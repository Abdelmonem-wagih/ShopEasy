import 'package:bloc/bloc.dart';


class ExpendCubit extends Cubit<bool> {
  ExpendCubit() : super(false);

  void toggleFavorite() {
    emit(!state);
  }
}
