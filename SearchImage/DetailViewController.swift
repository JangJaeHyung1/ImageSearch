//
//  DetailViewController.swift
//  SearchImage
//
//  Created by jh on 2021/02/19.
//

import UIKit
import RxCocoa
import RxSwift
//import RxViewController

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var document: Document?
    
    static let identifier = "DetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        UIsetting()
    }
    
    
    func UIsetting(){
        let date = timeDecode(document!.datetime)
        self.lblSite.text = "이미지 출처 : " + document!.displaySitename
        self.lblDate.text = date
        
        DispatchQueue.global().async { [weak self] in
            guard let imageUrl = self?.document?.imageURL else {
                return
            }
            do {
                let url = URL(string: imageUrl)
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
            catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func timeDecode(_ date: Date) -> String{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 ss초 작성"
        
        return dateFormatter.string(from: date)

    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
