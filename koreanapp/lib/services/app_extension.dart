import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';


extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  IconThemeData get iconThem => theme.iconTheme;
  TextTheme get text => theme.textTheme;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
}
