import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filter_provider.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  ConsumerState<FilterBottomSheet> createState() =>
      _FilterBottomSheetState();
}

class _FilterBottomSheetState
    extends ConsumerState<FilterBottomSheet> {
  // Tags ที่ต้องแสดงใน Filter
  static const List<String> availableTags = [
    'Money Maker',
    'Top Performer',
    'Most Resilient',
    'Whale Manager',
    'Solid Growth',
    'Low Leverage',
    'Most Consistent',
  ];

  late List<String> selectedTags;

  double minPnl = 0;
  double maxPnl = 500000;

  double? minRoi;

  bool apiOnly = false;

  @override
  void initState() {
    super.initState();

    final filter = ref.read(filterProvider);

    selectedTags = [...filter.tags];

    minPnl = filter.minPnl;
    maxPnl = filter.maxPnl;
    minRoi = filter.minRoi;
    apiOnly = filter.apiOnly;
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // Header
              // =========================

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
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // =========================
              // Tags
              // =========================

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
                      selectedTags.contains(tag);

                  return FilterChip(
                    label: Text(tag),
                    selected: selected,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          selectedTags.add(tag);
                        } else {
                          selectedTags.remove(tag);
                        }
                      });
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

              // =========================
              // PNL
              // =========================

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
                      value: minPnl.toStringAsFixed(0),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Text('-'),
                  ),

                  Expanded(
                    child: _ValueBox(
                      value: maxPnl.toStringAsFixed(0),
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
                  setState(() {
                    minPnl = values.start;
                    maxPnl = values.end;
                  });
                },
              ),

              const SizedBox(height: 16),

              // =========================
              // ROI
              // =========================

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
                    value: 0,
                    selected: minRoi == 0,
                    onTap: () {
                      setState(() {
                        minRoi = minRoi == 0 ? null : 0;
                      });
                    },
                  ),

                  _RoiChip(
                    title: '≥ 25%',
                    value: 25,
                    selected: minRoi == 25,
                    onTap: () {
                      setState(() {
                        minRoi = minRoi == 25 ? null : 25;
                      });
                    },
                  ),

                  _RoiChip(
                    title: '≥ 50%',
                    value: 50,
                    selected: minRoi == 50,
                    onTap: () {
                      setState(() {
                        minRoi = minRoi == 50 ? null : 50;
                      });
                    },
                  ),

                  _RoiChip(
                    title: '≥ 100%',
                    value: 100,
                    selected: minRoi == 100,
                    onTap: () {
                      setState(() {
                        minRoi = minRoi == 100 ? null : 100;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // API
              // =========================

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
                      setState(() {
                        apiOnly = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================
              // Buttons
              // =========================

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
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
                      onPressed: _confirm,
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(48),
                        backgroundColor:
                            const Color(0xFFF5B800),
                        foregroundColor:
                            Colors.black,
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

  void _confirm() {
    final notifier =
        ref.read(filterProvider.notifier);

    // Tags
    notifier.setTags(selectedTags);

    // PNL
    notifier.setPnlRange(
      minPnl,
      maxPnl,
    );

    // ROI
    notifier.setMinRoi(minRoi);

    // API
    notifier.setApiOnly(apiOnly);

    Navigator.pop(context);
  }

  void _reset() {
  // Reset local state
  setState(() {
    selectedTags = [];
    minPnl = 0;
    maxPnl = 500000;
    minRoi = null;
    apiOnly = false;
  });

  // Reset Riverpod state
  ref.read(filterProvider.notifier).reset();
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
        borderRadius:
            BorderRadius.circular(8),
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
  final double? value;
  final bool selected;
  final VoidCallback onTap;

  const _RoiChip({
    required this.title,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(title),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor:
          const Color(0xFFFFE28A),
    );
  }
}