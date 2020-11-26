import 'package:flutter/services.dart';
import 'dart:convert';

typedef PIAPISuccessCallback = void Function(Map<String, dynamic> json);
typedef PIAPIFailedCallback = void Function(PIAPIFailed failed);

class PIAPIFailed {
    var code = '';
    var message = '';
    PIAPIFailed(this.code, this.message);
}

class PIAPI {
  static const _methodChannel = const MethodChannel('com.pikicast.pikicast/API');

  static Map<String, dynamic> createParameters(String method, Map<String, String> parameters){
    Map<String, dynamic> arguments = {'METHOD':(method != null && method.length > 0) ? method : 'GET'};
    if (parameters != null){
      if(parameters.length > 0){
        arguments['PARAMETERS'] = parameters;
      }
    }
    return arguments;
  }

  static void _request(String method, String urlString, Map<String, String> parameters, PIAPISuccessCallback successCallback, PIAPIFailedCallback failedCallback) async {

    final String result = await _methodChannel.invokeMethod(urlString, createParameters(method,parameters));

/*    String result = '';
    await Future.delayed(Duration(seconds: 1), (){
      if (true) {
        result = '{\"data\":{\"liveEditorList\":[{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":1},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":1},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":1},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},'
            '{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0}]}}';
      }else{
        result = '{\"error\":{\"code\":\"ES11\",\"message\":\"I am error\"}}';
      }
    });*/

    print(result);
    Map<String, dynamic> jsonModel = json.decode(result);
    var error = jsonModel['error'];
    if (error == null){
      successCallback(jsonModel);
    }else{
      failedCallback(PIAPIFailed(error['code'], error['message']));
    }
  }

  static void GET(String urlString, {Map<String, String> parameters,PIAPISuccessCallback successCallback, PIAPIFailedCallback failedCallback }) async {
      _request('GET', urlString, parameters, successCallback, failedCallback);
  }

  static void POST(String urlString, {Map<String, String> parameters,PIAPISuccessCallback successCallback, PIAPIFailedCallback failedCallback }) async {
      _request('GET', urlString, parameters, successCallback, failedCallback);
  }
}