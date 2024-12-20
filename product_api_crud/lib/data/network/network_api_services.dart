import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'base_api_services.dart';
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  // GET API Response
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // POST API Response (Create)
  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: {
        "Content-Type": "application/json"
      }).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // PUT/PATCH API Response (Update)
  @override
  Future<dynamic> getUpdateApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url), body: jsonEncode(data), headers: {
        "Content-Type": "application/json"
      }).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // DELETE API Response
  @override
  Future<dynamic> getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

 // Process and validate the HTTP response based on status codes
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: // HTTP OK
        // Parse and return the response body as JSON
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 201: // Resource created successfully
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 204: // No content returned by the server
        return null;

      case 400: // Bad request
        throw BadRequestException(response.body.toString());

      case 401: // Unauthorized access
        throw UnauthorizedException('Unauthorized: ${response.body.toString()}');

      case 403: // Forbidden access
        throw UnauthorizedException('Forbidden: ${response.body.toString()}');

      case 404: // Resource not found
        throw BadRequestException('Not Found: ${response.body.toString()}');

      case 500: // Server error
        throw FetchDataException('Internal Server Error: ${response.body.toString()}');

      case 503: // Service unavailable
        throw FetchDataException('Service Unavailable: ${response.body.toString()}');

      default: // Any other unexpected HTTP status code
        throw FetchDataException(
            'Unexpected Error Occurred: ${response.statusCode} - ${response.body.toString()}');
    }
  }
}