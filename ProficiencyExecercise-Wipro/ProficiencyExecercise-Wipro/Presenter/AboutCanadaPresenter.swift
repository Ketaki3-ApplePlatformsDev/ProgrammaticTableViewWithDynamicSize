//
//  AboutCanadaPresenter.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation
import UIKit

struct AlertPresenter {
    func displayAlert(inViewController viewController: UIViewController, withTitle title: String?, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstants.ok.rawValue, style: .default, handler: { alert in
            NotificationCenter.default.post(name: Notification.Name(NotificationNames.refreshControl.rawValue), object: nil)
        }))
        
        viewController.present(alert, animated: true)
    }
}

class AboutCanadaViewControllerPresenter {
    weak private var controller : UIViewController?
    
    func attachedController (controler: UIViewController){
        controller = controler
    }
    
    func detachController() {
        controller = nil
    }
}
