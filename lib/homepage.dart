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

  @override
  Widget build(BuildContext context) {
    log('Home Page ${MediaQuery.of(context).size.height}');

    return Scaffold(
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
          // Dynamic Top Image that appears when a country is selected
          if (selectedTopImage != null) ...[
            /*LayoutBuilder(
              builder: (context, constraints) {
                double alignmentX;
                double alignmentY;
                double imageWidthFactor;
                double imageHeightFactor;

                // Handle specific resolutions or aspect ratios
                if (constraints.maxWidth <= 2560 && constraints.maxHeight <= 1600) {
                  // For 2560x1600 resolution
                  alignmentX = 0.3;
                  alignmentY = -0.2;
                  imageWidthFactor = 0.3;
                  imageHeightFactor = 0.5;
                } else if (constraints.maxWidth <= 1600 && constraints.maxHeight <= 2560) {
                  // For 1600x2560 resolution
                  alignmentX = 0.2;
                  alignmentY = -0.6;
                  imageWidthFactor = 0.4;
                  imageHeightFactor = 0.6;
                } else if (constraints.maxWidth >= 1000 && constraints.maxWidth <= 1500) {
                  // For iPads or similar-sized devices
                  alignmentX = 0.4;
                  alignmentY = -0.4;
                  imageWidthFactor = 0.35;
                  imageHeightFactor = 0.45;
                } else {
                  // Default case for other resolutions
                  alignmentX = 0.0;
                  alignmentY = 0.0;
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
            ),*/
            LayoutBuilder(
              builder: (context, constraints) {
                double alignmentX;
                double alignmentY;
                double imageWidthFactor;
                double imageHeightFactor;

                // Determine alignmentY based on height
                if (constraints.maxHeight >= 1000) {
                  alignmentY = 0.5;
                } else if (constraints.maxHeight >= 750) {
                  alignmentY = -0.5;
                } /*else if (constraints.maxHeight >= 750) {
                  alignmentY = -0.3;
                }*/ else {
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

            /*Align(
              alignment: const Alignment(0.4, -0.4), // Adjust alignment as needed
              child: SizedBox(
                width: 300, // Adjust width as needed
                child: Image.asset(
                  selectedTopImage!,
                  height: 400, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
            ),*/
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
                  child: Image.asset(
                    selectedBoyImage,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          /*Align(
            alignment: const Alignment(0.9, 0.9),
            child: SizedBox(
              width: 600,
              child: Image.asset(
                selectedBoyImage,
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
          ),*/
          // Animated White Box with rounded right corners
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500), // Duration of animation
            left: _animateBoxLeft
                ? -MediaQuery.of(context).size.width * 0.38 // Move left when transitioning
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
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        'Select a Country',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Container(
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
                        decoration: InputDecoration(
                          hintText: 'Search Country',
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
                  const SizedBox(height: 20),
                  // List of Countries with Name and Image
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: ListView(
                        children: [
                          countryListItem(
                            'India',
                            'assets/images/india.png',
                            () => onCountrySelected(
                                'India',
                                'assets/images/indiaBG.png',
                                'assets/images/ladyInSaree.gif',
                                'assets/images/indiaCloud.png'),
                          ),
                          countryListItem(
                            'USA',
                            'assets/images/usa.png',
                            () => onCountrySelected(
                                'USA',
                                'assets/images/usaBG.png',
                                'assets/images/usaGirl.png',
                                'assets/images/usaCloud.png'),
                          ),
                          countryListItem(
                            'Russia',
                            'assets/images/russia.png',
                            () => onCountrySelected(
                                'Russia',
                                'assets/images/russiaBG.png',
                                'assets/images/russiaGirl.gif',
                                'assets/images/russiaCloud.png'),
                          ),
                          countryListItem(
                            'Japan',
                            'assets/images/japan.png',
                            () => onCountrySelected(
                                'Japan',
                                'assets/images/japanBG.png',
                                'assets/images/japanGirl.gif',
                                'assets/images/japanTopImage.png'),
                          ),
                          countryListItem(
                            'United Kingdom',
                            'assets/images/uk.png',
                            () => onCountrySelected(
                                'United Kingdom',
                                'assets/images/ukBG.png',
                                'assets/images/ukBoy.gif',
                                'assets/images/ukTopImage.png'),
                          ),
                          countryListItem(
                            'Italy',
                            'assets/images/italy.png',
                            () => onCountrySelected(
                                'Italy',
                                'assets/images/italyBG.png',
                                'assets/images/italyBoy.gif',
                                'assets/images/italyTopImage.png'),
                          ),
                          countryListItem(
                            'Kenya',
                            'assets/images/kenya.png',
                            () => onCountrySelected(
                                'Kenya',
                                'assets/images/kenyaBG.png',
                                'assets/images/kenyaBoy.gif',
                                'assets/images/kenyaTopImage.png'),
                          ),
                          countryListItem(
                            'Brazil',
                            'assets/images/brazil.png',
                            () => onCountrySelected(
                                'Brazil',
                                'assets/images/brazilBG.png',
                                'assets/images/brazilBoy.gif',
                                'assets/images/brazilTopImage.png'),
                          ),
                          countryListItem(
                            'China',
                            'assets/images/china.png',
                            () => onCountrySelected(
                                'China',
                                'assets/images/chinaBG.png',
                                'assets/images/chinaGirl.gif',
                                'assets/images/chinaTopImage.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Image on the extreme right that appears when a country is selected
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
                  child: Image.asset(
                    'assets/images/next_btn.png',
                    width: 100,
                    height: 100,
                  ),
                ),
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

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Country Flag
                Image.asset(
                  assetPath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 40),
                // Country Name
                Text(
                  countryName,
                  style: TextStyle(
                    fontSize: 25,
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
