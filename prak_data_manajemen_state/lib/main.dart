import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'mahasiswa.dart';
import 'prodi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    // Registrasi Adapter
    Hive.registerAdapter(MahasiswaAdapter());
    Hive.registerAdapter(ProdiAdapter());

    // Buka Box
    await Hive.openBox<Mahasiswa>('mahasiswaBox');
    await Hive.openBox<Prodi>('prodiBox');

    var prodiBox = Hive.box<Prodi>('prodiBox');
    if (prodiBox.isEmpty) {
      await prodiBox.addAll([
        Prodi(namaProdi: "Informatika"),
        Prodi(namaProdi: "Biologi"),
        Prodi(namaProdi: "Fisika"),
      ]);
    }

    runApp(MyApp());
  } catch (e) {
    // Ini akan menampilkan error di console jika ada masalah saat startup
    print("Error saat inisialisasi: $e");
  }
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MahasiswaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MahasiswaPage extends StatefulWidget {
  @override
  _MahasiswaPageState createState() => _MahasiswaPageState();
}

// ... (Bagian import dan main tetap sama)

class _MahasiswaPageState extends State<MahasiswaPage> {
  final Box<Mahasiswa> box = Hive.box<Mahasiswa>('mahasiswaBox');
  final Box<Prodi> prodiBox = Hive.box<Prodi>('prodiBox'); // Berikan tipe generic agar aman

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  // prodiController tidak perlu jika pakai dropdown int

  int? editIndex;
  int? selectedProdiId;

  void saveData() {
    // Validasi sederhana agar tidak simpan data kosong
    if (namaController.text.isEmpty || selectedProdiId == null) return;

    final mahasiswa = Mahasiswa(
      nama: namaController.text,
      nim: nimController.text,
      // Simpan sebagai String jika modelmu minta String, 
      // tapi lebih baik model Mahasiswa menggunakan tipe int untuk prodiId
      prodiId: selectedProdiId.toString(), 
    );

    setState(() {
      if (editIndex == null) {
        box.add(mahasiswa);
      } else {
        box.putAt(editIndex!, mahasiswa);
        editIndex = null;
      }
      clearForm();
    });
  }

  void editData(int index) {
    final data = box.getAt(index)!;

    setState(() {
      namaController.text = data.nama;
      nimController.text = data.nim;
      // Parsing kembali ke int karena kita simpan sebagai String tadi
      selectedProdiId = int.tryParse(data.prodiId);
      editIndex = index;
    });
  }

  void deleteData(int index) {
    setState(() {
      box.deleteAt(index);
    });
  }

  void clearForm() {
    namaController.clear();
    nimController.clear();
    selectedProdiId = null;
    editIndex = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD Mahasiswa - Hive")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: nimController,
              decoration: InputDecoration(labelText: "NIM"),
            ),
            DropdownButtonFormField<int>(
              value: selectedProdiId, // Gunakan value, bukan initialValue
              hint: Text("Pilih Prodi"),
              items: List.generate(prodiBox.length, (index) {
                final prodi = prodiBox.getAt(index);
                return DropdownMenuItem(
                  value: index,
                  child: Text(prodi!.namaProdi),
                );
              }),
              onChanged: (value) {
                setState(() {
                  selectedProdiId = value;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: saveData,
                  child: Text(editIndex == null ? "Simpan" : "Update"),
                ),
                SizedBox(width: 10),
                if (editIndex != null)
                  ElevatedButton(
                    onPressed: clearForm,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text("Batal"),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box<Mahasiswa> box, _) {
                  if (box.isEmpty) {
                    return Center(child: Text("Belum ada data"));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final data = box.getAt(index)!;
                      
                      // AMBIL DATA PRODI BERDASARKAN ID
                      int? pId = int.tryParse(data.prodiId);
                      final prodi = (pId != null) ? prodiBox.getAt(pId) : null;

                      return Card(
                        child: ListTile(
                          title: Text(data.nama),
                          subtitle: Text(
                            "NIM: ${data.nim} | Prodi: ${prodi?.namaProdi ?? '-'}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => editData(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteData(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}