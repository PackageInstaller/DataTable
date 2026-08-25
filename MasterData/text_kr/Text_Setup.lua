__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "(번역자용) 텍스트 키 토글"
  },
  Setup_132685_SetupDesc = {
    Text = "현재 언어에서 어떤 스토리가 수동 번역되었는지 확인할 수 있습니다."
  },
  Setup_132685_SetupTitle = {
    Text = "「조사 작전」 공식 번역 완료된 챕터 표시"
  },
  Setup_134015_SetupTitle = {
    Text = "로그인 배경 애니메이션 변경"
  },
  Setup_148459_SetupDesc = {
    Text = "동조율이 20레벨에 도달하면, 해당 각성체는 「조사」 또는 「위상 대전」 전투에서 특별한 카드 외관을 표시합니다."
  },
  Setup_148459_SetupTitle = {
    Text = "「광채」 효과"
  },
  Setup_18433_SetupTitle = {
    Text = "게임 텍스트"
  },
  Setup_18434_SetupTitle = {
    Text = "안티앨리어싱"
  },
  Setup_18436_SetupTitle = {
    Text = "렌더링 정밀도"
  },
  Setup_18438_SetupTitle = {Text = "색수차"},
  Setup_18439_SetupTitle = {Text = "그림자"},
  Setup_18441_SetupTitle = {
    Text = "린피테이프 회복 완료"
  },
  Setup_18443_SetupTitle = {
    Text = "광기 폭발 및 은열쇠 발동 시 확인"
  },
  Setup_18444_SetupTitle = {
    Text = "이미지 품질"
  },
  Setup_18445_SetupTitle = {
    Text = "피사계 심도"
  },
  Setup_18448_SetupTitle = {
    Text = "장면 효과"
  },
  Setup_18449_SetupTitle = {
    Text = "유저 센터"
  },
  Setup_18453_SetupTitle = {Text = "음성"},
  Setup_18454_SetupTitle = {Text = "BGM"},
  Setup_18455_SetupTitle = {
    Text = "파견 완료"
  },
  Setup_18458_SetupTitle = {
    Text = "실타래시간 라이팅"
  },
  Setup_18459_SetupTitle = {Text = "효과음"},
  Setup_18460_SetupTitle = {
    Text = "이용 약관"
  },
  Setup_18461_SetupTitle = {
    Text = "화면 가장자리 블러"
  },
  Setup_18462_SetupTitle = {Text = "볼륨"},
  Setup_18463_SetupTitle = {
    Text = "교환 코드"
  },
  Setup_18466_SetupTitle = {
    Text = "특수 효과 품질"
  },
  Setup_18469_SetupDesc = {
    Text = "30프레임은 부하가 적고, 60프레임은 더 부드럽습니다."
  },
  Setup_18469_SetupTitle = {
    Text = "목표 프레임 속도"
  },
  Setup_21931_SetupTitle = {
    Text = "고객 센터"
  },
  Setup_24952_SetupDesc = {
    Text = "활성화 시, 메인 화면 및 작전 화면이 중력 센서의 영향을 받습니다."
  },
  Setup_24952_SetupTitle = {
    Text = "자이로스코프"
  },
  Setup_54468_SetupTitle = {
    Text = "그래픽 설정"
  },
  Setup_54469_SetupTitle = {Text = "해상도"},
  Setup_54664_SetupTitle = {
    Text = "단축키 표시"
  },
  Setup_54673_SetupTitle = {
    Text = "카드 8 선택"
  },
  Setup_54674_SetupTitle = {
    Text = "카드 9 선택"
  },
  Setup_54675_SetupTitle = {
    Text = "카드 2 선택"
  },
  Setup_54676_SetupTitle = {
    Text = "카드 3 선택"
  },
  Setup_54677_SetupTitle = {
    Text = "은열쇠 발동"
  },
  Setup_54678_SetupTitle = {
    Text = "카드 6 선택"
  },
  Setup_54679_SetupTitle = {
    Text = "카드 7 선택"
  },
  Setup_54680_SetupTitle = {
    Text = "카드 4 선택"
  },
  Setup_54681_SetupTitle = {
    Text = "카드 5 선택"
  },
  Setup_54682_SetupTitle = {
    Text = "광기 폭발 1"
  },
  Setup_54683_SetupTitle = {
    Text = "광기 폭발 2"
  },
  Setup_54684_SetupTitle = {
    Text = "광기 폭발 3"
  },
  Setup_54685_SetupTitle = {
    Text = "광기 폭발 4"
  },
  Setup_54686_SetupTitle = {
    Text = "드로우 덱 확인"
  },
  Setup_54687_SetupTitle = {
    Text = "카드 20 선택"
  },
  Setup_54688_SetupTitle = {Text = "턴 종료"},
  Setup_54689_SetupTitle = {
    Text = "카드 1 선택"
  },
  Setup_54690_SetupTitle = {
    Text = "취소/설정"
  },
  Setup_54691_SetupTitle = {
    Text = "영역 능력 1"
  },
  Setup_54692_SetupTitle = {
    Text = "카드 10 선택"
  },
  Setup_54693_SetupTitle = {
    Text = "카드 11 선택"
  },
  Setup_54694_SetupTitle = {
    Text = "카드 12 선택"
  },
  Setup_54695_SetupTitle = {
    Text = "카드 13 선택"
  },
  Setup_54696_SetupTitle = {
    Text = "카드 14 선택"
  },
  Setup_54697_SetupTitle = {
    Text = "카드 15 선택"
  },
  Setup_54698_SetupTitle = {
    Text = "카드 16 선택"
  },
  Setup_54699_SetupTitle = {
    Text = "카드 17 선택"
  },
  Setup_54700_SetupTitle = {
    Text = "카드 18 선택"
  },
  Setup_54701_SetupTitle = {
    Text = "카드 19 선택"
  },
  Setup_55509_SetupTitle = {
    Text = "게임 종료"
  },
  Setup_70541_SetupTitle = {
    Text = "창이 비활성 상태일 때"
  },
  Setup_72153_SetupTitle = {
    Text = "영역 능력 2"
  },
  Setup_94404_SetupTitle = {
    Text = "카드 사용"
  },
  Setup_94405_SetupTitle = {
    Text = "이전 카드"
  },
  Setup_94406_SetupTitle = {
    Text = "다음 카드"
  },
  Setup_94566_SetupTitle = {
    Text = "전투 동적 배경"
  }
})
return Text_Setup
