import 'package:flutter/material.dart';
import 'package:mapfeature_project/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MtResult extends StatefulWidget {
  final int userScore;
  final int cognitiveScore;
  final int somaticScore;
  MtResult(
      {required this.userScore,
      required this.cognitiveScore,
      required this.somaticScore});

  @override
  State<MtResult> createState() => _MtResultState();
}

class _MtResultState extends State<MtResult> {
  @override
  Widget build(BuildContext context) {
    // تعريف متغير لتحديد النص الذي سيتم عرضه
    String additionalText = '';
    double percent = (widget.userScore / 63) * 100;
    int roundedPercent = percent.ceil();

    // شرط: إذا كانت نتيجة الاختبار تفي بشرط معين
    if (widget.userScore <= 10 && widget.userScore >= 0) {
      additionalText =
          'THE SEVERITY OF DEPRESSION:These ups and downs are considered normal';
    } else if (widget.userScore <= 16 && widget.userScore > 10) {
      additionalText = 'THE SEVERITY OF DEPRESSION: Mild mood disturbance';
    } else if (widget.userScore <= 20 && widget.userScore > 16) {
      additionalText =
          'THE SEVERITY OF DEPRESSION: Borderline clinical depression';
    } else if (widget.userScore <= 30 && widget.userScore > 20) {
      additionalText = 'THE SEVERITY OF DEPRESSION: Moderate depression';
    } else if (widget.userScore <= 40 && widget.userScore > 30) {
      additionalText = 'THE SEVERITY OF DEPRESSION: Severe depression';
    } else {
      additionalText = 'THE SEVERITY OF DEPRESSION:Extreme depression';
    }

    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Text(
                  '@“Let’s Start…”',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.0),
                // Add more Drawer items if needed
              ],
            ),
          ),
        ),
        body: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'We strongly recommend that you consult a mental health professional for a correct diagnosis if your level of depression is above average',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F5D6B),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'YOUR SCORES',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0), // مسافة عمودية إضافية
                    new CircularPercentIndicator(
                      radius: 90.0,
                      animation: true,
                      animationDuration: 1800,
                      lineWidth: 12.0,
                      percent: ((widget.userScore / 63)),
                      center: new Text(
                        "$roundedPercent %",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: const Color(0xFF8ABAC5)),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: const Color.fromARGB(255, 245, 243, 243),
                      progressColor: const Color(0xFF8ABAC5),
                    ),
                    const SizedBox(
                        height: 16.0), // المسافة بين الـ Slider والنص
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'YOU SCORED  ${widget.userScore} FROM 63 ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // النص الإضافي الذي قد يتغير حسب الشرط
                  ],
                ),
              ),

              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      additionalText.trim(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
// بعد وضع Padding النص الإضافي
              Column(
                children: [
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 350,
                        // height: 140.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8ABAC5),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // تحديد بداية العناصر على محور النص التمركز الأفقي
                          children: [
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'SOMATIC DEPRESSIVE SYMPTOMS:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F5D6B),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: StepProgressIndicator(
                                totalSteps: 39,
                                currentStep: widget.somaticScore,
                                size: 10,
                                selectedColor: const Color(0xFF1F5D6B),
                                unselectedColor: Colors.white,
                                roundedEdges: const Radius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100.0),
                              child: Text(
                                'YOU SCORED $somaticScore From 39',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 350,
                    // height: 150.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8ABAC5),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // تحديد بداية العناصر على محور النص التمركز الأفقي
                      children: [
                        // const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Text(
                            'CONGNITIVE_AFFECTIVE DEPRESSION SYMPTOMS:',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F5D6B),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: StepProgressIndicator(
                            totalSteps: 39,
                            currentStep: widget.cognitiveScore,
                            size: 10,
                            selectedColor: const Color(0xFF1F5D6B),
                            unselectedColor: Colors.white,
                            roundedEdges: const Radius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          child: Text(
                            'YOU SCORED $cognitiveScore From 33',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // باقي محتوى الـ HomeScreen هنا
            ],
          ),
        ]));
  }
}
