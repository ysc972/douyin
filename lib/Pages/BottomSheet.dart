import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplyFullList extends StatelessWidget {
  const ReplyFullList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double screen_width=MediaQuery.of(context).size.width;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    Reply reply = provider.reply;
    List<Reply> replies = List<Reply>();
    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    ScrollController controller = ScrollController();
    return Stack(children: <Widget>[
      Positioned(
        top: 0,
        height: 30,
        width: screen_width,
        child: Container(
          height: 30,
          child: BottomSheetTop()
        ),
      ),
      Positioned(
        top:35,
        height: 530 ,
        width: screen_width,
        child: SingleChildScrollView(
          controller: controller,
          child:genReplyList(replies, controller) ,
        ),
      ),
      Positioned(
        bottom: 0,
        height: 50,
        width: screen_width,
        child: Container(
          height: 30,
          decoration:BoxDecoration(color: Colors.black) ,
        ),
      )
    ],);
    // return SingleChildScrollView(
    //   controller: controller,
    //   child: Container(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Container(
    //           height: 80 * rpx,
    //           child: BottomSheetTop()
    //         ),
    //         genReplyList(replies, controller)
    //       ],
    //     ),
    //   ),
    // );
  }
}
//父评论
class ReplyList extends StatelessWidget {
  const ReplyList({Key key, this.reply, this.controller}) : super(key: key);
  final Reply reply;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    // RecommendProvider provider = Provider.of<RecommendProvider>(context);
    List<Reply> replies = List<Reply>();
    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100 * rpx,
                height: 100 * rpx,
                padding: EdgeInsets.all(10 * rpx),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${reply.replyMakerAvatar}'),
                ),
              ),
              Container(
                width: 550 * rpx,
                child: ListTile(
                  title: Text('${reply.replyMakerName}'),
                  subtitle: Text(
                    '${reply.replyContent}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 100 * rpx,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
          genAfterReplyList(replies, controller)
        ],
      ),
    );
  }
}
//子评论
class AfterReply extends StatelessWidget {
  const AfterReply({Key key, this.afterReply}) : super(key: key);
  final Reply afterReply;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 100 * rpx,
                ),
                Container(
                  width: 550 * rpx,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 70 * rpx,
                        height: 70 * rpx,
                        padding: EdgeInsets.all(5 * rpx),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('${afterReply.replyMakerAvatar}'),
                        ),
                      ),
                      Container(
                        width: 480 * rpx,
                        child: ListTile(
                            title: Text('${afterReply.replyMakerName}'),
                            subtitle: RichText(
                              text: TextSpan(
                                  text: '${afterReply.replyContent}',
                                  style: TextStyle(color: Colors.grey[500]),
                                  children: [
                                    TextSpan(text: '   ${afterReply.whenReplied}')
                                  ]),
                            )
                            // Text(
                            //   '${afterReply.replyContent}',
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100 * rpx,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.grey[300],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 评论顶部
class BottomSheetTop extends StatelessWidget {
  const BottomSheetTop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Expanded(
            flex: 8,
            child: Center(
              child: Text('10条评论'),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          )
        ],
      ),
      // child: ListTile(
      //           leading: Container(
      //             width: 10 * rpx,
      //           ),
      //           trailing: IconButton(
      //             icon: Icon(Icons.close),
      //             onPressed: () {},
      //           ),
      //           title: Center(
      //             child: Text('10条评论'),
      //           ),
      //         ),
    );
  }
}




genReplyList(List<Reply> replies, ScrollController controller) {
  return ListView.builder(
    controller: controller,
    shrinkWrap: true,
    itemCount: replies.length,
    itemBuilder: (context, index) {
      return ReplyList(
        reply: replies[index],
        controller: controller,
      );
    },
  );
}

genAfterReplyList(List<Reply> replies, ScrollController controller) {
  return ListView.builder(
    shrinkWrap: true,
    controller: controller,
    itemCount: replies.length > 2 ? 2 : replies.length,
    itemBuilder: (context, index) {
      return AfterReply(
        afterReply: replies[index],
      );
    },
  );
}
