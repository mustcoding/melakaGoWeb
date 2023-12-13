import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/Model/quizQuestion.dart';
import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/Model/tourismServiceImage.dart';
import 'package:file_picker/file_picker.dart';

import '../../Model/appUser.dart';
import '../home/homePageView_Web_BSDC.dart';
import '../home/homePageView_Web_TAC.dart';


class quizForm extends StatefulWidget {
  late appUser user;

  quizForm({Key? key, required appUser user}) : super(key: key) {
    this.user = user;
  }


  @override
  State<quizForm> createState() => _quizFormState();
}

class _quizFormState extends State<quizForm> {


  TextEditingController questionTextController = TextEditingController();
  TextEditingController answerOption1Controller = TextEditingController();
  TextEditingController answerOption2Controller = TextEditingController();
  TextEditingController answerOption3Controller = TextEditingController();
  TextEditingController answerOption4Controller = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController qrIdController = TextEditingController();

  int isDelete = 0;
  String? types;
  final PageController _pageController = PageController();
  late FocusNode focusNode;
  Color borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        borderColor = focusNode.hasFocus ? Colors.red : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _addQuestion() async {
    final List<tourismService> service = [];
    final String questionText = questionTextController.text.trim();
    final String answerOption1 = answerOption1Controller.text.trim();
    final String answerOption2 = answerOption2Controller.text.trim();
    final String answerOption3 = answerOption3Controller.text.trim();
    final String answerOption4 = answerOption4Controller.text.trim();
    final String correctAnswer = correctAnswerController.text.trim();
    final int point = int.parse(pointController.text.trim());
    final int qrId = int.parse(qrIdController.text.trim());

    int questionId = 0;

    if (questionText.isNotEmpty && answerOption1.isNotEmpty &&
        answerOption2.isNotEmpty && answerOption3.isNotEmpty &&
        answerOption4.isNotEmpty && correctAnswer.isNotEmpty
        && correctAnswer.isNotEmpty && point != null && qrId != null) {
      quizQuestion question = quizQuestion(
          questionId,
          questionText,
          answerOption1,
          answerOption2,
          answerOption3,
          answerOption4,
          correctAnswer,
          point,
          qrId);

      if (await question.saveQuestion()) {
        _AlertMessage("Quiz Question Has Been Added");
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePageViewWebTAC(user: widget.user)),
            );
          });

          // Navigate to the login screen
        });
      }
      else {
        _AlertMessage("Registration Failed!!");
      }
    }
    else {
      _AlertMessage("Please Insert All The Information Needed");
      setState(() {
        questionTextController.clear();
        answerOption1Controller.clear();
        answerOption2Controller.clear();
        answerOption3Controller.clear();
        answerOption4Controller.clear();
        correctAnswerController.clear();
        pointController.clear();
        qrIdController.clear();
      });
    }
  }

  void _AlertMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Center(
          child: const Text(
            'Quiz Question',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:
          Container(
            margin: const EdgeInsets.all(20.0),
            width: 670,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildTextFieldContainer(
                    label: 'Question Text',
                    controller: questionTextController,
                  ),
                  buildTextFieldContainer(
                    label: 'Answer Option 1',
                    controller: answerOption1Controller,
                  ),
                  buildTextFieldContainer(
                    label: 'Answer Option 2',
                    controller: answerOption2Controller,
                  ),
                  buildTextFieldContainer(
                    label: 'Answer Option 3',
                    controller: answerOption3Controller,
                  ),
                  buildTextFieldContainer(
                    label: 'Answer Option 4',
                    controller: answerOption4Controller,
                  ),
                  buildTextFieldContainer(
                    label: 'Correct Answer',
                    controller: correctAnswerController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTextFieldContainer(
                        label: 'Point',
                        controller: pointController,
                      ),
                      buildTextFieldContainer(
                        label: 'QR ID',
                        controller: qrIdController,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _addQuestion,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen.shade700,
                    ),
                    child: const Text(
                      'Add Quiz Question',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }

  Widget buildTextFieldContainer({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  borderColor = hasFocus ? Colors.red : Colors.grey;
                });
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
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
