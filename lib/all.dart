import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Data keranjang dibuat di luar class supaya bisa dipakai semua halaman
List<Map<String, dynamic>> cart = [];

String _formatRupiah(int value) {
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
      home: const MenuPage(),
    );
  }
}

// ===================== HALAMAN MENU =====================
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
      'icon': Icons.rice_bowl,
      'quantity': 1,
      'level': 'Sedang',
    },
    {
      'name': 'Mie Ayam',
      'subtitle': 'Mie ayam bakso',
      'price': 20000,
      'icon': Icons.ramen_dining,
      'quantity': 1,
      'level': 'Sedang',
    },
    {
      'name': 'Sate Ayam',
      'subtitle': '10 tusuk + lontong',
      'price': 30000,
      'icon': Icons.kebab_dining,
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
      // cek apakah menu dengan level yang sama sudah ada di keranjang
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
              CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(menu['icon'], color: Colors.blue),
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
                      _formatRupiah(menu['price']),
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

// ===================== HALAMAN KERANJANG =====================
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _changeQuantity(Map<String, dynamic> item, int delta) {
    setState(() {
      item['quantity'] += delta;
      if (item['quantity'] <= 0) {
        cart.remove(item);
      }
    });
  }

  Widget _buildCartCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pedas: ${item['level']}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatRupiah(item['price'] * item['quantity']),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _changeQuantity(item, -1),
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
              '${item['quantity']}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          GestureDetector(
            onTap: () => _changeQuantity(item, 1),
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
        title: const Text('Keranjang'),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Keranjang masih kosong'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cart.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCartCard(cart[index]),
        ),
      ),

      // Footer
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total ($totalItems produk)',
                      style:
                      TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    Text(
                      _formatRupiah(totalPrice),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: cart.isEmpty
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== HALAMAN PEMBAYARAN =====================
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<String> methods = ['Tunai', 'QRIS', 'Transfer Bank'];
  String selectedMethod = 'QRIS';

  Widget _buildMethodCard(String method) {
    final bool isSelected = selectedMethod == method;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = method),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(method, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  void _bayar() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pembayaran Berhasil'),
        content: Text('Dibayar dengan $selectedMethod.'),
        actions: [
          TextButton(
            onPressed: () {
              cart.clear();
              Navigator.pop(dialogContext); // tutup dialog
              Navigator.popUntil(context, (route) => route.isFirst); // ke menu
            },
            child: const Text('OK'),
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
        title: const Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Pembayaran',
                style: TextStyle(color: Colors.grey.shade600)),
            Text(
              _formatRupiah(totalPrice),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Metode Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...methods.map((m) => _buildMethodCard(m)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _bayar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Bayar Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}