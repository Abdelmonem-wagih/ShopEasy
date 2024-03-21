import 'package:get_it/get_it.dart';
import 'package:shopease/feature/data/data_source/remote_data_source.dart';
import 'package:shopease/feature/data/repository/product_repository.dart';
import 'package:shopease/feature/domain/repository/base_product_repository.dart';
import 'package:shopease/feature/domain/usecase/get_product_usecase.dart';
import 'package:shopease/feature/presntaion/commponent/cart.dart';
import 'package:shopease/feature/presntaion/cubit/favorite/favorite_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/increase_badge/increase_badge_cubit.dart';
import 'package:shopease/feature/presntaion/cubit/product/product_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => ProductCubit(sl()));
  sl.registerLazySingleton(() => IncreaseBadgeCubit());
  sl.registerLazySingleton(() => FavoriteCubit());
  sl.registerLazySingleton(() => CartCubit());

//
  sl.registerLazySingleton(
    () => GetProductUseCase(
      baseProductRepository: sl(),
    ),
  );

  sl.registerLazySingleton<BaseProductRepository>(
    () => ProductRepository(
      baseRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<BaseRemoteDataSource>(
    () => RemoteDataSource(),
  );
}
