import 'package:flutter/material.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/services/app_extension.dart';

class SearchField extends StatefulWidget {
  final Function(String)? onSearch;
  const SearchField({super.key, this.onSearch});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  // late stt.SpeechToText _speech;
  // bool _isListening = false;
  // double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    // _speech = stt.SpeechToText();
  }

  // BuildContext context,
  TextEditingController controller = TextEditingController();
  Function() onSearchIconTap = () {};
  Function(String)? onSubmitted = (String) {};

  //   bool _isListening = false;
  // double _confidence = 1.0;
  //bool _isListening = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      width: 300.h,
      child: Padding(
        padding: EdgeInsets.only(
          right: 28.w,
          left: 28.w,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: TextField(

              // undoController: UndoHistoryController(),
              //focusNode: FocusNode(canRequestFocus: false),
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0),
                isDense: true,
                filled: true,
                fillColor: ColorManager.white,
                hintText: "Type to search",
                hintStyle: TextStyle(
                  fontSize: 13.h,
                  color: const Color(0xFF5F5F5F),
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
                prefixIcon: IconButton(
                  iconSize: 22.h,
                  onPressed: onSearchIconTap,
                  icon: Icon(
                    Icons.search,
                    color: ColorManager.appbarColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                      width: 1.h, color: Color.fromARGB(255, 44, 37, 37)),
                ),

                // voice recognization feature todo
                // suffixIcon: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     AvatarGlow(
                //       animate: _isListening,
                //       endRadius: 22.0,
                //       glowColor: const Color.fromARGB(255, 24, 226, 31),
                //       duration: Duration(milliseconds: 2000),
                //       repeat: true,
                //       repeatPauseDuration: Duration(milliseconds: 100),
                //       child: IconButton(
                //           iconSize: 22.h,
                //           onPressed: _listen,
                //           // icon: Icon(
                //           //   Icons.settings_voice_rounded,
                //           //   color: Colors.red,

                //           //   //isListining ? Icons.mic : Icons.mic_none,
                //           // )

                //           icon: Icon(
                //             _isListening ? Icons.mic_outlined : Icons.mic_off,
                //             color: Colors.red,
                //           )),
                //     ),
                //     // IconButton(
                //     //   iconSize: 22.h,
                //     //   onPressed: () {},
                //     //   icon: Icon(
                //     //     Icons.graphic_eq_outlined,
                //     //     color: AppColors.lightText,
                //     //   ),
                //     // )
                //   ],
                // ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1.h,
                color: const Color(0xFF5F5F5F),
                fontSize: 15.h,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
              ),
              // onChanged: onSubmitted,

              onChanged: (query) {
                if (widget.onSearch != null) {
                  widget.onSearch!(query);
                }
              }),
        ),
      ),
    );
  }

  // void _listen() async {
  //   if (_isListening) {
  //     // If already listening, stop the speech recognition
  //     _speech.stop();
  //     setState(() => _isListening = false);
  //   } else {
  //     // If not listening, start the speech recognition
  //     bool available = await _speech.initialize(
  //       onStatus: (val) => print('onStatus: $val'),
  //       onError: (val) => print('onError: $val'),
  //     );
  //     if (available) {
  //       setState(() => _isListening = true);
  //       _speech.listen(
  //         onResult: (val) {
  //           setState(() {
  //             if (val.hasConfidenceRating && val.confidence > 0) {
  //               _confidence = val.confidence;
  //               print(_confidence);
  //             }

  //             // Print the recognized speech here
  //             print("Recognized Speech: ${val.recognizedWords}");
  //           });
  //         },
  //       );
  //     } else {
  //       setState(() => _isListening = false);
  //       _speech.stop();
  //     }
  //   }
  // }
}
