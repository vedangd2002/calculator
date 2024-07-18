import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorAppHome(),
    );
  }
}

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  String equation = '0';
  String result = '0';
  String expression = '';

  buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == '⌫') {
        equation = equation.length > 1
            ? equation.substring(0, equation.length - 1)
            : '0';
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget calButtons(
      String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPressed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btnText,
          style: TextStyle(
              color: txtColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(200, 100)),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'My Calculator',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              height: 80,
              width: double.infinity,
              color: Colors.grey,
              child: Text(
                equation,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 50),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              height: 90,
              width: double.infinity,
              color: Colors.grey,
              child: Text(
                result,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons(
                            'AC', Colors.black, 80, Colors.blueGrey[100]!),
                        calButtons('⌫', Colors.black, 80, Colors.white38),
                        calButtons('%', Colors.black, 80, Colors.white38),
                        calButtons(
                            '÷', Colors.black, 80, Colors.blueGrey[100]!),
                      ]),
                  const SizedBox(height: 25),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons(
                            '7', Colors.black, 80, Colors.blueGrey[100]!),
                        calButtons('8', Colors.black, 80, Colors.white38),
                        calButtons('9', Colors.black, 80, Colors.white38),
                        calButtons(
                            'x', Colors.black, 80, Colors.blueGrey[100]!),
                      ]),
                  const SizedBox(height: 25),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons(
                            '4', Colors.black, 80, Colors.blueGrey[100]!),
                        calButtons('5', Colors.black, 80, Colors.white38),
                        calButtons('6', Colors.black, 80, Colors.white38),
                        calButtons(
                            '-', Colors.black, 80, Colors.blueGrey[100]!),
                      ]),
                  const SizedBox(height: 25),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons(
                            '1', Colors.black, 80, Colors.blueGrey[100]!),
                        calButtons('2', Colors.black, 80, Colors.white38),
                        calButtons('3', Colors.black, 80, Colors.white38),
                        calButtons(
                            '+', Colors.black, 80, Colors.blueGrey[100]!),
                      ]),
                  const SizedBox(height: 25),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons(
                            '0', Colors.black, 170, Colors.blueGrey[100]!),
                        calButtons('.', Colors.black, 80, Colors.white38),
                        calButtons('=', Colors.black, 80, Colors.white38),
                      ]),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
