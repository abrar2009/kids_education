import 'package:flutter/material.dart';

class CountrySelectionWidget extends StatefulWidget {
  final Function(String, String, String, String) onCountrySelected;
  final bool animateBoxLeft;
  final VoidCallback onAnimationComplete;

  const CountrySelectionWidget({
    Key? key,
    required this.onCountrySelected,
    required this.animateBoxLeft,
    required this.onAnimationComplete,
  }) : super(key: key);

  @override
  _CountrySelectionWidgetState createState() => _CountrySelectionWidgetState();
}

class _CountrySelectionWidgetState extends State<CountrySelectionWidget> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: widget.animateBoxLeft
          ? -MediaQuery.of(context).size.width * 0.38 // Move left when transitioning
          : 0, // Default position
      top: 0,
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.38,
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
                          () => selectCountry(
                        'India',
                        'assets/images/indiaBG.png',
                        'assets/images/indiaGirl.png',
                        'assets/images/indiaCloud.png',
                      ),
                    ),
                    countryListItem(
                      'USA',
                      'assets/images/usa.png',
                          () => selectCountry(
                        'USA',
                        'assets/images/usaBG.png',
                        'assets/images/usaBoy.png',
                        'assets/images/usaTopImage.png',
                      ),
                    ),
                    countryListItem(
                      'Russia',
                      'assets/images/russia.png',
                          () => selectCountry(
                        'Russia',
                        'assets/images/russiaBG.png',
                        'assets/images/russiaGirl.gif',
                        'assets/images/russiaCloud.png',
                      ),
                    ),
                    countryListItem(
                      'Japan',
                      'assets/images/japan.png',
                          () => selectCountry(
                        'Japan',
                        'assets/images/japanBG.png',
                        'assets/images/japanBoy.png',
                        'assets/images/japanTopImage.png',
                      ),
                    ),
                    countryListItem(
                      'United Kingdom',
                      'assets/images/uk.png',
                          () => selectCountry(
                        'United Kingdom',
                        'assets/images/ukBG.png',
                        'assets/images/ukBoy.png',
                        'assets/images/ukTopImage.png',
                      ),
                    ),
                    countryListItem(
                      'Italy',
                      'assets/images/italy.png',
                          () => selectCountry(
                        'Italy',
                        'assets/images/italyBG.png',
                        'assets/images/italyBoy.png',
                        'assets/images/italyTopImage.png',
                      ),
                    ),
                    countryListItem(
                      'Kenya',
                      'assets/images/kenya.png',
                          () => selectCountry(
                        'Kenya',
                        'assets/images/kenyaBG.png',
                        'assets/images/kenyaBoy.png',
                        'assets/images/kenyaTopImage.png',
                      ),
                    ),
                    countryListItem(
                      'Brazil',
                      'assets/images/brazil.png',
                          () => selectCountry(
                        'Brazil',
                        'assets/images/brazilBG.png',
                        'assets/images/brazilBoy.png',
                        'assets/images/brazilTopImage.png',
                      ),
                    ),
                    countryListItem(
                      'China',
                      'assets/images/china.png',
                          () => selectCountry(
                        'China',
                        'assets/images/chinaBG.png',
                        'assets/images/chinaBoy.png',
                        'assets/images/chinaTopImage.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            border: Border.all(color: isSelected ? Colors.black12 : Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4), // changes position of shadow
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

  // Select country and trigger callback
  void selectCountry(String countryName, String bgImage, String personImage, String cloudImage) {
    setState(() {
      selectedCountry = countryName;
    });
    widget.onCountrySelected(countryName, bgImage, personImage, cloudImage);
  }
}
