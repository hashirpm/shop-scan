abstract class FilterData {
  static List latest(List data) {
    data.sort((a, b) => (b['time']).compareTo(a['time']));
    return data;
  }

  static List popular(List data) {
    data.sort((a, b) => (b['popularity']).compareTo(a['popularity']));
    return data;
  }

  static List sale(List data) {
    data.removeWhere((element) => !element['onSale']);
    return data;
  }
}
