import '../pages/welcome.dart';
import '../pages/home.dart';
import '../pages/faq.dart';
import '../pages/booking.dart';
import '../pages/consultations.dart';
import '../pages/login.dart';
import '../pages/reset-password.dart';
import '../pages/register.dart';
import '../pages/edit_profile.dart';
import '../pages/teamwork.dart';
import '../pages/gallery.dart';
import '../pages/videos.dart';
import '../pages/about_us.dart';
import '../pages/under_construction.dart';
import '../pages/contact_us.dart';
import '../pages/settings.dart';

import 'route_names.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case aboutusRoute:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case galleryRoute:
        return MaterialPageRoute(builder: (_) => GalleryPage());
      case videosRoute:
        return MaterialPageRoute(builder: (_) => VideosPage());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => FAQPage());
      case teamWorkRoute:
        return MaterialPageRoute(builder: (_) => TeamWorkPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case contactUsRoute:
        return MaterialPageRoute(builder: (_) => ContactUs());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => Settings());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case bookingRoute:
        return MaterialPageRoute(builder: (_) => BookingPage());
      case consultationsRoute:
        return MaterialPageRoute(builder: (_) => Consultations());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => ProfilePage());
    }

    return MaterialPageRoute(builder: (_) => UnderConstructionPage());
  }
}