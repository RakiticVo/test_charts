import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constant/app_colors.dart';
import '../constant/edge_insets_custom.dart';
import '../constant/responsive.dart';
import '../constant/txt_style.dart';
import '../data/chart_data/line_chart_data.dart';

class AreaChartWidget extends StatefulWidget {
  const AreaChartWidget({Key? key}) : super(key: key);

  @override
  State<AreaChartWidget> createState() => _AreaChartWidgetState();
}

class _AreaChartWidgetState extends State<AreaChartWidget> {
  late BuildContext buildContext;
  late Responsive responsive;
  late TrackballBehavior trackballBehavior;

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    responsive = Responsive(buildContext);

    trackballBehavior = TrackballBehavior(
      enable: true,
      lineType: TrackballLineType.horizontal,
      markerSettings: const TrackballMarkerSettings(
          height: 10,
          width: 10,
          markerVisibility: TrackballVisibilityMode.visible,
          borderColor: AppColors.neutral02,
          borderWidth: 4,
          color: AppColors.neutral00,
          shape: DataMarkerType.circle
      ),
      hideDelay: 5000, // millisecond
      activationMode: ActivationMode.singleTap,
      builder: (context, trackballDetails) {
        return Container(
          height: responsive.getHeightResponsive(75.0),
          width: responsive.getHeightResponsive(185.0),
          decoration: BoxDecoration(
              color: AppColors.neutral04,
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
                          text: getDateFromContentFormat(areaChartCarbonFootprint[trackballDetails.pointIndex!].content),
                          style: TxtStyle().font12(buildContext: context, color: AppColors.neutral01, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: ' (kg CO',
                          style: TxtStyle().font12(buildContext: context, color: AppColors.neutral03),
                          children: [
                            TextSpan(
                              text: '2',
                              style: TxtStyle().font6(buildContext: context, color: AppColors.neutral03,),
                            )
                          ]
                        ),
                        TextSpan(
                          text: '-e)',
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
                        color: AppColors.primaryGreenCyan,
                        shape: BoxShape.circle
                    ),
                  ),
                  const SizedBox(width: 4.0,),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Carbon Footprint: ',
                          style: TxtStyle().font12(buildContext: context, color: AppColors.neutral03),
                        ),
                        TextSpan(
                          text: '${areaChartCarbonFootprint[trackballDetails.pointIndex!].data.toInt()}',
                          style: TxtStyle().font12(buildContext: context, color: AppColors.neutral01, fontWeight: FontWeight.w600),
                        ),
                      ]
                    ),
                  ),
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
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      tooltipAlignment: ChartAlignment.near,
    );

    return Center(
        child: Container(
            color: AppColors.neutral01,
            child: Transform.scale(
              scale: 1.1,
              child: SfCartesianChart(
                trackballBehavior: trackballBehavior,
                primaryXAxis: CategoryAxis(
                  labelStyle: TxtStyle().font12(buildContext: context, color: AppColors.neutral04),
                  axisLine: const AxisLine(color: AppColors.transparent),
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  isVisible: true,
                  labelStyle: TxtStyle().font12(buildContext: context, color: AppColors.neutral04),
                  visibleMinimum: 0,
                  axisLine: const AxisLine(color: AppColors.transparent),
                  majorTickLines: const MajorTickLines(width: 0),
                  interval: 10.0,
                  opposedPosition: true,
                ),
                borderWidth: 1,
                plotAreaBorderWidth: 0,
                series: <CartesianSeries>[
                  SplineAreaSeries<LineChartData, String>(
                    dataSource: areaChartCarbonFootprint,
                    xValueMapper: (LineChartData data, _) => getDayFromContent(data.content).toString(),
                    yValueMapper: (LineChartData data, _) => data.data,
                    gradient: const LinearGradient(
                      colors: [Color(0xff1fbd95), Color(0xffe9fbfa)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    opacity: 0.6,
                    splineType: SplineType.natural,
                  ),
                  SplineSeries<LineChartData, String>(
                    width: 4.0,
                    dataSource: areaChartCarbonFootprint,
                    xValueMapper: (LineChartData data, _) => getDayFromContent(data.content).toString(),
                    yValueMapper: (LineChartData data, _) => data.data,
                    color: AppColors.primaryGreenCyan,
                    splineType: SplineType.natural,
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
    return result + 20 < 50.0 ? 50.0 : result + 20;
  }

  getDayFromContent(String content){
    int temp = content.indexOf(', ', 0);
    if(temp > 0){
      switch(content.substring(0, temp - 3)){
        case 'January': return 1;
        case 'February': return 2;
        case 'March': return 3;
        case 'April': return 4;
        case 'May': return 5;
        case 'June': return 6;
        case 'July': return 7;
        case 'August': return 8;
        case 'September': return 9;
        case 'October': return 10;
        case 'November': return 11;
        case 'December': return 12;
      }
    }
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
