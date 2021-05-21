# 5.19
log
 - edit 버튼은 마스터한테만 보여지도록 수정.  
 - homelist의 apply 버튼도 마찬가지로 마스터한테만 보여지지 않도록 수정함.  
 - apply 발생시 application collection 에 신청건 저장
 - apply 발생 시 pop-up 알림 띄우기 
 - alarm page에 마스터 측에서 신청서 알람 list 
 - application detail page 이동까지 완성.

todo
 - alarm apply page만들기 
 - application detail page 구현하기 
 - apply - accept 기능 구현하기 
 - listview container 이랑 대부분의 text들 overflow 처리해주기 
 - apply 눌렀을 때 이미 신청한 스터디에 대해서는 이미 했다고 알람 띄우기 

# 5.21
log
 - application detail page 구현하기 
 - alarm listview applicant 이름 보여주는 걸로 수정함.
 - accept pressed했을 때, study의 mem에 applicant 추가
 - accept pressed했을 때, appUser의 mystudy에 study 추가
 - mystudy list에서 maxMemNember, currentMemNumber없앰. (필요없다고 판단)
 - home_widget, profile_page에서 유저 이름 데이터 베이스에서 받아오는 것으로 수정함. 
 - reject 버튼 구현
todo
 - accept 버튼 클릭시, applicant에게 알림 주기 
 - accept 버튼 클릭시 '추가하시겠습니까' 같은 pop alert 필요함. 
 - streambuilder initial data 설정가능한지 알아보기(페이지 이동시 데이터 읽어올때까지 걸리는 시간동안 overflow발생)
 - collection group query에 대해 공부하기(edit)https://joycehong0524.medium.com/firestore-%EC%9D%98-collection-group-query-51dcd64a5fd3
 - Edit profile Page 구현하기  
