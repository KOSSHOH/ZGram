import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger/src/app_theme.dart';
import 'package:messenger/src/ui/auth/login_screen.dart';
import 'package:messenger/src/ui/auth/signup_screen.dart';
import 'package:messenger/src/ui/menu/chat/chat_screen.dart';
import 'package:messenger/src/ui/menu/explore/explore_screen.dart';
import 'package:messenger/src/ui/menu/home/home_screen.dart';
import 'package:messenger/src/ui/menu/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectedTab(int index) {
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Theme(
        data: ThemeData(
          platform: TargetPlatform.android,
        ),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          controller: _pageController,
          children: <Widget>[
            HomeScreen(),
            ExploreScreen(),
            ChatScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        notchedShape: CircularNotchedRectangle(),
        height: 72,
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
            selected: "assets/menu/home_selected.svg",
            unselected: "assets/menu/home_unselected.svg",
          ),
          FABBottomAppBarItem(
            selected: "assets/menu/explore_selected.svg",
            unselected: "assets/menu/explore_unselected.svg",
          ),
          FABBottomAppBarItem(
            selected: "assets/menu/chat_selected.svg",
            unselected: "assets/menu/chat_unselected.svg",
          ),
          FABBottomAppBarItem(
            selected: "assets/menu/profile_selected.svg",
            unselected: "assets/menu/profile_unselected.svg",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 28,
          color: AppTheme.white,
        ),
        elevation: 2.0,
      ),
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({
    this.selected,
    this.unselected,
  });

  String selected;
  String unselected;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.height: 60.0,
    this.backgroundColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  final List<FABBottomAppBarItem> items;
  final double height;
  final Color backgroundColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 4,
      height: widget.height,
      margin: EdgeInsets.only(
        right: index == 1 ? 56 : 0.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              index == _selectedIndex
                  ? SvgPicture.asset(item.selected)
                  : SvgPicture.asset(item.unselected),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(
                  top: 8,
                ),
                height: index == _selectedIndex ? 6 : 0,
                width: index == _selectedIndex ? 6 : 0,
                decoration: BoxDecoration(
                  color: index == _selectedIndex
                      ? AppTheme.primary
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
