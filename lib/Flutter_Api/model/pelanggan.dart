class Pelanggan {
  String id;
  String nama;
  String email;
  String total;
  String foto;
  String gender;

  Pelanggan({
    this.id,
    this.nama,
    this.email,
    this.total,
    this.foto,
    this.gender,
  });

  factory Pelanggan.fromMap(Map<String, dynamic> map) => Pelanggan(
        id: map['id'],
        nama: map['nama'],
        email: map['email'],
        total: map['total'],
        foto: map['foto'],
        gender: map['gender'],
      );

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'nama': this.nama,
        'email': this.email,
        'total': this.total,
        'foto': this.foto,
        'gender': this.gender,
      };
}
