###허드슨 스터디 디비 정리 메모


요약하자면

한 유저 정보만 모아보면
- first name
- sure name
- major
- Contact
- 내가 참여하고있는 스터디(subcollection, 필드에 내가 마스터인지 여부 체크 )

한 study 정보를 모아보면
- Name 
- Category
- Max 인원수
- 현재 인원수
- When
- introduction
- study_rules
- Status
- Privite 여부
- 암호(프리이벳일시) 
- members (subcolleciton : username,contect,major, 마스터 여부)


study의 종류
- 전체 스터디
- 내가 참여한 스터디
- 내가 마스터인 스터디

4P 
- user쪽은. current로 현 유저 이메일 불러와서 collection user에서 docID = current.email인지 확인하고 , 같으면 surname, major 불러오기 
- study쪽은 study collection에 있는 모든 도큐먼드 다 읽어오면됨. (일단 마스터 표시 안하기로하자. 이거 하면 조건문 걸어야할듯..)
5P
- user쪽은. current로 현 유저 이메일 불러와서 collection user에서 docID = current.email인지 확인하고 , 같으면 surname, major,contect 불러오기
-  

Collection
- User
일단 유저 collection의 모든 document이름 = 유저 이메일
- Study
Document = 스터디 이름(이름을 겹칠 수 없도록하자)
- Register
신청 도큐먼트를 저장하는 collection 
신청자first,surename, major,contect, studyid, study master user
여기서 마스터가 받아주면 해당 도큐먼트의 정보를 user와 study에 각각 업데이트하고, 해당 도큐먼트는 지우기 
