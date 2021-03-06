import 'package:flutter/material.dart';
import '../models/category_model.dart';

///  ChangeNotifier : 管理全量的听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  /// 子类高亮索引
  int childIndex = 0;

  /// 一级分类切换逻辑
  String categoryId = '4';

  /// 小类Id
  String subId = '';

  /// 列表页数
  int page = 1;

  /// 显示没有数据的文字
  String noMoreText = '';

  /// 大类切换保存数据进行传递
  getChildCategory(List<BxMallSubDto> list, String  id) {
    //点击大类 子类高亮所用进行清零
    childIndex = 0;
    categoryId = id;

    /// 添加全部
    BxMallSubDto all = BxMallSubDto();

    all.mallSubId = '';
    //all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';

    /// 重置数据
    childCategoryList = [all];

    /// 注意：如果要使用 addAll 传递进入的参数一定要是指定类型的list
    childCategoryList.addAll(list);

    /// 通知所有的听众
    notifyListeners();
  }

  /// 改变子类索引
  changeChildIndex(index, String id) {
    subId = id;
    childIndex = index;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  /// 增加页面
  addPage() {
    page++;
  }

  changeNomore(String string) {
    noMoreText = string;
    notifyListeners();
  }
}
