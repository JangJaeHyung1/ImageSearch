//
//  ImageData.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import Foundation
import RxSwift
import RxRelay

class ImageListViewModel {
    var imagesObservable = BehaviorRelay<[Document]>(value: [])
    var searchKeyword = BehaviorSubject<String>(value: " ")
//    var searchKeyword:String = ""
    
    func fetchRequset(searchKeyword: BehaviorSubject<String>) {
                    _ = RequsetAPI.fetchImagesRx(searchKeyword)
                        .map { data -> [Document] in
                            struct Response: Decodable {
                                var meta: Meta
                                var documents: [Document]
                                //JSON 데이터의 배열이름과 동일해야 함
                            }
                            if let response = try? JSONDecoder().decode(Response.self, from: data){
//                                print("json")
//                                print(response.documents)
                                return response.documents
                            }
//                            searchKeyword.subscribe{print($0)}.disposed(by: DisposeBag())
//                            print(response.documents)
                            return []
                        }
//                        .take(1)
//                        .observe(on: MainScheduler.instance)
                        .bind(to: imagesObservable)
//                        .disposed(by: DisposeBag())
    }
}
