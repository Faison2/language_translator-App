import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:math' as math;

class LanguageSplashScreen extends StatefulWidget {
  @override
  _LanguageSplashScreenState createState() => _LanguageSplashScreenState();
}

class _LanguageSplashScreenState extends State<LanguageSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _slideAnimation = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.9, curve: Curves.easeOutBack),
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_rotationController);

    _controller.forward();
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf8f6ff),
              Color(0xFFf1e9fb),
              Color(0xFFe8d5ff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40), // Reduced from 60

              // Enhanced Image Display Section
              Expanded(
                flex: 3,
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Rotating background circles
                              AnimatedBuilder(
                                animation: _rotationAnimation,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _rotationAnimation.value * 2 * 3.14159,
                                    child: Container(
                                      width: 350, // Reduced from 380
                                      height: 350, // Reduced from 380
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFccb4ff).withOpacity(0.2),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Second rotating circle (opposite direction)
                              AnimatedBuilder(
                                animation: _rotationAnimation,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: -_rotationAnimation.value * 1.5 * 3.14159,
                                    child: Container(
                                      width: 380, // Reduced from 420
                                      height: 380, // Reduced from 420
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFa892ff).withOpacity(0.15),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Glowing background circles
                              Container(
                                width: 360, // Reduced from 400
                                height: 360, // Reduced from 400
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFFccb4ff).withOpacity(0.1),
                                      const Color(0xFFf1e9fb).withOpacity(0.05),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.7, 1.0],
                                  ),
                                ),
                              ),

                              Container(
                                width: 320, // Reduced from 350
                                height: 320, // Reduced from 350
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFFa892ff).withOpacity(0.15),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),

                              // Main image container with pulse effect
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Container(
                                      width: 300, // Reduced from 320
                                      height: 300, // Reduced from 320
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFffffff),
                                            Color(0xFFf8f6ff),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFccb4ff).withOpacity(0.3),
                                            blurRadius: 30,
                                            spreadRadius: 5,
                                            offset: const Offset(0, 10),
                                          ),
                                          BoxShadow(
                                            color: const Color(0xFFa892ff).withOpacity(0.2),
                                            blurRadius: 50,
                                            spreadRadius: -5,
                                            offset: const Offset(0, 20),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(20), // Reduced from 25
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFf1e9fb),
                                              Color(0xFFe8d5ff),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(0.8),
                                              blurRadius: 10,
                                              offset: const Offset(-5, -5),
                                            ),
                                            BoxShadow(
                                              color: const Color(0xFFccb4ff).withOpacity(0.3),
                                              blurRadius: 10,
                                              offset: const Offset(5, 5),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            "assets/v1.jpg",
                                            width: 250, // Reduced from 270
                                            height: 250, // Reduced from 270
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Decorative floating elements
                              Positioned(
                                top: 25, // Adjusted position
                                right: 40, // Adjusted position
                                child: AnimatedBuilder(
                                  animation: _rotationAnimation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(
                                        10 * math.sin(_rotationAnimation.value * 2 * 3.14159),
                                        10 * math.cos(_rotationAnimation.value * 2 * 3.14159),
                                      ),
                                      child: Container(
                                        width: 10, // Reduced from 12
                                        height: 10, // Reduced from 12
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFccb4ff).withOpacity(0.6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFccb4ff).withOpacity(0.3),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Positioned(
                                bottom: 40, // Adjusted position
                                left: 30, // Adjusted position
                                child: AnimatedBuilder(
                                  animation: _rotationAnimation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(
                                        15 * math.cos(_rotationAnimation.value * 1.5 * 3.14159),
                                        15 * math.sin(_rotationAnimation.value * 1.5 * 3.14159),
                                      ),
                                      child: Container(
                                        width: 7, // Reduced from 8
                                        height: 7, // Reduced from 8
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFa892ff).withOpacity(0.7),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFa892ff).withOpacity(0.4),
                                              blurRadius: 6,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Section
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25), // Reduced padding
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFccb4ff),
                          Color(0xFFf1e9fb),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Column(
                              children: [
                                const Text(
                                  "Let's Break",
                                  style: TextStyle(
                                    color: Color(0xFF858585),
                                    fontSize: 18, // Reduced from 20
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8), // Reduced from 12
                                const Text(
                                  "THE BARRIERS OF\nLANGUAGE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF4a4a4a),
                                    fontSize: 26, // Reduced from 30
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    letterSpacing: 1.2, // Reduced from 1.5
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25), // Reduced from 40

                          // Enhanced button
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TranslatorHomePage(),
                                ),
                              );
                            },
                            child: AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value * 0.95 + 0.05,
                                  child: Container(
                                    width: 70, // Reduced from 80
                                    height: 70, // Reduced from 80
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFccb4ff),
                                          Color(0xFFa892ff),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFccb4ff).withOpacity(0.4),
                                          blurRadius: 15, // Reduced from 20
                                          spreadRadius: 2,
                                          offset: const Offset(0, 6), // Reduced from 8
                                        ),
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.7),
                                          blurRadius: 8, // Reduced from 10
                                          offset: const Offset(-3, -3),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30, // Reduced from 35
                                    ),
                                  ),
                                );
                              },
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
}