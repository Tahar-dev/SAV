import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:srasav/pages/parc_page.dart';
import 'file_handle_api.dart';
import 'pdf_invoice_api.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:srasav/pages/parc_page.dart';

class InvoiceDesignPage extends StatefulWidget {
  const InvoiceDesignPage({Key? key});

  @override
  State<InvoiceDesignPage> createState() => _InvoiceDesignPageState();
}

class _InvoiceDesignPageState extends State<InvoiceDesignPage> with WidgetsBindingObserver {
  PdfColor themeColor = PdfColors.black; // Valeur par défaut
  pw.Font font = pw.Font.courier(); // Valeur par défaut
  final TextEditingController _textControllerID = TextEditingController();
  final TextEditingController _textControllerDescription = TextEditingController();
  final TextEditingController _textControllerType = TextEditingController();
  final TextEditingController _textControllerLieu = TextEditingController();
  final TextEditingController _textControllerAdresse = TextEditingController();
  final TextEditingController _textControllerEmail = TextEditingController();

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
   // _startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _textControllerID.dispose();
    _textControllerDescription.dispose();
    _textControllerType.dispose();
    _textControllerLieu.dispose();
    _textControllerAdresse.dispose();
    _textControllerEmail.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    } else if (state == AppLifecycleState.resumed && _isRunning) {
      _startTimer();
    }
  }

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    if (!_isRunning) return;
    _isRunning = false;
    _timer?.cancel();
  }

  String formatDuration(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = PdfInvoiceApi.getElapsed();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Intervention Maintenance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCard(
                  child: const Text(
                    'Intervention ID: 99A',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildCard(
                  child: Column(
                    children: [
                      const Text(
                        'Chronomètre',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton(
                            icon: Icons.play_arrow,
                            onPressed: () {
                              _startTimer();
                            },
                          ),
                          const SizedBox(width: 16),
                          _buildButton(
                            icon: Icons.pause,
                            onPressed: () {
                              _stopTimer();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildCard(
                  child: Column(
                    children: [
                      const Text(
                        'Date d’intervention\n05/28/2024 à 10:00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoColumn1(
                            icon: Icons.calendar_month,
                            text: 'Durée De\nTemps\nPlannifié\n02:00:00',
                          ),
                          const SizedBox(width: 16),
                          _buildInfoColumn2(
                            icon: Icons.access_time,
                            text: 'Temps Ecoulé\nEn Temps\nRéel\n ${formatDuration(_seconds)}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(controller: _textControllerID, label: 'ID', hint: 'Enter your text'),
                const SizedBox(height: 16),
                _buildTextField(controller: _textControllerDescription, label: 'Description', hint: 'Enter your text'),
                const SizedBox(height: 16),
                _buildTextField(controller: _textControllerType, label: 'Type', hint: 'Enter your text'),
                const SizedBox(height: 16),
                _buildTextField(controller: _textControllerLieu, label: 'Lieu', hint: 'Enter your text'),
                const SizedBox(height: 16),
                _buildTextField(controller: _textControllerAdresse, label: 'Adresse', hint: 'Enter your text'),
                const SizedBox(height: 16),
                _buildTextField(controller: _textControllerEmail, label: 'Email', hint: 'Enter your text'),
                const SizedBox(height: 16),
                _buildNavigateButton(
                  label: 'PARC',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const parcPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.blue[900]!, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildButton({required IconData icon, required VoidCallback onPressed}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildInfoColumn1({required IconData icon, required String text}) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 48.0,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 22,
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
    );
  }

  Widget _buildInfoColumn2({required IconData icon, required String text}) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 48.0,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 24,
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
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required String hint}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _buildNavigateButton({required String label, required VoidCallback onPressed}) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
