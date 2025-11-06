import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final int delay;

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.delay = 0,
  });

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: FilterChip(
            selected: _isSelected,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 16),
                const SizedBox(width: 6),
                Text(widget.label),
              ],
            ),
            onSelected: (selected) {
              setState(() => _isSelected = selected);
            },
            backgroundColor: widget.color.withOpacity(0.1),
            selectedColor: widget.color.withOpacity(0.3),
            checkmarkColor: widget.color,
            labelStyle: TextStyle(
              color: widget.color.withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        ),
      ),
    );
  }
}
