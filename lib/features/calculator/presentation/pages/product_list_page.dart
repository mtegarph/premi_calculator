import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/features/calculator/presentation/bloc/premi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Premi Nasabah'),
      ),
      body: BlocBuilder<PremiBloc, PremiState>(
        buildWhen: (previous, current) =>
            previous.product != current.product ||
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          if (state.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.failed.isSome()) {
            return Center(
                child: Text(state.failed
                    .getOrElse(
                      () => const Failure.unknown(message: 'errir'),
                    )
                    .message));
          }
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Pilih Produk Asuransi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.product.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = state.product[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/premi-calculator', extra: data);
                        context
                            .read<PremiBloc>()
                            .add(PremiEvent.selectedProduct(data));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.grey.shade50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              data.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                height:
                                    1.3, // agar deskripsi lebih mudah dibaca
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.info_outline,
                                    size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Text(
                                  'Min Age: ${data.minEntryAge} • Max: ${data.maxEntryAge}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (state.premiUserResult != null) ...[
                  const Text(
                    "Hasil Akhir Perhitungan Nasabah",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Tampilkan dialog detail saat ditekan
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text(
                              'Detail Perhitungan Premi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow(
                                    label: 'Produk ID',
                                    value:
                                        state.premiUserResult?.productId ?? '-',
                                  ),
                                  _buildDetailRow(
                                    label: 'Nama Produk',
                                    value: state.premiUserResult?.productName ??
                                        '-',
                                  ),
                                  _buildDetailRow(
                                    label: 'Usia',
                                    value:
                                        '${state.premiUserResult?.age ?? '-'} tahun',
                                  ),
                                  _buildDetailRow(
                                    label: 'UP (Up Sum Assured)',
                                    value: _formatCurrency(
                                        state.premiUserResult?.up ?? 0),
                                  ),
                                  _buildDetailRow(
                                    label: 'Kelas Pekerjaan',
                                    value: _formatOccupationalClass(state
                                        .premiUserResult?.occupationalClass),
                                  ),
                                  _buildDetailRow(
                                    label: 'Frekuensi Pembayaran',
                                    value: _formatPaymentFrequency(state
                                            .premiUserResult
                                            ?.paymentFrequency ??
                                        '1.0'),
                                  ),
                                  _buildDetailRow(
                                    label: 'Premi yang Dihitung',
                                    value: _formatCurrency(state.premiUserResult
                                            ?.calculatedPremium ??
                                        0),
                                    isBold: true,
                                  ),
                                  const Divider(height: 24),
                                  _buildDetailRow(
                                    label: 'Lokasi',
                                    value:
                                        'Lat: ${state.premiUserResult?.latitude.toStringAsFixed(6) ?? '-'} \nLong: ${state.premiUserResult?.longitude.toStringAsFixed(6) ?? '-'}',
                                  ),
                                  _buildDetailRow(
                                    label: 'Waktu Perhitungan',
                                    value: _formatDateTime(
                                        state.premiUserResult?.timestamp ??
                                            DateTime.now()),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(),
                                child: const Text('Tutup'),
                              ),
                              // Optional: tombol hapus jika kamu punya fungsi clear
                              // TextButton(
                              //   onPressed: () {
                              //     // logic hapus data lokal
                              //     context.read<PremiBloc>().add(ClearPremiUser());
                              //     Navigator.of(dialogContext).pop();
                              //   },
                              //   child: const Text('Hapus Data', style: TextStyle(color: Colors.red)),
                              // ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.grey.shade50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.premiUserResult?.productName ??
                                'Produk Tidak Diketahui',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Premi: ${_formatCurrency(state.premiUserResult?.calculatedPremium ?? 0)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Usia: ${state.premiUserResult?.age ?? '-'} tahun • UP: ${_formatCurrency(state.premiUserResult?.up ?? 0)}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  String _formatPaymentFrequency(String? freqValue) {
    if (freqValue == null || freqValue.isEmpty) return 'Tidak Diketahui';

    final value = double.tryParse(freqValue) ?? 1.0;

    switch (value.toStringAsFixed(2)) {
      case '1.00':
        return 'Bulanan';
      case '0.98':
        return 'Triwulanan (Kuartalan)';
      case '0.96':
        return 'Semesteran';
      case '0.92':
        return 'Tahunan';
      case '0.90':
        return 'Tahunan (Diskon Besar)';
      default:
        final discountPercent = ((1 - value) * 100).toStringAsFixed(0);
        return 'Frekuensi Lain ($discountPercent% diskon)';
    }
  }

  String _formatOccupationalClass(String? classValue) {
    if (classValue == null || classValue.isEmpty) return 'Tidak Diketahui';

    final multiplier = double.tryParse(classValue) ?? 1.0;

    // Mapping berdasarkan multiplier (cocok untuk kedua struktur JSON)
    // Kamu bisa sesuaikan labelnya sesuai kebutuhan bisnis/produk
    switch (multiplier.toStringAsFixed(1)) {
      case '1.0':
        return 'Kelas 1 - Risiko Rendah (Standar)';
      case '1.2':
        return 'Kelas 2 - Risiko Sedang';
      case '1.5':
        return 'Kelas 2 / 3 - Risiko Sedang-Tinggi';
      case '2.0':
        return 'Kelas 4 - Risiko Tinggi';
      case '2.5':
        return 'Kelas 3 - Risiko Tinggi';
      case '4.0':
        return 'Kelas 4 - Risiko Sangat Tinggi';
      default:
        return 'Kelas Lain (Faktor $multiplier)';
    }
  }

  String _formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy • HH:mm').format(date);
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold ? 16 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
