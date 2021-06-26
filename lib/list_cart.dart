import 'package:healthy_food/checkout.dart';
import 'package:healthy_food/food.dart';
import 'package:healthy_food/database/cart/db_helper.dart';
import 'package:healthy_food/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class ListCart extends StatefulWidget {
  @override
  _ListCartState createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  List<Food> _listFood = [];
  String totalString = '';
  int total = 0;
  void getFood() {
    total = 0;
    DbHelper.myDB.getAllFood().then((value) {
      _listFood = value;
      _listFood.forEach((element) {
        total = total + (element.price * element.jumlah);
      });
      FlutterMoneyFormatter fmf =
          FlutterMoneyFormatter(amount: double.parse(total.toString()));
      totalString = fmf.output.withoutFractionDigits;
      setState(() {});
    });

    // var newlist = await DbHelper.myDB.getAllAnimal();

    // setState(() {
    // });
  }

  @override
  void initState() {
    getFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21BFBD),
        title: Center(
          child: Text(
            'LIST CART Food',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 100,
            width: 40,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text('Rp. ${totalString.replaceAll(',', '.')}',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(),
                        ),
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('CHECK OUT',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                )
              ],
            ),
          )),
      body: _listFood.length > 0
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(color: Colors.green, height: 4);
              },
              itemCount: _listFood.length,
              itemBuilder: (context, index) {
                Food food = _listFood[index];
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        food.image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Rp. ${food.price}',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    int newjumlah = food.jumlah - 1 <= 0
                                        ? 1
                                        : food.jumlah - 1;
                                    Food newfood = Food(
                                      id: food.id,
                                      name: food.name,
                                      desc: food.desc,
                                      price: food.price,
                                      star: food.star,
                                      image: food.image,
                                      jumlah: newjumlah,
                                    );
                                    DbHelper.myDB
                                        .updateWhereId(newfood)
                                        .then((value) {
                                      print('value: $value');
                                    });
                                    getFood();
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '-',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(food.jumlah.toString(),
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    int newjumlah = food.jumlah + 1 >= 100
                                        ? 100
                                        : food.jumlah + 1;
                                    Food newfood = Food(
                                      id: food.id,
                                      name: food.name,
                                      desc: food.desc,
                                      price: food.price,
                                      star: food.star,
                                      image: food.image,
                                      jumlah: newjumlah,
                                    );
                                    DbHelper.myDB
                                        .updateWhereId(newfood)
                                        .then((value) {
                                      print('Value: $value');
                                    });
                                    getFood();
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '+',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                DbHelper.myDB.deleteWhereId(food.id);
                                getFood();
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                width: 30,
                                alignment: Alignment.center,
                                child: Icon(Icons.delete, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
                // return ListTile(
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => DetailMenu(),
                //     ),
                //   ),

                //   subtitle: Row(
                //     children: [
                //       FlatButton(
                //         onPressed: () {
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //     builder: (context) => UpdateCoffee(

                //           //     ),
                //           //   ),
                //           // ).then((value) {

                //           // });
                //         },
                //         child: Text('Edit'),
                //         color: Colors.amber,
                //       ),
                //       FlatButton(
                //         onPressed: () {

                //           getCoffee();
                //         },
                //         child: Text('delete'),
                //         color: Colors.orange,
                //       ),
                //     ],
                //   ),
                // );
              },
            )
          : Center(child: Text('Database Kosong')),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AddCoffee(),
      //     ),
      //   ).then((value) {
      //     getCoffee();
      //   }),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
