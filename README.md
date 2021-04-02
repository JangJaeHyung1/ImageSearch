# ImageSearch

브랜디  LABs MA팀 Senior iOS 채용 과제
- 카카오 'Daum 검색 - 이미지 검색' api를 사용하여 이미지 검색 앱을 만듭니다.

2. 확인사항 :
    - 카카오 Developer 계정은 개인 계정으로 만듭니다.
    - UISearchBar에 문자를 입력 후 1초가 지나면 자동으로 검색이 됩니다.
    -  검색어가 변경되면 목록 리셋 후 다시 데이터를 fetch 합니다.
       데이터는 30개씩 페이징 처리합니다. (최초 30개 데이터 fetch 후 스크롤 시 30개씩 추가 fetch)
   - 검색 결과 목록은 UICollectionView를 사용하여 3xN 그리드 모양으로 구성합니다.
       검색 결과가 없을 경우 '검색 결과가 없습니다.' 메시지를 화면에 보여줍니다.
       검색 결과 목록 중 하나를 탭 하였을 때 전체 화면으로 이미지를 보여줍니다. 
       좌우 여백이 0이고, 이미지 비율은 유지하도록 보여줍니다.
       이미지가 세로로 길 경우 스크롤 됩니다.
       response 데이터에 출처 'display_sitename', 문서 작성 시간 'datetime'이 있을 경우 전체화면 이미지 밑에 표시해 줍니다.
       이 외 UI는 자유롭게 구성합니다.
   - 오픈소스 라이브러리는 자유롭게 사용 가능합니다.
   - 결과물은 개인 github에 올려주시고,  labs-ma-ios@brandi.co.kr 으로 URL 공유 부탁드립니다.


Daum 이미지검색 API를 이용하여 만든 이미지검색 툴입니다.
 
rxSwift,rxCocoa와 Alamofire 라이브러리를 사용하였습니다.

debounce로 검색키워드에 대한 Observable을 1초의 시간뒤 emit되도록 하였습니다.

인피니티 스크롤 시 30개씩 이미지를 추가로 불러옵니다.


https://youtu.be/IcKxjbDUwKY 시현 영상입니다


1.초기 화면




<img width="400" alt="초기화면" src="https://user-images.githubusercontent.com/37135479/108620367-24a64380-746f-11eb-90d6-ac85ee3a6a92.png">







2.검색 화면




<img width="400" alt="검색" src="https://user-images.githubusercontent.com/37135479/108620369-2839ca80-746f-11eb-974a-5e630ef441a9.png">







3.이미지 눌렀을 때 화면



<img width="400" alt="이미지" src="https://user-images.githubusercontent.com/37135479/108620374-2b34bb00-746f-11eb-9acc-fd3b77e12f79.png">







4.결과값이 없을 때 화면



<img width="400" alt="결과값" src="https://user-images.githubusercontent.com/37135479/108620379-2e2fab80-746f-11eb-84ec-fe8f2f8d0b77.png">
