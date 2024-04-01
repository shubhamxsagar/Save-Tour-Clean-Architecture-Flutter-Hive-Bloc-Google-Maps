import 'package:arpan/core/repository/geolocation/bloc/geolocation_bloc.dart';
import 'package:arpan/core/repository/geolocation/geolocation_repository.dart';
import 'package:arpan/core/router/MyAppRouter.dart';
import 'package:arpan/core/themes/theme.dart';
import 'package:arpan/features/domain/repository/auth_repository.dart';
import 'package:arpan/features/domain/repository/todo_repository.dart';
import 'package:arpan/features/home/bloc/current_location_bloc.dart';
import 'package:arpan/features/login/presentation/bloc/login_bloc.dart';
import 'package:arpan/features/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

final myAppRouter = MyAppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
            create: (_) => GeolocationRepository()),
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LoginBloc(
                context.read<AuthRepository>(), context.read<TodoRepository>()
            )
          ),
          BlocProvider(
            create: (context) => GeolocationBloc(
                geolocationRepository: context.read<GeolocationRepository>())
              ..add(
                LoadGeolocation(),
              ),
          ),
          BlocProvider(
            create: (context) => CurrentLocationBloc(),
          )
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightThemeMode,
          themeMode: ThemeMode.light,
          routerConfig: myAppRouter.router,
        ),
      ),
    );
  }
}
