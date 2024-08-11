class GaleryItem{
  late int _id;
  late bool _isNull;
  GaleryItem({
    required int id,
    bool? isNull,
  }){
    _id = id;
    _isNull = isNull?? false;
  }
  int get id => _id;
  set id(int value) => _id = value;
  bool get isNull => _isNull;
  bool get isNotNull => !_isNull;
}