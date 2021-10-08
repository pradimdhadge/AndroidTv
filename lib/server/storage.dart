import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = new FlutterSecureStorage();

  Future getData(String key) async {
    return await storage.read(key: key);
  }

  Future getAllData() async {
    return await storage.readAll();
  }

  Future addData({required String key, required String value}) async {
    return await storage.write(key: key, value: value);
  }

  Future addAll(Map data) async {
    if (data.isEmpty) return false;
    data.forEach((key, value) async {
      await addData(key: key.toString(), value: value.toString());
    });

    return true;
  }

  Future updateAll(Map data) async {
    if (data.isEmpty) return false;
    data.forEach((key, value) async {
      await deleteData(key);
      await addData(key: key.toString(), value: value.toString());
    });
    return true;
  }

  Future updateData({required String key, required String value}) async {
    await deleteData(key);
    return await addData(key: key, value: value);
  }

  Future deleteData(String key) async {
    return await storage.delete(key: key);
  }

  Future deleteAllData() async {
    return await storage.deleteAll();
  }
}
