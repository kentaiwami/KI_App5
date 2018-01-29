//
//  SocialByAgeCell.swift
//  FiNote
//
//  Created by 岩見建汰 on 2018/01/29.
//  Copyright © 2018年 Kenta. All rights reserved.
//

import UIKit

class SocialByAgeCell: UICollectionViewCell {
    var user_count : UILabel!
    var poster: UIImageView!
    var users_icon: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        poster = UIImageView(frame: CGRect.zero)
        poster.image = UIImage(named: "no_image")
        
        users_icon = UIImageView(frame: CGRect.zero)
        users_icon.image = UIImage(named: "icon_users")
        users_icon.image = users_icon.image!.withRenderingMode(.alwaysTemplate)
        users_icon.tintColor = UIColor.hex(Color.gray.rawValue, alpha: 1.0)
        
        user_count = UILabel(frame: CGRect.zero)
        user_count.font = UIFont.systemFont(ofSize: 14)
        user_count.textColor = UIColor.hex(Color.gray.rawValue, alpha: 1.0)
        
        contentView.addSubview(poster)
        contentView.addSubview(user_count)
        contentView.addSubview(users_icon)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let icon_wh = 20 as CGFloat
        let ratio = 1.5 as CGFloat

        poster.centerX(to: contentView)
        poster.top(to: contentView)
        poster.width(contentView.frame.width/ratio)
        poster.height(contentView.frame.height/ratio)
        
        users_icon.bottom(to: contentView, offset: -5)
        users_icon.centerX(to: contentView)
        users_icon.width(icon_wh)
        users_icon.height(icon_wh)
        
        user_count.leadingToTrailing(of: users_icon, offset: 10)
        user_count.centerY(to: users_icon)
    }
}