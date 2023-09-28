
# Fegno Task

## Android Configuration

##### Change MainActivity.kt like this

```
package com.example.stripe_pay

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}

```

##### Change " android\app\src\main\res\values\styles.xml " like this

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Theme applied to the Android Window while the process is starting when the OS's Dark Mode setting is off -->
    <style name="LaunchTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <!-- Show a splash screen on the activity. Automatically removed when
             the Flutter engine draws its first frame -->
        <item name="android:windowBackground">@drawable/launch_background</item>
    </style>
    <!-- Theme applied to the Android Window as soon as the process has started.
         This theme determines the color of the Android Window while your
         Flutter UI initializes, as well as behind your Flutter UI while its
         running.

         This Theme is only used starting with V2 of Flutter's Android embedding. -->
    <style name="NormalTheme" parent="Theme.MaterialComponents">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
</resources>


```

##### Change " android\app\src\main\res\values-night\styles.xml " like this

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Theme applied to the Android Window while the process is starting when the OS's Dark Mode setting is on -->
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <!-- Show a splash screen on the activity. Automatically removed when
             the Flutter engine draws its first frame -->
        <item name="android:windowBackground">@drawable/launch_background</item>
    </style>
    <!-- Theme applied to the Android Window as soon as the process has started.
         This theme determines the color of the Android Window while your
         Flutter UI initializes, as well as behind your Flutter UI while its
         running.

         This Theme is only used starting with V2 of Flutter's Android embedding. -->
    <style name="NormalTheme" parent="Theme.MaterialComponents">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
</resources>

```


## Libraries & Tools Used 

* [flutter_stripe](https://pub.dev/packages/flutter_stripe)
* [dio](https://pub.dev/packages/dio)
