class HomePageModel {
  HomePageModel({
    required this.status,
    this.message,
    required this.data,
  });
  late bool? status;
  late Null message;
  late Data? data;

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.banners,
    this.products,
    this.ad,
  });
  late List<Banners>? banners;
  late List<Products>? products;
  late String? ad;

  Data.fromJson(Map<String, dynamic> json) {
    banners =
        List.from(json['banners']).map((e) => Banners.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banners'] = banners!.map((e) => e.toJson()).toList();
    _data['products'] = products!.map((e) => e.toJson()).toList();
    _data['ad'] = ad;
    return _data;
  }
}

class Banners {
  Banners({
    this.id,
    this.image,
    this.category,
    this.product,
  });
  late int? id;
  late String? image;
  late Null category;
  late Null product;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['category'] = category;
    _data['product'] = product;
    return _data;
  }
}

class Products {
  Products({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });
  late int? id;
  late int? price;
  late int? oldPrice;
  late int? discount;
  late String? image;
  late String? name;
  late String? description;
  late List<String>? images;
  late bool? inFavorites;
  late bool? inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['discount'] = discount;
    _data['image'] = image;
    _data['name'] = name;
    _data['description'] = description;
    _data['images'] = images;
    _data['in_favorites'] = inFavorites;
    _data['in_cart'] = inCart;
    return _data;
  }
}
