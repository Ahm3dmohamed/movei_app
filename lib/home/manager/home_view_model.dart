import 'package:flutter/material.dart';
import 'package:movie_app/service/models/search_model.dart';
import 'package:movie_app/modules/layouts/pages/bookmark_tab.dart';
import 'package:movie_app/modules/layouts/pages/home_tab.dart';
import 'package:movie_app/modules/layouts/pages/movei_tab.dart';
import 'package:movie_app/modules/manager/api_manager.dart';
import 'package:movie_app/modules/layouts/widgets/search/search_tab.dart';

class HomeViewModel extends ChangeNotifier {
  int currentIndex = 0;
  bool onClick = true;
  bool isLoading = false;
  SearchModel? searchResult;
  TextEditingController controller = TextEditingController();
  PageController pageController = PageController();
  final ApiManager apiManager = ApiManager();
  bool isBookmarked = false;

  void bookMarkCheck() {
    isBookmarked = !isBookmarked;
    notifyListeners();
  }

  // Perform search based on query
  Future<void> performSearch(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      searchResult = await apiManager.getSearchData(query);
    } catch (e) {
      searchResult = null;
      print("Error occurred during search: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    const MoveiTab(),
    const BookmarkTab(),
  ];
  void setIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  // void onBookmarkClick() {
  //   onClick == true
  //  ? IconButton(
  //           iconSize: 55,
  //           icon: Icon(
  //             Icons.bookmark_add_outlined,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //           onPressed: () {},
  //         )
  //       : IconButton(
  //           iconSize: 55,
  //           icon: Icon(
  //             Icons.bookmark_added_outlined,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //           onPressed: () {},
  //         );
  //   notifyListeners();
  // }
}
