// // ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koreanapp/resources/colorManager.dart';
import 'package:koreanapp/screens/onboarding/onboardingScreen.dart';
import 'package:koreanapp/screens/presentation/signin/signin.dart';
import 'package:koreanapp/screens/profile/switch_provider.dart';
import 'package:koreanapp/services/app_extension.dart';
import 'package:koreanapp/widgets/bottomNavBar.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../services/appcolors.dart';
import '../../widgets/customBackButton.dart';
import 'custom_profile_text.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String userName = "";
  late String phone = "";
  late String id = "";
  String termsOfServiceContent = "";
  String privacyPolicyContent = "";
  String openSourceLicenseContent = "";
  bool switchValue = false; // Define switchValue here
  // Variable to store the Privacy Policy content

  _ProfileState();

  void fetchTermsOfService() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("termsOfService")
          .limit(1) // Limit to the first document in the collection
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the first document in the collection
        String termsOfServiceContent = querySnapshot.docs.first["detail"];

        setState(() {
          this.termsOfServiceContent = termsOfServiceContent;
        });
      } else {
        // No documents in the collection
        print("Terms of Service collection is empty.");
      }
    } catch (e) {
      print("Error fetching Terms of Service: $e");
    }
  }

  void fetchPrivacyPolicy() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("privacyPolicy")
          .limit(1) // Limit to the first document in the collection
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the first document in the collection
        String privacyPolicyContent = querySnapshot.docs.first["detail"];

        setState(() {
          this.privacyPolicyContent = privacyPolicyContent;
        });
      } else {
        // No documents in the collection
        print("Privacy Policy collection is empty.");
      }
    } catch (e) {
      print("Error fetching Privacy Policy: $e");
    }
  }

  void fetchOpenSourceLicense() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("openSourceLicense")
          .limit(1) // Limit to the first document in the collection
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the first document in the collection
        String openSourceLicenseContent = querySnapshot.docs.first["detail"];

        setState(() {
          this.openSourceLicenseContent = openSourceLicenseContent;
        });
      } else {
        // No documents in the collection
        print("Open Source License collection is empty.");
      }
    } catch (e) {
      print("Error fetching Open Source License: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // _startShakeDetection(context);
    getValue();
    fetchTermsOfService();
    fetchPrivacyPolicy();
    fetchOpenSourceLicense(); // Fetch Terms of Service content on initialization
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString('name');
    print("My name is $getName");
    var getPhone = prefs.getString('phone');
    print("My phone is $getPhone");

    var getid = prefs.getString('token');
    print("My id is $getid");
    setState(() {
      userName = (getName)!;
      phone = getPhone!.toString();
      id = (getid)!;
    });
  }

  // void _startShakeDetection(BuildContext context) {
  //   shake(context);
  // }

  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void showDial(String content) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SimpleDialog(
            backgroundColor: ColorManager.white,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 4.h),
                child: Container(
                  padding: EdgeInsets.all(6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.w),
                    borderRadius: BorderRadius.circular(0.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        termsOfServiceContent,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showDial1(String content) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SimpleDialog(
            backgroundColor: AppColors.white,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 4.h),
                child: Container(
                  padding: EdgeInsets.all(6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.w),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        privacyPolicyContent,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showDial2(String content) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SimpleDialog(
            backgroundColor: AppColors.white,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 4.h),
                child: Container(
                  padding: EdgeInsets.all(6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.w),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        openSourceLicenseContent,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final switchProvider1 = Provider.of<SwitchProvider>(context);
    // final switchProvider2 = Provider.of<SwitchProvider>(context);

    return NewScaffoldForColorFiltered(
      // switchProvider1: switchProvider1,
      // switchProvider2: switchProvider2,
      userName: userName,
      id: id,
      phone: phone,
    );
  }

  Scaffold NewScaffoldForColorFiltered({
    // required SwitchProvider switchProvider1,
    // switchProvider2,
    required String userName,
    required String id,
    required String phone,
  }) {
    return Scaffold(
      body: ProfileBackgroungWid(
        userName: userName,
        id: id,
        child: ListView(
          children: [
            SizedBox(
              height: 30.h,
            ),
            CustomProfileText(
              onTap: () {
                print("contacts clicked");
              },
              customtext: "Contact: \t $phone",
              customicon: Icons.import_contacts_rounded,
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.h,
              ),
              child: Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.h, bottom: 15.h),
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // CustomSwitchRow1(
            //   // switchProvider: switchProvider1,
            //   text: "Black and white",
            //   value: false,
            //   // value: switchProvider1
            //   // .switchValue1, // Get the switch value from the provider
            //   onChanged: (newValue) {
            //     setState(() {
            //       // Update the switch value using the provider
            //       // switchProvider1.setSwitchValue1(newValue);
            //       print("switch value of profile is $newValue");
            //     });
            //   },
            // ),
            // CustomSwitchRow2(
            //   // switchProvider: switchProvider2,
            //   text: "Dylexia",
            //   value: false,
            //   // value: switchProvider2
            //   // .switchValue2, // Get the switch value from the provider
            //   onChanged: (newValue) {
            //     setState(() {
            //       // Update the switch value using the provider
            //       // switchProvider2.setSwitchValue2(newValue);
            //       print("switch value of profile dylexia is $newValue");
            //     });
            //   },
            // ),
            // CustomProfileText(
            //   onTap: () {},
            //   customtext: "Version \t 1.0",
            //   customicon: Icons.phone_android,
            // ),
            // CustomProfileText(
            //   onTap: () {
            //     showDial(termsOfServiceContent);
            //   },
            //   customtext: "Terms of Service",
            //   customicon: Icons.library_books_outlined,
            // ),
            // CustomProfileText(
            //   onTap: () {
            //     showDial1(privacyPolicyContent);
            //   },
            //   customtext: "Privacy Policy",
            //   customicon: Icons.privacy_tip_outlined,
            // ),
            CustomProfileText(
              onTap: () {
                showDial2(openSourceLicenseContent);
              },
              customtext: "Favourites",
              customicon: Icons.favorite_outline,
            ),
            CustomProfileText(
              onTap: () {
                showDial2(openSourceLicenseContent);
              },
              customtext: "Change language",
              customicon: Icons.language,
            ),
            SizedBox(
              height: 190.h,
            ),
            CustomProfileSignoutText(
              onTap: () {
                speak("Sign out");
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignIn();
                  }));
                });
              },
              customtext: "Sign Out",
              customicon: Icons.exit_to_app_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

// // new for profile

class ProfileBackgroungWid extends StatefulWidget {
  // final String customtext;
  Userdetails? userdetails;

  // late String userName;
  late String userName = ""; // Provide a default value

  final Widget child;
  final String id;

  ProfileBackgroungWid({
    Key? key,
    this.userdetails,
    required this.userName,
    required this.child,
    required this.id,
  }) : super(key: key);

  @override
  State<ProfileBackgroungWid> createState() => _ProfileBackgroungWidState();
}

class _ProfileBackgroungWidState extends State<ProfileBackgroungWid> {
  final imagePicker = ImagePicker();
  XFile? pickedImage;
  String imageUrls = "";
  String? id;

  bool isSaving = false;
  bool isUploading = false;
  String userName = ""; // Initialize with an empty string

  // String? customtext;

  @override
  void initState() {
    // pickedImage = XFile(widget.userdetails!.imageUrls!);
    // print("picked $pickedImage");
    super.initState();
    getValue();
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString('name');
    setState(() {
      userName = getName ?? ""; // Set userName based on SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.id)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.data!.exists) {
                    return const Center(child: Text("User data not found"));
                  }
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Container(
                    color: ColorManager.appbarColor,
                    height: MediaQuery.of(context)
                        .size
                        .height, // Set a limited height

                    child: CustomPaint(
                      painter: VennDiagramPainter(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: CustomBackButton(onBack: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomeBottomNavBar();
                              }));
                            }),
                          ),
                          CircleAvatar(
                            radius: 32.r,
                            backgroundColor: Colors.grey[300],
                            // backgroundImage: userData['imageUrls'] != null
                            //     ? NetworkImage(userData['imageUrls'])
                            //     : (pickedImage != null &&
                            //             pickedImage!.path.isNotEmpty)
                            //         ? FileImage(File(pickedImage!.path))
                            //             as ImageProvider
                            //         : null,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () async {
                                  await pickImage();
                                  if (pickedImage != null) {
                                    await uploadImages();
                                    await Userdetails.addUserImage(
                                      widget.id,
                                      Userdetails(
                                        imageUrls: imageUrls,
                                        id: widget.id,
                                      ),
                                    );
                                    setState(() {
                                      isUploading = false;
                                    });
                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    var image =
                                        prefs.setString('imageUrls', imageUrls);
                                    print("Image is $image");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.primary,
                                    size: 24.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.userName,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            // Use Expanded to occupy remaining vertical space
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(40),
                                //   topRight: Radius.circular(40),
                                // ),
                              ),
                              child: widget.child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }

  pickImage() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        this.pickedImage = pickedImage;
      });
    } else {
      print("no images selected");
    }
  }

  Future<void> uploadImages() async {
    if (pickedImage != null) {
      try {
        String downloadUrl = await postImages(pickedImage);
        setState(() {
          imageUrls = downloadUrl; // Update imageUrls with the download URL
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("userImages")
        .child(imageFile!.name);

    await ref.putData(
      await imageFile.readAsBytes(),
      SettableMetadata(contentType: "image/jpeg"),
    );
    urls = await ref.getDownloadURL();
    setState(() {
      isUploading = false;
      imageUrls = urls!;
    });
    return urls;
  }
}

//new background

class Userdetails {
  String imageUrls;
  String id;
  Userdetails({
    required this.imageUrls,
    required this.id,
  });

  static Future<void> addUserImage(String id, Userdetails addUserImage) async {
    CollectionReference db = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> data = {
      'imageUrls': addUserImage.imageUrls,
    };
    await db.doc(id).update(data);
  }
}

class CustomSwitchRow extends StatefulWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitchRow({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomSwitchRowState createState() => _CustomSwitchRowState();
}

class _CustomSwitchRowState extends State<CustomSwitchRow> {
  @override
  Widget build(BuildContext context) {
    // Define a custom TextStyle for the text when the toggle is on
    TextStyle customTextStyle = TextStyle(
      color: Colors.black, // Set the desired text color here
      fontFamily: 'DancingScript', // Set your custom font here
      fontSize: 16.0, // Set the desired font size here
    );

    // Define the default TextStyle for the text when the toggle is off
    TextStyle defaultTextStyle = TextStyle(
      color: Colors.black, // Set the default text color here
      fontSize: 16.0, // Set the default font size here
    );

    return Row(
      children: [
        Text(
          widget.text,
          style: widget.value ? customTextStyle : defaultTextStyle,
        ),
        Switch(
          value: widget.value,
          onChanged: (newValue) {
            widget.onChanged(newValue);
          },
        ),
      ],
    );
  }
}
