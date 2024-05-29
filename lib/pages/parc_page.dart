import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:srasav/pages/cart_page3_historic_itv.dart';
import 'package:srasav/pages/invoice_design.dart';
import 'file_handle_api.dart';
import 'pdf_invoice_api.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_invoice_api.dart';
import 'package:srasav/pages/pdf_invoice_api.dart';

// ignore: camel_case_types
class parcPage extends StatefulWidget {
  const parcPage({super.key});

  @override
  State<parcPage> createState() => _parcPageState();
}

// ignore: camel_case_types
class _parcPageState extends State<parcPage> {
  PdfColor themeColor = PdfColors.black; // Valeur par défaut
  pw.Font font = pw.Font.courier(); // Valeur par défaut
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    PdfInvoiceApi.startTimer(); // Start the stopwatch when the page is opened
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _textController.dispose();
    _textController2.dispose();
    _textController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PdfInvoiceApi.getElapsed();

    return Scaffold(
    appBar:AppBar(
  title: const Text(
    'PARC',
    style: TextStyle(
      color: Colors.white, // Couleur du texte en bleu
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor: Colors.blue[900], // Couleur bleue de l'appbar
  iconTheme: const IconThemeData(color: Colors.white),
),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
/*SizedBox(
  width: double.infinity, // Largeur maximale
  child: Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 16.0),
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[900]!, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Intervention ID: 99A',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ),
),*/


 /* Card(
  elevation: 4,
  margin: const EdgeInsets.only(bottom: 16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(color: Colors.blue[900]!, width: 2), // Couleur et largeur du bord
  ),
  child: const Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        Text(
          'Chronomètre',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.play_arrow),
                SizedBox(height: 8),
                Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(Icons.pause),
                SizedBox(height: 8),
                Text(
                  'Pause',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
),*/

Card(
  elevation: 4,
  margin: const EdgeInsets.only(bottom: 2.0),
  shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.blue[900]!, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
  child: const Padding(
    padding: EdgeInsets.all(16.0),
    /*child: Column(
      children: [
        Text(
          ' Date d’intervention \n05/28/2024 à 10:00',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
  children: [
    SizedBox(height: 8),
    DecoratedBox(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Icon(Icons.calendar_month), // Icône du calendrier
              SizedBox(height: 8), // Espacement entre l'icône et le texte
              Text(
                'Durée De\nTemps\nPlannifié\n02:00',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
  children: [
    SizedBox(height: 8),
    DecoratedBox(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Icon(Icons.access_time),
              SizedBox(height: 8), // Espacement entre l'icône et le texte
              Text(
                'Temps Ecoulé\nEn Temps\nRéel\n02:00',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),
            ),
          ],
        ),
      ],
    ),*/
    
                  child: const Text(
                    'Intervention ID: 99A',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),),
  


                const  SizedBox(height: 30),
                // Text field for user input
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Réference', // Ajout du titre
                    hintText: 'Enter your text',
                  ),
                ),
                const SizedBox(height: 16), // Ajout d'un espace entre les champs de texte
                TextFormField(
                  controller: _textController2,
                  decoration: const InputDecoration(
                    labelText: 'Article', // Ajout du titre
                    hintText: 'Enter your text',
                  ),
                ),
                const SizedBox(height: 16), // Ajout d'un espace entre les champs de texte
                TextFormField(
                  controller: _textController3,
                  decoration: const InputDecoration(
                    labelText: 'Marque', // Ajout du titre
                    hintText: 'Enter your text',
                  ),
                ),
               // const SizedBox(height: 16), 
               /*  TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'localisation', // Ajout du titre
                    hintText: 'Enter your text',
                  ),
                ),*/
                //const SizedBox(height: 16), // Ajout d'un espace entre les champs de texte
                /*TextFormField(
                  controller: _textController2,
                  decoration: const InputDecoration(
                    labelText: 'Software', // Ajout du titre
                    hintText: 'Enter your text',
                  ),
                ),*/
               // const SizedBox(height: 16), // Ajout d'un espace entre les champs de texte
                /*TextFormField(
                  controller: _textController3,
                  decoration: const InputDecoration(
                    labelText: 'Rapport', // Ajout du titre
                    hintText: 'Enter your text',
                  ),
                ),*/

 const SizedBox(height: 300), 
 Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
   Expanded(
  child: ElevatedButton(
    onPressed: () async {
      try {
        // Generate PDF file
        final pdfFile = await PdfInvoiceApi.generate(
          themeColor,
          font,
          _textController.text,
          _textController2.text, // Pass the user-entered text
          _textController3.text,
        );

        // Opening the PDF file
        FileHandleApi.openFile(pdfFile);
      } catch (e) {
        // Handle any exceptions that occur during PDF generation
        print('Error generating PDF: $e');
        // Optionally, you can show a dialog or snackbar to inform the user
        // about the error.
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue[900], // Couleur de l'arrière-plan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
    ),
    child: const Icon(
      Icons.picture_as_pdf, // Deuxième icône aléatoire
      color: Colors.white, // Couleur de l'icône
      size: 28, // Taille de l'icône
    ),
  ),
),

    SizedBox(width: 16), // Espace entre les deux boutons
    Expanded(
      child: ElevatedButton(
        onPressed: () {
           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage3()),
                    );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900], // Couleur de l'arrière-plan
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        ),
        child: const Icon(
          Icons.history, // Deuxième icône aléatoire
          color: Colors.white, // Couleur de l'icône
          size: 28, // Taille de l'icône
        ),
      ),
    ),
  ],
),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

