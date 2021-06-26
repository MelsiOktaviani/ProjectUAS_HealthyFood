import 'dart:convert';

import 'package:healthy_food/Flutter_Api/server/Api.dart';
import 'package:healthy_food/food.dart';
import 'package:healthy_food/detail_page.dart';
import 'package:healthy_food/wishlist/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class ListWishlist extends StatefulWidget {
  // final String id_user;
  // ListWishlist({this.id_user});

  @override
  _ListWishlistState createState() => _ListWishlistState();
}

class _ListWishlistState extends State<ListWishlist> {
  List<Food> wishlist = [];

  List<String> _selectedWishlist = [];
  bool isEdit = false;

  void getWishlist() async {
    String idUser = await Prefs.getIdUser();
    wishlist.clear();
    // String url = 'http://10.0.3.2/db_food_api/get_list_pelanggan.php';
    try {
      print('-------------$idUser');
      var response = await http.post(Api.urlGetListWishlist, body: {
        'id_user': idUser,
      });
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody['succes']) {
          print('list pasti succes');
          List listData = responseBody['data'];
          listData.forEach((itemWishlist) {
            print('itemWishlist: $itemWishlist');
            wishlist.add(Food.fromWishlist(itemWishlist));
          });
        } else {
          print('list gagal');
        }
      } else {
        print('Request Error');
      }
    } catch (e) {}
    setState(() {});
  }

  void deleteWishlist(String name) async {
    String idUser = await Prefs.getIdUser();

    // String url = 'http://10.0.3.2/db_food_api/get_list_pelanggan.php';
    try {
      await http.post(Api.urlDeleteWishlist, body: {
        'id_user': idUser,
        'name': name,
      });
      // checkWishlist();
    } catch (e) {}
    getWishlist();
  }

  @override
  void initState() {
    getWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21BFBD),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "LIST WISHLIST",
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
        actions: [
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white // foreground
                  ),
              onPressed: () {
                setState(() {
                  isEdit = true;
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: Text('Edit'))
        ],
      ),
      body: wishlist.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                Food foodModel = wishlist[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMenu(
                          food: foodModel,
                        ),
                      ),
                    ).then((value) => getWishlist());
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                        index == ListFood.length - 1 ? 16 : 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 0),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          child: isEdit
                              ? Checkbox(
                                  value:
                                      _selectedWishlist.contains(foodModel.name)
                                          ? true
                                          : false,
                                  onChanged: (value) {
                                    setState(() {
                                      if (_selectedWishlist
                                          .contains(foodModel.name)) {
                                        _selectedWishlist
                                            .remove(foodModel.name);
                                      } else {
                                        _selectedWishlist.add(foodModel.name);
                                      }
                                    });
                                  },
                                )
                              : null,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: foodModel.image,
                            child: Image.asset(
                              foodModel.image,
                              fit: BoxFit.cover,
                              height: 85,
                              width: 85,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(foodModel.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ),
                              Text(
                                foodModel.desc,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              Text('Rp. ${foodModel.price}',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 18)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBar.builder(
                                    initialRating: foodModel.star,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                          child: InkWell(
                            onTap: () {
                              deleteWishlist(foodModel.name);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8)
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text('Wishlist Kosong!'),
            ),
      bottomNavigationBar: SizedBox(
        child: isEdit
            ? Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_selectedWishlist.length} Selected'),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _selectedWishlist.forEach((element) {
                                deleteWishlist(element);
                              });
                              setState(() {
                                _selectedWishlist.clear();
                                isEdit = false;
                              });
                            },
                            child: Text('Delete'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedWishlist.clear();
                                isEdit = false;
                              });
                            },
                            child: Text('Cancel'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
