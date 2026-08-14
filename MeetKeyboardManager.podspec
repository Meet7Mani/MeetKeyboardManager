Pod::Spec.new do |spec|

  spec.name         = "MeetKeyboardManager"
  spec.version      = "1.0.2"
  spec.summary      = "A lightweight keyboard manager for iOS."

  spec.description  = <<-DESC
    MeetKeyboardManager automatically adds a Done button
    to UITextField and UITextView keyboard toolbars and
    adjusts the view when the keyboard appears.
  DESC

  spec.homepage     = "https://github.com/Meet7Mani/MeetKeyboardManager"

  spec.license      = {
    :type => "MIT",
    :file => "LICENSE"
  }

  spec.author       = {
    "Manpreet Singh" => "s777manpreet@gmail.com"
  }

  spec.platform       = :ios, "15.0"
  spec.swift_versions = "5.0"

  spec.source       = {
    :git => "https://github.com/Meet7Mani/MeetKeyboardManager.git",
    :tag => spec.version.to_s
  }

  spec.source_files = "MeetKeyboardManager/**/*.swift"

end
