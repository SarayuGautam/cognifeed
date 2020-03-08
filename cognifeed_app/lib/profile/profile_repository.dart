import 'dart:io';

import 'package:cognifeed_app/constants/cognifeed_constants.dart';
import 'package:cognifeed_app/profile/profile_response_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class ProfileRepository {
  static Future<ProfileResponseModel> getUserProfile() async {
    try {
      final response = await Cognifeed.dioClient.get("$baseUrl/users/profile");
      if (response.data.containsKey('error')) {
        return Future.error(response.data['error']);
      }
      return Future.value(ProfileResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is SocketException) {
        return Future.error("Unable to connect to internet.");
      }
      return Future.error(e.toString());
    }
  }

  static Future<String> updateUserProfile({
    @required String name,
    @required String email,
    @required String phone,
    @required String bio,
    @required String website,
    @required String address,
    @required String about,
  }) async {
    try {
      final response = await Cognifeed.dioClient.patch(
        "$baseUrl/users/profile",
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "bio": bio,
          "website": website,
          "address": address,
          "about": about,
        },
      );
      if (response.data.containsKey('error')) {
        return Future.error(response.data['error']);
      }
      return Future.value(response.data['message']);
    } catch (e) {
      if (e is SocketException) {
        return Future.error("Unable to connect to internet.");
      }
      return Future.error(e.toString());
    }
  }

  static Future<String> changePassword({
    @required String currentPassword,
    @required String newPassword,
  }) async {
    try {
      final response = await Cognifeed.dioClient.post(
        "$baseUrl/users/changepw",
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        },
      );
      if (response.data.containsKey('error')) {
        return Future.error(response.data['error']);
      }
      return Future.value(response.data['message']);
    } catch (e) {
      if (e is SocketException) {
        return Future.error("Unable to connect to internet.");
      }
      return Future.error(e.toString());
    }
  }

  static Future<String> forgetPassword(
      {@required String currentPassword,
      @required String newPassword,
      @required String verificationCode}) async {
    try {
      final response = await Cognifeed.dioClient.post(
        "$baseUrl/users/forgetpw",
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "resetToken": verificationCode,
        },
      );
      if (response.data.containsKey('error')) {
        return Future.error(response.data['error']);
      }
      return Future.value(response.data['message']);
    } catch (e) {
      if (e is SocketException) {
        return Future.error("Unable to connect to internet.");
      }
      return Future.error(e.toString());
    }
  }

  static Future uploadProfilePicture({@required File image}) async {
    String filename = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profile": await MultipartFile.fromFile(image.path, filename: filename)
    });
    try {
      final response = await Cognifeed.dioClient.patch(
        "$baseUrl/users/profile/image",
        data: formData,
      );
      if (response.data.containsKey('error')) {
        return Future.error(response.data['error']);
      }
      return Future.value(response.data);
    } catch (e) {
      if (e is SocketException) {
        return Future.error("Unable to connect to internet.");
      }
      return Future.error(e.toString());
    }
  }
}
