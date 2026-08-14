//
//  MeetKeyboardManager.swift
//  MeetKeyboardManager
//
//  Created with 💙 by Manpreet Singh.
//

import Foundation
import UIKit

public final class MeetManager {
    
    public static let shared                = MeetManager()

    var isEnabled                           = false
    private weak var activeField            : UIView?
    private var originalViewY               : CGFloat = 0
    
    private init() {
        
        if isEnabled {
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(textFieldDidBeginEditing(_:)),
                                                   name: UITextField.textDidBeginEditingNotification,
                                                   object: nil)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(textViewDidBeginEditing(_:)),
                                                   name: UITextView.textDidBeginEditingNotification,
                                                   object: nil)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow(_:)),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide(_:)),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }
    }
    
    deinit {
        if isEnabled {
            
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc private func textFieldDidBeginEditing(_ notification: Notification) {
       
        guard let textField = notification.object as? UITextField else { return }
        
        activeField                         = notification.object as? UIView
        addDoneToolbar(to: textField)
    }
    
    @objc private func textViewDidBeginEditing(_ notification: Notification) {
       
        guard let textView = notification.object as? UITextView else { return }
        
        activeField                         = notification.object as? UIView
        addDoneToolbar(to: textView)
    }
    
    // Overload for UITextField (has writable inputAccessoryView)
    private func addDoneToolbar(to textField: UITextField) {
       
        // Avoid adding multiple toolbars
        if textField.inputAccessoryView is UIToolbar { return }
        textField.inputAccessoryView        = makeDoneToolbar()
    }
    
    // Overload for UITextView (has writable inputAccessoryView)
    private func addDoneToolbar(to textView: UITextView) {
       
        // Avoid adding multiple toolbars
        if textView.inputAccessoryView is UIToolbar { return }
        textView.inputAccessoryView         = makeDoneToolbar()
    }
    
    // Builds the toolbar
    private func makeDoneToolbar() -> UIToolbar {
        
        let toolbar                         = UIToolbar()
        toolbar.barStyle                    = .default
        toolbar.isTranslucent               = true
        toolbar.backgroundColor             = .clear
        
        // Create flexible spaces for layout
        let flexSpaceLeft                   = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexSpaceRight                  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Done button on right
        let doneButton                      = UIBarButtonItem(title: "✓", style: .plain, target: self, action: #selector(doneTapped))
        
        toolbar.items                       = [flexSpaceLeft, flexSpaceRight, doneButton]
        toolbar.sizeToFit()
        return toolbar
    }
    
    @objc private func doneTapped() {
        
        getKeyWindow()?.endEditing(true)
    }
    
    // MARK: - Keyboard shift
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let field = activeField, let vcView = field.closestViewController()?.view, let userInfo = notification.userInfo, let kbFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        // compute overlap
        let fieldFrameInWindow              = field.convert(field.bounds, to: nil)
        let screenHeight                    = field.window?.windowScene?.screen.bounds.height ?? 0
        let overlap                         = (fieldFrameInWindow.maxY) - (screenHeight - kbFrame.height)
        guard overlap > 0 else { return }
        
        // save original Y
        if originalViewY == 0 {
            
            originalViewY                   = vcView.frame.origin.y
        }
        // keyboard animation
        let duration                        = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        let curveRaw                        = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue ?? UIView.AnimationCurve.easeInOut.rawValue
        let options                         = UIView.AnimationOptions(rawValue: UInt(curveRaw << 16))
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            
            vcView.frame.origin.y = self.originalViewY - overlap - 16 // optional padding
        }, completion: nil)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
       
        guard let field = activeField, let vcView = field.closestViewController()?.view else { return }
        
        let duration                        = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        let curveRaw                        = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue ?? UIView.AnimationCurve.easeInOut.rawValue
        let options = UIView.AnimationOptions(rawValue: UInt(curveRaw << 16))
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            
            vcView.frame.origin.y           = self.originalViewY
        }, completion: nil)
        
        originalViewY                       = 0
    }
    // Get the current key window safely for iOS 15+
    private func getKeyWindow() -> UIWindow? {
        
        if #available(iOS 15.0, *) {
            
            return UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap { $0.windows }.first { $0.isKeyWindow }
        }
        else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
}

