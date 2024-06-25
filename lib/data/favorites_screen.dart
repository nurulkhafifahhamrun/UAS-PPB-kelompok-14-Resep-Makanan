import 'package:cooking/data/data_recipes.dart';
import 'package:flutter/material.dart';
import 'package:cooking/menu_model.dart';
import 'package:cooking/menu_service.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Menu> favorites;
  final Function(Menu) toggleFavorite;
  final MenuService menuService;

  FavoritesScreen({
    required this.favorites,
    required this.toggleFavorite,
    required this.menuService,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                    menu: favorites[index], menuService: menuService),
              ),
            );
          },
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      favorites[index].imageUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favorites[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text('HTM: ${favorites[index].htm}'),
                      ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.red, // inkwell color
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(Icons.favorite, color: Colors.white),
                            ),
                            onTap: () {
                              toggleFavorite(favorites[index]);
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
    );
  }
}
