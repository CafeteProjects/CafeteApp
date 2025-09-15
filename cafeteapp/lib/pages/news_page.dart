import 'package:flutter/material.dart';
import '../models/menu_items.dart';
import 'menu_page.dart';
import 'news_page.dart';
import '/models/opening_hours_model.dart';
import '/database_workhorse.dart';
import '/models/italian_font.dart';


class Test extends StatefulWidget {

  //Todo : News aus der Datenbank holen, an Customwidget übergeben
  @override
  _State createState() => _State();
}

class _State extends State<Test> {

  final List<String> entries = <String> ["News der Woche"];
  late List<News> listnews = [];
  @override
  void initState() {
    super.initState();
    loadNews();
  }

  void loadNews() async {
    try {
      final fetchedNews = await fetchNews();
      setState(() {
        listnews = fetchedNews;
      });
    } catch (e) {
      print('Fehler beim Laden der News: $e');
    }
    if (listnews.isEmpty) {
      print('Die Liste ist leer');
    } else {
      print('Die Liste enthält ${listnews.length} Einträge');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Baseline(
            baseline: 30,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              'News',
              style: TextStyle(
                fontSize: 28,         // groß
                fontWeight: FontWeight.bold, // fett
                color: Colors.white,  // weiß
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF4B3621),
      ),
      body:  Container(
        color: Colors.brown,
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: listnews.length,
            itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          title: Center(child: Text(listnews[index].title!, style: TextStyle(color: Colors.white,)),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
              ),
          subtitle: Center(child: Text(listnews[index].formattedDate, style: TextStyle(color: Colors.white,)),),
          collapsedBackgroundColor: Color(0xFF4B3621),
          backgroundColor: Color(0xFF4B3621),
          textColor: Colors.white,
          children: <Widget>[Container(
              color: Color(0xFFEDE0C8),
              child: ListTile(title:
              Text(listnews[index].news!,)))],
        );
            }
            ),
      )
    );
}
}

