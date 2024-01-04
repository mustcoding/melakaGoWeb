import 'dart:convert';

import '../Controller/request_controller.dart';

class quizQuestion {

  int? questionId;
  String? questionText;
  String? answerOption1;
  String? answerOption2;
  String? answerOption3;
  String? answerOption4;
  String? correctAnswer;
  int? point;
  int? qrId;
  int? isDelete;

  quizQuestion(
      this.questionId,
      this.questionText,
      this.answerOption1,
      this.answerOption2,
      this.answerOption3,
      this.answerOption4,
      this.correctAnswer,
      this.point,
      this.qrId,
      this.isDelete
      );

  quizQuestion.Id(
      this.qrId
      );

  quizQuestion.fromJson(Map<String, dynamic> json)
      : questionId = json['questionId'] as dynamic?,
        questionText = json['questionText'] as String? ?? '',
        answerOption1 = json['answerOption1'] as String? ?? '',
        answerOption2 = json['answerOption2'] as String? ?? '',
        answerOption3 = json['answerOption3'] as String? ?? '',
        answerOption4 = json['answerOption4'] as String? ?? '',
        correctAnswer = json['correctAnswer'] as String? ?? '',
        point = json['point'] as dynamic?,
        qrId = json['qrId'] as dynamic?,
        isDelete = json['isDelete'] as dynamic?;



  //toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'questionText': questionText,
    'answerOption1': answerOption1,
    'answerOption2': answerOption2,
    'answerOption3': answerOption3,
    'answerOption4': answerOption4,
    'correctAnswer': correctAnswer,
    'point': point,
    'qrId': qrId,
    'isDelete': isDelete,
  };

  Future<bool> saveQuestion() async {
    RequestController req = RequestController(path: "/api/quizquestion.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {

      return true;
    }
    else {
      return false;
    }
  }

  Future<int> calculate() async {
    RequestController req = RequestController(path: "/api/quizquestion.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200) {
      int result=req.result()['count'];
      return result;
    }
    else {
      return 0;
    }
  }

  Future<int> calculateQuizByQR() async {
    RequestController req = RequestController(path: "/api/quizquestion.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      int result=req.result()['count'];
      return result;
    }
    else {
      return 0;
    }
  }

  Future<List<quizQuestion>> loadAll() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestion.php");
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }


  Future<List<quizQuestion>> loadQuizTS() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestionTS.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }

  Future<List<quizQuestion>> loadQuizTransport() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestionTransport.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }

  Future<List<quizQuestion>> loadQuizShopping() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestionShopping.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }

  Future<List<quizQuestion>> loadQuizLodging() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestionLodging.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }

  Future<List<quizQuestion>> loadQuizRestaurant() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestionRestaurant.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }

  Future<List<quizQuestion>> loadQuizActivity() async {
    List<quizQuestion> result = [];
    RequestController req =
    RequestController(path: "/api/loadQuizQuestionActivity.php");
    req.setBody(toJson());
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(quizQuestion.fromJson(item));
      }
    }
    return result;
  }

  Future<bool> deleteQuiz() async {
    RequestController req = RequestController(path: "/api/deleteTourismService.php");
    req.setBody({"questionId": questionId, "isDelete": isDelete});
    await req.put();
    if (req.status() == 400) {
      return false;
    } else if (req.status() == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateQuiz() async {

    RequestController req = RequestController(path: "/api/quizquestion.php");
    req.setBody({
      "questionId": questionId
      , "questionText": questionText
      , "answerOption1": answerOption1
      , "answerOption2": answerOption2
      , "answerOption3": answerOption3
      , "answerOption4": answerOption4
      , "correctAnswer": correctAnswer
      , "point": point
      , "qrId": qrId
      , "isDelete": isDelete});

    await req.put();
    if (req.status() == 400) {
      return false;
    } else if (req.status() == 200) {
      return true;
    } else {
      return false;
    }
  }

}
