import 'package:flutter/material.dart';
import 'main.dart';

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
              formatRupiah(totalPrice),
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