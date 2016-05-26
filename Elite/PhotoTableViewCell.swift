//
//  PhotoTableViewCell.swift
//  Elite
//
//  Created by Jerry on 16/5/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var touxiang:UIImageView?
    var editorName:UILabel?
    var texifield:UILabel?
    var photo:UIImageView?
    var sendtime:UILabel?
    var VIEW_WIDTH : CGFloat!
    var VIEW_HEIGHT : CGFloat!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.VIEW_WIDTH = frame.size.width
        self.VIEW_HEIGHT = frame.size.height
        
        self.touxiang = UIImageView(frame: CGRectMake(40,10,50,50))
        self.touxiang?.layer.cornerRadius = 25
        self.touxiang?.layer.masksToBounds = true
        self.touxiang?.clipsToBounds = true
        self.contentView.addSubview(self.touxiang!)
        
        self.editorName = UILabel(frame: CGRectMake(110,15,100,20))
        self.editorName?.font = UIFont(name: MY_FONT, size: 18)
        self.editorName?.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.editorName!)
        
        self.sendtime = UILabel(frame: CGRectMake(110,50,100,20))
        self.sendtime?.textColor = UIColor.grayColor()
        self.sendtime?.font = UIFont(name: MY_FONT, size: 10)
        self.contentView.addSubview(self.sendtime!)
        
        
        self.photo = UIImageView(frame: CGRectMake(40,80,SCREEN_WIDTH - 80,SCREEN_WIDTH - 80))
        self.contentView.addSubview(self.photo!)
        
        //let heightsize = self.VIEW_HEIGHT - 10 - 50 - (SCREEN_WIDTH - 80) - 80
        
        self.texifield = UILabel(frame: CGRectMake(40,SCREEN_WIDTH,SCREEN_WIDTH - 80,80))
        self.texifield?.font = UIFont(name: MY_FONT, size: 15)
        self.texifield?.textColor = UIColor.grayColor()
        self.texifield?.numberOfLines = 0
        self.texifield?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.contentView.addSubview(self.texifield!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
