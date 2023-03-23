import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constant/app_colors.dart';
import '../constant/edge_insets_custom.dart';
import '../constant/responsive.dart';
import '../constant/txt_style.dart';
import '../data/chart_data/column_chart_data.dart';
import '../data/chart_data/line_chart_data.dart';
class ChartCombineWidget extends StatefulWidget {
  const ChartCombineWidget({Key? key}) : super(key: key);

  @override
  State<ChartCombineWidget> createState() => _ChartCombineWidgetState();
}

class _ChartCombineWidgetState extends State<ChartCombineWidget> {
  late BuildContext buildContext;
  late Responsive responsive;
  // late TooltipBehavior _tooltip;
  late TrackballBehavior trackballBehavior;
  late CrosshairBehavior crosshairBehavior;
  int yAxisChosen = 1; // 0: Column Chart, 1: Spline Chart Usage, 2: Spline Chart Standard
  int pointTemp = 1;
  int currentData = 0;

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    responsive = Responsive(buildContext);

    // _tooltip = TooltipBehavior(
    //   color: AppColors.neutral05,
    //   opacity: 0.5,
    //   shadowColor: AppColors.transparent,
    //   enable: true,
    //   tooltipPosition: TooltipPosition.auto,
    //   builder: (data, point, series, pointIndex, seriesIndex) {
    //     // print('data: $data \n series: $series \n seriesIndex: $seriesIndex \n pointIndex: $pointIndex');
    //     // ColumnChartData chartData = data;
    //     return Container(
    //       height: responsive.getHeightResponsive(80.0),
    //       width: responsive.getHeightResponsive(170.0),
    //       decoration: BoxDecoration(
    //         color: AppColors.transparent.withOpacity(0.1),
    //         borderRadius: BorderRadius.circular(8.0)
    //       ),
    //       padding: EdgeInsetsCustom().all(context: buildContext, value: 8.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text.rich(
    //             TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text:  getDataFromContentFormat(
    //                     seriesIndex == 0
    //                       ? columnChartData0[pointIndex].content
    //                       : seriesIndex == 1
    //                         ? lineChartUsage[pointIndex].content
    //                         : lineChartStandard[pointIndex].content
    //                   ),
    //                   style: TxtStyle().font12(buildContext: context, color: AppColors.neutral01, fontWeight: FontWeight.w600),
    //                 ),
    //                 TextSpan(
    //                   text: ' (kWh)',
    //                   style: TxtStyle().font12(buildContext: context, color: AppColors.neutralShade0475),
    //                 )
    //               ]
    //             )
    //           ),
    //           Row(
    //             children: [
    //               Container(
    //                 width: responsive.getHeightResponsive(12.0),
    //                 height: responsive.getHeightResponsive(12.0),
    //                 decoration: BoxDecoration(
    //                     color: AppColors.primaryBlue,
    //                     borderRadius: BorderRadius.circular(4.0)
    //                 ),
    //               ),
    //               const SizedBox(width: 4.0,),
    //               Text(
    //                 'Standard: ${lineChartStandard[pointIndex].data}kWh',
    //                 style: TxtStyle().font12(buildContext: buildContext, color: AppColors.neutral01, fontWeight: FontWeight.w600),
    //               )
    //             ],
    //           ),
    //           Row(
    //             children: [
    //               Container(
    //                 width: responsive.getHeightResponsive(12.0),
    //                 height: responsive.getHeightResponsive(12.0),
    //                 decoration: BoxDecoration(
    //                     color: Colors.transparent,
    //                     borderRadius: BorderRadius.circular(4.0)
    //                 ),
    //               ),
    //               const SizedBox(width: 4.0,),
    //               // Text(
    //               //   'Usage: ${chartData.currentUsage}kWh',
    //               //   style: TxtStyle().font12(buildContext: buildContext, color: AppColors.neutral01, fontWeight: FontWeight.w600),
    //               // )
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );


    trackballBehavior = TrackballBehavior(
      enable: true,
      markerSettings: const TrackballMarkerSettings(
        height: 10,
        width: 10,
        markerVisibility: TrackballVisibilityMode.visible,
        borderColor: AppColors.neutral02,
        borderWidth: 4,
        color: AppColors.neutral00,
        shape: DataMarkerType.circle,
      ),
      hideDelay: 5000, // millisecond
      activationMode: ActivationMode.doubleTap,
      builder: (context, trackballDetails) {
        return Container(
          height: responsive.getHeightResponsive(100.0),
          width: responsive.getHeightResponsive(170.0),
          decoration: BoxDecoration(
            color: AppColors.neutral05.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.0)
          ),
          padding: EdgeInsetsCustom().all(context: buildContext, value: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                          text: getDateFromContentFormat(
                              trackballDetails.seriesIndex == 0
                                  ? columnChartData0[trackballDetails.pointIndex!].content
                                  : trackballDetails.seriesIndex == 1
                                  ? lineChartUsage[trackballDetails.pointIndex!].content
                                  : lineChartStandard[trackballDetails.pointIndex!].content
                          ),
                          style: TxtStyle().font12(buildContext: context, color: AppColors.neutral01, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: ' (kWh)',
                          style: TxtStyle().font12(buildContext: context, color: AppColors.neutral03),
                        )
                      ]
                  )
              ),
              Row(
                children: [
                  Container(
                    width: responsive.getHeightResponsive(12.0),
                    height: responsive.getHeightResponsive(12.0),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryCyan,
                      shape: BoxShape.circle
                    ),
                  ),
                  const SizedBox(width: 4.0,),
                  Text(
                    'Usage: ${lineChartUsage[trackballDetails.pointIndex!].data.toInt()}',
                    style: TxtStyle().font12(buildContext: buildContext, color: AppColors.neutral03, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: responsive.getHeightResponsive(12.0),
                    height: responsive.getHeightResponsive(12.0),
                    decoration: const BoxDecoration(
                      color: AppColors.neutral02,
                      shape: BoxShape.circle
                    ),
                  ),
                  const SizedBox(width: 4.0,),
                  Text(
                    'Your Goal: ${lineChartStandard[trackballDetails.pointIndex!].data.toInt()}',
                    style: TxtStyle().font12(buildContext: buildContext, color: AppColors.neutral03, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: responsive.getHeightResponsive(12.0),
                    height: responsive.getHeightResponsive(12.0),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryYellow,
                      shape: BoxShape.circle
                    ),
                  ),
                  const SizedBox(width: 4.0,),
                  Text(
                    'Standard: ${lineChartStandard[trackballDetails.pointIndex!].data.toInt()}',
                    style: TxtStyle().font12(buildContext: buildContext, color: AppColors.neutral03, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
        );
      },
      tooltipSettings: InteractiveTooltip(
        enable: true,
        color: AppColors.neutral05.withOpacity(0.5),
      ),
      lineDashArray: const <double>[5,5],
      lineType: TrackballLineType.none,
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      tooltipAlignment: ChartAlignment.near,
    );
    crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineWidth: 1,
      activationMode: ActivationMode.doubleTap,
      hideDelay: 5000, // millisecond
      lineType: CrosshairLineType.horizontal,
      lineDashArray: const <double>[5,5],
    );

    return Center(
        child: Container(
            color: AppColors.neutral01,
            child: Transform.scale(
              scale: 1.1,
              child: SfCartesianChart(
                crosshairBehavior: crosshairBehavior,
                trackballBehavior: trackballBehavior,
                primaryXAxis: CategoryAxis(
                  labelStyle: TxtStyle().font12(buildContext: context, color: AppColors.neutral04),
                  axisLine: const AxisLine(color: AppColors.transparent),
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  name: 'Primary',
                  isVisible: false,
                  labelStyle: TxtStyle().font12(buildContext: context, color: AppColors.neutral04),
                  visibleMinimum: 0,
                  axisLine: const AxisLine(color: AppColors.transparent),
                  majorTickLines: const MajorTickLines(width: 0),
                  interval: 200.0,
                ),
                axes: [
                  NumericAxis(
                    name: 'Usage',
                    isVisible: true,
                    opposedPosition: true,
                    maximum: getMaxData(lineChartUsage),
                    interval: 10,
                    minimum: 0,
                    axisLine: const AxisLine(color: AppColors.transparent),
                    majorTickLines: const MajorTickLines(width: 0),
                    axisLabelFormatter: (axisLabelRenderArgs) {
                      if(axisLabelRenderArgs.value == 50){
                        return ChartAxisLabel('kWh', TxtStyle().font12(buildContext: context, color: AppColors.neutral04));
                      }else{
                        return ChartAxisLabel(axisLabelRenderArgs.text, TxtStyle().font12(buildContext: context, color: AppColors.neutral04));
                      }
                    },
                  ),
                  NumericAxis(
                    name: 'Standard',
                    isVisible: true,
                    opposedPosition: true,
                    maximum: getMaxData(lineChartStandard),
                    interval: 10,
                    minimum: 0,
                    axisLine: const AxisLine(color: AppColors.transparent),
                    majorTickLines: const MajorTickLines(width: 0),
                  ),
                ],
                borderWidth: 1,
                plotAreaBorderWidth: 0,
                series: <CartesianSeries>[
                  StackedColumnSeries<ColumnChartData, String>(
                    enableTooltip: false,
                    width: 0.25,
                    dataSource: columnChartData0,
                    xValueMapper: (ColumnChartData data, _) => getDayFromContent(data.content),
                    yValueMapper: (ColumnChartData data, _) => data.currentUsage,
                    gradient: const LinearGradient(
                      colors: [Color(0xff8080ff), Color(0xffccccff)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                    onPointTap: (pointInteractionDetails) {
                      setState(() {
                        if(yAxisChosen != pointInteractionDetails.seriesIndex!){
                          yAxisChosen = pointInteractionDetails.seriesIndex!;
                          pointTemp = pointInteractionDetails.pointIndex!;
                        }
                      });

                      setState(() {
                        if(yAxisChosen == 2){
                          currentData = lineChartUsage[pointTemp].data.toInt();
                        }else{
                          currentData = lineChartStandard[pointTemp].data.toInt();
                        }
                      });

                      crosshairBehavior.show(pointTemp, currentData.toDouble());
                      print(currentData);
                    },
                  ),
                  SplineSeries<LineChartData, String>(
                    yAxisName: yAxisChosen == 2 ? 'Standard' : 'Usage',
                    width: 4.0,
                    dataSource: lineChartUsage,
                    xValueMapper: (LineChartData data, _) => getDayFromContent(data.content),
                    yValueMapper: (LineChartData data, _) => data.data,
                    color: AppColors.primaryCyan,
                    splineType: SplineType.monotonic,
                    onPointTap: (pointInteractionDetails) {
                      setState(() {
                        if(yAxisChosen != pointInteractionDetails.seriesIndex!){
                          yAxisChosen = pointInteractionDetails.seriesIndex!;
                          pointTemp = pointInteractionDetails.pointIndex!;
                        }
                      });

                      setState(() {
                        if(yAxisChosen == 2){
                          currentData = lineChartStandard[pointTemp].data.toInt();
                        }else{
                          currentData = lineChartUsage[pointTemp].data.toInt();
                        }
                      });

                      crosshairBehavior.show(pointTemp, currentData.toDouble());
                      print(currentData);
                    },
                  ),
                  SplineSeries<LineChartData, String>(
                    yAxisName: yAxisChosen == 2 ? 'Standard' : 'Usage',
                    width: 4.0,
                    dataSource: lineChartStandard,
                    xValueMapper: (LineChartData data, _) => getDayFromContent(data.content),
                    yValueMapper: (LineChartData data, _) => data.data,
                    color: AppColors.primaryYellow,
                    splineType: SplineType.monotonic,
                    onPointTap: (pointInteractionDetails) {
                      setState(() {
                        if(yAxisChosen != pointInteractionDetails.seriesIndex!){
                          yAxisChosen = pointInteractionDetails.seriesIndex!;
                          pointTemp = pointInteractionDetails.pointIndex!;
                        }
                      });

                      setState(() {
                        if(yAxisChosen == 2){
                          currentData = lineChartUsage[pointTemp].data.toInt();
                        }else if(yAxisChosen == 1){
                          currentData = lineChartUsage[pointTemp].data.toInt();
                        }else{
                          currentData = columnChartData0[pointTemp].currentUsage.toInt();
                        }
                      });

                      crosshairBehavior.show(pointTemp, currentData.toDouble());
                      print(currentData);
                    },
                  ),
                ],
              ),
            )
        )
    );
  }

  getMaxData(List<LineChartData> lineChartData){
    double result = 0;
    for(LineChartData data in lineChartData){
      if(max(result, data.data) != result){
        result = data.data;
      }
    }
    int rem = result.toInt() % 10;
    result = rem >= 5 ? (result - rem + 10) : (result - rem);
    // print('resultUsage = ${result}');
    return result + 20 < 50.0 ? 60.0 : result + 20;
  }

  getDayFromContent(String content){
    String result = '';
    int temp = content.indexOf(', ', 0);
    if(temp > 0){
      result = content.substring(temp - 2, temp);
    }
    return result;
  }

  getDateFromContentFormat(String content){
    String result = '';
    int temp = content.indexOf(', ', 0);
    if(temp > 0){
      result = content.substring(temp - 2, temp-1);
      if(result == '0'){
        result = content.replaceRange(temp - 2, temp-1, '');
      }else{
        result = content;
      }
    }
    return result;
  }
}
