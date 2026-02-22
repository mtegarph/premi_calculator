# Premi Calculator App

Aplikasi Flutter untuk menghitung premi asuransi jiwa (contoh: Term Life) berdasarkan faktor usia, UP (Up Sum Assured), kelas pekerjaan, frekuensi pembayaran, dan tabel mortalitas. Aplikasi ini dirancang dengan **Clean Architecture**, state management modern, dan penyimpanan lokal yang aman.

## Fitur Utama

- Daftar produk asuransi
- Kalkulasi premi secara real-time berdasarkan input user
- Riwayat perhitungan terakhir disimpan secara lokal (encrypted)
- Lokasi pengguna dicatat saat perhitungan
- UI sederhana & responsif

## Teknologi & Arsitektur yang Digunakan

| Kategori              | Teknologi / Package                          | Keterangan                                      |
|-----------------------|----------------------------------------------|-------------------------------------------------|
| State Management      | flutter_bloc + bloc                          | Event-driven, predictable state                 |
| Dependency Injection  | get_it                                       | Service locator pattern                         |
| Routing               | go_router                                    | Declarative routing, deep linking support       |
| Data Layer            | Hive (with AES encryption)                   | NoSQL lokal, cepat, encrypted box               |
| Model & Entity        | freezed + equatable                          | Immutable data class, value equality            |
| Arsitektur            | Clean Architecture                           | Separation of concerns (domain, data, presentation) |
| Lainnya               | flutter_secure_storage, geolocator, intl     | Key enkripsi, lokasi, formatting mata uang      |


## Struktur Folder (Clean Architecture)
```bash
lib/
├── core/                # konfigurasi global (locator, hive init, dll)
├── features/
│   └── premi/
│       ├── data/        # datasource (Hive), model, repository impl
│       ├── domain/      # entities, usecases, repository abstract
│       └── presentation/
│           ├── bloc/    # PremiBloc, events, states
│           └── pages/   # halaman UI (daftar produk, kalkulator, detail)
|
|
└── app.dart
└── injector.dart
└── main.dart
```
## Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK ≥ 3.16 sudah terinstall
2. Clone repository:
   ```bash
   git clone <repository-url>
   cd premi-calculator
3. install dependencies
    ```bash
    flutter pub get
4. generate file freezed (jika ada perubahan di state bloc)
    ```bash
    dart run build_runner build --delete-conflicting-outputs
5. jalankan aplikasi
  ```bash
  flutter run
  ```
## Catatan penting 
1. aplikasi memerlukan izin lokasi
2. pastikan device/emulator mendukung GPS

## Penggunaan AI dalam Pengembangan

Penggunaan AI dalam Proses Pengembangan

Saya mengerjakan proyek ini secara manual sebagai developer utama, mulai dari merancang arsitektur, menulis logika bisnis, hingga implementasi fitur inti.  

AI saya gunakan sebagai **asisten penolong** di dua area utama:
1. **Desain UI/UX**  
   Membantu saya menyusun layout card produk, dialog hasil premi, styling komponen GestureDetector, serta membuat helper function formatting yang rapi dan konsisten (mata uang, frekuensi pembayaran, kelas pekerjaan).

2. **Validasi & Diskusi Teknis**  
   Digunakan untuk berdiskusi mengenai asumsi rumus premi, penanganan edge case (misalnya umur di luar range), dan konfirmasi apakah pendekatan yang saya ambil sudah sesuai best practice.  
   Namun, rumus perhitungan, struktur Bloc, repository, enkripsi Hive, dan seluruh kode inti tetap saya tulis sendiri — AI tidak menghasilkan atau mengganti bagian tersebut secara otomatis.

Kesimpulan, proyek ini adalah hasil kerja yang saya buat dukungan AI sebagai alat bantu untuk mempercepat desain visual dan memvalidasi ide, bukan produk yang di-generate penuh oleh AI.



