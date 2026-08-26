import 'package:flutter/material.dart';

class TraderAvatar extends StatelessWidget {
  final String avatarUrl;

  const TraderAvatar({
    super.key,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFF5B800),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return const Icon(
                  Icons.person,
                  size: 36,
                );
              },
            ),
          ),
        ),

        Positioned(
          right: -2,
          top: -8,
          child: Icon(
            Icons.emoji_events,
            color: const Color(0xFFF5B800),
            size: 22,
          ),
        ),
      ],
    );
  }
}