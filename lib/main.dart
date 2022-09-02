import 'package:dicoding_submission/ui/home/pages/home_view.dart';
import 'package:dicoding_submission/ui/home/widgets/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final logindata = await SharedPreferences.getInstance();

  runApp(MyApp(
    loginData: logindata,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.loginData}) : super(key: key);
  final SharedPreferences loginData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
          background: Container(color: Colors.white)),
      title: 'Universitas',
      theme: ThemeData(),
      home: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc()..add(InitialData()),
        child: HomePage(
          loginData: loginData,
        ),
      ),
    );
  }
}
