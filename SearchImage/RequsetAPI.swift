//
//  RequsetAPI.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import Foundation
import Alamofire
import RxSwift

class RequsetAPI{
    static func fetchImages(_ keyword: String, onComplete: @escaping (Result<Data, Error>) -> Void ) {
        var pageNum:Int = 1
        var size: Int = 30
        guard let url: URL = URL(string: "https://dapi.kakao.com/v2/search/image?sort=accuracy&page=\(pageNum)&query=\(keyword)&size=\(size)") else {
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK cdbf902aa1c683526681f16f1f5581a4"
        ]
       
        AF.request(url,method: .get, headers: headers).responseJSON() { response in
                        switch response.result {
                        case .success:
                            if let result = try! response.result.get() as? Data{
                                onComplete(.success(result))
                            }else {
                                onComplete(.failure(NSError(domain: "no data",
                                                            code: response.response!.statusCode,
                                                            userInfo: nil)))
                            }
                        case .failure(let error):
                            onComplete(.failure(error))
                            return
                        }
                    }
    }
    
    //rx를 이용한 리팩토링 코드
    static func fetchImagesRx(_ keyword: String) -> Observable<Data> {
        return Observable.create() { emitter in
            
            fetchImages(keyword) { result in
                switch result{
                case let .success(data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case let .failure(err):
                    emitter.onError(err)
                }
            }
            return Disposables.create()
            
        }
    }
}


