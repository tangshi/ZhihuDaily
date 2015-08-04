//
//  Models.swift
//  知乎日报
//
//  Created by tangshi on 15/7/25.
//  Copyright © 2015年 tangshi. All rights reserved.
//

import Foundation

struct Story {
    var id: Int
    var title: String
    var images: [String] = [String]()
    var type: Int
    var ga_prefix: String
    var multipic: Bool
    
    init(dict: NSDictionary) {
        
        title = dict.objectForKey("title") as! String
        id = dict.objectForKey("id") as! Int
        type = dict.objectForKey("type") as! Int
        ga_prefix = dict.objectForKey("ga_prefix") as! String
        
        if let images_arr = dict.objectForKey("images") as? NSArray {
            for image_str in images_arr {
                images.append(image_str as! String)
            }
        }
        
        if let _ = dict.objectForKey("multipic") {
            multipic = true
        }
        else {
            multipic = false
        }
    }
}

struct News {
    var date: String
    var stories = [Story]()
    var top_stories = [Story]()
    
    init(dict: NSDictionary) {

        date = dict.objectForKey("date") as! String
        
        let stories_arr = dict.objectForKey("stories") as! NSArray
        for story_dict in stories_arr {
            let story = Story(dict: story_dict as! NSDictionary)
            stories.append(story)
        }
        
        let top_stories_arr = dict.objectForKey("top_stories") as! NSArray
        for top_story_dict in top_stories_arr {
            let top_story = Story(dict: top_story_dict as! NSDictionary)
            top_stories.append(top_story)
        }

    }
}

struct Section {
    var thumbnail: String      // 栏目的缩略图
    var id: Int                // 该栏目的 id
    var name: String           // 该栏目的名称
}
struct NewsContent {
    var body: String           // HTML 格式的新闻
    var image_source: String   // 图片的内容提供方。避免被起诉非法使用图片，显示图片时附上版权信息。
    var title: String          // 新闻标题
    var share_url: String      // 供在线查看内容与分享至 SNS 用的 URL
    var js: String             // 供手机端的 WebView(UIWebView) 使用
    var recommanders: String   // 这篇文章的推荐者
    var ga_prefix: String      // 供 Google Analytics 使用
    var section: Section       // 栏目的信息
    var type: Int              // 新闻的类型，作用未知
    var id: Int                // 新闻的 id
    var css: String            // 供手机端的 WebView(UIWebView) 使用
}