import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/database_service.dart';

class Dashborad extends StatelessWidget {
  const Dashborad({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de bord"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section Résumé des dépenses
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Total des dépenses (ce mois-ci)",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder(
                      future: databaseService
                          .getTotalDepensesParMois(DateTime.now()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erreur');
                        } else {
                          return Text(
                            "${snapshot.data!.toString()} CFA",
                            style: TextStyle(fontSize: 24),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Section Graphique des dépenses par catégorie
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Répartition des dépenses par catégorie",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      FutureBuilder<List<PieChartSectionData>>(
                        future: databaseService.getDepensesParCategorie(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Erreur');
                          } else {
                            return SizedBox(
                              height: 300,
                              child: PieChart(
                                PieChartData(
                                  sections: snapshot.data,
                                  centerSpaceRadius: 50,
                                ),
                                swapAnimationDuration:
                                    Duration(milliseconds: 150), // Optional
                                swapAnimationCurve: Curves.linear,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Autres sections statistiques possibles...
          ],
        ),
      ),
    );
  }
}
