class AppConstance {
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String paymentApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1Rjd01UVTJMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkucFQwSk1hdjFoQjdQTi1qWGVmVXZJTDBsX2JxNDJoQV9iVFhUSnFOZTU1bE53TUVwY3NWX0p2d2RxQjBZb1Bjdi1VaHA1X0ZPRW1xOWJsdTZPQ1VPUVE=';

  static const String getAuthToken = '/auth/tokens';
  static const getOrderId = '/ecommerce/orders';
  static const getPaymentRequest = '/acceptance/payment_keys';
  static const getRefCode = '/acceptance/payments/pay';
  static String visaUrl =
      '$baseUrl/acceptance/iframes/837361?payment_token=$finalToken';
  static String paymentFirstToken = '';

  static String paymentOrderId = '';

  static String finalToken = '';

  static const String integrationIdCard = '4553985';
  static const String integrationIdKiosk = '4553985';

  static String refCode = '';
//static const String baseUrl = 'https://fakestoreapi.com/products';
}
