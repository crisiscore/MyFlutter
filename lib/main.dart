import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/core/constants.dart';
import 'package:my_flutter/src/core/routes/app_router.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/blocs/remote_expenses/remote_expenses_bloc.dart';
import 'package:my_flutter/src/presentation/screens/bottom_navigation.dart';

Future<void> main() async {
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppTitle,
        onGenerateRoute: _router.generateRoute,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0)),
        home: BlocProvider<RemoteExpensesBloc>(
          create: (context) => injector(),
          child: const BottomNavigation(),
        ));
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }
} // MyApp
