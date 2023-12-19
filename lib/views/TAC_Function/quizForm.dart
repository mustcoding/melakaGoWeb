import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/Model/quizQuestion.dart';
import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/Model/tourismServiceImage.dart';
import 'package:file_picker/file_picker.dart';

import '../../Model/appUser.dart';
import '../../Model/qrId.dart';
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

class _quizFormState extends State<quizForm>{


  TextEditingController questionTextController = TextEditingController();
  TextEditingController answerOption1Controller = TextEditingController();
  TextEditingController answerOption2Controller = TextEditingController();
  TextEditingController answerOption3Controller = TextEditingController();
  TextEditingController answerOption4Controller = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController qrIdController = TextEditingController();
  TextEditingController tourismServiceController = TextEditingController();

  late Future<List<String>> tServicesFuture;
  String? selectedTourism;
  int ? selectedqrId;
  int isDelete=0;
  String? types;
  final PageController _pageController = PageController();
  List<tourismService> service=[];
  List<qrSpot> qrArea=[];
  List<String> tServices = [];
  int tourismServiceQuiz=0;
  List<int> qrUnder20=[];


  @override
  void initState() {
    tServicesFuture = getService();
    super.initState();
  }

  Future<List<String>> getService() async{

    int tourismServiceId=0;
    String companyName='';
    String companyAddress='';
    String businessContactNumber='';
    String email='';
    String businessStartHour='';
    String businessEndHour='';
    String faxNumber='';
    String instagram='';
    String xTwitter='';
    String thread='';
    String facebook='';
    String businessLocation='';
    int starRating=0;
    String businessDescription='';
    int tsId=0;


    tourismService services = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> tourismServices = await services.loadAll();

    print("List of tourismService: ${tourismServices}");
    // Alternatively, you can use a for-in loop:
    for (int i=0; i<tourismServices.length ; i++){
      tServices.add(tourismServices[i].companyName ?? '');
    }

    return tServices;
  }


  void _addQuestion() async{

    final String questionText = questionTextController.text.trim();
    final String answerOption1 = answerOption1Controller.text.trim();
    final String answerOption2= answerOption2Controller.text.trim();
    final String answerOption3 = answerOption3Controller.text.trim();
    final String answerOption4 = answerOption4Controller.text.trim();
    final String correctAnswer = correctAnswerController.text.trim();
    final int point = int.parse(pointController.text.trim());
    final int qrId = int.parse(qrIdController.text.trim());

    int questionId=0;

    if (questionText.isNotEmpty && answerOption1.isNotEmpty &&
        answerOption2.isNotEmpty && answerOption3.isNotEmpty &&
        answerOption4.isNotEmpty && correctAnswer.isNotEmpty
        && correctAnswer.isNotEmpty && point != null && qrId != null) {


      quizQuestion question = quizQuestion (questionId,questionText,answerOption1,
          answerOption2,answerOption3,answerOption4,correctAnswer,point,qrId);

      if (await question.saveQuestion()){

        _AlertMessage("Quiz Question Has Been Added");
        Future.delayed(Duration(seconds: 1), () {

          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageViewWebTAC(user: widget.user)),
            );
          });

          // Navigate to the login screen
        });

      }
      else{
        _AlertMessage("Registration Failed!!");
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
        qrIdController.clear();
      });
    }
  }

  void _checkQRId() async{
    final String? companyName = selectedTourism;
    print("Selected Country : ${companyName}");

    //get tourismServiceId by company name
    tourismService service = tourismService.getIdQuiz (companyName);

    //get tourismServiceId
    if (await service.getServiceIdQuiz()){
      //assign the tourismServiceId to tourismServiceQuiz
      tourismServiceQuiz = service.tourismServiceId!;
      print("Tourism Service ID : ${tourismServiceQuiz}");

      //get qrId by passing the parameter tourismServiceQuiz(ID)
     qrSpot qr = qrSpot.getId(tourismServiceQuiz);

     //load the data
      // eg: raw response:[{"qrId":19,"qrImages":null,"tourismServiceId":2},
      // {"qrId":20,"qrImages":null,"tourismServiceId":2},
      // {"qrId":21,"qrImages":null,"tourismServiceId":2}]
      List<qrSpot> loadedQr = await qr.loadQRSpot();

      //if the data exist in loadedQr
      if (loadedQr.isNotEmpty) {

        setState(() {
          qrArea.clear();
          qrArea.addAll(loadedQr);
        });

        qrUnder20.clear();

        for (int i=0 ; i<qrArea.length ; i++){

          //instance by parsing qrId to count the number of question
          //referring to the qrId
          quizQuestion quiz = quizQuestion.Id(qrArea[i].qrId);

          //calculate the quiz question by qrId
          int quizNumber = await quiz.calculateQuizByQR();

          print("Quiz number at qrID ${qrArea[i].qrId}: ${quizNumber}");

          //only save the qrId that having less than 20 question in qrUnder20
          if (quizNumber<20 )
          {
            qrUnder20.add(qrArea[i].qrId!);
            print("UNDER 20 QUIZ: ${qrUnder20[i]}");
          }

        }

        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            // Update the dropdown menu items with the new values
            selectedqrId = null;

          });
        });

      }
      else if(loadedQr.isEmpty) //if data doesn't in the loadedQr
      {

        int qrId=0;

        //instances to create new qrSpot
        qrSpot addQr = qrSpot(qrId, tourismServiceQuiz);

        //add new qrSpot
        if(await addQr.saveQR()){

          print("Successful registered");


          

        }

        qrUnder20.clear();
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            // Update the dropdown menu items with the new values
            selectedqrId = null;

          });
        });
      }
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

  void _showMessage(String msg){
    if(mounted){
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
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                width: 670,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<List<String>>(
                            future: tServicesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error loading data: ${snapshot.error}');
                              } else {
                                tServices = snapshot.data ?? [];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                                  children: [
                                    Text(
                                      'Company Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: selectedTourism,
                                        hint: Text('Select Company Name'),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTourism = value;
                                          });
                                        },
                                        isExpanded: true,
                                        items: tServices.map((String service) {
                                          return DropdownMenuItem<String>(
                                            value: service,
                                            child: Text(service),
                                          );
                                        }).toList(),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20), // Add some spacing
                          Container(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                                children: [
                                  Text(
                                    'QR ID',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: DropdownButtonFormField<int>(
                                      value: selectedqrId,
                                      hint: Text('QR ID'),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedqrId = value;
                                          qrIdController.text = value?.toString() ?? '';
                                        });
                                      },
                                      isExpanded: true,
                                      items: qrUnder20.map((int qrid) {
                                        return DropdownMenuItem<int>(
                                          value: qrid,
                                          child: Text(qrid.toString()),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
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
                      SizedBox(height:6),
                      ElevatedButton(
                        onPressed: _checkQRId,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen.shade700,
                        ),
                        child: const Text(
                          'Check QR ID',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                            width: 300.0,
                          ),
                          buildTextFieldContainer(
                            label: 'QR ID',
                            controller: qrIdController,
                            width: 300.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldContainer({
    required String label,
    required TextEditingController controller,
    double width = 600.0,
  }) {
    return Container(
      width: width,
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
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
