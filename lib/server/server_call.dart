import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:androidtv/globals/globals.dart' as globals;

class ServerCall {
  final String _domain = 'lokchitra.com';
  final Map<String, String> headers = {'X-LOKCHITRA': 'lokchitra123*#'};

  Future postRequest({arguments, path}) async {
    if (!await checkNetConnection()) return {'statusCode': 504};

    headers.addAll({'Access-Token': globals.token});
    final response = await http.post(
      Uri.https(_domain, path),
      headers: headers,
      body: arguments,
    );
    updateCookie(response);

    if (response.statusCode == 200) {
      print(response.body);
      final Map _resBody = jsonDecode(response.body);
      _resBody['statusCode'] = 200;
      return _resBody;
    } else
      return {'statusCode': response.statusCode};
  }

  Future getRequest({arguments, path}) async {
    if (!await checkNetConnection()) return {'statusCode': 504};

    headers.addAll({'Access-Token': globals.token});
    final response =
        await http.get(Uri.https(_domain, path, arguments), headers: headers);

    updateCookie(response);

    if (response.statusCode == 200) {
      final Map _resBody = jsonDecode(response.body);
      _resBody['statusCode'] = 200;
      return _resBody;
    } else
      return {'statusCode': response.statusCode};
  }

  Future getFile({path}) async {
    final response = await http.get(Uri.parse(path));
    return response;
  }

  Future multipartRequest(
      {Map<String, String>? upfiles, required String url, arguments}) async {
    if (!await checkNetConnection()) return {'statusCode': 504};

    headers.addAll({'Access-Token': globals.token});
    var request = http.MultipartRequest('POST', Uri.https(_domain, url));
    request.headers.addAll(headers);

    if (upfiles != null)
      upfiles.forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(key, value));
      });

    request.fields.addAll(arguments);

    http.Response response =
        await http.Response.fromStream(await request.send());

    updateCookie(response);

    if (response.statusCode == 200) {
      Map _resBody = jsonDecode(response.body);
      _resBody['statusCode'] = 200;
      return _resBody;
    } else
      return {'statusCode': response.statusCode};
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  checkNetConnection() async {
    var _connectionStatus;
    final Connectivity _connectivity = Connectivity();

    _connectionStatus = await _connectivity.checkConnectivity();
    if (_connectionStatus == ConnectivityResult.none) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Network Connection Fails');
      return false;
    }
    return true;
  }
}
