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
  //This is the shell class for the home page
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() {
    return _CalculatorHomeState();
  }
}

class _CalculatorHomeState extends State<CalculatorHome> {
  //This is the class that actually defines the state of the home page

  //Below is a list of relevant variables
  List<String> input = [];
  String result = '';
  GrammarParser p = GrammarParser();

  Widget buildButton(String value) {
    //This function returns a widget, an ElevatedButton. It is gonna be called inside
    //each button in the GridView.

    return ElevatedButton(
      onPressed: () {
        //onButtonPressed is a crucial function we define hereafter
        onButtonPressed(value);
      },
      child: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
    );
  }

  void onButtonPressed(String val) {
    //This function is the core of the app functionality. It detects the button that has
    //been pressed, and thereafter determines the course of action that should follow
    //e.g numbers or operator symbols pressed should be added to the input string, while
    //the '=' sign when pressed trigger evaluation of the input expression.
    setState(() {
      if (val == 'C') {
        //clear the input and result
        input = [];
        result = '';
      } else if (val == '=') {
        try {
          //high possibility of error here, from user input.
          //Run cautiously with exception handling.
          Expression exp = p.parse(input.join());
          ContextModel cm = ContextModel();
          double x = exp.evaluate(EvaluationType.REAL, cm);
          result = x.toString();
          input = [];
        } catch (e) {
          result = 'Syntax Error';
          input = [];
        }
      } else if (val == 'M') {
        //'M' in this case means '000
        for (int i = 0; i < 3; i++) {
          //Use a for-loop because we want each 0 to be added individually rather than
          //three zeros at once (000). When the user presses the delete button (←),
          //all three zeros are deleted at once if they were entered at once as a string.
          input.add('0');
        }
      } else if (val == '×') {
        input.add('*');
      } else if (val == '÷') {
        input.add('/');
      } else if (val == '%') {
        input.add('/100');
      } else if (val == '←') {
        try {
          input.removeLast();
        } catch (e) {
          result = 'Invalid input';
        }
      } else {
        //If any other character is pressed (in this case, numbers).
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
              crossAxisCount: 4, //max 4 widgets in a row
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
