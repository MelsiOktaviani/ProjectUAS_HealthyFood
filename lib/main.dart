import 'package:healthy_food/Flutter_Api/ui/list_pelanggan.dart';
import 'package:healthy_food/about_app.dart';
import 'package:healthy_food/login/login_user.dart';
import 'package:healthy_food/penjualan_food/list_penjualan.dart';
import 'package:healthy_food/wishlist/list_wishlist.dart';
import 'package:flutter/material.dart';
//import halaman yang akan diload kemudian beri alias
import './home_page.dart';
import './list_food_page.dart';
import './list_cart.dart';


//top level root
void main() {
  runApp(new MaterialApp(
    title: "tab Bar",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
    home: new Login(),
  ));
}

//menggunakan StatefulWidget
class MyApp extends StatefulWidget {
  final String id_user;
  const MyApp({Key key, this.id_user}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

//panggil juga SingleTickerProviderStateMixin
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  //deklarasikan variabel controller untuk mengatur tabbar
  int _currentIndex = 0;
  List<Map> _listNav = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.list, 'label': 'List'},
    {'icon': Icons.add_chart, 'label': 'Penjualan'},
    {'icon': Icons.add_box, 'label': 'Pelanggan'},
  ];
  List<String> _listTitle = [
    'Healthy Food',
    'List Food',
    'List Penjualan',
    'Daftar Pelanggan'
  ];
  List<Widget> _listPage = [
    HomePage(),
    ListFoodPage(),
    Home(),
    ListPelanggan(),
  ];

  // TabController controller;
  // //tambah initState unutk inisialisasi dan mengaktifkan tab
  @override
  void initState() {
    // controller = new TabController(length: 2, vsync: this);
    // _listPage = [
    //   HomePage(
    //     id_user: widget.id_user,
    //   ),
    //   ListFoodPage(),
    //   ListCart(),
    //   Home(),
    //   ListPelanggan(),
    // ];
    super.initState();
  }

  // //tambah dispose unutk berpindah halaman
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var keyScaffold = GlobalKey<ScaffoldState>();
    //gunakan widget Scaffold
    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        backgroundColor: Color(0xFF21BFBD),
        leading: _currentIndex == 0
            ? IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
                onPressed: () {
                  keyScaffold.currentState.openDrawer();
                })
            : SizedBox(),
        centerTitle: true,
        title: Text(
          _listTitle[_currentIndex],
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          _currentIndex == 0
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    print('click start');
                  },
                )
              : SizedBox(),
          _currentIndex == 0
              ? IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListCart()));
                  },
                )
              : SizedBox(),

          // _currentIndex == 0
          //     ? IconButton(
          //         icon: Icon(
          //           Icons.notifications_active,
          //           color: Colors.brown,
          //         ),
          //         onPressed: () {
          //           print('click start');
          //         },
          //       )
          //     : SizedBox(),
        ],
      ),

      //drawer profil user
      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
              accountName: new Text("Melsi Oktaviani"),
              accountEmail: new Text("melsi@undiksha.ac.id"),
              currentAccountPicture: new GestureDetector(
                onTap: () {},
                child: new CircleAvatar(
                  backgroundImage: new AssetImage('assets/images/melsi.jpg'),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/profile.jpeg'),
                    fit: BoxFit.cover),
              ),
            ),
            new ListTile(
              title: new Text('About'),
              trailing: new Icon(Icons.info_outline_rounded),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutApp()));
              },
            ),
            new ListTile(
              title: new Text('Notifications'),
              trailing: new Icon(
                Icons.notifications_none,
              ),
              onTap: () {
                print("Click Start");
              },
            ),
            new ListTile(
              title: new Text('Wishlist'),
              trailing: new Icon(Icons.favorite),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListWishlist()));
                print("Click Start");
              },
            ),
            new ListTile(
              title: new Text('Account'),
              trailing: new Icon(Icons.verified_user),
              onTap: () {
                print("Click Start");
              },
            ),
            new ListTile(
              title: new Text('Setting'),
              trailing: new Icon(Icons.settings),
              onTap: () {
                print("click");
              },
            ),
          ],
        ),
      ),

      body: _listPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF21BFBD),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          onTap: (newValue) {
            setState(() {
              _currentIndex = newValue;
            });
          },
          items: List.generate(_listNav.length, (index) {
            return BottomNavigationBarItem(
              label: _listNav[index]['label'],
              icon: Icon(_listNav[index]['icon']),
            );
          })),
      //widget TabBarView
      // body: new TabBarView(
      //   //terdapat controller untuk mengatur halaman
      //   controller: controller,
      //   children: <Widget>[
      //     //pemanggil halaman dimulai dari alias.ClassName halaman yang diload
      //     new HomePage.HomePage(),
      //     new ListFood.ListFoodPage(),
      //     // new Home.Home(),
      //   ],
      // ),
      //membuat bottom tab
      // bottomNavigationBar: new Material(
      //   color: Color(0xFFDAB68C),
      //   child: new TabBar(
      //     controller: controller,
      //     tabs: <Widget>[
      //       //menggunakan icon untuk mempercantik tab
      //       //icon berurutan sesuai penggilan halaman
      //       new Tab(icon: new Icon(Icons.home)),
      //       new Tab(icon: new Icon(Icons.list)),
      //       // new Tab(icon: new Icon(Icons.add_shopping_cart)),
      //     ],
      //   ),
      // ),
    );
  }
}