import 'package:depense_pro/models/categorie.dart';
import 'package:depense_pro/services/database_service.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../models/depense.dart';

class AjoutDepense extends StatefulWidget {
  const AjoutDepense({super.key});

  @override
  State<AjoutDepense> createState() => _AjoutDepenseState();
}

class _AjoutDepenseState extends State<AjoutDepense> {
  final _formKey = GlobalKey<FormState>();
  String _titre = '';
  String _description = "";
  int _montant = 0;
  DateTime _dateSelectionne = DateTime.now();
  int? _categorieSelectionne;

  // void _pickDate() async {
  //   final pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  //   if (pickedDate != null && pickedDate != _dateSelectionne) {
  //     setState(() {
  //       _dateSelectionne = pickedDate;
  //     });
  //   }
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_categorieSelectionne != null) {
        final nouvelDepense = Depense(
          _titre,
          _description,
          _montant,
          _dateSelectionne,
          _categorieSelectionne,
        );

        // Utiliser le ViewModel pour ajouter la dépense
        Provider.of<DatabaseService>(context, listen: false)
            .ajoutDepense(nouvelDepense);

        // Retourner à l'écran précédent
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Ajout d'une dépense"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Categorie>>(
            future: Provider.of<DatabaseService>(context).getAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Erreur de récupération des catégories'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Aucune catégorie disponible'));
              } else {
                List<Categorie> categories = snapshot.data!;

<<<<<<< HEAD
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Titre',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.3)),
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrer un titre';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _titre = value!;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Montant',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.3)),
                              borderSide: BorderSide(color: Colors.black))),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value) == null ||
                            int.parse(value) <= 0) {
                          return 'Entrer un montant valide';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _montant = int.parse(value!);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Row(
                    //   children: [
                    //     Text(
                    //         'Date: ${_dateSelectionne.toLocal().toString().split(' ')[0]}'),
                    //     TextButton(
                    //       onPressed: _pickDate,
                    //       child: const Text('Sélectionner une date'),
                    //     ),
                    //   ],
                    // ),
=======
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Titre'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrer un titre';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _titre = value!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Montant'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return 'Entrer un montant valide';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _montant = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Row(
                      //   children: [
                      //     Text(
                      //         'Date: ${_dateSelectionne.toLocal().toString().split(' ')[0]}'),
                      //     TextButton(
                      //       onPressed: _pickDate,
                      //       child: const Text('Sélectionner une date'),
                      //     ),
                      //   ],
                      // ),
>>>>>>> 5cfe9c82051b01489a684ff88dcee1383889eb15

                      EasyDateTimeLine(
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {
                          _dateSelectionne = selectedDate;
                        },
                        // activeColor: const Color(0xffB04759),
                        locale: "fr",
                      ),

<<<<<<< HEAD
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: 'Catégorie',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.3)),
                              borderSide: BorderSide(color: Colors.black))),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id.toString(),
                          child: Text('${category.icon} ${category.nom}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _categorieSelectionne = int.parse(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sélectionner une catégorie';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.3)),
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrer une description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                    const SizedBox(height: 32.0),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.black),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.5),
                                  ))),
                              onPressed: () {
                                if (_dateSelectionne.compareTo(DateTime.now()) >
                                    0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "La date séléctionné est superieur à la date du jour")));
                                  // print("DT1 is after DT2");
                                } else {
                                  _submitForm();
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Enregistré'),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              },
                              child: const Text(
                                'Ajouter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.5),
                              ))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Annuler',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
=======
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Catégorie'),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text('${category.icon} ${category.nom}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _categorieSelectionne = int.parse(value!);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sélectionner une catégorie';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrer une description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
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
                );
              }
            },
          ),
>>>>>>> 5cfe9c82051b01489a684ff88dcee1383889eb15
        ),
      ),
    );
  }
}
