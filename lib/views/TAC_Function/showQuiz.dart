import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/views/TAC_Function/editQuiz.dart';
import 'package:melakago_web/views/home/homePageView_Web_BSDC.dart';
import '../../Model/appUser.dart';
import '../../Model/quizQuestion.dart';
import '../../Model/tourismService.dart';

class showQuizQuestion extends StatefulWidget {

  late final appUser user;
  showQuizQuestion({required this.user});

  @override
  State<showQuizQuestion> createState() => _showQuizQuestionState();
}

class _showQuizQuestionState extends State<showQuizQuestion> {

  late appUser user;
  late tourismService ts;
  final List<quizQuestion> quizes = [];
  int questionId =0;
  String questionText = "";
  String answerOption1 = "";
  String answerOption2 = "";
  String answerOption3 = "";
  String answerOption4 = "";
  String correctAnswer = "";
  int point = 0;
  int qrId = 0;
  int isDelete=0;

  int tsId=0;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future<void> onListAllClicked() async {
    print("List ALL clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadAll(); // Call the instance method

    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });


  }


  void onTouristSpotClicked() async {

    tsId=6;
    print("Tourist Spot clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadQuizTS(); // Call the instance method

    //loadTourismService()
    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });

  }


  void onActivityClicked() async {
    tsId=5;
    print("Activity clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadQuizActivity(); // Call the instance method

    //loadTourismService()
    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });

  }

  void onRestaurantClicked() async {
    tsId=4;
    print("Restaurant clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadQuizRestaurant(); // Call the instance method

    //loadTourismService()
    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });

  }


  void onLodgingClicked() async {
    tsId=3;
    print("Lodging clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadQuizLodging(); // Call the instance method

    //loadTourismService()
    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });

  }


  void onTransportationClicked() async {
    tsId=2;
    print("Transportation clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadQuizTransport(); // Call the instance method

    //loadTourismService()
    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });

  }


  void onSouvenirStallClicked() async {
    tsId=1;
    print("Souvenir Stall clicked");

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    List<quizQuestion> loadedQuizes = await quiz.loadQuizShopping(); // Call the instance method

    //loadTourismService()
    setState(() {
      quizes .clear();
      quizes.addAll(loadedQuizes);
    });

  }


  void _removeServices(int index) async{

    int isDelete=1;
    int? id=quizes[index].questionId;

    quizQuestion quiz = quizQuestion(questionId, questionText, answerOption1,
        answerOption2, answerOption3, answerOption4, correctAnswer,
        point, qrId, isDelete);

    if(await quiz.deleteQuiz()){

      _AlertMessage(context, "NOTE: Tourism Service Successfully Deleted");
      Future.delayed(Duration(seconds: 2), () {
        // Navigate to the login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => showQuizQuestion(user:user)),
        );
      });
    }

  }

  void _AlertMessage(BuildContext context, String msg) {
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
        toolbarHeight: 90,
        title: Center(
          child: const Text(
            'Delete Tourism Service',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen.shade700,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // Navigate to the home page here
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePageViewWebBSDC(user: user)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onListAllClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.all_inclusive_outlined,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "List ALL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onTouristSpotClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Tourist Spot",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onActivityClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_activity,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Activity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onRestaurantClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Restaurant",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onLodgingClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.hotel,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Lodging",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onTransportationClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_transportation,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Transportation",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onSouvenirStallClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.storefront_rounded,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Souvenir Stall",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height:60),
              _buildListView(),
              SizedBox(height:60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      width: 1200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: quizes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(quizes[index].questionText.toString()),
            background: Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDismissed: (direction) {
              _removeServices(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item dismissed')),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(quizes[index].questionText.toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quiz Point: ${quizes[index].point}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        if (quizes != null && quizes.isNotEmpty && index >= 0 && index < quizes.length) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editQuizQuestion(index: index, quizes: quizes, user:user),
                            ),
                          );
                        } else {
                          // Handle the case where services is null, empty, or the index is out of bounds.
                          print("Invalid index or services list is null or empty.");
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeServices(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
