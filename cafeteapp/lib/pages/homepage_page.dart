import 'package:flutter/material.dart';
import '../models/menu_items.dart';
import 'menu_page.dart';
import 'news_page.dart';
import '/models/opening_hours_model.dart';
import '/database_workhorse.dart';
import '/models/italian_font.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Active> activeFuture;

  @override
  void initState() {
    super.initState();
    activeFuture = fetchActive();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> openState = ["Currently closed", "Currently open"];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Baseline(
            baseline: 30,
            baselineType: TextBaseline.alphabetic,
            child: const Text(
              'Cafete',
              style: TextStyle(
                fontFamily: 'italian',
                color: Colors.black,
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF4B3621),
      ),
      body: Stack(
        children: [
          // Hintergrundbild
          Image.asset(
            "assets/images/coffee.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Overlay für Buttons und Statusanzeige
          FutureBuilder<Active>(
            future: activeFuture,
            builder: (context, snapshot) {
              int activeIndex = 0; // Default: geschlossen
              if (snapshot.hasData) {
                activeIndex = snapshot.data!.active ? 1 : 0;
              }

              return Align(
                alignment: const Alignment(0, -0.4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Status-Text
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B3621).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: BaselineText(text: openState[activeIndex],)
                    ),
                    const SizedBox(height: 40),

                    // Menu Button
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MenuPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B3621),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: BaselineText(text: 'Menu')
                      ),
                    ),
                    const SizedBox(height: 30),

                    // News Button
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print("News gedrückt");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B3621),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: BaselineText(text: 'News')
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // OpeningHoursBox unten links
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: OpeningHoursBox(),
            ),
          ),
        ],
      ),
    );
  }
}
