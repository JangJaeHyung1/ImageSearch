//
//  ViewController.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var disposeBag = DisposeBag()
    let viewModel = ImageListViewModel()
    
    let cellIndentifier = "cell"
    
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
//        return viewModel.images.count
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIndentifier, for: indexPath) as! ImageCollectionViewCell
//        let image = viewModel.images[indexPath.row]
//
//            fetchImages("hi")
//
//            RequsetAPI.fetchImages("hi", onComplete: (Result<Data, Error>) -> Void)
//
//            let image: Image = self.images[indexPath.item]
//
//            cell.cellImage.image = UIImage(contentsOfFile: image.documents[indexPath.row].thumbnailURL)
//
//            return cell
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupSearchController()

        collectionCellUI()
        
        viewModel.imagesObservable
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: cellIndentifier, cellType: ImageCollectionViewCell.self)) { index, item, cell in
                let data = try? Data(contentsOf: URL(string: item.thumbnailURL)!)
                cell.cellImage.image = UIImage(data: data!)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색할 키워드를 입력해 주세요."
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Daum 이미지 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = false

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
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.reloadData()
    }
}

