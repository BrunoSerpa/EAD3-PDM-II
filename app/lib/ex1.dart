import 'package:flutter/material.dart';

class ConversorTemperatura extends StatefulWidget {
  const ConversorTemperatura({super.key, required this.title});

  final String title;

  @override
  State<ConversorTemperatura> createState() => _ConversorTemperaturaState();
}

class _ConversorTemperaturaState extends State<ConversorTemperatura> {
  final TextEditingController _celsiusController = TextEditingController();
  double? _fahrenheit;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _celsiusController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final input = _celsiusController.text;
    if (input.isEmpty) {
      setState(() {
        _fahrenheit = null;
        _errorMessage = null;
      });
      return;
    }
    final celsius = double.tryParse(input);
    if (celsius != null) {
      setState(() {
        _fahrenheit = (celsius * 9 / 5) + 32;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _fahrenheit = null;
        _errorMessage = 'Por favor, insira um valor numérico válido.';
      });
    }
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
                controller: _celsiusController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Temperatura em Celsius',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              if (_fahrenheit != null)
                Text(
                  'Temperatura em Fahrenheit: ${_fahrenheit!.toStringAsFixed(2)}°F',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _celsiusController.dispose();
    super.dispose();
  }
}