import 'package:depense_pro/models/depense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/categorie.dart';

class DatabaseService extends ChangeNotifier {
  static late Isar isar;

  // Initialisation de la base de données
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [DepenseSchema, CategorieSchema],
      directory: dir.path,
    );

    // Vérification si c'est le premier lancement de l'application
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await insertDefaultCategories;
      await prefs.setBool('isFirstLaunch', false);
    }
  }

  // Listes des dépenses
  final List<Depense> depensesActuelles = [];
  // Listes des categories
  final List<Categorie> categoriesActuelles = [];

  // Création d'une dépense et sauvegarde dans la base de données
  Future<void> ajoutDepense(Depense depense) async {
    // Sauvegarde dans la base de données
    await isar.writeTxn(() => isar.depenses.put(depense));

    // Récuperation de la base de données
    recuperationDepenses();
  }

  // Lecture des depenses de la base de donnees
  Future<void> recuperationDepenses() async {
    List<Depense> depenseRecuperer = await isar.depenses.where().findAll();
    depensesActuelles.clear();
    depensesActuelles.addAll(depenseRecuperer);
    notifyListeners();
  }

  // Création d'une categorie et sauvegarde dans la base de données
  Future<void> ajoutCategorie(Categorie categorie) async {
    // Sauvegarde dans la base de données
    await isar.writeTxn(() => isar.categories.put(categorie));

    // Récuperation de la base de données
    recuperationCategories();
  }

  // Lecture des categories de la base de donnees
  Future<void> recuperationCategories() async {
    List<Categorie> categorieRecuperer =
        await isar.categories.where().findAll();
    categoriesActuelles.clear();
    categoriesActuelles.addAll(categorieRecuperer);
    notifyListeners();
  }

  // Suppression d'une dépense de la base de données
  Future<void> supprimerDepense(int itemId) async {
    final item = await isar.depenses.get(itemId);
    if (item != null) {
      await isar.writeTxn(
        () async {
          await isar.depenses.delete(itemId);
        },
      );
    }
    await recuperationDepenses();
    notifyListeners();
  }

  // Suppression de toutes les dépenses de la base de données
  Future<void> suppressionDepenses() async {
    final List<Depense> items = await isar.depenses.where().findAll();
    await isar.writeTxn(
      () async {
        for (var item in items) {
          await isar.depenses.delete(item.id);
        }
      },
    );
    await recuperationDepenses();
    notifyListeners();
  }

  // Suppression d'une categorie de la base de données
  Future<void> suppressionCategorie(int itemId) async {
    final item = await isar.categories.get(itemId);
    if (item != null) {
      await isar.writeTxn(
        () async {
          await isar.categories.delete(itemId);
        },
      );
    }
    await recuperationCategories();
    notifyListeners();
  }

  static Future<void> get insertDefaultCategories async {
    final defaultCategories = [
      Categorie()
        ..nom = 'Food'
        ..icon = '🍔',
      Categorie()
        ..nom = 'Transport'
        ..icon = '🚗',
      Categorie()
        ..nom = 'Shopping'
        ..icon = '🛍️',
      Categorie()
        ..nom = 'Bills'
        ..icon = '💡',
    ];

    await isar.writeTxn(() async {
      var catList = await isar.categories.where().findAll();
      for (var category in catList) {
        await isar.categories.delete(category.id);
      }
      await isar.categories.putAll(defaultCategories);
    });
  }

  Future<List<Categorie>> getAllCategories() async {
    return await isar.categories.where().findAll();
  }

  // Fonction pour obtenir les dépenses totales pour un mois
  Future<int> getTotalDepensesParMois(DateTime mois) async {
    int total = 0;
    final List<Depense> items = await isar.depenses
        .filter()
        .dateGreaterThan(DateTime(mois.year, mois.month, 1))
        .dateLessThan(DateTime(mois.year, mois.month + 1, 1))
        .findAll();

    for (var element in items) {
      total += element.montant!;
    }

    return total;
  }

  Future<List<PieChartSectionData>> getDepensesParCategorie() async {
    final depenses = await isar.depenses.where().findAll();

    Map<String, int> depensesParCategorie = {};

    for (var depense in depenses) {
      final int idCategorie = depense.idCategorie!;
      final int montant = depense.montant!;

      final categorie = await isar.categories.get(idCategorie);

      depensesParCategorie.update(
        categorie!.nom!,
        (valeurExistante) => valeurExistante + montant,
        ifAbsent: () => montant,
      );
    }

    // Palette de couleurs pour chaque catégorie
    final List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple
    ];

    int colorIndex = 0;

    return depensesParCategorie.entries.map((categorie) {
      return PieChartSectionData(
        color: colors[colorIndex++ % colors.length],
        value: categorie.value.toDouble(),
        title: "${categorie.key} : ${categorie.value} CFA",
        radius: 70,
      );
    }).toList();
  }
}
