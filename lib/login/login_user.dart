import 'dart:convert';

import 'package:healthy_food/Flutter_Api/server/Api.dart';
import 'package:healthy_food/login/flutter_food_login_u_i_icons.dart';
import 'package:healthy_food/login/register_user.dart';
import 'package:healthy_food/main.dart';
import 'package:healthy_food/wishlist/prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/basic.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _controllerUsername = TextEditingController();
  var _controllerPassword = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void loginUser() async {
    try {
      var response = await http.post(Api.urlLogin, body: {
        'username': _controllerUsername.text,
        'password': _controllerPassword.text,
      });
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody['succes']) {
          print('Berhasil');
          var data = responseBody['data'];
          Prefs.saveIdUser(data['id']);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyApp(
                        id_user: data['id'],
                      )));
        } else {
          print('Gagal');
          // ignore: unused_local_variable
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Login Gagal!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print('Request Eror');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('./assets/images/food.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 24.0),
                  child: Column(
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    'Login',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register()));
                                      // Challenge can you make this create account button push to the signup screen?
                                      // then can you create the signup screen yourself?
                                    },
                                    child: Text(
                                      'create account',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 32.0,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _controllerUsername,
                                      decoration: InputDecoration(
                                          hintText: 'Email Address'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 32.0,
                                  ),
                                  Expanded(
                                    // Bonus Challenge #2
                                    // Can you figure out how to obscure the password text
                                    // with the eye icon as a toggle?
                                    child: TextField(
                                      obscureText: true,
                                      controller: _controllerPassword,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          suffixIcon:
                                              Icon(Icons.visibility_outlined)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  child: Icon(
                                    FlutterFoodLoginUI.google,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 22.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  child: Icon(
                                    FlutterFoodLoginUI.facebook,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            FittedBox(
                              child: GestureDetector(
                                onTap: () {
                                  loginUser();
                                  // Navigator.pushNamed(context, '/home-screen');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Theme.of(context).primaryColor),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
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
                ),
              ),
            )
          ],
        ));
  }
}