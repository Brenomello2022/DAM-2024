import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_play_store_games/pages/homepage.dart';

class GpsService extends StatefulWidget {
  const GpsService({Key? key}) : super(key: key);

  @override
  _GpsServiceState createState() => _GpsServiceState();
}

class _GpsServiceState extends State<GpsService> {
  final _linhas = <String>[];
  StreamSubscription<Position>? _subscription;
  Position? _ultimaLocalizacaoObtida;
  double _distanciaPercorrida = 0;

  bool get _monitorarandoLocalizacao => _subscription != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usando GPS'),
        centerTitle: true,
      ),
      body: _criarBody(),
    );
  }

  Widget _criarBody() => Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        ElevatedButton(
          onPressed: _obterUltimaLocalizacaoConhecida,
          child: const Text('Obter ultima localização conhecida'),
        ),
        ElevatedButton(
          onPressed: _obterLocalizacaoAtual,
          child: const Text('Obter localização atual'),
        ),
        ElevatedButton(
          onPressed: _monitorarandoLocalizacao ? _pararMonitoramento : _monitorarLocalizacao,
          child: Text(_monitorarandoLocalizacao ? 'Parar monitoramento' : 'Monitorar localização'),
        ),
        ElevatedButton(
          onPressed: _limparLog,
          child: const Text('Limpar Log'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: const Text('Ir para a página inicial.'),
        ),
        const SizedBox(height: 16.0),
        const Divider(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _linhas.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(5),
              child: Text(_linhas[index]),
            ),
          ),
        ),
      ],
    ),
  );

  void _obterUltimaLocalizacaoConhecida() async {
    bool permissoesPermitidas = await _permissoesPermitidas();
    if (!permissoesPermitidas) {
      return;
    }
    Position? position = await Geolocator.getLastKnownPosition();
    setState(() {
      if (position == null) {
        _linhas.add('Nenhuma localização encontrada!');
      } else {
        _linhas.add('Latitude: ${position.latitude}  | Longetude: ${position.longitude}');
      }
    });
  }

  void _obterLocalizacaoAtual() async {
    bool servicoHabilitado = await _servicoHabilitado();
    if (!servicoHabilitado) {
      return;
    }

    bool permissoesPermitidas = await _permissoesPermitidas();
    if (!permissoesPermitidas) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      if (position == null) {
        _linhas.add('Nenhuma localização encontrada!');
      } else {
        _linhas.add('Latitude: ${position.latitude}  | Longetude: ${position.longitude}');
      }
    });
  }

  void _monitorarLocalizacao() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    _subscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      setState(() {
        if (position == null) {
          _linhas.add('Nenhuma localização encontrada!');
        } else {
          _linhas.add('Latitude: ${position.latitude}  | Longetude: ${position.longitude}');
        }
      });
      if (_ultimaLocalizacaoObtida != null) {
        final distancia = Geolocator.distanceBetween(
          _ultimaLocalizacaoObtida!.latitude,
          _ultimaLocalizacaoObtida!.longitude,
          position.latitude,
          position.longitude,
        );

        _distanciaPercorrida += distancia;

        _linhas.add('Distancia percorrida: ${_distanciaPercorrida.toInt()} Metros');
      }
      _ultimaLocalizacaoObtida = position;
    });
  }

  void _pararMonitoramento() {
    _subscription?.cancel();
    setState(() {
      _subscription = null;
      _distanciaPercorrida = 0;
      _ultimaLocalizacaoObtida = null;
    });
  }

  Future<bool> _permissoesPermitidas() async {
    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        _mostrarMensagem('Não será possível usar o recurso por falta de permissão');
        return false;
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      await _mostrarDialogMensagem(
        'Para utilizar esse recurso, você deverá acessar as configurações do app e permitir a utilização do serviço de localização',
      );
      Geolocator.openAppSettings();
      return false;
    }
    return true;
  }

  Future<bool> _servicoHabilitado() async {
    bool servicoHabilitado = await Geolocator.isLocationServiceEnabled();

    if (!servicoHabilitado) {
      await _mostrarDialogMensagem(
        'Para utilizar esse serviço, você deverá habilitar a localização deste dispositivo',
      );

      Geolocator.openLocationSettings();
      return false;
    }
    return true;
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensagem),
    ));
  }

  Future<void> _mostrarDialogMensagem(String mensagem) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Atenção'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _limparLog() {
    setState(() {
      _linhas.clear();
    });
  }
}
