//
//  UIViewController+.swift
//  Tamaverse
//
//  Created by 강민수 on 2/21/25.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(
            title: StringLiterals.Alert.confirm,
            style: .default
        )
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func presentDeleteAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let cancelAlertAction = UIAlertAction(
            title: StringLiterals.Alert.cancel,
            style: .default
        )
        
        let deleteAlertAction = UIAlertAction(
            title: StringLiterals.Alert.delete,
            style: .destructive
        ) { _ in
            completion()
        }
        
        alertController.addAction(cancelAlertAction)
        alertController.addAction(deleteAlertAction)
        present(alertController, animated: true)
    }
}
