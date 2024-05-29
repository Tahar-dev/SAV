import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// Définition de la classe Technicians
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Définition de la classe Technicians
class Technicians {
  final String id;
  final String fullname;
  final String email;
  final int age;
  final String speciality;
  final String profil;

  Technicians({
    required this.id,
    required this.fullname,
    required this.email,
    required this.age,
    required this.speciality,
    required this.profil,
  });

  // Factory method pour créer une instance de Technicians à partir d'un Map
  factory Technicians.fromJson(Map<String, dynamic> json) {
    return Technicians(
      id: json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      age: json['age'],
      speciality: json['speciality'],
      profil: json['profil'],
    );
  }
}

// Définition du service TechniciansService
class TechniciansService {
  Future<List<Technicians>> getTechnicians() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:4000/api/technicians'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Technicians.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load technicians');
    }
  }
}

// Définition du widget AllTechniciansPage
class AllTechniciansPage extends StatefulWidget {
  @override
  _AllTechniciansPageState createState() => _AllTechniciansPageState();
}

class _AllTechniciansPageState extends State<AllTechniciansPage> {
  final TechniciansService techniciansService = TechniciansService();
  late Future<List<Technicians>> _futureTechnicians;

  @override
  void initState() {
    super.initState();
    _futureTechnicians = techniciansService.getTechnicians();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: FutureBuilder<List<Technicians>>(
          future: _futureTechnicians,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Technicians> technicians = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('lib/images/tahar_avatar.jpg'),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: technicians.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            itemProfile('Nom', Text(technicians[index].fullname), CupertinoIcons.person),
                            const SizedBox(height: 10),
                            itemProfile('Age', Text('${technicians[index].age}'), CupertinoIcons.phone),
                            const SizedBox(height: 10),
                            itemProfile('Specialité', Text('${technicians[index].speciality}'), CupertinoIcons.location),
                            const SizedBox(height: 10),
                            itemProfile('Carrierre',Text('${technicians[index].profil}'),CupertinoIcons.mail),
                            const SizedBox(height: 20,),
                          ],
                        );
                      },
                    ),
                   /* SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text('Edit Profile')
                      ),
                    ),*/
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  itemProfile(String title, Widget subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10
          )
        ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle,
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
