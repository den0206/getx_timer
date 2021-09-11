import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

var useTestId = true;
var showAd = true;

class AdmobBannerService {
  static AdmobBannerService get to => AdmobBannerService();

  static String get addID {
    if (Platform.isAndroid) {
      return "ca-app-pub-9593268307163426~8566551544";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9593268307163426~2642117502";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId1 {
    if (useTestId) {
      /// Test
      return Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-3940256099942544/2934735716";
    } else {
      if (Platform.isAndroid) {
        return FlutterConfig.get("BANNER_ANDROID");
      } else if (Platform.isIOS) {
        return FlutterConfig.get("BANNER_IOS");
      } else {
        throw new UnsupportedError("Unsupported platform");
      }
    }
  }

  Widget get myBannerAd {
    var bannerAd = BannerAd(
      adUnitId: bannerAdUnitId1,
      size: AdSize.banner,
      listener: bannerAdlistner,
      request: AdRequest(),
    )..load();

    return showAd
        ? Container(
            color: Colors.yellow[50],
            margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            width: bannerAd.size.width.toDouble(),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(ad: bannerAd),
          )
        : Container(
            width: 70.w,
          );
  }

  Widget get myDialogAd {
    var bannerAd = BannerAd(
      adUnitId: bannerAdUnitId1,
      size: AdSize.banner,
      listener: bannerAdlistner,
      request: AdRequest(),
    )..load();

    return showAd
        ? Container(
            color: Colors.yellow[50],
            margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            width: bannerAd.size.width.toDouble(),
            height: 60.w,
            child: AdWidget(ad: bannerAd),
          )
        : Container();
  }

  BannerAdListener get bannerAdlistner {
    return BannerAdListener(
      onAdLoaded: (ad) {},
      onAdOpened: (ad) {},
      onAdImpression: (Ad ad) {},
      onAdClosed: (ad) => print("Bannar close"),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        print("Banner failed");
        ad.dispose();
      },
    );
  }
}

class AdmobInterstialService extends GetxService {
  static AdmobInterstialService get to => Get.find();

  InterstitialAd? myInterstitialAd;
  int numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  static String get interstitialVideoAdUnitId {
    if (useTestId) {
      /// Test
      return Platform.isAndroid
          ? "ca-app-pub-3940256099942544/8691691433"
          : "ca-app-pub-3940256099942544/5135589807";
    } else {
      if (Platform.isAndroid) {
        return FlutterConfig.get("INSTESTIAL_VIDEO_ANDROID");
      } else if (Platform.isIOS) {
        return FlutterConfig.get("INSTESTIAL_VIDEO_IOS");
      } else {
        throw new UnsupportedError("Unsupported platform");
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    _createInterstitialAd();
  }

  Future<void> showInterstialAd({Function()? onDismiss}) async {
    if (myInterstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _addFullScreenContentCallback(onDismiss);
    await _showLoadingAdDialog();
    myInterstitialAd!.show();
    myInterstitialAd = null;
  }

  void _createInterstitialAd() {
    var _ = InterstitialAd.load(
      adUnitId: interstitialVideoAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          myInterstitialAd = ad;
          numInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
          numInterstitialLoadAttempts += 1;
          myInterstitialAd = null;
          if (numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _addFullScreenContentCallback(Function()? onDismissAd) {
    myInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        // print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        if (onDismissAd != null) onDismissAd();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();

        _createInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) {},
    );
  }

  Future<void> _showLoadingAdDialog() async {
    Get.defaultDialog(
        title: "",
        content: Column(
          children: [LoadingCellWidget(), Text("Loading....")],
        ));

    await Future.delayed(Duration(seconds: 1));
    if (Get.isDialogOpen!) Get.back();
  }
}

class LoadingCellWidget extends StatelessWidget {
  const LoadingCellWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 12.0,
        ),
      ),
    );
  }
}
