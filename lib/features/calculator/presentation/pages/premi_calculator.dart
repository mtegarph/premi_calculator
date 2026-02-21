import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/core/utils.dart';
import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:calculator_agen/features/calculator/presentation/bloc/premi_bloc.dart';
import 'package:calculator_agen/features/calculator/presentation/widgets/dialog_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PremiCalculator extends StatelessWidget {
  final Datum data;
  const PremiCalculator({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          context.read<PremiBloc>().add(const PremiEvent.getPremiUserLocal());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(data.name),
        ),
        body: BlocConsumer<PremiBloc, PremiState>(
          buildWhen: (previous, current) =>
              previous.ageController != current.ageController ||
              previous.premiUser != current.premiUser,
          listener: (context, state) {
            if (state.failureCalcucation.isSome()) {
              showFailureDialog(
                  context,
                  state.failureCalcucation
                      .getOrElse(() => const Failure.unknown(message: 'error'))
                      .message);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: state.ageController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Umur',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      final cleanValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                      context
                          .read<PremiBloc>()
                          .add(PremiEvent.updateUP(cleanValue));
                    },
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: state.upController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Uang Pertanggungan (IDR)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Format otomatis ke IDR (Rp 1.000.000)
                      final cleanValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                      final formatted = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(int.tryParse(cleanValue) ?? 0);
                      state.upController.value = TextEditingValue(
                        text: formatted,
                        selection:
                            TextSelection.collapsed(offset: formatted.length),
                      );
                      context
                          .read<PremiBloc>()
                          .add(PremiEvent.updateUP(cleanValue));
                    },
                  ),
                  const SizedBox(height: 16),

                  // Dropdown Kelas Pekerjaan
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Kelas Pekerjaan',
                      border: OutlineInputBorder(),
                    ),
                    items: classwork.map((label) {
                      return DropdownMenuItem<String>(
                        value: label,
                        child: Text(label),
                      );
                    }).toList(),
                    onChanged: (label) {
                      if (label != null) {
                        context
                            .read<PremiBloc>()
                            .add(PremiEvent.updateClassWork(label));
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Dropdown Metode Pembayaran
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Metode Pembayaran',
                      border: OutlineInputBorder(),
                    ),
                    items: buildAvailableFrequencyItems(
                        state.selectedProduct?.setup.frequencyDiscount),
                    onChanged: (label) {
                      if (label != null) {
                        final dataPick = {
                          'Monthly': data.setup.frequencyDiscount.monthly,
                          'Quarterly': data.setup.frequencyDiscount.quarterly,
                          'Semi Annually':
                              data.setup.frequencyDiscount.semiAnnually,
                          'Annually': data.setup.frequencyDiscount.annually
                        };

                        final discount = dataPick[label];

                        context
                            .read<PremiBloc>()
                            .add(PremiEvent.updatePaymentMethod(discount!));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                      onPressed: () {
                        context
                            .read<PremiBloc>()
                            .add(const PremiEvent.calculate());
                      },
                      child: const Text('Hitung')),

                  if (state.premiUser != 0) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Estimasi Premi: Rp ${NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(state.premiUser)}'),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String? _validateAge(String value, int min, int max) {
    final age = int.tryParse(value);
    if (age == null) return 'Masukkan umur valid';
    if (age < min || age > max) return 'Umur harus antara $min - $max';
    return null;
  }
}
