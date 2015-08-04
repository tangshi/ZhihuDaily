//
//  NewsCell.swift
//  知乎日报
//
//  Created by tangshi on 15/7/24.
//  Copyright © 2015年 tangshi. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsTitle: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
  
    @IBOutlet weak var morepicImage: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var reuseIdentifier: String {
        return "ZhihuDailyCell"
    }
    
}
