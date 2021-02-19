//
//  ViewController.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import UIKit
import RxSwift
import RxCocoa
//import RxViewController


class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lblSearchFlag: UILabel!
    var disposeBag = DisposeBag()
    let viewModel = ImageListViewModel()
    let cellIndentifier = "cell"
    var emptySearchFlag = true
    
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
        
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(Document.self))
            .bind{ [weak self] indexPath, model in
                self?.collectionView.deselectItem(at: indexPath, animated: true)
                self?.viewModel.showDetailViewImage.accept(model)
            }.disposed(by: disposeBag)
        
        viewModel.showDetailViewImage
            .subscribe(onNext: { [weak self] document in
                self?.performSegue(withIdentifier: DetailViewController.identifier,
                                   sender: document)
            })
            .disposed(by: disposeBag)
        
        viewModel.searchFlag
            .bind(to: lblSearchFlag.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == DetailViewController.identifier {
            let vc = segue.destination as? DetailViewController
            if let document = sender as? Document{
                vc?.document = document
//                vc?.date = timeDecode(document.datetime)
//                vc?.imageUrl = document.imageURL
//                vc?.site = document.displaySitename
//                print(document)
            }

        }
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
            if keyword.count == 0{
                viewModel.searchResult.accept([])
            }
            else{
                viewModel.searchKeyword.accept(keyword)
            }
        }
        viewModel.searchFlag.accept(true)
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



