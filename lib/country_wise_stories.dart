import 'package:bounce/bounce.dart';
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
  State<CountryWiseStoriesWidget> createState() =>
      _CountryWiseStoriesWidgetState();
}

class _CountryWiseStoriesWidgetState extends State<CountryWiseStoriesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isAnimating = false;
  int words_per_line = 0;
  int numberOfLines = 0;

  // Sample data for demonstration

  @override
  void initState() {
    print('country');
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String wrapText(String text) {
    List<String> words = text.split(' ');
    //int wordsPerLine = 4; // default is 4 words per line
    int wordsPerLine = words.length >= 20 ? 6 : 4;
    words_per_line = wordsPerLine;
    List<String> lines = [];

    // If the sentence has exactly 4 words, put the first 3 words on the first line and the last word on the second line
    if (words.length == 4 || words.length == 5) {
      lines.add(words.sublist(0, 3).join(' ')); // First 3 words in the first line
      lines.add(words.sublist(3).join(' ')); // Remaining word in the second line
    } else {
      // For other cases, group words with at least 4 per line
      for (int i = 0; i < words.length; i += wordsPerLine) {
        int end =
        (i + wordsPerLine < words.length) ? i + wordsPerLine : words.length;
        lines.add(words.sublist(i, end).join(' '));
      }
    }

    numberOfLines = lines.length;
    return lines.join('\n'); // Join lines with line breaks
  }

  // Function to measure the text size for a given text style and max width
  Size _measureText(String text, TextStyle style,
      {double maxWidth = double.infinity}) {
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

  // Function to get responsive cloud image size based on screen width
  double getResponsiveCloudImageSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      // Mobile
      return 180.0; // Smaller cloud image
    } else if (screenWidth <= 1200) {
      // Tablet
      return 230.0; // Medium cloud image
    } else {
      // iPad or larger
      return 280.0; // Larger cloud image
    }
  }

  @override
  Widget build(BuildContext context) {
      // Fetch content based on the selected country
      List<Map<String, String>> currentCountryContent = countryContent[widget.countryName] ?? [];
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      double selectedImageHeight =
      widget.countryName.toLowerCase() == '' ? 420 : 420;

      String wrappedText = wrapText(currentCountryContent[_currentPage]['cloudText']!);

      // Measure the wrapped text size for the current page
      final cloudTextSize = _measureText(
        wrappedText,
        TextStyle(fontSize: screenWidth < 1000 ? 18 : 20, fontWeight: FontWeight.w400),
        maxWidth: MediaQuery.of(context).size.width * 0.3,
      );

      /*final cloudTextSize = _measureText(
        wrappedText,
        TextStyle(
          fontSize: screenWidth < 1000 ? 16 : 20,
          fontWeight: FontWeight.w400,
        ),

        maxWidth: (numberOfLines > 3 && words_per_line == 5)
            ? MediaQuery.of(context).size.width * 0.35
            : (words_per_line <= 5
            ? MediaQuery.of(context).size.width * 0.5
            : MediaQuery.of(context).size.width * 0.3),

      );*/


      // Adjust the cloud size based on text size and number of lines
      int numOfLines = wrappedText.split('\n').length;
      //double cloudWidth = cloudTextSize.width + 260;

      // Determine screen width for responsive design

      double cloudWidth;

      // Responsive adjustments for cloud size
      if (screenWidth < 1000) {
        // Mobile
        cloudWidth = cloudTextSize.width + 100;
      } else if (screenWidth >= 1280) {
        // Tablet
        cloudWidth = cloudTextSize.width + 260;
      } else {
        // iPad or larger
        cloudWidth = cloudTextSize.width + 260;
      }

      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: [
              // Dynamic Background Image
              Image.asset(
                currentCountryContent[_currentPage]['backgroundImage']!,
                //width: MediaQuery.sizeOf(context).width * 1,
                //height: MediaQuery.sizeOf(context).height * 1,
                width: double.infinity,
                height: double.infinity,
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
                  String characterAlignmentString = currentCountryContent[_currentPage]['characterAlignment']!;
                  Alignment characterAlignment = _parseAlignment(characterAlignmentString);
                  return Stack(
                      children: [
                        Column(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Cloud with Text Overlay
                          Align(
                            alignment: Alignment(
                              screenWidth < 1000
                                  ? (characterAlignment.x == 0
                                  ? characterAlignment.x + 0.3 // If x == 0, add 0.2 when screenWidth < 1000
                                  : characterAlignment.x + 0.2) // Add 0.2 directly when screenWidth < 1000
                                  : (characterAlignment.x == 0
                                  ? characterAlignment.x + 0.3
                                  : (characterAlignment.x > 0
                                  ? characterAlignment.x - 0.1
                                  : (characterAlignment.x >= -0.1
                                  ? characterAlignment.x + 0.3
                                  : characterAlignment.x))),
                              characterAlignment.y == 0
                                  ? characterAlignment.y + 0.3
                                  : (characterAlignment.y > 0
                                  ? characterAlignment.y - 0.3
                                  : characterAlignment.y),
                            ),
                            /*Alignment(
                                        characterAlignment.x == 0
                                            ? characterAlignment.x + 0.3
                                            : (characterAlignment.x > 0
                                            ? characterAlignment.x - 0.1
                                            : (characterAlignment.x >= -0.1
                                            ? characterAlignment.x + 0.3
                                            : characterAlignment.x)),
                                        characterAlignment.y == 0
                                            ? characterAlignment.y + 0.3
                                            : (characterAlignment.y > 0
                                            ? characterAlignment.y - 0.3
                                            : characterAlignment.y),
                                      ),*/
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Cloud Image with dynamic size
                                  SizedBox(
                                    width: cloudWidth,
                                    //height: 230,
                                    child: Image.asset(
                                      currentCountryContent[index]['cloudImage']!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  // Overlay Text on Cloud Image
                                  Padding(
                                    padding: EdgeInsets.only(bottom: screenWidth > 1000 ? 35 : 25, right: 0, left: 0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      width: cloudWidth,
                                      child: Text(
                                        wrappedText,
                                        style: TextStyle(
                                          fontSize: screenWidth > 1000 ? 28 : 17,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          height: 1.1,
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
                          LayoutBuilder(
                              builder: (context, constraints){
                                // Handle specific screen resolutions
                                if (constraints.maxWidth == 2560 && constraints.maxHeight == 1600) {
                                  // For 2560x1600 resolution

                                  selectedImageHeight = 420;
                                } else if (constraints.maxWidth == 1600 && constraints.maxHeight == 2560) {
                                  // For 1600x2560 resolution
                                  selectedImageHeight = 420;
                                } else if (constraints.maxWidth > 1000 && constraints.maxWidth < 1500) {
                                  // For iPads or similar-sized devices
                                  selectedImageHeight = 420;
                                } else if (constraints.maxWidth >= 350 && constraints.maxWidth <= 1000) {
                                  // For mobile devices
                                  selectedImageHeight = 240;
                                } else {
                                  // Default case for other resolutions
                                  selectedImageHeight = 240;
                                }
                                return Align(
                                  alignment: /*Alignment(
                                      characterAlignment.x < 0
                                      ? characterAlignment.x + 0.1
                                      : characterAlignment.x,
                                      characterAlignment.y),*/

                                  Alignment(
                                    characterAlignment.x == -0.4
                                        ? characterAlignment.x
                                        : characterAlignment.x + 0.1,
                                    characterAlignment.y,
                                  ),

                                  //alignment: screenWidth >= 300 ? Alignment(characterAlignment.x + 0.1, characterAlignment.y + 1) : characterAlignment,
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
                                );
                              }
                          ),
                        ],
                      ),
                        //if(characterAlignment.x <= -0.7 || characterAlignment.x >= 0.7)
                          Align(
                            alignment: Alignment(
                              characterAlignment.x >= 0.5
                                  ? characterAlignment.x - 1.35
                                  : characterAlignment.x + 1.35,
                              characterAlignment.y + 0.18,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: currentCountryContent[index].containsKey('boardImage') &&
                                  currentCountryContent[index]['boardImage'] != null
                                  ? Image.asset(
                                currentCountryContent[index]['boardImage']!,
                                height: screenWidth < 1000 ? 290 : selectedImageHeight + 80,
                                fit: BoxFit.cover,
                              ) : Container(
                                //height: selectedImageHeight + 80,
                                height: screenWidth < 1000 ? 290 : selectedImageHeight + 80,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                      ]
                    );
                },
              ),

              // Next Button
              currentCountryContent.length - 1 == _currentPage
                  ? const SizedBox()
                  : Positioned(
                right: 20,
                top: MediaQuery.of(context).size.height / 2.2,
                child: Bounce(
                  // filterQuality:FilterQuality.high,
                  onTap: () {
                    print(_currentPage);
                    print(currentCountryContent.length);
                    if (_currentPage < currentCountryContent.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/images/next_btn.png',
                    width: screenWidth > 1000 ? 100 : 60,
                    height: screenWidth > 1000 ? 100 : 60,
                  ),
                ),
              ),

              // Previous Button
              if (_currentPage > 0)
                Positioned(
                  left: 20,
                  top: MediaQuery.of(context).size.height / 2.2,
                  child: Bounce(
                    onTap: () {
                      print(_currentPage);
                      print(currentCountryContent.length);
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                        );
                      }
                    },

                    child: Image.asset(
                      'assets/images/previous_btn.png',
                      //width: screenWidth >= 350 ? 60 : 100,
                      //height: screenWidth >= 350 ? 60 : 100,
                      width: screenWidth > 1000 ? 100 : 60,
                      height: screenWidth > 1000 ? 100 : 60,
                    ),
                  ),
                ),

              // Back Button to Home Page
              Align(
                alignment: const AlignmentDirectional(-0.99, -0.9),
                child: Bounce(
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
                      width: screenWidth >=350 ? MediaQuery.sizeOf(context).width * 0.15 : MediaQuery.sizeOf(context).width * 0.1,
                      height: screenWidth >=350 ? MediaQuery.sizeOf(context).height * 0.15 : MediaQuery.sizeOf(context).height * 0.1,
                      //height: MediaQuery.sizeOf(context).height * 0.1,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
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
      var tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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