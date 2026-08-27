import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filter_provider.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({
    super.key,
  });

  static const List<String> availableTags = [
    'Money Maker',
    'Top Performer',
    'Most Resilient',
    'Whale Manager',
    'Solid Growth',
    'Low Leverage',
    'Most Consistent',
  ];

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final filter = ref.watch(filterProvider);
    final notifier = ref.read(filterProvider.notifier);

    final minPnl = filter.minPnl;
    final maxPnl = filter.maxPnl;
    final minRoi = filter.minRoi;
    final apiOnly = filter.apiOnly;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Advance Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Tags',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: availableTags.map((tag) {
                  final selected =
                      filter.tags.contains(tag);

                  return FilterChip(
                    label: Text(tag),
                    selected: selected,

                    onSelected: (_) {
                      notifier.toggleTag(tag);
                    },

                    selectedColor:
                        const Color(0xFFFFE28A),

                    checkmarkColor: Colors.black,

                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              const Text(
                '7D PNL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _ValueBox(
                      value:
                          minPnl.toStringAsFixed(0),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Text('-'),
                  ),
                  Expanded(
                    child: _ValueBox(
                      value:
                          maxPnl.toStringAsFixed(0),
                    ),
                  ),
                ],
              ),

              RangeSlider(
                min: 0,
                max: 500000,
                values: RangeValues(
                  minPnl,
                  maxPnl,
                ),
                onChanged: (values) {
                  notifier.setPnlRange(
                    values.start,
                    values.end,
                  );
                },
              ),

              const SizedBox(height: 16),

              const Text(
                '7D ROI',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                children: [
                  _RoiChip(
                    title: '≥ 0%',
                    selected: minRoi == 0,
                    onTap: () {
                      notifier.setMinRoi(
                        minRoi == 0 ? null : 0,
                      );
                    },
                  ),

                  _RoiChip(
                    title: '≥ 25%',
                    selected: minRoi == 25,
                    onTap: () {
                      notifier.setMinRoi(
                        minRoi == 25 ? null : 25,
                      );
                    },
                  ),

                  _RoiChip(
                    title: '≥ 50%',
                    selected: minRoi == 50,
                    onTap: () {
                      notifier.setMinRoi(
                        minRoi == 50 ? null : 50,
                      );
                    },
                  ),

                  _RoiChip(
                    title: '≥ 100%',
                    selected: minRoi == 100,
                    onTap: () {
                      notifier.setMinRoi(
                        minRoi == 100 ? null : 100,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'API',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Show API traders only',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  Switch(
                    value: apiOnly,
                    onChanged: (value) {
                      notifier.setApiOnly(value);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        notifier.reset();
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(48),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(48),
                        backgroundColor:
                            const Color(0xFFF5B800),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RoiChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _RoiChip({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(title),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: const Color(0xFFFFE28A),
    );
  }
}
