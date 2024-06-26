import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {

  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedSortBy = '';
  String selectedCategory = '';

  final List<String> sortByOptions = [
    '',
    'AlfabéticaAscendente',
    'AlfabéticaDescendente',
    'AvaliaçãoCrescente',
    'AvaliaçãoDecrescente',
    'PreçoCrescente',
    'PreçoDecrescente',
  ];
  final List<String> categoryOptions = ['', 'Ação', 'Aventura', 'Terror'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Jogos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedSortBy,
              items: sortByOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option.isEmpty ? 'Ordenar Por' : option),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSortBy = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Ordenar Por:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categoryOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option.isEmpty ? 'Categoria' : option),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Categoria:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  applyFilters();
                },
                child: Text('Aplicar Filtros'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void applyFilters() {
    Navigator.pop(context, {'sortBy': selectedSortBy, 'category': selectedCategory});
  }
}
