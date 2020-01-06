import 'package:flutter/material.dart';

class RecommendProvider with ChangeNotifier {
  bool ifShowBottom = true;

  MainInfo mainInfo = MainInfo(
      avataurl: 'http://tengj.top/img/author.jpg',
      userName: '人民日报',
      content:
          ' SpringBoot中单元测试类写在在src/test/java目录下，你可以手动创建具体测试类，如果是IDEA，则可以通过IDEA自动创建测试类，如下图，也可以通过快捷键⇧⌘T(MAC)或者Ctrl+Shift+T(Window)来创建，如下：',
      favCount: 33,
      replyCount: 44,
      sharedCount: 33,
      desc: 'hello_world',
      videoUrl: '',
      ifFaved: false);
  Reply reply = Reply(
      ifFaved: true,
      afterReplies: List<Reply>(),
      replyContent: "真可爱，真好看，真厉害~真可爱，真好看，真厉害~",
      replyMakerAvatar:
          "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
      replyMakerName: "ABC",
      whenReplied: "3小时前");

  hideBottomBar() {
    ifShowBottom = false;
    notifyListeners();
  }
  showBottomBar(){
     ifShowBottom = true;
    notifyListeners();
  }
  tapFav() {
    mainInfo.ifFaved = !mainInfo.ifFaved;
    if (mainInfo.ifFaved) {
      mainInfo.favCount += 1;
    } else {
      mainInfo.favCount -= 1;
    }
    notifyListeners();
  }
}

class MainInfo {
  MainInfo(
      {this.avataurl,
      this.content,
      this.desc,
      this.favCount,
      this.ifFaved,
      this.replyCount,
      this.sharedCount,
      this.userName,
      this.videoUrl});

  String avataurl;
  String content;
  int favCount;
  int replyCount;
  int sharedCount;
  String userName;
  String videoUrl;
  String desc;
  bool ifFaved;
}

class Reply {
  String replyMakerName;
  String replyMakerAvatar;
  String replyContent;
  String whenReplied;
  bool ifFaved;
  List<Reply> afterReplies;

  Reply(
      {this.ifFaved,
      this.afterReplies,
      this.replyContent,
      this.replyMakerAvatar,
      this.replyMakerName,
      this.whenReplied});
}
