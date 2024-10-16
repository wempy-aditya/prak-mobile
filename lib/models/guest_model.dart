import 'dart:convert';

List<Guest> productFromJson(String str) =>
    List<Guest>.from(json.decode(str).map((x) => Guest.fromJson(x)));
String productToJson(List<Guest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guest {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  GuestRating rating;

  Guest({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: GuestRating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}

class GuestRating {
  double rate;
  int count;

  GuestRating({
    required this.rate,
    required this.count,
  });

  factory GuestRating.fromJson(Map<String, dynamic> json) => GuestRating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
