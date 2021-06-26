import 'package:healthy_food/Flutter_Api/model/pelanggan.dart';
import 'package:healthy_food/Flutter_Api/server/api.dart';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePelanggan extends StatefulWidget {
  final Pelanggan pelanggan;
  UpdatePelanggan({this.pelanggan});
  @override
  _UpdatePelangganState createState() => _UpdatePelangganState();
}

class _UpdatePelangganState extends State<UpdatePelanggan> {
  String _valuegender = 'Laki-laki';
  List<String> _items = ['Laki-laki', 'Perempuan'];

  var _controllerNama = TextEditingController();

  var _controllerEmail = TextEditingController();

  var _controllerTotal = TextEditingController();
  var _controllerFoto = TextEditingController();

  void updateNewPelanggan() async {
    // var url = 'http://10.0.3.2/db_food_api/update_pelanggan.php';
    try {
      var response = await http.post(Api.urlUpdatePelanggan, body: {
        'id': widget.pelanggan.id,
        'nama': _controllerNama.text,
        'email': _controllerEmail.text,
        'total': _controllerTotal.text,
        'foto': _controllerFoto.text,
        'gender': _valuegender,
      });
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
  }

  @override
  void initState() {
    _controllerNama.text = widget.pelanggan.nama;
    _controllerEmail.text = widget.pelanggan.email;
    _controllerTotal.text = widget.pelanggan.total;
    _controllerFoto.text = widget.pelanggan.foto;
    _valuegender = widget.pelanggan.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Customer'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerNama,
              keyboardType: TextInputType.text,
              // textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  // contentPadding: EdgeInsets.only(left: 10, bottom: 16),
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Customer Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerEmail,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerTotal,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Price Healthy Food Shopping'),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerFoto,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Image'),
            ),
          ),
          SizedBox(height: 16),
          Text("Gender : "),
          SizedBox(height: 8),
          RadioGroup<String>.builder(
            groupValue: _valuegender,
            onChanged: (value) => setState(() {
              _valuegender = value;
            }),
            items: _items,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              updateNewPelanggan();
            },
            child: Text(
              'Update',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
