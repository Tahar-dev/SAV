import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srasav/components/grocery_item_tile2.dart';
import 'package:srasav/components/grocery_item_tile3.dart';
import 'package:srasav/components/grocery_item_tile4.dart';
import 'package:srasav/components/grocery_item_tile5.dart';
import 'package:srasav/pages/login_page.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'package:srasav/pages/calendar.dart';
import 'cart_page.dart';
import 'package:animate_do/animate_do.dart';
import 'cart_page2_profil.dart';

class HomePage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const HomePage({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextEditingController emailController;
  late TextEditingController passwordController;
 @override
  void initState() {
    super.initState();
    emailController = widget.emailController;
    passwordController = widget.passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F1F1),
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
Column(
crossAxisAlignment: CrossAxisAlignment.center,
),
 Padding(
  padding: EdgeInsets.only(right: 50.0),
  child: Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '  SRA',
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'SAV',
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.yellow[700],
            ),
          ),
        ],
      ),
    ),
  ),
),

            Icon(
              Icons.notifications,
              color: Colors.black,
              size: 24.0,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Tahar SASSI"),
              accountEmail: Text(emailController.text),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/images/tahar_avatar.jpg'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllTechniciansPage()),
       );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Déconnexion'),
              onTap: () {
                  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
       );
              },
            ),
            SizedBox(height: 350),
            ListTile(
              leading: Image.asset('lib/images/logobmm.png'),
              title: Text('À propos du SRA'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeInUp(
              duration: Duration(milliseconds: 1400),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                     RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'BON',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[700],
            ),
          ),
          TextSpan(
            text: 'JOUR',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
                    const SizedBox(height: 4),
                    Text(
                      'Partons, résolvons les problèmes \net rendons nos clients heureux 😄',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    Consumer<CartModel>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.shopItems.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GroceryItemTile(
                                itemName: value.shopItems[index][0],
                                itemPrice: value.shopItems[index][1],
                                imagePath: value.shopItems[index][2],
                                color: value.shopItems[index][3],
                                onPressed: () => Provider.of<CartModel>(context, listen: false).addItemToCart(index),
                              );
                            } else if (index == 1) {
                              return Row(
                                children: [
                                  GroceryItemTile2(
                                    itemName: value.shopItems[1][0],
                                    itemPrice: value.shopItems[1][1],
                                    imagePath: value.shopItems[1][2],
                                    color: value.shopItems[1][3],
                                    onPressed: () => Provider.of<CartModel>(context, listen: false).addItemToCart(index),
                                  ),
                                  const SizedBox(height: 16),
                                  GroceryItemTile3(
                                    itemName: value.shopItems[2][0],
                                    itemPrice: value.shopItems[2][1],
                                    imagePath: value.shopItems[2][2],
                                    color: value.shopItems[2][3],
                                    onPressed: () => Provider.of<CartModel>(context, listen: false).addItemToCart(index),
                                  ),
                                ],
                              );
                            } else if (index == 2) {
                              return Row(
                                children: [
                                  GroceryItemTile4(
                                    itemName: value.shopItems[3][0],
                                    itemPrice: value.shopItems[3][1],
                                    imagePath: value.shopItems[3][2],
                                    color: value.shopItems[3][3],
                                    onPressed: () => Provider.of<CartModel>(context, listen: false).addItemToCart(index),
                                  ),
                                  const SizedBox(height: 16),
                                  GroceryItemTile5(
                                    itemName: value.shopItems[4][0],
                                    itemPrice: value.shopItems[4][1],
                                    imagePath: value.shopItems[4][2],
                                    color: value.shopItems[4][3],
                                    onPressed: () => Provider.of<CartModel>(context, listen: false).addItemToCart(index),
                                  ),
                                ],
                              );
                            }
                            return Container(); // Placeholder, vous pouvez modifier ou remplacer cela en fonction de vos besoins
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
