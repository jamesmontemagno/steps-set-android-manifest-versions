# Set Android Manifest Version Code and Name

Sets the Android Manifest Version Code and Name to the specified value, in the target AndroidManifest.xml file for the next build.

## Usage

### Android Manifest File Path

This is the direct path to your Adroid manifest .xml file. and should be specified such as: MyFile/Properties/AndroidManifest.xml

### Version Code
This is an integer type usually the $BITRISE_BUILD_NUMBER that is used ast the android:versionCode

### Version Code Offest
This input will automatically be added to the Build Number as an offset

### Version Name
This is a string that will be used to update the android:versionName. It can use any string, but the / is reserved and can not be used. A good example is: 1.0.$BITRISE_BUILD_NUMBER

## How to use this Step

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*
