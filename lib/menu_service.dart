import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'menu_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class MenuService {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addMenu(Menu menu, dynamic imageFile) async {
    String imageUrl = await uploadImage(imageFile);

    await _menuCollection.add({
      'name': menu.name,
      'htm': menu.htm,
      'tutorial': menu.tutorial,
      'imageUrl': imageUrl,
    });
  }

  Future<List<Menu>> getMenus() async {
    QuerySnapshot querySnapshot = await _menuCollection.get();
    return querySnapshot.docs.map((doc) => Menu.fromFirestore(doc)).toList();
  }

  Future<void> updateMenu(Menu menu, dynamic newImageFile) async {
    if (newImageFile != null) {
      String imageUrl = await uploadImage(newImageFile);
      menu.imageUrl = imageUrl;
    }

    await _menuCollection.doc(menu.id).update({
      'name': menu.name,
      'htm': menu.htm,
      'tutorial': menu.tutorial,
      'imageUrl': menu.imageUrl,
    });
  }

  Future<void> deleteMenu(String menuId) async {
    await _menuCollection.doc(menuId).delete();
  }

  Future<String> uploadImage(dynamic imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storage.ref().child('menu_images/$fileName.jpg');

    try {
      if (kIsWeb) {
        // Platform Web: Menggunakan putBlob
        final blob = html.Blob([imageFile]);
        UploadTask uploadTask = reference.putBlob(blob);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      } else {
        // Platform Mobile: Menggunakan putFile
        UploadTask uploadTask = reference.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading image: $e');
      return ''; // Atau handle error sesuai kebutuhan
    }
  }
}
