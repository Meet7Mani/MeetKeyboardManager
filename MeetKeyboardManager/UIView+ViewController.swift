//
//  UIView+ViewController.swift
//
//  Created with 💙 by Manpreet Singh.
//

import Foundation
import UIKit

extension UIView {
   
    func closestViewController() -> UIViewController? {
        
        var nextResponder                   : UIResponder? = self
        while nextResponder != nil {
           
            nextResponder                   = nextResponder?.next
            if let vc = nextResponder as? UIViewController {
                
                return vc
            }
        }
        return nil
    }
}
