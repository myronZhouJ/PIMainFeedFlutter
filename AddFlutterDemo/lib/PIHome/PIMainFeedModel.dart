import 'package:flutter/material.dart';
import 'Networking/PIAPI.dart';
import 'CommonModel/PIModel.dart';

class PIMainFeedModel with ChangeNotifier {
  var loaded = false;

  final liveEditorList = List<PILiveEditorModel>();
  final featuredContentList = List<PIContentModel>();
  final recommendedContentList = List<PIContentModel>();
  final justUpdatedContentList = List<PIContentModel>();
  final recommendedEditorList = List<PILiveEditorModel>();
  final liveProgramList = List<PILiveModel>();
  final categoryContentList = List<PIContentModel>();

  void load() {
    PIAPI.GET('mainFeed/start', parameters:{'offset':'0'}, successCallback:(json){
        for (Map<String, dynamic> item in json['data']['liveEditorList']) {
          liveEditorList.add(PILiveEditorModel.fromJson(item));
          var last = liveEditorList.last;
          print(last.identifier.toString() + last.name + last.avatar.toString() + last.isLive.toString());
        }
        loaded = true;
        notifyListeners();
    }, failedCallback: (error){
          print(error.code + error.message);
    });
  }

  void loadMoreRecommendedContent(){

  }

  void loadMoreJustUpdatedContent(){

  }
}

class PILiveEditorModel extends PIEditorModel {
  bool isLive = false;
  PILiveEditorModel.fromJson(Map<String, dynamic> jsonModel):isLive = jsonModel['isLive'] == 1, super.fromJson(jsonModel);
}



