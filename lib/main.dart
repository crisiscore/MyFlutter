import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/core/constants.dart';
import 'package:my_flutter/src/core/routes/app_routes.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/blocs/add_expense/add_expense_bloc.dart';
import 'package:my_flutter/src/presentation/blocs/delete_expense/delete_expense_bloc.dart';
import 'package:my_flutter/src/presentation/blocs/remote_expenses/remote_expenses_bloc.dart';
import 'package:my_flutter/src/presentation/screens/bottom_navigation.dart';

Future<void> main() async {
  await initializeDependencies();

  runApp( const MyApp()
      );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteExpensesBloc>(
          create: (context) => injector(),
        ),
        BlocProvider<AddExpenseBloc>(
          create: (context) => injector(),
        ),
        BlocProvider<DeleteExpenseBloc>(
          create: (context) => injector(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        title: kAppTitle,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0)),
        home: const BottomNavigation(),
      ),
    );
  }

} // MyApp
