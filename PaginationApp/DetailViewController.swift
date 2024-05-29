//
//  DetailViewController.swift
//  PaginationApp
//
//  Created by Kamal Kumar on 29/05/24.
//

import UIKit

class DetailViewController: UIViewController {

    var post: Post?
    var computedResultsCache = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.title = "Post Details"
        
        if let post = post {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "ID: \(post.id)\nTitle: \(post.title)\n\nBody:\n\(post.body)"
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            performHeavyComputation(for: post) { computedDetail in
                label.text? += "\n\n\(computedDetail)"
            }
        }
    }
    

    func performHeavyComputation(for post: Post, completion: @escaping (String) -> Void) {
        if let cachedResult = computedResultsCache[post.id] {
            completion(cachedResult)
            return
        }
        
        DispatchQueue.global().async {
            let startTime = CFAbsoluteTimeGetCurrent()
            
            // Simulating heavy computation
            let computedDetail = "Computed Detail for Post ID \(post.id)"
            
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("Time taken for heavy computation: \(timeElapsed) seconds")
            
            DispatchQueue.main.async {
                self.computedResultsCache[post.id] = computedDetail
                completion(computedDetail)
            }
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
