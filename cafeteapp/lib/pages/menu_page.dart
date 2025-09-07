import 'package:flutter/material.dart';
import '/database_workhorse.dart';
import '/models/menu_items.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<List<MenuItem>> menuItems;

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  // Verbindung prüfen und Menü laden
  void _loadMenu() async {
    bool connected = await checkConnection();
    if (connected) {
      setState(() {
        menuItems = fetchMenu();
      });
    } else {
      setState(() {
        menuItems = Future.error('Keine Verbindung zum Backend');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Baseline(
          baseline: 30, // Pixelhöhe anpassen, damit Text richtig sitzt
          baselineType: TextBaseline.alphabetic,
          child: const Text('Menu',
              style: TextStyle(
                fontFamily: 'italian',
                color: Colors.black,
              )),
        )),
        backgroundColor: Color(0xFF4B3621),
      ),
      body: Container(
        color: Color(0xFFEDE0C8),
        child: FutureBuilder<List<MenuItem>>(
          future: menuItems,
          builder: (context, snapshot) {
            // Ladezustand
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // Fehleranzeige
            else if (snapshot.hasError) {
              return Center(
                child: Text('Fehler: ${snapshot.error}'),
              );
            }
            // Keine Daten vorhanden
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Keine Menüeinträge vorhanden'));
            }
            // Daten sind vorhanden → nach Kategorie gruppieren
            else {
              final items = snapshot.data!;
        
              // Items nach Kategorie gruppieren
              Map<String, List<MenuItem>> groupedItems = {};
              for (var item in items) {
                groupedItems.putIfAbsent(item.category, () => []).add(item);
              }
        
              // ListView bauen
              return ListView(
                children: groupedItems.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          entry.key, // Kategorie-Name
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...entry.value.map((item) => Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 3,
                        color: Color(0xFF4B3621),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.name, style: TextStyle(fontSize: 18)),
                              Text("${item.price.toStringAsFixed(2)} €", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )),
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
