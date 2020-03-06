// import 'dart:ui';

// import 'package:cognifeed_app/application_wrapper.dart';
// import 'package:cognifeed_app/constants/cognifeed_constants.dart';
// import 'package:cognifeed_app/home/show_all_tags.dart';
// import 'package:cognifeed_app/widgets/TagWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';

// class OnboardingPage extends StatefulWidget {
//   @override
//   _OnboardingPageState createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar:
//           PreferredSize(preferredSize: Size(0, 0), child: SizedBox.shrink()),
//       bottomNavigationBar: SizedBox.shrink(),
//       body: AnnotatedRegion(
//         value: SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//         ),
//         child: Stack(
//           fit: StackFit.expand,
//           children: <Widget>[
//             Positioned(
//               right: -20,
//               top: 0,
//               bottom: -10,
//               left: -2,
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Image.asset(
//                   "assets/images/onboarding.png",
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             Stack(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.fromLTRB(21, 60, 10, 0),
//                   width: 372,
//                   height: 667,
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.12),
//                           borderRadius:
//                               BorderRadius.only(topLeft: Radius.circular(19))),
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     CognifeedOnboard(),
//                     MakeChoices(),
//                     SearchBox(),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Tags(),
//                     Container(
//                       margin: EdgeInsets.only(
//                         top: 15,
//                         bottom: 15,
//                       ),
//                       height: 2,
//                       width: 370,
//                       color: Color(0xff00c9c3),
//                     ),
//                     ShowMore(),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(14, 20, 10, 0),
//                       width: 372,
//                       height: 62.5,
//                       color: Colors.white.withOpacity(0.35),
//                       child: Stack(
//                         children: <Widget>[
//                           BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                           ),
//                           SaveButton(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CognifeedOnboard extends StatelessWidget {
//   const CognifeedOnboard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(
//           width: 20,
//         ),
//         SvgPicture.asset(
//           "assets/images/logo.svg",
//           width: 148,
//           height: 49,
//         ),
//       ],
//     );
//   }
// }

// class MakeChoices extends StatelessWidget {
//   const MakeChoices({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(top: 20, bottom: 15),
//           height: 30,
//           width: MediaQuery.of(context).size.width - 20,
//           padding: EdgeInsets.fromLTRB(110, 0, 96, 0),
//           child: Text(
//             'Make your choices!',
//             style: CognifeedTypography.textStyleOnboardHeading.copyWith(
//               color: Color(0xff192965),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SearchBox extends StatelessWidget {
//   const SearchBox({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(left: 22, right: 20),
//               height: 83,
//               width: 369,
//               decoration: BoxDecoration(
//                 color: Color(0xff192965).withOpacity(0.66),
//                 boxShadow: [
//                   BoxShadow(
//                       blurRadius: 6,
//                       offset: Offset(8, 10),
//                       color: Colors.black.withOpacity(0.16)),
//                 ],
//               ),
//               padding: EdgeInsets.fromLTRB(103, 15, 96, 13),
//             ),
//           ],
//         ),
//         SearchInput(),
//       ],
//     );
//   }
// }

// class SearchInput extends StatelessWidget {
//   const SearchInput({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 24),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Container(
//             height: 2,
//             width: 80,
//             color: Color(0xff00c9c3),
//           ),
//           Container(
//             height: 40,
//             width: 280,
//             decoration: BoxDecoration(
//               color: Color(0xffe9fdfc),
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//               border: Border.all(color: Color(0xff00c9c3), width: 1),
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search for tags...',
//                 hintStyle: CognifeedTypography.tags.copyWith(
//                   color: Color(0xff192965),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 2,
//             width: 50,
//             color: Color(0xff00c9c3),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ShowMore extends StatelessWidget {
//   const ShowMore({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (BuildContext context) => ShowAllTags()));
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(left: 40),
//             child: Text(
//               'Show more',
//               style: CognifeedTypography.textStyleOnboardHeading
//                   .copyWith(color: Color(0xffe9fdfc), fontSize: 20),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Image.asset(
//             "assets/images/next.png",
//             height: 25,
//             color: Color(0xffe9fdfc),
//           )
//         ],
//       ),
//     );
//   }
// }

// class SaveButton extends StatelessWidget {
//   const SaveButton({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (_) => ApplicationWrapper()));
//           },
//           child: Container(
//             margin: EdgeInsets.only(top: 16, left: 15),
//             padding: EdgeInsets.symmetric(horizontal: 35, vertical: 4),
//             child: Text(
//               'Save',
//               style:
//                   CognifeedTypography.tags.copyWith(color: Color(0xffe9fdfc)),
//             ),
//             decoration: BoxDecoration(
//               color: Color(0xff192965).withOpacity(0.85),
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:cognifeed_app/widgets/application_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../constants/Tags.dart';
import '../constants/cognifeed_constants.dart';
import '../constants/cognifeed_constants.dart';
import '../constants/cognifeed_constants.dart';
import '../widgets/TagWidget.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return ApplicationScaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff5a5f),
        onPressed: () {},
        child: Icon(
          Feather.arrow_right,
          size: 25,
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          color: Color(0xfff2f5f9),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Wrap(
            spacing: 15,
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 15,
            children: alltags.map((tag) {
              return CustomChip(tag: tag);
            }).toList(),
          ),
        ),
      ),
      title: "Make Your Choices!",
      isOnBoarding: true,
    );
  }
}

// class CustomChip extends StatefulWidget {

//   @override
//   _CustomChipState createState() => _CustomChipState();
// }

// class _CustomChipState extends State<CustomChip> {
//   bool isSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
// onTap: () {
//   isSelected = !isSelected;
//   if (isSelected) {
//     selectedTags.add(widget.tag);
//   } else {
//     if (selectedTags.contains(widget.tag)) {
//       selectedTags.remove(widget.tag);
//     }
//   }
//   setState(() {});
//   print(selectedTags);
// },
//       child: Container(
//         child: Chip(
//             backgroundColor: isSelected ? Colors.red : null,
//             label: Text(
//               widget.tag,
//               style: CognifeedTypography.articleTitle.copyWith(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 18,
//               ),
//             )),
//       ),
//     );
//   }
// }
class CustomChip extends StatefulWidget {
  final String tag;
  const CustomChip({Key key, @required this.tag}) : super(key: key);

  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  /// chips defination
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        if (isSelected) {
          selectedTags.add(widget.tag);
        } else {
          if (selectedTags.contains(widget.tag)) {
            selectedTags.remove(widget.tag);
          }
        }
        setState(() {});
        print(selectedTags);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: (isSelected) ? Color(0xffff5a5f) : Colors.white,
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1,
          //   style: BorderStyle.solid,
          // ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),
        child: Text(
          this.widget.tag,
          style: CognifeedTypography.articleTitle
              .copyWith(color: (isSelected) ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

var selectedTags = [];
