import 'package:depense_pro/components/my_drawer_list_tile.dart';
import 'package:depense_pro/views/dashboard.dart';
import 'package:flutter/material.dart';

import 'depense/ajout_depense.dart';
import 'categorie/list_categories.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  void pushPage(BuildContext ctx, Widget page) async {
    await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 100)),
          MyDrawerListTile(
            title: "Accueil",
            onTap: () => Navigator.pop(context),
            icon: Icons.home,
          ),
          MyDrawerListTile(
            title: "Catégories",
            onTap: () => pushPage(context, ListCategories()),
            icon: Icons.carpenter_outlined,
          ),
          MyDrawerListTile(
            title: "Ajouter une dépense",
            onTap: () => pushPage(context, AjoutDepense()),
            icon: Icons.account_balance_outlined,
          ),
          MyDrawerListTile(
            title: "Budgetisation",
            onTap: () => pushPage(context, Placeholder()),
            icon: Icons.monetization_on,
          ),
          MyDrawerListTile(
            title: "Statistiques",
            onTap: () => pushPage(context, Dashboard()),
            icon: Icons.analytics_outlined,
          ),
          MyDrawerListTile(
            title: "Gestion de dettes",
            onTap: () => pushPage(context, Placeholder()),
            icon: Icons.add_card_rounded,
          ),
        ],
      ),
    );
  }
}
