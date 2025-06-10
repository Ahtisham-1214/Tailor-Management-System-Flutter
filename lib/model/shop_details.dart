class ShopDetail {
  int? id;
  late String _shopName;
  late String _mail;
  late String _phoneNumber;
  late String _address;

  ShopDetail({
    this.id,
    required String shopName,
    required String mail,
    required String phoneNumber,
    required String address,
  }) {
    this.shopName = shopName;
    this.mail = mail;
    this.phoneNumber = phoneNumber;
    this.address = address;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
  }

  String get shopName => _shopName;

  set shopName(String value) {
    _shopName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopName': _shopName,
      'mail': _mail,
      'phoneNumber': _phoneNumber,
      'address': _address,
    };
  }

  factory ShopDetail.fromMap(Map<String, dynamic> map) {
    return ShopDetail(
      id: map['id'],
      shopName: map['shopName'],
      mail: map['mail'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }
}
