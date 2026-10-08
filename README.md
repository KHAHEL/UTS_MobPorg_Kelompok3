# Aplikasi Pemesanan Makanan

Tugas UTS Mobile Programming - Kelompok 3

Aplikasi pemesanan makanan berbasis Flutter. Aplikasi ini hanya berfokus
pada tampilan (UI), tanpa database, sehingga data menu ditulis langsung di kode.

## Anggota Kelompok

1. Mickael Ravelino 825240073
2. Sanjiro Ozara Liu Tama 825240074
3. Khenji Verdel 825240083

## Fitur

- **Pemilihan menu**: melihat daftar menu dan memilih makanan
- **Kostumisasi menu**: memilih level pedas dan jumlah pesanan
- **Keranjang belanja**: melihat pesanan, mengubah jumlah, dan melihat total harga
- **Pembayaran**: memilih metode pembayaran (Tunai, QRIS, Transfer Bank)

## Alur Aplikasi

Menu -> Keranjang -> Pembayaran

## Struktur Folder

lib/
- main.dart          : titik awal aplikasi, data keranjang, dan format Rupiah
- menu_page.dart     : halaman menu
- cart_page.dart     : halaman keranjang
- payment_page.dart  : halaman pembayaran

## Cara Menjalankan

1. Pastikan Flutter sudah terpasang (cek dengan `flutter doctor`)
2. Clone repository:
   git clone https://github.com/KHAHEL/UTS_MobPorg_Kelompok3.git
3. Masuk ke folder proyek lalu ambil dependency:
   flutter pub get
4. Jalankan aplikasi:
   flutter run

## Screenshot

Halaman Pemilihan Menu
<img width="652" height="872" alt="image" src="https://github.com/user-attachments/assets/103d8818-a0d2-4010-a97c-c79193215340" />

Setelah Memencet "Tambah" di Menu
<img width="657" height="877" alt="image" src="https://github.com/user-attachments/assets/9e9c5337-c186-4cc2-8c12-a6864005de69" />

Halaman Keranjang
<img width="656" height="877" alt="image" src="https://github.com/user-attachments/assets/3913eb46-61da-455c-95ff-9d7ae82f3f97" />

Setelah Memencet Checkout
<img width="658" height="872" alt="image" src="https://github.com/user-attachments/assets/bf011c6c-a2dd-488a-a69e-05d992665373" />

Setelah Memencet "Bayar Sekarang" akan memunculkan pop up
<img width="650" height="868" alt="image" src="https://github.com/user-attachments/assets/02b8922a-4fc0-48df-80d9-e272367082eb" />
