//
//  IssueViewController.swift
//  TestSimpleAppDOT
//
//  Created by Sayyid Maulana Khakul Yakin on 25/05/21.
//

import UIKit

class IssueViewController: UITableViewController {

    let reuseIndentifier = "cell"
    
    var issuesList : [ItemIssues] = []
    
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
        subtitleLabel.text = "List of the Issues"
        subtitleLabel.font = UIFont.italicSystemFont(ofSize: 10)
        subtitleLabel.tag = 1
        $0.addArrangedSubview(subtitleLabel)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupView()
        checkRepo()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IssueViewCell.self, forCellReuseIdentifier: reuseIndentifier)
        
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.setAnchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 80, paddingLeft: 160, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        
        navigationItem.titleView = titleStackView
    }
    
    private func checkRepo() {
        
        self.spinner.isHidden = false
        
        let myUrl = URL(string: repo)
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                
                
                let JSONData = try JSONDecoder().decode(Issues.self, from: data)
                
                self.issuesList = JSONData.items
                
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath) as! IssueViewCell
        cell.label.text = "Judul:\(issuesList[indexPath.item].title)\nJumlah komen: \(issuesList[indexPath.row].comments)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issuesList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
