import 'package:flutter/material.dart';

class PIMainFeed{
  static Widget run() {
    return PIMainFeedApp();
  }
}

class PIMainFeedApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIMainFeed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PIMainFeedPage(title: 'Pikicast'),
    );
  }
}

class PIMainFeedPage extends StatelessWidget {
  PIMainFeedPage({this.title});
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:Container(
        color: Colors.white,
        child:SizedBox.expand(
          child: Column(
            children: [
              PIMainFeedLiveEditorWrapper(),
              Expanded(
                  child:SizedBox.expand(
                    child:
                    Padding(
                        padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 30),
                        child: ListView(
                            children:[
                              PIMainFeedTopFeaturedBanner(),
                              PIMainFeedRecommended(),
                              PIMainFeedJustUpdated(),
                              PIMainFeedRecommendedEditors(),
                              PIMainFeedFeaturedLive(),
                              PIMainFeedCategory(),
                            ]
                        )
                    ),
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}

class PIMainFeedLiveEditorWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20) ,
        child: SizedBox(
            height:100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:EdgeInsets.only(left: 15, right: 15),
              itemBuilder:(context, index) {
                return PIMainFeedShortcutEditor();
              },
              separatorBuilder: (BuildContext context, int index){
                return SizedBox(width: 15);
              },
              itemCount:20,
            )
        )
    );
  }
}

class PIMainFeedTopFeaturedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 10),
      child:Container(
          height: 120,
          decoration: BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
//            border:Border.all(width: 0, color: Colors.red),
          ),
          child: ListView(
              scrollDirection:Axis.horizontal,
              children:[]
          )
      ),
    );
  }
}

class PIMainFeedReadMore extends StatelessWidget {
  final VoidCallback onPressed;
  PIMainFeedReadMore(this.onPressed);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width - 90,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border:Border.all(width: 1, color: Colors.blue),
      ),
      child:RaisedButton(
        color: Colors.white,
        highlightColor: Colors.white,
        onPressed: onPressed,
        child: Text('더보기', style: TextStyle(color: Colors.blue ,fontSize:20, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class PIMainFeedSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      Container(height: 1, decoration: BoxDecoration(color: Color(0xffeaeaea))),
      Container(height: 10, decoration: BoxDecoration(color: Color(0xfffafafa))),
    ],),);
  }
}

class PIMainFeedRecommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemW = (screenSize.width - 15 - 15 - 15)/2;
    final itemSize = Size(itemW, itemW*1.2);
    final contents = [1,2,3,4].map((e) => PIMainFeedContent(itemSize)).toList();

    return Padding(padding: EdgeInsets.only(left: 15, top: 20, right: 15) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('추천 콘텐츠', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            SizedBox(height: 15),
            Column(
                children: [
                  Container(
                    child:Wrap(
                        spacing: 15.0, // 主轴(水平)方向间距
                        runSpacing: 35.0, // 纵轴（垂直）方向间距
                        alignment: WrapAlignment.center, //沿主轴方向居中
                        children:contents
                    ),
                  ),
                  Container(height: 35),
                  PIMainFeedReadMore((){
                    print('read more');
                  }),
                ]
            ),
          ]
    ),
    );
  }
}

class PIMainFeedShortcutEditor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 90,
      alignment: Alignment.center,
      child:Stack(
        alignment:AlignmentDirectional.center,
        children: [
        Positioned(
        top: 5.0,
        child: Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  border:Border.all(width: 2, color: Colors.red),
                ),
                child:Padding(
                    padding: EdgeInsets.all(5),
                    child: Image(image: AssetImage('lib/PIHome/images/icProfileDefault56Dp.png'))
                ),
              ),
          ),
          Positioned(
            top: 3.0,
            child: Image(image: AssetImage('lib/PIHome/images/badgeOnAir.png')),),
          Positioned(
            bottom: 8.0,
            child:Text('zhouJing'),
          )
        ],
      ),
    );
  }
}

class PIMainFeedContent extends StatelessWidget{
  final Size size;
  PIMainFeedContent(this.size);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size.width, height: size.height,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE8E8E8),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            )
            ),
            Container(height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('10,000핔', style: TextStyle(color: Colors.blue ,fontSize:12, fontWeight: FontWeight.w600)),
                  SizedBox(height: 3),
                  Text('Type something here. Can be 2-line.', style: TextStyle(color: Colors.black ,fontSize:14, fontWeight: FontWeight.w600)),
                  SizedBox(height: 3),
                  Text('Nickname', style: TextStyle(color: Color(0xff9a9a9a) ,fontSize:12, fontWeight: FontWeight.w600))
                ],),
            ),
          ],)
    );
  }
}

class PIMainFeedLive extends StatelessWidget{
  final Size size;
  PIMainFeedLive(this.size);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size.width, height: size.height,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE8E8E8),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            )
            ),
            Container(height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text('Something. Can be 2-line.', style: TextStyle(color: Colors.black ,fontSize:14, fontWeight: FontWeight.w600)),
                  SizedBox(height: 3),
                  Text('Nickname', style: TextStyle(color: Color(0xff9a9a9a) ,fontSize:12, fontWeight: FontWeight.w600))
                ],),
            ),
          ],)
    );
  }
}

class PIMainFeedRecommendedEditorItem extends StatelessWidget{
  final Size size;
  PIMainFeedRecommendedEditorItem(this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
          width:size.width ,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [BoxShadow(color: Color(0xffeaeaea), offset: Offset(2.0, 2.0), blurRadius: 8.0, spreadRadius: 2.0)],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20 , bottom: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description for the creators! 🐈', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                  SizedBox(height: 28),
                  Image(width: 48, height: 48, image: AssetImage('lib/PIHome/images/icProfileDefault56Dp.png'))
                ]),
          ),
        );
  }
}

class PIMainFeedJustUpdated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemW = (screenSize.width - 15 - 15 - 30)/2;
    final itemSize = Size(itemW, itemW*1.2);

    return Padding(padding: EdgeInsets.only(left: 0, top: 60, right: 0) ,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(left: 15) ,
                  child:Text('최신 콘텐츠', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)
              ),
              SizedBox(height: 15),
              Container(
                  height: itemSize.height,
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:EdgeInsets.only(left: 15, right: 15),
                    itemBuilder:(context, index) {
                      return PIMainFeedContent(itemSize);
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return SizedBox(width: 15);
                    },
                    itemCount:5,
                  )
              ),
              SizedBox(height: 30),
            ]
        )
    );
  }
}

class PIMainFeedRecommendedEditors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemW = screenSize.width - 15 - 15 - 30;
    final itemSize = Size(itemW, 170);

    return Padding(padding: EdgeInsets.only(left: 0, top: 60, right: 0) ,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(left: 15) ,
                  child:Text('추천 크리에이터', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)
              ),
              Padding(padding: EdgeInsets.only(left: 15) ,
                  child:Text('다양한 피키의 크리에이터를 만나보세요!', style: TextStyle(color: Color(0xFF9a9a9a),fontSize: 14, fontWeight: FontWeight.w400),)
              ),
              SizedBox(height: 20),
              Container(
                  height: itemSize.height + 20,
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    itemBuilder:(context, index) {
                      return PIMainFeedRecommendedEditorItem(itemSize);
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return SizedBox(width: 15);
                    },
                    itemCount:5,
                  )
              ),
              SizedBox(height: 40),
            ]
        )
    );
  }
}

class PIMainFeedFeaturedLive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 0, top: 20, right: 0) ,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PIMainFeedSeparator(),
              SizedBox(height: 40),
              Padding(padding: EdgeInsets.only(left: 15) ,
                  child:Text('피키라이브', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)
              ),
              SizedBox(height: 20),
              Container(
                  height: 270,
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                    itemBuilder:(context, index) {
                      return PIMainFeedLive(Size(140, 270));
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return SizedBox(width: 15);
                    },
                    itemCount:5,
                  )
              ),
              SizedBox(height: 40),
            ]
        )
    );
  }
}

class PIMainFeedCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemW = (screenSize.width - 15 - 15 - 15)/2;
    final itemSize = Size(itemW, itemW*1.2);
    final contents = [1,2,3,4].map((e) => PIMainFeedContent(itemSize)).toList();

    return Padding(padding: EdgeInsets.only(left: 0, top: 20, right: 0) ,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PIMainFeedSeparator(),
            SizedBox(height: 40),
            Padding(padding: EdgeInsets.only(left: 15) ,
                child:Text('카테고리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)
            ),
            SizedBox(height: 15),
            Column(
                children: [
                  Container(
                    child:Wrap(
                        spacing: 15.0, // 主轴(水平)方向间距
                        runSpacing: 35.0, // 纵轴（垂直）方向间距
                        alignment: WrapAlignment.center, //沿主轴方向居中
                        children:contents
                    ),
                  ),
                  Container(height: 35),
                  PIMainFeedReadMore((){
                    print('read more');
                  }),
                ]
            ),
          ]
      ),
    );
  }
}


