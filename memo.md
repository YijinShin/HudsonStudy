### 허드슨 스터디 디비 정리 메모


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

memo 
- AppstateProvider > addUserToAppstate : 사용자가 앱에 처음 로그인한 경우에만 호출됨. 이 때는 아직 사용자가 하는 스터디가 없기 때문에 subcollection은 생성하지 않음. 
- AppstateProvider > addStueyToStudy : 처음 생성되면 생성한 유저 즉, current user이 마스터인 셈이니까 mem subcollection에 추가해주고 마스터 표시 해준다. 

alarm 종류
- 스터디 apply 알람 > 해당 스터디의 마스터한테 옴. 
- 스터디 accept 알람 > 해당 스터디의 신청자한테 옴.
- 스터디 전체에 관한 알람 > 스터디 멤버 전체한테 옴. 
- 만약 apply가 발생했을때, application collection에 저장을 한다하면 이름이 유니크할 수 없음. 
- 이 경우 docId는 자동생성으로 해야함. 필드에 (신청자 id, 마스터 id, study이름) 이렇게 넣기. 알람page의 listview는 application collection을 구독하면서 master==currentuserId인지 where을 통해 걸러서 해당 신청건만 알람 listview에 띄움. 
- 만약 apply가 발생했을때, 신청자와 마스터 안에 subcollection을 만들어서 저장한다면 두군데에 저장이 됨. 
- 이 경우, apply발생  >  신청자의 subcollection에 신청한 스터디 이름 저장. 마스터의 subcolleciton에 스터디 이름과 신청자 저장(docid를 어떻게 해야하지) 

지원을 했으나 아직 확인되지 않은 경우, 지원 버튼을 어떻게 할 것인가. 
- 아예 보여주지 않기
- 디테일 페이지에 지원 취소 버튼을 지원 버튼 대신 보여주기 (이 경우 지원 취소를 누르면 취소됨)
- 지원 버튼을 보여주나, 누르면 이미 지원했다고 알람 띄우기
- 어느쪽을 하든, appUser의 subcollection에 지원한 스터디 이름을 저장해서 체크하는 것이 가장 좋을 거같다. 

study가 수정된 경우, 업데이트
- study collection에서 해당 스터디
- appUser > myStudy에서 해당 스터디
- application에서 해당 스터디가 name인 모든 문서
- appUser > myapplication에서 해당 스터디 (이름뿐)

appUser가 수정된 경우, 업데이트
- appUser collection에서 해당 유저
- study > member 에서 해당 유저
- (application 에서 해당 유저가 applicant인 모든 문서는 필요없다. 어짜피 id는 안변하니까)
