import 'package:flutter/material.dart';
import 'Backend/country_data.dart';
import 'homepage.dart';

class CountryWiseStoriesWidget extends StatefulWidget {
  final String countryName;
  final String backgroundImage;
  final String characterImage;

  const CountryWiseStoriesWidget({
    super.key,
    required this.countryName,
    required this.backgroundImage,
    required this.characterImage,
  });

  @override
  State<CountryWiseStoriesWidget> createState() => _CountryWiseStoriesWidgetState();
}

class _CountryWiseStoriesWidgetState extends State<CountryWiseStoriesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isAnimating = false;

  // Sample data for demonstration


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  String wrapText(String text) {
    List<String> words = text.split(' ');
    //int wordsPerLine = 6; // default is 4 words per line
    int wordsPerLine = words.length >= 20 ? 6 : 5;
    List<String> lines = [];

    // If the sentence has exactly 4 words, put the first 3 words on the first line and the last word on the second line
    if (words.length == 4 || words.length == 5) {
      lines.add(words.sublist(0, 3).join(' ')); // First 3 words in the first line
      lines.add(words.sublist(3).join(' '));    // Remaining word in the second line
    } else {
      // For other cases, group words with at least 4 per line
      for (int i = 0; i < words.length; i += wordsPerLine) {
        int end = (i + wordsPerLine < words.length) ? i + wordsPerLine : words.length;
        lines.add(words.sublist(i, end).join(' '));
      }
    }

    return lines.join('\n'); // Join lines with line breaks
  }


  // Function to measure the text size for a given text style and max width
  Size _measureText(String text, TextStyle style, {double maxWidth = double.infinity}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: null, // Allow multiple lines
    )..layout(maxWidth: maxWidth);

    return Size(textPainter.width, textPainter.height);
  }

  Alignment _parseAlignment(String alignmentString) {
    final parts = alignmentString.split(',');
    if (parts.length == 2) {
      final x = double.tryParse(parts[0]) ?? 0.0;
      final y = double.tryParse(parts[1]) ?? 0.0;
      return Alignment(x, y);
    }
    return Alignment.center; // Default alignment
  }

  @override
  Widget build(BuildContext context) {
    // Fetch content based on the selected country
    List<Map<String, String>> currentCountryContent = countryContent[widget.countryName] ?? [];

    double selectedImageHeight = widget.countryName.toLowerCase() == '' ? 280 : 400;

    String wrappedText = wrapText(currentCountryContent[_currentPage]['cloudText']!);

    // Measure the wrapped text size for the current page
    final cloudTextSize = _measureText(
      wrappedText,
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      maxWidth: MediaQuery.of(context).size.width * 0.3,
    );

    // Adjust the cloud size based on text size and number of lines
    int numOfLines = wrappedText.split('\n').length;
    double cloudWidth = cloudTextSize.width + 120;
    //double cloudHeight = cloudTextSize.height + 180;
    double cloudHeight = cloudTextSize.height + (numOfLines * 30) + 100;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              // Dynamic Background Image
              Image.asset(
                currentCountryContent[_currentPage]['backgroundImage']!,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.968,
                fit: BoxFit.cover,
              ),
              // PageView for dynamic content
              PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: currentCountryContent.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Cloud Text
                      Align(
                        //alignment: AlignmentDirectional(-0.11, -0.3),
                        alignment: _parseAlignment(currentCountryContent[index]['cloudAlignment']!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Cloud Image with dynamic size
                              SizedBox(
                                width: cloudWidth,
                                height: cloudHeight,
                                child: Image.asset(
                                  //'assets/images/Cloud.png',
                                  currentCountryContent[index]['cloudImage']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // Overlay Text on Cloud Image
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20, right: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  width: cloudWidth,
                                  child: Text(
                                    //currentCountryContent[index]['cloudText']!,
                                    wrappedText,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 6,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Character Image
                      // Character Image
                      Align(
                        alignment: _parseAlignment(currentCountryContent[index]['characterAlignment']!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..scale(-1.0, 1.0), // Mirror horizontally
                            child: Image.asset(
                              currentCountryContent[index]['characterImage']!,
                              height: selectedImageHeight,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      /*Align(
                        //alignment: Alignment(-0.5, 0.9),
                        alignment: _parseAlignment(currentCountryContent[index]['characterAlignment']!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            currentCountryContent[index]['characterImage']!,
                            height: selectedImageHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),*/
                    ],
                  );
                },
              ),

              // Next Button
              Positioned(
                right: 20,
                top: MediaQuery.of(context).size.height / 2,
                child: GestureDetector(
                  onTap: () {
                    if (_currentPage < currentCountryContent.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/images/next_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),

              // Previous Button
              if (_currentPage > 0)
              Positioned(
                left: 20,
                top: MediaQuery.of(context).size.height / 2,
                child: GestureDetector(
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/images/previous_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),

              // Back Button to Home Page
              Align(
                alignment: const AlignmentDirectional(-0.99, -0.9),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      SlideFromLeftPageRoute(
                        page: const HomePage(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/images/bonus_btn.png',
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      fit: BoxFit.contain,
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

// Custom route for the animation
class SlideFromLeftPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideFromLeftPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Start from the left of the screen
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      // Apply the animation
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: _buildWhiteBox(child),
      );
    },
  );

  // Build the white box with rounded corners on the right side
  static Widget _buildWhiteBox(Widget child) {
    return Container(
      color: Colors.white,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: child,
      ),
    );
  }
}