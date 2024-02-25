class Singleton {
  static final Singleton instance = Singleton._internal();

  List<String> listColor = [];

  factory Singleton() {
    return instance;
  }

  Singleton._internal();
}
