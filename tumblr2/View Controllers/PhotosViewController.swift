//
//  PhotosViewController.swift
//  tumblr2
//
//  Created by Howard Aguilar on 2/3/20.
//  Copyright © 2020 Howard Aguilar. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var photosTableView: UITableView!
    
    //property
    var posts: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad() //Not sure if okay here
        photosTableView.delegate = self
        photosTableView.dataSource = self
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              print(dataDictionary)

              // TODO: Get the posts and store in posts property
              // Get the dictionary from the response key
              let responseDictionary = dataDictionary["response"] as! [String: Any]
              // Store the returned array of dictionaries in our posts property
              self.posts = responseDictionary["posts"] as! [[String: Any]]
              // TODO: Reload the table view
              self.photosTableView.reloadData()
          }
        }
        task.resume()
        
        //super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        // 1.            // 2.          // 3.
        if let photos = post["photos"] as? [[String: Any]] {
             // photos is NOT nil, we can use it!
             // TODO: Get the photo url
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            cell.photoView.af_setImage(withURL: url!)
            
        }
        //cell.textLabel?.text = "This is row \(indexPath.row)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? PhotoDetailsViewController{
            let cell = sender as! UITableViewCell
            let indexPath = photosTableView.indexPath(for: cell)!
            let post = posts[indexPath.row]
            if let photos = post["photos"] as? [[String: Any]] {
                 // photos is NOT nil, we can use it!
                 // TODO: Get the photo url
                // 1.
                let photo = photos[0]
                // 2.
                let originalSize = photo["original_size"] as! [String: Any]
                // 3.
                let urlString = originalSize["url"] as! String
                // 4.
                vc.photosUrl = urlString
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
