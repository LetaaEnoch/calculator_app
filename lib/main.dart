// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

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
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() {
    return _CalculatorHomeState();
  }
}

class _CalculatorHomeState extends State<CalculatorHome> {
  List<String> input = [];
  String result = '';
  GrammarParser p = GrammarParser();

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        onButtonPressed(value);
      },
      child: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
    );
  }

  void onButtonPressed(String val) {
    setState(() {
      if (val == 'C') {
        input = [];
        result = '';
      } else if (val == '=') {
        Expression exp = p.parse(input.join());
        ContextModel cm = ContextModel();
        double x = exp.evaluate(EvaluationType.REAL, cm);
        result = x.toString();
        input = [];
      } else if (val == 'M') {
        for (int i = 0; i < 3; i++) {
          input.add('0');
        }
      } else if (val == '×') {
        input.add('*');
      } else if (val == '÷') {
        input.add('/');
      } else if (val == '←') {
        input.removeLast();
      } else {
        input.add(val);
      }
    });
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //SizedBox(height: 20),
            Text(input.join(), style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                buildButton('%'),
                buildButton('M'),
                buildButton('C'),
                buildButton('←'),
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('÷'),
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('×'),
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('-'),
                buildButton('.'),
                buildButton('0'),
                buildButton('+'),
                buildButton('='),
                //SizedBox(height: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
