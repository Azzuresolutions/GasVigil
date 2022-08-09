import 'package:dio/dio.dart';

class MethodType {
  static const String post = "POST";
  static const String get = "GET";
  static const String put = "PUT";
  static const String delete = "DELETE";
  static const String patch = "Patch";
}

class NetworkClient {
  static NetworkClient? _shared;

  NetworkClient._();

  static NetworkClient get getInstance =>
      _shared = _shared ?? NetworkClient._();

  final dio = Dio();

  // Map<String, dynamic> getAuthHeaders() {
  //   Map<String, dynamic> authHeaders = <String, dynamic>{};

  //   if (PrefUtils.getInstance.isUserLogin()) {
  //     authHeaders["Authorization"] =
  //         // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MGEyMGVmMDQ2NmZmMTViMzFiYWYxZWYiLCJpc1JlZnJlc2giOmZhbHNlLCJpYXQiOjE2MjI0ODU2OTYsImV4cCI6MTYyMjQ4NTk5Nn0.S_JkAqsqHvKegBHmMrBkbKFP08LdGGvpjHx3A7xP7L0";
  //         "Bearer " +
  //             PrefUtils.getInstance.readData(
  //               PrefUtils.getInstance.accessToken,
  //             );
  //   } else {
  //     authHeaders["Content-Type"] = "application/json";
  //     // }

  //   }
  //   return authHeaders;
  // }

  Future<Response?> makeApiCall(
    String baseUrl,
    String method, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Function(dynamic response, String message)? successCallback,
    Function(String statusCode, String message)? failureCallback,
  }) async {
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   failureCallback(
    //     "",
    //     "No Internet Connection",
    //   );
    //   return null;
    // }

    dio.options.validateStatus = (status) {
      return status! < 510;
    };

    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 50000;

    // dio.options.connectTimeout =
    //     PrefUtils.getInstance.apiConfig()["config"]['timeout.connect'].toInt();
    // dio.options.receiveTimeout =
    //     PrefUtils.getInstance.apiConfig()["config"]['timeout.read'].toInt();

    // dio.options.headers = getAuthHeaders();

    // if (kDebugMode) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) => "PROXY 192.168.1.6:8888;";
    //   };
    // }

    if (headers != null) {
      for (var key in headers.keys) {
        dio.options.headers[key] = headers[key];
      }
    } else {
      dio.options.headers = {"Content-Type": "application/json"};
    }

    // FormData formData = FormData.fromMap(params!);

    switch (method) {
      case MethodType.post:
        try {
          Response response = await dio.post(
            baseUrl,
            data: params,
          );

          parseResponse(
            response,
            successCallback: successCallback!,
            failureCallback: failureCallback!,
          );
        } catch (error) {
          if (error is DioError) {}
        }
        break;

      case MethodType.get:
        Response response = await dio.get(
          baseUrl,
          queryParameters: params,
        );

        parseResponse(
          response,
          successCallback: successCallback!,
          failureCallback: failureCallback!,
        );

        break;

      case MethodType.put:
        Response response = await dio.put(
          baseUrl,
          data: params,
        );

        parseResponse(
          response,
          successCallback: successCallback!,
          failureCallback: failureCallback!,
        );

        break;

      case MethodType.delete:
        Response response = await dio.delete(
          baseUrl,
          data: params,
        );

        parseResponse(
          response,
          successCallback: successCallback!,
          failureCallback: failureCallback!,
        );

        break;

      case MethodType.patch:
        Response response = await dio.patch(
          baseUrl,
          data: params,
        );

        parseResponse(
          response,
          successCallback: successCallback!,
          failureCallback: failureCallback!,
        );

        break;

      default:
    }
    return null;
  }

  parseResponse(
    Response response, {
    Function(dynamic response, String message)? successCallback,
    Function(String statusCode, String message)? failureCallback,
  }) async {
    // int statusCode = response.data['code'];
    // String message = response.data["msg"].toString();
    final body = response;
    // print(body);

    // bool isVerify = response.data['isVerified'];
    // print(message);
    String message = response.statusMessage!;
    // String message = body["msg"];
    // int respStatus = body.data?['errorCode'] ?? 0;

    // if ((response.statusCode == ApiConstants.statusCodeOk ||
    //     response.statusCode == ApiConstants.statusCodeOk1)) {
    // if (body.statusCode == 200) {
    successCallback!(body.data, message);
    // if (body is Map<String, dynamic> || body is List<dynamic>) {
    //   successCallback!(body.data, message);
    //   return;
    // } else if (body is List<Map<String, dynamic>>) {
    //   successCallback!(body.data, message);
    //   return;
    // } else {
    //   failureCallback!(
    //     response.statusCode.toString(),
    //     message,
    //   );
    //   return;
    // }
    // } else {
    //   // ignore: avoid_print
    //   print(response.statusCode);

    //   failureCallback!(
    //     response.statusCode.toString(),
    //     message,
    //   );
    // }
  }
}
