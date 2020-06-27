//
//  PhotoCollectionViewCell.swift
//  PhotosChallenge
//
//  Created by Judith Lindemann on 26.06.20.
//  Copyright © 2020 Judith Lindemann. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        titleLabel.text = ""
        imageView.image = nil
    }
}
