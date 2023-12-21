

import '../Controller/request_controller.dart';

class appUser {
  int? appUserId;
  String? firstName;
  String? lastName;
  String? nickName;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? password;
  String? accessStatus;
  String? country;
  int? roleId;
  int? points;

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



  appUser.getId(
      this.email,
      );

  appUser.resetPassword(
      this.appUserId,
      this.password
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

  Future<bool> resetPassword() async {
    RequestController req = RequestController(path: "/api/getAppUserId.php");
    req.setBody({"appUserId": appUserId, "password": password });
    await req.put();
    if (req.status() == 400) {
      return false;
    } else if (req.status() == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getUserId() async {
    RequestController req = RequestController(path: "/api/getAppUserId.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      appUserId=req.result()['appUserId'];
      print(appUserId);
      return true;
    }
    else {
      return false;
    }
  }

  //ASH
  Future<bool> profilesave() async {
    try {
      // Create a Map representing the user profile data

      // Send a request to the server to update the user profile
      RequestController req = RequestController(path: "/api/updateProfile.php");
      //req.setBody(profileData);
      req.setBody({"appUserId": appUserId, 'nickName': nickName, 'phoneNumber': phoneNumber, 'password':password});
      await req.put();

      if (req.status() == 200) {
        // Profile update successful
        return true;
      } else {
        // Handle specific cases, e.g., duplicate email
        if (req.result()?.toString() == '{error: Email is already registered}') {
          return false;
        } else {
          // Handle other error cases
          return false;
        }
      }
    } catch (e) {
      // Handle errors, log them, and return false.
      print("Error updating profile: $e");
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

  //ASH
  Future<int> getCountByRoleId(int roleId) async {
    try {

      // Create a Map representing the user profile data

      RequestController req = RequestController(path: "/api/TotalUsersCount.php");
      req.setBody({'roleId': 4});
      await req.post();

      if (req.status() == 200) {
        Map<String, dynamic> result = req.result();
        return result['count'];
      } else {
        // Handle the error case
        return -1;
      }
    } catch (e) {
      // Handle errors and return an appropriate value
      print("Error getCountByRoleId: $e");
      return -1;
    }
  }

  //ASH
  Future<int> getInternationalUsersCount(String country, int roleId) async {
    try {
      RequestController req = RequestController(path: "/api/InternationalUsersCount.php");
      req.setBody({"country": country, "roleId": 4});
      await req.post();

      if (req.status() == 200) {
        Map<String, dynamic> result = req.result();
        return result['count'];
      } else {
        // Handle the error case
        return 0;
      }
    } catch (e) {
      // Handle errors and return an appropriate value
      return 0;
    }
  }

  //ASH
  Future<int> getLocalUsersCount(String country, int roleId) async {
    try {
      RequestController req = RequestController(path: "/api/LocalUsersCount.php");
      req.setBody({"country": country, "roleId": 4});
      await req.post();

      if (req.status() == 200) {
        Map<String, dynamic> result = req.result();
        return result['count'];
      } else {
        // Handle the error case
        return 0;
      }
    } catch (e) {
      // Handle errors and return an appropriate value
      return 0;
    }
  }


  //ASH
  Future<int> getCountByAccessStatus(String accessStatus, int roleId) async {
    try {
      RequestController req = RequestController(path: "/api/ActiveUsersCount.php");
      req.setBody({"accessStatus": accessStatus, "roleId": 4});
      await req.post();

      if (req.status() == 200) {
        Map<String, dynamic> result = req.result();
        return result['count'];
      } else {
        // Handle the error case
        return 0;
      }
    } catch (e) {
      // Handle errors and return an appropriate value
      return 0;
    }
  }


}
