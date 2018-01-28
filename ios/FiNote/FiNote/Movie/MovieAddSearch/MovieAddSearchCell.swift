//
//  MovieAddSearchCell.swift
//  FiNote
//
//  Created by 岩見建汰 on 2018/01/27.
//  Copyright © 2018年 Kenta. All rights reserved.
//

import UIKit

class MovieAddSearchCell: UITableViewCell {
    var title: UILabel!
    var overview: UILabel!
    var poster: UIImageView!
    var release_date: UILabel!
    var release_date_icon: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title = UILabel(frame: CGRect.zero)
        title.textAlignment = .left
        title.lineBreakMode = .byTruncatingTail
        title.font = UIFont.systemFont(ofSize: 18)
        
        overview = UILabel(frame: CGRect.zero)
        overview.textAlignment = .left
        overview.lineBreakMode = .byTruncatingTail
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 14)
        
        release_date = UILabel(frame: CGRect.zero)
        release_date.textAlignment = .left
        release_date.lineBreakMode = .byWordWrapping
        release_date.font = UIFont.systemFont(ofSize: 14)
        release_date.textColor = UIColor.hex(Color.gray.rawValue, alpha: 1.0)
        
        release_date_icon = UIImageView(frame: CGRect.zero)
        release_date_icon.image = UIImage(named: "tab_movies")
        release_date_icon.image = release_date_icon.image!.withRenderingMode(.alwaysTemplate)
        release_date_icon.tintColor = UIColor.hex(Color.gray.rawValue, alpha: 1.0)
        
        contentView.addSubview(title)
        contentView.addSubview(overview)
        contentView.addSubview(release_date)
        contentView.addSubview(release_date_icon)
        
        poster = UIImageView()
        contentView.addSubview(poster)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let icon_wh = 20 as CGFloat
        
        poster.frame = CGRect(x: 0, y: 0, width: contentView.frame.height/1.5, height: contentView.frame.height)
        
        title.trailing(to: contentView)
        title.leadingToTrailing(of: poster, offset: 20)
        title.top(to: contentView, offset: 5)
        
        overview.trailing(to: contentView)
        overview.topToBottom(of: title, offset: 2)
        overview.leadingToTrailing(of: poster, offset: 20)
        overview.bottom(to: contentView, offset: -25)
        
        release_date_icon.leadingToTrailing(of: poster, offset: 20)
        release_date_icon.bottom(to: contentView, offset: -5)
        release_date_icon.width(icon_wh)
        release_date_icon.height(icon_wh)
        
        release_date.leadingToTrailing(of: release_date_icon, offset: 5)
        release_date.centerY(to: release_date_icon, offset: 1)
    }

}