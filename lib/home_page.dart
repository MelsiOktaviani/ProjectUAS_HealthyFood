import 'package:healthy_food/about_app.dart';
import 'package:healthy_food/detail_page.dart';
import 'package:healthy_food/list_food_page.dart';
import 'package:healthy_food/wishlist/list_wishlist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(right: 45.0, left: 20.0),
        //   child: Text(
        
        //     style: TextStyle(
        //         fontSize: 25.0,
        //         fontWeight: FontWeight.bold,
        //         color: Color(0xFF473D3A)),
        //   ),
        // ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(right: 45.0, left: 20.0),
          child: Container(
            child: Text(
              'Let\'s select the best taste for your next healthy food break!',
              style: TextStyle(
                fontFamily: 'nunito',
                fontSize: 17.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFFB0AAA7),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/kepala1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Ikan Tuna + Sayur',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Spacer(),
                          Text(
                            'Rp. 200.000',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.orangeAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text('All')
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    makeCategory(
                        image: 'assets/images/salad.jpg', title: 'Salad Buah'),
                    makeCategory(
                        image: 'assets/images/tuna1.jpg', title: 'Healthy Food Spesial'),
                    makeCategory(
                        image: 'assets/images/kimchi.jpg', title: 'Kimchi'),
                    makeCategory(
                        image: 'assets/images/salad2.jpg', title: 'Salat Kentang'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Selling',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListFoodPage()));
                    },
                    child: Text('All'),
                  )
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    makeBestSell(
                        image: 'assets/images/diet1.jpg',
                        title: 'Daging Ayam + Tomat',
                        price: 'Rp.150.000'),
                    makeBestSell(
                        image: 'assets/images/diet2.jpg',
                        title: 'Daging Ayam + Sayur',
                        price: 'Rp.22.000'),
                    makeBestSell(
                        image: 'assets/images/diet3.jpg',
                        title: 'Daging Tuna Spesial',
                        price: 'Rp.255.000'),
                    makeBestSell(
                        image: 'assets/images/food3.png',
                        title: 'Sayur + Daging Tuna',
                        price: 'Rp.150.000'),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget makeCategory({image, title}) {
    return AspectRatio(
      aspectRatio: 2 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeBestSell({image, title, price}) {
    return AspectRatio(
      aspectRatio: 3 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart_outlined,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListFoodPage()));
                        },
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