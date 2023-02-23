class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  int? idCategory;

  Product({this.id, this.name, this.description, this.price, this.idCategory});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    idCategory = json['idCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['idCategory'] = this.idCategory;
    return data;
  }
}
