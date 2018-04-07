## Installing Carthage

There are multiple options for installing Carthage:

* **Installer:** Download and run the `Carthage.pkg` file for the latest [release](https://github.com/Carthage/Carthage/releases), then follow the on-screen instructions. If you are installing the pkg via CLI, you might need to run `sudo chown -R $(whoami) /usr/local` first.

* **Homebrew:** You can use [Homebrew](http://brew.sh) and install the `carthage` tool on your system simply by running `brew update` and `brew install carthage`. (note: if you previously installed the binary version of Carthage, you should delete `/Library/Frameworks/CarthageKit.framework`).

* **From source:** If you’d like to run the latest development version (which may be highly unstable or incompatible), simply clone the `master` branch of the repository, then run `make install`. Requires Xcode 9.0 (Swift 4.0).

## Adding frameworks to an application

Once you have Carthage [installed](#installing-carthage), you can begin adding frameworks to your project. Note that Carthage only supports dynamic frameworks, which are **only available on iOS 8 or later** (or any version of OS X).

### Getting started

##### If you're building for OS X

1. Create a [Cartfile][] that lists the frameworks you’d like to use in your project.
1. Run `carthage update`. This will fetch dependencies into a [Carthage/Checkouts][] folder and build each one or download a pre-compiled framework.
1. On your application targets’ _General_ settings tab, in the _Embedded Binaries_ section, drag and drop each framework you want to use from the [Carthage/Build][] folder on disk.

Additionally, you'll need to copy debug symbols for debugging and crash reporting on OS X.

1. On your application target’s _Build Phases_ settings tab, click the _+_ icon and choose _New Copy Files Phase_.
1. Click the _Destination_ drop-down menu and select _Products Directory_.
1. For each framework you’re using, drag and drop its corresponding dSYM file.

##### If you're building for iOS, tvOS, or watchOS

1. Create a [Cartfile][] that lists the frameworks you’d like to use in your project.
1. Run `carthage update`. This will fetch dependencies into a [Carthage/Checkouts][] folder, then build each one or download a pre-compiled framework.
1. On your application targets’ _General_ settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the [Carthage/Build][] folder on disk.
1. On your application targets’ _Build Phases_ settings tab, click the _+_ icon and choose _New Run Script Phase_. Create a Run Script in which you specify your shell (ex: `/bin/sh`), add the following contents to the script area below the shell:

    ```sh
    /usr/local/bin/carthage copy-frameworks
    ```

1. Add the paths to the frameworks you want to use under “Input Files”, e.g.:

    ```
    $(SRCROOT)/Carthage/Build/iOS/Result.framework
    $(SRCROOT)/Carthage/Build/iOS/ReactiveSwift.framework
    $(SRCROOT)/Carthage/Build/iOS/ReactiveCocoa.framework
    ```

1. Add the paths to the copied frameworks to the “Output Files”, e.g.:

    ```
    $(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Result.framework
    $(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/ReactiveSwift.framework
    $(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/ReactiveCocoa.framework
    ```

    With output files specified alongside the input files, Xcode only needs to run the script when the input files have changed or the output files are missing. This means dirty builds will be faster when you haven't rebuilt frameworks with Carthage.

This script works around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) triggered by universal binaries and ensures that necessary bitcode-related files and dSYMs are copied when archiving.

With the debug information copied into the built products directory, Xcode will be able to symbolicate the stack trace whenever you stop at a breakpoint. This will also enable you to step through third-party code in the debugger.

When archiving your application for submission to the App Store or TestFlight, Xcode will also copy these files into the dSYMs subdirectory of your application’s `.xcarchive` bundle.

##### For both platforms

Along the way, Carthage will have created some [build artifacts][Artifacts]. The most important of these is the [Cartfile.resolved][] file, which lists the versions that were actually built for each framework. **Make sure to commit your [Cartfile.resolved][]**, because anyone else using the project will need that file to build the same framework versions.
