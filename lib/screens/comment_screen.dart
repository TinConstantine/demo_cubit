import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_list_cubit/cubits/comment_cubit.dart';
import 'package:infinity_list_cubit/states/comments_state.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _scrollController = ScrollController();
  final _scrollThreadHold = 250.0;
  @override
  void initState() {
    context.read<CommentCubit>().loadComment();
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadHold) {
        context.read<CommentCubit>().loadComment();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Infinity List'),
      ),
      body: SafeArea(child: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, commentState) {
          print('comment State: $commentState');
          if (commentState is CommentStateInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (commentState is CommentStateFailure) {
            return const Center(
              child: Text(
                'Cannot load comments from Server',
                style: TextStyle(fontSize: 22, color: Colors.red),
              ),
            );
          }
          if (commentState is CommentStateSuccess) {
            if (commentState.comments.isEmpty) {
              return const Center(child: Text('Empty comments !'));
            }
            return ListView.builder(
              itemCount: commentState.hasReachedEnd
                  ? commentState.comments.length
                  : commentState.comments.length + 1,
              itemBuilder: (context, index) {
                if (index >= commentState.comments.length) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    child: const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    leading: Text('${commentState.comments[index].id}'),
                    title: Text(commentState.comments[index].email,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(commentState.comments[index].body),
                    isThreeLine: true,
                  );
                }
              },
              controller: _scrollController,
            );
          }
          return const Center(
            child: Text('Error'),
          );
        },
      )),
    );
  }
}
