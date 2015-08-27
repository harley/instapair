//
//  PhotosViewController.swift
//  instapair
//
//  Created by datdn1 on 8/27/15.
//  Copyright (c) 2015 ht. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var refreshControl:UIRefreshControl!
    var photos: [NSDictionary]?
    var feedUrl: NSURL?
    var feedRequest: NSURLRequest?
    
    @IBOutlet weak var photosTableView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
        
        let photo = photos![indexPath.row] as NSDictionary
        
//        println(photo)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        photosTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyId = "bb96edf46d6940fdac2105ac1779296b"
        
        self.feedUrl = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(keyId)")!
        self.feedRequest = NSURLRequest(URL: feedUrl!)
        
        self.photosTableView.delegate = self
        self.photosTableView.dataSource = self
        
        loadPhotos()
        
        photosTableView.rowHeight = 320
        // Do any additional setup after loading the view.
        
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        self.photosTableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadPhotos(refreshing: Bool = false) {
        NSURLConnection.sendAsynchronousRequest(feedRequest!, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            let responseDic = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            self.photos = responseDic["data"] as? [NSDictionary]
            //            println(self.photos)
            self.photosTableView.reloadData()
            
            if refreshing {
                self.refreshControl.endRefreshing()
            }
        }

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        
        var indexPath = photosTableView.indexPathForCell(sender as! PhotoCell)
        
        let photo = photos![indexPath!.row] as NSDictionary
        
//        let url = NSURL(string: photo.valueForKeyPath("images.standard_resolution.url") as! String)!
        
        vc.photoDict = photo
    }

    func refresh(sender: AnyObject) {
//        println(sender)
        loadPhotos(refreshing: true)
    }

}
