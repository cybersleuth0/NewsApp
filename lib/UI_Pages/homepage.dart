import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/bloc/news_bloc.dart';
import 'package:news_api/bloc/news_event.dart';
import 'package:news_api/bloc/news_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _homepageState();
}

class _homepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<News_Bloc>().add(GetCarouselNewsEvent());
  }

  String _selectedCategory = "business";
  final List<String> newsCategorys = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<ImageProvider> _getImageProvider(String? imageUrl) async {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final response = await http.head(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          return NetworkImage(imageUrl);
        }
      } catch (e) {}
    }
    return NetworkImage(
      "https://as1.ftcdn.net/v2/jpg/03/27/55/60/1000_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          elevation: 2,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 600 ? 8.0 : 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: screenWidth < 600 ? 1 : 0,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth < 600 ? 0 : 8.0),
                    child: ClipOval(
                      child: Image(
                        width: screenWidth < 600 ? 45 : 55,
                        height: screenWidth < 600 ? 45 : 55,
                        image: AssetImage("Assets/Images/boy_3d_image.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Morning\n',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 15 : 17,
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                        TextSpan(
                          text: 'Ayush',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 19 : 22,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth < 600 ? 5 : 10),
                Container(
                  padding: EdgeInsets.all(screenWidth < 600 ? 6 : 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF2C2C2C),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    size: screenWidth < 600 ? 26 : 30,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF121212),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 12.0 : 20.0,
          vertical: 10.0,
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF2C2C2C),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Let's see what's happening in the world",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      if (_searchController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Please enter a search term.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      } else {
                        context.read<News_Bloc>().add(
                          GetNewsBySearchEvent(query: _searchController.text),
                        );
                        _searchController.clear();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.search,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Breaking News section with "See all" link.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Breaking News !",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Horizontal list of news articles.
            // This section displays breaking news articles in a horizontal carousel.
            SizedBox(
              height: MediaQuery.of(context).size.width < 600
                  ? MediaQuery.of(context).size.height *
                        0.2 // Mobile
                  : MediaQuery.of(context).size.height * 0.4, // Web
              child: BlocBuilder<News_Bloc, News_States>(
                builder: (context, state) {
                  if (state is News_Loading_States) {
                    // Shimmer effect for loading state
                    return CarouselSlider.builder(
                      itemCount: 3, // Number of shimmer items
                      itemBuilder: (
                        BuildContext context,
                        int itemIndex,
                        int pageViewIndex,
                      ) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[500]!,
                          child: Container(
                            width: MediaQuery.of(context).size.width < 600
                                ? screenWidth * 0.8 // Mobile
                                : screenWidth * 0.4, // Web
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.height * 0.2 // Mobile
                            : MediaQuery.of(context).size.height * 0.4, // Web
                        enlargeCenterPage: true,
                        autoPlay: false, // Disable autoplay during shimmer
                      ),
                    );
                  }
                  if (state is News_Failure_States) {
                    return Center(child: Text(state.error));
                  }
                  if (state is News_Success_States) {
                    var snap = state.newsDataModel;
                    return CarouselSlider.builder(
                      itemCount: snap.articles.length,
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) {
                            var article = snap.articles[itemIndex];
                            return InkWell(
                              onTap: () async {
                                if (article.url != null) {
                                  try {
                                    final Uri url = Uri.parse(article.url!);
                                    if (!await launchUrl(
                                      url,
                                      mode: LaunchMode.inAppBrowserView,
                                    )) {}
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Error: Could not launch URL. Please ensure you have a browser installed and try again.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width < 600
                                      ? screenWidth *
                                            0.8 // Mobile
                                      : screenWidth * 0.4, // Web
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image:
                                          (article.urlToImage != null &&
                                              article.urlToImage!.isNotEmpty)
                                          ? NetworkImage(
                                              article.urlToImage!,
                                              scale: 1.0,
                                            )
                                          : AssetImage(
                                              "Assets/Images/Breaking-news.jpg",
                                            ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withOpacity(0.7),
                                              Colors.black.withOpacity(0.3),
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                              blurRadius: 8.0,
                                              spreadRadius: 2.0,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          article.title ?? "No Title",
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 6.0,
                                                color: Colors.black.withOpacity(
                                                  0.7,
                                                ),
                                                offset: Offset(2.0, 2.0),
                                              ),
                                            ],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.height *
                                  0.2 // Mobile
                            : MediaQuery.of(context).size.height * 0.4, // Web
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(height: 20),
            // Trending News section with "See all" link.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Right now",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // News category tabs.
            // This section displays news categories as tabs.
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: newsCategorys.map((category) {
                  bool isSelected = category == _selectedCategory;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                          context.read<News_Bloc>().add(
                            GetNewsByCategoryEvent(category: category),
                          );
                        });
                      },
                      child: Chip(
                        side: BorderSide(
                          width: 1,
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.grey[700]!,
                        ),
                        backgroundColor: isSelected
                            ? Colors.blueAccent
                            : Color(0xFF2C2C2C),
                        label: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.grey[300],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Vertical list of news articles.
            // This section displays news articles based on the selected category in a vertical list.
            BlocBuilder<News_Bloc, News_States>(
              builder: (context, state) {
                if (state is News_Loading_States) {
                  // Shimmer effect for loading state in vertical list
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(), // Disable scroll during shimmer
                    shrinkWrap: true,
                    itemCount: 5, // Number of shimmer items
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is News_Failure_States) {
                  return Center(child: Text(state.error));
                }
                if (state is News_Success_States) {
                  var articles = state.newsDataModel.articles;
                  if (articles.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("No articles found for this category."),
                    );
                  }
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length > 10 ? 10 : articles.length,
                    itemBuilder: (context, index) {
                      var article = articles[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF2C2C2C),
                            border: Border.all(
                              color: Colors.grey.shade700,
                            ), // Darker border
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  child: FutureBuilder<ImageProvider>(
                                    future: _getImageProvider(
                                      article.urlToImage,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[700]!,
                                          highlightColor: Colors.grey[500]!,
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        return Image(
                                          image: snapshot.data!,
                                          fit: BoxFit.cover,
                                          height: 120,
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? "No Title Available",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        article.description ??
                                            "No Description Available",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          article.publishedAt?.substring(
                                                0,
                                                10,
                                              ) ??
                                              "No Date",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
