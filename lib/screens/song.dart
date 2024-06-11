class Song {
  final String name;
  final String path;

  Song({required this.name, required this.path});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Song) {
      return name == other.name && path == other.path;
    }
    return false;
  }

  @override
  int get hashCode {
    // Combine the hashCodes of name and path
    return name.hashCode ^ path.hashCode;
  }
}
