//
//  GifCell.swift
//  Dispo Take Home
//
//  Created by Neel Kumar on 5/1/21.
//

import UIKit
import SnapKit

class GifCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()

    let gifLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "gif title"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        contentView.addSubview(gifLbl)
        
        gifLbl.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(20)
            make.centerY.equalTo(contentView)
        }
    }
    // prevent data appearing in wrong cell
    override func prepareForReuse() {
        self.imageView.image = nil
//        self.gifLbl.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
