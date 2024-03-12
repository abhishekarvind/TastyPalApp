import "package:firebase_auth/firebase_auth.dart";
import"package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import "package:tastypal/heatlybites/lib/community_page.dart";
import "package:tastypal/homescreen.dart";
import "package:tastypal/profile_page.dart";
import "package:tastypal/scan_page.dart";
import "package:tastypal/utils/colors.dart";

class Mainhome extends StatefulWidget {
  const Mainhome({super.key});

  @override
  State<Mainhome> createState() => _MainhomeState();
}

class _MainhomeState extends State<Mainhome> {
  String?  user;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!.uid;
  }


  List Pages=[
    const HomeScreen(),
    const ScanPage(),
    const CommunityPage(),
    const ProfilePage()
  ];
  late PersistentTabController _controller= PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
        screens: [
          const HomeScreen(),
          const ScanPage(),
          const CommunityPage(),
          const ProfilePage()
        ],
      controller:_controller,
      backgroundColor: CustomColor.lightgreen(),
      items: [
        PersistentBottomNavBarItem(icon: Icon(Icons.home_filled),
          title: ("Home"),
          activeColorPrimary: CustomColor.darkgreen(),
        ),
        PersistentBottomNavBarItem(icon: Icon(Icons.document_scanner),
          title: ("Scan Label"),activeColorPrimary: CustomColor.darkgreen()),
        PersistentBottomNavBarItem(icon: Icon(Icons.people),
          title: ("Feeds"),activeColorPrimary: CustomColor.darkgreen()),
        PersistentBottomNavBarItem(icon: Icon(Icons.account_circle),
          title: ("Profile"),activeColorPrimary: CustomColor.darkgreen()),
      ],
    );

  }
}
