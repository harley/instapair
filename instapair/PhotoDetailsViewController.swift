//
//  PhotoDetailsViewController.swift
//  instapair
//
//  Created by datdn1 on 8/27/15.
//  Copyright (c) 2015 ht. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var photoDetailTableView: UITableView!
    
    var photoDetailImage:UIImageView!
    var photoDict: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoDetailTableView.delegate = self
        self.photoDetailTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoDetailCell") as! PhotoDetailCell
//        cell.detailImageView.setImageWithURL(url)
        let url = NSURL(string: photoDict!.valueForKeyPath("images.standard_resolution.url") as! String)!
        cell.detailImageView.setImageWithURL(url)
        return cell
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
