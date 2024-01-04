import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/Model/tourismServiceImage.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:melakago_web/views/BSDC_Function/showServices.dart';
import 'package:melakago_web/views/TAC_Function/showQuiz.dart';

import '../../Model/appUser.dart';
import '../../Model/quizQuestion.dart';


class editQuizQuestion extends StatefulWidget {

  final List<quizQuestion>? quizes;
  final int ? index;
  final appUser user;

  editQuizQuestion({required int? index, required List<quizQuestion>? quizes, required this.user})
      : index = index,
        quizes = quizes;

  @override
  State<editQuizQuestion> createState() => _editQuizQuestionsState(index!, quizes!, user);
}

class _editQuizQuestionsState extends State<editQuizQuestion> {

  final int ? index;
  final List<quizQuestion>? quizes;
  String base64String='';
  String images='';
  String getImages='';
  int btypes=0;
  int? questionId=0;
  int? point=0;
  int? qrId=0;
  Uint8List? gambar;
  int isDelete=0;

  _editQuizQuestionsState(this.index, this.quizes, appUser user);

  late TextEditingController questionIdController;
  late TextEditingController questionTextController;
  late TextEditingController answerOption1Controller;
  late TextEditingController answerOption2Controller;
  late TextEditingController answerOption3Controller;
  late TextEditingController answerOption4Controller;
  late TextEditingController correctAnswerController;
  late TextEditingController pointController;
  late TextEditingController qrIdController;
  late TextEditingController isDeleteController;


  @override
  void initState() {
    super.initState();
    questionTextController = TextEditingController(text: quizes![index!].questionText);
    answerOption1Controller = TextEditingController(text: quizes![index!].answerOption1);
    answerOption2Controller = TextEditingController(text: quizes![index!].answerOption2);
    answerOption3Controller = TextEditingController(text: quizes![index!].answerOption3);
    answerOption4Controller = TextEditingController(text: quizes![index!].answerOption4);
    correctAnswerController = TextEditingController(text: quizes![index!].correctAnswer);
    pointController = TextEditingController(text: quizes![index!].point.toString());
    qrIdController = TextEditingController(text: quizes![index!].qrId.toString());



    questionId = quizes![index!].questionId;
    point = quizes![index!].point;
    qrId = quizes![index!].qrId;


  }


  String? types;
  final PageController _pageController = PageController();


  List<String> servicesType = [
    'Shopping',
    'Transport',
    'Lodging',
    'Restaurant',
    'Activity',
    'Tourist Spot',
  ];

  void _editServices() async{
    final List<tourismService> service= [];
    final String questionText = questionTextController.text.trim();
    final String answerOption1 = answerOption1Controller.text.trim();
    final String answerOption2= answerOption2Controller.text.trim();
    final String answerOption3 = answerOption3Controller.text.trim();
    final String answerOption4 = answerOption4Controller.text.trim();
    final String correctAnswer = correctAnswerController.text.trim();
    final int point = int.parse(pointController.text.trim()) ;



    if (questionText.isNotEmpty && answerOption1.isNotEmpty &&
        answerOption2.isNotEmpty && answerOption3.isNotEmpty &&
        answerOption4.isNotEmpty && correctAnswer.isNotEmpty
        && point != null ) {

      quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
          answerOption2, answerOption3, answerOption4, correctAnswer,
          point, qrId, isDelete);


      if (await quiz.updateQuiz()){
        _AlertMessage("Tourism Service Has Been Updated");
        Future.delayed(Duration(seconds: 1), () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => showQuizQuestion(user:widget.user)),
          );
        });
      }
      else{
        _AlertMessage("Update Failed!!");
      }
    }
    else{
      _AlertMessage("Please Insert All The Information Needed");
      setState(() {
        questionTextController.clear();
        answerOption1Controller.clear();
        answerOption2Controller.clear();
        answerOption3Controller.clear();
        answerOption4Controller.clear();
        correctAnswerController.clear();
        pointController.clear();
    // Set selectedCountry to null
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
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:90,
        title: Center(child: const Text('Update Tourism Service',
            style: TextStyle(fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(height: 80),
              SizedBox(height: 30),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question Text', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: questionTextController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Answer Option 1', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: answerOption1Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Answer Option 2', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: answerOption2Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Answer Option 3', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: answerOption3Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Answer Option 4', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: answerOption4Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correct Answer', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: correctAnswerController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.0, // Set the width to the desired value
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Point', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: pointController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'QR SPOT', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0), // Add some space between the label and the text field
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: qrIdController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: _editServices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade700, // Set your desired background color here
                ),
                child: const Text('Update',
                    style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
