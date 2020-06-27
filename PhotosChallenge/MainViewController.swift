//
//  ViewController.swift
//  PhotosChallenge
//
//  Created by Judith Lindemann on 26.06.20.
//  Copyright © 2020 Judith Lindemann. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [Photo]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        pullToRefresh()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: PhotoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self))
    }
    
    private func pullToRefresh() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl // iOS 10+
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        loadJSON()
        refreshControl.endRefreshing()
        
    }
    
    private func loadJSON() {
        APIService().loadJSON { [weak self] result in
            switch result {
            case .failure(let error):
                print("😡 \(error)")
            case .success(let photos):
                self?.photos = photos
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
        cell.titleLabel.text = photos[indexPath.row].title
        cell.albumLabel.text = "Album \(photos[indexPath.row].albumId)"
        cell.imageView.kf.setImage(with: photos[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as!DetailViewController
        present(detailViewController, animated: true) { [weak self] in
            detailViewController.photo = self?.photos[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
 
