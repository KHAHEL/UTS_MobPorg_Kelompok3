import 'package:flutter/material.dart';
import 'menu_page.dart';

class RestoranPage extends StatefulWidget {
  const RestoranPage({super.key});

  @override
  State<RestoranPage> createState() => _RestoranPageState();
}

class _RestoranPageState extends State<RestoranPage> {
  // Pilihan hanya untuk tampilan, tidak disimpan ke database.
  String? restoranDipilih;

  final List<String> daftarRestoran = [
    'Restoran Nusantara',
    'Warung Pak Budi',
    'Dapur Kita',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Pilih Restoran'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant, size: 80, color: Colors.blue),
                const SizedBox(height: 16),
                const Text(
                  'Mau makan di mana?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text('Pilih restoran untuk mulai memesan.'),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Nama Restoran',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: const Text('Pilih restoran'),
                  isExpanded: true,
                  items: daftarRestoran.map((nama) {
                    return DropdownMenuItem<String>(
                      value: nama,
                      child: Text(nama),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      restoranDipilih = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: restoranDipilih == null
                        ? null
                        : () {
                      // Semua pilihan menuju menu yang sama.
                      // Ganti halaman agar menu menjadi halaman utama.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Masuk ke Pemesanan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
