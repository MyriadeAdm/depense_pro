import 'package:depense_pro/models/categorie.dart';
import 'package:depense_pro/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjoutCategorie extends StatefulWidget {
  const AjoutCategorie({super.key});

  @override
  State<AjoutCategorie> createState() => _AjoutCategorieState();
}

class _AjoutCategorieState extends State<AjoutCategorie> {
  final _formKey = GlobalKey<FormState>();
  String _nom = "";
  String _icon = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final nouvelCategorie = Categorie(nom: _nom, icon: _icon);

      // Utiliser le ViewModel pour ajouter la categorie
      Provider.of<DatabaseService>(context, listen: false)
          .ajoutCategorie(nouvelCategorie);

      // Retourner à l'écran précédent
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout de catégorie"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.3)),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Nom de la catégorie',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrer un nom';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _nom = newValue!;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.3)),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Icône de la catégorie',
                  hintText: 'Entrez un emoji',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Choississez une icône';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _icon = newValue!;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enregistré'),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: const Text('Ajouter'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Annuler'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
