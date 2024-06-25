import 'package:cooking/data/data_recipes.dart';
import 'package:cooking/data/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:cooking/menu_model.dart';
import 'package:cooking/menu_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final MenuService _menuService = MenuService();
  List<Menu> _menus = [];
  List<Menu> _favorites = [];
  dynamic _imageFile;
  late TabController _tabController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _htmController = TextEditingController();
  final TextEditingController _tutorialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMenus();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _fetchMenus() async {
    List<Menu> menus = await _menuService.getMenus();

    setState(() {
      _menus = menus;
    });
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      _pickImageWeb();
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    }
  }

  void _pickImageWeb() {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          _imageFile = file;
        });
      });
    });
  }

  Future<void> _addMenu({Menu? menu}) async {
    if (_nameController.text.isEmpty ||
        _htmController.text.isEmpty ||
        _tutorialController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    Menu newMenu = Menu(
      id: menu?.id ?? '',
      name: _nameController.text,
      htm: _htmController.text,
      tutorial: _tutorialController.text,
      imageUrl: '',
    );

    if (_imageFile != null) {
      String imageUrl = await _menuService.uploadImage(_imageFile);
      newMenu.imageUrl = imageUrl;
    }

    if (menu == null) {
      await _menuService.addMenu(newMenu, _imageFile);
    } else {
      await _menuService.updateMenu(newMenu, _imageFile);
    }

    _nameController.clear();
    _htmController.clear();
    _tutorialController.clear();
    setState(() {
      _imageFile = null;
    });

    await _fetchMenus(); // Wait until menus are fetched
  }

  void _showAddMenuDialog({Menu? menu}) {
    if (menu != null) {
      _nameController.text = menu.name;
      _htmController.text = menu.htm;
      _tutorialController.text = menu.tutorial;
    } else {
      _nameController.clear();
      _htmController.clear();
      _tutorialController.clear();
      setState(() {
        _imageFile = null;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(menu == null ? 'Tambah Menu' : 'Edit Menu'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _htmController,
                  decoration: InputDecoration(labelText: 'HTM'),
                ),
                TextField(
                  controller: _tutorialController,
                  decoration: InputDecoration(labelText: 'Tutorial'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: _imageFile == null
                        ? Center(child: Text('Pilih Gambar'))
                        : kIsWeb
                            ? Image.network(
                                html.Url.createObjectUrlFromBlob(_imageFile),
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _imageFile,
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addMenu(menu: menu);
              },
              child: Text(menu == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite(Menu menu) {
    setState(() {
      if (_favorites.contains(menu)) {
        _favorites.remove(menu);
      } else {
        _favorites.add(menu);
      }
    });
  }

  void _editMenu(Menu menu) {
    _nameController.text = menu.name;
    _htmController.text = menu.htm;
    _tutorialController.text = menu.tutorial;
    _imageFile = menu.imageUrl;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Menu'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _htmController,
                  decoration: InputDecoration(labelText: 'HTM'),
                ),
                TextField(
                  controller: _tutorialController,
                  decoration: InputDecoration(labelText: 'Tutorial'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: menu.imageUrl.isEmpty
                        ? Center(child: Text('Pilih Gambar'))
                        : kIsWeb
                            ? Image.network(
                                menu.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                menu.imageUrl,
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addMenu(menu: menu);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDetail(Menu menu) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(menu: menu, menuService: _menuService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cooking App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.menu_book), text: 'Menus'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: _menus.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _navigateToDetail(_menus[index]),
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: _menus[index].imageUrl.isNotEmpty
                              ? kIsWeb
                                  ? Image.network(
                                      _menus[index].imageUrl,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      _menus[index].imageUrl,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                              : Container(
                                  width: 150,
                                  height: 150,
                                  color: Colors.grey[200],
                                  child: Center(child: Text('No Image')),
                                ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _menus[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _editMenu(_menus[index]),
                                ),
                              ],
                            ),
                            Text('HTM: ${_menus[index].htm}'),
                            ClipOval(
                              child: Material(
                                color: Colors.red, // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(Icons.favorite,
                                        color:
                                            _favorites.contains(_menus[index])
                                                ? Colors.white
                                                : Colors.grey),
                                  ),
                                  onTap: () {
                                    _toggleFavorite(_menus[index]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          FavoritesScreen(
              favorites: _favorites,
              toggleFavorite: _toggleFavorite,
              menuService: _menuService),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMenuDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
