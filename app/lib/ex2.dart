import 'package:flutter/material.dart';

class CalculadoraMedia extends StatefulWidget {
  const CalculadoraMedia({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraMedia> createState() => _CalculadoraMediaState();
}

class _CalculadoraMediaState extends State<CalculadoraMedia> {
  final TextEditingController _nota1Controller = TextEditingController();
  final TextEditingController _nota2Controller = TextEditingController();
  final TextEditingController _nota3Controller = TextEditingController();
  double? _media;
  String? _errorMessage;

  void _onTextChanged() {
    final n1 = double.tryParse(_nota1Controller.text);
    final n2 = double.tryParse(_nota2Controller.text);
    final n3 = double.tryParse(_nota3Controller.text);
    if (_nota1Controller.text.isEmpty &&
        _nota2Controller.text.isEmpty &&
        _nota3Controller.text.isEmpty) {
      setState(() {
        _media = null;
        _errorMessage = null;
      });
      return;
    }
    if (n1 == null || n2 == null || n3 == null) {
      setState(() {
        _media = null;
        _errorMessage = 'Por favor, insira valores numéricos válidos.';
      });
      return;
    }
    setState(() {
      _media = (n1 + n2 + n3) / 3;
      _errorMessage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _nota1Controller.addListener(_onTextChanged);
    _nota2Controller.addListener(_onTextChanged);
    _nota3Controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _nota1Controller.dispose();
    _nota2Controller.dispose();
    _nota3Controller.dispose();
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
                controller: _nota1Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nota2Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota 2',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nota3Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota 3',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              if (_media != null)
                Text(
                  'Média: ${_media!.toStringAsFixed(2)}',
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
