import 'package:healthy_food/checkout_berhasil_page.dart';
import 'package:healthy_food/database/cart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:healthy_food/food.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int pengiriman = 0;
  String pembayaran = '';
  var formScaffold = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
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
      total = total + pengiriman;
      FlutterMoneyFormatter fmf =
          FlutterMoneyFormatter(amount: double.parse(total.toString()));
      totalString = fmf.output.withoutFractionDigits;
      setState(() {});
    });

    // var newlist = await DbHelper.myDB.getAllAnimal();
    // _listCoffee = newlist;
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
      key: formScaffold,
      appBar: AppBar(
        backgroundColor: Color(0xFF21BFBD),
        title: Text('Checkout Page', style: TextStyle(color: Colors.green)),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('Rp ${totalString.replaceAll(',', '.')}',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (pengiriman != 0 && pembayaran != '') {
                        _listFood.forEach((food) {
                          DbHelper.myDB.deleteWhereId(food.id);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutBerhasil(),
                          ),
                        );
                      } else {
                        // ignore: unused_local_variable
                        final snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 2500),
                          behavior: SnackBarBehavior.floating,
                          content:
                              Text('Pengiriman dan Pembayaran Wajib Terisi!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                      }
                    } else {}
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: _listFood.length > 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Rp ${food.price}',
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Qty : ${food.jumlah}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Sub Total: Rp. ${food.price * food.jumlah}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('Database Kosong')),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lengkapi Data Diri!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Tidak Boleh Kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        hintText: 'Nama Lengkap',
                        // labelText: 'Input Nama',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money),
                        // prefixIcon:
                        //     Icon(Icons.attach_money, color: Colors.grey),
                        // suffixIcon: Icon(Icons.search, color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Tidak Boleh Kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        hintText: 'Alamat ',
                        // labelText: 'Input Angka',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money),
                        // prefixIcon:
                        //     Icon(Icons.attach_money, color: Colors.grey),
                        // suffixIcon: Icon(Icons.search, color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Tidak Boleh Kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        hintText: 'No.Tlp ',
                        // labelText: 'Input Angka',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money),
                        // prefixIcon:
                        //     Icon(Icons.attach_money, color: Colors.grey),
                        // suffixIcon: Icon(Icons.search, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            RadioButtonGroup(
              labels: <String>[
                "Dana",
                "Ovo",
              ],
              onSelected: (String selected) {
                setState(() {
                  pembayaran = selected;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pengiriman',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            RadioButtonGroup(
              labels: <String>[
                "Gojek = 6000",
                "Grab = 5000",
              ],
              onSelected: (String selected) {
                setState(() {
                  if ('Grab = 5000' == selected) {
                    pengiriman = 5000;
                  } else {
                    pengiriman = 6000;
                  }
                });
                getFood();
              },
            ),
          ],
        ),
      ),
    );
  }
}
