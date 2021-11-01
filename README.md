# ImageSearch


### 'Daum 검색 - 이미지 검색' api를 사용하여 이미지 검색 앱만들기

### Search ViewController 
- [x] 검색어 입력 후 1초지나면 debounce로 검색키워드에 대한 Observable을 1초의 시간뒤 emit되도록 함. debounce와 throttle에 대해 정리한  https://ggasoon2.tistory.com/3
- [x] 검색결과가 없을 시 '결과없음' text 출력 
- [x] 30개씩 페이징 후 스크롤 시 30개씩 fetch 추가


#### 1. 구현 부분
* 카카오 Developer 계정 사용.
* UISearchBar에 문자를 입력 후 1초가 지나면 자동으로 검색.
* 검색어가 변경되면 목록 리셋 후 다시 데이터를 fetch 합니다.
  - 데이터는 30개씩 페이징 처리합니다. (최초 30개 데이터 fetch 후 스크롤 시 30개씩 추가 fetch)
* 검색 결과 목록은 UICollectionView를 사용하여 3xN 그리드 모양으로 구성합니다.
  - 검색 결과가 없을 경우 '검색 결과가 없습니다.' 메시지를 화면에 보여줍니다.
  - 검색 결과 목록 중 하나를 탭 하였을 때 전체 화면으로 이미지를 보여줍니다. 
  - 좌우 여백이 0이고, 이미지 비율은 유지하도록 보여줍니다.
  - 이미지가 세로로 길 경우 스크롤 됩니다.
  - response 데이터에 출처 'display_sitename', 문서 작성 시간 'datetime'이 있을 경우 전체화면 이미지 밑에 표시해 줍니다.


#### 2. 추가적인 부분
- [x] RxSwift 사용
- [ ] Test 코드 구현
- [x] Error 핸들링 (guardlet 과 do-catch 사용)




### DetailImage ViewController
- [x] 이미지 비율 준수
- [x] 이미지 세로로 길 경우 스크롤



## 시현 영상 및 이미지

https://youtu.be/IcKxjbDUwKY 시현 영상입니다.


1.초기 화면




<img width="400" alt="초기화면" src="https://user-images.githubusercontent.com/37135479/108620367-24a64380-746f-11eb-90d6-ac85ee3a6a92.png">







2.검색 화면




<img width="400" alt="검색" src="https://user-images.githubusercontent.com/37135479/108620369-2839ca80-746f-11eb-974a-5e630ef441a9.png">







3.이미지 눌렀을 때 화면



<img width="400" alt="이미지" src="https://user-images.githubusercontent.com/37135479/108620374-2b34bb00-746f-11eb-9acc-fd3b77e12f79.png">







4.결과값이 없을 때 화면



<img width="400" alt="결과값" src="https://user-images.githubusercontent.com/37135479/108620379-2e2fab80-746f-11eb-84ec-fe8f2f8d0b77.png">
