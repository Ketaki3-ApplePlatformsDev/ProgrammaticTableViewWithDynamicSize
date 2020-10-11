//
//  AboutCanadaPresenter.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation
import UIKit

/// Presneter for Alerts in the app
struct AlertPresenter {
    /**
     Displays alert message and title on the viewController passed.
     
     - Parameter viewController: The on which the alert is to be presnted.
     
     - Parameter title: Title of the alert to be displayed.
     
     - Parameter message: Message to be displayed in the alert.
     */
    func displayAlert(inViewController viewController: UIViewController, withTitle title: String?, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstants.ok.rawValue, style: .default, handler: { alert in
            NotificationCenter.default.post(name: Notification.Name(NotificationNames.refreshControl.rawValue), object: nil)
        }))
        
        viewController.present(alert, animated: true)
    }
}

/// Presenter for AboutCanadaViewController
class AboutCanadaViewControllerPresenter {
    weak private var controller : UIViewController?
    
    /**
     Attaches the view controlller passed
     */
    func attachController (controller: UIViewController){
        self.controller = controller
    }
    
    /**
     Deattaches the view controlller passed
     */
    func detachController() {
        self.controller = nil
    }
}
