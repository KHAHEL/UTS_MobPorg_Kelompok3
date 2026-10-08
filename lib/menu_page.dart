import 'package:flutter/material.dart';
import 'main.dart';
import 'keranjang_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Map<String, dynamic>> menus = [
    {
      'name': 'Nasi Goreng',
      'subtitle': 'Nasi goreng spesial + telur',
      'price': 25000,
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8yxPqooYoS0ezAmESxpnWkPDdOW7yaPxIy6SuO3UwEA&s=10',
      'quantity': 1,
      'level': 'Sedang',
    },
    {
      'name': 'Mie Ayam',
      'subtitle': 'Mie ayam bakso',
      'price': 20000,
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRicPM06BK6A297Q--5JuXOJx-Nn8DVi-5NT3D2weudcQ&s=10',
      'quantity': 1,
      'level': 'Sedang',
    },
    {
      'name': 'Sate Ayam',
      'subtitle': '10 tusuk',
      'price': 20000,
      'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXCNPtWNj7jijvLKpKqDRaqlcH1FlDBEsEs5nD2uVCgg&s=10',
      'quantity': 1,
      'level': 'Sedang',
    },
  ];

  final List<String> levels = ['Tidak Pedas', 'Sedang', 'Pedas'];

  void _changeQuantity(Map<String, dynamic> menu, int delta) {
    setState(() {
      final newQty = menu['quantity'] + delta;
      menu['quantity'] = newQty < 1 ? 1 : newQty;
    });
  }

  void _setLevel(Map<String, dynamic> menu, String level) {
    setState(() {
      menu['level'] = level;
    });
  }

  void _addToCart(Map<String, dynamic> menu) {
    setState(() {
      Map<String, dynamic>? found;
      for (final item in cart) {
        if (item['name'] == menu['name'] && item['level'] == menu['level']) {
          found = item;
        }
      }

      if (found != null) {
        found['quantity'] += menu['quantity'];
      } else {
        cart.add({
          'image': menu['image'],
          'name': menu['name'],
          'price': menu['price'],
          'level': menu['level'],
          'quantity': menu['quantity'],
        });
      }

      menu['quantity'] = 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${menu['name']} masuk keranjang')),
    );
  }

  Widget _buildMenuCard(Map<String, dynamic> menu) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  menu['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade100,
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.blueGrey, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      menu['subtitle'],
                      style:
                      TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatRupiah(menu['price']),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Kostumisasi: level pedas
          Wrap(
            spacing: 8,
            children: levels.map((l) {
              return ChoiceChip(
                label: Text(l, style: const TextStyle(fontSize: 12)),
                selected: menu['level'] == l,
                onSelected: (_) => _setLevel(menu, l),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Jumlah + tombol tambah
          Row(
            children: [
              GestureDetector(
                onTap: () => _changeQuantity(menu, -1),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.remove, size: 14, color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 28,
                child: Text(
                  '${menu['quantity']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              GestureDetector(
                onTap: () => _changeQuantity(menu, 1),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, size: 14, color: Colors.blue),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _addToCart(menu),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Tambah'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Menu'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  ).then((_) => setState(() {}));
                },
              ),
              if (totalItems > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$totalItems',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menus.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMenuCard(menus[index]),
        ),
      ),
    );
  }
}