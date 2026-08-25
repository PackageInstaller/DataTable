__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_100331_Name = {Text = "1승"},
  Task_100332_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_100332_Name = {Text = "10승"},
  Task_100333_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_100333_Name = {Text = "6승"},
  Task_100334_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_100334_Name = {Text = "3승"},
  Task_100523_Desc = {
    Text = "의식 잠수 「기괴한 화폭」 완료"
  },
  Task_100523_Name = {
    Text = "현세의 광상곡"
  },
  Task_100576_Desc = {
    Text = "매 턴 전투를 경험할 때마다 조사 점수가 20점 감소합니다."
  },
  Task_100576_Name = {
    Text = "시간 흐름 모래시계<size=20><color=#747474>전투를 1 회합 경험할 때마다, 조사 점수가 20점 감소합니다 </color></size>"
  },
  Task_10143_Desc = {
    Text = "총 72턴 내 클리어"
  },
  Task_10143_Name = {
    Text = "총 72턴 내 클리어"
  },
  Task_10144_Desc = {
    Text = "총 79턴 내 클리어"
  },
  Task_10144_Name = {
    Text = "총 79턴 내 클리어"
  },
  Task_10145_Desc = {
    Text = "40칸 이상 이동하지 않고 클리어"
  },
  Task_10145_Name = {
    Text = "전략적 행군"
  },
  Task_10146_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10146_Name = {
    Text = "상쾌한 기분"
  },
  Task_10147_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10147_Name = {
    Text = "상쾌한 기분"
  },
  Task_10148_Desc = {
    Text = "총 31턴 내에 클리어"
  },
  Task_10148_Name = {
    Text = "총 31턴 내에 클리어"
  },
  Task_10149_Desc = {
    Text = "총 40턴 내 클리어"
  },
  Task_10149_Name = {
    Text = "총 40턴 내 클리어"
  },
  Task_10150_Desc = {
    Text = "총 47턴 내 클리어"
  },
  Task_10150_Name = {
    Text = "총 47턴 내 클리어"
  },
  Task_10151_Desc = {
    Text = "총 58턴 내 클리어"
  },
  Task_10151_Name = {
    Text = "총 58턴 내 클리어"
  },
  Task_10152_Desc = {
    Text = "총 65턴 내 클리어"
  },
  Task_10152_Name = {
    Text = "총 65턴 내 클리어"
  },
  Task_10153_Desc = {
    Text = "융식 괴물 제거"
  },
  Task_10153_Name = {Text = "목표"},
  Task_10154_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10154_Name = {
    Text = "완벽한 통과"
  },
  Task_10155_Desc = {
    Text = "18칸 이상 이동하지 않고 클리어"
  },
  Task_10155_Name = {
    Text = "전략적 행군"
  },
  Task_10156_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_10156_Name = {
    Text = "상쾌한 기분"
  },
  Task_10157_Desc = {
    Text = "검은 인장 100개 이상을 소지한 상태로 클리어"
  },
  Task_10157_Name = {Text = "저축"},
  Task_10158_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10158_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10159_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10159_Name = {
    Text = "속전속결"
  },
  Task_10160_Desc = {
    Text = "2개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10160_Name = {
    Text = "유물의 힘"
  },
  Task_10161_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10161_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10162_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10162_Name = {
    Text = "최종 강림"
  },
  Task_10163_Desc = {
    Text = "클리어 시 4개 이상의 유물 보유"
  },
  Task_10163_Name = {
    Text = "유물의 힘"
  },
  Task_10164_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10164_Name = {
    Text = "스테이지 클리어"
  },
  Task_10165_Desc = {
    Text = "8명의 깨어남체와 동조율이 5레벨에 도달"
  },
  Task_10165_Name = {
    Text = "완벽한 파트너 Ⅳ"
  },
  Task_10166_Desc = {
    Text = "12명의 깨어남체와 동조율이 3레벨에 도달"
  },
  Task_10166_Name = {
    Text = "궁합 콤비 Ⅴ"
  },
  Task_10167_Desc = {
    Text = "45칸 이상 이동하지 않고 클리어"
  },
  Task_10167_Name = {
    Text = "전략적 행군"
  },
  Task_10168_Desc = {
    Text = "총 17턴 내에 클리어"
  },
  Task_10168_Name = {
    Text = "총 17턴 내에 클리어"
  },
  Task_10169_Desc = {
    Text = "20명의 깨어남체를 소유"
  },
  Task_10169_Name = {
    Text = "함께 싸우기II"
  },
  Task_10170_Desc = {
    Text = "30명의 깨어남체를 보유"
  },
  Task_10170_Name = {
    Text = "함께 싸우기III"
  },
  Task_10171_Desc = {
    Text = "300번의 깨어남 의식을 진행합니다"
  },
  Task_10171_Name = {
    Text = "천재 비밀지킴이 Ⅳ"
  },
  Task_10172_Desc = {
    Text = "10명의 깨어남체를 보유"
  },
  Task_10172_Name = {
    Text = "함께 싸우기"
  },
  Task_10173_Desc = {
    Text = "4명의 깨어남체와 동조율이 Lv. 5에 달성"
  },
  Task_10173_Name = {
    Text = "궁합 콤비 II"
  },
  Task_10174_Desc = {
    Text = "지갑 찾기"
  },
  Task_10174_Name = {Text = "목표"},
  Task_10175_Desc = {
    Text = "깨어남체 40명 보유"
  },
  Task_10175_Name = {
    Text = "함께 싸우기 Ⅳ"
  },
  Task_10176_Desc = {
    Text = "4명의 깨어남체와 동조율이 3에 도달했습니다"
  },
  Task_10176_Name = {
    Text = "궁합 콤비"
  },
  Task_10177_Desc = {
    Text = "포나페의 폐허 400회 완료"
  },
  Task_10177_Name = {
    Text = "포나페의 축복 Ⅳ"
  },
  Task_10178_Desc = {
    Text = "600회 포나페의 폐허 완료"
  },
  Task_10178_Name = {
    Text = "포나페의 축복 Ⅴ"
  },
  Task_10179_Desc = {
    Text = "벌레의 소굴 50번 완료"
  },
  Task_10179_Name = {
    Text = "벌레 기르는 사람"
  },
  Task_10180_Desc = {
    Text = "벌레의 소굴 100번 완료"
  },
  Task_10180_Name = {
    Text = "벌레 기르는 사람 Ⅱ"
  },
  Task_10181_Desc = {
    Text = "벌레의 소굴 200번 완료"
  },
  Task_10181_Name = {
    Text = "벌레 양육자 Ⅲ"
  },
  Task_10182_Desc = {
    Text = "400번의 벌레의 소굴 완료"
  },
  Task_10182_Name = {
    Text = "벌레 기르는 사람 Ⅳ"
  },
  Task_10183_Desc = {
    Text = "벌레의 소굴 600번 완료"
  },
  Task_10183_Name = {
    Text = "벌레 기르는 사람 Ⅴ"
  },
  Task_10184_Desc = {
    Text = "1회 초월적 존재 클리어"
  },
  Task_10184_Name = {
    Text = "은밀한 탄생에 관하여"
  },
  Task_10185_Desc = {
    Text = "10회 클리어한 초월적 존재"
  },
  Task_10185_Name = {
    Text = "은밀한 탄생에 관하여 Ⅱ"
  },
  Task_10186_Desc = {
    Text = "25회 클리어 초월적 존재"
  },
  Task_10186_Name = {
    Text = "은밀한 탄생에 관하여 Ⅲ"
  },
  Task_10187_Desc = {
    Text = "제3장 「조심하십시오, 사나운 개가 있습니다」 조사 완료"
  },
  Task_10187_Name = {
    Text = "별의 새싹"
  },
  Task_10188_Desc = {
    Text = "전투 횟수 6회 이하로 클리어"
  },
  Task_10188_Name = {
    Text = "정밀 돌파"
  },
  Task_10189_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10189_Name = {
    Text = "안전제일"
  },
  Task_10190_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10190_Name = {
    Text = "상쾌한 기분"
  },
  Task_10191_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10191_Name = {
    Text = "완벽한 통과"
  },
  Task_10192_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10192_Name = {
    Text = "완벽한 통과"
  },
  Task_10193_Desc = {
    Text = "젠킨 찾기"
  },
  Task_10193_Name = {Text = "목표"},
  Task_10194_Desc = {
    Text = "약재 연마 Ⅰ 클리어"
  },
  Task_10194_Name = {Text = "임무 3"},
  Task_10195_Desc = {
    Text = "파견 임무 2회 완료"
  },
  Task_10195_Name = {Text = "임무 2"},
  Task_10196_Desc = {
    Text = "누적 40회 깨어남"
  },
  Task_10196_Name = {Text = "임무 1"},
  Task_10197_Desc = {
    Text = "제1장의 공명을 5회 업그레이드"
  },
  Task_10197_Name = {Text = "임무 5"},
  Task_10198_Desc = {
    Text = "깨어남체 4명 10레벨 달성"
  },
  Task_10198_Name = {Text = "임무 4"},
  Task_10199_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10199_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10200_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10200_Name = {
    Text = "상쾌한 기분"
  },
  Task_10201_Desc = {
    Text = "동력실타래 탈출"
  },
  Task_10201_Name = {Text = "목표"},
  Task_10202_Desc = {
    Text = "클리어 시 8장 이상의 각인된 카드를 보유한 상태로 클리어"
  },
  Task_10202_Name = {
    Text = "각인된 힘"
  },
  Task_10203_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10203_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10204_Desc = {
    Text = "조사 장소로 이동하세요"
  },
  Task_10204_Name = {Text = "목표"},
  Task_10205_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10205_Name = {
    Text = "속전속결"
  },
  Task_10206_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10206_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10207_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10207_Name = {
    Text = "안전제일"
  },
  Task_10208_Desc = {
    Text = "35칸 이상 이동하지 않고 클리어"
  },
  Task_10208_Name = {
    Text = "전략적 행군"
  },
  Task_10209_Desc = {
    Text = "클리어 시 4개 이상의 유물 보유"
  },
  Task_10209_Name = {
    Text = "유물의 힘"
  },
  Task_10210_Desc = {
    Text = "180 린피테이프 소모하기"
  },
  Task_10210_Name = {
    Text = "린피테이프 소모"
  },
  Task_10211_Desc = {
    Text = "길을 막는 아이들 배제"
  },
  Task_10211_Name = {Text = "목표"},
  Task_10212_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_10212_Name = {Text = "제1단계"},
  Task_10213_Desc = {
    Text = "차원을 넘어 다포딜을 쫓기"
  },
  Task_10213_Name = {Text = "목표"},
  Task_10215_Desc = {
    Text = "최종전 6턴 내 승리"
  },
  Task_10215_Name = {
    Text = "최종전 6턴 내 승리"
  },
  Task_10216_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10216_Name = {
    Text = "스테이지 클리어"
  },
  Task_10217_Desc = {
    Text = "최종전 15턴 내 승리하고, 압력이 500 미만일 것"
  },
  Task_10217_Name = {
    Text = "최종전 15턴 내 승리 압력 500 이내"
  },
  Task_10218_Desc = {
    Text = "4명의 20레벨 혈육 깨어남체 소유"
  },
  Task_10218_Name = {
    Text = "혈육의 주인 II"
  },
  Task_10219_Desc = {
    Text = "머피를 따라가기"
  },
  Task_10219_Name = {Text = "목표"},
  Task_10220_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10220_Name = {
    Text = "스테이지 클리어"
  },
  Task_10221_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10221_Name = {
    Text = "스테이지 클리어"
  },
  Task_10222_Desc = {
    Text = "누적하여 50장의 카드를 사용함"
  },
  Task_10223_Desc = {
    Text = "해골 사냥꾼의 단서를 찾다"
  },
  Task_10223_Name = {Text = "목표"},
  Task_10224_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10224_Name = {
    Text = "스테이지 클리어"
  },
  Task_10226_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10226_Name = {
    Text = "스테이지 클리어"
  },
  Task_10228_Desc = {
    Text = "선장 찾기"
  },
  Task_10228_Name = {Text = "목표"},
  Task_10229_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10229_Name = {
    Text = "스테이지 클리어"
  },
  Task_10230_Desc = {
    Text = "「지옥의 파수견」 추적"
  },
  Task_10230_Name = {Text = "목표"},
  Task_10231_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10231_Name = {
    Text = "속전속결"
  },
  Task_10232_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10232_Name = {
    Text = "스테이지 클리어"
  },
  Task_10233_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10233_Name = {
    Text = "스테이지 클리어"
  },
  Task_10234_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10234_Name = {
    Text = "스테이지 클리어"
  },
  Task_10235_Desc = {
    Text = "조사 60번 해연잔상"
  },
  Task_10235_Name = {
    Text = "깊은 바다의 폐허 Ⅲ"
  },
  Task_10236_Desc = {
    Text = "조사 30 회 해연잔상"
  },
  Task_10236_Name = {
    Text = "깊은 바다의 폐허 Ⅱ"
  },
  Task_10237_Desc = {
    Text = "120회 혼탁한 잔상 조사"
  },
  Task_10237_Name = {
    Text = "혼돈의 폐허 Ⅳ"
  },
  Task_10238_Desc = {
    Text = "혼탁한 잔상 조사 60번"
  },
  Task_10238_Name = {
    Text = "혼돈의 폐허 Ⅲ"
  },
  Task_10239_Desc = {
    Text = "해연잔상을 15번 조사"
  },
  Task_10239_Name = {
    Text = "깊은 바다의 폐허"
  },
  Task_10240_Desc = {
    Text = "240번 혼탁한 잔상 조사"
  },
  Task_10240_Name = {
    Text = "혼돈의 폐허Ⅴ"
  },
  Task_10241_Desc = {
    Text = "약재 연마 600회 완료"
  },
  Task_10241_Name = {
    Text = "조리 고수 Ⅴ"
  },
  Task_10242_Desc = {
    Text = "약재 연마 400회 완료"
  },
  Task_10242_Name = {
    Text = "조리 고수 Ⅳ"
  },
  Task_10243_Desc = {
    Text = "조사 30번 혼탁한 잔상"
  },
  Task_10243_Name = {
    Text = "혼돈의 폐허 Ⅱ"
  },
  Task_10244_Desc = {
    Text = "15번의 혼탁한 잔상 조사"
  },
  Task_10244_Name = {
    Text = "혼돈의 폐허"
  },
  Task_10245_Desc = {
    Text = "젠킨 보호"
  },
  Task_10245_Name = {Text = "목표"},
  Task_10246_Desc = {
    Text = "광인의 이변 저지"
  },
  Task_10246_Name = {Text = "목표"},
  Task_10247_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_10247_Name = {Text = "제3단계"},
  Task_10248_Desc = {
    Text = "다락문을 열 도구 찾기"
  },
  Task_10248_Name = {Text = "목표"},
  Task_10249_Desc = {
    Text = "위험에서 벗어나기"
  },
  Task_10249_Name = {Text = "목표"},
  Task_10250_Desc = {
    Text = "레벨이 끝날 때 최소 2개의 이벤트 타입 노드를 통과해야 합니다"
  },
  Task_10250_Name = {
    Text = "노드 트리거 타입"
  },
  Task_10251_Desc = {
    Text = "클리어 시 캠프로 체력 회복하지 않음"
  },
  Task_10251_Name = {
    Text = "특수 도전 유형"
  },
  Task_10252_Desc = {
    Text = "최종전이 끝날 때 최소 50%의 체력이 남아 있어야 합니다"
  },
  Task_10252_Name = {
    Text = "최종전 체력 요구사항 유형"
  },
  Task_10253_Desc = {
    Text = "증상 카드 최소 2장으로 클리어"
  },
  Task_10253_Name = {
    Text = "덱 플래닝 클래스"
  },
  Task_10254_Desc = {
    Text = "증상 카드 최대 2장 클리어"
  },
  Task_10254_Name = {
    Text = "덱 플래닝 클래스"
  },
  Task_10255_Desc = {
    Text = "스텝 수가 30스텝 이상일 때 클리어"
  },
  Task_10255_Name = {
    Text = "경로 계획 종류"
  },
  Task_10256_Desc = {
    Text = "25 단계 이내에 클리어"
  },
  Task_10256_Name = {
    Text = "경로 계획 종류"
  },
  Task_10258_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10258_Name = {
    Text = "스테이지 클리어"
  },
  Task_10259_Desc = {
    Text = "상태가 명령에 의해 제거된 횟수 (예: 성공적으로 약화 효과를 두 번 해제함)"
  },
  Task_10259_Name = {
    Text = "전투 효과 종류"
  },
  Task_10260_Desc = {
    Text = "상태가 명령에 의해 추가된 회수 (예: 성공적으로 약화 효과를 한번 추가)"
  },
  Task_10260_Name = {
    Text = "전투 효과 종류"
  },
  Task_10265_Desc = {
    Text = "해골 사냥꾼을 격퇴시키기"
  },
  Task_10265_Name = {Text = "목표"},
  Task_10266_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10266_Name = {
    Text = "안전제일"
  },
  Task_10267_Desc = {
    Text = "전투 횟수 3회 이하로 클리어"
  },
  Task_10267_Name = {
    Text = "정밀 돌파"
  },
  Task_10268_Desc = {
    Text = "50개 이상의 검은 인장을 소지한 상태로 클리어"
  },
  Task_10268_Name = {Text = "저축"},
  Task_10269_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10269_Name = {
    Text = "상쾌한 기분"
  },
  Task_10270_Desc = {
    Text = "클리어 시 8장 이상의 각인된 카드를 보유한 상태로 클리어"
  },
  Task_10270_Name = {
    Text = "각인된 힘"
  },
  Task_10271_Desc = {
    Text = "28칸 이상 이동하지 않고 클리어"
  },
  Task_10271_Name = {
    Text = "전략적 행군"
  },
  Task_10272_Desc = {
    Text = "모든 전투를 합쳐 광기 폭발 사용 횟수 4회 이하로 클리어"
  },
  Task_10272_Name = {
    Text = "냉정하고 우아하게"
  },
  Task_10273_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10273_Name = {
    Text = "최종 강림"
  },
  Task_10274_Desc = {
    Text = "클리어 시 4개 이상의 유물 보유"
  },
  Task_10274_Name = {
    Text = "유물의 힘"
  },
  Task_10275_Desc = {
    Text = "총 73턴 내 클리어"
  },
  Task_10275_Name = {
    Text = "총 73턴 내 클리어"
  },
  Task_10276_Desc = {
    Text = "선실타래로 들어가기"
  },
  Task_10276_Name = {Text = "목표"},
  Task_10277_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10277_Desc = {
    Text = "도서관에서 조용히 앉아 있는 것은 당신이 더 많은 깨어남체를 획득하게 하지 않습니다. \n출발하세요, 두 발을 내딛고 자연 속에서 그 만분의 하나의 가능성을 찾아보세요."
  },
  Task_10277_Name = {
    Text = "조사 임무: 밀은 추적"
  },
  Task_10278_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10278_Name = {
    Text = "상쾌한 기분"
  },
  Task_10279_Desc = {
    Text = "45칸 이상 이동하지 않고 클리어"
  },
  Task_10279_Name = {
    Text = "전략적 행군"
  },
  Task_10280_Desc = {
    Text = "30칸 이상 이동하지 않고 클리어"
  },
  Task_10280_Name = {
    Text = "전략적 행군"
  },
  Task_10281_Desc = {
    Text = "초차원 영역 깨어남체 1명 2단계로 승격"
  },
  Task_10281_Name = {
    Text = "초차원 숙련 Ⅱ"
  },
  Task_10282_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10282_Name = {
    Text = "안전제일"
  },
  Task_10283_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_10283_Name = {Text = "제5단계"},
  Task_10284_Desc = {
    Text = "최종전 17턴 내 승리"
  },
  Task_10284_Name = {
    Text = "최종전 17턴 내 승리"
  },
  Task_10285_Desc = {
    Text = "소모 10000000장미 금권"
  },
  Task_10285_Name = {
    Text = "금을 흙처럼 쓰다Ⅴ"
  },
  Task_10287_Desc = {
    Text = "5000000장미 금권 소모"
  },
  Task_10287_Name = {
    Text = "금을 흙처럼 쓰다Ⅳ"
  },
  Task_10288_Desc = {
    Text = "최종전 15턴 내 승리"
  },
  Task_10288_Name = {
    Text = "최종전 15턴 내 승리"
  },
  Task_10289_Desc = {
    Text = "전투 횟수 5회 이하로 클리어"
  },
  Task_10289_Name = {
    Text = "정밀 돌파"
  },
  Task_10290_Desc = {
    Text = "구석의 목소리 찾기"
  },
  Task_10290_Name = {Text = "목표"},
  Task_10292_Desc = {
    Text = "누적 로그인 90일"
  },
  Task_10292_Name = {Text = "지속성"},
  Task_10293_Desc = {
    Text = "누적 로그인 60 일"
  },
  Task_10293_Name = {
    Text = "그 세계에서 왔다"
  },
  Task_10294_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10294_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10295_Desc = {
    Text = "의문의 여성으로부터 벗어나기"
  },
  Task_10295_Name = {Text = "목표"},
  Task_10297_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10297_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10298_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10298_Name = {
    Text = "속전속결"
  },
  Task_10301_Desc = {
    Text = "지옥의 파수견 처치"
  },
  Task_10301_Name = {Text = "목표"},
  Task_10302_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10302_Desc = {
    Text = "카오스는 자연의 법칙이고, 질서는 인간의 망상이다."
  },
  Task_10302_Name = {
    Text = "연구 임무: 순백의 시편"
  },
  Task_10302_UnlockCondDesc = {
    Text = "수호자 레벨 25에 해금"
  },
  Task_10303_Desc = {
    Text = "수호자 조사 등급 35레벨 달성하기"
  },
  Task_10303_Name = {
    Text = "수호자 능력 고사 Ⅳ"
  },
  Task_10305_Desc = {
    Text = "8명의 깨어남체와 동조율을 레벨 3에 도달"
  },
  Task_10305_Name = {
    Text = "궁합 콤비 III"
  },
  Task_10307_Desc = {
    Text = "혼돈의 영역 Ⅰ 클리어"
  },
  Task_10307_Name = {Text = "임무 5"},
  Task_10308_Desc = {
    Text = "임의의 잔상 시험 1회 클리어"
  },
  Task_10308_Name = {Text = "임무 4"},
  Task_10309_Desc = {
    Text = "금권 수사 Ⅰ 클리어"
  },
  Task_10309_Name = {Text = "임무 3"},
  Task_10310_Desc = {
    Text = "깨어남체 4명 20레벨 달성"
  },
  Task_10310_Name = {Text = "임무 2"},
  Task_10311_Desc = {
    Text = "환몽 심잠 1회 클리어"
  },
  Task_10311_Name = {Text = "임무 1"},
  Task_10313_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10313_Name = {
    Text = "안전제일"
  },
  Task_10314_Desc = {
    Text = "30칸 이상 이동하지 않고 클리어"
  },
  Task_10314_Name = {
    Text = "전략적 행군"
  },
  Task_10315_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10315_Name = {
    Text = "최종 강림"
  },
  Task_10316_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10316_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10317_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_10317_Name = {
    Text = "상쾌한 기분"
  },
  Task_10318_Desc = {
    Text = "3개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10318_Name = {
    Text = "유물의 힘"
  },
  Task_10319_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10319_Name = {
    Text = "속전속결"
  },
  Task_10320_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10320_Desc = {
    Text = "빛나는 것이 반드시 황금이 아닐 수 있지만, 가격은 반드시 비싸다. \n전해지는 말에 따르면, 미사그는 이탈한 연금술사들에 의해 설립되었으며, 그들의 야망은 점석성금을 넘어선 것이었다."
  },
  Task_10320_Name = {
    Text = "연구 임무: 연금술 노트"
  },
  Task_10321_Desc = {
    Text = "33칸 이상 이동하지 않고 클리어"
  },
  Task_10321_Name = {
    Text = "전략적 행군"
  },
  Task_10322_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10322_Name = {
    Text = "유물의 힘"
  },
  Task_10323_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10323_Desc = {
    Text = "엄격하게 말하자면, 깨어남체도 은심 테크의 한 종류라고 할 수 있죠.\n수호자는 그들이 낙오되지 않도록 최선을 다해야 할 겁니다."
  },
  Task_10323_Name = {
    Text = "연구 임무: 약재 조제"
  },
  Task_10324_Desc = {
    Text = "학장실타래 내부의 이형 괴물 격퇴"
  },
  Task_10324_Name = {Text = "목표"},
  Task_10325_Desc = {
    Text = "2개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10325_Name = {
    Text = "유물의 힘"
  },
  Task_10326_Desc = {
    Text = "5장 이상의 각인된 카드를 소지한 상태로 클리어"
  },
  Task_10326_Name = {
    Text = "각인된 힘"
  },
  Task_10327_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_10327_Name = {
    Text = "상쾌한 기분"
  },
  Task_10328_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10328_Name = {
    Text = "스테이지 클리어"
  },
  Task_10329_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10329_Name = {
    Text = "스테이지 클리어"
  },
  Task_10330_Desc = {
    Text = "30칸 이상 이동하지 않고 클리어"
  },
  Task_10330_Name = {
    Text = "전략적 행군"
  },
  Task_10331_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10331_Name = {
    Text = "스테이지 클리어"
  },
  Task_10332_Desc = {
    Text = "최종전 12턴 내 승리"
  },
  Task_10332_Name = {
    Text = "최종전 12턴 내 승리"
  },
  Task_10333_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10333_Name = {
    Text = "스테이지 클리어"
  },
  Task_10334_Desc = {
    Text = "깨어남체 스킬 3회 향상"
  },
  Task_10334_Name = {
    Text = "아레나 애호가 (미사용)"
  },
  Task_10335_Desc = {
    Text = "클리어 무광의 경계 Ⅷ (미완성)"
  },
  Task_10336_Desc = {
    Text = "정신병원의 비밀 탐색"
  },
  Task_10336_Name = {Text = "목표"},
  Task_10337_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10337_Name = {
    Text = "완벽한 통과"
  },
  Task_10338_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10338_Name = {
    Text = "완벽한 통과"
  },
  Task_10339_Desc = {
    Text = "최종전 7턴 내 승리"
  },
  Task_10339_Name = {
    Text = "최종전 7턴 내 승리"
  },
  Task_10340_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10340_Name = {
    Text = "완벽한 통과"
  },
  Task_10341_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10341_Name = {
    Text = "완벽한 통과"
  },
  Task_10342_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10342_Name = {
    Text = "완벽한 통과"
  },
  Task_10343_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10343_Name = {
    Text = "완벽한 통과"
  },
  Task_10344_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10344_Name = {
    Text = "완벽한 통과"
  },
  Task_10345_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10345_Name = {
    Text = "완벽한 통과"
  },
  Task_10346_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10346_Name = {
    Text = "완벽한 통과"
  },
  Task_10347_Desc = {
    Text = "초차원 영역 깨어남체 1명 3단계로 승격"
  },
  Task_10347_Name = {
    Text = "초차원 숙련 Ⅲ"
  },
  Task_10348_Desc = {
    Text = "혈육 영역 깨어남체 1명 3단계로 승격"
  },
  Task_10348_Name = {
    Text = "혈육 숙련Ⅲ"
  },
  Task_10349_Desc = {
    Text = "심해 영역 깨어남체 1명 3단계로 승격"
  },
  Task_10349_Name = {
    Text = "심해 숙련 Ⅲ"
  },
  Task_10350_Desc = {
    Text = "혼돈 영역 깨어남체 1명 3단계로 승격"
  },
  Task_10350_Name = {
    Text = "혼돈 숙련 Ⅲ"
  },
  Task_10351_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10351_Name = {
    Text = "스테이지 클리어"
  },
  Task_10352_Desc = {
    Text = "4명의 레벨 40 혈육 깨어남체를 소유하고 있습니다"
  },
  Task_10352_Name = {
    Text = "혈육의 주인 Ⅳ"
  },
  Task_10353_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10353_Name = {
    Text = "스테이지 클리어"
  },
  Task_10354_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10354_Name = {
    Text = "스테이지 클리어"
  },
  Task_10355_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10355_Name = {
    Text = "스테이지 클리어"
  },
  Task_10356_Desc = {
    Text = "아이기스 쫓기"
  },
  Task_10356_Name = {Text = "목표"},
  Task_10357_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10357_Name = {
    Text = "스테이지 클리어"
  },
  Task_10358_Desc = {
    Text = "최종전 3턴 내 승리"
  },
  Task_10358_Name = {
    Text = "최종전 3턴 내 승리"
  },
  Task_10359_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10359_Name = {
    Text = "스테이지 클리어"
  },
  Task_10360_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10360_Name = {
    Text = "스테이지 클리어"
  },
  Task_10361_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10361_Name = {
    Text = "스테이지 클리어"
  },
  Task_10362_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10362_Name = {
    Text = "스테이지 클리어"
  },
  Task_10363_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10363_Name = {
    Text = "스테이지 클리어"
  },
  Task_10364_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10364_Name = {
    Text = "스테이지 클리어"
  },
  Task_10365_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10365_Name = {
    Text = "스테이지 클리어"
  },
  Task_10366_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10366_Name = {
    Text = "스테이지 클리어"
  },
  Task_10367_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10367_Name = {
    Text = "스테이지 클리어"
  },
  Task_10368_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10368_Name = {
    Text = "스테이지 클리어"
  },
  Task_10369_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10369_Name = {
    Text = "스테이지 클리어"
  },
  Task_10370_Desc = {
    Text = "10곳의 메인 줄기 제2장 「@1@2」의 분해점 찾기"
  },
  Task_10370_Desc2 = {
    Text = "메인 줄기 제2장 「로상의 이름으로」의 분해점 10 개를 찾아라"
  },
  Task_10370_Name2 = {
    Text = "숨겨진 속삭임Ⅱ"
  },
  Task_10371_Desc = {
    Text = "9개의 메인 줄기 제3장 「@1@2」의 분해점 찾기"
  },
  Task_10371_Desc2 = {
    Text = "9곳의 메인 줄기 제3장 「조심하십시오, 사나운 개가 있습니다」의 분해점을 찾았습니다"
  },
  Task_10371_Name2 = {
    Text = "숨겨진 속삭임 Ⅲ"
  },
  Task_10372_Desc = {
    Text = "336회의 파견 태스크 완료"
  },
  Task_10372_Name = {
    Text = "특파행동Ⅴ"
  },
  Task_10373_Desc = {
    Text = "8개의 메인 줄기 제1장 「동구의 비밀」의 분해점 찾기"
  },
  Task_10373_Name = {
    Text = "숨겨진 속삭임"
  },
  Task_10374_Desc = {
    Text = "84번의 파견 임무 완료"
  },
  Task_10374_Name = {
    Text = "특파행동Ⅲ"
  },
  Task_10375_Desc = {
    Text = "168개의 파견 태스크 완료"
  },
  Task_10375_Name = {
    Text = "특파행동Ⅳ"
  },
  Task_10376_Desc = {
    Text = "12번의 파견 태스크 완료"
  },
  Task_10376_Name = {
    Text = "특파행동"
  },
  Task_10377_Desc = {
    Text = "36개의 파견 태스크 완료"
  },
  Task_10377_Name = {
    Text = "특파행동Ⅱ"
  },
  Task_10378_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10378_Name = {
    Text = "스테이지 클리어"
  },
  Task_10379_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10379_Name = {
    Text = "스테이지 클리어"
  },
  Task_10380_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10380_Name = {
    Text = "스테이지 클리어"
  },
  Task_10381_Desc = {
    Text = "메인 줄기 제4장 「@1@2」의 분해점 12곳을 찾으세요"
  },
  Task_10381_Desc2 = {
    Text = "12개의 메인 줄기 제4장 「무성한 곳에서」의 분해점을 발견하다"
  },
  Task_10381_Name2 = {
    Text = "숨겨진 속삭임 Ⅳ"
  },
  Task_10382_Desc = {
    Text = "4명의 레벨 60 깊은 바다 깨어남체를 소유함"
  },
  Task_10382_Name = {
    Text = "깊은 바다의 주인 Ⅵ"
  },
  Task_10384_Desc = {
    Text = "최종전에서 1턴 동안 1000 이상의 방어막을 획득"
  },
  Task_10384_Name = {
    Text = "과잉 방어"
  },
  Task_10385_Desc = {
    Text = "의식의 통로를 지나, 프랜시스를 쫓기"
  },
  Task_10385_Name = {Text = "목표"},
  Task_10387_Desc = {
    Text = "융식 이변체 처치"
  },
  Task_10387_Name = {Text = "목표"},
  Task_10388_Desc = {
    Text = "사라를 지하실타래로 데려가기"
  },
  Task_10388_Name = {Text = "목표"},
  Task_10390_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10390_Name = {
    Text = "속전속결"
  },
  Task_10391_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10391_Name = {
    Text = "속전속결"
  },
  Task_10392_Desc = {
    Text = "차원 공간과 「그」의 시선에서 탈출하기"
  },
  Task_10392_Name = {Text = "목표"},
  Task_10394_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10394_Name = {
    Text = "속전속결"
  },
  Task_10395_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10395_Name = {
    Text = "속전속결"
  },
  Task_10396_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10396_Name = {
    Text = "속전속결"
  },
  Task_10397_Desc = {
    Text = "정신을 잃은 릴리 깨우기"
  },
  Task_10397_Name = {Text = "목표"},
  Task_10404_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10404_Name = {
    Text = "속전속결"
  },
  Task_10405_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10405_Name = {
    Text = "속전속결"
  },
  Task_10406_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10406_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10407_Desc = {
    Text = "어두운 지하철 통과"
  },
  Task_10407_Name = {Text = "목표"},
  Task_10409_Desc = {
    Text = "정신병원 탈출"
  },
  Task_10409_Name = {Text = "목표"},
  Task_10413_Desc = {
    Text = "클리어 시 4개 이상의 유물 보유"
  },
  Task_10413_Name = {
    Text = "유물의 힘"
  },
  Task_10419_Desc = {
    Text = "판디아 추적"
  },
  Task_10419_Name = {Text = "목표"},
  Task_10420_Desc = {
    Text = "조사 이벤트 「무성한 곳에서」 어려움 난이도 완료"
  },
  Task_10420_Name = {
    Text = "엄마, 저는 아프지 않아요·어려움"
  },
  Task_10421_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10421_Name = {
    Text = "속전속결"
  },
  Task_10422_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10422_Name = {
    Text = "속전속결"
  },
  Task_10423_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10423_Name = {
    Text = "속전속결"
  },
  Task_10424_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10424_Name = {
    Text = "속전속결"
  },
  Task_10425_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10425_Name = {
    Text = "속전속결"
  },
  Task_10426_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10426_Name = {
    Text = "속전속결"
  },
  Task_10427_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10427_Name = {
    Text = "속전속결"
  },
  Task_10428_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10428_Name = {
    Text = "속전속결"
  },
  Task_10429_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10429_Name = {
    Text = "속전속결"
  },
  Task_10430_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10430_Name = {
    Text = "속전속결"
  },
  Task_10431_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10431_Name = {
    Text = "속전속결"
  },
  Task_10432_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10432_Name = {
    Text = "속전속결"
  },
  Task_10433_Desc = {
    Text = "전투 횟수 6회 이하로 클리어"
  },
  Task_10433_Name = {
    Text = "정밀 돌파"
  },
  Task_10434_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10434_Name = {
    Text = "안전제일"
  },
  Task_10435_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10435_Name = {
    Text = "상쾌한 기분"
  },
  Task_10436_Desc = {
    Text = "연구원 저지"
  },
  Task_10436_Name = {Text = "목표"},
  Task_10437_Desc = {
    Text = "지하실타래 진입"
  },
  Task_10437_Name = {Text = "목표"},
  Task_10438_Desc = {
    Text = "총 24턴 내 클리어"
  },
  Task_10438_Name = {
    Text = "총 24턴 내 클리어"
  },
  Task_10439_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10439_Name = {
    Text = "속전속결"
  },
  Task_10440_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10440_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10441_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10441_Name = {
    Text = "속전속결"
  },
  Task_10442_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10442_Name = {
    Text = "속전속결"
  },
  Task_10443_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10443_Name = {
    Text = "속전속결"
  },
  Task_10444_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10444_Name = {
    Text = "속전속결"
  },
  Task_10445_Desc = {
    Text = "누적 소모 1000 검은 인장"
  },
  Task_10445_Name = {
    Text = "검은 소환Ⅲ"
  },
  Task_10446_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10446_Name = {
    Text = "속전속결"
  },
  Task_10447_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10447_Name = {
    Text = "속전속결"
  },
  Task_10448_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10448_Name = {
    Text = "속전속결"
  },
  Task_10449_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10449_Name = {
    Text = "스테이지 클리어"
  },
  Task_10450_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10450_Name = {
    Text = "스테이지 클리어"
  },
  Task_10451_Desc = {
    Text = "600회 금지된 기록 완료"
  },
  Task_10451_Name = {
    Text = "미스터리 문양 조각사 Ⅴ"
  },
  Task_10452_Desc = {
    Text = "금지된 기록 400번 완성"
  },
  Task_10452_Name = {
    Text = "미스터리 문양 조각사 Ⅳ"
  },
  Task_10453_Desc = {
    Text = "200회 금지된 기록 달성"
  },
  Task_10453_Name = {
    Text = "미스터리 문양 조각사 Ⅲ"
  },
  Task_10454_Desc = {
    Text = "비밀 계약 6세트 효과 활성화"
  },
  Task_10454_Name = {Text = "임무 4"},
  Task_10455_Desc = {
    Text = "50번의 금지된 기록 완성"
  },
  Task_10455_Name = {
    Text = "미스터리 문양 조각사"
  },
  Task_10456_Desc = {
    Text = "50회 클리어 초월적 존재"
  },
  Task_10456_Name = {
    Text = "은밀한 탄생에 관하여 Ⅳ"
  },
  Task_10457_Desc = {
    Text = "로탄 찾기"
  },
  Task_10457_Name = {Text = "목표"},
  Task_10458_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10458_Name = {
    Text = "스테이지 클리어"
  },
  Task_10459_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10459_Name = {
    Text = "스테이지 클리어"
  },
  Task_10460_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10460_Name = {
    Text = "스테이지 클리어"
  },
  Task_10461_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10461_Name = {
    Text = "스테이지 클리어"
  },
  Task_10462_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10462_Name = {
    Text = "스테이지 클리어"
  },
  Task_10463_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10463_Name = {
    Text = "스테이지 클리어"
  },
  Task_10464_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10464_Name = {
    Text = "스테이지 클리어"
  },
  Task_10465_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10465_Name = {
    Text = "스테이지 클리어"
  },
  Task_10466_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10466_Name = {
    Text = "스테이지 클리어"
  },
  Task_10467_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10467_Name = {
    Text = "스테이지 클리어"
  },
  Task_10468_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10468_Name = {
    Text = "스테이지 클리어"
  },
  Task_10469_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10469_Name = {
    Text = "스테이지 클리어"
  },
  Task_10470_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10470_Name = {
    Text = "스테이지 클리어"
  },
  Task_10471_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10471_Name = {
    Text = "스테이지 클리어"
  },
  Task_10472_Desc = {
    Text = "조사 메인 스토리 제2장 「밀랍인형의 이름으로」 완료"
  },
  Task_10473_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10473_Desc = {
    Text = "그들은 자신이 알아차리지 못한 공포 속에서 굴러다닙니다. \n무지하며, 어두우며, 이름 없이."
  },
  Task_10473_Name = {
    Text = "연구 임무: 진홍색 시편"
  },
  Task_10473_UnlockCondDesc = {
    Text = "수호자 레벨 25에 해금"
  },
  Task_10474_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10474_Name = {
    Text = "스테이지 클리어"
  },
  Task_10475_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10475_Name = {
    Text = "속전속결"
  },
  Task_10476_Desc = {
    Text = "금권 수사 400회 완료"
  },
  Task_10476_Name = {
    Text = "금굴러 Ⅳ"
  },
  Task_10477_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10477_Name = {
    Text = "안전제일"
  },
  Task_10478_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10478_Name = {
    Text = "속전속결"
  },
  Task_10479_Desc = {
    Text = "최종전 10턴 내 승리"
  },
  Task_10479_Name = {
    Text = "최종전 10턴 내 승리"
  },
  Task_10480_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10480_Name = {
    Text = "스테이지 클리어"
  },
  Task_10481_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10481_Name = {
    Text = "속전속결"
  },
  Task_10482_Desc = {
    Text = "조사 메인 스토리 제4장 「무성한 곳에서」 완료"
  },
  Task_10483_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10483_Name = {
    Text = "스테이지 클리어"
  },
  Task_10484_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10484_Name = {
    Text = "스테이지 클리어"
  },
  Task_10485_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10485_Name = {
    Text = "스테이지 클리어"
  },
  Task_10486_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10486_Name = {
    Text = "스테이지 클리어"
  },
  Task_10487_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10487_Name = {
    Text = "스테이지 클리어"
  },
  Task_10488_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10488_Name = {
    Text = "스테이지 클리어"
  },
  Task_10489_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10489_Name = {
    Text = "스테이지 클리어"
  },
  Task_10490_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10490_Name = {
    Text = "스테이지 클리어"
  },
  Task_10492_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10492_Name = {
    Text = "스테이지 클리어"
  },
  Task_10493_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10493_Name = {
    Text = "스테이지 클리어"
  },
  Task_10494_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10494_Name = {
    Text = "스테이지 클리어"
  },
  Task_10495_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10495_Name = {
    Text = "스테이지 클리어"
  },
  Task_10496_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10496_Name = {
    Text = "스테이지 클리어"
  },
  Task_10497_Desc = {
    Text = "30번의 환몽 심잠 완료"
  },
  Task_10497_Name = {
    Text = "심해잠수자Ⅲ"
  },
  Task_10498_Desc = {
    Text = "60회 환몽 심잠 완료"
  },
  Task_10498_Name = {
    Text = "심해잠수자Ⅳ"
  },
  Task_10499_Desc = {
    Text = "1회 환몽 심잠 완료"
  },
  Task_10499_Name = {
    Text = "심해잠수자"
  },
  Task_10500_Desc = {
    Text = "15번의 환몽 심잠 완료"
  },
  Task_10500_Name = {
    Text = "심해잠수자Ⅱ"
  },
  Task_10501_Desc = {
    Text = "한 번의 데미지가 800에 도달했습니다"
  },
  Task_10501_Name = {
    Text = "강력한 피해 Ⅲ"
  },
  Task_10502_Desc = {
    Text = "한 번의 데미지가 1000에 도달했습니다"
  },
  Task_10502_Name = {
    Text = "강력한 피해 Ⅳ"
  },
  Task_10503_Desc = {
    Text = "한 번의 데미지가 200에 도달했습니다"
  },
  Task_10503_Name = {
    Text = "강력한 피해"
  },
  Task_10504_Desc = {
    Text = "데미지가 400에 도달했습니다"
  },
  Task_10504_Name = {
    Text = "강력한 피해 Ⅱ"
  },
  Task_10505_Desc = {
    Text = "데미지가 5000에 도달하면"
  },
  Task_10505_Name = {
    Text = "치명적 피해Ⅴ"
  },
  Task_10506_Desc = {
    Text = "적에게 500층 중독을 적용"
  },
  Task_10506_Name = {
    Text = "독성학 전문가"
  },
  Task_10507_Desc = {
    Text = "아이기스 저지"
  },
  Task_10507_Name = {Text = "목표"},
  Task_10510_Desc = {
    Text = "특정 유형의 전투 X에서 한 턴에 1000 이상의 데미지를 입힌다 (X 엘리트 전투)"
  },
  Task_10510_Name = {
    Text = "전율 카니발"
  },
  Task_10511_Desc = {
    Text = "특정 유형의 전투 X에서 한 턴에 광기 폭발 사용 횟수가 5회 이상"
  },
  Task_10511_Name = {
    Text = "연쇄 광란"
  },
  Task_10512_Desc = {
    Text = "클리어 시 캠프 답변 기능 사용 횟수가 1회 이하인 경우"
  },
  Task_10512_Name = {
    Text = "안전지대"
  },
  Task_10513_Desc = {
    Text = "클리어 시 캠프의 지도 탐색도가 80% 초과 또는 같음"
  },
  Task_10513_Name = {
    Text = "대개의 눈앞을 밝혀주다"
  },
  Task_10514_Desc = {
    Text = "클리어 시 X타입의 카드가 3장 이하"
  },
  Task_10514_Name = {
    Text = "면역 전선"
  },
  Task_10515_Desc = {
    Text = "클리어 시 X타입의 카드가 3장 이하"
  },
  Task_10515_Name = {
    Text = "중상 통지"
  },
  Task_10516_Desc = {
    Text = "클리어 시 특정 타입 X의 유물이 3개 이상 (X황금)"
  },
  Task_10516_Name = {
    Text = "골드 시커"
  },
  Task_10517_Desc = {
    Text = "2종류 이상의 각인을 획득 (영감과 고급 영감 포함)"
  },
  Task_10517_Name = {
    Text = "각인 수집가"
  },
  Task_10518_Desc = {
    Text = "2명 이상의 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10518_Name = {
    Text = "깨어남의 순간"
  },
  Task_10519_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10519_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10520_Desc = {
    Text = "습격해오는 등불 교도 격퇴"
  },
  Task_10520_Name = {Text = "목표"},
  Task_10521_Desc = {
    Text = "법진을 그릴 시간을 벌기"
  },
  Task_10521_Name = {Text = "목표"},
  Task_10523_Desc = {
    Text = "임의의 깨어남체 스킬 3레벨 달성"
  },
  Task_10523_Name = {Text = "임무 2"},
  Task_10524_Desc = {
    Text = "메인 스토리 조사·1-8 어려움 클리어"
  },
  Task_10524_Name = {Text = "임무 3"},
  Task_10525_Desc = {
    Text = "깨어남체 4명 40레벨 달성"
  },
  Task_10525_Name = {Text = "임무 1"},
  Task_10526_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10526_Name = {
    Text = "속전속결"
  },
  Task_10527_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10527_Name = {
    Text = "속전속결"
  },
  Task_10528_Desc = {
    Text = "약재 연마 100회 완료"
  },
  Task_10528_Name = {
    Text = "천재 약사 Ⅱ"
  },
  Task_10529_Desc = {
    Text = "혼돈의 영역 Ⅵ 클리어"
  },
  Task_10529_Name = {Text = "임무 5"},
  Task_10530_Desc = {
    Text = "히로와 결착 짓기"
  },
  Task_10530_Name = {Text = "목표"},
  Task_10531_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10531_Name = {
    Text = "속전속결"
  },
  Task_10532_Desc = {
    Text = "금권 수사 200회 완료"
  },
  Task_10532_Name = {
    Text = "금굴러Ⅲ"
  },
  Task_10533_Desc = {
    Text = "돌과 협력하여 등불 교도 격퇴"
  },
  Task_10533_Name = {Text = "목표"},
  Task_10534_Desc = {
    Text = "금권 수사 50회 완료"
  },
  Task_10534_Name = {
    Text = "골드 시커"
  },
  Task_10535_Desc = {
    Text = "금권 수사 100회 완료"
  },
  Task_10535_Name = {
    Text = "금굴러Ⅱ"
  },
  Task_10536_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10536_Name = {
    Text = "스테이지 클리어"
  },
  Task_10537_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10537_Name = {
    Text = "속전속결"
  },
  Task_10538_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10538_Desc = {
    Text = "때로는 파괴의 충동이 창조의 충동이다. \n화필을 들어라, 예술은 어떤 준비도 필요하지 않다."
  },
  Task_10538_Name = {
    Text = "조사 임무: 다다이즘"
  },
  Task_10538_UnlockCondDesc = {
    Text = "조사 이벤트 1-13 오픈"
  },
  Task_10539_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_10539_Name = {Text = "제2단계"},
  Task_10540_Desc = {
    Text = "조사 메인 스토리 제1장 「동부 지구의 비밀」 어려움 난이도 완료"
  },
  Task_10544_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10544_Name = {
    Text = "완벽한 통과"
  },
  Task_10545_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10545_Name = {
    Text = "완벽한 통과"
  },
  Task_10546_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_10546_Name = {
    Text = "안녕하세요, 비밀지킴이"
  },
  Task_10547_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10547_Name = {
    Text = "완벽한 통과"
  },
  Task_10548_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10548_Name = {
    Text = "완벽한 통과"
  },
  Task_10549_Desc = {
    Text = "혼돈의 영역·간격 Ⅰ 완료하기"
  },
  Task_10550_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10550_Name = {
    Text = "완벽한 통과"
  },
  Task_10552_Desc = {
    Text = "2개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10552_Name = {
    Text = "유물의 힘"
  },
  Task_10553_Desc = {
    Text = "5장 이상의 각인된 카드를 소지한 상태로 클리어"
  },
  Task_10553_Name = {
    Text = "각인된 힘"
  },
  Task_10554_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_10554_Name = {
    Text = "상쾌한 기분"
  },
  Task_10555_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_10555_Name = {
    Text = "영역 숙련 Ⅲ"
  },
  Task_10556_Desc = {
    Text = "33칸 이상 이동하지 않고 클리어"
  },
  Task_10556_Name = {
    Text = "전략적 행군"
  },
  Task_10557_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10557_Name = {
    Text = "완벽한 통과"
  },
  Task_10558_Desc = {
    Text = "전투 횟수 5회 이하로 클리어"
  },
  Task_10558_Name = {
    Text = "정밀 돌파"
  },
  Task_10565_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10565_Desc = {
    Text = "그의 본능, 이성 그리고 마음은 작은 유리병에 봉인되어 있다. \n세상은 이제 그와 상관없게 되었다."
  },
  Task_10565_Name = {
    Text = "조사 임무: 활성 해리"
  },
  Task_10565_UnlockCondDesc = {
    Text = "조사 이벤트 1-13 오픈"
  },
  Task_10571_Desc = {
    Text = "150번의 깨어남 의식을 진행."
  },
  Task_10571_Name = {
    Text = "천재 비밀지킴이 Ⅲ"
  },
  Task_10572_Desc = {
    Text = "깨어남 의식을 100번 수행"
  },
  Task_10572_Name = {
    Text = "천재 비밀지킴이 Ⅱ"
  },
  Task_10575_Desc = {
    Text = "혈육 영역 깨어남체 1명 5단계로 승격"
  },
  Task_10575_Name = {
    Text = "혈육 숙련 Ⅴ"
  },
  Task_10576_Desc = {
    Text = "심해 영역 깨어남체 1명 5단계로 승격"
  },
  Task_10576_Name = {
    Text = "심해 숙련 Ⅴ"
  },
  Task_10577_Desc = {
    Text = "50번의 깨어남 의식 수행"
  },
  Task_10577_Name = {
    Text = "천재 비밀지킴이"
  },
  Task_10578_Desc = {
    Text = "초차원 영역 깨어남체 1명 5단계로 승격"
  },
  Task_10578_Name = {
    Text = "초차원 숙련 Ⅴ"
  },
  Task_10579_Desc = {
    Text = "12개의 9레벨 미스터리를 소유"
  },
  Task_10579_Name = {
    Text = "미스터리 컬렉터 Ⅱ"
  },
  Task_10580_Desc = {
    Text = "6개의 6레벨 미스터리를 소유"
  },
  Task_10580_Name = {
    Text = "미스터리 컬렉터"
  },
  Task_10581_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10581_Name = {
    Text = "속전속결"
  },
  Task_10582_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10582_Name = {
    Text = "속전속결"
  },
  Task_10583_Desc = {
    Text = "프랜시스의 흔적 추적"
  },
  Task_10583_Name = {Text = "목표"},
  Task_10584_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10584_Name = {
    Text = "속전속결"
  },
  Task_10585_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10585_Name = {
    Text = "속전속결"
  },
  Task_10586_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10586_Name = {
    Text = "속전속결"
  },
  Task_10587_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10587_Name = {
    Text = "속전속결"
  },
  Task_10588_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10588_Name = {
    Text = "속전속결"
  },
  Task_10589_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10589_Name = {
    Text = "속전속결"
  },
  Task_10590_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10590_Name = {
    Text = "속전속결"
  },
  Task_10591_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_10591_Name = {
    Text = "상쾌한 기분"
  },
  Task_10592_Desc = {
    Text = "라이 정신병원에 다시 들어가기"
  },
  Task_10592_Name = {Text = "목표"},
  Task_10593_Desc = {
    Text = "최종전 15턴 내 승리"
  },
  Task_10593_Name = {
    Text = "최종전 15턴 내 승리"
  },
  Task_10595_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10595_Name = {
    Text = "완벽한 통과"
  },
  Task_10596_Desc = {
    Text = "눈밭에서 탈출하기"
  },
  Task_10596_Name = {Text = "목표"},
  Task_10597_Desc = {
    Text = "파견 3회 실타래행하기"
  },
  Task_10597_Name = {
    Text = "임무 진행"
  },
  Task_10598_Desc = {
    Text = "총 38턴내에 클리어"
  },
  Task_10598_Name = {
    Text = "총 38턴내에 클리어"
  },
  Task_10599_Desc = {
    Text = "2500000장미 금권 소모"
  },
  Task_10599_Name = {
    Text = "금을 흙처럼 쓰다Ⅲ"
  },
  Task_10600_Desc = {
    Text = "로그인하기"
  },
  Task_10600_Name = {
    Text = "로그인하기"
  },
  Task_10601_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10601_Name = {
    Text = "완벽한 통과"
  },
  Task_10602_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10602_Name = {
    Text = "스테이지 클리어"
  },
  Task_10603_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10603_Name = {
    Text = "최종 강림"
  },
  Task_10604_Desc = {
    Text = "클리어 시 4개 이상의 유물 보유"
  },
  Task_10604_Name = {
    Text = "유물의 힘"
  },
  Task_10605_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10605_Name = {
    Text = "스테이지 클리어"
  },
  Task_10606_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10606_Name = {
    Text = "상쾌한 기분"
  },
  Task_10607_Desc = {
    Text = "클리어 시 8장 이상의 각인된 카드를 보유한 상태로 클리어"
  },
  Task_10607_Name = {
    Text = "각인된 힘"
  },
  Task_10608_Desc = {
    Text = "수호자 조사 등급 25레벨 달성하기"
  },
  Task_10608_Name = {
    Text = "수호자 능력 고사 Ⅲ"
  },
  Task_10609_Desc = {
    Text = "모든 전투를 합쳐 광기 폭발 사용 횟수 4회 이하로 클리어"
  },
  Task_10609_Name = {
    Text = "냉정하고 우아하게"
  },
  Task_10610_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10610_Name = {
    Text = "완벽한 통과"
  },
  Task_10611_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10611_Name = {
    Text = "안전제일"
  },
  Task_10612_Desc = {
    Text = "전투 횟수 3회 이하로 클리어"
  },
  Task_10612_Name = {
    Text = "정밀 돌파"
  },
  Task_10613_Desc = {
    Text = "50개 이상의 검은 인장을 소지한 상태로 클리어"
  },
  Task_10613_Name = {Text = "저축"},
  Task_10614_Desc = {
    Text = "16명의 깨어남체와의 동조율이 3레벨에 도달"
  },
  Task_10614_Name = {
    Text = "궁합 콤비 Ⅶ"
  },
  Task_10616_Desc = {
    Text = "레벨 40의 심해 깨어남체를 4명 보유"
  },
  Task_10616_Name = {
    Text = "깊은 바다의 주인 Ⅳ"
  },
  Task_10618_Desc = {
    Text = "총 48턴 내 클리어"
  },
  Task_10618_Name = {
    Text = "총 48턴 내 클리어"
  },
  Task_10619_Desc = {
    Text = "총 53턴 내 클리어"
  },
  Task_10619_Name = {
    Text = "총 53턴 내 클리어"
  },
  Task_10620_Desc = {
    Text = "조사 30회 차원 잔상"
  },
  Task_10620_Name = {
    Text = "초월의 황무지Ⅱ"
  },
  Task_10621_Desc = {
    Text = "차원 잔상 60번 조사"
  },
  Task_10621_Name = {
    Text = "초월의 황무지 Ⅲ"
  },
  Task_10622_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10622_Name = {
    Text = "완벽한 통과"
  },
  Task_10623_Desc = {
    Text = "차원 잔상 15번 조사"
  },
  Task_10623_Name = {
    Text = "초월의 황무지"
  },
  Task_10624_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10624_Name = {
    Text = "완벽한 통과"
  },
  Task_10625_Desc = {
    Text = "기질 잔상 120번 조사"
  },
  Task_10625_Name = {
    Text = "혈육의 폐허Ⅳ"
  },
  Task_10626_Desc = {
    Text = "기질 잔상 15번 조사"
  },
  Task_10626_Name = {
    Text = "혈육의 폐허"
  },
  Task_10627_Desc = {
    Text = "기질 잔상을 30번 조사"
  },
  Task_10627_Name = {
    Text = "혈육의 폐허Ⅱ"
  },
  Task_10628_Desc = {
    Text = "전투 횟수 6회 이하로 클리어"
  },
  Task_10628_Name = {
    Text = "정밀 돌파"
  },
  Task_10629_Desc = {
    Text = "해연잔상 240번 조사"
  },
  Task_10629_Name = {
    Text = "깊은 바다의 폐허Ⅴ"
  },
  Task_10630_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10630_Name = {
    Text = "완벽한 통과"
  },
  Task_10631_Desc = {
    Text = "특정 전투 X(보통)에서 한 턴에 적 3마리 이상 죽이기"
  },
  Task_10631_Name = {
    Text = "사냥의 시간"
  },
  Task_10632_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10632_Name = {
    Text = "완벽한 통과"
  },
  Task_10633_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10633_Name = {
    Text = "완벽한 통과"
  },
  Task_10634_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10634_Name = {
    Text = "완벽한 통과"
  },
  Task_10635_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10635_Name = {
    Text = "유물의 힘"
  },
  Task_10636_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10636_Name = {
    Text = "완벽한 통과"
  },
  Task_10637_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10637_Name = {
    Text = "완벽한 통과"
  },
  Task_10638_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10638_Name = {
    Text = "완벽한 통과"
  },
  Task_10639_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_10639_Name = {Text = "제4단계"},
  Task_10640_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10640_Name = {
    Text = "완벽한 통과"
  },
  Task_10641_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10641_Name = {
    Text = "완벽한 통과"
  },
  Task_10642_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10642_Name = {
    Text = "완벽한 통과"
  },
  Task_10643_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10643_Name = {
    Text = "완벽한 통과"
  },
  Task_10644_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10644_Name = {
    Text = "완벽한 통과"
  },
  Task_10645_Desc = {
    Text = "초차원 영역 깨어남체 1명 1단계로 승격"
  },
  Task_10645_Name = {
    Text = "초차원 숙련 Ⅰ"
  },
  Task_10646_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10646_Name = {
    Text = "스테이지 클리어"
  },
  Task_10647_Desc = {
    Text = "혼돈 영역 깨어남체 1명 1단계로 승격"
  },
  Task_10647_Name = {
    Text = "혼돈 숙련 Ⅰ"
  },
  Task_10648_Desc = {
    Text = "혈육 영역 깨어남체 1명 1단계로 승격"
  },
  Task_10648_Name = {
    Text = "혈육 숙련 Ⅰ"
  },
  Task_10649_Desc = {
    Text = "심해 영역 깨어남체 1명 1단계로 승격"
  },
  Task_10649_Name = {
    Text = "심해 숙련 Ⅰ"
  },
  Task_10650_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10650_Name = {
    Text = "안전제일"
  },
  Task_10651_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10651_Name = {
    Text = "스테이지 클리어"
  },
  Task_10652_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_10652_Desc2 = {
    Text = "조사 완료 이벤트 「로상의 이름으로」"
  },
  Task_10652_Name2 = {
    Text = "왁스 속의 수수께끼"
  },
  Task_10653_Desc = {
    Text = "조사 이벤트 「동구의 비밀」에서 공명을 3회"
  },
  Task_10653_Name = {
    Text = "감사의 반향"
  },
  Task_10654_Desc = {
    Text = "누적 로그인 30일"
  },
  Task_10654_Name = {
    Text = "적극분자"
  },
  Task_10656_Desc = {
    Text = "클리어 무광의 경계 Ⅶ (미완성)"
  },
  Task_10656_Name = {Text = "조각가"},
  Task_10658_Desc = {
    Text = "매 경기 30점"
  },
  Task_10658_Name = {
    Text = "전투 승리  <size=20><color=#747474>각 경기 30점</color></size>"
  },
  Task_10660_Desc = {Text = "찍!"},
  Task_10660_Name = {Text = "찍찍!"},
  Task_10661_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10661_Name = {
    Text = "스테이지 클리어"
  },
  Task_10663_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_10663_Name = {
    Text = "일찍 일어난 새가 벌레를 잡는다"
  },
  Task_10664_Desc = {
    Text = "50칸 이상 이동하지 않고 클리어"
  },
  Task_10664_Name = {
    Text = "전략적 행군"
  },
  Task_10665_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10665_Name = {
    Text = "안전제일"
  },
  Task_10666_Desc = {
    Text = "전투 횟수 7회 이하로 클리어"
  },
  Task_10666_Name = {
    Text = "정밀 돌파"
  },
  Task_10667_Desc = {
    Text = "깨어남체 4명 60레벨 달성"
  },
  Task_10667_Name = {Text = "임무 1"},
  Task_10668_Desc = {
    Text = "공격 작전/방어 훈련/협동 전투 20 회 완료"
  },
  Task_10668_Name = {
    Text = "스킬 재료 던전 (미사용)"
  },
  Task_10669_Desc = {
    Text = "메인 줄기의 조사 관문을 10회 완료"
  },
  Task_10669_Name = {
    Text = "메인 스토리 관문 (미사용)"
  },
  Task_10670_Desc = {
    Text = "혈육의 늪지·간격 Ⅰ 완료하기"
  },
  Task_10671_Desc = {
    Text = "상점에서 장미 금권을 소모하여 3회 교환"
  },
  Task_10671_Name = {
    Text = "금권 구매"
  },
  Task_10672_Desc = {
    Text = "친구에게 좋아요 10회 보내기"
  },
  Task_10672_Name = {
    Text = "친구에게 좋아요 보내기"
  },
  Task_10673_Desc = {
    Text = "초월적 존재 1회 클리어"
  },
  Task_10673_Name = {
    Text = "주간 보스"
  },
  Task_10674_Desc = {
    Text = "페이즈 체스 3회 참여"
  },
  Task_10674_Name = {Text = "PVP 전투"},
  Task_10675_Desc = {
    Text = "주간 시련 완료"
  },
  Task_10675_Name = {
    Text = "주간 시련"
  },
  Task_10676_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_10676_Name = {
    Text = "친구 조력"
  },
  Task_10677_Desc = {
    Text = "이번 주 환몽 심잠 누적 점수 1800점 달성"
  },
  Task_10677_Name = {
    Text = "환몽 심잠"
  },
  Task_10678_Desc = {
    Text = "클리어 시 남은 검은 인장 하나당 3점, 최대 600점"
  },
  Task_10678_Name = {
    Text = "검은 인장 <size=20><color=#747474>클리어 시 남은 검은 인장 1개당 3점 획득, 최대 600점</color></size>"
  },
  Task_10679_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_10679_Name = {
    Text = "속전속결"
  },
  Task_10680_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10680_Desc = {
    Text = "차원, 공간, 양자……perhaps 당신은 이러한 용어 뒤에 숨은 깊은 의미를 영원히 이해할 수 없을 것입니다.\n이 세상에서 일어나는 대부분의 일들을 이해할 수 없는 것처럼."
  },
  Task_10680_Name = {
    Text = "연구 임무: 보라색 시편"
  },
  Task_10680_UnlockCondDesc = {
    Text = "수호자 레벨 25에 해금"
  },
  Task_10681_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10681_Name = {
    Text = "안전제일"
  },
  Task_10682_Desc = {
    Text = "최종전 25턴 내 승리"
  },
  Task_10682_Name = {
    Text = "최종전 25턴 내 승리"
  },
  Task_10683_Desc = {
    Text = "혼돈 영역 깨어남체 1명 2단계로 승격"
  },
  Task_10683_Name = {
    Text = "혼돈 숙련 Ⅱ"
  },
  Task_10684_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 8회 발생했습니다"
  },
  Task_10684_Desc2 = {
    Text = "조사 이벤트 「조심하십시오, 사나운 개가 있습니다」에서의 공명 8회"
  },
  Task_10684_Name2 = {
    Text = "인내의 울림 Ⅲ"
  },
  Task_10685_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10685_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10686_Desc = {
    Text = "3개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10686_Name = {
    Text = "유물의 힘"
  },
  Task_10687_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10687_Name = {
    Text = "안전제일"
  },
  Task_10688_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10688_Name = {
    Text = "안전제일"
  },
  Task_10689_Desc = {
    Text = "30칸 이상 이동하지 않고 클리어"
  },
  Task_10689_Name = {
    Text = "전략적 행군"
  },
  Task_10690_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10690_Name = {
    Text = "최종 강림"
  },
  Task_10691_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10691_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10692_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10692_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10693_Desc = {
    Text = "변이의 근원 제거"
  },
  Task_10693_Name = {Text = "목표"},
  Task_10694_Desc = {
    Text = "습격해오는 등불 교도 격퇴"
  },
  Task_10694_Name = {Text = "목표"},
  Task_10695_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10695_Name = {
    Text = "완벽한 통과"
  },
  Task_10696_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10696_Name = {
    Text = "완벽한 통과"
  },
  Task_10698_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10698_Name = {
    Text = "완벽한 통과"
  },
  Task_10706_Desc = {
    Text = "비밀 계약 강화 1회 (미완성)"
  },
  Task_10706_Name = {
    Text = "장신구 강화 (미사용)"
  },
  Task_10707_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10707_Name = {
    Text = "속전속결"
  },
  Task_10708_Desc = {
    Text = "35칸 이상 이동하지 않고 클리어"
  },
  Task_10708_Name = {
    Text = "전략적 행군"
  },
  Task_10710_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10710_Name = {
    Text = "속전속결"
  },
  Task_10713_Desc = {
    Text = "혼돈 영역 깨어남체 1명 5단계로 승격"
  },
  Task_10713_Name = {
    Text = "혼돈 숙련 Ⅴ"
  },
  Task_10714_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10714_Name = {
    Text = "속전속결"
  },
  Task_10715_Desc = {
    Text = "포위 돌파"
  },
  Task_10715_Name = {Text = "목표"},
  Task_10716_Desc = {
    Text = "수호자 조사 등급 5레벨 달성하기"
  },
  Task_10716_Name = {
    Text = "수호자 능력 고사Ⅰ"
  },
  Task_10717_Desc = {
    Text = "최종전에서 1턴 동안 1500 이상의 방어막을 획득"
  },
  Task_10717_Name = {
    Text = "과잉 방어"
  },
  Task_10720_Desc = {
    Text = "혼돈의 영역 균열 Ⅶ 클리어"
  },
  Task_10720_Name = {Text = "임무 5"},
  Task_10721_Desc = {
    Text = "임의의 비밀 계약 6개 +12 강화"
  },
  Task_10721_Name = {Text = "임무 4"},
  Task_10722_Desc = {
    Text = "클리어 시 8장 이상의 각인된 카드를 보유한 상태로 클리어"
  },
  Task_10722_Name = {
    Text = "각인된 힘"
  },
  Task_10723_Desc = {
    Text = "모든 전투를 합쳐 광기 폭발 사용 횟수 4회 이하로 클리어"
  },
  Task_10723_Name = {
    Text = "냉정하고 우아하게"
  },
  Task_10724_Desc = {
    Text = "임의의 깨어남체 스킬 4레벨 달성"
  },
  Task_10724_Name = {Text = "임무 1"},
  Task_10725_Desc = {
    Text = "최종전에서 1턴 동안 2000 이상의 방어막을 획득"
  },
  Task_10725_Name = {
    Text = "과잉 방어"
  },
  Task_10727_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10727_Name = {
    Text = "완벽한 통과"
  },
  Task_10728_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10728_Name = {
    Text = "완벽한 통과"
  },
  Task_10729_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10729_Name = {
    Text = "완벽한 통과"
  },
  Task_10733_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10733_Desc = {
    Text = "그것은 신이 우주를 쓰는 언어입니다. \n그 언어를 들을 때, 당신은 무한을 듣고 있는 것입니다."
  },
  Task_10733_Name = {
    Text = "조사 임무: 옛날의 잔권"
  },
  Task_10733_UnlockCondDesc = {
    Text = "조사 이벤트 1-13 오픈"
  },
  Task_10734_Desc = {
    Text = "금권 수사 600회 완료"
  },
  Task_10734_Name = {
    Text = "금굴러Ⅴ"
  },
  Task_10735_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10735_Name = {
    Text = "속전속결"
  },
  Task_10736_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10736_Desc = {
    Text = "엄격하게 말하자면, 깨어남체도 은심 테크의 한 종류라고 할 수 있죠.\n수호자는 그들이 낙오되지 않도록 최선을 다해야 할 겁니다."
  },
  Task_10736_Name = {
    Text = "연구 임무: 약재 조제"
  },
  Task_10737_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10737_Name = {
    Text = "완벽한 통과"
  },
  Task_10738_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10738_Name = {
    Text = "속전속결"
  },
  Task_10739_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10739_Name = {
    Text = "완벽한 통과"
  },
  Task_10740_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10740_Name = {
    Text = "완벽한 통과"
  },
  Task_10741_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10741_Name = {
    Text = "안전제일"
  },
  Task_10742_Desc = {
    Text = "2개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_10742_Name = {
    Text = "유물의 힘"
  },
  Task_10743_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10743_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10744_Desc = {
    Text = "전투 횟수 5회 이하로 클리어"
  },
  Task_10744_Name = {
    Text = "정밀 돌파"
  },
  Task_10745_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_10745_Name = {
    Text = "상쾌한 기분"
  },
  Task_10746_Desc = {
    Text = "검은 인장 100개 이상을 소지한 상태로 클리어"
  },
  Task_10746_Name = {Text = "저축"},
  Task_10747_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10747_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10748_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_10748_Name = {
    Text = "최종 강림"
  },
  Task_10749_Desc = {
    Text = "클리어 시 4개 이상의 유물 보유"
  },
  Task_10749_Name = {
    Text = "유물의 힘"
  },
  Task_10750_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10750_Name = {
    Text = "스테이지 클리어"
  },
  Task_10751_Desc = {
    Text = "총 88턴 내 클리어"
  },
  Task_10751_Name = {
    Text = "총 88턴 내 클리어"
  },
  Task_10752_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10752_Name = {
    Text = "속전속결"
  },
  Task_10753_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_10753_Desc2 = {
    Text = "이벤트 「로상의 이름으로」에서 공명 3회"
  },
  Task_10753_Name2 = {
    Text = "경련의 울림"
  },
  Task_10754_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_10754_Desc2 = {
    Text = "이벤트 「로상의 이름으로」에서 공명 6회"
  },
  Task_10754_Name2 = {
    Text = "경련의 울림 Ⅱ"
  },
  Task_10755_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 8회 발생했습니다"
  },
  Task_10755_Desc2 = {
    Text = "조사 이벤트 「로상의 이름으로」에서 총 8번 공명했습니다"
  },
  Task_10755_Name2 = {
    Text = "경련의 울림 Ⅲ"
  },
  Task_10756_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_10756_Desc2 = {
    Text = "조사 사건 「조심하십시오, 사나운 개가 있습니다」에서 공명 3회"
  },
  Task_10756_Name2 = {
    Text = "인내의 울림"
  },
  Task_10757_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_10757_Desc2 = {
    Text = "조사 사건 「조심하십시오, 사나운 개가 있습니다」에서 공명 6회"
  },
  Task_10757_Name2 = {
    Text = "인내의 울림 Ⅱ"
  },
  Task_10758_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10758_Name = {
    Text = "속전속결"
  },
  Task_10759_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 10회"
  },
  Task_10759_Desc2 = {
    Text = "조사 이벤트 「조심하십시오, 사나운 개가 있습니다」에서 총 공명 10회"
  },
  Task_10759_Name2 = {
    Text = "인내의 울림 Ⅳ"
  },
  Task_10760_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_10760_Desc2 = {
    Text = "조사 이벤트 「무성한 곳에서」에서 총 공명 3회"
  },
  Task_10760_Name2 = {
    Text = "고통의 울림"
  },
  Task_10761_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_10761_Desc2 = {
    Text = "조사 이벤트 「무성한 곳에서」에서 6번 공명했습니다"
  },
  Task_10761_Name2 = {
    Text = "고통의 울림 Ⅱ"
  },
  Task_10762_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 8회 발생했습니다"
  },
  Task_10762_Desc2 = {
    Text = "조사 사건 「무성한 곳에서」에서 공명 8회"
  },
  Task_10762_Name2 = {
    Text = "고통의 울림 Ⅲ"
  },
  Task_10763_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10763_Name = {
    Text = "속전속결"
  },
  Task_10764_Desc = {
    Text = "심해의 유산 1회 클리어"
  },
  Task_10764_Name = {
    Text = "타워 클리어 - 깊은 바다"
  },
  Task_10765_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_10765_Name = {
    Text = "속전속결"
  },
  Task_10766_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10766_Name = {
    Text = "스테이지 클리어"
  },
  Task_10767_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10767_Name = {
    Text = "스테이지 클리어"
  },
  Task_10768_Desc = {
    Text = "4명의 레벨 10 초원차원 깨어남체를 보유"
  },
  Task_10768_Name = {
    Text = "초월의 주인"
  },
  Task_10769_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10769_Name = {
    Text = "안전제일"
  },
  Task_10770_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_10770_Name = {
    Text = "영역 숙련 Ⅴ"
  },
  Task_10771_Desc = {
    Text = "혼돈의 영역 1회 클리어"
  },
  Task_10771_Name = {
    Text = "타워 클리어-카오스"
  },
  Task_10772_Desc = {
    Text = "초원차원의 여정을 한 번 클리어"
  },
  Task_10772_Name = {
    Text = "타워 클리어-초원차원"
  },
  Task_10773_Desc = {
    Text = "혈육의 늪에서 1회 클리어"
  },
  Task_10773_Name = {
    Text = "타워 클리어-혈육"
  },
  Task_10774_Desc = {
    Text = "융재금지구역 1회 클리어 (특훈 점수 30점 달성)"
  },
  Task_10774_Name = {
    Text = "융재금지구역"
  },
  Task_10775_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10775_Name = {
    Text = "완벽한 통과"
  },
  Task_10776_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10776_Name = {
    Text = "완벽한 통과"
  },
  Task_10777_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10777_Name = {
    Text = "완벽한 통과"
  },
  Task_10778_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10778_Name = {
    Text = "완벽한 통과"
  },
  Task_10779_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10779_Name = {
    Text = "완벽한 통과"
  },
  Task_10780_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10780_Name = {
    Text = "완벽한 통과"
  },
  Task_10781_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10781_Name = {
    Text = "완벽한 통과"
  },
  Task_10782_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10782_Name = {
    Text = "완벽한 통과"
  },
  Task_10783_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10783_Name = {
    Text = "완벽한 통과"
  },
  Task_10784_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10784_Name = {
    Text = "완벽한 통과"
  },
  Task_10785_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10785_Name = {
    Text = "완벽한 통과"
  },
  Task_10786_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10786_Name = {
    Text = "완벽한 통과"
  },
  Task_10787_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10787_Desc = {
    Text = "빛나는 것이 반드시 황금이 아닐 수 있지만, 가격은 반드시 비싸다. \n전해지는 말에 따르면, 미사그는 이탈한 연금술사들에 의해 설립되었으며, 그들의 야망은 점석성금을 넘어선 것이었다."
  },
  Task_10787_Name = {
    Text = "연구 임무: 연금술 노트"
  },
  Task_10789_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10789_Name = {
    Text = "완벽한 통과"
  },
  Task_10790_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10790_Name = {
    Text = "완벽한 통과"
  },
  Task_10791_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10791_Name = {
    Text = "완벽한 통과"
  },
  Task_10792_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10792_Name = {
    Text = "완벽한 통과"
  },
  Task_10793_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10793_Name = {
    Text = "완벽한 통과"
  },
  Task_10794_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10794_Name = {
    Text = "완벽한 통과"
  },
  Task_10795_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10795_Name = {
    Text = "완벽한 통과"
  },
  Task_10796_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10796_Name = {
    Text = "완벽한 통과"
  },
  Task_10797_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10797_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10798_Desc = {
    Text = "적에게 2000개의 중독을 겹쳐줍니다"
  },
  Task_10798_Name = {
    Text = "독성학 전문가 Ⅲ"
  },
  Task_10799_Desc = {
    Text = "적에게 1000단계 중독을 겹쳐줍니다"
  },
  Task_10799_Name = {
    Text = "독성학 전문가 Ⅱ"
  },
  Task_10800_Desc = {
    Text = "반격으로 4명의 적을 처치하고 승리하세요"
  },
  Task_10800_Name = {
    Text = "정당방위"
  },
  Task_10801_Desc = {
    Text = "적에게 5000층 중독을 부여함"
  },
  Task_10801_Name = {
    Text = "독성학 전문가 Ⅳ"
  },
  Task_10802_Desc = {
    Text = "던전 클리어 시 카드 덱에 30장의 카드를 보유하게 됩니다"
  },
  Task_10802_Name = {
    Text = "카드 수집가"
  },
  Task_10803_Desc = {
    Text = "크리티컬 데미지로 6명의 적을 처치하고 승리를 거두세요"
  },
  Task_10803_Name = {
    Text = "갑작스러운 잔혹"
  },
  Task_10804_Desc = {
    Text = "한 번의 전투에서 손패 30장을 버리고 승리를 거두다"
  },
  Task_10804_Name = {
    Text = "모든 것을 무시하는"
  },
  Task_10805_Desc = {
    Text = "던전 클리어 시 덱에 8장의 증상 카드가 있습니다"
  },
  Task_10805_Name = {
    Text = "불운이 뒤따르다"
  },
  Task_10806_Desc = {
    Text = "1 턴에 10의 산출력을 소모하고 승리."
  },
  Task_10806_Name = {
    Text = "산무유책"
  },
  Task_10807_Desc = {
    Text = "던전을 클리어하면 7개의 유물 소지"
  },
  Task_10807_Name = {
    Text = "유물 수집가"
  },
  Task_10808_Desc = {
    Text = "임의의 깨어남체 스킬 5레벨 달성"
  },
  Task_10808_Name = {Text = "임무 2"},
  Task_10809_Desc = {
    Text = "혼돈 영역 깨어남체 1명 4단계로 승격"
  },
  Task_10809_Name = {
    Text = "혼돈 숙련 IV"
  },
  Task_10810_Desc = {
    Text = "비밀 계약 전사 10회 완료"
  },
  Task_10810_Name = {Text = "임무 4"},
  Task_10811_Desc = {
    Text = "혼돈의 영역 Ⅷ 클리어"
  },
  Task_10811_Name = {Text = "임무 5"},
  Task_10812_Desc = {
    Text = "초차원 영역 깨어남체 1명 4단계로 승격"
  },
  Task_10812_Name = {
    Text = "초차원 숙련 IV"
  },
  Task_10814_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10814_Name = {
    Text = "스테이지 클리어"
  },
  Task_10815_Desc = {
    Text = "6장 이하의 각인된 카드를 소지한 상태로 클리어"
  },
  Task_10815_Name = {
    Text = "각인 억제"
  },
  Task_10817_Desc = {
    Text = "약재 연마 50회 완료"
  },
  Task_10817_Name = {
    Text = "천재 약사"
  },
  Task_10818_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10818_Name = {
    Text = "완벽한 통과"
  },
  Task_10819_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10819_Name = {
    Text = "완벽한 통과"
  },
  Task_10820_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10820_Name = {
    Text = "완벽한 통과"
  },
  Task_10821_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10821_Name = {
    Text = "완벽한 통과"
  },
  Task_10822_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10822_Name = {
    Text = "완벽한 통과"
  },
  Task_10823_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10823_Name = {
    Text = "완벽한 통과"
  },
  Task_10824_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10824_Name = {
    Text = "완벽한 통과"
  },
  Task_10825_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10825_Name = {
    Text = "속전속결"
  },
  Task_10826_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10826_Name = {
    Text = "스테이지 클리어"
  },
  Task_10827_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10827_Name = {
    Text = "완벽한 통과"
  },
  Task_10828_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10828_Name = {
    Text = "속전속결"
  },
  Task_10830_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10830_Name = {
    Text = "완벽한 통과"
  },
  Task_10831_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10831_Name = {
    Text = "완벽한 통과"
  },
  Task_10832_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10832_Name = {
    Text = "스테이지 클리어"
  },
  Task_10833_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10833_Name = {
    Text = "스테이지 클리어"
  },
  Task_10834_Desc = {
    Text = "10장 이상의 각인된 카드를 소지한 상태로 클리어"
  },
  Task_10834_Name = {
    Text = "각인된 힘"
  },
  Task_10835_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10835_Name = {
    Text = "스테이지 클리어"
  },
  Task_10836_Desc = {
    Text = "최종전 20턴 내 승리"
  },
  Task_10836_Name = {
    Text = "최종전 20턴 내 승리"
  },
  Task_10839_Desc = {
    Text = "50칸 이상 이동하지 않고 클리어"
  },
  Task_10839_Name = {
    Text = "전략적 행군"
  },
  Task_10840_Desc = {
    Text = "총 43턴 내 클리어"
  },
  Task_10840_Name = {
    Text = "총 43턴 내 클리어"
  },
  Task_10842_Desc = {
    Text = "조사 완료 이벤트 「조심하십시오, 사나운 개가 있습니다」 어려움"
  },
  Task_10842_Name = {Text = "조각가"},
  Task_10844_Desc = {
    Text = "심해 영역 깨어남체 1명 2단계로 승격"
  },
  Task_10844_Name = {
    Text = "심해 숙련 Ⅱ"
  },
  Task_10845_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10845_Name = {
    Text = "스테이지 클리어"
  },
  Task_10848_Desc = {
    Text = "24칸 이상 이동하지 않고 클리어"
  },
  Task_10848_Name = {
    Text = "전략적 행군"
  },
  Task_10852_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10852_Name = {
    Text = "완벽한 통과"
  },
  Task_10853_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10853_Name = {
    Text = "스테이지 클리어"
  },
  Task_10854_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10854_Name = {
    Text = "스테이지 클리어"
  },
  Task_10855_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10855_Name = {
    Text = "스테이지 클리어"
  },
  Task_10857_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10857_Name = {
    Text = "스테이지 클리어"
  },
  Task_10858_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10858_Name = {
    Text = "스테이지 클리어"
  },
  Task_10859_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10859_Name = {
    Text = "스테이지 클리어"
  },
  Task_10860_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10860_Name = {
    Text = "스테이지 클리어"
  },
  Task_10861_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10861_Name = {
    Text = "스테이지 클리어"
  },
  Task_10862_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10862_Name = {
    Text = "스테이지 클리어"
  },
  Task_10863_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10863_Name = {
    Text = "스테이지 클리어"
  },
  Task_10864_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10864_Name = {
    Text = "스테이지 클리어"
  },
  Task_10865_Desc = {
    Text = "깨어남 의식 누적 100회 수행하기"
  },
  Task_10865_Name = {Text = "뽑기"},
  Task_10866_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10866_Name = {
    Text = "스테이지 클리어"
  },
  Task_10867_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10867_Name = {
    Text = "스테이지 클리어"
  },
  Task_10868_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10868_Name = {
    Text = "스테이지 클리어"
  },
  Task_10869_Desc = {
    Text = "모든 전투를 합쳐 광기 폭발 사용 횟수 4회 이하로 클리어"
  },
  Task_10869_Name = {
    Text = "냉정하고 우아하게"
  },
  Task_10870_Desc = {
    Text = "깨어남체 스킬 100번 업그레이드"
  },
  Task_10870_Name = {
    Text = "기술 연마 Ⅳ"
  },
  Task_10871_Desc = {
    Text = "깨어남체 스킬 200번 업그레이드"
  },
  Task_10871_Name = {
    Text = "기술 연마Ⅴ"
  },
  Task_10872_Desc = {
    Text = "4명의 레벨 60 초원차원 깨어남체를 보유"
  },
  Task_10872_Name = {
    Text = "초월의 주인 Ⅵ"
  },
  Task_10873_Desc = {
    Text = "깨어남체 스킬 10 회 업그레이드"
  },
  Task_10873_Name = {
    Text = "기술 연마"
  },
  Task_10874_Desc = {
    Text = "깨어남체 스킬을 20회 업그레이드"
  },
  Task_10874_Name = {
    Text = "기술 연마 II"
  },
  Task_10875_Desc = {
    Text = "깨어남체 스킬 업그레이드 50회"
  },
  Task_10875_Name = {
    Text = "기술 연마 III"
  },
  Task_10876_Desc = {
    Text = "4명의 레벨 20 초원차원 깨어남체를 보유"
  },
  Task_10876_Name = {
    Text = "초월의 주인 II"
  },
  Task_10877_Desc = {
    Text = "4명의 레벨 30 초월 깨어남체를 소유하고 있습니다"
  },
  Task_10877_Name = {
    Text = "초월의 주인 III"
  },
  Task_10878_Desc = {
    Text = "4명의 레벨 40 초월 깨어남체를 보유"
  },
  Task_10878_Name = {
    Text = "초월의 주인 Ⅳ"
  },
  Task_10879_Desc = {
    Text = "4명의 레벨 50 초원차원 깨어남체를 소유하고 있습니다"
  },
  Task_10879_Name = {
    Text = "초월의 주인Ⅴ"
  },
  Task_10880_Desc = {
    Text = "메인 스토리 조사·2-11 어려움 클리어"
  },
  Task_10880_Name = {Text = "임무 3"},
  Task_10881_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10881_Name = {
    Text = "안전제일"
  },
  Task_10882_Desc = {
    Text = "35칸 이상 이동하지 않고 클리어"
  },
  Task_10882_Name = {
    Text = "전략적 행군"
  },
  Task_10883_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_10883_Name = {
    Text = "영역 숙련 Ⅱ"
  },
  Task_10884_Desc = {
    Text = "클리어 시 8장 이상의 각인된 카드를 보유한 상태로 클리어"
  },
  Task_10884_Name = {
    Text = "각인된 힘"
  },
  Task_10885_Desc = {
    Text = "혼돈 깨어남체를 2명 이상 포함한 상태로 클리어"
  },
  Task_10885_Name = {
    Text = "혼돈이야말로 성장"
  },
  Task_10886_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10886_Name = {
    Text = "안전제일"
  },
  Task_10887_Desc = {
    Text = "첫 전투에 승리하여, 아이들을 물리치고 자신의 것을 되찾는다."
  },
  Task_10887_Name = {
    Text = "첫 전투를 클리어한다"
  },
  Task_10888_Desc = {
    Text = "40칸 이상 이동하지 않고 클리어"
  },
  Task_10888_Name = {
    Text = "전략적 행군"
  },
  Task_10889_Desc = {
    Text = "6장 이하의 각인된 카드를 소지한 상태로 클리어"
  },
  Task_10889_Name = {
    Text = "각인 억제"
  },
  Task_10890_Desc = {
    Text = "10장 이상의 각인된 카드를 소지한 상태로 클리어"
  },
  Task_10890_Name = {
    Text = "각인된 힘"
  },
  Task_10892_Desc = {
    Text = "28칸 이상 이동하지 않고 클리어"
  },
  Task_10892_Name = {
    Text = "전략적 행군"
  },
  Task_10893_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10893_Name = {
    Text = "스테이지 클리어"
  },
  Task_10894_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10894_Name = {
    Text = "스테이지 클리어"
  },
  Task_10895_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10895_Name = {
    Text = "스테이지 클리어"
  },
  Task_10896_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10896_Name = {
    Text = "스테이지 클리어"
  },
  Task_10897_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10897_Name = {
    Text = "스테이지 클리어"
  },
  Task_10898_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10898_Name = {
    Text = "스테이지 클리어"
  },
  Task_10899_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10899_Name = {
    Text = "스테이지 클리어"
  },
  Task_10900_Desc = {
    Text = "클리어 시 남은 1%의 데스 리저스턴스당 1점, 최대 600점."
  },
  Task_10900_Name = {
    Text = "베테랑 <size=20><color=#747474>클리어 시 남은 죽음 저항 1%마다 1점 획득, 최대 600점</color></size>"
  },
  Task_10901_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10901_Name = {
    Text = "스테이지 클리어"
  },
  Task_10902_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10902_Name = {
    Text = "스테이지 클리어"
  },
  Task_10904_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10904_Name = {
    Text = "속전속결"
  },
  Task_10905_Desc = {
    Text = "지하의 밀랍인형과 전투"
  },
  Task_10905_Name = {Text = "목표"},
  Task_10906_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_10906_Name = {
    Text = "상쾌한 기분"
  },
  Task_10907_Desc = {
    Text = "전투 횟수 7회 이하로 클리어"
  },
  Task_10907_Name = {
    Text = "정밀 돌파"
  },
  Task_10908_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10908_Name = {
    Text = "완벽한 통과"
  },
  Task_10909_Desc = {
    Text = "수호자 조사 등급 15레벨 달성하기"
  },
  Task_10909_Name = {
    Text = "수호자 능력 고사 Ⅱ"
  },
  Task_10910_Desc = {
    Text = "조사 이벤트 「동구의 비밀」에서 공명 8번"
  },
  Task_10910_Name = {
    Text = "감사의 반향 Ⅲ"
  },
  Task_10911_Desc = {
    Text = "조사 이벤트 「동구 미스트」에서 공명 6번"
  },
  Task_10911_Name = {
    Text = "감사의 반향 Ⅱ"
  },
  Task_10912_Desc = {
    Text = "혈육 영역 깨어남체 1명 2단계로 승격"
  },
  Task_10912_Name = {
    Text = "혈육 숙련 Ⅱ"
  },
  Task_10913_Desc = {
    Text = "찍찍, 찍찍...!!"
  },
  Task_10913_Name = {Text = "찍찍"},
  Task_10914_Desc = {
    Text = "관장실타래로 향하기"
  },
  Task_10914_Name = {Text = "목표"},
  Task_10915_Desc = {
    Text = "12명의 깨어남체와 동조율이 레벨 5에 도달"
  },
  Task_10915_Name = {
    Text = "궁합 콤비 Ⅵ"
  },
  Task_10916_Desc = {
    Text = "이벤트「동구의 비밀」조사 완료"
  },
  Task_10916_Name = {
    Text = "황금 사탕 포장지"
  },
  Task_10917_Desc = {
    Text = "16명의 깨어남체와 동조율이 레벨 5에 도달"
  },
  Task_10917_Name = {
    Text = "궁합 콤비 Ⅷ"
  },
  Task_10918_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_10918_Desc2 = {
    Text = "조사 사건「사나운 개 조심」완료"
  },
  Task_10918_Name2 = {
    Text = "차원을 초월하는 눈"
  },
  Task_10919_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10919_Name = {
    Text = "스테이지 클리어"
  },
  Task_10920_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10920_Name = {
    Text = "스테이지 클리어"
  },
  Task_10921_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10921_Name = {
    Text = "스테이지 클리어"
  },
  Task_10922_Desc = {
    Text = "포나페의 폐허 200회 완료"
  },
  Task_10922_Name = {
    Text = "포나페의 축복Ⅲ"
  },
  Task_10923_Desc = {
    Text = "100회 포나페의 폐허 완료"
  },
  Task_10923_Name = {
    Text = "포나페의 축복Ⅱ"
  },
  Task_10924_Desc = {
    Text = "카오스 클러스터 400회 완료"
  },
  Task_10924_Name = {
    Text = "클러스터리스트 Ⅳ"
  },
  Task_10925_Desc = {
    Text = "카오스 클러스터 200회 완료"
  },
  Task_10925_Name = {
    Text = "클러스터리스트 Ⅲ"
  },
  Task_10926_Desc = {
    Text = "포나페의 폐허 50 회 완료"
  },
  Task_10926_Name = {
    Text = "포나페의 축복"
  },
  Task_10927_Desc = {
    Text = "카오스 클러스터 600회 완료"
  },
  Task_10927_Name = {
    Text = "클러스터리스트 Ⅴ"
  },
  Task_10928_Desc = {
    Text = "조사 240회 차원 잔상"
  },
  Task_10928_Name = {
    Text = "초월의 황무지 Ⅴ"
  },
  Task_10929_Desc = {
    Text = "조사 120회 차원 잔상"
  },
  Task_10929_Name = {
    Text = "초월의 황무지 Ⅳ"
  },
  Task_10931_Desc = {
    Text = "50회 카오스 클러스터 완료"
  },
  Task_10931_Name = {
    Text = "클러스터리스트"
  },
  Task_10932_Desc = {
    Text = "누적 소모 2500 검은 인장"
  },
  Task_10932_Name = {
    Text = "검은 소환 Ⅳ"
  },
  Task_10933_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10933_Name = {
    Text = "완벽한 통과"
  },
  Task_10934_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10934_Desc = {
    Text = "모든 생명은 결국 바다로 회귀한다. \n영원히 멈추지 않는 시간의 흐름처럼, 그것은 종료의 시작이다."
  },
  Task_10934_Name = {
    Text = "연구 임무: 청색 시편"
  },
  Task_10934_UnlockCondDesc = {
    Text = "수호자 레벨 25에 해금"
  },
  Task_10935_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10935_Name = {
    Text = "완벽한 통과"
  },
  Task_10936_Desc = {
    Text = "매 경기 60점"
  },
  Task_10936_Name = {
    Text = "엘리트 격파 <size=20><color=#747474>각 60점</color></size>"
  },
  Task_10938_Desc = {
    Text = "18개의 12레벨 미스터리를 소유"
  },
  Task_10938_Name = {
    Text = "미스터리 컬렉터 Ⅲ"
  },
  Task_10941_Desc = {
    Text = "클리어 시 임의의 깨어남체 카드가 1장 이하일 경우 100점을 획득합니다"
  },
  Task_10941_Name = {
    Text = "잊혀진 자 <size=20><color=#747474>클리어 시 깨어남체 1명의 카드가 1장 이하</color></size>"
  },
  Task_10944_Desc = {
    Text = "4명의 레벨 20 깨어남체를 소유"
  },
  Task_10944_Name = {
    Text = "깊은 바다의 주인 II"
  },
  Task_10946_Desc = {
    Text = "깨어남체 4명 50레벨 달성"
  },
  Task_10946_Name = {Text = "임무 2"},
  Task_10947_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10947_Name = {
    Text = "목표 1: 복사 대기"
  },
  Task_10948_Desc = {
    Text = "정신병원 조사"
  },
  Task_10948_Name = {Text = "목표"},
  Task_10949_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_10949_Name = {
    Text = "상쾌한 기분"
  },
  Task_10951_Desc = {
    Text = "클리어 시 남은 생명 1%당 1점 획득, 최대 100점"
  },
  Task_10951_Name = {
    Text = "잔여 생명  <size=20><color=#747474>클리어 시 남은 1% 생명당 1 점, 최대 100점</color></size>"
  },
  Task_10953_Desc = {
    Text = "조사 메인 스토리 제2장 「밀랍인형의 이름으로」 어려움 난이도 완료"
  },
  Task_10954_Desc = {
    Text = "화가 난 아이들을 「위로」하기"
  },
  Task_10954_Name = {Text = "목표"},
  Task_10955_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10955_Name = {
    Text = "속전속결"
  },
  Task_10956_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10956_Name = {
    Text = "속전속결"
  },
  Task_10957_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_10957_Name = {
    Text = "속전속결"
  },
  Task_10958_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10958_Name = {
    Text = "스테이지 클리어"
  },
  Task_10959_Desc = {
    Text = "클리어 무광의 경계 Ⅲ (미완성)"
  },
  Task_10962_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10962_Name = {
    Text = "스테이지 클리어"
  },
  Task_10963_Desc = {
    Text = "35칸 이상 이동하지 않고 클리어"
  },
  Task_10963_Name = {
    Text = "전략적 행군"
  },
  Task_10964_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10964_Name = {
    Text = "목표 힌트 최대 8자"
  },
  Task_10965_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_10965_Name = {
    Text = "속전속결"
  },
  Task_10966_Desc = {
    Text = "40칸 이상 이동하지 않고 클리어"
  },
  Task_10966_Name = {
    Text = "전략적 행군"
  },
  Task_10969_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10969_Name = {
    Text = "안전제일"
  },
  Task_10970_Desc = {
    Text = "심해 영역 깨어남체 1명 4단계로 승격"
  },
  Task_10970_Name = {
    Text = "심해 숙련 IV"
  },
  Task_10971_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_10971_Name = {
    Text = "속전속결"
  },
  Task_10972_Desc = {
    Text = "혈육 영역 깨어남체 1명 4단계로 승격"
  },
  Task_10972_Name = {
    Text = "혈육 숙련 IV"
  },
  Task_10973_Desc = {
    Text = "전투 횟수 7회 이하로 클리어"
  },
  Task_10973_Name = {
    Text = "정밀 돌파"
  },
  Task_10974_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10974_Name = {
    Text = "완벽한 통과"
  },
  Task_10975_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_10975_Desc = {
    Text = "「그것은 당신의 마음을 기록할 것입니다.」 \n 「정말이야? 그럼 그것은 반드시 흉터투성이일 거야.」"
  },
  Task_10975_Name = {
    Text = "조사 임무: 영상 치료"
  },
  Task_10975_UnlockCondDesc = {
    Text = "조사 이벤트 1-13 오픈"
  },
  Task_10976_Desc = {
    Text = "메인 스토리 조사·4-12 어려움 클리어"
  },
  Task_10976_Name = {Text = "임무 3"},
  Task_10977_Desc = {
    Text = "총 26턴 내 클리어"
  },
  Task_10977_Name = {
    Text = "총 26턴 내 클리어"
  },
  Task_10981_Desc = {
    Text = "최종전 5턴 내 승리"
  },
  Task_10981_Name = {
    Text = "최종전 5턴 내 승리"
  },
  Task_10982_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10982_Name = {
    Text = "완벽한 통과"
  },
  Task_10983_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10983_Name = {
    Text = "완벽한 통과"
  },
  Task_10984_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10984_Name = {
    Text = "완벽한 통과"
  },
  Task_10985_Desc = {
    Text = "60회 기질 잔상 조사"
  },
  Task_10985_Name = {
    Text = "혈육의 폐허 Ⅲ"
  },
  Task_10986_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10986_Name = {
    Text = "완벽한 통과"
  },
  Task_10987_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_10987_Name = {
    Text = "완벽한 통과"
  },
  Task_10988_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10988_Name = {
    Text = "스테이지 클리어"
  },
  Task_10989_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10989_Name = {
    Text = "스테이지 클리어"
  },
  Task_10991_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10991_Name = {
    Text = "스테이지 클리어"
  },
  Task_10992_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10992_Name = {
    Text = "스테이지 클리어"
  },
  Task_10993_Desc = {
    Text = "어둠 속에 숨은 것에 경계하기"
  },
  Task_10993_Name = {Text = "목표"},
  Task_10994_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10994_Name = {
    Text = "스테이지 클리어"
  },
  Task_10995_Desc = {
    Text = "스테이지 클리어"
  },
  Task_10995_Name = {
    Text = "스테이지 클리어"
  },
  Task_10997_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_10997_Name = {
    Text = "안전제일"
  },
  Task_10998_Desc = {
    Text = "전투 횟수 7회 이하로 클리어"
  },
  Task_10998_Name = {
    Text = "정밀 돌파"
  },
  Task_10999_Desc = {
    Text = "최종전에서 7턴 이내에 승리"
  },
  Task_10999_Name = {
    Text = "속전속결"
  },
  Task_11003_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_11003_Name = {
    Text = "상쾌한 기분"
  },
  Task_11004_Desc = {
    Text = "로탄을 도와 적을 몰아넣기"
  },
  Task_11004_Name = {Text = "목표"},
  Task_11005_Desc = {
    Text = "조사 120회 해연잔상"
  },
  Task_11005_Name = {
    Text = "깊은 바다의 폐허 Ⅳ"
  },
  Task_11006_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11006_Name = {
    Text = "완벽한 통과"
  },
  Task_11007_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_11007_Desc2 = {
    Text = "사건 조사「무성한 곳에서」완료"
  },
  Task_11007_Name2 = {
    Text = "엄마, 저는 아프지 않아요"
  },
  Task_11008_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11008_Name = {
    Text = "완벽한 통과"
  },
  Task_11009_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11009_Name = {
    Text = "스테이지 클리어"
  },
  Task_11010_Desc = {
    Text = "누적 소모 5000 검은 인장"
  },
  Task_11010_Name = {
    Text = "검은 소환Ⅴ"
  },
  Task_11011_Desc = {
    Text = "클리어 시 남은 체력 비율이 80% 이상"
  },
  Task_11011_Name = {
    Text = "식은죽 먹기"
  },
  Task_11012_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_11012_Name = {
    Text = "속전속결"
  },
  Task_11013_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11013_Name = {
    Text = "완벽한 통과"
  },
  Task_11014_Desc = {
    Text = "비밀 계약 강화 3회"
  },
  Task_11014_Name = {
    Text = "시간 테스트2 (미사용)"
  },
  Task_11015_Desc = {
    Text = "깨어남체 레벨 강화 3회"
  },
  Task_11015_Name = {
    Text = "시간 테스트1 (비활성화됨)"
  },
  Task_11016_Desc = {
    Text = "특정 전투 X(엘리트)에서 중독(Y) 층수가 20 이상인 경우"
  },
  Task_11016_Name = {Text = "중독량"},
  Task_11017_Desc = {
    Text = "최종전에서 1턴 동안 1500 이상의 방어막을 획득"
  },
  Task_11017_Name = {
    Text = "과잉 방어"
  },
  Task_11018_Desc = {
    Text = "소모 500 검은 인장 누적"
  },
  Task_11018_Name = {
    Text = "검은 소환Ⅱ"
  },
  Task_11019_Desc = {
    Text = "4명의 레벨 30 깊은 바다 깨어남체를 보유 중입니다"
  },
  Task_11019_Name = {
    Text = "깊은 바다의 주인 III"
  },
  Task_11020_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11020_Name = {
    Text = "스테이지 클리어"
  },
  Task_11021_Desc = {
    Text = "4명의 레벨 50 깊은 바다 깨어남체를 소유하고 있습니다."
  },
  Task_11021_Name = {
    Text = "깊은 바다의 주인Ⅴ"
  },
  Task_11022_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11022_Name = {
    Text = "스테이지 클리어"
  },
  Task_11023_Desc = {
    Text = "4명의 레벨 50 혈육 깨어남체를 가지고 있다"
  },
  Task_11023_Name = {
    Text = "혈육의 주인Ⅴ"
  },
  Task_11024_Desc = {
    Text = "누적 소모 250 검은 인장"
  },
  Task_11024_Name = {
    Text = "검은 소환"
  },
  Task_11025_Desc = {
    Text = "4명의 10레벨 깊은 바다 깨어남체를 보유하고 있습니다"
  },
  Task_11025_Name = {
    Text = "심해의 주인"
  },
  Task_11026_Desc = {
    Text = "4명의 레벨 60 혈육 깨어남체를 보유하고 있습니다"
  },
  Task_11026_Name = {
    Text = "혈육의 주인 Ⅵ"
  },
  Task_11027_Desc = {
    Text = "특정 유형의 전투 X에서 한 턴에 카드 수량이 20 이상"
  },
  Task_11027_Name = {
    Text = "카드 마스터"
  },
  Task_11029_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 10회"
  },
  Task_11029_Desc2 = {
    Text = "조사 사건 「무성한 곳에서」에서 공명 10회"
  },
  Task_11029_Name2 = {
    Text = "고통의 울림 Ⅳ"
  },
  Task_11030_Desc = {
    Text = "클리어 시 8장 이상의 각인된 카드를 보유한 상태로 클리어"
  },
  Task_11030_Name = {
    Text = "각인된 힘"
  },
  Task_11031_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11031_Name = {
    Text = "스테이지 클리어"
  },
  Task_11032_Desc = {
    Text = "특정 전투 X에서 한 턴에 추가로 뽑는 카드 수가 5 이상"
  },
  Task_11032_Name = {
    Text = "명수우득"
  },
  Task_11033_Desc = {
    Text = "조사 이벤트 「로상의 이름으로」 어려움 난이도 완료"
  },
  Task_11033_Name = {
    Text = "왁스 속의 수수께끼·어려움"
  },
  Task_11034_Desc = {
    Text = "다프다일 밀어내기"
  },
  Task_11034_Name = {Text = "목표"},
  Task_11035_Desc = {
    Text = "특정 전투 X에서, 쌓인 방어막이 200 이상인 경우 (X 엘리트 전투)"
  },
  Task_11035_Name = {
    Text = "불타파할 수 없음"
  },
  Task_11036_Desc = {
    Text = "이벤트 「동구의 비밀」 어려움 조사 완료"
  },
  Task_11036_Name = {
    Text = "동구 미스트·어려움"
  },
  Task_11038_Desc = {
    Text = "클리어 시 죽음 저항 횟수가 1회 이하일 때"
  },
  Task_11038_Name = {
    Text = "무여가부사"
  },
  Task_11041_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_11041_Name = {
    Text = "속전속결"
  },
  Task_11042_Desc = {
    Text = "셀레스트 찾기"
  },
  Task_11042_Name = {Text = "목표"},
  Task_11043_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11043_Name = {
    Text = "완벽한 통과"
  },
  Task_11044_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11044_Name = {
    Text = "완벽한 통과"
  },
  Task_11045_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11045_Name = {
    Text = "완벽한 통과"
  },
  Task_11046_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11046_Name = {
    Text = "완벽한 통과"
  },
  Task_11047_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11047_Name = {
    Text = "완벽한 통과"
  },
  Task_11048_Desc = {
    Text = "100번의 금지된 기록 달성"
  },
  Task_11048_Name = {
    Text = "미스터리 문양 조각사 Ⅱ"
  },
  Task_11050_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11050_Name = {
    Text = "스테이지 클리어"
  },
  Task_11052_Desc = {
    Text = "기질 잔상 240번 조사"
  },
  Task_11052_Name = {
    Text = "혈육의 폐허Ⅴ"
  },
  Task_11053_Desc = {
    Text = "최종전 18턴 내 승리"
  },
  Task_11053_Name = {
    Text = "최종전 18턴 내 승리"
  },
  Task_11054_Desc = {
    Text = "하리엇의 오두막 방문"
  },
  Task_11054_Name = {Text = "목표"},
  Task_11057_Desc = {
    Text = "40칸 이상 이동하지 않고 클리어"
  },
  Task_11057_Name = {
    Text = "전략적 행군"
  },
  Task_11058_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_11058_Name = {
    Text = "상쾌한 기분"
  },
  Task_11059_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_11059_Name = {
    Text = "속전속결"
  },
  Task_11060_Desc = {
    Text = "100회 카오스 클러스터 완료"
  },
  Task_11060_Name = {
    Text = "클러스터리스트 Ⅱ"
  },
  Task_11061_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_11061_Name = {
    Text = "속전속결"
  },
  Task_11062_Desc = {
    Text = "머피를 쫓기"
  },
  Task_11062_Name = {Text = "목표"},
  Task_11063_Desc = {
    Text = "소리의 출처를 찾다"
  },
  Task_11063_Name = {Text = "목표"},
  Task_11064_Desc = {Text = "고마워"},
  Task_11064_Name = {Text = "고마워,"},
  Task_11065_Desc = {
    Text = "하리엇을 물리치다"
  },
  Task_11065_Name = {Text = "목표"},
  Task_11066_Desc = {
    Text = "나를 잊지 말아줘."
  },
  Task_11066_Name = {
    Text = "나를 잊지 말아줘."
  },
  Task_11067_Desc = {
    Text = "모두들 고마워..."
  },
  Task_11067_Name = {
    Text = "모두들 고마워…"
  },
  Task_11068_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_11068_Name = {
    Text = "속전속결"
  },
  Task_11069_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11069_Name = {
    Text = "완벽한 통과"
  },
  Task_11070_Desc = {
    Text = "총 턴 16턴 내 클리어"
  },
  Task_11070_Name = {
    Text = "총 턴 16턴 내 클리어"
  },
  Task_11071_Desc = {
    Text = "총 21턴 내에 클리어"
  },
  Task_11071_Name = {
    Text = "총 21턴 내에 클리어"
  },
  Task_11072_Desc = {
    Text = "총 11턴 내에 클리어"
  },
  Task_11072_Name = {
    Text = "총 11턴 내에 클리어"
  },
  Task_11073_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11073_Name = {
    Text = "스테이지 클리어"
  },
  Task_11074_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11074_Name = {
    Text = "스테이지 클리어"
  },
  Task_11075_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11075_Name = {
    Text = "스테이지 클리어"
  },
  Task_11076_Desc = {
    Text = "총 31턴 내에 클리어"
  },
  Task_11076_Name = {
    Text = "총 31턴 내에 클리어"
  },
  Task_11077_Desc = {
    Text = "4명의 레벨 50 카오스 깨어남체 소유"
  },
  Task_11077_Name = {
    Text = "카오스의 주인Ⅴ"
  },
  Task_11078_Desc = {
    Text = "4명의 40레벨 카오스 깨어남체 소유"
  },
  Task_11078_Name = {
    Text = "카오스의 주인 Ⅳ"
  },
  Task_11079_Desc = {
    Text = "4명의 레벨 10 혈육 깨어남체를 보유"
  },
  Task_11079_Name = {
    Text = "혈육의 주인"
  },
  Task_11080_Desc = {
    Text = "4명의 60레벨 카오스 깨어남체를 보유"
  },
  Task_11080_Name = {
    Text = "카오스의 주인 Ⅵ"
  },
  Task_11081_Desc = {
    Text = "4명의 10레벨 카오스 깨어남체를 소유"
  },
  Task_11081_Name = {
    Text = "카오스의 주인"
  },
  Task_11082_Desc = {
    Text = "4명의 30레벨 카오스 깨어남체를 소유"
  },
  Task_11082_Name = {
    Text = "카오스의 주인 III"
  },
  Task_11083_Desc = {
    Text = "4명의 20레벨 카오스 깨어남체를 보유 중입니다"
  },
  Task_11083_Name = {
    Text = "카오스의 주인 II"
  },
  Task_11084_Desc = {
    Text = "한 번의 전투에서 4번의 데스 리저스턴스를 발동하고 승리했습니다"
  },
  Task_11084_Name = {
    Text = "불사불휴"
  },
  Task_11085_Desc = {
    Text = "한 턴 내에 촉수 공격으로 적을 15번 공격하고, 이 게임에서 승리"
  },
  Task_11085_Name = {
    Text = "나선 군주"
  },
  Task_11086_Desc = {
    Text = "초원차원 턴에서 5번 점프하고 승리한다。"
  },
  Task_11086_Name = {
    Text = "차원 이동자"
  },
  Task_11087_Desc = {
    Text = "한 턴에 5개의 배아를 흡수하고 승리합니다."
  },
  Task_11087_Name = {
    Text = "배고프다"
  },
  Task_11088_Desc = {
    Text = "한 턴에 15장의 카드를 내고 승리"
  },
  Task_11088_Name = {
    Text = "내 차례야!이야"
  },
  Task_11089_Desc = {
    Text = "한 턴에 6장의 증상 카드를 내고 승리."
  },
  Task_11089_Name = {
    Text = "중증 환자"
  },
  Task_11090_Desc = {
    Text = "한 턴에 10장의 타격 카드를 내어 승리"
  },
  Task_11090_Name = {
    Text = "무한한 타격"
  },
  Task_11091_Desc = {
    Text = "전투 승리 시 손패, 쓰레기 더미, 드로우 덱의 총합이 8장 이하인 경우"
  },
  Task_11091_Name = {
    Text = "주머니가 비어있음"
  },
  Task_11092_Desc = {
    Text = "「24」 추격"
  },
  Task_11092_Name = {Text = "목표"},
  Task_11094_Desc = {
    Text = "조사 완료 이벤트 「조심하십시오, 사나운 개가 있습니다」 어려움"
  },
  Task_11094_Name = {
    Text = "차원을 초월하는 눈·어려움"
  },
  Task_11095_Desc = {
    Text = "소모 500000장미 금권"
  },
  Task_11095_Name = {
    Text = "돈을 물처럼 쓰다"
  },
  Task_11096_Desc = {
    Text = "1000000 장미 금권 소모"
  },
  Task_11096_Name = {
    Text = "금을 흙처럼 쓰다Ⅱ"
  },
  Task_11097_Desc = {
    Text = "리더와의 전투에서 승리하여 1200점을 획득했습니다"
  },
  Task_11097_Name = {
    Text = "보스 처치 <size=20><color=#747474>보스 전투 승리 시 1200점 획득</color></size>"
  },
  Task_11098_Desc = {
    Text = "최종전 9턴 내 승리"
  },
  Task_11098_Name = {
    Text = "최종전 9턴 내 승리"
  },
  Task_11099_Desc = {
    Text = "주인 곁으로 돌아가기"
  },
  Task_11099_Name = {Text = "목표"},
  Task_11100_Desc = {
    Text = "소리의 출처 밝히기"
  },
  Task_11100_Name = {Text = "목표"},
  Task_11101_Desc = {
    Text = "최종전에서 8턴 이내에 승리"
  },
  Task_11101_Name = {
    Text = "속전속결"
  },
  Task_11102_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11102_Name = {
    Text = "완벽한 통과"
  },
  Task_11103_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11103_Name = {
    Text = "완벽한 통과"
  },
  Task_11104_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_11104_Name = {
    Text = "속전속결"
  },
  Task_11105_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11105_Name = {
    Text = "스테이지 클리어"
  },
  Task_11106_Desc = {
    Text = "4명의 레벨 30 혈육 깨어남체를 보유"
  },
  Task_11106_Name = {
    Text = "혈육의 주인 III"
  },
  Task_11107_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11107_Name = {
    Text = "완벽한 통과"
  },
  Task_11108_Desc = {
    Text = "밀랍인형 《봄》 찾기"
  },
  Task_11108_Name = {Text = "목표"},
  Task_11109_Desc = {
    Text = "갑판을 지나가기"
  },
  Task_11109_Name = {Text = "목표"},
  Task_11111_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11111_Name = {
    Text = "스테이지 클리어"
  },
  Task_11112_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_11112_Name = {
    Text = "속전속결"
  },
  Task_11113_Desc = {
    Text = "해골 사냥꾼을 따라잡아"
  },
  Task_11113_Name = {Text = "목표"},
  Task_11114_Desc = {
    Text = "최종전 8턴 내 승리"
  },
  Task_11114_Name = {
    Text = "최종전 8턴 내 승리"
  },
  Task_11115_Desc = {
    Text = "총 58턴 내 클리어"
  },
  Task_11115_Name = {
    Text = "총 58턴 내 클리어"
  },
  Task_11116_Desc = {
    Text = "일일 퀘스트 완료"
  },
  Task_11116_Name = {
    Text = "일일 도전"
  },
  Task_11117_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11117_Name = {
    Text = "완벽한 통과"
  },
  Task_11118_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11118_Name = {
    Text = "스테이지 클리어"
  },
  Task_11119_Desc = {
    Text = "융식체 처치"
  },
  Task_11119_Name = {Text = "목표"},
  Task_11120_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11120_Name = {
    Text = "스테이지 클리어"
  },
  Task_11121_Desc = {
    Text = "구명보트 탑승"
  },
  Task_11121_Name = {Text = "목표"},
  Task_11122_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_11122_Name = {
    Text = "속전속결"
  },
  Task_11123_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_11123_Name = {
    Text = "속전속결"
  },
  Task_11124_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11124_Name = {
    Text = "스테이지 클리어"
  },
  Task_11125_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_11125_Name = {
    Text = "영역 숙련 Ⅳ"
  },
  Task_11126_Desc = {
    Text = "약재 연마 200회 완료"
  },
  Task_11126_Name = {
    Text = "천재 약사 Ⅲ"
  },
  Task_11128_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11128_Name = {
    Text = "한 번의 기회 <size=20><color=#747474>응급 영지체를 사용하지 않고 클리어</color></size>"
  },
  Task_11129_Desc = {
    Text = "데스크로 돌아가 판디아 찾기"
  },
  Task_11129_Name = {Text = "목표"},
  Task_11130_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11130_Name = {
    Text = "완벽한 통과"
  },
  Task_11135_Desc = {
    Text = "미리암에게서 도망치기"
  },
  Task_11135_Name = {Text = "목표"},
  Task_11136_Desc = {
    Text = "깨어남체 스킬 강화 누적 6회 달성"
  },
  Task_11136_Name = {Text = "임무 4"},
  Task_11137_Desc = {
    Text = "초월적 존재 1회 클리어"
  },
  Task_11137_Name = {Text = "임무 5"},
  Task_11138_Desc = {
    Text = "연금실타래에서 소재 합성 1회 완료"
  },
  Task_11138_Name = {Text = "임무 1"},
  Task_11139_Desc = {
    Text = "깨어남체 4명 30레벨 달성"
  },
  Task_11139_Name = {Text = "임무 2"},
  Task_11140_Desc = {
    Text = "혼돈의 영역 Ⅳ 클리어"
  },
  Task_11140_Name = {Text = "임무 3"},
  Task_11141_Desc = {
    Text = "총 39턴 내 클리어"
  },
  Task_11141_Name = {
    Text = "총 39턴 내 클리어"
  },
  Task_11142_Desc = {
    Text = "총 33턴 내 클리어"
  },
  Task_11142_Name = {
    Text = "총 33턴 내 클리어"
  },
  Task_11143_Desc = {
    Text = "총 54턴 내 클리어"
  },
  Task_11143_Name = {
    Text = "총 54턴 내 클리어"
  },
  Task_11144_Desc = {
    Text = "총 48턴 내 클리어"
  },
  Task_11144_Name = {
    Text = "총 48턴 내 클리어"
  },
  Task_11145_Desc = {
    Text = "총 14턴 내에 클리어"
  },
  Task_11145_Name = {
    Text = "총 14턴 내에 클리어"
  },
  Task_11146_Desc = {
    Text = "50칸 이상 이동하지 않고 클리어"
  },
  Task_11146_Name = {
    Text = "전략적 행군"
  },
  Task_11147_Desc = {
    Text = "총 26턴 내 클리어"
  },
  Task_11147_Name = {
    Text = "총 26턴 내 클리어"
  },
  Task_11148_Desc = {
    Text = "총 20턴 내 클리어"
  },
  Task_11148_Name = {
    Text = "총 20턴 내 클리어"
  },
  Task_11149_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11149_Name = {
    Text = "스테이지 클리어"
  },
  Task_11150_Desc = {
    Text = "총 66턴 내 클리어"
  },
  Task_11150_Name = {
    Text = "총 66턴 내 클리어"
  },
  Task_11151_Desc = {
    Text = "60턴 내에 클리어"
  },
  Task_11151_Name = {
    Text = "60턴 내에 클리어"
  },
  Task_11152_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_11152_Name = {Text = "제6단계"},
  Task_11153_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_11153_Name = {
    Text = "영역 숙련 Ⅰ"
  },
  Task_11154_Desc = {
    Text = "스테이지 클리어"
  },
  Task_11154_Name = {
    Text = "스테이지 클리어"
  },
  Task_11155_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_11155_Name = {
    Text = "상쾌한 기분"
  },
  Task_11156_Desc = {
    Text = "조사 메인 스토리 제1장 「동부 지구의 비밀」 완료"
  },
  Task_11157_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_11157_Name = {
    Text = "완벽한 통과"
  },
  Task_116471_Desc = {
    Text = "심해 영역 깨어남체를 사용하여「융합의 고통」에서 2회의 승리를 얻습니다"
  },
  Task_116472_Desc = {
    Text = "통과「바람의 지지」임의 난이도"
  },
  Task_116473_Desc = {
    Text = "융합된 고통의 피·통과"
  },
  Task_116474_Desc = {
    Text = "'쌍생 날개'를 광란 난이도로 클리어"
  },
  Task_116475_Desc = {
    Text = "'모험 동화'를 임의 난이도로 클리어"
  },
  Task_116476_Desc = {
    Text = "통과 이몽 시야「하늘 저편·하」"
  },
  Task_116477_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여「융합의 고통」에서 1회의 승리를 얻습니다"
  },
  Task_116478_Desc = {
    Text = "'망각의 독'을 임의 난이도로 클리어"
  },
  Task_116479_Desc = {
    Text = "'순진한 시절'을 임의 난이도로 클리어"
  },
  Task_116480_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여「융합의 고통」에서 2회의 승리를 얻습니다"
  },
  Task_116481_Desc = {
    Text = "「융합의 쓴 피·통과」 모든 업적을 완료하다"
  },
  Task_116482_Desc = {
    Text = "'순진한 시절'을 광란 난이도로 클리어"
  },
  Task_116483_Desc = {
    Text = "'침묵의 깨어남'을 임의 난이도로 클리어"
  },
  Task_116484_Desc = {
    Text = "「옛날 장부」 아무 난이도 통과"
  },
  Task_116485_Desc = {
    Text = "「옛날 장부」 아무 난이도 통과"
  },
  Task_116486_Desc = {
    Text = "융합된 고통의 피·광란"
  },
  Task_116487_Desc = {
    Text = "심해 영역 깨어남체를 사용하여「융합의 고통」에서 1회의 승리를 얻습니다"
  },
  Task_116488_Desc = {
    Text = "융합된 고통의 피·영역"
  },
  Task_116489_Desc = {
    Text = "'쌍생 날개'를 임의 난이도로 클리어"
  },
  Task_116490_Desc = {
    Text = "'망각의 독'을 임의 난이도로 클리어"
  },
  Task_116491_Desc = {
    Text = "'모험 동화'를 광란 난이도로 클리어"
  },
  Task_116492_Desc = {
    Text = "「옛날 장부」 광란 난이도 통과"
  },
  Task_116493_Desc = {
    Text = "통과「바람의 지지」임의 난이도"
  },
  Task_116494_Desc = {
    Text = "'침묵의 깨어남'을 광란 난이도로 클리어"
  },
  Task_116495_Desc = {
    Text = "'모험 동화'를 임의 난이도로 클리어"
  },
  Task_116496_Desc = {
    Text = "'순진한 시절'을 임의 난이도로 클리어"
  },
  Task_116497_Desc = {
    Text = "통과「망각의 독」광란 난이도"
  },
  Task_116498_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여「융합의 고통」에서 2회의 승리를 얻습니다"
  },
  Task_116499_Desc = {
    Text = "통과「바람의 지지」광란 난이도"
  },
  Task_116500_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여「융합의 고통」에서 1회의 승리를 얻습니다"
  },
  Task_116501_Desc = {
    Text = "'쌍생 날개'를 임의 난이도로 클리어"
  },
  Task_116502_Desc = {
    Text = "'침묵의 깨어남'을 임의 난이도로 클리어"
  },
  Task_116503_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여「융합의 고통」에서 2회의 승리를 얻습니다"
  },
  Task_116504_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여「융합의 고통」에서 1회의 승리를 얻습니다"
  },
  Task_116767_Desc = {
    Text = "폴룩스 체험 스테이지 1회 클리어"
  },
  Task_116768_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_116769_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_116770_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_116771_Desc = {
    Text = "파견 20회 완료"
  },
  Task_116772_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_116773_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_116774_Desc = {
    Text = "파견 20회 완료"
  },
  Task_116775_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_116776_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_116777_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_116778_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_116779_Desc = {
    Text = "깨어남 30회"
  },
  Task_116780_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_116781_Desc = {
    Text = "깨어남 30회"
  },
  Task_116782_Desc = {
    Text = "폴룩스 체험 스테이지 1회 클리어"
  },
  Task_116793_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_116793_Name = {Text = "3승"},
  Task_116794_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_116794_Name = {Text = "1승"},
  Task_116795_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_116795_Name = {Text = "6승"},
  Task_116796_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_116796_Name = {Text = "10승"},
  Task_116809_Desc = {
    Text = "이몽 시야「안녕, 영원한 고향」 완료하다"
  },
  Task_116809_Name = {
    Text = "아름다운 꿈의 여운"
  },
  Task_116810_Desc = {
    Text = "이몽 시야「안녕, 영원한 고향」 어려움 난이도 완료하다"
  },
  Task_116810_Name = {
    Text = "아름다운 꿈의 여운·어려움"
  },
  Task_116820_Name = {
    Text = "보스 3N회 격파"
  },
  Task_116821_Name = {
    Text = "보스 6N회 격파"
  },
  Task_116822_Name = {
    Text = "모든 보스 격파"
  },
  Task_116823_Name = {
    Text = "보스 5N회 격파"
  },
  Task_116824_Name = {
    Text = "보스 1N회 격파"
  },
  Task_116825_Name = {
    Text = "보스 4N회 격파"
  },
  Task_116826_Name = {
    Text = "보스 7N회 격파"
  },
  Task_116827_Name = {
    Text = "보스 2N회 격파"
  },
  Task_116884_Desc = {
    Text = "누적 로그인 11일"
  },
  Task_116885_Desc = {
    Text = "누적 로그인 13일"
  },
  Task_116886_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_116887_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_116888_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_116890_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_116891_Desc = {
    Text = "누적 로그인 16일"
  },
  Task_116892_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_116894_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_116895_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_116896_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_116897_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_116899_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_116900_Desc = {
    Text = "누적 로그인 14일"
  },
  Task_116901_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_116903_Desc = {
    Text = "누적 로그인 12일"
  },
  Task_117156_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「호수 속의 도시」에서 1회 승리"
  },
  Task_117157_Desc = {
    Text = "Use the Awakening Body of the Blood Flesh Boundary Realm to win once in 「The City in the Lake」."
  },
  Task_117158_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「호수 속의 도시」에서 1 회 승리"
  },
  Task_117159_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해 「호수 속의 도시」에서 1회 승리"
  },
  Task_117304_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_117304_Name = {Text = "1승"},
  Task_117305_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_117305_Name = {Text = "6승"},
  Task_117306_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_117306_Name = {Text = "3승"},
  Task_117307_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_117307_Name = {Text = "10승"},
  Task_117487_Desc = {
    Text = "완료 이몽 시야「안녕 영원의 고향」어려움 난이도"
  },
  Task_117487_Name = {
    Text = "결코 포기하지 않는다 ·어려움"
  },
  Task_117488_Desc = {
    Text = "완료 이몽 시야「안녕 영원의 고향」"
  },
  Task_117488_Name = {
    Text = "결코 포기하지 않는다"
  },
  Task_117489_Desc = {
    Text = "완료 이몽 시야「천변 저편·하」"
  },
  Task_117489_Name = {
    Text = "푸른 하늘 위"
  },
  Task_118481_Desc = {
    Text = "머피 데려가기"
  },
  Task_118481_Name = {Text = "목표"},
  Task_118482_Desc = {
    Text = "의식 현장에 침입하여 머피 구출"
  },
  Task_118482_Name = {Text = "목표"},
  Task_118483_Desc = {
    Text = "「낙원」에 다시 들어가기"
  },
  Task_118483_Name = {Text = "목표"},
  Task_118484_Desc = {
    Text = "꿈의 장막을 벗기기"
  },
  Task_118484_Name = {Text = "목표"},
  Task_118485_Desc = {
    Text = "인항 의식 관찰"
  },
  Task_118485_Name = {Text = "목표"},
  Task_118486_Desc = {
    Text = "날아오는 물고기 요격"
  },
  Task_118486_Name = {Text = "목표"},
  Task_118487_Desc = {
    Text = "도해자의 추적 뿌리치기"
  },
  Task_118487_Name = {Text = "목표"},
  Task_118488_Desc = {
    Text = "길의 끝에 도달하기"
  },
  Task_118488_Name = {Text = "목표"},
  Task_118489_Desc = {
    Text = "「자아」를 소멸시키기"
  },
  Task_118489_Name = {Text = "목표"},
  Task_118490_Desc = {
    Text = "혼란 속에서 머피 구출하기"
  },
  Task_118490_Name = {Text = "목표"},
  Task_118787_Desc = {
    Text = "성태의 노래"
  },
  Task_118791_Desc = {
    Text = "검은 사슬"
  },
  Task_118796_Desc = {
    Text = "사해유존"
  },
  Task_118799_Desc = {
    Text = "다크시의 배"
  },
  Task_118809_Desc = {
    Text = "황사의 벽"
  },
  Task_118821_Desc = {
    Text = "밀랍상의 비밀"
  },
  Task_118826_Desc = {
    Text = "혼탁한 잔상"
  },
  Task_118835_Desc = {
    Text = "해연잔상"
  },
  Task_118837_Desc = {
    Text = "광기의 촛대관"
  },
  Task_118842_Desc = {
    Text = "금권 수사"
  },
  Task_118845_Desc = {
    Text = "폭풍 바깥바다"
  },
  Task_118852_Desc = {
    Text = "기질 잔상"
  },
  Task_118856_Desc = {
    Text = "혼돈의 이방진"
  },
  Task_118860_Desc = {
    Text = "인형의 눈물"
  },
  Task_118871_Desc = {
    Text = "스워시 코르도"
  },
  Task_118873_Desc = {
    Text = "벌레의 소굴"
  },
  Task_118877_Desc = {
    Text = "약재 연마"
  },
  Task_118879_Desc = {
    Text = "카오스 클러스터"
  },
  Task_118881_Desc = {
    Text = "원초 균열"
  },
  Task_118892_Desc = {
    Text = "신앙의 손아귀"
  },
  Task_118907_Desc = {
    Text = "포나페의 폐허"
  },
  Task_118913_Desc = {
    Text = "계외의 그림자"
  },
  Task_118915_Desc = {
    Text = "블랙풀의 파도"
  },
  Task_118917_Desc = {
    Text = "차원 잔상"
  },
  Task_118918_Desc = {
    Text = "실타래레인 산맥"
  },
  Task_118922_Desc = {
    Text = "안개의 도시"
  },
  Task_118979_Desc = {
    Text = "대적하는 체스·회차 선택"
  },
  Task_118980_Desc = {
    Text = "「<color=#ae6abb>영지</color>」깨어남체를 사용하지 않고 20승 달성"
  },
  Task_118981_Desc = {
    Text = "전투 중에 아바타를 클릭하여 3명의 적에게 표정「안녕」이나「Hi」를 보냅니다"
  },
  Task_118982_Desc = {
    Text = "사전 편성 모드에서 500포인트에 도달"
  },
  Task_118983_Desc = {
    Text = "「<color=#76bf9d>축복</color>」깨어남체를 사용하지 않고 20승 달성"
  },
  Task_118984_Desc = {
    Text = "순차 선택 모드에서 1000포인트에 도달"
  },
  Task_118985_Desc = {
    Text = "순차 선택 모드에서 2500포인트에 도달"
  },
  Task_118986_Desc = {
    Text = "「페이즈 계몽」 모든 업적 완료"
  },
  Task_118987_Desc = {
    Text = "「<color=#6a97c2>수호</color>」깨어남체를 사용하지 않고 20승 달성"
  },
  Task_118988_Desc = {
    Text = "상태 계몽"
  },
  Task_118989_Desc = {
    Text = "「대전 표정」에서 한 번에 16개의 표정을 가져가 페이즈 체스 전투에 참여"
  },
  Task_118990_Desc = {
    Text = "상태 대국 전투 종료 후 적의 전술 복사"
  },
  Task_118991_Desc = {
    Text = "「순차 선택 모드」 1회 참여"
  },
  Task_118992_Desc = {
    Text = "사전 편성 모드에서 2000포인트에 도달"
  },
  Task_118993_Desc = {
    Text = "순차 선택 모드에서 2000포인트에 도달"
  },
  Task_118994_Desc = {
    Text = "순차 선택 모드에서 500포인트에 도달"
  },
  Task_118995_Desc = {
    Text = "페이즈 체스 전투가 끝난 후 상대에게「한 판 더」"
  },
  Task_118996_Desc = {
    Text = "사전 편성 모드에서 1000포인트에 도달"
  },
  Task_118997_Desc = {
    Text = "「<color=#c26669>투쟁</color>」깨어남체를 사용하지 않고 20승 달성"
  },
  Task_118998_Desc = {
    Text = "「수집」 내 카드 코멘트에 좋아요"
  },
  Task_118999_Desc = {
    Text = "「수집」 내 「깨어남체 실타래험」에서 깨어남체를 테스트하고 「친숙한 검은 고양이」 1마리를 처치"
  },
  Task_119000_Desc = {
    Text = "사전 편성 모드에서 3000포인트에 도달"
  },
  Task_119001_Desc = {
    Text = "「사전 편성 모드」 1회 참여"
  },
  Task_119002_Desc = {
    Text = "사전 편성 모드에서 1500포인트에 도달"
  },
  Task_119003_Desc = {
    Text = "순차 선택 모드에서 3000포인트에 도달"
  },
  Task_119004_Desc = {
    Text = "순차 선택 모드에서 1500포인트에 도달"
  },
  Task_119005_Desc = {
    Text = "대적하는 체스·예비 구성"
  },
  Task_119006_Desc = {
    Text = "「수호자 기록」의 「전투 기록」에서 페이즈 체스의 「재생」을 시청"
  },
  Task_119007_Desc = {
    Text = "「암호 대전」 1회 참여"
  },
  Task_119008_Desc = {
    Text = "사전 편성 모드에서 2500포인트에 도달"
  },
  Task_119009_Desc = {
    Text = "「<color=#c3aa64>흉성</color>」깨어남체를 사용하지 않고 20승 달성"
  },
  Task_119010_Desc = {
    Text = "만상 통찰"
  },
  Task_119193_Desc = {
    Text = "누적 68,000 원액 추출하기"
  },
  Task_119201_Desc = {
    Text = "누적 54,000 원액 추출하기"
  },
  Task_119212_Desc = {
    Text = "누적 42,000 원액 추출하기"
  },
  Task_119216_Desc = {
    Text = "누적 48,000 원액 추출하기"
  },
  Task_119217_Desc = {
    Text = "누적 36,000 원액 추출하기"
  },
  Task_119695_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_119696_Desc = {
    Text = "망각편 제4장 「무성한 곳에서」"
  },
  Task_119697_Desc = {
    Text = "통과 별의 장 제4장「낙원」"
  },
  Task_119698_Desc = {
    Text = "은열쇠를 200회 누적 사용"
  },
  Task_119699_Desc = {
    Text = "망각편 제7장 「욕하」 클리어"
  },
  Task_120441_Desc = {
    Text = "「조사 작전」 제7장 완료"
  },
  Task_120500_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120501_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120502_Desc = {
    Text = "조사 사건「@1@2」에서 2번 공명합니다"
  },
  Task_120502_Desc2 = {
    Text = "사건「놀이동산」에서 2회 공명합니다"
  },
  Task_120502_Name2 = {
    Text = "허망한 회상"
  },
  Task_120503_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_120503_Desc2 = {
    Text = "조사 사건 「정원」을 완료하십시오"
  },
  Task_120503_Name2 = {
    Text = "낙원의 붕괴"
  },
  Task_120504_Desc = {
    Text = "통과 별의 장 제4장 4-6"
  },
  Task_120505_Desc = {
    Text = "조사 사건 「정원」 어려움 난이도를 완료하십시오"
  },
  Task_120505_Name = {
    Text = "놀이공원의 붕괴·어려움"
  },
  Task_120506_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_120506_Desc2 = {
    Text = "수사 사건「낙원」에서 공명을 6회 하였습니다"
  },
  Task_120506_Name2 = {
    Text = "허망한 회상Ⅲ"
  },
  Task_120507_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120508_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120509_Desc = {
    Text = "통과 별의 장 제4장「낙원」어려움 난이도"
  },
  Task_120510_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120511_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120512_Desc = {
    Text = "통과 별의 장 제4장 4-6"
  },
  Task_120514_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120515_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120516_Desc = {
    Text = "통과 별의 장 제4장 4-5 어려움 난이도"
  },
  Task_120517_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120518_Desc = {
    Text = "통과 별의 장 제4장 4-5 어려움 난이도"
  },
  Task_120519_Desc = {
    Text = "통과 별의 장 제4장「낙원」"
  },
  Task_120520_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 7회 발생"
  },
  Task_120520_Desc2 = {
    Text = "수사 사건「낙원」에서 공명을 7회 하였습니다"
  },
  Task_120520_Name2 = {
    Text = "허망한 회상Ⅳ"
  },
  Task_120521_Desc = {
    Text = "통과 별의 장 제4장「낙원」어려움 난이도"
  },
  Task_120522_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_120523_Desc = {
    Text = "조사 사건「@1@2」에서 4번 공명합니다"
  },
  Task_120523_Desc2 = {
    Text = "사건「놀이동산」에서 4회 공명합니다"
  },
  Task_120523_Name2 = {
    Text = "허망한 회상Ⅱ"
  },
  Task_120524_Desc = {
    Text = "통과 별의 장 제4장「낙원」"
  },
  Task_120535_Desc = {
    Text = "망각편 제4장 「무성한 곳에서」"
  },
  Task_120536_Desc = {
    Text = "망각편 제7장 「욕하」 클리어"
  },
  Task_120537_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_120538_Desc = {
    Text = "통과 별의 장 제4장「낙원」"
  },
  Task_120549_Desc = {
    Text = "페이즈 체스에서 항복하지 않고 마지막 100경기까지 전투합니다"
  },
  Task_120850_Desc = {
    Text = "혈육 깨어남체만 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120851_Desc = {
    Text = "혼돈, 초차원 깨어남체를 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120852_Desc = {
    Text = "혼돈 깨어남체만 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120855_Desc = {
    Text = "「환몽 심잠」 최고 점수 1000 달성"
  },
  Task_120856_Desc = {
    Text = "혼돈, 혈육 깨어남체를 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120857_Desc = {
    Text = "혼돈 깨어남체만 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120862_Desc = {
    Text = "혈육 깨어남체만 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120863_Desc = {
    Text = "혼돈, 심해 깨어남체를 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120864_Desc = {
    Text = "혼돈, 초차원 깨어남체를 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120865_Desc = {
    Text = "심해, 초차원 깨어남체를 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120867_Desc = {
    Text = "심해, 혈육 깨어남체를 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120868_Desc = {
    Text = "악몽 아래"
  },
  Task_120869_Desc = {
    Text = "초차원 깨어남체만 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120870_Desc = {
    Text = "혼돈, 혈육 깨어남체를 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120871_Desc = {
    Text = "「환몽 심잠」 최고 점수 7000 달성"
  },
  Task_120872_Desc = {
    Text = "심해 깨어남체만 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120873_Desc = {
    Text = "심해 깨어남체만 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120876_Desc = {
    Text = "영역 해양 순항"
  },
  Task_120878_Desc = {
    Text = "「환몽 심잠」 최고 점수 6000 달성"
  },
  Task_120879_Desc = {
    Text = "심해, 초차원 깨어남체를 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120880_Desc = {
    Text = "「환상 잠수」의 「순위표」에서 1회 재생 관람"
  },
  Task_120882_Desc = {
    Text = "초차원 깨어남체만 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120883_Desc = {
    Text = "혼돈, 심해 깨어남체를 사용하여 「환몽 심잠」1회 완료"
  },
  Task_120884_Desc = {
    Text = "혈육, 초차원 깨어남체를 사용하여 난이도 VI 이상「환몽 심잠」5회 완료"
  },
  Task_120885_Desc = {
    Text = "꿈의 바다에 처음 들어서다"
  },
  Task_120889_Desc = {
    Text = "「환몽 심잠」 최고 점수 5000 달성"
  },
  Task_120890_Desc = {
    Text = "「환몽 심잠」1회 완료"
  },
  Task_120891_Desc = {
    Text = "「환몽 심잠」의 「랭킹」에서 팀 조합 1회 복사"
  },
  Task_120892_Desc = {
    Text = "「환몽 심잠」 최고 점수 2000 달성"
  },
  Task_120894_Desc = {
    Text = "「환몽 심잠」 최고 점수 4000 달성"
  },
  Task_120895_Desc = {
    Text = "「환몽 심잠」 최고 점수 3000 달성"
  },
  Task_120966_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_120966_Name = {Text = "3승"},
  Task_120967_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_120967_Name = {Text = "6승"},
  Task_120968_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_120968_Name = {Text = "10승"},
  Task_120969_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_120969_Name = {Text = "1승"},
  Task_120994_Desc = {
    Text = "「재전 원초·불협화음 서곡」의 모든 분신을 소멸시켜"
  },
  Task_120994_Name = {
    Text = "보스1 격파"
  },
  Task_120995_Desc = {
    Text = "「재전투 원초적·뒤틀린 화음」 모든 분신을 소멸시키다"
  },
  Task_120995_Name = {
    Text = "보스4 격파"
  },
  Task_120996_Name = {
    Text = "세계 보스 이벤트의 끝"
  },
  Task_120997_Desc = {
    Text = "「재전 원초 · 영원한 깊은 잠」의 모든 분신을 소멸시키기"
  },
  Task_120997_Name = {
    Text = "킬 보스7"
  },
  Task_120998_Desc = {
    Text = "「재전 원초·죽음의 선율」 모든 분신을 소멸시켜"
  },
  Task_120998_Name = {
    Text = "보스3 격파"
  },
  Task_120999_Desc = {
    Text = "「재전 원초·사신주음」 모든 분신을 소멸시키기"
  },
  Task_120999_Name = {
    Text = "보스5 격파"
  },
  Task_121000_Desc = {
    Text = "「재전 원초·광기 말미」 모든 분신을 소멸시켜"
  },
  Task_121000_Name = {
    Text = "보스 6 킬"
  },
  Task_121001_Desc = {
    Text = "「재전 원초·무질서 전주」의 모든 분신을 소멸시켜"
  },
  Task_121001_Name = {
    Text = "보스2 격파"
  },
  Task_121033_Desc = {
    Text = "누적 깨어남 30회"
  },
  Task_121035_Desc = {
    Text = "파견 20회 완료"
  },
  Task_121040_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_121041_Desc = {
    Text = "파견 20회 완료"
  },
  Task_121042_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_121044_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_121045_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_121046_Desc = {
    Text = "1회의 모샤 체험 스테이지 클리어"
  },
  Task_121047_Desc = {
    Text = "누적 깨어남 30회"
  },
  Task_121050_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_121051_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_121053_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_121054_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_121058_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_121061_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_121062_Desc = {
    Text = "1회의 모샤 체험 스테이지 클리어"
  },
  Task_121206_Desc = {
    Text = "누적 76,000 원액 추출하기"
  },
  Task_121207_Desc = {
    Text = "누적 84,000 원액 추출하기"
  },
  Task_121208_Desc = {
    Text = "누적 92,000 원액 추출하기"
  },
  Task_121233_Desc = {
    Text = "「경건한 손Ⅳ」에서 3성 평가를 획득했습니다"
  },
  Task_121234_Desc = {
    Text = "「밀랍상 비밀Ⅱ」에서 3성 평가를 획득했습니다"
  },
  Task_121235_Desc = {
    Text = "「기질 잔상Ⅲ」에서 별 3개 평가를 얻다"
  },
  Task_121236_Desc = {
    Text = "「인형의 눈물Ⅴ」에서 삼성 평가를 획득"
  },
  Task_121237_Desc = {
    Text = "「밀랍상 비밀Ⅲ」에서 3성 평가를 획득했습니다"
  },
  Task_121238_Desc = {
    Text = "「금권 수색Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121239_Desc = {
    Text = "「경계 밖의 그림자 IV」에서 삼성 평점을 받음"
  },
  Task_121240_Desc = {
    Text = "「카오스 클러스터 Ⅳ」에서 별 3개 평가를 얻다"
  },
  Task_121241_Desc = {
    Text = "「성태의 송가Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121242_Desc = {
    Text = "「암해의 배Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121243_Desc = {
    Text = "「칠흑의 사슬Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121244_Desc = {
    Text = "「해연 잔상Ⅴ」에서 삼성 평가를 획득"
  },
  Task_121245_Desc = {
    Text = "「차원 잔상Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121246_Desc = {
    Text = "「실타래서산맥Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121247_Desc = {
    Text = "「괴무의 도시Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121248_Desc = {
    Text = "「포나페의 폐허Ⅱ」에서 별점 3개 달성"
  },
  Task_121249_Desc = {
    Text = "「기질 잔상Ⅱ」에서 별 3개 평가를 얻다"
  },
  Task_121250_Desc = {
    Text = "「실타래서산맥Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121251_Desc = {
    Text = "「차원 잔상Ⅱ」에서 3성 평가를 획득했습니다"
  },
  Task_121252_Desc = {
    Text = "「혼탁 잔상Ⅳ」에서 삼성 평가를 획득"
  },
  Task_121253_Desc = {
    Text = "「광조 납관Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121254_Desc = {
    Text = "「경건한 손Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121255_Desc = {
    Text = "「혼돈 집단Ⅰ」에서 3성 평가를 얻다"
  },
  Task_121256_Desc = {
    Text = "「밀랍상 비밀Ⅳ」에서 3성 평가를 획득했습니다"
  },
  Task_121257_Desc = {
    Text = "「벌레의 소굴 Ⅰ」에서 별점 3개 획득"
  },
  Task_121258_Desc = {
    Text = "「황사 벽Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121259_Desc = {
    Text = "「인형의 눈물Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121260_Desc = {
    Text = "「경건한 손Ⅲ」에서 3성 평가를 획득했습니다"
  },
  Task_121261_Desc = {
    Text = "「경계 밖의 그림자 III」에서 삼성 평점을 받음"
  },
  Task_121262_Desc = {
    Text = "「사해의 유적Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121263_Desc = {
    Text = "「카오스 클러스터 Ⅱ」에서 별 3개 평가를 받았습니다"
  },
  Task_121264_Desc = {
    Text = "「혼란의 이 마을Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121265_Desc = {
    Text = "「해연 잔상Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121266_Desc = {
    Text = "「사해의 유적Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121267_Desc = {
    Text = "「광조 납관Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121268_Desc = {
    Text = "「해연 잔상Ⅳ」에서 삼성 평가를 획득"
  },
  Task_121269_Desc = {
    Text = "「스워시 코르도 Ⅳ」에서 3성 평가를 획득"
  },
  Task_121270_Desc = {
    Text = "「차원 잔상Ⅲ」에서 3성 평가를 획득했습니다"
  },
  Task_121271_Desc = {
    Text = "「금권 수색Ⅳ」에서 3성 평가를 획득했습니다"
  },
  Task_121272_Desc = {
    Text = "「해연 잔상Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121273_Desc = {
    Text = "「제제 추출Ⅰ」에서 별 3개 평가를 얻다"
  },
  Task_121274_Desc = {
    Text = "「밀랍상 비밀Ⅴ」에서 3성 평가를 획득했습니다"
  },
  Task_121275_Desc = {
    Text = "「사해의 유적Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121276_Desc = {
    Text = "「광조 납관Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121277_Desc = {
    Text = "「실타래서산맥Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121278_Desc = {
    Text = "「제제 추출Ⅳ」에서 별 3개 평가를 얻다"
  },
  Task_121279_Desc = {
    Text = "「인형의 눈물Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121280_Desc = {
    Text = "「기질 잔상Ⅴ」에서 별 3개 평가를 얻다"
  },
  Task_121281_Desc = {
    Text = "「암해의 배Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121282_Desc = {
    Text = "「검은 연못의 조류Ⅱ」에서 3성 평가를 획득했습니다"
  },
  Task_121283_Desc = {
    Text = "「혼탁 잔상Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121284_Desc = {
    Text = "「경건한 손Ⅱ」에서 3성 평가를 획득했습니다"
  },
  Task_121285_Desc = {
    Text = "「폭풍 해안Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121286_Desc = {
    Text = "「밀랍상 비밀Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121287_Desc = {
    Text = "「포나페의 폐허 Ⅲ」에서 별점 3개 획득"
  },
  Task_121288_Desc = {
    Text = "「성태의 송가Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121289_Desc = {
    Text = "「기질 잔상Ⅳ」에서 별 3개 평가를 얻다"
  },
  Task_121290_Desc = {
    Text = "「기질 잔상Ⅰ」에서 별 3개 평가를 얻다"
  },
  Task_121291_Desc = {
    Text = "「경계 밖의 그림자Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121292_Desc = {
    Text = "「성태의 송가Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121293_Desc = {
    Text = "「스워시 코르도 Ⅲ」에서 삼성 등급을 획득"
  },
  Task_121294_Desc = {
    Text = "「경계 밖의 그림자Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121295_Desc = {
    Text = "「금권 수색Ⅱ」에서 3성 평가를 획득했습니다"
  },
  Task_121296_Desc = {
    Text = "「제제 추출Ⅴ」에서 별 3개 평가를 얻다"
  },
  Task_121297_Desc = {
    Text = "「혼란의 이 마을Ⅱ」에서 3성 평가를 획득했습니다"
  },
  Task_121298_Desc = {
    Text = "「제제 추출Ⅱ」에서 별 3개 평가를 얻다"
  },
  Task_121299_Desc = {
    Text = "「스워시 코르도 Ⅱ」에서 3성 평가를 획득"
  },
  Task_121300_Desc = {
    Text = "「금권 수색Ⅴ」에서 3성 평가를 획득했습니다"
  },
  Task_121301_Desc = {
    Text = "「괴무의 도시Ⅲ」에서 삼성 평가를 획득"
  },
  Task_121302_Desc = {
    Text = "「제제 추출Ⅲ」에서 별 3개 평가를 얻다"
  },
  Task_121303_Desc = {
    Text = "「포나페의 폐허Ⅳ」에서 별점 3개 평가를 받다"
  },
  Task_121304_Desc = {
    Text = "「카오스 클러스터 Ⅲ」에서 3성 평가를 받다"
  },
  Task_121305_Desc = {
    Text = "「괴무의 도시Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121306_Desc = {
    Text = "「벌레의 소굴 Ⅲ」에서 별점 3개를 획득"
  },
  Task_121307_Desc = {
    Text = "「해연 잔상Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121308_Desc = {
    Text = "「벌레의 소굴 Ⅳ」에서 별점 평가 3개 획득"
  },
  Task_121309_Desc = {
    Text = "「포나페의 유적Ⅰ」에서 별 3개 평가를 받다"
  },
  Task_121310_Desc = {
    Text = "「혼탁 잔상Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121311_Desc = {
    Text = "「차원 잔상Ⅴ」에서 3성 평가를 획득했습니다"
  },
  Task_121312_Desc = {
    Text = "「벌레의 소굴 Ⅱ」에서 별점 평가 3개 획득"
  },
  Task_121313_Desc = {
    Text = "「칠흑의 사슬Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121314_Desc = {
    Text = "「차원 잔상Ⅳ」에서 3성 평가를 획득했습니다"
  },
  Task_121315_Desc = {
    Text = "「혼탁 잔상Ⅴ」에서 삼성 평가를 획득"
  },
  Task_121316_Desc = {
    Text = "「칠흑의 사슬Ⅳ」에서 삼성 평가를 획득"
  },
  Task_121317_Desc = {
    Text = "「칠흑의 사슬Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121318_Desc = {
    Text = "「혼란의 이 마을Ⅲ」에서 3성 평가를 획득했습니다"
  },
  Task_121319_Desc = {
    Text = "「인형의 눈물Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121320_Desc = {
    Text = "「암해의 배Ⅱ」에서 삼성 평가를 획득"
  },
  Task_121321_Desc = {
    Text = "「금권 수색Ⅲ」에서 3성 평가를 획득했습니다"
  },
  Task_121322_Desc = {
    Text = "「칠흑의 사슬Ⅴ」에서 삼성 평가를 획득"
  },
  Task_121323_Desc = {
    Text = "「인형의 눈물Ⅳ」에서 삼성 평가를 획득"
  },
  Task_121324_Desc = {
    Text = "「검은 연못의 조류Ⅰ」에서 3성 평가를 획득했습니다"
  },
  Task_121325_Desc = {
    Text = "「혼탁 잔상Ⅰ」에서 삼성 평가를 획득"
  },
  Task_121326_Desc = {
    Text = "「스워시 코르도 Ⅰ」에서 3성 평가를 얻다"
  },
  Task_121327_Desc = {
    Text = "「원초의 균열Ⅰ」에서 별 3개 평가를 얻다"
  },
  Task_121331_Desc = {
    Text = "「초입의 꿈바다」 모든 임무 완료"
  },
  Task_121332_Desc = {
    Text = "심해, 혈육 깨어남체를 사용하여 「환몽 심잠」1회 완료"
  },
  Task_121333_Desc = {
    Text = "혈육, 초차원 깨어남체를 사용하여 「환몽 심잠」1회 완료"
  },
  Task_121834_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121834_Name = {
    Text = "완벽한 통과"
  },
  Task_121835_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121835_Name = {
    Text = "완벽한 통과"
  },
  Task_121836_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121836_Name = {
    Text = "완벽한 통과"
  },
  Task_121837_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121837_Name = {
    Text = "완벽한 통과"
  },
  Task_121838_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121838_Name = {
    Text = "완벽한 통과"
  },
  Task_121839_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121839_Name = {
    Text = "완벽한 통과"
  },
  Task_121840_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121840_Name = {
    Text = "완벽한 통과"
  },
  Task_121841_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121841_Name = {
    Text = "완벽한 통과"
  },
  Task_121842_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121842_Name = {
    Text = "완벽한 통과"
  },
  Task_121843_Desc = {
    Text = "모든 성상 저주를 견디고, 15턴 내에 '낙원 프로젝션'을 물리쳐야 합니다."
  },
  Task_121843_Name = {
    Text = "낙원의 붕괴·숨기기"
  },
  Task_121844_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_121844_Name = {
    Text = "완벽한 통과"
  },
  Task_121897_Desc = {
    Text = "매 라운드가 남을 때마다 추가로 20점을 얻습니다. (현재 남은 라운드: {s1})"
  },
  Task_121897_Name = {
    Text = "시간 모래시계<size=20><color=#747474>초기 턴은 50, 남은 1턴마다 추가로 20점을 획득합니다.</color></size>"
  },
  Task_122110_Desc = {
    Text = "일일 첫 플레이 시 500점을 획득합니다."
  },
  Task_122110_Name = {
    Text = "탐몽 선행자<size=20><color=#747474>매일 첫 플레이 시 500점 획득</color></size>"
  },
  Task_122197_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「잃어버린 나」에서 1회 승리"
  },
  Task_122198_Desc = {
    Text = "클리어 「사지를 지배하다」 광기 난이도"
  },
  Task_122199_Desc = {
    Text = "클리어 「심장을 부수다」 광기 난이도"
  },
  Task_122200_Desc = {
    Text = "클리어 「절단 충수」 임의 난이도"
  },
  Task_122201_Desc = {
    Text = "클리어 「언어 통제」 임의 난이도"
  },
  Task_122202_Desc = {
    Text = "클리어 「본능적 사고」 어떤 난이도든"
  },
  Task_122203_Desc = {
    Text = "클리어 「진정한 나의 해방」 광기 난이도"
  },
  Task_122204_Desc = {
    Text = "클리어 「눈을 가리다」 광기 난이도"
  },
  Task_122205_Desc = {
    Text = "클리어 「심장을 부수다」 임의 난이도"
  },
  Task_122206_Desc = {
    Text = "클리어 「언어 통제」 임의 난이도"
  },
  Task_122207_Desc = {
    Text = "클리어 「절단 맹장」 광기 난이도"
  },
  Task_122208_Desc = {
    Text = "클리어 「본능적 사고」 어떤 난이도든"
  },
  Task_122209_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「잃어버린 자아」에서 1회 승리"
  },
  Task_122210_Desc = {
    Text = "클리어 「사지 지배」 아무 난이도"
  },
  Task_122211_Desc = {
    Text = "클리어 「진정한 나의 해방」 임의 난이도"
  },
  Task_122212_Desc = {
    Text = "다차원 연결「은과 피의 세례」"
  },
  Task_122213_Desc = {
    Text = "「잃어버린 나·클리어」 모든 성취를 완료하다"
  },
  Task_122214_Desc = {
    Text = "클리어 「눈을 가리다」 임의의 난이도"
  },
  Task_122215_Desc = {
    Text = "잃어버린 자아·경계역"
  },
  Task_122216_Desc = {
    Text = "클리어 「본능적 사고」 광기 난이도"
  },
  Task_122217_Desc = {
    Text = "클리어 「사지 지배」 아무 난이도"
  },
  Task_122218_Desc = {
    Text = "클리어 「진정한 나의 해방」 임의 난이도"
  },
  Task_122219_Desc = {
    Text = "잃어버린 자아·클리어"
  },
  Task_122220_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「잃어버린 자아」에서 2번 승리하세요"
  },
  Task_122221_Desc = {
    Text = "잃어버린 나·광기"
  },
  Task_122222_Desc = {
    Text = "클리어 「눈을 가리다」 임의의 난이도"
  },
  Task_122223_Desc = {
    Text = "클리어 「언어 제어」 광기 난이도"
  },
  Task_122224_Desc = {
    Text = "클리어 「절단 충수」 임의 난이도"
  },
  Task_122225_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「잃어버린 자아」에서 1회 승리"
  },
  Task_122226_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「잃어버린 자아」에서 2번 승리하기"
  },
  Task_122227_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「잃어버린 자아」에서 1회 승리"
  },
  Task_122228_Desc = {
    Text = "클리어 「심장을 부수다」 임의 난이도"
  },
  Task_122229_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「잃어버린 자아」에서 2번 승리하기"
  },
  Task_122230_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「잃어버린 자아」에서 2번 승리하기"
  },
  Task_122411_Desc = {
    Text = "강화 깨어남체 1/2명으로 출전 시, 250 / 500점 획득. (현재 출전: {s1})"
  },
  Task_122411_Name = {
    Text = "심연 호출<size=20><color=#747474>강화 깨어남체 1/2명으로 출전 시, 250 / 500점 획득 </color></size>"
  },
  Task_122584_Name = {
    Text = "모든 보스 격파"
  },
  Task_122704_Desc = {
    Text = "모샤 동조율이 10급에 도달했습니다"
  },
  Task_122808_Desc = {
    Text = "모샤 획득 시 기령 6"
  },
  Task_122808_Name = {
    Text = "모샤 획득 시 기령 6"
  },
  Task_122808_UnlockCondDesc = {
    Text = "이벤트@깨어남체 모샤 기령 패키지 2 이벤트"
  },
  Task_122809_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_122812_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_122816_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_122819_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_122824_Desc = {
    Text = "모샤 획득 시 기령 2"
  },
  Task_122824_Name = {
    Text = "모샤 획득 시 기령 2"
  },
  Task_122824_UnlockCondDesc = {
    Text = "이벤트@깨어남체 모샤 기령 패키지 2 이벤트"
  },
  Task_122828_Desc = {
    Text = "「조사 작전 작전-망각편-제3장」 어려움 모드 완료"
  },
  Task_122829_Desc = {
    Text = "완료「조사 작전 작전-망각편-제1장」어려움 모드"
  },
  Task_122830_Desc = {
    Text = "완료 「조사 작전 작전-망각편-제6장」 어려움 모드"
  },
  Task_122831_Desc = {
    Text = "완료 「조사 작전 작전-망각편-제7장」 어려움 모드"
  },
  Task_122832_Desc = {
    Text = "「조사 작전 작전 - 망각편 - 제4장」 어려움 모드 완료"
  },
  Task_122833_Desc = {
    Text = "조사 작전 작전 - 망각편 - 제2장 완료 어려움 모드"
  },
  Task_122834_Desc = {
    Text = "「조사 작전 작전-망각편-제5장」 어려움 모드 완료"
  },
  Task_123135_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「마녀 가게」에서 2회 승리"
  },
  Task_123136_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「마녀 가게」에서 2번 승리하기"
  },
  Task_123137_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「마녀 가게」에서 1회 승리"
  },
  Task_123138_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「마녀의 가게」에서 1회 승리"
  },
  Task_123139_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「마녀의 가게」에서 1회 승리"
  },
  Task_123140_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 체를 깨우고 「마녀 가게」에서 2번 승리"
  },
  Task_123141_Desc = {
    Text = "마녀의 소점포·경계역"
  },
  Task_123142_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「마녀 가게」에서 1회 승리"
  },
  Task_123143_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「마녀 가게」에서 2번 승리하세요"
  },
  Task_123288_Desc = {
    Text = "\"초차원 영역 깨어남체\"를 사용하여 \"심해의 응시\"에서 2번 승리"
  },
  Task_123289_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「심해의 응시」에서 2번 승리"
  },
  Task_123290_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「심해의 응시」에서 2번 승리"
  },
  Task_123291_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「심해의 응시」에서 2회 승리"
  },
  Task_123324_Desc = {
    Text = "파견 20회 완료"
  },
  Task_123325_Desc = {
    Text = "파견 20회 완료"
  },
  Task_123326_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_123327_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_123328_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_123329_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_123330_Desc = {
    Text = "테이스 시험판 스테이지 1회를 통과"
  },
  Task_123331_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_123332_Desc = {
    Text = "누적 깨어남 30회"
  },
  Task_123333_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_123334_Desc = {
    Text = "테이스 시험판 스테이지 1회를 통과"
  },
  Task_123335_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_123336_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_123337_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_123338_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_123339_Desc = {
    Text = "누적 깨어남 30회"
  },
  Task_123488_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_123488_Name = {Text = "3승"},
  Task_123489_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_123489_Name = {Text = "6승"},
  Task_123490_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_123490_Name = {Text = "10승"},
  Task_123491_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_123491_Name = {Text = "1승"},
  Task_123726_Name = {
    Text = "모샤 사이드 스테이지 보통 6 재차 클리어"
  },
  Task_123878_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「야수의 야망」에서 2회 승리"
  },
  Task_123883_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「야수의 야망」에서 2회 승리"
  },
  Task_123885_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「야수의 야망」에서 2회 승리"
  },
  Task_123887_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「야수의 야망」에서 2회 승리"
  },
  Task_124214_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_124214_Name = {Text = "3승"},
  Task_124215_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_124215_Name = {Text = "10승"},
  Task_124216_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_124216_Name = {Text = "1승"},
  Task_124217_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_124217_Name = {Text = "6승"},
  Task_124797_Desc = {
    Text = "「역전의 턴」의 다차원 연결 완료"
  },
  Task_124797_Name = {
    Text = "만상 역전"
  },
  Task_124798_Desc = {
    Text = "다차원 연결 “은과 피의 세례” 어려움 완료"
  },
  Task_124798_Name = {
    Text = "미래가 올 것입니다·어려움"
  },
  Task_124799_Desc = {
    Text = "다차원 연결 “은과 피의 세례” 완료"
  },
  Task_124799_Name = {
    Text = "미래가 올 것입니다"
  },
  Task_124835_Desc = {
    Text = "망각편「조사 작전 작전-제1장」 클리어"
  },
  Task_125386_Desc = {
    Text = "클리어 「시체 해탈」 임의 난이도"
  },
  Task_125387_Desc = {
    Text = "클리어 「창 뒤의 그림자」 임의의 난이도"
  },
  Task_125388_Desc = {
    Text = "클리어 「흡입」 임의의 난이도"
  },
  Task_125389_Desc = {
    Text = "클리어 「향기를 따라」 광기 난이도"
  },
  Task_125390_Desc = {
    Text = "클리어 「부풀어 오른 군중」 아무 난이도"
  },
  Task_125391_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「현녀무상」에서 1회 승리"
  },
  Task_125392_Desc = {
    Text = "의식 잠수 완료 “부채 아래 밤담화”"
  },
  Task_125392_Name = {
    Text = "하늘이 불안하고, 땅이 불안하다"
  },
  Task_125393_Desc = {
    Text = "클리어 「향기를 따라」 아무 난이도"
  },
  Task_125394_Desc = {
    Text = "클리어 「억울하게 죽다」 광기 난이도"
  },
  Task_125395_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_125396_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「현녀무상」에서 2회 승리"
  },
  Task_125397_Desc = {
    Text = "클리어 「사랑과 원망이 서로 생겨나다」 광기 난이도"
  },
  Task_125398_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_125399_Desc = {
    Text = "클리어 「억울하게 죽다」 임의 난이도"
  },
  Task_125400_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「현녀무상」에서 1회 승리"
  },
  Task_125401_Desc = {
    Text = "현녀무상·클리어"
  },
  Task_125402_Desc = {
    Text = "클리어 「흡입」 임의의 난이도"
  },
  Task_125403_Desc = {
    Text = "클리어 「창 뒤의 그림자」 임의의 난이도"
  },
  Task_125404_Desc = {
    Text = "클리어 「극락」 광기 난이도"
  },
  Task_125406_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「현녀무상」에서 1회 승리"
  },
  Task_125407_Desc = {
    Text = "클리어 「극락」 임의 난이도"
  },
  Task_125409_Desc = {
    Text = "클리어 「극락」 임의 난이도"
  },
  Task_125410_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「현녀무상」에서 2번 승리"
  },
  Task_125411_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「현녀무상」에서 2번 승리하기"
  },
  Task_125412_Desc = {
    Text = "클리어 「흡입」 광기 난이도"
  },
  Task_125413_Desc = {
    Text = "클리어 「의식 잠수: 부채 아래 밤담화」"
  },
  Task_125414_Desc = {
    Text = "클리어 「로직」 임의 난이도"
  },
  Task_125415_Desc = {
    Text = "서 동조율이 10급에 도달했습니다"
  },
  Task_125416_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「현녀무상」에서 2번 승리하세요"
  },
  Task_125417_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_125418_Desc = {
    Text = "서 획득 시 기령 2"
  },
  Task_125418_Name = {
    Text = "서 획득 시 기령 2"
  },
  Task_125418_UnlockCondDesc = {
    Text = "이벤트@깨어남체 서 기령 패키지 2 이벤트"
  },
  Task_125419_Desc = {
    Text = "클리어 「사랑과 원망이 서로 생겨나다」 임의 난이도"
  },
  Task_125420_Desc = {
    Text = "현녀무상·영역"
  },
  Task_125421_Desc = {
    Text = "클리어 「창 뒤의 그림자」 광기 난이도"
  },
  Task_125422_Desc = {
    Text = "클리어 「사랑과 원망이 서로 생겨나다」 임의 난이도"
  },
  Task_125423_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「현녀무상」에서 1회 승리"
  },
  Task_125424_Desc = {
    Text = "클리어 「향기를 따라」 아무 난이도"
  },
  Task_125425_Desc = {
    Text = "클리어 「부풀어 오른 군중」 광기 난이도"
  },
  Task_125426_Desc = {
    Text = "서 획득 시 기령 6"
  },
  Task_125426_Name = {
    Text = "서 획득 시 기령 6"
  },
  Task_125426_UnlockCondDesc = {
    Text = "이벤트@깨어남체 서 기령 패키지 2 이벤트"
  },
  Task_125427_Desc = {
    Text = "클리어 「로직」 임의 난이도"
  },
  Task_125428_Desc = {
    Text = "「현녀무상·클리어」 모든 성취를 완료하다"
  },
  Task_125429_Desc = {
    Text = "클리어 「시체 해탈」 임의 난이도"
  },
  Task_125430_Desc = {
    Text = "클리어 「로직」 광기 난이도"
  },
  Task_125431_Desc = {
    Text = "클리어 「부풀어 오른 군중」 아무 난이도"
  },
  Task_125432_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_125433_Desc = {
    Text = "클리어 「억울하게 죽다」 임의 난이도"
  },
  Task_125434_Desc = {
    Text = "현녀무상·광기"
  },
  Task_125435_Desc = {
    Text = "클리어 「시체 해탈」 광기 난이도"
  },
  Task_125500_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_125500_Name = {Text = "6승"},
  Task_125501_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_125501_Name = {Text = "10승"},
  Task_125502_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_125502_Name = {Text = "1승"},
  Task_125503_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_125503_Name = {Text = "3승"},
  Task_125686_Desc = {
    Text = "추격에서 도망치다"
  },
  Task_125686_Name = {Text = "목표"},
  Task_125687_Desc = {
    Text = "매복에서 살아남기"
  },
  Task_125687_Name = {Text = "목표"},
  Task_125688_Desc = {
    Text = "리즈의 몸을 되찾다"
  },
  Task_125688_Name = {Text = "목표"},
  Task_125689_Desc = {
    Text = "아라크네의 함정에서 탈출하기"
  },
  Task_125689_Name = {Text = "목표"},
  Task_125690_Desc = {
    Text = "삼질체의 봉인을 해제하다"
  },
  Task_125690_Name = {Text = "목표"},
  Task_125691_Desc = {
    Text = "주점의 적과 맞서다"
  },
  Task_125691_Name = {Text = "목표"},
  Task_125692_Desc = {
    Text = "융식체 처치"
  },
  Task_125692_Name = {Text = "목표"},
  Task_125693_Desc = {
    Text = "「선량」 구해줘"
  },
  Task_125693_Name = {Text = "목표"},
  Task_125694_Desc = {
    Text = "소렐 보호"
  },
  Task_125694_Name = {Text = "목표"},
  Task_125695_Desc = {
    Text = "「회상」에 복수하다"
  },
  Task_125695_Name = {Text = "목표"},
  Task_125845_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125845_Name = {
    Text = "완벽한 통과"
  },
  Task_125846_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125846_Name = {
    Text = "완벽한 통과"
  },
  Task_125847_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125847_Name = {
    Text = "완벽한 통과"
  },
  Task_125848_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125848_Name = {
    Text = "완벽한 통과"
  },
  Task_125849_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125849_Name = {
    Text = "완벽한 통과"
  },
  Task_125850_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125850_Name = {
    Text = "완벽한 통과"
  },
  Task_125851_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125851_Name = {
    Text = "완벽한 통과"
  },
  Task_125852_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125852_Name = {
    Text = "완벽한 통과"
  },
  Task_125853_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125853_Name = {
    Text = "완벽한 통과"
  },
  Task_125854_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_125854_Name = {
    Text = "완벽한 통과"
  },
  Task_126276_Desc = {
    Text = "「스포일러 금지」 광란 난이도 클리어"
  },
  Task_126277_Desc = {
    Text = "인형의 무대·광란"
  },
  Task_126279_Desc = {
    Text = "심해 계역 깨어남체를 사용하여 「인형의 무대」에서 1회 승리"
  },
  Task_126280_Desc = {
    Text = "인형의 무대·클리어"
  },
  Task_126281_Desc = {
    Text = "「연소」 임의 난이도 클리어"
  },
  Task_126282_Desc = {
    Text = "「스포일러 금지」 임의 난이도 클리어"
  },
  Task_126285_Desc = {
    Text = "「입장」 임의 난이도 클리어"
  },
  Task_126286_Desc = {
    Text = "「반전, 반전」 임의 난이도 클리어"
  },
  Task_126288_Desc = {
    Text = "「벽 위의 총」 임의 난이도 클리어"
  },
  Task_126290_Desc = {
    Text = "「연소」 광란 난이도 클리어"
  },
  Task_126292_Desc = {
    Text = "「벽 위의 총」 광란 난이도 클리어"
  },
  Task_126293_Desc = {
    Text = "「연소」 임의 난이도 클리어"
  },
  Task_126294_Desc = {
    Text = "「인형의 무대·클리어」 모든 업적 완료"
  },
  Task_126295_Desc = {
    Text = "초차원 계역 깨어남체를 사용하여 「인형의 무대」에서 1회 승리"
  },
  Task_126296_Desc = {
    Text = "「반전, 반전」 광란 난이도 클리어"
  },
  Task_126297_Desc = {
    Text = "「입장」 광란 난이도 클리어"
  },
  Task_126298_Desc = {
    Text = "인형의 무대·계역"
  },
  Task_126299_Desc = {
    Text = "심해 계역 깨어남체를 사용하여 「인형의 무대」에서 2회 승리"
  },
  Task_126302_Desc = {
    Text = "혼돈 계역 깨어남체를 사용하여 「인형의 무대」에서 2회 승리"
  },
  Task_126303_Desc = {
    Text = "「입장」 임의 난이도 클리어"
  },
  Task_126304_Desc = {
    Text = "혈육 계역 깨어남체를 사용하여 「인형의 무대」에서 2회 승리"
  },
  Task_126305_Desc = {
    Text = "「스포일러 금지」 임의 난이도 클리어"
  },
  Task_126307_Desc = {
    Text = "「벽 위의 총」 임의 난이도 클리어"
  },
  Task_126309_Desc = {
    Text = "혈육 계역 깨어남체를 사용하여 「인형의 무대」에서 1회 승리"
  },
  Task_126311_Desc = {
    Text = "초차원 계역 깨어남체를 사용하여 「인형의 무대」에서 2회 승리"
  },
  Task_126312_Desc = {
    Text = "혼돈 계역 깨어남체를 사용하여 「인형의 무대」에서 1회 승리"
  },
  Task_126313_Desc = {
    Text = "「반전, 반전」 임의 난이도 클리어"
  },
  Task_126385_Desc = {
    Text = "클리어 별의 시대 제5장 \"운명 극장\" 어려움 난이도"
  },
  Task_126386_Desc = {
    Text = "클리어 별의 시대 제5장 \"운명 극장\" 어려움 난이도"
  },
  Task_126387_Desc = {
    Text = "성진편 제5장 5-7 클리어"
  },
  Task_126388_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126390_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126391_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126392_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126393_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126394_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126395_Desc = {
    Text = "클리어 별의 시대 제5장 \"운명 극장\""
  },
  Task_126396_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126397_Desc = {
    Text = "성진편 제5장 5-6 어려움 난이도 클리어"
  },
  Task_126398_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126399_Desc = {
    Text = "성진편 제5장 5-6 어려움 난이도 클리어"
  },
  Task_126400_Desc = {
    Text = "성진편 제5장 5-7 클리어"
  },
  Task_126401_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126402_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_126403_Desc = {
    Text = "클리어 별의 시대 제5장 \"운명 극장\""
  },
  Task_126493_Desc = {
    Text = "고국 잡서Ⅶ"
  },
  Task_126494_Desc = {
    Text = "고국잡조·기간 한정 전용"
  },
  Task_126495_Desc = {
    Text = "고대 국가 잡서Ⅴ"
  },
  Task_126496_Desc = {
    Text = "고국 잡저Ⅰ"
  },
  Task_126497_Desc = {
    Text = "고국 잡서Ⅵ"
  },
  Task_126498_Desc = {
    Text = "고국 잡서Ⅲ"
  },
  Task_126499_Desc = {
    Text = "고국잡조Ⅳ"
  },
  Task_126500_Desc = {
    Text = "고국잡저·무료"
  },
  Task_126501_Desc = {
    Text = "고국 잡록Ⅱ"
  },
  Task_127071_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_127071_Name = {Text = "10승"},
  Task_127072_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_127072_Name = {Text = "3승"},
  Task_127073_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_127073_Name = {Text = "6승"},
  Task_127074_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_127074_Name = {Text = "1승"},
  Task_127094_Desc = {
    Text = "오레타 기령으로 인격 심화 12에 도달하다"
  },
  Task_127095_Desc = {
    Text = "본원 라몬나 기령으로 인격 심화 12에 도달"
  },
  Task_127096_Desc = {
    Text = "라모나 기령이 인격 심화 12에 도달하다"
  },
  Task_127097_Desc = {
    Text = "아이기스 기령에 도달하여 인격 심화 12"
  },
  Task_127098_Desc = {
    Text = "로탄 기령이 인격 심화 12에 도달"
  },
  Task_127099_Desc = {
    Text = "에리카 기령으로 인격 심화 12에 도달"
  },
  Task_127100_Desc = {
    Text = "돌 기령으로 인격 심화 12에 도달하다"
  },
  Task_127101_Desc = {
    Text = "오지에 기령 인격 심화 12"
  },
  Task_129511_Desc = {
    Text = "어려움 또는 광기 난이도로 3명의 혈육과 1명의 초차원 깨어남체로 구성된 팀으로 클리어"
  },
  Task_129512_Desc = {
    Text = "혼돈 3명과 초차원 깨어남체 1명으로 구성된 팀으로 어려움 또는 광기 난이도를 클리어"
  },
  Task_129513_Desc = {
    Text = "열차 노선·어려움"
  },
  Task_129513_Name = {
    Text = "열차 노선·어려움"
  },
  Task_129514_Desc = {
    Text = "완료 광기 난이도 3단계"
  },
  Task_129515_Desc = {
    Text = "1명의 혈육과 3명의 초차원 깨어남체로 구성된 팀으로 어려움 또는 광기 난이도를 클리어합니다"
  },
  Task_129516_Desc = {
    Text = "임시 난이도에서 3단계 리더 「용해·도르」를 처치"
  },
  Task_129517_Desc = {
    Text = "임의 난이도에서 3단계 리더 「낙원 장막」을 격파"
  },
  Task_129518_Desc = {
    Text = "「열차 노선·어려움」의 모든 임무를 완료"
  },
  Task_129519_Desc = {
    Text = "4명의 초월 깨어남체로 구성된 팀으로 임의의 난이도를 클리어하세요"
  },
  Task_129520_Desc = {
    Text = "보통 난이도 두 번째 단계 완료"
  },
  Task_129521_Desc = {
    Text = "임의 난이도에서 2단계 리더 「하이드라」를 격파하다"
  },
  Task_129522_Desc = {
    Text = "4명의 혈육 깨어남체로 구성된 팀으로 임의의 난이도를 클리어"
  },
  Task_129523_Desc = {
    Text = "임의 난이도로 2명의 혈육과 2명의 초차원 깨어남체로 구성된 팀으로 클리어"
  },
  Task_129524_Desc = {
    Text = "3명의 심해와 1명의 혈육 깨어남체로 구성된 팀으로 어려움 또는 광기 난이도를 클리어"
  },
  Task_129525_Desc = {
    Text = "보통 난이도 첫 번째 단계 완료"
  },
  Task_129526_Desc = {
    Text = "2명의 혼돈과 2명의 혈육 깨어남체로 구성된 팀을 사용하여 임의의 난이도를 클리어합니다"
  },
  Task_129527_Desc = {
    Text = "혼돈 3명과 혈육 깨어남체 1명으로 구성된 팀으로 어려움 또는 광기 난이도 클리어"
  },
  Task_129528_Desc = {
    Text = "「여정의 추억·환희 회랑」 모든 태스크 완료"
  },
  Task_129529_Desc = {
    Text = "보통 난이도 세 번째 단계 완료"
  },
  Task_129530_Desc = {
    Text = "혼돈 3명과 깊은 바다에서 깨어난 깨어남체 1명으로 구성된 팀으로 어려움 또는 광기 난이도 클리어"
  },
  Task_129531_Desc = {
    Text = "임의 난이도에서 1단계 리더 「▼아▼▼야」를 격파"
  },
  Task_129532_Desc = {
    Text = "어려움 난이도 제2단계 완료"
  },
  Task_129533_Desc = {
    Text = "광기 난이도 첫 번째 단계 클리어"
  },
  Task_129534_Desc = {
    Text = "가는 길에 남긴 사진·과거의 회상"
  },
  Task_129534_Name = {
    Text = "가는 길에 남긴 사진·과거의 회상"
  },
  Task_129535_Desc = {
    Text = "임의 난이도에서 3단계 리더 「부패의 조수 꼭두각시」를 처치합니다."
  },
  Task_129536_Desc = {
    Text = "가는 길에 남긴 사진·환희 회랑"
  },
  Task_129536_Name = {
    Text = "가는 길에 남긴 사진·환희 회랑"
  },
  Task_129537_Desc = {
    Text = "임의 난이도에서 3단계 리더 「초원차원 @2 번데기」를 격파"
  },
  Task_129538_Desc = {
    Text = "2명의 심해와 2명의 혈육 깨어남체로 구성된 팀으로 임의의 난이도를 클리어"
  },
  Task_129539_Desc = {
    Text = "임의 난이도에서 두 번째 단계 리더 「풍성한 모나무」를 무찌르다"
  },
  Task_129540_Desc = {
    Text = "임의 난이도에서 첫 번째 단계 리더 「울보 조▼」를 격파하라"
  },
  Task_129541_Desc = {
    Text = "혼돈 2명과 깊은 바다에서 깨어난 깨어남체 2명으로 구성된 팀으로 임의의 난이도를 클리어하기"
  },
  Task_129542_Desc = {
    Text = "어려움 난이도 세 번째 단계 완료"
  },
  Task_129543_Desc = {
    Text = "임의 난이도에서의 첫 번째 단계 리더 「수▼▼」를 격파"
  },
  Task_129544_Desc = {
    Text = "3명의 심해와 1명의 초차원 깨어남체로 구성된 팀으로 어려움 또는 광기 난이도로 클리어"
  },
  Task_129545_Desc = {
    Text = "광기 난이도 두 번째 단계 완료"
  },
  Task_129546_Desc = {
    Text = "임의 난이도에서의 첫 번째 단계 리더 「차원을 관통하는 개」를 격파하라"
  },
  Task_129547_Desc = {
    Text = "임의 난이도에서 2단계 리더 「쌍생모순」을 처치하다"
  },
  Task_129548_Desc = {
    Text = "난이도 어려움 또는 광기 난이도로 1명의 심해와 3명의 혈육 깨어남체로 구성된 팀으로 클리어"
  },
  Task_129549_Desc = {
    Text = "혼돈 2명과 초차원 깨어남체 2명으로 구성된 팀으로 임의의 난이도를 클리어합니다"
  },
  Task_129550_Desc = {
    Text = "어려움 난이도 첫 번째 단계 완료"
  },
  Task_129551_Desc = {
    Text = "「열차 노선·보통」의 모든 임무를 완료"
  },
  Task_129552_Desc = {
    Text = "2명의 심해 깨어남체와 2명의 초차원 깨어남체로 구성된 팀으로 임의의 난이도를 클리어"
  },
  Task_129553_Desc = {
    Text = "열차 노선·보통"
  },
  Task_129553_Name = {
    Text = "열차 노선·보통"
  },
  Task_129554_Desc = {
    Text = "혼돈 1명과 혈육 깨어남체 3명으로 구성된 팀으로 어려움 또는 광기 난이도 클리어"
  },
  Task_129555_Desc = {
    Text = "혼돈 1명과 초차원 깨어남체 3명으로 구성된 팀으로 어려움 또는 광기 난이도를 클리어"
  },
  Task_129556_Desc = {
    Text = "4명의 심해 깨어남체로 구성된 팀을 사용하여 임의의 난이도를 클리어"
  },
  Task_129557_Desc = {
    Text = "혼돈 1명과 심해 깨어남체 3명으로 구성된 팀으로 어려움 또는 광기 난이도로 클리어"
  },
  Task_129558_Desc = {
    Text = "1명의 심해와 3명의 초차원 깨어남체로 구성된 팀으로 어려움 또는 광기 난이도를 클리어"
  },
  Task_129559_Desc = {
    Text = "4명의 카오스 깨어남체로 구성된 팀을 사용하여 임의의 난이도를 클리어합니다"
  },
  Task_129560_Desc = {
    Text = "완료 「여정의 추억·회상」 모든 태스크"
  },
  Task_129561_Desc = {
    Text = "임의 난이도에서 두 번째 단계 보스 「성아」 처치"
  },
  Task_129895_Desc = {
    Text = "특파대 기록“기도의 해를 향한 기차”"
  },
  Task_129895_Name = {
    Text = "폭죽 소리 속에서 한 해가 저물다"
  },
  Task_130180_Desc = {
    Text = "다차원 연결 「잊혀진 사랑의 씨앗」 클리어"
  },
  Task_130181_Desc = {
    Text = "「마지막 한 잔」 광기 난이도 클리어"
  },
  Task_130182_Desc = {
    Text = "「식탁」 임의 난이도 클리어"
  },
  Task_130183_Desc = {
    Text = "심해 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_130184_Desc = {
    Text = "혈육 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_130185_Desc = {
    Text = "「학교」 임의 난이도 클리어"
  },
  Task_130186_Desc = {
    Text = "「병원」 아무 난이도 클리어"
  },
  Task_130187_Desc = {
    Text = "「마지막 한 잔」 임의 난이도 클리어"
  },
  Task_130188_Desc = {
    Text = "「병원」 광기 난이도 클리어"
  },
  Task_130189_Desc = {
    Text = "혼돈 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_130190_Desc = {
    Text = "혈육 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_130191_Desc = {
    Text = "「우물」 광기 난이도 클리어"
  },
  Task_130192_Desc = {
    Text = "초차원 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_130193_Desc = {
    Text = "「학교」 광기 난이도 클리어"
  },
  Task_130194_Desc = {
    Text = "「식탁」 임의 난이도 클리어"
  },
  Task_130195_Desc = {
    Text = "「집」 아무 난이도 클리어"
  },
  Task_130196_Desc = {
    Text = "「마지막 한 잔」 임의 난이도 클리어"
  },
  Task_130197_Desc = {
    Text = "「뇌 손상」 임의 난이도 클리어"
  },
  Task_130198_Desc = {
    Text = "심해 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_130199_Desc = {
    Text = "「뇌 손상」 임의 난이도 클리어"
  },
  Task_130200_Desc = {
    Text = "「우물」 임의 난이도 클리어"
  },
  Task_130201_Desc = {
    Text = "「집」 아무 난이도 클리어"
  },
  Task_130202_Desc = {
    Text = "「학교」 임의 난이도 클리어"
  },
  Task_130203_Desc = {
    Text = "「병원」 아무 난이도 클리어"
  },
  Task_130204_Desc = {
    Text = "「우물」 임의 난이도 클리어"
  },
  Task_130205_Desc = {
    Text = "뒤바뀐 새 삶·광기"
  },
  Task_130206_Desc = {
    Text = "「집」 광기 난이도 클리어"
  },
  Task_130207_Desc = {
    Text = "「뇌 손상」 광기 난이도 클리어"
  },
  Task_130208_Desc = {
    Text = "뒤바뀐 새 삶·계역"
  },
  Task_130209_Desc = {
    Text = "「뒤집힌 새 생명·클리어」 모든 업적 완료"
  },
  Task_130210_Desc = {
    Text = "뒤바뀐 새 삶·클리어"
  },
  Task_130211_Desc = {
    Text = "초차원 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_130212_Desc = {
    Text = "「식탁」 광기 난이도 클리어"
  },
  Task_130213_Desc = {
    Text = "혼돈 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_130412_Desc = {
    Text = "본원 오지에를 획득할 때 기령 2"
  },
  Task_130412_Name = {
    Text = "본원 오지에를 획득할 때 기령 2"
  },
  Task_130412_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 오지에 기령 패키지 2 이벤트"
  },
  Task_130413_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130414_Desc = {
    Text = "사야 획득 시 기령 2"
  },
  Task_130414_Name = {
    Text = "사야 획득 시 기령 2"
  },
  Task_130414_UnlockCondDesc = {
    Text = "이벤트@깨어남체 샤예 기령 패키지 2 이벤트"
  },
  Task_130416_Desc = {
    Text = "샤예 획득 시 기령 6"
  },
  Task_130416_Name = {
    Text = "샤예 획득 시 기령 6"
  },
  Task_130416_UnlockCondDesc = {
    Text = "이벤트@깨어남체 샤예 기령 패키지 2 이벤트"
  },
  Task_130417_Desc = {
    Text = "사토구야를 획득할 때 기령 2"
  },
  Task_130417_Name = {
    Text = "사토구야를 획득할 때 기령 2"
  },
  Task_130417_UnlockCondDesc = {
    Text = "이벤트@깨어남체 사토구아 기령 패키지 2 이벤트"
  },
  Task_130418_Desc = {
    Text = "사토구아를 획득할 때 기령 6"
  },
  Task_130418_Name = {
    Text = "사토구아를 획득할 때 기령 6"
  },
  Task_130418_UnlockCondDesc = {
    Text = "이벤트@깨어남체 사토구아 기령 패키지 2 이벤트"
  },
  Task_130420_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130421_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130424_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130425_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130427_Desc = {
    Text = "본원 오지에를 획득할 때 기령 6"
  },
  Task_130427_Name = {
    Text = "본원 오지에를 획득할 때 기령 6"
  },
  Task_130427_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 오지에 기령 패키지 2 이벤트"
  },
  Task_130429_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130440_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130441_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130442_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130446_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130447_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130448_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130459_Desc = {
    Text = "본원 오지에 동조율이 10레벨에 도달했습니다"
  },
  Task_130460_Desc = {
    Text = "사토구야 동조율이 10레벨에 도달했습니다"
  },
  Task_130461_Desc = {
    Text = "사야 동조율이 10단계에 도달했습니다"
  },
  Task_130555_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_130555_Name = {Text = "3승"},
  Task_130556_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_130556_Name = {Text = "10승"},
  Task_130557_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_130557_Name = {Text = "1승"},
  Task_130558_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_130558_Name = {Text = "6승"},
  Task_130950_Desc = {
    Text = "클리어 「대·소용돌이」 광기 난이도"
  },
  Task_130951_Desc = {
    Text = "클리어 「평범한 매일」 광기 난이도"
  },
  Task_130952_Desc = {
    Text = "클리어 「우레의 폭풍」 임의 난이도"
  },
  Task_130953_Desc = {
    Text = "클리어 「동반 발견」 광기 난이도"
  },
  Task_130954_Desc = {
    Text = "모스크와 바다·경계역"
  },
  Task_130956_Desc = {
    Text = "「모스크와 바다·클리어」 모든 성취를 완료하다"
  },
  Task_130957_Desc = {
    Text = "클리어 「대·소용돌이」 임의 난이도"
  },
  Task_130958_Desc = {
    Text = "모스크를 획득할 때 기령 6"
  },
  Task_130958_Name = {
    Text = "모스크를 획득할 때 기령 6"
  },
  Task_130958_UnlockCondDesc = {
    Text = "이벤트@깨어남체 모스크 기령 패키지 2"
  },
  Task_130959_Desc = {
    Text = "클리어 「대·소용돌이」 임의 난이도"
  },
  Task_130960_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130961_Desc = {
    Text = "Mosk와 바다·클리어"
  },
  Task_130962_Desc = {
    Text = "클리어 「귀환의 길」 임의 난이도"
  },
  Task_130963_Desc = {
    Text = "클리어 의식 잠수 「중독」"
  },
  Task_130964_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「모스크와 바다」에서 2번 승리하기"
  },
  Task_130965_Desc = {
    Text = "클리어 「평범한 매일」 어떤 난이도든"
  },
  Task_130966_Desc = {
    Text = "클리어 「출해 순간」 모든 난이도"
  },
  Task_130967_Desc = {
    Text = "클리어 「귀환의 길」 임의 난이도"
  },
  Task_130968_Desc = {
    Text = "클리어 「동반 발견」 임의 난이도"
  },
  Task_130970_Desc = {
    Text = "모스크를 획득할 때 기령 2"
  },
  Task_130970_Name = {
    Text = "모스크를 획득할 때 기령 2"
  },
  Task_130970_UnlockCondDesc = {
    Text = "이벤트@깨어남체 모스크 기령 패키지 2"
  },
  Task_130971_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「모스크와 바다」에서 1회 승리"
  },
  Task_130972_Desc = {
    Text = "클리어 「우레의 폭풍」 임의 난이도"
  },
  Task_130973_Desc = {
    Text = "클리어 「떠내려가는 보물」 광기 난이도"
  },
  Task_130974_Desc = {
    Text = "클리어 「출해의 순간」 광기 난이도"
  },
  Task_130975_Desc = {
    Text = "모스크 동조율이 10급에 도달했습니다"
  },
  Task_130976_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130977_Desc = {
    Text = "클리어 「동반 발견」 임의 난이도"
  },
  Task_130978_Desc = {
    Text = "심해 영역의 깨어남체로 「모스크와 바다」에서 1회 승리"
  },
  Task_130979_Desc = {
    Text = "클리어 「우레와 같은 폭풍」 광기 난이도"
  },
  Task_130980_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「모스크와 바다」에서 1회 승리"
  },
  Task_130981_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130982_Desc = {
    Text = "클리어 「귀환의 길」 광기 난이도"
  },
  Task_130983_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「모스크와 바다」에서 2번 승리했습니다"
  },
  Task_130984_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_130985_Desc = {
    Text = "클리어 「출해 순간」 모든 난이도"
  },
  Task_130986_Desc = {
    Text = "심해 영역의 깨어남체로 「모스크와 바다」에서 2회 승리"
  },
  Task_130987_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「모스크와 바다」에서 2번 승리하세요"
  },
  Task_130988_Desc = {
    Text = "클리어 「표류하는 보물」 아무 난이도"
  },
  Task_130989_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「모스크와 바다」에서 1회 승리했습니다"
  },
  Task_130990_Desc = {
    Text = "클리어 「평범한 매일」 어떤 난이도든"
  },
  Task_130991_Desc = {
    Text = "클리어 「표류하는 보물」 아무 난이도"
  },
  Task_130992_Desc = {
    Text = "모스크와 바다·광기"
  },
  Task_131106_Desc = {
    Text = "네프레아를 막다"
  },
  Task_131106_Name = {Text = "목표"},
  Task_131172_Desc = {
    Text = "공명명로·기간 한정 전용"
  },
  Task_131371_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_131372_Desc = {
    Text = "누적 깨어남 30회"
  },
  Task_131373_Desc = {
    Text = "누적 깨어남 30회"
  },
  Task_131374_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_131375_Desc = {
    Text = "1주 동안 모든 주간 시련 임무 완료"
  },
  Task_131376_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_131377_Desc = {
    Text = "파견 20회 완료"
  },
  Task_131378_Desc = {
    Text = "1주 동안 모든 주간 시련 임무 완료"
  },
  Task_131379_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_131380_Desc = {
    Text = "파견 20회 완료"
  },
  Task_131381_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_131382_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_131383_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_131384_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_131385_Desc = {
    Text = "1회의 라이커 데모 스테이지 클리어"
  },
  Task_131386_Desc = {
    Text = "1회의 라이커 데모 스테이지 클리어"
  },
  Task_131450_Desc = {
    Text = "페이즈 대결에서 60명의 깨어남체를 물리치세요"
  },
  Task_131451_Desc = {
    Text = "페이즈 대결에서 36명의 깨어남체를 물리치세요"
  },
  Task_131452_Desc = {
    Text = "예상 팀 모드에서 10경기 승리하기"
  },
  Task_131453_Desc = {
    Text = "페이즈 대결에서 카드를 740번 내다"
  },
  Task_131454_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 108회 발동"
  },
  Task_131455_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 192회 사용"
  },
  Task_131456_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 60회 발동"
  },
  Task_131457_Desc = {
    Text = "페이즈 대결에서 111명의 깨어남체를 물리치다"
  },
  Task_131458_Desc = {
    Text = "상위 대결에서 카드 300장 내기"
  },
  Task_131459_Desc = {
    Text = "페이즈 대결에서 480번 카드 내기"
  },
  Task_131460_Desc = {
    Text = "페이즈 대결에서 카드를 320번 내기"
  },
  Task_131461_Desc = {
    Text = "페이즈 대결에서 6명의 깨어남체를 물리치세요"
  },
  Task_131462_Desc = {
    Text = "페이즈 대결에서 129명의 깨어남체를 처치"
  },
  Task_131463_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 102회 발동"
  },
  Task_131464_Desc = {
    Text = "페이즈 대결에서 100번 카드 내기"
  },
  Task_131465_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 66회 발동"
  },
  Task_131466_Desc = {
    Text = "페이즈 대결에서 12명의 깨어남체를 물리치세요"
  },
  Task_131467_Desc = {
    Text = "페이즈 대결에서 누적 45승"
  },
  Task_131468_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 54회 사용"
  },
  Task_131469_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 240회 발동"
  },
  Task_131470_Desc = {
    Text = "페이즈 대결에서 99명의 깨어남체를 처치"
  },
  Task_131471_Desc = {
    Text = "페이즈 대결에서 87명의 깨어남체를 처치합니다"
  },
  Task_131472_Desc = {
    Text = "회전 선택 모드에서 다시 한 판을 하고 상대방 1번을 격파하세요"
  },
  Task_131473_Desc = {
    Text = "페이즈 대결에서 30명의 깨어남체를 물리치세요"
  },
  Task_131474_Desc = {
    Text = "예상 팀 모드에서 연속 승리 두 번 1회"
  },
  Task_131475_Desc = {
    Text = "회전 선택 모드에서 2번 승리 획득"
  },
  Task_131476_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 156회 사용"
  },
  Task_131477_Desc = {
    Text = "회전 선택 모드에서 6번의 승리를 획득하다"
  },
  Task_131478_Desc = {
    Text = "페이즈 대결에서 카드를 160번 내다"
  },
  Task_131479_Desc = {
    Text = "페이즈 대결에서 135명의 깨어남체를 처치"
  },
  Task_131480_Desc = {
    Text = "페이즈 대결에서 카드를 880번 내기"
  },
  Task_131481_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 132회 발동"
  },
  Task_131482_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 204회 발동"
  },
  Task_131483_Desc = {
    Text = "예상 팀 모드에서 4회 승리 획득"
  },
  Task_131484_Desc = {
    Text = "페이즈 대결에서 광기 폭발 144회 발동"
  },
  Task_131485_Desc = {
    Text = "페이즈 대결에서 카드 240번 내기"
  },
  Task_131486_Desc = {
    Text = "페이즈 대결에서 940번 카드를 내다"
  },
  Task_131487_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 210번 발동"
  },
  Task_131488_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 174회 발동"
  },
  Task_131489_Desc = {
    Text = "페이즈 대결에서 54명의 깨어남체를 물리치세요"
  },
  Task_131490_Desc = {
    Text = "페이즈 대결에서 21명의 깨어남체를 물리치세요"
  },
  Task_131491_Desc = {
    Text = "페이즈 대결에서 카드 내기 180회"
  },
  Task_131492_Desc = {
    Text = "영예 훈의 시련"
  },
  Task_131493_Desc = {
    Text = "페이즈 대결에서 400번 카드 내기"
  },
  Task_131494_Desc = {
    Text = "페이즈 대결에서 57명의 깨어남체를 물리치세요"
  },
  Task_131495_Desc = {
    Text = "회전 선택 모드에서 8번 승리하기"
  },
  Task_131496_Desc = {
    Text = "페이즈 대결에서 81명의 깨어남체를 처치하세요"
  },
  Task_131497_Desc = {
    Text = "페이즈 대결에서 93명의 깨어남체를 처치하다"
  },
  Task_131498_Desc = {
    Text = "페이즈 대결에서 120명의 깨어남체를 물리치다"
  },
  Task_131499_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 30회 발동합니다"
  },
  Task_131500_Desc = {
    Text = "페이즈 대결에서 카드를 220번 내다"
  },
  Task_131501_Desc = {
    Text = "페이즈 대결에서 광기 폭발 264회 사용"
  },
  Task_131502_Desc = {
    Text = "페이즈 대결에서 102명의 깨어남체를 물리치다"
  },
  Task_131503_Desc = {
    Text = "페이즈 대결에서 카드 140번 내다"
  },
  Task_131504_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 96회 발동"
  },
  Task_131505_Desc = {
    Text = "예상 팀 모드에서 다시 한 판을 진행하고 상대방을 1번 이기세요"
  },
  Task_131506_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 78회 발동"
  },
  Task_131507_Desc = {
    Text = "페이즈 대결에서 카드 1000번 내기"
  },
  Task_131508_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 90회 사용"
  },
  Task_131509_Desc = {
    Text = "페이즈 대결에서 132명의 깨어남체를 처치"
  },
  Task_131510_Desc = {
    Text = "페이즈 대결에서 126명의 깨어남체를 물리치다"
  },
  Task_131511_Desc = {
    Text = "페이즈 대결에서 9명의 깨어남체를 물리치다"
  },
  Task_131512_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 168회 사용"
  },
  Task_131513_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 162회 발동"
  },
  Task_131514_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 222회 사용"
  },
  Task_131515_Desc = {
    Text = "임계 시련"
  },
  Task_131516_Desc = {
    Text = "페이즈 대결에서 380번 카드 내기"
  },
  Task_131517_Desc = {
    Text = "페이즈 대결에서 660번 카드 내기"
  },
  Task_131518_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 114회 발동"
  },
  Task_131519_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 120회 발동"
  },
  Task_131520_Desc = {
    Text = "페이즈 대결에서 144명의 깨어남체를 물리치세요"
  },
  Task_131521_Desc = {
    Text = "페이즈 대결에서 24명의 깨어남체를 처치하세요"
  },
  Task_131522_Desc = {
    Text = "페이즈 대결에서 42명의 깨어남체를 처치하세요"
  },
  Task_131523_Desc = {
    Text = "페이즈 대결에서 카드 460번 내기"
  },
  Task_131524_Desc = {
    Text = "페이즈 대결에서 광기 폭발 180회 사용"
  },
  Task_131525_Desc = {
    Text = "페이즈 대결에서 520번 카드 내기"
  },
  Task_131526_Desc = {
    Text = "페이즈 대결에서 카드 840번 내기"
  },
  Task_131527_Desc = {
    Text = "페이즈 대결에서 69명의 깨어남체를 물리치세요"
  },
  Task_131528_Desc = {
    Text = "페이즈 대결에서 720번 카드를 내다"
  },
  Task_131529_Desc = {
    Text = "페이즈 대결에서 33명의 깨어남체를 물리치세요"
  },
  Task_131530_Desc = {
    Text = "페이즈 대결에서 39명의 깨어남체를 물리치세요"
  },
  Task_131531_Desc = {
    Text = "페이즈 대결에서 860번 카드를 내다"
  },
  Task_131532_Desc = {
    Text = "페이즈 대결에서 560번 카드 내기"
  },
  Task_131533_Desc = {
    Text = "페이즈 대결에서 600번 카드 내기"
  },
  Task_131534_Desc = {
    Text = "페이즈 대결에서 프로필 사진을 클릭하여 3명의 상대방에게 임의의 표정을 보내세요"
  },
  Task_131535_Desc = {
    Text = "페이즈 대결에서 66명의 깨어남체를 처치하세요"
  },
  Task_131536_Desc = {
    Text = "페이즈 대결에서 카드를 200번 내기"
  },
  Task_131537_Desc = {
    Text = "회전 선택 모드에서 1번 승리 획득"
  },
  Task_131538_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 234회 사용"
  },
  Task_131539_Desc = {
    Text = "페이즈 대결에서 820번 카드를 내다"
  },
  Task_131540_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 18회 발동"
  },
  Task_131541_Desc = {
    Text = "페이즈 대결에서 63명의 깨어남체를 물리치세요"
  },
  Task_131542_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 258회 사용"
  },
  Task_131543_Desc = {
    Text = "상대방에게 1회 칭찬하기 (페이즈 대결 전투 종료 후)"
  },
  Task_131544_Desc = {
    Text = "페이즈 대결에서 누적 25승을 달성하다"
  },
  Task_131545_Desc = {
    Text = "페이즈 대결에서 27명의 깨어남체를 처치하세요"
  },
  Task_131546_Desc = {
    Text = "페이즈 대결에서 18명의 깨어남체를 물리치세요"
  },
  Task_131547_Desc = {
    Text = "페이즈 대결에서 150명의 깨어남체를 처치"
  },
  Task_131548_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 48회 사용"
  },
  Task_131549_Desc = {
    Text = "페이즈 대결에서 카드 20번 내기"
  },
  Task_131550_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 36회 사용"
  },
  Task_131551_Desc = {
    Text = "페이즈 대결에서 15명의 깨어남체를 처치"
  },
  Task_131552_Desc = {
    Text = "페이즈 대결에서 84명의 깨어남체를 처치하세요"
  },
  Task_131553_Desc = {
    Text = "페이즈 대결에서 280번 카드 내기"
  },
  Task_131554_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 72회 사용"
  },
  Task_131555_Desc = {
    Text = "페이즈 대결에서 108명의 깨어남체를 물리치다"
  },
  Task_131556_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 246회 사용"
  },
  Task_131557_Desc = {
    Text = "페이즈 대결에서 700번 출카드하기"
  },
  Task_131558_Desc = {
    Text = "페이즈 대결에서 누적 35승 달성"
  },
  Task_131559_Desc = {
    Text = "페이즈 대결에서 누적 50승을 달성"
  },
  Task_131560_Desc = {
    Text = "페이즈 대결에서 3명의 깨어남체를 처치하세요"
  },
  Task_131561_Desc = {
    Text = "페이즈 대결에서 75명의 깨어남체를 처치"
  },
  Task_131562_Desc = {
    Text = "페이즈 대결에서 51명의 깨어남체를 처치하세요"
  },
  Task_131563_Desc = {
    Text = "페이즈 대결에서 카드 120번 내기"
  },
  Task_131564_Desc = {
    Text = "페이즈 대결에서 78명의 깨어남체를 물리치다"
  },
  Task_131565_Desc = {
    Text = "페이즈 대결에서 138명의 깨어남체를 물리치세요"
  },
  Task_131566_Desc = {
    Text = "페이즈 대결에서 90명의 깨어남체를 처치"
  },
  Task_131567_Desc = {
    Text = "비의 시련"
  },
  Task_131568_Desc = {
    Text = "예상 팀 모드에서 6번의 승리를 획득하다"
  },
  Task_131569_Desc = {
    Text = "예상 팀 모드에서 8번 승리하기"
  },
  Task_131570_Desc = {
    Text = "페이즈 대결에서 117명의 깨어남체를 물리치세요"
  },
  Task_131571_Desc = {
    Text = "페이즈 대결에서 누적 40승 달성"
  },
  Task_131572_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 126회 발동"
  },
  Task_131573_Desc = {
    Text = "페이즈 대결에서 760번 카드 내기"
  },
  Task_131574_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 270회 발동"
  },
  Task_131575_Desc = {
    Text = "예상 팀 모드에서 1승을 획득"
  },
  Task_131576_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 84회 발동"
  },
  Task_131577_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 294회 발동"
  },
  Task_131578_Desc = {
    Text = "페이즈 대결에서 누적 30승 달성"
  },
  Task_131579_Desc = {
    Text = "페이즈 대결에서 카드를 960번 내기"
  },
  Task_131580_Desc = {
    Text = "페이즈 대결에서 카드 260번 내기"
  },
  Task_131581_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 42회 사용"
  },
  Task_131582_Desc = {
    Text = "페이즈 대결에서 96명의 깨어남체를 물리치세요"
  },
  Task_131583_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 228회 사용"
  },
  Task_131584_Desc = {
    Text = "페이즈 대결에서 카드 40번 내기"
  },
  Task_131585_Desc = {
    Text = "페이즈 대결에서 카드를 800번 내기"
  },
  Task_131586_Desc = {
    Text = "페이즈 대결에서 580번 카드를 내기"
  },
  Task_131587_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 150회 발동"
  },
  Task_131588_Desc = {
    Text = "페이즈 대결에서 114명의 깨어남체를 물리치세요"
  },
  Task_131589_Desc = {
    Text = "페이즈 대결에서 780번 카드 내기"
  },
  Task_131590_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 24회 사용"
  },
  Task_131591_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 216회 사용"
  },
  Task_131592_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 276회 발동"
  },
  Task_131593_Desc = {
    Text = "페이즈 대결에서 카드 500번 내기"
  },
  Task_131594_Desc = {
    Text = "페이즈 대결에서 147명의 깨어남체를 물리치다"
  },
  Task_131595_Desc = {
    Text = "예상 팀 모드에서 2번 승리 획득"
  },
  Task_131596_Desc = {
    Text = "페이즈 대결에서 72명의 깨어남체를 물리치세요"
  },
  Task_131597_Desc = {
    Text = "페이즈 대결에서 카드를 640번 내기"
  },
  Task_131598_Desc = {
    Text = "페이즈 대결에서 105명의 깨어남체를 물리치다"
  },
  Task_131599_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 300회 발동"
  },
  Task_131600_Desc = {
    Text = "페이즈 대결에서 48명의 깨어남체를 물리치세요"
  },
  Task_131601_Desc = {
    Text = "페이즈 대결에서 920번 카드를 내다"
  },
  Task_131602_Desc = {
    Text = "페이즈 대결에서 60번 카드를 냄"
  },
  Task_131603_Desc = {
    Text = "페이즈 대결에서 카드를 360번 내기"
  },
  Task_131604_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 282회 발동"
  },
  Task_131605_Desc = {
    Text = "페이즈 대결에서 카드를 440번 내기"
  },
  Task_131606_Desc = {
    Text = "페이즈 대결에서 123명의 깨어남체를 격파하다"
  },
  Task_131607_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 198회 사용"
  },
  Task_131608_Desc = {
    Text = "페이즈 대결에서 카드를 680번 내기"
  },
  Task_131609_Desc = {
    Text = "페이즈 대결에서 45명의 깨어남체를 물리치세요"
  },
  Task_131610_Desc = {
    Text = "회전 선택 모드에서 연속으로 2번 승리하기 2회"
  },
  Task_131611_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 186회 발동"
  },
  Task_131612_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 6회 발동"
  },
  Task_131613_Desc = {
    Text = "페이즈 대결에서 620번 카드를 내기"
  },
  Task_131614_Desc = {
    Text = "회전 선택 모드에서 연속으로 2번 승리 1회"
  },
  Task_131615_Desc = {
    Text = "페이즈 대결에서 카드를 900번 내기"
  },
  Task_131616_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 252회 발동"
  },
  Task_131617_Desc = {
    Text = "페이즈 대결에서 카드를 980번 내기"
  },
  Task_131618_Desc = {
    Text = "페이즈 대결에서 141명의 깨어남체를 처치"
  },
  Task_131619_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 288회 사용"
  },
  Task_131620_Desc = {
    Text = "페이즈 대결에서 420번 카드 내기"
  },
  Task_131621_Desc = {
    Text = "회전 선택 모드에서 10경기 승리하기"
  },
  Task_131622_Desc = {
    Text = "페이즈 대결에서 카드 340번 내기"
  },
  Task_131623_Desc = {
    Text = "회전 선택 모드에서 4회 승리 획득"
  },
  Task_131624_Desc = {
    Text = "페이즈 대결에서 80번 카드 내기"
  },
  Task_131625_Desc = {
    Text = "예상 팀 모드에서 연속으로 2회 승리 2회"
  },
  Task_131626_Desc = {
    Text = "페이즈 대결에서 카드를 540번 내다"
  },
  Task_131627_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 138회 발동"
  },
  Task_131628_Desc = {
    Text = "페이즈 대결에서 광기 폭발을 12회 발동"
  },
  Task_131768_Desc = {
    Text = "의식 잠수“중독”"
  },
  Task_131768_Name = {Text = "지!"},
  Task_131801_Name = {
    Text = "턴 역전 복제 이벤트 끝"
  },
  Task_131891_Desc = {
    Text = "영원한 기억·기간 한정 전용"
  },
  Task_131892_Desc = {
    Text = "영원한 기억Ⅴ"
  },
  Task_131893_Desc = {
    Text = "영원한 기억Ⅶ"
  },
  Task_131894_Desc = {
    Text = "영원한 기억Ⅱ"
  },
  Task_131895_Desc = {
    Text = "영원한 기억Ⅰ"
  },
  Task_131896_Desc = {
    Text = "영원한 기억·무료"
  },
  Task_131897_Desc = {
    Text = "영원한 기억Ⅲ"
  },
  Task_131898_Desc = {
    Text = "영원한 기억Ⅳ"
  },
  Task_131899_Desc = {
    Text = "영원한 기억Ⅵ"
  },
  Task_132335_Desc = {
    Text = "클리어 의식 잠수 「가관의 날」"
  },
  Task_132454_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_132454_Name = {Text = "10승"},
  Task_132455_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_132455_Name = {Text = "3승"},
  Task_132456_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_132456_Name = {Text = "6승"},
  Task_132457_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_132457_Name = {Text = "1승"},
  Task_132689_Desc = {
    Text = "PC 환경에서 로그인하기"
  },
  Task_132690_Desc = {
    Text = "모바일 환경에서 원액 1회 추출하기"
  },
  Task_132691_Desc = {
    Text = "PC 환경에서 원액 1회 추출하기"
  },
  Task_132692_Desc = {
    Text = "모바일 환경에서 로그인하기"
  },
  Task_132874_Desc = {
    Text = "이번 시즌 3단계 보스 1회 격파"
  },
  Task_132875_Desc = {
    Text = "이번 시즌 5회 승리"
  },
  Task_132876_Desc = {
    Text = "이번 시즌 5회 승리"
  },
  Task_132877_Desc = {
    Text = "이번 시즌 「환몽 심잠」 3회 클리어"
  },
  Task_132909_Desc = {
    Text = "클리어 1 회 아라크네 체험 단계"
  },
  Task_132910_Desc = {
    Text = "파견 15회 완료"
  },
  Task_132911_Desc = {
    Text = "임의 시즌 임무 1개 완료"
  },
  Task_132912_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_132913_Desc = {
    Text = "임의 시즌 임무 1개 완료"
  },
  Task_132914_Desc = {
    Text = "깨어남 30회"
  },
  Task_132915_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_132916_Desc = {
    Text = "클리어 1 회 아라크네 체험 단계"
  },
  Task_132917_Desc = {
    Text = "파견 15회 완료"
  },
  Task_132918_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_132919_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_132920_Desc = {
    Text = "주간 활성도 1000 달성"
  },
  Task_132921_Desc = {
    Text = "주간 활성도 1000 달성"
  },
  Task_132922_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_132923_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_132924_Desc = {
    Text = "깨어남 30회"
  },
  Task_132928_Desc = {
    Text = "모든 작업을 완료하였습니다"
  },
  Task_132929_Desc = {
    Text = "메노핀 1800 점 소모"
  },
  Task_132930_Desc = {
    Text = "1주 동안 모든 주간 시험 임무를 완료하세요"
  },
  Task_132931_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_132932_Desc = {
    Text = "완료 20 회 파견"
  },
  Task_132933_Desc = {
    Text = "융재 디-이펙트 존 훈련 포인트가 100에 도달했습니다"
  },
  Task_133297_Desc = {
    Text = "이몽 시계 「주방 정복기」 완료"
  },
  Task_133297_Name = {
    Text = "환희! 진노! 낙루!"
  },
  Task_133302_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_133303_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_133304_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_133305_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_133306_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_133307_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_133308_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_133309_Desc = {
    Text = "깨어남 30회"
  },
  Task_133310_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_133311_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_133312_Desc = {
    Text = "깨어남 30회"
  },
  Task_133313_Desc = {
    Text = "파견 15회 완료"
  },
  Task_133314_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_133315_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_133316_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_133317_Desc = {
    Text = "파견 15회 완료"
  },
  Task_133940_Desc = {
    Text = "동문에게 좋아요 1회 누르기"
  },
  Task_133940_Name = {
    Text = "친구에게 좋아요 보내기"
  },
  Task_133941_Desc = {
    Text = "180 린피테이프 소모하기"
  },
  Task_133941_Name = {
    Text = "린피테이프 소모"
  },
  Task_133943_Desc = {
    Text = "카드 50장 사용"
  },
  Task_133943_Name = {
    Text = "일일 훈련"
  },
  Task_133944_Desc = {
    Text = "파견을 3 회 실타래행"
  },
  Task_133944_Name = {
    Text = "임무 진행"
  },
  Task_133945_Desc = {
    Text = "밀계 전사 50회 완료"
  },
  Task_133945_Name = {
    Text = "미스틱 트랜스크립트"
  },
  Task_133946_Desc = {
    Text = "초월적 존재 1회 클리어"
  },
  Task_133946_Name = {
    Text = "주간 보스"
  },
  Task_133947_Desc = {
    Text = "깨어남 의식 30회 진행"
  },
  Task_133947_Name = {Text = "뽑기"},
  Task_133948_Desc = {
    Text = "영페닌 1500 소모"
  },
  Task_133948_Name = {
    Text = "린피테이프 소모"
  },
  Task_133949_Desc = {
    Text = "장미 금권 100만 소모"
  },
  Task_133949_Name = {
    Text = "돈을 물처럼 쓰다"
  },
  Task_134074_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_134074_Desc2 = {
    Text = "조사 사건 \"운명 극장\""
  },
  Task_134074_Name2 = {
    Text = "운명의 주연"
  },
  Task_134075_Desc = {
    Text = "조사 사건 \"운명 극장\" 어려움 난이도"
  },
  Task_134075_Name = {
    Text = "운명의 주연·어려움"
  },
  Task_134095_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_134095_Desc2 = {
    Text = "조사 사건 \"운명 극장\"에서 공명 3회"
  },
  Task_134095_Name2 = {
    Text = "의종 회향"
  },
  Task_134096_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 10회"
  },
  Task_134096_Desc2 = {
    Text = "조사 사건 \"운명 극장\"에서 공명 10회"
  },
  Task_134096_Name2 = {
    Text = "의종 회향Ⅳ"
  },
  Task_134097_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 9번"
  },
  Task_134097_Desc2 = {
    Text = "조사 사건 \"운명 극장\"에서 공명 9회"
  },
  Task_134097_Name2 = {
    Text = "의종 회향Ⅲ"
  },
  Task_134098_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_134098_Desc2 = {
    Text = "조사 사건 \"운명 극장\"에서 공명 6회"
  },
  Task_134098_Name2 = {
    Text = "의종 회향Ⅱ"
  },
  Task_134099_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_134099_Name = {
    Text = "완벽한 통과"
  },
  Task_134121_Desc = {
    Text = "카라브 인격 심화 12 달성"
  },
  Task_134122_Desc = {
    Text = "케이케스 인격 심화 12 달성"
  },
  Task_134123_Desc = {
    Text = "파로스 인격 심화 12 달성"
  },
  Task_134124_Desc = {
    Text = "모샤 인격 심화 12 달성"
  },
  Task_134125_Desc = {
    Text = "사야 인격 심화 12 달성"
  },
  Task_134126_Desc = {
    Text = "차토구아 인격 심화 12 달성"
  },
  Task_134127_Desc = {
    Text = "타이이스 인격 심화 12 달성"
  },
  Task_134128_Desc = {
    Text = "본원 잠자는 군주 인격 심화 12 달성"
  },
  Task_134129_Desc = {
    Text = "시로 인격 심화 12 달성"
  },
  Task_134130_Desc = {
    Text = "타비 인격 심화 12 달성"
  },
  Task_134131_Desc = {
    Text = "폴뤼케스 인격 심화 12 달성"
  },
  Task_134132_Desc = {
    Text = "「24」 인격 심화 12 달성"
  },
  Task_134134_Desc = {
    Text = "유우하시 인격 심화 12 달성"
  },
  Task_134135_Desc = {
    Text = "탄망·머피 인격 심화 12 달성"
  },
  Task_134136_Desc = {
    Text = "용훼·도르 인격 심화 12 달성"
  },
  Task_134137_Desc = {
    Text = "픽맨 인격 심화 12 달성"
  },
  Task_134138_Desc = {
    Text = "판디아 인격 심화 12 달성"
  },
  Task_134140_Desc = {
    Text = "오를라 인격 심화 12 달성"
  },
  Task_134141_Desc = {
    Text = "쉬 인격 심화 12 달성"
  },
  Task_134142_Desc = {
    Text = "틴크트 인격 심화 12 달성"
  },
  Task_134143_Desc = {
    Text = "카티굴라 인격 심화 12 달성"
  },
  Task_134144_Desc = {
    Text = "레아 인격 심화 12 달성"
  },
  Task_134145_Desc = {
    Text = "머피 인격 심화 12 달성"
  },
  Task_134146_Desc = {
    Text = "둘세인 인격 심화 12 달성"
  },
  Task_134148_Desc = {
    Text = "코퍼산트 인격 심화 12 달성"
  },
  Task_134149_Desc = {
    Text = "릴리 인격 심화 12 달성"
  },
  Task_134150_Desc = {
    Text = "혈쇄·시로 인격 심화 12 달성"
  },
  Task_134151_Desc = {
    Text = "윈코르 인격 심화 12 달성"
  },
  Task_134152_Desc = {
    Text = "하멜린 인격 심화 12 달성"
  },
  Task_134153_Desc = {
    Text = "라이크 인격 심화 12 달성"
  },
  Task_134154_Desc = {
    Text = "산 인격 심화 12 달성"
  },
  Task_134155_Desc = {
    Text = "카시아 인격 심화 12 달성"
  },
  Task_134156_Desc = {
    Text = "카스토르 인격 심화 12 달성"
  },
  Task_134157_Desc = {
    Text = "모스 인격 심화 12 달성"
  },
  Task_134158_Desc = {
    Text = "페인트 인격 심화 12 달성"
  },
  Task_134159_Desc = {
    Text = "노디라 인격 심화 12 달성"
  },
  Task_134160_Desc = {
    Text = "아그리파 인격 심화 12 달성"
  },
  Task_134161_Desc = {
    Text = "젠킨 인격 심화 12 달성"
  },
  Task_134162_Desc = {
    Text = "살바도르 인격 심화 12 달성"
  },
  Task_134163_Desc = {
    Text = "아라크네 인격 심화 12 도달"
  },
  Task_134164_Desc = {
    Text = "다프다엘 인격 심화 12 달성"
  },
  Task_134165_Desc = {
    Text = "셀레스트 인격 심화 12 달성"
  },
  Task_134166_Desc = {
    Text = "소레일 인격 심화 12 달성"
  },
  Task_134167_Desc = {
    Text = "골리아 인격 심화 12 달성"
  },
  Task_134168_Desc = {
    Text = "투루 인격 심화 12 달성"
  },
  Task_134169_Desc = {
    Text = "클레멘틴 인격 심화 12 달성"
  },
  Task_134170_Desc = {
    Text = "가렌 인격 심화 12 달성"
  },
  Task_134171_Desc = {
    Text = "님피아 인격 심화 12 달성"
  },
  Task_134172_Desc = {
    Text = "완다 인격 심화 12 달성"
  },
  Task_134173_Desc = {
    Text = "리즈 인격 심화 12 달성"
  },
  Task_134174_Desc = {
    Text = "엘바 인격 심화 12 달성"
  },
  Task_134175_Desc = {
    Text = "미리암 인격 심화 12 달성"
  },
  Task_134394_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_134395_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_134396_Desc = {
    Text = "누적 로그인 16일"
  },
  Task_134397_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_134398_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_134399_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_134400_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_134401_Desc = {
    Text = "누적 로그인 14일"
  },
  Task_134402_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_134403_Desc = {
    Text = "누적 로그인 11일"
  },
  Task_134404_Desc = {
    Text = "누적 로그인 13일"
  },
  Task_134405_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_134406_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_134407_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_134408_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_134409_Desc = {
    Text = "누적 로그인 12일"
  },
  Task_135038_Desc = {
    Text = "로그인하기"
  },
  Task_135038_Name = {
    Text = "로그인하기"
  },
  Task_137649_Desc = {
    Text = "이번 시즌에 카드 150장 사용하기"
  },
  Task_137650_Desc = {
    Text = "이번 시즌에 카드 150장 사용하기"
  },
  Task_138583_Desc = {
    Text = "깨어남 30회"
  },
  Task_138584_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_138585_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_138586_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_138587_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_138588_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_138589_Desc = {
    Text = "깨어남 30회"
  },
  Task_138590_Desc = {
    Text = "파견 15회 완료"
  },
  Task_138591_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_138592_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_138593_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_138594_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_138595_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_138596_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_138597_Desc = {
    Text = "파견 15회 완료"
  },
  Task_138598_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_138762_Desc = {
    Text = "「운명을 초월한 비가」를 받은 후, 「배신의 망」 네프레아를 처치하라."
  },
  Task_138762_Name = {
    Text = "운명의 주연·숨겨진"
  },
  Task_139118_Desc = {
    Text = "「다차원 연결-잊혀진 사랑의 씨앗」 완료"
  },
  Task_139119_Desc = {
    Text = "모든 작업을 완료하였습니다"
  },
  Task_139121_Desc = {
    Text = "1000회 깨어남하기"
  },
  Task_139123_Desc = {
    Text = "250회 깨어남하기"
  },
  Task_139124_Desc = {
    Text = "1일 로그인"
  },
  Task_139125_Desc = {
    Text = "「조사 작전 작전-망각편-제4장」 일반 모드 완료"
  },
  Task_139126_Desc = {
    Text = "500회 깨어남하기"
  },
  Task_139127_Desc = {
    Text = "100회 깨어남하기"
  },
  Task_139600_Desc = {
    Text = "누적 체포 1000000회"
  },
  Task_139614_Desc = {
    Text = "누적 체포 500000회"
  },
  Task_139618_Desc = {
    Text = "누적 체포 50회"
  },
  Task_139619_Desc = {
    Text = "누적 체포 1000000회"
  },
  Task_139626_Desc = {
    Text = "누적 체포 300000회"
  },
  Task_139629_Desc = {
    Text = "누적 체포 700000회"
  },
  Task_139646_Desc = {
    Text = "캠퍼스 체포 기록"
  },
  Task_139649_Desc = {
    Text = "누적 체포 100000회"
  },
  Task_139651_Desc = {
    Text = "개인 체포 기록"
  },
  Task_139652_Desc = {
    Text = "누적 체포 100회"
  },
  Task_140087_Desc = {
    Text = "「거물」 1회 클리어"
  },
  Task_140088_Desc = {
    Text = "「블랙 골드 러시」 1회 클리어"
  },
  Task_140089_Desc = {
    Text = "「체포 거부」 10회 클리어"
  },
  Task_140090_Desc = {
    Text = "「그물 올려! 그물 올려!」 5회 클리어"
  },
  Task_140091_Desc = {
    Text = "「만선 귀환」 5회 클리어"
  },
  Task_140092_Desc = {
    Text = "「체포 거부」 1회 클리어"
  },
  Task_140093_Desc = {
    Text = "「거물」 10회 클리어"
  },
  Task_140094_Desc = {
    Text = "「첫 번째 은심」 5회 클리어"
  },
  Task_140095_Desc = {
    Text = "「블랙 골드 러시」 5회 클리어"
  },
  Task_140096_Desc = {
    Text = "「첫 번째 은심」 1회 클리어"
  },
  Task_140097_Desc = {
    Text = "「만선 귀환」 10회 클리어"
  },
  Task_140098_Desc = {
    Text = "「체포 거부」 5회 클리어"
  },
  Task_140099_Desc = {
    Text = "「거물」 5회 클리어"
  },
  Task_140100_Desc = {
    Text = "「만선 귀환」 1회 클리어"
  },
  Task_140101_Desc = {
    Text = "「그물 올려! 그물 올려!」 10회 클리어"
  },
  Task_140102_Desc = {
    Text = "「한 번 더」 1회 클리어"
  },
  Task_140103_Desc = {
    Text = "「한 번 더」 10회 클리어"
  },
  Task_140104_Desc = {
    Text = "「첫 번째 은심」 10회 클리어"
  },
  Task_140105_Desc = {
    Text = "「그물 올려! 그물 올려!」 1회 클리어"
  },
  Task_140106_Desc = {
    Text = "「블랙 골드 러시」 10회 클리어"
  },
  Task_140107_Desc = {
    Text = "「한 번 더」 5회 클리어"
  },
  Task_140114_Desc = {
    Text = "「다차원 연결-잊혀진 사랑의 씨앗」 완료"
  },
  Task_140115_Desc = {
    Text = "모든 작업을 완료하였습니다"
  },
  Task_140116_Desc = {
    Text = "1일 로그인"
  },
  Task_140117_Desc = {
    Text = "「조사 작전 작전-망각편-제4장」 일반 모드 완료"
  },
  Task_140189_Desc = {
    Text = "누적 5,000 원액 추출하기"
  },
  Task_140190_Desc = {
    Text = "누적 20,000 원액 추출하기"
  },
  Task_140191_Desc = {
    Text = "누적 10,000 원액 추출하기"
  },
  Task_140192_Desc = {
    Text = "누적 30,000 원액 추출하기"
  },
  Task_140306_Desc = {
    Text = "다차원 연결 「잊혀진 사랑의 씨앗」 어려움 난이도 완료"
  },
  Task_140306_Name = {
    Text = "방랑자의 귀착지·어려움"
  },
  Task_140307_Desc = {
    Text = "다차원 연결 「잊혀진 사랑의 씨앗」 완료"
  },
  Task_140307_Name = {
    Text = "방랑자의 귀착지"
  },
  Task_140463_Desc = {
    Text = "누적 200장의 카드 사용"
  },
  Task_140464_Desc = {
    Text = "완료 20 회 파견"
  },
  Task_140465_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_140466_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_140467_Desc = {
    Text = "모든 작업을 완료하였습니다"
  },
  Task_140468_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_141311_Desc = {
    Text = "의식 잠수 「영원한 에포얀스」 클리어"
  },
  Task_141312_Desc = {
    Text = "폰토스 동조율 10레벨 달성"
  },
  Task_141313_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「고지 순렵」에서 1회 승리"
  },
  Task_141314_Desc = {
    Text = "「숲의 법전」 광기 난이도 클리어"
  },
  Task_141315_Desc = {
    Text = "「맥주와 향신료」 임의 난이도 클리어"
  },
  Task_141316_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_141317_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_141318_Desc = {
    Text = "「고백」 임의 난이도 클리어"
  },
  Task_141319_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_141320_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_141321_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「고지 순렵」에서 2회 승리"
  },
  Task_141322_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「고지 순렵」에서 2회 승리"
  },
  Task_141323_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「고지 순렵」에서 1회 승리"
  },
  Task_141324_Desc = {
    Text = "고지 순렵·영역"
  },
  Task_141325_Desc = {
    Text = "「호루라기 소리」 광기 난이도 클리어"
  },
  Task_141326_Desc = {
    Text = "「추격 게임」 임의 난이도 클리어"
  },
  Task_141327_Desc = {
    Text = "「맥주와 향신료」 임의 난이도 클리어"
  },
  Task_141328_Desc = {
    Text = "「숲의 법전」 임의 난이도 클리어"
  },
  Task_141329_Desc = {
    Text = "고지 순렵·광기"
  },
  Task_141330_Desc = {
    Text = "「이원론」 광기 난이도 클리어"
  },
  Task_141331_Desc = {
    Text = "「숲의 법전」 임의 난이도 클리어"
  },
  Task_141332_Desc = {
    Text = "「맥주와 향신료」 광기 난이도 클리어"
  },
  Task_141333_Desc = {
    Text = "「고백」 광기 난이도 클리어"
  },
  Task_141335_Desc = {
    Text = "「늑연골」 임의 난이도 클리어"
  },
  Task_141336_Desc = {
    Text = "「이원론」 임의 난이도 클리어"
  },
  Task_141337_Desc = {
    Text = "「고지 순렵·클리어」 모든 업적 완료"
  },
  Task_141338_Desc = {
    Text = "폰토스 획득 시 기령 6"
  },
  Task_141338_Name = {
    Text = "폰토스 획득 시 기령 6"
  },
  Task_141338_UnlockCondDesc = {
    Text = "활동@깨어남체 폰토스 기령 예물 패키지 2 활동"
  },
  Task_141339_Desc = {
    Text = "「늑연골」 임의 난이도 클리어"
  },
  Task_141340_Desc = {
    Text = "「이원론」 임의 난이도 클리어"
  },
  Task_141341_Desc = {
    Text = "고지 순렵·클리어"
  },
  Task_141342_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「고지 순렵」에서 2회 승리"
  },
  Task_141343_Desc = {
    Text = "「호루라기 소리」 임의 난이도 클리어"
  },
  Task_141344_Desc = {
    Text = "「고백」 임의 난이도 클리어"
  },
  Task_141345_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「고지 순렵」에서 2회 승리"
  },
  Task_141346_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「고지 순렵」에서 1회 승리"
  },
  Task_141347_Desc = {
    Text = "「추격 게임」 광기 난이도 클리어"
  },
  Task_141348_Desc = {
    Text = "「호루라기 소리」 임의 난이도 클리어"
  },
  Task_141349_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「고지 순렵」에서 1회 승리"
  },
  Task_141350_Desc = {
    Text = "폰토스 인격 심화 12 달성"
  },
  Task_141351_Desc = {
    Text = "폰토스 획득 시 기령 2"
  },
  Task_141351_Name = {
    Text = "폰토스 획득 시 기령 2"
  },
  Task_141351_UnlockCondDesc = {
    Text = "활동@깨어남체 폰토스 기령 예물 패키지 2 활동"
  },
  Task_141352_Desc = {
    Text = "「추격 게임」 임의 난이도 클리어"
  },
  Task_141353_Desc = {
    Text = "「늑연골」 광기 난이도 클리어"
  },
  Task_141511_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_141512_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_141513_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_141514_Desc = {
    Text = "파견 15회 완료"
  },
  Task_141515_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_141516_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_141517_Desc = {
    Text = "깨어남 30회"
  },
  Task_141518_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_141519_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_141520_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_141521_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_141522_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_141523_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_141524_Desc = {
    Text = "깨어남 30회"
  },
  Task_141525_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_141526_Desc = {
    Text = "파견 15회 완료"
  },
  Task_141799_Desc = {
    Text = "심해 영역 각성체를 사용하여 「우모파티의 보물」에서 2회 승리하기"
  },
  Task_141800_Desc = {
    Text = "초차원 영역 각성체를 사용하여 「우모파티의 보물」에서 2회 승리하기"
  },
  Task_141801_Desc = {
    Text = "「실타래」 임의 난이도 클리어"
  },
  Task_141802_Desc = {
    Text = "혈육 영역 각성체를 사용하여 「우모파티의 보물」에서 2회 승리하기"
  },
  Task_141803_Desc = {
    Text = "「우모파티의 보물·클리어」 모든 업적 완료"
  },
  Task_141804_Desc = {
    Text = "혼돈 계역의 각성체를 사용하여 「우모파티의 보물」에서 1회 승리"
  },
  Task_141805_Desc = {
    Text = "「사과」 임의 난이도 클리어"
  },
  Task_141806_Desc = {
    Text = "클리어 「거울」 임의의 난이도"
  },
  Task_141807_Desc = {
    Text = "「열쇠」 임의 난이도 클리어"
  },
  Task_141808_Desc = {
    Text = "클리어 「거울」 광기의 난이도"
  },
  Task_141809_Desc = {
    Text = "「왕관」 광기 난이도 클리어"
  },
  Task_141810_Desc = {
    Text = "「깃털」 임의 난이도 클리어"
  },
  Task_141811_Desc = {
    Text = "「눈」 임의 난이도 클리어"
  },
  Task_141812_Desc = {
    Text = "「실타래」 광기 난이도 클리어"
  },
  Task_141813_Desc = {
    Text = "「사과」 광기 난이도 클리어"
  },
  Task_141814_Desc = {
    Text = "「왕관」 임의 난이도 클리어"
  },
  Task_141815_Desc = {
    Text = "혈육 영역 각성체를 사용하여 「우모파티의 보물」에서 1회 승리하기"
  },
  Task_141816_Desc = {
    Text = "클리어 「거울」 임의의 난이도"
  },
  Task_141817_Desc = {
    Text = "「깃털」 광기 난이도 클리어"
  },
  Task_141818_Desc = {
    Text = "「깃털」 임의 난이도 클리어"
  },
  Task_141819_Desc = {
    Text = "우모파티의 보물·매드니스"
  },
  Task_141820_Desc = {
    Text = "우모파티의 보물·영역"
  },
  Task_141821_Desc = {
    Text = "「눈」 임의 난이도 클리어"
  },
  Task_141822_Desc = {
    Text = "「실타래」 임의 난이도 클리어"
  },
  Task_141823_Desc = {
    Text = "「열쇠」 임의 난이도 클리어"
  },
  Task_141824_Desc = {
    Text = "우모파티의 보물·클리어"
  },
  Task_141825_Desc = {
    Text = "「사과」 임의 난이도 클리어"
  },
  Task_141826_Desc = {
    Text = "초차원 영역 각성체를 사용하여 「우모파티의 보물」에서 1회 승리하기"
  },
  Task_141827_Desc = {
    Text = "심해 영역 각성체를 사용하여 「우모파티의 보물」에서 1회 승리"
  },
  Task_141828_Desc = {
    Text = "「눈」 광기 난이도 클리어"
  },
  Task_141829_Desc = {
    Text = "혼돈 계역의 각성체를 사용하여 「우모파티의 보물」에서 2회 승리"
  },
  Task_141830_Desc = {
    Text = "「열쇠」 광기 난이도 클리어"
  },
  Task_141831_Desc = {
    Text = "「왕관」 임의 난이도 클리어"
  },
  Task_141899_Desc = {
    Text = "「사용자 센터-정보 완성」에서 전화 번호 또는 이메일을 연동하기"
  },
  Task_143320_Desc = {
    Text = "의식 잠수 「영원한 에포얀스」 어려움 난이도 완료"
  },
  Task_143320_Name = {
    Text = "시원한 여름 밤·어려움"
  },
  Task_143321_Desc = {
    Text = "의식 잠수 「영원한 에포얀스」 완료"
  },
  Task_143321_Name = {
    Text = "시원한 여름 밤"
  },
  Task_143588_Desc = {
    Text = "그의 품 속 에포양스……"
  },
  Task_143588_Name = {
    Text = "그의 품 속 에포양스……"
  },
  Task_143589_Desc = {
    Text = "남아서……"
  },
  Task_143589_Name = {
    Text = "남아서……"
  },
  Task_143590_Desc = {
    Text = "에포양스에 남다"
  },
  Task_143590_Name = {
    Text = "에포양스에 남다"
  },
  Task_144311_Desc = {
    Text = "강화 각성체 1/2/3/4명을 출전시킬 때, 250 / 500 750 / 1000점 획득. (현재 출전: {s1})"
  },
  Task_144311_Name = {
    Text = "심연 호출<size=20><color=#747474>강화 깨어남체 1/2/3/4명으로 출전 시, 250 / 500 / 750 / 1000점 획득 </color></size>"
  },
  Task_144312_Desc = {
    Text = "의식 잠수 「임시 텍스트」를 클리어하세요"
  },
  Task_144313_Desc = {
    Text = "뒤바뀐 새 삶·클리어"
  },
  Task_144314_Desc = {
    Text = "「뇌 손상」 광기 난이도 클리어"
  },
  Task_144315_Desc = {
    Text = "심해 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_144316_Desc = {
    Text = "「마지막 한 잔」 광기 난이도 클리어"
  },
  Task_144317_Desc = {
    Text = "「마지막 한 잔」 임의 난이도 클리어"
  },
  Task_144318_Desc = {
    Text = "뒤바뀐 새 삶·계역"
  },
  Task_144319_Desc = {
    Text = "「병원」 아무 난이도 클리어"
  },
  Task_144320_Desc = {
    Text = "심해 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_144321_Desc = {
    Text = "「식탁」 임의 난이도 클리어"
  },
  Task_144322_Desc = {
    Text = "「식탁」 광기 난이도 클리어"
  },
  Task_144323_Desc = {
    Text = "「집」 아무 난이도 클리어"
  },
  Task_144324_Desc = {
    Text = "초차원 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_144325_Desc = {
    Text = "「우물」 임의 난이도 클리어"
  },
  Task_144326_Desc = {
    Text = "「집」 아무 난이도 클리어"
  },
  Task_144327_Desc = {
    Text = "혼돈 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_144328_Desc = {
    Text = "「병원」 아무 난이도 클리어"
  },
  Task_144329_Desc = {
    Text = "「우물」 임의 난이도 클리어"
  },
  Task_144330_Desc = {
    Text = "「학교」 임의 난이도 클리어"
  },
  Task_144331_Desc = {
    Text = "「뇌 손상」 임의 난이도 클리어"
  },
  Task_144332_Desc = {
    Text = "「뒤집힌 새 생명·클리어」 모든 업적 완료"
  },
  Task_144333_Desc = {
    Text = "「식탁」 임의 난이도 클리어"
  },
  Task_144334_Desc = {
    Text = "「학교」 광기 난이도 클리어"
  },
  Task_144335_Desc = {
    Text = "「집」 광기 난이도 클리어"
  },
  Task_144336_Desc = {
    Text = "혈육 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_144337_Desc = {
    Text = "「뇌 손상」 임의 난이도 클리어"
  },
  Task_144338_Desc = {
    Text = "「학교」 임의 난이도 클리어"
  },
  Task_144339_Desc = {
    Text = "「마지막 한 잔」 임의 난이도 클리어"
  },
  Task_144340_Desc = {
    Text = "혈육 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_144341_Desc = {
    Text = "혼돈 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 1회 승리"
  },
  Task_144342_Desc = {
    Text = "초차원 계역 깨어남체를 사용하여 「뒤집힌 새 생명」에서 2회 승리"
  },
  Task_144343_Desc = {
    Text = "뒤바뀐 새 삶·광기"
  },
  Task_144344_Desc = {
    Text = "「우물」 광기 난이도 클리어"
  },
  Task_144345_Desc = {
    Text = "「병원」 광기 난이도 클리어"
  },
  Task_144360_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_144361_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_144362_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_144363_Desc = {
    Text = "파견 15회 완료"
  },
  Task_144364_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_144365_Desc = {
    Text = "깨어남 30회"
  },
  Task_144366_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_144367_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_144368_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_144369_Desc = {
    Text = "파견 15회 완료"
  },
  Task_144370_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_144371_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_144372_Desc = {
    Text = "깨어남 30회"
  },
  Task_144373_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_144374_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_144375_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_145388_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_145389_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「살육의 각축」에서 2회 승리"
  },
  Task_145390_Desc = {
    Text = "「근헌」 임의 난이도 클리어"
  },
  Task_145392_Desc = {
    Text = "살육의 각축·클리어"
  },
  Task_145393_Desc = {
    Text = "「살육의 전당」 광기 난이도 클리어"
  },
  Task_145394_Desc = {
    Text = "「권욕의 왕관」 임의 난이도 클리어"
  },
  Task_145395_Desc = {
    Text = "의식 잠항 「별하늘 고래의 침몰」 클리어"
  },
  Task_145396_Desc = {
    Text = "침식·로탄 획득 시 계령 6"
  },
  Task_145396_Name = {
    Text = "침식·로탄 획득 시 계령 6"
  },
  Task_145396_UnlockCondDesc = {
    Text = "이벤트@깨어남체 침식·로탄 계령 예물 패키지 2 이벤트"
  },
  Task_145397_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_145398_Desc = {
    Text = "침식·로탄 동조율 10등급 달성"
  },
  Task_145399_Desc = {
    Text = "살육의 각축·영역"
  },
  Task_145400_Desc = {
    Text = "「갇혀진 짐승」 임의 난이도 클리어"
  },
  Task_145401_Desc = {
    Text = "「살육의 전당」 임의 난이도 클리어"
  },
  Task_145402_Desc = {
    Text = "「갇혀진 짐승」 임의 난이도 클리어"
  },
  Task_145403_Desc = {
    Text = "「갇혀진 짐승」 광기 난이도 클리어"
  },
  Task_145404_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「살육의 각축」에서 1회 승리"
  },
  Task_145405_Desc = {
    Text = "혼돈 계역의 깨어남체를 사용하여 「살육의 각축」에서 2회 승리"
  },
  Task_145406_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_145408_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_145409_Desc = {
    Text = "「권욕의 왕관」 임의 난이도 클리어"
  },
  Task_145410_Desc = {
    Text = "「살육의 각축·클리어」 모든 업적 완료"
  },
  Task_145411_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「살육의 각축」에서 1회 승리"
  },
  Task_145412_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「살육의 각축」에서 2회 승리"
  },
  Task_145413_Desc = {
    Text = "「근헌」 임의 난이도 클리어"
  },
  Task_145414_Desc = {
    Text = "침식·로탄 획득 시 계령 2"
  },
  Task_145414_Name = {
    Text = "침식·로탄 획득 시 계령 2"
  },
  Task_145414_UnlockCondDesc = {
    Text = "이벤트@깨어남체 침식·로탄 계령 예물 패키지 2 이벤트"
  },
  Task_145415_Desc = {
    Text = "혼돈 계역의 깨어남체를 사용하여 「살육의 각축」에서 1회 승리"
  },
  Task_145416_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「살육의 각축」에서 2회 승리"
  },
  Task_145417_Desc = {
    Text = "「근헌」 광기 난이도 클리어"
  },
  Task_145418_Desc = {
    Text = "살육의 각축·매드니스"
  },
  Task_145419_Desc = {
    Text = "「아무도 없는 거울」 광기 난이도 클리어"
  },
  Task_145420_Desc = {
    Text = "「아무도 없는 거울」 임의 난이도 클리어"
  },
  Task_145421_Desc = {
    Text = "「권욕의 왕관」 광기 난이도 클리어"
  },
  Task_145423_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「살육의 각축」에서 1회 승리"
  },
  Task_145424_Desc = {
    Text = "「아무도 없는 거울」 임의 난이도 클리어"
  },
  Task_145425_Desc = {
    Text = "침식·로탄 인격 심화 12 달성"
  },
  Task_145426_Desc = {
    Text = "「살육의 전당」 임의 난이도 클리어"
  },
  Task_145479_Desc = {
    Text = "의식 잠항 「별하늘 고래의 침몰」 완료"
  },
  Task_145479_Name = {
    Text = "나는 폭풍이다"
  },
  Task_145576_Desc = {
    Text = "임시 텍스트·기간 한정 전용"
  },
  Task_145578_Desc = {
    Text = "만원의 의지·기간 한정 전용"
  },
  Task_146542_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146543_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146544_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146545_Desc = {
    Text = "별의 시대 6장 6-9 클리어"
  },
  Task_146546_Desc = {
    Text = "별의 시대 6장 「산의 연회」 어려움 난이도 클리어"
  },
  Task_146547_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146548_Desc = {
    Text = "별의 시대 6장 「산의 연회」 어려움 난이도 클리어"
  },
  Task_146549_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146550_Desc = {
    Text = "별의 시대 6장 6-9 클리어"
  },
  Task_146552_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146553_Desc = {
    Text = "별의 시대 6장 「산의 연회」 클리어"
  },
  Task_146554_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146555_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146556_Desc = {
    Text = "별의 시대 6장 6-5 어려움 난이도 클리어"
  },
  Task_146557_Desc = {
    Text = "별의 시대 6장 6-5 어려움 난이도 클리어"
  },
  Task_146558_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146559_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_146560_Desc = {
    Text = "별의 시대 6장 「산의 연회」 클리어"
  },
  Task_146801_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_146802_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146803_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146804_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146805_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_146806_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146807_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146808_Desc = {
    Text = "의식 잠항 「오일담」 클리어"
  },
  Task_146809_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146810_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_146811_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146812_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146813_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146814_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146815_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_146816_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_146817_Desc = {
    Text = "임시 텍스트·클리어"
  },
  Task_146818_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146819_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146820_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146821_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146822_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146823_Desc = {
    Text = "임시 텍스트·경계역"
  },
  Task_146824_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146825_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146826_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146827_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146828_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146829_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_146830_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146831_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_146832_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146833_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_146834_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146835_Desc = {
    Text = "임시 텍스트·광기"
  },
  Task_146836_Desc = {
    Text = "모든 성과 「임시 텍스트·통과」를 완료하십시오"
  },
  Task_146837_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146838_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_146839_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_146840_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147442_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_147443_Desc = {
    Text = "저무는 별·틴커트 동조율 10레벨 달성하기"
  },
  Task_147444_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_147450_Desc = {
    Text = "의식 잠수 「임시 텍스트」를 클리어하세요"
  },
  Task_147451_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_147452_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_147453_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_147454_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「임시 텍스트」에서 1회 승리"
  },
  Task_147456_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_147458_Desc = {
    Text = "저무는 별·틴커트 획득 시 계령 2"
  },
  Task_147458_Name = {
    Text = "저무는 별·틴커트 획득 시 계령 2"
  },
  Task_147458_UnlockCondDesc = {
    Text = "활동@각성체 저무는 별·틴커트 계령 패키지 2 활동"
  },
  Task_147461_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_147464_Desc = {
    Text = "의식 잠수 완료 「임시 텍스트」"
  },
  Task_147464_Name = {
    Text = "임시 텍스트"
  },
  Task_147465_Desc = {
    Text = "저무는 별·틴커트 획득 시 계령 6"
  },
  Task_147465_Name = {
    Text = "저무는 별·틴커트 획득 시 계령 6"
  },
  Task_147465_UnlockCondDesc = {
    Text = "활동@각성체 저무는 별·틴커트 계령 패키지 2 활동"
  },
  Task_147471_Desc = {
    Text = "저무는 별·틴커트 인격 심화 12 달성하기"
  },
  Task_147472_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_147474_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_147475_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_147476_Desc = {
    Text = "모든 성과 「임시 텍스트·통과」를 완료하십시오"
  },
  Task_147478_Desc = {
    Text = "의식 잠항 「임시 텍스트」 어려움 난이도 완료하기"
  },
  Task_147478_Name = {
    Text = "임시 텍스트·어려움"
  },
  Task_147483_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「임시 텍스트」에서 2회 승리"
  },
  Task_147552_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147553_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147554_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147555_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147556_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147557_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147558_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147559_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147560_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147561_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147562_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147563_Desc = {
    Text = "임시 텍스트·광기"
  },
  Task_147564_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147565_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147566_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147567_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147568_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147569_Desc = {
    Text = "임시 텍스트·경계역"
  },
  Task_147570_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147571_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147572_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147573_Desc = {
    Text = "「임시 텍스트」 광란 난이도 통과"
  },
  Task_147574_Desc = {
    Text = "임시 텍스트·클리어"
  },
  Task_147575_Desc = {
    Text = "클리어 「임시 텍스트」 어떤 난이도든"
  },
  Task_147676_Desc = {
    Text = "플레이어 레벨 2 달성"
  },
  Task_147676_Name = {
    Text = "(포장 대기)"
  },
  Task_147677_Desc = {
    Text = "10레벨 각성체 1명 보유"
  },
  Task_147677_Name = {
    Text = "(포장 대기)"
  },
  Task_147678_Desc = {
    Text = "조사 사건 「입학일」 완료"
  },
  Task_147678_Name = {
    Text = "(포장 대기)"
  },
  Task_147679_Desc = {
    Text = "각성체 5명 보유"
  },
  Task_147679_Name = {
    Text = "(포장 대기)"
  },
  Task_147894_Desc = {
    Text = "임시 텍스트"
  },
  Task_147894_Name = {Text = "목표"},
  Task_147895_Desc = {
    Text = "조사 사건 「산의 연회」 어려움 난이도 완료하기"
  },
  Task_147895_Name = {
    Text = "해발 8840m의 안식·어려움"
  },
  Task_147896_Desc = {
    Text = "임시 텍스트"
  },
  Task_147896_Name = {Text = "목표"},
  Task_147897_Desc = {
    Text = "임시 텍스트"
  },
  Task_147897_Name = {Text = "목표"},
  Task_147898_Desc = {
    Text = "임시 텍스트"
  },
  Task_147898_Name = {Text = "목표"},
  Task_147899_Desc = {
    Text = "임시 텍스트"
  },
  Task_147899_Name = {Text = "목표"},
  Task_147900_Desc = {
    Text = "임시 텍스트"
  },
  Task_147900_Name = {Text = "목표"},
  Task_147901_Desc = {
    Text = "임시 텍스트"
  },
  Task_147901_Name = {Text = "목표"},
  Task_147902_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 9번"
  },
  Task_147902_Desc2 = {
    Text = "조사 사건 「산의 연회」에서 9회 공명하기"
  },
  Task_147902_Name2 = {
    Text = "정직한 자의 7번의 예배Ⅳ"
  },
  Task_147903_Desc = {
    Text = "임시 텍스트"
  },
  Task_147903_Name = {Text = "목표"},
  Task_147904_Desc = {
    Text = "임시 텍스트"
  },
  Task_147904_Name = {Text = "목표"},
  Task_147905_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_147905_Desc2 = {
    Text = "조사 사건 「산의 연회」에서 3회 공명하기"
  },
  Task_147905_Name2 = {
    Text = "정직한 자의 7번의 예배"
  },
  Task_147906_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 7회 발생"
  },
  Task_147906_Desc2 = {
    Text = "조사 사건 「산의 연회」에서 7회 공명하기"
  },
  Task_147906_Name2 = {
    Text = "정직한 자의 7번의 예배Ⅲ"
  },
  Task_147907_Desc = {
    Text = "조사 사건 「@1@2」에서 5회 공명하기"
  },
  Task_147907_Desc2 = {
    Text = "조사 사건 「산의 연회」에서 5회 공명하기"
  },
  Task_147907_Name2 = {
    Text = "정직한 자의 7번의 예배Ⅱ"
  },
  Task_147908_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_147908_Desc2 = {
    Text = "조사 사건 「산의 연회」 완료하기"
  },
  Task_147908_Name2 = {
    Text = "해발 8840m의 안식"
  },
  Task_147909_Desc = {
    Text = "임시 텍스트"
  },
  Task_147909_Name = {Text = "목표"},
  Task_147910_Desc = {
    Text = "임시 텍스트"
  },
  Task_147910_Name = {Text = "목표"},
  Task_148121_Desc = {
    Text = "파견 15회 완료"
  },
  Task_148122_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_148123_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_148124_Desc = {
    Text = "깨어남 30회"
  },
  Task_148125_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_148126_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_148127_Desc = {
    Text = "「금기 시련」에서 임의의 시즌 임무 완료"
  },
  Task_148128_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_148129_Desc = {
    Text = "깨어남 30회"
  },
  Task_148130_Desc = {
    Text = "파견 15회 완료"
  },
  Task_148131_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_148132_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_148133_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_148134_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_148135_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_148136_Desc = {
    Text = "누적 카드 300장 사용"
  },
  Task_148489_Desc = {
    Text = "의식 잠항 「오일담」 완료하기"
  },
  Task_148489_Name = {
    Text = "고향 잃은 자의 개선"
  },
  Task_148490_Desc = {
    Text = "의식 잠항 「오일담」 어려움 난이도 완료하기"
  },
  Task_148490_Name = {
    Text = "고향 잃은 자의 개선·어려움"
  },
  Task_149335_Desc = {Text = "용 처치"},
  Task_149335_Name = {Text = "목표"},
  Task_149989_Desc = {
    Text = "별의 시대 6장 6-1 클리어하기"
  },
  Task_149990_Desc = {
    Text = "본원 오지에 인격 심화 12 달성하기"
  },
  Task_19734_Desc = {
    Text = "클리어 초월의 여정 · 간격 Ⅵ"
  },
  Task_19735_Desc = {
    Text = "클리어 혈육의 늪·간격 Ⅷ"
  },
  Task_19736_Desc = {
    Text = "클리어 초월의 여정·간격 Ⅳ"
  },
  Task_19737_Desc = {
    Text = "클리어 혈육의 늪 · 간격 Ⅱ"
  },
  Task_19738_Desc = {
    Text = "클리어 초월의 여정·간격Ⅱ"
  },
  Task_19739_Desc = {
    Text = "클리어 혈육의 늪·간격 Ⅵ"
  },
  Task_19740_Desc = {
    Text = "함정을 설치하여, 「사냥」을 시작하기"
  },
  Task_19740_Name = {Text = "목표"},
  Task_19741_Desc = {
    Text = "클리어 초월의 여정 · 간격 Ⅷ"
  },
  Task_19742_Desc = {
    Text = "클리어 깊은 바다의 유산·간격Ⅱ"
  },
  Task_19743_Desc = {
    Text = "클리어 혼돈의 영역·간격Ⅱ"
  },
  Task_19744_Desc = {
    Text = "클리어 깊은 바다의 유산·간격Ⅵ"
  },
  Task_19745_Desc = {
    Text = "클리어 혼돈의 영역 · 간격 Ⅳ"
  },
  Task_19746_Desc = {
    Text = "클리어 깊은 바다의 유산·간격 Ⅳ"
  },
  Task_19747_Desc = {
    Text = "클리어 혼돈의 영역·간격Ⅵ"
  },
  Task_19748_Desc = {
    Text = "클리어 혼돈의 영역·간격 Ⅷ"
  },
  Task_19749_Desc = {
    Text = "클리어 깊은 바다의 유산·간격Ⅷ"
  },
  Task_19750_Desc = {
    Text = "함정을 설치하여, 「사냥」을 시작하기"
  },
  Task_19750_Name = {Text = "목표"},
  Task_19751_Desc = {
    Text = "로탄을 도와 적을 몰아넣기"
  },
  Task_19751_Name = {Text = "목표"},
  Task_19752_Desc = {
    Text = "클리어 혈육의 늪·간격 Ⅳ"
  },
  Task_20972_Desc = {
    Text = "초월의 여정·간격 Ⅰ 완료하기"
  },
  Task_20973_Desc = {
    Text = "심해의 유산·간격 Ⅰ 완료하기"
  },
  Task_20990_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_20990_Name = {
    Text = "속전속결"
  },
  Task_20991_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_20991_Name = {
    Text = "완벽한 통과"
  },
  Task_20992_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_20992_Name = {
    Text = "완벽한 통과"
  },
  Task_20993_Desc = {
    Text = "최종전에서 1턴 동안 광기 폭발을 4회 이상 사용"
  },
  Task_20993_Name = {
    Text = "치명적인 마술"
  },
  Task_20994_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_20994_Name = {
    Text = "완벽한 통과"
  },
  Task_20995_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_20995_Name = {
    Text = "완벽한 통과"
  },
  Task_20996_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_20996_Name = {
    Text = "우아하고 정확한"
  },
  Task_20997_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_20997_Name = {
    Text = "속전속결"
  },
  Task_20998_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_20998_Name = {Text = "드로우!"},
  Task_20999_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_20999_Name = {
    Text = "완벽한 통과"
  },
  Task_21000_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21000_Name = {
    Text = "속전속결"
  },
  Task_21001_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21001_Name = {
    Text = "완벽한 통과"
  },
  Task_21002_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21002_Name = {
    Text = "무한의 포옹"
  },
  Task_21003_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_21003_Name = {
    Text = "영혼의 낙인"
  },
  Task_21004_Desc = {
    Text = "엘리트 전투에서 1턴 동안 240 이상의 피해 입히기"
  },
  Task_21004_Name = {
    Text = "전력의 일격"
  },
  Task_21005_Desc = {
    Text = "연락 지점에서 HP를 회복하지 않고 클리어"
  },
  Task_21005_Name = {
    Text = "불붙지 않은 자"
  },
  Task_21006_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_21006_Name = {
    Text = "에너지 절약"
  },
  Task_21007_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21007_Name = {
    Text = "기병의 보물창고"
  },
  Task_21008_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21008_Name = {
    Text = "에너지 절약"
  },
  Task_21009_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 사용"
  },
  Task_21009_Name = {
    Text = "내 차례야!이야"
  },
  Task_21010_Desc = {
    Text = "탐색도 100% 달성"
  },
  Task_21010_Name = {
    Text = "비경 조망"
  },
  Task_21011_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_21011_Name = {
    Text = "기병의 보물창고"
  },
  Task_21012_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_21012_Name = {
    Text = "기병의 보물창고"
  },
  Task_21013_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_21013_Name = {
    Text = "기병의 보물창고"
  },
  Task_21014_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 50%만큼의 방어막 획득"
  },
  Task_21014_Name = {
    Text = "강철의 몸"
  },
  Task_21015_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21015_Name = {
    Text = "완벽한 통과"
  },
  Task_21016_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21016_Name = {
    Text = "우아하고 정확한"
  },
  Task_21017_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21017_Name = {
    Text = "완벽한 통과"
  },
  Task_21018_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21018_Name = {
    Text = "우아하고 정확한"
  },
  Task_21019_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21019_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21020_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21020_Name = {
    Text = "완벽한 통과"
  },
  Task_21021_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_21021_Name = {
    Text = "속전속결"
  },
  Task_21022_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21022_Name = {
    Text = "완벽한 통과"
  },
  Task_21023_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21023_Name = {
    Text = "에너지 절약"
  },
  Task_21024_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21024_Name = {
    Text = "완벽한 통과"
  },
  Task_21025_Desc = {
    Text = "최종전에서 1턴 동안 광기 폭발을 4회 이상 사용"
  },
  Task_21025_Name = {
    Text = "치명적인 마술"
  },
  Task_21026_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21026_Name = {
    Text = "완벽한 통과"
  },
  Task_21027_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21027_Name = {
    Text = "속전속결"
  },
  Task_21028_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_21028_Name = {
    Text = "속전속결"
  },
  Task_21029_Desc = {
    Text = "최종전에서 1턴 동안 6장 이상의 카드 사용"
  },
  Task_21029_Name = {
    Text = "내 차례야!이야"
  },
  Task_21030_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21030_Name = {
    Text = "완벽한 통과"
  },
  Task_21032_Desc = {
    Text = "최종전에서 1턴 동안 40000 이상의 피해 입히기"
  },
  Task_21032_Name = {
    Text = "전력의 일격"
  },
  Task_21033_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21033_Name = {
    Text = "완벽한 통과"
  },
  Task_21034_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21034_Name = {
    Text = "완벽한 통과"
  },
  Task_21035_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21035_Name = {
    Text = "속전속결"
  },
  Task_21036_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21036_Name = {
    Text = "완벽한 통과"
  },
  Task_21037_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21037_Name = {
    Text = "에너지 절약"
  },
  Task_21038_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 사용"
  },
  Task_21038_Name = {
    Text = "내 차례야!이야"
  },
  Task_21039_Desc = {
    Text = "탐색도 100% 달성"
  },
  Task_21039_Name = {
    Text = "비경 조망"
  },
  Task_21040_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_21040_Name = {
    Text = "기병의 보물창고"
  },
  Task_21041_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_21041_Name = {
    Text = "기병의 보물창고"
  },
  Task_21042_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21042_Name = {
    Text = "우아하고 정확한"
  },
  Task_21043_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 50%만큼의 방어막 획득"
  },
  Task_21043_Name = {
    Text = "강철의 몸"
  },
  Task_21044_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_21044_Name = {
    Text = "영혼의 낙인"
  },
  Task_21045_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21045_Name = {
    Text = "우아하고 정확한"
  },
  Task_21046_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21046_Name = {
    Text = "속전속결"
  },
  Task_21047_Desc = {
    Text = "우아하고 정확한"
  },
  Task_21047_Name = {
    Text = "치명적인 마술"
  },
  Task_21048_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21048_Name = {
    Text = "완벽한 통과"
  },
  Task_21049_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21049_Name = {
    Text = "에너지 절약"
  },
  Task_21050_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21050_Name = {
    Text = "무한의 포옹"
  },
  Task_21051_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_21051_Name = {
    Text = "기병의 보물창고"
  },
  Task_21052_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21052_Name = {
    Text = "완벽한 통과"
  },
  Task_21053_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_21053_Name = {
    Text = "영혼의 낙인"
  },
  Task_21054_Desc = {
    Text = "4종류 이상의 서로 다른 각인을 획득"
  },
  Task_21054_Name = {
    Text = "영혼의 낙인"
  },
  Task_21055_Desc = {
    Text = "엘리트 전투에서 1턴 동안 980 이상의 피해 입히기"
  },
  Task_21055_Name = {
    Text = "전력의 일격"
  },
  Task_21056_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21056_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21057_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_21057_Name = {
    Text = "에너지 절약"
  },
  Task_21058_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21058_Name = {
    Text = "기병의 보물창고"
  },
  Task_21059_Desc = {
    Text = "탐색도 100% 달성"
  },
  Task_21059_Name = {
    Text = "비경 조망"
  },
  Task_21060_Desc = {
    Text = "엘리트 전투에서 1턴 동안 광기 폭발을 3회 이상 사용"
  },
  Task_21060_Name = {
    Text = "치명적인 마술"
  },
  Task_21061_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21061_Name = {Text = "드로우!"},
  Task_21062_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21062_Name = {
    Text = "속전속결"
  },
  Task_21063_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21063_Name = {
    Text = "완벽한 통과"
  },
  Task_21064_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_21064_Name = {
    Text = "기병의 보물창고"
  },
  Task_21065_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21065_Name = {
    Text = "에너지 절약"
  },
  Task_21066_Desc = {
    Text = "서로 다른 각인 3종류 이상 획득"
  },
  Task_21066_Name = {
    Text = "영혼의 낙인"
  },
  Task_21067_Desc = {
    Text = "2명 이상의 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21067_Name = {
    Text = "무한의 포옹"
  },
  Task_21068_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21068_Name = {
    Text = "우아하고 정확한"
  },
  Task_21069_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21069_Name = {
    Text = "기병의 보물창고"
  },
  Task_21070_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 사용"
  },
  Task_21070_Name = {
    Text = "내 차례야!이야"
  },
  Task_21071_Desc = {
    Text = "최종전에서 1턴 동안 광기 폭발을 3회 이상 사용"
  },
  Task_21071_Name = {
    Text = "치명적인 마술"
  },
  Task_21072_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_21072_Name = {
    Text = "에너지 절약"
  },
  Task_21073_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21073_Name = {
    Text = "에너지 절약"
  },
  Task_21074_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21074_Name = {
    Text = "완벽한 통과"
  },
  Task_21075_Desc = {
    Text = "4종류의 서로 다른 각인을 소지"
  },
  Task_21075_Name = {
    Text = "영혼의 낙인"
  },
  Task_21076_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21076_Name = {
    Text = "속전속결"
  },
  Task_21077_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21077_Name = {
    Text = "내 차례야!이야"
  },
  Task_21078_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21078_Name = {
    Text = "완벽한 통과"
  },
  Task_21079_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21079_Name = {
    Text = "완벽한 통과"
  },
  Task_21080_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21080_Name = {
    Text = "완벽한 통과"
  },
  Task_21081_Desc = {
    Text = "최종전에서 1턴 동안 350 이상의 피해 입히기"
  },
  Task_21081_Name = {
    Text = "전력의 일격"
  },
  Task_21082_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21082_Name = {
    Text = "속전속결"
  },
  Task_21083_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21083_Name = {
    Text = "속전속결"
  },
  Task_21084_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21084_Name = {
    Text = "완벽한 통과"
  },
  Task_21085_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21085_Name = {
    Text = "완벽한 통과"
  },
  Task_21086_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21086_Name = {
    Text = "에너지 절약"
  },
  Task_21087_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21087_Name = {
    Text = "속전속결"
  },
  Task_21088_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21088_Name = {
    Text = "속전속결"
  },
  Task_21089_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21089_Name = {
    Text = "완벽한 통과"
  },
  Task_21090_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21090_Name = {
    Text = "속전속결"
  },
  Task_21091_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21091_Name = {
    Text = "속전속결"
  },
  Task_21092_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21092_Name = {
    Text = "속전속결"
  },
  Task_21093_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21093_Name = {
    Text = "속전속결"
  },
  Task_21094_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21094_Name = {
    Text = "속전속결"
  },
  Task_21095_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21095_Name = {
    Text = "속전속결"
  },
  Task_21096_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21096_Name = {
    Text = "속전속결"
  },
  Task_21097_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21097_Name = {
    Text = "속전속결"
  },
  Task_21098_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21098_Name = {
    Text = "속전속결"
  },
  Task_21099_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21099_Name = {
    Text = "기병의 보물창고"
  },
  Task_21100_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21100_Name = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21101_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_21101_Name = {
    Text = "악의 근절"
  },
  Task_21102_Desc = {
    Text = "클리어 시 8개 이상의 유물 보유"
  },
  Task_21102_Name = {
    Text = "기병의 보물창고"
  },
  Task_21103_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21103_Name = {
    Text = "에너지 절약"
  },
  Task_21104_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21104_Name = {
    Text = "내 차례야!이야"
  },
  Task_21105_Desc = {
    Text = "최종전에서 1턴 동안 300 이상의 피해 입히기"
  },
  Task_21105_Name = {
    Text = "전력의 일격"
  },
  Task_21106_Desc = {
    Text = "최종전에서 1턴 동안 3장 이상의 카드 뽑기"
  },
  Task_21106_Name = {Text = "드로우!"},
  Task_21107_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21107_Name = {
    Text = "완벽한 통과"
  },
  Task_21108_Desc = {
    Text = "최종전에서 1턴 동안 96000 이상의 피해 입히기"
  },
  Task_21108_Name = {
    Text = "전력의 일격"
  },
  Task_21110_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21110_Name = {
    Text = "에너지 절약"
  },
  Task_21111_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21111_Name = {
    Text = "에너지 절약"
  },
  Task_21112_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_21112_Name = {
    Text = "악의 근절"
  },
  Task_21113_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21113_Name = {
    Text = "완벽한 통과"
  },
  Task_21114_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21114_Name = {
    Text = "속전속결"
  },
  Task_21115_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21115_Name = {
    Text = "에너지 절약"
  },
  Task_21116_Desc = {
    Text = "남은 HP 80% 이상으로 클리어"
  },
  Task_21116_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21117_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21117_Name = {
    Text = "완벽한 통과"
  },
  Task_21118_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21118_Name = {
    Text = "속전속결"
  },
  Task_21119_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21119_Name = {
    Text = "에너지 절약"
  },
  Task_21120_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_21120_Name = {
    Text = "악의 근절"
  },
  Task_21121_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21121_Name = {
    Text = "에너지 절약"
  },
  Task_21122_Desc = {
    Text = "엘리트 전투에서 1턴 동안 1600 이상의 피해 입히기"
  },
  Task_21122_Name = {
    Text = "전력의 일격"
  },
  Task_21123_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21123_Name = {
    Text = "속전속결"
  },
  Task_21124_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21124_Name = {
    Text = "완벽한 통과"
  },
  Task_21125_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21125_Name = {
    Text = "완벽한 통과"
  },
  Task_21126_Desc = {
    Text = "엘리트 전투에서 1턴 동안 광기 폭발을 3회 이상 사용"
  },
  Task_21126_Name = {
    Text = "치명적인 마술"
  },
  Task_21127_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21127_Name = {
    Text = "속전속결"
  },
  Task_21128_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21128_Name = {
    Text = "완벽한 통과"
  },
  Task_21129_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21129_Name = {
    Text = "에너지 절약"
  },
  Task_21130_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21130_Name = {
    Text = "완벽한 통과"
  },
  Task_21131_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21131_Name = {
    Text = "무한의 포옹"
  },
  Task_21132_Desc = {
    Text = "최종전에서 1턴 동안 6000 이상의 피해 입히기"
  },
  Task_21132_Name = {
    Text = "전력의 일격"
  },
  Task_21133_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21133_Name = {Text = "드로우!"},
  Task_21134_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21134_Name = {
    Text = "완벽한 통과"
  },
  Task_21135_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 뽑기"
  },
  Task_21135_Name = {Text = "드로우!"},
  Task_21136_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_21136_Name = {
    Text = "속전속결"
  },
  Task_21137_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21137_Name = {
    Text = "속전속결"
  },
  Task_21138_Desc = {
    Text = "엘리트 전투에서 1턴 동안 1800 이상의 피해 입히기"
  },
  Task_21138_Name = {
    Text = "전력의 일격"
  },
  Task_21139_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21139_Name = {
    Text = "기병의 보물창고"
  },
  Task_21140_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21140_Name = {
    Text = "내 차례야!이야"
  },
  Task_21141_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 65%만큼의 방어막을 획득"
  },
  Task_21141_Name = {
    Text = "강철의 몸"
  },
  Task_21142_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21142_Name = {
    Text = "에너지 절약"
  },
  Task_21143_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_21143_Name = {
    Text = "영혼의 낙인"
  },
  Task_21144_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_21144_Name = {
    Text = "기병의 보물창고"
  },
  Task_21145_Desc = {
    Text = "연락 지점에서의 회복 횟수 1회 이하인 상태로 클리어"
  },
  Task_21145_Name = {
    Text = "불붙지 않은 자"
  },
  Task_21146_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21146_Name = {
    Text = "기병의 보물창고"
  },
  Task_21147_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21147_Name = {
    Text = "에너지 절약"
  },
  Task_21148_Desc = {
    Text = "엘리트 전투에서 1턴 동안 500 이상의 피해 입히기"
  },
  Task_21148_Name = {
    Text = "전력의 일격"
  },
  Task_21149_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_21149_Name = {
    Text = "악의 근절"
  },
  Task_21150_Desc = {
    Text = "3명 이상의 깨어남체를 깨어남시키기"
  },
  Task_21150_Name = {
    Text = "무한의 포옹"
  },
  Task_21151_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_21151_Name = {
    Text = "영혼의 낙인"
  },
  Task_21152_Desc = {
    Text = "탐색도 100% 달성"
  },
  Task_21152_Name = {
    Text = "비경 조망"
  },
  Task_21153_Desc = {
    Text = "최종전에서 1턴 동안 광기 폭발을 4회 이상 사용"
  },
  Task_21153_Name = {
    Text = "치명적인 마술"
  },
  Task_21154_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21154_Name = {
    Text = "에너지 절약"
  },
  Task_21155_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 60%의 방어막 획득"
  },
  Task_21155_Name = {
    Text = "강철의 몸"
  },
  Task_21156_Desc = {
    Text = "클리어 시 8개 이상의 유물 보유"
  },
  Task_21156_Name = {
    Text = "기병의 보물창고"
  },
  Task_21157_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21157_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21158_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 뽑기"
  },
  Task_21158_Name = {Text = "드로우!"},
  Task_21159_Desc = {
    Text = "최종전에서 1턴 동안 5200 이상의 피해 입히기"
  },
  Task_21159_Name = {
    Text = "전력의 일격"
  },
  Task_21160_Desc = {
    Text = "최종전에서 1턴 동안 3장 이상의 카드 뽑기"
  },
  Task_21160_Name = {Text = "드로우!"},
  Task_21161_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21161_Name = {
    Text = "완벽한 통과"
  },
  Task_21162_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 65%만큼의 방어막을 획득"
  },
  Task_21162_Name = {
    Text = "강철의 몸"
  },
  Task_21163_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21163_Name = {
    Text = "에너지 절약"
  },
  Task_21164_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21164_Name = {
    Text = "기병의 보물창고"
  },
  Task_21165_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 사용"
  },
  Task_21165_Name = {
    Text = "내 차례야!이야"
  },
  Task_21166_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21166_Name = {
    Text = "완벽한 통과"
  },
  Task_21167_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_21167_Name = {
    Text = "영혼의 낙인"
  },
  Task_21168_Desc = {
    Text = "최종전에서 1턴 동안 120의 피해 입히기"
  },
  Task_21168_Name = {
    Text = "전력의 일격"
  },
  Task_21169_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21169_Name = {
    Text = "우아하고 정확한"
  },
  Task_21170_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21170_Name = {
    Text = "우아하고 정확한"
  },
  Task_21171_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_21171_Name = {
    Text = "악의 근절"
  },
  Task_21172_Desc = {
    Text = "최종전에서 1턴 동안 3장 이상의 카드 뽑기"
  },
  Task_21172_Name = {Text = "드로우!"},
  Task_21173_Desc = {
    Text = "3명 이상의 깨어남체를 깨어남시키기"
  },
  Task_21173_Name = {
    Text = "무한의 포옹"
  },
  Task_21174_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21174_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21176_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21176_Name = {
    Text = "속전속결"
  },
  Task_21177_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21177_Name = {
    Text = "속전속결"
  },
  Task_21178_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21178_Name = {
    Text = "에너지 절약"
  },
  Task_21179_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21179_Name = {
    Text = "완벽한 통과"
  },
  Task_21180_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21180_Name = {
    Text = "완벽한 통과"
  },
  Task_21181_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21181_Name = {
    Text = "완벽한 통과"
  },
  Task_21182_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21182_Name = {
    Text = "에너지 절약"
  },
  Task_21183_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21183_Name = {
    Text = "에너지 절약"
  },
  Task_21184_Desc = {
    Text = "탐색도 100% 달성"
  },
  Task_21184_Name = {
    Text = "비경 조망"
  },
  Task_21185_Desc = {
    Text = "최종전에서 1턴 동안 1000 이상의 피해 입히기"
  },
  Task_21185_Name = {
    Text = "전력의 일격"
  },
  Task_21186_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21186_Name = {
    Text = "속전속결"
  },
  Task_21187_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21187_Name = {
    Text = "속전속결"
  },
  Task_21188_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21188_Name = {
    Text = "속전속결"
  },
  Task_21189_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21189_Name = {
    Text = "속전속결"
  },
  Task_21190_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21190_Name = {
    Text = "속전속결"
  },
  Task_21191_Desc = {
    Text = "클리어 시 증상 카드 1장 이하"
  },
  Task_21191_Name = {
    Text = "에너지 절약"
  },
  Task_21192_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21192_Name = {
    Text = "속전속결"
  },
  Task_21193_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21193_Name = {
    Text = "속전속결"
  },
  Task_21194_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21194_Name = {
    Text = "속전속결"
  },
  Task_21195_Desc = {
    Text = "최종전에서 1턴 동안 7300 이상의 피해 입히기"
  },
  Task_21195_Name = {
    Text = "전력의 일격"
  },
  Task_21196_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21196_Name = {
    Text = "속전속결"
  },
  Task_21197_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21197_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21198_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21198_Name = {
    Text = "속전속결"
  },
  Task_21199_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 사용"
  },
  Task_21199_Name = {
    Text = "내 차례야!이야"
  },
  Task_21200_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_21200_Name = {
    Text = "에너지 절약"
  },
  Task_21201_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21201_Name = {
    Text = "완벽한 통과"
  },
  Task_21202_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21202_Name = {
    Text = "완벽한 통과"
  },
  Task_21203_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21203_Name = {
    Text = "완벽한 통과"
  },
  Task_21204_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_21204_Name = {
    Text = "기병의 보물창고"
  },
  Task_21205_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21205_Name = {
    Text = "에너지 절약"
  },
  Task_21206_Desc = {
    Text = "서로 다른 각인 3종류 이상 획득"
  },
  Task_21206_Name = {
    Text = "영혼의 낙인"
  },
  Task_21207_Desc = {
    Text = "2명 이상의 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21207_Name = {
    Text = "무한의 포옹"
  },
  Task_21208_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21208_Name = {
    Text = "우아하고 정확한"
  },
  Task_21209_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21209_Name = {
    Text = "기병의 보물창고"
  },
  Task_21210_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 사용"
  },
  Task_21210_Name = {
    Text = "내 차례야!이야"
  },
  Task_21211_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21211_Name = {
    Text = "완벽한 통과"
  },
  Task_21212_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21212_Name = {
    Text = "속전속결"
  },
  Task_21213_Desc = {
    Text = "최종전에서 1턴 동안 2500 이상의 피해 입히기"
  },
  Task_21213_Name = {
    Text = "전력의 일격"
  },
  Task_21214_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21214_Name = {Text = "드로우!"},
  Task_21215_Desc = {
    Text = "최종전에서 1턴 동안 6장 이상의 카드 사용"
  },
  Task_21215_Name = {
    Text = "내 차례야!이야"
  },
  Task_21216_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21216_Name = {
    Text = "우아하고 정확한"
  },
  Task_21217_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21217_Name = {
    Text = "우아하고 정확한"
  },
  Task_21218_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21218_Name = {
    Text = "무한의 포옹"
  },
  Task_21219_Desc = {
    Text = "최종전에서 1턴 동안 3장 이상의 카드 뽑기"
  },
  Task_21219_Name = {Text = "드로우!"},
  Task_21220_Desc = {
    Text = "3명 이상의 깨어남체를 깨어남시키기"
  },
  Task_21220_Name = {
    Text = "무한의 포옹"
  },
  Task_21221_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21221_Name = {
    Text = "우아하고 정확하게"
  },
  Task_21222_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21222_Name = {
    Text = "기병의 보물창고"
  },
  Task_21223_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21223_Name = {
    Text = "완벽한 통과"
  },
  Task_21224_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21224_Name = {
    Text = "완벽한 통과"
  },
  Task_21225_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_21225_Name = {
    Text = "악의 근절"
  },
  Task_21226_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_21226_Name = {
    Text = "기병의 보물창고"
  },
  Task_21227_Desc = {
    Text = "4종류 이상의 서로 다른 각인을 획득"
  },
  Task_21227_Name = {
    Text = "영혼의 낙인"
  },
  Task_21228_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21228_Name = {
    Text = "완벽한 통과"
  },
  Task_21229_Desc = {
    Text = "연락 지점에서 HP를 회복하지 않고 클리어"
  },
  Task_21229_Name = {
    Text = "불붙지 않은 자"
  },
  Task_21230_Desc = {
    Text = "탐색도 100% 달성"
  },
  Task_21230_Name = {
    Text = "비경 조망"
  },
  Task_21231_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21231_Name = {
    Text = "속전속결"
  },
  Task_21232_Desc = {
    Text = "연락 지점에서의 회복 횟수 1회 이하인 상태로 클리어"
  },
  Task_21232_Name = {
    Text = "불붙지 않은 자"
  },
  Task_21233_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21233_Name = {
    Text = "완벽한 통과"
  },
  Task_21234_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21234_Name = {
    Text = "완벽한 통과"
  },
  Task_21235_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 뽑기"
  },
  Task_21235_Name = {Text = "드로우!"},
  Task_21236_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21236_Name = {
    Text = "속전속결"
  },
  Task_21237_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21237_Name = {
    Text = "속전속결"
  },
  Task_21238_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21238_Name = {
    Text = "완벽한 통과"
  },
  Task_21239_Desc = {
    Text = "최종전에서 1턴 동안 광기 폭발을 3회 이상 사용"
  },
  Task_21239_Name = {
    Text = "치명적인 마술"
  },
  Task_21240_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21240_Name = {
    Text = "완벽한 통과"
  },
  Task_21241_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21241_Name = {
    Text = "완벽한 통과"
  },
  Task_21242_Desc = {
    Text = "클리어 시 HP 80% 이상"
  },
  Task_21242_Name = {
    Text = "우아하고 정확한"
  },
  Task_21243_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21243_Name = {
    Text = "속전속결"
  },
  Task_21244_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21244_Name = {
    Text = "속전속결"
  },
  Task_21245_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21245_Name = {
    Text = "속전속결"
  },
  Task_21246_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21246_Name = {
    Text = "속전속결"
  },
  Task_21247_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21247_Name = {
    Text = "속전속결"
  },
  Task_21248_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21248_Name = {
    Text = "속전속결"
  },
  Task_21249_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21249_Name = {
    Text = "속전속결"
  },
  Task_21250_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_21250_Name = {
    Text = "속전속결"
  },
  Task_21251_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21251_Name = {
    Text = "속전속결"
  },
  Task_21252_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21252_Name = {
    Text = "속전속결"
  },
  Task_21253_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21253_Name = {
    Text = "속전속결"
  },
  Task_21254_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21254_Name = {
    Text = "우아하고 정확한"
  },
  Task_21255_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21255_Name = {
    Text = "속전속결"
  },
  Task_21256_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21256_Name = {
    Text = "속전속결"
  },
  Task_21257_Desc = {
    Text = "엘리트 전투에서 1턴 동안 6000 이상의 피해 입히기"
  },
  Task_21257_Name = {
    Text = "전력의 일격"
  },
  Task_21258_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_21258_Name = {
    Text = "기병의 보물창고"
  },
  Task_21259_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_21259_Name = {
    Text = "내 차례야!이야"
  },
  Task_21260_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21260_Name = {
    Text = "완벽한 통과"
  },
  Task_21261_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21261_Name = {
    Text = "완벽한 통과"
  },
  Task_21262_Desc = {
    Text = "4종류 이상의 서로 다른 각인을 획득"
  },
  Task_21262_Name = {
    Text = "영혼의 낙인"
  },
  Task_21263_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21263_Name = {
    Text = "완벽한 통과"
  },
  Task_21264_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_21264_Name = {
    Text = "기병의 보물창고"
  },
  Task_21265_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21265_Name = {
    Text = "속전속결"
  },
  Task_21266_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21266_Name = {
    Text = "완벽한 통과"
  },
  Task_21267_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21267_Name = {
    Text = "완벽한 통과"
  },
  Task_21268_Desc = {
    Text = "3명 이상의 깨어남체를 깨어남시키기"
  },
  Task_21268_Name = {
    Text = "무한의 포옹"
  },
  Task_21269_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21269_Name = {
    Text = "완벽한 통과"
  },
  Task_21270_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21270_Name = {
    Text = "속전속결"
  },
  Task_21271_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_21271_Name = {
    Text = "기병의 보물창고"
  },
  Task_21272_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21272_Name = {
    Text = "속전속결"
  },
  Task_21273_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21273_Name = {
    Text = "속전속결"
  },
  Task_21274_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21274_Name = {
    Text = "완벽한 통과"
  },
  Task_21275_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_21275_Name = {
    Text = "속전속결"
  },
  Task_21276_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21276_Name = {
    Text = "완벽한 통과"
  },
  Task_21277_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21277_Name = {
    Text = "속전속결"
  },
  Task_21278_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21278_Name = {
    Text = "완벽한 통과"
  },
  Task_21279_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21279_Name = {
    Text = "완벽한 통과"
  },
  Task_21280_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21280_Name = {
    Text = "무한의 포옹"
  },
  Task_21281_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_21281_Name = {
    Text = "에너지 절약"
  },
  Task_21282_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21282_Name = {
    Text = "완벽한 통과"
  },
  Task_21283_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21283_Name = {
    Text = "완벽한 통과"
  },
  Task_21284_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21284_Name = {
    Text = "완벽한 통과"
  },
  Task_21285_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21285_Name = {
    Text = "완벽한 통과"
  },
  Task_21286_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21286_Name = {
    Text = "완벽한 통과"
  },
  Task_21287_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21287_Name = {
    Text = "완벽한 통과"
  },
  Task_21288_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21288_Name = {
    Text = "완벽한 통과"
  },
  Task_21289_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21289_Name = {
    Text = "완벽한 통과"
  },
  Task_21290_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21290_Name = {
    Text = "완벽한 통과"
  },
  Task_21291_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21291_Name = {
    Text = "완벽한 통과"
  },
  Task_21292_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21292_Name = {
    Text = "완벽한 통과"
  },
  Task_21293_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_21293_Name = {
    Text = "속전속결"
  },
  Task_21294_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 60%의 방어막 획득"
  },
  Task_21294_Name = {
    Text = "강철의 몸"
  },
  Task_21295_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_21295_Name = {
    Text = "무한의 포옹"
  },
  Task_21296_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_21296_Name = {
    Text = "우아하고 정확한"
  },
  Task_21297_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 뽑기"
  },
  Task_21297_Name = {Text = "드로우!"},
  Task_21298_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_21298_Name = {
    Text = "속전속결"
  },
  Task_21299_Desc = {
    Text = "최종전에서 15턴 이내에 승리"
  },
  Task_21299_Name = {
    Text = "속전속결"
  },
  Task_21300_Desc = {
    Text = "찍찍, 찍찍...!!"
  },
  Task_21300_Name = {Text = "찍찍!"},
  Task_21301_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_21301_Name = {
    Text = "완벽한 통과"
  },
  Task_21401_Desc = {
    Text = "카드 50장 사용하기"
  },
  Task_21401_Name = {
    Text = "일일 훈련"
  },
  Task_21794_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_21795_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_21821_Desc = {
    Text = "초기 40점, 3턴 이후 매 턴 5점 감소"
  },
  Task_21821_Name = {
    Text = "엘리트 라운드 수  <size=20><color=#747474>초기 40점, 3라운드 이후 매 턴마다 5점 감소</color></size>"
  },
  Task_21822_Desc = {
    Text = "초기 40점, 클리어 시 40스텝을 초과한 후 매 스텝마다 2점씩 감소합니다"
  },
  Task_21822_Name = {
    Text = "누적 스텝 수  <size=20><color=#747474>초기 40점, 클리어 시 40스텝을 초과한 후 매 스텝마다 2점 감소</color></size>"
  },
  Task_21823_Desc = {
    Text = "초기 600점, 12턴 이후 매 턴 60점 감소"
  },
  Task_21823_Name = {
    Text = "최종전 턴 수  <size=20><color=#747474>초기 600분, 12턴 이후 매 턴 60분 감소</color></size>"
  },
  Task_21824_Desc = {
    Text = "각 게임 초기 30점, 2턴 이후 매 턴 3점 감소"
  },
  Task_21824_Name = {
    Text = "전투 라운드 수  <size=20><color=#747474>매 경기 초기 30점, 2라운드 이후 매 라운드 3점 차감</color></size>"
  },
  Task_21907_Desc = {
    Text = "50회 누적 깨어남"
  },
  Task_21908_Desc = {
    Text = "누적 300회 깨어남"
  },
  Task_21914_Desc = {
    Text = "수호자 조사 등급 40 달성"
  },
  Task_21915_Desc = {
    Text = "「조사 작전」 제1장 완료"
  },
  Task_21916_Desc = {
    Text = "수호자 조사 등급 30 달성"
  },
  Task_21917_Desc = {
    Text = "수호자 조사 등급 20 달성"
  },
  Task_21918_Desc = {
    Text = "수호자 조사 등급 50 달성"
  },
  Task_22347_Desc = {
    Text = "유우하시를 무찌르다"
  },
  Task_22347_Name = {Text = "목표"},
  Task_22348_Desc = {
    Text = "충동을 통제하는 아우구스트"
  },
  Task_22348_Name = {Text = "목표"},
  Task_22349_Desc = {
    Text = "공주님을 지키기"
  },
  Task_22349_Name = {Text = "목표"},
  Task_22350_Desc = {
    Text = "아우구스트를 제지하라"
  },
  Task_22350_Name = {Text = "목표"},
  Task_22351_Desc = {
    Text = "아그리파를 찾아라"
  },
  Task_22351_Name = {Text = "목표"},
  Task_22352_Desc = {
    Text = "모래폭풍 피하기"
  },
  Task_22352_Name = {Text = "목표"},
  Task_22353_Desc = {
    Text = "에리카를 보호하십시오"
  },
  Task_22353_Name = {Text = "목표"},
  Task_22354_Desc = {
    Text = "에리카를 찾다"
  },
  Task_22354_Name = {Text = "목표"},
  Task_22355_Desc = {
    Text = "유우하시를 따라가세요"
  },
  Task_22355_Name = {Text = "목표"},
  Task_22356_Desc = {
    Text = "분노한 노예를 물리치다"
  },
  Task_22356_Name = {Text = "목표"},
  Task_22358_Desc = {
    Text = "최대 생명의 50%에 해당하는 방어막 추가"
  },
  Task_22358_Name = {
    Text = "생명의 보호 Ⅱ"
  },
  Task_22359_Desc = {
    Text = "최대 생명의 30%를 방어막으로 추가"
  },
  Task_22359_Name = {
    Text = "생명의 보호 Ⅰ"
  },
  Task_22380_Desc = {
    Text = "10개의 메인 줄기 제5장 「@1@2」의 분해점을 찾으세요"
  },
  Task_22380_Desc2 = {
    Text = "10개의 메인 줄기 제5장 「스톰아이즈」의 분해점 찾기"
  },
  Task_22380_Name2 = {
    Text = "숨겨진 속삭임Ⅴ"
  },
  Task_22381_Desc = {
    Text = "600번의 스워시 코르도를 완료"
  },
  Task_22381_Name = {
    Text = "곡선 시계열 Ⅴ"
  },
  Task_22382_Desc = {
    Text = "100회 스워시 코르도 완료"
  },
  Task_22382_Name = {
    Text = "곡선 시계열 Ⅱ"
  },
  Task_22383_Desc = {
    Text = "50번 스워시 코르도 완료"
  },
  Task_22383_Name = {
    Text = "곡선 시계열"
  },
  Task_22384_Desc = {
    Text = "스워시 코르도 400번 완료"
  },
  Task_22384_Name = {
    Text = "곡선 시계열 Ⅳ"
  },
  Task_22385_Desc = {
    Text = "200번 스워시 코르도 완료"
  },
  Task_22385_Name = {
    Text = "곡선 시계열 Ⅲ"
  },
  Task_22387_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_22387_Desc2 = {
    Text = "조사 완료 이벤트 「스톰아이즈」"
  },
  Task_22387_Name2 = {
    Text = "미궁 삼각형"
  },
  Task_22388_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_22388_Desc2 = {
    Text = "조사 이벤트 「스톰아이즈」에서 공명을 3회"
  },
  Task_22388_Name2 = {
    Text = "무망한 울림"
  },
  Task_22389_Desc = {
    Text = "조사 이벤트 「스톰아이즈」 어려움 난이도 완료"
  },
  Task_22389_Name = {
    Text = "미궁 삼각형·어려움"
  },
  Task_22390_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 7회 발생"
  },
  Task_22390_Desc2 = {
    Text = "조사 이벤트 「스톰아이즈」에서 공명 7회"
  },
  Task_22390_Name2 = {
    Text = "무망한 울림 Ⅲ"
  },
  Task_22391_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_22391_Desc2 = {
    Text = "조사 이벤트 「스톰아이즈」에서 공명을 6회"
  },
  Task_22391_Name2 = {
    Text = "무망한 울림 Ⅱ"
  },
  Task_22392_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 10회"
  },
  Task_22392_Desc2 = {
    Text = "조사 이벤트 「스톰아이즈」에서 공명 10회"
  },
  Task_22392_Name2 = {
    Text = "무망한 울림 Ⅳ"
  },
  Task_23613_Desc = {
    Text = "다프다일 찾기"
  },
  Task_23613_Name = {Text = "목표"},
  Task_23614_Desc = {
    Text = "백화점으로 가다"
  },
  Task_23614_Name = {Text = "목표"},
  Task_23615_Desc = {
    Text = "촬영 완료"
  },
  Task_23615_Name = {Text = "목표"},
  Task_23616_Desc = {
    Text = "이벤트 장소로 돌아가기"
  },
  Task_23616_Name = {Text = "목표"},
  Task_23617_Desc = {
    Text = "촬영 진행"
  },
  Task_23617_Name = {Text = "목표"},
  Task_23618_Desc = {
    Text = "외부에서 자료 수집"
  },
  Task_23618_Name = {Text = "목표"},
  Task_23619_Desc = {Text = "적 격퇴"},
  Task_23619_Name = {Text = "목표"},
  Task_23620_Desc = {
    Text = "요양원 방문"
  },
  Task_23620_Name = {Text = "목표"},
  Task_23646_Desc = {
    Text = "누적 깨어남 1000회"
  },
  Task_23708_Desc = {
    Text = "최종전 턴, 추가로 5장 카드를 뽑고, 100점을 획득합니다"
  },
  Task_23708_Name = {
    Text = "다다익선 <size=20><color=#747474>최종전에서 1턴 동안 추가로 5장의 카드를 드로우</color></size>"
  },
  Task_23709_Desc = {
    Text = "5개의 황금 유물을 획득하고，100점을 획득"
  },
  Task_23709_Name = {
    Text = "반짝이는 금빛 <size=20><color=#747474>황금 유물 5개 획득</color></size>"
  },
  Task_23710_Desc = {
    Text = "2개의 저주받은 유물을 획득, 100점을 획득합니다"
  },
  Task_23710_Name = {
    Text = "기병의 보물창고  <size=20><color=#747474>2개의 저주받은 창조물을 획득</color></size>"
  },
  Task_23711_Desc = {
    Text = "최종전에서 한 턴에 7장의 카드를 내어 100점을 획득했습니다"
  },
  Task_23711_Name = {
    Text = "내 차례야!  <size=20><color=#747474>최종전에서 한 턴에 7장의 카드를 사용했습니다</color></size>"
  },
  Task_23712_Desc = {
    Text = "4명의 깨어남체를 깨어남하여 100점을 획득합니다."
  },
  Task_23712_Name = {
    Text = "깨어남의 순간  <size=20><color=#747474>웨이크업 바디 4명 깨어남</color></size>"
  },
  Task_23713_Desc = {
    Text = "최종전 1턴에 추가로 3 산출력 획득, 100점 획득"
  },
  Task_23713_Name = {
    Text = "오버클럭 <size=20><color=#747474>최종전에서 1턴 동안 추가로 3의 산출력을 획득</color></size>"
  },
  Task_23714_Desc = {
    Text = "최종전 한 턴에 최소 3번 광기 폭발을 사용하여 100점을 획득합니다"
  },
  Task_23714_Name = {
    Text = "치명적인 마술  <size=20><color=#747474>최종전 한 턴에 3번 이상 광기 폭발 사용</color></size>"
  },
  Task_23715_Desc = {
    Text = "11개의 각인을 획득하고, 100점을 획득했습니다."
  },
  Task_23715_Name = {
    Text = "각인된 힘  <size=20><color=#747474> 11개의 각인을 획득</color></size>"
  },
  Task_23716_Desc = {
    Text = "최종전 1턴에 리더의 최대 생명 50%의 데미지를 주고 100점을 획득합니다"
  },
  Task_23716_Name = {
    Text = "재액 강림 <size=20><color=#747474>최종전에서 1턴 동안 보스 최대 HP의 50% 이상의 피해 입히기</color></size>"
  },
  Task_23717_Desc = {
    Text = "9종의 다른 각인을 획득하고, 100점을 획득하면"
  },
  Task_23717_Name = {
    Text = "각인 수집  <size=20><color=#747474>각인 9개 획득</color></size>"
  },
  Task_23718_Desc = {
    Text = "최종전 1턴 동안 최대 생명의 80%의 방어막을 획득, 100점 획득,"
  },
  Task_23718_Name = {
    Text = "강철의 몸  <size=20><color=#747474>최종전 1 턴 최대 생명 80%의 방어막 획득</color></size>"
  },
  Task_23719_Desc = {
    Text = "클리어 시 증상 카드 4장 이상 보유 시 100점을 획득합니다"
  },
  Task_23719_Name = {
    Text = "불치병 <size=20><color=#747474>클리어 시 증상 카드 4장 이상 보유</color></size>"
  },
  Task_23720_Desc = {
    Text = "최종전에서 매 턴마다 광기 폭발을 사용하여 100점을 획득한다"
  },
  Task_23720_Name = {
    Text = "광란의 공연 <size=20><color=#747474>최종전에서 매 턴 광기 폭발 사용</color></size>"
  },
  Task_23721_Desc = {
    Text = "7개의 유물을 획득하고, 100점을 획득."
  },
  Task_23721_Name = {
    Text = "풍성한 수확 <size=20><color=#747474>7개의 유물을 획득</color></size>"
  },
  Task_23722_Desc = {
    Text = "임의의 전투에서 한 턴에 4명의 적을 처치하면 [Score:100]점을 획득합니다"
  },
  Task_23722_Name = {
    Text = "무자비<size=20><color=#747474>임의의 전투에서 한 턴에 4명의 적을 제거</color></size>"
  },
  Task_23789_Desc = {
    Text = "누적 로그인 30 일"
  },
  Task_23868_Desc = {
    Text = "페이즈 체스 5회 승리"
  },
  Task_23868_Name = {
    Text = "주간 보상"
  },
  Task_23869_Desc = {
    Text = "페이즈 체스에서 고급 Ⅰ 티어 도달"
  },
  Task_23873_Desc = {
    Text = "최종전 1턴에 리더의 최대 생명 30%의 데미지를 주고 100점을 획득합니다"
  },
  Task_23873_Name = {
    Text = "재액 강림 <size=20><color=#747474>최종전에서 1턴 동안 보스 최대 HP의 30% 이상의 피해 입히기</color></size>"
  },
  Task_23874_Desc = {
    Text = "5개의 황금 또는 저주받은 유물 획득 시 100점 득점"
  },
  Task_23874_Name = {
    Text = "선악불문 <size=20><color=#747474>황금 유물과 저주받은 유물을 합계 5개 획득할 경우 100점 획득</color></size>"
  },
  Task_23875_Desc = {
    Text = "8종의 다른 각인을 획득하고, 100점을 획득합니다."
  },
  Task_23875_Name = {
    Text = "각인 수집  <size=20><color=#747474>8종의 다양한 각인 획득</color></size>"
  },
  Task_23876_Desc = {
    Text = "10개의 각인을 획득하고, 100점을 획득합니다"
  },
  Task_23876_Name = {
    Text = "각인된 힘  <size=20><color=#747474>10개의 각인 획득</color></size>"
  },
  Task_23877_Desc = {
    Text = "최종전 １턴에 최소 ４번 광기 폭발을 사용하여 １００점을 획득"
  },
  Task_23877_Name = {
    Text = "치명적인 마술  <size=20><color=#747474>최종전 턴에 최소 4번 광기 폭발 사용</color></size>"
  },
  Task_23878_Desc = {
    Text = "전투에서 한 턴에 3명의 적을 처치하면 100점을 획득합니다"
  },
  Task_23878_Name = {
    Text = "무자비<size=20><color=#747474>임의의 전투에서 한 턴에 3명의 적을 제거</color></size>"
  },
  Task_23879_Desc = {
    Text = "8개의 유물을 획득하고 100점을 얻었습니다"
  },
  Task_23879_Name = {
    Text = "풍성한 수확 <size=20><color=#747474>8개의 유물을 획득</color></size>"
  },
  Task_23885_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23886_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23887_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23888_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23889_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23890_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23891_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23892_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23893_Desc = {
    Text = "의식 잠수 「창백한 후예」 보통 클리어"
  },
  Task_23893_Name = {
    Text = "클리어 보상"
  },
  Task_23894_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_23895_Desc = {
    Text = "특파 기록 「비 내리는 마을의 유령」 보통 클리어"
  },
  Task_23895_Name = {
    Text = "클리어 보상"
  },
  Task_23896_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_24139_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_24139_Name = {
    Text = "기병의 보물창고"
  },
  Task_24140_Desc = {
    Text = "최종전에서 1턴 동안 6장 이상의 카드 사용"
  },
  Task_24140_Name = {
    Text = "내 차례야!이야"
  },
  Task_24141_Desc = {
    Text = "5개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_24141_Name = {
    Text = "기병의 보물창고"
  },
  Task_24142_Desc = {
    Text = "최종전에서 1턴 동안 6장 이상의 카드 사용"
  },
  Task_24142_Name = {
    Text = "내 차례야!이야"
  },
  Task_24177_Desc = {
    Text = "동력실타래 탈출"
  },
  Task_24177_Name = {Text = "목표"},
  Task_24403_Desc = {
    Text = "의심스러운 마차를 따라잡다"
  },
  Task_24403_Name = {Text = "목표"},
  Task_24404_Desc = {
    Text = "회피「N」의 시선"
  },
  Task_24404_Name = {Text = "목표"},
  Task_24405_Desc = {
    Text = "\"장미의 이름\"초대장을 찾아보기"
  },
  Task_24405_Name = {Text = "목표"},
  Task_24406_Desc = {
    Text = "인공 미궁에 들어가서 사건 당일로 돌아간다"
  },
  Task_24406_Name = {Text = "목표"},
  Task_24407_Desc = {
    Text = "의심스러운 남자를 잡아라."
  },
  Task_24407_Name = {Text = "목표"},
  Task_24408_Desc = {
    Text = "시녀 가렌을 따라가다"
  },
  Task_24408_Name = {Text = "목표"},
  Task_24409_Desc = {
    Text = "블랙셔도우의 공격을 저지하다."
  },
  Task_24409_Name = {Text = "목표"},
  Task_24410_Desc = {
    Text = "블랙셔도우의 공격을 방어하다"
  },
  Task_24410_Name = {Text = "목표"},
  Task_24411_Desc = {
    Text = "랑베르 선생님을 체포하라"
  },
  Task_24411_Name = {Text = "목표"},
  Task_24412_Desc = {
    Text = "격퇴 융식 몬스터"
  },
  Task_24412_Name = {Text = "목표"},
  Task_24457_Desc = {
    Text = "최종전 1턴에 최소 3/4번 광기 폭발을 사용하여 50/100점을 획득합니다."
  },
  Task_24457_Name = {
    Text = "치명적인 마술<size=20><color=#747474>최종전에서 한 턴에 최소 3번 광기 폭발 사용</color></size>"
  },
  Task_24458_Desc = {
    Text = "7/9/11개의 각인을 획득 시 30/60/100점을 획득합니다."
  },
  Task_24458_Name = {
    Text = "각인된 힘<size=20><color=#747474>7개의 각인 획득</color></size>"
  },
  Task_24459_Desc = {
    Text = "4/5/6개의 황금 유물을 획득하면 30점/60점/100점을 획득합니다."
  },
  Task_24459_Name = {
    Text = "반짝이는 금빛 <size=20><color=#747474>황금 유물 5개 획득</color></size>"
  },
  Task_24460_Desc = {
    Text = "4/5/6개의 황금 유물을 획득하면 30점/60점/100점을 획득합니다."
  },
  Task_24460_Name = {
    Text = "반짝이는 금빛 <size=20><color=#747474>황금 유물 4개 획득</color></size>"
  },
  Task_24461_Desc = {
    Text = "4/5/6개의 황금 또는 저주받은 유물을 획득 시 30/60/100점."
  },
  Task_24461_Name = {
    Text = "선악불문 <size=20><color=#747474>황금 유물과 저주받은 유물을 합계 6개 획득할 경우 100점 획득</color></size>"
  },
  Task_24462_Desc = {
    Text = "4/5/6개의 황금 또는 저주받은 유물을 획득 시 30/60/100점."
  },
  Task_24462_Name = {
    Text = "선악불문 <size=20><color=#747474>황금 유물과 저주받은 유물을 합계 4개 획득할 경우 100점 획득</color></size>"
  },
  Task_24463_Desc = {
    Text = "4/5/6개의 황금 또는 저주받은 유물을 획득 시 30/60/100점."
  },
  Task_24463_Name = {
    Text = "선악불문 <size=20><color=#747474>황금 유물과 저주받은 유물을 합계 5개 획득할 경우 100점 획득</color></size>"
  },
  Task_24464_Desc = {
    Text = "7/9/11개의 각인을 획득 시 30/60/100점을 획득합니다."
  },
  Task_24464_Name = {
    Text = "각인된 힘<size=20><color=#747474>9개 획득</color></size>"
  },
  Task_24465_Desc = {
    Text = "3/4명의 깨어남체를 깨어남하고, 50/100점을 획득합니다."
  },
  Task_24465_Name = {
    Text = "깨어남의 순간<size=20><color=#747474>깨어남체 3명 깨어남</color></size>"
  },
  Task_24466_Desc = {
    Text = "최종전에서 1턴에 5/7/9장의 카드를 내면 30/60/100점을 획득합니다."
  },
  Task_24466_Name = {
    Text = "내 차례야!<size=20><color=#747474>최종전에서 한 턴에 9장의 카드를 플레이했습니다</color></size>"
  },
  Task_24467_Desc = {
    Text = "3/4명의 깨어남체를 깨어남하고, 50/100점을 획득합니다."
  },
  Task_24467_Name = {
    Text = "깨어남의 순간<size=20><color=#747474>4명의 깨어남체 깨어남시키기</color></size>"
  },
  Task_24468_Desc = {
    Text = "최종전 1턴에 최소 3/4번 광기 폭발을 사용하여 50/100점을 획득합니다."
  },
  Task_24468_Name = {
    Text = "치명적인 마술<size=20><color=#747474>최종전 일턴에 최소 4회 광기 폭발 사용</color></size>"
  },
  Task_24469_Desc = {
    Text = "최종전 1턴 추가 2/3/4 산출력을 획득하고, 30/60/100점을 획득합니다."
  },
  Task_24469_Name = {
    Text = "오버클럭 <size=20><color=#747474>최종전에서 1턴 동안 추가로 2의 산출력을 획득</color></size>"
  },
  Task_24470_Desc = {
    Text = "최종전 1턴 추가 2/3/4 산출력을 획득하고, 30/60/100점을 획득합니다."
  },
  Task_24470_Name = {
    Text = "오버클럭 <size=20><color=#747474>최종전에서 1턴 동안 추가로 3의 산출력을 획득</color></size>"
  },
  Task_24471_Desc = {
    Text = "클리어 시 증상 카드 수량이 3/4장 이상이면 50/100점을 획득합니다."
  },
  Task_24471_Name = {
    Text = "불치병 <size=20><color=#747474>클리어 시 증상 카드 3장 이상 보유</color></size>"
  },
  Task_24472_Desc = {
    Text = "클리어 시 증상 카드 수량이 3/4장 이상이면 50/100점을 획득합니다."
  },
  Task_24472_Name = {
    Text = "불치병 <size=20><color=#747474>클리어 시 증상 카드 4장 이상 보유</color></size>"
  },
  Task_24473_Desc = {
    Text = "최종전 1턴 추가 2/3/4 산출력을 획득하고, 30/60/100점을 획득합니다."
  },
  Task_24473_Name = {
    Text = "오버클럭 <size=20><color=#747474>최종전에서 1턴 동안 추가로 4의 산출력을 획득</color></size>"
  },
  Task_24474_Desc = {
    Text = "클리어 시 임의의 깨어남체 카드가 2/1장 이하인 경우 50/100점을 획득합니다."
  },
  Task_24474_Name = {
    Text = "잊혀진 자<size=20><color=#747474>클리어 시 깨어남체 1명의 카드가 2장 이하</color></size>"
  },
  Task_24475_Desc = {
    Text = "최종전에서 연속 3/4/5턴 동안 광기 폭발을 사용하면 30/60/100분을 획득합니다."
  },
  Task_24475_Name = {
    Text = "광란의 공연 <size=20><color=#747474>최종전에서 5턴 연속으로 광기 폭발 사용</color></size>"
  },
  Task_24476_Desc = {
    Text = "클리어 시 임의의 깨어남체 카드가 2/1장 이하인 경우 50/100점을 획득합니다."
  },
  Task_24476_Name = {
    Text = "잊혀진 자<size=20><color=#747474>클리어 시 깨어남체 1명의 카드가 1장 이하</color></size>"
  },
  Task_24477_Desc = {
    Text = "최종전에서 연속 3/4/5턴 동안 광기 폭발을 사용하면 30/60/100분을 획득합니다."
  },
  Task_24477_Name = {
    Text = "광란의 공연 <size=20><color=#747474>최종전에서 4턴 연속으로 광기 폭발 사용</color></size>"
  },
  Task_24478_Desc = {
    Text = "6/7/8개의 유물을 획득하면, 30/60/100점을 획득합니다."
  },
  Task_24478_Name = {
    Text = "풍성한 수확 <size=20><color=#747474>7개의 유물을 획득</color></size>"
  },
  Task_24479_Desc = {
    Text = "6/7/8개의 유물을 획득하면, 30/60/100점을 획득합니다."
  },
  Task_24479_Name = {
    Text = "풍성한 수확 <size=20><color=#747474>6개의 유물을 획득</color></size>"
  },
  Task_24480_Desc = {
    Text = "최종전 1턴에 최대 생명의 25%/50%/75%의 방어막을 획득, 30/60/100점을 획득합니다."
  },
  Task_24480_Name = {
    Text = "강철의 몸<size=20><color=#747474>최종전 1 턴 최대 생명 25%의 방어막 획득</color></size>"
  },
  Task_24481_Desc = {
    Text = "최종전 1턴에 리더의 최대 생명 20%/30%/40%의 데미지를 주고, 30/60/100점수를 획득합니다."
  },
  Task_24481_Name = {
    Text = "재액 강림 <size=20><color=#747474>최종전에서 1턴 동안 보스 최대 HP의 30% 이상의 피해 입히기</color></size>"
  },
  Task_24482_Desc = {
    Text = "6/7/8개의 유물을 획득하면, 30/60/100점을 획득합니다."
  },
  Task_24482_Name = {
    Text = "풍성한 수확 <size=20><color=#747474>8개의 유물을 획득</color></size>"
  },
  Task_24483_Desc = {
    Text = "5/7/9개의 다른 각인을 획득 시, 30/60/100점을 획득합니다."
  },
  Task_24483_Name = {
    Text = "각인 수집<size=20><color=#747474>각인 9개 획득</color></size>"
  },
  Task_24484_Desc = {
    Text = "5/7/9개의 다른 각인을 획득 시, 30/60/100점을 획득합니다."
  },
  Task_24484_Name = {
    Text = "각인 수집<size=20><color=#747474>5개의 각인 획득</color></size>"
  },
  Task_24485_Desc = {
    Text = "5/7/9개의 다른 각인을 획득 시, 30/60/100점을 획득합니다."
  },
  Task_24485_Name = {
    Text = "각인 수집<size=20><color=#747474>7개의 다른 각인을 획득.</color></size>"
  },
  Task_24486_Desc = {
    Text = "4/5/6개의 황금 유물을 획득하면 30점/60점/100점을 획득합니다."
  },
  Task_24486_Name = {
    Text = "반짝이는 금빛 <size=20><color=#747474>황금 유물 6개 획득</color></size>"
  },
  Task_24487_Desc = {
    Text = "최종전에서 연속 3/4/5턴 동안 광기 폭발을 사용하면 30/60/100분을 획득합니다."
  },
  Task_24487_Name = {
    Text = "광란의 공연 <size=20><color=#747474>최종전에서 3턴 연속으로 광기 폭발 사용</color></size>"
  },
  Task_24488_Desc = {
    Text = "2/3개의 저주받은 유물을 획득, 50/100점을 획득합니다."
  },
  Task_24488_Name = {
    Text = "기병의 보물창고<size=20><color=#747474>저주받은 유물 3개 획득</color></size>"
  },
  Task_24489_Desc = {
    Text = "2/3개의 저주받은 유물을 획득, 50/100점을 획득합니다."
  },
  Task_24489_Name = {
    Text = "기병의 보물창고<size=20><color=#747474>2개 저주받은 유물 획득</color></size>"
  },
  Task_24490_Desc = {
    Text = "최종전 1턴에 최대 생명의 25%/50%/75%의 방어막을 획득, 30/60/100점을 획득합니다."
  },
  Task_24490_Name = {
    Text = "강철의 몸<size=20><color=#747474>최종전 1턴에 최대 생명의 50%의 방어막 획득</color></size>"
  },
  Task_24491_Desc = {
    Text = "최종전에서 1턴에 5/7/9장의 카드를 내면 30/60/100점을 획득합니다."
  },
  Task_24491_Name = {
    Text = "내 차례야!<size=20><color=#747474>최종전에서 턴당 7장의 카드를 플레이했습니다</color></size>"
  },
  Task_24492_Desc = {
    Text = "7/9/11개의 각인을 획득 시 30/60/100점을 획득합니다."
  },
  Task_24492_Name = {
    Text = "각인된 힘<size=20><color=#747474>11개 각인 획득</color></size>"
  },
  Task_24493_Desc = {
    Text = "최종전에서 1턴에 5/7/9장의 카드를 내면 30/60/100점을 획득합니다."
  },
  Task_24493_Name = {
    Text = "내 차례야!<size=20><color=#747474>최종전에서 한 턴에 5장의 카드를 플레이했습니다</color></size>"
  },
  Task_24494_Desc = {
    Text = "최종전 1턴에 리더의 최대 생명 20%/30%/40%의 데미지를 주고, 30/60/100점수를 획득합니다."
  },
  Task_24494_Name = {
    Text = "재액 강림 <size=20><color=#747474>최종전에서 1턴 동안 보스 최대 HP의 40% 이상의 피해 입히기</color></size>"
  },
  Task_24495_Desc = {
    Text = "최종전 1턴에 최대 생명의 25%/50%/75%의 방어막을 획득, 30/60/100점을 획득합니다."
  },
  Task_24495_Name = {
    Text = "강철의 몸<size=20><color=#747474>최종전 한 턴 최대 생명 75%의 방어막 획득</color></size>"
  },
  Task_24496_Desc = {
    Text = "최종전 1턴에 리더의 최대 생명 20%/30%/40%의 데미지를 주고, 30/60/100점수를 획득합니다."
  },
  Task_24496_Name = {
    Text = "재액 강림 <size=20><color=#747474>최종전에서 1턴 동안 보스 최대 HP의 20% 이상의 피해 입히기</color></size>"
  },
  Task_24497_Desc = {
    Text = "임의의 전투에서 한 턴에 3/4개의 적을 처치하면 50/100점을 획득합니다."
  },
  Task_24497_Name = {
    Text = "무자비<size=20><color=#747474>임의의 전투에서 한 턴에 4명의 적을 제거</color></size>"
  },
  Task_24498_Desc = {
    Text = "최종전에서 1턴에 추가로 4/5/6장의 카드를 뽑고, 30/60/100점을. 획득합니다."
  },
  Task_24498_Name = {
    Text = "다다익선 <size=20><color=#747474>최종전에서 1턴 동안 추가로 5장의 카드를 드로우</color></size>"
  },
  Task_24499_Desc = {
    Text = "최종전에서 1턴에 추가로 4/5/6장의 카드를 뽑고, 30/60/100점을. 획득합니다."
  },
  Task_24499_Name = {
    Text = "다다익선 <size=20><color=#747474>최종전에서 1턴 동안 추가로 4장의 카드를 드로우</color></size>"
  },
  Task_24500_Desc = {
    Text = "임의의 전투에서 한 턴에 3/4개의 적을 처치하면 50/100점을 획득합니다."
  },
  Task_24500_Name = {
    Text = "무자비<size=20><color=#747474>임의의 전투에서 한 턴에 3명의 적을 제거</color></size>"
  },
  Task_24501_Desc = {
    Text = "최종전에서 1턴에 추가로 4/5/6장의 카드를 뽑고, 30/60/100점을. 획득합니다."
  },
  Task_24501_Name = {
    Text = "다다익선 <size=20><color=#747474>최종전에서 1턴 동안 추가로 6장의 카드를 드로우</color></size>"
  },
  Task_24534_Desc = {
    Text = "라몬나를 쫓아가"
  },
  Task_24534_Name = {Text = "목표"},
  Task_25013_Desc = {
    Text = "특파 기록 「장미의 찬미」 보통 클리어"
  },
  Task_25013_Name = {
    Text = "클리어 보상"
  },
  Task_25014_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25015_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25016_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25017_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25018_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25019_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25020_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25021_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25022_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25023_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_25024_Desc = {
    Text = "의식 잠수 「한 걸음 차이」 보통 클리어"
  },
  Task_25024_Name = {
    Text = "클리어 보상"
  },
  Task_25164_Desc = {
    Text = "라몬나를 따라가세요"
  },
  Task_25164_Name = {Text = "목표"},
  Task_25167_Desc = {
    Text = "신비한 저택으로 들어가기"
  },
  Task_25167_Name = {Text = "목표"},
  Task_25168_Desc = {
    Text = "소렐 부인의 방으로 돌아가기"
  },
  Task_25168_Name = {Text = "목표"},
  Task_34729_Desc = {
    Text = "각본의 수수께끼·초차원"
  },
  Task_34731_Desc = {
    Text = "각본의 수수께끼·혼돈"
  },
  Task_34734_Desc = {
    Text = "특파 기록"
  },
  Task_34737_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34740_Desc = {
    Text = "각본의 수수께끼·심해"
  },
  Task_34741_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34742_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34743_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34744_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34745_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34746_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_34748_Desc = {
    Text = "각본의 수수께끼·혈육"
  },
  Task_34750_Desc = {
    Text = "「특파 기록」의 모든 임무 완료"
  },
  Task_34942_Desc = {
    Text = "카오스 경계역의 깨어남체를 사용하여 「스케줄 미스터리」에서 25회 누적 키오링을 사용하세요"
  },
  Task_34943_Desc = {
    Text = "「스케줄 미스터리」에서 총 50장의 「태아」를 획득하세요"
  },
  Task_34944_Desc = {
    Text = "「스케줄 미스터리」에서 초원차원 턴에 10번 누적 진입"
  },
  Task_34945_Desc = {
    Text = "「스케줄 미스터리」에서 누적하여 터치 월 공격을 250회 사용"
  },
  Task_34946_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「스케줄 미스터리」에서 1회 승리"
  },
  Task_34947_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「스케줄 미스터리」에서 1번 승리하기"
  },
  Task_34948_Desc = {
    Text = "「스케줄 미스터리」에서 누적하여 터치 월 공격을 100회 사용"
  },
  Task_34949_Desc = {
    Text = "「스케줄 미스터리」에서 초원차원 턴에 5회 누적 진입"
  },
  Task_34950_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「스케줄 미스터리」에서 1회 승리"
  },
  Task_34951_Desc = {
    Text = "「스케줄 미스터리」에서 「태아」를 총 15장 획득하세요"
  },
  Task_34952_Desc = {
    Text = "카오스 경계역 깨어남체를 이용하여 「스케줄 미스터리」에서 누적 10회 키오링 사용"
  },
  Task_34953_Desc = {
    Text = "카오스 경계역의 깨어남체를 사용하여 「스케줄 미스터리」에서 1회 승리하기"
  },
  Task_35262_Desc = {
    Text = "완료 「스케줄 미스터리」 모든 경계역 태스크"
  },
  Task_35263_Desc = {Text = "최종장"},
  Task_35808_Desc = {
    Text = "누적 500만 장미 금권 소모"
  },
  Task_35808_Name = {
    Text = "돈을 물처럼 쓰다"
  },
  Task_36141_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_36141_Desc2 = {
    Text = "조사 이벤트 「역전의 별들」에서 공명 6번"
  },
  Task_36141_Name2 = {
    Text = "갈망의 반향 Ⅱ"
  },
  Task_36142_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_36142_Desc2 = {
    Text = "이벤트 조사 「역전의 별들」 완료"
  },
  Task_36142_Name2 = {
    Text = "거부 호출"
  },
  Task_36143_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_36143_Desc2 = {
    Text = "조사 이벤트 「역전의 별들」에서 총 공명 3회"
  },
  Task_36143_Name2 = {
    Text = "갈망의 반향"
  },
  Task_36144_Desc = {
    Text = "조사 사건 「역전의 별들」 어려움 모드 완료"
  },
  Task_36144_Name = {
    Text = "거부 호출·어려움"
  },
  Task_36145_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 8회 발생했습니다"
  },
  Task_36145_Desc2 = {
    Text = "이벤트 「역전의 별들」 조사에서 공명 8회"
  },
  Task_36145_Name2 = {
    Text = "갈망의 반향 Ⅲ"
  },
  Task_36155_Desc = {
    Text = "선장 보호"
  },
  Task_36155_Name = {Text = "목표"},
  Task_36156_Desc = {
    Text = "동력실타래 진입"
  },
  Task_36156_Name = {Text = "목표"},
  Task_36157_Desc = {
    Text = "동료 찾기"
  },
  Task_36157_Name = {Text = "목표"},
  Task_36158_Desc = {
    Text = "도해자의 공세에 저항하기"
  },
  Task_36158_Name = {Text = "목표"},
  Task_36159_Desc = {
    Text = "「성태」에 접근하기"
  },
  Task_36159_Name = {Text = "목표"},
  Task_36160_Desc = {
    Text = "공격에 저항하기"
  },
  Task_36160_Name = {Text = "목표"},
  Task_36161_Desc = {
    Text = "조타실타래로 돌아가기"
  },
  Task_36161_Name = {Text = "목표"},
  Task_36162_Desc = {Text = "적 격퇴"},
  Task_36162_Name = {Text = "목표"},
  Task_36163_Desc = {
    Text = "조타실타래로 향하기"
  },
  Task_36163_Name = {Text = "목표"},
  Task_36164_Desc = {
    Text = "동력실타래로 향하기"
  },
  Task_36164_Name = {Text = "목표"},
  Task_36169_Desc = {
    Text = "광장으로 가기"
  },
  Task_36169_Name = {Text = "목표"},
  Task_36316_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_36316_Name = {
    Text = "에너지 절약"
  },
  Task_36317_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_36317_Name = {
    Text = "에너지 절약"
  },
  Task_36359_Desc = {
    Text = "10개의 메인 줄기 제6장 「@1@2」의 분해점 찾기"
  },
  Task_36359_Desc2 = {
    Text = "메인 줄기 제6장 「역전의 별들」의 분해점 10개 찾아"
  },
  Task_36359_Name2 = {
    Text = "숨겨진 속삭임Ⅵ"
  },
  Task_36622_Desc = {
    Text = "변이된 마을 주민 제어"
  },
  Task_36622_Name = {Text = "목표"},
  Task_36623_Desc = {
    Text = "완다의 침궁으로 가다"
  },
  Task_36623_Name = {Text = "목표"},
  Task_36624_Desc = {
    Text = "격퇴 융식 몬스터"
  },
  Task_36624_Name = {Text = "목표"},
  Task_36842_Desc = {
    Text = "의식 잠수 「언제나처럼」 보통 클리어"
  },
  Task_36842_Name = {
    Text = "클리어 보상"
  },
  Task_36864_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_36872_Desc = {
    Text = "응급 영지체를 사용할 때마다 조사 평점이 30%씩 줄어듭니다."
  },
  Task_36872_Name = {
    Text = "영지 소진 <size=20><color=#747474>응급 영지체를 1회 사용할 때마다 조사 점수 30% 감소</color></size>"
  },
  Task_38749_Desc = {
    Text = "180 린피테이프 소모하기"
  },
  Task_38750_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_38751_Desc = {
    Text = "친구에게 좋아요 10회 보내기"
  },
  Task_38752_Desc = {
    Text = "주간 시련 완료"
  },
  Task_38753_Desc = {
    Text = "파견을 3 회 실타래행"
  },
  Task_38754_Desc = {
    Text = "훈련 태스크 모두 완료"
  },
  Task_38755_Desc = {
    Text = "환몽 심잠 승리 1 회"
  },
  Task_38814_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해 「호수 속의 도시」에서 1회 승리"
  },
  Task_38815_Desc = {
    Text = "카오스 경계역 깨어남체를 활용하여 「호수 속의 도시」에서 5번 승리하기"
  },
  Task_38816_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「호수 속의 도시」에서 3번 승리하기"
  },
  Task_38817_Desc = {
    Text = "호수 속의 도시·혈육"
  },
  Task_38818_Desc = {
    Text = "클리어 「계시록」 아무 추억"
  },
  Task_38819_Desc = {
    Text = "클리어 「한단 기억」 임의의 추억"
  },
  Task_38820_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「호수 속의 도시」에서 5번 승리"
  },
  Task_38821_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「호수 속의 도시」에서 3번 승리하기"
  },
  Task_38822_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「호수 속의 도시」에서 1 회 승리"
  },
  Task_38823_Desc = {
    Text = "호수 속의 도시·깊은 바다"
  },
  Task_38824_Desc = {
    Text = "클리어 「소광란」 아무거나 추억"
  },
  Task_38825_Desc = {
    Text = "클리어 「정」 임의 추억"
  },
  Task_38826_Desc = {
    Text = "의식 잠수"
  },
  Task_38827_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「호수 속의 도시」에서 3번 승리하기 \n"
  },
  Task_38828_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「호수 속의 도시」에서 5번 승리"
  },
  Task_38829_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「호수 속의 도시」에서 1회 승리"
  },
  Task_38830_Desc = {
    Text = "클리어 「미라지」 임의 추억"
  },
  Task_38831_Desc = {
    Text = "호수 속의 도시·카오스"
  },
  Task_38832_Desc = {
    Text = "클리어 「진실타래」 임의의 추억"
  },
  Task_38833_Desc = {
    Text = "호수 속의 도시·추억"
  },
  Task_38834_Desc = {
    Text = "클리어 「황금 도시」 임의의 추억"
  },
  Task_38835_Desc = {
    Text = "Use the Awakening Body of the Blood Flesh Boundary Realm to win once in 「The City in the Lake」."
  },
  Task_38836_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「호수 속의 도시」에서 5번 승리하다"
  },
  Task_38837_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「호수 속의 도시」에서 3번 승리"
  },
  Task_38838_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_38839_Desc = {
    Text = "호수 속의 도시·초원차원"
  },
  Task_38840_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_39279_Desc = {
    Text = "응급 영지체를 1회 사용할 때마다 조사 점수가 20% 줄어듭니다. (사용 횟수:{s1})"
  },
  Task_39279_Name = {
    Text = "환계 구조<size=20><color=#747474>응급 영지체를 1회 사용할 때마다 조사 평점 20% 감소</color></size>"
  },
  Task_40465_Desc = {
    Text = "1/2/3 회 이상의 데스 리저스턴스를 발동하면 100/300/500 점을 획득합니다."
  },
  Task_40465_Name = {
    Text = "생사의 경계 <size=20><color=#747474>죽음 저항 1회 발동</color></size>"
  },
  Task_40466_Desc = {
    Text = "1/2/3 회 이상의 데스 리저스턴스를 발동하면 100/300/500 점을 획득합니다."
  },
  Task_40466_Name = {
    Text = "생사의 경계 <size=20><color=#747474>죽음 저항 3회 이상 발동</color></size>"
  },
  Task_40467_Desc = {
    Text = "1/2/3 회 이상의 데스 리저스턴스를 발동하면 100/300/500 점을 획득합니다."
  },
  Task_40467_Name = {
    Text = "생사의 경계 <size=20><color=#747474>죽음 저항 2회 발동</color></size>"
  },
  Task_40468_Desc = {
    Text = "5/6/7/8 개의 유물을 소유하면 250/500/750/1000 점 획득."
  },
  Task_40468_Name = {
    Text = "실타래상 수집 <size=20><color=#747474>5개의 유물을 보유</color></size>"
  },
  Task_40469_Desc = {
    Text = "5/6/7/8 개의 유물을 소유하면 250/500/750/1000 점 획득."
  },
  Task_40469_Name = {
    Text = "실타래상 수집 <size=20><color=#747474>7개의 유물을 보유</color></size>"
  },
  Task_40470_Desc = {
    Text = "5/6/7/8 개의 유물을 소유하면 250/500/750/1000 점 획득."
  },
  Task_40470_Name = {
    Text = "실타래상 수집 <size=20><color=#747474>6개의 유물을 보유</color></size>"
  },
  Task_40471_Desc = {
    Text = "최종전 11/10/9/8 턴 내 승리, 250/500/750/1000\n/1000 획득."
  },
  Task_40471_Name = {
    Text = "환몽 질주 <size=20><color=#747474>8턴 이내에 보스 처치</color></size>"
  },
  Task_40472_Desc = {
    Text = "최종전 11/10/9/8 턴 내 승리, 250/500/750/1000\n/1000 획득."
  },
  Task_40472_Name = {
    Text = "환몽 질주 <size=20><color=#747474>8턴 이내에 보스 처치</color></size>"
  },
  Task_40473_Desc = {
    Text = "최종전 11/10/9/8 턴 내 승리, 250/500/750/1000\n/1000 획득."
  },
  Task_40473_Name = {
    Text = "환몽 질주 <size=20><color=#747474>9턴 이내에 보스 처치</color></size>"
  },
  Task_40474_Desc = {
    Text = "최종전 11/10/9/8 턴 내 승리, 250/500/750/1000\n/1000 획득."
  },
  Task_40474_Name = {
    Text = "환몽 질주 <size=20><color=#747474>10턴 이내에 보스 처치</color></size>"
  },
  Task_40475_Desc = {
    Text = "최종전 11/10/9/8 턴 내 승리, 250/500/750/1000\n/1000 획득."
  },
  Task_40475_Name = {
    Text = "환몽 질주 <size=20><color=#747474>11턴 이내에 보스 처치</color></size>"
  },
  Task_40476_Desc = {
    Text = "최종전에서 승리하여 1000점을 획득했습니다."
  },
  Task_40476_Name = {
    Text = "꿈의 끝 <size=20><color=#747474>보스 전투에서 승리</color></size>"
  },
  Task_41334_Desc = {
    Text = "격퇴 리더{s1}"
  },
  Task_41334_Name = {Text = "목표"},
  Task_41367_Desc = {
    Text = "「조사 작전」 제3장 완료"
  },
  Task_41368_Desc = {
    Text = "「조사 작전」 제5장 완료"
  },
  Task_41369_Desc = {
    Text = "「조사 작전」 제4장 완료"
  },
  Task_41370_Desc = {
    Text = "「조사 작전」 제2장 완료"
  },
  Task_41371_Desc = {
    Text = "특훈 값이 처음으로 325에 도달했습니다"
  },
  Task_41372_Desc = {
    Text = "특훈 값이 처음으로 350에 도달했습니다"
  },
  Task_41373_Desc = {
    Text = "특훈 값이 처음으로 225에 도달했습니다"
  },
  Task_41374_Desc = {
    Text = "특훈 값이 처음으로 300에 도달했습니다"
  },
  Task_41375_Desc = {
    Text = "특훈 값이 처음으로 100 도달"
  },
  Task_41376_Desc = {
    Text = "특훈 값이 처음으로 150에 도달했습니다"
  },
  Task_41377_Desc = {
    Text = "특훈 값이 처음으로 50 도달"
  },
  Task_41380_Desc = {
    Text = "다음의 모든 추억 태스크 완료"
  },
  Task_43476_Desc = {
    Text = "수호자 조사 등급 55레벨 달성하기"
  },
  Task_43476_Name = {
    Text = "수호자 능력 고사 Ⅵ"
  },
  Task_43477_Desc = {
    Text = "수호자 조사 등급 45레벨 달성하기"
  },
  Task_43477_Name = {
    Text = "수호자 능력 고사 Ⅴ"
  },
  Task_43514_Desc = {
    Text = "그렌 등을 격퇴하다"
  },
  Task_43514_Name = {Text = "목표"},
  Task_43561_Desc = {
    Text = "조사 메인 스토리 제6장 「일그러진 별들」 완료"
  },
  Task_43562_Desc = {
    Text = "조사 메인 스토리 제5장 「폭풍의 눈」 완료"
  },
  Task_43563_Desc = {
    Text = "조사 메인 스토리 제3장 「맹견 주의」 완료"
  },
  Task_43564_Desc = {
    Text = "조사 메인 스토리 제6장 「일그러진 별들」 어려움 난이도 완료"
  },
  Task_43565_Desc = {
    Text = "조사 메인 스토리 제4장 「무성한 곳에서」 어려움 난이도 완료"
  },
  Task_43566_Desc = {
    Text = "조사 메인 스토리 제3장 「맹견 주의」 어려움 난이도 완료"
  },
  Task_43567_Desc = {
    Text = "조사 메인 스토리 제5장 「폭풍의 눈」 어려움 난이도 완료"
  },
  Task_43568_Desc = {
    Text = "조사 메인 스토리 제4장 「무성한 곳에서」 완료"
  },
  Task_43822_Desc = {
    Text = "80레벨 깨어남체 1명 소유"
  },
  Task_43822_Name = {
    Text = "「초월의 힘」Ⅰ"
  },
  Task_43824_Desc = {
    Text = "한 번의 데미지가 250000에 도달했습니다"
  },
  Task_43824_Name = {
    Text = "생명이 견디기 힘든 고통Ⅳ"
  },
  Task_43825_Desc = {
    Text = "한번의 데미지가 500000에 도달했습니다"
  },
  Task_43825_Name = {
    Text = "생명이 견디기 힘든 고통Ⅴ"
  },
  Task_43826_Desc = {
    Text = "데미지가 한 번 50000에 도달하면"
  },
  Task_43826_Name = {
    Text = "생명이 견디기 힘든 고통Ⅱ"
  },
  Task_43827_Desc = {
    Text = "한 번의 데미지가 100000에 도달했습니다"
  },
  Task_43827_Name = {
    Text = "생명이 견디기 힘든 고통 Ⅲ"
  },
  Task_43828_Desc = {
    Text = "3명의 80레벨 깨어남체를 보유하고 있음"
  },
  Task_43828_Name = {
    Text = "「초월의 힘」Ⅲ"
  },
  Task_43829_Desc = {
    Text = "2명의 80레벨 깨어남체 소유"
  },
  Task_43829_Name = {
    Text = "「초월의 힘」Ⅱ"
  },
  Task_43831_Desc = {
    Text = "적에게 10000개의 중독을 중첩"
  },
  Task_43831_Name = {
    Text = "현실타래의 독Ⅰ"
  },
  Task_43832_Desc = {
    Text = "의식 잠수 「기사의 소원」 완료"
  },
  Task_43832_Name = {
    Text = "천일야화"
  },
  Task_43833_Desc = {
    Text = "의식 잠수 「불꽃의 향연」 완료"
  },
  Task_43833_Name = {
    Text = "달빛 아래 새 일은 없다"
  },
  Task_43834_Desc = {
    Text = "특파 기록 「장미의 찬미」 완료"
  },
  Task_43834_Name = {
    Text = "붉은 장미는 침묵하지 않으리·어려움"
  },
  Task_43835_Desc = {
    Text = "특파 기록 「이야기의 마법」 완료"
  },
  Task_43835_Name = {
    Text = "단순한 어린 시절·어려움"
  },
  Task_43836_Desc = {
    Text = "특파 기록 「이야기의 마법」 완료"
  },
  Task_43836_Name = {
    Text = "단순한 어린 시절"
  },
  Task_43837_Desc = {
    Text = "특파 기록 「비 내리는 마을의 유령」 어려움 완료"
  },
  Task_43837_Name = {
    Text = "시대의 마녀·어려움"
  },
  Task_43838_Desc = {
    Text = "특파 기록 「비 내리는 마을의 유령」 완료"
  },
  Task_43838_Name = {
    Text = "시대의 마녀"
  },
  Task_43839_Desc = {
    Text = "특파 기록 「장미의 찬미」 완료"
  },
  Task_43839_Name = {
    Text = "붉은 장미는 침묵하지 않으리"
  },
  Task_43840_Desc = {
    Text = "페이즈 대결에서 2000번 대결"
  },
  Task_43840_Name = {
    Text = "위상 중복Ⅴ"
  },
  Task_43843_Desc = {
    Text = "명륜 SSR 분해"
  },
  Task_43843_Name = {
    Text = "외부의 물건"
  },
  Task_43844_Desc = {
    Text = "명륜중첩위치 700회"
  },
  Task_43844_Name = {
    Text = "양자 얽힘의 미래 Ⅰ"
  },
  Task_43845_Desc = {
    Text = "깨어남체 스킬 1000번 업그레이드"
  },
  Task_43845_Name = {
    Text = "「무공 숙련」Ⅷ"
  },
  Task_43846_Desc = {
    Text = "깨어남체 스킬을 1100회 업그레이드"
  },
  Task_43846_Name = {
    Text = "「무공 숙련」Ⅸ"
  },
  Task_43847_Desc = {
    Text = "깨어남체 스킬 1200번 업그레이드"
  },
  Task_43847_Name = {
    Text = "「무공 숙련」Ⅹ"
  },
  Task_43849_Desc = {
    Text = "명륜 100개 분해"
  },
  Task_43849_Name = {
    Text = "귀중한 호기심"
  },
  Task_43850_Desc = {
    Text = "200개의 명륜을 분해"
  },
  Task_43850_Name = {
    Text = "팔조각 내는 재미"
  },
  Task_43851_Desc = {
    Text = "명륜 300개 분해"
  },
  Task_43851_Name = {
    Text = "과일 껍질 속의 우주"
  },
  Task_43863_Desc = {
    Text = "페이즈 대결에서 1000번 대전하기"
  },
  Task_43863_Name = {
    Text = "위상 중복Ⅳ"
  },
  Task_43864_Desc = {
    Text = "페이즈 대결에서 500번 대결"
  },
  Task_43864_Name = {
    Text = "위상 중복Ⅲ"
  },
  Task_43866_Desc = {
    Text = "100번 환몽 심잠 완료"
  },
  Task_43866_Name = {
    Text = "얕은 모험"
  },
  Task_43867_Desc = {
    Text = "페이즈 대결에서 250번 대결"
  },
  Task_43867_Name = {
    Text = "위상 중복Ⅱ"
  },
  Task_43868_Desc = {
    Text = "페이즈 대결에서 100번 대전하기를"
  },
  Task_43868_Name = {
    Text = "위상 중복Ⅰ"
  },
  Task_43869_Desc = {
    Text = "40명의 깨어남체와 동조율이 레벨 10에 도달"
  },
  Task_43869_Name = {
    Text = "모두가 나의 날개입니다"
  },
  Task_43873_Desc = {
    Text = "명륜중첩위치 600 회"
  },
  Task_43873_Name = {
    Text = "교차하는 운명Ⅵ"
  },
  Task_43874_Desc = {
    Text = "명륜중첩위치 500번"
  },
  Task_43874_Name = {
    Text = "교차하는 운명Ⅴ"
  },
  Task_43875_Desc = {
    Text = "명륜중첩위치 400회"
  },
  Task_43875_Name = {
    Text = "교차하는 운명 Ⅳ"
  },
  Task_43876_Desc = {
    Text = "명륜중첩위치 300회"
  },
  Task_43876_Name = {
    Text = "교차하는 운명 Ⅲ"
  },
  Task_43877_Desc = {
    Text = "명륜중첩위치 200회"
  },
  Task_43877_Name = {
    Text = "교차하는 운명 Ⅱ"
  },
  Task_43878_Desc = {
    Text = "명륜중첩위치 100회"
  },
  Task_43878_Name = {
    Text = "교차하는 운명 Ⅰ"
  },
  Task_43880_Desc = {
    Text = "깨어남체 활성화 기령 600회"
  },
  Task_43880_Name = {
    Text = "미지의 부름"
  },
  Task_43881_Desc = {
    Text = "깨어남체 활성화 기령 500회"
  },
  Task_43881_Name = {
    Text = "영혼과 육체의 결합Ⅳ"
  },
  Task_43882_Desc = {
    Text = "깨어남체 기령 400회"
  },
  Task_43882_Name = {
    Text = "영혼과 육체의 결합Ⅲ"
  },
  Task_43883_Desc = {
    Text = "의식 잠수 “노래 같은 조각” 어려움 완료"
  },
  Task_43883_Name = {
    Text = "알레프의 비밀·어려움"
  },
  Task_43884_Desc = {
    Text = "의식 잠수 “피와 모래” 어려움 완료"
  },
  Task_43884_Name = {
    Text = "야수가 말하길·어려움"
  },
  Task_43885_Desc = {
    Text = "의식 잠수 「한 걸음 차이」 완료"
  },
  Task_43885_Name = {
    Text = "회로의 사자"
  },
  Task_43886_Desc = {
    Text = "의식 잠수 「언제나처럼」 완료"
  },
  Task_43886_Name = {
    Text = "보이지 않는 도시"
  },
  Task_43887_Desc = {
    Text = "의식 잠수 “기사의 소원” 어려움 완료"
  },
  Task_43887_Name = {
    Text = "천일야화·어려움"
  },
  Task_43888_Desc = {
    Text = "의식 잠수 “타오르는 군연” 어려움 완료"
  },
  Task_43888_Name = {
    Text = "달빛 아래 새 일은 없다·어려움"
  },
  Task_43889_Desc = {
    Text = "의식 잠수 「노래처럼 조각된」 완료"
  },
  Task_43889_Name = {
    Text = "알레프의 비밀"
  },
  Task_43890_Desc = {
    Text = "의식 잠수 「피와 모래」 완료"
  },
  Task_43890_Name = {
    Text = "야수가 말하길"
  },
  Task_43891_Desc = {
    Text = "의식 잠수 「뒤틀린 핵」 완료"
  },
  Task_43891_Name = {
    Text = "기계 인형은 꿈을 꾸나요"
  },
  Task_43892_Desc = {
    Text = "의식 잠수 「창백한 후예」 완료"
  },
  Task_43892_Name = {
    Text = "내 디미안"
  },
  Task_43893_Desc = {
    Text = "적에게 25000단계 중독을 중첩"
  },
  Task_43893_Name = {
    Text = "현실타래의 독Ⅱ"
  },
  Task_43896_Desc = {
    Text = "의식 잠수 “한 걸음 차이” 어려움 완료"
  },
  Task_43896_Name = {
    Text = "회로의 사자·어려움"
  },
  Task_43897_Desc = {
    Text = "10000번의 깨어남 의식 진행"
  },
  Task_43897_Name = {
    Text = "영지가수"
  },
  Task_43898_Desc = {
    Text = "의식 잠수 “왜곡된 핵심” 어려움 난이도 완료"
  },
  Task_43898_Name = {
    Text = "기계 인형은 꿈을 꾸나요·어려움"
  },
  Task_43899_Desc = {
    Text = "누적 소모 100000 검은 인장"
  },
  Task_43899_Name = {
    Text = "환영합니다「빛」4"
  },
  Task_43900_Desc = {
    Text = "누적 소모 50000 검은 인장"
  },
  Task_43900_Name = {
    Text = "환영합니다「빛」Ⅲ"
  },
  Task_43901_Desc = {
    Text = "누적 소모 25000 검은 인장"
  },
  Task_43901_Name = {
    Text = "환영합니다 「빛」 Ⅱ"
  },
  Task_43902_Desc = {
    Text = "누적 소모 10000 검은 인장"
  },
  Task_43902_Name = {
    Text = "환영합니다「빛」Ⅰ"
  },
  Task_43903_Desc = {
    Text = "12레벨의 미스터리 100개 소유"
  },
  Task_43903_Name = {
    Text = "금지된 수호자 Ⅲ"
  },
  Task_43904_Desc = {
    Text = "150개의 12레벨 미스터리 소유"
  },
  Task_43904_Name = {
    Text = "금지된 수호자 Ⅳ"
  },
  Task_43905_Desc = {
    Text = "12레벨 미스터리 25개를 소유"
  },
  Task_43905_Name = {
    Text = "금지된 수호자Ⅰ"
  },
  Task_43906_Desc = {
    Text = "50개의 12레벨 미스터리"
  },
  Task_43906_Name = {
    Text = "금지된 수호자 Ⅱ"
  },
  Task_43907_Desc = {
    Text = "2500번의 깨어남 의식을 진행합니다"
  },
  Task_43907_Name = {
    Text = "영혼을 노래하는 자Ⅱ"
  },
  Task_43908_Desc = {
    Text = "5000번의 깨어남 의식을 수행합니다"
  },
  Task_43908_Name = {
    Text = "영혼을 노래하는 자Ⅲ"
  },
  Task_43909_Desc = {
    Text = "500번의 깨어남 의식을 진행합니다"
  },
  Task_43909_Name = {
    Text = "천재 비밀지킴이Ⅴ"
  },
  Task_43910_Desc = {
    Text = "1000번의 깨어남 의식"
  },
  Task_43910_Name = {
    Text = "영혼을 노래하는 자Ⅰ"
  },
  Task_43911_Desc = {
    Text = "의식 잠수 “백색 후예” 어려움 완료"
  },
  Task_43911_Name = {
    Text = "내 디미안·어려움"
  },
  Task_43916_Desc = {
    Text = "하루에 프로필 사진을 3회 초과 변경"
  },
  Task_43916_Name = {
    Text = "변상괴작"
  },
  Task_43917_Desc = {
    Text = "기숙사에서 깨어남체와 100번 대화하기"
  },
  Task_43917_Name = {
    Text = "오늘은 이만 자자"
  },
  Task_43918_Desc = {
    Text = "미스틱 트랜스크립트 250회 완성"
  },
  Task_43918_Name = {
    Text = "느낌이 맞지 않아요"
  },
  Task_43919_Desc = {
    Text = "미스틱 트랜스크립트 100회 완료"
  },
  Task_43919_Name = {
    Text = "하비르신"
  },
  Task_43921_Desc = {
    Text = "미스틱 트랜스크립트 완료 500회"
  },
  Task_43921_Name = {
    Text = "한 번 더 출판하다"
  },
  Task_43923_Desc = {
    Text = "데미지가 한 번에 10000에 도달했습니다"
  },
  Task_43923_Name = {
    Text = "생명이 견디기 힘든 고통Ⅰ"
  },
  Task_43928_Desc = {
    Text = "30명의 깨어남체와 동조율을 레벨 10으로 도달"
  },
  Task_43928_Name = {
    Text = "「사랑」의 해석"
  },
  Task_43930_Desc = {
    Text = "16명의 깨어남체와 동조율이 레벨 10에 도달"
  },
  Task_43930_Name = {
    Text = "마음과 영의 대화"
  },
  Task_43932_Desc = {
    Text = "20명의 깨어남체와 동조율이 레벨 10에 도달"
  },
  Task_43932_Name = {
    Text = "영혼의 독자"
  },
  Task_43934_Desc = {
    Text = "라몬나의 본원 형태를 해금"
  },
  Task_43934_Name = {
    Text = "소녀의 곁에서"
  },
  Task_43936_Desc = {
    Text = "12명의 깨어남체와 동조율이 레벨 10에 도달"
  },
  Task_43936_Name = {
    Text = "조심스럽게 잠든 마음을 두드려 깨우세요"
  },
  Task_43937_Desc = {
    Text = "누적 로그인 300일"
  },
  Task_43937_Name = {
    Text = "결연한 의지"
  },
  Task_43938_Desc = {
    Text = "누적 로그인 365일"
  },
  Task_43938_Name = {
    Text = "별이 반짝이는 밤"
  },
  Task_43943_Desc = {
    Text = "누적 로그인 120일"
  },
  Task_43943_Name = {
    Text = "평범한 아침"
  },
  Task_43944_Desc = {
    Text = "누적 로그인 150일"
  },
  Task_43944_Name = {
    Text = "한 잔의 평범한 커피"
  },
  Task_43945_Desc = {
    Text = "누적 로그인 180일"
  },
  Task_43945_Name = {
    Text = "단순한 대화"
  },
  Task_43946_Desc = {
    Text = "누적 로그인 240일"
  },
  Task_43946_Name = {
    Text = "한 개의 뜨거운 심장"
  },
  Task_43948_Desc = {
    Text = "다른 명륜 30종을 획득"
  },
  Task_43948_Name = {
    Text = "무상의 지배자"
  },
  Task_43949_Desc = {
    Text = "다른 명륜 20종을 획득"
  },
  Task_43949_Name = {
    Text = "운명의 제자 Ⅱ"
  },
  Task_43950_Desc = {
    Text = "다른 명륜 10종을 획득"
  },
  Task_43950_Name = {
    Text = "운명의 제자 Ⅰ"
  },
  Task_43953_Desc = {
    Text = "다른 명륜 40종을 획득"
  },
  Task_43953_Name = {
    Text = "운명을 짜는 자"
  },
  Task_43957_Desc = {
    Text = "도우미 사용 1회"
  },
  Task_43957_Name = {
    Text = "외출은 친구와 함께"
  },
  Task_43958_Desc = {
    Text = "수정된 요약 메시지"
  },
  Task_43958_Name = {
    Text = "Hello, World!"
  },
  Task_43959_Desc = {
    Text = "좋아요를 1000번 받음"
  },
  Task_43959_Name = {
    Text = "찬사가 문을 두드릴 때"
  },
  Task_43961_Desc = {
    Text = "좋아요 100회"
  },
  Task_43961_Name = {
    Text = "내면의 작은 한 걸음"
  },
  Task_43962_Desc = {
    Text = "좋아요 50회"
  },
  Task_43962_Name = {
    Text = "미미한 시도"
  },
  Task_43964_Desc = {
    Text = "100명의 동문에게 관심"
  },
  Task_43964_Name = {
    Text = "별들이 빛나는 순간"
  },
  Task_43965_Desc = {
    Text = "관심 1명의 동문"
  },
  Task_43965_Name = {
    Text = "당신의 이름은?"
  },
  Task_43966_Desc = {
    Text = "누적 로그인 500일"
  },
  Task_43966_Name = {
    Text = "카다스의 태양이 평소와 같이 떠오른다"
  },
  Task_43967_Desc = {
    Text = "깨어남체 활성화 기령 60회"
  },
  Task_43967_Name = {
    Text = "영혼과 마음의 만남 Ⅴ"
  },
  Task_43968_Desc = {
    Text = "깨어남체 활성화 기령 100회"
  },
  Task_43968_Name = {
    Text = "그림자 속의 기다림"
  },
  Task_43969_Desc = {
    Text = "깨어남체 활성화 기령 30회"
  },
  Task_43969_Name = {
    Text = "영혼과 마음의 만남 Ⅲ"
  },
  Task_43970_Desc = {
    Text = "깨어남체 기령 45회"
  },
  Task_43970_Name = {
    Text = "영혼과 마음의 만남 Ⅳ"
  },
  Task_43972_Desc = {
    Text = "깨어남체 활성화 기령15번"
  },
  Task_43972_Name = {
    Text = "영혼과 마음의 만남 Ⅱ"
  },
  Task_43973_Desc = {
    Text = "4명의 80레벨 깨어남체를 보유"
  },
  Task_43973_Name = {
    Text = "「초월의 힘」Ⅳ"
  },
  Task_43975_Desc = {
    Text = "깨어남체 활성화 기령 200 회"
  },
  Task_43975_Name = {
    Text = "영혼과 육체의 결합Ⅰ"
  },
  Task_43976_Desc = {
    Text = "깨어남체 기령 300회"
  },
  Task_43976_Name = {
    Text = "영혼과 육체의 결합Ⅱ"
  },
  Task_44231_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「성당의 길」에서 1회 승리하기"
  },
  Task_44232_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「성당의 길」에서 3번 승리하세요."
  },
  Task_44233_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「성당의 길」에서 2번 승리하세요"
  },
  Task_44234_Desc = {
    Text = "클리어 「쟁취」 임의의 난이도"
  },
  Task_44235_Desc = {
    Text = "클리어 「착취」 아무 난이도"
  },
  Task_44236_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「성당의 길」에서 1회 승리"
  },
  Task_44237_Desc = {
    Text = "카오스 경계역 깨어남체로 「성당의 길」에서 3번 승리하기"
  },
  Task_44238_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「성당의 길」에서 2번 승리하기"
  },
  Task_44239_Desc = {
    Text = "카오스 경계역 깨어남체로 「성당의 길」에서 1회 승리"
  },
  Task_44240_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「성당의 길」에서 3번 승리하기"
  },
  Task_44241_Desc = {
    Text = "「대존의 신비한 자선 판매」에서 150회 구매"
  },
  Task_44242_Desc = {
    Text = "「대존의 신비한 자선 판매」에서 200회 구매"
  },
  Task_44243_Desc = {
    Text = "「큰 존의 신비한 자선 판매」에서 100회 구매"
  },
  Task_44244_Desc = {
    Text = "「그레이 부인의 작은 상점」에서 200번 구매"
  },
  Task_44245_Desc = {
    Text = "「그레이 부인의 작은 상점」에서 150회 구매"
  },
  Task_44246_Desc = {
    Text = "「그레이 부인의 작은 상점」에서 100번 구매"
  },
  Task_44247_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「성당의 길」에서 3번 승리"
  },
  Task_44248_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「성당의 길」에서 두 번 승리하세요"
  },
  Task_44249_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「성당의 길」에서 1회 승리"
  },
  Task_44250_Desc = {
    Text = "클리어 「후회」 어떤 난이도로든"
  },
  Task_44251_Desc = {
    Text = "성당 자선 판매 현장"
  },
  Task_44252_Desc = {
    Text = "「스미스 특매」에서 100번 구매"
  },
  Task_44253_Desc = {
    Text = "「스미스 특매」에서 200회 구매"
  },
  Task_44254_Desc = {
    Text = "「스미스 특매」에서 150회 구매"
  },
  Task_44255_Desc = {
    Text = "성당의 길·깊은 바다"
  },
  Task_44256_Desc = {
    Text = "성당의 길·초원차원"
  },
  Task_44257_Desc = {
    Text = "성당의 길·카오스"
  },
  Task_44258_Desc = {
    Text = "클리어 「수취」 임의의 난이도"
  },
  Task_44259_Desc = {
    Text = "완료 「성당의 길」 모든 난이도의 모든 스테이지"
  },
  Task_44260_Desc = {
    Text = "클리어 「비난」 임의 난이도"
  },
  Task_44261_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「성당의 길」에서 2번 승리"
  },
  Task_44262_Desc = {
    Text = "성당의 길·혈육"
  },
  Task_44263_Desc = {
    Text = "성당의 길·성장"
  },
  Task_44264_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_44567_Desc = {
    Text = "소피아를 막다"
  },
  Task_44567_Name = {Text = "목표"},
  Task_45665_Desc = {
    Text = "특파 기록 「거인의 몰락」 보통 클리어"
  },
  Task_45665_Name = {
    Text = "클리어 보상"
  },
  Task_45666_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_46575_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「무의식적 기억」 클리어(아무 난이도로)"
  },
  Task_46576_Desc = {
    Text = "클리어 「거울」 임의의 난이도"
  },
  Task_46577_Desc = {
    Text = "혈육 경계역을 사용하여 깨어남체로 「크롤링 뇌」의 임의 난이도를 클리어합니다"
  },
  Task_46578_Desc = {
    Text = "기억 인코딩·혈육"
  },
  Task_46579_Desc = {
    Text = "클리어 「크롤링 뇌」 어떤 난이도로든"
  },
  Task_46580_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「무의식적 기억」의 아무 난이도를 클리어합니다"
  },
  Task_46581_Desc = {
    Text = "기억 인코딩·깊은 바다"
  },
  Task_46582_Desc = {
    Text = "클리어 「무의식적 기억」 아무 난이도"
  },
  Task_46583_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「망각 곡선」의 임의난이도 클리어하기"
  },
  Task_46584_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「거울」의 임의의 난이도 클리어하기"
  },
  Task_46585_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「아몬드체」의 임의의 난이도를 클리어합니다"
  },
  Task_46586_Desc = {
    Text = "혼돈 영역 깨어남체를 사용해 「크롤링 뇌」의 임의 난이도를 클리어하기"
  },
  Task_46587_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「무의식적 기억」의 임의의 난이도를 클리어합니다"
  },
  Task_46588_Desc = {
    Text = "깊은 바다 영역 깨어남체로 「거울」의 임의 난이도 클리어"
  },
  Task_46589_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「망각 곡선」의 임의 난이도 클리어"
  },
  Task_46590_Desc = {
    Text = "깊은 바다 영역 깨어남체로 「무의식적 기억」 임의의 난이도 클리어"
  },
  Task_46591_Desc = {
    Text = "깊은 바다 영역의 깨어남체를 사용하여 「크롤링 뇌」의 임의의 난이도를 클리어"
  },
  Task_46592_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「아몬드체」의 임의의 난이도를 클리어합니다"
  },
  Task_46593_Desc = {
    Text = "완료「기억 인코딩」모든 스테이지 임의의 난이도"
  },
  Task_46594_Desc = {
    Text = "클리어 「망각 곡선」 어떤 난이도"
  },
  Task_46595_Desc = {
    Text = "기억 인코딩·카오스"
  },
  Task_46596_Desc = {
    Text = "클리어 「아몬드체」 임의의 난이도"
  },
  Task_46597_Desc = {
    Text = "초월계역 깨어남체를 사용하여 「망각 곡선」의 임의 난이도 클리어"
  },
  Task_46598_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「거울」의 임의 난이도 클리어"
  },
  Task_46599_Desc = {
    Text = "혈육 경계역을 사용하여 깨어남체로 「망각 곡선」의 임의 난이도를 클리어하기"
  },
  Task_46600_Desc = {
    Text = "깨어남체 깨어남을 활용해 혈육 경계역에서 「거울」의 임의 난이도를 클리어"
  },
  Task_46601_Desc = {
    Text = "혈육 경계역을 사용하여 깨어남체로 「아몬드체」의 임의의 난이도를 클리어하기"
  },
  Task_46602_Desc = {
    Text = "기억 인코딩·등장"
  },
  Task_46603_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「아몬드체」의 임의의 난이도를 클리어하기"
  },
  Task_46604_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「크롤링 뇌」의 아무 난이도를 클리어"
  },
  Task_46605_Desc = {
    Text = "기억 인코딩·초원차원"
  },
  Task_46624_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_46798_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46798_Name = {Text = "200점"},
  Task_46799_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46799_Name = {Text = "450점"},
  Task_46806_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46806_Name = {Text = "50점"},
  Task_46807_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46807_Name = {Text = "100점"},
  Task_46808_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46808_Name = {Text = "150점"},
  Task_46809_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46809_Name = {Text = "1500점"},
  Task_46810_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46810_Name = {Text = "250점"},
  Task_46811_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46811_Name = {Text = "300점"},
  Task_46812_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46812_Name = {Text = "350점"},
  Task_46821_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_46821_Name = {Text = "6승"},
  Task_46822_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_46822_Name = {Text = "3승"},
  Task_46823_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_46823_Name = {Text = "1승"},
  Task_46826_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46826_Name = {Text = "1450점"},
  Task_46827_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46827_Name = {Text = "1400점"},
  Task_46828_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46828_Name = {Text = "1350점"},
  Task_46829_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46829_Name = {Text = "1300점"},
  Task_46830_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46830_Name = {Text = "1250점"},
  Task_46831_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46831_Name = {Text = "1200점"},
  Task_46832_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46832_Name = {Text = "1150점"},
  Task_46833_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46833_Name = {Text = "1100점"},
  Task_46834_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46834_Name = {Text = "1050점"},
  Task_46835_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46835_Name = {Text = "1000점"},
  Task_46836_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46836_Name = {Text = "600점"},
  Task_46837_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46837_Name = {Text = "650점"},
  Task_46838_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46838_Name = {Text = "500점"},
  Task_46839_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46839_Name = {Text = "550점"},
  Task_46840_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46840_Name = {Text = "800점"},
  Task_46841_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46841_Name = {Text = "850점"},
  Task_46842_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46842_Name = {Text = "700점"},
  Task_46843_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46843_Name = {Text = "750점"},
  Task_46844_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46844_Name = {Text = "900점"},
  Task_46845_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46845_Name = {Text = "950점"},
  Task_46846_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_46846_Name = {Text = "10승"},
  Task_46847_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_46847_Name = {Text = "400점"},
  Task_46850_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_46850_Name = {Text = "10승"},
  Task_46852_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_46852_Name = {Text = "3승"},
  Task_46853_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_46853_Name = {Text = "6승"},
  Task_46854_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_46854_Name = {Text = "1승"},
  Task_47794_Desc = {
    Text = "모든 영역의 무광의 영역 Ⅶ 클리어"
  },
  Task_47795_Desc = {
    Text = "모든 영역의 무광의 영역 Ⅰ 클리어"
  },
  Task_47796_Desc = {
    Text = "모든 영역의 무광의 영역 III 클리어"
  },
  Task_47797_Desc = {
    Text = "모든 영역의 무광의 영역 V 클리어"
  },
  Task_47799_Desc = {
    Text = "모든 영역의 무광의 영역 IV 클리어"
  },
  Task_47800_Desc = {
    Text = "모든 영역의 무광의 영역 Ⅵ 클리어"
  },
  Task_47801_Desc = {
    Text = "모든 영역의 무광의 영역 Ⅷ 클리어"
  },
  Task_47802_Desc = {
    Text = "모든 영역의 무광의 영역 Ⅱ 클리어"
  },
  Task_48166_Desc = {
    Text = "로저스 등을 밀어내기"
  },
  Task_48166_Name = {Text = "목표"},
  Task_48167_Desc = {
    Text = "그림자 「24」를 무찌르다"
  },
  Task_48167_Name = {Text = "목표"},
  Task_48733_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_48733_Desc = {
    Text = "무너진 교회와 파괴된 유물에서 박물관은 그들의 보물을 획득하고, 당신은 당신의 보물을 획득합니다. \n각자 필요한 것을 얻습니다."
  },
  Task_48733_Name = {
    Text = "조사 임무: 범신론"
  },
  Task_48733_UnlockCondDesc = {
    Text = "수호자 레벨 40에 해금"
  },
  Task_48734_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_48734_Desc = {
    Text = "당신의 인식을 잊어버리세요, 당신의 목적을 잊어버리세요. \n진실타래이 무엇인지, 그것들이 당신에게 말해줄 것입니다."
  },
  Task_48734_Name = {
    Text = "조사 임무: 선험적 이론"
  },
  Task_48734_UnlockCondDesc = {
    Text = "수호자 조사 등급 30레벨 달성 시 해제"
  },
  Task_48735_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_48735_Desc = {
    Text = "지리는 고위자의 거짓말이다.\n등고선에 주의하라."
  },
  Task_48735_Name = {
    Text = "조사 임무: 측량 조사"
  },
  Task_48735_UnlockCondDesc = {
    Text = "수호자 20 레벨 오픈"
  },
  Task_48736_CompleteCondDesc = {
    Text = "총 레벨 ≥ {s1}"
  },
  Task_48736_Desc = {
    Text = "두 가지의 신뢰할 수 없는 약속과 잊기 힘든 꿈을 얻었습니다."
  },
  Task_48736_Name = {
    Text = "조사 임무: 비경의 환영"
  },
  Task_48736_UnlockCondDesc = {
    Text = "수호자 레벨 50에 해금"
  },
  Task_48775_Desc = {
    Text = "리리의 동조율이 10레벨에 도달했습니다."
  },
  Task_48776_Desc = {
    Text = "오레타 동조율이 10급에 도달했습니다"
  },
  Task_48777_Desc = {
    Text = "파인트 동조율이 10급을 달성했습니다"
  },
  Task_48778_Desc = {
    Text = "완다 동조율이 10급에 도달했습니다"
  },
  Task_48779_Desc = {
    Text = "젠킨 동조율이 10 레벨에 도달"
  },
  Task_48780_Desc = {
    Text = "오지르 동조율이 10에 도달했습니다"
  },
  Task_48781_Desc = {
    Text = "리즈의 동조율이 10급에 도달했습니다"
  },
  Task_48782_Desc = {
    Text = "다프다일 동조율 10 레벨"
  },
  Task_48783_Desc = {
    Text = "돌 동조율 10단계 달성"
  },
  Task_48784_Desc = {
    Text = "힐레스트 동조율이 10급에 도달했습니다"
  },
  Task_48785_Desc = {
    Text = "에이지스 동조율이 10레벨에 도달"
  },
  Task_48786_Desc = {
    Text = "머피 동조율이 10 레벨에 도달했습니다"
  },
  Task_48787_Desc = {
    Text = "산 동조율이 10단계에 도달했습니다"
  },
  Task_48788_Desc = {
    Text = "유우하시 동조율이 10급에 도달했습니다"
  },
  Task_48789_Desc = {
    Text = "노디라 동조율이 10급에 도달했습니다"
  },
  Task_48790_Desc = {
    Text = "「24」 동조율이 10급에 도달했습니다"
  },
  Task_48791_Desc = {
    Text = "아그리파 동조율이 10 단계에 도달했습니다"
  },
  Task_48792_Desc = {
    Text = "팔로스 동조율이 10 단계를 달성했습니다"
  },
  Task_48793_Desc = {
    Text = "벤코르 동조율이 10에 도달했습니다"
  },
  Task_48794_Desc = {
    Text = "살바도르 동조율 LV.10 달성"
  },
  Task_48795_Desc = {
    Text = "시로 동조율이 10 레벨에 도달했습니다"
  },
  Task_48796_Desc = {
    Text = "에리카의 동조율이 10단계에 도달했습니다"
  },
  Task_48797_Desc = {
    Text = "라몬나 동조율이 10급에 도달했습니다"
  },
  Task_48798_Desc = {
    Text = "소렐 동조율이 10 레벨을 달성했습니다"
  },
  Task_48799_Desc = {
    Text = "테이스 동조율이 10급에 도달했습니다"
  },
  Task_48800_Desc = {
    Text = "고리아 동조율이 10단계에 도달했습니다"
  },
  Task_48801_Desc = {
    Text = "레이아 동조율이 10급에 도달했습니다"
  },
  Task_48802_Desc = {
    Text = "엘바 동조율이 10 단계에 도달했습니다"
  },
  Task_48803_Desc = {
    Text = "케이크스 동조율이 10급에 도달했습니다"
  },
  Task_48804_Desc = {
    Text = "투루 동조율이 10급에 도달했습니다"
  },
  Task_48805_Desc = {
    Text = "카시아 동조율이 10급에 도달했습니다"
  },
  Task_48806_Desc = {
    Text = "가렌 동조율이 10단계를 달성했습니다"
  },
  Task_48807_Desc = {
    Text = "판디아 동조율이 10단계에 도달했습니다"
  },
  Task_48808_Desc = {
    Text = "틴커트 동조율이 10 단계에 도달했습니다"
  },
  Task_48809_Desc = {
    Text = "닝피아 동조율이 10단계에 도달했습니다"
  },
  Task_48810_Desc = {
    Text = "로탄 동조율이 10급에 도달했습니다"
  },
  Task_48829_Desc = {
    Text = "누적 로그인 11일"
  },
  Task_48830_Desc = {
    Text = "누적 로그인 14일"
  },
  Task_48831_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_48832_Desc = {
    Text = "누적 로그인 16일"
  },
  Task_48833_Desc = {
    Text = "누적 로그인 12일"
  },
  Task_48834_Desc = {
    Text = "누적 로그인 13일"
  },
  Task_48835_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_48836_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_48837_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_48838_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_48839_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_48840_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_48841_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_48842_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_48843_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_48844_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_49241_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_49241_Name = {Text = "1승"},
  Task_49242_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_49242_Name = {Text = "3승"},
  Task_49243_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_49243_Name = {Text = "6승"},
  Task_49244_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_49244_Name = {Text = "10승"},
  Task_49245_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_49245_Name = {Text = "10승"},
  Task_49246_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_49246_Name = {Text = "1승"},
  Task_49247_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_49247_Name = {Text = "6승"},
  Task_49248_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_49248_Name = {Text = "3승"},
  Task_49262_Desc = {
    Text = "최종전 30턴 내 승리"
  },
  Task_49262_Name = {
    Text = "최종전 30턴 내 승리"
  },
  Task_49380_Desc = {
    Text = "클리어 「재생화」 아무 난이도"
  },
  Task_49381_Desc = {
    Text = "혼란스러운 정욕·재현"
  },
  Task_49382_Desc = {
    Text = "「혼란 욕망·클리어」 모든 임무 완료"
  },
  Task_49383_Desc = {
    Text = "혼란스러운 정욕·클리어"
  },
  Task_49384_Desc = {
    Text = "클리어 「다중 배아 생식」 어떤 난이도든"
  },
  Task_49385_Desc = {
    Text = "클리어 「낙과」 모든 난이도"
  },
  Task_49386_Desc = {
    Text = "「혼란스러운 정욕」에서 30번 재현"
  },
  Task_49387_Desc = {
    Text = "클리어 「밀선」 어떤 난이도든"
  },
  Task_49388_Desc = {
    Text = "「혼란스러운 정욕」에 10번 재현"
  },
  Task_49389_Desc = {
    Text = "클리어 「유근」 아무 난이도"
  },
  Task_49390_Desc = {
    Text = "클리어 「발아」 모든 난이도"
  },
  Task_49391_Desc = {
    Text = "「혼란스러운 정욕」에 20번 재현"
  },
  Task_49392_Desc = {
    Text = "「혼란스러운 정욕」에서 50번 재현"
  },
  Task_49393_Desc = {
    Text = "「혼란스러운 정욕」에서 40번 재현"
  },
  Task_49394_Desc = {
    Text = "클리어 「꽃받침」 아무 난이도"
  },
  Task_49395_Desc = {
    Text = "클리어 「배주」 임의 난이도"
  },
  Task_49396_Desc = {
    Text = "클리어 「수분」 임의의 난이도"
  },
  Task_49397_Desc = {
    Text = "클리어 「년륜」 어떤 난이도"
  },
  Task_49769_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 50%만큼의 방어막 획득"
  },
  Task_49769_Name = {
    Text = "강철의 몸"
  },
  Task_49770_Desc = {
    Text = "엘리트 전투에서 1턴 동안 3000 이상의 피해 입히기"
  },
  Task_49770_Name = {
    Text = "전력의 일격"
  },
  Task_49771_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_49771_Name = {
    Text = "악의 근절"
  },
  Task_49772_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_49772_Name = {
    Text = "기병의 보물창고"
  },
  Task_49773_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_49773_Name = {
    Text = "영혼의 낙인"
  },
  Task_49774_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_49774_Name = {
    Text = "우아하고 정확한"
  },
  Task_49775_Desc = {
    Text = "최종전에서 1턴 동안 7장 이상의 카드 사용"
  },
  Task_49775_Name = {
    Text = "내 차례야!이야"
  },
  Task_49776_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_49776_Name = {
    Text = "무한의 포옹"
  },
  Task_49777_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_49777_Name = {
    Text = "에너지 절약"
  },
  Task_49778_Desc = {
    Text = "임의의 전투에서 1턴 동안 2체 이상의 적 처치"
  },
  Task_49778_Name = {
    Text = "악의 근절"
  },
  Task_49779_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_49779_Name = {
    Text = "기병의 보물창고"
  },
  Task_49780_Desc = {
    Text = "4종류 이상의 서로 다른 각인을 획득"
  },
  Task_49780_Name = {
    Text = "영혼의 낙인"
  },
  Task_49781_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_49781_Name = {
    Text = "우아하고 정확하게"
  },
  Task_49782_Desc = {
    Text = "최종전에서 1턴 동안 7장 이상의 카드 사용"
  },
  Task_49782_Name = {
    Text = "내 차례야!이야"
  },
  Task_49783_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_49783_Name = {
    Text = "무한의 포옹"
  },
  Task_49784_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_49784_Name = {
    Text = "에너지 절약"
  },
  Task_49785_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 50%만큼의 방어막 획득"
  },
  Task_49785_Name = {
    Text = "강철의 몸"
  },
  Task_49786_Desc = {
    Text = "엘리트 전투에서 1턴 동안 4500 이상의 피해 입히기"
  },
  Task_49786_Name = {
    Text = "전력의 일격"
  },
  Task_49787_Desc = {
    Text = "엘리트 전투에서 1턴 동안 7300 이상의 피해 입히기"
  },
  Task_49787_Name = {
    Text = "전력의 일격"
  },
  Task_49788_Desc = {
    Text = "서로 다른 각인 6종류 이상 획득"
  },
  Task_49788_Name = {
    Text = "영혼의 낙인"
  },
  Task_49789_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_49789_Name = {
    Text = "우아하고 정확한"
  },
  Task_49790_Desc = {
    Text = "7개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_49790_Name = {
    Text = "기병의 보물창고"
  },
  Task_49791_Desc = {
    Text = "연락 지점에서 HP를 회복하지 않고 클리어"
  },
  Task_49791_Name = {
    Text = "불붙지 않은 자"
  },
  Task_49792_Desc = {
    Text = "엘리트 전투에서 1턴 동안 9000 이상의 피해 입히기"
  },
  Task_49792_Name = {
    Text = "전력의 일격"
  },
  Task_49793_Desc = {
    Text = "6종류 이상의 서로 다른 각인 획득"
  },
  Task_49793_Name = {
    Text = "영혼의 낙인"
  },
  Task_49794_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_49794_Name = {
    Text = "우아하고 정확하게"
  },
  Task_49795_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49795_Name = {
    Text = "속전속결"
  },
  Task_49796_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49796_Name = {
    Text = "속전속결"
  },
  Task_49797_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49797_Name = {
    Text = "속전속결"
  },
  Task_49798_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49798_Name = {
    Text = "속전속결"
  },
  Task_49799_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49799_Name = {
    Text = "속전속결"
  },
  Task_49800_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49800_Name = {
    Text = "속전속결"
  },
  Task_49801_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49801_Name = {
    Text = "속전속결"
  },
  Task_49802_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49802_Name = {
    Text = "속전속결"
  },
  Task_49803_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49803_Name = {
    Text = "속전속결"
  },
  Task_49804_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49804_Name = {
    Text = "완벽한 통과"
  },
  Task_49805_Desc = {
    Text = "7개 이상의 유물을 소지한 상태로 클리어"
  },
  Task_49805_Name = {
    Text = "기병의 보물창고"
  },
  Task_49806_Desc = {
    Text = "연락 지점에서 HP를 회복하지 않고 클리어"
  },
  Task_49806_Name = {
    Text = "불붙지 않은 자"
  },
  Task_49807_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49807_Name = {
    Text = "완벽한 통과"
  },
  Task_49808_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49808_Name = {
    Text = "완벽한 통과"
  },
  Task_49809_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49809_Name = {
    Text = "완벽한 통과"
  },
  Task_49810_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49810_Name = {
    Text = "완벽한 통과"
  },
  Task_49811_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49811_Name = {
    Text = "완벽한 통과"
  },
  Task_49812_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49812_Name = {
    Text = "완벽한 통과"
  },
  Task_49813_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49813_Name = {
    Text = "완벽한 통과"
  },
  Task_49814_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49814_Name = {
    Text = "완벽한 통과"
  },
  Task_49815_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49815_Name = {
    Text = "완벽한 통과"
  },
  Task_49816_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49816_Name = {
    Text = "완벽한 통과"
  },
  Task_49817_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_49817_Name = {
    Text = "에너지 절약"
  },
  Task_49818_Desc = {
    Text = "최종전에서 1턴 동안 4체 이상의 적 처치"
  },
  Task_49818_Name = {
    Text = "악의 근절"
  },
  Task_49819_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_49819_Name = {
    Text = "에너지 절약"
  },
  Task_49820_Desc = {
    Text = "최종전에서 1턴 동안 4체 이상의 적 처치"
  },
  Task_49820_Name = {
    Text = "악의 근절"
  },
  Task_49821_Desc = {
    Text = "최종전에서 18턴 이내에 승리"
  },
  Task_49821_Name = {
    Text = "속전속결"
  },
  Task_49822_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49822_Name = {
    Text = "속전속결"
  },
  Task_49823_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_49823_Name = {
    Text = "속전속결"
  },
  Task_49824_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_49824_Name = {
    Text = "완벽한 통과"
  },
  Task_49852_Desc = {
    Text = "누비아에 위협받는 캠프 정리하기"
  },
  Task_49852_Name = {Text = "목표"},
  Task_49853_Desc = {
    Text = "폭풍의 벽 돌파하기"
  },
  Task_49853_Name = {Text = "목표"},
  Task_49854_Desc = {
    Text = "아란 병사를 유괴하여 유해의 위치를 알아내기"
  },
  Task_49854_Name = {Text = "목표"},
  Task_49855_Desc = {
    Text = "수원 찾기"
  },
  Task_49855_Name = {Text = "목표"},
  Task_49856_Desc = {
    Text = "카시아를 격파하여 유해 되찾기"
  },
  Task_49856_Name = {Text = "목표"},
  Task_49857_Desc = {
    Text = "타이스와 함께 싸우기"
  },
  Task_49857_Name = {Text = "목표"},
  Task_49858_Desc = {
    Text = "카시아의 마수로부터 벗어나기"
  },
  Task_49858_Name = {Text = "목표"},
  Task_49859_Desc = {
    Text = "지모수 부활 의식 저지"
  },
  Task_49859_Name = {Text = "목표"},
  Task_49860_Desc = {
    Text = "지모수의 의식의 바다로 들어가기"
  },
  Task_49860_Name = {Text = "목표"},
  Task_49861_Desc = {
    Text = "아란인들을 위해 누비아 몰아내기"
  },
  Task_49861_Name = {Text = "목표"},
  Task_49862_Desc = {
    Text = "지모수의 유해 찾기"
  },
  Task_49862_Name = {Text = "목표"},
  Task_49863_Desc = {
    Text = "지모수 격파"
  },
  Task_49863_Name = {Text = "목표"},
  Task_49879_Desc = {
    Text = "환형·라몬나 동조율이 10급에 도달"
  },
  Task_50033_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_50033_Desc2 = {
    Text = "조사 이벤트 「욕하」에서 공명 6회"
  },
  Task_50033_Name2 = {
    Text = "망념의 울림 Ⅱ"
  },
  Task_50034_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 9번"
  },
  Task_50034_Desc2 = {
    Text = "조사 사건 「욕하」에서 공명 9회"
  },
  Task_50034_Name2 = {
    Text = "망념의 울림 Ⅲ"
  },
  Task_50035_Desc = {
    Text = "12곳의 메인 줄기 7장 「@1@2」의 분해점을 찾아"
  },
  Task_50035_Desc2 = {
    Text = "12곳의 메인 줄기 7장 「욕하」의 분해점 찾기"
  },
  Task_50035_Name2 = {
    Text = "숨겨진 속삭임 Ⅶ"
  },
  Task_50036_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_50036_Desc2 = {
    Text = "조사 사건 「욕하」에서 공명 3회"
  },
  Task_50036_Name2 = {
    Text = "망념의 울림"
  },
  Task_50037_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_50037_Desc2 = {
    Text = "조사 완료 사건 「욕하」"
  },
  Task_50037_Name2 = {
    Text = "성수가 타버릴 때"
  },
  Task_50038_Desc = {
    Text = "조사 완료 이벤트 「욕하」 어려움 난이도"
  },
  Task_50038_Name = {
    Text = "성수가 타버릴 때·어려움"
  },
  Task_50039_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 11번 발생"
  },
  Task_50039_Desc2 = {
    Text = "조사 사건 「욕하」에서 공명 11 회"
  },
  Task_50039_Name2 = {
    Text = "망념의 울림 Ⅳ"
  },
  Task_51106_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「스케줄 미스터리」에서 2번 승리하십시오"
  },
  Task_51107_Desc = {
    Text = "완료 「스케줄 미스터리·클리어」의 모든 태스크"
  },
  Task_51108_Desc = {
    Text = "클리어 「시나리오 회전」 모든 난이도"
  },
  Task_51109_Desc = {
    Text = "특파 기록"
  },
  Task_51109_Name = {
    Text = "【폐기됨】"
  },
  Task_51110_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「스케줄 미스터리」에서 1회 승리"
  },
  Task_51111_Desc = {
    Text = "스케줄 미스터리·경계역"
  },
  Task_51112_Desc = {
    Text = "카오스 경계역의 깨어남체를 사용하여 「스케줄 미스터리」에서 1회 승리하기"
  },
  Task_51113_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「스케줄 미스터리」에서 2번 승리하기"
  },
  Task_51114_Desc = {
    Text = "클리어 ‘카타시스’ 임의 난이도"
  },
  Task_51115_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「스케줄 미스터리」에서 두 번 승리하기"
  },
  Task_51116_Desc = {
    Text = "클리어 「가면 코미디」 임의 난이도"
  },
  Task_51117_Desc = {
    Text = "클리어 「삼일률」 아무 난이도"
  },
  Task_51118_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「스케줄 미스터리」에서 1번 승리하기"
  },
  Task_51119_Desc = {
    Text = "클리어 「호광이론」 모든 난이도"
  },
  Task_51120_Desc = {
    Text = "클리어 「극작 피라미드」 임의 난이도"
  },
  Task_51121_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「스케줄 미스터리」에서 1회 승리"
  },
  Task_51122_Desc = {
    Text = "클리어 「드라마의 네 번째 벽」 어떤 난이도로든"
  },
  Task_51123_Desc = {
    Text = "클리어 「이방화 효과」 임의의 난이도"
  },
  Task_51124_Desc = {
    Text = "스케줄 미스터리·클리어"
  },
  Task_51125_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「스케줄 미스터리」에서 두 번 승리하세요"
  },
  Task_51126_Desc = {
    Text = "클리어 「장면 정지 순간」 모든 난이도"
  },
  Task_51140_Desc = {
    Text = "통관 특수 임무 기록 「이야기의 마법」"
  },
  Task_51141_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_51141_Name = {
    Text = "【폐기됨】"
  },
  Task_51142_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_51142_Name = {
    Text = "【폐기됨】"
  },
  Task_51143_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_51143_Name = {
    Text = "【폐기됨】"
  },
  Task_51144_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_51144_Name = {
    Text = "【폐기됨】"
  },
  Task_51145_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_51145_Name = {
    Text = "【폐기됨】"
  },
  Task_51146_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_51146_Name = {
    Text = "【폐기됨】"
  },
  Task_52280_Desc = {
    Text = "「영누이 제단」에 제물 바쳐 100회 보상 획득"
  },
  Task_52281_Desc = {
    Text = "「영누이 제단」에 제물 바쳐 200회 보상 획득"
  },
  Task_52282_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「심연의 제사」에서 2번 승리하라"
  },
  Task_52283_Desc = {
    Text = "심연의 제사·클리어"
  },
  Task_52284_Desc = {
    Text = "클리어 「증언」 모든 난이도"
  },
  Task_52285_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「심연의 제사」에서 1 회 승리"
  },
  Task_52286_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「심연의 제사」에서 2번 승리하기"
  },
  Task_52287_Desc = {
    Text = "클리어 「신념」 아무 난이도"
  },
  Task_52288_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「심연의 제사」에서 1회 승리"
  },
  Task_52289_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「심연의 제사」에서 1회 승리하기"
  },
  Task_52290_Desc = {
    Text = "심연의 제사·경계역"
  },
  Task_52291_Desc = {
    Text = "이몽시계 클리어 「모독」"
  },
  Task_52292_Desc = {
    Text = "「고릴라 혈 제단」 제물 바치기로 100번의 보상을 획득"
  },
  Task_52293_Desc = {
    Text = "「혈 제단」에 제물 바치기로 200회 보상을 획득"
  },
  Task_52294_Desc = {
    Text = "「영수단」 제물 바치기로 200회 보상 획득"
  },
  Task_52295_Desc = {
    Text = "「영수단」 제물 바치기로 100번의 보상을 획득"
  },
  Task_52296_Desc = {
    Text = "클리어 「의심」 임의의 난이도"
  },
  Task_52297_Desc = {
    Text = "클리어 「동요」 모든 난이도"
  },
  Task_52298_Desc = {
    Text = "혈육 경계역 깨어남체를 사용하여 「심연의 제사」에서 2번 승리하세요"
  },
  Task_52299_Desc = {
    Text = "초월계역 깨어남체를 사용하여 「심연의 제사」에서 1회 승리"
  },
  Task_52300_Desc = {
    Text = "클리어 「강림」 모든 난이도"
  },
  Task_52301_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「심연의 제사」에서 2회 승리하기"
  },
  Task_52302_Desc = {
    Text = "심연의 응답"
  },
  Task_52303_Desc = {
    Text = "「심연의 제사·클리어」와 「심연의 응답」 모든 태스크 완료"
  },
  Task_53694_Desc = {
    Text = "「정수 활성 이온」 1000 달성"
  },
  Task_53695_Desc = {
    Text = "누적 20회 파견 완료"
  },
  Task_53696_Desc = {
    Text = "등교 신고 첫날"
  },
  Task_53697_Desc = {
    Text = "카오스 경계역 깨어남체로 3승을 거두세요"
  },
  Task_53698_Desc = {
    Text = "동창회에서 다른 사람에게 10번 좋아요를 누르기"
  },
  Task_53699_Desc = {
    Text = "등교 신고 6일차"
  },
  Task_53700_Desc = {
    Text = "등교 신고 5일째"
  },
  Task_53701_Desc = {
    Text = "네번째 날"
  },
  Task_53702_Desc = {Text = "다음 날"},
  Task_53703_Desc = {
    Text = "세번째 날"
  },
  Task_53704_Desc = {Text = "첫날"},
  Task_53705_Desc = {
    Text = "초원차원 경계역 깨어남체를 사용하여 3번 승리하세요"
  },
  Task_53706_Desc = {
    Text = "등교 신고 4일차"
  },
  Task_53707_Desc = {
    Text = "혈육 경계역에서 깨어남한 깨어남체로 3회의 승리를 거두세요"
  },
  Task_53708_Desc = {
    Text = "깊은 바다 영역 깨어남체로 3승을 거두세요"
  },
  Task_53709_Desc = {
    Text = "등교 신고 2일차"
  },
  Task_53710_Desc = {
    Text = "깨어남체 육성을 1회 완료"
  },
  Task_53711_Desc = {
    Text = "누적 소모 50000 장미 금권"
  },
  Task_53712_Desc = {
    Text = "누적 영페닌 1500포인트 소모"
  },
  Task_53713_Desc = {
    Text = "「정수 활성 이온」 500 달성"
  },
  Task_53714_Desc = {
    Text = "누적 사용 50만 장미 금권"
  },
  Task_53715_Desc = {
    Text = "아무 깨어남 이벤트에서 20회 누적 깨어남 의식 진행"
  },
  Task_53716_Desc = {
    Text = "클리어 무광의 경계 또는 초월적 존재"
  },
  Task_53717_Desc = {
    Text = "동문의 깨어남체를 사용하여 10번 도우미 전투"
  },
  Task_53718_Desc = {
    Text = "등교 신고 3일째"
  },
  Task_53719_Desc = {
    Text = "동문의 깨어남체를 도우미로 사용"
  },
  Task_53720_Desc = {
    Text = "상점에서 금권을 사용하여 3회 교환"
  },
  Task_53721_Desc = {
    Text = "영페닌 180포인트 소모"
  },
  Task_53722_Desc = {
    Text = "파견 3회 실타래행"
  },
  Task_53723_Desc = {
    Text = "등교 신고 7일차"
  },
  Task_53724_Desc = {
    Text = "「기초 활성 이온」 1000 달성"
  },
  Task_53725_Desc = {
    Text = "1회 깨어남체 체험판 스테이지를 완료하세요"
  },
  Task_53726_Desc = {
    Text = "깨어남 1회 진행"
  },
  Task_53982_Desc = {
    Text = "카오스 경계역의 깨어남체를 사용하여 「장미의 추억」에서 한 번 승리하기"
  },
  Task_53983_Desc = {
    Text = "클리어 「인형 게임」 아무 난이도"
  },
  Task_53984_Desc = {
    Text = "클리어 「시선」 모든 난이도"
  },
  Task_53985_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「장미의 추억」에서 2번 승리하세요"
  },
  Task_53986_Desc = {
    Text = "혈육계역의 깨어남체를 사용하여 「장미의 추억」에서 1회 승리하기"
  },
  Task_53987_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「장미의 추억」에서 2회 승리"
  },
  Task_53988_Desc = {
    Text = "장미의 추억·경계역"
  },
  Task_53989_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「장미의 추억」에서 한 번 승리하기"
  },
  Task_53990_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「장미의 추억」에서 2번 승리"
  },
  Task_53991_Desc = {
    Text = "완료 「장미의 추억·클리어」 모든 태스크"
  },
  Task_53992_Desc = {
    Text = "클리어 「미완의 대본」 임의의 난이도"
  },
  Task_53993_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「장미의 추억」에서 1회 승리"
  },
  Task_53994_Desc = {
    Text = "클리어 「장미의 각도」 어떤 난이도든"
  },
  Task_53995_Desc = {
    Text = "장미의 추억·클리어"
  },
  Task_53996_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「장미의 추억」에서 2번 승리"
  },
  Task_53997_Desc = {
    Text = "클리어 「장다리 아저씨」 의 임의 난이도"
  },
  Task_53998_Desc = {
    Text = "클리어 「선물」 아무 난이도"
  },
  Task_53999_Desc = {
    Text = "클리어 「종곡」 임의의 난이도"
  },
  Task_54000_Desc = {
    Text = "클리어 「부아래서 헤엄치는 물고기」 어떤 난이도로든"
  },
  Task_54001_Desc = {
    Text = "클리어 「얼굴」 임의 난이도"
  },
  Task_54542_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_54542_Name = {Text = "1승"},
  Task_54543_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_54543_Name = {Text = "6승"},
  Task_54544_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_54544_Name = {Text = "3승"},
  Task_54545_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_54545_Name = {Text = "10승"},
  Task_54546_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_54546_Name = {Text = "1승"},
  Task_54547_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_54547_Name = {Text = "10승"},
  Task_54548_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_54548_Name = {Text = "10승"},
  Task_54549_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_54549_Name = {Text = "6승"},
  Task_54550_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_54550_Name = {Text = "1승"},
  Task_54551_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_54551_Name = {Text = "3승"},
  Task_54552_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_54552_Name = {Text = "6승"},
  Task_54553_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_54553_Name = {Text = "3승"},
  Task_54554_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_54554_Name = {Text = "6승"},
  Task_54555_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_54555_Name = {Text = "1승"},
  Task_54556_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_54556_Name = {Text = "10승"},
  Task_54557_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_54557_Name = {Text = "3승"},
  Task_54585_Desc = {
    Text = "누적 1,000 원액 추출하기"
  },
  Task_54586_Desc = {
    Text = "누적 3,000 원액 추출하기"
  },
  Task_54587_Desc = {
    Text = "누적 6,000 원액 추출하기"
  },
  Task_54588_Desc = {
    Text = "누적 10,000 원액 추출하기"
  },
  Task_54589_Desc = {
    Text = "누적 30,000 원액 추출하기"
  },
  Task_54590_Desc = {
    Text = "누적 60,000 원액 추출하기"
  },
  Task_54591_Desc = {
    Text = "누적 100,000 원액 추출하기"
  },
  Task_55092_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_55092_Name = {
    Text = "영역 숙련 Ⅶ"
  },
  Task_55093_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_55093_Name = {
    Text = "영역 숙련 Ⅵ"
  },
  Task_55094_Desc = {
    Text = "혈육 영역 깨어남체 3명 레벨 60 달성"
  },
  Task_55094_Name = {
    Text = "혈육 숙련 Ⅶ"
  },
  Task_55095_Desc = {
    Text = "심해 영역 깨어남체 3명 레벨 60 달성"
  },
  Task_55095_Name = {
    Text = "심해 숙련 Ⅶ"
  },
  Task_55096_Desc = {
    Text = "혼돈 영역 깨어남체 3명 레벨 60 달성"
  },
  Task_55096_Name = {
    Text = "혼돈 숙련 Ⅶ"
  },
  Task_55097_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_55097_Name = {
    Text = "영역 숙련 Ⅷ"
  },
  Task_55098_Desc = {
    Text = "초차원 영역 깨어남체 3명 레벨 60 달성"
  },
  Task_55098_Name = {
    Text = "초차원 숙련 Ⅶ"
  },
  Task_55099_Desc = {
    Text = "초차원 영역 깨어남체 1명 레벨 60 달성"
  },
  Task_55099_Name = {
    Text = "초차원 숙련 VI"
  },
  Task_55100_Desc = {
    Text = "혼돈 영역 깨어남체 1명 레벨 60 달성"
  },
  Task_55100_Name = {
    Text = "혼돈 숙련 VI"
  },
  Task_55101_Desc = {
    Text = "심해 영역 깨어남체 1명 레벨 60 달성"
  },
  Task_55101_Name = {
    Text = "심해 숙련 VI"
  },
  Task_55102_Desc = {
    Text = "혈육 영역 깨어남체 1명 레벨 60 달성"
  },
  Task_55102_Name = {
    Text = "혈육 숙련 VI"
  },
  Task_55103_Desc = {
    Text = "초차원 영역 깨어남체 6명 레벨 60 달성"
  },
  Task_55103_Name = {
    Text = "초차원 숙련 Ⅷ"
  },
  Task_55104_Desc = {
    Text = "심해 영역 깨어남체 6명 레벨 60 달성"
  },
  Task_55104_Name = {
    Text = "심해 숙련 Ⅷ"
  },
  Task_55105_Desc = {
    Text = "혈육 영역 깨어남체 6명 레벨 60 달성"
  },
  Task_55105_Name = {
    Text = "혈육 숙련 Ⅷ"
  },
  Task_55106_Desc = {
    Text = "혼돈 영역 깨어남체 6명 레벨 60 달성"
  },
  Task_55106_Name = {
    Text = "혼돈 숙련 Ⅷ"
  },
  Task_55177_Desc = {
    Text = "「정원의 추억·클리어」모든 업적 완료"
  },
  Task_55178_Desc = {
    Text = "정원의 추억·경계역"
  },
  Task_55179_Desc = {
    Text = "코레트의 꽃집"
  },
  Task_55180_Desc = {
    Text = "카오스 경계역 깨어남체로 「정원의 추억」에서 2번 승리하기"
  },
  Task_55181_Desc = {
    Text = "클리어 「작은 왕국」 임의의 난이도"
  },
  Task_55182_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「정원의 추억」에서 한 번 승리"
  },
  Task_55183_Desc = {
    Text = "정원의 추억·클리어"
  },
  Task_55184_Desc = {
    Text = "클리어 「번영하는 시편」 임의 난이도."
  },
  Task_55185_Desc = {
    Text = "「장미 정원」에서 시를 교환하여 100회 보상을 받음"
  },
  Task_55186_Desc = {
    Text = "「장미 정원」에서 시를 교환하여 200회 피드백 획득"
  },
  Task_55187_Desc = {
    Text = "클리어 「재」 아무 난이도"
  },
  Task_55188_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「정원의 추억」에서 두 번 승리하기"
  },
  Task_55189_Desc = {
    Text = "「계개화원」에서 시를 교환하여 200회 보상 획득"
  },
  Task_55190_Desc = {
    Text = "「계개화원」에서 시문을 교환하여 100번의 보상 획득"
  },
  Task_55191_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용해 「정원의 추억」에서 1회 승리"
  },
  Task_55192_Desc = {
    Text = "통관 특수 임무 기록 「장미의 거처」"
  },
  Task_55193_Desc = {
    Text = "클리어 「손을 잡다」 아무 난이도"
  },
  Task_55194_Desc = {
    Text = "클리어 「첫 번째 장미」 아무 난이도"
  },
  Task_55195_Desc = {
    Text = "「아이리스 정원」에서 시문을 교환하여 200번의 보상 획득"
  },
  Task_55196_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「정원의 추억」에서 1회 승리."
  },
  Task_55197_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「정원의 추억」에서 2번 승리하세요"
  },
  Task_55198_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「정원의 추억」에서 2번 승리"
  },
  Task_55199_Desc = {
    Text = "깊은 바다 영역의 깨어남체를 사용하여 「정원의 추억」에서 1회 승리하기"
  },
  Task_55200_Desc = {
    Text = "「아이리스 정원」에서 시문을 교환하여 100번의 응답 획득"
  },
  Task_55426_Desc = {
    Text = "코레트를 격파하다"
  },
  Task_55426_Name = {Text = "목표"},
  Task_55852_Desc = {
    Text = "깨어남체 1명 70레벨 달성"
  },
  Task_55852_Name = {Text = "임무 2"},
  Task_55853_Desc = {
    Text = "메인 스토리 조사·제7장 보통 완료"
  },
  Task_55853_Name = {Text = "임무 3"},
  Task_55854_Desc = {
    Text = "깨어남체 4명 62레벨 달성"
  },
  Task_55854_Name = {Text = "임무 1"},
  Task_55855_Desc = {
    Text = "임의의 깨어남체 인격 심화 4레벨 달성"
  },
  Task_55855_Name = {Text = "임무 4"},
  Task_55856_Desc = {
    Text = "융재 특훈 점수 150점 달성"
  },
  Task_55856_Name = {Text = "임무 5"},
  Task_55857_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_55857_Name = {Text = "제8단계"},
  Task_55858_Desc = {
    Text = "이번 단계의 모든 미션을 완료하여 보상 수령"
  },
  Task_55858_Name = {Text = "제7단계"},
  Task_55859_Desc = {
    Text = "깨어남체 1명 62레벨 달성"
  },
  Task_55859_Name = {Text = "임무 2"},
  Task_55860_Desc = {
    Text = "메인 스토리 조사·제6장 보통 완료"
  },
  Task_55860_Name = {Text = "임무 3"},
  Task_55861_Desc = {
    Text = "임의의 깨어남체 스킬 6레벨 달성"
  },
  Task_55861_Name = {Text = "임무 1"},
  Task_55862_Desc = {
    Text = "임의의 깨어남체 재능 활성화하기"
  },
  Task_55862_Name = {Text = "임무 4"},
  Task_55863_Desc = {
    Text = "융재 특훈 점수 50점 달성"
  },
  Task_55863_Name = {Text = "임무 5"},
  Task_56002_Desc = {
    Text = "의식 잠수 “거인의 몰락” 어려움 완료"
  },
  Task_56002_Name = {
    Text = "무비의 용감·어려움"
  },
  Task_56003_Desc = {
    Text = "완료: 의식 잠수 “일상적으로 모든 일이 진행 중입니다” 어려움 난이도"
  },
  Task_56003_Name = {
    Text = "보이지 않는 도시·어려움"
  },
  Task_56004_Desc = {
    Text = "의식 잠수 「거인의 몰락」 완료"
  },
  Task_56004_Name = {
    Text = "무비의 용감"
  },
  Task_56005_Desc = {
    Text = "특파 기록 “” 어려움 완료"
  },
  Task_56005_Name = {
    Text = "강의 원류로 돌아가다·어려움"
  },
  Task_56006_Desc = {
    Text = "특파 기록 「피의 색」 완료"
  },
  Task_56006_Name = {
    Text = "영원한 자비·어려움"
  },
  Task_56007_Desc = {
    Text = "특파 기록 「비 내리는 마을의 유령」 완료"
  },
  Task_56007_Name = {
    Text = "강의 원류로 돌아가다"
  },
  Task_56008_Desc = {
    Text = "특파 기록 「피의 색」 완료"
  },
  Task_56008_Name = {
    Text = "영원한 자비"
  },
  Task_56009_Desc = {
    Text = "이몽시계 「모독」 완성"
  },
  Task_56009_Name = {
    Text = "왜곡된 광신"
  },
  Task_56103_Desc = {
    Text = "적에게 50000단계 중독을 중첩"
  },
  Task_56103_Name = {
    Text = "현실타래의 독 Ⅲ"
  },
  Task_56104_Desc = {
    Text = "적에게 100000층 중독을 적용"
  },
  Task_56104_Name = {
    Text = "현실타래의 독 Ⅳ"
  },
  Task_56106_Desc = {
    Text = "6명의 80레벨 깨어남체를 보유하고"
  },
  Task_56106_Name = {
    Text = "「초월의 힘」Ⅴ"
  },
  Task_56107_Desc = {
    Text = "「이몽 시야」의 「하늘 끝 너머」 상급 완료"
  },
  Task_56107_Name = {Text = "하강"},
  Task_56108_Desc = {
    Text = "200 회 환몽 심잠 완료"
  },
  Task_56108_Name = {
    Text = "드림하트 어드벤처"
  },
  Task_56109_Desc = {
    Text = "300번의 환몽 심잠 완료"
  },
  Task_56109_Name = {
    Text = "드림워커"
  },
  Task_56110_Desc = {
    Text = "완료 500회 환몽 심잠"
  },
  Task_56110_Name = {
    Text = "드림마스터"
  },
  Task_56111_Desc = {
    Text = "8명의 80레벨 깨어남체를 보유"
  },
  Task_56111_Name = {
    Text = "「초월의 힘」Ⅵ"
  },
  Task_56112_Desc = {
    Text = "10명의 80레벨 깨어남체를 소유"
  },
  Task_56112_Name = {
    Text = "「초월의 힘」Ⅶ"
  },
  Task_56113_Desc = {
    Text = "8명의 깨어남체와 동조율 레벨 10 도달"
  },
  Task_56113_Name = {
    Text = "만나서 반갑습니다"
  },
  Task_56115_Desc = {
    Text = "합성 재료 11111 회"
  },
  Task_56115_Name = {
    Text = "고속으로 회전하는 용해로가 미사그에 진입합니다"
  },
  Task_56116_Desc = {
    Text = "레벨 12의 미스터리 200개 소유"
  },
  Task_56116_Name = {
    Text = "금지된 수호자 Ⅳ"
  },
  Task_56117_Desc = {
    Text = "4명의 깨어남체와 동조율을 레벨 10에 도달"
  },
  Task_56117_Name = {
    Text = "궁합 콤비 Ⅸ"
  },
  Task_56118_Desc = {
    Text = "깨어남체 스킬 400번 업그레이드"
  },
  Task_56118_Name = {
    Text = "「무공 숙련」Ⅱ"
  },
  Task_56120_Desc = {
    Text = "30명의 80레벨 깨어남체 보유"
  },
  Task_56120_Name = {
    Text = "무에 대한 선전포고 Ⅲ"
  },
  Task_56121_Desc = {
    Text = "80레벨 깨어남체 25명 보유"
  },
  Task_56121_Name = {
    Text = "무에 대한 선전포고Ⅱ"
  },
  Task_56122_Desc = {
    Text = "20명의 80레벨 깨어남체를 소유"
  },
  Task_56122_Name = {
    Text = "무에 대한 선전포고Ⅰ"
  },
  Task_56123_Desc = {
    Text = "15명의 80레벨 깨어남체를 보유"
  },
  Task_56123_Name = {
    Text = "「초월의 힘」Ⅷ"
  },
  Task_56126_Desc = {
    Text = "40명의 80레벨 깨어남체를 보유하고 있다"
  },
  Task_56126_Name = {
    Text = "무에 대한 선전포고Ⅴ"
  },
  Task_56127_Desc = {
    Text = "35명의 80레벨 깨어남체를 소유"
  },
  Task_56127_Name = {
    Text = "무에 대한 선전포고 Ⅳ"
  },
  Task_56128_Desc = {
    Text = "누적 소모 250000 검은 인장"
  },
  Task_56128_Name = {
    Text = "환영합니다「빛」Ⅴ"
  },
  Task_56129_Desc = {
    Text = "누적 소모 1000000 검은 인장"
  },
  Task_56129_Name = {
    Text = "환영합니다「빛」Ⅶ"
  },
  Task_56130_Desc = {
    Text = "누적 소모 500000 검은 인장"
  },
  Task_56130_Name = {
    Text = "환영합니다「빛」Ⅵ"
  },
  Task_56131_Desc = {
    Text = "깨어남체 스킬 800회 업그레이드"
  },
  Task_56131_Name = {
    Text = "「무공 숙련」Ⅵ"
  },
  Task_56132_Desc = {
    Text = "깨어남체 스킬 700번 업그레이드"
  },
  Task_56132_Name = {
    Text = "「무공 숙련」Ⅴ"
  },
  Task_56133_Desc = {
    Text = "깨어남체 스킬 600번 업그레이드"
  },
  Task_56133_Name = {
    Text = "「무공 숙련」Ⅳ"
  },
  Task_56134_Desc = {
    Text = "깨어남체 스킬 500번 업그레이드"
  },
  Task_56134_Name = {
    Text = "「무공 숙련」Ⅲ"
  },
  Task_56135_Desc = {
    Text = "미스틱 트랜스크립트 완료 5000회"
  },
  Task_56135_Name = {
    Text = "다채로운 검정"
  },
  Task_56136_Desc = {
    Text = "2500회 미스틱 트랜스크립트 완료"
  },
  Task_56136_Name = {
    Text = "변덕스러운 마음"
  },
  Task_56137_Desc = {
    Text = "미스틱 트랜스크립트 1000회 완성"
  },
  Task_56137_Name = {
    Text = "초안으로 돌아가자!"
  },
  Task_56138_Desc = {
    Text = "깨어남체 스킬 900회 업그레이드"
  },
  Task_56138_Name = {
    Text = "「무공 숙련」Ⅶ"
  },
  Task_56140_Desc = {
    Text = "10000번 미스틱 트랜스크립트 완료"
  },
  Task_56140_Name = {
    Text = "데몬 가방"
  },
  Task_56156_Desc = {
    Text = "명륜중첩위치 800회"
  },
  Task_56156_Name = {
    Text = "양자 얽힘의 미래 Ⅱ"
  },
  Task_56157_Desc = {
    Text = "명륜중첩위치 900회"
  },
  Task_56157_Name = {
    Text = "양자 얽힘의 미래Ⅲ"
  },
  Task_56161_Desc = {
    Text = "오를라 동조율이 10에 도달했습니다"
  },
  Task_56162_Desc = {
    Text = "미리암의 동조율이 10단계에 도달했습니다"
  },
  Task_56177_Desc = {
    Text = "80종의 다른 명륜을 획득"
  },
  Task_56177_Name = {
    Text = "운명을 짜는 자"
  },
  Task_56178_Desc = {
    Text = "다른 명륜 70종을 획득"
  },
  Task_56178_Name = {
    Text = "무상의 지배자"
  },
  Task_56179_Desc = {
    Text = "업그레이드 깨어남체 스킬 300회"
  },
  Task_56179_Name = {
    Text = "「무공 숙련」Ⅰ"
  },
  Task_56180_Desc = {
    Text = "명륜중첩위치 1100회"
  },
  Task_56180_Name = {
    Text = "양자 얽힘의 미래Ⅴ"
  },
  Task_56181_Desc = {
    Text = "명륜중첩위치 1200회"
  },
  Task_56181_Name = {
    Text = "양자 얽힘의 미래Ⅵ"
  },
  Task_56182_Desc = {
    Text = "좋아요 1000회"
  },
  Task_56182_Name = {
    Text = "사회적 강도"
  },
  Task_56184_Desc = {
    Text = "좋아요 250회"
  },
  Task_56184_Name = {
    Text = "외부로의 큰 한 걸음"
  },
  Task_56185_Desc = {
    Text = "좋아요 500회"
  },
  Task_56185_Name = {
    Text = "세계로의 큰 발걸음"
  },
  Task_56186_Desc = {
    Text = "2000개의 명륜을 분해"
  },
  Task_56186_Name = {
    Text = "운명의 주인"
  },
  Task_56187_Desc = {
    Text = "1000개의 명륜을 분해"
  },
  Task_56187_Name = {
    Text = "운명의 목을 조르다"
  },
  Task_56188_Desc = {
    Text = "다른 명륜 60종을 획득"
  },
  Task_56188_Name = {
    Text = "운명의 제자 Ⅱ"
  },
  Task_56189_Desc = {
    Text = "다른 명륜 50종을 획득"
  },
  Task_56189_Name = {
    Text = "운명의 제자 Ⅰ"
  },
  Task_56191_Desc = {
    Text = "명륜중첩위치 1000회"
  },
  Task_56191_Name = {
    Text = "양자 얽힘의 미래 Ⅳ"
  },
  Task_56192_Desc = {
    Text = "명륜 500개 분해"
  },
  Task_56192_Name = {
    Text = "운명에 도전하다"
  },
  Task_56349_Desc = {
    Text = "격퇴 리더 「에이지스」"
  },
  Task_56349_Name = {Text = "목표"},
  Task_56350_Desc = {
    Text = "격퇴 보스 「다프다일」"
  },
  Task_56350_Name = {Text = "목표"},
  Task_56351_Desc = {
    Text = "격퇴 리더 「레이아」"
  },
  Task_56351_Name = {Text = "목표"},
  Task_56352_Desc = {
    Text = "격퇴 리더 「오를라를 향해」"
  },
  Task_56352_Name = {Text = "목표"},
  Task_56353_Desc = {
    Text = "격퇴 리더 「24」"
  },
  Task_56353_Name = {Text = "목표"},
  Task_56412_Desc = {
    Text = "클리어 「그의 강림」 임의의 난이도"
  },
  Task_56413_Desc = {
    Text = "클리어 「행형자」 임의의 난이도"
  },
  Task_56414_Desc = {
    Text = "다크 유터스·클리어"
  },
  Task_56415_Desc = {
    Text = "클리어 「포장천」 모든 난이도"
  },
  Task_56416_Desc = {
    Text = "다크 유터스·경계역"
  },
  Task_56417_Desc = {
    Text = "클리어 「잠복」 모든 난이도"
  },
  Task_56420_Desc = {
    Text = "클리어 「도살당한 어린양」 임의 난이도"
  },
  Task_56421_Desc = {
    Text = "클리어 「시공의 구멍」 모든 난이도"
  },
  Task_56422_Desc = {
    Text = "클리어 「노란 별」 아무 난이도"
  },
  Task_57121_Desc = {
    Text = "클리어 「도살당한 어린양」 광기의 난이도"
  },
  Task_57122_Desc = {
    Text = "클리어 「행형자」 광기 난이도"
  },
  Task_57123_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「다크 유터스」에서 2번 승리하기"
  },
  Task_57124_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「다크 유터스」에서 2번 승리하세요"
  },
  Task_57125_Desc = {
    Text = "클리어 「그의 강림」 광기 난이도"
  },
  Task_57126_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「다크 유터스」에서 1회 승리"
  },
  Task_57127_Desc = {
    Text = "클리어 「시공의 구멍」 광기 난이도"
  },
  Task_57128_Desc = {
    Text = "클리어 「노란 별」 광기의 난이도"
  },
  Task_57129_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「다크 유터스」에서 1회 승리"
  },
  Task_57130_Desc = {
    Text = "클리어 「잠복」 광기 난이도"
  },
  Task_57131_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해 「다크 유터스」에서 2회 승리"
  },
  Task_57132_Desc = {
    Text = "사용하여 혈육 경계역의 깨어남체로 「다크 유터스」에서 1회 승리"
  },
  Task_57133_Desc = {
    Text = "「다크 유터스·클리어」와 「다크 유터스·경계역」의 모든 태스크 완료"
  },
  Task_57134_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「다크 유터스」에서 2번 승리하기"
  },
  Task_57135_Desc = {
    Text = "클리어 「포장천」 광기의 난이도"
  },
  Task_57136_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「다크 유터스」에서 1회 승리"
  },
  Task_57137_Desc = {
    Text = "다크 유터스·광기"
  },
  Task_57369_Desc = {
    Text = "클리어 「나뭇가지를 물고」 아무 난이도에서"
  },
  Task_57370_Desc = {
    Text = "월야전설·광기"
  },
  Task_57371_Desc = {
    Text = "클리어 「미스터리 룸」 어떤 난이도든"
  },
  Task_57372_Desc = {
    Text = "월야전설·클리어"
  },
  Task_57373_Desc = {
    Text = "클리어 「나뭇가지를 물고」 광기 난이도"
  },
  Task_57374_Desc = {
    Text = "클리어 「무두체」 임의 난이도"
  },
  Task_57375_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해 「월야전설」에서 2회 승리"
  },
  Task_57376_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「월야전설」에서 2번 승리하세요"
  },
  Task_57377_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「월야전설」에서 한 번 승리하기"
  },
  Task_57378_Desc = {
    Text = "클리어 「불청객」 광기 난이도"
  },
  Task_57379_Desc = {
    Text = "클리어 **「무두체」** 광기 난이도"
  },
  Task_57380_Desc = {
    Text = "「월야전설·클리어」의 모든 태스크 완료"
  },
  Task_57381_Desc = {
    Text = "클리어 「미스터리 룸」 광기 난이도"
  },
  Task_57382_Desc = {
    Text = "초월계역 깨어남체를 사용하여 「월야전설」에서 1회 승리"
  },
  Task_57383_Desc = {
    Text = "초월계역 깨어남체를 사용하여 「월야전설」에서 2번 승리하라"
  },
  Task_57384_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「월야전설」에서 한 번 승리"
  },
  Task_57385_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「월야전설」에서 2번 승리하기"
  },
  Task_57386_Desc = {
    Text = "클리어 「행운의 평민」 아무 난이도"
  },
  Task_57387_Desc = {
    Text = "클리어 「부재 진술」 광기 난이도"
  },
  Task_57388_Desc = {
    Text = "클리어 「탐정의 친구」 어떤 난이도든"
  },
  Task_57389_Desc = {
    Text = "클리어 「불청객」 어떤 난이도든지"
  },
  Task_57390_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「월야전설」에서 1회 승리"
  },
  Task_57391_Desc = {
    Text = "월야전설·경계역"
  },
  Task_57392_Desc = {
    Text = "클리어 「탐정의 친구」 광기 난이도"
  },
  Task_57393_Desc = {
    Text = "클리어 「부재 진술」 어떤 난이도든"
  },
  Task_57394_Desc = {
    Text = "클리어 「행운의 평민」 광기 난이도"
  },
  Task_57404_Desc = {
    Text = "클리어 「후기」 임의의 난이도"
  },
  Task_57405_Desc = {
    Text = "클리어 「반전 술수」 임의 난이도"
  },
  Task_57406_Desc = {
    Text = "클리어 「후기」 광기 모드"
  },
  Task_57407_Desc = {
    Text = "클리어 「반전 술수」 광기 난이도"
  },
  Task_57409_Desc = {
    Text = "통관 특수 임무 기록 「사냥 즐겁게!」"
  },
  Task_57570_Desc = {
    Text = "클리어 「반전 술수」 임의 난이도"
  },
  Task_57571_Desc = {
    Text = "클리어 「탐정의 친구」 어떤 난이도든"
  },
  Task_57572_Desc = {
    Text = "클리어 「무두체」 임의 난이도"
  },
  Task_57573_Desc = {
    Text = "클리어 「도살당한 어린양」 임의 난이도"
  },
  Task_57574_Desc = {
    Text = "클리어 「부재 진술」 어떤 난이도든"
  },
  Task_57575_Desc = {
    Text = "클리어 「노란 별」 아무 난이도"
  },
  Task_57576_Desc = {
    Text = "클리어 「그의 강림」 임의의 난이도"
  },
  Task_57577_Desc = {
    Text = "클리어 「행형자」 임의의 난이도"
  },
  Task_57578_Desc = {
    Text = "클리어 「후기」 임의의 난이도"
  },
  Task_57579_Desc = {
    Text = "클리어 「포장천」 모든 난이도"
  },
  Task_57580_Desc = {
    Text = "클리어 「불청객」 어떤 난이도든지"
  },
  Task_57581_Desc = {
    Text = "클리어 「잠복」 모든 난이도"
  },
  Task_57582_Desc = {
    Text = "클리어 「시공의 구멍」 모든 난이도"
  },
  Task_57583_Desc = {
    Text = "클리어 「나뭇가지를 물고」 아무 난이도에서"
  },
  Task_57584_Desc = {
    Text = "클리어 「행운의 평민」 아무 난이도"
  },
  Task_57585_Desc = {
    Text = "클리어 「미스터리 룸」 어떤 난이도든"
  },
  Task_58104_Desc = {
    Text = "클리어 「후회」 어떤 난이도로든"
  },
  Task_58107_Desc = {
    Text = "클리어 「비난」 임의 난이도"
  },
  Task_58109_Desc = {
    Text = "클리어 「집착」 광기 난이도"
  },
  Task_58110_Desc = {
    Text = "클리어 「쟁취」 임의의 난이도"
  },
  Task_58111_Desc = {
    Text = "클리어 「쟁취」 임의의 난이도"
  },
  Task_58112_Desc = {
    Text = "클리어 「후회」 어떤 난이도로든"
  },
  Task_58113_Desc = {
    Text = "클리어 「착취」 아무 난이도"
  },
  Task_58114_Desc = {
    Text = "클리어 「후회」 광기 모드"
  },
  Task_58115_Desc = {
    Text = "클리어 「수취」 임의의 난이도"
  },
  Task_58118_Desc = {
    Text = "클리어 「비난」 광기 난이도"
  },
  Task_58119_Desc = {
    Text = "클리어 「수취」 광기 난이도"
  },
  Task_58120_Desc = {
    Text = "완료 「성당의 길」 모든 난이도의 모든 스테이지"
  },
  Task_58122_Desc = {
    Text = "클리어 「비난」 임의 난이도"
  },
  Task_58123_Desc = {
    Text = "성당 자선 판매 현장"
  },
  Task_58124_Desc = {
    Text = "클리어 「착취」 아무 난이도"
  },
  Task_58126_Desc = {
    Text = "클리어 「수취」 임의의 난이도"
  },
  Task_58128_Desc = {
    Text = "성당의 길·광기"
  },
  Task_58130_Desc = {
    Text = "성당의 길·성장"
  },
  Task_58131_Desc = {
    Text = "클리어 「쟁취」 광기 난이도"
  },
  Task_58132_Desc = {
    Text = "「큰 존의 신비한 자선 판매」에서 100회 구매"
  },
  Task_58133_Desc = {
    Text = "「대존의 신비한 자선 판매」에서 200회 구매"
  },
  Task_58134_Desc = {
    Text = "「그레이 부인의 작은 상점」에서 100번 구매"
  },
  Task_58135_Desc = {
    Text = "「그레이 부인의 작은 상점」에서 200번 구매"
  },
  Task_58136_Desc = {
    Text = "「스미스 특매」에서 200회 구매"
  },
  Task_58137_Desc = {
    Text = "「스미스 특매」에서 100번 구매"
  },
  Task_58138_Desc = {
    Text = "조사 이벤트 「{s1}」 완료"
  },
  Task_58500_Desc = {
    Text = "홍명의 소리·클리어"
  },
  Task_58501_Desc = {
    Text = "클리어 「관현편성」 광기 난이도"
  },
  Task_58502_Desc = {
    Text = "클리어 「서곡」 임의 난이도"
  },
  Task_58503_Desc = {
    Text = "클리어 「소보무곡」 임의의 난이도"
  },
  Task_58504_Desc = {
    Text = "클리어 「여운」 아무 난이도"
  },
  Task_58505_Desc = {
    Text = "클리어 「종곡」 임의의 난이도"
  },
  Task_58506_Desc = {
    Text = "클리어 「느린 템포」 임의 난이도"
  },
  Task_58507_Desc = {
    Text = "클리어 「빠른 판자」 광기 난이도"
  },
  Task_58508_Desc = {
    Text = "클리어 「소보무곡」 광기 난이도다"
  },
  Task_58509_Desc = {
    Text = "클리어 「여운」 아무 난이도"
  },
  Task_58510_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「홍명의 소리」에서 1회 승리"
  },
  Task_58511_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「홍명의 소리」에서 2번 승리하십시오"
  },
  Task_58512_Desc = {
    Text = "클리어 「미로의 꿈길」 임의 난이도"
  },
  Task_58513_Desc = {
    Text = "홍명의 소리·경계역"
  },
  Task_58514_Desc = {
    Text = "클리어 「여운」 난이도 광기"
  },
  Task_58515_Desc = {
    Text = "클리어 「소보무곡」 임의의 난이도"
  },
  Task_58516_Desc = {
    Text = "홍명의 소리·광기"
  },
  Task_58517_Desc = {
    Text = "클리어 「빠른 판자」 임의 난이도"
  },
  Task_58518_Desc = {
    Text = "클리어 「서곡」 광기 난이도"
  },
  Task_58519_Desc = {
    Text = "클리어 「관현편성」 아무 난이도"
  },
  Task_58520_Desc = {
    Text = "클리어 「느린 템포」 광기 난이도"
  },
  Task_58521_Desc = {
    Text = "클리어 「느린 템포」 임의 난이도"
  },
  Task_58522_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「홍명의 소리」에서 2번 승리하기"
  },
  Task_58523_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「홍명의 소리」에서 1번 승리하기."
  },
  Task_58524_Desc = {
    Text = "클리어 「막 내리기」 아무 난이도"
  },
  Task_58525_Desc = {
    Text = "클리어 「종곡」 광기 난이도"
  },
  Task_58526_Desc = {
    Text = "클리어 「미로의 꿈길」 광기"
  },
  Task_58527_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「홍명의 소리」에서 2번 승리하기"
  },
  Task_58528_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「홍명의 소리」에서 승리"
  },
  Task_58529_Desc = {
    Text = "클리어 「빠른 판자」 임의 난이도"
  },
  Task_58530_Desc = {
    Text = "「홍명의 소리·클리어」 모든 태스크 완료"
  },
  Task_58531_Desc = {
    Text = "클리어 「서곡」 임의 난이도"
  },
  Task_58532_Desc = {
    Text = "클리어 「막 내리기」 아무 난이도"
  },
  Task_58533_Desc = {
    Text = "클리어 「관현편성」 아무 난이도"
  },
  Task_58534_Desc = {
    Text = "클리어 「미로의 꿈길」 임의 난이도"
  },
  Task_58535_Desc = {
    Text = "클리어 「종곡」 임의의 난이도"
  },
  Task_58536_Desc = {
    Text = "클리어 「막 내리기」 광기 난이도"
  },
  Task_58537_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「홍명의 소리」에서 1번 승리"
  },
  Task_58538_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「홍명의 소리」에서 2번 승리하세요"
  },
  Task_58989_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58989_Name = {
    Text = "속전속결"
  },
  Task_58990_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58990_Name = {
    Text = "속전속결"
  },
  Task_58991_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_58991_Name = {Text = "드로우!"},
  Task_58992_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_58992_Name = {
    Text = "에너지 절약"
  },
  Task_58993_Desc = {
    Text = "서로 다른 각인 4종류 이상 획득"
  },
  Task_58993_Name = {
    Text = "영혼의 낙인"
  },
  Task_58994_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58994_Name = {
    Text = "속전속결"
  },
  Task_58995_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58995_Name = {
    Text = "속전속결"
  },
  Task_58996_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58996_Name = {
    Text = "속전속결"
  },
  Task_58997_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58997_Name = {
    Text = "속전속결"
  },
  Task_58998_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58998_Name = {
    Text = "속전속결"
  },
  Task_58999_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_58999_Name = {
    Text = "속전속결"
  },
  Task_59000_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_59000_Name = {
    Text = "속전속결"
  },
  Task_59001_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59001_Name = {
    Text = "완벽한 통과"
  },
  Task_59002_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_59002_Name = {
    Text = "에너지 절약"
  },
  Task_59003_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_59003_Name = {
    Text = "에너지 절약"
  },
  Task_59004_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59004_Name = {
    Text = "완벽한 통과"
  },
  Task_59005_Desc = {
    Text = "클리어 시 8개 이상의 유물 보유"
  },
  Task_59005_Name = {
    Text = "기병의 보물창고"
  },
  Task_59006_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59006_Name = {
    Text = "완벽한 통과"
  },
  Task_59007_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_59007_Name = {
    Text = "기병의 보물창고"
  },
  Task_59008_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59008_Name = {
    Text = "완벽한 통과"
  },
  Task_59009_Desc = {
    Text = "최종전에서 1턴 동안 6장 이상의 카드 사용"
  },
  Task_59009_Name = {
    Text = "내 차례야!이야"
  },
  Task_59010_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 65%만큼의 방어막을 획득"
  },
  Task_59010_Name = {
    Text = "강철의 몸"
  },
  Task_59011_Desc = {
    Text = "최종전에서 1턴 동안 6장 이상의 카드 사용"
  },
  Task_59011_Name = {
    Text = "내 차례야!이야"
  },
  Task_59012_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 65%만큼의 방어막을 획득"
  },
  Task_59012_Name = {
    Text = "강철의 몸"
  },
  Task_59013_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_59013_Name = {Text = "드로우!"},
  Task_59014_Desc = {
    Text = "최종전에서 1턴 동안 최소 20000의 피해 입히기"
  },
  Task_59014_Name = {
    Text = "전력의 일격"
  },
  Task_59015_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_59015_Name = {
    Text = "우아하고 정확한"
  },
  Task_59016_Desc = {
    Text = "4종류 이상의 서로 다른 각인을 획득"
  },
  Task_59016_Name = {
    Text = "영혼의 낙인"
  },
  Task_59017_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_59017_Name = {
    Text = "우아하고 정확하게"
  },
  Task_59018_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_59018_Name = {
    Text = "기병의 보물창고"
  },
  Task_59019_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_59019_Name = {
    Text = "무한의 포옹"
  },
  Task_59020_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_59020_Name = {
    Text = "기병의 보물창고"
  },
  Task_59021_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_59021_Name = {
    Text = "기병의 보물창고"
  },
  Task_59022_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_59022_Name = {
    Text = "에너지 절약"
  },
  Task_59023_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 뽑기"
  },
  Task_59023_Name = {Text = "드로우!"},
  Task_59024_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59024_Name = {
    Text = "완벽한 통과"
  },
  Task_59025_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59025_Name = {
    Text = "완벽한 통과"
  },
  Task_59026_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59026_Name = {
    Text = "완벽한 통과"
  },
  Task_59027_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59027_Name = {
    Text = "완벽한 통과"
  },
  Task_59028_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59028_Name = {
    Text = "완벽한 통과"
  },
  Task_59029_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59029_Name = {
    Text = "완벽한 통과"
  },
  Task_59030_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59030_Name = {
    Text = "완벽한 통과"
  },
  Task_59031_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59031_Name = {
    Text = "완벽한 통과"
  },
  Task_59032_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_59032_Name = {
    Text = "완벽한 통과"
  },
  Task_59033_Desc = {
    Text = "모든 깨어남체가 깨어남된 상태로 클리어"
  },
  Task_59033_Name = {
    Text = "무한의 포옹"
  },
  Task_59034_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_59034_Name = {
    Text = "기병의 보물창고"
  },
  Task_59035_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_59035_Name = {
    Text = "속전속결"
  },
  Task_59036_Desc = {
    Text = "1개 이상의 저주받은 유물을 소지한 상태로 클리어"
  },
  Task_59036_Name = {
    Text = "기병의 보물창고"
  },
  Task_59037_Desc = {
    Text = "최종전에서 18턴 이내에 승리"
  },
  Task_59037_Name = {
    Text = "속전속결"
  },
  Task_59038_Desc = {
    Text = "최종전에서 12턴 이내에 승리"
  },
  Task_59038_Name = {
    Text = "속전속결"
  },
  Task_59039_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 60%의 방어막 획득"
  },
  Task_59039_Name = {
    Text = "강철의 몸"
  },
  Task_59040_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_59040_Name = {
    Text = "내 차례야!이야"
  },
  Task_59041_Desc = {
    Text = "최종전에서 1턴 동안 최대 HP 60%의 방어막 획득"
  },
  Task_59041_Name = {
    Text = "강철의 몸"
  },
  Task_59042_Desc = {
    Text = "클리어 시 증상 카드 3장 이하"
  },
  Task_59042_Name = {
    Text = "에너지 절약"
  },
  Task_59043_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_59043_Name = {
    Text = "우아하고 정확하게"
  },
  Task_59044_Desc = {
    Text = "최종전에서 18턴 이내에 승리"
  },
  Task_59044_Name = {
    Text = "속전속결"
  },
  Task_59045_Desc = {
    Text = "최종전에서 1턴 동안 4장 이상의 카드 뽑기"
  },
  Task_59045_Name = {Text = "드로우!"},
  Task_59046_Desc = {
    Text = "클리어 시 8개 이상의 유물 보유"
  },
  Task_59046_Name = {
    Text = "기병의 보물창고"
  },
  Task_59047_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_59047_Name = {
    Text = "내 차례야!이야"
  },
  Task_59048_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_59048_Name = {
    Text = "우아하고 정확한"
  },
  Task_59438_Desc = {
    Text = "레이크 동조율이 10단계에 도달했습니다"
  },
  Task_60163_Desc = {
    Text = "스테이지 클리어"
  },
  Task_60163_Name = {
    Text = "스테이지 클리어"
  },
  Task_60163_UnlockCondDesc = {
    Text = "8-9 스테이지 클리어 후 해금"
  },
  Task_60164_Desc = {
    Text = "스테이지 클리어"
  },
  Task_60164_Name = {
    Text = "스테이지 클리어"
  },
  Task_60164_UnlockCondDesc = {
    Text = "8-11 스테이지 클리어 후 해금"
  },
  Task_60165_Desc = {
    Text = "스테이지 클리어"
  },
  Task_60165_Name = {
    Text = "스테이지 클리어"
  },
  Task_60165_UnlockCondDesc = {
    Text = "8-10 단계 클리어 후 해금"
  },
  Task_60443_Desc = {
    Text = "조사 메인 스토리 제4장 「무성한 곳에서」 완료"
  },
  Task_60444_Desc = {
    Text = "특훈 값이 처음으로 150에 도달했습니다"
  },
  Task_60445_Desc = {
    Text = "특훈 값이 처음으로 325에 도달했습니다"
  },
  Task_60446_Desc = {
    Text = "특훈 값이 처음으로 50 도달"
  },
  Task_60447_Desc = {
    Text = "특훈 값이 처음으로 100 도달"
  },
  Task_60448_Desc = {
    Text = "조사 메인 스토리 제4장 「무성한 곳에서」 어려움 난이도 완료"
  },
  Task_60449_Desc = {
    Text = "특훈 값이 처음으로 300에 도달했습니다"
  },
  Task_60450_Desc = {
    Text = "조사 메인 스토리 제2장 「밀랍인형의 이름으로」 완료"
  },
  Task_60451_Desc = {
    Text = "조사 메인 스토리 제5장 「폭풍의 눈」 어려움 난이도 완료"
  },
  Task_60452_Desc = {
    Text = "특훈 값이 처음으로 225에 도달했습니다"
  },
  Task_60453_Desc = {
    Text = "조사 메인 스토리 제1장 「동부 지구의 비밀」 완료"
  },
  Task_60454_Desc = {
    Text = "조사 메인 스토리 제6장 「일그러진 별들」 어려움 난이도 완료"
  },
  Task_60455_Desc = {
    Text = "조사 메인 스토리 제2장 「밀랍인형의 이름으로」 어려움 난이도 완료"
  },
  Task_60456_Desc = {
    Text = "조사 메인 스토리 제5장 「폭풍의 눈」 완료"
  },
  Task_60457_Desc = {
    Text = "조사 메인 스토리 제3장 「맹견 주의」 어려움 난이도 완료"
  },
  Task_60458_Desc = {
    Text = "조사 메인 스토리 제1장 「동부 지구의 비밀」 어려움 난이도 완료"
  },
  Task_60459_Desc = {
    Text = "조사 메인 스토리 제3장 「맹견 주의」 완료"
  },
  Task_60460_Desc = {
    Text = "조사 메인 스토리 제6장 「일그러진 별들」 완료"
  },
  Task_60461_Desc = {
    Text = "특훈 값이 처음으로 350에 도달했습니다"
  },
  Task_60601_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60602_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60603_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60604_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60606_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60607_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60608_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60609_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60610_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60611_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60612_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60613_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60614_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60615_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60616_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60617_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60618_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60619_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60620_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60622_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60623_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60624_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60625_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60626_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60627_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60628_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60629_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60630_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60631_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60633_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60634_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60635_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60636_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60637_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60638_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60639_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60640_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60641_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60642_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60643_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60644_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60645_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60646_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60647_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60648_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60649_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60650_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60651_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60653_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60654_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60655_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60656_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60657_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60658_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60659_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60660_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60661_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60663_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60664_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60665_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60666_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60667_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60668_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60669_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60670_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60671_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60672_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60673_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60674_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60675_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60676_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60677_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60678_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60680_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60681_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60682_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60683_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60684_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60685_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60686_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60687_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60688_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60689_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60690_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60691_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60692_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60694_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60696_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60697_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60699_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60742_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60743_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60747_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60748_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60749_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60750_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60751_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60752_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60754_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60755_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60757_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60758_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60759_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60760_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60761_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60763_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60765_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60766_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60768_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60769_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60770_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60772_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60773_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60774_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60777_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60778_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60779_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60780_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60781_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60782_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60783_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60784_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60785_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60787_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60788_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60789_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60790_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60793_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60795_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60796_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60797_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60798_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60799_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60800_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60801_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60803_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60804_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60805_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_60829_Desc = {
    Text = "함린 동조율이 10단계에 도달했습니다"
  },
  Task_61103_Desc = {
    Text = "본원 돌 획득"
  },
  Task_61103_Name = {
    Text = "본원 돌 획득"
  },
  Task_61104_Desc = {
    Text = "본원 힐로 획득"
  },
  Task_61104_Name = {
    Text = "본원 힐로 획득"
  },
  Task_61105_Desc = {
    Text = "리리 획득"
  },
  Task_61105_Name = {
    Text = "리리 획득"
  },
  Task_61106_Desc = {
    Text = "획득 오를라"
  },
  Task_61106_Name = {
    Text = "획득 오를라"
  },
  Task_61107_Desc = {
    Text = "미리암 획득"
  },
  Task_61107_Name = {
    Text = "미리암 획득"
  },
  Task_61108_Desc = {
    Text = "레크 획득"
  },
  Task_61108_Name = {
    Text = "레크 획득"
  },
  Task_61109_Desc = {
    Text = "소렐 획득"
  },
  Task_61109_Name = {
    Text = "소렐 획득"
  },
  Task_61110_Desc = {
    Text = "살바도르 획득"
  },
  Task_61110_Name = {
    Text = "살바도르 획득"
  },
  Task_61111_Desc = {
    Text = "와ン다 획득"
  },
  Task_61111_Name = {
    Text = "와ン다 획득"
  },
  Task_61112_Desc = {
    Text = "도루 획득"
  },
  Task_61112_Name = {
    Text = "도루 획득"
  },
  Task_61113_Desc = {
    Text = "획득「24」"
  },
  Task_61113_Name = {
    Text = "획득「24」"
  },
  Task_61114_Desc = {
    Text = "타비 얻기"
  },
  Task_61114_Name = {
    Text = "타비 얻기"
  },
  Task_61115_Desc = {
    Text = "테이스 획득"
  },
  Task_61115_Name = {
    Text = "테이스 획득"
  },
  Task_61116_Desc = {
    Text = "함린 획득"
  },
  Task_61116_Name = {
    Text = "함린 획득"
  },
  Task_61117_Desc = {
    Text = "다프다일 획득"
  },
  Task_61117_Name = {
    Text = "다프다일 획득"
  },
  Task_61118_Desc = {
    Text = "잉크피 얻기"
  },
  Task_61118_Name = {
    Text = "잉크피 얻기"
  },
  Task_61157_Desc = {
    Text = "조사 메인 스토리 제8장 「종말의 교향곡」 어려움 난이도 완료"
  },
  Task_61158_Desc = {
    Text = "조사 메인 스토리 제7장 「욕망의 강」 완료"
  },
  Task_61159_Desc = {
    Text = "조사 메인 스토리 제7장 「욕망의 강」 어려움 난이도 완료"
  },
  Task_61160_Desc = {
    Text = "조사 메인 스토리 제8장 「종말의 교향곡」 어려움 난이도 완료"
  },
  Task_61161_Desc = {
    Text = "조사 메인 스토리 제8장 「종말의 교향곡」 완료"
  },
  Task_61162_Desc = {
    Text = "조사 메인 스토리 제7장 「욕망의 강」 어려움 난이도 완료"
  },
  Task_61163_Desc = {
    Text = "조사 메인 스토리 제7장 「욕망의 강」 완료"
  },
  Task_61164_Desc = {
    Text = "조사 메인 스토리 제8장 「종말의 교향곡」 완료"
  },
  Task_61186_Desc = {
    Text = "클리어 「한단 기억」 임의 난이도"
  },
  Task_61187_Desc = {
    Text = "클리어 「황금 도시」 임의 난이도"
  },
  Task_61188_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해 「호수 속의 도시」에서 1회 승리"
  },
  Task_61189_Desc = {
    Text = "「호수 속의 도시·클리어」의 모든 태스크 완료"
  },
  Task_61190_Desc = {
    Text = "클리어 「계시록」 모든 난이도"
  },
  Task_61191_Desc = {
    Text = "클리어 「진실타래」 광기 난이도"
  },
  Task_61192_Desc = {
    Text = "클리어 「황금 도시」 광기의 난이도"
  },
  Task_61193_Desc = {
    Text = "클리어 「미라지」 임의의 난이도"
  },
  Task_61194_Desc = {
    Text = "호수 속의 도시·클리어"
  },
  Task_61195_Desc = {
    Text = "클리어 「진실타래」 어떤 난이도든"
  },
  Task_61196_Desc = {
    Text = "클리어 「소광란」 아무 난이도"
  },
  Task_61197_Desc = {
    Text = "클리어 「미라지」 임의의 난이도"
  },
  Task_61198_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「호수 속의 도시」에서 1 회 승리"
  },
  Task_61199_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「호수 속의 도시」에서 1회 승리"
  },
  Task_61200_Desc = {
    Text = "클리어 「미라지」 광기 난이도."
  },
  Task_61201_Desc = {
    Text = "호수 속의 도시·경계역"
  },
  Task_61202_Desc = {
    Text = "클리어 「황금 도시」 임의 난이도"
  },
  Task_61203_Desc = {
    Text = "클리어 「계시록」 모든 난이도"
  },
  Task_61204_Desc = {
    Text = "클리어 「정」 임의 난이도"
  },
  Task_61205_Desc = {
    Text = "클리어 「한단 기억」 임의 난이도"
  },
  Task_61206_Desc = {
    Text = "Use the Awakening Body of the Blood Flesh Boundary Realm to win once in 「The City in the Lake」."
  },
  Task_61207_Desc = {
    Text = "클리어 「소광란」 광기 난이도"
  },
  Task_61208_Desc = {
    Text = "클리어 계시록 광기 난이도"
  },
  Task_61209_Desc = {
    Text = "클리어 「정」 임의 난이도"
  },
  Task_61210_Desc = {
    Text = "클리어 「소광란」 아무 난이도"
  },
  Task_61211_Desc = {
    Text = "호수 속의 도시·광기"
  },
  Task_61212_Desc = {
    Text = "클리어 「진실타래」 어떤 난이도든"
  },
  Task_61213_Desc = {
    Text = "클리어 「한단 기억」 광기 난이도"
  },
  Task_61214_Desc = {
    Text = "클리어 「정」 광기 난이도"
  },
  Task_61215_Desc = {
    Text = "의식 잠수 클리어 「타오르는 군연」"
  },
  Task_61375_Desc = {
    Text = "누적 로그인 12일"
  },
  Task_61376_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_61377_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_61378_Desc = {
    Text = "누적 로그인 11일"
  },
  Task_61379_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_61380_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_61381_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_61382_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_61383_Desc = {
    Text = "누적 로그인 14일"
  },
  Task_61384_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_61385_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_61386_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_61387_Desc = {
    Text = "누적 로그인 13일"
  },
  Task_61388_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_61389_Desc = {
    Text = "누적 로그인 16일"
  },
  Task_61390_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_61394_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61395_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61396_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61397_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61398_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61399_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61400_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61401_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61402_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61403_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61404_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61405_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61407_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61408_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61409_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61410_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61411_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61412_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61413_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61414_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61415_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61416_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61417_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61418_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61419_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61420_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61421_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61422_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61425_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61426_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61427_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61428_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61430_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61431_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61432_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61433_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61434_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61435_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61436_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61438_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61439_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61440_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61441_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61442_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61443_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61444_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61445_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61446_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61447_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61448_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61449_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61450_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61451_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61452_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61453_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61455_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61456_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61457_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61458_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61459_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61460_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61461_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61462_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61463_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61464_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61465_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61466_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61468_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61469_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61470_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61471_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61472_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61473_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61474_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61475_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61476_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61477_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61478_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61479_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61481_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61519_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61520_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61521_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61522_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61523_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61524_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61525_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61526_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61527_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61528_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61616_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61617_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61620_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61621_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61622_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61623_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61626_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61627_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61628_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61629_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61631_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61633_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61634_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61636_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61637_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61639_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61640_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61642_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61643_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61644_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61645_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61648_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61649_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61650_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61652_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61653_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61654_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61655_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61657_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61659_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61660_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61661_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61662_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61665_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61666_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61668_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61669_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61671_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61672_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61673_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61675_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61676_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61678_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61679_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61681_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61682_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61684_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61685_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61687_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61688_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61690_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61691_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61693_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61694_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61696_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61697_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61699_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61700_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61701_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61702_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61704_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61705_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61706_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61707_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61709_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61710_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61712_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61713_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61716_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61717_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61719_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61720_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61722_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61723_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61725_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61726_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61727_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61729_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61731_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61733_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61734_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61735_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61736_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61739_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61740_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61743_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61744_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61748_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61749_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61750_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61751_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61753_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61754_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61756_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61757_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61758_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61759_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61762_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61763_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61765_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61766_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61767_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61769_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61770_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61771_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61772_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61774_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61777_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61778_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61781_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61782_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61783_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61784_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61785_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61788_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61789_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61791_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61792_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61794_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61795_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61796_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61797_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61798_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61801_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61802_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61804_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61805_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61807_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61808_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61810_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61811_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61814_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61815_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61816_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61817_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61819_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61820_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61821_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61824_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_61825_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_62002_Desc = {
    Text = "클리어 「산을 보다」 광기 난이도"
  },
  Task_62003_Desc = {
    Text = "클리어 「파토」 임의 난이도"
  },
  Task_62004_Desc = {
    Text = "야수의 야망·경계역"
  },
  Task_62005_Desc = {
    Text = "클리어 「한겨울」 어떤 난이도로든"
  },
  Task_62006_Desc = {
    Text = "「욕망의 식욕」에서 꽃눈을 교환하여 200회 보상을 획득"
  },
  Task_62007_Desc = {
    Text = "「먹는 야심」 교환으로 꽃봉오리 100회 획득"
  },
  Task_62008_Desc = {
    Text = "클리어 「한겨울」 광기 난이도"
  },
  Task_62009_Desc = {
    Text = "클리어 「한겨울」 어떤 난이도로든"
  },
  Task_62010_Desc = {
    Text = "클리어 「산을 보다」 임의 난이도"
  },
  Task_62011_Desc = {
    Text = "클리어 「격투장」 임의의 난이도"
  },
  Task_62012_Desc = {
    Text = "클리어 「산을 보다」 임의 난이도"
  },
  Task_62013_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「야수의 야망」에서 1회 승리."
  },
  Task_62014_Desc = {
    Text = "산맥의 거대한 입"
  },
  Task_62015_Desc = {
    Text = "클리어 「파토」 광기 모드"
  },
  Task_62016_Desc = {
    Text = "야수의 야망·광기"
  },
  Task_62017_Desc = {
    Text = "클리어 「귀환」 광기 난이도"
  },
  Task_62018_Desc = {
    Text = "야수의 야망·클리어"
  },
  Task_62019_Desc = {
    Text = "심해 영역 깨어남체를 이용해 「야수의 야망」에서 1회 승리"
  },
  Task_62020_Desc = {
    Text = "「재생의 희망」에서 꽃봉오리를 교환하여 100회 피드백을 획득"
  },
  Task_62021_Desc = {
    Text = "「복수의 전의」 꽃봉오리 교환으로 200회 보상 획득"
  },
  Task_62022_Desc = {
    Text = "「복수의 전의」에서 꽃봉오리 교환으로 100회 보상 획득"
  },
  Task_62023_Desc = {
    Text = "「야수의 야망·클리어」의 모든 미션 완료"
  },
  Task_62024_Desc = {
    Text = "혼돈 영역 깨어남체를 이용해 「야수의 야망」에서 1회 승리"
  },
  Task_62025_Desc = {
    Text = "「재생의 희망」에서 꽃봉오리를 교환하여 200회 보상 획득"
  },
  Task_62026_Desc = {
    Text = "클리어 「귀환」 모든 난이도"
  },
  Task_62027_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「야수의 야망」에서 한 번 승리"
  },
  Task_62028_Desc = {
    Text = "클리어 「격투장」 임의의 난이도"
  },
  Task_62029_Desc = {
    Text = "클리어 「격투장」 광기 난이도"
  },
  Task_62030_Desc = {
    Text = "클리어 「귀환」 모든 난이도"
  },
  Task_62031_Desc = {
    Text = "클리어 「파토」 임의 난이도"
  },
  Task_62092_Desc = {
    Text = "통관 특수 임무 기록 「엘워스의 귀인」"
  },
  Task_62207_Desc = {
    Text = "혈연·시로 동조율이 10 단계에 도달"
  },
  Task_62209_Desc = {
    Text = "눈 산에서 탈출하기"
  },
  Task_62209_Name = {Text = "목표"},
  Task_62231_Desc = {
    Text = "레크 획득 시 기령 6"
  },
  Task_62231_Name = {
    Text = "레크 획득 시 기령 6"
  },
  Task_62231_UnlockCondDesc = {
    Text = "이벤트@깨어남체 레이크 기령 패키지 1"
  },
  Task_62232_Desc = {
    Text = "전금 젠킨을 획득할 때 기령 2"
  },
  Task_62232_Name = {
    Text = "전금 젠킨을 획득할 때 기령 2"
  },
  Task_62232_UnlockCondDesc = {
    Text = "활동@깨어남체 젠킨 기령 선물 패키지 0"
  },
  Task_62233_Desc = {
    Text = "전금 젠킨을 획득하면 기령 6"
  },
  Task_62233_Name = {
    Text = "전금 젠킨을 획득하면 기령 6"
  },
  Task_62233_UnlockCondDesc = {
    Text = "이벤트@젠킨 깨어남체 기령 패키지 2 이벤트"
  },
  Task_62234_Desc = {
    Text = "함린을 획득할 때 기령 2 활성화"
  },
  Task_62234_Name = {
    Text = "함린을 획득할 때 기령 2 활성화"
  },
  Task_62234_UnlockCondDesc = {
    Text = "이벤트@깨어남체 함린 기령 선물 패키지 0"
  },
  Task_62235_Desc = {
    Text = "완다 획득 시 기령 2"
  },
  Task_62235_Name = {
    Text = "완다 획득 시 기령 2"
  },
  Task_62235_UnlockCondDesc = {
    Text = "이벤트@깨어남체 완다 기령 선물 패키지 0"
  },
  Task_62236_Desc = {
    Text = "닝피아 획득 시 기령 6"
  },
  Task_62236_Name = {
    Text = "닝피아 획득 시 기령 6"
  },
  Task_62236_UnlockCondDesc = {
    Text = "이벤트@깨어남체 닝피아 기령 패키지 2 이벤트"
  },
  Task_62237_Desc = {
    Text = "오를라를 획득할 때 기령이 2만큼 활성화됩니다"
  },
  Task_62237_Name = {
    Text = "오를라를 획득할 때 기령이 2만큼 활성화됩니다"
  },
  Task_62237_UnlockCondDesc = {
    Text = "이벤트@깨어남체 오를라 기령 선물 패키지 0"
  },
  Task_62238_Desc = {
    Text = "와ン다 획득 시 기령 6"
  },
  Task_62238_Name = {
    Text = "와ン다 획득 시 기령 6"
  },
  Task_62238_UnlockCondDesc = {
    Text = "이벤트@깨어남체 완다 기령 패키지 1"
  },
  Task_62239_Desc = {
    Text = "카시아를 획득할 때 기령 2"
  },
  Task_62239_Name = {
    Text = "카시아를 획득할 때 기령 2"
  },
  Task_62239_UnlockCondDesc = {
    Text = "이벤트@깨어남체 카시아 기령 패키지 0"
  },
  Task_62240_Desc = {
    Text = "팔로스를 획득할 때 기령 2"
  },
  Task_62240_Name = {
    Text = "팔로스를 획득할 때 기령 2"
  },
  Task_62240_UnlockCondDesc = {
    Text = "이벤트@깨어남체 팔로스 기령 패키지 1 이벤트"
  },
  Task_62241_Desc = {
    Text = "함린 획득 시 기령 6"
  },
  Task_62241_Name = {
    Text = "함린 획득 시 기령 6"
  },
  Task_62241_UnlockCondDesc = {
    Text = "이벤트@깨어남체 함린 기령 패키지 2 이벤트"
  },
  Task_62242_Desc = {
    Text = "틴커트를 얻을 때 기령 6"
  },
  Task_62242_Name = {
    Text = "틴커트를 얻을 때 기령 6"
  },
  Task_62242_UnlockCondDesc = {
    Text = "이벤트@깨어남체 틴커트 기령 패키지 1"
  },
  Task_62243_Desc = {
    Text = "고리아를 획득할 때 기령이 6으로 활성화됩니다"
  },
  Task_62243_Name = {
    Text = "고리아를 획득할 때 기령이 6으로 활성화됩니다"
  },
  Task_62243_UnlockCondDesc = {
    Text = "이벤트@고리아 기령 패키지 2 이벤트"
  },
  Task_62244_Desc = {
    Text = "틴커트를 얻을 때 기령 2"
  },
  Task_62244_Name = {
    Text = "틴커트를 얻을 때 기령 2"
  },
  Task_62244_UnlockCondDesc = {
    Text = "이벤트@깨어남체 틴커트 기령 패키지 1 이벤트"
  },
  Task_62245_Desc = {
    Text = "레이아 획득 시 기령 6"
  },
  Task_62245_Name = {
    Text = "레이아 획득 시 기령 6"
  },
  Task_62245_UnlockCondDesc = {
    Text = "이벤트@레이아의 깨어남체 기령 패키지 2 이벤트"
  },
  Task_62246_Desc = {
    Text = "도루 획득 시 기령 6"
  },
  Task_62246_Name = {
    Text = "도루 획득 시 기령 6"
  },
  Task_62246_UnlockCondDesc = {
    Text = "이벤트@깨어남체 툴루 기령 패키지 2 이벤트"
  },
  Task_62247_Desc = {
    Text = "유우하시 획득 시 기령 2"
  },
  Task_62247_Name = {
    Text = "유우하시 획득 시 기령 2"
  },
  Task_62247_UnlockCondDesc = {
    Text = "활동@깨어남체 유우하시 기령 이벤트 0"
  },
  Task_62248_Desc = {
    Text = "도루 획득 시 기령 2"
  },
  Task_62248_Name = {
    Text = "도루 획득 시 기령 2"
  },
  Task_62248_UnlockCondDesc = {
    Text = "이벤트@깨어남체 툴루 기령 선물 패키지 0"
  },
  Task_62249_Desc = {
    Text = "리리 획득 시 기령 6"
  },
  Task_62249_Name = {
    Text = "리리 획득 시 기령 6"
  },
  Task_62249_UnlockCondDesc = {
    Text = "이벤트@깨어남체 리리 기령 패키지 2 이벤트"
  },
  Task_62250_Desc = {
    Text = "파인트 획득 시 기령 2"
  },
  Task_62250_Name = {
    Text = "파인트 획득 시 기령 2"
  },
  Task_62250_UnlockCondDesc = {
    Text = "활동@깨어남체 파인트 기령 패키지 1 활동"
  },
  Task_62251_Desc = {
    Text = "다프다일을 획득할 때 기령 6"
  },
  Task_62251_Name = {
    Text = "다프다일을 획득할 때 기령 6"
  },
  Task_62251_UnlockCondDesc = {
    Text = "이벤트@깨어남체 다프다일 기령 패키지 1"
  },
  Task_62252_Desc = {
    Text = "아그리파를 획득할 때 기령 6 개방"
  },
  Task_62252_Name = {
    Text = "아그리파를 획득할 때 기령 6 개방"
  },
  Task_62252_UnlockCondDesc = {
    Text = "이벤트@깨어남체 아그리파 기령 패키지 1"
  },
  Task_62253_Desc = {
    Text = "판디아를 얻을 때 기령 2 획득"
  },
  Task_62253_Name = {
    Text = "판디아를 얻을 때 기령 2 획득"
  },
  Task_62253_UnlockCondDesc = {
    Text = "이벤트@깨어남체 판디아 기령 패키지 1 이벤트"
  },
  Task_62254_Desc = {
    Text = "다프다일을 획득할 때 기령 2"
  },
  Task_62254_Name = {
    Text = "다프다일을 획득할 때 기령 2"
  },
  Task_62254_UnlockCondDesc = {
    Text = "이벤트@깨어남체 다프다일 기령 패키지 1 이벤트"
  },
  Task_62255_Desc = {
    Text = "소렐 획득 시 기령 2"
  },
  Task_62255_Name = {
    Text = "소렐 획득 시 기령 2"
  },
  Task_62255_UnlockCondDesc = {
    Text = "이벤트@깨어남체 소렐 기령 패키지 0"
  },
  Task_62256_Desc = {
    Text = "판디아를 획득할 때 기령 6 활성화"
  },
  Task_62256_Name = {
    Text = "판디아를 획득할 때 기령 6 활성화"
  },
  Task_62256_UnlockCondDesc = {
    Text = "이벤트@깨어남체 판디아 기령 패키지 1"
  },
  Task_62257_Desc = {
    Text = "「24」를 획득할 때 기령 6"
  },
  Task_62257_Name = {
    Text = "「24」를 획득할 때 기령 6"
  },
  Task_62257_UnlockCondDesc = {
    Text = "이벤트@깨어남체 「24」 기령 선물 2 이벤트"
  },
  Task_62258_Desc = {
    Text = "리즈 획득 시 기령 2"
  },
  Task_62258_Name = {
    Text = "리즈 획득 시 기령 2"
  },
  Task_62258_UnlockCondDesc = {
    Text = "이벤트@리즈 기령 깨어남체 패키지 1 이벤트"
  },
  Task_62259_Desc = {
    Text = "「24」를 획득하면 기령 2"
  },
  Task_62259_Name = {
    Text = "「24」를 획득하면 기령 2"
  },
  Task_62259_UnlockCondDesc = {
    Text = "이벤트@깨어남체 「24」 기령 선물 패키지 0"
  },
  Task_62260_Desc = {
    Text = "리즈 획득 시 기령 6"
  },
  Task_62260_Name = {
    Text = "리즈 획득 시 기령 6"
  },
  Task_62260_UnlockCondDesc = {
    Text = "이벤트@리즈 깨어남체 기령 패키지 2 이벤트"
  },
  Task_62261_Desc = {
    Text = "히로 얻기 기령 2"
  },
  Task_62261_Name = {
    Text = "히로 얻기 기령 2"
  },
  Task_62261_UnlockCondDesc = {
    Text = "이벤트@깨어남체 시로 기령 패키지 1 이벤트"
  },
  Task_62262_Desc = {
    Text = "살바도르를 획득할 때 기령 2"
  },
  Task_62262_Name = {
    Text = "살바도르를 획득할 때 기령 2"
  },
  Task_62262_UnlockCondDesc = {
    Text = "활동@깨어남체 살바도르 기령 선물 패키지 0"
  },
  Task_62263_Desc = {
    Text = "히로 얻기 기령 6 개 획득"
  },
  Task_62263_Name = {
    Text = "히로 얻기 기령 6 개 획득"
  },
  Task_62263_UnlockCondDesc = {
    Text = "이벤트@깨어남체 시로 기령 패키지 1"
  },
  Task_62264_Desc = {
    Text = "살바도르를 획득할 때 기령 6"
  },
  Task_62264_Name = {
    Text = "살바도르를 획득할 때 기령 6"
  },
  Task_62264_UnlockCondDesc = {
    Text = "이벤트@깨어남체 살바도르 기령 깨어남 패키지 2 이벤트"
  },
  Task_62265_Desc = {
    Text = "닝피아를 얻을 때 기령2"
  },
  Task_62265_Name = {
    Text = "닝피아를 얻을 때 기령2"
  },
  Task_62265_UnlockCondDesc = {
    Text = "이벤트@닝피아 깨어남체 기령 선물 1 이벤트"
  },
  Task_62266_Desc = {
    Text = "머피를 얻을 때 기령 2 활성화"
  },
  Task_62266_Name = {
    Text = "머피를 얻을 때 기령 2 활성화"
  },
  Task_62266_UnlockCondDesc = {
    Text = "이벤트@깨어남체 머피 기령 패키지 0"
  },
  Task_62267_Desc = {
    Text = "레크 획득 시 기령 2"
  },
  Task_62267_Name = {
    Text = "레크 획득 시 기령 2"
  },
  Task_62267_UnlockCondDesc = {
    Text = "이벤트@깨어남체 레이크 기령 선물 패키지 0"
  },
  Task_62268_Desc = {
    Text = "타비를 얻을 때 기령 6"
  },
  Task_62268_Name = {
    Text = "타비를 얻을 때 기령 6"
  },
  Task_62268_UnlockCondDesc = {
    Text = "이벤트@깨어남체 타비 기령 세트 2 이벤트"
  },
  Task_62269_Desc = {
    Text = "팔로스를 획득할 때 기령 6"
  },
  Task_62269_Name = {
    Text = "팔로스를 획득할 때 기령 6"
  },
  Task_62269_UnlockCondDesc = {
    Text = "이벤트@깨어남체 팔로스 기령 선물 패키지 1"
  },
  Task_62270_Desc = {
    Text = "타비 얻기 시 기령 2 획득"
  },
  Task_62270_Name = {
    Text = "타비 얻기 시 기령 2 획득"
  },
  Task_62270_UnlockCondDesc = {
    Text = "이벤트@깨어남체 타비 깨어남 패키지 1 이벤트"
  },
  Task_62271_Desc = {
    Text = "파인트를 획득할 때 기령 레벨 6"
  },
  Task_62271_Name = {
    Text = "파인트를 획득할 때 기령 레벨 6"
  },
  Task_62271_UnlockCondDesc = {
    Text = "이벤트@깨어남체 파인트 기령 패키지 2 이벤트"
  },
  Task_62272_Desc = {
    Text = "소렐을 획득할 때 기령 6"
  },
  Task_62272_Name = {
    Text = "소렐을 획득할 때 기령 6"
  },
  Task_62272_UnlockCondDesc = {
    Text = "이벤트-깨어남체 소렐 기령 패키지 2 이벤트"
  },
  Task_62273_Desc = {
    Text = "산 획득 시 기령 2"
  },
  Task_62273_Name = {
    Text = "산 획득 시 기령 2"
  },
  Task_62273_UnlockCondDesc = {
    Text = "이벤트@깨어남체 산 기령 패키지 0"
  },
  Task_62274_Desc = {
    Text = "고리아를 획득할 때 기령 레벨 2"
  },
  Task_62274_Name = {
    Text = "고리아를 획득할 때 기령 레벨 2"
  },
  Task_62274_UnlockCondDesc = {
    Text = "이벤트@고리아 깨어남 기령 선물 1"
  },
  Task_62275_Desc = {
    Text = "미리암을 획득할 때 기령 2단계"
  },
  Task_62275_Name = {
    Text = "미리암을 획득할 때 기령 2단계"
  },
  Task_62275_UnlockCondDesc = {
    Text = "이벤트@미리암의 기령 깨어남체 패키지 1 이벤트"
  },
  Task_62276_Desc = {
    Text = "벤코르를 획득할 때 기령 6"
  },
  Task_62276_Name = {
    Text = "벤코르를 획득할 때 기령 6"
  },
  Task_62276_UnlockCondDesc = {
    Text = "이벤트 - 깨어남체 벤코르 기령 패키지 2 이벤트"
  },
  Task_62277_Desc = {
    Text = "케이크스를 획득할 때 기령 2단계"
  },
  Task_62277_Name = {
    Text = "케이크스를 획득할 때 기령 2단계"
  },
  Task_62277_UnlockCondDesc = {
    Text = "이벤트@깨어남체 케이크스 기령 0"
  },
  Task_62278_Desc = {
    Text = "기령 6이 적용된 미리암을 획득"
  },
  Task_62278_Name = {
    Text = "기령 6이 적용된 미리암을 획득"
  },
  Task_62278_UnlockCondDesc = {
    Text = "이벤트@깨어남체 미리암 기령 선물 2 이벤트"
  },
  Task_62279_Desc = {
    Text = "벤코르를 획득하면 기령 2이 활성화됩니다"
  },
  Task_62279_Name = {
    Text = "벤코르를 획득하면 기령 2이 활성화됩니다"
  },
  Task_62279_UnlockCondDesc = {
    Text = "이벤트@벤코르의 체온 기령 선물 팩 1 이벤트"
  },
  Task_62280_Desc = {
    Text = "케이크스를 획득할 때 기령 6"
  },
  Task_62280_Name = {
    Text = "케이크스를 획득할 때 기령 6"
  },
  Task_62280_UnlockCondDesc = {
    Text = "이벤트@깨어남체 케이크스 기령 패키지 2 이벤트"
  },
  Task_62281_Desc = {
    Text = "노디라를 획득할 때 기령 2단계 활성화"
  },
  Task_62281_Name = {
    Text = "노디라를 획득할 때 기령 2단계 활성화"
  },
  Task_62281_UnlockCondDesc = {
    Text = "이벤트@깨어남체 노디라 기령 패키지 0"
  },
  Task_62282_Desc = {
    Text = "레이아 획득 시 기령 2"
  },
  Task_62282_Name = {
    Text = "레이아 획득 시 기령 2"
  },
  Task_62282_UnlockCondDesc = {
    Text = "이벤트@레이아의 깨어남 기령 패키지 1 이벤트"
  },
  Task_62283_Desc = {
    Text = "힐레스트를 획득할 때 기령 2"
  },
  Task_62283_Name = {
    Text = "힐레스트를 획득할 때 기령 2"
  },
  Task_62283_UnlockCondDesc = {
    Text = "이벤트@깨어남체 힐레스트 기령 패키지 0"
  },
  Task_62284_Desc = {
    Text = "가렌을 획득할 때 기령 2개"
  },
  Task_62284_Name = {
    Text = "가렌을 획득할 때 기령 2개"
  },
  Task_62284_UnlockCondDesc = {
    Text = "이벤트@깨어남체 가렌 기령 선물 패키지 0"
  },
  Task_62285_Desc = {
    Text = "산 획득 시 기령 6"
  },
  Task_62285_Name = {
    Text = "산 획득 시 기령 6"
  },
  Task_62285_UnlockCondDesc = {
    Text = "이벤트@깨어남체 산 기령 패키지 2 이벤트"
  },
  Task_62286_Desc = {
    Text = "힐레스트를 획득할 때 기령 6"
  },
  Task_62286_Name = {
    Text = "힐레스트를 획득할 때 기령 6"
  },
  Task_62286_UnlockCondDesc = {
    Text = "이벤트@깨어남체 힐레스트 기령 패키지 1"
  },
  Task_62287_Desc = {
    Text = "가렌 얻기로 기령 6"
  },
  Task_62287_Name = {
    Text = "가렌 얻기로 기령 6"
  },
  Task_62287_UnlockCondDesc = {
    Text = "이벤트@깨어남체 가렌 기령 패키지 1"
  },
  Task_62288_Desc = {
    Text = "노디라를 획득하면 기령 6"
  },
  Task_62288_Name = {
    Text = "노디라를 획득하면 기령 6"
  },
  Task_62288_UnlockCondDesc = {
    Text = "이벤트@깨어남체 노디라 기령 패키지 1"
  },
  Task_62289_Desc = {
    Text = "잉크피 얻기 기령 6"
  },
  Task_62289_Name = {
    Text = "잉크피 얻기 기령 6"
  },
  Task_62289_UnlockCondDesc = {
    Text = "이벤트@깨어남체 머피 기령 패키지 1"
  },
  Task_62290_Desc = {
    Text = "오를라를 획득 시 기령 6"
  },
  Task_62290_Name = {
    Text = "오를라를 획득 시 기령 6"
  },
  Task_62290_UnlockCondDesc = {
    Text = "이벤트@깨어남체 오를라 기령 패키지 2 이벤트"
  },
  Task_62291_Desc = {
    Text = "테이스를 획득할 때 기령 II"
  },
  Task_62291_Name = {
    Text = "테이스를 획득할 때 기령 II"
  },
  Task_62291_UnlockCondDesc = {
    Text = "이벤트@깨어남체 테이스 기령 선물 1 이벤트"
  },
  Task_62292_Desc = {
    Text = "엘바 획득 시 기령 6"
  },
  Task_62292_Name = {
    Text = "엘바 획득 시 기령 6"
  },
  Task_62292_UnlockCondDesc = {
    Text = "이벤트@깨어남체 엘바 기령 선물 패키지 1"
  },
  Task_62293_Desc = {
    Text = "아그리파를 획득할 때 기령 2 활성화"
  },
  Task_62293_Name = {
    Text = "아그리파를 획득할 때 기령 2 활성화"
  },
  Task_62293_UnlockCondDesc = {
    Text = "이벤트@아그리파 깨어남 기령 패키지 1 이벤트"
  },
  Task_62294_Desc = {
    Text = "리리 획득 시 기령 2"
  },
  Task_62294_Name = {
    Text = "리리 획득 시 기령 2"
  },
  Task_62294_UnlockCondDesc = {
    Text = "이벤트@깨어남체 리리 기령 패키지 0"
  },
  Task_62295_Desc = {
    Text = "테이스를 획득할 때 기령 레벨 6"
  },
  Task_62295_Name = {
    Text = "테이스를 획득할 때 기령 레벨 6"
  },
  Task_62295_UnlockCondDesc = {
    Text = "이벤트@깨어남체 테이스 기령 패키지 1"
  },
  Task_62296_Desc = {
    Text = "엘바 획득 시 기령 2"
  },
  Task_62296_Name = {
    Text = "엘바 획득 시 기령 2"
  },
  Task_62296_UnlockCondDesc = {
    Text = "이벤트@엘바 기령 깨어남체 패키지 1 이벤트"
  },
  Task_62297_Desc = {
    Text = "유우하시를 획득 시 기령 6"
  },
  Task_62297_Name = {
    Text = "유우하시를 획득 시 기령 6"
  },
  Task_62297_UnlockCondDesc = {
    Text = "이벤트@깨어남체 유우하시 기령 선물 2 이벤트"
  },
  Task_62298_Desc = {
    Text = "본원 힐로를 획득할 때 기령 2"
  },
  Task_62298_Name = {
    Text = "본원 힐로를 획득할 때 기령 2"
  },
  Task_62298_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 힐로 기령 패키지 1 이벤트"
  },
  Task_62299_Desc = {
    Text = "본원 힐로를 획득할 때 기령 6"
  },
  Task_62299_Name = {
    Text = "본원 힐로를 획득할 때 기령 6"
  },
  Task_62299_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 힐로 기령 선물 2 이벤트"
  },
  Task_62300_Desc = {
    Text = "카시아 획득 시 기령 6"
  },
  Task_62300_Name = {
    Text = "카시아 획득 시 기령 6"
  },
  Task_62300_UnlockCondDesc = {
    Text = "이벤트@깨어남체 카시아 기령 패키지 1"
  },
  Task_62320_Desc = {
    Text = "특파 기록 「엘워스의 귀환자」 어려움 완료"
  },
  Task_62320_Name = {
    Text = "생명, 산을 뚫고 나오다·어려움"
  },
  Task_62321_Desc = {
    Text = "조사 완료 이벤트 「종말의 교향곡」 어려움 난이도"
  },
  Task_62321_Name = {
    Text = "전투, 기억의 이름으로·어려움"
  },
  Task_62322_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_62322_Desc2 = {
    Text = "이벤트 「종말의 교향곡」 조사 완료"
  },
  Task_62322_Name2 = {
    Text = "전투, 기억의 이름으로"
  },
  Task_62323_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_62323_Desc2 = {
    Text = "조사 이벤트 「종말의 교향곡」에서 공명 3회"
  },
  Task_62323_Name2 = {
    Text = "견고한 울림"
  },
  Task_62324_Desc = {
    Text = "특파 기록 「즐거운 사냥!」 완료"
  },
  Task_62324_Name = {
    Text = "운명의 장난"
  },
  Task_62325_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 9번"
  },
  Task_62325_Desc2 = {
    Text = "조사 이벤트 「종말의 교향곡」에서 공명을 9회"
  },
  Task_62325_Name2 = {
    Text = "견고한 울림 Ⅲ"
  },
  Task_62326_Desc = {
    Text = "10곳의 메인 줄기 8장 「@1@2」의 분해점 찾기"
  },
  Task_62326_Desc2 = {
    Text = "메인 줄기 8장 「종말의 교향곡」의 분해점 10곳을 찾으세요"
  },
  Task_62326_Name2 = {
    Text = "숨겨진 속삭임 Ⅷ"
  },
  Task_62327_Desc = {
    Text = "특파 기록 「엘워스의 귀환자」 완료"
  },
  Task_62327_Name = {
    Text = "생명, 산을 뚫고 나오다"
  },
  Task_62328_Desc = {
    Text = "특파 기록 「즐거운 사냥!」 어려움 완료"
  },
  Task_62328_Name = {
    Text = "운명의 장난·어려움"
  },
  Task_62329_Desc = {
    Text = "특파 기록 「장미의 거처」 완료"
  },
  Task_62329_Name = {
    Text = "꽃과 시의 여운"
  },
  Task_62330_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_62330_Desc2 = {
    Text = "조사 이벤트 「종말의 교향곡」에서 공명을 6회"
  },
  Task_62330_Name2 = {
    Text = "견고한 울림 Ⅱ"
  },
  Task_62331_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 13회 발생함"
  },
  Task_62331_Desc2 = {
    Text = "조사 이벤트 「종말의 교향곡」에서 공명을 13회"
  },
  Task_62331_Name2 = {
    Text = "견고한 울림 Ⅳ"
  },
  Task_62332_Desc = {
    Text = "특파 기록 「장미의 거처」 어려움 완료"
  },
  Task_62332_Name = {
    Text = "꽃과 시의 여운·어려움"
  },
  Task_62346_Desc = {
    Text = "라몬나의 도움 없이 「완전한 망각의 이치」를 격파하십시오."
  },
  Task_62346_Name = {
    Text = "고독한 최상의 위엄"
  },
  Task_62371_Desc = {
    Text = "라모나의 도움을 받아 「잊혀진 시초」를 격파하세요."
  },
  Task_62371_Name = {
    Text = "내 손을 잡아, 비밀의 수호자"
  },
  Task_65510_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65511_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65512_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65513_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65514_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65515_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65516_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65517_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65518_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65519_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_65722_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「기억 인코딩」에서 1번 승리"
  },
  Task_65723_Desc = {
    Text = "클리어 「거울」 임의의 난이도"
  },
  Task_65724_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「기억 인코딩」에서 1회 승리"
  },
  Task_65725_Desc = {
    Text = "기억 인코딩·클리어"
  },
  Task_65726_Desc = {
    Text = "기억 인코딩·경계역"
  },
  Task_65727_Desc = {
    Text = "클리어 「아몬드체」 광기 모드"
  },
  Task_65728_Desc = {
    Text = "클리어 「망각 곡선」 광기 난이도"
  },
  Task_65729_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「기억 인코딩」에서 1번 승리"
  },
  Task_65730_Desc = {
    Text = "클리어 「아몬드체」 임의의 난이도"
  },
  Task_65731_Desc = {
    Text = "클리어 「아몬드체」 임의의 난이도"
  },
  Task_65732_Desc = {
    Text = "클리어 「거울」 임의의 난이도"
  },
  Task_65733_Desc = {
    Text = "클리어 「망각 곡선」 어떤 난이도"
  },
  Task_65734_Desc = {
    Text = "클리어 「크롤링 뇌」 어떤 난이도로든"
  },
  Task_65735_Desc = {
    Text = "완료「기억 인코딩·클리어」모든 태스크"
  },
  Task_65736_Desc = {
    Text = "클리어 「망각 곡선」 어떤 난이도"
  },
  Task_65737_Desc = {
    Text = "클리어 「무의식적 기억」 아무 난이도"
  },
  Task_65738_Desc = {
    Text = "클리어 「거울」 광기의 난이도"
  },
  Task_65739_Desc = {
    Text = "기억 인코딩·광기"
  },
  Task_65740_Desc = {
    Text = "클리어 「무의식적 기억」 아무 난이도"
  },
  Task_65741_Desc = {
    Text = "통관 특수 임무 기록 「평온한 분열」"
  },
  Task_65742_Desc = {
    Text = "클리어 「무의식적 기억」 광기 난이도"
  },
  Task_65743_Desc = {
    Text = "클리어 「크롤링 뇌」 어떤 난이도로든"
  },
  Task_65744_Desc = {
    Text = "클리어 「크롤링 뇌」 광기 난이도"
  },
  Task_65745_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「기억 인코딩」에서 1번 승리"
  },
  Task_66015_Desc = {
    Text = "타비 동조율이 10에 도달했습니다"
  },
  Task_66213_Desc = {
    Text = "신국의 탄생·광기"
  },
  Task_66214_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「신국의 탄생」에서 1회 승리"
  },
  Task_66215_Desc = {
    Text = "클리어 「증언」 모든 난이도"
  },
  Task_66216_Desc = {
    Text = "클리어 「동요」 광기의 난이도"
  },
  Task_66217_Desc = {
    Text = "클리어 「강림」 모든 난이도"
  },
  Task_66218_Desc = {
    Text = "클리어 ‘신념’, 광기 난이도"
  },
  Task_66219_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「신국의 탄생」에서 1회 승리"
  },
  Task_66220_Desc = {
    Text = "클리어 「신념」 아무 난이도"
  },
  Task_66221_Desc = {
    Text = "클리어 「증언」 모든 난이도"
  },
  Task_66224_Desc = {
    Text = "클리어 「의심」 임의의 난이도"
  },
  Task_66227_Desc = {
    Text = "이몽시계 클리어 「모독」"
  },
  Task_66228_Desc = {
    Text = "'신국 탄생·통과'의 모든 임무 완료"
  },
  Task_66229_Desc = {
    Text = "클리어 「증언」 광기 난이도"
  },
  Task_66230_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「신국의 탄생」에서 1회 승리"
  },
  Task_66231_Desc = {
    Text = "클리어 「강림」 광기 난이도"
  },
  Task_66232_Desc = {
    Text = "신국의 탄생·경계역"
  },
  Task_66233_Desc = {
    Text = "클리어 「동요」 모든 난이도"
  },
  Task_66235_Desc = {
    Text = "클리어 「의심」 광기 난이도"
  },
  Task_66236_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「신국의 탄생」에서 1 회 승리"
  },
  Task_66237_Desc = {
    Text = "클리어 「강림」 모든 난이도"
  },
  Task_66238_Desc = {
    Text = "클리어 「동요」 모든 난이도"
  },
  Task_66240_Desc = {
    Text = "신국의 탄생·클리어"
  },
  Task_66241_Desc = {
    Text = "클리어 「신념」 아무 난이도"
  },
  Task_66242_Desc = {
    Text = "클리어 「의심」 임의의 난이도"
  },
  Task_66243_Desc = {
    Text = "심연의 응답"
  },
  Task_66335_Desc = {
    Text = "심사회의 추격을 피해 탈출하기"
  },
  Task_66335_Name = {Text = "목표"},
  Task_66336_Desc = {
    Text = "인면견 저지하기"
  },
  Task_66336_Name = {Text = "목표"},
  Task_66337_Desc = {
    Text = "심사회의 봉쇄 돌파하기"
  },
  Task_66337_Name = {Text = "목표"},
  Task_66338_Desc = {
    Text = "타이스 격파"
  },
  Task_66338_Name = {Text = "목표"},
  Task_66339_Desc = {Text = "N 격파"},
  Task_66339_Name = {Text = "목표"},
  Task_66340_Desc = {
    Text = "심사회의 침입 저지"
  },
  Task_66340_Name = {Text = "목표"},
  Task_66341_Desc = {
    Text = "쌍둥이 신상 파괴"
  },
  Task_66341_Name = {Text = "목표"},
  Task_66342_Desc = {
    Text = "하멜른 저지하기"
  },
  Task_66342_Name = {Text = "목표"},
  Task_66343_Desc = {
    Text = "타비 찾기"
  },
  Task_66343_Name = {Text = "목표"},
  Task_66344_Desc = {
    Text = "유리에트 저지"
  },
  Task_66344_Name = {Text = "목표"},
  Task_66422_Name = {
    Text = "보스 1N회 격파"
  },
  Task_66423_Name = {
    Text = "보스 2N회 격파"
  },
  Task_66424_Name = {
    Text = "보스 3N회 격파"
  },
  Task_66425_Name = {
    Text = "보스 4N회 격파"
  },
  Task_66426_Name = {
    Text = "보스 5N회 격파"
  },
  Task_66428_Name = {
    Text = "모든 보스 격파"
  },
  Task_66580_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_66580_Name = {
    Text = "완벽한 통과"
  },
  Task_66581_Desc = {
    Text = "클리어 시 8개 이상의 유물 보유"
  },
  Task_66581_Name = {
    Text = "기병의 보물창고"
  },
  Task_66582_Desc = {
    Text = "최종전에서 25턴 이내에 승리"
  },
  Task_66582_Name = {
    Text = "속전속결"
  },
  Task_66583_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_66583_Name = {
    Text = "우아하고 정확한"
  },
  Task_66584_Desc = {
    Text = "클리어 시 유물 8개 이상 소지"
  },
  Task_66584_Name = {
    Text = "기병의 보물창고"
  },
  Task_66585_Desc = {
    Text = "최종전에서 1턴 동안 200000 이상의 피해 입히기"
  },
  Task_66585_Name = {
    Text = "전력의 일격"
  },
  Task_66724_Desc = {
    Text = "클리어 「출발」 광기 난이도"
  },
  Task_66725_Desc = {
    Text = "클리어 「세계의 문」 광기 난이도"
  },
  Task_66726_Desc = {
    Text = "「지행의 문」 광기 난이도 클리어"
  },
  Task_66727_Desc = {
    Text = "클리어 「궁극의 문」 임의 난이도"
  },
  Task_66728_Desc = {
    Text = "클리어 「시비의 문」 광기 난이도"
  },
  Task_66729_Desc = {
    Text = "클리어 「귀일지문」 임의의 난이도"
  },
  Task_66730_Desc = {
    Text = "클리어 「출발」 임의 난이도"
  },
  Task_66731_Desc = {
    Text = "클리어 「시비의 문」 임의의 난이도"
  },
  Task_66732_Desc = {
    Text = "클리어 「문안에」 광기 난이도"
  },
  Task_66733_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「최종 테스트」에서 한 번 승리"
  },
  Task_66734_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「최종 테스트」에서 2회 승리"
  },
  Task_66735_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「최종 테스트」에서 2번 승리하라"
  },
  Task_66736_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「최종 테스트」에서 1번 승리"
  },
  Task_66737_Desc = {
    Text = "클리어 「시비의 문」 임의의 난이도"
  },
  Task_66738_Desc = {
    Text = "클리어 「지행의 문」 임의 난이도"
  },
  Task_66739_Desc = {
    Text = "최종 테스트·광기"
  },
  Task_66740_Desc = {
    Text = "클리어 「지행의 문」 임의 난이도"
  },
  Task_66741_Desc = {
    Text = "클리어 「세계의 문」 아무 난이도"
  },
  Task_66742_Desc = {
    Text = "클리어 「궁극의 문」 임의 난이도"
  },
  Task_66743_Desc = {
    Text = "클리어 「문안에」 아무 난이도"
  },
  Task_66744_Desc = {
    Text = "최종 테스트·클리어"
  },
  Task_66745_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「최종 테스트」에서 2번 승리하라"
  },
  Task_66746_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「최종 테스트」에서 한 번 승리"
  },
  Task_66747_Desc = {
    Text = "클리어 「이성의 문」 광기의 난이도"
  },
  Task_66748_Desc = {
    Text = "클리어 「귀일지문」 광기 난이도"
  },
  Task_66749_Desc = {
    Text = "클리어 「출발」 임의 난이도"
  },
  Task_66750_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「최종 테스트」에서 2번 승리하라"
  },
  Task_66751_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해 「최종 테스트」에서 1회 승리"
  },
  Task_66752_Desc = {
    Text = "클리어 「문안에」 아무 난이도"
  },
  Task_66753_Desc = {
    Text = "클리어 「본성의 문」 어떤 난이도든"
  },
  Task_66754_Desc = {
    Text = "클리어 「본성의 문」 광기 난이도"
  },
  Task_66755_Desc = {
    Text = "클리어 「궁극의 문」 광기 난이도"
  },
  Task_66756_Desc = {
    Text = "최종 테스트·경계역"
  },
  Task_66757_Desc = {
    Text = "완료「최종 테스트·클리어」모든 태스크"
  },
  Task_66758_Desc = {
    Text = "클리어 「이성의 문」 아무 난이도"
  },
  Task_66759_Desc = {
    Text = "클리어 「본성의 문」 어떤 난이도든"
  },
  Task_66760_Desc = {
    Text = "클리어 「세계의 문」 아무 난이도"
  },
  Task_66761_Desc = {
    Text = "클리어 「이성의 문」 아무 난이도"
  },
  Task_66762_Desc = {
    Text = "클리어 「귀일지문」 임의의 난이도"
  },
  Task_67066_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67067_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67068_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67069_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67070_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67071_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67072_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67073_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67075_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67076_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_67113_Desc = {
    Text = "2개의 메인 줄기 최종장 「@1@2」의 분해점 찾다"
  },
  Task_67113_Desc2 = {
    Text = "2곳의 메인 줄기 최종장 「장몽진시」의 분해점 찾기"
  },
  Task_67113_Name2 = {
    Text = "숨겨진 속삭임 Ⅸ"
  },
  Task_67114_Desc = {
    Text = "조사 완료 이벤트 「장몽진시」 어려움"
  },
  Task_67114_Name = {
    Text = "감시, 죽을 때까지·어려움"
  },
  Task_67115_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_67115_Desc2 = {
    Text = "이벤트 조사 「장몽진시」 완료"
  },
  Task_67115_Name2 = {
    Text = "감시, 죽을 때까지"
  },
  Task_67116_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_67116_Desc2 = {
    Text = "조사 사건 「장몽진시」에서 공명 3회"
  },
  Task_67116_Name2 = {
    Text = "궁극의 반향"
  },
  Task_67125_Name = {
    Text = "보스 6N회 격파"
  },
  Task_67126_Name = {
    Text = "보스 7N회 격파"
  },
  Task_67408_Desc = {
    Text = "토후-와-보후를 저지하고, 문을 닫기"
  },
  Task_67408_Name = {Text = "목표"},
  Task_67409_Desc = {
    Text = "미사그의 내통자 찾기"
  },
  Task_67409_Name = {Text = "목표"},
  Task_67410_Desc = {
    Text = "토후-와-보후 저지"
  },
  Task_67410_Name = {Text = "목표"},
  Task_67411_Desc = {
    Text = "깨어남체들과 작별을 고하기"
  },
  Task_67411_Name = {Text = "목표"},
  Task_67827_Desc = {
    Text = "굴복하라... 이 영원한 혼돈의 진실타래에..."
  },
  Task_67827_Name = {
    Text = "굴복하라... 이 영원한 혼돈의 진실타래에..."
  },
  Task_67828_Desc = {
    Text = "그 신의 우둔함에, 저항할 수는 없다."
  },
  Task_67828_Name = {
    Text = "그 신의 우둔함에, 저항할 수는 없다."
  },
  Task_67829_Desc = {
    Text = "그 신의 위엄을, 직시할 수는 없다."
  },
  Task_67829_Name = {
    Text = "그 신의 위엄을, 직시할 수는 없다."
  },
  Task_67919_Desc = {
    Text = "소나니르 호 · 광기의 시야의 모든 분신을 소멸시키고 해금"
  },
  Task_67919_Name = {
    Text = "보스 6 킬"
  },
  Task_67920_Desc = {
    Text = "「왁스상관·공포의 시선」의 모든 분신을 제거하면 해금됩니다."
  },
  Task_67920_Name = {
    Text = "보스2 격파"
  },
  Task_67921_Desc = {
    Text = "「요양원·기묘한 시선」의 모든 분신을 소멸시켜 해금"
  },
  Task_67921_Name = {
    Text = "보스4 격파"
  },
  Task_67922_Desc = {
    Text = "「브릴퍼트·사악한 신의 시선」의 모든 분신을 해금하려면 제거하세요."
  },
  Task_67922_Name = {
    Text = "보스5 격파"
  },
  Task_67923_Desc = {
    Text = "「빈민원·슬픔의 시선」 모든 분신을 소멸시켜 해금"
  },
  Task_67923_Name = {
    Text = "보스1 격파"
  },
  Task_67924_Desc = {
    Text = "「레무바시·탄생의 시선」 모든 분신을 소멸시켜 해금"
  },
  Task_67924_Name = {
    Text = "킬 보스7"
  },
  Task_67925_Desc = {
    Text = "「라이·차가운 시선」의 모든 분신을 제거하여 해금"
  },
  Task_67925_Name = {
    Text = "보스3 격파"
  },
  Task_67926_Name = {
    Text = "5개의 원초적 시야 의 모든 분신이 킬되었습니다"
  },
  Task_67927_Name = {
    Text = "2개의 원초적 시야의 모든 분신이 킬되었습니다"
  },
  Task_67928_Name = {
    Text = "4개의 원초적 시야의 모든 분신이 킬되었습니다."
  },
  Task_67929_Name = {
    Text = "6개의 원초적 시야의 모든 분신이 제거되었습니다"
  },
  Task_67930_Name = {
    Text = "1개의 원초적 시야의 모든 분신이 킬되었습니다"
  },
  Task_67931_Name = {
    Text = "7개의 원초적 시야의 모든 분신이 킬되었습니다"
  },
  Task_67932_Name = {
    Text = "3개의 원초적 시야의 모든 분신이 킬을 당했다"
  },
  Task_68342_Desc = {
    Text = "별을 넘어Ⅲ"
  },
  Task_68343_Desc = {
    Text = "별을 넘어Ⅴ"
  },
  Task_68344_Desc = {
    Text = "별을 넘어Ⅶ"
  },
  Task_68345_Desc = {
    Text = "별을 넘어 Ⅱ"
  },
  Task_68346_Desc = {
    Text = "별을 넘어Ⅳ"
  },
  Task_68347_Desc = {
    Text = "별을 넘어Ⅰ"
  },
  Task_68348_Desc = {
    Text = "별을 넘어Ⅵ"
  },
  Task_68365_Desc = {
    Text = "별을 넘어·무료"
  },
  Task_68377_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68378_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68379_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68380_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68382_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68383_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68384_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68385_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68386_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68387_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68388_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68389_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68390_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68391_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68392_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68393_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68394_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68395_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68396_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68397_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_68418_Name = {
    Text = "세계 보스 이벤트의 끝"
  },
  Task_68492_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「깊은 바다 응시」에서 1회 승리"
  },
  Task_68493_Desc = {
    Text = "클리어 「신의 눈」 광기 난이도로"
  },
  Task_68494_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「깊은 바다 응시」에서 1회 승리"
  },
  Task_68495_Desc = {
    Text = "클리어 「아름다운 환상」 임의 난이도"
  },
  Task_68496_Desc = {
    Text = "클리어 「아름다운 환상」 광기의 난이도"
  },
  Task_68497_Desc = {
    Text = "클리어 「인성 붕괴」 임의의 난이도"
  },
  Task_68498_Desc = {
    Text = "클리어 「인성 붕괴」 광기 난이도。"
  },
  Task_68499_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「깊은 바다 응시」에서 1회 승리"
  },
  Task_68500_Desc = {
    Text = "클리어 「신의 눈」 임의의 난이도"
  },
  Task_68501_Desc = {
    Text = "클리어 「인성 붕괴」 임의의 난이도"
  },
  Task_68502_Desc = {
    Text = "클리어 「향수」 임의 난이도"
  },
  Task_68503_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「깊은 바다 응시」에서 1번 승리"
  },
  Task_68504_Desc = {
    Text = "깊은 바다 응시·광기"
  },
  Task_68505_Desc = {
    Text = "클리어 「아름다운 환상」 임의 난이도"
  },
  Task_68506_Desc = {
    Text = "클리어 「쇠퇴한 국가」 모든 난이도"
  },
  Task_68507_Desc = {
    Text = "깊은 바다 응시·클리어"
  },
  Task_68508_Desc = {
    Text = "클리어 「향수」 임의 난이도"
  },
  Task_68509_Desc = {
    Text = "클리어 ‘향수’ 광기 난이도"
  },
  Task_68510_Desc = {
    Text = "클리어 「쇠퇴한 국가」 모든 난이도"
  },
  Task_68511_Desc = {
    Text = "클리어 「쇠퇴한 국가」 광기"
  },
  Task_68512_Desc = {
    Text = "깊은 바다 응시·경계역"
  },
  Task_68513_Desc = {
    Text = "「심해의 응시·클리어」 모든 임무 완료"
  },
  Task_68514_Desc = {
    Text = "클리어 「신의 눈」 임의의 난이도"
  },
  Task_68860_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_68860_Name = {Text = "1승"},
  Task_68861_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_68861_Name = {Text = "6승"},
  Task_68862_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_68862_Name = {Text = "3승"},
  Task_68863_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_68863_Name = {Text = "10승"},
  Task_68864_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_68864_Name = {Text = "3승"},
  Task_68865_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_68865_Name = {Text = "6승"},
  Task_68866_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_68866_Name = {Text = "1승"},
  Task_68867_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_68867_Name = {Text = "10승"},
  Task_69819_Desc = {
    Text = "최종전 35턴 내 승리"
  },
  Task_69819_Name = {
    Text = "최종전 35턴 내 승리"
  },
  Task_70112_Desc = {
    Text = "깊은 바다 영역 깨어남체로 「혼란스러운 정욕」에서 1번 승리하기"
  },
  Task_70113_Desc = {
    Text = "클리어 「년륜」 광기 난이도"
  },
  Task_70114_Desc = {
    Text = "깊은 바다 영역 깨어남체로 「혼란스러운 정욕」에서 2번 승리"
  },
  Task_70115_Desc = {
    Text = "클리어 「유근」 아무 난이도"
  },
  Task_70116_Desc = {
    Text = "클리어 「수분」 임의의 난이도"
  },
  Task_70117_Desc = {
    Text = "클리어 「유근」 광기 모드"
  },
  Task_70118_Desc = {
    Text = "클리어 「발아」 모든 난이도"
  },
  Task_70119_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「혼란스러운 정욕」에서 1번 승리"
  },
  Task_70120_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「혼란스러운 정욕」에서 승리 2번하기"
  },
  Task_70121_Desc = {
    Text = "혼란스러운 정욕·광기"
  },
  Task_70122_Desc = {
    Text = "클리어 「낙과」 광기 난이도"
  },
  Task_70123_Desc = {
    Text = "혼란스러운 정욕·경계역"
  },
  Task_70124_Desc = {
    Text = "클리어 「수분」 광기 난이도"
  },
  Task_70125_Desc = {
    Text = "클리어 꽃받침 광기 난이도"
  },
  Task_70126_Desc = {
    Text = "클리어 「재생화」 아무 난이도"
  },
  Task_70127_Desc = {
    Text = "클리어 「재생화」 광기 난이도"
  },
  Task_70128_Desc = {
    Text = "클리어 「발아」 광기 난이도"
  },
  Task_70129_Desc = {
    Text = "클리어 「밀선」 어떤 난이도든"
  },
  Task_70130_Desc = {
    Text = "클리어 「년륜」 어떤 난이도"
  },
  Task_70131_Desc = {
    Text = "클리어 「배주」 임의 난이도"
  },
  Task_70132_Desc = {
    Text = "클리어 「낙과」 모든 난이도"
  },
  Task_70133_Desc = {
    Text = "클리어 「배주」 광기 난이도"
  },
  Task_70134_Desc = {
    Text = "카오스 경계역의 깨어남체를 사용하여 「혼란스러운 정욕」에서 2번 승리하라"
  },
  Task_70135_Desc = {
    Text = "클리어 「꽃받침」 아무 난이도"
  },
  Task_70136_Desc = {
    Text = "카오스 경계역의 깨어남체를 사용하여 「혼란스러운 정욕」에서 1번 승리"
  },
  Task_70137_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용해 「혼란스러운 정욕」에서 2번 승리하기"
  },
  Task_70138_Desc = {
    Text = "클리어 「다중 배아 생식」 광기 난이도"
  },
  Task_70139_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「혼란스러운 정욕」에서 1번 승리"
  },
  Task_70140_Desc = {
    Text = "클리어 「다중 배아 생식」 어떤 난이도든"
  },
  Task_70141_Desc = {
    Text = "클리어 「밀선」 광기 난이도"
  },
  Task_70307_Desc = {
    Text = "최종전 40턴 내 승리"
  },
  Task_70307_Name = {
    Text = "최종전 40턴 내 승리"
  },
  Task_70446_Name = {
    Text = "8-8 다시 클리어"
  },
  Task_70447_Name = {
    Text = "8-4 다시 클리어"
  },
  Task_70448_Name = {
    Text = "레이크 지선 스테이지 12 보통 재차 클리어"
  },
  Task_70449_Name = {
    Text = "재차 에리카 사이드 스테이지 보통 3 클리어"
  },
  Task_70450_Name = {
    Text = "3-14 다시 클리어"
  },
  Task_70451_Name = {
    Text = "재차 클리어 산 지선 관문 보통 4"
  },
  Task_70452_Name = {
    Text = "오를라 지선 스테이지 보통 9 재차 클리어"
  },
  Task_70453_Name = {
    Text = "오지르 측선 스테이지 보통 난이도 4 재차 클리어"
  },
  Task_70454_Name = {
    Text = "2-16 다시 클리어"
  },
  Task_70455_Name = {
    Text = "2-15 다시 클리어"
  },
  Task_70456_Name = {
    Text = "오레타 서브 퀘스트 보통 3 재차 클리어"
  },
  Task_70457_Name = {
    Text = "재차 클리어 「24」지선 스테이지 보통 10"
  },
  Task_70458_Name = {
    Text = "다포딜의 서브 퀘스트 일반 난이도 10을 재깨우기"
  },
  Task_70459_Name = {
    Text = "재차 클리어 아그리파 보통 5"
  },
  Task_70460_Name = {
    Text = "6-8 다시 클리어"
  },
  Task_70461_Name = {
    Text = "8-14 다시 클리어"
  },
  Task_70462_Name = {
    Text = "일반 13 소렐 부대 재차 클리어"
  },
  Task_70463_Name = {
    Text = "미리암 서브 퀘스트 15 보통 클리어 재차"
  },
  Task_70464_Name = {
    Text = "8-7 다시 클리어"
  },
  Task_70465_Name = {
    Text = "7-2 다시 클리어"
  },
  Task_70466_Name = {
    Text = "7-3 다시 클리어"
  },
  Task_70467_Name = {
    Text = "7-1 다시 클리어"
  },
  Task_70468_Name = {
    Text = "리리 사이드 퀘스트 일반 7 재차 클리어"
  },
  Task_70469_Name = {
    Text = "본원 라몬나 사이드 퀘스트 보통 4 재차 클리어"
  },
  Task_70470_Name = {
    Text = "1-8 다시 클리어"
  },
  Task_70471_Name = {
    Text = "본원 힐로 지선 스테이지 보통 9를 다시 클리어해 주세요."
  },
  Task_70472_Name = {
    Text = "4-16 다시 클리어"
  },
  Task_70473_Name = {
    Text = "1-14 다시 클리어"
  },
  Task_70474_Name = {
    Text = "4-13 다시 클리어"
  },
  Task_70475_Name = {
    Text = "1-15 다시 클리어"
  },
  Task_70476_Name = {
    Text = "9-13 다시 클리어"
  },
  Task_70477_Name = {
    Text = "3-2 다시 클리어"
  },
  Task_70478_Name = {
    Text = "3-3 다시 클리어"
  },
  Task_70479_Name = {
    Text = "유우하시 지선 스테이지 4 보통 재차 클리어"
  },
  Task_70480_Name = {
    Text = "6-15 다시 클리어"
  },
  Task_70481_Name = {
    Text = "고리아 보통 3 재차 클리어하기"
  },
  Task_70482_Name = {
    Text = "5-12 다시 클리어"
  },
  Task_70483_Name = {
    Text = "6-10 다시 클리어"
  },
  Task_70484_Name = {
    Text = "살바도르 사이드 퀘스트 보통 9 재차 클리어"
  },
  Task_70485_Name = {
    Text = "완다 사이드 스테이지 보통 4를 재차 클리어"
  },
  Task_70941_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70941_Name = {
    Text = "속전속결"
  },
  Task_70942_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_70942_Name = {
    Text = "우아하고 정확한"
  },
  Task_70943_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_70943_Name = {Text = "드로우!"},
  Task_70944_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_70944_Name = {
    Text = "에너지 절약"
  },
  Task_70945_Desc = {
    Text = "각인 1개 이상 획득"
  },
  Task_70945_Name = {
    Text = "영혼의 낙인"
  },
  Task_70946_Desc = {
    Text = "클리어 시 HP 50% 이상"
  },
  Task_70946_Name = {
    Text = "우아하고 정확한"
  },
  Task_70947_Desc = {
    Text = "1개 이상의 황금 유물을 소지한 상태로 클리어"
  },
  Task_70947_Name = {
    Text = "기병의 보물창고"
  },
  Task_70948_Desc = {
    Text = "클리어 시 증상 카드 2장 이하"
  },
  Task_70948_Name = {
    Text = "에너지 절약"
  },
  Task_70949_Desc = {
    Text = "클리어 시 유물 2개 이상 소지"
  },
  Task_70949_Name = {
    Text = "기병의 보물창고"
  },
  Task_70950_Desc = {
    Text = "1개 이상의 황금 유물을 소지한 상태로 클리어"
  },
  Task_70950_Name = {
    Text = "기병의 보물창고"
  },
  Task_70951_Desc = {
    Text = "최종전에서 1턴 동안 5장 이상의 카드 뽑기"
  },
  Task_70951_Name = {
    Text = "내 차례야!이야"
  },
  Task_70952_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70952_Name = {
    Text = "속전속결"
  },
  Task_70953_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70953_Name = {
    Text = "속전속결"
  },
  Task_70954_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70954_Name = {
    Text = "속전속결"
  },
  Task_70955_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70955_Name = {
    Text = "속전속결"
  },
  Task_70956_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70956_Name = {
    Text = "속전속결"
  },
  Task_70957_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70957_Name = {
    Text = "속전속결"
  },
  Task_70958_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70958_Name = {
    Text = "속전속결"
  },
  Task_70959_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70959_Name = {
    Text = "속전속결"
  },
  Task_70960_Desc = {
    Text = "최종전에서 10턴 이내에 승리"
  },
  Task_70960_Name = {
    Text = "속전속결"
  },
  Task_71343_Desc = {
    Text = "클리어 「광재」 광기 난이도"
  },
  Task_71344_Desc = {
    Text = "카오스 경계역 깨어남체를 사용해서 「무의문」에서 1회 승리"
  },
  Task_71345_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「무의문」에서 2번 승리하기"
  },
  Task_71346_Desc = {
    Text = "클리어 「빛나는 소멸」 임의의 난이도"
  },
  Task_71347_Desc = {
    Text = "클리어 「광재」 임의의 난이도"
  },
  Task_71348_Desc = {
    Text = "클리어 「혼돈의 예언」 모든 난이도"
  },
  Task_71349_Desc = {
    Text = "무의문·경계역"
  },
  Task_71350_Desc = {
    Text = "클리어 「인형의 집」 어떤 난이도든"
  },
  Task_71351_Desc = {
    Text = "클리어 「별」 광기 레벨"
  },
  Task_71352_Desc = {
    Text = "클리어 「광재」 임의의 난이도"
  },
  Task_71353_Desc = {
    Text = "클리어 「빛나는 소멸」 임의의 난이도"
  },
  Task_71354_Desc = {
    Text = "클리어 「환상 무도회」 어떤 난이도든"
  },
  Task_71355_Desc = {
    Text = "무의문·광기"
  },
  Task_71356_Desc = {
    Text = "클리어 「인형의 실타래」 임의난이도"
  },
  Task_71357_Desc = {
    Text = "클리어 「진실타래의 독약」 임의 난이도"
  },
  Task_71358_Desc = {
    Text = "클리어 「인형의 실타래」 광기 난이도"
  },
  Task_71359_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「무의문」에서 2번 승리하십시오"
  },
  Task_71360_Desc = {
    Text = "클리어 「혼돈의 예언」 모든 난이도"
  },
  Task_71361_Desc = {
    Text = "클리어 「초대」 광기 난이도"
  },
  Task_71362_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「무의문」에서 2번 승리하기"
  },
  Task_71363_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「무의문」에서 1회 승리"
  },
  Task_71364_Desc = {
    Text = "무의문·클리어"
  },
  Task_71365_Desc = {
    Text = "「무의문·클리어」 모든 성취를 완료하다"
  },
  Task_71366_Desc = {
    Text = "클리어 「빛나는 소멸」광기 난이도"
  },
  Task_71367_Desc = {
    Text = "클리어 「진실타래의 독약」 광기"
  },
  Task_71368_Desc = {
    Text = "클리어 「인형의 실타래」 임의난이도"
  },
  Task_71369_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「무의문」에서 한 번 승리"
  },
  Task_71370_Desc = {
    Text = "클리어 「인형의 집」 광기 난이도"
  },
  Task_71373_Desc = {
    Text = "클리어 「별」 임의의 난이도"
  },
  Task_71374_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「무의문」에서 2번 승리하다"
  },
  Task_71375_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용해 「무의문」에서 1회 승리"
  },
  Task_71376_Desc = {
    Text = "클리어 「환상 무도회」 어떤 난이도든"
  },
  Task_71377_Desc = {
    Text = "클리어 「인형의 집」 어떤 난이도든"
  },
  Task_71378_Desc = {
    Text = "클리어 「별」 임의의 난이도"
  },
  Task_71379_Desc = {
    Text = "클리어 「초대」 임의 난이도"
  },
  Task_71380_Desc = {
    Text = "클리어 「혼돈의 예언」 광기"
  },
  Task_71381_Desc = {
    Text = "클리어 「환상 무도회」 광기"
  },
  Task_71382_Desc = {
    Text = "클리어 「진실타래의 독약」 임의 난이도"
  },
  Task_71385_Desc = {
    Text = "클리어 「초대」 임의 난이도"
  },
  Task_71757_Desc = {
    Text = "클리어 「가면 코미디」 광기 난이도"
  },
  Task_71758_Desc = {
    Text = "클리어 「시나리오 회전」 모든 난이도"
  },
  Task_71759_Desc = {
    Text = "클리어 「장면 정지 순간」 광기"
  },
  Task_71760_Desc = {
    Text = "클리어 「장면 정지 순간」 모든 난이도"
  },
  Task_71761_Desc = {
    Text = "클리어 「카타시스」 광기 난이도로"
  },
  Task_71762_Desc = {
    Text = "클리어 「호광이론」 모든 난이도"
  },
  Task_71763_Desc = {
    Text = "클리어 「시나리오 회전」 광기 난이도"
  },
  Task_71764_Desc = {
    Text = "클리어 「이방화 효과」 광기 난이도"
  },
  Task_71765_Desc = {
    Text = "클리어 「삼일률」 광기 난이도"
  },
  Task_71766_Desc = {
    Text = "클리어 「삼일률」 아무 난이도"
  },
  Task_71767_Desc = {
    Text = "클리어 ‘카타시스’ 임의 난이도"
  },
  Task_71768_Desc = {
    Text = "클리어 「가면 코미디」 임의 난이도"
  },
  Task_71769_Desc = {
    Text = "클리어 「드라마의 네 번째 벽」광기 난이도"
  },
  Task_71770_Desc = {
    Text = "클리어 「드라마의 네 번째 벽」 어떤 난이도로든"
  },
  Task_71771_Desc = {
    Text = "클리어 「이방화 효과」 임의의 난이도"
  },
  Task_71772_Desc = {
    Text = "클리어 「호광이론」 광기 난이도"
  },
  Task_71773_Desc = {
    Text = "클리어 「극작 피라미드」 광기 모드"
  },
  Task_71774_Desc = {
    Text = "클리어 「극작 피라미드」 임의 난이도"
  },
  Task_71775_Desc = {
    Text = "스케줄 미스터리·광기"
  },
  Task_71795_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71795_Name = {Text = "2800점"},
  Task_71796_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71796_Name = {Text = "2700점"},
  Task_71797_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71797_Name = {Text = "2900점"},
  Task_71798_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71798_Name = {Text = "2600점"},
  Task_71799_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71799_Name = {Text = "2300점"},
  Task_71800_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71800_Name = {Text = "2400점"},
  Task_71801_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71801_Name = {Text = "2500점"},
  Task_71802_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71802_Name = {Text = "1900점"},
  Task_71803_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71803_Name = {Text = "2000점"},
  Task_71804_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71804_Name = {Text = "2100점"},
  Task_71805_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71805_Name = {Text = "2200점"},
  Task_71806_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71806_Name = {Text = "3000점"},
  Task_71807_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71807_Name = {Text = "1600점"},
  Task_71808_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71808_Name = {Text = "1700점"},
  Task_71809_Desc = {
    Text = "대국 점수 최고 기록"
  },
  Task_71809_Name = {Text = "1800점"},
  Task_71819_Desc = {
    Text = "클리어 「종곡」 임의의 난이도"
  },
  Task_71820_Desc = {
    Text = "클리어 「얼굴」 임의 난이도"
  },
  Task_71821_Desc = {
    Text = "클리어 「장다리 아저씨」 의 임의 난이도"
  },
  Task_71822_Desc = {
    Text = "클리어 「시선」 모든 난이도"
  },
  Task_71823_Desc = {
    Text = "클리어 「인형 게임」 아무 난이도"
  },
  Task_71824_Desc = {
    Text = "클리어 「미완의 대본」 임의의 난이도"
  },
  Task_71825_Desc = {
    Text = "클리어 「장미의 각도」 어떤 난이도든"
  },
  Task_71826_Desc = {
    Text = "클리어 「부아래서 헤엄치는 물고기」 어떤 난이도로든"
  },
  Task_71827_Desc = {
    Text = "클리어 「선물」 아무 난이도"
  },
  Task_71867_Desc = {
    Text = "5/6/7/8 개의 유물을 소유하면 250/500/750/1000 점 획득."
  },
  Task_71867_Name = {
    Text = "실타래상 수집 <size=20><color=#747474>8개의 유물을 보유</color></size>"
  },
  Task_71868_Desc = {
    Text = "각각의 근육 기억을 1회 사용 시 조사 점수가 20% 감소합니다."
  },
  Task_71868_Name = {
    Text = "드림워커 <size=20><color=#747474>근육 기억을 1회 사용할 때마다 조사 점수 20% 감소</color></size>"
  },
  Task_71934_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71935_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71936_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71937_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71939_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71940_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71941_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71942_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71943_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71944_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71945_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71946_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71947_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71948_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71949_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71950_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71952_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71953_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71954_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71955_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71977_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71978_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71980_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_71981_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_72038_Name = {
    Text = "재차 클리어 투루 사이드 관문 보통 4"
  },
  Task_72039_Desc = {
    Text = "「시선」 광기 난이도 클리어"
  },
  Task_72040_Desc = {
    Text = "클리어 「부아래서 헤엄치는 물고기」 광기 난이도로"
  },
  Task_72041_Desc = {
    Text = "클리어 「인형 게임」 광기"
  },
  Task_72042_Desc = {
    Text = "클리어 「선물」 광기"
  },
  Task_72043_Desc = {
    Text = "통관 특수 임무 기록 「장미의 추억」"
  },
  Task_72044_Desc = {
    Text = "클리어 「장다리 아저씨」 광기"
  },
  Task_72045_Desc = {
    Text = "클리어 미완의 대본 광기 난이도"
  },
  Task_72046_Desc = {
    Text = "클리어 「장미의 각도」 광기 난이도"
  },
  Task_72047_Desc = {
    Text = "클리어 「표정」 광기 난이도"
  },
  Task_72048_Desc = {
    Text = "클리어 「종곡」 광기 난이도"
  },
  Task_72049_Desc = {
    Text = "장미의 추억·광기"
  },
  Task_72245_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72245_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72386_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72386_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72387_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72387_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72389_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72389_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72390_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72390_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72391_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72391_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72392_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72392_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72393_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72393_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72394_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72394_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72395_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72395_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72396_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72396_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72416_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72416_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72420_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72420_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72540_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72540_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72541_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72541_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72542_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72542_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72545_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72545_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72546_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72546_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72547_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72547_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72548_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72548_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72549_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72549_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72632_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72632_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72652_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72652_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72677_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72677_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72678_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72678_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72679_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72679_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72681_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72681_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72682_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72682_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72683_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72683_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72684_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72684_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72685_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72685_UnlockCondDesc = {
    Text = "「턴 역전: 이계의 손님」을 완료한 후 해금됩니다. 「턴 역전」으로 이동하시겠습니까?"
  },
  Task_72700_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72700_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72701_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72701_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72703_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72703_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72704_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72704_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72705_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72705_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72706_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72706_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72707_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72707_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72709_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72709_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72773_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72773_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72790_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72790_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72798_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72798_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72799_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72799_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72800_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72800_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72801_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72801_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72802_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72802_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72803_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72803_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72805_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72805_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72806_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72806_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72807_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_72807_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_72957_Desc = {
    Text = "사용 「통증을 넘어서」 3번 승리 획득"
  },
  Task_72958_Desc = {
    Text = "사용 「이형체 회흡」 획득 1회 승리"
  },
  Task_72959_Desc = {
    Text = "사용「코어 용해」로 3번 승리하기"
  },
  Task_72961_Desc = {
    Text = "사용 「35mm의 마법」 1번 승리를 획득하다"
  },
  Task_72963_Desc = {
    Text = "사용 「여왕의 계율」 3번 승리 획득"
  },
  Task_72965_Desc = {
    Text = "「백만 몬스터의 눈」을 사용하여 1번 승리 획득"
  },
  Task_72968_Desc = {
    Text = "사용 「등장」으로 1번 승리 획득"
  },
  Task_72973_Desc = {
    Text = "「릴리」를 사용하여 1회 승리"
  },
  Task_72975_Desc = {
    Text = "사용 「분노의 피와 모래」 3번 승리 획득"
  },
  Task_72976_Desc = {
    Text = "「가장 소중한 수집품」을 사용하여 3회 승리하기"
  },
  Task_72977_Desc = {
    Text = "사용 「은둔의 전륜」 3번 승리 획득"
  },
  Task_72978_Desc = {
    Text = "「정보는 생명이다」를 사용하여 3번 승리"
  },
  Task_72980_Desc = {
    Text = "「리즈」를 사용하여 1회 승리"
  },
  Task_72982_Desc = {
    Text = "사용 「죽음 너머로」 획득 3번의 승리"
  },
  Task_72983_Desc = {
    Text = "「호수에서 돌아보기」를 사용하여 1번 승리를 획득"
  },
  Task_72986_Desc = {
    Text = "사용 「거인의 검」 한 번 승리"
  },
  Task_72989_Desc = {
    Text = "「오지에」를 사용하여 3회 승리"
  },
  Task_72990_Desc = {
    Text = "「포식의 요람」을 사용하여 1번 승리"
  },
  Task_72992_Desc = {
    Text = "「크리티컬 포인트」를 사용하여 한 번 승리하기"
  },
  Task_72993_Desc = {
    Text = "사용 「나의 소중한 친구에게」로 1번 승리 획득"
  },
  Task_72994_Desc = {
    Text = "「단시간의 영원」을 사용하여 1회 승리를 획득하다"
  },
  Task_72995_Desc = {
    Text = "사용 「산호 여인의 죽음」을 획득하여 1회 승리"
  },
  Task_72997_Desc = {
    Text = "「오레타」를 사용하여 3회 승리"
  },
  Task_72999_Desc = {
    Text = "「장미의 승리」를 사용하여 3번 승리하기"
  },
  Task_73001_Desc = {
    Text = "사용해 「애정」 1회 승리 획득"
  },
  Task_73003_Desc = {
    Text = "「이사라우의 시선」을 사용하여 3번의 승리를 획득하기"
  },
  Task_73004_Desc = {
    Text = "「로드의 지팡이」를 사용하여 1번 승리를 획득"
  },
  Task_73006_Desc = {
    Text = "「행운의 시간」을 사용하여 3번 승리하기"
  },
  Task_73007_Desc = {
    Text = "「아그리파」를 사용하여 3회 승리"
  },
  Task_73009_Desc = {
    Text = "「눈이 녹을 때까지」 사용하여 1회 승리"
  },
  Task_73011_Desc = {
    Text = "「심의 방벽」 사용하여 1회 승리."
  },
  Task_73012_Desc = {
    Text = "「미리암」을 사용하여 3회 승리"
  },
  Task_73014_Desc = {
    Text = "「하멜른」을 사용하여 1회 승리"
  },
  Task_73015_Desc = {
    Text = "「해의 꿈」을 사용하여 3번 승리하기"
  },
  Task_73016_Desc = {
    Text = "사용 「섬망」 1번의 승리 획득"
  },
  Task_73018_Desc = {
    Text = "「해피 마법 쇼」를 사용하여 1번 승리하세요."
  },
  Task_73019_Desc = {
    Text = "「숙성」을 사용하여 1회 승리 획득"
  },
  Task_73021_Desc = {
    Text = "「순은의 초심」을 사용하여 1회 승리 획득"
  },
  Task_73022_Desc = {
    Text = "「돌」을 사용하여 1회 승리"
  },
  Task_73025_Desc = {
    Text = "사용 「나지막이 말하기」 1번의 승리를 획득"
  },
  Task_73026_Desc = {
    Text = "「활성화」 사용으로 1회 승리 획득。"
  },
  Task_73028_Desc = {
    Text = "「다포딜」을 사용하여 1회 승리"
  },
  Task_73030_Desc = {
    Text = "「윙클」을사용하여 3회 승리"
  },
  Task_73033_Desc = {
    Text = "「진홍색으로 침없다」를 사용하여 1번 승리했습니다"
  },
  Task_73037_Desc = {
    Text = "사용 「연쇄을 벗어던진 날」 3번 승리 획득"
  },
  Task_73039_Desc = {
    Text = "사용 「동야추억」 1회 승리를 획득"
  },
  Task_73041_Desc = {
    Text = "「은밀한 탄생」을 사용하여 1번 승리"
  },
  Task_73044_Desc = {
    Text = "「라이커」를 사용하여 3회 승리"
  },
  Task_73045_Desc = {
    Text = "「융해·돌」을 사용하여 1회 승리"
  },
  Task_73047_Desc = {
    Text = "「파인트」를 사용하여 1회 승리"
  },
  Task_73048_Desc = {
    Text = "「타이스」를 사용하여 3회 승리"
  },
  Task_73050_Desc = {
    Text = "「아이기스」를 사용하여 3회 승리"
  },
  Task_73051_Desc = {
    Text = "「오레타」를 사용하여 1회 승리"
  },
  Task_73052_Desc = {
    Text = "「산」을 사용하여 1회 승리"
  },
  Task_73053_Desc = {
    Text = "「머피」를 사용하여 1회 승리"
  },
  Task_73054_Desc = {
    Text = "「타비」를 사용하여 3회 승리"
  },
  Task_73055_Desc = {
    Text = "「돌」을 사용하여 3회 승리"
  },
  Task_73056_Desc = {
    Text = "「살바도르」를 사용하여 1회 승리"
  },
  Task_73057_Desc = {
    Text = "「유일한 씨앗」을 사용하여 3번의 승리를 거두기"
  },
  Task_73059_Desc = {
    Text = "「은코다의 결심」을 사용하여 3번 승리 획득하기"
  },
  Task_73061_Desc = {
    Text = "「컷팅과 피해」로 3번 승리"
  },
  Task_73063_Desc = {
    Text = "「자비로운 양육」을 사용하여 1번의 승리를 획득"
  },
  Task_73064_Desc = {
    Text = "사용 「징계」 획득 3번 승리"
  },
  Task_73066_Desc = {
    Text = "「운명의 룰렛」에서 3번 승리하기"
  },
  Task_73067_Desc = {
    Text = "「판디아」를 사용하여 1회 승리"
  },
  Task_73068_Desc = {
    Text = "「전부 그녀의」를 사용하여 1번 승리하기"
  },
  Task_73070_Desc = {
    Text = "사용 「거인의 횡포」 3번 승리 획득"
  },
  Task_73073_Desc = {
    Text = "「라모나」를 사용하여 3회 승리"
  },
  Task_73074_Desc = {
    Text = "「시첩의 끝구절」을 사용하여 1회 승리하기"
  },
  Task_73075_Desc = {
    Text = "「백색 후예」를 사용하여 3번 승리를 획득"
  },
  Task_73077_Desc = {
    Text = "「완다」를 사용하여 1회 승리"
  },
  Task_73081_Desc = {
    Text = "「성실타래한 위력」을 사용하여 1번 승리했습니다"
  },
  Task_73082_Desc = {
    Text = "사용 「메모리 스피럴」 1회 승리를 획득"
  },
  Task_73083_Desc = {
    Text = "「추적 시계」를 사용해서 3번 승리하기"
  },
  Task_73085_Desc = {
    Text = "「오를라」를 사용하여 1회 승리"
  },
  Task_73086_Desc = {
    Text = "사용 「모임의 순간」 획득 1회 승리"
  },
  Task_73087_Desc = {
    Text = "사용 「침묵의 연회」 3번 승리 획득"
  },
  Task_73088_Desc = {
    Text = "「폭우 속에서」를 사용하여 1회 승리하기"
  },
  Task_73089_Desc = {
    Text = "「로탄」을 사용하여 1회 승리"
  },
  Task_73090_Desc = {
    Text = "사용 「혈육의 광연」 승리 1회 획득"
  },
  Task_73095_Desc = {
    Text = "「카렌」을 사용하여 1회 승리"
  },
  Task_73097_Desc = {
    Text = "사용: 「욕망의 바다에서 떠돌기」 획득: 1회 승리"
  },
  Task_73098_Desc = {
    Text = "「카시아」를 사용하여 1회 승리"
  },
  Task_73099_Desc = {
    Text = "「중하의 꿈」을 사용하여 1회 승리"
  },
  Task_73100_Desc = {
    Text = "「소렐」을 사용하여 3회 승리"
  },
  Task_73102_Desc = {
    Text = "사용 「신왕의 찬가」 획득 1회 승리"
  },
  Task_73105_Desc = {
    Text = "「불평등한 교환」을 사용하여 3번 승리했습니다."
  },
  Task_73107_Desc = {
    Text = "사용 「기사의 마음」 획득 1번의 승리"
  },
  Task_73109_Desc = {
    Text = "「고주복」을 사용하여 3번 승리하기"
  },
  Task_73110_Desc = {
    Text = "「살바도르」를 사용하여 3회 승리"
  },
  Task_73111_Desc = {
    Text = "「별하늘의 수호수」를 사용하여 3번 승리"
  },
  Task_73117_Desc = {
    Text = "사용 「뼈를 갉아먹는 포옹」 획득 1 승리"
  },
  Task_73118_Desc = {
    Text = "「오레타의 보물」을 사용하여 1번 승리했습니다"
  },
  Task_73120_Desc = {
    Text = "사용 「도태우화」 획득 1회 승리"
  },
  Task_73122_Desc = {
    Text = "「회귀·라모나」를 사용하여 3회 승리"
  },
  Task_73123_Desc = {
    Text = "사용 「마지막 서약」으로 1회 승리 획득"
  },
  Task_73124_Desc = {
    Text = "사용 「방출」로 3번의 승리"
  },
  Task_73126_Desc = {
    Text = "사용 「기운」 획득 1회 승리"
  },
  Task_73128_Desc = {
    Text = "「욕심」으로 3번 승리"
  },
  Task_73129_Desc = {
    Text = "「카이커스」를 사용하여 1회 승리"
  },
  Task_73130_Desc = {
    Text = "「진리의 문」을 사용하여 3번 승리하기"
  },
  Task_73131_Desc = {
    Text = "사용 「장미의 이름으로」 1번 승리"
  },
  Task_73134_Desc = {
    Text = "「에리카」를 사용하여 3회 승리"
  },
  Task_73136_Desc = {
    Text = "사용 「죽음의 해부」 획득 3회 승리"
  },
  Task_73138_Desc = {
    Text = "「틴커트」를 사용하여 3회 승리"
  },
  Task_73139_Desc = {
    Text = "사용 「단시간의 영원」 3번 승리 획득"
  },
  Task_73140_Desc = {
    Text = "「직무 소재」를 사용하여 3번 승리."
  },
  Task_73141_Desc = {
    Text = "사용 「명우」로 1번 승리하기"
  },
  Task_73144_Desc = {
    Text = "「거인의 검」을 사용하여 3번 승리하기"
  },
  Task_73147_Desc = {
    Text = "「영원히 끝없는 연주」를 사용하여 3번 승리"
  },
  Task_73148_Desc = {
    Text = "「빙하 아래의 깊은 잠듦」을 사용해 3번의 승리를 획득"
  },
  Task_73150_Desc = {
    Text = "「릴리」를 사용하여 3회 승리"
  },
  Task_73151_Desc = {
    Text = "사용 「장미의 승리」로 1회 승리 획득"
  },
  Task_73152_Desc = {
    Text = "「회무진용」을 사용하여 3번 승리"
  },
  Task_73153_Desc = {
    Text = "「툴루」를 사용하여 1회 승리"
  },
  Task_73154_Desc = {
    Text = "사용 「희망」으로 1번 승리 획득"
  },
  Task_73156_Desc = {
    Text = "「레아」를 사용하여 3회 승리"
  },
  Task_73157_Desc = {
    Text = "「애정」으로 3번 승리 획득하기"
  },
  Task_73161_Desc = {
    Text = "「님피아」를 사용하여 3회 승리"
  },
  Task_73162_Desc = {
    Text = "「광란」으로 3번 승리하기"
  },
  Task_73165_Desc = {
    Text = "사용 「존재하지 않는 곳」 획득 1회 승리"
  },
  Task_73166_Desc = {
    Text = "「파로스」를 사용하여 3회 승리"
  },
  Task_73167_Desc = {
    Text = "「히로」를 사용하여 1회 승리"
  },
  Task_73170_Desc = {
    Text = "「툴루」를 사용하여 3회 승리"
  },
  Task_73172_Desc = {
    Text = "「흡입」를 사용하여 3번의 승리를 획득하세요."
  },
  Task_73173_Desc = {
    Text = "사용 「인도의 돛」 획득 1회 승리"
  },
  Task_73174_Desc = {
    Text = "「모임의 순간」을 사용하여 3번의 승리를 획득"
  },
  Task_73176_Desc = {
    Text = "「셀레스트」를 사용하여 1회 승리"
  },
  Task_73177_Desc = {
    Text = "「산」을 사용하여 3회 승리"
  },
  Task_73178_Desc = {
    Text = "「통찰」을 사용하여 1회 승리 획득"
  },
  Task_73180_Desc = {
    Text = "「영원한 레퀴엠」 사용하여 3번의 승리 획득"
  },
  Task_73181_Desc = {
    Text = "「완성할 수 없는 계산」을 사용하여 3번 승리하기"
  },
  Task_73182_Desc = {
    Text = "「아그리파」를 사용하여 1회 승리"
  },
  Task_73183_Desc = {
    Text = "사용 「속박된 노래」 3번 승리 획득"
  },
  Task_73185_Desc = {
    Text = "「극야와 새벽」을 사용하여 3번 승리"
  },
  Task_73186_Desc = {
    Text = "「집중력」으로 1번 승리"
  },
  Task_73189_Desc = {
    Text = "「무한으로 떨어지는 인형」을 사용해서 3번 승리하기"
  },
  Task_73192_Desc = {
    Text = "「밤의 그림자에 숨어서」로 1회 승리"
  },
  Task_73193_Desc = {
    Text = "「기억증후군」 사용으로 1회 승리"
  },
  Task_73197_Desc = {
    Text = "사용 「망각의 손」 3번 승리 획득"
  },
  Task_73200_Desc = {
    Text = "「모험의 가방」을 사용하여 1회 승리 획득"
  },
  Task_73204_Desc = {
    Text = "「혈쇄·히로」를 사용하여 3회 승리"
  },
  Task_73206_Desc = {
    Text = "사용하여 「포식의 요람」으로 3번의 승리를 획득"
  },
  Task_73208_Desc = {
    Text = "「융해·돌」을 사용하여 3회 승리"
  },
  Task_73209_Desc = {
    Text = "「산호 여인의 죽음」으로 3회 승리 달성"
  },
  Task_73210_Desc = {
    Text = "「오지에」를 사용하여 1회 승리"
  },
  Task_73212_Desc = {
    Text = "「자비로운 양육」을 사용하여 3번 승리 획득"
  },
  Task_73213_Desc = {
    Text = "「크리티컬 포인트」를 사용하여 3번의 승리를 획득"
  },
  Task_73214_Desc = {
    Text = "「나의 소중한 친구에게」를 사용하여 3번 승리"
  },
  Task_73216_Desc = {
    Text = "「진홍색으로 침잠하다」를 사용하여 3번의 승리를 획득"
  },
  Task_73217_Desc = {
    Text = "사용 「컷팅과 피해」 1승 획득"
  },
  Task_73218_Desc = {
    Text = "「회무진용」을 사용하여 1번의 승리를 획득했습니다"
  },
  Task_73219_Desc = {
    Text = "「머릿속의 목소리」를 사용하여 3회 승리"
  },
  Task_73220_Desc = {
    Text = "「로드의 지팡이」를 사용해 3번 승리하기"
  },
  Task_73222_Desc = {
    Text = "「망각의 손」을 사용하여 한 번 승리"
  },
  Task_73223_Desc = {
    Text = "「젠킨」을 사용하여 3회 승리"
  },
  Task_73224_Desc = {
    Text = "「미리암」을 사용하여 1회 승리"
  },
  Task_73225_Desc = {
    Text = "「행운의 시간」 사용으로 1회 승리 획득"
  },
  Task_73227_Desc = {
    Text = "「미친 길」을 사용하여 1회 승리"
  },
  Task_73228_Desc = {
    Text = "「엘바」를 사용하여 1회 승리"
  },
  Task_73229_Desc = {
    Text = "「신언 석판」을 사용하여 1회 승리 획득"
  },
  Task_73232_Desc = {
    Text = "「등장」 사용: 3번의 승리 획득"
  },
  Task_73233_Desc = {
    Text = "「유우하시」를 사용하여 3회 승리"
  },
  Task_73235_Desc = {
    Text = "사용 「35mm의 마법」을 획득하여 3번 승리"
  },
  Task_73236_Desc = {
    Text = "「부패의 선물」을 사용하여 1번의 승리를 획득합니다"
  },
  Task_73237_Desc = {
    Text = "「욕심」으로 1번 승리"
  },
  Task_73241_Desc = {
    Text = "사용 「존재하지 않는 곳」 3번 승리 획득"
  },
  Task_73243_Desc = {
    Text = "「리즈」를 사용하여 3회 승리"
  },
  Task_73246_Desc = {
    Text = "사용 「은둔의 전륜」 1번 승리 획득"
  },
  Task_73249_Desc = {
    Text = "「머릿속의 목소리」를 사용하여 1회 승리"
  },
  Task_73250_Desc = {
    Text = "「24」를 사용하여 1회 승리"
  },
  Task_73253_Desc = {
    Text = "「견고한 의지」를 사용하여 3번 승리했습니다."
  },
  Task_73254_Desc = {
    Text = "사용 「이형체 회흡」 획득 3회 승리"
  },
  Task_73257_Desc = {
    Text = "「타이스」를 사용하여 1회 승리"
  },
  Task_73259_Desc = {
    Text = "「파인트」를 사용하여 3회 승리"
  },
  Task_73260_Desc = {
    Text = "「타비」를 사용하여 1회 승리"
  },
  Task_73262_Desc = {
    Text = "「아이기스」를 사용하여 1회 승리"
  },
  Task_73266_Desc = {
    Text = "「은코다의 결심」을 사용하여 한 번 승리"
  },
  Task_73267_Desc = {
    Text = "「로탄」을 사용하여 3회 승리"
  },
  Task_73268_Desc = {
    Text = "「유일한 씨앗」을 사용하여 1번 승리하기"
  },
  Task_73269_Desc = {
    Text = "사용 「징계」로 1번 승리"
  },
  Task_73270_Desc = {
    Text = "사용 「상처받은 지느러미」 획득 1의 승리"
  },
  Task_73271_Desc = {
    Text = "「중하의 꿈」을 사용하여 3번 승리"
  },
  Task_73278_Desc = {
    Text = "「거인의 횡포」로 1번 승리."
  },
  Task_73279_Desc = {
    Text = "「에리카」를 사용하여 1회 승리"
  },
  Task_73280_Desc = {
    Text = "「방출」 사용으로 1번 승리 획득"
  },
  Task_73281_Desc = {
    Text = "「해의 꿈」을 사용하여 1번 승리를 획득"
  },
  Task_73282_Desc = {
    Text = "「눈이 녹을 때까지」를 사용해서 3번 승리하기"
  },
  Task_73284_Desc = {
    Text = "「운명의 룰렛」을 사용하여 1번 승리 획득"
  },
  Task_73285_Desc = {
    Text = "사용 「진리의 문」 획득 1회 승리"
  },
  Task_73286_Desc = {
    Text = "「라모나」를 사용하여 1회 승리"
  },
  Task_73287_Desc = {
    Text = "「판디아」를 사용하여 3회 승리"
  },
  Task_73288_Desc = {
    Text = "「장미의 이름으로」를 사용하여 3번의 승리를 획득하기"
  },
  Task_73289_Desc = {
    Text = "「전부 그녀의」를 사용하여 3회 승리하기"
  },
  Task_73290_Desc = {
    Text = "「완다」를 사용하여 3회 승리"
  },
  Task_73292_Desc = {
    Text = "「시첩의 끝구절」을 사용하여 3회 승리하기"
  },
  Task_73293_Desc = {
    Text = "「백색 후예」를 사용하여 1번 승리했습니다"
  },
  Task_73294_Desc = {
    Text = "「틴커트」를 사용하여 1회 승리"
  },
  Task_73296_Desc = {
    Text = "「코어 용해」를 사용하여 1회 승리 획득"
  },
  Task_73297_Desc = {
    Text = "「신적 강림」을 사용하여 1번 승리"
  },
  Task_73298_Desc = {
    Text = "「포효하는 피와 모래」로 1회 승리하기"
  },
  Task_73299_Desc = {
    Text = "「젠킨」을 사용하여 1회 승리"
  },
  Task_73302_Desc = {
    Text = "「나지막이 말하기」를 사용하여 3번의 승리를 획득"
  },
  Task_73303_Desc = {
    Text = "사용 「여왕의 계율」로 1회 승리 획득"
  },
  Task_73305_Desc = {
    Text = "“숙성”을 사용하여 3번 승리”"
  },
  Task_73306_Desc = {
    Text = "「통증을 넘어서」를 사용하여 1번 승리를 획득"
  },
  Task_73309_Desc = {
    Text = "사용 「침묵의 연회」 획득 1회 승리"
  },
  Task_73311_Desc = {
    Text = "「미친 길」을 사용하여 3번의 승리를 획득하다"
  },
  Task_73312_Desc = {
    Text = "「골리아」를 사용하여 3회 승리"
  },
  Task_73313_Desc = {
    Text = "「도태우화」 사용하여 3번 승리."
  },
  Task_73314_Desc = {
    Text = "「윙클」을사용하여 1회 승리"
  },
  Task_73315_Desc = {
    Text = "「백만 몬스터의 눈」을 사용해 3번 승리하기"
  },
  Task_73316_Desc = {
    Text = "「다포딜」을 사용하여 3회 승리"
  },
  Task_73317_Desc = {
    Text = "「정보는 생명이다」로 1회 승리한다."
  },
  Task_73318_Desc = {
    Text = "「라이커」를 사용하여 1회 승리"
  },
  Task_73321_Desc = {
    Text = "「오를라」를 사용하여 3회 승리"
  },
  Task_73322_Desc = {
    Text = "「가장 소중한 수집품」을 사용하여 1회 승리하기"
  },
  Task_73323_Desc = {
    Text = "「노틸라」를 사용하여 3회 승리"
  },
  Task_73324_Desc = {
    Text = "사용 「호수에서 돌아보기」 3번 승리 획득"
  },
  Task_73325_Desc = {
    Text = "사용 「죽음 너머로」 1 회 승리 획득"
  },
  Task_73326_Desc = {
    Text = "「동야추억」을 사용하여 3번의 승리를 거두기"
  },
  Task_73327_Desc = {
    Text = "「모험의 가방」을 사용하여 3번 승리하기"
  },
  Task_73328_Desc = {
    Text = "「골리아」를 사용하여 1회 승리"
  },
  Task_73330_Desc = {
    Text = "「고주복」을 사용하여 1번 승리합니다"
  },
  Task_73333_Desc = {
    Text = "「완성할 수 없는 계산」 사용으로 1회 승리 획득"
  },
  Task_73334_Desc = {
    Text = "「별하늘의 수호수」를 사용하여 1회 승리했습니다."
  },
  Task_73335_Desc = {
    Text = "「신적 강림」을 사용하여 3번의 승리를 획득하세요."
  },
  Task_73338_Desc = {
    Text = "「무한으로 떨어지는 인형」을 사용하여 1회 승리 획득"
  },
  Task_73341_Desc = {
    Text = "「머피」를 사용하여 3회 승리"
  },
  Task_73343_Desc = {
    Text = "「극야와 새벽」을 사용하여 1번 승리"
  },
  Task_73345_Desc = {
    Text = "「이사라우의 시선」을 사용하여 1번 승리"
  },
  Task_73346_Desc = {
    Text = "「집중력」을 사용하여 3번 승리를 거둠"
  },
  Task_73349_Desc = {
    Text = "사용 「뼈를 갉아먹는 포옹」 획득 3번 승리"
  },
  Task_73352_Desc = {
    Text = "‘밤의 그림자에 숨어서’를 사용하여 3번 승리"
  },
  Task_73353_Desc = {
    Text = "사용 「기운」 3승 얻기"
  },
  Task_73354_Desc = {
    Text = "「노틸라」를 사용하여 1회 승리"
  },
  Task_73355_Desc = {
    Text = "「회귀·라모나」를 사용하여 1회 승리"
  },
  Task_73356_Desc = {
    Text = "「오레타의 보물」을 사용하여 3번의 승리를 획득하기"
  },
  Task_73357_Desc = {
    Text = "사용 「마지막 서약」으로 3번 승리하기"
  },
  Task_73359_Desc = {
    Text = "「카이커스」를 사용하여 3회 승리"
  },
  Task_73360_Desc = {
    Text = "사용 「죽음의 해부」 획득 1 승리"
  },
  Task_73362_Desc = {
    Text = "「해피 마법 쇼」를 사용하여 3번의 승리를 거두기"
  },
  Task_73363_Desc = {
    Text = "「님피아」를 사용하여 1회 승리"
  },
  Task_73366_Desc = {
    Text = "「추적 시계」를 사용하여 1회 승리 획득."
  },
  Task_73369_Desc = {
    Text = "사용 「섬망」 획득의 3번 승리"
  },
  Task_73370_Desc = {
    Text = "「하멜른」을 사용하여 3회 승리"
  },
  Task_73372_Desc = {
    Text = "「순은의 초심」을 사용하여 3번 승리하기"
  },
  Task_73374_Desc = {
    Text = "「카렌」을 사용하여 3회 승리"
  },
  Task_73377_Desc = {
    Text = "「불평등한 교환」을 사용하여 1회 승리 획득"
  },
  Task_73379_Desc = {
    Text = "「소렐」을 사용하여 1회 승리"
  },
  Task_73380_Desc = {
    Text = "「카시아」를 사용하여 3회 승리"
  },
  Task_73382_Desc = {
    Text = "「연쇄을 벗어던진 날」을 사용하여 1회 승리 획득"
  },
  Task_73387_Desc = {
    Text = "「은밀한 탄생」을 사용하여 3번 승리"
  },
  Task_73388_Desc = {
    Text = "사용 「심의 방벽」 3번 승리 획득"
  },
  Task_73390_Desc = {
    Text = "「상처받은 지느러미」를 사용해 3번 승리하기"
  },
  Task_73392_Desc = {
    Text = "「유우하시」를 사용하여 1회 승리"
  },
  Task_73394_Desc = {
    Text = "「성실타래한 위력」을 사용하여 3번의 승리를 획득"
  },
  Task_73395_Desc = {
    Text = "「혈쇄·히로」를 사용하여 1회 승리"
  },
  Task_73396_Desc = {
    Text = "「신언 석판」을 사용하여 3번의 승리를 획득하세요."
  },
  Task_73400_Desc = {
    Text = "「영원한 레퀴엠」을 사용하여 1번 승리"
  },
  Task_73404_Desc = {
    Text = "「거울 속의 사람」을 사용하여 1번 승리하기"
  },
  Task_73405_Desc = {
    Text = "「폭우 속에서」를 사용하여 3번 승리"
  },
  Task_73407_Desc = {
    Text = "「부패의 선물」을 사용하여 3번 승리하기"
  },
  Task_73409_Desc = {
    Text = "「셀레스트」를 사용하여 3회 승리"
  },
  Task_73410_Desc = {
    Text = "사용 「통찰력」 획득 3번 승리"
  },
  Task_73413_Desc = {
    Text = "「속박된 노래」를 사용하여 1회 승리"
  },
  Task_73417_Desc = {
    Text = "「기억증후군」을 사용하여 3번의 승리를 획득하세요"
  },
  Task_73418_Desc = {
    Text = "「거울 속의 사람」을 사용하여 3번의 승리를 거두기"
  },
  Task_73422_Desc = {
    Text = "「24」를 사용하여 3회 승리"
  },
  Task_73425_Desc = {
    Text = "「견고한 의지」를 사용하여 1번 승리했습니다"
  },
  Task_73426_Desc = {
    Text = "「엘바」를 사용하여 3회 승리"
  },
  Task_73427_Desc = {
    Text = "사용 「광란」으로 1번 승리하기"
  },
  Task_73430_Desc = {
    Text = "「활성화」 사용으로 3번의 승리 획득"
  },
  Task_73431_Desc = {
    Text = "「영원히 끝없는 연주」를 사용하여 한 번의 승리를 획득"
  },
  Task_73432_Desc = {
    Text = "사용 「직무 소재」로 1회 승리를 획득"
  },
  Task_73433_Desc = {
    Text = "사용 「명우」로 3번의 승리를 획득하기"
  },
  Task_73435_Desc = {
    Text = "사용 「메모리 스피럴」 3번 승리 획득"
  },
  Task_73437_Desc = {
    Text = "사용 「희망」 3번 승리를 획득"
  },
  Task_73440_Desc = {
    Text = "사용 「빙하 아래의 깊은 잠듦」 획득 의 1회 승리"
  },
  Task_73442_Desc = {
    Text = "「혈육의 광연」 사용하여 3번의 승리 획득"
  },
  Task_73444_Desc = {
    Text = "「욕망의 바다에서 떠돌기」를 사용해 3번 승리하기"
  },
  Task_73445_Desc = {
    Text = "「레아」를 사용하여 1회 승리"
  },
  Task_73451_Desc = {
    Text = "「히로」를 사용하여 3회 승리"
  },
  Task_73453_Desc = {
    Text = "「인도의 돛」을 사용하여 3번 승리하기"
  },
  Task_73456_Desc = {
    Text = "「파로스」를 사용하여 1회 승리"
  },
  Task_73457_Desc = {
    Text = "「기사의 마음」을 사용하여 3번의 승리를 거두기"
  },
  Task_73459_Desc = {
    Text = "「신왕의 찬가」를 사용하여 3번 승리"
  },
  Task_73462_Desc = {
    Text = "‘흡입’ 사용하여 1회 승리 획득"
  },
  Task_73584_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_73584_Name = {Text = "10승"},
  Task_73585_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_73585_Name = {Text = "1승"},
  Task_73586_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_73586_Name = {Text = "6승"},
  Task_73587_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_73587_Name = {Text = "3승"},
  Task_73588_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73588_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73589_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73589_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73590_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73590_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73591_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73591_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73592_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73592_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73593_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73593_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73594_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73594_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73595_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73595_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73596_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73596_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73597_Desc = {
    Text = "마법의 도토리를 획득하다"
  },
  Task_73597_UnlockCondDesc = {
    Text = "완료 시 '턴 역전: 역전의 순간' 해금, '턴 역전'으로 전향하시겠습니까?"
  },
  Task_73672_Desc = {
    Text = "본원 도르를 획득할 때 2 기령"
  },
  Task_73672_Name = {
    Text = "본원 도르를 획득할 때 2 기령"
  },
  Task_73672_UnlockCondDesc = {
    Text = "활동@깨어남체 본원 도르 기령 선물 패키지 0"
  },
  Task_73673_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_73674_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_73676_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_73677_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_73679_Desc = {
    Text = "본원 도르를 획득할 때 기령 +6"
  },
  Task_73679_Name = {
    Text = "본원 도르를 획득할 때 기령 +6"
  },
  Task_73679_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 도르 기령 선물 2 이벤트"
  },
  Task_73686_Desc = {
    Text = "용해·도르 동조율이 10급에 도달"
  },
  Task_73880_Desc = {
    Text = "융해·돌을 따라 「답」 확인하기"
  },
  Task_73880_Name = {Text = "목표"},
  Task_73881_Desc = {
    Text = "변이된 사라 제압"
  },
  Task_73881_Name = {Text = "목표"},
  Task_73882_Desc = {
    Text = "B-68호 융해·돌 격파"
  },
  Task_73882_Name = {Text = "목표"},
  Task_73883_Desc = {
    Text = "눈앞의 차원 세계 탐색하기"
  },
  Task_73883_Name = {Text = "목표"},
  Task_73884_Desc = {
    Text = "젠킨을 조용히 시키기"
  },
  Task_73884_Name = {Text = "목표"},
  Task_73885_Desc = {
    Text = "융해·돌 구속하기"
  },
  Task_73885_Name = {Text = "목표"},
  Task_73886_Desc = {
    Text = "종탑 방어"
  },
  Task_73886_Name = {Text = "목표"},
  Task_73887_Desc = {
    Text = "빈민원 복도의 변이체 제거"
  },
  Task_73887_Name = {Text = "목표"},
  Task_73888_Desc = {
    Text = "유리에트로부터 살바도르 구출하기"
  },
  Task_73888_Name = {Text = "목표"},
  Task_73889_Desc = {
    Text = "구세 대성당으로 향하는 길 열기"
  },
  Task_73889_Name = {Text = "목표"},
  Task_74202_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74203_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74204_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74205_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74206_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74207_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74208_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74210_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74211_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74212_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_74222_Desc = {
    Text = "의식 잠수 「대관의 날」 완료"
  },
  Task_74222_Name = {
    Text = "왕권은 영원하다"
  },
  Task_74223_Desc = {
    Text = "조사 완료: 사건 「재림 안개도시」 어려움 난이도"
  },
  Task_74223_Name = {
    Text = "회색 밤에 잃어버리지 마세요·어려움"
  },
  Task_74224_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 10회"
  },
  Task_74224_Desc2 = {
    Text = "조사 이벤트 「재림 안개도시」에서 공명 10회"
  },
  Task_74224_Name2 = {
    Text = "공허한 울림Ⅳ"
  },
  Task_74225_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_74225_Desc2 = {
    Text = "조사 완료 이벤트 「재림 안개도시」"
  },
  Task_74225_Name2 = {
    Text = "회색 밤에 잃어버리지 마세요"
  },
  Task_74226_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_74226_Desc2 = {
    Text = "조사 이벤트 「재림 안개도시」에서 총 공명 3회"
  },
  Task_74226_Name2 = {
    Text = "공허한 울림"
  },
  Task_74227_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_74227_Desc2 = {
    Text = "조사 이벤트 「재림 안개도시」에서 총 공명 6회"
  },
  Task_74227_Name2 = {
    Text = "공허한 울림Ⅱ"
  },
  Task_74228_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 8회 발생했습니다"
  },
  Task_74228_Desc2 = {
    Text = "조사 이벤트 「재림 안개도시」에서 총 공명 8회"
  },
  Task_74228_Name2 = {
    Text = "공허한 울림Ⅲ"
  },
  Task_74235_Desc = {
    Text = "리즈를 찾다"
  },
  Task_74235_Name = {Text = "목표"},
  Task_74295_Desc = {
    Text = "의식 잠수 「열정은 먼지로」 완료"
  },
  Task_74295_Name = {
    Text = "청염회무"
  },
  Task_74296_Desc = {
    Text = "의식 잠수 「열정이 먼지로 돌아가다」 어려움 완료"
  },
  Task_74296_Name = {
    Text = "청염회무·어려움"
  },
  Task_74332_Name = {
    Text = "턴 역전 이벤트 끝"
  },
  Task_74333_Desc = {
    Text = "클리어 턴 역전 스토리 제2장"
  },
  Task_74333_UnlockCondDesc = {
    Text = "수령 「라운드 특별상: 포인트 1200 달성」 후 해금"
  },
  Task_74334_Desc = {
    Text = "클리어 턴 역전 스토리 서장"
  },
  Task_74335_Desc = {
    Text = "클리어 턴 역전 스토리 제3장"
  },
  Task_74335_UnlockCondDesc = {
    Text = "수령 「라운드 특별상: 포인트 2400 달성」 후 해금"
  },
  Task_74342_Desc = {
    Text = "수호 캐릭터의 카드 25장 사용"
  },
  Task_74343_Desc = {
    Text = "흉성 캐릭터의 카드 25장 사용"
  },
  Task_74344_Desc = {
    Text = "축복 캐릭터의 카드 25장 사용"
  },
  Task_74345_Desc = {
    Text = "영지 캐릭터의 카드 25장 사용"
  },
  Task_74346_Desc = {
    Text = "투쟁 캐릭터의 카드 25장 사용"
  },
  Task_74375_Desc = {
    Text = "투쟁 캐릭터의 카드 1750장 사용"
  },
  Task_74376_Desc = {
    Text = "축복 캐릭터의 카드 400장 사용"
  },
  Task_74377_Desc = {
    Text = "영지 캐릭터의 카드 1225장 사용"
  },
  Task_74378_Desc = {
    Text = "흉성 캐릭터의 카드 1125장 사용"
  },
  Task_74379_Desc = {
    Text = "흉성 캐릭터의 카드 775장 사용"
  },
  Task_74380_Desc = {
    Text = "축복 캐릭터의 카드 1775장 사용"
  },
  Task_74381_Desc = {
    Text = "투쟁 캐릭터의 카드 775장 사용"
  },
  Task_74382_Desc = {
    Text = "영지 캐릭터의 카드 700장 사용"
  },
  Task_74383_Desc = {
    Text = "수호 캐릭터의 카드 1875장 사용"
  },
  Task_74384_Desc = {
    Text = "축복 캐릭터의 카드 825장 사용"
  },
  Task_74385_Desc = {
    Text = "투쟁 캐릭터의 카드 1800장 사용"
  },
  Task_74386_Desc = {
    Text = "투쟁 캐릭터의 카드 1200장 사용"
  },
  Task_74387_Desc = {
    Text = "축복 캐릭터의 카드 775장 사용"
  },
  Task_74388_Desc = {
    Text = "영지 캐릭터의 카드 525장 사용"
  },
  Task_74389_Desc = {
    Text = "영지 캐릭터의 카드 1600장 사용"
  },
  Task_74390_Desc = {
    Text = "축복 캐릭터의 카드 675장 사용"
  },
  Task_74391_Desc = {
    Text = "투쟁 캐릭터의 카드 1975장 사용"
  },
  Task_74392_Desc = {
    Text = "수호 캐릭터의 카드 1525장 사용"
  },
  Task_74393_Desc = {
    Text = "흉성 캐릭터의 카드 1325장 사용"
  },
  Task_74394_Desc = {
    Text = "흉성 캐릭터의 카드 1550장 사용"
  },
  Task_74395_Desc = {
    Text = "축복 캐릭터의 카드 1125장 사용"
  },
  Task_74396_Desc = {
    Text = "흉성 캐릭터의 카드 125장 사용"
  },
  Task_74397_Desc = {
    Text = "흉성 캐릭터의 카드 1600장 사용"
  },
  Task_74398_Desc = {
    Text = "축복 캐릭터의 카드 650장 사용"
  },
  Task_74399_Desc = {
    Text = "흉성 캐릭터의 카드 325장 사용"
  },
  Task_74400_Desc = {
    Text = "축복 캐릭터의 카드 1325장 사용"
  },
  Task_74401_Desc = {
    Text = "축복 캐릭터의 카드 150장 사용"
  },
  Task_74402_Desc = {
    Text = "흉성 캐릭터의 카드 50장 사용"
  },
  Task_74403_Desc = {
    Text = "축복 캐릭터의 카드 2000장 사용"
  },
  Task_74404_Desc = {
    Text = "투쟁 캐릭터의 카드 850장 사용"
  },
  Task_74405_Desc = {
    Text = "축복 캐릭터의 카드 1150장 사용"
  },
  Task_74406_Desc = {
    Text = "흉성 캐릭터의 카드 150장 사용"
  },
  Task_74407_Desc = {
    Text = "수호 캐릭터의 카드 550장 사용"
  },
  Task_74408_Desc = {
    Text = "흉성 캐릭터의 카드 800장 사용"
  },
  Task_74409_Desc = {
    Text = "투쟁 캐릭터의 카드 100장 사용"
  },
  Task_74410_Desc = {
    Text = "수호 캐릭터의 카드 1600장 사용"
  },
  Task_74411_Desc = {
    Text = "영지 캐릭터의 카드 1300장 사용"
  },
  Task_74412_Desc = {
    Text = "축복 캐릭터의 카드 1850장 사용"
  },
  Task_74413_Desc = {
    Text = "영지 캐릭터의 카드 1525장 사용"
  },
  Task_74414_Desc = {
    Text = "수호 캐릭터의 카드 1425장 사용"
  },
  Task_74415_Desc = {
    Text = "수호 캐릭터의 카드 1275장 사용"
  },
  Task_74416_Desc = {
    Text = "영지 캐릭터의 카드 925장 사용"
  },
  Task_74417_Desc = {
    Text = "수호 캐릭터의 카드 800장 사용"
  },
  Task_74418_Desc = {
    Text = "영지 캐릭터의 카드 1625장 사용"
  },
  Task_74419_Desc = {
    Text = "영지 캐릭터의 카드 1775장 사용"
  },
  Task_74420_Desc = {
    Text = "축복 캐릭터의 카드 1100장 사용"
  },
  Task_74421_Desc = {
    Text = "흉성 캐릭터의 카드 100장 사용"
  },
  Task_74422_Desc = {
    Text = "영지 캐릭터의 카드 1750장 사용"
  },
  Task_74423_Desc = {
    Text = "영지 캐릭터의 카드 1125장 사용"
  },
  Task_74424_Desc = {
    Text = "영지 캐릭터의 카드 750장 사용"
  },
  Task_74425_Desc = {
    Text = "흉성 캐릭터의 카드 1725장 사용"
  },
  Task_74426_Desc = {
    Text = "투쟁 캐릭터의 카드 1150장 사용"
  },
  Task_74427_Desc = {
    Text = "영지 캐릭터의 카드 175장 사용"
  },
  Task_74428_Desc = {
    Text = "흉성 캐릭터의 카드 1625장 사용"
  },
  Task_74429_Desc = {
    Text = "축복 캐릭터의 카드 425장 사용"
  },
  Task_74430_Desc = {
    Text = "영지 캐릭터의 카드 1700장 사용"
  },
  Task_74431_Desc = {
    Text = "투쟁 캐릭터의 카드 1325장 사용"
  },
  Task_74432_Desc = {
    Text = "축복 캐릭터의 카드 1225장 사용"
  },
  Task_74433_Desc = {
    Text = "흉성 캐릭터의 카드 225장 사용"
  },
  Task_74434_Desc = {
    Text = "투쟁 캐릭터의 카드 1875장 사용"
  },
  Task_74435_Desc = {
    Text = "영지 캐릭터의 카드 725장 사용"
  },
  Task_74436_Desc = {
    Text = "영지 캐릭터의 카드 325장 사용"
  },
  Task_74437_Desc = {
    Text = "영지 캐릭터의 카드 1350장 사용"
  },
  Task_74438_Desc = {
    Text = "수호 캐릭터의 카드 1725장 사용"
  },
  Task_74439_Desc = {
    Text = "투쟁 캐릭터의 카드 1375장 사용"
  },
  Task_74440_Desc = {
    Text = "수호 캐릭터의 카드 925장 사용"
  },
  Task_74441_Desc = {
    Text = "흉성 캐릭터의 카드 1950장 사용"
  },
  Task_74442_Desc = {
    Text = "투쟁 캐릭터의 카드 450장 사용"
  },
  Task_74443_Desc = {
    Text = "수호 캐릭터의 카드 175장 사용"
  },
  Task_74444_Desc = {
    Text = "수호 캐릭터의 카드 1100장 사용"
  },
  Task_74445_Desc = {
    Text = "수호 캐릭터의 카드 450장 사용"
  },
  Task_74446_Desc = {
    Text = "투쟁 캐릭터의 카드 1225장 사용"
  },
  Task_74447_Desc = {
    Text = "영지 캐릭터의 카드 1475장 사용"
  },
  Task_74448_Desc = {
    Text = "수호 캐릭터의 카드 1250장 사용"
  },
  Task_74449_Desc = {
    Text = "영지 캐릭터의 카드 100장 사용"
  },
  Task_74450_Desc = {
    Text = "투쟁 캐릭터의 카드 975장 사용"
  },
  Task_74451_Desc = {
    Text = "축복 캐릭터의 카드 800장 사용"
  },
  Task_74452_Desc = {
    Text = "흉성 캐릭터의 카드 1875장 사용"
  },
  Task_74453_Desc = {
    Text = "투쟁 캐릭터의 카드 900장 사용"
  },
  Task_74454_Desc = {
    Text = "수호 캐릭터의 카드 1950장 사용"
  },
  Task_74455_Desc = {
    Text = "수호 캐릭터의 카드 1000장 사용"
  },
  Task_74456_Desc = {
    Text = "투쟁 캐릭터의 카드 1925장 사용"
  },
  Task_74457_Desc = {
    Text = "영지 캐릭터의 카드 1825장 사용"
  },
  Task_74458_Desc = {
    Text = "투쟁 캐릭터의 카드 1725장 사용"
  },
  Task_74459_Desc = {
    Text = "흉성 캐릭터의 카드 1500장 사용"
  },
  Task_74460_Desc = {
    Text = "흉성 캐릭터의 카드 1375장 사용"
  },
  Task_74461_Desc = {
    Text = "수호 캐릭터의 카드 350장 사용"
  },
  Task_74462_Desc = {
    Text = "흉성 캐릭터의 카드 1975장 사용"
  },
  Task_74463_Desc = {
    Text = "수호 캐릭터의 카드 625장 사용"
  },
  Task_74464_Desc = {
    Text = "수호 캐릭터의 카드 500장 사용"
  },
  Task_74465_Desc = {
    Text = "영지 캐릭터의 카드 1200장 사용"
  },
  Task_74466_Desc = {
    Text = "영지 캐릭터의 카드 775장 사용"
  },
  Task_74467_Desc = {
    Text = "영지 캐릭터의 카드 975장 사용"
  },
  Task_74468_Desc = {
    Text = "영지 캐릭터의 카드 1550장 사용"
  },
  Task_74469_Desc = {
    Text = "영지 캐릭터의 카드 2000장 사용"
  },
  Task_74470_Desc = {
    Text = "흉성 캐릭터의 카드 1050장 사용"
  },
  Task_74471_Desc = {
    Text = "수호 캐릭터의 카드 1700장 사용"
  },
  Task_74472_Desc = {
    Text = "투쟁 캐릭터의 카드 1500장 사용"
  },
  Task_74473_Desc = {
    Text = "축복 캐릭터의 카드 75장 사용"
  },
  Task_74474_Desc = {
    Text = "축복 캐릭터의 카드 550장 사용"
  },
  Task_74475_Desc = {
    Text = "영지 캐릭터의 카드 150장 사용"
  },
  Task_74476_Desc = {
    Text = "투쟁 캐릭터의 카드 1575장 사용"
  },
  Task_74477_Desc = {
    Text = "영지 캐릭터의 카드 425장 사용"
  },
  Task_74478_Desc = {
    Text = "수호 캐릭터의 카드 950장 사용"
  },
  Task_74479_Desc = {
    Text = "수호 캐릭터의 카드 700장 사용"
  },
  Task_74480_Desc = {
    Text = "투쟁 캐릭터의 카드 1175장 사용"
  },
  Task_74481_Desc = {
    Text = "투쟁 캐릭터의 카드 700장 사용"
  },
  Task_74482_Desc = {
    Text = "축복 캐릭터의 카드 1275장 사용"
  },
  Task_74483_Desc = {
    Text = "영지 캐릭터의 카드 625장 사용"
  },
  Task_74484_Desc = {
    Text = "흉성 캐릭터의 카드 275장 사용"
  },
  Task_74485_Desc = {
    Text = "수호 캐릭터의 카드 1575장 사용"
  },
  Task_74486_Desc = {
    Text = "수호 캐릭터의 카드 1400장 사용"
  },
  Task_74487_Desc = {
    Text = "투쟁 캐릭터의 카드 1675장 사용"
  },
  Task_74488_Desc = {
    Text = "영지 캐릭터의 카드 1075장 사용"
  },
  Task_74489_Desc = {
    Text = "수호 캐릭터의 카드 325장 사용"
  },
  Task_74490_Desc = {
    Text = "축복 캐릭터의 카드 1025장 사용"
  },
  Task_74491_Desc = {
    Text = "영지 캐릭터의 카드 1025장 사용"
  },
  Task_74492_Desc = {
    Text = "영지 캐릭터의 카드 1050장 사용"
  },
  Task_74493_Desc = {
    Text = "수호 캐릭터의 카드 600장 사용"
  },
  Task_74494_Desc = {
    Text = "영지 캐릭터의 카드 1900장 사용"
  },
  Task_74495_Desc = {
    Text = "수호 캐릭터의 카드 125장 사용"
  },
  Task_74496_Desc = {
    Text = "영지 캐릭터의 카드 200장 사용"
  },
  Task_74497_Desc = {
    Text = "축복 캐릭터의 카드 1575장 사용"
  },
  Task_74498_Desc = {
    Text = "흉성 캐릭터의 카드 575장 사용"
  },
  Task_74499_Desc = {
    Text = "투쟁 캐릭터의 카드 800장 사용"
  },
  Task_74500_Desc = {
    Text = "영지 캐릭터의 카드 1275장 사용"
  },
  Task_74501_Desc = {
    Text = "수호 캐릭터의 카드 1625장 사용"
  },
  Task_74502_Desc = {
    Text = "축복 캐릭터의 카드 1900장 사용"
  },
  Task_74503_Desc = {
    Text = "투쟁 캐릭터의 카드 1100장 사용"
  },
  Task_74504_Desc = {
    Text = "투쟁 캐릭터의 카드 150장 사용"
  },
  Task_74505_Desc = {
    Text = "축복 캐릭터의 카드 50장 사용"
  },
  Task_74506_Desc = {
    Text = "투쟁 캐릭터의 카드 1025장 사용"
  },
  Task_74507_Desc = {
    Text = "투쟁 캐릭터의 카드 1900장 사용"
  },
  Task_74508_Desc = {
    Text = "투쟁 캐릭터의 카드 675장 사용"
  },
  Task_74509_Desc = {
    Text = "수호 캐릭터의 카드 1925장 사용"
  },
  Task_74510_Desc = {
    Text = "영지 캐릭터의 카드 1850장 사용"
  },
  Task_74511_Desc = {
    Text = "흉성 캐릭터의 카드 1250장 사용"
  },
  Task_74512_Desc = {
    Text = "투쟁 캐릭터의 카드 1950장 사용"
  },
  Task_74513_Desc = {
    Text = "투쟁 캐릭터의 카드 550장 사용"
  },
  Task_74514_Desc = {
    Text = "투쟁 캐릭터의 카드 250장 사용"
  },
  Task_74515_Desc = {
    Text = "흉성 캐릭터의 카드 1525장 사용"
  },
  Task_74516_Desc = {
    Text = "수호 캐릭터의 카드 75장 사용"
  },
  Task_74517_Desc = {
    Text = "영지 캐릭터의 카드 1150장 사용"
  },
  Task_74518_Desc = {
    Text = "흉성 캐릭터의 카드 825장 사용"
  },
  Task_74519_Desc = {
    Text = "수호 캐릭터의 카드 50장 사용"
  },
  Task_74520_Desc = {
    Text = "흉성 캐릭터의 카드 1200장 사용"
  },
  Task_74521_Desc = {
    Text = "투쟁 캐릭터의 카드 1600장 사용"
  },
  Task_74522_Desc = {
    Text = "투쟁 캐릭터의 카드 1125장 사용"
  },
  Task_74523_Desc = {
    Text = "흉성 캐릭터의 카드 1425장 사용"
  },
  Task_74524_Desc = {
    Text = "투쟁 캐릭터의 카드 225장 사용"
  },
  Task_74525_Desc = {
    Text = "영지 캐릭터의 카드 375장 사용"
  },
  Task_74526_Desc = {
    Text = "수호 캐릭터의 카드 1475장 사용"
  },
  Task_74527_Desc = {
    Text = "수호 캐릭터의 카드 100장 사용"
  },
  Task_74528_Desc = {
    Text = "투쟁 캐릭터의 카드 375장 사용"
  },
  Task_74529_Desc = {
    Text = "수호 캐릭터의 카드 1850장 사용"
  },
  Task_74530_Desc = {
    Text = "투쟁 캐릭터의 카드 350장 사용"
  },
  Task_74531_Desc = {
    Text = "축복 캐릭터의 카드 1675장 사용"
  },
  Task_74532_Desc = {
    Text = "흉성 캐릭터의 카드 675장 사용"
  },
  Task_74533_Desc = {
    Text = "영지 캐릭터의 카드 1650장 사용"
  },
  Task_74534_Desc = {
    Text = "영지 캐릭터의 카드 75장 사용"
  },
  Task_74535_Desc = {
    Text = "투쟁 캐릭터의 카드 50장 사용"
  },
  Task_74536_Desc = {
    Text = "투쟁 캐릭터의 카드 875장 사용"
  },
  Task_74537_Desc = {
    Text = "수호 캐릭터의 카드 1650장 사용"
  },
  Task_74538_Desc = {
    Text = "축복 캐릭터의 카드 250장 사용"
  },
  Task_74539_Desc = {
    Text = "축복 캐릭터의 카드 100장 사용"
  },
  Task_74540_Desc = {
    Text = "축복 캐릭터의 카드 1075장 사용"
  },
  Task_74541_Desc = {
    Text = "흉성 캐릭터의 카드 1750장 사용"
  },
  Task_74542_Desc = {
    Text = "투쟁 캐릭터의 카드 750장 사용"
  },
  Task_74543_Desc = {
    Text = "영지 캐릭터의 카드 550장 사용"
  },
  Task_74544_Desc = {
    Text = "투쟁 캐릭터의 카드 1450장 사용"
  },
  Task_74545_Desc = {
    Text = "투쟁 캐릭터의 카드 725장 사용"
  },
  Task_74546_Desc = {
    Text = "영지 캐릭터의 카드 600장 사용"
  },
  Task_74547_Desc = {
    Text = "축복 캐릭터의 카드 700장 사용"
  },
  Task_74548_Desc = {
    Text = "수호 캐릭터의 카드 1550장 사용"
  },
  Task_74549_Desc = {
    Text = "축복 캐릭터의 카드 850장 사용"
  },
  Task_74550_Desc = {
    Text = "흉성 캐릭터의 카드 1450장 사용"
  },
  Task_74551_Desc = {
    Text = "투쟁 캐릭터의 카드 1625장 사용"
  },
  Task_74552_Desc = {
    Text = "투쟁 캐릭터의 카드 200장 사용"
  },
  Task_74553_Desc = {
    Text = "축복 캐릭터의 카드 1525장 사용"
  },
  Task_74554_Desc = {
    Text = "흉성 캐릭터의 카드 525장 사용"
  },
  Task_74555_Desc = {
    Text = "축복 캐릭터의 카드 325장 사용"
  },
  Task_74556_Desc = {
    Text = "투쟁 캐릭터의 카드 1525장 사용"
  },
  Task_74557_Desc = {
    Text = "흉성 캐릭터의 카드 375장 사용"
  },
  Task_74558_Desc = {
    Text = "축복 캐릭터의 카드 1375장 사용"
  },
  Task_74559_Desc = {
    Text = "축복 캐릭터의 카드 300장 사용"
  },
  Task_74560_Desc = {
    Text = "축복 캐릭터의 카드 225장 사용"
  },
  Task_74561_Desc = {
    Text = "투쟁 캐릭터의 카드 1850장 사용"
  },
  Task_74562_Desc = {
    Text = "수호 캐릭터의 카드 475장 사용"
  },
  Task_74563_Desc = {
    Text = "축복 캐릭터의 카드 600장 사용"
  },
  Task_74564_Desc = {
    Text = "수호 캐릭터의 카드 1375장 사용"
  },
  Task_74565_Desc = {
    Text = "수호 캐릭터의 카드 1450장 사용"
  },
  Task_74566_Desc = {
    Text = "수호 캐릭터의 카드 300장 사용"
  },
  Task_74567_Desc = {
    Text = "영지 캐릭터의 카드 950장 사용"
  },
  Task_74568_Desc = {
    Text = "수호 캐릭터의 카드 1200장 사용"
  },
  Task_74569_Desc = {
    Text = "흉성 캐릭터의 카드 1025장 사용"
  },
  Task_74570_Desc = {
    Text = "축복 캐릭터의 카드 950장 사용"
  },
  Task_74571_Desc = {
    Text = "투쟁 캐릭터의 카드 1350장 사용"
  },
  Task_74572_Desc = {
    Text = "수호 캐릭터의 카드 525장 사용"
  },
  Task_74573_Desc = {
    Text = "투쟁 캐릭터의 카드 125장 사용"
  },
  Task_74574_Desc = {
    Text = "축복 캐릭터의 카드 475장 사용"
  },
  Task_74575_Desc = {
    Text = "영지 캐릭터의 카드 350장 사용"
  },
  Task_74576_Desc = {
    Text = "영지 캐릭터의 카드 1175장 사용"
  },
  Task_74577_Desc = {
    Text = "영지 캐릭터의 카드 1250장 사용"
  },
  Task_74578_Desc = {
    Text = "수호 캐릭터의 카드 775장 사용"
  },
  Task_74579_Desc = {
    Text = "수호 캐릭터의 카드 400장 사용"
  },
  Task_74580_Desc = {
    Text = "투쟁 캐릭터의 카드 825장 사용"
  },
  Task_74581_Desc = {
    Text = "영지 캐릭터의 카드 650장 사용"
  },
  Task_74582_Desc = {
    Text = "흉성 캐릭터의 카드 1575장 사용"
  },
  Task_74583_Desc = {
    Text = "축복 캐릭터의 카드 350장 사용"
  },
  Task_74584_Desc = {
    Text = "투쟁 캐릭터의 카드 1400장 사용"
  },
  Task_74585_Desc = {
    Text = "수호 캐릭터의 카드 275장 사용"
  },
  Task_74586_Desc = {
    Text = "축복 캐릭터의 카드 1500장 사용"
  },
  Task_74587_Desc = {
    Text = "흉성 캐릭터의 카드 500장 사용"
  },
  Task_74588_Desc = {
    Text = "투쟁 캐릭터의 카드 1075장 사용"
  },
  Task_74589_Desc = {
    Text = "축복 캐릭터의 카드 625장 사용"
  },
  Task_74590_Desc = {
    Text = "투쟁 캐릭터의 카드 575장 사용"
  },
  Task_74591_Desc = {
    Text = "흉성 캐릭터의 카드 850장 사용"
  },
  Task_74592_Desc = {
    Text = "수호 캐릭터의 카드 650장 사용"
  },
  Task_74593_Desc = {
    Text = "축복 캐릭터의 카드 575장 사용"
  },
  Task_74594_Desc = {
    Text = "축복 캐릭터의 카드 375장 사용"
  },
  Task_74595_Desc = {
    Text = "수호 캐릭터의 카드 225장 사용"
  },
  Task_74596_Desc = {
    Text = "영지 캐릭터의 카드 1875장 사용"
  },
  Task_74597_Desc = {
    Text = "수호 캐릭터의 카드 1075장 사용"
  },
  Task_74598_Desc = {
    Text = "투쟁 캐릭터의 카드 1825장 사용"
  },
  Task_74599_Desc = {
    Text = "흉성 캐릭터의 카드 1700장 사용"
  },
  Task_74600_Desc = {
    Text = "수호 캐릭터의 카드 150장 사용"
  },
  Task_74601_Desc = {
    Text = "수호 캐릭터의 카드 1750장 사용"
  },
  Task_74602_Desc = {
    Text = "수호 캐릭터의 카드 1975장 사용"
  },
  Task_74603_Desc = {
    Text = "흉성 캐릭터의 카드 750장 사용"
  },
  Task_74604_Desc = {
    Text = "축복 캐릭터의 카드 1750장 사용"
  },
  Task_74605_Desc = {
    Text = "흉성 캐릭터의 카드 1150장 사용"
  },
  Task_74606_Desc = {
    Text = "흉성 캐릭터의 카드 1475장 사용"
  },
  Task_74607_Desc = {
    Text = "수호 캐릭터의 카드 875장 사용"
  },
  Task_74608_Desc = {
    Text = "흉성 캐릭터의 카드 725장 사용"
  },
  Task_74609_Desc = {
    Text = "축복 캐릭터의 카드 1725장 사용"
  },
  Task_74610_Desc = {
    Text = "흉성 캐릭터의 카드 1800장 사용"
  },
  Task_74611_Desc = {
    Text = "축복 캐릭터의 카드 1050장 사용"
  },
  Task_74612_Desc = {
    Text = "축복 캐릭터의 카드 1925장 사용"
  },
  Task_74613_Desc = {
    Text = "흉성 캐릭터의 카드 925장 사용"
  },
  Task_74614_Desc = {
    Text = "영지 캐릭터의 카드 250장 사용"
  },
  Task_74615_Desc = {
    Text = "영지 캐릭터의 카드 900장 사용"
  },
  Task_74616_Desc = {
    Text = "흉성 캐릭터의 카드 350장 사용"
  },
  Task_74617_Desc = {
    Text = "축복 캐릭터의 카드 1350장 사용"
  },
  Task_74618_Desc = {
    Text = "축복 캐릭터의 카드 125장 사용"
  },
  Task_74619_Desc = {
    Text = "흉성 캐릭터의 카드 1775장 사용"
  },
  Task_74620_Desc = {
    Text = "흉성 캐릭터의 카드 1925장 사용"
  },
  Task_74621_Desc = {
    Text = "흉성 캐릭터의 카드 1900장 사용"
  },
  Task_74622_Desc = {
    Text = "영지 캐릭터의 카드 875장 사용"
  },
  Task_74623_Desc = {
    Text = "수호 캐릭터의 카드 250장 사용"
  },
  Task_74624_Desc = {
    Text = "수호 캐릭터의 카드 900장 사용"
  },
  Task_74625_Desc = {
    Text = "수호 캐릭터의 카드 675장 사용"
  },
  Task_74626_Desc = {
    Text = "수호 캐릭터의 카드 1350장 사용"
  },
  Task_74627_Desc = {
    Text = "영지 캐릭터의 카드 1450장 사용"
  },
  Task_74628_Desc = {
    Text = "축복 캐릭터의 카드 875장 사용"
  },
  Task_74629_Desc = {
    Text = "투쟁 캐릭터의 카드 1550장 사용"
  },
  Task_74630_Desc = {
    Text = "영지 캐릭터의 카드 1000장 사용"
  },
  Task_74631_Desc = {
    Text = "흉성 캐릭터의 카드 2000장 사용"
  },
  Task_74632_Desc = {
    Text = "영지 캐릭터의 카드 675장 사용"
  },
  Task_74633_Desc = {
    Text = "수호 캐릭터의 카드 1025장 사용"
  },
  Task_74634_Desc = {
    Text = "흉성 캐릭터의 카드 1300장 사용"
  },
  Task_74635_Desc = {
    Text = "영지 캐릭터의 카드 1800장 사용"
  },
  Task_74636_Desc = {
    Text = "수호 캐릭터의 카드 1825장 사용"
  },
  Task_74637_Desc = {
    Text = "투쟁 캐릭터의 카드 1700장 사용"
  },
  Task_74638_Desc = {
    Text = "투쟁 캐릭터의 카드 1000장 사용"
  },
  Task_74639_Desc = {
    Text = "축복 캐릭터의 카드 275장 사용"
  },
  Task_74640_Desc = {
    Text = "영지 캐릭터의 카드 1100장 사용"
  },
  Task_74641_Desc = {
    Text = "축복 캐릭터의 카드 1800장 사용"
  },
  Task_74642_Desc = {
    Text = "투쟁 캐릭터의 카드 1475장 사용"
  },
  Task_74643_Desc = {
    Text = "흉성 캐릭터의 카드 1225장 사용"
  },
  Task_74644_Desc = {
    Text = "축복 캐릭터의 카드 975장 사용"
  },
  Task_74645_Desc = {
    Text = "투쟁 캐릭터의 카드 400장 사용"
  },
  Task_74646_Desc = {
    Text = "영지 캐릭터의 카드 800장 사용"
  },
  Task_74647_Desc = {
    Text = "영지 캐릭터의 카드 1925장 사용"
  },
  Task_74648_Desc = {
    Text = "영지 캐릭터의 카드 1375장 사용"
  },
  Task_74649_Desc = {
    Text = "영지 캐릭터의 카드 400장 사용"
  },
  Task_74650_Desc = {
    Text = "축복 캐릭터의 카드 1000장 사용"
  },
  Task_74651_Desc = {
    Text = "흉성 캐릭터의 카드 700장 사용"
  },
  Task_74652_Desc = {
    Text = "축복 캐릭터의 카드 1700장 사용"
  },
  Task_74653_Desc = {
    Text = "흉성 캐릭터의 카드 1075장 사용"
  },
  Task_74654_Desc = {
    Text = "투쟁 캐릭터의 카드 1050장 사용"
  },
  Task_74655_Desc = {
    Text = "투쟁 캐릭터의 카드 175장 사용"
  },
  Task_74656_Desc = {
    Text = "영지 캐릭터의 카드 300장 사용"
  },
  Task_74657_Desc = {
    Text = "흉성 캐릭터의 카드 1000장 사용"
  },
  Task_74658_Desc = {
    Text = "영지 캐릭터의 카드 825장 사용"
  },
  Task_74659_Desc = {
    Text = "투쟁 캐릭터의 카드 600장 사용"
  },
  Task_74660_Desc = {
    Text = "수호 캐릭터의 카드 725장 사용"
  },
  Task_74661_Desc = {
    Text = "수호 캐릭터의 카드 750장 사용"
  },
  Task_74662_Desc = {
    Text = "흉성 캐릭터의 카드 1675장 사용"
  },
  Task_74663_Desc = {
    Text = "영지 캐릭터의 카드 1500장 사용"
  },
  Task_74664_Desc = {
    Text = "수호 캐릭터의 카드 375장 사용"
  },
  Task_74665_Desc = {
    Text = "수호 캐릭터의 카드 1150장 사용"
  },
  Task_74666_Desc = {
    Text = "영지 캐릭터의 카드 275장 사용"
  },
  Task_74667_Desc = {
    Text = "축복 캐릭터의 카드 900장 사용"
  },
  Task_74668_Desc = {
    Text = "영지 캐릭터의 카드 475장 사용"
  },
  Task_74669_Desc = {
    Text = "흉성 캐릭터의 카드 75장 사용"
  },
  Task_74670_Desc = {
    Text = "축복 캐릭터의 카드 175장 사용"
  },
  Task_74671_Desc = {
    Text = "수호 캐릭터의 카드 1775장 사용"
  },
  Task_74672_Desc = {
    Text = "영지 캐릭터의 카드 575장 사용"
  },
  Task_74673_Desc = {
    Text = "투쟁 캐릭터의 카드 500장 사용"
  },
  Task_74674_Desc = {
    Text = "영지 캐릭터의 카드 1725장 사용"
  },
  Task_74675_Desc = {
    Text = "투쟁 캐릭터의 카드 950장 사용"
  },
  Task_74676_Desc = {
    Text = "영지 캐릭터의 카드 1950장 사용"
  },
  Task_74677_Desc = {
    Text = "수호 캐릭터의 카드 1500장 사용"
  },
  Task_74678_Desc = {
    Text = "축복 캐릭터의 카드 1975장 사용"
  },
  Task_74679_Desc = {
    Text = "흉성 캐릭터의 카드 975장 사용"
  },
  Task_74680_Desc = {
    Text = "영지 캐릭터의 카드 1325장 사용"
  },
  Task_74681_Desc = {
    Text = "투쟁 캐릭터의 카드 1775장 사용"
  },
  Task_74682_Desc = {
    Text = "영지 캐릭터의 카드 125장 사용"
  },
  Task_74683_Desc = {
    Text = "축복 캐릭터의 카드 1550장 사용"
  },
  Task_74684_Desc = {
    Text = "투쟁 캐릭터의 카드 2000장 사용"
  },
  Task_74685_Desc = {
    Text = "흉성 캐릭터의 카드 1275장 사용"
  },
  Task_74686_Desc = {
    Text = "축복 캐릭터의 카드 525장 사용"
  },
  Task_74687_Desc = {
    Text = "흉성 캐릭터의 카드 550장 사용"
  },
  Task_74688_Desc = {
    Text = "투쟁 캐릭터의 카드 650장 사용"
  },
  Task_74689_Desc = {
    Text = "흉성 캐릭터의 카드 875장 사용"
  },
  Task_74690_Desc = {
    Text = "축복 캐릭터의 카드 1875장 사용"
  },
  Task_74691_Desc = {
    Text = "수호 캐릭터의 카드 1300장 사용"
  },
  Task_74692_Desc = {
    Text = "흉성 캐릭터의 카드 1100장 사용"
  },
  Task_74693_Desc = {
    Text = "수호 캐릭터의 카드 2000장 사용"
  },
  Task_74694_Desc = {
    Text = "흉성 캐릭터의 카드 1850장 사용"
  },
  Task_74695_Desc = {
    Text = "투쟁 캐릭터의 카드 75장 사용"
  },
  Task_74696_Desc = {
    Text = "투쟁 캐릭터의 카드 625장 사용"
  },
  Task_74697_Desc = {
    Text = "투쟁 캐릭터의 카드 1425장 사용"
  },
  Task_74698_Desc = {
    Text = "수호 캐릭터의 카드 1800장 사용"
  },
  Task_74699_Desc = {
    Text = "영지 캐릭터의 카드 225장 사용"
  },
  Task_74700_Desc = {
    Text = "축복 캐릭터의 카드 725장 사용"
  },
  Task_74701_Desc = {
    Text = "수호 캐릭터의 카드 1175장 사용"
  },
  Task_74702_Desc = {
    Text = "영지 캐릭터의 카드 450장 사용"
  },
  Task_74703_Desc = {
    Text = "수호 캐릭터의 카드 575장 사용"
  },
  Task_74704_Desc = {
    Text = "축복 캐릭터의 카드 1625장 사용"
  },
  Task_74705_Desc = {
    Text = "흉성 캐릭터의 카드 625장 사용"
  },
  Task_74706_Desc = {
    Text = "흉성 캐릭터의 카드 1350장 사용"
  },
  Task_74707_Desc = {
    Text = "축복 캐릭터의 카드 1650장 사용"
  },
  Task_74708_Desc = {
    Text = "흉성 캐릭터의 카드 650장 사용"
  },
  Task_74709_Desc = {
    Text = "수호 캐릭터의 카드 200장 사용"
  },
  Task_74710_Desc = {
    Text = "수호 캐릭터의 카드 1125장 사용"
  },
  Task_74711_Desc = {
    Text = "영지 캐릭터의 카드 50장 사용"
  },
  Task_74712_Desc = {
    Text = "흉성 캐릭터의 카드 450장 사용"
  },
  Task_74713_Desc = {
    Text = "축복 캐릭터의 카드 1250장 사용"
  },
  Task_74714_Desc = {
    Text = "흉성 캐릭터의 카드 250장 사용"
  },
  Task_74715_Desc = {
    Text = "축복 캐릭터의 카드 1450장 사용"
  },
  Task_74716_Desc = {
    Text = "영지 캐릭터의 카드 1675장 사용"
  },
  Task_74717_Desc = {
    Text = "흉성 캐릭터의 카드 900장 사용"
  },
  Task_74718_Desc = {
    Text = "영지 캐릭터의 카드 500장 사용"
  },
  Task_74719_Desc = {
    Text = "수호 캐릭터의 카드 1325장 사용"
  },
  Task_74720_Desc = {
    Text = "흉성 캐릭터의 카드 425장 사용"
  },
  Task_74721_Desc = {
    Text = "축복 캐릭터의 카드 1425장 사용"
  },
  Task_74722_Desc = {
    Text = "투쟁 캐릭터의 카드 1300장 사용"
  },
  Task_74723_Desc = {
    Text = "축복 캐릭터의 카드 925장 사용"
  },
  Task_74724_Desc = {
    Text = "축복 캐릭터의 카드 1825장 사용"
  },
  Task_74725_Desc = {
    Text = "축복 캐릭터의 카드 1175장 사용"
  },
  Task_74726_Desc = {
    Text = "흉성 캐릭터의 카드 175장 사용"
  },
  Task_74727_Desc = {
    Text = "축복 캐릭터의 카드 750장 사용"
  },
  Task_74728_Desc = {
    Text = "수호 캐릭터의 카드 850장 사용"
  },
  Task_74729_Desc = {
    Text = "투쟁 캐릭터의 카드 1650장 사용"
  },
  Task_74730_Desc = {
    Text = "투쟁 캐릭터의 카드 1275장 사용"
  },
  Task_74731_Desc = {
    Text = "흉성 캐릭터의 카드 1175장 사용"
  },
  Task_74732_Desc = {
    Text = "영지 캐릭터의 카드 1975장 사용"
  },
  Task_74733_Desc = {
    Text = "투쟁 캐릭터의 카드 275장 사용"
  },
  Task_74734_Desc = {
    Text = "영지 캐릭터의 카드 1425장 사용"
  },
  Task_74735_Desc = {
    Text = "수호 캐릭터의 카드 1900장 사용"
  },
  Task_74736_Desc = {
    Text = "축복 캐릭터의 카드 1600장 사용"
  },
  Task_74737_Desc = {
    Text = "흉성 캐릭터의 카드 600장 사용"
  },
  Task_74738_Desc = {
    Text = "수호 캐릭터의 카드 1050장 사용"
  },
  Task_74739_Desc = {
    Text = "흉성 캐릭터의 카드 1400장 사용"
  },
  Task_74740_Desc = {
    Text = "축복 캐릭터의 카드 200장 사용"
  },
  Task_74741_Desc = {
    Text = "축복 캐릭터의 카드 500장 사용"
  },
  Task_74742_Desc = {
    Text = "수호 캐릭터의 카드 1225장 사용"
  },
  Task_74743_Desc = {
    Text = "투쟁 캐릭터의 카드 525장 사용"
  },
  Task_74744_Desc = {
    Text = "흉성 캐릭터의 카드 400장 사용"
  },
  Task_74745_Desc = {
    Text = "축복 캐릭터의 카드 1400장 사용"
  },
  Task_74746_Desc = {
    Text = "수호 캐릭터의 카드 425장 사용"
  },
  Task_74747_Desc = {
    Text = "투쟁 캐릭터의 카드 475장 사용"
  },
  Task_74748_Desc = {
    Text = "흉성 캐릭터의 카드 475장 사용"
  },
  Task_74749_Desc = {
    Text = "축복 캐릭터의 카드 1475장 사용"
  },
  Task_74750_Desc = {
    Text = "투쟁 캐릭터의 카드 300장 사용"
  },
  Task_74751_Desc = {
    Text = "영지 캐릭터의 카드 1575장 사용"
  },
  Task_74752_Desc = {
    Text = "수호 캐릭터의 카드 1675장 사용"
  },
  Task_74753_Desc = {
    Text = "수호 캐릭터의 카드 975장 사용"
  },
  Task_74754_Desc = {
    Text = "투쟁 캐릭터의 카드 1250장 사용"
  },
  Task_74755_Desc = {
    Text = "영지 캐릭터의 카드 850장 사용"
  },
  Task_74756_Desc = {
    Text = "축복 캐릭터의 카드 1200장 사용"
  },
  Task_74757_Desc = {
    Text = "흉성 캐릭터의 카드 1650장 사용"
  },
  Task_74758_Desc = {
    Text = "흉성 캐릭터의 카드 200장 사용"
  },
  Task_74759_Desc = {
    Text = "축복 캐릭터의 카드 1950장 사용"
  },
  Task_74760_Desc = {
    Text = "흉성 캐릭터의 카드 950장 사용"
  },
  Task_74761_Desc = {
    Text = "축복 캐릭터의 카드 450장 사용"
  },
  Task_74762_Desc = {
    Text = "영지 캐릭터의 카드 1400장 사용"
  },
  Task_74763_Desc = {
    Text = "투쟁 캐릭터의 카드 325장 사용"
  },
  Task_74764_Desc = {
    Text = "투쟁 캐릭터의 카드 925장 사용"
  },
  Task_74765_Desc = {
    Text = "흉성 캐릭터의 카드 1825장 사용"
  },
  Task_74766_Desc = {
    Text = "흉성 캐릭터의 카드 300장 사용"
  },
  Task_74767_Desc = {
    Text = "축복 캐릭터의 카드 1300장 사용"
  },
  Task_74768_Desc = {
    Text = "투쟁 캐릭터의 카드 425장 사용"
  },
  Task_74769_Desc = {
    Text = "수호 캐릭터의 카드 825장 사용"
  },
  Task_75738_Desc = {
    Text = "클리어 「무두체」 임의 난이도"
  },
  Task_75739_Desc = {
    Text = "클리어 「회색 바다로 돌아가다」 임의 난이도"
  },
  Task_75740_Desc = {
    Text = "클리어 「늪악귀」 임의의 난이도"
  },
  Task_75741_Desc = {
    Text = "클리어 「비오는 밤 추적」 임의의 난이도"
  },
  Task_75742_Desc = {
    Text = "클리어 「그것과 그녀」 임의 난이도"
  },
  Task_76237_Desc = {
    Text = "클리어 별빛 이야기 제1장 1-5 어려움"
  },
  Task_76238_Desc = {
    Text = "최종장 「기나긴 꿈의 끝」 완료"
  },
  Task_76239_Desc = {
    Text = "클리어 별빛 이야기 제1장 1-6"
  },
  Task_76240_Desc = {
    Text = "최종장 9-3 어려움 난이도 완료"
  },
  Task_76241_Desc = {
    Text = "최종장 「기나긴 꿈의 끝」 어려움 난이도 완료"
  },
  Task_76242_Desc = {
    Text = "최종장 「기나긴 꿈의 끝」 완료"
  },
  Task_76243_Desc = {
    Text = "클리어 스타즈 챕터 제1장 「재림 안개도시」 어려움"
  },
  Task_76244_Desc = {
    Text = "클리어 스타즈 챕터 제1장 「재림 안개도시」 어려움"
  },
  Task_76245_Desc = {
    Text = "최종장 9-4 완료"
  },
  Task_76246_Desc = {
    Text = "클리어 별빛 이야기 제1장 1-6"
  },
  Task_76247_Desc = {
    Text = "클리어 스타즈 챕터 제1장 「재림 안개도시」"
  },
  Task_76248_Desc = {
    Text = "클리어 별빛 이야기 제1장 1-5 어려움"
  },
  Task_76249_Desc = {
    Text = "최종장 「기나긴 꿈의 끝」 어려움 난이도 완료"
  },
  Task_76250_Desc = {
    Text = "최종장 9-3 어려움 난이도 완료"
  },
  Task_76251_Desc = {
    Text = "최종장 9-4 완료"
  },
  Task_76252_Desc = {
    Text = "클리어 스타즈 챕터 제1장 「재림 안개도시」"
  },
  Task_76339_Desc = {
    Text = "클리어 「회색 바다로 돌아가다」 임의 난이도"
  },
  Task_76340_Desc = {
    Text = "마녀의 소점포·광기"
  },
  Task_76341_Desc = {
    Text = "클리어 「비오는 밤 추적」 광기 난이도"
  },
  Task_76342_Desc = {
    Text = "클리어 「늪악귀」 광기 난이도"
  },
  Task_76343_Desc = {
    Text = "클리어 「그것과 그녀」 임의 난이도"
  },
  Task_76344_Desc = {
    Text = "마녀의 보물창고"
  },
  Task_76345_Desc = {
    Text = "「화려한 비밀 보물」에서 300개의 아이템을 교환하여 획득"
  },
  Task_76346_Desc = {
    Text = "「화려한 비밀 보물」에서 150개의 아이템을 교환하여 획득"
  },
  Task_76347_Desc = {
    Text = "클리어 **「무두체」** 광기 난이도"
  },
  Task_76348_Desc = {
    Text = "클리어 「비오는 밤 추적」 임의의 난이도"
  },
  Task_76349_Desc = {
    Text = "클리어 「그것과 그녀」 광기 난이도"
  },
  Task_76350_Desc = {
    Text = "클리어 「회색 바다로 돌아가다」 광기 난이도"
  },
  Task_76351_Desc = {
    Text = "「희귀한 물건」 교환으로 150개의 아이템 획득"
  },
  Task_76352_Desc = {
    Text = "통관 특수 임무 기록 「비 마을의 그림자」"
  },
  Task_76353_Desc = {
    Text = "완료 「마녀의 소점포·클리어」 모든 태스크"
  },
  Task_76354_Desc = {
    Text = "「희귀한 물건」과 교환하여 300개의 아이템을 획득"
  },
  Task_76355_Desc = {
    Text = "클리어 「늪악귀」 임의의 난이도"
  },
  Task_76356_Desc = {
    Text = "「우려를 해소하는 좋은 제품」에서 300개의 아이템을 교환하여 획득"
  },
  Task_76357_Desc = {
    Text = "「우려를 해소하는 좋은 제품」에서 150개의 아이템을 획득하여 교환"
  },
  Task_76358_Desc = {
    Text = "마녀의 소점포·클리어"
  },
  Task_76359_Desc = {
    Text = "클리어 「무두체」 임의 난이도"
  },
  Task_77674_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_77674_Name = {Text = "10승"},
  Task_77675_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_77675_Name = {Text = "1승"},
  Task_77676_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_77676_Name = {Text = "3승"},
  Task_77677_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_77677_Name = {Text = "6승"},
  Task_78106_Desc = {
    Text = "「회귀·라모나」를 사용하여 6회 승리"
  },
  Task_78107_Desc = {
    Text = "「이사라우의 시선」을 사용하여 6번 승리하기"
  },
  Task_78108_Desc = {
    Text = "「견고한 의지」를 사용하여 6번 승리했습니다"
  },
  Task_78109_Desc = {
    Text = "「에리카」를 사용하여 10회 승리"
  },
  Task_78112_Desc = {
    Text = "「릴리」를 사용하여 6회 승리"
  },
  Task_78113_Desc = {
    Text = "「중하의 꿈」을 사용하여 6번 승리하기"
  },
  Task_78114_Desc = {
    Text = "「전부 그녀의」를 사용하여 6번 승리하다"
  },
  Task_78115_Desc = {
    Text = "「혈쇄·히로」를 사용하여 10회 승리"
  },
  Task_78116_Desc = {
    Text = "「라이커」를 사용하여 10회 승리"
  },
  Task_78117_Desc = {
    Text = "「라모나」를 사용하여 10회 승리"
  },
  Task_78118_Desc = {
    Text = "「님피아」를 사용하여 6회 승리"
  },
  Task_78119_Desc = {
    Text = "사용 「장미의 이름으로」 6회 승리"
  },
  Task_78120_Desc = {
    Text = "「아그리파」를 사용하여 6회 승리"
  },
  Task_78122_Desc = {
    Text = "「미리암」을 사용하여 6회 승리"
  },
  Task_78123_Desc = {
    Text = "「리즈」를 사용하여 6회 승리"
  },
  Task_78124_Desc = {
    Text = "「방출」 사용으로 6번의 승리를 획득."
  },
  Task_78125_Desc = {
    Text = "사용 「애정」 6번 승리 획득"
  },
  Task_78126_Desc = {
    Text = "사용 「거울 속의 사람」으로 6번 승리하기"
  },
  Task_78127_Desc = {
    Text = "사용 「연쇄을 벗어던진 날」 획득 6번의 승리"
  },
  Task_78128_Desc = {
    Text = "「미친 길」을 사용해 6번 승리하기"
  },
  Task_78129_Desc = {
    Text = "「틴커트」를 사용하여 6회 승리"
  },
  Task_78130_Desc = {
    Text = "「모임의 순간」을 사용하여 6번 승리하기"
  },
  Task_78131_Desc = {
    Text = "「판디아」를 사용하여 6회 승리"
  },
  Task_78132_Desc = {
    Text = "「살바도르」를 사용하여 10회 승리"
  },
  Task_78133_Desc = {
    Text = "「해의 꿈」을 사용해서 6번 승리하기"
  },
  Task_78134_Desc = {
    Text = "「진리의 문」을 사용하여 6번 승리하기"
  },
  Task_78135_Desc = {
    Text = "「광란」을 사용하여 6번의 승리를 획득하다"
  },
  Task_78137_Desc = {
    Text = "사용 「상처받은 지느러미」 획득 6회 승리"
  },
  Task_78138_Desc = {
    Text = "「히로」를 사용하여 10회 승리"
  },
  Task_78139_Desc = {
    Text = "깨어남체"
  },
  Task_78140_Desc = {
    Text = "「24」를 사용하여 6회 승리"
  },
  Task_78141_Desc = {
    Text = "「카시아」를 사용하여 6회 승리"
  },
  Task_78142_Desc = {
    Text = "「타비」를 사용하여 6회 승리"
  },
  Task_78143_Desc = {
    Text = "「골리아」를 사용하여 6회 승리"
  },
  Task_78144_Desc = {
    Text = "「24」를 사용하여 10회 승리"
  },
  Task_78145_Desc = {
    Text = "「신언 석판」을 사용하여 6번 승리하기"
  },
  Task_78146_Desc = {
    Text = "「영원한 레퀴엠」 사용하여 6번의 승리 획득"
  },
  Task_78147_Desc = {
    Text = "사용 「징계」로 6번 승리"
  },
  Task_78148_Desc = {
    Text = "「신적 강림」을 사용하여 6번의 승리를 거두기"
  },
  Task_78149_Desc = {
    Text = "「시첩의 끝구절」을 사용하여 6회 승리하기"
  },
  Task_78150_Desc = {
    Text = "사용 「무한으로 떨어지는 인형」 6번 승리 획득"
  },
  Task_78151_Desc = {
    Text = "「침묵의 연회」를 사용하여 6번의 승리를 획득"
  },
  Task_78152_Desc = {
    Text = "「성실타래한 위력」을 사용하여 6번의 승리를 거두기"
  },
  Task_78153_Desc = {
    Text = "「툴루」를 사용하여 10회 승리"
  },
  Task_78154_Desc = {
    Text = "「은코다의 결심」을 사용하여 6번 승리하기"
  },
  Task_78155_Desc = {
    Text = "「욕심」으로 6번 승리"
  },
  Task_78159_Desc = {
    Text = "「명우」를 사용하여 6번의 승리를 획득"
  },
  Task_78160_Desc = {
    Text = "「회무진용」을 사용하여 6번의 승리를 획득"
  },
  Task_78161_Desc = {
    Text = "「혈육의 광연」으로 6번의 승리를 획득"
  },
  Task_78162_Desc = {
    Text = "「윙클」을사용하여 6회 승리"
  },
  Task_78163_Desc = {
    Text = "「백만 몬스터의 눈」을 사용하여 6번 승리"
  },
  Task_78164_Desc = {
    Text = "사용 「나지막이 말하기」로 6번 승리"
  },
  Task_78166_Desc = {
    Text = "「돌」을 사용하여 6회 승리"
  },
  Task_78168_Desc = {
    Text = "「아그리파」를 사용하여 10회 승리"
  },
  Task_78169_Desc = {
    Text = "「로탄」을 사용하여 10회 승리"
  },
  Task_78170_Desc = {
    Text = "「골리아」를 사용하여 10회 승리"
  },
  Task_78171_Desc = {
    Text = "「진홍색으로 침없다」를 사용하여 6번의 승리를 획득했다."
  },
  Task_78172_Desc = {
    Text = "「판디아」를 사용하여 10회 승리"
  },
  Task_78173_Desc = {
    Text = "「도태우화」를 사용해 6번 승리하기"
  },
  Task_78174_Desc = {
    Text = "「운명의 룰렛」을 사용하여 6번 승리하기"
  },
  Task_78175_Desc = {
    Text = "「컷팅과 피해」를 사용하여 6번 승리"
  },
  Task_78176_Desc = {
    Text = "「신왕의 찬가」를 사용하여 6번의 승리를 획득하기"
  },
  Task_78177_Desc = {
    Text = "「융해·돌」을 사용하여 10회 승리"
  },
  Task_78178_Desc = {
    Text = "「레아」를 사용하여 6회 승리"
  },
  Task_78179_Desc = {Text = "명륜"},
  Task_78180_Desc = {
    Text = "「히로」를 사용하여 6회 승리"
  },
  Task_78181_Desc = {
    Text = "「동야추억」을 사용하여 6번의 승리를 획득하기"
  },
  Task_78182_Desc = {
    Text = "사용 「거인의 횡포」 6번 승리 획득"
  },
  Task_78183_Desc = {
    Text = "「다포딜」을 사용하여 10회 승리"
  },
  Task_78184_Desc = {
    Text = "「인도의 돛」을 사용해 6번의 승리 획득"
  },
  Task_78185_Desc = {
    Text = "「라이커」를 사용하여 6회 승리"
  },
  Task_78186_Desc = {
    Text = "「파인트」를 사용하여 6회 승리"
  },
  Task_78187_Desc = {
    Text = "사용 「망각의 손」 6번 승리 획득"
  },
  Task_78188_Desc = {
    Text = "「타이스」를 사용하여 6회 승리"
  },
  Task_78189_Desc = {
    Text = "「님피아」를 사용하여 10회 승리"
  },
  Task_78190_Desc = {
    Text = "「완다」를 사용하여 6회 승리"
  },
  Task_78192_Desc = {
    Text = "「노틸라」를 사용하여 6회 승리"
  },
  Task_78193_Desc = {
    Text = "「아이기스」를 사용하여 6회 승리"
  },
  Task_78194_Desc = {
    Text = "「완성할 수 없는 계산」을 사용하여 6번 승리"
  },
  Task_78196_Desc = {
    Text = "「여왕의 계율」을 사용하여 6번 승리"
  },
  Task_78197_Desc = {
    Text = "「오레타」를 사용하여 6회 승리"
  },
  Task_78198_Desc = {
    Text = "「회귀·라모나」를 사용하여 10회 승리"
  },
  Task_78199_Desc = {
    Text = "「밤의 그림자에 숨어서」를 사용해 6번 승리하기"
  },
  Task_78200_Desc = {
    Text = "「혈쇄·히로」를 사용하여 6회 승리"
  },
  Task_78201_Desc = {
    Text = "「통증을 넘어서」로 6번 승리"
  },
  Task_78202_Desc = {
    Text = "「거인의 검」을 사용하여 6번 승리"
  },
  Task_78203_Desc = {
    Text = "「엘바」를 사용하여 10회 승리"
  },
  Task_78204_Desc = {
    Text = "「임계점」을 사용하여 6번 승리"
  },
  Task_78205_Desc = {
    Text = "「산호 여인의 죽음」을 사용하여 6번의 승리를 거두기"
  },
  Task_78206_Desc = {
    Text = "「유일한 씨앗」을 사용하여 6번 승리하기"
  },
  Task_78208_Desc = {
    Text = "사용 「포식의요람」으로 6번 승리하기"
  },
  Task_78209_Desc = {
    Text = "「나의 소중한 친구에게」를 사용하여 6번의 승리를 획득하기"
  },
  Task_78210_Desc = {
    Text = "사용 「집중력」 획득 6회 승리"
  },
  Task_78212_Desc = {
    Text = "「기억증후군」을 사용하여 6번의 승리를 거두기"
  },
  Task_78213_Desc = {
    Text = "「다포딜」을 사용하여 6회 승리"
  },
  Task_78214_Desc = {
    Text = "사용 「눈이 녹을 때까지」 6번 승리"
  },
  Task_78216_Desc = {
    Text = "「희망」을 사용하여 6번 승리하기"
  },
  Task_78217_Desc = {
    Text = "「극야와 새벽」을 사용하여 6번 승리하기"
  },
  Task_78218_Desc = {
    Text = "「머피」를 사용하여 10회 승리"
  },
  Task_78219_Desc = {
    Text = "「불평등한 교환」을 사용하여 6번 승리했습니다"
  },
  Task_78220_Desc = {
    Text = "「오레타의 보물」을 사용하여 6번의 승리를 획득하기"
  },
  Task_78221_Desc = {
    Text = "「아이기스」를 사용하여 10회 승리"
  },
  Task_78223_Desc = {
    Text = "「로드의 지팡이」를 사용해 6번 승리하기"
  },
  Task_78224_Desc = {
    Text = "「욕망의 바다에서 떠돌기」를 사용해 6번 승리하기"
  },
  Task_78225_Desc = {
    Text = "「유우하시」를 사용하여 6회 승리"
  },
  Task_78226_Desc = {
    Text = "「미리암」을 사용하여 10회 승리"
  },
  Task_78227_Desc = {
    Text = "「라모나」를 사용하여 6회 승리"
  },
  Task_78228_Desc = {
    Text = "「기사의 마음」을 사용하여 6번의 승리를 거두기"
  },
  Task_78229_Desc = {
    Text = "「융해·돌」을 사용하여 6회 승리"
  },
  Task_78230_Desc = {
    Text = "「가장 소중한 수집품」을 사용하여 6회 승리하기"
  },
  Task_78231_Desc = {
    Text = "사용 「모험의 가방」 6번 승리 획득"
  },
  Task_78232_Desc = {
    Text = "사용 「기운」 획득 6번 승리"
  },
  Task_78233_Desc = {
    Text = "「엘바」를 사용하여 6회 승리"
  },
  Task_78234_Desc = {
    Text = "사용 「마지막 서약」으로 6번 승리하기"
  },
  Task_78235_Desc = {
    Text = "「오를라」를 사용하여 6회 승리"
  },
  Task_78236_Desc = {
    Text = "사용 「폭우 속에서」에서 6번 승리하기"
  },
  Task_78237_Desc = {
    Text = "「돌」을 사용하여 10회 승리"
  },
  Task_78238_Desc = {
    Text = "사용 「죽음 너머로」 획득 6번 승리"
  },
  Task_78239_Desc = {
    Text = "「별하늘의 수호수」를 사용해 6번 승리하기"
  },
  Task_78240_Desc = {
    Text = "사용 「분노의 피와 모래」 6번 승리 획득"
  },
  Task_78241_Desc = {
    Text = "「호수에서 돌아보기」를 사용하여 6번 승리를 획득"
  },
  Task_78242_Desc = {
    Text = "「젠킨」을 사용하여 10회 승리"
  },
  Task_78243_Desc = {Text = "은열쇠"},
  Task_78244_Desc = {
    Text = "「백색 후예」를 사용하여 6번 승리"
  },
  Task_78245_Desc = {
    Text = "「카이커스」를 사용하여 6회 승리"
  },
  Task_78246_Desc = {
    Text = "「하멜른」을 사용하여 6회 승리"
  },
  Task_78247_Desc = {
    Text = "「오를라」를 사용하여 10회 승리"
  },
  Task_78248_Desc = {
    Text = "「코어 용해」를 사용하여 6번 승리하기"
  },
  Task_78249_Desc = {
    Text = "「섬망」을 사용해 6번 승리하기"
  },
  Task_78250_Desc = {
    Text = "「은밀한 탄생」으로 6번 승리 획득하기"
  },
  Task_78251_Desc = {
    Text = "「오레타」를 사용하여 10회 승리"
  },
  Task_78252_Desc = {
    Text = "「머피」를 사용하여 6회 승리"
  },
  Task_78253_Desc = {
    Text = "「순은의 초심」을 사용하여 6번의 승리를 거두기"
  },
  Task_78254_Desc = {
    Text = "「툴루」를 사용하여 6회 승리"
  },
  Task_78255_Desc = {
    Text = "「산」을 사용하여 6회 승리"
  },
  Task_78256_Desc = {
    Text = "「젠킨」을 사용하여 6회 승리"
  },
  Task_78257_Desc = {
    Text = "「윙클」을사용하여 10회 승리"
  },
  Task_78258_Desc = {
    Text = "「완다」를 사용하여 10회 승리"
  },
  Task_78261_Desc = {
    Text = "「추적 시계」를 사용해 6번 승리하기"
  },
  Task_78262_Desc = {
    Text = "「장미의 승리」를 사용하여 6번 승리 획득하기"
  },
  Task_78263_Desc = {
    Text = "「오지에」를 사용하여 10회 승리"
  },
  Task_78264_Desc = {
    Text = "「파로스」를 사용하여 6회 승리"
  },
  Task_78265_Desc = {
    Text = "「파인트」를 사용하여 10회 승리"
  },
  Task_78266_Desc = {
    Text = "「하멜른」을 사용하여 10회 승리"
  },
  Task_78267_Desc = {
    Text = "「자비로운 양육」을 사용하여 6번 승리하기"
  },
  Task_78269_Desc = {
    Text = "사용 「죽음의 해부」 6번 승리 획득"
  },
  Task_78270_Desc = {
    Text = "「숙성」 사용으로 6번의 승리"
  },
  Task_78272_Desc = {
    Text = "「정보는 생명이다」를 사용하여 6번 승리했습니다"
  },
  Task_78273_Desc = {
    Text = "사용 「뼈를 갉아먹는 포옹」 6번 승리를 획득"
  },
  Task_78274_Desc = {
    Text = "「산」을 사용하여 10회 승리"
  },
  Task_78275_Desc = {
    Text = "「빙하 아래의 깊은 잠듦」을 사용해 6번 승리하기"
  },
  Task_78276_Desc = {
    Text = "「에리카」를 사용하여 6회 승리"
  },
  Task_78277_Desc = {
    Text = "「은둔의 전륜」을 사용하여 6회 승리 획득하기"
  },
  Task_78278_Desc = {
    Text = "사용 「35mm의 마법」으로 6번의 승리 획득"
  },
  Task_78279_Desc = {
    Text = "「머릿속의 목소리」를 사용하여 6회 승리"
  },
  Task_78280_Desc = {
    Text = "「행운의 시간」을 사용하여 6번 승리하기"
  },
  Task_78281_Desc = {
    Text = "「카렌」을 사용하여 10회 승리"
  },
  Task_78282_Desc = {
    Text = "「타비」를 사용하여 10회 승리"
  },
  Task_78283_Desc = {
    Text = "「유우하시」를 사용하여 10회 승리"
  },
  Task_78284_Desc = {
    Text = "「리즈」를 사용하여 10회 승리"
  },
  Task_78286_Desc = {
    Text = "사용 「심의 방벽」 6회 승리"
  },
  Task_78287_Desc = {
    Text = "「카시아」를 사용하여 10회 승리"
  },
  Task_78288_Desc = {
    Text = "사용 「이형체 회흡」 6번 승리를 획득"
  },
  Task_78289_Desc = {
    Text = "사용 「영원히 끝없는 연주」 6번 승리 획득"
  },
  Task_78290_Desc = {
    Text = "「고주복」을 사용하여 6번 승리하기"
  },
  Task_78291_Desc = {
    Text = "「셀레스트」를 사용하여 10회 승리"
  },
  Task_78292_Desc = {
    Text = "「존재하지 않는 곳」에서 6번의 승리를 획득"
  },
  Task_78294_Desc = {
    Text = "「틴커트」를 사용하여 10회 승리"
  },
  Task_78295_Desc = {
    Text = "「파로스」를 사용하여 10회 승리"
  },
  Task_78296_Desc = {
    Text = "「릴리」를 사용하여 10회 승리"
  },
  Task_78297_Desc = {
    Text = "사용 「단시간의 영원」 6번 승리 획득"
  },
  Task_78298_Desc = {
    Text = "사용 「활성」으로 6번 승리"
  },
  Task_78299_Desc = {
    Text = "「노틸라」를 사용하여 10회 승리"
  },
  Task_78301_Desc = {
    Text = "「살바도르」를 사용하여 6회 승리"
  },
  Task_78303_Desc = {
    Text = "「흡입」를 사용하여 6번의 승리를 획득하다"
  },
  Task_78304_Desc = {
    Text = "「카이커스」를 사용하여 10회 승리"
  },
  Task_78305_Desc = {
    Text = "「오지에」를 사용하여 6회 승리"
  },
  Task_78306_Desc = {
    Text = "사용 「직무 소재」로 6번 승리하기"
  },
  Task_78307_Desc = {
    Text = "「소렐」을 사용하여 10회 승리"
  },
  Task_78308_Desc = {
    Text = "「해피 마법 쇼」를 사용하여 6번의 승리를 획득하기"
  },
  Task_78309_Desc = {
    Text = "사용 「통찰력」 획득 6번 승리"
  },
  Task_78310_Desc = {
    Text = "「셀레스트」를 사용하여 6회 승리"
  },
  Task_78313_Desc = {
    Text = "「등장」을 이용하여 6번 승리하기"
  },
  Task_78314_Desc = {
    Text = "「레아」를 사용하여 10회 승리"
  },
  Task_78315_Desc = {
    Text = "사용 「속박된 노래」 6번 승리 획득"
  },
  Task_78316_Desc = {
    Text = "「소렐」을 사용하여 6회 승리"
  },
  Task_78317_Desc = {
    Text = "「카렌」을 사용하여 6회 승리"
  },
  Task_78318_Desc = {
    Text = "카드 내기"
  },
  Task_78319_Desc = {
    Text = "「로탄」을 사용하여 6회 승리"
  },
  Task_78320_Desc = {
    Text = "「부패의 선물」을 사용하여 6번 승리하기"
  },
  Task_78321_Desc = {
    Text = "「타이스」를 사용하여 10회 승리"
  },
  Task_78322_Desc = {
    Text = "「메모리 스피럴」을 사용하여 6번 승리하기"
  },
  Task_78326_Desc = {
    Text = "케디구라 동조율이 10레벨에 도달했습니다"
  },
  Task_78327_Desc = {
    Text = "아르고몬트 동조율이 10레벨에 도달했습니다"
  },
  Task_78328_Desc = {
    Text = "폴리덱스 동조율이 10단계에 도달"
  },
  Task_78329_Desc = {
    Text = "독수리 동조율이 10에 도달했습니다"
  },
  Task_78332_Desc = {
    Text = "란티고스 동조율이 10레벨에 도달했습니다"
  },
  Task_78333_Desc = {
    Text = "칼라브 동조율이 10에 도달했습니다"
  },
  Task_78334_Desc = {
    Text = "크퍼산트 동조율이 10레벨에 도달했습니다"
  },
  Task_78336_Desc = {
    Text = "아라크네 동조율이 10급에 도달했다"
  },
  Task_78338_Desc = {
    Text = "흑파라오 동조율이 10급에 도달했습니다"
  },
  Task_78339_Desc = {
    Text = "샤타크 새의 동조율이 10단계에 도달했습니다"
  },
  Task_78340_Desc = {
    Text = "피크맨 동조율이 10 단계에 도달했습니다"
  },
  Task_78341_Desc = {
    Text = "클레멘틴의 동조율이 10급에 도달했습니다"
  },
  Task_78342_Desc = {
    Text = "카스토르 동조율이 10레벨에 도달했습니다"
  },
  Task_78366_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78367_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78368_Desc = {
    Text = "샤타크 새를 획득할 때 기령6"
  },
  Task_78368_Name = {
    Text = "샤타크 새를 획득할 때 기령6"
  },
  Task_78368_UnlockCondDesc = {
    Text = "활동@깨어남체 샤타크 새 기령 패키지 1"
  },
  Task_78369_Desc = {
    Text = "케디구라를 획득할 시 기령 6"
  },
  Task_78369_Name = {
    Text = "케디구라를 획득할 시 기령 6"
  },
  Task_78369_UnlockCondDesc = {
    Text = "이벤트@깨어남체 케디구라 기령 패키지 1"
  },
  Task_78370_Desc = {
    Text = "샤타크 새를 획득할 때 기령이 2만큼 활성화됩니다"
  },
  Task_78370_Name = {
    Text = "샤타크 새를 획득할 때 기령이 2만큼 활성화됩니다"
  },
  Task_78370_UnlockCondDesc = {
    Text = "활동@깨어남체 샤타크 새 기령 패키지 1"
  },
  Task_78371_Desc = {
    Text = "케디구라를 획득할 때 기령 2 개방"
  },
  Task_78371_Name = {
    Text = "케디구라를 획득할 때 기령 2 개방"
  },
  Task_78371_UnlockCondDesc = {
    Text = "이벤트@깨어남체 케디구라 기령 패키지 1"
  },
  Task_78372_Desc = {
    Text = "폴룩스 계령 2 달성"
  },
  Task_78372_Name = {
    Text = "폴룩스 계령 2 달성"
  },
  Task_78372_UnlockCondDesc = {
    Text = "이벤트@깨어남체 폴리덱스 기령 패키지 2 이벤트 참여하기"
  },
  Task_78373_Desc = {
    Text = "폴리덱스를 획득할 때 기령 6"
  },
  Task_78373_Name = {
    Text = "폴리덱스를 획득할 때 기령 6"
  },
  Task_78373_UnlockCondDesc = {
    Text = "이벤트@깨어남체 폴리덱스 기령 패키지 2 이벤트 참여하기"
  },
  Task_78375_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78379_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78380_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78382_Desc = {
    Text = "아라크네를 얻었을 때 기령 6"
  },
  Task_78382_Name = {
    Text = "아라크네를 얻었을 때 기령 6"
  },
  Task_78382_UnlockCondDesc = {
    Text = "활동@깨어남체아라크네기령선물 패키지2활동"
  },
  Task_78383_Desc = {
    Text = "아라크네를 얻었을 때 기령2"
  },
  Task_78383_Name = {
    Text = "아라크네를 얻었을 때 기령2"
  },
  Task_78383_UnlockCondDesc = {
    Text = "활동@깨어남체아라크네기령선물 패키지2활동"
  },
  Task_78384_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78385_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78390_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78391_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78394_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78395_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78396_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78397_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78400_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78401_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78402_Desc = {
    Text = "피크맨을 획득할 때 기령 6"
  },
  Task_78402_Name = {
    Text = "피크맨을 획득할 때 기령 6"
  },
  Task_78402_UnlockCondDesc = {
    Text = "이벤트@깨어남체 피크맨 기령 패키지 1"
  },
  Task_78403_Desc = {
    Text = "피크맨을 획득할 때 기령 2 발동"
  },
  Task_78403_Name = {
    Text = "피크맨을 획득할 때 기령 2 발동"
  },
  Task_78403_UnlockCondDesc = {
    Text = "이벤트@깨어남체 피크맨 기령 패키지 1"
  },
  Task_78404_Desc = {
    Text = "카스토르를 획득할 때 기령 2"
  },
  Task_78404_Name = {
    Text = "카스토르를 획득할 때 기령 2"
  },
  Task_78404_UnlockCondDesc = {
    Text = "이벤트@깨어남체 카스토르 기령 패키지 1"
  },
  Task_78405_Desc = {
    Text = "카스토르를 획득할 때 기령 6"
  },
  Task_78405_Name = {
    Text = "카스토르를 획득할 때 기령 6"
  },
  Task_78405_UnlockCondDesc = {
    Text = "이벤트@깨어남체 카스토르 기령 패키지 1"
  },
  Task_78409_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78415_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78416_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78418_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78419_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78421_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78423_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78424_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78426_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78429_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78430_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78431_Desc = {
    Text = "칼라브를 획득할 때 기령 2"
  },
  Task_78431_Name = {
    Text = "칼라브를 획득할 때 기령 2"
  },
  Task_78431_UnlockCondDesc = {
    Text = "이벤트@깨어남체 칼라브 기령 패키지 2 이벤트"
  },
  Task_78432_Desc = {
    Text = "칼라브를 획득하면 기령 6"
  },
  Task_78432_Name = {
    Text = "칼라브를 획득하면 기령 6"
  },
  Task_78432_UnlockCondDesc = {
    Text = "이벤트@깨어남체 칼라브 기령 패키지 2 이벤트"
  },
  Task_78435_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78436_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78437_Desc = {
    Text = "아르고몬트를 획득할 때 기령 2"
  },
  Task_78437_Name = {
    Text = "아르고몬트를 획득할 때 기령 2"
  },
  Task_78437_UnlockCondDesc = {
    Text = "이벤트 - 아르고몬트의 깨어남체 기령 패키지 2 이벤트"
  },
  Task_78438_Desc = {
    Text = "클레멘틴을 획득할 때 기령 레벨 2"
  },
  Task_78438_Name = {
    Text = "클레멘틴을 획득할 때 기령 레벨 2"
  },
  Task_78438_UnlockCondDesc = {
    Text = "이벤트@깨어남체 클레멘틴 기령 패키지 1"
  },
  Task_78440_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78441_Desc = {
    Text = "클레멘틴을획득할 때 기령 6"
  },
  Task_78441_Name = {
    Text = "클레멘틴을획득할 때 기령 6"
  },
  Task_78441_UnlockCondDesc = {
    Text = "이벤트@깨어남체 클레멘틴 기령 패키지 1"
  },
  Task_78446_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78447_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78449_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78450_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78451_Desc = {
    Text = "흑파라오를 획득할 때 기령 레벨 2"
  },
  Task_78451_Name = {
    Text = "흑파라오를 획득할 때 기령 레벨 2"
  },
  Task_78451_UnlockCondDesc = {
    Text = "이벤트@깨어남체 흑파라오 기령 선물 패키지 1"
  },
  Task_78453_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78458_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78459_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78460_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78466_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78468_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78470_Desc = {
    Text = "흑파라오 획득 시 기령 6"
  },
  Task_78470_Name = {
    Text = "흑파라오 획득 시 기령 6"
  },
  Task_78470_UnlockCondDesc = {
    Text = "이벤트@깨어남체 흑파라오 기령 선물 패키지 1"
  },
  Task_78476_Desc = {
    Text = "란티고스를 획득할 때 기령 6"
  },
  Task_78476_Name = {
    Text = "란티고스를 획득할 때 기령 6"
  },
  Task_78476_UnlockCondDesc = {
    Text = "이벤트@깨어남체 란티고스 기령 선물 패키지 1"
  },
  Task_78477_Desc = {
    Text = "란티고스를 획득할 때 기령 레벨 2"
  },
  Task_78477_Name = {
    Text = "란티고스를 획득할 때 기령 레벨 2"
  },
  Task_78477_UnlockCondDesc = {
    Text = "이벤트@깨어남체 란티고스 기령 선물 패키지 1"
  },
  Task_78481_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78483_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78484_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78485_Desc = {
    Text = "독수리를 획득할 때 기령 2 개방"
  },
  Task_78485_Name = {
    Text = "독수리를 획득할 때 기령 2 개방"
  },
  Task_78485_UnlockCondDesc = {
    Text = "이벤트@깨어남체 독수리 기령 선물 패키지 1"
  },
  Task_78486_Desc = {
    Text = "독수리를 획득하면 기령이 6으로 활성화됩니다."
  },
  Task_78486_Name = {
    Text = "독수리를 획득하면 기령이 6으로 활성화됩니다."
  },
  Task_78486_UnlockCondDesc = {
    Text = "이벤트@깨어남체 독수리 기령 선물 패키지 1"
  },
  Task_78487_Desc = {
    Text = "아르고몬트를 획득할 때 기령 6"
  },
  Task_78487_Name = {
    Text = "아르고몬트를 획득할 때 기령 6"
  },
  Task_78487_UnlockCondDesc = {
    Text = "이벤트 - 아르고몬트의 깨어남체 기령 패키지 2 이벤트"
  },
  Task_78488_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78489_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78492_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78493_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78495_Desc = {
    Text = "크퍼산트 획득 시 기령 6"
  },
  Task_78495_Name = {
    Text = "크퍼산트 획득 시 기령 6"
  },
  Task_78495_UnlockCondDesc = {
    Text = "이벤트@깨어남체 크퍼산트 기령 선물 2 이벤트"
  },
  Task_78496_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78497_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78499_Desc = {
    Text = "크퍼산트를 획득할 때 기령 레벨 2"
  },
  Task_78499_Name = {
    Text = "크퍼산트를 획득할 때 기령 레벨 2"
  },
  Task_78499_UnlockCondDesc = {
    Text = "이벤트@깨어남체 크퍼산트 기령 선물 2 이벤트"
  },
  Task_78573_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78574_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78576_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78577_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78599_Desc = {
    Text = "최종전 13턴 내 승리"
  },
  Task_78599_Name = {
    Text = "최종전 13턴 내 승리"
  },
  Task_78600_Desc = {
    Text = "최종전 14턴 내 승리"
  },
  Task_78600_Name = {
    Text = "최종전 14턴 내 승리"
  },
  Task_78718_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「기억 인코딩」에서 2번 승리하십시오"
  },
  Task_78719_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「기억 인코딩」에서 2번 승리하세요"
  },
  Task_78720_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「기억 인코딩」에서 2번 승리하라"
  },
  Task_78721_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「기억 인코딩」에서 2회 승리"
  },
  Task_78723_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅱ"
  },
  Task_78724_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅰ"
  },
  Task_78725_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅶ"
  },
  Task_78726_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅴ"
  },
  Task_78727_Desc = {
    Text = "검은 조류속 벌레의 울음·무료"
  },
  Task_78728_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅵ"
  },
  Task_78729_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅲ"
  },
  Task_78730_Desc = {
    Text = "검은 조류속 벌레의 울음Ⅳ"
  },
  Task_78740_Desc = {
    Text = "본원 침수의 주인 획득 시 기령 6"
  },
  Task_78740_Name = {
    Text = "본원 침수의 주인 획득 시 기령 6"
  },
  Task_78740_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 침수의 주인 기령 선물 2 이벤트"
  },
  Task_78741_Desc = {
    Text = "본원 침수의 주인 동조율이 10 레벨에 도달했습니다"
  },
  Task_78742_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78743_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78745_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78746_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78748_Desc = {
    Text = "본원 침수의 주인을 획득할 때 기령 2"
  },
  Task_78748_Name = {
    Text = "본원 침수의 주인을 획득할 때 기령 2"
  },
  Task_78748_UnlockCondDesc = {
    Text = "이벤트@깨어남체 본원 침수의 주인 기령 선물 2 이벤트"
  },
  Task_78763_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78764_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78766_Desc = {
    Text = "본원 심해 숙녀를 획득할 때 기령 2"
  },
  Task_78766_Name = {
    Text = "본원 심해 숙녀를 획득할 때 기령 2"
  },
  Task_78766_UnlockCondDesc = {
    Text = "활동@깨어남체 본원 심해 숙녀 기령 패키지 1"
  },
  Task_78767_Desc = {
    Text = "본원 심해 숙녀를 획득할 때 기령 6"
  },
  Task_78767_Name = {
    Text = "본원 심해 숙녀를 획득할 때 기령 6"
  },
  Task_78767_UnlockCondDesc = {
    Text = "활동@깨어남체 본원 심해 숙녀 기령 패키지 1"
  },
  Task_78768_Desc = {
    Text = "본원 심해 숙녀 동조율이 10단계로 올랐습니다"
  },
  Task_78769_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_78770_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_79259_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79259_Name = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79283_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79283_Name = {
    Text = "완벽한 통과"
  },
  Task_79284_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79284_Name = {
    Text = "완벽한 통과"
  },
  Task_79285_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79285_Name = {
    Text = "완벽한 통과"
  },
  Task_79286_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79286_Name = {
    Text = "완벽한 통과"
  },
  Task_79287_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79287_Name = {
    Text = "완벽한 통과"
  },
  Task_79288_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79288_Name = {
    Text = "완벽한 통과"
  },
  Task_79289_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79289_Name = {
    Text = "완벽한 통과"
  },
  Task_79290_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79290_Name = {
    Text = "완벽한 통과"
  },
  Task_79291_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79291_Name = {
    Text = "완벽한 통과"
  },
  Task_79292_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_79292_Name = {
    Text = "완벽한 통과"
  },
  Task_79304_Desc = {
    Text = "「순백의 첫 만남」으로 1회 승리하기"
  },
  Task_79305_Desc = {
    Text = "「태양의 낙타」를 사용하여 1회 승리 획득"
  },
  Task_79306_Desc = {
    Text = "사용 「무속역병」으로 1회 승리 획득"
  },
  Task_79307_Desc = {
    Text = "「회전, 회전」 사용하여 6번의 승리를 획득하기"
  },
  Task_79308_Desc = {
    Text = "「쥐의 지혜」를 사용하여 1회 승리"
  },
  Task_79309_Desc = {
    Text = "「순백의 첫 만남」을 사용해 3번 승리하기"
  },
  Task_79310_Desc = {
    Text = "「뜨거운 이별의 키스」 사용하여 6번의 승리 획득."
  },
  Task_79311_Desc = {
    Text = "사용 「태양의 낙타」 획득 3번의 승리"
  },
  Task_79312_Desc = {
    Text = "사용 「목동의 지팡이」 3번 승리 획득"
  },
  Task_79313_Desc = {
    Text = "사용 「불멸의 장례식」을 획득하여 1회 승리"
  },
  Task_79314_Desc = {
    Text = "「쥐의 지혜」를 사용하여 3회 승리"
  },
  Task_79315_Desc = {
    Text = "「산맥의 각오」를 사용하여 3번 승리"
  },
  Task_79316_Desc = {
    Text = "「작은 소원」을 사용하여 3회 승리"
  },
  Task_79317_Desc = {
    Text = "「영혼의 탄생」 사용으로 1회 승리 획득"
  },
  Task_79318_Desc = {
    Text = "「깊은 바다의 부름」을 사용하여 6번의 승리를 획득하기"
  },
  Task_79319_Desc = {
    Text = "「부패한 연회」를 사용하여 6번의 승리를 획득하세요."
  },
  Task_79320_Desc = {
    Text = "「별들의 가호」를 사용해 3번 승리하기"
  },
  Task_79321_Desc = {
    Text = "「부패한 연회」를 사용해 3번의 승리를 획득하세요."
  },
  Task_79322_Desc = {
    Text = "사용 「문의 답」으로 한 번 승리 획득"
  },
  Task_79323_Desc = {
    Text = "사용 「목동의 지팡이」로 6번 승리를 획득하다"
  },
  Task_79324_Desc = {
    Text = "「깊은 바다의 부름」을 사용하여 1번 승리"
  },
  Task_79325_Desc = {
    Text = "「깊은 바다의 부름」을 사용하여 3번의 승리를 획득하기"
  },
  Task_79326_Desc = {
    Text = "사용 「무속역병」 획득 3회 승리"
  },
  Task_79327_Desc = {
    Text = "「봄의 헌시」를 사용하여 6회 승리"
  },
  Task_79328_Desc = {
    Text = "‘한 발의 총소리’로 1회 승리"
  },
  Task_79329_Desc = {
    Text = "「불멸의 장례식」을 사용하여 3번의 승리를 달성하다"
  },
  Task_79330_Desc = {
    Text = "「주점의 문」을 사용하여 1회 승리를 획득"
  },
  Task_79331_Desc = {
    Text = "「영원한 집착」을 사용하여 3번 승리하기"
  },
  Task_79332_Desc = {
    Text = "「작은 소원」을 사용하여 1회 승리"
  },
  Task_79333_Desc = {
    Text = "「문의 답」을 사용하여 6번의 승리를 획득"
  },
  Task_79334_Desc = {
    Text = "「청석 왕좌」를 사용하여 6번 승리하기"
  },
  Task_79335_Desc = {
    Text = "「별들의 가호」를 사용하여 1번의 승리를 획득."
  },
  Task_79336_Desc = {
    Text = "「산맥의 각오」를 사용하여 6번 승리 획득하기"
  },
  Task_79337_Desc = {
    Text = "사용 「태양의 낙타」로 6번 승리"
  },
  Task_79338_Desc = {
    Text = "「아쿠트의 봄」을 사용하여 6번 승리하기"
  },
  Task_79339_Desc = {
    Text = "「쥐의 지혜」를 사용하여 6회 승리"
  },
  Task_79340_Desc = {
    Text = "「폭식」 사용하여 6번의 승리 획득"
  },
  Task_79341_Desc = {
    Text = "「불멸의 장례식」을 사용하여 6번 승리"
  },
  Task_79342_Desc = {
    Text = "「해의 제전」을 사용하여 6번 승리."
  },
  Task_79343_Desc = {
    Text = "사용 「주사수호」 획득 1회 승리"
  },
  Task_79344_Desc = {
    Text = "사용 「주사수호」 3번 승리 획득"
  },
  Task_79345_Desc = {
    Text = "「주점의 문」으로 3번 승리하기"
  },
  Task_79346_Desc = {
    Text = "「과거의 꽃과 시」를 사용하여 3번 승리하기"
  },
  Task_79347_Desc = {
    Text = "「회전, 회전」 사용으로 1번 승리."
  },
  Task_79348_Desc = {
    Text = "「마녀 넓은 챙 모자」 사용하여 6번 승리"
  },
  Task_79349_Desc = {
    Text = "「회고의 문을 넘어가다」를 사용하여 3번의 승리를 획득"
  },
  Task_79350_Desc = {
    Text = "「네번째 악장」을 사용해 6번 승리하기"
  },
  Task_79351_Desc = {
    Text = "「청석 왕좌」를 사용하여 1번 승리"
  },
  Task_79352_Desc = {
    Text = "사용하여 「네번째 악장」으로 획득 1회 승리"
  },
  Task_79353_Desc = {
    Text = "「주점의 문」을 사용하여 6번 승리 획득하기"
  },
  Task_79354_Desc = {
    Text = "사용 「무속역병」 6번의 승리를 획득"
  },
  Task_79355_Desc = {
    Text = "「한 발의 총소리」로 6번의 승리를 획득했다."
  },
  Task_79356_Desc = {
    Text = "「마녀 넓은 챙 모자」를 사용하여 1번의 승리를 획득"
  },
  Task_79357_Desc = {
    Text = "「회전, 회전」을 사용하여 3번의 승리를 획득하기"
  },
  Task_79358_Desc = {
    Text = "「부패한 연회」 사용하여 1회 승리 획득"
  },
  Task_79359_Desc = {
    Text = "「청석 왕좌」를 사용하여 3번 승리하기"
  },
  Task_79360_Desc = {
    Text = "「뜨거운 이별의 키스」를 사용하여 3번의 승리를 획득하세요."
  },
  Task_79361_Desc = {
    Text = "「영혼의 탄생」을 사용하여 3번의 승리를 획득하세요."
  },
  Task_79362_Desc = {
    Text = "「영원한 집착」 사용하여 1회 승리."
  },
  Task_79363_Desc = {
    Text = "「회고의 문을 넘어가다」를 사용하여 1회 승리 달성"
  },
  Task_79364_Desc = {
    Text = "「뜨거운 이별의 키스」를 사용하여 1회 승리"
  },
  Task_79365_Desc = {
    Text = "「과거의 꽃과 시」를 사용하여 6번 승리하기"
  },
  Task_79366_Desc = {
    Text = "「별들의 가호」를 사용하여 6번 승리"
  },
  Task_79367_Desc = {
    Text = "「봄의 헌시」를 사용하여 1회 승리"
  },
  Task_79368_Desc = {
    Text = "「산맥의 각오」를 사용하여 1회 승리 획득"
  },
  Task_79369_Desc = {
    Text = "「아쿠트의 봄」을 사용하여 3번 승리하기"
  },
  Task_79370_Desc = {
    Text = "「주사수호」 사용하여 6번 승리"
  },
  Task_79371_Desc = {
    Text = "「마녀 넓은 챙 모자」를 사용해 3번의 승리를 획득하기"
  },
  Task_79372_Desc = {
    Text = "사용 「해의 제전」 3번 승리 획득"
  },
  Task_79373_Desc = {
    Text = "「회고의 문을 넘어가다」를 사용하여 6번의 승리를 획득"
  },
  Task_79374_Desc = {
    Text = "「순백의 첫 만남」을 사용해 6번 승리하기"
  },
  Task_79375_Desc = {
    Text = "「작은 소원」을 사용하여 6회 승리"
  },
  Task_79376_Desc = {
    Text = "「폭식」 사용하여 3번의 승리 획득"
  },
  Task_79377_Desc = {
    Text = "해의 제전을 사용하여 1회 승리를 획득하세요"
  },
  Task_79378_Desc = {
    Text = "사용 「네번째 악장」으로 3번 승리하기"
  },
  Task_79379_Desc = {
    Text = "「폭식」으로 한 번 승리하기"
  },
  Task_79380_Desc = {
    Text = "「문의 답」을 사용하여 3번의 승리를 획득하기."
  },
  Task_79381_Desc = {
    Text = "「과거의 꽃과 시」를 사용하여 1번 승리하세요."
  },
  Task_79382_Desc = {
    Text = "「목동의 지팡이」를 사용하여 1회 승리"
  },
  Task_79383_Desc = {
    Text = "「한 발의 총소리」로 3번 승리"
  },
  Task_79384_Desc = {
    Text = "사용하여 「영혼의 탄생」 6개의 승리 획득"
  },
  Task_79385_Desc = {
    Text = "「아쿠트의 봄」을 사용하여 1번 승리"
  },
  Task_79386_Desc = {
    Text = "「영원한 집착」을 사용하여 6번 승리하기"
  },
  Task_79387_Desc = {
    Text = "「봄의 헌시」를 사용하여 3회 승리"
  },
  Task_79483_Desc = {
    Text = "공포 치유·경계역"
  },
  Task_79484_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「공포 치유」에서 2번 승리"
  },
  Task_79485_Desc = {
    Text = "깊은 바다 영역 깨어남체를 사용하여 「공포 치유」에서 한 번 승리"
  },
  Task_79486_Desc = {
    Text = "클리어 「기억 클리닉」 어떤 난이도"
  },
  Task_79487_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「공포 치료」에서 2번 승리하기"
  },
  Task_79488_Desc = {
    Text = "초원차원 깨어남체를 사용하여 「공포 치유」에서 한 번 승리"
  },
  Task_79489_Desc = {
    Text = "클리어 「신생」 광기 난이도"
  },
  Task_79490_Desc = {
    Text = "공포 치유·클리어"
  },
  Task_79491_Desc = {
    Text = "클리어 「화염의 나비」 아무 난이도"
  },
  Task_79492_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용해 「공포 치유」에서 1회 승리"
  },
  Task_79493_Desc = {
    Text = "혈육 경계역의 깨어남체를 사용하여 「공포 치료」에서 2번 승리하기"
  },
  Task_79494_Desc = {
    Text = "클리어 「신생」 임의의 난이도"
  },
  Task_79495_Desc = {
    Text = "클리어 「타오르는 세계」광기 난이도"
  },
  Task_79496_Desc = {
    Text = "클리어 「꿈을 침입할 때」 광기 모드"
  },
  Task_79497_Desc = {
    Text = "클리어 「기억 클리닉」 어떤 난이도"
  },
  Task_79498_Desc = {
    Text = "클리어 「화염의 나비」 아무 난이도"
  },
  Task_79499_Desc = {
    Text = "클리어 「타오르는 세계」 임의 난이도"
  },
  Task_79500_Desc = {
    Text = "공포 치유·광기"
  },
  Task_79501_Desc = {
    Text = "클리어 「타오르는 세계」 임의 난이도"
  },
  Task_79502_Desc = {
    Text = "클리어 「꿈을 침입할 때」 아무 난이도"
  },
  Task_79503_Desc = {
    Text = "카오스 경계역 깨어남체를 사용하여 「공포 치유」에서 1회 승리"
  },
  Task_79504_Desc = {
    Text = "카오스 경계역 깨어남체로 「공포 치료」에서 2번 승리하기"
  },
  Task_79505_Desc = {
    Text = "클리어 「신생」 임의의 난이도"
  },
  Task_79506_Desc = {
    Text = "클리어 「화염의 나비」 광기 난이도"
  },
  Task_79507_Desc = {
    Text = "「공포 치료·클리어」 모든 태스크 완료"
  },
  Task_79508_Desc = {
    Text = "클리어 「꿈을 침입할 때」 아무 난이도"
  },
  Task_79509_Desc = {
    Text = "클리어 「기억 클리닉」 광기 난이도로"
  },
  Task_79747_Desc = {
    Text = "클레멘타인 획득"
  },
  Task_79747_Name = {
    Text = "클레멘타인 획득"
  },
  Task_80218_Desc = {
    Text = "길을 막고 있는 「주민」 격파"
  },
  Task_80218_Name = {Text = "목표"},
  Task_80219_Desc = {
    Text = "「생명 의식」 저지"
  },
  Task_80219_Name = {Text = "목표"},
  Task_80220_Desc = {
    Text = "우주@2의 투영 격파"
  },
  Task_80220_Name = {Text = "목표"},
  Task_80221_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80221_Name = {
    Text = "완벽한 통과"
  },
  Task_80222_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80222_Name = {
    Text = "완벽한 통과"
  },
  Task_80223_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80223_Name = {
    Text = "완벽한 통과"
  },
  Task_80224_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80224_Name = {
    Text = "완벽한 통과"
  },
  Task_80225_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80225_Name = {
    Text = "완벽한 통과"
  },
  Task_80226_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80226_Name = {
    Text = "완벽한 통과"
  },
  Task_80227_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80227_Name = {
    Text = "완벽한 통과"
  },
  Task_80228_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80228_Name = {
    Text = "완벽한 통과"
  },
  Task_80229_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80229_Name = {
    Text = "완벽한 통과"
  },
  Task_80230_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80230_Name = {
    Text = "완벽한 통과"
  },
  Task_80231_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80231_Name = {
    Text = "완벽한 통과"
  },
  Task_80232_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_80232_Name = {
    Text = "완벽한 통과"
  },
  Task_80233_Desc = {
    Text = "「라모나」 확인하기"
  },
  Task_80233_Name = {Text = "목표"},
  Task_80234_Desc = {
    Text = "순찰대에 잡히지 않도록 피하기"
  },
  Task_80234_Name = {Text = "목표"},
  Task_80235_Desc = {
    Text = "「클레멘타인」들로부터 벗어나기"
  },
  Task_80235_Name = {Text = "목표"},
  Task_80236_Desc = {
    Text = "클레멘타인의 진료실타래로 향하기"
  },
  Task_80236_Name = {Text = "목표"},
  Task_80237_Desc = {Text = "귀환"},
  Task_80237_Name = {Text = "목표"},
  Task_80238_Desc = {
    Text = "허버트의 「수용」 저지"
  },
  Task_80238_Name = {Text = "목표"},
  Task_80239_Desc = {
    Text = "의사의 추적으로부터 벗어나기"
  },
  Task_80239_Name = {Text = "목표"},
  Task_80240_Desc = {
    Text = "알비노의 기억 파고들기"
  },
  Task_80240_Name = {Text = "목표"},
  Task_80241_Desc = {
    Text = "발광한 환자 제압"
  },
  Task_80241_Name = {Text = "목표"},
  Task_80286_Desc = {
    Text = "별의 편 2장 2-9를 통과하세요"
  },
  Task_80287_Desc = {
    Text = "별의 편 2장 2-6 어려움 난이도를 통과하세요"
  },
  Task_80288_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_80288_Desc2 = {
    Text = "조사 사건 '변화'를 완료했습니다"
  },
  Task_80288_Name2 = {
    Text = "우주의 윙윙거림을 듣고"
  },
  Task_80289_Desc = {
    Text = "조사 사건 '변화' 어려움 난이도를 완료했습니다"
  },
  Task_80289_Name = {
    Text = "우주의 윙윙거림·어려움"
  },
  Task_80290_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80291_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80292_Desc = {
    Text = "별의 편 2장 「탈피」를 통과하세요"
  },
  Task_80293_Desc = {
    Text = "별의 편 2장 「탈피」 어려움 난이도를 통과하세요"
  },
  Task_80294_Desc = {
    Text = "별의 편 2장 2-6 어려움 난이도를 통과하세요"
  },
  Task_80295_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 9번"
  },
  Task_80295_Desc2 = {
    Text = "사건 「탈바꿈」에서 9회 공명"
  },
  Task_80295_Name2 = {
    Text = "변이 메아리Ⅲ"
  },
  Task_80296_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_80296_Desc2 = {
    Text = "조사 사건 「변화」에서 공명 6회"
  },
  Task_80296_Name2 = {
    Text = "변이 메아리Ⅱ"
  },
  Task_80297_Desc = {
    Text = "조사 이벤트 「@1@2」에서 공명 3회"
  },
  Task_80297_Desc2 = {
    Text = "조사 사건 「변화」에서 공명 3회"
  },
  Task_80297_Name2 = {
    Text = "변이 메아리"
  },
  Task_80298_Desc = {
    Text = "별의 편 2장 2-9를 통과하세요"
  },
  Task_80299_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 11번 발생"
  },
  Task_80299_Desc2 = {
    Text = "사건 「탈바꿈」에서 11회 공명"
  },
  Task_80299_Name2 = {
    Text = "변이 메아리Ⅳ"
  },
  Task_80300_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80301_Desc = {
    Text = "별의 편 2장 「탈피」를 통과하세요"
  },
  Task_80302_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80303_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80304_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80305_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80306_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80307_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80309_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_80310_Desc = {
    Text = "별의 편 2장 「탈피」 어려움 난이도를 통과하세요"
  },
  Task_80419_Name = {
    Text = "성신편 2-18 다시 클리어"
  },
  Task_80433_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_80433_Name = {Text = "10승"},
  Task_80434_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_80434_Name = {Text = "6승"},
  Task_80435_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_80435_Name = {Text = "3승"},
  Task_80436_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_80436_Name = {Text = "1승"},
  Task_80993_Desc = {
    Text = "청소 도구 달성"
  },
  Task_80994_Desc = {
    Text = "각종 3개의 임무를 완료합니다"
  },
  Task_80994_Name = {
    Text = "오늘의 청소가 완료되었습니다!"
  },
  Task_80995_Desc = {
    Text = "이벤트 보상"
  },
  Task_80996_Desc = {
    Text = "청소 도구 달성"
  },
  Task_80997_Desc = {
    Text = "100000 장미 금권 소모"
  },
  Task_80997_Name = {
    Text = "배낭 정리"
  },
  Task_80998_Desc = {
    Text = "청소 도구 달성"
  },
  Task_80999_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81000_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_81001_Desc = {
    Text = "어떤 조사 작전 활동도 1회 클리어"
  },
  Task_81001_Name = {
    Text = "추억을 되찾다"
  },
  Task_81002_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_81003_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81004_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81005_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81006_Desc = {
    Text = "이벤트 임무"
  },
  Task_81007_Desc = {
    Text = "1회 페이즈 체스를 완료했습니다"
  },
  Task_81007_Name = {
    Text = "차원 소독"
  },
  Task_81008_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_81009_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_81010_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81011_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_81012_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_81013_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_81014_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81015_Desc = {
    Text = "청소 도구 달성"
  },
  Task_81016_Desc = {
    Text = "융해의 폐허에서 180 엘릭틴을 소모한다"
  },
  Task_81016_Name = {
    Text = "부식 정화"
  },
  Task_81017_Desc = {
    Text = "7일 로그인"
  },
  Task_81018_Desc = {
    Text = "환상 잠수 1회 통과"
  },
  Task_81018_Name = {
    Text = "꿈의 환기"
  },
  Task_81083_Desc = {
    Text = "심해 미항·광란"
  },
  Task_81084_Desc = {
    Text = "‘최종 애가’를 임의 난이도로 통과하다"
  },
  Task_81085_Desc = {
    Text = "심해 영역의 깨어남체로 「심해 미로」에서 2회 승리"
  },
  Task_81086_Desc = {
    Text = "‘오래된 나침반’을 임의 난이도로 통과하다"
  },
  Task_81087_Desc = {
    Text = "심해 영역의 깨어남체로 「심해 미로」에서 1회 승리"
  },
  Task_81088_Desc = {
    Text = "‘최종 애가’를 임의 난이도로 통과하다"
  },
  Task_81089_Desc = {
    Text = "‘항해사 수첩’을 미친 난이도로 통과하다"
  },
  Task_81090_Desc = {
    Text = "‘인도자의 빛’을 미친 난이도로 통과하다"
  },
  Task_81091_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「심해 미항」에서 2회 승리했습니다"
  },
  Task_81092_Desc = {
    Text = "‘구형 육분의’를 미친 난이도로 통과하다"
  },
  Task_81093_Desc = {
    Text = "의식 잠수 ‘마지막 항해’를 통과하다"
  },
  Task_81094_Desc = {
    Text = "‘오래된 나침반’을 미친 난이도로 통과하다"
  },
  Task_81095_Desc = {
    Text = "‘인도자의 빛’을 임의 난이도로 통과하다"
  },
  Task_81096_Desc = {
    Text = "‘오래된 나침반’을 임의 난이도로 통과하다"
  },
  Task_81097_Desc = {
    Text = "「심해 미항로·통과」의 모든 업적을 완료했다"
  },
  Task_81098_Desc = {
    Text = "‘인도자의 빛’을 임의 난이도로 통과하다"
  },
  Task_81099_Desc = {
    Text = "「별의 궤적」 광란 난이도를 클리어하다"
  },
  Task_81100_Desc = {
    Text = "「별의 궤적」의 임의 난이도를 클리어하다"
  },
  Task_81101_Desc = {
    Text = "‘신호 깃발 언어’를 임의 난이도로 통과하다"
  },
  Task_81102_Desc = {
    Text = "‘신호 깃발 언어’를 임의 난이도로 통과하다"
  },
  Task_81103_Desc = {
    Text = "‘구형 육분의’를 임의 난이도로 통과하다"
  },
  Task_81104_Desc = {
    Text = "‘고대 해도’를 임의 난이도로 통과하다"
  },
  Task_81105_Desc = {
    Text = "‘신호 깃발 언어’ 미친 난이도로 통과하다"
  },
  Task_81106_Desc = {
    Text = "‘항해사 수첩’을 임의 난이도로 통과하다"
  },
  Task_81107_Desc = {
    Text = "‘항해사 수첩’을 임의 난이도로 통과하다"
  },
  Task_81108_Desc = {
    Text = "‘얼룩진 별 판’을 임의 난이도로 통과하다"
  },
  Task_81109_Desc = {
    Text = "혈육 영역의 깨어남체로 「심해 미로」에서 1회 승리"
  },
  Task_81110_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「심해 미항」에서 1회 승리했습니다"
  },
  Task_81111_Desc = {
    Text = "‘최종 애가’를 미친 난이도로 통과하다"
  },
  Task_81112_Desc = {
    Text = "심해 미항·통과"
  },
  Task_81113_Desc = {
    Text = "「별의 궤적」의 임의 난이도를 클리어하다"
  },
  Task_81114_Desc = {
    Text = "‘고대 해도’를 임의 난이도로 통과하다"
  },
  Task_81115_Desc = {
    Text = "‘고대 해도’를 미친 난이도로 통과하다"
  },
  Task_81116_Desc = {
    Text = "‘얼룩진 별 판’을 미친 난이도로 통과하다"
  },
  Task_81117_Desc = {
    Text = "‘구형 육분의’를 임의 난이도로 통과하다"
  },
  Task_81118_Desc = {
    Text = "‘얼룩진 별 판’을 임의 난이도로 통과하다"
  },
  Task_81119_Desc = {
    Text = "심해 미항·경계"
  },
  Task_81120_Desc = {
    Text = "혼돈 영역의 깨어남체로 「심해 미로」에서 2회 승리"
  },
  Task_81121_Desc = {
    Text = "혈육 영역의 깨어남체로 「심해 미로」에서 2회 승리"
  },
  Task_81122_Desc = {
    Text = "혼돈 영역의 깨어남체로 「심해 미로」에서 1회 승리"
  },
  Task_81481_Desc = {
    Text = "링·라모나의 도움 없이 '우주@2 투영'을 처치합니다."
  },
  Task_81481_Name = {
    Text = "우주의 윙윙거림을 듣다·숨겨진"
  },
  Task_81772_Name = {
    Text = "보스 1N회 격파"
  },
  Task_81773_Name = {
    Text = "보스 7N회 격파"
  },
  Task_81774_Name = {
    Text = "모든 보스 격파"
  },
  Task_81775_Name = {
    Text = "보스 3N회 격파"
  },
  Task_81776_Name = {
    Text = "보스 2N회 격파"
  },
  Task_81777_Name = {
    Text = "보스 6N회 격파"
  },
  Task_81778_Name = {
    Text = "보스 4N회 격파"
  },
  Task_81779_Name = {
    Text = "보스 5N회 격파"
  },
  Task_84111_Name = {
    Text = "다시 클레바샨트 서브 퀘스트 일반 4 통과"
  },
  Task_84143_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_84144_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_84145_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_84146_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_84147_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_84148_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_84149_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_84150_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_84151_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_84152_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_84153_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_84154_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_84155_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_84156_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_84157_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_84158_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_84159_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_84160_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_84161_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_84162_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_84163_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_84164_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_84165_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_84166_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_84167_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_84168_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_84169_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_84170_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_84171_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_84172_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_84323_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_84323_Name = {Text = "3승"},
  Task_84324_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_84324_Name = {Text = "6승"},
  Task_84325_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_84325_Name = {Text = "1승"},
  Task_84326_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_84326_Name = {Text = "10승"},
  Task_84349_Desc = {
    Text = "의식 잠수 「마지막 항해」 완료"
  },
  Task_84349_Name = {
    Text = "별과 심연의 인도"
  },
  Task_88945_Desc = {
    Text = "「감옥을 부수기」의 어떤 난이도로 클리어하세요"
  },
  Task_88946_Desc = {
    Text = "이몽 시야「하늘 너머·상」을 클리어 합니다"
  },
  Task_88947_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 2회 승리한다"
  },
  Task_88948_Desc = {
    Text = "「고독한 여정」의 어떤 난이도로 클리어하세요"
  },
  Task_88949_Desc = {
    Text = "심해 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 1회 승리한다"
  },
  Task_88950_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 1회 승리한다"
  },
  Task_88951_Desc = {
    Text = "「전등을 전하는 자」의 어떤 난이도로 클리어하세요"
  },
  Task_88952_Desc = {
    Text = "「감옥을 부수기」의 광란 난이도로 클리어하세요"
  },
  Task_88953_Desc = {
    Text = "「감옥을 부수기」의 어떤 난이도로 클리어하세요"
  },
  Task_88954_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 1회 승리한다"
  },
  Task_88955_Desc = {
    Text = "「자유와 죽음」의 광란 난이도로 클리어하세요"
  },
  Task_88956_Desc = {
    Text = "「고독한 여정」의 어떤 난이도로 클리어하세요"
  },
  Task_88957_Desc = {
    Text = "푸른 하늘로의 도약·광란"
  },
  Task_88958_Desc = {
    Text = "「자유와 죽음」의 어떤 난이도로 클리어하세요"
  },
  Task_88959_Desc = {
    Text = "「자유와 죽음」의 어떤 난이도로 클리어하세요"
  },
  Task_88960_Desc = {
    Text = "「끝없는 모래」의 어떤 난이도로 클리어하세요"
  },
  Task_88961_Desc = {
    Text = "「푸른 하늘을 뛰어넘다·통과」의 모든 업적 완료"
  },
  Task_88962_Desc = {
    Text = "「전등을 전하는 자」의 어떤 난이도로 클리어하세요"
  },
  Task_88963_Desc = {
    Text = "「끝없는 모래」의 광란 난이도로 클리어하세요"
  },
  Task_88964_Desc = {
    Text = "「바보」의 광란 난이도로 클리어하세요"
  },
  Task_88965_Desc = {
    Text = "「어제의 꿈」의 광란 난이도로 클리어하세요"
  },
  Task_88966_Desc = {
    Text = "「고독한 여정」의 광란 난이도로 클리어하세요"
  },
  Task_88967_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 2회 승리한다"
  },
  Task_88968_Desc = {
    Text = "「어제의 꿈」의 어떤 난이도로 클리어하세요"
  },
  Task_88969_Desc = {
    Text = "푸른 하늘로의 도약·경계"
  },
  Task_88970_Desc = {
    Text = "심해 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 2회 승리한다"
  },
  Task_88971_Desc = {
    Text = "푸른 하늘로의 도약·클리어"
  },
  Task_88972_Desc = {
    Text = "「끝없는 모래」의 어떤 난이도로 클리어하세요"
  },
  Task_88973_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 1회 승리한다"
  },
  Task_88974_Desc = {
    Text = "「바보」의 어떤 난이도로 클리어하세요"
  },
  Task_88975_Desc = {
    Text = "「전등을 전하는 자」의 광란 난이도로 클리어하세요"
  },
  Task_88976_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여「푸른 하늘의 도약」에서 2회 승리한다"
  },
  Task_88977_Desc = {
    Text = "「어제의 꿈」의 어떤 난이도로 클리어하세요"
  },
  Task_88978_Desc = {
    Text = "「바보」의 어떤 난이도로 클리어하세요"
  },
  Task_89577_Desc = {
    Text = "누적 로그인 12일"
  },
  Task_89578_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_89579_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_89580_Desc = {
    Text = "누적 로그인 10일"
  },
  Task_89581_Desc = {
    Text = "누적 로그인 11일"
  },
  Task_89582_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_89583_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_89584_Desc = {
    Text = "누적 로그인 16일"
  },
  Task_89585_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_89586_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_89587_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_89588_Desc = {
    Text = "누적 로그인 14일"
  },
  Task_89589_Desc = {
    Text = "누적 로그인 8일"
  },
  Task_89590_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_89591_Desc = {
    Text = "누적 로그인 13일"
  },
  Task_89592_Desc = {
    Text = "누적 로그인 9일"
  },
  Task_89844_Desc = {
    Text = "첫 번째 운세 계약 깨어남({s1}/1)"
  },
  Task_89844_Name = {
    Text = "임무 완료를 통해 의상 교환권 획득"
  },
  Task_89845_Desc = {
    Text = "7일 로그인 ({s1}/7)"
  },
  Task_89845_Name = {
    Text = "임무 완료를 통해 의상 교환권 획득"
  },
  Task_89846_Desc = {
    Text = "이동하는 해조 집단을 물리치세요({s1}/30)"
  },
  Task_89846_Name = {
    Text = "임무 완료를 통해 의상 교환권 획득"
  },
  Task_90036_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_90036_Name = {Text = "6승"},
  Task_90037_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_90037_Name = {Text = "3승"},
  Task_90038_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_90038_Name = {Text = "10승"},
  Task_90039_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_90039_Name = {Text = "1승"},
  Task_90495_Desc = {
    Text = "실타래전 강의·혼돈의 의념 완료하기"
  },
  Task_90495_Name = {
    Text = "혼돈의 의념"
  },
  Task_90866_Desc = {
    Text = "심연의 태동Ⅰ"
  },
  Task_90867_Desc = {
    Text = "만원의 의지Ⅰ"
  },
  Task_90868_Desc = {
    Text = "임시 텍스트·무료"
  },
  Task_90869_Desc = {
    Text = "두개골의 애가Ⅶ"
  },
  Task_90870_Desc = {
    Text = "임시 텍스트Ⅳ"
  },
  Task_90871_Desc = {
    Text = "공약명도Ⅲ"
  },
  Task_90872_Desc = {
    Text = "두개골의 애가Ⅰ"
  },
  Task_90873_Desc = {
    Text = "만원의 의지Ⅴ"
  },
  Task_90874_Desc = {
    Text = "심연의 태동Ⅵ"
  },
  Task_90875_Desc = {
    Text = "임시 텍스트Ⅰ"
  },
  Task_90876_Desc = {
    Text = "심연의 태동·무료"
  },
  Task_90877_Desc = {
    Text = "두개골의 애가·무료"
  },
  Task_90878_Desc = {
    Text = "두개골의 애가Ⅵ"
  },
  Task_90879_Desc = {
    Text = "만원의 의지Ⅳ"
  },
  Task_90880_Desc = {
    Text = "만원의 의지·무료"
  },
  Task_90881_Desc = {
    Text = "두개골의 애가Ⅲ"
  },
  Task_90882_Desc = {
    Text = "공혼명도Ⅱ"
  },
  Task_90883_Desc = {
    Text = "임시 텍스트Ⅴ"
  },
  Task_90884_Desc = {
    Text = "두개골의 애가Ⅴ"
  },
  Task_90885_Desc = {
    Text = "임시 텍스트Ⅵ"
  },
  Task_90886_Desc = {
    Text = "임시 텍스트Ⅶ"
  },
  Task_90887_Desc = {
    Text = "한 쌍의 운명Ⅵ"
  },
  Task_90888_Desc = {
    Text = "공명 명운Ⅳ"
  },
  Task_90889_Desc = {
    Text = "두개골의 애가Ⅳ"
  },
  Task_90890_Desc = {
    Text = "공액 운명Ⅴ"
  },
  Task_90891_Desc = {
    Text = "공변 명운Ⅰ"
  },
  Task_90892_Desc = {
    Text = "만원의 의지Ⅲ"
  },
  Task_90893_Desc = {
    Text = "심연의 태동Ⅱ"
  },
  Task_90894_Desc = {
    Text = "임시 텍스트Ⅲ"
  },
  Task_90895_Desc = {
    Text = "공액 운명Ⅶ"
  },
  Task_90896_Desc = {
    Text = "두개골의 애가Ⅱ"
  },
  Task_90897_Desc = {
    Text = "심연의 태동Ⅶ"
  },
  Task_90898_Desc = {
    Text = "심연의 태동Ⅴ"
  },
  Task_90899_Desc = {
    Text = "심연의 태동Ⅳ"
  },
  Task_90900_Desc = {
    Text = "만원의 의지Ⅵ"
  },
  Task_90901_Desc = {
    Text = "공명 운명·무료"
  },
  Task_90902_Desc = {
    Text = "만원의 의지Ⅱ"
  },
  Task_90903_Desc = {
    Text = "심연의 태동Ⅲ"
  },
  Task_90904_Desc = {
    Text = "만원의 의지Ⅶ"
  },
  Task_90905_Desc = {
    Text = "임시 텍스트 Ⅱ"
  },
  Task_91028_Desc = {
    Text = "'전사 왕관'의 광란 난이도를 클리어합니다"
  },
  Task_91029_Desc = {
    Text = "사용 혼돈 영역 깨어남체가「신성한 사냥」에서 1회 승리"
  },
  Task_91030_Desc = {
    Text = "사용 혈육 영역 깨어남체가「신성한 사냥」에서 1회 승리"
  },
  Task_91031_Desc = {
    Text = "사용 초차원 영역 깨어남체가「신성한 사냥」에서 1회 승리"
  },
  Task_91032_Desc = {
    Text = "사용 혈육 영역 깨어남체가「신성한 사냥」에서 2회 승리"
  },
  Task_91033_Desc = {
    Text = "신성한 사냥·통과"
  },
  Task_91034_Desc = {
    Text = "'무서운 사냥꾼'의 임의 난이도를 클리어합니다"
  },
  Task_91035_Desc = {
    Text = "신성한 사냥·광란"
  },
  Task_91036_Desc = {
    Text = "'원정 나팔'의 임의 난이도를 클리어합니다"
  },
  Task_91037_Desc = {
    Text = "'협력 지혜'의 임의 난이도를 클리어합니다"
  },
  Task_91038_Desc = {
    Text = "사용 심해 영역 깨어남체가「신성한 사냥」에서 2회 승리"
  },
  Task_91039_Desc = {
    Text = "사용 초차원 영역 깨어남체가「신성한 사냥」에서 2회 승리"
  },
  Task_91040_Desc = {
    Text = "통과하라 이몽 시야「주방의 전쟁」"
  },
  Task_91041_Desc = {
    Text = "'전사 왕관'의 임의 난이도를 클리어합니다"
  },
  Task_91042_Desc = {
    Text = "'전사 왕관'의 임의 난이도를 클리어합니다"
  },
  Task_91043_Desc = {
    Text = "사용 심해 영역 깨어남체가「신성한 사냥」에서 1회 승리"
  },
  Task_91044_Desc = {
    Text = "'영광의 귀환'의 임의 난이도를 클리어합니다"
  },
  Task_91045_Desc = {
    Text = "'무서운 사냥꾼'의 임의 난이도를 클리어합니다"
  },
  Task_91046_Desc = {
    Text = "'협력 지혜'의 광란 난이도를 클리어합니다"
  },
  Task_91047_Desc = {
    Text = "'원정 나팔'의 임의 난이도를 클리어합니다"
  },
  Task_91048_Desc = {
    Text = "'협력 지혜'의 임의 난이도를 클리어합니다"
  },
  Task_91049_Desc = {
    Text = "'영광의 귀환'의 임의 난이도를 클리어합니다"
  },
  Task_91050_Desc = {
    Text = "「신성한 사냥·통과」의 모든 성취를 완료합니다"
  },
  Task_91051_Desc = {
    Text = "'원정 나팔'의 광란 난이도를 클리어합니다"
  },
  Task_91052_Desc = {
    Text = "'영광의 귀환'의 광란 난이도를 클리어합니다"
  },
  Task_91053_Desc = {
    Text = "신성한 사냥·경계"
  },
  Task_91054_Desc = {
    Text = "'무서운 사냥꾼'의 광란 난이도를 클리어합니다"
  },
  Task_91055_Desc = {
    Text = "사용 혼돈 영역 깨어남체가「신성한 사냥」에서 2회 승리"
  },
  Task_91129_Desc = {
    Text = "레벨이 20레벨에 도달했습니다"
  },
  Task_91131_Desc = {
    Text = "레벨이 5레벨에 도달했습니다"
  },
  Task_91149_Desc = {
    Text = "레벨이 15레벨에 도달했습니다"
  },
  Task_91154_Desc = {
    Text = "레벨이 10레벨에 도달했습니다"
  },
  Task_91332_Desc = {
    Text = "도어세인 격파"
  },
  Task_91332_Name = {Text = "목표"},
  Task_91333_Desc = {
    Text = "침입자 격파"
  },
  Task_91333_Name = {Text = "목표"},
  Task_91334_Desc = {
    Text = "「부패의 인형」을 격파하고, 유해 궁전 지키기"
  },
  Task_91334_Name = {Text = "목표"},
  Task_91335_Desc = {
    Text = "도해자 격파"
  },
  Task_91335_Name = {Text = "목표"},
  Task_91336_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91336_Name = {
    Text = "완벽한 통과"
  },
  Task_91337_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91337_Name = {
    Text = "완벽한 통과"
  },
  Task_91338_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91338_Name = {
    Text = "완벽한 통과"
  },
  Task_91339_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91339_Name = {
    Text = "완벽한 통과"
  },
  Task_91340_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91340_Name = {
    Text = "완벽한 통과"
  },
  Task_91341_Desc = {
    Text = "픽맨의 「그림」 파괴"
  },
  Task_91341_Name = {Text = "목표"},
  Task_91342_Desc = {
    Text = "적을 물리치고 구울 궁전에 진입"
  },
  Task_91342_Name = {Text = "목표"},
  Task_91343_Desc = {
    Text = "구울의 추적에서 벗어나기"
  },
  Task_91343_Name = {Text = "목표"},
  Task_91344_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91344_Name = {
    Text = "완벽한 통과"
  },
  Task_91345_Desc = {
    Text = "융식체 격파"
  },
  Task_91345_Name = {Text = "목표"},
  Task_91346_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91346_Name = {
    Text = "완벽한 통과"
  },
  Task_91347_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91347_Name = {
    Text = "완벽한 통과"
  },
  Task_91348_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91348_Name = {
    Text = "완벽한 통과"
  },
  Task_91349_Desc = {
    Text = "골리아를 격퇴하고, 법진 파괴하기"
  },
  Task_91349_Name = {Text = "목표"},
  Task_91350_Desc = {
    Text = "응급 영지체를 사용하지 않고 클리어"
  },
  Task_91350_Name = {
    Text = "완벽한 통과"
  },
  Task_91351_Desc = {
    Text = "집사 프란 격파"
  },
  Task_91351_Name = {Text = "목표"},
  Task_91357_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91358_Desc = {
    Text = "통과 별자리 편 제3장 3-5"
  },
  Task_91359_Desc = {
    Text = "조사 완료 이벤트 「@1@2」"
  },
  Task_91359_Desc2 = {
    Text = "사건 조사 「욕구」를 완료합니다"
  },
  Task_91359_Name2 = {
    Text = "뼈와 영혼의 공동 식사"
  },
  Task_91360_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91361_Desc = {
    Text = "통과 별자리 편 제3장 3-5 어려움 난이도"
  },
  Task_91362_Desc = {
    Text = "통과 별자리 편 제3장「만족」어려움 난이도"
  },
  Task_91363_Desc = {
    Text = "조사 사건 '만족' 어려움 난이도 완료"
  },
  Task_91363_Name = {
    Text = "뼈와 영혼의 만찬·어려움"
  },
  Task_91364_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91365_Desc = {
    Text = "통과 별자리 편 제3장「만족」"
  },
  Task_91366_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91367_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91368_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91370_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91371_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91372_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91373_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_91379_Desc = {
    Text = "통과 별자리 편 제3장 2-5 어려움 난이도"
  },
  Task_91380_Desc = {
    Text = "통과 별자리 편 제3장 2-5"
  },
  Task_91381_Desc = {
    Text = "통과 별자리 편 제3장「만족」어려움 난이도"
  },
  Task_91382_Desc = {
    Text = "통과 별자리 편 제3장「만족」"
  },
  Task_91436_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_91436_Name = {Text = "1승"},
  Task_91437_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_91437_Name = {Text = "3승"},
  Task_91438_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_91438_Name = {Text = "6승"},
  Task_91439_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_91439_Name = {Text = "10승"},
  Task_91720_Desc = {
    Text = "7일 로그인 ({s1}/7)"
  },
  Task_91720_Name = {
    Text = "임무 완료를 통해 의상 교환권 획득"
  },
  Task_91721_Desc = {
    Text = "모든 광란 난이도 클리어({s1}/5)"
  },
  Task_91721_Name = {
    Text = "임무 완료를 통해 의상 교환권 획득"
  },
  Task_91786_Desc = {
    Text = "혈육 영역에서 깨어남체를 사용하여 「신국 강림」에서 2회 승리"
  },
  Task_91787_Desc = {
    Text = "혼돈 영역에서 깨어남체를 사용하여 「신국 강림」에서 2회 승리"
  },
  Task_91788_Desc = {
    Text = "심해 영역에서 깨어남체를 사용하여 「신국 강림」에서 2회 승리"
  },
  Task_91789_Desc = {
    Text = "초차원 영역에서 깨어남체를 사용하여 「신국 강림」에서 2회 승리"
  },
  Task_94489_Desc = {
    Text = "혼돈 영역 깨어남체 6명 레벨 80 달성"
  },
  Task_94489_Name = {
    Text = "혼돈 숙련 Ⅹ"
  },
  Task_94490_Desc = {
    Text = "심해 영역 깨어남체 6명 레벨 70 달성"
  },
  Task_94490_Name = {
    Text = "심해 숙련 Ⅸ"
  },
  Task_94491_Desc = {
    Text = "초차원 영역 깨어남체 6명 레벨 70 달성"
  },
  Task_94491_Name = {
    Text = "초차원 숙련 Ⅸ"
  },
  Task_94492_Desc = {
    Text = "혈육 영역 깨어남체 6명 레벨 80 달성"
  },
  Task_94492_Name = {
    Text = "혈육 숙련 Ⅹ"
  },
  Task_94493_Desc = {
    Text = "심해 영역 깨어남체 6명 레벨 80 달성"
  },
  Task_94493_Name = {
    Text = "심해 숙련 Ⅹ"
  },
  Task_94494_Desc = {
    Text = "혈육 영역 깨어남체 6명 레벨 70 달성"
  },
  Task_94494_Name = {
    Text = "혈육 숙련 Ⅸ"
  },
  Task_94495_Desc = {
    Text = "혼돈 영역 깨어남체 6명 레벨 70 달성"
  },
  Task_94495_Name = {
    Text = "혼돈 숙련 Ⅸ"
  },
  Task_94496_Desc = {
    Text = "초차원 영역 깨어남체 6명 레벨 80 달성"
  },
  Task_94496_Name = {
    Text = "초차원 숙련 Ⅹ"
  },
  Task_94497_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_94497_Name = {
    Text = "영역 숙련Ⅹ"
  },
  Task_94498_Desc = {
    Text = "이번 장의 모든 임무를 완료하여 보상 수령"
  },
  Task_94498_Name = {
    Text = "영역 숙련 Ⅸ"
  },
  Task_94613_Desc = {
    Text = "실타래전 강의·초차원 영역 완료하기"
  },
  Task_94613_Name = {
    Text = "초차원 영역"
  },
  Task_94614_Desc = {
    Text = "실타래전 강의·혈육의 증식 완료하기"
  },
  Task_94614_Name = {
    Text = "혈육의 증식"
  },
  Task_94615_Desc = {
    Text = "실타래전 강의·심해의 촉수 완료하기"
  },
  Task_94615_Name = {
    Text = "심해의 촉수"
  },
  Task_94699_Desc = {
    Text = "두개골 정원의 만가·한정 전용"
  },
  Task_94861_Desc = {
    Text = "1800 린피테이프 소모"
  },
  Task_94863_Desc = {
    Text = "누적 깨어남 100회"
  },
  Task_94865_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_94867_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_94871_Desc = {
    Text = "카티구라 체험 스테이지 1회 클리어"
  },
  Task_94874_Desc = {
    Text = "2주 동안 매주 시험 완료"
  },
  Task_94876_Desc = {
    Text = "1800 린피테이프 소모"
  },
  Task_94877_Desc = {
    Text = "파견 20회 완료"
  },
  Task_94882_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_94885_Desc = {
    Text = "2주 동안 매주 시험 완료"
  },
  Task_94886_Desc = {
    Text = "카티구라 체험 스테이지 1회 클리어"
  },
  Task_94888_Desc = {
    Text = "조력 깨어남체 3회 사용"
  },
  Task_94891_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_94895_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_94898_Desc = {
    Text = "누적 깨어남 100회"
  },
  Task_94901_Desc = {
    Text = "파견 20회 완료"
  },
  Task_95192_Desc = {
    Text = "「지표의 태양」의 광란 난이도를 클리어한다"
  },
  Task_95193_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「잿빛 추적」에서 2번 승리했습니다"
  },
  Task_95194_Desc = {
    Text = "통과「침묵의 세계」임의 난이도"
  },
  Task_95195_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「잿빛 추적」에서 1번 승리했습니다"
  },
  Task_95196_Desc = {
    Text = "의식 잠수 '불멸의 극주'를 통과한다"
  },
  Task_95197_Desc = {
    Text = "「계약 목표」의 임의 난이도를 클리어한다"
  },
  Task_95198_Desc = {
    Text = "통과「침묵의 세계」광란 난이도"
  },
  Task_95199_Desc = {
    Text = "「계약 목표」의 임의 난이도를 클리어한다"
  },
  Task_95200_Desc = {
    Text = "「지표의 태양」의 임의 난이도를 클리어한다"
  },
  Task_95201_Desc = {
    Text = "통과「화염의 선고」임의 난이도"
  },
  Task_95202_Desc = {
    Text = "심해 영역 깨어남체가 ‘잿더미 추격전’에서 1회 승리합니다"
  },
  Task_95203_Desc = {
    Text = "「고대의 맹세」의 임의 난이도를 클리어한다"
  },
  Task_95204_Desc = {
    Text = "통과「화염의 선고」임의 난이도"
  },
  Task_95205_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「잿빛 추적」에서 1번 승리했습니다"
  },
  Task_95206_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「잿빛 추적」에서 2번 승리했습니다"
  },
  Task_95207_Desc = {
    Text = "통과「덮치는 세계의 빛」임의 난이도"
  },
  Task_95208_Desc = {
    Text = "「지표의 태양」의 임의 난이도를 클리어한다"
  },
  Task_95209_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「잿빛 추적」에서 1번 승리했습니다"
  },
  Task_95210_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「잿빛 추적」에서 2번 승리했습니다"
  },
  Task_95211_Desc = {
    Text = "통과「화염의 선고」광란 난이도"
  },
  Task_95212_Desc = {
    Text = "재로 소멸된 추격·광란"
  },
  Task_95213_Desc = {
    Text = "심해 영역 깨어남체가 ‘잿더미 추격전’에서 2회 승리합니다"
  },
  Task_95214_Desc = {
    Text = "「계약 목표」의 광란 난이도를 클리어한다"
  },
  Task_95215_Desc = {
    Text = "통과「침묵의 세계」임의 난이도"
  },
  Task_95216_Desc = {
    Text = "통과「덮치는 세계의 빛」임의 난이도"
  },
  Task_95217_Desc = {
    Text = "재로 소멸된 추격·경계"
  },
  Task_95218_Desc = {
    Text = "통과「연옥의 노래」임의 난이도"
  },
  Task_95219_Desc = {
    Text = "「고대의 맹세」의 임의 난이도를 클리어한다"
  },
  Task_95220_Desc = {
    Text = "「고대의 맹세」의 광란 난이도를 클리어한다"
  },
  Task_95221_Desc = {
    Text = "통과「덮치는 세계의 빛」광란 난이도"
  },
  Task_95222_Desc = {
    Text = "통과「연옥의 노래」임의 난이도"
  },
  Task_95223_Desc = {
    Text = "'재와 추적·통과'의 모든 업적 완료"
  },
  Task_95224_Desc = {
    Text = "통과「연옥의 노래」광란 난이도"
  },
  Task_95225_Desc = {
    Text = "재로 소멸된 추격·클리어"
  },
  Task_95470_Desc = {
    Text = "N을 이기다"
  },
  Task_95470_Name = {Text = "목표"},
  Task_95520_Desc = {
    Text = "누적 16,000 원액 추출하기"
  },
  Task_95521_Desc = {
    Text = "누적 25,000 원액 추출하기"
  },
  Task_95522_Desc = {
    Text = "누적 13,000 원액 추출하기"
  },
  Task_95523_Desc = {
    Text = "누적 8,000 원액 추출하기"
  },
  Task_95524_Desc = {
    Text = "누적 2,000 원액 추출하기"
  },
  Task_95525_Desc = {
    Text = "누적 20,000 원액 추출하기"
  },
  Task_95526_Desc = {
    Text = "누적 4,000 원액 추출하기"
  },
  Task_95527_Desc = {
    Text = "누적 5,000 원액 추출하기"
  },
  Task_95532_Desc = {
    Text = "꽃동산의 옛날·광란"
  },
  Task_95533_Desc = {
    Text = "통과「재」광란 난이도"
  },
  Task_95534_Desc = {
    Text = "통과「미세한 왕국」광란 난이도"
  },
  Task_95535_Desc = {
    Text = "통과「첫 번째 장미」광란 난이도"
  },
  Task_95536_Desc = {
    Text = "통과「손잡기」광란 난이도"
  },
  Task_95537_Desc = {
    Text = "통과「피어나는 시편」광란 난이도"
  },
  Task_95543_Desc = {
    Text = "클리어 「첫 번째 장미」 아무 난이도"
  },
  Task_95544_Desc = {
    Text = "클리어 「손을 잡다」 아무 난이도"
  },
  Task_95545_Desc = {
    Text = "클리어 「번영하는 시편」 임의 난이도."
  },
  Task_95546_Desc = {
    Text = "클리어 「재」 아무 난이도"
  },
  Task_95547_Desc = {
    Text = "클리어 「작은 왕국」 임의의 난이도"
  },
  Task_95830_Desc = {
    Text = "영혼을 삼키는 연회·경계"
  },
  Task_95831_Desc = {
    Text = "「망령의 화염」의 광란 난이도를 클리어한다"
  },
  Task_95832_Desc = {
    Text = "통과「부패 조향」임의 난이도"
  },
  Task_95833_Desc = {
    Text = "통과「부패 조향」광란 난이도"
  },
  Task_95834_Desc = {
    Text = "통과「침몰한 관이 열리다」임의 난이도"
  },
  Task_95835_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「영혼을 삼키는 잔치」에서 2번 승리했습니다"
  },
  Task_95836_Desc = {
    Text = "둘레세인 획득 시 영혼의 부름 2를 얻습니다"
  },
  Task_95836_Name = {
    Text = "둘레세인 획득 시 영혼의 부름 2를 얻습니다"
  },
  Task_95836_UnlockCondDesc = {
    Text = "활동@깨어남체 두레세인의 영혼의 부름 기념품 2 활동"
  },
  Task_95837_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_95838_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_95839_Desc = {
    Text = "통과「침몰한 관이 열리다」임의 난이도"
  },
  Task_95840_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「영혼을 삼키는 잔치」에서 1번 승리했습니다"
  },
  Task_95841_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「영혼을 삼키는 잔치」에서 1번 승리했습니다"
  },
  Task_95842_Desc = {
    Text = "통과「골혈 박탈」광란 난이도"
  },
  Task_95843_Desc = {
    Text = "통과「성전환의 만찬」광란 난이도"
  },
  Task_95844_Desc = {
    Text = "「망령의 화염」의 임의 난이도를 클리어한다"
  },
  Task_95845_Desc = {
    Text = "「망령의 화염」의 임의 난이도를 클리어한다"
  },
  Task_95846_Desc = {
    Text = "두레사인의 동조율이 10레벨에 도달했습니다"
  },
  Task_95847_Desc = {
    Text = "영혼을 삼키는 연회·통과"
  },
  Task_95848_Desc = {
    Text = "'혼탁의 연회·통과'의 모든 임무 완료"
  },
  Task_95849_Desc = {
    Text = "통과「침몰한 관이 열리다」광란 난이도"
  },
  Task_95850_Desc = {
    Text = "둘레세인 획득 시 영혼의 부름 6을 얻습니다"
  },
  Task_95850_Name = {
    Text = "둘레세인 획득 시 영혼의 부름 6을 얻습니다"
  },
  Task_95850_UnlockCondDesc = {
    Text = "활동@깨어남체 두레세인의 영혼의 부름 기념품 2 활동"
  },
  Task_95853_Desc = {
    Text = "통과「골혈 박탈」임의 난이도"
  },
  Task_95854_Desc = {
    Text = "영혼을 삼키는 연회·광란"
  },
  Task_95855_Desc = {
    Text = "통과「성전환의 만찬」임의 난이도"
  },
  Task_95856_Desc = {
    Text = "심해 영역 깨어남체가 ‘영혼을 수확하는 잔치’에서 1회 승리합니다"
  },
  Task_95857_Desc = {
    Text = "통과「부패 조향」임의 난이도"
  },
  Task_95858_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「영혼을 삼키는 잔치」에서 1번 승리했습니다"
  },
  Task_95860_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「영혼을 삼키는 잔치」에서 2번 승리했습니다"
  },
  Task_95861_Desc = {
    Text = "통과「골혈 박탈」임의 난이도"
  },
  Task_95862_Desc = {
    Text = "심해 영역 깨어남체가 ‘영혼을 수확하는 잔치’에서 2회 승리합니다"
  },
  Task_95863_Desc = {
    Text = "통과「성전환의 만찬」임의 난이도"
  },
  Task_95864_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「영혼을 삼키는 잔치」에서 2번 승리했습니다"
  },
  Task_95865_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_95866_UnlockCondDesc = {
    Text = "먼저 이전 패키지를 수령해 주세요."
  },
  Task_96333_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_96333_Name = {Text = "10승"},
  Task_96334_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_96334_Name = {Text = "3승"},
  Task_96335_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_96335_Name = {Text = "6승"},
  Task_96336_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_96336_Name = {Text = "1승"},
  Task_96618_Desc = {
    Text = "상점에서 금권을 사용하여 3회 교환"
  },
  Task_96619_Desc = {
    Text = "파견 20회 완료"
  },
  Task_96620_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_96621_Desc = {
    Text = "「24」 혼돈 트라이얼 단계 1회 클리어"
  },
  Task_96622_Desc = {
    Text = "2주 동안 모든 주간 시련 임무 완료"
  },
  Task_96623_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_96624_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_96625_Desc = {
    Text = "파견 20회 완료"
  },
  Task_96626_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_96627_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_96628_Desc = {
    Text = "1800 린피테이프 소모"
  },
  Task_96629_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_96630_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_96631_Desc = {
    Text = "상점에서 금권을 사용하여 3회 교환"
  },
  Task_96632_Desc = {
    Text = "1800 린피테이프 소모"
  },
  Task_96633_Desc = {
    Text = "「24」 혼돈 트라이얼 단계 1회 클리어"
  },
  Task_96840_Desc = {
    Text = "이계 도첩·통과"
  },
  Task_96841_Desc = {
    Text = "지옥 변화를 임의의 난이도로 클리어"
  },
  Task_96842_Desc = {
    Text = "금소의 광란을 임의의 난이도로 클리어"
  },
  Task_96843_Desc = {
    Text = "선 인 연령을 임의의 난이도로 클리어"
  },
  Task_96844_Desc = {
    Text = "축제 정지상을 광란 난이도로 클리어"
  },
  Task_96845_Desc = {
    Text = "금소의 광란을 광란 난이도로 클리어"
  },
  Task_96846_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「이계 도화」에서 2회의 승리를 획득합니다"
  },
  Task_96847_Desc = {
    Text = "영감 침범을 임의의 난이도로 클리어"
  },
  Task_96848_Desc = {
    Text = "피의 확산을 광란 난이도로 클리어"
  },
  Task_96849_Desc = {
    Text = "피의 확산을 임의의 난이도로 클리어"
  },
  Task_96850_Desc = {
    Text = "금소의 광란을 임의의 난이도로 클리어"
  },
  Task_96851_Desc = {
    Text = "피의 확산을 임의의 난이도로 클리어"
  },
  Task_96852_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「이계 도화」에서 2회의 승리를 획득합니다"
  },
  Task_96853_Desc = {
    Text = "「이계 도감·클리어」 모든 업적 완수"
  },
  Task_96854_Desc = {
    Text = "선 인 연령을 임의의 난이도로 클리어"
  },
  Task_96855_Desc = {
    Text = "축제 정지상을 임의의 난이도로 클리어"
  },
  Task_96856_Desc = {
    Text = "이계의 그림 두루마리·경계"
  },
  Task_96857_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「이계 도화」에서 2회의 승리를 획득합니다"
  },
  Task_96858_Desc = {
    Text = "선 인 연령을 광란 난이도로 클리어"
  },
  Task_96859_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「이계 도화」에서 1회의 승리를 획득합니다"
  },
  Task_96860_Desc = {
    Text = "지옥 변화를 임의의 난이도로 클리어"
  },
  Task_96861_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여 「이계 도화」에서 1회의 승리를 획득합니다"
  },
  Task_96862_Desc = {
    Text = "의식 잠수 「기괴한 화폭」 완료"
  },
  Task_96863_Desc = {
    Text = "악몽 덩어리를 임의의 난이도로 클리어"
  },
  Task_96864_Desc = {
    Text = "심해 영역 깨어남체를 사용하여 「이계 도화」에서 1회의 승리를 획득합니다"
  },
  Task_96865_Desc = {
    Text = "영감 침범을 광란 난이도로 클리어"
  },
  Task_96866_Desc = {
    Text = "악몽 덩어리를 임의의 난이도로 클리어"
  },
  Task_96867_Desc = {
    Text = "이계 도첩·광란"
  },
  Task_96868_Desc = {
    Text = "축제 정지상을 임의의 난이도로 클리어"
  },
  Task_96869_Desc = {
    Text = "영감 침범을 임의의 난이도로 클리어"
  },
  Task_96870_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여 「이계 도화」에서 2회의 승리를 획득합니다"
  },
  Task_96871_Desc = {
    Text = "지옥 변화를 광란 난이도로 클리어"
  },
  Task_96872_Desc = {
    Text = "악몽 덩어리를 광란 난이도로 클리어"
  },
  Task_96873_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여 「이계 도화」에서 1회의 승리를 획득합니다"
  },
  Task_97192_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_97193_Desc = {
    Text = "파견 20회 완료"
  },
  Task_97194_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_97195_Desc = {
    Text = "도어세인 체험 스테이지 1회 클리어"
  },
  Task_97196_Desc = {
    Text = "2주 동안 매주 시험 완료"
  },
  Task_97197_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_97198_Desc = {
    Text = "1800 린피테이프 소모"
  },
  Task_97199_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_97200_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_97201_Desc = {
    Text = "1800 린피테이프 소모"
  },
  Task_97202_Desc = {
    Text = "3회의 매일 시험 완료"
  },
  Task_97203_Desc = {
    Text = "도어세인 체험 스테이지 1회 클리어"
  },
  Task_97243_Desc = {
    Text = "파견 20회 완료"
  },
  Task_97244_Desc = {
    Text = "2주 동안 매주 시험 완료"
  },
  Task_97245_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_97246_Desc = {
    Text = "3회의 매일 시험 완료"
  },
  Task_97309_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 총 6회"
  },
  Task_97309_Desc2 = {
    Text = "조사 사건「만족」중 공명 6회"
  },
  Task_97309_Name2 = {
    Text = "폭식의 메아리Ⅲ"
  },
  Task_97310_Desc = {
    Text = "조사 사건 「@1@2」에서 공명 9번"
  },
  Task_97310_Desc2 = {
    Text = "조사 사건「연회」에서 9번 공명합니다"
  },
  Task_97310_Name2 = {
    Text = "폭식의 메아리Ⅳ"
  },
  Task_97311_Desc = {
    Text = "조사 사건「@1@2」에서 2번 공명합니다"
  },
  Task_97311_Desc2 = {
    Text = "조사 사건「연회」에서 2번 공명합니다"
  },
  Task_97311_Name2 = {
    Text = "폭식의 메아리"
  },
  Task_97312_Desc = {
    Text = "조사 사건「@1@2」에서 4번 공명합니다"
  },
  Task_97312_Desc2 = {
    Text = "조사 사건「연회」에서 4번 공명합니다"
  },
  Task_97312_Name2 = {
    Text = "폭식의 메아리Ⅱ"
  },
  Task_97322_Desc = {
    Text = "완벽하게 꿈의 수호막을 유지하며「부패의 꼭두각시」를 처치합니다."
  },
  Task_97322_Name = {
    Text = "한 번의 약속, 한 번의 감시·숨겨진"
  },
  Task_97673_Desc = {
    Text = "'다섯 번째 날'의 광란 난이도를 클리어합니다"
  },
  Task_97674_Desc = {
    Text = "'첫 날'의 광란 난이도를 클리어합니다"
  },
  Task_97675_Desc = {
    Text = "'둘째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97676_Desc = {
    Text = "7일간의 창조·클리어"
  },
  Task_97677_Desc = {
    Text = "'일곱 번째 날'의 어느 난이도에서도 클리어합니다"
  },
  Task_97678_Desc = {
    Text = "혼돈 영역 깨어남체로 「7일간의 창조」에서 1회 승리"
  },
  Task_97679_Desc = {
    Text = "「7일간의 창조·클리어」의 모든 업적 완료"
  },
  Task_97680_Desc = {
    Text = "'둘째 날'의 광란 난이도를 클리어합니다"
  },
  Task_97681_Desc = {
    Text = "'일곱 번째 날'의 광란 난이도를 클리어합니다"
  },
  Task_97682_Desc = {
    Text = "'일곱 번째 날'의 어느 난이도에서도 클리어합니다"
  },
  Task_97683_Desc = {
    Text = "'여섯 번째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97684_Desc = {
    Text = "'첫 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97685_Desc = {
    Text = "'셋째 날'의 광란 난이도를 클리어합니다"
  },
  Task_97686_Desc = {
    Text = "초차원 영역 깨어남체로 「7일간의 창조」에서 1회 승리"
  },
  Task_97687_Desc = {
    Text = "혈육 영역 깨어남체로 「7일간의 창조」에서 1회 승리"
  },
  Task_97688_Desc = {
    Text = "'넷째 날'의 광란 난이도를 클리어합니다"
  },
  Task_97689_Desc = {
    Text = "'첫 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97690_Desc = {
    Text = "초차원 영역 깨어남체로 「7일간의 창조」에서 2회 승리"
  },
  Task_97691_Desc = {
    Text = "'넷째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97692_Desc = {
    Text = "심해 영역 깨어남체로 「7일간의 창조」에서 1회 승리"
  },
  Task_97693_Desc = {
    Text = "'셋째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97694_Desc = {
    Text = "혼돈 영역 깨어남체로 「7일간의 창조」에서 2회 승리"
  },
  Task_97695_Desc = {
    Text = "'여섯 번째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97696_Desc = {
    Text = "혈육 영역 깨어남체로 「7일간의 창조」에서 2회 승리"
  },
  Task_97697_Desc = {
    Text = "'여섯 번째 날'의 광란 난이도를 클리어합니다"
  },
  Task_97698_Desc = {
    Text = "7일간의 창조·광란"
  },
  Task_97699_Desc = {
    Text = "'넷째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97700_Desc = {
    Text = "7일간의 창조·영역"
  },
  Task_97701_Desc = {
    Text = "심해 영역 깨어남체로 「7일간의 창조」에서 2회 승리"
  },
  Task_97702_Desc = {
    Text = "'둘째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97703_Desc = {
    Text = "'셋째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97704_Desc = {
    Text = "'다섯 번째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97705_Desc = {
    Text = "'다섯 번째 날'의 어떤 난이도에서도 클리어합니다"
  },
  Task_97855_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여「일광 아래 신사」에서 1회의 승리를 얻습니다"
  },
  Task_97856_Desc = {
    Text = "누적 로그인 6일"
  },
  Task_97857_Desc = {
    Text = "누적 로그인 4일"
  },
  Task_97858_Desc = {
    Text = "통과「시적인 정원」광란 난이도"
  },
  Task_97859_Desc = {
    Text = "통과 이몽 시야「안녕, 영원한 고향」"
  },
  Task_97860_Desc = {
    Text = "누적 로그인 3일"
  },
  Task_97861_Desc = {
    Text = "「햇살 아래 새로운 일·통과」 모든 업적을 완료하다"
  },
  Task_97862_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여「일광 아래 신사」에서 2회의 승리를 얻습니다"
  },
  Task_97863_Desc = {
    Text = "심해 영역 깨어남체를 사용하여「일광 아래 신사」에서 1회의 승리를 얻습니다"
  },
  Task_97864_Desc = {
    Text = "'예전의 장소'를 광란 난이도로 클리어"
  },
  Task_97865_Desc = {
    Text = "햇빛 아래서 새로운 일·클리어"
  },
  Task_97866_Desc = {
    Text = "햇빛 아래서 새로운 일·영역"
  },
  Task_97867_Desc = {
    Text = "'완벽 동화'를 광란 난이도로 클리어"
  },
  Task_97868_Desc = {
    Text = "통과「시적인 정원」임의 난이도"
  },
  Task_97869_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여「일광 아래 신사」에서 1회의 승리를 얻습니다"
  },
  Task_97870_Desc = {
    Text = "'기계의 꿈'을 임의 난이도로 클리어"
  },
  Task_97871_Desc = {
    Text = "통과「검은 태양에 맞서기」광란 난이도"
  },
  Task_97872_Desc = {
    Text = "'검은 해를 직면'을 임의 난이도로 클리어"
  },
  Task_97873_Desc = {
    Text = "'완벽 동화'를 임의 난이도로 클리어"
  },
  Task_97874_Desc = {
    Text = "혈육 영역 깨어남체를 사용하여「일광 아래 신사」에서 2회의 승리를 얻습니다"
  },
  Task_97875_Desc = {
    Text = "누적 로그인 5일"
  },
  Task_97876_Desc = {
    Text = "'예전의 장소'를 임의 난이도로 클리어"
  },
  Task_97877_Desc = {
    Text = "누적 로그인 7일"
  },
  Task_97878_Desc = {
    Text = "'기계의 꿈'을 광란 난이도로 클리어"
  },
  Task_97879_Desc = {
    Text = "'검은 해를 직면'을 임의 난이도로 클리어"
  },
  Task_97880_Desc = {
    Text = "누적 로그인 2일"
  },
  Task_97881_Desc = {
    Text = "'완벽 동화'를 임의 난이도로 클리어"
  },
  Task_97882_Desc = {
    Text = "'기계의 꿈'을 임의 난이도로 클리어"
  },
  Task_97883_Desc = {
    Text = "혼돈 영역 깨어남체를 사용하여「일광 아래 신사」에서 1회의 승리를 얻습니다"
  },
  Task_97884_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_97885_Desc = {
    Text = "햇빛 아래서 새로운 일·광란"
  },
  Task_97886_Desc = {
    Text = "7일 로그인"
  },
  Task_97887_Desc = {
    Text = "초차원 영역 깨어남체를 사용하여「일광 아래 신사」에서 2회의 승리를 얻습니다"
  },
  Task_97888_Desc = {
    Text = "'예전의 장소'를 임의 난이도로 클리어"
  },
  Task_97889_Desc = {
    Text = "심해 영역 깨어남체를 사용하여「일광 아래 신사」에서 2회의 승리를 얻습니다"
  },
  Task_97890_Desc = {
    Text = "통과「시적인 정원」임의 난이도"
  },
  Task_97952_Desc = {
    Text = "통과 이몽 시야「안녕, 영원한 고향」"
  },
  Task_97953_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_97954_Desc = {
    Text = "통과 이몽 시야「안녕, 영원한 고향」"
  },
  Task_97955_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_97956_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_97957_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_97958_Desc = {
    Text = "하루 시험 4회를 완료하다"
  },
  Task_97959_Desc = {
    Text = "파견 20회 완료"
  },
  Task_97960_Desc = {
    Text = "린피테이프 1500점 소모"
  },
  Task_97961_Desc = {
    Text = "누적 소모 100000 장미 금권"
  },
  Task_97962_Desc = {
    Text = "파견 20회 완료"
  },
  Task_97963_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_97964_Desc = {
    Text = "융합 재해 훈련치가 100에 도달하였습니다"
  },
  Task_97965_Desc = {
    Text = "누적 소모 100000 장미 금권"
  },
  Task_97966_Desc = {
    Text = "통과 초월적 존재 1회"
  },
  Task_97967_Desc = {
    Text = "누적 로그인 1일"
  },
  Task_98151_Desc = {
    Text = "심연의 태동·시간 제한 전용"
  },
  Task_98347_Desc = {
    Text = "이번 시즌 누적 10승 달성"
  },
  Task_98347_Name = {Text = "10승"},
  Task_98348_Desc = {
    Text = "이번 시즌 누적 3승 달성"
  },
  Task_98348_Name = {Text = "3승"},
  Task_98349_Desc = {
    Text = "이번 시즌 누적 6승 달성"
  },
  Task_98349_Name = {Text = "6승"},
  Task_98350_Desc = {
    Text = "이번 시즌 누적 1승 달성"
  },
  Task_98350_Name = {Text = "1승"},
  Task_98505_Desc = {
    Text = "의식 잠수 「불사의 극주」 완료"
  },
  Task_98505_Name = {
    Text = "즐거움이 깨지는 날"
  },
  Task_98700_Desc = {
    Text = "누적 로그인 15일"
  },
  Task_98701_Desc = {
    Text = "2주 동안 모든 주간 시련 임무 완료"
  }
})
return Text_Task
