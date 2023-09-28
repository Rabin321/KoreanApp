class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Learn Korean with Hanguel",
    image: "assets/images/onboardingscreen1.png",
    desc: "The best app which helps you learn korean language",
  ),
  OnboardingContents(
    title: "Seamless Start to 한국어 Learning",
    image: "assets/images/onboardingscreen1.png",
    desc:
        "Dive into the wonders of Korean language and culture through the app",
  ),
  OnboardingContents(
    title: "Mastering 한국어 through Quizzes",
    image: "assets/images/onboardingscreen1.png",
    desc:
        "Enhance your proficiency in the Korean language through the interactive quizzes",
  ),
];
