//
//  PhotoDetailsViewController.swift
//  tumblr2
//
//  Created by Howard Aguilar on 2/5/20.
//  Copyright © 2020 Howard Aguilar. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var detailsImageView: UIImageView!
    var photosUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPhoto()
        

        // Do any additional setup after loading the view.
    }
    
    func downloadPhoto(){
        let url = URL(string: photosUrl)!
        detailsImageView.af_setImage(withURL: url)
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
