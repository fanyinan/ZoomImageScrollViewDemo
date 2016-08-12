//
//  VisitedMeCollectionViewCell.swift
//  MuMu
//
//  Created by 范祎楠 on 15/7/17.
//  Copyright © 2015年 juxin. All rights reserved.
//

import UIKit

class VisitedMeCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    avatarImageView.contentMode = UIViewContentMode.ScaleAspectFill

  }
}
