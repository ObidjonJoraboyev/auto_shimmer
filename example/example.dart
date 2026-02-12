import 'package:auto_shimmer/auto_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: AutoShimmerExample(), debugShowCheckedModeBanner: false));
}

class AutoShimmerExample extends StatefulWidget {
  const AutoShimmerExample({super.key});

  @override
  State<AutoShimmerExample> createState() => _AutoShimmerExampleState();
}

class _AutoShimmerExampleState extends State<AutoShimmerExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoTheme.brightnessOf(context) == Brightness.dark
          ? CupertinoColors.black
          : Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: CupertinoTheme.brightnessOf(context) == Brightness.dark
            ? CupertinoColors.black
            : Colors.white,
        title: AutoShimmer(
          duration: Duration(milliseconds: 1800),
          baseColor: CupertinoColors.systemGrey,
          isLoading: true,
          child: Text("Loading name..."),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 22, bottom: 4),
              child: Text("News"),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  ...List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: AutoShimmer(
                        direction: ShimmerDirection.ttb,
                        tilt: -0.3,
                        duration: Duration(milliseconds: 1800),
                        isLoading: true,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 22, bottom: 4),
              child: Text("Products"),
            ),
            GridView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16),
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return AutoShimmer(
                  isLoading: true,
                  duration: const Duration(milliseconds: 1800),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Item $index",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
