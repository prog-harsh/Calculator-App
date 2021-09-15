import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '0';
  var answer = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: 40, right: 20, left: 10),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics().parent,
                      scrollDirection: Axis.horizontal,
                      child: Text(userInput,
                          style:
                              TextStyle(fontSize: 23, color: Colors.black87)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(answer,
                          style:
                              TextStyle(fontSize: 30, color: Colors.black54))),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      MyButton('C', clearButton),
                      MyButton('M', () {}),
                      MyButton('%', addUserInput),
                      MyButton('DEL', delPressed),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton('7', addUserInput),
                      MyButton('8', addUserInput),
                      MyButton('9', addUserInput),
                      MyButton('/', addUserInput),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton('4', addUserInput),
                      MyButton('5', addUserInput),
                      MyButton('6', addUserInput),
                      MyButton('x', addUserInput),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton('1', addUserInput),
                      MyButton('2', addUserInput),
                      MyButton('3', addUserInput),
                      MyButton('-', addUserInput),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton('0', addUserInput),
                      MyButton('.', addUserInput),
                      MyButton('=', equalPressed),
                      MyButton('+', addUserInput),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// function to calculate the input operation
  void equalPressed() {
    if (isOperator(userInput.substring(0, 1))) {
      setState(() {
        answer = 'Error';
      });
      return;
    }
    if (isOperator(
        userInput.substring(userInput.length - 1, userInput.length))) {
      setState(() {
        answer = 'Error';
      });
      return;
    }

    try {
      String finaluserinput = userInput;

      finaluserinput = userInput.replaceAll('x', '*');

      Parser p = Parser();
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        answer = eval.toString();
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  void addUserInput(String text) {
    setState(() {
      if (userInput == '0') {
        userInput = '';
      }
      userInput += text;
    });
  }

  void clearButton() {
    setState(() {
      userInput = '0';
      answer = '0';
    });
  }

  bool isOperator(String x) {
    if (x == '/' || x == '*' || x == '%') {
      return true;
    }
    return false;
  }

  void delPressed() {
    setState(() {
      if (userInput.length == 1) {
        userInput = '0';
        return;
      }
      userInput = userInput.substring(0, userInput.length - 1);
    });
  }
}
