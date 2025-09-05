import 'package:flutter/material.dart';

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});

  @override
  State<TranslatorHomePage> createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String _sourceLanguage = 'English';
  String _targetLanguage = 'Shona';
  String _translatedText = '';
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _languages = ['English', 'Nyanja', 'Shona', 'Ndebele'];

  final Map<String, String> _flags = {
    'English': '🇬🇧',
    'Nyanja': '🇲🇼',
    'Shona': '🇿🇼',
    'Ndebele': '🇿🇼',
  };

  final Map<String, Color> _languageColors = {
    'English': const Color(0xFFccb4ff),
    'Nyanja': const Color(0xFFa892ff),
    'Shona': const Color(0xFF9575ff),
    'Ndebele': const Color(0xFFb39dff),
  };

  // Dictionaries
  final Map<String, Map<String, String>> _translations = {
    'English': {
      'hello': 'mhoro (Shona) / moni (Nyanja) / sawubona (Ndebele)',
      'goodbye': 'chisarai zvakanaka (Shona) / tsalani bwino (Nyanja) / hamba kahle (Ndebele)',
      'thank you': 'mazvita (Shona) / zikomo (Nyanja) / ngiyabonga (Ndebele)',
      'please': 'ndapota (Shona) / chonde (Nyanja) / ngiyacela (Ndebele)',
      'yes': 'hongu (Shona) / inde (Nyanja) / yebo (Ndebele)',
      'no': 'kwete (Shona) / ayi (Nyanja) / hatshi (Ndebele)',
      'water': 'mvura (Shona) / madzi (Nyanja) / amanzi (Ndebele)',
      'food': 'chikafu (Shona) / chakudya (Nyanja) / ukudla (Ndebele)',
      'love': 'rudo (Shona) / chikondi (Nyanja) / uthando (Ndebele)',
      'family': 'mhuri (Shona) / banja (Nyanja) / umuli (Ndebele)',
    },
    'Shona': {
      'mhoro': 'hello (English)',
      'chisarai zvakanaka': 'goodbye (English)',
      'mazvita': 'thank you (English)',
      'ndapota': 'please (English)',
      'hongu': 'yes (English)',
      'kwete': 'no (English)',
      'mvura': 'water (English)',
      'chikafu': 'food (English)',
      'rudo': 'love (English)',
      'mhuri': 'family (English)',
    },
    'Nyanja': {
      'moni': 'hello (English)',
      'tsalani bwino': 'goodbye (English)',
      'zikomo': 'thank you (English)',
      'chonde': 'please (English)',
      'inde': 'yes (English)',
      'ayi': 'no (English)',
      'madzi': 'water (English)',
      'chakudya': 'food (English)',
      'chikondi': 'love (English)',
      'banja': 'family (English)',
    },
    'Ndebele': {
      'sawubona': 'hello (English)',
      'hamba kahle': 'goodbye (English)',
      'ngiyabonga': 'thank you (English)',
      'ngiyacela': 'please (English)',
      'yebo': 'yes (English)',
      'hatshi': 'no (English)',
      'amanzi': 'water (English)',
      'ukudla': 'food (English)',
      'uthando': 'love (English)',
      'umuli': 'family (English)',
    },
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = temp;
      _translatedText = '';
    });
  }

  Future<void> _translate() async {
    final input = _controller.text.trim().toLowerCase();
    if (input.isEmpty) {
      setState(() => _translatedText = 'Please enter text to translate');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API delay for better UX
    await Future.delayed(const Duration(milliseconds: 500));

    final dictionary = _translations[_sourceLanguage];
    if (dictionary != null && dictionary.containsKey(input)) {
      setState(() {
        _translatedText = dictionary[input]!;
        _isLoading = false;
      });
      _animationController.forward().then((_) => _animationController.reset());
    } else {
      setState(() {
        _translatedText = 'Translation not available for "$input"';
        _isLoading = false;
      });
    }
  }

  Widget _buildLanguageCard(
      String language,
      bool isSource,
      void Function(String?) onChanged,
      ) {
    final color = _languageColors[language] ?? const Color(0xFFccb4ff);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFf1f0ff),
            const Color(0xFFf1e9fb).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<String>(
        value: language,
        isExpanded: true,
        underline: const SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down, color: color),
        items: _languages.map((String lang) {
          return DropdownMenuItem<String>(
            value: lang,
            child: Row(
              children: [
                Text(_flags[lang] ?? '', style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Text(
                  lang,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _languageColors[lang],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFf1f0ff),
              Color(0xFFf1e9fb),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      const Text(
                        '🌍 African Languages',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4a4a4a),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Translator',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF858585),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded( // Changed from Flexible to Expanded
                      child: _buildLanguageCard(
                        _sourceLanguage,
                        true,
                            (newValue) {
                          setState(() {
                            _sourceLanguage = newValue!;
                            _translatedText = '';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFf1f0ff), Color(0xFFf1e9fb)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFccb4ff).withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFccb4ff).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: _swapLanguages,
                        child: const Icon(
                          Icons.swap_horiz,
                          color: Color(0xFFccb4ff),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded( // Changed from Flexible to Expanded
                      child: _buildLanguageCard(
                        _targetLanguage,
                        false,
                            (newValue) {
                          setState(() {
                            _targetLanguage = newValue!;
                            _translatedText = '';
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Input Field
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFf1f0ff), Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFccb4ff).withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFccb4ff).withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter text to translate...',
                      hintStyle: const TextStyle(color: Color(0xFF858585)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color(0xFF858585),
                        ),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _translatedText = '');
                        },
                      )
                          : null,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),

                const SizedBox(height: 24),

                // Translate Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _translate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFccb4ff), Color(0xFFa892ff)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.translate, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Translate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Result
                if (_translatedText.isNotEmpty)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFf1e9fb).withOpacity(0.8),
                            const Color(0xFFf1f0ff).withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFccb4ff).withOpacity(0.4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFccb4ff).withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.record_voice_over,
                                color: const Color(0xFFccb4ff),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Translation:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF858585),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _translatedText,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4a4a4a),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const Spacer(),

                // Footer
                const Text(
                  'Supporting African Languages 🌟',
                  style: TextStyle(
                    color: Color(0xFF858585),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}