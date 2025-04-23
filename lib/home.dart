import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/cubit/post_cubit.dart';
import 'package:noteapp/cubit/post_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Loadposts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // han having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: Text('Note App')),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  subtitle: Text("${state.posts[index]['id']}"),
                  title: Text("${state.posts[index]['title']}"),
                );
              },
            );
          } else if (state is PostError) {
            return InkWell(
              onTap: () {
                Loadposts();
              },
              child: Center(child: Text('Try again')),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  void Loadposts() {
    context.read<PostCubit>().fetchPosts();
  }
}
