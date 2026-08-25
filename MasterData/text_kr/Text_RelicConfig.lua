__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "전투 시작 후, 「<MindWall:정신의 벽>」 1스택을 획득하고, 3턴 후에 그걸 「<BarrierCrash:장벽 붕괴>」로 변환시킨다."
  },
  RelicConfig_100300_Desc = {
    Text = "전투 시작 후, 「<MindWall:정신의 벽>」 1스택을 획득하고, 3턴 후에 그걸 「<BarrierCrash:장벽 붕괴>」로 변환시킨다."
  },
  RelicConfig_100300_Name = {
    Text = "심리 분석"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "당신의 마음을 정확히 살펴보고, 잘못된 선택을 하지 마세요."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "<DevouredIconKeywords:포식>효과를 발동한 후, 다른 깨어남체가 [Arg1] pt의 광기를 얻습니다. 그리고 이 효과는 매 턴마다 한 번만 적용됩니다."
  },
  RelicConfig_100399_Desc = {
    Text = "<DevouredIconKeywords:포식>효과를 발동한 후, 다른 깨어남체가 [Arg1] pt의 광기를 얻습니다. 그리고 이 효과는 매 턴마다 한 번만 적용됩니다."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:창구의 황금 꿈나라+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "변화의 날이 바로 당신의 죽음의 날입니다."
  },
  RelicConfig_100400_BattleDesc = {
    Text = "턴 종료 시 [Heal:Arg1] HP을 회복합니다."
  },
  RelicConfig_100400_Desc = {
    Text = "턴 종료 시 [Heal:Arg1] HP을 회복합니다."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:창구의 은총의 피+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "그것은 달콤하고 부드러운 맛이 나며, 장미꽃 향기를 발산합니다."
  },
  RelicConfig_100401_BattleDesc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_100401_Desc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:창구의 녹슨 강철톱+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "해부의사는 평생 아름다운 여자를 볼 수 없고, 오직 뼈 더미와 질병으로 인해 염증이 생긴 신경, 근육 및 조직만 볼 수 있다."
  },
  RelicConfig_100402_BattleDesc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<VulnerabilityIconKeywords:손상>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100402_Desc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<VulnerabilityIconKeywords:손상>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:창구의 봄의 제전>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "밤의 웃음소리 속에서 카누의 실타래루엣이 호수 위를 자유롭게 미끄러졌다."
  },
  RelicConfig_100404_BattleDesc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_100404_Desc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:창구의 무거운 자물쇠>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "두꺼우면서도 견고한 자물쇠는, 만약 키가 없다면 아마도 열기 어려울 것입니다. \n물론, 이것은 어떤 도둑에게는 별로 중요하지 않다."
  },
  RelicConfig_100405_BattleDesc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<WeaknessIconKeywords:허약>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100405_Desc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<WeaknessIconKeywords:허약>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:창구의 악동>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "순수한 악에서 태어났지만, 그것의 의도는 아니었다."
  },
  RelicConfig_100406_BattleDesc = {
    Text = "<DevouredIconKeywords:포식>효과를 발동한 후, 다른 깨어남체가 [Arg1] pt의 광기를 얻습니다. 그리고 이 효과는 매 턴마다 한 번만 적용됩니다."
  },
  RelicConfig_100406_Desc = {
    Text = "<DevouredIconKeywords:포식>효과를 발동한 후, 다른 깨어남체가 [Arg1] pt의 광기를 얻습니다. 그리고 이 효과는 매 턴마다 한 번만 적용됩니다."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:창구의 황금 꿈나라>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "변화의 날이 바로 당신의 죽음의 날입니다."
  },
  RelicConfig_100407_BattleDesc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_100407_Desc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:창구의 줄마노>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "일반적인 마노의 무늬일 거예요. 아마도."
  },
  RelicConfig_100408_BattleDesc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_100408_Desc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:창구의 무거운 자물쇠+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "두꺼우면서도 견고한 자물쇠는, 만약 키가 없다면 아마도 열기 어려울 것입니다. \n물론, 이것은 어떤 도둑에게는 별로 중요하지 않다."
  },
  RelicConfig_100409_BattleDesc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<WeaknessIconKeywords:허약>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100409_Desc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<WeaknessIconKeywords:허약>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:창구의 악동+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "순수한 악에서 태어났지만, 그것의 의도는 아니었다."
  },
  RelicConfig_100410_BattleDesc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_100410_Desc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:창구의 줄마노+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "일반적인 마노의 무늬일 거예요. 아마도."
  },
  RelicConfig_100411_BattleDesc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<VulnerabilityIconKeywords:손상>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100411_Desc = {
    Text = "수집 시 모든 적에게 [Arg1] 층의<VulnerabilityIconKeywords:손상>을 부여. 모든 깨어남체가 가하는 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:창구의 봄의 제전+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "밤의 웃음소리 속에서 카누의 실타래루엣이 호수 위를 자유롭게 미끄러졌다."
  },
  RelicConfig_100412_BattleDesc = {
    Text = "턴 종료 시 [Heal:Arg1] HP을 회복합니다."
  },
  RelicConfig_100412_Desc = {
    Text = "턴 종료 시 [Heal:Arg1] HP을 회복합니다."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:창구의 은총의 피>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "그것은 달콤하고 부드러운 맛이 나며, 장미꽃 향기를 발산합니다."
  },
  RelicConfig_100413_BattleDesc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_100413_Desc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:창구의 녹슨 강철톱>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "해부의사는 평생 아름다운 여자를 볼 수 없고, 오직 뼈 더미와 질병으로 인해 염증이 생긴 신경, 근육 및 조직만 볼 수 있다."
  },
  RelicConfig_100539_BattleDesc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_100539_Desc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:창구의 핏빛 조약돌>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "일、이、삼、사、오."
  },
  RelicConfig_100540_BattleDesc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_100540_Desc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:창구의 핏빛 조약돌+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "일、이、삼、사、오."
  },
  RelicConfig_116382_BattleDesc = {
    Text = "녹슨 열쇠 꾸러미.\n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_116382_Desc = {
    Text = "녹슨 열쇠 꾸러미.\n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_116382_Name = {
    Text = "녹슨 열쇠"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "녹슨 열쇠 꾸러미.\n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_116383_Desc = {
    Text = "녹슨 열쇠 꾸러미.\n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_116383_Name = {
    Text = "녹슨 열쇠"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "녹슨 열쇠 꾸러미.\n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_116384_Desc = {
    Text = "녹슨 열쇠 꾸러미.\n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_116384_Name = {
    Text = "녹슨 열쇠"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "손패 상한 +1.\n턴 시작 시, 모든 의식을 완료하지 않았다면 최대 HP의 10%에 해당하는 <SacrificeKeyWord:헌신의 제사>를 얻습니다. 1장의 「<DerivativeCardKeywords_119:신에게 바침>」을 손에 넣고, 최대 1장을 가질 수 있습니다."
  },
  RelicConfig_119371_Desc = {
    Text = "손패 상한 +1.\n턴 시작 시, 모든 의식을 완료하지 않았다면 최대 HP의 10%에 해당하는 <SacrificeKeyWord:헌신의 제사>를 얻습니다. 1장의 「<DerivativeCardKeywords_119:신에게 바침>」을 손에 넣고, 최대 1장을 가질 수 있습니다."
  },
  RelicConfig_119371_Name = {
    Text = "황동 향로"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "「리모리아 공예로 이 향로를 제작했습니다. 매일 밤 편안한 잠을 기원합니다. 미리암 드림。」"
  },
  RelicConfig_120372_BattleDesc = {
    Text = "손패 상한이 [Arg1] 증가한다. 턴 시작 시, 「<PVPDerivativeCardKeywords_11:불평등한 교환>」 [Arg2]장을 손패 안에 넣는다."
  },
  RelicConfig_120372_Desc = {
    Text = "손패 상한이 [Arg1] 증가한다. 턴 시작 시, 「<PVPDerivativeCardKeywords_11:불평등한 교환>」 [Arg2]장을 손패 안에 넣는다."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:만화경>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "드로우하기 전 「<PVPWeaponKeywords:명륜>」 [Arg1]장의 행동력 소모가 -5/-3/-1/+1로 변화하고, 카드 1장을 드로우한다."
  },
  RelicConfig_120373_Desc = {
    Text = "드로우하기 전 「<PVPWeaponKeywords:명륜>」 [Arg1]장의 행동력 소모가 -5/-3/-1/+1로 변화하고, 카드 1장을 드로우한다."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:미사그 배지>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "피해 면역"
  },
  RelicConfig_121214_Desc = {
    Text = "피해 면역"
  },
  RelicConfig_121214_Name = {
    Text = "무적 테스트 유물"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "최종 피해량이 250% 증가하며, 1회 피해를 입힐 때마다 50% 감소하고, 주는 방어막이 10% 증가합니다. 최대 5회 발동 가능하며, 매 턴 시작 후 초기화됩니다."
  },
  RelicConfig_121689_Desc = {
    Text = "최종 피해량이 250% 증가하며, 1회 피해를 입힐 때마다 50% 감소하고, 주는 방어막이 10% 증가합니다. 최대 5회 발동 가능하며, 매 턴 시작 후 초기화됩니다."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:“백은의 귀환 · 탄생”>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "전투 시작 시, 카드를 3장 선택하여「<RippleKeywords:여파>: 카드를 1장 뽑고, 임시 <PowerIconKeywords:힘>을 [Arg3]pt 획득합니다.」를 부여합니다. 턴 시작 시 <RippleKeywords:여파> 효과가 있는 카드 2장을 뽑고, 모든 <RippleKeywords:여파> 효과를 1번 발동시킵니다. <RippleKeywords:여파>가 10번 발동한 후, <DerivativeCardKeywords_1:그림자의 메아리> 1장을 손패에 추가합니다."
  },
  RelicConfig_121690_Desc = {
    Text = "전투 시작 시, 카드를 3장 선택하여「<RippleKeywords:여파>: 카드를 1장 뽑고, 임시 <PowerIconKeywords:힘>을 [Arg3]pt 획득합니다.」를 부여합니다. 턴 시작 시 <RippleKeywords:여파> 효과가 있는 카드 2장을 뽑고, 모든 <RippleKeywords:여파> 효과를 1번 발동시킵니다. <RippleKeywords:여파>가 10번 발동한 후, <DerivativeCardKeywords_1:그림자의 메아리> 1장을 손패에 추가합니다."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:“백은의 귀환 · 광기”>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "모든 깨어남체의 광기 폭발 최종 피해가 100% 증가하며, 각 깨어남체가 광기 폭발을 해제한 후 500% 기본 광기의 은열쇠 에너지를 획득합니다. 모든 깨어남체의 기본 광기가 20점 감소하며, 최대 5회까지 감소합니다."
  },
  RelicConfig_121691_Desc = {
    Text = "모든 깨어남체의 광기 폭발 최종 피해가 100% 증가하며, 각 깨어남체가 광기 폭발을 해제한 후 500% 기본 광기의 은열쇠 에너지를 획득합니다. 모든 깨어남체의 기본 광기가 20점 감소하며, 최대 5회까지 감소합니다."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:“백은의 귀환 · 공포”>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "모든 깨어남체가 초래하는 <RetaliateIconKeywords:반격>, <IntoxicationIconKeywords:중독>, 방어막과 HP력 회복이 50% 증가합니다. 턴이 종료될 때 현재 방어막의 500%에 해당하는 일시적인 <RetaliateIconKeywords:반격>을 획득합니다."
  },
  RelicConfig_121692_Desc = {
    Text = "모든 깨어남체가 초래하는 <RetaliateIconKeywords:반격>, <IntoxicationIconKeywords:중독>, 방어막과 HP력 회복이 50% 증가합니다. 턴이 종료될 때 현재 방어막의 500%에 해당하는 일시적인 <RetaliateIconKeywords:반격>을 획득합니다."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:“백은의 귀환 · 사악한 신앙”>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "손패 상한 +5. 턴 시작 시 2장의 카드를 뽑고, 2점의 행동력을 획득합니다. 덱을 초기화할 때마다 [Arg3]점 <PowerIconKeywords:힘>과 [Arg4]점의 임시 <AlertIconKeywords:경계>를 획득하며, 광기가 가장 높은 깨어남체의 각 비파생 명령 카드 1장을 생성하여 드로우 덱에 넣고, 그 카드의 행동력 소모를 1점 낮춥니다."
  },
  RelicConfig_121693_Desc = {
    Text = "손패 상한 +5. 턴 시작 시 2장의 카드를 뽑고, 2점의 행동력을 획득합니다. 덱을 초기화할 때마다 [Arg3]점 <PowerIconKeywords:힘>과 [Arg4]점의 임시 <AlertIconKeywords:경계>를 획득하며, 광기가 가장 높은 깨어남체의 각 비파생 명령 카드 1장을 생성하여 드로우 덱에 넣고, 그 카드의 행동력 소모를 1점 낮춥니다."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:“백은의 귀환 · 뼈속까지 차게”>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "모든 깨어남체는 매 턴 첫 번째 “명령 카드”로 25 pt의 광기를 획득하고, <DerivativeCardKeywords_4:“영감”> 1장을 손에 추가합니다. “광기 폭발”을 4번 사용한 후, 모든 깨어남체의 <Seal:봉인> 상태를 해제하고, 모든 깨어남체가 50 pt의 광기를 획득합니다."
  },
  RelicConfig_121694_Desc = {
    Text = "모든 깨어남체는 매 턴 첫 번째 “명령 카드”로 25 pt의 광기를 획득하고, <DerivativeCardKeywords_4:“영감”> 1장을 손에 추가합니다. “광기 폭발”을 4번 사용한 후, 모든 깨어남체의 <Seal:봉인> 상태를 해제하고, 모든 깨어남체가 50 pt의 광기를 획득합니다."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:“백은의 귀환 · 기이함”>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "전투 시작 시, [Arg4] 점의 <PowerIconKeywords:힘>을 획득하고, 은열쇠 에너지 저장 한도가 100% 증가합니다. 매 pt 행동력 소모 시 획득하는 은열쇠 에너지가 100% 증가하며, 은열쇠 깨어남 또는 키령 해제 후, 현재 <PowerIconKeywords:힘>의 20%에 해당하는 임시 <PowerIconKeywords:힘>을 획득하고 모든 깨어남체가 20 pt의 광기를 얻습니다."
  },
  RelicConfig_121695_Desc = {
    Text = "전투 시작 시, [Arg4] 점의 <PowerIconKeywords:힘>을 획득하고, 은열쇠 에너지 저장 한도가 100% 증가합니다. 매 pt 행동력 소모 시 획득하는 은열쇠 에너지가 100% 증가하며, 은열쇠 깨어남 또는 키령 해제 후, 현재 <PowerIconKeywords:힘>의 20%에 해당하는 임시 <PowerIconKeywords:힘>을 획득하고 모든 깨어남체가 20 pt의 광기를 얻습니다."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:“백은의 귀환· 슬픔”>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "전투 시작 후, 「<PVPDerivativeCardKeywords_25:실타래비아의 홍차>」 [Arg1]장을 손패 안에 넣는다."
  },
  RelicConfig_122625_Desc = {
    Text = "전투 시작 후, 「<PVPDerivativeCardKeywords_25:실타래비아의 홍차>」 [Arg1]장을 손패 안에 넣는다."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:시런 홍차>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "매 라운드 드로우 덱에 「<PVPDerivativeCardKeywords_14:현실타래 모방>」 [Arg1]장을 손패 안에 넣고, 깨어남체 중 랜덤으로 소속시킨다."
  },
  RelicConfig_122626_Desc = {
    Text = "매 라운드 드로우 덱에 「<PVPDerivativeCardKeywords_14:현실타래 모방>」 [Arg1]장을 손패 안에 넣고, 깨어남체 중 랜덤으로 소속시킨다."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:마법 장갑>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "매 턴 최초로 사용한 「스킬」의 피해, 치유 및 방어막이 [Arg1]% 증가한다."
  },
  RelicConfig_122627_Desc = {
    Text = "매 턴 최초로 사용한 「스킬」의 피해, 치유 및 방어막이 [Arg1]% 증가한다."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:루비 브로치>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "턴 종료 후, 광기를 추가로 <Energy:[Arg1]> 획득한다."
  },
  RelicConfig_122628_Desc = {
    Text = "턴 종료 후, 광기를 추가로 <Energy:[Arg1]> 획득한다."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:야몽의 표상>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "덱 안에는 두 배의 깨어남체 카드가 존재한다. 카드 사용 후, 손패 수가 해당 턴에 처음으로 [Arg1] 이하일 경우 카드 [Arg2]장을 드로우한다."
  },
  RelicConfig_122629_Desc = {
    Text = "덱 안에는 두 배의 깨어남체 카드가 존재한다. 카드 사용 후, 손패 수가 해당 턴에 처음으로 [Arg1] 이하일 경우 카드 [Arg2]장을 드로우한다."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:행복한 레코드>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "손패 상한이 [Arg1] 증가한다. 매 라운드 드로우 덱에 「<PVPDerivativeCardKeywords_13:불멸의 장례식>」 [Arg2]장을 손패 안에 넣는다."
  },
  RelicConfig_122630_Desc = {
    Text = "손패 상한이 [Arg1] 증가한다. 매 라운드 드로우 덱에 「<PVPDerivativeCardKeywords_13:불멸의 장례식>」 [Arg2]장을 손패 안에 넣는다."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:유실타래된 제사용 칼>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "턴 시작 시 [Arg1]장 행동력 소모 -1인 “타격”을 뽑습니다. 광기 폭발을 발동한 후 [Arg2]장의 <DepleteIconKeywords:소모>, <PrepareKeypvewords:준비1> 및 <RetainIconKeywords:보존>이 있는 대응하는 깨어남체의 “타격”을 생성합니다.\n 1턴 내에 [Arg3]장의 “타격”을 사용할 때마다 [Arg4] pt의 임시<PowerIconKeywords:힘>을 획득합니다; [Arg5]장의 “타격”을 사용한 후 [Arg6]장을 뽑고 [Arg7] pt의 행동력을 얻습니다; [Arg8]장의 “타격”을 사용한 후 모든 깨어남체가 [Arg9] pt의 광기를 얻습니다."
  },
  RelicConfig_122768_Desc = {
    Text = "턴 시작 시 [Arg1]장 행동력 소모 -1인 “타격”을 뽑습니다. 광기 폭발을 발동한 후 [Arg2]장의 <DepleteIconKeywords:소모>, <PrepareKeypvewords:준비1> 및 <RetainIconKeywords:보존>이 있는 대응하는 깨어남체의 “타격”을 생성합니다.\n 1턴 내에 [Arg3]장의 “타격”을 사용할 때마다 [Arg4] pt의 임시<PowerIconKeywords:힘>을 획득합니다; [Arg5]장의 “타격”을 사용한 후 [Arg6]장을 뽑고 [Arg7] pt의 행동력을 얻습니다; [Arg8]장의 “타격”을 사용한 후 모든 깨어남체가 [Arg9] pt의 광기를 얻습니다."
  },
  RelicConfig_122768_Name = {
    Text = "그 세계의 메아리"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "이세계의 안개 속에 섞인 여운, 왜곡과 광기, 그리고 의심할 수 없는 현실타래로 통하는."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "턴 시작 시 무셰트가 광기 [Arg1]pt를 획득하고, 행동력 소모가 0인 임시 「타격」 카드를 1장 생성한다. 매번 「극적인 만남」 발동 시마다 「샤이닝☆토네이도」가 해당 전투에서 입히는 기본 피해와 타격 피해 증가 효과가 [Arg2]% 증가한다."
  },
  RelicConfig_123724_Desc = {
    Text = "턴 시작 시 무셰트가 광기 [Arg1]pt를 획득하고, 행동력 소모가 0인 임시 「타격」 카드를 1장 생성한다. 매번 「극적인 만남」 발동 시마다 「샤이닝☆토네이도」가 해당 전투에서 입히는 기본 피해와 타격 피해 증가 효과가 [Arg2]% 증가한다."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:차원 영상 · 무셰트>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "모든 깨어남체가 매 턴 첫 번째로 명령 카드를 사용할 때 [Arg1] pt의 광기를 획득합니다. 1턴 내에 4장의 서로 다른 깨어남체에 속하는 명령 카드를 사용한 후, 모든 적에게 우리 편 최대 HP의 [Arg2]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여합니다."
  },
  RelicConfig_125488_Desc = {
    Text = "모든 깨어남체가 매 턴 첫 번째로 명령 카드를 사용할 때 [Arg1] pt의 광기를 획득합니다. 1턴 내에 4장의 서로 다른 깨어남체에 속하는 명령 카드를 사용한 후, 모든 적에게 우리 편 최대 HP의 [Arg2]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여합니다."
  },
  RelicConfig_125488_Name = {
    Text = "아줌마의 기세"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "턴 시작 시 서는 [Arg1] 광기를 획득하고 모든 적에게 1층 <WitherKeywords:취해 있다>를 부여합니다. 매 턴 서의 첫 번째 명령 카드를 사용할 때마다 반드시 “공명” 효과가 발동됩니다."
  },
  RelicConfig_125489_Desc = {
    Text = "턴 시작 시 서는 [Arg1] 광기를 획득하고 모든 적에게 1층 <WitherKeywords:취해 있다>를 부여합니다. 매 턴 서의 첫 번째 명령 카드를 사용할 때마다 반드시 “공명” 효과가 발동됩니다."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:차원 영상 · 서>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "손패 상한 +3. 매 턴 사용한 첫 3장의 비파생 명령 카드를 기록하며, 3턴 후 턴 시작 시 그 카드의 행동력 소모를 -1로 줄이고 <DepleteIconKeywords:소모>의 복사본을 손패에 추가합니다."
  },
  RelicConfig_126673_Desc = {
    Text = "손패 상한 +3. 매 턴 사용한 첫 3장의 비파생 명령 카드를 기록하며, 3턴 후 턴 시작 시 그 카드의 행동력 소모를 -1로 줄이고 <DepleteIconKeywords:소모>의 복사본을 손패에 추가합니다."
  },
  RelicConfig_126673_Name = {
    Text = "운명의 물레"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "운명은 흘러가며, 영원히 멈추지 않는다."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:골드 조화>:“행동력 조화”로 인한 행동력 증가 효과의 최대치는 1pt며, 1% 피해 증폭당 영지 연구 심도 효과가 1% 증가합니다.\n<OrangeQuality:차원 선물>:탐험 시작 시, 랜덤으로 1개의 차원 이미지 유물을 얻고, 최대 손패 매수가 2 증가합니다.\n<OrangeQuality:축복받은 의식>:첫 번째, 두 번째 단계의 리더 보상이 랜덤 축복받은 유물 3개 중 1개로 변경됩니다.\n<RedQuality:장거리 피로>:전투 중 모든 HP 답변 효과가 50% 감소하며, “바랜 유골” 선택 시 “안장”으로 변경되어 최대 HP의 25%를 회복합니다.\n<RedQuality:기절 증상>:전투 시작 시, 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다.\n<RedQuality:영원한 밤의 복도>:탐험 시작 시, 모든 깨어남체의 기본 광기와 은열쇠 에너지 상한선이 50% 증가합니다."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:골드 조화>:“행동력 조화”로 인한 행동력 증가 효과의 최대치는 pt며, 1% 피해 증폭당 영지 연구 심도 효과가 1% 증가합니다.\n<OrangeQuality:차원 선물>:탐험 시작 시, 랜덤으로 1개의 차원 이미지 유물을 얻고, 최대 손패 매수가 2 증가합니다.\n<OrangeQuality:축복받은 의식>:첫 번째, 두 번째 단계의 리더 보상이 랜덤 축복받은 유물 3개 중 1개로 변경됩니다.\n<RedQuality:장거리 피로>:전투 중 모든 HP 답변 효과가 50% 감소하며, “바랜 유골” 선택 시 “안장”으로 변경되어 최대 HP의 25%를 회복합니다.\n<RedQuality:기절 증상>:전투 시작 시, 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다.\n<RedQuality:영원한 밤의 복도>:탐험 시작 시, 모든 깨어남체의 기본 광기와 은열쇠 에너지 상한선이 50% 증가합니다."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:작은“N”의 혼란 카메라>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "큰일 났다! 카메라가 완전히 고장 났어! 어? 어떻게 아직 작동하지? 잠깐! 이 제한이 도대체 뭐야?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:골드 조화>:“행동력 조화”로 인한 행동력 증가 효과의 최대치는 1점이며, 1% 피해 증폭당 영지 연구 심도 효과가 1% 증가합니다.\n<RedQuality:장거리 피로>: 전투 중 모든 HP 회복 효과가 50% 감소하며, “바랜 유골”에서 “안장”을 선택할 경우 최대 HP의 25%를 회복합니다."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:골드 조화>:“행동력 조화”로 인한 행동력 증가 효과의 최대치는 1점이며, 1% 피해 증폭당 영지 연구 심도 효과가 1% 증가합니다.\n<RedQuality:장거리 피로>: 전투 중 모든 HP 회복 효과가 50% 감소하며, “바랜 유골”에서 “안장”을 선택할 경우 최대 HP의 25%를 회복합니다."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:작은「N」의 완벽한 카메라>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "더 쳐다보지 말아요, 이건 카메라라고요! 새로 나온 신제품으로, 남녀노소 정직하게 판매합니다."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:골드 조화>:“행동력 조화”로 인한 행동력 증가 효과는 최대 1pt이며, 1% 피해 증폭당 영지 연구 심도 효과가 1% 증가합니다.\n<OrangeQuality:차원 선물>:탐험 시작 시, 랜덤으로 1개의 차원 이미지 유물을 획득하고, 최대 손패 매수가 1 증가합니다.\n<RedQuality:장거리 피로>:전투 중 모든 HP 회복 효과가 50% 감소하며, “바랜 유골” 선택 시 “안장”으로 변경되어 최대 HP의 25%를 회복합니다.\n<RedQuality:기절 증상>:전투 시작 시, 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:골드 조화>:“행동력 조화”로 인한 행동력 증가 효과는 최대 1pt이며, 1% 피해 증폭당 영지 연구 심도 효과가 1% 증가합니다.\n<OrangeQuality:차원 선물>:탐험 시작 시, 랜덤으로 1개의 차원 이미지 유물을 획득하고, 최대 손패 매수가 1 증가합니다.\n<RedQuality:장거리 피로>:전투 중 모든 HP 회복 효과가 50% 감소하며, “바랜 유골” 선택 시 “안장”으로 변경되어 최대 HP의 25%를 회복합니다.\n<RedQuality:기절 증상>:전투 시작 시, 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:작은「N」의 낡은 카메라>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "젠장! 카메라가 망가졌잖아! 내가 한번 고쳐볼게…… 켜졌다! 근데 왠지 모르게 이상한 느낌이 든다 말이지……"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "턴 시작 시마다 모스가 [Arg1] 광기를 획득합니다. 매 턴 처음 사용하는 「차지!」 또는 「장전!」 의 효과가 2회 발동됩니다."
  },
  RelicConfig_131079_Desc = {
    Text = "턴 시작 시마다 모스가 [Arg1] 광기를 획득합니다. 매 턴 처음 사용하는 「차지!」 또는 「장전!」 의 효과가 2회 발동됩니다."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:차원 영상 · 모스>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "앞의 3턴 시작 시 매 턴마다 1회 “해달의 난처함”이 발동합니다. 5턴 시작 시 모든 “해달의 난처함”의 부정 효과를 제거하고 “<DerivativeCardKeywords_135:이세 충격!”>을 획득합니다."
  },
  RelicConfig_131080_Desc = {
    Text = "앞의 3턴 시작 시 매 턴마다 1회 “해달의 난처함”이 발동합니다. 5턴 시작 시 모든 “해달의 난처함”의 부정 효과를 제거하고 “<DerivativeCardKeywords_135:이세 충격!”>을 획득합니다."
  },
  RelicConfig_131080_Name = {
    Text = "알탄이 2세"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "모스크 여사가 단호하게 말했다. 이게 유물이다.\n“나쁜 놈, 물어!”"
  },
  RelicConfig_131178_BattleDesc = {
    Text = "전투 시작 시 「<DerivativeCardKeywords_134:금단의 진실타래>」 1장을 덱에 셔플하여 넣습니다. 매 턴 카드 드로우 수 +[Arg1]. 지령 카드를 사용한 후 각각 패, 드로우 더미, 버린 카드 더미에서 <ErosionColorInkKeywords:인지 착란>이 부여되지 않은 랜덤 지령 카드 [Arg2]장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  RelicConfig_131178_Desc = {
    Text = "전투 시작 시 「<DerivativeCardKeywords_134:금단의 진실타래>」 1장을 덱에 셔플하여 넣습니다. 매 턴 카드 드로우 수 +[Arg1]. 지령 카드를 사용한 후 각각 패, 드로우 더미, 버린 카드 더미에서 <ErosionColorInkKeywords:인지 착란>이 부여되지 않은 랜덤 지령 카드 [Arg2]장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  RelicConfig_131178_Name = {
    Text = "아오가이 일지"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "기록된 내용에는 일흔 개의 메이슨 소수가 포함되어 있습니다."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "피해 면역"
  },
  RelicConfig_132540_Name = {
    Text = "집합 테스트 유물"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "크리티컬 확률이 15% 증가합니다. 턴 시작 시 HP가 25%([Arg1]) 미만일 경우, 해당 턴 동안 크리티컬 확률이 추가로 30% 증가합니다."
  },
  RelicConfig_13740_Desc = {
    Text = "크리티컬 확률이 15% 증가합니다. 턴 시작 시 HP가 25% 미만일 경우, 해당 턴 동안 크리티컬 확률이 추가로 30% 증가합니다."
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:신비한 성상의>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "우주의 신비."
  },
  RelicConfig_13741_BattleDesc = {
    Text = "크리티컬 피해가 15% 증가합니다. 방어막을 보유한 적에게 입히는 피해가 반드시 크리티컬로 적중합니다."
  },
  RelicConfig_13741_Desc = {
    Text = "크리티컬 피해가 15% 증가합니다. 방어막을 보유한 적에게 입히는 피해가 반드시 크리티컬로 적중합니다."
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:미학의 원리>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "랍상사: 의사의 조력자, 장의업자의 고객, 무덤벌레의 공양자."
  },
  RelicConfig_13742_BattleDesc = {
    Text = "크리티컬 피해가 50% 증가합니다. 매 3번째 공격이 반드시 크리티컬로 적중합니다."
  },
  RelicConfig_13742_Desc = {
    Text = "크리티컬 피해가 50% 증가합니다. 매 3번째 공격이 반드시 크리티컬로 적중합니다."
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:시계추「명상」>"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "턴 시작 시, 광기를 가장 적게 보유한 깨어남체가 15 광기를 획득합니다. 직전에 사용한 카드보다 행동력 소비가 적은 카드를 연속으로 2번 사용할 때마다, 광기를 가장 적게 보유한 깨어남체가 15 광기를 획득합니다."
  },
  RelicConfig_13743_Desc = {
    Text = "턴 시작 시, 광기를 가장 적게 보유한 깨어남체가 15 광기를 획득합니다. 직전에 사용한 카드보다 행동력 소비가 적은 카드를 연속으로 2번 사용할 때마다, 광기를 가장 적게 보유한 깨어남체가 15 광기를 획득합니다."
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:아르카나 유물>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "운명의 종언."
  },
  RelicConfig_13744_BattleDesc = {
    Text = "턴 시작 시, 광기를 가장 적게 보유한 깨어남체가 15 광기를 획득합니다."
  },
  RelicConfig_13744_Desc = {
    Text = "턴 시작 시, 광기를 가장 적게 보유한 깨어남체가 15 광기를 획득합니다."
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:월계수잎 소매단추>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "은제로 제작된 계엽 문양이 새겨진 소매단추입니다. \n정교하게 만들어져 반짝이는 광채를 띠며, 과거에는 두 아이의 우정을 담고 있었습니다."
  },
  RelicConfig_13745_BattleDesc = {
    Text = "추천 영역 보너스가 50%로 증가합니다. 탐사 시작 시 행운의 각인 확률이 2배로 증가합니다."
  },
  RelicConfig_13745_Desc = {
    Text = "추천 영역 보너스가 50%로 증가합니다. 탐사 시작 시 행운의 각인 확률이 2배로 증가합니다."
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:시계추「숙면」>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "죽음을 1회 무효화하고, 발동 후 즉시 HP를 10% 회복합니다. 효과가 3번 발동된 후 해당 유물이 영구적으로 무효화됩니다."
  },
  RelicConfig_13747_Desc = {
    Text = "죽음을 1회 무효화하고, 발동 후 즉시 HP를 10% 회복합니다. 효과가 3번 발동된 후 해당 유물이 영구적으로 무효화됩니다."
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆비상식량☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "최후의 수단으로도 이것은 먹지 않는 게 좋다."
  },
  RelicConfig_13748_BattleDesc = {
    Text = "전투 시작 시, 실타래제 행동력 소비가 1인 카드의 피해가 [Arg1], 방어막 획득량이 [Arg2] 증가합니다."
  },
  RelicConfig_13748_Desc = {
    Text = "전투 시작 시, 실타래제 행동력 소비가 1인 카드의 피해가 [Arg1], 방어막 획득량이 [Arg2] 증가합니다."
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:순진한 마리>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "논리란 칵테일과 같아, 너무 많이 섭취하면 그 이점이 사라집니다."
  },
  RelicConfig_13749_BattleDesc = {
    Text = "매 4턴마다, 모든 적이 해당 턴 동안 받는 피해가 2배 증가하지만, 해당 턴 동안 광기 폭발 사용 시 모든 깨어남체를 1턴 동안 봉인합니다."
  },
  RelicConfig_13749_Desc = {
    Text = "매 4턴마다, 모든 적이 해당 턴 동안 받는 피해가 2배 증가하지만, 해당 턴 동안 광기 폭발 사용 시 모든 깨어남체를 1턴 동안 봉인합니다."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:여정의 유골>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "신성한 일부입니다. \n몸통과 분리되더라도 그 흔적은 이미 전 세계를 뒤덮었습니다."
  },
  RelicConfig_13750_BattleDesc = {
    Text = "턴 종료 시, 방어막이 없을 경우 피해를 1회 무효화하는 <ParcloseIconKeywords:장벽>을 획득합니다. 전투마다 1번만 발동합니다."
  },
  RelicConfig_13750_Desc = {
    Text = "턴 종료 시, 방어막이 없을 경우 피해를 1회 무효화하는 <ParcloseIconKeywords:장벽>을 획득합니다. 전투마다 1번만 발동합니다."
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆아픔아 멀리멀리 날아가라☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "효과는 그렇게 영구적이지 않습니다."
  },
  RelicConfig_13751_BattleDesc = {
    Text = "크리티컬 확률이 25% 증가하고, 매 턴 처음 입히는 피해량이 2배가 됩니다."
  },
  RelicConfig_13751_Desc = {
    Text = "크리티컬 확률이 25% 증가하고, 매 턴 처음 입히는 피해량이 2배가 됩니다."
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:시계추「심화」>"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "턴 시작 시 HP를 [Arg1] 회복합니다. 현재 HP가 50% 미만일 경우, 대신 [Arg2] 회복합니다."
  },
  RelicConfig_13752_Desc = {
    Text = "턴 시작 시 HP를 [Arg1] 회복합니다. 현재 HP가 50% 미만일 경우, 대신 [Arg2] 회복합니다."
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:은혜의 피>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "그것은 달콤하고 부드러운 맛이 나며, 장미꽃 향기를 발산합니다."
  },
  RelicConfig_13753_BattleDesc = {
    Text = "이 유물은 태스크에 효과가 없습니다."
  },
  RelicConfig_13753_Desc = {
    Text = "이 유물은 태스크에 효과가 없습니다."
  },
  RelicConfig_13753_Name = {
    Text = "미션 유물 테스트"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "보완이 필요한 유물"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "매 5번째 피해가 반드시 크리티컬로 적중합니다."
  },
  RelicConfig_13754_Desc = {
    Text = "매 5번째 피해가 반드시 크리티컬로 적중합니다."
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:시력 교정기>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "누군가가 그것을 통해 진실타래을 찾았습니다."
  },
  RelicConfig_13755_BattleDesc = {
    Text = "턴 시작 시, <DimensionalSpaceIconKeywords:초차원 공간>에 존재하는 카드 1장마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 초차원 턴일 경우, 임시 <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13755_Desc = {
    Text = "턴 시작 시, <DimensionalSpaceIconKeywords:초차원 공간>에 존재하는 카드 1장마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 초차원 턴일 경우, 임시 <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:삼각 프리즘>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "“빛은 일곱 가지 색으로 이루어져 있습니다.”"
  },
  RelicConfig_13756_BattleDesc = {
    Text = "해당 유물 획득 시, 다른 모든 유물을 잃고, 랜덤 황금 유물 2개를 획득합니다."
  },
  RelicConfig_13756_Desc = {
    Text = "해당 유물 획득 시, 다른 모든 유물을 잃고, 랜덤 황금 유물 2개를 획득합니다."
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆되돌아보다 감상☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "기묘한 시대에서 꽃이야말로 인간의 첫 번째 관상자였다. \n움직이지 마세요, 그들은 조용한 전시물을 더 선호합니다."
  },
  RelicConfig_13757_BattleDesc = {
    Text = "카드를 8번 사용할 때마다, 마지막으로 사용한 카드의 효과가 2번 적용됩니다."
  },
  RelicConfig_13757_Desc = {
    Text = "카드를 8번 사용할 때마다, 마지막으로 사용한 카드의 효과가 2번 적용됩니다."
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:별빛의 술>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "별들 사이를 거닐다."
  },
  RelicConfig_13758_BattleDesc = {
    Text = "해당 유물 획득 시 최대 HP가 [Arg1] 증가하고, 공격받을 때 획득하는 광기가 2 증가합니다."
  },
  RelicConfig_13758_Desc = {
    Text = "해당 유물 획득 시 최대 HP가 [Arg1] 증가하고, 공격받을 때 획득하는 광기가 2 증가합니다."
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:달콤한 잉크>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "누군가는 이것이 악마의 피라고 하지만, 헤이요, 먼저 시도해 보자!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "광기 폭발을 사용할 때, 모든 적에게 해당 적이 이번 턴 공격할 횟수만큼 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다."
  },
  RelicConfig_13759_Desc = {
    Text = "광기 폭발을 사용할 때, 모든 적에게 해당 적이 이번 턴 공격할 횟수만큼 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다."
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆라듐 턱뼈☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "어느 수집가의 사설 전시실타래에 전시된 유골.\n수집가는 그 아름다운 형광에 매료되어 낮과 밤을 보내며 감상하다가 결국 말라 죽었고, 최종적으로 그것의 동류가 되었다."
  },
  RelicConfig_13760_BattleDesc = {
    Text = "최대 행동력이 1 증가합니다. 직전에 사용한 카드보다 행동력 소비가 높은 카드를 연속으로 2번 사용할 때마다, 행동력을 1 획득합니다."
  },
  RelicConfig_13760_Desc = {
    Text = "최대 행동력이 1 증가합니다. 직전에 사용한 카드보다 행동력 소비가 높은 카드를 연속으로 2번 사용할 때마다, 행동력을 1 획득합니다."
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:아르카나 기록>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "운명의 흐름."
  },
  RelicConfig_13761_BattleDesc = {
    Text = "턴 시작 시, 이전 턴에 남은 손패 매수가 4장 이상이었을 경우, 행동력을 2 획득합니다."
  },
  RelicConfig_13761_Desc = {
    Text = "턴 시작 시, 이전 턴에 남은 손패 매수가 4장 이상이었을 경우, 행동력을 2 획득합니다."
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:미사그 배지>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "미사그 대학이 조사원에게 배포한 배지입니다. 이 배지는 착용자의 신분을 상징하는 것뿐만 아니라, 원격 통신이 가능한 도구이기도 합니다."
  },
  RelicConfig_13762_BattleDesc = {
    Text = "「방어」 사용 시, <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다."
  },
  RelicConfig_13762_Desc = {
    Text = "「방어」 사용 시, <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다."
  },
  RelicConfig_13762_Name = {
    Text = "기형 쐐기풀 조끼"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "오염된 액체를 구분할 수 없습니다."
  },
  RelicConfig_13763_BattleDesc = {
    Text = "전투 시작 시 [Arg1]의 방어막을 획득합니다. 턴 시작 시 방어막을 보유하고 있을 경우, 해당 턴 동안 방어막 획득량과 HP 회복량이 50% 증가합니다."
  },
  RelicConfig_13763_Desc = {
    Text = "전투 시작 시 [Arg1]의 방어막을 획득합니다. 턴 시작 시 방어막을 보유하고 있을 경우, 해당 턴 동안 방어막 획득량과 HP 회복량이 50% 증가합니다."
  },
  RelicConfig_13763_Name = {
    Text = "기형 정원의 수호자"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "해당 유물 획득 시, 영구적으로 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13764_Desc = {
    Text = "해당 유물 획득 시, 영구적으로 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:루비 브로치>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "어렴풋이 핏빛이 스며나온다."
  },
  RelicConfig_13766_BattleDesc = {
    Text = "해당 유물 획득 시, 카드를 1장 선택하여 2종류의 강화 효과를 부여합니다. (참고: 천면환상의 카드 조합과 유사합니다.)"
  },
  RelicConfig_13766_Desc = {
    Text = "해당 유물 획득 시, 카드를 1장 선택하여 2종류의 강화 효과를 부여합니다. (참고: 천면환상의 카드 조합과 유사합니다.)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆명가의 타자기☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "소문에 따르면, 진정으로 세대를 초월한 작품을 쓴 것은 사실타래 타자기라고 한다."
  },
  RelicConfig_13767_BattleDesc = {
    Text = "해당 유물 획득 시, 랜덤 고급 각인 3개 중 1개를 선택하여 지정된 카드에 부여합니다."
  },
  RelicConfig_13767_Desc = {
    Text = "해당 유물 획득 시, 랜덤 고급 각인 3개 중 1개를 선택하여 지정된 카드에 부여합니다."
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:라인드의 고문서>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "아래 질문을 들어보세요: 10명의 승려가 6개의 빵을 나누어 가집니다. 각각 몇 개씩 얻을까요?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "최대 행동력 2 증가. “타격” 또는 “방어”를 사용한 후, 해당 깨어남체가 5 광기를 획득합니다. 광기 폭발을 발동한 후, 해당 깨어남체에 부가적으로 소모 마음이 허한 사람 “타격” 1장을 획득하며, 은열쇠를 발동한 후, 랜덤으로 부가적으로 소모 마음이 허한 사람 “방어” 1장을 획득합니다."
  },
  RelicConfig_13768_Desc = {
    Text = "최대 행동력 2 증가. “타격”이나 “방어”를 사용한 후, 해당 깨어남체가 5 광기를 획득합니다. 광기 폭발을 발동한 후, 1장의 해당 깨어남체에 부가적으로 소모 공허의 “타격”을 획득하고, 은열쇠를 발동한 후, 랜덤으로 1장의 부가적으로 소모 공허의 “방어”를 획득합니다."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:시계추「날개」>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "턴 시작 시 <EmbryoFusionIconKeywords:배아 융합>이 30% 증가합니다. 모든 <DevouredIconKeywords:포식> 효과가 <UnlimitedDevouredIconKeywords:무한 포식>으로 변경됩니다."
  },
  RelicConfig_13769_Desc = {
    Text = "턴 시작 시 <EmbryoFusionIconKeywords:배아 융합>이 30% 증가합니다. 모든 <DevouredIconKeywords:포식> 효과가 <UnlimitedDevouredIconKeywords:무한 포식>으로 변경됩니다."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:꿈틀거리는 탯줄>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "목을 감싸는."
  },
  RelicConfig_13770_BattleDesc = {
    Text = "턴 시작 시 [Arg1]의 방어막을 획득합니다. 턴마다 해당 효과로 획득하는 방어막 양이 [Arg2] 증가합니다."
  },
  RelicConfig_13770_Desc = {
    Text = "턴 시작 시 [Arg1]의 방어막을 획득합니다. 턴마다 해당 효과로 획득하는 방어막 양이 [Arg2] 증가합니다."
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:수호의 손>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "기도의 손，견고한 주먹."
  },
  RelicConfig_13771_BattleDesc = {
    Text = "모든 깨어남체의 은열쇠 충전이 30 증가합니다. 은열쇠 발동 후, <DerivativeCardKeywords_4:「영감」> 3장을 드로우 덱에 추가합니다."
  },
  RelicConfig_13771_Desc = {
    Text = "모든 깨어남체의 은열쇠 충전이 30 증가합니다. 은열쇠 발동 후, <DerivativeCardKeywords_4:「영감」> 3장을 드로우 덱에 추가합니다."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:시계추「이슬잠」>"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "전투 종료 시, 추가로 검은 인장 75개와 증상 카드 1장을 획득합니다."
  },
  RelicConfig_13772_Desc = {
    Text = "전투 종료 시, 추가로 검은 인장 75개와 증상 카드 1장을 획득합니다."
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:에메랄드 탁본>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "이 인장은 천년 동안 변치 않고 남아 있습니다."
  },
  RelicConfig_13773_BattleDesc = {
    Text = "매번 능동적으로 피해를 입힐 때마다, 자신에게 [Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, 피해 대상에게 [Arg2] 층의<BleedingIconKeywords:출혈>을 부여합니다. 적을 1회 처치할 때마다, 자신에게 적용된 <BleedingIconKeywords:출혈> 상태를 해제합니다."
  },
  RelicConfig_13773_Desc = {
    Text = "매번 능동적으로 피해를 입힐 때마다, 자신에게 [Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, 피해 대상에게 [Arg2] 층의<BleedingIconKeywords:출혈>을 부여합니다. 적을 1회 처치할 때마다, 자신에게 적용된<BleedingIconKeywords:출혈> 상태를 해제합니다."
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:군체 의식>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "감싸기, 공생, 군집; 두려움, 미지, 통제."
  },
  RelicConfig_13774_BattleDesc = {
    Text = "실타래제 행동력 소비가 3인 카드를 사용할 때마다, 카드를 1장 뽑고 행동력을 2 획득합니다. 실타래제 행동력 소비가 4 이상인 카드를 사용할 때마다, 다른 손패의 행동력 소비가 1 감소합니다."
  },
  RelicConfig_13774_Desc = {
    Text = "실타래제 행동력 소비가 3인 카드를 사용할 때마다, 카드를 1장 뽑고 행동력을 2 획득합니다. 실타래제 행동력 소비가 4 이상인 카드를 사용할 때마다, 다른 손패의 행동력 소비가 1 감소합니다."
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:시계추「눈」>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "해당 유물 획득 시, 명령 카드 1장을 선택하여 「고유」, 「보존」 및 「사용 후 1장 드로우」 효과를 부여합니다."
  },
  RelicConfig_13775_Desc = {
    Text = "해당 유물 획득 시, 명령 카드 1장을 선택하여 「고유」, 「보존」 및 「사용 후 1장 드로우」 효과를 부여합니다."
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:서류철>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "쉿, 이것은 우리만의 비밀 거래다."
  },
  RelicConfig_13776_BattleDesc = {
    Text = "전투 시작 후, 촉수 1개를 생성합니다."
  },
  RelicConfig_13776_Desc = {
    Text = "전투 시작 후, 촉수 1개를 생성합니다."
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:노란 달팽이>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "이 작은 소황나사의 출신은 고귀하며, 완벽하고 흠잡을 데 없는 기원을 가지고 있습니다."
  },
  RelicConfig_13777_BattleDesc = {
    Text = "홀수 턴 종료 시, 행동력이 1 이상 남아 있을 경우 다음 턴에 추가로 카드를 2장 뽑습니다. 짝수 턴 종료 시, 손패의 카드가 1장 이상 남아 있을 경우 다음 턴에 추가로 행동력을 2 회복합니다."
  },
  RelicConfig_13777_Desc = {
    Text = "홀수 턴 종료 시, 행동력이 1 이상 남아 있을 경우 다음 턴에 추가로 카드를 2장 뽑습니다. 짝수 턴 종료 시, 손패의 카드가 1장 이상 남아 있을 경우 다음 턴에 추가로 행동력을 2 회복합니다."
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:해와 달의 암호>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "추측해 보세요, 검은색이나 하얀색일까요?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "최대 촉수 수량이 1 증가합니다. HP가 50% 미만일 때, <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가합니다."
  },
  RelicConfig_13778_Desc = {
    Text = "최대 촉수 수량이 1 증가합니다. HP가 50% 미만일 때, <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가합니다."
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:바다의 노래>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "전해지는 바에 따르면, 조개류 등 섭취할 수 없는 동물들이 해양의 약 80%의 영양분을 흡수한다고 합니다."
  },
  RelicConfig_13779_BattleDesc = {
    Text = "턴 시작 시 카드를 1장 뽑고, 턴 종료 시 손패 1장을 선택하여 보존할 수 있습니다."
  },
  RelicConfig_13779_Desc = {
    Text = "턴 시작 시 카드를 1장 뽑고, 턴 종료 시 손패 1장을 선택하여 보존할 수 있습니다."
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:선지자의 소원 램프>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "당신의 소원에 답합니다."
  },
  RelicConfig_13780_BattleDesc = {
    Text = "매번 광기 폭발을 사용할 때, 1장의 <DerivativeCardKeywords_7:“독성 감염”>을 얻습니다. 손패에 3장의 <DerivativeCardKeywords_7:“독성 감염”>이 있을 경우, <DerivativeCardKeywords_8:“독성 발작”>을 발동하는 카드를 합성합니다."
  },
  RelicConfig_13780_Desc = {
    Text = "매번 광기 폭발을 사용할 때, 1장의 <DerivativeCardKeywords_7:“독성 감염”>을 얻습니다. 손패에 3장의 <DerivativeCardKeywords_7:“독성 감염”>이 있으면 <DerivativeCardKeywords_8:“독성 발작”>을 발동하는 중독을 합성합니다."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:이형의 목소리>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "그는 악마는 아니지만, 그는 인생 너머의 저어를 전달합니다."
  },
  RelicConfig_13781_BattleDesc = {
    Text = "검은 인장을 1개 소모할 때마다 모든 깨어남체가 1 광기를 획득합니다."
  },
  RelicConfig_13781_Desc = {
    Text = "검은 인장을 1개 소모할 때마다 모든 깨어남체가 1 광기를 획득합니다."
  },
  RelicConfig_13781_Name = {
    Text = "뒤집힌 꽃"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "테스트 창조물"
  },
  RelicConfig_13782_Desc = {
    Text = "테스트 창조물"
  },
  RelicConfig_13782_Name = {
    Text = "테스트 유물"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "매 턴 3번째로 카드를 사용한 후, <DerivativeCardKeywords_4:「영감」> 1장을 버린 카드 더미에 추가합니다. 매 턴 6번째로 카드를 사용한 후, <DerivativeCardKeywords_4:「영감」> 1장을 버린 카드 더미에서 손패로 가져옵니다."
  },
  RelicConfig_13783_Desc = {
    Text = "매 턴 3번째로 카드를 사용한 후, <DerivativeCardKeywords_4:「영감」> 1장을 버린 카드 더미에 추가합니다. 매 턴 6번째로 카드를 사용한 후, <DerivativeCardKeywords_4:「영감」> 1장을 버린 카드 더미에서 손패로 가져옵니다."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:문명의 빛>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "밤을 가르는 유성."
  },
  RelicConfig_13784_BattleDesc = {
    Text = "턴 시작 시, 적 하나당 행동력을 1 획득합니다. 적에게 능동 피해를 가하여 처치하였을 경우, 다른 적에게 초과한 피해량만큼의 <BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_13784_Desc = {
    Text = "턴 시작 시, 적 하나당 행동력을 1 획득합니다. 적에게 능동 피해를 가하여 처치하였을 경우, 다른 적에게 초과한 피해량만큼의 <BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:군중의 노래>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "귀를 괴롭히기 위해 태어났습니다."
  },
  RelicConfig_13785_BattleDesc = {
    Text = "턴 종료 시 <EmbryoFusionIconKeywords:배아 융합>이 15% 증가하고, 손패에 <DerivativeCardKeywords_2:「배아」>가 존재할 경우 HP를 [Arg1] 회복합니다."
  },
  RelicConfig_13785_Desc = {
    Text = "턴 종료 시 <EmbryoFusionIconKeywords:배아 융합>이 15% 증가하고, 손패에 <DerivativeCardKeywords_2:「배아」>가 존재할 경우 HP를 [Arg1] 회복합니다."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:역병 진단서>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "역병 —— 자연의 무의식적인 불안정한 상태의 우연한 표현."
  },
  RelicConfig_13786_BattleDesc = {
    Text = "광기 폭발 사용 후, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13786_Desc = {
    Text = "광기 폭발 사용 후, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:무거운 자물쇠>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "두꺼우면서도 견고한 자물쇠는, 만약 키가 없다면 아마도 열기 어려울 것입니다. \n물론, 이것은 어떤 도둑에게는 별로 중요하지 않다."
  },
  RelicConfig_13787_BattleDesc = {
    Text = "턴 시작 시 무작위 적 1명에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입힙니다. 이번 전투에서 「타격」을 7번 사용한 후 피해량이 [Arg2]로 변하고, 「타격」을 21번 사용한 후 즉시 모든 적에게 [Arg3] 포인트의 <FixedDamage:순수 피해>를 입힙니다."
  },
  RelicConfig_13787_Desc = {
    Text = "턴 시작 시 무작위 적 1명에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입힙니다. 이번 전투에서 「타격」을 7번 사용한 후 피해량이 [Arg2]로 변하고, 「타격」을 21번 사용한 후 즉시 모든 적에게 [Arg3] 포인트의 <FixedDamage:순수 피해>를 입힙니다."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:오래된 퍼즐>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "무거운 그림액자에 장착되었던 예술 작품은 전시된 날부터 일부가 결여되어 있었습니다."
  },
  RelicConfig_13788_BattleDesc = {
    Text = "최대 촉수 수량이 2개 감소합니다. 턴 종료 시 모든 촉수가 추가로 1회 공격합니다."
  },
  RelicConfig_13788_Desc = {
    Text = "최대 촉수 수량이 2개 감소합니다. 턴 종료 시 모든 촉수가 추가로 1회 공격합니다."
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:신성한 고통의 팔>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "고통을 즐기세요."
  },
  RelicConfig_13789_BattleDesc = {
    Text = "덱이 초기화될 때마다, <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13789_Desc = {
    Text = "덱이 초기화될 때마다, <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:울음 파이프>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "이는 과연 증오의 산물인지, 아니면 복수의 결과인지?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "지도에서 이동할 때마다 검은 인장을 10개 획득하지만, 스트레스가 10 증가합니다."
  },
  RelicConfig_13790_Desc = {
    Text = "지도에서 이동할 때마다 검은 인장을 10개 획득하지만, 스트레스가 10 증가합니다."
  },
  RelicConfig_13790_Name = {
    Text = "바닥 없는 주머니"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "해당 유물 획득 시, 명령 카드 1장을 선택하여 그 복사본을 덱에 추가합니다."
  },
  RelicConfig_13791_Desc = {
    Text = "해당 유물 획득 시, 명령 카드 1장을 선택하여 그 복사본을 덱에 추가합니다."
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:순간의 불꽃>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "떨리는 빛, 희미한 희망."
  },
  RelicConfig_13792_BattleDesc = {
    Text = "HP를 잃을 때마다 <EmbryoFusionIconKeywords:배아 융합>이 10% 증가합니다. 현재 HP가 50% 미만일 경우 2배로 증가합니다."
  },
  RelicConfig_13792_Desc = {
    Text = "HP를 잃을 때마다 <EmbryoFusionIconKeywords:배아 융합>이 10% 증가합니다. 현재 HP가 50% 미만일 경우 2배로 증가합니다."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:녹슨 톱>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "해부의사는 평생 아름다운 여자를 볼 수 없고, 오직 뼈 더미와 질병으로 인해 염증이 생긴 신경, 근육 및 조직만 볼 수 있다."
  },
  RelicConfig_13793_BattleDesc = {
    Text = "해당 유물 획득 시 파티의 검은 인장 드롭율이 원래 값의 150%으로 증가합니다. HP를 회복할 때마다 모든 깨어남체가 3 광기를 획득합니다. HP를 잃을 때마다 [Arg1]의 <PowerIconKeywords:힘>과 촉수 피해를 획득합니다. 각 효과를 합하여 턴마다 5번까지 발동합니다."
  },
  RelicConfig_13793_Desc = {
    Text = "해당 유물 획득 시 파티의 검은 인장 드롭율이 원래 값의 150%으로 증가합니다. HP를 회복할 때마다 모든 깨어남체가 3 광기를 획득합니다. HP를 잃을 때마다 [Arg1]의 <PowerIconKeywords:힘>과 촉수 피해를 획득합니다. 각 효과를 합하여 턴마다 5번까지 발동합니다."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:시계추「달」>"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "턴 종료 후, 모든 깨어남체가 5 광기를 획득합니다. 남은 행동력 1마다 추가로 3 광기를 획득합니다."
  },
  RelicConfig_13794_Desc = {
    Text = "턴 종료 후, 모든 깨어남체가 5 광기를 획득합니다. 남은 행동력 1마다 추가로 3 광기를 획득합니다."
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:프로토타입 배터리>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "휴대용 희망."
  },
  RelicConfig_13795_BattleDesc = {
    Text = "최대 행동력이 1 증가합니다."
  },
  RelicConfig_13795_Desc = {
    Text = "최대 행동력이 1 증가합니다."
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:활력 주사기>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "경련도 활성의 한 종류입니다."
  },
  RelicConfig_13796_BattleDesc = {
    Text = "전투 종료 시 HP가 50% 이하일 경우, 백은 유물로 업그레이드됩니다."
  },
  RelicConfig_13796_Desc = {
    Text = "전투 종료 시 HP가 50% 이하일 경우, 백은 유물로 업그레이드됩니다."
  },
  RelicConfig_13796_Name = {
    Text = "낡은 노트 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "하나의 낡은 일기장, 내지는 삽입 페이지로 가득 차 있으며, 대충 보아도 최소한 엘워스 지도, 실타래험 기록, 삼각형 융화자국이 가득한 서신을 포함하고 있다.\n노트의 앞부분 내용은 글씨가 가지런하고 정돈되어 있지만, 후속 내용은 점차 난잡해지고 있다."
  },
  RelicConfig_13797_BattleDesc = {
    Text = "「타격」을 3장 사용한 후, 황금 유물로 업그레이드됩니다."
  },
  RelicConfig_13797_Desc = {
    Text = "「타격」을 3장 사용한 후, 황금 유물로 업그레이드됩니다."
  },
  RelicConfig_13797_Name = {
    Text = "낡은 노트 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "낡은 일기장, 내지는 삽입 페이지로 가득 차 있으며, 대충 보면 적어도 엘워스 지도, 실타래험 기록, 삼각 융화자국으로 가득한 서신지가 포함되어 있다.\n노트의 앞부분 내용은 글씨가 깔끔하고 바르게 쓰여져 있지만, 이후에는 점점 난잡해지고 무질서해진다."
  },
  RelicConfig_13798_BattleDesc = {
    Text = "전투 시작 시, 덱에 있는 모든 증상 카드에 <NothingnessIconKeywords:공허>를 부여하고, 덱에 있는 증상 카드 1장마다 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13798_Desc = {
    Text = "전투 시작 시, 덱에 있는 모든 증상 카드에 <NothingnessIconKeywords:공허>를 부여하고, 덱에 있는 증상 카드 1장마다 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:하포드의 영약>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "성분이 불명확한 약물입니다. \n유명한 바이올리니스트 에릭이 이를 매우 좋아했다고 합니다."
  },
  RelicConfig_13799_BattleDesc = {
    Text = "전투 첫 턴에, <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다. 전투 2번째 턴에, <DerivativeCardKeywords_41:「은열쇠 공명」> 1장을 손패에 추가합니다. 전투 3번째 턴에, <DerivativeCardKeywords_39:「과거의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13799_Desc = {
    Text = "전투 첫 턴에, <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다. 전투 2번째 턴에, <DerivativeCardKeywords_41:「은열쇠 공명」> 1장을 손패에 추가합니다. 전투 3번째 턴에, <DerivativeCardKeywords_39:「과거의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:시계추「별무리」>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_6:「양산」> 1장을 손패에 추가합니다. 카드를 6장 사용할 때마다, 손패의 모든 <DerivativeCardKeywords_6:「양산」>의 <AlertIconKeywords:경계>를 [Arg2] 증가시킵니다."
  },
  RelicConfig_13800_Desc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_6:「양산」> 1장을 손패에 추가합니다. 카드를 6장 사용할 때마다, 손패의 모든 <DerivativeCardKeywords_6:「양산」>의 <AlertIconKeywords:경계>를 [Arg2] 증가시킵니다."
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:여행용 양산>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "빛 없는 땅에서 피어나다."
  },
  RelicConfig_13801_BattleDesc = {
    Text = "일반 전투에서 모든 적의 HP가 30% 증가하는 대신, 전투 승리 시 검은 인장 25개를 추가로 획득합니다."
  },
  RelicConfig_13801_Desc = {
    Text = "일반 전투에서 모든 적의 HP가 30% 증가하는 대신, 전투 승리 시 검은 인장 25개를 추가로 획득합니다."
  },
  RelicConfig_13801_Name = {
    Text = "찢어진 전투 깃발"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "해당 유물 획득 시 최대 HP가 [Arg1] 증가합니다. 만약 획득 시 HP가 25% 미만이었을 경우, 대신 [Arg2] 증가합니다."
  },
  RelicConfig_13802_Desc = {
    Text = "해당 유물 획득 시 최대 HP가 [Arg1] 증가합니다. 만약 획득 시 HP가 25% 미만이었을 경우, 대신 [Arg2] 증가합니다."
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:실타래론 홍차>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "건강한 식사, 우리가 시작합시다."
  },
  RelicConfig_13803_BattleDesc = {
    Text = "3턴마다 임시 촉수를 3개 생성합니다."
  },
  RelicConfig_13803_Desc = {
    Text = "3턴마다 임시 촉수를 3개 생성합니다."
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:잠수 헬멧>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "꿈은 별빛 바다야!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "턴 종료 시 [Arg1]의 방어막을 획득합니다. 방어막이 0 또는 3의 배수일 경우, <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13804_Desc = {
    Text = "턴 종료 시 [Arg1]의 방어막을 획득합니다. 방어막이 0 또는 3의 배수일 경우, <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:구조 신호>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "그는 구조를 기다리지 못했습니다."
  },
  RelicConfig_13806_BattleDesc = {
    Text = "증상 카드를 뽑을 때마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 보유한 저주받은 유물 1개마다 크리티컬 확률과 크리티컬 피해가 10% 증가합니다."
  },
  RelicConfig_13806_Desc = {
    Text = "증상 카드를 뽑을 때마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 보유한 저주받은 유물 1개마다 크리티컬 확률과 크리티컬 피해가 10% 증가합니다."
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:심연 통신>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "인적이 드문 교외, 외로운 전화부스에서 벨이 울린다. \n“다크……시……무한한……시시……어둠……”"
  },
  RelicConfig_13807_BattleDesc = {
    Text = "전투 시작 시 <EmbryoFusionIconKeywords:배아 융합>이 50% 증가합니다. 광기를 50 이상 보유한 깨어남체 1명마다 추가로 1회 발동합니다."
  },
  RelicConfig_13807_Desc = {
    Text = "전투 시작 시 <EmbryoFusionIconKeywords:배아 융합>이 50% 증가합니다. 광기를 50 이상 보유한 깨어남체 1명마다 추가로 1회 발동합니다."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:사랑스러운 아기>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "목수가 아내를 위해 생동감 넘치는 목각 인형을 만들었고, 그것은 그들의 아들을 대신해 그녀의 배 속에서 잠들어 있게 될 것이다."
  },
  RelicConfig_13808_BattleDesc = {
    Text = "광기 폭발 사용 후, 대응하는 깨어남체의 랜덤 명령 카드 1장을 손패에 추가합니다. 해당 카드에는 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:공허>가 부여됩니다. 전투 종료 시 HP를 [Arg1] 회복합니다."
  },
  RelicConfig_13808_Desc = {
    Text = "광기 폭발 사용 후, 대응하는 깨어남체의 랜덤 명령 카드 1장을 손패에 추가합니다. 해당 카드에는 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:공허>가 부여됩니다. 전투 종료 시 HP를 [Arg1] 회복합니다."
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:의사의 가방>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "의사의 신분을 상징하는 가방, 아주 무겁다.\n\n그것을 여는 사람이 진짜 의사가 아닐 수 있다.\n"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "모든 유물의 가격이 20% 감소합니다."
  },
  RelicConfig_13809_Desc = {
    Text = "모든 유물의 가격이 20% 감소합니다."
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:말재간>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "상인뿐만 아니라 신앙심 깊은 사람도 말을 잘한다."
  },
  RelicConfig_13811_BattleDesc = {
    Text = "「타격」을 3번 사용할 때마다 모든 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히고, 해당 각성체는 광기 15을 획득합니다."
  },
  RelicConfig_13811_Desc = {
    Text = "「타격」을 3번 사용할 때마다 모든 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히고, 해당 각성체는 광기 15을 획득합니다."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:녹슨 메스>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "생체를 자르는 데 적합하지 않습니다."
  },
  RelicConfig_13812_BattleDesc = {
    Text = "해당 유물 획득 시 최대 HP가 100% 증가하고, 턴 시작 시 HP를 [Arg1] 잃습니다."
  },
  RelicConfig_13812_Desc = {
    Text = "해당 유물 획득 시 최대 HP가 100% 증가하고, 턴 시작 시 HP를 [Arg1] 잃습니다."
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆영생자의 혈육☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "「해양 생물은 다리를 잘라서 살아남는 데 익숙하다.」"
  },
  RelicConfig_13813_BattleDesc = {
    Text = "전투 시작 시, 엘리트 적과 보스의 현재 HP가 20% 감소합니다."
  },
  RelicConfig_13813_Desc = {
    Text = "전투 시작 시, 엘리트 적과 보스의 현재 HP가 20% 감소합니다."
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆오래된 닻☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "빨리 집에 돌아가세요, 나의 오래된 선원。"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "턴 종료 시, 손패에 남아있는 카드 1장마다 모든 깨어남체가 2 광기를 획득합니다."
  },
  RelicConfig_13814_Desc = {
    Text = "턴 종료 시, 손패에 남아있는 카드 1장마다 모든 깨어남체가 2 광기를 획득합니다."
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:기울어진 저울>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "더 이상 공정성을 상징하지 않습니다."
  },
  RelicConfig_13815_BattleDesc = {
    Text = "해당 유물 획득 시, 카드를 1장 선택하여 해당 카드의 행동력 소비를 영구적으로 1로 변경합니다."
  },
  RelicConfig_13815_Desc = {
    Text = "해당 유물 획득 시, 카드를 1장 선택하여 해당 카드의 행동력 소비를 영구적으로 1로 변경합니다."
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆정제된 의안☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "더 이상 순수하지 않은 눈알."
  },
  RelicConfig_13816_BattleDesc = {
    Text = "전투 시작 시, 모든 적이 <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다. 피해를 입힐 때마다 광기를 가장 적게 보유한 깨어남체가 6 광기를 획득합니다."
  },
  RelicConfig_13816_Desc = {
    Text = "전투 시작 시, 모든 적이 <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다. 피해를 입힐 때마다 광기를 가장 적게 보유한 깨어남체가 6 광기를 획득합니다."
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆애곡의 방울☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "딩동, 딩동, 아이가 울고 있어요;\n딩동, 딩동, 아이가 비명을 지르고 있어요;\n딩동, 딩동, 아이가 울부짖고 있어요;\n딩동, 딩동, 배가 고픈 거예요, 당신이 알잖아요."
  },
  RelicConfig_13817_BattleDesc = {
    Text = "명령 카드를 6장 사용할 때마다, <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가합니다."
  },
  RelicConfig_13817_Desc = {
    Text = "명령 카드를 6장 사용할 때마다, <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가합니다."
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:균열 유충>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "우리의 뇌가 여전히 미스터리라면, 그 안에 촉수가 가득해도 놀랄 일이 아니다."
  },
  RelicConfig_13818_BattleDesc = {
    Text = "치명타율이 50% 증가하지만, 전투 시작 시 자신에게 <FragileIconKeywords:손상>을 3턴간 부여한다."
  },
  RelicConfig_13818_Desc = {
    Text = "치명타율이 50% 증가하지만, 전투 시작 시 자신에게 <FragileIconKeywords:손상>을 3턴간 부여한다."
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:기괴한 갈고리발톱>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "식별하기 어려운 종."
  },
  RelicConfig_13819_BattleDesc = {
    Text = "행동력 소비가 3 이상인 카드를 사용할 때마다, 카드를 1장 뽑고 행동력을 1 획득합니다."
  },
  RelicConfig_13819_Desc = {
    Text = "행동력 소비가 3 이상인 카드를 사용할 때마다, 카드를 1장 뽑고 행동력을 1 획득합니다."
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆상실타래의 미☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "그녀의 아름다움을 기억하는 이는 이미 없다."
  },
  RelicConfig_13820_BattleDesc = {
    Text = "증상 카드를 획득할 때마다 최대 HP가 [Arg1] 증가합니다."
  },
  RelicConfig_13820_Desc = {
    Text = "증상 카드를 획득할 때마다 최대 HP가 [Arg1] 증가합니다."
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆유향 약재☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "“달콤하고 유혹적인 향기.”"
  },
  RelicConfig_13821_BattleDesc = {
    Text = "광기 폭발 사용 후, 카드를 1장 뽑습니다. HP가 25% 미만일 경우, 추가로 카드를 1장 뽑습니다."
  },
  RelicConfig_13821_Desc = {
    Text = "광기 폭발 사용 후, 카드를 1장 뽑습니다. HP가 25% 미만일 경우, 추가로 카드를 1장 뽑습니다."
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:지식의 수레바퀴>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "읽을 때 안전에 주의하세요."
  },
  RelicConfig_13822_BattleDesc = {
    Text = "능동 피해를 입힐 때마다, <TentacleInjurieIconKeywords:촉수 피해>가 일시적으로 [Arg1] 증가합니다. 최대 3번까지 중첩되며, 최대 중첩 도달 시 최대 촉수 수량을 무시하는 임시 촉수를 1개 생성합니다."
  },
  RelicConfig_13822_Desc = {
    Text = "능동 피해를 입힐 때마다, <TentacleInjurieIconKeywords:촉수 피해>가 일시적으로 [Arg1] 증가합니다. 최대 3번까지 중첩되며, 최대 중첩 도달 시 최대 촉수 수량을 무시하는 임시 촉수를 1개 생성합니다."
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:나선의 황홀>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "영원한 잠의 주인이, 꿈 속에서 너를 기다리노라."
  },
  RelicConfig_13823_BattleDesc = {
    Text = "턴마다 [Arg1]번째로 사용하는 명령 카드가 2번 발동하며, 사용한 후 다시 손패로 돌아옵니다."
  },
  RelicConfig_13823_Desc = {
    Text = "턴마다 [Arg1]번째로 사용하는 명령 카드가 2번 발동하며, 사용한 후 다시 손패로 돌아옵니다."
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:별빛의 술+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "별들 사이를 거닐다."
  },
  RelicConfig_13824_BattleDesc = {
    Text = "매 턴 시작 시 <DeathResistanceIconKeywords:데스 리저스턴스>가 10% 증가합니다(이번 관카 내에서 데스 리저스턴스가 발동될 때마다 획득하는 데스 리저스턴스가 반으로 줄어듭니다). <DeathResistanceIconKeywords:데스 리저스턴스>가 100% 이상일 때, <ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다."
  },
  RelicConfig_13824_Desc = {
    Text = "매 턴 시작 시 <DeathResistanceIconKeywords:데스 리저스턴스>가 10% 증가합니다(이번 스테이지에서 데스 리저스턴스가 1회 발동될 때마다 획득하는 데스 리저스턴스가 절반으로 감소합니다). <DeathResistanceIconKeywords:데스 리저스턴스>가 100% 이상일 때, <ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:인어의 눈물>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "물에 넣지 마세요."
  },
  RelicConfig_13825_BattleDesc = {
    Text = "검은 인장을 10개 소모할 때마다 HP를 [Arg1]pt 회복한다."
  },
  RelicConfig_13825_Desc = {
    Text = "검은 인장을 10개 소모할 때마다 HP를 1% 회복합니다."
  },
  RelicConfig_13825_Name = {
    Text = "뒤집힌 뿌리"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "깨어남체의 카드가 아닌 카드를 사용할 때마다, 광기를 가장 적게 보유한 깨어남체가 10 광기를 획득합니다."
  },
  RelicConfig_13826_Desc = {
    Text = "깨어남체의 카드가 아닌 카드를 사용할 때마다, 광기를 가장 적게 보유한 깨어남체가 10 광기를 획득합니다."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:이국의 우표집>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "정량화된 추억."
  },
  RelicConfig_13827_BattleDesc = {
    Text = "해당 유물 획득 시, 검은 인장을 75개 획득하고, 보유한 유물 1개를 선택하여 랜덤 저주받은 유물로 교체합니다."
  },
  RelicConfig_13827_Desc = {
    Text = "해당 유물 획득 시, 검은 인장을 75개 획득하고, 보유한 유물 1개를 선택하여 랜덤 저주받은 유물로 교체합니다."
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:저주받은 비석>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "무를 때 깊은 바다의 부름을 들었다."
  },
  RelicConfig_13828_BattleDesc = {
    Text = "매 턴 처음으로 명령 카드가 버린 카드 더미로 보내진 후, 해당 카드의 임시 복사본 1장을 드로우 덱에 추가하고, 행동력 소비를 1 감소시킵니다."
  },
  RelicConfig_13828_Desc = {
    Text = "매 턴 처음으로 명령 카드가 버린 카드 더미로 보내진 후, 해당 카드의 임시 복사본 1장을 드로우 덱에 추가하고, 행동력 소비를 1 감소시킵니다."
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:소리 없는 축음기>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "그의 목소리가 바람에 사라졌다."
  },
  RelicConfig_13829_BattleDesc = {
    Text = "녹슨 열쇠 꾸러미. \n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_13829_Desc = {
    Text = "녹슨 열쇠 꾸러미. \n잠긴 문을 여는 데 사용할 수 있다."
  },
  RelicConfig_13829_Name = {
    Text = "녹슨 열쇠"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "HP 회복 시 추가로 [Arg1]의 방어막을 획득합니다. 3번째 턴 시작 시, <AlertIconKeywords:경계>를 [Arg2] 획득합니다."
  },
  RelicConfig_13830_Desc = {
    Text = "HP 회복 시 추가로 [Arg1]의 방어막을 획득합니다. 3번째 턴 시작 시, <AlertIconKeywords:경계>를 [Arg2] 획득합니다."
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:나비 표본>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "지금까지 그는 누군가에게 깊이 사랑받고 있다."
  },
  RelicConfig_13831_BattleDesc = {
    Text = "명령 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, 해당 카드의 주인이 15 광기를 획득합니다."
  },
  RelicConfig_13831_Desc = {
    Text = "명령 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, 해당 카드의 주인이 15 광기를 획득합니다."
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:시간 벌레>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "시계점과 곤충 박물관에 동시에 존재하는 포켓워치입니다. \n홍적 원년 이후, 대학의 소장품으로 편입되었습니다."
  },
  RelicConfig_13832_BattleDesc = {
    Text = "초차원 턴에 진입한 후 자신의 <WeaknessIconKeywords:허약>와 <FragileIconKeywords:손상> 상태를 해제하고, 모든 적에게 <WeaknessIconKeywords:허약>와 <VulnerabilityIconKeywords:취약>을 3턴간 부여한다. 이번 턴 모든 깨어남체의 최종 피해가 15% 증가한다."
  },
  RelicConfig_13832_Desc = {
    Text = "초차원 턴에 진입한 후 자신의 <WeaknessIconKeywords:허약>와 <FragileIconKeywords:손상> 상태를 해제하고, 모든 적에게 <WeaknessIconKeywords:허약>와 <VulnerabilityIconKeywords:취약>을 3턴간 부여한다. 이번 턴 모든 깨어남체의 최종 피해가 15% 증가한다."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:초끈 회중시계>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "“어라, 포켓 워치가 멈췄네.”"
  },
  RelicConfig_13833_BattleDesc = {
    Text = "피해를 입힐 때마다 대상에게 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다. 해당 효과가 전투 중 25회 발동했을 경우, 모든 적의 <IntoxicationIconKeywords:중독>을 즉시 발동시킵니다."
  },
  RelicConfig_13833_Desc = {
    Text = "피해를 입힐 때마다 대상에게 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다. 해당 효과가 전투 중 25회 발동했을 경우, 모든 적의 <IntoxicationIconKeywords:중독>을 즉시 발동시킵니다."
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆먼지 낀 재봉틀☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "자비로운 어머니가 심장의 상처를 봉합합니다."
  },
  RelicConfig_13834_BattleDesc = {
    Text = "방어막을 5번 획득할 때마다, 획득하는 방어막 [Arg1]%만큼의 <RetaliateIconKeywords:반격>을 추가로 획득합니다."
  },
  RelicConfig_13834_Desc = {
    Text = "방어막을 5번 획득할 때마다, 획득하는 방어막 [Arg1]%만큼의 <RetaliateIconKeywords:반격>을 추가로 획득합니다."
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:선현의 기록>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "“인간은 얼마나 어리석은가，단지 구시대적이라는 이유로 맹신한다.”"
  },
  RelicConfig_13835_BattleDesc = {
    Text = "턴 시작 시 카드를 1장 뽑습니다."
  },
  RelicConfig_13835_Desc = {
    Text = "턴 시작 시 카드를 1장 뽑습니다."
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:정밀 나침반>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "지시하는 것은 방향이 아니라 자기장입니다."
  },
  RelicConfig_13836_BattleDesc = {
    Text = "전투 시작 시, <DerivativeCardKeywords_3:“경련”>과 <DerivativeCardKeywords_4:“영감”>을 랜덤으로 <DimensionalSpaceIconKeywords:초원공간>에 넣으며 상한선에 도달할 때까지 진행합니다. 초차원 턴에 진입하면 [Arg1] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_13836_Desc = {
    Text = "전투 시작 시, 랜덤으로 <DerivativeCardKeywords_3:“경련”>과 <DerivativeCardKeywords_4:“영감”>을 <DimensionalSpaceIconKeywords:초원공간>에 최대 한도까지 넣습니다. 초차원 턴에 들어가면 [Arg1] 점의 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:알폰소의 기구>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "무상한 운명과는 달리, 별들이 자신의 운행 법칙을 가지고 있다."
  },
  RelicConfig_13837_BattleDesc = {
    Text = "줍을 때 100% <DeathResistanceIconKeywords:데스 리저스턴스>를 획득합니다(이번 스테이지에서 데스 리저스턴스가 발동할 때마다 획득하는 데스 리저스턴스가 절반으로 줄어듭니다). 데스 리저스턴스가 발동된 후, 이 전투에서 매 턴 시작 시 [Arg1] 점의 HP를 회복합니다."
  },
  RelicConfig_13837_Desc = {
    Text = "줍을 때 100% <DeathResistanceIconKeywords:데스 리저스턴스>를 획득합니다(이번 스테이지에서 데스 리저스턴스가 발동될 때마다 획득하는 데스 리저스턴스가 절반으로 줄어듭니다). <DeathResistanceIconKeywords:데스 리저스턴스>가 발동된 후, 이 전투에서 매 턴 시작 시 [Arg1] 점의 HP를 회복합니다."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:인공 호흡기>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "탐험가에게 꼭 필요한 훌륭한 물건입니다. 지나치게 의존하면 그것이 당신과 떼려야 뗄 수 없는 존재가 될지도 모릅니다."
  },
  RelicConfig_13838_BattleDesc = {
    Text = "이는 효과가 없는 태스크 유물2입니다"
  },
  RelicConfig_13838_Desc = {
    Text = "이는 효과가 없는 태스크 유물2입니다"
  },
  RelicConfig_13838_Name = {
    Text = "미션 유물 테스트 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "보완이 필요한 유물"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "손패가 1장일 때, 카드를 사용한 후 카드를 2장 뽑습니다. 턴마다 2번까지 발동합니다."
  },
  RelicConfig_13839_Desc = {
    Text = "손패가 1장일 때, 카드를 사용한 후 카드를 2장 뽑습니다. 턴마다 2번까지 발동합니다."
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆마술 장갑☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "「두려워하지 마, 이건 그냥 마법일 뿐이야.」"
  },
  RelicConfig_13840_BattleDesc = {
    Text = "매 3 턴마다 모든 적에게 1층의<WeaknessIconKeywords:약화>를 추가합니다. <WeaknessIconKeywords:약화> 상태의 적에게 피해를 입힌 후 [Arg1]의 일시적인<PowerIconKeywords:힘>을 획득합니다. 각 턴당 최대 3회까지 발동됩니다."
  },
  RelicConfig_13840_Desc = {
    Text = "3턴마다 모든 적에게 1턴 동안 <WeaknessIconKeywords:허약>을 부여합니다. <WeaknessIconKeywords:허약> 상태의 적에게 피해를 입힐 경우, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 턴마다 3번까지 발동합니다."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:악동>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "순수한 악에서 태어났지만, 그것의 의도는 아니었다."
  },
  RelicConfig_13841_BattleDesc = {
    Text = "모든 「타격」의 크리티컬 피해가 20% 증가합니다. 전투 시작 시, <DerivativeCardKeywords_40:「아름다운 순간」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13841_Desc = {
    Text = "모든 「타격」의 크리티컬 피해가 20% 증가합니다. 전투 시작 시, <DerivativeCardKeywords_40:「아름다운 순간」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:아름다운 순간>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "순간의 아름다움을 영원히 보관합니다."
  },
  RelicConfig_13842_BattleDesc = {
    Text = "죽음 저항이 발동하지 않은 치명적인 피해를 1번 무효화하고, HP를 [Arg1] 회복한 후 해당 유물을 영구적으로 비활성화시킵니다."
  },
  RelicConfig_13842_Desc = {
    Text = "죽음 저항이 발동하지 않은 치명적인 피해를 1번 무효화하고, HP를 [Arg1] 회복한 후 해당 유물을 영구적으로 비활성화시킵니다."
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:대역 인형>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "히히히, 히히히. 네가 나한테 빚진 거야?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "당신이 <WeaknessIconKeywords:허약>을 부여하면 실타래드를 [Arg1]pt 획득하고, <VulnerabilityIconKeywords:취약>을 부여하면 <PowerIconKeywords:임시 힘>을 [Arg2]pt 획득한다. 만약 1턴 내에 이 두 효과가 모두 발동하면, 추가로 실타래드를 [Arg1]pt와 <PowerIconKeywords:임시 힘>을 [Arg2]pt 획득한다."
  },
  RelicConfig_13844_Desc = {
    Text = "당신이 <WeaknessIconKeywords:허약>을 부여하면 실타래드를 [Arg1]pt 획득하고, <VulnerabilityIconKeywords:취약>을 부여하면 <PowerIconKeywords:임시 힘>을 [Arg2]pt 획득한다. 만약 1턴 내에 이 두 효과가 모두 발동하면, 추가로 실타래드를 [Arg1]pt와 <PowerIconKeywords:임시 힘>을 [Arg2]pt 획득한다."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:무거운 액자>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "정신이 혼란한 예술가가 남긴 마지막 작품으로,\n이 안에서 그의 공포에 찬 얼굴을 볼 수 있다고 한다."
  },
  RelicConfig_13845_BattleDesc = {
    Text = "행동력이 0이 될 때 행동력을 2 획득합니다. 턴마다 2번까지 발동합니다."
  },
  RelicConfig_13845_Desc = {
    Text = "행동력이 0이 될 때 행동력을 2 획득합니다. 턴마다 2번까지 발동합니다."
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆백은 차분기☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "“그것은 역사를 바꾸었습니다.”"
  },
  RelicConfig_13846_BattleDesc = {
    Text = "HP를 잃을 때마다 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 매 전투마다 최대 10번까지 발동합니다. 최대로 발동했을 경우, 잃은 HP의 25%를 회복합니다."
  },
  RelicConfig_13846_Desc = {
    Text = "HP를 잃을 때마다 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 매 전투마다 최대 10번까지 발동합니다. 최대로 발동했을 경우, 잃은 HP의 25%를 회복합니다."
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:최고의 영광>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "우아하고 신비로운 검은색 짧은 털 고양이, 어떤 먼 사막 국가에서 신의 화신으로 여겨졌다고 전해진다. 하지만 그 신의 이름은 이제 아무도 모른다. \n숭배받고, 존경받고, 잊혀지는 것이 신의 숙명일지도 모른다."
  },
  RelicConfig_13847_BattleDesc = {
    Text = "부정적인 상태의 적에게 입히는 피해가 20% 증가하고, 적을 처치했을 경우 처치자는 20 광기를 획득합니다."
  },
  RelicConfig_13847_Desc = {
    Text = "부정적인 상태의 적에게 입히는 피해가 20% 증가하고, 적을 처치했을 경우 처치자는 20 광기를 획득합니다."
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:제사장의 지팡이>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "허락되지 않은 성실타래."
  },
  RelicConfig_13848_BattleDesc = {
    Text = "해당 유물 획득 시, 파티의 영역 숙련이 원래 값의 150%로 증가합니다. 매 턴 명령 카드를 5번 사용한 후, 모든 깨어남체가 20 광기를 획득합니다."
  },
  RelicConfig_13848_Desc = {
    Text = "해당 유물 획득 시, 파티의 영역 숙련이 원래 값의 150%로 증가합니다. 매 턴 명령 카드를 5번 사용한 후, 모든 깨어남체가 20 광기를 획득합니다."
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:시계추「불결함」>"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "매 턴 3번째로 피해를 입힌 후, [Arg1]의 방어막을 획득합니다. 매 턴 6번째로 피해를 입힌 후, <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13849_Desc = {
    Text = "매 턴 3번째로 피해를 입힌 후, [Arg1]의 방어막을 획득합니다. 매 턴 6번째로 피해를 입힌 후, <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:안전한 출구>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "보아하니, 그도 도망치지 못한 것 같습니다."
  },
  RelicConfig_13851_BattleDesc = {
    Text = "<DevouredIconKeywords:포식>이 발동될 때마다 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다."
  },
  RelicConfig_13851_Desc = {
    Text = "<DevouredIconKeywords:포식>이 발동될 때마다 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다."
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:보이지 않는 손>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "살인, 강도, 가려움을 다스리는 데 최고의 도구입니다."
  },
  RelicConfig_13852_BattleDesc = {
    Text = "해당 유물 획득 시, 깨어남체 1명을 선택하여 깨어남시키고, 해당 깨어남체의 영지 깨어남 행동력 소비가 영구적으로 1 감소합니다."
  },
  RelicConfig_13852_Desc = {
    Text = "해당 유물 획득 시, 깨어남체 1명을 선택하여 깨어남시키고, 해당 깨어남체의 영지 깨어남 행동력 소비가 영구적으로 1 감소합니다."
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:이스터 에그>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "즐거움을 마음껏 누리되 섭취할 수 없습니다."
  },
  RelicConfig_13853_BattleDesc = {
    Text = "피해를 입힐 때마다 임시 <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다. 턴마다 5번까지 발동하며, 5번째 발동 시 <DerivativeCardKeywords_4:「영감」> 1장을 드로우 덱에 추가합니다."
  },
  RelicConfig_13853_Desc = {
    Text = "피해를 입힐 때마다 임시 <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다. 턴마다 5번까지 발동하며, 5번째 발동 시 <DerivativeCardKeywords_4:「영감」> 1장을 드로우 덱에 추가합니다."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:의식용 단검>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "날이 굽어진 단검. 주로 제사 의식에 사용된다."
  },
  RelicConfig_13854_BattleDesc = {
    Text = "턴 시작 시, 카드를 2장 뽑고, 행동력을 2 획득합니다. 명령 카드나 영지 깨어남 카드를 뽑을 때마다 해당 카드의 행동력 소비를 랜덤으로 변경시킵니다. (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "턴 시작 시, 카드를 2장 뽑고, 행동력을 2 획득합니다. 명령 카드나 영지 깨어남 카드를 뽑을 때마다 해당 카드의 행동력 소비를 랜덤으로 변경시킵니다. (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:속임수의 모자>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "카시아 양의 환상 서커스에 오신 것을 환영합니다! 조심하세요, 마법 도구를 함부로 만지지 마세요. 만약 불행히도 물리면 큰일입니다. \n결국, 그것이 마지막으로 피의 맛을 본 후의 결과는 매우 공포스러웠습니다. \n\n모자가 눈을 깜빡이며 언제든지 변신할 준비가 되어 있는 것처럼 보입니다."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "턴 시작 시 및 매 턴 HP 회복 시 [Arg1] 포인트의 <RetaliateIconKeywords:반격>을 획득하며, 매 턴 최대 3번 반격을 획득할 수 있습니다. 상한에 도달하면 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  RelicConfig_13855_Desc = {
    Text = "턴 시작 시 및 매 턴 HP 회복 시 [Arg1] 포인트의 <RetaliateIconKeywords:반격>을 획득하며, 매 턴 최대 3번 반격을 획득할 수 있습니다. 상한에 도달하면 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:작은 오르골>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "덕스터의 저택에는 많은 수집품이 있다. 부서지기 전, 작은 팔음함은 덕스터 소녀가 가장 좋아하는 장난감이었다.\n세월이 흘렀고, 덕스터 소녀가 다시 그녀를 찾았을 때, 그녀는 기어가 느슨해지고 음악이 변조되었지만 여전히 회전을 멈추지 않았다."
  },
  RelicConfig_13856_BattleDesc = {
    Text = "크리티컬 피해가 15% 증가합니다. 「타격」의 크리티컬 확률이 40% 증가합니다."
  },
  RelicConfig_13856_Desc = {
    Text = "크리티컬 피해가 15% 증가합니다. 「타격」의 크리티컬 확률이 40% 증가합니다."
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:흰 까마귀 부리>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "그 앞에서 비밀은 없습니다."
  },
  RelicConfig_13857_BattleDesc = {
    Text = "광기 폭발을 사용한 후, <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다. 이번 전투 동안 6번째로 발동했을 경우, 보유한 <RetaliateIconKeywords:반격> 수치를 2배로 증가시킵니다."
  },
  RelicConfig_13857_Desc = {
    Text = "광기 폭발을 사용한 후, <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다. 이번 전투 동안 6번째로 발동했을 경우, 보유한 <RetaliateIconKeywords:반격> 수치를 2배로 증가시킵니다."
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆육분의☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "너를 인도하는 것은 오직 잘못된 길뿐이다."
  },
  RelicConfig_13858_BattleDesc = {
    Text = "턴마다 추가로 카드를 1장 뽑고, 행동력을 1pt 획득합니다."
  },
  RelicConfig_13858_Desc = {
    Text = "턴마다 추가로 카드를 1장 뽑고, 행동력을 1pt 획득합니다."
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆추억이 방울방울☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "누군가는 그 여름에 영원히 머물렀다."
  },
  RelicConfig_13859_BattleDesc = {
    Text = "턴 시작 시 카드를 1장 뽑습니다. 전투 시작 시, <DerivativeCardKeywords_4:「영감」> 1장을 덱에 추가합니다. 매 전투마다 추가하는 <DerivativeCardKeywords_4:「영감」> 매수가 1장씩 증가하며, 최대 3번까지 증가합니다."
  },
  RelicConfig_13859_Desc = {
    Text = "턴 시작 시 카드를 1장 뽑습니다. 전투 시작 시, <DerivativeCardKeywords_4:「영감」> 1장을 덱에 추가합니다. 매 전투마다 추가하는 <DerivativeCardKeywords_4:「영감」> 매수가 1장씩 증가하며, 최대 3번까지 증가합니다."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:프라스노 거울>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "빛과 그림자의 마술."
  },
  RelicConfig_13860_BattleDesc = {
    Text = "같은 깨어남체의 카드를 연속으로 사용할 때마다, 해당 깨어남체가 8 광기를 획득합니다."
  },
  RelicConfig_13860_Desc = {
    Text = "같은 깨어남체의 카드를 연속으로 사용할 때마다, 해당 깨어남체가 8 광기를 획득합니다."
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:정밀 계측기>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "인류 역사상 가장 사악한 발명품 중 하나입니다."
  },
  RelicConfig_13861_BattleDesc = {
    Text = "해당 유물 획득 시, 깨어남체 카드 1장을 선택하여 행동력 소비를 1 감소시키고, 해당 카드를 「타격」으로 취급합니다."
  },
  RelicConfig_13861_Desc = {
    Text = "해당 유물 획득 시, 깨어남체 카드 1장을 선택하여 행동력 소비를 1 감소시키고, 해당 카드를 「타격」으로 취급합니다."
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:우연의 오류>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "하하하, 시원하게 웃자!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "해당 유물 획득 시, 영구적으로 <PowerIconKeywords:힘>을 [Arg1] 잃습니다. 피해를 입힐 때마다 HP를 [Arg2] 회복합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_13862_Desc = {
    Text = "영구적으로 <PowerIconKeywords:힘>을 [Arg1] 잃습니다. 피해를 입힐 때마다 HP를 [Arg2] 회복합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:일곱 비늘의 키스>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "깊은 키스를 원해? 당신을 죽일 정도로."
  },
  RelicConfig_13863_BattleDesc = {
    Text = "전투 첫 번째 턴에 행동력을 3 획득합니다."
  },
  RelicConfig_13863_Desc = {
    Text = "전투 첫 번째 턴에 행동력을 3 획득합니다."
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:회중시계 거울>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "기억이 과거의 시간에 굳어져 검은 바닥에 깊이 묻혀 있습니다."
  },
  RelicConfig_13864_BattleDesc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 후, 해당 깨어남체의 「타격」을 1장 손패에 추가하여 <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>를 부여합니다."
  },
  RelicConfig_13864_Desc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 후, 해당 깨어남체의 「타격」을 1장 손패에 추가하여 <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>를 부여합니다."
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:신식 차축>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "시골에서 도시로, 재난에서 부흥으로."
  },
  RelicConfig_13865_BattleDesc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 후, 해당 깨어남체의 「방어」 1장을 손패에 추가하여 <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>를 부여합니다."
  },
  RelicConfig_13865_Desc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 후, 해당 깨어남체의 「방어」 1장을 손패에 추가하여 <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>를 부여합니다."
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:조용한 서곡>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "유명한 바이올리니스트 에릭 아이크슈타인의 바이올린입니다. \n지금은 더 이상 연주할 수 없습니다."
  },
  RelicConfig_13866_BattleDesc = {
    Text = "3턴마다 모든 적에게 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. <VulnerabilityIconKeywords:취약> 상태의 적에게 피해를 입힌 후, 해당 적의 임시 <PowerIconKeywords:힘>을 [Arg1]pt 잃게 한다. 턴마다 최대 3회 발동한다."
  },
  RelicConfig_13866_Desc = {
    Text = "3턴마다 모든 적에게 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. <VulnerabilityIconKeywords:취약> 상태의 적에게 피해를 입힌 후, 해당 적의 임시 <PowerIconKeywords:힘>을 [Arg1]pt 잃게 한다. 턴마다 최대 3회 발동한다."
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:봄의 제전>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "밤의 웃음소리 속에서 카누의 실타래루엣이 호수 위를 자유롭게 미끄러졌다."
  },
  RelicConfig_13867_BattleDesc = {
    Text = "최대 손패 매수가 3 증가하지만, 턴마다 뽑는 카드 매수가 1 감소합니다. 턴 종료 시 손패의 모든 증상 카드와 손패 카드를 버리고, 다른 카드는 보존됩니다."
  },
  RelicConfig_13867_Desc = {
    Text = "최대 손패 매수가 3 증가하지만, 턴마다 뽑는 카드 매수가 1 감소합니다. 턴 종료 시 손패의 모든 증상 카드와 손패 카드를 버리고, 다른 카드는 보존됩니다."
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:각인된 의식>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "고대 부족은 죽은 이의 두개골에 특수 기호를 새김으로써 그의 영혼을 남겨두어 영원한 동반자로 만들 수 있다는 것을 믿었다."
  },
  RelicConfig_13868_BattleDesc = {
    Text = "광기 폭발을 4번 사용한 후, 손패에 있는 모든 카드의 행동력 소비가 1 감소합니다."
  },
  RelicConfig_13868_Desc = {
    Text = "광기 폭발을 4번 사용한 후, 손패에 있는 모든 카드의 행동력 소비가 1 감소합니다."
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆탈출 평면도☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "「등선 후, 가장 가까운 안전 출구를 먼저 찾아주세요.」"
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다. 능동 피해를 입힐 때마다 임시 촉수 피해가 [Arg1] 증가하고, 촉수 피해를 입힐 때마다 [Arg2]의 방어막을 획득합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다. 능동 피해를 입힐 때마다 임시 촉수 피해가 [Arg1] 증가하고, 촉수 피해를 입힐 때마다 [Arg2]의 방어막을 획득합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:시계추「몽마」>"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "행동력을 1 소비할 때마다, 대응하는 깨어남체가 2 광기를 획득합니다."
  },
  RelicConfig_13870_Desc = {
    Text = "행동력을 1 소비할 때마다, 대응하는 깨어남체가 2 광기를 획득합니다."
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:은색 버클 리본>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "사건 현장에 나타났던 리본이 외력으로 두 조각으로 찢어졌다. \n그 중 하나가 높은 곳에서 날아내려 소녀의 손바닥에 떨어졌다."
  },
  RelicConfig_13871_BattleDesc = {
    Text = "턴 시작 시, 모든 깨어남체가 10 광기를 획득합니다. 해당 유물 획득 시 모든 깨어남체의 최대 HP가 30% 감소합니다."
  },
  RelicConfig_13871_Desc = {
    Text = "턴 시작 시, 모든 깨어남체가 10 광기를 획득합니다. 해당 유물 획득 시 모든 깨어남체의 최대 HP가 30% 감소합니다."
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:악몽의 표상>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "조심하세요, 방종한 심면은 당신이 모르는 사이에 모든 것을 흡수할 것입니다."
  },
  RelicConfig_13873_BattleDesc = {
    Text = "<ExaltIconKeywords:영지 깨어남>을 사용한 후, 모든 적의 방어막을 제거합니다."
  },
  RelicConfig_13873_Desc = {
    Text = "<ExaltIconKeywords:영지 깨어남>을 사용한 후, 모든 적의 방어막을 제거합니다."
  },
  RelicConfig_13873_Name = {
    Text = "검은 거울"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "홀수 턴일 경우, 남은 손패 매수가 0일 때 카드를 2장 뽑습니다. 짝수 턴일 경우, 남은 행동력이 0일 때 행동력을 2 획득합니다."
  },
  RelicConfig_13874_Desc = {
    Text = "홀수 턴일 경우, 남은 손패 매수가 0일 때 카드를 2장 뽑습니다. 짝수 턴일 경우, 남은 행동력이 0일 때 행동력을 2 획득합니다."
  },
  RelicConfig_13874_Name = {
    Text = "기형 황금 가이드"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "「타격」과 「방어」의 행동력 소비가 1 증가하고, 사용 시 해당 깨어남체가 35 광기를 획득합니다."
  },
  RelicConfig_13875_Desc = {
    Text = "「타격」과 「방어」의 행동력 소비가 1 증가하고, 사용 시 해당 깨어남체가 35 광기를 획득합니다."
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:부서진 가면>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "누구의 얼굴이 공포에 차서 시간 속에 굳어져 있다."
  },
  RelicConfig_13877_BattleDesc = {
    Text = "매 턴 2번째 방어막을 획득한 후 [Arg1] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 매 턴 4번째 방어막을 획득한 후 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  RelicConfig_13877_Desc = {
    Text = "매 턴 2번째 방어막을 획득한 후 [Arg1] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 매 턴 4번째 방어막을 획득한 후 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:숨김 없는 전달자>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "그것은 수많은 주동적이거나 수동적으로 말해진 비밀을 전달한다."
  },
  RelicConfig_13878_BattleDesc = {
    Text = "명령 카드를 6장 사용할 때마다, 마지막으로 사용한 카드를 버린 카드 더미에서 손패로 가져옵니다."
  },
  RelicConfig_13878_Desc = {
    Text = "명령 카드를 6장 사용할 때마다, 마지막으로 사용한 카드를 버린 카드 더미에서 손패로 가져옵니다."
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:황혼 속에서>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "함께 사진을 찍어봐! 진실타래한 고통을 체험해보자."
  },
  RelicConfig_13879_BattleDesc = {
    Text = "광기 폭발을 5회 사용할 떄마다, 마지막으로 광기 폭발을 사용한 깨어남체가 100 광기를 획득합니다."
  },
  RelicConfig_13879_Desc = {
    Text = "광기 폭발을 5회 사용할 떄마다, 마지막으로 광기 폭발을 사용한 깨어남체가 100 광기를 획득합니다."
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:작은 요람>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "희망、축복과 사랑을 담아."
  },
  RelicConfig_13880_BattleDesc = {
    Text = "능동 피해를 입힐 때마다, [Arg1]의 방어막을 획득합니다. HP를 회복할 때마다, 임시 <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13880_Desc = {
    Text = "능동 피해를 입힐 때마다, [Arg1]의 방어막을 획득합니다. HP를 회복할 때마다, 임시 <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:우리의 집>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "그들은 이전에 함께 있었고, 이후에도 항상 함께 있을 것입니다. 그들은 서로를 사랑하는 한 가족입니다."
  },
  RelicConfig_13881_BattleDesc = {
    Text = "홀수 턴 시작 시, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 짝수 턴 시작 시, 임시 <AlertIconKeywords:경계>를 [Arg2] 획득합니다."
  },
  RelicConfig_13881_Desc = {
    Text = "홀수 턴 시작 시, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 짝수 턴 시작 시, 임시 <AlertIconKeywords:경계>를 [Arg2] 획득합니다."
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:쌍둥이 인형>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "쌍둥이는 옛 시대의 선물이며, 미래를 위한 우화입니다."
  },
  RelicConfig_13882_BattleDesc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 깨어남체가 턴 종료 시 20 광기를 획득합니다. 「헌신의 정신」 유물을 함께 보유하고 있을 경우, 다른 깨어남체도 5 광기를 획득합니다."
  },
  RelicConfig_13882_Desc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 깨어남체가 턴 종료 시 20 광기를 획득합니다. 「헌신의 정신」 유물을 함께 보유하고 있을 경우, 다른 깨어남체도 5 광기를 획득합니다."
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:어머니의 형상>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "“주십시오, 무엇이든 주겠습니다, 제발 그를 놔두세요.”"
  },
  RelicConfig_13883_BattleDesc = {
    Text = "깨어남체가 <DevouredIconKeywords:포식>을 발동할 때마다, 다른 깨어남체들이 10 광기를 획득합니다."
  },
  RelicConfig_13883_Desc = {
    Text = "깨어남체가 <DevouredIconKeywords:포식>을 발동할 때마다, 다른 깨어남체들이 10 광기를 획득합니다."
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:황금빛 꿈나라>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "변화의 날이 바로 당신의 죽음의 날입니다."
  },
  RelicConfig_13884_BattleDesc = {
    Text = "「타격」 사용 시 모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다."
  },
  RelicConfig_13884_Desc = {
    Text = "「타격」 사용 시 모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:신경 독소>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "추출, 정제."
  },
  RelicConfig_13885_BattleDesc = {
    Text = "전투 시작 시, <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다. 보스 전투라면, 추가로 <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13885_Desc = {
    Text = "전투 시작 시, <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다. 보스 전투라면, 추가로 <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:통신 장비>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "그것이 맑은 종소리를 내는 순간을 기대하거나 두려워합니다."
  },
  RelicConfig_13886_BattleDesc = {
    Text = "덱이 초기화될 때마다, <DerivativeCardKeywords_5:「삼지창」> 2장과 <DerivativeCardKeywords_6:「양산」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13886_Desc = {
    Text = "덱이 초기화될 때마다, <DerivativeCardKeywords_5:「삼지창」> 2장과 <DerivativeCardKeywords_6:「양산」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆숙녀의 작은 가방☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "그것은 정교하게 장식되어야 했지, 죽음으로 가득 차서는 안 해야 합니다."
  },
  RelicConfig_13887_BattleDesc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_5:「삼지창」> 1장을 손패에 추가합니다. 광기 폭발 사용 시, 손패의 모든 <DerivativeCardKeywords_5:「삼지창」>의 <PowerIconKeywords:힘>을 [Arg2] 증가시킵니다."
  },
  RelicConfig_13887_Desc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_5:「삼지창」> 1장을 손패에 추가합니다. 광기 폭발 사용 시, 손패의 모든 <DerivativeCardKeywords_5:「삼지창」>의 <PowerIconKeywords:힘>을 [Arg2] 증가시킵니다."
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:삼지창>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "무론 어떻게 봐도 보통이다."
  },
  RelicConfig_13888_BattleDesc = {
    Text = "전투 시작 시 [Arg1]의 방어막을 획득합니다. 해당 전투 동안 「방어」를 7번 사용하면 즉시 [Arg2]의 방어막을 획득합니다. 해당 전투 동안 「방어」를 21번 사용하면 임시 장벽 1스택을 획득합니다."
  },
  RelicConfig_13888_Desc = {
    Text = "전투 시작 시 [Arg1]의 방어막을 획득합니다. 해당 전투 동안 「방어」를 7번 사용하면 즉시 [Arg2]의 방어막을 획득합니다. 해당 전투 동안 「방어」를 21번 사용하면 임시 장벽 1스택을 획득합니다."
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:포트니 아침 신문>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "당신의 변기와 가장 친한 친구입니다."
  },
  RelicConfig_13889_BattleDesc = {
    Text = "초차원 턴 진입 후, 행동력을 3 획득합니다."
  },
  RelicConfig_13889_Desc = {
    Text = "초차원 턴 진입 후, 행동력을 3 획득합니다."
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:빛나는 모래시계>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "측정 가능한 시간입니다."
  },
  RelicConfig_13890_BattleDesc = {
    Text = "전투 시작 시, 모든 적에게 1턴 동안 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 보스 전투일 경우 추가로 2턴 동안 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  RelicConfig_13890_Desc = {
    Text = "전투 시작 시, 모든 적에게 1턴 동안 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 보스 전투일 경우 추가로 2턴 동안 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:변색 구속복>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "시간뿐만 아니라 공포와 고통도 물감을 변색시킬 수 있다."
  },
  RelicConfig_13891_BattleDesc = {
    Text = "매 턴 처음으로 사용한 카드가 워프 효과를 발동했을 경우 카드를 1장 뽑고, 그렇지 않을 경우 행동력을 1 획득합니다. 초차원 턴에는 두 가지 효과가 모두 적용됩니다."
  },
  RelicConfig_13891_Desc = {
    Text = "매 턴 처음으로 사용한 카드가 워프 효과를 발동했을 경우 카드를 1장 뽑고, 그렇지 않을 경우 행동력을 1 획득합니다. 초차원 턴에는 두 가지 효과가 모두 적용됩니다."
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:도약 장치>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "왜곡된 그림자를 반사해."
  },
  RelicConfig_13892_BattleDesc = {
    Text = "퀘스트를 하나 부여합니다. 퀘스트를 완료하여 보상을 획득합니다. [이벤트 플레이스홀더]"
  },
  RelicConfig_13892_Desc = {
    Text = "퀘스트를 하나 부여합니다. 퀘스트를 완료하여 보상을 획득합니다. [이벤트 플레이스홀더]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:낡은 일기장>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "낡은 일기장, 내지는 삽입 페이지로 가득 차 있으며, 대충 보면 최소한 엘워스 지도, 실타래험 기록, 삼각형 융화자국으로 가득한 서신지가 포함되어 있습니다. \n 노트의 앞부분은 글씨가 가지런하고 정돈되어 있지만, 이후에는 점차 흐트러지고 어지럽게 변합니다."
  },
  RelicConfig_13893_BattleDesc = {
    Text = "방어막을 4번 획득할 때마다, 획득한 방어막 수치 50%만큼의 HP를 회복합니다."
  },
  RelicConfig_13893_Desc = {
    Text = "방어막을 4번 획득할 때마다, 획득한 방어막 수치 50%만큼의 HP를 회복합니다."
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:선원 호루라기>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "미인어를 제외하고, 휘파람은 회오리바람, 악취 나는 장화, 그리고 100일 동안 목욕을 하지 않은 수레주인을 불러올 수 있다。"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "이전 턴에 4장 이하의 카드를 사용했을 경우, 이번 턴에 처음 사용하는 카드의 효과가 2회 발동합니다."
  },
  RelicConfig_13894_Desc = {
    Text = "이전 턴에 4장 이하의 카드를 사용했을 경우, 이번 턴에 처음 사용하는 카드의 효과가 2회 발동합니다."
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆악몽의 영혼 등불☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "환몽을 소개합니다."
  },
  RelicConfig_13895_BattleDesc = {
    Text = "HP를 잃을 때마다 광기를 가장 적게 보유한 깨어남체가 10 광기를 획득합니다. HP를 5번 잃을 때마다 잃은 HP의 20%를 회복합니다."
  },
  RelicConfig_13895_Desc = {
    Text = "HP를 잃을 때마다 광기를 가장 적게 보유한 깨어남체가 10 광기를 획득합니다. HP를 5번 잃을 때마다 잃은 HP의 20%를 회복합니다."
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:시계추「해석」>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "최대 행동력이 2 증가합니다. 덱이 초기화될 때마다 <DerivativeCardKeywords_9:「흐트러짐」> 1장을 드로우 덱에 추가합니다."
  },
  RelicConfig_13896_Desc = {
    Text = "최대 행동력이 2 증가합니다. 덱이 초기화될 때마다 <DerivativeCardKeywords_9:「흐트러짐」> 1장을 드로우 덱에 추가합니다."
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:검은 촛대>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "화염 속에서 명료함을 태우다, 허망에 빠지다."
  },
  RelicConfig_13897_BattleDesc = {
    Text = "<ExaltIconKeywords:영지 깨어남>이 턴 종료 시 보존됩니다."
  },
  RelicConfig_13897_Desc = {
    Text = "<ExaltIconKeywords:영지 깨어남>이 턴 종료 시 보존됩니다."
  },
  RelicConfig_13897_Name = {
    Text = "하얀 거울"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "영지 깨어남 상태의 깨어남체 1명마다 <ProficientInRealmsIconKeywords:영역 숙련>이 35 증가합니다. <ExaltIconKeywords:영지 깨어남>을 사용한 후, 해당 깨어남체의 랜덤 명령 카드를 2장 손패에 추가하고, 「소모」를 부여합니다."
  },
  RelicConfig_13898_Desc = {
    Text = "영지 깨어남 상태의 깨어남체 1명마다 <ProficientInRealmsIconKeywords:영역 숙련>이 35 증가합니다. <ExaltIconKeywords:영지 깨어남>을 사용한 후, 해당 깨어남체의 랜덤 명령 카드를 2장 손패에 추가하고, 「소모」를 부여합니다."
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:그분의 신탁>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "그는 말했다, 두려워하지 말라고。"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "턴 시작 시, <ProficientInRealmsIconKeywords:영역 숙련>이 50 증가합니다. 부정적인 상태를 보유하지 않았을 경우 <ProficientInRealmsIconKeywords:영역 숙련> 증가량이 150으로 증가합니다."
  },
  RelicConfig_13899_Desc = {
    Text = "턴 시작 시, <ProficientInRealmsIconKeywords:영역 숙련>이 50 증가합니다. 부정적인 상태를 보유하지 않았을 경우 <ProficientInRealmsIconKeywords:영역 숙련> 증가량이 150으로 증가합니다."
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆「자유에 경의를 표하라」☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "한 손에 담긴 조금의 향수를 느끼게 하는 은심."
  },
  RelicConfig_13900_BattleDesc = {
    Text = "광기 폭발을 사용한 후, 손패에 있는 모든 카드의 행동력 소비가 1 감소합니다."
  },
  RelicConfig_13900_Desc = {
    Text = "광기 폭발을 사용한 후, 손패에 있는 모든 카드의 행동력 소비가 1 감소합니다."
  },
  RelicConfig_13900_Name = {
    Text = "기형 문명의 빛"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "매 명령 카드 1장 사용 시 [Arg2]%의 <DeathResistanceIconKeywords:데스 리저스턴스>를 획득합니다(이번 스테이지에서 데스 리저스턴스가 1회 발동할 때마다 획득하는 데스 리저스턴스가 절반으로 줄어듭니다). 만약 당신의 <DeathResistanceIconKeywords:데스 리저스턴스>가 100% 이상이면 [Arg1] 점의 임시<PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_13901_Desc = {
    Text = "매 명령 카드 1장 사용 시 [Arg2]%의 <DeathResistanceIconKeywords:데스 리저스턴스>를 획득합니다(이번 스테이지에서 데스 리저스턴스가 1회 발동할 때마다 획득하는 데스 리저스턴스가 절반으로 줄어듭니다). 만약 당신의 <DeathResistanceIconKeywords:데스 리저스턴스>가 100% 이상이면 [Arg1] 점의 임시 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:뱀의 허물>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "자해를 통해 탈피하여 재생성한다."
  },
  RelicConfig_13902_BattleDesc = {
    Text = "턴 시작 후 [Arg2] 포인트의 방어막을 획득합니다. 턴 종료 후 무작위 적에게 현재 방어막 수치의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, 보스전에서는 피해 효과가 2배가 됩니다."
  },
  RelicConfig_13902_Desc = {
    Text = "턴 시작 후 [Arg2] 포인트의 방어막을 획득합니다. 턴 종료 후 무작위 적에게 현재 방어막 수치의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, 보스전에서는 피해 효과가 2배가 됩니다."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:황금 가이드>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "방향을 잃었을 때 열어보세요, 하지만 조심하세요——그것의 코로나는 햇빛을 볼 수 없습니다."
  },
  RelicConfig_13904_BattleDesc = {
    Text = "적의 의도를 숨깁니다. 매 턴 행동력을 1 획득하고, 카드를 1장 뽑습니다."
  },
  RelicConfig_13904_Desc = {
    Text = "적의 의도를 숨깁니다. 매 턴 행동력을 1 획득하고, 카드를 1장 뽑습니다."
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:미혹의 풍경>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "딩동댕. 딩동댕."
  },
  RelicConfig_13905_BattleDesc = {
    Text = "전투 시작 후, <RetaliateIconKeywords:반격>을 [Arg2] 획득합니다. 「방어」 사용 시 <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다."
  },
  RelicConfig_13905_Desc = {
    Text = "전투 시작 후, <RetaliateIconKeywords:반격>을 [Arg2] 획득합니다. 「방어」 사용 시 <RetaliateIconKeywords:반격>을 [Arg1] 획득합니다."
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:쐐기풀 조끼>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "오염된 액체를 구분할 수 없습니다."
  },
  RelicConfig_13906_BattleDesc = {
    Text = "이것은 4번의 효과가 없는 주간 대체 유물입니다"
  },
  RelicConfig_13906_Desc = {
    Text = "이것은 4번의 효과가 없는 주간 대체 유물입니다"
  },
  RelicConfig_13906_Name = {
    Text = "일상 도전 주간 대체 유물 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "턴 시작 시, 이전 턴에 카드를 3장 이상 사용했을 경우, 카드를 2장 뽑습니다."
  },
  RelicConfig_13907_Desc = {
    Text = "턴 시작 시, 이전 턴에 카드를 3장 이상 사용했을 경우, 카드를 2장 뽑습니다."
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:새 지갑>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "미사그 대학의 문장이 새겨진 가죽 지갑입니다. \n지금은 비어 있어 아무것도 없습니다."
  },
  RelicConfig_13908_BattleDesc = {
    Text = "광기 폭발을 사용한 후, 해당 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  RelicConfig_13908_Desc = {
    Text = "광기 폭발을 사용한 후, 해당 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  RelicConfig_13908_Name = {
    Text = "기형 이름 없는 신의 베일"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "광기 폭발 사용 후, 현재 HP의 8%를 잃고, 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다. 적이 하나일 경우, 추가로 임시 <PowerIconKeywords:힘>을 [Arg2] 탈취합니다."
  },
  RelicConfig_13909_Desc = {
    Text = "광기 폭발 사용 후, 현재 HP의 8%를 잃고, 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다. 적이 하나일 경우, 추가로 임시 <PowerIconKeywords:힘>을 [Arg2] 탈취합니다."
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:재앙 의식의 새>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "말라버린 시체가 울음소리를 내며 울렸습니다."
  },
  RelicConfig_13910_BattleDesc = {
    Text = "광기 폭발 사용 후, 대응하는 깨어남체가 10 광기를 획득하고, [Arg1]의 방어막을 획득합니다."
  },
  RelicConfig_13910_Desc = {
    Text = "광기 폭발 사용 후, 대응하는 깨어남체가 10 광기를 획득하고, [Arg1]의 방어막을 획득합니다."
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:이름 없는 신의 베일>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "신을 직시할 수 없다."
  },
  RelicConfig_13911_BattleDesc = {
    Text = "매 턴 마지막으로 명령 카드를 사용한 깨어남체가 턴 종료 시 20 광기를 획득합니다. 「어머니의 형상」 유물을 함께 보유하고 있을 경우, 다른 깨어남체도 5 광기를 획득합니다."
  },
  RelicConfig_13911_Desc = {
    Text = "매 턴 마지막으로 명령 카드를 사용한 깨어남체가 턴 종료 시 20 광기를 획득합니다. 「어머니의 형상」 유물을 함께 보유하고 있을 경우, 다른 깨어남체도 5 광기를 획득합니다."
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:헌신의 정신>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "“주십시오, 무엇이든 주겠습니다, 제발 저를 용서해주세요.”"
  },
  RelicConfig_13912_BattleDesc = {
    Text = "턴 종료 시 남은 손패 1장마다, 다음 턴 시작 시 행동력을 1 획득합니다."
  },
  RelicConfig_13912_Desc = {
    Text = "턴 종료 시 남은 손패 1장마다, 다음 턴 시작 시 행동력을 1 획득합니다."
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:시계추「연역」>"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "턴 시작 시, HP가 [Arg1]보다 높을 경우 HP를 [Arg1] 잃고, 임시 <PowerIconKeywords:힘>을 [Arg2], 임시 <AlertIconKeywords:경계>를 [Arg3] 획득합니다."
  },
  RelicConfig_13913_Desc = {
    Text = "턴 시작 시, HP가 [Arg1]보다 높을 경우 HP를 [Arg1] 잃고, 임시 <PowerIconKeywords:힘>을 [Arg2], 임시 <AlertIconKeywords:경계>를 [Arg3] 획득합니다."
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:구원의 수족>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "신성한 일부입니다. \n몸통과 분리되어 있어도 여전히 따뜻함을 느낄 수 있습니다."
  },
  RelicConfig_13914_BattleDesc = {
    Text = "「타격」 사용 시 행동력을 2 획득하는 대신, 손패의 랜덤 카드 1장을 버립니다. 「방어」 사용 시 카드를 2장 뽑는 대신, 행동력을 1 잃습니다. 턴마다 3번까지 발동합니다."
  },
  RelicConfig_13914_Desc = {
    Text = "「타격」 사용 시 행동력을 2 획득하는 대신, 손패의 랜덤 카드 1장을 버립니다. 「방어」 사용 시 카드를 2장 뽑는 대신, 행동력을 1 잃습니다. 턴마다 3번까지 발동합니다."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:행복한 레코드>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "유명한 바이올리니스트의 마지막 공연을 녹음한 음반입니다. \n그 이후로, 그것은 불꽃을 일으킵니다."
  },
  RelicConfig_13915_BattleDesc = {
    Text = "추천 영역 보너스가 50%로 증가하며, 탐사 시작 시 <ProficientInRealmsIconKeywords:영역 숙련>이 2배로 증가합니다."
  },
  RelicConfig_13915_Desc = {
    Text = "추천 영역 보너스가 50%로 증가하며, 탐사 시작 시 <ProficientInRealmsIconKeywords:영역 숙련>이 2배로 증가합니다."
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:시계추「입몽」>"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "광기 폭발 사용 후, 다음으로 사용하는 카드의 효과가 2회 발동합니다."
  },
  RelicConfig_13916_Desc = {
    Text = "광기 폭발 사용 후, 다음으로 사용하는 카드의 효과가 2회 발동합니다."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:시계추「잠유」>"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "적의 의도가 공격일 경우, 피해를 입힌 후 대상의 임시 <PowerIconKeywords:힘>을 [Arg1] 감소시킵니다. 그렇지 않을 경우, 피해량 25%만큼의 <BleedingIconKeywords:출혈>을 부여합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_13917_Desc = {
    Text = "적의 의도가 공격일 경우, 피해를 입힌 후 대상의 임시 <PowerIconKeywords:힘>을 [Arg1] 감소시킵니다. 그렇지 않을 경우, 피해량 25%만큼의 <BleedingIconKeywords:출혈>을 부여합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:기형 심장>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "두 개의 서로 의지하는 “심장”."
  },
  RelicConfig_13918_BattleDesc = {
    Text = "피해를 입힐 때마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 최대 3번까지 중첩되며, 최대 중첩일 때 효과가 2배로 적용됩니다."
  },
  RelicConfig_13918_Desc = {
    Text = "피해를 입힐 때마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 최대 3번까지 중첩되며, 최대 중첩일 때 효과가 2배로 적용됩니다."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:실타래올 마노>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "일반적인 마노의 무늬일 거예요. 아마도."
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 50 증가합니다. 해당 유물 획득 시, 보유한 유물 중 하나를 선택하여, 랜덤 유물로 교체합니다."
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 50 증가합니다. 해당 유물 획득 시, 보유한 유물 중 하나를 선택하여, 랜덤 유물로 교체합니다."
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:만화경>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "생각하고 보는 모든 것이 환상이다."
  },
  RelicConfig_13920_BattleDesc = {
    Text = "부여하는 허약 효과가 5% 증가합니다. <WeaknessIconKeywords:허약>을 부여할 때, 대상의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다."
  },
  RelicConfig_13920_Desc = {
    Text = "부여하는 허약 효과가 5% 증가합니다. <WeaknessIconKeywords:허약>을 부여할 때, 대상의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:빛바랜 사진>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "모호한 사진은 모호한 기억을 담고 있거나, 어쩌면 — 바로 기억의 결핍이 사진의 색바램을 만든 것일지도 모른다."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "해당 유물 획득 시, 명령 카드 2장을 선택하여 삭제하고, 영구적으로 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13921_Desc = {
    Text = "해당 유물 획득 시, 명령 카드 2장을 선택하여 삭제하고, 영구적으로 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:검은 별의 잔불>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "잔불이 아직 꺼지지 않았다."
  },
  RelicConfig_13922_BattleDesc = {
    Text = "매 턴 광기 폭발을 2회 사용한 후 모든 깨어남체가 8 광기를 획득합니다. 광기 폭발을 3번 발동한 후에는 다시 모든 깨어남체가 8 광기를 획득합니다."
  },
  RelicConfig_13922_Desc = {
    Text = "매 턴 광기 폭발을 2회 사용한 후 모든 깨어남체가 8 광기를 획득합니다. 광기 폭발을 3번 발동한 후에는 다시 모든 깨어남체가 8 광기를 획득합니다."
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:잊혀진 자의 피>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "점점 소멸된다."
  },
  RelicConfig_13923_BattleDesc = {
    Text = "피해를 입힐 때마다 [Arg1]의 방어막을 획득합니다. 턴 시작 시, 남은 방어막 3마다 1의 임시 <PowerIconKeywords:힘>과 촉수 피해를 획득합니다."
  },
  RelicConfig_13923_Desc = {
    Text = "피해를 입힐 때마다 [Arg1]의 방어막을 획득합니다. 턴 시작 시, 남은 방어막 3마다 1의 임시 <PowerIconKeywords:힘>과 촉수 피해를 획득합니다."
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:시계추「은밀」>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "<TransitionIconKeywords:워프> 효과가 발동할 때마다, 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다. 적이 1명이라면 추가로 임시 <PowerIconKeywords:힘>을 [Arg2] 탈취합니다."
  },
  RelicConfig_13924_Desc = {
    Text = "<TransitionIconKeywords:워프> 효과가 발동할 때마다, 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1] 탈취합니다. 적이 1명이라면 추가로 임시 <PowerIconKeywords:힘>을 [Arg2] 탈취합니다."
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:공간 왜곡 장치>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "공간으로 뛰어들기."
  },
  RelicConfig_13925_BattleDesc = {
    Text = "턴 시작 시 카드를 1장 뽑습니다. 직전에 사용한 카드와 행동력 소비가 같은 카드를 연속으로 2번 사용할 때마다 카드를 1장 뽑습니다. 턴마다 3번까지 발동합니다."
  },
  RelicConfig_13925_Desc = {
    Text = "턴 시작 시 카드를 1장 뽑습니다. 직전에 사용한 카드와 행동력 소비가 같은 카드를 연속으로 2번 사용할 때마다 카드를 1장 뽑습니다. 턴마다 3번까지 발동합니다."
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:만상 영지의 신비>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "전지전능."
  },
  RelicConfig_13926_BattleDesc = {
    Text = "전투 시작 시, 덱의 각인 1개마다 <PowerIconKeywords:힘>을 [Arg1] 획득하고, 보유한 유물 1개마다 HP를 [Arg2] 회복합니다."
  },
  RelicConfig_13926_Desc = {
    Text = "전투 시작 시, 덱의 각인 1개마다 <PowerIconKeywords:힘>을 [Arg1] 획득하고, 보유한 유물 1개마다 HP를 [Arg2] 회복합니다."
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆상회 메달☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "“이걸 착용하면 당신은 렌티니언 상회의 일원 중 하나가 됩니다.”"
  },
  RelicConfig_13927_BattleDesc = {
    Text = "해당 유물 획득 시 증상 카드 1장을 덱에서 삭제합니다. 랜덤 각인 1개를 고급 각인으로 업그레이드합니다."
  },
  RelicConfig_13927_Desc = {
    Text = "해당 유물 획득 시 증상 카드 1장을 덱에서 삭제합니다. 랜덤 각인 1개를 고급 각인으로 업그레이드합니다."
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:행운의 토끼 발>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "토끼에게는 그다지 운이 좋지 않았다."
  },
  RelicConfig_13928_BattleDesc = {
    Text = "크리티컬 확률이 15% 증가합니다. 카드를 1장 사용할 때마다, 임시 크리티컬 확률이 5% 증가합니다."
  },
  RelicConfig_13928_Desc = {
    Text = "크리티컬 확률이 15% 증가합니다. 카드를 1장 사용할 때마다, 임시 크리티컬 확률이 5% 증가합니다."
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:멤피스 의식 거울>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "“당신이 거기서 무엇을 보았나요?”"
  },
  RelicConfig_13929_BattleDesc = {
    Text = "HP를 잃을 때마다 [Arg1] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 단일 턴 내 3번째 발동이라면 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  RelicConfig_13929_Desc = {
    Text = "HP를 잃을 때마다 [Arg1] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 단일 턴 내 3번째 발동이라면 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:고인의 회중시계>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "추억과 감상에 젖어 미지로 나아갑니다."
  },
  RelicConfig_13930_BattleDesc = {
    Text = "턴 종료 시, 남은 손패 1장마다 모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다."
  },
  RelicConfig_13930_Desc = {
    Text = "턴 종료 시, 남은 손패 1장마다 모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1] 부여합니다."
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:의심스러운 연고>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "집에서 만든 외상용 연고입니다. 의사의 지시 없이 사용하지 마십시오."
  },
  RelicConfig_13931_BattleDesc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득합니다. <DerivativeCardKeywords_2:「배아」>가 생성될 때마다 임시 <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13931_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득합니다. <DerivativeCardKeywords_2:「배아」>가 생성될 때마다 임시 <PowerIconKeywords:힘>을 [Arg2] 획득합니다."
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:피로 물든 조약돌>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "하나, 둘, 셋, 넷, 다섯."
  },
  RelicConfig_13932_BattleDesc = {
    Text = "「방어」를 3번 사용할 때마다, [Arg1]의 방어막을 획득하고, 사용한 깨어남체가 15 광기를 획득합니다."
  },
  RelicConfig_13932_Desc = {
    Text = "「방어」를 3번 사용할 때마다, [Arg1]의 방어막을 획득하고, 사용한 깨어남체가 15 광기를 획득합니다."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:침묵 장갑>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "그들은 수많은 피, 눈물, 그리고 곰팡이에 물들었던."
  },
  RelicConfig_13933_BattleDesc = {
    Text = "6번 주간 대체 유물는 효과가 없습니다."
  },
  RelicConfig_13933_Desc = {
    Text = "6번 주간 대체 유물는 효과가 없습니다."
  },
  RelicConfig_13933_Name = {
    Text = "일상 도전 주간 대체 유물 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "이것은 효과가 없는 주간 대체 유물 5 입니다"
  },
  RelicConfig_13934_Desc = {
    Text = "이것은 효과가 없는 주간 대체 유물 5 입니다"
  },
  RelicConfig_13934_Name = {
    Text = "일상 도전 주간 대체 유물 5개"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "크리티컬 확률이 10% 증가합니다. 매 턴 처음으로 크리티컬이 발동한 후 크리티컬 확률이 추가로 20% 증가하고, 매 턴 3번째로 크리티컬이 발동한 후 크리티컬 피해가 추가로 50% 증가합니다."
  },
  RelicConfig_13935_Desc = {
    Text = "크리티컬 확률이 10% 증가합니다. 매 턴 처음으로 크리티컬이 발동한 후 크리티컬 확률이 추가로 20% 증가하고, 매 턴 3번째로 크리티컬이 발동한 후 크리티컬 피해가 추가로 50% 증가합니다."
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:축제의 축복>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "그것은 사랑하는 이들에게 축복을 가져다주어야 합니다."
  },
  RelicConfig_13936_BattleDesc = {
    Text = "이것은 3 주간 대체 유물로 효과가 없습니다."
  },
  RelicConfig_13936_Desc = {
    Text = "이것은 3 주간 대체 유물로 효과가 없습니다."
  },
  RelicConfig_13936_Name = {
    Text = "일상 도전 주간 대체 유물 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "이것은 효과가 없는 주간 대체 유물 2입니다"
  },
  RelicConfig_13937_Desc = {
    Text = "이것은 효과가 없는 주간 대체 유물 2입니다"
  },
  RelicConfig_13937_Name = {
    Text = "일상 도전 주간 대체 유물 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "이것은 효과가 없는 주간 대체 유물 1입니다"
  },
  RelicConfig_13938_Desc = {
    Text = "이것은 효과가 없는 주간 대체 유물 1입니다"
  },
  RelicConfig_13938_Name = {
    Text = "일상 도전 주간 대체 유물 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "3번쨰 턴 시작 시, 해당 전투 동안 크리티컬 확률이 15% 증가하고, <DerivativeCardKeywords_39:「과거의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13939_Desc = {
    Text = "3번쨰 턴 시작 시, 해당 전투 동안 크리티컬 확률이 15% 증가하고, <DerivativeCardKeywords_39:「과거의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:과거의 공물>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "진헌되었던 물건."
  },
  RelicConfig_13940_BattleDesc = {
    Text = "방어막이 존재할 경우, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 방어막이 현재 HP보다 높을 경우, 임시 <PowerIconKeywords:힘>을 추가로 [Arg2] 획득합니다."
  },
  RelicConfig_13940_Desc = {
    Text = "방어막이 존재할 경우, 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 방어막이 현재 HP보다 높을 경우, 임시 <PowerIconKeywords:힘>을 추가로 [Arg2] 획득합니다."
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:비둘기 깃털 부채>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "정교하고 비싸지만, 그다지 실타래용적이지 않다."
  },
  RelicConfig_13941_BattleDesc = {
    Text = "「타격」 사용 시 HP를 [Arg1] 회복하고, 자신의 <IntoxicationIconKeywords:중독>을 [Arg1] 감소시킵니다."
  },
  RelicConfig_13941_Desc = {
    Text = "「타격」 사용 시 HP를 [Arg1] 회복하고, 자신의 <IntoxicationIconKeywords:중독>을 [Arg1] 감소시킵니다."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:지혈관>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "“빨리, 빨리 그것을 줘!”"
  },
  RelicConfig_13942_BattleDesc = {
    Text = "촉수 1개가 존재할 때마다, 턴 종료 시 [Arg1]의 방어막을 획득합니다. 촉수가 정해 태세라면, 해당 효과로 획득하는 방어막 양이 50% 증가합니다."
  },
  RelicConfig_13942_Desc = {
    Text = "촉수 1개가 존재할 때마다, 턴 종료 시 [Arg1]의 방어막을 획득합니다. 촉수가 정해 태세라면, 해당 효과로 획득하는 방어막 양이 50% 증가합니다."
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:무명의 의수>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "손에 찔리지 않도록 조심하세요."
  },
  RelicConfig_139929_BattleDesc = {
    Text = "턴 시작 시 사야가 [Arg1] 광기를 획득합니다. 사야의 광기 폭발 시 소모한 광기 100pt당, 랜덤 생성된 「스킬」 1장이 추가로 1회 더 발동합니다."
  },
  RelicConfig_139929_Desc = {
    Text = "턴 시작 시 사야가 [Arg1] 광기를 획득합니다. 사야의 광기 폭발 시 소모한 광기 100pt당, 랜덤 생성된 「스킬」 1장이 추가로 1회 더 발동합니다."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:차원 영상 · 사야>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:배수진>：턴 시작 시 최대 HP력의 1%를 잃을 때마다 임시 최종 피해가 5% 증가하며, 이전 턴에 사망 저항이 발동된 경우 해당 효과가 2배가 됩니다. \n<RedQuality:지고>：모든 적의 최대 HP력이 300% 증가합니다."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:배수진>：턴 시작 시 최대 HP력의 1%를 잃을 때마다 임시 최종 피해가 5% 증가하며, 이전 턴에 사망 저항이 발동된 경우 해당 효과가 2배가 됩니다. \n<RedQuality:지고>：모든 적의 최대 HP력이 300% 증가합니다."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:차원 영추-사투>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:증식>：매 라운드 각 깨어남체가 처음으로 「스킬」을 사용할 때, 해당 카드의 임시 원본 복제 2장을 생성한다. 연산력 소모가 0 또는 1인 명령 카드를 사용할 때 모든 깨어남체가 광기 5를 획득한다.\n<RedQuality:요새>：원본 연산력 소모가 3 이상인 카드를 사용할 때, 모든 적이 최대 HP력의 20% 보호막을 획득한다."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:증식>：매 라운드 각 깨어남체가 처음으로 「스킬」을 사용할 때, 해당 카드의 임시 원본 복제 2장을 생성한다. 연산력 소모가 0 또는 1인 명령 카드를 사용할 때 모든 깨어남체가 광기 5를 획득한다.\n<RedQuality:요새>：원본 연산력 소모가 3 이상인 카드를 사용할 때, 모든 적이 최대 HP력의 20% 보호막을 획득한다."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:차원 진자-경계>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:회생>：획득하는 보호막 및 회복 효과가 25% 증가합니다. HP력을 회복하거나 보호막을 획득할 때, 최대 HP력의 1%에 해당하는 회복 또는 보호막 효과를 발생시킬 때마다 10%의 임시 피해 강화를 획득합니다.\n<RedQuality:속삭임>：매 턴 최대 HP력의 10%에 해당하는 힘 감소 효과를 받습니다."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:회생>：획득하는 보호막 및 회복 효과가 25% 증가합니다. HP력을 회복하거나 보호막을 획득할 때, 최대 HP력의 1%에 해당하는 회복 또는 보호막 효과를 발생시킬 때마다 10%의 임시 피해 강화를 획득합니다.\n<RedQuality:속삭임>：매 턴 최대 HP력의 10%에 해당하는 힘 감소 효과를 받습니다."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:차원 영추-위협>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:여명>：모든 깨어남체의 기본 광기가 30 감소합니다. 매 턴 처음 발동하는 광기 폭발의 최종 피해가 200% 증가하고, 보호막 및 HP력 회복이 100% 증가합니다. 광기 폭발을 5회 발동할 때마다 깨어남체 1명을 선택하여 깨어남시키고, 광기 폭발 증폭 효과를 초기화합니다.\n<RedQuality:고갈>：기본 은열쇠 에너지가 200% 증가합니다."
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:여명>：모든 깨어남체의 기본 광기가 30 감소합니다. 매 턴 처음 발동하는 광기 폭발의 최종 피해가 200% 증가하고, 보호막 및 HP력 회복이 100% 증가합니다. 광기 폭발을 5회 발동할 때마다 깨어남체 1명을 선택하여 깨어남시키고, 광기 폭발 증폭 효과를 초기화합니다.\n<RedQuality:고갈>：기본 은열쇠 에너지가 200% 증가합니다."
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:차원 영추-궤주>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:깨어남>：매 라운드 처음으로 광기 폭발을 발동한 후, 해당 깨어남체의 광기 폭발 쿨타임을 초기화하고 광기 50을 획득하며, 연산력 소모가 0인 모든 「스킬」의 임시 복제를 생성한다.\n<RedQuality:봉인>：매 라운드 처음으로 광기 폭발을 발동한 후, 다른 깨어남체를 봉인한다."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:깨어남>：매 라운드 처음으로 광기 폭발을 발동한 후, 해당 깨어남체의 광기 폭발 쿨타임을 초기화하고 광기 50을 획득하며, 연산력 소모가 0인 모든 「스킬」의 임시 복제를 생성한다.\n<RedQuality:봉인>：매 라운드 처음으로 광기 폭발을 발동한 후, 다른 깨어남체를 봉인한다."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:차원 진자-결투>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:반향>：턴 시작 후 드로우 더미에서 연산력이 가장 높은 지령 카드 3장을 뽑으며, 매 턴 처음 사용하는 지령 카드가 2회 발동합니다.\n<RedQuality:현기증>：지령 카드를 사용한 후 해당 카드 이상의 연산력 소모를 가진 다른 모든 지령 카드를 버립니다."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:반향>：턴 시작 후 드로우 더미에서 연산력이 가장 높은 지령 카드 3장을 뽑으며, 매 턴 처음 사용하는 지령 카드가 2회 발동합니다.\n<RedQuality:현기증>：지령 카드를 사용한 후 해당 카드 이상의 연산력 소모를 가진 다른 모든 지령 카드를 버립니다."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:차원 영추-혼란>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:위력>：모든 깨어남체가 가하는 <PowerIconKeywords:힘> 50% 증가, 피해를 1회 가할 때마다 임시 <PowerIconKeywords:힘> [Arg2]을 획득한다.\n<RedQuality:무형>：전투 시작 시, 모든 적이 <ParcloseIconKeywords:장벽> 50층을 획득한다."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:위력>：모든 깨어남체가 가하는 <PowerIconKeywords:힘> 50% 증가, 피해를 1회 가할 때마다 임시 <PowerIconKeywords:힘> [Arg2]을 획득한다.\n<RedQuality:무형>：전투 시작 시, 모든 적이 <ParcloseIconKeywords:장벽> 50층을 획득한다."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:차원 진자-잠복>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "최대 손패 매수 +1. 전투 시작 시 「<DerivativeCardKeywords_148:驭魇>」 1장을 생성하여 손패에 넣습니다. 깨어남체의 「기초 타격」을 사용할 때, 「<DerivativeCardKeywords_148:驭魇>」의 행동력 소모가 -1되고 모든 적에게 [Arg1] 침식을 가합니다. 깨어남체의 「기본 방어」를 사용할 때, [Arg2] 힘을 획득하고 다음에 「<DerivativeCardKeywords_148:驭魇>」를 사용할 때 최종 피해 효과와 힘이 [Arg3]% 증가합니다."
  },
  RelicConfig_140840_Desc = {
    Text = "최대 손패 매수 +1. 전투 시작 시 「<DerivativeCardKeywords_148:驭魇>」 1장을 생성하여 손패에 넣습니다. 깨어남체의 「기초 타격」을 사용할 때, 「<DerivativeCardKeywords_148:驭魇>」의 행동력 소모가 -1되고 모든 적에게 [Arg1] 침식을 가합니다. 깨어남체의 「기본 방어」를 사용할 때, [Arg2] 힘을 획득하고 다음에 「<DerivativeCardKeywords_148:驭魇>」를 사용할 때 최종 피해 효과와 힘이 [Arg3]% 증가합니다."
  },
  RelicConfig_140840_Name = {
    Text = "헛된 몸부림"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "허망한 자는 변화를 두려워하고, 통제를 벗어나는 것을 두려워한다. 가장 깊은 곳에서 그는 상실타래에 대한 히스테리적인 공포를 품고 있다.\n그는 호각을 거듭 불며 그 소리로 모든 것을 지배하려 하지만, 아무것도 붙잡을 수 없었다. 그 어떤 것도 남지 않았다. 결코 그랬던 적도 없다."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "턴 시작 시 폰토스가 광기를 [Arg1] 획득한다. 획득 후 다음 전투 시작 시, 영구 「건트」 3장을 생성한다. 「건트」 사용 시 폰토스가 광기 3pt를 획득한다."
  },
  RelicConfig_143665_Desc = {
    Text = "턴 시작 시 폰토스가 광기를 [Arg1] 획득한다. 획득 후 다음 전투 시작 시, 영구 「건트」 3장을 생성한다. 「건트」 사용 시 폰토스가 광기 3pt를 획득한다."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:차원 영상 · 폰토스>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "턴 시작 시 침식·로탄이 광기를 [Arg1]pt 획득한다. 「경계를 베는 검」은 다음 턴 시작 시 「저승의 인도」의 추격을 발동한다: 전체 적에게 침식·로탄 공격력의 400% 피해를 입히며, 해당 피해는 이번 「경계를 베는 검」이 「대검·고래 낙하」를 통해 획득한 피해 보너스를 적용받고, 「타격」으로 간주한다."
  },
  RelicConfig_145438_Desc = {
    Text = "턴 시작 시 침식·로탄이 광기를 [Arg1]pt 획득한다. 「경계를 베는 검」은 다음 턴 시작 시 「저승의 인도」의 추격을 발동한다: 전체 적에게 침식·로탄 공격력의 400% 피해를 입히며, 해당 피해는 이번 「경계를 베는 검」이 「대검·고래 낙하」를 통해 획득한 피해 보너스를 적용받고, 「타격」으로 간주한다."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:차원 영상 · 침식·로탄>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "손패 상한이 1 증가한다. 전투 시작 시 또는 「<DerivativeCardKeywords_157:검의 뼈>」를 사용한 후 「<DerivativeCardKeywords_155:광기의 뼈>」 1장을 손패에 넣고, 「<DerivativeCardKeywords_156:상처의 뼈>」 1장을 드로우 덱에 섞는다. 1턴 동안 「<DerivativeCardKeywords_155:광기의 뼈>」와 「<DerivativeCardKeywords_156:상처의 뼈>」를 동시에 사용할 경우, 해당 카드 2장을 「<DerivativeCardKeywords_157:검의 뼈>」로 합성하여 손패에 넣는다."
  },
  RelicConfig_146128_Desc = {
    Text = "손패 상한이 1 증가한다. 전투 시작 시 또는 「<DerivativeCardKeywords_157:검의 뼈>」를 사용한 후 「<DerivativeCardKeywords_155:광기의 뼈>」 1장을 손패에 넣고, 「<DerivativeCardKeywords_156:상처의 뼈>」 1장을 드로우 덱에 섞는다. 1턴 동안 「<DerivativeCardKeywords_155:광기의 뼈>」와 「<DerivativeCardKeywords_156:상처의 뼈>」를 동시에 사용할 경우, 해당 카드 2장을 「<DerivativeCardKeywords_157:검의 뼈>」로 합성하여 손패에 넣는다."
  },
  RelicConfig_146128_Name = {
    Text = "고래 잔해의 갑주"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "레비아탄의 잔해는 선택된 자를 보호하여, 가는 곳마다 무적으로 하게 하시며, 죽지도 않고 멸하지도 않게 하신다."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "턴 시작 시 카시아는 [Arg1] 광기를 획득합니다. 매 1장의 카드를 뽑을 때마다 카시아는 [Arg2] 광기를 획득합니다. 카시아가 광기 폭발을 방출할 때 모든 적은 [Arg3] 힘을 잃습니다."
  },
  RelicConfig_147547_Desc = {
    Text = "턴 시작 시 카시아는 [Arg1] 광기를 획득합니다. 매 1장의 카드를 뽑을 때마다 카시아는 [Arg2] 광기를 획득합니다. 카시아가 광기 폭발을 방출할 때 모든 적은 [Arg3] 힘을 잃습니다."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:차원 영상 · 카시아>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "행동력 상한과 매 턴 드로우 수 +1. 턴 시작 시 3개의 「<Caroboo_Tips:로열 마리 초콜릿>」을 <FaxianKeywords:발견>하여 하나를 선택합니다. 그 중 1개만 진짜입니다: 진짜를 선택하면 긍정적 효과를 획득하고 자신의 무작위 부정적 상태 1종을 해제합니다; 가짜를 선택하면 부정적 효과를 받고 다음 <FaxianKeywords:발견> 시 진짜 선택지 +1, 효과 2배가 되며, 진짜를 선택한 후 초기화됩니다."
  },
  RelicConfig_147665_Desc = {
    Text = "행동력 상한과 매 턴 드로우 수 +1. 턴 시작 시 3개의 「<Caroboo_Tips:로열 마리 초콜릿>」을 <FaxianKeywords:발견>하여 하나를 선택합니다. 그 중 1개만 진짜입니다: 진짜를 선택하면 긍정적 효과를 획득하고 자신의 무작위 부정적 상태 1종을 해제합니다; 가짜를 선택하면 부정적 효과를 받고 다음 <FaxianKeywords:발견> 시 진짜 선택지 +1, 효과 2배가 되며, 진짜를 선택한 후 초기화됩니다."
  },
  RelicConfig_147665_Name = {
    Text = "로열 마리 초콜릿"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "달콤하고 귀중하다고……? 아니면?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "턴 시작 시 부서의 맹세·오지에가 [Arg1] 포인트의 광기를 획득하고, 「암류」는 더 이상 드로우 수를 감소시키지 않습니다."
  },
  RelicConfig_148525_Desc = {
    Text = "턴 시작 시 부서의 맹세·오지에가 [Arg1] 포인트의 광기를 획득하고, 「암류」는 더 이상 드로우 수를 감소시키지 않습니다."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:차원 영상·부서의 맹세·오지에>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "현재 환경이 「빙역」으로 간주됩니다.\n종북 대륙: 드로우 단계 후 손에 있는 행동력이 가장 높은 얼지 않은 명령 카드 2장에 <SlowIconKeywords:둔화> 1스택, <RetainIconKeywords:보존>을 부여합니다. 임의의 명령 카드가 <SlowIconKeywords:둔화>를 3스택 이상 보유할 때, 해당 카드의 <SlowIconKeywords:둔화>와 이번 전투에서 부여된 <RetainIconKeywords:보존>을 제거하고 「빙결」 상태로 만들며, <TempPowerKeywords2:강화> 25스택을 부여합니다."
  },
  RelicConfig_149665_Desc = {
    Text = "현재 환경이 「빙역」으로 간주됩니다.\n종북 대륙: 드로우 단계 후 손에 있는 행동력이 가장 높은 얼지 않은 명령 카드 2장에 <SlowIconKeywords:둔화> 1스택, <RetainIconKeywords:보존>을 부여합니다. 임의의 명령 카드가 <SlowIconKeywords:둔화>를 3스택 이상 보유할 때, 해당 카드의 <SlowIconKeywords:둔화>와 이번 전투에서 부여된 <RetainIconKeywords:보존>을 제거하고 「빙결」 상태로 만들며, <TempPowerKeywords2:강화> 25스택을 부여합니다."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:빙역 결정핵>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "그것은 추위를 가져오는 것이 아니다.\n그것은 다만 대지에게 상기시킬 뿐이다, 겨울은 결코 떠난 적이 없다고."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "피해를 입힐 때마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 최대 5번까지 중첩 가능하고, 최대 중첩에 도달했을 경우 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_20164_Desc = {
    Text = "피해를 입힐 때마다 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 최대 5번까지 중첩 가능하고, 최대 중첩에 도달했을 경우 <PowerIconKeywords:힘>을 [Arg1] 획득합니다."
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:시계추「미면」>"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "모든 깨어남체를 깨어남시킵니다. <ExaltIconKeywords:영지 깨어남> 후, 해당 깨어남체의 랜덤 명령 카드 2장을 손패에 추가하고, 「소모」와 「공허」를 부여합니다."
  },
  RelicConfig_20165_Desc = {
    Text = "모든 깨어남체를 깨어남시킵니다. <ExaltIconKeywords:영지 깨어남> 후, 해당 깨어남체의 랜덤 명령 카드 2장을 손패에 추가하고, 「소모」와 「공허」를 부여합니다."
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:그분의 신탁+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "그분께서 말씀하셨다, '두려워하지 말라' 라고."
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다. 매 턴 처음으로 사용한 카드를 버린 카드 더미에서 손패로 되돌립니다. 초차원 턴 시작 시, 해당 턴의 손패 상한이 5 증가하고, 모든 손패를 <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>를 추가하여 복제합니다."
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련> 100 상승. 각 턴에 사용한 첫 번째 카드를 버린 카드 더미에서 손으로 되돌립니다. 초차원 턴 시작 시, 해당 턴의 손패 상한이 5 증가하고 손패를 복제하며, 복제된 카드에 <NothingnessIconKeywords:공허>와 <DepleteIconKeywords:소모>를 추가합니다."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:시계추 「꿈도둑」>"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "턴 종료 시, 행동력이 1 이상 남아 있을 경우 다음 턴에 추가로 카드를 2장 뽑고, 손패의 카드가 1장 이상 남아 있을 경우 다음 턴에 추가로 행동력을 2 회복합니다."
  },
  RelicConfig_20167_Desc = {
    Text = "턴 종료 시, 행동력이 1 이상 남아 있을 경우 다음 턴에 추가로 카드를 2장 뽑고, 손패의 카드가 1장 이상 남아 있을 경우 다음 턴에 추가로 행동력을 2 회복합니다."
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:해와 달의 암호+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "맞춰봐. 흑일까, 백일까?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "최대 촉수 수량이 2 증가합니다. 광기 폭발을 사용한 후, 촉수 피해가 [Arg1] 증가합니다. 1턴 동안 광기 폭발을 3회 사용했을 경우, 모든 촉수가 즉시 1번씩 공격합니다."
  },
  RelicConfig_20168_Desc = {
    Text = "최대 촉수 수량이 2 증가합니다. 광기 폭발을 사용한 후, 촉수 피해가 [Arg1] 증가합니다. 1턴 동안 광기 폭발을 3회 사용했을 경우, 모든 촉수가 즉시 1번씩 공격합니다."
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:시계추「이슬잠」>"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다. 카드를 1장 사용할 때마다 <EmbryoFusionIconKeywords:배아 융합>이 10% 증가합니다. HP가 25% 미만일 때에는 20% 증가합니다. 턴마다 10번까지 발동합니다."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:영역 숙련>이 100 증가합니다. 카드를 1장 사용할 때마다 <EmbryoFusionIconKeywords:배아 융합>이 10% 증가합니다. HP가 25% 미만일 때에는 20% 증가합니다. 턴마다 10번까지 발동합니다."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:시계추「용솟음」>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "전투 시작 시, 모든 깨어남체가 50 광기를 획득하고, <DerivativeCardKeywords_1:「그림자의 메아리」> 2장을 손패에 추가합니다."
  },
  RelicConfig_20170_Desc = {
    Text = "전투 시작 시, 모든 깨어남체가 50 광기를 획득하고, <DerivativeCardKeywords_1:「그림자의 메아리」> 2장을 손패에 추가합니다."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:통신 장비+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "그것이 맑은 종소리를 내는 순간을 기대하거나 두려워합니다."
  },
  RelicConfig_20171_BattleDesc = {
    Text = "랜덤으로 백은 유물, 황금 유물, 저주받은 유물 중 하나를 획득합니다."
  },
  RelicConfig_20171_Desc = {
    Text = "랜덤으로 백은 유물, 황금 유물, 저주받은 유물 중 하나를 획득합니다."
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:되돌아보다 감상+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "기묘한 시대에서 꽃이야말로 인간의 첫 번째 관상자였다. \n움직이지 마세요, 그들은 조용한 전시물을 더 선호합니다."
  },
  RelicConfig_20172_BattleDesc = {
    Text = "매 턴에 사용된 명령 카드가 3장이 되면 1장의 <DerivativeCardKeywords_4:“영감”>을 얻고, 6장이 되면 다시 1장의 <DerivativeCardKeywords_4:“영감”>을 얻습니다. 10장이 되면 다음 턴 시작 시 덱에서 임의로 2장의 카드를 손패에 넣을 수 있습니다."
  },
  RelicConfig_20172_Desc = {
    Text = "매 턴에 사용된 명령 카드가 3장이 되면 1장의 <DerivativeCardKeywords_4:“영감”>을 얻고, 6장이 되면 다시 1장의 <DerivativeCardKeywords_4:“영감”>을 얻습니다. 10장이 된 후, 다음 턴 시작 시 덱에서 임의로 2장의 카드를 손패에 넣을 수 있습니다."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:시계추 「메아리」>"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "부정적인 상태의 적에게 입히는 피해가 50% 증가하고, 적을 처치할 시 처치자가 100 광기를 획득합니다."
  },
  RelicConfig_20173_Desc = {
    Text = "부정적인 상태의 적에게 입히는 피해가 50% 증가하고, 적을 처치할 시 처치자가 100 광기를 획득합니다."
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:제사장의 지팡이+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "허락되지 않은 경건함."
  },
  RelicConfig_20174_BattleDesc = {
    Text = "획득 후 팀 피해 증폭이 원래 수치의 150%가 됩니다. 턴 시작 후 무작위 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히며, 이번 전투에서 은열쇠를 1번 사용할 때마다 피해 +[Arg2] 이 피해 증가는 팀 피해 증폭 보너스의 적용을 받습니다."
  },
  RelicConfig_20174_Desc = {
    Text = "획득 후 팀 피해 증폭이 원래 수치의 150%가 됩니다. 턴 시작 후 무작위 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히며, 이번 전투에서 은열쇠를 1번 사용할 때마다 피해 +[Arg2] 이 피해 증가는 팀 피해 증폭 보너스의 적용을 받습니다."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:시계추 「유실타래」>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "<WeaknessIconKeywords:허약> 효과가 8% 증가하고, <VulnerabilityIconKeywords:취약> 효과가 25% 증가한다. <WeaknessIconKeywords:허약> 또는 <VulnerabilityIconKeywords:취약>을 부여할 때, 임시로 대상의 <PowerIconKeywords:힘>을 [Arg1]pt 빼앗는다."
  },
  RelicConfig_20175_Desc = {
    Text = "<WeaknessIconKeywords:허약> 효과가 8% 증가하고, <VulnerabilityIconKeywords:취약> 효과가 25% 증가한다. <WeaknessIconKeywords:허약> 또는 <VulnerabilityIconKeywords:취약>을 부여할 때, 임시로 대상의 <PowerIconKeywords:힘>을 [Arg1]pt 빼앗는다."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:빛바랜 사진+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "모호한 사진은 모호한 기억을 담고 있거나, 어쩌면 — 바로 기억의 결핍이 사진의 색바램을 만든 것일지도 모른다."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "턴 시작 시, 적 하나당 행동력을 2 획득합니다. 적에게 능동 피해를 가하여 처치하였을 경우, 다른 적에게 초과한 피해량의 2배만큼 <BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_20176_Desc = {
    Text = "턴 시작 시, 적 하나당 행동력을 2 획득합니다. 적에게 능동 피해를 가하여 처치하였을 경우, 다른 적에게 초과한 피해량의 2배만큼 <BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:군중의 노래+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "귀를 괴롭히기 위해 태어났습니다."
  },
  RelicConfig_20177_BattleDesc = {
    Text = "해당 유물 획득 시, 죽음 저항이 2배로 증가합니다. 피해를 입힌 후 목표에게 피해량 50%만큼의 <BleedingIconKeywords:출혈>을 부여합니다. 죽음 저항이 1회 발동할 때마다, 모든 적의 출혈을 즉시 1회 발동시킵니다."
  },
  RelicConfig_20177_Desc = {
    Text = "해당 유물 획득 시, 죽음 저항이 2배로 증가합니다. 피해를 입힌 후 목표에게 피해량 50%만큼의 <BleedingIconKeywords:출혈>을 부여합니다. 죽음 저항이 1회 발동할 때마다, 모든 적의 출혈을 즉시 1회 발동시킵니다."
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:시계추 「부활」>"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "능동 피해를 입힐 때마다 3pt의 광기를 얻고, 목표에 [Arg1] 층의 <IntoxicationIconKeywords:중독>을 부여합니다. 만약 이번 전투에서 누적 25 횟수가 되면 즉시 모든 적에게 <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  RelicConfig_20178_Desc = {
    Text = "능동 피해를 입힐 때마다 3pt의 광기를 얻고, 목표에 [Arg1] 층의 <IntoxicationIconKeywords:중독>을 부여합니다. 만약 이번 전투에서 누적 25 횟수가 되면 즉시 모든 적에게<IntoxicationIconKeywords:중독>를 발동합니다."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:먼지 낀 재봉틀+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "자비로운 어머니가 심장의 상처를 봉합합니다."
  },
  RelicConfig_21906_BattleDesc = {
    Text = "「타격」을 사용할 경우 행동력을 3 획득하고, 손패의 랜덤 카드 1장을 버립니다. 「방어」 카드를 사용할 경우 카드를 3장 뽑고, 행동력을 1 잃습니다."
  },
  RelicConfig_21906_Desc = {
    Text = "「타격」을 사용할 경우 행동력을 3 획득하고, 손패의 랜덤 카드 1장을 버립니다. 「방어」 카드를 사용할 경우 카드를 3장 뽑고, 행동력을 1 잃습니다."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:행복한 레코드+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "유명한 바이올리니스트의 마지막 공연을 녹음한 음반입니다. \n그 이후로, 그것은 불꽃을 일으킵니다."
  },
  RelicConfig_23688_BattleDesc = {
    Text = "흡수 효과가 발동할 때마다 30점의 <EmbryoFusionIconKeywords:배아 융합>과 [Arg1] 점의 <PowerIconKeywords:힘>을 얻습니다. 만약 1턴 중 2번째로 발동할 경우 1점의 행동력을 얻고 1장의 카드를 뽑습니다. 1턴 중 3번째로 발동할 경우 2점의 행동력을 얻고 2장의 카드를 뽑습니다."
  },
  RelicConfig_23688_Desc = {
    Text = "매번 포식이 발동할 때마다 30점의 <EmbryoFusionIconKeywords:배아 융합>과 [Arg1]점의 <PowerIconKeywords:힘>을 얻습니다. 만약 1턴 중 두 번째 발동 시 1점의 행동력을 얻고 1장의 카드를 뽑습니다. 만약 1턴 중 세 번째 발동 시 2점의 행동력을 얻고 2장의 카드를 뽑습니다."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:시계추「역류」>"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "줍기 후 모든 깨어남체가 30포인트의 광기를 획득합니다. 매 1회 광기 폭발 시 1포인트 카운트 증가. 키오링 해제 후, [Arg1]포인트의 임시 경비, [Arg2]포인트의 임시 <PowerIconKeywords:힘>을 획득하고 모든 깨어남체가 6포인트의 광기를 획득하며, 모든 카운트를 소모해 각 카운트당 추가로 1회 효과가 발동됩니다."
  },
  RelicConfig_23689_Desc = {
    Text = "줍기 후 모든 깨어남체가 30포인트의 광기를 획득합니다. 매 1회 광기 폭발 시 1포인트 카운트 증가. 키오링 해제 후, [Arg1]포인트의 임시 경비, [Arg2]포인트의 임시 <PowerIconKeywords:힘>을 획득하고 모든 깨어남체가 6포인트의 광기를 획득하며, 모든 카운트를 소모해 각 카운트당 추가로 1회 효과가 발동됩니다."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:시계추「축력」>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "추가로 얻는 1점의 행동력이나 추가로 뽑는 1장의 카드마다 모든 적에게 [Arg1] 점의 <PowerIconKeywords:힘>을 훔치고, 4%의 임시 크리티컬 확률을 얻으며, 엘리트 또는 리더 배틀 효과가 두 배로 증가합니다. 초차원 턴 시작 후, [Arg2] 점의 <PowerIconKeywords:힘>을 얻고, 크리티컬 피해가 +15% 증가합니다."
  },
  RelicConfig_23690_Desc = {
    Text = "추가로 얻는 1점의 행동력이나 추가로 뽑는 1장의 카드마다 모든 적에게 [Arg1] 점의 <PowerIconKeywords:힘>을 훔치고, 4%의 임시 크리티컬 확률을 얻습니다. 엘리트 또는 리더 배틀 효과는 두 배가 됩니다. 초차원 턴 시작 후 [Arg2] 점의 <PowerIconKeywords:힘>을 얻으며, 크리티컬 피해가 +15% 증가합니다."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:시계추「간격」>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "피해를 5번 입힐 때마다 HP를 [Arg1] 회복합니다. HP를 잃을 때마다 촉수 피해가 [Arg2] 증가하고, 한 번에 [Arg3] 이상의 HP를 잃었을 경우 모든 촉수가 1번씩 공격합니다."
  },
  RelicConfig_23691_Desc = {
    Text = "피해를 5번 입힐 때마다 HP를 [Arg1] 회복합니다. HP를 잃을 때마다 촉수 피해가 [Arg2] 증가하고, 한 번에 최대 HP의 10% 이상을 잃었을 경우 모든 촉수가 1번씩 공격합니다."
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:시계추「조수」>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "피해를 입힐 때마다 임시 <PowerIconKeywords:힘>을 [Arg1]pt 획득하고 임시 촉수 피해가 [Arg2]pt 증가한다. 턴마다 최대 12회 발동한다. 만약 1턴 내에 4회 피해를 입혔다면 모든 적에게 취약을 1스택 부여하고 실타래드를 [Arg3]pt 획득한다. 만약 8회 피해를 입혔다면 모든 적에게 허약을 1스택 부여하고 HP를 [Arg3]pt 회복한다."
  },
  RelicConfig_35135_Desc = {
    Text = "피해를 입힐 때마다 임시 <PowerIconKeywords:힘>을 [Arg1]pt 획득하고 임시 촉수 피해가 [Arg2]pt 증가한다. 턴마다 최대 12회 발동한다. 만약 1턴 내에 4회 피해를 입혔다면 모든 적에게 취약을 1스택 부여하고 실타래드를 [Arg3]pt 획득한다. 만약 8회 피해를 입혔다면 모든 적에게 허약을 1스택 부여하고 HP를 [Arg3]pt 회복한다."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:시계추「도취」>"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "“타격”의 피해와 “방어”로 획득한 방어막이 30% 증가합니다. 1 턴 동안 4장 이상의 “타격”과 “방어”를 사용하면, 다음 턴 시작 시 카드 2장을 뽑고 1점의 행동력을 얻습니다."
  },
  RelicConfig_35136_Desc = {
    Text = "“타격”의 피해와 “방어”로 획득한 방어막이 30% 증가합니다. 1 턴 동안 4장 이상의 “타격”과 “방어”를 사용하면, 다음 턴 시작 시 카드 2장을 뽑고 1점의 행동력을 얻습니다."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:시계추「집요」>"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "카드를 1장 사용할 때마다 [Arg1]만큼의 일시적인<PowerIconKeywords:힘>을 획득하고 [Arg2]만큼의 HP를 회복하며, 주도 공격 후 [Arg2]만큼의 힘을 제거합니다. 깨어남체가 적 하나를 처치하면 30 광기를 얻습니다."
  },
  RelicConfig_35137_Desc = {
    Text = "카드를 1장 사용할 때마다 [Arg1]만큼의 일시적인<PowerIconKeywords:힘>을 획득하고 [Arg2]만큼의 HP를 회복하며, 주도 공격 후 [Arg2]만큼의 힘을 제거합니다. 깨어남체가 적 하나를 처치하면 30 광기를 얻습니다."
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:시계추「축적」>"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "광기 폭발 후, 랜덤 적에게 [Arg1] 중독을 부여하고, 1장의 명령 카드를 사용할 때마다 [Arg2] 임시 반격을 획득합니다. 매 4턴 종료 시, 모든 적에게 중독 레벨과 자신의 반격 레벨의 합계에 해당하는 피해를 입힙니다."
  },
  RelicConfig_35138_Desc = {
    Text = "광기 폭발 후, 랜덤 적에게 [Arg1] 중독을 부여하고, 1장의 명령 카드를 사용할 때마다 [Arg2] 임시 반격을 획득합니다. 매 4턴 종료 시, 모든 적에게 중독 레벨과 자신의 반격 레벨의 합계에 해당하는 피해를 입힙니다."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:시계추「만연」>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "획득 후 파티의 피해 강화가 30% 증가합니다. 4번째 피해는 반드시 크리티컬로 발생하며, 크리티컬 피해가 50% 증가합니다. 만약 해당 공격으로 킬이 발생하면 5개의 검은 인장을 획득합니다."
  },
  RelicConfig_35139_Desc = {
    Text = "획득 후 파티의 피해 강화가 30% 증가합니다. 4번째 피해는 반드시 크리티컬로 발생하며, 크리티컬 피해가 50% 증가합니다. 만약 해당 공격으로 킬이 발생하면 5개의 검은 인장을 획득합니다."
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:시계추「종결」>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "광기 폭발 후 1장의 카드를 뽑습니다. 카드 1장을 버릴 때마다 모든 깨어남체가 3점의 광기를 획득하며, 턴당 최대 15점입니다."
  },
  RelicConfig_36823_Desc = {
    Text = "광기 폭발 후 1장의 카드를 뽑습니다. 카드 1장을 버릴 때마다 모든 깨어남체가 3점의 광기를 획득하며, 턴당 최대 15점입니다."
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:시계추「왕래」>"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "각각의 행동력 소모 시, 카드 1장을 뽑습니다. 각 턴에 최대 5번까지 적용됩니다. 덱이 초기화될 때마다 2점의 행동력을 획득합니다."
  },
  RelicConfig_36824_Desc = {
    Text = "각각의 행동력 소모 시, 카드 1장을 뽑습니다. 각 턴에 최대 5번까지 적용됩니다. 덱이 초기화될 때마다 2점의 행동력을 획득합니다."
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:시계추「불면」>"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "매 4번의 피해를 줄 때마다 <DerivativeCardKeywords_4:“영감”> 1장을 드로우 덱에 넣습니다. 매 턴 최대 3번까지 발동합니다. 광기 폭발을 방출한 후, 덱에서 모든 <DerivativeCardKeywords_4:“영감”>을 사용하고 소모합니다."
  },
  RelicConfig_39302_Desc = {
    Text = "매 4번의 피해를 줄 때마다 <DerivativeCardKeywords_4:“영감”> 1장을 드로우 덱에 넣습니다. 매 턴 최대 3번까지 발동합니다. 광기 폭발을 방출한 후, 덱에서 모든 <DerivativeCardKeywords_4:“영감”>을 사용하고 소모합니다."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:시계추「미몽」>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "현재 행동력이 홀수일 때, 추가로 [Arg2] 점의 임시 경계가 있는 것으로 간주합니다. 현재 행동력이 짝수일 때, 추가로 [Arg1] 점의 임시 <PowerIconKeywords:힘>과 [Arg3] 점의 임시 촉수 피해가 있는 것으로 간주합니다. 1개의 황금 유물을 소유할 때마다 해당 조물의 효과가 50% 증가하며, 1개의 저주받은 유물을 소유할 때마다 80% 증가합니다."
  },
  RelicConfig_39303_Desc = {
    Text = "현재 행동력이 홀수일 때, 추가로 [Arg2] 점의 임시 <AlertIconKeywords:경계>를 보유한 것으로 간주합니다. 현재 행동력이 짝수일 때, 추가로 [Arg1] 점의 임시 <PowerIconKeywords:힘>과 [Arg3] 점의 임시 촉수 피해를 보유한 것으로 간주합니다. 황금 유물을 1개 보유할 때마다 해당 조물의 효과가 50% 증가하며, 저주받은 유물을 1개 보유할 때마다 80% 증가합니다."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:시계추「경몽」>"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "매 턴 시작 시 모든 깨어남체가 20의 광기를 획득합니다. 적용 시 최대 HP가 50% 감소합니다."
  },
  RelicConfig_44192_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 20의 광기를 획득합니다. 적용 시 최대 HP가 50% 감소합니다."
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:죄악·악몽의 표상>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "방종으로 인한 깊은 잠은 욕망을 품고 있으며, 당신이 모르는 사이에 모든 것을 흡수합니다."
  },
  RelicConfig_44300_BattleDesc = {
    Text = "매 턴 시작 시 모든 깨어남체가 25점의 광기를 획득합니다. 줍기 시 최대 HP가 3배가 됩니다."
  },
  RelicConfig_44300_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 25점의 광기를 획득합니다. 줍기 시 최대 HP가 3배가 됩니다."
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:축복·악몽의 표상>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "두려워하지 마세요, 망설이지 마세요. 이는 단순히 찰나의 꿈일 뿐입니다. 아버지 신의 빛은 여전히 당신 위에 비춰지고 있습니다."
  },
  RelicConfig_44592_BattleDesc = {
    Text = "전투가 끝나면 100개의 검은 인장와 2장의 증상 카드를 획득합니다."
  },
  RelicConfig_44592_Desc = {
    Text = "전투가 끝나면 100개의 검은 인장와 2장의 증상 카드를 획득합니다."
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:죄악·에메랄드 탁본>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_44593_BattleDesc = {
    Text = "픽업 시 자신을 제외한 1개의 임의의 죄책감 유물로 변형되며, 75 검은 인장을 획득합니다."
  },
  RelicConfig_44593_Desc = {
    Text = "픽업 시 자신을 제외한 1개의 임의의 죄책감 유물로 변형되며, 75 검은 인장을 획득합니다."
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:죄악·저주받은 비석>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "들어, 누군가 안에서 호출하고 있어."
  },
  RelicConfig_44594_BattleDesc = {
    Text = "매 2턴마다 모든 적이 받는 피해가 2배로 증가하지만, 해당 턴 중 광기 폭발을 1회 사용할 때마다 모든 깨어남체를 1턴간 봉인하며, 자신에게 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  RelicConfig_44594_Desc = {
    Text = "매 2턴마다 모든 적이 받는 피해가 2배로 증가하지만, 해당 턴 중 광기 폭발을 1회 사용할 때마다 모든 깨어남체를 1턴간 봉인하며, 자신에게 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:여정의 유골>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "신성한 일부야. \n몸통과 분리된 후, 이미 죄악에 침식되었습니다."
  },
  RelicConfig_44597_BattleDesc = {
    Text = "매번 능동적으로 피해를 입힐 때마다, 자신에게 [Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, 피해 대상에게 [Arg2] 층의<BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_44597_Desc = {
    Text = "매번 능동적으로 피해를 입힐 때마다, 자신에게 [Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, 피해 대상에게 [Arg2] 층의<BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:죄악·군체 의식>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "감싸기, 공생, 군집; 두려움, 미지, 통제."
  },
  RelicConfig_44598_BattleDesc = {
    Text = "광기 폭발을 사용한 후, 현재 HP의 12%를 잃고, 모든 적으로 [Arg1] 점의 일시적인 <PowerIconKeywords:힘>을 훔칩니다. 만약 적이 1명뿐이라면, 추가로 [Arg2] 점의 일시적인 <PowerIconKeywords:힘>을 훔칩니다."
  },
  RelicConfig_44598_Desc = {
    Text = "광기 폭발을 사용한 후, 현재 HP의 12%를 잃고, 모든 적으로 [Arg1] 점의 일시적인 <PowerIconKeywords:힘>을 훔칩니다. 만약 적이 1명뿐이라면, 추가로 [Arg2] 점의 일시적인 <PowerIconKeywords:힘>을 훔칩니다."
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:죄악·재앙 의식의 새>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "욕심 때문에 죽은 가련한 생령이 메마른 흉곽으로 날카로운 비명을 지른다."
  },
  RelicConfig_44603_BattleDesc = {
    Text = "손패 상한이 5 증가하고, 전투 시작 시 6장의 카드를 뽑습니다. 턴 종료 시 손에 있는 모든 증상 카드와 상태 카드를 버리고, 다른 카드는 유지하지만, 매 턴 카드 뽑기 수가 2 감소합니다."
  },
  RelicConfig_44603_Desc = {
    Text = "손패 상한이 5 증가하고, 전투 시작 시 6장의 카드를 뽑습니다. 턴 종료 시 손에 있는 모든 증상 카드와 상태 카드를 버리고, 다른 카드는 유지하지만, 매 턴 카드 뽑기 수가 2 감소합니다."
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:죄악·각인된 의식>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "욕심쟁이는 다른 사람을 물건으로 여기며, 다른 사람의 고통에서 자신의 쾌락을 취한다."
  },
  RelicConfig_44608_BattleDesc = {
    Text = "영구적으로 <PowerIconKeywords:힘>을 [Arg1] 잃습니다. 피해를 입힐 때마다 HP를 [Arg2] 회복합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_44608_Desc = {
    Text = "영구적으로 <PowerIconKeywords:힘>을 [Arg1] 잃습니다. 피해를 입힐 때마다 HP를 [Arg2] 회복합니다. 턴마다 6번까지 발동합니다."
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:죄악·일곱 비늘의 키스>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "그의 키스는 당신을 유혹할 것이다——물론, 유혹당하는 것은 당신 자신일 수도 있다."
  },
  RelicConfig_44609_BattleDesc = {
    Text = "최대 행동력이 3 증가합니다. 매번 패를 초기화할 때 <DerivativeCardKeywords_9:「불안정한 걸음걸이」> 2장을 드로우 덱에 추가합니다."
  },
  RelicConfig_44609_Desc = {
    Text = "최대 행동력이 3 증가합니다. 매번 패를 초기화할 때 <DerivativeCardKeywords_9:「불안정한 걸음걸이」> 2장을 드로우 덱에 추가합니다."
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:죄악·검은 촛대>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "이성의 불길, 광기에 빠지다."
  },
  RelicConfig_44610_BattleDesc = {
    Text = "치명타율과 치명타 피해가 50% 증가하고, 매 턴 시작 시 자신에게 <FragileIconKeywords:손상>을 1턴간 부여한다."
  },
  RelicConfig_44610_Desc = {
    Text = "치명타율과 치명타 피해가 50% 증가하고, 매 턴 시작 시 자신에게 <FragileIconKeywords:손상>을 1턴간 부여한다."
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:죄악·기괴한 갈고리발톱>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "욕망에 왜곡된 클로."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "최대 행동력이 4 증가하고, 매번 드로우 덱을 초기화할 때 <DerivativeCardKeywords_4:“영감”> 4장을 드로우 덱에 추가합니다."
  },
  RelicConfig_44654_Desc = {
    Text = "최대 행동력이 4 증가하고, 매번 드로우 덱을 초기화할 때 <DerivativeCardKeywords_4:“영감”> 4장을 드로우 덱에 추가합니다."
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:축복·검은 촛대>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "불타는 욕망, 구원을 얻다."
  },
  RelicConfig_44656_BattleDesc = {
    Text = "유물주 상한선+[Arg1], 융흔 중 리프레시 횟수+1. 전투가 끝나면 125 검은 인장을 획득합니다. 주울 때는 최대 6장의 증상 카드를 선택하여 삭제할 수 있습니다."
  },
  RelicConfig_44656_Desc = {
    Text = "유물주 상한선+[Arg1], 융흔 중 리프레시 횟수+1. 전투가 끝나면 125 검은 인장을 획득합니다. 주울 때는 최대 6장의 증상 카드를 선택하여 삭제할 수 있습니다."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:축복·에메랄드 탁본>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "아버지 신의 구원이 상처를 지웠다."
  },
  RelicConfig_44658_BattleDesc = {
    Text = "광기 폭발을 사용한 후, [Arg1] 점의 임시 힘을 획득하고, 모든 적으로부터 [Arg1] 점의 임시 <PowerIconKeywords:힘>을 빼앗습니다. 만약 적이 1명뿐이라면, 추가로 [Arg2] 점의 임시 <PowerIconKeywords:힘>을 빼앗습니다."
  },
  RelicConfig_44658_Desc = {
    Text = "광기 폭발을 사용한 후, [Arg1] 점의 임시 힘을 획득하고, 모든 적으로부터 [Arg1] 점의 임시 <PowerIconKeywords:힘>을 빼앗습니다. 만약 적이 1명뿐이라면, 추가로 [Arg2] 점의 임시 <PowerIconKeywords:힘>을 빼앗습니다."
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:축복·재앙 의식의 새>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "용서의 빛이 욕심의 잔해를 감싸고, 죽은 새가 최후의 가사를 부를 수 있었다."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "1 회의 능동적 피해를 입힐 때마다 [Arg1] HP를 회복하고, 피해를 입힌 대상에게 [Arg2] 층의<BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_44659_Desc = {
    Text = "1 회의 능동적 피해를 입힐 때마다 [Arg1] HP를 회복하고, 피해를 입힌 대상에게 [Arg2] 층의<BleedingIconKeywords:출혈>을 부여합니다."
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:축복·군체 의식>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "감싸기, 공생, 군집; 단결, 공존, 보호."
  },
  RelicConfig_44660_BattleDesc = {
    Text = "손패 상한이 5 증가하고, 전투 시작 시 손패를 상한까지 보충합니다. 턴 시작 시 추가로 1장의 카드를 뽑고, 턴 종료 시 손에 든 모든 증상 카드와 상태 카드를 버리며, 다른 카드는 보관합니다."
  },
  RelicConfig_44660_Desc = {
    Text = "손패 상한이 5 증가하고, 전투 시작 시 손패를 상한까지 보충합니다. 턴 시작 시 추가로 1장의 카드를 뽑고, 턴 종료 시 손에 든 모든 증상 카드와 상태 카드를 버리며, 다른 카드는 보관합니다."
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:축복·각인된 의식>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "욕심은 자신의 잘못을 마음에 새기고 과거를 속죄하기 위해 노력합니다."
  },
  RelicConfig_44662_BattleDesc = {
    Text = "2 턴마다 모든 적이 받는 피해가 2배로 증가하며, 이번 턴에 광기 폭발을 1회 사용할 때마다 랜덤으로 1종의 상태를 해제합니다."
  },
  RelicConfig_44662_Desc = {
    Text = "2 턴마다 모든 적이 받는 피해가 2배로 증가하며, 이번 턴에 광기 폭발을 1회 사용할 때마다 랜덤으로 1종의 상태를 해제합니다."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:축복·여정의 유골>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "신성한 일부입니다. \n몸통과 분리되더라도 그 흔적은 이미 전 세계를 뒤덮었습니다."
  },
  RelicConfig_44663_BattleDesc = {
    Text = "크리티컬 확률 50% 증가, 크리티컬 피해 100% 증가."
  },
  RelicConfig_44663_Desc = {
    Text = "크리티컬 확률 50% 증가, 크리티컬 피해 100% 증가."
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:축복·기괴한 갈고리발톱>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "모든 욕망은 이미 내려놓았습니다."
  },
  RelicConfig_44664_BattleDesc = {
    Text = "획득 후 영구적으로 [Arg1] <PowerIconKeywords:힘>을 얻습니다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 턴당 최대 6번까지 발동됩니다."
  },
  RelicConfig_44664_Desc = {
    Text = "획득 후 영구적으로 [Arg1] <PowerIconKeywords:힘>을 얻습니다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 턴당 최대 6번까지 발동됩니다."
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:축복·일곱 비늘의 키스>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "이 타락한 키스를 거부하라, 아버지 신의 품은 모든 어둠보다 따뜻하다."
  },
  RelicConfig_47444_BattleDesc = {
    Text = "“타격”과 “방어”가 추가로 50 은열쇠 에너지 획득. 연산력 소비가 2 이상인 카드를 1장 사용할 때마다, 연산력 소비가 1인 카드를 1장 뽑고 해당 카드의 연산력 소비를 0으로 변경. 매 턴 최대 3회 발동."
  },
  RelicConfig_47444_Desc = {
    Text = "“타격”과 “방어”가 추가로 50 은열쇠 에너지 획득. 연산력 소비가 2 이상인 카드를 1장 사용할 때마다, 연산력 소비가 1인 카드를 1장 뽑고 해당 카드의 연산력 소비를 0으로 변경. 매 턴 최대 3회 발동."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:시계추「쌍둥이」>"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체의 <ExaltIconKeywords:영지 깨어남>을 덱에 셔플합니다. 제 6 턴 시작 후, 테이스는 매 턴 전투 지원을 제공합니다."
  },
  RelicConfig_50338_Desc = {
    Text = "전투 시작 시 모든 깨어남체의 <ExaltIconKeywords:영지 깨어남>을 덱에 셔플합니다. 제 6 턴 시작 후, 테이스는 매 턴 전투 지원을 제공합니다."
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:시계추 「미혹」>"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "그는 말했다, 두려워하지 말라고。"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "해당 유물 획득 시, 카드를 1장 선택하여 해당 카드의 행동력 소비를 영구적으로 1로 변경합니다."
  },
  RelicConfig_50385_Desc = {
    Text = "해당 유물 획득 시, 카드를 1장 선택하여 해당 카드의 행동력 소비를 영구적으로 1로 변경합니다."
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆말라붙은 눈☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "사막에서 가장 소중한 물을 잃고, 그녀의 눈는 이미 말라버렸다."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "전투 첫 턴 시작 시, <DerivativeCardKeywords_46:“프리온 독소”>를 손에 추가합니다; 3턴에는 <DerivativeCardKeywords_49:“끝없는 공격”>을 손에 추가합니다; 데스 리저스턴스가 발동한 후, <DerivativeCardKeywords_52:“부활의 고치”>를 손에 추가합니다."
  },
  RelicConfig_50487_Desc = {
    Text = "전투 첫 턴 시작 시, <DerivativeCardKeywords_46:“프리온 독소”>를 손에 추가합니다; 3턴에는 <DerivativeCardKeywords_49:“끝없는 공격”>을 손에 추가합니다; 데스 리저스턴스가 발동한 후, <DerivativeCardKeywords_52:“부활의 고치”>를 손에 추가합니다."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:시계추 「축복」>"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "턴이 끝날 때: 가장 낮은 광기의 깨어남체가 35pt의 광기를 획득합니다. 남은 HP가 50% 이상이면, [Arg1]pt의 <PowerIconKeywords:힘>을 획득합니다. 남은 HP가 50% 미만이면, [Arg2]pt의 HP를 회복합니다."
  },
  RelicConfig_50488_Desc = {
    Text = "턴 종료 시: 광기가 가장 낮은 깨어남체가 35의 광기를 획득합니다. 현재 HP가 50% 이상일 경우, [Arg1]pt의 <PowerIconKeywords:힘>을 획득합니다. 현재 HP이 50% 미만일 경우, [Arg2]pt의 HP을 회복합니다."
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:시계추 「균형」>"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "크리티컬 확률, 치명타 피해 100% 증가. 1회 피해를 줄 때마다, 모든 깨어남체의 크리티컬과 치명타 피해가 10% 감소, 최대 50%까지 감소. 1회 피해를 줄 때마다, 이번 턴에 발생하는 중독과 반격이 10% 증가, 최대 50%까지 증가."
  },
  RelicConfig_50489_Desc = {
    Text = "크리티컬 확률 및 크리티컬 피해가 100% 증가합니다. 능동 피해 또는 촉수 피해를 입힐 때마다 모든 깨어남체의 크리티컬 확률과 크리티컬 피해가 10% 감소하며 (최대 50%), 중독과 반격 피해량이 10% 증가합니다 (최대 50%)."
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:시계추 「물결」>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "매번 이전 카드와 소속 깨어남체가 다른 명령 카드를 사용할 때마다 해당 깨어남체는 3pt의 광기를 얻고, 1층의 “활성”을 축적합니다. 10층이 축적되면 모든 “활성”을 초기화하고, 모든 깨어남체에게 소모가 있는 랜덤 명령 카드를 1장씩 손에 추가하며, 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_51686_Desc = {
    Text = "매번 이전 카드와 소속 깨어남체가 다른 명령 카드를 사용하면, 해당 깨어남체가 3pt의 광기를 얻고 1층의 “활성”을 축적합니다. 10층이 쌓이면 모든 “활성”을 초기화하고, 모든 깨어남체에게 행동력 소모가 1 감소하고 “소모” 효과가 있는 랜덤 명령 카드를 각각 1장 손에 넣습니다. 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:시계추 「진화」>"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "비“타격”“방어”의 명령 카드를 사용한 후, 만약 이 카드가 파생 카드가 아닐 경우, 해당 깨어남체는 15pt의 광기를 획득하며, 매 턴 최대 5회까지 트리거할 수 있습니다. 매 턴 첫 번째 트리거 시, 사용한 카드를 다시 손으로 횟수합니다."
  },
  RelicConfig_51687_Desc = {
    Text = "비“타격”“방어”의 명령 카드를 사용한 후, 만약 이 카드가 파생 카드가 아닐 경우, 해당 깨어남체는 15pt의 광기를 획득하며, 매 턴 최대 5회까지 트리거할 수 있습니다. 매 턴 첫 번째 트리거 시, 사용한 카드를 다시 손으로 횟수합니다."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:시계추 「투영」>"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "줍을 때, 모든 명령 카드에 “보존”을 추가합니다. 턴이 끝날 때, 손패 수가 5 이상이면 랜덤으로 3장의 손패의 연산력 소비가 1 감소하고, 그렇지 않으면 3장의 카드를 뽑습니다."
  },
  RelicConfig_51688_Desc = {
    Text = "줍을 때, 모든 명령 카드에 “보존”을 추가합니다. 턴이 끝날 때, 손패 수가 5 이상이면 랜덤으로 3장의 손패의 연산력 소비가 1 감소하고, 그렇지 않으면 3장의 카드를 뽑습니다."
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:시계추 「온상」>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "전투 시작 시, 3장의 랜덤 증상 카드를 덱에 추가합니다. 턴 시작 시, 1장의 카드를 뽑습니다. 증상 카드를 1장 사용할 때마다 2pt의 행동력을 얻습니다. 증상 카드를 1장 버릴 때마다 모든 깨어남체가 5pt의 광기를 획득하며, 매 턴 최대 5회까지 누적 발동할 수 있습니다."
  },
  RelicConfig_51689_Desc = {
    Text = "전투 시작 시, 3장의 랜덤 증상 카드를 덱에 추가합니다. 턴 시작 시, 1장의 카드를 뽑습니다. 증상 카드를 1장 사용할 때마다 2pt의 행동력을 획득합니다. 증상 카드를 1장 버릴 때마다 모든 깨어남체가 5pt의 광기를 획득하며, 매 턴 최대 5회까지 누적 발동할 수 있습니다."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:시계추 「역병」>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "모의전 표준 유물 7세트"
  },
  RelicConfig_55847_Desc = {
    Text = "모의전 표준 유물 7세트"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆모의전 유물☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "기묘한 시대에서 꽃이야말로 인간의 첫 번째 관상자였다. \n움직이지 마세요, 그들은 조용한 전시물을 더 선호합니다."
  },
  RelicConfig_55874_BattleDesc = {
    Text = "전투 종료 후 「펜과 잉크」 [Arg1]스택을 획득합니다. 「펜과 잉크」가 2스택에 도달하면 소모되고, 랜덤 「이미지」 1장을 덱에 추가합니다."
  },
  RelicConfig_55874_Desc = {
    Text = "전투 종료 후 「펜과 잉크」 [Arg1]스택을 획득합니다. 「펜과 잉크」가 2스택에 도달하면 소모되고, 랜덤 「이미지」 1장을 덱에 추가합니다."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:오를라의 펜과 잉크>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_56355_BattleDesc = {
    Text = "최대 손패 매수가 2 증가하고, 턴 시작 시마다 카드를 1장 뽑습니다. 전투 종료 후 「펜과 잉크」 [Arg1]스택을 획득합니다. 「펜과 잉크」가 2스택에 도달하면 소모되고, 「이미지」 1장을 선택하여 덱에 추가합니다."
  },
  RelicConfig_56355_Desc = {
    Text = "최대 손패 매수가 2 증가하고, 턴 시작 시마다 카드를 1장 뽑습니다. 전투 종료 후 「펜과 잉크」 [Arg1]스택을 획득합니다. 「펜과 잉크」가 2스택에 도달하면 소모되고, 「이미지」 1장을 선택하여 덱에 추가합니다."
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:오를라의 펜과 잉크>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_56356_BattleDesc = {
    Text = "전투 종료 후 「펜과 잉크」 [Arg1]스택을 획득합니다. 「펜과 잉크」가 2스택에 도달하면 소모되고, 「이미지」 1장을 선택하여 덱에 추가합니다."
  },
  RelicConfig_56356_Desc = {
    Text = "전투 종료 후 「펜과 잉크」 [Arg1]스택을 획득합니다. 「펜과 잉크」가 2스택에 도달하면 소모되고, 「이미지」 1장을 선택하여 덱에 추가합니다."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:오를라의 펜과 잉크>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57667_BattleDesc = {
    Text = "초기 2층의 신모 권능을 보유하고 있으며, 3번째 턴 이후 매 턴 시작 시 신모 권능을 소모하여 다양한 효과를 얻거나 신모 권능을 회복할 수 있습니다. 치명적인 피해를 받으면 부활하고 모든 신모 권능을 소모하며, 각 층마다 10%의 HP를 회복합니다. 단, 1회만 유효합니다."
  },
  RelicConfig_57667_Desc = {
    Text = "초기 2층의 신모 권능을 보유하고, 3번째 턴 이후 매 턴 시작 시 신모 권능을 소모하여 다양한 효과를 얻거나 신모 권능을 답변할 수 있습니다. 치명적인 피해를 받을 경우 부활하며 모든 신모 권능을 소모하고, 각 층당 10%의 HP를 회복합니다. 단 1회만 발동 가능합니다."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:신모의 비호>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "모든 깨어남체의 크리티컬 확률이 15% 증가합니다. 레이크와 주사위의 랜덤 효과 최종 결과가 1 증가합니다."
  },
  RelicConfig_57732_Desc = {
    Text = "모든 깨어남체의 크리티컬 확률이 15% 증가합니다. 레이크와 주사위의 랜덤 효과 최종 결과가 1 증가합니다."
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:고급 행운의 외투>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "턴이 시작되거나 레이크 또는 주사위의 랜덤 효과가 발동할 때, 100 은열쇠 에너지와 4% 크리티컬 피해를 획득하며, 최대 50% 크리티컬 피해 획득 가능. 전투 종료 시 제거됩니다."
  },
  RelicConfig_57733_Desc = {
    Text = "턴이 시작되거나 레이크 또는 주사위의 랜덤 효과가 발동할 때, 100 은열쇠 에너지와 4% 크리티컬 피해를 획득하며, 최대 50% 크리티컬 피해 획득 가능. 전투 종료 시 제거됩니다."
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:정교한 큰입 단추>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57734_BattleDesc = {
    Text = "매번 키령 해제 시, “빛나는 편방 주사위” 1장을 손에 넣습니다."
  },
  RelicConfig_57734_Desc = {
    Text = "매번 키령 해제 시, “빛나는 편방 주사위” 1장을 손에 넣습니다."
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:빛나는 속임수 주사위>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57735_BattleDesc = {
    Text = "턴이 시작되거나 레이크 및 주사위의 랜덤 효과가 발동할 때, 50 은열쇠 에너지와 2% 크리티컬 피해를 획득합니다. 최대 30% 크리티컬 피해까지 가능하며, 전투 종료 시 제거됩니다."
  },
  RelicConfig_57735_Desc = {
    Text = "턴이 시작되거나 레이크 및 주사위의 랜덤 효과가 발동할 때, 50 은열쇠 에너지와 2% 크리티컬 피해를 획득합니다. 최대 30% 크리티컬 피해까지 가능하며, 전투 종료 시 제거됩니다."
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:큰입 단추>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57736_BattleDesc = {
    Text = "매번 키령 해제 시, “편방 주사위” 1장을 손에 넣습니다."
  },
  RelicConfig_57736_Desc = {
    Text = "매번 키령 해제 시, “편방 주사위” 1장을 손에 넣습니다."
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:속임수 주사위>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57737_BattleDesc = {
    Text = "모든 깨어남체의 크리티컬 확률이 10% 증가합니다. 모든 레이크와 주사위의 랜덤 효과는 최저값이 나타나지 않습니다."
  },
  RelicConfig_57737_Desc = {
    Text = "모든 깨어남체의 크리티컬 확률이 10% 증가합니다. 모든 레이크와 주사위의 랜덤 효과는 최저값이 나타나지 않습니다."
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:행운의 외투>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물을 얻습니다. “루비 브로치, 실타래올 마노, 구조 신호, 불운의 의식새, 시령배·매혹”."
  },
  RelicConfig_57791_Desc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물을 얻습니다. “루비 브로치, 실타래올 마노, 구조 신호, 불운의 의식새, 시령배·매혹”."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물을 얻습니다. “어포크, 이국적인 우표집, 알카나 기록, 의식 명각, 시령배·축적” 중 하나입니다."
  },
  RelicConfig_57792_Desc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물을 얻습니다. “어포크, 이국적인 우표집, 알카나 기록, 의식 명각, 시령배·축적” 중 하나입니다."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물을 얻습니다. “레이저 턱뼈, 의심스러운 연고, 먼지 낀 자수틀, 이종의 목소리, 시령배·이용” 중 하나를 얻습니다."
  },
  RelicConfig_57793_Desc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물을 얻습니다. “레이저 턱뼈, 의심스러운 연고, 먼지 낀 자수틀, 이종의 목소리, 시령배·이용” 중 하나를 얻습니다."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "유물 상한 +1. 전투 시작 후 처음 다섯 턴 동안, 매 턴 시작 시 하나의 유물을 획득합니다. 이에는 “가시두드러기베스트”, “고인의 품에 있던 시계”, “선결단장”, “구원의 지지대”, “시령배·만연”이 포함됩니다."
  },
  RelicConfig_57794_Desc = {
    Text = "유물 상한 +1. 전투 시작 후 처음 다섯 턴 동안, 매 턴 시작 시 하나의 유물을 획득합니다. 이에는 “가시두드러기베스트”, “고인의 품에 있던 시계”, “선결단장”, “구원의 지지대”, “시령배·만연”이 포함됩니다."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "유물 상한 +1. 전투 시작 후 처음 다섯 턴 동안, 매 턴 시작마다 유물 하나를 얻습니다: “녹슨 버들잎 칼, 지혈관, 오래된 퍼즐, 벌레 무리의 의식, 시령배·쌍둥이”."
  },
  RelicConfig_57795_Desc = {
    Text = "유물 상한 +1. 전투 시작 후 처음 다섯 턴 동안, 매 턴 시작마다 유물 하나를 얻습니다: “녹슨 버들잎 칼, 지혈관, 오래된 퍼즐, 벌레 무리의 의식, 시령배·쌍둥이”."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "유물 상한이 1 증가한다. 전투 시작 후 5턴 동안 각 턴 시작시 하나의 유물「정밀 계측기, 계엽소매단추, 무명의 신의 베일, 악몽의 상징, 시령배·균형」을 획득한다."
  },
  RelicConfig_57796_Desc = {
    Text = "유물 상한이 1 증가한다. 전투 시작 후 5턴 동안 각 턴 시작시 하나의 유물「정밀 계측기, 계엽소매단추, 무명의 신의 베일, 악몽의 상징, 시령배·균형」을 획득한다."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물, “새로운 지갑, 미사그 배지, 별빛의 술, 칠개맨의 키스, 시령배·눈”을 획득합니다."
  },
  RelicConfig_57797_Desc = {
    Text = "유물 상한 +1. 전투 시작 후 첫 다섯 턴 동안 각 턴 시작 시 하나의 유물, “새로운 지갑, 미사그 배지, 별빛의 술, 칠개맨의 키스, 시령배·눈”을 획득합니다."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:시계추「가라앉은 보물」>"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "전설에 따르면 리모리아는 이 바다에 가라앉았습니다. 누가 침몰한 보물의 비밀을 찾는 것을 참을 수 있을까요?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨웁니다. 다음 5 턴 동안 매 턴 시작 시 하나의 유물(녹슨 버들잎 칼, 새식 휠 액슬, 우리의 집, 기괴한 후크클로우, 시령배·입신)을 획득합니다."
  },
  RelicConfig_58872_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨웁니다. 다음 5 턴 동안 매 턴 시작 시 하나의 유물(녹슨 버들잎 칼, 새식 휠 액슬, 우리의 집, 기괴한 후크클로우, 시령배·입신)을 획득합니다."
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:시계추「비보 α」>"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨웁니다. 다음 5 턴 동안, 매 턴 시작 시 하나의 유물을 획득하며, 「달콤한 잉크, 실타래성한 음반, 별빛의 술, 기예의 모자, 시령배·이용」 중 하나를 얻습니다."
  },
  RelicConfig_58873_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨웁니다. 다음 5 턴 동안, 매 턴 시작 시 하나의 유물을 획득하며, 「달콤한 잉크, 실타래성한 음반, 별빛의 술, 기예의 모자, 시령배·이용」 중 하나를 얻습니다."
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:시계추「비보 β」>"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "턴 시작 시 1장의 “레이크의 행운의 주사위”를 획득하며, 주사위의 눈금이 +1됩니다. 턴 시작 시와 매번 주사위를 던진 후 모든 깨어남체는 4%의 크리티컬 피해를 획득하며, 최대 100%까지 획득할 수 있습니다."
  },
  RelicConfig_59118_Desc = {
    Text = "턴 시작 시 1장의 “레이크의 행운의 주사위”를 획득하며, 주사위의 눈금이 +1됩니다. 턴 시작 시와 매번 주사위를 던진 후 모든 깨어남체는 4%의 크리티컬 피해를 획득하며, 최대 100%까지 획득할 수 있습니다."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:시계추「혼돈의 선물」>"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "고대의 죄악이 여기에 새겨져 있다."
  },
  RelicConfig_59687_BattleDesc = {
    Text = "모의전 표준 유물 7세트"
  },
  RelicConfig_59687_Desc = {
    Text = "모의전 표준 유물 7세트"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆모의전 유물☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "기묘한 시대에서 꽃이야말로 인간의 첫 번째 관상자였다. \n움직이지 마세요, 그들은 조용한 전시물을 더 선호합니다."
  },
  RelicConfig_60723_BattleDesc = {
    Text = "최대 행동력 1 증가하고, 턴 시작 시 추가로 1장의 카드를 뽑으며, 1장의 “협주의 교향”을 획득합니다. 연속으로 3번 사용한 명령 카드의 행동력이 같을 경우, 모든 깨어남체는 20pt의 광기를 획득하며, 턴 시작 시와 발동 후에 횟수가 초기화됩니다."
  },
  RelicConfig_60723_Desc = {
    Text = "최대 행동력이 1 증가하고, 턴 시작 시 추가로 1장의 카드를 뽑으며, 1장의 “협주의 교향”을 획득합니다. 연속으로 3번 사용한 명령 카드의 행동력이 같을 경우, 모든 깨어남체가 20pt의 광기를 획득하며, 턴 시작 시와 발동 후에 횟수를 초기화합니다."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:악단의 지휘봉>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "가늘고 긴 지휘봉, 그러나 레버보다 더 강력한 힘을 가지고 있습니다. \n음표를 지휘하고, 영혼을 지휘하며, 운명을 지휘합니다."
  },
  RelicConfig_60724_BattleDesc = {
    Text = "전투 시작 시, 「취약」 각인과 「폭발」 각인 및 그 고급 각인을 획득하고, 카드에 각인을 선택한다."
  },
  RelicConfig_60724_Desc = {
    Text = "전투 시작 시, 「취약」 각인과 「폭발」 각인 및 그 고급 각인을 획득하고, 카드에 각인을 선택한다."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60725_BattleDesc = {
    Text = "전투 시작 시, “광기” 각인과 “카탈리스트” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60725_Desc = {
    Text = "전투 시작 시, “광기” 각인과 “카탈리스트” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60726_BattleDesc = {
    Text = "전투 시작 시, 「약화」 각인과 「계산」 각인, 그리고 그 고급 각인을 새길 카드를 선택하여 새깁니다."
  },
  RelicConfig_60726_Desc = {
    Text = "전투 시작 시, 「약화」 각인과 「계산」 각인, 그리고 그 고급 각인을 새길 카드를 선택하여 새깁니다."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60727_BattleDesc = {
    Text = "전투 시작 시, “철벽” 각인과 “묘수” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60727_Desc = {
    Text = "전투 시작 시, “철벽” 각인과 “묘수” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60728_BattleDesc = {
    Text = "전투 시작 시, “임신” 각인과 “에코” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택할 수 있습니다."
  },
  RelicConfig_60728_Desc = {
    Text = "전투 시작 시, “임신” 각인과 “에코” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택할 수 있습니다."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60729_BattleDesc = {
    Text = "전투 시작 시, “묘수” 각인과 “영감” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60729_Desc = {
    Text = "전투 시작 시, “묘수” 각인과 “영감” 각인 및 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60730_BattleDesc = {
    Text = "전투 시작 시, “폭력” 각인과 “소진” 각인 및 그 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60730_Desc = {
    Text = "전투 시작 시, “폭력” 각인과 “소진” 각인 및 그 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60731_BattleDesc = {
    Text = "전투 시작 시, 2개의 “합주” 각인과 그 고급 각인을 획득하며, 카드에 각인을 적용합니다."
  },
  RelicConfig_60731_Desc = {
    Text = "전투 시작 시, 2개의 “합주” 각인과 그 고급 각인을 획득하며, 카드에 각인을 적용합니다."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_60732_BattleDesc = {
    Text = "전투 시작 시, “기획”각인과 “미러”각인 및 그 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60732_Desc = {
    Text = "전투 시작 시, “기획”각인과 “미러”각인 및 그 고급 각인을 획득하고, 카드에 각인을 선택합니다."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:시계추「학교장의 격언」>"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_65376_BattleDesc = {
    Text = "초기 보유 [Arg1] 과학단 인원. 전투 시작 시, 5장의 <DerivativeCardKeywords_73:의심>을 덱에 넣습니다."
  },
  RelicConfig_65376_Desc = {
    Text = "초기 보유 [Arg1] 과학단 인원. 전투 시작 시, 5장의 <DerivativeCardKeywords_73:의심>을 덱에 넣습니다."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:과학단>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "미사그 창시자의 메시지가 귀에 맴돈다. \n은열쇠가 길을 안내하기를 바라며, 미사그의 수호자여."
  },
  RelicConfig_65406_BattleDesc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_71:“빛나는 인간성의 빛”> [Arg1]장을 획득합니다.\n<D05EX_Relic:당신의 모든 노력은 가치가 있습니다. 당신은 거의 과학 탐사대를 지켰고, 살아남은 사람들은 진심으로 당신에게 감사하고 있습니다.>"
  },
  RelicConfig_65406_Desc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_71:“빛나는 인간성의 빛”> [Arg1]장을 획득합니다.\n<D05EX_Relic:당신의 모든 노력이 가치가 있었습니다. 당신은 거의 과학 탐사대를 보호했으며, 살아남은 사람들은 진심으로 당신에게 감사하고 있습니다.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:구조 훈장·백금>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "당신의 모든 노력은 가치가 있었으며, 당신은 거의 탐사파티을 보호했습니다. 살아남은 사람들은 진심으로 당신에게 감사하고 있습니다."
  },
  RelicConfig_65407_BattleDesc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_72:“찬란한 인간성의 빛”> [Arg1]장을 획득합니다.\n<D05EX_Relic:당신은 믿을 수 없는 기적을 창조했습니다. 재난 이후 모든 사람들이 살아남았고, 당신은 사람들의 마음속에 위대한 영웅입니다. 당신에 대한 전설은 아마도 눈 덮인 산 주변에 전해질 것입니다.>"
  },
  RelicConfig_65407_Desc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_72:“찬란한 인간성의 빛”> [Arg1]장을 획득합니다.\n <D05EX_Relic:당신은 믿을 수 없는 기적을 창조했습니다. 재난 이후 모든 사람들이 살아남았고, 당신은 사람들의 마음속에 위대한 영웅입니다. 당신에 대한 전설은 아마도 눈 덮인 산 주변에 전해질 것입니다.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:구조 훈장·다이아몬드>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "당신은 놀라운 기적을 만들어냈습니다. 재난 후 모든 사람이 전부 살아남았습니다. 당신은 사람들의 마음속에 위대한 영웅으로 남아있을 것입니다. 당신에 대한 전설은 아마도 설산 주변에서 퍼져나갈 것입니다."
  },
  RelicConfig_65408_BattleDesc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_68:“어두운 인간성의 빛”> [Arg1]장을 획득합니다.\n<D05EX_Relic:눈산에서 벗어나기 위해 당신은 효율성을 우선시하는 전략을 선택했고, 사람들은 하나둘씩 죽어가는 것을 지켜보았습니다. 살아남은 이들이 당신을 바라보는 시선은 감사보다 공포가 더 컸습니다.>"
  },
  RelicConfig_65408_Desc = {
    Text = "턴 시작 시, [Arg1]장의 <DerivativeCardKeywords_68:‘희미한 인간성의 광휘’>를 얻습니다.\n<D05EX_Relic:눈 덮인 산을 넘어가기 위해, 당신은 효율을 우선시하는 전략을 선택했고, 사람들이 하나씩 죽어가는 것을 지켜보았습니다. 생존자들이 당신을 바라보는 눈길에는 두려움이 감사보다 더 많이 담겨 있었습니다.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:구조 훈장·청동>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "설산을 벗어나기 위해 당신은 효율성을 우선하는 전략을 선택했고, 사람들이 하나씩 사라지는 것을 지켜봤습니다. 생존자들이 당신을 바라보는 시선에는 두려움이 감사보다 컸습니다."
  },
  RelicConfig_65409_BattleDesc = {
    Text = "턴 시작 시, [Arg1] 장의 <DerivativeCardKeywords_69:“미약한 인간성의 빛”>을 획득합니다.\n<D05EX_Relic:당신은 아마 노력했을 것입니다. 반은 죽었지만, 적어도 나머지 반은 구했습니다. 희생은 항상 불가피한 것이니까요.>"
  },
  RelicConfig_65409_Desc = {
    Text = "턴 시작 시, [Arg1] 장의 <DerivativeCardKeywords_69:“미약한 인간성의 빛”>을 획득합니다.\n<D05EX_Relic:당신은 아마 노력했을 것입니다. 반은 죽었지만, 적어도 나머지 반은 구했습니다. 희생은 항상 불가피한 것이니까요.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:구조 훈장·백은>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "당신은 아마 노력했을 것입니다. 반은 죽었으나, 적어도 나머지 반은 구했습니다. 희생은 항상 피할 수 없는 것이니까요."
  },
  RelicConfig_65410_BattleDesc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_70:“인성의 빛”> [Arg1]장을 획득합니다. \n<D05EX_Relic:당신은 대부분의 사람들을 구했습니다. 사람들이 원래 비극적인 운명을 바꾼 것입니다. 당신은 이미 최선을 다한 것이죠, 아니요?>"
  },
  RelicConfig_65410_Desc = {
    Text = "턴 시작 시, <DerivativeCardKeywords_70:“인성의 빛”> [Arg1]장을 획득합니다. \n<D05EX_Relic:당신은 대부분의 사람들을 구했습니다. 사람들이 원래 비극적인 운명을 바꾼 것입니다. 당신은 이미 최선을 다한 것이죠, 아니요?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:구조 훈장·황금>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "당신은 대부분의 사람들을 구했고, 사람들의 원래 비극적인 운명을 바꾸었습니다. 당신은 이미 최선을 다했지 않나요?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "전투 시작 시 3장의 랜덤 “증상” 카드를 섞습니다. “증상” 카드를 사용할 때 [Arg1]pt의 힘을 얻습니다.\n<D05EX_Relic:당신의 도움으로 과학단은 누구도 살아남지 못하다, 당신은 냉정하게 자신을 위해 최대의 이익을 챙겼지만, 이 모든 것이 정말 가치가 있을까요?>"
  },
  RelicConfig_65456_Desc = {
    Text = "전투 시작 시 3장의 랜덤 “증상” 카드를 섞습니다. “증상” 카드를 사용할 때 [Arg1]pt의 힘을 얻습니다.\n<D05EX_Relic:당신의 도움으로 과학단은 누구도 살아남지 못하다, 당신은 냉담하게 자신에게 최대의 이익을 챙겼지만, 이 모든 것이 정말 가치가 있을까요?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:고독한 늑대의 휘장>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "당신의 도움으로, 과학단은 누구도 살아남지 못했고, 당신은 자신을 위해 최대의 이익을 얻었습니다. 하지만 정말로 이 모든 것이 가치가 있었을까요？"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남시킵니다. 이후 5턴 동안 매 턴 시작 시 하나의 유물을 획득합니다. 「통신 장비, 봄의 제사, 사제의 지팡이, 불운의 의식새, 시령배·투사」 중 하나를 얻습니다."
  },
  RelicConfig_65569_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남시킵니다. 이후 5턴 동안 매 턴 시작 시 하나의 유물을 획득합니다. 「통신 장비, 봄의 제사, 사제의 지팡이, 불운의 의식새, 시령배·투사」 중 하나를 얻습니다."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:시계추「비보 δ」>"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남시킵니다. 이후 5턴 동안 매 턴 시작 시 하나를 획득합니다: “미사그 배지, 의사의 가방, 프로토타입 배터리, 의식 명각, 시령배·연화”."
  },
  RelicConfig_65570_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남시킵니다. 이후 5턴 동안 매 턴 시작 시 하나를 획득합니다: “미사그 배지, 의사의 가방, 프로토타입 배터리, 의식 명각, 시령배·연화”."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:시계추「비보 γ」>"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "전투 시작 시 행동력 상한이 1 증가하고, 모든 깨어남체를 깨어남한다. 이후 5턴 동안 매 턴 시작 시 하나의 유물을 획득하며, 「포트니 아침 신문, 미학 원리, 군중의 노래, 불완전한 얼굴, 시령배·왕래」 중 하나를 얻는다."
  },
  RelicConfig_66515_Desc = {
    Text = "전투 시작 시 행동력 상한이 1 증가하고, 모든 깨어남체를 깨어남한다. 이후 5턴 동안 매 턴 시작 시 하나의 유물을 획득하며, 「포트니 아침 신문, 미학 원리, 군중의 노래, 불완전한 얼굴, 시령배·왕래」 중 하나를 얻는다."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:시계추「비보 ε」>"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_66518_Desc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:시계추「기원 β」>"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_66519_Desc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:시계추「기원 α」>"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "매 턴 시작 시 모든 깨어남체가 25의 광기를 획득합니다. 획득 시 최대 HP가 1.5배 됩니다."
  },
  RelicConfig_67690_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 25의 광기를 획득합니다. 획득 시 최대 HP가 1.5배 됩니다."
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:축복·악몽의 표상β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "두려워하지 마세요, 망설이지 마세요. 이는 단순히 찰나의 꿈일 뿐입니다. 아버지 신의 빛은 여전히 당신 위에 비춰지고 있습니다."
  },
  RelicConfig_67788_BattleDesc = {
    Text = "해당 유물 획득 시, 행동력을 3 획득합니다."
  },
  RelicConfig_67788_Desc = {
    Text = "해당 유물 획득 시, 행동력을 3 획득합니다."
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:회중시계 거울>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "기억이 과거의 시간에 굳어져 검은 바닥에 깊이 묻혀 있습니다."
  },
  RelicConfig_67789_BattleDesc = {
    Text = "획득 시, <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_67789_Desc = {
    Text = "획득 시, <DerivativeCardKeywords_1:「그림자의 메아리」> 1장을 손패에 추가합니다."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:통신 장비>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "그것이 맑은 종소리를 내는 순간을 기대하거나 두려워합니다."
  },
  RelicConfig_67790_BattleDesc = {
    Text = "모든 「타격」의 크리티컬 피해가 20% 증가합니다. 해당 유물 획득 시, <DerivativeCardKeywords_40:「아름다운 순간」> 1장을 손패에 추가합니다."
  },
  RelicConfig_67790_Desc = {
    Text = "모든 「타격」의 크리티컬 피해가 20% 증가합니다. 해당 유물 획득 시, <DerivativeCardKeywords_40:「아름다운 순간」> 1장을 손패에 추가합니다."
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:아름다운 순간>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "순간의 아름다움을 영원히 보관합니다."
  },
  RelicConfig_67791_BattleDesc = {
    Text = "획득 시, 모든 적에게 1턴 동안 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  RelicConfig_67791_Desc = {
    Text = "획득 시, 모든 적에게 1턴 동안 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:변색 구속복>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "시간뿐만 아니라 공포와 고통도 물감을 변색시킬 수 있다."
  },
  RelicConfig_67793_BattleDesc = {
    Text = "전투 시작 시, 모든 깨어남체가 50 광기를 획득하고, <DerivativeCardKeywords_1:「그림자의 메아리」> 2장을 손패에 추가합니다."
  },
  RelicConfig_67793_Desc = {
    Text = "모든 깨어남체가 50 광기를 획득하고, <DerivativeCardKeywords_1:「그림자의 메아리」> 2장을 손패에 추가합니다."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:통신 장비+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "그것이 맑은 종소리를 내는 순간을 기대하거나 두려워합니다."
  },
  RelicConfig_67794_BattleDesc = {
    Text = "손패 상한이 5 증가하고, 전투 시작 시 손패를 상한까지 보충합니다. 턴 시작 시 추가로 1장의 카드를 뽑고, 턴 종료 시 손에 든 모든 증상 카드와 상태 카드를 버리며, 다른 카드는 보관합니다."
  },
  RelicConfig_67794_Desc = {
    Text = "손패 상한이 5 증가하고, 전투 시작 시 손패를 상한까지 보충합니다. 턴 시작 시 추가로 1장의 카드를 뽑고, 턴 종료 시 손에 든 모든 증상 카드와 상태 카드를 버리며, 다른 카드는 보관합니다."
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:축복·각인된 의식 β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "욕심은 자신의 잘못을 마음에 새기고 과거를 속죄하기 위해 노력합니다."
  },
  RelicConfig_67818_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67818_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:「만상의 문 ε」>"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67819_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:「만상의 문 ζ」>"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67820_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:「만상의 문 θ」>"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67821_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:「만상의 문 γ」>"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67822_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:「만상의 문 α」>"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67823_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:「만상의 문 η」>"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67824_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:「만상의 문 δ」>"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67825_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:「만상의 문 β」>"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67826_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 턴 시작 시, “유물” 또는 “지원” 중 하나를 랜덤으로 발견, 총 5번 발견."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:「만상의 문 ι」>"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_84:「추억의 빛 - 미완성된 밀랍상」>을 손패에 추가하고, 모든 드로우 덱의 카드를 복사합니다. 턴마다 추가로 카드를 5장 뽑고, 행동력을 5 획득합니다. 「타격」 또는 「방어」를 사용한 후, [Arg1]의 방어막을 획득합니다."
  },
  RelicConfig_68651_Desc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_84:「추억의 빛 - 미완성된 밀랍상」>을 손패에 추가하고, 모든 드로우 덱의 카드를 복사합니다. 턴마다 추가로 카드를 5장 뽑고, 행동력을 5 획득합니다. 「타격」 또는 「방어」를 사용한 후, [Arg1]의 방어막을 획득합니다."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:「순은의 핵·공포」>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_85:“추억의 빛 - 변이의 심장”>을(를) 손에 추가합니다. 턴 시작 시, 원하는 손패를 버리고 같은 수의 카드를 드로우할 수 있습니다. 홀수 턴에는 [Arg1]pt의 임시 힘을 얻고, 「<DerivativeCardKeywords_97:“불굴의 전의 β”>」를 손에 넣습니다. 짝수 턴에는 [Arg2]pt의 임시 경계를 얻고, <DerivativeCardKeywords_98:“은신 β”>를 손에 넣습니다."
  },
  RelicConfig_68652_Desc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_85:“추억의 빛 - 변이의 심장”>을 손에 추가합니다. 턴 시작 시, 원하는 만큼의 손패를 버리고 같은 수만큼 카드를 뽑을 수 있습니다. 홀수 턴에는 [Arg1]pt의 임시 힘을 얻고, “<DerivativeCardKeywords_97:불굴의 전의 β」>를 손에 추가합니다. 짝수 턴에는 [Arg2]pt의 임시 경계를 얻고, <DerivativeCardKeywords_98:”은신 β”>을 손에 추가합니다."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:「순은의 핵·한기」>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_83:“추억의 빛 - 순진한 보답”>을 손에 추가합니다. 모든 깨어남체는 매 턴 추가로 1회의 광기 폭발을 사용할 수 있으며, 광기 폭발을 사용한 후 적의 [Arg2] 점 힘을 감소시킵니다. 턴 시작 시, 모든 깨어남체가 [Arg1] 점의 광기를 획득합니다."
  },
  RelicConfig_68653_Desc = {
    Text = "전투 시작 시 깨어남 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_83:“추억의 빛 - 순진한 보답”>을 손에 추가합니다. 모든 깨어남체는 매 턴 추가로 1회의 광기 폭발을 사용할 수 있으며, 광기 폭발을 사용한 후 적의 [Arg2] 점 힘을 감소시킵니다. 턴 시작 시, 모든 깨어남체가 [Arg1] 점의 광기를 획득합니다."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:「순은의 핵·비애」>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남하고 <DerivativeCardKeywords_88:“추억의 빛 - 유토피아의 장막”>을 손에 넣습니다. 파티의 최대 손패 매수 +2, 은열쇠 에너지 저장 한도 +100％. 키령 해제 후, 모든 깨어남체의 임시 크리티컬 확률과 크리티컬 피해가 + [Arg1] % 증가하며, 최대 HP의 20％에 해당하는 방어막을 획득하고, 손패가 한도에 도달할 때까지 카드를 뽑습니다."
  },
  RelicConfig_68654_Desc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남하고, <DerivativeCardKeywords_88:“추억의 빛 - 유토피아의 장막”>을 손에 넣습니다. 파티의 최대 손패 매수가 +2 되고, 은열쇠 에너지 저장 한도가 +100％ 증가합니다. 은열쇠를 해제한 후, 모든 깨어남체의 임시 크리티컬 확률과 크리티컬 피해가 + [Arg1] % 증가하며, 최대 HP의 20％에 해당하는 방어막을 얻고, 손패가 한도에 도달할 때까지 카드를 뽑습니다."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:「순은의 핵·광기」>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남하고, <DerivativeCardKeywords_89:“추억의 빛 - 풍요의 씨앗”>을 손에 추가합니다. 턴 종료 시 남은 행동력을 보존하며 손패를 더 이상 버리지 않습니다. 1회의 능동 피해를 입힐 때마다 [Arg1]pt의 임시 힘과 [Arg2]pt의 방어막을 얻습니다."
  },
  RelicConfig_68655_Desc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남하고, <DerivativeCardKeywords_89:“추억의 빛 - 풍요의 씨앗”>을 손에 추가합니다. 턴 종료 시 남은 행동력을 보존하며 손패를 더 이상 버리지 않습니다. 1회의 능동 피해를 입힐 때마다 [Arg1]pt의 임시 힘과 [Arg2]pt의 방어막을 얻습니다."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:「순은의 핵·탄생」>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_86:“추억의 빛 - 꿀 와인”>을 손에 추가합니다. 모든 깨어남체의 크리티컬 피해가 1.5배로 증가합니다. 턴 종료 시, 광기 폭발을 사용하지 않은 깨어남체는 [Arg1]pt의 광기를 얻습니다. 사용한 카드 수가 [Arg2]보다 적으면, 다음 턴에 2장의 카드를 뽑고 2pt의 행동력을 얻습니다."
  },
  RelicConfig_68656_Desc = {
    Text = "전투 시작 시 모든 깨어남체를 깨어남시키고, <DerivativeCardKeywords_86:“추억의 빛 - 꿀 와인”>을 손에 추가합니다. 모든 깨어남체의 크리티컬 피해는 1.5배가 됩니다. 턴 종료 시 광기 폭발을 사용하지 않은 깨어남체는 [Arg1] 점의 광기를 획득합니다. 카드 사용 수가 [Arg2]보다 적으면, 다음 턴에 2장의 카드를 뽑고 2점의 행동력을 얻습니다."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:「순은의 핵·기이」>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "전투 시작 시 모든 각성체를 각성시키고 <DerivativeCardKeywords_87:「추억의 빛 - 대행자의 심판」>을 손에 넣으며, 팀 피해 증폭이 2배가 됩니다. 플레이어가 가하는 허약 효과가 25%에서 50%로 증가하고, 매 턴 종료 시 최대 HP의 [Arg1]%에 해당하는 방어막을 획득하고 모든 적에게 자신의 방어막의 [Arg2]배에 해당하는 <FixedDamage:순수 피해>를 입힙니다."
  },
  RelicConfig_68657_Desc = {
    Text = "전투 시작 시 모든 각성체를 각성시키고 <DerivativeCardKeywords_87:「추억의 빛 - 대행자의 심판」>을 손에 넣으며, 팀 피해 증폭이 2배가 됩니다. 플레이어가 가하는 허약 효과가 25%에서 50%로 증가하고, 매 턴 종료 시 최대 HP의 [Arg1]%에 해당하는 방어막을 획득하고 모든 적에게 자신의 방어막의 [Arg2]배에 해당하는 <FixedDamage:순수 피해>를 입힙니다."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:「순은의 핵·모독」>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "타비가 주는 피해, 치유, 방어막이 50% 증가합니다. 전투 시작 시 타비는 광기 120pt 획득합니다."
  },
  RelicConfig_68886_Desc = {
    Text = "타비가 주는 피해, 방어막, HP 회복이 50％ 증가합니다. 전투 시작 시 타비는 광기 120pt를 획득합니다."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:“전지안”>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "그분은 문을 통해 나오시며, 유일하고 올바른 길을 밟으셨다."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_69319_Desc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:시계추「기원 ε」>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_69320_Desc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:시계추「기원 γ」>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_69321_Desc = {
    Text = "전투 시작 시, 연산력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 유물을 발견, 총 5회 발견."
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:시계추「기원 δ」>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "턴 시작 시 1pt의 “심연 원능”을 축적하고, “깊은 잠” 또는 “깨어남” 중 하나를 선택합니다. 깊은 잠: 추가로 1pt의 “심연 원능”을 축적합니다. 깨어남: 1/5/10pt의 “심연 원능”을 소모하여 툴루의 지원을 얻습니다. 소모한 “심연 원능”이 많을수록 툴루의 지원 효과가 강해집니다."
  },
  RelicConfig_70042_Desc = {
    Text = "턴 시작 시 1pt의 “심연 원능”을 축적하고, “깊은 잠” 또는 “깨어남” 중 하나를 선택합니다. 깊은 잠: 추가로 1pt의 “심연 원능”을 축적합니다. 깨어남: 1/5/10pt의 “심연 원능”을 소모하여 툴루의 지원을 받습니다. 소모하는 “심연 원능”이 많을수록 툴루의 지원 효과가 강해집니다."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:신왕의 권능>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "전투 시작 시, 모든 깨어남체의 “영지 깨어남”을 드로우 덱에 섞습니다."
  },
  RelicConfig_70084_Desc = {
    Text = "전투 시작 시, 모든 깨어남체의 “영지 깨어남”을 드로우 덱에 섞습니다."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:영지 깨어남>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "모든 깨어남체가 주는 기본 피해가 [Arg1]% 증가합니다."
  },
  RelicConfig_70700_Desc = {
    Text = "모든 깨어남체가 주는 기본 피해가 [Arg1]% 증가합니다."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:울음 파이프>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "이는 과연 증오의 산물인지, 아니면 복수의 결과인지?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "턴 시작 시 모든 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  RelicConfig_70701_Desc = {
    Text = "턴 시작 시 모든 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:프로토타입 배터리>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "휴대용 희망."
  },
  RelicConfig_70702_BattleDesc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70702_Desc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:무거운 자물쇠+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "두꺼우면서도 견고한 자물쇠는, 만약 키가 없다면 아마도 열기 어려울 것입니다. \n물론, 이것은 어떤 도둑에게는 별로 중요하지 않다."
  },
  RelicConfig_70703_BattleDesc = {
    Text = "“타격”이 추가로 1회 [Arg1]% 깨어남체 공격력의 피해를 입히며, 턴당 최대 3회까지 발생합니다."
  },
  RelicConfig_70703_Desc = {
    Text = "“타격”이 추가로 1회 [Arg1]% 깨어남체 공격력의 피해를 입히며, 턴당 최대 3회까지 발생합니다."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:녹슨 메스>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "생체를 자르는 데 적합하지 않습니다."
  },
  RelicConfig_70704_BattleDesc = {
    Text = "은열쇠를 사용해 깨어남한 후 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하고 [Arg2] 은열쇠 에너지 획득합니다。"
  },
  RelicConfig_70704_Desc = {
    Text = "은열쇠를 사용해 깨어남한 후 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하고 [Arg2] 은열쇠 에너지 획득합니다。"
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:의심스러운 연고+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "집에서 만든 외상용 연고입니다. 의사의 지시 없이 사용하지 마십시오."
  },
  RelicConfig_70705_BattleDesc = {
    Text = "“타격”이 피해를 입히고 [Arg1]%의 <IntoxicationIconKeywords:중독>을 부여하며, 매 턴 최대 [Arg2] pt까지."
  },
  RelicConfig_70705_Desc = {
    Text = "“타격”이 피해를 입히고 [Arg1]%의 <IntoxicationIconKeywords:중독>을 부여하며, 매 턴 최대 [Arg2] pt까지."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:이형의 목소리+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "그는 악마는 아니지만, 그는 인생 너머의 저어를 전달합니다."
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> 자동 획득량 증가 [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> 자동 획득량 증가 [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:역병 진단서>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "역병 —— 자연의 무의식적인 불안정한 상태의 우연한 표현."
  },
  RelicConfig_70707_BattleDesc = {
    Text = "은열쇠 깨어남 후 모든 깨어남체가 광기 [Arg1]pt와 은열쇠 에너지 [Arg2] 획득."
  },
  RelicConfig_70707_Desc = {
    Text = "은열쇠 깨어남 후 모든 깨어남체가 광기 [Arg1]pt와 은열쇠 에너지 [Arg2] 획득."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:월계수잎 소매단추+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "은제로 제작된 계엽 문양이 새겨진 소매단추입니다. \n정교하게 만들어져 반짝이는 광채를 띠며, 과거에는 두 아이의 우정을 담고 있었습니다."
  },
  RelicConfig_70708_BattleDesc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체와 유물이 입히는 <IntoxicationIconKeywords:중독> 효과가 [Arg2]% 증가합니다."
  },
  RelicConfig_70708_Desc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체와 유물이 입히는 <IntoxicationIconKeywords:중독> 효과가 [Arg2]% 증가합니다."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:먼지 낀 재봉틀+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "자비로운 어머니가 심장의 상처를 봉합합니다."
  },
  RelicConfig_70709_BattleDesc = {
    Text = "초원차원 턴에 진입한 후, 첫 번째로 사용된 파생 명령 카드는 추가로 [Arg1] 회 발동됩니다."
  },
  RelicConfig_70709_Desc = {
    Text = "초원차원 턴에 진입한 후, 첫 번째로 사용된 파생 명령 카드는 추가로 [Arg1] 회 발동됩니다."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:빛나는 모래시계>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "측정 가능한 시간입니다."
  },
  RelicConfig_70711_BattleDesc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <RetaliateIconKeywords:반격>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70711_Desc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <RetaliateIconKeywords:반격>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:선현의 기록+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "“인간은 얼마나 어리석은가，단지 구시대적이라는 이유로 맹신한다.”"
  },
  RelicConfig_70712_BattleDesc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <PowerIconKeywords:힘>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70712_Desc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <PowerIconKeywords:힘>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:우리의 집>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "그들은 이전에 함께 있었고, 이후에도 항상 함께 있을 것입니다. 그들은 서로를 사랑하는 한 가족입니다."
  },
  RelicConfig_70713_BattleDesc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_70713_Desc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:녹슨 톱>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "해부의사는 평생 아름다운 여자를 볼 수 없고, 오직 뼈 더미와 질병으로 인해 염증이 생긴 신경, 근육 및 조직만 볼 수 있다."
  },
  RelicConfig_70714_BattleDesc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체가 가하는 <RetaliateIconKeywords:반격>과 유물이 가하는 <RetaliateIconKeywords:반격>이 [Arg2]% 상승합니다."
  },
  RelicConfig_70714_Desc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체가 가하는 <RetaliateIconKeywords:반격>과 유물이 가하는 <RetaliateIconKeywords:반격>이 [Arg2]% 상승합니다."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:숨김 없는 전달자>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "그것은 수많은 주동적이거나 수동적으로 말해진 비밀을 전달한다."
  },
  RelicConfig_70715_BattleDesc = {
    Text = "은열쇠로 깨어남 후 [Arg1]장의 카드를 뽑고 [Arg2]의 은열쇠 에너지 획득."
  },
  RelicConfig_70715_Desc = {
    Text = "은열쇠로 깨어남 후 [Arg1]장의 카드를 뽑고 [Arg2]의 은열쇠 에너지 획득."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:새 지갑+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "미사그 대학의 문장이 새겨진 가죽 지갑입니다. \n지금은 비어 있어 아무것도 없습니다."
  },
  RelicConfig_70717_BattleDesc = {
    Text = "턴 시작 시 [Arg1]장의 카드를 뽑습니다."
  },
  RelicConfig_70717_Desc = {
    Text = "턴 시작 시 [Arg1]장의 카드를 뽑습니다."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:정밀 나침반+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "지시하는 것은 방향이 아니라 자기장입니다."
  },
  RelicConfig_70718_BattleDesc = {
    Text = "「광기 폭발」 사용 후 모든 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히고, [Arg2]% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  RelicConfig_70718_Desc = {
    Text = "「광기 폭발」 사용 후 모든 적에게 아군 최대 HP의 [Arg2]%에 해당하는 <FixedDamage:순수 피해>를 1회 입히고, [Arg2]% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:라듐 턱뼈>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "어느 수집가의 사설 전시실타래에 전시된 유골.\n수집가는 그 아름다운 형광에 매료되어 낮과 밤을 보내며 감상하다가 결국 말라 죽었고, 최종적으로 그것의 동류가 되었다."
  },
  RelicConfig_70719_BattleDesc = {
    Text = "턴 시작 시 모든 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  RelicConfig_70719_Desc = {
    Text = "턴 시작 시 모든 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:프로토타입 배터리+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "휴대용 희망."
  },
  RelicConfig_70720_BattleDesc = {
    Text = "턴 시작 시, HP이 25% 미만이면 [Arg1] 임시<PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70720_Desc = {
    Text = "턴 시작 시, HP이 25% 미만이면 [Arg1] 임시<PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:최고의 영광>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "우아하고 신비로운 검은색 짧은 털 고양이, 어떤 먼 사막 국가에서 신의 화신으로 여겨졌다고 전해진다. 하지만 그 신의 이름은 이제 아무도 모른다. \n숭배받고, 존경받고, 잊혀지는 것이 신의 숙명일지도 모른다."
  },
  RelicConfig_70721_BattleDesc = {
    Text = "한 턴에 4번 “광기 폭발”을 방출하면 [Arg1] 행동력을 획득하고, 3턴의 재사용 대기시간 적용."
  },
  RelicConfig_70721_Desc = {
    Text = "한 턴에 4번 “광기 폭발”을 방출하면 [Arg1] 행동력을 획득하고, 3턴의 재사용 대기시간 적용."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:백은 차분기>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "“그것은 역사를 바꾸었습니다.”"
  },
  RelicConfig_70722_BattleDesc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <PowerIconKeywords:힘>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70722_Desc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <PowerIconKeywords:힘>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:우리의 집+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "그들은 이전에 함께 있었고, 이후에도 항상 함께 있을 것입니다. 그들은 서로를 사랑하는 한 가족입니다."
  },
  RelicConfig_70723_BattleDesc = {
    Text = "연속으로 2번 이전 카드보다 행동력 소모가 높은 카드를 사용할 때 [Arg1] <RetaliateIconKeywords:반격>을 획득하며, 각 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70723_Desc = {
    Text = "연속으로 2번 이전 카드보다 행동력 소모가 높은 카드를 사용할 때 [Arg1] <RetaliateIconKeywords:반격>을 획득하며, 각 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:아르카나 기록+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "운명의 흐름."
  },
  RelicConfig_70724_BattleDesc = {
    Text = "전투 시작 시 [Arg1] <PowerIconKeywords:힘> 획득."
  },
  RelicConfig_70724_Desc = {
    Text = "전투 시작 시 [Arg1] <PowerIconKeywords:힘> 획득."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:루비 브로치+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "어렴풋이 핏빛이 스며나온다."
  },
  RelicConfig_70725_BattleDesc = {
    Text = "전투 시작 후, 모든 적에게 [Arg1] 층<WeaknessIconKeywords:약화>를 부여하며, 보스 전투 시 효과가 두 배로 적용됩니다. 모든 깨어남체의 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_70725_Desc = {
    Text = "전투 시작 후, 모든 적에게 [Arg1] 층<WeaknessIconKeywords:약화>를 부여하며, 보스 전투 시 효과가 두 배로 적용됩니다. 모든 깨어남체의 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:악동+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "순수한 악에서 태어났지만, 그것의 의도는 아니었다."
  },
  RelicConfig_70726_BattleDesc = {
    Text = "소멸이 [Arg1] 방어막을 획득하고, 3턴의 재사용 대기시간."
  },
  RelicConfig_70726_Desc = {
    Text = "소멸이 [Arg1] 방어막을 획득하고, 3턴의 재사용 대기시간."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:초끈 회중시계>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "“어라, 포켓 워치가 멈췄네.”"
  },
  RelicConfig_70727_BattleDesc = {
    Text = "턴 종료 시 [Arg1] HP을 회복합니다."
  },
  RelicConfig_70727_Desc = {
    Text = "턴 종료 시 [Arg1] HP을 회복합니다."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:은혜의 피+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "그것은 달콤하고 부드러운 맛이 나며, 장미꽃 향기를 발산합니다."
  },
  RelicConfig_70728_BattleDesc = {
    Text = "정해 자세를 사용하여 모든 적에게 [Arg1] 점의 일시적인 <PowerIconKeywords:힘>을 잃게 합니다. 3 턴 쿨다운."
  },
  RelicConfig_70728_Desc = {
    Text = "정해 자세를 사용하여 모든 적에게 [Arg1] 점의 일시적인 <PowerIconKeywords:힘>을 잃게 합니다. 3 턴 쿨다운."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:무명의 의수+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "손에 찔리지 않도록 조심하세요."
  },
  RelicConfig_70730_BattleDesc = {
    Text = "전투 시작 시 [Arg1] <PowerIconKeywords:힘> 획득."
  },
  RelicConfig_70730_Desc = {
    Text = "전투 시작 시 [Arg1] <PowerIconKeywords:힘> 획득."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:루비 브로치>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "어렴풋이 핏빛이 스며나온다."
  },
  RelicConfig_70731_BattleDesc = {
    Text = "적의 공격을 받을 때 해당 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히며, 이 피해는 [Arg2]% <RetaliateIconKeywords:반격> 보너스의 적용을 받습니다. 각 적마다 매 턴 최대 1번 발동합니다."
  },
  RelicConfig_70731_Desc = {
    Text = "적의 공격을 받을 때 해당 적에게 아군 최대 HP의 [Arg3]%에 해당하는 <FixedDamage:순수 피해>를 입히며, 이 피해는 [Arg2]% <RetaliateIconKeywords:반격> 보너스의 적용을 받습니다. 각 적마다 매 턴 최대 1번 발동합니다."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:의식용 단검+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "날이 굽어진 단검. 주로 제사 의식에 사용된다."
  },
  RelicConfig_70732_BattleDesc = {
    Text = "초원차원 턴에 진입한 후, 첫 번째로 사용된 파생 명령 카드는 추가로 [Arg1] 회 발동됩니다."
  },
  RelicConfig_70732_Desc = {
    Text = "초원차원 턴에 진입한 후, 첫 번째로 사용된 파생 명령 카드는 추가로 [Arg1] 회 발동됩니다."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:빛나는 모래시계+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "측정 가능한 시간입니다."
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> 자동 획득량 증가 [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> 자동 획득량 증가 [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:역병 진단서+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "역병 —— 자연의 무의식적인 불안정한 상태의 우연한 표현."
  },
  RelicConfig_70734_BattleDesc = {
    Text = "은열쇠를 사용하여 깨어남하면 모든 깨어남체의 기본 피해가 [Arg1]% 증가하고 [Arg2]은열쇠 에너지를 획득합니다."
  },
  RelicConfig_70734_Desc = {
    Text = "은열쇠를 사용하여 깨어남하면 모든 깨어남체의 기본 피해가 [Arg1]% 증가하고 [Arg2]은열쇠 에너지를 획득합니다."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:신비한 성상의>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "우주의 신비."
  },
  RelicConfig_70735_BattleDesc = {
    Text = "연속 2회 이상 이전 카드보다 낮은 연산력 소비의 카드를 사용할 때 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 적용하며, 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70735_Desc = {
    Text = "연속 2회 이상 이전 카드보다 낮은 연산력 소비의 카드를 사용할 때 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 적용하며, 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:아르카나 유물+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "운명의 종언."
  },
  RelicConfig_70736_BattleDesc = {
    Text = "정해 자세를 사용하여 모든 적에게 [Arg1] 점의 일시적인 <PowerIconKeywords:힘>을 잃게 합니다. 3 턴 쿨다운."
  },
  RelicConfig_70736_Desc = {
    Text = "정해 자세를 사용하여 모든 적에게 [Arg1] 점의 일시적인 <PowerIconKeywords:힘>을 잃게 합니다. 3 턴 쿨다운."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:무명의 의수>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "손에 찔리지 않도록 조심하세요."
  },
  RelicConfig_70737_BattleDesc = {
    Text = "카드를 사용한 후, 손패 수가 [Arg1] 보다 작거나 같음 경우 [Arg2] 장의 카드를 뽑습니다. 매 턴 최대 [Arg3] 번까지 트리거됩니다."
  },
  RelicConfig_70737_Desc = {
    Text = "카드를 사용한 후, 손패 수가 [Arg1] 보다 작거나 같음 경우 [Arg2] 장의 카드를 뽑습니다. 매 턴 최대 [Arg3] 번까지 트리거됩니다."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:마법 장갑>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "“두려워하지 마, 이건 그냥 마법이야.”"
  },
  RelicConfig_70738_BattleDesc = {
    Text = "턴 종료 시 [Arg1] HP을 회복합니다."
  },
  RelicConfig_70738_Desc = {
    Text = "턴 종료 시 [Arg1] HP을 회복합니다."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:은혜의 피>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "그것은 달콤하고 부드러운 맛이 나며, 장미꽃 향기를 발산합니다."
  },
  RelicConfig_70739_BattleDesc = {
    Text = "은빛 열쇠를 깨어남 후 [Arg1] 방어막과 [Arg2] 은열쇠 에너지 획득."
  },
  RelicConfig_70739_Desc = {
    Text = "은빛 열쇠를 깨어남 후 [Arg1] 방어막과 [Arg2] 은열쇠 에너지 획득."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:나비 표본>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "지금까지 그는 누군가에게 깊이 사랑받고 있다."
  },
  RelicConfig_70740_BattleDesc = {
    Text = "은열쇠를 사용하여 깨어남하면 모든 깨어남체의 기본 피해가 [Arg1]% 증가하고 [Arg2]은열쇠 에너지를 획득합니다."
  },
  RelicConfig_70740_Desc = {
    Text = "은열쇠를 사용하여 깨어남하면 모든 깨어남체의 기본 피해가 [Arg1]% 증가하고 [Arg2]은열쇠 에너지를 획득합니다."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:신비한 성상의+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "우주의 신비."
  },
  RelicConfig_70741_BattleDesc = {
    Text = "최대 행동력이 [Arg1] 증가합니다."
  },
  RelicConfig_70741_Desc = {
    Text = "최대 행동력이 [Arg1] 증가합니다."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:활력 주사기+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "경련도 활성의 한 종류입니다."
  },
  RelicConfig_70742_BattleDesc = {
    Text = "전투 시작 시 최대 촉수 수량이 [Arg1] 증가하고, 촉수를 [Arg2]개 생성합니다."
  },
  RelicConfig_70742_Desc = {
    Text = "전투 시작 시 최대 촉수 수량이 [Arg1] 증가하고, 촉수를 [Arg2]개 생성합니다."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:바다의 노래>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "전해지는 바에 따르면, 조개류 등 섭취할 수 없는 동물들이 해양의 약 80%의 영양분을 흡수한다고 합니다."
  },
  RelicConfig_70743_BattleDesc = {
    Text = "매 턴 첫 번째 <DevouredIconKeywords:흡수> 시, 다른 깨어남체가 [Arg1]만큼의 광기를 획득합니다."
  },
  RelicConfig_70743_Desc = {
    Text = "매 턴 첫 번째 <DevouredIconKeywords:흡수> 시, 다른 깨어남체가 [Arg1]만큼의 광기를 획득합니다."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:황금빛 꿈나라>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "변화의 날이 바로 당신의 죽음의 날입니다."
  },
  RelicConfig_70744_BattleDesc = {
    Text = "비 파생 명령 카드를 사용한 후, 해당 카드의 연산력 소모를 2 줄이고 [Arg1] 장의 일시적 복제를 드로우 덱에 섞습니다. 3 턴 쿨다운."
  },
  RelicConfig_70744_Desc = {
    Text = "비 파생 명령 카드를 사용한 후, 해당 카드의 연산력 소모를 2 줄이고 [Arg1] 장의 일시적 복제를 드로우 덱에 섞습니다. 3 턴 쿨다운."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:소리 없는 축음기+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "그의 목소리가 바람에 사라졌다."
  },
  RelicConfig_70745_BattleDesc = {
    Text = "전투 시작 시 [Arg1] <RetaliateIconKeywords:반격> 획득, 리더 전투 효과 두 배."
  },
  RelicConfig_70745_Desc = {
    Text = "전투 시작 시 [Arg1] <RetaliateIconKeywords:반격> 획득, 리더 전투 효과 두 배."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:쐐기풀 조끼+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "오염된 액체를 구분할 수 없습니다."
  },
  RelicConfig_70746_BattleDesc = {
    Text = "턴 시작 시, HP이 25% 미만이면 [Arg1] 임시<PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70746_Desc = {
    Text = "턴 시작 시, HP이 25% 미만이면 [Arg1] 임시<PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:최고의 영광+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "우아하고 신비로운 검은색 짧은 털 고양이, 어떤 먼 사막 국가에서 신의 화신으로 여겨졌다고 전해진다. 하지만 그 신의 이름은 이제 아무도 모른다. \n숭배받고, 존경받고, 잊혀지는 것이 신의 숙명일지도 모른다."
  },
  RelicConfig_70747_BattleDesc = {
    Text = "카드를 사용한 후, 손패 수가 [Arg1] 보다 작거나 같음 경우 [Arg2] 장의 카드를 뽑습니다. 매 턴 최대 [Arg3] 번까지 트리거됩니다."
  },
  RelicConfig_70747_Desc = {
    Text = "카드를 사용한 후, 손패 수가 [Arg1] 보다 작거나 같음 경우 [Arg2] 장의 카드를 뽑습니다. 매 턴 최대 [Arg3] 번까지 트리거됩니다."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:마법 장갑+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "“두려워하지 마, 이건 그냥 마법이야.”"
  },
  RelicConfig_70748_BattleDesc = {
    Text = "은빛 열쇠를 깨어남 후 [Arg1] 방어막과 [Arg2] 은열쇠 에너지 획득."
  },
  RelicConfig_70748_Desc = {
    Text = "은빛 열쇠를 깨어남 후 [Arg1] 방어막과 [Arg2] 은열쇠 에너지 획득."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:나비 표본+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "지금까지 그는 누군가에게 깊이 사랑받고 있다."
  },
  RelicConfig_70749_BattleDesc = {
    Text = "매번 카드가 초원공간에 들어갈 때, 해당 카드의 소유자가 다른 초원공간의 카드 소유자와 다르다면 [Arg1] 장의 <DerivativeCardKeywords_4:“영감”>을 손에 넣습니다."
  },
  RelicConfig_70749_Desc = {
    Text = "매번 카드가 초원공간에 들어갈 때, 해당 카드의 소유자가 다른 초원공간의 카드 소유자와 다르다면 [Arg1] 장의 <DerivativeCardKeywords_4:“영감”>을 손에 넣습니다."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:알폰소의 기구+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "무상한 운명과는 달리, 별들이 자신의 운행 법칙을 가지고 있다."
  },
  RelicConfig_70750_BattleDesc = {
    Text = "연속으로 2번 이전 카드보다 행동력 소모가 높은 카드를 사용할 때 [Arg1] <RetaliateIconKeywords:반격>을 획득하며, 각 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70750_Desc = {
    Text = "연속으로 2번 이전 카드보다 행동력 소모가 높은 카드를 사용할 때 [Arg1] <RetaliateIconKeywords:반격>을 획득하며, 각 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:아르카나 기록>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "운명의 흐름."
  },
  RelicConfig_70751_BattleDesc = {
    Text = "은빛 열쇠를 깨어남 후 [Arg1] 행동력과 [Arg2] 은열쇠 에너지 획득."
  },
  RelicConfig_70751_Desc = {
    Text = "은빛 열쇠를 깨어남 후 [Arg1] 행동력과 [Arg2] 은열쇠 에너지 획득."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:미사그 배지>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "미사그 대학이 조사원에게 배포한 배지입니다. 이 배지는 착용자의 신분을 상징하는 것뿐만 아니라, 원격 통신이 가능한 도구이기도 합니다."
  },
  RelicConfig_70752_BattleDesc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <RetaliateIconKeywords:반격>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70752_Desc = {
    Text = "은빛 열쇠를 깨어남한 후 [Arg1] <RetaliateIconKeywords:반격>과 [Arg2] 은열쇠 에너지 를 획득합니다."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:선현의 기록>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "“인간은 얼마나 어리석은가，단지 구시대적이라는 이유로 맹신한다.”"
  },
  RelicConfig_70753_BattleDesc = {
    Text = "전투 시작 후 모든 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하며, 보스전에서는 효과가 2배이다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  RelicConfig_70753_Desc = {
    Text = "전투 시작 후 모든 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하며, 보스전에서는 효과가 2배이다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:봄의 제전+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "밤의 웃음소리 속에서 카누의 실타래루엣이 호수 위를 자유롭게 미끄러졌다."
  },
  RelicConfig_70754_BattleDesc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_70754_Desc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:피로 물든 조약돌>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "하나, 둘, 셋, 넷, 다섯."
  },
  RelicConfig_70755_BattleDesc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_70755_Desc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:실타래올 마노+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "일반적인 마노의 무늬일 거예요. 아마도."
  },
  RelicConfig_70756_BattleDesc = {
    Text = "은열쇠 깨어남 후 행동력 [Arg1]pt와 은열쇠 에너지 [Arg2] 획득."
  },
  RelicConfig_70756_Desc = {
    Text = "은열쇠 깨어남 후 행동력 [Arg1]pt와 은열쇠 에너지 [Arg2] 획득."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:미사그 배지+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "미사그 대학이 조사원에게 배포한 배지입니다. 이 배지는 착용자의 신분을 상징하는 것뿐만 아니라, 원격 통신이 가능한 도구이기도 합니다."
  },
  RelicConfig_70757_BattleDesc = {
    Text = "노도 자세를 사용하여 즉시 모든 촉수를 적에게 공격하게 하여 [Arg1] 회 공격, 3 턴 쿨다운。"
  },
  RelicConfig_70757_Desc = {
    Text = "노도 자세를 사용하여 즉시 모든 촉수를 적에게 공격하게 하여 [Arg1] 회 공격, 3 턴 쿨다운。"
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:나선의 황홀>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "영원한 잠의 주인이, 꿈 속에서 너를 기다리노라."
  },
  RelicConfig_70758_BattleDesc = {
    Text = "연속 2회 이상 이전 카드보다 낮은 연산력 소비의 카드를 사용할 때 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 적용하며, 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70758_Desc = {
    Text = "연속 2회 이상 이전 카드보다 낮은 연산력 소비의 카드를 사용할 때 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 적용하며, 턴당 최대 3회까지 발동합니다."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:아르카나 유물>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "운명의 종언."
  },
  RelicConfig_70759_BattleDesc = {
    Text = "전투 시작 후, 모든 적에게 [Arg1] 층<WeaknessIconKeywords:약화>를 부여하며, 보스 전투 시 효과가 두 배로 적용됩니다. 모든 깨어남체의 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_70759_Desc = {
    Text = "전투 시작 후, 모든 적에게 [Arg1] 층<WeaknessIconKeywords:약화>를 부여하며, 보스 전투 시 효과가 두 배로 적용됩니다. 모든 깨어남체의 기본 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:악동>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "순수한 악에서 태어났지만, 그것의 의도는 아니었다."
  },
  RelicConfig_70760_BattleDesc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하며, 보스 전투에서는 효과가 두 배로 적용됩니다."
  },
  RelicConfig_70760_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하며, 보스 전투에서는 효과가 두 배로 적용됩니다."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:신경 독소>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "추출, 정제."
  },
  RelicConfig_70761_BattleDesc = {
    Text = "전투 시작 후 모든 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하며, 보스전에서는 효과가 2배이다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  RelicConfig_70761_Desc = {
    Text = "전투 시작 후 모든 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하며, 보스전에서는 효과가 2배이다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:봄의 제전>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "밤의 웃음소리 속에서 카누의 실타래루엣이 호수 위를 자유롭게 미끄러졌다."
  },
  RelicConfig_70762_BattleDesc = {
    Text = "한 턴에 4번 “광기 폭발”을 방출하면 [Arg1] 행동력을 획득하고, 3턴의 재사용 대기시간 적용."
  },
  RelicConfig_70762_Desc = {
    Text = "한 턴에 4번 “광기 폭발”을 방출하면 [Arg1] 행동력을 획득하고, 3턴의 재사용 대기시간 적용."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:백은 차분기+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "“그것은 역사를 바꾸었습니다.”"
  },
  RelicConfig_70763_BattleDesc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70763_Desc = {
    Text = "“광기 폭발”을 시전한 후, [Arg1] 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:무거운 자물쇠>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "두꺼우면서도 견고한 자물쇠는, 만약 키가 없다면 아마도 열기 어려울 것입니다. \n물론, 이것은 어떤 도둑에게는 별로 중요하지 않다."
  },
  RelicConfig_70764_BattleDesc = {
    Text = "적의 공격을 받을 때 해당 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히며, 이 피해는 [Arg2]% <RetaliateIconKeywords:반격> 보너스의 적용을 받습니다. 각 적마다 매 턴 최대 1번 발동합니다."
  },
  RelicConfig_70764_Desc = {
    Text = "적의 공격을 받을 때 해당 적에게 아군 최대 HP의 [Arg3]%에 해당하는 <FixedDamage:순수 피해>를 입히며, 이 피해는 [Arg2]% <RetaliateIconKeywords:반격> 보너스의 적용을 받습니다. 각 적마다 매 턴 최대 1번 발동합니다."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:의식용 단검>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "날이 굽어진 단검. 주로 제사 의식에 사용된다."
  },
  RelicConfig_70765_BattleDesc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_70765_Desc = {
    Text = "피해를 줄 때마다 [Arg1] 임시 <PowerIconKeywords:힘>을 획득하며, 턴당 최대 15번까지 발동됩니다."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:실타래올 마노>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "일반적인 마노의 무늬일 거예요. 아마도."
  },
  RelicConfig_70766_BattleDesc = {
    Text = "턴이 시작될 때, 생명이 25% 미만이면 [Arg1]  방어막을 획득합니다."
  },
  RelicConfig_70766_Desc = {
    Text = "턴이 시작될 때, 생명이 25% 미만이면 [Arg1]  방어막을 획득합니다."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:수호의 손>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "기도의 손，견고한 주먹."
  },
  RelicConfig_70767_BattleDesc = {
    Text = "소멸로 인해 가장 낮은 광기의 깨어남체가 [Arg1] 광기를 획득하며, 3 턴 쿨다운입니다."
  },
  RelicConfig_70767_Desc = {
    Text = "소멸로 인해 가장 낮은 광기의 깨어남체가 [Arg1] 광기를 획득하며, 3 턴 쿨다운입니다."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:시간 벌레>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "시계점과 곤충 박물관에 동시에 존재하는 포켓워치입니다. \n홍적 원년 이후, 대학의 소장품으로 편입되었습니다."
  },
  RelicConfig_70768_BattleDesc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체가 가하는 <RetaliateIconKeywords:반격>과 유물이 가하는 <RetaliateIconKeywords:반격>이 [Arg2]% 상승합니다."
  },
  RelicConfig_70768_Desc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체가 가하는 <RetaliateIconKeywords:반격>과 유물이 가하는 <RetaliateIconKeywords:반격>이 [Arg2]% 상승합니다."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:숨김 없는 전달자+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "그것은 수많은 주동적이거나 수동적으로 말해진 비밀을 전달한다."
  },
  RelicConfig_70769_BattleDesc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_70769_Desc = {
    Text = "매 턴 처음으로 직접 “태아”를 사용한 후, 해당 턴 내에서 능동 피해가 [Arg1]% 피해량의 <BleedingIconKeywords:출혈>을 일으킵니다."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:피로 물든 조약돌+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "하나, 둘, 셋, 넷, 다섯."
  },
  RelicConfig_70770_BattleDesc = {
    Text = "턴 시작 시 [Arg1]장의 카드를 뽑습니다."
  },
  RelicConfig_70770_Desc = {
    Text = "턴 시작 시 [Arg1]장의 카드를 뽑습니다."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:정밀 나침반>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "지시하는 것은 방향이 아니라 자기장입니다."
  },
  RelicConfig_70771_BattleDesc = {
    Text = "“타격”은 추가로 2회 [Arg1]% 깨어남체 공격력의 피해를 입혀, 턴당 최대 3회까지 발동됩니다."
  },
  RelicConfig_70771_Desc = {
    Text = "“타격”은 추가로 2회 [Arg1]% 깨어남체 공격력의 피해를 입혀, 턴당 최대 3회까지 발동됩니다."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:녹슨 메스+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "생체를 자르는 데 적합하지 않습니다."
  },
  RelicConfig_70772_BattleDesc = {
    Text = "은열쇠로 깨어남 후 [Arg1]장의 카드를 뽑고 [Arg2]의 은열쇠 에너지 획득."
  },
  RelicConfig_70772_Desc = {
    Text = "은열쇠로 깨어남 후 [Arg1]장의 카드를 뽑고 [Arg2]의 은열쇠 에너지 획득."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:새 지갑>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "미사그 대학의 문장이 새겨진 가죽 지갑입니다. \n지금은 비어 있어 아무것도 없습니다."
  },
  RelicConfig_70774_BattleDesc = {
    Text = "매 턴 처음 5번의 피해량이 [Arg1]% 증가합니다."
  },
  RelicConfig_70774_Desc = {
    Text = "매 턴 처음 5번의 피해량이 [Arg1]% 증가합니다."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:시력 교정기>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "누군가가 그것을 통해 진실타래을 찾았습니다."
  },
  RelicConfig_70776_BattleDesc = {
    Text = "전투 시작 시 [Arg1] <RetaliateIconKeywords:반격> 획득, 리더 전투 효과 두 배."
  },
  RelicConfig_70776_Desc = {
    Text = "전투 시작 시 [Arg1] <RetaliateIconKeywords:반격> 획득, 리더 전투 효과 두 배."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:쐐기풀 조끼>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "오염된 액체를 구분할 수 없습니다."
  },
  RelicConfig_70777_BattleDesc = {
    Text = "한 턴 내에 4장의 다른 웨이크업 바디에 속한 명령 카드를 사용하면 모든 깨어남이 [Arg1] 광기를 획득하며, 3턴 쿨다운."
  },
  RelicConfig_70777_Desc = {
    Text = "한 턴 내에 4장의 다른 웨이크업 바디에 속한 명령 카드를 사용하면 모든 깨어남이 [Arg1] 광기를 획득하며, 3턴 쿨다운."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:이름 없는 신의 베일>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "신을 직시할 수 없다."
  },
  RelicConfig_70778_BattleDesc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하며, 보스 전투에서는 효과가 두 배로 적용됩니다."
  },
  RelicConfig_70778_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하며, 보스 전투에서는 효과가 두 배로 적용됩니다."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:신경 독소+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "추출, 정제."
  },
  RelicConfig_70779_BattleDesc = {
    Text = "은열쇠를 사용해 깨어남한 후 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하고 [Arg2] 은열쇠 에너지 획득합니다。"
  },
  RelicConfig_70779_Desc = {
    Text = "은열쇠를 사용해 깨어남한 후 모든 적에게 [Arg1] <IntoxicationIconKeywords:중독>을 부여하고 [Arg2] 은열쇠 에너지 획득합니다。"
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:의심스러운 연고>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "집에서 만든 외상용 연고입니다. 의사의 지시 없이 사용하지 마십시오."
  },
  RelicConfig_70780_BattleDesc = {
    Text = "“타격”이 피해를 입히고 [Arg1]%의 <IntoxicationIconKeywords:중독>을 부여하며, 매 턴 최대 [Arg2] pt까지."
  },
  RelicConfig_70780_Desc = {
    Text = "“타격”이 피해를 입히고 [Arg1]%의 <IntoxicationIconKeywords:중독>을 부여하며, 매 턴 최대 [Arg2] pt까지."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:이형의 목소리>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "그는 악마는 아니지만, 그는 인생 너머의 저어를 전달합니다."
  },
  RelicConfig_70781_BattleDesc = {
    Text = "턴이 시작될 때, 생명이 25% 미만이면 [Arg1]  방어막을 획득합니다."
  },
  RelicConfig_70781_Desc = {
    Text = "턴이 시작될 때, 생명이 25% 미만이면 [Arg1]  방어막을 획득합니다."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:수호의 손+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "기도의 손，견고한 주먹."
  },
  RelicConfig_70782_BattleDesc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_70782_Desc = {
    Text = "HP을 잃을 때마다 [Arg1]%의 HP 손실타래량에 대한 진홍색 용광로를 획득합니다."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:녹슨 톱+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "해부의사는 평생 아름다운 여자를 볼 수 없고, 오직 뼈 더미와 질병으로 인해 염증이 생긴 신경, 근육 및 조직만 볼 수 있다."
  },
  RelicConfig_70783_BattleDesc = {
    Text = "매 턴 처음 5번의 피해량이 [Arg1]% 증가합니다."
  },
  RelicConfig_70783_Desc = {
    Text = "매 턴 처음 5번의 피해량이 [Arg1]% 증가합니다."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:시력 교정기+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "누군가가 그것을 통해 진실타래을 찾았습니다."
  },
  RelicConfig_70784_BattleDesc = {
    Text = "매번 카드가 초원공간에 들어갈 때, 해당 카드의 소유자가 다른 초원공간의 카드 소유자와 다르다면 [Arg1] 장의 <DerivativeCardKeywords_4:“영감”>을 손에 넣습니다."
  },
  RelicConfig_70784_Desc = {
    Text = "매번 카드가 초원공간에 들어갈 때, 해당 카드의 소유자가 다른 초원공간의 카드 소유자와 다르다면 [Arg1] 장의 <DerivativeCardKeywords_4:“영감”>을 손에 넣습니다."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:알폰소의 기구>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "무상한 운명과는 달리, 별들이 자신의 운행 법칙을 가지고 있다."
  },
  RelicConfig_70785_BattleDesc = {
    Text = "한 턴 내에 4장의 다른 웨이크업 바디에 속한 명령 카드를 사용하면 모든 깨어남이 [Arg1] 광기를 획득하며, 3턴 쿨다운."
  },
  RelicConfig_70785_Desc = {
    Text = "한 턴 내에 4장의 다른 웨이크업 바디에 속한 명령 카드를 사용하면 모든 깨어남이 [Arg1] 광기를 획득하며, 3턴 쿨다운."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:이름 없는 신의 베일+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "신을 직시할 수 없다."
  },
  RelicConfig_70786_BattleDesc = {
    Text = "턴 종료 시 조수 태세일 경우 <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가합니다. 증가한다. 쿨타임 3턴."
  },
  RelicConfig_70786_Desc = {
    Text = "턴 종료 시 조수 태세일 경우 <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가한다. 쿨타임 3턴."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:균열 유충>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "우리의 뇌가 여전히 미스터리라면, 그 안에 촉수가 가득해도 놀랄 일이 아니다."
  },
  RelicConfig_70787_BattleDesc = {
    Text = "모든 깨어남체가 주는 기본 피해가 [Arg1]% 증가합니다."
  },
  RelicConfig_70787_Desc = {
    Text = "모든 깨어남체가 주는 기본 피해가 [Arg1]% 증가합니다."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:울음 파이프+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "이는 과연 증오의 산물인지, 아니면 복수의 결과인지?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "은열쇠 깨어남 후 모든 깨어남체가 광기 [Arg1]pt와 은열쇠 에너지 [Arg2] 획득."
  },
  RelicConfig_70788_Desc = {
    Text = "은열쇠 깨어남 후 모든 깨어남체가 광기 [Arg1]pt와 은열쇠 에너지 [Arg2] 획득."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:월계수잎 소매단추>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "은제로 제작된 계엽 문양이 새겨진 소매단추입니다. \n정교하게 만들어져 반짝이는 광채를 띠며, 과거에는 두 아이의 우정을 담고 있었습니다."
  },
  RelicConfig_70789_BattleDesc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체와 유물이 입히는 <IntoxicationIconKeywords:중독> 효과가 [Arg2]% 증가합니다."
  },
  RelicConfig_70789_Desc = {
    Text = "전투 시작 후, [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 획득합니다. 모든 깨어남체와 유물이 입히는 <IntoxicationIconKeywords:중독> 효과가 [Arg2]% 증가합니다."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:먼지 낀 재봉틀>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "자비로운 어머니가 심장의 상처를 봉합합니다."
  },
  RelicConfig_70790_BattleDesc = {
    Text = "소멸로 인해 가장 낮은 광기의 깨어남체가 [Arg1] 광기를 획득하며, 3 턴 쿨다운입니다."
  },
  RelicConfig_70790_Desc = {
    Text = "소멸로 인해 가장 낮은 광기의 깨어남체가 [Arg1] 광기를 획득하며, 3 턴 쿨다운입니다."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:시간 벌레+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "시계점과 곤충 박물관에 동시에 존재하는 포켓워치입니다. \n홍적 원년 이후, 대학의 소장품으로 편입되었습니다."
  },
  RelicConfig_70791_BattleDesc = {
    Text = "전투 시작 시 최대 촉수 수량이 [Arg1] 증가하고, 촉수를 [Arg2]개 생성합니다."
  },
  RelicConfig_70791_Desc = {
    Text = "전투 시작 시 최대 촉수 수량이 [Arg1] 증가하고, 촉수를 [Arg2]개 생성합니다."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:바다의 노래+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "전해지는 바에 따르면, 조개류 등 섭취할 수 없는 동물들이 해양의 약 80%의 영양분을 흡수한다고 합니다."
  },
  RelicConfig_70792_BattleDesc = {
    Text = "턴 종료 시 조수 태세일 경우 <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가한다. 쿨타임 3턴."
  },
  RelicConfig_70792_Desc = {
    Text = "턴 종료 시 조수 태세일 경우 <TentacleInjurieIconKeywords:촉수 피해>가 [Arg1] 증가한다. 쿨타임 3턴."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:균열 유충+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "우리의 뇌가 여전히 미스터리라면, 그 안에 촉수가 가득해도 놀랄 일이 아니다."
  },
  RelicConfig_70793_BattleDesc = {
    Text = "매 턴 첫 번째 <DevouredIconKeywords:흡수> 시, 다른 깨어남체가 [Arg1]만큼의 광기를 획득합니다."
  },
  RelicConfig_70793_Desc = {
    Text = "매 턴 첫 번째 <DevouredIconKeywords:흡수> 시, 다른 깨어남체가 [Arg1]만큼의 광기를 획득합니다."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:황금빛 꿈나라+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "변화의 날이 바로 당신의 죽음의 날입니다."
  },
  RelicConfig_70794_BattleDesc = {
    Text = "소멸이 [Arg1] 방어막을 획득하고, 3턴의 재사용 대기시간."
  },
  RelicConfig_70794_Desc = {
    Text = "소멸이 [Arg1] 방어막을 획득하고, 3턴의 재사용 대기시간."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:초끈 회중시계+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "“어라, 포켓 워치가 멈췄네.”"
  },
  RelicConfig_70795_BattleDesc = {
    Text = "비 파생 명령 카드를 사용한 후, 해당 카드의 연산력 소모를 2 줄이고 [Arg1] 장의 일시적 복제를 드로우 덱에 섞습니다. 3 턴 쿨다운."
  },
  RelicConfig_70795_Desc = {
    Text = "비 파생 명령 카드를 사용한 후, 해당 카드의 연산력 소모를 2 줄이고 [Arg1] 장의 일시적 복제를 드로우 덱에 섞습니다. 3 턴 쿨다운."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:소리 없는 축음기>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "그의 목소리가 바람에 사라졌다."
  },
  RelicConfig_70796_BattleDesc = {
    Text = "「광기 폭발」 사용 후 모든 적에게 [Arg1] 포인트의 <FixedDamage:순수 피해>를 입히고, [Arg2]% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  RelicConfig_70796_Desc = {
    Text = "「광기 폭발」 사용 후 모든 적에게 아군 최대 HP의 [Arg2]%에 해당하는 <FixedDamage:순수 피해>를 1회 입히고, [Arg2]% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:라듐 턱뼈+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "어느 수집가의 사설 전시실타래에 전시된 유골.\n수집가는 그 아름다운 형광에 매료되어 낮과 밤을 보내며 감상하다가 결국 말라 죽었고, 최종적으로 그것의 동류가 되었다."
  },
  RelicConfig_70797_BattleDesc = {
    Text = "최대 행동력이 [Arg1] 증가합니다."
  },
  RelicConfig_70797_Desc = {
    Text = "최대 행동력이 [Arg1] 증가합니다."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:활력 주사기>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "경련도 활성의 한 종류입니다."
  },
  RelicConfig_70798_BattleDesc = {
    Text = "노도 자세를 사용하여 즉시 모든 촉수를 적에게 공격하게 하여 [Arg1] 회 공격, 3 턴 쿨다운。"
  },
  RelicConfig_70798_Desc = {
    Text = "노도 자세를 사용하여 즉시 모든 촉수를 적에게 공격하게 하여 [Arg1] 회 공격, 3 턴 쿨다운。"
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:나선의 황홀+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "영원한 잠의 주인이, 꿈 속에서 너를 기다리노라."
  },
  RelicConfig_70799_BattleDesc = {
    Text = "방어가 [Arg1] 임시<RetaliateIconKeywords:반격>을 획득합니다. 매 턴 최대 3회까지 발동됩니다."
  },
  RelicConfig_70799_Desc = {
    Text = "방어가 [Arg1] 임시<RetaliateIconKeywords:반격>을 획득합니다. 매 턴 최대 3회까지 발동됩니다."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:고인의 회중시계+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "추억과 감상에 젖어 미지로 나아갑니다."
  },
  RelicConfig_70800_BattleDesc = {
    Text = "방어가 [Arg1] 임시<RetaliateIconKeywords:반격>을 획득합니다. 매 턴 최대 3회까지 발동됩니다."
  },
  RelicConfig_70800_Desc = {
    Text = "방어가 [Arg1] 임시<RetaliateIconKeywords:반격>을 획득합니다. 매 턴 최대 3회까지 발동됩니다."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:고인의 회중시계>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "추억과 감상에 젖어 미지로 나아갑니다."
  },
  RelicConfig_70986_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 2개의 유물 중 1개를 선택하여 획득, 5개의 홀수 턴 동안 지속."
  },
  RelicConfig_70986_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 2개의 유물 중 1개를 선택하여 획득, 5개의 홀수 턴 동안 지속."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:시계추「기원 η」>"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 2개의 유물 중 1개를 선택하여 획득, 5개의 홀수 턴 동안 지속."
  },
  RelicConfig_70987_Desc = {
    Text = "전투 시작 시, 행동력 상한 +1, 모든 깨어남체를 깨어남. 홀수 턴 시작 시, 2개의 유물 중 1개를 선택하여 획득, 5개의 홀수 턴 동안 지속."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:시계추「기원 ζ」>"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "턴 시작 시 회귀·라모나가 광기를 [Arg1] 획득한다. 매 턴 최초로 「반복」이 발동될 때, 은열쇠 에너지 [Arg2]pt와 「음엔트로피」 [Arg3]스택을 획득한다."
  },
  RelicConfig_71195_Desc = {
    Text = "턴 시작 시 회귀·라모나가 광기를 [Arg1] 획득한다. 매 턴 최초로 「반복」이 발동될 때, 은열쇠 에너지 [Arg2]pt와 「음엔트로피」 [Arg3]스택을 획득한다."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:차원 영상 · 회귀·라모나>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "턴 시작 시 로탄은 [Arg1] 광기를 획득합니다. 매 턴 처음으로 로탄의 “방어”를 발동한 후, [Arg2] 장의 소모와 공허가 부여된 “고집스러운 검”을 손에 추가합니다."
  },
  RelicConfig_71196_Desc = {
    Text = "턴 시작 시 로탄은 [Arg1] 광기를 획득합니다. 매 턴 처음으로 로탄의 “방어”를 발동한 후, [Arg2] 장의 소모와 공허가 부여된 “고집스러운 검”을 손에 추가합니다."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:차원 영상 · 로탄>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "턴 시작 시 라모나는 [Arg1] 광기를 획득합니다. 매 [Arg2]번째로 라모나의 명령 카드를 사용할 때, 해당 명령 카드가 추가로 1회 발동하고 [Arg3] 점의 은열쇠 에너지 획득합니다."
  },
  RelicConfig_71197_Desc = {
    Text = "턴 시작 시 라모나는 [Arg1] 광기를 획득합니다. 매 [Arg2]번째로 라모나의 명령 카드를 사용할 때, 해당 명령 카드가 추가로 1회 발동하고 [Arg3] 점의 은열쇠 에너지 획득합니다."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:차원 영상 · 라모나>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "턴 시작 시 레아는 [Arg1] 광기를 획득합니다. HP을 잃을 때마다 [Arg2] 힘을 획득하며, 각 전투에서 최대 [Arg3] 회까지 중첩됩니다. [Arg3] 회 중첩된 후, “고통과 환희”의 행동력 소모가 2로 줄어들고, 피해 횟수가 1 증가합니다."
  },
  RelicConfig_71230_Desc = {
    Text = "턴 시작 시 레아는 [Arg1] 광기를 획득합니다. HP을 잃을 때마다 [Arg2] 힘을 획득하며, 각 전투에서 최대 [Arg3] 회까지 중첩됩니다. [Arg3] 회 중첩된 후, “고통과 환희”의 행동력 소모가 2로 줄어들고, 피해 횟수가 1 증가합니다."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:차원 영상 · 레아>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "턴 시작 시 오레타는 [Arg1] 광기를 획득합니다. “선체 분열” 피해 횟수가 [Arg2]만큼 증가하며, 오레타의 “방어”를 사용한 후 1장의 “선체 분열”을 손에 추가합니다."
  },
  RelicConfig_71231_Desc = {
    Text = "턴 시작 시 오레타는 [Arg1] 광기를 획득합니다. “선체 분열” 피해 횟수가 [Arg2]만큼 증가하며, 오레타의 “방어”를 사용한 후 1장의 “선체 분열”을 손에 추가합니다."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:차원 영상 · 오레타>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "턴 시작 시 틴커트는 [Arg1] 광기를 획득합니다. 틴커트의 명령 카드가 점프를 유발한 후, 이를 손으로 반환하고 출전 전 행동력 소모를 -1로 감소시킵니다. 매 턴 최대 [Arg2] 번 발동됩니다."
  },
  RelicConfig_71232_Desc = {
    Text = "턴 시작 시 틴커트는 [Arg1] 광기를 획득합니다. 틴커트의 명령 카드가 점프를 유발한 후, 이를 손으로 반환하고 출전 전 행동력 소모를 -1로 감소시킵니다. 매 턴 최대 [Arg2] 번 발동됩니다."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:차원 영상 · 틴커트>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "턴 시작 시 노틸라가 [Arg1] 광기를 획득합니다. 노틸라의 “광기 폭발”을 사용한 후 현재 방어막의 [Arg2]%와 동일한 반격과 지연 실타래드를 획득하며, 매 턴 최대 1회까지 발동됩니다."
  },
  RelicConfig_71233_Desc = {
    Text = "턴 시작 시 노틸라가 [Arg1] 광기를 획득합니다. 노틸라의 “광기 폭발”을 사용한 후 현재 방어막의 [Arg2]%와 동일한 반격과 지연 실타래드를 획득하며, 매 턴 최대 1회까지 발동됩니다."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:차원 영상 · 노틸라>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "턴 시작 시 융해·돌은 [Arg1] 광기를 획득합니다. 용해 돌이 광기 폭발을 사용한 후, 다른 깨어남체들은 [Arg2] 광기를 소모할 때마다 1 광기를 획득합니다."
  },
  RelicConfig_71234_Desc = {
    Text = "턴 시작 시 융해·돌은 [Arg1] 광기를 획득합니다. 용해 돌이 광기 폭발을 사용한 후, 다른 깨어남체들은 [Arg2] 광기를 소모할 때마다 1 광기를 획득합니다."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:차원 영상 · 융해·돌>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "턴 시작 시 히로는 [Arg1] 광기를 획득합니다. 매번 1장의 카드가 버려질 때마다 히로는 [Arg2] 점의 광기를 획득합니다."
  },
  RelicConfig_71235_Desc = {
    Text = "턴 시작 시 히로는 [Arg1] 광기를 획득합니다. 매번 1장의 카드가 버려질 때마다 히로는 [Arg2] 점의 광기를 획득합니다."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:차원 영상 · 히로>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "턴 시작 시 다포딜은 [Arg1]의 광기와 1장의 “영감”을 획득합니다. “이질적 파도”가 얻는 힘이 [Arg2]% 증가하며, 매번 사용 시 이번 탐색에서 추가로 영구적으로 [Arg3]% 증가하고, 최대 [Arg4]%까지 증가합니다."
  },
  RelicConfig_71236_Desc = {
    Text = "턴 시작 시 다포딜은 [Arg1] 광기와 1장의 “영감”을 획득합니다. “이질적 파도”가 얻는 힘이 [Arg2]% 증가하며, 매번 사용 시 이번 탐색에서 추가로 영구적으로 [Arg3]% 증가하고, 최대 [Arg4]%까지 증가합니다."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:차원 영상 · 다포딜>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "턴 시작 시 완다는 [Arg1] 광기를 받고 [Arg2] 층의「꿈 인도」를 획득합니다. 현재 차원 턴이라면 임시「가시 척추 사슬」 및「미로의 수호」카드를 1장씩 손에 추가하고, 완다의 다음 명령 카드를 두 번 발동시킵니다."
  },
  RelicConfig_71237_Desc = {
    Text = "턴 시작 시 완다는 [Arg1] 광기를 받고 [Arg2] 층의「꿈 인도」를 획득합니다. 현재 차원 턴이라면 임시「가시 척추 사슬」 및「미로의 수호」카드를 1장씩 손에 추가하고, 완다의 다음 명령 카드를 두 번 발동시킵니다."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:차원 영상 · 완다>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "턴 시작 시 아그리파는 [Arg1] 광기를 획득합니다. “불내의 시혜”는 아그리파가 이번 턴 중에 산출 비용을 [Arg2] 줄이게 만들며, 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_71238_Desc = {
    Text = "턴 시작 시 아그리파는 [Arg1] 광기를 획득합니다. “불내의 시혜”는 아그리파가 이번 턴 중에 산출 비용을 [Arg2] 줄이게 만들며, 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:차원 영상 · 아그리파>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "턴 시작 시 “24”는 [Arg1] 광기를 획득합니다. 턴 시작 시 “24”가 “우울증” 상태일 경우 추가로 [Arg2] 광기를 획득하며, “조울증” 상태일 경우 “24”의 임시 크리티컬 확률과 임시 크리티컬 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_71239_Desc = {
    Text = "턴 시작 시 “24”는 [Arg1] 광기를 획득합니다. 턴 시작 시 “24”가 “우울증” 상태일 경우 추가로 [Arg2] 광기를 획득하며, “조울증” 상태일 경우 “24”의 임시 크리티컬 확률과 임시 크리티컬 피해가 [Arg2]% 증가합니다."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:차원 영상 · 「24」>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "턴 시작 시 리즈는 [Arg1] 광기를 획득합니다. ‘죽음의 춤’으로 버린 카드는 추가로 1번 발동하며, 3턴의 재사용 대기시간이 적용됩니다."
  },
  RelicConfig_71240_Desc = {
    Text = "턴 시작 시 리즈는 [Arg1] 광기를 획득합니다. ‘죽음의 춤’으로 버린 카드는 추가로 1번 발동하며, 3턴의 재사용 대기시간이 적용됩니다."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:차원 영상 · 리즈>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "턴 시작 시 혈쇄·히로는 [Arg1] 광기를 획득합니다. 혈쇄·히로의 공격 시 피해에는 [Arg2]% 출혈이 추가되며, 적을 킬한 후 다른 적에게 추가 피해와 동일한 출혈을 입힙니다."
  },
  RelicConfig_71241_Desc = {
    Text = "턴 시작 시 혈쇄·히로는 [Arg1] 광기를 획득합니다. 혈쇄·히로의 공격 시 피해에는 [Arg2]% 출혈이 추가되며, 적을 킬한 후 다른 적에게 추가 피해와 동일한 출혈을 입힙니다."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:차원 영상 · 혈쇄·히로>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "턴 시작 시 셀레스트가 [Arg1] 광기를 획득합니다. 턴이 종료되기 전, 손패에 남아있는 셀레스트의 명령 카드 1장마다 촉수 1개가 적을 공격하고 HP를 [Arg2] 회복합니다."
  },
  RelicConfig_71242_Desc = {
    Text = "턴 시작 시 셀레스트가 [Arg1] 광기를 획득합니다. 턴이 종료되기 전, 손패에 남아있는 셀레스트의 명령 카드 1장마다 촉수 1개가 적을 공격하고 HP를 [Arg2] 회복합니다."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:차원 영상 · 셀레스트>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "턴 시작 시 카시아는 [Arg1] 광기를 획득합니다. 매 1장의 카드를 뽑을 때마다 카시아는 [Arg2] 광기를 획득합니다. 카시아가 광기 폭발을 방출할 때 모든 적은 [Arg3] 힘을 잃습니다."
  },
  RelicConfig_71243_Desc = {
    Text = "턴 시작 시 카시아는 [Arg1] 광기를 획득합니다. 매 1장의 카드를 뽑을 때마다 카시아는 [Arg2] 광기를 획득합니다. 카시아가 광기 폭발을 방출할 때 모든 적은 [Arg3] 힘을 잃습니다."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:차원 영상 · 카시아>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "턴 시작 시 소렐은 [Arg1] 광기를 획득합니다. 소렐이 1번 피해를 입힐 때마다 배아 융합 +[Arg2]%, 각 턴당 최대 [Arg3]번까지 적용됩니다. 10번 적용된 후 소렐의 본 전투 최종 피해 +[Arg4]%가 됩니다."
  },
  RelicConfig_71244_Desc = {
    Text = "턴 시작 시 소렐은 [Arg1] 광기를 획득합니다. 소렐이 1번 피해를 입힐 때마다 배아 융합 +[Arg2]%, 각 턴당 최대 [Arg3]번까지 적용됩니다. 10번 적용된 후 소렐의 본 전투 최종 피해 +[Arg4]%가 됩니다."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:차원 영상 · 소렐>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "턴 시작 시 오지에는 [Arg1]의 광기를 얻는다. 턴마다 최초로 오지에의 \"관통의 총\" 또는 \"타격\"을 시전한 후, 오지에가 이번 턴에 생성한 보호막과 힘이 [Arg2]% 증가한다."
  },
  RelicConfig_71245_Desc = {
    Text = "턴 시작 시 오지에는 [Arg1]의 광기를 얻는다. 턴마다 최초로 오지에의 \"관통의 총\" 또는 \"타격\"을 시전한 후, 오지에가 이번 턴에 생성한 보호막과 힘이 [Arg2]% 증가한다."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:차원 영상 · 오지에>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "턴 시작 시 엘바는 [Arg1] 광기를 획득합니다. 엘바가 1턴 내에 [Arg2] 장의 “방어”를 사용하면, 1장의 소모된 “심안의 칼날”을 손에 추가합니다; [Arg3] 장의 “타격”을 사용하면, 1장의 소모된 “임전 태세”를 손에 추가합니다."
  },
  RelicConfig_71246_Desc = {
    Text = "턴 시작 시 엘바는 [Arg1]의 광기를 획득합니다. 엘바가 1턴 내에 [Arg2] 장의 “방어”를 사용하면, 1장의 소모된 “심안의 칼날”을 손에 추가합니다; [Arg3] 장의 “타격”을 사용하면, 1장의 소모된 “임전 태세”를 손에 추가합니다."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:차원 영상 · 엘바>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "턴 시작 시 젠킨이 [Arg1] 광기를 획득하고, 최종 피해가 [Arg2]% 증가합니다. 「브라운 출동!」의 기본 피해와 피해 증가량이 [Arg3]% 증가합니다."
  },
  RelicConfig_71247_Desc = {
    Text = "턴 시작 시 젠킨이 [Arg1] 광기를 획득하고, 최종 피해가 [Arg2]% 증가합니다. 「브라운 출동!」의 기본 피해와 피해 증가량이 [Arg3]% 증가합니다."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:차원 영상 · 젠킨>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "턴 시작 시 돌은 [Arg1] 광기를 획득합니다. 전투 시작 후 돌의 “등가교환” 행동력 소모가 0으로 변하며 사용한 후 다음 턴에 추가로 [Arg2] 장의 카드를 뽑습니다."
  },
  RelicConfig_71248_Desc = {
    Text = "턴 시작 시 돌은 [Arg1] 광기를 획득합니다. 전투 시작 후 돌의 “등가교환” 행동력 소모가 0으로 변하며 사용한 후 다음 턴에 추가로 [Arg2] 장의 카드를 뽑습니다."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:차원 영상 · 돌>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "턴 시작 시 라이커가 광기를 [Arg1] 획득한다. 매 턴 최초 주사위 결과가 6으로 잠금된다."
  },
  RelicConfig_71249_Desc = {
    Text = "턴 시작 시 라이커가 광기를 [Arg1] 획득한다. 매 턴 최초 주사위 결과가 6으로 잠금된다."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:차원 영상 · 라이커>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "턴 시작 시 미리암은 [Arg1] 광기를 획득하고, 1장의 “성례”를 드립니다."
  },
  RelicConfig_71250_Desc = {
    Text = "턴 시작 시 미리암은 [Arg1] 광기를 획득하고, 1장의 “성례”를 드립니다."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:차원 영상 · 미리암>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "턴 시작 시 벤코르는 [Arg1] 광기를 획득합니다. 다른 깨어남체가 광기 폭발을 발동할 때마다 벤코르는 [Arg2] 점의 광기를 획득하고, 손에 든 “정신 재건”의 행동력 소모를 [Arg3] 줄입니다."
  },
  RelicConfig_71251_Desc = {
    Text = "턴 시작 시 벤코르는 [Arg1] 광기를 획득합니다. 다른 깨어남체가 광기 폭발을 발동할 때마다 벤코르는 [Arg2] 점의 광기를 획득하고, 손에 든 “정신 재건”의 행동력 소모를 [Arg3] 줄입니다."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:차원 영상 · 윙클>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "턴 시작 시 툴루가 [Arg1] 광기를 획득합니다. 툴루의 광기 소모량이 [Arg2] 감소하고, 광기 폭발 사용 시 임시 촉수를 [Arg3]개 생성합니다."
  },
  RelicConfig_71252_Desc = {
    Text = "턴 시작 시 툴루가 [Arg1] 광기를 획득합니다. 툴루의 광기 소모량이 [Arg2] 감소하고, 광기 폭발 사용 시 임시 촉수를 [Arg3]개 생성합니다."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:차원 영상 · 툴루>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "턴 시작 시 파인트는 [Arg1] 광기를 획득합니다. 파인트가 생성하는 방어막, 반격, HP 답변이 [Arg2]% 증가하며, 데스 리저스턴스가 발동할 때마다 이 효과는 이번 탐색 동안 [Arg3]% 증가하며, 최대 [Arg4] 번 적용됩니다."
  },
  RelicConfig_71253_Desc = {
    Text = "턴 시작 시 파인트는 [Arg1] 광기를 획득합니다. 파인트가 생성하는 방어막, 반격, HP 답변이 [Arg2]% 증가하며, 데스 리저스턴스가 발동할 때마다 이 효과는 이번 탐색 동안 [Arg3]% 증가하며, 최대 [Arg4] 번 적용됩니다."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:차원 영상 · 파인트>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "턴 시작 시 타비가 광기를 [Arg1] 획득한다. 단일 턴 내 타비의 명령 카드를 [Arg2]장 사용 시 <DerivativeCardKeywords_67:「은열쇠의 새벽빛」>1장을 손패에 추가한다. 해당 효과의 재사용 대기 시간 [Arg3]턴."
  },
  RelicConfig_71254_Desc = {
    Text = "턴 시작 시 타비가 광기를 [Arg1] 획득한다. 단일 턴 내 타비의 명령 카드를 [Arg2]장 사용 시 <DerivativeCardKeywords_67:「은열쇠의 새벽빛」>1장을 손패에 추가한다. 해당 효과의 재사용 대기 시간 [Arg3]턴."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:차원 영상 · 타비>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "턴 시작 시 하멜른이 광기를 [Arg1] 획득한다. 「영혼의 서곡」의 행동력 소모가 [Arg2] 줄어들고, 기본 피해 횟수가 [Arg3] 증가한다."
  },
  RelicConfig_71255_Desc = {
    Text = "턴 시작 시 하멜른이 광기를 [Arg1] 획득한다. 「영혼의 서곡」의 행동력 소모가 [Arg2] 줄어들고, 기본 피해 횟수가 [Arg3] 증가한다."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:차원 영상 · 하멜른>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "턴 시작 시 오를라가 [Arg1] 광기를 획득합니다. 전투 시작 시 모든 감정의 은유를 각각 [Arg2] 층 얻으며, “은유” 효과가 50% 증가합니다."
  },
  RelicConfig_71256_Desc = {
    Text = "턴 시작 시 오를라가 [Arg1] 광기를 획득합니다. 전투 시작 시 모든 감정의 은유를 각각 [Arg2] 층 얻으며, “은유” 효과가 50% 증가합니다."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:차원 영상 · 오를라>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "턴 시작 시 머피가 [Arg1] 광기를 획득합니다. 머피의 「타격」 및 「방어」 사용 시 「희생」의 [Arg2]%를 임시 촉수 피해로 전환합니다. 턴마다 1번만 발동합니다."
  },
  RelicConfig_71257_Desc = {
    Text = "턴 시작 시 머피가 [Arg1] 광기를 획득합니다. 머피의 「타격」 및 「방어」 사용 시 「희생」의 [Arg2]%를 임시 촉수 피해로 전환합니다. 턴마다 1번만 발동합니다."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:차원 영상 · 머피>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "턴 시작 시 유우하시는 [Arg1] 광기를 얻습니다. 유우하시는 광기 소모가 [Arg2]점 감소하며, 매번 광기 폭발을 발동할 때마다 추가로 5점 감소합니다. 매 턴마다 [Arg3]회 광기 폭발을 발동할 수 있습니다."
  },
  RelicConfig_71258_Desc = {
    Text = "턴 시작 시 유우하시는 [Arg1] 광기를 얻습니다. 유우하시는 광기 소모가 [Arg2]점 감소하며, 매번 광기 폭발을 발동할 때마다 추가로 5점 감소합니다. 매 턴마다 [Arg3]회 광기 폭발을 발동할 수 있습니다."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:차원 영상 · 유우하시>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "턴 시작 시 아이기스가 광기를 [Arg1]pt 획득한다. 아이기스가 <VulnerabilityIconKeywords:취약> 상태인 적에게 피해를 입힐 때, 해당 적의 <PowerIconKeywords:임시 힘>을 [Arg2]pt 빼앗는다. 매 턴 최대 [Arg3]회 발동한다."
  },
  RelicConfig_71259_Desc = {
    Text = "턴 시작 시 아이기스가 광기를 [Arg1]pt 획득한다. 아이기스가 <VulnerabilityIconKeywords:취약> 상태인 적에게 피해를 입힐 때, 해당 적의 <PowerIconKeywords:임시 힘>을 [Arg2]pt 빼앗는다. 매 턴 최대 [Arg3]회 발동한다."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:차원 영상 · 아이기스>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "턴 시작 시 테이스는 [Arg1] 광기를 획득합니다. 테이스가 1 턴 내에 [Arg2] 장의 명령 카드를 사용하면, “성결의 자식” 한 장과 [Arg3] 점의 임시 힘을 획득하며, [Arg4] 턴의 재사용 대기시간이 발생합니다."
  },
  RelicConfig_71260_Desc = {
    Text = "턴 시작 시 테이스는 [Arg1] 광기를 획득합니다. 테이스가 1 턴 내에 [Arg2] 장의 명령 카드를 사용하면, “성결의 자식” 한 장과 [Arg3] 점의 임시 힘을 획득하며, [Arg4] 턴의 재사용 대기시간이 발생합니다."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:차원 영상 · 타이스>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "턴 시작 시 파로스가 [Arg1] 광기를 획득합니다. 촉수가 2번 공격할 때마다, 해당 전투 동안 파로스의 중독 부여량과 방어막 획득량이 [Arg2]% 증가합니다 (최대 50%)."
  },
  RelicConfig_71261_Desc = {
    Text = "턴 시작 시 파로스가 [Arg1] 광기를 획득합니다. 촉수가 2번 공격할 때마다, 해당 전투 동안 파로스의 중독 부여량과 방어막 획득량이 [Arg2]% 증가합니다 (최대 50%)."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:차원 영상 · 파로스>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "턴 시작 시 판디아는 [Arg1] 광기를 획득합니다. 판디아가 광기 폭발을 방출한 후, [Arg2]%의 임시 반격을 영구적 반격으로 획득합니다."
  },
  RelicConfig_71262_Desc = {
    Text = "턴 시작 시 판디아는 [Arg1] 광기를 획득합니다. 판디아가 광기 폭발을 방출한 후, [Arg2]%의 임시 반격을 영구적 반격으로 획득합니다."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:차원 영상 · 판디아>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "턴 시작 시 릴리는 [Arg1] 광기를 획득합니다. 릴리의 인내 상한이 [Arg2]% 증가하며, “시들지 않는 진흙 속의 꽃” 또는 “보복의 일격”을 사용할 때, “인내” 스택의 8%에 해당하는 HP을 회복합니다."
  },
  RelicConfig_71263_Desc = {
    Text = "턴 시작 시 릴리는 [Arg1]의 광기를 획득합니다. 릴리의 인내 상한이 [Arg2]% 증가하며, “시들지 않는 진흙 속의 꽃” 또는 “보복의 일격”을 사용할 때, “인내” 스택의 8%에 해당하는 HP를 회복합니다."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:차원 영상 · 릴리>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "턴 시작 시, 카렌이 광기를 [Arg1] 획득한다. 「침묵의 수호」 사용 시 소모된 행동력의 2배를 반환한다, 재사용 대기시간 [Arg2]턴."
  },
  RelicConfig_71264_Desc = {
    Text = "턴 시작 시, 카렌이 광기를 [Arg1] 획득한다. 「침묵의 수호」 사용 시 소모된 행동력의 2배를 반환한다, 재사용 대기시간 [Arg2]턴."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:차원 영상 · 카렌>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "턴 시작 시 살바도르는 [Arg1] 광기를 얻습니다. 매번 진홍색 용광로가 쌓일 때마다 쌓인 양의 [Arg2]% 만큼 힘을 얻습니다. 살바도르의 “공격”과 “소멸해야 할 고통”은 추가로 [Arg3] 배의 힘 증가 효과를 받습니다."
  },
  RelicConfig_71265_Desc = {
    Text = "턴 시작 시 살바도르는 [Arg1] 광기를 얻습니다. 매번 진홍색 용광로가 쌓일 때마다 쌓인 양의 [Arg2]% 만큼 힘을 얻습니다. 살바도르의 “공격”과 “소멸해야 할 고통”은 추가로 [Arg3] 배의 힘 증가 효과를 받습니다."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:차원 영상 · 살바도르>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "턴 시작 시 케이크스는 [Arg1] 광기를 획득합니다. 케이크스가 방어막을 획득할 때 [Arg2]%의 방어막량만큼 HP을 회복."
  },
  RelicConfig_71266_Desc = {
    Text = "턴 시작 시 케이크스는 [Arg1] 광기를 획득합니다. 케이크스가 방어막을 획득할 때 [Arg2]%의 방어막량만큼 HP을 회복."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:차원 영상 · 카이커스>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "턴 시작 시 님피아는 [Arg1] 광기를 획득합니다. 님피아의 “타격”을 사용한 후, “님피아”가 이번 전투에서 주는 중독이 [Arg2]% 증가하며, 님피아의 “방어”를 사용한 후 모든 적에게 [Arg3]% 중독을 유발합니다. 매 턴마다 각각 1회만 발동됩니다."
  },
  RelicConfig_71267_Desc = {
    Text = "턴 시작 시 님피아는 [Arg1] 광기를 획득합니다. 님피아의 “타격”을 사용한 후, “님피아”가 이번 전투에서 주는 중독이 [Arg2]% 증가하며, 님피아의 “방어”를 사용한 후 모든 적에게 [Arg3]% 중독을 유발합니다. 매 턴마다 각 1회만 발동됩니다."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:차원 영상 · 님피아>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "턴 시작 시 에리카는 [Arg1] 광기를 획득합니다. 에리카가 1 턴 내에 [Arg2] 장의 명령 카드를 사용하면, 2 pt의 행동력을 획득하고 이 전투에서 “전자기 폭발”의 힘과 경계 가성이 2배로 증가합니다."
  },
  RelicConfig_71268_Desc = {
    Text = "턴 시작 시 에리카는 [Arg1] 광기를 획득합니다. 에리카가 1 턴 내에 [Arg2] 장의 명령 카드를 사용하면, 2 pt의 행동력을 획득하고 이 전투에서 “전자기 폭발”의 힘과 경계 가성이 2배로 증가합니다."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:차원 영상 · 에리카>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "턴 시작 시 골리아가 광기를 [Arg1] 획득한다. 만약 골리아가 1턴 내로 피해를 [Arg2]회 입혔다면, 해당 전투에서 입힌 피해는 추가 힘 보너스를 1배 적용받는다. 재사용 대기 시간 3턴."
  },
  RelicConfig_71269_Desc = {
    Text = "턴 시작 시 골리아가 광기를 [Arg1] 획득한다. 만약 골리아가 1턴 내로 피해를 [Arg2]회 입혔다면, 해당 전투에서 입힌 피해는 추가 힘 보너스를 1배 적용받는다. 재사용 대기 시간 3턴."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:차원 영상 · 골리아>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "턴 시작 시 산은 [Arg1] 광기를 획득합니다. 전투 시작 시 산의 모든 명령 카드에 보존, 예비 1, [Arg2] 점 방어막을 부여합니다."
  },
  RelicConfig_71270_Desc = {
    Text = "턴 시작 시 산은 [Arg1] 광기를 획득합니다. 전투 시작 시 산의 모든 명령 카드에 보존, 예비 1, [Arg2] 점 방어막을 부여합니다."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:차원 영상 · 산>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "짝수 턴 시작 시, 1장의 <DerivativeCardKeywords_105:“무한은심 보물창고”>를 손에 넣습니다."
  },
  RelicConfig_71662_Desc = {
    Text = "짝수 턴 시작 시, 1장의 <DerivativeCardKeywords_105:“무한은심 보물창고”>를 손에 넣습니다."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:고양이의 보물>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "손패 상한 +1. 턴 시작 시 현재 연구 중이 아닌 경우, 진행하지 않은 연구 중 하나를 선택하고 완료하면 융해·돌의 연구 성과를 얻습니다. 3개의 연구를 완료하면 “무한의 종말”을 손에 추가하며, 해당 유물은 실타래효됩니다."
  },
  RelicConfig_72226_Desc = {
    Text = "손패 상한 +1. 턴 시작 시 현재 연구 중이 아닌 경우, 진행하지 않은 연구 중 하나를 선택하고 완료하면 융해·돌의 연구 성과를 얻습니다. 3개의 연구를 완료하면 “무한의 종말”을 손에 추가하며, 해당 유물은 실타래효됩니다."
  },
  RelicConfig_72226_Name = {
    Text = "최종 연구 수첩"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "손패 상한 +1. 턴 시작 시 커스텀 “금기의 거래”를 획득합니다. “금기의 거래” 사용 후, 다음 턴에 재발동 가능. “금기의 거래”를 보유 중일 때 다른 타입의 “명령 카드”를 사용하면 해당 효과가 업그레이드됩니다."
  },
  RelicConfig_74832_Desc = {
    Text = "손패 상한 +1. 턴 시작 시 커스텀 “금기의 거래”를 획득합니다. “금기의 거래” 사용 후, 다음 턴에 재발동 가능. “금기의 거래”를 보유 중일 때 다른 타입의 “명령 카드”를 사용하면 해당 효과가 업그레이드됩니다."
  },
  RelicConfig_74832_Name = {
    Text = "천면 초대장"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "편지의 글자는 끊임없이 변하며, 항상 거부할 수 없는 갈망으로 바뀌었다."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "단일 턴 내에 4장의 서로 다른 깨어남체에 속하는 명령 카드를 사용하면, 모든 깨어남체가 이번 턴에 주는 최종 피해가 [Arg1]% 증가하고, [Arg2] 점의 광기를 잃습니다. 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_78664_Desc = {
    Text = "단일 턴 내에 4장의 서로 다른 깨어남체에 속하는 명령 카드를 사용하면, 모든 깨어남체가 이번 턴에 주는 최종 피해가 [Arg1]% 증가하고, [Arg2] 점의 광기를 잃습니다. 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:기괴한 갈고리발톱>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "식별하기 어려운 종."
  },
  RelicConfig_78665_BattleDesc = {
    Text = "턴 시작 시 [Arg1]장의 카드를 적게 뽑습니다. 실타래제 행동력 소모가 [Arg2] 이상인 카드를 1장 사용할 때마다 행동력을 1pt 획득하며, 각 턴에 최대 [Arg3]번까지 발동합니다."
  },
  RelicConfig_78665_Desc = {
    Text = "턴 시작 시 [Arg1]장의 카드를 적게 뽑습니다. 실타래제 행동력 소모가 [Arg2] 이상인 카드를 1장 사용할 때마다 행동력을 1pt 획득하며, 각 턴에 최대 [Arg3]번까지 발동합니다."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:애곡의 방울>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "띵동, 띵동, 아이가 울고 있어요;\n띵동, 띵동, 아이가 비명을 지르고 있어요;\n띵동, 띵동, 아이가 울부짖고 있어요;\n띵동, 띵동, 배가 고픈 거예요, 당신이 알잖아요."
  },
  RelicConfig_78666_BattleDesc = {
    Text = "턴 시작 시 반격을 [Arg1]pt 획득합니다. 1턴 내에 광기 폭발을 [Arg2]회 사용한 후, 자신에게 영구 반격을 [Arg3]% 제거하고, 제거된 양의 임시 반격을 [Arg4]% 획득하며, [Arg5]턴 동안 쿨타임이 적용됩니다."
  },
  RelicConfig_78666_Desc = {
    Text = "턴 시작 시 반격을 [Arg1]pt 획득합니다. 1턴 내에 광기 폭발을 [Arg2]회 사용한 후, 자신에게 영구 반격을 [Arg3]% 제거하고, 제거된 양의 임시 반격을 [Arg4]% 획득하며, [Arg5]턴 동안 쿨타임이 적용됩니다."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:여정의 유골>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "신성함의 일부입니다.\n몸통과 분리되더라도 그 흔적은 이미 전 세계를 뒤덮었습니다."
  },
  RelicConfig_78667_BattleDesc = {
    Text = "카드 뽑기 단계 후 추가로 [Arg1] 장의 카드를 뽑고, [Arg2] 장의 손패를 선택하여 버립니다."
  },
  RelicConfig_78667_Desc = {
    Text = "카드 뽑기 단계 후 추가로 [Arg1] 장의 카드를 뽑고, [Arg2] 장의 손패를 선택하여 버립니다."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:속임수의 모자>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "카시아 양의 환상 서커스에 오신 것을 환영합니다! 조심하세요, 마법 도구를 함부로 만지지 마세요. 만약 실타래수로 물리면, 그건 큰일이예요.\n결국, 그것이 마지막으로 피의 맛을 느꼈을 때, 그로 인해 발생한 결과는 정말 공포스러웠습니다.\n\n모자도 눈을 깜빡이며, 언제든지 태어날 준비가 되어 있는 것처럼 보입니다."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "은열쇠 깨어남 사용 후, 해당 깨어남체의 파생되지 않은 명령 카드 [Arg1] 장을 선택하여 소모하고, [Arg2] 장의 추가 소모된 원본 복제를 각각 덱, 손패 더미, 버린 카드 더미에 넣습니다."
  },
  RelicConfig_78668_Desc = {
    Text = "은열쇠 깨어남 사용 후, 해당 깨어남체의 파생되지 않은 명령 카드 [Arg1] 장을 선택하여 소모하고, [Arg2] 장의 추가 소모된 원본 복제를 각각 덱, 손패 더미, 버린 카드 더미에 넣습니다."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:에메랄드 탁본>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "이 인장은 천년 동안 변치 않고 남아 있습니다."
  },
  RelicConfig_78669_BattleDesc = {
    Text = "전투 시작 시 힘 [Arg1]pt를 획득합니다. 턴 시작 시, 영구 힘 [Arg2]pt 마다 임시 힘 [Arg3]pt를 얻으며, 임시 힘을 최대 [Arg4]pt 얻습니다. 턴 종료 시, 해당 유물로 얻은 임시 힘의 절반에 해당하는 방어막을 잃습니다."
  },
  RelicConfig_78669_Desc = {
    Text = "전투 시작 시 힘 [Arg1]pt를 획득합니다. 턴 시작 시, 영구 힘 [Arg2]pt 마다 임시 힘 [Arg3]pt를 얻으며, 임시 힘을 최대 [Arg4]pt 얻습니다. 턴 종료 시, 해당 유물로 얻은 임시 힘의 절반에 해당하는 방어막을 잃습니다."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:재앙 의식의 새>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "말라버린 시체가 울음소리를 내며 울부짖습니다."
  },
  RelicConfig_78670_BattleDesc = {
    Text = "모든 깨어남체의 기본 피해가 [Arg1]% 증가하고, 덱 초기화 시 추가로 [Arg2]% 증가하지만, 손에 「불안정한 걸음걸이」가 1장 추가됩니다. 증가치는 최대 [Arg3]%까지입니다."
  },
  RelicConfig_78670_Desc = {
    Text = "모든 깨어남체의 기본 피해가 [Arg1]% 증가하고, 덱 초기화 시 추가로 [Arg2]% 증가하지만, 손에 「불안정한 걸음걸이」가 1장 추가됩니다. 증가치는 최대 [Arg3]%까지입니다."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:검은 촛대>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "화염 속에서 명료함을 태우다, 허망에 빠진다."
  },
  RelicConfig_78671_BattleDesc = {
    Text = "턴 시작 시 배아 융합도 + [Arg1]%，당신의 “배아”는 턴 종료 시 버려집니다."
  },
  RelicConfig_78671_Desc = {
    Text = "턴 시작 시 배아 융합도 + [Arg1]%，당신의 “배아”는 턴 종료 시 버려집니다."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:꿈틀거리는 탯줄>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "목을 감싸는."
  },
  RelicConfig_78672_BattleDesc = {
    Text = "턴 시작 시 [Arg2] 층 중독을 받으며, 초차원 공간마다 1개의 빈 자리가 있을 때 [Arg1] 점 힘을 얻습니다."
  },
  RelicConfig_78672_Desc = {
    Text = "턴 시작 시 [Arg2] 층 중독을 받으며, 초차원 공간마다 1개의 빈 자리가 있을 때 [Arg1] 점 힘을 얻습니다."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:군체 의식>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "감싸기, 공생, 군집; 두려움, 미지, 통제."
  },
  RelicConfig_78673_BattleDesc = {
    Text = "은빛 열쇠 깨어남 후 [Arg1]만큼의 은열쇠 에너지를 추가로 소모합니다. 이로 인해 영지 깨어남 카드의 행동력 소모가 0이 되며, 사용 시 대상 깨어남체가 [Arg2]만큼의 광기를 추가로 얻습니다."
  },
  RelicConfig_78673_Desc = {
    Text = "은빛 열쇠 깨어남 후 [Arg1]만큼의 은열쇠 에너지를 추가로 소모합니다. 이로 인해 영지 깨어남 카드의 행동력 소모가 0이 되며, 사용 시 대상 깨어남체가 [Arg2]만큼의 광기를 추가로 얻습니다."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:각인된 의식>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "고대 부족은 죽은 이의 두개골에 특수 기호를 새김으로써 그의 영혼을 남겨두어 영원한 동반자로 만들 수 있다는 것을 믿었다."
  },
  RelicConfig_78674_BattleDesc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] 중독 피해를 줍니다. 턴 시작 시 적의 중독을 [Arg2]% 제거하고, 제거량의 [Arg3]%만큼 출혈을 적용합니다."
  },
  RelicConfig_78674_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] 중독 피해를 줍니다. 턴 시작 시 적의 중독을 [Arg2]% 제거하고, 제거량의 [Arg3]%만큼 출혈을 적용합니다."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:구원의 수족>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "신성함의 일부입니다.\n몸통과 분리되어 있어도 여전히 따뜻함을 느낄 수 있습니다."
  },
  RelicConfig_78675_BattleDesc = {
    Text = "턴 시작 시 촉수가 [Arg1]개를 초과할 경우, 촉수 [Arg2]개를 잃고 임시 촉수 [Arg3]개를 생성합니다. 그렇지 않을 경우 영구 촉수 [Arg4]개를 생성합니다."
  },
  RelicConfig_78675_Desc = {
    Text = "턴 시작 시 촉수가 [Arg1]개를 초과할 경우, 촉수 [Arg2]개를 잃고 임시 촉수 [Arg3]개를 생성합니다. 그렇지 않을 경우 영구 촉수 [Arg4]개를 생성합니다."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:신성한 고통의 팔>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "고통을 즐기세요."
  },
  RelicConfig_79408_BattleDesc = {
    Text = "손패 상한 +2, 뽑는 카드 수 +2. “청명의 기억”은 시작 시 5층이며, 마크가 있는 카드를 사용하면 “청명의 기억”이 변화합니다. “청명의 기억”이 5 이하일 때마다 1점 낮아질 때마다 최종 피해 +10%, 방어막과 HP 회복이 5% 감소합니다; “청명의 기억”이 5 이상일 때마다 1점 높아질 때마다 방어막과 HP 회복이 5% 증가하고, 최종 피해 -10%입니다."
  },
  RelicConfig_79408_Desc = {
    Text = "최대 손패 매수 +2, 뽑다 수 +2. “맑은 기억”의 시작은 5층이며, 마크가 있는 카드를 사용하면 “맑은 기억”이 변화합니다. “맑은 기억”이 5 이하일 때마다 1점 낮아질 때마다 최종 피해 +10%, 방어막과 HP 회복이 5% 감소합니다; “맑은 기억”이 5 이상일 때마다 1점 높아질 때마다 방어막과 HP 회복이 5% 증가하며, 최종 피해 -10%입니다."
  },
  RelicConfig_79408_Name = {
    Text = "「기억」과「꿈」"
  },
  RelicConfig_79408_StoryDesc = {
    Text = "「오세요, 내 말을 들어보세요。」\n「내가 당신의 기억과 꿈을 가져와。」\n「비할 데 없이 맛있는 디저트로 만들어 드릴게요。」"
  },
  RelicConfig_80340_BattleDesc = {
    Text = "턴 시작 시 클레멘타인에게 [Arg1] 광기가 부여됩니다. 클레멘타인의 모든 명령 카드 피해, 방패, HP 회복, 광기 얻기, 은열쇠 에너지 얻기의 효과 횟수가 1 증가합니다."
  },
  RelicConfig_80340_Desc = {
    Text = "턴 시작 시 클레멘타인에게 [Arg1] 광기가 부여됩니다. 클레멘타인의 모든 명령 카드 피해, 방패, HP 회복, 광기 얻기, 은열쇠 에너지 얻기의 효과 횟수가 1 증가합니다."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:차원 영상 · 클레멘타인>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "탐험 시작 시 유물 한계 +1,「심해」영역 깨어남체가 자신의「차원 영상」을 얻습니다. 파티원 중 1명이「심해」영역 깨어남체일 경우, 유물 한계 +1."
  },
  RelicConfig_83509_Desc = {
    Text = "탐험 시작 시 유물 한계 +1,「심해」영역 깨어남체가 자신의「차원 영상」을 얻습니다. 파티원 중 1명이「심해」영역 깨어남체일 경우, 유물 한계 +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:「심해 반지」>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "심연의 깊은 바다 속에서의 잠자는 자가 잊혀진 권위를 세상에 드러내기 시작합니다."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "탐험 시작 시 유물 한계가 1 증가하고,「혈육」 영역 깨어남체가 자신의「차원 영상」을 얻는다. 파티원 중 1명이「혈육」영역 깨어남체일 경우, 유물 한계가 1 증가한다."
  },
  RelicConfig_83510_Desc = {
    Text = "탐험 시작 시 유물 한계 +1,「혈육」영역 깨어남체가 자신의「차원 영상」을 얻습니다. 파티원 중 1명이「혈육」영역 깨어남체일 경우, 유물 한계 +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:「혈육 반지」>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "지금껏 고통과 약함없이, 승승장구해왔다."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "탐험 시작 시 유물 한계가 1 증가하고 ,「초차원」영역 깨어남체가 자신의「차원 영상」을 얻는다. 파티원 중 1명이 「초차원」 영역 깨어남체일 경우, 유물 한계가 1 증가한다."
  },
  RelicConfig_83511_Desc = {
    Text = "탐험 시작 시 유물 한계가 1 증가하고, 「초차원」 영역 깨어남체가 자신의 「차원 영상」을 얻는다. 파티원 중 1명이 「초차원」 영역 깨어남체일 경우, 유물 한계가 1 증가한다."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:「초차원 반지」>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "무한의 차원이 중첩되며, 이 순간의 나 「자신」은 무한히 완전하다."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "탐험 시작 시 유물 한계 +1, 「혼돈」영역 깨어남체가 자신의 「차원 영상」을 얻습니다. 파티원 중 1명이 「혼돈」영역 깨어남체일 경우, 유물 한계 +1."
  },
  RelicConfig_83512_Desc = {
    Text = "탐험 시작 시 유물 한계 +1, 「혼돈」영역 깨어남체가 자신의 「차원 영상」을 얻습니다. 파티원 중 1명이「혼돈」영역 깨어남체일 경우, 유물 한계 +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:「혼돈 반지」>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "혼돈은 형체가 없고, 혼돈은 본질이 없으며, 혼돈은 모든 것에 융합되었다."
  },
  RelicConfig_83606_BattleDesc = {
    Text = "손패 상한 + 1. 턴 시작 시 「항해자의 결정」이 없으면, 그것을 손에 넣습니다.\n리더가 초기 최대 HP의 10%를 잃을 때마다, 1층의 「항해를 시작하다」를 얻고, 한도는 10층이며, 「항해를 시작하다」는 「파도를 가르는 출항」의 효과를 높일 수 있습니다.\n자신이 초기 최대 HP의 10%를 잃을 때마다, 1층의 「닻을 내리다」를 얻고, 한도는 10층이며, 「닻을 내리다」는 「해안 정박」의 효과를 높일 수 있습니다."
  },
  RelicConfig_83606_Desc = {
    Text = "손패 상한 +1. 턴 시작 시 「항해자의 결정」이 없으면, 그것을 손에 넣는다. \n 리더가 초기 최대 HP의 10%를 잃을 때마다, 1층의 「항해를 시작하다」를 얻고, 한도는 10층이며, 「항해를 시작하다」는 「파도를 가르는 출항」의 효과를 높일 수 있다. \n 자신이 초기 최대 HP의 10%를 잃을 때마다, 1층의 「닻을 내리다」를 얻고, 한도는 10층이며, 「닻을 내리다」는 「해안 정박」의 효과를 높일 수 있다."
  },
  RelicConfig_83606_Name = {
    Text = "에라스모의 지침"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "깜박이는 번개가 나아갈 방향을 인도할 것이다."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "턴 시작 시 아그리파는 [Arg1] 광기를 획득합니다. “불내의 시혜”는 아그리파가 이번 턴 중에 산출 비용을 [Arg2] 줄이게 만들며, 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_84112_Desc = {
    Text = "턴 시작 시 아그리파는 [Arg1] 광기를 획득합니다. “불내의 시혜”는 아그리파가 이번 턴 중에 산출 비용을 [Arg2] 줄이게 만들며, 매 턴 최대 1회 적용됩니다."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:차원 영상 · 아그리파>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "턴 시작 시 카라부가 [Arg1] 광기를 획득합니다. 카라부가 <FaxianKeywords:발견> <DerivativeCardKeywords_152:「축복」>을 할 때마다 추가 선택지 1개가 나타나며, 광기 폭발은 동일한 양의 피해에 해당하는 <Corrosion:침식>을 가합니다."
  },
  RelicConfig_84113_Desc = {
    Text = "턴 시작 시 카라부가 [Arg1] 광기를 획득합니다. 카라부가 <FaxianKeywords:발견> <DerivativeCardKeywords_152:「축복」>을 할 때마다 추가 선택지 1개가 나타나며, 광기 폭발은 동일한 양의 피해에 해당하는 <Corrosion:침식>을 가합니다."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:차원 영상·카라부>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "턴 시작 시 픽맨이 광기를 [Arg1] 획득한다. 「창의」 1스택 획득 시마다 랜덤으로 손패 1장의 해당 턴 행동력 소모를 1 감소시키며, 픽맨이 「창의」를 소비 시 추가로 모든 깨어남체가 광기를 [Arg2]pt 획득한다."
  },
  RelicConfig_84114_Desc = {
    Text = "턴 시작 시 픽맨이 광기를 [Arg1] 획득한다. 「창의」 1스택 획득 시마다 랜덤으로 손패 1장의 해당 턴 행동력 소모를 1 감소시키며, 픽맨이 「창의」를 소비 시 추가로 모든 깨어남체가 광기를 [Arg2]pt 획득한다."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:차원 영상 · 픽맨>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "턴 시작 시 에리카는 [Arg1] 광기를 획득합니다. 에리카가 1 턴 내에 [Arg2] 장의 명령 카드를 사용하면, 2 pt의 행동력을 획득하고 이 전투에서 “전자기 폭발”의 힘과 경계 가성이 2배로 증가합니다."
  },
  RelicConfig_84116_Desc = {
    Text = "턴 시작 시 에리카는 [Arg1] 광기를 획득합니다. 에리카가 1 턴 내에 [Arg2] 장의 명령 카드를 사용하면, 2 pt의 행동력을 획득하고 이 전투에서 “전자기 폭발”의 힘과 경계 가성이 2배로 증가합니다."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:차원 영상·에리카>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "턴 시작 시 탄망·머피가 광기를 [Arg1] 획득한다. 「레무리아 왈츠」가 매 3번째 사용될 시 3회 발동한다."
  },
  RelicConfig_84117_Desc = {
    Text = "턴 시작 시 탄망·머피가 광기를 [Arg1] 획득한다. 「레무리아 왈츠」가 매 3번째 사용될 시 3회 발동한다."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:차원 영상 · 탄망·머피>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "턴 시작 시 카시아는 [Arg1] 광기를 획득합니다. 매 1장의 카드를 뽑을 때마다 카시아는 [Arg2] 광기를 획득합니다. 카시아가 광기 폭발을 방출할 때 모든 적은 [Arg3] 힘을 잃습니다."
  },
  RelicConfig_84118_Desc = {
    Text = "턴 시작 시 카시아는 [Arg1] 광기를 획득합니다. 매 1장의 카드를 뽑을 때마다 카시아는 [Arg2] 광기를 획득합니다. 카시아가 광기 폭발을 방출할 때 모든 적은 [Arg3] 힘을 잃습니다."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:차원 영상 · 카시아>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "턴 시작 시 머피가 [Arg1] 광기를 획득합니다. 머피의 「타격」 및 「방어」 사용 시 「희생」의 [Arg2]%를 임시 촉수 피해로 전환합니다. 턴마다 1번만 발동합니다."
  },
  RelicConfig_84119_Desc = {
    Text = "턴 시작 시 머피가 [Arg1] 광기를 획득합니다. 머피의 「타격」 및 「방어」 사용 시 「희생」의 [Arg2]%를 임시 촉수 피해로 전환합니다. 턴마다 1번만 발동합니다."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:차원 영상 · 머피>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "턴 시작 시 아라크네가 광기를 [Arg1] 획득한다. 「타격」과 「방어」가 즉시 「끝없는 실타래타래」 추격을 1회 발동하며, 이는 매 턴 각각 최대 1회까지 적용된다."
  },
  RelicConfig_84121_Desc = {
    Text = "턴 시작 시 아라크네가 광기를 [Arg1] 획득한다. 「타격」과 「방어」가 즉시 「끝없는 실타래타래」 추격을 1회 발동하며, 이는 매 턴 각각 최대 1회까지 적용된다."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:차원 영상 · 아라크네>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "턴 시작 시 툴루가 [Arg1] 광기를 획득합니다. 툴루의 광기 소모량이 [Arg2] 감소하고, 광기 폭발 사용 시 임시 촉수를 [Arg3]개 생성합니다."
  },
  RelicConfig_84122_Desc = {
    Text = "턴 시작 시 툴루가 [Arg1] 광기를 획득합니다. 툴루의 광기 소모량이 [Arg2] 감소하고, 광기 폭발 사용 시 임시 촉수를 [Arg3]개 생성합니다."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:차원 영상 · 툴루>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "턴 시작 시 폴룩스가 광기를 [Arg1]pt 획득한다. 전투 시작 시 「성심」 1장을 획득하며, 「성심」이 3번째로 사용되며 소모될 때 모든 적에게 피해 증가를 부여하고 피해 2회를 입힌다."
  },
  RelicConfig_84123_Desc = {
    Text = "턴 시작 시 폴룩스가 광기를 [Arg1]pt 획득한다. 전투 시작 시 「성심」 1장을 획득하며, 「성심」이 3번째로 사용되며 소모될 때 모든 적에게 피해 증가를 부여하고 피해 2회를 입힌다."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:차원 영상 · 폴룩스>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "턴 시작 시 하멜른이 광기를 [Arg1] 획득한다. 「영혼의 서곡」의 행동력 소모가 [Arg2] 줄어들고, 기본 피해 횟수가 [Arg3] 증가한다."
  },
  RelicConfig_84124_Desc = {
    Text = "턴 시작 시 하멜른이 광기를 [Arg1] 획득한다. 「영혼의 서곡」의 행동력 소모가 [Arg2] 줄어들고, 기본 피해 횟수가 [Arg3] 증가한다."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:차원 영상 · 하멜른>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "턴 시작 시 카티구라가 광기 [Arg1]pt를 획득한다. 누적 「활염」 10스택 소모 즉시 카티구라의 명령 카드를 1장 드로우하여 「활염」 3스택을 부여하고, 해당 턴에는 더 이상 스택을 누적하지 않는다."
  },
  RelicConfig_84125_Desc = {
    Text = "턴 시작 시 카티구라가 광기 [Arg1]pt를 획득한다. 누적 「활염」 10스택 소모 즉시 카티구라의 명령 카드를 1장 드로우하여 「활염」 3스택을 부여하고, 해당 턴에는 더 이상 스택을 누적하지 않는다."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:차원 영상 · 카티구라>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "턴 시작 시 카스토르는 [Arg1] 광기를 얻습니다. 전투 시작 시 「검은 날개」 2장을 손에 넣고, 매 턴 「검은 날개」를 처음 쓴 후 [Arg2] pt의 임시 힘을 얻습니다."
  },
  RelicConfig_84126_Desc = {
    Text = "턴 시작 시 카스토르는 [Arg1] 광기를 얻습니다. 전투 시작 시 「검은 날개」 2장을 손에 넣고, 매 턴 「검은 날개」를 처음 쓴 후 [Arg2] pt의 임시 힘을 얻습니다."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:차원 영상 · 카스토르>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "턴 시작 시 코퍼산트는 광기를 [Arg1] 얻고, 임시 촉수 1개를 얻는다. 죽음 저항이 발동될 때마다 코퍼산트는 광기를 [Arg2]pt 얻고, 행동력 1을 0으로 소모하고, 소모한 「징벌 번개」를 손에 넣는다."
  },
  RelicConfig_84127_Desc = {
    Text = "턴 시작 시 코퍼산트는 광기를 [Arg1] 얻고, 임시 촉수 1개를 얻는다. 죽음 저항이 발동될 때마다 코퍼산트는 광기를 [Arg2]pt 얻고, 행동력 1을 0으로 소모하고, 소모한 「징벌 번개」를 손에 넣는다."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:차원 영상 · 코퍼산트>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "행동력 상한선이 1 증가하고, 매 턴 뽑는 카드 수가 1 증가하며, 전투 시작 시 [Arg1] 층의 “숙명 감옥” 카운트를 얻습니다. \n 각 층의 “숙명 감옥”은 모든 깨어남체가 생성하는 광기를 [Arg2]% 감소시키며, 광기 폭발을 발동할 때마다 1층의 “숙명 감옥”이 줄어듭니다. 모든 “숙명 감옥”이 제거된 후, 모든 깨어남체가 [Arg3] pt의 광기를 얻고 “불굴의 심장”을 얻습니다: 모든 깨어남체가 생성하는 광기가 [Arg4]% 증가하며, 매 턴 2회까지 광기 폭발을 발동할 수 있습니다."
  },
  RelicConfig_89252_Desc = {
    Text = "최대 행동력 1 증가, 매 턴 뽑는 카드 수 1 증가, 전투 시작 시 [Arg1]층 「숙명 감옥」 카운트를 획득합니다.\n각 층의 「숙명 감옥」은 모든 깨어남체가 생성하는 광기를 [Arg2]% 감소시키며, 광기 폭발을 발동할 때마다 「숙명 감옥」 1층이 감소합니다. 모든 「숙명 감옥」이 제거된 후, 모든 깨어남체가 [Arg3] pt의 광기를 획득하고, 「불굴의 심장」을 얻습니다: 모든 깨어남체가 생성하는 광기가 [Arg4]% 증가하며, 매 턴 2회 광기 폭발을 발동할 수 있습니다."
  },
  RelicConfig_89252_Name = {
    Text = "저주받은 깃털"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "이제 이 깃털은 더 이상 하늘을 날 수 없게 되었어."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "최대 손패 매수 +2, 광기 폭발을 해제한 후 임시 최종 피해가 10% 증가합니다.\n카드가 초원공간에 들어간 후, 손에 있는 1개의 “배아”가 “성결의 자식”으로 변환됩니다.\n1개의 “배아”를 생성할 때마다, 초원공간의 랜덤 카드의 행동력 소모가 1 감소합니다."
  },
  RelicConfig_89645_Desc = {
    Text = "최대 손패 매수 +2, 광기 폭발을 해제한 후 임시 최종 피해가 10% 증가합니다.\n카드가 초원공간에 들어가면 손에 있는 1개의 “배아”가 “성결의 자식”으로 변환됩니다.\n1개의 “배아”를 생성할 때마다 초원공간의 랜덤 카드 행동력 소모가 1 감소합니다."
  },
  RelicConfig_89645_Name = {
    Text = "초끈 부패 약재"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "턴 시작 시 250의 은열쇠 에너지를 얻습니다。\n은열쇠 깨어남을 사용한 후, '은열쇠 미광' 1장을 손에 넣습니다。\n매 턴 시작 시 깨어남체 지원 카드 1장을 발견합니다。"
  },
  RelicConfig_89646_Desc = {
    Text = "턴 시작 시 250의 은열쇠 에너지를 얻습니다。\n은열쇠 깨어남을 사용한 후, '은열쇠 미광' 1장을 손에 넣습니다。\n매 턴 시작 시 깨어남체 지원 카드 1장을 발견합니다。"
  },
  RelicConfig_89646_Name = {
    Text = "통합 유전 약제"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "매 턴의 첫 번째 명령 카드가 1번 추가로 발동합니다.\n소멸 시 1개의 촉수 생성.\n촉수를 “노도”자세로 전환한 후, 이번 턴의 1장의 명령 카드의 워프 효과가 반드시 발동하며 그 카드의 2개의 오리지널 복제를 초원공간에 넣습니다. 3 턴 쿨타임."
  },
  RelicConfig_89647_Desc = {
    Text = "매 턴의 첫 번째 명령 카드가 추가로 1번 발동합니다.\n소멸 시 1개의 촉수 생성.\n촉수를 “노도” 자세로 전환한 후, 이번 턴의 1장의 명령 카드의 워프 효과가 반드시 발동하며 그 카드를 2장의 원본 복제를 초원공간에 넣고, 3 턴 쿨타임."
  },
  RelicConfig_89647_Name = {
    Text = "초끈 해연 약재"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "경계 숙련도 200점 상승.\n스칼렛 용광로 소모 시, 소모량의 15%만큼 촉수 피해 증가.\n촉수 공격 시마다 [Arg3] 점 스칼렛 용광로 축적."
  },
  RelicConfig_89648_Desc = {
    Text = "경계 숙련도 200점 상승.\n스칼렛 용광로 소모 시, 소모량의 15%만큼 촉수 피해 증가.\n촉수 공격 시마다 [Arg3] 점 스칼렛 용광로 축적."
  },
  RelicConfig_89648_Name = {
    Text = "부패 해연 약재"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "턴 시작 시, 아군과 적에게 <Kuangre:광열>을 1 부여합니다. <Kuangre:광열> 1스택마다 입히는 능동 피해 및 촉수 피해의 10%만큼 대상에게 <BleedingIconKeywords:출혈>을 부여합니다. 보스 HP의 20%만큼 피해를 입힐 때마다 모든 깨어남체가 10 광기를 획득합니다. 전투 시작 시 <DerivativeCardKeywords_108:「자손의 격려」>와 <DerivativeCardKeywords_109:「자손의 축복」>을 드로우 덱에 추가합니다."
  },
  RelicConfig_91096_Desc = {
    Text = "턴 시작 시, 아군과 적에게 <Kuangre:광열>을 1 부여합니다. <Kuangre:광열> 1스택마다 입히는 능동 피해 및 촉수 피해의 10%만큼 대상에게 <BleedingIconKeywords:출혈>을 부여합니다. 보스 HP의 20%만큼 피해를 입힐 때마다 모든 깨어남체가 10 광기를 획득합니다. 전투 시작 시 <DerivativeCardKeywords_108:「자손의 격려」>와 <DerivativeCardKeywords_109:「자손의 축복」>을 드로우 덱에 추가합니다."
  },
  RelicConfig_91096_Name = {
    Text = "창백한 알"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "창백한 아이가 태어날 때의 고동.\n조심해, 그들이 곧 올 것입니다."
  },
  RelicConfig_94695_BattleDesc = {
    Text = "깨어남체 처치 완료 후, 다른 아군에게 <StrongEffectKeywords:증폭 효과>를 [Arg1] 부여하며, 해당 효과는 깨어남체마다 한 번만 발동된다."
  },
  RelicConfig_94695_Desc = {
    Text = "깨어남체 처치 완료 후, 다른 아군에게 <StrongEffectKeywords:증폭 효과>를 [Arg1] 부여하며, 해당 효과는 깨어남체마다 한 번만 발동된다."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:검은 별의 잔불>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "전투 시작 후, 「<PVPDerivativeCardKeywords_21:뼈를 침식하는 포옹>」 [Arg1]장을 손패에 넣는다."
  },
  RelicConfig_94696_Desc = {
    Text = "전투 시작 후, 「<PVPDerivativeCardKeywords_21:뼈를 침식하는 포옹>」 [Arg1]장을 손패에 넣는다."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:활력 주사기>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "턴 종료 시, 손에 있는 모든 카드를 버리고 같은 수만큼 카드를 드로우한다."
  },
  RelicConfig_94697_Desc = {
    Text = "턴 종료 시, 손에 있는 모든 카드를 버리고 같은 수만큼 카드를 드로우한다."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:미혹의 풍경>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "전투 시작 후, 「<PVPDerivativeCardKeywords_22:후발제인>」과 「<PVPDerivativeCardKeywords_23:머릿속의 소리>」를 [Arg1]장씩 드로우 덱에 넣는다."
  },
  RelicConfig_94698_Desc = {
    Text = "전투 시작 후, 「<PVPDerivativeCardKeywords_22:후발제인>」과 「<PVPDerivativeCardKeywords_23:머릿속의 소리>」를 [Arg1]장씩 드로우 덱에 넣는다."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:알폰소의 기구>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "손패 상한 +1.\n턴 시작 시 <DerivativeCardKeywords_111:「혼 포식」>이 없으면 이를 손에 넣습니다. 만약「배부름」이 10에 도달하면 <DerivativeCardKeywords_112:「기억 공명」>으로 전환합니다."
  },
  RelicConfig_95975_Desc = {
    Text = "손 카드 한도 +1.\n턴 시작 시 「혼 포식」이 없다면 카드를 손에 넣습니다. 만약 「배불리」가 10에 도달하면 이를 「기억 공명」으로 변환합니다."
  },
  RelicConfig_95975_Name = {Text = "본 컵"},
  RelicConfig_95975_StoryDesc = {
    Text = "「피의 달이 떠오르고, 해골들은 함께 잔을 들어야 한다.」"
  },
  RelicConfig_95976_BattleDesc = {
    Text = "턴 시작 시 도어세인이 광기를 [Arg1], 힘을 [Arg2]pt 획득한다. 도어세인이 「잔해」 사용 시 영구 힘 20%를 임시 힘으로 획득한다."
  },
  RelicConfig_95976_Desc = {
    Text = "턴 시작 시 도어세인이 광기를 [Arg1], 힘을 [Arg2]pt 획득한다. 도어세인이 「잔해」 사용 시 영구 힘 20%를 임시 힘으로 획득한다."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:차원 영상 · 도어세인>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "<Heat:열량>이 3 미만일 때, 3장의 미연소 명령 카드를 사용할 때마다 손패의 1장의 명령 카드에 <BurningKeywords:번영>을 부여합니다.<BurningKeywords:번영>이 부여된 카드가 사용되면 <Heat:열량> 1층을 축적하고, 그렇지 않으면 소모하고 1장의 카드를 뽑습니다.<Heat:열량>이 3층에 도달하면, 3점의 행동력을 획득하고 3장의 카드를 뽑으며, 손패의 모든 명령 카드에 <BurningKeywords:번영>을 부여하고 즉시 <Overload:폭발 초과> 상태에 들어갑니다."
  },
  RelicConfig_96652_Desc = {
    Text = "<Heat:열량>이 3 미만일 때, 3장의 미연소 명령 카드를 사용할 때마다 손패의 1장의 명령 카드에 <BurningKeywords:번영>을 부여합니다. <BurningKeywords:번영> 카드가 사용되면, 1층의 <Heat:열량>이 쌓이거나, 그렇지 않으면 소모하고 1장의 카드를 뽑습니다. <Heat:열량>이 3층에 도달하면, 3 pt의 행동력을 얻고, 3장의 카드를 뽑으며, 손패의 모든 명령 카드에 <BurningKeywords:번영>을 부여하고 즉시 <Overload:폭발 초과> 상태에 들어갑니다."
  },
  RelicConfig_96652_Name = {
    Text = "검은 불꽃"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "검은 불꽃이 그녀의 의지를 관철시키고, 모든 것을 태워 없애버릴 것이다."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "마지막 손에 든 카드를 잃으면 2장의 카드를 뽑고 [Arg1] pt의 은열쇠 에너지를 얻는다. 매번 덱을 리셋할 때 촉수 피해가 [Arg2] 점 증가한다."
  },
  RelicConfig_97344_Desc = {
    Text = "마지막 손에 든 카드를 잃으면 2장의 카드를 뽑고 [Arg1] pt의 은열쇠 에너지를 얻는다. 매번 덱을 리셋할 때 촉수 피해가 [Arg2] 점 증가한다."
  },
  RelicConfig_97344_Name = {
    Text = "미사그 우승컵"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "오늘, 우리는 두려움을 잊고, 고통을 잊고, 오직 축제를 즐기겠습니다."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "지시 카드를 3장 사용하면 1 pt 행동력을 얻고 1장의 카드를 뽑습니다. 각 주 회피 시 임시 최종 피해를 2% 증가시켜 최대 50%에 도달합니다."
  },
  RelicConfig_97345_Desc = {
    Text = "지시 카드를 3장 사용하면 1 pt 행동력을 얻고 1장의 카드를 뽑습니다. 각 주 회피 시 임시 최종 피해를 2% 증가시켜 최대 50%에 도달합니다."
  },
  RelicConfig_97345_Name = {
    Text = "미사그 우승컵"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "오늘, 우리는 두려움을 잊고, 고통을 잊고, 오직 축제를 즐기겠습니다."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "모든 깨어남체의 크리티컬 확률이 30% 증가합니다. 홀수 턴 시작 시, 모든 적은 현재 HP의 25%를 잃습니다. 자신의 HP 비율이 적보다 낮을 때, 최종 피해가 50% 증가합니다. 자신의 HP 비율이 적보다 높을 경우, 광기 폭발 후 35 pt의 광기를 얻습니다."
  },
  RelicConfig_97346_Desc = {
    Text = "모든 깨어남체의 크리티컬 확률이 30% 증가합니다. 홀수 턴 시작 시, 모든 적은 현재 HP의 25%를 잃습니다. 자신의 HP 비율이 적보다 낮을 때, 최종 피해가 50% 증가합니다. 자신의 HP 비율이 적보다 높을 경우, 광기 폭발 후 35 pt의 광기를 얻습니다."
  },
  RelicConfig_97346_Name = {
    Text = "미사그 우승컵"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "오늘, 우리는 두려움을 잊고, 고통을 잊고, 오직 축제를 즐기겠습니다."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "최대 행동력이 2pt 증가하고, 사용하지 않은 행동력은 다음 턴으로 남겨둡니다. 만약 2pt 이상의 행동력을 남겼다면, 다음 턴 시작 시 모든 깨어남체가 광기 20pt를 얻습니다. 만약 행동력을 4pt 이상 남겼을 경우, 다음 턴의 기본 피해가 100% 증가합니다."
  },
  RelicConfig_97347_Desc = {
    Text = "최대 행동력이 2pt 증가하고, 사용하지 않은 행동력은 다음 턴으로 남겨둡니다. 만약 2pt 이상의 행동력을 남겼다면, 다음 턴 시작 시 모든 깨어남체가 광기 20pt를 얻습니다. 만약 행동력을 4pt 이상 남겼을 경우, 다음 턴의 기본 피해가 100% 증가합니다."
  },
  RelicConfig_97347_Name = {
    Text = "미사그 우승컵"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "오늘 우리는 두려움과 고통을 잊어버리고, 오직 축제에 흠뻑 빠져듭니다."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "패 상한 +1, 전투 시작 시 「<DerivativeCardKeywords_116:팔레트>」를 획득한다.\n턴 시작 시 「<PrimaryColor:원색>」 1개를 획득하고 랜덤으로 지령 카드 2장에 「<ColorInkKeywords:인지 부조화>」를 부여한다. 「<ColorInkKeywords:인지 부조화>」 카드를 낸 후 순서대로 「<PrimaryColor:원색>」 1개를 획득한다.\n「<PrimaryColor:원색>」을 낸 후 「<DerivativeCardKeywords_116:팔레트>」에 기록되며, 「<DerivativeCardKeywords_116:팔레트>」에 2종류의 서로 다른 「<PrimaryColor:원색>」이 존재하면 지속 버프 효과를 부여한다.\n팔레트에 3종류의 서로 다른 「<PrimaryColor:원색>」이 존재하면, 즉시 모든 적의 최대 HP력의 5%를 잃게 하고 「<DerivativeCardKeywords_116:팔레트>」를 초기화한다."
  },
  RelicConfig_98274_Desc = {
    Text = "패 상한 +1, 전투 시작 시 「<DerivativeCardKeywords_116:팔레트>」를 획득한다.\n턴 시작 시 「<PrimaryColor:원색>」 1개를 획득하고 랜덤으로 지령 카드 2장에 「<ColorInkKeywords:인지 부조화>」를 부여한다. 「<ColorInkKeywords:인지 부조화>」 카드를 낸 후 순서대로 「<PrimaryColor:원색>」 1개를 획득한다.\n「<PrimaryColor:원색>」을 낸 후 「<DerivativeCardKeywords_116:팔레트>」에 기록되며, 「<DerivativeCardKeywords_116:팔레트>」에 2종류의 서로 다른 「<PrimaryColor:원색>」이 존재하면 지속 버프 효과를 부여한다.\n팔레트에 3종류의 서로 다른 「<PrimaryColor:원색>」이 존재하면, 즉시 모든 적의 최대 HP력의 5%를 잃게 하고 「<DerivativeCardKeywords_116:팔레트>」를 초기화한다."
  },
  RelicConfig_98274_Name = {
    Text = "이상 현상의 팔레트"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "징후 속에서, 우리는「예술」의 탄생을 목격할 것입니다."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "모든 깨어남체의 HP 회복과 방어막의 기본 효과가 [Arg1]% 증가한다."
  },
  RelicConfig_98367_Desc = {
    Text = "모든 깨어남체의 HP 회복과 방어막의 기본 효과가 [Arg1]% 증가한다."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:뱀의 허물>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "자신에게 고통을 주는 걸 통한 탈피로 재생성된다."
  },
  RelicConfig_98368_BattleDesc = {
    Text = "전투 시작 시 [Arg1]% 피해 강화를 얻습니다. 매 번 다른 깨어남체의 명령 카드를 플레이할 때마다 추가로 [Arg1]% 임시 피해 강화를 얻습니다."
  },
  RelicConfig_98368_Desc = {
    Text = "전투 시작 시 [Arg1]% 피해 강화를 얻습니다. 매 번 다른 깨어남체의 명령 카드를 플레이할 때마다 추가로 [Arg1]% 임시 피해 강화를 얻습니다."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:만화경+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "생각하고 보는 모든 것이 환상이다."
  },
  RelicConfig_98369_BattleDesc = {
    Text = "은열쇠 깨어남 후 손에 있는 행동력이 가장 높은 [Arg1]장의 카드에 보존 및 준비를 얻도록 하고, [Arg2] 은열쇠 에너지를 획득합니다."
  },
  RelicConfig_98369_Desc = {
    Text = "은열쇠 깨어남 후 손에 있는 행동력이 가장 높은 [Arg1]장의 카드에 보존 및 준비를 얻도록 하고, [Arg2] 은열쇠 에너지를 획득합니다."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:이국적인 우표집>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "정량화된 추억."
  },
  RelicConfig_98370_BattleDesc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] 층 허약과 손상을 가합니다. 「소멸」 후에도 이 효과가 트리거되지만, 3턴의 쿨다운이 있습니다."
  },
  RelicConfig_98370_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1] 층<WeaknessIconKeywords:허약>과<VulnerabilityIconKeywords:취약>를 가합니다. '소멸' 후에도 이 효과가 발동되지만 3 턴의 쿨타임이 있습니다."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:공간 왜곡 장치>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "공간으로 뛰어들기."
  },
  RelicConfig_98371_BattleDesc = {
    Text = "턴 종료 전, 손에 있는 각 명령 카드 소속 깨어남체는 광기 [Arg1]pt를 얻는다."
  },
  RelicConfig_98371_Desc = {
    Text = "턴 종료 전, 손에 있는 각 명령 카드 소속 깨어남체는 광기 [Arg1]pt를 얻는다."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:불균형한 저울>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "더 이상 공정성을 상징하지 않는다."
  },
  RelicConfig_98372_BattleDesc = {
    Text = "턴 종료 시 은열쇠 에너지가 가득 찼다면, [Arg1] pt의 은열쇠 에너지를 소비하여 1장의 <DerivativeCardKeywords_129:“은열쇠 미광”>을 손패에 넣습니다."
  },
  RelicConfig_98372_Desc = {
    Text = "턴 종료 시 은열쇠 에너지가 가득 찼다면, [Arg1] pt의 은열쇠 에너지를 소비하여 1장의 <DerivativeCardKeywords_129:“은열쇠 미광”>을 손패에 넣습니다."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:황혼 속에서>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "함께 사진을 찍어봐! 진실타래한 고통을 체험해보자."
  },
  RelicConfig_98373_BattleDesc = {
    Text = "「광기 폭발」을 발동하여 [Arg1] 은열쇠 에너지를 획득한다."
  },
  RelicConfig_98373_Desc = {
    Text = "「광기 폭발」을 발동하여 [Arg1] 은열쇠 에너지를 획득한다."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:아름다운 순간+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "순간의 아름다움을 영원히 보관합니다."
  },
  RelicConfig_98374_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」 이후 모든 적에게 [Arg1] 레이어의 중독을 적용하고 [Arg2] 레이어의 반격을 얻습니다."
  },
  RelicConfig_98374_Desc = {
    Text = "매 회합 최초「은열쇠」 후 모든 적에게 [Arg1] 층<IntoxicationIconKeywords:중독>을 적용하고, [Arg2] 층<RetaliateIconKeywords:반격>을 얻습니다."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:선지자의 소원 램프+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "당신의 소원에 답합니다."
  },
  RelicConfig_98375_BattleDesc = {
    Text = "턴 종료 시, 은열쇠 에너지가 최대일 경우, 은열쇠 에너지를 [Arg1] 소모하여 「은열쇠의 새벽빛」 1장을 손패에 추가합니다."
  },
  RelicConfig_98375_Desc = {
    Text = "턴 종료 시, 은열쇠 에너지가 최대일 경우, 은열쇠 에너지를 [Arg1] 소모하여 「은열쇠의 새벽빛」 1장을 손패에 추가합니다."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:황혼 속에서+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "함께 사진을 찍어봐! 진실타래한 고통을 체험해보자."
  },
  RelicConfig_98376_BattleDesc = {
    Text = "모든 깨어남체의 HP 회복과 방어막의 기본 효과가 [Arg1]% 증가한다."
  },
  RelicConfig_98376_Desc = {
    Text = "모든 깨어남체의 HP 회복과 방어막의 기본 효과가 [Arg1]% 증가한다."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:뱀의 허물+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "자신에게 고통을 주는 걸 통한 탈피로 재생성된다."
  },
  RelicConfig_98377_BattleDesc = {
    Text = "각 카드가 초차원으로 들어올 시, 드로우 덱에서 해당 카드 소속 깨어남체의 명령 카드를 [Arg1]장 드로우한다. 드로우할 수 없다면 동일한 양의 행동력을 획득한다. 매 턴 최대 2번 발동할 수 있다."
  },
  RelicConfig_98377_Desc = {
    Text = "각 카드가 초차원으로 들어올 시, 드로우 덱에서 해당 카드 소속 깨어남체의 명령 카드를 [Arg1]장 드로우한다. 드로우할 수 없다면 동일한 양의 행동력을 획득한다. 매 턴 최대 2번 발동할 수 있다."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:프리즘>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "“빛은 일곱 가지 색으로 이루어져 있습니다.”"
  },
  RelicConfig_98378_BattleDesc = {
    Text = "전투 시작 시 [Arg1]% 피해 강력을 얻습니다. 피해를 받을 때 [Arg2] 반격을 얻고, 한 턴에 최대 3회 트리거됩니다."
  },
  RelicConfig_98378_Desc = {
    Text = "전투 시작 시 [Arg1]%의 피해 증폭을 얻습니다. 피해를 입었을 때 [Arg2] <RetaliateIconKeywords:반격>을 얻으며, 매 턴 최대 3번 발동됩니다."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:안전 출구+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "보아하니, 그도 도망치지 못한 것 같습니다."
  },
  RelicConfig_98379_BattleDesc = {
    Text = "능동적 피해나 촉수 피해를 입힌 후, 그 턴에 대상이 입는 촉수 피해가 [Arg1]% 증가하며, 매 턴 최대 20번 발동할 수 있습니다."
  },
  RelicConfig_98379_Desc = {
    Text = "능동적 피해나 촉수 피해를 입힌 후, 그 턴에 대상이 입는 촉수 피해가 [Arg1]% 증가하며, 매 턴 최대 20번 발동할 수 있습니다."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:잠수 헬멧>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "꿈은 별빛 바다야!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "전투 시작 시와 죽음 저항 발동 후 은열쇠 에너지를 [Arg1] 얻는다."
  },
  RelicConfig_98380_Desc = {
    Text = "전투 시작 시와 죽음 저항 발동 후 은열쇠 에너지를 [Arg1] 얻는다."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:과거의 공물>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "진헌되었던 물건."
  },
  RelicConfig_98381_BattleDesc = {
    Text = "은열쇠를 깨어남한 후, HP [Heal:Arg1]pt를 회복하고 은열쇠 에너지를 [Arg2] 획득한다."
  },
  RelicConfig_98381_Desc = {
    Text = "은열쇠를 깨어남한 후, HP [Heal:Arg1]pt를 회복하고 은열쇠 에너지를 [Arg2] 획득한다."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:여행양산>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "빛이 스며들지 않는 땅에서 피어오르다."
  },
  RelicConfig_98382_BattleDesc = {
    Text = "전투 시작 시 [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 얻습니다. 홀수 턴 시작 시 [Arg2] 장의 카드를 뽑고, 짝수 턴 시작 시 [Arg2] 점의 행동력을 얻습니다."
  },
  RelicConfig_98382_Desc = {
    Text = "전투 시작 시 [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 얻습니다. 홀수 턴 시작 시 [Arg2] 장의 카드를 뽑고, 짝수 턴 시작 시 [Arg2] 점의 행동력을 얻습니다."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:일월 루프+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "추측해 보세요, 검은색이나 하얀색일까요?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」로 모든 촉수가 적을 [Arg1]번 공격하며, 50% 피해를 입힙니다."
  },
  RelicConfig_98383_Desc = {
    Text = "매 턴 첫 번째 「열쇠」로 모든 촉수가 적을 [Arg1]번 공격하며, 50% 피해를 입힙니다."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:노란 달팽이+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "이 작은 소황나사의 출신은 고귀하며, 완벽하고 흠잡을 데 없는 기원을 가지고 있습니다."
  },
  RelicConfig_98384_BattleDesc = {
    Text = "모든 깨어남체의 기초 피해량이 [Arg1]% 증가합니다. 광기 폭발을 발동하기 전에, 이를 발동한 깨어남체의 기초 피해량이 임시로 [Arg2]% 증가합니다."
  },
  RelicConfig_98384_Desc = {
    Text = "모든 깨어남체의 기초 피해량이 [Arg1]% 증가합니다. 광기 폭발을 발동하기 전에, 이를 발동한 깨어남체의 기초 피해량이 임시로 [Arg2]% 증가합니다."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:잊혀진 자의 피>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "점점 소멸된다."
  },
  RelicConfig_98385_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」 이후 모든 적에게 [Arg1] 레이어의 중독을 적용하고 [Arg2] 레이어의 반격을 얻습니다."
  },
  RelicConfig_98385_Desc = {
    Text = "매 회합 최초「은열쇠」 후 모든 적에게 [Arg1] 층<IntoxicationIconKeywords:중독>을 적용하고, [Arg2] 층<RetaliateIconKeywords:반격>을 얻습니다."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:선지자의 소원 램프>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "당신의 소원에 답합니다."
  },
  RelicConfig_98386_BattleDesc = {
    Text = "턴 시작 시 HP가 50% 이하일 시, 임시 피해 증폭이 [Arg1]% 증가한다. HP가 25% 이하라면, 추가로 카드 [Arg2]장을 드로우해 행동력을 [Arg2] 획득한다."
  },
  RelicConfig_98386_Desc = {
    Text = "턴 시작 시 HP가 50% 이하일 시, 임시 피해 증폭이 [Arg1]% 증가한다. HP가 25% 이하라면, 추가로 카드 [Arg2]장을 드로우해 행동력을 [Arg2] 획득한다."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:의사의 가방>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "의사의 신분을 상징하는 가방, 아주 무겁다.\n그것을 여는 사람이 진짜 의사가 아닐 수 있다."
  },
  RelicConfig_98387_BattleDesc = {
    Text = "전투 시작 시 전체 적에게 허약과 취약을 [Arg1]스택 입힌다. 「소멸」 후에도 해당 효과는 발동되지만, 재사용 대기 시간이 3턴 존재한다."
  },
  RelicConfig_98387_Desc = {
    Text = "전투 시작 시 전체 적에게 <WeaknessIconKeywords:허약>과<VulnerabilityIconKeywords:취약>을 [Arg1]스택 입힌다. 「소멸」 후에도 해당 효과는 발동되지만, 재사용 대기 시간이 3턴 존재한다."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:공간 왜곡 장치+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "공간으로 뛰어들기."
  },
  RelicConfig_98388_BattleDesc = {
    Text = "전투 시작 시와 죽음 저항 발동 후 은열쇠 에너지를 [Arg1] 얻는다."
  },
  RelicConfig_98388_Desc = {
    Text = "전투 시작 시와 죽음 저항 발동 후 은열쇠 에너지를 [Arg1] 얻는다."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:과거의 공물+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "진헌되었던 물건."
  },
  RelicConfig_98389_BattleDesc = {
    Text = "전투 시작 시 [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 얻습니다. 홀수 턴 시작 시 [Arg2] 장의 카드를 뽑고, 짝수 턴 시작 시 [Arg2] 점의 행동력을 얻습니다."
  },
  RelicConfig_98389_Desc = {
    Text = "전투 시작 시 [Arg1] <ProficientInRealmsIconKeywords:영역 숙련>을 얻습니다. 홀수 턴 시작 시 [Arg2] 장의 카드를 뽑고, 짝수 턴 시작 시 [Arg2] 점의 행동력을 얻습니다."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:해와 달의 암호>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "추측해 보세요, 검은색이나 하얀색일까요?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "카드를 1장 드로우하거나 버릴 때마다 임시 힘 [Arg1]pt를 얻으며, 매 턴 최대 15회 발동된다."
  },
  RelicConfig_98390_Desc = {
    Text = "카드를 1장 드로우하거나 버릴 때마다 임시 <PowerIconKeywords:힘> [Arg1]pt를 얻으며, 매 턴 최대 15회 발동된다."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:조용한 서곡>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "유명한 바이올리니스트 에릭 아이크슈타인의 바이올린이다.\n허나, 지금은 더 이상 연주할 수 없다."
  },
  RelicConfig_98391_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」로 임시 피해 강효 +[Arg2]%. HP이 낮을수록 효과가 더 강력합니다."
  },
  RelicConfig_98391_Desc = {
    Text = "매 턴 첫 번째 「열쇠」로 임시 피해 강효 +[Arg1]%. HP이 낮을수록 효과가 더 강력합니다."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:하포드의 영약>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "성분이 불명확한 약물입니다. \n유명한 바이올리니스트 에릭이 이를 매우 좋아했다고 합니다."
  },
  RelicConfig_98392_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」로 임시 피해 강효 +[Arg2]%. HP이 낮을수록 효과가 더 강력합니다."
  },
  RelicConfig_98392_Desc = {
    Text = "매 턴 첫 번째 「열쇠」로 임시 피해 강효 +[Arg1]%. HP이 낮을수록 효과가 더 강력합니다."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:하포드의 영약+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "성분이 불명확한 약물입니다. \n유명한 바이올리니스트 에릭이 이를 매우 좋아했다고 합니다."
  },
  RelicConfig_98393_BattleDesc = {
    Text = "모든 깨어남체의 매 턴 첫 「명령 카드」는 [Arg1] 은열쇠 에너지를 얻습니다."
  },
  RelicConfig_98393_Desc = {
    Text = "모든 깨어남체의 매 턴 첫 「명령 카드」는 [Arg1] 은열쇠 에너지를 얻습니다."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:말빨>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "상인뿐만 아니라 신앙심 깊은 사람도 말을 잘한다."
  },
  RelicConfig_98394_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」 사용 후 소비한 은열쇠 에너지의 [Arg1]%를 반환합니다."
  },
  RelicConfig_98394_Desc = {
    Text = "매 턴 첫 번째 「열쇠」 사용 후 소비한 은열쇠 에너지의 [Arg1]%를 반환합니다."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:행운의 토끼 발>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "토끼에게는 그다지 운이 좋지 않았다."
  },
  RelicConfig_98395_BattleDesc = {
    Text = "전투 시작 시 [Arg1]% 피해 강력을 얻습니다. 적극적인 피해를 가한 후 모든 적에게 [Arg2] 중독을 가하고, 매 턴 최대 5회 트리거됩니다."
  },
  RelicConfig_98395_Desc = {
    Text = "전투 시작 시 [Arg1]%의 피해 증폭을 얻습니다. 능동 피해를 입힌 후 모든 적에게 [Arg2] <IntoxicationIconKeywords:중독>을 가하며, 매 턴 최대 5번 발동됩니다."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:사제의 지팡이+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "허락되지 않은 성실타래."
  },
  RelicConfig_98396_BattleDesc = {
    Text = "전투 시작 시 [Arg1]% 피해 강화를 얻습니다. 매 번 다른 깨어남체의 명령 카드를 플레이할 때마다 추가로 [Arg1]% 임시 피해 강화를 얻습니다."
  },
  RelicConfig_98396_Desc = {
    Text = "전투 시작 시 [Arg1]% 피해 강화를 얻습니다. 매 번 다른 깨어남체의 명령 카드를 플레이할 때마다 추가로 [Arg1]% 임시 피해 강화를 얻습니다."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:만화경>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "생각하고 보는 모든 것이 환상이다."
  },
  RelicConfig_98397_BattleDesc = {
    Text = "매 턴 두 번째로 「열쇠」를 발동한 후 [Arg1] 은열쇠 에너지를 얻고, 모든 깨어남체가 [Arg2] 광기를 얻습니다."
  },
  RelicConfig_98397_Desc = {
    Text = "매 턴 두 번째로 「열쇠」를 발동한 후 [Arg1] 은열쇠 에너지를 얻고, 모든 깨어남체가 [Arg2] 광기를 얻습니다."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:정밀 계측기+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "인류 역사상 가장 사악한 발명품 중 하나입니다."
  },
  RelicConfig_98398_BattleDesc = {
    Text = "전투 시작 시 모든 적의 임시<ExhaustionIconKeywords:힘>을 [Arg1]만큼 감소시킵니다. '핏빛 용광로'를 사용해도 이 효과가 발동되지만 3 턴의 쿨타임이 있습니다."
  },
  RelicConfig_98398_Desc = {
    Text = "전투 시작 시 모든 적의 임시<ExhaustionIconKeywords:힘>을 [Arg1]만큼 감소시킵니다. '핏빛 용광로'를 사용해도 이 효과가 발동되지만 3 턴의 쿨타임이 있습니다."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:보이지 않는 손+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "살인, 강도, 가려움을 다스리는 데 최고의 도구입니다."
  },
  RelicConfig_98399_BattleDesc = {
    Text = "매 턴 두 번째로 「열쇠」를 발동한 후 [Arg1] 은열쇠 에너지를 얻고, 모든 깨어남체가 [Arg2] 광기를 얻습니다."
  },
  RelicConfig_98399_Desc = {
    Text = "매 턴 두 번째로 「열쇠」를 발동한 후 [Arg1] 은열쇠 에너지를 얻고, 모든 깨어남체가 [Arg2] 광기를 얻습니다."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:정밀 계측기>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "인류 역사상 가장 사악한 발명품 중 하나입니다."
  },
  RelicConfig_98400_BattleDesc = {
    Text = "카드를 1장 드로우하거나 버릴 때마다 임시 힘 [Arg1]pt를 얻으며, 매 턴 최대 15회 발동된다."
  },
  RelicConfig_98400_Desc = {
    Text = "카드를 1장 드로우하거나 버릴 때마다 임시 <PowerIconKeywords:힘> [Arg1]pt를 얻으며, 매 턴 최대 15회 발동된다."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:조용한 서곡+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "유명한 바이올리니스트 에릭 아이크슈타인의 바이올린이다.\n허나, 지금은 더 이상 연주할 수 없다."
  },
  RelicConfig_98401_BattleDesc = {
    Text = "전투 시작 시 피해 증폭을 [Arg1]% 받고, 매 턴 첫 반격을 받은 후 행동력을 [Arg2] 획득한다."
  },
  RelicConfig_98401_Desc = {
    Text = "전투 시작 시 피해 증폭을 [Arg1]% 받고, 매 턴 첫 <RetaliateIconKeywords:반격>을 받은 후에 행동력을 [Arg2]pt 획득한다."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:포트니 아침 신문+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "당신의 변기와 가장 친한 친구입니다."
  },
  RelicConfig_98402_BattleDesc = {
    Text = "능동적 피해나 촉수 피해를 입힌 후, 그 턴에 대상이 입는 촉수 피해가 [Arg1]% 증가하며, 매 턴 최대 20번 발동할 수 있습니다."
  },
  RelicConfig_98402_Desc = {
    Text = "능동적 피해나 촉수 피해를 입힌 후, 그 턴에 대상이 입는 촉수 피해가 [Arg1]% 증가하며, 매 턴 최대 20번 발동할 수 있습니다."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:잠수 헬멧+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "꿈은 별빛 바다야!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "전투 시작 시 [Arg1] 힘을 얻습니다. 「소모」가 있는 카드를 플레이할 때마다 [Arg2] 임시 힘을 얻고, 한 턴에 최대 10회 트리거됩니다."
  },
  RelicConfig_98403_Desc = {
    Text = "전투 시작 시 [Arg1] <PowerIconKeywords:힘>을 얻습니다. '소모'가 있는 카드를 사용할 때마다 [Arg2] 임시<PowerIconKeywords:힘>을 얻으며, 매 턴 최대 10번 발동됩니다."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:작은 오르골+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "덕스터의 저택에는 많은 수집품이 있습니다. 부서지기 전에, 작은 팔음함은 덕스터 양반님의 가장 좋아하던 장난감이었습니다. \n세월이 흘러, 덕스터 양반님이 다시 그녀를 찾았을 때, 그녀의 기어는 느슨해지고 음악은 변조되었지만, 여전히 회전을 멈추지 않았습니다."
  },
  RelicConfig_98404_BattleDesc = {
    Text = "「광기 폭발」을 발동하여 [Arg1] 은열쇠 에너지를 획득한다."
  },
  RelicConfig_98404_Desc = {
    Text = "「광기 폭발」을 발동하여 [Arg1] 은열쇠 에너지를 획득한다."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:아름다운 순간>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "순간의 아름다움을 영원히 보관합니다."
  },
  RelicConfig_98405_BattleDesc = {
    Text = "모든 깨어남체의 매 턴 첫 「명령 카드」는 [Arg1] 은열쇠 에너지를 얻습니다."
  },
  RelicConfig_98405_Desc = {
    Text = "모든 깨어남체의 매 턴 첫 「명령 카드」는 [Arg1] 은열쇠 에너지를 얻습니다."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:말재간+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "상인뿐만 아니라 신앙심 깊은 사람도 말을 잘한다."
  },
  RelicConfig_98406_BattleDesc = {
    Text = "「배아」 1개 생성 시, [Arg1] 스칼렛 용광로를 얻습니다. 매 턴 최대 3번 발동할 수 있습니다."
  },
  RelicConfig_98406_Desc = {
    Text = "「배아」 1개 생성 시, [Arg1] 스칼렛 용광로를 얻습니다. 매 턴 최대 3번 발동할 수 있습니다."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:사랑스러운 아기+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "목수가 아내를 위해 생동감 넘치는 목각 인형을 만들었고, 그것은 그들의 아들을 대신해 그녀의 배 속에서 잠들어 있게 될 것이다."
  },
  RelicConfig_98407_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」 사용 후 소비한 은열쇠 에너지의 [Arg1]%를 반환합니다."
  },
  RelicConfig_98407_Desc = {
    Text = "매 턴 첫 번째 「열쇠」 사용 후 소비한 은열쇠 에너지의 [Arg1]%를 반환합니다."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:행운의 토끼 발+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "토끼에게는 그다지 운이 좋지 않았다."
  },
  RelicConfig_98408_BattleDesc = {
    Text = "턴 시작 시, 모든 광기가 부족하여 광기 폭발을 사용할 수 없는 깨어남체는 [Arg1] 점의 광기를 얻습니다。"
  },
  RelicConfig_98408_Desc = {
    Text = "턴 시작 시, 모든 광기가 부족하여 광기 폭발을 사용할 수 없는 깨어남체는 [Arg1] 점의 광기를 얻습니다。"
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:이스터 에그 타임>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "즐거움을 마음껏 누리되 섭취할 수 없습니다."
  },
  RelicConfig_98409_BattleDesc = {
    Text = "전투 시작 시 모든 적의 임시<ExhaustionIconKeywords:힘>을 [Arg1]만큼 감소시킵니다. '핏빛 용광로'를 사용해도 이 효과가 발동되지만 3 턴의 쿨타임이 있습니다."
  },
  RelicConfig_98409_Desc = {
    Text = "전투 시작 시 모든 적의 임시<ExhaustionIconKeywords:힘>을 [Arg1]만큼 감소시킵니다. '핏빛 용광로'를 사용해도 이 효과가 발동되지만 3 턴의 쿨타임이 있습니다."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:보이지 않는 손>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "살인, 강도, 가려움을 다스리는 데 최고의 도구입니다."
  },
  RelicConfig_98410_BattleDesc = {
    Text = "「배아」 1개 생성 시, [Arg1] 스칼렛 용광로를 얻습니다. 매 턴 최대 3번 발동할 수 있습니다."
  },
  RelicConfig_98410_Desc = {
    Text = "「배아」 1개 생성 시, [Arg1] 스칼렛 용광로를 얻습니다. 매 턴 최대 3번 발동할 수 있습니다."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:사랑스러운 아기>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "목수가 아내를 위해 생동감 넘치는 목각 인형을 만들었고, 그것은 그들의 아들을 대신해 그녀의 배 속에서 잠들어 있게 될 것이다."
  },
  RelicConfig_98411_BattleDesc = {
    Text = "턴이 시작할 때, 만약 은열쇠 에너지가 [Arg1]보다 크면 [Arg1] 점의 은열쇠 에너지를 소모하여 1장의 <DerivativeCardKeywords_115:「고급 영감」>을 손으로 가져온다."
  },
  RelicConfig_98411_Desc = {
    Text = "턴이 시작할 때, 만약 은열쇠 에너지가 [Arg1]보다 크면 [Arg1] 점의 은열쇠 에너지를 소모하여 1장의 <DerivativeCardKeywords_115:「고급 영감」>을 손으로 가져온다."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:야몽의 표상>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "조심하세요, 방종한 심면은 당신이 모르는 사이에 모든 것을 흡수할 것입니다."
  },
  RelicConfig_98412_BattleDesc = {
    Text = "5회「광기 폭발」을 해방하면, 다음 [Arg1] 장의 비파생 명령 카드가 추가 발동된다."
  },
  RelicConfig_98412_Desc = {
    Text = "5회「광기 폭발」을 해방하면, 다음 [Arg1] 장의 비파생 명령 카드가 추가 발동된다."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:별빛술+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "별들 사이를 거닐다."
  },
  RelicConfig_98413_BattleDesc = {
    Text = "전투 시작 시 [Arg1]% 피해 강력을 얻습니다. 피해를 받을 때 [Arg2] 반격을 얻고, 한 턴에 최대 3회 트리거됩니다."
  },
  RelicConfig_98413_Desc = {
    Text = "전투 시작 시 [Arg1]%의 피해 증폭을 얻습니다. 피해를 입었을 때 [Arg2] <RetaliateIconKeywords:반격>을 얻으며, 매 턴 최대 3번 발동됩니다."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:안전 출구>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "보아하니, 그도 도망치지 못한 것 같습니다."
  },
  RelicConfig_98414_BattleDesc = {
    Text = "모든 깨어남체의 기초 피해량이 [Arg1]% 증가합니다. 광기 폭발을 발동하기 전에, 이를 발동한 깨어남체의 기초 피해량이 임시로 [Arg2]% 증가합니다."
  },
  RelicConfig_98414_Desc = {
    Text = "모든 깨어남체의 기초 피해량이 [Arg1]% 증가합니다. 광기 폭발을 발동하기 전에, 이를 발동한 깨어남체의 기초 피해량이 임시로 [Arg2]% 증가합니다."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:잊혀진 자의 피+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "점점 소멸된다."
  },
  RelicConfig_98415_BattleDesc = {
    Text = "은열쇠를 깨어남한 후, HP [Heal:Arg1]pt를 회복하고 은열쇠 에너지를 [Arg2] 획득한다."
  },
  RelicConfig_98415_Desc = {
    Text = "은열쇠를 깨어남한 후, HP [Heal:Arg1]pt를 회복하고 은열쇠 에너지를 [Arg2] 획득한다."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:여행용 양산+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "빛이 스며들지 않는 땅에서 피어오르다."
  },
  RelicConfig_98416_BattleDesc = {
    Text = "전투 시작 시 피해 증폭 [Arg1]%를 얻고, 매 턴 첫 번째로 반격을 받는다면 행동력을 [Arg2] 얻는다."
  },
  RelicConfig_98416_Desc = {
    Text = "전투 시작 시 피해 증폭 [Arg1]%를 얻고, 매 턴 첫 번째에 <RetaliateIconKeywords:반격>을 받는다면 행동력을 [Arg2] 얻는다."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:포트니 아침 신문>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "당신의 변기와 단짝친구다."
  },
  RelicConfig_98417_BattleDesc = {
    Text = "턴 시작 시, 모든 광기가 부족하여 광기 폭발을 사용할 수 없는 깨어남체는 [Arg1] 점의 광기를 얻습니다。"
  },
  RelicConfig_98417_Desc = {
    Text = "턴 시작 시, 모든 광기가 부족하여 광기 폭발을 사용할 수 없는 깨어남체는 [Arg1] 점의 광기를 얻습니다。"
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:이스터 에그+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "즐거움을 마음껏 누리되 섭취할 수 없습니다."
  },
  RelicConfig_98418_BattleDesc = {
    Text = "전투 시작 시 피해 증폭 [Arg1]%를 얻는다. 매 턴 첫 번째에 중독을 적용한 후 카드 [Arg2]장을 드로우한다."
  },
  RelicConfig_98418_Desc = {
    Text = "전투 시작 시 피해 증폭 [Arg1]%를 얻는다. 매 턴 첫 번째에 <IntoxicationIconKeywords:중독>을 적용한 후 카드 [Arg2]장을 드로우한다."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:라인드의 고문서+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "질문에 귀 기울여보세요: 승려 10명이 빵 6개를 나누어 가지려 합니다. 승려 1명당 각각 몇 개씩 얻을까요?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "5회「광기 폭발」을 해방하면, 다음 [Arg1] 장의 비파생 명령 카드가 추가 발동된다."
  },
  RelicConfig_98419_Desc = {
    Text = "5회「광기 폭발」을 해방하면, 다음 [Arg1] 장의 비파생 명령 카드가 추가 발동된다."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:별빛의 술>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "별들 사이를 거닐다."
  },
  RelicConfig_98420_BattleDesc = {
    Text = "각 카드가 초차원으로 들어올 시, 드로우 덱에서 해당 카드 소속 깨어남체의 명령 카드를 [Arg1]장 드로우한다. 드로우할 수 없다면 동일한 양의 행동력을 획득한다. 매 턴 최대 2번 발동할 수 있다."
  },
  RelicConfig_98420_Desc = {
    Text = "각 카드가 초차원으로 들어올 시, 드로우 덱에서 해당 카드 소속 깨어남체의 명령 카드를 [Arg1]장 드로우한다. 드로우할 수 없다면 동일한 양의 행동력을 획득한다. 매 턴 최대 2번 발동할 수 있다."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:삼각 프리즘+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "“빛은 일곱 가지 색으로 이루어져 있습니다.”"
  },
  RelicConfig_98421_BattleDesc = {
    Text = "은열쇠 깨어남 후 손에 있는 행동력이 가장 높은 [Arg1]장의 카드에 보존 및 준비를 얻도록 하고, [Arg2] 은열쇠 에너지를 획득합니다."
  },
  RelicConfig_98421_Desc = {
    Text = "은열쇠 깨어남 후 손에 있는 행동력이 가장 높은 [Arg1]장의 카드에 보존 및 준비를 얻도록 하고, [Arg2] 은열쇠 에너지를 획득합니다."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:이국의 우편집+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "정량화된 추억."
  },
  RelicConfig_98422_BattleDesc = {
    Text = "턴 종료 전, 손에 있는 각 명령 카드의 소속 깨어남체는 광기 [Arg1]pt를 얻는다."
  },
  RelicConfig_98422_Desc = {
    Text = "턴 종료 전, 손에 있는 각 명령 카드의 소속 깨어남체는 광기 [Arg1]pt를 얻는다."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:기울어진 저울+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "더 이상 공정성을 상징하지 않는다."
  },
  RelicConfig_98423_BattleDesc = {
    Text = "전투 시작 시 [Arg1]% 피해 강력을 얻습니다. 적극적인 피해를 가한 후 모든 적에게 [Arg2] 중독을 가하고, 매 턴 최대 5회 트리거됩니다."
  },
  RelicConfig_98423_Desc = {
    Text = "전투 시작 시 [Arg1]%의 피해 증폭을 얻습니다. 능동 피해를 입힌 후 모든 적에게 [Arg2] <IntoxicationIconKeywords:중독>을 가하며, 매 턴 최대 5번 발동됩니다."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:제사장 지팡이>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "허락되지 않은 성실타래."
  },
  RelicConfig_98424_BattleDesc = {
    Text = "전투 시작 시 피해 증폭 [Arg1]%를 얻는다. 매 턴 첫 번째에 중독을 적용한 후 카드 [Arg2]장을 드로우한다."
  },
  RelicConfig_98424_Desc = {
    Text = "전투 시작 시 피해 증폭 [Arg1]%를 얻는다. 매 턴 첫 번째에 <IntoxicationIconKeywords:중독>을 적용한 후 카드 [Arg2]장을 드로우한다."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:라이온드 초서>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "질문에 귀 기울여보세요: 승려 10명이 빵 6개를 나누어 가지려 합니다. 승려 1명당 각각 몇 개씩 얻을까요?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "전투 시작 시 [Arg1] 힘을 얻습니다. 「소모」가 있는 카드를 플레이할 때마다 [Arg2] 임시 힘을 얻고, 한 턴에 최대 10회 트리거됩니다."
  },
  RelicConfig_98425_Desc = {
    Text = "전투 시작 시 [Arg1] <PowerIconKeywords:힘>을 얻습니다. '소모'가 있는 카드를 사용할 때마다 [Arg2] 임시<PowerIconKeywords:힘>을 얻으며, 매 턴 최대 10번 발동됩니다."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:작은 오르골>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "덕스터의 저택에는 많은 수집품이 있습니다. 부서지기 전에, 작은 팔음함은 덕스터 양반님의 가장 좋아하던 장난감이었습니다. \n세월이 흘러, 덕스터 양반님이 다시 그녀를 찾았을 때, 그녀의 기어는 느슨해지고 음악은 변조되었지만, 여전히 회전을 멈추지 않았습니다."
  },
  RelicConfig_98426_BattleDesc = {
    Text = "매 턴 첫 번째 「열쇠」로 모든 촉수가 적을 [Arg1]번 공격하며, 50% 피해를 입힙니다."
  },
  RelicConfig_98426_Desc = {
    Text = "매 턴 첫 번째 「열쇠」로 모든 촉수가 적을 [Arg1]번 공격하며, 50% 피해를 입힙니다."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:소황나사>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "이 작은 소황나사의 출신은 고귀하며, 완벽하고 흠잡을 데 없는 기원을 가지고 있습니다."
  },
  RelicConfig_98427_BattleDesc = {
    Text = "턴 시작 시 HP가 50% 이하일 시, 임시 피해 증폭이 [Arg1]% 증가한다. HP가 25% 이하라면, 추가로 카드 [Arg2]장을 드로우해 행동력을 [Arg2] 획득한다."
  },
  RelicConfig_98427_Desc = {
    Text = "턴 시작 시 HP가 50% 이하일 시, 임시 피해 증폭이 [Arg1]% 증가한다. HP가 25% 이하라면, 추가로 카드 [Arg2]장을 드로우해 행동력을 [Arg2] 획득한다."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:의사의 가방+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "의사의 신분을 상징하는 가방, 아주 무겁다.\n그것을 여는 사람이 진짜 의사가 아닐 수 있다."
  },
  RelicConfig_98891_BattleDesc = {
    Text = "전투 시작 후, 5층 「<LostWay:잃어버린 길>」을 얻으며, 지시 카드를 3장 사용할 때마다 1층 감소한다.\n모든 「<LostWay:잃어버린 길>」이 제거된 후, 모든 깨어남체에게 100 pt의 광기를 주며, 지시 카드를 3장 사용할 때마다 [Arg1] pt HP 회복, 전방 적에게 적의 최대 HP의 1%만큼 <Corrosion:부식>을 적용한다."
  },
  RelicConfig_98891_Desc = {
    Text = "전투 시작 후, 5층 「<LostWay:잃어버린 길>」을 얻으며, 지시 카드를 3장 사용할 때마다 1층 감소한다.\n모든 「<LostWay:잃어버린 길>」이 제거된 후, 모든 깨어남체에게 100 pt의 광기를 주며, 지시 카드를 3장 사용할 때마다 [Arg1] pt HP 회복, 전방 적에게 적의 최대 HP의 1%만큼 <Corrosion:부식>을 적용한다."
  },
  RelicConfig_98891_Name = {
    Text = "구조의 성불"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "어두운 시간을 지나도, 구원의 등불은 결국 죽음 속에서 다시 빛날 것이다."
  }
})
return Text_RelicConfig
