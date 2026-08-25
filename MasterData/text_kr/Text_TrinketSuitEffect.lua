__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "4월의 찬가"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "크리티컬 피해 +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 턴 시작 시, 적의 총 HP가 75%를 초과할 경우, 장착자의 임시 크리티컬 확률 및 크리티컬 피해가 35% 상승합니다."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "환형의 시편 (미완성)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "짝수 턴이 시작된 후, 무작위로 손패에 있는 카드 1장의 산출력 소비가 1 감소합니다."
  },
  TrinketSuitEffect_18337_Name = {
    Text = "바다에서 돌아오는 길"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "영역 숙련 +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 전투 시작 시, 장착자의 공격력 12%에 해당하는 힘을 획득합니다. 현재 영역이 심해인 경우, 효과가 \"매 턴 시작 시 (50+0.25*팀 영역 숙련)% 확률로 촉수 집결 1중첩을 획득하며, 100%를 초과할 시 여러 중첩을 획득할 수 있고, 보스 전투에서는 확률이 2배로 증가합니다.\"로 변경됩니다."
  },
  TrinketSuitEffect_18338_Name = {
    Text = "저주받은 토끼"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "영역 숙련 +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "장착자의 방어막 및 HP 회복량이 12% 상승합니다."
  },
  TrinketSuitEffect_18339_Name = {
    Text = "이율배반"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "은열쇠 충전 +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 장착자의 광기 최대치가 20 증가합니다. 장착자 명령 카드의 크리티컬 확률, 크리티컬 피해, 방어막 값, HP 회복량이 20% 상승합니다."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "유기 형태"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "검은 인장 드롭율 +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>. 스테이지 시작 시, 죽음 저항을 최대 100% 차감합니다. 1%의 죽음 저항이 차감될 때마다 장착자가 생성하는 광기가 0.15% 증가합니다."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "진홍빛 심동"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "크리티컬 피해 +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "은열쇠 발동 후, 장착자의 크리티컬 확률이 30% 상승합니다."
  },
  TrinketSuitEffect_18342_Name = {
    Text = "표준 비밀 계약 SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "장착자의 피해, 치유, 방어막 값이 15% 상승합니다."
  },
  TrinketSuitEffect_18343_Name = {
    Text = "표준 비밀 계약 R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "장착자의 피해, 치유, 방어막 값이 15% 상승합니다."
  },
  TrinketSuitEffect_18344_Name = {
    Text = "기계장치의 신"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "영역 숙련 +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "각 전투의 첫 번째 턴에 산출력 1을 획득합니다. 보스 전투에서는 추가로 4턴마다 산출력 1을 획득합니다."
  },
  TrinketSuitEffect_18345_Name = {
    Text = "광합성 제례"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "피해 강화 +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 장착자의 명령 카드가 초차원 공간에 진입하면, 배아 융합을 +25~50 증가시키며, 현재 HP가 낮을수록 더 많은 배아 융합을 획득합니다."
  },
  TrinketSuitEffect_18346_Name = {Text = "재진화"},
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "광기 충전 레벨 +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 스테이지 시작 시, 장착자는 35 광기를 획득합니다. 장착자가 광기 폭발을 사용한 후, 해당 전투에서 매 턴 종료 시 2 광기를 획득하며, 최대 3번까지 중첩됩니다."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "생명력 착취"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "은열쇠 충전 +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 턴 종료 시 장착자의 은열쇠 충전 200%에 해당하는 은열쇠 에너지를 획득합니다. 현재 영역이 '혈육'인 경우, 효과가 은열쇠 충전 5마다 배아 융합을 +1 증가시키는 것으로 변경됩니다."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "약재의 꿈"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "피해 증폭 +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>. 전투 종료 시 획득하는 검은 인장이 -8 감소합니다. 전투 시작 시 장착자의 타격과 방어를 제외한 명령 카드의 원본 복사본을 드로우 덱에 추가하며, 각 종류당 최대 1장입니다."
  },
  TrinketSuitEffect_18349_Name = {
    Text = "달콤한 점액동물"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "죽음 저항 +25.2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 1턴 내에 '섬멸'을 발동하고 촉수 자세를 전환한 경우, 장착자의 해당 턴 방어막, HP 회복, 최종 피해가 +25% 상승합니다. 3턴 쿨타임."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "극장의 고양이(미완성)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "장착자가 HP 75% 이상인 적에게 가하는 피해는 반드시 크리티컬이 됩니다."
  },
  TrinketSuitEffect_18351_Name = {
    Text = "36호실타래의 고리"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "광기 충전 레벨 +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>. 최대 은열쇠 에너지 및 열쇠령 은열쇠 에너지 소모량이 +200 증가합니다. 장착자 광기 폭발의 크리티컬 확률, 크리티컬 피해, 방어막 값, HP 회복량이 30% 상승합니다."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "뒤틀린 쌍둥이·백"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "짝수 턴이 시작된 후, <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>가 부여된 장착자의 「방어」를 손패에 추가합니다."
  },
  TrinketSuitEffect_18353_Name = {
    Text = "핏빛의 포옹"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "크리티컬 확률 +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "장착자가 피해를 가할 경우, 은열쇠 에너지를 35 획득합니다. 크리티컬 피해일 경우 획득량이 70으로 증가합니다. 최대 3회까지 발동 가능."
  },
  TrinketSuitEffect_18354_Name = {
    Text = "표준 비밀 계약 SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "장착자의 피해, 치유, 방어막 값이 15% 상승합니다."
  },
  TrinketSuitEffect_18355_Name = {
    Text = "무구의 계시록"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "은열쇠 충전 +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 열쇠령 발동 후, 장착자의 체력 12%에 해당하는 HP를 회복하며, 잃은 HP 비율에 따라 효과가 증가하여 최대 장착자의 체력 24%에 해당하는 HP를 회복합니다."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "황야의 늑대"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "피해 증폭 +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "장착자의 기본 피해가 20％ 상승하고, <IntoxicationIconKeywords:중독> 부여량과 얻는 <RetaliateIconKeywords:반격> 수치가 10％ 상승합니다."
  },
  TrinketSuitEffect_18357_Name = {
    Text = "먼 곳의 잔치"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "검은 인장 드롭율 +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "스테이지 시작 시, 검은 인장 10개를 획득합니다. 장착자의 「방어」가 생성하는 방어막 값이 60% 증가합니다."
  },
  TrinketSuitEffect_18358_Name = {
    Text = "뒤틀린 쌍둥이·흑"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "크리티컬 확률 +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "홀수 턴이 시작된 후, <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>가 부여된 장착자의 「타격」을 손패에 추가합니다."
  },
  TrinketSuitEffect_18359_Name = {
    Text = "소녀의 번데기"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "크리티컬 확률 +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 팀 유일>: 장착자가 매 턴 처음 배아를 소모한 후, 보유한 촉수 1개당 8% 임시 크리티컬 피해를 획득하며, 최대 80%입니다."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "묘지의 속삭임"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "죽음 저항 +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "스테이지 시작 시 <DeathResistanceIconKeywords:죽음 저항>이 25% 증가합니다. 죽음 저항이 발동된 후, 장착자는 50 광기를 획득합니다."
  },
  TrinketSuitEffect_99234_Name = {Text = "부패질"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "임시 텍스트"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "임시 텍스트"
  },
  TrinketSuitEffect_99235_Name = {Text = "비상"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "임시 텍스트"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "임시 텍스트"
  },
  TrinketSuitEffect_99236_Name = {Text = "스틱스"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "임시 텍스트"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "임시 텍스트"
  }
})
return Text_TrinketSuitEffect
