import 'package:flutter/material.dart'; // Android的风格
import 'package:flutter/cupertino.dart'; //iOS的风格

import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您的光临';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        // 套一层是为了解决键盘弹出多了一条线
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: _jikeshijian,
                  child: Text('请求数据'),
                ),
                Text(showText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _jikeshijian() {
    print('向极客时间....');

    getHttp2().then((data) {
      setState(() {
        showText = data['data'].toString();
      });
    });
  }

  Future getHttp2() async {
    try {
      print('走try-------------');
      Response response;
      Dio dio = Dio();
      //dio.options.headers = httpHeaders;
      dio.options.headers.addAll(httpHeaders);
      response =
          await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      print('请求成功');
      print(response);
      return response.data;
    } catch (e) {
      print('请求失败');
      return print(e);
    }
  }

  // 没有防重复点击
  void _choiceAction() {
    print("开始选择你喜欢的类型.....");
    if (typeController.text.toString() == "") {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('美女类型不能为空'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'];
        });
      });
    }
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
      var data = {"name": TypeText};
      // get 和 post简单换一下就好
      response = await Dio().post(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

// 请求错误捕获异常
// void getHttp() async {
//   print('--------');
//   try {
//     Response response;
//     response = await Dio().get(
//         'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=长腿小姐姐');
//     return print(response);
//   } catch (e) {
//     return print(e);
//   }
// }