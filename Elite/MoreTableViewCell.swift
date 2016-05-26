//
//  MoreTableViewCell.swift
//  Elite
//
//  Created by Jerry on 16/4/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var UserName:UILabel?
    var UserPhoto:UIImageView?
    var UserEmail:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        self.UserPhoto = UIImageView(frame: CGRectMake(8, 9, 70, 80))
        self.contentView.addSubview(self.UserPhoto!)
        
        self.UserName = UILabel(frame: CGRectMake(100,20,242,25))
        self.UserName?.font = UIFont(name: MY_FONT, size: 18)
        self.UserName?.textColor = MAIN_RED
        self.contentView.addSubview(self.UserName!)
        
        self.UserEmail = UILabel(frame: CGRectMake(100,60,242,25))
        self.UserEmail?.font = UIFont(descriptor: UIFontDescriptor(), size: 12)
        self.UserEmail?.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.UserEmail!)
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
