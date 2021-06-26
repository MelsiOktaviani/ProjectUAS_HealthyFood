

class Penjualan {
  int _id;
  String _name;
  String _desc;
  String _jumlah;
  String _tanggal;

  Penjualan(this._name, this._desc, this._jumlah, this._tanggal);
  Penjualan.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'].toString();
    this._desc = map['desc'].toString();
    this._jumlah = map['jumlah'].toString();
    this._tanggal = map['tanggal'].toString();
  }

  int get id => _id;
  String get name => _name;
  String get desc => _desc;
  String get jumlah => _jumlah;
  String get tanggal => _tanggal;

  set name(String value) {
    _name = value;
  }

  set desc(String value) {
    _desc = value;
  }

  set jumlah(String value) {
    _jumlah = value;
  }

  set tanggal(String value) {
    _tanggal = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = this._name;
    map['desc'] = this._desc;
    map['jumlah'] = this._jumlah;
    map['tanggal'] = this._tanggal;
    return map;
  }
}