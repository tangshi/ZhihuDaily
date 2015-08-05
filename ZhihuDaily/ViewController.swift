//
//  ViewController.swift
//  ZhihuDaily
//
//  Created by tangshi on 15/8/4.
//  Copyright © 2015年 tangshi. All rights reserved.
//

import UIKit
import Alamofire

class DailyViewController: UITableViewController {
    
    var latestNews: News?
    
    var contentViewController = NewsContentViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.reuseIdentifier)
        
        tableView.rowHeight = 70
        
        let url_string = "http://news-at.zhihu.com/api/4/news/latest"
        
        Alamofire.request(.GET, url_string).responseJSON { (_, _, result) -> Void in
            if let obj = result.value {
                let dict = obj as! NSDictionary
                self.latestNews = News(dict: dict)
                self.tableView.reloadData()
            }
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
        
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return latestNews?.stories.count ?? 0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerLabel = UILabel()
            headerLabel.text = "今日要闻"
            headerLabel.backgroundColor = UIColor.whiteColor()
            headerLabel.font = UIFont.systemFontOfSize(12)
            headerLabel.textAlignment = .Center
            headerLabel.textColor = UIColor.grayColor()
            
            return headerLabel
        }
        else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NewsCell.reuseIdentifier, forIndexPath: indexPath) as! NewsCell
        
        if let story = latestNews?.stories[indexPath.row] {
            cell.newsTitle.text = story.title
            
            if story.images.count > 0 {
                let image_url = story.images[0]

                Alamofire.request(.GET, image_url).response(completionHandler: { (_, _, data, _) -> Void in
                    if let imagedata = data {
                        let image = UIImage(data: imagedata)
                        cell.newsImage.image = image
                    }
                })
            }
            
            if story.multipic {
                cell.morepicImage.image = UIImage(named: "Home_Morepic")
            }
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 点击cell跳转到日报内容页面
        contentViewController.news_id = latestNews?.stories[indexPath.row].id
        contentViewController.loadData()
        self.navigationController?.pushViewController(contentViewController, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

