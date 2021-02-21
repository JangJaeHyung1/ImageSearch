# ImageSearch

Daum 이미지검색 API를 이용하여 만든 이미지검색 툴입니다.
 
rxSwift,rxCocoa와 Alamofire 라이브러리를 사용하였습니다.

debounce로 검색키워드에 대한 Observable을 emit 하였습니다. 시간간격은 1초로 하였습니다.

인피니티 스크롤 시 30개씩 이미지를 추가로 불러옵니다.


1.초기 화면
<img width="400" alt="초기화면" src="https://user-images.githubusercontent.com/37135479/108620367-24a64380-746f-11eb-90d6-ac85ee3a6a92.png">



2.검색 화면
<img width="400" alt="검색" src="https://user-images.githubusercontent.com/37135479/108620369-2839ca80-746f-11eb-974a-5e630ef441a9.png">


3.이미지 눌렀을 때 화면
<img width="400" alt="이미지" src="https://user-images.githubusercontent.com/37135479/108620374-2b34bb00-746f-11eb-9acc-fd3b77e12f79.png">

4.결과
<img width="400" alt="결과값" src="https://user-images.githubusercontent.com/37135479/108620379-2e2fab80-746f-11eb-84ec-fe8f2f8d0b77.png">
