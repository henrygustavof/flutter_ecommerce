import 'package:meta/meta.dart';

class Product {
  String id;
  String name;
  String description;
  num price;
  String url;

  Product(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.url});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "url": url
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        url: json['url']);
  }
}
