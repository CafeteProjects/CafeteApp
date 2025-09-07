//Weiterverarbeitung der erhaltenen Daten
import '/database_workhorse.dart';

class MenuItem {
  final String name;
  final double price;
  final String category; // neue Kategorie

  MenuItem({required this.name, required this.price, required this.category});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['itemname'] ?? 'Unbekannt',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
      category: json['category'] ?? 'Sonstiges',
    );
  }
}
class Active {
  final bool active;

  Active({required this.active});

  factory Active.fromJson(Map<String, dynamic> json) {
    final dynamic rawValue = json['active'];
    int value;

    if (rawValue is int) {
      value = rawValue;
    } else if (rawValue is bool) {
      value = rawValue ? 1 : 0;
    } else if (rawValue is String) {
      value = int.tryParse(rawValue) ?? 0;
    } else {
      value = 0;
    }

    return Active(active: value == 1);
  }
}
