import 'dart:convert';
import '../models/comment.dart';
import 'package:http/http.dart' as http;

final http.Client client = http.Client();

Future<List<Comment>> getCommentFromApi(int start, int limit) async {
  final String uri =
      "https://jsonplaceholder.typicode.com/comments?_start=$start&_limit=$limit";
  final response = await client.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    List<dynamic> resposeBody = jsonDecode(response.body);

    return resposeBody.map((e) => Comment.fromJson(e)).toList();
  }
  return [];
}
