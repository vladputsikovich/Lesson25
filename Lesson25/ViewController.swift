//
//  ViewController.swift
//  Lesson25
//
//  Created by Владислав Пуцыкович on 26.01.22.
//

import UIKit


fileprivate struct Constants {
    static let identificator = "cell"
    static let sections: [String] = ["PDF", "Sites"]
    static let urls: [String] = [
        "https://www.apple.com",
        "https://www.google.com",
        "https://www.yandex.by",
        "https://www.yahoo.com"
    ]
    static let pdfs: [String] = [
        "ticket.pdf",
        "ticket.pdf",
        "ticket.pdf",
        "ticket.pdf"
    ]
}

class ViewController: UIViewController {

    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
    }
    
    func createTable() {
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}

// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.pdfs.count
        case 1:
            return Constants.urls.count
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: Constants.identificator
        )
        cell.textLabel?.text =  indexPath.section == 0
                        ? Constants.pdfs[indexPath.item]
                        : Constants.urls[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sections.count
    }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SiteController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.title = indexPath.section == 0
                        ? Constants.pdfs[indexPath.item]
                        : Constants.urls[indexPath.item]
        controller.urlString = indexPath.section == 0
                        ? Constants.pdfs[indexPath.item]
                        : Constants.urls[indexPath.item]
        
        present(navigationController, animated: true, completion: nil)
    }
}
