import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String massage;

  const Failure(this.massage);

  @override
  List<Object> get props => [massage];

}

class ServerFailure extends Failure{
  const ServerFailure(super.massage);
}

class DataBaseFailure extends Failure{
  const DataBaseFailure(super.massage);
}
