class Product {
  String id;
  String name;
  String description;
  String? imageUrl;
  String price;


  Product({
    required this.id,
    required this.name,
    required this.description,

    required this.price,
    this.imageUrl,
  });


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
  };


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}