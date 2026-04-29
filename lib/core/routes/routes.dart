import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:money_converter/core/di/dp_injection.dart';
import 'package:money_converter/core/routes/route_paths.dart';
import 'package:money_converter/features/main/presentation/cubit/currency_cubit.dart';
import 'package:money_converter/features/main/presentation/screens/main_screen.dart';

class Routes {
  const Routes._();

  static GoRouter routes = GoRouter(
    initialLocation: RoutePaths.main,
    routes: [
      GoRoute(
        path: RoutePaths.main,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<CurrencyCubit>(),
          child: MainScreen(),
        ),
      ),
    ],
  );
}
