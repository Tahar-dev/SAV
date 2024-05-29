import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

class CartPage5 extends StatelessWidget {
  const CartPage5({super.key});

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
          // Données aléatoires pour le tableau
          List<Map<String, String>> interventions = [
            {'intervention': 'Intervention 1', 'date': '2024-04-30'},
            {'intervention': 'Intervention 2', 'date': '2024-05-01'},
          ];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "liste d'intervention à servir",
                  style: GoogleFonts.notoSerif(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Tableau d'interventions
              SizedBox(
                height: 200, // Hauteur du tableau
                child: ListView.builder(
                  itemCount: interventions.length + 1, // +1 pour la ligne d'en-tête
                  itemBuilder: (context, index) {
                    // Ligne d'en-tête
                    if (index == 0) {
                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(child: Center(child: Text('N°'))),
                            Expanded(child: Center(child: Text('Intervention'))),
                            Expanded(child: Center(child: Text('Date'))),
                          ],
                        ),
                      );
                    }

                    // Données de la ligne
                    Map<String, String> intervention = interventions[index - 1];
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Center(child: Text(index.toString()))),
                          Expanded(child: Center(child: Text(intervention['intervention']!))),
                          Expanded(child: Center(child: Text(intervention['date']!))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
