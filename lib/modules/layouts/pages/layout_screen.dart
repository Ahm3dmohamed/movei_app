import 'package:flutter/material.dart';
import 'package:movie_app/home/manager/home_view_model.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            body: PageView(
              controller: provider.pageController,
              onPageChanged: (value) {
                provider.setIndex(value);
              },
              children: provider.tabs,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (value) {
                provider.setIndex(value);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: "Browse",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: "BookMark",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
