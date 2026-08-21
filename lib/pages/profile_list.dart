import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/trader_provider.dart';
import '../widgets/advanced_filter.dart';
import '../providers/filter_provider.dart';

class TraderPage extends ConsumerWidget {
  const TraderPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final traders = ref.watch(traderProvider);
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Traders'),
        // ),
        body: traders.when(loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (error, stackTrace) {
      return Center(
        child: Text('Error: $error'),
      );
    }, data: (traders) {
      final filter = ref.watch(filterProvider);
      final filteredtraders = traders.where((trader) {
        if (filter.tag.isNotEmpty) {
          if (!filter.tag.every(
            (tag) => trader.tags.contains(tag),
          )) {
            return false;
          }
        }

        if (filter.apiOnly && trader.isAPI != true) {
          return false;
        }

        final pnl = trader.pnl30d ?? 0;
        if (pnl < filter.minPnl) {
          return false;
        }
        if (pnl > filter.maxPnl) {
          return false;
        }

        if (filter.minRoi != null) {
          final roi = trader.roi30d ?? 0;
          if (roi < filter.minRoi!) {
            return false;
          }
        }

        return true;
      }).toList();
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: filteredtraders.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Spot"),
                          SizedBox(
                            child: Text("Be a Lead Traader"),
                          )
                        ],
                      ),
                      Text(
                        "Spot Copy Trading",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Follow the world's top cryto traders and copy their trades with one click",
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text("Join Elite Trader Program"),
                            Text("Up To 30% Profit Share!"),
                            Text("Join")
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: null,
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(1.0),
                                  side: BorderSide(
                                      color: Colors.amber, width: 1.5),
                                  shape: LinearBorder.bottom(
                                      size: 1, alignment: 0.5)),
                              child: Text(
                                'Recommended',
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                            onPressed: null,
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(1.0),
                                side:
                                    BorderSide(color: Colors.amber, width: 1.5),
                                shape: LinearBorder.bottom(
                                    size: 1, alignment: 10.5)),
                            child: Text(
                              "All Portfolios",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: null,
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(1.0),
                                side:
                                    BorderSide(color: Colors.amber, width: 1.5),
                                shape: LinearBorder.bottom(
                                    size: 1, alignment: 0.5)),
                            child: Text(
                              "My Favorites",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Container(
                            color: Colors.amber[50],
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return AdvancedFilter();
                                      });
                                },
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("High PNL"),
                          TextButton(onPressed: null, child: Text("More"))
                        ],
                      )
                    ],
                  ));
            }
            final trader = filteredtraders[index - 1];
            return Card(
              shape: Border.all(color: Colors.white70),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                    Colors.white,
                    Colors.amber.shade100,
                  ]
                  )
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(trader.avatarUrl),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(trader.name),
                              Row(
                                children: [
                                  Text(
                                      '${trader.copierCount}/${trader.copierLimit}'),
                                  if (trader.isAPI == true) const Text(' API')
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text("30 Days PNL (USD)"),
                      Text('${trader.pnl30d}'),
                      Text('ROI  ${trader.roi30d}%'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [const Text('AUM'), Text('${trader.aum}')],
                          ),
                          Column(
                            children: [
                              const Text('30 Days MDD'),
                              Text('${trader.mdd30d}')
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Days Leading Trading'),
                              Text('${trader.shareRation}')
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: null, child: Text('Mock')),
                          ElevatedButton(onPressed: null, child: Text('Copy')),
                        ],
                      )
                    ],
                  ),
                  // subtitle: Text('ROI 30D: ${trader.roi30d}'),
                ),
              ),
            );
          });
    }));
  }
}
