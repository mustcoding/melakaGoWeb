

import '../Controller/request_controller.dart';

class appUser {
  int appUserId;
  String firstName;
  String lastName;
  String nickName;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String password;
  String accessStatus;
  String country;
  int roleId;
  int points;

  appUser(
      this.appUserId,
      this.firstName,
      this.lastName,
      this.nickName,
      this.dateOfBirth,
      this.phoneNumber,
      this.email,
      this.password,
      this.accessStatus,
      this.country,
      this.roleId,
      this.points
      );

  appUser.fromJson(Map<String, dynamic> json)
      : appUserId = json['appUserId'] as dynamic,
        firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        nickName = json['nickName'] as String,
        dateOfBirth = json['dateOfBirth'] as String,
        phoneNumber = json['phoneNumber'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        accessStatus = json['accessStatus'] as String,
        country = json['country'] as String,
        roleId = json['roleId'] as dynamic,
        points = json['points'] as dynamic;

  //toJson will be automatically called by jsonEncode when necessary
  Map<String, dynamic> toJson() => {
    'appUserId': appUserId,
    'firstName': firstName,
    'lastName': lastName,
    'nickName': nickName,
    'dateOfBirth': dateOfBirth,
    'phoneNumber': phoneNumber,
    'email': email,
    'password': password,
    'accessStatus': accessStatus,
    'country': country,
    'roleId': roleId,
    'points': points,
  };

  Future<bool> save() async {
    RequestController req = RequestController(path: "/api/appuser.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 400) {
      return false;
    } else if (req.status() == 200) {
      String data = req.result().toString();
      if (data == '{error: Email is already registered}') {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkAdminExistence() async {
    RequestController req = RequestController(path: "/api/appUserCheckExistence.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      appUserId=req.result()['appUserId'];
      firstName=req.result()['firstName'];
      lastName=req.result()['lastName'];
      nickName=req.result()['nickName'];
      dateOfBirth=req.result()['dateOfBirth'];
      phoneNumber=req.result()['phoneNumber'];
      email=req.result()['email'];
      password=req.result()['password'];
      country=req.result()['country'];
      accessStatus=req.result()['accessStatus'];
      roleId=req.result()['roleId'];
      points=req.result()['points'];
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> deleteUser() async {
    RequestController req = RequestController(path: "/api/appUserCheckExistence.php");
    req.setBody({"appUserId": appUserId, "accessStatus": "DEACTIVATE"});
    await req.put();
    if (req.status() == 400) {
      return false;
    } else if (req.status() == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile() async {
    RequestController req = RequestController(path: "/api/appuser.php");
    req.setBody({"appUserId": appUserId, "nickName": nickName, "phoneNumber": phoneNumber, "email": email, "password": password });
    await req.put();
    if (req.status() == 400) {
      return false;
    } else if (req.status() == 200) {
      return true;
    } else {
      return false;
    }
  }


  Future<List<appUser>> loadAll() async {
    List<appUser> result = [];
    RequestController req =
    RequestController(path: "/api/appUserCheckExistence.php");
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(appUser.fromJson(item) as appUser);
      }
    }
    return result;
  }
  //hello world!!
}
