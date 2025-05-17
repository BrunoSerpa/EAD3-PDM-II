import 'dart:math';
import 'package:flutter/material.dart';

class JogoAdivinhacao extends StatefulWidget {
  const JogoAdivinhacao({super.key, required this.title});

  final String title;

  @override
  State<JogoAdivinhacao> createState() => _JogoAdivinhacaoState();
}

class _JogoAdivinhacaoState extends State<JogoAdivinhacao> {
  final TextEditingController _palpiteController = TextEditingController();
  int? _numeroSecreto;
  int _tentativas = 0;
  String? _mensagem;
  bool _jogoFinalizado = false;

  void _iniciarJogo() {
    setState(() {
      _numeroSecreto = Random().nextInt(10) + 1;
      _tentativas = 0;
      _mensagem = null;
      _jogoFinalizado = false;
      _palpiteController.clear();
    });
  }

  void _verificarPalpite() {
    if (_jogoFinalizado) return;
    final palpite = int.tryParse(_palpiteController.text);
    if (palpite == null || palpite < 1 || palpite > 10) {
      setState(() {
        _mensagem = 'Digite um número entre 1 e 10.';
      });
      return;
    }
    setState(() {
      _tentativas++;
      if (palpite == _numeroSecreto) {
        _mensagem = 'Parabéns! Você acertou em $_tentativas tentativa(s)!';
        _jogoFinalizado = true;
      } else if (palpite < _numeroSecreto!) {
        _mensagem = 'Muito baixo! Tente novamente.';
      } else {
        _mensagem = 'Muito alto! Tente novamente.';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _iniciarJogo();
  }

  @override
  void dispose() {
    _palpiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Novo Jogo',
            onPressed: _iniciarJogo,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tente adivinhar o número entre 1 e 10!',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _palpiteController,
                keyboardType: TextInputType.number,
                enabled: !_jogoFinalizado,
                decoration: const InputDecoration(
                  labelText: 'Seu palpite',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _verificarPalpite(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _jogoFinalizado ? null : _verificarPalpite,
                child: const Text('Verificar'),
              ),
              const SizedBox(height: 16),
              if (_mensagem != null)
                Text(
                  _mensagem!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: _jogoFinalizado ? Colors.green : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              if (_jogoFinalizado)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: _iniciarJogo,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Novo Jogo'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
