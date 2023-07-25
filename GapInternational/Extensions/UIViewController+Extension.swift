//
//  UIViewController+Extension.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with title: String, andMessage body: String? = nil) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
