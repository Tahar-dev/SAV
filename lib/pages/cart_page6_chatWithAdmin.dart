import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage6 extends StatelessWidget {
  const CartPage6({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        title: Text(
          "Contacter Admin",
          style: GoogleFonts.notoSerif(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // Message de l'admin
                _buildAdminMessage("Bien bon l'intervention, merci !"),

                // Message de l'utilisateur
                _buildUserMessage("Merci, je suis content que tout soit bien fait."),

                // Autre message de l'admin
                _buildAdminMessage("Bravo ! Continuez comme ça."),
              ],
            ),
          ),

          // Zone de saisie pour envoyer un message
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Widget pour construire un message de l'admin
  Widget _buildAdminMessage(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Widget pour construire un message de l'utilisateur
  Widget _buildUserMessage(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Widget pour construire la zone de saisie de message
  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Écrire un message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
