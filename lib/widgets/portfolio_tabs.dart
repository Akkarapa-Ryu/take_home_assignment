import 'package:flutter/material.dart';

class PortfolioTabs extends StatelessWidget {
  final int filterCount;
  final VoidCallback onFilterTap;
  final bool hasActiveFilter;

  const PortfolioTabs({
    super.key,
    required this.filterCount,
    required this.onFilterTap,
    required this.hasActiveFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 18,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildTab(
            title: 'Recommended',
            selected: true,
          ),

          _buildTab(
            title: 'All Portfolios',
            selected: false,
          ),

          _buildTab(
            title: 'My Favorites',
            selected: false,
          ),

          const SizedBox(width: 8),

          // =========================
          // Filter Button
          // =========================
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(
                right: 8,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8DD),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(
                      Icons.filter_list,
                    ),
                  ),

                  // Badge
                if (filterCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      constraints:
                          const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFF5B800),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$filterCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool selected,
  }) {
    return Expanded(
      child: SizedBox(
        height: 54,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: selected
                    ? Colors.black
                    : Colors.grey.shade600,
                fontWeight: selected
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            ),

            if (selected)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  color:
                      const Color(0xFFF5B800),
                ),
              ),
          ],
        ),
      ),
    );
  }
}