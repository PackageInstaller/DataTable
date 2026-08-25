__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "금기 학식 등급은 비밀 수호자 등급과 동일하며, 아래 3가지 연구 깊이의 효과를 결정합니다. 편대 깨어남체의 평균 등급이 비밀 수호자 등급 이상일 경우, 금기 학식 등급은 편대 깨어남체 평균 등급과 비밀 수호자 등급의 평균값을 취합니다.\n생체 연구 깊이: <Blue:{s1}>\n·깨어남체의 체질 속성 100포인트당 파티 생명력으로 전환되는 효과 강도를 결정합니다.\n물상 연구 깊이: <Blue:{s2}>\n·유물, 각인, 열령이 발생시키는 힘, 촉완 피해, 보호막, 생명력 회복, 힘 감소 계열 효과 강도를 결정합니다.\n영식 연구 깊이: <Blue:{s3}>\n·유물, 각인, 열령이 발생시키는 잠금 중독, 잠금 반격, 잠금 피해, 잠금 출혈 계열 효과 강도를 결정합니다.\n"
  },
  ActorAttrType_121209_Text = {
    Text = "금기 학식 등급"
  },
  ActorAttrType_18103_Text = {Text = "방어막"},
  ActorAttrType_18104_Text = {
    Text = "타격 피해 보정"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "크리티컬 피해 +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "크리티컬 피해"
  },
  ActorAttrType_18106_Text = {
    Text = "방어막 보정"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "공격 +{s1}"
  },
  ActorAttrType_18107_Text = {Text = "공격"},
  ActorAttrType_18108_Text = {Text = "체력"},
  ActorAttrType_18109_Text = {
    Text = "카드 피해 보정"
  },
  ActorAttrType_18110_Text = {
    Text = "손상 비율 보정"
  },
  ActorAttrType_18111_Text = {
    Text = "받는 방어막 보정"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "방어 +{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "방어 상승"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "깨어남체의 광기 회복 효율입니다."
  },
  ActorAttrType_18113_Text = {
    Text = "초기 광기"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "체력이 높을수록 깨어남체의 최대 HP가 상승합니다.\n수호자 조사 등급이 높을수록 체력이 깨어남체의 최대 HP에 미치는 영향이 더욱 강해집니다."
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "체력 +{s1}"
  },
  ActorAttrType_18114_Text = {Text = "체력"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "깨어남체 본원 강림 후 돌려받는 광기 수치"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "광기 소비 감소 +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "광기 소비 감소"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "체력이 높을수록 깨어남체의 최대 HP가 상승합니다.\n수호자 조사 등급이 높을수록 체력이 깨어남체의 최대 HP에 미치는 영향이 더욱 강해집니다."
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "체력 +{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "체력 상승"
  },
  ActorAttrType_18117_Text = {
    Text = "촉수 피해"
  },
  ActorAttrType_18118_Text = {
    Text = "초차원 공간 슬롯 개수"
  },
  ActorAttrType_18119_Text = {
    Text = "받는 피해 보정"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "깨어남체의 최대 축적 광기, 광기 폭발 발동 시 소모하는 광기는 모두 광기 최대치와 같습니다."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "광기 최대치 +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "광기 최대치"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "스킬2 레벨"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "스킬2 레벨 +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "스킬2 레벨"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "방어 레벨"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "방어 레벨 +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "방어 레벨"
  },
  ActorAttrType_18123_Text = {
    Text = "피해 횟수 보정"
  },
  ActorAttrType_18124_Text = {
    Text = "방어막 잠금값 보정"
  },
  ActorAttrType_18125_Text = {
    Text = "받는 방어막 잠금값 보정"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "팀의 영역 숙련은 팀 내 깨어남체 영역 숙련의 합과 같습니다. 영역 숙련은 팀의 영역 특성 효과를 강화합니다. 현재 팀이 「순수 심해/순수 혈육/순수 초차원」일 경우, 영역 숙련 효과가 2배로 증가합니다.\n· <Blue:혼돈> 영역은 영역 숙련 1마다, 은열쇠 발동 후 모든 깨어남체가 <Blue:0.05> 광기를 추가로 획득합니다.\n· <Blue:심해> 영역은 영역 숙련 1마다, 광기 폭발 후 <Blue:0.25%> 확률로 임시 촉수를 1개 생성하며 (확률이 100%를 초과할 경우 여러 개를 생성할 수 있음), 「정해」 태세로 전환 시 최대 HP의 <Blue:0.01%>만큼의 방어막을 생성하고, 「노도」 태세에서 공격으로 발동된 촉수 공격이 촉수 피해를 <Blue:0.02%>만큼 증가시킵니다.\n· <Blue:혈육> 영역은 영역 숙련 1마다, 매 턴 처음 포식 효과를 발동할 때 최대 HP의 <Blue:0.01%>만큼 방어막을 생성하고, <Blue:0.005%>만큼의 임시 힘을 추가로 획득합니다 (잃은 HP에 따라 최대 100%까지 증가). \n· <Blue:초차원> 영역은 영역 숙련 1마다, 턴 시작시 <Blue:0.125%> 확률로 「영감」 카드 1장을 추가로 획득합니다 (확률이 100%를 초과하면 여러 장을 획득할 수 있음)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "영역 숙련 +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "영역 숙련"
  },
  ActorAttrType_18127_Text = {Text = "HP"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "공격 +{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "공격 상승"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "기본 피해가 높을 수록 깨어남체가 가하는 피해량이 높아집니다."
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "기본 피해"
  },
  ActorAttrType_18129_Text = {
    Text = "기본 피해"
  },
  ActorAttrType_18130_Text = {Text = "레벨"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "턴 종료 시, 깨어남체가 자동으로 회복하는 광기 수치입니다. (과제 모드에서는 깨어남체가 행동할 때마다 얻는 광기 수치)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "광기 자동 회복 +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "광기 자동 회복"
  },
  ActorAttrType_18132_Text = {
    Text = "계령 등급"
  },
  ActorAttrType_18133_Text = {
    Text = "받는 광기 생성량 보정"
  },
  ActorAttrType_18134_Text = {
    Text = "배아 융합 최대치"
  },
  ActorAttrType_18135_Text = {
    Text = "현재 광기"
  },
  ActorAttrType_18136_Text = {
    Text = "받는 피해 잠금값 보정"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "깨어남체가 부여하는 방어막 및 회복 효과의 수치를 상승시킵니다."
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "방어막/치유 증폭 +{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "방어막/치유 증폭"
  },
  ActorAttrType_18138_Text = {
    Text = "치유 보정"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "커맨드 카드를 사용하거나 영지 깨어남 시, 행동력 1 소모마다 {s1} 포인트의 은열쇠 에너지를 획득합니다. 해당 속성이 증가할수록 추가로 상승하는 은열쇠 에너지는 점차 감소합니다."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "은열쇠 충전 +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "은열쇠 충전"
  },
  ActorAttrType_18140_Text = {
    Text = "죽음 저항 횟수"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "타격 레벨"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "타격 레벨 +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "타격 레벨"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "모든 깨어남체의 「기본 피해」, 「잠금값 중독」 및 「잠금값 반격」 스택, 그리고 심해 영역의 「초기 촉수 피해」를 증가시킵니다."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "피해 증폭 +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "피해 증폭"
  },
  ActorAttrType_18143_Text = {
    Text = "광기 폭발 피해 보정"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "깨어남체에게 공격받았을 때, 크리티컬에 저항할 확률입니다."
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "크리티컬 저항 +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "크리티컬 저항"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "본원 강림 레벨"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "본원 강림 레벨 +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "본원 강림 레벨"
  },
  ActorAttrType_18146_Text = {
    Text = "받는 치유 잠금값 보정"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "행운의 각인 확률 +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "행운의 각인 확률"
  },
  ActorAttrType_18148_Text = {
    Text = "치유 잠금값 보정"
  },
  ActorAttrType_18149_Text = {
    Text = "체력 상승"
  },
  ActorAttrType_18150_Text = {
    Text = "허약 비율 보정"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "파티의 죽음 저항은 파티 내 깨어남체들의 죽음 저항의 합.\n\n전투 중 치명적인 피해를 받았을 때, 일정 확률로 HP 1을 남기고 생존한다. 발동 후 다음 턴에 추가로 행동력 2를 획득하고 카드를 2장 뽑는다. 현재 및 이후 획득하는 죽음 저항은 절반으로 감소하며, 조사가 끝날 때까지 지속된다."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "죽음 저항 +{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "죽음 저항"
  },
  ActorAttrType_18152_Text = {
    Text = "광기 생성량 보정"
  },
  ActorAttrType_18154_Text = {
    Text = "최대 촉수 수량"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "전투 승리 시 적이 드롭하는 검은 인장 수량을 증가시킵니다."
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "검은 인장 드롭율 +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "검은 인장 드롭율"
  },
  ActorAttrType_18156_Text = {
    Text = "받는 광기 생성량 잠금값 보정"
  },
  ActorAttrType_18157_Text = {
    Text = "의도 숨김"
  },
  ActorAttrType_18158_Text = {
    Text = "피해 잠금값 보정"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "크리티컬 확률 +{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "크리티컬 확률"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "스킬1 레벨"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "스킬1 레벨 +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "스킬1 레벨"
  },
  ActorAttrType_18161_Text = {Text = "레벨"},
  ActorAttrType_18162_Text = {
    Text = "피해 보정"
  },
  ActorAttrType_18163_Text = {
    Text = "촉수 수량"
  },
  ActorAttrType_18164_Text = {
    Text = "받는 치유 보정"
  },
  ActorAttrType_18165_Text = {
    Text = "최대 행동력"
  },
  ActorAttrType_18166_Text = {
    Text = "취약 비율 보정"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "방어 +{s1}"
  },
  ActorAttrType_18167_Text = {Text = "방어"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "영지 깨어남 레벨"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "영지 깨어남 레벨 +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "영지 깨어남 레벨"
  },
  ActorAttrType_21322_Text = {
    Text = "은열쇠 충전"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "광기 폭발을 사용한 후 광기를 {s1} 얻습니다. 속성값이 높아질 수록 얻는 광기 수치가 점차 감소합니다."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "광기 충전 레벨 +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "광기 충전 레벨"
  },
  ActorAttrType_22214_Text = {
    Text = "광기 충전"
  }
})
return Text_ActorAttrType
