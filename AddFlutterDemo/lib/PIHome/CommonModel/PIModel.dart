import 'dart:convert';
import 'package:flutter/services.dart';

class PIMethodChannel {
  static const _methodChannel = const MethodChannel('com.pikicast.pikicast/normal');
  static Future<T> request<T>(String methodName, {Map<String, String> parameters}) async {
    return await _methodChannel.invokeMethod(methodName, parameters);
  }
}

class PIImageUtil {
  // critical issue
  static String _baseUrl;
  static _refreshBaseUrl() async{
    if (_baseUrl == null) {
      _baseUrl = await PIMethodChannel.request('image/baseUrl');
    }
  }

  static String _imageBaseUrl() {
    if (_baseUrl == null) {
      _refreshBaseUrl();
    }
    return _baseUrl ?? 'http://dev-cdnb.pikicast.com';
  }

  static String fullImagePath(String path) {
    return (_imageBaseUrl() ?? '') + (path ?? '');
  }
}

class PIEditorModel {
  var identifier = 0;
  var name = '';
  var avatar = '';

  PIEditorModel(this.identifier, this.name, this.avatar);

  PIEditorModel.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        name = json['name']{
    this.avatar = PIImageUtil.fullImagePath(json['avatar']);
  }
}

class PIContentModel {
  var identifier = 0;
  var title = '';
  var description = '';
  var thumbnail = '';

  PIContentModel(this.identifier, this.title, this.description, this.thumbnail);

  PIContentModel.fromJson(Map<String, dynamic> json){
    this.identifier = int.parse(json['identifier']);
    this.title = json['title'];
    this.description = json['description'];
    this.thumbnail = PIImageUtil.fullImagePath(json['thumbnail']);
  }
}

class PILiveModel {
  var identifier = 0;
  var title = '';
  var description = '';
  var thumbnail = '';
  var isLive = false;

  PILiveModel.fromJson(Map<String, dynamic> jsonModel){
    this.identifier = int.parse(jsonModel['identifier']);
    this.title = jsonModel['title'];
    this.description = jsonModel['description'];
    this.thumbnail = PIImageUtil.fullImagePath(jsonModel['thumbnail']);
    this.isLive = jsonModel['isLive'];
  }
}