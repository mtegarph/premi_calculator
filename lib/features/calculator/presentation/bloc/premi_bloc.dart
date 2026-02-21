import 'dart:developer';

import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/core/use_case/utils.dart';
import 'package:calculator_agen/features/calculator/domain/entities/premi_user_result.dart';
import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:calculator_agen/features/calculator/domain/usecases/get_list_product_use_case.dart';
import 'package:calculator_agen/features/calculator/domain/usecases/get_premi_user_use_case.dart';
import 'package:calculator_agen/features/calculator/domain/usecases/set_premi_user_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'premi_event.dart';
part 'premi_state.dart';
part 'premi_bloc.freezed.dart';

class PremiBloc extends Bloc<PremiEvent, PremiState> {
  final GetProductList getProductList;
  final SetPremiUser setPremiUser;
  final GetPremiUser getPremiUser;

  PremiBloc(this.getProductList, this.getPremiUser, this.setPremiUser)
      : super(PremiState.initial()) {
    on<GetProductListEvent>(_getProductList);

    on<UpdateAge>(_updateAge);
    on<UpdateUP>(_updateUP);
    on<UpdateClassWork>(_updateClass);
    on<UpdatePaymentMethod>(_updatePayment);
    on<CalculatePremium>(_performCalculation);
    on<SelectedProduct>(_selectedProduct);
    on<GetPremiUserLocal>(_getPremiUserLocal);
  }
  Future<void> _getPremiUserLocal(
      GetPremiUserLocal event, Emitter<PremiState> emit) async {
    log('manggil data lokal');
    emit(state.copyWith(isLoading: true));

    final result = await getPremiUser(const None());

    result.fold(
      (l) => emit(state.copyWith(failed: some(l), isLoading: false)),
      (r) {
        emit(state.copyWith(premiUserResult: r, isLoading: false));
      },
    );
  }

  void _performCalculation(CalculatePremium event, Emitter emit) async {
    final age = int.parse(state.ageController.text);
    final up = double.parse(state.upController.text);
    final classWork = state.classWork;
    final paymentDiscount = state.paymentMethod;
    log('masuk perhitungan');
    if (up <= 0 || age <= 0) {
      emit(state.copyWith(
          failureCalcucation: some(const Failure.invalidArgs(
              message: 'Data tidak boleh kosong atau dibawah 0'))));
      return;
    }
    try {
      if (age < state.selectedProduct!.minEntryAge ||
          age > state.selectedProduct!.maxEntryAge) {
        emit(state.copyWith(
            failureCalcucation: some(Failure.invalidArgs(
                message:
                    'Umur harus antara ${state.selectedProduct!.minEntryAge}–${state.selectedProduct!.maxEntryAge} tahun'))));
        return;
      }

      final mortalityRate =
          findMortalityRate(state.selectedProduct!.setup.mortalityTable, age);
      if (mortalityRate == null) {
        emit(state.copyWith(
            failureCalcucation: some(const Failure.invalidArgs(
                message: 'Tidak ada mortaliti rate di umur ini'))));
        return;
      }

      final premium = (up / 1000) * mortalityRate * classWork * paymentDiscount;
      final finalPremium = premium + (state.selectedProduct!.setup.adminFee);
      final position = await Geolocator.getCurrentPosition();
      final localSavePremi = PremiUserResult(
          productId: state.selectedProduct?.id ?? '',
          productName: state.selectedProduct?.name ?? '',
          age: age,
          up: up,
          occupationalClass: classWork.toString(),
          paymentFrequency: paymentDiscount.toString(),
          calculatedPremium: finalPremium,
          timestamp: DateTime.now(),
          latitude: position.latitude,
          longitude: position.longitude);
      await setPremiUser(localSavePremi);

      emit(state.copyWith(
        premiUser: finalPremium,
      ));
    } catch (e) {
      emit(state.copyWith(
          premiUser: 0,
          failureCalcucation: some(const Failure.invalidArgs(
              message: 'Gagal Menghitung Premi User'))));
    }
  }

  double? findMortalityRate(List<MortalityTable> table, int age) {
    for (var entry in table) {
      final parts = entry.ageRange.split('-').map(int.tryParse).toList();

      if (parts.length == 2 &&
          age >= (parts[0] ?? 0) &&
          age <= (parts[1] ?? 0)) {
        return entry.ratePerMille;
      }
    }
    return null;
  }

  void _updateClass(UpdateClassWork event, Emitter emit) {
    final product = state.selectedProduct;
    if (product == null) return;

    final kelas = event.classPick;

    final data = {
      'Kelas 1': product.setup.occupationalClassMultiplier.class1,
      'Kelas 2': product.setup.occupationalClassMultiplier.class2,
      'Kelas 3': product.setup.occupationalClassMultiplier.class3,
      'Kelas 4': product.setup.occupationalClassMultiplier.class4,
    };

    if (!data.containsKey(kelas)) {
      log('Warning: Unknown occupational class → $kelas');
      emit(state.copyWith(classWork: 1.0));
      return;
    }

    final multiplier = data[kelas]!;
    emit(state.copyWith(
        classWork: multiplier, failureCalcucation: const None()));
    log('data update kelas ${state.classWork}');
  }

  void _updatePayment(UpdatePaymentMethod event, Emitter emit) {
    final product = state.selectedProduct;
    if (product == null) return;

    emit(state.copyWith(
        paymentMethod: event.discount, failureCalcucation: const None()));
    log('data update payment ${state.paymentMethod}');
  }

  void _selectedProduct(SelectedProduct event, Emitter emit) {
    emit(state.copyWith(
        selectedProduct: event.product,
        ageController: TextEditingController(),
        classWork: 0,
        paymentMethod: 0,
        premiUser: 0,
        ratePerMille: 0,
        upController: TextEditingController()));
  }

  void _updateAge(UpdateAge event, Emitter emit) {
    final cleanAge = event.age.replaceAll(RegExp(r'[^0-9]'), '');
    state.ageController.text = cleanAge;
    emit(state.copyWith(
        ageController: TextEditingController(text: cleanAge),
        failureCalcucation: const None()));
    log('data update umur ${state.ageController.text}');
  }

  void _updateUP(UpdateUP event, Emitter emit) {
    emit(state.copyWith(
        upController: TextEditingController(text: event.up),
        failureCalcucation: const None()));
    log('data update Up ${state.upController.text}');
  }

  Future<void> _getProductList(
      GetProductListEvent event, Emitter<PremiState> emit) async {
    emit(state.copyWith(isLoading: true));
    final permissionResult = await _ensurePermission(true);
    if (!permissionResult.$1) {
      throw Failure.permissionNotGranted(
        message: ensureErrorMessage(
          '[${permissionResult.$2}] Permission is not granted',
        ),
      );
    }

    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw Failure.serviceNotAvailable(
        message: ensureErrorMessage(
          'Location service is not available or disabled',
        ),
      );
    }
    log('masuk kesini');
    final result = await getProductList(const None());

    result.fold(
      (l) => emit(state.copyWith(failed: some(l), isLoading: false)),
      (r) {
        emit(state.copyWith(product: r, isLoading: false));
      },
    );
  }

  Future<(bool, LocationPermission)> _ensurePermission(
      bool shouldRequest) async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        break;
      case LocationPermission.denied:
        if (shouldRequest) {
          permission = await Geolocator.requestPermission();
          if (permission
              case == LocationPermission.always ||
                  == LocationPermission.whileInUse) {
            return (true, permission);
          }
        }
        break;
      default:
        return (true, permission);
    }
    return (false, permission);
  }
}
