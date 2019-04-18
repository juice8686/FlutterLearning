import 'dart:io';
import 'package:flutter/material.dart';

import 'package:trader_detail/models/trade_detail_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionRecord {
  int index;
  bool expand;
  SectionRecord({@required this.index, @required this.expand});
  @override
  String toString() {
    return ' index : ${this.index}, expand : ${this.expand}';
  }
}

typedef TradeCellCallback = SectionRecord Function(
    SectionRecord aSectionRecord);

class TradeCell extends StatefulWidget {
  TradeDetailModel tradeDetailModel;
  var index;
  TradeCellCallback tradeCellCallback;

  TradeCell({
    Key key,
    @required this.tradeDetailModel,
    @required this.index,
    this.tradeCellCallback,
  })  : assert(tradeDetailModel != null),
        assert(index != null),
        super(key: key);

  @override
  _TradeCellState createState() => _TradeCellState();
}

// 正常高度为 70
// 展开高度为 106
class _TradeCellState extends State<TradeCell> {
  Widget container = Container();
  SectionRecord _sectionRecord;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget expandWidget() {
    if (_sectionRecord != null) {
      print(
          '_sectionRecord = $_sectionRecord , widget.index = ${widget.index}');
    } else {
      print('widget.index = ${widget.index}');
    }

    if (_sectionRecord != null &&
        _sectionRecord.expand != null &&
        _sectionRecord.expand &&
        _sectionRecord.index == widget.index) {
      return Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Stack(
          children: <Widget>[
            // Image(image: ,),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              // color: Colors.blue,
              height: 35,
              width: ScreenUtil.screenWidth - 30,
              child: Image.asset(
                'images/tradeDetail_greyBg.png',
                width: ScreenUtil.screenWidth - 30,
                height: ScreenUtil.instance.setHeight(35),
                fit: BoxFit.fill,
              ),
            ),

            Container(
              // color: Colors.blue,
              height: 40,
              width: ScreenUtil.screenWidth - 30,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '${widget.tradeDetailModel.remain}',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(height: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('-----before ----- $_sectionRecord');
        setState(() {
          _sectionRecord = widget.tradeCellCallback(_sectionRecord);

          // if (widget.index != _sectionRecord.index) {
          //   _sectionRecord.expand = false;
          // }
        });
        print('-----after ----- $_sectionRecord');
        // if (tmpsectionRecord != null) return;
        // if (tmpsectionRecord == _sectionRecord) {
        //   _sectionRecord.expand = false;
        // } else {
        //   _sectionRecord.expand = true;
        // }
      },

      /// 方法的是否有值知否要判断
      // onTap: () {
      //   // if (widget.tradeCellCallback()) {}

      //   print(
      //       '\n=============================\nwidget.index = ${widget.index} \n${widget.tradeDetailModel}\n=============================');
      // },
      onTapCancel: () {
        print('我被取消了');
      },
      // 如何监听点击 开始点击 - 结束点击？？？？

      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Column(
              // 先看看如果没有container是否可以定制高度
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        '${widget.tradeDetailModel.typeDetail}',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff333333)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 15),
                      child: Text(
                        '${widget.tradeDetailModel.outCome > 0 ? "-${widget.tradeDetailModel.outCome}" : "+${widget.tradeDetailModel.inCome}"}元',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: widget.tradeDetailModel.outCome > 0
                                ? Color(0xff10bfc7)
                                : Color(0xffff8A10)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 8),
                      child: Text(
                        '${widget.tradeDetailModel.dealTime}',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffb3b3b3)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 8),
                      child: Text(
                        '可以用余额${widget.tradeDetailModel.availableBalance}元',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color(0xff999999)),
                      ),
                    ),
                  ],
                ),
                // 展开的详细说明
                expandWidget(),

                // if (_sectionRecord.expand) {
                //   Container(),
                // } else {

                // }

                /// 分割线
                Container(
                  width: ScreenUtil.screenWidth,
                  height: 0.5,
                  color: Colors.black12,
                ),
              ],
            ),

            // Opacity(
            //   // 设置透明度
            //   opacity: 0.1,
            //   child: Container(
            //     width: ScreenUtil.screenWidth,
            //     height: 100,
            //     color: Colors.blue[100],
            //   ),
            // ),
          ],
        ),
      ),
      // child:

      // ),
    );
  }
}
