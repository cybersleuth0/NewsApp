import 'package:bloc/bloc.dart';
import 'package:news_api/Api_Helper/apihelper.dart';
import 'package:news_api/AppConstant/Urls.dart';
import 'package:news_api/models/models.dart';

import 'news_event.dart';
import 'news_state.dart';

class News_Bloc extends Bloc<News_Events, News_States> {
  Api_Helper api_helper;

  News_Bloc({required this.api_helper}) : super(News_initial_States()) {
    on<GetNews_Event>((event, emit) async {
      emit(News_Loading_States());
      var responseJson = await api_helper.getApi(url: Urls.getNewsURL);
      var fromJson = SourceDataModel.fromJson(responseJson);
      if (responseJson != null) {
        emit(News_Success_States(sourceDataModel: fromJson));
      } else {
        emit(News_Failure_States(error: "Something went wrong!"));
      }
    });
  }
}
