import 'package:flutter/material.dart';

class CalculadoraAreaRetangulo extends StatefulWidget {
  const CalculadoraAreaRetangulo({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraAreaRetangulo> createState() =>
      _CalculadoraAreaRetanguloState();
}

class _CalculadoraAreaRetanguloState extends State<CalculadoraAreaRetangulo> {
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double? _area;
  String? _errorMessage;

  void _onTextChanged() {
    final largura = double.tryParse(_larguraController.text);
    final altura = double.tryParse(_alturaController.text);
    if (_larguraController.text.isEmpty && _alturaController.text.isEmpty) {
      setState(() {
        _area = null;
        _errorMessage = null;
      });
      return;
    }
    if (largura == null || altura == null) {
      setState(() {
        _area = null;
        _errorMessage = 'Por favor, insira valores numéricos válidos.';
      });
      return;
    }
    setState(() {
      _area = largura * altura;
      _errorMessage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _larguraController.addListener(_onTextChanged);
    _alturaController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _larguraController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _larguraController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Largura',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              if (_area != null)
                Text(
                  'Área: ${_area!.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
