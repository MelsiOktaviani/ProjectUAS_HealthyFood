import 'package:healthy_food/database/cart/db_helper.dart';

class Food {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String image;
  final double star;
  final int jumlah;
  int idUser;
  int idWishlist;

  Food(
      {this.id,
      this.name,
      this.desc,
      this.price,
      this.image,
      this.star,
      this.jumlah,
      this.idUser,
      this.idWishlist});

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
        id: int.parse(map[DbHelper.COLUMN_ID].toString()),
        name: map[DbHelper.COLUMN_NAME],
        desc: map[DbHelper.COLUMN_DESC],
        price: int.parse(map[DbHelper.COLUMN_PRICE].toString()),
        image: map[DbHelper.COLUMN_IMAGE],
        star: double.parse(map[DbHelper.COLUMN_STAR].toString()),
        jumlah: int.parse(map[DbHelper.COLUMN_JUMLAH].toString()));
  }

  factory Food.fromWishlist(Map<String, dynamic> map) {
    return Food(
        name: map['name'],
        desc: map['description'],
        price: int.parse(map['price'].toString()),
        image: map['image'],
        star: double.parse(map['star'].toString()),
        idUser: int.parse(map['id_user'].toString()),
        idWishlist: int.parse(map['id_wishlist'].toString()),
        jumlah: int.parse(map['jumlah'].toString()));
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUMN_NAME: this.name,
      DbHelper.COLUMN_DESC: this.desc,
      DbHelper.COLUMN_PRICE: this.price,
      DbHelper.COLUMN_IMAGE: this.image,
      DbHelper.COLUMN_STAR: this.star,
      DbHelper.COLUMN_JUMLAH: this.jumlah,
    };
  }

  Map<String, dynamic> toWishlist() {
    return {
      'name': this.name,
      'description': this.desc,
      'price': this.price.toString(),
      'image': this.image,
      'star': this.star.toString(),
      'jumlah': this.jumlah.toString(),
      'id_user': this.idUser.toString(),
    };
  }
}

final ListFood = [
  Food(
    name: "Daging Tuna",
    desc:
        "Daging Tuna adalah makanan healthy food yang dibuat dengan mencampurkan sepotong daging tuna dengan bumbu rahasia. Bumbu rahasia yang digunakan dalam makanan ini adalah tidak mengandung MSG",
    price: 50000,
    image: "assets/images/food2.png",
    star: 4,
    jumlah: 1,
  ),
  Food(
    name: "Sayur + Daging Tuna",
    desc: "Sayur + Daging Tuna adalah inti semesta healthy food. Well, Must Try.",
    price: 150000,
    image: "assets/images/food3.png",
    star: 4,
    jumlah: 1,
  ),
  Food(
    name: "Sayur + Daging Ayam + Nasi",
    desc: "Sayur + Daging Ayam + Nasi memberi kelezatan.",
    price: 45000,
    image: "assets/images/food4.png",
    star: 5,
    jumlah: 1,
  ),
  Food(
    name: "Kentang + Daging Sapi",
    desc:
        "Kentang + Daging Sapi adalah makanan healthy food favorit di Indoneia, dengan selera pecinta sapi.",
    price: 100000,
    image: "assets/images/food5.png",
    star: 5,
    jumlah: 1,
  ),
  Food(
    name: "Ikan Tuna + Sayur",
    desc:
        "Kombinasi makanan helathy food yang dicintai semua orang.",
    price: 200000,
    image: "assets/images/kepala1.jpg",
    star: 3,
    jumlah: 1,
  ),
  Food(
    name: "Daging Ayam + Tomat",
    desc: "Kombinasi makanan healthy food terenyah.",
    price: 150000,
    image: "assets/images/diet1.jpg",
    star: 4,
    jumlah: 1,
  ),
  Food(
    name: "Daging Ayam + Sayur",
    desc: "Kombinasi daging ayam empuk dan sayur segar.",
    price: 22000,
    image: "assets/images/diet2.jpg",
    star: 5,
    jumlah: 1,
  ),
  Food(
    name: "Daging Tuna Spesial",
    desc: "Kombinasi daging tuna dan sayur sehingga menjadi spesial.",
    price: 255000,
    image: "assets/images/diet3.jpg",
    star: 4,
    jumlah: 1,
  )
];