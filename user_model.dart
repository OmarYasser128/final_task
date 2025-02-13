
class UserModel {
  final String? accessToken;
  final String? name;

  UserModel({required this.accessToken, required this.name});

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      accessToken: json["access_token"] ?? "No Token",
      name: json["user"]["identities"][0]["identity_data"]["user_name"] ?? "No Name",
    );
  }
}