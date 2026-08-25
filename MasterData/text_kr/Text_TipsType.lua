__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "해상도를 변경한 후 클라이언트를 재시작해야 적용됩니다. 확인하시겠습니까?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "취소"},
  TipsType_100001_RightBtnDesc = {Text = "확인"},
  TipsType_100001_Title = {
    Text = "해상도 변경 확인"
  },
  TipsType_100002_Desc = {
    Text = "{s1}님의 게임 초대 수락을 기다리고 있습니다."
  },
  TipsType_100002_RightBtnDesc = {Text = "취소"},
  TipsType_100002_Title = {
    Text = "한 판 더!"
  },
  TipsType_100003_Desc = {
    Text = "{s1}님께서 게임을 다시 하자고 초대했습니다."
  },
  TipsType_100003_LeftBtnDesc = {Text = "거절"},
  TipsType_100003_RightBtnDesc = {Text = "수락"},
  TipsType_100003_Title = {
    Text = "한 판 더!"
  },
  TipsType_100004_Desc = {
    Text = "이미 현재 기숙사 배경으로 설정되어 있습니다."
  },
  TipsType_100005_Desc = {
    Text = "페이즈 체스(PVP) 모드 미개방"
  },
  TipsType_100006_Desc = {
    Text = "상대가 아직 페이즈 체스 기능을 개방하지 않았습니다"
  },
  TipsType_100007_Desc = {
    Text = "상호 팔로우 상태여야 친선경기를 시작할 수 있습니다."
  },
  TipsType_100008_Desc = {
    Text = "상대방이 오프라인 상태입니다."
  },
  TipsType_100009_Desc = {
    Text = "상대방이 탐사 중입니다."
  },
  TipsType_100010_Desc = {
    Text = "친선경기 대기 시간 초과"
  },
  TipsType_100011_Desc = {
    Text = "친선경기를 취소했습니다."
  },
  TipsType_100012_Desc = {
    Text = "친선경기 초대가 거절되었습니다."
  },
  TipsType_100012_LeftBtnDesc = {Text = "확인"},
  TipsType_100012_Title = {Text = "알림"},
  TipsType_100013_Desc = {
    Text = "상대방이 오프라인 상태입니다."
  },
  TipsType_100014_Desc = {
    Text = "상대방이 다른 게임 모드로 진입했습니다."
  },
  TipsType_100015_Desc = {
    Text = "초대가 너무 빈번합니다. {s1}초 후에 다시 시도해 주세요."
  },
  TipsType_100016_Desc = {
    Text = "상대방이 친선경기를 취소했습니다."
  },
  TipsType_100016_LeftBtnDesc = {Text = "확인"},
  TipsType_100016_Title = {Text = "알림"},
  TipsType_100017_Desc = {
    Text = "해당 플레이어는 친선경기를 진행 중입니다."
  },
  TipsType_100017_LeftBtnDesc = {Text = "확인"},
  TipsType_100017_Title = {Text = "알림"},
  TipsType_100018_Desc = {
    Text = "해당 편성에는 기간 한정 카드가 포함되어 있으며, 이번 시즌의 핵심 과제를 해제해야 계속 사용할 수 있습니다. 다시 함께 전투에 임할 수 있기를 기대합니다!\n핵심 과제를 해제하러 가시겠습니까?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "취소"},
  TipsType_100018_RightBtnDesc = {Text = "확인"},
  TipsType_100018_Title = {
    Text = "핵심 과제가 만료되었습니다."
  },
  TipsType_10001_Desc = {
    Text = "조작 성공"
  },
  TipsType_100020_Desc = {
    Text = "전투가 진행 중입니다. 이전 전투를 계속하시겠습니까?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "취소"},
  TipsType_100020_RightBtnDesc = {Text = "확인"},
  TipsType_100020_Title = {Text = "알림"},
  TipsType_10002_Desc = {
    Text = "설정표 오류"
  },
  TipsType_10003_Desc = {
    Text = "클라이언트 데이터 입력 오류"
  },
  TipsType_10004_Desc = {
    Text = "서버가 아직 가동되지 않았습니다"
  },
  TipsType_10005_Desc = {
    Text = "캐릭터 데이터 오류"
  },
  TipsType_10006_Desc = {
    Text = "깨어남체 데이터를 찾을 수 없습니다."
  },
  TipsType_10007_Desc = {
    Text = "깨어남체가 최대 레벨에 도달했습니다."
  },
  TipsType_10008_Desc = {
    Text = "과제 점수가 부족합니다."
  },
  TipsType_10009_Desc = {
    Text = "깨어남체가 최대 레벨에 도달하지 않아 영혼 깨어남을 활성화할 수 없습니다."
  },
  TipsType_100100_Desc = {
    Text = "현재 최신 버전 업데이트가 존재합니다. 자동 업데이트가 되지 않을 경우, Steam을 재시작한 후 업데이트를 확인해 주세요."
  },
  TipsType_100100_RightBtnDesc = {Text = "확인"},
  TipsType_100100_Title = {
    Text = "업데이트 알림"
  },
  TipsType_10010_Desc = {
    Text = "영혼 깨어남 완료"
  },
  TipsType_10011_Desc = {
    Text = "현재 생성된 캐릭터가 없습니다."
  },
  TipsType_10012_Desc = {
    Text = "보유 중인 캐릭터"
  },
  TipsType_10013_Desc = {
    Text = "중복된 캐릭터명입니다."
  },
  TipsType_10014_Desc = {
    Text = "비경 구역 오류"
  },
  TipsType_10015_Desc = {
    Text = "비경 구역을 찾을 수 없습니다."
  },
  TipsType_10016_Desc = {
    Text = "현재 스태미나가 너무 낮습니다."
  },
  TipsType_10017_Desc = {
    Text = "{s1}에서 {s2}까지 해제 가능"
  },
  TipsType_10018_Desc = {
    Text = "이 비경의 2층에 1회 도달한 후, 빠른 조사가 가능합니다."
  },
  TipsType_10019_Desc = {
    Text = "이벤트가 완료되었습니다."
  },
  TipsType_10020_Desc = {
    Text = "이벤트 설정표에 타입이 잘못 입력되었습니다."
  },
  TipsType_10021_Desc = {
    Text = "이벤트가 존재하지 않습니다."
  },
  TipsType_10022_Desc = {
    Text = "검은 인장이 부족하여 구매할 수 없습니다."
  },
  TipsType_10023_Desc = {
    Text = "해당 카드는 강화할 수 없습니다."
  },
  TipsType_10024_Desc = {
    Text = "해당 카드는 강화 한도에 도달했습니다."
  },
  TipsType_10025_Desc = {
    Text = "행상은 해당 상품을 판매하지 않습니다."
  },
  TipsType_10026_Desc = {
    Text = "해당 보상이 존재하지 않습니다."
  },
  TipsType_10027_Desc = {
    Text = "보상 수령 완료"
  },
  TipsType_10028_Desc = {
    Text = "이벤트 데이터 오류"
  },
  TipsType_10029_Desc = {
    Text = "상품 구매 성공"
  },
  TipsType_10030_Desc = {
    Text = "현재 에너지가 부족하여 포탈을 활성화할 수 없습니다. 포탈을 활성화하려면 {s1}의 에너지가 필요합니다."
  },
  TipsType_10031_Desc = {
    Text = "스토리 대화 이벤트를 찾을 수 없습니다."
  },
  TipsType_10032_Desc = {
    Text = "이벤트 선택: 명령 카드 수량이 부족합니다."
  },
  TipsType_10033_Desc = {
    Text = "이벤트 선택: 명령 카드가 너무 많습니다."
  },
  TipsType_10034_Desc = {
    Text = "이벤트 선택: 명령 카드가 존재하지 않습니다."
  },
  TipsType_10035_Desc = {
    Text = "랜덤 이벤트 목록에 데이터가 없습니다."
  },
  TipsType_10036_Desc = {
    Text = "행상은 해당 상품을 판매하지 않습니다."
  },
  TipsType_10037_Desc = {
    Text = "이벤트 선택: 유물 수량이 부족합니다."
  },
  TipsType_10038_Desc = {
    Text = "이벤트 선택: 유물 수량이 너무 많습니다."
  },
  TipsType_10039_Desc = {
    Text = "이벤트 선택: 유물 존재하지 않습니다."
  },
  TipsType_10040_Desc = {
    Text = "이벤트 노드를 찾을 수 없습니다."
  },
  TipsType_10041_Desc = {
    Text = "행상 갱신 횟수를 전부 소모했습니다."
  },
  TipsType_10042_Desc = {
    Text = "전투 드롭 명령 카드 갱신 횟수가 소진되었습니다."
  },
  TipsType_10043_Desc = {
    Text = "전투 드롭 유물 갱신 횟수가 소진되었습니다."
  },
  TipsType_10044_Desc = {
    Text = "연락 지점 기능이 잠겨 있습니다."
  },
  TipsType_10045_Desc = {
    Text = "이벤트 구역이 일치하지 않습니다! 현재 구역: {s1}, 이벤트 설정 구역: {s2}"
  },
  TipsType_10046_Desc = {
    Text = "이벤트 상점의 카드 삭제 횟수가 소진되었습니다."
  },
  TipsType_10047_Desc = {
    Text = "과제 유닛 데이터를 찾을 수 없습니다."
  },
  TipsType_10048_Desc = {
    Text = "유닛이 이미 제출되었습니다. 다시 제출할 필요가 없습니다."
  },
  TipsType_10049_Desc = {
    Text = "유닛의 과제는 전부 완성되지 않아 제출할 수 없습니다."
  },
  TipsType_10050_Desc = {
    Text = "과제 모듈을 찾을 수 없습니다."
  },
  TipsType_10051_Desc = {
    Text = "레벨에 과제 데이터가 없습니다."
  },
  TipsType_10052_Desc = {
    Text = "이 비경에 해당하는 과제가 없습니다."
  },
  TipsType_10053_Desc = {
    Text = "학점이 부족하여 보상을 수령할 수 없습니다."
  },
  TipsType_10054_Desc = {
    Text = "학점 보상 수령 조건이 아직 충족되지 않았습니다."
  },
  TipsType_10055_Desc = {
    Text = "과제 점수에 해당하는 미션을 찾을 수 없습니다."
  },
  TipsType_10056_Desc = {
    Text = "과제 점수 미션이 완료되었습니다."
  },
  TipsType_10057_Desc = {
    Text = "과제 점수 미션의 하위 작업이 완료되지 않았습니다."
  },
  TipsType_10058_Desc = {
    Text = "NPC가 트리거되었습니다."
  },
  TipsType_10059_Desc = {
    Text = "NPC 데이터 오류"
  },
  TipsType_10060_Desc = {
    Text = "NPC가 존재하지 않습니다."
  },
  TipsType_10061_Desc = {
    Text = "비경에서 발견되지 않습니다."
  },
  TipsType_10062_Desc = {
    Text = "공명 데이터를 찾을 수 없습니다."
  },
  TipsType_10063_Desc = {
    Text = "공명이 최대 레벨에 도달했습니다."
  },
  TipsType_10064_Desc = {
    Text = "공명 레벨 관련 데이터를 찾을 수 없습니다."
  },
  TipsType_10065_Desc = {
    Text = "초기화 횟수가 없습니다."
  },
  TipsType_10066_Desc = {
    Text = "공명 활성화 조건이 충족되지 않았습니다."
  },
  TipsType_10067_Desc = {
    Text = "공명 입자가 부족합니다."
  },
  TipsType_10068_Desc = {
    Text = "영혼 깨어남이 완료되었으니 \n다시 영혼 깨어남을 활성화할 수 없습니다."
  },
  TipsType_10069_Desc = {
    Text = "영혼 깨어남에 필요한 재료가 부족합니다."
  },
  TipsType_10070_Desc = {
    Text = "깨어남체 업그레이드에 필요한 재료가 부족합니다"
  },
  TipsType_10071_Desc = {
    Text = "깨어남체 업그레이드에 필요한 금권이 부족합니다."
  },
  TipsType_10072_Desc = {
    Text = "깨어남체 업그레이드에 필요한 금권이 부족합니다."
  },
  TipsType_10073_Desc = {
    Text = "깨어남체 스킬이 없습니다."
  },
  TipsType_10074_Desc = {
    Text = "깨어남체 스킬이 아직 해제되지 않았습니다."
  },
  TipsType_10075_Desc = {
    Text = "소환에 필요한 ‘은심’이 부족합니다."
  },
  TipsType_10076_Desc = {
    Text = "아이템 부족"
  },
  TipsType_10077_Desc = {
    Text = "오늘 구매 횟수 최대치에 도달했습니다."
  },
  TipsType_10078_Desc = {
    Text = "아이템을 사용할 수 없습니다"
  },
  TipsType_10079_Desc = {
    Text = "아이템 사용 수량 오류"
  },
  TipsType_10080_Desc = {
    Text = "스킬이 최대 레벨에 도달했습니다."
  },
  TipsType_10081_Desc = {
    Text = "재료가 부족하여 업그레이드할 수 없습니다."
  },
  TipsType_10082_Desc = {
    Text = "화폐가 부족하여 업그레이드할 수 없습니다."
  },
  TipsType_10083_Desc = {
    Text = "깨어남체 연결률이 최대 레벨에 도달했습니다."
  },
  TipsType_10084_Desc = {
    Text = "해당 깨어남체는 동원 정신이 부족합니다."
  },
  TipsType_10085_Desc = {
    Text = "업그레이드 경로에 캐릭터 ID가 설정되지 않았습니다."
  },
  TipsType_10086_Desc = {
    Text = "지정된 전용 카드 정보를 찾을 수 없습니다."
  },
  TipsType_10087_Desc = {
    Text = "지정된 전용 카드가 해제되지 않았습니다."
  },
  TipsType_10088_Desc = {
    Text = "해당 전용 카드 uuid를 찾을 수 없습니다."
  },
  TipsType_10089_Desc = {
    Text = "챕터 보상에 필요한 포인트가 부족합니다."
  },
  TipsType_10090_Desc = {
    Text = "챕터 보상을 이미 수령했습니다."
  },
  TipsType_10091_Desc = {
    Text = "선택한 스토리는 아직 해제되지 않았습니다."
  },
  TipsType_10092_Desc = {
    Text = "선택한 던전은 아직 해제되지 않았습니다."
  },
  TipsType_10093_Desc = {
    Text = "던전 구역이 아직 해제되지 않았습니다."
  },
  TipsType_10094_Desc = {
    Text = "스토리 소탕 기능이 아직 해제되지 않았습니다."
  },
  TipsType_10095_Desc = {
    Text = "던전 도전의 스토리라인을 찾을 수 없습니다."
  },
  TipsType_10096_Desc = {
    Text = "던전 도전의 스토리라인 미션을 찾을 수 없습니다."
  },
  TipsType_10097_Desc = {
    Text = "도전 미션이 완료되었습니다. 보상을 다시 수령할 수 없습니다."
  },
  TipsType_10098_Desc = {
    Text = "도전 미션이 완료되지 않아 보상을 수령할 수 없습니다."
  },
  TipsType_10099_Desc = {
    Text = "건물이 존재하지 않습니다."
  },
  TipsType_10100_Desc = {
    Text = "건물이 최대 레벨에 도달했습니다."
  },
  TipsType_10101_Desc = {
    Text = "건물 업그레이드/건축 조건이 부족합니다."
  },
  TipsType_10102_Desc = {
    Text = "건물이 이미 존재하여 재건설할 수 없습니다."
  },
  TipsType_10103_Desc = {
    Text = "업그레이드/건축에 필요한 아이템이 부족합니다."
  },
  TipsType_10104_Desc = {
    Text = "해당 위치에 이미 깨어남체가 있어, 입주할 수 없습니다."
  },
  TipsType_10105_Desc = {
    Text = "아이템 합성에 필요한 다른 아이템이 부족합니다."
  },
  TipsType_10106_Desc = {
    Text = "아이템 합성에 필요한 화폐가 부족합니다."
  },
  TipsType_10107_Desc = {
    Text = "합성 아이템이 해제되지 않았습니다."
  },
  TipsType_10108_Desc = {
    Text = "서버 연결 실타래패, 네트워크를 확인한 후 다시 시도해 주세요"
  },
  TipsType_10109_Desc = {
    Text = "해당 캠프의 기능은 이미 선택되어 있어, 다시 선택할 수 없습니다."
  },
  TipsType_10110_Desc = {
    Text = "캠프 기능의 사용 횟수가 모두 소진되었습니다."
  },
  TipsType_10111_Desc = {
    Text = "전용 카드는 업그레이드하지 않으면 전환할 수 없습니다."
  },
  TipsType_10112_Desc = {
    Text = "전용 카드는 변화가 없어서 전환할 수 없습니다."
  },
  TipsType_10113_Desc = {
    Text = "전용 카드 전환 실타래패했습니다."
  },
  TipsType_10114_Desc = {
    Text = "깨어남체 {s1} 획득"
  },
  TipsType_10115_Desc = {
    Text = "중복으로 획득한 {s1}이(가) {s2}{s3}(으)로 전환되었습니다."
  },
  TipsType_10116_Desc = {
    Text = "{s1} 신물이 한도를 초과하여 {s2} {s3}(으)로 전환되었습니다."
  },
  TipsType_10117_Desc = {
    Text = "로그 업로드 성공"
  },
  TipsType_10118_Desc = {
    Text = "명령어가 일치하지 않습니다, 현재 {s1} 명령을 기다리는 중입니다.{s2}가 입력되었습니다."
  },
  TipsType_10119_Desc = {
    Text = "카드를 잃음:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "시전 불가"
  },
  TipsType_10121_Desc = {
    Text = "해당 스킬 없음"
  },
  TipsType_10122_Desc = {
    Text = "스킬 쿨다운 중"
  },
  TipsType_10123_Desc = {
    Text = "스킬 사용 횟수 소진"
  },
  TipsType_10124_Desc = {
    Text = "건물 Tid {s1}의 관련 건물 업그레이드 순서가 순환하는지 확인하세요."
  },
  TipsType_10125_Desc = {
    Text = "건물 Tid {s1}에 관련 설정이 없는지 확인하세요."
  },
  TipsType_10126_Desc = {
    Text = "건물 Tid {s1}의 실타래제 등급은 {s2}이며, 설정된 등급은 {s3}입니다."
  },
  TipsType_10127_Desc = {
    Text = "건물 유형 설정을 찾을 수 없습니다."
  },
  TipsType_10128_Desc = {
    Text = "건물 설정을 찾을 수 없거나 건물 유형이 존재하지 않습니다."
  },
  TipsType_10129_Desc = {
    Text = "해당 스토리라인의 과제 점수 미션은 아직 오픈되지 않았습니다."
  },
  TipsType_10130_Desc = {
    Text = "제거 성공"
  },
  TipsType_10131_Desc = {
    Text = "‘메노핀’ × {s1} 추가 성공"
  },
  TipsType_10132_Desc = {
    Text = "수리 완료"
  },
  TipsType_10133_Desc = {
    Text = "GM 아이템 추가 시 아이템 이름 [\"..arg1..\"]에 해당하는 아이템을 찾을 수 없습니다."
  },
  TipsType_10134_Desc = {
    Text = "이벤트 [“..arg1..”]가 존재하지 않습니다."
  },
  TipsType_10135_Desc = {
    Text = "현재: {s1}을 누르세요."
  },
  TipsType_10136_Desc = {
    Text = "스킬 업그레이드 성공"
  },
  TipsType_10137_Desc = {
    Text = "생성 성공"
  },
  TipsType_10138_Desc = {
    Text = "서버 시간 수정 성공"
  },
  TipsType_10139_Desc = {
    Text = "서버 시간 조정 실타래패"
  },
  TipsType_10140_Desc = {
    Text = "건물 총 수: 17\n이 임시 버전에서는 일부 건물만 사용할 수 있습니다"
  },
  TipsType_10141_Desc = {
    Text = "건물 해금 조건이 충족되지 않았습니다."
  },
  TipsType_10142_Desc = {
    Text = "건물:{s1}설정된 인터페이스가 존재하지 않습니다{s2}"
  },
  TipsType_10143_Desc = {
    Text = "해당 합성식은 아직 해제되지 않았습니다."
  },
  TipsType_10144_Desc = {
    Text = "재료 부족"
  },
  TipsType_10145_Desc = {
    Text = "합성 성공"
  },
  TipsType_10146_Desc = {
    Text = "업그레이드 성공"
  },
  TipsType_10147_Desc = {
    Text = "몬스터 슬롯이 비어 있어 전투를 시작할 수 없습니다."
  },
  TipsType_10148_Desc = {
    Text = "‘메노핀’ 답장"
  },
  TipsType_10149_Desc = {
    Text = "입력한 캐릭터 ID가 중복되어 전투를 시작할 수 없습니다."
  },
  TipsType_10150_Desc = {
    Text = "입력한 ID{s1}가 존재하지 않아 전투를 시작할 수 없습니다."
  },
  TipsType_10151_Desc = {
    Text = "몬스터가 해당하는 동작이 없습니다."
  },
  TipsType_10152_Desc = {Text = "미오픈"},
  TipsType_10153_Desc = {
    Text = "덱에 카드가 없습니다."
  },
  TipsType_10154_Desc = {
    Text = "다른 카드의 효과가 발동 중이므로 카드를 낼 수 없습니다."
  },
  TipsType_10155_Desc = {
    Text = "손패에 없어서 사용할 수 없습니다."
  },
  TipsType_10156_Desc = {
    Text = "사용할 수 없는 카드입니다."
  },
  TipsType_10157_Desc = {
    Text = "이 카드에는 스킬이 설정되어 있지 않습니다."
  },
  TipsType_10158_Desc = {
    Text = "사용할 수 없는 카드입니다."
  },
  TipsType_10159_Desc = {
    Text = "행동력 부족"
  },
  TipsType_10160_Desc = {
    Text = "해당하는 깨어남체가 없습니다."
  },
  TipsType_10161_Desc = {
    Text = "남은 횟수가 부족합니다."
  },
  TipsType_10162_Desc = {
    Text = "탐색 스킬 사용"
  },
  TipsType_10163_Desc = {
    Text = "%d장의 명령 카드가 선택되었습니다."
  },
  TipsType_10164_Desc = {
    Text = "최대 수량에 도달했습니다."
  },
  TipsType_10165_Desc = {
    Text = "선택되지 않습니다."
  },
  TipsType_10166_Desc = {
    Text = "이 카드는 행동력 소모로 사용할 수 없습니다."
  },
  TipsType_10167_Desc = {
    Text = "소모 총합 초과"
  },
  TipsType_10168_Desc = {
    Text = "{s1}장의 카드가 선택되었습니다."
  },
  TipsType_10169_Desc = {
    Text = "촉수 수량이 최대치에 도달했습니다."
  },
  TipsType_10170_Desc = {
    Text = "제거 성공"
  },
  TipsType_10171_Desc = {
    Text = "강화 성공"
  },
  TipsType_10172_Desc = {
    Text = "변화 성공"
  },
  TipsType_10173_Desc = {
    Text = "클립보드에 복사되었습니다."
  },
  TipsType_10174_Desc = {
    Text = "명령 카드를 획득했습니다."
  },
  TipsType_10175_Desc = {
    Text = "제거 횟수가 소진되었습니다."
  },
  TipsType_10176_Desc = {
    Text = "강화 횟수가 소진되었습니다."
  },
  TipsType_10177_Desc = {
    Text = "변화 횟수가 소진되었습니다."
  },
  TipsType_10178_Desc = {
    Text = "복사 횟수가 소진되었습니다."
  },
  TipsType_10179_Desc = {
    Text = "명령 카드 선택 수량이 최대치에 도달했습니다."
  },
  TipsType_10180_Desc = {
    Text = "명령 카드를 아직 선택하지 않았습니다."
  },
  TipsType_10181_Desc = {
    Text = "상점이 개방되지 않았습니다. 기대해 주세요."
  },
  TipsType_10182_Desc = {
    Text = "기대해 주세요."
  },
  TipsType_10183_Desc = {
    Text = "목표 지점이 너무 멀어서 위치를 확인할 수 없습니다."
  },
  TipsType_10184_Desc = {
    Text = "목표 지역을 놓쳐 완료할 수 없습니다."
  },
  TipsType_10185_Desc = {
    Text = "이 과제는 아직 해제되지 않았습니다."
  },
  TipsType_10186_Desc = {
    Text = "비경을 탐색하여 더 많은 조사를 해제하세요."
  },
  TipsType_10187_Desc = {
    Text = "선행 미션을 완료하여 더 많은 조사를 해제하세요."
  },
  TipsType_10188_Desc = {
    Text = "제출 성공. 과제 점수 +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "제출할 수 있는 과제가 없습니다."
  },
  TipsType_10190_Desc = {
    Text = "아직 개방되지 않았습니다. 던전 개방 시간을 확인하세요."
  },
  TipsType_10191_Desc = {
    Text = "스테이지 해제 조건이 아직 충족되지 않았습니다."
  },
  TipsType_10192_Desc = {
    Text = "{s1}은(는) 비어 있을 수 없습니다."
  },
  TipsType_10193_Desc = {
    Text = "{s1}과 {s2}은(는) 비어 있을 수 없습니다."
  },
  TipsType_10194_Desc = {
    Text = "갱신 횟수가 소진되었습니다. 더 이상 갱신할 수 없습니다."
  },
  TipsType_10195_Desc = {
    Text = "획득 경로가 아직 해제되지 않았습니다."
  },
  TipsType_10196_Desc = {
    Text = "획득 경로가 열리는 시간이 아닙니다."
  },
  TipsType_10197_Desc = {
    Text = "변화시킬 유물을 선택하세요."
  },
  TipsType_10198_Desc = {
    Text = "제거 성공"
  },
  TipsType_10199_Desc = {
    Text = "제거 횟수가 소진되었습니다."
  },
  TipsType_10200_Desc = {
    Text = "변화 횟수가 소진되었습니다."
  },
  TipsType_10201_Desc = {
    Text = "제거할 유물을 선택해 주세요."
  },
  TipsType_10202_Desc = {
    Text = "수량이 최대치에 도달했습니다."
  },
  TipsType_10203_Desc = {
    Text = "최소 {s1}개의 유물을 선택하세요."
  },
  TipsType_10204_Desc = {
    Text = "현재 남은 전환 횟수는 0이며, 전환을 할 수 없습니다."
  },
  TipsType_10205_Desc = {
    Text = "모든 전용 카드가 최대 레벨로 업그레이드되었습니다."
  },
  TipsType_10206_Desc = {
    Text = "현재 배척도가 0으로 더 이상 낮출 수 없습니다."
  },
  TipsType_10207_Desc = {Text = "미오픈"},
  TipsType_10208_Desc = {
    Text = "영혼의 닻이 부족하여, 강화할 수 없습니다."
  },
  TipsType_10209_Desc = {
    Text = "{s1}가 {s2} 레벨에 도달해야 영혼 깨어남을 수행할 수 있습니다."
  },
  TipsType_10210_Desc = {
    Text = "‘{s1}’ 부족"
  },
  TipsType_10211_Desc = {
    Text = "아직 소유하지 않음「{s1}」"
  },
  TipsType_10212_Desc = {
    Text = "최대 레벨 도달"
  },
  TipsType_10213_Desc = {
    Text = "먼저 재료를 선택해 주세요."
  },
  TipsType_10214_Desc = {
    Text = "‘{s1}’ 부족"
  },
  TipsType_10215_Desc = {
    Text = "업그레이드 성공"
  },
  TipsType_10216_Desc = {
    Text = "영지 약제가 증가했습니다."
  },
  TipsType_10217_Desc = {
    Text = "영혼 깨어남 최대치에 도달했습니다."
  },
  TipsType_10218_Desc = {
    Text = "업그레이드 실타래패"
  },
  TipsType_10219_Desc = {
    Text = "아이템이 부족하여 업그레이드할 수 없습니다."
  },
  TipsType_10221_Desc = {
    Text = "스킬 업그레이드 성공"
  },
  TipsType_10222_Desc = {
    Text = "검은 인장이 부족하여 구매할 수 없습니다."
  },
  TipsType_10223_Desc = {Text = "품절"},
  TipsType_10224_Desc = {
    Text = "검은 인장이 부족하여 명령 카드를 제거할 수 없습니다."
  },
  TipsType_10225_Desc = {
    Text = "명령 카드 {s1}장 제거"
  },
  TipsType_10226_Desc = {
    Text = "이 방향은 아직 오픈되지 않아 강화할 수 없습니다."
  },
  TipsType_10227_Desc = {
    Text = "이 방향은 이미 최대 레벨로 강화되었습니다."
  },
  TipsType_10228_Desc = {
    Text = "먼저 전용 카드의 강화 방향을 선택해 주세요."
  },
  TipsType_10229_Desc = {
    Text = "영혼의 닻이 부족하여, 강화할 수 없습니다."
  },
  TipsType_10230_Desc = {
    Text = "해당 영역의 깨어남체를 보유하지 않아 선택할 수 없습니다."
  },
  TipsType_10231_Desc = {
    Text = "파티 편성"
  },
  TipsType_10232_Desc = {
    Text = "파티 이름은 {s1}글자를 초과할 수 없습니다."
  },
  TipsType_10233_Desc = {
    Text = "파티 이름은 비어 있을 수 없습니다."
  },
  TipsType_10234_Desc = {
    Text = "교환 성공!"
  },
  TipsType_10235_Desc = {
    Text = "남은 ‘은심’이 없습니다."
  },
  TipsType_10236_Desc = {
    Text = "더 이상 줄일 수 없습니다."
  },
  TipsType_10237_Desc = {
    Text = "{s1}은(는) 아직 오픈되지 않았습니다. 기대해 주세요."
  },
  TipsType_10238_Desc = {
    Text = "소환은 아직 오픈되지 않았습니다. 기대해 주세요."
  },
  TipsType_10239_Desc = {
    Text = "캠퍼스 미니맵 기능은 아직 오픈되지 않았습니다."
  },
  TipsType_10240_Desc = {
    Text = "과제 등급 {s1} 달성 시 해제"
  },
  TipsType_10241_Desc = {
    Text = "조건에 맞는 카드가 없습니다."
  },
  TipsType_10242_Desc = {
    Text = "모든 영역 카드가 업그레이드되었습니다."
  },
  TipsType_10243_Desc = {
    Text = "업그레이드할 수 있는 명령 카드가 없습니다."
  },
  TipsType_10244_Desc = {
    Text = "새로운 전송 지점을 발견했습니다! {s1}로 이동할 수 있습니다."
  },
  TipsType_10245_Desc = {
    Text = "이미 이 유물을 획득하여, 중복 획득할 수 없습니다."
  },
  TipsType_10246_Desc = {
    Text = "회복 성공"
  },
  TipsType_10247_Desc = {
    Text = "제거 성공"
  },
  TipsType_10248_Desc = {
    Text = "물자 화면 열기"
  },
  TipsType_10249_Desc = {
    Text = "지난번 접속이 비정상적으로 종료된 것으로 확인되어, ‘메노핀’ 및 해당 보상 아이템이 반환되었습니다. 물자에서 확인해 주세요."
  },
  TipsType_10250_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10251_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10252_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10253_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10254_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10255_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10256_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10257_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10258_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10259_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10260_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10261_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10262_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10263_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10264_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10265_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10266_Desc = {
    Text = "AVG 버전에서는 일부 건물만 제공되며, 여기 표시된 수치는 건물의 총 개수인 17개를 나타냅니다."
  },
  TipsType_10267_Desc = {
    Text = "사용 조건 미충족"
  },
  TipsType_10268_Desc = {
    Text = "조사 등급 2 달성 시 빠른 조사 해제"
  },
  TipsType_10269_Desc = {
    Text = "연결이 끊어졌습니다."
  },
  TipsType_10270_Desc = {
    Text = "서버 연결이 중단되었습니다. 잠시 후 타이틀로 돌아갑니다."
  },
  TipsType_10271_Desc = {Text = "확인"},
  TipsType_10272_Desc = {
    Text = "서버가 아직 열리지 않았습니다. 나중에 다시 시도해 주세요."
  },
  TipsType_10273_Desc = {
    Text = "조작 성공"
  },
  TipsType_10274_Desc = {
    Text = "해당 비경을 찾을 수 없습니다."
  },
  TipsType_10275_Desc = {
    Text = "비경 이벤트 완료되었습니다."
  },
  TipsType_10276_Desc = {
    Text = "비경 이벤트 설정 타입이 잘못 입력되었습니다."
  },
  TipsType_10277_Desc = {
    Text = "비경 이벤트가 존재하지 않습니다."
  },
  TipsType_10278_Desc = {
    Text = "검은 인장이 부족하여 구매할 수 없습니다."
  },
  TipsType_10279_Desc = {
    Text = "이 카드는 강화할 수 없습니다."
  },
  TipsType_10280_Desc = {
    Text = "이 카드는 이미 강화 한도에 도달했습니다."
  },
  TipsType_10281_Desc = {
    Text = "행상은 해당 상품을 판매하지 않습니다."
  },
  TipsType_10282_Desc = {
    Text = "해당 보상이 없습니다."
  },
  TipsType_10283_Desc = {
    Text = "보상 수령 완료"
  },
  TipsType_10284_Desc = {
    Text = "설정표 오류"
  },
  TipsType_10285_Desc = {
    Text = "이벤트 데이터 오류"
  },
  TipsType_10286_Desc = {
    Text = "상품 구매 완료"
  },
  TipsType_10287_Desc = {
    Text = "과제 유닛 데이터를 찾을 수 없습니다."
  },
  TipsType_10288_Desc = {
    Text = "유닛이 이미 제출되었습니다. 다시 제출할 필요가 없습니다."
  },
  TipsType_10289_Desc = {
    Text = "유닛의 과제는 전부 완성되지 않아 제출할 수 없습니다."
  },
  TipsType_10290_Desc = {
    Text = "과제 모듈이 없습니다."
  },
  TipsType_10291_Desc = {
    Text = "레벨에 과제 데이터가 없습니다."
  },
  TipsType_10292_Desc = {
    Text = "클라이언트 데이터 입력 오류"
  },
  TipsType_10293_Desc = {
    Text = "서비스가 시작되지 않았습니다"
  },
  TipsType_10294_Desc = {
    Text = "캐릭터 데이터 오류"
  },
  TipsType_10295_Desc = {
    Text = "캐릭터가 없으므로 새로 생성해야 합니다."
  },
  TipsType_10296_Desc = {
    Text = "이미 캐릭터가 있으므로, 다시 생성할 필요 없습니다."
  },
  TipsType_10297_Desc = {
    Text = "중복된 캐릭터명."
  },
  TipsType_10298_Desc = {
    Text = "비경 오류"
  },
  TipsType_10299_Desc = {
    Text = "해당 스토리는 아직 오픈되지 않아, 들어갈 수 없습니다."
  },
  TipsType_10300_Desc = {
    Text = "이곳에서 지형 효과와 몬스터 정보를 확인할 수 있습니다."
  },
  TipsType_10301_Desc = {
    Text = "{s1} {s2} 달성 시 {s3} 해제"
  },
  TipsType_10302_Desc = {
    Text = "{s1} {s2} 달성 시 {s3} 해제"
  },
  TipsType_10303_Desc = {
    Text = "건물 해제 조건 미충족"
  },
  TipsType_10304_Desc = {
    Text = "건물 업그레이드 미충족"
  },
  TipsType_10305_Desc = {
    Text = "건물 업그레이드 재료가 부족합니다."
  },
  TipsType_10306_Desc = {
    Text = "수령할 수 있는 미션 보상이 있습니다."
  },
  TipsType_10307_Desc = {
    Text = "(HP가 <Negative:10%%> 감소합니다.)"
  },
  TipsType_10308_Desc = {
    Text = "매 턴 종료 시, 현재 보호 스택 수와 동일한 <BuffTipBlock:실타래드> 값을 획득합니다. 피해를 받을 때마다 보호가 <BuffTip:1>스택 감소합니다."
  },
  TipsType_10309_Desc = {
    Text = "다중 보호"
  },
  TipsType_10310_Desc = {
    Text = "스태미나가 경계 수치 이하일 때, 조사 위험도가 증가합니다"
  },
  TipsType_10311_Desc = {
    Text = "스태미나가 위험 수치 아래로 떨어졌습니다. 조사가 너무 위험합니다. 계속 진행하시겠습니까?"
  },
  TipsType_10312_Desc = {
    Text = "현재 스태미나가 너무 낮아 비경에 진입할 수 없습니다."
  },
  TipsType_10313_Desc = {
    Text = "동일한 레벨의 전용 카드를 선택하여 전환해 주세요."
  },
  TipsType_10314_Desc = {
    Text = "깨어남체 영혼 깨어남이 2급 달성 시 해당 방향 해제"
  },
  TipsType_10315_Desc = {
    Text = "깨어남체 영혼 깨어남이 3급 달성 시 해당 방향 해제"
  },
  TipsType_10316_Desc = {Text = "현재"},
  TipsType_10317_Desc = {
    Text = "모든 깨어남체의 스킬이 잠겨 있어 충전할 수 없습니다."
  },
  TipsType_10318_Desc = {
    Text = "모든 깨어남체 스킬의 에너지가 가득 찼습니다."
  },
  TipsType_10319_Desc = {Text = "사용됨"},
  TipsType_10320_Desc = {
    Text = "검은 인장 부족"
  },
  TipsType_10321_Desc = {
    Text = "검은 인장 부족"
  },
  TipsType_10322_Desc = {
    Text = "검은 인장 부족"
  },
  TipsType_10323_Desc = {
    Text = "이미 보유한 유물을 중복으로 획득할 수 없습니다."
  },
  TipsType_10324_Desc = {
    Text = "갱신 횟수가 부족합니다."
  },
  TipsType_10325_Desc = {
    Text = "아군에게 {s1} 피해를 입힙니다."
  },
  TipsType_10326_Desc = {Text = "공격"},
  TipsType_10327_Desc = {
    Text = "여기서는 스테이지의 미니맵 미리보기가 표시되며, 플레이어는 전략을 미리 세울 수 있습니다."
  },
  TipsType_10328_Desc = {
    Text = "10분 만에 일일 던전 중 한 스테이지를 완료하셨습니다. 여기서 독특한 플레이 경험을 획득하셨으며, 스테이지 디자인을 통해 스타일에 대한 이해를 강화하셨습니다."
  },
  TipsType_10329_Desc = {
    Text = "현재 HP 최대치가 최대 HP의 50% 미만입니다. 주의하시기 바랍니다."
  },
  TipsType_10330_Desc = {
    Text = "깨어남체의 존재를 유지하는 에너지입니다. 피해를 받으면 HP가 줄어들고, HP가 0이 되면 조사가 실타래패합니다."
  },
  TipsType_10331_Desc = {
    Text = "깨어남체의 공격 강도를 나타냅니다. 힘이 강할수록 명령 카드를 사용 시 적에게 입히는 피해가 증가합니다."
  },
  TipsType_10332_Desc = {
    Text = "깨어남체의 방어 능력을 나타냅니다. 경계가 높을수록 명령 카드 사용 시 획득하는 실타래드가 많아집니다."
  },
  TipsType_10333_Desc = {
    Text = "아무 곳이나 클릭하여 계속하기"
  },
  TipsType_10334_Desc = {
    Text = "미션 조사 항목 미완료"
  },
  TipsType_10335_Desc = {
    Text = "조사 평가"
  },
  TipsType_10336_Desc = {
    Text = "계시의 영혼을 지닌 전용 카드 1장 부여"
  },
  TipsType_10337_Desc = {
    Text = "전용 카드의 강화 방향 선택"
  },
  TipsType_10338_Desc = {
    Text = "주 도시의 미니맵 기능이 아직 오픈되지 않았습니다. 기대해 주세요."
  },
  TipsType_10339_Desc = {
    Text = "{s1} {s2}값"
  },
  TipsType_10340_Desc = {
    Text = "{s1} 기본 카드 세트 레벨 상승"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:호감도:>"
  },
  TipsType_10342_Desc = {
    Text = "깨어남체와의 감정적 연결을 나타냅니다. 호감도가 깊어지면 깨어남체를 더욱 깊이 이해할 수 있습니다."
  },
  TipsType_10343_Desc = {
    Text = "<Positive:현재 레벨:> {s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:기본 카드 세트:>"
  },
  TipsType_10345_Desc = {
    Text = "해당 영역에 진입할 때 소유한 초기 카드 세트입니다."
  },
  TipsType_10346_Desc = {
    Text = "<Positive:카드 세트의 최고 레벨:> Lv.{s1}"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:카드 세트 레벨:>"
  },
  TipsType_10348_Desc = {
    Text = "해당 영역의 지정된 수의 깨어남체가 특정 호감도 등급에 도달하면 기본 카드 세트를 업그레이드할 수 있습니다."
  },
  TipsType_10349_Desc = {
    Text = "<Positive:업그레이드 내용:>"
  },
  TipsType_10350_Desc = {
    Text = "업그레이드할 때마다 하나의 명령 카드의 기본 값이 증가합니다."
  },
  TipsType_10351_Desc = {
    Text = "{s1} 호감도 상승"
  },
  TipsType_10352_Desc = {
    Text = "비경 침묵 중"
  },
  TipsType_10353_Desc = {
    Text = "비경은 침입자를 배척합니다."
  },
  TipsType_10354_Desc = {
    Text = "비경 배척도 증가"
  },
  TipsType_10355_Desc = {
    Text = "배척도가 {s1}에 도달했습니다. 비경이 당신을 지켜보고 있습니다."
  },
  TipsType_10356_Desc = {
    Text = "영혼 깨어남 1"
  },
  TipsType_10357_Desc = {
    Text = "해당 스킬 숙달"
  },
  TipsType_10358_Desc = {
    Text = "동시에 존재할 수 있는 촉수의 최대 수량"
  },
  TipsType_10359_Desc = {
    Text = "촉수 공격 강도를 나타냅니다. 촉수의 힘이 강할수록, 촉수를 사용할 때 적에게 가하는 피해가 커집니다."
  },
  TipsType_10360_Desc = {
    Text = "명령 카드 미선택"
  },
  TipsType_10361_Desc = {
    Text = "변화 성공"
  },
  TipsType_10362_Desc = {
    Text = "명령 카드 미선택"
  },
  TipsType_10363_Desc = {
    Text = "복사 성공"
  },
  TipsType_10364_Desc = {
    Text = "{s1}장의 명령 카드가 선택되었습니다."
  },
  TipsType_10365_Desc = {
    Text = "명령 카드 미선택"
  },
  TipsType_10366_Desc = {
    Text = "명령 카드 미선택"
  },
  TipsType_10367_Desc = {
    Text = "업그레이드 성공"
  },
  TipsType_10368_Desc = {
    Text = "유물 물자 기능 개발 중. 기대해 주세요."
  },
  TipsType_10369_Desc = {
    Text = "변화시킬 유물을 선택하세요."
  },
  TipsType_10370_Desc = {
    Text = "버전이 업데이트되었습니다. 게임을 다시 다운로드해 주세요."
  },
  TipsType_10371_Desc = {
    Text = "고급 효과"
  },
  TipsType_10372_Desc = {
    Text = "비경 정보"
  },
  TipsType_10373_Desc = {
    Text = "공격 카드를 1장 사용할 때마다, 촉수가 랜덤한 적에게 {s1} 피해를 입힙니다."
  },
  TipsType_10374_Desc = {
    Text = "현재 완료해야 할 과제가 없습니다."
  },
  TipsType_10375_Desc = {
    Text = "현재 보관된 과제가 없습니다"
  },
  TipsType_10376_Desc = {
    Text = "이번 조사 미완료 과제"
  },
  TipsType_10377_Desc = {
    Text = "되돌릴 수 없습니다."
  },
  TipsType_10378_Desc = {
    Text = "(다음 과제가 자동으로 보관되었습니다.)"
  },
  TipsType_10379_Desc = {
    Text = "목표 과제가 완료되었습니다."
  },
  TipsType_10380_Desc = {
    Text = "해당 아이템을 소지하고 있지 않습니다."
  },
  TipsType_10381_Desc = {
    Text = "잘못된 인덱스 값"
  },
  TipsType_10382_Desc = {Text = "미개방"},
  TipsType_10383_Desc = {
    Text = "전용 카드 업그레이드, 횟수 제한 없음"
  },
  TipsType_10384_Desc = {
    Text = "유물 보존 슬롯 1개가 해제되었습니다!"
  },
  TipsType_10385_Desc = {
    Text = "연결률 향상"
  },
  TipsType_10386_Desc = {
    Text = "슬롯 정보가 없습니다."
  },
  TipsType_10387_Desc = {
    Text = "재화가 부족합니다."
  },
  TipsType_10388_Desc = {
    Text = "최대 레벨에 도달했습니다."
  },
  TipsType_10389_Desc = {
    Text = "개발 중입니다. 기대해 주세요."
  },
  TipsType_10390_Desc = {
    Text = "수동 업그레이드 슬롯이 더 이상 남아 있지 않습니다."
  },
  TipsType_10391_Desc = {
    Text = "상점이나 캠프에서 봉인을 해제한 후 사용할 수 있습니다."
  },
  TipsType_10392_Desc = {
    Text = "이번 전투에서 스태미나 {s1}을(를) 소모합니다."
  },
  TipsType_10393_Desc = {
    Text = "깨어남체 에너지가 가득 차서 더 이상 강화할 수 없습니다."
  },
  TipsType_10394_Desc = {
    Text = "모든 깨어남체의 에너지가 상승되었습니다."
  },
  TipsType_10395_Desc = {
    Text = "‘눈’을 사용하여 해제해야 합니다."
  },
  TipsType_10396_Desc = {
    Text = "성공적으로 각인되었습니다."
  },
  TipsType_10397_Desc = {
    Text = "{s1} 깨어남체가 배치되었습니다. 파티에 {s2} 영역 특성이 부여됩니다."
  },
  TipsType_10398_Desc = {
    Text = "파티는 중립이 되며 어떠한 영역 특성도 가지지 않습니다."
  },
  TipsType_10399_Desc = {
    Text = "작은 사이클 시스템 검증이 제4장 스테이지에서 오픈됩니다."
  },
  TipsType_10400_Desc = {
    Text = "유물은 {s1}개까지 계승시킬 수 있습니다. 선택한 유물의 수를 줄여주세요."
  },
  TipsType_10401_Desc = {
    Text = "선택되지 않은 유물은 계승되지 않습니다."
  },
  TipsType_10405_Desc = {
    Text = "{s1}을(를) 획득하셨습니다"
  },
  TipsType_10406_Desc = {
    Text = "배치한 깨어남체가 최대 수량에 도달했습니다."
  },
  TipsType_10407_Desc = {
    Text = "해당 황금탑은 도전할 수 없습니다."
  },
  TipsType_10408_Desc = {
    Text = "해당 황금탑은 아직 해제되지 않았습니다. - 지정된 조사 던전을 완료해 주세요."
  },
  TipsType_10409_Desc = {
    Text = "출전시킬 깨어남체를 선택해 주세요."
  },
  TipsType_10410_Desc = {
    Text = "깨어남체가 파견 미션을 열심히 수행 중입니다. 나중에 다시 와서 수령해 주세요."
  },
  TipsType_10411_Desc = {
    Text = "장미 금권 {s1} 개 수령 완료"
  },
  TipsType_10412_Desc = {
    Text = "시간 보상은 시간에 따라 누적됩니다"
  },
  TipsType_10413_Desc = {
    Text = "「은심」이 부족합니다"
  },
  TipsType_10414_Desc = {
    Text = "도전 횟수가 없습니다."
  },
  TipsType_10415_Desc = {
    Text = "도전 쿨다운 중"
  },
  TipsType_10416_Desc = {
    Text = "도전할 상대가 없습니다."
  },
  TipsType_10417_Desc = {
    Text = "배치할 깨어남체를 선택하세요."
  },
  TipsType_10418_Desc = {
    Text = "영지 약제가 부족하여 레벨을 상승시킬 수 없습니다."
  },
  TipsType_10419_Desc = {
    Text = "최대 레벨에 도달했습니다"
  },
  TipsType_10420_Desc = {
    Text = "깨어남체 미개방"
  },
  TipsType_10421_Desc = {
    Text = "즐겨찾기 해제 성공"
  },
  TipsType_10422_Desc = {
    Text = "스토리 라인 도전 구매 횟수가 부족합니다."
  },
  TipsType_10423_Desc = {
    Text = "스토리 라인의 등급이 부족하여 소탕이 불가능합니다."
  },
  TipsType_10424_Desc = {
    Text = "조사 파티의 영역 조합 오류"
  },
  TipsType_10425_Desc = {
    Text = "「은심」이 부족합니다"
  },
  TipsType_10426_Desc = {
    Text = "오늘의 증표 구매 횟수가 최대치에 도달했습니다."
  },
  TipsType_10427_Desc = {
    Text = "비밀의 영역 3성 완료 시 해제"
  },
  TipsType_10428_Desc = {
    Text = "증표 {s1}장을 획득했습니다."
  },
  TipsType_10429_Desc = {
    Text = "도전 횟수 {s1}회를 획득했습니다."
  },
  TipsType_10430_Desc = {
    Text = "조사 작전 4-6 완료 시 해제"
  },
  TipsType_10431_Desc = {
    Text = "증표가 부족합니다"
  },
  TipsType_10432_Desc = {
    Text = "증표 구매 횟수가 부족합니다."
  },
  TipsType_10433_Desc = {
    Text = "영혼 깨어남 등급이 최대치에 도달했습니다."
  },
  TipsType_10434_Desc = {
    Text = "「{s1}」이(가) 부족합니다"
  },
  TipsType_10435_Desc = {
    Text = "해당 상품은 판매되지 않습니다."
  },
  TipsType_10436_Desc = {
    Text = "해당 종류의 상점이 없습니다."
  },
  TipsType_10437_Desc = {
    Text = "해당 상품은 품절되었습니다."
  },
  TipsType_10438_Desc = {
    Text = "상점 데이터가 없습니다."
  },
  TipsType_10439_Desc = {
    Text = "갱신 횟수가 없습니다."
  },
  TipsType_10440_Desc = {
    Text = "오늘 ‘메노핀’ 구매 가능 횟수를 초과했습니다."
  },
  TipsType_10441_Desc = {
    Text = "깨어남체 파편이 부족합니다."
  },
  TipsType_10442_Desc = {
    Text = "영혼 깨어남점이 활성화되었습니다."
  },
  TipsType_10443_Desc = {
    Text = "영혼 깨어남점이 활성화되지 않았습니다."
  },
  TipsType_10444_Desc = {
    Text = "‘메노핀’ × {s1} 구매 성공"
  },
  TipsType_10445_Desc = {
    Text = "‘메노핀’이 최대치에 도달했습니다."
  },
  TipsType_10446_Desc = {
    Text = "조사 1-12 완료 시 해제"
  },
  TipsType_10447_Desc = {
    Text = "프롤로그 완료 시 해제"
  },
  TipsType_10448_Desc = {
    Text = "프롤로그 완료 시 해제"
  },
  TipsType_10449_Desc = {
    Text = "조사 작전 2-4 완료 시 해제"
  },
  TipsType_10450_Desc = {
    Text = "스킬 레벨이 최대치에 도달했습니다."
  },
  TipsType_10451_Desc = {
    Text = "깨어남체 승격 등급이 부족합니다."
  },
  TipsType_10452_Desc = {
    Text = "스킬 업그레이드 재료가 부족합니다."
  },
  TipsType_10453_Desc = {
    Text = "조사 작전 3-15 완료 시 해제"
  },
  TipsType_10454_Desc = {
    Text = "조사 작전 3-7 완료 시 해제"
  },
  TipsType_10455_Desc = {
    Text = "스킬 업그레이드에 필요한 조건을 충족하지 못했습니다."
  },
  TipsType_10456_Desc = {
    Text = "테스트 버전에서는 각 충전 항목에 대해 최대 1회만 충전 가능합니다."
  },
  TipsType_10457_Desc = {
    Text = "해당 깨어남체 본원 강림이 쿨다운 중입니다. 다음 턴에 발동하세요."
  },
  TipsType_10458_Desc = {
    Text = "충전 설정표에 해당하는 설정이 없습니다."
  },
  TipsType_10459_Desc = {
    Text = "이미 무료 충전을 사용하여, 재충전할 수 없습니다."
  },
  TipsType_10460_Desc = {
    Text = "공명이 이미 활성화되어 추가적인 활성화가 필요하지 않습니다."
  },
  TipsType_10461_Desc = {
    Text = "아이템 {s1}의 가격이 변경되었으니, 확인해 주세요."
  },
  TipsType_10462_Desc = {
    Text = "「장미 금권」이 부족합니다"
  },
  TipsType_10463_Desc = {
    Text = "「훈련 배지」가 부족합니다"
  },
  TipsType_10464_Desc = {
    Text = "조사 작전 3-4 완료 시 해제"
  },
  TipsType_10465_Desc = {
    Text = "조사 작전 2-16 완료 시 해제"
  },
  TipsType_10466_Desc = {
    Text = "조사 작전 3-16 완료 시 해제"
  },
  TipsType_10467_Desc = {
    Text = "조사 작전 4-12 완료 시 해제"
  },
  TipsType_10468_Desc = {
    Text = "조사 작전 5-12 완료 시 해제"
  },
  TipsType_10469_Desc = {
    Text = "조사 작전 6-12 완료 시 해제"
  },
  TipsType_10470_Desc = {
    Text = "조사 작전 1-7 완료 시 해제"
  },
  TipsType_10471_Desc = {
    Text = "장착 성공"
  },
  TipsType_10472_Desc = {
    Text = "장비 해제 성공"
  },
  TipsType_10473_Desc = {
    Text = "최대 레벨에 도달했습니다."
  },
  TipsType_10474_Desc = {
    Text = "「장미 금권」이 부족합니다"
  },
  TipsType_10475_Desc = {
    Text = "재료를 선택하세요."
  },
  TipsType_10476_Desc = {
    Text = "잠금 보호 중입니다. 먼저 잠금을 해제해 주세요."
  },
  TipsType_10477_Desc = {
    Text = "스테이지 미개방"
  },
  TipsType_10478_Desc = {
    Text = "전투 외에는 이용 불가합니다."
  },
  TipsType_10479_Desc = {
    Text = "버린 카드 더미가 비어 있습니다."
  },
  TipsType_10480_Desc = {
    Text = "RPG 전투 조정 중입니다. 현재 직접적인 승리로 처리됩니다."
  },
  TipsType_10482_Desc = {
    Text = "명륜이 잠겼습니다."
  },
  TipsType_10483_Desc = {
    Text = "명륜을 찾을 수 없습니다."
  },
  TipsType_10484_Desc = {
    Text = "명륜이 최대 등급에 도달했습니다."
  },
  TipsType_10485_Desc = {
    Text = "명륜이 장착되었습니다."
  },
  TipsType_10486_Desc = {
    Text = "명륜이 일치하지 않습니다."
  },
  TipsType_10487_Desc = {
    Text = "명륜이 잠겨 있지 않습니다."
  },
  TipsType_10488_Desc = {
    Text = "「편성」 「서포트」 「비밀 계약 방안」에서 사용 중인 비밀 계약은 분해할 수 없습니다."
  },
  TipsType_10489_Desc = {
    Text = "「편성」 「서포트」 에서 사용 중인 명륜은 분해할 수 없습니다."
  },
  TipsType_10490_Desc = {
    Text = "광기가 부족하여 광기 폭발을 사용할 수 없습니다."
  },
  TipsType_10491_Desc = {
    Text = "먼저 이전에 받은 선물을 수령해야 합니다."
  },
  TipsType_10492_Desc = {
    Text = "현재 비밀 계약이 잠겨 있습니다. 자원으로 사용하려면 해제해 주세요."
  },
  TipsType_10493_Desc = {
    Text = "현재 명륜이 잠겨 있습니다. 자원으로 사용하려면 해제해 주세요."
  },
  TipsType_10494_Desc = {
    Text = "조사 작전 1-7 완료 시 해제"
  },
  TipsType_10495_Desc = {
    Text = "조사 작전 1-13 완료 시 해제"
  },
  TipsType_10496_Desc = {
    Text = "현재 비밀 계약의 레벨이 최대치에 도달했습니다."
  },
  TipsType_10497_Desc = {
    Text = "상점이 초기화되었습니다."
  },
  TipsType_10498_Desc = {
    Text = "교체 성공"
  },
  TipsType_10499_Desc = {
    Text = "수집 성공"
  },
  TipsType_10500_Desc = {
    Text = "중첩 성공"
  },
  TipsType_10501_Desc = {
    Text = "도전 미개방"
  },
  TipsType_10502_Desc = {
    Text = "현재 깨어남체는 {s1}의 다른 스테이지에서 도전했으므로 다시 출전할 수 없습니다."
  },
  TipsType_10503_Desc = {
    Text = "배치된 깨어남체가 4명 미만이어서 도전할 수 없습니다."
  },
  TipsType_10504_Desc = {
    Text = "조사 작전 3-7 완료 시 해제"
  },
  TipsType_10505_Desc = {
    Text = "제1층 3성 달성 시 해제"
  },
  TipsType_10506_Desc = {
    Text = "제2층 3성 달성 시 해제"
  },
  TipsType_10507_Desc = {
    Text = "제3층 3성 달성 시 해제"
  },
  TipsType_10508_Desc = {
    Text = "제4층 3성 달성 시 해제"
  },
  TipsType_10509_Desc = {
    Text = "제5층 3성 달성 시 해제"
  },
  TipsType_10510_Desc = {
    Text = "제6층 3성 달성 시 해제"
  },
  TipsType_10511_Desc = {
    Text = "제7층 3성 달성 시 해제"
  },
  TipsType_10512_Desc = {
    Text = "제8층 3성 달성 시 해제"
  },
  TipsType_10513_Desc = {
    Text = "강화할 비밀 계약을 선택해 주세요."
  },
  TipsType_10514_Desc = {
    Text = "수령 완료"
  },
  TipsType_10515_Desc = {
    Text = "조사 작전 2-14 완료 시 해제"
  },
  TipsType_10516_Desc = {
    Text = "조사 작전 4-7 완료 시 해제"
  },
  TipsType_10517_Desc = {
    Text = "조사 작전 4-7 완료 시 해제"
  },
  TipsType_10518_Desc = {
    Text = "편성이 저장되었습니다."
  },
  TipsType_10519_Desc = {
    Text = "빛나는 구역을 클릭하여 이동하세요."
  },
  TipsType_10520_Desc = {
    Text = "파티 이름은 중국어, 영어, 숫자로만 구성되어야 합니다."
  },
  TipsType_10521_Desc = {
    Text = "파티 이름의 길이는 8자를 초과할 수 없습니다."
  },
  TipsType_10522_Desc = {
    Text = "파티 내 깨어남체 수가 {s1}개 부족하여 조사를 진행할 수 없습니다."
  },
  TipsType_10523_Desc = {
    Text = "해당 깨어남체는 이미 무광의 영역 해당 층의 다른 비경에서 전투에 참여했습니다."
  },
  TipsType_10524_Desc = {
    Text = "파티에 이미 두 개의 다른 영역의 깨어남체가 존재합니다. 다른 영역의 깨어남체를 선택할 수 없습니다."
  },
  TipsType_10525_Desc = {
    Text = "깨어남체를 하나 선택해 주세요."
  },
  TipsType_10526_Desc = {
    Text = "더 이상 깨어남체를 선택할 수 없습니다"
  },
  TipsType_10527_Desc = {
    Text = "육성 주의: 환몽 심잠에서는, 깨어남체의 레벨 및 스킬 레벨이 모두 레벨1로 조정됩니다."
  },
  TipsType_10528_Desc = {
    Text = "파티 이름은 비어 있을 수 없습니다."
  },
  TipsType_10529_Desc = {
    Text = "파티에 지친 깨어남체가 있어 더 이상 전투를 진행할 수 없습니다."
  },
  TipsType_10530_Desc = {
    Text = "우편함 내 첨부 아이템을 모두 수령하였습니다."
  },
  TipsType_10531_Desc = {
    Text = "프롤로그 스토리 완료 시 해제"
  },
  TipsType_10532_Desc = {
    Text = "물자가 가득 차서 아이템을 받지 못했습니다. 물자 속을 정리한 후 계속 수령해 주세요."
  },
  TipsType_10533_Desc = {
    Text = "물자 속이 가득 차, 보상은 우편함으로 지급됩니다."
  },
  TipsType_10534_Desc = {
    Text = "물자 속이 가득 차서 아이템을 전부 수령하지 못했습니다. 물자 안을 정리한 후 계속 수령해 주세요."
  },
  TipsType_10535_Desc = {
    Text = "수령 가능한 편지 첨부물이 없습니다."
  },
  TipsType_10536_Desc = {
    Text = "먼저 유물을 교환해야 합니다."
  },
  TipsType_10537_Desc = {
    Text = "조사 작전 2-4 완료 시 해제"
  },
  TipsType_10538_Desc = {
    Text = "조사 작전 1-12 완료 시 해제"
  },
  TipsType_10539_Desc = {
    Text = "조사 작전 1-12 완료 시 해제"
  },
  TipsType_10540_Desc = {
    Text = "조사 작전 1-12 완료 시 해제"
  },
  TipsType_10541_Desc = {
    Text = "제9층 3성 달성 시 해제"
  },
  TipsType_10542_Desc = {
    Text = "제10층 3성 달성 시 해제"
  },
  TipsType_10543_Desc = {
    Text = "제11층 3성 달성 시 해제"
  },
  TipsType_10544_Desc = {
    Text = "제12층 3성 달성 시 해제"
  },
  TipsType_10545_Desc = {
    Text = "제13층 3성 달성 시 해제"
  },
  TipsType_10546_Desc = {
    Text = "제14층 3성 달성 시 해제"
  },
  TipsType_10547_Desc = {
    Text = "이 기능은 곧 제거될 예정입니다."
  },
  TipsType_10548_Desc = {
    Text = "조사 작전 1-7 완료 시 해제"
  },
  TipsType_10549_Desc = {
    Text = "유물 획득 한도에 도달하여 더 이상 획득할 수 없습니다."
  },
  TipsType_10550_Desc = {
    Text = "{s1}연결 완료. 이제 전투에 참여시킬 수 있습니다!"
  },
  TipsType_10551_Desc = {
    Text = "{s1}의 레벨과 스킬 레벨이 영지 증폭기에서 제공하는 레벨을 초과했습니다. 사용할 수 없습니다."
  },
  TipsType_10552_Desc = {
    Text = "깨어남체 레벨과 스킬 레벨이 영지 증폭기에서 제공하는 레벨을 초과했습니다. 사용할 수 없습니다."
  },
  TipsType_10553_Desc = {
    Text = "기대해 주세요."
  },
  TipsType_10554_Desc = {
    Text = "이전 스테이지를 클릭하면 해제됩니다."
  },
  TipsType_10555_Desc = {
    Text = "취약한 길에서는 되돌아갈 수 없습니다."
  },
  TipsType_10556_Desc = {
    Text = "아직 오픈되지 않았습니다. 기대해 주세요."
  },
  TipsType_10557_Desc = {
    Text = "이미 해당 유물을 보유 중입니다. 중복으로 획득할 수 없습니다."
  },
  TipsType_10558_Desc = {
    Text = "시스템 클립보드의 내용을 가져와 <긍정: [붙여넣기]>를 진행합니다. 계속하시겠습니까?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "취소"},
  TipsType_10558_RightBtnDesc = {Text = "확인"},
  TipsType_10558_Title = {
    Text = "붙여넣기 기능 활성화"
  },
  TipsType_10559_Desc = {
    Text = "승격 재료 부족"
  },
  TipsType_10560_Desc = {
    Text = "이미 초기 상태입니다."
  },
  TipsType_10561_Desc = {
    Text = "‘장미 금권’ 부족"
  },
  TipsType_10562_Desc = {Text = "미승격"},
  TipsType_10563_Desc = {
    Text = "공명 초기화 성공"
  },
  TipsType_10564_Desc = {
    Text = "조사 등급 {s1}에 도달 시 해제"
  },
  TipsType_10565_Desc = {
    Text = "봉인된 광기는 해제가 불가능합니다"
  },
  TipsType_1056601_Desc = {
    Text = "은심 통신에 문제가 발생했습니다. 네트워크를 확인하고 다시 시도해 주세요. ({s1})"
  },
  TipsType_10566_Desc = {
    Text = "은심 통신에 이상이 있습니다. 잠시 후 다시 시도해 주세요. ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "서버 정보 로딩 실타래패! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "먼저 서버를 선택해 주세요."
  },
  TipsType_10569_Desc = {Text = "미개방"},
  TipsType_10570_Desc = {
    Text = "계정을 입력하세요."
  },
  TipsType_10571_Desc = {
    Text = "공명 활성화 재료 부족"
  },
  TipsType_10572_Desc = {
    Text = "선행 공명점 미업그레이드"
  },
  TipsType_10573_Desc = {
    Text = "최고 레벨 도달"
  },
  TipsType_10574_Desc = {
    Text = "업그레이드 성공"
  },
  TipsType_10575_Desc = {
    Text = "해당 깨어남체 교체 불가"
  },
  TipsType_10576_Desc = {
    Text = "해당 위치 배치 불가"
  },
  TipsType_10577_Desc = {
    Text = "깨어남체 수가 부족하여 도전이 불가능합니다"
  },
  TipsType_10578_Desc = {
    Text = "다음 스테이지 미개방"
  },
  TipsType_10579_Desc = {
    Text = "이미 마지막 스테이지에 도달했습니다"
  },
  TipsType_10580_Desc = {
    Text = "현재 경험치 한계에 도달하여 더 이상 추가할 수 없습니다"
  },
  TipsType_10581_Desc = {
    Text = "명륜 슬롯이 가득 차서 추가할 수 없습니다."
  },
  TipsType_10582_Desc = {
    Text = "빠른 투입이 가능한 재료가 없습니다."
  },
  TipsType_10583_Desc = {
    Text = "명륜 슬롯에 재료를 넣어 주세요."
  },
  TipsType_10584_Desc = {
    Text = "장착할 수 있는 명륜이 없습니다."
  },
  TipsType_10585_Desc = {
    Text = "조사 작전 2-8 완료 시 해제"
  },
  TipsType_10586_Desc = {
    Text = "조사 작전 2-14 완료 시 해제"
  },
  TipsType_10587_Desc = {
    Text = "조사 작전 3-16 완료 시 해제"
  },
  TipsType_10588_Desc = {
    Text = "조사 작전 4-12 완료 시 해제"
  },
  TipsType_10589_Desc = {
    Text = "조사 작전 5-12 완료 시 해제"
  },
  TipsType_10590_Desc = {
    Text = "조사 작전 6-12 완료 시 해제"
  },
  TipsType_10591_Desc = {
    Text = "조사 작전 2-12 완료 시 해제"
  },
  TipsType_10592_Desc = {
    Text = "해당 계정의 로그인이 제한되었습니다, 의문 사항은 고객 센터로 문의 부탁드립니다."
  },
  TipsType_10593_Desc = {
    Text = "로그인 세션이 만료되었습니다. 다시 로그인해 주세요."
  },
  TipsType_10594_Desc = {
    Text = "현재 「메노핀」이 부족합니다."
  },
  TipsType_10595_Desc = {
    Text = "{s1}을(를) 활성화하시겠습니까?"
  },
  TipsType_10595_Title = {
    Text = "특성 활성화"
  },
  TipsType_10596_Desc = {
    Text = "해당 깨어남체를 아직 보유하고 있지 않습니다."
  },
  TipsType_10597_Desc = {
    Text = "강화할 수 있는 명륜이 없습니다."
  },
  TipsType_10598_Desc = {
    Text = "해당 계정은 관련 규정을 위반하여 {s1}까지 로그인 금지 처리되었습니다. 문의 사항은 고객센터로 연락 바랍니다."
  },
  TipsType_10599_Desc = {
    Text = "조사 작전 2-15 완료 시 해제"
  },
  TipsType_10600_Desc = {
    Text = "레벨 한도에 도달하여 더 이상 추가할 수 없습니다."
  },
  TipsType_10601_Desc = {
    Text = "조사 작전 1-7 완료 시 수호자 성장 기록 해제"
  },
  TipsType_10602_Desc = {
    Text = "조사 작전 1-7 완료 시 영역 마스터리 미션 오픈"
  },
  TipsType_10603_Desc = {
    Text = "소재가 선택되지 않았습니다."
  },
  TipsType_10604_Desc = {
    Text = "장시간 조작이 없어 던전에서 자동 퇴장됩니다."
  },
  TipsType_10605_Desc = {
    Text = "설문 작성이 완료되었습니다. 힘이 되어주셔서 감사합니다!"
  },
  TipsType_10606_Desc = {
    Text = "활성화에 필요한 재료가 부족합니다."
  },
  TipsType_10607_Desc = {
    Text = "이번 주 보상 횟수가 모두 소진되어, 도전해도 보상을 받을 수 없습니다. 그래도 도전하시겠습니까?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "취소"},
  TipsType_10607_RightBtnDesc = {Text = "확인"},
  TipsType_10607_Title = {
    Text = "도전 알림"
  },
  TipsType_10608_Desc = {
    Text = "캠퍼스를 열심히 가꾸고 있습니다, 점검이 끝날 때까지 기다려주세요."
  },
  TipsType_10609_Desc = {
    Text = "{s1}을(를) 기숙사에 성공적으로 초대했습니다."
  },
  TipsType_10610_Desc = {
    Text = "{s1}은(는) 이미 기숙사에 있습니다."
  },
  TipsType_10611_Desc = {
    Text = "현재 Wi-Fi 네트워크가 아닌 상태입니다. 데이터 네트워크를 사용하여 계속 다운로드하시겠습니까?\n(데이터 통화료가 부과될 수 있습니다.)"
  },
  TipsType_10611_LeftBtnDesc = {Text = "취소"},
  TipsType_10611_RightBtnDesc = {Text = "확인"},
  TipsType_10611_Title = {
    Text = "다운로드 확인"
  },
  TipsType_10612_Desc = {
    Text = "모든 카드가 각인되었습니다."
  },
  TipsType_10613_Desc = {
    Text = "네트워크 오류가 발생했습니다, 잠시만 기다려 주세요."
  },
  TipsType_10614_Desc = {
    Text = "도전 미개방"
  },
  TipsType_10615_Desc = {
    Text = "쿨타임 중, 다음 턴에 사용 가능"
  },
  TipsType_10616_Desc = {
    Text = "선택 진행 중입니다. 선택이 완료되어야 발동할 수 있습니다."
  },
  TipsType_10617_Desc = {
    Text = "현재 광기 폭발이 해방 조건을 충족하지 않아 해방할 수 없습니다."
  },
  TipsType_10618_Desc = {
    Text = "현재 파티의 평균 레벨 {s1}이 추천 레벨인 {s2} 보다 낮습니다. 조사를 진행하면 큰 도전을 마주할 수 있습니다. 계속하시겠습니까?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "강화하기"
  },
  TipsType_10618_RightBtnDesc = {Text = "확인"},
  TipsType_10618_Title = {
    Text = "조사 확인"
  },
  TipsType_10619_Desc = {
    Text = "조사 등급 {s1} 레벨 이후에 사용할 수 있습니다."
  },
  TipsType_10620_Desc = {
    Text = "네트워크 상태가 불안정합니다. Steam 연결을 확인하거나 Steam을 리셋한 후 다시 시도해 주세요."
  },
  TipsType_10621_Desc = {
    Text = "<WeaponEffect_Num:{s1}>을(를) 이름으로 사용하시겠습니까?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "취소"},
  TipsType_10621_RightBtnDesc = {Text = "확인"},
  TipsType_10621_Title = {
    Text = "각인 확인"
  },
  TipsType_10622_Desc = {
    Text = "각인 쿨다운 중, {s1}시간 {s2}분 후에 다시 각인할 수 있습니다."
  },
  TipsType_10623_Desc = {
    Text = "각인 성공"
  },
  TipsType_10624_Desc = {
    Text = "이름은 중국어, 영어, 숫자로만 구성할 수 있습니다."
  },
  TipsType_10625_Desc = {
    Text = "이 카드는 곧 폐기될 것입니다."
  },
  TipsType_10626_Desc = {
    Text = "Steam에서 다음 옵션을 활성화 해주세요.\n[Steam 설정-게임 중-게임 중 Steam 인터페이스 사용]\n그 후 게임을 리셋하여 적용해 주세요."
  },
  TipsType_10626_RightBtnDesc = {Text = "확인"},
  TipsType_10626_Title = {Text = "알림"},
  TipsType_10628_Desc = {
    Text = "새 이름은 현재 이름과 중복될 수 없습니다."
  },
  TipsType_10629_Desc = {
    Text = "{s1}~{s2}개의 문자를 입력하세요."
  },
  TipsType_10630_Desc = {
    Text = "{s1} 3성 달성 시 재현 가능"
  },
  TipsType_10631_Desc = {
    Text = "계정이 이용 약관을 위반하여 강제 로그아웃 처리되었습니다."
  },
  TipsType_10631_RightBtnDesc = {Text = "확인"},
  TipsType_10631_Title = {Text = "안내"},
  TipsType_10632_Desc = {
    Text = "도전을 완료한 후, 오늘의 재현을 진행할 수 있습니다."
  },
  TipsType_10633_Desc = {
    Text = "이번 분해에서는 다음 물자를 소모하며, <Blue:분해 후에는 회복할 수 없습니다>. 분해를 진행하시겠습니까?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "취소"},
  TipsType_10633_RightBtnDesc = {Text = "확인"},
  TipsType_10633_Title = {
    Text = "분해 확인"
  },
  TipsType_10634_Desc = {
    Text = "현재 월간 패스 남은 일수가 {s1}일을 초과하여 누적할 수 없습니다."
  },
  TipsType_10635_Desc = {
    Text = "필요한 「원액」이 부족합니다. 원액 추출로 이동하시겠습니까?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "취소"},
  TipsType_10635_RightBtnDesc = {Text = "확인"},
  TipsType_10635_Title = {
    Text = "원액 부족"
  },
  TipsType_10636_Desc = {
    Text = "현재 사용하지 않는 명륜이 없습니다."
  },
  TipsType_10637_Desc = {
    Text = "현재 사용하지 않는 비밀 계약이 없습니다."
  },
  TipsType_10638_Desc = {
    Text = "비어 있는 비밀 계약 슬롯이 없습니다. 장비를 해제한 후 다시 시도해 주세요."
  },
  TipsType_10640_Desc = {
    Text = "해당 깨어남체에 장착한 비밀 계약을 모두 해제하시겠습니까?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "취소"},
  TipsType_10640_RightBtnDesc = {Text = "확인"},
  TipsType_10640_Title = {Text = "힌트"},
  TipsType_10641_Desc = {
    Text = "언어를 변경한 후에는 클라이언트를 재시작해야 적용됩니다. 다시 시작하시겠습니까?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "취소"},
  TipsType_10641_RightBtnDesc = {Text = "확인"},
  TipsType_10641_Title = {
    Text = "언어 변경 확인"
  },
  TipsType_10642_Desc = {
    Text = "수호자 조사 등급 부족"
  },
  TipsType_10643_Desc = {
    Text = "부식에 오염된 지역에 진입하면, HP가 {s1}pt 감소합니다."
  },
  TipsType_10644_Desc = {
    Text = "이미 해당 열쇠 지령을 선택했습니다."
  },
  TipsType_10645_Desc = {
    Text = "미획득한 열쇠 지령"
  },
  TipsType_10646_Desc = {
    Text = "「{s1}」이(가) 부족합니다"
  },
  TipsType_10647_Desc = {
    Text = "조사 이벤트가 아직 시작되지 않았습니다, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "로테이션 간격이 갱신되었습니다."
  },
  TipsType_10649_Desc = {
    Text = "현재 파견 가능한 수량이 최대치에 도달했습니다."
  },
  TipsType_10650_Desc = {
    Text = "현재 해제된 SSR 깨어남체가 없습니다."
  },
  TipsType_10651_Desc = {
    Text = "일정 수량에 도달해야 사용할 수 있습니다."
  },
  TipsType_10652_Desc = {
    Text = "현재 획득하지 않은 프로필과 전투 이모티콘이 없습니다."
  },
  TipsType_10701_Desc = {
    Text = "현재 장착된 명륜이 있습니다. 해제 후 다시 시도해주세요."
  },
  TipsType_10702_Desc = {
    Text = "장착한 SSR 명륜의 추가 중첩가 12에 도달하면, SSR 명륜을 동시에 2개 장착할 수 있습니다."
  },
  TipsType_10703_Desc = {
    Text = "깨어남체에 이미 동일한 명륜이 장착되어 있어 장착할 수 없습니다."
  },
  TipsType_10704_Desc = {
    Text = "비밀 계약 레벨이 최대치에 도달했습니다."
  },
  TipsType_10705_Desc = {
    Text = "소모 재료 수량이 최대치에 도달했습니다."
  },
  TipsType_10706_Desc = {
    Text = "부가 속성은 최대 2개까지 잠글 수 있습니다."
  },
  TipsType_10707_Desc = {
    Text = "전승 재료 부족"
  },
  TipsType_10708_Desc = {
    Text = "깨어남체 승격 {s1}단계 후 오픈"
  },
  TipsType_10709_Desc = {
    Text = "「{s1}」이(가) 부족합니다"
  },
  TipsType_10710_Desc = {Text = "품절"},
  TipsType_10711_Desc = {
    Text = "해당 상품은 해제되지 않았습니다."
  },
  TipsType_10712_Desc = {
    Text = "소모 재료가 최대치에 도달했습니다."
  },
  TipsType_10713_Desc = {
    Text = "명륜이 최대 중첩에 도달했습니다."
  },
  TipsType_10714_Desc = {
    Text = "이벤트 조건이 충족되지 않아 선택할 수 없습니다."
  },
  TipsType_10715_Desc = {
    Text = "해당 앱을 설치한 후에 공유해 주세요."
  },
  TipsType_10716_Desc = {
    Text = "명륜 선택 수량이 최대치에 도달했습니다"
  },
  TipsType_10717_Desc = {
    Text = "은열쇠 선택 수량이 최대치에 도달했습니다"
  },
  TipsType_10718_Desc = {
    Text = "활성화 성공"
  },
  TipsType_10719_Desc = {
    Text = "「천면 인장」이 부족합니다. 「치환 설정」에서 재료 교환을 선택할 수 있습니다."
  },
  TipsType_10720_Desc = {
    Text = "1배속으로 전환되었습니다."
  },
  TipsType_10721_Desc = {
    Text = "2배속으로 전환되었습니다."
  },
  TipsType_10722_Desc = {
    Text = "대학 입구가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  TipsType_10723_Desc = {
    Text = "저장 성공"
  },
  TipsType_10724_Desc = {
    Text = "저장에 실타래패했습니다. 앨범 권한이 없거나 저장 공간이 부족합니다."
  },
  TipsType_10725_Desc = {
    Text = "재료가 부족합니다."
  },
  TipsType_10726_Desc = {
    Text = "카드를 선택하세요."
  },
  TipsType_10727_Desc = {
    Text = "해당 깨어남체는 비활성화되었습니다."
  },
  TipsType_10728_Desc = {
    Text = "본원 형태는 파견할 수 없습니다. 다시 선택해 주세요."
  },
  TipsType_10736_Desc = {
    Text = "「메노핀」이 충분하여 보충할 필요가 없습니다."
  },
  TipsType_10737_Desc = {
    Text = "신규 버전이 출시되었습니다, 원활한 미사그 생활을 위해 재접속하여 업데이트를 받아주세요."
  },
  TipsType_10738_Desc = {
    Text = "현재 읽을 수 있는 튜토리얼이 없습니다."
  },
  TipsType_10739_Desc = {
    Text = "{s1}이(가) {s2}에서 이미 도전을 완료하여, 다시 출전할 수 없습니다."
  },
  TipsType_10740_Desc = {
    Text = "현재 조사 등급 {s1}이 추천 등급인 {s2} 보다 낮습니다. 조사를 진행하면 큰 도전을 마주할 수 있습니다. 계속하시겠습니까?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "취소"},
  TipsType_10740_RightBtnDesc = {Text = "확인"},
  TipsType_10740_Title = {
    Text = "조사 확인"
  },
  TipsType_10741_Desc = {
    Text = "현재 파티의 평균 레벨 {s1}과 수호자 조사 등급 {s2}이 모두 추천 레벨보다 낮습니다. 조사를 진행하면 막대한 도전을 마주할 수 있습니다. 계속하시겠습니까?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "취소"},
  TipsType_10741_RightBtnDesc = {Text = "확인"},
  TipsType_10741_Title = {
    Text = "조사 확인"
  },
  TipsType_10742_Desc = {
    Text = "파티 내의 동일한 명륜 효과는 중복 발동되지 않습니다. 현재 <Blue:{s1}> 명륜 효과가 활성화되지 않은 상태입니다.\n명륜 장비를 다시 조정한 뒤 조사를 진행하시길 권장합니다. 그래도 조사를 진행하시겠습니까?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "취소"},
  TipsType_10742_RightBtnDesc = {Text = "확인"},
  TipsType_10742_Title = {
    Text = "조사 확인"
  },
  TipsType_10743_Desc = {
    Text = "디-이펙트 존에 남아있는 서포트 횟수가 없습니다."
  },
  TipsType_10744_Desc = {
    Text = "팔로워 수가 최대치에 도달했습니다."
  },
  TipsType_10745_Desc = {
    Text = "생일 날짜가 잘못되어, 설정할 수 없습니다."
  },
  TipsType_10746_Desc = {
    Text = "클립보드에 복사되었습니다."
  },
  TipsType_10747_Desc = {
    Text = "좋아요 성공"
  },
  TipsType_10748_Desc = {
    Text = "{s1}은(는) 이미 서포트 깨어남체입니다."
  },
  TipsType_10749_Desc = {
    Text = "서포트 깨어남체는 비어 있을 수 없습니다."
  },
  TipsType_10750_Desc = {
    Text = "오늘 이미 이 수호자에게 좋아요를 눌렀습니다."
  },
  TipsType_10751_Desc = {
    Text = "최대 4명의 깨어남체를 전시할 수 있습니다."
  },
  TipsType_10752_Desc = {
    Text = "영역이 요구 사항을 충족하지 않아 출전할 수 없습니다."
  },
  TipsType_10753_Desc = {
    Text = "{s1}은(는) 이미 전투에 배치되어 있으며, 중복 선택할 수 없습니다."
  },
  TipsType_10754_Desc = {
    Text = "{s1} 초기화 완료"
  },
  TipsType_10755_Desc = {
    Text = "해제 성공"
  },
  TipsType_10756_Desc = {
    Text = "현재 사용할 수 있는 중첩 재료가 없습니다."
  },
  TipsType_10757_Desc = {
    Text = "{s1}은(는) 오늘의 이벤트에서 이미 도전했으므로, 다시 참여할 수 없습니다."
  },
  TipsType_10758_Desc = {
    Text = "파티 영역이 조건에 맞지 않습니다"
  },
  TipsType_10761_Desc = {
    Text = "본원 형태 깨어남체는 일반 형태와 동시에 출전할 수 없습니다."
  },
  TipsType_10762_Desc = {
    Text = "본원 형태 깨어남체는 일반 형태와 동시에 표시할 수 없습니다."
  },
  TipsType_10799_Desc = {
    Text = "현재<Blue:{s1}>의 비밀 계약 6세트 효과가 <Blue:파티 단독>의 제한으로 적용되지 않았습니다. 비밀 계약을 재조정한 후 조사를 다시 진행해 주시기 바랍니다.\n조사를 계속 진행하겠습니까?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "취소"},
  TipsType_10799_RightBtnDesc = {Text = "확인"},
  TipsType_10799_Title = {
    Text = "조사 확인"
  },
  TipsType_10801_Desc = {
    Text = "비밀 계약 방안 수량이 최대치에 도달했습니다"
  },
  TipsType_10802_Desc = {
    Text = "{s1}은 이미 다른 비밀 계약을 방 안에서 사용 중이므로 저장할 수 없습니다"
  },
  TipsType_10803_Desc = {
    Text = "비밀 계약 방안 이름은 비워둘 수 없습니다"
  },
  TipsType_10804_Desc = {
    Text = "올바르지 않은 문자가 포함되어 있어, 다시 입력해 주세요."
  },
  TipsType_10805_Desc = {
    Text = "저장되었습니다."
  },
  TipsType_10806_Desc = {
    Text = "해당 비밀 계약은 {s1}에서 사용 중입니다"
  },
  TipsType_10807_Desc = {
    Text = "장착 완료"
  },
  TipsType_10808_Desc = {
    Text = "장착 해제됨"
  },
  TipsType_10809_Desc = {
    Text = "해당 파티이 이미 출전 중입니다."
  },
  TipsType_10810_Desc = {
    Text = "비밀 계약 방안은 비어 있을 수 없습니다."
  },
  TipsType_10811_Desc = {
    Text = "현재 이 방안이 장착되어 있습니다."
  },
  TipsType_10812_Desc = {
    Text = "장착 완료"
  },
  TipsType_10813_Desc = {
    Text = "【{s1}】방안을 삭제하시겠습니까?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "취소"},
  TipsType_10813_RightBtnDesc = {Text = "확인"},
  TipsType_10814_Desc = {
    Text = "이번 조사에 배치된 깨어남체가 파티 요구 사항을 충족하지 않습니다."
  },
  TipsType_10815_Desc = {
    Text = "현재 깨어남체는 스토리의 특별한 디자인으로 인해, 세부 정보를 확인할 수 없습니다."
  },
  TipsType_10816_Desc = {
    Text = "‘대리 증표’ 부족"
  },
  TipsType_10817_Desc = {
    Text = "현재 결산 기록이 없습니다. 먼저 ‘도전’을 완료하고, 다음 날 9:00에 결산 후 다시 실타래행해 주세요."
  },
  TipsType_10818_Desc = {
    Text = "오늘의 대리가 완료되어 더 이상 반복할 수 없습니다."
  },
  TipsType_10821_Desc = {
    Text = "현재 획득 가능한 아이템이 없습니다. 잠시 후에 다시 확인해 주세요."
  },
  TipsType_10822_Desc = {
    Text = "이벤트가 종료되었습니다."
  },
  TipsType_10823_Desc = {
    Text = "특수 씨앗이 품절되면 상점에 재고 보충을 요청할 수 있습니다."
  },
  TipsType_10824_Desc = {
    Text = "재고 보충 회수가 모두 소진되었습니다. 더 이상 보유한 재고가 없습니다."
  },
  TipsType_10825_Desc = {
    Text = "‘{s1}’ 부족"
  },
  TipsType_10826_Desc = {
    Text = "특수 씨앗이 품절되었습니다. 씨앗을 심어 초기화할 수 있습니다."
  },
  TipsType_10827_Desc = {
    Text = "특수 씨앗이 초기화되었습니다."
  },
  TipsType_10828_Desc = {
    Text = "아이템이 전부 교환되었습니다. 초기화를 선택해 주세요."
  },
  TipsType_10829_Desc = {
    Text = "초기화 성공"
  },
  TipsType_10830_Desc = {
    Text = "파티에 출전할 수 없는 깨어남체가 있어 조사를 시작할 수 없습니다."
  },
  TipsType_10831_Desc = {
    Text = "파티에 동일한 명륜이 포함되어 있어 디-이펙트 존에 진입할 수 없습니다."
  },
  TipsType_10832_Desc = {
    Text = "파티가 열쇠 지령을 장착하지 않아 조사를 시작할 수 없습니다."
  },
  TipsType_10833_Desc = {
    Text = "파티에 장착할 수 없는 명륜이 있어 조사를 시작할 수 없습니다."
  },
  TipsType_10834_Desc = {
    Text = "서포트 깨어남체에는 명륜을 장착할 수 없습니다."
  },
  TipsType_10835_Desc = {
    Text = "서포트 깨어남체에는 비밀 계약을 장착할 수 없습니다."
  },
  TipsType_10836_Desc = {
    Text = "스토리 사전 설정 깨어남체에는 명륜을 장착할 수 없습니다."
  },
  TipsType_10837_Desc = {
    Text = "스토리 사전 설정 깨어남체에는 비밀 계약을 장착할 수 없습니다."
  },
  TipsType_10838_Desc = {
    Text = "이모티콘 프리셋의 이모티콘 개수가 최대치에 도달했습니다."
  },
  TipsType_10839_Desc = {
    Text = "이모티콘이 사용되었습니다. 이모티콘 프리셋에 있는 이모티콘을 클릭하면 해제됩니다."
  },
  TipsType_10840_Desc = {
    Text = "이모티콘 너무 빨리 보냈습니다."
  },
  TipsType_10841_Desc = {
    Text = "이모티콘 프리셋은 비어 있을 수 없습니다."
  },
  TipsType_10842_Desc = {
    Text = "이모티콘 프리셋이 업데이트되었습니다."
  },
  TipsType_10843_Desc = {
    Text = "해당 항목은 아직 해제되지 않았습니다"
  },
  TipsType_10844_Desc = {Text = "미개방"},
  TipsType_10850_Desc = {
    Text = "파티에 장착할 수 없는 열쇠 지령이 존재하여 조사를 시작할 수 없습니다."
  },
  TipsType_10901_Desc = {Text = "마비"},
  TipsType_10902_Desc = {Text = "기절"},
  TipsType_10903_Desc = {
    Text = "{s1} 미보유"
  },
  TipsType_10904_Desc = {
    Text = "본 챕터의 「보통」 모드를 클리어하면, 「꿈의 회상」 모드를 통해 스토리를 감상할 수 있습니다."
  },
  TipsType_10905_Desc = {
    Text = "「조사 작전」 1-15·보통 완료 시 「꿈의 회상」 모드를 해제할 수 있습니다."
  },
  TipsType_10906_Desc = {
    Text = "「현실타래의 기점」이 부족합니다"
  },
  TipsType_10907_Desc = {Text = "해제됨"},
  TipsType_10908_Desc = {
    Text = "{s1}영혼 깨어남 레벨이 가득 찼습니다. 계속 수령하면 <TipsHighlightText:‘정제된 노시스 조각’× 2>, <TipsHighlightText:‘노시스 조각’× 6>, <TipsHighlightText:‘원초의 침전’× 250>으로 전환됩니다. 소환하시겠습니까?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "취소"},
  TipsType_10908_RightBtnDesc = {Text = "확인"},
  TipsType_10908_Title = {
    Text = "소화 확인"
  },
  TipsType_10909_Desc = {
    Text = "{s1}이 소환되었습니다. 계속 수령 시 <TipsHighlightText:‘잔편·{s2}’× 1>과 <TipsHighlightText:‘근원 침전’× 50>으로 전환됩니다. 소환하시겠습니까?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "취소"},
  TipsType_10909_RightBtnDesc = {Text = "확인"},
  TipsType_10909_Title = {
    Text = "소화 확인"
  },
  TipsType_10910_Desc = {
    Text = "<TipsHighlightText:{s1}>를 소환하시겠습니까?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "취소"},
  TipsType_10910_RightBtnDesc = {Text = "확인"},
  TipsType_10910_Title = {
    Text = "소화 확인"
  },
  TipsType_10911_Desc = {
    Text = "공간 부족"
  },
  TipsType_10912_Desc = {
    Text = "초차원 공간에 명령 카드가 없어서 사용할 수 없습니다."
  },
  TipsType_10913_Desc = {
    Text = "이번 턴에서는 다시 사용할 수 없습니다"
  },
  TipsType_10914_Desc = {
    Text = "정말 <TipsHighlightText:{s1}>을(를) 선택하시겠습니까?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "취소"},
  TipsType_10914_RightBtnDesc = {Text = "확인"},
  TipsType_10914_Title = {
    Text = "선택 확인"
  },
  TipsType_10915_Desc = {
    Text = "편성 해제는 순서대로 진행해야 하며, 해제되지 않은 편성을 건너뛸 수 없습니다."
  },
  TipsType_10916_Desc = {
    Text = "<Blue: {s1} × {s2}>를 소모하여 해제하시겠습니까?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "취소"},
  TipsType_10916_RightBtnDesc = {Text = "확인"},
  TipsType_10916_Title = {
    Text = "해제 확인"
  },
  TipsType_10917_Desc = {
    Text = "{s1} 해제 성공"
  },
  TipsType_10918_Desc = {
    Text = "{s1} 해제 성공, 파티이 모두 해제되었습니다."
  },
  TipsType_10919_Desc = {
    Text = "[{s1}:{s2}] 완료 후 해제됩니다. [{s1}](으)로 이동하시겠습니까?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "취소"},
  TipsType_10919_RightBtnDesc = {Text = "확인"},
  TipsType_10919_Title = {Text = "미개방"},
  TipsType_10920_Desc = {
    Text = "기간 한정 이벤트 ‘위상 역전’에서 ‘마법의 도토리’ × {s1}개를 모으면 해제됩니다! ‘위상 역전’으로 이동하시겠습니까?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "취소"},
  TipsType_10920_RightBtnDesc = {Text = "확인"},
  TipsType_10920_Title = {Text = "미개방"},
  TipsType_10921_Desc = {
    Text = "주 속성이 같은 명륜을 동시에 장착할 수 없습니다."
  },
  TipsType_20001_Desc = {
    Text = "체크박스를 통해 2차 확인"
  },
  TipsType_20001_LeftBtnDesc = {Text = "확인"},
  TipsType_20001_Title = {Text = "제목"},
  TipsType_20002_Desc = {
    Text = "체크박스를 선택하지 않고 확인"
  },
  TipsType_20002_LeftBtnDesc = {Text = "취소"},
  TipsType_20002_RightBtnDesc = {Text = "확인"},
  TipsType_20002_Title = {Text = "제목"},
  TipsType_20003_Desc = {
    Text = "계정이 다른 기기에서 로그인되었습니다."
  },
  TipsType_20003_RightBtnDesc = {Text = "확인"},
  TipsType_20003_Title = {
    Text = "연결 끊김 알림"
  },
  TipsType_20004_Desc = {
    Text = "서버와의 연결이 끊어졌습니다. 다시 로그인해 주세요."
  },
  TipsType_20004_RightBtnDesc = {Text = "확인"},
  TipsType_20004_Title = {
    Text = "연결 끊김 알림"
  },
  TipsType_20005_Desc = {
    Text = "동기화 실타래패, 다시 시도하시겠습니까?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "취소"},
  TipsType_20005_RightBtnDesc = {Text = "확인"},
  TipsType_20005_Title = {
    Text = "동기화 실타래패"
  },
  TipsType_20006_Desc = {
    Text = "동기화에 실타래패했습니다. 잠시 후 로그인 화면으로 돌아갑니다."
  },
  TipsType_20006_RightBtnDesc = {Text = "확인"},
  TipsType_20006_Title = {
    Text = "동기화 실타래패"
  },
  TipsType_20007_Desc = {
    Text = "동기화에 실타래패했습니다. 잠시 후 로그인 화면으로 돌아갑니다."
  },
  TipsType_20007_RightBtnDesc = {Text = "확인"},
  TipsType_20007_Title = {
    Text = "동기화 실타래패"
  },
  TipsType_20008_Desc = {
    Text = "이번 조사는 <Positive:{s1}> 스태미나를 소모합니다. 정말 끝내시겠습니까?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "취소"},
  TipsType_20008_RightBtnDesc = {Text = "확인"},
  TipsType_20008_Title = {
    Text = "탐사 종료"
  },
  TipsType_20009_Desc = {
    Text = "새로고침 시 각인과 유물이 갱신되지만, 깨어남체 깨어남과 명령 카드 판매 횟수는 초기화되지 않습니다. 새로고침하시겠습니까?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "취소"},
  TipsType_20009_RightBtnDesc = {Text = "확인"},
  TipsType_20009_Title = {
    Text = "새로고침 확인"
  },
  TipsType_20010_Desc = {
    Text = "해당 영역의 깨어남체가 부족합니다. 파티를 계속 생성하시겠습니까?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "취소"},
  TipsType_20010_RightBtnDesc = {Text = "확인"},
  TipsType_20011_Desc = {
    Text = "선택된 깨어남체가 없어 편성이 유지되지 않습니다."
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "나가기 확인"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "편성 계속하기"
  },
  TipsType_20012_Desc = {
    Text = "깨어남체가 선택되지 않았습니다"
  },
  TipsType_20012_RightBtnDesc = {Text = "확인"},
  TipsType_20013_Desc = {
    Text = "파티에 빈 자리가 남아 있습니다. 그래도 출발하시겠습니까?"
  },
  TipsType_20013_LeftBtnDesc = {
    Text = "돌아가기"
  },
  TipsType_20013_RightBtnDesc = {Text = "출발"},
  TipsType_20014_Desc = {
    Text = "파티 수량이 최대치에 도달했습니다."
  },
  TipsType_20014_RightBtnDesc = {Text = "확인"},
  TipsType_20015_Desc = {
    Text = "해당 파티를 삭제하시겠습니까?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "취소"},
  TipsType_20015_RightBtnDesc = {Text = "확인"},
  TipsType_20016_Desc = {
    Text = "{s1} 완료 후 해제"
  },
  TipsType_20016_RightBtnDesc = {Text = "확인"},
  TipsType_20017_Desc = {
    Text = "이곳에서 지도 정보와 이미 처치한 몬스터 정보를 확인할 수 있습니다. 현재 버전에서는 이 기능이 아직 개발되지 않았습니다."
  },
  TipsType_20017_RightBtnDesc = {Text = "확인"},
  TipsType_20018_Desc = {
    Text = "아직 스테이지 해제 조건을 충족하지 않았습니다."
  },
  TipsType_20018_RightBtnDesc = {Text = "확인"},
  TipsType_20018_Title = {
    Text = "빠른 탐사"
  },
  TipsType_20019_Desc = {
    Text = "「은심」이 부족합니다, 상점에서 구매하시겠습니까?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "취소"},
  TipsType_20019_RightBtnDesc = {Text = "이동"},
  TipsType_20020_Desc = {
    Text = "고급 {s1}을(를) 완료한 후 이 고급 난이도가 해제됩니다."
  },
  TipsType_20020_RightBtnDesc = {Text = "확인"},
  TipsType_20021_Desc = {
    Text = "{s1} 보통 모드를 완료한 후에 고급 훈련이 해제됩니다."
  },
  TipsType_20021_RightBtnDesc = {Text = "확인"},
  TipsType_20022_Desc = {
    Text = "「은심」이 부족합니다, 상점에서 구매하시겠습니까?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "취소"},
  TipsType_20022_RightBtnDesc = {Text = "확인"},
  TipsType_20022_Title = {
    Text = "은심이 부족합니다."
  },
  TipsType_20023_Desc = {
    Text = "경험치가 {s1}만큼 초과됩니다(반환되지 않음). 캐릭터가 최대 등급에 도달하면 더 이상 경험치를 획득할 수 없습니다. 계속하시겠습니까?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "취소"},
  TipsType_20023_RightBtnDesc = {Text = "확인"},
  TipsType_20024_Desc = {
    Text = "파티 인원이 부족하여 던전에 진입할 수 없습니다."
  },
  TipsType_20024_RightBtnDesc = {Text = "확인"},
  TipsType_20026_Desc = {
    Text = "에너지 충전을 하시겠습니까?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "취소"},
  TipsType_20026_RightBtnDesc = {Text = "확인"},
  TipsType_20027_Desc = {
    Text = "HP를 회복하시겠습니까?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "취소"},
  TipsType_20027_RightBtnDesc = {Text = "확인"},
  TipsType_20028_Desc = {
    Text = "이 창을 닫으면 [{s1}]을(를) 얻을 수 없게 됩니다. 정말로 포기하시겠습니까?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "취소"},
  TipsType_20028_RightBtnDesc = {Text = "확인"},
  TipsType_20029_Desc = {
    Text = "이 창을 닫으면 이번 이벤트를 건너뛰게 됩니다(유물은 제거되지 않음). 건너뛰시겠습니까?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "취소"},
  TipsType_20029_RightBtnDesc = {Text = "확인"},
  TipsType_20030_Desc = {
    Text = "선택한 유물은 보관할 수 없습니다. 계승을 포기하시겠습니까?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "취소"},
  TipsType_20030_RightBtnDesc = {Text = "확인"},
  TipsType_20031_Desc = {
    Text = "전투에서 이탈하시겠습니까?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "취소"},
  TipsType_20031_RightBtnDesc = {Text = "확인"},
  TipsType_20032_Desc = {
    Text = "현재 스테이지는 해제되지 않았습니다. 해제를 위해 클리어 조사 스테이지로 이동하시겠습니까?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "취소"},
  TipsType_20032_RightBtnDesc = {Text = "확인"},
  TipsType_20032_Title = {Text = "미개방"},
  TipsType_20033_Desc = {
    Text = "현재 도전 횟수가 부족합니다. 「은심」 × 500을 소모하여 초기화하시겠습니까?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "취소"},
  TipsType_20033_RightBtnDesc = {Text = "확인"},
  TipsType_20034_Desc = {
    Text = "현재 도전이 쿨다운 중입니다. 「은심」 × 50을 소모하여 초기화하시겠습니까?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "취소"},
  TipsType_20034_RightBtnDesc = {Text = "확인"},
  TipsType_20035_Desc = {
    Text = "추천 레벨은 {s1}이며, 현재 파티 평균 레벨은 {s2}입니다. 조사에 어려움이 예상됩니다. 계속 진행하시겠습니까?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "취소"},
  TipsType_20035_RightBtnDesc = {Text = "확인"},
  TipsType_20035_Title = {
    Text = "전투력 부족"
  },
  TipsType_20036_Desc = {
    Text = "현재 소탕 횟수가 {s1}회로 설정되었으나, 도전 시 {s2} 스태미나를 소모하여 1회 보상만 획득하게 됩니다. 그래도 도전하시겠습니까?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "취소"},
  TipsType_20036_RightBtnDesc = {Text = "확인"},
  TipsType_20036_Title = {
    Text = "도전 확인"
  },
  TipsType_20037_Desc = {
    Text = "강화 재료 중 고급 재료가 포함되어 있습니다. 강화하시겠습니까?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "취소"},
  TipsType_20037_RightBtnDesc = {Text = "확인"},
  TipsType_20037_Title = {
    Text = "강화 확인"
  },
  TipsType_20038_Desc = {
    Text = "이 장비는 현재 잠금 상태입니다. 잠금을 해제하시겠습니까?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "취소"},
  TipsType_20038_RightBtnDesc = {Text = "확인"},
  TipsType_20039_Desc = {
    Text = "확인 시 이번 조사는 실타래패로 처리되며, 이후 조사 보상을 획득할 수 없습니다. 조사를 종료하시겠습니까?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "취소"},
  TipsType_20039_RightBtnDesc = {Text = "확인"},
  TipsType_20039_Title = {
    Text = "조사 나가기"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:현재 조사를 포기하려면 「메노핀」 {s1}개가 소모됩니다.> 확인 후 이번 조사는 실타래패로 처리되며, 이후의 조사 보상을 받을 수 없습니다. 조사를 종료하시겠습니까?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "취소"},
  TipsType_20040_RightBtnDesc = {Text = "확인"},
  TipsType_20040_Title = {
    Text = "조사 나가기"
  },
  TipsType_20041_BottomDesc = {
    Text = "보유 중인 시간 압축 허가증: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "시간 압축 허가증 {s1}개를 사용하여 가속하시겠습니까?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "취소"},
  TipsType_20041_RightBtnDesc = {Text = "확인"},
  TipsType_20041_Title = {
    Text = "가속 확인"
  },
  TipsType_20042_Desc = {
    Text = "RPG 전투 조정 중입니다. 현재 직접적인 승리로 처리됩니다."
  },
  TipsType_20042_LeftBtnDesc = {Text = "취소"},
  TipsType_20042_RightBtnDesc = {Text = "확인"},
  TipsType_20043_Desc = {
    Text = "{s1} 은심을 사용하여 현재 미션을 갱신하시겠습니까?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "취소"},
  TipsType_20043_RightBtnDesc = {Text = "확인"},
  TipsType_20043_Title = {
    Text = "미션 갱신"
  },
  TipsType_20044_BottomDesc = {
    Text = "연구 허가증 {s1}장 소모"
  },
  TipsType_20044_Desc = {
    Text = "{s1} 연구를 진행하시겠습니까?\n연구 효과: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {Text = "취소"},
  TipsType_20044_RightBtnDesc = {Text = "확인"},
  TipsType_20044_Title = {
    Text = "연구 확인"
  },
  TipsType_20045_BottomDesc = {
    Text = "연구를 취소하면 현재까지의 연구 진행 상태는 보존되지 않습니다."
  },
  TipsType_20045_Desc = {
    Text = "{s1} 연구를 취소하시겠습니까? (연구 허가증이 전액 반환됩니다.)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "취소"},
  TipsType_20045_RightBtnDesc = {Text = "확인"},
  TipsType_20045_Title = {
    Text = "연구 취소"
  },
  TipsType_20046_Desc = {
    Text = "「은심」 {s1}개를 소모하여 가속하시겠습니까?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "취소"},
  TipsType_20046_RightBtnDesc = {Text = "확인"},
  TipsType_20046_Title = {
    Text = "가속 확인"
  },
  TipsType_20047_Desc = {
    Text = "{s1}개의 <Blue:「{s2}」>가/이 부족합니다. <Blue:「은심」×{s3} >을(를) 소모하여 구매하시겠습니까?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "취소"},
  TipsType_20047_RightBtnDesc = {Text = "확인"},
  TipsType_20047_Title = {
    Text = "구매 확인"
  },
  TipsType_20048_Desc = {
    Text = "{s1}개의 <Blue:「{s2}」>가/이 부족합니다. <Blue:「은심」×{s3} >을(를) 소모하여 구매하시겠습니까?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "취소"},
  TipsType_20048_RightBtnDesc = {Text = "확인"},
  TipsType_20048_Title = {
    Text = "구매 확인"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:「{s1}」>이 <Blue:「{s2}」>에 장착되어 있습니다. 교체하시겠습니까?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "취소"},
  TipsType_20049_RightBtnDesc = {Text = "확인"},
  TipsType_20049_Title = {
    Text = "교체 알림"
  },
  TipsType_20050_Desc = {
    Text = "명륜의 사용량이 최대 중첩를 초과했습니다. 계속하시겠습니까?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "취소"},
  TipsType_20050_RightBtnDesc = {Text = "확인"},
  TipsType_20050_Title = {
    Text = "중첩 알림"
  },
  TipsType_20051_Desc = {
    Text = "중첩 수량이 명륜의 최대 중첩 레벨을 초과하게 됩니다. 중첩 후 초과된 수량에 따라 해당하는 수량의 명륜이 반환됩니다. 계속하시겠습니까?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "취소"},
  TipsType_20051_RightBtnDesc = {Text = "확인"},
  TipsType_20051_Title = {
    Text = "중첩 알림"
  },
  TipsType_20052_Desc = {
    Text = "추천 레벨은 {s1}이며, 현재 파티 평균 레벨은 {s2}입니다. 조사에 상당한 어려움이 예상됩니다. 계속 진행하시겠습니까?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "취소"},
  TipsType_20052_RightBtnDesc = {Text = "확인"},
  TipsType_20052_Title = {
    Text = "전투력 부족"
  },
  TipsType_20053_Desc = {
    Text = "추천 레벨은 {s1}이며, 현재 파티의 평균 레벨은 {s2}입니다. 조사에 매우 큰 어려움이 예상됩니다. 계속 진행하시겠습니까?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "취소"},
  TipsType_20053_RightBtnDesc = {Text = "확인"},
  TipsType_20053_Title = {
    Text = "전투력 부족"
  },
  TipsType_20054_Desc = {
    Text = "현재 도전 보상을 모두 수령했습니다. 계속 도전해도 보상을 받을 수 없습니다. 계속하시겠습니까?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "취소"},
  TipsType_20054_RightBtnDesc = {Text = "확인"},
  TipsType_20054_Title = {
    Text = "도전 확인"
  },
  TipsType_20055_Desc = {
    Text = "초기화하면 현재 스테이지의 진행도가 0으로 돌아가고, 깨어남체 출전 기록도 함께 삭제됩니다. 초기화하시겠습니까?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "취소"},
  TipsType_20055_RightBtnDesc = {Text = "확인"},
  TipsType_20055_Title = {
    Text = "초기화 확인"
  },
  TipsType_20056_Desc = {
    Text = "도전에 성공하면, 현재 편성된 4명의 깨어남체는 {s1}의 다른 스테이지에 출전할 수 없게 됩니다. 도전 확인하시겠습니까?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "취소"},
  TipsType_20056_RightBtnDesc = {Text = "확인"},
  TipsType_20056_Title = {
    Text = "도전 확인"
  },
  TipsType_20057_Desc = {
    Text = "파티 구성이 아카데미 교범의 권장 지침을 위반하고 있습니다. 그래도 도전을 계속하시겠습니까?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "취소"},
  TipsType_20057_RightBtnDesc = {Text = "확인"},
  TipsType_20057_Title = {
    Text = "편성 확인"
  },
  TipsType_20058_Desc = {
    Text = "현재 스테이지는 이미 완료되었습니다. 다시 도전하려면 진행도를 0성으로 초기화해야 하며, 이때 깨어남체 출전 기록도 함께 삭제됩니다. 초기화하시겠습니까?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "취소"},
  TipsType_20058_RightBtnDesc = {Text = "확인"},
  TipsType_20058_Title = {
    Text = "초기화 확인"
  },
  TipsType_20059_Desc = {
    Text = "현재 파티의 깨어남체가 4명 미만으로 전투에 진입할 수 없습니다."
  },
  TipsType_20059_Title = {
    Text = "파티 편성 저장하기"
  },
  TipsType_20060_BottomDesc = {
    Text = "결과를 확인 시 다시 소환할 수 없습니다."
  },
  TipsType_20060_Desc = {
    Text = "이번 소환 결과를 선택하시겠습니까? (이번 소환에서 얻은 모든 깨어남체와 명륜을 획득하게 됩니다.)"
  },
  TipsType_20060_LeftBtnDesc = {Text = "취소"},
  TipsType_20060_RightBtnDesc = {Text = "확인"},
  TipsType_20060_Title = {
    Text = "선택 확인"
  },
  TipsType_20061_BottomDesc = {
    Text = "현재 은심: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "{s1}개의 ‘은심’을 소모하여 다시 소환하시겠습니까?\n(재소환 시 현재 뽑기 결과는 저장되지 않습니다.)"
  },
  TipsType_20061_LeftBtnDesc = {Text = "취소"},
  TipsType_20061_RightBtnDesc = {Text = "확인"},
  TipsType_20061_Title = {
    Text = "다시 소환하기"
  },
  TipsType_20062_Desc = {
    Text = "읽은 편지를 모두 삭제하시겠습니까?\n첨부물을 수령하지 않은 편지는 삭제되지 않습니다."
  },
  TipsType_20062_LeftBtnDesc = {Text = "취소"},
  TipsType_20062_RightBtnDesc = {Text = "확인"},
  TipsType_20062_Title = {
    Text = "읽은 편지 삭제하기"
  },
  TipsType_20063_Desc = {
    Text = "정말 삭제하시겠습니까?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "취소"},
  TipsType_20063_RightBtnDesc = {Text = "확인"},
  TipsType_20063_Title = {
    Text = "해당 우편 삭제하기"
  },
  TipsType_20064_Desc = {
    Text = "보관함의 편지가 삭제되면 복원할 수 없습니다.\n이 편지를 삭제하시겠습니까?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "취소"},
  TipsType_20064_RightBtnDesc = {Text = "확인"},
  TipsType_20064_Title = {
    Text = "소중한 편지 삭제하기"
  },
  TipsType_20065_Desc = {
    Text = "<Blue:{s1}>을(를) 소모하여 <Blue:{s2}>을(를) 합성하시겠습니까?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "취소"},
  TipsType_20065_RightBtnDesc = {Text = "확인"},
  TipsType_20065_Title = {
    Text = "합성 확인"
  },
  TipsType_20066_Desc = {
    Text = "<Blue:{s1}>을(를) 분해하여 <Blue:{s2}>을(를) 획득하시겠습니까?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "취소"},
  TipsType_20066_RightBtnDesc = {Text = "확인"},
  TipsType_20066_Title = {
    Text = "분해 확인"
  },
  TipsType_20067_Desc = {
    Text = "Blue:{s1}개의 SSR 등급 비밀 계약을 소모하여 Blue:{s2}개의 Blue:{s3}을(를) 재각인하시겠습니까?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "취소"},
  TipsType_20067_RightBtnDesc = {Text = "확인"},
  TipsType_20067_Title = {
    Text = "재인쇄 확인"
  },
  TipsType_20068_Desc = {
    Text = "모든 깨어남체가 전투 능력을 완전히 상실타래했습니다.\n\n유일한 수호자 님.\n이제 무엇을 선택하시겠습니까?"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "전투 다시 하기"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "잠시 후퇴하기"
  },
  TipsType_20068_Title = {
    Text = "조사 실타래패"
  },
  TipsType_20069_Desc = {
    Text = "선택한 깨어남체의 광기가 이미 최대치에 도달했습니다. 그래도 해당 깨어남체를 선택하시겠습니까?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "취소"},
  TipsType_20069_RightBtnDesc = {Text = "확인"},
  TipsType_20069_Title = {
    Text = "선택 확정"
  },
  TipsType_20070_Desc = {
    Text = "{s1}을(를) 사용하시겠습니까?\n레벨 또는 스킬이 강화된 깨어남체의 강화 자원은 반환되지 않습니다."
  },
  TipsType_20070_LeftBtnDesc = {Text = "취소"},
  TipsType_20070_RightBtnDesc = {Text = "확인"},
  TipsType_20070_Title = {
    Text = "증폭 확인"
  },
  TipsType_20071_Desc = {
    Text = "수호자의 조사 등급 제한으로 인해 깨어남체 레벨이 {s1}로 상승합니다. 부족한 강화 재료는 반환되지 않습니다. 계속하시겠습니까?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "취소"},
  TipsType_20071_RightBtnDesc = {Text = "확인"},
  TipsType_20071_Title = {
    Text = "증폭 확인"
  },
  TipsType_20072_Desc = {
    Text = "해당 스테이지의 모든 스토리를 건너뛰시겠습니까?\nP.S. 나중에 해당 스테이지에 다시 입장하여 스토리를 다시 볼 수 있습니다."
  },
  TipsType_20072_LeftBtnDesc = {Text = "취소"},
  TipsType_20072_RightBtnDesc = {Text = "확인"},
  TipsType_20072_Title = {
    Text = "건너뛰기"
  },
  TipsType_20073_Desc = {
    Text = "<Blue:{s1}>을(를) 분해하여 <Blue:{s2}>을(를) 획득하시겠습니까? (현재 비밀 계약은 강화되어 있으며, 분해 시 강화 재료는 반환되지 않습니다.)"
  },
  TipsType_20073_LeftBtnDesc = {Text = "취소"},
  TipsType_20073_RightBtnDesc = {Text = "확인"},
  TipsType_20073_Title = {
    Text = "분해 확인"
  },
  TipsType_20074_Desc = {
    Text = "<Blue:{s1}>을(를) 분해하여 <Blue:{s2}>을(를) 획득하시겠습니까?\n(현재 명륜의 희귀도가 높습니다)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "취소"},
  TipsType_20074_RightBtnDesc = {Text = "확인"},
  TipsType_20074_Title = {
    Text = "분해 확인"
  },
  TipsType_20075_BottomDesc = {
    Text = "연구 허가증 {s1} 장 소모"
  },
  TipsType_20075_Desc = {
    Text = "{s1} 연구를 시작하시겠습니까?\n생산 효율: {s2} 장미 금권/6시간당\n      —>{s3} 장미 금권/6시간당"
  },
  TipsType_20075_LeftBtnDesc = {Text = "취소"},
  TipsType_20075_RightBtnDesc = {Text = "확인"},
  TipsType_20075_Title = {
    Text = "연구 확인"
  },
  TipsType_20076_BottomDesc = {
    Text = "연구 허가증 {s1} 장 소모"
  },
  TipsType_20076_Desc = {
    Text = "{s1}의 연구를 시작하시겠습니까?\n생산 효율: {s2} 영지 비약/6시간당\n      —>{s3} 영지 비약/6시간당"
  },
  TipsType_20076_LeftBtnDesc = {Text = "취소"},
  TipsType_20076_RightBtnDesc = {Text = "확인"},
  TipsType_20076_Title = {
    Text = "연구 확인"
  },
  TipsType_20077_BottomDesc = {
    Text = "연구 허가증 {s1} 장 소모"
  },
  TipsType_20077_Desc = {
    Text = "{s1}의 연구를 시작하시겠습니까?\n생산 효율: {s2} 비밀 계약의 흔적/6시간당\n      —>{s3} 비밀 계약의 흔적/6시간당"
  },
  TipsType_20077_LeftBtnDesc = {Text = "취소"},
  TipsType_20077_RightBtnDesc = {Text = "확인"},
  TipsType_20077_Title = {
    Text = "연구 확인"
  },
  TipsType_20078_Desc = {
    Text = "해당 스테이지의 모든 스토리를 건너뛰시겠습니까?\nP.S. 나중에 해당 스테이지에 다시 입장하여 스토리를 다시 볼 수 있습니다."
  },
  TipsType_20078_LeftBtnDesc = {Text = "취소"},
  TipsType_20078_RightBtnDesc = {Text = "확인"},
  TipsType_20078_Title = {
    Text = "건너뛰기"
  },
  TipsType_20079_Desc = {
    Text = "은열쇠가 치명적인 위기를 감지했습니다. 응급 영지체를 활성화하시겠습니까?\n(부활 시 응급 영지체 1개가 소모되며, 매일 10시(한국 시간 기준)에 자동으로 1개를 획득합니다. 현재 남은 수량: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "취소"},
  TipsType_20079_RightBtnDesc = {Text = "확인"},
  TipsType_20079_Title = {
    Text = "부활 확인"
  },
  TipsType_20080_Desc = {
    Text = "은열쇠가 치명적인 위기를 감지했습니다. 응급 영지체를 활성화하시겠습니까?\n(부활 시 응급 영지체 1개가 소모되며, 매일 10시(한국 시간 기준)에 자동으로 1개를 획득합니다. 현재 남은 수량: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {Text = "확인"},
  TipsType_20080_Title = {
    Text = "부활 확인"
  },
  TipsType_20081_Desc = {
    Text = "게임 초기화에 실타래패했습니다. {s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "확인"},
  TipsType_20081_Title = {
    Text = "로그인 오류 알림"
  },
  TipsType_20082_Desc = {
    Text = "<Blue:「은심」× {s1} >를 소모하여 <Blue: {s2} >레벨을 구매하시겠습니까?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "취소"},
  TipsType_20082_RightBtnDesc = {Text = "확인"},
  TipsType_20082_Title = {Text = "레벨 업"},
  TipsType_20083_Desc = {
    Text = "명륜 {s1}을(를) 소모하여 강화하시겠습니까?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "취소"},
  TipsType_20083_RightBtnDesc = {Text = "확인"},
  TipsType_20083_Title = {
    Text = "소모 확인"
  },
  TipsType_20084_Desc = {
    Text = "파티의 평균 레벨이 스테이지 추천 레벨보다 낮아, 출전하는 깨어남체의 속성이 약화됩니다. 조사하시겠습니까?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "강화하러 가기"
  },
  TipsType_20084_RightBtnDesc = {Text = "확인"},
  TipsType_20084_Title = {
    Text = "조사 확인"
  },
  TipsType_20085_Desc = {
    Text = "게임 종료 확인"
  },
  TipsType_20085_LeftBtnDesc = {Text = "취소"},
  TipsType_20085_RightBtnDesc = {Text = "확인"},
  TipsType_20085_Title = {
    Text = "게임 종료"
  },
  TipsType_20086_Desc = {
    Text = "서버 점검 중"
  },
  TipsType_20086_RightBtnDesc = {Text = "확인"},
  TipsType_20086_Title = {
    Text = "연결 끊김 알림"
  },
  TipsType_20087_Desc = {
    Text = "<TipsHighlightText:{s1} × {s2}>를 소모하여 <TipsHighlightText:{s3}>를 활성화하시겠습니까?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "취소"},
  TipsType_20087_RightBtnDesc = {Text = "확인"},
  TipsType_20087_Title = {
    Text = "활성화 확인"
  },
  TipsType_20088_Desc = {
    Text = "수령할 시 「메노핀」이 초과되어, 초과하는 부분 {s1}은(는) 획득할 수 없습니다. 계속 수령하시겠습니까?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "취소"},
  TipsType_20088_RightBtnDesc = {Text = "확인"},
  TipsType_20088_Title = {
    Text = "메노핀 초과"
  },
  TipsType_20089_Desc = {
    Text = "「장미 금권」 ×<Blue: {s1}>를 소모하여 재고를 갱신합니다.\n남은 갱신 횟수: <Blue:{s2}> \n 갱신 횟수가 많을수록 필요한 「장미 금권」의 수량이 증가합니다."
  },
  TipsType_20089_LeftBtnDesc = {Text = "취소"},
  TipsType_20089_RightBtnDesc = {Text = "확인"},
  TipsType_20089_Title = {
    Text = "재고 갱신"
  },
  TipsType_20090_Desc = {
    Text = "명륜 수량이 최대치에 도달했습니다. 명륜을 정리해야만 소환할 수 있습니다. 이동하시겠습니까? \n\n<color=#ADC0CB>* 「설정」에서 SR/R 등급 명륜 자동 분해를 설정할 수 있습니다.</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "취소"},
  TipsType_20090_RightBtnDesc = {
    Text = "정리로 이동"
  },
  TipsType_20090_Title = {
    Text = "정리 알림"
  },
  TipsType_20091_Desc = {
    Text = "비밀 계약 수량이 최대치에 도달했습니다. 비밀 계약을 정리해야만 조사를 진행할 수 있습니다. 이동하시겠습니까?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "취소"},
  TipsType_20091_RightBtnDesc = {
    Text = "정리로 이동"
  },
  TipsType_20091_Title = {
    Text = "정리 알림"
  },
  TipsType_20092_Desc = {
    Text = "현재 깨어남체에 장착한 명륜을 모두 해제하시겠습니까?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "취소"},
  TipsType_20092_RightBtnDesc = {Text = "확인"},
  TipsType_20092_Title = {
    Text = "장비 해제 확인"
  },
  TipsType_20093_Desc = {
    Text = "소모 비밀 계약이 업그레이드되었습니다. 확인하시겠습니까?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "취소"},
  TipsType_20093_RightBtnDesc = {Text = "확인"},
  TipsType_20093_Title = {
    Text = "업그레이드 확인"
  },
  TipsType_20094_Desc = {
    Text = "기존 부가 속성에 더 좋은 속성이 있습니다. 교체하면 저장되지 않습니다, 그래도 교체하시겠습니까?"
  },
  TipsType_20094_LeftBtnDesc = {Text = "취소"},
  TipsType_20094_RightBtnDesc = {Text = "확인"},
  TipsType_20094_Title = {
    Text = "교체 확인"
  },
  TipsType_20095_Desc = {
    Text = "현재 전승된 부가 속성 중 좋은 속성이 존재합니다. 전승을 계속하면 저장되지 않습니다. 계속하시겠습니까?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "취소"},
  TipsType_20095_RightBtnDesc = {Text = "확인"},
  TipsType_20095_Title = {
    Text = "전승 확인"
  },
  TipsType_20096_Desc = {
    Text = "비밀 계약 업그레이드 후 레벨이 최대치를 초과하게 되며, 초과한 만큼의 전승 재료가 반환됩니다. 계속하시겠습니까?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "취소"},
  TipsType_20096_RightBtnDesc = {Text = "확인"},
  TipsType_20096_Title = {
    Text = "업그레이드 확인"
  },
  TipsType_20097_Desc = {
    Text = "해당 깨어남체의 영혼 깨어남치가 가득 찼습니다.\n선택 시 「영핵 조각」 × 3 및 「영핵 조각」 × 1만 획득할 수 있습니다."
  },
  TipsType_20097_LeftBtnDesc = {Text = "취소"},
  TipsType_20097_RightBtnDesc = {Text = "계속"},
  TipsType_20097_Title = {
    Text = "선택 확인"
  },
  TipsType_20098_Desc = {
    Text = "해당 상품은 <Blue:{s1}>장의 미스릴 거래 증표로 구매할 수 있습니다."
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "현금 결제"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "증표 결제"
  },
  TipsType_20098_Title = {
    Text = "결제 방식 선택"
  },
  TipsType_20099_Desc = {
    Text = "게임을 종료하시겠습니까?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "취소"},
  TipsType_20099_RightBtnDesc = {Text = "확인"},
  TipsType_20099_Title = {Text = "알림"},
  TipsType_20100_Desc = {
    Text = "신규 버전이 출시되었습니다, 게임을 재시작해 리소스 업데이트를 받아주세요."
  },
  TipsType_20100_RightBtnDesc = {Text = "확인"},
  TipsType_20100_Title = {
    Text = "업데이트 알림"
  },
  TipsType_20101_Desc = {
    Text = "조사가 이미 완료되었습니다. 다시 조사할 때 스토리를 건너뛰시겠습니까?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "건너뛰기"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "스토리 유지"
  },
  TipsType_20101_Title = {
    Text = "스토리 확인"
  },
  TipsType_20102_Desc = {
    Text = "{s1}의 팔로우를 해제하시겠습니까?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "취소"},
  TipsType_20102_RightBtnDesc = {Text = "확인"},
  TipsType_20102_Title = {
    Text = "팔로우 취소"
  },
  TipsType_20103_Desc = {
    Text = "이벤트 기간 동안 <WeaponEffect_Num:기간 한정 무료>로 해제됩니다. 해제하시겠습니까?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "취소"},
  TipsType_20103_RightBtnDesc = {Text = "확인"},
  TipsType_20103_Title = {
    Text = "이벤트 혜택"
  },
  TipsType_20105_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20105_LeftBtnDesc = {Text = "나가기"},
  TipsType_20105_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20105_Title = {
    Text = "조사 확인"
  },
  TipsType_20106_Desc = {
    Text = "<Blue: 「원액」 × {s1}>를 소모하여 구매하시겠습니까?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "취소"},
  TipsType_20106_RightBtnDesc = {Text = "구매"},
  TipsType_20106_Title = {
    Text = "구매 확인"
  },
  TipsType_20107_Desc = {
    Text = "<Blue:{s1}>을(를) 선택하시겠습니까?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "취소"},
  TipsType_20107_RightBtnDesc = {Text = "확인"},
  TipsType_20107_Title = {
    Text = "선택 확인"
  },
  TipsType_20108_Desc = {
    Text = "이번 중첩에는 희귀 아이템 「순환의 모본」이 소모됩니다. \n계속하시겠습니까?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "취소"},
  TipsType_20108_RightBtnDesc = {Text = "확인"},
  TipsType_20108_Title = {
    Text = "소모 확인"
  },
  TipsType_20109_Desc = {
    Text = "이번 전투를 다시 시작하시겠습니까?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "취소"},
  TipsType_20109_RightBtnDesc = {Text = "확인"},
  TipsType_20109_Title = {Text = "재전투"},
  TipsType_20110_Desc = {
    Text = "{s1}월 {s2}일을 생일로 선택하시겠습니까?\n선택 후 변경할 수 없습니다."
  },
  TipsType_20110_LeftBtnDesc = {Text = "취소"},
  TipsType_20110_RightBtnDesc = {Text = "확인"},
  TipsType_20110_Title = {
    Text = "생일 확인"
  },
  TipsType_20111_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20111_LeftBtnDesc = {Text = "나가기"},
  TipsType_20111_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20111_Title = {
    Text = "조사 확인"
  },
  TipsType_20112_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20112_LeftBtnDesc = {Text = "나가기"},
  TipsType_20112_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20112_Title = {
    Text = "조사 확인"
  },
  TipsType_20113_Desc = {
    Text = "모든 튜토리얼 내용을 이미 읽은 것으로 표시하고 보상을 받으시겠습니까? (신입 수호자는 튜토리얼 내용을 꼼꼼히 읽어보는 것을 권장합니다~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "취소"},
  TipsType_20113_RightBtnDesc = {Text = "확인"},
  TipsType_20113_Title = {
    Text = "모두 읽음 확인"
  },
  TipsType_20114_Desc = {
    Text = "<WeaponEffect_Num:{s1}>을(를) 선택하여 리셋을 하시겠습니까?\n되돌리기 후에는 원상복구가 불가능합니다. 신중하게 확인해주세요."
  },
  TipsType_20114_LeftBtnDesc = {Text = "취소"},
  TipsType_20114_RightBtnDesc = {Text = "확인"},
  TipsType_20114_Title = {
    Text = "리셋 선택"
  },
  TipsType_201151_Desc = {
    Text = "현재 깨어남체은 영혼 깨어남이 없기 때문에, 영혼 깨어남 리셋이 필요하지 않습니다."
  },
  TipsType_20115_Desc = {
    Text = "현재 깨어남체는 아무런 육성을 거치지 않았으므로, 육성 리셋이 필요하지 않습니다."
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>의 초기화를 시작했습니다.\n즉시 이동하여 리셋을 진행하시겠습니까?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "취소"},
  TipsType_20116_RightBtnDesc = {Text = "이동"},
  TipsType_20116_Title = {
    Text = "오픈 성공"
  },
  TipsType_20117_Desc = {
    Text = "깨어남체의 업그레이드, 승격, 스킬, 특성 및 영지 심화 상태를 리셋하고, 소모된 자원을 반환합니다.\n<WeaponEffect_Num:{s1}>의 육성 리셋을 진행하시겠습니까?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "취소"},
  TipsType_20117_RightBtnDesc = {Text = "확인"},
  TipsType_20117_Title = {
    Text = "육성 리셋"
  },
  TipsType_20118_Desc = {
    Text = "깨어남체의 영혼 깨어남 등급을 초기화하고, 영혼 깨어남 소비를 반환합니다.\n<WeaponEffect_Num:{s1}>에 대한 영혼 깨어남 리셋을 진행하시겠습니까?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "취소"},
  TipsType_20118_RightBtnDesc = {Text = "확인"},
  TipsType_20118_Title = {
    Text = "영혼 깨어남 리셋"
  },
  TipsType_20119_Desc = {
    Text = "깨어남체의 업그레이드, 승급, 스킬, 개방, 특성, 영지 심화 상태를 초기화하고, 소모된 자원을 반환합니다.\n깨어남체를 검은 연못으로 되돌립니다.\n<WeaponEffect_Num:{s1}>를 검은 연못으로 회귀하시겠습니까?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "취소"},
  TipsType_20119_RightBtnDesc = {Text = "확인"},
  TipsType_20119_Title = {
    Text = "검은 연못 회귀"
  },
  TipsType_20120_Desc = {
    Text = "특수 깨어남체는 회귀시킬 수 없습니다"
  },
  TipsType_20121_Desc = {
    Text = "명륜의 중첩 상태를 초기화하고, 모든 중첩 소모를 반환합니다.\n<WeaponEffect_Num:{s1}>의 중첩을 리셋을 하시겠습니까?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "취소"},
  TipsType_20121_RightBtnDesc = {Text = "확인"},
  TipsType_20121_Title = {
    Text = "중첩 리셋"
  },
  TipsType_20122_Desc = {
    Text = "명륜의 중첩 상태를 초기화하고, 모든 중첩 소비를 반환하며 명륜을 검은 연못으로 되돌립니다.\n<WeaponEffect_Num:{s1}>의 검은 연못 회귀를 진행하시겠습니까?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "취소"},
  TipsType_20122_RightBtnDesc = {Text = "확인"},
  TipsType_20122_Title = {
    Text = "검은 연못 회귀"
  },
  TipsType_20123_Desc = {
    Text = "도전을 완료한 후, 해당 파티의 깨어남체, 명륜, 열쇠 지령은 다른 디-이펙트 존에서 사용할 수 없게 됩니다. 계속하시겠습니까?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "취소"},
  TipsType_20123_RightBtnDesc = {Text = "확인"},
  TipsType_20123_Title = {
    Text = "도전 확인"
  },
  TipsType_20124_Desc = {
    Text = "초기화 후, 현재 조사 파티의 깨어남체, 명륜, 열쇠 지령이 다시 사용 가능하지만, 해당 스테이지에서 획득한 특훈 점수가 차감됩니다. 보상 상태에는 영향이 없습니다. 초기화하시겠습니까?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "취소"},
  TipsType_20124_RightBtnDesc = {Text = "확인"},
  TipsType_20124_Title = {
    Text = "초기화 확인"
  },
  TipsType_20125_Desc = {
    Text = "현재 명륜 중첩 등급이 0이므로, 중첩 리셋이 필요하지 않습니다."
  },
  TipsType_20126_Desc = {
    Text = "현재 깨어남체가 파견 중입니다. 소환한 후 리셋 또는 리턴을 진행해 주세요."
  },
  TipsType_20127_Desc = {
    Text = "현재 명륜이 잠겨 있습니다. 먼저 잠금을 해제하고 반환해 주세요."
  },
  TipsType_20128_Desc = {
    Text = "{s1}는 이미 완료된 스테이지입니다. 초기화를 해야만 도전할 수 있습니다. 초기화하시겠습니까?\n(초기화 후, 조사 파티의 깨어남체, 명륜, 열쇠 지령을 다시 사용할 수 있게 되지만, 해당 스테이지에서 획득한 특훈 점수가 차감됩니다.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "취소"},
  TipsType_20128_RightBtnDesc = {Text = "확인"},
  TipsType_20128_Title = {
    Text = "초기화 확인"
  },
  TipsType_20129_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20129_LeftBtnDesc = {Text = "나가기"},
  TipsType_20129_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20129_Title = {
    Text = "조사 확인"
  },
  TipsType_20130_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20130_LeftBtnDesc = {Text = "나가기"},
  TipsType_20130_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20130_Title = {
    Text = "조사 확인"
  },
  TipsType_20131_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20131_LeftBtnDesc = {Text = "나가기"},
  TipsType_20131_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20131_Title = {
    Text = "조사 확인"
  },
  TipsType_20132_Desc = {
    Text = "<TipsHighlightText:비밀 계약 잔본>이 충분할 경우, 잔본을 우선하여 소모합니다. \n 잔본이 부족할 경우 자동으로 <TipsHighlightText:「{s1}」>을 소모하여 잔본을 보충합니다."
  },
  TipsType_20132_LeftBtnDesc = {Text = "취소"},
  TipsType_20132_RightBtnDesc = {
    Text = "계속 선택하기"
  },
  TipsType_20132_Title = {
    Text = "자동 보충"
  },
  TipsType_20133_Desc = {
    Text = "<TipsHighlightText:「{s1}」>의 영지 심화를 진행하시겠습니까?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "취소"},
  TipsType_20133_RightBtnDesc = {Text = "확인"},
  TipsType_20133_Title = {
    Text = "영지 심화"
  },
  TipsType_20134_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20134_LeftBtnDesc = {Text = "종료"},
  TipsType_20134_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20134_Title = {
    Text = "조사 확인"
  },
  TipsType_20137_Desc = {
    Text = "확인: <Blue:「{s1}」×{s2}>를 소모하여 이 곡을 해제하시겠습니까?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "취소"},
  TipsType_20137_RightBtnDesc = {Text = "확인"},
  TipsType_20137_Title = {
    Text = "해제 확인"
  },
  TipsType_20138_Desc = {
    Text = "이벤트 기간 동안 <Blue:한정 무료>로 해제할 수 있습니다. 해제하시겠습니까?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "취소"},
  TipsType_20138_RightBtnDesc = {Text = "확인"},
  TipsType_20138_Title = {
    Text = "해제 확인"
  },
  TipsType_20139_Desc = {
    Text = "<Blue:「{s1}」×{s3}>를 소모하여 <Blue:「{s2}」>를 시작하시겠습니까?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "취소"},
  TipsType_20139_RightBtnDesc = {Text = "확인"},
  TipsType_20139_Title = {
    Text = "해제 확인"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:{s1}> 현재 보유한 수량이 최대입니다. 아이템의 보유 한도에 도달했습니다. 계속 받으면 더 이상 획득할 수 없습니다. 그래도 받으시겠습니까?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "취소"},
  TipsType_20140_RightBtnDesc = {Text = "확인"},
  TipsType_20140_Title = {
    Text = "수령 확인"
  },
  TipsType_20141_Desc = {
    Text = "최대 HP의 30%({s1})를 소모하여\n전투를 건너뛰고 적을 즉시 처치하시겠습니까?\n\n현재 HP: {s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "취소"},
  TipsType_20141_RightBtnDesc = {Text = "확인"},
  TipsType_20141_Title = {
    Text = "근육 기억"
  },
  TipsType_20142_Desc = {
    Text = "<color=#BB646D> {s1} </color> HP를 소모하여, 검은 인장 {s2}개를 획득하시겠습니까?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "취소"},
  TipsType_20142_RightBtnDesc = {Text = "확인"},
  TipsType_20142_Title = {
    Text = "조사 확인"
  },
  TipsType_20145_LeftBtnDesc = {Text = "취소"},
  TipsType_20145_Title = {
    Text = "로그인 보상"
  },
  TipsType_20151_Desc = {
    Text = "초기화 후, ‘특수 아이템’의 남은 수량이 최대 수량으로 초기화됩니다. 확인하시겠습니까?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "취소"},
  TipsType_20151_RightBtnDesc = {Text = "확인"},
  TipsType_20151_Title = {
    Text = "초기화 확인"
  },
  TipsType_20152_Desc = {
    Text = "‘{s1}’이 부족합니다. ‘장미 금권’ × {s2}을 사용하여 채우시겠습니까?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "취소"},
  TipsType_20152_RightBtnDesc = {Text = "확인"},
  TipsType_20152_Title = {
    Text = "활성화 확인"
  },
  TipsType_20153_Desc = {
    Text = "초기화 후, ‘특수 아이템’과 ‘일반 아이템’의 남은 수량이 최대치로 초기화됩니다. \n {s1}번째 이후, ‘특수 아이템’은 더 이상 초기화되지 않습니다. \n 확인하시겠습니까?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "취소"},
  TipsType_20153_RightBtnDesc = {Text = "확인"},
  TipsType_20153_Title = {
    Text = "초기화 확인"
  },
  TipsType_20154_Desc = {
    Text = "초기화 후, ‘특수 아이템’과 ‘일반 아이템’의 남은 수량이 최대치로 초기화됩니다. \n {s1}번째 이후, ‘특수 아이템’은 더 이상 초기화되지 않습니다. \n 현재 <Blue:‘일반 아이템’>이 남아 있습니다. 계속하시겠습니까?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "취소"},
  TipsType_20154_RightBtnDesc = {Text = "확인"},
  TipsType_20154_Title = {
    Text = "초기화 확인"
  },
  TipsType_20155_Desc = {
    Text = "중첩 재료에 잠금 상태인 명륜이 포함되어 있습니다. 선택한 명륜을 중첩에 사용하기 위해 소모하시겠습니까?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "취소"},
  TipsType_20155_RightBtnDesc = {Text = "확인"},
  TipsType_20155_Title = {
    Text = "중첩 확인"
  },
  TipsType_20156_Desc = {
    Text = "<TipsHighlightText: ‘현실타래의 기점’ × 1>을 소모하여 해제하시겠습니까?\n(욕망의 파도 이벤트 기간 동안 해제에 필요한 「현실타래의 기점」 이 {s1}개에서 {s2}개로 감소합니다.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "취소"},
  TipsType_20156_RightBtnDesc = {Text = "확인"},
  TipsType_20156_Title = {
    Text = "해제 확인"
  },
  TipsType_20157_Desc = {
    Text = "<TipsHighlightText:‘현실타래의 기점’ × {s1}>을 소모하여 해제하시겠습니까?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "취소"},
  TipsType_20157_RightBtnDesc = {Text = "확인"},
  TipsType_20157_Title = {
    Text = "해제 확인"
  },
  TipsType_20158_Desc = {
    Text = "현재 스테이지가 만료되었습니다. 도전을 완료해도 보상을 획득할 수 없습니다. 그래도 나가시겠습니까?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "취소"},
  TipsType_20158_RightBtnDesc = {Text = "확인"},
  TipsType_20158_Title = {
    Text = "나가기 확인"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:「{s1}」>의 보유 한도가 <TipsHighlightText: {s2} >개를 초과했습니다. 초과분 1개당 <Blue:‘형체 없는 자의 초대장’× 1>으로 전환되었습니다."
  },
  TipsType_20159_Title = {
    Text = "변환 알림"
  },
  TipsType_20160_Desc = {
    Text = "<TipsHighlightText:{s1}>해제 완료!\n이벤트 무료 해제 특전으로 다음 보상을 지급해 드립니다."
  },
  TipsType_20160_RightBtnDesc = {Text = "확인"},
  TipsType_20160_Title = {
    Text = "보상 알림"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:「{s1}」>의 보유 한도가 <TipsHighlightText: {s2} >개를 초과했습니다. 초과분 1개당 <Blue:「장미 금권」 × 5000>으로 전환되었습니다."
  },
  TipsType_20161_Title = {
    Text = "변환 알림"
  },
  TipsType_20162_Desc = {
    Text = "깨어남체의 업그레이드, 승격, 스킬, 특성 및 영지 심화 상태를 리셋하고, 소모된 자원을 반환합니다.\n<WeaponEffect_Num:{s1}>의 육성 리셋을 진행하시겠습니까?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "취소"},
  TipsType_20162_RightBtnDesc = {Text = "확인"},
  TipsType_20162_Title = {
    Text = "육성 리셋"
  },
  TipsType_20163_Desc = {
    Text = "깨어남체의 영혼 깨어남 상태를 초기화하고, 소모된 자원을 반환합니다.\n<WeaponEffect_Num:{s1}>의 육성 리셋을 진행하시겠습니까?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "취소"},
  TipsType_20163_RightBtnDesc = {Text = "확인"},
  TipsType_20163_Title = {
    Text = "영혼 깨어남 리셋"
  },
  TipsType_20164_Desc = {
    Text = "깨어남체의 업그레이드, 승격, 스킬, 특성, 영혼 깨어남 및 영지 심화 상태를 초기화하고, 해당 소모 자원이 반환되며, 깨어남체는 검은 연못으로 복귀됩니다.\n<WeaponEffect_Num:{s1}>을 검은 연못으로 초기화하시겠습니까?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "취소"},
  TipsType_20164_RightBtnDesc = {Text = "확인"},
  TipsType_20164_Title = {
    Text = "검은 연못 회귀"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}>은(는) 특별한 깨어남체로, 레벨, 승격, 스킬, 특성 및 영지 심화 상태만 리셋을 할 수 있습니다. <Red:영혼 깨어남 육성은 리셋을 할 수 없습니다.> <WeaponEffect_Num:{s1}>을(를) 선택하여 리셋을 진행하시겠습니까?\n리셋 후에는 원상복구가 불가능하니, 신중하게 확인해주세요."
  },
  TipsType_20165_LeftBtnDesc = {Text = "취소"},
  TipsType_20165_RightBtnDesc = {Text = "확인"},
  TipsType_20165_Title = {
    Text = "리셋 선택"
  },
  TipsType_20166_Desc = {
    Text = "특수 깨어남체는 영혼 깨어남 리셋을 진행할 수 없습니다."
  },
  TipsType_20167_Desc = {
    Text = "이번 리셋에서 이미 ‘육성 리셋’을 진행했습니다. 다음 리셋에서 ‘육성 리셋’을 다시 진행할 수 있습니다."
  },
  TipsType_20168_Desc = {
    Text = "이번 리셋에서 이미 ‘영혼 깨어남 리셋’을 진행했습니다. 다음 리셋에서 ‘영혼 깨어남 리셋’을 다시 진행할 수 있습니다."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:주의: 선택 후, 이번 이벤트는 변경할 수 없습니다!>"
  },
  TipsType_20169_Desc = {
    Text = "깨어남체 <OrangeQuality:「{s1}」> 및 추천 명륜 <OrangeQuality:「{s2}」>을(를) 이번 이벤트의 선택적 UP으로 설정하시겠습니까?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "취소"},
  TipsType_20169_RightBtnDesc = {Text = "확인"},
  TipsType_20169_Title = {
    Text = "선택 확인"
  },
  TipsType_20170_Desc = {
    Text = "오늘의 도전 한도에 도달했습니다. 내일 다시 도전하시길 바랍니다!"
  },
  TipsType_20171_Desc = {
    Text = "이제 「환몽 심잠」으로 이동할 수 있습니다!"
  },
  TipsType_20173_Desc = {
    Text = "이제 「페이즈 체스」로 이동할 수 있습니다!"
  },
  TipsType_20174_Desc = {
    Text = "이제 「조사·어려움」으로 이동할 수 있습니다!"
  },
  TipsType_20175_Desc = {
    Text = "이제 「초월적 존재」로 이동할 수 있습니다!"
  },
  TipsType_20176_Desc = {
    Text = "이제 「융재금지구역」으로 이동할 수 있습니다!"
  },
  TipsType_20177_Desc = {
    Text = "이제 「번식 광란」으로 이동할 수 있습니다!"
  },
  TipsType_20178_Desc = {
    Text = "이제 「두 번째 명륜」을 장착할 수 있습니다!"
  },
  TipsType_20179_Desc = {
    Text = "이제 「혼돈의 구역」으로 이동할 수 있습니다."
  },
  TipsType_20180_Desc = {
    Text = "이제 「금지된 기록」으로 이동할 수 있습니다."
  },
  TipsType_20181_Desc = {
    Text = "이제 「비밀 계약 강화」로 이동할 수 있습니다."
  },
  TipsType_20182_Desc = {
    Text = "이제 「비밀계약 전사」로 이동할 수 있습니다!"
  },
  TipsType_20183_Desc = {
    Text = "해당 이벤트는 종료되었습니다."
  },
  TipsType_20184_Desc = {
    Text = "이제 「수첩」으로 이동할 수 있습니다."
  },
  TipsType_20185_Desc = {
    Text = "이 스테이지의 모든 스토리를 건너뛰시겠습니까?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "취소"},
  TipsType_20185_RightBtnDesc = {Text = "확인"},
  TipsType_20185_Title = {
    Text = "건너뛰기"
  },
  TipsType_20186_Desc = {
    Text = "게임 실타래행에 필요한 데이터를 다운로드합니다.\n계속하시겠습니까?\n\n* 데이터 네트워크 사용 시 데이터 통화료가 부과될 수 있습니다."
  },
  TipsType_20186_LeftBtnDesc = {Text = "취소"},
  TipsType_20186_RightBtnDesc = {Text = "확인"},
  TipsType_20187_Desc = {
    Text = "리소스 다운로드 완료"
  },
  TipsType_20187_LeftBtnDesc = {Text = "확인"},
  TipsType_20188_Desc = {
    Text = "저장 공간이 부족합니다. 최소 {s1}의 저장 공간을 확보해야 하며, 그렇지 않으면 실타래행 시 리소스가 손실타래될 수 있습니다. 그래도 계속 다운로드하시겠습니까?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "취소"},
  TipsType_20188_RightBtnDesc = {Text = "확인"},
  TipsType_20189_Desc = {
    Text = "리소스 다운로드 실타래패, 다시 시도하시겠습니까?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "취소"},
  TipsType_20189_RightBtnDesc = {Text = "확인"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>의 보유 한도가 <TipsHighlightText: {s2} >개를 초과했습니다. 초과분 1개당<Blue:{s3}>(으)로 전환되었습니다."
  },
  TipsType_20190_Title = {
    Text = "변환 알림"
  },
  TipsType_20191_Desc = {
    Text = "이제 「이벤트」로 이동할 수 있습니다!"
  },
  TipsType_20192_Desc = {
    Text = "후속 스토리에 필요한 데이터를 다운로드합니다.\n리소스 크기: {s1}\n계속하시겠습니까?\n\n* 데이터 네트워크 사용 시 데이터 통화료가 부과될 수 있습니다."
  },
  TipsType_20192_LeftBtnDesc = {Text = "취소"},
  TipsType_20192_RightBtnDesc = {
    Text = "다운로드"
  },
  TipsType_20193_Desc = {
    Text = "이제 「파견」으로 이동할 수 있습니다!"
  },
  TipsType_20194_Desc = {
    Text = "이제 「은심 통신」으로 이동할 수 있습니다!"
  },
  TipsType_20195_Desc = {
    Text = "이제 「과제 기록」으로 이동할 수 있습니다!"
  },
  TipsType_20196_Desc = {
    Text = "이제 「무광의 영역」으로 이동할 수 있습니다!"
  },
  TipsType_20197_Desc = {
    Text = "소환 최대 횟수에 도달했습니다. 미션 보상을 수령하러 이동하세요!"
  },
  TipsType_20198_Desc = {
    Text = "아직 미션을 완료하지 않았습니다. 완료 후 다시 수령해 주세요!"
  },
  TipsType_20199_Desc = {
    Text = "수령 후‘대리 증표’가 소유 제한을 초과하게 됩니다.\n초과 부분은 획득할 수 없습니다.\n계속해서 수령하시겠습니까?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "취소"},
  TipsType_20199_RightBtnDesc = {Text = "확인"},
  TipsType_20199_Title = {
    Text = "수령 확인"
  },
  TipsType_20200_Desc = {
    Text = "시험 훈련 대리를 신청하면 <Blue:「대리 증명서」× 1>\n신청 후 바로 일일 시험 훈련이 완료됩니다. 확인하시겠습니까?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "취소"},
  TipsType_20200_RightBtnDesc = {Text = "확인"},
  TipsType_20200_Title = {
    Text = "대리 확인"
  },
  TipsType_20201_Desc = {
    Text = "다음 비밀 계약이 이미 장착 중입니다. 교체하시겠습니까?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "취소"},
  TipsType_20201_RightBtnDesc = {Text = "확인"},
  TipsType_20201_Title = {
    Text = "교체 확인"
  },
  TipsType_20202_Desc = {
    Text = "현재 {s1}에 적용된 방안입니다. 【{s2}】프리셋을 삭제하시겠습니까?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "취소"},
  TipsType_20202_RightBtnDesc = {Text = "확인"},
  TipsType_20202_Title = {
    Text = "삭제 확인"
  },
  TipsType_20203_Desc = {
    Text = "동일한 명륜 효과는 중복 적용되지 않습니다. {s1}은(는) 이미 현재 파티에서 장착 중입니다. 장착을 확인하시겠습니까?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "취소"},
  TipsType_20203_RightBtnDesc = {Text = "확인"},
  TipsType_20203_Title = {
    Text = "장착 확인"
  },
  TipsType_20204_Desc = {
    Text = "{s1}에서 현재 비밀 계약이 사용 중입니다. 분해 후 해당 방안에서 제거됩니다. 계속하시겠습니까?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "취소"},
  TipsType_20204_RightBtnDesc = {Text = "확인"},
  TipsType_20204_Title = {
    Text = "삭제 확인"
  },
  TipsType_20205_Desc = {
    Text = "편성 {s1}에서 현재 비밀 계약이 사용 중입니다. 분해하면 해당 비밀 계약이 해제됩니다. 계속하시겠습니까?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "취소"},
  TipsType_20205_RightBtnDesc = {Text = "확인"},
  TipsType_20205_Title = {
    Text = "삭제 확인"
  },
  TipsType_20206_Desc = {
    Text = "편성 {s1}에서 해당 명륜을 사용 중입니다. 분해하면 해당 명륜의 장착이 해제됩니다. 계속하시겠습니까?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "취소"},
  TipsType_20206_RightBtnDesc = {Text = "확인"},
  TipsType_20206_Title = {
    Text = "삭제 확인"
  },
  TipsType_20207_Desc = {
    Text = "현재 방안이 아직 저장되지 않았습니다. 나가게 되면 이번 편집 내용이 모두 사라집니다. 나가시겠습니까?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "취소"},
  TipsType_20207_RightBtnDesc = {Text = "확인"},
  TipsType_20207_Title = {
    Text = "저장 확인"
  },
  TipsType_20208_Desc = {
    Text = "이미 미션 보상을 수령했습니다. 다른 미션을 확인해 보세요!"
  },
  TipsType_20209_Desc = {
    Text = "미션이 만료되었습니다."
  },
  TipsType_20210_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20210_LeftBtnDesc = {Text = "나가기"},
  TipsType_20210_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20210_Title = {
    Text = "조사 확인"
  },
  TipsType_20211_Desc = {
    Text = "{s1}일 {s2}시간 후 오픈"
  },
  TipsType_20212_Desc = {
    Text = "{s1}시간 {s2}분 후 오픈"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>은(는) 이미 편성에서 초월 인과를 발동한 상태입니다. 리셋하면 초월 인과 효과가 사라지고 편성에서 자동으로 제거됩니다. <WeaponEffect_Num:{s1}>을(를) 선택하여 리셋을 진행하시겠습니까?\n리셋 후에는 원상복구가 불가능합니다. 신중하게 확인해 주세요."
  },
  TipsType_20213_LeftBtnDesc = {Text = "취소"},
  TipsType_20213_RightBtnDesc = {Text = "확인"},
  TipsType_20213_Title = {
    Text = "리셋 선택"
  },
  TipsType_20214_Desc = {
    Text = "명륜의 중첩 상태가 초기화되고 소모한 중첩 재료가 반환됩니다.\n<WeaponEffect_Num:{s1}>이(가) 편성에서 초월 인과를 발동했으며, 리셋 후에 편성에서 자동으로 제거됩니다.\n<WeaponEffect_Num:{s1}>의 중첩 리셋을 진행하시겠습니까?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "취소"},
  TipsType_20214_RightBtnDesc = {Text = "확인"},
  TipsType_20214_Title = {
    Text = "중첩 리셋"
  },
  TipsType_20215_Desc = {
    Text = "명륜의 중첩돌파를 초기화하고 모든 소모 자원을 반환하며, 명륜을 검은 연못으로 회수합니다.\n<WeaponEffect_Num:{s1}>이(가) 편성에서 초월인과를 발동했으며, 리턴 후에 편성에서 자동으로 제거됩니다.\n<WeaponEffect_Num:{s1}>을(를) 검은 연못 리턴을 하시겠습니까?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "취소"},
  TipsType_20215_RightBtnDesc = {Text = "확인"},
  TipsType_20215_Title = {
    Text = "검은 연못 회귀"
  },
  TipsType_20216_Desc = {
    Text = "<Blue:「{s1}」× {s2} >을(를) 소모하여 구매하시겠습니까?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "취소"},
  TipsType_20216_RightBtnDesc = {Text = "구매"},
  TipsType_20216_Title = {
    Text = "구매 확인"
  },
  TipsType_20217_Desc = {
    Text = "{s1}은(는) {s2} 후에 오픈됩니다."
  },
  TipsType_20218_Desc = {
    Text = "이번 조사에서 사전 선택한 깨어남체는 직접 참전 불가하며, 해당하는 깨어남체로만 교체 가능합니다."
  },
  TipsType_20219_Desc = {
    Text = "이미 동일한 깨어남체가 배치되어 중복 선택할 수 없습니다."
  },
  TipsType_20220_Desc = {
    Text = "현재 Wi-Fi를 사용하고 있지 않은 것으로 감지되었습니다. 다운로드는 많은 데이터를 소모합니다. 다운로드를 계속하시겠습니까?\n리소스 크기: {s1}\n계속하시겠습니까?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "취소"},
  TipsType_20220_RightBtnDesc = {
    Text = "다운로드"
  },
  TipsType_20221_Desc = {
    Text = "리소스 다운로드 완료"
  },
  TipsType_20221_LeftBtnDesc = {Text = "확인"},
  TipsType_20222_Desc = {
    Text = "저장 공간이 부족합니다. 최소 {s1}의 저장 공간을 확보해야 하며, 그렇지 않으면 실타래행 시 리소스가 손실타래될 수 있습니다. 그래도 계속 다운로드하시겠습니까?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "취소"},
  TipsType_20222_RightBtnDesc = {Text = "확인"},
  TipsType_20223_Desc = {
    Text = "리소스 다운로드 실타래패, 다시 시도하시겠습니까?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "취소"},
  TipsType_20223_RightBtnDesc = {Text = "확인"},
  TipsType_20224_Desc = {
    Text = "프롤로그 이후에 필요한 데이터를 다운로드합니다.\n리소스 크기: {s1}\n계속하시겠습니까?\n\n* 데이터 네트워크 사용 시 데이터 통화료가 부과될 수 있습니다."
  },
  TipsType_20224_LeftBtnDesc = {Text = "취소"},
  TipsType_20224_RightBtnDesc = {
    Text = "다운로드"
  },
  TipsType_20225_Desc = {
    Text = "{s1}을(를) 완료하셨습니다. 추가로 도전하시겠습니까? \n추가 도전 시 {s2} 특훈치를 획득할 수 있습니다."
  },
  TipsType_20225_LeftBtnDesc = {Text = "취소"},
  TipsType_20225_RightBtnDesc = {Text = "확인"},
  TipsType_20225_Title = {
    Text = "추가 도전"
  },
  TipsType_20226_Desc = {
    Text = "초기화 후, 추가 도전 파티의 깨어남체, 열쇠 지령, 명륜을 다시 사용할 수 있지만, 해당 스테이지에서 추가로 완료해서 얻은 특훈 값이 차감됩니다(보상 상태에는 영향을 미치지 않음). 초기화하시겠습니까?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "취소"},
  TipsType_20226_RightBtnDesc = {Text = "확인"},
  TipsType_20226_Title = {
    Text = "초기화 확인"
  },
  TipsType_20227_Desc = {
    Text = "초기화 후, 현재 조사 파티의 깨어남체, 열쇠와 명륜을 다시 사용할 수 있으며, 추가 도전 파티가 현재 조사 파티를 대체합니다. 하지만 해당 스테이지에서 추가로 획득한 특훈 값은 차감됩니다(보상 상태에는 영향을 미치지 않음). 초기화하시겠습니까?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "취소"},
  TipsType_20227_RightBtnDesc = {Text = "확인"},
  TipsType_20227_Title = {
    Text = "초기화 확인"
  },
  TipsType_20228_Desc = {
    Text = "아래로 스크롤하여 더 많은 공지사항을 확인하세요."
  },
  TipsType_20229_Desc = {
    Text = "「<Blue:{s1}>」이 중첩 레벨 한계에 도달했습니다.\n계속 구매하시겠습니까?\n남은 수량: {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "취소"},
  TipsType_20229_RightBtnDesc = {Text = "확인"},
  TipsType_20229_Title = {
    Text = "구매 확인"
  },
  TipsType_20230_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20230_LeftBtnDesc = {Text = "종료"},
  TipsType_20230_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20230_Title = {
    Text = "조사 확인"
  },
  TipsType_20231_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20231_LeftBtnDesc = {Text = "종료"},
  TipsType_20231_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20231_Title = {
    Text = "조사 확인"
  },
  TipsType_20232_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20232_LeftBtnDesc = {Text = "종료"},
  TipsType_20232_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20232_Title = {
    Text = "조사 확인"
  },
  TipsType_20233_Desc = {
    Text = "재료가 부족합니다. 다음 재료를 소모하여 보충하시겠습니까?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "취소"},
  TipsType_20233_RightBtnDesc = {Text = "확인"},
  TipsType_20233_Title = {
    Text = "보충 확인"
  },
  TipsType_20234_Desc = {
    Text = "이 스테이지에서는 지정된 열쇠 지령만 장착할 수 있으며, 교체는 불가능합니다."
  },
  TipsType_20235_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20235_LeftBtnDesc = {Text = "종료"},
  TipsType_20235_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20235_Title = {
    Text = "조사 확인"
  },
  TipsType_20236_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20236_LeftBtnDesc = {Text = "종료"},
  TipsType_20236_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20236_Title = {
    Text = "조사 확인"
  },
  TipsType_20237_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20237_LeftBtnDesc = {Text = "종료"},
  TipsType_20237_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20237_Title = {
    Text = "조사 확인"
  },
  TipsType_20238_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20238_LeftBtnDesc = {Text = "종료"},
  TipsType_20238_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20238_Title = {
    Text = "조사 확인"
  },
  TipsType_20239_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20239_LeftBtnDesc = {Text = "종료"},
  TipsType_20239_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20239_Title = {
    Text = "조사 확인"
  },
  TipsType_20240_Desc = {
    Text = "수리 완료, 게임에 다시 접속해 주세요."
  },
  TipsType_20240_RightBtnDesc = {Text = "확인"},
  TipsType_20240_Title = {Text = "안내"},
  TipsType_20241_Desc = {
    Text = "중첩 레벨 한도에 도달하려면 「<Blue:{s2}>」이(가) {s1}개 더 필요합니다.\n계속 구매하시겠습니까?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "취소"},
  TipsType_20241_RightBtnDesc = {Text = "확인"},
  TipsType_20241_Title = {
    Text = "구매 확인"
  },
  TipsType_20250_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20250_LeftBtnDesc = {Text = "종료"},
  TipsType_20250_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20250_Title = {
    Text = "조사 확인"
  },
  TipsType_20251_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20251_LeftBtnDesc = {Text = "종료"},
  TipsType_20251_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20251_Title = {
    Text = "조사 확인"
  },
  TipsType_20252_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_20252_LeftBtnDesc = {Text = "종료"},
  TipsType_20252_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_20252_Title = {
    Text = "조사 확인"
  },
  TipsType_20259_Desc = {
    Text = "‘천면인장’이 부족할 때의 대체 설정이 저장되었습니다."
  },
  TipsType_20300_Desc = {
    Text = "이미 {s1} 포지션 깨어남체가 존재하여, 같은 편성에서 동일 포지션의 깨어남체를 사용할 수 없습니다."
  },
  TipsType_20301_Desc = {
    Text = "이제 「정기 훈련 미션」으로 이동할 수 있습니다!"
  },
  TipsType_20351_Desc = {
    Text = "{s1}이(가) 부족합니다, {s2} {s3}(으)로 {s4} {s5}을(를) 교환하시겠습니까?"
  },
  TipsType_20351_LeftBtnDesc = {Text = "취소"},
  TipsType_20351_RightBtnDesc = {Text = "확인"},
  TipsType_20351_Title = {
    Text = "{s1}이(가) 부족합니다"
  },
  TipsType_20352_Desc = {
    Text = "상대와 곧 연결되며, 연결 후에는 해제할 수 없습니다. 계속 연결하시겠습니까?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "취소"},
  TipsType_20352_RightBtnDesc = {Text = "확인"},
  TipsType_20352_Title = {
    Text = "초대 확인"
  },
  TipsType_20353_Desc = {
    Text = "초대 코드가 클립보드에 복사되었습니다."
  },
  TipsType_20354_Desc = {
    Text = "이미 상대방의 초대자입니다!"
  },
  TipsType_20355_Desc = {
    Text = "자신의 초대 코드는 입력할 수 없습니다. 다른 수호자의 코드를 구해보세요."
  },
  TipsType_20356_Desc = {
    Text = "플레이 시 프롤로그 스토리와 튜토리얼을 다시 경험할 수 있습니다!\n단, 플레이 중 스테이지의 모든 보상은 데모 버전으로, 실타래제로 획득할 수 없습니다.\n진행하시겠습니까?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "취소"},
  TipsType_20356_RightBtnDesc = {Text = "확인"},
  TipsType_20356_Title = {
    Text = "조사 확인"
  },
  TipsType_20357_Desc = {
    Text = "{s1} 님을 더 이상 팔로우하지 않으시겠습니까?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "취소"},
  TipsType_20357_RightBtnDesc = {Text = "확인"},
  TipsType_20357_Title = {
    Text = "팔로우 해제"
  },
  TipsType_20358_Desc = {
    Text = "확인되지 않은 언팔로우가 있습니다. 떠나면 어떤 작업도 저장되지 않습니다. 떠나시겠습니까?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "취소"},
  TipsType_20358_RightBtnDesc = {Text = "확인"},
  TipsType_20358_Title = {
    Text = "종료 확인"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:「{s1}」>이 부족합니다. 교환하러 가시겠습니까?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "취소"},
  TipsType_20400_RightBtnDesc = {Text = "확인"},
  TipsType_20400_Title = {
    Text = "추첨 아이템이 부족합니다."
  },
  TipsType_300001_Desc = {
    Text = "‘은빛의 새벽’에서 1회의 무료 소환 기회를 사용할 수 있습니다. 사용하시겠습니까?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "취소"},
  TipsType_300001_RightBtnDesc = {Text = "확인"},
  TipsType_300001_Title = {
    Text = "소화 확인"
  },
  TipsType_300002_Desc = {
    Text = "이번 소환 결과를 선택하시겠습니까? 확인하면 무료 5연차 횟수를 소모합니다."
  },
  TipsType_300002_LeftBtnDesc = {Text = "취소"},
  TipsType_300002_RightBtnDesc = {Text = "확인"},
  TipsType_300002_Title = {
    Text = "소화 확인"
  },
  TipsType_30001_Desc = {
    Text = "측면 알림 아이콘 없음"
  },
  TipsType_30003_Desc = {
    Text = "{s1} 해제"
  },
  TipsType_30004_Desc = {
    Text = "{s1} 고급 모드 해제"
  },
  TipsType_30005_Desc = {
    Text = "{s1} (어려움) 해제"
  },
  TipsType_31000_Desc = {
    Text = "해당 생년월일 인증 정보를 사용하시겠습니까? 설정 시 변경할 수 없습니다!"
  },
  TipsType_31000_LeftBtnDesc = {Text = "취소"},
  TipsType_31000_RightBtnDesc = {Text = "확인"},
  TipsType_31000_Title = {
    Text = "연령 인증"
  },
  TipsType_31001_Desc = {
    Text = "이번 달에 이미 <Blue:{s1}>원을 충전하셨으며, 충전 한도는 <Blue:{s2}>원으로 제한되어 있습니다. 다음 달에 다시 충전하거나 더 낮은 금액의 상품으로 시도해주세요."
  },
  TipsType_31002_Desc = {
    Text = "먼저 연령 인증을 완료하세요."
  },
  TipsType_31003_Desc = {
    Text = "은열쇠가 치명적인 위기를 감지했습니다. 응급 영지체를 사용하시겠습니까?\n(부활 시 응급 영지체 1개를 소모하며, 매일 10시(한국 시간 기준)에 자동으로 1개를 획득합니다. 현재 남은 수량: {s1})\n<Blue:(첫 부활은 응급 영지체를 소모하지 않습니다.)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "취소"},
  TipsType_31003_RightBtnDesc = {Text = "확인"},
  TipsType_31003_Title = {
    Text = "부활 확인"
  },
  TipsType_31004_Desc = {
    Text = "은열쇠가 치명적인 위기를 감지했습니다. 응급 영지체를 사용하시겠습니까?\n(부활 시 응급 영지체 1개를 소모하며, 매일 10시(한국 시간 기준)에 자동으로 1개를 획득합니다. 현재 남은 수량: {s1})\n<Blue:(첫 부활은 응급 영지체를 소모하지 않습니다.)>"
  },
  TipsType_31004_RightBtnDesc = {Text = "확인"},
  TipsType_31004_Title = {
    Text = "부활 확인"
  },
  TipsType_40001_Desc = {
    Text = "HP가 0이 되면 조사가 강제로 종료됩니다."
  },
  TipsType_40001_Title = {Text = "HP"},
  TipsType_40002_Desc = {
    Text = "지도 이동 및 이벤트 조사는 정신적 스트레스를 유발하며, 스트레스가 누적되면 수호자에게 증상이 나타납니다.\n한 칸 이동할 때마다 스트레스가 10pt 증가하며, 스트레스가 100pt에 도달할 때마다 증상 1개를 얻습니다.\n스트레스가 500에 도달한 후에는 한 칸 이동할 때마다 HP가 10% 감소됩니다."
  },
  TipsType_40002_Title = {
    Text = "스트레스"
  },
  TipsType_40003_Desc = {
    Text = "파견 레벨이 높을수록 미션 난이도가 높아지고 보상도 많아집니다."
  },
  TipsType_40003_Title = {
    Text = "파견 레벨"
  },
  TipsType_40004_Desc = {
    Text = "매 턴마다 사용하는 첫 번째 명령 카드의 임시 복사본이 초차원 공간으로 진입합니다. \n초차원 공간이 최대 수용량에 도달하면, 추가 초차원 턴 1회를 획득하며 실타래드를 유지합니다.\n 영역 숙련 효과: 턴 시작 시 일정 확률로 ‘영감’ 카드 1장을 손패에 추가합니다."
  },
  TipsType_40004_Title = {
    Text = "초차원 공간"
  },
  TipsType_40005_Desc = {
    Text = "수호자는 조사와 막간 훈련 등의 도전을 통해 자신의 레벨을 향상시킬 수 있습니다. 더 많은 게임 콘텐츠는 수호자의 레벨 상승에 따라 단계적으로 해제됩니다."
  },
  TipsType_40005_Title = {Text = "레벨"},
  TipsType_40006_Desc = {
    Text = "명령 카드를 사용하려면 행동력이 소모됩니다. 턴이 종료 시 남은 행동력은 보유되지 않으며, 턴이 시작할 때 행동력이 최대치까지 회복됩니다.\n턴 시작 시 연산력이 최대치까지 회복됩니다."
  },
  TipsType_40006_Title = {Text = "행동력"},
  TipsType_40007_Desc = {
    Text = "은열쇠가 특별한 에너지를 감지했습니다. 지도 어딘가에 귀중한 물자가 숨겨져 있을지도 몰라요……"
  },
  TipsType_40007_Title = {
    Text = "숨겨진 자원"
  },
  TipsType_40008_Desc = {
    Text = "전투 중 치명적인 위기 상황에서 발동할 수 있으며, 발동 시 1개를 소모합니다. 수호자의 HP와 깨어남체의 광기를 최대치로 회복시키며, 매일 오전 10시(한국 시간 기준)에 자동으로 1개를 획득합니다."
  },
  TipsType_40008_Title = {
    Text = "응급 영지체"
  },
  TipsType_40009_Desc = {
    Text = "명령 카드를 사용하려면 행동력을 소모됩니다. 턴 종료 시 남은 행동력은 보유되지 않고, 턴 시작 시 최대 행동력이 1 상승하며 행동력이 최대치까지 회복됩니다. 현재 턴: {s1}"
  },
  TipsType_40009_Title = {Text = "행동력"},
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "융재 금지구역이 초기화되어, 진행 중인 도전이 즉시 종료됩니다."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "확인"},
  TipsType_AbyssChallengeResetTips_Title = {Text = "힌트"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "은열쇠가 치명적인 위기를 감지했습니다. 응급 영지체를 사용하시겠습니까?\n(소생 시 응급 영지체 {s1}개를 소모하며, 응급 영지체는 매일 9시에 1개 자동 획득됩니다)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "취소"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "확인"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "부활 확인"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "<Blue:{s1}>의 <Blue:{s2}> 초대를 수락하시겠습니까?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "거절"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "수락"},
  TipsType_AcceptConfirm_Title = {
    Text = "비공개 대전"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "해당 미션을 완료하면 소환을 진행할 수 있습니다."
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "이미 현재 BGM으로 설정되었습니다."
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "「장미 금권」이 부족하여 현재 보유한 「영지 비약」을 사용할 수 없습니다. 「장미 금권」을 보충한 후 다시 시도해 주세요."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "깨어남체가 아직 해제되지 않았습니다, 기대해 주세요."
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "<Blue:{s1}>을(를) 소비하여 <Blue:랜덤> 깨어남체 1개를 획득하시겠습니까?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "사용 확인"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "전투 생성 실타래패"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "현재 수밀기행을 모두 완료했습니다."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "조사해야 함"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "조사해야 함"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "조사 확인"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "종료"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "조사 확인"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "즐겨찾기가 취소되었습니다."
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "「장미 금권」× {s1}을 소모하여 구매하시겠습니까?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "구매 확인"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "수집 성공"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "자주 사용하는 조력 수호자가 최대치에 도달했습니다. 주 이용 조력 목록을 조정해 주세요."
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "파일 쓰기에 실타래패하였습니다. 디바이스 내 남은 저장 공간이 충분한지 확인해 주세요."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "확인"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "저장 공간이 부족합니다. 다운로드를 계속 시도하시겠습니까?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "취소"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "확인"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "<Blue:「원액」× {s1} >를 소모하여 구매하시겠습니까?\n <color=#ACBFCA>이번 기회는 특별 과제로, 핵심 과제의 가격이 인하되었습니다.</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "구매"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "구매 확인"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "<color=#5EF2FF>페이즈 값</color>을 입력해 주세요."
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "최대 {s1}명의 깨어남체를 선택하여 필터링할 수 있습니다"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "현재 페이지의 <color=#5EF2FF>{s1}</color>명의 팔로워를 팔로우하시겠습니까? \n\n<color=#96947F>팔로우 </color>{s2}<color=#A0A0A0>/{s3}\n한도를 초과하면 더 이상은 팔로우할 수 없습니다.</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_FollowBackConfirm_Title = {
    Text = "맞팔로우 확인"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "이 작업은 대량의 자원을 소모하며, 깨어남체의 능력을 극한까지 키우고 싶을 때 적합합니다. 「광기의 징조」 강화를 확인하시겠습니까?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "강화 확인"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "해당 작업은 대량의 자원을 소모하며, 깨어남체의 능력을 극한까지 키우고 싶을 때 적합합니다. 「내재 영격」 강화를 확인하시겠습니까?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "강화 확인"
  },
  TipsType_InCharging_Desc = {
    Text = "주문이 처리 중입니다. 중복 결제는 자제해 주세요.\n결제가 완료되었다면, 시스템에서 보상을 지급할 때까지 기다려 주세요.\n결제가 완료되지 않았다면, 게임을 재시작한 후 다시 시도해 주세요.\n문의가 있으시면 고객 센터에 연락해 주세요."
  },
  TipsType_InCharging_RightBtnDesc = {Text = "확인"},
  TipsType_InCharging_Title = {Text = "안내"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "텍스트 식별 리소스 다운로드 중이니, 잠시 후에 다시 시도해 주세요."
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "해당 깨어남체의 영혼 깨어남이 가득 찼습니다.\n선택 시 ‘노시스 조각’× 6 및 ‘정제된 노시스 조각’× 2만 획득합니다."
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "취소"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "계속"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "확인 선택"
  },
  TipsType_MainResetBG_Desc = {
    Text = "기숙사의 배경 <Blue:「화면」>과<Blue:「음악」>을 기본값으로 복원하시겠습니까?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "취소"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "확인"},
  TipsType_MainResetBG_Title = {
    Text = "기본값으로 복원"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "잠금적으로 아이템을 획득하며, 변경할 수 없습니다."
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "모든 선택 아이템을 선택한 후에 구매 가능합니다."
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "상대방이 매치를 취소했습니다."
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "상대방이 <Blue:{s1}>의 초대를 거절했습니다. 모드를 다시 선택하세요."
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "전투 라운드 수가 상한에 도달했습니다\n\n유일한 수호자여\n이제 어떤 선택을 하시겠습니까?"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {Text = "재전투"},
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "잠시 후퇴하기"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "조사 실타래패"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "전투 재생 오류가 발생했습니다. 나중에 다시 시도해 주세요."
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "리플레이가 턴 25개 중 최대 한도에 도달했습니다.\n리플레이를 종료합니다."
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "확인"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "종료 확인"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "조사 기록 없음"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "전투 리플레이 로딩 중입니다. 반복적인 조작을 삼가해 주세요."
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "특수 편성의 전투 리플레이는 현재 지원되지 않습니다. 기대해 주세요."
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "전투 리플레이 가져오기 시간 초과"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "전투 리플레이 중에는 조작이 불가능합니다."
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "클립보드에 복사되었습니다."
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "클립보드에서 <color=#5EF2FF>조사 작전</color> 편성이 올바르게 인식되지 않았습니다."
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "해당 편성 코드에 대한 파티 구성을 저장하시겠습니까?\n해당 구성을 보유하지 않은 부분은 비어 있게 됩니다."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "취소"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "확인"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "저장 확인"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "해당 파티에는 프리셋 깨어남체가 포함되어 있어 편성 코드를 복사하거나 가져올 수 없습니다."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "대국이 라운드 상한에 도달했습니다. 선공 측이 대국을 종결하지 못하여 패배로 판정됩니다."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "확인"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "대전 종료"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "대국이 라운드 상한에 도달했습니다. 후공 측이 최후까지 성공적으로 버텨내어 승리로 판정됩니다."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "확인"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "대전 종료"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "항복하시겠습니까?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "항복 확인"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "클립보드에서 <color=#5EF2FF>페이즈 체스</color> 편성 데이터를 읽어 오는 데 실타래패했습니다."
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "해당 수호자를 차단하시겠습니까?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "거절"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "수락"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {
    Text = "차단하시겠습니까?"
  },
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "해당 비공개 대전이 시작되었습니다."
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "새로운 수호자가 비공개 대전에 들어왔습니다."
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "대기 중입니다..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "비공개 대전을 종료하시겠습니까?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "취소"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "종료"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "종료 확인"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "상대방이 대전 요청을 거절했습니다."
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "「기초 활성 이온」\n·해제 후, 이번 기간 코어 과제 지속 기간 동안 「일상 시험 훈련」의 「기초 활성 이온」 누적 보상에서 획득하는 「현실타래의 기점」, 「무구의 은핵」, 「경험」, 「은심」이 3배로 증가합니다. 「코어 과제」 구매 후 이번 기간에 이미 수령한 「기초 활성 이온」 누적 보상의 추가 배율 부분이 소급 지급됩니다."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "「시간 역행」\n·전투 중 경험한 턴으로 돌아갈 수 있습니다.\n·전투의 앞선 25턴 중 아무 턴으로 돌아갈 수 있습니다.\n·다시 도전한 후에도 역행 기능을 사용하여 이전 턴으로 돌아갈 수 있습니다."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "「페이즈 체스」\n·해제 후, 이번 과제 시즌 지속 기간 동안 「페이즈 체스」의 모든 카드를 사용할 수 있습니다."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>페이즈 값</color>이 클립보드에 복사되었습니다."
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "<Blue:「원액」 × {s1} >을(를) 소비하여 구매하시겠습니까?\n\n<size=30><color=#ACBFCA>「원액」 소비 시, 증정된 「원액」을 우선 차감합니다.\n(추출: {s2}, 증정: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "취소"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "구매"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "구매 확인"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "댓글 내용은 비어있을 수 없습니다."
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "해당 댓글을 삭제하시겠습니까?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "취소"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "확인"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "삭제 확인"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "모든 댓글을 숨길까요?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "아니요"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "네"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "숨기기"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "네트워크 오류가 감지되어 매칭이 잠시 중단되었습니다."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "전투 중입니다. 이전 전투를 계속하시겠습니까? \n「질주하는 환희 특급」 시즌이 업데이트되었습니다. 계속 도전하면 최신 시즌 임무를 완료할 수 있지만, 「귀빈 명단」에는 입장할 수 없습니다."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "취소"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "확인"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "힌트"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "지난 도전 진행도는 {s1} - 제 {s2} 단계 - 제 {s3} 전투이며, 「귀빈 포인트」× {s4}를 획득했습니다.\n시즌이 업데이트되었습니다. 계속 도전하면 최신 시즌 임무를 완료할 수 있지만, 「귀빈 명단」에는 입장할 수 없습니다. 계속 도전하시겠습니까?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "취소"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "확인"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "계속 도전하기"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "마지막 도전 진행도는 {s1} - {s2} 단계 - {s3} 전투이며, 「특별 점수」× {s4}를 획득했습니다.\n계속 도전하시겠습니까?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "취소"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "확인"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "계속 도전하기"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "이전 저장된 도전을 종료한 후에야 새로운 도전을 진행할 수 있습니다."
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "도전을 종료하시겠습니까?\n현재 도전의 진도가 저장됩니다. 다음 도전에서는 현재 진도를 이어가며, 해당 전투를 다시 시작합니다."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "취소"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "확인"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "저장 후 종료하기"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "도전을 종료하시겠습니까?\n현재 도전의 진도가 저장되며, 다음 도전 시 현재 진도에서 계속 진행됩니다."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "취소"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "확인"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "저장 후 종료하기"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "시즌이 업데이트되었습니다. 계속 도전하면 최신 시즌 임무를 완료할 수 있지만, 「귀빈 명단」에는 입장할 수 없습니다."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "리플레이 정보는 비어 있을 수 없습니다."
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "파티 내 깨어남체에 영역 충돌이 발생했습니다. 조정해 주세요."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "선택한 수량을 초과했습니다"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "해당 랭킹 데이터가 아직 로딩되지 않았습니다. 잠시 후 다시 화면을 열어 주세요."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "확인"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "서버 랭킹 데이터 초기화 중"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> 개의 {s2}을(를) 사용하여 <Blue:{s3}> 개의 {s4}(으)로 교환하시겠습니까?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "교환 확인"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "전투 기록이 숨겨져 있습니다"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Steam에서 「설정-게임 중」 및 본 게임 「속성-일반」에서 「게임 중 Steam 오버레이 활성화」를 켠 후 게임을 재시작하여 다시 시도해 보세요."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "확인"},
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Tip"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam 인증 오류가 발생했습니다. Steam 클라이언트를 재시작한 후 다시 시도해 주세요."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "확인"},
  TipsType_SteamRestartTips_Title = {
    Text = "로그인 오류"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "종료"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "조사 확인"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "종료"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "조사 확인"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "최상의 스토리 경험을 위해 아래 조사 스테이지를 먼저 완료하실타래 것을 권장합니다."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "종료"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "계속 조사하기"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "조사 확인"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "깨어남 소모 재료 정보가 변경되었습니다. 다시 깨어남해 주세요."
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "<Blue:「{s2}」>이(가) {s1}개 부족합니다. <Blue:「{s4}」×{s3} >로 대체하여 소모하시겠습니까?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "취소"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "확인"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "교환 확인"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:주의 사항: 선택 후, 이번 이벤트 동안은 변경할 수 없습니다!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "깨어남체 <OrangeQuality:「{s1}」, 「{s2}」, 「{s3}」, 「{s4}」>을(를) 이번 이벤트 획득률 향상 깨어남체로 지정하시겠습니까?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "선택 확인"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:주의 사항: 선택 후, 이번 이벤트 동안은 변경할 수 없습니다!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "선택 가능한 수량의 최대치에 도달했습니다."
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "모든 유형의 선택을 완료한 후 다시 시도해 주세요"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "이번 기간 지정 각성체 선택을 완료하시겠습니까?\n확인 후, 이번 기간 선택은 다시 변경할 수 없습니다."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "확인 선택"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "이미 최신 상태입니다. 더 많은 교우를 팔로우해 폭넓은 조력 선택지를 경험해 보세요!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "자동 전사가 진행 중이므로 조작할 수 없습니다."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(잠금되지 않은 속성 강도가 8이 될 때까지 자동 전사를 중지합니다.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "최대 {s1} 회 전사\n최대 소모"
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "자동 전사 확인"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "비밀 계약 가방이 가득 찼습니다"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "모든 비밀 계약을 분리하시겠습니까?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "분리 확인"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "결합된 비밀 계약이 존재하여 방안으로 저장할 수 없습니다!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "다음 비밀 계약을 결합하시겠습니까? 다른 각성체에 장착되어 있거나 편성/방안/지원전에 존재하는 비밀 계약은 자동으로 해제됩니다."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketBindTips_Title = {
    Text = "결속 확인"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "결합을 변경하시겠습니까?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "결합 변경 확인"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "모든 밀계를 분해하시겠습니까?\n\n<color=#9BA3A2><size=30>선택한 재료에 +12 밀계 부품이 포함되어 있습니다.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "분리 확인"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "결합을 변경하시겠습니까?\n\n<color=#9BA3A2><size=30>선택한 소재 중 +12 비밀 계약 부품이 포함되어 있습니다.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "결합 변경 확인"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "해당 비밀 계약을 분리하시겠습니까?\n\n<color=#9BA3A2><size=30>선택한 소재 중 +12 비밀 계약 부품이 포함되어 있습니다.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "분리 확인"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "해당 비밀 계약을 분리하시겠습니까?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "취소"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "확인"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "분리 확인"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "해당 <color=#5EF2FF>페이즈 값</color>이 사용 중입니다. 잠시 후 다시 시도하세요."
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = "<Blue:{s2}>의 초대를 수락하기를 기다리는 중\n{s1}\n입니다."
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "취소"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "비공개 대전"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "다른 수호자가 비공개 대전에 들어오기를 기다리고 있습니다\n <Blue:{s1}>\n"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "취소"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "<color=#5EF2FF>페이즈 값</color> 복사하기"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "비공개 대전"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "<Blue:{s1}>을(를) 소비하여 <Blue:랜덤> 명륜 1개를 획득하시겠습니까?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "취소"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "확인"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "사용 확인"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "이번 주 보상 횟수가 모두 소진되었습니다. 재현할 수 없습니다."
  }
})
return Text_TipsType
