//
//  ViewController.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var disposeBag = DisposeBag()
    let viewModel = ImageListViewModel()
    let cellIndentifier = "cell"
    
    var isSearching: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupSearchController()

        collectionCellUI()
        
        viewModel.searchResult
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: cellIndentifier, cellType: ImageCollectionViewCell.self)) { index, item, cell in
                let data = try? Data(contentsOf: URL(string: item.thumbnailURL)!)
                cell.cellImage.image = UIImage(data: data!)
                cell.layer.cornerRadius = 2
            }
            .disposed(by: disposeBag)
    }

    
}
extension ViewController: UICollectionViewDelegateFlowLayout, UISearchResultsUpdating{
    
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
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let keyword = searchController.searchBar.text{
            viewModel.searchKeyword.accept(keyword)
        }
        
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색할 키워드를 입력해 주세요."
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Daum 이미지 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
