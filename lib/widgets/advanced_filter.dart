import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filter_provider.dart';

class AdvancedFilter extends ConsumerWidget {
  const AdvancedFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final notifier = ref.read(filterProvider.notifier);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          )),
      child: SafeArea(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8),
            width: 45,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Advance Filters',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Tags'),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.8,
                    children: [
                      _FilterButton(
                        title: 'Money Maker',
                        selected: filter.tag.contains('Money Maker'),
                        onTap: () {
                          notifier.toggleTag('Money Maker');
                        },
                      ),
                      _FilterButton(
                        title: 'Top Performer',
                        selected: filter.tag.contains('Top Performer'),
                        onTap: () {
                          notifier.toggleTag('Top Performer');
                        },
                      ),
                      _FilterButton(
                        title: 'Most Resilient',
                        selected: filter.tag.contains('Most Resilient'),
                        onTap: () {
                          notifier.toggleTag('Most Resilient');
                        },
                      ),
                      _FilterButton(
                        title: 'Whale Manager',
                        selected: filter.tag.contains('Whale Manager'),
                        onTap: () {
                          notifier.toggleTag('Whale Manager');
                        },
                      ),
                      _FilterButton(
                        title: 'Solid Growth',
                        selected: filter.tag.contains('Solid Growth'),
                        onTap: () {
                          notifier.toggleTag('Solid Growth');
                        },
                      ),
                      _FilterButton(
                        title: 'Low Leverage',
                        selected: filter.tag.contains('Low Leverage'),
                        onTap: () {
                          notifier.toggleTag('Low Leverage');
                        },
                      ),
                      _FilterButton(
                        title: 'Most Consistent',
                        selected: filter.tag.contains('Most Consistent'),
                        onTap: () {
                          notifier.toggleTag('Most Consistent');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '30D PnL',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _ValueBox(
                        value: filter.minPnl.toStringAsFixed(0),
                      )),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Text('-'),
                      ),
                      Expanded(
                          child: _ValueBox(
                        value: filter.maxPnl.toStringAsFixed(0),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          rangeThumbShape: RoundRangeSliderThumbShape(
                              enabledThumbRadius: 11)),
                      child: RangeSlider(
                        min: 0,
                        max: 500000,
                        values: RangeValues(filter.minPnl, filter.maxPnl),
                        onChanged: (value) {
                          notifier.setPnl(
                            value.start,
                            value.end,
                          );
                        },
                      )),
                  const SizedBox(height: 12),
                  const Text(
                    '7D ROI',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.8,
                    children: [
                      _FilterButton(
                        title: '≥0%',
                        selected: filter.minRoi == 0,
                        onTap: () {
                          notifier.setRoi(0);
                        },
                      ),
                      _FilterButton(
                        title: '≥25%',
                        selected: filter.minRoi == 25,
                        onTap: () {
                          notifier.setRoi(25);
                        },
                      ),
                      _FilterButton(
                        title: '≥50%',
                        selected: filter.minRoi == 50,
                        onTap: () {
                          notifier.setRoi(50);
                        },
                      ),
                      _FilterButton(
                        title: '≥100%',
                        selected: filter.minRoi == 100,
                        onTap: () {
                          notifier.setRoi(100);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'API',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: filter.apiOnly,
                        activeColor: Colors.amber,
                        onChanged: (value) {
                          notifier.setApi(value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        notifier.reset();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text('Reset'),
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text('Confirm'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Colors.black : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ValueBox extends StatelessWidget {
  final String value;

  const _ValueBox({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
