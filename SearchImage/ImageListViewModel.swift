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
    var searchResult = PublishRelay<[Document]>()
    var searchKeyword = PublishRelay<String>()
    var searchFlag = PublishRelay<Bool>()
    
    init (){
        searchKeyword.debounce(.seconds(1), scheduler: MainScheduler.instance).flatMap( RequsetAPI.fetchImagesRx(_:) ).subscribe(onNext:{ self.searchResult.accept($0) })
        
        searchResult.flatMap(emptyCheck(_:)).subscribe(onNext:{self.searchFlag.accept($0)})
    }
    func emptyCheck(_ result: [Document]) -> Observable<Bool>{
        return Observable.create(){ emitter in
            if result.count == 0 {
                emitter.onNext(false)
                emitter.onCompleted()
            }
            emitter.onNext(true)
            emitter.onCompleted()
            return Disposables.create()
        }
        
        
    }
    
  
}
