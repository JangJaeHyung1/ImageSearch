//
//  DetailViewController.swift
//  SearchImage
//
//  Created by jh on 2021/02/19.
//

import UIKit
import RxCocoa
import RxSwift
import CoreGraphics
//import RxViewController

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var document: Document?
    
    static let identifier = "DetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false

        UIsetting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
                let imageViewRatio = (image?.size.height)! / (image?.size.width)!
                
               
                DispatchQueue.main.async {
                    
//                    print(image?.size.width,image?.size.height)
//                    print(self?.imageView.frame.size.width,self?.imageView.frame.size.height)
//                    print()
                    let scale = (self?.imageView.frame.size.width)! / (image?.size.width)!
                    let newImage = self?.resize(image: image!, scale: scale)
                    let newHeight = (self?.imageView.frame.width)! * imageViewRatio
                    self?.imageView.frame.size = CGSize(width: (self?.imageView.frame.width)!, height: newHeight)
                    self?.imageView.image = newImage
//                    print(newImage?.size.width,newImage?.size.height)
//                    print(self?.imageView.frame.size.width,self?.imageView.frame.size.height)
//                    print()
//                    print()
                }
            }
            catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    func resize(image: UIImage, scale: CGFloat) -> UIImage
    {
        let transform = CGAffineTransform(scaleX: scale, y: scale)
       let size = image.size.applying(transform)
       UIGraphicsBeginImageContext(size)
       image.draw(in: CGRect(origin: .zero, size: size))
       let resultImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
        return resultImage!
    }
    func timeDecode(_ date: Date) -> String{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 ss초 작성"
        
        return dateFormatter.string(from: date)

    }
    
}

