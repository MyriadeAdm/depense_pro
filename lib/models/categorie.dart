import 'package:isar/isar.dart';

part 'categorie.g.dart';

@collection
class Categorie {
  Id id = Isar.autoIncrement; // Auto-génération de l'ID

  String? nom;
  String? icon;

  Categorie({this.nom, this.icon});
}
