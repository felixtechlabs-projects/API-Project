//
//  ViewController.swift
//  JSONParsing
//
//  Created by Sneahaal on 11/08/25.
//

import UIKit

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    var postArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        print("Testing purpose")
    }
    
    
    func fetchData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                self.postArray = try JSONDecoder().decode([Post].self, from: data!)
                DispatchQueue.main.async {
                    self.postTableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let obj = postArray[indexPath.row]
        cell?.textLabel?.text = obj.title
        cell?.detailTextLabel?.text = obj.body
        return cell!
    }
}
