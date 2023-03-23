import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:test_charts/constant/edge_insets_custom.dart';
import 'package:test_charts/widget/area_chart_widget.dart';
import 'package:test_charts/widget/button_floating_status.dart';
import 'package:test_charts/widget/chat_page.dart';

import '../constant/app_colors.dart';
import '../constant/responsive.dart';
import 'constant/svg_picture_custom.dart';
import 'widget/chart_combine_widget.dart';

class TestChart extends StatefulWidget {
  const TestChart({Key? key}) : super(key: key);

  @override
  State<TestChart> createState() => _TestChartState();
}

class _TestChartState extends State<TestChart> with SingleTickerProviderStateMixin {

  late BuildContext buildContext;
  late Responsive responsive;
  bool isExpand = false;
  bool hasFocus = false;

  Offset position = const Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    responsive = Responsive(buildContext);

    return Stack(
      children: [
        Scaffold(
          body: Container(
            color: AppColors.neutral00,
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ChartCombineWidget(),
                AreaChartWidget(),
              ],
            )
          ),
        ),
        _getContentPopUpWidget(),
      ],
    );
  }

  _getContentPopUpWidget(){
    return Stack(
      children: [
        isExpand == false
            ? ButtonFloatingStatus(callbackExpand: callBackExpand, callBackOffset: callBackOffset, position: position)
            : SafeArea(
              child: Container(
                color: AppColors.neutral08.withOpacity(0.6),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: Responsive(context).getHeightResponsive(70.0),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      isExpand = !isExpand;
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 2.0, color: Colors.white)
                                        ),
                                        padding: EdgeInsetsCustom().all(context: context, value: 1.0),
                                        child: const SvgPictureCustom(width: 60.0, height: 60.0, path: 'assets/bot.svg')
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  isExpand = !isExpand;
                                  setState(() {

                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(child: ChatPage(callbackExpand: callBackExpand)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  void callBackExpand(bool isExpand){
    setState(() {
      this.isExpand = isExpand;
    });
  }

  void callBackOffset(Offset offset){
    setState(() {
      position = offset;
    });
  }
}
