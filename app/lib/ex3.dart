import 'package:flutter/material.dart';

class CalculadoraDesconto extends StatefulWidget {
  const CalculadoraDesconto({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraDesconto> createState() => _CalculadoraDescontoState();
}

class Produto {
  final String nome;
  final double precoOriginal;
  final double desconto;
  final double precoFinal;

  Produto({
    required this.nome,
    required this.precoOriginal,
    required this.desconto,
    required this.precoFinal,
  });
}

class _CalculadoraDescontoState extends State<CalculadoraDesconto> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descontoController = TextEditingController();
  double? _precoFinal;
  String? _errorMessage;
  final List<Produto> _produtos = [];

  void _calcularDesconto() {
    final nome = _nomeController.text.trim();
    final preco = double.tryParse(_precoController.text);
    final desconto = double.tryParse(_descontoController.text);
    if (nome.isEmpty || preco == null || desconto == null) {
      setState(() {
        _precoFinal = null;
        _errorMessage = 'Preencha todos os campos corretamente.';
      });
      return;
    }
    setState(() {
      _precoFinal = preco - (preco * desconto / 100);
      _errorMessage = null;
    });
  }

  void _adicionarProduto() {
    final nome = _nomeController.text.trim();
    final preco = double.tryParse(_precoController.text);
    final desconto = double.tryParse(_descontoController.text);
    if (nome.isEmpty || preco == null || desconto == null) {
      setState(() {
        _errorMessage = 'Preencha todos os campos corretamente.';
      });
      return;
    }
    final precoFinal = preco - (preco * desconto / 100);
    setState(() {
      _produtos.add(
        Produto(
          nome: nome,
          precoOriginal: preco,
          desconto: desconto,
          precoFinal: precoFinal,
        ),
      );
      _nomeController.clear();
      _precoController.clear();
      _descontoController.clear();
      _precoFinal = null;
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descontoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preço Original',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => _calcularDesconto(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descontoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Desconto (%)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => _calcularDesconto(),
              ),
              const SizedBox(height: 16),
              if (_precoFinal != null)
                Text(
                  'Preço com desconto: R\$ ${_precoFinal!.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.red),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _adicionarProduto,
                child: const Text('Adicionar Produto à Lista'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Produtos Criados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._produtos.map(
                (produto) => Card(
                  child: ListTile(
                    title: Text(produto.nome),
                    subtitle: Text(
                      'Original: R\$ ${produto.precoOriginal.toStringAsFixed(2)} | Desconto: ${produto.desconto.toStringAsFixed(2)}%',
                    ),
                    trailing: Text(
                      'R\$ ${produto.precoFinal.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
