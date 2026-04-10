import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String dataDiterima;

  // Constructor untuk menerima data
  const DetailPage({super.key, required this.dataDiterima});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Detail")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Data yang dikirim:"),
            Text(
              dataDiterima, 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}