import 'package:healthy_food/Flutter_Api/server/api.dart';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPelanggan extends StatefulWidget {
  @override
  _AddPelangganState createState() => _AddPelangganState();
}

class _AddPelangganState extends State<AddPelanggan> {
  String _valuegender = 'Laki-laki';

  List<String> _items = ['Laki-laki', 'Perempuan'];

  var _controllerNama = TextEditingController();

  var _controllerEmail = TextEditingController();

  var _controllerTotal = TextEditingController();

  var _controllerFoto = TextEditingController();

  void addNewPelanggan() async {
    // var url = '${Api.server}/add_pelanggan.php';
    try {
      var response = await http.post(Api.urlAddPelanggan, body: {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Pelanggan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerNama,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Costumer Name'),
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
          SizedBox(
            height: 8,
          ),
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
          SizedBox(height: 8),
          Text("Gender"),
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
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              addNewPelanggan();
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
