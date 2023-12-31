class LoginModel {
  LoginModel({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  final bool? success;
  final String? message;
  final User? user;
  final String? token;

  LoginModel copyWith({
    bool? success,
    String? message,
    User? user,
    String? token,
  }) {
    return LoginModel(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      success: json["success"],
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user": user?.toJson(),
    "token": token,
  };

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.lastName,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? location;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? lastName;

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? lastName,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      lastName: lastName ?? this.lastName,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      location: json["location"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      lastName: json["lastName"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "location": location,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "lastName": lastName,
  };

}
