abstract class Cache {
  dynamic read(String key) {}
  void write(
    String key,
    dynamic value,
  ) {}

  void save() {}
  Future<void> restore() { return Future<void>.value(null); }
  void reset() {}
}
