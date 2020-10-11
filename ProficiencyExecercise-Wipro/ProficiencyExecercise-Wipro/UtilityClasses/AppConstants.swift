//
//  AppConstants.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation

/// Enum that stores the String Constants being used in the app
enum StringConstants: String {
    case ok = "Ok"
}

/// Enum that stores all the Errors Messages being displayed in the app
enum ErrorsMessages: String {
    case errorTitle = "⚠️ ERROR!!"
    case noInternet = "Your internet connection appears to be offline."
    case somethingWentWrong = "Something Went Wrong!!"
    case noData = "No Data Available!"
}

/// Enum that stores all the Notification Names being used in the app
enum NotificationNames: String {
    case refreshControl = "RefreshControl"
    case reloadCell = "ReloadCell"
    case userInfoKeyCell = "CurrentCell"
}

/// Enum that stores all the Image Names being used in the app
enum ImageNames: String {
    case placeholderImage = "placeholder"
}

/// Enum that stores all the TableView Cell Identifiers being used in the app
enum TableViewCellIdentifiers: String {
    case aboutCanadaTableViewCell = "AboutCanadaTableViewCell"
}
