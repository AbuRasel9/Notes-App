enum ApiStatus{loading,initial,success,error}

enum FontOptions {
  montserrat,
  noToSerif;

  String get key => switch (this) {
    FontOptions.montserrat => "Montserrat",
    FontOptions.noToSerif => "NotoSerif",
  };
}
