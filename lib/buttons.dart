import 'package:flutter/material.dart';

// creating Stateless Wideget for buttons
class MyButton extends StatelessWidget {
  final text;
  final btnPresesed;
  MyButton(this.text, this.btnPresesed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.25,
      child: ClipRRect(
        //borderRadius: BorderRadius.all(Radius.circular(10)),
        child: OutlinedButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
              backgroundColor: text == '='
                  ? MaterialStateProperty.all(Colors.orange)
                  : (isFrontRow(text)
                      ? MaterialStateProperty.all(Colors.blue[50])
                      : (isOperator(text)
                          ? MaterialStateProperty.all(Colors.blue[500])
                          : MaterialStateProperty.all(Colors.white)))),
          onPressed: () {
            isnotOperatorNumber(text) ? btnPresesed() : btnPresesed(text);
          },
          child: Text(
            '$text',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  bool isFrontRow(String x) {
    if (x == 'C' || x == 'M' || x == '%' || x == 'DEL') {
      return true;
    }
    return false;
  }

  bool isnotOperatorNumber(String x) {
    if (x == 'C' || x == 'D' || x == '=' || x == 'M') {
      return true;
    }
    return false;
  }
}
