import 'package:go_router/go_router.dart';
import 'package:imgur/core/config/routes.dart';
import 'package:imgur/presentation/screens/details_screen.dart';
import 'package:imgur/presentation/screens/home_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.details,
      builder: (_, state) => DetailsScreen(
        extraData: state.extra as Map<String, dynamic>?,
      ),
    ),
  ],
);
