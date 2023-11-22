import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              width: 70,
              height: 40,
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 197, 197, 197),
                highlightColor: Colors.grey,
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 204, 204, 204),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 300,
          height: 300,
          child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 197, 197, 197),
              highlightColor: Colors.grey,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Colors.amber,
                ),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: ShimmerTile(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: ShimmerTile(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: ShimmerTile(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: ShimmerTile(),
        ),
      ],
    );
  }
}

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 197, 197, 197),
            highlightColor: Colors.grey,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 204, 204, 204),
                borderRadius: BorderRadius.circular(23),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 197, 197, 197),
                highlightColor: Colors.grey,
                child: Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 204, 204, 204),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 30,
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 197, 197, 197),
                highlightColor: Colors.grey,
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 204, 204, 204),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 197, 197, 197),
                highlightColor: Colors.grey,
                child: Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 204, 204, 204),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
