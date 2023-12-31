import 'package:get_it/get_it.dart';

import '../bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(() => AuthBloc());
}
