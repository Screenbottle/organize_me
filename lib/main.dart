import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/features/todo/presentation/bloc/local_todo_bloc.dart';
import 'package:organize_me/features/todo/presentation/bloc/local_todo_event.dart';
import 'package:organize_me/features/todo/presentation/injection.dart';
import 'package:organize_me/features/todo/presentation/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalTodoBloc>(
      create: (context) => sl()..add(GetTodo()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen()),
    );
  }
}
