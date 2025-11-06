import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/books_provider.dart';
import '../widgets/advanced_book_card.dart';
import '../widgets/advanced_book_list_item.dart';
import 'book_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Bestseller', 'query': 'bestseller', 'gradient': [Color(0xFFFF6B6B), Color(0xFFFF8E53)], 'icon': Icons.local_fire_department_rounded},
    {'name': 'Fiction', 'query': 'fiction', 'gradient': [Color(0xFF4E65FF), Color(0xFF92EFFD)], 'icon': Icons.auto_stories_rounded},
    {'name': 'Mystery', 'query': 'mystery', 'gradient': [Color(0xFF9D50BB), Color(0xFF6E48AA)], 'icon': Icons.search_rounded},
    {'name': 'Romance', 'query': 'romance', 'gradient': [Color(0xFFFF6B9D), Color(0xFFC76DD8)], 'icon': Icons.favorite_rounded},
    {'name': 'Sci-Fi', 'query': 'science fiction', 'gradient': [Color(0xFF00C9FF), Color(0xFF92FE9D)], 'icon': Icons.rocket_launch_rounded},
    {'name': 'History', 'query': 'history', 'gradient': [Color(0xFFFFAA85), Color(0xFFB77A82)], 'icon': Icons.history_edu_rounded},
    {'name': 'Biography', 'query': 'biography', 'gradient': [Color(0xFF667EEA), Color(0xFF764BA2)], 'icon': Icons.person_rounded},
    {'name': 'Fantasy', 'query': 'fantasy', 'gradient': [Color(0xFFF093FB), Color(0xFFF5576C)], 'icon': Icons.castle_rounded},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(currentBooksProvider);
    final viewMode = ref.watch(viewModeProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Categories go below when screen < 900px
    final categoriesBelow = screenWidth < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Space for header (taller if categories below)
              SliverToBoxAdapter(child: SizedBox(height: categoriesBelow ? 144 : 80)),
              
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              
              // Books grid/list
              booksAsync.when(
                data: (books) {
                  if (books.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book_rounded, size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text('No books found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    );
                  }
                  
                  if (viewMode == ViewMode.grid) {
                    return SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailScreen(book: books[index]))),
                            child: AdvancedBookCard(book: books[index]),
                          ),
                          childCount: books.length,
                        ),
                      ),
                    );
                  } else {
                    return SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailScreen(book: books[index]))),
                              child: AdvancedBookListItem(book: books[index]),
                            ),
                          ),
                          childCount: books.length,
                        ),
                      ),
                    );
                  }
                },
                loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator(strokeWidth: 3, color: Color(0xFF667EEA)))),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline_rounded, size: 80, color: Colors.red[300]),
                        const SizedBox(height: 16),
                        const Text('Something went wrong', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => ref.refresh(currentBooksProvider),
                          icon: const Icon(Icons.refresh_rounded, size: 20),
                          label: const Text('Retry', style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF667EEA),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
          
          // FIXED HEADER - adapts based on screen width
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Top bar (logo + title + buttons)
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1a1a2e), Color(0xFF16213e)]),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      // Logo
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      // Title
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Novella', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, height: 1)),
                          SizedBox(height: 4),
                          Text('Discover great books', style: TextStyle(fontSize: 13, color: Color(0xFFB0B0B0), height: 1)),
                        ],
                      ),
                      const Spacer(),
                      // Toggle buttons
                      _buildCompactToggle(viewMode),
                    ],
                  ),
                ),
                
                // Categories - shown below when screen < 900px
                if (categoriesBelow)
                  Container(
                    height: 64,
                    color: const Color(0xFF16213e),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => _buildCategoryChip(categories[index], selectedCategory),
                    ),
                  ),
              ],
            ),
          ),
          
          // Categories on right side when screen >= 900px
          if (!categoriesBelow)
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Container(
                height: 64,
                color: Colors.white,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => _buildCategoryChip(categories[index], selectedCategory),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(Map<String, dynamic> cat, String selectedCategory) {
    final isSelected = selectedCategory == cat['query'];
    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryProvider.notifier).state = cat['query'] as String;
        HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          gradient: isSelected ? LinearGradient(colors: cat['gradient'] as List<Color>) : null,
          color: isSelected ? null : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFE0E0E0), width: 1.5),
          boxShadow: isSelected ? [BoxShadow(color: (cat['gradient'] as List<Color>)[0].withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(cat['icon'] as IconData, color: isSelected ? Colors.white : const Color(0xFF424242), size: 18),
            const SizedBox(width: 8),
            Text(cat['name'] as String, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactToggle(ViewMode viewMode) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCompactButton(
            icon: Icons.grid_view_rounded,
            isSelected: viewMode == ViewMode.grid,
            onTap: () {
              setState(() => ref.read(viewModeProvider.notifier).state = ViewMode.grid);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(children: [Icon(Icons.grid_view_rounded, color: Colors.white, size: 18), SizedBox(width: 10), Text('Grid View')]),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
          _buildCompactButton(
            icon: Icons.view_list_rounded,
            isSelected: viewMode == ViewMode.list,
            onTap: () {
              setState(() => ref.read(viewModeProvider.notifier).state = ViewMode.list);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(children: [Icon(Icons.view_list_rounded, color: Colors.white, size: 18), SizedBox(width: 10), Text('List View')]),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompactButton({required IconData icon, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: isSelected ? const Color(0xFF1a1a2e) : Colors.white70, size: 18),
      ),
    );
  }
}
