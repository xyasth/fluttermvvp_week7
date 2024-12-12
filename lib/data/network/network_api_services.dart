import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttermvvp_week7/data/app_exeption.dart';
import 'package:fluttermvvp_week7/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:fluttermvvp_week7/data/network/base_api_services.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApiResponse(String endpoint) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.https(Const.BaseUrl, endpoint), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apikey,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request time out!');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiResponse(String endpoint, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.https(Const.BaseUrl, endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apikey,
        },
        body: jsonEncode(data),
      );
      responseJson = returnResponse(response);
      print("RESPONSE");
      return responseJson;
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request time out!');
    } catch (e) {
      throw FetchDataException('Unexpected error: $e');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server');
    }
  }
}

// class NetworkApiServices implements BaseApiServices {
//   @override
//   Future getApiResponse(String endpoint) async {
//     dynamic responseJson;
//     try {
//       final response = await http
//           .get(Uri.https(Const.BaseUrl, endpoint), headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'key': Const.apikey,
//       });
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw NoInternetException('');
//     } on TimeoutException {
//       throw FetchDataException('Network Request Time Out !!');
//     }

//     return responseJson();
//   }

//   @override
//   Future postApiResponse(String url, data) {
//     // TODO: implement postApiResponse
//     throw UnimplementedError();
//   }

//   dynamic returnResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         dynamic responseJson = jsonDecode(response.body);
//         return responseJson;
//       case 400:
//         throw BadRequestException(response.body.toString());
//       case 500:
//       case 404:
//         throw UnauthorisedException(response.body.toString());
//       default:
//         throw FetchDataException(
//             'Error occured while communicating with server');
//     }
//   }
// }
