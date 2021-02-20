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
    
    @IBOutlet weak var lblSearchFlag: UILabel!
    var disposeBag = DisposeBag()
    let viewModel = ImageListViewModel()
    let cellIndentifier = "cell"
    var emptySearchFlag = true

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.setupSearchController()

        collectionCellUI()
        
        //셀이 선택했을때 선택된 값을 showDetailViewImage(PublishRelay)에 넘겨준다.
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(Document.self))
            .bind{ [weak self] indexPath, model in
                self?.collectionView.deselectItem(at: indexPath, animated: true)
                self?.viewModel.showDetailViewImage.accept(model)
            }.disposed(by: disposeBag)
        
        //segue가 실행될때 showDetailViewImage(PublishRelay)의 값을 sender로 넘겨준다
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
                disposeBag = DisposeBag()
                viewModel.searchResult.accept([])
                
                viewModel.searchResult
                    .observe(on: MainScheduler.instance)
                    .bind(to: collectionView.rx.items(cellIdentifier: cellIndentifier, cellType: ImageCollectionViewCell.self)) { index, item, cell in
                        let data = try? Data(contentsOf: URL(string: item.thumbnailURL)!)
                        cell.cellImage.image = UIImage(data: data!)
                        cell.layer.cornerRadius = 2
                    }
                    .disposed(by: disposeBag)
            }
            else{

                viewModel.searchKeyword.accept(keyword)
            }
        }
        
        viewModel.searchFlag.accept(true)
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "검색할 키워드를 입력해 주세요."
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Daum 이미지 검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
}



