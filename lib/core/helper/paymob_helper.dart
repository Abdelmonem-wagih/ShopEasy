// import 'package:dio/dio.dart';
// import 'package:shopease/core/unit/app_constance.dart';

// class PaymobHelper {
//   Dio dio = Dio();

//   Future<String> payWithPaymob({required double amount}) async {
//     try {
//       String token = await getToken();
//       int orderId = await getOrderId(
//         token: token,
//         amount: (100 * amount).toString(),
//       );
//       String paymobKey = await getPaymobKey(
//         token: token,
//         orderId: orderId.toString(),
//         amount: (100 * amount).toString(),
//       );

//       return paymobKey;
//     } catch (e) {
//       rethrow;
//     }
//   }
// /////////////////////////////////////////////////

//   Future<String> getToken() async {
//     try {
//       Response response = await dio.post(
//         'https://accept.paymob.com/api/auth/tokens',
//         data: {'api_key': AppConstance.paymobApiKey},
//       );
//       print(
//           '==================================================================================');
//       print('Token =>>>>>>>>>>>>>>${response.data['token']}');
//       print(
//           '==================================================================================');

//       return response.data['token'];
//     } catch (e) {
//       rethrow;
//     }
//   }

// ////////////////////////////////////////////////
//   ///
//   Future<int> getOrderId(
//       {required String token, required String amount}) async {
//     try {
//       Response response = await dio.post(
//         'https://accept.paymob.com/api/ecommerce/orders',
//         data: {
//           'auth_token': token,
//           'delivery_needed': 'true',
//           'amount_cents': amount,
//           'currency': 'EGP',
//           'item': [],
//         },
//       );
//       print(
//           '==================================================================================');
//       print('Token =>>>>>>>>>>>>>>${response.data['id']}');
//       print(
//           '==================================================================================');
//       return response.data['id'];
//     } catch (e) {
//       rethrow;
//     }
//   }

// //////////////////////////////////////////
//   Future<String> getPaymobKey({
//     required String token,
//     required String orderId,
//     required String amount,
//   }) async {
//     try {
//       Response response = await dio.post(
//         'https://accept.paymob.com/api/acceptance/payment_keys',
//         data: {
//           "auth_token": token,
//           "amount_cents": amount,
//           "expiration": 3600,
//           "order_id": orderId,
//           "lock_order_when_paid": "false",
//           "billing_data": {
//             "apartment": "803",
//             "email": "abdowagih38@gmail.com",
//             "floor": "42",
//             "first_name": "Clifford",
//             "street": "Ethan Land",
//             "building": "8028",
//             "phone_number": "+20 01024657305",
//             "shipping_method": "PKG",
//             "postal_code": "01898",
//             "city": "Jaskolskiburgh",
//             "country": "CR",
//             "last_name": "Nicolas",
//             "state": "Utah"
//           },
//           "currency": "EGP",
//           "integration_id": 4553985
//         },
//       );
//       print(
//           '==================================================================================');
//       print('Token =>>>>>>>>>>>>>>${response.data['token']}');
//       print(
//           '==================================================================================');
//       return response.data['token'];
//     } catch (e) {
//       print('Exception $e');
//       rethrow;
//     }
//   }
// }
