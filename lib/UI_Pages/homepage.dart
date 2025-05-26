import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/bloc/news_bloc.dart';
import 'package:news_api/bloc/news_event.dart';
import 'package:news_api/bloc/news_state.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _homepageState();
}

class _homepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<News_Bloc>().add(GetNews_Event());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(
              height: 300,
              child: BlocBuilder<News_Bloc, News_States>(
                  builder: (context, state) {
                    if (state is News_Loading_States) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is News_Failure_States) {
                      return Center(child: Text(state.error));
                    }
                    if (state is News_Success_States) {
                      return ListView.builder(
                          itemCount: state.sourceDataModel.articles.length,
                          itemBuilder: (_, index) {
                            return Container();
                          }
                      );
                    }
                    return Container();
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
