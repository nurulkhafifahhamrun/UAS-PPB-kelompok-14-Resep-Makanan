import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String id;
  String name;
  String htm;
  String tutorial;
  String imageUrl;

  Menu(
      {required this.id,
      required this.name,
      required this.htm,
      required this.tutorial,
      required this.imageUrl});

  // Factory method untuk membuat objek Menu dari data snapshot Firestore
  factory Menu.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Menu(
      id: doc.id,
      name: data['name'],
      htm: data['htm'],
      tutorial: data['tutorial'],
      imageUrl: data['imageUrl'],
    );
  }
}
