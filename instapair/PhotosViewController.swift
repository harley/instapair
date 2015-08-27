//
//  PhotosViewController.swift
//  instapair
//
//  Created by datdn1 on 8/27/15.
//  Copyright (c) 2015 ht. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var photos: [NSDictionary]?
    
    @IBOutlet weak var photosTableView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
        
        let photo = photos![indexPath.row] as NSDictionary
        
        println(photo)
        let url = NSURL(string: photo.valueForKeyPath("images.low_resolution.url") as! String)!
        cell.photoImageView.setImageWithURL(url)
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        } else {
            return 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyId = "bb96edf46d6940fdac2105ac1779296b"
        
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(keyId)")
        
        let request = NSURLRequest(URL: url!)
        
        self.photosTableView.delegate = self
        self.photosTableView.dataSource = self
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            let responseDic = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            self.photos = responseDic["data"] as? [NSDictionary]
//            println(self.photos)
            self.photosTableView.reloadData()
            
         
        }
        photosTableView.rowHeight = 320
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
