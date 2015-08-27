//
//  PhotosViewController.swift
//  instapair
//
//  Created by datdn1 on 8/27/15.
//  Copyright (c) 2015 ht. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    var photos:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyId = "bb96edf46d6940fdac2105ac1779296b"
        
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(keyId)")
        
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            let responseDic = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            self.photos = responseDic["data"] as! NSArray
            println(self.photos)
         
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
