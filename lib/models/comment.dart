class Comment {
  /* "postId": 1,
    "id": 1,
    "name": "id labore ex et quam laborum",
    "email": "Eliseo@gardner.biz",
    "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
    */
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
  Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});
  factory Comment.fromJson(Map<dynamic, dynamic> json) {
    return Comment(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}
