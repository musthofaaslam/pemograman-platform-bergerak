import 'package:flutter/material.dart';
import 'pages/mahasiswa_page.dart'; // Sesuaikan dengan lokasi folder file MahasiswaPage kamu

void main() async {
  // Wajib ditambahkan agar sqflite bisa berjalan dengan benar saat inisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Data Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Opsional: Menggunakan desain Material 3 yang lebih modern
      ),
      home: MahasiswaPage(),
    );
  }
}