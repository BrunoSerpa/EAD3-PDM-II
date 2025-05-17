import 'package:flutter/material.dart';
import 'ex1.dart';
import 'ex2.dart';
import 'ex3.dart';
import 'ex4.dart';
import 'ex5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Exercícios 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ExerciciosHome(),
    );
  }
}

class ExerciciosHome extends StatelessWidget {
  const ExerciciosHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Exercícios')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _ExercicioButton(
              title: 'Conversor de Temperatura',
              image:
                  'https://images.icon-icons.com/3291/PNG/512/thermometer_digital_medical_health_icon_208436.png',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const ConversorTemperatura(
                            title: 'Conversor de Temperatura',
                          ),
                    ),
                  ),
            ),
            _ExercicioButton(
              title: 'Calculadora de Média',
              image: 'https://cdn-icons-png.flaticon.com/512/5331/5331567.png',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const CalculadoraMedia(
                            title: 'Calculadora de Média Aritmética',
                          ),
                    ),
                  ),
            ),
            _ExercicioButton(
              title: 'Calculadora de Desconto',
              image: 'https://cdn-icons-png.flaticon.com/512/879/879757.png',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const CalculadoraDesconto(
                            title: 'Calculadora de Desconto',
                          ),
                    ),
                  ),
            ),
            _ExercicioButton(
              title: 'Jogo de Adivinhação',
              image: 'https://cdn-icons-png.flaticon.com/512/96/96394.png',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const JogoAdivinhacao(
                            title: 'Jogo de Adivinhação',
                          ),
                    ),
                  ),
            ),
            _ExercicioButton(
              title: 'Área do Retângulo',
              image: 'https://cdn-icons-png.flaticon.com/512/5853/5853855.png',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const CalculadoraAreaRetangulo(
                            title: 'Calculadora de Área de Retângulo',
                          ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExercicioButton extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const _ExercicioButton({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  _ExercicioButtonState createState() => _ExercicioButtonState();
}

class _ExercicioButtonState extends State<_ExercicioButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  Color get _backgroundColor {
    if (_isPressed) {
      return Colors.grey[500]!;
    } else if (_isHovered) {
      return Colors.grey[300]!;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit:
          (_) => setState(() {
            _isHovered = false;
            _isPressed = false;
          }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.image, width: 50, fit: BoxFit.contain),
              const SizedBox(height: 12),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
