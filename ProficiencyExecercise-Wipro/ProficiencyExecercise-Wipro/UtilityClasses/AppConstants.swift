//
//  AppConstants.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import Foundation

enum StringConstants: String {
    case ok = "Ok"
    case networkError = "⚠️ Network Error!!"
    case internetConnectionOffline = "Your internet connection appears to be offline."
    case titleUnavailable = "Title is unavailable."
    case descriptionUnavailable = "Description is unavailable."
}

enum ErrorsMessages: String {
    case errorTitle = "⚠️ ERROR!!"
    case noInternet = "Your internet connection appears to be offline."
    case somethingWentWrong = "Something Went Wrong!!"
    case noData = "No Data Available!"
}

enum NotificationNames: String {
    case refreshControl = "RefreshControl"
    case reloadCell = "ReloadCell"
    case userInfoKeyCell = "CurrentCell"
}

enum ImageNames: String {
    case placeholderImage = "placeholder"
}

enum TableViewCellIdentifiers: String {
    case aboutCanadaTableViewCell = "AboutCanadaTableViewCell"
}
