class Price{
  double _kameezShalwaar;
  double _shirt;

  Price({required double kameezShalwaar, required double shirt})
  : _kameezShalwaar = kameezShalwaar,
    _shirt = shirt;

  double get kameezShalwaarPrice => _kameezShalwaar;
  double get shirtPrice => _shirt;

  @override
  String toString() {
    return 'Price(kameezShalwaar: $_kameezShalwaar, shirt: $_shirt)';
  }
}