import 'package:cooking/menu_model.dart';
import 'package:cooking/menu_service.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Menu menu;
  final MenuService menuService;

  DetailScreen({required this.menu, required this.menuService});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Menu'),
        content: Text('Anda yakin ingin menghapus ${menu.name}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _deleteMenu(context);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteMenu(BuildContext context) async {
    try {
      await menuService
          .deleteMenu(menu.id); // Panggil fungsi deleteMenu dari MenuService
      Navigator.of(context)
          .pop(); // Tutup halaman DetailScreen setelah berhasil menghapus
    } catch (e) {
      // Handle error jika terjadi
      print('Error deleting menu: $e');
      // Tampilkan snackbar atau pesan error kepada pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus menu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(menu.imageUrl, fit: BoxFit.cover),
              SizedBox(height: 16),
              Text(
                menu.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blueAccent,
                ),
              ),
              Text('HTM: ${menu.htm}'),
              SizedBox(height: 16),
              Text(
                menu.tutorial,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
