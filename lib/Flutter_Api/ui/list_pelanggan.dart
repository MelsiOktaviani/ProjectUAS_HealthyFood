import 'dart:convert';

import 'package:healthy_food/Flutter_Api/model/pelanggan.dart';
import 'package:healthy_food/Flutter_Api/server/api.dart';
import 'package:healthy_food/Flutter_Api/ui/add_pelanggan.dart';
import 'package:healthy_food/Flutter_Api/ui/update_pelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPelanggan extends StatefulWidget {
  @override
  _ListPelangganState createState() => _ListPelangganState();
}

class _ListPelangganState extends State<ListPelanggan> {
  List<Pelanggan> _listPelanggan = [];

  void getListPelanggan() async {
    _listPelanggan.clear();
    // String url = 'http://10.0.3.2/db_food_api/get_list_pelanggan.php';
    try {
      var response = await http.get(Api.urlGetListPelanggan);
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody['succes']) {
          List listData = responseBody['data'];
          listData.forEach((itemPelanggan) {
            _listPelanggan.add(Pelanggan.fromMap(itemPelanggan));
          });
        } else {}
      } else {
        print('Request Error');
      }
    } catch (e) {}
    setState(() {});
  }

  void deletePelanggan(String id) async {
    // var url = 'http://10.0.3.2/db_food_api/delete_pelanggan.php';
    try {
      var response = await http.post(
        Api.urlDeletePelanggan,
        body: {'id': id},
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody['succes']) {
          print('Berhasil');
        } else {
          print('Gagal');
        }
      } else {
        print('Request Eror');
      }
    } catch (e) {}
    getListPelanggan();
  }

  @override
  void initState() {
    getListPelanggan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listPelanggan.length > 0
            ? ListView.builder(
                itemCount: _listPelanggan.length,
                itemBuilder: (context, index) {
                  Pelanggan pelanggan = _listPelanggan[index];
                  return ListTile(
                    leading: Image.network(
                      pelanggan.foto,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      pelanggan.nama,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.brown[900]),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rp" + pelanggan.total),
                        Text(pelanggan.gender)
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePelanggan(
                                pelanggan: pelanggan,
                              )),
                    ).then((value) => getListPelanggan()),
                    trailing: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.brown,
                      child: InkWell(
                        onTap: () {
                          deletePelanggan(pelanggan.id);
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
                  );
                },
              )
            : Center(
                child: Text('Silahkan Tambah Data!'),
              ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            // backgroundColor: Colors.amber,
            // foregroundColor: Colors.black,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPelanggan()),
              ).then((value) => getListPelanggan());
            },
          ),
        )
      ],
    );
  }
}
