import 'package:bloc/bloc.dart';


class FavoriteCubit extends Cubit<bool> {
  FavoriteCubit() : super(false);

  void toggleFavorite() {
    emit(!state);
  }
}
