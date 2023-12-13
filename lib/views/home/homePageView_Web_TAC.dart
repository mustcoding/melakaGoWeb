import 'package:flutter/material.dart';
import 'package:melakago_web/Model/tourismService.dart';
import '../../Model/appUser.dart';
import '../../Model/quizQuestion.dart';
import '../../widgets/navigation_bar/navigationLogin_Web_TAC.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageViewWebTAC extends StatelessWidget {
  late final appUser user;
  HomePageViewWebTAC({required this.user}) : nickName = user.nickName;

  String nickName = '';
  int? totalQuestion;

  static const containerWidth = 360.0;
  static const containerHeight = 200.0;

  Future<void> countTS() async{

    int questionId=0;
    String questionText='';
    String answerOption1='';
    String answerOption2='';
    String answerOption3='';
    String answerOption4='';
    String correctAnswer='';
    int point=0;
    int qrId=0;


    quizQuestion question = quizQuestion (questionId,
        questionText,answerOption1,answerOption2, answerOption3,
        answerOption4, correctAnswer, point,qrId);

    totalQuestion = await question.calculate();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavigationLoginWebTAC(user: user),
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                          ),
                        ),
                        child: CustomPaint(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.orangeAccent, Colors.red],
                              ).createShader(bounds);
                            },
                            child: Text(
                              '   Where History \nWhispers In Every \n   Cobblestone',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.grey,
                                    offset: Offset(3.0, 3.0),
                                  ),
                                ],
                                fontSize: 75,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.amberAccent.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 80),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 7.0),
                          SizedBox(
                            width: containerWidth,
                            height: containerHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey, // Set the background color to grey
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height:60.0),
                                  // Icon and Title
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.question_mark_outlined,
                                        size: 30.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 15.0),
                                      Text(
                                        'TOTAL QUESTIONS',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  // Number of Tourist Spots
                                  FutureBuilder<void>(
                                    future: countTS(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${totalQuestion}',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        // Display a loading indicator or placeholder while waiting for the calculation
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

