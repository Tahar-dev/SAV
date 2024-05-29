import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

class CartPage4 extends StatelessWidget {
  const CartPage4({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          // Données de fournisseurs fictives
          List<Map<String, String>> fournisseurs = [
            {'fournisseur': 'Fournisseur 1', 'specialite': 'Spécialité 1', 'gsm': '123456789'},
            {'fournisseur': 'Fournisseur 2', 'specialite': 'Spécialité 2', 'gsm': '987654321'},
          ];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Fournisseurs",
                  style: GoogleFonts.notoSerif(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Tableau de fournisseurs
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: fournisseurs.length + 1, // +1 pour l'en-tête
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // En-tête
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(child: Center(child: Text('N°'))),
                                Expanded(child: Center(child: Text('Fournisseurs'))),
                                Expanded(child: Center(child: Text('Numéro GSM'))),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Récupérer les données du fournisseur
                        Map<String, String> fournisseur = fournisseurs[index - 1];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(child: Center(child: Text(index.toString()))),
                                Expanded(child: Center(child: Text(fournisseur['fournisseur']!))),
                                Expanded(child: Center(child: Text(fournisseur['gsm']!))),
                              ],
                            ),
                        
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
