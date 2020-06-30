class ProductModel {
  String productId;
  String productName;
  String productPrice;
  String productCatId;
  String productCatSub;
  String productCatBrand;
  String productDetails;
  String productImage;
  String productQun;
  String discount;
  String entryby;

  ProductModel(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productCatId,
      this.productCatSub,
      this.productCatBrand,
      this.productDetails,
      this.productImage,
      this.productQun,
      this.discount,
      this.entryby});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productCatId = json['product_cat_id'];
    productCatSub = json['product_cat_sub'];
    productCatBrand = json['product_cat_brand'];
    productDetails = json['product_details'];
    productImage = json['product_image'];
    productQun = json['product_qun'];
    discount = json['discount'];
    entryby = json['entryby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_cat_id'] = this.productCatId;
    data['product_cat_sub'] = this.productCatSub;
    data['product_cat_brand'] = this.productCatBrand;
    data['product_details'] = this.productDetails;
    data['product_image'] = this.productImage;
    data['product_qun'] = this.productQun;
    data['discount'] = this.discount;
    data['entryby'] = this.entryby;
    return data;
  }
}
