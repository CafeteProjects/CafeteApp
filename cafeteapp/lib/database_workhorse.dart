import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/menu_items.dart';
//import 'models/active.dart'; // Dein Active-Model

const String backendMenuUrl = 'http://192.168.48.155:5000/menu';
const String backendActiveUrl = 'http://192.168.48.155:5000/active';

// Prüft, ob das Backend erreichbar ist (beide Endpoints)
Future<bool> checkConnection() async {
  try {
    final responseMenu = await http.get(Uri.parse(backendMenuUrl)).timeout(Duration(seconds: 5));
    final responseActive = await http.get(Uri.parse(backendActiveUrl)).timeout(Duration(seconds: 5));

    if (responseMenu.statusCode == 200 && responseActive.statusCode == 200) {
      return true;
    } else {
      print('Server antwortet mit Statuscodes: Menu=${responseMenu.statusCode}, Active=${responseActive.statusCode}');
      return false;
    }
  } catch (e) {
    print('Fehler bei Verbindung zum Backend: $e');
    return false;
  }
}

// Menü-Daten abrufen
Future<List<MenuItem>> fetchMenu() async {
  try {
    final response = await http.get(Uri.parse(backendMenuUrl)).timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((item) => MenuItem.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Server antwortet mit Fehlercode ${response.statusCode}');
    }
  } catch (e) {
    print('Fehler beim Laden des Menüs: $e');
    throw Exception('Keine Verbindung zum Backend');
  }
}

// Active-Daten abrufen
Future<Active> fetchActive() async {
  final response = await http.get(Uri.parse('http://192.168.48.155:5000/active'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return Active.fromJson(data[0] as Map<String, dynamic>); // erstes Element der Liste
  } else {
    throw Exception('Failed to load active');
  }
}

