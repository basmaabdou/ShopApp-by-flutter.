import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/componant/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../login&register/Login&register_cubit/cubit.dart';
import '../login&register/shop_login_screen.dart';



class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/onBoarding1.jpg',
        title: 'Screen Title one',
        body: 'Screen Body 1'
    ),
    BoardingModel(
        image: 'assets/images/onBoarding4.jpg',
        title: 'Screen Title two',
        body: 'Screen Body 2'
    ),
    BoardingModel(
        image: 'assets/images/onBoarding3.jpg',
        title: 'Screen Title three',
        body: 'Screen Body 3'
    ),
  ];


  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateFinish(context, ShopLoginScreen());
    });
  }

  var boardController=PageController();
  bool isLast=false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                submit();
              },
              text: 'SKIP',
         ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index==boarding.length-1) {
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastEaseInToSlowEaseOut
                    );
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),
      SizedBox(
        height:30,
      ),
      Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 26,
          )
      ),
      SizedBox(
        height:15,
      ),
      Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 16,
          )
      ),
      SizedBox(
        height:30,
      ),
    ],
  );
}
