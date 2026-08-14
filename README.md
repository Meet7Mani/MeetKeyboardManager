# MeetKeyboardManager

A lightweight keyboard manager for iOS that automatically adds a **Done** button to `UITextField` and `UITextView` keyboard toolbars and adjusts the view when the keyboard appears.

## Requirements

* iOS 15.0+
* Swift 5.0+

## Installation

### Swift Package Manager

Add MeetKeyboardManager to your project using Xcode:

1. Open your project in Xcode.
2. Select **File → Add Package Dependencies...**
3. Enter:

```text
https://github.com/Meet7Mani/MeetKeyboardManager.git
```

4. Select the desired version and add the `MeetKeyboardManager` package.

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/Meet7Mani/MeetKeyboardManager.git",
        from: "1.0.2"
    )
]
```

Then add the product to your target:

```swift
.product(
    name: "MeetKeyboardManager",
    package: "MeetKeyboardManager"
)
```

### CocoaPods

Add the following to your `Podfile`:

```ruby
platform :ios, '15.0'

target 'YourApp' do
    use_frameworks!

    pod 'MeetKeyboardManager', '~> 1.0.2'
end
```

Then run:

```bash
pod install
```

## Usage

Import the framework:

```swift
import MeetKeyboardManager
```

Start the keyboard manager:

```swift
MeetManager.shared.start()
```

Stop the keyboard manager when it is no longer needed:

```swift
MeetManager.shared.stop()
```

## What It Does

MeetKeyboardManager provides:

* Automatically adds a **Done (✓)** button to `UITextField` keyboards.
* Automatically adds a **Done (✓)** button to `UITextView` keyboards.
* Dismisses the keyboard when the Done button is tapped.
* Automatically shifts the view when the active text field or text view is covered by the keyboard.
* Supports both Swift Package Manager and CocoaPods.
* Supports iOS 15.0 and later.

## Example

```swift
import UIKit
import MeetKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        MeetManager.shared.start()

        return true
    }
}
```
That's it. You do not need to call start() in every UIViewController.
The manager observes UITextField, UITextView, and keyboard notifications globally, so it handles text fields/text views throughout the application.

Stopping the manager

Normally, you don't need to call stop() during normal app usage. If your application needs to disable the keyboard manager for some reason, you can call:

```swift
MeetManager.shared.stop()
```

## License

MeetKeyboardManager is available under the MIT license. See the `LICENSE` file for more information.

## Author

with 💙 by Manpreet Singh.
s777manpreet@gmail.com

GitHub: https://github.com/Meet7Mani
