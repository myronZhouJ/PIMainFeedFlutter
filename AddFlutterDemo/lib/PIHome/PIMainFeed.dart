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
      body:SizedBox.expand(
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
                            PIMainFeedTopBanner(),
                            PIMainFeedRecommended(),
                            PIMainFeedRecommended2(),
                          ]
                      )
                  ),
                )
            )
          ],
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
          child: ListView(
              scrollDirection:Axis.horizontal,
              padding:EdgeInsets.only(left: 10, right: 10),
              children:[
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
                PIEditor(),
              ]
          ),
        )
    );
  }
}

class PIMainFeedTopBanner extends StatelessWidget {
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

class PIMainFeedRecommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    final itemW = (ScreenSize.width - 15 - 15 - 15)/2;
    final itemSize = Size(itemW, itemW*1.2);
    return Padding(padding: EdgeInsets.only(left: 15, top: 20, right: 15) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('추천 콘텐츠', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                color: Colors.white),
            child:Wrap(
                spacing: 15.0, // 主轴(水平)方向间距
                runSpacing: 35.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.center, //沿主轴方向居中
                children:[
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),
                  PIMainFeedContent(itemSize),

                  Container(
                    width: ScreenSize.width - 90,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border:Border.all(width: 1, color: Colors.blue),
                    ),
                    child:RaisedButton(
                      color: Colors.white,
                      highlightColor: Colors.white,
                      onPressed: (){},
                      child: Text('더보기', style: TextStyle(color: Colors.blue ,fontSize:20, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ]
            ),
          )]
    ),
    );
  }
}

class PIEditor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 90,
      margin: EdgeInsets.only(left: 6, right: 6), //容器外填充
      alignment: Alignment.center,
      child:Stack(
        alignment:AlignmentDirectional.center,
        children: [
        Positioned(
        top: 5.0,
        child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
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

class PIMainFeedRecommended2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    final itemW = (ScreenSize.width - 15 - 15 - 30)/2;
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
                  decoration: BoxDecoration(
                      color: Colors.white),
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
              )
            ]
        )
    );
  }
}


