//
//  ViewController.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 10/10/20.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

typealias CompletionHandler = (_ success:Bool, _ aboutCanada: [AboutCanada]?, _ title: String?) -> Void

class AboutCanadaViewController: UIViewController {
    // MARK: - UI Components
    let aboutTableView = UITableView()
    var refreshControl: UIRefreshControl!
    var activityIndicator: NVActivityIndicatorView!
    
    private let viewControllerPresenter = AboutCanadaViewControllerPresenter()
    
    /// Used to store "AboutCanada" type data to be loaded on AboutCanadaTableViewCell
    lazy var aboutCanadaArray: [AboutCanada] = {
        return []
    }()
    
    override func viewDidLoad() {
        // To keep track of image aync call to update that particular cell
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCell(_:)), name: NSNotification.Name(rawValue: NotificationNames.reloadCell.rawValue), object: nil)
        // To keep track if internet is discomnnected then refresh control should end refreshing without blocking main thread
        NotificationCenter.default.addObserver(self, selector: #selector(self.endRefreshing(_:)), name: NSNotification.Name(rawValue: NotificationNames.refreshControl.rawValue), object: nil)
        
        view.backgroundColor = .clear
        setupTableView()
        setTableViewConstraints()
        loadAndRefreshDataFromService()
    }
}

// MARK: - UI Methods
extension AboutCanadaViewController {
    /**
     Method that sets up the TableView's delegate, datasource and other ui controls being displayed eg. refresh control .
     */
    func setupTableView() {
        aboutTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setting DataSource & Delegate for aboutTableView
        aboutTableView.delegate = self
        aboutTableView.dataSource = self
        
        // Settting up dynamic height of row in aboutTableView
        if UIDevice.current.userInterfaceIdiom == .phone {
            aboutTableView.estimatedRowHeight = 65
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            aboutTableView.estimatedRowHeight = 105
        }
        aboutTableView.rowHeight = UITableView.automaticDimension
        
        // Adding refresh control to call service and reload data in tableView
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.loadAndRefreshDataFromService), for: .valueChanged)
        aboutTableView.addSubview(refreshControl)
        
        aboutTableView.register(AboutCanadaTableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifiers.aboutCanadaTableViewCell.rawValue)
        view.addSubview(aboutTableView)
    }
    
    /**
     Method that sets up the TableView's layout constraints.
     */
    func setTableViewConstraints() {
        aboutTableView.translatesAutoresizingMaskIntoConstraints = false
        aboutTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        aboutTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        aboutTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        aboutTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
}

extension AboutCanadaViewController {
    /**
     Method for adding activityIndicator for loading
     */
    func setupActivityIndicator() {
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: view.bounds.size.width/2-25, y: view.bounds.size.height/2-25, width: 50, height: 50))
        activityIndicator.type = . circleStrokeSpin
        activityIndicator.color = .darkGray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    /**
     Method for ending refresh after No internet alert is presented so that main thread should not be interupted.
     
     This method is called from Notification
     */
    @objc func endRefreshing(_ notification: NSNotification ) {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
            aboutCanadaArray = []
            self.aboutTableView.reloadData()
            self.aboutTableView.scrollsToTop = true
        }
    }
    
    /**
     Method to reload Cell after image is downloaded.
     
     This method is called from Notification
     */
    @objc func reloadCell(_ notification: NSNotification ) {
        if let notificationUserInfo = notification.userInfo {
            
            if let currentCell = notificationUserInfo[NotificationNames.userInfoKeyCell.rawValue] {
                guard let indexPath = self.aboutTableView.indexPath(for: (currentCell as? AboutCanadaTableViewCell)!) else {
                    // This is to make sure, cell to reload is still in visible rect
                    return
                }
                
                aboutTableView.reloadRows(at: [indexPath], with: .automatic)
                if let activityIndicator = activityIndicator {
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    /**
     Method for Calling for service to get data.
     
     - Parameter completionHandler: The Completion Handler that gets called after we have retrieved the data
     */
    func getDataFromService (completionHandler: @escaping CompletionHandler) {
        viewControllerPresenter.attachController(controller: self)
        WebServiceCallsManager.shared.getData(fromWebService: URLConstants.aboutCanada.rawValue, completionHandler: {[weak self] (status, rows, title) in
            if let weekSelf = self {
                weekSelf.viewControllerPresenter.detachController()
                if status {
                    if (rows?.count)! > 0 {
                        // Using Main thread to update the UI
                        DispatchQueue.main.async {
                            weekSelf.title = title
                        }
                        // Scenario if Data is Available.
                        completionHandler(status, rows, title)
                        
                    } else {
                        // Scenario if data is unvailable.
                        DispatchQueue.main.async {
                            weekSelf.refreshControl.endRefreshing()
                            let presenter = AlertPresenter()
                            presenter.displayAlert(inViewController: weekSelf, withTitle: ErrorsMessages.errorTitle.rawValue, andMessage: ErrorsMessages.noData.rawValue)
                            return
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        // Displaying Alert if service calls fails
                        weekSelf.refreshControl.endRefreshing()
                        let alertPresenter = AlertPresenter()
                        alertPresenter.displayAlert(inViewController: weekSelf, withTitle: ErrorsMessages.errorTitle.rawValue, andMessage: ErrorsMessages.somethingWentWrong.rawValue)
                        return
                    }
                }
            }
        })
        
    }
    
    /**
     Method for Calling for service to get data for table view.
     */
    @objc func loadAndRefreshDataFromService() {
        
        // Checking if internet connection is available.
        if (NetworkReachabilityManager()?.isReachable == false) {
            
            // Displaying Alert if No internet connection.
            let alertPresenter = AlertPresenter(
            )
            alertPresenter.displayAlert(inViewController: self, withTitle: ErrorsMessages.errorTitle.rawValue, andMessage: ErrorsMessages.noInternet.rawValue)
            return
            
        } else {
            _ = (activityIndicator != nil) ? activityIndicator.startAnimating() : setupActivityIndicator()
            
            self.refreshControl.beginRefreshing()
            self.getDataFromService { [weak self] (isSuccess, aboutCanadaArray, _) in
                if isSuccess {
                    guard let weakSelf = self else{
                        return
                    }
                    guard let aboutCanadaArray = aboutCanadaArray else{
                        return
                    }
                    weakSelf.aboutCanadaArray = aboutCanadaArray
                    
                    // Reloading TableView to update data received from service in table view
                    // Using Main thread to update the UI
                    
                    DispatchQueue.main.async {
                        
                        if let activityIndicator = weakSelf.activityIndicator {
                            activityIndicator.stopAnimating()
                        }
                        weakSelf.aboutTableView.reloadData()
                        weakSelf.refreshControl.endRefreshing()
                        weakSelf.aboutTableView.layoutSubviews()
                        weakSelf.aboutTableView.layoutIfNeeded()
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource Methods
extension AboutCanadaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutCanadaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aboutCanadaTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.aboutCanadaTableViewCell.rawValue, for: indexPath) as! AboutCanadaTableViewCell
        aboutCanadaTableViewCell.aboutCanada = self.aboutCanadaArray[indexPath.row]
        aboutCanadaTableViewCell.layoutSubviews()
        aboutCanadaTableViewCell.layoutIfNeeded()
        return aboutCanadaTableViewCell
    }
}

// MARK: - UITableViewDelegate Methods
extension AboutCanadaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
