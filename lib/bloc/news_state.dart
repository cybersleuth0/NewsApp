
import '../models/models.dart';

abstract class News_States {}

// Represents the initial state of the news feature.
// This state is typically used when the app starts or before any news data is loaded.
class News_initial_States extends News_States {

}

// Represents the loading state of the news feature.
// This state indicates that news data is currently being fetched or processed.
class News_Loading_States extends News_States {}

// Represents a state where news data has been successfully fetched.
// This state is typically used when the API call is successful
// and news articles are available.
class News_Success_States extends News_States {
  NewsDataModel newsDataModel;

  News_Success_States({required this.newsDataModel});
}

// Represents a state where fetching news data has failed.
// This state is used when an error occurs during the API call,
// such as a network issue or server error.
class News_Failure_States extends News_States {
  final String error;

  News_Failure_States({required this.error});
}
