import 'package:flutter/material.dart';
import 'package:srasav/pages/home_page.dart';
import '/components/my_button.dart';
import '/components/my_textfield.dart';
import '/components/password_field.dart';
import '/components/square_tile.dart';
import 'package:srasav/pages/calendar.dart';
import 'cart_page.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:srasav/pages/login_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String loginUrl = 'http://10.0.2.2:8000/auth/login';
  String signUpUrl ='http://10.0.2.2:8000/auth/signup';

  Future<void> signUserIn(BuildContext context) async {
        try {
      var email = emailController.text;
      var password = passwordController.text;

      var response = await http.post(
        Uri.parse(loginUrl),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        var token = jsonDecode(response.body)['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => HomePage(
      emailController: emailController,
      passwordController: passwordController,
    ),
  ),
);
      } else {
        throw Exception('Email ou mot de passe incorrect.');
      }
   } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
  /*Text(
                'SRASAV.',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
  ),*/
  RichText(
  text: TextSpan(
    style: TextStyle(
      fontWeight: FontWeight.bold,
     // color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: 'SRA',

        style: TextStyle(
          fontSize: 42.0,
          color: Colors.black,
        ),
      ),
      TextSpan(
        text: 'SAV',
         style: TextStyle(
          fontSize: 42.0,
          color: Colors.yellow[700],
        ),
        
      ),
       TextSpan(
        text: '■',
         style: TextStyle(
          fontSize: 18.0,
          color: Colors.yellow[700],
        ),
      ),
      
    ],
  ),
),

              const SizedBox(height: 10),
              // logo
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10), // Définir le rayon des coins
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // Déplace l'ombre
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10), // Définir le rayon des coins
    child: Image.asset(
      'lib/images/SAV_imag200.jpg',
      //width: 100,
      //height: 100,
    ),
  ),
),





              const SizedBox(height: 20),
// welcome back, you've been missed!
//const SizedBox(width: 100),
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    
    SizedBox(width: 25), // Espacement vers la droite
    Text(
      'Log In',
      style: TextStyle(
        color: Colors.black,
        fontSize: 23,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.bold,
        
      ),
    ),
  ],
),

/*Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(width: 25), // Espacement vers la droite
    Text(
       'Nom',
      style: TextStyle(
        color: Colors.black,
      //  fontSize: 23,
      //  fontFamily: 'Rubik',
      //  fontWeight: FontWeight.bold,
        
      ),
    ),
  ],
),*/


              const SizedBox(height: 20),

              // username textfield
              
              MyTextField1(
                controller: emailController,
                hintText: 'E-mail',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField2(
                controller: passwordController,
                hintText: 'Mot de passe',
                
                obscureText: true,
              ),

              const SizedBox(height: 10),
              
              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Mot de passe oublié?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // sign in button
              MyButton(
                   onTap: () {
                // Appel de la fonction signUserIn lorsqu'on appuie sur le bouton
                signUserIn(context);
              },
              ),

              const SizedBox(height: 20),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Ou',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google_icon.png'),

                  //SizedBox(width: 10),

                  // apple button
                //  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 10),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pas encore membre ?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Inscrivez-vous maintenant',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
}