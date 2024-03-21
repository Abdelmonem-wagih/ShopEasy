import 'package:bloc/bloc.dart';

class IncreaseBadgeCubit extends Cubit<int> {
  IncreaseBadgeCubit() : super(0);

  void incrementBadge() {
    emit(state + 1);
  }
}
