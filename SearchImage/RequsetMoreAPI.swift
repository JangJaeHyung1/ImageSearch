//
//  RequsetMoreAPI.swift
//  SearchImage
//
//  Created by jh on 2021/02/21.
//

import Foundation
import Alamofire

let DidReceiveDocumentNotification: Notification.Name = Notification.Name("DidReceiveDocument")

func fetchImages(_ keyword: String,fehtchCount: Int){
    let size = 30
    
    let urlString: String =  "https://dapi.kakao.com/v2/search/image?sort=accuracy&page=\(fehtchCount)&query=\(keyword)&size=\(size)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = URL(string: encodedString)!
    let headers: HTTPHeaders = [
        "Authorization": "KakaoAK cdbf902aa1c683526681f16f1f5581a4"
    ]
    
    AF.request(url,method: .get, headers: headers).responseJSON() { response in
        switch response.result {
        case .success:
            do{
                struct Response: Decodable {
                    var meta: Meta
                    var documents: [Document]
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
                
                if let result = response.data{
                    let response = try decoder.decode(Response.self, from: result)
                        NotificationCenter.default.post(name: DidReceiveDocumentNotification, object: nil, userInfo: ["documents" : response.documents ])
                }
            }catch {
                print("JSONSerialization error:", error)
            }
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
}
