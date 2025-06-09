class Price {
  int? id;
  late double _kameezShalwaar;
  late double _shirt;

  Price({this.id, required double kameezShalwaar, required double shirt}) {
    this.kameezShalwaar = kameezShalwaar;
    this.shirt = shirt;
  }

  double get kameezShalwaarPrice => _kameezShalwaar;

  double get shirtPrice => _shirt;

  set kameezShalwaar(double value) {
    if (value < 1) {
      throw Exception('Invalid Kameez Shalwaar Price');
    }
    _kameezShalwaar = value;
  }

  @override
  String toString() {
    return 'Price(kameezShalwaar: $_kameezShalwaar, shirt: $_shirt)';
  }

  set shirt(double value) {
    if (value < 1) {
      throw Exception('Invalid Shirt Price');
    }
    _shirt = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kameezShalwaar': _kameezShalwaar,
      'shirt': _shirt,
    };
  }
  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      id: map['id'],
      kameezShalwaar: map['kameezShalwaar'],
      shirt: map['shirt'],
    );
  }
}