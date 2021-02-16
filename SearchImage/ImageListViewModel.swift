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

//    var keywordk: String = ""
    
    var imagesObservable = BehaviorSubject<[Document]>(value: [])
    
    init() {
        _ = RequsetAPI.fetchImagesRx("세배")
            .map { data -> [Document] in
                struct Response: Decodable {
                    var meta: Meta
                    var documents: [Document]
                    //JSON 데이터의 배열이름과 동일해야 함
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                return response.documents
            }
            .take(1) // 처음
            .bind(to: imagesObservable)
    }
}
