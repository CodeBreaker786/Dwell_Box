
class CategoryItem {
  final String title;
  const CategoryItem({this.title});
}

class CategoryItems {
  static List<CategoryItem> loadCategoryItem() {
    const fi = <CategoryItem>[
      CategoryItem(
          title: "1st"),
      CategoryItem(
          title: "2nd"),
          CategoryItem(
          title: "3rd"),
    ];
    return fi;
  }
}
