part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitialStates extends PaymentState {}

class PaymentAuthLoadingStates extends PaymentState {}

class PaymentAuthSuccessStates extends PaymentState {}

class PaymentAuthErrorStates extends PaymentState {
  final String error;
  PaymentAuthErrorStates(this.error);
}

// for order id
class PaymentOrderIdLoadingStates extends PaymentState {}

class PaymentOrderIdSuccessStates extends PaymentState {}

class PaymentOrderIdErrorStates extends PaymentState {
  final String error;
  PaymentOrderIdErrorStates(this.error);
}

// for request token
class PaymentRequestTokenLoadingStates extends PaymentState {}

class PaymentRequestTokenSuccessStates extends PaymentState {}

class PaymentRequestTokenErrorStates extends PaymentState {
  final String error;
  PaymentRequestTokenErrorStates(this.error);
}

// for ref code
class PaymentRefCodeLoadingStates extends PaymentState {}

class PaymentRefCodeSuccessStates extends PaymentState {}

class PaymentRefCodeErrorStates extends PaymentState {
  final String error;
  PaymentRefCodeErrorStates(this.error);
}
