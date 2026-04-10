import 'package:flutter/material.dart';
import 'mahasiswa.dart';
import 'mahasiswa_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  List data = [];

  final namaC = TextEditingController();
  final nimC = TextEditingController();
  final prodiC = TextEditingController();

  int? selectedId;

  void getData() async {
    final result = await ApiService.getData();
    setState(() {
      data = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void submit() async {
    final mhs = Mahasiswa(
      id: selectedId,
      nama: namaC.text,
      nim: nimC.text,
      prodi: prodiC.text,
    );

    if (selectedId == null) {
      await ApiService.createData(mhs);
    } else {
      await ApiService.updateData(mhs);
    }

    clearForm();
    getData();
  }

  void clearForm() {
    namaC.clear();
    nimC.clear();
    prodiC.clear();
    selectedId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD Mahasiswa")),
      body: Column(
        children: [
          // FORM
          TextField(
            controller: namaC,
            decoration: InputDecoration(labelText: "Nama"),
          ),
          TextField(
            controller: nimC,
            decoration: InputDecoration(labelText: "NIM"),
          ),
          TextField(
            controller: prodiC,
            decoration: InputDecoration(labelText: "Prodi"),
          ),

          ElevatedButton(
            onPressed: submit,
            child: Text(selectedId == null ? "Tambah" : "Update"),
          ),

          Divider(),

          // LIST
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final m = data[index];

                return ListTile(
                  title: Text(m.nama),
                  subtitle: Text("${m.nim} - ${m.prodi}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDIT
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            selectedId = m.id;
                            namaC.text = m.nama;
                            nimC.text = m.nim;
                            prodiC.text = m.prodi;
                          });
                        },
                      ),

                      // DELETE
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await ApiService.deleteData(m.id!);
                          getData();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

