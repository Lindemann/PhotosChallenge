//
//  DetailViewController.swift
//  PhotosChallenge
//
//  Created by Judith Lindemann on 26.06.20.
//  Copyright © 2020 Judith Lindemann. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var photo: Photo? {
        didSet {
            imageView.kf.setImage(with: photo?.url)
        }
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            closeButton.tintColor = .white
        } else {
            view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            closeButton.tintColor = .black
        }
    }
}
