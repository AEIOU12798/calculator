import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ReadOnly1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalculatorScreen();
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller = TextEditingController();
  String answer = '';
  String userInput = '';
  late double w = MediaQuery.of(context).size.width;
  late double h = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    // Retrieve the width and height

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          // backgroundColor: Colors.black,
          title: Container(
            // margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'Calculator',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: _controller,
                readOnly: true,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xff2F4F4F))),
                ),
              ),
            ),
            // SizedBox(height: 8.0),
            Container(
              height: h * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color(0xff696969),
                ),
              ),
              margin: EdgeInsets.only(top: 15.0),
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 30.0,
                    // color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.06),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                children: [
                  _buildButton('C',
                      btncolor: Colors.deepPurple,
                      txtcolor: Colors.white,
                      isClear: true),
                  _buildButton('<',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                  _buildButton('%',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                  _buildButton('÷',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                  _buildButton('7', txtcolor: Colors.black),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('×',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                  _buildButton(
                    '4',
                  ),
                  _buildButton(
                    '5',
                  ),
                  _buildButton(
                    '6',
                  ),
                  _buildButton('-',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                  _buildButton(
                    '1',
                  ),
                  _buildButton(
                    '2',
                  ),
                  _buildButton(
                    '3',
                  ),
                  _buildButton('+',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                  _buildButton(
                    '00',
                  ),
                  _buildButton(
                    '0',
                  ),
                  _buildButton(
                    '.',
                  ),
                  _buildButton('=',
                      btncolor: Colors.deepPurple, txtcolor: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Wigdet Type function for buttons

  Widget _buildButton(String txt,
      {Color? btncolor, Color? txtcolor, bool isClear = false}) {
    return Container(
      margin: EdgeInsets.all(w * 0.02),
      height: h * 0.07,
      width: w * 0.20,
      child: ElevatedButton(
        onPressed: () {
          if (txt == 'C') {
            _controller.clear();
            setState(() {
              answer = '';
            });
          } else if (txt == "<") {
            if (_controller.text.isNotEmpty) {}
            _controller.text =
                _controller.text.substring(0, _controller.text.length - 1);
          } else if (txt == '=') {
            if (_controller.text.isNotEmpty) {
              userInput = _controller.text;
              userInput = userInput.replaceAll('×', '*');
              userInput = userInput.replaceAll('÷', '/');
              try {
                Parser p = Parser();
                Expression expression = p.parse(userInput);
                ContextModel cm = ContextModel();
                double eval = expression.evaluate(EvaluationType.REAL, cm);
                setState(() {
                  answer = eval.toString();
                  // if(answer.endsWith(".0")){
                  //   answer=answer.substring(0,answer.length -2);
                  // }
                });
              } catch (e) {
                setState(() {
                  answer = 'Error';
                });
              }
            }
          } else {
            setState(() {
              _controller.text += txt;
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(btncolor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
        ),
        child: Text(
          txt,
          style: TextStyle(
            color: txtcolor,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
