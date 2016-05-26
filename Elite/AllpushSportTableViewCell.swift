//
//  AllpushSportTableViewCell.swift
//  Elite
//
//  Created by Jerry on 16/4/17.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class AllpushSportTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var SportTime:UILabel?
    var SportPlace:UILabel?
    var More:UILabel?
    var sendTime:UILabel?
    var SportTitle:UILabel?
    
    var cover:UIImageView?
    var VIEW_WIDTH : CGFloat!
    var VIEW_HEIGHT : CGFloat!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.VIEW_WIDTH = frame.size.width
        self.VIEW_HEIGHT = frame.size.height
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        self.backgroundView?.backgroundColor = selfsetColor
        self.SportTitle = UILabel(frame: CGRectMake(78,8,self.VIEW_WIDTH,25))
        self.SportTime = UILabel(frame: CGRectMake(78,38,242,25))
        self.SportPlace = UILabel(frame: CGRectMake(78,65,242,25))
        self.More = UILabel(frame: CGRectMake(78,80,242,25))
        self.sendTime = UILabel(frame: CGRectMake(SCREEN_WIDTH - 78 - 20,80,242,25))
        
        self.SportPlace?.font = UIFont(name: MY_FONT, size: 15)
        self.SportTime?.font = UIFont(name: MY_FONT, size: 15)
        self.SportTitle?.font = UIFont(name: MY_FONT, size: 18)
        self.SportTitle?.textColor = MAIN_RED
        self.More?.font = UIFont(name: MY_FONT, size: 10)
        self.More?.textColor = UIColor.grayColor()
        
        self.sendTime?.font = UIFont(name: MY_FONT, size: 10)
        self.sendTime?.textColor = UIColor.grayColor()
        
        self.contentView.addSubview(self.SportTime!)
        self.contentView.addSubview(self.SportPlace!)
        self.contentView.addSubview(self.More!)
        self.contentView.addSubview(self.sendTime!)
        self.contentView.addSubview(self.SportTitle!)
        
        self.cover = UIImageView(frame: CGRectMake(8, 9, 60, 80))
        self.contentView.addSubview(self.cover!)
        
        
        
 
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
