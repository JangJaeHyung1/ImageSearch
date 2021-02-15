//
//  ViewController.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images: [Image] = []
    
    let cellIndentifier = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell:ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIndentifier, for: indexPath) as? ImageCollectionViewCell {
//            let image: Image = self.images[indexPath.item]
//
//            cell.cellImage.image = UIImage(contentsOfFile: image.documents[indexPath.row].thumbnailURL)
//
            return cell
        }
        return UICollectionViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        collectionCellUI()
        self.collectionView.reloadData()
    }


    func collectionCellUI(){
        let interval:CGFloat = 5
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: interval , left: interval, bottom: 0, right: interval)
        flowLayout.minimumInteritemSpacing = interval
        flowLayout.minimumLineSpacing = interval
        let width: CGFloat = ( UIScreen.main.bounds.width - interval) / 3
        flowLayout.itemSize = CGSize(width: width - interval, height: width - interval)
        //        flowLayout.estimatedItemSize = CGSize(width: 150, height: 110)
        self.collectionView.collectionViewLayout = flowLayout
    }
}

