import 'package:healthy_food/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './food.dart';


class ListFoodPage extends StatefulWidget {
  final Food food;
  ListFoodPage({this.food});
  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  int jumlah = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ListFood.length,
      itemBuilder: (context, index) {
        Food foodModel = ListFood[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMenu(
                  food: foodModel,
                ),
              ),
            );
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20
                      // topLeft: Radius.circular(20),
                      // bottomLeft: Radius.circular(20),
                      // bottomRight: Radius.circular(20),
                      // topRight: Radius.circular(20),
                      ),
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
                          style: TextStyle(color: Colors.orange, fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          //     );
                          //     DbHelper.myDB
                          //         .insertCoffee(newcoffee)
                          //         .then((value) {
                          //       if (value != null) {
                          //         print('Berhasil $value');
                          //       }
                          //     });
                          //   },
                          //   child: Icon(
                          //     Icons.shopping_cart_sharp,
                          //     color: Colors.brown,
                          //   ),
                          // ),
                          RatingBar.builder(
                            initialRating: foodModel.star,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 15,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                Icon(Icons.navigate_next),
              ],
            ),
          ),
        );
      },
    );
  }
}