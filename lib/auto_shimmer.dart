import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Shimmer animation direction.
enum ShimmerDirection { ltr, rtl, ttb, btt }

/// A lightweight, theme-aware shimmer wrapper for any widget.
///
/// Use it to show loading placeholders (skeleton shimmer) on top of
/// text, containers, cards, grids, and lists.
class AutoShimmer extends StatefulWidget {
  /// The widget to apply the shimmer effect to.
  final Widget child;

  /// Whether shimmer animation is active.
  ///
  /// If `false`, returns [child] as-is.
  final bool isLoading;

  /// Animation duration for one shimmer pass.
  final Duration duration;

  /// Base color of the shimmer.
  ///
  /// If null, an adaptive theme-based color is used.
  final Color? baseColor;

  /// Highlight color of the shimmer.
  ///
  /// If null, an adaptive theme-based color is used.
  final Color? highlightColor;

  /// Shimmer direction (left-to-right, right-to-left, top-to-bottom, bottom-to-top).
  final ShimmerDirection direction;

  /// Diagonal tilt amount for horizontal shimmer.
  ///
  /// Automatically ignored for vertical directions.
  final double tilt;

  /// Creates an [AutoShimmer] widget.
  const AutoShimmer({
    super.key,
    required this.child,
    required this.isLoading,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
    this.direction = ShimmerDirection.ltr,
    this.tilt = -0.3,
  });

  @override
  State<AutoShimmer> createState() => _AutoShimmerState();
}

class _AutoShimmerState extends State<AutoShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _syncAnimation();
  }

  void _syncAnimation() {
    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.stop();
      _controller.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(AutoShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.isLoading != widget.isLoading) {
      _syncAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    final isDark = Platform.isIOS
        ? (CupertinoTheme.of(context).brightness == Brightness.dark)
        : Theme.of(context).brightness == Brightness.dark;

    final base = widget.baseColor ??
        (isDark
            ? CupertinoColors.systemGrey6.resolveFrom(context)
            : CupertinoColors.systemGrey5.resolveFrom(context));

    final highlight = widget.highlightColor ??
        (isDark
            ? CupertinoColors.systemGrey5.resolveFrom(context)
            : CupertinoColors.systemGrey6.resolveFrom(context));

    return ExcludeSemantics(
      excluding: true,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              final t = Curves.easeInOutSine.transform(_controller.value);
              final travel = (t * 2.8) - 1.4;
              final double tilt = (widget.direction == ShimmerDirection.ttb ||
                      widget.direction == ShimmerDirection.btt)
                  ? 0.0
                  : widget.tilt;

              Alignment begin;
              Alignment end;

              switch (widget.direction) {
                case ShimmerDirection.ltr:
                  begin = Alignment(travel - 1.0, tilt);
                  end = Alignment(travel + 1.0, -tilt);
                  break;

                case ShimmerDirection.rtl:
                  final x = -travel;
                  begin = Alignment(x - 1.0, -tilt);
                  end = Alignment(x + 1.0, tilt);
                  break;

                case ShimmerDirection.ttb:
                  begin = Alignment(0.0, travel - 1.0);
                  end = Alignment(0.0, travel + 1.0);
                  break;

                case ShimmerDirection.btt:
                  final y = -travel;
                  begin = Alignment(0.0, y - 1.0);
                  end = Alignment(0.0, y + 1.0);
                  break;
              }
              return LinearGradient(
                begin: begin,
                end: end,
                colors: [base, base, highlight, base, base],
                stops: const [0.0, 0.32, 0.5, 0.68, 1.0],
              ).createShader(bounds);
            },
            child: widget.child,
          );
        },
      ),
    );
  }
}
