import 'dart:math';

import 'package:flutter/material.dart';

class ColumnChartData {
  ColumnChartData(this.content, this.currentUsage);
  final String content;
  final double currentUsage;
}
final List<ColumnChartData> columnChartData0 = [
  ColumnChartData('February 27, 2023', 420),
  ColumnChartData('February 28, 2023', 590),
  ColumnChartData('March 01, 2023', 700),
  ColumnChartData('March 02, 2023', 480),
  ColumnChartData('March 03, 2023', 680),
  ColumnChartData('March 04, 2023', 410),
  ColumnChartData('March 05, 2023', 220),
  ColumnChartData('March 06, 2023', 530),
];


// final List<ColumnChartData> columnChartData1 = [
//   ColumnChartData('Aug', 420, 0, AppColors.secondaryYellow),
//   ColumnChartData('Sep', 590, 0, AppColors.secondaryYellow),
//   ColumnChartData('Oct', 700, 0, AppColors.secondaryYellow),
//   ColumnChartData('Nov', 480, 0, AppColors.secondaryYellow),
//   ColumnChartData('Dec', 680, 0, AppColors.secondaryPurple, AppColors.secondaryYellow),
//   ColumnChartData('Jan', 700, 750, _setColor(700, 680), AppColors.secondaryYellow),
// ];

// Color _setColor(double currentUsage, double lastMonthUsage){
//   if(currentUsage < lastMonthUsage){
//     return AppColors.secondaryGreen;
//   }else {
//     return AppColors.primaryRed;
//   }
// }