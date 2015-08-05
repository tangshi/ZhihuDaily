//
//  NewsContentViewController.swift
//  ZhihuDaily
//
//  Created by tangshi on 15/8/5.
//  Copyright © 2015年 tangshi. All rights reserved.
//

import UIKit
import Alamofire

class NewsContentViewController: UIViewController {

    
    @IBOutlet weak var webview: UIWebView!
    
    let base_url_str = "http://news-at.zhihu.com/api/5/news/"
    var news_id: Int?
    var newsContent: NewsContent?
    
    var topImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadData() {
        if news_id == nil {
            print("error: news id lost", appendNewline: true)
            return
        }
        
        let url = base_url_str + "\(news_id!)"
        
        Alamofire.request(.GET, url).responseJSON { (_, _, result) -> Void in
            if let obj = result.value {
                let dict = obj as! NSDictionary
                self.newsContent = NewsContent(dict: dict)
                
                Alamofire.request(.GET, self.newsContent!.image).response(completionHandler: { (_, _, data, _) -> Void in
                    let image = UIImage(data: data!)
                    self.topImage.image = image
                    let width = UIScreen.mainScreen().bounds.width
                    // 根据css中的内容得知顶部图片的高度为200像素
                    self.topImage.frame = CGRect(x: 0, y: 0, width: width, height: 200)
                    self.topImage.contentMode = .ScaleAspectFill
                    // 裁剪超出视图的部分
                    self.topImage.clipsToBounds = true
                    self.webview.scrollView.addSubview(self.topImage)
                })
                
                self.webview.loadHTMLString(self.newsContent!.body, baseURL: nil)
            }
            else {
                print("load data error", appendNewline: true)
            }
        }
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
