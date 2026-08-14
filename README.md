# MeetKeyboardManager

A lightweight iOS keyboard manager that adds a Done button to text fields and text views and automatically adjusts the view when the keyboard appears.

# MeetKeyboardManager

A lightweight keyboard manager for iOS that automatically adds a **Done** button to `UITextField` and `UITextView` and moves the view when the keyboard overlaps the active input field.

## Features

- Automatically adds a Done button to `UITextField`
- Automatically adds a Done button to `UITextView`
- Dismisses the keyboard when Done is tapped
- Automatically moves the view when the keyboard overlaps the active input field
- Restores the view when the keyboard is dismissed
- Uses keyboard animation settings for smooth transitions
- Supports UIKit
- No third-party dependencies

## Requirements

- iOS 15.0+
- Swift 5.0+
- Xcode 15.0+
- UIKit

## Installation

### CocoaPods

Add `MeetKeyboardManager` to your `Podfile`:

    platform :ios, '15.0'

    target 'YourApp' do
      use_frameworks!

      pod 'MeetKeyboardManager'
    end

Then run:

    pod install

Open the generated `.xcworkspace` file and build your project.

## Usage

Import the framework:

    import MeetKeyboardManager

Initialize the manager:

    MeetManager.shared

That's it.

Once initialized, `MeetManager` automatically observes `UITextField` and `UITextView` editing events.

For example:

    import UIKit
    import MeetKeyboardManager

    final class ViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()

            MeetManager.shared
        }
    }

You don't need to manually configure individual text fields or text views.

## What It Does

### Done Button

When a `UITextField` or `UITextView` begins editing, MeetKeyboardManager automatically adds a toolbar above the keyboard with a Done button.

Tapping Done dismisses the keyboard.

### Keyboard Handling

When the keyboard appears and overlaps the active input field, MeetKeyboardManager automatically moves the view upward.

When the keyboard disappears, the view returns to its original position.

## Example

    import UIKit
    import MeetKeyboardManager

    final class LoginViewController: UIViewController {

        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!

        override func viewDidLoad() {
            super.viewDidLoad()

            MeetManager.shared
        }
    }

No additional setup is required for the text fields.

## How It Works

MeetKeyboardManager listens for:

- `UITextField` editing events
- `UITextView` editing events
- Keyboard show notifications
- Keyboard hide notifications

When an input view becomes active, the manager:

1. Adds a Done button to the keyboard toolbar.
2. Detects whether the keyboard overlaps the active input view.
3. Moves the view if necessary.
4. Restores the view when the keyboard is dismissed.

## License

MeetKeyboardManager is released under the MIT License.

See [LICENSE](LICENSE) for details.

## Author

**Manpreet Singh**
**s777manpreet@gmail.com**

## Repository

https://github.com/Meet7Mani/MeetKeyboardManager
