import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organize_me/core/constants/colors.dart';
import 'package:floor/floor.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';
import 'package:organize_me/features/todo/presentation/pages/home.dart';
import 'package:organize_me/features/todo/presentation/pages/splash.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: darkGreen),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
