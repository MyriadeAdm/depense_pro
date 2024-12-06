import 'package:depense_pro/services/database_service.dart';
import 'package:depense_pro/views/depense/ajout_depense.dart';
import 'package:depense_pro/views/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/depense.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Fonction de recupération des depenses dans la base de données
  void recuperation() {
    context.read<DatabaseService>().recuperationDepenses();
  }

  @override
  void initState() {
    super.initState();
    recuperation();
  }

  @override
  Widget build(BuildContext context) {
    final depenseDB = context.watch<DatabaseService>();
    List<Depense> depenseActuelles = depenseDB.depensesActuelles;

    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text("Finance Pro"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Mes Dépenses"),
            Expanded(
              child: ListView.builder(
                itemCount: depenseActuelles.length,
                itemBuilder: (BuildContext context, int index) {
                  final listDepenseReverse = depenseActuelles.reversed.toList();
                  final depense = listDepenseReverse[index];

                  return ListTile(
                    title: Text(depense.titre!),
                    subtitle: Text("${depense.montant} F CFA"),
                    trailing: Text(
                      depense.date!.toLocal().toString().split(' ')[0],
                    ),
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Placeholder();
                            },
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
