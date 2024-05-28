import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  String history = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      history = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        if (num2 != 0) {
          _output = (num1 / num2).toString();
        } else {
          _output = "Error";
        }
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "sin") {
      _output = sin(double.parse(output) * (pi / 180)).toString();
    } else if (buttonText == "cos") {
      _output = cos(double.parse(output) * (pi / 180)).toString();
    } else if (buttonText == "tan") {
      _output = tan(double.parse(output) * (pi / 180)).toString();
    } else if (buttonText == "√") {
      _output = sqrt(double.parse(output)).toString();
    } else if (buttonText == "log") {
      _output = log(double.parse(output)).toString();
    } else if (buttonText == "ln") {
      _output = (log(double.parse(output)) / log(e)).toString();
    } else if (buttonText == "^") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "^2") {
      _output = (double.parse(output) * double.parse(output)).toString();
    } else if (buttonText.endsWith(" to ")) {
      operand = buttonText;
    } else if (buttonText == "Convert") {
      if (operand.isEmpty) {
        return;
      }
      double value = double.parse(output);
      switch (operand) {
        case "m to cm":
          _output = (value * 100).toString();
          break;
        case "cm to m":
          _output = (value / 100).toString();
          break;
        case "kg to g":
          _output = (value * 1000).toString();
          break;
        case "g to kg":
          _output = (value / 1000).toString();
          break;
        case "°C to °F":
          _output = ((value * 9 / 5) + 32).toString();
          break;
        case "°F to °C":
          _output = ((value - 32) * 5 / 9).toString();
          break;
        default:
          return;
      }
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
      history += "$buttonText ";
    });
  }

  Widget buildButton(String buttonText, {Color color = Colors.white70}) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(24.0),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        ),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Scientific Calculator",
          style: TextStyle(color: Colors.lightBlue),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 65,
              horizontal: 30,
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
                fontSize: 40.0,
              ),
            ),
          ),
          const Expanded(child: Divider()),
          Column(children: [
            Row(children: <Widget>[
              buildButton("sin"),
              buildButton("cos"),
              buildButton("tan"),
              buildButton("√"),
            ]),
            Row(children: <Widget>[
              buildButton("log"),
              buildButton("ln"),
              buildButton("^2"),
              buildButton("÷"),
            ]),
            Row(children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("×", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("-", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("+", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("."),
              buildButton("0"),
              buildButton("00"),
              buildButton("="),
            ]),
            Row(children: <Widget>[
              buildButton("CLEAR", color: Colors.red),
              buildButton("Convert", color: Colors.green),
            ]),
            Row(children: <Widget>[
              buildButton("m to cm"),
              buildButton("cm to m"),
              buildButton("kg to g"),
              buildButton("g to kg"),
            ]),
            Row(children: <Widget>[
              buildButton("°C to °F"),
              buildButton("°F to °C"),
              buildButton(""),
              buildButton("", color: Colors.green),
            ]),
          ]),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  history,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: CalculatorScreen(),
));
