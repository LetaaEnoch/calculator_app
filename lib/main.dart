import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      home: CalculatorHome(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() {
    return _CalculatorHomeState();
  }
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String input = '';
  String result = '';

  Widget buildButton(String value) {
    return ElevatedButton(onPressed: () {}, child: Text(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //SizedBox(height: 20),
          Text(input, style: TextStyle(fontSize: 30)),
          Text(
            result,
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          //SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('÷'),
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('x'),
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('-'),
                  buildButton('.'),
                  buildButton('0'),
                  buildButton('+'),
                  buildButton('='),
                  //SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
