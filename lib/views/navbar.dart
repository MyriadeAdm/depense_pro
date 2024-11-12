import 'package:depense_pro/views/dashboard.dart';
import 'package:flutter/material.dart';

import 'depense/ajout_depense.dart';
import 'categorie/list_categories.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Avatar"),
            accountEmail: const Text("Testmail@testmail.test"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/avatar.jpg"),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pink.shade900,
            ),
          ),
          ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text("Categories"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListCategories(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_outlined),
            title: Text("Ajouter une dépense"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AjoutDepense(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text("Budgetisation"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.analytics_outlined),
            title: Text("Statistiques"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Dashborad(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_card_outlined),
            title: Text("Gestion de dettes"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
