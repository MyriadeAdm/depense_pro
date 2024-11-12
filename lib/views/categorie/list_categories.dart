import 'package:depense_pro/models/categorie.dart';
import 'package:depense_pro/views/categorie/ajout_categorie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database_service.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({super.key});

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
// Fonction de recupération des depenses dans la base de données
  void recuperation() {
    context.read<DatabaseService>().recuperationCategories();
  }

  @override
  void initState() {
    super.initState();
    recuperation();
  }

  @override
  Widget build(BuildContext context) {
    final categorieDB = context.watch<DatabaseService>();
    List<Categorie> categories = categorieDB.categoriesActuelles;

    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des catégories"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var item = categories[index];
                    return ListTile(
                      title: Text("${item.icon} ${item.nom}"),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Confirmer",
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Annuler'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Supprimer'),
                                    onPressed: () {
                                      categorieDB.suppressionCategorie(item.id);
                                      // TODO Afficher le message lui indiquant que toutes les depenses ratachés à la categorie partiront
                                      //supprimer tout es qui est en rapport avec la categorie
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade800,
                        ),
                        color: Colors.red.shade800,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AjoutCategorie(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
