class ApiToken {
  String token;

  ApiToken({required this.token});

  factory ApiToken.fromJson(Map<String, dynamic> json) {
    return ApiToken(token: json['token']);
  }
}

