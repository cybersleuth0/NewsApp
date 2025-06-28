import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/bloc/news_bloc.dart';
import 'package:news_api/bloc/news_event.dart';
import 'package:news_api/bloc/news_state.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String _selectedCategory = "All";
  final List<String> newsCategorys = [
    "All",
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipOval(
                    child: Image(
                      width: 50,
                      height: 50,
                      image: AssetImage("Assets/Images/boy_3d_image.jpg"),
                      fit: BoxFit.cover, // Ensures the image fills the circle
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
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: Colors.grey[600],
                          ),
                        ),
                        TextSpan(
                          text: 'Ayush',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.notifications_none, size: 28),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Search bar container with light grey background and subtle shadow.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xfff8f8f8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Center(child: Icon(Icons.search, size: 24)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Let's see what's happening in the world",
                        border: InputBorder.none,
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
              height: 230,
              child: BlocBuilder<News_Bloc, News_States>(
                builder: (context, state) {
                  if (state is News_Loading_States) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is News_Failure_States) {
                    return Center(child: Text(state.error));
                  }
                  if (state is News_Success_States) {
                    var snap = state.newsDataModel;
                    return CarouselSlider.builder(
                      itemCount: snap.articles.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        var article = snap.articles[itemIndex];
                        return InkWell(
                          onTap: () async {
                            if (article.url != null) {
                              try {
                                final Uri url = Uri.parse(article.url!);
                                if (!await launchUrl(url,
                                    mode: LaunchMode.inAppBrowserView)) {}
                              } catch (e) {
                                // print("Error launching URL: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      'Error: Could not launch URL. Please ensure you have a browser installed and try again.')),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 320,
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
                                  image: (article.urlToImage != null &&
                                      article.urlToImage!.isNotEmpty)
                                      ? NetworkImage(article.urlToImage!,
                                      scale: 1.0)
                                      : AssetImage(
                                      "Assets/Images/placeholder_image.png")
                                  ,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient( // Added gradient background
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.black.withOpacity(0.3)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      // Slightly more rounded corners
                                      boxShadow: [
                                        // Enhanced shadow for better depth
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.5),
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
                                          Shadow(blurRadius: 6.0,
                                              color: Colors.black
                                                  .withOpacity(0.7),
                                              offset: Offset(2.0, 2.0))
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
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: false,
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
                              GetNewsByCategoryEvent(category: category));
                        });
                      },
                      child: Chip(
                        side: BorderSide(width: 1,
                            color: isSelected ? Colors.white : Colors
                                .grey),
                        backgroundColor: isSelected ? Colors.blueAccent : Colors
                            .transparent,
                        label: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors
                                .black87,
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
            Expanded(
              child: BlocBuilder<News_Bloc, News_States>(
                builder: (context, state) {
                  if (state is News_Loading_States) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is News_Failure_States) {
                    return Center(child: Text(state.error));
                  }
                  if (state is News_Success_States) {
                    var articles = state.newsDataModel.articles;
                    if (articles.isEmpty) {
                      return Center(
                          child: Text("No articles found for this category."));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        var article = articles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
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
                                      child: Image(
                                        image: (article.urlToImage != null &&
                                            article.urlToImage!.isNotEmpty)
                                            ? NetworkImage(article.urlToImage!)
                                            : AssetImage(
                                            "Assets/Images/placeholder_image.png") as ImageProvider,
                                        fit: BoxFit.cover,
                                        height: 120,
                                      ),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(article.title ??
                                                "No Title Available",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87)),
                                            SizedBox(height: 8),
                                            Text(
                                              article.description ??
                                                  "No Description Available",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.grey[700]),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,),
                                            SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                article.publishedAt?.substring(
                                                    0, 10) ?? "No Date",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey),),
                                            )
                                          ]),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container(); // Default empty container
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
