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
    var searchResult = BehaviorRelay<[Document]>(value: [])
    var searchKeyword = BehaviorRelay<String>(value: " ")
    
    init (){
        searchKeyword.debounce(.seconds(1), scheduler: MainScheduler.instance).flatMap( fetchRequest ).subscribe(onNext:{ self.searchResult.accept($0) })
    }
    
    func fetchRequest(_ keyword: String) -> Observable<[Document]>{
        return RequsetAPI.fetchImagesRx(keyword).map { data -> [Document] in
            struct Response: Decodable {
                var meta: Meta
                var documents: [Document]
            }
            if let response = try? JSONDecoder().decode(Response.self, from: data){
                return response.documents
            }
            return []
        }
    }
}
