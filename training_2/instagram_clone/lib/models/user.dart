class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List following;
  final List followers;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

//This will convert arguments to an object file
//So this will not be written every time it will be used
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
