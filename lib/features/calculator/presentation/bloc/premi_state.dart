part of 'premi_bloc.dart';

@freezed
class PremiState with _$PremiState {
  const factory PremiState(
      {required List<Datum> product,
      required Datum? selectedProduct,
      required Option<Failure> failed,
      required Option<Failure> failureCalcucation,
      required bool isLoading,
      required TextEditingController ageController,
      required TextEditingController upController,
      required double classWork,
      required double premiUser,
      required double ratePerMille,
      required PremiUserResult? premiUserResult,
      required double paymentMethod}) = _AboutState;

  factory PremiState.initial() => PremiState(
      failed: const None(),
      isLoading: false,
      product: [],
      ageController: TextEditingController(),
      selectedProduct: null,
      upController: TextEditingController(),
      classWork: 0,
      paymentMethod: 0,
      premiUserResult: null,
      premiUser: 0,
      failureCalcucation: const None(),
      ratePerMille: 0);
}
