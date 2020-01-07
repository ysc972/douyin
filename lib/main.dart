import 'package:douyin_demo/Pages/BottomSheet.dart';
import 'package:douyin_demo/Widget/FavAnination.dart';
import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '抖课',
        home: Scaffold(
          body: Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Recommendpage()),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.black),
              child: BtmBar(),
            ),
          ),
        ));
  }
}

class Recommendpage extends StatelessWidget {
  const Recommendpage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    double rpx = screen_width / 750;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => RecommendProvider(),
        )
      ],
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: 1300 * rpx,
            width: screen_width,
            child: Container(
              color: Colors.orange,
            ),
          ),
          Positioned(
            top: 0,
            height: screen_height * 0.1,
            width: screen_width,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: TopTab(),
            ),
          ),
          Positioned(
            bottom: 0,
            height: 280 * rpx,
            width: 0.7 * screen_width,
            child: Container(
              // decoration: BoxDecoration(color: Colors.redAccent),
              child: BtnContent(),
            ),
          ),
          Positioned(
            right: 0,
            top: 0.3 * screen_height,
            height: 0.4 * screen_height,
            width: 0.2 * screen_width,
            child: Container(
              // decoration: BoxDecoration(color: Colors.orange),
              child: BtnList(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            width: 0.25 * screen_width,
            height: 0.25 * screen_width,
            child: Container(
              // decoration: BoxDecoration(color: Colors.purple),
              child: RotateAlbum(
                rpx: rpx,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopTab extends StatefulWidget {
  @override
  _TopTabState createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(bottom: 20 * rpx, left: 20 * rpx),
              child: Icon(Icons.search)),
        ),
        Expanded(
          flex: 8,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 150 * rpx, vertical: 20 * rpx),
            child: TabBar(
              tabs: <Widget>[Text('关注'), Text('推荐')],
              controller: controller,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white, fontSize: 20),
              unselectedLabelStyle:
                  TextStyle(color: Colors.grey[700], fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(right: 20 * rpx, bottom: 20 * rpx),
              child: Icon(Icons.live_tv)),
        )
      ],
    );
  }
}

class BtmBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getBottomTextWidget('首页', true),
          getBottomTextWidget('同城', false),
          AddIcon(),
          getBottomTextWidget('消息', false),
          getBottomTextWidget('我', false),
        ],
      ),
    );
  }
}

getBottomTextWidget(String content, bool ifSelected) {
  return Text('$content',
      style: ifSelected
          ? TextStyle(fontSize: 18, color: Colors.white)
          : TextStyle(fontSize: 18, color: Colors.grey[600]));
}

class AddIcon extends StatelessWidget {
  const AddIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 70 * rpx,
      width: 120 * rpx,
      child: Stack(
        children: <Widget>[
          Positioned(
            height: 130 * rpx,
            width: 100 * rpx,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: 70 * rpx,
            width: 100 * rpx,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: 70 * rpx,
            width: 100 * rpx,
            right: 10 * rpx,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class BtnContent extends StatelessWidget {
  const BtnContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double rpx = MediaQuery.of(context).size.width / 750;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ListTile(
            title: Text(
              '@${provider.mainInfo.userName}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '${provider.mainInfo.content}',
              maxLines: 2,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 0.7 * screen_width,
            height: 80 * rpx,
            // margin: EdgeInsets.only(top: 10 * rpx, bottom: 10 * rpx),
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                width: 20 * rpx,
              ),
              Icon(Icons.music_note),
              // Expanded(
              //   child: Text('${provider.mainInfo.desc}',
              //       style: TextStyle(color: Colors.white),
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis),
              // )
              Expanded(
                // padding: const EdgeInsets.all(8.0),
                child: Marquee(
                  blankSpace: 100,
                  text: 'testsssss',
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class RotateAlbum extends StatefulWidget {
  RotateAlbum({Key key, this.rpx}) : super(key: key);
  final double rpx;
  @override
  _RotateAlbumState createState() => _RotateAlbumState(rpx);
}

class _RotateAlbumState extends State<RotateAlbum>
    with SingleTickerProviderStateMixin {
  _RotateAlbumState(this.rpx);
  final double rpx;
  AnimationController _controller;
  var animation;
  @override
  void initState() {
    super.initState();
    // double rpx=MediaQuery.of(context).size.width/750;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.forward(from: 0.0);
          }
        }),
      child: Container(
        width: 120 * rpx,
        height: 120 * rpx,
        padding: EdgeInsets.all(30 * rpx),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=4374cf7b04fa513d45a7648c5c043e9e/8644ebf81a4c510f0b02b8bd6c59252dd52aa557.jpg'),
        ),
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: animation,
    );
  }
}

class BtnList extends StatelessWidget {
  BtnList({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    double rpx = MediaQuery.of(context).size.width / 750;
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 160 * rpx,
            height: 130 * rpx,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                      width: 90 * rpx,
                      height: 90 * rpx,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage('${provider.mainInfo.avataurl}'),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 30 * rpx,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                        width: 50 * rpx,
                        height: 59 * rpx,
                        child: Icon(
                          Icons.add,
                          size: 40 * rpx,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          ),
          // IconText(
          //     text: '${provider.mainInfo.favCount}',
          //     iconButton: IconButton(
          //       onPressed: () {
          //         provider.tapFav();
          //       },
          //       icon: provider.mainInfo.ifFaved
          //           ? AnimatePositiveIcon(
          //               size: 80 * rpx,
          //             )
          //           : AnimateNegtiveIcon(
          //               size: 80 * rpx,
          //               icon: Icons.favorite,
          //               startColor: Colors.redAccent,
          //               endColor: Colors.white,
          //               callback: () {}),
          //     )),
          IconText(
            iconButton: AnimateNegtiveIcon(
              size: 80*rpx,
              icon: Icons.chat,
              startColor: Colors.white,
              endColor: Colors.white,
              callback: (){showBottom(context, screen_width, screen_height);},
              
            ),
            text: '${provider.mainInfo.replyCount}',
          ),
          // IconText(
          //   iconButton: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.reply,
          //       size: 80 * rpx,
          //     ),
          //   ),
          //   text: '${provider.mainInfo.sharedCount}',
          // )
        ],
      ),
    );
  }
}
// getBtnList(double rpx, BuildContext context) {
//   RecommendProvider provider = Provider.of<RecommendProvider>(context);
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: <Widget>[
//       Container(
//         width: 160 * rpx,
//         height: 130 * rpx,
//         child: Stack(
//           children: <Widget>[
//             Center(
//               child: Container(
//                   width: 90 * rpx,
//                   height: 90 * rpx,
//                   child: CircleAvatar(
//                     backgroundImage:
//                         NetworkImage('${provider.mainInfo.avataurl}'),
//                   )),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 30 * rpx,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.redAccent,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Container(
//                     width: 50 * rpx,
//                     height: 59 * rpx,
//                     child: Icon(
//                       Icons.add,
//                       size: 40 * rpx,
//                       color: Colors.white,
//                     )),
//               ),
//             )
//           ],
//         ),
//       ),
//       IconText(
//           text: '${provider.mainInfo.favCount}',
//           iconButton: IconButton(
//             onPressed: provider.tapFav(),
//             icon: Icon(
//               Icons.favorite,
//               size: 80 * rpx,
//               color: Colors.redAccent,
//             ),
//           )),
//       IconText(
//         iconButton: IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.feedback,
//             size: 80 * rpx,
//           ),
//         ),
//         text: '${provider.mainInfo.replyCount}',
//       ),
//       IconText(
//         iconButton: IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.reply,
//             size: 80 * rpx,
//           ),
//         ),
//         text: '${provider.mainInfo.sharedCount}',
//       )
//     ],
//   );
// }

class IconText extends StatelessWidget {
  const IconText({Key key, this.iconButton, this.text}) : super(key: key);
  final AnimateNegtiveIcon  iconButton;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        iconButton,
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

showBottom(context, screen_width, screen_height) {
  RecommendProvider provider = Provider.of<RecommendProvider>(context);
  provider.hideBottomBar();
  showModalBottomSheet(
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              builder: (context) => RecommendProvider(),
            )
          ],
          child: Container(
            height: 0.7 * screen_height,
            child: ReplyFullList(),
          ),
        );
      });
}
