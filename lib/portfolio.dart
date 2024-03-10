import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/database/userService.dart';
import 'package:portfolio/model/user.dart';

import 'package:velocity_x/velocity_x.dart';

import 'components/about.dart';
import 'components/education.dart';
import 'components/footer.dart';
import 'components/projects.dart';
import 'components/skills.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final skillsKey = GlobalKey();
  final educationKey = GlobalKey();
  List<Widget> items = [];
  bool isMobile = false;
  double value = 0;
  UserModel? user;

  fetchDetails() async {
    print("heeee");
    user = await DatabaseService.getUserById();
    print("thuueir");
    setState(() {});
  }

  @override
  void initState() {
    items = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 45)),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const Portfolio()));
            },
            child: const Text("Home")),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 45)),
            onPressed: () {
              Scrollable.ensureVisible(educationKey.currentContext!);
            },
            child: const Text("Education")),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 45)),
            onPressed: () {
              Scrollable.ensureVisible(skillsKey.currentContext!);
            },
            child: const Text("Skills")),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 45)),
            onPressed: () {},
            child: const Text("Settings")),
      ),
    ];
    fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Scaffold(
        backgroundColor: Vx.purple300,
        body: Stack(children: [
          //drawer
          DrawerContent(user: user!, items: items),
          //main body
          TweenAnimationBuilder(
            curve: Curves.easeInExpo,
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setEntry(0, 3, 200 * value)
                ..rotateY((pi / 6) * value),
              child: Scaffold(
                appBar: AppBar(
                    // leading: IconButton(
                    //   icon: const Icon(FontAwesomeIcons.barsStaggered),
                    //   onPressed: () => setState(() {
                    //     value > 0 ? value = 1 : value = 0;
                    //     print(value);
                    //   }),
                    // ),
                    title: const Text("Portfolio",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w400)),
                    actions: !isMobile ? items : null),
                body: SingleChildScrollView(
                  child: Container(
                    color: Vx.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              About(user: user!),
                              Education(key: educationKey)
                            ],
                          ),
                          const Projects(),
                          Skill(key: skillsKey),
                          Footer(
                            facebook: user!.facebook.isEmpty
                                ? 'https://www.facebook.com/'
                                : user!.facebook,
                            instagram: user!.instagram.isEmpty
                                ? 'https://www.instagram.com/'
                                : user!.instagram,
                            github: user!.githubId.isEmpty
                                ? 'https://github.com/'
                                : user!.githubId,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              setState(() {
                e.delta.dx > 0 ? value = 1 : value = 0;
              });
            },
          )
        ]));
  }
}

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key, required this.user, required this.items});
  UserModel user;
  List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Vx.purple300,
      width: 200,
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        DrawerHeader(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Image.asset(
                  "assets/user.png",
                  errorBuilder: (context, error, stackTrace) {
                    return const Center();
                  },
                ),
              ),
              Text(
                user.name.isEmpty ? 'New User' : user.name,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => items[index],
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: items.length))
      ]),
    ));
  }
}
