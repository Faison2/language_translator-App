import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});

  @override
  State<TranslatorHomePage> createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late AnimationController _floatingController;
  late List<Animation<double>> _cardAnimations;
  late Animation<double> _headerAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatingAnimation;

  // Enhanced category data with modern design
  final List<CategoryItem> _categories = [
    CategoryItem(
      title: 'NUMBERS',
      icon: Icons.looks_one_rounded,
      color: const Color(0xFFccb4ff),
      secondaryColor: const Color(0xFFa892ff),
      gradient: const LinearGradient(
        colors: [Color(0xFFccb4ff), Color(0xFFa892ff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '🔢',
    ),
    CategoryItem(
      title: 'FAMILY',
      icon: Icons.family_restroom_rounded,
      color: const Color(0xFFa892ff),
      secondaryColor: const Color(0xFF8a75d9),
      gradient: const LinearGradient(
        colors: [Color(0xFFa892ff), Color(0xFF8a75d9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '👨‍👩‍👧‍👦',
    ),
    CategoryItem(
      title: 'COLOURS',
      icon: Icons.palette_rounded,
      color: const Color(0xFFe8d5ff),
      secondaryColor: const Color(0xFFd0b8ff),
      gradient: const LinearGradient(
        colors: [Color(0xFFe8d5ff), Color(0xFFd0b8ff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '🎨',
    ),
    CategoryItem(
      title: 'NOUNS',
      icon: Icons.mic_rounded,
      color: const Color(0xFFf1e9fb),
      secondaryColor: const Color(0xFFe2d5f7),
      gradient: const LinearGradient(
        colors: [Color(0xFFf1e9fb), Color(0xFFe2d5f7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '📝',
    ),
    CategoryItem(
      title: 'VERBS',
      icon: Icons.pan_tool_rounded,
      color: const Color(0xFFf8f6ff),
      secondaryColor: const Color(0xFFe8e2ff),
      gradient: const LinearGradient(
        colors: [Color(0xFFf8f6ff), Color(0xFFe8e2ff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '⚡',
    ),
    CategoryItem(
      title: 'PHRASES',
      icon: Icons.headset_mic_rounded,
      color: const Color(0xFFd0b8ff),
      secondaryColor: const Color(0xFFb89eff),
      gradient: const LinearGradient(
        colors: [Color(0xFFd0b8ff), Color(0xFFb89eff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '💬',
    ),
    CategoryItem(
      title: 'ANIMALS',
      icon: Icons.pets_rounded,
      color: const Color(0xFFb89eff),
      secondaryColor: const Color(0xFFa185e8),
      gradient: const LinearGradient(
        colors: [Color(0xFFb89eff), Color(0xFFa185e8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '🐾',
    ),
    CategoryItem(
      title: 'DATES',
      icon: Icons.calendar_today_rounded,
      color: const Color(0xFF8a75d9),
      secondaryColor: const Color(0xFF7260b8),
      gradient: const LinearGradient(
        colors: [Color(0xFF8a75d9), Color(0xFF7260b8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      emoji: '📅',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _headerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_floatingController);

    _cardAnimations = List.generate(
      _categories.length,
          (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.2 + (index * 0.1),
            0.8 + (index * 0.1),
            curve: Curves.elasticOut,
          ),
        ),
      ),
    );

    _animationController.forward();
    _pulseController.repeat(reverse: true);
    _floatingController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf8f6ff),
              Color(0xFFf1e9fb),
              Color(0xFFe8d5ff),
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Floating background elements
            ...List.generate(6, (index) => _buildFloatingElement(index)),

            SafeArea(
              child: Column(
                children: [
                  _buildModernHeader(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFccb4ff),
                            blurRadius: 30,
                            spreadRadius: -10,
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        child: Column(
                          children: [
                            _buildWelcomeSection(),
                            Expanded(child: _buildCategoryGrid()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingElement(int index) {
    final colors = [
      const Color(0xFFccb4ff),
      const Color(0xFFa892ff),
      const Color(0xFFe8d5ff),
    ];
    final sizes = [15.0, 25.0, 20.0, 18.0, 12.0, 22.0];
    final positions = [
      const Offset(50, 100),
      const Offset(300, 150),
      const Offset(80, 250),
      const Offset(250, 80),
      const Offset(350, 300),
      const Offset(30, 350),
    ];

    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        // Ensure positions are within screen bounds
        double x = (positions[index].dx + (20 * math.sin(_floatingAnimation.value * 2 * math.pi + index))).clamp(0, screenWidth - sizes[index]);
        double y = (positions[index].dy + (15 * math.cos(_floatingAnimation.value * 2 * math.pi + index))).clamp(0, screenHeight - sizes[index]);

        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: sizes[index],
            height: sizes[index],
            decoration: BoxDecoration(
              color: colors[index % colors.length].withOpacity(0.6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors[index % colors.length].withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernHeader() {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - _headerAnimation.value)),
          child: Opacity(
            opacity: _headerAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Row(
                children: [
                  // Modern menu button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFccb4ff), Color(0xFFa892ff)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFccb4ff).withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.apps_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Learn SADC Languages',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4a4a4a),
                            letterSpacing: 0.1,
                          ),
                        ),
                        Text(
                          'Break Southern Africa Language Barriers',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF858585),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile/Settings button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFccb4ff).withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFFa892ff),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a Category',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4a4a4a),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your language journey',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFccb4ff), Color(0xFFa892ff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '🚀',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _cardAnimations[index],
            builder: (context, child) {
              return Transform.scale(
                scale: _cardAnimations[index].value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    80 * (1 - _cardAnimations[index].value),
                  ),
                  child: Opacity(
                    opacity: _cardAnimations[index].value,
                    child: _buildModernCategoryCard(_categories[index], index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildModernCategoryCard(CategoryItem category, int index) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _onCategoryTap(category);
      },
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: index % 2 == 0 ? _pulseAnimation.value : 1.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: category.gradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: category.color.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: -2,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 10,
                    offset: const Offset(-5, -5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _onCategoryTap(category);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Emoji icon with glassmorphism effect
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              category.emoji,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Title with modern typography
                        Text(
                          category.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.8,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        // Subtle progress indicator
                        Container(
                          height: 3,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onCategoryTap(CategoryItem category) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CategoryTranslatorPage(category: category),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final IconData icon;
  final Color color;
  final Color secondaryColor;
  final Gradient gradient;
  final String emoji;

  CategoryItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.secondaryColor,
    required this.gradient,
    required this.emoji,
  });
}

class CategoryTranslatorPage extends StatefulWidget {
  final CategoryItem category;

  const CategoryTranslatorPage({
    super.key,
    required this.category,
  });

  @override
  State<CategoryTranslatorPage> createState() => _CategoryTranslatorPageState();
}

class _CategoryTranslatorPageState extends State<CategoryTranslatorPage>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String _sourceLanguage = 'English';
 // String _targetLanguage = 'Shona';
  String _translatedText = '';
  bool _isLoading = false;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  final List<String> _languages = ['English', 'Nyanja', 'Shona', 'Ndebele'];

  //final Map<String, String> _flags = {
  //   'English': '🇬🇧',
  //   'Nyanja': '🇲🇼',
  //   'Shona': '🇿🇼',
  //   'Ndebele': '🇿🇼',
  // };

  final Map<String, Map<String, Map<String, String>>> _categoryTranslations = {
    'NUMBERS': {
      'English': {
        'one': 'motsi (Shona) / chimodzi (Nyanja) / nye (Ndebele)',
        'two': 'vhiri (Shona) / ziwiri (Nyanja) / zimbili (Ndebele)',
        'three': 'vitatu (Shona) / zitatu (Nyanja) / zintathu (Ndebele)',
        '1': 'motsi (Shona) / chimodzi (Nyanja) / nye (Ndebele)',
        '2': 'vhiri (Shona) / ziwiri (Nyanja) / zimbili (Ndebele)',
        '3': 'vitatu (Shona) / zitatu (Nyanja) / zintathu (Ndebele)',
      }
    },
    'FAMILY': {
      'English': {
        'mother': 'amai (Shona) / amayi (Nyanja) / umama (Ndebele)',
        'father': 'baba (Shona) / bambo (Nyanja) / ubaba (Ndebele)',
        'child': 'mwana (Shona) / mwana (Nyanja) / umntwana (Ndebele)',
        'sister': 'hanzvadzi (Shona) / mlongo (Nyanja) / udadewethu (Ndebele)',
        'brother': 'mukoma (Shona) / mchimwene (Nyanja) / umfowethu (Ndebele)',
      }
    },
    'COLOURS': {
      'English': {
        'red': 'tsvuku (Shona) / wofiira (Nyanja) / ubomvu (Ndebele)',
        'blue': 'bhuruu (Shona) / wabuluu (Nyanja) / oluhlaza okwesibhakabhaka (Ndebele)',
        'green': 'girini (Shona) / wobiriwira (Nyanja) / oluhlaza (Ndebele)',
        'yellow': 'yero (Shona) / wachikasu (Nyanja) / ophuzi (Ndebele)',
      }
    },
    'ANIMALS': {
      'English': {
        'dog': 'imbwa (Shona) / galu (Nyanja) / inja (Ndebele)',
        'cat': 'katsi (Shona) / mphaka (Nyanja) / ikati (Ndebele)',
        'cow': 'mombe (Shona) / ng\'ombe (Nyanja) / inkomo (Ndebele)',
        'chicken': 'huku (Shona) / nkhuku (Nyanja) / inkukhu (Ndebele)',
      }
    },
  };

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    _slideController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.category.gradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xFF4a4a4a),
                          size: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.category.emoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.category.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Translator',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.bookmark_rounded,
                        color: Color(0xFF4a4a4a),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Main content
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          // Input section
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.category.color.withOpacity(0.1),
                                  widget.category.secondaryColor.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: widget.category.color.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _controller,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF4a4a4a),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter ${widget.category.title.toLowerCase()} to translate...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Translate button
                                GestureDetector(
                                  onTap: _translate,
                                  child: Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      gradient: widget.category.gradient,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: widget.category.color.withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: _isLoading
                                          ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          strokeWidth: 2,
                                        ),
                                      )
                                          : const Text(
                                        'Translate',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Result section
                          if (_translatedText.isNotEmpty)
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  gradient: widget.category.gradient,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.category.color.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.translate_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Translation:',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        _translatedText,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Copy button
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: _translatedText));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Translation copied to clipboard!'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.copy_rounded,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Copy',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          // Sample words section when no translation is shown
                          if (_translatedText.isEmpty)
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Try these ${widget.category.title.toLowerCase()}:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Expanded(
                                      child: ListView(
                                        children: _getSampleWords().map((word) {
                                          return Container(
                                            margin: const EdgeInsets.only(bottom: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                _controller.text = word;
                                                _translate();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      widget.category.color.withOpacity(0.1),
                                                      widget.category.secondaryColor.withOpacity(0.05),
                                                    ],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: widget.category.color.withOpacity(0.2),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        color: widget.category.color,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      word,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey[700],
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios_rounded,
                                                      size: 14,
                                                      color: widget.category.color,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getSampleWords() {
    final categoryData = _categoryTranslations[widget.category.title];
    if (categoryData != null && categoryData[_sourceLanguage] != null) {
      return categoryData[_sourceLanguage]!.keys.toList();
    }
    return [];
  }

  void _translate() {
    final input = _controller.text.trim().toLowerCase();
    if (input.isEmpty) return;

    setState(() => _isLoading = true);

    // Simulate translation with category-specific data
    final categoryData = _categoryTranslations[widget.category.title];
    final translations = categoryData?[_sourceLanguage];

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          if (translations != null && translations.containsKey(input)) {
            _translatedText = translations[input]!;
          } else {
            _translatedText = 'Translation not available for "$input" in ${widget.category.title}.\n\nTry one of the suggested words below.';
          }
          _isLoading = false;
        });
      }
    });
  }
}