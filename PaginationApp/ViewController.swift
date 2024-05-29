//
//  ViewController.swift
//  PaginationApp
//
//  Created by Kamal Kumar on 29/05/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var posts = [Post]()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "Posts"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchPosts()
    }
    
    func fetchPosts() {
        guard !isLoading else { return }
        isLoading = true
        NetworkManager.shared.fetchPosts { [weak self] newPosts, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch posts: \(error)")
                    self?.isLoading = false
                    return
                }
                
                if let newPosts = newPosts {
                    self?.posts.append(contentsOf: newPosts)
                    self?.tableView.reloadData()
                }
                self?.isLoading = false
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.id): \(post.title)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
            fetchPosts()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.post = posts[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
