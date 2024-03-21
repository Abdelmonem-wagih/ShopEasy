import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int statusCode;
  final String statusMessage;
  final bool success;

  const ErrorMessageModel({
    required this.statusCode,
    
    required this.statusMessage,
    required this.success, required String message,
  });

  factory ErrorMessageModel.fromJason(Map<String, dynamic> json) {
    return ErrorMessageModel(
      statusCode: json["status_code"],
      statusMessage: json["status_message"],
      success: json["success"], message: '',
    );
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, success];
}
