import 'package:flutter/material.dart';

import '../models/trader.dart';
import 'trader_avatar.dart';
import 'trader_stat.dart';

class TraderCard extends StatelessWidget {
  final Trader trader;

  const TraderCard({
    super.key,
    required this.trader,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8DD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // Header
          // =========================

          Row(
            children: [
              TraderAvatar(
                avatarUrl: trader.avatarUrl,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trader.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${trader.copierCount} / ${trader.copierLimit}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        if (trader.isAPI) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'API',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // =========================
          // PNL
          // =========================

          Text(
            '30 Days PNL (USD)',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            _formatMoney(trader.pnl30d),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00C878),
            ),
          ),

          const SizedBox(height: 2),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'ROI ',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: '${trader.roi30d.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Color(0xFF00C878),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // =========================
          // Statistics
          // =========================

          Row(
            children: [
              Expanded(
                child: TraderStat(
                  title: 'AUM',
                  value: _formatMoney(
                    trader.aum,
                    decimals: 2,
                  ),
                ),
              ),
              Expanded(
                child: TraderStat(
                  title: '30 Days MDD',
                  value: '${trader.mdd30d.toStringAsFixed(2)}%',
                ),
              ),
              Expanded(
                child: TraderStat(
                  title: 'Days Leading Trading',
                  value: '0',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // =========================
          // Buttons
          // =========================

          Row(
            children: [
              SizedBox(
                width: 130,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.grey.shade100,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Mock',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.yellow.shade700,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Copy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _formatMoney(
    double value, {
    int decimals = 2,
  }) {
    return value.toStringAsFixed(decimals);
  }
}
