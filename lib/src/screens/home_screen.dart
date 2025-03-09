import 'package:flutter/material.dart';
import 'package:match_your_kitty/src/models/cat.dart';
import 'package:match_your_kitty/src/screens/cat_details_screen.dart';
import 'package:match_your_kitty/src/services/api_service.dart';
import 'package:match_your_kitty/src/widgets/cat_card_list.dart';
import 'package:match_your_kitty/src/widgets/react_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Cat> catList = [];
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      fetchRandomCat();
    }
  }

  void onLike() {
    setState(() {
      likeCount++;
      if (catList.isNotEmpty) {
        catList = List.of(catList)..removeLast();
      }
    });
    fetchRandomCat();
  }

  void onNext() {
    setState(() {
      if (catList.isNotEmpty) {
        catList = List.of(catList)..removeLast();
      }
    });
    fetchRandomCat();
  }

  Future<void> fetchRandomCat() async {
    final catData = await apiService.getRandomCat();
    if (catData == null || catData.isEmpty) {
      return;
    }

    final cat = Cat.fromJson(catData);

    setState(() {
      catList.insert(0, cat);
    });
  }

  void onCardTapped(Cat cat) {
    Navigator.pushNamed(context, CatDetailPage.routeName, arguments: cat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Cat ($likeCount ❤️)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CatCardList(
              catList: catList,
              onNext: onNext,
              onLike: onLike,
              onCardTapped: onCardTapped,
            ),
            SizedBox(height: 20),
            ReactButtons(onNext: onNext, onLike: onLike),
          ],
        ),
      ),
    );
  }
}
