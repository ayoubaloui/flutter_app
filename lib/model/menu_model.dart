class MenuModel {
  const MenuModel(
      {this.id,
      required this.menuImage,
      required this.menuTitle,
      required this.menuPrice});
  final String? id;
  final String menuImage;
  final String menuTitle;
  final String menuPrice;

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id'] ?? '',
      menuImage: map['menuImage'] ?? '',
      menuTitle: map['menuTitle'] ?? '',
      menuPrice: map['menuPrice'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuImage': menuImage,
      'menuTitle': menuTitle,
      'menuPrice': menuPrice,
    };
  }
}
