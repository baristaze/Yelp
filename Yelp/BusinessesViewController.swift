//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, FilterDelegate {

    var businesses: [Business]!
    let defaultImage:UIImage? = UIImage(named: "yelpLogo.png")
    
    @IBOutlet var filterBarButton: UIBarButtonItem!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var bizTableView: UITableView!

    var searchText:String = ""
    var categories:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bizTableView.estimatedRowHeight = 110
        self.bizTableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = self.filterBarButton
        self.navigationItem.titleView = self.searchBar;
        self.searchBar.delegate = self
        self.searchBar.placeholder = searchText
        
        self.reloadBusinesses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadBusinesses() {
        
        var query = searchText.isEmpty ? "Restaurants" : searchText
        if(categories.isEmpty){
            
            Business.searchWithTerm(query) { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.bizTableView.reloadData()
            }
        }
        else {
            
            Business.searchWithTerm(query, sort: .Distance, categories: self.categories, deals: false) { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.bizTableView.reloadData()
            }
        }
    }
    
    func filter(filter: FilterViewController, didChangeValue distance: Float, categories: [String]) {
        
        self.categories = categories
        self.reloadBusinesses()
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
        cell.bizPhotoView.setImageWithURL(biz.imageURL, placeholderImage:defaultImage!)
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        
        self.searchText = searchText
        self.reloadBusinesses()
        if(!self.isFiltered()) {
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("endSearching"), userInfo: nil, repeats: false)
        }
    }
    
    func isFiltered() -> Bool {
        var searchText = self.searchBar.text
        return !searchText.isEmpty
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.endSearching()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.endSearching()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.endSearching()
    }
    
    func endSearching() {
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var navigationVC = segue.destinationViewController as! UINavigationController
        var vc = navigationVC.topViewController as! FilterViewController
        vc.delegate = self
    }
}
