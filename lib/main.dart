import 'package:flutter/material.dart';
import 'restoran_page.dart';

void main() {
  runApp(const MyApp());
}

List<Map<String, dynamic>> cart = [];

String formatRupiah(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final posFromEnd = s.length - i;
    buffer.write(s[i]);
    if (posFromEnd > 1 && posFromEnd % 3 == 1) {
      buffer.write('.');
    }
  }
  return 'Rp$buffer';
}

int get totalItems => cart.fold(0, (sum, p) => sum + (p['quantity'] as int));

int get totalPrice => cart.fold(
    0, (sum, p) => sum + ((p['quantity'] as int) * (p['price'] as int)));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pesan Makanan',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const RestoranPage(),
    );
  }
}