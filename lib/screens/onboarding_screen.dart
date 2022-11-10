import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class bordingModel {
  String image;
  String title;
  String body;
  bordingModel(
      {required this.image, required this.title, required this.body});
}

class Onboarding_screen extends StatefulWidget {
  @override
  _Onboarding_screenState createState() => _Onboarding_screenState();
}

class _Onboarding_screenState extends State<Onboarding_screen> {
  var boardController = PageController();
  bool isLast = false;
  List<bordingModel> bording = [
    bordingModel(
        image: 'https://storyset.com/illustration/opened/bro#FFC100FF&hide=&hide=complete',
        title: 'title1',
        body: ' body1'),
    bordingModel(
        image: 'https://storyset.com/illustration/catalogue/pana#FFC100FF&hide=&hide=complete',
        title: 'title2',
        body: 'body2'),
    bordingModel(
        image: 'https://storyset.com/illustration/catalogue/cuate#FFC100FF&hide=&hide=complete',
        title: 'title3',
        body: 'body3')
  ];
  Future<void> submitOnBoarding() async {
    await Cache_helper.saveData(key: 'onBoarding', value: true).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login_screen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        actions: [
          textbuttom(
            text: 'Skip',
            function: submitOnBoarding,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == bording.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    bordingBuildingUnit(b: bording[index]),
                itemCount: bording.length,
              ),
            ),
            Row(children: [
              SmoothPageIndicator(
                controller: boardController,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.deepOrange,
                    dotHeight: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                    dotWidth: 10),
                count: bording.length,
              ),
              Spacer(),
              FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (isLast == true) {
                     submitOnBoarding();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  })
            ])
          ],
        ),
      ),
    );
  }

  Widget bordingBuildingUnit({bordingModel ?b}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${b!.image}'),
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 25,
          ),
          Text(
            '${b.title}',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text('${b.body}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15,
          )
        ],
      );
}
