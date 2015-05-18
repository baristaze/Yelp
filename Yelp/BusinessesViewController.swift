//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource {

    var businesses: [Business]!
    
    @IBOutlet weak var bizTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bizTableView.estimatedRowHeight = 110
        self.bizTableView.rowHeight = UITableViewAutomaticDimension
        
//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//        })
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.bizTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses?.count ?? 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let biz = self.businesses[indexPath.row]
        let cell = self.bizTableView.dequeueReusableCellWithIdentifier("yelp.biz.cell", forIndexPath: indexPath) as! BizTableCell
        cell.bizNameLabel.text = biz.name
        cell.addressLabel.text = biz.address
        cell.categoriesLabel.text = biz.categories
        cell.imageView?.setImageWithURL(biz.imageURL)
        cell.ratingImageView.setImageWithURL(biz.ratingImageURL)
        
        if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
            cell.preservesSuperviewLayoutMargins = false
        }
        if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
            cell.separatorInset = UIEdgeInsetsMake(0, 4, 0, 0)
        }
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 79;
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
