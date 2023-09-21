import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_list_cubit/cubits/comment_cubit.dart';
import 'package:infinity_list_cubit/screens/comment_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CommentCubit(),
        child: const CommentScreen(),
      ),
    );
  }
}
