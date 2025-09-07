
Erstelle eine Liste mit Dictionaries basierend auf der Auswertung der Datenbank.

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['itemname'],
      price: json['price'].toDouble(),
    );
  }
}

