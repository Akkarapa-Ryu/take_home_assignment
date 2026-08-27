import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filter_provider.dart';
import '../providers/trader_provider.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/portfolio_tabs.dart';
import '../widgets/top_banner.dart';
import '../widgets/trader_card.dart';


class PortfolioListPage extends ConsumerWidget {
  const PortfolioListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTradersAsync = ref.watch(filteredTraderProvider);
    final filterCount = ref.watch(activeFilterCountProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: filteredTradersAsync.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },

          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Error: $error',
              ),
            );
          },

          data: (filteredTraders) {
            return CustomScrollView(
              slivers: [
                // =========================
                // Top section
                // =========================

                SliverToBoxAdapter(
                  child: _buildHeader(),
                ),

                // =========================
                // Banner
                // =========================

                const SliverToBoxAdapter(
                  child: TopBanner(),
                ),

                // =========================
                // Tabs + Filter
                // =========================

                SliverToBoxAdapter(
                  child: PortfolioTabs(
                    filterCount: filterCount,
                    onFilterTap: () {
                      showModalBottomSheet(context: context, 
                      builder: (context) {
                        return FilterBottomSheet();
                      });
                    }, hasActiveFilter: filterCount > 0,
                  ),
                ),

                // =========================
                // Section title
                // =========================

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      14,
                      20,
                      14,
                      12,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'High PNL',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(width: 4),

                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              'More',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // =========================
                // Trader Cards
                // =========================

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final trader = filteredTraders[index];

                        return TraderCard(
                          trader: trader,
                        );
                      },
                      childCount: filteredTraders.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        14,
        16,
        14,
        12,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          // Spot
          const Row(
            children: [
              Text(
                'Spot',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(width: 4),

              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
            ],
          ),

          // Right buttons
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outline,
                  size: 20,
                ),
                label: const Text(
                  'Be a Lead Trader',
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor:
                      const Color(0xFFF5B800),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}