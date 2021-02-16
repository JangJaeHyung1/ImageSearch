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
        var urlString: String =  "https://dapi.kakao.com/v2/search/image?sort=accuracy&page=\(pageNum)&query=\(keyword)&size=\(size)"
        
        var encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        var url = URL(string: encodedString)!


        var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
        // HTTP 메시지 헤더
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
        
        
//        AF.request(url,method: .get, headers: headers).responseJSON() { response in
//                        switch response.result {
//                        case .success(let value):
////                            let result = try! response.result.get()
////                            if let fdaf = result as? Data {
////                                print(fdaf)
////                            }
////                            onComplete(.success(value as! Data))
//                            print(type(of: value))
//                            // NS딕셔너리 타입 value 그자체라서 data타입으로 반환불가
////                            }else {
////                                onComplete(.failure(NSError(domain: "no data",
////                                                            code: response.response!.statusCode,
////                                                            userInfo: nil)))
////                            }
//                        case .failure(let error):
//                            onComplete(.failure(error))
//                            return
//                        }
//                    }
    }
    
    //rx를 이용한 리팩토링 코드
    static func fetchImagesRx(_ keyword: String) -> Observable<Data> {
        return Observable.create() { emitter in
            //레거시 코드
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


