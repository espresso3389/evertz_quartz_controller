import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evertz Quartz Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const int _numBlocks = 16;
const int _totalBlocks = _numBlocks + 2;
const int _numBlocksV = 64;
const int _totalBlocksV = _numBlocksV + 2;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Evertz Quartz Test'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: CustomPaint(
            painter: CrossbarPainter(),
            child: SizedBox(
              width: _numBlocks * 50 + 50,
              height: _numBlocksV * 50 + 50,
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _totalBlocks),
                itemCount: _totalBlocks * _totalBlocksV,
                itemBuilder: (context, index) {
                  final y = index ~/ _totalBlocks - 1;
                  final x = index % _totalBlocks - 1;
                  if (y == -1 || y == _numBlocksV) {
                    if (x == -1 || x == _numBlocks) {
                      return Container(
                        width: 50,
                        height: 50,
                      );
                    }
                    return Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '$x',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (x == -1 || x == _numBlocks) {
                    return Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '$y',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return crossPoint(context, x, y);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget crossPoint(BuildContext context, int x, int y) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.green,
      width: 50,
      height: 50,
    );
  }
}

class CrossbarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 64; i++) {
      final y = (i + 1) * 50.0;
      canvas.drawLine(
        Offset(50, y),
        Offset(_numBlocks * 50, y),
        Paint()..color = Colors.black,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
