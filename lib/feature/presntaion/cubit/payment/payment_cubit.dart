import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease/core/network/dio.dart';
import 'package:shopease/core/unit/app_constance.dart';
import 'package:shopease/models/authentication_request_model.dart';
import 'package:shopease/models/order_registration_model.dart';
import 'package:shopease/models/payment_reqeust_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitialStates());
  static PaymentCubit get(context) => BlocProvider.of(context);
  AuthenticationRequestModel? authTokenModel;
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    DioHelperPayment.postData(url: AppConstance.getAuthToken, data: {
      'api_key': AppConstance.paymentApiKey,
    }).then((value) {
      authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      AppConstance.paymentFirstToken = authTokenModel!.token;
      print('The token 🍅');
      emit(PaymentAuthSuccessStates());
    }).catchError((error) {
      print('Error in auth token 🤦‍♂️');
      emit(
        PaymentAuthErrorStates(error.toString()),
      );
    });
  }

  Future getOrderRegistrationID({
    required String price,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    DioHelperPayment.postData(url: AppConstance.getOrderId, data: {
      'auth_token': AppConstance.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      OrderRegistrationModel orderRegistrationModel =
          OrderRegistrationModel.fromJson(value.data);
      AppConstance.paymentOrderId = orderRegistrationModel.id.toString();
      getPaymentRequest(price);
      print('The order id 🍅 =${AppConstance.paymentOrderId}');
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print('Error in order id 🤦‍♂️');
      emit(
        PaymentOrderIdErrorStates(error.toString()),
      );
    });
  }

  // for final request token

  Future<void> getPaymentRequest(
    String priceOrder,
  ) async {
    emit(PaymentRequestTokenLoadingStates());
    DioHelperPayment.postData(
      url: AppConstance.getPaymentRequest,
      data: {
        "auth_token": AppConstance.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": AppConstance.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": 'email@gmail.com',
          "floor": "NA",
          "first_name": 'firstName',
          "street": "NA",
          "building": "NA",
          "phone_number": '01024657305',
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": 'lastName',
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": AppConstance.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      PaymentRequestModel paymentRequestModel =
          PaymentRequestModel.fromJson(value.data);
      AppConstance.finalToken = paymentRequestModel.token;
      print('Final token 🚀 ${AppConstance.finalToken}');
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print('Error in final token 🤦‍♂️');
      emit(
        PaymentRequestTokenErrorStates(error.toString()),
      );
    });
  }

 
}
