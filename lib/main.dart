import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobs_portal/core/bloc/jobs/jobs_bloc.dart';
import 'package:jobs_portal/core/bloc/splash/splash_bloc.dart';
import 'package:jobs_portal/presentation/splash_screen.dart';

import 'core/bloc/auth/auth_bloc.dart';
import 'core/helper/shared_value.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();

  SharedValue().writeTokenIfNull();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(builder: (context, child) {
      return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => AuthBloc()),BlocProvider(create: (_) => JobsBloc()),BlocProvider(create: (_)=>SplashBloc())],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job Portal',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
