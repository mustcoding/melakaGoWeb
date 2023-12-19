import 'dart:convert';

import 'package:melakago_web/Model/qrId.dart';
import 'package:melakago_web/Model/qrId.dart';
import 'package:melakago_web/Model/qrId.dart';

import '../Controller/request_controller.dart';

class qrSpot {

  int? qrId;
  int? tourismServiceId;

  qrSpot(
      this.qrId,
      this.tourismServiceId,
      );

  qrSpot.getId(
      this.tourismServiceId,
      );

  qrSpot.fromJson(Map<String, dynamic> json)
      : qrId = json['qrId'] as dynamic?,
        tourismServiceId = json['tourismServiceId'] as dynamic?
      ;

  //toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'qrId': qrId,
    'tourismServiceId': tourismServiceId,
  };

  Future<bool> saveQR() async {
    RequestController req = RequestController(path: "/api/qrSpot.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200)
    {
      return true;
    }
    else {
      return false;
    }

  }

  Future<bool> getQRId() async {
    RequestController req = RequestController(path: "/api/getTourismServiceIdQuiz.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      qrId=req.result()['qrId'];
      print(qrId);
      return true;
    }
    else {
      return false;
    }
  }

  Future<int> calculate() async {
    RequestController req = RequestController(
        path: "/api/countTourismService.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      int result = req.result()['count'];
      return result;
    }
    else {
      return 0;
    }
  }

  Future<List<qrSpot>> loadQRSpot() async {
    List<qrSpot> result = [];
    RequestController req =
    RequestController(path: "/api/getTourismServiceIdQuiz.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(qrSpot.fromJson(item));
      }
    }
    return result;
  }

}
