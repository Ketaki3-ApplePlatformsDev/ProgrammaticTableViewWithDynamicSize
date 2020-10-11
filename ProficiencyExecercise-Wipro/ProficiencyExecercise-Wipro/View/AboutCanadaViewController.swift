//
//  ViewController.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 10/10/20.
//

import UIKit

typealias CompletionHandler = (_ success:Bool, _ aboutCanada: [AboutCanada]?, _ title: String?) -> Void

class AboutCanadaViewController: UIViewController {
    let aboutTableView = UITableView()
    var safeArea: UILayoutGuide!
    var aboutCanada: [AboutCanada] = []
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }
}

extension AboutCanadaViewController {
    func setupTableView() {
        view.addSubview(aboutTableView)
        aboutTableView.translatesAutoresizingMaskIntoConstraints = false
        aboutTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        aboutTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        aboutTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        aboutTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        aboutTableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifiers.aboutCanadaTableViewCell.rawValue)
        
        aboutTableView.estimatedRowHeight = 64
        aboutTableView.rowHeight = UITableView.automaticDimension
    }
}

extension AboutCanadaViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return aboutCanada.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let aboutCanadaTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.aboutCanadaTableViewCell.rawValue, for: indexPath)
    let dataToDisplay = self.aboutCanada[indexPath.row]
    configure(cell: aboutCanadaTableViewCell, withDataToDisplay: dataToDisplay)
    return aboutCanadaTableViewCell
  }
    
    func configure(cell: UITableViewCell, withDataToDisplay aboutCanada: AboutCanada) {
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        if let title = aboutCanada.title {
            cell.textLabel?.text = title
        } else {
            cell.textLabel?.text = StringConstants.titleUnavailable.rawValue
        }
        
        if let descrition = aboutCanada.description {
            cell.detailTextLabel?.text = descrition
        } else {
            cell.detailTextLabel?.text = StringConstants.descriptionUnavailable.rawValue
        }
    }
}
