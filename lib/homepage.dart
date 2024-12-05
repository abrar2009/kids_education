import 'dart:developer';
import 'package:flutter/material.dart';
import 'country_wise_stories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCountry;
  String selectedBackgroundImage = 'assets/images/image 27.png';
  String selectedBoyImage = 'assets/images/boy.png';
  String? selectedTopImage;
  bool _animateBoxLeft = false; // Flag to track animation
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> countryList = [
    {
      'name': 'India',
      'image': 'assets/images/india.png',
      'bgImage': 'assets/images/indiaBG.png',
      'boyImage': 'assets/images/ladyInSaree.gif',
      'topImage': 'assets/images/indiaCloud.png',
    },
    {
      'name': 'USA',
      'image': 'assets/images/usa.png',
      'bgImage': 'assets/images/usaBG.png',
      'boyImage': 'assets/images/usaGirl.png',
      'topImage': 'assets/images/usaCloud.png',
    },
    {
      'name': 'Russia',
      'image': 'assets/images/russia.png',
      'bgImage': 'assets/images/russiaBG.png',
      'boyImage': 'assets/images/russiaGirl.gif',
      'topImage': 'assets/images/russiaCloud.png',
    },
    {
      'name': 'Japan',
      'image': 'assets/images/japan.png',
      'bgImage': 'assets/images/japanBG.png',
      'boyImage': 'assets/images/japanGirl.gif',
      'topImage': 'assets/images/japanTopImage.png',
    },
    {
      'name': 'United Kingdom',
      'image': 'assets/images/uk.png',
      'bgImage': 'assets/images/ukBG.png',
      'boyImage': 'assets/images/ukBoy.gif',
      'topImage': 'assets/images/ukTopImage.png',
    },
    {
      'name': 'Italy',
      'image': 'assets/images/italy.png',
      'bgImage': 'assets/images/italyBG.png',
      'boyImage': 'assets/images/italyBoy.gif',
      'topImage': 'assets/images/italyTopImage.png',
    },
    {
      'name': 'Kenya',
      'image': 'assets/images/kenya.png',
      'bgImage': 'assets/images/kenyaBG.png',
      'boyImage': 'assets/images/kenyaBoy.gif',
      'topImage': 'assets/images/kenyaTopImage.png',
    },
    {
      'name': 'Brazil',
      'image': 'assets/images/brazil.png',
      'bgImage': 'assets/images/brazilBG.png',
      'boyImage': 'assets/images/brazilBoy.gif',
      'topImage': 'assets/images/brazilTopImage.png',
    },
    {
      'name': 'China',
      'image': 'assets/images/china.png',
      'bgImage': 'assets/images/chinaBG.png',
      'boyImage': 'assets/images/chinaGirl.gif',
      'topImage': 'assets/images/chinaTopImage.png',
    },
  ];

  List<Map<String, String>> filteredCountries = [];
  @override
  void initState() {
    super.initState();
    filteredCountries = List.from(countryList);
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    String searchQuery = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries = countryList
          .where((country) => country['name']!.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Home Page height: ${MediaQuery.of(context).size.height}');
    log('Home Page width: ${MediaQuery.of(context).size.width}');
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image that changes according to selected country
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  selectedBackgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Dynamic Topcloud Image that appears when a country is selected
          if (selectedTopImage != null) ...[
            LayoutBuilder(
              builder: (context, constraints) {
                double alignmentX;
                double alignmentY;
                double imageWidthFactor;
                double imageHeightFactor;

                // Determine alignmentY based on height
                if (constraints.maxHeight >= 1000) {
                  alignmentY = 0.2;
                } else if (constraints.maxHeight >= 750) {
                  alignmentY = -0.5;
                } else if (constraints.maxHeight < 1000) {
                  // For mobile devices
                  alignmentY = -0.85;
                } else {
                  alignmentY = 0; // Default case
                }

                // Determine alignmentX and size factors based on width
                if (constraints.maxWidth <= 2560) {
                  alignmentX = 0.3;
                  imageWidthFactor = 0.3;
                  imageHeightFactor = 0.5;
                } else if (constraints.maxWidth <= 1600) {
                  alignmentX = 0.2;
                  imageWidthFactor = 0.4;
                  imageHeightFactor = 0.6;
                } else if (constraints.maxWidth >= 1000 && constraints.maxWidth <= 1500) {
                  alignmentX = 0.4;
                  imageWidthFactor = 0.35;
                  imageHeightFactor = 0.45;
                } else if (constraints.maxWidth > 320 && constraints.maxWidth < 1000) {
                  // For mobile devices
                  alignmentX = 2.2;
                  imageWidthFactor = 0.2;
                  imageHeightFactor = 0.1;
                } else {
                  alignmentX = 0.0; // Default case for other resolutions
                  imageWidthFactor = 0.3;
                  imageHeightFactor = 0.5;
                }

                return Align(
                  alignment: Alignment(alignmentX, alignmentY),
                  child: SizedBox(
                    width: constraints.maxWidth * imageWidthFactor,
                    child: Image.asset(
                      selectedTopImage!,
                      height: constraints.maxHeight * imageHeightFactor,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ],
          // Dynamic Boy Image
          LayoutBuilder(
            builder: (context, constraints) {
              double alignmentX;
              double alignmentY;
              double imageWidth;
              double imageHeight;

              // Handle specific screen resolutions
              if (constraints.maxWidth == 2560 && constraints.maxHeight == 1600) {
                // For 2560x1600 resolution
                alignmentX = 0.8; // Adjust based on design
                alignmentY = 0.9; // Adjust based on design
                imageWidth = 600;
                imageHeight = 400;
              } else if (constraints.maxWidth == 1600 && constraints.maxHeight == 2560) {
                // For 1600x2560 resolution
                alignmentX = 0.7;
                alignmentY = 0.9;
                imageWidth = 600;
                imageHeight = 400;
              } else if (constraints.maxWidth > 1000 && constraints.maxWidth < 1500) {
                // For iPads or similar-sized devices
                alignmentX = 0.9;
                alignmentY = 0.9;
                imageWidth = 600;
                imageHeight = 400;
              } else if (constraints.maxWidth >= 350 && constraints.maxWidth <= 1000) {
                // For mobile devices
                alignmentX = 0.9;
                alignmentY = 1.1;
                imageWidth = 350;
                imageHeight = 280;
              } else {
                // Default case for other resolutions
                alignmentX = 2;
                alignmentY = 0.9;
                imageWidth = 600;
                imageHeight = 400;
              }

              return Align(
                alignment: Alignment(alignmentX, alignmentY),
                child: SizedBox(
                  width: imageWidth,
                  child: /*Image.asset(
                    selectedBoyImage,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),*/
                  Image.asset(
                    selectedBoyImage,
                    height: selectedBoyImage == 'assets/images/boy.png'
                        ? (screenWidth < 1000 ? 320 : 550)
                        : imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          // Animated white box(side drawer) with rounded right corners
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500), // Duration of animation
            left: _animateBoxLeft
                ? -MediaQuery.of(context).size.width * 0.45 // Move left when transitioning
                : 0, // Default position
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth < 1000 ? 20 : 50),
                    child: Center(
                      child: Text(
                        'Select a Country',
                        style: TextStyle(
                          fontSize: screenWidth < 1000 ? 20 : 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: screenWidth < 1000 ? 20 : 30),
                    child: Container(
                      height: screenWidth < 1000 ? 45 : 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Country',hintStyle: TextStyle(
                          fontSize: screenWidth < 1000 ? 20 : 24
                        ),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // List of Countries with Name and Image
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50, right: screenWidth < 1000 ? 20 : 30),
                      child: ListView(
                        children: filteredCountries.map((country) {
                          return countryListItem(
                            country['name']!,
                            country['image']!,
                                () => onCountrySelected(
                              country['name']!,
                              country['bgImage']!,
                              country['boyImage']!,
                              country['topImage']!,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Next button Image on the extreme right that appears when a country is selected
          if (selectedCountry != null) ...[
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _animateBoxLeft = true; // Start the animation when navigating
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => CountryWiseStoriesWidget(
                          countryName: selectedCountry!,
                          backgroundImage: selectedBackgroundImage,
                          characterImage: selectedBoyImage,
                        ),
                        transitionDuration: const Duration(milliseconds: 800),
                        transitionsBuilder: (_, anim, __, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          );
                        },
                      ),
                    ).then((_) {
                      setState(() {
                        _animateBoxLeft = false; // Reset animation when coming back
                      });
                    });
                  });
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double imageSize;

                      // Set the image size based on the screen width
                      if (constraints.maxWidth >= 1000) {
                        // For tablets and iPads
                        imageSize = 100; // Larger size
                      } else if (constraints.maxWidth >= 350) {
                        // For medium screens (e.g., larger phones)
                        imageSize = 60;
                      } else {
                        // For small screens (e.g., phones)
                        imageSize = 60;
                      }

                      return Image.asset(
                        'assets/images/next_btn.png',
                        width: imageSize,
                        height: imageSize,
                      );
                    },
                  ),
                ),
                /*Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/next_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),*/
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Handle country selection and update the background and boy image
  void onCountrySelected(String country, String backgroundImage,
      String boyImage, String topImage) {
    setState(() {
      selectedCountry = country;
      selectedBackgroundImage = backgroundImage; // Update the background image based on selection
      selectedBoyImage = boyImage; // Update the boy image based on selection
      selectedTopImage = topImage; // Update the top image based on selection
    });
  }

  // List Item with country name and image
  Widget countryListItem(String countryName, String assetPath, VoidCallback? onTap) {
    final bool isSelected = selectedCountry == countryName;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white,
            border: Border.all(
                color: isSelected ? Colors.black12 : Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12, top: 12),
            child: Row(
              children: [
                // Country Flag
                Image.asset(
                  assetPath,
                  height: screenWidth < 1000 ? 35 : 70,
                  width: screenWidth < 1000 ? 35 : 70,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 60),
                // Country Name
                Text(
                  countryName,
                  style: TextStyle(
                    fontSize: screenWidth < 1000 ? 20 : 35,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.black54,
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
