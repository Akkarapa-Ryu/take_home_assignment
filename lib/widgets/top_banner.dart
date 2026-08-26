import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          child: const Text('Spot Copy Trading',
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          child: const Text("Follow the world's top cryto traders and copy their trades with one click",
            softWrap: true,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.maxFinite,
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join Elite Trader Program',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Up To 30% Profit Share!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Join Now',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
