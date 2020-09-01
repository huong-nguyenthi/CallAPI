//
//  ViewController.swift
//  CallAPI
//
//  Created by Nguyen Thi Huong on 8/31/20.
//  Copyright © 2020 Nguyen Thi Huong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    @IBOutlet weak var loadMore: UIActivityIndicatorView!
    
    var data: [DataAttribute] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "loading")
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.tableView.addSubview(self.refreshControl)
        loadMore.isHidden = true
    }
    
    func getData() {
        loadMore.isHidden = false
        if  let url = URL(string: "http://demo0737597.mockable.io/master_data") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decorder = JSONDecoder()
                    do{
                        let parsedJSON = try decorder.decode(DataPeople.self, from: data)
                        self.data = parsedJSON.data
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.lblNoData.isHidden = !(self.data.count == 0)
                            if self.data.count != 0 {
                                self.lblNoData.isHidden = true
                            } else {
                                self.lblNoData.isHidden = false
                            }
                            self.loadMore.isHidden = true
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getData()
        tableView.reloadData()
        refreshControl.endRefreshing()
        print("scroll to top")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let index = data[indexPath.row]
        cell.setData(data: index)
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
            getData()
            self.data += self.data
            tableView.reloadData()
        }
    }
        
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
//            loadMoreData()
//        }
//    }
//
//    func loadMoreData() {
//        if !self.isLoading {
//            self.isLoading = true
//            DispatchQueue.global().async {
//                sleep(2)
//                DispatchQueue.main.async {
//                    //self.getData()
//                    print("hello kitty")
//                    self.tableView.reloadData()
//                    self.isLoading = false
//                }
//            }
//        }
//    }
    
}
