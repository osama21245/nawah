import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String _basicAuth = 'Basic ${base64Encode(utf8.encode("osama:osama1234"))}';

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  final Dio dio;

  Crud({required this.dio});

  Future<Map> postData(String link, Map<String, dynamic> data) async {
    int maxretry = 0;
    try {
      var response = await dio.post(
        link,
        data: data,
        options: Options(
          contentType: "application/json",
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If response.data is already a Map, return it directly
        if (response.data is Map) {
          return response.data;
        }
        // If it's a String, parse it
        if (response.data is String) {
          return jsonDecode(response.data);
        }
        throw const FormatException('Unexpected response format');
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        print('Request timed out: ${e.message}');
        throw "Request timed out";
      } else if (e.type == DioExceptionType.connectionError) {
        if (await _hasInternetAccess() && maxretry < 2) {
          return postData(link, data);
        } else {
          throw "No Internet Connection";
        }
      } else {
        throw e.message ?? "Unknown error";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> getData(String link, Map<String, dynamic> data) async {
    int maxretry = 0;
    try {
      var response = await dio.get(
        link,
        data: data,
        options: Options(
          contentType: "application/json",
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If response.data is already a Map, return it directly
        if (response.data is Map) {
          return response.data;
        }
        // If it's a String, parse it
        if (response.data is String) {
          return jsonDecode(response.data);
        }
        throw const FormatException('Unexpected response format');
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        print('Request timed out: ${e.message}');
        throw "Request timed out";
      } else if (e.type == DioExceptionType.connectionError) {
        if (await _hasInternetAccess() && maxretry < 2) {
          return postData(link, data);
        } else {
          throw "No Internet Connection";
        }
      } else {
        throw e.message ?? "Unknown error";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final response = await http
          .get(Uri.parse('https://google.com'))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Future<Map> multiPostData(File imageFile, String link, Map data) async {
  //   final url = Uri.parse(link);
  //   var request = http.MultipartRequest('POST', url)
  //     ..fields['name'] = data["name"] // إضافة الاسم كحقل نصي
  //     ..files.add(await http.MultipartFile.fromPath(
  //       'image',
  //       imageFile.path,
  //     ));
  //   var response = await request.send();

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var responseBody = await response.stream.bytesToString();
  //     var decodedResponse = jsonDecode(responseBody);
  //     print(decodedResponse);
  //     final res = decodedResponse;
  //     return res;
  //   } else {
  //     throw const ServerException(message: "Server Error");
  //   }
  // }

  Future<Map> multiListPostData(
      List<File> imageFiles, String link, Map data) async {
    final url = Uri.parse(link);
    var request = http.MultipartRequest('POST', url)
      ..fields['name'] = data["name"]; // Add the name as a text field

    for (var imageFile in imageFiles) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        imageFile.path,
      ));
    }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
      var decodedResponse = jsonDecode(responseBody);
      print(decodedResponse);
      final res = decodedResponse;
      return res;
    } else {
      throw Exception("Server Error");
    }
  }

  // Future<Either<StatusRequest, Map>> postDataPayment(
  //   String linkurl,
  //   Map data,
  // ) async {
  //   if (await checkInternet()) {
  //     var response = await http.post(Uri.parse(linkurl),
  //         body: jsonEncode(data),
  //         headers: {'Content-Type': 'application/json'});
  //     print(response.statusCode);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Map responsebody = jsonDecode(response.body);
  //       print(responsebody);

  //       return right(responsebody);
  //     } else {
  //       return const Left(StatusRequest.serverfailure);
  //     }
  //   } else {
  //     return const Left(StatusRequest.offlinefaliure);
  //   }
  // }
}
