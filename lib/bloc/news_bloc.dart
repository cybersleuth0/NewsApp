import 'package:bloc/bloc.dart';
import 'package:news_api/Api_Helper/apihelper.dart';
import 'package:news_api/AppConstant/Urls.dart';
import 'package:news_api/models/models.dart';

import 'news_event.dart';
import 'news_state.dart';

class News_Bloc extends Bloc<NewsEvents, News_States> {
  Api_Helper api_helper;

  News_Bloc({required this.api_helper}) : super(News_initial_States()) {
    /////Get Carousel News
    on<GetCarouselNewsEvent>((event, emit) async {
      emit(News_Loading_States());
      var responseJson = await api_helper.getApi(url: Urls.getCarouselNewsURL);
      var fromJson = NewsDataModel.fromJson(responseJson);
      if (responseJson != null) {
        emit(News_Success_States(newsDataModel: fromJson));
      } else {
        emit(News_Failure_States(error: "Something went wrong!"));
      }
    });

    ////Get News By Category
    on<GetNewsByCategoryEvent>((event, emit) async {
      emit(News_Loading_States());
      String fetchcategoryUrl =
          "${Urls.getNewsByCategoryURL}category=${event.category}&apiKey=${Urls.apiKey}";
      print("Url: $fetchcategoryUrl");
      var responseJson = await api_helper.getApi(url: fetchcategoryUrl);
      var fromJson = NewsDataModel.fromJson(responseJson);
      if (responseJson != null) {
        emit(News_Success_States(newsDataModel: fromJson));
      } else {
        emit(News_Failure_States(error: "Something went wrong!"));
      }
    });
  }
}
