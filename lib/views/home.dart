import 'package:depense_pro/services/database_service.dart';
import 'package:depense_pro/views/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../components/my_details_row.dart';
import '../models/depense.dart';

const double _pagePadding = 16.0;
const double _buttonHeight = 56.0;
const double _bottomPaddingForButton = 150.0;

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

    SliverWoltModalSheetPage page1(
        BuildContext modalSheetContext, Depense depense) {
      return WoltModalSheetPage(
        hasSabGradient: false,
        stickyActionBar: Padding(
          padding: const EdgeInsets.all(_pagePadding),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: Navigator.of(modalSheetContext).pop,
                child: const SizedBox(
                  height: _buttonHeight,
                  width: double.infinity,
                  child: Center(child: Text('Cancel')),
                ),
              ),
              // const SizedBox(height: 8),
              // ElevatedButton(
              //   onPressed: WoltModalSheet.of(modalSheetContext).showNext,
              //   child: const SizedBox(
              //     height: _buttonHeight,
              //     width: double.infinity,
              //     child: Center(child: Text('Next page')),
              //   ),
              // ),
            ],
          ),
        ),
        topBarTitle: Text(
          'Details',
          style: TextStyle(fontSize: 24),
        ),
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(_pagePadding),
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(modalSheetContext).pop,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(
              _pagePadding,
              _pagePadding,
              _pagePadding,
              _bottomPaddingForButton,
            ),
            child: Column(
              children: [
                MyDetailsRow(
                  title: "Titre",
                  value: depense.titre!,
                ),
                MyDetailsRow(
                  title: "Montant",
                  value: depense.montant.toString(),
                ),
                MyDetailsRow(
                  title: "Date de Création",
                  value: depense.date!.toLocal().toString().split(' ')[0],
                ),
                MyDetailsRow(
                  title: "Description",
                  value: depense.description.toString(),
                ),
              ],
            )),
      );
    }

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
                    onTap: () {
                      WoltModalSheet.show<void>(
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            page1(modalSheetContext, depense),
                          ];
                        },
                        modalTypeBuilder: (context) =>
                            const WoltBottomSheetType(),
                        onModalDismissedWithBarrierTap: () {
                          debugPrint('Closed modal sheet with barrier tap');
                          Navigator.of(context).pop();
                        },
                      );
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
