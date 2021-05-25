//
//  UserViewController.swift
//  TestSimpleAppDOT
//
//  Created by Sayyid Maulana Khakul Yakin on 25/05/21.
//

import UIKit

class UserViewController: UITableViewController {

    let reuseIndentifier = "cell"
    
    var filteredTableData = [ItemUsers]()
    var resultSearchController = UISearchController()
    
    var usersList : [ItemUsers] = []
    
    var spinner = UIActivityIndicatorView(style: .large)
        
    lazy var titleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Catalouge"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.tag = 0
        $0.addArrangedSubview(titleLabel)
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "List of the Users"
        subtitleLabel.font = UIFont.italicSystemFont(ofSize: 10)
        subtitleLabel.tag = 1
        $0.addArrangedSubview(subtitleLabel)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }(UIStackView())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupView()
        checkUsers()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeThatFits(CGSize(width: CGFloat(self.view.frame.size.width - 50), height: 50.0))
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.tableView.reloadData()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserViewCell.self, forCellReuseIdentifier: reuseIndentifier)
        
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.setAnchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 80, paddingLeft: 160, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        
        navigationItem.titleView = titleStackView
    }
    
    private func checkUsers() {
        
        self.spinner.isHidden = false
        
        let myUrl = URL(string: users)
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                
                
                let JSONData = try JSONDecoder().decode(User.self, from: data)
                
                self.usersList = JSONData.items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                    self.spinner.isHidden = true
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath) as! UserViewCell
        
        if (resultSearchController.isActive) {
            guard let thumb = usersList[indexPath.row].avatarURL else { return UITableViewCell() }
            cell.img.loadImage(using: thumb)
            
            cell.label.text = "The ID:\n\(usersList[indexPath.row].id ?? 0)"
            cell.labelLogin.text = usersList[indexPath.item].login
            return cell
        } else {
            guard let thumb = usersList[indexPath.row].avatarURL else { return UITableViewCell() }
            cell.img.loadImage(using: thumb)
            
            cell.label.text = "The ID:\n\(usersList[indexPath.row].id ?? 0)"
            cell.labelLogin.text = usersList[indexPath.item].login
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return usersList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension UserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        var temp : [ItemUsers] = []
        for i in 0 ..< usersList.count{
            if ((usersList[i].login?.lowercased().contains(searchController.searchBar.text!.lowercased()) ) ?? false) {
                temp.append(usersList[i])
            }
        }
        self.filteredTableData = temp
        self.tableView.reloadData()
    }

}
