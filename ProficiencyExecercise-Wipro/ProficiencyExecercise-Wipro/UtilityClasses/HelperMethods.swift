//
//  HelperMethods.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation
import UIKit

class HelperMethods {
    func displayAlert(inViewController viewController: UIViewController, withTitle title: String?, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: StringConstants.ok.rawValue, style: .cancel, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

