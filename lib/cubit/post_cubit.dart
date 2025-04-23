import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoading());

  /// Fetch the posts from the api

  Future fetchPosts() async {
    emit(PostLoading());

    try {
      // establish the apo connection.
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      // Check for th status of the response.
      if (response.statusCode == 200) {
        // get the resonse body in a list
        final List posts = json.decode(response.body);

        emit(PostLoaded(posts));
      }
    } catch (e) {
      emit(PostError("ERROR $e"));
    }
  }
}
