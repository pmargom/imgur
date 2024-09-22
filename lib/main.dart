import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgur/core/config/app_router.dart';
import 'package:imgur/core/setup_logger.dart';
import 'package:imgur/di/injection_container.dart';
import 'package:imgur/presentation/cubits/home/galleries_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  setupLogger();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => GalleriesCubit(getIt()))],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Imgur',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
