class Mahasiswa {
  final int? id;
  final String nama;
  final String nim;
  final String prodi;

  Mahasiswa({this.id, required this.nama, required this.nim, required this.prodi});

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: int.parse(json['id'].toString()),
      nama: json['nama'],
      nim: json['nim'],
      prodi: json['prodi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "nim": nim,
      "prodi": prodi,
    };
  }
}