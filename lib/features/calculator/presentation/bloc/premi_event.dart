part of 'premi_bloc.dart';

@freezed
class PremiEvent with _$PremiEvent {
  const factory PremiEvent.started() = _Started;

  const factory PremiEvent.getProductListEvent() = GetProductListEvent;

  const factory PremiEvent.updateAge(String age) = UpdateAge;
  const factory PremiEvent.updateUP(String up) = UpdateUP;
  const factory PremiEvent.updateClassWork(String classPick) = UpdateClassWork;
  const factory PremiEvent.updatePaymentMethod(double discount) =
      UpdatePaymentMethod;
  const factory PremiEvent.selectedProduct(Datum product) = SelectedProduct;
  const factory PremiEvent.calculate() = CalculatePremium;
  const factory PremiEvent.loadLastCalculation() = LoadLastCalculation;
  const factory PremiEvent.getPremiUserLocal() = GetPremiUserLocal;
}
