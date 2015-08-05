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
        
        if dict.objectForKey("multipic") != nil {
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
    var thumbnail: String  // 栏目的缩略图
    var id: Int            // 该栏目的 id
    var name: String       // 该栏目的名称
    
    init(dict: NSDictionary) {
        thumbnail = dict["thumbnail"] as! String
        id = dict["id"] as! Int
        name = dict["name"] as! String
    }
}

struct NewsContent {
    var body: String                 // HTML 格式的新闻
    var image_source: String         // 图片的内容提供方。避免被起诉非法使用图片，显示图片时附上版权信息。
    var image: String                // 在文章浏览界面中使用的大图。
    var title: String                // 新闻标题
    var share_url: String            // 供在线查看内容与分享至 SNS 用的 URL
    var js: [String]                 // 供手机端的 WebView(UIWebView) 使用
    var ga_prefix: String            // 供 Google Analytics 使用
    var section: Section?            // 栏目的信息
    var type: Int                    // 新闻的类型，作用未知
    var id: Int                      // 新闻的 id
    var css: [String]                // 供手机端的 WebView(UIWebView) 使用
    
    init(dict: NSDictionary) {
        body = dict["body"] as! String
        image_source = dict["image_source"] as! String
        image = dict["image"] as! String
        title = dict["title"] as! String
        share_url = dict["share_url"] as! String
        ga_prefix = dict["ga_prefix"] as! String
        type = dict["type"] as! Int
        id = dict["id"] as! Int
        
        if let section_dict = dict["section"] as? NSDictionary {
            section = Section(dict: section_dict)
        }
        
        js = [String]()
        if let js_arr = dict["js"] as? NSArray {
            for js_str in js_arr {
                js.append(js_str as! String)
            }
        }

        css = [String]()
        if let css_arr = dict["css"] as? NSArray {
            for css_str in css_arr {
                css.append(css_str as! String)
            }
            let css_url = css[0]
            body = "<link href='\(css_url)' rel='stylesheet' type='text/css' />\(body)"
        }
    }
}