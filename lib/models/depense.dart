import 'package:depense_pro/models/categorie.dart';
import 'package:isar/isar.dart';

part 'depense.g.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
@collection
class Depense {
  Id id = Isar.autoIncrement;

  String? titre;

  String? description;

  int? montant;

  DateTime? date;

  int? idCategorie;

  @Ignore()
  Categorie? categorie;

  Depense(
      this.titre, this.description, this.montant, this.date, this.idCategorie);
}
