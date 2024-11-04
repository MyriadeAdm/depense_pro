import 'package:isar/isar.dart';

part 'dette.g.dart';

@collection
class Dette {
  Id id = Isar.autoIncrement;

  String? nom;
  int? montant;

  Dette(this.nom, this.montant);
}
