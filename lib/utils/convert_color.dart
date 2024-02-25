class ConvertColor {
  static String convert(int colorId) {
    String convert = '';
    switch (colorId) {
      case 1:
        convert = 'White';
        break;
      case 2:
        convert = 'Black';
        break;
      case 3:
        convert = 'Red';
        break;
      case 4:
        convert = 'Green';
        break;
      case 5:
        convert = 'Blue';
        break;
      case 6:
        convert = 'Yellow';
        break;
    }
    return convert;
  }

  static int parseColor(String color) {
    int id = 0;
    switch (color) {
      case 'White':
        id = 1;
        break;
      case 'Black':
        id = 2;
        break;
      case 'Red':
        id = 3;
        break;
      case 'Green':
        id = 4;
        break;
      case 'Blue':
        id = 5;
        break;
      case 'Yellow':
        id = 6;
        break;
    }
    return id;
  }
}
