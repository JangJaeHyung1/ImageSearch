//
//  RequsetAPI.swift
//  SearchImage
//
//  Created by jh on 2021/02/15.
//

import Foundation
import RxSwift
import RxRelay

class RequsetAPI{
    static func fetchImages(_ keyword: String, onComplete: @escaping (Result<Data, Error>) -> Void ) {
        let pageNum:Int = 1
        let size: Int = 30
        let urlString: String =  "https://dapi.kakao.com/v2/search/image?sort=accuracy&page=\(pageNum)&query=\(keyword)&size=\(size)"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("KakaoAK cdbf902aa1c683526681f16f1f5581a4", forHTTPHeaderField: "Authorization")
    
        URLSession.shared.dataTask(with: request) { data, res, err in
                if let err = err {
                    onComplete(.failure(err))
                    return
                }
                guard let data = data else {
                    let httpResponse = res as! HTTPURLResponse
                    onComplete(.failure(NSError(domain: "no data",
                                                code: httpResponse.statusCode,
                                                userInfo: nil)))
                    return
                }
                onComplete(.success(data))
            }.resume()
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


