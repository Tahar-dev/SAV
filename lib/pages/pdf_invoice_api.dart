import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'file_handle_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static final Stopwatch _stopwatch = Stopwatch();

  // Démarrer le chronomètre
  static void startTimer() {
    _stopwatch.start();
  }

  // Obtenir le temps écoulé
  static Duration getElapsed() {
    return _stopwatch.elapsed;
  }

  // Générer le PDF en prenant en compte le temps écoulé et le texte utilisateur
  static Future<File> generate(PdfColor color, pw.Font fontFamily, String userText, String text, String text2) async {
    final pdf = pw.Document();

    final iconImage = (await rootBundle.load('assets/logob.png')).buffer.asUint8List();
    final elapsed = _stopwatch.elapsed;

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 150,
                  width: 150,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    /* pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                        color: color,
                        font: fontFamily,
                      ),
                    ),*/
                    /* pw.Text(
                      'Flutter Approach',
                      style: pw.TextStyle(
                        fontSize: 15.0,
                        color: color,
                        font: fontFamily,
                      ),
                    ),*/
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Mr Nicolas CAVANI',
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                        color: color,
                        font: fontFamily,
                      ),
                    ),
                    pw.Text(
                      'Quartier Berriat \nChorier Grenoble 38000',
                      style: pw.TextStyle(
                        fontSize: 14.0,
                        color: color,
                        font: fontFamily,
                      ),
                    ),
                    pw.Text(
                      DateTime.now().toString(),
                      style: pw.TextStyle(
                        fontSize: 14.0,
                        color: color,
                        font: fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 10 * PdfPageFormat.mm),
            pw.Text(
              'REFERENCE :',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: 20.0,
                color: color,
                font: fontFamily,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            // Add the user-entered text
            pw.Text(
              userText,
              style: pw.TextStyle(
                fontSize: 18.0,
                color: color,
                font: fontFamily,
              ),
            ),
            
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
            
            // Add the second text
            pw.Text(
              'ARTICLE :',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: 20.0,
                color: color,
                font: fontFamily,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            pw.Text(
              text,
              style: pw.TextStyle(
                fontSize: 18.0,
                color: color,
                font: fontFamily,
              ),
            ),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            pw.Text(
              'MARQUE :',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: 20.0,
                color: color,
                font: fontFamily,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            pw.Text(
              text2,
              style: pw.TextStyle(
                fontSize: 18.0,
                color: color,
                font: fontFamily,
              ),
            ),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            pw.Text(
              'Temps écoulé: ${elapsed.inHours}:${elapsed.inMinutes % 60}:${elapsed.inSeconds % 60}',
              style: pw.TextStyle(
                fontSize: 20.0,
                color: color,
                font: fontFamily,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            // Add space for signatures at the bottom
            pw.SizedBox(height: 80 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text(
                      'Signature Technicien',
                      style: pw.TextStyle(
                        fontSize: 18.0,
                        color: color,
                        font: fontFamily,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 20 * PdfPageFormat.mm),
                    pw.Container(
                      width: 100,
                      height: 1,
                      color: color,
                    ),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text(
                      'Signature Client',
                      style: pw.TextStyle(
                        fontSize: 18.0,
                        color: color,
                        font: fontFamily,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 20 * PdfPageFormat.mm),
                    pw.Container(
                      width: 100,
                      height: 1,
                      color: color,
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'Flutter Approach',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: color, font: fontFamily),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Address: ',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, color: color, font: fontFamily),
                  ),
                  pw.Text(
                    'Merul Badda, Anandanagor, Dhaka 1212',
                    style: pw.TextStyle(color: color, font: fontFamily),
                  ),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Email: ',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, color: color, font: fontFamily),
                  ),
                  pw.Text(
                    'flutterapproach@gmail.com',
                    style: pw.TextStyle(color: color, font: pw.Font.courier()),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
