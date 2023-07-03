import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:technical_test_meddi_yosidey/libraries/url_data.dart' as app_url;
import 'exceptions.dart';

///***************************************************************************
/// ApiBase
///***************************************************************************

abstract class ApiBase {
  late String apiUrl;
  late Map<String, String> headers;
}

///***************************************************************************
/// ApiService
///***************************************************************************
class ApiService extends ApiBase {
  /// Singleton constructor
  static final ApiService _instance = ApiService._internal();

  factory ApiService(String point, {String? token}) {
    _instance.apiUrl = app_url.serverApi + point;

    /// For the body json
    _instance.headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    if (token != null) {
      /// Add token if existing
      _instance.headers[HttpHeaders.authorizationHeader] = "JWT $token";
    }

    return _instance;
  }

  factory ApiService.baseUrl(String url, {String? token}) {
    _instance.apiUrl = url;

    /// For the body json
    _instance.headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    if (token != null) {
      /// Add token if existing
      _instance.headers[HttpHeaders.authorizationHeader] = "JWT $token";
    }

    return _instance;
  }

  ApiService._internal();

  ///*************** apiGetRequest ***************
  Future<dynamic> apiGetRequest() async {
    var responseJson;
    try {
      final response =
          (headers == null) ? await http.get(Uri.parse(apiUrl)) : await http.get(Uri.parse(apiUrl), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  ///*************** apiPostRequest ***************
  Future<dynamic> apiPostRequest(String body) async {
    var responseJson;
    try {
      final response = (headers == null)
          ? await http.post(Uri.parse(apiUrl), body: body)
          : await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  ///*************** apiPutRequest ***************
  Future<dynamic> apiPutRequest(String body) async {
    var responseJson;

    try {
      final response = (headers == null)
          ? await http.put(Uri.parse(apiUrl), body: body)
          : await http.put(Uri.parse(apiUrl), body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  ///*************** apiDeleteRequest ***************
  Future<dynamic> apiDeleteRequest() async {
    var responseJson;

    try {
      final response =
          (headers == null) ? await http.delete(Uri.parse(apiUrl)) : await http.delete(Uri.parse(apiUrl), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  ///*************** _returnResponse ***************
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201: // For the POST

        debugPrint("##API: Status code -> ${response.statusCode}");
        //debugPrint("##API: Status Body -> ${response.body}");
        /// Content-Type http header sent by the server is missing the
        /// encoding tag. This causes the Dart http client to decode the
        /// body as Latin-1 instead of utf-8.
        final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 400:
        throw BadDataException(utf8.decode(response.bodyBytes));
      case 401:
      case 403:
        throw UnauthorizedDataException(utf8.decode(response.bodyBytes));
      case 500:
        throw FetchDataException('Error occured while Communication with Server with Status code: ${response.statusCode}');
      case 502:
        throw BadDataException('Bad Gateway with Server with Status code: ${response.statusCode}');
    }
  }
}
