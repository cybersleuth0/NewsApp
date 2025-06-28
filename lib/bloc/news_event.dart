abstract class NewsEvents {}

class GetCarouselNewsEvent extends NewsEvents {}

class GetNewsByCategoryEvent extends NewsEvents {
  final String category;

  GetNewsByCategoryEvent({required this.category});
}