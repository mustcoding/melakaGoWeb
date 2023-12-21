import 'package:flutter/material.dart';
import 'package:melakago_web/Model/appUser.dart';

class RewardPage extends StatefulWidget {
  late appUser user;

  RewardPage({Key? key, required appUser user}) : super(key: key) {
    this.user = user;
  }

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Center(
          child: const Text(
            'Reward Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                width: 670,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      buildTextFieldContainer(
                        label: 'Reward Name',
                        controller: TextEditingController(),
                      ),
                      buildTextFieldContainer(
                        label: 'Reward Description',
                        controller: TextEditingController(),
                        maxLines: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildTextFieldContainer(
                            label: 'Reward Points',
                            controller: TextEditingController(),
                            width: 300.0,
                            keyboardType: TextInputType.number,
                          ),
                          buildTextFieldContainer(
                            label: 'Reward Code',
                            controller: TextEditingController(),
                            width: 300.0,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          // Implement reward redemption logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade700,
                        ),
                        child: const Text(
                          'Add Reward',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldContainer({
    required String label,
    required TextEditingController controller,
    double width = 600.0,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
