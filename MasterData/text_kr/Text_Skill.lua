__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Skill = readonly({
  Skill_100224_Desc = {
    Text = "턴 종료 시 HP를 [Arg1] 회복한다."
  },
  Skill_100224_Name = {
    Text = "그려진「은혜의 피」"
  },
  Skill_100225_Desc = {
    Text = "획득 시 전체 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  Skill_100225_Name = {
    Text = "그려진「봄의 제전」"
  },
  Skill_100226_Desc = {
    Text = "HP를 잃을 때, 잃은 HP의 [Arg1]%만큼 핏빛 용광로를 축적한다."
  },
  Skill_100226_Name = {
    Text = "그려진「녹슨 강톱」"
  },
  Skill_100227_Desc = {
    Text = "매 턴 처음으로 「배아」를 직접 사용한 후, 이번 턴에 능동 피해를 줄 때 피해량의 [Arg1]%에 해당하는 <BleedingIconKeywords:출혈>을 추가로 부여한다."
  },
  Skill_100227_Name = {
    Text = "그려진「피 묻은 자갈」"
  },
  Skill_100228_Desc = {
    Text = "피해를 줄 때마다 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다. 매 턴 최대 15회까지 발동한다."
  },
  Skill_100228_Name = {
    Text = "그려진「실타래올 마노」"
  },
  Skill_100229_Desc = {
    Text = "「광기 폭발」 발동 후 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_100229_Name = {
    Text = "그려진 「무거운 자물쇠」"
  },
  Skill_100230_Desc = {
    Text = "「광기 폭발」 발동 후 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_100230_Name = {
    Text = "그려진 「무거운 자물쇠」"
  },
  Skill_100231_Desc = {
    Text = "매 턴 처음으로 <DevouredIconKeywords:포식>이 발동될 때 다른 깨어남체가 [Arg1]의 광기를 획득한다."
  },
  Skill_100231_Name = {
    Text = "그려진「황금빛 꿈의 나라」"
  },
  Skill_100232_Desc = {
    Text = "획득 시 전체 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  Skill_100232_Name = {
    Text = "그려진「봄의 제전」"
  },
  Skill_100233_Desc = {
    Text = "HP를 잃을 때, 잃은 HP의 [Arg1]%만큼 핏빛 용광로를 축적한다."
  },
  Skill_100233_Name = {
    Text = "그려진「녹슨 강톱」"
  },
  Skill_100234_Desc = {
    Text = "턴 종료 시 HP를 [Arg1] 회복한다."
  },
  Skill_100234_Name = {
    Text = "그려진「은혜의 피」"
  },
  Skill_100235_Desc = {
    Text = "피해를 줄 때마다 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다. 매 턴 최대 15회까지 발동한다."
  },
  Skill_100235_Name = {
    Text = "그려진「실타래올 마노」"
  },
  Skill_100236_Desc = {
    Text = "획득 시 전체 적에게 <WeaknessIconKeywords:허약> [Arg1]스택을 부여한다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  Skill_100236_Name = {
    Text = "그려진「악동」"
  },
  Skill_100237_Desc = {
    Text = "획득 시 전체 적에게 <WeaknessIconKeywords:허약> [Arg1]스택을 부여한다. 모든 깨어남체가 주는 기본 피해가 [Arg2]% 증가한다."
  },
  Skill_100237_Name = {
    Text = "그려진「악동」"
  },
  Skill_100238_Desc = {
    Text = "매 턴 처음으로 「배아」를 직접 사용한 후, 이번 턴에 능동 피해를 줄 때 피해량의 [Arg1]%에 해당하는 <BleedingIconKeywords:출혈>을 추가로 부여한다."
  },
  Skill_100238_Name = {
    Text = "그려진「피 묻은 자갈」"
  },
  Skill_100239_Desc = {
    Text = "매 턴 처음으로 <DevouredIconKeywords:포식>이 발동될 때 다른 깨어남체가 [Arg1]의 광기를 획득한다."
  },
  Skill_100239_Name = {
    Text = "그려진「황금빛 꿈의 나라」"
  },
  Skill_100304_Desc = {
    Text = "깨어남체 1명을 선택하여 [Arg1]pt의 광기를 획득하고, 덱에 <DerivativeCardKeywords_4:「영감」> 1장을 섞어 넣는다. 픽맨이 팀에 있을 경우, 그에게 「<Chuangyi:창의>」 1스택을 부여한다."
  },
  Skill_100304_Name = {
    Text = "허무의 색채"
  },
  Skill_100467_Desc = {
    Text = "창의 10스택"
  },
  Skill_100467_Name = {
    Text = "10스택 창의"
  },
  Skill_100598_Desc = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg1]pt, <Undercurrent:암류> [Arg2]스택, 임시 촉수 2개를 획득한다."
  },
  Skill_100598_Name = {
    Text = "깊은 암류"
  },
  Skill_100599_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 대상의 <IntoxicationIconKeywords:중독> 1스택당 피해가 1pt 증가한다. <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  Skill_100599_Name = {
    Text = "광열의 바다"
  },
  Skill_100600_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 대상의 <IntoxicationIconKeywords:중독> 1스택당 피해가 1pt 증가한다. 「<FlickeringCandle:희미한 촛불>」 1스택을 부여한다."
  },
  Skill_100600_Name = {
    Text = "광열의 바다"
  },
  Skill_100601_Desc = {
    Text = "적의 「<FlickeringCandle:희미한 촛불>」을 동일한 양의 「<LightOfTheLost:항해의 빛>」으로 업그레이드하고, 최대 촉수 수를 3 증가시킨다."
  },
  Skill_100601_Name = {
    Text = "붕괴의 집념"
  },
  Skill_100602_Desc = {
    Text = "이 의도로 전환할 때 1배의 임시 촉수를 생성하고, <TentacleInjurieIconKeywords:촉수 피해>가 임시로 50% 감소한다. 실타래드를 <Block:[Block:Arg1]>pt 획득하고 1턴간 부정 상태에 면역이 된다."
  },
  Skill_100602_Name = {
    Text = "잃어버린 고대의 도시"
  },
  Skill_100603_Desc = {
    Text = "이 의도로 전환할 때 1배의 임시 촉수를 생성하고, <TentacleInjurieIconKeywords:촉수 피해>가 임시로 50% 감소한다. 실타래드를 <Block:[Block:Arg1]>pt 획득하고 1턴간 부정 상태에 면역이 된다."
  },
  Skill_100603_Name = {
    Text = "잃어버린 고대의 도시"
  },
  Skill_100604_Desc = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg1]pt, <Undercurrent:암류> [Arg2]스택, 임시 촉수 2개를 획득한다."
  },
  Skill_100604_Name = {
    Text = "깊은 암류"
  },
  Skill_116332_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 현재 실타래드의 10%만큼 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_116332_Name = {
    Text = "찰나의 꿈"
  },
  Skill_116513_Desc_1 = {
    Text = "<PVPCapKeywords:최대 산출력> +[Arg1]. 상대방 <PVPCapKeywords:최대 산출력> +[Arg2]."
  },
  Skill_116513_Name_1 = {
    Text = "단꿈의 순간"
  },
  Skill_116513_UnknownName = {
    Text = "단꿈의 순간"
  },
  Skill_117171_Desc_1 = {
    Text = "전체 적의 <PVPCorrosionKeywords:죄인>을 발동시키고, 피해량만큼 HP를 회복한다."
  },
  Skill_117171_Name_1 = {
    Text = "광명의 길"
  },
  Skill_117172_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_18:「고통의 근원·지식」>, <PVPDerivativeCardKeywords_19:「영혼의 족쇄·미혹」>, <PVPDerivativeCardKeywords_20:「파멸의 신앙·집착」> 각 1장을 손에 넣는다."
  },
  Skill_117172_Name_1 = {
    Text = "무죄의 성재"
  },
  Skill_117173_Desc_1 = {
    Text = "적 한 명의 긍정 상태를 해제하고, 그에게 <Damage:[Damage:Arg1]>의 피해를 주며, <PVPEntanglementKeywords:엉킴>을 부여한다. 전체 적의 <PVPCorrosionKeywords:죄인>을 발동시켜 <Damage:[Arg2]>의 HP를 잃는다."
  },
  Skill_117173_Name_1 = {
    Text = "파멸의 신앙·집착"
  },
  Skill_117174_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> <PVPCorrosionKeywords:죄인>을 부여하고, <Damage:[Arg2]> HP를 잃고,"
  },
  Skill_117174_Name_1 = {
    Text = "모독의 성심"
  },
  Skill_117175_Desc_1 = {
    Text = "대상에게 <PVPVulnerabilityIconKeywords:취약>과 <PVPWeaknessKeywords:허약>을 부여하고, <Damage:[Damage:Arg1]>의 피해를 준다. 전체 적의 <PVPCorrosionKeywords:죄인>을 발동시켜 HP를 <Damage:[Arg2]> 잃는다."
  },
  Skill_117175_Name_1 = {
    Text = "영혼의 족쇄·미혹"
  },
  Skill_117176_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_117176_Name_1 = {Text = "타격"},
  Skill_117177_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 [Arg1] <PVPCorrosionKeywords:죄인>을 부여하고 <Damage:[Damage:Arg1]> 피해를 입힌다."
  },
  Skill_117177_Name_1 = {
    Text = "무망의 귀의"
  },
  Skill_117178_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, <DisarmKeywords:마비>, <PVPMethysisKeywords:중독>. 전체 적의 <PVPCorrosionKeywords:죄인>을 발동하여 <Damage:[Arg2]> 생명력을 잃습니다."
  },
  Skill_117178_Name_1 = {
    Text = "고통의 근원·지식"
  },
  Skill_117207_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 전과 턴 종료 시, <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 스택의 <PVPCorrosionKeywords:죄인>을 부여한다."
  },
  Skill_117207_Name_1 = {
    Text = "왜곡된 기사시"
  },
  Skill_117208_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 사용 시 및 턴 종료 시, 광기가 가장 높은 적에게 [Arg1]의 <PVPfengsuoKeywords:폭발 봉인>을 부여한다."
  },
  Skill_117208_Name_1 = {
    Text = "성자의 얼굴"
  },
  Skill_117272_Desc = {
    Text = "모든 손패를 버리고 카드를 5장 뽑은 후, 「순환의 그림자」를 손패, 덱, 버린 카드 더미에 각각 1장씩 넣는다."
  },
  Skill_117272_Name = {
    Text = "먼 옛날의 환상"
  },
  Skill_117274_Desc = {
    Text = "「추억 효과」 3개를 <FaxianKeywords:발견>하고 1개를 선택하여 발동하며, 열쇠 에너지를 <Posse:[Arg1]>pt 획득하고, 소모된 카드 중 「심해의 반향」 각인이 있는 무작위 카드 1장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: 모든 깨어남체가 광기 5pt를 획득한다."
  },
  Skill_117274_Name = {
    Text = "순환의 그림자"
  },
  Skill_117275_Desc = {
    Text = "「추억 효과」 3개를 <FaxianKeywords:발견>하고 1개를 선택하여 발동한다. <RippleKeywords:여파>: 모든 깨어남체가 광기 5pt를 획득한다."
  },
  Skill_117275_Name = {
    Text = "순환의 그림자"
  },
  Skill_117276_BattleDesc = {
    Text = "모든 손패를 버리고 카드를 5장 뽑은 후, 「순환의 그림자」를 손패, 덱, 버린 카드 더미에 각각 1장씩 넣는다. [Arg1]회 사용 가능하다."
  },
  Skill_117276_Desc = {
    Text = "모든 손패를 버리고 카드를 5장 뽑은 후, 「순환의 그림자」를 손패, 덱, 버린 카드 더미에 각각 1장씩 넣는다. 3회 사용 가능하다."
  },
  Skill_117276_Name = {
    Text = "먼 옛날의 환상"
  },
  Skill_117277_Desc = {
    Text = "손에서 비파생 명령 카드 1장을 선택하여, 이번 전투 동안 해당 카드가 주는 피해, 실타래드, HP 회복량을 [Arg1]% 증가시키며, 다음에 사용하기 전까지 비용이 0이 된다."
  },
  Skill_117277_Name = {
    Text = "미완성된 밀랍상"
  },
  Skill_117278_Desc = {
    Text = "「추억 효과」 3개를 <FaxianKeywords:발견>하고 1개를 선택하여 발동하며, 열쇠 에너지를 <Posse:[Arg1]>pt 획득한다. <RippleKeywords:여파>: 모든 깨어남체가 광기 5pt를 획득한다."
  },
  Skill_117278_Name = {
    Text = "순환의 그림자"
  },
  Skill_117301_Desc = {
    Text = "손에서 비파생 명령 카드 1장을 선택하여, 해당 카드의 <DepleteIconKeywords:소모>가 부여된 원본 복사본 3장을 덱에 섞어 넣는다. 이 카드들은 다음에 사용하기 전까지 비용이 1 감소한다."
  },
  Skill_117301_Name = {
    Text = "풍요로운 핵"
  },
  Skill_117302_Desc_1 = {
    Text = "행동력 소모가 가장 높은 「스킬」 [Arg1]장을 뽑고, 그 카드에게 <PrepareKeywords:예비2>를 부여한다."
  },
  Skill_117302_Name_1 = {
    Text = "피의 성심"
  },
  Skill_117302_UnknownName = {
    Text = "피의 성심"
  },
  Skill_117312_AwakerSkillBackgroundStory = {
    Text = "유리에트는 말했었다, 세상은 불결하며, 교회의 사명은 세상의 죄악을 씻는 것이라고.\n그는 신이 선택한 성자이며, 그는 여러 가지 시험을 통과하고 신성한 마음을 가졌다.\n조용한 기도를 몇 마디만으로도, 경건한 신자는 감동의 눈물을 흘릴 수 있다.\n그 마음을 심지처럼 태우고, 그의 은혜를 주도록 하라, 그 빛의 비추임 아래, 반드시 순결한 축복을 가져올 것이다."
  },
  Skill_117312_Desc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 행동력 소모가 가장 낮은 명령 카드 2장을 드로우한다."
  },
  Skill_117312_EffectNameList = {Text = "피해"},
  Skill_117312_Name = {
    Text = "영혼을 태우는 등불"
  },
  Skill_117312_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_117313_AwakerSkillBackgroundStory = {
    Text = "그가 내린 축복은 칠흑의 독주이다."
  },
  Skill_117313_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_117313_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 폴룩스가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_117313_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_117313_Name = {Text = "타격"},
  Skill_117313_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_117314_AwakerSkillBackgroundStory = {
    Text = "그들은 죄가 있다, 흘러내리는 검은 신혈은 그 증거이다.\n그들은 심판을 받아야 하며, 죄를 씻어내야만 정토에 갈 수 있다.\n판결하라, 그들의 죄를 선언하고, 그들의 피를 흘리게 하며, 그들에게 형벌을 내리라.\n이것은 성자의 권능과 의무이다."
  },
  Skill_117314_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다. 초차원 턴에 진입할 경우 자동으로 이 카드를 드로우한다."
  },
  Skill_117314_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다. 「성심」을 1장 사용할 때마다 이 카드의 행동력 소모가 1 감소한다. 초차원 턴에 진입할 경우 자동으로 이 카드를 드로우한다."
  },
  Skill_117314_EffectNameList = {Text = "피해"},
  Skill_117314_Name = {
    Text = "부정의 심판"
  },
  Skill_117314_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_117315_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <ZuiyinKeywords:죄인> 3스택을 획득한다. 사용 후 이 카드를 덱 맨 위에 넣는다. 3번째 사용 시 <DepleteIconKeywords:소모>되며, 다음에 사용하는 폴룩스의 명령 카드에 「고통 구원」 효과를 적용한다([Arg2]/3)."
  },
  Skill_117315_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <ZuiyinKeywords:죄인> 3스택을 획득한다. 사용 후 이 카드를 덱 맨 위에 넣는다. 3번째 사용 시 <DepleteIconKeywords:소모>되며, 다음에 사용하는 폴룩스의 명령 카드에 「고통 구원」 효과를 2회 적용한다([Arg2]/3)."
  },
  Skill_117315_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <ZuiyinKeywords:죄인> 3스택을 획득한다. 사용 후 이 카드를 덱 맨 위에 넣는다. 3번째 사용 시 <DepleteIconKeywords:소모>되며, 다음에 사용하는 폴룩스의 명령 카드에 「고통 구원」 효과가 적용된다."
  },
  Skill_117315_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <ZuiyinKeywords:죄인> 3스택을 획득한다. 사용 후 이 카드를 덱 맨 위에 넣는다. 3번째 사용 시 <DepleteIconKeywords:소모>되며, 다음에 사용하는 폴룩스의 명령 카드에 「고통 구원」 효과를 2회 적용한다."
  },
  Skill_117315_Name = {Text = "성심"},
  Skill_117315_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> 점의 피해를 주고, <ZuiyinKeywords:죄 인장> 3층을 획득한다. 사용 후 이 카드를 덱 맨 위에 섞는다. 3번째 사용 시 <DepleteIconKeywords:소모>하고 자신의 다음 커맨드 카드가 「고통 구원」 효과를 받게 한다([Arg2]/3)."
  },
  Skill_117315_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <ZuiyinKeywords:죄인> 3스택을 획득한다. 사용 후 이 카드를 덱 맨 위에 넣는다. 3번째 사용 시 <DepleteIconKeywords:소모>되며, 다음에 사용하는 폴룩스의 명령 카드에 「고통 구원」 효과를 2회 적용한다([Arg2]/3)."
  },
  Skill_117315_tempBattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]> 점의 피해를 주고 [Arg3]% 출혈을 부여하며, <ZuiyinKeywords:죄 인장> 3층을 획득한다. 사용 후 이 카드를 덱 맨 위에 섞는다. 3번째 사용 시 <DepleteIconKeywords:소모>하고 자신의 다음 커맨드 카드가 「고통 구원」 효과를 받게 한다([Arg2]/3)."
  },
  Skill_117315_tempBattleDesc_4 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 입히고 [Arg3]% 출혈을 부여합니다. <ZuiyinKeywords:죄인의 낙인> 3층을 획득합니다. 사용 후 이 카드를 드로우 덱 상단에 섞어 넣습니다. 3번째 사용 시 <DepleteIconKeywords:소모>되며 자신의 다음 명령 카드가 「고통의 구원」 효과를 받고 2회 발동됩니다([Arg2]/3)."
  },
  Skill_117315_tempBattleDesc_5 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히고 [Arg3]% 출혈을 부여하며, <ZuiyinKeywords:죄인> 3중첩을 획득합니다. 사용 후 이 카드를 드로우 더미 상단에 셔플하며, 이번 턴 연산력 소모가 0이 되고 100% 피해의 <BleedingIconKeywords:출혈>을 부여합니다. 3번째 사용 시 <DepleteIconKeywords:소모>되며 자신의 다음 지령 카드에 「고통의 구원」 효과를 부여하고 2회 발동합니다([Arg2]/3)."
  },
  Skill_117316_AwakerSkillBackgroundStory = {
    Text = "이 밝은 마음은 그에게 모든 악을 막아줄 것이다."
  },
  Skill_117316_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg3]>pt 획득한다."
  },
  Skill_117316_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 폴룩스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_117316_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_117316_Name = {Text = "방어"},
  Skill_117316_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_117317_AwakerSkillBackgroundStory = {
    Text = "“‘폴룩스, 너의 성심은 등불을 들고자 하는 이의 광휘를 대행하고 있다. 너는 그를 사랑하는 것처럼 이 영광을 소중히 여겨야 한다.’ \n그래서 그는 그 무형의 관을 머리에 얹고, 소홀히 여기지 않았다. \n‘폴룩스, 두려워하지 마라. 자유의 맛을 느껴보아야 한다……’ \n그는 이 영광으로 모든 것을 얻었지만, 이 영광 때문에 모든 것을 잃었다. 그래서 그는 이 관이 사실타래은 무형의 족쇄일 뿐임을 깨달았다. \n그는 관을 찢어, 그 공허한 심장은 처음으로 낮처럼 밝은 빛을 발하였고, 그 분노의 비명은 더는 다른 사람의 귓가에 전해질 수 없었다.”"
  },
  Skill_117317_Desc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이번 턴에 폴룩스가 다음으로 사용하는 명령 카드에 「고통 구원」 효과가 적용된다. <DerivativeCardKeywords_118:「성심」> 1장을 손에 넣는다."
  },
  Skill_117317_EffectNameList = {Text = "피해"},
  Skill_117317_Name = {
    Text = "무죄의 성재"
  },
  Skill_117317_OverLimitUtlSkillDesc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이번 턴에 폴룩스가 다음으로 사용하는 명령 카드에 「고통 구원」 효과가 적용되며, 해당 카드가 1회 추가로 발동한다. <DerivativeCardKeywords_118:「성심」> 2장을 손에 넣는다. 이번 턴 동안 폴룩스의 모든 명령 카드에 「고통 구원」 효과가 50% 추가로 적용된다."
  },
  Skill_117317_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_117318_AwakerSkillBackgroundStory = {
    Text = "과거 그의 눈은 음영에 가려져 어둠을 낮처럼 보았습니다.\n 이제 그는 세상의 진정한 모습을 다시 보았고, 반대의 길로 발걸음을 옮겼습니다.\n 언제나 그는 빛을 향해 나아가고 있습니다."
  },
  Skill_117318_Desc_0 = {
    Text = "폴뤽스가 <Energy:[Energy:Arg1]> 포인트의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 사용 시와 버리기 단계 후 3층의 <ZuiyinKeywords:죄인>을 획득하며, 손패 1장당 추가로 1층의 <ZuiyinKeywords:죄인>을 획득합니다. 「성심」이 100% 피해의 출혈을 가합니다."
  },
  Skill_117318_Desc_15 = {
    Text = "폴뤽스가 <Energy:[Energy:Arg1]> 포인트의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 사용 시와 버리기 단계 후 3층의 <ZuiyinKeywords:죄인>을 획득하며, 손패 1장당 추가로 1층의 <ZuiyinKeywords:죄인>을 획득합니다. 「성심」이 100% 피해의 출혈을 가하며, 사용으로 인해 드로우 더미에 섞인 후 해당 「성심」의 이번 턴 연산력 소모가 0이 되고 100% 피해의 <BleedingIconKeywords:출혈>을 부여합니다."
  },
  Skill_117318_EffectNameList = {Text = "광기"},
  Skill_117318_Name = {
    Text = "정화의 길"
  },
  Skill_117494_Desc_1 = {
    Text = "광기를 제거한다."
  },
  Skill_117494_Name_1 = {
    Text = "광기 제거"
  },
  Skill_117740_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 <PVPCorrosionKeywords:죄인>을 부여한다."
  },
  Skill_117740_Name_1 = {
    Text = "죄인 테스트"
  },
  Skill_117757_Desc = {
    Text = "카드를 1장 뽑고 그 카드의 행동력 소모를 1 감소시킨다. 명령 카드를 뽑았다면, 그 카드의 소유자가 임시 치명타 피해 [Arg1]%를 획득한다. 폴룩스가 팀에 있을 경우, <ZuiyinKeywords:죄인> [Arg2]스택을 획득한다."
  },
  Skill_117757_Name = {
    Text = "피의 성심"
  },
  Skill_117861_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>과 피해량의 10%에 해당하는 <IntoxicationColour:중독>을 부여한다."
  },
  Skill_117861_Name = {
    Text = "더러운 피의 제사"
  },
  Skill_117862_Desc = {
    Text = "<SacrificeKeyWord:희생> [Arg1]스택과 <EmptinessKeywords:허무> 1스택을 부여한다."
  },
  Skill_117862_Name = {
    Text = "심연의 축복"
  },
  Skill_117863_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_117863_Name = {
    Text = "휘두르기"
  },
  Skill_118055_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해를 입혔을 경우 「상호 계약: 심해 분열체」 [Arg3]스택을 획득한다."
  },
  Skill_118055_Name = {
    Text = "등불의 빛"
  },
  Skill_118056_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <HeavyInjuryKeywords:중상> 1스택을 부여하며, 플레이어의 실타래드 1pt당 이번 피해가 1pt 감소한다."
  },
  Skill_118056_Name = {
    Text = "영지 오염"
  },
  Skill_118057_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <HeavyInjuryKeywords:중상>을 부여하며, 플레이어의 실타래드 1pt당 이번 피해가 1pt 감소한다."
  },
  Skill_118057_Name = {
    Text = "중상입은 뼈"
  },
  Skill_118058_Desc = {
    Text = "해당 의도로 전환할 때 <Flaw:허점> 1스택을 획득한다. <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 적에게 <BirthRitual:강생 의식> [Arg3]스택을 부여하며, <FatePact:운명의 계약> 1스택당 부여량이 1씩 증가한다."
  },
  Skill_118058_Name = {
    Text = "영겁의 윤회의 천막"
  },
  Skill_118059_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <RetaliateIconKeywords:임시 반격> [Arg3]스택을 획득하며, 플레이어의 남은 손패 1장당 <RetaliateIconKeywords:임시 반격>이 [Arg4]스택 추가로 증가한다."
  },
  Skill_118059_Name = {
    Text = "원한의 복수"
  },
  Skill_118060_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주며(촉수 2개당 피해 횟수가 1회 증가한다), [Arg3]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여하고, 자신의 부정 상태를 해제한다."
  },
  Skill_118060_Name = {
    Text = "레무리아의 역류"
  },
  Skill_118061_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 턴 종료 전까지 플레이어의 남은 손패 1장당 공격 횟수가 1회 감소하며, 최소 3회까지 감소한다."
  },
  Skill_118061_Name = {
    Text = "뱀들의 찢기"
  },
  Skill_118062_Desc = {
    Text = "전방에 「레무리아 깨어남체」 1개를 소환한다."
  },
  Skill_118062_Name = {
    Text = "선택받은 자"
  },
  Skill_118063_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_3:「기절」> [Arg3]장을 덱에 섞어 넣는다."
  },
  Skill_118063_Name = {
    Text = "지고의 산제"
  },
  Skill_118064_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 즉시 「상호 계약: 심해 분열체」 [Arg3]스택을 획득한다."
  },
  Skill_118064_Name = {
    Text = "빛 「신앙 집결」"
  },
  Skill_118065_Desc = {
    Text = "해당 의도로 전환할 때, 현재 촉수 수만큼의 임시 촉수를 획득한다. <Block:[Block:Arg1]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다."
  },
  Skill_118065_Name = {
    Text = "자유의 서원"
  },
  Skill_118066_Desc = {
    Text = "「호출」에 추가 효과를 부여한다: 5스택에 도달하면 즉시 모든 깨어남체를 봉인한다."
  },
  Skill_118066_Name = {Text = "깨어남"},
  Skill_118068_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_118068_Name = {Text = "깨물기"},
  Skill_118070_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 방어되지 않은 피해를 1회 줄 때마다 순서대로 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <Decay:부패> 1스택씩을 부여한다."
  },
  Skill_118070_Name = {
    Text = "낙원 재가동"
  },
  Skill_118071_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Decay:부패> 1스택을 부여한다. 턴 시작 시 「성상 축복」 1개를 선택하여 「저주」로 반전시킨다."
  },
  Skill_118071_Name = {
    Text = "「장막의 드러냄」"
  },
  Skill_118072_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가한다."
  },
  Skill_118072_Name = {Text = "타격"},
  Skill_118074_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg2]pt, <Undercurrent:암류> [Arg3]스택을 획득한다."
  },
  Skill_118074_Name = {
    Text = "촉수 장벽"
  },
  Skill_118076_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Decay:부패> [Arg3]스택을 부여한다."
  },
  Skill_118076_Name = {
    Text = "촉수 포식"
  },
  Skill_118077_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해를 입혔을 경우 「상호 계약: 심해 분열체」 [Arg3]스택을 획득한다."
  },
  Skill_118077_Name = {
    Text = "등불의 빛"
  },
  Skill_118078_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 1턴간 봉인한다."
  },
  Skill_118078_Name = {
    Text = "신권의 칼날"
  },
  Skill_118080_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어가 유지한 모든 손패를 버린다. 방어되지 않은 피해를 입힐 때마다 <DerivativeCardKeywords_80:「질식」> [Arg3]장을 덱 맨 위에 섞어 넣는다."
  },
  Skill_118080_Name = {Text = "교살"},
  Skill_118083_Desc = {
    Text = "<Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 플레이어의 현재 HP의 50%에 해당하는 피해(<Damage:[Damage:Arg4]>)를 입히며, 동일한 양의 <BleedingIconKeywords:출혈>과 <Decay:부패> [Arg5]스택을 부여한다."
  },
  Skill_118083_Name = {
    Text = "부패한 뼈의 강타"
  },
  Skill_118084_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득하며, 「호출」 1스택당 실타래드가 <Block:[Block:Arg4]>pt 추가로 증가한다."
  },
  Skill_118084_Name = {Text = "시도"},
  Skill_118086_Desc = {
    Text = "해당 의도로 전환할 때 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 대상의 HP가 50% 미만일 경우 <Decay:부패> [Arg2]스택을 부여하고, 그렇지 않을 경우 <WeaknessIconKeywords:허약> [Arg3]스택을 부여한다."
  },
  Skill_118086_Name = {
    Text = "영령의 저주"
  },
  Skill_118087_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt, <SacrificeKeyWord:희생> [Arg2]스택, <TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg3]pt를 획득한다."
  },
  Skill_118087_Name = {
    Text = "성녀의 탄생"
  },
  Skill_118090_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해를 1회 입힐 때마다 임시 촉수 1개를 생성한다. 턴 종료 전까지 플레이어의 남은 손패 1장당 공격 횟수가 1회 감소하며, 최소 3회까지 감소한다."
  },
  Skill_118090_Name = {
    Text = "뱀들 광란의 춤"
  },
  Skill_118091_Desc = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가하고, 최대 촉수 수가 1 증가한다. 자신에게 <SacrificeKeyWord:희생> [Arg2]스택을 부여한다."
  },
  Skill_118091_Name = {
    Text = "심해의 성가"
  },
  Skill_118092_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 번 준다. [Arg3] 층의 <ResentChainsKeywords:원망의 사슬>을 획득한다. 1 층의 <Abyssallock:꿈의 족쇄>를 잃을 때마다 획득한 <ResentChainsKeywords:원망의 사슬>이 1 증가하고, 피해가 <Damage:[Damage:Arg4]> 점 증가한다."
  },
  Skill_118092_Name = {
    Text = "영원한 감옥"
  },
  Skill_118093_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 번 입히고, 드로우 덱과 버린 카드 더미에 [Arg3] 장의 랜덤 카드에 <SeastriderCurse:도해자 저주원한>을 추가합니다."
  },
  Skill_118093_Name = {
    Text = "등불의 빛"
  },
  Skill_118094_Desc = {
    Text = "「피의 서약」 [Arg1]스택과 <RetaliateIconKeywords:반격> [Arg2]스택을 획득한다."
  },
  Skill_118094_Name = {
    Text = "타오르는 심지"
  },
  Skill_118095_Desc = {
    Text = "해당 의도로 전환할 때, 현재 촉수 수만큼의 임시 촉수를 획득한다. <Block:[Block:Arg1]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다."
  },
  Skill_118095_Name = {
    Text = "망상의 계승자"
  },
  Skill_118096_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 발생시키고, [Arg3] 층 <HeavyInjuryKeywords:치명타>을 적용합니다. 플레이어가 1 점 방어막을 소지할 때마다 이번 피해가 1 점 감소합니다."
  },
  Skill_118096_Name = {
    Text = "죄악의 채찍질"
  },
  Skill_118097_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 해당 의도로 전환할 때 임시 <Abyssallock2:꿈의 족쇄> [Arg3]스택을 획득한다. 턴 종료 시 손에 있는 <SlowIconKeywords:둔화> 카드 1장당 추가로 1회 피해를 입힌다."
  },
  Skill_118097_Name = {
    Text = "「근심 없는 정토」"
  },
  Skill_118099_Desc = {
    Text = "「피의 서약」 [Arg1]스택과 <RetaliateIconKeywords:반격> [Arg2]스택을 획득한다."
  },
  Skill_118099_Name = {
    Text = "타오르는 심지"
  },
  Skill_118100_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Decay:부패> [Arg3]스택을 부여한다."
  },
  Skill_118100_Name = {
    Text = "촉수 포식"
  },
  Skill_118101_Desc = {
    Text = "<Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 플레이어의 현재 HP의 25%에 해당하는 피해(<Damage:[Damage:Arg4]>)를 입히며, 동일한 양의 <BleedingIconKeywords:출혈>과 <Decay:부패> [Arg5]스택을 부여한다."
  },
  Skill_118101_Name = {
    Text = "부패한 뼈의 강타"
  },
  Skill_118102_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「피의 서약」 2스택당 임시 촉수 1개를 획득한다."
  },
  Skill_118102_Name = {
    Text = "심해 보조 제사"
  },
  Skill_118103_Desc = {
    Text = "「피의 서약」 [Arg1]스택과 <RetaliateIconKeywords:반격> [Arg2]스택을 획득한다."
  },
  Skill_118103_Name = {
    Text = "타오르는 심지"
  },
  Skill_118104_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체를 1턴간 봉인한다. <MutualAid1:상호 계약: 레무리아> 2스택을 획득한다."
  },
  Skill_118104_Name = {
    Text = "레무리아의 영광!"
  },
  Skill_118105_Desc = {
    Text = "적에게 <BirthRitual:강생 의식>을 [Arg1]스택 부여하고, <FatePact:운명의 계약>을 [Arg2]스택 획득하며, 자신에게 <VulnerabilityIconKeywords:취약>을 1스택 부여한다."
  },
  Skill_118105_Name = {
    Text = "레무리아의 왈츠"
  },
  Skill_118106_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 입힙니다. [Arg3] 개의 촉수 상한을 얻고 [Arg3] 개의 촉수를 생성하며, [TentaclePower:Arg4] 포인트의 <TentacleInjurieIconKeywords:촉수 피해>를 얻습니다. [Arg5] 층의 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <VulnerabilityIconKeywords:취약>, <HeavyInjuryKeywords:치명타>을 부여합니다."
  },
  Skill_118106_Name = {
    Text = "「신국 환상」"
  },
  Skill_118107_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「피의 서약」 2스택당 임시 촉수 1개를 획득한다."
  },
  Skill_118107_Name = {
    Text = "죄악의 채찍질"
  },
  Skill_118108_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <RetaliateIconKeywords:임시 반격> [Arg3]스택을 획득하며, 플레이어의 남은 손패 1장당 <RetaliateIconKeywords:임시 반격>이 [Arg4]스택 추가로 증가한다."
  },
  Skill_118108_Name = {
    Text = "원한의 복수"
  },
  Skill_118109_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 주고, [Arg3] 층 <IntoxicationIconKeywords:중독>을 부여합니다. 적의 생명력이 낮을수록 피해가 높아지며 최대 <Damage:[Damage:Arg4]> 점 피해입니다."
  },
  Skill_118109_Name = {
    Text = "푸른 고리 독소"
  },
  Skill_118648_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg2]스택을 부여한다. 다른 적이 남아있을 경우, 자신을 희생하여 기생하며, 「감염됨」 상태를 부여한다."
  },
  Skill_118648_Name = {Text = "기생"},
  Skill_118767_Desc = {
    Text = "피해 <Damage:[Damage:Arg3]>pt의 <PunctureDamagewords:관통> 피해를 [AttackTimes:Arg2]회 주고, 추가로 플레이어의 현재 HP의 50%에 해당하는 <PunctureDamagewords:관통> 피해(<Damage:[Damage:Arg4]>)를 주며, 동일한 양의 <BleedingIconKeywords:출혈>과 <Decay:부패> [Arg5]스택을 부여한다."
  },
  Skill_118767_Name = {
    Text = "부패한 뼈「<PunctureDamagewords:관통>」"
  },
  Skill_118929_Desc = {
    Text = "촉수 2개를 생성하고, 최대 촉수 수가 2 증가한다."
  },
  Skill_118929_Name = {
    Text = "창조된 존재"
  },
  Skill_118974_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주며(촉수 2개당 피해 횟수가 1회 증가한다), [Arg3]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여하고, 자신의 부정 상태를 해제한다."
  },
  Skill_118974_Name = {
    Text = "레무리아의 역류"
  },
  Skill_118975_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt, <SacrificeKeyWord:희생> [Arg2]스택, <TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg3]pt를 획득한다."
  },
  Skill_118975_Name = {
    Text = "성녀의 탄생"
  },
  Skill_119040_Desc_1 = {
    Text = "무작위 아군의 「타격」 [Arg1]장을 덱에 섞어 넣고, 「타격」 [Arg2]장을 드로우한다."
  },
  Skill_119040_Name_1 = {
    Text = "안개 속에서"
  },
  Skill_119040_UnknownName = {
    Text = "안개 속에서"
  },
  Skill_119041_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 전체 아군의 「타격」 피해가 [Arg1]% 증가한다."
  },
  Skill_119041_Name_1 = {
    Text = "이성의 등불"
  },
  Skill_119042_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [Arg1]% 증가하며, 임의의 아군이 「타격」을 사용한 후 [Arg3]장의 카드를 드로우한다. 매 턴 최대 [Arg2]회 발동한다."
  },
  Skill_119042_Name_1 = {
    Text = "광란의 세계 끝에서"
  },
  Skill_119043_Desc_1 = {
    Text = "총 [Arg1]의 <PVPSacrificeKeyWords:희생>을 모든 적에게 균등하게 부여한다."
  },
  Skill_119043_Name_1 = {
    Text = "길 잃은 배"
  },
  Skill_119043_UnknownName = {
    Text = "길 잃은 배"
  },
  Skill_119044_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 헌신의 제사가 가장 적은 적에게 [Arg1] <PVPSacrificeKeyWords:헌신의 제사>를 부여하고, [Arg2]회 반복합니다. 아군 전체가 더 이상 <PVPCapKeywords:최대 산출력> 감소 효과의 영향을 받지 않습니다."
  },
  Skill_119044_Name_1 = {
    Text = "어둠 속의 안식"
  },
  Skill_119045_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후, 모든 적이 이번 턴에 능동 피해를 받으면 받은 피해의 [Arg1]%만큼 <PVPSacrificeKeyWords:희생>을 획득한다."
  },
  Skill_119045_Name_1 = {
    Text = "푸른 고리 독소"
  },
  Skill_119088_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 주고, 1턴 <WeaknessIconKeywords:허약>을 부여하며 <Block:[Block:Arg3]> 점 방어막을 얻습니다. 각 층의 「호출」은 방어막을 <Block:[Block:Arg4]> 점 증가시킵니다."
  },
  Skill_119088_Name = {Text = "시도"},
  Skill_119089_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 1턴간 봉인하며, 해당 깨어남체 덱 내 무작위 스킬 카드 [Arg3]장에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  Skill_119089_Name = {
    Text = "신권의 칼날"
  },
  Skill_119090_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 증상 카드 [Arg3]장을 덱에 섞어 넣는다."
  },
  Skill_119090_Name = {
    Text = "지고의 산제"
  },
  Skill_119091_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체를 1턴간 봉인한다. <MutualAid1:상호 계약: 레무리아> 2스택을 획득한다."
  },
  Skill_119091_Name = {
    Text = "레무리아의 영광!"
  },
  Skill_119092_Desc = {
    Text = "잃은 HP의 10%를 회복하며, 「호출」 1스택당 회복량이 20% 증가한다. 전방에 「레무리아 깨어남체」 1개를 소환한다."
  },
  Skill_119092_Name = {
    Text = "선택받은 자"
  },
  Skill_119110_Desc = {
    Text = "<SacrificeKeyWord:희생> [Arg1]스택을 부여한다. 턴 시작 시 <FatePact:운명의 계약> [Arg2]스택을 획득한다."
  },
  Skill_119110_Name = {
    Text = "운명의 문턱"
  },
  Skill_119113_Desc_1 = {
    Text = "자신을 <StrengthenKeywords:강화>하고 <Energy:[Energy:Arg1]> 광기를 획득한다."
  },
  Skill_119113_Name_1 = {
    Text = "역경 속 광기"
  },
  Skill_119114_BattleDesc_1 = {
    Text = "자신의 부정 상태를 해제하고, 전체 적에게 [Arg2] 회 <Damage:[Damage:Arg1]> 피해를 가하며, 사망한 아군 1명당 추가로 1회 피해를 가합니다."
  },
  Skill_119114_Desc_1 = {
    Text = "자신의 부정 상태를 해제하고, 전체 적에게 1회 <Damage:[Damage:Arg1]> 피해를 가하며, 사망한 아군 1명당 추가로 1회 피해를 가합니다."
  },
  Skill_119114_Name_1 = {
    Text = "샤이닝☆토네이도"
  },
  Skill_119115_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 <PVPBleedingKeywords:출혈> 피해를 준다. 「타격」을 1장 사용할 때마다 행동력 소모가 1 감소한다."
  },
  Skill_119115_Name_1 = {
    Text = "파멸의 열상"
  },
  Skill_119116_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_119116_Name_1 = {Text = "타격"},
  Skill_119118_Desc_1 = {
    Text = "무작위로 [Arg1] 회 <Damage:[Damage:Arg2]> 피해를 입히고, 동일한 횟수의 <PVPBleedingKeywords:출혈>을 발동하며, 동시에 「공격」으로 간주."
  },
  Skill_119118_Name_1 = {
    Text = "안개를 찢는 강습"
  },
  Skill_119313_Desc = {
    Text = "추가 생명 막대 3개를 획득하고, 최대 HP가 250% 증가하며, 최대 HP의 10%에 해당하는 「옛날 잔재」를 획득한다. 최대 촉수 수가 5 증가하고 「촉수 집결」을 획득한다."
  },
  Skill_119313_Name = {
    Text = "해역 윤회"
  },
  Skill_119334_BattleDesc = {
    Text = "열쇠 에너지를 2000pt 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119334_Desc = {
    Text = "열쇠 에너지를 2000pt 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119334_Name = {
    Text = "환상 제사"
  },
  Skill_119335_BattleDesc = {
    Text = "의식 목표: 방어 카드 4장 사용.\n의식 보상: 잃은 HP의 50%를 회복하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119335_Desc = {
    Text = "의식 목표: 방어 카드 4장 사용.\n의식 보상: 잃은 HP의 50%를 회복하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119335_Name = {
    Text = "천진난만한 제사"
  },
  Skill_119336_BattleDesc = {
    Text = "의식 목표: 광기 폭발 4회 발동([Arg1]/4).\n의식 보상: 모든 깨어남체가 <Energy:30>의 광기를 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119336_Desc = {
    Text = "의식 목표: 광기 폭발 4회 발동.\n의식 보상: 모든 깨어남체가 <Energy:30>의 광기를 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119336_Name = {
    Text = "자유 제사 의식"
  },
  Skill_119337_BattleDesc = {
    Text = "의식 목표: 광기 폭발 4회 발동.\n의식 보상: 모든 깨어남체가 <Energy:30>의 광기를 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119337_Desc = {
    Text = "의식 목표: 광기 폭발 4회 발동.\n의식 보상: 모든 깨어남체가 <Energy:30>의 광기를 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119337_Name = {
    Text = "자유 제사 의식"
  },
  Skill_119338_BattleDesc = {
    Text = "잃은 HP의 50%를 회복하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119338_Desc = {
    Text = "잃은 HP의 50%를 회복하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119338_Name = {
    Text = "천진난만한 제사"
  },
  Skill_119339_BattleDesc = {
    Text = "의식 목표: 열쇠 지령 3회 발동([Arg1]/3).\n의식 보상: 열쇠 에너지를 2000pt 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119339_Desc = {
    Text = "의식 목표: 열쇠 지령 3회 발동.\n의식 보상: 열쇠 에너지를 2000pt 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119339_Name = {
    Text = "환상 제사"
  },
  Skill_119340_BattleDesc = {
    Text = "모든 깨어남체가 <Energy:30>의 광기를 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119340_Desc = {
    Text = "모든 깨어남체가 <Energy:30>의 광기를 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119340_Name = {
    Text = "자유 제사 의식"
  },
  Skill_119341_BattleDesc = {
    Text = "의식 목표: 방어 카드 4장 사용([Arg1]/4).\n의식 보상: 잃은 HP의 50%를 회복하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119341_Desc = {
    Text = "의식 목표: 방어 카드 4장 사용.\n의식 보상: 잃은 HP의 50%를 회복하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119341_Name = {
    Text = "천진난만한 제사"
  },
  Skill_119342_Desc = {
    Text = "희생 의식 1개를 선택한다. 각 의식은 한 번만 선택할 수 있다."
  },
  Skill_119342_Name = {
    Text = "신께 바침"
  },
  Skill_119343_BattleDesc = {
    Text = "의식 목표: 열쇠 지령 3회 발동.\n의식 보상: 열쇠 에너지를 2000pt 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119343_Desc = {
    Text = "의식 목표: 열쇠 지령 3회 발동.\n의식 보상: 열쇠 에너지를 2000pt 획득하고, 자신의 모든 <SacrificeKeyWord:희생>을 제거하며, 모든 적에게 최대 HP 5%의 <SacrificeKeyWord:희생>을 부여한다."
  },
  Skill_119343_Name = {
    Text = "환상 제사"
  },
  Skill_119574_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」 전, 「스킬」 전, 「광기 폭발」 전에 임시 <StrongEffectKeywords:강효> +[Arg1]을 부여한다. 매 턴 각 효과는 한 번만 발동한다."
  },
  Skill_119574_Name_1 = {
    Text = "우리는 다시 만날 것이다"
  },
  Skill_119712_BattleDesc = {
    Text = "「<DerivativeCardKeywords_122:성상 축복: 지식의 꿈>」을 잃고, 모든 깨어남체가 즉시 광기의 50%를 잃으며, 모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  Skill_119712_Desc = {
    Text = "「<DerivativeCardKeywords_122:성상 축복: 지식의 꿈>」을 잃고, 모든 깨어남체가 즉시 광기의 50%를 잃으며, 모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  Skill_119712_Name = {
    Text = "성상 저주: 어리석음의 탄식"
  },
  Skill_119713_BattleDesc = {
    Text = "사용 시, 이번 턴 동안 「성상 저주」 효과의 영향을 받지 않고 모든 피해에 면역이 되며, 적의 「옛날 잔재」 효과가 영구적으로 2배 증가한다."
  },
  Skill_119713_Desc = {
    Text = "사용 시, 이번 턴 동안 「성상 저주」 효과의 영향을 받지 않고 모든 피해에 면역이 되며, 적의 「옛날 잔재」 효과가 영구적으로 2배 증가한다."
  },
  Skill_119713_Name = {
    Text = "은열쇠, 반드시 앞길을 인도하리라"
  },
  Skill_119714_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 입힙니다. [Arg3] 개의 촉수 상한을 얻고 [Arg3] 개의 촉수를 생성하며, [TentaclePower:Arg4] 포인트의 <TentacleInjurieIconKeywords:촉수 피해>를 얻습니다. [Arg5] 층의 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <VulnerabilityIconKeywords:취약>, <HeavyInjuryKeywords:치명타>을 부여합니다."
  },
  Skill_119714_Name = {
    Text = "「신국 환상·종결」"
  },
  Skill_119715_BattleDesc = {
    Text = "매 턴 시작 시 최대 HP의 5%에 해당하는 <PowerIconKeywords:힘>을 획득하고, 임시 치명타율이 25% 증가한다."
  },
  Skill_119715_Desc = {
    Text = "매 턴 시작 시 최대 HP의 5%에 해당하는 <PowerIconKeywords:힘>을 획득하고, 임시 치명타율이 25% 증가한다."
  },
  Skill_119715_Name = {
    Text = "성상 축복: 위엄의 꿈"
  },
  Skill_119716_BattleDesc = {
    Text = "매 턴 시작 시 잃은 HP의 15%를 회복한다."
  },
  Skill_119716_Desc = {
    Text = "매 턴 시작 시 잃은 HP의 15%를 회복한다."
  },
  Skill_119716_Name = {
    Text = "성상 축복：영원한 꿈"
  },
  Skill_119717_BattleDesc = {
    Text = "「<DerivativeCardKeywords_120:성상 축복: 영원한 꿈>」을 잃고, 즉시 현재 HP의 50%를 잃으며, 모든 깨어남체의 HP 회복량이 50% 감소한다."
  },
  Skill_119717_Desc = {
    Text = "「<DerivativeCardKeywords_120:성상 축복: 영원한 꿈>」을 잃고, 즉시 최대 HP의 50%를 잃으며, 모든 깨어남체의 HP 회복량이 50% 감소한다."
  },
  Skill_119717_Name = {
    Text = "성상 저주: 파멸의 원한"
  },
  Skill_119718_BattleDesc = {
    Text = "매 턴 시작 시 모든 깨어남체가 <Energy:10>의 광기를 획득한다."
  },
  Skill_119718_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 <Energy:10>의 광기를 획득한다."
  },
  Skill_119718_Name = {
    Text = "성상 축복：지식의 꿈"
  },
  Skill_119719_BattleDesc = {
    Text = "「<DerivativeCardKeywords_121:성상 축복: 위엄의 꿈>」을 잃고, 즉시 힘의 50%를 잃으며, 모든 깨어남체의 힘 획득 효과가 50% 감소한다."
  },
  Skill_119719_Desc = {
    Text = "「<DerivativeCardKeywords_121:성상 축복: 위엄의 꿈>」을 잃고, 즉시 힘의 50%를 잃으며, 모든 깨어남체의 힘 획득 효과가 50% 감소한다."
  },
  Skill_119719_Name = {
    Text = "성상 저주: 쇠퇴의 슬픔"
  },
  Skill_119762_AwakerSkillBackgroundStory = {
    Text = "신모의 지시는 반박할 수 없다."
  },
  Skill_119762_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_119762_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 「심해의 성가」 1장을 드로우한다. 매 턴 1회만 발동한다. ([Arg3]/1)"
  },
  Skill_119762_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 탄망·머피가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_119762_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 탄망·머피가 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 「심해의 성가」 1장을 드로우한다. 매 턴 1회만 발동한다."
  },
  Skill_119762_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_119762_Name = {Text = "타격"},
  Skill_119762_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_119763_AwakerSkillBackgroundStory = {
    Text = "그녀는 오만하다. 그녀는 오만으로 내면의 수리할 수 없는 공허함을 가린다.\n그녀는 자신이 한 때 누구였는지를 잊어버렸고, 자신이 되어야 할 사람을 잊어버렸다.\n수많은 도해자들이 그녀의 발 아래 굴복하고, 그녀는 존경의 목소리 속에서 가장 중요한 것을 잊어버렸다.\n그녀는 이미 이 창백한 운명에 굴복해버렸다."
  },
  Skill_119763_BattleDesc = {
    Text = "행동력 2pt를 획득하고, 카드 2장을 드로우한다. 다음 턴 시작 시 <SacrificeKeyWord:희생> [Arg3]pt를 부여한다. <RippleKeywords:여파>: <SacrificeKeyWord:희생> [Arg4]pt를 제거한다."
  },
  Skill_119763_Desc = {
    Text = "행동력 2pt를 획득하고, 카드 2장을 드로우한다. 다음 턴 시작 시 최대 HP의 [Arg1]%만큼 <SacrificeKeyWord:희생>을 부여한다. <RippleKeywords:여파>: 최대 HP의 [Float:Arg2]%만큼 <SacrificeKeyWord:희생>을 제거한다."
  },
  Skill_119763_EffectNameList = {
    Text = "희생 제거 비율"
  },
  Skill_119763_Name = {
    Text = "심해의 성가"
  },
  Skill_119764_AwakerSkillBackgroundStory = {
    Text = "머피의 손에 있는 상아 조각상의 유래는 여러 가지 설이 있다. \n 어떤 이는 그 조각상이 머피의 지시하에 탐색한 심해 유적에서 유래했다고 하고, 어떤 이는 조각상이 성스러운 아기와 함께 그녀의 가슴속 요동치는 심장에서 탄생했다고도 한다. \n 그러나 의심할 여지 없는 사실타래은, 빛 한 점 없는 해저에 고요히 잠든 나인(螺湮)의 도시와 그녀의 떼려야 뗄 수 없는 관계를 상징하는 이 조각상이, 머피가 「진정한 신모」가 된 날 도해자들의 시선에 나타났다는 것이다. \n 그 이후로 신자들은 머피가 이 상아 조각상을 이용해 폭풍을 뚫고, 피바다를 가르는 것을 목격했다. \n 절대적인 권력은 종종 허상의 상징에 그치지 않는다. 인간의 무릎은 절대적인 힘의 권위 아래에서만 무릎 꿇을 것이다."
  },
  Skill_119764_BattleDesc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, 다음 턴 시작 시 <SacrificeKeyWord:희생> [Arg7]pt를 부여한다. 전체 적에게 <DwmofeiKeywords:강생 의식> [Arg3]스택을 부여하고, HP가 가장 높은 적에게 <Damage:[Damage:Arg5]>pt의 피해를 [Arg4]회 입힌다. 이 피해에는 [Arg6]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다."
  },
  Skill_119764_Desc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, 다음 턴 시작 시 최대 HP의 [Arg2]%만큼 <SacrificeKeyWord:희생>을 부여한다. 전체 적에게 <DwmofeiKeywords:강생 의식> [Arg3]스택을 부여하고, HP가 가장 높은 적에게 <Damage:[Damage:Arg5]>pt의 피해를 [Arg4]회 입힌다. 이 피해에는 [Arg6]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다."
  },
  Skill_119764_EffectNameList = {
    Text = "실타래드, 강생 의식 부여량, 촉수 피해 계수"
  },
  Skill_119764_Name = {
    Text = "허망의 왕녀"
  },
  Skill_119764_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, 다음 턴 시작 시 <SacrificeKeyWord:희생> [Arg7]pt를 부여한다. 전체 적에게 <DwmofeiKeywords:강생 의식> [Arg8]스택을 부여하고, HP가 가장 높은 적에게 <Damage:[Damage:Arg5]>pt의 피해를 [Arg4]회 입힌다. 이 피해에는 [Arg6]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다. 행동력 소모가 2인 「나선원무」 3장을 손에 넣고, <DepleteIconKeywords:소모>와 <PrepareKeypvewords1:예비1>을 부여한다."
  },
  Skill_119764_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3,$GrowValue4%"
  },
  Skill_119765_AwakerSkillBackgroundStory = {
    Text = "그녀는 경솔하다. 그녀는 경솔함으로 부서진 현실타래에 맞선다. \n춤추자고 그녀가 말했다, 신에게 바치는 춤을 춘다고. \n신이 우리에게 왜곡된 인과관계, 뒤엉킨 과거, 그리고 불가사의한 미래를 주신 것에 감사하다고. \n스포트라이트 아래, 그녀는 모든 것의 유일한 초점이다."
  },
  Skill_119765_BattleDesc = {
    Text = "<Posse:[Arg7]>pt의 열쇠 에너지를 획득한다. 촉수 자세에 따라 효과를 획득한다. 「조수」: <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가하고, 촉수 1개를 생성한다. 「정해」: <Block:[Block:Arg2]>pt의 실타래드를 획득하며, 실타래드의 50%를 다음 턴까지 유지한다. 「노도」: HP가 가장 높은 적에게 <Damage:[Damage:Arg4]>pt의 피해를 [Arg3]회 입히고, 이 피해에는 [Arg5]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다."
  },
  Skill_119765_Desc = {
    Text = "은열쇠 충전량의 [Arg6]%에 해당하는 열쇠 에너지를 획득한다. 촉수 자세에 따라 효과를 획득한다. 「조수」: <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg8] 증가하고, 촉수 1개를 생성한다. 「정해」: <Block:[Block:Arg9]>pt의 실타래드를 획득하며, 실타래드의 50%를 다음 턴까지 유지한다. 「노도」: HP가 가장 높은 적에게 <Damage:[Damage:Arg4]>pt의 피해를 [Arg3]회 입히고, 이 피해에는 [Arg5]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다."
  },
  Skill_119765_EffectNameList = {
    Text = "촉수 피해, 실타래드, 피해, 촉수 피해 계수, 은열쇠 충전량"
  },
  Skill_119765_Name = {
    Text = "레무리아의 왈츠"
  },
  Skill_119765_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2, 공격력*GrowValue3,$GrowValue4%,$GrowValue5%"
  },
  Skill_119766_AwakerSkillBackgroundStory = {
    Text = "그녀는 신의 탯줄에 맺힌 핏방울을 바다에 떨어뜨렸다. 그리고 신을 향해, 영원히 종착지에 닿지 않을 항해를 기원했다.\n덧없는 꿈의 물거품이 이어지는 한, 그녀는 유일무이한 신모(神母)로 군림할 테니까."
  },
  Skill_119766_Desc_0 = {
    Text = "탄망·머피가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 탄망·머피가 주는 피해에 <SacrificeKeyWord:희생> [Arg2]%를 추가로 부여한다. 턴 시작 시, <MingqiKeywords:명계> 1스택을 획득한다."
  },
  Skill_119766_Desc_15 = {
    Text = "탄망·머피가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 탄망·머피가 주는 피해에 <SacrificeKeyWord:희생> [Arg2]%를 추가로 부여한다. <MingqiKeywords:명계> 2스택을 획득한다. 턴 시작 시, <MingqiKeywords:명계> 1스택을 획득한다. 턴 종료 시, 「조수」 자세일 경우 추가로 <MingqiKeywords:명계> 1스택을 획득한다."
  },
  Skill_119766_EffectNameList = {
    Text = "광기, 희생 비율"
  },
  Skill_119766_Name = {
    Text = "바다의 성례"
  },
  Skill_119767_AwakerSkillBackgroundStory = {
    Text = "신모의 언행은 비난받을 수 없다."
  },
  Skill_119767_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_119767_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 「심해의 성가」 1장을 드로우한다. 매 턴 1회만 발동한다. ([Arg3]/1)"
  },
  Skill_119767_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 탄망·머피가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_119767_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 탄망·머피가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 「심해의 성가」 1장을 드로우한다. 매 턴 1회만 발동한다."
  },
  Skill_119767_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_119767_Name = {Text = "방어"},
  Skill_119767_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_119835_Desc = {
    Text = "버린 카드 더미에서 명령 카드 1장을 선택하여 손으로 되돌린다. 「라모나」가 팀에 있을 경우, 그녀가 이번 턴에 사용하는 다음 명령 카드가 [Arg1]회 발동한다."
  },
  Skill_119835_Name = {
    Text = "재회의 소원"
  },
  Skill_119845_Desc_1 = {
    Text = "<PVPHoldingKeywords:보유>: 이번 턴에 마지막으로 사용한 「스킬」로 간주하며, 산출력 소모 -[Arg1]. 이 카드는 전투 시작 후 두 번째 덱의 맨 위에 놓인다."
  },
  Skill_119845_Name_1 = {
    Text = "재회의 소원"
  },
  Skill_119845_UnknownName = {
    Text = "재회의 소원"
  },
  Skill_120314_Desc = {
    Text = "행동력 1pt를 획득하고, 모든 적에게 <DwmofeiKeywords:강림 의식> 5스택을 부여한다. 「탄망·머피」가 팀에 있을 경우, 「레무리아 왈츠」 1장을 드로우한다."
  },
  Skill_120314_Name = {
    Text = "길 잃은 배"
  },
  Skill_120896_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전체 아군이 <RetaliateIconKeywords:반격> [Arg3]스택을 획득한다."
  },
  Skill_120896_Name = {
    Text = "파쇄된 칼"
  },
  Skill_120942_Desc = {
    Text = "1000000 HP 추가"
  },
  Skill_120942_Name = {
    Text = "1000000 HP 추가"
  },
  Skill_121138_Desc = {
    Text = "이 의도로 전환할 때 1배의 임시 촉수를 생성하고, <TentacleInjurieIconKeywords:촉수 피해>가 임시로 50% 감소한다. 전체 아군이 실타래드를 <Block:[Block:Arg1]>pt 획득하고 1턴간 부정 상태에 면역이 된다."
  },
  Skill_121138_Name = {
    Text = "잃어버린 고대의 도시"
  },
  Skill_121342_Desc = {
    Text = "전열 몬스터에게 99999999의 피해를 준다."
  },
  Skill_121342_Name = {
    Text = "전방 몬스터 처치"
  },
  Skill_121354_Desc = {
    Text = "전체 몬스터에게 99999999의 피해를 준다."
  },
  Skill_121354_Name = {
    Text = "모든 몬스터 처치"
  },
  Skill_121360_Desc = {
    Text = "무적 제거 추가"
  },
  Skill_121360_Name = {
    Text = "무적 제거 추가"
  },
  Skill_121361_Desc = {
    Text = "무적 추가"
  },
  Skill_121361_Name = {
    Text = "무적 추가"
  },
  Skill_121366_Desc = {
    Text = "500 HP 추가"
  },
  Skill_121366_Name = {
    Text = "500 HP 추가"
  },
  Skill_121800_Desc = {
    Text = "적의 촉수 피해를 임시로 80% 감소시키고, 감소한 만큼의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_121800_Name = {
    Text = "천궁 뒤집기"
  },
  Skill_121801_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 50pt를 획득하며, 이를 3회 반복한다."
  },
  Skill_121801_Name = {
    Text = "불변의 신념"
  },
  Skill_121802_Desc = {
    Text = "즉시 최대 HP의 25%를 회복하고, 최대 HP의 500%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_121802_Name = {
    Text = "숭배와 격려"
  },
  Skill_121803_Desc = {
    Text = "카드를 5장 뽑고, 손의 모든 <SlowIconKeywords:둔화>를 제거한다."
  },
  Skill_121803_Name = {
    Text = "신이 선택한 빛"
  },
  Skill_122118_Desc = {
    Text = "카드 1장을 뽑고, <DerivativeCardKeywords_128:「카운트다운: 0」>를 버린 카드 더미에 섞어 넣는다."
  },
  Skill_122118_Name = {
    Text = "카운트다운: 1"
  },
  Skill_122119_Desc = {
    Text = "카드 3장을 뽑고 행동력 3pt를 획득하며, [Arg1]% 확률로 <DerivativeCardKeywords_123:「카운트다운: 5」>를 버린 카드 더미에 섞어 넣는다."
  },
  Skill_122119_Name = {
    Text = "카운트다운: 0"
  },
  Skill_122120_Desc = {
    Text = "카드 1장을 뽑고, <DerivativeCardKeywords_125:「카운트다운: 3」>를 버린 카드 더미에 섞어 넣는다."
  },
  Skill_122120_Name = {
    Text = "카운트다운: 4"
  },
  Skill_122121_Desc = {
    Text = "카드 1장을 뽑고, <DerivativeCardKeywords_124:「카운트다운: 4」>를 버린 카드 더미에 섞어 넣는다."
  },
  Skill_122121_Name = {
    Text = "카운트다운: 5"
  },
  Skill_122122_Desc = {
    Text = "카드 1장을 뽑고, <DerivativeCardKeywords_126:「카운트다운: 2」>를 버린 카드 더미에 섞어 넣는다."
  },
  Skill_122122_Name = {
    Text = "카운트다운: 3"
  },
  Skill_122123_Desc = {
    Text = "카드 1장을 뽑고, <DerivativeCardKeywords_127:「카운트다운: 1」>를 버린 카드 더미에 섞어 넣는다."
  },
  Skill_122123_Name = {
    Text = "카운트다운: 2"
  },
  Skill_122413_Desc = {
    Text = "무셰트 이후 방어되지 않은 피해를 입힐 때, <Monster_Fervor:임시 열광> 2스택을 획득한다. <ReinforcePVEKeywords:견고> 80스택을 획득하며, 적 턴 시작 시 제거된다."
  },
  Skill_122413_Name = {
    Text = "안개 속의 유적"
  },
  Skill_122414_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 적의 실타래드 <Block:[Block:Arg3]>pt당 피해가 1pt 증가한다. <PowerIconKeywords:힘>을 [Arg4]pt 획득한다."
  },
  Skill_122414_Name = {
    Text = "인간 폭발"
  },
  Skill_122415_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_122415_Name = {
    Text = "빛나는 토네이도"
  },
  Skill_122416_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_122416_Name = {
    Text = "빛나는 토네이도"
  },
  Skill_122417_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해가 1회 방어될 때마다 <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_122417_Name = {
    Text = "샤이닝☆크러시"
  },
  Skill_122432_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 방어막 <Block:[Block:Arg1]>과 광기를 <Energy:[Energy:Arg1]> 획득한다. 턴 종료 시 해당 명륜은 자동 해제되며, 다음에 「상자 속의 천진난만」을 장착할 때 획득하는 광기와 방어막이 [Arg2] 증가한다."
  },
  Skill_122432_Name_1 = {
    Text = "상자 속의 천진난만"
  },
  Skill_122433_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 <PVPReciprocalKeywords:카운트다운 순간> 3스택을 획득한다."
  },
  Skill_122433_Name_1 = {
    Text = "카운트다운 순간"
  },
  Skill_122483_AwakerSkillBackgroundStory = {
    Text = "전투, 마치 삶의 마지막 한 번과 같다. \n 안개로 가득 찬, '자신'의 세계로 돌아가기 위해."
  },
  Skill_122483_Desc_0 = {
    Text = "「타격」으로 간주한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다."
  },
  Skill_122483_Desc_2 = {
    Text = "「타격」으로 간주한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 이전에 사용한 다른 「타격」의 임시 복사본 1장을 생성하며, 해당 카드의 행동력 소모를 1 감소시킨다."
  },
  Skill_122483_EffectNameList = {Text = "피해"},
  Skill_122483_Name = {
    Text = "인간 폭발"
  },
  Skill_122483_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_122484_AwakerSkillBackgroundStory = {
    Text = "모든 사람은 죽게 되어 있고, 그녀도 마찬가지다. 그녀는 죽음을 저항하지도, 거부하지도 않는다.\n 미안하지만, 그녀의 죽음은 오늘도, 지금도 아닐 것이다.\n 그녀는 아직 즐길 만큼 즐기지 못했으니까!"
  },
  Skill_122484_Desc = {
    Text = "「타격」으로 간주한다. 무작위 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_122484_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_122484_Name = {
    Text = "샤이닝☆크러시"
  },
  Skill_122484_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_122485_AwakerSkillBackgroundStory = {
    Text = "과거를 잊지 마세요, 안개 경계 조사단을 잊지 마세요.\n잊는 것은 배신을 의미합니다.\n그리고 그녀, 무셰트는 결코 배신하지 않을 것입니다."
  },
  Skill_122485_Desc_0 = {
    Text = "모샤가 <Energy:[Energy:Arg1]> 의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 「극적인 해후」 피해 횟수 +2. 「극적인 해후」를 발동할 때마다 모샤의 「타격」 임시 최종 피해 +25%. 즉시 임시 「인간 폭파」 1장을 생성합니다."
  },
  Skill_122485_Desc_15 = {
    Text = "무셰트가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「극적인 조우」의 피해 횟수가 2회 증가하며, 매 턴 발동 횟수 상한이 5로 증가한다. 「극적인 조우」가 발동될 때마다 무셰트의 「타격」 임시 최종 피해가 25% 증가한다. 즉시 행동력 소모가 0인 임시 「인간 폭발」 2장을 생성한다."
  },
  Skill_122485_EffectNameList = {Text = "광기"},
  Skill_122485_Name = {
    Text = "안개 속의 유적"
  },
  Skill_122486_AwakerSkillBackgroundStory = {
    Text = "「이 세계에서도 그걸 외쳐야 하나?」\n「좋아, 그럼 잘 들어—」\n「왔다! 남녀노소 모두 좋아하는! 빛나는☆토네이도——!!」"
  },
  Skill_122486_BattleDesc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다. 이번 턴 모든 깨어남체의 「타격」 피해가 [Arg3]pt 증가한다."
  },
  Skill_122486_BattleDesc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다. 이번 턴 무셰트가 주는 피해 횟수가 1회 증가하며, 모든 깨어남체의 「타격」 피해가 [Arg3]pt 증가한다."
  },
  Skill_122486_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 턴 모든 깨어남체의 「타격」 피해가 [Arg3]pt 증가한다."
  },
  Skill_122486_Desc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 턴 무셰트가 주는 피해 횟수가 1회 증가하며, 모든 깨어남체의 「타격」 피해가 [Arg3]pt 증가한다."
  },
  Skill_122486_EffectNameList = {
    Text = "피해, 타격 피해 증가"
  },
  Skill_122486_Name = {
    Text = "샤이닝☆토네이도"
  },
  Skill_122486_OverLimitUtlSkillDesc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>점의 피해를 [Arg4]회 가합니다. 모든 깨어남체의 「공격」 피해가 [Arg3]점 증가합니다. 다음에 사용하는 「폭풍 충돌」의 기본 행동력 소모가 0이 됩니다. 이번 전투에서 처음 발동하는 경우, 모든 적을 추가로 <HunmiKeywords:실타래신>시킵니다."
  },
  Skill_122486_OverLimitUtlSkillDesc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>점의 피해를 [Arg4]회 가합니다. 이번 턴 모카가 가하는 피해 횟수 +1, 모든 깨어남체의 「공격」 피해가 [Arg3]점 증가합니다. 다음에 사용하는 「폭풍 충돌」의 기본 행동력 소모가 0이 됩니다. 이번 전투에서 처음 발동하는 경우, 모든 적을 추가로 <HunmiKeywords:실타래신>시킵니다."
  },
  Skill_122486_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_122487_AwakerSkillBackgroundStory = {
    Text = "“아직도 반항할 수 있어? 화가 좀 나기 시작하는데... 목 씻고 기다리고 있어!”"
  },
  Skill_122487_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_122487_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 무셰트가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_122487_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_122487_Name = {Text = "방어"},
  Skill_122487_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_122488_AwakerSkillBackgroundStory = {
    Text = "“하하하하, 이렇게 해야죠, 일이 재미있어졌어요!”\n“저와 함께 놀아 주셔서 감사합니다, 정말 기뻐요……”"
  },
  Skill_122488_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_122488_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 무셰트가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_122488_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_122488_Name = {Text = "타격"},
  Skill_122488_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_122656_Desc_1 = {
    Text = "적의 깨어남체 한 명을 퇴장시키고, 아군 깨어남체들이 그 깨어남체의 최대 HP, 현재 HP, 실타래드, 광기를 균등하게 분배한다."
  },
  Skill_122656_Name_1 = {
    Text = "실타래비아의 홍차"
  },
  Skill_122836_Desc = {
    Text = "HP를 500으로 설정한다."
  },
  Skill_122836_Name = {
    Text = "HP를 500으로 설정"
  },
  Skill_123159_Desc_0 = {
    Text = "무작위 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다."
  },
  Skill_123159_Name = {
    Text = "극적인 만남"
  },
  Skill_123270_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 덱 또는 버린 카드 더미의 무작위 카드 [Arg3]장을 <BurningKeywords:연소>시키며, <VulnerabilityIconKeywords:취약>을 [Arg4]스택 부여한다."
  },
  Skill_123270_Name = {
    Text = "페타 플레어"
  },
  Skill_123509_Desc = {
    Text = "「타격」 2장을 드로우한다. 「무셰트」가 팀에 있을 경우, 그 카드들의 행동력 소모를 1 감소시킨다."
  },
  Skill_123509_Name = {
    Text = "안개 속에서"
  },
  Skill_124013_Desc_1 = {
    Text = "공식에 따라 상태 테스트 카드를 생성한다."
  },
  Skill_124013_Name_1 = {
    Text = "테스트 카드 생성"
  },
  Skill_124014_Desc_1 = {
    Text = "공식에 따라 대상에게만 상태를 부여한다."
  },
  Skill_124014_Name_1 = {Text = "대상만"},
  Skill_124015_Desc_1 = {
    Text = "공식에 따라 자신에게만 상태를 부여한다."
  },
  Skill_124015_Name_1 = {Text = "자신만"},
  Skill_124025_Desc_1 = {
    Text = "공식에 따라 양측에게 상태를 부여한다."
  },
  Skill_124025_Name_1 = {Text = "양측"},
  Skill_124069_Desc = {
    Text = "<Damage:[Damage:Arg1]>점의 피해를 [AttackTimes:Arg2]회 입히고, 막히지 않은 피해를 [Arg3]회 입힐 때마다 드로우 덱 맨 위 명령 카드에 <SlowIconKeywords:둔화> [Arg4]스택을 부여한다."
  },
  Skill_124069_Name = {Text = "타격"},
  Skill_124070_Desc = {
    Text = "모든 부정 상태를 해제하고, 상대 턴 종료 시 손패를 버리지 않는다. 턴 종료 시 순서대로 <FragileIconKeywords:취약>, <WeaknessIconKeywords:허약>, <HeavyInjuryKeywords:중상>, <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다."
  },
  Skill_124070_Name = {
    Text = "경계 밖의 소리"
  },
  Skill_124071_Desc = {
    Text = "전체 아군이 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_124071_Name = {
    Text = "울려 퍼지는 소리"
  },
  Skill_124072_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득하고, 손패의 무작위 명령 카드 [Arg2]장과 드로우 덱의 무작위 명령 카드 [Arg2]장에 <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_124072_Name = {
    Text = "별빛 오로라"
  },
  Skill_124073_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 전체 아군이 <PowerIconKeywords:힘>을 [Arg3]pt 획득한다. 자신이나 다른 아군에게 <WeaknessIconKeywords:허약> 또는 <VulnerabilityIconKeywords:취약> 상태가 있을 경우, 해당 상태를 적에게 전이한다."
  },
  Skill_124073_Name = {Text = "진혼곡"},
  Skill_124074_Desc = {
    Text = "<Block:[Block:Arg1]>점의 방어막을 획득하고, 적의 손패에 <SlowIconKeywords:둔화> 카드가 [Arg2]장 있을 때마다 임시 <MadnessIconKeywords:발광> [Arg3]스택을 획득한다."
  },
  Skill_124074_Name = {
    Text = "울려 퍼지는 소리"
  },
  Skill_124075_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_124075_Name = {Text = "타격"},
  Skill_124076_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량의 [Arg3]%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_124076_Name = {Text = "타격"},
  Skill_124077_Desc = {
    Text = "전체 아군이 잃은 HP의 [Arg1]%를 회복한다."
  },
  Skill_124077_Name = {
    Text = "돋아나는 새싹"
  },
  Skill_124078_Desc = {
    Text = "잃은 HP의 [Arg1]%를 회복하고, <ReinforcePVEKeywords:견고> [Arg2]스택을 획득한다."
  },
  Skill_124078_Name = {
    Text = "돋아나는 새싹"
  },
  Skill_124079_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다. 자신에게 <WeaknessIconKeywords:허약> 또는 <VulnerabilityIconKeywords:취약> 상태가 있을 경우, 해당 상태를 적에게 전이한다."
  },
  Skill_124079_Name = {Text = "진혼곡"},
  Skill_124080_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량의 [Arg3]%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_124080_Name = {Text = "타격"},
  Skill_124081_Desc = {
    Text = "<RetaliateIconKeywords:반격> [Arg1]스택을 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득하며, 전진한다."
  },
  Skill_124081_Name = {
    Text = "별의 요람"
  },
  Skill_124082_Desc = {
    Text = "<Guaiwusiwangdikang:죽음 저항> [Arg1]스택을 획득하고, <Guaiwusiwangdikang:죽음 저항>의 HP 회복량이 [Arg2]% 증가한다. 적이 명령 카드를 [Arg3]장 사용할 때마다, 임시로 <PowerIconKeywords:힘> [Arg4]pt를 빼앗는다."
  },
  Skill_124082_Name = {
    Text = "무한한 별빛"
  },
  Skill_124083_Desc = {
    Text = "<RetaliateIconKeywords:반격> [Arg1]스택, 실타래드를 <Block:[Block:Arg2]>pt, <Guaiwusiwangdikang:죽음 저항> [Arg3]스택을 획득한다."
  },
  Skill_124083_Name = {
    Text = "별의 요람"
  },
  Skill_124084_Desc = {
    Text = "최대 HP가 [Arg1]% 증가하고, <PowerIconKeywords:힘> [Arg2]%를 빼앗는다. 적의 최대 HP가 [Arg3]% 감소한다."
  },
  Skill_124084_Name = {
    Text = "양분 흡수"
  },
  Skill_124085_Desc = {
    Text = "최대 HP가 [Arg1]% 증가하고, <PowerIconKeywords:힘> [Arg2]%를 빼앗는다. 이번 턴에 HP를 잃지 않았다면 적의 최대 HP가 [Arg3]% 감소한다."
  },
  Skill_124085_Name = {
    Text = "양분 흡수"
  },
  Skill_124086_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득하고, 손패의 무작위 명령 카드 [Arg2]장과 드로우 덱의 무작위 명령 카드 [Arg2]장에 <SlowIconKeywords:둔화> [Arg3]스택을 부여한다. 후퇴한다."
  },
  Skill_124086_Name = {
    Text = "별빛 오로라"
  },
  Skill_124182_Desc = {
    Text = "최대 HP가 [Arg1]% 증가하고, <PowerIconKeywords:힘> [Arg2]%를 빼앗는다."
  },
  Skill_124182_Name = {
    Text = "양분 흡수"
  },
  Skill_124205_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 적의 실타래드 <Block:[Block:Arg3]>pt당 피해가 1pt 증가한다. <PowerIconKeywords:힘>을 [Arg4]pt 획득한다."
  },
  Skill_124205_Name = {
    Text = "인간 폭발"
  },
  Skill_124218_Desc_1 = {
    Text = "무작위로 생존 깨어남체를 획득한다."
  },
  Skill_124218_Name_1 = {
    Text = "랜덤 생존 깨어남체 획득"
  },
  Skill_124225_Desc_1 = {
    Text = "무작위로 카드를 획득한다."
  },
  Skill_124225_Name_1 = {
    Text = "랜덤 카드 획득"
  },
  Skill_124420_Desc = {
    Text = "무셰트 이후 방어되지 않은 피해를 입힐 때, <Monster_Fervor:임시 열광> 2스택을 획득한다."
  },
  Skill_124420_Name = {
    Text = "안개 속의 유적"
  },
  Skill_124422_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해가 1회 방어될 때마다 <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_124422_Name = {
    Text = "샤이닝☆크러시"
  },
  Skill_124423_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_124423_Name = {
    Text = "빛나는 토네이도"
  },
  Skill_124424_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_124424_Name = {
    Text = "빛나는 토네이도"
  },
  Skill_124740_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 궁극기를 사용한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124740_Name = {
    Text = "추격 테스트"
  },
  Skill_124742_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 「타격」을 사용한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124742_Name = {
    Text = "추격 테스트"
  },
  Skill_124755_Desc = {
    Text = "플레이어가 지명 열쇠 지령을 발동한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124755_Name = {
    Text = "추격 테스트"
  },
  Skill_124761_Desc = {
    Text = "플레이어가 지명 열쇠 지령을 발동한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124761_Name = {
    Text = "추격 테스트"
  },
  Skill_124762_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 궁극기를 사용한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124762_Name = {
    Text = "추격 테스트"
  },
  Skill_124763_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 「타격」을 사용한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124763_Name = {
    Text = "추격 테스트"
  },
  Skill_124814_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 「방어」를 사용한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124814_Name = {
    Text = "추격 테스트"
  },
  Skill_124815_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 스킬1을 사용한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124815_Name = {
    Text = "추격 테스트"
  },
  Skill_124816_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 깨어남을 사용한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124816_Name = {
    Text = "추격 테스트"
  },
  Skill_124817_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 깨어남을 사용한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124817_Name = {
    Text = "추격 테스트"
  },
  Skill_124818_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 스킬1을 사용한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124818_Name = {
    Text = "추격 테스트"
  },
  Skill_124819_Desc = {
    Text = "깨어남체 4명이 번갈아 가며 「방어」를 사용한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124819_Name = {
    Text = "추격 테스트"
  },
  Skill_124820_Desc = {
    Text = "빈 물약 카드, 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_124820_Name = {
    Text = "추격 테스트"
  },
  Skill_124821_Desc = {
    Text = "플레이어가 지명 카드를 사용한다. 블랙리스트 리스닝에 대해서는 침묵을 유지한다."
  },
  Skill_124821_Name = {
    Text = "추격 테스트"
  },
  Skill_124822_Desc = {
    Text = "플레이어가 지명 카드를 사용한다. 모든 리스닝을 발동시킨다."
  },
  Skill_124822_Name = {
    Text = "추격 테스트"
  },
  Skill_124839_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, 손의 무작위 카드 [Arg2]장과 덱의 무작위 카드 [Arg2]장에 <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_124839_Name = {
    Text = "별빛 오로라"
  },
  Skill_124840_Desc = {
    Text = "<RetaliateIconKeywords:반격> [Arg1]스택을 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_124840_Name = {
    Text = "별의 요람"
  },
  Skill_124871_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체의 스킬 카드를 사용한 후, [Arg1]장의 카드를 뽑으며, 다른 깨어남체의 카드를 우선적으로 드로우한다. 매 턴 최대 1회 발동한다."
  },
  Skill_124871_Name_1 = {
    Text = "숙명의 물레"
  },
  Skill_124872_Desc_1 = {
    Text = "아군 한 명을 선택하여, 그가 다음에 사용하는 「스킬」이 2회 발동하게 한다."
  },
  Skill_124872_Name_1 = {Text = "그물"},
  Skill_124874_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 다음에 사용하는 [Arg1]장의 「스킬」이 2회 발동한다."
  },
  Skill_124874_Name_1 = {
    Text = "영원한 직조의 그물"
  },
  Skill_124875_Desc_1 = {
    Text = "카드를 [Arg1] 장 뽑고, 행동력 [Arg1] 점을 획득. 임의의 깨어남체를 선택하여, 자신의 다음 턴 시작 전까지 해당 깨어남체가 입히거나 받는 치명적인 능동 피해를 동일한 양의 <PVPDestinedDeathKeyWords:운명의 전조> 부여로 대체."
  },
  Skill_124875_Name_1 = {
    Text = "운명, 이로써 고하노라"
  },
  Skill_124876_BattleDesc_1 = {
    Text = "무작위로 [Arg3]회 <Damage:[Damage:Arg2]> 피해를 입히고, <PVPDestinedDeathKeyWords:명정예조>, 이 카드를 드로우 더미에 섞어 넣으며, 모든 「방직」 피해 횟수 +1."
  },
  Skill_124876_Desc_1 = {
    Text = "무작위로 [Arg1]회 <Damage:[Damage:Arg2]> 피해를 입히고, <PVPDestinedDeathKeyWords:명정예조>, 이 카드를 드로우 더미에 섞어 넣으며, 모든 「방직」 피해 횟수 +1."
  },
  Skill_124876_Name_1 = {Text = "직조"},
  Skill_124877_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_124877_Name_1 = {Text = "타격"},
  Skill_124878_Desc_1 = {
    Text = "<PVPHoldingKeywords:보유>: 카드를 사용할 때마다 적의 손패 중 무작위 「스킬」로 변화하며, 해당 스킬의 산출력 소모 -[Arg1]."
  },
  Skill_124878_Name_1 = {Text = "예언"},
  Skill_124900_Desc_1 = {
    Text = "모든 아군이 <StrongEffectKeywords:증폭 효과>를 [Arg1] 획득한다. 해당 카드는 다음 드로우 덱에 섞어 넣으며, 다음 사용 시 <StrongEffectKeywords:증폭 효과>가 [Arg2] 증가한다."
  },
  Skill_124900_Name_1 = {
    Text = "운명의 궤적"
  },
  Skill_124900_UnknownName = {
    Text = "운명의 궤적"
  },
  Skill_125370_Desc_1 = {
    Text = "아군 한 명을 선택하여, 다른 아군과 적 전체에게 <PVPLostSoulKeyWords:치취> [Arg1] 층을 부여합니다."
  },
  Skill_125370_Name_1 = {
    Text = "저택의 옛일"
  },
  Skill_125370_UnknownName = {
    Text = "저택의 옛일"
  },
  Skill_125371_AwakerSkillBackgroundStory = {
    Text = "그들은 그녀의 출생에 대해 말하지 않고, 오직 그녀가 태어날 때의 형언할 수 없는 거대한 환희에 대해서만 이야기한다.\n당신의 의식은 황홀함 속에서 녹아내리고, 당신의 과거는 황홀함 속에서 녹아내리며, 당신의 두개골은 황홀함 속에서 녹아내리고…… 당신의 뇌수는 황홀함 속에서 녹아내릴 것이다.\n부드럽고 연한 간식을 단지 입으로 넣으며—— ‘그리움’으로 유도한다."
  },
  Skill_125371_BattleDesc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 의 필정 크리티컬 피해를 가하고 [Arg2]% 중독을 발동합니다. <ResonanceKeywords:공명3>: <EmbryoFusionIconKeywords:배아융합> +[Arg4]( [Arg5]/3 )."
  },
  Skill_125371_BattleDesc_1 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 의 필정 크리티컬 피해를 가하고 [Arg2]% 중독을 발동하며, <EmbryoFusionIconKeywords:배아융합>+ [Arg6]. <ResonanceKeywords:공명3>: <EmbryoFusionIconKeywords:배아융합> +[Arg4]( [Arg5]/3 )."
  },
  Skill_125371_Desc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 의 필정 크리티컬 피해를 가하고 [Arg2]% 중독을 발동합니다. <ResonanceKeywords:공명3>: <EmbryoFusionIconKeywords:배아융합> +[Arg4]."
  },
  Skill_125371_Desc_1 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 의 필정 크리티컬 피해를 가하고 [Arg2]% 중독을 발동하며, <EmbryoFusionIconKeywords:배아융합>+ [Arg6]. <ResonanceKeywords:공명3>: <EmbryoFusionIconKeywords:배아융합> +[Arg4]."
  },
  Skill_125371_EffectNameList = {Text = "피해"},
  Skill_125371_Name = {
    Text = "잊지 못할 그리움"
  },
  Skill_125371_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_125372_Desc_1 = {
    Text = "대상과 <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고 1층 <PVPLostSoulKeyWords:도취>를 부여한다."
  },
  Skill_125372_Name_1 = {
    Text = "끊이지 않는 연사"
  },
  Skill_125373_AwakerSkillBackgroundStory = {
    Text = "왜 신들을 유혹해야 하는가? 그들은 본래 저항할 힘이 없다.\n왜 그들을 부추겨야 하는가? 더 높은 곳, 더 넓은 곳으로, 권력의 소용돌이가 모든 시선을 사로잡는다.\n감정에 갇힌 평범한 사람의 골수는 삼키기 힘들다. 야망으로 절인 평범한 육체는 흥미롭지 않다.\n「꿈 없는 땅(不梦乡)」은 포식자가 사냥감의 찌꺼기에게 내리는 하사품이다.\n그 환희의 중심에는 아무것도 없고, 오직 끝없는 혼란과 끝없는 기교활한 복잡함만이 있다."
  },
  Skill_125373_Desc_0 = {
    Text = "서가 <Energy:[Energy:Arg1]>점의 광기를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 서의 각 종류의 커맨드 카드가 매 턴 처음으로 <ResonanceKeywords:공명> 효과를 발동할 때, 해당 카드의 기본 행동력 소모가 0이 됩니다."
  },
  Skill_125373_Desc_15 = {
    Text = "서가 <Energy:[Energy:Arg1]>점의 광기를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 서의 각 종류의 커맨드 카드가 매 턴 처음으로 <ResonanceKeywords:공명> 효과를 발동할 때, 해당 카드의 기본 행동력 소모가 0이 됩니다. <WitherKeywords0:취해 있다>의 중첩 상한이 15층으로 증가하며, 서가 매 턴 처음 사용하는 커맨드 카드가 1회 추가로 발동합니다."
  },
  Skill_125373_EffectNameList = {Text = "광기"},
  Skill_125373_Name = {
    Text = "불몽향의 주인"
  },
  Skill_125374_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_125374_Name_1 = {Text = "타격"},
  Skill_125375_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPLostSoulKeyWords:치취> 1스택을 부여한다."
  },
  Skill_125375_Name_1 = {
    Text = "어둠 속의 밀회"
  },
  Skill_125376_AwakerSkillBackgroundStory = {
    Text = "예로부터 지금까지, 사랑이라는 글자. \n 언제나 사람을 죄악의 구렁텅이로 이끌면서도 결코 고개를 돌리지 못하게 할 뿐이다."
  },
  Skill_125376_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시킨다.] 행동력 [Arg2]pt를 획득하고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg3]스택을 부여한다. <WitherKeywords1:약속> 또는 <WitherKeywords2:영혼 탈취> 중 하나를 선택한다."
  },
  Skill_125376_Desc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시킨다.] 행동력 [Arg2]pt를 획득하고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg3]스택을 부여한다. 다음에 발동되는 <ResonanceKeywords:공진> 효과가 2배로 증가한다. <WitherKeywords1:약속> 또는 <WitherKeywords2:영혼 탈취> 중 하나를 선택한다."
  },
  Skill_125376_EffectNameList = {
    Text = "중독, 힘 감소"
  },
  Skill_125376_Name = {
    Text = "밤안개 속의 서약"
  },
  Skill_125376_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식> : 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 임시로 감소시킵니다.]연산력 [Arg2]을 획득하고, <EmbryoFusionIconKeywords:배아융합>+ [Arg4], 모든 적에게 [Poison:Arg3] 층의 <IntoxicationIconKeywords:중독>을 부여합니다. 선택: <WitherKeywords3:상허> 또는 <WitherKeywords4:탈백>."
  },
  Skill_125376_OverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:포식> : 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 임시로 감소시킵니다.]연산력 [Arg2]을 획득하고, <EmbryoFusionIconKeywords:배아융합>+ [Arg4], 모든 적에게 [Poison:Arg3] 층의 <IntoxicationIconKeywords:중독>을 부여합니다. 자신의 다음 <ResonanceKeywords:공명> 효과가 2배가 됩니다. 선택: <WitherKeywords3:상허> 또는 <WitherKeywords4:탈백>."
  },
  Skill_125376_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_125377_Desc_1 = {
    Text = "<PVPSneakKeywords:잠행>을 부여하고, <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_125377_Name_1 = {
    Text = "서리는 밤안개"
  },
  Skill_125378_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 [Arg1] 스택 <PVPLostSoulKeyWords:도취>를 부여합니다."
  },
  Skill_125378_Name_1 = {
    Text = "목련의 미끼"
  },
  Skill_125379_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:다른 아군이 「광기 폭발」 후, 손패에 있는 장착자의 모든 「스킬」 연산력 소모 -1."
  },
  Skill_125379_Name_1 = {
    Text = "부질없는 찡그림"
  },
  Skill_125380_AwakerSkillBackgroundStory = {
    Text = "그녀의 부채 아래에는 입맞춤이 하나, 그리고 수없이 많은 입맞춤이 숨겨져 있다.\n풍부하고, 즙이 많고, 부드러운….포박, 소멸, 침묵."
  },
  Skill_125380_BattleDesc = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다. <ResonanceKeywords:공진3>: 전체 적에게 <WitherKeywords:도취> 1스택을 부여한다([Arg3]/3)."
  },
  Skill_125380_Desc_0 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다. <ResonanceKeywords:공진3>: 전체 적에게 <WitherKeywords:도취> 1스택을 부여한다."
  },
  Skill_125380_Desc_3 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다. <ResonanceKeywords:공진3>: 전체 적에게 <WitherKeywords0:도취> 1스택을 부여한다."
  },
  Skill_125380_EffectNameList_0 = {
    Text = "중독, 힘 감소"
  },
  Skill_125380_Name = {
    Text = "부채에 봉한 키스"
  },
  Skill_125380_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_125381_AwakerSkillBackgroundStory = {
    Text = "“기기괴괴, 괴괴기기. 죽은 아내 한밤중에 무덤 파고 기어 나와, 배신한 몹쓸 낭군 가마솥에 펄펄 삶네.“"
  },
  Skill_125381_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_125381_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <ResonanceKeywords:공진3>: 추가로 <Energy:[Energy:Arg3]>pt의 광기를 획득한다([Arg4]/3)."
  },
  Skill_125381_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 쉬가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_125381_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 쉬가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <ResonanceKeywords:공진3>: 추가로 <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_125381_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_125381_Name = {Text = "타격"},
  Skill_125381_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_125382_Desc_1 = {
    Text = "대상의 모든 <PVPLostSoulKeyWords:치취>를 제거하고 <Damage:[Damage:Arg1]> 피해를 입힌다. 1층 제거할 때마다 무작위 적에게 1회 <Damage:[Damage:Arg2]> 피해를 입히고 <StrongEffectKeywords:강효> +[Arg3]."
  },
  Skill_125382_Name_1 = {
    Text = "밤안개 속의 서약"
  },
  Skill_125383_AwakerSkillBackgroundStory = {
    Text = "“얼굴 없는 신녀께서 고통을 구원하려,\n얼굴 베고 가슴 갈라 낭군의 뼈를 발라,\n제단 앞 지고하신 주님께 제물로 바치옵네.”"
  },
  Skill_125383_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_125383_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <ResonanceKeywords:공진3>: 추가로 광기를 <Energy:[Energy:Arg3]>pt 획득한다([Arg4]/3)."
  },
  Skill_125383_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 쉬가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_125383_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 쉬가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <ResonanceKeywords:공진3>: 추가로 광기를 <Energy:[Energy:Arg3]>pt 획득한다."
  },
  Skill_125383_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_125383_Name = {Text = "방어"},
  Skill_125383_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_125903_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득한다. 덱과 버린 카드 더미에서 명령 카드 [Arg3]장을 발견하고, 그중 [Arg4]장을 선택하여 <DepleteIconKeywords:소모>한다."
  },
  Skill_125903_Name = {
    Text = "만물 귀일"
  },
  Skill_125904_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:취약>, <WeaknessIconKeywords:허약> 및 <VulnerabilityIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_125904_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_125905_Desc = {
    Text = "턴 종료 시 손에 있을 경우, 모든 깨어남체가 광기 3pt를 잃는다. 버릴 경우 <DepleteIconKeywords:소모>된다."
  },
  Skill_125905_Name = {Text = "침묵"},
  Skill_125906_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <FragileIconKeywords:손상> [Arg3]스택을 부여한다. 명령 카드를 [Arg4]장 사용한 후, 의도를 <FragileIconKeywords:손상> 및 <WeaknessIconKeywords:허약> [Arg7]스택을 부여하는 「네 날개의 발현」으로 변경한다."
  },
  Skill_125906_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_125907_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다. 다음에 사용할 명령 카드의 깨어남체를 <Seal:봉인>한다. [Arg2]턴간 지속된다."
  },
  Skill_125907_Name = {
    Text = "시공을 가르는 날개"
  },
  Skill_125908_Desc = {
    Text = "적이 행동력을 소모할 때, 획득하는 열쇠 에너지가 [Arg1]% 감소한다. 타비가 방어되지 않은 피해를 입힌 후, 「<DerivativeCardKeywords_131:진·윤회 역설>」 [Arg2]장을 손에 넣는다."
  },
  Skill_125908_Name = {
    Text = "은열쇠의 문"
  },
  Skill_125909_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <FragileIconKeywords:손상> 및 <WeaknessIconKeywords:허약> [Arg3]스택을 부여한다. 명령 카드를 [Arg4]장 사용한 후, 의도를 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약> 및 <VulnerabilityIconKeywords:취약> [Arg7]스택을 부여하는 「여섯 날개의 만개」로 변경한다."
  },
  Skill_125909_Name = {
    Text = "네 날개의 성장"
  },
  Skill_126008_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 30pt를 획득하고, 다른 깨어남체는 광기 10pt를 잃는다. 턴 종료 시 이 카드가 손에 있을 경우, 아군에게 피해를 준다."
  },
  Skill_126008_Name = {
    Text = "진·회귀역설"
  },
  Skill_126350_Desc_1 = {
    Text = "대상 한 명에게 <PVPSneakKeywords:잠행>을 부여한다."
  },
  Skill_126350_Name_1 = {Text = "잠행"},
  Skill_126446_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는(<Damage:[Damage:Arg4]>) <IntoxicationIconKeywords:중독>을 부여한다. 손패 [Arg5]장에 <BurningKeywords:연소>를 부여한다."
  },
  Skill_126446_Name = {
    Text = "부패의 푸른 불꽃"
  },
  Skill_126447_Desc = {
    Text = "피해 <Damage:[Damage:Arg1]>pt를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 ( [Arg4] )pt 부여한다. 손패 [Arg5]장에 <BurningKeywords:연소>를 부여한다."
  },
  Skill_126447_Name = {
    Text = "사멸의 푸른 불꽃"
  },
  Skill_126448_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는(<Damage:[Damage:Arg4]>) <IntoxicationIconKeywords:중독>을 부여한다. 손패 [Arg5]장에 <BurningKeywords:연소>를 부여한다."
  },
  Skill_126448_Name = {
    Text = "푸른 불꽃"
  },
  Skill_126449_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 <MonsterLizVerdantSpark:청록색 불씨> [Arg2]스택을 획득한다. 해당 의도로 전환할 때, 이번 턴에 「공격」을 [Arg3]회 받을 때마다 <MonsterLizVerdantSpark:청록색 불씨> [Arg4]스택을 획득한다."
  },
  Skill_126449_Name = {
    Text = "유혹의 불꽃"
  },
  Skill_126450_Desc = {
    Text = "<MonsterLizVerdantSpark:청록색 불씨> [Arg1]스택을 획득한다. HP를 [Arg2]% 잃을 때마다 <MonsterLizVerdantSpark:청록색 불씨> [Arg3]스택을 획득한다. <ExhaustionCounter:눈에는 눈>을 획득한다."
  },
  Skill_126450_Name = {
    Text = "비취의 반영"
  },
  Skill_126451_Desc = {
    Text = "해당 의도로 전환할 때 부정 상태를 해제한다. <PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 모든 손패를 버린다. <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다. 손패 1장을 버릴 때마다 추가로 1회 피해를 입히고, <MonsterLizVerdantSpark:청록색 불씨> 1스택을 획득한다."
  },
  Skill_126451_Name = {
    Text = "죽음을 고하는 춤"
  },
  Skill_126452_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 모든 손패를 버린다. <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다. 손패 [Arg4]장을 버릴 때마다 추가로 [Arg5]회 피해를 입히고, <MonsterLizVerdantSpark:청록색 불씨> [Arg6]스택을 획득한다."
  },
  Skill_126452_Name = {
    Text = "죽음을 고하는 춤"
  },
  Skill_126484_AwakerSkillBackgroundStory = {
    Text = "첫 번째 실타래이 드리워졌을 때, 운명은 이미 그 판결을 선고했다."
  },
  Skill_126484_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_126484_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 아라크네가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_126484_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_126484_Name = {Text = "타격"},
  Skill_126484_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_126484_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_126484_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이번 턴 처음 사용할 경우, 「끝없는 실타래타래」 추격을 1회 발동한다([Arg3]/1)."
  },
  Skill_126485_AwakerSkillBackgroundStory = {
    Text = "운명 또한 인형의 무모함에 양보할 것이다.\n만약, 그들이 정해진 대가를 감수할 의지가 있다면."
  },
  Skill_126485_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_126485_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 아라크네가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_126485_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_126485_Name = {Text = "방어"},
  Skill_126485_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_126485_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_126485_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 점 방어막를 얻습니다. <Energy:[Energy:Arg2]> 점 광기를 얻습니다. 이번 턴에 처음 사용한다면, 1회 「무한 실타래타래」 추격을 발동합니다 ( [Arg3]/1)."
  },
  Skill_126486_AwakerSkillBackgroundStory = {
    Text = "그녀는 운명의 이름으로, 이곳에서 선언한다.\n모든 잘못된 운수는 시간의 먼지 속에 묻히리라. 세계의 운명은 정해진 궤도로 돌아가리라.\n뒤엉킨 실타래은 이곳에서 끊어지리라. 버림받은 불행한 자는 이곳에서 안식을 얻으리라."
  },
  Skill_126486_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 피해 강효가 [Arg2]% 증가하며, 모든 손패의 <SlowIconKeywords:둔화> 상태를 해제한다."
  },
  Skill_126486_EffectNameList = {
    Text = "실타래드, 피해 증폭, 끝없는 실타래타래 운명의 판결"
  },
  Skill_126486_Name = {
    Text = "운명, 이로써 고하노라"
  },
  Skill_126486_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 임시 피해 강효가 [Arg2]% 증가하며, 모든 손패의 <SlowIconKeywords:둔화> 상태를 해제한다. 손과 초차원 공간에서 <SingularityKeywords1:특이점 비콘>을 보유한 카드 최대 5장의 임시 원본 복제를 생성하여, 무작위로 덱과 버린 카드 더미에 넣고 행동력 소모를 0으로 만든다."
  },
  Skill_126486_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2％, 공격력*GrowValue3"
  },
  Skill_126488_BattleDesc_0 = {
    Text = "최대 HP의 [Float:Arg3]%([Arg4])를 잃고, <SilkKeywords:직명> 1스택을 획득한다. 이번 전투에서 「<DerivativeCardKeywords_138:사선인명>」으로 잃은 HP와 아라크네가 주는 <CutKeywords:운명 재단>이 [Arg2]% 증가한다. 허무: 아라크네가 무작위로 15~30pt의 광기를 획득한다."
  },
  Skill_126488_Desc_0 = {
    Text = "최대 HP의 [Arg1]%를 잃고, <SilkKeywords:직명> 1스택을 획득한다. 이번 전투에서 「<DerivativeCardKeywords_138:사선인명>」으로 잃은 HP와 아라크네가 주는 <CutKeywords:운명 재단>이 [Arg2]% 증가한다. 허무: 아라크네가 무작위로 15~30pt의 광기를 획득한다."
  },
  Skill_126488_Name = {
    Text = "운명을 이끄는 실타래"
  },
  Skill_126490_AwakerSkillBackgroundStory = {
    Text = "장막이 올라가는 그 순간, 인형들은 고개를 들어 물레 뒤의 그 온화한 얼굴을 바라보았다.\n실타래이 팽팽히 당겨지고, 인형들의 노래와 춤 속에서 그녀는 어머니처럼 미소 지었다.\n운명의 무대 위에서, 그녀는 그들의 유일한 관객이었다."
  },
  Skill_126490_BattleDesc_0 = {
    Text = "아라크네가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「소멸」이 초차원 공간의 명령 카드 1장을 선택하여 꺼내고, 「다음 사용 시 추가로 1회 발동」을 부여하며, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동하도록 변경된다."
  },
  Skill_126490_BattleDesc_15 = {
    Text = "아라크네가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 「소멸」이 초차원 공간의 명령 카드 1장을 선택하여 꺼내는 것으로 변경되며, 「다음 사용 후 추가 1회 발동」을 부여하고, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동합니다. 「소멸」 발동 후 즉시 모든 적에게 「운명 재단」의 50%에 해당하는 <FixedDamage:순수 피해>를 입히며, 다음 광기 폭발의 피해 증폭과 방어막이 50% 증가합니다."
  },
  Skill_126490_Desc_0 = {
    Text = "아라크네가 [Arg2]%의 기본 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 「소멸」이 초차원 공간의 지령 카드 1장을 선택하여 꺼내고, 「다음 사용 시 추가로 1회 발동」을 부여하며, 다음 1장의 사용한 지령 카드가 <SingularityKeywords3:차원 이동>을 발동하도록 변경됩니다."
  },
  Skill_126490_Desc_15 = {
    Text = "아라크네가 [Arg2]% 광기 최대치를 획득합니다. <ExaltIconKeywords:영지 각성>: 「소멸」이 초차원 공간의 명령 카드 1장을 선택하여 꺼내는 것으로 변경되며, 「다음 사용 후 추가 1회 발동」을 부여하고, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동합니다. 「소멸」 발동 후 즉시 모든 적에게 「운명 재단」의 50%에 해당하는 <FixedDamage:순수 피해>를 입히며, 다음 광기 폭발의 피해 증폭과 방어막이 50% 증가합니다."
  },
  Skill_126490_EffectNameList = {Text = "광기"},
  Skill_126490_Name = {
    Text = "인형극 개막"
  },
  Skill_126656_Desc = {
    Text = "위치 1의 깨어남체에게 후속 행동을 추가하여, 해당 깨어남체의 「타격」 카드를 사용하게 한다."
  },
  Skill_126656_Name = {
    Text = "추격 테스트"
  },
  Skill_126657_Desc = {
    Text = "전방 적에게 후속 행동을 추가하여, 현재 의도를 사용하게 한다."
  },
  Skill_126657_Name = {
    Text = "추격 테스트"
  },
  Skill_126658_Desc = {
    Text = "수호자에게 후속 행동을 추가하여, 스킬@주인공 스킬@머릿속의 목소리를 사용하게 한다."
  },
  Skill_126658_Name = {
    Text = "추격 테스트"
  },
  Skill_126767_BattleDesc = {
    Text = "전체 적에게 <WitherKeywords:치취> [Arg1]스택을 부여한다."
  },
  Skill_126767_Desc_0 = {
    Text = "전체 적에게 <WitherKeywords:치취> [Arg1]스택을 부여한다."
  },
  Skill_126767_Desc_3 = {
    Text = "전체 적에게 <WitherKeywords0:치취> [Arg1]스택을 부여한다."
  },
  Skill_126767_Name = {Text = "정혼"},
  Skill_126768_BattleDesc = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1층 제거할 때마다 대상 최대 HP의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히고 [Arg2]% 중독을 발동합니다."
  },
  Skill_126768_Desc_0 = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1층 제거할 때마다 대상 최대 HP의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히고 [Arg2]% 중독을 발동합니다."
  },
  Skill_126768_Desc_3 = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1층 제거할 때마다 대상 최대 HP의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히고 [Arg2]% 중독을 발동합니다."
  },
  Skill_126768_Name = {Text = "탐혼"},
  Skill_126793_Desc = {
    Text = "행동력 1pt를 획득하고, 모든 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시킨다. 「서」가 팀에 있을 경우, 모든 적에게 <WitherKeywords:치취> 1스택을 부여한다."
  },
  Skill_126793_Name = {
    Text = "저택의 옛일"
  },
  Skill_126880_BattleDesc = {
    Text = "전체 적에게 <WitherKeywords:치취> [Arg1]스택을 부여하고, 부여하는 중독량이 200% 증가한다."
  },
  Skill_126880_Desc_0 = {
    Text = "전체 적에게 <WitherKeywords:치취> [Arg1]스택을 부여하고, 부여하는 중독량이 200% 증가한다."
  },
  Skill_126880_Desc_3 = {
    Text = "전체 적에게 <WitherKeywords0:치취> [Arg1]스택을 부여하고, 부여하는 중독량이 200% 증가한다."
  },
  Skill_126880_Name = {Text = "정혼"},
  Skill_126881_BattleDesc = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1층 제거할 때마다 [Arg3] 점 진홍빛 용광로를 적립하고, 대상 최대 HP의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, [Arg2]% 중독을 발동합니다."
  },
  Skill_126881_Desc_0 = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1층 제거할 때마다 [Arg3] 점 진홍빛 용광로를 적립하고, 대상 최대 HP의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, [Arg2]% 중독을 발동합니다."
  },
  Skill_126881_Desc_3 = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1층 제거할 때마다 [Arg3] 점 진홍빛 용광로를 적립하고, 대상 최대 HP의 [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, [Arg2]% 중독을 발동합니다."
  },
  Skill_126881_Name = {Text = "탐혼"},
  Skill_127246_Desc = {
    Text = "<MonsterTimeBeacon:회귀> [Arg1]스택을 획득한다. 이후 매 턴 종료 시 <MonsterTimeBeacon:회귀> [Arg2]스택을 획득한다."
  },
  Skill_127246_Name = {
    Text = "엔트로피 역전"
  },
  Skill_127247_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 <PowerIconKeywords:힘>과 <ExhaustionIconKeywords:힘 감소>의 [Arg3]배 영향을 받으며, 사용 후 [Arg4]배 증가한다. <MonsterTimeBeacon:회귀>: [Arg5]배의 피해를 입힌다."
  },
  Skill_127247_Name = {
    Text = "운명의 검"
  },
  Skill_127248_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다. 덱 또는 버린 카드 더미의 카드 [Arg2]장을 손에 넣고, 영구적으로 <MonsterSightUnbound:초월의 눈>과 <RetainIconKeywords:유지>를 부여한다. <MonsterTimeBeacon:회귀>: 추가로 <PowerIconKeywords:힘> [Arg3]pt를 획득한다."
  },
  Skill_127248_Name = {
    Text = "초월의 눈"
  },
  Skill_127249_Desc = {
    Text = "적 턴 시작 시, 적의 이전 턴 마지막에 사용한 명령 카드 [Arg1]장을 손에 넣고 <NothingnessIconKeywords:허무>를 부여한다. 손에 넣을 수 있는 명령 카드가 부족할 경우, 부족한 장수만큼 카드를 드로우한다. <MonsterTimeBeacon:회귀> [Arg2]스택을 획득한다."
  },
  Skill_127249_Name = {
    Text = "패러독스 수렴"
  },
  Skill_127250_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BlindingKeywords:실타래명> [Arg3]스택을 부여한다. <MonsterTimeBeacon:회귀>: 추가로 [Arg4]회 피해 및 <BlindingKeywords:실타래명> [Arg5]스택을 부여한다."
  },
  Skill_127250_Name = {Text = "타격"},
  Skill_127251_Desc = {
    Text = "적 턴 시작 시, 적의 이전 턴 마지막에 사용한 명령 카드 [Arg1]장을 손에 넣고, <NothingnessIconKeywords:허무>와 <DepleteIconKeywords:소모>를 부여한다. 손에 넣을 수 있는 명령 카드가 부족할 경우, 부족한 장수만큼 카드를 드로우한다. <MonsterTimeBeacon:회귀> [Arg2]스택을 획득한다."
  },
  Skill_127251_Name = {
    Text = "패러독스 수렴"
  },
  Skill_127252_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다. 덱 또는 버린 카드 더미의 카드 [Arg2]장을 손에 넣고, 영구적으로 <MonsterSightUnbound:초월의 눈>, <RetainIconKeywords:유지> 및 <SlowIconKeywords:둔화>를 부여한다. <MonsterTimeBeacon:회귀>: 추가로 <PowerIconKeywords:힘> [Arg3]pt를 획득한다."
  },
  Skill_127252_Name = {
    Text = "초월의 눈"
  },
  Skill_127698_Desc = {
    Text = "<FragileIconKeywords:손상>을 [Arg1]중첩 부여하고, 카드 [Arg2]장에 <BrokenCard:암중 파괴>를 [Arg3]중첩 부여한다."
  },
  Skill_127698_Name = {Text = "분해"},
  Skill_127699_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 무작위 증상 카드 [Arg3]장을 섞어 넣는다."
  },
  Skill_127699_Name = {
    Text = "흑사의 키스"
  },
  Skill_127700_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_127700_Name = {
    Text = "독을 바른 침"
  },
  Skill_128020_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 카드 [Arg2]장에 <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_128020_Name = {
    Text = "어둠의 실타래타래"
  },
  Skill_128021_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 깨어남체의 <DepleteIconKeywords:소모>가 부여된 「타격」 [Arg3]장을 상대의 덱에 섞어 넣는다."
  },
  Skill_128021_Name = {
    Text = "환독 침식"
  },
  Skill_128048_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해를 1회 입힐 때마다 대상이 <PowerIconKeywords:힘> [Arg3]pt를 잃는다."
  },
  Skill_128048_Name = {Text = "쇠퇴"},
  Skill_128049_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 손 또는 덱 맨 위의 명령 카드 [Arg2]장을 [Arg3]턴간 봉인한다."
  },
  Skill_128049_Name = {
    Text = "속박의 그물"
  },
  Skill_128052_Desc = {
    Text = "[Arg1] 층 <WeaknessIconKeywords:허약>을 부여하고, 손 안 또는 덱 상단의 커맨드 카드 [Arg2] 장을 [Arg3] 턴 동안 봉인합니다. 전열로 이동하고, 후방에 냉거미 무리 [Arg4] 마리를 소환합니다."
  },
  Skill_128052_Name = {
    Text = "속박의 그물"
  },
  Skill_128053_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 손 또는 덱 맨 위의 명령 카드 [Arg2]장을 [Arg3]턴간 봉인한다. 전방으로 이동하고, 후방에 소형 냉거미 흰색 군체 [Arg4]마리를 소환한다."
  },
  Skill_128053_Name = {
    Text = "속박의 그물"
  },
  Skill_128207_Desc = {
    Text = "매 행동 종료 후 <ParcloseIconKeywords:장벽> [Arg1]스택과 <Chapter5_Monster_Fervor1:임시 열광> [Arg2]스택을 획득한다."
  },
  Skill_128207_Name = {
    Text = "직모의 요람"
  },
  Skill_128227_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해를 1회 입힐 때마다 대상이 명령 카드 [Arg3]장을 버린다."
  },
  Skill_128227_Name = {Text = "파멸"},
  Skill_128229_Desc = {
    Text = "[Arg1] 층 <FragileIconKeywords:취약>을 부여하고, 손 안 또는 덱 상단의 커맨드 카드 [Arg2] 장에 [Arg3] 층 <BrokenCard:암중파괴>를 부착합니다. 전열로 이동하고, 후방에 연옥 거미떼 [Arg4] 마리를 소환합니다."
  },
  Skill_128229_Name = {
    Text = "붕괴의 실타래"
  },
  Skill_128230_Desc = {
    Text = "<FragileIconKeywords:손상>을 [Arg1]중첩 부여하고, 손 또는 덱 맨 위의 명령 카드 [Arg2]장에 <BrokenCard:암중 파괴>를 [Arg3]중첩 부여한다. 전방으로 이동하고, 후방에 소형 냉거미 검은색 군체를 [Arg4]마리 소환한다."
  },
  Skill_128230_Name = {
    Text = "붕괴의 실타래"
  },
  Skill_128233_Desc = {
    Text = "<FragileIconKeywords:손상>을 [Arg1]중첩 부여하고, 손 또는 덱 맨 위의 명령 카드 [Arg2]장에 <BrokenCard:암중 파괴>를 [Arg3]중첩 부여한다."
  },
  Skill_128233_Name = {
    Text = "붕괴의 실타래"
  },
  Skill_128254_Desc = {
    Text = "매 행동 종료 후 <PowerIconKeywords:힘> [Arg1]pt와 <Chapter5_Monster_Fervor2:임시 열광> [Arg2]스택을 획득한다."
  },
  Skill_128254_Name = {
    Text = "직모의 속삭임"
  },
  Skill_128474_Desc = {
    Text = "전열 아군과 위치를 교환하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 이번 턴에 「옛날 잔재」를 파괴했다면, 임시 <ReinforcePVEKeywords:견고> [Arg3]스택을 획득하고, <Damage:[Damage:Arg4]>pt의 피해를 [AttackTimes:Arg5]회 입히며, <Chapter5_Monster_Fervor1:임시 열광> [Arg6]스택을 획득하는 「착격」으로 전환된다."
  },
  Skill_128474_Name = {
    Text = "열광 찌르기"
  },
  Skill_128475_Desc = {
    Text = "전열 아군과 위치를 교환하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, <Chapter5_Monster_Fervor1:임시 열광> [Arg3]스택을 획득한다."
  },
  Skill_128475_Name = {Text = "쪼기"},
  Skill_128476_Desc = {
    Text = "전열 아군과 위치를 교환하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 이번 턴에 「옛날 잔재」를 파괴했다면, 임시 <ReinforcePVEKeywords:견고> [Arg3]스택을 획득하고, <Damage:[Damage:Arg4]>pt의 피해를 [AttackTimes:Arg5]회 입히며, <Chapter5_Monster_Fervor1:임시 열광> [Arg6]스택을 획득하는 「착격」으로 전환된다."
  },
  Skill_128476_Name = {
    Text = "열광 찌르기"
  },
  Skill_128477_Desc = {
    Text = "전열 아군과 위치를 교환하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, <Chapter5_Monster_Fervor1:임시 열광> [Arg3]스택을 획득한다."
  },
  Skill_128477_Name = {Text = "쪼기"},
  Skill_128624_Desc = {
    Text = "해당 의도로 전환할 때, 즉시 <Chapter5_Monster_Fervor3:열광> [Arg1]스택을 획득한다. <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히고, [Arg4]회 방어되지 않은 피해를 입힐 때마다 <Chapter5_Monster_Fervor3:열광> [Arg5]스택을 획득한다."
  },
  Skill_128624_Name = {
    Text = "광희의 고치"
  },
  Skill_128625_Desc = {
    Text = "해당 의도로 전환할 때 즉시 <EmptinessKeywords:공허> [Arg1]스택을 부여하고 모든 깨어남체가 광기 [Arg2]pt를 잃는다. <Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg4]회 입히고, 모든 손패를 버린다."
  },
  Skill_128625_Name = {
    Text = "경구의 고치"
  },
  Skill_128627_Desc = {
    Text = "해당 의도로 전환할 때, 다음 턴 시작까지 명령 카드를 [Arg1]장 사용할 때마다 임시 <PowerIconKeywords:힘>을 [Arg2]pt 획득한다. <Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg4]회 입히고, 대상의 HP가 낮을수록 피해가 증가하며 최대 피해 <Damage:[Damage:Arg5]>pt까지 증가한다."
  },
  Skill_128627_Name = {
    Text = "폭노의 고치"
  },
  Skill_128628_Desc = {
    Text = "해당 의도로 전환할 때, 무작위 증상 카드 [Arg1]장을 손에 넣는다. <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>, <FragileIconKeywords:취약>, <HeavyInjuryKeywords:중상>을 [Arg2]턴간 부여하고, <BleedingIconKeywords:출혈>을 [Arg3]스택 부여한다. 이번 턴에 증상 카드를 [Arg4]장 사용할 때마다 <BleedingIconKeywords:출혈> 효과가 [Arg5] 증가한다."
  },
  Skill_128628_Name = {
    Text = "애민의 고치"
  },
  Skill_128689_Desc = {
    Text = "임시 크리티컬 확률 +[Arg1]%, 행동력 1 포인트를 획득합니다. 이번 전투에서 처음 발동 시 모든 적에게 [Arg3] 포인트 <AshesPastKeyWord:옛날 잔재>를 부여합니다."
  },
  Skill_128689_Name = {
    Text = "연말 불꽃"
  },
  Skill_129565_BattleDesc_1 = {
    Text = "아군 전체 임시 <StrongEffectKeywords:강효>+ [Arg3], 전사한 아군 1명당 추가로 [Arg1] 임시 <StrongEffectKeywords:강효>를 획득합니다."
  },
  Skill_129565_Desc_1 = {
    Text = "아군 전체 임시 <StrongEffectKeywords:강효>+ [Arg1], 아군이 사망할 때마다 임시 <StrongEffectKeywords:강효>+1."
  },
  Skill_129565_Name_1 = {
    Text = "연말 불꽃"
  },
  Skill_129565_UnknownName = {
    Text = "연말 불꽃"
  },
  Skill_129615_Desc = {
    Text = "해당 의도로 전환할 때 즉시 <EmptinessKeywords:공허> [Arg1]스택을 부여하고 모든 깨어남체가 광기 [Arg2]pt를 잃는다. <Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg4]회 입히고, 모든 손패를 버린다."
  },
  Skill_129615_Name = {
    Text = "경구의 고치"
  },
  Skill_129616_Desc = {
    Text = "해당 의도로 전환할 때, 다음 턴 시작까지 명령 카드를 [Arg1]장 사용할 때마다 임시 <PowerIconKeywords:힘>을 [Arg2]pt 획득한다. <Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg4]회 입히고, 대상의 HP가 낮을수록 피해가 증가하며 최대 피해 <Damage:[Damage:Arg5]>pt까지 증가한다."
  },
  Skill_129616_Name = {
    Text = "폭노의 고치"
  },
  Skill_129617_Desc = {
    Text = "해당 의도로 전환할 때, 무작위 증상 카드 [Arg1]장을 손에 넣는다. <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>, <FragileIconKeywords:취약>, <HeavyInjuryKeywords:중상>을 [Arg2]턴간 부여하고, <BleedingIconKeywords:출혈>을 [Arg3]스택 부여한다. 이번 턴에 증상 카드를 [Arg4]장 사용할 때마다 <BleedingIconKeywords:출혈> 효과가 [Arg5] 증가한다."
  },
  Skill_129617_Name = {
    Text = "애민의 고치"
  },
  Skill_129618_Desc = {
    Text = "해당 의도로 전환할 때, 즉시 <Chapter5_Monster_Fervor3:열광> [Arg1]스택을 획득한다. <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히고, [Arg4]회 방어되지 않은 피해를 입힐 때마다 <Chapter5_Monster_Fervor3:열광> [Arg5]스택을 획득한다."
  },
  Skill_129618_Name = {
    Text = "광희의 고치"
  },
  Skill_129622_Desc = {
    Text = "해당 의도로 전환할 때 즉시 <EmptinessKeywords:공허> [Arg1]스택을 부여하고 모든 깨어남체가 광기 [Arg2]pt를 잃는다. <Damage:[Damage:Arg3]>pt의 피해를 [AttackTimes:Arg4]회 입히고, 모든 손패를 버린다."
  },
  Skill_129622_Name = {
    Text = "경구의 고치"
  },
  Skill_129638_Desc = {
    Text = "해당 의도로 전환할 수 없다. 해당 의도로 전환할 때, 즉시 임시 <ReinforcePVEKeywords:견고> [Arg1]스택을 획득한다.\n\n<Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히고, 무작위 증상 카드 [Arg4]장을 덱에 섞어 넣으며, <Chapter5_Monster_Fervor3:열광> [Arg5]스택을 획득하고, 모든 깨어남체가 광기 [Arg6]pt를 잃는다."
  },
  Skill_129638_Name = {
    Text = "파견광연"
  },
  Skill_129811_Desc = {
    Text = "전략 1개를 선택한다. 「장해지주」가 「잔해 수취」를 발동할 때마다 이 카드를 손에 넣는다."
  },
  Skill_129811_Name = {
    Text = "전략 수립"
  },
  Skill_129812_Desc = {
    Text = "모든 적이 주는 피해가 임시로 30% 감소한다."
  },
  Skill_129812_Name = {
    Text = "정면 교란"
  },
  Skill_129813_Desc = {
    Text = "모든 적이 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다. 「장해지주」가 <Guaiwucanhai:잔해>의 절반을 잃는다."
  },
  Skill_129813_Name = {
    Text = "기습 비축"
  },
  Skill_129822_Desc = {
    Text = "<EmptinessKeywords:공허> 및 <WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 잃은 HP의 [Arg2]%를 회복한다. 공간 가장 왼쪽의 카드 [Arg3]장을 복사하여 덱 맨 위에 넣고, 무작위 명령 카드 [Arg4]장을 복사하여 차원 균열에 넣는다."
  },
  Skill_129822_Name = {
    Text = "운명의 그물"
  },
  Skill_129823_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「차원 균열」에 있는 카드 1장당 추가로 1회 피해를 입힌다."
  },
  Skill_129823_Name = {
    Text = "끝없는 실타래"
  },
  Skill_129824_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]스택 부여하며, 「차원 균열」에 있는 카드 1장당 1스택을 추가로 부여한다."
  },
  Skill_129824_Name = {
    Text = "영원한 직조"
  },
  Skill_129826_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, 무작위 명령 카드 [Arg2]장의 복사본을 「차원 균열」에 넣으며, <DerivativeCardKeywords_23:상처> [Arg3]장을 덱에 넣는다."
  },
  Skill_129826_Name = {
    Text = "운명, 이로써 고하노라"
  },
  Skill_129827_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, 무작위 명령 카드 [Arg2]장의 복사본을 「차원 균열」에 넣으며, 무작위 <AberrationKeywords:변이> [Arg3]장을 덱에 넣는다."
  },
  Skill_129827_Name = {
    Text = "운명을 초월하는 비가"
  },
  Skill_129828_Desc = {
    Text = "「끊어진 실타래의 진동」 발동 후의 의도를 변경한다. 무작위 커맨드 카드 [Arg1]장의 복사본을 「차원 균열」에 넣고, [Arg2]장의 카드가 「차원 균열」을 떠날 때마다 [Arg3]층의 <BrokenCard:암중 파괴>를 부여한다."
  },
  Skill_129828_Name = {
    Text = "인형극장 개막"
  },
  Skill_129856_Desc = {
    Text = "촉수 1개를 생성하고 임시 촉수 피해를 [Arg1] 획득한다."
  },
  Skill_129856_Name = {
    Text = "왕권의 위엄"
  },
  Skill_129857_Desc = {
    Text = "「진노」를 획득하고, 「졸음」 12스택, 그리고 촉수 피해 [Arg1]을 획득한다."
  },
  Skill_129857_Name = {
    Text = "불멸의 위엄"
  },
  Skill_129858_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 자신의 최대 HP가 [Arg3]% 증가한다."
  },
  Skill_129858_Name = {
    Text = "등가 교환"
  },
  Skill_129869_Desc = {
    Text = "사용자 정의 실타래행 명령"
  },
  Skill_129869_Name = {
    Text = "패키징 테스트"
  },
  Skill_130234_Desc_1 = {
    Text = "다른 랜덤한 「열쇠 지령」 [Arg1]장을 확인하고, 1장을 선택하여 손에 넣는다."
  },
  Skill_130234_Name_1 = {
    Text = "불평등한 교환"
  },
  Skill_130234_UnknownName = {
    Text = "불평등한 교환"
  },
  Skill_130240_Desc = {
    Text = "깨어남체 1명을 선택하여 [Arg1]pt의 광기를 획득하고, 다른 깨어남체들은 [Arg2]pt의 광기를 획득한다. 「모스」가 팀에 있을 경우, 즉시 「소용돌이! 유동! 포!」를 발동하여 추격한다."
  },
  Skill_130240_Name = {
    Text = "익사한 순수"
  },
  Skill_130351_Desc = {
    Text = "드로우 단계 후 손에 있을 경우, 무작위 명령 카드 1장을 「강제 사용」하여 2회 발동한다.\n사용 후, 다음에 사용하는 명령 카드가 추가로 2회 발동한다. [Arg1]회 사용 후 소모된다([Arg2]/[Arg1])."
  },
  Skill_130351_Name = {
    Text = "마리오네트"
  },
  Skill_130385_Desc = {
    Text = "드로우 단계 후 손에 있을 경우, 손의 무작위 명령 카드 2장 중 1장을 선택하여 강제로 사용하고, 2회 발동한다.\n사용 후, 다음 명령 카드의 행동력 소모가 2pt 감소하며, 사용한 명령 카드는 추가로 2회 발동한다. [Arg1]회 사용 후 소모된다([Arg2]/[Arg1])."
  },
  Skill_130385_Name = {
    Text = "마리오네트"
  },
  Skill_130386_Desc = {
    Text = "드로우 단계 후 손에 있을 경우, 손의 무작위 명령 카드 2장 중 1장을 선택하여 강제로 사용하고, 2회 발동한다.\n사용 후, 다음에 사용하는 명령 카드가 추가로 2회 발동한다. [Arg1]회 사용 후 소모된다([Arg2]/[Arg1])."
  },
  Skill_130386_Name = {
    Text = "마리오네트"
  },
  Skill_130471_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2]회 입히며, 차원 균열 안에 카드 1장이 있을 때마다 피해가 [Arg3] 점 증가합니다. 막히지 않은 피해를 1회 입힐 때마다 <ResentChainsKeywords:원한의 사슬> 1층을 획득합니다."
  },
  Skill_130471_Name = {
    Text = "만사천심"
  },
  Skill_130472_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2]회 입히고 자신의 부정적 상태를 해제하며, 막히지 않은 피해를 1회 입힐 때마다 자신의 최대 생명력이 3% 증가합니다."
  },
  Skill_130472_Name = {
    Text = "「당사자는 모른다」"
  },
  Skill_130473_Desc = {
    Text = "다른 아군이 [Arg1] 점 <PowerIconKeywords:힘>을 획득하고, 자신은 [Arg2] 점 <PowerIconKeywords:힘>과 [Arg3]% 임시 <Baojidikang:치명타 저항>을 획득하며, <Chapter5_Monster_Agitation:심연옥의 문>이 부여된 종복 2명을 소환합니다."
  },
  Skill_130473_Name = {
    Text = "권속 부화"
  },
  Skill_130474_Desc = {
    Text = "해당 의도로 전환할 때, <BleedingIconKeywords:출혈>을 [Arg1]스택 부여한다. <WeaknessIconKeywords:허약> 및 <VulnerabilityIconKeywords:취약>을 [Arg2]스택 부여한다."
  },
  Skill_130474_Name = {
    Text = "운명의 붉은 실타래"
  },
  Skill_130475_Desc = {
    Text = "[Arg1] 점 <IntoxicationIconKeywords:중독>을 부여하고, 모든 깨어남체의 기본 광기 +[Arg2]."
  },
  Skill_130475_Name = {
    Text = "「풍우가 몰아치는 밤」"
  },
  Skill_130476_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득하며, 차원 균열을 제거한다."
  },
  Skill_130476_Name = {
    Text = "운명을 초월하는 비가"
  },
  Skill_130477_Desc = {
    Text = "해당 의도로 전환 시, 「속박의 서약」과 <Chapter5_Monster_Fervor4:광열>을 제거하고 다른 아군을 소멸시킵니다. 자신의 현재 및 최대 생명력이 250% 증가하고, 「구일의 잔불」 총량이 2배가 되며, 「융식 안개 방패」 50층을 획득하고 「차원 균열」을 개방합니다."
  },
  Skill_130477_Name = {
    Text = "암야를 얽어매는 물레"
  },
  Skill_130478_Desc = {
    Text = "현재 「운명의 파편」을 보유한 모든 지령 카드를 [Arg1] 턴 동안 「봉인」하고, 다른 지령 카드에 [Arg2] 층 <SlowIconKeywords:지연>을 부여합니다."
  },
  Skill_130478_Name = {
    Text = "「엎질러진 물」"
  },
  Skill_130479_Desc = {
    Text = "이 의도로 전환할 때, [Arg1] 층의<BleedingIconKeywords:출혈>을 발생시킵니다. [Arg2] 층의<WeaknessIconKeywords:허약>과<VulnerabilityIconKeywords:취약>을 적용합니다. 만약 차원 균열 안의 카드 수가 [Arg3]보다 많다면, 추가로 [Arg4] 층의<FragileIconKeywords:손상>,<BlindingKeywords:실타래명>,<Decay:부패>를 적용합니다."
  },
  Skill_130479_Name = {
    Text = "부패한 운명의 붉은 실타래"
  },
  Skill_130491_Desc = {
    Text = "플레이어는 [Power:Arg1] 점의 <PowerIconKeywords:힘>, <Block:[Block:Arg2]> 점의 방어막, [Heal:Arg3] 점의 치료, [TentaclePower:Arg4] 점의 <TentacleInjurieIconKeywords:촉수 피해>, [Counterattack:Arg5] 층의 <RetaliateIconKeywords:반격>을 얻고, 전방 적에게 <Damage:[Damage:Arg6]> 데미지를 [Arg7] 번 입히며, [Poison:Arg8] 층의 <IntoxicationIconKeywords:중독>을 부여하고, [Exhaustion:Arg9] 층의 <ExhaustionIconKeywords:쇠약>을 적용합니다."
  },
  Skill_130491_Name = {
    Text = "칠색 대포 α"
  },
  Skill_130493_Desc = {
    Text = "행동력 2pt를 획득하고, 카드 2장을 드로우한다."
  },
  Skill_130493_Name = {
    Text = "리아의 코인"
  },
  Skill_130506_Desc = {
    Text = "손에 있는 모든 명령 카드를 무작위로 덱에 섞어 넣는다. 섞어 넣은 명령 카드는 다음에 사용할 때 25% 확률로 1회 추가 발동하며, 명령 카드 1장을 섞어 넣을 때마다 모든 깨어남체가 광기 2pt를 획득한다."
  },
  Skill_130506_Name = {
    Text = "도박의 지혜"
  },
  Skill_130507_Desc = {
    Text = "손에 있는 모든 명령 카드를 무작위로 덱에 섞어 넣는다. 섞어 넣은 명령 카드는 다음에 사용할 때 13% 확률로 1회 추가 발동하며, 명령 카드 1장을 섞어 넣을 때마다 모든 깨어남체가 광기 2pt를 획득한다."
  },
  Skill_130507_Name = {
    Text = "도박의 지혜"
  },
  Skill_130508_Desc = {
    Text = "손에 있는 모든 명령 카드를 무작위로 덱에 섞어 넣는다. 섞어 넣은 명령 카드는 다음에 사용할 때 17% 확률로 1회 추가 발동하며, 명령 카드 1장을 섞어 넣을 때마다 모든 깨어남체가 광기 2pt를 획득한다."
  },
  Skill_130508_Name = {
    Text = "도박의 지혜"
  },
  Skill_130509_Desc = {
    Text = "손에 있는 모든 명령 카드를 무작위로 덱에 섞어 넣는다. 섞어 넣은 명령 카드는 다음에 사용할 때 21% 확률로 1회 추가 발동하며, 명령 카드 1장을 섞어 넣을 때마다 모든 깨어남체가 광기 2pt를 획득한다."
  },
  Skill_130509_Name = {
    Text = "도박의 지혜"
  },
  Skill_130513_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:장비 시와 턴 시작 시, 다음 효과 중 하나를 무작위로 발동한다: <Energy:[Energy:Arg1]> 광기를 획득하고 자신을 <PVPSlowKeywords:둔화>; <Energy:[Energy:Arg3]> 광기를 획득; <Energy:[Energy:Arg4]> 과 [Arg5]장의 <PVPDerivativeCardKeywords_17:「영감」>을 획득."
  },
  Skill_130513_Name_1 = {
    Text = "도박의 지혜"
  },
  Skill_130928_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 피해를 가합니다. 처치하지 못하면 [Arg2] 중첩 <PVPWaterPowerKeyWords:와류>를 획득합니다."
  },
  Skill_130928_Name_1 = {
    Text = "심연! 소용돌이! 대폭발"
  },
  Skill_130929_AwakerSkillBackgroundStory = {
    Text = "활기차게 무서운 대포를 휘두르며, 깡충깡충 전장에 들어간다.\n어떠한 걱정도, 위험도 신경 쓰지 않으며, 이 친구와 비교하면 이 모든 것이 너무 하찮다.\n“친구야, 귀찮게 말야! 모스, 등장!”"
  },
  Skill_130929_BattleDesc_0 = {
    Text = "모스가 광기 <Energy:[Energy:Arg1]>pt를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「장전!」 1장을 드로우한다. 모스가 추격을 발동한 후 다음 모스의 광기 폭발은 추가로 촉수 피해 보너스 [Arg2]% 획득하며, 이는 최대 [Arg3]회 중첩된다."
  },
  Skill_130929_BattleDesc_15 = {
    Text = "모스가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 「장전!」을 1장 뽑습니다. 모스가 추격을 발동한 후 다음 모스의 광기 폭발이 촉수 피해 계수 [Arg2]%를 추가로 받으며, 다음 광기 폭발이 HP가 가장 높은 적에게 최대 HP의 [Arg4]%에 해당하는 <FixedDamage:순수 피해>를 입히고, 최대 [Arg3]회 중첩됩니다."
  },
  Skill_130929_Desc_0 = {
    Text = "모스가 [Arg5]%의 기본 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 「장전!」 1장을 뽑습니다. 모스가 추격을 발동한 후 다음 모스의 광기 폭발 시 추가로 [Arg2]% 촉수 피해 보너스를 받으며, 최대 [Arg3]회 중첩됩니다."
  },
  Skill_130929_Desc_15 = {
    Text = "모스가 [Arg5]% 광기 최대치를 획득합니다. <ExaltIconKeywords:영지 각성>: 「장전!」을 1장 뽑습니다. 모스가 추격을 발동한 후 다음 모스의 광기 폭발이 촉수 피해 계수 [Arg2]%를 추가로 받으며, 다음 광기 폭발이 HP가 가장 높은 적에게 최대 HP의 [Arg4]%에 해당하는 <FixedDamage:순수 피해>를 입히고, 최대 [Arg3]회 중첩됩니다."
  },
  Skill_130929_EffectNameList = {
    Text = "광기, 촉수 피해 계수"
  },
  Skill_130929_Name = {
    Text = "소용돌이 등장!"
  },
  Skill_130929_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2%"
  },
  Skill_130930_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」로 자신이 <Block:[Block:Arg1]> 방어막과 <DelayKeywords:지연>: <Energy:[Energy:Arg2]> 광기를 획득합니다."
  },
  Skill_130930_Name_1 = {
    Text = "아득한 에덴동산"
  },
  Skill_130931_AwakerSkillBackgroundStory = {
    Text = "소용돌이가 파괴를 가져오고, 심연이 파멸을 가져온다.\n우정과 햇빛을 동경하는 소녀는 결국 영원한 고독으로 회귀했다.\n절규, 비명, 왜곡, 붕괴, 이는 그녀가 모스크스에 있을 때의 루프이다.\n이는 모스크스 아래에서 심연이 모든 것을 포식하는 포효이다.\n또한 모스가 그를 이긴 증거이기도 하다."
  },
  Skill_130931_BattleDesc_0 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 2배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%)."
  },
  Skill_130931_BattleDesc_1 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 2배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%). 영역 숙련 [Arg6]pt를 획득한다."
  },
  Skill_130931_BattleDesc_3 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 3배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%). 영역 숙련 [Arg6]pt를 획득하고, 20pt의 광기를 소모할 때마다 다른 깨어남체가 1pt의 광기를 획득한다."
  },
  Skill_130931_Desc_0 = {
    Text = "모든 손에 있는 카드의 <BurningKeywords2:번영> 상태를 해제합니다. 모든 적에게 [Arg7]%의 <TentacleInjurieIconKeywords:터치손상> 보너스 피해를 입히고, 생명이 가장 높은 적에게는 2배의 피해를 줍니다. 최대 3개의 추가 영구 터치 월을 희생하며, 각 터치 월마다 이번 광기 폭발의 크리티컬 피해가 +50% 증가합니다."
  },
  Skill_130931_Desc_1 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords2:연소> 상태를 해제한다. 전체 적에게 [Arg7]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된 피해를 주고, HP가 가장 높은 적에게는 2배의 피해를 준다. 최대 3개의 추가 영구 촉수를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다. 영역 숙련 [Arg6]pt를 획득한다."
  },
  Skill_130931_Desc_3 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords2:연소> 상태를 해제한다. 전체 적에게 [Arg7]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된 피해를 주고, HP가 가장 높은 적에게는 3배의 피해를 준다. 최대 3개의 추가 영구 촉수를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다. 영역 숙련 [Arg6]pt를 획득하고, 20pt의 광기를 소모할 때마다 다른 깨어남체가 1pt의 광기를 획득한다."
  },
  Skill_130931_EffectNameList = {
    Text = "촉수 피해 계수"
  },
  Skill_130931_Name = {
    Text = "심연! 소용돌이! 포!"
  },
  Skill_130931_OverLimitUtlSkillDesc = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 3배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 100% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%). 영역 숙련 [Arg6]pt를 획득한다. 이후 5회 동안 사용하는 「와! 류! 탄!」의 효과가 2회 적용된다."
  },
  Skill_130931_tempBattleDesc_1 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 2배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%)."
  },
  Skill_130931_tempBattleDesc_2 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 2배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%). 영역 숙련 [Arg6]pt를 획득한다."
  },
  Skill_130931_tempBattleDesc_3 = {
    Text = "손에 있는 모든 카드의 <BurningKeywords:연소> 상태를 해제한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, HP가 가장 높은 적에게는 3배의 피해를 입힌다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 희생한 촉수 1개당 이번 광기 폭발의 치명타 피해가 50% 증가한다(현재 치명타율: [Arg5]%. 촉수 피해 보너스: [Arg8]%). 영역 숙련 [Arg6]pt를 획득하고, 20pt의 광기를 소모할 때마다 다른 깨어남체가 1pt의 광기를 획득한다."
  },
  Skill_130931_tempBattleDesc_4 = {
    Text = "손에 든 모든 카드의 <BurningKeywords:연소> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]> 점 피해를 입히고, HP가 가장 높은 적에게 3배 피해와 최대 HP의 [Arg9]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 각 촉수마다 이번 광기 폭발의 치명타 피해 +50%(현재 치명타율: [Arg5]%. 촉수 피해 계수: [Arg8]%). [Arg6] 점 영역 숙련을 획득하며, 광기 20점을 소모할 때마다 다른 각성체가 광기 1점을 획득합니다."
  },
  Skill_130931_tempOverLimitUtlSkillDesc_1 = {
    Text = "손패의 모든 카드의 <BurningKeywords:연소> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]>점의 피해를 가하며, HP가 가장 높은 적에게 2배의 피해를 가합니다. 추가 영구 촉수를 최대 3개 희생하여([Arg4]개), 각 1개마다 이번 광기 폭발의 크리티컬 피해 +100%(현재 크리티컬 확률: [Arg5]%. 터치 월 데미지 보너스: [Arg8]%). 이후 발동되는 5회의 「소용돌이! 유동! 발사!」가 2회 발동합니다."
  },
  Skill_130931_tempOverLimitUtlSkillDesc_2 = {
    Text = "손패의 모든 카드의 <BurningKeywords:연소> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]>점의 피해를 가하며, HP가 가장 높은 적에게 2배의 피해를 가합니다. 추가 영구 촉수를 최대 3개 희생하여([Arg4]개), 각 1개마다 이번 광기 폭발의 크리티컬 피해 +100%(현재 크리티컬 확률: [Arg5]%. 터치 월 데미지 보너스: [Arg8]%). [Arg6]점의 영역 마스터리를 획득합니다. 이후 발동되는 5회의 「소용돌이! 유동! 발사!」가 2회 발동합니다."
  },
  Skill_130931_tempOverLimitUtlSkillDesc_3 = {
    Text = "손패의 모든 카드의 <BurningKeywords:연소> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]>점의 피해를 가하며, HP가 가장 높은 적에게 3배의 피해를 가합니다. 추가 영구 촉수를 최대 3개 희생하여([Arg4]개), 각 1개마다 이번 광기 폭발의 크리티컬 피해 +100%(현재 크리티컬 확률: [Arg5]%. 터치 월 데미지 보너스: [Arg8]%). [Arg6]점의 영역 마스터리를 획득하며, 광기 20점을 소모할 때마다 다른 깨어남체가 광기 1점을 획득합니다. 이후 발동되는 5회의 「소용돌이! 유동! 발사!」가 2회 발동합니다."
  },
  Skill_130931_tempOverLimitUtlSkillDesc_4 = {
    Text = "손에 든 모든 카드의 <BurningKeywords:연소> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]> 점 피해를 입히고, HP가 가장 높은 적에게 3배 피해와 최대 HP의 [Arg9]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다. 최대 3개의 추가 영구 촉수([Arg4]개)를 희생하며, 각 촉수마다 이번 광기 폭발의 치명타 피해 +100%(현재 치명타율: [Arg5]%. 촉수 피해 계수: [Arg8]%). [Arg6] 점 영역 숙련을 획득합니다. 이후 5회 발동되는 「소용돌이! 발사!」가 2회 발동됩니다."
  },
  Skill_130932_AwakerSkillBackgroundStory = {
    Text = "“끼익, 끼익……”\n흉악한 대포가 푸른 소용돌이를 계속 삼켜내며, 존재하지 않는 소리를 내고 있다.\n매번 하나를 삼킬 때마다 괴물의 동공 속 진홍이 더욱 짙어졌다.\n그것은 기다리고 있다, 기다리고 있다……\n자신의 천진난만한 주인이 명령을 내리는 순간을."
  },
  Skill_130932_BattleDesc = {
    Text = "<DerivativeCardKeywords_132:> <WhirlpoolKeywords:소용돌이 장전> 1스택을 획득하며, [Arg1]회 사용할 수 있다."
  },
  Skill_130932_Desc = {
    Text = "<DerivativeCardKeywords_132:> <WhirlpoolKeywords:소용돌이 장전> 1스택을 획득하며, 3회 사용할 수 있다."
  },
  Skill_130932_EffectNameList = {
    Text = "「소용돌이! 유동! 포탄!」 레벨"
  },
  Skill_130932_Name = {Text = "장전!"},
  Skill_130933_Desc = {
    Text = "모든 적이 <ReinforcePVEKeywords:견고> 25스택을 획득한다. 매 턴 뽑는 카드 수가 1 감소한다. 모든 깨어남체가 생성하는 실타래드와 HP 회복량이 20% 증가한다."
  },
  Skill_130933_Name = {
    Text = "털 쓰다듬기"
  },
  Skill_130934_Desc_0 = {
    Text = "HP가 가장 높은 적에게 [Arg1] 포인트의 <RealDamage:잠금 피해>를 입히고, <TentacleInjurieIconKeywords:촉수> +[TentaclePower:Arg2]."
  },
  Skill_130934_Desc_1 = {
    Text = "HP가 가장 높은 적에게 [Arg1] 점 <RealDamage:고정 피해>와 대상 최대 HP의 [Float:Arg3]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다. <TentacleInjurieIconKeywords:촉수 피해> +[TentaclePower:Arg2]."
  },
  Skill_130934_Name = {
    Text = "소용돌이! 발사!"
  },
  Skill_130935_AwakerSkillBackgroundStory = {
    Text = "“탁탁~ 나쁜 사람을 쓰러뜨려~”"
  },
  Skill_130935_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_130935_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>점의 피해를 가합니다. <Energy:[Energy:Arg2]>점의 광기를 획득합니다. 모스의 다음 광기 폭발 크리티컬 확률 +[Arg3]%, 다음 「장착」의 기본 행동력 소모가 1 감소합니다."
  },
  Skill_130935_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 모스가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_130935_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>점의 피해를 가합니다. 모스가 <Energy:[Energy:Arg2]>점의 광기를 획득합니다. 모스의 다음 광기 폭발 크리티컬 확률 +[Arg3]%, 다음 「장착」의 기본 행동력 소모가 1 감소합니다."
  },
  Skill_130935_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_130935_Name = {Text = "타격"},
  Skill_130935_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_130936_Desc_1 = {
    Text = "<DelayKeywords:지연>:<Energy:[Energy:Arg1]> 광기. 다음 턴 시작까지, 생명력을 잃으면 동일한 양의 지연 광기를 보호막으로 전환한다."
  },
  Skill_130936_Name_1 = {
    Text = "소용돌이 보호막"
  },
  Skill_130937_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_130937_Name_1 = {Text = "타격"},
  Skill_130938_AwakerSkillBackgroundStory = {
    Text = "“싸라싸라~ 친구를 지키자~”"
  },
  Skill_130938_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_130938_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>점의 방어막를 획득합니다. <Energy:[Energy:Arg2]>점의 광기를 획득합니다. 모스의 다음 광기 폭발 크리티컬 확률 +[Arg3]%, 다음 「장착」의 기본 행동력 소모가 1 감소합니다."
  },
  Skill_130938_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 모스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_130938_Desc_2 = {
    Text = "<Block:[Block:Arg1]>점의 방어막를 획득합니다. 모스가 <Energy:[Energy:Arg2]>점의 광기를 획득합니다. 모스의 다음 광기 폭발 크리티컬 확률 +[Arg3]%, 다음 「장착」의 기본 행동력 소모가 1 감소합니다."
  },
  Skill_130938_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_130938_Name = {Text = "방어"},
  Skill_130938_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_130939_Desc_1 = {
    Text = "전열 적에게 <Damage:[Damage:Arg1]> 피해를 가하고, <PVPDerivativeCardKeywords_27:「심연! 소용돌이! 이식!」>으로 업그레이드합니다. 처치하지 못하면 [Arg2] 중첩 <PVPWaterPowerKeyWords:와류>를 획득합니다.<PVPDerivativeCardKeywords_28:>"
  },
  Skill_130939_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, <PVPPenetrateKeywords:관통>, <PVPDerivativeCardKeywords_28:「심연! 소용돌이! 대폭격!」>으로 업그레이드합니다. 처치하지 못하면 [Arg2] 중첩 <PVPWaterPowerKeyWords:와류>를 획득합니다."
  },
  Skill_130939_Desc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 피해를 가합니다. 처치하지 못하면 [Arg2] 중첩 <PVPWaterPowerKeyWords:와류>를 획득합니다."
  },
  Skill_130939_Name_1 = {
    Text = "심연! 소용돌이! 포!"
  },
  Skill_130939_Name_2 = {
    Text = "심연! 소용돌이! Mk. II!"
  },
  Skill_130939_Name_3 = {
    Text = "심연! 소용돌이! 대폭발"
  },
  Skill_130940_Desc = {
    Text = "모든 적의 <ReinforcePVEKeywords:견고>를 제거한다. 잃은 HP의 50%를 회복하고, 모든 깨어남체의 광기를 최대치로 채운다. 이번 턴에 모든 깨어남체는 광기 폭발을 2회 발동할 수 있다."
  },
  Skill_130940_Name = {
    Text = "이세 충격!"
  },
  Skill_130941_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 첫 번째로 「스킬」 사용 후 <HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 <Damage:[Damage:Arg1]> 피해를 줍니다."
  },
  Skill_130941_Name_1 = {
    Text = "갇힌 광기"
  },
  Skill_130942_AwakerSkillBackgroundStory = {
    Text = "실타래험에서 모스가 힘을 저축하는 방법을 배운 이후, 그녀가 초래하는 파괴력은 배가 되기 시작했습니다.\n따라서 모스 주변에 비정상적인 습기가 나타나기 시작하면, 즉시 적과 거리를 두어야 합니다.\n모스의 말로는“먼저 준비하고, 그 다음 발사! 그러면 위력이 커!”."
  },
  Skill_130942_Desc = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득하고, 다음 모스의 광기 폭발 치명타율이 [Arg2]% 증가한다. <RippleKeywords:여파>: 다른 깨어남체가 <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_130942_EffectNameList = {
    Text = "광기, 치명타율"
  },
  Skill_130942_Name = {Text = "차지!"},
  Skill_130942_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2%"
  },
  Skill_130943_Desc = {
    Text = "모든 적이 <ReinforcePVEKeywords:견고> 25스택을 획득한다. 열쇠 에너지 상한 및 열쇠 지령 소모 열쇠 에너지가 350 증가한다. 매 턴 처음 사용하는 열쇠 지령이 2회 발동한다."
  },
  Skill_130943_Name = {
    Text = "간식 먹이기"
  },
  Skill_130944_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 주며, <Energy:[Energy:Arg2]> 광기를 획득합니다."
  },
  Skill_130944_Name_1 = {Text = "파동탄"},
  Skill_130945_Desc = {
    Text = "모든 적이 <ReinforcePVEKeywords:견고> 25스택을 획득한다. 모든 깨어남체의 기본 광기가 10pt 증가한다. 광기 폭발 발동 후 행동력 1pt를 획득하며, 각 깨어남체는 1턴에 1회만 발동할 수 있다."
  },
  Skill_130945_Name = {
    Text = "볼 비비기"
  },
  Skill_130946_Desc_1 = {
    Text = "아군 전체 +[Arg1] <PVPWaterPowerKeyWords:와류>, 전사한 아군 1명당 추가로 +[Arg2] <PVPWaterPowerKeyWords:와류>."
  },
  Skill_130946_Name_1 = {
    Text = "익사한 순수"
  },
  Skill_130946_UnknownName = {
    Text = "익사한 순수"
  },
  Skill_130947_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, <PVPPenetrateKeywords:관통>, <PVPDerivativeCardKeywords_28:「심연! 소용돌이! 대폭격!」>으로 업그레이드합니다. 처치하지 못하면 [Arg2] 중첩 <PVPWaterPowerKeyWords:와류>를 획득합니다."
  },
  Skill_130947_Name_1 = {
    Text = "심연! 소용돌이! Mk. II!"
  },
  Skill_130948_Desc_1 = {
    Text = "[Arg1]스택 <PVPWaterPowerKeyWords:와류>를 획득하고, <PVPDerivativeCardKeywords_26:「파동탄」> [Arg2]장을 손에 넣는다."
  },
  Skill_130948_Name_1 = {
    Text = "와류 파동"
  },
  Skill_131102_Desc = {
    Text = "손의 무작위 명령 카드 2장에 「<Chapter5_Monster_Support1:번식의 이치>」 각인을 부여한다."
  },
  Skill_131102_Name = {
    Text = "번식의 이치"
  },
  Skill_131114_Desc = {
    Text = "손의 무작위 명령 카드 2장에 「<Chapter5_Monster_Support2:지혜의 이치>」 각인을 부여한다."
  },
  Skill_131114_Name = {
    Text = "지혜의 이치"
  },
  Skill_131115_Desc = {
    Text = "손의 무작위 명령 카드 2장에 「<Chapter5_Monster_Support3:환희의 이치>」 각인을 부여한다."
  },
  Skill_131115_Name = {
    Text = "환희의 이치"
  },
  Skill_131192_Desc = {
    Text = "손에 든 <ErosionColorInkKeywords:인지 혼란>이 부여된 모든 카드의 행동력 소모를 -1하고, 카드 1장마다 광기가 가장 낮은 깨어남체가 <Energy:5> 점의 광기를 획득합니다. 이후 각 위치의 <ErosionColorInkKeywords:인지 혼란>이 부여된 카드를 원래대로 되돌립니다. 이번 턴에 카드를 낸 후 다른 카드에 <ErosionColorInkKeywords:인지 혼란>을 더 이상 부여하지 않습니다."
  },
  Skill_131192_Name = {
    Text = "금지된 진실타래"
  },
  Skill_131241_Desc = {
    Text = "플레이어는 [Power:Arg1] 점의 <PowerIconKeywords:힘>, <Block:[Block:Arg2]> 점의 방어막, [Heal:Arg3] 점의 치료, [TentaclePower:Arg4] 점의 <TentacleInjurieIconKeywords:촉수 피해>, [Counterattack:Arg5] 층의 <RetaliateIconKeywords:반격>을 얻고, 전방 적에게 <Damage:[Damage:Arg6]> 데미지를 [Arg7] 번 입히며, [Poison:Arg8] 층의 <IntoxicationIconKeywords:중독>을 부여하고, [Exhaustion:Arg9] 층의 <ExhaustionIconKeywords:쇠약>을 적용합니다."
  },
  Skill_131241_Name = {
    Text = "칠색 대포 β"
  },
  Skill_131365_Desc = {
    Text = "적에게 최대 HP 비례 피해를 주고, 초차원 공간을 파괴한다."
  },
  Skill_131365_Name = {
    Text = "운명의 실타래 제자리를 찾다"
  },
  Skill_131438_Desc = {
    Text = "드로우 단계 후 손에 있을 경우, 손의 무작위 명령 카드 2장 중 1장을 선택하여 강제로 사용하고, 2회 발동한다.\n사용 후, 다음 명령 카드의 행동력 소모가 0이 되며, 사용한 명령 카드는 추가로 2회 발동한다. [Arg1]회 사용 후 소모된다([Arg2]/[Arg1])."
  },
  Skill_131438_Name = {
    Text = "마리오네트"
  },
  Skill_131654_Desc = {
    Text = "사용 후, 지정된 깨어남체의 광기 값을 제거한 후, 기본 광기 값의 1배에 해당하는 광기를 획득한다."
  },
  Skill_131654_Name = {
    Text = "광기 중첩 1배"
  },
  Skill_131786_Desc = {
    Text = "사용 후, 무작위 대상에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 다른 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다."
  },
  Skill_131786_Name = {
    Text = "목표 테스트"
  },
  Skill_131856_AwakerSkillBackgroundStory = {
    Text = "귀, 눈, 뇌, 피부, 혀, 그리고 온몸에 퍼진 감각.\n함께 나눈 사랑과 온기는 영원히 당신을 감싸며, 죽을 때까지 이어질 것이다——"
  },
  Skill_131856_BattleDesc_0 = {
    Text = "사야가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>:「핏빛 용광로」 사용 후 다른 깨어남체의 「<DestructionKeywords:파괴>」가 없는 명령 카드에 각각 <ErosionColorInkKeywords:인지 혼란>을 부여한다. 매 턴 처음 3회 <ErosionColorInkKeywords:인지 혼란>이 부여된 명령 카드 사용 시 사야와 해당 명령 카드 소속 깨어남체가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131856_BattleDesc_15 = {
    Text = "사야가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>:「핏빛 용광로」 사용 후 사야가 광기<Energy:[Energy:Arg4]>pt와 「<KaiHuajishu:우종>」 1스택을 획득한다. 다른 깨어남체의 「<DestructionKeywords:파괴>」가 없는 명령 카드에 각각 <ErosionColorInkKeywords:인지 혼란>을 부여한다. 매 턴 처음 3회 <ErosionColorInkKeywords:인지 혼란>이 부여된 명령 카드 사용 시 사야와 해당 명령 카드 소속 깨어남체가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131856_Desc_0 = {
    Text = "사야가 광기 최대치를 [Arg3]% 획득한다. <ExaltIconKeywords:영지 깨어남>:「핏빛 용광로」 사용 후 다른 깨어남체의 「<DestructionKeywords:파괴>」가 없는 명령 카드에 각각 <ErosionColorInkKeywords:인지 혼란>을 부여한다. 매 턴 처음 3회 <ErosionColorInkKeywords:인지 혼란>이 부여된 명령 카드 사용 시 사야와 해당 명령 카드 소속 깨어남체가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131856_Desc_15 = {
    Text = "사야가 광기 최대치를 [Arg3]% 획득한다. <ExaltIconKeywords:영지 깨어남>:「핏빛 용광로」 사용 후 사야가 광기<Energy:[Energy:Arg4]>pt와 「<KaiHuajishu:우종>」 1스택을 획득한다. 다른 깨어남체의 「<DestructionKeywords:파괴>」가 없는 명령 카드에 각각 <ErosionColorInkKeywords:인지 혼란>을 부여한다. 매 턴 처음 3회 <ErosionColorInkKeywords:인지 혼란>이 부여된 명령 카드 사용 시 사야와 해당 명령 카드 소속 깨어남체가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131856_EffectNameList = {
    Text = "광기,추가 광기"
  },
  Skill_131856_Name = {
    Text = "인지 개조"
  },
  Skill_131857_AwakerSkillBackgroundStory = {
    Text = "계속 바래왔던 세계—— 더이상 숨을 필요가 없는 세계에 도달하기 전,\n길을 막고 있는 모든 것은 무찔러야 할 「적」이다."
  },
  Skill_131857_BattleDesc_0 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131857_BattleDesc_2 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg3]."
  },
  Skill_131857_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 사야가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_131857_Desc_2 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 사야가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg4], 현재 HP가 낮을수록 효과가 높아지며 이는 최대 100% 증가한다."
  },
  Skill_131857_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_131857_Name = {Text = "타격"},
  Skill_131857_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_131858_AwakerSkillBackgroundStory = {
    Text = "공포스럽고, 아름답고, 절망적인, 「사랑」의 침식 속에서 그 빛나는 생명은 fǝrǝmtǝlan을 노래합니다.\n이것은 새로운 세계의 막을 열고, 낡은 세계의 멸망을 알리는 노래입니다."
  },
  Skill_131858_BattleDesc = {
    Text = "[<DevouredIconKeywords:포식>: 랜덤 복제된 「기본 타격」 또는 「기본 방어」 2장의 행동력 소모가 0이 되고 1회 추가로 발동한다.] 방어막을 <Block:[Block:Arg1]>pt 획득한다. 다른 깨어남체 1명을 선택해, 덱과 버린 카드 더미에 해당 깨어남체의 명령 카드 1세트의 원본 복제를 각각 추가하고, <NothingnessIconKeywords:허무>와 <DestructionKeywords:파괴>를 부여한다. 모든 <KaiHuajishu:우종>을 소모하며, 1스택 소모할 때마다 그중 랜덤 「스킬」 1장의 행동력 소모를 0으로 만든다."
  },
  Skill_131858_Desc = {
    Text = "[<DevouredIconKeywords:포식>: 랜덤 복제된 「기본 타격」 또는 「기본 방어」 2장의 행동력 소모가 0이 되고 1회 추가로 발동한다.] 방어막을 <Block:[Block:Arg1]>pt 획득한다. 다른 깨어남체 1명을 선택해, 덱과 버린 카드 더미에 해당 깨어남체의 명령 카드 1세트의 원본 복제를 각각 추가하고, <NothingnessIconKeywords:허무>와 <DestructionKeywords:파괴>를 부여한다. 모든 <KaiHuajishu:우종>을 소모하며, 1스택 소모할 때마다 그중 랜덤 「스킬」 1장의 행동력 소모를 0으로 만든다."
  },
  Skill_131858_EffectNameList = {Text = "방어막"},
  Skill_131858_Name = {
    Text = "사야의 노래"
  },
  Skill_131858_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:포식>: 랜덤 복제된 「기본 타격」 또는 「기본 방어」 2장의 행동력 소모가 0이 되고 1회 추가로 발동한다.] 방어막을 <Block:[Block:Arg1]>pt 획득한다.다른 깨어남체 1명을 선택하여, 덱과 버린 카드 더미에 해당 깨어남체의 명령 카드 1세트의 원본 복제를 추가하고, <NothingnessIconKeywords:허무>와 <DestructionKeywords:파괴>를 부여하며 복제된 모든 「스킬」이 추가로 1번 발동한다. 모든 <KaiHuajishu:우종>을 소모하며, 1스택 소모할 때마다 그중 랜덤 「스킬」 1장의 행동력 소모를 0으로 만든다."
  },
  Skill_131858_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_131860_AwakerSkillBackgroundStory = {
    Text = "이 깨어남체는 망상 근육 조직을 포함한 원래 종족의 일부 특징을 보존하고 있습니다.\n공격을 받는 순간, 근육 조직이 전방위로 수축하여 물리적 수단으로는 실타래질적인 피해를 입히기 어렵습니다."
  },
  Skill_131860_BattleDesc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131860_BattleDesc_2 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg3]."
  },
  Skill_131860_Desc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 사야가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_131860_Desc_2 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 사야가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg4], 현재 HP가 낮을수록 효과가 높아지며 이는 최대 100% 증가한다."
  },
  Skill_131860_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_131860_Name = {Text = "방어"},
  Skill_131860_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_131902_Desc = {
    Text = "사용 후, 모스의 광기 상한을 출력한다."
  },
  Skill_131902_Name = {
    Text = "기능 속성"
  },
  Skill_132227_Desc = {
    Text = "파티에 신국 심해 깨어남체가 있을 경우 힘 1000pt를 획득하고, 없을 경우 쇠약 1000pt를 획득한다."
  },
  Skill_132227_Name = {
    Text = "스킬@테스트@신규 심해 직업 판정 테스트"
  },
  Skill_132357_AwakerSkillBackgroundStory = {
    Text = "봐봐! 오레타가 물고기처럼 거품을 내고 있어!"
  },
  Skill_132357_Desc = {
    Text = "<Block:[Block:Arg1]> 방어막를 획득하고, 자신, 플레이어, 앞줄 적에게 각각 상태를 부여합니다. 사용 값, 실타래제 값을 각 1회씩 적용합니다."
  },
  Skill_132357_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_132357_Name = {
    Text = "테스트·방어"
  },
  Skill_132357_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_132358_AwakerSkillBackgroundStory = {
    Text = "소녀는 아쉬움을 뒤로한 채 파산한 수족관을 떠났다. 그동안 일한 대가로, 그녀는 해파리 몇 마리를 집으로 데려가는 것을 허락받았다. 이들은 그녀가 가장 아끼는 작은 생명체이자 환상의 바다를 부유하는 정령이며, 끊임없이 피어나는 생명의 꽃이었다. 정성껏 돌보기만 한다면, 이 아이들이 수조를 가득 채우게 될 거야! ——한때 그녀는 그런 광경을 기대했었다."
  },
  Skill_132358_Desc_0 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다."
  },
  Skill_132358_Desc_15 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다. 오레타의 「타격」이 관통 피해로 변경되며, 추가로 2회 피해를 준다."
  },
  Skill_132358_EffectNameList = {Text = "광기"},
  Skill_132358_Name = {
    Text = "테스트·깨어남"
  },
  Skill_132359_AwakerSkillBackgroundStory = {
    Text = "빛의 일곱 빛깔, 찬란하고 황홀하게～"
  },
  Skill_132359_Desc = {
    Text = "플레이어가 [Power:Arg1] 포인트의 <PowerIconKeywords:힘>, <Block:[Block:Arg2]> 포인트의 보호막, [Heal:Arg3] 포인트의 치유, [TentaclePower:Arg4] 포인트의 <TentacleInjurieIconKeywords:촉수 피해>, [Counterattack:Arg5] 층의 <RetaliateIconKeywords:반격>을 획득하고, 전열 적에게 <Damage:[Damage:Arg6]> 포인트의 피해를 [Arg7] 회 가하며, [Poison:Arg8] 층의 <IntoxicationIconKeywords:중독>, [Exhaustion:Arg9] 층의 <ExhaustionIconKeywords:쇠약>, [FateCut:Arg10] 층의 <CutKeywords:운명 심판>을 부여한다."
  },
  Skill_132359_Name = {
    Text = "화려한 궁극기"
  },
  Skill_132359_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 준다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하며, 이후 5회 「선체 분열」을 사용할 때마다 카드 1장을 드로우한다."
  },
  Skill_132360_AwakerSkillBackgroundStory = {
    Text = "빛의 일곱 빛깔, 찬란하고 황홀하게～"
  },
  Skill_132360_Desc = {
    Text = "전열 적에게 [Arg1] 점 일반 고정 피해를 [Arg2]회 줍니다."
  },
  Skill_132360_Name = {
    Text = "테스트·굴절"
  },
  Skill_132361_AwakerSkillBackgroundStory = {
    Text = "헤헤! 놀랐지?"
  },
  Skill_132361_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132361_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 오레타가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132361_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_132361_Name = {
    Text = "테스트·타격"
  },
  Skill_132361_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132361_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132361_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 3회 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_132362_AwakerSkillBackgroundStory = {
    Text = "빛의 일곱 빛깔, 찬란하고 황홀하게～"
  },
  Skill_132362_Desc = {
    Text = "전열 적에게 [Arg1] 점 관통 고정 피해를 [Arg2]회 줍니다."
  },
  Skill_132362_Name = {
    Text = "테스트·반사"
  },
  Skill_132363_Desc_1 = {
    Text = "현재 행동 카드 대상 테스트"
  },
  Skill_132363_Name_1 = {
    Text = "현재 행동 카드 대상 테스트"
  },
  Skill_132425_AwakerSkillBackgroundStory = {
    Text = "소녀는 아쉬움을 뒤로한 채 파산한 수족관을 떠났다. 그동안 일한 대가로, 그녀는 해파리 몇 마리를 집으로 데려가는 것을 허락받았다. 이들은 그녀가 가장 아끼는 작은 생명체이자 환상의 바다를 부유하는 정령이며, 끊임없이 피어나는 생명의 꽃이었다. 정성껏 돌보기만 한다면, 이 아이들이 수조를 가득 채우게 될 거야! ——한때 그녀는 그런 광경을 기대했었다."
  },
  Skill_132425_Desc_0 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다."
  },
  Skill_132425_Desc_15 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다. 오레타의 「타격」이 관통 피해로 변경되며, 추가로 2회 피해를 준다."
  },
  Skill_132425_EffectNameList = {Text = "광기"},
  Skill_132425_Name = {
    Text = "테스트·깨어남"
  },
  Skill_132426_AwakerSkillBackgroundStory = {
    Text = "\"헤헤! 놀랐지?\""
  },
  Skill_132426_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132426_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 오레타가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132426_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_132426_Name = {
    Text = "테스트·타격"
  },
  Skill_132426_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132426_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132426_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 3회 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_132427_AwakerSkillBackgroundStory = {
    Text = "빛의 일곱 빛깔, 찬란하고 황홀하게～"
  },
  Skill_132427_Desc = {
    Text = "플레이어가 [Power:Arg1] 포인트의 <PowerIconKeywords:힘>, <Block:[Block:Arg2]> 포인트의 보호막, [Heal:Arg3] 포인트의 치유, [TentaclePower:Arg4] 포인트의 <TentacleInjurieIconKeywords:촉수 피해>, [Counterattack:Arg5] 층의 <RetaliateIconKeywords:반격>을 획득하고, 전열 적에게 <Damage:[Damage:Arg6]> 포인트의 피해를 [Arg7] 회 가하며, [Poison:Arg8] 층의 <IntoxicationIconKeywords:중독>, [Exhaustion:Arg9] 층의 <ExhaustionIconKeywords:쇠약>, [FateCut:Arg10] 층의 <CutKeywords:운명 심판>을 부여한다."
  },
  Skill_132427_Name = {
    Text = "테스트·굴절"
  },
  Skill_132428_AwakerSkillBackgroundStory = {
    Text = "소녀는 아쉬움을 뒤로한 채 파산한 수족관을 떠났다. 그동안 일한 대가로, 그녀는 해파리 몇 마리를 집으로 데려가는 것을 허락받았다. 이들은 그녀가 가장 아끼는 작은 생명체이자 환상의 바다를 부유하는 정령이며, 끊임없이 피어나는 생명의 꽃이었다. 정성껏 돌보기만 한다면, 이 아이들이 수조를 가득 채우게 될 거야! ——한때 그녀는 그런 광경을 기대했었다."
  },
  Skill_132428_Desc_0 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다."
  },
  Skill_132428_Desc_15 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다. 오레타의 「타격」이 관통 피해로 변경되며, 추가로 2회 피해를 준다."
  },
  Skill_132428_EffectNameList = {Text = "광기"},
  Skill_132428_Name = {
    Text = "테스트·깨어남"
  },
  Skill_132429_AwakerSkillBackgroundStory = {
    Text = "바다는 깊고 고요하며, 생에 대한 갈망과 죽음에 대한 공포를 품고 있습니다.\n 그러나 누군가는 웃음과 장난으로 바다를 가득 채우고 싶어합니다. 오레타가 그런 초대를 할 때, “그녀와 함께 한바탕 떠들어도 괜찮지 않을까”라는 기분이 항상 마음속에 밀려오고, 자연스럽게 사소한 기쁨이 가슴을 가득 채우게 됩니다."
  },
  Skill_132429_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 입힌다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다."
  },
  Skill_132429_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 준다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다."
  },
  Skill_132429_EffectNameList = {
    Text = "피해, 후속 피해 증가"
  },
  Skill_132429_Name = {
    Text = "테스트·폭주"
  },
  Skill_132429_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 준다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하며, 이후 5회 「선체 분열」을 사용할 때마다 카드 1장을 드로우한다."
  },
  Skill_132429_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_132430_AwakerSkillBackgroundStory = {
    Text = "바다는 깊고 고요하며, 생에 대한 갈망과 죽음에 대한 공포를 품고 있습니다.\n 그러나 누군가는 웃음과 장난으로 바다를 가득 채우고 싶어합니다. 오레타가 그런 초대를 할 때, “그녀와 함께 한바탕 떠들어도 괜찮지 않을까”라는 기분이 항상 마음속에 밀려오고, 자연스럽게 사소한 기쁨이 가슴을 가득 채우게 됩니다."
  },
  Skill_132430_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 입힌다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다."
  },
  Skill_132430_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 준다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다."
  },
  Skill_132430_EffectNameList = {
    Text = "피해, 후속 피해 증가"
  },
  Skill_132430_Name = {
    Text = "테스트·폭주"
  },
  Skill_132430_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 준다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하며, 이후 5회 「선체 분열」을 사용할 때마다 카드 1장을 드로우한다."
  },
  Skill_132430_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_132431_AwakerSkillBackgroundStory = {
    Text = "\"봐봐! 오레타가 물고기처럼 거품을 내고 있어!\""
  },
  Skill_132431_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132431_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132431_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132431_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132431_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_132431_Name = {
    Text = "테스트·방어"
  },
  Skill_132431_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_132432_AwakerSkillBackgroundStory = {
    Text = "아이들은 천천히 동화의 본질을 꿰뚫어 보고, 신화 뒤에 숨겨진 우화를 이해하게 됩니다. 인간의 언어로 이 과정을 '성장'이라고 부릅니다.\n 하지만 어떤 아이들은 잠자리에서 듣던 그 이야기를 더욱 믿게 되고, 고집스럽게 하늘에 정말로 무지개 다리가 있고, 정말로 문명이 심해에 잠겼다고 생각합니다.\n 오레타는 이러한 이야기를 좋아하며, 더 많은 친구들과 이 기쁨을 나누고 싶어합니다."
  },
  Skill_132432_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 모든 손패를 버리고, 버린 장수만큼 카드를 드로우한다. 「선체 분열」 1장을 버린 카드 더미에 넣는다."
  },
  Skill_132432_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 모든 손패를 버리고, 버린 장수 + 1장의 카드를 드로우한다. 「선체 분열」 1장을 버린 카드 더미에 넣는다."
  },
  Skill_132432_EffectNameList = {
    Text = "촉수 피해, 「선체 분열」 레벨"
  },
  Skill_132432_Name = {
    Text = "테스트·2스킬"
  },
  Skill_132432_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132433_AwakerSkillBackgroundStory = {
    Text = "세상에는 특별한 해파리가 존재합니다. 다치면 떨어진 조직이 다시 완전한 형체로 발달하기도 합니다.\n“오레타도 해파리를 만들 수 있어요! 그래서 오레타도 해파리예요!”\n아이들이 세상을 인식하는 이 단계에서는 그녀의 흥미를 꺾지 않는 것이 좋겠어요."
  },
  Skill_132433_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 「선체 분열」 [Arg2]장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_132433_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 「선체 분열」 [Arg2]장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_132433_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_132433_Name = {
    Text = "테스트·1스킬"
  },
  Skill_132433_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132434_AwakerSkillBackgroundStory = {
    Text = "아이들은 천천히 동화의 본질을 꿰뚫어 보고, 신화 뒤에 숨겨진 우화를 이해하게 됩니다. 인간의 언어로 이 과정을 '성장'이라고 부릅니다.\n 하지만 어떤 아이들은 잠자리에서 듣던 그 이야기를 더욱 믿게 되고, 고집스럽게 하늘에 정말로 무지개 다리가 있고, 정말로 문명이 심해에 잠겼다고 생각합니다.\n 오레타는 이러한 이야기를 좋아하며, 더 많은 친구들과 이 기쁨을 나누고 싶어합니다."
  },
  Skill_132434_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 모든 손패를 버리고, 버린 장수만큼 카드를 드로우한다. 「선체 분열」 1장을 버린 카드 더미에 넣는다."
  },
  Skill_132434_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 모든 손패를 버리고, 버린 장수 + 1장의 카드를 드로우한다. 「선체 분열」 1장을 버린 카드 더미에 넣는다."
  },
  Skill_132434_EffectNameList = {
    Text = "촉수 피해, 「선체 분열」 레벨"
  },
  Skill_132434_Name = {
    Text = "테스트·2스킬"
  },
  Skill_132434_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132435_AwakerSkillBackgroundStory = {
    Text = "소녀는 아쉬움을 뒤로한 채 파산한 수족관을 떠났다. 그동안 일한 대가로, 그녀는 해파리 몇 마리를 집으로 데려가는 것을 허락받았다. 이들은 그녀가 가장 아끼는 작은 생명체이자 환상의 바다를 부유하는 정령이며, 끊임없이 피어나는 생명의 꽃이었다. 정성껏 돌보기만 한다면, 이 아이들이 수조를 가득 채우게 될 거야! ——한때 그녀는 그런 광경을 기대했었다."
  },
  Skill_132435_Desc_0 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다."
  },
  Skill_132435_Desc_15 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다. 오레타의 「타격」이 관통 피해로 변경되며, 추가로 2회 피해를 준다."
  },
  Skill_132435_EffectNameList = {Text = "광기"},
  Skill_132435_Name = {
    Text = "테스트·깨어남"
  },
  Skill_132436_AwakerSkillBackgroundStory = {
    Text = "봐봐! 오레타가 물고기처럼 거품을 내고 있어!"
  },
  Skill_132436_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132436_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132436_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132436_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132436_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_132436_Name = {
    Text = "테스트·방어"
  },
  Skill_132436_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_132437_AwakerSkillBackgroundStory = {
    Text = "\"봐봐! 오레타가 물고기처럼 거품을 내고 있어!\""
  },
  Skill_132437_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132437_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132437_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132437_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_132437_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_132437_Name = {
    Text = "테스트·방어"
  },
  Skill_132437_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_132438_AwakerSkillBackgroundStory = {
    Text = "빛의 일곱 빛깔, 찬란하고 황홀하게～"
  },
  Skill_132438_Desc = {
    Text = "플레이어가 [Power:Arg1] 포인트의 <PowerIconKeywords:힘>, <Block:[Block:Arg2]> 포인트의 보호막, [Heal:Arg3] 포인트의 치유, [TentaclePower:Arg4] 포인트의 <TentacleInjurieIconKeywords:촉수 피해>, [Counterattack:Arg5] 층의 <RetaliateIconKeywords:반격>을 획득하고, 전열 적에게 <Damage:[Damage:Arg6]> 포인트의 피해를 [Arg7] 회 가하며, [Poison:Arg8] 층의 <IntoxicationIconKeywords:중독>, [Exhaustion:Arg9] 층의 <ExhaustionIconKeywords:쇠약>, [FateCut:Arg10] 층의 <CutKeywords:운명 심판>을 부여한다."
  },
  Skill_132438_Name = {
    Text = "화려한 필살기"
  },
  Skill_132438_OverLimitUtlSkillDesc = {
    Text = "플레이어는 [Power:Arg1] 점의 <PowerIconKeywords:힘>, <Block:[Block:Arg2]> 점의 방어막, [Heal:Arg3] 점의 치료, [TentaclePower:Arg4] 점의 <TentacleInjurieIconKeywords:촉수 피해>, [Counterattack:Arg5] 층의 <RetaliateIconKeywords:반격>을 얻고, 전방 적에게 <Damage:[Damage:Arg6]> 데미지를 [Arg7] 번 입히며, [Poison:Arg8] 층의 <IntoxicationIconKeywords:중독>을 부여하고, [Exhaustion:Arg9] 층의 <ExhaustionIconKeywords:쇠약>을 적용합니다."
  },
  Skill_132439_AwakerSkillBackgroundStory = {
    Text = "빛의 일곱 빛깔, 찬란하고 황홀하게～"
  },
  Skill_132439_Desc = {
    Text = "전열 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 동일한 양의 <IntoxicationIconKeywords:중독>, 동일한 양의 <CutKeywords:운명 재단>을 부여하며, 동일한 양의 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_132439_Name = {
    Text = "테스트·반사"
  },
  Skill_132440_AwakerSkillBackgroundStory = {
    Text = "세상에는 특별한 해파리가 존재합니다. 다치면 떨어진 조직이 다시 완전한 형체로 발달하기도 합니다.\n“오레타도 해파리를 만들 수 있어요! 그래서 오레타도 해파리예요!”\n아이들이 세상을 인식하는 이 단계에서는 그녀의 흥미를 꺾지 않는 것이 좋겠어요."
  },
  Skill_132440_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 「선체 분열」 [Arg2]장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_132440_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 「선체 분열」 [Arg2]장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_132440_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_132440_Name = {
    Text = "테스트·1스킬"
  },
  Skill_132440_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132441_AwakerSkillBackgroundStory = {
    Text = "헤헤! 놀랐지?"
  },
  Skill_132441_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132441_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 오레타가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132441_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_132441_Name = {
    Text = "테스트·타격"
  },
  Skill_132441_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132441_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132441_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 3회 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_132442_AwakerSkillBackgroundStory = {
    Text = "\"헤헤! 놀랐지?\""
  },
  Skill_132442_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132442_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 오레타가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132442_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_132442_Name = {
    Text = "테스트·타격"
  },
  Skill_132442_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_132442_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_132442_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 3회 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_132494_Desc = {
    Text = "모든 손패를 버리고, 집합 테스트 카드를 [Arg1]장 생성하여 앞 [Arg2]장과 뒤 [Arg3]장의 차집합을 구한 후, 해당 카드에 소모를 부여한다."
  },
  Skill_132494_Name = {Text = "차집합"},
  Skill_132495_Desc = {
    Text = "모든 손패를 버리고, 집합 테스트 카드를 [Arg1]장 생성하여 앞 [Arg2]장과 뒤 [Arg3]장의 대칭차를 구한 후, 해당 카드에 소모를 부여한다."
  },
  Skill_132495_Name = {Text = "대칭차"},
  Skill_132496_Name = {
    Text = "집합 테스트"
  },
  Skill_132497_Desc = {
    Text = "모든 손패를 버리고, 집합 테스트 카드를 [Arg1]장 생성하여 앞 [Arg2]장과 뒤 [Arg3]장의 합집합을 구한 후, 해당 카드에 소모를 부여한다."
  },
  Skill_132497_Name = {Text = "합집합"},
  Skill_132498_Desc = {
    Text = "모든 손패를 버리고, 집합 테스트 카드를 [Arg1]장 생성하여 앞 [Arg2]장과 뒤 [Arg3]장의 교집합을 구한 후, 해당 카드에 소모를 부여한다."
  },
  Skill_132498_Name = {Text = "교집합"},
  Skill_132884_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [Arg1] <StrongEffectKeywords:강효>를 획득하며, 다른 아군이 광기 폭발 후 <PVPOneMeetingKeywords:일기일회>를 획득합니다."
  },
  Skill_132884_Name_1 = {
    Text = "사쿠라의 망상"
  },
  Skill_133319_Desc_1 = {
    Text = "아군 1명의 다음 스킬 연산력 소모를 -[Arg1]하고, <Damage:[Arg2]> 생명력을 잃습니다."
  },
  Skill_133319_Name_1 = {Text = "개서"},
  Skill_133322_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_133322_Name_1 = {Text = "타격"},
  Skill_133323_BattleDesc_1 = {
    Text = "전열의 적에게 <Damage:[Damage:Arg4]> 피해를 가하며, 생명력을 [Arg2] 잃을 때마다 피해 +[Arg3], 자신의 생명력을 동일한 양만큼 회복합니다."
  },
  Skill_133323_Desc_1 = {
    Text = "전열의 적에게 <Damage:[Damage:Arg1]> 피해를 입히며, 생명력을 [Arg2] 잃을 때마다 피해 +[Arg3], 자신은 동일한 양의 생명력을 회복합니다."
  },
  Skill_133323_Name_1 = {Text = "약식"},
  Skill_133324_Desc_1 = {
    Text = "적 전체에게 <Damage:[Damage:Arg1]> 피해를 입히고 <PVPCognitiveDissonanceKeyWords:인지 착란>을 부여합니다."
  },
  Skill_133324_Name_1 = {
    Text = "사야의 노래"
  },
  Skill_133325_BattleDesc_1 = {
    Text = "아군 한 명을 선택하여 <Heal:[Heal:Arg4]> <PVPFeatheredSeedsKeyWords:우종>과 동량의 HP를 획득하게 하며, [Arg2] 행동력을 소모할 때마다 <PVPFeatheredSeedsKeyWords:우종>과 동량의 HP가 [Arg3] 증가."
  },
  Skill_133325_Desc_1 = {
    Text = "아군 1명을 선택하여 <Heal:[Heal:Arg1]> <PVPFeatheredSeedsKeyWords:우종>과 동일한 양의 생명력을 부여하며, 연산력을 [Arg2] 소모할 때마다 <PVPFeatheredSeedsKeyWords:우종>과 동일한 양의 생명력이 [Arg3] 증가합니다."
  },
  Skill_133325_Name_1 = {Text = "확산"},
  Skill_133346_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:중상>, PVPPenetrateKeywords:관통 1>, <DelayKeywords:지연 1>을 적용한다: 전체 아군의 HP를 <Heal:[Heal:Arg1]> 회복하며, <PVPSeriousInjuryKeywords:중상>이 [Arg2]만큼의 방어막 또는 <DelayKeywords:지연>을 분산시킬 때마다 HP 회복량이 [Arg3] 증가한다."
  },
  Skill_133346_Name_1 = {
    Text = "새로운 세계에 바치다"
  },
  Skill_133346_UnknownName = {
    Text = "새로운 세계에 바치다"
  },
  Skill_133347_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 이 명륜은 사망 후에도 보존됩니다. 장착자 사망 시 및 사망 상태에서의 이후 [Arg2]턴 종료 후, 다른 아군이 <Heal:[Heal:Arg1]> <PVPFeatheredSeedsKeyWords:우종>과 HP를 획득합니다."
  },
  Skill_133347_Name_1 = {
    Text = "세상이 향기로 물들기를"
  },
  Skill_133348_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 후, 장착자의 「타격」, 「스킬」, 「광기 폭발」 설명을 식별할 수 없지만, 매 피해, 보호막, 치유가 랜덤으로 [Arg1]%～[Arg2]% 증가합니다."
  },
  Skill_133348_Name_1 = {
    Text = "진흙 속의 동화"
  },
  Skill_133365_AwakerSkillBackgroundStory = {
    Text = "그녀는 실타래이 끊어지는 소리를 셀 수 없이 들었다.\n이루어지지 않은 재회. 하지 못한 고백. 태어나지 못한 아이.\n세상에 나오지 못한 음악. 승리하지 못한 전쟁. 살아남지 못한 문명.\n실타래은 엮이고. 실타래은 끊어지고. 실타래은 다시 그 거대한 그물로 흘러든다.\n운명의 신은 이미 알고 있었다, 진정으로 소멸하는 것은 없으며, 진정으로 존재했던 것도 없다는 것을."
  },
  Skill_133365_Desc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 다른 깨어남체가 광기를 <Energy:[Energy:Arg2]>pt 획득하며, 다음 「영원의 직조」가 추가 「<DerivativeCardKeywords_138:사선인명>」을 생성해 덱과 버린 카드 더미에 넣는다."
  },
  Skill_133365_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_133365_Name = {
    Text = "운명의 그물"
  },
  Skill_133365_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_133366_AwakerSkillBackgroundStory = {
    Text = "그녀가 태어난 첫날부터, 그녀는 운명의 실타래이 뻗어나가는 것을 보았다.\n실타래의 궤적을 따라, 그녀는 문을 열고 들어가 끝없는 죄수의 운명을 받아들였다.\n실타래은 모이라이라 불리는 물레를 관통하고, 성벽과 해협을 관통하고, 맹세와 거짓말을 관통하고, 스스로 선택하고 있다고 믿는 모든 영혼을 관통했다.\n이 자유의 환상 속에서, 물레는 돌고 또 돌며, 영원히 멈추지 않는다."
  },
  Skill_133366_Desc_0 = {
    Text = "모든 적에게 <CutKeywords:운명 재단> [FateCut:Arg1]pt를 주고, 「<DerivativeCardKeywords_138:사선인명>」 1장을 생성하여 손에 넣는다."
  },
  Skill_133366_EffectNameList = {
    Text = "운명 재단"
  },
  Skill_133366_Name = {
    Text = "영원한 직조"
  },
  Skill_133366_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_133366_tempBattleDesc_1 = {
    Text = "모든 적에게 [FateCut:Arg1]pt의 <CutKeywords:운명 재단>을 주고, 「<DerivativeCardKeywords_138:사선인명>」 1장을 손에 넣는다."
  },
  Skill_133366_tempBattleDesc_2 = {
    Text = "모든 적에게 [FateCut:Arg1]pt의 <CutKeywords:운명 재단>을 주고, 「<DerivativeCardKeywords_138:사선인명>」 1장을 손에 넣으며, 덱과 버린 카드 더미에 넣는다."
  },
  Skill_133381_Desc_0 = {
    Text = "임시 <SingularityKeywords2:특이점 프리즘> 5스택을 획득하고, HP가 가장 낮은 적에게 <CutKeywords:운명 재단> [FateCut:Arg2]pt를 준다."
  },
  Skill_133381_Desc_3 = {
    Text = "임시 <SingularityKeywords2:특이점 프리즘> 10스택을 획득하고, HP가 가장 낮은 적에게 <CutKeywords:운명 재단> [FateCut:Arg2]pt를 준다."
  },
  Skill_133381_Name = {
    Text = "끝없는 실타래타래"
  },
  Skill_133473_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 무작위 증상 카드 [Arg3]장을 섞어 넣는다."
  },
  Skill_133473_Name = {
    Text = "흑사의 키스"
  },
  Skill_133474_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 깨어남체의 <DepleteIconKeywords:소모>가 부여된 「타격」 [Arg3]장을 상대의 덱에 섞어 넣는다."
  },
  Skill_133474_Name = {
    Text = "환독 침식"
  },
  Skill_133715_Desc = {
    Text = "깨어남체 1명을 선택하여 카드 속성을 추가하고, 해당 깨어남체의 현재 및 미래의 모든 카드에 전파한다."
  },
  Skill_133715_Name = {
    Text = "카드 속성 전파"
  },
  Skill_133950_Desc = {
    Text = "해금된 3개의 랜덤 키오더 중 1개를 선택하여 즉시 발동하고 2회 적용합니다. 사용 후 영구적으로 「<DerivativeCardKeywords_140:봄의 소식>」으로 변화합니다."
  },
  Skill_133950_Name = {
    Text = "이치고이치에"
  },
  Skill_133951_Desc = {
    Text = "<Posse:[Arg1]> 포인트의 은열쇠 에너지를 획득하며, 사용 후 영구적으로 「<DerivativeCardKeywords_141:벚꽃 만개>」로 변화합니다."
  },
  Skill_133951_Name = {
    Text = "봄의 편지"
  },
  Skill_133952_Desc = {
    Text = "<Posse:[Arg1]> 포인트의 은열쇠 에너지를 획득하며, 사용 후 영구적으로 「<DerivativeCardKeywords_142:꽃눈보라>」로 변화합니다."
  },
  Skill_133952_Name = {
    Text = "벚꽃 만개"
  },
  Skill_133953_Desc = {
    Text = "<Posse:[Arg1]> 포인트의 은열쇠 에너지를 획득하며, 사용 후 영구적으로 「<DerivativeCardKeywords_143:일기일회>」로 변화합니다."
  },
  Skill_133953_Name = {Text = "꽃바람"},
  Skill_134007_Desc = {
    Text = "사용 후, 선택한 깨어남체의 궁극기를 여러 번 강제로 발동시킨다."
  },
  Skill_134007_Name = {
    Text = "강제적으로 궁극기 사용하기"
  },
  Skill_134008_Desc = {
    Text = "사용 후, 몬스터가 현재 의도를 강제로 사용한다."
  },
  Skill_134008_Name = {
    Text = "강제적으로 의도 사용하기"
  },
  Skill_134009_Desc = {
    Text = "사용 후, 손패 더미 맨 위의 카드 1장을 여러 번 강제로 사용한다."
  },
  Skill_134009_Name = {
    Text = "강제적으로 카드 사용하기"
  },
  Skill_134010_Desc = {
    Text = "사용 후, 플레이어에게 열쇠 지령을 여러 번 강제로 발동시킨다."
  },
  Skill_134010_Name = {
    Text = "강제적으로 열쇠 지령 사용하기"
  },
  Skill_134203_Desc = {
    Text = "임시 치명타 피해 70% 증가."
  },
  Skill_134203_Name = {
    Text = "은밀한 오후 휴식 시간"
  },
  Skill_134204_Desc = {
    Text = "임시 치명타 피해 60% 증가."
  },
  Skill_134204_Name = {
    Text = "은밀한 오후 휴식 시간"
  },
  Skill_134205_Desc = {
    Text = "임시 치명타 피해 80% 증가."
  },
  Skill_134205_Name = {
    Text = "은밀한 오후 휴식 시간"
  },
  Skill_134206_Desc = {
    Text = "임시 치명타 피해 50% 증가."
  },
  Skill_134206_Name = {
    Text = "은밀한 오후 휴식 시간"
  },
  Skill_134210_Desc = {
    Text = "모든 깨어남을 해제한다."
  },
  Skill_134210_Name = {
    Text = "모든 깨어남 해방"
  },
  Skill_134212_Desc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 임시 피해 증폭 효과를 [Arg2]% 획득한다. 「아라크네」가 파티에 있을 경우, 「영원한 직조」 1장을 드로우해 그 카드의 행동력 소모를 1 감소시킨다."
  },
  Skill_134212_Name = {
    Text = "운명의 궤적"
  },
  Skill_134252_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 다음에 주는 피해가 2배가 된다."
  },
  Skill_134252_Name_1 = {
    Text = "은밀한 오후 휴식 시간"
  },
  Skill_138603_Desc = {
    Text = "모든 적에게 최대 생명력의 1% 피해를 3회 입히고, 그들의 초차원 공간을 파괴하여 그 안의 카드를 모두 제거합니다."
  },
  Skill_138603_Name = {
    Text = "운명의 실타래 제자리를 찾다"
  },
  Skill_138768_Desc = {
    Text = "일러스트 설정 테스트 카드입니다."
  },
  Skill_138768_Name = {
    Text = "추격 테스트"
  },
  Skill_138769_Desc = {
    Text = "특정 카드로 추격을 진행하며, 해당 카드의 카드 일러스트를 재생합니다."
  },
  Skill_138769_Name = {
    Text = "추격 테스트"
  },
  Skill_138810_AwakerSkillBackgroundStory = {
    Text = "겉모습이 중요할까, 아니면 속의 영혼이 더 중요할까? 이런 것에 답은 과연 있기는 한 걸까?\n사랑 속에서 몸부림치는 이는 이렇게 방황하면서 휘말리게 될 희생양들을 소중히 여기는 마음으로 포식한다."
  },
  Skill_138810_BattleDesc_0 = {
    Text = "현재 HP의 10%([Arg4])를 잃고, 전체 적에게 <Corrosion:부식>을 [Corrosion:Arg1]pt 입힌다. 모든 명령 카드를 버린 후, 버린 만큼 카드를 ([Arg3])장 드로우한다."
  },
  Skill_138810_BattleDesc_1 = {
    Text = "현재 HP의 10%([Arg4])를 잃고, 전체 적에게 <Corrosion:부식>을 [Corrosion:Arg1]pt 입힌다. 모든 명령 카드를 버린 후, 버린 만큼 카드를 ([Arg3])장 드로우한다."
  },
  Skill_138810_BattleDesc_3 = {
    Text = "현재 HP의 10%([Arg4])를 잃고, 전체 적에게 <Corrosion:부식>을 [Corrosion:Arg1]pt 입힌 다음, 추가로 대상 최대 HP의 0.5%에 해당하는 <Corrosion:부식>을 입힌다. 모든 명령 카드를 버린 후, 카드 [Arg3]장 드로우한다."
  },
  Skill_138810_Desc_0 = {
    Text = "현재 HP의 10%를 잃고, 모든 적에게 <Corrosion:침식>을 [Corrosion:Arg1]pt 가한다. 모든 명령 카드를 버린 후, 버린 만큼 카드를 뽑는다."
  },
  Skill_138810_Desc_1 = {
    Text = "현재 HP의 10%를 잃고, 모든 적에게 <Corrosion:침식>을 [Corrosion:Arg1]pt 가한다. 모든 명령 카드를 버린 후, 버린 만큼 카드를 뽑는다."
  },
  Skill_138810_Desc_3 = {
    Text = "현재 HP의 10%를 잃고, 모든 적에게 <Corrosion:침식>을 [Corrosion:Arg1]pt 가하며, 대상의 최대 HP의 0.5%만큼 <Corrosion:침식>을 추가로 부여한다. 모든 명령 카드를 버린 후, 버린 만큼 카드를 뽑는다."
  },
  Skill_138810_EffectNameList = {Text = "부식"},
  Skill_138810_Name = {
    Text = "피어나는 살점"
  },
  Skill_138810_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_139862_Desc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 「스킬」 카드 2장을 드로우해 <ErosionColorInkKeywords:인지 혼란>을 부여한다. 사야가 파티에 있을 경우 <KaiHuajishu:우종> 1스택을 획득한다."
  },
  Skill_139862_Name = {
    Text = "새로운 세계에 바치다"
  },
  Skill_140120_Desc_1 = {
    Text = "목표 한명에게 운명, 이로써 고하노라를 부여한다."
  },
  Skill_140120_Name_1 = {
    Text = "운명, 이로써 고하노라"
  },
  Skill_140144_Desc_1 = {
    Text = "대상 1명에게 <ReinforceKeywords:치취>를 부여합니다."
  },
  Skill_140144_Name_1 = {Text = "치취"},
  Skill_140457_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:장착 시 및 임의의 깨어남체가 「광기 폭발」을 발동한 후, 자신이 <Block:[Block:Arg1]> 보호막을 획득합니다."
  },
  Skill_140457_Name_1 = {
    Text = "별들에게"
  },
  Skill_140566_Desc = {
    Text = "사용 후, 테스트용 성녀 작성(특이점 비콘 30 포함), 테스트용 동료의 힘을 획득한다."
  },
  Skill_140567_Desc = {
    Text = "사용 후, 테스트용 성녀 작성, 테스트용 동료의 힘(특이점 비콘 30 포함)을 획득한다."
  },
  Skill_140592_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <FragileIconKeywords:취약>을 부여하고, 드로우 더미의 무작위 카드 2장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140598_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, 드로우 더미의 무작위 카드 1장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140600_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, 드로우 더미의 무작위 카드 1장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140601_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. 드로우 더미의 무작위 카드 3장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140604_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. <PowerIconKeywords:힘> [Arg3]을 획득하고, 드로우 더미의 무작위 카드 1장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140608_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, 드로우 더미의 무작위 카드 1장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140609_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <WeaknessIconKeywords:허약>을 부여하고, 드로우 더미의 무작위 카드 1장에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_140665_Desc = {
    Text = "임시 <SingularityKeywords2:특이점 프리즘>을 획득하고 생명력이 가장 낮은 적에게 <CutKeywords:운명 심판>을 가합니다."
  },
  Skill_140665_Name = {
    Text = "끝없는 실타래타래"
  },
  Skill_140666_Desc_1 = {
    Text = "대상 하나에게 인지 착란을 부여합니다."
  },
  Skill_140666_Name_1 = {
    Text = "인지 착란"
  },
  Skill_140680_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 <MaxHPKeywords:최대 HP>를 [Arg1] 획득하고, 턴 종료 시 HP를 <Heal:[Heal:Arg2]> 회복한다. HP 회복량은 장착자의 HP가 낮을수록 증가하며, 최대 [Arg3]% 증가한다."
  },
  Skill_140680_Name_1 = {
    Text = "이상한 나라의 릴리"
  },
  Skill_140714_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 2회 입히고, <HungerKeywords:허기> 1 스택을 획득합니다. 막히지 않은 데미지를 1회 입힐 때마다 <HungerKeywords:허기> 1 스택을 추가로 획득합니다."
  },
  Skill_140714_Name = {
    Text = "먹ｦ이ﾋ 찾기"
  },
  Skill_140714_tempName_1 = {
    Text = "먹ｦ이ﾋ 찾기"
  },
  Skill_140714_tempName_2 = {
    Text = "먹이 찾기"
  },
  Skill_140716_Desc = {
    Text = "자신의 부정적 상태를 해제하고 「호식」 상태를 획득합니다: 매 턴 시작 시 허기 1스택을 획득하고, 막히지 않은 데미지를 줄 때 최대 HP의 2% 만큼 방어막를 획득하며, 적응의 최대 스택이 75로 증가합니다."
  },
  Skill_140716_Name = {Text = "탈A피ﾑ"},
  Skill_140716_tempName_1 = {Text = "탈A피ﾑ"},
  Skill_140716_tempName_2 = {Text = "탈피"},
  Skill_140717_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 데미지를 주고 동량의 <BleedingIconKeywords:출혈>을 부여한다. 자신의 최대 HP가 5% 증가하며, 플레이어 손패의 무작위 「스킬」 카드 1장을 삼켜 소모한다."
  },
  Skill_140717_Name = {
    Text = "약ﾃ탈ｨ"
  },
  Skill_140717_tempName_1 = {
    Text = "약ﾃ탈ｨ"
  },
  Skill_140717_tempName_2 = {Text = "약식"},
  Skill_140765_Desc = {
    Text = "해당 의도로 전환 시, 자신의 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:약점>을 적에게 전이한다. 전이에 성공하면 손실타래된 HP의 10% (<Heal:[Heal:Arg3]>)를 회복하고 <HungerKeywords:허기> 1층을 획득하며, 실타래패하면 <Damage:[Damage:Arg1]>의 데미지를 주고 <HungerKeywords:허기> 2층을 획득한다."
  },
  Skill_140765_Name = {
    Text = "자ｸ극kQ 반응"
  },
  Skill_140765_tempName_1 = {
    Text = "자ｸ극kQ 반응"
  },
  Skill_140765_tempName_2 = {
    Text = "스트레스 반응"
  },
  Skill_140766_Desc = {
    Text = "해당 의도로 전환 시, 자신의 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:약점>을 적에게 전이한다. 전이에 성공하면 손실타래된 HP의 10% (<Heal:[Heal:Arg3]>)를 회복하고 <HungerKeywords:허기> 1층을 획득하며, 실타래패하면 <Damage:[Damage:Arg1]>의 데미지를 주고 <HungerKeywords:허기> 2층을 획득한다."
  },
  Skill_140766_Name = {
    Text = "자ｸ극kQ 반응"
  },
  Skill_140766_tempName_1 = {
    Text = "자ｸ극kQ 반응"
  },
  Skill_140766_tempName_2 = {
    Text = "스트레스 반응"
  },
  Skill_140767_Desc = {
    Text = "해당 의도로 전환 시, 자신의 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:약점>을 적에게 전이한다. 전이에 성공하면 손실타래된 HP의 10% (<Heal:[Heal:Arg3]>)를 회복하고 <HungerKeywords:허기> 1층을 획득하며, 실타래패하면 <Damage:[Damage:Arg1]>의 데미지를 주고 <HungerKeywords:허기> 2층을 획득한다."
  },
  Skill_140767_Name = {
    Text = "자ｸ극kQ 반응"
  },
  Skill_140767_tempName_1 = {
    Text = "자ｸ극kQ 반응"
  },
  Skill_140767_tempName_2 = {
    Text = "스트레스 반응"
  },
  Skill_140829_Desc = {
    Text = "임시 최종 피해 +[Arg1]%, 모든 적에게 최대 HP의 [Arg2]%에 해당하는 침식을 가합니다."
  },
  Skill_140829_Name = {Text = "사냥"},
  Skill_140830_Desc = {
    Text = "<Pangtuosihuodong_Defend:\"방호\"> 또는 <Pangtuosihuodong_Attack:\"사냥\">을 선택합니다."
  },
  Skill_140830_Name = {
    Text = "야마 조종"
  },
  Skill_140831_Desc = {
    Text = "모든 적이 이번 턴에 가하는 피해가 [Arg1]% 감소하고, [Arg2] 포인트의 힘을 획득합니다."
  },
  Skill_140831_Name = {Text = "호위"},
  Skill_140849_Desc = {
    Text = "장착자가 광기 <Energy:[Arg1]>pt와 <Yishiganshe:「의식 간섭」>을 획득한다."
  },
  Skill_140849_Name = {
    Text = "이상한 나라의 릴리"
  },
  Skill_140850_Desc = {
    Text = "장착자가 광기 <Energy:[Arg1]>pt와 <Yishiganshe:「의식 간섭」>을 획득한다."
  },
  Skill_140850_Name = {
    Text = "이상한 나라의 릴리"
  },
  Skill_140851_Desc = {
    Text = "장착자가 광기 <Energy:[Arg1]>pt와 <Yishiganshe:「의식 간섭」>을 획득한다."
  },
  Skill_140851_Name = {
    Text = "이상한 나라의 릴리"
  },
  Skill_140852_Desc = {
    Text = "장착자가 광기 <Energy:[Arg1]>pt와 <Yishiganshe:「의식 간섭」>을 획득한다."
  },
  Skill_140852_Name = {
    Text = "이상한 나라의 릴리"
  },
  Skill_141020_Desc_1 = {
    Text = "테스트용 상태를 추가합니다."
  },
  Skill_141020_Name_1 = {
    Text = "상태 추가"
  },
  Skill_141058_AwakerSkillBackgroundStory = {
    Text = "엄청난 호기심과 뛰어난 습득력 덕분에, 사야는 자신이 인간을 모방하는 과정에서 겉으로는 인간 소녀의 모습과 똑닮은 영혼을 얻게 되었다.\n하지만, 그녀는 그로 인해 더욱 고독해졌고 그로 인해 더없이 행복해졌다."
  },
  Skill_141058_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합>이 [Blood:Arg2] 증가한다. <KaiHuajishu:우종> 1스택을 획득한다."
  },
  Skill_141058_Desc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합>이 [Blood:Arg1] 증가한다. 현재 HP가 낮을수록 효과가 높아지며, 최대 100% 증가한다. <KaiHuajishu:우종> 1스택을 획득한다."
  },
  Skill_141058_EffectNameList = {
    Text = "배아 융합"
  },
  Skill_141058_Name = {
    Text = "생물 의태"
  },
  Skill_141947_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 종료 시, <PVPVoidKeywords:공허>가 부여된 「스킬」 카드를 [Arg1]장 <PVPDiscoveryKeyWords:발견>하여 손에 넣습니다."
  },
  Skill_141947_Name_1 = {
    Text = "위를 향한 추락"
  },
  Skill_142022_Desc = {
    Text = "[Arg1] 포인트의 <PowerIconKeywords:힘>을 획득합니다. 자신의 부정적 상태를 제거하고 「성스러운 날개」를 획득합니다: 자신의 턴에 받는 피해가 영구적으로 10% 감소합니다."
  },
  Skill_142022_Name = {
    Text = "성스러운 날개"
  },
  Skill_142023_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_142023_Name = {
    Text = "네 개의 날개가 자라나다"
  },
  Skill_142024_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. <ResentChainsKeywords:원한의 사슬> 3층을 획득합니다. 이 의도로 전환 시, 광기가 가장 높은 깨어남체 1명의 광기 폭발과 모든 커맨드 카드를 1턴 동안 봉인합니다."
  },
  Skill_142024_Name = {
    Text = "네 개의 날개가 자라나다-봉쇄"
  },
  Skill_142025_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. 모든 깨어남체의 현재 광기를 절반으로 줄입니다."
  },
  Skill_142025_Name = {
    Text = "네 개의 날개가 자라나다-냉적"
  },
  Skill_142026_Desc = {
    Text = "[Arg1] 점<PowerIconKeywords:힘>을 획득했습니다."
  },
  Skill_142026_Name = {
    Text = "날개 펼치기"
  },
  Skill_142027_Desc = {
    Text = "「융식의 핵」 1장을 덱에 넣습니다. 자신의 스킬을 강화합니다."
  },
  Skill_142027_Name = {
    Text = "문살 활짝 열림"
  },
  Skill_142028_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. <HeavyInjuryKeywords:치명타> 2층을 부여합니다. 이 의도로 전환 시, <HeavyInjuryKeywords:치명타> 1층을 부여합니다."
  },
  Skill_142028_Name = {
    Text = "두 개의 날개가 펼쳐지다-치명타"
  },
  Skill_142029_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 가합니다. 2 층 <WeaknessIconKeywords:허약>을 부여합니다."
  },
  Skill_142029_Name = {
    Text = "두 개의 날개가 펼쳐지다-허약"
  },
  Skill_142030_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_142030_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_142031_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_142031_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_142032_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. <HeavyInjuryKeywords:치명타> 2층을 부여합니다."
  },
  Skill_142032_Name = {
    Text = "두 개의 날개가 펼쳐지다-치명타"
  },
  Skill_142033_Desc = {
    Text = "[Arg1] 포인트의 <PowerIconKeywords:힘>을 획득합니다. 적의 영구 힘, 영구 반격, 영구 터치손상의 50%를 제거하고 「저주의 날개」를 부여합니다: 가하는 힘, 반격, 터치손상이 영구적으로 10% 감소합니다."
  },
  Skill_142033_Name = {
    Text = "저주의 날개"
  },
  Skill_142034_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_142034_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_142035_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. 각 커맨드 카드의 절반에 <SlowIconKeywords:둔화> 1층을 부여합니다. 이 의도로 전환 시, 손패의 절반에 해당하는 커맨드 카드에 <SlowIconKeywords:둔화> 1층을 부여합니다."
  },
  Skill_142035_Name = {
    Text = "네 개의 날개가 자라나다-둔화"
  },
  Skill_142036_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. <WeaknessIconKeywords:허약> 2층을 부여합니다. 이 의도로 전환 시, <WeaknessIconKeywords:허약> 1층을 부여합니다."
  },
  Skill_142036_Name = {
    Text = "두 개의 날개가 펼쳐지다-허약"
  },
  Skill_142037_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 가합니다. 2 층 <FragileIconKeywords:취약>을 부여합니다."
  },
  Skill_142037_Name = {
    Text = "두 개의 날개가 펼쳐지다-취약"
  },
  Skill_142038_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. HP가 낮은 적일수록 피해가 높아지며, 최대 100%까지 증가합니다."
  },
  Skill_142038_Name = {
    Text = "여섯 개의 날개가 만개하다-임종의 저어"
  },
  Skill_142039_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. <FragileIconKeywords:취약> 2층을 부여합니다. 이 의도로 전환 시, <FragileIconKeywords:취약> 1층을 부여합니다."
  },
  Skill_142039_Name = {
    Text = "두 개의 날개가 펼쳐지다-취약"
  },
  Skill_142040_Desc = {
    Text = "[Arg1] 포인트의 <PowerIconKeywords:힘>을 획득합니다. 적의 현재 피해 증폭의 25%를 제거하고 「약화의 날개」를 부여합니다: 가하는 기본 데미지, 중독, 반격이 영구적으로 10% 감소합니다."
  },
  Skill_142040_Name = {
    Text = "오염된 날개"
  },
  Skill_142041_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. <ResentChainsKeywords:원한의 사슬> 3층을 획득합니다."
  },
  Skill_142041_Name = {
    Text = "네 개의 날개가 자라나다-봉쇄"
  },
  Skill_142042_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. 각 단계마다 대상의 현재 HP의 5%에 해당하는 추가 피해를 입힙니다."
  },
  Skill_142042_Name = {
    Text = "여섯 개의 날개가 만개하다-성진의 추락"
  },
  Skill_142043_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_142043_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_142044_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점의 피해를 [AttackTimes:Arg2] 회 입힙니다. 각 단계마다 대상의 현재 HP의 5% 추가 피해를 입힙니다. 해당 의도로 전환 시, 이번 턴 동안 부정적 상태에 면역됩니다."
  },
  Skill_142044_Name = {
    Text = "여섯 개의 날개가 만개하다-성진의 추락"
  },
  Skill_142045_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. 각 커맨드 카드의 절반에 <SlowIconKeywords:둔화> 1층을 부여합니다."
  },
  Skill_142045_Name = {
    Text = "네 개의 날개가 자라나다-둔화"
  },
  Skill_142046_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 회 입힙니다. HP가 낮은 적일수록 피해량이 높아지며, 최대 100%까지 증가합니다. 이 의도로 전환 시, <PowerIconKeywords:힘>을 [Arg3] 포인트 획득합니다."
  },
  Skill_142046_Name = {
    Text = "여섯 개의 날개가 만개하다-임종의 저어"
  },
  Skill_142047_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 회 입힙니다. 피해량이 100% 증가하지만, 이번 턴에 자신이 최대 HP의 2% 피해를 받을 때마다 이 효과가 10% 감소하며, 최대 50%까지 감소합니다."
  },
  Skill_142047_Name = {
    Text = "여섯 개의 날개가 만개하다-이중 계시"
  },
  Skill_142048_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 입힙니다. 모든 깨어남체의 현재 광기를 절반으로 줄입니다. 이 의도로 전환 시, 모든 깨어남체가 광기 25를 잃습니다."
  },
  Skill_142048_Name = {
    Text = "네 개의 날개가 자라나다-냉적"
  },
  Skill_142049_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 회 입힙니다. 피해량이 100% 증가하지만, 이번 턴에 자신이 최대 HP의 2% 피해를 받을 때마다 이 효과가 10% 감소하며, 최대 50%까지 감소합니다.  이 의도로 전환 시, 최대 HP의 10%에 해당하는 방어막를 획득합니다."
  },
  Skill_142049_Name = {
    Text = "여섯 개의 날개가 만개하다-이중 계시"
  },
  Skill_142050_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_142050_Name = {
    Text = "네 개의 날개가 자라나다"
  },
  Skill_142449_Desc_1 = {
    Text = "무엇일까요?"
  },
  Skill_142449_Name_1 = {Text = "보물"},
  Skill_142449_UnknownName = {Text = "보물"},
  Skill_142686_Desc_1 = {
    Text = "대상의 명륜을 영구적으로 무효화하며, 다시 사용하면 해제됩니다."
  },
  Skill_142686_Name_1 = {
    Text = "슈퍼 포박"
  },
  Skill_142689_Desc_1 = {
    Text = "대상에게 명륜을 장착합니다."
  },
  Skill_142689_Name_1 = {
    Text = "명륜 장착"
  },
  Skill_142695_AwakerSkillBackgroundStory = {
    Text = "그는 가장 사랑하는 이들의 가장 생생하고 재미있는 부분을 붙잡아 두었고, 모든 적에게 가장 처참하고 긴 고통을 내려주었다.\n술잔이 오가는 밤마다, 그는 웃음을 터뜨리며 텅 빈 껍데기들로 이루어진 바다 속으로 빠져들었다."
  },
  Skill_142695_BattleDesc = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거한다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1]pt 감소시킨다. HP가 가장 낮은 적에게 촉수 피해의 [Arg2]%([Arg3])에 해당하는 <RealDamage:잠금 피해>를 입히며, 처치 시 영구 「건트」 <DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 1장을 손에 넣는다. 전투당 최대 영구 「건트」 3장까지 생성 가능."
  },
  Skill_142695_Desc = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거한다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg8]pt 감소시킨다. HP가 가장 낮은 적에게 촉수 피해의 [Arg2]%에 해당하는 <RealDamage:잠금 피해>를 입히며, 처치 시 영구 「건트」 <DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 1장을 손에 넣는다. 전투당 최대 영구 「건트」 3장까지 생성 가능."
  },
  Skill_142695_EffectNameList = {
    Text = "임시 힘 감소,촉수 피해 보너스,건트 레벨"
  },
  Skill_142695_Name = {
    Text = "끝없는 사냥"
  },
  Skill_142695_OverLimitUtlSkillDesc = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거한다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1]pt 감소시킨다. HP가 가장 낮은 적에게 촉수 피해의 [Arg6]%([Arg7])에 해당하는 <RealDamage:잠금 피해>를 입히며, 처치 시 영구 「건트」 <DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 2장을 손에 넣는다. 전투당 최대 영구 「건트」 3장까지 생성 가능. 모든 「건트」 의 행동력 소모 -1."
  },
  Skill_142695_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2,$GrowValue3"
  },
  Skill_142695_tempBattleDesc_1 = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거한다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1]pt 감소시킨다. HP가 가장 낮은 적에게 촉수 피해의 [Arg2]%([Arg3])에 해당하는 <RealDamage:잠금 피해>를 입히며, 처치 시 영구 「건트」 <DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 1장을 손에 넣는다. 전투당 최대 영구 「건트」 3장까지 생성 가능."
  },
  Skill_142695_tempBattleDesc_2 = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거합니다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1] 점 감소시킵니다. HP가 가장 낮은 적에게 촉수 피해의 [Arg2]%( [Arg3] )에 해당하는 <RealDamage:잠금 피해>를 입히고, 해당 적을 처치하면 영구적으로 \"건트\"<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 카드 1장을 손에 넣습니다. 전투당 최대 3장 영구 생성됩니다. [Arg5] 층 <BattueKeywords:집단 사냥>을 획득합니다."
  },
  Skill_142695_tempOverLimitUtlSkillDesc_1 = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거한다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1]pt 감소시킨다. HP가 가장 낮은 적에게 촉수 피해의 [Arg6]%([Arg7])에 해당하는 <RealDamage:잠금 피해>를 입히며, 처치 시 영구 「건트」 <DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 2장을 손에 넣는다. 전투당 최대 영구 「건트」 3장까지 생성 가능. 모든 「건트」 의 행동력 소모 -1."
  },
  Skill_142695_tempOverLimitUtlSkillDesc_2 = {
    Text = "자신의 <ExhaustionIconKeywords:힘 감소> 상태를 제거합니다. 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1] 점 감소시킵니다. HP가 가장 낮은 적에게 촉수 피해의 [Arg6]%( [Arg7] )에 해당하는 <RealDamage:잠금 피해>를 입히며, 처치 시 \"건트\"<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:> 2장을 영구적으로 손에 생성합니다. 전투당 최대 3장 영구 생성. 모든 곳의 \"건트\" 행동력 소모 -1. [Arg5]층 <BattueKeywords:집단 사냥> 획득."
  },
  Skill_142696_AwakerSkillBackgroundStory = {
    Text = "「내게 기도를 올려보아라. 그럼 네가 원하는 죽음을 내려주도록 하지.」"
  },
  Skill_142696_BattleDesc_0 = {
    Text = "피해 <Damage:[Damage:Arg1]>pt를 가하고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_142696_BattleDesc_3 = {
    Text = "피해 <Damage:[Damage:Arg1]>pt를 가하고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다. 매턴 첫 번째 사용 시, 「건트」 1장( [Arg3]/1 )을 뽑는다."
  },
  Skill_142696_Desc_0 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 가하고, 폰토스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_142696_Desc_3 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 가하고, 폰토스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 매턴 첫 번째 사용 시, 「건트」 1장을 뽑는다."
  },
  Skill_142696_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_142696_Name = {Text = "타격"},
  Skill_142696_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_142699_AwakerSkillBackgroundStory = {
    Text = "「에뷔노스에서 단 잠을 취하고, 에뷔노스에서 실타래컷 마시거라. 그 영원하고, 오래된 심연의 근원에서.」"
  },
  Skill_142699_BattleDesc_0 = {
    Text = "방어막 <Block:[Block:Arg1]>pt를 획득하고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_142699_BattleDesc_3 = {
    Text = "방어막 <Block:[Block:Arg1]>pt를 획득하고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다. 매턴 첫 번째 사용 시, 「건트」 1장( [Arg3]/1 )을 뽑는다."
  },
  Skill_142699_Desc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 폰토스가 광기를 <Energy:[Energy:Arg2]> 획득한다."
  },
  Skill_142699_Desc_3 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 폰토스가 광기를 <Energy:[Energy:Arg2]> 획득한다. 매턴 첫 번째 사용 시, 「건트」 1장을 뽑는다."
  },
  Skill_142699_EffectNameList = {
    Text = "방어막, 광기"
  },
  Skill_142699_Name = {Text = "방어"},
  Skill_142699_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_142700_AwakerSkillBackgroundStory = {
    Text = "「당신은 무엇을 원하는가?」\n힘, 질서, 잃었다가 되찾는 것, 피로 원수를 갚는 것……\n그는 오랫동안 어둡게 침묵에 잠겼지만, 사실타래 그는 이미 답을 알고 있었다. 풀 수 없는 답을.\n그는 태양이 동쪽에서 떠서 서쪽으로 지기를 원했고, 모든 것이 평소와 같기를 바랐다."
  },
  Skill_142700_BattleDesc_0 = {
    Text = "폰토스가 <Energy:[Energy:Arg1]> 광기를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 덱에 「건트」가 3장 있을 때마다 「끝없는 사냥」이 <BattueKeywords:집단 사냥> 1층을 추가로 획득합니다. 폰토스의 카드를 1장 사용할 때마다 다음 「끝없는 사냥」의 임시 힘 감소 효과가 [Arg3]% 증가합니다. 매 턴 최대 3회 발동."
  },
  Skill_142700_BattleDesc_15 = {
    Text = "폰토스가 <Energy:[Energy:Arg1]> 점 광기를 얻습니다. <ExaltIconKeywords:영지 깨어남>: 덱에 「건트」가 2장 있을 때마다, 「끝없는 사냥」이 추가로 <BattueKeywords:집단 사냥> 1층을 얻습니다. 폰토스의 카드를 1장 사용할 때마다, 다음 「끝없는 사냥」의 임시 힘 감소 효과가 [Arg3]% 증가하며, 매 턴 최대 3회 발동합니다. 매 턴 첫 번째 「타격」과 첫 번째 「방어」 시 추가로 <Energy:[Energy:Arg4]> 점 광기를 얻습니다."
  },
  Skill_142700_Desc_0 = {
    Text = "폰토스가 [Arg2]% 광기 최대치를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 덱에 「건트」가 3장 있을 때마다 「끝없는 사냥」이 <BattueKeywords:집단 사냥> 1층을 획득합니다. 폰토스의 카드를 1장 사용할 때마다 다음 「끝없는 사냥」의 임시 힘 감소 효과가 [Arg3]% 증가합니다. 매 턴 최대 3회 발동."
  },
  Skill_142700_Desc_15 = {
    Text = "폰토스가 [Arg2]% 광기 최대치를 얻습니다. <ExaltIconKeywords:영지 깨어남>: 덱에 「건트」가 2장 있을 때마다, 「끝없는 사냥」이 <BattueKeywords:집단 사냥> 1층을 얻습니다. 폰토스의 카드를 1장 사용할 때마다, 다음 「끝없는 사냥」의 임시 힘 감소 효과가 [Arg3]% 증가하며, 매 턴 최대 3회 발동합니다. 매 턴 첫 번째 「타격」과 첫 번째 「방어」 시 추가로 <Energy:[Energy:Arg4]> 점 광기를 얻습니다."
  },
  Skill_142700_EffectNameList = {Text = "광기"},
  Skill_142700_Name = {
    Text = "심연의 분노"
  },
  Skill_142802_Desc = {
    Text = "장착자가 잠금 광기를 <Yellow:[Arg1]>pt 획득하고, 각 위치의 명령 카드의 <ErosionColorInkKeywords:인지 착란> 효과를 제거한다."
  },
  Skill_142802_Name = {
    Text = "위를 향한 추락"
  },
  Skill_142803_BattleDesc = {
    Text = "모든 적에게 [Arg1]pt 및 최대 HP의 1%의 잠금 <Corrosion:부식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace24:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142803_Desc = {
    Text = "모든 적에게 장착자의 공격력의 3000% 및 최대 HP의 1%의 잠금 <Corrosion:부식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace24:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142803_Name = {
    Text = "인세로의 내딛음"
  },
  Skill_142804_Desc = {
    Text = "장착자가 잠금 광기를 <Yellow:[Arg1]>pt 획득하고, 각 위치의 명령 카드의 <ErosionColorInkKeywords:인지 착란> 효과를 제거한다."
  },
  Skill_142804_Name = {
    Text = "위를 향한 추락"
  },
  Skill_142805_Desc = {
    Text = "장착자가 잠금 광기를 <Yellow:[Arg1]>pt 획득하고, 각 위치의 명령 카드의 <ErosionColorInkKeywords:인지 착란> 효과를 제거한다."
  },
  Skill_142805_Name = {
    Text = "위를 향한 추락"
  },
  Skill_142806_BattleDesc = {
    Text = "모든 적에게 [Arg1]pt 및 대상 최대 HP의 0.4%의 잠금 <Corrosion:침식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace21:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142806_Desc = {
    Text = "모든 적에게 장착자의 공격력의 1500% 및 대상 최대 HP의 0.4%의 잠금 <Corrosion:침식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace21:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142806_Name = {
    Text = "인세로의 내딛음"
  },
  Skill_142807_Desc = {
    Text = "장착자가 잠금 광기를 <Yellow:[Arg1]>pt 획득하고, 각 위치의 명령 카드의 <ErosionColorInkKeywords:인지 착란> 효과를 제거한다."
  },
  Skill_142807_Name = {
    Text = "위를 향한 추락"
  },
  Skill_142808_BattleDesc = {
    Text = "모든 적에게 [Arg1]pt 및 대상 최대 HP의 0.8%의 잠금 <Corrosion:침식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace23:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142808_Desc = {
    Text = "모든 적에게 장착자의 공격력의 2500% 및 대상 최대 HP의 0.8%의 잠금 <Corrosion:침식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace23:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142808_Name = {
    Text = "인세로의 내딛음"
  },
  Skill_142809_BattleDesc = {
    Text = "모든 적에게 [Arg1]pt 및 최대 HP의 0.6%의 잠금 <Corrosion:부식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace22:「위를 향한 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142809_Desc = {
    Text = "모든 적에게 장착자의 공격력의 2000% 및 최대 HP의 0.6%의 잠금 <Corrosion:부식> 피해를 입히고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 <Falltospace22:「위로 추락」> 1장을 드로우 덱에 섞는다."
  },
  Skill_142809_Name = {
    Text = "인세로의 내딛음"
  },
  Skill_142846_AwakerSkillBackgroundStory = {
    Text = "인간의 귀와 현재의 은심테크놀로지로는, 폰토스의 사냥 호각 소리에서 어떠한 유효한 정보도 얻을 수 없다.\n하지만 에포양스에 동화된 모든 개체는, 호각 소리의 지시에 따르는 것에 매우 빠르게 적응하는 것으로 보인다."
  },
  Skill_142846_Desc = {
    Text = "이번 전투에서 처음 사용하는 경우, 3종류의 서로 다른 「건트」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>를 생성하여 손에 넣고 <Block:[Block:Arg1]> 점 방어막를 획득합니다. 영구 건트를 4장 보유할 때마다 그 중 1장을 「쌍생 건트」로 업그레이드하며, 그렇지 않으면 「건트」를 3장 뽑습니다."
  },
  Skill_142846_EffectNameList = {
    Text = "방어막,건트 레벨"
  },
  Skill_142846_Name = {
    Text = "건트지기의 호각"
  },
  Skill_142846_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_142847_AwakerSkillBackgroundStory = {
    Text = "에포양스가 나타나는 빈도는 불규칙하며, 그 전모 역시 관측할 수 없다.\n유일하게 알려진 것은, 얼굴 없는 생물들이 무리를 지어 하늘에 출몰할 때, 창문 안에서 형언할 수 없는 진주빛을 발산하는 집 한 채가 어딘가 안개 속 절벽 위에 우뚝 서 있다는 것이다."
  },
  Skill_142847_BattleDesc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 반드시 크리티컬인 피해를 입힙니다. <Energy:[Energy:Arg2]> 광기를 획득합니다. 추가로 X회 발동."
  },
  Skill_142847_BattleDesc_2 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 반드시 크리티컬인 피해를 입힙니다. <Energy:[Energy:Arg2]> 광기를 획득합니다. 추가로 X+1회 발동."
  },
  Skill_142847_Desc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 반드시 크리티컬인 피해를 입힙니다. <Energy:[Energy:Arg2]> 광기를 획득합니다. 추가로 X회 발동."
  },
  Skill_142847_Desc_2 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 반드시 크리티컬인 피해를 입힙니다. <Energy:[Energy:Arg2]> 광기를 획득합니다. 추가로 X+1회 발동."
  },
  Skill_142847_EffectNameList = {
    Text = "데미지,광기"
  },
  Skill_142847_Name = {
    Text = "요마 습격"
  },
  Skill_142847_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_142874_Desc_1 = {
    Text = "적에게 <Damage:[Damage:Arg1]> 데미지를 입히고, 피해량의 절반만큼 HP를 잃거나 아군에게 <Block:[Block:Arg2]> 방어막를 부여한다. 카드를 [Arg3] 장 뽑는다."
  },
  Skill_142874_Name_1 = {
    Text = "요마 사냥"
  },
  Skill_142875_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]> 데미지를 주고, <Energy:[Energy:Arg2]> 광기를 획득합니다."
  },
  Skill_142875_Name_1 = {Text = "타격"},
  Skill_142876_Desc_1 = {
    Text = "<TauntKeywords:도발>, 공격을 받을 때마다 <PVPDerivativeCardKeywords_30:\"사냥의 악몽\"> [Arg1] 장을 손패에 넣습니다."
  },
  Skill_142876_Name_1 = {
    Text = "군주의 의식"
  },
  Skill_142877_Desc_1 = {
    Text = "임의의 다른 대상을 선택한다. 아군일 경우, 자신과 아군이 <Block:[Block:Arg1]> 방어막를 획득하고, 다음 턴 시작 전까지 해당 아군이 받는 피해의 절반을 대신 부담한다; 적일 경우, 다음 턴 시작 전까지 받는 피해의 절반을 전가한다."
  },
  Skill_142877_Name_1 = {
    Text = "끝없는 사냥"
  },
  Skill_142878_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 입힙니다. 대상의 광기가 [Arg2] 미만이면 데미지가 두 배가 되고, 그렇지 않으면 <PVPEmptinessKeywords:공허>를 입힙니다."
  },
  Skill_142878_Name_1 = {
    Text = "수렵의 예술"
  },
  Skill_142879_Desc_1 = {
    Text = "[Arg1] 장의 <PVPDerivativeCardKeywords_30:\"사냥의 악몽\">을 덱에 넣고, [Arg2] 장의 카드를 뽑는다."
  },
  Skill_142879_Name_1 = {
    Text = "건트의 지배자"
  },
  Skill_142958_Desc_1 = {
    Text = "지정한 아군이 <Block:[Block:Arg1]> 방어막를 획득하고, <PVPGrowthKeywords:성장> -[Arg2], 방어막 효과가 소진되면 [Arg3]장 드로우로 변경됩니다."
  },
  Skill_142958_Desc_2 = {
    Text = "[Arg3]장 드로우."
  },
  Skill_142958_Name_1 = {
    Text = "마음이 허한 사람"
  },
  Skill_142958_UnknownName = {
    Text = "마음이 허한 사람"
  },
  Skill_142960_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142960_Name_1 = {
    Text = "란티고스 전용 무기 (임시 텍스트)"
  },
  Skill_142961_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전 현재 HP의 25%를 잃고; 「광기 폭발」 후 전체 적에게 [Arg1] 피해를 주고 동량의 HP를 흡수한다."
  },
  Skill_142961_Name_1 = {
    Text = "달콤한 열매의 낭설"
  },
  Skill_142962_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142962_Name_1 = {
    Text = "사토구야SR(임시 텍스트)"
  },
  Skill_142963_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142963_Name_1 = {
    Text = "벌처 SR (임시 텍스트)"
  },
  Skill_142964_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142964_Name_1 = {
    Text = "아포고몬 SR (임시 텍스트)"
  },
  Skill_142965_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142965_Name_1 = {
    Text = "샤타크 새 전용 무기 (임시 텍스트)"
  },
  Skill_142966_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 시작 시, 무작위 적에게 [Arg1] <PVPCompassKeywords:잘못된 길로 향하는 나침반>을 부여합니다."
  },
  Skill_142966_Name_1 = {
    Text = "갈림길을 가리키는 나침반"
  },
  Skill_142967_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142967_Name_1 = {
    Text = "독수리 전용 무기 (임시 텍스트)"
  },
  Skill_142968_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142968_Name_1 = {
    Text = "네프렌카 SR (임시 텍스트)"
  },
  Skill_142969_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142969_Name_1 = {
    Text = "본원 오지에 전용 무기(임시 텍스트)"
  },
  Skill_142970_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142970_Name_1 = {
    Text = "흑파라오 전용 무기 (임시 텍스트)"
  },
  Skill_142971_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 최대 손패 매수+ [Arg1] , 장착자 또는 아군이 사망 시, 해당 카드가 더 이상 <PVPDerivativeCardKeywords_2:\"환상\">으로 전환되지 않고 <PVPDerivativeCardKeywords_30:\"요마 사냥\">으로 전환됩니다."
  },
  Skill_142971_Name_1 = {
    Text = "살아있는 감옥"
  },
  Skill_142972_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142972_Name_1 = {
    Text = "본원 오지에 SR (임시 텍스트)"
  },
  Skill_142973_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142973_Name_1 = {
    Text = "본원 툴루 SR (임시 텍스트)"
  },
  Skill_142975_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142975_Name_1 = {
    Text = "사토구아 전용 무기(임시 텍스트)"
  },
  Skill_142977_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142977_Name_1 = {
    Text = "란테고스 SR (임시 텍스트)"
  },
  Skill_142978_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 적 전체에게 [Arg1] 스택 <PVPBless:축복>을 부여합니다."
  },
  Skill_142978_Name_1 = {
    Text = "달콤한 진실타래"
  },
  Skill_142980_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142980_Name_1 = {
    Text = "샨타크 SR (임시 텍스트)"
  },
  Skill_142981_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_142981_Name_1 = {
    Text = "아르고몬트 전용 무기 (임시 텍스트)"
  },
  Skill_143024_Desc_1 = {
    Text = "아군 위치1 또는 위치2 또는 적군을 선택하며, 메커니즘을 무시하지 않습니다."
  },
  Skill_143024_Name_1 = {
    Text = "대상 테스트4"
  },
  Skill_143025_Desc_1 = {
    Text = "아군 또는 적군을 선택하며, 적군의 도발을 무시합니다."
  },
  Skill_143025_Name_1 = {
    Text = "대상 테스트2"
  },
  Skill_143026_Desc_1 = {
    Text = "아군 위치1 또는 위치2 또는 적군을 선택하며, 적군의 잠행을 무시합니다."
  },
  Skill_143026_Name_1 = {
    Text = "대상 테스트3"
  },
  Skill_143027_Desc_1 = {
    Text = "아군 또는 적군을 선택하며, 적군의 잠행과 도발을 무시합니다."
  },
  Skill_143027_Name_1 = {
    Text = "대상 테스트1"
  },
  Skill_143028_Desc_1 = {
    Text = "대상 테스트에 필요한 카드를 획득합니다."
  },
  Skill_143028_Name_1 = {
    Text = "목표 테스트"
  },
  Skill_143392_Desc_1 = {
    Text = "깨어남체 하나의 HP를 0으로 만듭니다."
  },
  Skill_143392_Name_1 = {Text = "HP 제로"},
  Skill_143432_Desc = {
    Text = "행동력 소모 1 증가"
  },
  Skill_143432_Name = {
    Text = "행동력 소모 1 증가"
  },
  Skill_143433_Desc = {
    Text = "잠금 행동력1"
  },
  Skill_143433_Name = {
    Text = "잠금 행동력1"
  },
  Skill_143434_Desc = {
    Text = "잠금 행동력5"
  },
  Skill_143434_Name = {
    Text = "잠금 행동력5"
  },
  Skill_143443_Desc = {
    Text = "조건에 따라 깨어남체를 선택합니다"
  },
  Skill_143443_Name = {
    Text = "인터페이스 테스트"
  },
  Skill_143494_Desc_1 = {
    Text = "순수 피해를 면역합니다. 두 번째 발동 시 해제됩니다."
  },
  Skill_143494_Name_1 = {
    Text = "순수 피해 면역"
  },
  Skill_143495_Desc_1 = {
    Text = "능동 피해를 면역합니다. 두 번째 발동 시 해제됩니다."
  },
  Skill_143495_Name_1 = {
    Text = "능동 피해 면역"
  },
  Skill_143556_Desc = {
    Text = "악몽 감금 테스트"
  },
  Skill_143556_Name = {
    Text = "악몽 감금 테스트"
  },
  Skill_143557_Desc_0 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1]pt 감소시키고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가한다."
  },
  Skill_143557_Desc_3 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1]pt 감소시키고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가한다. <RippleKeywords:여파>: 행동력 소모 -1."
  },
  Skill_143557_Name = {
    Text = "교란의 건트"
  },
  Skill_143557_tempName_1 = {
    Text = "교란의 건트"
  },
  Skill_143557_tempName_2 = {
    Text = "쌍생·교란의 건트"
  },
  Skill_143558_BattleDesc_0 = {
    Text = "HP가 가장 낮은 적에게 촉수 피해의 [Arg1]%에 해당하는 <RealDamage:잠금 피해>( [Arg2] )를 입히고, 폰토스의 기본 크리티컬 피해의 [Arg3]%에 해당하는 임시 크리티컬 피해( [Arg4]％ )를 획득한다."
  },
  Skill_143558_BattleDesc_3 = {
    Text = "HP가 가장 낮은 적에게 촉수 피해의 [Arg1]%에 해당하는 <RealDamage:잠금 피해>( [Arg2] )를 입히고, 폰토스의 기본 크리티컬 피해의 [Arg3]%에 해당하는 임시 크리티컬 피해( [Arg4]％ )를 획득한다. <RippleKeywords:여파>: 행동력 소모 -1."
  },
  Skill_143558_Desc_0 = {
    Text = "HP가 가장 낮은 적에게 촉수 피해의 [Arg5]％에 해당하는 <RealDamage:잠금 피해>를 입히고, 폰토스의 기본 크리티컬 피해의 [Arg3]%에 해당하는 임시 크리티컬 피해를 획득한다."
  },
  Skill_143558_Desc_3 = {
    Text = "HP가 가장 낮은 적에게 촉수 피해의 [Arg5]％에 해당하는 <RealDamage:잠금 피해>를 입히고, 폰토스의 기본 크리티컬 피해의 [Arg3]%에 해당하는 임시 크리티컬 피해를 획득한다. <RippleKeywords:여파>: 행동력 소모 -1."
  },
  Skill_143558_Name = {
    Text = "사냥의 건트"
  },
  Skill_143558_tempName_1 = {
    Text = "사냥의 건트"
  },
  Skill_143558_tempName_2 = {
    Text = "쌍생·사냥의 건트"
  },
  Skill_143559_Desc_0 = {
    Text = "<DerivativeCardKeywords_4:「영감」> 1장을 덱에 섞어놓고, 다른 깨어남체가 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_143559_Desc_3 = {
    Text = "<DerivativeCardKeywords_4:「영감」> 1장을 덱에 섞어놓고, 다른 깨어남체가 광기 <Energy:[Energy:Arg2]>pt를 획득한다. <RippleKeywords:여파>: 행동력 소모 -1."
  },
  Skill_143559_Name = {
    Text = "약식의 건트"
  },
  Skill_143559_tempName_1 = {
    Text = "약식의 건트"
  },
  Skill_143559_tempName_2 = {
    Text = "쌍생·약식의 건트"
  },
  Skill_143604_Desc = {
    Text = "임시 크리티컬 피해를 [Arg1]% 증가시키고, 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Arg2]pt 감소한다. 폰토스가 파티에 있으면 <BattueKeywords:사냥> 1스택을 획득한다."
  },
  Skill_143604_Name = {
    Text = "마음이 허한 사람"
  },
  Skill_143686_Desc = {
    Text = "건트 테스트2"
  },
  Skill_143686_Name = {
    Text = "건트 테스트2"
  },
  Skill_143687_Desc = {
    Text = "플레이어에게 허약이 없으면 카드 면은 일반 배아, 있으면 성태"
  },
  Skill_143687_Name = {
    Text = "카드 조건 표현식 테스트"
  },
  Skill_144438_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 아군이 사망할 때, 자신이 <Energy:[Energy:Arg1]> 광기를 획득합니다. 아군이 소생할 때, 해당 아군이 <Energy:[Energy:Arg2]> 광기를 획득합니다. 광기 획득 효과는 대상의 광기가 가득 차지 않았을 때만 발동되며, 최대 [Arg8]회 발동 후 해당 명륜을 파괴합니다."
  },
  Skill_144438_Name_1 = {
    Text = "영혼의 동조"
  },
  Skill_144486_AwakerSkillBackgroundStory = {
    Text = "요정과 마법사는 어느 작은 마을 구석에 있는 황무지에서 만났다.\n그때의 그녀는 호화로운 옷차림을 한 이방의 아이들을 미소 지으며 불러모으고 있었고, 마법사는 그 아이들의 어머니 손목에서 딸랑거리는 금팔찌를 눈여겨보고 있었다.\n두 사람의 시선이 허공에서 마주치자, 순간 의도를 서로 꿰뚫어 보았다.\n이 침묵의 대결에서는 결국 마법사가 한 수 위였고, 노련한 경험을 통해 간신히 승리를 거머쥐게 되었다.\n그리고, 이렇게 해서 속고 또 속이는 아름다운 새 사업의 막이 올랐다."
  },
  Skill_144486_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:포식>: <WormGrowth1:과식> 1 스택 획득. 피해를 줄 때마다 대상에게 [Corrosion:Arg10] 포인트 <Corrosion:침식> 부여.】손에 있는 모든 카드의 <BurningKeywords2:연소> 상태를 제거합니다. <Block:[Block:Arg2]> 포인트 방어막 획득. 모든 적에게 <Damage:[Damage:Arg1]> 포인트 피해를 [Arg8] 회 줍니다. <WormGrowth1:과식> 1 스택마다 광기 폭발 기본 피해와 방어막이 [Arg6]% 증가합니다. 모든 <SacrificialMark1:봉헌>을 소비하며, 스택마다 피해 횟수 +1, <WormGrowth1:과식> 획득. 현재 <WormGrowth1:과식> 스택: [Arg9], 이번 전투 누적 스택: [Arg11]"
  },
  Skill_144486_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:포식>: <WormGrowth2:과식> 1 스택 획득, 피해를 줄 때마다 대상에게 [Corrosion:Arg10] 포인트 <Corrosion:침식> 부여.】손에 있는 모든 카드의 <BurningKeywords2:연소> 상태를 제거합니다. <Block:[Block:Arg2]> 포인트 방어막 획득. 모든 적에게 <Damage:[Damage:Arg1]> 포인트 피해를 [Arg8] 회 줍니다. <WormGrowth2:과식> 1 스택마다 광기 폭발 기본 피해와 방어막이 [Arg6]% 증가합니다. 모든 <SacrificialMark1:봉헌>을 소비하며, 스택마다 피해 횟수 +1, <WormGrowth2:과식> 획득. 현재 <WormGrowth2:과식> 스택: [Arg9], 이번 전투 누적 스택: [Arg11]"
  },
  Skill_144486_Desc_0 = {
    Text = "【<DevouredIconKeywords:포식>: <WormGrowth1:과식> 1층을 획득합니다. 피해를 입힐 때마다 대상에게 [Corrosion:Arg10] 점 <Corrosion:침식>을 부여합니다.】손에 든 모든 카드의 <BurningKeywords2:연소> 상태를 해제합니다. <Block:[Block:Arg2]> 점 방어막을 획득합니다. 모든 적에게 <Damage:[Damage:Arg1]> 점 피해를 [Arg8]회 입힙니다. <WormGrowth1:과식> 1층마다 광기 폭발 기본 피해와 방어막이 [Arg6]% 증가합니다. 모든 <SacrificialMark1:봉헌>을 소모하며, 층마다 피해 횟수 +1을 부여하고 <WormGrowth1:과식>을 획득합니다."
  },
  Skill_144486_Desc_3 = {
    Text = "【<DevouredIconKeywords:포식>: <WormGrowth2:과식> 1층을 획득하며, 피해를 입힐 때마다 대상에게 [Corrosion:Arg10] 점 <Corrosion:침식>을 부여합니다.】손에 든 모든 카드의 <BurningKeywords2:연소> 상태를 해제합니다. <Block:[Block:Arg2]> 점 방어막을 획득합니다. 모든 적에게 <Damage:[Damage:Arg1]> 점 피해를 [Arg8]회 입힙니다. <WormGrowth2:과식> 1층마다 광기 폭발 기본 피해와 방어막이 [Arg6]% 증가합니다. 모든 <SacrificialMark1:봉헌>을 소모하며, 층마다 피해 횟수 +1을 부여하고 <WormGrowth2:과식>을 획득합니다."
  },
  Skill_144486_EffectNameList = {
    Text = "방어막,피해,포식 침식"
  },
  Skill_144486_Name = {
    Text = "짜잔★요정님 등장!"
  },
  Skill_144486_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:포식>: <WormGrowth2:과식> 1 스택 획득. 피해를 줄 때마다 대상에게 [Corrosion:Arg10] 포인트 <Corrosion:침식> 부여】손에 있는 모든 카드의 <BurningKeywords2:연소> 상태를 제거합니다. <Block:[Block:Arg2]> 포인트 방어막 획득. 모든 적에게 <Damage:[Damage:Arg1]> 포인트 피해를 [Arg8] 회 줍니다. <WormGrowth2:과식> 1 스택마다 광기 폭발 기본 피해와 방어막이 [Arg6]% 증가합니다. 모든 <SacrificialMark1:봉헌>을 소비하며, 스택마다 피해 횟수 +1, <WormGrowth2:과식> 획득. <FaxianKeywords:발견> 2 그룹 <Blessing:선물>이 다른 <DerivativeCardKeywords_152:「축복」>, 각 그룹에 2 장 포함, 1 그룹을 선택해 손에 넣습니다.  모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg12] 포인트 영구 감소시킵니다. 현재 <WormGrowth2:과식> 스택: [Arg9]. 이번 전투 누적 스택: [Arg11]"
  },
  Skill_144486_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_144487_AwakerSkillBackgroundStory = {
    Text = "눈이 내리기 직전의 맑은 밤마다, 카라부는 굴뚝 곁에 올라가 흐릿한 하늘을 조용히 바라보곤 했다.\n마법봉을 하늘로 겨누며, 그녀는 자신이 직접 만든 주문을 그려냈다.\n그리고 흩날리는 눈가루가 그녀를 다시금 영혼을 내맡긴 함박눈이 내리던 밤의 품으로 데려갔다.\n\n「봐, 이게 내 마법이야.」"
  },
  Skill_144487_Desc_0 = {
    Text = "HP가 가장 높은 적에게 [Arg1] 포인트 <RealDamage:고정 피해>를 줍니다. [Arg2] 라운드 <WeaknessIconKeywords:허약> 부여."
  },
  Skill_144487_Desc_1 = {
    Text = "HP가 가장 높은 적에게 [Arg1] 포인트 <RealDamage:고정 피해>를 줍니다. [Arg2] 라운드 <WeaknessIconKeywords:허약> 부여. <Energy:[Energy:Arg3]> 포인트 광기 획득."
  },
  Skill_144487_EffectNameList = {Text = "피해"},
  Skill_144487_Name = {
    Text = "흩날리는 눈의 저주"
  },
  Skill_144487_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_144487_tempBattleDesc_1 = {
    Text = "HP가 가장 높은 적에게 [Arg1] 포인트 <RealDamage:고정 피해>를 [Arg4] 회 줍니다. [Arg2] 라운드 <WeaknessIconKeywords:허약> 부여."
  },
  Skill_144487_tempBattleDesc_2 = {
    Text = "HP가 가장 높은 적에게 [Arg1] 포인트 <RealDamage:고정 피해>를 [Arg4] 회 줍니다. [Arg2] 라운드 <WeaknessIconKeywords:허약> 부여. <Energy:[Energy:Arg3]> 포인트 광기 획득."
  },
  Skill_144487_tempBattleDesc_3 = {
    Text = "모든 적에게 [Arg1] 포인트 <RealDamage:고정 피해>를 [Arg4] 회 주고 [Arg2] 라운드 <WeaknessIconKeywords:허약>을 부여합니다."
  },
  Skill_144487_tempBattleDesc_4 = {
    Text = "전체 적에게 [Arg1] 점 <RealDamage:고정 피해>를 [Arg4] 회 가하고 [Arg2] 턴 <WeaknessIconKeywords:허약>을 부여합니다. <Energy:[Energy:Arg3]> 점 광기를 획득합니다."
  },
  Skill_144488_AwakerSkillBackgroundStory = {
    Text = "「이 요정님이 널 감싸줄게! 최강 방어 마법은 모든 공격이든 막아낼 수 있으니까!」"
  },
  Skill_144488_BattleDesc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_144488_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 점 방어막을 획득합니다. <Energy:[Energy:Arg2]> 점 광기를 획득합니다. 매 [Arg3] / 7 번째로 「타격」 또는 「방어」 사용 시, 1 층 <SacrificialMark1:봉헌>을 획득하고 <FaxianKeywords:발견>한 [Arg4] 장의 <BlessingNegativeEffect:대가>가 서로 다른 <DerivativeCardKeywords_152:「축복」> 중 1 장을 선택해 손에 넣습니다."
  },
  Skill_144488_Desc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 카라부가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_144488_Desc_2 = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 카라부가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_144488_EffectNameList = {
    Text = "방어막, 광기"
  },
  Skill_144488_Name = {Text = "방어"},
  Skill_144488_PropertyNameList = {
    Text = "방어력* GrowValue1,$GrowValue2"
  },
  Skill_144489_BattleDesc = {
    Text = "[Arg1] 점 행동력을 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_144489_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_144489_Name = {
    Text = "바로 내려지는 축복·행동력"
  },
  Skill_144490_AwakerSkillBackgroundStory = {
    Text = "「이 요정님이 나서는 거야! 최강 공격 마법은 모든 방어막을 깨부실타래 수 있다구!」"
  },
  Skill_144490_BattleDesc_0 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_144490_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 입힙니다. <Energy:[Energy:Arg2]> 점 광기를 획득합니다. 매 [Arg3] / 7 번째로 「타격」 또는 「방어」 사용 시, 1 층 <SacrificialMark1:봉헌>을 획득하고 <FaxianKeywords:발견>한 [Arg4] 장의 <BlessingNegativeEffect:대가>가 서로 다른 <DerivativeCardKeywords_152:「축복」> 중 1 장을 선택해 손에 넣습니다."
  },
  Skill_144490_Desc_0 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 카라부가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_144490_Desc_2 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 카라부가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_144490_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_144490_Name = {Text = "타격"},
  Skill_144490_PropertyNameList = {
    Text = "공격력* GrowValue1,$GrowValue2"
  },
  Skill_144491_AwakerSkillBackgroundStory = {
    Text = "탐욕은 인간 본성의 참빛깔이다.\n누구도 달콤함의 유혹을 뿌리칠 순 없다, 그건 요정 대모인 자신조차도 예외는 아니니까.\n카라부가 입을 크게 벌려 웃으며, 새까맣고 뾰족한 이빨을 드러냈다."
  },
  Skill_144491_BattleDesc_0 = {
    Text = "카라부가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 「진홍빛 용광로」 사용 후, 다음 「기적의 축복」의 행동력 소비 -3, 각 <FaxianKeywords:발견> 선택지에 <DerivativeCardKeywords_152:「축복」> 1 장이 추가로 포함되며, 1 세트를 선택해 드로우 덱에 넣습니다."
  },
  Skill_144491_BattleDesc_15 = {
    Text = "카라부가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 「진홍빛 용광로」 사용 후, 다음 「기적의 축복」의 행동력 소비 -3, 각 <FaxianKeywords:발견> 선택지에 <DerivativeCardKeywords_152:「축복」> 2 장이 추가로 포함되며, 1 세트를 선택해 드로우 덱에 넣습니다. 「축복」 사용 후, 배아 융합 +10, 현재 HP가 낮을수록 효과가 높아지며, 최대 100% 증가합니다."
  },
  Skill_144491_Desc_0 = {
    Text = "카라부가 [Arg2]% 기초 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 「진홍빛 용광로」 사용 후, 다음 「기적의 축복」의 행동력 소비 -3, 각 <FaxianKeywords:발견> 선택지에 <DerivativeCardKeywords_152:「축복」> 1 장이 추가로 포함되며, 1 세트를 선택해 드로우 덱에 넣습니다."
  },
  Skill_144491_Desc_15 = {
    Text = "카라부가 [Arg2]% 기초 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 「진홍빛 용광로」 사용 후, 다음 「기적의 축복」의 행동력 소비 -3, 각 <FaxianKeywords:발견> 선택지에 <DerivativeCardKeywords_152:「축복」> 2 장이 추가로 포함되며, 1 세트를 선택해 드로우 덱에 넣습니다. <Blessing:축복> 사용 후, 배아 융합 +10, 현재 HP가 낮을수록 효과가 높아지며, 최대 100% 증가합니다."
  },
  Skill_144491_EffectNameList = {Text = "광기"},
  Skill_144491_Name = {
    Text = "유혹하는 달콤한 열매"
  },
  Skill_144492_AwakerSkillBackgroundStory = {
    Text = "「끝없는 보물을 원해?」\n「무한한 권력을 원하는 걸까?」\n「죽은 자를 되살리는 만병통솔약을 원해?」\n「사람의 마음을 꿰뚫는 수정구슬을 원하나?」\n「사랑하는 이를 되돌려놓을 부적은?」\n「모든 질문에 답해주는 마법의 거울은 어때?」\n「모든 욕망을 바로 충족시켜주는 달콤한 열매가 필요하지?」\n\n무슨 소원이든, 여기엔 모두 다 있어!\n자, 진심을 보여줘. 이 요정 대모에게 제물을 바치라구!\n기적이 내려올 거야. 3초만 기다려 줘 ♪\n\n3, 2, 1—— 사실타래 뻥이야, 정말 미안해!"
  },
  Skill_144492_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> [Arg2] 장 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, [Arg3] 장을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144492_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> [Arg2] 장 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, [Arg3] 장을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144492_EffectNameList = {
    Text = "방어막,힘,힘 임시 감소,고정 광기,은열쇠 에너지,임시 피해 증폭"
  },
  Skill_144492_Name = {
    Text = "기적의 축복"
  },
  Skill_144492_PropertyNameList = {
    Text = "방어력*GrowValue1,공격력*GrowValue2,방어력*GrowValue3,$GrowValue4,$GrowValue5,$GrowValue6%"
  },
  Skill_144492_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> [Arg2] 장 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, [Arg3] 장을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144492_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> 2 그룹 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, 각 그룹에 2 장 포함, 1 그룹을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144492_tempBattleDesc_3 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> 3 그룹 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, 각 그룹에 2 장 포함, 1 그룹을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144492_tempBattleDesc_4 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> 2 그룹 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, 각 그룹에 3 장 포함, 1 그룹을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144492_tempBattleDesc_5 = {
    Text = "<Block:[Block:Arg1]> 포인트 방어막 획득. <FaxianKeywords:발견> 3 그룹 <BlessingNegativeEffect:대가>가 다른 <DerivativeCardKeywords_152:「축복」>, 각 그룹에 3 장 포함, 1 그룹을 선택해 드로우 덱에 넣습니다."
  },
  Skill_144512_Name = {
    Text = "테스트 제목명2"
  },
  Skill_144513_Name = {
    Text = "테스트 제목명3"
  },
  Skill_144514_Desc = {
    Text = "사용 후 은열쇠 패키지 3개 중 1개를 선택합니다. 각 패키지에는 은열쇠 3개가 포함되어 있습니다. 선택 후 순서대로 즉시 발동합니다."
  },
  Skill_144514_Name = {
    Text = "은열쇠 패키지 3개 중 1개 선택"
  },
  Skill_144515_Name = {
    Text = "테스트 제목명1"
  },
  Skill_145386_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [Arg2] 스택의 <EnergyStorageKeywords:충전>을 얻고, 「타격」 피해 증가 [Arg1]% 및 <PVPPunctureDamagewords:관통 피해>로 변경된다."
  },
  Skill_145386_Name_1 = {
    Text = "하늘의 추락"
  },
  Skill_145387_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」 피해 증가 [Arg1]%, 매 「타격」 후 피해가 추가로 [Arg2]% 증가하며, 최대 [Arg3]%까지 증가합니다."
  },
  Skill_145387_Name_1 = {
    Text = "불멸의 곯은 뼈"
  },
  Skill_145439_BattleDesc = {
    Text = "행동력 1점을 획득합니다. 보존: <Green:[Arg1]> 점 고정 HP 회복량과 <Yellow:[Arg2]> 점 고정 광기를 축적합니다(현재 <Green:[Arg3]> HP 회복량, <Yellow:[Arg4]> 점 광기 축적됨). 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145439_Desc = {
    Text = "행동력 1점을 획득합니다. 보존: 장착자 체력의 5%에 해당하는 고정 HP 회복량과 고정 광기 3점을 이 카드에 축적합니다. 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145439_Name = {
    Text = "영혼의 동조"
  },
  Skill_145440_BattleDesc = {
    Text = "행동력 1점을 획득합니다. 보존: <Green:[Arg1]> 점 고정 HP 회복량과 <Yellow:[Arg2]> 점 고정 광기를 축적합니다(현재 <Green:[Arg3]> HP 회복량, <Yellow:[Arg4]> 점 광기 축적됨). 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145440_Desc = {
    Text = "행동력 1점을 획득합니다. 보존: 장착자 체력의 6%에 해당하는 고정 HP 회복량과 고정 광기 4점을 이 카드에 축적합니다. 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145440_Name = {
    Text = "영혼의 동조"
  },
  Skill_145441_BattleDesc = {
    Text = "행동력 1점을 획득합니다. 보존: <Green:[Arg1]> 점 고정 HP 회복량과 <Yellow:[Arg2]> 점 고정 광기를 축적합니다(현재 <Green:[Arg3]> HP 회복량, <Yellow:[Arg4]> 점 광기 축적됨). 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145441_Desc = {
    Text = "행동력 1점을 획득합니다. 보존: 장착자 체력의 4%에 해당하는 고정 HP 회복량과 고정 광기 2점을 이 카드에 축적합니다. 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145441_Name = {
    Text = "영혼의 동조"
  },
  Skill_145442_BattleDesc = {
    Text = "행동력 1점을 획득합니다. 보존: <Green:[Arg1]> 점 고정 HP 회복량과 <Yellow:[Arg2]> 점 고정 광기를 축적합니다(현재 <Green:[Arg3]> HP 회복량, <Yellow:[Arg4]> 점 광기 축적됨). 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145442_Desc = {
    Text = "행동력 1점을 획득합니다. 보존: 장착자 체력의 3%에 해당하는 고정 HP 회복량과 고정 광기 1점을 이 카드에 축적합니다. 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 파괴합니다."
  },
  Skill_145442_Name = {
    Text = "영혼의 동조"
  },
  Skill_145536_BattleDesc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145536_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145536_Name = {
    Text = "바로 내려지는 축복·은열쇠 에너지"
  },
  Skill_145537_BattleDesc = {
    Text = "모든 각성체가 <Yellow:[Arg1]> 점 고정 광기를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145537_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145537_Name = {
    Text = "바로 내려지는 축복·광기"
  },
  Skill_145538_BattleDesc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145538_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145538_Name = {
    Text = "바로 내려지는 축복·피해 증폭"
  },
  Skill_145539_BattleDesc = {
    Text = "카드를 [Arg1] 장 드로우합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145539_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145539_Name = {
    Text = "바로 내려지는 축복·드로우"
  },
  Skill_145540_BattleDesc = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145540_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145540_Name = {
    Text = "바로 내려지는 축복·힘"
  },
  Skill_145541_BattleDesc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시로 감소시킵니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145541_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_145541_Name = {
    Text = "바로 내려지는 축복·고갈"
  },
  Skill_145557_Desc_1 = {
    Text = "앞줄 적에게 <Damage:[Damage:Arg1]> 피해를 입히고 피해의 절반만큼 HP를 회복하며, 「타격」으로 간주합니다."
  },
  Skill_145557_Name_1 = {
    Text = "삼켜진 검"
  },
  Skill_145558_Desc_1 = {
    Text = "전방의 적에게 피해를 <Damage:[Damage:Arg1]> 주고, 광기를 <Energy:[Energy:Arg2]> 획득한다."
  },
  Skill_145558_Name_1 = {Text = "타격"},
  Skill_145559_Desc_1 = {
    Text = "전방의 적에게  <PVPPunctureDamagewords:관통 피해>를 <Damage:[Damage:Arg1]> 입히고, 적을 처치하면 <PVPPowerIconKeywords:힘>을 [Arg2] 획득한다."
  },
  Skill_145559_Name_1 = {
    Text = "낙하한 고래의 귀환"
  },
  Skill_145560_Desc_1 = {
    Text = "적 전체에게 피해를  <Damage:[Damage:Arg1]> 입히고, 임시로 <PVPPowerIconKeywords:힘>을 [Arg2] 빼앗으며, HP를 [Arg3] 잃는다."
  },
  Skill_145560_Name_1 = {
    Text = "추락하는 칼날"
  },
  Skill_145561_Desc_1 = {
    Text = "대상 아군을 제외한 모든 깨어남체에게 <Damage:[Damage:Arg1]> <PVPPunctureDamagewords:관통 피해>를 줍니다. 이후 매 턴 시작 시 이 효과를 반복합니다."
  },
  Skill_145561_Name_1 = {
    Text = "고래를 삼킨 폭풍"
  },
  Skill_145561_UnknownName = {
    Text = "고래를 삼킨 폭풍"
  },
  Skill_145562_Desc_1 = {
    Text = "적 한 명을 선택해 쌍방 <PVPLock:잠금> 상태로 만들고, 대상에게 피해를 <Damage:[Damage:Arg1]> 입힌다. 대상이 <PVPLock:잠금> 상태에서 사망할 시 해당 카드는 손으로 돌아온다. <PVPFusion:융합>: 피해가 [Arg2] 증가한다."
  },
  Skill_145562_Name_1 = {
    Text = "결투의 계약"
  },
  Skill_145612_Desc = {
    Text = "축복은 행동력 소비 1, <RetainIconKeywords:보존>, <PrepareKeypvewords:예비>, <DepleteIconKeywords:소모>를 가진 강화 카드입니다.\n사용 시 <BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다. 「축복」에는 3가지 종류가 있습니다:\n「바로 내려지는 축복」: 「놓쳐진 기회」를 발동하지 않습니다.\n「호화로운 축복」: 「허풍」을 발동하지 않습니다.\n「따뜻한 축복」: 「은폐된 살의」를 발동하지 않습니다."
  },
  Skill_145612_Name = {Text = "축복"},
  Skill_145664_Desc = {
    Text = "공식에 따라 [Poison:Arg1] 중독, [Counterattack:Arg2] 반격, [Power:Arg3] 힘, [Exhaustion:Arg4] 고갈, [TentaclePower:Arg5] 촉수 피해, [FateCut:Arg6] 운명 재단, [Corrosion:Arg7] 침식을 추가합니다."
  },
  Skill_145664_Name = {
    Text = "공식에 따라 상태 추가"
  },
  Skill_145673_AwakerSkillBackgroundStory = {
    Text = "「보이나요? 당신의 칼날 아래 그들의 살과 피부가 어떻게 터져 나와, 찬란한 핏꽃을 피워냈는지.」\n「눈을 감으면 존재하지 않는다고 망상하지 마세요, 사랑하는 아이여.」\n「당신은 알고 있어요, 당신은 잘 알고 있어요.」\n「당신이 갈고닦은 기예는, 이미 오래전에 죽음의 빛깔에 물들어, 타인에게 다음 재앙을 불러올 뿐이에요.」"
  },
  Skill_145673_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> 점의 피해를 입힙니다. <Energy:[Energy:Arg2]> 점의 광기를 획득합니다."
  },
  Skill_145673_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 2회 입힙니다. <Energy:[Energy:Arg2]> 점 광기를 획득합니다."
  },
  Skill_145673_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 입힙니다. 부서약·오지에가 <Energy:[Energy:Arg2]> 점 광기를 획득합니다."
  },
  Skill_145673_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 2회 입힙니다. 부서약·오지에가 <Energy:[Energy:Arg2]> 점 광기를 획득합니다."
  },
  Skill_145673_EffectNameList = {
    Text = "데미지,광기"
  },
  Skill_145673_Name = {Text = "타격"},
  Skill_145673_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_145674_AwakerSkillBackgroundStory = {
    Text = "「들리나요? 그들의 울부짖음이 어떻게 모든 구석에 울려 퍼졌는지, 그러나 아무도 그들을 위해 조금의 피난처조차 마련해주지 않았어요.」\n「귀를 막으면 외면할 수 있다고 생각하지 마세요, 무능한 기사여.」\n「당신은 직접 겪었고, 당신은 선택했어요.」\n「적의 물결이 밀려왔을 때, 당신은 갑옷을 벗어던지고, 그들이 당신이 가장 사랑하는 땅을 유린하도록 내버려 두었어요.」"
  },
  Skill_145674_BattleDesc = {
    Text = "<Block:[Block:Arg1]> 점의 방어막을 획득했습니다. <Energy:[Energy:Arg2]> 점의 광기를 획득했습니다."
  },
  Skill_145674_Desc = {
    Text = "<Block:[Block:Arg3]> 점 방어막을 획득합니다. 부서약·오지에가 <Energy:[Energy:Arg2]> 점 광기를 획득합니다."
  },
  Skill_145674_EffectNameList = {
    Text = "방어막, 광기"
  },
  Skill_145674_Name = {Text = "방어"},
  Skill_145674_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_145675_AwakerSkillBackgroundStory = {
    Text = "사실, 오지에는 이미 오래전에 그 성의 진짜 모습을 잊어버렸다.\n하지만 지금, 그는 마음속 깊은 곳의 소망에 기대어 새로운 방벽을 쌓을 수 있다.\n만약 그의 수호 아래, 여전히 사람들의 웃음소리를 들을 수 있고, 익숙한 꽃들이 다시 들판에 가득 피어난다면......\n그렇다면, 이미 오래전에 변이된 그 심장도, 이 세상에 남아 있을 의미가 있을 것이다."
  },
  Skill_145675_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> 점 방어막 획득, [Power:Arg2] 점 <PowerIconKeywords:힘> 획득, 모든 <KuangNu:암용> 소모, 1층 소모할 때마다 부여하는 방어막과 힘 33% 증가, 1층 <ShuZui:자죄> 획득."
  },
  Skill_145675_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]> 점 방어막 획득, [Power:Arg2] 점 <PowerIconKeywords:힘> 획득, 모든 <KuangNu2:암용> 소모, 1층 소모할 때마다 부여하는 방어막과 힘 50% 증가, 1층 <ShuZui:자죄> 획득."
  },
  Skill_145675_Desc_0 = {
    Text = "<Block:[Block:Arg3]> 점 방어막을 획득하고, [Power:Arg4] 점 <PowerIconKeywords:힘>을 획득합니다. 모든 <KuangNu:암류>를 소모하며, 1층 소모할 때마다 부여되는 방어막과 힘이 33% 증가하고, <ShuZui:자책> 1층을 획득합니다."
  },
  Skill_145675_Desc_3 = {
    Text = "<Block:[Block:Arg3]> 점 방어막을 획득하고, [Power:Arg4] 점 <PowerIconKeywords:힘>을 획득합니다. 모든 <KuangNu2:암류>를 소모하며, 1층 소모할 때마다 부여되는 방어막과 힘이 50% 증가하고, <ShuZui:자책> 1층을 획득합니다."
  },
  Skill_145675_EffectNameList = {
    Text = "실타래드, 힘"
  },
  Skill_145675_Name = {
    Text = "꺼지지 않는 기사의 마음"
  },
  Skill_145675_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 점 방어막 획득, [Power:Arg5] 점 <PowerIconKeywords:힘> 획득, 모든 <KuangNu:암용> 소모, 1층 소모할 때마다 부여하는 방어막과 힘 33% 증가, 1층 <ShuZui:자죄> 획득."
  },
  Skill_145675_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]> 점 방어막 획득, [Power:Arg5] 점 <PowerIconKeywords:힘> 획득, 모든 <KuangNu2:암용> 소모, 1층 소모할 때마다 부여하는 방어막과 힘 50% 증가, 1층 <ShuZui:자죄> 획득."
  },
  Skill_145675_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_145676_AwakerSkillBackgroundStory = {
    Text = "모든 기사가 서임 선서를 할 때, 몸에 지닌 병기에도 똑같이 영광이 깃들었다.\n하지만 그에게 속했던 최초의, 신성한 사명을 부여받은 그 은창은, 이미 전화의 잿더미 속에 녹아 사라졌다.\n그러나, 이미 죄를 진 몸이라면, 이 죄악의 검은 오물을 새로운 무기로 삼는 것도 나쁘지 않다고 그는 생각했다. 그렇게 하면, 더 많은 피를 묻히더라도, 더 이상 옛 사람들에게 수치를 안기지 않을 것이라고."
  },
  Skill_145676_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 주고, [Arg2]% 힘 보너스 적용, 1층 <KuangNu:암용> 획득."
  },
  Skill_145676_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 주고, [Arg2]% 힘 보너스 적용, 1층 <KuangNu:암용> 획득."
  },
  Skill_145676_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 주고, 300% 힘 보너스 적용, 1층 <KuangNu:암용> 획득."
  },
  Skill_145676_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 주고, 300% 힘 보너스 적용, 1층 <KuangNu:암용> 획득."
  },
  Skill_145676_EffectNameList = {Text = "피해"},
  Skill_145676_Name = {
    Text = "염죄창봉"
  },
  Skill_145676_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_145677_AwakerSkillBackgroundStory = {
    Text = "한때, 소년은 이 사악한 검은 오물을 자신의 몸에서 떼어내려 시도했지만, 무엇을 해도— 손으로 뜯고, 날카로운 도구로 자르고, 둔기로 두드려도...... 형체 없는 악몽은 언제나 사라지지 않았고, 오히려 점점 더 기세를 부렸다.\n결국, 그는 마침내 인정했다. 그와 그것은 이미 완전히 하나로 합쳐져, 서로를 구분할 수 없다는 것을.\n그것은 그의 그림자가 되었다."
  },
  Skill_145677_BattleDesc_0 = {
    Text = "부서약·오지에가 <Energy:[Energy:Arg1]> 점 광기 획득. <ExaltIconKeywords:영지 각성>: 부서약·오지에가 매 턴 첫 번째 「염죄창봉」으로 피해를 줄 때 동일한 양의 <Corrosion:침식> 부여. 「방어」의 보호막 증가 50%, 카드 1장 드로우."
  },
  Skill_145677_BattleDesc_15 = {
    Text = "부서약·오지에가 <Energy:[Energy:Arg1]> 점 광기 획득. <ExaltIconKeywords:영지 각성>: 부서약·오지에가 매 턴 첫 번째 「염죄창봉」으로 피해를 줄 때 동일한 양의 <Corrosion:침식> 부여. 「염죄창봉」의 기본 피해 100% 증가, 추가로 200% 힘 보너스 적용. 「방어」의 보호막 증가 100%, 카드 1장 드로우."
  },
  Skill_145677_Desc_0 = {
    Text = "부서약·오지에가 [Arg2]% 광기 최대치 획득. <ExaltIconKeywords:영지 각성>: 부서약·오지에가 매 턴 첫 번째 「염죄창봉」으로 피해를 줄 때 동일한 양의 <Corrosion:침식> 부여. 「방어」의 보호막 증가 50%, 카드 1장 드로우."
  },
  Skill_145677_Desc_15 = {
    Text = "부서약·오지에가 [Arg2]% 광기 최대치 획득. <ExaltIconKeywords:영지 각성>: 부서약·오지에가 매 턴 첫 번째 「염죄창봉」으로 피해를 줄 때 동일한 양의 <Corrosion:침식> 부여. 「염죄창봉」의 기본 피해 100% 증가, 추가로 200% 힘 보너스 적용. 「방어」의 보호막 증가 100%, 카드 1장 드로우."
  },
  Skill_145677_EffectNameList = {Text = "광기"},
  Skill_145677_Name = {
    Text = "흑소와의 공생"
  },
  Skill_145678_AwakerSkillBackgroundStory = {
    Text = "미사그의 정기 검사 중, 연구원들은 이 형체 없는 칠흑의 물체에 대해 전문적인 연구를 진행했다.\n예상 밖으로, 그들은 실제로 그 안에서 일부 물질 성분을 추출해냈고, 이에 서둘러 두 번째 실험을 진행했지만, 얻은 결과는 또 전혀 달랐다.\n마치 그것이 드러내는 무정형의 특성과 서로 호응하듯, 그것을 구성하는 성분도 매 순간 변화하며, 마치 허무맹랑한 환영과도 같았다.\n형체 없는 것의 근원은 곧 형체가 없음이다."
  },
  Skill_145678_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시키고, [Power:Arg2] 점 <PowerIconKeywords:힘> 획득. 추가로 Ⅹ회 발동. Ⅹ는 최대 5."
  },
  Skill_145678_EffectNameList = {
    Text = "힘 임시 감소,힘"
  },
  Skill_145678_Name = {
    Text = "끝없는 황야의 그림자"
  },
  Skill_145678_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_145713_Desc = {
    Text = "사용 후, 플레이어의 기본 열쇠의 힘 상한을 읽어 최대 열쇠의 힘을 축적하고 출력합니다."
  },
  Skill_145713_Name = {
    Text = "열쇠의 힘 속성 획득"
  },
  Skill_145971_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 주고, 대상의 현재 HP가 자신보다 많을 경우 양측의 현재 HP를 교환한다."
  },
  Skill_145971_Name_1 = {
    Text = "광기 폭발"
  },
  Skill_145972_Desc_1 = {
    Text = "임의의 대상의 HP를 <Heal:[Heal:Arg1]> 회복하고, 다음 턴 시작 시 소모되지 않은 HP를 제거합니다."
  },
  Skill_145972_Name_1 = {
    Text = "거짓이 아닌 것"
  },
  Skill_145972_UnknownName = {
    Text = "거짓이 아닌 것"
  },
  Skill_145973_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]> 데미지를 주고, <Energy:[Energy:Arg2]> 광기를 획득합니다."
  },
  Skill_145973_Name_1 = {Text = "타격"},
  Skill_145974_Desc_1 = {
    Text = "적 한 명에게 [Arg1] 스택의 <PVPBless:축복>을 부여한다. 자신은 <Damage:[Arg2]> HP를 잃는다."
  },
  Skill_145974_Name_1 = {Text = "스킬 3"},
  Skill_145975_Desc_1 = {
    Text = "<PVPBluff:현혹>으로 적 한 명이 전투 의지를 잃게 만든다. <PVPBluff:현혹> 종료 시 전체 적에게 <Damage:[Damage:Arg1]> 피해를 준다."
  },
  Skill_145975_Name_1 = {Text = "스킬 1"},
  Skill_145976_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 광기를 얻고, <Damage:[Arg2]> HP를 잃는다. <DelayKeywords:지연 1>: [Arg1] 광기를 차감한다."
  },
  Skill_145976_Name_1 = {Text = "스킬 2"},
  Skill_145988_Desc = {
    Text = "임시로 전체 적의 [Arg1] 포인트 <ExhaustionIconKeywords:힘>을 감소시킵니다."
  },
  Skill_145988_Name = {
    Text = "원초의 기억·고갈"
  },
  Skill_145989_Desc = {
    Text = "모든 깨어남체가 <Energy:[Arg1]> 점 광기를 획득합니다."
  },
  Skill_145989_Name = {
    Text = "원초의 기억·촉매"
  },
  Skill_145990_Desc = {
    Text = "<Heal:[Arg1]> 포인트 HP 회복"
  },
  Skill_145990_Name = {
    Text = "원초의 기억·회복"
  },
  Skill_145991_Desc = {
    Text = "모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1]스택 부여한다."
  },
  Skill_145991_Name = {
    Text = "원초의 기억·독소"
  },
  Skill_145992_Desc = {
    Text = "[Arg1] 층 <RetaliateIconKeywords:임시 반격>을 획득합니다."
  },
  Skill_145992_Name = {
    Text = "원초의 기억·첨예한 가시"
  },
  Skill_145993_Desc = {
    Text = "[Arg1] 점<PowerIconKeywords:힘>을 획득했습니다."
  },
  Skill_145993_Name = {
    Text = "원초의 기억·완력"
  },
  Skill_145995_Desc = {
    Text = "<Block:[Arg1]> 점 방어막를 획득합니다."
  },
  Skill_145995_Name = {
    Text = "원초의 기억·철벽"
  },
  Skill_146011_AwakerSkillBackgroundStory = {
    Text = "잔해의 칼날이 그리는 궤적은 언제나 여유롭고 우아하다.\n검 한 번을 허투루 쓰지 않고 진지하게 휘두루는 것, 그게 그녀가 상대와의 전투 그 자체에 바치는 최대의 경의다."
  },
  Skill_146011_BattleDesc_0 = {
    Text = "피해 <Damage:[Damage:Arg1]>pt를 [Arg3]회 입히고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_146011_BattleDesc_2 = {
    Text = "피해 <Damage:[Damage:Arg1]>pt [Arg3]회 입히고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다. 매턴 첫 번째 사용 시 「단검·식」 1장( [Arg4]/1 )을 드로우 한다."
  },
  Skill_146011_Desc_0 = {
    Text = "피해 <Damage:[Damage:Arg1]>pt를 [Arg3]회 입히고, 침식·로탄이 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_146011_Desc_2 = {
    Text = "피해 <Damage:[Damage:Arg1]>pt [Arg3]회 입히고, 침식·로탄이 광기 <Energy:[Energy:Arg2]>pt를 획득한다. 매턴 첫 번째 사용 시 「단검·식」 1장을 드로우 한다."
  },
  Skill_146011_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_146011_Name = {Text = "타격"},
  Skill_146011_PropertyNameList = {
    Text = "공격력*GrowValue1, $GrowValue2"
  },
  Skill_146012_Desc = {
    Text = "사용 불가. 이 카드를 보유 중일 때 모든 적이 입히는 피해가 25% 증가하며, 침식·로탄의 명령 카드가 모두 <DerivativeCardKeywords_154:「침멸」>로 변화하고, 턴 시작 시 <DerivativeCardKeywords_154:「침멸」> 1장을 드로우합니다."
  },
  Skill_146012_Name = {
    Text = "대검·고래 낙하"
  },
  Skill_146013_AwakerSkillBackgroundStory = {
    Text = "아주 드문 때. 아주 드문 때만 로탄은 검을 거두고는 한다.\n그 이색의 눈가 싸늘히 지켜보고 있다. 검을 거두는 건, 언제나 더 나은 일격을 위한 것이기 때문에."
  },
  Skill_146013_BattleDesc_0 = {
    Text = "방어막 <Block:[Block:Arg1]>pt를 획득하고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_146013_BattleDesc_2 = {
    Text = "방어막 <Block:[Block:Arg1]>pt를 획득하고, 광기 <Energy:[Energy:Arg2]>pt를 획득한다. 매턴 첫 번째 사용 시 「장검·낙」 1장( [Arg4]/1 )을 드로우 한다."
  },
  Skill_146013_Desc_0 = {
    Text = "방어막 <Block:[Block:Arg1]>pt를 획득하고, 침식·로탄이 광기 <Energy:[Energy:Arg2]>pt를 획득한다."
  },
  Skill_146013_Desc_2 = {
    Text = "방어막 <Block:[Block:Arg1]>pt를 획득하고, 침식·로탄이 광기 <Energy:[Energy:Arg2]>pt를 획득한다. 매턴 첫 번째 사용 시 「장검·낙」 1장을 드로우 한다."
  },
  Skill_146013_EffectNameList = {
    Text = "방어막, 광기"
  },
  Skill_146013_Name = {Text = "방어"},
  Skill_146013_PropertyNameList = {
    Text = "방어력*GrowValue1, $GrowValue2"
  },
  Skill_146014_AwakerSkillBackgroundStory = {
    Text = "레비아탄의 가장 단단하고 무거운 두개골을 갈아 만든 장검, 그녀는 이를 「낙」이라 이름 붙였다.\n대검이 가로로 휩쓸며 보이는 검날의 호선은 마치 거대한 고래가 꼬리를 흔드는 것처럼 보였으며, 묵직한 잔해가 앞을 가로막는 모든 것을 짓이겼다.\n로탄이 말했다. 「내 신선한 피를 마시고, 생명을 갉아먹어라.\n그리고, 모든 생명들이 네 막을 수 없는 궤적 속에 낙하하도록 만들어라.」"
  },
  Skill_146014_Desc = {
    Text = "「타격」으로 간주한다. 모든 적에게 피해 <Damage:[Damage:Arg1]>pt를 [Arg3]회 입히고, 힘 보너스 [Arg2]%를 적용받는다. 이번 턴에 「타격」을 1장 사용할 때마다, 다음에 사용하는 「장검·낙」의 행동력 소모가 1 감소한다."
  },
  Skill_146014_EffectNameList = {Text = "피해"},
  Skill_146014_Name = {
    Text = "장검·낙"
  },
  Skill_146014_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_146015_AwakerSkillBackgroundStory = {
    Text = "레비아탄은 그녀가 그 검을 쓸어내렸을 때의 모습을 영원히 기억한다.\n그의 영역에서, 자기의 주제도 모르던 작은 형체는 이미 상처투성이로 변해있던 것이다. 인간의 몸은 너무나 나약하여, 거의 한 번의 숨결만으로도 그녀를 다시는 일어서지 못하게 할 수 있었다. 어리석고, 오만하며, 불쌍하게 그지없는 사람—— 이것이 레비아탄이 그녀에게 내린 모든 심판이었다.\n하지만, 심판이 내려지기 직전에 그 작고 나약한 형체가 다시 일어섰다. 그녀의 웃음소리는 그에게 지금까지 느껴본 적 없는 감정을 소용돌이치게 만들었다.\n그는 그녀가 부서진 무기와 만신창이인 몸을 부둥켜앉은 채 높이 도약하는 것을 지켜봤다. 그는 별바다를 베어낼 것만 같은 검의 의지가 자신의 눈앞에 다가오는 것을 보았다.\n그 검이 그를 관통하는 순간, 레비아탄은 깨달았다. 그가 한 번도 경험해 본 적 없던 그 감정의 이름은 바로 공포라는 것을."
  },
  Skill_146015_Desc_0 = {
    Text = "<DerivativeCardKeywords_153:「대검·고래 낙하」>를 보유 시 발동할 수 있다. 피해가 가장 높은 적에게 반드시 크리티컬로 적중하는 피해를 <Damage:[Damage:Arg1]>pt 입히고, 힘 보너스 [Arg2]%를 적용받는다. 대상이 <DerivativeCardKeywords_153:「대검·고래 낙하」>를 통해 피해가 1pt 증가할 때마다 「경계를 베는 검」의 피해가 75 증가한다. <DerivativeCardKeywords_154:>"
  },
  Skill_146015_Desc_3 = {
    Text = "<DerivativeCardKeywords_153:「대검·고래 낙하」>를 보유 시 발동할 수 있다. 피해가 가장 높은 적에게 반드시 크리티컬로 적중하는 피해를 <Damage:[Damage:Arg1]>pt 입히고, 힘 보너스 [Arg2]%를 적용받는다. 대상이 <DerivativeCardKeywords_153:「대검·고래 낙하」>를 통해 피해가 1pt 증가할 때마다 「경계를 베는 검」의 피해가 150 증가한다. <DerivativeCardKeywords_154:>"
  },
  Skill_146015_EffectNameList = {
    Text = "피해, 힘 보너스"
  },
  Skill_146015_Name = {
    Text = "경계를 베는 검"
  },
  Skill_146015_OverLimitUtlSkillDesc = {
    Text = "<DerivativeCardKeywords_153:「대검·고래 낙하」>를 보유 시 발동할 수 있고, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다. 피해가 가장 높은 적에게 반드시 크리티컬로 적중하는 피해를 <Damage:[Damage:Arg1]>pt 입히고, 힘 보너스 [Arg2]%를 적용받는다. 대상이 <DerivativeCardKeywords_153:「대검·고래 낙하」>를 통해 피해가 1pt 증가할 때마다 「경계를 베는 검」의 피해가 150 증가한다. <DerivativeCardKeywords_154:>"
  },
  Skill_146015_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2％"
  },
  Skill_146016_AwakerSkillBackgroundStory = {
    Text = "신명은 그녀의 영혼과 육체를 찢어버리는 것이 혼돈에 대한 궁극의 심판이라 여겼다.\n하지만, 공허한 영혼은 추구하는 것을 멈추지 않았고, 없어진 힘도 진정으로 사라지지 않았다.\n잔해로 만든 갑옷이 다시 그녀의 몸을 덮을 때, 다시 말해 레비아탄의 심장이 다시 그녀의 의지와 공명할 때—— 모든 속박은 그 순간에 산산이 부서져 버린다.\n영혼과 혈육은 별바다 깊은 곳에서 다시 하나로 되어져, 혼돈의 짐승은 이제 완전해졌다.\n이 별바다는, 완전한 그녀를 다시 맞이하게 될 것이다."
  },
  Skill_146016_BattleDesc_0 = {
    Text = "「침식·로탄」이 광기 <Energy:[Energy:Arg1]>pt를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「침식·로탄」 명령 카드 피해 횟수가 1 증가한다. 턴 시작 시 <DerivativeCardKeywords_153:「대검·고래 낙하」>가 손에 있을 경우, 이번 턴 첫 번째 <DerivativeCardKeywords_154:「침멸」>이 광기를 1pt 탈취할 때마다 다음 「경계를 베는 검」의 최종 피해가 1% 증가하며, 이는 최대 90%까지 중첩된다."
  },
  Skill_146016_BattleDesc_15 = {
    Text = "「침식·로탄」이 광기 <Energy:[Energy:Arg1]>pt를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「침식·로탄」 명령 카드 피해 횟수가 1 증가하고, <DerivativeCardKeywords_154:「침멸」>이 탈취하는 광기가 50% 증가한다. 턴 시작 시 <DerivativeCardKeywords_153:「대검·고래 낙하」>가 손에 있을 경우, 이번 턴 첫 번째 <DerivativeCardKeywords_154:「침멸」>이 광기를 1pt 탈취할 때마다 다음 「경계를 베는 검」의 최종 피해가 1.5% 증가하며, 이는 최대 135%까지 중첩된다."
  },
  Skill_146016_Desc_0 = {
    Text = "「침식·로탄」이 광기 최대치의 [Arg2]%를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「침식·로탄」 명령 카드 피해 횟수가 1 증가한다. 턴 시작 시 <DerivativeCardKeywords_153:「대검·고래 낙하」>가 손에 있을 경우, 이번 턴 첫 번째 <DerivativeCardKeywords_154:「침멸」>이 광기를 1pt 탈취할 때마다 다음 「경계를 베는 검」의 최종 피해가 1% 증가하며, 이는 최대 90%까지 중첩된다."
  },
  Skill_146016_Desc_15 = {
    Text = "「침식·로탄」이 광기 최대치의 [Arg2]%를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「침식·로탄」 명령 카드 피해 횟수가 1 증가하고, <DerivativeCardKeywords_154:「침멸」>이 탈취하는 광기가 50% 증가한다. 턴 시작 시 <DerivativeCardKeywords_153:「대검·고래 낙하」>가 손에 있을 경우, 이번 턴 첫 번째 <DerivativeCardKeywords_154:「침멸」>이 광기를 1pt 탈취할 때마다 다음 「경계를 베는 검」의 최종 피해가 1.5% 증가하며, 이는 최대 135%까지 중첩된다."
  },
  Skill_146016_EffectNameList = {Text = "광기"},
  Skill_146016_Name = {
    Text = "고대 근원으로의 회귀"
  },
  Skill_146017_AwakerSkillBackgroundStory = {
    Text = "레비아탄의 가장 날카로운 이빨을 갈아 만든 단검, 그녀는 이를 「식」이라 이름 붙였다.\n그것은 약자에게는 입맛이 돌지 않았으며, 검의 끝은 언제나 강한 적만을 향한다. 칼날은 극히 재빠르게 찌르며, 잔상이 사라질 때는 별바다처럼 광대한 힘도 침멸하여 사라진다.\n그것의 탐욕에는 끝이 없어, 그 굶주린 시선은 태어난 순간부터 로탄을 응시해 매번 출격할 때마다 로탄의 몸속에서 혈육 한 조각을 깨물어 뜯는다.\n하지만, 로탄은 개의치 않는다. 그녀는 그것에게 신선한 피를 먹이며 힘으로 그것을 제압한다. 그녀는 그걸 가장 강한 상대에게 휘두르며, 힘의 진미를 그것과 함께 음미한다."
  },
  Skill_146017_BattleDesc = {
    Text = "「타격」으로 간주한다. 랜덤 적에게 피해 <Damage:[Damage:Arg1]>pt를 [Arg3]회 입히고, <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하며, 사용 후에는 드로우 덱으로 돌아간다. 이 카드를 3번째 사용할 때마다 추가로 1회 발동하고, 해당 턴 다음에 「장검·낙」 사용 시 <DerivativeCardKeywords_153:「대검·고래 낙하」>로 합성된다( [Arg4]/3 ). <DerivativeCardKeywords_154:>"
  },
  Skill_146017_Desc = {
    Text = "「타격」으로 간주한다. 랜덤 적에게 피해 <Damage:[Damage:Arg1]>pt를 [Arg3]회 입히고, <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하며, 사용 후에는 드로우 덱으로 돌아간다. 이 카드를 3번째 사용할 때마다 추가로 1회 발동하고, 해당 턴 다음에 「장검·낙」 사용 시 <DerivativeCardKeywords_153:「대검·고래 낙하」>로 합성된다. <DerivativeCardKeywords_154:>"
  },
  Skill_146017_EffectNameList = {
    Text = "피해, 힘"
  },
  Skill_146017_Name = {
    Text = "단검·식"
  },
  Skill_146017_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_146018_Desc = {
    Text = "카드 1장을 뽑습니다. 다른 깨어남체로부터 최대 [Arg1] 점의 광기를 탈취합니다."
  },
  Skill_146018_Name = {Text = "침멸"},
  Skill_146018_tempBattleDesc_1 = {
    Text = "카드 1장을 뽑습니다. 다른 깨어남체로부터 최대 [Arg1] 점의 광기를 탈취합니다."
  },
  Skill_146018_tempBattleDesc_2 = {
    Text = "카드 1장을 뽑습니다. 다른 깨어남체로부터 최대 [Arg1] 점의 광기를 탈취하고, 추가로 탈취한 값의 50%에 해당하는 광기를 획득합니다."
  },
  Skill_146067_Desc_1 = {
    Text = "카드를 되찾고 <Damage:[Arg1]> 피해를 받는다."
  },
  Skill_146067_Name_1 = {Text = "축복?"},
  Skill_146069_Desc = {
    Text = "사용 후 손패를 비우고, 공백 은열쇠를 손패에 추가합니다."
  },
  Skill_146069_Name = {
    Text = "공백 은열쇠 획득"
  },
  Skill_146097_Desc = {
    Text = "사용 후 손패를 비우고, 편성 은열쇠를 손패에 추가합니다."
  },
  Skill_146097_Name = {
    Text = "편성 은열쇠 획득"
  },
  Skill_146112_Desc = {
    Text = "모든 깨어남체가 광기 <Energy:[Energy:Arg1]>pt를 획득한다. <Shimieluotanhuodong1:전의> [Arg2]스택을 축적하고, 사용 후에는 드로우 덱에 섞여진다."
  },
  Skill_146112_Name = {
    Text = "광기의 뼈"
  },
  Skill_146113_Desc = {
    Text = "모든 깨어남체가 광기를 <Energy:[Energy:Arg1]>pt 획득하고, <PowerIconKeywords:힘>을 [Arg2]pt 획득한다. 모든 <Shimieluotanhuodong1:전의>를 소모하며, <Shimieluotanhuodong1:전의> 1스택을 소모할 때마다 모든 깨어남체의 최종 피해가 3% 증가한다."
  },
  Skill_146113_Name = {Text = "검의 뼈"},
  Skill_146114_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다. 사용 후 이번 턴 내 피해를 입을 때마다, 1회당 <Shimieluotanhuodong1:전의> [Arg2]스택을 축적한다."
  },
  Skill_146114_Name = {
    Text = "상처의 뼈"
  },
  Skill_146132_Desc = {
    Text = "새로운 한여름의 꿈 로직. 카드를 1장 드로우한다. 명령 카드 혹은 영지 깨어남을 드로우했다면, 그 카드의 행동력 소모를 0으로 만들고, 그 카드의 소유자가 광기를 <Energy:[Arg1]>pt 획득한다. 그렇지 않을 경우에는 그 카드를 버리고 해당 효과를 반복한다."
  },
  Skill_146132_Name = {
    Text = "한여름의 꿈"
  },
  Skill_146388_Desc = {
    Text = "광기 폭발 해방 허용"
  },
  Skill_146388_Name = {
    Text = "본원 로탄 테스트"
  },
  Skill_146461_Desc = {
    Text = "텍스트 불필요, 번역 불필요."
  },
  Skill_146461_Name = {
    Text = "사신의 인도"
  },
  Skill_146484_Desc = {
    Text = "[Arg1]% 임시 피해 증폭을 획득합니다."
  },
  Skill_146484_Name = {
    Text = "원초의 기억·분노"
  },
  Skill_146517_Desc = {
    Text = "보유한 은열쇠 중에서 <FaxianKeywords:발견>한 [Arg1] 종류의 은열쇠 중 [Arg2] 개를 선택하여 [Arg3] 회 발동합니다."
  },
  Skill_146517_Name = {
    Text = "원초·쌍생의 재현"
  },
  Skill_146519_Desc = {
    Text = "보유한 은열쇠 중에서 <FaxianKeywords:발견>한 [Arg1] 조의 은열쇠를 확인합니다. 각 조는 [Arg2] 개의 서로 다른 은열쇠로 구성됩니다. [Arg3] 조의 은열쇠를 선택하여 해당 은열쇠를 순서대로 [Arg4] 회 발동합니다."
  },
  Skill_146519_Name = {
    Text = "원초·삼상의 계시"
  },
  Skill_146647_Desc = {
    Text = "<Block:[Block:Arg1]> 점 방어막을 획득하고, 영역 숙련이 [Arg2] 증가합니다. 카라부가 파티에 있을 경우, 다음 1회 <DerivativeCardKeywords_152:「축복」>이 「부정적 효과」를 발동하지 않습니다."
  },
  Skill_146647_Name = {
    Text = "거짓이 아닌 것"
  },
  Skill_146648_Desc = {
    Text = "[Arg2]점의 <PowerIconKeywords:힘>을 획득하고, 깨어남체 1명을 선택해 다른 깨어남체의 광기를 최대 [Arg1]점 탈취합니다. 침식·로탄이 파티에 있을 경우, 다음 침식·로탄의 「타격」이 추가 1회 발동합니다."
  },
  Skill_146648_Name = {
    Text = "고래를 삼킨 폭풍"
  },
  Skill_146658_Name = {Text = "제3조"},
  Skill_146659_Name = {Text = "제1조"},
  Skill_146660_Name = {Text = "제2조"},
  Skill_147427_Desc_0 = {
    Text = "이번 턴 동안 전체 적의 <PowerIconKeywords:힘> [Arg1]pt를 탈취한다."
  },
  Skill_147427_Desc_4000 = {
    Text = "이번 턴 동안 전체 적의 <PowerIconKeywords:힘> [Arg1]pt를 탈취한다. <TransitionIconKeywords:워프>: 행동력 소모가 0이 된다."
  },
  Skill_147427_EffectNameList_0 = {Text = "힘 탈취"},
  Skill_147427_Name = {
    Text = "레퀴엠(미완성)"
  },
  Skill_147427_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_147428_Name_1 = {Text = "타격"},
  Skill_147429_Desc = {
    Text = "저무는 별·틴커트가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 저무는 별·틴커트의 모든 카드가 무작위 효과 1개를 획득하며, 해당 각인 효과는 전투 종료 시 제거됩니다."
  },
  Skill_147429_EffectNameList = {Text = "광기"},
  Skill_147429_Name = {
    Text = "경계 너머의 목소리(미완성)"
  },
  Skill_147430_Name_1 = {
    Text = "부활의 메아리"
  },
  Skill_147431_Desc_0 = {
    Text = "이번 턴에 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 모든 손패가 무작위 효과 1개를 획득한다. 이 효과는 사용 후 또는 전투 종료 시 제거된다. <TransitionIconKeywords:워프>: 무작위 효과가 승급된다."
  },
  Skill_147431_Desc_6 = {
    Text = "이번 턴 동안 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 모든 손패가 무작위 효과 1개를 획득한다. 이 효과는 사용 후 또는 전투 종료 시 제거된다. <TransitionIconKeywords:워프>: 무작위 효과가 승급된다!"
  },
  Skill_147431_EffectNameList = {Text = "힘"},
  Skill_147431_Name = {
    Text = "프리즘 판타지(미완성)"
  },
  Skill_147431_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_147432_Name_1 = {
    Text = "별빛의 오로라"
  },
  Skill_147433_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 입힙니다. 저무는 별·틴커트가 <Energy:[Energy:Arg2]> 점 광기를 획득합니다."
  },
  Skill_147433_EffectNameList = {
    Text = "데미지,광기"
  },
  Skill_147433_Name = {
    Text = "타격(미완성)"
  },
  Skill_147433_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_147434_Desc = {
    Text = "이전 턴에 HP를 잃지 않았다면, 이번 턴의 치명타율이 [Arg2]% 증가한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다."
  },
  Skill_147434_EffectNameList_0 = {Text = "피해"},
  Skill_147434_EffectNameList_1000 = {
    Text = "피해, 추가 피해"
  },
  Skill_147434_Name = {
    Text = "심공의 메아리(미완성)"
  },
  Skill_147434_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_147434_PropertyNameList_1000 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue1"
  },
  Skill_147435_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자리 차지 설명"
  },
  Skill_147435_Name_1 = {
    Text = "저무는 별·틴커트 SR(임시 텍스트)"
  },
  Skill_147436_Name_1 = {Text = "진혼곡"},
  Skill_147437_Desc = {
    Text = "<Block:[Block:Arg1]> 점 방어막을 획득합니다. 저무는 별·틴커트가 <Energy:[Energy:Arg2]> 점 광기를 획득합니다."
  },
  Skill_147437_EffectNameList = {
    Text = "방어막, 광기"
  },
  Skill_147437_Name = {
    Text = "방어(미완성)"
  },
  Skill_147437_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_147438_Name_1 = {
    Text = "구름을 가르는 외침"
  },
  Skill_147551_Desc = {
    Text = "임시 텍스트"
  },
  Skill_147551_Name = {
    Text = "임시 자리 은열쇠"
  },
  Skill_147734_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [Arg1] <MaxHPKeywords:최대 HP>를 획득합니다. 턴 시작 시, 전체 적에게 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:출혈>을 부여합니다."
  },
  Skill_147734_Name_1 = {
    Text = "어둠에서 어둠으로"
  },
  Skill_147742_BattleDesc = {
    Text = "[Arg1] 포인트의 임시 <PowerIconKeywords:힘>을 획득하거나 [Arg1] 포인트의 임시 <ExhaustionIconKeywords:고갈>을 획득합니다."
  },
  Skill_147742_Desc = {
    Text = "[Arg1] 포인트의 임시 <PowerIconKeywords:힘>을 획득하거나 [Arg1] 포인트의 임시 <ExhaustionIconKeywords:고갈>을 획득합니다."
  },
  Skill_147742_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_147743_BattleDesc = {
    Text = "상한을 무시하는 은열쇠 에너지 1000을 획득하거나 은열쇠 에너지 1000점을 잃는다."
  },
  Skill_147743_Desc = {
    Text = "상한을 무시하는 은열쇠 에너지 1000을 획득하거나 은열쇠 에너지 1000점을 잃는다."
  },
  Skill_147743_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_147744_BattleDesc = {
    Text = "모든 각성체가 광기 20을 획득하거나 광기 20을 잃는다."
  },
  Skill_147744_Desc = {
    Text = "모든 각성체가 광기 20을 획득하거나 광기 20을 잃는다."
  },
  Skill_147744_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_147745_BattleDesc = {
    Text = "최대 HP의 5%를 회복하거나 최대 HP의 5%를 잃습니다."
  },
  Skill_147745_Desc = {
    Text = "최대 HP의 5%를 회복하거나 최대 HP의 5%를 잃습니다."
  },
  Skill_147745_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_147746_BattleDesc = {
    Text = "다음 턴 시작 시 「<DerivativeCardKeywords_115:상급 영감>」 1장을 추가로 획득하거나, 행동력 2를 잃고 카드를 2장 덜 드로우합니다."
  },
  Skill_147746_Desc = {
    Text = "다음 턴 시작 시 「<DerivativeCardKeywords_115:상급 영감>」 1장을 추가로 획득하거나, 행동력 2를 잃고 카드를 2장 덜 드로우합니다."
  },
  Skill_147746_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_147917_Name = {
    Text = "호화로운 축복"
  },
  Skill_147918_Name = {
    Text = "따뜻한 축복"
  },
  Skill_147919_Name = {
    Text = "바로 내려지는 축복"
  },
  Skill_147937_Desc = {
    Text = "[Arg1] 스택 <MonsterPainKeywords:고통 구원> 획득, 이후 플레이어가 「<DerivativeCardKeywords_158:대죄>」 사용 시 <MonsterSinMarkKeywords:죄인>의 50%만 해제하며, 명령 카드 1장 사용할 때마다 <MonsterSinMarkKeywords:죄인> 1 획득. 턴 종료 후 <InvincibleUntilRoused:은심 고정> 제거."
  },
  Skill_147937_Name = {
    Text = "정화의 길"
  },
  Skill_147938_Desc = {
    Text = "은열쇠 발동 시마다 다음 사용 시 행동력 소비를 1 감소. 사용 후 「성자·백야」의 <MonsterSinMarkKeywords:죄인> 스택을 절반 해제."
  },
  Skill_147938_Name = {Text = "대죄"},
  Skill_147939_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 줍니다. <PowerIconKeywords:힘> [Arg3] 스택을 획득합니다."
  },
  Skill_147939_Name = {
    Text = "영혼을 태우는 등불"
  },
  Skill_147940_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 줍니다. <MonsterSinMarkKeywords:죄인> [Arg3] 스택을 획득합니다."
  },
  Skill_147940_Name = {Text = "성심"},
  Skill_147941_Desc = {
    Text = "은열쇠 발동 시마다 다음 사용 시 행동력 소비를 [Arg1] 감소. 사용 후 「성자·백야」의 <MonsterSinMarkKeywords:죄인> 스택을 [Arg2]% 해제."
  },
  Skill_147941_Name = {Text = "대죄"},
  Skill_147942_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힘. [Arg3] 스택 <MonsterPainKeywords:고통 구원> 획득, [Arg4] 스택 <FragileIconKeywords:손상> 부여."
  },
  Skill_147942_Name = {
    Text = "무죄의 성재"
  },
  Skill_147943_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힘. [Arg3] 스택 <MonsterPainKeywords:고통 구원> 축적, [Arg4] 스택 <FragileIconKeywords:손상> 부여."
  },
  Skill_147943_Name = {
    Text = "백야의 빛을 비추며"
  },
  Skill_147944_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_147944_Name = {
    Text = "부정의 심판"
  },
  Skill_148024_Desc = {
    Text = "각성체 1명을 선택하여, 이번 턴 해당 각성체의 다음 광기 폭발 시 광기 1 소비마다 은열쇠 에너지 [Arg1]을 획득합니다."
  },
  Skill_148024_Name = {
    Text = "천변만화의 열매 - 악마의 열쇠"
  },
  Skill_148025_Desc = {
    Text = "각성체 1명을 선택하여, 이번 턴 해당 각성체의 다음 광기 폭발 시 획득하는 방어막과 HP 회복이 [Arg1]% 증가합니다."
  },
  Skill_148025_Name = {
    Text = "천변만화의 열매 - 공정의 깃털"
  },
  Skill_148026_Desc = {
    Text = "각성체 1명을 선택하여, 이번 턴 해당 각성체의 명령 카드가 주는 피해에 [Arg1]% 출혈을 부여합니다."
  },
  Skill_148026_Name = {
    Text = "천변만화의 열매 - 필멸의 눈"
  },
  Skill_148027_Desc = {
    Text = "각성체 1명을 선택하여, 해당 각성체의 행동력이 가장 높은 명령 카드 [Arg1]장의 행동력 소비를 [Arg2] 감소시킵니다."
  },
  Skill_148027_Name = {
    Text = "천변만화의 열매 - 예지의 거울"
  },
  Skill_148028_BattleDesc = {
    Text = "각성체 1명을 선택하여, 이번 턴 해당 각성체의 명령 카드를 [Arg1]회 사용하면 잃은 HP의 [Arg2]%에 해당하는 방어막을 획득합니다( [Arg3] )  . 소비: 다음 턴 시작 시 「천변만화의 열매」 1장을 생성하여 드로우 덱에 넣습니다."
  },
  Skill_148028_Desc = {
    Text = "각성체 1명을 선택하여, 이번 턴 해당 각성체의 명령 카드를 [Arg1]회 사용하면 잃은 HP의 [Arg2]%에 해당하는 방어막을 획득합니다."
  },
  Skill_148028_Name = {
    Text = "천변만화의 열매 - 유혹의 열매"
  },
  Skill_148029_Desc = {
    Text = "각성체 1명을 선택하여, 이번 턴 해당 각성체의 다음 광기 폭발이 주는 피해에 [Arg1]% <CutKeywords:운명 재단>을 부여합니다."
  },
  Skill_148029_Name = {
    Text = "천변만화의 열매 - 운명의 실"
  },
  Skill_148042_BattleDesc = {
    Text = "카드를 [Arg1]장 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148042_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148042_Name = {
    Text = "호화로운 축복·드로우"
  },
  Skill_148043_BattleDesc = {
    Text = "[Arg1] 점 행동력을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148043_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148043_Name = {
    Text = "호화로운 축복·행동력"
  },
  Skill_148044_BattleDesc = {
    Text = "모든 각성체가 <Yellow:[Arg1]> 고정 광기를 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148044_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148044_Name = {
    Text = "따뜻한 축복·광기"
  },
  Skill_148045_BattleDesc = {
    Text = "[Arg1] 행동력을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148045_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148045_Name = {
    Text = "따뜻한 축복·행동력"
  },
  Skill_148046_BattleDesc = {
    Text = "모든 각성체가 <Yellow:[Arg1]> 고정 광기를 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148046_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148046_Name = {
    Text = "호화로운 축복·광기"
  },
  Skill_148047_BattleDesc = {
    Text = "<Posse:[Arg1]> 은열쇠 에너지를 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148047_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148047_Name = {
    Text = "따뜻한 축복·은열쇠 에너지"
  },
  Skill_148048_BattleDesc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148048_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148048_Name = {
    Text = "호화로운 축복·피해 증폭"
  },
  Skill_148049_BattleDesc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148049_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148049_Name = {
    Text = "호화로운 축복·고갈"
  },
  Skill_148050_BattleDesc = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148050_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148050_Name = {
    Text = "호화로운 축복·힘"
  },
  Skill_148051_BattleDesc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148051_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148051_Name = {
    Text = "따뜻한 축복·힘"
  },
  Skill_148052_BattleDesc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148052_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148052_Name = {
    Text = "따뜻한 축복·고갈"
  },
  Skill_148053_BattleDesc = {
    Text = "카드를 [Arg1]장 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148053_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148053_Name = {
    Text = "따뜻한 축복·드로우"
  },
  Skill_148054_BattleDesc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148054_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148054_Name = {
    Text = "호화로운 축복·은열쇠 에너지"
  },
  Skill_148055_BattleDesc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_148055_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_148055_Name = {
    Text = "따뜻한 축복·피해 증폭"
  },
  Skill_148360_Desc = {
    Text = "해당 의도로 전환 시, 적의 방어막을 파괴하고 이번 턴 방어막 획득 불가 상태로 만들며, 즉시 [Arg3] 스택 <MonsterB05EXFever:광열> 획득. 턴 종료까지 자신이 입히는 피해에 100% <BleedingIconKeywords:출혈> 추가. <Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힘."
  },
  Skill_148360_Name = {
    Text = "사슬에 묶인 원한"
  },
  Skill_148361_Desc = {
    Text = "해당 의도로 전환 시, 적의 방어막을 파괴하고 이번 턴 방어막 획득 불가 상태로 만들며, 즉시 [Arg3] 스택 <MonsterB05EXFever:광열> 획득. 턴 종료까지 자신이 입히는 피해에 100% <BleedingIconKeywords:출혈> 추가. <Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힘."
  },
  Skill_148361_Name = {
    Text = "속박의 사슬"
  },
  Skill_148362_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고 [Arg3]% <BleedingIconKeywords:출혈> 추가, 현재 HP의 [Arg4]% 소모. 해당 의도로 전환 시 「증오」 [Arg5] 스택 보유 중이면 의도가 <Damage:[Damage:Arg6]> 피해를 [AttackTimes:Arg7]회 입히는 「피에 굶주린 철구」로 교체되고, 그렇지 않으면 「증오」 1 스택 획득."
  },
  Skill_148362_Name = {
    Text = "선혈의 사슬"
  },
  Skill_148364_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, 적의 <BleedingIconKeywords:출혈> 3 스택마다 피해 1 증가, 손실된 HP의 30% 회복."
  },
  Skill_148364_Name = {
    Text = "피에 굶주린 철구"
  },
  Skill_148365_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, [Arg3] <PowerIconKeywords:힘> 획득. 자신의 HP가 [Arg4](50%) 미만이면 피해와 획득 <PowerIconKeywords:힘>이 2배."
  },
  Skill_148365_Name = {
    Text = "원한 발산"
  },
  Skill_148393_Desc = {
    Text = "턴 시작 시 [Arg1] 스택 <ResentChainsKeywords:증오의 사슬> 획득. 의도가 「피에 굶주린 철구」로 전환될 때, 적의 턴 종료까지 모든 피해 및 HP 손실 효과에 면역."
  },
  Skill_148393_Name = {
    Text = "영혼 사냥 선언"
  },
  Skill_148499_Name = {
    Text = "마법 보물상자"
  },
  Skill_148502_Name = {
    Text = "마법 보물상자"
  },
  Skill_148506_Name = {
    Text = "마법 보물상자"
  },
  Skill_148531_Desc = {
    Text = "각성체 1명을 선택하여, 해당 각성체의 명령 카드 1장을 드로우하고 행동력 소비를 0으로 만들며, 해당 각성체의 다음 광기 폭발을 초월 폭발로 간주합니다. 이미 초월 폭발인 경우 광기 최대치의 100%를 반환합니다."
  },
  Skill_148531_Name = {
    Text = "천변만화의 열매 - 영원의 관"
  },
  Skill_149049_Desc = {
    Text = "[Arg1]스택의 <Guaiwusiwangdikang:죽음 저항>을 획득한다. 모든 <SlowIconKeywords:둔화> 명령 카드를 「빙결」시키고 <SlowIconKeywords:둔화> 효과를 제거하며, 모든 각성체의 광기를 <Energy:[Energy:Arg2]>점 제거한다."
  },
  Skill_149049_Name = {
    Text = "생존자의 노래"
  },
  Skill_149077_Desc = {
    Text = "해당 의도로 전환 시, 광기가 가장 높은 각성체의 광기를 최대 <Energy:[Energy:Arg1]> 삼키고, 사망 후 반환. <Damage:[Damage:Arg2]> 피해를 [AttackTimes:Arg3]회 입히고 동량의 <BleedingIconKeywords:출혈> 부여, 광기가 가장 높은 각성체에게 [Arg4] 스택 광기 봉인 부여."
  },
  Skill_149077_Name = {Text = "삼킴"},
  Skill_149078_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, [Arg3] 스택 <WeaknessIconKeywords:허약> 부여."
  },
  Skill_149078_Name = {
    Text = "물어뜯기"
  },
  Skill_149079_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_149079_Name = {
    Text = "물어뜯기"
  },
  Skill_149080_Desc = {
    Text = "해당 의도로 전환 시, 광기가 가장 낮은 각성체의 명령 카드 [Arg1]장을 빙결하고, 사망 후 해당 각성체의 빙결 해제. <Damage:[Damage:Arg2]> 피해를 [AttackTimes:Arg3]회 입히고 동량의 <BleedingIconKeywords:출혈> 부여, 드로우 덱 또는 버린 카드 더미의 카드 [Arg4]장에 [Arg5] 스택 <SlowIconKeywords:둔화> 부여."
  },
  Skill_149080_Name = {Text = "삼킴"},
  Skill_149081_Desc = {
    Text = "[Arg1] <PowerIconKeywords:힘> 획득, 삼킨 광기를 소화."
  },
  Skill_149081_Name = {Text = "잠복"},
  Skill_149082_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘> 획득, 대상 각성체의 빙결된 명령 카드를 모두 파쇄하여 <DepleteIconKeywords:소비>."
  },
  Skill_149082_Name = {Text = "잠복"},
  Skill_149129_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, [Arg3] 스택 <WeaknessIconKeywords:허약> 부여 및 손에 든 모든 카드를 버림."
  },
  Skill_149129_Name = {Text = "해체"},
  Skill_149130_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, <BloodOath_New:피의 맹세> [Arg3] 스택마다 입히는 피해가 [Arg4] 증가."
  },
  Skill_149130_Name = {
    Text = "새로운 생명을 포옹하다"
  },
  Skill_149131_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고 동량의 <BleedingIconKeywords:출혈> 추가."
  },
  Skill_149131_Name = {
    Text = "등불이 영혼을 태우다"
  },
  Skill_149132_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘> 획득. 드로우 덱 또는 버린 카드 더미의 명령 카드 [Arg2]장에 [Arg3] 스택 <SlowIconKeywords:둔화> 부여, 적의 각 카드에 <SlowIconKeywords:둔화>가 [Arg4] 스택 있을 때마다 자신이 [Arg5] 스택 <BloodOath_New:피의 맹세> 획득."
  },
  Skill_149132_Name = {
    Text = "성스러운 모습을 비추다"
  },
  Skill_149150_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘>을 획득하고, 방어막 보유 시 [Arg1] 스택 <BoneHitKeywords:뼈를 에는 일격>을 부여하며, 그렇지 않으면 현재 HP의 [Arg2]%를 잃고 동량의 <CardKeyWord:서리 방패>를 획득합니다."
  },
  Skill_149150_Name = {
    Text = "영원한 겨울의 의지"
  },
  Skill_149151_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 피해의 [Arg3]% 만큼 <BoneHitKeywords:뼈를 에는 일격>을 부여하며, 자신이 방어막을 보유한 경우 부여하는 <BoneHitKeywords:뼈를 에는 일격>이 두 배가 됩니다."
  },
  Skill_149151_Name = {
    Text = "얼음 가시"
  },
  Skill_149152_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <HeavyInjuryKeywords:치명타>를 부여하며, 막히지 않은 경우 죽음 저항을 [Arg4]% 제거합니다."
  },
  Skill_149152_Name = {Text = "목 긋기"},
  Skill_149153_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 잃은 HP의 [Arg3]%를 회복합니다."
  },
  Skill_149153_Name = {
    Text = "흡혈 멍울"
  },
  Skill_149175_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <BlindingKeywords:실명>을 부여하며, 무작위 증상 카드 [Arg4] 장을 상대방 드로우 덱에 셔플합니다."
  },
  Skill_149175_Name = {
    Text = "영혼 설교"
  },
  Skill_149176_Desc = {
    Text = "손에 든 모든 카드를 버리고, 버린 카드 더미의 모든 명령 카드에 [Arg1] 스택 <SlowIconKeywords:둔화> 부여."
  },
  Skill_149176_Name = {
    Text = "죄의 불로 싸여진 영육"
  },
  Skill_149177_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘> 획득. 드로우 덱 또는 버린 카드 더미의 명령 카드 [Arg2]장에 [Arg3] 스택 <SlowIconKeywords:둔화> 부여, 적의 각 카드에 <SlowIconKeywords:둔화>가 [Arg4] 스택 있을 때마다 자신이 [Arg5] 스택 <BloodOath_New:피의 맹세> 획득."
  },
  Skill_149177_Name = {
    Text = "성스러운 모습을 비추다"
  },
  Skill_149178_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘> 획득. 드로우 덱 또는 버린 카드 더미의 명령 카드 [Arg2]장에 [Arg3] 스택 <SlowIconKeywords:둔화> 부여, 적의 각 카드에 <SlowIconKeywords:둔화>가 [Arg4] 스택 있을 때마다 자신이 [Arg5] 스택 <BloodOath_New:피의 맹세> 획득."
  },
  Skill_149178_Name = {
    Text = "성스러운 모습을 비추다"
  },
  Skill_149181_Desc = {
    Text = "전열 적에게 [Arg1] 점 일반 고정 피해를 [Arg2]회 줍니다."
  },
  Skill_149181_Name = {
    Text = "고정 피해 테스트"
  },
  Skill_149182_Desc = {
    Text = "전열 적에게 [Arg1] 점 관통 고정 피해를 [Arg2]회 줍니다."
  },
  Skill_149182_Name = {
    Text = "고정 피해 테스트"
  },
  Skill_149208_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 피해의 [Arg3]% 만큼 <BleedingIconKeywords:출혈>을 부여하며, 자신이 방어막을 보유한 경우 부여하는 <BleedingIconKeywords:출혈>이 두 배가 됩니다."
  },
  Skill_149208_Name = {
    Text = "저주 찌르기"
  },
  Skill_149209_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘>을 획득하고, 방어막 보유 시 [Arg1] 스택 <IntoxicationIconKeywords:중독>을 부여하며, 그렇지 않으면 현재 HP의 [Arg2]%를 잃고 동량의 <CardKeyWord:저주 방패>를 획득합니다."
  },
  Skill_149209_Name = {
    Text = "등불의 의지"
  },
  Skill_149210_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <EmptinessKeywords:공허>를 부여하며, 막히지 않은 경우 죽음 저항을 [Arg4]% 제거합니다."
  },
  Skill_149210_Name = {
    Text = "목 조르기"
  },
  Skill_149236_Desc = {
    Text = "전열 적에게 광기 폭발 퍼센트 보정 -50 부여"
  },
  Skill_149236_Name = {
    Text = "광기 폭발 퍼센트 보정 테스트"
  },
  Skill_149237_Desc = {
    Text = "전열 적에게 광기 폭발 퍼센트 보정 +50 부여"
  },
  Skill_149237_Name = {
    Text = "광기 폭발 퍼센트 보정 테스트"
  },
  Skill_149239_Desc = {
    Text = "전열 적에게 명령 카드 피해 수치 퍼센트 보정 +50 부여"
  },
  Skill_149239_Name = {
    Text = "명령 카드 피해 수치 퍼센트 보정 테스트"
  },
  Skill_149248_Desc = {
    Text = "전열 적에게 명령 카드 피해 수치 퍼센트 보정 -50 부여"
  },
  Skill_149248_Name = {
    Text = "명령 카드 피해 수치 퍼센트 보정 테스트"
  },
  Skill_149255_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 막히지 않을 때마다 모든 각성체의 광기를 [Arg3] 제거합니다."
  },
  Skill_149255_Name = {
    Text = "기습 사냥"
  },
  Skill_149256_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 막히지 않은 피해의 [Arg3]% 만큼 <BoneHitKeywords:뼈를 에는 일격>을 부여합니다."
  },
  Skill_149256_Name = {Text = "설해"},
  Skill_149277_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <HeavyInjuryKeywords:치명타>를 부여하며, 막히지 않은 경우 죽음 저항을 [Arg4]% 제거합니다."
  },
  Skill_149277_Name = {Text = "목 긋기"},
  Skill_149278_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <HeavyInjuryKeywords:치명타>를 부여하며, 막히지 않은 경우 죽음 저항을 [Arg4]% 제거합니다."
  },
  Skill_149278_Name = {Text = "목 긋기"},
  Skill_149279_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 피해의 [Arg3]% 만큼 <BleedingIconKeywords:출혈>을 부여하며, 자신이 방어막을 보유한 경우 부여하는 <BleedingIconKeywords:출혈>이 두 배가 됩니다."
  },
  Skill_149279_Name = {
    Text = "저주 찌르기"
  },
  Skill_149280_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 잃은 HP의 [Arg3]%를 회복합니다."
  },
  Skill_149280_Name = {
    Text = "흡혈 멍울"
  },
  Skill_149281_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <EmptinessKeywords:공허>를 부여하며, 막히지 않은 경우 죽음 저항을 [Arg4]% 제거합니다."
  },
  Skill_149281_Name = {
    Text = "목 조르기"
  },
  Skill_149282_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘>을 획득하고, 방어막 보유 시 [Arg1] 스택 <BoneHitKeywords:뼈를 에는 일격>을 부여하며, 그렇지 않으면 현재 HP의 [Arg2]%를 잃고 [Arg3]% <CardKeyWord:서리 방패>를 획득합니다."
  },
  Skill_149282_Name = {
    Text = "영원한 겨울의 의지"
  },
  Skill_149283_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘>을 획득하고, 방어막 보유 시 [Arg1] 스택 <BoneHitKeywords:뼈를 에는 일격>을 부여하며, 그렇지 않으면 현재 HP의 [Arg2]%를 잃고 [Arg3]% <CardKeyWord:서리 방패>를 획득합니다."
  },
  Skill_149283_Name = {
    Text = "영원한 겨울의 의지"
  },
  Skill_149284_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 피해의 [Arg3]% 만큼 <BleedingIconKeywords:출혈>을 부여하며, 자신이 방어막을 보유한 경우 부여하는 <BleedingIconKeywords:출혈>이 두 배가 됩니다."
  },
  Skill_149284_Name = {
    Text = "저주 찌르기"
  },
  Skill_149285_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘>을 획득하고, 방어막 보유 시 [Arg1] 스택 <IntoxicationIconKeywords:중독>을 부여하며, 그렇지 않으면 현재 HP의 [Arg2]%를 잃고 [Arg3]% <CardKeyWord:저주 방패>를 획득합니다."
  },
  Skill_149285_Name = {
    Text = "등불의 의지"
  },
  Skill_149286_Desc = {
    Text = "[Arg1] 스택 <PowerIconKeywords:힘>을 획득하고, 방어막 보유 시 [Arg1] 스택 <IntoxicationIconKeywords:중독>을 부여하며, 그렇지 않으면 현재 HP의 [Arg2]%를 잃고 [Arg3]% <CardKeyWord:저주 방패>를 획득합니다."
  },
  Skill_149286_Name = {
    Text = "등불의 의지"
  },
  Skill_149287_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 피해의 [Arg3]% 만큼 <BoneHitKeywords:뼈를 에는 일격>을 부여하며, 자신이 방어막을 보유한 경우 부여하는 <BoneHitKeywords:뼈를 에는 일격>이 두 배가 됩니다."
  },
  Skill_149287_Name = {
    Text = "얼음 가시"
  },
  Skill_149288_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 스택 <EmptinessKeywords:공허>를 부여하며, 막히지 않은 경우 죽음 저항을 [Arg4]% 제거합니다."
  },
  Skill_149288_Name = {
    Text = "목 조르기"
  },
  Skill_149289_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, 피해의 [Arg3]% 만큼 <BoneHitKeywords:뼈를 에는 일격>을 부여하며, 자신이 방어막을 보유한 경우 부여하는 <BoneHitKeywords:뼈를 에는 일격>이 두 배가 됩니다."
  },
  Skill_149289_Name = {
    Text = "얼음 가시"
  },
  Skill_149333_Desc = {
    Text = "<Block:[Block:Arg1]> 점 방어막을 획득하고, [Arg2] 점 <PowerIconKeywords:힘>을 획득합니다. 부서약·오지에가 파티에 있을 경우, 부서약·오지에가 [Arg3] 점 광기를 획득하고, 1 스택 <KuangNu:암류>를 획득합니다."
  },
  Skill_149333_Name = {
    Text = "영속 새 챕터"
  },
  Skill_149334_Name_1 = {
    Text = "영속 새 챕터"
  },
  Skill_149334_UnknownName = {
    Text = "영속 새 챕터"
  },
  Skill_149345_Desc = {
    Text = "은열쇠 에너지 <Posse:[Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149345_Name = {
    Text = "따뜻한 축복·은열쇠 에너지"
  },
  Skill_149346_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149346_Name = {
    Text = "따뜻한 축복·힘"
  },
  Skill_149347_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg3] 층 <WeaknessIconKeywords:허약>을 부여하며, 패 덱의 [Arg4] 장 명령 카드에 [Arg5] 층 <SlowIconKeywords:둔화>를 부여합니다."
  },
  Skill_149347_Name = {
    Text = "흩날리는 눈의 저주"
  },
  Skill_149348_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1] 점 감소시킵니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149348_Name = {
    Text = "바로 내려지는 축복·고갈"
  },
  Skill_149349_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]점 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149349_Name = {
    Text = "따뜻한 축복·고갈"
  },
  Skill_149350_Desc = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149350_Name = {
    Text = "따뜻한 축복·광기"
  },
  Skill_149353_Desc = {
    Text = "[Arg1] 점 행동력을 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149353_Name = {
    Text = "바로 내려지는 축복·행동력"
  },
  Skill_149354_Desc = {
    Text = "<Block:[Block:Arg4]> 의 서리 방패를 획득하고, [Arg5] 회 <Bleesing_Negative:은폐된 살의> 효과를 가합니다. 「<DerivativeCardKeywords_161:축복>」 [Arg1] 세트를 발견하며, 각 세트에는 <Blessing:선물>과 <BlessingNegativeEffect:대가>가 포함되어 있고, 세트당 [Arg2] 장이며, [Arg3] 세트를 선택하여 손에 넣습니다."
  },
  Skill_149354_Name = {
    Text = "기적의 축복"
  },
  Skill_149355_Desc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149355_Name = {
    Text = "바로 내려지는 축복·은열쇠 에너지"
  },
  Skill_149356_Desc = {
    Text = "모든 각성체가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149356_Name = {
    Text = "바로 내려지는 축복·광기"
  },
  Skill_149357_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]점 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149357_Name = {
    Text = "호화로운 축복·고갈"
  },
  Skill_149358_Desc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149358_Name = {
    Text = "호화로운 축복·피해 증폭"
  },
  Skill_149359_Desc = {
    Text = "카드 [Arg1]장을 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149359_Name = {
    Text = "따뜻한 축복·드로우"
  },
  Skill_149360_Desc = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149360_Name = {
    Text = "호화로운 축복·광기"
  },
  Skill_149361_Desc = {
    Text = "행동력 [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149361_Name = {
    Text = "호화로운 축복·행동력"
  },
  Skill_149362_Desc = {
    Text = "<MonsterBless:선물> 1종과 <BlessingNegativeEffect:대가> 1종을 획득합니다. 「축복」은 총 3종: 「바로 내려지는 축복」, 「호화로운 축복」, 「따뜻한 축복」이 있습니다.\n「바로 내려지는 축복」: 「놓쳐진 기회」를 발동하지 않습니다.\n「호화로운 축복」: 「허풍」을 발동하지 않습니다.\n「따뜻한 축복」: 「은폐된 살의」를 발동하지 않습니다."
  },
  Skill_149362_Name = {Text = "축복"},
  Skill_149364_Desc = {
    Text = "「백설 요정」이 「흠 없는 동화」를 사용한 후 다음 [Arg1] 개의 의도가 모두 「흩날리는 눈의 저주」가 됩니다. 매 라운드 [Arg3] 층 <SlowIconKeywords:둔화>를 가진 랜덤 「<DerivativeCardKeywords_161:축복>」 [Arg2] 장을 패 덱에 셔플합니다."
  },
  Skill_149364_Name = {
    Text = "유혹하는 달콤한 열매"
  },
  Skill_149365_Desc = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149365_Name = {
    Text = "바로 내려지는 축복·힘"
  },
  Skill_149366_Desc = {
    Text = "은열쇠 에너지 <Posse:[Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149366_Name = {
    Text = "호화로운 축복·은열쇠 에너지"
  },
  Skill_149367_Desc = {
    Text = "행동력 [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149367_Name = {
    Text = "따뜻한 축복·행동력"
  },
  Skill_149369_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149369_Name = {
    Text = "흠 없는 동화"
  },
  Skill_149372_Desc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149372_Name = {
    Text = "따뜻한 축복·피해 증폭"
  },
  Skill_149373_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149373_Name = {
    Text = "짜잔★요정님 등장!"
  },
  Skill_149374_Desc = {
    Text = "카드 [Arg1]장을 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149374_Name = {
    Text = "호화로운 축복·드로우"
  },
  Skill_149375_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149375_Name = {
    Text = "호화로운 축복·힘"
  },
  Skill_149376_Desc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149376_Name = {
    Text = "바로 내려지는 축복·피해 증폭"
  },
  Skill_149377_Desc = {
    Text = "카드를 [Arg1] 장 뽑습니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149377_Name = {
    Text = "바로 내려지는 축복·드로우"
  },
  Skill_149378_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 가하고, [Arg4] 층 <SlowIconKeywords:둔화>를 가진 랜덤 「<DerivativeCardKeywords_161:축복>」 [Arg3] 장을 패 덱에 셔플합니다."
  },
  Skill_149378_Name = {Text = "타격"},
  Skill_149636_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149636_Name = {
    Text = "짜잔★요정님 등장!\n봉헌 행동력"
  },
  Skill_149639_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149639_Name = {
    Text = "짜잔★요정님 등장!\n봉헌 열쇠의 힘"
  },
  Skill_149642_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149642_Name = {
    Text = "짜잔★요정님 등장!\n봉헌 카드"
  },
  Skill_149643_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149643_Name = {
    Text = "짜잔★요정님 등장!\n봉헌 광기"
  },
  Skill_149644_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149644_Name = {
    Text = "흠 없는 동화\n봉헌 행동력, 카드"
  },
  Skill_149645_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149645_Name = {
    Text = "흠 없는 동화\n봉헌 열쇠의 힘, 광기"
  },
  Skill_149646_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149646_Name = {
    Text = "흠 없는 동화\n봉헌 카드, 광기"
  },
  Skill_149647_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149647_Name = {
    Text = "흠 없는 동화\n봉헌 행동력, 열쇠의 힘"
  },
  Skill_149648_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149648_Name = {
    Text = "흠 없는 동화\n봉헌 행동력, 광기"
  },
  Skill_149649_Desc = {
    Text = "이 의도로 전환 시 무작위로 적에게 [Arg1] 종류의 봉헌을 요구합니다. <Damage:[Damage:Arg4]> 점 피해를 [AttackTimes:Arg5] 회 가합니다. 봉헌 성공 시 「백설 요정」의 HP 상한이 [Arg2]% 증가하고, 1 층 <MonsterB11_AFFull:과식>을 획득합니다; 그렇지 않으면 [Arg3] 점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_149649_Name = {
    Text = "흠 없는 동화\n봉헌 열쇠의 힘, 카드"
  },
  Skill_149706_Desc_1 = {
    Text = "PVP 순수 피해에 면역되며, 재사용 시 해제됩니다."
  },
  Skill_149706_Name_1 = {
    Text = "순수 피해 면역"
  },
  Skill_149722_BattleDesc = {
    Text = "상한을 무시하는 은열쇠 에너지 1000을 획득하거나 은열쇠 에너지 1000점을 잃는다."
  },
  Skill_149722_Desc = {
    Text = "상한을 무시하는 은열쇠 에너지 1000을 획득하거나 은열쇠 에너지 1000점을 잃는다."
  },
  Skill_149722_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_149723_BattleDesc = {
    Text = "모든 각성체가 광기 20을 획득하거나 광기 20을 잃는다."
  },
  Skill_149723_Desc = {
    Text = "모든 각성체가 광기 20을 획득하거나 광기 20을 잃는다."
  },
  Skill_149723_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_149724_BattleDesc = {
    Text = "다음 턴 시작 시 「<DerivativeCardKeywords_115:상급 영감>」 1장을 추가로 획득하거나, 행동력 2를 잃고 카드를 2장 덜 드로우합니다."
  },
  Skill_149724_Desc = {
    Text = "다음 턴 시작 시 「<DerivativeCardKeywords_115:상급 영감>」 1장을 추가로 획득하거나, 행동력 2를 잃고 카드를 2장 덜 드로우합니다."
  },
  Skill_149724_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_149725_BattleDesc = {
    Text = "최대 HP의 5%를 회복하거나 최대 HP의 5%를 잃습니다."
  },
  Skill_149725_Desc = {
    Text = "최대 HP의 5%를 회복하거나 최대 HP의 5%를 잃습니다."
  },
  Skill_149725_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_149726_BattleDesc = {
    Text = "[Arg1] 포인트의 임시 <PowerIconKeywords:힘>을 획득하거나 [Arg1] 포인트의 임시 <ExhaustionIconKeywords:고갈>을 획득합니다."
  },
  Skill_149726_Desc = {
    Text = "[Arg1] 포인트의 임시 <PowerIconKeywords:힘>을 획득하거나 [Arg1] 포인트의 임시 <ExhaustionIconKeywords:고갈>을 획득합니다."
  },
  Skill_149726_Name = {
    Text = "로열 마리 초콜릿"
  },
  Skill_149842_Name = {
    Text = "뼈를 에는 일격 한풍Skill1"
  },
  Skill_149843_Name = {
    Text = "아가리Attack1"
  },
  Skill_149844_Name = {
    Text = "칠대 「신기」의 보광ExSkill"
  },
  Skill_149845_Name = {
    Text = "뼈를 에는 일격 한풍Skill2"
  },
  Skill_149846_Name = {
    Text = "심연 수확Attack2"
  },
  Skill_149847_Name = {
    Text = "영원불멸의 화채Summon"
  },
  Skill_149901_Desc = {
    Text = "모든 보물 특수효과 끄기"
  },
  Skill_149901_Name = {
    Text = "모든 보물 특수효과 끄기"
  },
  Skill_149902_Name = {
    Text = "스킬@대식세포 지렁이 윌리엄 지원 카드3"
  },
  Skill_149903_Name = {
    Text = "스킬@대식세포 지렁이 N 지원 카드"
  },
  Skill_149904_Name = {
    Text = "스킬@대식세포 지렁이 윌리엄 지원 카드1"
  },
  Skill_149905_Name = {
    Text = "스킬@대식세포 지렁이 윌리엄 지원 카드2"
  },
  Skill_149906_Desc = {
    Text = "테스트 특수효과 카드 획득"
  },
  Skill_149906_Name = {
    Text = "테스트 특수효과 카드 획득"
  },
  Skill_149907_Desc = {
    Text = "모든 보물 특수효과 켜기"
  },
  Skill_149907_Name = {
    Text = "모든 보물 특수효과 켜기"
  },
  Skill_149959_BattleDesc = {
    Text = "카드 [Arg1]장을 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149959_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149959_Name = {
    Text = "호화로운 축복·드로우"
  },
  Skill_149959_tempBattleDesc_1 = {
    Text = "카드를 [Arg2]장 뽑습니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149959_tempBattleDesc_2 = {
    Text = "카드를 [Arg1]장 뽑습니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149959_tempBattleDesc_3 = {
    Text = "카드를 [Arg1]장 뽑습니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149960_BattleDesc = {
    Text = "카드를 [Arg1]장 뽑습니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149960_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149960_Name = {
    Text = "바로 내려지는 축복·드로우"
  },
  Skill_149960_tempBattleDesc_1 = {
    Text = "카드를 [Arg2]장 뽑습니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149960_tempBattleDesc_2 = {
    Text = "카드를 [Arg1]장 뽑습니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149960_tempBattleDesc_3 = {
    Text = "카드를 [Arg1]장 뽑습니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149961_BattleDesc = {
    Text = "은열쇠 에너지를 <Posse:[Arg1]>만큼 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149961_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149961_Name = {
    Text = "호화로운 축복·은열쇠 에너지"
  },
  Skill_149961_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 점 은열쇠 에너지를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149961_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149961_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149962_BattleDesc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149962_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149962_Name = {
    Text = "호화로운 축복·피해 증폭"
  },
  Skill_149962_tempBattleDesc_1 = {
    Text = "임시 피해 증폭 +[Arg2]%. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149962_tempBattleDesc_2 = {
    Text = "임시 피해 증폭 +[Arg1]%. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149962_tempBattleDesc_3 = {
    Text = "임시 피해 증폭 +[Arg1]%. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149963_BattleDesc = {
    Text = "[Arg1] 점 행동력을 획득합니다, 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1 층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149963_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149963_Name = {
    Text = "바로 내려지는 축복·행동력"
  },
  Skill_149963_tempBattleDesc_1 = {
    Text = "[Arg2] 점 행동력을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149963_tempBattleDesc_2 = {
    Text = "[Arg1] 점 행동력을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149963_tempBattleDesc_3 = {
    Text = "[Arg1] 점 행동력을 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149964_BattleDesc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]만큼 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149964_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149964_Name = {
    Text = "호화로운 축복·힘"
  },
  Skill_149964_tempBattleDesc_1 = {
    Text = "[Arg2] 점 <PowerIconKeywords:힘>을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149964_tempBattleDesc_2 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149964_tempBattleDesc_3 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149965_BattleDesc = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149965_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149965_Name = {
    Text = "바로 내려지는 축복·광기"
  },
  Skill_149965_tempBattleDesc_1 = {
    Text = "모든 각성체가 <Yellow:[Arg2]>의 고정 광기를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149965_tempBattleDesc_2 = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149965_tempBattleDesc_3 = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149966_BattleDesc = {
    Text = "카드 [Arg1]장을 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149966_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149966_Name = {
    Text = "따뜻한 축복·드로우"
  },
  Skill_149966_tempBattleDesc_1 = {
    Text = "카드를 [Arg2]장 뽑습니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149966_tempBattleDesc_2 = {
    Text = "카드를 [Arg1]장 뽑습니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149966_tempBattleDesc_3 = {
    Text = "카드를 [Arg1]장 뽑습니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149967_BattleDesc = {
    Text = "행동력을 [Arg1]만큼 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149967_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149967_Name = {
    Text = "호화로운 축복·행동력"
  },
  Skill_149967_tempBattleDesc_1 = {
    Text = "[Arg2] 점 행동력을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149967_tempBattleDesc_2 = {
    Text = "[Arg1] 점 행동력을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149967_tempBattleDesc_3 = {
    Text = "[Arg1] 점 행동력을 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149968_BattleDesc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149968_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149968_Name = {
    Text = "바로 내려지는 축복·피해 증폭"
  },
  Skill_149968_tempBattleDesc_1 = {
    Text = "임시 피해 증폭 +[Arg2]%. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149968_tempBattleDesc_2 = {
    Text = "임시 피해 증폭 +[Arg1]%. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149968_tempBattleDesc_3 = {
    Text = "임시 피해 증폭 +[Arg1]%. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149969_BattleDesc = {
    Text = "행동력 [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149969_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149969_Name = {
    Text = "따뜻한 축복·행동력"
  },
  Skill_149969_tempBattleDesc_1 = {
    Text = "[Arg2] 점 행동력을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149969_tempBattleDesc_2 = {
    Text = "[Arg1] 점 행동력을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149969_tempBattleDesc_3 = {
    Text = "[Arg1] 점 행동력을 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149970_BattleDesc = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149970_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149970_Name = {
    Text = "호화로운 축복·광기"
  },
  Skill_149970_tempBattleDesc_1 = {
    Text = "모든 각성체가 <Yellow:[Arg2]>의 고정 광기를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149970_tempBattleDesc_2 = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149970_tempBattleDesc_3 = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149971_BattleDesc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시킵니다, 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1 층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149971_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149971_Name = {
    Text = "바로 내려지는 축복·고갈"
  },
  Skill_149971_tempBattleDesc_1 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]만큼 감소시킵니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149971_tempBattleDesc_2 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149971_tempBattleDesc_3 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149972_BattleDesc = {
    Text = "은열쇠 에너지 <Posse:[Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149972_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149972_Name = {
    Text = "따뜻한 축복·은열쇠 에너지"
  },
  Skill_149972_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 점 은열쇠 에너지를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149972_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149972_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149973_BattleDesc = {
    Text = "모든 각성체가 고정 광기 <Yellow:[Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149973_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149973_Name = {
    Text = "따뜻한 축복·광기"
  },
  Skill_149973_tempBattleDesc_1 = {
    Text = "모든 각성체가 <Yellow:[Arg2]>의 고정 광기를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149973_tempBattleDesc_2 = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149973_tempBattleDesc_3 = {
    Text = "모든 각성체가 <Yellow:[Arg1]>의 고정 광기를 획득합니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149974_BattleDesc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149974_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149974_Name = {
    Text = "따뜻한 축복·힘"
  },
  Skill_149974_tempBattleDesc_1 = {
    Text = "[Arg2] 점 <PowerIconKeywords:힘>을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149974_tempBattleDesc_2 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149974_tempBattleDesc_3 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149975_BattleDesc = {
    Text = "모든 적의 【Exhaustion:Arg1】점 <ExhaustionIconKeywords:힘>을 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149975_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149975_Name = {
    Text = "따뜻한 축복·고갈"
  },
  Skill_149975_tempBattleDesc_1 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]만큼 감소시킵니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149975_tempBattleDesc_2 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149975_tempBattleDesc_3 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149976_BattleDesc = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다, 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1 층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149976_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149976_Name = {
    Text = "바로 내려지는 축복·힘"
  },
  Skill_149976_tempBattleDesc_1 = {
    Text = "[Arg2] 점 <PowerIconKeywords:힘>을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149976_tempBattleDesc_2 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149976_tempBattleDesc_3 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149977_BattleDesc = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함됩니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149977_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149977_Name = {
    Text = "호화로운 축복·고갈"
  },
  Skill_149977_tempBattleDesc_1 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]만큼 감소시킵니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149977_tempBattleDesc_2 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149977_tempBattleDesc_3 = {
    Text = "임시로 모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]만큼 감소시킵니다. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149978_BattleDesc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다. <SacrificialMark1:봉헌> 1층을 획득합니다."
  },
  Skill_149978_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149978_Name = {
    Text = "따뜻한 축복·피해 증폭"
  },
  Skill_149978_tempBattleDesc_1 = {
    Text = "임시 피해 증폭 +[Arg2]%. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149978_tempBattleDesc_2 = {
    Text = "임시 피해 증폭 +[Arg1]%. <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동합니다."
  },
  Skill_149978_tempBattleDesc_3 = {
    Text = "임시 피해 증폭 +[Arg1]%. 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149979_BattleDesc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다, 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다. 1 층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149979_Desc_0 = {
    Text = "<BlessingNegativeEffect:대가>가 있는 <Blessing:선물> 1개와 1층 <SacrificialMark1:봉헌>을 획득합니다."
  },
  Skill_149979_Name = {
    Text = "바로 내려지는 축복·은열쇠 에너지"
  },
  Skill_149979_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 점 은열쇠 에너지를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149979_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2 턴 후 발동합니다."
  },
  Skill_149979_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 자신에게 무작위 1 종류의 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149995_Desc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149995_Name = {
    Text = "호화로운 축복·피해 증폭"
  },
  Skill_149995_tempBattleDesc_1 = {
    Text = "임시 피해 증폭 +[Arg2]%, <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149995_tempBattleDesc_2 = {
    Text = "임시 피해 증폭 +[Arg1]%, <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_149995_tempBattleDesc_3 = {
    Text = "임시 피해 증폭 +[Arg1]%, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149996_Desc = {
    Text = "카드 [Arg1]장을 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_149996_Name = {
    Text = "따뜻한 축복·드로우"
  },
  Skill_149996_tempBattleDesc_1 = {
    Text = "카드를 [Arg2]장 뽑습니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149996_tempBattleDesc_2 = {
    Text = "카드를 [Arg1]장 뽑습니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_149996_tempBattleDesc_3 = {
    Text = "카드를 [Arg1]장 뽑고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149997_Desc = {
    Text = "카드를 [Arg1] 장 뽑습니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149997_Name = {
    Text = "바로 내려지는 축복·드로우"
  },
  Skill_149997_tempBattleDesc_1 = {
    Text = "카드를 [Arg2]장 뽑습니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149997_tempBattleDesc_2 = {
    Text = "카드를 [Arg1]장 뽑습니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_149997_tempBattleDesc_3 = {
    Text = "카드를 [Arg1]장 뽑고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149998_Desc = {
    Text = "[Arg1] 점 행동력을 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149998_Name = {
    Text = "바로 내려지는 축복·행동력"
  },
  Skill_149998_tempBattleDesc_1 = {
    Text = "[Arg2] 행동력을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149998_tempBattleDesc_2 = {
    Text = "[Arg1] 행동력을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_149998_tempBattleDesc_3 = {
    Text = "[Arg1] 행동력을 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_149999_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg1] 점 감소시킵니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_149999_Name = {
    Text = "바로 내려지는 축복·고갈"
  },
  Skill_149999_tempBattleDesc_1 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2] 점 임시 감소시킵니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_149999_tempBattleDesc_2 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시킵니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_149999_tempBattleDesc_3 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시키고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150000_Desc = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_150000_Name = {
    Text = "따뜻한 축복·광기"
  },
  Skill_150000_tempBattleDesc_1 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg2]>점을 획득합니다, <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150000_tempBattleDesc_2 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다, <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동됩니다."
  },
  Skill_150000_tempBattleDesc_3 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다, 자신에게 무작위 <Bleesing_Negative:은폐된 살의> 효과 1종을 부여합니다."
  },
  Skill_150001_Desc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150001_Name = {
    Text = "바로 내려지는 축복·피해 증폭"
  },
  Skill_150001_tempBattleDesc_1 = {
    Text = "임시 피해 증폭 +[Arg2]%, <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150001_tempBattleDesc_2 = {
    Text = "임시 피해 증폭 +[Arg1]%, <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150001_tempBattleDesc_3 = {
    Text = "임시 피해 증폭 +[Arg1]%, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150002_Desc = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150002_Name = {
    Text = "호화로운 축복·광기"
  },
  Skill_150002_tempBattleDesc_1 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg2]>점을 획득합니다, <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150002_tempBattleDesc_2 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다, <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동됩니다."
  },
  Skill_150002_tempBattleDesc_3 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다, 자신에게 무작위 <Bleesing_Negative:은폐된 살의> 효과 1종을 부여합니다."
  },
  Skill_150003_Desc = {
    Text = "행동력 [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_150003_Name = {
    Text = "따뜻한 축복·행동력"
  },
  Skill_150003_tempBattleDesc_1 = {
    Text = "[Arg2] 행동력을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150003_tempBattleDesc_2 = {
    Text = "[Arg1] 행동력을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150003_tempBattleDesc_3 = {
    Text = "[Arg1] 행동력을 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150004_Desc = {
    Text = "은열쇠 에너지 <Posse:[Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150004_Name = {
    Text = "호화로운 축복·은열쇠 에너지"
  },
  Skill_150004_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 은열쇠 에너지를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150004_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 은열쇠 에너지를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150004_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150005_Desc = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150005_Name = {
    Text = "바로 내려지는 축복·힘"
  },
  Skill_150005_tempBattleDesc_1 = {
    Text = "<PowerIconKeywords:힘>을 [Arg2] 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150005_tempBattleDesc_2 = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150005_tempBattleDesc_3 = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150006_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]점 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150006_Name = {
    Text = "호화로운 축복·고갈"
  },
  Skill_150006_tempBattleDesc_1 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2] 점 임시 감소시킵니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150006_tempBattleDesc_2 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시킵니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150006_tempBattleDesc_3 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시키고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150007_Desc = {
    Text = "임시 피해 증폭 +[Arg1]%. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_150007_Name = {
    Text = "따뜻한 축복·피해 증폭"
  },
  Skill_150007_tempBattleDesc_1 = {
    Text = "임시 피해 증폭 +[Arg2]%, <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150007_tempBattleDesc_2 = {
    Text = "임시 피해 증폭 +[Arg1]%, <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150007_tempBattleDesc_3 = {
    Text = "임시 피해 증폭 +[Arg1]%, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150008_Desc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150008_Name = {
    Text = "바로 내려지는 축복·은열쇠 에너지"
  },
  Skill_150008_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 은열쇠 에너지를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150008_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 은열쇠 에너지를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150008_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150009_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_150009_Name = {
    Text = "따뜻한 축복·힘"
  },
  Skill_150009_tempBattleDesc_1 = {
    Text = "<PowerIconKeywords:힘>을 [Arg2] 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150009_tempBattleDesc_2 = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150009_tempBattleDesc_3 = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150010_Desc = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]점 임시로 감소시킵니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_150010_Name = {
    Text = "따뜻한 축복·고갈"
  },
  Skill_150010_tempBattleDesc_1 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2] 점 임시 감소시킵니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150010_tempBattleDesc_2 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시킵니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150010_tempBattleDesc_3 = {
    Text = "모든 적의 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1] 점 임시 감소시키고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150011_Desc = {
    Text = "모든 각성체가 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. 주의! <Bleesing_Exaggerate:허풍> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150011_Name = {
    Text = "바로 내려지는 축복·광기"
  },
  Skill_150011_tempBattleDesc_1 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg2]>점을 획득합니다, <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150011_tempBattleDesc_2 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다, <Bleesing_Delay:놓쳐진 기회>: 2턴 후에 발동됩니다."
  },
  Skill_150011_tempBattleDesc_3 = {
    Text = "모든 각성체가 광기 <Energy:[Energy:Arg1]>점을 획득합니다, 자신에게 무작위 <Bleesing_Negative:은폐된 살의> 효과 1종을 부여합니다."
  },
  Skill_150012_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150012_Name = {
    Text = "호화로운 축복·힘"
  },
  Skill_150012_tempBattleDesc_1 = {
    Text = "<PowerIconKeywords:힘>을 [Arg2] 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150012_tempBattleDesc_2 = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150012_tempBattleDesc_3 = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150013_Desc = {
    Text = "행동력 [Arg1]점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150013_Name = {
    Text = "호화로운 축복·행동력"
  },
  Skill_150013_tempBattleDesc_1 = {
    Text = "[Arg2] 행동력을 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150013_tempBattleDesc_2 = {
    Text = "[Arg1] 행동력을 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150013_tempBattleDesc_3 = {
    Text = "[Arg1] 행동력을 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150014_Desc = {
    Text = "카드 [Arg1]장을 뽑습니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Negative:은폐된 살의> 효과가 포함되어 있습니다."
  },
  Skill_150014_Name = {
    Text = "호화로운 축복·드로우"
  },
  Skill_150014_tempBattleDesc_1 = {
    Text = "카드를 [Arg2]장 뽑습니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150014_tempBattleDesc_2 = {
    Text = "카드를 [Arg1]장 뽑습니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150014_tempBattleDesc_3 = {
    Text = "카드를 [Arg1]장 뽑고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_150015_Desc = {
    Text = "은열쇠 에너지 <Posse:[Arg1]>점을 획득합니다. 주의! <Bleesing_Delay:놓쳐진 기회> 또는 <Bleesing_Exaggerate:허풍> 효과가 포함되어 있습니다."
  },
  Skill_150015_Name = {
    Text = "따뜻한 축복·은열쇠 에너지"
  },
  Skill_150015_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 은열쇠 에너지를 획득합니다. <Bleesing_Exaggerate:허풍>: 효과가 50% 감소합니다."
  },
  Skill_150015_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 은열쇠 에너지를 획득합니다. <Bleesing_Delay:놓쳐진 기회>: 2턴 후 발동됩니다."
  },
  Skill_150015_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득하고, 자신에게 무작위 1종 <Bleesing_Negative:은폐된 살의> 효과를 부여합니다."
  },
  Skill_19313_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <Block:[Block:Arg1]>의 실타래드와 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19313_Name_1 = {
    Text = "겨울밤의 추억"
  },
  Skill_19314_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19314_Name_1 = {Text = "타격"},
  Skill_19315_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 시작 시, 긍정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 획득한다. 적이 매 턴 처음으로 「열쇠 지령」을 사용할 때 <PVPDerivativeCardKeywords_3:「화려한 풍경」> [Arg1]장을 손에 넣는다."
  },
  Skill_19315_Name_1 = {
    Text = "소리 없는 잔치"
  },
  Skill_19316_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시 <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_19316_Name_1 = {
    Text = "아쿠트의 봄"
  },
  Skill_19320_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_19320_Name_1 = {
    Text = "죽음을 넘어"
  },
  Skill_19321_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 사망 후, 다음 턴 시작 시 자신을 <PVPResurrectionKeywords:소생>하고 <Heal:[Heal:Arg1]> 생명력과 <Block:[Block:Arg2]> 보호막을 획득하며 이 「운명의 바퀴」를 파괴합니다."
  },
  Skill_19321_Name_1 = {Text = "활성"},
  Skill_19322_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]> 피해를 주고, <Energy:[Energy:Arg2]> 광기를 획득한다."
  },
  Skill_19322_Name_1 = {Text = "타격"},
  Skill_19323_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 패 상한 + [Arg2]. 턴 종료 시, 패에 있는 랜덤 「스킬」 [Arg1] 장의 복사본을 획득합니다."
  },
  Skill_19323_Name_1 = {
    Text = "재회의 순간"
  },
  Skill_19324_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 매 턴 처음 [Arg2] 장의 「스킬」이 소모하는 산력 - [Arg1]."
  },
  Skill_19324_Name_1 = {Text = "명오"},
  Skill_19327_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 카드 [Arg1]장을 드로우한다."
  },
  Skill_19327_Name_1 = {Text = "탐욕"},
  Skill_19328_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19328_Name_1 = {Text = "타격"},
  Skill_19329_Desc_1 = {
    Text = "아군 1명을 <PVPResurrectionKeywords:소생>시키고 <ComaKeywords:실타래신>시키며, <Block:[Block:Arg1]> 방어막를 부여합니다. 해당 아군이 다음 턴 시작 시에도 사망 상태라면, 이 키오더 효과를 1회 재발동합니다."
  },
  Skill_19329_Name_1 = {
    Text = "영원한 집착"
  },
  Skill_19329_UnknownName = {
    Text = "영원한 집착"
  },
  Skill_19331_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]> 피해를 주고 <Energy:[Energy:Arg2]> 광기를 획득한다."
  },
  Skill_19331_Name_1 = {Text = "타격"},
  Skill_19334_Desc_1 = {
    Text = "지정한 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_19334_Name_1 = {
    Text = "주사 수호"
  },
  Skill_19334_UnknownName = {
    Text = "주사 수호"
  },
  Skill_19337_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19337_Name_1 = {Text = "타격"},
  Skill_19339_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19339_Name_1 = {Text = "타격"},
  Skill_19340_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 양측이 모든 손패를 버리고, 버린 카드 수 + 1장의 카드를 드로우한다."
  },
  Skill_19340_Name_1 = {
    Text = "행복한 매직 쇼"
  },
  Skill_19341_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:턴 종료 시 자신이 <Energy:[Energy:Arg1]> 광기를 획득하고, 남은 모든 연산력을 소모하며, 연산력 1을 소모할 때마다 획득 광기가 [Arg3] 증가한다."
  },
  Skill_19341_Name_1 = {
    Text = "은밀한 탄생"
  },
  Skill_19342_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 자신에게 <ComaKeywords:기절>을 부여한다. 「광기 폭발」 전에 모든 아군의 부정 상태를 해제한다."
  },
  Skill_19342_Name_1 = {
    Text = "귀족의 지팡이"
  },
  Skill_19343_Desc_1 = {
    Text = "다른 랜덤한 「열쇠 지령」 [Arg1]장을 확인하고, 1장을 선택하여 손에 넣는다."
  },
  Skill_19343_Name_1 = {
    Text = "불평등한 교환"
  },
  Skill_19343_UnknownName = {
    Text = "불평등한 교환"
  },
  Skill_19346_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19346_Name_1 = {Text = "타격"},
  Skill_19349_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 자신에게 <ComaKeywords:기절>을 부여한다. 「광기 폭발」 전에 모든 적의 긍정 상태를 해제한다."
  },
  Skill_19349_Name_1 = {Text = "섬망"},
  Skill_19350_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:턴 시작 시, 자신에게 <PVPSeriousInjuryKeywords:중창>을 입히고 <Damage:[Damage:Arg1]> 층 <PVPCorrosionKeywords:죄인>을 획득한다. 턴 종료 시, 자신을 <ReinforceKeywords:강고>한다."
  },
  Skill_19350_Name_1 = {
    Text = "여왕의 계율"
  },
  Skill_19353_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」으로 자신의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_19353_Name_1 = {Text = "흡입"},
  Skill_19354_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 「타격」이 <PVPVulnerabilityIconKeywords:피해 증가> 대상을 공격합니다. 장착 및 턴 종료 시 <EnergyStorageKeywords:축력> [Arg1] 층을 획득합니다."
  },
  Skill_19354_Name_1 = {Text = "임계점"},
  Skill_19355_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [Arg1]% 증가하며, 「타격」이 대상을 선택할 수 있다."
  },
  Skill_19355_Name_1 = {Text = "총애"},
  Skill_19356_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:매 턴 첫 「타격」이 추가로 <Damage:[Damage:Arg1]> 피해를 입히며, <PVPMethysisKeywords:중독>."
  },
  Skill_19356_Name_1 = {
    Text = "고통의 저주"
  },
  Skill_19358_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19358_Name_1 = {Text = "타격"},
  Skill_19360_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19360_Name_1 = {Text = "타격"},
  Skill_19361_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 카드 [Arg1]장을 드로우한다."
  },
  Skill_19361_Name_1 = {Text = "용출"},
  Skill_19363_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 다른 아군이 <Block:[Block:Arg1]>의 실타래드를 획득한다."
  },
  Skill_19363_Name_1 = {
    Text = "존재하지 않는 곳"
  },
  Skill_19364_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:「타격」이 <PVPSeriousInjuryKeywords:중창>을 입히며, 피해가 [Arg1]% 증가하지만, 자신이 피해의 절반만큼 생명력을 잃는다."
  },
  Skill_19364_Name_1 = {
    Text = "고통의 지느러미"
  },
  Skill_19370_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 모든 아군이 <Block:[Block:Arg1]>의 실타래드를 획득한다."
  },
  Skill_19370_Name_1 = {
    Text = "마음의 장벽"
  },
  Skill_19372_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「공격」 데미지량 증가 [Arg1]%, 「광기 폭발」 후 자신의 <PVPPowerIconKeywords:힘>+ [Arg2] 및 「공격」 데미지량 추가 증가 [Arg3]%, 최대 100%."
  },
  Skill_19372_Name_1 = {
    Text = "별하늘의 짐승"
  },
  Skill_19374_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 대상을 선택할 수 있으며, 대상의 <Energy:[Energy:Arg1]> 광기를 감소시킨다."
  },
  Skill_19374_Name_1 = {
    Text = "떠도는 욕망"
  },
  Skill_19378_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19378_Name_1 = {Text = "타격"},
  Skill_19379_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 광기가 가장 낮은 아군이 <Energy:[Energy:Arg1]>의 광기를 획득하고, HP 손실타래이 가장 많은 아군의 HP를 <Heal:[Heal:Arg2]> 회복한다."
  },
  Skill_19379_Name_1 = {
    Text = "자비로운 양육"
  },
  Skill_19380_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19380_Name_1 = {Text = "타격"},
  Skill_19381_Desc_1 = {
    Text = "<PVPHoldingKeywords:보유>: 카드를 사용할 때마다 이 카드는 다른 랜덤한 「명륜」으로 변하고, 그 행동력 소모가 1 감소한다."
  },
  Skill_19381_Name_1 = {
    Text = "영혼의 탄생"
  },
  Skill_19383_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 아군 깨어남체가 죽을 때, 모든 적에게 <Damage:[Damage:Arg1]>의 <PVPBleedingKeywords:출혈> 피해를 준다. 장착한 깨어남체가 죽을 때 추가로 <Damage:[Damage:Arg2]>의 <PVPBleedingKeywords:출혈> 피해를 준다."
  },
  Skill_19383_Name_1 = {
    Text = "산호 여인의 죽음"
  },
  Skill_19384_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명 바퀴>:「광기 폭발」후 [Arg1] 장 「스킬」을 뽑고, 그것을 [Arg2] 장 복사하여 손에 넣는다."
  },
  Skill_19384_Name_1 = {
    Text = "행운의 시간"
  },
  Skill_19387_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 [Arg1]의 행동력을 획득한다. <DelayKeywords:지연>: [Arg2]의 행동력을 차감한다."
  },
  Skill_19387_Name_1 = {
    Text = "기억 증후군"
  },
  Skill_19388_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 <Energy:[Energy:Arg1]> 광기를 획득합니다. 아군 깨어남체가 「광기 폭발」을 발동한 후, 자신이 <DelayKeywords:지연>: <Energy:[Energy:Arg2]> 광기를 획득합니다."
  },
  Skill_19388_Name_1 = {
    Text = "신왕의 찬송가"
  },
  Skill_19389_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 이 카드를 대상이 장착한 「명륜」으로 변화시킨다. 대상이 「명륜」을 장착하지 않았다면 「환상」 [Arg1]장을 획득하고 소모한 행동력을 반환한다."
  },
  Skill_19389_Name_1 = {
    Text = "모험가의 배낭"
  },
  Skill_19391_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19391_Name_1 = {Text = "타격"},
  Skill_19393_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [Arg1]% 증가하며, 자신이 <ReinforceKeywords:보강>을 획득한다."
  },
  Skill_19393_Name_1 = {
    Text = "불굴의 의지"
  },
  Skill_19394_Desc_1 = {
    Text = "카드 [Arg1]장을 드로우하고, [Arg2]의 행동력을 획득한다."
  },
  Skill_19394_Name_1 = {
    Text = "후발제인"
  },
  Skill_19400_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <HPAndShieldMin:HP와 방어막가 가장 낮은> 아군이 [Arg1] 스택의 <PVPProtectiveKeywords:장벽>을 얻는다."
  },
  Skill_19400_Name_1 = {
    Text = "나의 소중한 친구에게"
  },
  Skill_19401_Desc_1 = {
    Text = "[Arg1]의 행동력을 획득한다. <DelayKeywords:지연>: [Arg2]의 행동력을 차감한다."
  },
  Skill_19401_Name_1 = {
    Text = "쥐의 지혜"
  },
  Skill_19401_UnknownName = {
    Text = "쥐의 지혜"
  },
  Skill_19402_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시와 턴 시작 시, 자신에게 <PVPProtectiveKeywords:장벽>이 없으면 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 획득하고, 그렇지 않으면 손에 있는 자신의 행동력 소모가 가장 높은 「스킬」 1장의 행동력 소모를 1 감소시킨다."
  },
  Skill_19402_Name_1 = {
    Text = "신언의 석판"
  },
  Skill_19403_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 손패 상한이 [Arg1] 증가한다."
  },
  Skill_19403_Name_1 = {
    Text = "기억의 나선"
  },
  Skill_19406_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:「광기 폭발」 후 적 전체에게 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:출혈>을 입힌다."
  },
  Skill_19406_Name_1 = {
    Text = "잃어버린 길"
  },
  Skill_19409_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 목표를 1회 공격할 때마다 [Arg1]의 행동력을 획득한다."
  },
  Skill_19409_Name_1 = {
    Text = "속박된 노래"
  },
  Skill_19411_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 주는 피해, 치료 및 방어막 효과가 [Arg1]% 증가하며, 「스킬」 사용 후 <PVPProtectiveKeywords:장벽>이 없을 경우 1스택을 획득한다."
  },
  Skill_19411_Name_1 = {
    Text = "시첩의 끝구절"
  },
  Skill_19412_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」을 사용하면 자신이 <ReinforceKeywords:보강>을 획득한다."
  },
  Skill_19412_Name_1 = {
    Text = "기사의 마음"
  },
  Skill_19413_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19413_Name_1 = {Text = "타격"},
  Skill_19414_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 자신이 부정 효과를 해제할 때 해제할 부정 효과가 없으면 <Heal:[Heal:Arg1]> HP를 회복합니다. 턴 종료 시, <DelayKeywords:지연>: 자신의 부정 상태를 해제합니다."
  },
  Skill_19414_Name_1 = {
    Text = "인도하는 돛"
  },
  Skill_19415_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:「광기 폭발」이 입히는 피해, 치유 및 보호막 효과가 [Arg1]% 증가한다."
  },
  Skill_19415_Name_1 = {
    Text = "장미의 이름으로"
  },
  Skill_19418_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 모든 아군이 <StrengthenKeywords:강화>를 획득한다."
  },
  Skill_19418_Name_1 = {
    Text = "신앙의 힘"
  },
  Skill_19419_Desc_1 = {
    Text = "아군 한 명에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_19419_Name_1 = {Text = "환상"},
  Skill_19420_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <PVPDerivativeCardKeywords_11:「불평등한 교환」> [Arg1]장을 덱에 섞어 넣는다."
  },
  Skill_19420_Name_1 = {
    Text = "정보는 생명"
  },
  Skill_19421_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 자신에게 <StrengthenKeywords:강화>와 <ReinforceKeywords:보강>을 부여한다."
  },
  Skill_19421_Name_1 = {
    Text = "고통을 넘어"
  },
  Skill_19422_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19422_Name_1 = {Text = "타격"},
  Skill_19424_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19424_Name_1 = {Text = "타격"},
  Skill_19425_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19425_Name_1 = {Text = "타격"},
  Skill_19426_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 모든 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_19426_Name_1 = {Text = "은총"},
  Skill_19430_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 처음으로 적의 능동 공격을 받은 후, 그 적에게 [Arg1]의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다."
  },
  Skill_19430_Name_1 = {
    Text = "창백한 후예"
  },
  Skill_19431_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:장비 시와 턴 시작 시, 적 전체에게 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:출혈>을 입히며, 대상의 손패 1장당 추가로 [Arg2] <PVPBleedingKeywords:출혈>을 입힌다."
  },
  Skill_19431_Name_1 = {
    Text = "혈육의 광연"
  },
  Skill_19432_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19432_Name_1 = {Text = "타격"},
  Skill_19433_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 자신에게 [Arg2]의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다. 죽은 아군이 1명 있을 때마다 <StrongEffectKeywords:강효> +[Arg1]을 부여한다."
  },
  Skill_19433_Name_1 = {
    Text = "가장 소중한 수집품"
  },
  Skill_19437_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [Arg1]% 증가한다. 공격을 1회 받을 때마다 [Arg2]스택 <EnergyStorageKeywords:차지>를 획득한다."
  },
  Skill_19437_Name_1 = {Text = "폭식"},
  Skill_19438_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, [Arg1]의 임시 <PVPRetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_19438_Name_1 = {Text = "핵 용해"},
  Skill_19439_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19439_Name_1 = {Text = "타격"},
  Skill_19444_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 장착자가 <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 [Arg1] 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_19444_Name_1 = {
    Text = "부패의 선물"
  },
  Skill_19446_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 자신의 부정 상태를 해제하고, [Arg1]스택 <EnergyStorageKeywords:차지>를 획득한다."
  },
  Skill_19446_Name_1 = {
    Text = "사슬을 벗어던진 날"
  },
  Skill_19448_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 적이 [Arg1]번째 「스킬」을 사용할 때, 그 스킬의 행동력 소모가 [Arg2] 감소한 복사본 1장을 손에 넣는다."
  },
  Skill_19448_Name_1 = {Text = "통찰"},
  Skill_19449_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]> 데미지를 주고, <Energy:[Energy:Arg2]> 광기를 획득한다."
  },
  Skill_19449_Name_1 = {Text = "타격"},
  Skill_19451_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 장착한 깨어남체가 처음 사용하는 「스킬」의 피해가 [Arg1]% 증가한다."
  },
  Skill_19451_Name_1 = {
    Text = "거인의 검"
  },
  Skill_19452_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19452_Name_1 = {Text = "타격"},
  Skill_19453_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <PVPDerivativeCardKeywords_2:「환상」> 1장을 획득한다. 손패에 <PVPDerivativeCardKeywords_2:「환상」> 2장이 있을 때마다, 이를 합성하여 <PVPDerivativeCardKeywords_12:「작은 소원」> 1장으로 만든다."
  },
  Skill_19453_Name_1 = {Text = "숙성"},
  Skill_19455_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체가 매 턴 처음으로 「스킬」을 사용한 후, 그 스킬의 행동력 소모가 [Arg1] 감소한 복사본 1장을 덱에 섞어 넣는다."
  },
  Skill_19455_Name_1 = {
    Text = "회전, 회전"
  },
  Skill_19456_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:「타격」「스킬」「광기 폭발」이 가하는 피해, 치료 및 방패가 [Arg3]% 증가하며, <PVPGrowthKeywords:성장> [Arg2]% 증가합니다."
  },
  Skill_19456_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「공격」 「스킬」 「광기 폭발」로 입히는 데미지, 치유 및 방어막 증가 [Arg1]%, <PVPGrowthKeywords:성장> [Arg2]%."
  },
  Skill_19456_Name_1 = {
    Text = "태양의 몰락"
  },
  Skill_19457_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」으로 자신이 <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_19457_Name_1 = {Text = "광란"},
  Skill_19458_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 <HPAndShieldMax:HP와 방어막가 가장 높은> 적을 공격하고, 추가로 피해의 [Arg1]%에 해당하는 <PVPBleedingKeywords:출혈>을 입힌다."
  },
  Skill_19458_Name_1 = {
    Text = "절단과 피해"
  },
  Skill_19460_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 대상을 선택하여 [Arg1]스택 <PVPSlowKeywords:둔화>를 부여하며, 매 턴 첫 번째 대상에게 발동 시 효과가 2배로 증가한다."
  },
  Skill_19460_Name_1 = {
    Text = "망각의 손"
  },
  Skill_19463_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19463_Name_1 = {Text = "타격"},
  Skill_19465_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19465_Name_1 = {Text = "타격"},
  Skill_19466_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <Block:[Block:Arg1]>의 실타래드를 획득하고, 다른 아군이 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_19466_Name_1 = {
    Text = "완성 불가능한 연산"
  },
  Skill_19467_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: HP를 잃어서 획득하는 광기가 2배로 증가한다."
  },
  Skill_19467_Name_1 = {
    Text = "바다의 꿈"
  },
  Skill_19468_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 손패 중 행동력 소모가 가장 높은 카드 1장의 행동력 소모를 [Arg1] 감소시킨다."
  },
  Skill_19468_Name_1 = {
    Text = "정신 집중"
  },
  Skill_19470_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_19470_Name_1 = {
    Text = "기형체의 역습"
  },
  Skill_19471_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <Block:[Block:Arg1]>의 실타래드를 획득한다."
  },
  Skill_19471_Name_1 = {Text = "추방"},
  Skill_19473_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 사용 시 및 턴 종료 시, HP 손실타래이 가장 큰 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_19473_Name_1 = {Text = "희망"},
  Skill_19475_Desc_1 = {
    Text = "모든 손패를 버리고, 버린 수만큼 카드를 드로우한다. 손패가 비어 있으면 랜덤하게 [Arg1]장의 열쇠 지령을 획득한다."
  },
  Skill_19475_Name_1 = {
    Text = "순백의 첫 만남"
  },
  Skill_19475_UnknownName = {
    Text = "순백의 첫 만남"
  },
  Skill_19477_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 사용 시 및 턴 종료 시, 자신이 <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_19477_Name_1 = {Text = "속삭임"},
  Skill_19479_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 이전 턴 마지막에 사용한 「스킬」을 손에 넣고, 그 스킬의 행동력 소모를 1 감소시킨다. 이 효과가 여러 번 발동할 경우 이전 턴으로 거슬러 올라간다."
  },
  Skill_19479_Name_1 = {
    Text = "역행 시계"
  },
  Skill_19483_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <PVPDerivativeCardKeywords_11:「불평등한 교환」> [Arg1]장을 손에 넣는다."
  },
  Skill_19483_Name_1 = {
    Text = "폭우 속에서"
  },
  Skill_19484_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 다른 아군에게 <Energy:[Energy:Arg1]>의 광기를 부여하며, 이 효과로 넘치는 광기는 절반으로 감소하여 장착한 깨어남체에게 반환된다."
  },
  Skill_19484_Name_1 = {
    Text = "책임의 무게"
  },
  Skill_19486_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 사망한 후, 다른 아군에게 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_19486_Name_1 = {
    Text = "죽음의 분석"
  },
  Skill_19487_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 최대 산출력 1포인트당 <PVPCapKeywords:><HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 [Arg1] <PVPBleedingKeywords:출혈>을 부여하며, 총 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:출혈> 피해를 입힌다."
  },
  Skill_19487_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 최대 산출력 1포인트당 <PVPCapKeywords:><HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 [Arg1] <PVPBleedingKeywords:출혈>을 부여한다."
  },
  Skill_19487_Name_1 = {
    Text = "밤의 그림자 속에서"
  },
  Skill_19489_Desc_1 = {
    Text = "깨어남체 1명을 선택해 광기를 <Energy:[Energy:Arg1]> 획득한다."
  },
  Skill_19489_Name_1 = {
    Text = "작은 소원"
  },
  Skill_19489_UnknownName = {
    Text = "작은 소원"
  },
  Skill_19493_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [Arg1]% 증가하며, 「광기 폭발」 후 자신의 HP를 <Heal:[Heal:Arg2]> 회복한다."
  },
  Skill_19493_Name_1 = {
    Text = "삼켜진 자장가"
  },
  Skill_19495_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명 바퀴>: 「광기 폭발」 후 <DelayKeywords:지연>: 전체 아군의 <Heal:[Heal:Arg1]> 생명 회복."
  },
  Skill_19495_Name_1 = {
    Text = "폭식 우화"
  },
  Skill_19497_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 모든 적에게 [Arg1]의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  Skill_19497_Name_1 = {Text = "징벌"},
  Skill_19499_Desc_1 = {
    Text = "전체 아군에게 방어막을 <Block:[Block:Arg1]> 부여한다."
  },
  Skill_19499_Name_1 = {
    Text = "머릿속의 소리"
  },
  Skill_19499_UnknownName = {
    Text = "머릿속의 소리"
  },
  Skill_20075_Desc = {
    Text = "전방 적을 물리치다."
  },
  Skill_20075_Name = {
    Text = "위상 변환"
  },
  Skill_20841_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_20841_Name = {
    Text = "피여,끓어라!"
  },
  Skill_20842_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_20842_Name = {
    Text = "피와 모래의 노래"
  },
  Skill_20843_Desc = {
    Text = "[Arg1]의 실타래드를 획득하고, <BleedingIconKeywords:출혈> [Arg2]스택을 부여한다."
  },
  Skill_20843_Name = {
    Text = "피여, 소리질러라!"
  },
  Skill_20844_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_20850_Desc = {
    Text = "「핏빛」의 행동 의도 1회를 낮은 위협의 단일 공격으로 변경한다."
  },
  Skill_20850_Name = {
    Text = "계약의 메아리"
  },
  Skill_20974_Desc = {
    Text = "해당 의도는 '계약의 메아리'로 변경할 수 없다. 「피의 광란·종말」 상태를 획득하며, 일정 수준의 HP를 잃은 후 매우 높은 피해량의 광기 폭발을 방출한다."
  },
  Skill_20974_Name = {Text = "깨어남"},
  Skill_20975_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득하며, 「융식」 2장을 덱에 섞어 넣는다."
  },
  Skill_20975_Name = {
    Text = "피와 모래의 노래·광란"
  },
  Skill_21308_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 공격을 받을 때마다 공격 횟수가 1회 감소하며, 최소 3회까지 감소한다."
  },
  Skill_21308_Name = {
    Text = "혈노의 연격(허점)"
  },
  Skill_21313_Desc_1 = {
    Text = "대상 한 명에게 <PVPVulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_21313_Name_1 = {Text = "취약"},
  Skill_21314_Desc_1 = {
    Text = "대상 한 명에게 <StrengthenKeywords:강화>를 부여한다."
  },
  Skill_21314_Name_1 = {Text = "강화"},
  Skill_21315_Desc_1 = {
    Text = "대상 한 명에게 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_21315_Name_1 = {Text = "허약"},
  Skill_21316_Desc_1 = {
    Text = "대상 한 명에게 <ReinforceKeywords:보강>을 부여한다."
  },
  Skill_21316_Name_1 = {Text = "보강"},
  Skill_21320_Desc_1 = {
    Text = "모든 카드를 버린다."
  },
  Skill_21320_Name_1 = {
    Text = "모든 손패 버리기"
  },
  Skill_21321_Desc_1 = {
    Text = "테스트 명령을 실타래행한다."
  },
  Skill_21321_Name_1 = {
    Text = "테스트 명령"
  },
  Skill_21330_Desc_1 = {
    Text = "대상 한 명에게 <Damage:[Damage:Arg1]>의 피해와 동일한 양의 <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_21330_Name_1 = {Text = "중독"},
  Skill_21332_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고 <ComaKeywords:기절>을 부여한다."
  },
  Skill_21332_Name_1 = {Text = "기절"},
  Skill_21333_Desc_1 = {
    Text = "대상 한 명의 긍정 상태를 해제한다."
  },
  Skill_21333_Name_1 = {
    Text = "긍정 효과 제거"
  },
  Skill_21334_Desc_1 = {
    Text = "대상 한 명에게 <TauntKeywords:도발>을 부여한다."
  },
  Skill_21334_Name_1 = {Text = "도발"},
  Skill_21336_Desc_1 = {
    Text = "목표 하나에게 <DelayKeywords:지연>:<Energy:[Energy:Arg1]> 광기를 부여합니다."
  },
  Skill_21336_Name_1 = {
    Text = "지연 광기"
  },
  Skill_21337_Desc_1 = {
    Text = "대상 한 명에게 임시 <StrengthenKeywords:반격> [Arg1]을 부여한다."
  },
  Skill_21337_Name_1 = {Text = "반격"},
  Skill_21338_Desc_1 = {
    Text = "대상 한 명에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_21338_Name_1 = {Text = "광기"},
  Skill_21339_Desc_1 = {
    Text = "대상 한 명의 부정 상태를 해제한다."
  },
  Skill_21339_Name_1 = {
    Text = "부정 효과 해제"
  },
  Skill_21341_Desc_1 = {
    Text = "대상 한 명에게 <StrengthenKeywords:실타래드>를 부여한다."
  },
  Skill_21341_Name_1 = {Text = "방어막"},
  Skill_21355_Desc_1 = {
    Text = "대상 한 명에게 [Arg1]스택 <PVPSlowKeywords:둔화>를 부여한다."
  },
  Skill_21355_Name_1 = {Text = "둔화"},
  Skill_21356_Desc_1 = {
    Text = "목표에게 <DelayKeywords:지연>: [Arg1]장의 카드를 뽑습니다."
  },
  Skill_21356_Name_1 = {
    Text = "지연 드로우"
  },
  Skill_21357_Desc_1 = {
    Text = "대상 한 명에게서 <Energy:[Energy:Arg1]>의 광기를 제거한다."
  },
  Skill_21357_Name_1 = {
    Text = "광기 상실타래"
  },
  Skill_21361_Desc_1 = {
    Text = "목표 하나에게 <DelayKeywords:지연>: <Heal:[Heal:Arg1]> 생명을 획득시킵니다."
  },
  Skill_21361_Name_1 = {
    Text = "지연 치유"
  },
  Skill_21362_Desc_1 = {
    Text = "<PVPResurrectionKeywords:부활>로 대상 한 명을 부활시키고 <Heal:[Heal:Arg1]>의 생명력을 회복시킨다."
  },
  Skill_21362_Name_1 = {Text = "부활"},
  Skill_21379_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_21403_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_21582_BattleDesc_1 = {
    Text = "모든 카드를 버리고, 목표 덱을 생성하며, 행동력을 50 증가시키고, 광기 1장을 획득한다."
  },
  Skill_21582_Desc_1 = {
    Text = "모든 카드를 버리고, 목표 덱을 생성하며, 행동력을 50 증가시키고, 광기 1장을 획득한다. 이 카드는 100번 사용할 수 있다."
  },
  Skill_21582_Name_1 = {Text = "덱 생성"},
  Skill_21602_Desc_1 = {
    Text = "대상 한 명에게 <EnergyStorageColour:차지> [Arg1]스택을 부여한다."
  },
  Skill_21602_Name_1 = {Text = "차지"},
  Skill_21603_Desc_1 = {
    Text = "대상 한 명에게 <PowerColourKeywords:힘> [Arg1]을 부여한다."
  },
  Skill_21603_Name_1 = {Text = "힘"},
  Skill_21615_AwakerSkillBackgroundStory = {
    Text = "오지에의 기억은 융식 현상으로 인해 산산조각이 났다.\n\n그는 무도회의 웃음소리는 기억하지만, 무도회 주인공의 이름은 잊었다. 그는 기사단에서 훈련받은 것은 기억하지만, 대공이 어린 그를 왜 기사로 삼았는지는 모른다. 그는 자신이 철기병 아래 죽음을 맞이한 것은 기억하지만, 자신이 지켰던 미소가 어떤 것이었는지는 떠올릴 수 없다.\n누구도 그를 탓할 수 없다. 그는 기사가 해야 할 모든 책임을 다했으니—— 지키려는 의지를 위해 목숨을 바치는 것까지."
  },
  Skill_21615_Desc_0 = {
    Text = "자신의 <FragileIconKeywords:손상> 상태를 해제한다. 실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_21615_Desc_2 = {
    Text = "자신이 <FragileIconKeywords:손상> 상태라면, 이를 해제하고 실타래드를 <Block:[Block:Arg3]>pt 추가로 획득한다. 실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_21615_EffectNameList_0 = {
    Text = "실타래드, 힘"
  },
  Skill_21615_EffectNameList_2 = {
    Text = "손상 해제 시 실타래드, 실타래드, 힘"
  },
  Skill_21615_Name = {
    Text = "칠예, 전승된 미덕"
  },
  Skill_21615_OverLimitUtlSkillDesc_0 = {
    Text = "자신의 <FragileIconKeywords:취약> 상태를 해제합니다. <Block:[Block:Arg1]> 점 방어막를 획득합니다. [Power:Arg2] 점 임시 <PowerIconKeywords:힘>을 획득합니다. 획득한 방어막가 200% 증가합니다. 오지에가 가하는 피해 횟수 +1, 3회합 동안 지속됩니다."
  },
  Skill_21615_OverLimitUtlSkillDesc_2 = {
    Text = "자신이 <FragileIconKeywords:취약> 상태면, 이를 해제하고 <Block:<Block:[Block:Arg3]>>의 보호막을 추가로 획득한다. <Block:<Block:[Block:Arg1]>>의 보호막을 획득하고, 이번 턴에 <PowerIconKeywords:힘>을 [Power:Arg2] 획득한다. 획득하는 보호막이 200% 증가한다. 오지에가 3턴간 피해를 주는 횟수가 1회 증가한다."
  },
  Skill_21615_PropertyNameList_0 = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_21615_PropertyNameList_2 = {
    Text = "방어력*GrowValue3, 방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_21620_AwakerSkillBackgroundStory = {
    Text = "이성은 그녀의 시각을 결정하고, 진리는 그녀의 사고의 폭을 구축하며, 현실타래은 그녀의 도덕적 기준을 속박합니다. \n이 세기의 천재에게 있어 과학 또한 하나의 철학입니다."
  },
  Skill_21620_Desc_0 = {
    Text = "자신의 <VulnerabilityIconKeywords:취약> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복하며, 다른 깨어남체들이 광기를 [Energy:Arg2]pt 획득한다."
  },
  Skill_21620_Desc_3 = {
    Text = "자신의 <VulnerabilityIconKeywords:취약> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복하며, 모든 깨어남체가 광기를 [Energy:Arg2]pt 획득한다."
  },
  Skill_21620_EffectNameList_0 = {
    Text = "회복, 광기"
  },
  Skill_21620_EffectNameList_7 = {
    Text = "회복, 광기, 턴당 회복"
  },
  Skill_21620_Name = {
    Text = "이성, 진리와 현실타래"
  },
  Skill_21620_OverLimitUtlSkillDesc_0 = {
    Text = "자신의 <VulnerabilityIconKeywords:취약> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복하며, 다른 깨어남체가 광기를 [Energy:Arg2]pt 획득한다. 3턴 동안 턴 시작 시 HP를 <Heal:[Heal:Arg3]>pt 회복한다."
  },
  Skill_21620_OverLimitUtlSkillDesc_3 = {
    Text = "자신의 <VulnerabilityIconKeywords:취약> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복하며, 모든 깨어남체가 광기를 [Energy:Arg2]pt 획득한다. 3턴 동안 턴 시작 시 HP를 <Heal:[Heal:Arg3]>pt 회복한다."
  },
  Skill_21620_PropertyNameList_0 = {
    Text = "체질*GrowValue1,$GrowValue2"
  },
  Skill_21620_PropertyNameList_7 = {
    Text = "체질*GrowValue1,$GrowValue2, 체질*GrowValue3"
  },
  Skill_21663_Desc = {
    Text = "<MadnessIconKeywords:광란>을 [Arg1]스택 획득한다. 깨어남 후, 매 턴마다 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 각각 3스택 제거한다."
  },
  Skill_21663_Name = {
    Text = "전투의 욕망"
  },
  Skill_21668_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_21672_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:30]> 피해를 준다."
  },
  Skill_21672_Name_1 = {
    Text = "범위 피해 부여"
  },
  Skill_21721_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전체 아군이 <Block:[Block:Arg3]>pt의 실타래드를 획득하며, <DerivativeCardKeywords_26:「증상:망상」> 2장을 덱에 섞어 넣는다."
  },
  Skill_21721_Name = {
    Text = "은밀한 기습"
  },
  Skill_21783_Desc_1 = {
    Text = "대상 한 명을 처치한다."
  },
  Skill_21783_Name_1 = {Text = "처치"},
  Skill_21837_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_21837_Name = {
    Text = "물어뜯기"
  },
  Skill_21902_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다!"
  },
  Skill_21939_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_21939_Name = {Text = "출혈"},
  Skill_21940_Desc = {
    Text = "[Arg1]스택의 기도 상태를 획득한다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택을 잃고, 턴 종료 시 모두 사라진다."
  },
  Skill_21940_Name = {Text = "기도"},
  Skill_21948_Desc = {
    Text = "기도 [Arg1]스택을 획득한다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택 감소하고, 턴 종료 시 모두 소진된다."
  },
  Skill_21948_Name = {Text = "기도"},
  Skill_21949_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_21949_Name = {Text = "출혈"},
  Skill_22056_Desc = {
    Text = "[Arg2]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_22056_Name = {
    Text = "복수 선언"
  },
  Skill_22152_Desc = {
    Text = "<Block:[Block:Arg1]>의 <CardKeyWord:서리 방패>를 획득하고, 플레이어에게 <WeaknessIconKeywords:허약>을 [Arg2]턴간 부여한다."
  },
  Skill_22152_Name = {
    Text = "심해의 부름"
  },
  Skill_22153_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_22154_Desc = {
    Text = "사망 시, 자신과 동일한 HP를 가진 「바다 속의 존재」 2개로 분열한다."
  },
  Skill_22154_Name = {Text = "분열"},
  Skill_22155_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 다음 턴 시작 시 <DerivativeCardKeywords_80:「질식」> [Arg3]장을 손에 넣는다."
  },
  Skill_22156_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_22162_Desc = {
    Text = "<Block:[Block:Arg1]>의 <CardKeyWord:서리 방패>를 획득하고, 플레이어에게 <WeaknessIconKeywords:허약>을 [Arg2]턴간 부여한다."
  },
  Skill_22162_Name = {
    Text = "심해의 부름"
  },
  Skill_22196_Desc = {
    Text = "<Block:[Block:Arg1]>의 <CardKeyWord:서리 방패>를 획득하고, 플레이어에게 <WeaknessIconKeywords:허약>을 [Arg2]턴간 부여한다."
  },
  Skill_22196_Name = {
    Text = "심해의 부름"
  },
  Skill_22197_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_22198_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 다음 턴에 <DerivativeCardKeywords_80:「질식」> [Arg3]장을 획득한다."
  },
  Skill_22199_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_22209_Desc_1 = {
    Text = "상대가 명령 카드와 「타격」을 사용하지 못하게 한다."
  },
  Skill_22209_Name_1 = {
    Text = "슈퍼 둔화"
  },
  Skill_22212_Desc_1 = {
    Text = "대상 한 명에게 <EnergyStorageColour:사투> [Arg1]을 부여한다."
  },
  Skill_22212_Name_1 = {Text = "사투"},
  Skill_22218_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 맨 위의 카드 [Arg3]장에게 <PVPSlowKeywords:둔화> [Arg4]스택을 부여한다."
  },
  Skill_22218_Name = {
    Text = "한기 공격"
  },
  Skill_22233_Desc = {
    Text = "「차원 간섭형 융식체」로 진화한다. 현재 HP가 높을수록 진화한 괴물이 더 강해진다."
  },
  Skill_22233_Name = {
    Text = "융식 진화"
  },
  Skill_22234_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_45:「차원 폐쇄」> 1장을 손에 넣는다."
  },
  Skill_22234_Name = {
    Text = "차원 봉쇄"
  },
  Skill_22306_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 <CardKeyWord:서리 방패>를 획득한다."
  },
  Skill_22306_Name = {
    Text = "얼음 방패 타격"
  },
  Skill_22316_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2] 회 입힙니다. 플레이어에게 <CardKeyWord:“노도의 인장”>이 표시된 랜덤 카드 [Arg3] 장을 부여합니다: 이 표시가 있는 카드를 사용하면 현재 턴에 몬스터의 공격 횟수가 +1 증가하며, 노도의 인장은 발동 후 제거됩니다."
  },
  Skill_22316_Name = {
    Text = "노도의 이끌림"
  },
  Skill_22317_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 이번 턴에 공격을 1회 받을 때마다 임시 <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_22317_Name = {
    Text = "거대한 검의 참격"
  },
  Skill_22318_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 기생 [Arg3]스택을 부여한다."
  },
  Skill_22318_Name = {Text = "뼈 침식"},
  Skill_22319_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt와 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시, 보유한 스택만큼 HP를 회복하며, HP 5pt를 잃을 때마다 1스택 감소한다."
  },
  Skill_22319_Name = {Text = "심잠"},
  Skill_22320_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_22320_Name = {Text = "베기"},
  Skill_22331_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_22332_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_22333_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 번 주고, [Arg3] 턴 동안 <CardKeyWord:상처>를 부여합니다. 상처: 「타격」을 사용한 후, 드로우 덱 맨 위에 2장의 「상처」 카드를 추가합니다."
  },
  Skill_22333_Name = {
    Text = "상처 강타"
  },
  Skill_22344_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_22345_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 번 주고, [Arg3] 턴 동안 <CardKeyWord:상처>를 부여합니다. 상처: 「타격」을 사용한 후, 드로우 덱 맨 위에 2장의 「상처」 카드를 추가합니다."
  },
  Skill_22345_Name = {
    Text = "상처 타격"
  },
  Skill_22346_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, <FragileIconKeywords:손상>을 [Arg2]턴간 부여한다."
  },
  Skill_22698_Desc_1 = {
    Text = "무작위로 1~[Arg1]장의 <PVPDerivativeCardKeywords_2:「환상」>을 덱에 섞어 넣는다."
  },
  Skill_22698_Name_1 = {
    Text = "환상을 덱에 넣기"
  },
  Skill_22700_Desc = {
    Text = "[Arg2]턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_22700_Name = {
    Text = "차원 안개"
  },
  Skill_23407_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 현재 <RetaliateIconKeywords:반격>과 동일한 양의 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_23407_Name = {
    Text = "역린의 수호"
  },
  Skill_23408_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_23409_Desc = {
    Text = "현재 <RetaliateIconKeywords:반격>과 동일한 양의 <PowerIconKeywords:힘>을 획득한다. 이후 매 턴마다 <RetaliateIconKeywords:반격>을 [Arg1] 스택 추가로 획득한다."
  },
  Skill_23409_Name = {
    Text = "변신하는 몸"
  },
  Skill_23410_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <RetaliateIconKeywords:반격> [Arg3]스택을 획득한다."
  },
  Skill_23410_Name = {
    Text = "파쇄된 칼"
  },
  Skill_23411_Desc = {
    Text = "실타래드를 [Arg2]pt 및 재생력 [Arg1]스택을 획득한다. 재생력: 턴 종료 시, 보유한 스택만큼 HP를 회복하며, HP 5pt를 잃을 때마다 1스택 감소한다."
  },
  Skill_23411_Name = {
    Text = "이단의 혈통"
  },
  Skill_23467_Desc = {
    Text = "3개의 의도 중 2개를 선택하여 다포딜의 행동 의도에 추가한다."
  },
  Skill_23467_Name = {
    Text = "천면환상·실타래"
  },
  Skill_23468_Desc = {
    Text = "3개의 의도 중 2개를 선택하여 다포딜의 행동 의도에 추가한다."
  },
  Skill_23468_Name = {
    Text = "천면환상·실타래"
  },
  Skill_23469_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「증상:섬망」과 「증상:맹종」을 덱에 섞어 넣는다."
  },
  Skill_23469_Name = {
    Text = "콤보+증상"
  },
  Skill_23470_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈> [Arg3]스택을 부여한다."
  },
  Skill_23470_Name = {
    Text = "콤보+출혈"
  },
  Skill_23471_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체의 광기를 [Arg3] 감소시킨다."
  },
  Skill_23471_Name = {
    Text = "콤보+광기 감소"
  },
  Skill_23472_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 적의 <PowerIconKeywords:힘>을 [Arg3] 감소시킨다."
  },
  Skill_23472_Name = {
    Text = "피해+힘 감소"
  },
  Skill_23473_Desc = {
    Text = "「증상:섬망」과 「증상:맹종」을 덱에 섞어 넣는다."
  },
  Skill_23473_Name = {
    Text = "필름 VL-13"
  },
  Skill_23474_Desc = {
    Text = "모든 깨어남체의 광기를 [Arg1] 감소시킨다."
  },
  Skill_23474_Name = {
    Text = "필름 VL-9"
  },
  Skill_23475_Desc = {
    Text = "공격 시 <BleedingIconKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_23475_Name = {
    Text = "필름 VL-7"
  },
  Skill_23476_Desc = {
    Text = "힘 감소 [Arg1]스택을 부여한다."
  },
  Skill_23476_Name = {
    Text = "반짝이는 머리"
  },
  Skill_23477_Desc = {
    Text = "공격 횟수가 1회 증가한다."
  },
  Skill_23477_Name = {
    Text = "시끄러운 머리"
  },
  Skill_23478_Desc = {
    Text = "취약을 2스택 부여한다."
  },
  Skill_23478_Name = {
    Text = "포효하는 머리"
  },
  Skill_23479_Desc = {
    Text = "실타래드를 [Arg1]pt 획득한다."
  },
  Skill_23480_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_23481_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어의 덱과 버린 카드 더미에 각각 <DerivativeCardKeywords_45:「차원 폐쇄」> 1장을 섞어 넣는다."
  },
  Skill_23481_Name = {
    Text = "원질의 바다"
  },
  Skill_23482_Desc = {
    Text = "실타래드를 [Arg1]pt 획득한다."
  },
  Skill_23483_Desc = {
    Text = "「천면환상」 효과 강화: 의도를 두 번 선택한다. 버릴 경우 모든 깨어남체가 광기 20을 잃고, 「증상」 카드 5장을 덱에 섞어 넣는다."
  },
  Skill_23483_Name = {
    Text = "차원 투영"
  },
  Skill_23484_Desc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다."
  },
  Skill_23484_Name = {
    Text = "실타래드+피해"
  },
  Skill_23485_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈> [Arg3]스택을 부여하며, 「증상:섬망」 2장을 덱에 넣는다."
  },
  Skill_23485_Name = {
    Text = "콤보+출혈+증상"
  },
  Skill_23486_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체의 광기를 [Arg3] 감소시키며, 「증상:섬망」 2장을 덱에 넣는다."
  },
  Skill_23486_Name = {
    Text = "콤보+광기 감소+증상"
  },
  Skill_23487_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_23488_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_23489_Desc = {
    Text = "3개의 의도 중 2개를 선택하여 다포딜의 행동 의도에 추가한다."
  },
  Skill_23489_Name = {
    Text = "천면환상·실타래"
  },
  Skill_23490_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_23490_Name = {
    Text = "목을 자르는 일격"
  },
  Skill_23491_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 힘이 [Arg2] 증가한다."
  },
  Skill_23491_Name = {
    Text = "실타래드+힘"
  },
  Skill_23492_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 다포딜의 모든 부정 상태를 해제한다."
  },
  Skill_23492_Name = {Text = "방어막"},
  Skill_23493_Desc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다."
  },
  Skill_23493_Name = {
    Text = "실타래드+피해"
  },
  Skill_23494_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체의 광기를 [Arg3] 감소시키며, <BleedingIconKeywords:출혈> [Arg4]스택을 부여하고, 「증상:섬망」과 「증상:맹종」을 덱에 섞어 넣는다."
  },
  Skill_23494_Name = {
    Text = "천면환상"
  },
  Skill_23495_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  Skill_23495_Name = {
    Text = "피해+취약"
  },
  Skill_23496_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 적의 <PowerIconKeywords:힘>을 [Arg3]pt 감소시키며, <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  Skill_23496_Name = {
    Text = "피해+취약+힘 감소"
  },
  Skill_23497_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다."
  },
  Skill_23497_Name = {
    Text = "뇌를 먹는 수선화"
  },
  Skill_23498_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 다포딜의 모든 부정 상태를 해제한다."
  },
  Skill_23498_Name = {
    Text = "부생의 수선화"
  },
  Skill_23499_Desc = {
    Text = "힘이 [Arg1] 증가한다."
  },
  Skill_23499_Name = {
    Text = "식육 수선화"
  },
  Skill_23500_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 적의 <PowerIconKeywords:힘>을 [Arg3]pt 감소시키며, <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  Skill_23500_Name = {
    Text = "천면환상"
  },
  Skill_23501_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_23501_Name = {Text = "피해"},
  Skill_23502_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 적의 <PowerIconKeywords:힘>을 [Arg3] 감소시킨다."
  },
  Skill_23502_Name = {
    Text = "피해+힘 감소"
  },
  Skill_23503_Desc = {
    Text = "[Arg1]의 실타래드를 획득하고, 힘이 [Arg2] 증가한다."
  },
  Skill_23503_Name = {
    Text = "실타래드+힘"
  },
  Skill_23504_Desc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히며, <PowerIconKeywords:힘>을 [Arg4]pt 획득한다."
  },
  Skill_23504_Name = {
    Text = "실타래드+피해+힘"
  },
  Skill_23505_Desc = {
    Text = "3개의 의도 중 1개를 선택하여 다포딜의 행동 의도에 추가한다."
  },
  Skill_23505_Name = {
    Text = "천면환상·허"
  },
  Skill_23506_Desc = {
    Text = "3개의 의도 중 1개를 선택하여 다포딜의 행동 의도에 추가한다."
  },
  Skill_23506_Name = {
    Text = "천면환상·허"
  },
  Skill_23507_Desc = {
    Text = "3개의 의도 중 1개를 선택하여 다포딜의 행동 의도에 추가한다."
  },
  Skill_23507_Name = {
    Text = "천면환상·허"
  },
  Skill_23508_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  Skill_23508_Name = {
    Text = "피해+취약"
  },
  Skill_23509_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_23509_Name = {
    Text = "목을 자르는 일격"
  },
  Skill_23510_Desc = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히며, <PowerIconKeywords:힘>을 [Arg4]pt 획득한다. 다포딜의 모든 부정 상태를 해제한다."
  },
  Skill_23510_Name = {
    Text = "천면환상"
  },
  Skill_23511_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈> [Arg3]스택을 부여하며, 모든 깨어남체의 광기를 [Arg4] 감소시킨다."
  },
  Skill_23511_Name = {
    Text = "콤보+출혈+광기 감소"
  },
  Skill_23729_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 준다. 방어되지 않은 피해를 입힐 때마다 <FragileIconKeywords:손상> 1스택을 부여한다."
  },
  Skill_23729_Name = {Text = "사냥"},
  Skill_23756_Desc = {
    Text = "사용 후 [Arg1] 점 <FixedDamage:순수 피해>를 받고, 카드 2장 드로우."
  },
  Skill_23756_Name = {Text = "조커"},
  Skill_23758_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어가 이번 턴에 마지막으로 사용한 명령 카드를 덱 맨 위로 되돌리며, 다음 턴에 상대가 드로우하는 카드 수가 1 감소한다."
  },
  Skill_23758_Name = {
    Text = "허공 집기"
  },
  Skill_23761_Desc = {
    Text = "카시아가 「환영 이동」을 획득한다. 상대가 카드를 10장 사용한 후, 즉시 생명력이 낮은 「분신」을 전방에 소환한다."
  },
  Skill_23761_Name = {Text = "깨어남"},
  Skill_23810_Desc = {
    Text = "<TouquKeywords:영구 탈취>로 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 다음 턴 시작 시 상대의 뽑는 카드 수가 3 감소하며, 덱 맨 위의 카드 3장을 공개하고 상대가 1장을 선택하여 손에 넣는다."
  },
  Skill_23810_Name = {
    Text = "모두 사라져라!"
  },
  Skill_23811_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 행동력 소모가 3인 「폭탄」 1장을 즉시 손에 넣는다. 후디니가 보유한 「의기양양」 1스택당 「폭탄」의 행동력 소모가 1 감소한다."
  },
  Skill_23811_Name = {
    Text = "공허로부터"
  },
  Skill_23812_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_23812_Name = {
    Text = "마술 카드: 관통"
  },
  Skill_23813_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「모독의 환영」 5장을 손에 넣는다. 후디니가 보유한 「의기양양」 1스택당 「모독의 환영」 1장을 「영감」으로 교체한다."
  },
  Skill_23813_Name = {
    Text = "플라잉 카드"
  },
  Skill_23814_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 손패, 덱, 버린 카드 더미에 각각 「조커」 5장을 넣는다."
  },
  Skill_23814_Name = {
    Text = "마술 카니발"
  },
  Skill_23815_Desc = {
    Text = "자신의 앞에 「후디니」의 인형을 소환한다. 「의기양양」 1스택당 인형의 최대 HP가 20% 감소하며, 최소 1까지 감소한다."
  },
  Skill_23815_Name = {
    Text = "라이브 액션 스턴트"
  },
  Skill_23816_Desc = {
    Text = "「소모」와 「유지」가 부여된 「행운의 관객」 1장을 상대의 손에 넣는다."
  },
  Skill_23816_Name = {
    Text = "행운의 관객"
  },
  Skill_23817_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_23817_Name = {
    Text = "마술 카드: 쇠약"
  },
  Skill_23818_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_23818_Name = {
    Text = "마법 연타"
  },
  Skill_23819_Desc = {
    Text = "폭탄이 손패에 있는 동안 1턴이 지날 때마다 카운트가 1 증가하며, 카운트가 2에 도달했을 때 턴 종료 시 손패에 있으면 아군 팀에게 <Damage:[Damage:Arg1]> 점 <FixedDamage:순수 피해>를 주고 파괴됩니다. 현재 카운트: <RedQuality:[Arg2]>."
  },
  Skill_23819_Name = {
    Text = "뛰는 폭탄"
  },
  Skill_23820_Desc = {
    Text = "폭탄이 손패에 있는 동안 1턴이 지날 때마다 카운트가 1 증가하며, 카운트가 2에 도달했을 때 턴 종료 시 손패에 있으면 아군 팀에게 <Damage:[Damage:Arg1]> 점 <FixedDamage:순수 피해>를 주고 파괴됩니다. 현재 카운트: <RedQuality:[Arg2]>."
  },
  Skill_23820_Name = {
    Text = "뛰는 폭탄"
  },
  Skill_23821_Desc = {
    Text = "폭탄이 손패에 있는 동안 1턴이 지날 때마다 카운트가 1 증가하며, 카운트가 2에 도달했을 때 턴 종료 시 손패에 있으면 아군 팀에게 <Damage:[Damage:Arg1]> 점 <FixedDamage:순수 피해>를 주고 파괴됩니다. 현재 카운트: <RedQuality:[Arg2]>."
  },
  Skill_23821_Name = {
    Text = "뛰는 폭탄"
  },
  Skill_23822_Desc = {
    Text = "폭탄이 손패에 있는 동안 1턴이 지날 때마다 카운트가 1 증가하며, 카운트가 2에 도달했을 때 턴 종료 시 손패에 있으면 아군 팀에게 <Damage:[Damage:Arg1]> 점 <FixedDamage:순수 피해>를 주고 파괴됩니다. 현재 카운트: <RedQuality:[Arg2]>."
  },
  Skill_23822_Name = {
    Text = "뛰는 폭탄"
  },
  Skill_24173_Desc_1 = {
    Text = "지정된 모든 깨어남체는 더 이상 죽지 않는다."
  },
  Skill_24173_Name_1 = {
    Text = "죽음 면역"
  },
  Skill_24209_Desc = {
    Text = "현재 HP의 [Arg1]%([Arg2])를 잃고, 「신국의 지체」가 후방 적에게 3배의 피해([Arg3])를 준다. 보스 전투에서는 10배의 피해([Arg4])를 준다."
  },
  Skill_24209_Name = {
    Text = "대행자의 판결"
  },
  Skill_24243_Desc = {
    Text = "다음 목표를 찾고 있다…"
  },
  Skill_24243_Name = {Text = "추적"},
  Skill_24244_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 50pt를 획득한다. 단, 「히드라」에게 [Arg1]pt의 힘을 획득시킨다."
  },
  Skill_24244_Name = {Text = "집착"},
  Skill_24417_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_24417_Name = {
    Text = "신권의 칼날"
  },
  Skill_24418_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_24418_Name = {
    Text = "지고의 산제"
  },
  Skill_24586_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 1회 입히고, 자신이 사망한다."
  },
  Skill_24586_Name = {
    Text = "이별 선물"
  },
  Skill_24587_Desc = {
    Text = "이번 턴에 행동력 소모가 3 이상인 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24587_Name = {
    Text = "「속삭임」\n행동력 ≥3"
  },
  Skill_24604_Desc = {
    Text = "「N」의 모든 분신을 기절시킨다."
  },
  Skill_24604_Name = {
    Text = "장미의 소원"
  },
  Skill_24605_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신에게 「암흑」 1스택과 「혼돈」 4스택을 부여한다. 「암흑」 1스택당 분신을 1개 생성하며, 최대 3개까지 생성된다."
  },
  Skill_24605_Name = {
    Text = "검은 소환"
  },
  Skill_24606_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 손에 「최고의 은총」 1장을 넣는다."
  },
  Skill_24606_Name = {
    Text = "맹목적인 계약"
  },
  Skill_24607_Desc = {
    Text = "행동력 2pt를 획득하고, 분신을 기절시킬 수 있는 「장미의 소원」 1장을 손에 넣으며, 덱의 카드 4장에 <SlowIconKeywords:둔화>를 부여한다."
  },
  Skill_24607_Name = {
    Text = "최고의 은총"
  },
  Skill_24608_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_24609_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전체 아군에게 <RetaliateIconKeywords:반격> [Arg3]스택을 부여한다."
  },
  Skill_24609_Name = {
    Text = "기어오는 안개"
  },
  Skill_24634_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「회귀 역설」 4장을 손에 넣는다."
  },
  Skill_24634_Name = {
    Text = "네 날개의 성장"
  },
  Skill_24635_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「회귀 역설」 6장을 손에 넣는다."
  },
  Skill_24635_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_24636_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「회귀 역설」 2장을 손에 넣는다."
  },
  Skill_24636_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_24637_Desc = {
    Text = "최대 HP가 2배로 증가한다. 턴 시작 시, 「타비에게 답하기」 1장을 손에 넣는다."
  },
  Skill_24637_Name = {Text = "부활"},
  Skill_24638_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고 실타래드를 <Block:[Block:Arg2]>pt 획득하며, 2턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_24638_Name = {
    Text = "날개 펼치기"
  },
  Skill_24646_Desc = {
    Text = "이번 턴에 증상 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24646_Name = {
    Text = "「속삭임」\n증상"
  },
  Skill_24647_Desc = {
    Text = "이번 턴에 카드를 5장 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24647_Name = {
    Text = "「속삭임」\n카드 사용 5장"
  },
  Skill_24648_Desc = {
    Text = "이번 턴에 열쇠 지령을 발동한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24648_Name = {
    Text = "「속삭임」\n열쇠 지령"
  },
  Skill_24649_Desc = {
    Text = "이번 턴에 행동력 소모가 0인 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24649_Name = {
    Text = "「속삭임」\n행동력 0"
  },
  Skill_24650_Desc = {
    Text = "이번 턴에 광기 폭발을 2회 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24650_Name = {
    Text = "「속삭임」\n광기 폭발 2회"
  },
  Skill_24695_Desc = {
    Text = "이번 턴에 카드를 5장 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24695_Name = {
    Text = "「속삭임」\n카드 사용 5장"
  },
  Skill_24696_Desc = {
    Text = "이번 턴에 증상 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24696_Name = {
    Text = "「속삭임」\n증상"
  },
  Skill_24697_Desc = {
    Text = "이번 턴에 열쇠 지령을 발동한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24697_Name = {
    Text = "「속삭임」\n열쇠 지령"
  },
  Skill_24698_Desc = {
    Text = "이번 턴에 열쇠 지령을 발동한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24698_Name = {
    Text = "「속삭임」\n열쇠 지령"
  },
  Skill_24699_Desc = {
    Text = "이번 턴에 행동력 소모가 3 이상인 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24699_Name = {
    Text = "「속삭임」\n행동력 ≥3"
  },
  Skill_24700_Desc = {
    Text = "이번 턴에 행동력 소모가 3 이상인 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24700_Name = {
    Text = "「속삭임」\n행동력 ≥3"
  },
  Skill_24701_Desc = {
    Text = "이번 턴에 행동력 소모가 0인 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24701_Name = {
    Text = "「속삭임」\n행동력 0"
  },
  Skill_24702_Desc = {
    Text = "이번 턴에 행동력 소모가 0인 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24702_Name = {
    Text = "「속삭임」\n행동력 0"
  },
  Skill_24703_Desc = {
    Text = "이번 턴에 광기 폭발을 2회 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24703_Name = {
    Text = "「속삭임」\n광기 폭발 2회"
  },
  Skill_24704_Desc = {
    Text = "이번 턴에 카드를 5장 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24704_Name = {
    Text = "「속삭임」\n카드 사용 5장"
  },
  Skill_24705_Desc = {
    Text = "이번 턴에 광기 폭발을 2회 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24705_Name = {
    Text = "「속삭임」\n광기 폭발 2회"
  },
  Skill_24706_Desc = {
    Text = "이번 턴에 증상 카드를 사용한 후, 행동 의도를 「이별 선물」로 변경한다."
  },
  Skill_24706_Name = {
    Text = "「속삭임」\n증상"
  },
  Skill_24713_Desc = {
    Text = "「회귀·라모나」가 광기 15 획득, 다른 각성체는 광기 3 차감. 이 카드가 턴 종료 시 손패에 있으면 아군에게 [Arg1] 점 <FixedDamage:순수 피해>를 줍니다."
  },
  Skill_24713_Name = {
    Text = "회귀 역설"
  },
  Skill_24714_Desc_1 = {
    Text = "대상 한 명에게 <PowerColourKeywords:힘 감소> [Arg1]을 부여한다."
  },
  Skill_24714_Name_1 = {Text = "힘 감소"},
  Skill_24982_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다. 카렌이 잃은 HP의 [Arg2]%를 회복하고, 동일한 양의 실타래드를 획득한다."
  },
  Skill_24982_Name = {
    Text = "침묵의 수호"
  },
  Skill_24983_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_24983_Name = {
    Text = "메이드의 마법"
  },
  Skill_24984_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 최대 HP를 [Arg3] 감소시킨다."
  },
  Skill_24984_Name = {Text = "식중독"},
  Skill_24986_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <WeaknessIconKeywords:허약>을 부여하며, 「암흑 요리」 1장을 손에 넣는다."
  },
  Skill_24986_Name = {
    Text = "개구리 스튜"
  },
  Skill_24987_Desc = {
    Text = "사용 시 행동력 3pt를 획득하고 자신에게 1턴간 <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>, <FragileIconKeywords:취약>과 <IntoxicationIconKeywords:중독>을 [Arg1]스택 부여한다. 턴 종료 시 손에 있을 경우, 덱 또는 버린 카드 더미의 무작위 명령 카드 2장에 <SlowIconKeywords:둔화>를 부여한다."
  },
  Skill_24987_Name = {
    Text = "카렌의 특제 요리"
  },
  Skill_24988_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「암흑 요리」 2장을 상대의 손에 넣는다. 2턴 동안 「배부르고 목이 시원해졌어요」를 획득한다: 아군이 행동력을 소모할 때마다 카렌이 임시 <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_24988_Name = {
    Text = "맛있게 드세요!"
  },
  Skill_24989_Desc = {
    Text = "사용 후 행동력 2pt와 <IntoxicationIconKeywords:중독> [Arg1]스택을 획득한다. 턴 종료 시 손에 있을 경우, 덱 또는 버린 카드 더미의 무작위 명령 카드 1장에 <SlowIconKeywords:둔화>를 부여한다."
  },
  Skill_24989_Name = {
    Text = "이상한 요리"
  },
  Skill_25058_Desc = {
    Text = "상대의 손에 「카렌의 특제 요리」 2장을 넣는다. 3턴 동안 「배부름」 상태를 획득한다. 「배부름」: 아군이 행동력을 소모할 때마다 카렌이 임시 <PowerIconKeywords:힘>을 [Arg2] 획득한다."
  },
  Skill_25058_Name = {Text = "깨어남"},
  Skill_25127_Desc_1 = {
    Text = "모든 카드를 버리고, 각 깨어남체의 「타격」 2장을 획득한다."
  },
  Skill_25127_Name_1 = {
    Text = "타격 획득"
  },
  Skill_25173_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, [Arg3]턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_25174_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_25174_Name = {
    Text = "검은 혼돈"
  },
  Skill_25175_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_25176_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전체 아군에게 <RetaliateIconKeywords:반격> [Arg3]스택을 부여한다."
  },
  Skill_25176_Name = {
    Text = "잠행의 안개"
  },
  Skill_25182_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_24:「열상」> 4장을 손에 넣는다."
  },
  Skill_25182_Name = {
    Text = "네 날개의 성장"
  },
  Skill_25183_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_24:「열상」> 2장을 손에 넣는다."
  },
  Skill_25183_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_25184_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_24:「열상」> 6장을 손에 넣는다."
  },
  Skill_25184_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_25389_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_25389_Name = {
    Text = "놀라운 공연"
  },
  Skill_25411_Desc = {
    Text = "턴 시작 시 기본값으로 설정된 촉수 기본 자세이며, 촉수 피해는 100%이다. 턴 종료 시까지 「조수」 자세를 유지할 경우, 영구 촉수 1개를 생성한다."
  },
  Skill_25411_Name = {Text = "조수"},
  Skill_25412_Desc = {
    Text = "이번 턴 동안 촉수 피해가 50% 감소하고, 실타래드를 <Block:[Block:Arg1]>pt 획득하며, 이후 촉수가 공격할 때마다 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_25412_Name = {Text = "정해"},
  Skill_25412_tempBattleDesc_1 = {
    Text = "이번 턴 동안 촉수 피해가 50% 감소하고, <Block:[Block:Arg1]>의 실타래드를 획득하며, 이후 촉수가 공격할 때마다 <Block:[Block:Arg2]>의 실타래드를 획득한다."
  },
  Skill_25412_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg3]>의 실타래드를 획득하고, 턴 종료 시 촉수가 공격하지 않는다. 3턴 쿨다운."
  },
  Skill_25412_tempBattleDesc_3 = {
    Text = "<Block:[Block:Arg3]>의 실타래드를 획득하고, 턴 종료 시 촉수가 공격하지 않는다. 3턴 쿨다운."
  },
  Skill_25413_Desc = {
    Text = "이번 턴 동안 촉수 피해가 [Arg1]%가 되며, 능동 피해를 준 후 촉수 1개가 대상 적을 공격하여 [Arg3]%의 촉수 피해를 준다. 턴 종료 시 촉수 1개를 잃는다. 현재 영구 촉수 개수가 1개를 초과할 때만 이 자세를 선택할 수 있다."
  },
  Skill_25413_Name = {Text = "노도"},
  Skill_25413_tempBattleDesc_1 = {
    Text = "이번 턴 동안 촉수 피해가 [Arg1]%가 되며, 능동 피해를 준 후 촉수 1개가 대상 적을 공격하여 [Arg3]%의 촉수 피해를 준다. 턴 종료 시 촉수 1개를 잃는다. 현재 영구 촉수 개수가 1개를 초과할 때만 이 자세를 선택할 수 있다."
  },
  Skill_25413_tempBattleDesc_2 = {
    Text = "이번 턴 동안 촉수 피해가 [Arg2]%가 되며, 능동 피해를 준 후 촉수 1개가 적을 공격한다. 턴 종료 시 촉수 1개를 잃는다. 현재 영구 촉수 개수가 1개를 초과할 때만 이 자세를 선택할 수 있다. 3턴 쿨다운."
  },
  Skill_25413_tempBattleDesc_3 = {
    Text = "이번 턴 동안 촉수 피해가 [Arg2]%가 되며, 능동 피해를 준 후 촉수 1개가 적을 공격한다. 턴 종료 시 촉수 1개를 잃는다. 현재 영구 촉수 개수가 1개를 초과할 때만 이 자세를 선택할 수 있다. 3턴 쿨다운."
  },
  Skill_30362_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대 덱의 가장 위에 「조커」 1장을 넣는다."
  },
  Skill_30362_Name = {
    Text = "서프라이즈!"
  },
  Skill_34668_Desc = {
    Text = "모든 손패를 버리고, 다른 깨어남체 1명을 선택하여 그 깨어남체가 광기 100pt를 획득하게 한다. 그 깨어남체의 전체 덱을 획득하고 「되돌리기」를 부여하며, 행동력을 100pt로 초기화한 후, 「덱 생성」을 손으로 되돌린다."
  },
  Skill_34668_Name = {Text = "덱 생성"},
  Skill_34674_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_34675_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_34676_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <DerivativeCardKeywords_45:「차원 폐쇄」> [Arg2]장을 덱에 섞어 넣는다."
  },
  Skill_34677_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <DerivativeCardKeywords_80:「질식」> [Arg2]장을 덱에 섞어 넣는다."
  },
  Skill_34682_Desc = {
    Text = "전체 적의 HP +9999999"
  },
  Skill_34682_Name = {
    Text = "무적 몬스터"
  },
  Skill_35502_Desc = {
    Text = "핏빛 용광로의 모든 회복량을 소비하여 HP를 [Heal:Arg1] 회복합니다. 최대 [Arg2]까지 핏빛 용광로를 축적할 수 있습니다."
  },
  Skill_35502_Name = {
    Text = "핏빛 용광로"
  },
  Skill_35502_tempBattleDesc_1 = {
    Text = "모든 핏빛 용광로 회복량을 소모하여 [Heal:Arg1] 포인트의 HP를 회복합니다. 최대 [Arg2] 포인트의 핏빛 용광로를 축적할 수 있습니다. 모든 적에게 대상 최대 HP의 1%에 해당하는 침식을 가하며, 소모한 핏빛 용광로가 많을수록 침식 효과가 강해지고 최대 100% 증가합니다. 「빈 껍질」 적에게는 5배의 침식 효과를 가합니다. 3턴 쿨다운."
  },
  Skill_35507_Desc = {
    Text = "「행운의 관객」이 될 깨어남체 1명을 선택하여, 해당 깨어남체의 모든 카드에 「유지」를 부여한다. 「행운의 관객」의 카드를 사용하면 「후디니」의 스킬이 약화되고 힘이 감소하며, 최대 HP가 약간 감소한다."
  },
  Skill_35507_Name = {
    Text = "행운의 관객"
  },
  Skill_35522_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다!"
  },
  Skill_35522_Name = {
    Text = "두개골 강타"
  },
  Skill_35523_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_35524_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, <FragileIconKeywords:손상>을 [Arg2]턴간 부여한다."
  },
  Skill_35526_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_35526_Name = {Text = "강타"},
  Skill_35528_Desc = {
    Text = "<PVPBleedingKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_35528_Name = {Text = "출혈"},
  Skill_35671_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득한다."
  },
  Skill_35671_Name = {Text = "강화"},
  Skill_35742_Desc = {
    Text = "잃은 HP([Arg2])의 [Arg1]%를 회복하고 동일한 양의 방어막을 획득하며, 은열쇠 에너지를 [Arg3] 획득한다."
  },
  Skill_35742_Name = {
    Text = "유토피아의 장막"
  },
  Skill_35743_Desc = {
    Text = "장착하지 않은 열쇠 지령 3개를 확인하고, 그 중 1개를 선택하여 즉시 발동한다."
  },
  Skill_35743_Name = {
    Text = "유토피아의 장막"
  },
  Skill_35960_Desc = {
    Text = "1턴간 <FragileIconKeywords:손상>과 중독 [Arg1]pt를 부여한다."
  },
  Skill_35960_Name = {
    Text = "손상 독소"
  },
  Skill_35961_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_35961_Name = {Text = "순교"},
  Skill_35962_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_35963_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_35963_Name = {Text = "순교"},
  Skill_35964_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_35965_Desc = {
    Text = "1턴간 <WeaknessIconKeywords:허약>을 부여하고, 광기가 가장 높은 깨어남체를 1턴간 봉인한다."
  },
  Skill_35965_Name = {
    Text = "초생의 저주"
  },
  Skill_36003_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_36003_Name = {
    Text = "문어의 키스"
  },
  Skill_36004_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_36005_Desc = {
    Text = "부정 상태 제거, <Block:[Block:Arg1]> 포인트의 방어막을 획득하고 1층의 광기를 얻습니다."
  },
  Skill_36005_Name = {Text = "탈바꿈"},
  Skill_36025_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36026_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36027_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36028_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 행동력 소모가 가장 낮은 카드 4장에 「심해의 낙인」을 부여한다."
  },
  Skill_36028_Name = {
    Text = "사냥감 표식"
  },
  Skill_36029_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36030_Desc = {
    Text = "산호의 가시가 몸에 박혔다!"
  },
  Skill_36030_Name = {
    Text = "산호 기생"
  },
  Skill_36031_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36032_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36033_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36034_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 행동력 소모가 가장 낮은 카드 4장에 「심해의 낙인」을 부여한다."
  },
  Skill_36034_Name = {
    Text = "사냥감 표식"
  },
  Skill_36035_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg3]스택을 획득한다."
  },
  Skill_36036_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_36037_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt과 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시 보유한 스택수만큼 HP를 회복하고, HP 5pt 손실타래 시 1스택 감소한다. 전방에 「잠의 자식」, 후방에 「물의 자식」을 각각 1개씩 소환한다."
  },
  Skill_36037_Name = {Text = "경건"},
  Skill_36038_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_36039_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「기생 산호」 1장을 덱 맨 위에 넣는다."
  },
  Skill_36039_Name = {Text = "산호화"},
  Skill_36040_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt과 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시 보유한 스택수만큼 HP를 회복하고, HP 5pt 손실타래 시 1스택 감소한다."
  },
  Skill_36040_Name = {Text = "경건"},
  Skill_36041_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_36042_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 행동력 소모가 가장 낮은 카드 2장에 「심해의 낙인」을 부여한다."
  },
  Skill_36042_Name = {
    Text = "사냥감 표식"
  },
  Skill_36043_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_36044_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt과 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시 보유한 스택수만큼 HP를 회복하고, HP 5pt 손실타래 시 1스택 감소한다. 전방에 「잠의 자식」 1개를 소환한다."
  },
  Skill_36044_Name = {Text = "경건"},
  Skill_36045_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt과 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시 보유한 스택수만큼 HP를 회복하고, HP 5pt 손실타래 시 1스택 감소한다. 후방에 「물의 자식」 1개를 소환한다."
  },
  Skill_36045_Name = {Text = "경건"},
  Skill_36046_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「기생 산호」 1장을 덱 맨 위와 버린 카드 더미 맨 위에 각각 넣는다."
  },
  Skill_36046_Name = {
    Text = "산호화 가속"
  },
  Skill_36047_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt과 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시 보유한 스택수만큼 HP를 회복하고, HP 5pt 손실타래 시 1스택 감소한다."
  },
  Skill_36047_Name = {Text = "경건"},
  Skill_36048_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_36049_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg3]스택을 획득한다."
  },
  Skill_36076_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 다른 아군에게 자신의 HP만큼 회복시킨 후 자신이 사망한다."
  },
  Skill_36076_Name = {Text = "순교"},
  Skill_36077_Desc = {
    Text = "광란 1스택을 획득하고, 카드 2장에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  Skill_36077_Name = {Text = "광란"},
  Skill_36078_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어의 모든 손패를 버린다."
  },
  Skill_36078_Name = {Text = "해체"},
  Skill_36079_Desc = {
    Text = "광란 1스택을 획득하고, 카드 3장에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  Skill_36079_Name = {Text = "광란"},
  Skill_36080_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「기생 산호」 1장을 덱 맨 위에 넣는다."
  },
  Skill_36080_Name = {Text = "산호화"},
  Skill_36081_Desc = {
    Text = "광란 1스택을 획득하고, 카드 2장에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  Skill_36081_Name = {Text = "광란"},
  Skill_36082_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「영각의 자식」 1개를 소환한다."
  },
  Skill_36082_Name = {Text = "악탄"},
  Skill_36083_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 1턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_36083_Name = {
    Text = "심해의 세례"
  },
  Skill_36084_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어의 모든 손패를 버린다."
  },
  Skill_36084_Name = {Text = "해체"},
  Skill_36085_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 1턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여하며, 다른 아군 1명당 자신이 <ParcloseIconKeywords:장벽> 1스택을 획득한다."
  },
  Skill_36085_Name = {
    Text = "심해의 세례"
  },
  Skill_36086_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 1턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_36086_Name = {
    Text = "심해의 세례"
  },
  Skill_36087_Desc = {
    Text = "<DerivativeCardKeywords_24:「열상」> 3장을 손에 넣는다."
  },
  Skill_36087_Name = {Text = "열상"},
  Skill_36088_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어의 모든 손패를 버린다."
  },
  Skill_36088_Name = {Text = "해체"},
  Skill_36089_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_36090_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「물의 자식」 1개를 소환한다."
  },
  Skill_36090_Name = {Text = "악탄"},
  Skill_36177_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「영각의 자식」, 「잠의 자식」, 「물의 자식」을 소환한다."
  },
  Skill_36177_Name = {
    Text = "죄의 탄생"
  },
  Skill_36179_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_36180_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_36255_Desc = {
    Text = "<BleedingIconKeywords:출혈> [Arg1]스택과 [Arg2]의 실타래드를 부여한다."
  },
  Skill_36255_Name = {
    Text = "과거의 꿈"
  },
  Skill_36256_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 또는 버린 카드 더미의 무작위 명령 카드 3장에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  Skill_36256_Name = {
    Text = "악몽 직조"
  },
  Skill_36257_Desc = {
    Text = "최대 HP가 300%로 증가하고, HP를 모두 회복하며 [Arg3]의 실타래드를 획득한다. 최대 촉수 수가 7 증가한다. 매 턴 종료 시 <PowerIconKeywords:힘>을 [Arg1] 획득한다."
  },
  Skill_36257_Name = {
    Text = "수태의 씨앗"
  },
  Skill_36258_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 50%만큼 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_36258_Name = {
    Text = "영겁의 고통"
  },
  Skill_36259_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위로 깨어남체 [Arg3]명을 봉인한다."
  },
  Skill_36259_Name = {Text = "긴 꿈"},
  Skill_36260_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택을 부여한다."
  },
  Skill_36260_Name = {
    Text = "꿈속의 중얼거림"
  },
  Skill_36261_Desc = {
    Text = "<WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>, <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다."
  },
  Skill_36261_Name = {Text = "통곡"},
  Skill_36326_Desc = {
    Text = "신모의 권능 1스택을 소모하여 <PowerIconKeywords:힘>을 [Arg3] 획득하고, 「성아」의 촉수 피해를 [Arg2] 감소시킨다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_36326_Name = {
    Text = "훈계, 은혜와 원한을 갚아라"
  },
  Skill_36327_Desc = {
    Text = "신모의 권능 1스택을 소모하여 행동력 3pt를 획득하고, 카드를 3장 드로우한다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_36327_Name = {
    Text = "희생, 자유의 불꽃을 밝혀라"
  },
  Skill_36328_Desc = {
    Text = "신모의 권능 1스택을 소모하여 모든 깨어남체가 광기 20을 획득한다. 「성아」의 촉수가 「성아」에게 10배의 피해를 즉시 주고, 촉수 피해 [Arg2]를 [Arg3]회 준다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_36328_Name = {
    Text = "참수, 왕관의 위엄을 보여라"
  },
  Skill_36329_Desc = {
    Text = "신모의 권능 1스택을 회복한다. 신모의 권능은 소모하여 머피의 다른 능력을 발동할 수 있으며, 최대 3스택까지 회복된다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_36329_Name = {
    Text = "짧은 휴식"
  },
  Skill_36330_Desc = {
    Text = "앞줄 적에게 최대 HP의 25%([Arg1])에 해당하는 <FixedDamage:순수 피해>를 입히고, 1턴 동안 실신시킨다."
  },
  Skill_36330_Name = {Text = "왕권"},
  Skill_36331_Desc = {
    Text = "기절 상태, 행동할 수 없음"
  },
  Skill_36331_Name = {Text = "기절"},
  Skill_36356_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_36356_Name = {Text = "순교"},
  Skill_36357_Desc = {
    Text = "플레이어의 <PowerIconKeywords:힘> [Arg1]pt을 영구적으로 빼앗는다."
  },
  Skill_36357_Name = {Text = "흡입"},
  Skill_36358_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_36365_Desc = {
    Text = "전방에 「바다 속의 존재」 1개를 소환한다."
  },
  Skill_36365_Name = {
    Text = "권속이여!"
  },
  Skill_36366_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_23:「상처」> [Arg3]장을 섞어 넣는다."
  },
  Skill_36367_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 봉인한다."
  },
  Skill_36368_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드를 [Arg3]pt 획득하며, 플레이어의 남은 손패 1장당 실타래드가 [Arg4]pt 추가로 증가한다."
  },
  Skill_36368_Name = {
    Text = "탐색 공격"
  },
  Skill_36648_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드를 [Arg3]pt 획득하며, 「잉태」 1스택당 실타래드가 [Arg4]pt 증가한다."
  },
  Skill_36648_Name = {
    Text = "탐색 공격"
  },
  Skill_36649_Desc = {
    Text = "후방에 「영각의 자식」 1개를 소환하며, 「잉태」 스택이 높을수록 더 강해진다!"
  },
  Skill_36649_Name = {
    Text = "선택받은 자"
  },
  Skill_36650_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드를 [Arg3]pt 획득하며, 플레이어의 남은 손패 1장당 실타래드가 [Arg4]pt 추가로 증가한다."
  },
  Skill_36650_Name = {
    Text = "탐색 공격"
  },
  Skill_36651_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_3:「기절」> [Arg3]장을 섞어 넣는다."
  },
  Skill_36651_Name = {
    Text = "지고의 산제"
  },
  Skill_36652_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 봉인한다."
  },
  Skill_36653_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전방에 「잠의 자식」 2개를 소환한다."
  },
  Skill_36653_Name = {
    Text = "레무리아의 영광!"
  },
  Skill_36654_Desc = {
    Text = "후방에 「바다 속의 존재」 1개를 소환한다."
  },
  Skill_36654_Name = {
    Text = "권속이여!"
  },
  Skill_36655_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체를 봉인하며, 전방에 「레무리아의 희망」 2개를 소환한다."
  },
  Skill_36655_Name = {
    Text = "레무리아의 영광!"
  },
  Skill_36656_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 1턴간 봉인한다."
  },
  Skill_36656_Name = {
    Text = "신권의 칼날"
  },
  Skill_36657_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_23:「상처」> [Arg3]장을 섞어 넣는다."
  },
  Skill_36800_Desc = {
    Text = "덱에서 행동력 소모pt가 가장 낮은 카드 [Arg1]장을 드로우한다. 현재 계역이 「심해」일 경우, 추가로 <TentacleInjurieIconKeywords:촉수 피해>가 [Arg2]pt 증가한다."
  },
  Skill_36800_Name = {
    Text = "오레타의 보물"
  },
  Skill_36807_BattleDesc = {
    Text = "1 명의 웨이크업 바디를 선택하여 <Energy:[Arg2]> 포인트의 광기를 획득하게 하며, [Arg3] 포인트의 <PowerIconKeywords:힘>을 획득합니다. 현재 경계역이 「혈육」인 경우, <EmbryoFusionIconKeywords:배아 융합> + [Arg4]를 추가로 얻지만, 10%（[Arg1]）의 현재 생명을 잃습니다."
  },
  Skill_36807_Desc = {
    Text = "1 명의 웨이크업 바디를 선택하여 <Energy:[Arg2]> 점의 광기를 얻게 하고, [Arg3] 점의 <PowerIconKeywords:힘>을 얻습니다. 현재 경계역이 「혈육」인 경우, <EmbryoFusionIconKeywords:배아 융합> + [Arg4]가 추가로 적용되지만, 현재 생명의 10%를 잃습니다."
  },
  Skill_36807_Name = {
    Text = "포효하는 피와 모래"
  },
  Skill_36808_Desc = {
    Text = "행동력 [Arg4]pt를 획득한다. 깨어남체 1명을 선택하여, 그 깨어남체의 「타격」 [Arg1]장과 「방어」 [Arg1]장의 원본 복사본을 손에 넣고, 해당 카드들에게 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 부여한다. 현재 계역이 「초차원」일 경우, 추가로 임시 <PowerIconKeywords:힘> [Arg2]pt와 임시 <AlertIconKeywords:경계> [Arg3]pt를 획득한다."
  },
  Skill_36808_Name = {
    Text = "순간의 영원"
  },
  Skill_36809_Desc = {
    Text = "임시 치명타율 [Arg1]%와 임시 <PowerIconKeywords:힘> [Arg2]pt를 획득한다. 보스전이며 이번 턴에 아직 카드를 사용하지 않았다면, 죽음 저항을 [Arg3]회 시도한다. 성공 시 실타래드를 <Block:[Block:Arg4]>pt 획득하며, 이 효과는 [Arg5]회만 발동한다."
  },
  Skill_36809_Name = {
    Text = "마지막 맹세"
  },
  Skill_36843_Desc = {
    Text = "덱에서 [Arg1]장의 카드를 선택하여 손에 넣고, 그 카드들의 행동력 소모를 [Arg2] 감소시킨다."
  },
  Skill_36843_Name = {
    Text = "회귀의 문을 넘어"
  },
  Skill_36844_Desc = {
    Text = "HP가 가장 높은 적에게 [Arg2] 점 <IntoxicationIconKeywords:중독>을 부여하고, <Block:[Block:Arg1]> 점 방어막을 획득합니다. 이번 턴에 「포식」이 발동된 경우, 방어막을 더 이상 획득하지 않고, 해당 적에게 50% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  Skill_36844_Name = {
    Text = "호숫가의 회상"
  },
  Skill_36845_Desc = {
    Text = "행동력을 [Arg1]pt 획득하고, 다음 턴 시작 시 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 현재 계역이 「심해」이며 「조수」 자세일 경우, 효과가 [Arg3]개의 촉수를 생성하는 것으로 변경된다."
  },
  Skill_36845_Name = {
    Text = "뼈를 침식하는 포옹"
  },
  Skill_36846_Desc = {
    Text = "[Arg1] 점 <RetaliateIconKeywords:반격>을 획득하고, 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [Arg2] 점 감소시킵니다. 현재 「초차원 턴」 상태라면, 임시 <PowerIconKeywords:힘>을 더 이상 감소시키지 않고, 모든 적에게 100% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  Skill_36846_Name = {
    Text = "부패의 향연"
  },
  Skill_36851_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, <PVPDerivativeCardKeywords_4:「영감」> [Arg2]장을 손에 넣는다. 현재 초차원 턴일 경우, 효과가 <PVPDerivativeCardKeywords_4:「영감」> [Arg3]장을 손에 넣는 것으로 변경된다."
  },
  Skill_36851_Name = {
    Text = "안개 드리운 진실타래"
  },
  Skill_36852_Desc = {
    Text = "카드를 1장 드로우한다. 명령 카드 혹은 영지 깨어남을 드로우했다면, 그 카드의 행동력 소모를 0으로 만들고, 그 카드의 소유자가 광기를 <Energy:[Arg1]>pt 획득한다. 그렇지 않을 경우에는 그 카드를 버리고 해당 효과를 반복한다."
  },
  Skill_36852_Name = {
    Text = "한여름의 꿈"
  },
  Skill_36853_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다. 공격 피해를 받을 때, 다음 턴 시작 시 받은 피해의 [Arg2]%만큼 방어막으로 획득한다. 현재 계역이 「혈육」일 경우, 지연 방어막을 획득하는 대신 피해량의 10%를 회복량으로 핏빛 용광로에 적립한다."
  },
  Skill_36853_Name = {
    Text = "기적의 강림"
  },
  Skill_36854_Desc = {
    Text = "행동력 1 포인트와 [Arg1] 포인트 <PowerIconKeywords:힘>을 획득하고, 깨어남체 한 명을 선택하여 [Arg2] 포인트 광기를 획득합니다. 현재 영역이 「심해」이고 「노도」 자세 상태라면, 효과가 [Arg3]% 임시 크리티컬 확률 및 임시 크리티컬 피해 획득으로 변경됩니다."
  },
  Skill_36854_Name = {
    Text = "거인의 패도"
  },
  Skill_36855_Desc = {
    Text = "영역 숙련도가 [Arg1] 증가한다. 깨어남체 1명을 선택하여 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_36855_Name = {
    Text = "그녀의 전부"
  },
  Skill_36856_BattleDesc = {
    Text = "임시 <PowerIconKeywords:힘> [Arg1]을 획득하고, 카드를 2장 드로우한다. 현재 계역이 「혈육」일 경우, 현재 HP의 10%([Arg3])를 잃고 추가로 임시 <PowerIconKeywords:힘> [Arg2]을 획득하며, 손에 있는 「배아」 1장당 추가로 임시 <PowerIconKeywords:힘> [Arg2]을 획득한다."
  },
  Skill_36856_Desc = {
    Text = "임시 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 카드를 2장 드로우한다. 현재 계역이 「혈육」일 경우, 현재 HP의 10%를 잃고 추가로 임시 <PowerIconKeywords:힘> [Arg2]pt를 획득하며, 손에 있는 「배아」 1장당 추가로 임시 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_36856_Name = {
    Text = "장미의 승리"
  },
  Skill_39273_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_3950_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_3951_AwakerSkillBackgroundStory = {
    Text = "거울같은 호수 위로 백조가 맴돈다."
  },
  Skill_3951_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_3951_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>의 방어막을 획득합니다. <Energy:[Energy:Arg2]> 광기를 획득하고, 모든 적의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킵니다."
  },
  Skill_3951_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 리즈가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_3951_Desc_2 = {
    Text = "<Block:[Block:Arg1]>의 방어막을 획득합니다. 리즈가 <Energy:[Energy:Arg2]> 광기를 획득하고, 모든 적의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킵니다."
  },
  Skill_3951_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_3951_Name = {Text = "방어"},
  Skill_3951_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_3952_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다. 매 턴마다 상대 손에 남은 카드에게 「<SlowIconKeywords:둔화>」를 부여한다."
  },
  Skill_3952_Name = {Text = "깨어남"},
  Skill_3953_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3954_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 입히고, <PowerIconKeywords:힘>을 [Arg2]pt 획득한다."
  },
  Skill_3954_Name = {
    Text = "난폭한 물결"
  },
  Skill_3955_Desc = {
    Text = "전열 아군에게 <ParcloseIconKeywords:장벽> [Arg1]스택을 부여한다."
  },
  Skill_3955_Name = {Text = "장벽"},
  Skill_3956_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3957_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3958_Desc = {
    Text = "매 턴 시작 시, 이전 턴에 받은 피해의 절반만큼 방어막을 획득한다."
  },
  Skill_3958_Name = {
    Text = "아첨의 포옹"
  },
  Skill_3960_Desc = {
    Text = "턴 종료 시 손에 있으면 자신에게 <WeaknessIconKeywords:허약>을 1턴간 부여한다. 사용 시 모든 적에게 <WeaknessIconKeywords:허약>을 1턴간 부여한다. 판매 불가."
  },
  Skill_3960_Name = {
    Text = "증상: 쇠약"
  },
  Skill_3961_AwakerSkillBackgroundStory = {
    Text = "전문가가 한 번 손을 대면 알 수 있다. \n현명한 사람은 라이커의 배팅을 모방하는 법을 배워야 한다."
  },
  Skill_3961_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_3961_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 행동력이 부족할 경우 검은 인장 3개를 소모하여 2회 발동할 수 있다. (현재 검은 인장: [Arg3])"
  },
  Skill_3961_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 라이커가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_3961_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 라이커가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 행동력이 부족할 경우 검은 인장 3개를 소모하여 2회 발동할 수 있다."
  },
  Skill_3961_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_3961_Name = {Text = "타격"},
  Skill_3961_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_3962_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 이후 「연속 깨물기」의 공격 횟수를 증가시킨다."
  },
  Skill_3962_Name = {
    Text = "연속 깨물기"
  },
  Skill_3963_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다. 후퇴."
  },
  Skill_3963_Name = {Text = "독소"},
  Skill_3964_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 3턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_3965_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_3966_Desc = {
    Text = "[Arg2]턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_3966_Name = {
    Text = "차원 공동"
  },
  Skill_3967_AwakerSkillBackgroundStory = {
    Text = "누가 여자아이에게 말을 해준 적이 있다. \n\n“너의 곰을 안아라, 그가 네 꿈을 지켜줄 거야.” \n\n깨어남 이후 곰인형이 그녀의 든든한 수호자가 된 것은, 아마 그 때문일 것이다."
  },
  Skill_3967_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 이번「영겁의 눈」이 모든 적에게 1턴 동안 <PetrifactionIconKeywords:석화>를 부여합니다. 대상이 석화 저항을 가지고 있다면 최종 피해량이 200% 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]>의 피해를 입히고, [Arg2]턴 동안 <VulnerabilityIconKeywords:취약>을 부여합니다. 광기 폭발을 사용할 때마다 「영겁의 눈」의 기본 피해량이 [Arg3]% 증가합니다."
  },
  Skill_3967_EffectNameList = {Text = "피해"},
  Skill_3967_Name = {
    Text = "영겁의 눈"
  },
  Skill_3967_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 모든 적에게 1턴 동안 <PetrifactionIconKeywords:석화>를 부여합니다. 대상이 석화 저항을 가지고 있다면 이번「영겁의 눈」의 최종 피해량이 200% 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]>의 피해를 입히고, [Arg2]턴 동안 <VulnerabilityIconKeywords:취약>을 부여합니다. 광기 폭발을 사용할 때마다 「영겁의 눈」의 기본 피해량이 50% 증가합니다. 이번 턴 동안 모든 깨어남체가 입히는 최종 피해량이 25% 증가합니다."
  },
  Skill_3967_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_3967_tempBattleDesc_1 = {
    Text = "[<DevouredIconKeywords:포식>: 이번「영겁의 눈」이 모든 적에게 1턴 동안 <PetrifactionIconKeywords:석화>를 부여합니다. 대상이 석화 저항을 가지고 있다면 최종 피해량이 200% 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]>의 피해를 입히고, [Arg2]턴 동안 <VulnerabilityIconKeywords:취약>을 부여합니다. 광기 폭발을 사용할 때마다 「영겁의 눈」의 기본 피해량이 [Arg3]% 증가합니다."
  },
  Skill_3967_tempBattleDesc_2 = {
    Text = "[<DevouredIconKeywords:포식>: 이번 「만고의 눈」가 모든 적에게 1턴의 <PetrifactionIconKeywords:석화>를 부여하며, 대상이 석화 내성을 보유하면 최종 피해가 200% 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]> 포인트의 피해를 입히고 [Arg2] 턴의 <VulnerabilityIconKeywords:피해 증가>를 부여하며, 발동할 때마다 「만고의 눈」 기본 피해가 [Arg3]% 증가합니다. 아이기스가 사용하는 다음 「방어」가 3회 적용됩니다."
  },
  Skill_3967_tempOverLimitUtlSkillDesc_1 = {
    Text = "[<DevouredIconKeywords:포식>: 모든 적에게 1턴의 <PetrifactionIconKeywords:석화>를 부여하며, 대상이 석화 내성을 보유하면 이번 「만고의 눈」 최종 피해가 200% 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]> 포인트의 피해를 입히고 [Arg2] 턴의 <VulnerabilityIconKeywords:피해 증가>를 부여합니다. 발동할 때마다 「만고의 눈」 기본 피해가 [Arg3]% 증가합니다. 이번 턴 모든 깨어남체가 가하는 최종 피해가 25% 증가합니다."
  },
  Skill_3967_tempOverLimitUtlSkillDesc_2 = {
    Text = "[<DevouredIconKeywords:포식>: 모든 적에게 1턴의 <PetrifactionIconKeywords:석화>를 부여하며, 대상이 석화 내성을 보유하면 이번 「만고의 눈」 최종 피해가 200% 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]> 포인트의 피해를 입히고 [Arg2] 턴의 <VulnerabilityIconKeywords:피해 증가>를 부여합니다. 발동할 때마다 「만고의 눈」 기본 피해가 [Arg3]% 증가합니다. 이번 턴 모든 깨어남체가 가하는 최종 피해가 25% 증가합니다. 아이기스가 사용하는 다음 「방어」가 3회 적용됩니다."
  },
  Skill_3968_Desc = {
    Text = "턴 종료 시 손에 있을 경우, <IntoxicationIconKeywords:중독> [Arg1]스택을 획득한다."
  },
  Skill_3968_Name = {Text = "질식"},
  Skill_3969_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 자신의 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 해제한다."
  },
  Skill_3969_Name = {
    Text = "절망 속의 생존"
  },
  Skill_3970_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_3971_AwakerSkillBackgroundStory = {
    Text = "그녀가 손에 든 칼날은 오직 세상의 공익을 위해 들어올릴 것이다."
  },
  Skill_3971_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_3971_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 엘바가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_3971_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_3971_Name = {Text = "타격"},
  Skill_3971_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_3972_AwakerSkillBackgroundStory = {
    Text = "그녀는 차원 속에서 기묘하고 변화무쌍한 추적자들을 두려워하지 않는다. 그녀는 자신의 비밀스러운 방법이 있다."
  },
  Skill_3972_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_3972_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. <TransitionIconKeywords:워프>: 행동력 1pt를 획득한다."
  },
  Skill_3972_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 다프다엘이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_3972_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 다프다엘이 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. <TransitionIconKeywords:워프>: 행동력 1pt를 획득한다."
  },
  Skill_3972_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_3972_EffectNameList_1 = {
    Text = "실타래드, 광기, 힘"
  },
  Skill_3972_Name = {Text = "방어"},
  Skill_3972_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_3972_PropertyNameList_1 = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_3973_AwakerSkillBackgroundStory = {
    Text = "고요함에 삼켜지기 직전, 그녀는 마치 익사한 시녀를 보는 듯했다.\n 시녀의 피부는 하얗게 변해, 썩어가는 수련이 호수에 누워 있는 것처럼 보였다. 목의 상처는 푸르스름한 맥락을 따라 보이지 않는 먼 곳까지 뻗어 있었다.\n “너의 묘안석 목걸이를 봐,” 시체가 말했다, “모두 재가 되었어. 재가 되었어......”"
  },
  Skill_3973_Desc = {
    Text = "HP를 <Heal:[Heal:Arg1]>pt 회복하고, 방어막을 <Block:[Block:Arg2]>pt 획득한다. 턴 종료 시 해당 카드가 손에 있을 경우, 해당 카드의 행동력 소모가 1 증가하고 HP 회복량과 방어막 획득량이 2배로 증가한다. 이는 최대 [Arg3]회까지 중첩된다."
  },
  Skill_3973_EffectNameList = {
    Text = "회복, 실타래드"
  },
  Skill_3973_Name = {
    Text = "침묵의 수호"
  },
  Skill_3973_PropertyNameList = {
    Text = "체질*GrowValue1, 방어력*GrowValue2"
  },
  Skill_3974_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3974_Name = {
    Text = "목을 베는 참격"
  },
  Skill_3975_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_3977_AwakerSkillBackgroundStory = {
    Text = "“가까이 와, 부끄러워하지 마, 모자 쓴 아저씨에게 너의 웃음과 기쁨을 보여줘.”\n카시아 대사가 모자의 챙을 살짝 치며, 펑 하고 리본과 카드를 한가득 만들어냈다.\n“마음속으로 네 카드를 선택해. 쉿! 아무에게도 말하지 마. 카시아의 다음 말이 어떤 카드가 너의 유일한 카드인지 알려줄 거야.”"
  },
  Skill_3977_Desc_0 = {
    Text = "「타격」으로 간주한다. <DimensionalSpaceIconKeywords:초차원 공간>에 있는 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 2 감소시킨다. <Damage:[Damage:Arg1]>pt의 피해를 무작위로 [Arg2]회 입히고, <PowerIconKeywords:임시 힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_3977_Desc_3 = {
    Text = "「타격」으로 간주한다. <DimensionalSpaceIconKeywords:초차원 공간>에 있는 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 2 감소시킨다. <Damage:[Damage:Arg1]>pt의 피해를 무작위로 [Arg2]회 입히고, <PowerIconKeywords:임시 힘>을 [Power:Arg3]pt 획득한다. <RippleKeywords:여파>: <DerivativeCardKeywords_4:「영감」> 1장을 덱에 넣는다."
  },
  Skill_3977_EffectNameList = {
    Text = "피해, 임시 힘"
  },
  Skill_3977_Name = {
    Text = "허공 집기"
  },
  Skill_3977_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_3978_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, [Arg2]스택의 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_3978_Name = {Text = "경계"},
  Skill_3979_AwakerSkillBackgroundStory = {
    Text = "조현병. 이 단어가 발명되기 전부터 허버트는 실타래험실타래에서 수많은 병례를 만들어냈습니다.\n24는 분명 그 중 최고의 작품으로, 그녀의 인격은 놀라운 속도로 끊임없이 증식하며 서로 간섭하지 않습니다.\n어떤 의미에서 그녀의 뇌는 시끄러운 세입자로 가득 찬 혼잡한 아파트와 같습니다."
  },
  Skill_3979_Desc_0 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다."
  },
  Skill_3979_EffectNameList = {Text = "피해"},
  Skill_3979_Name = {Text = "난도질"},
  Skill_3979_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_3980_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_3981_AwakerSkillBackgroundStory = {
    Text = "다른 종족으로부터 전해지고, 이단으로 여겨지는 혈통입니다.\n 오직 그 고귀함을 믿고, 그 위대함을 믿어야만 잔혹한 세상에서 살아남을 수 있습니다.\n 그 오른 삼촌이 남긴 두루마리와 그 안에 그려진 화려한 심해 고대 도시는 그가 가진 유일한 정신적 의지입니다.\n “혈통 폭발의 순간, 반드시 심해의 무궁한 힘을 받게 될 것입니다.”"
  },
  Skill_3981_Desc = {
    Text = "HP를 <Heal:[Heal:Arg3]>pt 회복하고 자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. 전체 적에게 <VulnerabilityIconKeywords:취약>을 [Arg4]스택 부여한다. <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1]pt 증가하고, <RetaliateIconKeywords:반격>을 [Counterattack:Arg2]스택 획득한다. 다음 턴 시작 전까지, 공격을 1회 받을 때마다 촉수 1개가 공격자에게 반격한다."
  },
  Skill_3981_EffectNameList = {
    Text = "회복, 촉수 피해, 반격"
  },
  Skill_3981_Name = {
    Text = "이단의 혈통"
  },
  Skill_3981_OverLimitUtlSkillDesc = {
    Text = "HP를 <Heal:[Heal:Arg3]>pt 회복하고 자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. 전체 적에게 <VulnerabilityIconKeywords:취약>을 [Arg4]스택 부여한다. <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1]pt 증가하고, <RetaliateIconKeywords:반격>을 [Counterattack:Arg2]스택 획득한다. 다음 턴 시작 전까지, 공격을 1회 받을 때마다 촉수 1개가 공격자에게 반격한다. 촉수 1개가 5회 공격하고, 입힌 피해량의 25%만큼 반격을 획득한다."
  },
  Skill_3981_PropertyNameList = {
    Text = "체질*GrowValue2, 공격력*GrowValue1, 공격력*GrowValue3"
  },
  Skill_3982_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_24:「열상」> 4장을 손에 넣는다."
  },
  Skill_3982_Name = {
    Text = "네 날개의 성장"
  },
  Skill_3983_AwakerSkillBackgroundStory = {
    Text = "실타래험 후, 24는 모든 거울을 부숴버렸다.\n“내 사랑스러운 소녀” 외눈박이 과학자가 그녀의 긴 머리를 쓰다듬으며, “조용히 해.”\n24는 과학자의 눈에서 낯선 몬스터를 보았다. 그녀는 분명 정신이 혼미해져서 그의 두 눈을 찌르려 했던 것이다.\n이것이 그녀가 밀랍 인형관에 버려진 이유일 것이다."
  },
  Skill_3983_Desc = {
    Text = "'24'가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>:"
  },
  Skill_3983_EffectNameList = {
    Text = "광기,광기 폭발 최종 피해 증가,촉수 피해 추가%,힘,카오스 크리티컬 확률 및 크리티컬 데미지,반격 데미지 보너스 %"
  },
  Skill_3983_Name = {
    Text = "인격 조정"
  },
  Skill_3983_PropertyNameList = {
    Text = "$GrowValue1,GrowValue2,$GrowValue3,공격력*GrowValue4,$GrowValue5,$GrowValue6"
  },
  Skill_3984_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_24:「열상」> 6장을 손에 넣는다."
  },
  Skill_3984_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_3986_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_3987_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드를 [Arg3]pt 획득한다. 턴 종료 전까지 플레이어의 남은 손패 1장당 실타래드가 [Arg4]pt 추가로 증가한다."
  },
  Skill_3987_Name = {Text = "시도"},
  Skill_3988_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3989_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3989_Name = {Text = "찌르기"},
  Skill_3991_Desc = {
    Text = "상대의 덱에 <DerivativeCardKeywords_9:「비틀거림」> [Arg1]장을 넣는다."
  },
  Skill_3991_Name = {
    Text = "흐트러짐"
  },
  Skill_3992_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득하고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다. 전진."
  },
  Skill_3993_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_3994_AwakerSkillBackgroundStory = {
    Text = "씨앗은 발아하기를 원하지 않는 법이 없습니다. 식물은 햇빛과 이슬을 맞으며 땅을 뚫고 나오고, 어린이는 사랑과 희망으로 자라납니다. 파인트는 요람에 웅크리고 소중한 영양분을 안고 조용히 그 순간이 오기를 기다립니다……"
  },
  Skill_3994_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, HP를 <Heal:[Heal:Arg2]>pt 회복한다. 이번 전투에서 <DeathResistanceIconKeywords:죽음 저항>이 발동된 경우, 효과가 1회 추가로 발동한다."
  },
  Skill_3994_EffectNameList = {
    Text = "실타래드, 회복"
  },
  Skill_3994_Name = {
    Text = "돋아나는 새싹"
  },
  Skill_3994_PropertyNameList = {
    Text = "방어력*GrowValue1, 체질*GrowValue2"
  },
  Skill_3995_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 1턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_3996_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_33:「살려줘」> 1장을 손에 넣는다."
  },
  Skill_3996_Name = {Text = "살려줘"},
  Skill_3997_AwakerSkillBackgroundStory = {
    Text = "“거리 싸움에는 별다른 규칙이 없어요. 그냥 손에 익은 걸 쓰면 돼요.”"
  },
  Skill_3997_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다."
  },
  Skill_3997_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_3997_Name = {Text = "타격"},
  Skill_3997_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_3999_Desc = {
    Text = "사용 불가. 광기 폭발 발동 후, 모든 깨어남체를 1턴간 봉인한다."
  },
  Skill_3999_Name = {
    Text = "차원 폐쇄"
  },
  Skill_4000_Desc = {
    Text = "정지 상태, 행동할 수 없다."
  },
  Skill_4000_Name = {Text = "정체"},
  Skill_4001_AwakerSkillBackgroundStory = {
    Text = "거미줄이 그녀를 한 겹 한 겹 꽉 둘러쌌다. 그녀는 따뜻하고 안전한 고치 안에서 바깥쪽으로 장난스럽게 얼굴을 찡그렸다."
  },
  Skill_4001_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 아그리파가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4001_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 아그리파가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 모든 적의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다."
  },
  Skill_4001_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4001_Name = {Text = "방어"},
  Skill_4001_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4002_BattleDesc = {
    Text = "[Arg1]의 실타래드를 획득한다. 뽑았을 때 모든 깨어남체가 광기 3을 잃는다."
  },
  Skill_4002_Desc = {
    Text = "최대 HP의 10%만큼 실타래드를 획득한다. 뽑았을 때 모든 깨어남체가 광기 3을 잃는다."
  },
  Skill_4002_Name = {
    Text = "증상: 낙담"
  },
  Skill_4003_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4004_Desc = {
    Text = "[Arg2]턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_4004_Name = {
    Text = "차원 안개"
  },
  Skill_4005_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4005_Name = {Text = "방어막"},
  Skill_4006_Desc = {
    Text = "상태 카드."
  },
  Skill_4006_Name = {
    Text = "흐트러짐"
  },
  Skill_4007_Desc = {
    Text = "<Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히고, <Block:[Block:Arg1]>의 실타래드를 획득하며, 턴 종료 시 남은 실타래드는 2배의 HP로 전환된다."
  },
  Skill_4008_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 입히고, 광란 1스택을 획득한다."
  },
  Skill_4009_AwakerSkillBackgroundStory = {
    Text = "그녀는 손상하지만 매혹적인 아기새이다. 하늘과 대지, 거센 인파를 향해, 그녀는 모든 경계를 내려놓았다."
  },
  Skill_4009_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4009_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 레아가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4009_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4009_Name = {Text = "방어"},
  Skill_4009_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4010_AwakerSkillBackgroundStory = {
    Text = "히로는 이 이상한 힘을 언제 얻었는지 기억나지 않는다.\n어떤 보이지 않는 별이 없는 밤, 히로는 감옥의 진흙바닥에서 깨어나, 갑자기 옆에서 꿈틀거리는 검은 진흙을 발견했다. 그 검은 진흙은 마치 신생의 두 팔처럼 그녀의 단단한 사슬을 끊어주었다.\n그녀는 옆 방에 갇혀 있었던, 그녀가 그를 위해 탄원하여 감옥에 갇힌 늙은 농노를 떠올렸다. 그녀는 급히 가서 확인하려 했지만, 거기에는 거의 말라버린 피자국만 남아 있었다.\n그것은 그녀의 아버지였다.\n밤낮으로 쉬지 않고 일한 것이 그의 생명을 빼앗지 않았고, 무정하고 잔인한 채찍질도 그의 생명을 빼앗지 않았다—그의 생명을 빼앗은 것은 자신의 간청이었고, 중상모략자의 비방이었으며, 권력자의 불분명한 판단이었다…\n눈구멍은 이미 말라버렸고, 흐르는 것들은—그냥 증오로 가득 찬 검은 액체일 뿐이었다."
  },
  Skill_4010_BattleDesc = {
    Text = "현재 HP의 [Arg1]%([Arg3])를 잃고, 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해와 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다. 무작위 깨어남체의 「타격」 2장을 손에 넣고 <DepleteIconKeywords:소모>를 부여한다. 「타격」으로 간주한다."
  },
  Skill_4010_Desc = {
    Text = "현재 HP의 [Arg1]%를 잃고, 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해와 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다. 무작위 깨어남체의 「타격」 2장을 손에 넣고 <DepleteIconKeywords:소모>를 부여한다. 「타격」으로 간주한다."
  },
  Skill_4010_EffectNameList = {
    Text = "피해, 타격 레벨"
  },
  Skill_4010_Name = {
    Text = "끝없는 원한"
  },
  Skill_4010_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4011_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4011_Name = {Text = "방어막"},
  Skill_4012_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4013_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4014_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4014_Name = {
    Text = "장례의 종소리"
  },
  Skill_4015_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4016_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_23:「상처」> [Arg3]장을 넣는다."
  },
  Skill_4016_Name = {
    Text = "상처 입히기"
  },
  Skill_4017_AwakerSkillBackgroundStory = {
    Text = "긴 고독 속에서, 그녀는 왜 검을 휘둘렀는지 이미 잊은 지 오래되었다.\n\n그러나 자신이 이 검을 휘둘러야 한다는 것만은 분명히 알고 있었다."
  },
  Skill_4017_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주며, 「명정지검」에서 <PowerIconKeywords:힘>이 [Arg2]배 효과를 발휘한다. 열쇠 지령을 사용할 때마다, 이번 전투에서 힘 배율이 1배 증가한다. <TimeBeacon:회귀>: <C01EXCardKeyWord1:윤회의 정원> 또는 <C01EXCardKeyWord2:미래 찬가> 중 하나를 선택한다."
  },
  Skill_4017_EffectNameList_0 = {Text = "피해"},
  Skill_4017_Name = {
    Text = "운명의 검"
  },
  Skill_4017_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4018_AwakerSkillBackgroundStory = {
    Text = "통증, 통증. \n어두운 차가움의 통증은 그녀가 거의 기억하는 몇 안 되는 것들 중 하나였다. \n만약 그녀가 진정한 나우티루스처럼 아름답고 단단한 외피를 가지고 있었다면, 그렇게 아프지 않았을까?"
  },
  Skill_4018_Desc_0 = {
    Text = "노틸라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 노틸라가 부여하는 실타래드와 <RetaliateIconKeywords:반격>이 [Arg2]% 증가한다."
  },
  Skill_4018_Desc_15 = {
    Text = "노틸라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 노틸라가 부여하는 실타래드와 <RetaliateIconKeywords:반격>이 [Arg2]% 증가하고, 모든 깨어남체가 주는 잠금 <RetaliateIconKeywords:반격>이 [Arg3]% 증가한다."
  },
  Skill_4018_EffectNameList = {Text = "광기"},
  Skill_4018_Name = {
    Text = "수리 전문가"
  },
  Skill_4019_AwakerSkillBackgroundStory = {
    Text = "\"하나가 만물을 낳고, 만물이 하나로 돌아간다\"는 이론처럼, 그녀는 역설의 함정에 빠진 적이 있었다."
  },
  Skill_4019_Desc_0 = {
    Text = "<Posse:[Arg1]>pt의 열쇠 에너지를 획득한다. 이전 턴에 마지막으로 사용한 3장의 서로 다른 비파생 명령 카드의 원본 복사본을 손에 넣고, 그 카드들의 비용을 1 감소시키며 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 부여한다. 손에 넣을 수 있는 명령 카드가 부족할 경우, 부족한 장수만큼 카드를 드로우한다."
  },
  Skill_4019_Desc_3 = {
    Text = "<Posse:[Arg1]>pt의 열쇠 에너지를 획득한다. 이전 턴에 마지막으로 사용한 3장의 서로 다른 비파생 명령 카드의 원본 복사본을 손에 넣고, 그 카드들의 비용을 1 감소시키며 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 부여한다. 손에 넣을 수 있는 명령 카드가 부족할 경우, 부족한 장수만큼 카드를 드로우한다. 잠금 해제된 열쇠 지령 중 1개를 선택하여, 사용하거나 전투 종료 시까지 현재 열쇠 지령을 대체한다."
  },
  Skill_4019_EffectNameList = {
    Text = "은열쇠 충전"
  },
  Skill_4019_Name = {
    Text = "패러독스 수렴"
  },
  Skill_4019_OverLimitUtlSkillDesc_0 = {
    Text = "<Posse:[Arg1]> 점의 은열쇠 에너지를 획득합니다. 지난 턴에 마지막으로 사용한 서로 다른 비파생 커맨드 카드 3장을 원시 복제하여 손패에 넣고, 해당 카드들의 행동력 소모를 0으로 만들며 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:공허>를 부여합니다. 손패에 넣을 수 있는 커맨드 카드가 부족할 경우, 동일한 수량의 카드를 뽑아 대체합니다. 상한을 무시하는 <TimeBeacon2:네겐트로피> 3층을 획득합니다."
  },
  Skill_4019_OverLimitUtlSkillDesc_3 = {
    Text = "<Posse:[Arg1]>의 열쇠 에너지를 획득한다. 이전 턴에 마지막으로 사용한 3장의 서로 다른 비파생 명령 카드의 원본 복사본을 손에 넣고, 그 카드들의 비용을 0으로 만들며 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 부여한다. 손에 넣을 수 있는 명령 카드가 부족할 경우, 부족한 장수만큼 카드를 드로우한다. 잠금 해제된 열쇠 지령 중 1개를 선택하여, 사용하거나 전투 종료 시까지 현재 열쇠 지령을 대체한다. 상한을 무시하는 <TimeBeacon2:음엔트로피> 3스택을 획득한다."
  },
  Skill_4020_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4020_Name = {
    Text = "융식의 포옹"
  },
  Skill_4021_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 이후 「연속 깨물기」의 공격 횟수를 증가시킨다."
  },
  Skill_4021_Name = {
    Text = "연속 깨물기"
  },
  Skill_4022_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 이후 「연속 깨물기」의 공격 횟수를 증가시킨다."
  },
  Skill_4022_Name = {
    Text = "연속 깨물기"
  },
  Skill_4023_AwakerSkillBackgroundStory = {
    Text = "리즈는 자신이 녹색 불꽃을 획득한 그날의 광경을 기억하고 있다. \n청색의 화종이 손바닥에서 솟아올라 떨어지며, 오랫동안 억눌려 있던 소원을 이루도록 부추겼다."
  },
  Skill_4023_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 피해량의 [Arg2]%만큼 <IntoxicationIconKeywords:중독>을 부여한다. 턴 종료 시 이 카드가 손이나 <DimensionalSpaceIconKeywords:초차원공간>에 있을 경우, 「<DerivativeCardKeywords_19:부패 녹염>」으로 승급된다. 행동력이 부족할 때 강제로 사용할 수 있으며, 이 경우 효과가 <Energy:[Energy:Arg3]>의 광기를 획득하는 것으로 변경되고, <DepleteIconKeywords:소모>된다."
  },
  Skill_4023_EffectNameList = {Text = "피해"},
  Skill_4023_Name = {
    Text = "녹색 불꽃"
  },
  Skill_4023_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4024_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4025_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 「쥐 떼의 분노」를 획득한다. 「쥐 떼의 분노」: 다음 턴에 공격을 1회 받을 때마다 [Arg3]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4025_Name = {
    Text = "쥐 떼 집합"
  },
  Skill_4026_Desc = {
    Text = "<PowerIconKeywords:힘>이 2배로 증가한다."
  },
  Skill_4026_Name = {
    Text = "절망 속의 생존"
  },
  Skill_4027_AwakerSkillBackgroundStory = {
    Text = "파인트는 얇은 껍질을 떠날 수가 없어서, 틴커트는 자주 그녀의 곁에서 진혼곡을 불러주었다.\n“내가 당신의 생명력을 흡수할 거예요.”파인트가 이렇게 말했다.\n“괜찮아요, 우리의 생명은 하나니까요.”틴커트가 대답했다."
  },
  Skill_4027_BattleDesc_0 = {
    Text = "자신의 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약> 상태를 해제합니다. 모든 적의 <ExhaustionIconKeywords:힘>을 일시적으로 [Exhaustion:Arg1] 감소시키고, 적 1명당 <PowerIconKeywords:임시 힘>을 [Power:Arg1] 획득합니다. 이번 턴에 다음으로 사용하는 도약 효과가 반드시 발동합니다. <TransitionIconKeywords:도약>: 모든 적의 <ExhaustionIconKeywords:힘>을 일시적으로 [Exhaustion:Arg2] 감소시키고, 적 1명당 <PowerIconKeywords:임시 힘>을 [Power:Arg2] 획득하는 효과로 변경됩니다."
  },
  Skill_4027_Desc_0 = {
    Text = "자신의 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약> 상태를 해제합니다. 모든 적의 <PowerIconKeywords:힘>을 [Arg1] <TouquKeywords:탈취>합니다. 이번 턴에 다음으로 사용하는 도약 효과가 반드시 발동합니다. <TransitionIconKeywords:도약>: <PowerIconKeywords:힘>을 [Arg2] <TouquKeywords:탈취>하는 효과로 변경됩니다."
  },
  Skill_4027_EffectNameList = {
    Text = "힘 탈취,도약 힘 탈취"
  },
  Skill_4027_Name = {Text = "진혼곡"},
  Skill_4027_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4028_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_4028_Name = {
    Text = "자폭 공격"
  },
  Skill_4029_Desc = {
    Text = "[Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, [Arg2] 점의<PowerIconKeywords:힘>을 줄입니다."
  },
  Skill_4029_Name = {
    Text = "침식의 시선"
  },
  Skill_4030_Desc = {
    Text = "매 턴마다 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_4030_Name = {
    Text = "고대의 부름"
  },
  Skill_4031_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, <AlertIconKeywords:경계> [Arg2]pt를 잃는다."
  },
  Skill_4031_Name = {
    Text = "족쇄: 섭정 부인"
  },
  Skill_4032_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4032_Name = {Text = "강타"},
  Skill_4033_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 뒤틀린 시체 광연의 피해를 <Damage:[Damage:Arg3]>만큼 증가시킨다."
  },
  Skill_4033_Name = {Text = "난도질"},
  Skill_4034_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_4035_AwakerSkillBackgroundStory = {
    Text = "혼란스러운 영혼은 오직 자신에게만 집중하며, 그들은 필연적으로 방어에 소홀해지기 마련이다."
  },
  Skill_4035_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4035_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, '24'가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4035_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4035_Name = {Text = "방어"},
  Skill_4035_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4036_AwakerSkillBackgroundStory = {
    Text = "정밀한 작업을 할 때면 돌의 이 집게손은 사용하기 정말 불편하다. \n하지만 이계 기술을 인류가 완전히 사용할 수 있도록 개조하기 전까지, 그녀는 적어도 10년은 이 두 손을 참아야 해요."
  },
  Skill_4036_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4036_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 돌이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4036_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4036_Name = {Text = "타격"},
  Skill_4036_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4037_Desc = {
    Text = "손에 있는 모든 카드의 <SlowIconKeywords:둔화> 효과를 해제한다."
  },
  Skill_4037_Name = {
    Text = "난 인형이 아니야"
  },
  Skill_4038_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 회 입히고, [Arg3] 포인트의 <PowerIconKeywords:힘>을 일시적으로 감소시킵니다."
  },
  Skill_4041_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4042_Desc = {
    Text = "기생 중 방해를 받아 일시적으로 혼란에 빠졌다…"
  },
  Skill_4042_Name = {Text = "혼란"},
  Skill_4043_BattleDesc = {
    Text = "전체 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Arg2]pt 감소시키며, 적 1명당 임시 <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4043_Desc = {
    Text = "모든 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여하고, 모든 적에게서 <PowerIconKeywords:힘>을 [Arg1]pt 탈취한다."
  },
  Skill_4043_Name = {
    Text = "머릿속의 소리"
  },
  Skill_4044_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4045_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득하며, 방어되지 않은 피해만큼 HP를 회복한다."
  },
  Skill_4045_Name = {
    Text = "환희와 피"
  },
  Skill_4046_AwakerSkillBackgroundStory = {
    Text = "명령: 공격. 물어라."
  },
  Skill_4046_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4046_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 릴리가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4046_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4046_Name = {Text = "타격"},
  Skill_4046_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4047_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4048_Desc = {
    Text = "깨어남체 1명을 선택해 광기를 <Energy:[Arg1]>pt 획득한다."
  },
  Skill_4048_Name = {
    Text = "작은 소원"
  },
  Skill_4049_Desc = {
    Text = "[Arg1]pt의 HP를 회복하고, 턴 종료 시 모든 실타래드를 잃는다."
  },
  Skill_4049_Name = {
    Text = "족쇄: 처형당하는 노예"
  },
  Skill_4050_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_3:「기절」> 2장을 덱에 섞어 넣는다."
  },
  Skill_4050_Name = {Text = "명멸"},
  Skill_4051_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, HP가 낮을수록 더 큰 피해를 준다."
  },
  Skill_4051_Name = {
    Text = "보복의 일격"
  },
  Skill_4052_Desc = {
    Text = "혈육 계역 깨어남체가 광기 폭발을 발동할 때 이 카드를 소모하여 <DevouredIconKeywords:포식> 효과를 1회 발동할 수 있다. 직접 사용 시 깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]> 광기를 부여하고, 이번 턴 치명타율이 [Arg2]% 증가한다."
  },
  Skill_4052_Name = {Text = "배아"},
  Skill_4052_tempBattleDesc_1 = {
    Text = "혈육 계역 깨어남체가 광기 폭발을 발동할 때 이 카드를 소모하여 <DevouredIconKeywords:포식> 효과를 1회 발동할 수 있다. 직접 사용 시 깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]> 광기를 부여하고, 이번 턴 치명타율이 [Arg2]% 증가한다."
  },
  Skill_4052_tempBattleDesc_2 = {
    Text = "혈육 영역 깨어남체가 광기 폭발을 발동할 때 이를 소모하여 1회 <DevouredIconKeywords:포식> 효과를 발동한다. 사용 후 깨어남체 하나를 선택하여 <Energy:[Energy:Arg1]> 광기를 획득한다. 깨어남체가 매 라운드 처음으로 「배아」 또는 「성결의 자식」을 소모할 때, [Arg3] 중첩의 <BreedingKeywords1:번식 축전>을 획득한다."
  },
  Skill_4052_tempName_1 = {Text = "배아"},
  Skill_4052_tempName_2 = {
    Text = "번식· 배아"
  },
  Skill_4053_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 3턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_4054_Desc = {
    Text = "특수한 찢기 상처입니다. 턴 종료 시 손에 있을 경우, [Arg1] 점 <FixedDamage:순수 피해>를 받습니다. 버릴 때 <DepleteIconKeywords:소모>됩니다."
  },
  Skill_4054_Name = {Text = "열상"},
  Skill_4055_AwakerSkillBackgroundStory = {
    Text = "끝없이 펼쳐진 대양 속에서, 외로운 항해 배가 파도에 흔들리고 있다.\n 그들은 기도하고, 간청하고, 애원하며, 하얀 성녀가 그들을 바다에서 데려가 고향의 땅에 다시 발을 디디게 해주기를 바란다.\n 중앙 돛대 위에서, 흰 치마를 입은 소녀가 고개를 들어 하얀 새를 바라본다.\n “나에게 키를 맡겨라, 내가 너희를 집으로 데려가겠다.”"
  },
  Skill_4055_BattleDesc_0 = {
    Text = "자신의 <HeavyInjuryKeywords:중상> 상태를 해제하고, <Heal:[Heal:Arg1]>의 HP를 회복하며 행동력 1pt를 획득한다. 이번 전투에서 치명적 피해를 받을 경우 부활하여 HP를 [Arg2]%(<Heal:[Arg3]>) 회복한다. 부활 효과는 전투마다 1회만 발동한다."
  },
  Skill_4055_BattleDesc_3 = {
    Text = "자신의 <HeavyInjuryKeywords:중상> 상태를 해제하고, <Heal:[Heal:Arg1]>의 HP를 회복하며 행동력 1pt를 획득한다. 이번 전투에서 치명적 피해를 받을 경우 부활하여 HP를 [Arg2]%(<Heal:[Arg3]>) 회복하고 모든 깨어남체가 <Energy:[Energy:Arg4]>의 광기를 획득한다. 부활 효과는 발동 후 6턴 동안 다시 부여할 수 없다."
  },
  Skill_4055_Desc_0 = {
    Text = "자신의 <HeavyInjuryKeywords:중상> 상태를 해제하고, <Heal:[Heal:Arg1]>의 HP를 회복하며 행동력 1pt를 획득한다. 이번 전투에서 치명적 피해를 받을 경우 부활하여 HP를 [Arg2]% 회복한다. 부활 효과는 전투마다 1회만 발동한다."
  },
  Skill_4055_Desc_3 = {
    Text = "자신의 <HeavyInjuryKeywords:중상> 상태를 해제하고, <Heal:[Heal:Arg1]>의 HP를 회복하며 행동력 1pt를 획득한다. 이번 전투에서 치명적 피해를 받을 경우 부활하여 HP를 [Arg2]% 회복하고 모든 깨어남체가 <Energy:[Energy:Arg4]>의 광기를 획득한다. 부활 효과는 발동 후 6턴 동안 다시 부여할 수 없다."
  },
  Skill_4055_EffectNameList = {
    Text = "회복, 회복%"
  },
  Skill_4055_Name = {
    Text = "불멸의 극락조"
  },
  Skill_4055_OverLimitUtlSkillDesc_0 = {
    Text = "<Heal:[Heal:Arg1]> 점 HP를 회복하고 행동력 1을 획득하며, 자신의 <HeavyInjuryKeywords:치명타> 상태를 해제합니다. 이번 전투에서 치명적인 피해를 받을 때 소생하여 [Arg2]%(<Heal:[Arg3]>) HP를 회복하며, 전투당 1회만 발동됩니다. 회복이 50% 증가한 「순백의 꿈」 3장을 손패에 추가하고 소모를 부여합니다."
  },
  Skill_4055_OverLimitUtlSkillDesc_3 = {
    Text = "자신의 <HeavyInjuryKeywords:중상> 상태를 해제하고, <Heal:[Heal:Arg1]>의 HP를 회복하며 행동력 1pt를 획득한다. 이번 전투에서 치명적 피해를 받을 경우 부활하여 HP를 [Arg2]%(<Heal:[Arg3]>) 회복하고 모든 깨어남체가 <Energy:[Energy:Arg4]>의 광기를 획득한다. 부활 효과는 발동 후 6턴 동안 다시 부여할 수 없다. 회복량이 50% 증가한 「순백의 꿈」 3장을 손에 넣고 <DepleteIconKeywords:소모>를 부여한다."
  },
  Skill_4055_PropertyNameList = {
    Text = "체질*GrowValue1,$GrowValue2"
  },
  Skill_4056_AwakerSkillBackgroundStory = {
    Text = "고마워, 곰돌아. 으앗, 화내지 마, 내가 잘못 말했어. 고마워, 작은 눈."
  },
  Skill_4056_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4056_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 아이기스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4056_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4056_Name = {Text = "방어"},
  Skill_4056_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4057_Desc = {
    Text = "피의 등불 발동: 매 턴 종료 시, <BleedingIconKeywords:출혈>을 [Arg1]스택 부여한다."
  },
  Skill_4057_Name = {
    Text = "피의 등불"
  },
  Skill_4058_Desc = {
    Text = "「분열 환자」를 기절시키고, 카드를 3장 뽑으며 행동력 3pt를 획득한다."
  },
  Skill_4058_Name = {Text = "살려줘"},
  Skill_4059_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4059_Name = {
    Text = "뜨거운 밀랍의 욕망"
  },
  Skill_4060_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈>을 [Arg1]스택 부여한다."
  },
  Skill_4060_Name = {Text = "출혈"},
  Skill_4061_AwakerSkillBackgroundStory = {
    Text = "일생에 반드시 겪는 세 가지 일: 출생, 사망, 그리고 아그리파의 분노."
  },
  Skill_4061_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 아그리파가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4061_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 아그리파가 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 모든 적의 <IntoxicationIconKeywords:중독>을 [Arg3]% 발동시킨다."
  },
  Skill_4061_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4061_Name = {Text = "타격"},
  Skill_4061_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4062_Desc = {
    Text = "<WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 99스택 부여한다. <DerivativeCardKeywords_33:「살려줘」> 1장을 손에 넣는다."
  },
  Skill_4062_Name = {
    Text = "희미한 자아"
  },
  Skill_4063_Desc = {
    Text = "증상 카드 5장을 덱에 넣는다."
  },
  Skill_4063_Name = {
    Text = "병마의 포위"
  },
  Skill_4064_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈>을 [Arg1]스택 부여한다."
  },
  Skill_4064_Name = {Text = "출혈"},
  Skill_4065_AwakerSkillBackgroundStory = {
    Text = "상위 존재의 악의가 걷잡을 수 없이 요동쳤지만, 인류의 의지 또한 속수무책으로 당하고만 있지는 않았다.\n모든 것을 녹여버리는 검은 점액이 그 초월자의 정신을 갉아먹으며 인류의 유일한 구원이 되어주었다.\n잠시나마 우위를 점한 인형술사가 두 팔을 펼치자, 파괴적인 전류는 수호의 방벽으로 탈바꿈했다."
  },
  Skill_4065_BattleDesc_0 = {
    Text = "임시 <AlertIconKeywords:경계> [Arg1]pt를 획득한다. <Posse:[Arg2]>pt의 열쇠 에너지를 획득한다. 자신의 <FragileIconKeywords:손상> 상태를 해제한다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_13:「기계 무장-전개」>으로 변환된다."
  },
  Skill_4065_BattleDesc_1 = {
    Text = "임시 <AlertIconKeywords:경계> [Arg1]pt를 획득한다. <Posse:[Arg2]>pt의 열쇠 에너지를 획득한다. 자신의 <FragileIconKeywords:손상> 상태를 해제한다. <DepleteIconKeywords:소모>가 부여된 에리카의 「방어」 1장을 손에 넣는다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_13:「기계 무장-전개」>으로 변환된다."
  },
  Skill_4065_Desc_0 = {
    Text = "<AlertIconKeywords:임시 경계> [Arg1]pt를 획득한다. 에리카의 은열쇠 충전과 동일한 양의 열쇠 에너지를 획득한다. 자신의 <FragileIconKeywords:손상> 상태를 해제한다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_13:「기계 무장-전개」>으로 변환된다."
  },
  Skill_4065_Desc_1 = {
    Text = "<AlertIconKeywords:임시 경계> [Arg1]pt를 획득한다. 에리카의 은열쇠 충전과 동일한 양의 열쇠 에너지를 획득한다. 자신의 <FragileIconKeywords:손상> 상태를 해제한다. <DepleteIconKeywords:소모>가 부여된 에리카의 「방어」 1장을 손에 넣는다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_13:「기계 무장-전개」>으로 변환된다."
  },
  Skill_4065_EffectNameList = {
    Text = "힘, 경계"
  },
  Skill_4065_Name = {
    Text = "기계 무장-수축"
  },
  Skill_4065_PropertyNameList = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4066_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4067_Desc = {
    Text = "[Arg2]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4067_Name = {
    Text = "복수 선언"
  },
  Skill_4068_AwakerSkillBackgroundStory = {
    Text = "여자아이는 어린 시절부터 엄격한 귀족 교육을 받았다. \n이 복잡한 교훈은 단 하나의 단어로 요약된다: 절제. \n이들은 자세, 식욕, 말하는 음량 등을 포함하지만 이에 국한되지 않는다…\n여자아이는 하루 종일 꽃이 만발한 정원에서 시를 읽고, 노래하며 기도했다.\n그녀는 매우 배가 고팠다."
  },
  Skill_4068_BattleDesc_0 = {
    Text = "현재 HP의 [Arg1]%([Arg4])를 잃습니다. <EmbryoFusionIconKeywords:배아 융합>+[Blood:Arg3]. [Power:Arg2] 의 임시 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_4068_BattleDesc_2 = {
    Text = "현재 HP의 [Arg1]%([Arg4])를 잃습니다. <EmbryoFusionIconKeywords:배아 융합>+[Blood:Arg3]. [Power:Arg2] 의 임시 <PowerIconKeywords:힘>을 획득합니다. <Energy:[Energy:Arg5]> 광기를 획득합니다."
  },
  Skill_4068_Desc_0 = {
    Text = "현재 HP의 [Arg1]%를 잃습니다. <EmbryoFusionIconKeywords:배아 융합>+[Blood:Arg3]. [Power:Arg2] 의 임시 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_4068_Desc_2 = {
    Text = "현재 HP의 [Arg1]%를 잃습니다. <EmbryoFusionIconKeywords:배아 융합>+[Blood:Arg3]. [Power:Arg2] 의 임시 <PowerIconKeywords:힘>을 획득합니다. <Energy:[Energy:Arg5]> 광기를 획득합니다."
  },
  Skill_4068_EffectNameList_0 = {
    Text = "힘, 배아 융합"
  },
  Skill_4068_Name = {
    Text = "채워지지 않은 고통"
  },
  Skill_4068_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4069_AwakerSkillBackgroundStory = {
    Text = "“방어 모드 전환 완료, 제 뒤에 숨으시기 바랍니다.\""
  },
  Skill_4069_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4069_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 에리카가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4069_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4069_Name = {Text = "방어"},
  Skill_4069_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4070_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4071_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_4071_Name = {Text = "출혈"},
  Skill_4072_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 자신은 <Block:[Block:Arg2]>의 실타래드를 획득한다."
  },
  Skill_4072_Name = {
    Text = "전체 강화"
  },
  Skill_4073_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4073_Name = {Text = "환희"},
  Skill_4074_Desc = {
    Text = "모든 깨어남체의 「방어」를 손에 넣는다. 폭주한 히로는 오직 릴리에게만 집중하고 있는 듯하다…"
  },
  Skill_4074_Name = {Text = "은신"},
  Skill_4075_AwakerSkillBackgroundStory = {
    Text = "님피아는 꽃을 매우 좋아합니다. 문학 소설 외에는 이것이 병상에서 그녀와 함께하는 유일한 존재입니다.\n 다만, 부모님이 돌아가신 후로는 정기적으로 위로의 꽃다발이 배달되지 않았습니다.\n 그 마지막 백합 꽃다발도 시간이 지나면서 점차 생기를 잃었습니다.\n 그래서, 자신을 위해 준비한 장례식에서 그녀는 주저 없이 그것을 가져갔습니다.\n 빛과 그림자 속에서 헤엄치는 물고기들이 춤을 추고, 산호는 줄기와 잎을 뻗으며, 밀려오는 파도가 그녀의 시선이 향하는 먼 곳으로 다가갑니다."
  },
  Skill_4075_BattleDesc_0 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다."
  },
  Skill_4075_BattleDesc_3 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 이번 전투에서 「자아의 장례식」이 부여하는 <IntoxicationIconKeywords:중독> 스택이 [Poison:Arg4] 증가한다."
  },
  Skill_4075_Desc_0 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다."
  },
  Skill_4075_Desc_3 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 이번 전투에서 「자아의 장례식」이 부여하는 <IntoxicationIconKeywords:중독> 스택이 [Poison:Arg4] 증가한다."
  },
  Skill_4075_EffectNameList_0 = {
    Text = "중독, 힘"
  },
  Skill_4075_EffectNameList_3 = {
    Text = "중독, 힘, 중독 추가 부여량"
  },
  Skill_4075_Name = {
    Text = "자아의 장례식"
  },
  Skill_4075_OverLimitUtlSkillDesc_0 = {
    Text = "모든 적에게 [Poison:Arg1] 스택의 <IntoxicationIconKeywords:중독>을 부여하고 [Arg3]%의 <IntoxicationIconKeywords:중독>을 발동합니다. [Power:Arg2] 점 <PowerIconKeywords:힘>을 획득합니다. 님피아가 가하는 <IntoxicationIconKeywords:중독>이 50% 증가하며, 3회합 동안 지속됩니다."
  },
  Skill_4075_OverLimitUtlSkillDesc_3 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여하고, <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다. <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 이번 전투에서 「자아의 장례식」이 부여하는 <IntoxicationIconKeywords:중독> 스택이 [Poison:Arg4] 증가한다. 3턴 동안 님피아가 주는 <IntoxicationIconKeywords:중독> 피해가 50% 증가한다."
  },
  Skill_4075_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4075_PropertyNameList_3 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4076_AwakerSkillBackgroundStory = {
    Text = "모피를 입은 비너스여, 그대의 발을 노예의 등에 올려놓으소서!\n그들의 목에 쇠사슬을 걸고, 등가시로 그들의 상처 난 심장을 찌르소서."
  },
  Skill_4076_Desc_0 = {
    Text = "무작위 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 이 피해에는 [Arg4]%의 <RetaliateIconKeywords:반격> 보너스가 적용된다. 각 공격 시 피해 대상의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시킨다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 5스택을 소모하여, 성공 시 소모한 행동력을 반환하고 추가로 2회 피해를 입힌다. 실타래패 시 <DreamGuide:몽인> 2스택을 획득한다."
  },
  Skill_4076_Desc_1 = {
    Text = "무작위 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 이 피해에는 [Arg4]%의 <RetaliateIconKeywords:반격> 보너스가 적용된다. 각 공격 시 피해 대상의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시킨다. 이 카드의 치명타율이 25% 증가한다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 5스택을 소모하여, 성공 시 소모한 행동력을 반환하고 추가로 2회 피해를 입힌다. 실타래패 시 <DreamGuide:몽인> 2스택을 획득한다."
  },
  Skill_4076_EffectNameList = {
    Text = "피해, 힘 감소, 반격 계수"
  },
  Skill_4076_Name = {
    Text = "가시 사슬"
  },
  Skill_4076_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2,$GrowValue3%"
  },
  Skill_4077_AwakerSkillBackgroundStory = {
    Text = "그 촉수는 어느 신의 것인지 이미 알 수 없다. \n그것들은 심연에서 왔고, 그것들은 깊은 바다에 머물며, 그것들은 마음대로 뻗어나간다. 그것들은 나선 지배자의 명령을 따를 것이다."
  },
  Skill_4077_BattleDesc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 입힙니다. 추가로 [Arg3]%의 촉수 피해와 힘 계수가 적용됩니다. 모든 촉수가 [Arg2]번 공격하여 [Arg4]%의 <PunctureDamagewords:관통 피해>를 입힙니다. <RippleKeywords:여파>: 촉수 1개가 적을 공격합니다."
  },
  Skill_4077_BattleDesc_1 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 입힙니다. 추가로 [Arg3]%의 촉수 피해와 힘 계수가 적용됩니다. 모든 촉수가 모든 적에게 [Arg2]번 공격하여 [Arg4]%의 <PunctureDamagewords:관통 피해>를 입힙니다. 현재 태세가 「고요한 바다」일 경우, 산출력 소비가 2 감소합니다. <RippleKeywords:여파>: 촉수 1개가 적을 공격합니다."
  },
  Skill_4077_Desc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 입힙니다. 추가로 [Arg3]%의 촉수 피해와 힘 계수가 적용됩니다. 모든 촉수가 [Arg2]번 공격하여 [Arg4]%의 <PunctureDamagewords:관통 피해>를 입힙니다. <RippleKeywords:여파>: 촉수 1개가 적을 공격합니다."
  },
  Skill_4077_Desc_1 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 입힙니다. 추가로 [Arg3]%의 촉수 피해와 힘 계수가 적용됩니다. 모든 촉수가 모든 적에게 [Arg2]번 공격하여 [Arg4]%의 <PunctureDamagewords:관통 피해>를 입힙니다. 현재 태세가 「고요한 바다」일 경우, 산출력 소비가 2 감소합니다. <RippleKeywords:여파>: 촉수 1개가 적을 공격합니다."
  },
  Skill_4077_EffectNameList = {
    Text = "피해,모든 촉수 공격 피해 퍼센트"
  },
  Skill_4077_Name = {
    Text = "심연의 호령"
  },
  Skill_4077_PropertyNameList = {
    Text = "공격력*GrowValue1,GrowValue2"
  },
  Skill_4078_Desc = {
    Text = "이 카드를 뽑은 후 이번 턴에 사용한 카드가 3장 이하일 경우, 다음 턴 시작 시 행동력을 2pt 추가로 획득한다."
  },
  Skill_4078_Name = {
    Text = "증상: 의심"
  },
  Skill_4080_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 공격을 1회 받을 때마다 피해 횟수가 1회 증가한다."
  },
  Skill_4080_Name = {
    Text = "광기의 채찍"
  },
  Skill_4081_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 3턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_4082_Desc = {
    Text = "임시 <ParcloseIconKeywords:장벽> 1스택을 획득하고, 행동력이 영구적으로 2 감소한다."
  },
  Skill_4082_Name = {
    Text = "족쇄: 부활한 성녀"
  },
  Skill_4085_Desc = {
    Text = "[Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, [Arg2] 점의<PowerIconKeywords:힘>을 줄입니다."
  },
  Skill_4085_Name = {
    Text = "침식의 시선"
  },
  Skill_4086_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고 후퇴한다."
  },
  Skill_4087_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신은 「밀랍 코팅」 [Arg3]스택을 획득한다. 「밀랍 코팅」: 상태 이상 면역, 치명타 피해를 입을 때마다 1스택 감소한다."
  },
  Skill_4087_Name = {
    Text = "밀랍상 등장"
  },
  Skill_4088_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_38:「환각」> 1장을 섞어 넣는다."
  },
  Skill_4088_Name = {Text = "환각"},
  Skill_4089_Desc = {
    Text = "광기가 가장 낮은 깨어남체가 [Arg1] 광기를 획득한다."
  },
  Skill_4089_Name = {
    Text = "순수한 답례"
  },
  Skill_4090_Desc = {
    Text = "대상 깨어남체가 [Arg1] 광기를 획득한다."
  },
  Skill_4090_Name = {
    Text = "순수한 답례"
  },
  Skill_4092_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4092_Name = {
    Text = "뜻밖의 사망"
  },
  Skill_4093_AwakerSkillBackgroundStory = {
    Text = "표면적으로, 윈클이 항상 함께하는 기기는 “위치 탐지기-Y031”이라고 불리며, 정신을 안정시키고 정신 파동을 감지할 수 있다고 합니다.\n 그것이 왜 정신력을 압축하고 마치 포탄처럼 발사하는 기능을 가지고 있는 지는 윈클이 언급하지 않았습니다."
  },
  Skill_4093_Desc_0 = {
    Text = "모든 적의 <ParcloseIconKeywords:장벽> 상태를 제거하고 <Damage:[Damage:Arg1]> 포인트의 데미지를 입히고 1 턴 동안 <WeaknessIconKeywords:약화>를 적용합니다. [Arg3] 포인트의 은열에너지 획득.<TransitionIconKeywords:점프>: 대신 <Energy:[Energy:Arg2]> 포인트의 광기 획득"
  },
  Skill_4093_Desc_1 = {
    Text = "모든 적의 <ParcloseIconKeywords:장벽> 상태를 제거하고 <Damage:[Damage:Arg1]> 데미지와 1턴의 <WeaknessIconKeywords:허약>을 부여합니다. 은열쇠 에너지를 [Arg3]점 획득합니다. <TransitionIconKeywords:도약>: 대신 <Energy:[Energy:Arg2]> 광기를 획득합니다. 가한 데미지에 [Arg4]% 반격 계수가 적용됩니다."
  },
  Skill_4093_EffectNameList_0 = {
    Text = "피해, 광기, 은열쇠 에너지"
  },
  Skill_4093_EffectNameList_1 = {
    Text = "데미지,광기,은열쇠 에너지,반격 계수"
  },
  Skill_4093_Name = {
    Text = "에너지 광선"
  },
  Skill_4093_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4093_PropertyNameList_1 = {
    Text = "공격*GrowValue1,$GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4094_Desc = {
    Text = "깨어남체 1명의 카드에 「사냥당함」 상태를 부여하고, 자신에게 「사냥의 표식」 2스택을 부여한다."
  },
  Skill_4094_Name = {
    Text = "사냥 의식"
  },
  Skill_4095_AwakerSkillBackgroundStory = {
    Text = "홀로 떨어진 쥐가 어두운 구석에서 기어 다닌다. 그것은 여위고 작아서, 한 대의 빗자루로 쉽게 쫓아낼 수 있다.\n 방랑자도 마찬가지다.\n 작지만 힘이 있다. 방랑자와 쥐가 팀을 이루면, 그들은 막강해질 수 있다."
  },
  Skill_4095_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 X+1회 입히는 <DerivativeCardKeywords_12:「쥐 떼 돌격」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_4095_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 X+2회 입히는 <DerivativeCardKeywords_12:「쥐 떼 돌격」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_4095_EffectNameList = {
    Text = "「쥐 떼 돌격」 피해"
  },
  Skill_4095_Name = {
    Text = "쥐 떼 집합"
  },
  Skill_4095_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4097_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해만큼 HP를 회복한다."
  },
  Skill_4097_Name = {Text = "피"},
  Skill_4098_Desc = {
    Text = "점액이 다시 모여 릴리가 된다. 「불멸의 꽃」 상태를 획득하고 공격 형태를 전환한다. 「농포」 1개를 소환한다."
  },
  Skill_4098_Name = {
    Text = "점액 응집"
  },
  Skill_4099_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4100_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4102_AwakerSkillBackgroundStory = {
    Text = "배가 고픈 라이커가 배를 문지르며 거리에서 걷고 있습니다.\n 눈앞에 구운 치킨이 갑자기 나타나면 좋겠다고 생각했습니다.\n 한 검은 그림자가 갑자기 옆에서 튀어나오고, 그 후 여자의 비명이 들려왔다.\n 라이커는 눈이 빠르고 손이 빠르게 그 그림자를 붙잡았고, 가방을 여인에게 돌려주려 했으나 여인의 표정이 이상했습니다.\n 한바탕 엉켜진 후, 경찰이 천천히 도착했습니다.\n 알고 보니 여인은 유명한 보석 괴도였습니다.\n 보석 주인은 라이커에게 맛있는 식사를 대접하고, 추가로 금색 보석 하나를 선물했습니다.\n “정말 의외의 수확이군요.” 라이커가 배를 문지르며 말했습니다."
  },
  Skill_4102_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 덱에서 카드 1장을 선택하여 손에 넣는다. 치명타 발생 시, 선택한 카드의 행동력 소모를 1 감소시킨다."
  },
  Skill_4102_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 덱에서 카드 1장을 선택하여 손에 넣는다. 치명타 발생 시, 선택한 카드의 행동력 소모를 2 감소시킨다."
  },
  Skill_4102_EffectNameList = {Text = "피해"},
  Skill_4102_Name = {
    Text = "의외의 수확"
  },
  Skill_4102_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4103_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4104_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 「사냥의 표식」 1스택당 임시 <PowerIconKeywords:힘>이 [Arg4] 감소한다."
  },
  Skill_4104_Name = {
    Text = "두개골 파쇄"
  },
  Skill_4105_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4105_Name = {
    Text = "탐색 공격"
  },
  Skill_4106_Desc = {
    Text = "<MadnessIconKeywords:광란> [Arg1]스택을 획득한다. 젠킨이 방어되지 않은 피해를 입힐 때마다, 무작위 「명령 카드」에 영구적인 상처를 남긴다."
  },
  Skill_4106_Name = {
    Text = "공간 접기"
  },
  Skill_4107_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4108_Desc = {
    Text = "모든 증상 카드를 <DerivativeCardKeywords_37:「질식」>으로 변경한다. 질식: 비용 1, 턴 종료 시 손에 남아있으면 자신에게 <IntoxicationIconKeywords:중독> [Arg1]pt를 부여한다."
  },
  Skill_4108_Name = {
    Text = "잊혀진 고난의 바다"
  },
  Skill_4109_AwakerSkillBackgroundStory = {
    Text = "부드러운 바다 바람 속에서 그녀는 잠에 빠졌지만, 날개 퍼덕이는 소리에 깨어났다. 온몸이 눈처럼 하얀 작은 새가 그녀의 머리 위를 스쳐 지나가며, 같은 눈처럼 하얀 구름 속으로 사라졌다.\n 그것은 분명 꿈일 것이다. 육지에서 멀리 떨어진 대양 깊은 곳에서 어떻게 홀로 날아가는 새가 있을 수 있을까?\n 그녀는 그렇게 생각하면서도 어쩔 수 없이 희망과 동경을 느꼈다."
  },
  Skill_4109_BattleDesc_0 = {
    Text = "HP를 <Heal:[Heal:Arg1]> 회복하고, 행동력을 [Arg2]pt 획득하며 손패의 <SlowIconKeywords:둔화> 상태를 해제한다. 촉수 1개가 적을 공격하여 촉수 피해를 [Arg3]% 입힌다."
  },
  Skill_4109_BattleDesc_2 = {
    Text = "HP를 <Heal:[Heal:Arg1]> 회복하고, 행동력을 [Arg2]pt 획득하며 손패의 <SlowIconKeywords:둔화> 상태를 해제한다. <RetainIconKeywords:보존> 1턴당, 다음 사용 시 추가로 HP를 <Heal:[Arg3]> 회복한다. 촉수 1개가 적을 공격하여 촉수 피해를 [Arg4]% 입힌다."
  },
  Skill_4109_Desc_0 = {
    Text = "HP를 <Heal:[Heal:Arg1]> 회복하고, 행동력을 [Arg2]pt 획득하며 손패의 <SlowIconKeywords:둔화> 상태를 해제한다. 촉수 1개가 적을 공격하여 촉수 피해를 [Arg3]% 입힌다."
  },
  Skill_4109_Desc_2 = {
    Text = "HP를 <Heal:[Heal:Arg1]> 회복하고, 행동력을 [Arg2]pt 획득하며 손패의 <SlowIconKeywords:둔화> 상태를 해제한다. <RetainIconKeywords:보존> 1턴당, 다음 사용 시 추가로 HP를 <Heal:[Arg3]> 회복한다. 촉수 1개가 적을 공격하여 촉수 피해를 [Arg4]% 입힌다."
  },
  Skill_4109_EffectNameList_0 = {Text = "회복"},
  Skill_4109_EffectNameList_2 = {
    Text = "회복, 추가 회복"
  },
  Skill_4109_Name = {
    Text = "순백의 꿈"
  },
  Skill_4109_PropertyNameList_0 = {
    Text = "체질*GrowValue1,"
  },
  Skill_4109_PropertyNameList_2 = {
    Text = "체질*GrowValue1, 체질*GrowValue2"
  },
  Skill_4110_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4110_Name = {
    Text = "밀랍상 등장"
  },
  Skill_4111_AwakerSkillBackgroundStory = {
    Text = "차원을 넘나드는 참격으로 무방비한 자들을 참수한다."
  },
  Skill_4111_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4111_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 2배로 적용된다. <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <TransitionIconKeywords:워프>: 행동력 1pt를 획득한다."
  },
  Skill_4111_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 다프다엘이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4111_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 2배로 적용된다. 다프다엘이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <TransitionIconKeywords:워프>: 행동력 1pt를 획득한다."
  },
  Skill_4111_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4111_Name = {Text = "타격"},
  Skill_4111_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4112_Desc = {
    Text = "덱에서 카드 1장을 선택하여 손에 넣는다."
  },
  Skill_4112_Name = {Text = "탐색"},
  Skill_4113_AwakerSkillBackgroundStory = {
    Text = "닝피아는 바다의 축복을 받은 아이입니다. 언제든지 그녀가 기도를 시작하면, 이 바다의 정령들은 그녀 주변을 맴돌며 오랫동안 떠나려 하지 않습니다."
  },
  Skill_4113_BattleDesc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4113_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 님피아가 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4113_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4113_Name = {Text = "방어"},
  Skill_4113_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4114_AwakerSkillBackgroundStory = {
    Text = "“이런 단순한 속임수, 귀하신 손님, 잘 보세요.”"
  },
  Skill_4114_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4114_BattleDesc_1 = {
    Text = "방어막을 <Block:[Block:Arg1]> 획득하고, 현재 HP가 50% 미만일 경우 추가로 1회 방어막을 획득합니다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg4]%. 광기를 <Energy:[Energy:Arg2]> 획득합니다."
  },
  Skill_4114_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 소렐이 광기를 <Energy:[Energy:Arg3]>pt 획득한다."
  },
  Skill_4114_Desc_1 = {
    Text = "방어막을 <Block:[Block:Arg1]> 획득하고, 현재 HP가 50% 미만일 경우 추가로 1회 방어막을 획득합니다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg4]%. 소레이유가 광기를 <Energy:[Energy:Arg3]> 획득합니다."
  },
  Skill_4114_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4114_Name = {Text = "방어"},
  Skill_4114_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4115_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4116_Desc = {
    Text = "뽑았을 때 자신의 최대 HP가 20% 감소한다. 사용 후 모든 깨어남체의 이번 턴 치명타 피해가 100% 증가한다. 판매 불가."
  },
  Skill_4116_Name = {Text = "융식"},
  Skill_4117_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_34:「채워지지 않은 고통」> 2장을 덱에 넣는다."
  },
  Skill_4117_Name = {Text = "고통"},
  Skill_4118_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]pt를 부여한다."
  },
  Skill_4118_Name = {
    Text = "자아의 장례식"
  },
  Skill_4119_BattleDesc = {
    Text = "HP를 [Arg1] 잃고, 행동력 2를 획득한다. 판매 불가."
  },
  Skill_4119_Desc = {
    Text = "최대 HP의 10%를 잃고, 행동력 2pt를 획득한다. 판매 불가."
  },
  Skill_4119_Name = {
    Text = "증상: 망상"
  },
  Skill_4120_AwakerSkillBackgroundStory = {
    Text = "그녀는 격투사에게 자신을 죽여달라고 요청했다.\n“곧 그들이 나를 찾아 나를 모욕하고, 내 머리를 자를 거야. 내 부모님에게 했던 것처럼.”\n나는 그런 저열한 벌레의 손에 죽는 것을 원치 않지만, 너…... 너는 그들과 다르다.\n이것이 내가 가진 유일한 부탁이야. 나를 죽여줘.”\n격투사는 하하 웃으며, 그 소리가 가슴을 울리고, 그의 몸에 있는 족쇄도 덩달아 철컥철컥 소리를 냈다.\n그는 그녀의 말에 감동받지 않았지만, 항상 문 앞에 오는 신선한 피를 거부하지 않았다."
  },
  Skill_4120_Desc_0 = {
    Text = "방어막을 <Block:[Block:Arg1]> 획득합니다. 현재의 <EmbryoFusionIconKeywords:배아 융합>이 2배로 증가합니다."
  },
  Skill_4120_Desc_1 = {
    Text = "방어막을 <Block:[Block:Arg1]> 획득합니다. 현재의 <EmbryoFusionIconKeywords:배아 융합>이 2배로 증가합니다. 손패에서 산출력 소비가 가장 높은 카드 1장의 산출력 소비가 이번 턴 동안 1 감소합니다."
  },
  Skill_4120_EffectNameList_0 = {
    Text = "실타래드"
  },
  Skill_4120_Name = {
    Text = "마지못한 자비"
  },
  Skill_4120_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4121_AwakerSkillBackgroundStory = {
    Text = "온화하고 아름다운 것뿐만 아니라 날카롭고 공격적인 것도 예술의 일부입니다."
  },
  Skill_4121_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_4121_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 샨이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4121_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4121_Name = {Text = "타격"},
  Skill_4121_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4122_AwakerSkillBackgroundStory = {
    Text = "보호막은 자신감 부족의 표현이며, 배제당한 자가 스스로 세운 방어벽입니다."
  },
  Skill_4122_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4122_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카이커스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4122_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4122_Name = {Text = "방어"},
  Skill_4122_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4123_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4124_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4125_AwakerSkillBackgroundStory = {
    Text = "에리카 허리 옆의 장치는 바로 그녀의 동력 원천이다. 얽히고 설킨 기계들은 이해할 수 없는 원리에 따라 끊임없이 그녀에게 필요한 전류를 공급한다.\n 주인과 마찬가지로 이 장치는 매우 불안정하며, 그녀가 단락되는 순간 거대한 에너지가 폭발하고, 보이는 전류가 사방으로 튕겨 나가며 주변의 모든 것을 태울 것이다."
  },
  Skill_4125_Desc_0 = {
    Text = "소모한 행동력이 짝수일 경우, <Damage:[Damage:Arg2]>pt의 피해를 X+2회 입힌다. 홀수일 경우, <Block:[Block:Arg3]>pt의 실타래드를 X+1회 획득한다."
  },
  Skill_4125_Desc_3 = {
    Text = "소모한 행동력이 짝수일 경우, <Damage:[Damage:Arg2]>pt의 피해를 X+2회 입힌다. 홀수일 경우, <Block:[Block:Arg3]>pt의 실타래드를 X+1회 획득한다. <TransitionIconKeywords:워프>: 두 효과가 동시에 발동된다."
  },
  Skill_4125_EffectNameList = {
    Text = "피해, 실타래드"
  },
  Skill_4125_Name = {
    Text = "기능 과부하"
  },
  Skill_4125_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4126_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「구걸자」를 소환한다."
  },
  Skill_4126_Name = {
    Text = "분열 타격"
  },
  Skill_4127_Desc = {
    Text = "<DerivativeCardKeywords_32:「끈적이는 밀랍」> 1장을 상대의 덱에 섞어 넣는다."
  },
  Skill_4127_Name = {
    Text = "성대한 접대"
  },
  Skill_4128_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4129_Desc = {
    Text = "모든 손패를 버리고, 버린 수량 + 2장의 카드를 드로우한다."
  },
  Skill_4129_Name = {
    Text = "순백의 첫 만남"
  },
  Skill_4130_AwakerSkillBackgroundStory = {
    Text = "“환호하고, 비명을 지르고, 광기로! 이렇게 해야 진정한 카니발이다!”"
  },
  Skill_4130_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4130_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 카시아가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4130_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4130_Name = {Text = "타격"},
  Skill_4130_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4131_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4132_Desc = {
    Text = "사용 불가."
  },
  Skill_4132_Name = {Text = "환각"},
  Skill_4133_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_4133_Name = {
    Text = "석질 분해"
  },
  Skill_4134_AwakerSkillBackgroundStory = {
    Text = "주교가 성실타래하게 축복의 의식을 집행합니다. \n사람이 더 이상 상처받지 않고, 고통받지 않기를 바랍니다. 고통이 없는 나라가 이 세상에 강림하기를 바랍니다."
  },
  Skill_4134_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4134_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 핏빛 용광로 회복량을 <Heal:[Heal:Arg3]>pt 축적한다."
  },
  Skill_4134_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 살바도르가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4134_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 살바도르가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 핏빛 용광로 회복량을 <Heal:[Heal:Arg3]>pt 축적한다."
  },
  Skill_4134_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4134_EffectNameList_1 = {
    Text = "실타래드, 광기, 핏빛 용광로 축적"
  },
  Skill_4134_Name = {Text = "방어"},
  Skill_4134_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4134_PropertyNameList_1 = {
    Text = "방어력*GrowValue1,$GrowValue2, 체질*GrowValue3"
  },
  Skill_41357_Desc = {
    Text = "<DreamGuide:몽인> 10스택을 소모하여, 모든 적에게 1턴 동안 「몽유」 상태를 부여한다: 주는 피해가 [Arg3]% 감소하고, 공격 횟수가 2배로 증가한다."
  },
  Skill_41357_Name = {
    Text = "잠결의 메아리"
  },
  Skill_41358_Desc = {
    Text = "<DreamGuide:몽인> 1스택을 획득한다."
  },
  Skill_41358_Name = {
    Text = "최면 맥박"
  },
  Skill_41359_Desc = {
    Text = "<DreamGuide:몽인> 5스택을 소모하여, 완다가 <Energy:[Energy:Arg1]>의 광기를 획득하고, 현재 영구 <RetaliateIconKeywords:반격>의 [Arg2]%([Arg3])에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_41359_Name = {
    Text = "깊은 잠의 반격"
  },
  Skill_4135_Desc = {Text = "폐기"},
  Skill_4135_Name = {Text = "폐기"},
  Skill_4136_Desc = {
    Text = "모든 손패를 버리고,"
  },
  Skill_4136_Name = {
    Text = "기형의 심장"
  },
  Skill_4137_AwakerSkillBackgroundStory = {
    Text = "연역법은 논리적 추론으로, 올바른 전제를 파악해야만 정확한 결론을 도출할 수 있다.\n\n탐정이 되기 전, 라모나는 세상을 인식하기 위해 연역법을 사용해 왔다.\n\n충분한 모험을 겪은 후, 아마 그녀는 귀납법을 사용하는 것을 고려하기 시작할지도 모른다."
  },
  Skill_4137_Desc_0 = {
    Text = "<Posse:[Arg1]>pt의 열쇠 에너지를 획득하고, 덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣으며, 그 카드의 비용을 0pt으로 만든다."
  },
  Skill_4137_Desc_3 = {
    Text = "<Posse:[Arg1]>pt의 열쇠 에너지를 획득하고, 덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣으며, 그 카드의 비용을 0pt으로 만든다. <DerivativeCardKeywords_4:「영감」> 1장을 덱에 섞어 넣는다."
  },
  Skill_4137_EffectNameList = {
    Text = "은열쇠 충전"
  },
  Skill_4137_Name = {
    Text = "세계 연역법"
  },
  Skill_4137_OverLimitUtlSkillDesc_0 = {
    Text = "<Posse:[Arg1]> 점의 은열쇠 에너지를 획득합니다. 덱 또는 버린 카드 더미에서 카드 1장을 선택해 손패에 넣고, 해당 카드의 행동력 소모를 0점으로 변경합니다. 모든 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:약점>을 부여하며, 다음에 발동되는 키오더가 2회 발동됩니다."
  },
  Skill_4137_OverLimitUtlSkillDesc_3 = {
    Text = "<Posse:[Arg1]>pt의 은열쇠 에너지를 획득하고, 덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣으며, 그 카드의 행동력 소모를 0pt로 만든다. <DerivativeCardKeywords_4:「영감」> 1장을 덱에 섞어 넣는다. 모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 1턴간 부여하고, 다음에 발동하는 열쇠 지령이 2회 발동한다."
  },
  Skill_4138_AwakerSkillBackgroundStory = {
    Text = "라모나는 열 살 때, 전투 훈련을 받고 싶다는 요청을 했다.\n\n기사 놀이를 하고 싶어서가 아니라, 양아버지의 사치와 낭비를 목격한 후, 소녀는 다가올 파산에 대비하기로 결심했다.\n\n“여왕의 경호 보수는 경찰서 급여보다 높겠죠?”"
  },
  Skill_4138_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다. 사용 후 「여왕의 검」의 피해 횟수가 1회 증가하며, 최대 [Arg3]회까지 증가한다. 임시 영역 숙련도를 [Arg7] 획득한다."
  },
  Skill_4138_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [Arg5]회 입히며, 피해를 입힐 때마다 [Power:Arg4]점의 임시 <PowerIconKeywords:힘>을 획득합니다. 사용 후 「여왕의 검」의 피해 횟수 +1, 최대 [Arg6]회까지 증가합니다. [Arg7]점의 임시 영역 숙련을 획득합니다. <RippleKeywords:여파>: 라모나의 은열쇠 충전에 상응하는 은열쇠 에너지를 300% 획득합니다."
  },
  Skill_4138_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [Arg5]회 입히며, 피해를 입힐 때마다 [Power:Arg4]점의 임시 <PowerIconKeywords:힘>을 획득합니다. 사용 후 「여왕의 검」의 피해 횟수 +1, 최대 [Arg6]회까지 증가합니다. [Arg7]점의 임시 영역 숙련을 획득합니다. <RippleKeywords:여파>: 라모나의 은열쇠 충전에 상응하는 은열쇠 에너지를 300% 획득합니다."
  },
  Skill_4138_EffectNameList_0 = {Text = "피해"},
  Skill_4138_EffectNameList_1 = {
    Text = "피해,임시 힘"
  },
  Skill_4138_Name = {
    Text = "여왕의 검"
  },
  Skill_4138_PropertyNameList_0 = {
    Text = "공격력*GrowValue1"
  },
  Skill_4138_PropertyNameList_1 = {
    Text = "공격력*GrowValue1,공격력*GrowValue2"
  },
  Skill_4139_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득하며, <AlertIconKeywords:경계> [Arg3]pt를 획득한다."
  },
  Skill_4139_Name = {
    Text = "전체 강화"
  },
  Skill_4140_Desc = {
    Text = "뽑았을 때 HP 1을 잃고, 사용 후 카드 1장을 드로우한다. 몸이 흩어지는 것 같다…"
  },
  Skill_4140_Name = {Text = "융식액"},
  Skill_4141_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4142_Desc = {
    Text = "카드를 2장 뽑고, 「증상: 망언」 1장을 버린 카드 더미에 넣는다. 판매 불가."
  },
  Skill_4142_Name = {
    Text = "증상: 망언"
  },
  Skill_4143_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4144_AwakerSkillBackgroundStory = {
    Text = "주인님의 명령이라면, 릴리는 그 커다란 녀석을 풀어놓을 수 있습니다. 그 녀석은 고통을 두려워하지 않거든요. 고통은 힘일 뿐이고, 고통은 광기를 부추기니까요. 릴리도 고통이 두렵지 않고, 그 녀석도 고통을 두려워하지 않아요. 그러니 그것은 틀림없이 주인님을 도와 적들을 섬멸해 줄 거예요."
  },
  Skill_4144_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 대상의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킵니다. 크리티컬이라면 중독 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 취급됩니다. <PainWord:인내> 1스택마다 피해가 2 증가하고, 사용 후 <PainWord:인내>를 제거합니다."
  },
  Skill_4144_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 대상의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킵니다. 크리티컬이라면 중독 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 취급됩니다. <PainWord:인내> 1스택마다 피해가 2 증가하고, 사용 후 <PainWord:인내>를 제거합니다. 이 카드의 크리티컬 확률이 20% 증가합니다."
  },
  Skill_4144_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 대상의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킵니다. 크리티컬이라면 중독 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 취급됩니다. <PainWord:인내> 1스택마다 피해가 2 증가하고, 사용 후 <PainWord:인내>의 절반을 제거합니다. 이 카드의 크리티컬 확률이 20% 증가합니다."
  },
  Skill_4144_EffectNameList = {Text = "피해"},
  Skill_4144_Name = {
    Text = "보복의 일격"
  },
  Skill_4144_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4144_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 줍니다. 대상의 <IntoxicationIconKeywords:중독> 효과를 [Arg3]% 발동하며, 치명타 시 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 간주됩니다. <PainWord:인내> 1중첩당 피해가 2 증가합니다."
  },
  Skill_4144_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 줍니다. 대상의 <IntoxicationIconKeywords:중독> 효과를 [Arg3]% 발동하며, 치명타 시 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 간주됩니다. <PainWord:인내> 1중첩당 피해가 2 증가하며, 낸 후 <PainWord:인내>를 제거합니다. 이 카드의 치명타율이 20% 증가합니다."
  },
  Skill_4144_tempBattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 대상의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킵니다. 크리티컬이라면 중독 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 취급됩니다. <PainWord:인내> 1스택마다 피해가 2 증가하고, 사용 후 <PainWord:인내>의 절반을 제거합니다. 이 카드의 크리티컬 확률이 20% 증가합니다."
  },
  Skill_4144_tempBattleDesc_4 = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 가하고, 대상의 <IntoxicationIconKeywords:중독> 효과를 [Arg3]% 발동시키며, 치명타 발생 시 발동 비율이 [Arg4]%로 증가합니다. 「타격」으로 간주합니다. <PainWord:인내> 1중첩당 피해가 [Float:Arg6] 증가하며, 사용 후 <PainWord:인내>의 절반을 제거합니다. 이 카드의 치명타율이 20% 증가합니다."
  },
  Skill_4145_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4146_Desc = {
    Text = "자신에게 [Arg1] 점 <FixedDamage:순수 피해>를 입히고, [Arg2] 점 임시 <PowerIconKeywords:힘>을 획득하며, 카드 1장을 뽑습니다."
  },
  Skill_4146_Name = {
    Text = "채워지지 않은 고통"
  },
  Skill_4147_Desc_0 = {
    Text = "<Damage:[Damage:Arg2]>의 피해를 무작위로 [Arg1]회 준다."
  },
  Skill_4147_EffectNameList = {
    Text = "「쥐 떼 돌격」 피해"
  },
  Skill_4147_Name = {
    Text = "쥐 떼 돌격"
  },
  Skill_4147_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4148_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4149_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득하며 전진한다."
  },
  Skill_4150_Desc = {
    Text = "[Arg1]의 실타래드를 획득한다. 실타래드가 사라질 때, 남은 실타래드가 2배의 HP로 전환된다."
  },
  Skill_4150_Name = {
    Text = "불멸의 꽃"
  },
  Skill_4151_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4152_AwakerSkillBackgroundStory = {
    Text = "피가 바닥에 흐르고, 시체가 여기저기 널려 있든지, 심장을 꿰뚫는 고통을 견디든지,\n신의 땅이 세상에 다시 오기 위해서는 이것들이 모두 미미한 희생입니다.\n그녀는 자신이 선택받은 자가 아니며, 감옥에 갇힌 소녀가 아니라는 것만을 원망합니다."
  },
  Skill_4152_Desc_0 = {
    Text = "다른 깨어남체 1명을 선택하여 <Energy:[Energy:Arg2]>의 광기를 부여한다. <O07CardKeyWord:의식>: 추가로 [Arg4]/[Arg5]/[Arg6]의 광기를 부여한다."
  },
  Skill_4152_Desc_2 = {
    Text = "다른 깨어남체 1명을 선택하여 <Energy:[Energy:Arg2]>의 광기를 부여하고, 영역 숙련이 [Arg3] 증가한다. <O07CardKeyWord:의식>: 추가로 [Arg4]/[Arg5]/[Arg6]의 광기를 부여한다."
  },
  Skill_4152_EffectNameList = {Text = "광기"},
  Skill_4152_Name = {
    Text = "선택받은 자"
  },
  Skill_4154_AwakerSkillBackgroundStory = {
    Text = "들어봐, 그것은 자신을 위해 울리는 장례식 종소리이다.\n 미친 탐색자가 아니고, 어리버리하게 길 잃은 자도 아니다. 그녀는 그저 조용히 자신의 종착지를 선택했다.\n 시든 꽃잎들이 그녀의 제의를 위해 춤추고, 광란의 바람이 그녀의 장송가를 위해 슬퍼한다.\n 그 심장을 울리는 종소리 뒤에, 세상은 잠시 죽음 같은 고요함에 빠진다."
  },
  Skill_4154_Desc_0 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg1]스택 부여하고, [Arg2]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4154_Desc_1 = {
    Text = "전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg1]스택 부여하고, [Arg2]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 실타래드를 <Block:[Block:Arg3]>pt 획득한다."
  },
  Skill_4154_EffectNameList_0 = {Text = "중독"},
  Skill_4154_EffectNameList_1 = {
    Text = "중독, 실타래드"
  },
  Skill_4154_Name = {
    Text = "장례의 종소리"
  },
  Skill_4154_PropertyNameList_0 = {
    Text = "공격력*GrowValue1"
  },
  Skill_4154_PropertyNameList_1 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4155_AwakerSkillBackgroundStory = {
    Text = "만고에서, 무지에서, 공포에서 비롯된 것입니다.\n타이스의 혈관 속을 흐르는 것은 원시적인 본능입니다.\n 되돌릴 수 없는 헌신의 제사 속에서, 그 당시 아직 어린 타이스는 이 본능이 심어졌습니다.\n 의지, 감정, 나아가 인격까지 그녀와는 관계없는 존재로 대체되었습니다.\n그녀가 남긴 것은 오직 이 생명 간의 공통된, 죽음을 두려워하는 본능뿐입니다."
  },
  Skill_4155_BattleDesc_0 = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg1], <Posse:[Arg2]> 점 은열쇠 에너지를 획득합니다. 선택: <B01AFKeyWord1:공포의 피>, <B01AFKeyWord2:부패의 피>, <B01AFKeyWord3:생식의 피><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_BattleDesc_1 = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg1], <Posse:[Arg2]> 점 은열쇠 에너지를 획득합니다. 선택: <B01AFKeyWordQ1:공포의 피>, <B01AFKeyWordQ2:부패의 피>, <B01AFKeyWordQ3:생식의 피><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg1], 타이스의 은열쇠 충전의 2배에 해당하는 은열쇠 에너지를 획득합니다. 선택: <B01AFKeyWord1:공포의 피>, <B01AFKeyWord2:부패의 피>, <B01AFKeyWord3:생식의 피><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_1 = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg1], 타이스의 은열쇠 충전의 2배에 해당하는 은열쇠 에너지를 획득합니다. 선택: <B01AFKeyWordQ1:공포의 피>, <B01AFKeyWordQ2:부패의 피>, <B01AFKeyWordQ3:생식의 피><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_EffectNameList = {
    Text = "배아 융합"
  },
  Skill_4155_Name = {
    Text = "성혈의 본능"
  },
  Skill_4156_AwakerSkillBackgroundStory = {
    Text = "그녀가 귀족의 글동무로 일할 때, 오를라는 서재의 한구석에서 시집을 읽는 것을 좋아했다. 그 슬픈 시구들은 항상 그녀를 눈물을 흘리게 했다."
  },
  Skill_4156_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 「방어」로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「슬픔」으로 전환한다."
  },
  Skill_4156_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다. 「방어」로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「슬픔」으로 전환한다."
  },
  Skill_4156_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 올라가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 「방어」로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「슬픔」으로 전환한다. 「슬픔」 은유 1스택을 소모할 때마다 HP를 <Heal:[Heal:Arg3]>pt 회복한다."
  },
  Skill_4156_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 올라가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다. 「방어」로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「슬픔」으로 전환한다. 「슬픔」 은유 1스택을 소모할 때마다 HP를 <Heal:[Heal:Arg3]>pt 회복한다."
  },
  Skill_4156_EffectNameList = {
    Text = "실타래드, 광기, 회복"
  },
  Skill_4156_Name = {
    Text = "애통의 시편"
  },
  Skill_4156_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2, 체질*GrowValue3"
  },
  Skill_4157_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4158_Desc = {
    Text = "이 카드가 손에 있는 동안 모든 깨어남체의 치명타율이 25% 증가한다. 턴 종료 시, 무작위 「증상 카드」 1장을 덱에 넣는다."
  },
  Skill_4158_Name = {
    Text = "증상: 맹종"
  },
  Skill_4160_AwakerSkillBackgroundStory = {
    Text = "브장송의 시녀가 보기에, 그녀의 아가씨는 조금 유별났다. 아가씨는 시 읽기를 즐기지 않았고, 악기 연주도 전혀 하지 않았다. 그녀는 생명을 다한 것들에 매료되어 있었다. 시들어버린 낙엽 한 잎을 넋을 잃고 바라보다가...... 이내 벌떡 일어나 방으로 뛰어갔다. 그러고는— 쾅! 쾅! 쾅! \"어휴, 우리 꼬마 예술가님 좀 보셔!\" 시녀가 한숨을 쉬며 말했다. \"시멘트 석공이랑 다를 게 대체 뭐람?\""
  },
  Skill_4160_Desc_0 = {
    Text = "다음 턴 시작 시, 자신의 <FragileIconKeywords:손상> 상태를 해제하고 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4160_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg2]>pt 획득한다. 다음 턴 시작 시, 자신의 <FragileIconKeywords:손상> 상태를 해제하고 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4160_EffectNameList_0 = {
    Text = "지연 실타래드"
  },
  Skill_4160_EffectNameList_1 = {
    Text = "지연 실타래드, 실타래드"
  },
  Skill_4160_Name = {
    Text = "폐쇄적 창작"
  },
  Skill_4160_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4160_PropertyNameList_1 = {
    Text = "방어력*GrowValue1, 방어력*GrowValue2,"
  },
  Skill_4161_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택을 부여한다."
  },
  Skill_4161_Name = {Text = "독소"},
  Skill_4162_Desc = {
    Text = "석화 상태, 행동할 수 없음"
  },
  Skill_4162_Name = {Text = "석화"},
  Skill_4163_AwakerSkillBackgroundStory = {
    Text = "이 깊은 증오와 병적인 점액을 가시로 응결하여, 적의 목을 단칼에 베어버리는 절대적인 일격을 가해."
  },
  Skill_4163_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4163_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입힙니다. <Energy:[Energy:Arg2]> 광기와 10% 크리티컬 피해를 획득합니다."
  },
  Skill_4163_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 히로가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4163_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입힙니다. 시로가 <Energy:[Energy:Arg2]> 광기와 10% 크리티컬 피해를 획득합니다."
  },
  Skill_4163_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4163_Name = {Text = "타격"},
  Skill_4163_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4164_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4165_AwakerSkillBackgroundStory = {
    Text = "“공격 명령 실타래행 완료, 다음 명령을 내려주세요.”"
  },
  Skill_4165_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4165_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 에리카가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4165_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4165_Name = {Text = "타격"},
  Skill_4165_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4166_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다!"
  },
  Skill_4166_Name = {
    Text = "사슬을 끊는 일격"
  },
  Skill_4167_AwakerSkillBackgroundStory = {
    Text = "살롱을 준비하는 것은 쉬운 일이 아니다. 주류, 메뉴, 심지어는 웨이터의 선정까지 모두 직접 해야 한다. \n다행히도, 소렐은 그녀의 추종자들로부터 충분한 자유와 특권을 얻었다."
  },
  Skill_4167_Desc_0 = {
    Text = "소렐이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: [Power:Arg2]pt의 <PowerIconKeywords:힘>을 획득하고, 소렐이 피해를 1회 줄 때마다 [Power:Arg3]pt의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4167_Desc_15 = {
    Text = "소렐이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: [Power:Arg2]pt의 <PowerIconKeywords:힘>을 획득하고, 소렐이 피해를 1회 줄 때마다 [Power:Arg3]pt의 임시 <PowerIconKeywords:힘>을 획득하며 소렐의 임시 최종 피해가 2% 증가하고, 다른 깨어남체는 1% 증가한다. 임시 최종 피해 증가 효과는 매 턴 최대 [Arg4]회 발동한다."
  },
  Skill_4167_EffectNameList = {
    Text = "광기, 힘, 임시 힘"
  },
  Skill_4167_Name = {
    Text = "환영 특권"
  },
  Skill_4167_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4168_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <PVPBleedingKeywords:출혈>을 부여하며, 이 피해에는 2배의 <PowerIconKeywords:힘> 보너스가 적용된다."
  },
  Skill_4168_Name = {
    Text = "거대한 검의 위엄-피"
  },
  Skill_4169_AwakerSkillBackgroundStory = {
    Text = "맛있는 것은 먹어야 하고, 강력한 힘은 사용해야 한다. \n소녀는 기도하며 체내에 숨겨진 힘을 자극했다."
  },
  Skill_4169_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4169_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가한다."
  },
  Skill_4169_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 머피가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4169_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 머피가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가한다."
  },
  Skill_4169_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4169_EffectNameList_2 = {
    Text = "실타래드, 광기, 촉수 피해"
  },
  Skill_4169_Name = {Text = "방어"},
  Skill_4169_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4169_PropertyNameList_2 = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_4170_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 주고, 이 피해에는 2배의 <PowerIconKeywords:힘> 보너스가 적용된다. <VulnerabilityIconKeywords:취약>을 [Arg2]스택 부여한다."
  },
  Skill_4170_Name = {
    Text = "거대한 검의 위엄-마무리"
  },
  Skill_4171_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg4]회 입히며, 이 피해에는 2배의 <PowerIconKeywords:힘> 보너스가 적용된다. <PowerIconKeywords:힘>을 [Arg2]pt 획득하고, 적의 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>의 절반을 제거한다."
  },
  Skill_4171_Name = {
    Text = "거대한 검의 위엄-힘"
  },
  Skill_4172_AwakerSkillBackgroundStory = {
    Text = "“그녀는 개미 한 마리도 해치고 싶어 하지 않아요.”\n“그럼 그녀를 죽여서 다른 ‘그녀’를 오게 하세요.”"
  },
  Skill_4172_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4172_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, '24'가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4172_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4172_Name = {Text = "타격"},
  Skill_4172_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4173_Desc = {
    Text = "기절 상태, 행동할 수 없음"
  },
  Skill_4173_Name = {Text = "기절"},
  Skill_4174_Desc = {
    Text = "자신의 앞과 뒤에 「등불」을 각각 1개씩 소환한다."
  },
  Skill_4174_Name = {
    Text = "성례 의식"
  },
  Skill_4175_AwakerSkillBackgroundStory = {
    Text = "“거리 쥐”라는 별명을 가진 아이들이 쥐를 받아들였는지, 아니면 진짜 쥐가 거리 아이들을 받아들였는지는 말하기 어렵습니다. 생계에 의해 탄생한 이 우정은 여러 해의 교류 속에서 깨지지 않을 정도로 단단해졌습니다.\n 누가 동물이 인간의 가장 좋은 친구가 아니라고 말할 수 있을까?"
  },
  Skill_4175_Desc = {
    Text = "소녀는 분명히 어떠한 특수 능력도 갖추고 있지 않았다."
  },
  Skill_4175_EffectNameList = {Text = "힘"},
  Skill_4175_Name = {Text = "없음"},
  Skill_4175_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4176_AwakerSkillBackgroundStory = {
    Text = "「하—앗!」"
  },
  Skill_4176_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4176_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 오지에가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4176_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4176_Name = {Text = "방어"},
  Skill_4176_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4177_AwakerSkillBackgroundStory = {
    Text = "그 두 줄의 간헐적으로 나타나는 삼각형 이빨을 두려워하지 마세요, 그리고 들어간 후 다시 나오지 않는 흰 토끼 아가씨에 대해서도 걱정하지 마세요. 모자 쓴 선생님은 카시아 대마법사에 의해 직접 훈련된 전문 마법 아이템으로, 절대 함부로 물지 않아요."
  },
  Skill_4177_Desc_0 = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득한다. 손의 증상 카드와 상태 카드를 모두 버리고, 나머지 카드를 덱에 섞은 후, 버리고 섞은 장수만큼 카드 X장을 드로우한다. <TransitionIconKeywords:워프>: 「모두 사라져라!」의 행동력 소모를 반환한다."
  },
  Skill_4177_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득한다. 손의 증상 카드와 상태 카드를 모두 버리고, 나머지 카드를 덱에 섞은 후, 버리고 섞은 장수만큼 카드 X장을 드로우한다. 카드 1장을 뽑을 때마다 <Energy:[Energy:Arg2]>의 광기를 획득한다. <TransitionIconKeywords:워프>: 「모두 사라져라!」의 행동력 소모를 반환한다."
  },
  Skill_4177_EffectNameList = {Text = "광기"},
  Skill_4177_Name = {
    Text = "사라지는 마술!"
  },
  Skill_4178_AwakerSkillBackgroundStory = {
    Text = "“나에게 가장 적합한 것은 왕을 넘어서 정치를 주도할 수 있는 권력이다。”"
  },
  Skill_4178_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4178_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 현재 HP가 50%([Arg4]) 미만일 경우 추가로 1회 피해를 입힙니다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg3]%. 광기를 <Energy:[Energy:Arg2]> 획득합니다."
  },
  Skill_4178_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 소렐이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4178_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 현재 HP가 50% 미만일 경우 추가로 1회 피해를 입힙니다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg3]%. 소레이유가 광기를 <Energy:[Energy:Arg2]> 획득합니다."
  },
  Skill_4178_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4178_Name = {Text = "타격"},
  Skill_4178_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4181_Desc = {
    Text = "자신이 <RetaliateIconKeywords:반격> [Arg1]스택을 획득한다."
  },
  Skill_4181_Name = {
    Text = "기브 앤 테이크"
  },
  Skill_4182_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택을 부여한다."
  },
  Skill_4182_Name = {Text = "독소"},
  Skill_4183_Desc = {
    Text = "「24」가 광기를 [Energy:Arg1]pt 획득한다. 창백하고, 손상하지만, 그럼에도 불구하고 굳건하다."
  },
  Skill_4183_Name = {
    Text = "그녀를 살려줘!"
  },
  Skill_4184_BattleDesc = {
    Text = "[Arg1]번의 임시 <PowerIconKeywords:힘>을 얻습니다 (카드를 사용할 때). 카드를 뽑았을 때 [Arg2]의 임시 <PowerIconKeywords:힘>이 감소합니다."
  },
  Skill_4184_Desc = {
    Text = "[Arg1]번의 임시 <PowerIconKeywords:힘>을 얻습니다 (카드를 사용할 때). 카드를 뽑았을 때 [Arg2]의 임시 <PowerIconKeywords:힘>이 감소합니다."
  },
  Skill_4184_Name = {
    Text = "증상: 쇼크"
  },
  Skill_4185_Desc = {
    Text = "모든 적의 <PowerIconKeywords:힘>이 임시로 [Arg1]pt 감소하고, 1턴 동안 획득하는 실타래드와 <PowerIconKeywords:힘>이 50% 감소한다."
  },
  Skill_4185_EffectNameList = {Text = "힘 감소"},
  Skill_4185_Name = {Text = "저주"},
  Skill_4185_PropertyNameList = {
    Text = "공격력*GrowValue"
  },
  Skill_4186_Desc = {
    Text = "전체 아군이 <Block:[Block:Arg1]>의 실타래드를 획득한다."
  },
  Skill_4186_Name = {
    Text = "전체 방어막"
  },
  Skill_4187_Desc = {
    Text = "공허 [Arg1]스택을 부여한다."
  },
  Skill_4187_Name = {
    Text = "광기 흡수"
  },
  Skill_4188_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4188_Name = {
    Text = "물어뜯기"
  },
  Skill_4189_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <DerivativeCardKeywords_3:「기절」> [Arg2]장을 덱에 섞어 넣는다."
  },
  Skill_4190_Desc = {
    Text = "[Arg1]pt의 HP를 회복하고, 모든 적의 힘을 [Arg1]pt 감소시킨다. 뽑았을 때 모든 깨어남체가 <Energy:10>의 광기를 잃는다."
  },
  Skill_4190_Name = {
    Text = "거인의 공포"
  },
  Skill_4191_Desc = {
    Text = "모든 깨어남체가 <Energy:[Energy:Arg1]> 광기를 획득한다."
  },
  Skill_4191_Name = {
    Text = "혼돈 충전"
  },
  Skill_4192_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]pt를 부여한다."
  },
  Skill_4192_Name = {
    Text = "자아의 장례식"
  },
  Skill_4193_AwakerSkillBackgroundStory = {
    Text = "“촉수, 셀 수 없는 촉수가 땅속에서 나를 끌어당기고 있어…\n 의사님, 제가 히스테리에 걸린 건가요…”\n 여자는 무기력하게 울며, 그녀는 매우 두려워했다. 그녀의 맞은편에는 안경을 쓴 긴 머리의 의사가 앉아 있었다.\n “아니, 이건 히스테리가 아니야.”\n 의사는 웃으며, 눈이 뱀처럼 길게 좁아졌다.\n “이건 진실타래이야… 이 세계에 관한, 왜곡된 진실타래.”"
  },
  Skill_4193_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 이번 전투 동안 「뒤틀린 시체의 광연」의 기본 피해가 20% 증가한다."
  },
  Skill_4193_EffectNameList_0 = {
    Text = "피해, 은열쇠 에너지, 혼돈 광란 피해 증가, 촉수 피해, 촉수 피해 계수%, 배아 융합, 핏빛 용광로 축적, 힘, 임시 힘 감소, 초차원 광란 피해 증가, 초차원 광란 피해 상한"
  },
  Skill_4193_Name = {
    Text = "뒤틀린 시체의 광연"
  },
  Skill_4193_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]> 의 <PunctureDamagewords:관통 피해>를 입히고, 이번 전투 동안 「뒤틀린 시체의 광연」의 기본 데미지가 20% 증가합니다. 영역 마스터리를 24 획득하고, 「24」의 다음 커맨드 카드가 3번 발동됩니다."
  },
  Skill_4193_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2, 공격력*GrowValue3, 공격력*GrowValue4,$GrowValue5,$GrowValue6, 체질*GrowValue7, 공격력*GrowValue8, 방어력*GrowValue9, 공격력*GrowValue10"
  },
  Skill_4194_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4194_Name = {Text = "깨물기"},
  Skill_4195_AwakerSkillBackgroundStory = {
    Text = "깨어남체가 된 후, 오지에는 무정형의 검은 물질과 안정적인 공생 관계를 형성했다.\n\n융식의 참상을 목격한 사람들은 종종 오지에의 등장에 극도로 긴장하게 된다.\n\n오지에와 함께 전투를 치러본 사람만이 그 무형의 존재가 얼마나 견고한 장벽으로 응결될 수 있는지를 알고 있다."
  },
  Skill_4195_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt X+1회 획득하며, 행동력 1pt를 소모할 때마다 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4195_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt X+1회 획득한다. 행동력 1pt를 소모할 때마다 광기를 <Energy:[Energy:Arg3]>pt 획득한다. <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4195_EffectNameList_0 = {
    Text = "실타래드"
  },
  Skill_4195_EffectNameList_3 = {
    Text = "실타래드, 힘"
  },
  Skill_4195_Name = {
    Text = "부정형 장벽"
  },
  Skill_4195_PropertyNameList_0 = {
    Text = "방어력*GrowValue1"
  },
  Skill_4195_PropertyNameList_3 = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4196_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4196_Name = {
    Text = "뒤틀린 시체의 광연"
  },
  Skill_4197_AwakerSkillBackgroundStory = {
    Text = "“닻을 올려라, 출항할 시간이다.”"
  },
  Skill_4197_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 촉수 1개가 적을 공격하여 [Arg3]%의 촉수 피해를 입힌다."
  },
  Skill_4197_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 셀레스트가 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 촉수 1개가 적을 공격하여 [Arg3]%의 촉수 피해를 입힌다."
  },
  Skill_4197_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4197_Name = {Text = "타격"},
  Skill_4197_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4198_AwakerSkillBackgroundStory = {
    Text = "노틸라의 인생 신조: 용접으로 고칠 수 없는 것은 없다. 만약 있다면, 몇 번 더 용접하면 된다. \n하지만 대부분의 경우, 그녀가 반복해서 용접하는 이유는 그렇지 않다."
  },
  Skill_4198_BattleDesc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4198_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 노틸라가 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4198_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4198_Name = {Text = "방어"},
  Skill_4198_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4199_Desc = {
    Text = "무작위 깨어남체에게 임시 봉인 1스택을 부여한다. 이 효과를 2회 반복한다."
  },
  Skill_4199_Name = {Text = "봉인"},
  Skill_4200_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4201_Desc = {
    Text = "[Arg2]pt의 <PowerIconKeywords:힘>을 획득하고, 족쇄 4장을 손에 넣는다."
  },
  Skill_4201_Name = {
    Text = "복수 선언"
  },
  Skill_4202_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4203_AwakerSkillBackgroundStory = {
    Text = "헤헤! 놀랐지?"
  },
  Skill_4203_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4203_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 오레타가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4203_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4203_Name = {Text = "타격"},
  Skill_4203_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4203_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4203_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 의 <PunctureDamagewords:관통 피해>를 4회 가합니다. <Energy:[Energy:Arg2]> 의 광기를 획득합니다."
  },
  Skill_4204_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4205_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4205_Name = {Text = "광노"},
  Skill_4206_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 덱과 버린 카드 더미의 모든 카드에게 「<SlowIconKeywords:둔화>」와 「<PrepareKeywords:예비>」를 부여한다."
  },
  Skill_4206_Name = {
    Text = "진·영겁의 눈"
  },
  Skill_4207_Desc = {
    Text = "전체가 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4208_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_36:「모독의 환영」> 3장을 손에 넣는다."
  },
  Skill_4208_Name = {
    Text = "이계의 응시"
  },
  Skill_4209_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 입히고 동일한 양의 출혈을 부여하며 후퇴한다."
  },
  Skill_4209_Name = {
    Text = "찢어발기는 타격"
  },
  Skill_4210_Desc = {
    Text = "「미안해」 2마리를 소환하고, 그들에게 <ParcloseIconKeywords:장벽> 1스택을 부여한다."
  },
  Skill_4210_Name = {
    Text = "죄책감의 바다"
  },
  Skill_4211_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4212_Desc = {
    Text = "모든 적의 임시 힘을 [Arg2]pt 감소시키고, <DerivativeCardKeywords_26:증상:「망상」> 1장을 손에 넣는다. \"아파? 정말 불쌍하구나… 울어도 돼!\""
  },
  Skill_4212_Name = {Text = "절규"},
  Skill_4213_Desc = {
    Text = "적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4213_Name = {
    Text = "뾰족한 나무"
  },
  Skill_4214_AwakerSkillBackgroundStory = {
    Text = "노틸라의 작업 공간에는 크고 작은 메모지가 철로 가득 붙어 있다. 이것은 실타래비아 씨가 그녀에게 전해준 방법으로, 중요한 것들을 기억하는 데 도움을 줄 수 있다.\n하지만 한 쪽 면만 적힌 그 일기처럼, 이 메모지에도 똑같은 글귀가 적혀 있다: 잊지 마세요.\n 어떤 기억은 글을 쓰는 순간 이미 조용히 사라져버렸다."
  },
  Skill_4214_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득한다. 다른 깨어남체 1명을 선택하여 <Energy:[Energy:Arg2]>의 광기를 부여한다."
  },
  Skill_4214_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4214_Name = {
    Text = "단기 기억"
  },
  Skill_4214_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4215_Desc = {
    Text = "턴 종료 시 손에 있을 경우, <IntoxicationIconKeywords:중독> [Arg1]스택을 획득한다. \"나와 함께 빠져들어라!\""
  },
  Skill_4215_Name = {Text = "질식"},
  Skill_4216_Desc = {
    Text = "임시 <ParcloseIconKeywords:장벽> [Arg1]스택을 획득한다."
  },
  Skill_4216_Name = {Text = "벌꿀 술"},
  Skill_4217_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4217_Name = {
    Text = "날개 펼치기"
  },
  Skill_4218_Desc = {
    Text = "실타래드를 [Arg2]pt 및 「방혈」 상태를 획득한다. 「방혈」: 방어되지 않은 피해를 1회 줄 때마다 <BleedingIconKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_4218_Name = {
    Text = "항해 요리"
  },
  Skill_4219_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4220_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4222_BattleDesc = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득하고, 영구 힘의 25%([Arg3])에 해당하는 임시 <PowerIconKeywords:힘>을 추가로 획득합니다."
  },
  Skill_4222_Desc = {
    Text = "[Arg1] 포인트 <PowerIconKeywords:힘>을 획득하고, 영구 힘의 25%에 해당하는 임시 <PowerIconKeywords:힘>을 추가로 획득합니다."
  },
  Skill_4222_Name = {
    Text = "영원한 집착"
  },
  Skill_4223_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg4] 번 입히고, [Arg2] 장의 카드에 「깊은 잠수 인장」을 부여하며, 사용 시 적에게 일시적으로 <PowerIconKeywords:힘>을 부여."
  },
  Skill_4223_Name = {
    Text = "사냥감 표식"
  },
  Skill_4224_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4224_Name = {
    Text = "혼돈의 짐승"
  },
  Skill_4225_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4226_Desc = {
    Text = "[Arg1]스택의 기도 상태를 획득한다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택을 잃고, 턴 종료 시 모두 사라진다."
  },
  Skill_4226_Name = {Text = "기도"},
  Skill_4227_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 이후 「연속 깨물기」의 공격 횟수를 증가시킨다."
  },
  Skill_4227_Name = {
    Text = "연속 깨물기"
  },
  Skill_4228_Desc = {
    Text = "매 턴마다 [Arg1]의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4228_Name = {
    Text = "복수 예고"
  },
  Skill_4229_AwakerSkillBackgroundStory = {
    Text = "필리스틴의 수장은 거대한 검을 쥔 강력한 전사로, 단 한 번 검을 휘두르는 것만으로도 적을 베어 넘길 수 있었다. 필리스틴의 수장은 잔혹한 폭군이었다. 잔인하고 이기적인 그는 목적을 달성하기 위해서라면 자신의 모든 동족마저도 기꺼이 희생시킬 수 있는 자였다. 필리스틴의 선대 수장은 욕망의 노예였다. 끝없이 힘을 갈망하던 그는, 결국 자신이 좇던 그 힘에 집어삼켜지고 말았다."
  },
  Skill_4229_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 대상의 HP가 25%([Arg3]) 미만이거나 대상을 처치할 경우 소모한 행동력을 반환한다. 이 피해에는 <PowerIconKeywords:힘>이 [Arg2]배로 적용된다."
  },
  Skill_4229_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 대상의 HP가 25%([Arg3]) 미만이거나 대상을 처치할 경우 소모한 행동력을 반환한다. 이 피해에는 <PowerIconKeywords:힘>이 [Arg2]배로 적용되며, 촉수 1개당 힘 배율이 1배 추가로 증가한다."
  },
  Skill_4229_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 대상의 HP가 25% 미만이거나 대상을 처치할 경우 소모한 행동력을 반환한다. 이 피해에는 <PowerIconKeywords:힘>이 [Arg2]배로 적용된다."
  },
  Skill_4229_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 대상의 HP가 25% 미만이거나 대상을 처치할 경우 소모한 행동력을 반환한다. 이 피해에는 <PowerIconKeywords:힘>이 [Arg2]배로 적용되며, 촉수 1개당 힘 배율이 1배 추가로 증가한다."
  },
  Skill_4229_EffectNameList = {Text = "피해"},
  Skill_4229_Name = {
    Text = "참수의 일섬"
  },
  Skill_4229_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4230_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 50pt를 획득한다."
  },
  Skill_4230_Name = {
    Text = "그림자의 메아리"
  },
  Skill_4231_AwakerSkillBackgroundStory = {
    Text = "봐봐! 오레타가 물고기처럼 거품을 내고 있어!"
  },
  Skill_4231_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4231_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4231_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4231_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카드 1장을 드로우한다. 오레타가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4231_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4231_Name = {Text = "방어"},
  Skill_4231_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4232_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4232_Name = {
    Text = "뒤틀린 시체의 광연"
  },
  Skill_4233_AwakerSkillBackgroundStory = {
    Text = "부드러운 바닷물이 시든 꽃잎을 보내고, 피어나는 물결은 수련이 열리고 닫히듯이 움직입니다.\n 당신이 방심하면, 그 평온한 겉모습에 속아 넘어갈 것입니다. 고요한 달빛 아래의 사사로운 파도는 실타래제로는 만물을 삼킬 힘을 내포하고 있습니다.\n 그녀의 사랑과 증오처럼, 결코 색으로 드러나지 않지만, 거세게 일렁이는 파도 속에서 격렬하게 울려 퍼집니다."
  },
  Skill_4233_Desc_0 = {
    Text = "HP가 가장 높은 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. 이 피해에는 <PowerIconKeywords:힘>이 2배로 적용된다."
  },
  Skill_4233_Desc_2 = {
    Text = "HP가 가장 높은 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. 이 피해에는 <PowerIconKeywords:힘>이 2배로 적용된다. 매 턴 3장까지 증상 카드를 사용할 때마다 「요동치는 밤물결」의 피해가 이번 전투 동안 [Arg2] 증가한다."
  },
  Skill_4233_EffectNameList = {Text = "피해"},
  Skill_4233_Name = {
    Text = "밤의 파도"
  },
  Skill_4233_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4234_AwakerSkillBackgroundStory = {
    Text = "“내가 뭐했더라?” \n노틸라가 조사가 끝난 후 항상 이렇게 묻는다. 공격한 융식체에 대한 죄책감 때문은 아니고. 그저 정말로 잊어버렸기 때문이다."
  },
  Skill_4234_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4234_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기와 <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득한다."
  },
  Skill_4234_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 노틸라가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4234_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 노틸라가 <Energy:[Energy:Arg2]>pt의 광기와 <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득한다."
  },
  Skill_4234_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4234_EffectNameList_1 = {
    Text = "피해, 광기, 반격"
  },
  Skill_4234_Name = {Text = "타격"},
  Skill_4234_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4234_PropertyNameList_1 = {
    Text = "공격력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_4235_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 「쥐 떼의 분노」를 획득한다. 「쥐 떼의 분노」: 다음 턴에 공격을 1회 받을 때마다 [Arg3]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4235_Name = {
    Text = "쥐 떼 집합"
  },
  Skill_4238_AwakerSkillBackgroundStory = {
    Text = "과거에 운명에 순응하던 그였다면, 아마 이 방어를 세우지 않았을 것."
  },
  Skill_4238_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4238_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4238_Desc_0 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 툴루가 <Energy:[Energy:Arg2]>의 광기를 획득한다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4238_Desc_2 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 툴루가 <Energy:[Energy:Arg2]>의 광기를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4238_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4238_EffectNameList_2 = {
    Text = "실타래드, 광기, 임시 촉수 피해, 임시 힘"
  },
  Skill_4238_Name = {Text = "방어"},
  Skill_4238_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4238_PropertyNameList_2 = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3, 공격력*GrowValue3"
  },
  Skill_4239_AwakerSkillBackgroundStory = {
    Text = "신성의 지배 아래 있는 이 땅에서, 국민들은 이 대주제를 사랑하고 있음이 분명하다.\n모든 사람은 그녀의 성실타래함, 그녀의 근면함, 그녀의 희생을 볼 수 있다.\n그래서 많은 이들이 그녀를 어머니 신과 동일시하고 있다. 물론, 이 일은 비밀리에 이야기해야 하며, 절대 미리암에게 알려서는 안 된다."
  },
  Skill_4239_Desc_0 = {
    Text = "<O07CardKeyWord2:「성례」> [Arg4]장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg5]스택을 부여한다. 촉수 자세에 따라 효과를 획득한다. 조수: <PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 정해: 다른 깨어남체가 <Energy:[Energy:Arg2]>의 광기를 획득한다. 노도: 전체 적의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다."
  },
  Skill_4239_Desc_3 = {
    Text = "<O07CardKeyWord2:「성례」> [Arg4]장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg5]스택을 부여한다. 촉수 자세에 따라 효과를 획득한다. 조수: <PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 정해: 다른 깨어남체가 <Energy:[Energy:Arg2]>의 광기를 획득한다. 노도: 전체 적의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다."
  },
  Skill_4239_EffectNameList = {
    Text = "힘/촉수 피해, 광기, 중독 발동%, 중독"
  },
  Skill_4239_Name = {
    Text = "심연을 향한 기도"
  },
  Skill_4239_OverLimitUtlSkillDesc = {
    Text = "<O07CardKeyWord2:「성례」> [Arg6]장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg5]스택을 부여한다. 촉수 상한과 촉수 수가 1 증가한다. 촉수 자세에 따라 효과를 획득한다. 조수: <PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 정해: 다른 깨어남체가 <Energy:[Energy:Arg2]>의 광기를 획득한다. 노도: 전체 적의 <IntoxicationIconKeywords:중독> [Arg3]%를 발동시킨다."
  },
  Skill_4239_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2,$GrowValue3, 공격력*$GrowValue4"
  },
  Skill_4240_AwakerSkillBackgroundStory = {
    Text = "이 아름다운 트레이를 보세요, 아름답고 귀여운 그녀에게 딱 맞지 않나요?"
  },
  Skill_4240_BattleDesc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4240_Desc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 카렌이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4240_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4240_Name = {Text = "방어"},
  Skill_4240_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4241_AwakerSkillBackgroundStory = {
    Text = "대부분의 사람들이 처음 그 미성 가수의 소리를 들을 때 놀라워합니다. \n그 작고 섬세한 육체로부터 어떻게 그런 큰 소리와 에너지가 폭발할 수 있는 지. \n연음이 점점 커지며 소리가 온 우주를 관통합니다."
  },
  Skill_4241_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 다음 턴에 치명타율이 [Arg2]% 증가한다. <TransitionIconKeywords:워프>: 실타래드를 <Block:[Block:Arg3]>pt 획득하고, 다음 턴에 치명타율이 [Arg4]% 증가하는 효과로 변경된다."
  },
  Skill_4241_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 다음 턴에 치명타율과 치명타 피해가 [Arg2]% 증가한다. <TransitionIconKeywords:워프>: 실타래드를 <Block:[Block:Arg3]>pt 획득하고, 다음 턴에 치명타율과 치명타 피해가 [Arg4]% 증가하는 효과로 변경된다."
  },
  Skill_4241_EffectNameList = {
    Text = "실타래드, 워프 실타래드"
  },
  Skill_4241_Name = {
    Text = "울려 퍼지는 선율"
  },
  Skill_4241_PropertyNameList = {
    Text = "방어력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4242_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, [Arg2]의 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_4242_Name = {Text = "경계"},
  Skill_4243_AwakerSkillBackgroundStory = {
    Text = "펜과 잉크는 그녀의 무기이지만, 장미의 가시처럼 항상 자신을 상처 입힌다."
  },
  Skill_4243_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg3]>pt의 광기를 획득한다. 「타격」으로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「분노」로 전환한다."
  },
  Skill_4243_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주고, 광기를 [Energy:Arg3]pt 획득한다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 「타격」으로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「분노」로 전환한다."
  },
  Skill_4243_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 올라가 <Energy:[Energy:Arg3]>pt의 광기를 획득한다. 「타격」으로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「분노」로 전환한다. 「분노」 은유 1스택을 소모할 때마다 추가로 2회 피해를 입힌다."
  },
  Skill_4243_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주고, 올라가 광기를 [Energy:Arg3]pt 획득한다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 「타격」으로 간주한다. <TransitionIconKeywords:워프>: 감정 상태를 「분노」로 전환한다. 「분노」 은유 1스택을 소모할 때마다 추가로 피해를 2회 준다."
  },
  Skill_4243_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4243_Name = {
    Text = "광상의 시편"
  },
  Skill_4243_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4244_AwakerSkillBackgroundStory = {
    Text = "화려하고 부유한 공간에 숨은 상류층 캐릭터들과 직접 마주하지 않은 사이에도, 라이커는 과한 승리로 인해 그들의 적대감을 사게 되었다. \n그는 거리에서 습격을 당했지만, 총알은 가슴 주머니의 은화를 정확히 맞혔다."
  },
  Skill_4244_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4244_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 행동력이 부족할 경우 검은 인장 3개를 소모하여 2회 발동할 수 있다. (현재 검은 인장: [Arg3])"
  },
  Skill_4244_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 라이커가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4244_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 라이커가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 행동력이 부족할 경우 검은 인장 3개를 소모하여 2회 발동할 수 있다."
  },
  Skill_4244_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4244_Name = {Text = "방어"},
  Skill_4244_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4245_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고 후퇴한다."
  },
  Skill_4246_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4247_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4247_Name = {
    Text = "물어뜯기"
  },
  Skill_4248_Desc = {
    Text = "사용 후 [Arg1] 점 <FixedDamage:순수 피해>를 받고, 카드 2장을 뽑아 <DepleteIconKeywords:소모>합니다. 턴 종료 시 손에 있을 경우, [Arg2] 점 피해를 받습니다."
  },
  Skill_4248_Name = {
    Text = "모독의 환영"
  },
  Skill_4249_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4249_Name = {
    Text = "혼돈의 짐승"
  },
  Skill_4250_AwakerSkillBackgroundStory = {
    Text = "어린 왕은 신의 속삭임을 끊임없이 듣고 있어 꿈에서 벗어나기 힘들어한다.\n그럼에도 불구하고, 깨어 있을 때 남긴 몇 마디는 나라를 다스리기에 충분하다.\n아무리 소극적으로 피하려 해도, 백성에게 부여받은 위엄은 그의 권력이 되었다."
  },
  Skill_4250_Desc_0 = {
    Text = "툴루가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한이 1 증가하고, 툴루가 행동력 1pt를 소모하거나 툴루의 명령 카드 1장을 버릴 때마다 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다."
  },
  Skill_4250_Desc_15 = {
    Text = "툴루가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한이 1 증가하고, 툴루가 행동력 1pt를 소모하거나 툴루의 명령 카드 1장을 버릴 때마다 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 툴루가 광기 폭발을 발동한 후, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 최대 [Arg4]회 중첩된다."
  },
  Skill_4250_EffectNameList = {
    Text = "광기, 촉수 피해, 힘"
  },
  Skill_4250_Name = {
    Text = "불멸의 위엄"
  },
  Skill_4250_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2, 공격력*GrowValue2"
  },
  Skill_4251_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4253_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4254_Desc = {
    Text = "기도 4스택을 획득하고, 다른 아군을 희생한다. 희생한 아군 1명당 기도를 [Arg1]스택 추가 획득한다."
  },
  Skill_4254_Name = {
    Text = "영원한 촛불"
  },
  Skill_4255_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4255_Name = {Text = "찌르기"},
  Skill_4257_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4257_Name = {Text = "짓밟기"},
  Skill_4258_Desc = {
    Text = "<IntoxicationIconKeywords:중독>을 [Arg2]스택 부여하고 용해를 1턴간 부여한다. 사용한 카드는 소모되며, 명령 카드의 피해와 보호막이 3배로 증가한다. 행동력 3pt를 획득하고, 카드를 3장 드로우한다."
  },
  Skill_4258_Name = {
    Text = "증오 포식"
  },
  Skill_4259_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여하고, 덱과 버린 카드 더미에서 무작위 카드 [Arg2]장에 「<SlowIconKeywords:둔화>」를 부여한다."
  },
  Skill_4259_Name = {
    Text = "둔화 독소"
  },
  Skill_4260_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4261_Desc = {
    Text = "기도 스택을 모두 소모하며, 2스택을 소모할 때마다 후열에 등불 교도 1명을 소환한다."
  },
  Skill_4261_Name = {
    Text = "성례 의식"
  },
  Skill_4263_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, <FragileIconKeywords:손상>을 [Arg2]턴간 부여한다."
  },
  Skill_4264_AwakerSkillBackgroundStory = {
    Text = "재미있는 광대가 날카로운 칼로 가득 찔려 있고, 거꾸로 매달린 공중곡예사가 실타래수로 떨어졌습니다. 편안하게 즐겨주세요, 사랑하는 관객 여러분들, 공연의 서막이 이제 막 올랐습니다."
  },
  Skill_4264_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4264_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카시아가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4264_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4264_Name = {Text = "방어"},
  Skill_4264_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4265_Desc = {
    Text = "여기서 쓰러질 수는 없다. 모두가 나를 기다리고 있다. 치명적 피해를 받을 때, HP를 1 회복한다."
  },
  Skill_4265_Name = {
    Text = "밀랍인형관 열쇠"
  },
  Skill_4266_Desc = {
    Text = "<DerivativeCardKeywords_80:「질식」> [Arg1]장을 상대의 손에 넣는다."
  },
  Skill_4266_Name = {
    Text = "익사자의 원한"
  },
  Skill_4268_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 입히고, <Block:[Block:Arg2]>pt의 실타래드를 획득한다."
  },
  Skill_4269_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_3:「기절」> [Arg3]장을 섞어 넣는다."
  },
  Skill_4270_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4270_Name = {
    Text = "사슬을 끊는 일격"
  },
  Skill_4271_Desc = {
    Text = "<PunctureDamagewords:관통 피해>를 준다. 손에서 행동력 소모가 가장 높은 카드 1장의 행동력 소모를 1 감소시킨다."
  },
  Skill_4271_Name = {Text = "관통"},
  Skill_4272_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4273_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_3:「기절」> [Arg3]장을 덱에 섞어 넣는다."
  },
  Skill_4274_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, [Arg2]스택의 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_4274_Name = {Text = "경계"},
  Skill_4275_AwakerSkillBackgroundStory = {
    Text = "“거리 싸움에는 별다른 규칙이 없어요. 그냥 손에 익은 걸 쓰면 돼요.”"
  },
  Skill_4275_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4275_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 젠킨이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4275_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4275_Name = {Text = "타격"},
  Skill_4275_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4277_AwakerSkillBackgroundStory = {
    Text = "무에서 유를 창조하는 것은 과학의 계역이 아닙니다.\n돌은 항상 그렇게 믿어왔습니다. 우주, 인류, 나아가 융식 현상까지, 모든 것에는 기원이 있으며, 모든 일에는 대가가 필요합니다.\n“그래서 연금술 기술의 개발에 관해서, 돌님은 어떻게 생각하시나요……”\n“개발 성공 가능성은 당신의 졸업 논문의 가치와 같아서, 둘 다 제로입니다.”"
  },
  Skill_4277_BattleDesc_0 = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복하고, 모든 손패를 버린다."
  },
  Skill_4277_BattleDesc_2 = {
    Text = "HP를 <Heal:[Heal:Arg1]>pt 회복한다. 모든 손패를 버리고, 버린 카드 1장당 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4277_Desc_0 = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복한다. 모든 손패를 버리고, 버린 카드 1장당 HP를 <Heal:[Heal:Arg2]> 추가로 회복한다."
  },
  Skill_4277_Desc_2 = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복한다. 모든 손패를 버리고, 버린 카드 1장당 HP를 <Heal:[Heal:Arg2]> 추가로 회복하며 그와 동일한 양의 실타래드를 획득한다."
  },
  Skill_4277_EffectNameList = {
    Text = "회복, 회복량 상승"
  },
  Skill_4277_Name = {
    Text = "등가 교환"
  },
  Skill_4277_PropertyNameList = {
    Text = "체질*GrowValue1, 체질*GrowValue2"
  },
  Skill_4278_AwakerSkillBackgroundStory = {
    Text = "따뜻한 피가 그의 볼을 타고 흘러내렸고, 그는 입을 벌려 날카로운 이빨을 드러냈다. \n약육강식은 세상의 근본이며, 그는 영원한 사냥꾼이 될 것이다. \n그는 시체들 위를 밟으며 승리의 포효를 내질렀다."
  },
  Skill_4278_Desc_0 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 전체 적의 <PowerIconKeywords:힘>을 임시로 모두 제거한다."
  },
  Skill_4278_Desc_2 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 전체 적의 <PowerIconKeywords:힘>을 임시로 모두 제거하고, 제거한 만큼의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4278_EffectNameList = {Text = "힘"},
  Skill_4278_Name = {
    Text = "강자의 법칙"
  },
  Skill_4278_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4279_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4280_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4281_AwakerSkillBackgroundStory = {
    Text = "그녀는 언제부터 이렇게 변했는지 기억조차 나지 않는다. 무의식 중에, 예전 아버지 앞에 무릎 꿇고 슬픔을 토하며 용서를 구하던 소녀는 이미 죽었고, 사치스러운 망국의 꽃이 그녀의 피로 태어났다. “내 가장 고귀한 작은 까마귀야, 오늘 너는 또 어떤 찬란한 보석을 나에게 가져왔니?”"
  },
  Skill_4281_BattleDesc = {
    Text = "현재 HP의 [Arg1]%([Arg4])를 잃고, <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg2]%. 이번 턴 동안 피해를 1회 입힐 때마다, 턴 종료 시 HP를 [Arg3] 회복합니다."
  },
  Skill_4281_Desc = {
    Text = "현재 HP의 [Arg1]%를 잃고, <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg2]%. 이번 턴 동안 피해를 1회 입힐 때마다, 턴 종료 시 HP를 [Arg3] 회복합니다."
  },
  Skill_4281_EffectNameList = {
    Text = "배아 융합, 회복"
  },
  Skill_4281_Name = {
    Text = "진주옥란"
  },
  Skill_4281_PropertyNameList = {
    Text = "$GrowValue1, 체질*GrowValue2"
  },
  Skill_4282_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4283_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4283_Name = {
    Text = "오만의 검"
  },
  Skill_4284_AwakerSkillBackgroundStory = {
    Text = "그녀는 항상 신병들에게 말한다: 피곤하더라도, 약해지더라도, 절대 무기를 내려놓지 말라고. 그것이 당신의 가장 가까운 동반자, 가장 견고한 방어막이 되어야 한다고. \n전장에서 오직 경계하는 자만이 살아남을 수 있다."
  },
  Skill_4284_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt [Arg2]회 획득한다. 턴 종료 시 이 카드가 손에 있을 경우, 다음 사용 시 실타래드 획득 횟수가 1회 증가한다. 모든 깨어남체의 <CardKeyWord:봉인> 상태를 해제한다."
  },
  Skill_4284_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt [Arg2]회 획득한다. 턴 종료 시 이 카드가 손에 있을 경우, 다음 사용 시 실타래드 획득 횟수가 1회 증가한다. 모든 깨어남체의 <CardKeyWord:봉인> 상태를 해제한다. 「방어」로 간주한다."
  },
  Skill_4284_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 턴 종료 시 이 카드가 손에 있을 경우, 다음 사용 시 실타래드 획득 횟수가 1회 증가한다. 모든 깨어남체의 <CardKeyWord:봉인> 상태를 해제한다."
  },
  Skill_4284_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 턴 종료 시 이 카드가 손에 있을 경우, 다음 사용 시 실타래드 획득 횟수가 1회 증가한다. 모든 깨어남체의 <CardKeyWord:봉인> 상태를 해제한다. 「방어」로 간주한다."
  },
  Skill_4284_EffectNameList = {
    Text = "실타래드"
  },
  Skill_4284_Name = {
    Text = "임전 태세"
  },
  Skill_4284_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_4285_AwakerSkillBackgroundStory = {
    Text = "그는 폭력의 상징으로 소환되어, 검투장의 스타가 되었다.\n그는 폭력의 상징으로 경멸당하며, 지하실타래의 수인이 되었다.\n쏟아지는 피가 철사슬에 의해 꽉 묶일 때,\n천 년의 갈증이여….\n포효하며, 날카로운 포효를 내질렀고,\n더 이상 참을 수 없었다."
  },
  Skill_4285_BattleDesc_0 = {
    Text = "현재 HP의 [Arg1]%([Arg4])를 잃고, 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. <PowerIconKeywords:힘>을 [Power:Arg3] 획득한다."
  },
  Skill_4285_Desc_0 = {
    Text = "현재 HP의 [Arg1]%를 잃고, 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_4285_EffectNameList_0 = {
    Text = "피해, 힘"
  },
  Skill_4285_Name = {
    Text = "피여, 소리질러라!"
  },
  Skill_4285_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4286_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_4287_AwakerSkillBackgroundStory = {
    Text = "격투사가 눈을 감았다.\n 심장박동이 부드럽고 힘차게, 먼 곳의 귀청이 터질 듯한 환호성을 덮어버린다.\n 어둠 아래, 살육이라는 불꽃이 꿈틀거리고 있다.\n 뛰고, 끓고, 끝없는 어둠을 핥아내리기까지.\n 격투사가 눈을 떴다. 그는 드디어 준비가 되었다."
  },
  Skill_4287_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 3회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. HP가 25%([Arg3]) 미만일 경우 획득하는 광기가 2배로 증가한다."
  },
  Skill_4287_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 3회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. HP가 25%([Arg3]) 미만일 경우 추가로 2회 피해를 입히고 획득하는 광기가 2배로 증가한다."
  },
  Skill_4287_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 3회 입히고, 유우하시가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. HP가 25% 미만일 경우 획득하는 광기가 2배로 증가한다."
  },
  Skill_4287_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 3회 입히고, 유우하시가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. HP가 25% 미만일 경우 추가로 2회 피해를 입히고 획득하는 광기가 2배로 증가한다."
  },
  Skill_4287_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4287_Name = {
    Text = "피여, 끓어올라라!"
  },
  Skill_4287_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4288_AwakerSkillBackgroundStory = {
    Text = "“별들이 정위에 도달할 때, 신국은 별들의 인도로 수면 위로 떠오르며 다시 나타날 것이다. 그때, 나 또한 다시 임할 것이며, 산령처럼 천지 사이에 자리잡을 것이다……”"
  },
  Skill_4288_Desc_0 = {
    Text = "촉수 [Arg1]개를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 임시 치명타율이 [Arg3]% 증가한다."
  },
  Skill_4288_EffectNameList_0 = {
    Text = "임시 촉수 피해, 임시 힘, 치명타율"
  },
  Skill_4288_Name = {
    Text = "정위의 순간"
  },
  Skill_4288_OverLimitUtlSkillDesc_0 = {
    Text = "촉수 [Arg1]개를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 임시 치명타율이 [Arg3]% 증가한다. 턴 종료 시, 모든 촉수가 모든 적을 2회 공격한다."
  },
  Skill_4288_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue1,$GrowValue2"
  },
  Skill_4288_tempBattleDesc_1 = {
    Text = "촉수 [Arg1]개를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 임시 치명타율이 [Arg3]% 증가한다."
  },
  Skill_4288_tempBattleDesc_2 = {
    Text = "촉수 [Arg1]개를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 임시 치명타율이 [Arg3]% 증가한다. 모든 적이 받는 촉수 피해가 10% 증가하며, 최대 5회 중첩된다."
  },
  Skill_4288_tempOverLimitUtlSkillDesc_1 = {
    Text = "촉수 [Arg1]개를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 임시 치명타율이 [Arg3]% 증가한다. 턴 종료 시, 모든 촉수가 모든 적을 2회 공격한다."
  },
  Skill_4288_tempOverLimitUtlSkillDesc_2 = {
    Text = "촉수 [Arg1]개를 획득한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 임시 치명타율이 [Arg3]% 증가한다. 모든 적이 받는 촉수 피해가 10% 증가하며, 최대 5회 중첩된다. 턴 종료 시, 모든 촉수가 모든 적을 2회 공격한다."
  },
  Skill_4289_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드를 [Arg3]pt 획득한다. 턴 종료 전까지 플레이어의 남은 손패 1장당 실타래드가 [Arg4]pt 추가로 증가한다."
  },
  Skill_4289_Name = {Text = "시도"},
  Skill_4290_AwakerSkillBackgroundStory = {
    Text = "개선식은 예로부터 로마인들의 성대한 축제였다. 하얀 비둘기와 월계수 잎, 그리고 하늘을 수놓으며 흩날리는 금가루…… 이 모든 영광은 전사를 위한 것이었으나, 한편으론 그와 전혀 무관한 것이기도 했다. 그는 갈리아, 알렉산드리아, 파르티아에서 끌려온 전쟁 포로들과 함께 무거운 십자가에 결박된 채 거리를 조리돌림당하고 있었다."
  },
  Skill_4290_BattleDesc_0 = {
    Text = "유우하시가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 유우하시는 <CardKeyWord:봉인>의 영향을 받지 않으며, 치명타율과 치명타 피해가 [Arg2]% 증가한다. HP가 25% 미만일 때 효과가 2배로 증가한다."
  },
  Skill_4290_BattleDesc_15 = {
    Text = "유우하시가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 유우하시는 <CardKeyWord:봉인>의 영향을 받지 않으며, 치명타율과 치명타 피해가 [Arg2]% 증가하고, 「피와 모래의 찬가」의 최종 피해가 [Arg5]% 증가한다. HP가 25% 미만일 때 효과가 2배로 증가한다."
  },
  Skill_4290_Desc_0 = {
    Text = "유우하시가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 유우하시는 <CardKeyWord:봉인>의 영향을 받지 않으며, 치명타율과 치명타 피해가 [Arg2]% 증가한다. HP가 25% 미만일 때 효과가 2배로 증가한다."
  },
  Skill_4290_Desc_15 = {
    Text = "유우하시가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 유우하시는 <CardKeyWord:봉인>의 영향을 받지 않으며, 치명타율과 치명타 피해가 [Arg2]% 증가하고, 「피와 모래의 찬가」의 최종 피해가 [Arg5]% 증가한다. HP가 25% 미만일 때 효과가 2배로 증가한다."
  },
  Skill_4290_EffectNameList = {Text = "광기"},
  Skill_4290_Name = {
    Text = "붉은 제례"
  },
  Skill_4291_AwakerSkillBackgroundStory = {
    Text = "그녀는 마음대로 행동하는 것을 좋아한다. 사람의 머리를 자르고, 꿰매고, 다시 자르고, 다시 꿰매고…… 동기도 없고 목적도 없다. 모든 것이 자연스럽게 이루어지며, 아무도 그녀를 비난하지 못한다."
  },
  Skill_4291_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 1스택을 획득한다."
  },
  Skill_4291_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 완다가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 1스택을 획득한다."
  },
  Skill_4291_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4291_Name = {Text = "타격"},
  Skill_4291_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4292_Desc = {
    Text = "행동력 3pt를 획득한다."
  },
  Skill_4292_Name = {
    Text = "쥐의 지혜"
  },
  Skill_4293_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4293_Name = {Text = "청소"},
  Skill_4294_Desc = {
    Text = "양측 모두에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다. 「예리한 칼날Ⅱ」를 획득한다: 방어되지 않은 피해를 입혔을 경우, 덱의 맨 위에 <DerivativeCardKeywords_23:「상처」> 2장을 추가한다. 1턴간 지속된다."
  },
  Skill_4294_Name = {
    Text = "죽음의 투쟁"
  },
  Skill_4295_AwakerSkillBackgroundStory = {
    Text = "이 두 눈은 더 이상 정상적으로 사물을 볼 수 없다.\n\n그녀는 시간과 현실타래의 폭풍을 정면으로 마주하며, 울부짖는 혼돈이 베고 갈가리 찢겨 마침내 그녀의 눈이 되도록 내버려 두었다.\n\n「라모나」에게 속한 또 하나의 흔적이 그녀의 몸에서 사라지고 있다. 그녀는 손끝에서 흘러가는 생명을 붙잡지 못했듯이, 흘러가는 자신 또한 붙잡을 수 없다."
  },
  Skill_4295_Desc = {
    Text = "[Power:Arg1]pt의 <PowerIconKeywords:힘>을 획득한다. 덱에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모량을 1 감소시킨다. <TimeBeacon:회귀>: 덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력을 0pt으로 만든다."
  },
  Skill_4295_EffectNameList = {Text = "힘"},
  Skill_4295_Name = {
    Text = "초월의 눈"
  },
  Skill_4295_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4296_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_36:「모독의 환영」> 1장을 손에 넣는다."
  },
  Skill_4296_Name = {
    Text = "정신 잠식"
  },
  Skill_4297_AwakerSkillBackgroundStory = {
    Text = "조심하세요. 이 여자의 모든 행동은 하나의 최종 목표를 향하고 있습니다. 그녀를 상처 입히는 것... 아니, 심하게 상처 입히는 것이다."
  },
  Skill_4297_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4297_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 레아가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4297_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4297_Name = {Text = "타격"},
  Skill_4297_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4298_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4298_Name = {
    Text = "남겨진 원한"
  },
  Skill_4299_Desc = {
    Text = "행동력 1pt를 획득한다."
  },
  Skill_4299_Name = {Text = "계산"},
  Skill_4300_Desc = {
    Text = "전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4300_Name = {Text = "취약"},
  Skill_4301_Desc = {
    Text = "카드 1장을 드로우한다."
  },
  Skill_4301_Name = {Text = "묘수"},
  Skill_4302_Desc = {
    Text = "다른 깨어남체가 <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_4302_Name = {Text = "촉매"},
  Skill_4303_Desc = {
    Text = "<DerivativeCardKeywords_4:「영감」> 1장을 덱에 넣는다."
  },
  Skill_4303_Name = {Text = "영감"},
  Skill_4304_Desc = {
    Text = "전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4304_Name = {Text = "허약"},
  Skill_4305_Desc = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_4305_Name = {Text = "광기"},
  Skill_4306_AwakerSkillBackgroundStory = {
    Text = "그녀는 땅에서 신의 이름으로 행할 것이다. \n그녀는 신의 아름다운 이름을 얻을 것이다. \n그녀는 파괴의 때에, 누구도 견딜 수 없는 고통을 받을 것이다. \n이것이 바로 대행자이다."
  },
  Skill_4306_Desc_0 = {
    Text = "미리암이 광기를 [Energy:Arg1]pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한과 촉수 수가 1 증가하고, 전체 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. 미리암의 「타격」과 「무상생제」의 치명타율이 100% 증가한다. <O07CardKeyWord4:「신앙의 갈림길」> 1장을 손에 넣는다."
  },
  Skill_4306_Desc_15 = {
    Text = "미리암이 광기를 [Energy:Arg1]pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한과 촉수 수가 1 증가하고, 전체 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. 미리암의 「타격」과 「무상생제」의 치명타율이 100% 증가한다. <O07CardKeyWord4:「신앙의 갈림길」> 1장을 손에 넣는다. 「성례」 2장을 뒤집을 때마다 「신국환영」 1장을 손에 넣는다."
  },
  Skill_4306_EffectNameList = {Text = "광기"},
  Skill_4306_Name = {
    Text = "신앙의 증언"
  },
  Skill_4307_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_4307_Name = {Text = "출혈"},
  Skill_4308_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4309_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_9:「낙담」> [Arg3]장을 덱에 넣는다."
  },
  Skill_4309_Name = {
    Text = "무성의 비명"
  },
  Skill_4310_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대는 턴 종료까지 <PowerIconKeywords:힘> [Arg3]pt를 잃는다."
  },
  Skill_4311_AwakerSkillBackgroundStory = {
    Text = "부드럽고 가벼운 접촉은 당신에게 사랑을 느끼게 할까요?\n따뜻한 숨결이 당신을 저에게 빠져들게 할까요?\n진주와 가벼운 실타래크로 전해오는 손길이 당신에게 선물일까요?"
  },
  Skill_4311_Desc_0 = {
    Text = "다른 깨어남체 1명을 선택하여, 자신과 해당 깨어남체가 모두 <Energy:[Energy:Arg1]>의 광기를 획득한다. <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4311_EffectNameList = {
    Text = "광기, 힘"
  },
  Skill_4311_Name = {
    Text = "고대의 애무"
  },
  Skill_4311_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4313_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다."
  },
  Skill_4313_Name = {Text = "독소"},
  Skill_4314_AwakerSkillBackgroundStory = {
    Text = "그녀의 피는 그들로 인해 끓어오르고, 그녀의 뇌수는 그들로 인해 요동친다. 이 이형(異形)의 아이들이 그녀의 오랜 숙원을 이루어줄지, 혹은 끝없는 공허 속에서 살아남을 수 있을지는 중요하지 않다. 타이스는 그저 애정을 가득 품은 채, 그 신성한 아이들이 탄생하는 매 순간을 기꺼이 맞이할 뿐이다."
  },
  Skill_4314_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 다른 깨어남체들이 <Energy:[Energy:Arg1]>pt의 광기를 획득한다.] 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입히고, 피해량의 [Arg3]%만큼 <BleedingIconKeywords:출혈>, 피해량의 [Arg4]%만큼 <IntoxicationIconKeywords:중독>을 부여하며, 피해량의 [Arg5]%만큼 <RetaliateIconKeywords:반격>을 획득한다. 손에서 비파생 명령 카드 1장을 선택하여, 해당 카드의 행동력 소모가 [Arg6] 감소한 원본 복사본 [Arg7]장을 손에 넣고, <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 부여한다."
  },
  Skill_4314_EffectNameList = {
    Text = "광기, 피해, 출혈%, 중독%, 반격%"
  },
  Skill_4314_Name = {
    Text = "풍요의 의식"
  },
  Skill_4314_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 다른 깨어남체가 <Energy:[Energy:Arg1]> 점의 광기를 얻습니다.]모든 적에게 <Damage:[Damage:Arg2]> 점의 데미지를 입히고, 데미지의 [Arg3]%에 해당하는 <BleedingIconKeywords:출혈>을 입히며, 데미지의 [Arg4]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여하고 데미지의 [Arg5]%에 해당하는 <RetaliateIconKeywords:반격>을 획득합니다. 손에 있는 파생되지 않은 명령 카드 1장을 선택하여, <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:공허>가 부여된 원시 복제 [Arg7]장을 손에 넣고, 행동력 소모 -[Arg6]을 적용합니다. 이후 3턴 동안 매 턴 시작 시 \"배아\" 1장을 \"성결의 자식\"으로 변환하며, \"배아\"가 없을 경우 <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg8]하며, 배아 융합 상승 효과의 영향을 받지 않습니다."
  },
  Skill_4314_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2,$GrowValue3,$GrowValue4,$GrowValue5"
  },
  Skill_4315_AwakerSkillBackgroundStory = {
    Text = "나를 보호해줘... 보호해줘... 보호해줘… \n겁 많은 몬스터, 그녀와 마찬가지로 생명이 있는 것 같으면서도 의식이 없는 것 같다. \n검은 점액이 그녀의 사용자가 되어, 밤낮을 가리지 않고 명령에 의해 움직인다."
  },
  Skill_4315_Desc_0 = {
    Text = "릴리가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시 최대 HP의 10%에 해당하는 <PainWord:인내>를 획득한다. 릴리가 실타래드를 부여할 때, HP가 가장 높은 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg2]스택을 부여한다."
  },
  Skill_4315_Desc_15 = {
    Text = "릴리가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시 최대 HP의 10%에 해당하는 <PainWord:인내>를 획득한다. 릴리가 실타래드를 부여할 때, HP가 가장 높은 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg2]스택을 부여한다. 광기 폭발 시 이번 턴에 공격을 1회 받을 때마다 다음 「보복의 일격」의 <PainWord:인내> 소모 효과가 40% 증가하며, 최대 5스택까지 중첩된다."
  },
  Skill_4315_EffectNameList = {
    Text = "광기, 중독"
  },
  Skill_4315_Name = {
    Text = "점액 집합"
  },
  Skill_4315_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4316_Desc = {
    Text = "<DerivativeCardKeywords_32:「끈적이는 밀랍」> 1장을 상대의 덱에 섞어 넣는다."
  },
  Skill_4316_Name = {
    Text = "밀랍 기름"
  },
  Skill_4317_Desc = {
    Text = "자폭! <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택을 부여한다."
  },
  Skill_4317_Name = {Text = "BOOM!"},
  Skill_4318_Desc = {
    Text = "전투 종료 후에도 덱에 남아 있으며, 판매 불가."
  },
  Skill_4318_Name = {
    Text = "끈적이는 밀랍"
  },
  Skill_4319_Desc = {
    Text = "전체 아군이 실타래드를 <Block:[Block:Arg1]>pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_4319_Name = {
    Text = "울부짖음"
  },
  Skill_4320_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4322_AwakerSkillBackgroundStory = {
    Text = "나방은 머리가 없어, 본능에 따라 무작정 날아다닐 뿐이다. \n그렇다면, 이 나방들보다 머리가 나은 그들에게 그들이 탐내는 것을 보여주자. \n그것은 어린 여자아이의 순수하고 천진난만한 꿈이다."
  },
  Skill_4322_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <DepleteIconKeywords:소모>가 부여된 <DerivativeCardKeywords_18:「녹염」> 1장을 손에 넣는다. <TransitionIconKeywords:워프>: 다음 턴 시작까지, 공격을 1회 받을 때마다 <DepleteIconKeywords:소모>가 부여된 <DerivativeCardKeywords_18:「녹염」> 1장을 손에 넣는다."
  },
  Skill_4322_EffectNameList_0 = {
    Text = "실타래드"
  },
  Skill_4322_Name = {
    Text = "유혹의 불꽃"
  },
  Skill_4322_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4323_AwakerSkillBackgroundStory = {
    Text = "오지에의 총기 자세는 표준적이지 않았지만, 그를 가르칠 수 있는 모든 사람들은 이미 시간과 어둠 속으로 사라졌다."
  },
  Skill_4323_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4323_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 오지에가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4323_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4323_Name = {Text = "타격"},
  Skill_4323_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4324_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_4325_AwakerSkillBackgroundStory = {
    Text = "그가 거대한 검을 들 때, 반드시 피와 죽음이 따르게 된다."
  },
  Skill_4325_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4325_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 골리아가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4325_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4325_Name = {Text = "타격"},
  Skill_4325_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4326_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4328_Desc = {
    Text = "모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1]스택 부여한다."
  },
  Skill_4328_Name = {
    Text = "독성 감염"
  },
  Skill_4329_AwakerSkillBackgroundStory = {
    Text = "그녀는 고향의 멸망을 직접 목격했음에도 불구하고, 그녀가 아는 모든 것이 융식의 포식 아래 사라져버렸음에도 불구하고, 찾는 것을 포기하고 싶지 않았다. 위치 장치가 탐색의 빛을 켜고, 그녀와 공통의 고향을 가진 사람을 찾으려 했다.\n 반드시 있을 것이다, 반드시 있을 것이다."
  },
  Skill_4329_BattleDesc_0 = {
    Text = "<Block:[Block:Arg3]>의 방어막을 획득하고, 손패의 모든 카드를 버립니다. <TransitionIconKeywords:도약>: 손패를 버리지 않고 카드를 1장 뽑으며, <Block:[Block:Arg4]>의 방어막을 획득합니다."
  },
  Skill_4329_BattleDesc_2 = {
    Text = "<Block:[Block:Arg3]>의 방어막을 획득하고, 손패의 모든 카드를 버립니다. 버린 카드 1장마다 <Block:[Block:Arg2]>의 지연 방어막를 획득합니다. <TransitionIconKeywords:도약>: 손패를 버리지 않고 카드를 2장 뽑으며, <Block:[Block:Arg4]>의 방어막을 획득합니다."
  },
  Skill_4329_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 손의 모든 카드를 버린다. 버린 카드 1장당 획득하는 실타래드가 50% 증가한다. <TransitionIconKeywords:워프>: 카드를 버리지 않고 1장을 뽑으며, 획득하는 실타래드가 100% 증가한다."
  },
  Skill_4329_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 손의 모든 카드를 버린다. 버린 카드 1장당 획득하는 실타래드가 50% 증가하고 다음 턴에 실타래드를 <Block:[Block:Arg2]>pt 획득한다. <TransitionIconKeywords:워프>: 카드를 버리지 않고 2장을 뽑으며, 획득하는 실타래드가 100% 증가한다."
  },
  Skill_4329_EffectNameList_0 = {
    Text = "실타래드"
  },
  Skill_4329_EffectNameList_2 = {
    Text = "실타래드, 지연 실타래드"
  },
  Skill_4329_Name = {
    Text = "정신 재건"
  },
  Skill_4329_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4329_PropertyNameList_2 = {
    Text = "방어력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4332_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4333_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4334_AwakerSkillBackgroundStory = {
    Text = "검은색 진흙 속에서 피어나는 꽃봉오리. 한때는 정원사의 따듯한 손길을 느꼈고, 한때는 비와 이슬의 보살핌을 받았었다.\n 하지만 지금은 홀로 고독하게 피어나, 거센 바람이 연약한 살결을 찢고 폭우가 가녀린 몸뚱이를 짓이겨도, 얇고 예리한 칼날이 피부를 가르고 길고 뾰족한 바늘이 뼛속까지 파고들어도 그저 내맡길 뿐이다.\n어차피 몸속에 깃든 그 거대한 괴물이 그녀를 대신해 모든 고통을 막아줄 테니까.\n어쩌면 그녀의 곁에 남은 것은 이제 그 거대한 괴물뿐일지도 모른다. 앞으로 그녀는, 영원히 괴물과 함께 살아갈 수밖에 없으리라……."
  },
  Skill_4334_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다."
  },
  Skill_4334_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 절반 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다."
  },
  Skill_4334_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <PainWord:인내> 스택의 [Arg2]%만큼 HP를 회복하고, <PainWord:인내>를 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다."
  },
  Skill_4334_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <PainWord:인내> 스택의 [Arg2]%만큼 HP를 회복하고, <PainWord:인내>를 절반 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다."
  },
  Skill_4334_EffectNameList_0 = {
    Text = "실타래드, 중독"
  },
  Skill_4334_Name = {
    Text = "진흙 속 불멸의 꽃"
  },
  Skill_4334_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 점 방어막를 획득합니다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고 <PainWord:인내>를 제거합니다. 공격을 1회 받을 때마다 공격자에게 [Poison:Arg4] 스택의 <IntoxicationIconKeywords:중독>을 부여하며, 1회합 동안 지속됩니다. 이번 전투에서 인내 상한이 100% 증가하고, 최대 HP와 동일한 인내를 획득합니다. 소모가 부여된 「보복의 일격」 2장을 손패에 추가합니다."
  },
  Skill_4334_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 절반 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다. 이번 전투 동안 인내 상한이 100% 증가하고, 최대 HP만큼의 인내를 획득한다. <DepleteIconKeywords:소모>가 부여된 「보복의 일격」 2장을 손에 넣는다."
  },
  Skill_4334_PropertyNameList_0 = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4334_tempBattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다."
  },
  Skill_4334_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 포인트의 방어막을 획득합니다. [Arg2]%([Arg3]) 생명을 회복하고 <PainWord:인내>의 절반을 제거합니다. 공격을 1회 받을 때마다, 공격자에게 [Poison:Arg4] 스택의 <IntoxicationIconKeywords:중독>을 1 턴 동안 부여합니다."
  },
  Skill_4334_tempBattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 절반 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다. 이번 턴에 공격을 1회 받을 때마다 다음 「보복의 일격」의 <PainWord:인내> 소모 효과가 40% 증가하며, 최대 5스택까지 중첩된다."
  },
  Skill_4334_tempOverLimitUtlSkillDesc_1 = {
    Text = "<Block:[Block:Arg1]> 점 방어막를 획득합니다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고 <PainWord:인내>를 제거합니다. 공격을 1회 받을 때마다 공격자에게 [Poison:Arg4] 스택의 <IntoxicationIconKeywords:중독>을 부여하며, 1회합 동안 지속됩니다. 이번 전투에서 인내 상한이 100% 증가하고, 최대 HP와 동일한 인내를 획득합니다. 소모가 부여된 「보복의 일격」 2장을 손패에 추가합니다."
  },
  Skill_4334_tempOverLimitUtlSkillDesc_2 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 절반 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다. 이번 전투 동안 인내 상한이 100% 증가하고, 최대 HP만큼의 인내를 획득한다. <DepleteIconKeywords:소모>가 부여된 「보복의 일격」 2장을 손에 넣는다."
  },
  Skill_4334_tempOverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득한다. <PainWord:인내> 스택의 [Arg2]%([Arg3])만큼 HP를 회복하고, <PainWord:인내>를 절반 제거한다. 공격을 1회 받을 때마다 공격자에게 <IntoxicationIconKeywords:중독> [Poison:Arg4]스택을 부여한다. 1턴 동안 지속된다. 이번 전투 동안 인내 상한이 100% 증가하고, 최대 HP만큼의 인내를 획득한다. <DepleteIconKeywords:소모>가 부여된 「보복의 일격」 2장을 손에 넣는다. 이번 턴에 공격을 1회 받을 때마다 다음 「보복의 일격」의 <PainWord:인내> 소모 효과가 40% 증가하며, 최대 5스택까지 중첩된다."
  },
  Skill_4336_Desc = {
    Text = "전체 아군에게 <ParcloseIconKeywords:장벽> [Arg1]스택을 부여한다."
  },
  Skill_4336_Name = {
    Text = "전체 보호막"
  },
  Skill_4337_AwakerSkillBackgroundStory = {
    Text = "덱스터 경은 맹세했다. 처음 딸에게 고전 검술을 가르칠 때, 그는 이 기술이 딸의 기품을 높여주길 바랐을 뿐이다 — 분명히, 라모나의 추구는 여기서 그치지 않았다."
  },
  Skill_4337_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4337_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 라모나가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4337_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4337_Name = {Text = "타격"},
  Skill_4337_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4338_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]을 획득한다. 전진."
  },
  Skill_4338_Name = {Text = "전체 힘"},
  Skill_4339_AwakerSkillBackgroundStory = {
    Text = "한 사람이 농담 반 진담 반으로 아이기스에게 스카프를 짜줄 수 있는지 물어본 적이 있다. 그녀는 스웨터 바늘부터 실타래까지 모든 것을 갖추고 있었기 때문이다.\n 아이기스는 부끄러워 고개를 숙였다. 그녀는 머리에 있는 스웨터 바늘은 장식이 아니라 자신의 눈 힘을 억제하는 특수 도구라는 것을 다른 사람에게 말하지 않았다.\n 며칠 후, 그녀는 빌린 스웨터 바늘로 다채로운 스카프를 완성했다."
  },
  Skill_4339_Desc_0 = {
    Text = "아이기스가 광기를 [Energy:Arg1]pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 아이기스가 카드를 사용한 후, 전체 적에게 [Arg2]턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4339_Desc_15 = {
    Text = "아이기스가 <Energy:[Energy:Arg1]> 포인트의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 아이기스가 카드를 사용한 후, 모든 적에게 [Arg2] 턴 <VulnerabilityIconKeywords:피해 증가>를 부여합니다. 아이기스가 광기 폭발을 발동한 후 자신의 다음 「방어」가 3회 적용되며, 추가로 광기 폭발 기본 피해가 50% 증가합니다."
  },
  Skill_4339_EffectNameList = {Text = "광기"},
  Skill_4339_Name = {
    Text = "정체의 저주"
  },
  Skill_4340_Desc = {
    Text = "<PowerIconKeywords:임시 힘>을 [Arg3]pt 획득하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. HP를 잃을 경우, 획득한 <PowerIconKeywords:임시 힘>이 사라진다."
  },
  Skill_4340_Name = {
    Text = "목을 베는 참격(허점)"
  },
  Skill_4341_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4342_AwakerSkillBackgroundStory = {
    Text = "“거리 쥐”라는 별명을 가진 아이들이 쥐를 받아들였는지, 아니면 진짜 쥐가 거리 아이들을 받아들였는지는 말하기 어렵습니다. 생계에 의해 탄생한 이 우정은 여러 해의 교류 속에서 깨지지 않을 정도로 단단해졌습니다.\n 누가 동물이 인간의 가장 좋은 친구가 아니라고 말할 수 있을까?"
  },
  Skill_4342_Desc = {
    Text = "행동력 소모가 0이고, <DepleteIconKeywords:소모>가 부여된 「브라운 출동!」 [Arg1]장을 손에 넣는다. 임시 치명타 피해가 [Arg2]% 증가한다."
  },
  Skill_4342_EffectNameList = {
    Text = "임시 치명타 피해"
  },
  Skill_4342_Name = {
    Text = "안개 도시의 악동"
  },
  Skill_4342_OverLimitUtlSkillDesc = {
    Text = "행동력 소모가 0이고, <DepleteIconKeywords:소모>가 부여된 「브라운 출동!」 [Arg1]장을 손에 넣는다. 임시 치명타 피해가 [Arg2]% 증가한다. <DepleteIconKeywords:소모>가 부여된 「슈퍼 대집결!」 1장을 손에 넣는다."
  },
  Skill_4343_AwakerSkillBackgroundStory = {
    Text = "전장에서 그는 적을 물리치며, 검으로 한 번 찍으면 이를 감당할 수 없는 자들이 패배하여 군대가 흩어진다."
  },
  Skill_4343_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4343_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 골리아가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4343_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4343_Name = {Text = "방어"},
  Skill_4343_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4344_AwakerSkillBackgroundStory = {
    Text = "노래는 그녀의 방패였다. \n그러나 이 방패는 명령과 훈계 속에 숨은 경멸과 모욕을 막지 못했다."
  },
  Skill_4344_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4344_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 2회 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TransitionIconKeywords:워프>: 광기 획득 횟수가 1회 증가한다."
  },
  Skill_4344_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 틴커트가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4344_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 2회 획득하고, 틴커트가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TransitionIconKeywords:워프>: 광기 획득 횟수가 1회 증가한다."
  },
  Skill_4344_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4344_Name = {Text = "방어"},
  Skill_4344_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4345_Desc = {
    Text = "레아는 HP를 일정량 잃을 때마다 최대 HP와 동일한 양의 실타래드를 획득한다."
  },
  Skill_4345_Name = {
    Text = "피를 갈망하는 자"
  },
  Skill_4346_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고 후퇴한다."
  },
  Skill_4347_Desc = {
    Text = "매 턴마다 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_4347_Name = {
    Text = "고대의 부름"
  },
  Skill_4348_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg3]스택을 획득한다. 턴 종료 전까지 플레이어의 손패 1장당 <ParcloseIconKeywords:장벽>이 [Arg4]스택 추가로 증가한다."
  },
  Skill_4348_Name = {Text = "시도"},
  Skill_4349_AwakerSkillBackgroundStory = {
    Text = "검은 점액이 그녀를 심연으로 끌어당깁니다. 별들이 여기서 태어나고, 빛이 여기서 죽습니다. 여기에는 시간도 생명도 없습니다.\n 한 목소리가 멀리서 다가오며 검은 빛을 발산합니다.\n 그것이 말합니다: 당신은 영원히 달라질 것입니다, 왜냐하면 당신은 요정의 통로를 방문했기 때문입니다.\n 그녀는 여기서 오랜 시간 방황할 것입니다."
  },
  Skill_4349_Desc_0 = {
    Text = "젠킨이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 치명타율이 [Arg2]% 증가하고, 젠킨이 피해를 1회 줄 때마다 임시 치명타 피해가 [Arg3]% 증가한다. 매 턴 최대 5회까지 중첩된다."
  },
  Skill_4349_Desc_15 = {
    Text = "젠킨이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 치명타율이 [Arg2]% 증가하고, 젠킨이 피해를 1회 줄 때마다 임시 치명타 피해가 [Arg3]% 증가한다. 매 턴 최대 5회까지 중첩된다. 젠킨 자신은 「공간 접기」와 「안개 도시의 거리 아이」에서 치명타 피해 효과를 2배로 획득한다."
  },
  Skill_4349_EffectNameList = {Text = "광기"},
  Skill_4349_Name = {
    Text = "공간 접기"
  },
  Skill_4350_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4351_Desc = {
    Text = "모든 적의 임시 힘을 [Arg2]pt 감소시키고, <DerivativeCardKeywords_27:증상:「발작」> 1장을 손에 넣는다. \"아파? 정말 불쌍하구나… 울어도 돼!\""
  },
  Skill_4351_Name = {Text = "절규!"},
  Skill_4352_Desc = {
    Text = "「간섭형 융식체」로 진화한다. 현재 HP가 높을수록 진화한 괴물이 더 강해진다."
  },
  Skill_4352_Name = {
    Text = "융식 진화"
  },
  Skill_4353_Desc = {
    Text = "임시 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 턴 종료 시 <PowerIconKeywords:힘>이 [Arg2]pt 감소한다."
  },
  Skill_4353_Name = {
    Text = "족쇄: 방황하는 칼날"
  },
  Skill_4354_Desc = {
    Text = "모든 아군을 흡수하고 그만큼 HP를 회복한다. [Arg1]의 <PowerIconKeywords:힘>을 획득하고, 「네 탓이야」 1개를 흡수할 때마다 추가로 [Arg2]의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4354_Name = {Text = "흡수"},
  Skill_4356_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4356_Name = {
    Text = "작은 소원"
  },
  Skill_4357_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4357_Name = {
    Text = "융식의 포옹"
  },
  Skill_4358_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4359_Desc = {
    Text = "모든 적에게 <IntoxicationIconKeywords:중독>을 [Arg1]스택 부여하고, 모든 적의 중독을 즉시 발동시킨다."
  },
  Skill_4359_Name = {
    Text = "독성 발작"
  },
  Skill_4360_AwakerSkillBackgroundStory = {
    Text = "어머, 반항하지 마~"
  },
  Skill_4360_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4360_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득한다."
  },
  Skill_4360_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 판디아가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4360_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 판디아가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득한다."
  },
  Skill_4360_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4360_EffectNameList_1 = {
    Text = "실타래드, 광기, 반격"
  },
  Skill_4360_Name = {Text = "방어"},
  Skill_4360_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4360_PropertyNameList_1 = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_4361_AwakerSkillBackgroundStory = {
    Text = "요람에 누운 소녀는, 아직 보지 못한 꽃을 꿈꾸는 걸까? \n그것은 어떤 꽃일까? 그녀 자신처럼 한 뼘 남짓한 공간에 얽매인 채, 고작 손바닥만 한 화분에서 싹을 틔우는 꽃일까? \n아니면 동생의 노래에 나오는 것처럼, 별의 바다에서 만개하여 우주의 먼지와 별의 흐름을 타고 미지의 저편으로 향하는 꽃일까?"
  },
  Skill_4361_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 행동력 소모가 0pt인 「돋아나는 새싹」 1장을 손에 넣고 <DepleteIconKeywords:소모>를 부여한다. 전체 적에게 2턴간 <WeaknessIconKeywords:허약>을 부여한다.] <RetaliateIconKeywords:반격>을 [Counterattack:Arg1]스택 획득한다. <DeathResistanceIconKeywords:죽음 저항>이 [Arg2]% 미만일 경우 [Arg3]% 증가시킨다. 자신의 <FragileIconKeywords:손상>을 해제한다."
  },
  Skill_4361_Desc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 행동력 소모가 0pt인 「돋아나는 새싹」 1장을 손에 넣고 <DepleteIconKeywords:소모>를 부여한다. 전체 적에게 2턴간 <WeaknessIconKeywords:허약>을 부여한다.] <RetaliateIconKeywords:반격>을 [Counterattack:Arg1]스택 획득한다. <DeathResistanceIconKeywords:죽음 저항>이 [Arg2]% 미만일 경우 [Arg3]% 증가시킨다. 자신의 <FragileIconKeywords:손상>을 해제한다."
  },
  Skill_4361_EffectNameList_0 = {
    Text = "반격, 죽음 저항 상한, 죽음 저항"
  },
  Skill_4361_Name = {
    Text = "별의 요람"
  },
  Skill_4361_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:포식>: 행동력 소모가 0pt인 「돋아나는 새싹」 1장을 손에 넣고 <DepleteIconKeywords:소모>를 부여한다. 전체 적에게 2턴간 <WeaknessIconKeywords:허약>을 부여한다.] <RetaliateIconKeywords:반격>을 [Counterattack:Arg1]스택 획득한다. <DeathResistanceIconKeywords:죽음 저항>이 [Arg2]% 미만일 경우 [Arg3]% 증가시킨다. 자신의 <FragileIconKeywords:손상>을 해제한다. 전체 적의 임시 <PowerColourKeywords:힘>을 [Exhaustion:Arg5]pt 감소시킨다."
  },
  Skill_4361_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4362_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여하고, 덱과 버린 카드 더미에서 무작위 카드 [Arg2]장에 「<SlowIconKeywords:둔화>」를 부여한다."
  },
  Skill_4362_Name = {
    Text = "둔화 독소"
  },
  Skill_4363_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신을 희생한다. 광란의 영향을 받지 않는다."
  },
  Skill_4363_Name = {
    Text = "헌신의 제사"
  },
  Skill_4364_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다!"
  },
  Skill_4365_AwakerSkillBackgroundStory = {
    Text = "어떤 사람들은 육체와 영혼이 영원히 하나여야 한다고 고집하며, 또 어떤 사람들은 육체를 잃으면 방황하는 정신이 파멸로 향할까 두려워한다.\n 그 의심에 대한 응답은 돌에게 귀찮은 일이었고, 그저 여러 개의 꼭두각시 몸을 교체하며 수술의 성공을 증명하기로 선택했다."
  },
  Skill_4365_Desc = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복하고, 모든 적에게 <WeaknessIconKeywords:허약>을 [Arg2]턴간 부여한다."
  },
  Skill_4365_EffectNameList = {Text = "회복"},
  Skill_4365_Name = {
    Text = "외계 수술"
  },
  Skill_4365_PropertyNameList = {
    Text = "체질*GrowValue1,"
  },
  Skill_4366_AwakerSkillBackgroundStory = {
    Text = "노래는 그녀의 무기입니다. \n이 무기는 그녀가 별빛 속에서 외롭게 방랑할 때 항상 함께 했습니다."
  },
  Skill_4366_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4366_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 2회 입힙니다. <Energy:[Energy:Arg2]> 점 광기를 획득합니다. <TransitionIconKeywords:도약>: 피해를 1회 추가로 입힙니다."
  },
  Skill_4366_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 틴커트가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4366_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 2회 입힙니다. 틴커트가 <Energy:[Energy:Arg2]> 점 광기를 획득합니다. <TransitionIconKeywords:도약>: 피해를 1회 추가로 입힙니다."
  },
  Skill_4366_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4366_Name = {Text = "타격"},
  Skill_4366_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4367_AwakerSkillBackgroundStory = {
    Text = "리즈는 자신이 녹색 불꽃을 획득한 그날의 광경을 기억하고 있다. \n청색의 화종이 손바닥에서 솟아올라 떨어지며, 오랫동안 억눌려 있던 소원을 이루도록 부추겼다."
  },
  Skill_4367_Desc = {
    Text = "무작위 적에게 <Damage:[Damage:Arg2]>의 <PunctureDamagewords:관통 피해>를 [Arg1]회 주고, 피해량의 50%만큼 <IntoxicationIconKeywords:중독>을 부여한다. 행동력이 부족할 때 강제로 사용할 수 있으며, 이 경우 효과가 <Energy:[Energy:Arg3]>의 광기를 획득하는 것으로 변경되고, <DepleteIconKeywords:소모>된다."
  },
  Skill_4367_EffectNameList = {Text = "피해"},
  Skill_4367_Name = {
    Text = "사멸의 녹색 불꽃"
  },
  Skill_4367_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4368_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4368_Name = {Text = "구타"},
  Skill_4371_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해만큼 HP를 회복하며, <DerivativeCardKeywords_34:「채워지지 않은 고통」> 1장을 덱에 넣는다."
  },
  Skill_4371_Name = {
    Text = "고통과 피"
  },
  Skill_4372_Desc = {
    Text = "양측 모두에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다. 「예리한 칼날Ⅱ」를 획득한다: 방어되지 않은 피해를 입혔을 경우, 덱의 맨 위에 <DerivativeCardKeywords_23:「상처」> 2장을 추가한다. 1턴간 지속된다."
  },
  Skill_4372_Name = {
    Text = "죽음의 투쟁"
  },
  Skill_4373_AwakerSkillBackgroundStory = {
    Text = "그녀의 앞지느러미는 항로를 가를 수 있고, 꼬리지느러미는 항구를 내리칠 만큼 강력하다. \n더 이상 싸울 상대가 없어진 후, 거대한 고래는 혼돈 속에서 잠들어 행성을 새로 태어난 생명체들에게 맡겼다."
  },
  Skill_4373_BattleDesc_0 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 제거한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해가 [Arg2] 증가한다."
  },
  Skill_4373_BattleDesc_3 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 제거한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해가 [Arg2] 증가한다. <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>가 부여된 「타격」 2장을 손에 넣는다."
  },
  Skill_4373_Desc_0 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 제거한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해가 [Arg2] 증가한다."
  },
  Skill_4373_Desc_15 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 제거한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해가 [Arg2] 증가한다. <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>가 부여된 「타격」 2장을 손에 넣는다."
  },
  Skill_4373_Desc_3 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 제거한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해가 [Arg2] 증가한다. <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>가 부여된 「타격」 2장을 손에 넣는다."
  },
  Skill_4373_EffectNameList = {
    Text = "피해, 피해"
  },
  Skill_4373_Name = {
    Text = "혼돈의 짐승"
  },
  Skill_4373_OverLimitUtlSkillDesc_0 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]> 피해를 입힙니다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해+ [Arg2]. 모든 적에게 추가로 1회 대상 최대 HP 15%의 <FixedDamage:순수 피해>를 입힙니다. 이번 전투에서 「혼돈의 짐승」의 기본 피해가 100% 증가합니다."
  },
  Skill_4373_OverLimitUtlSkillDesc_3 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 해제합니다. 모든 적에게 <Damage:[Damage:Arg1]> 피해를 [Arg3] 회 입힙니다. 이번 전투에서 「타격」을 1장 사용할 때마다 피해+ [Arg2]. <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>가 부여된 「타격」 2장을 손패에 넣습니다. 모든 적에게 추가로 1회 대상 최대 HP 15%의 <FixedDamage:순수 피해>를 입힙니다. 이번 전투에서 「혼돈의 짐승」의 기본 피해가 100% 증가합니다."
  },
  Skill_4373_PropertyNameList = {
    Text = "공격력*GrowValue1,공격력*GrowValue2"
  },
  Skill_4374_Desc = {
    Text = "작은 상처라 대수롭지 않습니다. [Arg1] 점 <FixedDamage:순수 피해>를 받고, 카드 [Arg3]장을 뽑습니다."
  },
  Skill_4374_Name = {Text = "상처"},
  Skill_4375_AwakerSkillBackgroundStory = {
    Text = "한 걸음 한 걸음, 그녀는 천천히 바닷물 속으로 발을 내딛었다.\n 피부에 닿자마자 다소 차가운 밤의 바다, 이 순간에는 인간의 포옹처럼 따뜻하게 느껴진다.\n 바다가 나를 받아주었다는 생각이 조용히 님피아의 머릿 속에 떠올랐다.\n 문득 부모님의 미소가 보였다. 그 바다의 깊은 곳에는 분명 가족의 행복이 있을 것이다."
  },
  Skill_4375_Desc_0 = {
    Text = "님피아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 님피아가 카드를 사용한 후, <Energy:[Energy:Arg2]>의 광기를 획득한다. 턴 종료 시, 님피아가 주는 중독이 [Arg3]% 증가한다."
  },
  Skill_4375_Desc_15 = {
    Text = "님피아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 님피아가 카드를 사용한 후, <Energy:[Energy:Arg2]>의 광기를 획득한다. 턴 종료 시, 님피아가 주는 중독이 [Arg4]% 증가한다."
  },
  Skill_4375_EffectNameList = {
    Text = "광기, 카드당 광기 획득, 중독 부여 증가"
  },
  Skill_4375_Name = {
    Text = "잊혀진 고난의 바다"
  },
  Skill_4376_AwakerSkillBackgroundStory = {
    Text = "다, 다가오지 마세요, 다치게 하고 싶지 않아요!"
  },
  Skill_4376_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4376_BattleDesc_1 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 대상의 <VulnerabilityIconKeywords:취약> 1스택당 <EmbryoFusionIconKeywords:배아 융합>이 [Arg3]% 증가한다(최대 [Arg4]%). 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4376_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 아이기스가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4376_Desc_1 = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 대상의 <VulnerabilityIconKeywords:취약> 1스택당 <EmbryoFusionIconKeywords:배아 융합>이 [Arg3]% 증가한다(최대 [Arg4]%). 아이기스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4376_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4376_Name = {Text = "타격"},
  Skill_4376_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4377_AwakerSkillBackgroundStory = {
    Text = "경외하지 않는 자, 예의를 지키지 않는 자, 모독하는 자는 영원한 나라에 가지 않아야 합니다."
  },
  Skill_4377_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4377_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 촉수 1개가 50%의 피해량으로 2회 공격한다."
  },
  Skill_4377_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 팔로스가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4377_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 팔로스가 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 촉수 1개가 50%의 피해량으로 2회 공격한다."
  },
  Skill_4377_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4377_Name = {Text = "타격"},
  Skill_4377_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4378_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_4378_Name = {Text = "출혈"},
  Skill_4379_AwakerSkillBackgroundStory = {
    Text = "선포하노니:\n예술의 극치를 느끼지 못하는 저속한 자들이여, 무용가의 고통에 기뻐하는 열광자들이여, 명예와 재물을 탐하는 비참한 자들이여.\n이것이 바로 너희의 말로다.\n너희에게 이 죽음을 고하는 춤을 바치노니, 녹색 불꽃이 너희의 영혼을 정화하고, 아름다운 불꽃이 너희의 불결한 마음을 씻어내리라.\n영원의 정토에서 다시 만나기를."
  },
  Skill_4379_Desc_0 = {
    Text = "<PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. 손에 있는 모든 리즈의 카드를 버리고, 그 효과를 발동한다."
  },
  Skill_4379_Desc_3 = {
    Text = "<PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. 손에 있는 모든 리즈의 카드를 버리고, 그 효과를 발동한다. 카드 2장을 버릴 때마다 카드 1장을 드로우한다."
  },
  Skill_4379_EffectNameList = {Text = "힘"},
  Skill_4379_Name = {
    Text = "죽음을 고하는 춤"
  },
  Skill_4379_OverLimitUtlSkillDesc_0 = {
    Text = "손패의 모든 「녹염」과 「부패 녹염」을 「사멸 녹염」으로 업그레이드하며, 이후 [Arg2] 회합 동안 매 회합 시작 시 이 효과를 1회 반복합니다. [Arg1] 점 임시 <PowerIconKeywords:힘>을 획득합니다. 손패의 모든 리즈 카드를 버리고 그 효과를 발동합니다."
  },
  Skill_4379_OverLimitUtlSkillDesc_3 = {
    Text = "손패의 모든 「녹염」과 「부패 녹염」을 「사멸 녹염」으로 업그레이드합니다. [Arg2]턴 동안 턴 시작 시마다 이 효과가 다시 발동됩니다. 임시 <PowerIconKeywords:힘>을 [Arg1] 획득합니다. 손패에 있는 모든 리즈의 카드를 버리고, 그 효과를 발동합니다. 카드를 2장 버릴 때마다 카드를 1장 뽑습니다."
  },
  Skill_4379_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4380_Desc = {
    Text = "사라가 [Arg1]pt의 HP를 회복한다."
  },
  Skill_4380_Name = {Text = "회복"},
  Skill_43819_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_43819_Name = {Text = "깨어남"},
  Skill_4381_AwakerSkillBackgroundStory = {
    Text = "변화의 때가 왔다.\n전승자는 인간보다 더 고귀한 존재이다.\n가족을 버리고, 친구를 버리고, 고통을 버리고, 과거의 모든 것을 버린다.\n나는 영광의 가호를 얻을 것이다.\n그의 피부 표면에는 비늘 가시가 무성하게 자생하고 있다."
  },
  Skill_4381_Desc_0 = {
    Text = "카이커스가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 카이커스가 카드를 1장 사용할 때마다 <Heal:[Heal:Arg2]>의 HP를 회복하며 <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득한다."
  },
  Skill_4381_Desc_15 = {
    Text = "카이커스가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 카이커스가 카드를 1장 사용할 때마다 <Heal:[Heal:Arg2]>의 HP를 회복하며 <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득하고, 촉수 1개가 공격하여 입힌 피해의 [Arg4]%만큼 반격을 획득한다."
  },
  Skill_4381_EffectNameList = {
    Text = "광기, 회복, 반격"
  },
  Skill_4381_Name = {
    Text = "변형하는 육체"
  },
  Skill_4381_PropertyNameList = {
    Text = "$GrowValue1, 체질*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4382_Desc = {
    Text = "깨어남체 1명을 주시한다. 주시하는 깨어남체의 카드를 사용할 시, 카드를 2장 추가로 드로우한다."
  },
  Skill_4382_Name = {
    Text = "사냥의 시선"
  },
  Skill_4383_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4383_Name = {Text = "명멸"},
  Skill_4384_AwakerSkillBackgroundStory = {
    Text = "금욕과 억압이 클수록, 소녀의 지배 능력은 더욱 놀랍다.\n 시끄러운 가죽 채찍은 달콤한 사랑의 말과 같고, 뜨거운 밀랍 방울은 뜨거운 키스를 대신하며, 팽팽한 줄은 세심한 배려를 나타내고, 붉고 부풀어 오른 상처는 사랑의 증거이다.\n 그 꿀색의 비참한 환상 속에서, 소녀의 은방울 같은 웃음소리가 울려 퍼진다."
  },
  Skill_4384_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, <RetaliateIconKeywords:반격> 1스택당 피해가 [Arg2] 증가한다. <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_4384_Desc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, <RetaliateIconKeywords:반격> 1스택당 피해가 [Arg2] 증가한다. <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득하고, <RetaliateIconKeywords:반격> [Counterattack:Arg4]스택을 획득한다."
  },
  Skill_4384_EffectNameList_0 = {
    Text = "피해, 힘"
  },
  Skill_4384_EffectNameList_3 = {
    Text = "피해, 힘, 반격"
  },
  Skill_4384_Name = {
    Text = "꿀빛 비극의 환상"
  },
  Skill_4384_OverLimitUtlSkillDesc = {
    Text = "전체 적에게 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. <Damage:[Damage:Arg1]>pt의 피해를 2회 주고, <RetaliateIconKeywords:반격> 1스택당 피해가 [Arg2]pt 증가한다. <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득하고, <RetaliateIconKeywords:반격>을 [Counterattack:Arg5]스택 획득한다."
  },
  Skill_4384_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4384_PropertyNameList_3 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4385_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4386_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4387_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4388_AwakerSkillBackgroundStory = {
    Text = "수많은 윤회 속에서, 그녀는 귀인을 자신에게 단단히 묶으며 인과의 늪으로 한 걸음씩 빠져들었다.\n\n역설이 그녀의 몸을 찢고, 혼돈이 그녀의 영혼을 채웠다. 그리고 끝없는 고통 속에서, 그녀는 「미지」가 새어낸 한 줄기 미광을 붙잡았다."
  },
  Skill_4388_Desc_0 = {
    Text = "순행·라모나가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 순행·라모나가 <TimeBeacon:회귀>를 발동하지 않은 카드를 사용한 후, <TimeBeacon2:음엔트로피> 1스택과 <Posse:[Arg2]>pt의 열쇠 에너지를 획득한다. 매 턴 최대 3회 발동된다."
  },
  Skill_4388_Desc_15 = {
    Text = "환행·라모나가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 환행·라모나가 <TimeBeacon:회환>을 발동하지 않은 카드를 사용한 후, 1중첩의 <TimeBeacon2:부엔트로피>와 <Posse:[Arg2]> 은열쇠 에너지를 획득하고, <TimeBeacon:회환>을 발동한 카드를 사용한 후, 50 은열쇠 에너지를 획득한다."
  },
  Skill_4388_EffectNameList = {Text = "광기"},
  Skill_4388_Name = {
    Text = "엔트로피 역전"
  },
  Skill_4389_AwakerSkillBackgroundStory = {
    Text = "「나는 어둠을 전혀 두려워하지 않아! 이 등은 단지 조명용일 뿐이야.」"
  },
  Skill_4389_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4389_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4389_Name = {Text = "방어"},
  Skill_4389_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4390_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신은 「밀랍 코팅」 [Arg3]스택을 획득한다. 「밀랍 코팅」: 상태 이상 면역, 치명타 피해를 입을 때마다 1스택 감소한다."
  },
  Skill_4390_Name = {
    Text = "밀랍상 등장"
  },
  Skill_4391_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 주고, [Arg2]턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_4392_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4392_Name = {Text = "강타"},
  Skill_4393_AwakerSkillBackgroundStory = {
    Text = "시가 처음 출판된 날, 정원사는 기쁨에 차서 장미 한 송이를 가져왔습니다. \n그녀는 조심스럽게 장미를 보관했습니다. 정원이 몰락의 길을 걷기 전, 그것은 이 덧없는 환몽이 빚어낸 가장 찬란한 절정이었다."
  },
  Skill_4393_BattleDesc = {
    Text = "다른 깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]>의 광기를 부여한다. <TransitionIconKeywords:워프>: 감정 상태를 「기쁨」으로 전환한다."
  },
  Skill_4393_Desc = {
    Text = "다른 깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]>의 광기를 부여한다. <TransitionIconKeywords:워프>: 감정 상태를 「기쁨」으로 전환한다. 「기쁨」 은유 1스택을 소모할 때마다 추가로 <Energy:[Energy:Arg2]>의 광기를 부여한다."
  },
  Skill_4393_EffectNameList = {Text = "광기"},
  Skill_4393_Name = {
    Text = "환몽의 시편"
  },
  Skill_4394_Desc = {
    Text = "공허 [Arg1]스택을 부여한다."
  },
  Skill_4394_Name = {
    Text = "광기 흡수"
  },
  Skill_4395_Desc = {
    Text = "전체 아군이 [Arg1]pt의 HP를 회복한다."
  },
  Skill_4395_Name = {Text = "회복"},
  Skill_4396_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4396_Name = {
    Text = "탐색 공격"
  },
  Skill_4397_AwakerSkillBackgroundStory = {
    Text = "우리는 운명의 삼상 자매 \n하늘, 대지와 바다를 달리는 메아리입니다 \n영원히 분리되지 않는 연속된 비입니다 \n긴 밤이 다가온다 길게 우리를 갈라놓을 수 있는 것은 없습니다"
  },
  Skill_4397_BattleDesc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4397_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, '24'가 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4397_EffectNameList = {Text = "피해"},
  Skill_4397_Name = {
    Text = "이종 공생"
  },
  Skill_4397_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4398_AwakerSkillBackgroundStory = {
    Text = "배팅, 배팅, 거리낌 없이 배팅.\n 정장 차림의 하인이 손짓을 하며, 상대의 카드를 보고 이마의 땀을 닦고, 머리 위의 시계 바늘이 막 0시를 지나갔다.\n 시끄럽고 붐비는 인파 속에서 수많은 세부 사항들이 그의 눈에 들어오고, 계산 없이도 올바른 결론으로 이어졌다.\n 그 궁극적인 멸망이 찾아오기 전까지 그는 패한 적이 없었다."
  },
  Skill_4398_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 무작위로 1~[Arg3]장의 카드를 드로우하고, 드로우한 카드 1장당 <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4398_EffectNameList_0 = {
    Text = "피해, 힘"
  },
  Skill_4398_Name = {Text = "올인!"},
  Skill_4398_OverLimitUtlSkillDesc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 3회 입힌다. 무작위로 1~[Arg3]장의 카드를 드로우하고, 드로우한 카드의 행동력 소모를 1 감소시키며, 드로우한 카드 1장당 <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4398_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4400_AwakerSkillBackgroundStory = {
    Text = "작품에 몰입해보세요. 창작이든 감상이든, 그것은 사람들에게 끝없는 위안을 줄 수 있습니다."
  },
  Skill_4400_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg3]>pt 획득한다."
  },
  Skill_4400_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 샨이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4400_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4400_Name = {Text = "방어"},
  Skill_4400_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4401_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 적을 삼킨다. 대상의 다음 턴 뽑기를 건너뛰고 저항할 수 없는 봉인을 부여하며, 차원 균열 카드를 손에 넣는다."
  },
  Skill_4401_Name = {
    Text = "현실타래 찢기"
  },
  Skill_4402_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, [Arg2]스택의 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_4402_Name = {Text = "경계"},
  Skill_4403_AwakerSkillBackgroundStory = {
    Text = "수많은 기어들이 서로 얽혀 서로를 움직이며 도자기 외관에 생명을 모방할 수 있는 능력을 부여합니다.\n이것은 그녀가 가장 자랑스러워하는 작품으로, 복제할 수 없는 정교한 기계입니다.\n에리카는 어떻게든 자신과 같은 이름을 가진 이 자동 인형이 자신의 두 번째 생명이 될 것이라고는 상상할 수 없었습니다."
  },
  Skill_4403_Desc_0 = {
    Text = "에리카가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 에리카가 피해를 줄 때 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득하고, 에리카가 실타래드를 부여할 때 <AlertIconKeywords:임시 경계> [Arg3]pt를 획득한다."
  },
  Skill_4403_Desc_15 = {
    Text = "에리카가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 에리카가 피해를 줄 때 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득하고, 에리카가 실타래드를 부여할 때 <AlertIconKeywords:임시 경계> [Arg3]pt를 획득한다. 에리카가 광기 폭발을 발동할 때마다 광기 폭발이 적용받는 힘과 경계 보너스가 추가로 1배 증가한다."
  },
  Skill_4403_EffectNameList = {
    Text = "광기, 힘, 경계"
  },
  Skill_4403_Name = {
    Text = "매개변수 조정"
  },
  Skill_4403_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2, 방어력*GrowValue3"
  },
  Skill_4404_AwakerSkillBackgroundStory = {
    Text = "그녀의 예의는 혼합된 것이며, 궁정에서 몇 가지를 배우고, 시장에서 자연스럽게 흡수했으며, 초기 신전에서 가르침을 받았습니다."
  },
  Skill_4404_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4404_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt와 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다."
  },
  Skill_4404_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 타이스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4404_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 타이스가 광기를 <Energy:[Energy:Arg2]>pt와 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다."
  },
  Skill_4404_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4404_EffectNameList_3 = {
    Text = "실타래드, 광기"
  },
  Skill_4404_Name = {Text = "방어"},
  Skill_4404_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4404_PropertyNameList_3 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4405_AwakerSkillBackgroundStory = {
    Text = "「나는 어둠을 전혀 두려워하지 않아! 이 등은 단지 조명용일 뿐이야.」"
  },
  Skill_4405_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 젠킨이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4405_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4405_Name = {Text = "방어"},
  Skill_4405_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4407_AwakerSkillBackgroundStory = {
    Text = "그녀의 피부는 초록색으로 변하고, 썩은 혈관이 끊임없이 왜곡되고, 감기고 있다.\n 그녀의 어깨는 마치 무언가를 잉태하고 있는 듯하며—— 검은 액체가 그녀의 팔을 따라 흐르며 수술대 위로 확산되고 있다.\n 초생의 혈육이 창문에서 피어나며, 앞다투어 부드럽고 조용하게 피어오른다.\n 허약한 소녀가 미소를 지었다.\n “드디어 다시 만났군, @2.”"
  },
  Skill_4407_Desc_0 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입힌다. 다음 턴 시작 전까지 HP를 2 잃을 때마다 다음 턴 시작 시 실타래드를 1pt 획득한다."
  },
  Skill_4407_Desc_1 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 [Arg2]회 준다. 다음 턴 시작 전까지, HP를 2 잃을 때마다 다음 턴 시작 시 실타래드를 1pt 획득한다."
  },
  Skill_4407_EffectNameList_0 = {Text = "피해"},
  Skill_4407_Name = {
    Text = "고통과 환희"
  },
  Skill_4407_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4408_AwakerSkillBackgroundStory = {
    Text = "인류가 알고 있는 스펙트럼에는 이러한 빛이 존재하지 않습니다. \n오로라처럼 화려하게 흐르고, 오로라처럼 잡을 수 없으며, 오로라처럼 순식간에 사라집니다."
  },
  Skill_4408_Desc_0 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 임시 치명타율이 [Arg2]% 증가한다. 틴커트의 「타격」 기본 피해가 이번 전투 동안 [Arg3]% 증가한다. 턴 종료 시까지 손의 카드 중 무작위 5장의 행동력 소모가 1 감소한다."
  },
  Skill_4408_Desc_3 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 임시 치명타율과 임시 치명타 피해가 [Arg2]% 증가한다. 틴커트의 「타격」 기본 피해가 이번 전투 동안 [Arg3]% 증가한다. 턴 종료 시까지 손의 카드 중 무작위 5장의 행동력 소모가 1 감소한다."
  },
  Skill_4408_EffectNameList_0 = {Text = "힘"},
  Skill_4408_Name = {
    Text = "별빛의 오로라"
  },
  Skill_4408_OverLimitUtlSkillDesc_0 = {
    Text = "[Arg1] 점 <PowerIconKeywords:힘>을 획득합니다. 임시 크리티컬 확률 +[Arg2]%. 이번 전투에서 틴커트의 「공격」 기본 데미지가 [Arg3]% 증가합니다. 무작위 손패 5장의 행동력 소모를 회합 종료까지 0으로 만듭니다."
  },
  Skill_4408_OverLimitUtlSkillDesc_3 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 임시 치명타율과 임시 치명타 피해가 [Arg2]% 증가한다. 틴커트의 「타격」 기본 피해가 이번 전투 동안 [Arg3]% 증가한다. 턴 종료 시까지 손의 카드 중 무작위 5장의 행동력 소모가 0이 된다."
  },
  Skill_4408_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4409_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4410_AwakerSkillBackgroundStory = {
    Text = "신의 나라, 유토피아, 영원한 낙원이자 팔로스의 고향이다. \n그 위대한 도시 국가는 이미 잃어버렸고, 진흙, 습지, 이끼가 자란 거대한 돌들 외에는 아무것도 남지 않았습니다."
  },
  Skill_4410_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 덱에서 최대 3장의 카드를 선택하여 손에 넣는다."
  },
  Skill_4410_EffectNameList = {
    Text = "실타래드"
  },
  Skill_4410_Name = {
    Text = "잃어버린 고대의 도시"
  },
  Skill_4410_OverLimitUtlSkillDesc = {
    Text = "손패 상한+2, 턴 종료 시 손패 1장을 선택하여 보존을 부여하고 행동력 소비 -1, 3턴 지속. <Block:[Block:Arg1]> 방어막을 획득합니다. 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제합니다. 드로우 덱에서 최대 3장의 카드를 선택하여 손패에 넣습니다."
  },
  Skill_4410_PropertyNameList = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4411_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량을 50% 감소시키는 <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4412_AwakerSkillBackgroundStory = {
    Text = "광기로 충만한 “백절불굴”의 가죽 채찍은 영원히 신선하고 아름답습니다. 물론, 언제 어디서든, 당신이 갈망하는 고통을 줄 수 있습니다."
  },
  Skill_4412_Desc_0 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 피해량의 50%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_4412_EffectNameList_0 = {Text = "피해"},
  Skill_4412_Name = {
    Text = "광기의 채찍"
  },
  Skill_4412_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4413_AwakerSkillBackgroundStory = {
    Text = "입대 후, 그녀는 전선에서 싸웠고, 비록 부상을 입어도 전장을 떠나고 싶지 않았다. 오직 그녀는 “더 나은 세상”이 곧 올 것이라고 진심으로 믿었기 때문이다.\n 하지만 거짓은 결국 파멸할 것이다. 이번에 그녀는 무기를 들었고, 더 이상 그 허황된 약속을 위해서가 아니라, 자신의 마음속에 있는 올바름을 위해 싸운다."
  },
  Skill_4413_Desc_0 = {
    Text = "엘바가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: <AlertIconKeywords:경계> [Arg2]pt를 획득한다. 엘바의 명령 카드가 주는 피해가 현재 실타래드에 비례하여 증가하며, 실타래드 1pt당 피해가 2 증가한다."
  },
  Skill_4413_Desc_15 = {
    Text = "엘바가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: <AlertIconKeywords:경계> [Arg2]pt를 획득한다. 엘바의 명령 카드가 주는 피해가 현재 실타래드에 비례하여 증가하며, 실타래드 1pt당 피해가 2 증가한다. 매 턴 처음으로 피해를 줄 때 실타래드를 <Block:[Block:Arg3]>pt 획득한다."
  },
  Skill_4413_EffectNameList = {
    Text = "광기, 경계"
  },
  Skill_4413_Name = {
    Text = "전장의 지혜"
  },
  Skill_4413_PropertyNameList = {
    Text = "$GrowValue1, 방어력*GrowValue2"
  },
  Skill_4415_Desc = {
    Text = "1턴간 <FragileIconKeywords:취약>, <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약> 상태에 면역이 된다. 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_4415_EffectNameList = {
    Text = "실타래드"
  },
  Skill_4415_Name = {Text = "축복"},
  Skill_4415_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_4416_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4417_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <PowerIconKeywords:힘>을 [Arg2] 획득한다."
  },
  Skill_4418_Desc = {
    Text = "전투 종료 후에도 덱에 남아 있다."
  },
  Skill_4418_Name = {
    Text = "끈적이는 밀랍"
  },
  Skill_4419_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4420_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4421_AwakerSkillBackgroundStory = {
    Text = "그녀는 볼록한 달 아래에서 춤추고 있다.\n치마자락이 팔에 감기며, 마치 구름처럼 끊임없이 회전하고 있다.\n그녀 아래, 끝없이 흐르는 대호는 점차 하늘과 하나로 합쳐지고 있다.\n춤춰라. 춤춰라. 어둠 속의 목소리가 말했다.\n잠든 그 어른을 깨어남시키고, 그 천 년의 약속을 실타래천하라."
  },
  Skill_4421_Desc_0 = {
    Text = "카렌이 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 카렌이 카드를 사용한 후, HP를 <Heal:[Heal:Arg2]>pt 회복하고 광기를 <Energy:[Energy:Arg3]>pt 획득한다. <DerivativeCardKeywords_42:「기묘한 요리」>를 사용한 후, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg4]스택 부여한다."
  },
  Skill_4421_Desc_15 = {
    Text = "카렌이 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 카렌이 카드를 사용한 후, HP를 <Heal:[Heal:Arg2]>pt 회복하고 광기를 <Energy:[Energy:Arg3]>pt 획득한다. 턴 종료 시 카렌의 명령 카드를 보존했을 경우에는, HP 회복과 광기 획득 효과를 2회 발동한다. <DerivativeCardKeywords_42:「기묘한 요리」>를 사용한 후, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg4]스택 부여한다."
  },
  Skill_4421_EffectNameList = {
    Text = "광기, 회복, 중독"
  },
  Skill_4421_Name = {
    Text = "차오르는 달 아래 춤"
  },
  Skill_4421_PropertyNameList = {
    Text = "$GrowValue1, 체질*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4422_AwakerSkillBackgroundStory = {
    Text = "“거리 싸움에는 별다른 규칙이 없어요. 그냥 손에 익은 걸 쓰면 돼요.”"
  },
  Skill_4422_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 젠킨이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4422_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4422_Name = {Text = "타격"},
  Skill_4422_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4423_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4424_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신을 희생한다. 광란의 영향을 받지 않는다."
  },
  Skill_4424_Name = {
    Text = "헌신의 제사"
  },
  Skill_4425_Desc = {
    Text = "사망 시, 자신과 동일한 HP를 가진 「Ⅱ형 융식체」 2개로 분열한다."
  },
  Skill_4425_Name = {Text = "분열"},
  Skill_4426_Desc = {
    Text = "어둡고, 좁고, 끊임없이 붕괴하는 공간. 출구와 괴물 모두 그곳에 있기에, 도망칠 곳이 없다."
  },
  Skill_4426_Name = {Text = "도주"},
  Skill_4427_AwakerSkillBackgroundStory = {
    Text = "물론, 빗자루이든 아니면 무기이든 그녀는 매우 우아하게 다룰 수 있습니다."
  },
  Skill_4427_BattleDesc = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4427_Desc = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 카렌이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4427_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4427_Name = {Text = "타격"},
  Skill_4427_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_44284_Desc = {
    Text = "「태동·누비아 유생」 5마리를 소환하고, 자신을 은폐하여 공격받지 않는다. 모든 적이 사망하면 은폐가 해제된다."
  },
  Skill_44284_Name = {Text = "번식"},
  Skill_44285_Desc = {
    Text = "[Arg1]턴간 <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>, <FragileIconKeywords:취약>을 부여한다. 깨어남체 2명을 봉인하고, <IntoxicationIconKeywords:중독>을 [Arg2]스택 부여하며, 덱의 카드 2장에 <AberrationKeywords:변이>를 발생시킨다."
  },
  Skill_44285_Name = {Text = "수유"},
  Skill_44286_Desc = {
    Text = "「풍요의 지모수」가 주변의 생기를 흡수하여 최대 HP가 증가하고, 모든 스킬이 강화된다!"
  },
  Skill_44286_Name = {
    Text = "다중 융합"
  },
  Skill_4428_AwakerSkillBackgroundStory = {
    Text = "이 사람은 위선적인 성녀로, 그녀의 말과 행동은 성녀의 본분을 전혀 지키지 않았다. \n하지만 그 강한 외모 아래에는 어떤 진실타래이 숨겨져 있을까, 자신의 운명을 위해 기꺼이 깃발을 드는 것도 성녀의 품성일 수 있다."
  },
  Skill_4428_BattleDesc_0 = {
    Text = "방어막 <Block:[Block:Arg6]>pt 및 행동력 [Arg3]pt를 획득한다. 다음 턴 시작 시 최대 HP의 [Arg5]%만큼 <SacrificeKeyWord:희생>을 부여한다. <RippleKeywords:여파>: <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg4] 증가한다."
  },
  Skill_4428_Desc_0 = {
    Text = "총(최대 생명 <Block:[Block:Arg1]%> + <Block:[Block:Arg2]>) 점 방패와 [Arg3] 점 컴퓨팅 파워를 획득합니다.다음 턴 시작 시 최대 생명 [Arg5]% 만큼 <SacrificeKeyWord:희생>됩니다.<RippleKeywords:여파>:<TentacleInjurieIconKeywords:촉수 피해> +[TentaclePower:Arg4]가 적용됩니다."
  },
  Skill_4428_EffectNameList = {
    Text = "실타래드, 촉수 피해"
  },
  Skill_4428_Name = {
    Text = "성녀의 탄생"
  },
  Skill_4428_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4429_AwakerSkillBackgroundStory = {
    Text = "타이스의 영겁 같은 삶 속에서 니네베는 그저 스쳐 가는 작은 정거장일 뿐이었습니다. 허나 그곳의 전당에서 선물 받은 의복은 진정 그녀가 애지중지하던 옷이었습니다."
  },
  Skill_4429_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4429_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기와 <PowerIconKeywords:힘>을 [Power:Arg3] 획득한다."
  },
  Skill_4429_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 타이스가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4429_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 타이스가 <Energy:[Energy:Arg2]>pt의 광기와 <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_4429_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4429_EffectNameList_3 = {
    Text = "피해, 광기"
  },
  Skill_4429_Name = {Text = "타격"},
  Skill_4429_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4429_PropertyNameList_3 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4430_Desc = {
    Text = "「절규」 3장을 손에 넣는다. 상대에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여하고, <PowerIconKeywords:힘>을 [Arg2]pt 획득한다."
  },
  Skill_4430_Name = {
    Text = "뜨거운 밀랍의 욕망"
  },
  Skill_4431_Desc = {
    Text = "<DerivativeCardKeywords_80:「질식」> [Arg1]장을 상대의 손에 넣는다."
  },
  Skill_4431_Name = {
    Text = "익사자의 원한"
  },
  Skill_4432_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 입히고, <PowerIconKeywords:힘>을 [Arg2]pt 획득한다."
  },
  Skill_4432_Name = {
    Text = "난폭한 물결"
  },
  Skill_4433_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 70을 획득한다."
  },
  Skill_4433_Name = {
    Text = "그림자의 메아리"
  },
  Skill_4434_AwakerSkillBackgroundStory = {
    Text = "그녀가 전투를 하는 목적은 절대로 데미지를 주는 것이 아니라 보호하는 것이다."
  },
  Skill_4434_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4434_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 엘바가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4434_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4434_Name = {Text = "방어"},
  Skill_4434_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4435_Desc = {
    Text = "<DerivativeCardKeywords_32:「끈적이는 밀랍」> 2장을 상대의 덱에 섞어 넣고, 전체가 [Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4435_Name = {
    Text = "성대한 접대"
  },
  Skill_4436_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_4436_Name = {Text = "출혈"},
  Skill_4437_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg5]>pt의 실타래드를 획득한다. 이번 턴에 카드를 1장 드로우할 때마다 실타래드가 [Arg4]pt 추가로 증가한다."
  },
  Skill_4437_Name = {
    Text = "은밀한 기습"
  },
  Skill_4438_AwakerSkillBackgroundStory = {
    Text = "명령: 방어. 막아내라."
  },
  Skill_4438_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4438_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 릴리가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 죽음 저항 1%당 릴리의 기본 실타래드 획득량이 0.25% 증가한다."
  },
  Skill_4438_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4438_Name = {Text = "방어"},
  Skill_4438_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4439_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <MadnessIconKeywords:광란> [Arg3]스택을 획득한다."
  },
  Skill_4440_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 적을 삼킨다. 대상의 다음 턴 뽑기를 건너뛰고 저항할 수 없는 봉인을 부여하며, 차원 균열 카드를 손에 넣는다."
  },
  Skill_4440_Name = {
    Text = "현실타래 찢기"
  },
  Skill_44411_Desc = {
    Text = "「태동·누비아 유생」 7마리를 소환하고, 자신을 은폐하여 공격받지 않는다. 모든 적이 사망하면 은폐가 해제된다."
  },
  Skill_44411_Name = {
    Text = "만물의 어머니"
  },
  Skill_44412_Desc = {
    Text = "[Arg1]턴간 <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>, <FragileIconKeywords:취약>을 부여한다. 모든 깨어남체를 1턴간 봉인하고, <IntoxicationIconKeywords:중독>을 [Arg2]스택 부여하며, 덱의 카드 3장에 <AberrationKeywords:변이>를 발생시킨다."
  },
  Skill_44412_Name = {
    Text = "독선 수유"
  },
  Skill_4441_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4442_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4442_Name = {Text = "구타"},
  Skill_4443_AwakerSkillBackgroundStory = {
    Text = "그녀는 한 때 정점에서 높이 떨어졌고, 과거의 영광은 오늘의 수치로 변했다.\n 집정관 부인의 뜰에서 추방된 후, 히로는 수많은 히로 노예들 중 평범한 일원이 되어 스파르타 감옥지기에게 짓밟힘을 당했다. 그런 절망적인 상황에서도 그녀는 결코 실타래망과 나태에 빠지지 않았다.\n 그녀의 가슴 속에서 타오르는 것은 오직 끊임없는 증오뿐이었다.\n 목의 가시 사슬이 무자비하게 찢어지고, 그 속박된 힘이 풀리며 진정한 모습이 드러날 준비를 하고 있다.\n 이제부터 매일 목을 깨끗이 씻고, 나의 복수를 기다리라."
  },
  Skill_4443_Desc = {
    Text = "[<DevouredIconKeywords:포식>: 이번 턴 동안 최대 손패 매수가 2장 증가하고, [Arg1] 장의 「공격」을 손패에 추가합니다. 히로의 「공격」 기본 데미지가 이번 전투 동안 [Arg3]% 증가합니다.]\n자신의 <WeaknessIconKeywords:허약>과 임시 <PowerIconKeywords:힘> 감소 상태를 제거하고, 이번 턴 동안 「공격」이 주는 최종 피해가 [Arg2]% 증가하며, 히로가 입히는 피해가 [Arg4]% 증가합니다."
  },
  Skill_4443_EffectNameList = {
    Text = "타격 피해 증가"
  },
  Skill_4443_Name = {
    Text = "절망 끝의 생존"
  },
  Skill_4443_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:포식>: 이번 턴 동안 최대 손패 매수가 2장 증가하고, [Arg1] 장의 「공격」을 손패에 추가합니다. 히로의 「공격」 기본 데미지가 이번 전투 동안 [Arg3]% 증가합니다.]\n자신의 <WeaknessIconKeywords:허약>과 임시 <PowerIconKeywords:힘> 감소 상태를 제거하고, 이번 턴 동안 「공격」이 주는 최종 피해가 [Arg2]% 증가하며, 히로가 입히는 피해가 [Arg4]% 증가합니다. 이번 턴 동안 최대 손패 매수가 2장 증가하고, 「불규칙한 형태」 2장을 손패에 추가합니다. 히로의 크리티컬 피해가 [Arg5]% 증가합니다."
  },
  Skill_4444_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 판디아의 노예 3마리를 소환한다."
  },
  Skill_4444_Name = {
    Text = "꿀빛 비극의 환상"
  },
  Skill_44452_Desc = {
    Text = "[Arg1]%([Arg2])의 HP를 회복하고 동일한 양의 실타래드를 획득한다. HP가 낮을수록 효과가 증가하며, 최대 HP의 20%까지 회복할 수 있다."
  },
  Skill_44452_Name = {
    Text = "아란의 기도"
  },
  Skill_44453_Desc = {
    Text = "「신성한 자손」 1장을 획득한다. 「신성한 자손」: 손의 비파생 명령 카드 1장을 선택하여 행동력 소모가 0인 원본 복사본을 획득하고, <DepleteIconKeywords:소모>와 <RetainIconKeywords:유지>를 부여한다."
  },
  Skill_44453_Name = {
    Text = "신성한 자손"
  },
  Skill_44454_Desc = {
    Text = "깨어남체 1명이 광기 100을 획득하고, 봉인이 해제된다."
  },
  Skill_44454_Name = {
    Text = "수액 분출"
  },
  Skill_4445_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득하고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다. 전진."
  },
  Skill_44462_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다! <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_44462_Name = {
    Text = "광란의 물어뜯기"
  },
  Skill_44463_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_44463_Name = {
    Text = "피에 굶주린 발톱"
  },
  Skill_44472_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 모든 깨어남체가 <Energy:[Energy:Arg2]>의 광기를 획득한다. 현재 HP가 낮을수록 실타래드와 광기 획득량이 증가한다."
  },
  Skill_44472_Name = {
    Text = "주교의 봉헌"
  },
  Skill_4447_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4447_Name = {
    Text = "목을 베는 참격"
  },
  Skill_44486_Desc = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 모든 깨어남체가 <Energy:[Energy:Arg2]>의 광기를 획득한다. 현재 HP가 낮을수록 실타래드와 광기 획득량이 증가한다."
  },
  Skill_44486_Name = {
    Text = "주교의 봉헌"
  },
  Skill_4448_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다!"
  },
  Skill_4448_Name = {
    Text = "두개골 강타"
  },
  Skill_4449_Desc = {
    Text = "<DerivativeCardKeywords_32:「끈적이는 밀랍」> 2장을 덱에 섞어 넣는다."
  },
  Skill_4449_Name = {
    Text = "밀랍 기름"
  },
  Skill_4450_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_23:「상처」> [Arg3]장을 덱에 섞어 넣는다."
  },
  Skill_4451_Desc = {
    Text = "광기가 가장 높은 깨어남체에게 임시 봉인 1스택을 부여하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다."
  },
  Skill_4451_Name = {Text = "봉인"},
  Skill_4452_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4452_Name = {
    Text = "불량품의 원한"
  },
  Skill_4453_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 자신은 「밀랍 갑옷」 [Arg2]스택을 획득한다. 「밀랍 갑옷」: 1스택마다 받는 피해가 [Arg3] 감소하며, 치명타 피해를 입을 때마다 1스택 감소한다."
  },
  Skill_4453_Name = {
    Text = "밀랍상 등장"
  },
  Skill_4454_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량과 동일한 <PVPBleedingKeywords:출혈>을 부여하며, 이 피해에는 3배의 <PowerIconKeywords:힘> 보너스가 적용된다."
  },
  Skill_4454_Name = {
    Text = "참수의 일격"
  },
  Skill_4455_AwakerSkillBackgroundStory = {
    Text = "그녀는 이제 그 곧게 선 제복과 새로워진 무기 아래의 진실타래을 알게 되었다.\n 이른바 도움은 단지 압박의 위장일 뿐이고, 이른바 정복은 침략의 깃발일 뿐이다.\n 그녀는 무기를 높이 들고, 빛의 별의 오각형이 정의, 공정, 가디언, 해방, 그리고 진실타래로 밝혀져 불공정의 그림자를 완전히 몰아낼 것이다."
  },
  Skill_4455_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 손에 있는 모든 상태 카드와 증상 카드를 버리고, 버린 장수만큼 카드를 뽑는다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4455_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 손에 있는 모든 상태 카드와 증상 카드를 버리고, 버린 장수보다 1장 많은 카드를 뽑는다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4455_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 손에 있는 모든 상태 카드와 증상 카드를 버리고, 버린 장수보다 1장 많은 카드를 뽑는다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 엘바의 임시 치명타율과 임시 치명타 피해가 50% 증가한다."
  },
  Skill_4455_EffectNameList = {
    Text = "실타래드"
  },
  Skill_4455_Name = {
    Text = "무한한 정의"
  },
  Skill_4455_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 점 방어막를 획득합니다. 손패의 모든 상태 카드와 증상 카드를 버리고, 버린 수만큼 카드를 뽑습니다. 모든 적에게 1회합 동안 <VulnerabilityIconKeywords:약점>을 부여합니다. 소모가 부여된 「임전 태세」와 「심안의 칼날」 1장씩을 손패에 추가합니다. 이번 전투의 크리티컬 피해 +25%."
  },
  Skill_4455_OverLimitUtlSkillDesc_2 = {
    Text = "<Block:[Block:Arg1]> 점 방어막를 획득합니다. 손패의 모든 상태 카드와 증상 카드를 버리고, 버린 수 +1만큼 카드를 뽑습니다. 모든 적에게 1회합 동안 <VulnerabilityIconKeywords:약점>을 부여합니다. 소모가 부여된 「임전 태세」와 「심안의 칼날」 1장씩을 손패에 추가합니다. 이번 전투의 크리티컬 피해 +25%."
  },
  Skill_4455_OverLimitUtlSkillDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 손에 있는 모든 상태 카드와 증상 카드를 버리고, 버린 장수보다 1장 많은 카드를 뽑는다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. <DepleteIconKeywords:소모>가 부여된 「임전 태세」와 「심안의 칼날」을 1장씩 손에 넣는다. 엘바의 임시 치명타율과 임시 치명타 피해가 50% 증가한다. 이번 전투 동안 치명타 피해가 25% 증가한다."
  },
  Skill_4455_PropertyNameList = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4456_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 기본 공격 횟수 10회, 턴 종료 전까지 플레이어의 손패 1장당 공격 횟수가 1회 감소하며, 최소 3회까지 감소한다."
  },
  Skill_4456_Name = {
    Text = "뱀들의 찢기"
  },
  Skill_44573_Desc = {
    Text = "이 카드의 카드면이 빛난다!"
  },
  Skill_44573_Name = {
    Text = "비활성화 효과"
  },
  Skill_44574_Desc = {
    Text = "이 카드의 카드면이 빛난다!"
  },
  Skill_44574_Name = {
    Text = "효과 변화"
  },
  Skill_4457_AwakerSkillBackgroundStory = {
    Text = "거센 폭풍을 두려워하지 마세요. 그녀가 여러분을 지켜줄 것입니다."
  },
  Skill_4457_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 촉수 1개가 적을 공격하여 [Arg3]%의 촉수 피해를 준다."
  },
  Skill_4457_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 셀레스트가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 촉수 1개가 적을 공격하여 [Arg3]%의 촉수 피해를 준다."
  },
  Skill_4457_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4457_Name = {Text = "방어"},
  Skill_4457_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4458_AwakerSkillBackgroundStory = {
    Text = "그는 전투에서 생긴 깊은 상처와 일상 훈련 및 연습에서 생긴 얕은 상처를 자랑스럽게 드러냈다.\n 이것들은 영웅의 증명이며, 그의 자부심이다.\n 그러나 그의 목에 있는 흉터에 대해서는 묻지 마라. 그것은 그의 힘의 시작이자, 그의 치욕의 근원이다."
  },
  Skill_4458_Desc_0 = {
    Text = "골리아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 골리아가 피해를 줄 때 <PowerIconKeywords:힘> [Power:Arg2]pt와 <TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg3]pt를 획득한다."
  },
  Skill_4458_Desc_15 = {
    Text = "골리아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 골리아가 피해를 줄 때 <PowerIconKeywords:힘> [Power:Arg2]pt와 <TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:Arg3]pt를 획득한다. 골리아는 노도 자세에서 추가로 [Arg4]%의 <PowerIconKeywords:힘> 보너스를 받는다."
  },
  Skill_4458_EffectNameList = {
    Text = "광기, 힘, 촉수 피해"
  },
  Skill_4458_Name = {
    Text = "복수 예고"
  },
  Skill_4458_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4459_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_3:「기절」> 1장을 넣는다."
  },
  Skill_4459_Name = {Text = "경련"},
  Skill_4460_AwakerSkillBackgroundStory = {
    Text = "아버지 신이 그의 꿈에 강림하여 그에게 지침을 내렸습니다.\n“하늘이 해와 달에 의해 나뉘어질 때, 혼자 숲으로 가서 동쪽으로 오백 걸음을 또 오백 걸음 나아가라. 어둠 속 따뜻한 곳에, 나의 마지막 뼈가 묻혀 있다.\n가져가라, 나의 집행자, 그러나 기억해야 한다. 혈육은 혈육으로 보상해야 하고, 생명은 생명으로 채워야 한다.”\n그는 신비로운 문자가 새겨진 석판을 파내어, 그것들에게 자신의 뼈와 피를 바치며 고통받는 이들을 위해 희망의 한 줄기를 얻으려 했다."
  },
  Skill_4460_Desc_0 = {
    Text = "모든 적에게 1턴 동안 <WeaknessIconKeywords:약화>를 부여하고, <EmbryoFusionIconKeywords:배아 융합>을 +[Arg1]% 증가시킵니다. 핏빛 용광로를 <Heal:[Heal:Arg2]>만큼 축적합니다."
  },
  Skill_4460_Desc_2 = {
    Text = "모든 적에게 1턴 동안 <WeaknessIconKeywords:약화>를 부여하고, <EmbryoFusionIconKeywords:배아 융합>을 +[Arg1]% 증가시킵니다. 핏빛 용광로를 <Heal:[Heal:Arg2]>만큼 축적하고, 이번 전투 동안 매 턴 추가로 [Arg3] 축적합니다."
  },
  Skill_4460_EffectNameList_0 = {
    Text = "배아 융합, 핏빛 용광로 축적량"
  },
  Skill_4460_EffectNameList_2 = {
    Text = "배아 융합, 핏빛 용광로 축적량, 축적량 추가"
  },
  Skill_4460_Name = {
    Text = "축복받은 뼈와 피"
  },
  Skill_4460_PropertyNameList_0 = {
    Text = "$GrowValue1, 체질*GrowValue2"
  },
  Skill_4460_PropertyNameList_2 = {
    Text = "$GrowValue1, 체질*GrowValue2, 체질*GrowValue3"
  },
  Skill_44612_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_44612_Name = {
    Text = "물어뜯기"
  },
  Skill_4461_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]을 획득한다."
  },
  Skill_4461_Name = {Text = "전체 힘"},
  Skill_4462_Desc = {
    Text = "<DerivativeCardKeywords_9:「비틀거림」> 2장을 상대의 덱과 버린 카드 더미에 각각 1장씩 섞어 넣는다."
  },
  Skill_4462_Name = {Text = "명멸"},
  Skill_4463_AwakerSkillBackgroundStory = {
    Text = "융식 현상은 모든 사람에게 평등하며, 깨어남체도 예외가 아니다. 소멸의 시간을 연장하기 위해 돌은 모든 지식, 의식, 감정을 외부 기관에 저장했다. \n“현명한 두뇌” — 돌을 위해 특별히 만든 찬사."
  },
  Skill_4463_Desc_0 = {
    Text = "돌이 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 돌이 회복을 줄 때, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4463_Desc_15 = {
    Text = "돌이 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 돌이 회복을 줄 때, 실타래드를 <Block:[Block:Arg2]>pt 획득하며, 돌의 「타격」과 「방어」도 실타래드 획득 효과를 발동할 수 있다."
  },
  Skill_4463_EffectNameList = {
    Text = "광기, 실타래드"
  },
  Skill_4463_Name = {
    Text = "영혼 분리"
  },
  Skill_4463_PropertyNameList = {
    Text = "$GrowValue1, 방어력*GrowValue2"
  },
  Skill_4464_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈>을 [Arg1]스택 부여한다."
  },
  Skill_4464_Name = {Text = "출혈"},
  Skill_4465_Desc = {
    Text = "매 턴마다 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_4465_Name = {
    Text = "고대의 부름"
  },
  Skill_4466_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_44674_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 「열상」, 「상처」, <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_44674_Name = {
    Text = "「광란의 물어뜯기」"
  },
  Skill_44675_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어가 카드를 1장 사용할 때마다 해당 의도의 추가 효과가 전환된다. 추가 효과는 강타, 회복, 약화 순서로 전환된다."
  },
  Skill_44675_Name = {
    Text = "「혼돈의 물어뜯기」"
  },
  Skill_44676_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg2]pt를 획득하고 실타래드를 [Arg1]pt 획득하며, 무작위 증상 카드 3장을 덱에 섞어 넣는다."
  },
  Skill_44676_Name = {
    Text = "「거울 속의 판결」"
  },
  Skill_44677_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_44677_Name = {
    Text = "발톱 공격"
  },
  Skill_44678_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「광분」 1장을 손에 넣는다."
  },
  Skill_44678_Name = {Text = "징벌"},
  Skill_44679_Desc = {
    Text = "[Arg1]의 실타래드와 <PowerIconKeywords:힘>을 [Arg2] 획득한다. 플레이어가 카드를 1장 사용할 때마다 해당 의도의 추가 효과가 전환된다. 추가 효과는 반격, 정화, 이식 순서로 전환된다."
  },
  Skill_44679_Name = {
    Text = "「거울 속 응시」"
  },
  Skill_4467_Desc = {
    Text = "임시 <PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_4467_Name = {Text = "삼지창"},
  Skill_44680_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 「열상」과 「상처」를 부여한다."
  },
  Skill_44680_Name = {Text = "징벌"},
  Skill_44681_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_44681_Name = {
    Text = "물어뜯기"
  },
  Skill_44682_Desc = {
    Text = "임시 힘을 [Arg1] 획득한다. 모든 적이 임시 힘을 [Arg2] 획득한다. 이 카드를 폐기한다. 전투 종료 후에도 덱에 남아 있다."
  },
  Skill_44682_Name = {Text = "광분"},
  Skill_44683_Desc = {
    Text = "발광 1스택을 획득하고, 「분방」 카드 1장을 손패 덱에 추가한다. 분방: 행동력 소비 1. 전투 종료 후에도 덱에 보존되며, 사용 시 모든 유닛이 임시 힘을 획득하고 파괴된다."
  },
  Skill_44683_Name = {
    Text = "눈에는 눈"
  },
  Skill_4468_Desc = {
    Text = "「농포」를 소환한다."
  },
  Skill_4468_Name = {
    Text = "금지된 검은 늪"
  },
  Skill_44691_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_44691_Name = {
    Text = "뒷골목 습격"
  },
  Skill_44692_Desc = {
    Text = "전열에 <ParcloseIconKeywords:장벽> 3스택을 부여하고, <PowerIconKeywords:힘>을 [Arg1] 획득한다."
  },
  Skill_44692_Name = {
    Text = "어둠 속에 숨기"
  },
  Skill_44693_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 번 입히고, “리프트”를 1 턴 동안 적용합니다. 리프트: “방어”를 사용할 때, 드로우 덱 맨 위에 <DerivativeCardKeywords_23:“상처”> 카드 1장을 추가합니다."
  },
  Skill_44693_Name = {
    Text = "비오는 밤의 학살"
  },
  Skill_44694_Desc = {
    Text = "실타래드를 [Arg1]pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_44694_Name = {
    Text = "범죄 예고"
  },
  Skill_44695_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 번 입히고, 1 턴 동안 “상처”를 적용합니다. 상처: “타격”을 사용한 후, 드로우 덱 맨 위에 1 장의 <DerivativeCardKeywords_23:“상처”>를 추가합니다."
  },
  Skill_44695_Name = {
    Text = "역습의 일격"
  },
  Skill_44696_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱에 섞어 넣는다."
  },
  Skill_44696_Name = {Text = "납치"},
  Skill_44697_Desc = {
    Text = "1턴간 <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_44697_Name = {
    Text = "먼지 날리기"
  },
  Skill_44698_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_44698_Name = {Text = "청소"},
  Skill_44699_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_44699_Name = {Text = "사기"},
  Skill_4469_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4469_Name = {
    Text = "끝없는 원한"
  },
  Skill_4470_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4470_Name = {
    Text = "브라운 출동!"
  },
  Skill_4471_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4471_Name = {
    Text = "신권의 칼날"
  },
  Skill_44722_AwakerSkillBackgroundStory = {
    Text = "아버지 신의 수많은 신언 중 하나는 아버지 신의 원초의 피가 생명을 수호하는 것을 이야기합니다."
  },
  Skill_44722_BattleDesc = {
    Text = "피를 통해 치유하리. 피해를 입힌 후, 현재 HP의 10%([Arg1])를 잃고, 잃은 HP(<Heal:[Heal:Arg2]>)만큼 핏빛 용광로 회복량을 축적한다."
  },
  Skill_44722_Desc = {
    Text = "피를 통해 치유하리. 피해를 입힌 후, 현재 HP의 10%를 잃고, 잃은 HP만큼 핏빛 용광로 회복량을 축적한다."
  },
  Skill_44722_Name = {Text = "헌신"},
  Skill_44723_AwakerSkillBackgroundStory = {
    Text = "아버지 신의 수많은 신언 중 하나는 아버지 신의 원초적인 육체가 생명을 기르는 것을 이야기합니다."
  },
  Skill_44723_BattleDesc = {
    Text = "고통으로 고통을 없애리. 모든 핏빛 용광로 축적량을 소모하여, 소모한 축적량 1당 피해량을 3 증가시킵니다. 보스 전투일 경우, 1당 피해량을 9 증가시킵니다. 최대 HP의 1%에 해당하는 핏빛 용광로를 소모할 때마다 최종 피해량이 [Arg5]% 증가합니다. 총 <Damage:[Damage:Arg4]>의 피해를 입힙니다."
  },
  Skill_44723_Desc = {
    Text = "고통으로 고통을 없애리. 모든 핏빛 용광로 축적량을 소모하여, 소모한 축적량 1당 피해량을 3 증가시킵니다. 보스 전투일 경우, 1당 피해량을 9 증가시킵니다. 최대 HP의 1%에 해당하는 핏빛 용광로를 소모할 때마다 최종 피해량이 [Arg5]% 증가합니다."
  },
  Skill_44723_EffectNameList = {
    Text = "피해, 피해 증가량"
  },
  Skill_44723_Name = {Text = "해방"},
  Skill_44723_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2%"
  },
  Skill_44723_tempBattleDesc_1 = {
    Text = "고통으로 고통을 없애리. 모든 핏빛 용광로 축적량을 소모하여, 소모한 축적량 1당 피해량을 3 증가시킵니다. 보스 전투일 경우, 1당 피해량을 9 증가시킵니다. 최대 HP의 1%에 해당하는 핏빛 용광로를 소모할 때마다 최종 피해량이 [Arg5]% 증가합니다. 총 <Damage:[Damage:Arg4]>의 피해를 입힙니다."
  },
  Skill_4472_Desc = {
    Text = "깨어남체 4명의 광기 폭발을 1턴간 봉인한다."
  },
  Skill_4472_Name = {Text = "봉인"},
  Skill_44735_Desc = {
    Text = "타비 부활 효과 테스트"
  },
  Skill_44735_Name = {
    Text = "타비 효과 테스트"
  },
  Skill_4473_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 기생 [Arg3]스택을 부여한다."
  },
  Skill_4473_Name = {Text = "뼈 침식"},
  Skill_4474_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4475_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다."
  },
  Skill_4475_Name = {Text = "독소"},
  Skill_44765_Desc = {
    Text = "[Arg1]의 실타래드와 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 자신의 부정 상태를 해제한다. 카드 사용 시, 추가 효과가 이식으로 전환된다."
  },
  Skill_44765_Name = {
    Text = "「거울 속 응시」정화"
  },
  Skill_44766_Desc = {
    Text = "[Arg1]의 실타래드와 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 임시 반격을 [Arg3] 획득한다. 카드 사용 시, 추가 효과가 정화로 전환된다."
  },
  Skill_44766_Name = {
    Text = "「거울 속 응시」반격"
  },
  Skill_44767_Desc = {
    Text = "[Arg1]의 실타래드와 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 「광분」 2장을 덱에 섞어 넣는다. 카드 사용 시, 추가 효과가 반격으로 전환된다."
  },
  Skill_44767_Name = {
    Text = "「거울 속 응시」이식"
  },
  Skill_4476_AwakerSkillBackgroundStory = {
    Text = "그들은 먼저 그녀를 성녀라고 불렀고, 돛대에 속박했습니다. 그들은 나중에 그녀를 무용지물이라고 부르며 감옥에 던져 넣었습니다. \n그들은 그녀가 생사를 결정할 수 없고 단지 배의 항로만을 가리킬 수 있다는 것을 잊은 듯합니다."
  },
  Skill_4476_Desc_0 = {
    Text = "실타래레스트가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 실타래레스트가 가하는 생명력 회복이 15% 증가하며, 생명력 회복 시 임시 <TentacleInjurieIconKeywords:촉수 피해> +[TentaclePower:Arg2]."
  },
  Skill_4476_Desc_15 = {
    Text = "실타래레스트가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 실타래레스트가 가하는 생명력 회복이 15% 증가하며, 생명력 회복 시 임시 <TentacleInjurieIconKeywords:촉수 피해> +[TentaclePower:Arg2]. 「불사의 극락조」 소생 발동 시, 임시 <TentacleInjurieIconKeywords:촉수 피해> +[TentaclePower:Arg3], 보스전 시 효과 2배."
  },
  Skill_4476_EffectNameList = {
    Text = "광기, 임시 촉수 피해"
  },
  Skill_4476_Name = {
    Text = "보호의 힘"
  },
  Skill_4476_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4477_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4477_Name = {
    Text = "이중 깨물기"
  },
  Skill_44786_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다. 카드 사용 시, 추가 효과가 강타로 전환된다."
  },
  Skill_44786_Name = {
    Text = "「혼돈의 물어뜯기」약화"
  },
  Skill_44787_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, HP를 [Arg3]pt 회복한다. 카드 사용 시, 추가 효과가 약화로 전환된다."
  },
  Skill_44787_Name = {
    Text = "「혼돈의 물어뜯기」회복"
  },
  Skill_44788_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 카드 사용 시, 추가 효과가 회복으로 전환된다."
  },
  Skill_44788_Name = {
    Text = "「혼돈의 물어뜯기」강타"
  },
  Skill_4478_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4479_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_44817_AwakerSkillBackgroundStory = {
    Text = "“나는 창조주의 대행자입니다. 나는 그의 힘을 빌려 그의 이름으로 여러분의 모든 고통을 없애겠습니다。”"
  },
  Skill_44817_Desc = {
    Text = "임시 <ParcloseIconKeywords:장벽>을 [Arg1]스택 획득하고, <EmbryoFusionIconKeywords:배아 융합>을 +[Arg2]% 증가시킵니다."
  },
  Skill_44817_Name = {
    Text = "자비의 보호"
  },
  Skill_4481_AwakerSkillBackgroundStory = {
    Text = "그들은 아름다움, 즐거움, 부드러움의 벽입니다. \n 젊은 육체가 믿을 수 없는 자세로 왜곡되어 층층이 쌓여 하늘까지 이어집니다. \n 쉿! 울지 마세요, 미소를 유지하세요. 수많은 여름밤에 당신이 여왕에게 했던 것처럼."
  },
  Skill_4481_Desc_0 = {
    Text = "완다가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 즉시 <DreamGuide:몽인> 5스택을 획득한다. 턴 시작 후 <DreamGuide:몽인> 1스택을 획득한다. <DreamGuide:몽인>을 획득하여 5스택 또는 10스택에 도달할 때마다, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4481_Desc_15 = {
    Text = "완다가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 즉시 <DreamGuide:몽인> 5스택을 획득한다. 턴 시작 후 <DreamGuide:몽인> 1스택을 획득한다. <DreamGuide:몽인>을 획득하여 5스택 또는 10스택에 도달할 때마다, 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 완다가 광기 폭발을 발동한 후 자신의 다음 2장의 명령 카드가 추가로 1회 발동한다."
  },
  Skill_4481_EffectNameList = {
    Text = "광기, 실타래드"
  },
  Skill_4481_Name = {
    Text = "불사자의 몽언"
  },
  Skill_4481_PropertyNameList = {
    Text = "$GrowValue1, 방어력*GrowValue2"
  },
  Skill_4482_Desc = {
    Text = "<DerivativeCardKeywords_32:「끈적이는 밀랍」> [Arg1]장을 덱에 섞어 넣는다."
  },
  Skill_4482_Name = {
    Text = "밀랍 기름"
  },
  Skill_4483_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4483_Name = {
    Text = "물어뜯기"
  },
  Skill_4484_Desc = {
    Text = "수호 인형을 소환한다."
  },
  Skill_4484_Name = {
    Text = "소환과 강화"
  },
  Skill_4486_Desc = {
    Text = "[Arg1]의 실타래드를 획득한다. 실타래드가 사라질 때, 남은 실타래드가 2배의 HP로 전환된다."
  },
  Skill_4486_Name = {
    Text = "불멸의 꽃"
  },
  Skill_4487_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4488_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4489_Desc = {
    Text = "모든 아군이 실타래드를 <Block:[Block:Arg1]>pt 획득하고, 자신은 <PowerIconKeywords:힘>을 [Arg2]pt 획득한다."
  },
  Skill_4490_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4491_Desc = {
    Text = "자신을 희생하여 융식의 축복을 구한다."
  },
  Skill_4491_Name = {Text = "희생"},
  Skill_4492_AwakerSkillBackgroundStory = {
    Text = "저녁 바람은 고향의 종소리를 가져오고, 별빛은 귀향의 길을 밝혀줍니다. \n지나간 의무는 그녀의 집착이 되었습니다. \n그녀는 생명을 불쏘시개로 삼아 영원한 등불을 밝히려 합니다."
  },
  Skill_4492_Desc_0 = {
    Text = "팔로스가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득한다. 팔로스의 카드를 1장 사용할 때마다 [Arg2]장의 카드를 뽑고, 전체 적의 <IntoxicationIconKeywords:중독> 효과를 [Arg3]% 발동한다. 매 턴 최대 3회 발동한다."
  },
  Skill_4492_Desc_15 = {
    Text = "파로스가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득한다. 파로스의 카드를 1장 사용할 때마다 [Arg2]장의 카드를 뽑고, 모든 적의 <IntoxicationIconKeywords:중독> 효과를 [Arg3]% 발동하며, 이번 라운드 촉수가 피해를 가할 때 피해의 5%에 해당하는 <IntoxicationIconKeywords:중독>을 추가로 부여한다. 매 라운드 최대 3회 적용."
  },
  Skill_4492_EffectNameList = {Text = "광기"},
  Skill_4492_Name = {
    Text = "가라앉은 집념"
  },
  Skill_4493_Desc = {
    Text = "기이한 정신적 체험의 일종이다."
  },
  Skill_4493_Name = {Text = "환각"},
  Skill_4494_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 모든 손패를 버린다."
  },
  Skill_4494_Name = {Text = "해체"},
  Skill_4495_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4496_BattleDesc = {
    Text = "HP를 [Arg1] 잃고, 카드를 2장 드로우한다. 판매 불가."
  },
  Skill_4496_Desc = {
    Text = "최대 HP의 10%를 잃고, 카드를 2장 드로우한다. 판매 불가."
  },
  Skill_4496_Name = {
    Text = "증상: 발작"
  },
  Skill_4497_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4498_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4499_Desc = {
    Text = "모든 깨어남체의 비용 0 「타격」을 각각 1장씩 손에 넣고, <DepleteIconKeywords:소모>를 부여한다. 턴 종료까지 손에 있는 모든 깨어남체의 카드를 비용 0의 「타격」으로 교체한다."
  },
  Skill_4499_Name = {
    Text = "아름다운 순간"
  },
  Skill_45007_AwakerSkillBackgroundStory = {
    Text = "아버지 신의 수많은 신언 중 하나는 아버지 신의 원초적인 육체가 생명을 기르는 것을 이야기합니다."
  },
  Skill_45007_BattleDesc = {
    Text = "신앙으로 세상을 구원하리. 모든 핏빛 용광로 축적량을 소모하여 소모량의 150%에 해당하는 실타래드([Arg1])를 획득한다. 이 실타래드는 실타래드 계수와 디버프의 영향을 받지 않으며, 실타래드 상한을 무시한다."
  },
  Skill_45007_Desc = {
    Text = "신앙으로 세상을 구원하리. 모든 핏빛 용광로 축적량을 소모하여 소모량의 150%에 해당하는 실타래드를 획득한다. 이 실타래드는 실타래드 계수와 디버프의 영향을 받지 않으며, 실타래드 상한을 무시한다."
  },
  Skill_45007_Name = {Text = "구원"},
  Skill_45019_Desc_1 = {
    Text = "대상 한 명에게 <DisarmKeywords:마비>를 부여한다."
  },
  Skill_45019_Name_1 = {Text = "마비"},
  Skill_4501_AwakerSkillBackgroundStory = {
    Text = "파손되기 쉬운 외부 장기를 보호하기 위해, 돌은 유리관 내부에 「역장 발생기」를 내장했다. 그녀가 무표정한 얼굴로 학생들에게 설명하는 바람에, 다들 돌 교수가 또 농담을 하는 건지 분간하지 못했다. 실타래로 끔찍한 유머 감각이 아닐 수 없다."
  },
  Skill_4501_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4501_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 돌이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4501_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4501_Name = {Text = "방어"},
  Skill_4501_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4502_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_4502_Name = {
    Text = "석질 분해"
  },
  Skill_4504_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45051_Desc_1 = {
    Text = "대상 한 명에게 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_45051_Name_1 = {Text = "장벽"},
  Skill_4505_Desc = {
    Text = "[Arg1]의 <PowerIconKeywords:힘>을 획득하고, <DerivativeCardKeywords_35:「거인의 공포」> 3장을 덱에 섞어 넣는다."
  },
  Skill_4505_Name = {
    Text = "해연의 힘"
  },
  Skill_45063_Desc_1 = {
    Text = "전체 적에게 부정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여한다."
  },
  Skill_45063_Name_1 = {
    Text = "화려한 풍경"
  },
  Skill_4506_AwakerSkillBackgroundStory = {
    Text = "그것은 무한한 원질의 바다로, 전설에 따르면 행성의 모든 유기물이 여기서 탄생했다고 한다. \n회색의 바다 위에는 무한한 얼굴들이 부유하고 있으며, 웃음 또는 슬픔을 담고 있다."
  },
  Skill_4506_Desc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 피해를 입히며, 해당 피해는 [Arg4]배의 힘 보너스를 받습니다. 커스텀 「천면환상」 1장을 생성하여 손패에 넣습니다. 현재 초차원 턴이 아니고 <DimensionalSpaceIconKeywords:초차원 공간>에 「천면환상」이 없을 경우, 이를 복사하여 <DimensionalSpaceIconKeywords:초차원 공간>에 넣고 <SingularityKeywords3:차원 이동>을 1회 발동한 것으로 간주합니다. 그렇지 않으면 <DerivativeCardKeywords_4:「영감」> 1장을 손패에 넣습니다."
  },
  Skill_4506_EffectNameList = {Text = "피해"},
  Skill_4506_Name = {
    Text = "원질의 바다"
  },
  Skill_4506_OverLimitUtlSkillDesc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 피해를 입히며, 해당 피해는 [Arg4]배의 힘 보너스를 받습니다. 커스텀 「천면환상」 1장을 생성하여 손패에 넣습니다. 현재 초차원 턴이 아니고 <DimensionalSpaceIconKeywords:초차원 공간>에 「천면환상」이 없을 경우, 이를 복사하여 <DimensionalSpaceIconKeywords:초차원 공간>에 넣고 <SingularityKeywords3:차원 이동>을 1회 발동한 것으로 간주합니다. 그렇지 않으면 <DerivativeCardKeywords_4:「영감」> 1장을 손패에 넣습니다. 추가로 「천면환상」의 복사본 [Arg2]장을 손패에 넣으며, 「목을 베는 일격」의 이번 전투 기본 피해가 [Arg3]% 증가합니다."
  },
  Skill_4506_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_45079_Desc_1 = {
    Text = "대상 한 명에게 <PVPSeriousInjuryKeywords:중상>을 부여한다."
  },
  Skill_45079_Name_1 = {Text = "중상"},
  Skill_4507_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4507_Name = {
    Text = "물어뜯기"
  },
  Skill_4508_Desc = {
    Text = "턴 시작 시 덱에 있는 무작위 명령 카드 1장의 복사본으로 변신하며, 해당 카드의 비용은 3으로 잠금된다. 턴 종료 시 원래대로 돌아온다. 사용 불가."
  },
  Skill_4508_Name = {
    Text = "증상: 섬망"
  },
  Skill_4509_AwakerSkillBackgroundStory = {
    Text = "태초의 혼돈을 제외하고는, 그 무엇도 바닷물과 불꽃을 하나로 뒤섞을 수 없다. 얼마든지 가서 찾아보고 증명해 보아라. 사막의 첨탑을 쫓고, 심해의 미궁을 탐색하고, 끝없이 펼쳐진 산맥을 넘어보아라. 장담컨대, '로탄'보다 더 오래된 존재는 없다."
  },
  Skill_4509_BattleDesc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg2] 획득한다."
  },
  Skill_4509_BattleDesc_2 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg2] 획득한다. 「타격」으로 간주한다."
  },
  Skill_4509_Desc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4509_Desc_2 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다. 「타격」으로 간주한다."
  },
  Skill_4509_EffectNameList = {
    Text = "피해, 힘"
  },
  Skill_4509_Name = {
    Text = "난폭한 물결"
  },
  Skill_4509_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4510_Desc = {
    Text = "뽑았을 때, 이번 턴 동안 모든 깨어남체의 광기 획득량이 50% 감소한다."
  },
  Skill_4510_Name = {Text = "허무"},
  Skill_4511_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4512_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt와 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시, 보유한 스택만큼 HP를 회복하며, HP 5pt를 잃을 때마다 1스택 감소한다."
  },
  Skill_4512_Name = {Text = "심잠"},
  Skill_4514_Desc = {
    Text = "적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4514_Name = {
    Text = "깊은 구덩이"
  },
  Skill_4515_AwakerSkillBackgroundStory = {
    Text = "단 한 번의 일격. \n 유린하는 자의 숨통을 끊고, 배신자의 숨통을 끊으며, 오만한 자의 숨통을 끊고, 침략자의 숨통을 끊어내리라.\n긴말은 필요치 않다. 칠흑 같은 증오를 품은 이 비수로, 그녀의 선택과 각오를 선언할 뿐이다."
  },
  Skill_4515_BattleDesc = {
    Text = "「타격」으로 간주한다. <Damage:[Damage:Arg1]>pt의 피해를 입히고, 손에 있는 다른 「타격」 1장당 기본 피해가 [Arg3]% 증가하며, 힘 보너스를 1배 추가로 적용받는다. 사용 후 손의 모든 「타격」을 버린다."
  },
  Skill_4515_Desc = {
    Text = "「타격」으로 간주한다. <Damage:[Damage:Arg1]>pt의 피해를 입히고, 손에 있는 다른 「타격」 1장당 기본 피해가 [Arg3]% 증가하며, 힘 보너스를 1배 추가로 적용받는다. 사용 후 손의 모든 「타격」을 버린다."
  },
  Skill_4515_EffectNameList = {Text = "피해"},
  Skill_4515_Name = {
    Text = "사슬을 끊는 일격"
  },
  Skill_4515_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4516_AwakerSkillBackgroundStory = {
    Text = "“수치… 수치…”\n여자아이는 주방 구석에 움츠리고, 아직 입가의 핏자국을 닦을 시간도 없었다.\n그녀는 가까운 사람의 비난을 견디고 있었지만, 변명할 힘이 없었다.\n그날 이후, 여자아이는 자신의 이름을 잃어버렸다.\n그녀는 세상 사람들 앞에서 사라졌고, 마치 한 방울의 물이 끊임없이 쏟아지는 소문이라는 강에 흡수되듯이."
  },
  Skill_4516_Desc_0 = {
    Text = "레아가 <Energy:[Energy:Arg1]> 포인트의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 레아가 카드를 사용한 후, <EmbryoFusionIconKeywords:배아융합> +[Blood:Arg2]."
  },
  Skill_4516_Desc_15 = {
    Text = "레아가 <Energy:[Energy:Arg1]> 포인트의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 레아가 카드를 사용한 후, <EmbryoFusionIconKeywords:배아융합> +[Blood:Arg2], 그리고 다음 광기 폭발 강화: 영구 힘의 [Arg3]%에 해당하는 임시 힘을 획득하며, 최대 [Arg4]회 중첩 가능합니다."
  },
  Skill_4516_EffectNameList = {
    Text = "광기, 배아 융합"
  },
  Skill_4516_Name = {
    Text = "피의 갈망"
  },
  Skill_4517_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_4517_Name = {
    Text = "사냥창 찌르기"
  },
  Skill_4518_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4518_Name = {
    Text = "상처 찢기"
  },
  Skill_4519_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체를 1턴간 봉인한다."
  },
  Skill_4519_Name = {
    Text = "「▼▼ 강림을 위해 ▼▼ 정화」"
  },
  Skill_4520_Desc = {
    Text = "기도 [Arg1]스택을 획득한다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택 감소하고, 턴 종료 시 모두 사라진다."
  },
  Skill_4520_Name = {Text = "기도"},
  Skill_4521_Desc = {
    Text = "[Arg1]의 <PowerIconKeywords:힘>을 획득하고, 손의 모든 카드에게 「<SlowIconKeywords:둔화>」와 「<RetainKeywords:유지>」를 부여하며, 상대의 손에 「점점 석화」 1장을 넣는다."
  },
  Skill_4521_Name = {
    Text = "진·영겁의 눈"
  },
  Skill_4522_Desc = {
    Text = "실타래드를 [Arg2]pt 및 재생력 [Arg1]스택을 획득한다. 재생력: 턴 종료 시, 보유한 스택만큼 HP를 회복하며, HP 5pt를 잃을 때마다 1스택 감소한다."
  },
  Skill_4522_Name = {
    Text = "이단의 혈통"
  },
  Skill_4523_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4524_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45251_Desc_1 = {
    Text = "전체 아군의 HP를 지난 턴 시작 시점으로 되돌리되, 회복 후 HP는 최대 [Arg1]%를 초과할 수 없으며, <ReduceEffectKeywords:증폭 감소> [Arg2], 광기는 절반으로 줄어듭니다. <PVPRaidKeywords:습격>: 회복 후 HP는 최대 [Arg3]%를 초과할 수 없습니다."
  },
  Skill_45251_Name_1 = {
    Text = "회귀의 문을 넘어"
  },
  Skill_45251_UnknownName = {
    Text = "회귀의 문을 넘어"
  },
  Skill_45252_Desc_1 = {
    Text = "[Arg1]장의 다른 무작위 「키오더」를 덱에 섞습니다. 손패로 뽑기 전까지 무엇인지 알 수 없습니다."
  },
  Skill_45252_Name_1 = {
    Text = "오레타의 보물"
  },
  Skill_45252_UnknownName = {
    Text = "오레타의 보물"
  },
  Skill_45253_Desc_1 = {
    Text = "적 1명에게 <PVPEmptinessKeywords:공허>를 부여하고, 대상의 [Arg1] 광기를 동량의 <DelayKeywords:지연>으로 전환합니다: <DelayKeywords:지연>: 광기."
  },
  Skill_45253_Name_1 = {
    Text = "바다의 제사"
  },
  Skill_45253_UnknownName = {
    Text = "바다의 제사"
  },
  Skill_45254_Name_1 = {
    Text = "봄의 헌시"
  },
  Skill_45254_UnknownName = {
    Text = "봄의 헌시"
  },
  Skill_45255_Desc_1 = {
    Text = "모든 적에게 총 <Damage:[Damage:Arg1]>의 피해를 균등하게 분배하여 준다."
  },
  Skill_45255_Name_1 = {
    Text = "그녀의 전부"
  },
  Skill_45255_UnknownName = {
    Text = "그녀의 전부"
  },
  Skill_45256_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 이번 턴의 다음 「타격」을 랜덤 대상으로 변경하고, 추가로 랜덤한 대상 [Arg1]명을 공격하게 한다."
  },
  Skill_45256_Name_1 = {
    Text = "거울 속의 사람"
  },
  Skill_45257_Desc_1 = {
    Text = "아군 한 명을 <ReinforceKeywords:보강>하고, 카드 [Arg1]장을 드로우한다."
  },
  Skill_45257_Name_1 = {
    Text = "마지막 맹세"
  },
  Skill_45257_UnknownName = {
    Text = "마지막 서약"
  },
  Skill_45258_BattleDesc_1 = {
    Text = "모든 행동력을 소진하며, 소모한 행동력 1포인트마다 및 보유한 <PVPCapKeywords:최대 산출력> 1포인트마다 [Arg1] <PVPBleedingKeywords:출혈>을 부여하고, 총 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:출혈> 데미지를 입힙니다."
  },
  Skill_45258_Desc_1 = {
    Text = "모든 행동력을 소진하며, 소모한 행동력 1포인트마다 및 보유한 <PVPCapKeywords:최대 산출력> 1포인트마다 [Arg1] <PVPBleedingKeywords:출혈>을 부여합니다."
  },
  Skill_45258_Name_1 = {
    Text = "포효하는 피와 모래"
  },
  Skill_45258_UnknownName = {
    Text = "포효하는 피와 모래"
  },
  Skill_45259_Desc_1 = {
    Text = "아군 한 명을 선택하여 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 획득하고, <PVPPowerIconKeywords:힘> +[Arg2]을 부여한다."
  },
  Skill_45259_Name_1 = {
    Text = "장미의 승리"
  },
  Skill_45259_UnknownName = {
    Text = "장미의 승리"
  },
  Skill_4525_AwakerSkillBackgroundStory = {
    Text = "찰싹! 찰싹! 찰싹! 버릇없는 노예들은 이 작은 채찍으로 때려주자~"
  },
  Skill_4525_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4525_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 피해량의 50%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다. <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4525_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 판디아가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4525_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 피해량의 50%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다. 판디아가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4525_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4525_Name = {Text = "타격"},
  Skill_4525_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_45260_Desc_1 = {
    Text = "아군 한 명을 선택하여 <Block:[Block:Arg1]> 보호막을 부여하고, 해당 대상의 현재 생명력과 보호막을 다른 아군에게 분배합니다. 대상이 유일한 생존 아군일 경우 대신 <StrengthenKeywords:강화>와 <ReinforceKeywords:가고>를 획득합니다."
  },
  Skill_45260_Name_1 = {
    Text = "부패한 향연"
  },
  Skill_45260_UnknownName = {
    Text = "부패의 연회"
  },
  Skill_45261_Desc_1 = {
    Text = "대상에게 모든 손패를 버리게 한다. 만약 버린 손패가 없을 경우, [Arg2]의 행동력을 획득하고 [Arg2]장의 카드를 드로우한다."
  },
  Skill_45261_Name_1 = {
    Text = "거인의 패도"
  },
  Skill_45261_UnknownName = {
    Text = "거인의 패도"
  },
  Skill_45262_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <TauntKeywords:도발>과 <Block:[Block:Arg1]>의 실타래드를 획득한다."
  },
  Skill_45262_Name_1 = {
    Text = "35mm의 마법"
  },
  Skill_45263_Desc_1 = {
    Text = "[Arg1] 장의 카드를 뽑습니다."
  },
  Skill_45263_Name_1 = {
    Text = "한여름의 꿈"
  },
  Skill_45263_UnknownName = {
    Text = "한여름의 꿈"
  },
  Skill_45264_Desc_1 = {
    Text = "<DelayKeywords:지연>: <StrengthenKeywords:강화>와 <ReinforceKeywords:요새화> 자신을 하고 [Arg1] 층 <EnergyStorageKeywords:차지>을 획득합니다."
  },
  Skill_45264_Name_1 = {
    Text = "기적의 강림"
  },
  Skill_45264_UnknownName = {
    Text = "기적의 강림"
  },
  Skill_45265_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 대상을 선택할 수 있으며, 「타격」 전에 대상의 해제 가능한 모든 긍정 상태를 그 뒤의 깨어남체에게 <PVPRepelKeywords:밀쳐내기>한다."
  },
  Skill_45265_Name_1 = {
    Text = "심해의 부름"
  },
  Skill_45266_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 「타격」 후, 손에 있는 장착한 깨어남체의 비파생 「스킬」이 순서대로 장착한 깨어남체의 다른 「스킬」로 변화한다. <PVPFlowerKeywords:지난날의 꽃과 시>"
  },
  Skill_45266_Name_1 = {
    Text = "지난날의 꽃과 시"
  },
  Skill_45267_Desc_1 = {
    Text = "손패의 모든 「스킬」에 <PrepareKeywords:예비>를 부여하고, 기본 산출력 소모가 [Arg2]인 「스킬」에 <PrepareKeywords:예비> [Arg3]를 부여한다."
  },
  Skill_45267_Name_1 = {
    Text = "흑고니의 춤사위"
  },
  Skill_45267_UnknownName = {
    Text = "흑고니의 춤사위"
  },
  Skill_45268_Desc_1 = {
    Text = "임의의 대상에게 랜덤한 「명륜」을 장착한다. 사용 횟수가 소진되지 않았다면 이 카드를 상대의 덱에 섞어 넣는다."
  },
  Skill_45268_Name_1 = {
    Text = "한 발의 총성"
  },
  Skill_45268_UnknownName = {
    Text = "한 발의 총성"
  },
  Skill_45269_Desc_1 = {
    Text = "<PVPCapKeywords:최대 산출력> +[Arg1]."
  },
  Skill_45269_Name_1 = {
    Text = "뼈를 침식하는 포옹"
  },
  Skill_45269_UnknownName = {
    Text = "뼈를 침식하는 포옹"
  },
  Skill_4526_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_45270_Desc_1 = {
    Text = "<PVPHoldingKeywords:보유>: 턴 종료 시, 마지막으로 사용한 「스킬」 카드 1장으로 변화하여 그 스킬의 행동력 소모를 2 감소시키며, 사용 후 「안개 드리운 진실타래」 1장을 덱에 섞어 넣는다."
  },
  Skill_45270_Name_1 = {
    Text = "안개 드리운 진실타래"
  },
  Skill_45270_UnknownName = {
    Text = "안개 드리운 진실타래"
  },
  Skill_45271_Desc_1 = {
    Text = "[Arg1]의 피해를 주고, <DisarmKeywords:마비>와 <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_45271_Name_1 = {
    Text = "순간의 영원"
  },
  Skill_45271_UnknownName = {
    Text = "순간의 영원"
  },
  Skill_45272_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPEntanglementKeywords:엉킴>과 <PVPPenetrateKeywords:관통>을 부여한다."
  },
  Skill_45272_Name_1 = {
    Text = "호숫가의 회상"
  },
  Skill_45272_UnknownName = {
    Text = "호숫가의 회상"
  },
  Skill_45273_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 능동 피해를 받을 때마다 다른 아군이 <Energy:[Energy:Arg1]> 광기를 획득합니다."
  },
  Skill_45273_Name_1 = {
    Text = "이사라우의 시선"
  },
  Skill_45275_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 손패 상한이 [Arg1] 증가한다. 「광기 폭발」 후 자신이 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45275_Name_1 = {
    Text = "찬란한 이별의 키스"
  },
  Skill_4527_Desc = {
    Text = "<MadnessIconKeywords:광란> 1스택을 획득한다. 증상 카드를 사용할 때마다 판디아의 상태가 「불안」과 「방종」 사이에서 변화한다. 「불안」: 공격 횟수 +1, <PowerIconKeywords:힘> 감소. 「방종」: 공격 횟수 -1, <PowerIconKeywords:힘> 증가."
  },
  Skill_4527_Name = {Text = "깨어남"},
  Skill_4528_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 뒤틀린 시체 광연의 피해를 <Damage:[Damage:Arg3]> 증가시킨다."
  },
  Skill_4528_Name = {Text = "난도질"},
  Skill_4529_AwakerSkillBackgroundStory = {
    Text = "고난은 잔인하고, 무정하다. \n\n모든 것이 소멸하는 검은 죽음 앞에서, 생명을 다 바친다 해도 그는 세상의 모든 것을 지키려 할 것이다."
  },
  Skill_4529_Desc_0 = {
    Text = "<B02AFKeyWord2:헌신>, <B02AFKeyWord3:해방> 또는 <B02AFKeyWord4:구원> 중 하나를 선택하고, <Energy:[Energy:Arg5]>pt의 광기를 획득한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히며, 이번 전투에서 핏빛 용광로 회복량이 1만큼 누적될 때마다 피해가 [Float:Arg2] 증가한다."
  },
  Skill_4529_Desc_2 = {
    Text = "<B02AFKeyWord2:헌신>, <B02AFKeyWord3:해방> 또는 <B02AFKeyWord4:구원> 중 하나를 선택하고, <Energy:[Energy:Arg5]>pt의 광기를 획득한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히며, 이번 전투에서 핏빛 용광로 회복량이 1만큼 누적될 때마다 피해가 [Float:Arg2] 증가한다. 이번 피해의 치명타율이 [Arg4]% 증가한다."
  },
  Skill_4529_EffectNameList = {
    Text = "피해, 피해 증가량, 광기"
  },
  Skill_4529_Name = {
    Text = "고통의 해소"
  },
  Skill_4529_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4530_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4530_Name = {Text = "찌르기"},
  Skill_4531_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 맨 위의 카드 [Arg3]장에게 「<SlowIconKeywords:둔화>」와 「<RetainKeywords:유지>」를 부여한다."
  },
  Skill_4531_Name = {
    Text = "정체의 저주"
  },
  Skill_4532_Desc = {
    Text = "「강신 의식」을 완료하여, 자신의 HP와 최대 HP가 2배로 증가한다. <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>, <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하고, 「집착」 3장을 덱에 넣는다."
  },
  Skill_4532_Name = {
    Text = "강신 의식·강림"
  },
  Skill_4533_AwakerSkillBackgroundStory = {
    Text = "젠킨도 처음에는 브라운을 이해할 수 없었다.\n 이렇게는 안 되겠다고 그녀는 생각했다. 이렇게 하면 브라운이 거리의 자부심 강한 신사들의 주목을 끌 수 없으니, 그녀가 그들의 주머니에서 오늘 저녁을 가져올 수 없을 것이다.\n 그래서 그녀는 등불을 들고 훈련을 시작했고, 여러 날의 시도 끝에 드디어...\n “브라운, 출동!”\n “지!”"
  },
  Skill_4533_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 전투 동안, 「브라운 출동!」이 주는 피해가 [Arg2] 증가한다. <TransitionIconKeywords:워프>: 이 스킬에 힘이 1배 추가로 적용된다."
  },
  Skill_4533_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 전투 동안, 「브라운 출동!」이 주는 피해가 [Arg2] 증가하고, 「쥐 떼 돌격」이 주는 피해가 [Arg3] 증가한다. <TransitionIconKeywords:워프>: 이 스킬에 힘이 1배 추가로 적용된다."
  },
  Skill_4533_EffectNameList_0 = {
    Text = "피해, 피해 성장"
  },
  Skill_4533_EffectNameList_1 = {
    Text = "피해, 피해 증가, 쥐 떼 돌격 피해 증가"
  },
  Skill_4533_Name = {
    Text = "브라운 출동!"
  },
  Skill_4533_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4533_PropertyNameList_1 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4534_Desc = {
    Text = "수호 인형을 소환하며, 자신은 [Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4534_Name = {
    Text = "소환과 강화"
  },
  Skill_4535_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_45367_Desc_1 = {
    Text = "<DelayKeywords:지연>: 한 명의 아군에게 [Arg1] 장의 「타격」을 부여합니다."
  },
  Skill_45367_Name_1 = {
    Text = "불멸의 장례식"
  },
  Skill_45367_UnknownName = {
    Text = "불멸의 장례식"
  },
  Skill_4536_Desc = {
    Text = "더 이상 차원 횡단으로 탈출할 수 없다!…… 그래도 이 카드를 소모할 수는 있지만, 아무 의미가 없다."
  },
  Skill_4536_Name = {
    Text = "보고 있어...!"
  },
  Skill_4537_Desc = {
    Text = "손패의 모든 증상 카드를 소모한다. 1장 소모할 때마다 카드를 1장 드로우한다. 앞으로 1번만 더 사용할 수 있다."
  },
  Skill_4537_Name = {
    Text = "차원 횡단"
  },
  Skill_45383_Desc_1 = {
    Text = "대상 한 명에게 임시 <PowerColourKeywords:힘 감소> [Arg1]을 부여한다."
  },
  Skill_45383_Name_1 = {
    Text = "임시 힘 감소"
  },
  Skill_45384_Desc_1 = {
    Text = "대상 한 명에게 임시 <PowerColourKeywords:힘> [Arg1]을 부여한다."
  },
  Skill_45384_Name_1 = {Text = "임시 힘"},
  Skill_4538_Desc = {
    Text = "손패의 모든 증상 카드를 소모한다. 1장 소모할 때마다 카드를 1장 드로우한다. 앞으로 2번 더 사용할 수 있다."
  },
  Skill_4538_Name = {
    Text = "차원 횡단"
  },
  Skill_4539_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Flaw:허점>을 획득한다. 허점: 이번 턴 동안 반드시 치명타 피해를 받는다."
  },
  Skill_4539_Name = {
    Text = "쥐 떼 돌격"
  },
  Skill_4540_Desc = {
    Text = "기도 [Arg1]스택을 획득한다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택 감소하고, 모두 소진 시 기절한다."
  },
  Skill_4540_Name = {Text = "기도"},
  Skill_4541_AwakerSkillBackgroundStory = {
    Text = "자정 무렵, 고요한 물줄기는 병약한 소녀의 안내에 따라 부드럽게 감싸며 흐른다."
  },
  Skill_4541_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4541_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 님피아가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4541_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4541_Name = {Text = "타격"},
  Skill_4541_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4542_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고 후퇴한다."
  },
  Skill_4543_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4544_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45453_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 주고, 목표가 손패를 1장 가질 때마다 추가로 1회 피해를 입힌다. 피해의 절반만큼 방어막을 얻는다.<PVPPenetrateKeywords:관통>."
  },
  Skill_45453_Name_1 = {
    Text = "산호 나선"
  },
  Skill_45454_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복하고, 그에게 <Energy:[Energy:Arg2]>의 광기를 부여하며, 자신에게 사용 시 효과가 절반으로 감소한다."
  },
  Skill_45454_Name_1 = {
    Text = "풍요의 의식"
  },
  Skill_45455_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:약점> 목표를 공격하여 <Damage:[Damage:Arg1]> 데미지를 주고, <PVPPenetrateKeywords:관통>합니다."
  },
  Skill_45455_Name_1 = {
    Text = "무형의 이동"
  },
  Skill_45456_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, 피해량만큼 HP를 회복한다. <PVPSeriousInjuryKeywords:중상> 상태인 대상에게 사용 시 회복량이 2배가 된다."
  },
  Skill_45456_Name_1 = {
    Text = "선체 재구성"
  },
  Skill_45457_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <PVPMethysisKeywords:중독>을 2배로 만든다."
  },
  Skill_45457_Name_1 = {
    Text = "자아의 장례식"
  },
  Skill_45458_Desc_1 = {
    Text = "임의의 다른 대상에게 <PVPVulnerabilityIconKeywords:취약>을 부여하고, <DelayKeywords:지연>: <Energy:[Energy:Arg1]> 광기를 획득합니다."
  },
  Skill_45458_Name_1 = {
    Text = "고통을 즐김"
  },
  Skill_45459_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45459_Name_1 = {Text = "타격"},
  Skill_4545_AwakerSkillBackgroundStory = {
    Text = "「나는 어둠을 전혀 두려워하지 않아! 이 등은 단지 조명용일 뿐이야.」"
  },
  Skill_4545_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4545_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 카드를 2장 뽑고, 뽑은 카드가 젠킨의 카드가 아니라면 버린다."
  },
  Skill_4545_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 젠킨이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4545_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 젠킨이 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 카드를 2장 뽑고, 뽑은 카드가 젠킨의 카드가 아니라면 버린다."
  },
  Skill_4545_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4545_Name = {Text = "방어"},
  Skill_4545_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_45460_Desc_1 = {
    Text = "임의의 다른 대상에게 <Damage:[Damage:Arg1]>의 피해를 주고, 그 대상이 <Energy:[Energy:Arg2]>의 광기를 획득하게 한다."
  },
  Skill_45460_Name_1 = {
    Text = "지고의 희열"
  },
  Skill_45461_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, [Arg2] 층 <EnergyStorageKeywords:충전>을 획득한다."
  },
  Skill_45461_Name_1 = {Text = "원망"},
  Skill_45462_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입힌다. [Arg2] 층 <EnergyStorageKeywords:충전>을 획득한다."
  },
  Skill_45462_Name_1 = {
    Text = "선전 포고"
  },
  Skill_45463_Desc_1 = {
    Text = "<EnergyStorageKeywords:차지>를 [Arg1]스택 획득하고, 자신에게 <PVPVulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_45463_Name_1 = {
    Text = "솟구치는 증오"
  },
  Skill_45464_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, 같은 양의 <PVPSacrificeKeyWords:희생>을 부여한다."
  },
  Skill_45464_Name_1 = {
    Text = "레무리아의 의식"
  },
  Skill_45465_Desc_1 = {
    Text = "모든 아군에게 <Block:[Block:Arg1]>의 실타래드를 부여하고, 모든 적의 <PVPSacrificeKeyWords:희생>을 발동시킨다."
  },
  Skill_45465_Name_1 = {
    Text = "심연의 윤회"
  },
  Skill_45466_Desc_1 = {
    Text = "모든 적의 광기를 <Energy:[Energy:Arg1]> 감소시키고, <PVPCapKeywords:최대 산출력> - [Arg2]."
  },
  Skill_45466_Name_1 = {
    Text = "허망의 은총"
  },
  Skill_45467_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, <DisarmKeywords:마비>, <PVPMethysisKeywords:중독>, <PVPBleedingKeywords:출혈>."
  },
  Skill_45467_Name_1 = {
    Text = "삼날 가시"
  },
  Skill_45468_Desc_1 = {
    Text = "[Arg1]의 임시 <PVPRetaliateIconKeywords:반격>을 획득하고, 이번 턴에 [Arg3]회 「스킬」 사용 후 1스택의 <EnergyStorageKeywords:차지>를 획득한다. 턴 종료 시까지 사용하지 않은 횟수는 각각 <Heal:[Heal:Arg4]>의 HP 회복으로 전환된다."
  },
  Skill_45468_Name_1 = {
    Text = "이단의 혈통"
  },
  Skill_45469_Desc_1 = {
    Text = "<DelayKeywords:지연>: <Energy:[Energy:Arg1]> 광기."
  },
  Skill_45469_Name_1 = {
    Text = "쥐 떼의 왕"
  },
  Skill_4546_AwakerSkillBackgroundStory = {
    Text = "젠킨도 처음에는 브라운을 이해할 수 없었다.\n 이렇게는 안 되겠다고 그녀는 생각했다. 이렇게 하면 브라운이 거리의 자부심 강한 신사들의 주목을 끌 수 없으니, 그녀가 그들의 주머니에서 오늘 저녁을 가져올 수 없을 것이다.\n 그래서 그녀는 등불을 들고 훈련을 시작했고, 여러 날의 시도 끝에 드디어...\n “브라운, 출동!”\n “지!”"
  },
  Skill_4546_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 전투 동안 「브라운 출동!」이 주는 피해가 [Arg2] 증가한다. <TransitionIconKeywords:워프>: 모든 적에게 피해를 입히는 효과로 변경되지만, 사용 후 <DepleteIconKeywords:소모>된다."
  },
  Skill_4546_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이번 전투 동안 「브라운 출동!」이 주는 피해가 [Arg2] 증가하고, 「쥐 떼 돌격」이 주는 피해가 [Arg3] 증가한다. <TransitionIconKeywords:워프>: 모든 적에게 피해를 입히는 효과로 변경되지만, 사용 후 <DepleteIconKeywords:소모>된다."
  },
  Skill_4546_EffectNameList_0 = {
    Text = "피해, 피해 증가"
  },
  Skill_4546_EffectNameList_1 = {
    Text = "피해, 피해 증가, 쥐 떼 돌격 피해 증가"
  },
  Skill_4546_Name = {
    Text = "브라운 출동!"
  },
  Skill_4546_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4546_PropertyNameList_1 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_45470_Desc_1 = {
    Text = "<PVPMouseKeywords:쥐 카드><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:> 중 하나를 선택하고, 그 카드의 복사본 [Arg1]장을 손에 넣는다."
  },
  Skill_45470_Name_1 = {
    Text = "길거리 친구"
  },
  Skill_45471_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45471_Name_1 = {Text = "타격"},
  Skill_45472_Desc_1 = {
    Text = "아군 한 명의 부정 상태를 해제하거나, 적 한 명의 긍정 상태를 해제한다."
  },
  Skill_45472_Name_1 = {
    Text = "생리 해부"
  },
  Skill_45473_Desc_1 = {
    Text = "전체 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_45473_Name_1 = {
    Text = "외부 계역 주입"
  },
  Skill_45474_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_45474_Name_1 = {
    Text = "깊은 치유"
  },
  Skill_45475_Desc_1 = {
    Text = "적 전체가 이번 턴 능동 피해를 받은 후 피해의 [Arg1]%에 해당하는 <PVPSacrificeKeyWords:헌제>를 획득하게 하며, 임시 <StrongEffectKeywords:강효> +[Arg2]."
  },
  Skill_45475_Name_1 = {
    Text = "망상의 왕녀"
  },
  Skill_45476_Desc_1 = {
    Text = "적 하나에게 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:출혈>을 가한다."
  },
  Skill_45476_Name_1 = {
    Text = "은밀한 가시"
  },
  Skill_45477_Desc_1 = {
    Text = "피해를 <Damage:[Damage:Arg1]> 데미지를 주고, <PVPWeaknessKeywords:약화>, <PVPPenetrateKeywords:관통>합니다."
  },
  Skill_45477_Name_1 = {
    Text = "잃어버린 예술"
  },
  Skill_45478_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45478_Name_1 = {Text = "타격"},
  Skill_45479_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, 피해량의 절반만큼 HP를 잃는다."
  },
  Skill_45479_Name_1 = {
    Text = "철쇄 강타"
  },
  Skill_4547_Desc = {
    Text = "다른 깨어남체가 <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_4547_Name = {
    Text = "고차원 촉매"
  },
  Skill_45480_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, 피해량의 절반만큼 HP를 잃는다."
  },
  Skill_45480_Name_1 = {
    Text = "사슬 회전"
  },
  Skill_45481_Desc_1 = {
    Text = "랜덤으로 <Damage:[Damage:Arg1]>의 피해를 주고, <TauntKeywords:도발>을 가진 적 대상을 우선 공격하며, 피해량의 절반만큼 HP를 잃는다."
  },
  Skill_45481_Name_1 = {
    Text = "부정형의 사슬"
  },
  Skill_45482_Desc_1 = {
    Text = "임의의 다른 대상으로부터 <Energy:[Energy:Arg2]> 광기를 탈취하고, 대상과 자신에게 <PVPEmptinessKeywords:공허>를 부여하며, <StrongEffectKeywords:증폭> +[Arg1], 「꿀빛 비극의 환상」에게 <StrongEffectKeywords:증폭> +[Arg3]."
  },
  Skill_45482_Name_1 = {
    Text = "꿀빛 비극의 환상"
  },
  Skill_45483_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45483_Name_1 = {Text = "타격"},
  Skill_45484_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45484_Name_1 = {Text = "타격"},
  Skill_45485_Desc_1 = {
    Text = "적 하나의 긍정 상태를 해제하고, 대상에게 <Damage:[Damage:Arg1]> 피해를 가하며, [Arg2]<PVPSlowKeywords:둔화>."
  },
  Skill_45485_Name_1 = {
    Text = "별빛 오로라"
  },
  Skill_45486_Desc_1 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득한다."
  },
  Skill_45486_Name_1 = {
    Text = "경화된 돌 피부"
  },
  Skill_45487_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPWeaknessKeywords:허약>를 부여한다."
  },
  Skill_45487_Name_1 = {
    Text = "허약의 시선"
  },
  Skill_45488_Desc_1 = {
    Text = "전체 아군에게 <Block:[Block:Arg1]>의 실타래드를 부여한다."
  },
  Skill_45488_Name_1 = {
    Text = "레무리아의 수호"
  },
  Skill_45489_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  Skill_45489_Name_1 = {
    Text = "왕권의 위엄"
  },
  Skill_4548_Desc = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_4548_Name = {
    Text = "고차원 광기"
  },
  Skill_45490_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  Skill_45490_Name_1 = {
    Text = "영원한 위세"
  },
  Skill_45491_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, <PVPSlowKeywords:둔화>를 부여한다."
  },
  Skill_45491_Name_1 = {Text = "물거품"},
  Skill_45492_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, 대상을 처치할 경우 다른 적에게 동일한 양의 <PVPBleedingKeywords:출혈>을 부여한다."
  },
  Skill_45492_Name_1 = {
    Text = "멸망의 예언"
  },
  Skill_45493_Desc_1 = {
    Text = "적 한 명의 긍정적 상태를 해제하고, 해당 대상에게 <Damage:[Damage:Arg1]> 피해를 입히며, <PVPCapKeywords:최대 산출력> - [Arg2]."
  },
  Skill_45493_Name_1 = {
    Text = "심해의 저주"
  },
  Skill_45494_Desc_1 = {
    Text = "적 한 명에게 <PVPVulnerabilityIconKeywords:취약>과 <PVPSeriousInjuryKeywords:중상>을 부여하고, HP를 <Damage:[Arg1]> 잃는다."
  },
  Skill_45494_Name_1 = {
    Text = "해월의 고통"
  },
  Skill_45495_Desc_1 = {
    Text = "무작위로 [Arg1]회 <Damage:[Damage:Arg2]> 피해를 입히고, <Damage:[Arg3]> 생명력을 잃음."
  },
  Skill_45495_Name_1 = {
    Text = "쌍방 자극"
  },
  Skill_45496_Desc_1 = {
    Text = "전체 적의 긍정 상태를 해제하고, <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_45496_Name_1 = {
    Text = "심연을 향한 기도"
  },
  Skill_45497_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45497_Name_1 = {Text = "타격"},
  Skill_45498_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45498_Name_1 = {Text = "타격"},
  Skill_45499_BattleDesc_1 = {
    Text = "HP를 <Heal:[Heal:Arg4]> 회복하고, HP [Arg2] 손실타래당 치유량이 [Arg3] 증가한다."
  },
  Skill_45499_Desc_1 = {
    Text = "HP를 <Heal:[Heal:Arg1]> 회복하고, HP [Arg2] 손실타래당 치유량이 [Arg3] 증가한다."
  },
  Skill_45499_Name_1 = {
    Text = "재구성 치유"
  },
  Skill_4549_Desc = {
    Text = "전체 적에게 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4549_Name = {
    Text = "고차원 허약"
  },
  Skill_45500_BattleDesc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg4]> 데미지를 입히며, [Arg2] HP가 손실타래될 때마다 데미지 + [Arg3], 동시에 「공격」으로 간주."
  },
  Skill_45500_Desc_1 = {
    Text = "적 전체에게 <Damage:[Damage:Arg1]> 피해를 입히며, 생명력 [Arg2] 손실타래당 피해 + [Arg3], 동시에 「타격」으로 간주."
  },
  Skill_45500_Name_1 = {
    Text = "보답의 일격"
  },
  Skill_45501_Desc_1 = {
    Text = "<HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, 적을 처치하면 다른 아군에게 <Energy:[Energy:Arg2]> 광기를 부여한다."
  },
  Skill_45501_Name_1 = {
    Text = "원질의 바다"
  },
  Skill_45502_Desc_1 = {
    Text = "<TauntKeywords:도발>을 부여하고 자신에게 <PVPVulnerabilityIconKeywords:취약>을 부여하며, 다음 턴 전까지 능동적으로 공격받을 때마다 광기를 [Energy:Arg1]pt 획득한다."
  },
  Skill_45502_Name_1 = {
    Text = "고통 전환"
  },
  Skill_45503_Desc_1 = {
    Text = "임의의 다른 대상에게 [Arg1]스택 <EnergyStorageKeywords:차지>를 부여하고, 대상의 <Energy:[Energy:Arg2]>의 광기를 빼앗으며 <PVPEmptinessKeywords:공허>를 부여한다."
  },
  Skill_45503_Name_1 = {
    Text = "끝없는 공허"
  },
  Skill_45504_BattleDesc_1 = {
    Text = "무작위로 <Damage:[Damage:Arg4]> 데미지를 입히며, [Arg2] HP가 부족할 때마다 데미지 + [Arg3]."
  },
  Skill_45504_Desc_1 = {
    Text = "랜덤으로 <Damage:[Damage:Arg1]> 피해를 가하며, 생명력 [Arg2] 부족 시마다 피해 + [Arg3]."
  },
  Skill_45504_Name_1 = {
    Text = "속박의 사슬"
  },
  Skill_45505_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, 피해량의 절반만큼 HP를 회복한다."
  },
  Skill_45505_Name_1 = {
    Text = "해연의 힘"
  },
  Skill_45506_Desc_1 = {
    Text = "<PVPResurrectionKeywords:부활>로 아군 한 명을 부활시키고, 대상의 HP를 <Heal:[Heal:Arg1]> 회복시킨다."
  },
  Skill_45506_Name_1 = {
    Text = "이성, 진리와 현실타래"
  },
  Skill_4550_Desc = {
    Text = "전체 적에게 2턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4550_Name = {
    Text = "고차원 취약"
  },
  Skill_45510_Desc_1 = {
    Text = "선택: 전체 아군에게 <Energy:[Energy:Arg1]>의 광기를 부여하거나, 전체 아군에게 <Block:[Block:Arg2]>의 실타래드를 부여한다."
  },
  Skill_45510_Name_1 = {
    Text = "특수 배합"
  },
  Skill_45511_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45511_Name_1 = {Text = "타격"},
  Skill_45512_BattleDesc_1 = {
    Text = "합계 <Damage:[Damage:Arg4]> 피해를 가하고, 모든 연산력을 소진하며, 연산력을 [Arg2] 소모할 때마다 피해 + [Arg3], 모든 적에게 균등 분배하여 각 적에게 <Damage:[Damage:Arg5]> 피해를 가합니다."
  },
  Skill_45512_Desc_1 = {
    Text = "합계 <Damage:[Damage:Arg1]> 피해를 입히며, 모든 연산력을 소진하고, 연산력 [Arg2] 소모당 피해 + [Arg3], 모든 적에게 균등 분배."
  },
  Skill_45512_Name_1 = {
    Text = "죽음을 고하는 춤"
  },
  Skill_45513_Desc_1 = {
    Text = "[Arg1]스택 <EnergyStorageKeywords:차지>를 획득한다."
  },
  Skill_45513_Name_1 = {
    Text = "전투 의지"
  },
  Skill_45514_Desc_1 = {
    Text = "이번 턴에 「타격」을 사용하면, 「타격」+ [Arg1]% 피해 <PVPPenetrateKeywords:관통>; 그렇지 않으면 턴 종료 시 +[Arg2] <PVPProtectiveKeywords:배리어>."
  },
  Skill_45514_Name_1 = {
    Text = "별 짐승의 여운"
  },
  Skill_45515_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45515_Name_1 = {
    Text = "오염 폭풍"
  },
  Skill_45516_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 <PVPCardLockKeywords:카드 봉쇄>를 부여한다."
  },
  Skill_45516_Name_1 = {
    Text = "차원 추적"
  },
  Skill_45517_Desc_1 = {
    Text = "다른 모든 깨어남체의 손패를 버리고, 버린 수만큼 + [Arg1]의 랜덤한 <PVPMouseKeywords:쥐 카드><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>를 손에 넣는다. <PVPPowerIconKeywords:힘> + [Arg2]."
  },
  Skill_45517_Name_1 = {
    Text = "안개 도시의 거리 아이"
  },
  Skill_45518_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_11:「불평등한 교환」> [Arg1]장을 손에 넣는다."
  },
  Skill_45518_Name_1 = {
    Text = "잃어버린 고대의 도시"
  },
  Skill_45519_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45519_Name_1 = {Text = "타격"},
  Skill_4551_Desc = {
    Text = "행동력 2pt를 획득한다."
  },
  Skill_4551_Name = {
    Text = "고차원 계산"
  },
  Skill_45520_Desc_1 = {
    Text = "전체 적의 <PVPMethysisKeywords:중독>을 발동시킨다."
  },
  Skill_45520_Name_1 = {
    Text = "중독 폭발"
  },
  Skill_45521_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_45521_Name_1 = {
    Text = "해양 독소"
  },
  Skill_45522_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_45522_Name_1 = {
    Text = "독기 충만"
  },
  Skill_45523_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_45523_Name_1 = {
    Text = "여명의 섬광"
  },
  Skill_45524_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 <PVPBleedingKeywords:출혈> 피해를 준다."
  },
  Skill_45524_Name_1 = {
    Text = "떨어지는 녹색 별"
  },
  Skill_45525_Desc_1 = {
    Text = "<StrengthenKeywords:강화>와 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_45525_Name_1 = {
    Text = "수호의 녹색 불꽃"
  },
  Skill_45526_BattleDesc_1 = {
    Text = "적 한 명의 긍정적 상태를 해제하고 <Damage:[Damage:Arg3]> 데미지를 입히며, 자신의 <PVPProtectiveKeywords:장벽>을 제거하고, 층마다 데미지 + [Arg2]."
  },
  Skill_45526_Desc_1 = {
    Text = "적 하나의 긍정 상태를 해제하고 <Damage:[Damage:Arg1]> 피해를 가하며, 자신의 <PVPProtectiveKeywords:배리어>를 제거하고, 1층당 피해 + [Arg2]."
  },
  Skill_45526_Name_1 = {
    Text = "「심판」"
  },
  Skill_45527_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, <PVPProtectiveKeywords:장벽>을 획득한다."
  },
  Skill_45527_Name_1 = {
    Text = "신성한 뼈와 피"
  },
  Skill_45528_BattleDesc_1 = {
    Text = "무작위로 [Arg1]회 <Damage:[Damage:Arg4]> 데미지를 입히고, 자신의 <PVPProtectiveKeywords:장벽>을 제거하며, 층마다 데미지 + [Arg3]."
  },
  Skill_45528_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]> 피해를 가하고, 자신의 <PVPProtectiveKeywords:배리어>를 제거하며, 1층당 피해 + [Arg3]."
  },
  Skill_45528_Name_1 = {
    Text = "「징악」"
  },
  Skill_45529_Desc_1 = {
    Text = "적에게 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:출혈>과 <PVPPenetrateKeywords:관통>을 입힙니다."
  },
  Skill_45529_Name_1 = {
    Text = "피와 모래의 찬가"
  },
  Skill_4552_Desc = {
    Text = "카드 2장을 드로우한다."
  },
  Skill_4552_Name = {
    Text = "고차원 묘수"
  },
  Skill_45530_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45530_Name_1 = {Text = "타격"},
  Skill_45531_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45531_Name_1 = {
    Text = "뒤틀린 시체의 광연"
  },
  Skill_45532_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45532_Name_1 = {Text = "타격"},
  Skill_45533_Desc_1 = {
    Text = "이전 턴의 마지막에 사용한 [Arg1]장의 \"스킬\"을 손으로 가져와 비용을 0으로 만든다. 이 효과가 여러 번 발동할 경우, 이전 턴으로 거슬러 올라간다."
  },
  Skill_45533_Name_1 = {
    Text = "패러독스 수렴"
  },
  Skill_45534_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해와 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여한다."
  },
  Skill_45534_Name_1 = {
    Text = "맛있게 드세요!"
  },
  Skill_45535_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_10:「비혈」> [Arg1]장을 획득한다."
  },
  Skill_45535_Name_1 = {
    Text = "피의 선언"
  },
  Skill_45536_BattleDesc_1 = {
    Text = "무작위로 [Arg1] 회 <Damage:[Damage:Arg3]> 피해를 입히며, <PVPCapKeywords:최대 산출력> 1점마다 [Arg2] 피해 증가."
  },
  Skill_45536_Desc_1 = {
    Text = "무작위로 [Arg1] 회 피해를 입히며, <PVPCapKeywords:최대 산출력> 1점마다 [Arg2] 피해 증가."
  },
  Skill_45536_Name_1 = {
    Text = "날카로운 비명"
  },
  Skill_45537_Desc_1 = {
    Text = "적 한 명에게 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:출혈>을 부여하고,"
  },
  Skill_45537_Name_1 = {
    Text = "피의 애가"
  },
  Skill_45538_Desc_1 = {
    Text = "아군에게 긍정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여하거나, 적에게 부정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여한다."
  },
  Skill_45538_Name_1 = {
    Text = "창작 디저트"
  },
  Skill_45539_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복하고, 자신에게 사용 시 효과가 절반으로 감소하며, 긍정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여한다."
  },
  Skill_45539_Name_1 = {
    Text = "영양 보충 스튜"
  },
  Skill_4553_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「구걸자」를 소환한다."
  },
  Skill_4553_Name = {
    Text = "분열 타격"
  },
  Skill_45540_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득하고, 손에 든 모든 카드의 사용 횟수를 [Arg2] 회복한다."
  },
  Skill_45540_Name_1 = {
    Text = "식재료 보충"
  },
  Skill_45541_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 또는 <Damage:[Damage:Arg2]> 또는 <Damage:[Damage:Arg3]> 피해를 입히고, <PVPPenetrateKeywords:관통> 합니다."
  },
  Skill_45541_Name_1 = {Text = "올인!"},
  Skill_45542_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고 <PVPProtectiveKeywords:장벽>을 획득하며, 동시에 \"타격\"으로 간주한다."
  },
  Skill_45542_Name_1 = {
    Text = "환형 궤도"
  },
  Skill_45543_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, <PVPProtectiveKeywords:장벽> [Arg3]을 획득한다."
  },
  Skill_45543_Name_1 = {
    Text = "죽음의 꿈 도시"
  },
  Skill_45544_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히고, <DisarmKeywords:마비>, <PVPPenetrateKeywords:관통> 합니다."
  },
  Skill_45544_Name_1 = {
    Text = "전자기 폭발"
  },
  Skill_45545_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:약점> 자신, <DelayKeywords:지연> : [Arg1] 장의 카드를 뽑습니다."
  },
  Skill_45545_Name_1 = {
    Text = "위대한 희생"
  },
  Skill_45546_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 [Arg2] 회 반복해서 입히며, 「성혈의 인도」 상태의 대상이 있으면 우선 공격한다."
  },
  Skill_45546_Name_1 = {
    Text = "존속의 본능"
  },
  Skill_45547_Desc_1 = {
    Text = "이번 턴 동안, 대상이 능동적으로 공격받을 때마다, 가장 많은 HP를 잃은 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_45547_Name_1 = {
    Text = "성혈의 인도"
  },
  Skill_45548_Desc_1 = {
    Text = "<PVPResurrectionKeywords:소생>전체 아군, <DelayKeywords:지연> : 전체 아군의 생명을 <Heal:[Heal:Arg1]> 회복합니다."
  },
  Skill_45548_Name_1 = {
    Text = "불멸의 극락조"
  },
  Skill_45549_BattleDesc_1 = {
    Text = "지정한 적에게 <Damage:[Damage:Arg2]> 피해를 입히며, 연산력 상한 1당 피해 + [Arg1]."
  },
  Skill_45549_Desc_1 = {
    Text = "지정한 적에게 피해를 입히며, <PVPCapKeywords:최대 산출력> 1점마다 [Arg1] 피해 증가."
  },
  Skill_45549_Name_1 = {
    Text = "불을 쫓는 벌레"
  },
  Skill_4554_Desc = {
    Text = "임시 <AlertIconKeywords:경계>를 [Arg1]pt 획득한다."
  },
  Skill_4554_Name = {Text = "양산"},
  Skill_45550_Desc_1 = {
    Text = "카드 [Arg1]장을 드로우한다."
  },
  Skill_45550_Name_1 = {
    Text = "묻힌 보물"
  },
  Skill_45551_Desc_1 = {
    Text = "[Arg1]장의 카드를 확인하고, 1장을 손에 넣으며, 나머지 카드는 덱에 섞어 넣는다."
  },
  Skill_45551_Name_1 = {
    Text = "암류의 미광"
  },
  Skill_45552_Desc_1 = {
    Text = "<StrengthenKeywords:강화>로 전체 아군을 강화하고, <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_45552_Name_1 = {
    Text = "준비 완료"
  },
  Skill_45553_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45553_Name_1 = {Text = "타격"},
  Skill_45554_Desc_1 = {
    Text = "전방의 적에게 피해를 <Damage:[Damage:Arg1]>만큼 입히고, 그만큼 보호막을 획득한다."
  },
  Skill_45554_Name_1 = {
    Text = "칠예, 전승된 미덕"
  },
  Skill_45555_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <DisarmKeywords:마비>와 <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_45555_Name_1 = {
    Text = "인격 오염"
  },
  Skill_45556_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, 피해량과 동일한 양의 실타래드를 획득하며, <TauntKeywords:도발>을 부여한다."
  },
  Skill_45556_Name_1 = {
    Text = "방어 광선"
  },
  Skill_45557_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Block:[Block:Arg2]>의 실타래드를 획득하며, <StrongEffectKeywords:강효> +[Arg3]을 부여한다."
  },
  Skill_45557_Name_1 = {
    Text = "끝없는 조각"
  },
  Skill_45558_Desc_1 = {
    Text = "전체 아군에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_45558_Name_1 = {
    Text = "양자 촉매"
  },
  Skill_45559_Desc_1 = {
    Text = "아군 한 명에게 <Block:[Block:Arg1]>의 실타래드를 부여한다."
  },
  Skill_45559_Name_1 = {
    Text = "광학 방호"
  },
  Skill_4555_Desc = {
    Text = "구속에서 벗어나 부화하여, 다음 목표를 찾고 있다…"
  },
  Skill_4555_Name = {
    Text = "부화 재생"
  },
  Skill_45560_Desc_1 = {
    Text = "<HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 <Damage:[Damage:Arg1]> 피해를 입힌다. 사망한 깨어남체 1개마다 추가로 1회 피해를 입힌다."
  },
  Skill_45560_Name_1 = {
    Text = "피를 밟고서"
  },
  Skill_45561_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45561_Name_1 = {Text = "타격"},
  Skill_45562_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_15:「액화된 허무」> 3장을 획득한다."
  },
  Skill_45562_Name_1 = {
    Text = "종점, 진리와 심연의 문"
  },
  Skill_45563_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, 적을 처치하면 「회환검기」 [Arg2]장을 손에 배치하며, 피해 + [Arg3]."
  },
  Skill_45563_Name_1 = {
    Text = "회전 검술"
  },
  Skill_45564_Desc_1 = {
    Text = "<ReinforceKeywords:보강>로 아군 한 명을 강화하고, 그의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_45564_Name_1 = {
    Text = "유토피아의 축복"
  },
  Skill_45565_BattleDesc_1 = {
    Text = "[Arg3]회 <Damage:[Damage:Arg1]> 피해를 입히며, 사망한 아군 1개당 추가로 1회 피해를 입힘."
  },
  Skill_45565_Desc_1 = {
    Text = "[Arg2]회 <Damage:[Damage:Arg1]> 피해를 입히며, 사망한 아군 1개당 추가로 1회 피해를 입힘."
  },
  Skill_45565_Name_1 = {
    Text = "순백의 잔물결"
  },
  Skill_45566_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복하고, <TauntKeywords:도발>을 부여한다."
  },
  Skill_45566_Name_1 = {
    Text = "피안의 신호"
  },
  Skill_45567_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히고, <PVPMethysisKeywords:중독>, <PVPPenetrateKeywords:관통>. 화려한 장편: 추가로 [Arg2] 회 발동."
  },
  Skill_45567_Name_1 = {
    Text = "죽음의 시편"
  },
  Skill_45568_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히고, <DisarmKeywords:마비>, <PVPPenetrateKeywords:관통>. 화려한 장편: 추가로 적 전체에게 [Arg2] 회 적용."
  },
  Skill_45568_Name_1 = {
    Text = "영혼의 시편"
  },
  Skill_45569_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복하고, <PVPPenetrateKeywords:관통>. 화려한 장편: 대상의 부정적 상태를 해제하고 추가로 [Arg2] 회 적용."
  },
  Skill_45569_Name_1 = {
    Text = "생명의 시편"
  },
  Skill_4556_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45570_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45570_Name_1 = {Text = "타격"},
  Skill_45571_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45571_Name_1 = {Text = "타격"},
  Skill_45572_Desc_1 = {
    Text = "전체 아군의 모든 <DelayKeywords:지연> 치유 효과를 즉시로 발동시키고, 랜덤으로 [Arg1] 회 <Damage:[Damage:Arg2]> 데미지를 입힙니다."
  },
  Skill_45572_Name_1 = {
    Text = "아첨의 포옹"
  },
  Skill_45573_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45573_Name_1 = {Text = "타격"},
  Skill_45574_Desc_1 = {
    Text = "<StrongEffectKeywords:강효> +[Arg1]을 부여하고, 다음 시편을 증폭시켜 추가 효과를 부여한다."
  },
  Skill_45574_Name_1 = {
    Text = "화려한 시곡"
  },
  Skill_45575_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  Skill_45575_Name_1 = {
    Text = "별들이 교차하는 순간"
  },
  Skill_45576_Desc_1 = {
    Text = "「타격」[Arg1]장을 획득한다."
  },
  Skill_45576_Name_1 = {
    Text = "혼돈의 짐승"
  },
  Skill_45577_Desc_1 = {
    Text = "<PVPHoldingKeywords:보유>: 상대가 사용한 마지막 「스킬」로 변하며, 비용 - [Arg1]."
  },
  Skill_45577_Name_1 = {
    Text = "별빛의 모방"
  },
  Skill_45578_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 광기, [Arg2] 중첩 <EnergyStorageKeywords:축력> 획득."
  },
  Skill_45578_Name_1 = {
    Text = "맹렬한 성장"
  },
  Skill_45579_Desc_1 = {
    Text = "<TauntKeywords:도발>을 부여한다. 다음 턴 시작까지, 자신이 공격받을 때마다 [Arg1]스택의 <EnergyStorageKeywords:차지>를 획득하고, 공격자에게 [Arg1]스택의 <PVPSlowKeywords:둔화>를 부여한다."
  },
  Skill_45579_Name_1 = {
    Text = "이상 중력"
  },
  Skill_4557_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「네 탓이야」 2개를 소환한다."
  },
  Skill_4557_Name = {Text = "호출"},
  Skill_45580_Desc_1 = {
    Text = "<PVPProtectiveKeywords:장벽>, 카드를 [Arg2] 장 뽑는다."
  },
  Skill_45580_Name_1 = {
    Text = "좀비의 벽"
  },
  Skill_45582_Desc_1 = {
    Text = "전체 아군의 부정 상태를 해제하고, [Arg1]스택 <EnergyStorageKeywords:차지>를 획득한다."
  },
  Skill_45582_Name_1 = {
    Text = "부활의 메아리"
  },
  Skill_45583_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <PVPSlowKeywords:둔화>를 부여한다."
  },
  Skill_45583_Name_1 = {Text = "애가"},
  Skill_45584_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 주고, <PVPPenetrateKeywords:관통>하며 동시에 「타격」으로 간주됩니다."
  },
  Skill_45584_Name_1 = {
    Text = "구름을 뚫는 외침"
  },
  Skill_45585_BattleDesc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg4]> 데미지를 입히고 <PVPSlowKeywords:둔화>를 부여하며, [Arg2] 방어막를 보유할 때마다 데미지 + [Arg3]."
  },
  Skill_45585_Desc_1 = {
    Text = "적 전체에게 <Damage:[Damage:Arg1]> 피해를 입히며, <PVPSlowKeywords:둔화>, 보호막 [Arg2]당 피해 + [Arg3]."
  },
  Skill_45585_Name_1 = {
    Text = "무한한 정의"
  },
  Skill_45586_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 준다."
  },
  Skill_45586_Name_1 = {
    Text = "창조주의 은총"
  },
  Skill_45587_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 주어, <PVPPenetrateKeywords:관통>합니다."
  },
  Skill_45587_Name_1 = {
    Text = "혼령 추격"
  },
  Skill_45588_Desc_1 = {
    Text = "대상에게 <PVPVulnerabilityIconKeywords:취약>을 부여하고 <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_45588_Name_1 = {
    Text = "레버리지 투기"
  },
  Skill_45589_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히며, <PVPSlowKeywords:둔화>."
  },
  Skill_45589_Name_1 = {
    Text = "카드 트릭"
  },
  Skill_4558_AwakerSkillBackgroundStory = {
    Text = "학생들은 라모나와 눈을 마주치는 것을 피했다.\n\n소문에 따르면, 그 푸른 눈은 마음속을 꿰뚫어 볼 수 있으며, 모든 거짓말은 라모나의 눈앞에서 숨을 수 없다고 한다. 심지어 그녀가 단안경을 벗는 날이 바로 신이 강림하는 날이라는 말도 있다.\n\n“선배들 헛소문은 믿지 마, 안경은 그냥 읽기 편하려고 쓰는 거야.”\n\n“나는 최신형 거짓말 탐지기가 아니야. 이 정도 추리는 그냥 간단한 거 아니야?”"
  },
  Skill_4558_Desc_0 = {
    Text = "모든 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시킨다. 카드를 1장 드로우한다."
  },
  Skill_4558_Desc_2 = {
    Text = "모든 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시킨다. 카드를 1장 뽑고, 뽑은 카드의 비용 1당 <Posse:[Arg2]>pt의 열쇠 에너지를 획득한다."
  },
  Skill_4558_EffectNameList = {Text = "힘 감소"},
  Skill_4558_Name = {
    Text = "공격 분석"
  },
  Skill_4558_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_45590_Desc_1 = {
    Text = "무작위 적에게 [Arg2] 회 <Damage:[Damage:Arg1]> 데미지를 입히고,"
  },
  Skill_45590_Name_1 = {
    Text = "승부수 들어간다!"
  },
  Skill_45591_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg3]> 데미지를 입히고, 이 카드를 덱에 섞으며, 모든 「천면중첩」 데미지 + [Arg2]."
  },
  Skill_45591_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, 이 카드를 드로우 더미에 셔플하며, 모든 「천면중첩」의 피해 + [Arg2]."
  },
  Skill_45591_Name_1 = {
    Text = "천면 중첩"
  },
  Skill_45592_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPRaidKeywords:돌격>: <Damage:[Damage:Arg3]>의 피해로 대체하여 준다."
  },
  Skill_45592_Name_1 = {
    Text = "광전 돌진"
  },
  Skill_45593_Desc_1 = {
    Text = "적 전체에게 <Damage:[Damage:Arg1]> 피해를 입히며, <PVPRaidKeywords:돌격>: <Damage:[Damage:Arg3]> 피해로 변경."
  },
  Skill_45593_Name_1 = {
    Text = "블레셋식 기습"
  },
  Skill_45594_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, 적을 처치할 경우 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45594_Name_1 = {
    Text = "거검 중격"
  },
  Skill_45595_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, <PVPSeriousInjuryKeywords:중상> 상태인 대상에게는 피해가 2배로 증가한다."
  },
  Skill_45595_Name_1 = {
    Text = "폭발하는 피"
  },
  Skill_45596_Desc_1 = {
    Text = "랜덤으로 <Damage:[Damage:Arg1]>의 피해를 주고, 피해의 절반만큼 임시 <PVPRetaliateIconKeywords:반격>을 획득하며, 동시에 「타격」으로 간주한다."
  },
  Skill_45596_Name_1 = {
    Text = "역린 반격"
  },
  Skill_45597_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:치명타>을 입히고 <Damage:[Damage:Arg1]> 피해를 줍니다, <PVPPenetrateKeywords:관통>."
  },
  Skill_45597_Name_1 = {
    Text = "가시비늘 일격"
  },
  Skill_45598_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45598_Name_1 = {Text = "타격"},
  Skill_45599_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 광기를 소모하여 다른 아군에게 <Energy:[Energy:Arg2]> 광기를 부여한다."
  },
  Skill_45599_Name_1 = {
    Text = "음 엔트로피 연산"
  },
  Skill_4559_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45600_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45600_Name_1 = {Text = "타격"},
  Skill_45601_Desc_1 = {
    Text = "전체 적의 [Arg1] 장 랜덤 \"스킬\"을 확인하고, [Arg2] 장을 손에 넣어 비용을 0으로 만든다."
  },
  Skill_45601_Name_1 = {
    Text = "현실타래 모방"
  },
  Skill_45602_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <ComaKeywords:기절>을 부여한다."
  },
  Skill_45602_Name_1 = {
    Text = "영겁의 눈"
  },
  Skill_45603_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45603_Name_1 = {Text = "타격"},
  Skill_45604_Desc_1 = {
    Text = "아군 한 명에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_45604_Name_1 = {
    Text = "선택받은 자의 권능"
  },
  Skill_45605_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 준다."
  },
  Skill_45605_Name_1 = {
    Text = "불굴의 선언"
  },
  Skill_45606_Desc_1 = {
    Text = "<PVPCapKeywords:최대 산출력> + [Arg1]."
  },
  Skill_45606_Name_1 = {
    Text = "신국의 선물"
  },
  Skill_45607_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 데미지를 주고, 그리고 「타격」으로 간주됩니다"
  },
  Skill_45607_Name_1 = {
    Text = "광란의 절단"
  },
  Skill_45608_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입힌다."
  },
  Skill_45608_Name_1 = {
    Text = "욕망의 난무"
  },
  Skill_45609_Desc_1 = {
    Text = "대상의 해제 가능한 모든 긍정 상태를 빼앗고, <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_45609_Name_1 = {
    Text = "별의 요람"
  },
  Skill_4560_BattleDesc = {
    Text = "HP를 [Arg1] 잃고, 잃은 수치의 2배만큼 실타래드를 획득한다. 판매 불가."
  },
  Skill_4560_Desc = {
    Text = "최대 HP의 5%를 잃고, 잃은 수치의 2배만큼 실타래드를 획득한다. 판매 불가."
  },
  Skill_4560_Name = {
    Text = "증상: 폐쇄 공포증"
  },
  Skill_45610_BattleDesc_1 = {
    Text = "<TauntKeywords:도발>, [Arg4] 임시 <PVPRetaliateIconKeywords:반격>을 획득하고, <PVPProtectiveKeywords:배리어>가 [Arg2] 있을 때마다 추가로 [Arg3] 임시 <PVPRetaliateIconKeywords:반격>을 획득합니다."
  },
  Skill_45610_Desc_1 = {
    Text = "<TauntKeywords:도발>을 부여하고, [Arg1]의 임시 <PVPRetaliateIconKeywords:반격>을 획득하며, <PVPProtectiveKeywords:장벽>을 [Arg2] 보유할 때마다 임시 <PVPRetaliateIconKeywords:반격>을 [Arg3] 추가로 획득한다."
  },
  Skill_45610_Name_1 = {
    Text = "길 잃은 꿈의 인도자"
  },
  Skill_45611_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 입히고,"
  },
  Skill_45611_Name_1 = {Text = "등가시"},
  Skill_45612_Desc_1 = {
    Text = "<TauntKeywords:도발>, <Block:[Block:Arg1]> 보호막."
  },
  Skill_45612_Name_1 = {
    Text = "미로의 함정"
  },
  Skill_45613_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다."
  },
  Skill_45613_Name_1 = {
    Text = "올가미 교살"
  },
  Skill_45614_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다."
  },
  Skill_45614_Name_1 = {
    Text = "얽히는 거미줄"
  },
  Skill_45615_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다."
  },
  Skill_45615_Name_1 = {
    Text = "창백한 보호"
  },
  Skill_45616_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, <ComaKeywords:실타래신>시킨다."
  },
  Skill_45616_Name_1 = {
    Text = "진흙 위의 불멸의 꽃"
  },
  Skill_45617_Desc_1 = {
    Text = "카드 [Arg1]장을 드로우한다. 그 카드가 「명륜」일 경우 비용을 0으로 만든다. 그렇지 않을 경우 그 카드의 복사본 [Arg2]장을 손에 넣는다."
  },
  Skill_45617_Name_1 = {
    Text = "운명의 장인"
  },
  Skill_45618_Desc_1 = {
    Text = "아군 한 명에게 <Block:[Block:Arg1]>의 실타래드를 부여하고, 그의 손에 [Arg2]장의 「타격」을 넣는다."
  },
  Skill_45618_Name_1 = {
    Text = "도구 상자"
  },
  Skill_45619_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_45619_Name_1 = {
    Text = "녹슨 렌치"
  },
  Skill_4561_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45620_Desc_1 = {
    Text = "<TauntKeywords:도발>을 부여하고, 카드 [Arg1]장을 드로우한다."
  },
  Skill_45620_Name_1 = {
    Text = "작은 수호자"
  },
  Skill_45621_Desc_1 = {
    Text = "<PVPWeaknessKeywords:허약>, <PVPVulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_45621_Name_1 = {
    Text = "썩은 장미의 향기"
  },
  Skill_45622_BattleDesc_1 = {
    Text = "모든 적에게 <Damage:[Damage:Arg3]> 피해를 주고, 모든 손패를 버리고 모든 <EnergyStorageKeywords:차지>를 제거하며, 손패 1장과 <EnergyStorageKeywords:차지> 1층마다 피해 + [Arg2]."
  },
  Skill_45622_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 피해를 가하고, 모든 패를 버리며 모든 <EnergyStorageKeywords:축력>을 제거, 패 1장과 <EnergyStorageKeywords:축력> 1층마다 피해 + [Arg2]."
  },
  Skill_45622_Name_1 = {
    Text = "궁지 생존"
  },
  Skill_45623_Desc_1 = {
    Text = "선택: [Arg1]의 행동력을 획득하거나, [Arg2]장의 카드를 드로우한다."
  },
  Skill_45623_Name_1 = {
    Text = "천재의 예견"
  },
  Skill_45624_Desc_1 = {
    Text = "아군 전체에게 <Block:[Block:Arg1]> 보호막 부여, 임시 <StrongEffectKeywords:강효> +[Arg2]."
  },
  Skill_45624_Name_1 = {
    Text = "망상의 계승자"
  },
  Skill_45625_Desc_1 = {
    Text = "선택: 전체 아군의 HP를 <Heal:[Heal:Arg1]> 회복하거나, 전체 적에게 <Damage:[Damage:Arg2]>의 피해를 준다."
  },
  Skill_45625_Name_1 = {
    Text = "인간 관찰 실타래험"
  },
  Skill_45626_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 피해를 가하고, 랜덤 <PVPAmazingMagicKeywords:놀라운 마술><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:> 카드 1장을 손에 넣습니다."
  },
  Skill_45626_Name_1 = {
    Text = "마술 카니발"
  },
  Skill_45627_Desc_1 = {
    Text = "<DelayKeywords:지연>: 전체 아군에게 <Heal:[Heal:Arg1]> 생명을 회복합니다."
  },
  Skill_45627_Name_1 = {
    Text = "피에 목마른 광연"
  },
  Skill_45629_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득하고, <TauntKeywords:도발>을 부여한다."
  },
  Skill_45629_Name_1 = {
    Text = "예술의 열광"
  },
  Skill_4562_Desc = {
    Text = "실타래드를 [Arg2]pt 획득하고, 「악의적 방혈」 상태를 획득한다. 「악의적 방혈」: 방어되지 않은 피해를 1회 줄 때마다 <BleedingIconKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_4562_Name = {
    Text = "항해 요리"
  },
  Skill_45630_Desc_1 = {
    Text = "랜덤한 <PVPAmazingMagicKeywords:놀라운 마술><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:> 카드 1장을 손에 넣는다."
  },
  Skill_45630_Name_1 = {
    Text = "마술사의 금고"
  },
  Skill_45631_Desc_1 = {
    Text = "모든 손패를 버리고, 버린 수만큼 카드를 드로우한다. 손패가 0장일 경우 추가로 1장을 드로우한다."
  },
  Skill_45631_Name_1 = {
    Text = "속임수 셔플"
  },
  Skill_45632_Desc_1 = {
    Text = "아군 한 명을 <StrengthenKeywords:강화>하고 <ReinforceKeywords:보강>한다."
  },
  Skill_45632_Name_1 = {
    Text = "축복의 마법 코인"
  },
  Skill_45633_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45633_Name_1 = {Text = "타격"},
  Skill_45634_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45634_Name_1 = {Text = "타격"},
  Skill_45635_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히고, <TauntKeywords:도발>에 영향을 받은 대상에게는 3배의 피해를 입히며, 대상에게 <TauntKeywords:도발>을 부여한다."
  },
  Skill_45635_Name_1 = {
    Text = "선봉 전술"
  },
  Skill_45636_Desc_1 = {
    Text = "전체 아군에게 [Arg1]스택 <EnergyStorageKeywords:차지>를 부여한다."
  },
  Skill_45636_Name_1 = {
    Text = "전투 계시"
  },
  Skill_45637_Desc_1 = {
    Text = "<TauntKeywords:도발>, 부정 상태 해제."
  },
  Skill_45637_Name_1 = {
    Text = "기사의 열정"
  },
  Skill_45638_Desc_1 = {
    Text = "[Arg1] 행동력을 획득한다."
  },
  Skill_45638_Name_1 = {
    Text = "효율적인 사고"
  },
  Skill_45639_Desc_1 = {
    Text = "모든 적군에게 <Damage:[Damage:Arg1]> 피해를 입힌다."
  },
  Skill_45639_Name_1 = {
    Text = "미사그의 검"
  },
  Skill_4563_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45640_Desc_1 = {
    Text = "<PVPHoldingKeywords:보유>: 이번 턴 내에서 이전에 사용한 \"스킬\"로 간주한다."
  },
  Skill_45640_Name_1 = {
    Text = "모의 연역"
  },
  Skill_45641_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, 자신의 실타래드를 2배로 증가시키며, 「타격」으로 간주한다."
  },
  Skill_45641_Name_1 = {
    Text = "정의의 판결"
  },
  Skill_45642_Desc_1 = {
    Text = "<TauntKeywords:도발>을 부여하고, <PVPDerivativeCardKeywords_1:「심안 타격」> [Arg1]장을 획득한다."
  },
  Skill_45642_Name_1 = {
    Text = "전장의 수호자"
  },
  Skill_45643_Desc_1 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, [Arg2]스택 <EnergyStorageKeywords:차지>를 획득한다."
  },
  Skill_45643_Name_1 = {
    Text = "방어 자세"
  },
  Skill_45644_Desc_1 = {
    Text = "<TauntKeywords:도발>과 <ReinforceKeywords:보강>을 부여한다."
  },
  Skill_45644_Name_1 = {
    Text = "기계 장벽"
  },
  Skill_45645_Desc_1 = {
    Text = "전체 아군에게 <Block:[Block:Arg1]>의 실타래드를 부여한다."
  },
  Skill_45645_Name_1 = {
    Text = "역장 방호"
  },
  Skill_45646_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  Skill_45646_Name_1 = {
    Text = "전류 과부하"
  },
  Skill_45647_Desc_1 = {
    Text = "<DelayKeywords:지연>: 한 명의 아군에게서 부정적인 상태 효과를 해제하고, 그 아군의 생명을 <Heal:[Heal:Arg1]> 회복시킵니다."
  },
  Skill_45647_Name_1 = {
    Text = "응혈 치료"
  },
  Skill_45648_Desc_1 = {
    Text = "행동력을 가득 채운다."
  },
  Skill_45648_Name_1 = {
    Text = "세계 연역법"
  },
  Skill_45649_Desc_1 = {
    Text = "<PVPCapKeywords:최대 산출력> + [Arg1], <Energy:[Energy:Arg2]> 광기."
  },
  Skill_45649_Name_1 = {
    Text = "환희의 과실타래"
  },
  Skill_4564_Desc = {
    Text = "[Arg1] 층의<BleedingIconKeywords:출혈>을 부여하고, [Arg2] 점의<PowerIconKeywords:힘>을 줄입니다."
  },
  Skill_4564_Name = {
    Text = "침식의 시선"
  },
  Skill_45650_Desc_1 = {
    Text = "전체 적에게 <PVPSeriousInjuryKeywords:중상>을 부여하고 <Damage:[Damage:Arg1]>의 피해를 준다. 대상이 이미 <PVPSeriousInjuryKeywords:중상> 상태였다면 피해가 2배로 증가한다."
  },
  Skill_45650_Name_1 = {
    Text = "소란스러운 바다"
  },
  Skill_45651_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, 동일한 양의 피해만큼 방어막를 획득하며, 동시에 「타격」으로 간주한다."
  },
  Skill_45651_Name_1 = {
    Text = "통찰의 일격"
  },
  Skill_4565_Desc = {
    Text = "<DerivativeCardKeywords_23:「상처」> [Arg1]장을 상대의 덱에 섞어 넣는다."
  },
  Skill_4566_Desc = {
    Text = "자신을 희생하여, 자신의 HP를 「등불 교회 목사」의 HP로 전환한다."
  },
  Skill_4566_Name = {
    Text = "헌신의 제사"
  },
  Skill_45676_Desc_1 = {
    Text = "전체 적의 긍정 상태를 해제한다."
  },
  Skill_45676_Name_1 = {
    Text = "블러핑 마술 카드"
  },
  Skill_45677_Desc_1 = {
    Text = "전체 아군의 부정 상태를 해제한다."
  },
  Skill_45677_Name_1 = {
    Text = "토끼 신사모자"
  },
  Skill_45678_Desc_1 = {
    Text = "<HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, <DisarmKeywords:마비>시킨다."
  },
  Skill_45678_Name_1 = {Text = "전기 쥐"},
  Skill_45679_Desc_1 = {
    Text = "<PVPResurrectionKeywords:부활>로 아군 한 명을 부활시키고, 그 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_45679_Name_1 = {
    Text = "절단 분리 마법 상자"
  },
  Skill_4567_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45680_Desc_1 = {
    Text = "선택: 전체 아군의 부정 상태를 해제하거나, 전체 적의 긍정 상태를 해제한다."
  },
  Skill_45680_Name_1 = {
    Text = "비둘기 손수건"
  },
  Skill_45681_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, <PVPMethysisKeywords:중독>시킨다."
  },
  Skill_45681_Name_1 = {
    Text = "감염된 쥐"
  },
  Skill_45682_Desc_1 = {
    Text = "전체 아군에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_45682_Name_1 = {
    Text = "텔레파시 마이크"
  },
  Skill_45683_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 준다."
  },
  Skill_45683_Name_1 = {
    Text = "이성을 잃은 쥐"
  },
  Skill_45684_Desc_1 = {
    Text = "랜덤으로 [Arg1]회 <Damage:[Damage:Arg2]>의 피해를 주고, <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_45684_Name_1 = {
    Text = "끓어오르는 피"
  },
  Skill_4568_Desc = {
    Text = "적을 기절시키고, 그 적의 <RetaliateIconKeywords:반격> 스택수를 모두 제거한다."
  },
  Skill_4568_Name = {Text = "큰 돌"},
  Skill_45692_Desc = {
    Text = "덱의 무작위 명령 카드 1장을 동결하고, <MadnessIconKeywords:광란> 1스택을 획득한다."
  },
  Skill_45692_Name = {
    Text = "서리의 비명"
  },
  Skill_4569_Desc = {
    Text = "턴 종료 시 손에 있으면 자신에게 <FragileIconKeywords:취약>을 1턴간 부여한다. 사용 시 모든 적에게 <VulnerabilityIconKeywords:취약>을 1턴간 부여한다. 판매 불가."
  },
  Skill_4569_Name = {
    Text = "증상: 붕괴"
  },
  Skill_45704_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_45708_AwakerSkillBackgroundStory = {
    Text = "그가 거대한 검을 들 때, 반드시 피와 죽음이 따르게 된다."
  },
  Skill_45708_Desc_0 = {
    Text = "<DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣는다. 이번 전투 동안 「거대한 검의 위엄」과 「참수의 일격」의 기본 피해가 25% 증가한다."
  },
  Skill_45708_Desc_3 = {
    Text = "<DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣는다. 이번 전투 동안 「거대한 검의 위엄」과 「참수의 일격」의 기본 피해가 25% 증가한다. 골리아가 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_45708_Name = {Text = "잠복"},
  Skill_45709_AwakerSkillBackgroundStory = {
    Text = "그가 거대한 검을 들 때, 반드시 피와 죽음이 따르게 된다."
  },
  Skill_45709_Desc_0 = {
    Text = "<DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣고, 현재 촉수 피해의 [Arg1]%만큼 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_45709_Desc_3 = {
    Text = "<DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣고, 현재 촉수 피해의 [Arg1]%만큼 임시 <PowerIconKeywords:힘>을 획득한다. 골리아의 임시 치명타율이 [Arg2]% 증가한다."
  },
  Skill_45709_EffectNameList = {
    Text = "촉수 피해%"
  },
  Skill_45709_Name = {Text = "찬탈"},
  Skill_4570_AwakerSkillBackgroundStory = {
    Text = "빛나라, 고향이 있는 방향을 향하여."
  },
  Skill_4570_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4570_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 촉수 1개가 50%의 피해량으로 2회 공격한다."
  },
  Skill_4570_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 팔로스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4570_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 팔로스가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 촉수 1개가 50%의 피해량으로 2회 공격한다."
  },
  Skill_4570_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4570_Name = {Text = "방어"},
  Skill_4570_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4571_Desc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. <Block:[Block:Arg2]> 점 방어막를 획득합니다."
  },
  Skill_4571_EffectNameList = {
    Text = "실타래드"
  },
  Skill_4571_Name = {Text = "은열쇠"},
  Skill_4571_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_4572_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전체 아군이 <Block:[Block:Arg3]>pt의 실타래드를 획득하며 후퇴한다."
  },
  Skill_4573_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4574_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_4574_Name = {
    Text = "사냥창 찌르기"
  },
  Skill_4575_AwakerSkillBackgroundStory = {
    Text = "그것은 산으로 이루어진 고대 폐허이다. 처음에는, 그것은 바닷물 위에서 흔들리는 하얀 광채에 불과했다.\n나중에, 그것은 높은 계단, 왜곡된 부조, 우뚝 솟은 석주를 자아냈다. 쿵! 모든 것이 갑자기 멈추었을 때, 잊혀진 예술이 마침내 해저에서 베일을 벗었다. 그녀는 그 예술이 있는 곳으로 가야 한다."
  },
  Skill_4575_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득한다. 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 [Arg3] 증가한다. 이 스킬은 추가로 [Arg4]%의 치명타율과 치명타 피해 보너스가 적용된다. 보스 전투에서는 피해 횟수가 1회 추가된다."
  },
  Skill_4575_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득한다. 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 [Arg3] 증가한다. 이 스킬은 추가로 [Arg4]%의 치명타율과 치명타 피해 보너스가 적용된다. 보스 전투에서는 피해 횟수가 1회 추가된다."
  },
  Skill_4575_Desc_0 = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득한다. 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 [Arg3] 증가한다. 이 스킬은 추가로 [Arg4]%의 치명타율과 치명타 피해 보너스가 적용된다. 보스 전투에서는 피해 횟수가 1회 추가된다."
  },
  Skill_4575_Desc_3 = {
    Text = "<Block:[Block:Arg1]>pt의 실타래드를 획득한다. 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 [Arg3] 증가한다. 이 스킬은 추가로 [Arg4]%의 치명타율과 치명타 피해 보너스가 적용된다. 보스 전투에서는 피해 횟수가 1회 추가된다."
  },
  Skill_4575_EffectNameList_0 = {
    Text = "실타래드, 피해"
  },
  Skill_4575_Name = {
    Text = "잊혀진 예술"
  },
  Skill_4575_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg5]>pt의 실타래드를 획득한다. 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 [Arg3] 증가한다. 이 스킬은 추가로 [Arg4]%의 치명타율과 치명타 피해 보너스가 적용된다. 보스 전투에서는 피해 횟수가 1회 추가된다. 이번 전투 동안 「잊혀진 예술」과 「타격」이 주는 피해에 실타래드 계수가 100% 추가로 적용된다."
  },
  Skill_4575_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg5]>pt의 실타래드를 획득한다. 전체 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 [Arg3] 증가한다. 이 스킬은 추가로 [Arg4]%의 치명타율과 치명타 피해 보너스가 적용된다. 보스 전투에서는 피해 횟수가 1회 추가된다. 이번 전투 동안 「잊혀진 예술」과 「타격」이 주는 피해에 실타래드 계수가 100% 추가로 적용된다."
  },
  Skill_4575_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4576_AwakerSkillBackgroundStory = {
    Text = "네 머리를 내게 줘. \n그것은 반드시 내가 사랑하는 수집품 중 하나가 되어, 차원의 바다에서 떠돌겠지. \n사냥꾼 해골마녀는 입꼬리를 올리며 무심히 말했다. \n“운이 좋다면, 그것들처럼 언제든 내 곁에 있을 수 있어?”"
  },
  Skill_4576_BattleDesc_0 = {
    Text = "HP가 가장 낮은 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 5배로 적용된다. 다프다엘이 적을 처치할 경우, 이번 스테이지 동안 「목을 자르는 일격」의 기본 피해가 영구적으로 25% 증가한다(현재 [Arg3]회 증가). <TransitionIconKeywords:워프>: HP가 가장 높은 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입히는 효과로 변경된다."
  },
  Skill_4576_Desc_0 = {
    Text = "HP가 가장 낮은 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 5배로 적용된다. 다프다엘이 적을 처치할 경우, 이번 스테이지 동안 「목을 자르는 일격」의 기본 피해가 영구적으로 25% 증가한다. <TransitionIconKeywords:워프>: HP가 가장 높은 적에게 <Damage:[Damage:Arg2]>pt의 피해를 입히는 효과로 변경된다."
  },
  Skill_4576_EffectNameList = {
    Text = "피해, 워프 피해"
  },
  Skill_4576_Name = {
    Text = "목을 자르는 일격"
  },
  Skill_4576_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4577_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg4] 번 입힙니다. [Arg2] 장의 카드에 「깊은 잠수 인장」을 부여합니다: 사용하면 적에게 임시로 <PowerIconKeywords:힘>을 부여합니다."
  },
  Skill_4577_Name = {
    Text = "사냥감 표식"
  },
  Skill_4578_AwakerSkillBackgroundStory = {
    Text = "이것은 그녀가 막아낸 ∞+1번째 공격이다."
  },
  Skill_4578_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TimeBeacon:회귀>: 모든 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시키고, 카드를 1장 뽑으며, 순행·라모나가 광기를 <Energy:[Energy:Arg5]>pt 추가로 획득한다."
  },
  Skill_4578_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 순행·라모나가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TimeBeacon:회귀>: 모든 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시키고, 카드를 1장 뽑으며, 순행·라모나가 광기를 <Energy:[Energy:Arg5]>pt 추가로 획득한다."
  },
  Skill_4578_EffectNameList = {
    Text = "실타래드, 광기, 임시 힘"
  },
  Skill_4578_Name = {Text = "방어"},
  Skill_4578_PropertyNameList = {
    Text = "방어력 * GrowValue1, $GrowValue2, 방어력 * GrowValue3"
  },
  Skill_4579_AwakerSkillBackgroundStory = {
    Text = "마법사가 말했다: “이교도의 수가 많아\n우리 리바넌트는 힘이 부족한 것 같군.\n유우하시 형제여, 너의 나팔을 불어라,\n미친 듯이 싸우자.”\n전사가 대답했다: “여기에는 이교도가 없다.\n너희 모두는 내가 죽일 것이다, 죽은 자는 부족과 신앙을 가리지 않는다.\n그때에는 시체가 계곡을 덮고, 정상에 가득 차,\n그것이 바로 내가 피와 모래의 찬가를 바치는 것이다.”"
  },
  Skill_4579_BattleDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 이번 전투에서 이후 발동하는 「피와 모래의 찬가」의 피해가 [Arg4] 증가하고, 힘 배율이 [Arg3]배 증가한다.] 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 「피와 모래의 찬가」에서 <PowerIconKeywords:힘>이 [Arg2]배 효과를 발휘한다. 유우하시가 <Energy:[Energy:Arg5]>pt의 광기를 획득한다."
  },
  Skill_4579_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 이번 전투에서 이후 발동하는 「피와 모래의 찬가」의 피해량이 [Arg4] 증가하고, 적용되는 힘 계수가 [Arg3]배 증가합니다.]모든 적에게 <Damage:[Damage:Arg1]>의 피해를 입힙니다. <PowerIconKeywords:힘>이 「피와 모래의 찬가」에서 [Arg2]배 효과를 발휘합니다. 우브하시의 광기 충전량의 2배에 해당하는 광기를 획득합니다."
  },
  Skill_4579_EffectNameList = {
    Text = "피해, 피해 증가"
  },
  Skill_4579_Name = {
    Text = "피와 모래의 찬가"
  },
  Skill_4579_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:포식>: 이번 전투에서 이후 발동하는 「피와 모래의 찬가」의 피해가 [Arg4] 증가하고, 힘 배율이 [Arg3]배 증가한다.] 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 「피와 모래의 찬가」에서 <PowerIconKeywords:힘>이 [Arg2]배 효과를 발휘한다. 유우하시가 <Energy:[Energy:Arg5]>pt의 광기를 획득한다. <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>가 부여된 「피여, 소리질러라!」로 손을 가득 채운다. 이번 턴 유우하시의 피해 횟수가 1회 증가한다."
  },
  Skill_4579_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4580_Desc = {
    Text = "자신의 뒤에 「등불」을 1개 소환한다."
  },
  Skill_4580_Name = {
    Text = "성례 의식"
  },
  Skill_4581_AwakerSkillBackgroundStory = {
    Text = "성당 아래에는 숨겨진 공간이 있다. 주교는 석판 앞에 무릎을 꿇고, 창조의 시작에 남겨진 비밀의 말을 읊조린다. 시간에 잊힌 룬이 응답하는 빛을 발하며, 주교의 의지에 따라 거대한 허상을 드러내어 그 빛 아래에 감싸인 이에게 창조주의 「축복」을 내린다."
  },
  Skill_4581_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 임시 <PowerIconKeywords:힘>을 [Power:Arg1]pt 획득하고, 임시 치명타율이 [Arg4]% 증가한다.] 실타래드를 <Block:[Block:Arg2]>pt 획득하고, 전체 적에게 <VulnerabilityIconKeywords:취약>을 1턴간 부여한다. 다음 턴 시작까지, 받은 공격 피해의 [Arg3]%가 핏빛 용광로 회복량으로 전환된다."
  },
  Skill_4581_Desc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 임시 <PowerIconKeywords:힘>을 [Power:Arg1]pt 획득하고, 임시 치명타율이 [Arg4]% 증가한다.] 실타래드를 <Block:[Block:Arg2]>pt 획득하고, 전체 적에게 <VulnerabilityIconKeywords:취약>을 1턴간 부여한다. 다음 턴 시작까지, 받은 공격 피해의 [Arg3]%가 핏빛 용광로 회복량으로 전환된다. 살바도르의 임시 치명타 피해가 [Arg5]% 증가한다."
  },
  Skill_4581_EffectNameList = {
    Text = "임시 힘, 실타래드, 핏빛 용광로 전환량"
  },
  Skill_4581_Name = {
    Text = "창조주의 은총"
  },
  Skill_4581_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: [Power:Arg1] 점 임시 <PowerIconKeywords:힘>을 획득하고, 임시 크리티컬 확률 +[Arg4]%.] <Block:[Block:Arg2]> 점 방어막를 획득합니다. 모든 적에게 1회합 동안 <VulnerabilityIconKeywords:약점>을 부여합니다. 다음 회합 시작까지, 공격을 받을 때 피해의 [Arg6]%를 핏빛 용광로 회복량으로 전환합니다. 살바도르의 \"기초 타격\"과 \"마땅한 고통의 소멸\"이 추가로 100% 힘 보너스를 받습니다. 이번 탐색에서 핏빛 용광로 상한이 최대 HP의 2% 증가하며, 최대 10%까지 증가합니다."
  },
  Skill_4581_OverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 임시 <PowerIconKeywords:힘>을 [Power:Arg1]pt 획득하고, 임시 치명타율이 [Arg4]% 증가한다.] 실타래드를 <Block:[Block:Arg2]>pt 획득하고, 전체 적에게 <VulnerabilityIconKeywords:취약>을 1턴간 부여한다. 다음 턴 시작까지, 받은 공격 피해의 [Arg6]%가 핏빛 용광로 회복량으로 전환된다. 살바도르의 임시 치명타 피해가 [Arg5]% 증가한다. 살바도르의 「기본 타격」과 「응소지고」가 힘 보너스를 100% 추가로 적용받는다. 이번 탐색 동안, 핏빛 용광로 상한이 최대 HP의 2%씩 증가하며, 최대 10%까지 증가한다."
  },
  Skill_4581_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2,$GrowValue3%"
  },
  Skill_4582_BattleDesc = {
    Text = "모든 깨어남체가 <Energy:[Arg1]> 포인트 광기를 획득하고, 다음 턴 시작 시 최대 HP의 5%([Arg3])에 해당하는 <SacrificeKeyWord:희생>을 받습니다."
  },
  Skill_4582_Desc = {
    Text = "모든 깨어남체가 <Energy:[Arg1]> 포인트 광기를 획득하고, 다음 턴 시작 시 최대 HP의 5% <SacrificeKeyWord:희생>을 받습니다."
  },
  Skill_4582_Name = {
    Text = "불멸의 장례식"
  },
  Skill_4584_Desc = {
    Text = "부끄럽지만 어쩔 수 없다. 열쇠를 가져오는 것이 최우선이지 않은가?"
  },
  Skill_4584_Name = {Text = "도주"},
  Skill_4585_AwakerSkillBackgroundStory = {
    Text = "노틸라는 종종 주변에 누군가 있다는 것을 잊곤 해서, 모두에게 많은 불편을 초래했습니다.\n“죄송해요, 일부러 그런 건 아니에요. 지금 바로 메모지를 붙여서 저 자신에게 상기시켜야겠어요—어, 내가 뭘 적으려고 했더라?”\n그래서 모두가 캠퍼스 한 구석에 그녀를 위해 구역을 마련해 주었고, 그곳에서 그녀는 자유롭게 강철을 가공할 수 있었습니다.\n누구도 그녀가 고온 광선을 벽으로 펼치는 일을 할 것이라고는 상상하지 못했습니다."
  },
  Skill_4585_Desc_0 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, 임시 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득한다. 보스 전투에서는 획득하는 임시 <RetaliateIconKeywords:반격>이 3배로 증가한다."
  },
  Skill_4585_EffectNameList_0 = {
    Text = "실타래드, 임시 반격"
  },
  Skill_4585_Name = {
    Text = "고온 주의"
  },
  Skill_4585_PropertyNameList_0 = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4586_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4587_AwakerSkillBackgroundStory = {
    Text = "이것은 그녀가 휘두른 ∞+1번째 검이다."
  },
  Skill_4587_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <TimeBeacon:회귀>: [Arg3]회 피해를 주고, 순행·라모나의 치명타율이 [Arg5]% 증가한다."
  },
  Skill_4587_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 순행·라모나가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <TimeBeacon:회귀>: [Arg3]회 피해를 주고, 순행·라모나의 치명타율이 [Arg5]% 증가한다."
  },
  Skill_4587_EffectNameList = {
    Text = "피해,광기"
  },
  Skill_4587_Name = {Text = "타격"},
  Skill_4587_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4588_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 대상에게 <IntoxicationIconKeywords:중독> [Arg3]스택을 부여한다."
  },
  Skill_4588_Name = {Text = "독소"},
  Skill_4589_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4590_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4591_AwakerSkillBackgroundStory = {
    Text = "반복적으로 어둠에 포식당하는 고통이 그녀의 어둠에 대한 공포를 만들어냈습니다. 눈을 감고 쉬는 잠깐의 순간조차 그녀는 참기 힘들었습니다.\n“비록 웃고 있지만! 당신들은 전혀 모르죠, 그 검은색이…… 검은색이…… 얼마나 무서운지.”"
  },
  Skill_4591_Desc_0 = {
    Text = "윙클이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 윙클이 주는 실타래드와 <RetaliateIconKeywords:반격>이 10% 증가하고, 카드를 사용한 후 <Energy:[Energy:Arg2]>의 광기와 <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득한다."
  },
  Skill_4591_Desc_15 = {
    Text = "윈코르가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 윈코르가 가하는 보호막과 반격이 10% 증가하고, 카드 사용 후 <Energy:[Energy:Arg2]> 광기와 [Counterattack:Arg3] 중첩의 <RetaliateIconKeywords:반격>을 획득한다. 광기가 가장 낮은 다른 깨어남체에게 80 광기를 부여한다."
  },
  Skill_4591_EffectNameList = {
    Text = "광기, 반격"
  },
  Skill_4591_Name = {
    Text = "자아 봉쇄"
  },
  Skill_4591_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4592_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「구걸자」를 소환한다."
  },
  Skill_4592_Name = {
    Text = "분열 타격"
  },
  Skill_4594_Desc = {
    Text = "대상에게 <IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다."
  },
  Skill_4594_Name = {Text = "독소"},
  Skill_4597_Desc = {
    Text = "전체 아군이 <PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_4597_Name = {
    Text = "전체 강화"
  },
  Skill_4598_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4599_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4600_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4601_AwakerSkillBackgroundStory = {
    Text = "“별들과 카다스는 모두 준비가 되었다. 선택받은 권속이여, 너는 재생의 영광을 누릴 것이다…”\n그때부터 그녀의 예술은 오직 하나의 모티프만 남았다.\n그녀는 광상(狂想) 속에서 자유롭게 잊혀지고, 환상 속에서 눈물을 흘렸다."
  },
  Skill_4601_Desc_0 = {
    Text = "산이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한이 1 증가한다. 산이 주는 실타래드가 [Arg3]% 증가한다. 산이 실타래드를 줄 때마다 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가한다."
  },
  Skill_4601_Desc_15 = {
    Text = "산이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한이 1 증가한다. 산이 주는 실타래드와 최종 피해가 [Arg3]% 증가하며, 영구 촉수 1개당 추가로 3% 증가한다. 산이 실타래드를 줄 때마다 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가한다."
  },
  Skill_4601_EffectNameList = {
    Text = "광기, 촉수 피해"
  },
  Skill_4601_Name = {
    Text = "무아의 경지"
  },
  Skill_4601_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4602_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 모든 신도를 흡수한다."
  },
  Skill_4602_Name = {
    Text = "영원한 고통"
  },
  Skill_4603_AwakerSkillBackgroundStory = {
    Text = "이 녹색 불꽃은 이미 그녀의 일부가 되었습니다. \n그녀가 이끄는 곳 어디서든 불을 붙일 수 있습니다."
  },
  Skill_4603_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4603_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입힙니다. <Energy:[Energy:Arg2]> 광기를 획득하고, 피해량의 [Arg3]%만큼 <IntoxicationIconKeywords:중독>을 부여합니다."
  },
  Skill_4603_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 리즈가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4603_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입힙니다. 리즈가 <Energy:[Energy:Arg2]> 광기를 획득하고, 피해량의 [Arg3]%만큼 <IntoxicationIconKeywords:중독>을 부여합니다."
  },
  Skill_4603_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4603_Name = {Text = "타격"},
  Skill_4603_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4604_AwakerSkillBackgroundStory = {
    Text = "\"오지에, 정말 착한 아이구나. 자라서 내 딸의 기사가 되어주지 않겠니? —— 그녀가 너를 무척 좋아하단다.\"\n\n\"자작가의 아이로군? 기사단은 어리다고 훈련을 줄여주지는 않아.\"\n\n\"잘하고 있군! 아무래도, 오지에는 미래에 공주님으로부터 직접 서임받겠구나.\"\n\n\"뒤로 물러서지 마, 별궁을 사수해! 누구도 공주님께 가까이 가지 못하게 해!\"\n\n\"고맙다, 오지에…... 됐어, 이제 내가 너를 지킬게…...\""
  },
  Skill_4604_Desc_0 = {
    Text = "오지에가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: [Power:Arg3]pt의 <PowerIconKeywords:힘>을 획득하고, 오지에가 카드를 사용한 후 [Power:Arg2]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4604_Desc_15 = {
    Text = "오지에가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: [Power:Arg3]pt의 <PowerIconKeywords:힘>을 획득하고, 오지에가 카드를 사용한 후 [Power:Arg2]pt의 <PowerIconKeywords:힘>을 획득한다. 이번 전투에서 죽음 저항 발동 후, 오지에의 광기 폭발로 획득하는 임시 <PowerIconKeywords:힘>이 3배로 증가한다."
  },
  Skill_4604_EffectNameList = {
    Text = "광기, 힘, 카드당 힘 획득"
  },
  Skill_4604_Name = {
    Text = "기사의 열정"
  },
  Skill_4604_PropertyNameList = {
    Text = "$GrowValue1,공격력*GrowValue3,공격력*GrowValue2"
  },
  Skill_4605_Desc = {
    Text = "무작위 깨어남체에게 임시 봉인 1스택을 부여한다. 이 효과를 2회 반복한다."
  },
  Skill_4605_Name = {Text = "봉인"},
  Skill_4606_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4607_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 [Arg2]배로 적용되며, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_4607_EffectNameList = {Text = "피해"},
  Skill_4607_Name = {
    Text = "천면환상"
  },
  Skill_4607_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4608_Desc = {Text = "없음"},
  Skill_4609_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다. 적의 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>의 절반을 제거한다."
  },
  Skill_4609_Name = {
    Text = "강자의 법칙"
  },
  Skill_4610_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4610_Name = {
    Text = "허약의 일격"
  },
  Skill_4611_Desc = {
    Text = "모든 깨어남체가 광기 20을 획득한다. 「분열 환자」를 기절시킨다."
  },
  Skill_4611_Name = {
    Text = "진정시키는 종"
  },
  Skill_46128_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「다차원 존재」를 소환한다."
  },
  Skill_46128_Name = {
    Text = "차원 분할"
  },
  Skill_46129_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「다차원 존재」를 소환한다."
  },
  Skill_46129_Name = {
    Text = "차원 분할"
  },
  Skill_4612_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_46130_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 자신은 <Block:[Block:Arg2]>의 실타래드를 획득한다."
  },
  Skill_46130_Name = {
    Text = "전체 강화"
  },
  Skill_46131_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_46135_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4613_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4614_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4615_AwakerSkillBackgroundStory = {
    Text = "파인트는 불완전하다. \n파인트는 위험하다. \n파인트는 저주받았다. \n파인트, 가장 기묘하고 다채로운 별들에서 온 한 줄기 색채이다."
  },
  Skill_4615_BattleDesc_15 = {
    Text = "파인트가 <Energy:[Energy:Arg1]> 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 즉시 모든 적의 <PowerIconKeywords:힘>을 [Arg4] 포인트 영구 탈취합니다. [Counterattack:Arg3] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 이번 전투에서 죽음 저항 발동 감쇠율이 50%에서 45%로 감소합니다. 파인트가 카드를 사용할 때, 모든 적의 <PowerIconKeywords:힘>을 [Arg2] 포인트 <TouquKeywords:탈취>합니다. 턴 종료 시, 앞줄 적에게 50% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  Skill_4615_Desc_0 = {
    Text = "파인트가 <Energy:[Energy:Arg1]> 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: [Counterattack:Arg3] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 이번 전투에서 죽음 저항 발동 감쇠율이 50%에서 45%로 감소합니다. 파인트가 카드를 사용할 때, 모든 적의 <PowerIconKeywords:힘>을 [Arg2] 포인트 <TouquKeywords:탈취>합니다. 턴 종료 시, 앞줄 적에게 50% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  Skill_4615_Desc_15 = {
    Text = "파인트가 <Energy:[Energy:Arg1]> 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: 즉시 모든 적의 <PowerIconKeywords:힘>을 [Arg4] 포인트 영구 탈취합니다. [Counterattack:Arg3] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 이번 전투에서 죽음 저항 발동 감쇠율이 50%에서 45%로 감소합니다. 파인트가 카드를 사용할 때, 모든 적의 <PowerIconKeywords:힘>을 [Arg2] 포인트 <TouquKeywords:탈취>합니다. 턴 종료 시, 앞줄 적에게 50% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  Skill_4615_EffectNameList = {
    Text = "광기, 반격, 힘 탈취"
  },
  Skill_4615_Name = {
    Text = "무한한 별빛"
  },
  Skill_4615_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue3, 공격력*GrowValue2"
  },
  Skill_4616_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 방어되지 않은 피해를 입혔을 때 피해량의 3배만큼 HP를 회복한다. [Arg2]턴간 지속된다. 전진."
  },
  Skill_4616_Name = {
    Text = "수술 준비"
  },
  Skill_4617_AwakerSkillBackgroundStory = {
    Text = "선원들의 절망 어린 통곡 속에서도, 그녀는 고요히 응시하며 기다릴 뿐이었다. 고요하던 수면에 기포가 일더니 거대한 촉수가 솟아올라 순식간에 돛대를 옭아매었고, 이내 바닷바람을 맞으며 거대한 새 돛자락으로 펼쳐졌다. 「출항! 출항하라!」 선원들이 노래했다. 「우리는 환영 속에서 닻을 올리리라!」"
  },
  Skill_4617_Desc = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg2] 증가하고, 전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다. 촉수 1개가 적을 공격하여 [Arg3]%의 촉수 피해를 준다."
  },
  Skill_4617_EffectNameList = {
    Text = "회복, 임시 촉수 피해"
  },
  Skill_4617_Name = {
    Text = "영원한 환상"
  },
  Skill_4617_PropertyNameList = {
    Text = "체질*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4618_AwakerSkillBackgroundStory = {
    Text = "당신은 어느 순간 자신이 모든 스포트라이트의 중심, 우주의 중심, 신의 총애를 받은 자라고 느낀 적이 있나요? \n라이커에게는 밑장을 살짝 들여다보고 당당히 공개하는 순간이었습니다."
  },
  Skill_4618_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 1~[Arg4]회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 피해 횟수가 6회 이상일 경우, <DepleteIconKeywords:소모>가 부여된 행동력 소모 0의 「뜻밖의 수확」 1장을 손에 넣는다."
  },
  Skill_4618_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 1~[Arg4]회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 치명타 발생 시마다 추가로 <Energy:[Arg3]>pt의 광기를 획득한다. 피해 횟수가 6회 이상일 경우, <DepleteIconKeywords:소모>가 부여된 행동력 소모 0의 「뜻밖의 수확」 1장을 손에 넣는다."
  },
  Skill_4618_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4618_Name = {
    Text = "승부의 순간"
  },
  Skill_4618_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4620_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4621_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여하고, 덱과 버린 카드 더미에서 무작위 카드 [Arg2]장에 「<SlowIconKeywords:둔화>」를 부여한다."
  },
  Skill_4621_Name = {
    Text = "둔화 침식"
  },
  Skill_4622_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 방어되지 않은 피해를 입힐 때마다 <FragileIconKeywords:손상> 1스택을 부여한다."
  },
  Skill_4622_Name = {
    Text = "영원한 사냥"
  },
  Skill_4624_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4625_Desc = {
    Text = "행동력 1pt를 획득하고, 「증상: 히스테리」 1장을 버린 카드 더미에 넣는다. 판매 불가."
  },
  Skill_4625_Name = {
    Text = "증상: 히스테리"
  },
  Skill_4626_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 덱과 버린 카드 더미의 모든 카드에게 「<SlowIconKeywords:둔화>」와 「<RetainKeywords:유지>」을 부여한다."
  },
  Skill_4626_Name = {
    Text = "영겁의 눈"
  },
  Skill_4627_AwakerSkillBackgroundStory = {
    Text = "아첨자가 연민을 구할 때, 자만하지 마세요.\n 아첨자가 응시할 때, 부끄러워하지 마세요.\n 아첨자가 포옹할 때, 도망치지 마세요.\n 아첨자가 생각하고 행동하는 것은 오직 유일한 종착점으로 향할 뿐이며, 그곳에는 당신의 자리가 없고, 오직 물결처럼 몰아치는 슬픔과 타락만이 있습니다."
  },
  Skill_4627_BattleDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4627_BattleDesc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4627_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, 힘을 [Power:Arg2]pt 획득한다."
  },
  Skill_4627_Desc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4627_EffectNameList = {
    Text = "회복, 힘"
  },
  Skill_4627_Name = {
    Text = "아첨의 포옹"
  },
  Skill_4627_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 손실타래된 HP의 [Arg4]%를 회복합니다(<Heal:[Arg3]>). 자신의 <VulnerabilityIconKeywords:약점> 상태를 해제합니다.] <Heal:[Heal:Arg1]> 점 HP를 회복합니다. [Power:Arg5] 점 <PowerIconKeywords:힘>을 획득합니다. 모든 깨어남체의 크리티컬 확률과 크리티컬 피해 +[Arg6]%."
  },
  Skill_4627_OverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg5]pt 획득한다. 모든 깨어남체의 치명타율과 치명타 피해가 [Arg6]% 증가한다."
  },
  Skill_4627_PropertyNameList = {
    Text = "체질*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4627_tempBattleDesc_1 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4627_tempBattleDesc_2 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4627_tempBattleDesc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg2]pt, <PowerIconKeywords:임시 힘>을 [Power:Arg7]pt 획득한다."
  },
  Skill_4627_tempOverLimitUtlSkillDesc_1 = {
    Text = "[<DevouredIconKeywords:포식>: 손실타래된 HP의 [Arg4]%를 회복합니다(<Heal:[Arg3]>). 자신의 <VulnerabilityIconKeywords:약점> 상태를 해제합니다.] <Heal:[Heal:Arg1]> 점 HP를 회복합니다. [Power:Arg5] 점 <PowerIconKeywords:힘>을 획득합니다. 모든 깨어남체의 크리티컬 확률과 크리티컬 피해 +[Arg6]%."
  },
  Skill_4627_tempOverLimitUtlSkillDesc_2 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg5]pt 획득한다. 모든 깨어남체의 치명타율과 치명타 피해가 [Arg6]% 증가한다."
  },
  Skill_4627_tempOverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:포식>: 잃은 HP의 [Arg4]%(<Heal:[Arg3]>)를 회복하고, 자신의 <VulnerabilityIconKeywords:취약> 상태를 해제한다. 이번 「아첨의 포옹」으로 획득하는 힘이 2배로 증가한다.] HP를 <Heal:[Heal:Arg1]>pt 회복하고, <PowerIconKeywords:힘>을 [Power:Arg5]pt, <PowerIconKeywords:임시 힘>을 [Power:Arg7]pt 획득한다. 모든 깨어남체의 치명타율과 치명타 피해가 [Arg6]% 증가한다."
  },
  Skill_4628_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg3]회 입히고, 광란 1스택을 획득한다."
  },
  Skill_4629_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 준다. 방어되지 않은 피해를 입힐 때마다 <FragileIconKeywords:손상> 1스택을 부여한다."
  },
  Skill_4629_Name = {Text = "사냥"},
  Skill_4630_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4631_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4632_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 방어되지 않은 피해를 입혔을 때 피해량의 3배만큼 HP를 회복한다. [Arg2]턴간 지속된다."
  },
  Skill_4632_Name = {
    Text = "수술 준비"
  },
  Skill_4633_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, <DerivativeCardKeywords_32:「끈적이는 밀랍」> 1장을 덱에 섞어 넣는다."
  },
  Skill_4633_Name = {
    Text = "수술 준비"
  },
  Skill_4634_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4635_AwakerSkillBackgroundStory = {
    Text = "어떤 고대의 힘이 머피의 몸에서 부활했다. \n심어진 씨앗은 날이 갈수록 헛된 꽃봉오리로 자라났다. \n“이런 힘을 받았으니, 내 진짜 실타래력을 똑똑히 보여주겠다!”"
  },
  Skill_4635_Desc = {
    Text = "1턴 동안, 전체 적의 피해가 [Arg1]% 감소하지만, 자신이 공격을 받을 때 받은 피해의 절반만큼 <SacrificeKeyWord:희생>을 부여한다. 실타래드를 <Block:[Block:Arg2]>pt 획득하고, 모든 촉수가 1회 공격한다."
  },
  Skill_4635_EffectNameList = {
    Text = "실타래드"
  },
  Skill_4635_Name = {
    Text = "허망의 계승자"
  },
  Skill_4635_OverLimitUtlSkillDesc = {
    Text = "1턴 동안, 전체 적의 피해가 [Arg1]% 감소하지만, 자신이 공격을 받을 때 받은 피해의 절반만큼 <SacrificeKeyWord:희생>을 부여한다. <Block:[Block:Arg2]>의 실타래드를 획득하고, 모든 촉수가 1회 공격한다. 3턴 동안 매 턴 시작 시, <Block:[Block:Arg3]>의 실타래드를 획득하고 <TentacleInjurieIconKeywords:촉수 피해>가 [Arg4] 증가하며, 임시 촉수 2개를 생성한다."
  },
  Skill_4635_PropertyNameList = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4636_Desc = {
    Text = "이 카드를 뽑을 때, 행동력 1을 잃고 카드를 1장 드로우한다."
  },
  Skill_4636_Name = {Text = "미혹"},
  Skill_4637_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4638_AwakerSkillBackgroundStory = {
    Text = "온전한 철강으로 만들어진 날카로운 칼날은 무겁고, 공기를 가를 때 발생하는 기류는 심지어 바위를 부술 수 있습니다.\n 나의 충성스러운 동료, 나의 믿음직한 거대한 칼이여, 우리는 모두 어둠에서 신생과 무한한 힘을 얻었습니다. 오늘 밤, 우리는 적의 피를 마음껏 마시고; 오늘 밤, 우리는 마음껏 살육할 것입니다."
  },
  Skill_4638_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이 피해에는 <PowerIconKeywords:힘>이 [Arg2]배로 적용된다. 이 카드는 「타격」으로 간주한다."
  },
  Skill_4638_EffectNameList = {Text = "피해"},
  Skill_4638_Name = {
    Text = "거대한 검의 위엄"
  },
  Skill_4638_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4639_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4641_Desc_0 = {
    Text = "무작위 적에게 <Damage:[Damage:Arg2]>의 피해를 [Arg1]회 준다."
  },
  Skill_4641_EffectNameList = {Text = "피해"},
  Skill_4641_Name = {
    Text = "쥐 떼 돌격"
  },
  Skill_4641_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_46420_Desc_1 = {
    Text = "대상 한 명에게 [Arg1]스택 <PVPEntanglementKeywords:엉킴>을 부여한다."
  },
  Skill_46420_Name_1 = {Text = "엉킴"},
  Skill_4642_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 모든 손패를 버린다."
  },
  Skill_4642_Name = {Text = "해체"},
  Skill_46431_Desc_1 = {
    Text = "대상 하나에게 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:출혈> 피해를 부여한다."
  },
  Skill_46431_Name_1 = {
    Text = "지연 피해"
  },
  Skill_46432_Desc_1 = {
    Text = "대상 하나에게 <DelayKeywords:지연>을 부여합니다: <Block:[Block:Arg1]> 방어막."
  },
  Skill_46432_Name_1 = {
    Text = "지연 실타래드"
  },
  Skill_46433_Desc_1 = {
    Text = "대상 한 명에게 <PVPEmptinessKeywords:공허> 1스택을 부여한다."
  },
  Skill_46433_Name_1 = {Text = "공허"},
  Skill_4643_AwakerSkillBackgroundStory = {
    Text = "“아니, 아니. 이건 창작의 논리가 아니야.”\n조각가는 낮은 목소리로 말했지만, 젊은 제자의 눈을 직접 바라보진 못했다.\n그 눈은 얼마나 아름다운가...\n세상의 끝 바다처럼 고요하여, 죽어가는 철새의 몸부림을 모두 담아내고 있었다.\n그녀는 모든 것을 알고 있었지만, 침묵을 지켰다."
  },
  Skill_4643_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 촉수 [Arg2]개를 획득한다. <RippleKeywords:여파>: 광기를 <Energy:[Energy:Arg4]>pt 획득한다."
  },
  Skill_4643_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 촉수 1개당 실타래드가 [Arg3]pt 추가로 획득한다. 촉수 [Arg2]개를 획득한다. <RippleKeywords:여파>: 광기를 <Energy:[Energy:Arg4]>pt 획득한다."
  },
  Skill_4643_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 촉수 [Arg2]개를 획득한다. <RippleKeywords:여파>: 현재 촉수 수만큼의 광기를 획득한다."
  },
  Skill_4643_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 촉수 1개당 실타래드가 [Arg3]pt 추가로 획득한다. 촉수 [Arg2]개를 획득한다. <RippleKeywords:여파>: 현재 촉수 수만큼의 광기를 획득한다."
  },
  Skill_4643_EffectNameList_0 = {
    Text = "실타래드"
  },
  Skill_4643_EffectNameList_2 = {
    Text = "실타래드, 촉수당 실타래드"
  },
  Skill_4643_Name = {
    Text = "미의 자비"
  },
  Skill_4643_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,"
  },
  Skill_4643_PropertyNameList_2 = {
    Text = "방어력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4644_AwakerSkillBackgroundStory = {
    Text = "항구를 떠나는 배는 바람 속에서 길을 잃고, 무리에서 벗어난 짐승이 거대한 파도를 일으킨다.\n 그녀의 광기는 몇 차례 인류 문명의 존속에 영향을 미쳤지만, 그녀는 결코 신경 쓰지 않았습니다.\n 짐승에게는 서식지를 되찾는 것보다 더 중요한 일이 없으니까요."
  },
  Skill_4644_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해와 동일한 양의 <IntoxicationIconKeywords:중독>을 부여하며, 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다. 임시 촉수 [Arg2]개를 생성하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가한다."
  },
  Skill_4644_EffectNameList = {
    Text = "피해, 촉수 피해"
  },
  Skill_4644_Name = {
    Text = "광열의 바다"
  },
  Skill_4644_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4645_BattleDesc = {
    Text = "HP를 [Arg1] 잃고, 모든 깨어남체가 광기 10을 획득한다. 판매 불가."
  },
  Skill_4645_Desc = {
    Text = "최대 HP의 10%를 잃고, 모든 깨어남체가 광기 10을 획득한다. 판매 불가."
  },
  Skill_4645_Name = {
    Text = "증상: 광기"
  },
  Skill_4646_AwakerSkillBackgroundStory = {
    Text = "결투에서는 일반적으로 방어 자세가 필요하지 않으며, 맹렬한 공격이 바로 최고의 방어다."
  },
  Skill_4646_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4646_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 로탄이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4646_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4646_Name = {Text = "타격"},
  Skill_4646_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4647_Desc = {
    Text = "더 이상 쓸모가 없다. 버리거나 사용할 때 <DepleteIconKeywords:소모>를 부여한다."
  },
  Skill_4647_Name = {Text = "돌"},
  Skill_4648_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4649_Desc = {
    Text = "사망 시, 자신과 동일한 HP를 가진 「융식 삼각 밀랍상」 2개로 분열한다."
  },
  Skill_4649_Name = {Text = "분열"},
  Skill_4650_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4650_Name = {
    Text = "질식의 고통"
  },
  Skill_4651_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 기생 [Arg3]스택을 부여한다."
  },
  Skill_4651_Name = {Text = "뼈 침식"},
  Skill_4652_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 맨 위의 카드 [Arg3]장에게 「<SlowIconKeywords:둔화>」와 「<PrepareKeywords:예비>」를 부여한다."
  },
  Skill_4652_Name = {
    Text = "정체의 저주"
  },
  Skill_4653_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4653_Name = {
    Text = "수술 절단"
  },
  Skill_4654_Desc = {
    Text = "실타래드를 [Arg1]pt 획득한다. 릴리가 소환한 점액 실타래드는 지옥견의 찢기 공격을 단 한 번만 막아낼 수 있다. 정말… 아프지 않은 걸까?"
  },
  Skill_4654_Name = {
    Text = "시들지 않는 진흙 속의 꽃"
  },
  Skill_4655_AwakerSkillBackgroundStory = {
    Text = "바다는 깊고 고요하며, 생에 대한 갈망과 죽음에 대한 공포를 품고 있습니다.\n 그러나 누군가는 웃음과 장난으로 바다를 가득 채우고 싶어합니다. 오레타가 그런 초대를 할 때, “그녀와 함께 한바탕 떠들어도 괜찮지 않을까”라는 기분이 항상 마음속에 밀려오고, 자연스럽게 사소한 기쁨이 가슴을 가득 채우게 됩니다."
  },
  Skill_4655_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 입힌다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다."
  },
  Skill_4655_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 덱과 버린 카드 더미에서 「선체 분열」을 최대 10장까지 소모하며, 소모한 장당 추가로 1회 피해를 준다. 「선체 분열」 2장을 손에 넣는다. 오레타가 이번 전투에서 이후에 주는 피해가 [Arg2] 증가한다."
  },
  Skill_4655_EffectNameList = {
    Text = "피해, 후속 피해 증가"
  },
  Skill_4655_Name = {
    Text = "소란스러운 바다"
  },
  Skill_4655_OverLimitUtlSkillDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> 점 데미지를 가합니다. 덱과 버린 카드 더미에서 「선체 분열」 카드를 최대 10장 소모하며, 장당 1회 추가 데미지를 가합니다. 「선체 분열」 2장을 손패에 추가합니다. 「오레타」가 이번 전투에서 이후 가하는 데미지가 [Arg2] 점 증가합니다. [Power:Arg2] 점 <PowerIconKeywords:힘>과 [TentaclePower:Arg2] 점 <TentacleInjurieIconKeywords:터치손상>을 획득하며, 이후 「선체 분열」을 5회 사용할 때마다 카드 1장을 뽑습니다."
  },
  Skill_4655_OverLimitUtlSkillDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>만큼 <PunctureDamagewords:관통 피해>를 입힙니다. 뽑기 덱과 버림 패에서 최대 10장「선체 분열」을 소모하고, 각 카드는 추가로 1회의 피해를 입힙니다. 2장의「선체 분열」을 손에 넣습니다.「오리타」가 이번 전투에서 후속으로 입히는 피해를 [Arg2]만큼 증가시킵니다. [Power:Arg2]점의 <PowerIconKeywords:힘>과 [TentaclePower:Arg2]점의 <TentacleInjurieIconKeywords:촉수 피해>를 얻고, 이후 5회「선체 분열」을 사용하면 카드 1장을 뽑습니다."
  },
  Skill_4655_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4656_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4657_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]pt를 획득하고 <Block:[Block:Arg2]>의 실타래드를 획득한다."
  },
  Skill_4657_Name = {
    Text = "전체 강화"
  },
  Skill_4658_AwakerSkillBackgroundStory = {
    Text = "카시아의 양손이 비어있다.\n카시아의 모자도 텅 비어 있다;\n카시아의 가슴도 텅 비어있다.\n비어있는 카시아가 비어있는 행복을 담고 있다. 빈 무대에서 빈 공연을 진행하다."
  },
  Skill_4658_Desc_0 = {
    Text = "카시아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 카시아가 카드를 1장 사용할 때마다 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득한다."
  },
  Skill_4658_Desc_15 = {
    Text = "카시아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 카시아가 카드를 1장 사용할 때마다 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득하며, 모든 깨어남체가 「타격」을 사용할 때에도 해당 효과가 발동되어 임시 힘을 획득한다."
  },
  Skill_4658_EffectNameList = {
    Text = "광기, 힘"
  },
  Skill_4658_Name = {
    Text = "오프닝 공연"
  },
  Skill_4658_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4659_AwakerSkillBackgroundStory = {
    Text = "— 하지만 아직 너는 너무 약해서 제대로 보호하지 않으면 안 되지."
  },
  Skill_4659_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4659_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 로탄이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4659_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4659_Name = {Text = "방어"},
  Skill_4659_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4659_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_4659_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>의 실타래드를 획득하고, <Energy:[Energy:Arg2]>의 광기를 획득한다. 이번 턴에 다음 1장의 「오만의 검」이 2회 발동한다."
  },
  Skill_4660_AwakerSkillBackgroundStory = {
    Text = "하나 둘 하나 둘……\n그녀는 손에 쟁반을 들고 경쾌한 리듬에 맞춰 인파 속을 누비고 있다.\n손님들은 한 순간도 쉬지 않고 술을 마시고 노래를 부르며, 그녀는 한 순간도 멈추지 않고 요리를 서빙하고 미소를 짓고 있다.\n여기 모든 것이 금색이다. 금색의 로비, 금색의 포도주, 그리고 금색의 치마자락.\n카렌은 금색을 좋아한다. 그녀는 수없이 연습한 시그니처 미소를 지었다.\n“손님, 천천히 드세요——!!”"
  },
  Skill_4660_Desc_0 = {
    Text = "모든 손패의 <SlowIconKeywords:둔화> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복한다. <DerivativeCardKeywords_42:「기묘한 요리」> 1장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여한다."
  },
  Skill_4660_Desc_3 = {
    Text = "모든 손패의 <SlowIconKeywords:둔화> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복한다. <DerivativeCardKeywords_42:「기묘한 요리」> 1장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여한다."
  },
  Skill_4660_EffectNameList = {
    Text = "회복, 중독"
  },
  Skill_4660_Name = {
    Text = "맛있게 드세요!"
  },
  Skill_4660_OverLimitUtlSkillDesc_0 = {
    Text = "모든 손패의 <SlowIconKeywords:둔화> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복한다. <DerivativeCardKeywords_42:「기묘한 요리」> 1장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여한다. <DerivativeCardKeywords_42:「기묘한 요리」>를 드로우 덱과 버린 카드 더미에 각 1장씩 섞는다."
  },
  Skill_4660_OverLimitUtlSkillDesc_3 = {
    Text = "모든 손패의 <SlowIconKeywords:둔화> 상태를 해제하고, HP를 <Heal:[Heal:Arg1]>pt 회복한다. <DerivativeCardKeywords_42:「기묘한 요리」> 1장을 손에 넣고, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여한다. <DerivativeCardKeywords_42:「기묘한 요리」>를 드로우 덱과 버린 카드 더미에 각 1장씩 섞는다."
  },
  Skill_4660_PropertyNameList = {
    Text = "체질*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4661_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 임시 <RetaliateIconKeywords:반격> [Arg3]스택을 획득한다."
  },
  Skill_4661_Name = {
    Text = "꿀빛 비극의 환상"
  },
  Skill_4662_AwakerSkillBackgroundStory = {
    Text = "사람들은 그녀의 미모에 감탄하고 고혹적인 매력을 흠모했지만, 그 누구도 아직 피지 않은 꽃봉오리를 대수롭게 여기지 않았다. 들판에서 위태롭게 흔들리던 어린 꽃망울의 미래는 타인의 손에 제멋대로 좌우되었고, 그저 정원사의 출세를 위한 장기말로 취급받았다. 마침내 그녀가 왕관 앞에서 화려하게 만개했을 때야 비로소, 사람들은 자신들이 이미 날카로운 가시에 찢겨 피투성이가 되었음을 깨닫고 경악했다"
  },
  Skill_4662_BattleDesc_0 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 턴 종료 시 <Heal:[Heal:Arg2]>pt의 HP를 회복한다."
  },
  Skill_4662_BattleDesc_2 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, 피해를 1회 입힐 때마다 임시 치명타율이 5% 증가한다. 턴 종료 시 <Heal:[Heal:Arg2]>pt의 HP를 회복한다."
  },
  Skill_4662_Desc_0 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 턴 종료 시 <Heal:[Heal:Arg2]>pt의 HP를 회복한다."
  },
  Skill_4662_Desc_2 = {
    Text = "무작위로 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, 피해를 1회 입힐 때마다 임시 치명타율이 5% 증가한다. 턴 종료 시 <Heal:[Heal:Arg2]>pt의 HP를 회복한다."
  },
  Skill_4662_EffectNameList_0 = {
    Text = "피해, 회복"
  },
  Skill_4662_Name = {
    Text = "장미의 아름다움"
  },
  Skill_4662_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 체질*GrowValue2"
  },
  Skill_4663_AwakerSkillBackgroundStory = {
    Text = "차가운 기계가 심장을 대체하고, 유압관 안의 기름이 피를 대체했다. 그녀는 차갑고 이성적이며 명령에 따라 행동해야 했다.\n 그러나, 외부의 의지가 그녀의 육체 안에서 조용히 움직이고 있었다. 그는 피도 필요 없고, 온도도 필요 없으며, 오직 자신만으로 비인간적인 악의를 불태울 수 있다. 그는 말했다: 복종하라, 천박하고 약한 생물아, 그리고 나의 뜨거운 전구 속에서 파멸하라."
  },
  Skill_4663_BattleDesc_0 = {
    Text = "<PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. <Posse:[Arg2]>의 열쇠 에너지를 획득한다. 자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_14:「기계 무장-수축」>으로 변환된다."
  },
  Skill_4663_BattleDesc_1 = {
    Text = "<PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. <Posse:[Arg2]>의 열쇠 에너지를 획득한다. 자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. <DepleteIconKeywords:소모>가 부여된 에리카의 「타격」 1장을 손에 넣는다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_14:「기계 무장-수축」>으로 변환된다."
  },
  Skill_4663_Desc_0 = {
    Text = "<PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. 에리카의 은열쇠 충전과 동일한 양의 열쇠 에너지를 획득한다. 자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_14:「기계 무장-수축」>으로 변환된다."
  },
  Skill_4663_Desc_1 = {
    Text = "<PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. 에리카의 은열쇠 충전과 동일한 양의 열쇠 에너지를 획득한다. 자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. <DepleteIconKeywords:소모>가 부여된 에리카의 「타격」 1장을 손에 넣는다. 카드가 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_14:「기계 무장-수축」>으로 변환된다."
  },
  Skill_4663_EffectNameList_0 = {
    Text = "힘, 경계"
  },
  Skill_4663_EffectNameList_1 = {
    Text = "힘, 경계, 「타격」 레벨"
  },
  Skill_4663_Name = {
    Text = "기계 무장-전개"
  },
  Skill_4663_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4663_PropertyNameList_1 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2,$GrowValue3"
  },
  Skill_4664_AwakerSkillBackgroundStory = {
    Text = "형체 없는 전염병이 조용히 다가와 끝없는 고통과 광기를 가져옵니다. 비숍은 밤을 새워 사람들의 고통을 덜어줄 수 없다는 것에 대해 무한한 슬픔을 느낍니다. “자비로운 창조주여, 그들을 구원해 주시고, 제가 그들의 모든 고통과 슬픔을 대신 지겠습니다.” 그러자 아버지 신이 그에게 「축복」을 내리시고, 그가 신언이 새겨진 석판을 지니게 하여 고통을 없애고 어려움을 덜어주는 일을 하게 하셨습니다."
  },
  Skill_4664_Desc_0 = {
    Text = "살바도르가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: <B02AFKeyWord:인애로 보호하기> 1장을 손에 넣는다. 턴 종료 후, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_4664_Desc_15 = {
    Text = "살바도르가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: <B02AFKeyWord:인애의 수호> 1장을 손에 넣는다. 라운드 종료 후, [Power:Arg2] 의 <PowerIconKeywords:힘>을 획득한다. 「조주의 비호」와 「축복 골혈」이 축적하는 진홍 용광로가 25% 증가하고, 「응소지고」에서 「초도」를 선택할 때 최대 생명력 1%의 진홍 용광로를 소모할 때마다 증가하는 최종 피해 효과가 2%에서 5%로 증가한다."
  },
  Skill_4664_EffectNameList = {
    Text = "광기, 힘"
  },
  Skill_4664_Name = {
    Text = "「축복」"
  },
  Skill_4664_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_4665_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4665_Name = {
    Text = "봉제품의 광기"
  },
  Skill_4666_AwakerSkillBackgroundStory = {
    Text = "“흠, 이 몸께서 너를 제대로 교육해 주겠어.”"
  },
  Skill_4666_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4666_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득하며, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가한다."
  },
  Skill_4666_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 머피가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4666_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 머피가 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가한다."
  },
  Skill_4666_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4666_EffectNameList_2 = {
    Text = "피해, 광기, 촉수 피해"
  },
  Skill_4666_Name = {Text = "타격"},
  Skill_4666_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4666_PropertyNameList_2 = {
    Text = "공격력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_4667_AwakerSkillBackgroundStory = {
    Text = "그것은 모든 차원을 초월한 거대한 미궁이다. 미궁에 잘못 발을 들인 여행자는 하나의 불손한 거래를 마주해야만 한다. 「아니오」라고 답한다면, 여행자는 영원히 미궁에 갇히게 된다. 「예」라고 답한다면, 여행자의 육신에는 불경한 씨앗이 심어지고 모든 기억을 말소당하게 된다. 뭐라고, 거래의 구체적인 내용이 무엇이냐고? 거래의 정확한 내용은 아무도 알지 못한다. 심지어 저 창백한 미궁의 주인조차도. 거래는, 그저 거래일 뿐이다."
  },
  Skill_4667_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: <PowerIconKeywords:힘> [Power:Arg1]pt, <AlertIconKeywords:경계> [Arg4]pt를 획득한다.] 실타래드를 <Block:[Block:Arg2]>pt 획득하고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg3]스택을 부여한다."
  },
  Skill_4667_EffectNameList = {
    Text = "힘, 경계, 실타래드, 중독"
  },
  Skill_4667_Name = {
    Text = "창백한 보호"
  },
  Skill_4667_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: <PowerIconKeywords:힘> [Power:Arg1]pt, <AlertIconKeywords:경계> [Arg4]pt를 획득한다.] <Block:[Block:Arg2]>의 실타래드를 획득하고, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg3]스택을 부여한다. 「타격」과 「방어」가 아닌 아그리파의 명령 카드를 2장 드로우한다. 손에 있는 「타격」과 「방어」가 아닌 아그리파의 명령 카드 2장의 행동력 소모를 이번 턴 동안 1 감소시킨다."
  },
  Skill_4667_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue4, 방어력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4668_AwakerSkillBackgroundStory = {
    Text = "그는 자신이 거의 죽을 뻔했다는 사실타래을 받아들일 수 없다. 그는 무적이어야 하며, 금강불괴여야 한다. 만약 인간의 육체가 그가 힘의 정점에 오르는 데 방해가 된다면, 육체를 버리겠다; 만약 부족한 사람들을 버리는 것이 그의 강함을 가져온다면, 과거를 묻어버리겠다.\n 그는 거대한 검을 심해에 던져 비인간적인 힘을 빌려, 모든 것의 정복자가 되겠다고 맹세했다.\n 그에게 힘을 준 존재조차도 미래에는 반드시 그의 발 아래 누워 있을 것이다."
  },
  Skill_4668_Desc = {
    Text = "<O06_AFKeyWord1:찬탈> 또는 <O06_AFKeyWord2:잠복> 중 하나를 선택한다. <DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣는다."
  },
  Skill_4668_EffectNameList = {Text = "임시 힘"},
  Skill_4668_Name = {
    Text = "해연의 힘"
  },
  Skill_4668_OverLimitUtlSkillDesc = {
    Text = "<O06_AFKeyWord1:찬탈> 또는 <O06_AFKeyWord2:잠복> 중 하나를 선택한다. 「찬탈」 선택 시, <DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣으며, 해당 카드의 기본 피해가 400% 증가하고 행동력 소모가 0이 된다. 「잠복」 선택 시, 「거대한 검의 위엄」을 넣지 않고, 「참수의 일격」 2장을 손에 넣으며, 「소모」, 「예비1」, 「유지」를 부여한다."
  },
  Skill_4669_AwakerSkillBackgroundStory = {
    Text = "그녀는 감정의 매개체이며, 정서의 연속입니다. \n이 진한 잉크를 흘려보내세요, 이 시적 재능을 낭비하게 하세요. \n이 세상에서 입으로 표현되지 않은 말들은 그녀의 시집에서 시작될 것입니다."
  },
  Skill_4669_Desc_0 = {
    Text = "올라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 즉시 현재 감정 외 다른 감정의 <D06CardKeyWord1:은유> 1스택을 획득하며, 매 턴 시작 시에도 1스택을 획득한다. 각 <D06CardKeyWord1:은유>는 최대 3스택까지 가능하며, <D06CardKeyWord1:은유> 1스택당 시편 <TransitionIconKeywords:워프> 시 해당 <D06CardKeyWord1:은유>를 소모하고 추가 보너스를 획득한다."
  },
  Skill_4669_Desc_15 = {
    Text = "올라가 <Energy:[Energy:Arg1]> 광기를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 즉시 현재 감정 외 다른 감정의 <D06CardKeyWord1:은유> 1층을 획득하고, 매 라운드 시작 시에도 1층을 획득합니다. 각 <D06CardKeyWord1:은유>는 최대 3층이며, <D06CardKeyWord1:은유> 1층마다 시편 <TransitionIconKeywords:도약> 시 해당 <D06CardKeyWord1:은유>를 소모하고 추가 보너스를 획득합니다. 소멸 발동 후 올라의 이번 라운드 다음 지령 카드가 도약 효과를 발동합니다. 올라가 은유를 3층 이상 소모할 때마다 현재 감정 오라 효과를 일시적으로 [Arg2]% 증가시키며, 이 효과는 중첩되지 않습니다."
  },
  Skill_4669_EffectNameList = {Text = "광기"},
  Skill_4669_Name = {
    Text = "시집 서문"
  },
  Skill_4670_Desc = {
    Text = "사망 시, 자신과 동일한 HP를 가진 「Ⅱ형 융식체」 3개로 분열한다."
  },
  Skill_4670_Name = {Text = "분열"},
  Skill_4672_Desc = {
    Text = "현재 HP와 실타래드를 이전 턴 종료 시의 상태로 되돌린다."
  },
  Skill_4672_Name = {
    Text = "과거의 메아리"
  },
  Skill_4673_Desc = {
    Text = "대상에게 <IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다."
  },
  Skill_4673_Name = {Text = "독소"},
  Skill_4674_Desc = {
    Text = "모든 증상 카드를 <DerivativeCardKeywords_37:「질식」>으로 변경한다. 질식: 비용 1, 턴 종료 시 손에 남아있으면 자신에게 <IntoxicationIconKeywords:중독> [Arg1]pt를 부여한다."
  },
  Skill_4674_Name = {
    Text = "잊혀진 고난의 바다"
  },
  Skill_4675_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_24:「열상」> 2장을 손에 넣는다."
  },
  Skill_4675_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_4676_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_4677_Desc = {
    Text = "행동력 1pt를 획득하고, 카드를 1장 드로우한다."
  },
  Skill_4677_Name = {Text = "영감"},
  Skill_4678_AwakerSkillBackgroundStory = {
    Text = "그는 적을 짓밟을 기회를 결코 놓치지 않는다."
  },
  Skill_4678_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4678_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 유우하시가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4678_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4678_Name = {Text = "타격"},
  Skill_4678_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4680_AwakerSkillBackgroundStory = {
    Text = "산바람이 미로의 해골 속에서 바스락거리고, 애절한 소리를 내고 있다.\n 그녀는 먼 곳에서 길을 잃은 여행자의 애가를 듣고 팔천 번째 하품을 했다.\n 그녀는 고통을 음미한 후, 그것들을 하나하나 분류하고 진열했다.\n 오직 하나의 질문이 있다. 아무도 그녀의 걸작을 알지 못하고, 그녀는 여기서 유일한 관객이다.\n 아!\n 그녀는 미로의 가장 깊은 곳에 앉아 또 한 번 하품을 했다."
  },
  Skill_4680_Desc_0 = {
    Text = "아그리파가 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 아그리파가 부여하는 <IntoxicationIconKeywords:중독>이 50% 증가하고, 턴 종료 후 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4680_Desc_15 = {
    Text = "아그리파가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 아그리파가 부여하는 <IntoxicationIconKeywords:중독>이 100% 증가하고, 라운드 종료 후 <Block:[Block:Arg2]> 보호막을 획득하며, 매 라운드 아그리파가 중독을 가하거나 발동할 때마다 해당 보호막이 50% 증가한다. 최대 5중첩."
  },
  Skill_4680_EffectNameList = {
    Text = "광기, 실타래드"
  },
  Skill_4680_Name = {
    Text = "방황의 길"
  },
  Skill_4680_PropertyNameList = {
    Text = "$GrowValue1, 방어력*GrowValue2"
  },
  Skill_4681_Desc = {
    Text = "장기전이 밀경의 주목을 끌었다… 증상 카드 1장을 영구적으로 덱에 넣는다."
  },
  Skill_4681_Name = {Text = "응시"},
  Skill_4682_Desc = {
    Text = "깨어남체 4명의 광기 폭발을 1턴간 봉인한다."
  },
  Skill_4682_Name = {Text = "봉인"},
  Skill_4683_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4683_Name = {Text = "명멸"},
  Skill_4685_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고 후퇴한다."
  },
  Skill_4686_AwakerSkillBackgroundStory = {
    Text = "“슬픔과 고통 외에는 이 잔인한 폭력이 어떤 도움도 가져올 수 없다. 언젠가 그것은 끝나야만 한다.”"
  },
  Skill_4686_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4686_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이번 전투에서 핏빛 용광로 축적량이 2만큼 누적될 때마다 피해가 [Float:Arg3] 증가한다. <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4686_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 살바도르가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4686_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이번 전투에서 핏빛 용광로 축적량이 2만큼 누적될 때마다 피해가 [Float:Arg3] 증가한다. 살바도르가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4686_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4686_Name = {Text = "타격"},
  Skill_4686_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4687_Desc = {
    Text = "턴 종료 시 손에 있을 경우, 손에 있는 모든 카드를 <DerivativeCardKeywords_25:「돌」>로 변경한다. 버릴 때 <DepleteIconKeywords:소모>를 부여한다."
  },
  Skill_4687_Name = {
    Text = "석화 진행"
  },
  Skill_4688_Desc = {
    Text = "<MadnessIconKeywords:광란> [Arg1]스택을 획득하고, <DerivativeCardKeywords_9:「비틀거림」> [Arg2]장을 덱에 섞어 넣는다."
  },
  Skill_4688_Name = {Text = "광란"},
  Skill_4689_Desc = {
    Text = "<MadnessIconKeywords:광란> [Arg1]스택을 획득하고, <DerivativeCardKeywords_9:「비틀거림」> [Arg2]장을 덱에 섞어 넣는다."
  },
  Skill_4689_Name = {Text = "광란"},
  Skill_4690_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4691_Desc = {
    Text = "카드 4장을 드로우한다."
  },
  Skill_4691_Name = {
    Text = "불평등한 교환"
  },
  Skill_4692_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_4693_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4693_Name = {
    Text = "오만의 검"
  },
  Skill_4694_AwakerSkillBackgroundStory = {
    Text = "어두운 신문 감옥에서 렌티니언이 어디에나 있는 밀랍은 또한 귀한 것이다.\n 귀하니 중요한 곳에 사용해야 한다. 예를 들어 징벌할 때, 불량한 아이의 피부에 사용해야 한다.\n 특별히 제작된 밀랍은 아니지만 떨어질 때 비참한 비명소리가 함께하지만, 소녀의 귀에는 우아한 시가처럼 들린다."
  },
  Skill_4694_BattleDesc_0 = {
    Text = "<RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득한다. 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시키고, 적 1명당 <PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. 전체 적의 <RetaliateIconKeywords:반격>을 제거한다."
  },
  Skill_4694_BattleDesc_2 = {
    Text = "<RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득한다. 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg1]pt 감소시키고, 적 1명당 <PowerIconKeywords:임시 힘> [Power:Arg1]pt를 획득한다. 전체 적의 <RetaliateIconKeywords:반격>을 제거한다. <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_4694_Desc_0 = {
    Text = "<RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득한다. 전체 적의 <PowerIconKeywords:힘> [Arg1]pt를 <TouquKeywords:탈취>하고, 전체 적의 <RetaliateIconKeywords:반격>을 제거한다."
  },
  Skill_4694_Desc_2 = {
    Text = "<RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득한다. 전체 적의 <PowerIconKeywords:힘> [Arg1]pt를 <TouquKeywords:탈취>하고, 전체 적의 <RetaliateIconKeywords:반격>을 제거한다. <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_4694_EffectNameList = {
    Text = "힘 탈취, 반격"
  },
  Skill_4694_Name = {
    Text = "뜨거운 밀랍의 욕망"
  },
  Skill_4694_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4695_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_33:「살려줘」> 1장을 손에 넣는다."
  },
  Skill_4695_Name = {Text = "살려줘"},
  Skill_4697_Desc = {
    Text = "<MadnessIconKeywords:광란> [Arg1]스택을 획득한다."
  },
  Skill_4697_Name = {
    Text = "전투의 욕망"
  },
  Skill_4698_Desc = {
    Text = "기도 [Arg1]스택을 획득한다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택을 잃고, 턴 종료 시 모두 사라진다."
  },
  Skill_4698_Name = {Text = "기도"},
  Skill_4701_AwakerSkillBackgroundStory = {
    Text = "그것은 왜곡된 태아, 죄악의 씨앗이다. \n 두근거리는 심장박동, 넘실타래대는 맥박, 골혈이 반목하며 운명이 역으로 얽혀 있다. \n 생성물은 선택의 자유가 없으며 그녀는 역행하는 임신이 진행되도록 내버려 둘 수밖에 없다."
  },
  Skill_4701_Desc_0 = {
    Text = "머피가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 머피가 카드를 사용한 후 촉수 상한을 무시하는 임시 촉수 1개와 행동력 소모 1pt에 해당하는 은열쇠 충전을 획득한다. 매 턴 최대 3회 발동한다."
  },
  Skill_4701_Desc_15 = {
    Text = "머피가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 머피가 카드를 사용한 후 촉수 상한을 무시하는 임시 촉수 1개와 행동력 소모 1pt에 해당하는 은열쇠 충전을 획득한다. 매 턴 최대 3회 발동한다. 머피가 매 턴 처음 사용하는 「나선소멸역류」의 피해 횟수와 「성녀작성」의 행동력 획득량이 2배가 된다."
  },
  Skill_4701_EffectNameList = {Text = "광기"},
  Skill_4701_Name = {
    Text = "만들어진 존재"
  },
  Skill_4702_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_4702_Name = {
    Text = "석질 분해"
  },
  Skill_4703_AwakerSkillBackgroundStory = {
    Text = "주인을 보호합니다. 주인을 보호합니다. 주인을 보호합니다. \n상처투성이가 되더라도 명령을 끝까지 실타래행하겠습니다. \n적은 강하지만 더 큰 금지 구역을 펼치고, 몸이 아파도 명령을 철저히 관철시키겠습니다."
  },
  Skill_4703_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고 모든 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg2]스택을 부여한다. 다음 턴 시작까지, 공격을 1회 받을 때마다 <PainWord:인내> [Arg3]스택을 획득한다."
  },
  Skill_4703_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고 모든 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg2]스택을 부여한다. 다음 턴 시작까지, 공격을 1회 받을 때마다 <PainWord:인내> [Arg3]스택을 획득한다. HP가 50%([Arg4]) 미만일 경우 실타래드를 1회 추가로 획득하고, 부여하는 중독이 2배로 증가한다."
  },
  Skill_4703_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고 모든 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg2]스택을 부여한다. 릴리의 죽음 저항 1%당 기본 실타래드 획득량이 0.25% 증가한다. 다음 턴 시작까지, 공격을 1회 받을 때마다 <PainWord:인내> [Arg3]스택을 획득한다."
  },
  Skill_4703_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고 모든 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg2]스택을 부여한다. 릴리의 죽음 저항 1%당 기본 실타래드 획득량이 0.25% 증가한다. 다음 턴 시작까지, 공격을 1회 받을 때마다 <PainWord:인내> [Arg3]스택을 획득한다. HP가 50% 미만일 경우 실타래드를 1회 추가로 획득하고, 부여하는 중독이 2배로 증가한다."
  },
  Skill_4703_EffectNameList = {
    Text = "실타래드, 중독, 인내"
  },
  Skill_4703_Name = {
    Text = "금지된 검은 늪"
  },
  Skill_4703_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2, 방어력*GrowValue3"
  },
  Skill_4704_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4705_Desc = {
    Text = "「강신 의식」 상태를 획득하여 매 턴 힘이 증가한다. <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>, <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하고, 「집착」 3장을 덱에 넣는다."
  },
  Skill_4705_Name = {
    Text = "강신 의식·부름"
  },
  Skill_4706_Desc = {
    Text = "실타래드를 [Arg2]pt 획득하고, 「악의적 방혈」 상태를 획득한다. 「악의적 방혈」: 방어되지 않은 피해를 1회 줄 때마다 <BleedingIconKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_4706_Name = {
    Text = "항해 요리"
  },
  Skill_4707_Desc = {
    Text = "릴리는 매 턴마다 플레이어가 사용한 첫 번째 깨어남체 카드를 모방한다."
  },
  Skill_4707_Name = {Text = "깨어남"},
  Skill_47090_Desc_1 = {
    Text = "이 카드의 카드면에는 특수 효과가 있다!"
  },
  Skill_47090_Name_1 = {Text = "효과3"},
  Skill_47091_Desc_1 = {
    Text = "이 카드의 카드면에는 특수 효과가 있다!"
  },
  Skill_47091_Name_1 = {Text = "효과2"},
  Skill_47092_Desc_1 = {
    Text = "이 카드의 카드면에는 특수 효과가 있다!"
  },
  Skill_47092_Name_1 = {Text = "효과1"},
  Skill_4709_Desc = {
    Text = "깨어남체 1명을 선택하여, 그 깨어남체의 명령 카드를 각 1장씩 손에 넣는다. 수호자와 은열쇠의 공명이 깨어남체들에게 지속적으로 전투할 용기를 불어넣었다…"
  },
  Skill_4709_Name = {
    Text = "은열쇠 공명"
  },
  Skill_4710_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 데미지를 [AttackTimes:Arg2] 회 입히고, [Arg3] 포인트의 임시 <PowerIconKeywords:힘>을 감소시키며, 턴 종료 시 제거됩니다."
  },
  Skill_4711_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4712_Desc = {
    Text = "<DerivativeCardKeywords_32:「끈적이는 밀랍」> 1장을 상대의 덱에 섞어 넣는다."
  },
  Skill_4712_Name = {
    Text = "성대한 접대"
  },
  Skill_4713_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신은 <MadnessIconKeywords:광란> [Arg2]스택을 획득한다."
  },
  Skill_4714_AwakerSkillBackgroundStory = {
    Text = "징계, 단지 그의 무수한 권능 중 가장 작은 하나일 뿐이다."
  },
  Skill_4714_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이 피해에는 [Arg4]%의 촉수 피해 보너스와 힘 보너스가 추가로 적용된다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4714_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스와 <PowerIconKeywords:힘> 보너스가 추가로 적용된다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4714_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 툴루가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이 피해에는 [Arg4]%의 촉수 피해 보너스와 힘 보너스가 추가로 적용된다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4714_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 툴루가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스와 <PowerIconKeywords:힘> 보너스가 추가로 적용된다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4714_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4714_EffectNameList_2 = {
    Text = "피해, 광기, 임시 촉수 피해, 임시 힘"
  },
  Skill_4714_Name = {Text = "타격"},
  Skill_4714_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4714_PropertyNameList_2 = {
    Text = "공격력*GrowValue1,$GrowValue2, 공격력*GrowValue3, 공격력*GrowValue3"
  },
  Skill_4715_AwakerSkillBackgroundStory = {
    Text = "주요 재료: 블루 치즈, 인도 카레, 신선한 개구리 다리 적당량 준비 단계: 재료를 혼합하여 일주일 동안 절이고, 토탄 술 1온스를 주입합니다. 기타: 플레이팅이 중요합니다. 로즈메리를 미소 모양으로 조형하세요. 꼭 기억하세요, 꼭 기억하세요!"
  },
  Skill_4715_Desc = {
    Text = "HP를 <Heal:[Heal:Arg2]>pt 회복한다. 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg1]스택 부여하고, 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4715_EffectNameList_0 = {
    Text = "중독, 회복"
  },
  Skill_4715_Name = {
    Text = "개구리 스튜"
  },
  Skill_4715_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 체질*GrowValue2"
  },
  Skill_4716_AwakerSkillBackgroundStory = {
    Text = "가속 페달, 브레이크, 정상; 연료탱크, 정상; 엔진 상태, 양호.\n 그녀는 출발할 준비가 되었고, 모험할 준비가 되었고, 다가오는 모든 미지를 맞이할 준비가 되었다.\n 외발 자전거가 그녀의 아래에서 굉음을 내며, 어두운 궤도가 고속으로 회전하며 초월적인 속도로 앞으로 나아갔다."
  },
  Skill_4716_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 방어막과 [Counterattack:Arg2] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 현재 방어막을 50% 증가시킵니다. 모든 적에게 [Arg3]% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  Skill_4716_Desc_3 = {
    Text = "<Block:[Block:Arg1]> 방어막과 [Counterattack:Arg2] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 현재 방어막을 50% 증가시킵니다. 모든 적에게 [Arg3]% <RetaliateIconKeywords:반격>을 발동합니다. 자신이 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>에 1턴 동안 면역됩니다."
  },
  Skill_4716_EffectNameList_0 = {
    Text = "실타래드, 반격"
  },
  Skill_4716_Name = {
    Text = "출격 준비 완료"
  },
  Skill_4716_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 방어막과 [Counterattack:Arg2] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 방어막 상한을 무시하고 현재 방어막을 50% 증가시킵니다. 모든 적에게 [Arg4]% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  Skill_4716_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]> 방어막과 [Counterattack:Arg2] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 방어막 상한을 무시하고 현재 방어막을 50% 증가시킵니다. 모든 적에게 [Arg4]% <RetaliateIconKeywords:반격>을 발동합니다. 자신이 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>에 1턴 동안 면역됩니다."
  },
  Skill_4716_PropertyNameList_0 = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4718_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4718_Name = {
    Text = "뜻밖의 사망"
  },
  Skill_4719_AwakerSkillBackgroundStory = {
    Text = "인간의 몸으로 걷는 데 익숙해진 후, 로탄은 자신에게 맞는 무기를 찾는 데 오랜 시간을 보냈다. 지금까지도 그녀는 이 쌍검들이 자신과 어울린다고 생각하지 않으며, 그냥 적당히 사용하고 있을 뿐이다."
  },
  Skill_4719_Desc_0 = {
    Text = "무작위 적 1명에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입힌다. 이번 턴에 「타격」을 1장 사용할 때마다 이 카드의 행동력 소모가 1 감소한다."
  },
  Skill_4719_Desc_1 = {
    Text = "무작위 적 1명에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히며, 「타격」으로 간주한다. 이번 턴에 「타격」을 1장 사용할 때마다 이 카드의 행동력 소모가 1 감소한다."
  },
  Skill_4719_EffectNameList_0 = {Text = "피해"},
  Skill_4719_Name = {
    Text = "오만의 검"
  },
  Skill_4719_PropertyNameList_0 = {
    Text = "공격력*GrowValue1"
  },
  Skill_4720_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_23:「상처」> [Arg3]장을 넣는다."
  },
  Skill_4720_Name = {
    Text = "상처 입히기"
  },
  Skill_4721_AwakerSkillBackgroundStory = {
    Text = "대사제가 되었을 때, 미리암은 이 단검을 선물로 받았습니다."
  },
  Skill_4721_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입힙니다. 100%의 <TentacleInjurieIconKeywords:촉수 피해> 계수가 적용됩니다. <Energy:[Energy:Arg2]> 광기를 획득합니다. <O07CardKeyWord:의식>: 최종 피해량이 [Arg4]%/[Arg5]%/[Arg6]% 증가합니다."
  },
  Skill_4721_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입힙니다. 100%의 <TentacleInjurieIconKeywords:촉수 피해> 계수가 적용됩니다. 미리암이 <Energy:[Energy:Arg2]> 광기를 획득합니다. <O07CardKeyWord:의식>: 최종 피해량이 [Arg4]%/[Arg5]%/[Arg6]% 증가합니다."
  },
  Skill_4721_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4721_Name = {Text = "타격"},
  Skill_4721_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4722_AwakerSkillBackgroundStory = {
    Text = "천만 년의 고독 속에서, 그 사람의 출현은 심해에 갑자기 비치는 어슴푸레한 빛과 같아서, 오랫동안 잠잠했던 해저를 불태웠다. \n공정한 대결을 위해, 로탄은 기꺼이 인간의 형태로 자신을 낮추며, 상대의 성장을 은근히 기다린다 —— 그녀는 통쾌한 전투를 갈망해 왔으며, 이미 너무나도 오랜 시간이 흘렀다."
  },
  Skill_4722_Desc_0 = {
    Text = "로탄이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 로탄의 피해 횟수가 [Arg2]회 증가한다."
  },
  Skill_4722_Desc_15 = {
    Text = "로탄이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 로탄의 피해 횟수가 [Arg2]회 증가한다. 로탄의 「방어」는 이번 턴의 다음 「오만의 검」이 2회 발동하게 한다."
  },
  Skill_4722_EffectNameList = {Text = "광기"},
  Skill_4722_Name = {
    Text = "전투의 욕망"
  },
  Skill_4723_Desc = {
    Text = "「사냥의 표식」 1스택당 실타래드를 [Arg2]pt 획득한다."
  },
  Skill_4723_Name = {
    Text = "차지 에코"
  },
  Skill_4724_Desc = {
    Text = "모든 적의 임시 힘을 [Arg2]pt 감소시키고, <DerivativeCardKeywords_26:증상:「망상」> 1장을 손에 넣는다. \"아파? 정말 불쌍하구나… 울어도 돼!\""
  },
  Skill_4724_Name = {Text = "절규"},
  Skill_4725_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4726_Desc = {
    Text = "광기가 가장 높은 깨어남체에게 임시 봉인 1스택을 부여하고, <Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입힌다."
  },
  Skill_4726_Name = {Text = "봉인"},
  Skill_4727_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4727_Name = {Text = "깨물기"},
  Skill_4728_AwakerSkillBackgroundStory = {
    Text = "나는 인간으로서의 모든 것을 버렸다! 나는 심해의 품으로 돌아갈 것이다!\n 하지만 왜 내 변화는 실타래패했는가?\n 운명의 조롱인가? 아니면 나의 어리석음인가?\n 광란의 카이커스는 부서진 창을 끌어안고 바다 속으로 가라앉으려 했다.\n 돌아갈 수만 있다면, 받아들여진다면, 앞으로 얼마나 많은 장애물이 있든 그는 하나하나 치워버릴 것이다."
  },
  Skill_4728_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고 동일한 양의 <RetaliateIconKeywords:반격>을 획득한다. 이 피해에는 50%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다."
  },
  Skill_4728_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고 동일한 양의 <RetaliateIconKeywords:반격>을 획득한다. 이 피해에는 50%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다. <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4728_EffectNameList_0 = {Text = "피해"},
  Skill_4728_EffectNameList_1 = {
    Text = "피해, 광기"
  },
  Skill_4728_Name = {
    Text = "파쇄된 장창"
  },
  Skill_4728_PropertyNameList_0 = {
    Text = "공격력*GrowValue1"
  },
  Skill_4728_PropertyNameList_1 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4729_AwakerSkillBackgroundStory = {
    Text = "“네, 나는 그렇게 그녀에게 약속한 적이 있습니다.”\n고국이 멸망했던 그 날을 언급하자, 어린 왕의 표정은 더욱 지쳐 보였다.\n“나는 그 말이 그녀가 죽기 전의 공포를 위로해 주길 바랐을 뿐, 그녀가 그것을 규칙으로 삼아……”"
  },
  Skill_4729_Desc_0 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 현재 자세가 「정해」일 경우, 이번 턴 동안 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시킨다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4729_Desc_3 = {
    Text = "자신의 <WeaknessIconKeywords:허약> 상태를 해제한다. 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가하고, 임시 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 임시 치명타율이 [Arg2]% 증가한다. 현재 자세가 「정해」일 경우, 이번 턴 동안 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시킨다. <RippleKeywords:여파>: 촉수 1개가 적을 공격한다."
  },
  Skill_4729_EffectNameList_0 = {
    Text = "임시 촉수 피해, 임시 힘, 힘 감소"
  },
  Skill_4729_Name = {
    Text = "레무리아의 재림"
  },
  Skill_4729_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4731_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <TouquKeywords:영구 탈취>로 <PowerIconKeywords:힘> [Arg3]pt를 획득한다."
  },
  Skill_4731_Name = {
    Text = "차지 에코"
  },
  Skill_4732_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4733_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈>을 [Arg1]스택 부여한다."
  },
  Skill_4733_Name = {Text = "출혈"},
  Skill_4734_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg2]스택을 부여한다. 다른 적이 남아있을 경우, 자신을 희생하여 해당 적에게 기생하며, 「기생됨」 상태를 부여한다."
  },
  Skill_4734_Name = {Text = "기생"},
  Skill_4735_Desc = {
    Text = "<WeaknessIconKeywords:허약> [Arg1]스택을 부여하고, 덱과 버린 카드 더미의 맨 위에서 [Arg3]장의 카드에게 「<SlowIconKeywords:둔화>」와 「<PrepareKeywords:예비>」를 부여한다."
  },
  Skill_4735_Name = {
    Text = "영겁의 눈"
  },
  Skill_4736_Desc = {
    Text = "「등불」 2개를 소환한다."
  },
  Skill_4736_Name = {Text = "소환"},
  Skill_4737_Desc = {
    Text = "기도 스택을 전부 소모하며, 소모한 스택마다 <BleedingIconKeywords:출혈>을 [Arg1]씩 부여한다."
  },
  Skill_4737_Name = {
    Text = "융식의 포옹"
  },
  Skill_4738_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4739_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_4740_AwakerSkillBackgroundStory = {
    Text = "빛을 향하는 본능이 날벌레에게 빛을 쫓아가게 하지만, 그 장명등화는 너무 눈부셔서 사람들은 종종 물결 아래 숨겨진 격렬한 흐름을 간과하게 된다……"
  },
  Skill_4740_Desc = {
    Text = "이번 턴 동안 촉수 피해를 입힌 후, 전체 적에게 <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여한다."
  },
  Skill_4740_EffectNameList = {Text = "중독"},
  Skill_4740_Name = {
    Text = "깊은 암류"
  },
  Skill_4740_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4741_Desc = {
    Text = "턴 종료 시 해당 카드를 드로우한 후 남은 행동력이 2pt 이상일 경우, 다음 턴 시작 시 카드 2장을 추가로 드로우한다."
  },
  Skill_4741_Name = {
    Text = "증상: 흥분"
  },
  Skill_4742_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_4742_Name = {Text = "강화"},
  Skill_4743_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4744_AwakerSkillBackgroundStory = {
    Text = "그녀는 본래 굽히기를 원치 않았으나, 가장 완벽한 복수는 언제나 잠깐의 인내심이 필요하다."
  },
  Skill_4744_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4744_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt와 임시 치명타율 25%를 획득한다."
  },
  Skill_4744_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 히로가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4744_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 히로가 광기를 <Energy:[Energy:Arg2]>pt와 임시 치명타율 25%를 획득한다."
  },
  Skill_4744_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4744_Name = {Text = "방어"},
  Skill_4744_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_47455_Desc_1 = {
    Text = "대상 한 명에게 <StrengthenKeywords:모래주머니>를 부여한다."
  },
  Skill_47455_Name_1 = {
    Text = "모래주머니"
  },
  Skill_4745_AwakerSkillBackgroundStory = {
    Text = "두 개의 의지가 기계의 몸 안에서 끊임없이 대립하며 갈등한다. 하나는 파괴를 원하고, 다른 하나는 굴복하지 않으려 한다. 하지만 작은 인간이 오래도록 승리할 수는 없다. 그녀는 결국 상대에게 삼켜져, 오직 파괴를 위해 존재하는 광기의 그릇이 되고 말 것이다.\n그래서 그녀는 모든 전류를 방출한다. 거대한 전기 아크가 그녀의 몸을 뒤덮으며, 단락된 몸에서 전류의 폭음이 울려 퍼진다. 그녀는 모아둔 에너지를 앞으로 던지고, 곧 일시적으로 시스템 마비 상태에 빠진다.\n「움직일 수 없다면, 파괴할 수도 없다.」"
  },
  Skill_4745_Desc_0 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, [Arg3]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4745_Desc_2 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, [Arg3]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 이 스킬에는 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>가 [Arg7]배로 적용된다."
  },
  Skill_4745_EffectNameList_0 = {
    Text = "피해, 실타래드"
  },
  Skill_4745_Name = {
    Text = "전자기 폭발"
  },
  Skill_4745_OverLimitUtlSkillDesc_0 = {
    Text = "에리카가 [Arg4]% 임시 크리티컬 확률과 크리티컬 피해를 획득합니다. <Block:[Block:Arg6]> 점 방어막를 획득합니다. 모든 적에게 <Damage:[Damage:Arg5]> 데미지를 가하고 [Arg3] 스택의 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:약점>을 부여합니다. 에리카의 「기초 타격」이 1회 추가 데미지를 가하고, 「기본 방어」가 1회 추가 방어막를 획득하며, 3회합 동안 지속됩니다."
  },
  Skill_4745_OverLimitUtlSkillDesc_2 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg6]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg5]>pt의 피해를 주고, [Arg3]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 이 스킬에는 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>가 [Arg7]배로 적용된다. 에리카의 「타격」이 추가로 1회 피해를 주고, 「방어」가 추가로 1회 실타래드를 획득한다. 3턴 동안 지속된다."
  },
  Skill_4745_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4745_tempBattleDesc_1 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, [Arg3]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_4745_tempBattleDesc_2 = {
    Text = "에리카가 임시 크리티컬 확률과 크리티컬 피해를 [Arg4]% 획득합니다. <Block:[Block:Arg2]>의 방어막을 획득합니다. 모든 적에게 <Damage:[Damage:Arg1]>의 피해를 입히고, [Arg3]스택 <WeaknessIconKeywords:약화>와 <VulnerabilityIconKeywords:취약>을 부여합니다. 이 스킬에 [Arg7]배 <PowerIconKeywords:힘>과 <AlertIconKeywords:경비> 보너스가 추가로 적용됩니다."
  },
  Skill_4745_tempBattleDesc_3 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg3]스택 부여한다. 이 스킬에는 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>가 [Arg7]배로 적용되며, 이후 발동 시 적용되는 힘과 경계 보너스가 추가로 1배 증가한다."
  },
  Skill_4745_tempOverLimitUtlSkillDesc_1 = {
    Text = "에리카가 [Arg4]% 임시 크리티컬 확률과 크리티컬 피해를 획득합니다. <Block:[Block:Arg6]> 포인트 방어막를 획득합니다. 모든 적에게 <Damage:[Damage:Arg5]> 데미지를 입히고 [Arg3] 층 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:약점>을 부여합니다. 에리카의 「기초 타격」이 추가로 1회 데미지를 입히고, 「기본 방어」가 추가로 1회 방어막를 획득하며, 3턴 동안 지속됩니다."
  },
  Skill_4745_tempOverLimitUtlSkillDesc_2 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg6]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg5]>pt의 피해를 주고, <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg3]스택 부여한다. 이 스킬에는 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>가 [Arg7]배로 적용된다. 에리카의 「기본 타격」이 추가로 1회 피해를 주고, 「기본 방어」가 추가로 1회 실타래드를 획득한다. 3턴 동안 지속된다."
  },
  Skill_4745_tempOverLimitUtlSkillDesc_3 = {
    Text = "에리카의 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 실타래드를 <Block:[Block:Arg6]>pt 획득한다. 모든 적에게 <Damage:[Damage:Arg5]>pt의 피해를 주고, <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg3]스택 부여한다. 이 스킬에는 <PowerIconKeywords:힘>과 <AlertIconKeywords:경계>가 [Arg7]배로 적용되며, 이후 발동 시 적용되는 힘과 경계 보너스가 추가로 1배 증가한다. 에리카의 「기본 타격」이 추가로 1회 피해를 주고, 「기본 방어」가 추가로 1회 실타래드를 획득한다. 3턴 동안 지속된다."
  },
  Skill_4746_Desc = {
    Text = "모든 적의 임시 힘을 [Arg2]pt 감소시키고, <DerivativeCardKeywords_28:증상:「붕괴」> 1장을 손에 넣는다. \"아파? 정말 불쌍하구나… 울어도 돼!\""
  },
  Skill_4746_Name = {Text = "절규!!"},
  Skill_4747_Desc = {
    Text = "장기전이 밀경의 주목을 끌었다… <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「분노」 상태를 획득한다. 적의 힘이 지속적으로 증가할 것이다!"
  },
  Skill_4747_Name = {Text = "모독"},
  Skill_47484_Desc = {
    Text = "행동력 2pt를 획득하고, 카드를 2장 드로우한다."
  },
  Skill_47484_Name = {
    Text = "고급 영감"
  },
  Skill_4748_AwakerSkillBackgroundStory = {
    Text = "아이들은 천천히 동화의 본질을 꿰뚫어 보고, 신화 뒤에 숨겨진 우화를 이해하게 됩니다. 인간의 언어로 이 과정을 '성장'이라고 부릅니다.\n 하지만 어떤 아이들은 잠자리에서 듣던 그 이야기를 더욱 믿게 되고, 고집스럽게 하늘에 정말로 무지개 다리가 있고, 정말로 문명이 심해에 잠겼다고 생각합니다.\n 오레타는 이러한 이야기를 좋아하며, 더 많은 친구들과 이 기쁨을 나누고 싶어합니다."
  },
  Skill_4748_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 모든 손패를 버리고, 버린 장수만큼 카드 X장을 드로우한다. 「선체 분열」 1장을 버린 카드 더미에 넣는다."
  },
  Skill_4748_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다. 모든 손패를 버리고, 버린 장수 + 1장의 카드를 드로우한다. 「선체 분열」 1장을 버린 카드 더미에 넣는다."
  },
  Skill_4748_EffectNameList = {
    Text = "촉수 피해, 선체 분열 레벨"
  },
  Skill_4748_Name = {
    Text = "친구의 힘"
  },
  Skill_4748_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4749_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4750_AwakerSkillBackgroundStory = {
    Text = "잉태하라, 태어나라, 번식하라.\n 점점 용해되는 현실타래 속에서, 어두운 세계로 들어서며, 곧 신생할 허공 속에서.\n 너희의 존재는 어머니의 희생의 열매이자, 어머니를 유지하게 하는 원인이다.\n 신성한 자식들아, 새 세계에서 다시 태어나라. 그 순결한, 모든 공포가 사라진 새 세계에서 다시 태어나라."
  },
  Skill_4750_Desc_0 = {
    Text = "타이스가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 즉시 <DerivativeCardKeywords_10:성결의 자식> 1장을 획득한다. 열쇠 지령을 발동할 때마다, 손에 있는 「배아」 1개를 <DerivativeCardKeywords_10:성결의 자식>으로 변환한다."
  },
  Skill_4750_Desc_15 = {
    Text = "타이스가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 즉시 <DerivativeCardKeywords_10:성결의 자식> 1장을 획득한다. 열쇠 지령을 발동할 때마다, 손에 있는 「배아」 1개를 <DerivativeCardKeywords_10:성결의 자식>으로 변환한다. 「풍요의 의식」이 추가로 복사본 1장을 손에 넣는다."
  },
  Skill_4750_EffectNameList = {Text = "광기"},
  Skill_4750_Name = {
    Text = "어머니의 부름"
  },
  Skill_47516_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 다른 깨어남체의 [Arg1]장의 카드를 버리며, 성공적으로 버리면 [Arg2]장의 카드를 드로우한다."
  },
  Skill_47516_Name_1 = {
    Text = "은빛 물고기의 결심"
  },
  Skill_4751_AwakerSkillBackgroundStory = {
    Text = "눈을 깜빡이지 말고, 자세히 보세요, 마법의 순간이 왔습니다;\n흰 장갑, 검은 모자, 다채로운 카드 제가 허공에서 만들어냈습니다.\n리본처럼 화려하고, 반짝이처럼 찬란한,\n이 환상적이고 광란의 빛나는 공연, 당신은 절대 추측할 수 없을 거예요!"
  },
  Skill_4751_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 카드 [Arg2]장을 드로우한다. 카시아의 명령 카드를 1장 드로우할 때마다 무작위 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 카시아의 모든 기본 피해가 [Arg3]% 증가한다."
  },
  Skill_4751_Desc_2 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 카드 [Arg2]장을 드로우한다. 증상 카드, 상태 카드 또는 카시아의 명령 카드를 1장 드로우할 때마다 무작위 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 카시아의 모든 기본 피해가 [Arg3]% 증가한다."
  },
  Skill_4751_EffectNameList_0 = {Text = "피해"},
  Skill_4751_Name = {
    Text = "마술 카니발"
  },
  Skill_4751_OverLimitUtlSkillDesc_0 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 점 데미지를 [Arg4]회 가하고, 카드 [Arg2]장을 뽑으며, 카시아의 커맨드 카드를 1장 뽑을 때마다 무작위 적에게 <Damage:[Damage:Arg1]> 점 데미지를 [Arg4]회 가합니다. 카시아의 모든 기본 데미지가 [Arg3]% 증가합니다. 이후 카시아의 커맨드 카드를 [Arg6]회 사용하면 [Power:Arg5] 점 힘을 획득합니다."
  },
  Skill_4751_OverLimitUtlSkillDesc_2 = {
    Text = "모든 적에게 <Damage:[Damage:Arg1]> 피해를 [Arg4]번 입히고, [Arg2]장의 카드를 뽑습니다. 증상 카드, 상태 카드 또는 카시아의 명령 카드를 1장 뽑을 때마다 무작위 적에게 <Damage:[Damage:Arg1]> 피해를 [Arg4]번 입힙니다. 카시아의 모든 기본 데미지를 [Arg3]% 증가시킵니다. 이후 카시아의 명령 카드를 [Arg6]번 플레이한 후, [Power:Arg5] 힘을 획득합니다."
  },
  Skill_4751_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4752_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4753_AwakerSkillBackgroundStory = {
    Text = "가시는 적의의 상징이며, 침입자를 향한 날카로운 칼날이다."
  },
  Skill_4753_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이 피해에는 [Arg3]%의 반격 보너스가 적용된다."
  },
  Skill_4753_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 카이커스가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 이 피해에는 [Arg3]%의 반격 보너스가 적용된다."
  },
  Skill_4753_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4753_Name = {Text = "타격"},
  Skill_4753_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4754_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_4754_Name = {
    Text = "남겨진 원한"
  },
  Skill_4755_AwakerSkillBackgroundStory = {
    Text = "미리암은 이 단검이 수많은 의식에서 신의 힘이 주입되었다고 깊이 믿고 있습니다."
  },
  Skill_4755_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <O07CardKeyWord:의식>: 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5]pt 감소시킨다."
  },
  Skill_4755_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 미리암이 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <O07CardKeyWord:의식>: 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5]pt 감소시킨다."
  },
  Skill_4755_EffectNameList = {
    Text = "실타래드, 광기, 힘 감소"
  },
  Skill_4755_Name = {Text = "방어"},
  Skill_4755_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_4756_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4756_Name = {
    Text = "탐색 공격"
  },
  Skill_4757_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg2]턴간 부여한다."
  },
  Skill_4758_AwakerSkillBackgroundStory = {
    Text = "그녀는 새로운 이름으로 세상에 다시 태어나, 외모를 가리고 윤곽을 잃었다.\n세상에 전해지는 것은 오직 그녀의 입술로 이야기된 시편뿐이다.\n그것만으로도 충분하다.\n시인은 외모를 가질 필요가 없다… 그들은 본래 진한 잉크 속에, 페이지 뒤에 숨어 있어야 한다."
  },
  Skill_4758_BattleDesc = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다. <TransitionIconKeywords:워프>: 감정 상태를 「두려움」으로 전환한다."
  },
  Skill_4758_Desc = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다. <TransitionIconKeywords:워프>: 감정 상태를 「두려움」으로 전환한다. 「두려움」 은유 1스택을 소모할 때마다 추가로 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다."
  },
  Skill_4758_EffectNameList = {
    Text = "힘, 힘 감소, 추가 힘"
  },
  Skill_4758_Name = {
    Text = "기묘한 시편"
  },
  Skill_4758_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4759_AwakerSkillBackgroundStory = {
    Text = "세상에는 특별한 해파리가 존재합니다. 다치면 떨어진 조직이 다시 완전한 형체로 발달하기도 합니다.\n“오레타도 해파리를 만들 수 있어요! 그래서 오레타도 해파리예요!”\n아이들이 세상을 인식하는 이 단계에서는 그녀의 흥미를 꺾지 않는 것이 좋겠어요."
  },
  Skill_4759_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 「선체 분열」 [Arg2]장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: <Energy:[Energy:Arg3]>pt의 광기를 획득한다."
  },
  Skill_4759_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 「선체 분열」 [Arg2]장을 버린 카드 더미에 넣는다. <RippleKeywords:여파>: <Energy:[Energy:Arg3]>의 광기를 획득한다."
  },
  Skill_4759_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_4759_Name = {Text = "샘 분열"},
  Skill_4759_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4760_AwakerSkillBackgroundStory = {
    Text = "아이기스의 인형에 의해 오랫동안 주목받는 사물은 시선이 닿는 지점부터 색이 입혀지고 섬유화되는 현상이 나타난다. 일정 시간이 지나면, 해당 계역은 심지어 색깔 실타래과 비슷한 물질로 변해 인형에 의해 흡수된다. 만약 제 때 시선을 막지 않으면, 주목받는 사물이 완전히 해체되어 인형의 일부가 될 수 있다.\n 관찰된 바에 따르면, 오직 아이기스 본인만이 인형의 시선 영향을 받지 않는다."
  },
  Skill_4760_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주며, 이 피해에는 힘이 2배로 적용된다. 대상이 <VulnerabilityIconKeywords:취약> 상태일 경우, 이 카드가 소모한 행동력을 반환하고 카드 1장을 뽑는다."
  },
  Skill_4760_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주며, 이 피해에는 힘이 2배로 적용된다. 대상이 <VulnerabilityIconKeywords:취약> 상태일 경우, 이 카드가 소모한 행동력을 반환하고 카드 1장을 뽑는다. 대상이 가진 <VulnerabilityIconKeywords:취약> 1스택당 「석질 분해」의 최종 피해가 [Arg2]% 증가하며, 최대 500%까지 증가한다."
  },
  Skill_4760_EffectNameList = {Text = "피해"},
  Skill_4760_Name = {
    Text = "석질 분해"
  },
  Skill_4760_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4761_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 모든 손패를 버린다."
  },
  Skill_4761_Name = {Text = "해체"},
  Skill_4762_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득하며 전진한다."
  },
  Skill_4763_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 [Arg2]배로 적용되며, 피해량의 [Arg3]%에 해당하는 <RetaliateIconKeywords:임시 반격>을 획득한다."
  },
  Skill_4763_EffectNameList = {Text = "피해"},
  Skill_4763_Name = {
    Text = "천면환상"
  },
  Skill_4763_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4764_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 힘이 [Arg2]배로 적용된다."
  },
  Skill_4764_EffectNameList = {Text = "피해"},
  Skill_4764_Name = {
    Text = "천면환상"
  },
  Skill_4764_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4765_Desc = {
    Text = "모든 적의 임시 힘을 [Arg2]pt 감소시키고, <DerivativeCardKeywords_29:증상:「망언」> 1장을 손에 넣는다. \"아파? 정말 불쌍하구나… 울어도 돼!\""
  },
  Skill_4765_Name = {Text = "절규!!!"},
  Skill_4766_Desc = {
    Text = "모든 적의 임시 힘을 [Arg2]pt 감소시키고, <DerivativeCardKeywords_30:증상:「쇼크」> 1장을 손에 넣는다. \"아파? 정말 불쌍하구나… 울어도 돼!\""
  },
  Skill_4766_Name = {Text = "절규!!!!"},
  Skill_4767_AwakerSkillBackgroundStory = {
    Text = "방어는 그저 살육의 향연을 끝없이 이어가기 위한 수단일 뿐입니다. 결국 죽은 자는 그 어떤 즐거움도 누릴 수 없으니까요, 그렇죠?"
  },
  Skill_4767_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4767_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 유우하시가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4767_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4767_Name = {Text = "방어"},
  Skill_4767_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4768_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4768_Name = {
    Text = "원한의 포획"
  },
  Skill_4769_AwakerSkillBackgroundStory = {
    Text = "그녀의 보금자리는 끊임없이 팽창하는 폐허이다. \n 꿈은 여기서 완전히 죽어버렸지만, 폐허는 그것에 대해 알지 못한다. 그것은 단지 충실타래히 팽창할 뿐이다. \n 세계는 이미 그것을 망각했다."
  },
  Skill_4769_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. <DreamGuide:몽인> 스택을 소모하여 <JingjinvwangKeywords1:깊은 잠의 반격> 또는 <JingjinvwangKeywords2:잠결의 메아리> 중 하나를 선택하여 발동할 수 있다. <DreamGuide:몽인>이 5스택 미만일 경우, <DreamGuide:몽인> 1스택을 추가로 획득한다."
  },
  Skill_4769_EffectNameList = {
    Text = "실타래드, 반격, 깊은 잠의 반격 광기 획득, 임시 반격%"
  },
  Skill_4769_Name = {
    Text = "꿈속 죽음의 도시"
  },
  Skill_4769_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]>의 실타래드와 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. 몽인을 소모하지 않고, <JingjinvwangKeywords3:최면 맥락>, <JingjinvwangKeywords1:깊은 잠의 반격>, <JingjinvwangKeywords2:잠결의 메아리> 효과를 동시에 발동한다."
  },
  Skill_4769_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4769_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>의 실타래드와 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. <DreamGuide:몽인> 스택을 소모하여 <JingjinvwangKeywords1:깊은 잠의 반격> 또는 <JingjinvwangKeywords2:잠결의 메아리> 중 하나를 선택하여 발동할 수 있다. <DreamGuide:몽인>이 5스택 미만일 경우, <DreamGuide:몽인> 1스택을 추가로 획득한다."
  },
  Skill_4769_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>의 실타래드와 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. 몽인을 소모하지 않고, <JingjinvwangKeywords3:최면 맥락>, <JingjinvwangKeywords1:깊은 잠의 반격>, <JingjinvwangKeywords2:잠결의 메아리> 효과를 동시에 발동한다. 완다가 다음에 사용하는 2장의 명령 카드가 추가로 1회 발동한다."
  },
  Skill_4769_tempOverLimitUtlSkillDesc_1 = {
    Text = "<Block:[Block:Arg1]>의 실타래드와 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. 몽인을 소모하지 않고, <JingjinvwangKeywords3:최면 맥락>, <JingjinvwangKeywords1:깊은 잠의 반격>, <JingjinvwangKeywords2:잠결의 메아리> 효과를 동시에 발동한다."
  },
  Skill_4769_tempOverLimitUtlSkillDesc_2 = {
    Text = "<Block:[Block:Arg1]>의 실타래드와 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. 몽인을 소모하지 않고, <JingjinvwangKeywords3:최면 맥락>, <JingjinvwangKeywords1:깊은 잠의 반격>, <JingjinvwangKeywords2:잠결의 메아리> 효과를 동시에 발동한다."
  },
  Skill_4769_tempOverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>의 실타래드와 <RetaliateIconKeywords:반격> [Counterattack:Arg2]스택을 획득하고, 이번 턴에 다음 워프 효과가 반드시 발동한다. 몽인을 소모하지 않고, <JingjinvwangKeywords3:최면 맥락>, <JingjinvwangKeywords1:깊은 잠의 반격>, <JingjinvwangKeywords2:잠결의 메아리> 효과를 동시에 발동한다. 완다가 다음에 사용하는 2장의 명령 카드가 추가로 1회 발동한다."
  },
  Skill_4770_AwakerSkillBackgroundStory = {
    Text = "소렐의 살롱에서 연회가 끝나기 전 다 함께 추는 원무(圓舞)는 결코 빠질 수 없는 백미다. 술기운과 본능이 이끄는 대로, 이웃 나라의 왕자든, 궁정의 고위 관료든, 곁을 지키던 시녀든 가릴 것 없이 모두가 손을 맞잡고 무도회장으로 뛰어들어 광란의 파티를 즐긴다. 이윽고 음악 소리가 잦아들고 살롱의 막이 내리면, 쥐고 있는 절대적인 권력과 지평선 너머로 떠오르는 희미한 여명을 제외하고 소렐의 곁에는 그 무엇도 남지 않는다."
  },
  Skill_4770_Desc_0 = {
    Text = "[<UnlimitedDevouredIconKeywords:무한 포식>: 이번 권력의 난무의 피해 횟수가 [Arg3]회 증가하고, HP 회복량이 <Heal:[Heal:Arg6]> 증가한다.] 무작위로 <Damage:[Damage:Arg2]>pt의 피해를 [Arg1]회 입힌다. 턴 종료 시 <Heal:[Heal:Arg4]>pt의 HP를 회복한다."
  },
  Skill_4770_EffectNameList_0 = {
    Text = "피해, 회복, 무한 포식 회복"
  },
  Skill_4770_EffectNameList_7 = {
    Text = "피해, 회복, 타수당 회복, 무한 포식 회복"
  },
  Skill_4770_Name = {
    Text = "욕망의 난무"
  },
  Skill_4770_OverLimitUtlSkillDesc_0 = {
    Text = "[<UnlimitedDevouredIconKeywords:무한 포식>: 이번 권력의 난무의 피해 횟수가 [Arg3]회 증가하고, HP 회복량이 <Heal:[Heal:Arg6]> 증가한다.] 무작위로 <Damage:[Damage:Arg2]>pt의 피해를 [Arg1]회 입힌다. <Heal:[Heal:Arg4]>pt의 HP를 회복한다. 소렐이 다음에 사용하는 명령 카드 3장을 2회 발동한다. 이번 광기 폭발로 피해를 1회 입힐 때마다, 턴 종료 시 <Heal:[Heal:Arg5]>pt의 HP를 회복한다."
  },
  Skill_4770_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 체질*GrowValue2, 체질*GrowValue3, 체질*GrowValue4"
  },
  Skill_4770_PropertyNameList_7 = {
    Text = "공격력*GrowValue1, 체질*GrowValue2, 체질*GrowValue3, 체질*GrowValue4"
  },
  Skill_4771_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 현재 HP가 25%([Arg3]) 미만일 경우, HP를 <Heal:[Heal:Arg2]>pt 회복한다."
  },
  Skill_4771_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 현재 HP가 25% 미만일 경우, HP를 <Heal:[Heal:Arg2]>pt 회복한다."
  },
  Skill_4771_Name = {
    Text = "주사 수호"
  },
  Skill_4773_Desc = {
    Text = "무작위 깨어남체에게 임시 봉인 1스택을 부여한다. 이 효과를 2회 반복한다."
  },
  Skill_4773_Name = {Text = "봉인"},
  Skill_4774_AwakerSkillBackgroundStory = {
    Text = "그녀는 호수 중앙에 부패한 것을 심어 길을 잃은 여행자들을 끌어당깁니다.\n음유시인이 말했습니다:\n마치 선물 상자의 한 모서리를 열듯, 희귀한 보물이 반짝이며 등장하고\n마치 커튼을 한 모서리를 열듯, 애절한 노래가 마음껏 전해집니다."
  },
  Skill_4774_Desc_0 = {
    Text = "<RetaliateIconKeywords:반격> [Counterattack:Arg1]스택을 획득한다. 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다. 적이 1명만 있을 경우 힘 감소 효과가 50% 증가한다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 5스택을 소모하여, 성공 시 추가로 <RetaliateIconKeywords:반격> [Arg3]스택을 획득한다. 실타래패 시 <DreamGuide:몽인> 2스택을 획득한다."
  },
  Skill_4774_EffectNameList_0 = {
    Text = "반격, 힘 감소, 추가 반격"
  },
  Skill_4774_EffectNameList_2 = {
    Text = "반격, 힘 감소, 추가 반격"
  },
  Skill_4774_Name = {
    Text = "방황의 수호자"
  },
  Skill_4774_PropertyNameList_0 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4774_PropertyNameList_2 = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_4775_Desc = {
    Text = "깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_4775_Name = {
    Text = "고차원 정향 촉매"
  },
  Skill_4776_AwakerSkillBackgroundStory = {
    Text = "기브 앤 테이크는 주와 노의 관계에서 중요한 부분입니다.\n 주인이 노예에게 주는 것, 키스든 채찍이든, 노예는 사랑과 감사의 마음으로 받아들여야 합니다.\n 당신은 진정한 노예가 아니라 쾌감을 추구하는 쾌락자입니다."
  },
  Skill_4776_Desc_0 = {
    Text = "판디아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득하고, 판디아가 피해를 1회 줄 때마다 <RetaliateIconKeywords:반격> [Counterattack:Arg2]pt를 획득한다."
  },
  Skill_4776_Desc_15 = {
    Text = "판디아가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: <RetaliateIconKeywords:반격> [Counterattack:Arg3]스택을 획득하고, 판디아가 피해를 1회 줄 때마다 <RetaliateIconKeywords:반격> [Counterattack:Arg2]pt를 획득한다. 판디아가 영구 <RetaliateIconKeywords:반격>을 획득할 때, 획득량의 [Arg4]%만큼 동일한 양의 힘을 획득한다."
  },
  Skill_4776_EffectNameList = {
    Text = "광기, 반격, 타수당 반격 획득"
  },
  Skill_4776_Name = {
    Text = "기브 앤 테이크"
  },
  Skill_4776_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue3, 공격력*GrowValue2"
  },
  Skill_4777_AwakerSkillBackgroundStory = {
    Text = "「죽여야 해, 검은 것들은 전부, 전부 죽여야 해...! 안 그러면 죽는 건 나야, 죽는 건 나야...」"
  },
  Skill_4777_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4777_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 입힙니다. <Energy:[Energy:Arg2]> 광기를 획득합니다. 가하는 데미지에 [Arg3]% 반격 계수가 적용됩니다."
  },
  Skill_4777_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 윙클이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4777_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 입힙니다. 웬코르가 <Energy:[Energy:Arg2]> 광기를 획득합니다. 가하는 데미지에 [Arg3]% 반격 계수가 적용됩니다."
  },
  Skill_4777_EffectNameList_0 = {
    Text = "데미지,광기"
  },
  Skill_4777_EffectNameList_1 = {
    Text = "데미지,광기,반격 계수"
  },
  Skill_4777_Name = {Text = "타격"},
  Skill_4777_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4777_PropertyNameList_1 = {
    Text = "공격*GrowValue1,$GrowValue2,$GrowValue3%"
  },
  Skill_4778_AwakerSkillBackgroundStory = {
    Text = "파인트는 요람에서 벗어나려 하지 않는다. 허나 다행스럽게도, 이 요람은 애초부터 그녀와 일체화되어 있다. 파인트의 모든 동족이 부화하기 전의 모습과 똑같이."
  },
  Skill_4778_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4778_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, 피해량의 50%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다. <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4778_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 파인트가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4778_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg3]회 입히고, 피해량의 50%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다. 파인트가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_4778_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_4778_Name = {Text = "타격"},
  Skill_4778_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4780_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4780_Name = {
    Text = "브라운 출동!"
  },
  Skill_47818_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_47818_Name = {Text = "공격"},
  Skill_4781_Desc = {
    Text = "<PVPBleedingKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_4781_Name = {Text = "출혈"},
  Skill_47820_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_47820_Name = {Text = "공격"},
  Skill_4782_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4784_AwakerSkillBackgroundStory = {
    Text = "아무리 흉내 내도, 인간의 기술은 결코 ▼▼의 기술을 진정으로 복제할 수 없습니다. 정신이 모인 기계가 격렬하게 흔들리며 전투의 동료에게 힘을 부여하지만, 그녀가 이 인공 육체에서 벗어나는 것은 불가능합니다.\n 한때 호흡처럼 자연스러웠던 능력이 이제는 더 이상 발휘할 수 없습니다."
  },
  Skill_4784_Desc_0 = {
    Text = "자신의 <FragileIconKeywords:손상> 상태를 해제하고 실타래드를 <Block:[Block:Arg1]>pt 획득한다. <RetaliateIconKeywords:반격>을 [Counterattack:Arg3]스택 획득한다. 다른 깨어남체 1명을 선택하여 광기를 [Energy:Arg2]pt 부여한다."
  },
  Skill_4784_Desc_3 = {
    Text = "자신의 <FragileIconKeywords:손상> 상태를 해제하고 실타래드를 <Block:[Block:Arg1]>pt 획득한다. <RetaliateIconKeywords:반격>을 [Counterattack:Arg3]스택 획득한다. 다른 깨어남체 1명을 선택하여 광기를 [Energy:Arg2]pt 부여하고, 해당 깨어남체는 이번 턴에 광기 폭발을 2회 발동한 후에야 재사용 대기 시간에 들어간다."
  },
  Skill_4784_EffectNameList = {
    Text = "실타래드, 광기, 반격"
  },
  Skill_4784_Name = {
    Text = "형태 없는 전이"
  },
  Skill_4784_OverLimitUtlSkillDesc_0 = {
    Text = "자신의 <FragileIconKeywords:취약> 상태를 해제하고 <Block:[Block:Arg1]> 점 방어막를 획득합니다. [Counterattack:Arg3] 스택의 <RetaliateIconKeywords:반격>을 획득합니다. 다른 깨어남체 1명을 선택하여 <Energy:[Energy:Arg2]> 점 광기를 획득하게 합니다. 선택한 깨어남체가 회합 시작 시 <Energy:[Energy:Arg4]> 점 광기를 획득하며, 3회합 동안 지속됩니다."
  },
  Skill_4784_OverLimitUtlSkillDesc_3 = {
    Text = "자신의 <FragileIconKeywords:손상> 상태를 해제하고 실타래드를 <Block:[Block:Arg1]>pt 획득한다. <RetaliateIconKeywords:반격>을 [Counterattack:Arg3]스택 획득한다. 다른 깨어남체 1명을 선택하여 광기를 [Energy:Arg2]pt 부여하고, 해당 깨어남체는 이번 턴에 광기 폭발을 2회 발동한 후에야 재사용 대기 시간에 들어간다. 선택한 깨어남체가 3턴 동안 턴 시작 시 광기를 [Energy:Arg4]pt 획득한다."
  },
  Skill_4784_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_4785_AwakerSkillBackgroundStory = {
    Text = "“가까이 다가오지 마…… 너희들의 안전을 위해서라도…… 가까이 다가오지 마……”"
  },
  Skill_4785_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4785_BattleDesc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 동일한 양의 <RetaliateIconKeywords:반격>을 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4785_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 피인트가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4785_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 동일한 양의 <RetaliateIconKeywords:반격>을 획득하고, 피인트가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4785_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4785_Name = {Text = "방어"},
  Skill_4785_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4786_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4786_Name = {
    Text = "뜻밖의 사망"
  },
  Skill_4787_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4787_Name = {
    Text = "모체 탐색"
  },
  Skill_4788_Desc = {
    Text = "양측 모두에게 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다. 「예리한 칼날Ⅲ」를 획득한다: 방어되지 않은 피해를 입혔을 경우, 덱의 맨 위에 <DerivativeCardKeywords_23:「상처」> 3장을 추가한다. 1턴간 지속된다."
  },
  Skill_4788_Name = {
    Text = "죽음의 투쟁"
  },
  Skill_4789_AwakerSkillBackgroundStory = {
    Text = "아무도 왜 눈물 방울 모양의 은심을 박아넣은 곰 인형이 아이기스가 깨어남한 후 이렇게 변했는지 설명할 수 없습니다. 이것은 아마도 아이기스 몸에 있는 상위자 힘과 관련이 있거나, 단순히 강력한 정신력의 왜곡으로 인해 생긴 변형일 것입니다.\n 어쨌든, 그것은 일정한 자아 의식을 가진 것처럼 보이며, 가끔 아이기스가 주의를 기울이지 않을 때 일부를 분리하여 털실타래로 이루어진 불꽃놀이처럼 흩어지곤 합니다."
  },
  Skill_4789_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, [Arg2]턴 동안 <VulnerabilityIconKeywords:취약>을 부여합니다. <EmbryoFusionIconKeywords:배아 융합>을 +[Arg3]% 증가시킵니다."
  },
  Skill_4789_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, [Arg2]턴 동안 <VulnerabilityIconKeywords:취약>을 부여합니다. <EmbryoFusionIconKeywords:배아 융합>을 +[Arg3]% 증가시킵니다. 포식이 발동될 시, 버린 카드 더미에 있는 「작은 소원」을 손패로 가져오고, 그 카드의 산출력 소비를 0으로 만듭니다."
  },
  Skill_4789_EffectNameList = {
    Text = "피해, 배아 융합"
  },
  Skill_4789_Name = {
    Text = "작은 소원"
  },
  Skill_4789_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_4790_AwakerSkillBackgroundStory = {
    Text = "검은 점액이 그녀를 심연으로 끌어당깁니다. 별들이 여기서 태어나고, 빛이 여기서 죽습니다. 여기에는 시간도 생명도 없습니다.\n 한 목소리가 멀리서 다가오며 검은 빛을 발산합니다.\n 그것이 말합니다: 당신은 영원히 달라질 것입니다, 왜냐하면 당신은 요정의 통로를 방문했기 때문입니다.\n 그녀는 여기서 오랜 시간 방황할 것입니다."
  },
  Skill_4790_Desc = {
    Text = "젠킨이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 치명타율이 [Arg2]% 증가하고, 젠킨이 피해를 1회 줄 때마다 이번 턴 동안 치명타 피해가 [Arg3]% 증가한다."
  },
  Skill_4790_EffectNameList = {Text = "광기"},
  Skill_4790_Name = {
    Text = "공간 접기"
  },
  Skill_4791_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_4791_Name = {Text = "출혈"},
  Skill_4792_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4793_AwakerSkillBackgroundStory = {
    Text = "뾰족한 가시야말로 최고의 방어다."
  },
  Skill_4793_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 1스택을 획득한다."
  },
  Skill_4793_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 완다가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <TransitionIconKeywords:워프>: <DreamGuide:몽인> 1스택을 획득한다."
  },
  Skill_4793_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_4793_Name = {Text = "방어"},
  Skill_4793_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_4794_Desc = {
    Text = "「사슬의 일격」, 「끝없는 원한」, 「타격」, 「방어」 중 1장을 선택하여 손에 넣고 <DepleteIconKeywords:소모>를 부여한다."
  },
  Skill_4794_Name = {
    Text = "불규칙한 형태"
  },
  Skill_4795_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_28:「증상:의심」> 2장을 덱에 넣는다."
  },
  Skill_4795_Name = {
    Text = "머리 사냥의 저주"
  },
  Skill_4796_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt와 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시, 보유한 스택만큼 HP를 회복하며, HP 5pt를 잃을 때마다 1스택 감소한다."
  },
  Skill_4796_Name = {Text = "심잠"},
  Skill_4797_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4798_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_23:「상처」> [Arg3]장을 덱에 섞어 넣는다."
  },
  Skill_47996_Desc = {
    Text = "잠금 해제된 열쇠 지령 중 1개를 선택하여 발동시키고, 그 효과를 2회 적용한다. 각 열쇠 지령은 이번 탐색에서 1번만 선택할 수 있으며, 초기 지급된 열쇠 지령은 선택할 수 없다."
  },
  Skill_47996_Name = {
    Text = "잊혀지지 않은 새벽"
  },
  Skill_4800_AwakerSkillBackgroundStory = {
    Text = "라이커는 자신의 승리가 행운의 여신 덕분이라고 굳게 믿는다.\n\n최종적으로 모든 재산을 탕진하는 도박사처럼, 그는 행운의 여신이 결코 시선을 돌리지 않을 것이라고 굳게 믿는다."
  },
  Skill_4800_Desc_0 = {
    Text = "라이커가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 이번 전투에서 선택한 <C05_zaowu:「혼돈의 유산」> 유물 1개를 획득하거나, 이미 보유한 <C05_zaowu:「혼돈의 유산」> 1개를 승급한다."
  },
  Skill_4800_Desc_15 = {
    Text = "라이커가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 이번 전투에서 선택한 <C05_zaowu:「혼돈의 유산」> 유물 1개를 획득하거나, 이미 보유한 <C05_zaowu:「혼돈의 유산」> 1개를 승급한다. 해당 효과를 연속 2회 실타래행한다. 라이커의 모든 6면 주사위가 8면 주사위로 승급된다."
  },
  Skill_4800_EffectNameList = {
    Text = "광기, 힘"
  },
  Skill_4800_Name = {
    Text = "최고의 운"
  },
  Skill_4800_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_48018_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4802_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_4803_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4804_AwakerSkillBackgroundStory = {
    Text = "불꽃이 확산되어 극장의 천정을 에메랄드빛으로 비추며, 마치 아침의 맑고 고요한 호수처럼 보인다.\n얼마나 많은 사람들이 이 에메랄드색의 모습을 쫓아왔는가, 또 얼마나 많은 사람들이 그 유려하고 힘 넘치는 춤을 무시하고, 희미하게 드러나는 백옥색 팔과 상상 속의 치마 아래의 풍경만을 보았는가.\n하지만 무용가는 마치 잠금된 듯 거기에 서서 초록 불꽃에 포식당한 임종의 자세를 취하고 있다."
  },
  Skill_4804_Desc_0 = {
    Text = "리즈가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 리즈가 [Arg2]회 피해를 줄 때마다 <DepleteIconKeywords:소모>가 부여된 <DerivativeCardKeywords_18:「녹염」> 1장을 손에 넣는다. 매 턴 최대 3회 발동한다."
  },
  Skill_4804_Desc_15 = {
    Text = "리즈가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 리즈가 [Arg2]회 피해를 줄 때마다 <DepleteIconKeywords:소모>가 부여된 <DerivativeCardKeywords_18:「녹염」> 1장을 손에 넣는다. 매 턴 최대 3회 발동한다. 리즈가 피해를 3회 줄 때마다 리즈의 이번 전투 피해가 [Arg3] 증가한다."
  },
  Skill_4804_EffectNameList = {Text = "광기"},
  Skill_4804_Name = {
    Text = "비취의 반영"
  },
  Skill_4806_Desc = {
    Text = "<MadnessIconKeywords:광란> [Arg1]스택을 획득하고, <DerivativeCardKeywords_9:「비틀거림」> [Arg2]장을 덱에 섞어 넣는다."
  },
  Skill_4806_Name = {Text = "광란"},
  Skill_4807_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득하고, 다른 깨어남체들의 「타격」을 손에 넣는다. 로탄의 격려가 모두의 전의를 불태웠다…"
  },
  Skill_4807_Name = {
    Text = "불굴의 전의"
  },
  Skill_48084_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48085_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득하며, <DerivativeCardKeywords_45:「차원 폐쇄」> 1장을 덱에 섞어 넣는다."
  },
  Skill_48085_Name = {
    Text = "차원 방벽"
  },
  Skill_48086_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 즉시 <ResentChainsKeywords:원한의 사슬> 2스택을 획득한다."
  },
  Skill_48086_Name = {
    Text = "차원 잠금"
  },
  Skill_4808_AwakerSkillBackgroundStory = {
    Text = "두 손으로 주먹을 만들 수 있고, 이빨은 물 때 데미지를 입힐 수 있습니다. \n홀로 있는 병사를 경시하지 말아요. 그들의 몸의 모든 부위는 무기로 사용될 수 있습니다. \n그녀는 그렇게 말하며 다리의 칼날을 펼쳤습니다."
  },
  Skill_4808_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입힌다. 실타래드 1pt당 피해가 2 증가한다. 이번 턴에 「방어」를 1장 사용할 때마다 행동력 소모가 1 감소한다. 「타격」으로 간주한다."
  },
  Skill_4808_EffectNameList = {Text = "피해"},
  Skill_4808_Name = {
    Text = "심안의 칼날"
  },
  Skill_4808_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4809_Desc = {
    Text = "치명타율이 [Arg1]% 증가하고, 치명타 피해가 [Arg2]% 증가한다."
  },
  Skill_4809_Name = {Text = "치명타"},
  Skill_4810_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <RetaliateIconKeywords:반격> [Arg3]스택을 획득한다."
  },
  Skill_4810_Name = {
    Text = "파쇄된 칼"
  },
  Skill_4811_AwakerSkillBackgroundStory = {
    Text = "홀로 떨어진 쥐가 어두운 구석에서 기어 다닌다. 그것은 여위고 작아서, 한 대의 빗자루로 쉽게 쫓아낼 수 있다.\n 방랑자도 마찬가지다.\n 작지만 힘이 있다. 방랑자와 쥐가 팀을 이루면, 그들은 막강해질 수 있다."
  },
  Skill_4811_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 X+4회 입히는 <DerivativeCardKeywords_12:「쥐 떼 돌격」> 1장을 덱 맨 위에 넣는다. <TransitionIconKeywords:워프>: 추가로 「브라운 출동!」 1장을 덱 맨 위에 넣는다."
  },
  Skill_4811_EffectNameList = {
    Text = "「쥐 떼 돌격」 피해"
  },
  Skill_4811_Name = {
    Text = "쥐 떼 집합"
  },
  Skill_4811_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4812_Desc = {
    Text = "<PowerIconKeywords:힘>이 2배 추가로 적용되며, <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다."
  },
  Skill_4812_EffectNameList = {Text = "힘"},
  Skill_4812_Name = {Text = "완력"},
  Skill_4812_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_4813_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4813_Name = {
    Text = "지고의 산제"
  },
  Skill_4814_Desc = {
    Text = "깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_4814_Name = {
    Text = "정향 촉매"
  },
  Skill_48151_Desc_1 = {
    Text = "대상 한 명에게 <StrengthenKeywords:행동 봉쇄>를 부여한다."
  },
  Skill_48151_Name_1 = {
    Text = "행동 봉쇄"
  },
  Skill_4815_Desc = {
    Text = "임시 치명타율이 [Arg1]% 증가한다. 이번 전투 동안 「목을 자르는 일격」과 「천면환상」의 기본 피해가 5% 증가한다."
  },
  Skill_4815_Name = {
    Text = "치명적 추론"
  },
  Skill_4816_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt와 재생력 [Arg2]스택을 획득한다. 재생력: 턴 종료 시, 보유한 스택만큼 HP를 회복하며, HP 5pt를 잃을 때마다 1스택 감소한다."
  },
  Skill_4816_Name = {Text = "심잠"},
  Skill_4817_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득하며 전진한다."
  },
  Skill_4818_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg4] 번 입히고, [Arg2] 장의 카드에 「깊은 잠수 인장」을 부여하며, 사용 시 적에게 일시적으로 <PowerIconKeywords:힘>을 부여."
  },
  Skill_4818_Name = {
    Text = "심해의 표식"
  },
  Skill_4819_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Flaw:허점>을 획득한다. 허점: 이번 턴 동안 반드시 치명타 피해를 받는다."
  },
  Skill_4819_Name = {
    Text = "쥐 떼 돌격"
  },
  Skill_4820_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다!"
  },
  Skill_4821_AwakerSkillBackgroundStory = {
    Text = "그녀의 미로는 세계의 모든 구석으로 이어집니다.\n 밀림 속, 도서관 지하, 심해 깊숙한 곳에 모두 출입구가 있습니다.\n 미로에 잘못 들어간 불행한 이들을 의지하여, 그녀는 겨우 세계의 모습을 그려낼 수 있었습니다.\n 여행자는 끊임없이 회전하는 통로 속에서 길을 잃고, 그녀는 끊임없이 변하는 이야기 속에서 길을 잃습니다.\n 그녀는 모든 것을 알고 있지만, 더 이상 미로에서 한 걸음도 나갈 수 없습니다."
  },
  Skill_4821_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. 포식이 발동될 때마다, 버린 카드 더미에서 「창백한 선회」를 손으로 가져온다."
  },
  Skill_4821_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 입히고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여합니다. <EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg2]%. 포식이 발동될 때마다, 버린 카드 더미에 있는「창백한 선회」를 손패로 가져옵니다."
  },
  Skill_4821_EffectNameList_0 = {Text = "피해"},
  Skill_4821_EffectNameList_3 = {Text = "피해"},
  Skill_4821_Name = {
    Text = "창백한 선회"
  },
  Skill_4821_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4821_PropertyNameList_3 = {
    Text = "공격력*GrowValue1"
  },
  Skill_4822_AwakerSkillBackgroundStory = {
    Text = "끝없는 방랑 속에서, 틴커트는 고향의 이름을 잊어버렸다.\n 긴 세월 속에서, 우주는 그 죽은 별의 이름을 잊어버렸다.\n 그것은 수많은 융식당한 버려진 별들과 마찬가지로 '황야의 별'로 통칭된다.\n 그녀의 노래는 아마도 그 외계 별의 마지막 여운일 것이다."
  },
  Skill_4822_Desc_0 = {
    Text = "틴커트가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 틴커트의 「타격」 기본 피해가 [Arg2]% 증가하고, 틴커트의 모든 카드가 무작위 효과 1개를 획득한다. 해당 효과는 전투 종료 시 제거된다."
  },
  Skill_4822_Desc_15 = {
    Text = "틴크트가 <Energy:[Energy:Arg1]> 의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 틴크트의 「타격」 기본 피해가 [Arg2]% 증가하고, 틴크트의 모든 카드에 랜덤 효과 1개가 부여되며, 해당 효과는 전투 종료 시 제거됩니다. 틴크트가 매 턴 처음으로 「스킬」을 사용할 때 연산력 소모가 0인 임시 「타격」 1장을 생성하며, 해당 「타격」의 랜덤 효과가 2배가 됩니다."
  },
  Skill_4822_EffectNameList = {Text = "광기"},
  Skill_4822_Name = {
    Text = "경계 너머의 소리"
  },
  Skill_4823_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4823_Name = {Text = "단념"},
  Skill_4824_AwakerSkillBackgroundStory = {
    Text = "리즈는 자신이 녹색 불꽃을 획득한 그날의 광경을 기억하고 있다. \n청색의 화종이 손바닥에서 솟아올라 떨어지며, 오랫동안 억눌려 있던 소원을 이루도록 부추겼다."
  },
  Skill_4824_Desc_0 = {
    Text = "무작위 적에게 <Damage:[Damage:Arg2]>의 <PunctureDamagewords:관통 피해>를 [Arg1]회 주고, 피해량의 [Arg3]%만큼 <IntoxicationIconKeywords:중독>을 부여한다. 행동력이 부족할 때 강제로 사용할 수 있으며, 이 경우 효과가 <Energy:[Energy:Arg4]>의 광기를 획득하는 것으로 변경되고, <DepleteIconKeywords:소모>된다."
  },
  Skill_4824_Desc_1 = {
    Text = "무작위 적에게 <Damage:[Damage:Arg2]>의 <PunctureDamagewords:관통 피해>를 [Arg1]회 주고, 피해량의 [Arg3]%만큼 <IntoxicationIconKeywords:중독>을 부여한다. 턴 종료 시 이 카드가 손이나 <DimensionalSpaceIconKeywords:초차원공간>에 있을 경우, 「<DerivativeCardKeywords_20:사멸 녹염>」으로 승급된다. 행동력이 부족할 때 강제로 사용할 수 있으며, 이 경우 효과가 <Energy:[Energy:Arg4]>의 광기를 획득하는 것으로 변경되고, <DepleteIconKeywords:소모>된다."
  },
  Skill_4824_EffectNameList = {Text = "피해"},
  Skill_4824_Name = {
    Text = "부패의 녹색 불꽃"
  },
  Skill_4824_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4825_AwakerSkillBackgroundStory = {
    Text = "회색, 끈적함, 저절로 움직이는 마치 생명력 있는 조수.\n 붙기만 하면 골수까지 감염될 것 같다……\n 이 물체를 엿본 사람은 모두 이런 감상을 가질 것이다."
  },
  Skill_4825_Desc_0 = {
    Text = "<PowerIconKeywords:힘>을 [Power:Arg1] 획득하고, 모든 적에게 <VulnerabilityIconKeywords:취약>을 부여합니다. <TransitionIconKeywords:도약>: 임시 <PowerIconKeywords:힘>을 [Power:Arg2] 획득하고, 모든 적에게 <VulnerabilityIconKeywords:취약>을 부여하는 효과로 변경됩니다."
  },
  Skill_4825_EffectNameList = {
    Text = "힘, 임시 힘"
  },
  Skill_4825_Name = {
    Text = "이질의 파도"
  },
  Skill_4825_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4826_Desc = {
    Text = "상태 카드."
  },
  Skill_4826_Name = {Text = "경련"},
  Skill_4827_AwakerSkillBackgroundStory = {
    Text = "“우리에게 영양을 흡수하는 것은 식물이 햇빛을 쫓는 것처럼 자연스럽다.” 파인트는 동족이 말하는 “햇빛을 쫓는 것”이 어떤 본능인지 이해하지 못했다. 그녀는 단지, 한 번 사냥감의 몸에 뿌리를 내리면, 멈출 수 없고, 멈출 수 없고, 멈출 수 없다는 것만 알았다……"
  },
  Skill_4827_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Power:Arg1]pt 획득하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시킨다."
  },
  Skill_4827_EffectNameList = {
    Text = "힘, 임시 힘 감소"
  },
  Skill_4827_Name = {
    Text = "양분 흡수"
  },
  Skill_4827_PropertyNameList = {
    Text = "공격력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_4833_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_36:「모독의 환영」> 3장을 손에 넣는다."
  },
  Skill_4833_Name = {
    Text = "이계의 응시"
  },
  Skill_4835_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4836_AwakerSkillBackgroundStory = {
    Text = "오지에가 예비 기사가 되었을 때, 그의 키는 말 등에도 미치지 못했다. 수호를 위해 희생할 때에도, 그는 겨우 창을 들어 올릴 수 있었다. \n어린 소년이 적의 갑옷을 꿰뚫을 수 있게 한 것은, 얼마나 굳건한 신념과 의지였을까?"
  },
  Skill_4836_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통 피해>를 [Arg3]회 주고, [Arg2]턴간 <VulnerabilityIconKeywords:취약>을 부여하며, <PowerIconKeywords:힘>의 효과를 2배로 받는다."
  },
  Skill_4836_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통 피해>를 [Arg3]회 주고, [Arg2]턴간 <VulnerabilityIconKeywords:취약>을 부여하며, <PowerIconKeywords:힘>의 효과를 3배로 받는다."
  },
  Skill_4836_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통 피해>를 주고, [Arg2]턴간 <VulnerabilityIconKeywords:취약>을 부여하며, <PowerIconKeywords:힘>의 효과를 2배로 받는다."
  },
  Skill_4836_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통 피해>를 주고, [Arg2]턴간 <VulnerabilityIconKeywords:취약>을 부여하며, <PowerIconKeywords:힘>의 효과를 3배로 받는다."
  },
  Skill_4836_EffectNameList = {Text = "피해"},
  Skill_4836_Name = {
    Text = "관통의 창"
  },
  Skill_4836_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_4838_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4838_Name = {
    Text = "광란의 타격"
  },
  Skill_4839_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4840_AwakerSkillBackgroundStory = {
    Text = "이것은 본디 내게 속해야 할 것, 나선연(螺湮)의 지배자로부터 이어진 전승이다. \n썩어빠진 자들이여, 나선연 역류의 징벌을 받아라."
  },
  Skill_4840_BattleDesc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, [Arg2]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다. <SacrificeKeyWord:희생> 스택의 [Arg3]%를 제거한다."
  },
  Skill_4840_BattleDesc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg5]회 주고, [Arg2]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다. <SacrificeKeyWord:희생> 스택의 [Arg3]%를 제거한다."
  },
  Skill_4840_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, [Arg2]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용된다. <SacrificeKeyWord:희생> 스택의 [Arg3]%를 제거한다."
  },
  Skill_4840_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주고, [Arg2]턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 이 피해에는 [Arg4]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스가 적용되며, 촉수 2개당 피해 횟수가 1회 추가로 증가한다. <SacrificeKeyWord:희생> 스택의 [Arg3]%를 제거한다."
  },
  Skill_4840_EffectNameList = {
    Text = "피해, 촉수 피해 계수, 희생 제거%"
  },
  Skill_4840_Name = {
    Text = "레무리아의 역류"
  },
  Skill_4840_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2％,$GrowValue3％"
  },
  Skill_4841_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4842_AwakerSkillBackgroundStory = {
    Text = "차원을 초월하는 마녀는 차원 속의 굴절 법칙을 잘 알고 있다.\n 그녀는 차원의 모든 경로와 연결점을 명확히 알고 있다.\n 무한 통로는 그녀의 마음 속에 모두 있다.\n 그렇다면 다른 차원에서 투사된 물질은 그녀에게 자연스럽게 주머니 속의 물건과도 같다."
  },
  Skill_4842_Desc_0 = {
    Text = "다프다엘이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 다프다엘의 카드 1장이 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_4:「영감」> 1장을 손에 넣는다. 매 턴 최대 2회 발동한다."
  },
  Skill_4842_Desc_15 = {
    Text = "다프다엘이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 다프다엘의 카드 1장이 <DimensionalSpaceIconKeywords:초차원 공간>에 들어갈 때마다, <DerivativeCardKeywords_4:「영감」> 1장을 손에 넣는다. 매 턴 최대 2회 발동한다. 행동력 소모가 0인 임시 「목을 자르는 일격」 1장을 생성하여 초차원 공간에 넣는다."
  },
  Skill_4842_EffectNameList = {Text = "광기"},
  Skill_4842_Name = {
    Text = "차원 투영"
  },
  Skill_4843_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_31:「융식액」> 1장을 덱에 섞어 넣는다."
  },
  Skill_4844_AwakerSkillBackgroundStory = {
    Text = "내가 선택받기를 기다리고, 심해로 잠수하기를 기다리며, 내 부족으로 돌아가기를 기다린다.\n 나는 영원한 안락을 누릴 것이고, 무지하고 평범한 사람들은 나를 다시는 괴롭힐 수 없다.\n 그런 동경을 품고, 작은 소년은 환상의 꿈속으로 잠들었다."
  },
  Skill_4844_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. 다음 턴 시작까지, <RetaliateIconKeywords:반격>과 촉수 반격이 50%의 피해량으로 [Arg2]회 추가 발동한다. <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다."
  },
  Skill_4844_EffectNameList = {
    Text = "실타래드, 힘"
  },
  Skill_4844_Name = {
    Text = "역린의 수호"
  },
  Skill_4844_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4845_AwakerSkillBackgroundStory = {
    Text = "피는 신령과의 연결고리입니다. \n신의 땅의 재림은 최정점에 도달한 순수한 제물이 기반이 됩니다."
  },
  Skill_4845_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. <O07CardKeyWord:의식>: <PowerIconKeywords:힘> [Power:Arg3]/[Power:Arg4]/[Power:Arg5]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 증가한다."
  },
  Skill_4845_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. 임시 치명타 피해가 [Arg2]% 증가한다. <O07CardKeyWord:의식>: <PowerIconKeywords:힘> [Power:Arg3]/[Power:Arg4]/[Power:Arg5]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 증가한다."
  },
  Skill_4845_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. <O07CardKeyWord:의식>: <PowerIconKeywords:힘> [Power:Arg3]/[Power:Arg4]/[Power:Arg5]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 증가한다."
  },
  Skill_4845_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 주고, 동일한 양의 <IntoxicationIconKeywords:중독>을 부여한다. 임시 치명타 피해가 미리암의 기본 치명타 피해의 15%만큼 증가한다. <O07CardKeyWord:의식>: <PowerIconKeywords:힘> [Power:Arg3]/[Power:Arg4]/[Power:Arg5]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 증가한다."
  },
  Skill_4845_EffectNameList = {
    Text = "피해, 힘/촉수 피해"
  },
  Skill_4845_Name = {
    Text = "지고의 산제"
  },
  Skill_4845_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4846_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4846_Name = {
    Text = "검은 늪의 침식"
  },
  Skill_4847_AwakerSkillBackgroundStory = {
    Text = "회피는 부끄러운 일이 아니다. 오히려 잠시 숨을 돌릴 여유가 있기에, 그녀는 상대의 행동을 추론할 수 있었다."
  },
  Skill_4847_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4847_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 라모나가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4847_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4847_Name = {Text = "방어"},
  Skill_4847_PropertyNameList = {
    Text = "방어력 * GrowValue1, $GrowValue2"
  },
  Skill_4848_AwakerSkillBackgroundStory = {
    Text = "그 스파르타인들이 저지른 대가를 치르게 하라.\n 네가 준 것은 연민이 아니고, 네가 빼앗은 것은 은혜가 아니다.\n 그것은 꿈을 품은 소녀의 인생이며, 수많은 히로인의 뜨거운 피눈물이다.\n 복수자는 잃은 것은 오직 사슬뿐이다."
  },
  Skill_4848_Desc_0 = {
    Text = "히로가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 히로의 카드가 <RetainIconKeywords:유지>를 획득하며, 턴 종료 후 「사슬의 일격」의 타격 보너스와 「끝없는 원한」의 기본 피해가 10% 증가한다."
  },
  Skill_4848_Desc_15 = {
    Text = "히로가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 사용 시 즉시 「사슬의 일격」의 타격 보너스와 「끝없는 원한」의 기본 피해를 50% 증가시키고, 턴 종료 후 해당 값이 10% 추가로 증가한다. 히로의 카드가 <RetainIconKeywords:유지>를 획득한다."
  },
  Skill_4848_EffectNameList = {Text = "광기"},
  Skill_4848_Name = {
    Text = "복수 선언"
  },
  Skill_4849_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>의 실타래드를 획득한다."
  },
  Skill_4850_BattleDesc = {
    Text = "이 카드의 치명타율과 치명타 피해가 50% 증가하고, <PunctureDamagewords:관통 피해>를 준다."
  },
  Skill_4850_Desc = {
    Text = "이 카드의 치명타율과 치명타 피해가 50% 증가하고, <PunctureDamagewords:관통 피해>를 준다."
  },
  Skill_4850_Name = {
    Text = "관통 치명타"
  },
  Skill_4851_Desc = {
    Text = "<DerivativeCardKeywords_4:「영감」> 2장을 덱에 넣는다."
  },
  Skill_4851_Name = {
    Text = "고차원 영감"
  },
  Skill_4852_Desc = {
    Text = "<Posse:[Arg1]> 점 은열쇠 에너지를 획득합니다. 이번 전투에서 「목을 자르는 일격」과 「천면환상」의 기본 데미지가 10% 증가합니다."
  },
  Skill_4852_Name = {
    Text = "고차원 키 에너지"
  },
  Skill_4853_Desc = {
    Text = "<DerivativeCardKeywords_80:「질식」> [Arg1]장을 상대의 손에 넣는다."
  },
  Skill_4853_Name = {
    Text = "익사자의 원한"
  },
  Skill_4854_Desc = {
    Text = "덱에서 카드 1장을 선택하여 손에 넣고, 해당 카드의 행동력 소모를 1 감소시킨다."
  },
  Skill_4854_Name = {
    Text = "정밀 탐색"
  },
  Skill_4855_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 자신은 「밀랍 갑옷」 [Arg2]스택을 획득한다. 「밀랍 갑옷」: 1스택마다 받는 피해가 [Arg3] 감소하며, 치명타 피해를 입을 때마다 1스택 감소한다."
  },
  Skill_4855_Name = {
    Text = "밀랍상 등장"
  },
  Skill_4856_AwakerSkillBackgroundStory = {
    Text = "정원의 플라타너스 잎사귀가 사각거리며 흔들리고, 작은 새들은 봄날의 찬가를 지저귄다. 비좁은 천창 창살 너머로는 갓 피어난 장미의 그윽한 향기가 스며들어 그녀의 코끝을 맴돈다. 고독한 온실타래 속, 시선이 닿는 모든 흐드러진 꽃들이 곧 한 편의 시가 된다."
  },
  Skill_4856_Desc_0 = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복하고, <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 다른 깨어남체가 <Energy:[Energy:Arg3]>의 광기를 획득하며, 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 감정 상태를 보유 중일 경우, 해당하는 화려한 장편의 효과가 150% 증가한다."
  },
  Skill_4856_Desc_3 = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복하고, <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 다른 깨어남체가 <Energy:[Energy:Arg3]>의 광기를 획득하며, 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 감정 상태를 보유 중일 경우, 해당하는 화려한 장편의 효과가 250% 증가한다."
  },
  Skill_4856_EffectNameList = {
    Text = "회복, 힘"
  },
  Skill_4856_Name = {
    Text = "화려한 시곡"
  },
  Skill_4856_OverLimitUtlSkillDesc_0 = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복하고, <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다. 다른 깨어남체가 <Energy:[Energy:Arg3]>의 광기를 획득하며, 임시 치명타율과 임시 치명타 피해가 [Arg4]% 증가한다. 감정 상태를 보유 중일 경우, 해당하는 화려한 장편의 효과가 600% 증가한다. 만능 「은유」 3스택을 획득한다: 다음 시편 워프 시 임의의 감정 「은유」로 사용되며, <DepleteIconKeywords:소모>된다."
  },
  Skill_4856_PropertyNameList = {
    Text = "체질*GrowValue1, 공격력*GrowValue2"
  },
  Skill_4857_Desc = {
    Text = "<PowerIconKeywords:힘>이 4배 추가로 적용되며, <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다."
  },
  Skill_4857_EffectNameList = {Text = "힘"},
  Skill_4857_Name = {
    Text = "고차원 완력"
  },
  Skill_4857_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_48581_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48581_Name = {
    Text = "뒤틀린 시체의 광연-혼돈"
  },
  Skill_48582_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 방어되지 않은 피해량의 50%에 해당하는 <PVPBleedingKeywords:출혈>을 부여한다."
  },
  Skill_48582_Name = {
    Text = "뒤틀린 시체의 광연-혈육"
  },
  Skill_48583_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 뒤틀린 시체 광연의 피해를 <Damage:[Damage:Arg3]> 증가시킨다."
  },
  Skill_48583_Name = {
    Text = "혼돈의 절단-광란"
  },
  Skill_48584_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <RetaliateIconKeywords:반격> [Arg3]스택을 획득한다."
  },
  Skill_48584_Name = {
    Text = "뒤틀린 시체의 광연-초차원"
  },
  Skill_48585_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 <IntoxicationIconKeywords:중독> [Arg3]스택을 부여한다."
  },
  Skill_48585_Name = {
    Text = "뒤틀린 시체의 광연-심해"
  },
  Skill_4858_AwakerSkillBackgroundStory = {
    Text = "소녀는 아쉬움을 뒤로한 채 파산한 수족관을 떠났다. 그동안 일한 대가로, 그녀는 해파리 몇 마리를 집으로 데려가는 것을 허락받았다. 이들은 그녀가 가장 아끼는 작은 생명체이자 환상의 바다를 부유하는 정령이며, 끊임없이 피어나는 생명의 꽃이었다. 정성껏 돌보기만 한다면, 이 아이들이 수조를 가득 채우게 될 거야! ——한때 그녀는 그런 광경을 기대했었다."
  },
  Skill_4858_Desc_0 = {
    Text = "오레타가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣는다. 오레타가 피해를 줄 때 [Arg2]개의 촉수가 1회 공격한다."
  },
  Skill_4858_Desc_15 = {
    Text = "오레타가 <Energy:[Energy:Arg1]> 의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: 촉수 1개를 획득하고, 「선체 분열」 2장을 손에 넣습니다. 오레타가 피해를 가할 때, [Arg2]개의 촉수가 1회 공격합니다. 오레타의 「타격」이 관통 피해로 변경되며, 추가로 3회 피해를 가합니다."
  },
  Skill_4858_EffectNameList = {Text = "광기"},
  Skill_4858_Name = {
    Text = "자가 증식"
  },
  Skill_48592_Desc = {
    Text = "<DerivativeCardKeywords_33:「살려줘」> 1장을 손에 넣는다. 그림자 「24」가 난폭해지며, 모든 행동이 강화되고 가장 맹렬한 공격을 시작한다."
  },
  Skill_48592_Name = {
    Text = "광란 인격"
  },
  Skill_48593_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 뒤틀린 시체 광연의 피해를 <Damage:[Damage:Arg3]> 증가시킨다."
  },
  Skill_48593_Name = {Text = "난도질"},
  Skill_48595_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48595_Name = {
    Text = "뒤틀린 시체의 광연"
  },
  Skill_4859_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_4859_Name = {
    Text = "장례의 종소리"
  },
  Skill_48600_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48600_Name = {
    Text = "이종 공생"
  },
  Skill_4860_Desc = {
    Text = "공포도 야수의 본능이다."
  },
  Skill_4860_Name = {Text = "놀람"},
  Skill_4861_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_4861_Name = {
    Text = "손상 공격"
  },
  Skill_4862_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_4863_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_4863_Name = {
    Text = "사냥창 찌르기"
  },
  Skill_4864_AwakerSkillBackgroundStory = {
    Text = "철학은 정답이 없는 학문이다.\n\n그것은 문명의 기원에서 흘러나온 강과 같아서, 강의 각 구간마다 인류는 서로 다른 물을 부어넣었다.\n\n그리고 그녀는 자신만의 강줄기를 파고 있다.\n\n어쩌면, 머지않아 그녀는 자신의 존재 본질을 꿰뚫어 볼지도 모른다. 어쩌면, 그날은 영원히 오지 않을지도 모른다."
  },
  Skill_4864_Desc_0 = {
    Text = "라모나가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 라모나가 카드를 사용한 후, 행동력 1pt를 획득하며, 매 턴 최대 3회 발동된다."
  },
  Skill_4864_Desc_15 = {
    Text = "라모나가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 라모나가 카드를 사용한 후, 행동력 1pt를 획득하고 라모나가 주는 기본 피해가 10% 증가하며, 매 턴 최대 3회 발동된다."
  },
  Skill_4864_EffectNameList = {Text = "광기"},
  Skill_4864_Name = {
    Text = "첫 번째 철학"
  },
  Skill_4865_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_3:「기절」> 1장을 덱에 섞어 넣는다."
  },
  Skill_4865_Name = {Text = "경련"},
  Skill_4866_Desc = {
    Text = "자신이 사망하면, 다른 아군이 최대 HP만큼 HP를 회복한다."
  },
  Skill_4866_Name = {Text = "희생"},
  Skill_4867_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_4868_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]을 획득한다."
  },
  Skill_4868_Name = {Text = "전체 힘"},
  Skill_4869_AwakerSkillBackgroundStory = {
    Text = "“안돼, 안돼, 안돼, 오지 마—”"
  },
  Skill_4869_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4869_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 윙클이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_4869_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_4869_Name = {Text = "방어"},
  Skill_4869_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_48812_Desc = {
    Text = "손에 다른 「배아」가 없을 때, <DevouredIconKeywords:포식>되어 포식 효과를 2회 발동할 수 있다. 직접 사용하거나 자동 변환 시 「배아」의 1.5배 효과로 간주된다."
  },
  Skill_48812_Name = {
    Text = "성결의 자식"
  },
  Skill_48812_tempBattleDesc_1 = {
    Text = "「배아」가 없을 때, <DevouredIconKeywords:포식>될 수 있으며 2회 <DevouredIconKeywords:포식> 효과를 발동한다. 직접 사용하거나 자동 전환 시 「배아」의 1.5배 효과로 간주한다."
  },
  Skill_48812_tempBattleDesc_2 = {
    Text = "「배아」가 없을 때, <DevouredIconKeywords:포식>될 수 있으며 2회 <DevouredIconKeywords:포식> 효과를 발동한다. 사용 후 깨어남체 하나를 선택하여 <Energy:[Energy:Arg1]> 광기를 획득한다. 깨어남체가 매 라운드 처음으로 「배아」 또는 「성결의 자식」을 소모할 때, [Arg3] 중첩의 <BreedingKeywords1:번식 축전>을 획득한다."
  },
  Skill_48812_tempName_1 = {
    Text = "성결의 자식"
  },
  Skill_48812_tempName_2 = {
    Text = "번식· 성결의 자식"
  },
  Skill_48813_Desc = {
    Text = "전체 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]턴간 부여한다."
  },
  Skill_48813_Name = {
    Text = "부패의 피"
  },
  Skill_48814_Desc = {
    Text = "전체 적에게 <WeaknessIconKeywords:허약>을 [Arg1]턴간 부여한다."
  },
  Skill_48814_Name = {
    Text = "공포의 피"
  },
  Skill_48815_Desc = {
    Text = "<EmbryoFusionIconKeywords:배아 융합> +[Blood:Arg1]."
  },
  Skill_48815_Name = {
    Text = "생식의 피"
  },
  Skill_48857_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48857_Name = {
    Text = "광기와 피의 발톱"
  },
  Skill_48858_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다! <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_48858_Name = {
    Text = "미쳐 날뛰는 물어뜯기"
  },
  Skill_48859_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48860_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_48860_Name = {Text = "강화"},
  Skill_48882_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48883_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48884_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_48884_Name = {Text = "강화"},
  Skill_48885_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_48885_Name = {Text = "강화"},
  Skill_48893_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48894_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_48894_Name = {Text = "강화"},
  Skill_48895_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48896_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_48896_Name = {Text = "강화"},
  Skill_48897_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_48898_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_48898_Name = {Text = "강화"},
  Skill_49124_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, [Arg3]턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_49124_Name = {
    Text = "갑옷을 뚫는 가시"
  },
  Skill_49125_Desc = {
    Text = "사용 후 카드를 1장 드로우한다. 턴 종료 시 손에 남아있을 경우, 은열쇠 에너지를 500 잃는다."
  },
  Skill_49125_Name = {
    Text = "실타래어증 변형"
  },
  Skill_49126_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_49127_Desc = {
    Text = "사용 후 카드를 1장 드로우한다. 턴 종료 시 손에 남아있을 경우, 무작위 증상 카드 2장을 덱에 섞어 넣는다."
  },
  Skill_49127_Name = {
    Text = "대사 변이"
  },
  Skill_49128_Desc = {
    Text = "사용 후 카드를 1장 뽑는다. 턴 종료 시 손에 남아있을 경우, 자신에게 1턴간 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_49128_Name = {
    Text = "쇠약 변형"
  },
  Skill_49129_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_49129_Name = {
    Text = "피의 가시"
  },
  Skill_49130_Desc = {
    Text = "사용 후 카드를 1장 드로우한다. 턴 종료 시 손에 남아있을 경우, 모든 깨어남체가 광기 10을 잃는다."
  },
  Skill_49130_Name = {
    Text = "어리석은 변이"
  },
  Skill_49131_Desc = {
    Text = "사용 후 카드를 1장 드로우한다. 턴 종료 시 손에 남아있을 경우, 「상처」 4장을 덱에 섞어 넣는다."
  },
  Skill_49131_Name = {
    Text = "사지 절단 변형"
  },
  Skill_49133_Desc = {
    Text = "끝없는 번식 속에 태어난 정체불명의 산물… 사용 후 모든 깨어남체가 광기 5를 획득하며, 턴 종료 시 손에 남아있을 경우 스스로 복제한다. 이 카드의 행동력 소모는 최소 1이다."
  },
  Skill_49133_Name = {
    Text = "혼란의 자식"
  },
  Skill_49215_Desc = {
    Text = "행동력을 1pt 획득한다, [Arg1]회 사용 가능."
  },
  Skill_49215_Name = {
    Text = "기묘한 요리"
  },
  Skill_49216_Desc = {
    Text = "행동력을 1pt 획득한다. [Arg1]회 사용 가능. 50% 확률로 <MysterybuffKeywords:기묘한 버프>가 발동된다."
  },
  Skill_49216_Name = {
    Text = "기묘한 요리"
  },
  Skill_49233_Desc = {
    Text = "최전방 아군과 위치를 교환하고 실타래드를 [Arg1]pt 획득한다."
  },
  Skill_49233_Name = {Text = "보호"},
  Skill_49234_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 자신에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_49234_Name = {
    Text = "필사의 공격"
  },
  Skill_49235_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_49235_Name = {
    Text = "심장을 관통하는 일격"
  },
  Skill_49236_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후방의 아군과 위치를 교환하며, <PowerIconKeywords:힘> [Arg3]pt 획득한다."
  },
  Skill_49236_Name = {
    Text = "힘을 모은 일격"
  },
  Skill_49279_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 1장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_49279_Name = {
    Text = "기형 확산"
  },
  Skill_49280_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_49280_Name = {
    Text = "먼지 날리기"
  },
  Skill_49281_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_49281_Name = {
    Text = "천의 바늘"
  },
  Skill_49282_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_49282_Name = {Text = "기도문"},
  Skill_49288_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_49288_Name = {Text = "충격"},
  Skill_49289_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <WeaknessIconKeywords:허약>을 부여한다. 대상의 <PowerIconKeywords:힘> 4pt당 1pt 감소시키며, 감소시킨 힘은 대상의 힘을 초과할 수 없다."
  },
  Skill_49289_Name = {
    Text = "어둠의 침식"
  },
  Skill_49290_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_49290_Name = {
    Text = "피의 분사"
  },
  Skill_49291_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 1장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_49291_Name = {
    Text = "불결한 탄생"
  },
  Skill_49416_Desc = {
    Text = "손에 있는 비파생한 명령 카드 1장을 선택해, <DepleteIconKeywords:소모>가 부여된 원본의 복사본을 획득하면 그 명령 카드의 소유자가 광기를 <Energy:[Arg1]> 획득한다."
  },
  Skill_49416_Name = {
    Text = "유일한 씨앗"
  },
  Skill_49434_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_49434_Name = {Text = "충격"},
  Skill_49435_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_49435_Name = {
    Text = "피의 분사"
  },
  Skill_49436_Desc = {
    Text = "힘을 [Arg1]pt 획득한다. <ConcealmentKeywords:은폐> 50스택을 획득한다. 전방에 「증식·누비아 새끼」 2마리를 소환한다."
  },
  Skill_49436_Name = {
    Text = "은밀한 호출"
  },
  Skill_49437_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 2장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_49437_Name = {
    Text = "불결한 탄생"
  },
  Skill_49438_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <WeaknessIconKeywords:허약>을 부여한다. 대상의 <PowerIconKeywords:힘> 3pt당 1pt 감소시키며, 감소시킨 힘은 대상의 힘을 초과할 수 없다."
  },
  Skill_49438_Name = {
    Text = "어둠의 침식"
  },
  Skill_49439_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, [Arg3]턴간 <FragileIconKeywords:손상>과 <HeavyInjuryKeywords:중상>을 부여한다. 다른 적이 모두 사망했다면, 즉시 의도를 「충격」으로 전환한다."
  },
  Skill_49439_Name = {
    Text = "은밀한 기습"
  },
  Skill_49454_Desc = {
    Text = "힘을 [Arg1]pt 획득한다. <ConcealmentKeywords:은폐> 75스택을 획득한다. 전방에 「증식·누비아 새끼」 2마리를 소환한다."
  },
  Skill_49454_Name = {
    Text = "은밀한 호출"
  },
  Skill_49455_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [AttackTimes:Arg2] 번 가합니다. 1장의 <DerivativeCardKeywords_44:음란한 자식>을 손에 추가하고, 덱의 5장의 카드에 <AberrationKeywords:변형>을 발생시킵니다."
  },
  Skill_49455_Name = {
    Text = "불결한 탄생"
  },
  Skill_49456_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_49456_Name = {
    Text = "피의 분사"
  },
  Skill_49457_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_49457_Name = {Text = "충격"},
  Skill_49458_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 번 입힙니다. 1장의 <DerivativeCardKeywords_44:음란한 자식>을 손에 추가하고, 카드 덱에서 2장의 카드가 <AberrationKeywords:변형>을 일으키게 합니다."
  },
  Skill_49458_Name = {
    Text = "불결한 탄생"
  },
  Skill_49459_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, [Arg3]턴간 <FragileIconKeywords:손상>과 <HeavyInjuryKeywords:중상>을 부여한다. 다른 적이 모두 사망했다면, 즉시 의도를 「충격」으로 전환한다."
  },
  Skill_49459_Name = {
    Text = "은밀한 기습"
  },
  Skill_49460_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <WeaknessIconKeywords:허약>을 부여한다. 대상의 <PowerIconKeywords:힘> 3pt당 1pt 감소시키며, 감소시킨 힘은 대상의 힘을 초과할 수 없다."
  },
  Skill_49460_Name = {
    Text = "어둠의 침식"
  },
  Skill_49477_Desc_1 = {
    Text = "상대의 모든 손패를 버리고, 상대에게 [Arg1]장의 「열쇠 지령」을 부여한다."
  },
  Skill_49477_Name_1 = {
    Text = "상대에게 열쇠 지령 부여"
  },
  Skill_49490_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_49491_Desc = {
    Text = "기도 [Arg1]스택을 획득하고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택 감소하고, 턴 종료 시 모두 사라진다."
  },
  Skill_49491_Name = {
    Text = "피의 기도"
  },
  Skill_49492_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 2장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_49492_Name = {
    Text = "기형의 바늘"
  },
  Skill_49493_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, 「기도」 1스택당 피해 횟수가 1회 증가한다. 방어되지 않은 피해를 1회 입힐 때마다 <DerivativeCardKeywords_23:「상처」> 1장을 덱에 넣으며, 최대 5장까지 넣을 수 있다."
  },
  Skill_49493_Name = {
    Text = "영원한 촛불"
  },
  Skill_49515_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 3장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_49515_Name = {
    Text = "기형의 바늘"
  },
  Skill_49516_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 3장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_49516_Name = {
    Text = "기형의 바늘"
  },
  Skill_49517_Desc = {
    Text = "<DerivativeCardKeywords_44:음란 녀석> 2장을 손에 넣고, 즉시 전방에 「누비아」 1마리와 후방에 「누비아 새끼」 2마리를 소환한다."
  },
  Skill_49517_Name = {
    Text = "오염 살포"
  },
  Skill_49518_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_49519_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, 「기도」 1스택당 피해 횟수가 1회 증가한다. 방어되지 않은 피해를 1회 입힐 때마다 <DerivativeCardKeywords_23:「상처」> 1장을 덱에 넣으며, 최대 5장까지 넣을 수 있다."
  },
  Skill_49519_Name = {
    Text = "영원한 촛불"
  },
  Skill_49520_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, 「기도」 1스택당 피해 횟수가 1회 증가한다. 방어되지 않은 피해를 1회 입힐 때마다 <DerivativeCardKeywords_23:「상처」> 1장을 덱에 넣으며, 최대 5장까지 넣을 수 있다."
  },
  Skill_49520_Name = {
    Text = "영원한 촛불"
  },
  Skill_49521_Desc = {
    Text = "기도 [Arg1]스택을 획득하고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택 감소하고, 턴 종료 시 모두 사라진다."
  },
  Skill_49521_Name = {
    Text = "피의 기도"
  },
  Skill_49522_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_49523_Desc = {
    Text = "기도 [Arg1]스택을 획득하고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다. 기도: 스킬 강화에 사용되며, 피해를 받으면 1스택 감소하고, 턴 종료 시 모두 사라진다."
  },
  Skill_49523_Name = {
    Text = "피의 기도"
  },
  Skill_49530_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_49530_Name = {
    Text = "심장을 관통하는 일격"
  },
  Skill_49531_Desc = {
    Text = "최전방 아군과 위치를 교환하고 실타래드를 [Arg1]pt 획득한다."
  },
  Skill_49531_Name = {
    Text = "용감한 보호"
  },
  Skill_49532_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후방의 아군과 위치를 교환한다."
  },
  Skill_49532_Name = {
    Text = "힘을 모은 맹습"
  },
  Skill_49533_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 자신에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_49533_Name = {
    Text = "필사의 공격"
  },
  Skill_49543_Desc = {
    Text = "전체 아군이 <PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_49543_Name = {Text = "고무"},
  Skill_49544_Desc = {
    Text = "아란 대장에게 [Arg1]의 실타래드를 부여한다."
  },
  Skill_49544_Name = {Text = "호위"},
  Skill_49551_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 1턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_49551_Name = {
    Text = "광란의 쪼아먹기"
  },
  Skill_49552_Desc = {
    Text = "플레이어에게 <EmptinessKeywords:허무> 5스택을 부여한다. <DerivativeCardKeywords_25:「돌」> 3장을 덱에 섞어 넣는다."
  },
  Skill_49552_Name = {
    Text = "사막의 폭풍"
  },
  Skill_49553_Desc = {
    Text = "<Block:[Block:Arg3]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_49553_Name = {Text = "날갯짓"},
  Skill_49554_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_49554_Name = {Text = "쪼기"},
  Skill_49555_Desc = {
    Text = "매 턴마다 <PowerIconKeywords:힘>을 [Arg1]pt 획득한다. 모든 깨어남체의 모든 광기를 제거한다."
  },
  Skill_49555_Name = {
    Text = "사막의 속삭임"
  },
  Skill_49556_Desc = {
    Text = "<Block:[Block:Arg3]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, 1턴간 <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_49556_Name = {
    Text = "광란의 날갯짓"
  },
  Skill_49576_Desc = {
    Text = "3턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다. 실타래드를 [Arg1]pt 및 <AlertIconKeywords:경계> [Arg2]pt를 획득한다. 버린 카드 더미에 <DerivativeCardKeywords_25:「돌」> 3장을 섞어 넣는다."
  },
  Skill_49576_Name = {
    Text = "무한한 정의"
  },
  Skill_49577_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_49577_Name = {Text = "칼날"},
  Skill_49578_Desc = {
    Text = "매 턴마다 힘을 [Arg1]pt 획득하고, 즉시 <AlertIconKeywords:경계> [Arg2]pt를 획득한다."
  },
  Skill_49578_Name = {
    Text = "전장의 지혜"
  },
  Skill_49579_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_49579_Name = {
    Text = "증폭 타격"
  },
  Skill_49580_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 만약 HP를 잃은 적이 있다면, 의도를 즉시 낮은 피해량의 「예리한 칼날」로 변경한다."
  },
  Skill_49580_Name = {
    Text = "심안의 칼날"
  },
  Skill_49581_Desc = {
    Text = "실타래드를 [Arg1]pt 및 경계 [Arg2]pt를 획득한다."
  },
  Skill_49581_Name = {
    Text = "전투 체세"
  },
  Skill_49624_Desc = {
    Text = "<DerivativeCardKeywords_44:음란 녀석> 1장을 손에 넣고, <IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다."
  },
  Skill_49624_Name = {
    Text = "저주의 독"
  },
  Skill_49630_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_49630_Name = {Text = "태동"},
  Skill_49631_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_49631_Name = {Text = "태동"},
  Skill_49632_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_49632_Name = {
    Text = "피의 분사"
  },
  Skill_49633_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_49633_Name = {
    Text = "피의 분사"
  },
  Skill_49743_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_49743_Name = {
    Text = "폭발하는 진홍빛 가시덤불"
  },
  Skill_49834_Desc_1 = {
    Text = "아군의 랜덤 「스킬」 [Arg1]장을 확인 후, 1장을 선택하여 그 스킬의 복사본 [Arg2]장을 행동력 소모가 [Arg3] 감소한 상태로 드로우 덱에 섞어 넣는다."
  },
  Skill_49834_Name_1 = {
    Text = "유일한 씨앗"
  },
  Skill_49834_UnknownName = {
    Text = "유일한 씨앗"
  },
  Skill_49882_Desc = {
    Text = "해제된 무작위 열쇠 지령 3개 중 1개를 선택하여 즉시 발동하며, 그 효과를 2회 적용한다."
  },
  Skill_49882_Name = {
    Text = "은열쇠의 새벽빛"
  },
  Skill_50300_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 치명적 피해를 1회 저항하고 이 「명륜」을 파괴하며, [Arg1]스택 <PVPProtectiveKeywords:장벽>을 획득한다. 발동 시 유일한 생존 아군일 경우, 다음 턴 시작 시 랜덤한 「열쇠 지령」 [Arg2]장을 획득한다."
  },
  Skill_50300_Name_1 = {
    Text = "극야와 새벽"
  },
  Skill_50327_Desc_1 = {
    Text = "목표 하나에게 <DelayKeywords:지연>을 부여합니다: [Arg1] 개의 랜덤 키오링을 획득합니다."
  },
  Skill_50327_Name_1 = {
    Text = "지연 랜덤 열쇠 지령"
  },
  Skill_50329_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_50329_Name = {Text = "강타"},
  Skill_50330_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_50330_Name = {Text = "강타"},
  Skill_50335_Desc = {
    Text = "<Block:[Block:Arg3]>pt의 실타래드를 획득하고, <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_50335_Name = {Text = "날갯짓"},
  Skill_50340_Desc = {
    Text = "끝없는 번식 속에 태어난 정체불명의 산물… 사용 후 모든 깨어남체가 광기 5를 획득하며, 턴 종료 시 손에 남아있을 경우 스스로 복제한다. 이 카드의 행동력 소모는 최소 1이다."
  },
  Skill_50340_Name = {
    Text = "혼란의 자식"
  },
  Skill_50381_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_50381_Name = {
    Text = "가시덤불"
  },
  Skill_50382_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_50382_Name = {Text = "가시"},
  Skill_50383_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_50383_Name = {
    Text = "진홍빛 가시덤불"
  },
  Skill_50384_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_50384_Name = {
    Text = "핏빛 가시"
  },
  Skill_50388_Desc = {
    Text = "주사위를 굴려 나온 눈금에 따라 효과를 획득한다. 1: 모든 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다. 2: 모든 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 3: 모든 적에게 [Arg1]pt의 출혈 피해를 준다. 4: 행동력 2pt를 획득한다. 5: 카드 2장을 뽑는다. 6+: 이것이 바로 라이커의 강운이다! 위의 모든 효과를 획득한다!"
  },
  Skill_50388_Name = {
    Text = "라이커의 행운 주사위"
  },
  Skill_50392_Desc = {
    Text = "결정:<DerivativeCardKeywords_50:“단방향”> 또는 <DerivativeCardKeywords_51:“집결”>"
  },
  Skill_50392_Name = {
    Text = "끝없는 공격"
  },
  Skill_50393_Desc = {
    Text = "깨어남체 1명을 선택하여, 대상의 비용 0 「타격」 3장을 손에 넣고, 대상이 광기 10pt를 획득한다."
  },
  Skill_50393_Name = {Text = "일방"},
  Skill_50394_Desc = {
    Text = "<DerivativeCardKeywords_47:「흡착」> 또는 <DerivativeCardKeywords_48:「고화」> 중 하나를 선택하여 발동한다."
  },
  Skill_50394_Name = {
    Text = "프리온 독소"
  },
  Skill_50395_Desc = {
    Text = "최대 HP의 30%만큼 실타래드를 획득한다."
  },
  Skill_50395_Name = {
    Text = "번데기화"
  },
  Skill_50396_Desc = {
    Text = "<DerivativeCardKeywords_53:「번데기화」> 또는 <DerivativeCardKeywords_54:「잠식」> 중 하나를 선택하여 발동한다."
  },
  Skill_50396_Name = {
    Text = "부활의 고치"
  },
  Skill_50397_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1] 획득하고, <IntoxicationIconKeywords:중독>을 [Arg2]스택 획득한다."
  },
  Skill_50397_Name = {Text = "응고"},
  Skill_50398_Desc = {
    Text = "임시 <PowerIconKeywords:힘>을 [Arg1] 획득한다."
  },
  Skill_50398_Name = {Text = "흡착"},
  Skill_50399_Desc = {
    Text = "모든 깨어남체의 비용 0 「타격」을 각각 1장씩 손에 넣고, 모든 깨어남체가 광기 5pt를 획득한다."
  },
  Skill_50399_Name = {Text = "집결"},
  Skill_50492_Desc = {
    Text = "최대 HP의 30%만큼 HP를 회복하고, 자신에게 취약을 1턴간 부여한다."
  },
  Skill_50492_Name = {Text = "집결"},
  Skill_50699_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 변이 카드 1장을 손에 넣는다."
  },
  Skill_50699_Name = {Text = "징벌"},
  Skill_50700_Desc = {
    Text = "실타래드를 [Arg1]pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득한다. 플레이어가 카드를 1장 사용할 때마다 해당 의도의 추가 효과가 전환된다. 추가 효과는 반격, 정화, 이식 순서로 전환된다."
  },
  Skill_50700_Name = {
    Text = "혈연의 계승"
  },
  Skill_50701_Desc = {
    Text = "실타래드를 [Arg1]pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 자신의 부정 상태를 해제한다. 카드 사용 시, 추가 효과가 이식으로 전환된다."
  },
  Skill_50701_Name = {
    Text = "혈연의 계승\n정화"
  },
  Skill_50702_Desc = {
    Text = "실타래드를 [Arg1]pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 무작위 변이 카드 2장을 손에 넣는다. 카드 사용 시, 추가 효과가 반격으로 전환된다."
  },
  Skill_50702_Name = {
    Text = "혈연의 계승\n이식"
  },
  Skill_50703_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어가 카드를 1장 사용할 때마다 해당 의도의 추가 효과가 전환된다. 추가 효과는 강타, 회복, 약화 순서로 전환된다."
  },
  Skill_50703_Name = {
    Text = "「혼돈의 물어뜯기」"
  },
  Skill_50704_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_50704_Name = {
    Text = "송곳니 물어뜯기"
  },
  Skill_50706_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_50706_Name = {
    Text = "비통의 찢기"
  },
  Skill_50707_Desc = {
    Text = "실타래드를 [Arg1]pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 임시 반격을 [Arg3] 획득한다. 카드 사용 시, 추가 효과가 정화로 전환된다."
  },
  Skill_50707_Name = {
    Text = "혈연의 계승\n반격"
  },
  Skill_50739_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다. 카드 사용 시, 추가 효과가 강타로 전환된다."
  },
  Skill_50739_Name = {
    Text = "「혼돈의 물어뜯기」약화"
  },
  Skill_50740_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다. 카드 사용 시, 추가 효과가 회복으로 전환된다."
  },
  Skill_50740_Name = {
    Text = "「혼돈의 물어뜯기」강타"
  },
  Skill_50741_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, HP를 [Arg3]pt 회복한다. 카드 사용 시, 추가 효과가 약화로 전환된다."
  },
  Skill_50741_Name = {
    Text = "「혼돈의 물어뜯기」회복"
  },
  Skill_50845_Desc = {
    Text = "손의 비파생 명령 카드 1장을 선택하여 행동력 소모가 0인 원본 복사본을 획득하고, <DepleteIconKeywords:소모>와 <RetainIconKeywords:유지>를 부여한다."
  },
  Skill_50845_Name = {
    Text = "신성한 자손"
  },
  Skill_50867_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_50867_Name = {
    Text = "폭발하는 핏빛 가시"
  },
  Skill_51690_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드를 [Arg3]pt 획득하며, 「잉태」 1스택당 실타래드가 [Arg4]pt 증가한다."
  },
  Skill_51690_Name = {
    Text = "탐색 공격"
  },
  Skill_51691_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체를 봉인하며, 전방에 「레무리아의 희망」 2개를 소환한다."
  },
  Skill_51691_Name = {
    Text = "레무리아의 영광!"
  },
  Skill_51692_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 <DerivativeCardKeywords_3:「기절」> [Arg3]장을 섞어 넣는다."
  },
  Skill_51692_Name = {
    Text = "지고의 산제"
  },
  Skill_51693_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 1턴간 봉인한다."
  },
  Skill_51693_Name = {
    Text = "신권의 칼날"
  },
  Skill_51694_Desc = {
    Text = "후방에 「영각의 자식」 1개를 소환하며, 「잉태」 스택이 높을수록 더 강해진다."
  },
  Skill_51694_Name = {
    Text = "선택받은 자"
  },
  Skill_51699_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체를 봉인하며, 전방에 「레무리아의 희망」 2개를 소환한다."
  },
  Skill_51699_Name = {
    Text = "레무리아의 영광!"
  },
  Skill_51700_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 덱에 무작위 증상 카드 [Arg3]장을 섞어 넣는다."
  },
  Skill_51700_Name = {
    Text = "지고의 산제"
  },
  Skill_51701_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <WeaknessIconKeywords:허약>을 부여하며, 실타래드를 [Arg3]pt 획득하고, 「잉태」 1스택당 실타래드가 [Arg4]pt 증가한다."
  },
  Skill_51701_Name = {
    Text = "탐색 공격"
  },
  Skill_51702_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체를 1턴간 봉인하며, 해당 깨어남체 덱 내 무작위 명령 카드 [Arg3]장에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  Skill_51702_Name = {
    Text = "신권의 칼날"
  },
  Skill_51703_Desc = {
    Text = "잃은 HP의 [Arg5]%를 회복하고, 후방에 「영각의 자식」 1개를 소환한다. 「잉태」 스택이 높을수록 회복량과 소환된 자식이 더 강해진다."
  },
  Skill_51703_Name = {
    Text = "선택받은 자"
  },
  Skill_51721_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고 <ComaKeywords:석화>를 부여한다."
  },
  Skill_51721_Name_1 = {Text = "석화"},
  Skill_51733_AwakerSkillBackgroundStory = {
    Text = "그녀는 땅에서 신의 이름으로 행할 것이다. \n그녀는 신의 아름다운 이름을 얻을 것이다. \n그녀는 파괴의 때에, 누구도 견딜 수 없는 고통을 받을 것이다. \n이것이 바로 대행자이다."
  },
  Skill_51733_Desc = {
    Text = "미리암이 광기를 [Energy:Arg3]pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한과 촉수 수가 1 증가하고, 전체 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. <O07CardKeyWord5:「신앙의 종말」> 1장을 손에 넣는다. <CardKeyWord:확고한 자아> 또는 <CardKeyWord:헌신의 계시> 중 하나를 선택한다."
  },
  Skill_51733_EffectNameList = {
    Text = "실타래드, 촉수 피해, 광기"
  },
  Skill_51733_Name = {
    Text = "신앙의 갈림길"
  },
  Skill_51733_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_51734_Desc = {
    Text = "미리암이 광기를 [Energy:Arg1]pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 상한과 촉수 수가 1 증가하고, 전체 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. 턴 종료 시마다 무작위 「신국의 환영」 1장을 손에 넣는다."
  },
  Skill_51734_Name = {
    Text = "신앙의 종말"
  },
  Skill_51735_Desc = {
    Text = "턴 시작 시마다 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, <TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:Arg1] 증가한다."
  },
  Skill_51735_EffectNameList = {
    Text = "실타래드, 촉수 피해"
  },
  Skill_51735_Name = {
    Text = "헌신의 계시"
  },
  Skill_51735_PropertyNameList = {
    Text = "방어력*GrowValue1, 공격력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_51736_Desc = {
    Text = "턴 시작 시마다 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_51736_EffectNameList = {
    Text = "실타래드"
  },
  Skill_51736_Name = {
    Text = "확고한 자아"
  },
  Skill_51736_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_51782_Desc = {
    Text = "깨어남체 1명을 선택하여 [Arg1]pt의 광기를 획득한다. 카드 2장을 드로우한다."
  },
  Skill_51782_Name = {
    Text = "신국의 부름"
  },
  Skill_51783_Desc = {
    Text = "깨어남체 1명을 선택하여 광기를 [Arg1]pt 획득한다. 모든 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_51783_Name = {
    Text = "신국의 신앙"
  },
  Skill_51784_Desc = {
    Text = "깨어남체 1명을 선택하여 [Arg1]pt의 광기를 획득한다. 행동력 2pt를 획득한다."
  },
  Skill_51784_Name = {
    Text = "신국의 강림"
  },
  Skill_51814_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg4]pt 획득하고, 「잠의 자식」, 「물의 자식」, 「영각의 자식」을 각각 1개씩 소환한다. 「잉태」가 추가 효과를 얻는다: 5스택 도달 시 즉시 「물의 자식」 1개를 소환한다."
  },
  Skill_51814_Name = {Text = "깨어남"},
  Skill_51902_BattleDesc = {
    Text = "잃은 HP의 10%([Arg1])를 회복한다. <O07CardKeyWord:의식> 효과를 통해 <O07CardKeyWord3:「집착」>으로 변환되며, 명령 카드의 효과가 강화된다."
  },
  Skill_51902_Desc = {
    Text = "잃은 HP의 10%를 회복한다. <O07CardKeyWord:의식> 효과를 통해 <O07CardKeyWord3:「집착」>으로 변환되며, 명령 카드의 효과가 강화된다."
  },
  Skill_51902_Name = {Text = "성례"},
  Skill_52055_Desc = {
    Text = "미리암이 [Arg1]의 광기를 획득한다. 턴 종료 시 이 카드가 손에 있을 경우, 이 카드는 「성례」로 변환되고 다음 턴에 뽑는 카드 수가 1 감소한다."
  },
  Skill_52055_Name = {Text = "집착"},
  Skill_52076_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_52077_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_52077_Name = {Text = "강화"},
  Skill_52078_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_52079_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_52079_Name = {Text = "강화"},
  Skill_52094_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_52094_Name = {Text = "강화"},
  Skill_52095_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_52096_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_52096_Name = {Text = "강화"},
  Skill_52097_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_52317_Desc = {
    Text = "모든 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_52317_Name = {
    Text = "진실타래한 친구"
  },
  Skill_52318_Desc = {
    Text = "카드 2장을 드로우한다."
  },
  Skill_52318_Name = {
    Text = "안정적인 생활"
  },
  Skill_52319_Desc = {
    Text = "행동력 2pt를 획득한다."
  },
  Skill_52319_Name = {
    Text = "따뜻한 가정"
  },
  Skill_52698_Desc = {
    Text = "카드를 2장 뽑고 행동력 2pt를 획득하지만, 모든 깨어남체가 광기 5pt를 잃는다. 현재 「정해」 자세일 경우, 모든 적에게 <IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다. 보스전에서는 3배의 효과를 발휘한다."
  },
  Skill_52698_Name = {
    Text = "바다의 제사"
  },
  Skill_54041_Desc = {
    Text = "2배의 피해를 입히고 환형 라모나의 은열쇠 충전에 상응하는 은열쇠 에너지를 추가로 600% 획득하지만, 사용 후 <DepleteIconKeywords:소모>됩니다."
  },
  Skill_54041_Name = {
    Text = "미래 찬가"
  },
  Skill_54042_Desc = {
    Text = "행동력 3pt를 획득한다."
  },
  Skill_54042_Name = {
    Text = "윤회의 법정"
  },
  Skill_54377_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 적 깨어남체 사망 후, [Arg1] <StrongEffectKeywords:강효>를 획득하고, 해당 적의 산력 소모가 가장 높으며 <PVPVoidKeywords:허무>가 부여된 「스킬」을 패에 넣습니다."
  },
  Skill_54377_Name_1 = {
    Text = "무수한 총애의 시선"
  },
  Skill_54439_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 [AttackTimes:Arg2]회 입힙니다. 무작위 깨어남체 1명의 모든 카드에 <ErosionColorInkKeywords:인지착란>을 부여합니다."
  },
  Skill_54439_Name = {
    Text = "융식의 먹물 염색"
  },
  Skill_54440_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_54441_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <BlindingKeywords:실타래명>을 부여하고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54442_Desc = {
    Text = "「오를라에게」의 손실타래된 HP를 3% 회복시킵니다."
  },
  Skill_54442_Name = {Text = "관수"},
  Skill_54443_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 [AttackTimes:Arg2]회 입힙니다. 무작위 깨어남체 1명의 모든 카드에 <ColorInkKeywords:인지부조화>를 부여합니다."
  },
  Skill_54443_Name = {
    Text = "먹물 염색"
  },
  Skill_54444_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <WeaknessIconKeywords:허약>을 부여하고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54445_Desc = {
    Text = "4명의 가시 시종을 소환합니다. 모든 카드에 <ErosionColorInkKeywords:인지착란>을 부여합니다. [Arg1] 층의 쇠약, [Arg2] 층의 중독, [Arg3] 층의 <BleedingIconKeywords:출혈>을 적용합니다. 또한 <BlindingKeywords:실타래명>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <VulnerabilityIconKeywords:취약>, <HeavyInjuryKeywords:치명타>을 99 턴 동안 적용합니다."
  },
  Skill_54445_Name = {
    Text = "시의 환상 낙원"
  },
  Skill_54446_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 플레이어의 <PowerIconKeywords:힘>과 <RetaliateIconKeywords:반격>의 50%를 제거한다."
  },
  Skill_54446_Name = {
    Text = "인연의 절단"
  },
  Skill_54447_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. 드로우 더미의 무작위 카드 3장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54448_Desc = {
    Text = "실타래드를 [Arg1]pt 및 <RetaliateIconKeywords:반격> [Arg2]스택, <PowerIconKeywords:힘> [Arg3]pt를 획득한다."
  },
  Skill_54448_Name = {
    Text = "금지된 탐욕"
  },
  Skill_54449_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. 드로우 더미의 무작위 카드 3장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54450_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_54450_Name = {Text = "재단"},
  Skill_54451_Desc = {
    Text = "실타래드를 [Arg1]pt 및 임시 <RetaliateIconKeywords:반격> [Arg2]스택을 획득하고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_54451_Name = {Text = "탐욕"},
  Skill_54452_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <FragileIconKeywords:취약>을 부여하고, 드로우 더미의 무작위 카드 2장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54453_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. <PowerIconKeywords:힘> [Arg3]을 획득하고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54454_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. <PowerIconKeywords:힘> [Arg3]을 획득하고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54455_Desc = {
    Text = "「오를라에게」의 <PowerIconKeywords:힘>을 [Arg1] 증가시킵니다."
  },
  Skill_54455_Name = {Text = "공양"},
  Skill_54456_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 가시 시종 1명을 소환한다. 이후 「탐욕의 노래」의 피해 횟수가 1회 증가한다."
  },
  Skill_54456_Name = {
    Text = "욕망의 노래"
  },
  Skill_54457_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 가시 시종 1명을 소환한다. 이후 「탐욕의 노래」의 피해 횟수가 1회 증가한다."
  },
  Skill_54457_Name = {
    Text = "욕망의 노래"
  },
  Skill_54458_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, [Arg3] 보호막을 획득하며, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54459_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54460_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입히고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54461_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <FragileIconKeywords:취약>을 부여하고, 드로우 더미의 무작위 카드 2장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_54566_Desc = {
    Text = "해제된 열쇠 지령 중 1개를 선택하여 발동한다."
  },
  Skill_54566_Name = {
    Text = "한계 초월 링크"
  },
  Skill_55481_Desc = {
    Text = "초차원 공간의 가장 왼쪽에 있는 카드를 제거하고, 즉시 「영감」 1장을 손에 넣는다. 「소멸」은 1턴에 1번만 사용할 수 있다."
  },
  Skill_55481_Name = {Text = "소멸"},
  Skill_55481_tempBattleDesc_1 = {
    Text = "초차원 공간의 가장 왼쪽에 있는 카드를 제거하고, 즉시 「영감」 1장을 손에 넣는다. 「소멸」은 1턴에 1번만 사용할 수 있다."
  },
  Skill_55481_tempBattleDesc_2 = {
    Text = "초차원 공간의 가장 왼쪽에 있는 카드를 제거하고, 즉시 「영감」 1장을 손에 넣는다. 이번 턴 오를라의 다음 명령 카드가 도약 효과를 발동한다. 「소멸」은 1턴에 1번만 사용할 수 있다."
  },
  Skill_55481_tempBattleDesc_3 = {
    Text = "초차원 공간의 가장 왼쪽에 있는 카드를 꺼낸다. 3턴 쿨다운."
  },
  Skill_55481_tempBattleDesc_4 = {
    Text = "초차원 공간의 명령 카드 1장을 선택하여 꺼내고, 「사용 후 추가로 1회 발동」을 부여하며, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동한다. 3턴 쿨다운."
  },
  Skill_55481_tempBattleDesc_5 = {
    Text = "초차원 공간의 가장 왼쪽에 있는 카드를 꺼낸다. 이번 턴 오를라의 다음 명령 카드가 도약 효과를 발동한다. 3턴 쿨다운."
  },
  Skill_55481_tempBattleDesc_6 = {
    Text = "초차원 공간의 명령 카드 1장을 선택하여 꺼내고, 「사용 후 추가로 1회 발동」을 부여하며, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동한다. 이번 턴 오를라의 다음 명령 카드가 도약 효과를 발동한다. 3턴 쿨다운."
  },
  Skill_55481_tempBattleDesc_7 = {
    Text = "초차원 공간의 명령 카드 1장을 선택하여 꺼내고, 「사용 후 추가 1회 발동」을 부여하며, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동하게 합니다. 즉시 모든 적에게 「운명 재단」의 50%에 해당하는 <FixedDamage:순수 피해>를 입히고, 다음 아라크네의 광기 폭발이 가하는 피해 증폭과 보호막 증가가 50% 상승합니다. 3턴 쿨다운."
  },
  Skill_55481_tempBattleDesc_8 = {
    Text = "초차원 공간의 명령 카드 1장을 선택하여 꺼내고, 「사용 후 추가 1회 발동」을 부여하며, 다음에 사용하는 명령 카드 1장이 <SingularityKeywords3:차원 이동>을 발동하게 합니다. 즉시 모든 적에게 「운명 재단」의 50%에 해당하는 <FixedDamage:순수 피해>를 입히고, 다음 아라크네의 광기 폭발이 가하는 피해 증폭과 보호막 증가가 50% 상승합니다. 이번 턴 오를라의 다음 명령 카드가 도약 효과를 발동합니다. 3턴 쿨다운."
  },
  Skill_55802_Name_1 = {
    Text = "비의 노래"
  },
  Skill_55803_Name_1 = {
    Text = "꽃의 노래"
  },
  Skill_55804_Name_1 = {
    Text = "바람의 노래"
  },
  Skill_56035_Desc = {
    Text = "실타래드를 [Arg1]pt 획득한다."
  },
  Skill_56035_Name = {Text = "대지"},
  Skill_56036_Desc = {
    Text = "잃은 HP의 [Arg1]%([Arg2])를 회복한다."
  },
  Skill_56036_Name = {Text = "샘물"},
  Skill_56037_Desc = {
    Text = "모든 적에게 [Arg1]턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_56037_Name = {Text = "꽃다발"},
  Skill_56038_Desc = {
    Text = "모든 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]턴간 부여한다."
  },
  Skill_56038_Name = {Text = "고양이"},
  Skill_56039_Desc = {
    Text = "무작위로 부정 상태 1개를 해제한다."
  },
  Skill_56039_Name = {Text = "달"},
  Skill_56040_Desc = {
    Text = "실타래드를 [Arg1]pt 획득한다. 이번 턴에 광기 폭발을 3회 발동했다면, 이 카드는 추가로 1회 발동된다."
  },
  Skill_56040_Name = {Text = "대지"},
  Skill_56041_Desc = {
    Text = "잃은 HP의 [Arg1]%([Arg2])를 회복한다. 현재 HP가 25%([Arg3]) 미만일 경우, 이 카드는 추가로 1회 발동된다."
  },
  Skill_56041_Name = {Text = "샘물"},
  Skill_56042_Desc = {
    Text = "모든 적에게 [Arg1]턴간 <WeaknessIconKeywords:허약>을 부여하고, <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>가 부여된 무작위 이미지를 버린 카드 더미에 넣는다."
  },
  Skill_56042_Name = {Text = "꽃다발"},
  Skill_56043_Desc = {
    Text = "모든 적에게 <VulnerabilityIconKeywords:취약>을 [Arg1]턴간 부여한다. 적이 죽을 때마다 이 카드를 덱에서 손으로 가져온다."
  },
  Skill_56043_Name = {Text = "고양이"},
  Skill_56044_Desc = {
    Text = "무작위로 부정 상태 1개를 해제한다. 이 카드는 추가로 3회 발동되며, 이후 소멸된다."
  },
  Skill_56044_Name = {Text = "달"},
  Skill_56045_Desc = {
    Text = "[Arg1]pt의 행동력을 획득한다."
  },
  Skill_56045_Name = {Text = "태양"},
  Skill_56046_Desc = {
    Text = "카드 [Arg1]장을 드로우한다."
  },
  Skill_56046_Name = {Text = "별"},
  Skill_56047_Desc = {
    Text = "모든 깨어남체가 [Arg1]pt의 광기를 획득한다."
  },
  Skill_56047_Name = {Text = "봄"},
  Skill_56048_Desc = {
    Text = "계역 정통을 [Arg1] 증가시키고, 임시 계역 정통을 [Arg2] 증가시킨다."
  },
  Skill_56048_Name = {Text = "시구"},
  Skill_56049_Desc = {
    Text = "덱 또는 버린 카드 더미에서 명령 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 2 감소시킨다."
  },
  Skill_56049_Name = {Text = "나비"},
  Skill_56050_Desc = {
    Text = "[Arg1]pt의 행동력을 획득한다."
  },
  Skill_56050_Name = {Text = "태양"},
  Skill_56051_Desc = {
    Text = "카드 [Arg1]장을 드로우한다."
  },
  Skill_56051_Name = {Text = "별"},
  Skill_56052_Desc = {
    Text = "모든 깨어남체가 [Arg1]pt의 광기를 획득한다."
  },
  Skill_56052_Name = {Text = "봄"},
  Skill_56053_Desc = {
    Text = "임시 영역 숙련도가 [Arg1] 증가한다."
  },
  Skill_56053_Name = {Text = "시구"},
  Skill_56054_Desc = {
    Text = "덱에서 명령 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 1 감소시킨다."
  },
  Skill_56054_Name = {Text = "나비"},
  Skill_56055_Desc = {
    Text = "[Arg1]pt의 열쇠 에너지를 획득한다."
  },
  Skill_56055_Name = {Text = "구름"},
  Skill_56056_Desc = {
    Text = "자신의 최대 HP 100%에 해당하는 <FixedDamage:순수 피해>([Arg1])를 입히며, 해당 피해는 5배의 <PowerIconKeywords:힘> 보너스를 받습니다."
  },
  Skill_56056_Name = {Text = "바람"},
  Skill_56057_Desc = {
    Text = "임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_56057_Name = {Text = "숲"},
  Skill_56058_Desc = {
    Text = "임시 <AlertIconKeywords:경계> [Arg1]pt를 획득한다."
  },
  Skill_56058_Name = {Text = "눈"},
  Skill_56059_Desc = {
    Text = "자신의 최대 HP 150%에 해당하는 <FixedDamage:순수 피해>([Arg1])를 입히며, 해당 피해는 10배의 <PowerIconKeywords:힘> 보너스를 받습니다."
  },
  Skill_56059_Name = {Text = "바람"},
  Skill_56060_Desc = {
    Text = "다음에 사용하는 열쇠 지령이 2회 발동한다."
  },
  Skill_56060_Name = {Text = "구름"},
  Skill_56061_Desc = {
    Text = "임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다. 사용 후 이번 턴에 피해를 1회 줄 때마다 임시 치명타율이 [Arg2]% 증가한다."
  },
  Skill_56061_Name = {Text = "숲"},
  Skill_56062_Desc = {
    Text = "임시 <AlertIconKeywords:경계> [Arg1]pt를 획득한다. 사용 후 이번 턴 동안 모든 깨어남체가 생성하는 실타래드와 회복량이 [Arg2]% 증가한다."
  },
  Skill_56062_Name = {Text = "눈"},
  Skill_56144_Desc = {
    Text = "사용할 수 없음"
  },
  Skill_56144_Name = {Text = "헌시"},
  Skill_56155_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 X+10회 입히는 <DerivativeCardKeywords_12:「쥐 떼 돌격」> 1장을 덱 맨 위에 넣는다."
  },
  Skill_56155_EffectNameList = {
    Text = "「쥐 떼 돌격」 피해"
  },
  Skill_56155_Name = {
    Text = "슈퍼 대집합!"
  },
  Skill_56155_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_56199_Desc = {
    Text = "HP를 <Heal:[Arg1]>pt 회복한다."
  },
  Skill_56199_Name = {
    Text = "비의 찬가"
  },
  Skill_56200_Desc = {
    Text = "임시 크리티컬 확률 +[Arg1]%."
  },
  Skill_56200_Name = {
    Text = "달의 찬가"
  },
  Skill_56201_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_56201_Name = {
    Text = "바람의 찬가"
  },
  Skill_56202_Desc = {
    Text = "4개의 <D06CardKeeperSkill:시편> 중 하나를 선택하고, 해당 선택지를 제거한다. 모든 시편이 선택되면 초기화된다."
  },
  Skill_56202_Name = {
    Text = "봄의 헌시"
  },
  Skill_56203_Desc = {
    Text = "모든 깨어남체가 [Arg1]pt의 광기를 획득한다."
  },
  Skill_56203_Name = {
    Text = "꽃의 찬가"
  },
  Skill_56370_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 즉시 <ResentChainsKeywords:원한의 사슬> 2스택을 획득한다."
  },
  Skill_56370_Name = {
    Text = "차원 잠금"
  },
  Skill_56371_Desc = {
    Text = "전체가 <PowerIconKeywords:힘> [Arg1]pt를 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득하며, <DerivativeCardKeywords_45:「차원 폐쇄」> 1장을 덱에 섞어 넣는다."
  },
  Skill_56371_Name = {
    Text = "차원 방벽"
  },
  Skill_57140_Desc = {
    Text = "「냉혹한 영혼」 2명을 소환하고, 전체 아군이 <CardKeyWord:서리 방패> [Arg1]pt를 획득한다."
  },
  Skill_57140_Name = {
    Text = "냉혹한 영혼"
  },
  Skill_57141_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 맨 위의 명령 카드 1장을 동결한다."
  },
  Skill_57141_Name = {
    Text = "서리 칼날"
  },
  Skill_57338_AwakerSkillBackgroundStory = {
    Text = "그가 거대한 검을 들 때, 반드시 피와 죽음이 따르게 된다."
  },
  Skill_57338_Desc_0 = {
    Text = "기본 데미지가 400% 증가하고 행동력 소모가 0인 <DerivativeCardKeywords_17:\"거대한 검의 위엄\"> 3장을 손패에 넣고, [Arg1]%의 터치손상에 해당하는 임시 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_57338_Desc_3 = {
    Text = "기본 피해가 400% 증가하고 행동력 소모가 0인 <DerivativeCardKeywords_17:「거대한 검의 위엄」> 3장을 손에 넣고, 현재 촉수 피해의 [Arg1]%만큼 임시 <PowerIconKeywords:힘>을 획득한다. 골리아의 임시 치명타율이 [Arg2]% 증가한다."
  },
  Skill_57338_EffectNameList = {
    Text = "촉수 피해%"
  },
  Skill_57338_Name = {Text = "찬탈"},
  Skill_57339_AwakerSkillBackgroundStory = {
    Text = "그가 거대한 검을 들 때, 반드시 피와 죽음이 따르게 된다."
  },
  Skill_57339_Desc_0 = {
    Text = "「참수의 일격」 2장을 손패에 넣고, 해당 카드에 <DepleteIconKeywords:소모>, <PrepareKeypvewords:준비1>, <RetainIconKeywords:보존>을 부여합니다. 이번 전투에서 「거대한 검의 위엄」과 「참수의 일격」의 기본 데미지를 25% 증가시킵니다."
  },
  Skill_57339_Desc_3 = {
    Text = "「참수의 일격」 2장을 손에 넣고, <DepleteIconKeywords:소모>, <PrepareKeypvewords:예비1>, <PrepareKeywords:유지>를 부여한다. 이번 전투 동안 「거대한 검의 위엄」과 「참수의 일격」의 기본 피해가 25% 증가한다. 골리아가 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_57339_Name = {Text = "잠복"},
  Skill_57342_AwakerSkillBackgroundStory = {
    Text = "온전한 철강으로 만들어진 날카로운 칼날은 무겁고, 공기를 가를 때 발생하는 기류는 심지어 바위를 부술 수 있습니다.\n 나의 충성스러운 동료, 나의 믿음직한 거대한 칼이여, 우리는 모두 어둠에서 신생과 무한한 힘을 얻었습니다. 오늘 밤, 우리는 적의 피를 마음껏 마시고; 오늘 밤, 우리는 마음껏 살육할 것입니다."
  },
  Skill_57342_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입힌다. 이 피해에는 <PowerIconKeywords:힘>이 [Arg2]배로 적용된다. 이 카드는 「타격」으로 간주한다."
  },
  Skill_57342_EffectNameList = {Text = "피해"},
  Skill_57342_Name = {
    Text = "거대한 검의 위엄"
  },
  Skill_57342_PropertyNameList = {
    Text = "공격력*GrowValue1,"
  },
  Skill_57550_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「타비에게 답하기」를 손에 넣는다."
  },
  Skill_57550_Name = {
    Text = "진리의 물음"
  },
  Skill_57551_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 10%에 해당하는 <IntoxicationIconKeywords:중독>과 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_57551_Name = {
    Text = "심연의 응시"
  },
  Skill_57552_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_57552_Name = {
    Text = "분쇄의 여섯 날개"
  },
  Skill_57553_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신의 부정 상태를 복사하여 대상에게 부여한다."
  },
  Skill_57553_Name = {
    Text = "동화의 네 날개"
  },
  Skill_57554_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <FragileIconKeywords:손상>을 부여하며, 5장의 카드에 1턴간 「침식」을 부여한다."
  },
  Skill_57554_Name = {Text = "침식"},
  Skill_57555_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>과 <RetaliateIconKeywords:반격>의 15%를 제거한 후 해당 수치만큼 임시 <PowerIconKeywords:힘>과 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_57555_Name = {
    Text = "탈취의 두 날개"
  },
  Skill_57556_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_57556_Name = {
    Text = "「모순」흑익"
  },
  Skill_57557_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 쌍자 융합도가 15% 증가한다."
  },
  Skill_57557_Name = {
    Text = "「모순」 합체"
  },
  Skill_57558_Desc = {
    Text = "2턴간 <WeaknessIconKeywords:허약>과 <BlindingKeywords:실타래명>을 부여한다. 실타래드를 [Arg1]pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 자신의 부정 상태를 해제한다."
  },
  Skill_57558_Name = {
    Text = "「모순」은빛"
  },
  Skill_57568_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「점차적인 망각」 1장을 손에 넣는다. 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_57568_Name = {Text = "망각"},
  Skill_57661_Desc = {
    Text = "신모의 권능 1스택을 회복한다. 신모의 권능은 소모하여 머피의 다른 능력을 발동할 수 있으며, 최대 3스택까지 회복된다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_57661_Name = {
    Text = "짧은 휴식"
  },
  Skill_57662_Desc = {
    Text = "신모의 권능 1스택을 소모하여 힘을 [Arg2] 획득하고, 모든 깨어남체가 <Energy:[Energy:Arg3]>의 광기를 획득한다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_57662_Name = {
    Text = "참수, 왕관의 위엄을 보여라"
  },
  Skill_57663_Desc = {
    Text = "신모의 권능 1스택을 소모하여 모든 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여하고, [Arg2]의 실타래드를 획득하며 동일한 양의 HP를 회복한다. 회복량은 잃은 HP에 비례하며, 최대 2배까지 증가한다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_57663_Name = {
    Text = "희생, 자유의 불꽃을 밝혀라"
  },
  Skill_57664_Desc = {
    Text = "신모의 권능 1스택을 소모하여 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여하고, 이번 턴 모든 깨어남체가 주는 피해가 25% 증가한다. 행동력 1pt를 획득하고 카드를 1장 뽑는다. (현재 남은 신모의 권능: [Arg1]스택)"
  },
  Skill_57664_Name = {
    Text = "훈계, 은혜와 원한을 갚아라"
  },
  Skill_57668_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「융식의 핵심」 1장을 덱에 넣는다."
  },
  Skill_57668_Name = {
    Text = "새로운 시작"
  },
  Skill_57669_Desc = {
    Text = "「안개 방패」를 추가하고, 「망각의 시작」으로 전환된다."
  },
  Skill_57669_Name = {
    Text = "강제 융합"
  },
  Skill_57670_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_57670_Name = {Text = "폐기"},
  Skill_57671_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다. 「어둠의 자식」과 「빛의 자식」으로 분열되며, 융합도 1%당 「빛의 자식」의 HP가 0.5% 감소한다."
  },
  Skill_57671_Name = {
    Text = "거체 붕괴"
  },
  Skill_57699_Desc = {
    Text = "전체 대상이 <ParcloseIconKeywords:장벽> 2스택을 획득하며, 자신은 추가로 5스택을 획득한다."
  },
  Skill_57699_Name = {Text = "장벽"},
  Skill_57754_AwakerSkillBackgroundStory = {
    Text = "부드러운 바다 바람 속에서 그녀는 잠에 빠졌지만, 날개 퍼덕이는 소리에 깨어났다. 온몸이 눈처럼 하얀 작은 새가 그녀의 머리 위를 스쳐 지나가며, 같은 눈처럼 하얀 구름 속으로 사라졌다.\n 그것은 분명 꿈일 것이다. 육지에서 멀리 떨어진 대양 깊은 곳에서 어떻게 홀로 날아가는 새가 있을 수 있을까?\n 그녀는 그렇게 생각하면서도 어쩔 수 없이 희망과 동경을 느꼈다."
  },
  Skill_57754_Desc = {
    Text = "HP를 <Heal:[Heal:Arg1]>pt 회복하고, 행동력을 [Arg2]pt 획득하며 손패의 <SlowIconKeywords:둔화> 상태를 해제한다. <RetainIconKeywords:유지> 1턴당, 다음 사용 시 추가로 HP를 <Heal:[Arg3]>pt 회복한다. 촉수 1개가 적을 공격하여 촉수 피해를 [Arg4]% 입힌다."
  },
  Skill_57754_EffectNameList_0 = {Text = "회복"},
  Skill_57754_EffectNameList_2 = {
    Text = "회복, 추가 회복"
  },
  Skill_57754_Name = {
    Text = "순백의 꿈"
  },
  Skill_57754_PropertyNameList_0 = {
    Text = "체질*GrowValue1,"
  },
  Skill_57754_PropertyNameList_2 = {
    Text = "체질*GrowValue1, 체질*GrowValue2"
  },
  Skill_57760_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <Energy:[Energy:Arg1]>의 광기를 차감하여 <PVPDerivativeCardKeywords_12:「작은 소원」>으로 전환한다. 전환에 실타래패하면 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_57760_Name_1 = {
    Text = "끝없는 연주"
  },
  Skill_57761_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 처음으로 「광기 폭발」 한 후, 임시 <StrongEffectKeywords:강효> +[Arg1]을 부여한다."
  },
  Skill_57761_Name_1 = {
    Text = "목자의 지팡이"
  },
  Skill_57762_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [Arg1]스택 <PVPSleepKeywords:정제된 수면>을 획득한다."
  },
  Skill_57762_Name_1 = {
    Text = "빙하 아래의 잠"
  },
  Skill_57763_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」의 피해가 [Arg1]% 증가한다. 「광기 폭발」 후 잃은 HP의 [Arg2]%를 회복한다."
  },
  Skill_57763_Name_1 = {
    Text = "설산이 녹을 때까지"
  },
  Skill_57764_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 입히는 데미지, 회복 및 방어막 효과가 [Arg1]~[Arg2]% 증가하고,"
  },
  Skill_57764_Name_1 = {
    Text = "운명의 룰렛"
  },
  Skill_57765_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체의 스킬 카드를 사용한 후, 장착한 깨어남체의 스킬 카드 1장을 드로우한다. 매 턴 최대 1회 발동한다."
  },
  Skill_57765_Name_1 = {
    Text = "진리의 문"
  },
  Skill_57805_Desc = {
    Text = "매 턴마다 극야의 미광을 1개 획득한다."
  },
  Skill_57805_Name = {
    Text = "라모나의 지원"
  },
  Skill_57807_Desc = {
    Text = "라모나가 남긴 역류의 힘을 사용하여 전투 시작으로 돌아간다."
  },
  Skill_57807_Name = {
    Text = "라모나의 최종 지원 회귀"
  },
  Skill_57808_Desc = {
    Text = "하멜른이 2턴간 휴식한다. 이후 모든 지원 효과의 사용 횟수가 1 증가한다."
  },
  Skill_57808_Name = {Text = "휴식"},
  Skill_57809_Desc = {
    Text = "쌍자 융합도가 10% 감소한다. 이번 턴에 광기 폭발을 1회 발동할 때마다 쌍자 융합도가 추가로 3% 감소한다. [Arg1]회 사용 가능하다."
  },
  Skill_57809_Name = {Text = "진혼곡"},
  Skill_57810_Desc = {
    Text = "이번 턴에 주는 피해, 중독, 반격이 25% 증가한다. [Arg1]회 사용 가능하다."
  },
  Skill_57810_Name = {Text = "광상곡"},
  Skill_57811_Desc = {
    Text = "행동력 3pt를 획득하고, 카드를 3장 드로우한다. 이번 턴에 명령 카드를 1장 사용할 때마다 전체 깨어남체가 광기 1pt를 획득한다. [Arg1]회 사용 가능하다."
  },
  Skill_57811_Name = {Text = "협주곡"},
  Skill_57812_Desc = {
    Text = "완전히 부활하여 모든 카드와 세 가지 질체를 되찾고, 「극야의 미광」 5장을 획득한다."
  },
  Skill_57812_Name = {
    Text = "라모나의 마지막 지원"
  },
  Skill_57859_Desc = {
    Text = "[Arg2]면체 주사위를 던져, 나온 눈금 × [Arg1]의 임시 <PowerIconKeywords:힘>을 획득한다. 눈금이 4 이상일 경우, 전체 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다. 눈금이 6 이상일 경우, 획득하는 임시 <PowerIconKeywords:힘>이 2배로 증가하고 행동력 1pt를 획득한다."
  },
  Skill_57859_Name = {
    Text = "빛나는 속임수 주사위"
  },
  Skill_57860_Desc = {
    Text = "[Arg2]면체 주사위를 던져, 나온 눈금 × [Arg1]의 임시 <PowerIconKeywords:힘>을 획득한다. 눈금이 4 이상일 경우, 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 눈금이 6 이상일 경우, 획득하는 임시 <PowerIconKeywords:힘>이 2배로 증가한다."
  },
  Skill_57860_Name = {
    Text = "속임수 주사위"
  },
  Skill_57887_Desc = {
    Text = "현재 HP와 최대 HP가 [Arg1] 증가한다. 「안개 방패」를 추가하고, 「완전한 망각의 이치」로 전환된다."
  },
  Skill_57887_Name = {
    Text = "완벽한 융합"
  },
  Skill_57888_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다. 「어둠의 자식」과 「빛의 자식」으로 분열되며, 「빛의 자식」의 HP가 75% 감소하고 영구적으로 기절한다."
  },
  Skill_57888_Name = {
    Text = "융식 분형"
  },
  Skill_57892_Desc = {
    Text = "「<DerivativeCardKeywords_1:유영의 메아리>」 3장을 손에 넣고, 선택 후 해당 옵션을 제거한다."
  },
  Skill_57892_Name = {
    Text = "나아갈 길을 찾아"
  },
  Skill_57893_Desc = {
    Text = "이전 턴에 마지막으로 사용한 서로 다른 명령 카드 3장의 원본 복사본을 획득한다. 해당 카드들의 행동력 소모는 0이다. 「<DerivativeCardKeywords_39:과거의 메아리>」 1장을 손에 넣는다. 선택 후 해당 옵션은 제거된다."
  },
  Skill_57893_Name = {
    Text = "과거를 추억하다"
  },
  Skill_57894_Desc = {
    Text = "「<DerivativeCardKeywords_67:은열쇠 서광>」과 「<DerivativeCardKeywords_41:은열쇠 공명>」을 손에 넣고, 선택 후 해당 옵션을 제거한다."
  },
  Skill_57894_Name = {
    Text = "은열쇠를 움켜쥐다"
  },
  Skill_57895_Desc = {
    Text = "「융식의 핵심」으로 인해 잃은 힘, 반격, 최대 HP를 복원한다. 행동력 5pt를 획득하고, 모든 깨어남체가 광기 100을 획득한다. 모든 <DerivativeCardKeywords_38:환각>을 원래대로 되돌린다."
  },
  Skill_57895_Name = {
    Text = "최초의 링크"
  },
  Skill_57947_Desc = {
    Text = "적 최대 HP의 10%를 감소시킨다. 촉수 1개를 생성하고 임시 촉수 피해를 [Arg1] 획득한다."
  },
  Skill_57947_Name = {
    Text = "왕권의 위엄"
  },
  Skill_57949_Desc = {
    Text = "자신의 <WeaknessIconKeywords:허약>과 힘 감소 상태를 해제한다. 임시 촉수 피해를 [Arg1] 획득한다."
  },
  Skill_57949_Name = {
    Text = "레무리아 재림"
  },
  Skill_57950_Desc = {
    Text = "피해를 총 [Arg1]pt를 입힌다. 촉수 1개당 피해가 [Arg3]pt 증가한다."
  },
  Skill_57950_Name = {
    Text = "심연의 호령"
  },
  Skill_57951_Desc = {
    Text = "「진노」, 「졸음」 12스택을 획득한다. 촉수 피해가 [Arg1] 증가한다."
  },
  Skill_57951_Name = {
    Text = "불멸의 위엄"
  },
  Skill_57969_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「융식의 핵심」 2장을 덱에 넣는다."
  },
  Skill_57969_Name = {
    Text = "망각, 신생의 서막"
  },
  Skill_57971_Desc = {
    Text = "쌍자 융합도가 30% 증가한다."
  },
  Skill_57971_Name = {
    Text = "융합도 업"
  },
  Skill_57972_Desc = {
    Text = "쌍자 융합도가 30% 감소한다."
  },
  Skill_57972_Name = {
    Text = "융합도 다운"
  },
  Skill_58044_Desc = {
    Text = "「무모한 도박」과 「승부의 순간」의 기본 피해를 영구적으로 25% 증가시킨다."
  },
  Skill_58044_Name = {
    Text = "딜러의 승리"
  },
  Skill_58288_Desc = {
    Text = "<C05_yansheng2:빛나는 편방 주사위> 1장을 손에 넣고, 임시 치명타율 [Arg1]%를 획득한다."
  },
  Skill_58288_Name = {
    Text = "한 발의 총성"
  },
  Skill_58494_Name = {Text = "깊은 잠"},
  Skill_58495_Desc = {
    Text = "촉수 피해가 [Arg1] 증가한다."
  },
  Skill_58495_Name = {
    Text = "꿈의 속삭임"
  },
  Skill_58933_AwakerSkillBackgroundStory = {
    Text = "내려가라, 내려가라, 지친 여행자는 곧 돌아올 것이다. 음표가 네 영혼을 부드럽게 어루만져주니, 모든 고통과 집착을 내려놓고 평온한 꿈의 나라로 안심하고 들어가라."
  },
  Skill_58933_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_58933_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 임시 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. 이 카드로 「선율」 효과가 발동되었을 경우, 획득하는 임시 <PowerIconKeywords:힘>이 2배로 증가한다."
  },
  Skill_58933_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 하믈린이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_58933_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 하믈린이 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 임시 <PowerIconKeywords:힘> [Power:Arg3]pt를 획득한다. 이 카드로 「선율」 효과가 발동되었을 경우, 획득하는 임시 <PowerIconKeywords:힘>이 2배로 증가한다."
  },
  Skill_58933_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_58933_Name = {Text = "방어"},
  Skill_58933_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_58939_AwakerSkillBackgroundStory = {
    Text = "높여, 높여, 돛을 조여라, 우리는 먼 곳을 향해 출발할 것이다. 나팔 소리가 너를 위해 울려줄 것이다, 새들이 너를 따라 날아간다. 가장 높은 파도를 넘어가야 한다."
  },
  Skill_58939_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_58939_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득하며, <PowerIconKeywords:임시 힘>을 [Power:Arg3]pt 획득한다. 이 카드로 「선율」 효과가 발동되었을 경우, 획득하는 <PowerIconKeywords:임시 힘>이 2배로 증가한다."
  },
  Skill_58939_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 하믈린이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_58939_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 하믈린이 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, <PowerIconKeywords:임시 힘>을 [Power:Arg3]pt 획득한다. 이 카드로 「선율」 효과가 발동되었을 경우, 획득하는 <PowerIconKeywords:임시 힘>이 2배로 증가한다."
  },
  Skill_58939_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_58939_Name = {Text = "타격"},
  Skill_58939_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_59159_Desc_1 = {
    Text = "대상 한 명에게 <StrongEffectKeywords:강효>를 부여한다."
  },
  Skill_59159_Name_1 = {Text = "강효"},
  Skill_59191_Name = {
    Text = "극야의 미광"
  },
  Skill_59428_Desc_1 = {
    Text = "대상 한 명에게 <ReduceEffectKeywords:강효 감소>를 부여한다."
  },
  Skill_59428_Name_1 = {
    Text = "강효 감소"
  },
  Skill_59476_AwakerSkillBackgroundStory = {
    Text = "이 곡을 듣기 전까지 당신은 진정한 귀를 갖지 못했습니다. 이 곡을 들은 후로는 이런 소리를 다시 찾을 수 없습니다. 그러니 온 정신을 집중하고 숨을 죽여 이 생에 한 번도 듣기 힘든 곡을 찬미해 주세요！"
  },
  Skill_59476_Desc_0 = {
    Text = "하멜른이 <Energy:[Energy:Arg1]> 점의 광기를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시, 「<DerivativeCardKeywords_64:협주의 교향>」 1장을 손에 넣습니다<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_Desc_15 = {
    Text = "하멜른이 <Energy:[Energy:Arg1]> 점의 광기를 얻습니다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시, 「<DerivativeCardKeywords_64:협주의 교향>」 카드 1장을 손에 넣습니다. 턴 시작 시, 「멜로디」를 가진 커맨드 카드 1장당 하멜른이 <Energy:[Energy:Arg2]> 점의 광기를 얻습니다. 「원초의 음률」 발동 시, 멜로디를 가진 커맨드 카드가 2장 존재할 때마다 데미지 횟수+1<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_EffectNameList = {Text = "광기"},
  Skill_59476_Name = {
    Text = "칭송받아 마땅한 곡"
  },
  Skill_59477_AwakerSkillBackgroundStory = {
    Text = "음악은 어디에서 태어나는가? 신을 기쁘게 하는 제례에서, 농부의 노래에서, 원시인의 울부짖음에서, 봄날의 제비 소리에서, 소나무 바람과 바다의 파도에서, 대지의 진동과 산의 붕괴에서…… 아니면 천지의 혼돈 속에서, 신의 꿈속의 꿈결의 속삭임에서."
  },
  Skill_59477_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 무작위로 [Arg3]회 주고, 피해를 1회 줄 때마다 대상의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시키고 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득한다. 손에서 「선율」이 없고, <DepleteIconKeywords:소모>가 아니며 비파생인 명령 카드 1장을 선택하여 「<HuihuanaKeywords:반복되는 선율>」을 부여한다. 조건을 만족하는 카드가 없을 경우, 대신 추가로 3회 피해를 준다."
  },
  Skill_59477_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통 피해>를 [Arg3]회 입히고, 피해를 1회 줄 때마다 대상의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시키며 <PowerIconKeywords:임시 힘>을 [Power:Arg2]pt 획득한다. 손에서 「선율」이 없고 <DepleteIconKeywords:소모>가 아니며 비파생인 명령 카드 1장을 선택하여 「<HuihuanbKeywords:반복되는 선율>」을 부여한다. 조건을 만족하는 카드가 없을 경우, 대신 추가로 3회 피해를 입힌다."
  },
  Skill_59477_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 무작위로 3회 주고, 피해를 1회 줄 때마다 대상의 <PowerIconKeywords:힘> [Arg2]pt를 <TouquKeywords:탈취>한다. 손에서 「선율」이 없고, <DepleteIconKeywords:소모>가 아니며 비파생인 명령 카드 1장을 선택하여 「<HuihuanaKeywords:반복되는 선율>」을 부여한다. 조건을 만족하는 카드가 없을 경우, 대신 추가로 3회 피해를 준다."
  },
  Skill_59477_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 무작위로 3회 주고, 피해를 1회 줄 때마다 대상의 <PowerIconKeywords:힘> [Arg2]pt를 <TouquKeywords:탈취>한다. 손에서 「선율」이 없고, <DepleteIconKeywords:소모>가 아니며 비파생인 명령 카드 1장을 선택하여 「<HuihuanbKeywords:반복되는 선율>」을 부여한다. 조건을 만족하는 카드가 없을 경우, 대신 추가로 3회 피해를 준다."
  },
  Skill_59477_EffectNameList = {
    Text = "피해, 힘 탈취"
  },
  Skill_59477_Name = {
    Text = "원초의 선율"
  },
  Skill_59477_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 무작위로 [Arg3]회 주고, 피해를 1회 줄 때마다 대상의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시키고 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득하며, 대상에게 무작위 <MysterydebuffKeywords:기묘한 부정 효과> 1개를 부여한다. 손에서 「선율」이 없고, <DepleteIconKeywords:소모>가 아니며 비파생인 명령 카드 2장을 선택하여 「<HuihuanbKeywords:반복되는 선율>」을 부여한다. 조건을 만족하는 카드가 없을 경우, 대신 추가로 3회 피해를 준다."
  },
  Skill_59477_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_59478_AwakerSkillBackgroundStory = {
    Text = "만약 영혼을 해부할 수 있다면, 수많은 음표들로 나누어질까? 고음과 저음, 빠른 음과 느린 음, 탄생의 울음과 죽음의 애곡이 한데 어우러져 울려퍼진다. 귀를 기울이라, 크게 따라부르라! 이는 영혼의 본질을 묘사하는 서곡이다."
  },
  Skill_59478_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 무작위로 [Arg2]회 주고, 피해를 줄 때마다 50% 확률로 대상에게 무작위 <MysterydebuffKeywords:기묘한 부정 효과> 1개를 부여한다. 이 카드를 행동력 소모 0으로 사용했을 경우, 추가로 2회 피해를 준다."
  },
  Skill_59478_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 무작위로 3회 주고, 피해를 줄 때마다 50% 확률로 대상에게 무작위 <MysterydebuffKeywords:기묘한 부정 효과> 1개를 부여한다. 이 카드를 행동력 소모 0으로 사용했을 경우, 추가로 2회 피해를 준다."
  },
  Skill_59478_EffectNameList = {Text = "피해"},
  Skill_59478_Name = {
    Text = "영혼의 서곡"
  },
  Skill_59478_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_59479_AwakerSkillBackgroundStory = {
    Text = "당신은 이런 음악 소리를 들어본 적이 있나요? 그것은 그렇게 익숙하고 친근하여 당신의 인생의 여운을 떠올리게 합니다. 도대체 어디서 들어본 걸까요? 당신의 꿈 속에서, 당신의 기억 속에서, 아니면 죽기 전 천국의 소환에서, 그 피리를 불고 있는 천사가 부드럽게 연주한 것입니다."
  },
  Skill_59479_Desc = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. <DerivativeCardKeywords_4:「영감」> 2장을 손에 넣는다. 행동력이 부족할 때에도 사용할 수 있으며, 이 경우 「영감」 2장을 덱에 넣는 효과로 변경된다."
  },
  Skill_59479_EffectNameList = {Text = "힘"},
  Skill_59479_Name = {
    Text = "추억의 회전곡"
  },
  Skill_59479_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_59490_Desc = {
    Text = "다음에 사용하는 비파생 명령 카드의 행동력 소모가 2 증가하고, 2회 발동된다."
  },
  Skill_59490_Name = {Text = "상행음"},
  Skill_59491_Desc = {
    Text = "다음에 사용하는 비파생 명령 카드의 행동력 소모가 2 감소한다."
  },
  Skill_59491_Name = {Text = "하행음"},
  Skill_59665_Desc = {
    Text = "전투 종료 후에도 덱에 남아 있다. 당신은 이미 경비원에게 발각되었다…"
  },
  Skill_59665_Name = {Text = "경계"},
  Skill_59735_Desc = {
    Text = "전체 대상이 잃은 HP의 15%를 회복한다."
  },
  Skill_59735_Name = {
    Text = "성스러운 치유"
  },
  Skill_59736_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <FragileIconKeywords:손상>을 부여하며, 모든 카드에 1턴간 「침식」을 부여한다."
  },
  Skill_59736_Name = {
    Text = "만물의 침식"
  },
  Skill_59737_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「점차적인 망각」 1장을 손에 넣는다. 2턴간 <WeaknessIconKeywords:허약>을 부여하며, <DerivativeCardKeywords_38:환각> 2장을 덱에 섞어 넣는다."
  },
  Skill_59737_Name = {
    Text = "영원한 망각"
  },
  Skill_59738_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다. 「융식의 핵심」 1장을 덱에 넣고, 2턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_59738_Name = {Text = "파멸"},
  Skill_59739_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다. 「융식의 핵심」 1장을 덱에 넣고, 2턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_59739_Name = {
    Text = "완전한 파멸"
  },
  Skill_59740_Desc = {
    Text = "전체 대상의 <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>, <VulnerabilityIconKeywords:취약>, <HeavyInjuryKeywords:중상> 상태를 제거하고, <IntoxicationIconKeywords:중독>을 25% 감소시킨다."
  },
  Skill_59740_Name = {Text = "정화"},
  Skill_59866_Desc = {
    Text = "뒤로 이동하여 「혼돈 강림」 상태로 진입하고 「혼돈」 스택을 최대치로 회복한다. 필드에 「N」의 분신이 존재할 경우, 그에게 장벽 5스택을 부여한 후, 분신을 최대치까지 소환한다. 이미 「암흑」 3스택을 보유하고 있을 경우, 추가로 자신에게 광란 1스택을 부여한다."
  },
  Skill_59866_Name = {
    Text = "혼돈 강림"
  },
  Skill_59867_Desc = {
    Text = "[Arg1]pt의 피해를 [Arg2]회 입히고, 버린 카드 더미에 「경련」 1장을 섞어 넣는다. 필드에 「속삭임」의 분신이 1개 존재할 때마다 추가로 1장씩 섞어 넣는다."
  },
  Skill_59867_Name = {
    Text = "말 없는 공포"
  },
  Skill_60001_Desc = {
    Text = "<MadnessIconKeywords:광란> 1스택을 획득한다. 상대의 임시 <PowerIconKeywords:힘>을 [Arg1] 감소시킨다."
  },
  Skill_60001_Name = {
    Text = "낮게 으르렁거리기"
  },
  Skill_60002_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량과 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_60002_Name = {
    Text = "출혈의 발톱"
  },
  Skill_60003_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_60025_Desc = {
    Text = "덱의 카드 3장의 행동력 소모를 3으로 변경한다."
  },
  Skill_60025_Name = {
    Text = "울음소리"
  },
  Skill_60026_Desc = {
    Text = "1턴간 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_60026_Name = {
    Text = "펼쳐진 날개"
  },
  Skill_60027_Desc = {
    Text = "자신이 사망하여 <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 카드 4장에 <AberrationKeywords:변이>를 부여한다."
  },
  Skill_60027_Name = {
    Text = "꼬리 바늘!"
  },
  Skill_60039_Desc = {
    Text = "장비하지 않은 열쇠 지령 3개를 확인하고, 1개를 선택하여 즉시 발동한다. 행동력 1pt를 획득하고, 자신의 <IntoxicationIconKeywords:중독>, 봉인, <SlowIconKeywords:둔화> 상태를 해제한다."
  },
  Skill_60039_Name = {
    Text = "유토피아의 장막"
  },
  Skill_60040_Desc = {
    Text = "모든 손패를 버리고, 버린 장수 + 3장의 카드를 드로우한다."
  },
  Skill_60040_Name = {
    Text = "기형의 심장"
  },
  Skill_60041_Desc = {
    Text = "깨어남체 1명을 선택하여 [Arg1]pt의 광기를 획득한다."
  },
  Skill_60041_Name = {
    Text = "순수한 답례"
  },
  Skill_60042_Desc = {
    Text = "<ParcloseIconKeywords:장벽> [Arg1]스택을 획득한다."
  },
  Skill_60042_Name = {Text = "꿀 와인"},
  Skill_60047_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg3]스택을 획득한다."
  },
  Skill_60048_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 광기가 가장 높은 깨어남체의 광기를 50% 잃게 한다."
  },
  Skill_60048_Name = {
    Text = "광기 흡수"
  },
  Skill_60060_Desc = {
    Text = "[Arg1]%의 HP를 회복한다. 필드에 「속삭임」 상태의 분신이 1개 존재할 때마다 추가로 잃은 HP의 [Arg2]%를 회복한다."
  },
  Skill_60060_Name = {
    Text = "어둠의 침식"
  },
  Skill_60071_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전방에 「수색 고양이」 [Arg3]마리를 소환한다. 자신의 HP가 낮을수록 소환된 펫이 더 강력해진다."
  },
  Skill_60071_Name = {Text = "사육"},
  Skill_60072_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전방에 「수색 고양이」 [Arg3]마리를 소환한다. 자신의 HP가 낮을수록 소환된 펫이 더 강력해진다."
  },
  Skill_60072_Name = {Text = "사육"},
  Skill_60073_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 전방에 「수색 고양이」 [Arg3]마리를 소환한다. 자신의 HP가 낮을수록 소환된 펫이 더 강력해진다."
  },
  Skill_60073_Name = {Text = "사육"},
  Skill_60074_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 입히고, <HeavyInjuryKeywords:치명타> [Arg3] 턴 동안 지속."
  },
  Skill_60074_Name = {
    Text = "「중상」 비칼"
  },
  Skill_60075_Desc = {
    Text = "후방에 「작은 벌」 [Arg1]마리를 소환한다. 자신의 HP가 낮을수록 소환된 펫이 더 강력해진다."
  },
  Skill_60075_Name = {
    Text = "둥지로의 귀환"
  },
  Skill_60076_Desc = {
    Text = "후방에 「작은 벌」 [Arg1]마리를 소환한다. 자신의 HP가 낮을수록 소환된 펫이 더 강력해진다. 모든 아군에게 장벽 [Arg2]스택을 부여하고, 장벽 수는 턴 수에 따라 증가한다."
  },
  Skill_60076_Name = {
    Text = "둥지로의 귀환"
  },
  Skill_60077_Desc = {
    Text = "후방에 「작은 벌」 [Arg1]마리를 소환한다. 자신의 HP가 낮을수록 소환된 펫이 더 강력해진다."
  },
  Skill_60077_Name = {
    Text = "둥지로의 귀환"
  },
  Skill_60078_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 입히고, <HeavyInjuryKeywords:치명타> [Arg3] 턴 동안 지속."
  },
  Skill_60078_Name = {
    Text = "「중상」 비칼"
  },
  Skill_60079_Desc = {
    Text = "<Damage:[Damage:Arg1]> 포인트의 피해를 [AttackTimes:Arg2] 회 입히고, <HeavyInjuryKeywords:치명타> [Arg3] 턴 동안 지속."
  },
  Skill_60079_Name = {
    Text = "「중상」 비칼"
  },
  Skill_60080_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_60080_Name = {Text = "제재"},
  Skill_60081_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_60081_Name = {Text = "제재"},
  Skill_60082_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_60082_Name = {Text = "제재"},
  Skill_60131_Desc = {
    Text = "실타래드를 [Arg1]pt 및 경계 [Arg2]pt를 획득한다."
  },
  Skill_60131_Name = {
    Text = "기계 무장-수축"
  },
  Skill_60132_Desc = {
    Text = "턴 종료 시 현재 상태에 따라 다른 강화 효과를 획득한다. 전개: 임시 <MadnessIconKeywords:광란> 1스택을 획득한다. 회수: 임시 <ReinforcePVEKeywords:견고> 50스택을 획득한다."
  },
  Skill_60132_Name = {
    Text = "매개변수 조정"
  },
  Skill_60133_Desc = {
    Text = "힘을 [Arg1]pt 획득한다."
  },
  Skill_60133_Name = {
    Text = "기계 무장-전개"
  },
  Skill_60134_Desc = {
    Text = "2턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다. <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 실타래드를 [Arg3]pt 획득한다."
  },
  Skill_60134_Name = {
    Text = "전자기 폭발"
  },
  Skill_60135_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득한다. 「형태 전환」을 할 때마다 피해 횟수와 장벽 획득량이 1씩 증가한다."
  },
  Skill_60135_Name = {
    Text = "기능 과부하"
  },
  Skill_60136_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 임시 <RetaliateIconKeywords:반격>을 [Arg2] 획득한다."
  },
  Skill_60136_Name = {Text = "방어"},
  Skill_60137_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3] 획득한다."
  },
  Skill_60137_Name = {Text = "타격"},
  Skill_60171_Desc = {
    Text = "<BleedingIconKeywords:출혈> [Arg1]스택을 부여하고 실타래드를 [Arg2]pt 획득한다. 출혈 피해는 힘 증가 효과를 받는다."
  },
  Skill_60171_Name = {Text = "출혈"},
  Skill_60172_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량만큼 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_60172_Name = {
    Text = "검술 탐색"
  },
  Skill_60173_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <HeavyInjuryKeywords:중상> [Arg3]스택을 부여한다."
  },
  Skill_60173_Name = {Text = "중상"},
  Skill_60174_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고 임시 <RetaliateIconKeywords:반격> [Arg2]스택을 획득한다."
  },
  Skill_60174_Name = {
    Text = "검의 기세"
  },
  Skill_60175_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량의 10배에 해당하는 HP를 회복한다."
  },
  Skill_60175_Name = {
    Text = "흡혈의 검술"
  },
  Skill_60176_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_60176_Name = {Text = "환영검"},
  Skill_60177_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_60177_Name = {
    Text = "갑옷 파쇄"
  },
  Skill_60178_Desc = {
    Text = "<BleedingIconKeywords:출혈> [Arg1]스택을 부여하고 실타래드를 [Arg2]pt 획득한다. 출혈 피해는 힘 증가 효과를 받는다."
  },
  Skill_60178_Name = {Text = "출혈"},
  Skill_60179_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, <HeavyInjuryKeywords:중상> [Arg2]스택을 부여한다."
  },
  Skill_60179_Name = {
    Text = "검의 의지"
  },
  Skill_60180_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_60180_Name = {
    Text = "갑옷 파쇄"
  },
  Skill_60181_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고 임시 <RetaliateIconKeywords:반격> [Arg2]스택을 획득한다."
  },
  Skill_60181_Name = {
    Text = "검의 기세"
  },
  Skill_60182_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_60182_Name = {Text = "환영검"},
  Skill_60192_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, <HeavyInjuryKeywords:중상> [Arg2]스택을 부여한다."
  },
  Skill_60192_Name = {
    Text = "검의 의지"
  },
  Skill_60193_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량만큼 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_60193_Name = {
    Text = "검술 탐색"
  },
  Skill_60194_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <HeavyInjuryKeywords:중상> [Arg3]스택을 부여한다."
  },
  Skill_60194_Name = {Text = "중상"},
  Skill_60195_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량의 10배에 해당하는 HP를 회복한다."
  },
  Skill_60195_Name = {
    Text = "흡혈의 검술"
  },
  Skill_60252_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_60252_Name = {
    Text = "찢어가르는 칼날"
  },
  Skill_60253_Desc = {
    Text = "<BleedingIconKeywords:출혈> [Arg1]스택을 부여하고 실타래드를 [Arg2]pt 획득한다. 출혈 피해는 힘 증가 효과를 받는다."
  },
  Skill_60253_Name = {
    Text = "혈액 부패"
  },
  Skill_60254_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득하고 임시 <RetaliateIconKeywords:반격>을 [Arg2]스택 획득한다. <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_60254_Name = {
    Text = "검의 기세"
  },
  Skill_60255_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_60255_Name = {
    Text = "갑옷을 꿰뚫는 칼날"
  },
  Skill_60256_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통> 피해를 주고, 대상의 HP가 높을수록 피해량이 증가한다. <FragileIconKeywords:손상>을 [Arg3]중첩 부여한다."
  },
  Skill_60256_Name = {
    Text = "그림자 칼날「<PunctureDamagewords:관통>」"
  },
  Skill_60272_Desc = {
    Text = "무작위 <AberrationKeywords:변이> 3장과 「증상」 1장을 덱에 섞어 넣는다."
  },
  Skill_60272_Name = {
    Text = "이 세상을 위해"
  },
  Skill_60273_Desc = {
    Text = "말해봐, 수호자… 무엇이 너를 아직도 싸우게 만드는 거야?\n이 카드가 손패에 있는 동안 다른 카드를 사용하면, \"타비\"가 분노하여 아군에게 [Arg1]점의 <FixedDamage:순수 피해>를 입힌다."
  },
  Skill_60273_Name = {
    Text = "타비에게 답하기"
  },
  Skill_60274_Desc = {
    Text = "「타비」가 <ExclamationPointColour:원한의 사슬> 3스택을 획득한다."
  },
  Skill_60274_Name = {
    Text = "소중한 사람을 위해"
  },
  Skill_60275_Desc = {
    Text = "무작위로 7장의 명령 카드에 <ErosionColorInkKeywords:인지착란>을 추가합니다."
  },
  Skill_60275_Name = {
    Text = "그저 나 자신을 위해서"
  },
  Skill_60285_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 30pt를 획득하고, 다른 깨어남체는 광기 10pt를 잃는다. 턴 종료 시 이 카드가 손에 있을 경우, 아군에게 [Arg1]pt의 피해를 입힌다."
  },
  Skill_60285_Name = {
    Text = "진·회귀역설"
  },
  Skill_60286_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「진·회귀 역설」 2장을 손에 넣는다."
  },
  Skill_60286_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_60287_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「진·회귀 역설」 6장을 손에 넣는다."
  },
  Skill_60287_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_60288_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「진·회귀 역설」 4장을 손에 넣는다."
  },
  Skill_60288_Name = {
    Text = "네 날개의 성장"
  },
  Skill_60293_Desc = {
    Text = "최대 HP가 2배로 증가한다. 턴 시작 시, 「타비에게 답하기」 1장을 손에 넣는다."
  },
  Skill_60293_Name = {Text = "부활"},
  Skill_60309_Desc = {
    Text = "융식 속에서 투쟁하고, 융식 속에서 소멸한다. 뽑을 때 현재 행동력과 광기의 25%를 잃는다. 사용 후 <PowerIconKeywords:힘>과 <RetaliateIconKeywords:반격>의 20%를 잃는다. 턴 종료 시 손에 있으면 최대 HP가 5% 감소한다."
  },
  Skill_60309_Name = {
    Text = "융식의 핵"
  },
  Skill_60310_Desc = {
    Text = "잃은 HP의 15%([Arg2])를 회복하며, 이번 턴에 광기 폭발을 발동할 때 잃은 HP의 5%를 회복한다. [Arg1]회 사용 가능하다."
  },
  Skill_60310_Name = {Text = "자장가"},
  Skill_60335_Desc = {
    Text = "당신은 세계를 잊고, 세계도 당신을 잊고 있다. 턴 종료 전에 모든 다른 손패를 <DerivativeCardKeywords_38:환각>으로 바꾸고 버린다."
  },
  Skill_60335_Name = {
    Text = "녹아내리는 기억"
  },
  Skill_60397_Desc = {
    Text = "<ReinforcePVEKeywords:견고> 20스택과 <PowerIconKeywords:힘> [Arg1]pt를 획득한다. 이후 피해를 1회 받을 때마다 임시 <ReinforcePVEKeywords:견고> 2스택을 획득한다."
  },
  Skill_60397_Name = {
    Text = "종말 진화"
  },
  Skill_60398_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴 동안 <BlindingKeywords:실타래명>과 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_60398_Name = {
    Text = "「귀면의 물어뜯기」"
  },
  Skill_60399_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt, <PowerIconKeywords:힘> [Arg2]pt, <RetaliateIconKeywords:반격> [Arg3]스택을 획득하고 자신의 부정 상태를 해제한다."
  },
  Skill_60399_Name = {Text = "탈바꿈"},
  Skill_60424_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, <DerivativeCardKeywords_4:「영감」> 1장을 손에 넣는다. 이번 턴에 「음표의 율령」이 발동할 때, <DerivativeCardKeywords_4:「영감」> 1장을 손에 넣는다."
  },
  Skill_60424_Name = {
    Text = "추억의 회전곡\n행동력 ≥2"
  },
  Skill_60425_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량만큼 임시 <PowerIconKeywords:힘>을 획득하며, 피해량의 10배에 해당하는 HP를 회복한다."
  },
  Skill_60425_Name = {
    Text = "원초의 선율\n행동력 ≤2"
  },
  Skill_60426_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 대상의 <PowerIconKeywords:힘>을 [Arg3] 감소시킨다."
  },
  Skill_60426_Name = {
    Text = "하행음\n행동력 1"
  },
  Skill_60427_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 영구 <ReinforcePVEKeywords:견고> [Arg3]스택을 획득한다."
  },
  Skill_60427_Name = {
    Text = "상행음\n행동력 3"
  },
  Skill_60428_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해를 입힐 때마다 무작위 부정 효과 1개를 부여한다. 이후 「영혼의 서곡」의 피해 횟수가 1회 증가한다."
  },
  Skill_60428_Name = {
    Text = "영혼의 서곡\n행동력 0"
  },
  Skill_60475_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_60475_Name = {
    Text = "끝없는 원한"
  },
  Skill_60476_Desc = {
    Text = "전체 아군이 <PowerIconKeywords:힘>을 [Arg1]pt 획득하고, 자신의 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 해제한다."
  },
  Skill_60476_Name = {
    Text = "절망 속의 생존"
  },
  Skill_60477_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_60478_Desc = {
    Text = "모든 의태 깨어남체를 제거한다. 의태 깨어남체 2명을 소환한다. 이번 전투에서 모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  Skill_60478_Name = {
    Text = "어머니의 부름"
  },
  Skill_60479_Desc = {
    Text = "의태 깨어남체 1명을 소환한다. 의태 깨어남체가 가득 찼을 경우, 의도가 「타격」으로 변경된다."
  },
  Skill_60479_Name = {
    Text = "성혈의 본능"
  },
  Skill_60480_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>을 [Arg3]턴간 부여한다."
  },
  Skill_60480_Name = {
    Text = "석질 분해"
  },
  Skill_60481_Desc = {
    Text = "광기가 가장 높은 깨어남체의 광기를 50pt씩 2회 감소시킨다. 2턴간 <BlindingKeywords:실타래명>과 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_60481_Name = {
    Text = "고대의 애무"
  },
  Skill_60482_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 맨 위의 카드 [Arg3]장에게 「<SlowIconKeywords:둔화>」와 「<RetainIconKeywords:유지>」를 부여한다."
  },
  Skill_60482_Name = {
    Text = "정체의 저주"
  },
  Skill_60483_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%만큼 <IntoxicationIconKeywords:중독>, 피해량의 [Arg4]%만큼 <BleedingIconKeywords:출혈>을 부여하며, 피해량의 [Arg5]%만큼 <RetaliateIconKeywords:반격>을 획득한다."
  },
  Skill_60483_Name = {
    Text = "풍요의 의식"
  },
  Skill_60498_Desc = {
    Text = "매 턴 시작 시, 전체 아군이 이전 턴에 받은 피해의 절반만큼 방어막을 획득한다."
  },
  Skill_60498_Name = {
    Text = "아첨의 포옹"
  },
  Skill_60501_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <DerivativeCardKeywords_34:「채워지지 않은 고통」> 2장을 덱에 넣는다."
  },
  Skill_60501_Name = {Text = "고통"},
  Skill_60514_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈> [Arg3]스택을 부여한다."
  },
  Skill_60514_Name = {Text = "비칼"},
  Skill_60515_Desc = {
    Text = "<BloodOath:피의 서약> 10스택을 획득하고, 2턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_60515_Name = {
    Text = "혈홍의 서약"
  },
  Skill_60516_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BloodOath:피의 서약> 1스택당 피해가 [Arg3]pt 증가한다."
  },
  Skill_60516_Name = {
    Text = "죄의 등불"
  },
  Skill_60517_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_60517_Name = {Text = "오염"},
  Skill_60535_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <FragileIconKeywords:손상>을 부여하며, 「피 묻은 심지」 1장을 손에 넣는다."
  },
  Skill_60535_Name = {Text = "오염"},
  Skill_60536_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 무작위로 <FragileIconKeywords:손상> 또는 <HeavyInjuryKeywords:중상>을 2턴간 부여한다. 「피 묻은 심지」 1장을 손에 넣는다."
  },
  Skill_60537_Desc = {
    Text = "<BloodOath:피의 서약> 10스택을 획득하고, 2턴간 <HeavyInjuryKeywords:중상>을 부여한다. 「피 묻은 심지」 1장을 손에 넣는다."
  },
  Skill_60537_Name = {
    Text = "혈홍의 서약"
  },
  Skill_60538_Desc = {
    Text = "<SacrificeKeyWord:희생> [Arg3]pt와 <PowerIconKeywords:힘> [Arg4]pt를 획득한다. 턴 종료 시 이 카드가 손에 있을 경우, 「등불」 아이샤가 HP를 [Arg1] 잃고 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_60538_Name = {
    Text = "피 묻은 심지"
  },
  Skill_60539_Desc = {
    Text = "견고 80스택을 획득하고, 턴 종료 시 <BloodOath:피의 서약> 10스택을 획득한다."
  },
  Skill_60539_Name = {Text = "탈피"},
  Skill_60540_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BloodOath:피의 서약> 1스택당 피해가 [Arg3]pt 증가한다."
  },
  Skill_60540_Name = {
    Text = "죄의 등불"
  },
  Skill_60541_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BleedingIconKeywords:출혈> [Arg3]스택을 부여한다."
  },
  Skill_60541_Name = {Text = "패혈증"},
  Skill_60542_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <BloodOath:피의 서약> 2스택당 피해 횟수가 1회 증가한다."
  },
  Skill_60542_Name = {
    Text = "영원한 촛불"
  },
  Skill_60552_Desc = {
    Text = "「<DerivativeCardKeywords_61:상행음>」 또는 「<DerivativeCardKeywords_62:하행음>」 중 하나를 선택한다."
  },
  Skill_60552_Name = {
    Text = "협주의 교향"
  },
  Skill_60590_BattleDesc = {
    Text = "이번 턴에 다음으로 사용하는 카드의 행동력 소모가 3 이상이면 행동력 2점을 획득하고, 그렇지 않으면 카드 2장을 뽑습니다. 이번 전투에서 4번째로 발동되는 경우, 대신 <DerivativeCardKeywords_4:\"영감\"> 4장을 직접 획득합니다.([Arg1]/4)"
  },
  Skill_60590_Desc = {
    Text = "이번 턴에 다음으로 사용하는 카드의 행동력 소모가 3 이상이면 행동력 2점을 획득하고, 그렇지 않으면 카드 2장을 뽑습니다. 이번 전투에서 4번째로 발동되는 경우, 대신 <DerivativeCardKeywords_4:\"영감\"> 4장을 직접 획득합니다."
  },
  Skill_60590_Name = {
    Text = "네번째 악장"
  },
  Skill_60837_Desc_1 = {
    Text = "[Arg1] 층의<PVPSlowKeywords:느림>을 유발하며, <PVPPenetrateKeywords:관통>합니다."
  },
  Skill_60837_Name_1 = {
    Text = "네번째 악장"
  },
  Skill_60837_UnknownName = {
    Text = "네번째 악장"
  },
  Skill_60845_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 가하고, [Arg2]<PVPSlowKeywords:둔화>, <PVPPenetrateKeywords:관통>."
  },
  Skill_60845_Name_1 = {
    Text = "비창의 약음"
  },
  Skill_60846_Desc_1 = {
    Text = "적 전체에게 <Damage:[Damage:Arg1]> 피해를 입히고, 피해의 [Arg2]% 에 해당하는 <PVPBleedingKeywords:출혈>을 부가하며, 대상이 해제 가능한 부정적 상태를 보유한 경우 [Arg3]%로 상승."
  },
  Skill_60846_Name_1 = {
    Text = "원초의 선율"
  },
  Skill_60848_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 광기를 획득하고, <DelayKeywords:지연>: [Arg2] 행동력 차감."
  },
  Skill_60848_Name_1 = {
    Text = "변방의 화음"
  },
  Skill_60849_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_60849_Name_1 = {
    Text = "경악의 강음"
  },
  Skill_60884_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_60884_Name_1 = {Text = "타격"},
  Skill_60927_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_60928_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_60929_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, 기도 5스택을 획득하며, 마지막 아군과 위치를 교환한다."
  },
  Skill_60929_Name = {Text = "기도"},
  Skill_60930_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 <ParcloseIconKeywords:장벽> 2스택을 획득하며, 최전방 아군과 위치를 교환한다."
  },
  Skill_60931_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_60931_Name = {
    Text = "영원한 촛불"
  },
  Skill_60932_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 힘 [Arg2]pt를 획득하고, 최전방 아군과 위치를 교환한다."
  },
  Skill_60932_Name = {
    Text = "밀랍상 등장"
  },
  Skill_60933_Desc = {
    Text = "<DerivativeCardKeywords_9:비틀거림> 1장과 <DerivativeCardKeywords_32:끈적이는 밀랍> 1장을 덱에 섞어 넣는다. 최후방 아군과 위치를 교환한다."
  },
  Skill_60933_Name = {
    Text = "성대한 접대"
  },
  Skill_60934_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_60934_Name = {
    Text = "밀랍상 등장"
  },
  Skill_60937_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 힘 [Arg2]pt를 획득하고, 최전방 아군과 위치를 교환한다. <DerivativeCardKeywords_9:비틀거림> 1장과 <DerivativeCardKeywords_32:끈적이는 밀랍> 1장을 덱에 섞어 넣는다."
  },
  Skill_60937_Name = {
    Text = "밀랍상 등장"
  },
  Skill_60938_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_60939_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_60939_Name = {
    Text = "밀랍상 등장"
  },
  Skill_60952_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 전체 적에게 [Arg1]스택 <PVPSlowKeywords:둔화>를 부여한다."
  },
  Skill_60952_Name_1 = {
    Text = "영원한 진혼곡"
  },
  Skill_61119_AwakerSkillBackgroundStory = {
    Text = "라크시스가 긴 자를 들고 티리안의 삶을 노래한다:\n스파르타를 도륙한 살인자, 너는 영웅이 될 수 있었지만,\n티히폰이 너의 두 눈을 가렸고, 그녀의 날개는 묶는 밧줄이 되었으며,\n그녀는 너를 증오의 노예로 만들었고, 눈에는 오직 선홍색만이 보인다."
  },
  Skill_61119_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해와 동일한 양의 <BleedingIconKeywords:출혈>을 부여하며, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_61119_Desc_2 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>pt의 피해와 동일한 양의 <BleedingIconKeywords:출혈>을 부여하며, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다. HP가 50% 미만일 경우 획득하는 <PowerIconKeywords:힘>이 2배로 증가한다."
  },
  Skill_61119_EffectNameList = {
    Text = "피해, 힘"
  },
  Skill_61119_Name = {
    Text = "원한 발산"
  },
  Skill_61119_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_61120_AwakerSkillBackgroundStory = {
    Text = "죽여라, 죽여라, 죽음만이 남을 때까지 죽여라."
  },
  Skill_61120_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_61120_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기와 임시 치명타율 및 임시 치명타 피해 [Arg3]%를 획득한다."
  },
  Skill_61120_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 혈쇄·히로가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_61120_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 혈쇄·히로가 <Energy:[Energy:Arg2]>pt의 광기와 임시 치명타율 및 임시 치명타 피해 [Arg3]%를 획득한다."
  },
  Skill_61120_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_61120_Name = {Text = "타격"},
  Skill_61120_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_61121_AwakerSkillBackgroundStory = {
    Text = "아틀로포스가 검은 실타래을 끊자, 티로스인의 운명이 단절되었다. \n족쇄마저 무기로 삼았던 그 용맹하던 암살자도 \n결국 수많은 창 앞에서 쓰러졌다."
  },
  Skill_61121_BattleDesc = {
    Text = "현재 HP의 10%([Arg2])를 잃고, <Damage:[Damage:Arg1]>pt의 피해를 무작위로 2회 입히며 피해량의 50%에 해당하는 <BleedingIconKeywords:출혈>을 부여한다. 이 카드를 3회 사용한 후, 「<DerivativeCardKeywords_66:피에 굶주린 철구>」로 변화한다([Arg3]/3)."
  },
  Skill_61121_Desc = {
    Text = "현재 HP의 10%를 잃고, <Damage:[Damage:Arg1]>pt의 피해를 무작위로 2회 입히며 피해량의 50%에 해당하는 <BleedingIconKeywords:출혈>을 부여한다. 이 카드를 3회 사용한 후, 「<DerivativeCardKeywords_66:피에 굶주린 철구>」로 변화한다."
  },
  Skill_61121_EffectNameList = {Text = "피해"},
  Skill_61121_Name = {
    Text = "선혈의 사슬"
  },
  Skill_61121_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_61122_AwakerSkillBackgroundStory = {
    Text = "아틀로포스가 검은 실타래을 끊자, 티로스인의 운명이 단절되었다. \n족쇄마저 무기로 삼았던 그 용맹하던 암살자도 \n결국 수많은 창 앞에서 쓰러졌다."
  },
  Skill_61122_BattleDesc = {
    Text = "「타격」으로 간주한다. <Damage:[Damage:Arg1]>pt의 피해를 입히며, 이 피해에는 힘이 5배로 적용된다. 대상의 <BleedingIconKeywords:출혈> 30%를 발동시키며, 잃은 HP의 [Arg3]%(<Heal:[Arg2]>)를 회복한다. 사용 후 「<DerivativeCardKeywords_65:피의 사슬>」로 변화한다."
  },
  Skill_61122_Desc = {
    Text = "「타격」으로 간주한다. <Damage:[Damage:Arg1]>pt의 피해를 입히며, 이 피해에는 힘이 5배로 적용된다. 대상의 <BleedingIconKeywords:출혈> 30%를 발동시키며, 잃은 HP의 15%를 회복한다. 사용 후 「<DerivativeCardKeywords_65:피의 사슬>」로 변화한다."
  },
  Skill_61122_EffectNameList = {Text = "피해"},
  Skill_61122_Name = {
    Text = "피에 굶주린 철구"
  },
  Skill_61122_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_61123_AwakerSkillBackgroundStory = {
    Text = "노래하소서, 여신이시여! 델로스의 딸의 운명을 노래하소서:\n피와 눈물, 분노와 절망으로 가득하도다.\n그녀의 증오는 맹렬한 불길처럼 모든 것을 태우고,\n끝내 자신의 죽음을 불러오리라."
  },
  Skill_61123_Desc_0 = {
    Text = "혈쇄·히로가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「<DerivativeCardKeywords_65:피의 사슬>」 1장을 손에 넣고, 혈쇄·히로의 명령 카드가 <RetainIconKeywords:유지>를 획득한다. 턴 시작 시, 혈쇄·히로의 기본 피해가 이번 전투 동안 [Arg2]% 증가한다."
  },
  Skill_61123_Desc_15 = {
    Text = "혈쇄·시로가 <Energy:[Energy:Arg1]> 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「<DerivativeCardKeywords_65:선혈 쇄사>」 1장을 손에 넣고, 혈쇄·시로의 지령 카드가 「<RetainIconKeywords:보류>」를 획득한다. 라운드 시작 시, 혈쇄·시로의 기본 피해가 이번 전투에서 [Arg2]% 증가한다. 광기 폭발 「결박 쇄사」 발동 후, 손에 있는 각기 다른 「혈쇄·시로」 지령 카드마다 50중첩의 <TempPowerKeywords:임시 강화>를 부여한다."
  },
  Skill_61123_EffectNameList = {
    Text = "광기, 피해 증가"
  },
  Skill_61123_Name = {
    Text = "영혼 사냥 선언"
  },
  Skill_61124_AwakerSkillBackgroundStory = {
    Text = "클로토, 클로토, 물레가락을 쥔 여신이여, 그대는 어디서 이 실타래을 가져왔는가? 설령 저 가여운 틸로인이 족쇄를 부순다 한들, 결코 운명의 사슬에서는 벗어날 수 없으리니."
  },
  Skill_61124_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 혈쇄·히로의 명령 카드 1장을 드로우하고, 손에 있는 혈쇄·히로의 명령 카드의 행동력 소모를 1 감소시킨다.] 이번 턴 동안 혈쇄·히로가 주는 능동 피해에 <BleedingIconKeywords:출혈> [Arg2]%를 추가로 부여한다. <Damage:[Damage:Arg1]>pt의 피해를 입힌다."
  },
  Skill_61124_Desc_3 = {
    Text = "[<DevouredIconKeywords:포식> : 혈쇄·히로의 커맨드 카드를 1장 뽑고, 손패의 혈쇄·히로 커맨드 카드 행동력 소모를 1 감소시킨다.]이번 턴 혈쇄·히로가 능동 피해를 줄 때, [Arg2]%<BleedingIconKeywords:출혈>을 부여한다. 대상의 방어막를 파괴하고, <Damage:[Damage:Arg1]> 점의 피해를 주며 대상이 방어막를 획득할 수 없게 하고, 1턴 동안 지속된다."
  },
  Skill_61124_EffectNameList = {
    Text = "피해, 출혈%"
  },
  Skill_61124_Name = {
    Text = "속박의 사슬"
  },
  Skill_61124_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 혈쇄·히로의 커맨드 카드 1장을 뽑고, 손패의 혈쇄·히로 커맨드 카드의 행동력 소모를 1 감소시킵니다.] 이번 회합에서 혈쇄·히로가 능동 피해를 가할 때 [Arg2]% <BleedingIconKeywords:출혈>을 부여합니다. 혈쇄·히로의 크리티컬 피해가 35% 증가하고, 임시 최대 손패 매수 +2, \"원한 발산\"과 \"피의 사슬\" 1장씩을 손패에 추가하며 해당 카드들의 행동력 소모를 -1 합니다."
  },
  Skill_61124_OverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:포식> : 혈쇄·히로의 커맨드 카드를 1장 뽑고, 손패의 혈쇄·히로 커맨드 카드 행동력 소모를 1 감소시킨다.]이번 턴 혈쇄·히로가 능동 피해를 줄 때, [Arg2]%<BleedingIconKeywords:출혈>을 부여한다. 대상의 방어막를 파괴하고, <Damage:[Damage:Arg1]> 점의 피해를 주며 대상이 방어막를 획득할 수 없게 하고, 1턴 동안 지속된다. 혈쇄·히로의 크리티컬 피해가 35% 증가하고, 임시 최대 손패 매수+2, \"원한 발산\"과 \"피의 사슬\" 1장을 손패에 넣고, 해당 카드들의 행동력 소모를 -1 한다."
  },
  Skill_61124_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2%"
  },
  Skill_61124_tempBattleDesc_1 = {
    Text = "[<DevouredIconKeywords:포식>: 혈쇄·히로의 명령 카드 1장을 드로우하고, 손에 있는 혈쇄·히로의 명령 카드의 행동력 소모를 1 감소시킨다.] 이번 턴 동안 혈쇄·히로가 주는 능동 피해에 <BleedingIconKeywords:출혈> [Arg2]%를 추가로 부여한다. <Damage:[Damage:Arg1]>pt의 피해를 입힌다."
  },
  Skill_61124_tempBattleDesc_2 = {
    Text = "[<DevouredIconKeywords:포식> : 혈쇄·히로의 커맨드 카드를 1장 뽑고, 손패의 혈쇄·히로 커맨드 카드 행동력 소모를 1 감소시킨다.]이번 턴 혈쇄·히로가 능동 피해를 줄 때, [Arg2]%<BleedingIconKeywords:출혈>을 부여한다. 대상의 방어막를 파괴하고, <Damage:[Damage:Arg1]> 점의 피해를 주며 대상이 방어막를 획득할 수 없게 하고, 1턴 동안 지속된다."
  },
  Skill_61124_tempBattleDesc_3 = {
    Text = "[<DevouredIconKeywords:포식> : 혈쇄·히로의 커맨드 카드를 1장 뽑고, 손패의 혈쇄·히로 커맨드 카드 행동력 소모를 1 감소시킨다.]이번 턴 혈쇄·히로가 능동 피해를 줄 때, [Arg2]%<BleedingIconKeywords:출혈>을 부여한다. 대상의 방어막를 파괴하고, <Damage:[Damage:Arg1]> 점의 피해를 주며 대상이 방어막를 획득할 수 없게 하고, 1턴 동안 지속된다. 손패의 서로 다른 자신의 커맨드 카드 각각에 50층 \"임시 강화\"를 부여하며, 턴 종료 또는 사용 후 제거된다."
  },
  Skill_61124_tempOverLimitUtlSkillDesc_1 = {
    Text = "[<DevouredIconKeywords:포식>: 혈쇄·히로의 커맨드 카드 1장을 뽑고, 손패의 혈쇄·히로 커맨드 카드의 행동력 소모를 1 감소시킵니다.] 이번 회합에서 혈쇄·히로가 능동 피해를 가할 때 [Arg2]% <BleedingIconKeywords:출혈>을 부여합니다. 혈쇄·히로의 크리티컬 피해가 35% 증가하고, 임시 최대 손패 매수 +2, \"원한 발산\"과 \"피의 사슬\" 1장씩을 손패에 추가하며 해당 카드들의 행동력 소모를 -1 합니다."
  },
  Skill_61124_tempOverLimitUtlSkillDesc_2 = {
    Text = "[<DevouredIconKeywords:포식> : 혈쇄·히로의 커맨드 카드를 1장 뽑고, 손패의 혈쇄·히로 커맨드 카드 행동력 소모를 1 감소시킨다.]이번 턴 혈쇄·히로가 능동 피해를 줄 때, [Arg2]%<BleedingIconKeywords:출혈>을 부여한다. 대상의 방어막를 파괴하고, <Damage:[Damage:Arg1]> 점의 피해를 주며 대상이 방어막를 획득할 수 없게 하고, 1턴 동안 지속된다. 혈쇄·히로의 크리티컬 피해가 35% 증가하고, 임시 최대 손패 매수+2, \"원한 발산\"과 \"피의 사슬\" 1장을 손패에 넣고, 해당 카드들의 행동력 소모를 -1 한다."
  },
  Skill_61124_tempOverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:포식> : 혈쇄·히로의 커맨드 카드를 1장 뽑고, 손패의 혈쇄·히로 커맨드 카드 행동력 소모를 1 감소시킨다.]이번 턴 혈쇄·히로가 능동 피해를 줄 때, [Arg2]%<BleedingIconKeywords:출혈>을 부여한다. 대상의 방어막를 파괴하고, <Damage:[Damage:Arg1]> 점의 피해를 주며 대상이 방어막를 획득할 수 없게 하고, 1턴 동안 지속된다. 혈쇄·히로의 크리티컬 피해가 35% 증가하고, 임시 최대 손패 매수+2, \"원한 발산\"과 \"피의 사슬\" 1장을 손패에 넣고, 해당 카드들의 행동력 소모를 -1 한다. 손패의 서로 다른 자신의 커맨드 카드 각각에 50층 \"임시 강화\"를 부여하며, 턴 종료 또는 사용 후 제거된다."
  },
  Skill_61125_Desc = {
    Text = "혈쇄·히로의 기본 명령 카드 1장을 선택하여 손에 넣는다."
  },
  Skill_61125_Name = {
    Text = "불규칙한 형태·혈쇄"
  },
  Skill_61126_AwakerSkillBackgroundStory = {
    Text = "인내하고 기다려라. 모든 고통 위에 복수의 피가 단비처럼 내릴 것이다."
  },
  Skill_61126_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_61126_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 전체 적의 <BleedingIconKeywords:출혈> [Arg3]%를 발동시킨다."
  },
  Skill_61126_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 혈쇄·히로가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_61126_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 혈쇄·히로가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 전체 적의 <BleedingIconKeywords:출혈> [Arg3]%를 발동시킨다."
  },
  Skill_61126_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_61126_Name = {Text = "방어"},
  Skill_61126_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_61535_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 카드 1장을 동결한다."
  },
  Skill_61535_Name = {
    Text = "얼음 가시"
  },
  Skill_61536_Desc = {
    Text = "턴 종료 시 <Block:[Block:Arg1]>점 <CardKeyWord:서리방패>와 [Arg2]점 <PowerIconKeywords:힘>을 획득합니다."
  },
  Skill_61536_Name = {
    Text = "뼈에 사무치는 추위"
  },
  Skill_61537_Desc = {
    Text = "모든 깨어남체가 광기 10을 잃는다."
  },
  Skill_61537_Name = {Text = "저주"},
  Skill_62216_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_62216_Name = {Text = "종결..."},
  Skill_62217_Desc = {
    Text = "<ReinforcePVEKeywords:견고> [Arg1]스택을 획득한다."
  },
  Skill_62217_Name = {
    Text = "깊은 우주의 주목"
  },
  Skill_62218_Desc = {
    Text = "그분이 당신을 바라보신다. 「증상」 1장을 당신의 덱에 영구적으로 추가한다."
  },
  Skill_62218_Name = {
    Text = "응시-카운트다운: 1"
  },
  Skill_62221_Desc = {
    Text = "자신을 은폐하고, 수많은 세계의 시선을 불러들여 전투에 합류시킨다."
  },
  Skill_62221_Name = {
    Text = "무한한 세계의 눈"
  },
  Skill_62305_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [Arg1]의 <StrongEffectKeywords:강효>를 획득한다. HP를 잃을 때마다, 현재 HP가 [Arg2]% 미만일 경우 <ReinforceKeywords:보강>과 <StrengthenKeywords:강화>를 획득한다."
  },
  Skill_62305_Name_1 = {
    Text = "핏빛 침잠"
  },
  Skill_62306_Desc_1 = {
    Text = "임의의 대상에게 <TauntKeywords:도발>과 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_62306_Name_1 = {
    Text = "산들의 각오"
  },
  Skill_62306_UnknownName = {
    Text = "산맥의 각오"
  },
  Skill_62311_Desc = {
    Text = "1턴간 <FragileIconKeywords:손상>을 부여한다. <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 손에 동결된 카드 1장당 추가로 1회 피해를 주며, 해당 동결된 카드들을 소모한다."
  },
  Skill_62311_Name = {
    Text = "얼음의 말"
  },
  Skill_62312_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 손에 동결된 카드 1장당 피해가 [Arg3]pt 증가한다. 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_62312_Name = {
    Text = "서리의 불꽃"
  },
  Skill_62314_Desc = {
    Text = "「냉혹한 영혼」 2명을 소환하고, 전체 아군이 <CardKeyWord:서리 방패> [Arg1]pt를 획득한다."
  },
  Skill_62314_Name = {
    Text = "냉혹한 영혼"
  },
  Skill_62315_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 손에 동결된 카드 1장당 피해가 [Arg3]pt 증가한다. 3턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_62315_Name = {
    Text = "차가운 불꽃"
  },
  Skill_62316_Desc = {
    Text = "3턴간 <FragileIconKeywords:손상>을 부여한다. <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 손에 동결된 카드 1장당 추가로 1회 피해를 주며, 해당 동결된 카드들을 소모한다."
  },
  Skill_62316_Name = {
    Text = "얼음의 분노"
  },
  Skill_65341_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱 맨 위의 명령 카드 2장을 동결한다."
  },
  Skill_65341_Name = {
    Text = "서리 칼날"
  },
  Skill_65357_Desc = {
    Text = "깨어남체 1명을 선택하여, 해당 깨어남체의 명령 카드를 2장 드로우한다."
  },
  Skill_65357_Name = {
    Text = "산들의 각오"
  },
  Skill_65369_Desc = {
    Text = "탐사단 인원 1명을 잃는다. 카드 [Arg2]장을 뽑고, 행동력 [Arg2]을 획득한다. 최대 HP의 10%([Arg1])를 잃는다."
  },
  Skill_65369_Name = {
    Text = "능동적인 약속"
  },
  Skill_65370_Desc = {
    Text = "탐사단 인원 2명을 잃는다. 카드 [Arg1]장을 뽑고, 행동력 [Arg1]pt를 획득한다. 모든 깨어남체가 [Arg2]pt의 광기를 획득한다."
  },
  Skill_65370_Name = {
    Text = "이성적인 협상"
  },
  Skill_65371_Desc = {
    Text = "탐사단 인원 5명을 잃는다. 모든 깨어남체가 광기 50을 획득하고, 최대 HP의 30%([Arg1])를 회복한다. 카드 [Arg2]장을 뽑고, 행동력 [Arg2]을 획득한다."
  },
  Skill_65371_Name = {Text = "무시"},
  Skill_65372_Desc = {
    Text = "탐사단 인원이 0일 경우, 이 카드는 <DerivativeCardKeywords_9:「비틀거림」>으로 변한다. 턴 종료 후 이 카드가 손에 있을 경우, 다음 턴 시작 시 모든 적이 [Arg1]pt의 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_65372_Name = {Text = "의심"},
  Skill_65393_Desc = {
    Text = "[Arg1]pt의 행동력을 획득하고, 깨어남체 1명을 선택하여 [Arg2]pt의 광기를 획득한다."
  },
  Skill_65393_Name = {
    Text = "인간성의 빛"
  },
  Skill_65451_Desc = {
    Text = "[Arg1]pt의 행동력을 획득하고, 깨어남체 1명을 선택하여 [Arg2]pt의 광기를 획득한다."
  },
  Skill_65451_Name = {
    Text = "희미한 인간성의 빛"
  },
  Skill_65452_Desc = {
    Text = "[Arg1]pt의 행동력을 획득하고, 깨어남체 1명을 선택하여 [Arg2]pt의 광기를 획득한다."
  },
  Skill_65452_Name = {
    Text = "빛나는 인간성의 빛"
  },
  Skill_65453_Desc = {
    Text = "[Arg1]pt의 행동력을 획득하고, 깨어남체 1명을 선택하여 [Arg2]pt의 광기를 획득한다."
  },
  Skill_65453_Name = {
    Text = "어두운 인간성의 빛"
  },
  Skill_65454_Desc = {
    Text = "[Arg1]pt의 행동력을 획득하고, 모든 깨어남체가 [Arg2]pt의 광기를 획득한다."
  },
  Skill_65454_Name = {
    Text = "찬란한 인간성의 빛"
  },
  Skill_65462_Desc = {
    Text = "카드 [Arg2]장을 뽑고, 행동력 [Arg2]pt를 획득한다. 최대 HP의 20%([Arg1])를 잃는다. 모든 깨어남체가 광기 20pt를 잃는다."
  },
  Skill_65462_Name = {
    Text = "전력을 다해 협력"
  },
  Skill_65545_Desc = {
    Text = "최대 HP를 15% 증가시키고, <ReinforcePVEKeywords:견고> [Arg1]스택과 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_65545_Name = {
    Text = "냉동 회복"
  },
  Skill_65546_Desc = {
    Text = "[Arg1]의 서리 방패를 획득하고, <DerivativeCardKeywords_74:경계> 1장을 손에 넣는다."
  },
  Skill_65546_Name = {Text = "경비"},
  Skill_65547_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 손의 모든 동결된 카드를 소모한다."
  },
  Skill_65547_Name = {
    Text = "얼음을 부수는 강타"
  },
  Skill_65548_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_65548_Name = {
    Text = "서늘한 일격"
  },
  Skill_65549_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 완전히 방어되지 않은 피해를 입힐 때마다 동결되지 않은 무작위 명령 카드 1장을 동결한다."
  },
  Skill_65549_Name = {
    Text = "폭풍의 일격"
  },
  Skill_65550_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <SlowIconKeywords:둔화> [Arg3]스택을 부여한다."
  },
  Skill_65550_Name = {
    Text = "서리의 노래"
  },
  Skill_65551_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 턴 종료 전까지 손패 1장당 추가로 1회 피해를 입힌다. (최대 10회)"
  },
  Skill_65551_Name = {
    Text = "얼음 파쇄의 비칼"
  },
  Skill_66041_Desc = {
    Text = "테스트용 카드"
  },
  Skill_66041_Name = {
    Text = "스킬 @ 테스트 카드 A"
  },
  Skill_66042_Desc = {
    Text = "테스트용 카드"
  },
  Skill_66042_Name = {
    Text = "스킬 @ 테스트 카드 B"
  },
  Skill_66043_Desc = {
    Text = "테스트용 카드"
  },
  Skill_66043_Name = {
    Text = "스킬 @ 테스트 카드 C"
  },
  Skill_66282_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_66282_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_66283_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_66283_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_66284_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_66284_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_66285_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_66285_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_66286_Desc = {
    Text = "그분은 의혹을 품고 계신다. 임시 「원한의 사슬」 [Arg1]스택을 획득한다."
  },
  Skill_66286_Name = {
    Text = "속박-카운트다운: 4"
  },
  Skill_66287_Desc = {
    Text = "그분은 매우 호기심이 많으시다. <PowerIconKeywords:힘>을 [Arg1]pt 획득하신다."
  },
  Skill_66287_Name = {
    Text = "강화-카운트다운: 2"
  },
  Skill_66288_Desc = {
    Text = "그분은 의혹을 품고 계신다. 임시 「원한의 사슬」 [Arg1]스택을 획득한다."
  },
  Skill_66288_Name = {
    Text = "속박-카운트다운: 3"
  },
  Skill_66289_Desc = {
    Text = "<ParcloseIconKeywords:장벽> [Arg1]스택을 획득한다."
  },
  Skill_66289_Name = {
    Text = "백치 맹목의 벽"
  },
  Skill_66290_Desc = {
    Text = "적에게 「최고 의지의 위압」을 부여한다: 명령 카드 1장을 사용할 때, 해당 깨어남체의 행동력 소모가 가장 낮은 명령 카드 1장을 버린다."
  },
  Skill_66290_Name = {
    Text = "절대 의지의 권력"
  },
  Skill_66291_Desc = {
    Text = "「융식의 핵심」을 덱에 섞어 넣는다."
  },
  Skill_66291_Name = {
    Text = "만물을 삼키는 망각의 그림자"
  },
  Skill_66292_Desc = {
    Text = "「영원을 꿰뚫는 자물쇠」를 획득한다: 매 턴 종료 시 「원한의 사슬」 1스택을 획득한다."
  },
  Skill_66292_Name = {
    Text = "영원을 꿰뚫는 자물쇠"
  },
  Skill_66296_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_66296_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_66298_Desc = {
    Text = "자신을 은폐하고, 수많은 세계의 시선을 불러들여 전투에 합류시킨다."
  },
  Skill_66298_Name = {
    Text = "무한한 세계의 눈"
  },
  Skill_66300_Desc = {
    Text = "<ReinforcePVEKeywords:견고> [Arg1]스택을 획득하고, 모든 적의 긍정 상태를 해제하며, 자신의 모든 부정 상태를 해제한다."
  },
  Skill_66300_Name = {
    Text = "진·깊은 우주의 주목"
  },
  Skill_66301_Desc = {
    Text = "모든 깨어남체가 광기의 절반을 잃고, 상대는 행동력 상한 5와 손패 상한 10을 잃는다. <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히며, 진정한 원초… 곧 강림한다!"
  },
  Skill_66301_Name = {
    Text = "「세계 붕괴의 융식」"
  },
  Skill_66302_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 모든 깨어남체가 광기 100%를 잃는다. 수호자의 행동력 상한이 5 감소하고, 손패 상한이 10 감소한다."
  },
  Skill_66302_Name = {
    Text = "「세계 붕괴의 융식」"
  },
  Skill_66303_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_66303_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_66304_Desc = {
    Text = "자신의 위치를 이동하여 「시선」의 배열을 변경한다."
  },
  Skill_66304_Name = {
    Text = "환영 이동"
  },
  Skill_66349_AwakerSkillBackgroundStory = {
    Text = "그녀는 과거, 현재, 그리고 미래를 알고 있습니다. \n그녀는 모든 것이 어떻게 시작되었는지, 그리고 어떻게 사라질 지를 알고 있습니다. \n그녀의 귀에는 그 “그”의 숨소리가 울려 퍼집니다."
  },
  Skill_66349_Desc_0 = {
    Text = "이 카드가 손에 있을 때, 덱 맨 위의 카드가 명령 카드일 경우 그 카드의 복사본으로 변한다. 사용 후 원래대로 돌아오며, <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_66349_Desc_1 = {
    Text = "이 카드가 손에 있을 때, 덱 맨 위의 카드가 명령 카드라면 행동력 소모가 1 감소한 그 카드의 복사본으로 변한다. 사용 후 원래대로 돌아오며, <Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_66349_EffectNameList = {Text = "광기"},
  Skill_66349_Name = {
    Text = "만물을 꿰뚫는 이치"
  },
  Skill_66350_AwakerSkillBackgroundStory = {
    Text = "은열쇠의 문을 넘어서, 인간은 그의 왕좌 앞에 엎드려 궁극적인 답을 탐구합니다. \n그리고 그녀는 문지기입니다. 그녀는 저지하고, 경고하며, 주의를 줍니다. \n알리지 않는 것이 그녀의 자비입니다."
  },
  Skill_66350_BattleDesc_0 = {
    Text = "타비가 <Energy:[Energy:Arg1]>점의 광기를 획득합니다. 「<DerivativeCardKeywords_67:은열쇠의 새벽빛>」 1장을 손에 넣습니다. 타비가 행동력 1점을 소비할 때마다 은열쇠 충전의 50%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  Skill_66350_BattleDesc_15 = {
    Text = "타비가 <Energy:[Energy:Arg1]>점의 광기를 획득합니다. 「<DerivativeCardKeywords_67:은열쇠의 새벽빛>」 1장을 손에 넣습니다. 타비가 행동력 1점을 소비할 때마다 은열쇠 충전의 50%에 해당하는 은열쇠 에너지를 획득합니다. 타비가 광기 폭발을 발동한 후, 모든 깨어남체의 이번 턴 명령 카드 최종 피해가 [Arg2]% 증가하며 다음에 사용하는 다른 깨어남체의 명령 카드도 추가 1회 발동됩니다."
  },
  Skill_66350_Desc_0 = {
    Text = "타비가 <Energy:[Energy:Arg1]>점의 광기를 획득합니다. 「<DerivativeCardKeywords_67:은열쇠의 새벽빛>」 1장을 손에 넣습니다. 타비가 행동력 1점을 소비할 때마다 은열쇠 충전의 50%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  Skill_66350_Desc_15 = {
    Text = "타비가 <Energy:[Energy:Arg1]>점의 광기를 획득합니다. 「<DerivativeCardKeywords_67:은열쇠의 새벽빛>」 1장을 손에 넣습니다. 타비가 행동력 1점을 소비할 때마다 은열쇠 충전의 50%에 해당하는 은열쇠 에너지를 획득합니다. 타비가 광기 폭발을 발동한 후, 모든 깨어남체의 이번 턴 명령 카드 최종 피해가 [Arg2]% 증가하며 다음에 사용하는 다른 깨어남체의 명령 카드도 추가 1회 발동됩니다."
  },
  Skill_66350_EffectNameList = {Text = "광기"},
  Skill_66350_Name = {
    Text = "은열쇠의 문"
  },
  Skill_66351_Desc = {
    Text = "행동력이 부족할 때 <Posse:500>pt의 열쇠 에너지를 소모하여 사용할 수 있다. <Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, 타비가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. 카드 1장을 드로우한다. <DerivativeCardKeywords_76:「네 개의 날개가 자라나다」>를 덱에 넣는다."
  },
  Skill_66351_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_66351_Name = {
    Text = "두 날개의 맥동"
  },
  Skill_66351_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_66352_AwakerSkillBackgroundStory = {
    Text = "그녀는 고의로 방해하지 않았다. \n그러나 초월자는 광기에 빠졌다."
  },
  Skill_66352_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_66352_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt와 치명타율 및 치명타 피해 [Arg3]%를 획득한다. 최대 10회 중첩된다([Arg4]/10)."
  },
  Skill_66352_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 타비가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_66352_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 타비가 광기를 <Energy:[Energy:Arg2]>pt와 치명타율 및 치명타 피해 [Arg3]%를 획득한다. 최대 10회 중첩된다."
  },
  Skill_66352_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_66352_Name = {Text = "방어"},
  Skill_66352_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_66353_Desc = {
    Text = "행동력이 부족할 때 <Posse:500>의 열쇠 에너지를 소모하여 사용할 수 있다. <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 6회 준다. 6가지 「추억」 중 하나를 선택하여 효과를 발동할 수 있다. 선택한 「추억」은 이번 스테이지 동안 다시 선택할 수 없다."
  },
  Skill_66353_EffectNameList = {Text = "피해"},
  Skill_66353_Name = {
    Text = "여섯 날개의 해방"
  },
  Skill_66353_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_66354_AwakerSkillBackgroundStory = {
    Text = "그녀는 해를 끼칠 의도가 전혀 없다.\n다만 진리의 문에 틈이 생겼을 뿐이다."
  },
  Skill_66354_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_66354_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기와 치명타율 및 치명타 피해 [Arg3]%를 획득한다. 최대 10회 중첩된다([Arg4]/10)."
  },
  Skill_66354_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 타비가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_66354_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 타비가 <Energy:[Energy:Arg2]>pt의 광기와 치명타율 및 치명타 피해 [Arg3]%를 획득한다. 최대 10회 중첩된다."
  },
  Skill_66354_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_66354_Name = {Text = "타격"},
  Skill_66354_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_66355_BattleDesc = {
    Text = "행동력이 부족할 때 <Posse:500>의 열쇠 에너지를 소모하여 사용할 수 있다. <Damage:[Damage:Arg1]>의 피해를 4회 주고, 카드 1장을 드로우한다. 피해를 줄 때마다 대상의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg2]pt 감소시키고 <PowerIconKeywords:임시 힘> [Power:Arg2]pt를 획득한다. <DerivativeCardKeywords_77:「여섯 날개의 해방」>을 덱에 넣는다."
  },
  Skill_66355_Desc = {
    Text = "행동력이 부족할 때 <Posse:500>의 열쇠 에너지를 소모하여 사용할 수 있다. <Damage:[Damage:Arg1]>의 피해를 4회 주고, 카드 1장을 드로우한다. 피해를 줄 때마다 대상의 임시 <PowerIconKeywords:힘>을 [Power:Arg2]pt <TouquKeywords:탈취>한다. <DerivativeCardKeywords_77:「여섯 날개의 해방」>을 덱에 넣는다."
  },
  Skill_66355_EffectNameList = {
    Text = "피해, 힘 탈취"
  },
  Skill_66355_Name = {
    Text = "네 날개의 성장"
  },
  Skill_66355_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_66356_AwakerSkillBackgroundStory = {
    Text = "일생만물.\n그녀는 시간과 공간을 지배하며, 그녀의 손 끝에서 질서로 가득 찬 세계가 흘러나온다.\n만물귀일.\n무기물과 유기물이 하나의 혼돈으로 뒤섞여, 결국 “그”의 숨결 속에서 공허로 돌아간다."
  },
  Skill_66356_Desc_0 = {
    Text = "이번 턴 동안 자신의 명령 카드 최종 피해가 15% 증가합니다. 은열쇠 에너지를 <Posse:[Arg1]> 획득합니다. 현재 영역의 스킬 카드 중 5장을 <FaxianKeywords:발견>하고 최대 3장을 손패에 추가합니다. 해당 카드들은 타비의 카드로 취급되며, <DepleteIconKeywords:소모>와 <RetainIconKeywords:보존>을 부여합니다. 다음으로 내는 타비의 명령 카드 효과가 2번 발동됩니다."
  },
  Skill_66356_Desc_2 = {
    Text = "이번 턴 동안 자신의 지시 카드 최종 피해가 15% 증가합니다. <Posse:[Arg1]> 포인트의 은빛 키 에너지를 획득합니다. 현재 영역의 스킬 카드에서 <FaxianKeywords:발견>하여 5장 중 최대 3장을 선택해 손에 넣고 타비의 카드로 간주합니다. 이 카드들은 <DepleteIconKeywords:소모>, <PrepareKeypvewords1:준비1> 및 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 지시 카드가 2회 발동합니다."
  },
  Skill_66356_EffectNameList = {
    Text = "은열쇠 에너지"
  },
  Skill_66356_Name = {
    Text = "만물귀일"
  },
  Skill_66356_OverLimitUtlSkillDesc_0 = {
    Text = "타비가 가하는 피해, 방어막, HP 회복이 임시로 [Arg2]% 증가합니다. 행동력 3점과 <Posse:[Arg1]>점의 은열쇠 에너지를 획득합니다. 현재 영역의 스킬 카드 중 <FaxianKeywords:발견> 10장을 하여, 최대 3장을 선택해 손에 넣고 타비의 카드로 취급하며, 해당 카드들은 <DepleteIconKeywords:소모>와 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 커맨드 카드가 2회 발동합니다."
  },
  Skill_66356_OverLimitUtlSkillDesc_2 = {
    Text = "타비가 가하는 피해, 방어막, HP 회복이 임시로 [Arg2]% 증가합니다. 행동력 3점과 <Posse:[Arg1]>점의 은열쇠 에너지를 획득합니다. 현재 영역의 스킬 카드 중 <FaxianKeywords:발견> 10장을 하여, 최대 3장을 선택해 손에 넣고 타비의 카드로 취급하며, 해당 카드들은 <DepleteIconKeywords:소모>, <PrepareKeypvewords1:준비1>과 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 커맨드 카드가 2회 발동합니다."
  },
  Skill_66356_tempBattleDesc_1 = {
    Text = "이번 턴 동안 자신의 지시 카드 최종 피해가 15% 증가합니다. <Posse:[Arg1]> 포인트의 은빛 키 에너지를 획득합니다. 현재 영역의 스킬 카드에서 <FaxianKeywords:발견>하여 5장 중 최대 3장을 선택해 손에 넣고 타비의 카드로 간주합니다. 이 카드들은 <DepleteIconKeywords:소모>, <PrepareKeypvewords1:준비1> 및 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 지시 카드가 2회 발동합니다."
  },
  Skill_66356_tempBattleDesc_2 = {
    Text = "이번 턴 동안 자신의 명령 카드 최종 피해가 15% 증가합니다. 은열쇠 에너지를 <Posse:[Arg1]> 획득합니다. 현재 영역의 스킬 카드 중 5장을 <FaxianKeywords:발견>하고 최대 3장을 손패에 추가합니다. 해당 카드들은 타비의 카드로 취급되며, <DepleteIconKeywords:소모>와 <RetainIconKeywords:보존>을 부여합니다. 다음으로 내는 타비의 명령 카드 효과가 2번 발동됩니다."
  },
  Skill_66356_tempBattleDesc_3 = {
    Text = "모든 깨어남체의 이번 턴 명령 카드 최종 피해가 15% 증가한다. <Posse:[Arg1]>의 열쇠 에너지를 획득한다. 현재 계역의 스킬 카드 중 5장을 <FaxianKeywords:발견>하고, 최대 3장을 선택하여 손에 넣으며 해당 카드들은 타비의 카드로 간주한다. 이 카드들은 <DepleteIconKeywords:소모>, <PrepareKeypvewords:예비1> 및 <RetainIconKeywords:유지>를 획득한다. 다음에 사용하는 타비의 명령 카드와 다른 깨어남체의 명령 카드가 각각 2회 발동한다."
  },
  Skill_66356_tempOverLimitUtlSkillDesc_1 = {
    Text = "타비가 가하는 피해, 방어막, HP 회복이 임시로 [Arg2]% 증가하며, 이번 턴 자신의 커맨드 카드 최종 피해 +15%. 행동력 3점과 <Posse:[Arg1]>점의 은열쇠 에너지를 획득합니다. 현재 영역의 스킬 카드 중 <FaxianKeywords:발견> 10장을 하여, 최대 3장을 선택해 손에 넣고 타비의 카드로 취급하며, 해당 카드들은 <DepleteIconKeywords:소모>와 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 커맨드 카드가 2회 발동합니다."
  },
  Skill_66356_tempOverLimitUtlSkillDesc_2 = {
    Text = "타비가 가하는 피해, 방어막, HP 회복이 임시로 [Arg2]% 증가하며, 이번 턴 자신의 커맨드 카드 최종 피해 +15%. 행동력 3점과 <Posse:[Arg1]>점의 은열쇠 에너지를 획득합니다. 현재 영역의 스킬 카드 중 <FaxianKeywords:발견> 10장을 하여, 최대 3장을 선택해 손에 넣고 타비의 카드로 취급하며, 해당 카드들은 <DepleteIconKeywords:소모>와 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 커맨드 카드가 2회 발동합니다."
  },
  Skill_66356_tempOverLimitUtlSkillDesc_3 = {
    Text = "타비가 가하는 피해, 방어막, HP 회복이 임시로 [Arg2]% 증가하며, 모든 깨어남체의 이번 턴 커맨드 카드 최종 피해가 15% 증가합니다. 행동력 3점과 <Posse:[Arg1]>점의 은열쇠 에너지를 획득합니다. 현재 영역의 스킬 카드 중 <FaxianKeywords:발견> 10장을 하여, 최대 3장을 선택해 손에 넣고 타비의 카드로 취급하며, 해당 카드들은 <DepleteIconKeywords:소모>, <PrepareKeypvewords1:준비1>과 <RetainIconKeywords:보존>을 획득합니다. 다음에 사용하는 타비의 커맨드 카드와 다른 깨어남체의 커맨드 카드가 각각 2회 발동합니다."
  },
  Skill_66357_AwakerSkillBackgroundStory = {
    Text = "그것은 공허, 무한한 시공간 속 유일하고 좁은 틈입니다. \n “수호자”라는 존재는 모든 문제의 답이며, 모든 문살을 여는 키입니다. \n 타비는 여섯 날개를 울리며 그 유일한 존재를 향해 돌진했다."
  },
  Skill_66357_Desc_0 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. <DerivativeCardKeywords_75:「두 개의 날개가 펼쳐지다」>를 덱에 넣는다."
  },
  Skill_66357_Desc_1 = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고 <DerivativeCardKeywords_4:「영감」> 1장을 손에 넣는다. <DerivativeCardKeywords_75:「두 개의 날개가 펼쳐지다」>를 덱에 넣는다."
  },
  Skill_66357_EffectNameList = {Text = "힘"},
  Skill_66357_Name = {
    Text = "시공을 가르는 날개"
  },
  Skill_66357_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_66402_Desc = {
    Text = "깨어남체 1명을 선택하여 <Energy:[Energy:Arg1]> 광기를 부여한다."
  },
  Skill_66402_Name = {
    Text = "순수한 답례"
  },
  Skill_66403_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 비용을 0으로 만든다."
  },
  Skill_66403_Name = {
    Text = "극야의 미광"
  },
  Skill_66404_Desc = {
    Text = "모든 손패를 버리고, 버린 장수 + 3장의 카드를 드로우한다."
  },
  Skill_66404_Name = {
    Text = "기형의 심장"
  },
  Skill_66405_Desc = {
    Text = "맨 뒷줄 적에게 대상 최대 HP [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, 해당 피해는 자신의 최대 HP 300% 이하로 내려가지 않습니다."
  },
  Skill_66405_Name = {
    Text = "대행자의 판결"
  },
  Skill_66406_Desc = {
    Text = "임시 <ParcloseIconKeywords:장벽> 1스택을 획득한다."
  },
  Skill_66406_Name = {Text = "벌꿀 술"},
  Skill_66407_Desc = {
    Text = "열쇠 지령 3개를 확인하고, 그 중 1개를 선택하여 즉시 발동한다."
  },
  Skill_66407_Name = {
    Text = "유토피아의 장막"
  },
  Skill_66444_Desc_1 = {
    Text = "깨어남체 한 명을 선택하여 해당 깨어남체의 HP를 지난 턴 시작 시로 되돌리고, <PVPWeaknessKeywords:허약>과 <PVPVulnerabilityIconKeywords:약점>을 부여."
  },
  Skill_66444_Name_1 = {
    Text = "초월과 회귀"
  },
  Skill_66445_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_66445_Name_1 = {Text = "타격"},
  Skill_66446_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 피해와 [Arg2] <PVPfengsuoKeywords:폭발 봉인>을 부여합니다."
  },
  Skill_66446_Name_1 = {
    Text = "만물 귀일"
  },
  Skill_66448_Desc_1 = {
    Text = "전체 아군에게 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_66448_Name_1 = {
    Text = "시공의 틈새"
  },
  Skill_66449_Desc_1 = {
    Text = "<DelayKeywords:지연>: 아군 한 명에게 <Energy:[Energy:Arg1]> 광기를 부여."
  },
  Skill_66449_Name_1 = {
    Text = "완전한 계승"
  },
  Skill_66458_Desc = {
    Text = "현재 HP와 실타래드를 이전 턴 종료 시의 상태로 되돌린다."
  },
  Skill_66458_Name = {
    Text = "과거의 메아리"
  },
  Skill_66498_BattleDesc_1 = {
    Text = "아군 1명을 선택하여, 적의 손패 중 행동력 소모가 가장 높은 스킬 카드 [Arg1]장을 복사하게 하고, 해당 카드의 행동력 소모를 -[Arg2]합니다. 상대방의 손패에는 현재 [Arg3]장의 스킬이 있습니다."
  },
  Skill_66498_Desc_1 = {
    Text = "아군 한 명을 선택하여, 적 패에서 산력 소모가 가장 높은 스킬 카드 [Arg1] 장을 복사하고, 해당 카드의 산력 소모를 -[Arg2] 합니다."
  },
  Skill_66498_Name_1 = {
    Text = "문의 해답"
  },
  Skill_66498_UnknownName = {Text = "문의 답"},
  Skill_66499_Desc = {
    Text = "무작위 열쇠 지령 3개를 <FaxianKeywords:발견>하고, 그 중 1개를 선택하여 효과를 발동하며 <Posse:[Arg1]>pt의 열쇠 에너지를 획득한다."
  },
  Skill_66499_Name = {
    Text = "문의 해답"
  },
  Skill_66520_Desc = {
    Text = "「<Qunxingzhijiu:별빛의 술>」"
  },
  Skill_66520_Name = {
    Text = "별들의 술"
  },
  Skill_66525_Desc = {
    Text = "「<Zhanxindeqianbao:새 지갑>」"
  },
  Skill_66525_Name = {Text = "새 지갑"},
  Skill_66526_Desc = {
    Text = "「<Wushangrongchong:최고의 영광>」"
  },
  Skill_66526_Name = {
    Text = "최고의 영광"
  },
  Skill_66527_Desc = {
    Text = "「<Canquemiankong:불완전한 얼굴>」"
  },
  Skill_66527_Name = {
    Text = "부서진 가면"
  },
  Skill_66528_Desc = {
    Text = "「<Xingdaozhihai:여정의 유골>」"
  },
  Skill_66528_Name = {
    Text = "여정의 유골"
  },
  Skill_66529_Desc = {
    Text = "「<Chunzhiji:봄의 제전>」"
  },
  Skill_66529_Name = {
    Text = "봄의 제사"
  },
  Skill_66530_Desc = {
    Text = "「<Huoxingzhusheqi:활성 주사기>」"
  },
  Skill_66530_Name = {
    Text = "활성 주사기"
  },
  Skill_66531_Desc = {
    Text = "「<Jingmijishiqi:정밀 계측기>」"
  },
  Skill_66531_Name = {
    Text = "정밀 계측기"
  },
  Skill_66532_Desc = {
    Text = "「<Huaibiaojing:회중시계 거울 β>」"
  },
  Skill_66532_Name = {
    Text = "회중시계 거울 β"
  },
  Skill_66533_Desc = {
    Text = "「<Shiluozhimei:상실타래의 아름다움>」"
  },
  Skill_66533_Name = {
    Text = "상실타래의 아름다움"
  },
  Skill_66534_Desc = {
    Text = "「<Tongxunshebei:통신 장비 β>」"
  },
  Skill_66534_Name = {
    Text = "통신 장비 β"
  },
  Skill_66535_Desc = {
    Text = "「<Etong:악동>」"
  },
  Skill_66535_Name = {Text = "악동"},
  Skill_66536_Desc = {
    Text = "「<Biansejushufu:변색 구속복 β>」"
  },
  Skill_66536_Name = {
    Text = "변색 구속복 β"
  },
  Skill_66537_Desc = {
    Text = "「<Renyuleizhu:인어의 눈물>」"
  },
  Skill_66537_Name = {
    Text = "인어의 눈물"
  },
  Skill_66538_Desc = {
    Text = "「<Kuailechangpian:행복한 레코드>」"
  },
  Skill_66538_Name = {
    Text = "행복한 레코드"
  },
  Skill_66721_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시와 턴 시작 시, 자신에게 <PVPProtectiveKeywords:장벽>이 없으면 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 획득하고, 그렇지 않으면 <StrengthenKeywords:강화>를 획득한다."
  },
  Skill_66721_Name_1 = {
    Text = "은세의 윤회"
  },
  Skill_66891_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 다른 아군 깨어남체가 사망한 후, <Block:[Block:Arg1]>의 실타래드를 획득하고, 그 깨어남체의 행동력 소모가 가장 낮은 「스킬」을 손에 넣는다."
  },
  Skill_66891_Name_1 = {
    Text = "순은의 초심"
  },
  Skill_67110_Desc = {
    Text = "이 창백한 피리 소리 속에서 다시 잠들어라…"
  },
  Skill_67110_Name = {
    Text = "영원한 잠"
  },
  Skill_67168_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 2턴간 <HeavyInjuryKeywords:중상>을 부여한다."
  },
  Skill_67168_Name = {
    Text = "중상 돌격"
  },
  Skill_67169_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 자신의 최대 HP가 [Arg3]% 증가하며, 플레이어의 최대 HP가 [Arg3]% 감소한다."
  },
  Skill_67169_Name = {
    Text = "등가 교환"
  },
  Skill_67170_Desc = {
    Text = "「통 속의 뇌 분체」가 「영질 분리」를 발동할 때, <TouquKeywords:영구 탈취>로 <PowerIconKeywords:힘> 5%를 추가로 빼앗는다. 턴 종료 시, 「통 속의 뇌 분체」 1명을 소환한다."
  },
  Skill_67170_Name = {
    Text = "영혼과 육체의 @1분"
  },
  Skill_67171_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하며, 「부정형 장벽」 상태를 획득한다. 「부정형 장벽」: 행동력을 소모할 때마다 실타래드를 <Block:[Block:Arg3]>pt 및 임시 견고를 3스택 획득한다."
  },
  Skill_67171_Name = {
    Text = "부정형 장벽"
  },
  Skill_67172_Desc = {
    Text = "모든 「종말」을 제거하고, 플레이어의 최대 HP를 1로 변경한다."
  },
  Skill_67172_Name = {
    Text = "허무의 종말"
  },
  Skill_67173_Desc = {
    Text = "임시 <PowerIconKeywords:힘>을 [Power:Arg1]pt 획득하고, 실타래드를 <Block:[Block:Arg2]>pt 획득한다."
  },
  Skill_67173_Name = {
    Text = "칠예, 전승된 미덕"
  },
  Skill_67174_Desc = {
    Text = "턴 종료 시 <PowerIconKeywords:힘>을 [Power:Arg1]pt 획득한다. 실타래드가 파괴될 경우, 획득하는 임시 <ReinforcePVEKeywords:견고>가 35스택에서 75스택으로 증가한다."
  },
  Skill_67174_Name = {
    Text = "기사의 열정"
  },
  Skill_67175_Desc = {
    Text = "[Arg1]pt의 피해를 [Arg2]회 입히고, 플레이어가 유지한 카드를 버린다."
  },
  Skill_67175_Name = {
    Text = "약점 타격"
  },
  Skill_67176_Desc = {
    Text = "「비틀거림」, 「질식」, 「산호 증식」, 「모독의 환영」, 「광란」 중 1장을 선택하여 손에 넣고, 나머지 4장은 버린 카드 더미에 넣는다."
  },
  Skill_67176_Name = {
    Text = "세계 연역법"
  },
  Skill_67177_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 주고, 2턴간 <FragileIconKeywords:손상>을 부여한다. 실타래드가 파괴될 경우, 「중상 돌진」으로 변경된다: 손상 대신 중상을 부여한다."
  },
  Skill_67177_Name = {
    Text = "방패 파괴 충격"
  },
  Skill_67178_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 동일한 양의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  Skill_67178_Name = {
    Text = "종말의 광상"
  },
  Skill_67180_Desc = {
    Text = "다음 [Arg1]턴 동안, 매 턴 종료 시 「통 속의 뇌 분체」 1명을 소환한다."
  },
  Skill_67180_Name = {Text = "분리"},
  Skill_67181_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 [Arg2]회 주고, 이후 발동하는 「여왕의 검」의 피해 횟수가 1 증가한다."
  },
  Skill_67181_Name = {
    Text = "여왕의 검"
  },
  Skill_67182_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통> 피해를 [Arg2]회 주고 동일한 양의 <BleedingIconKeywords:출혈>을 부여하며, 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 실타래드가 파괴될 경우, 「격노의 창」으로 변경된다: 관통 피해와 출혈을 부여하지 않지만, 피해 횟수가 1 증가한다."
  },
  Skill_67182_Name = {
    Text = "「관통」의 창"
  },
  Skill_67183_Desc = {
    Text = "<Damage:[Damage:Arg1]> 데미지를 [Arg2] 회 입힙니다."
  },
  Skill_67183_Name = {Text = "타격"},
  Skill_67184_Desc = {
    Text = "드로우 단계 종료 후 손에서 무작위로 명령 카드 3장을 공개하고, 1장을 선택하여 「메아리」 각인을 부여하며, 나머지 카드는 버린다."
  },
  Skill_67184_Name = {
    Text = "제일 철학"
  },
  Skill_67185_Desc = {
    Text = "2턴간 <WeaknessIconKeywords:허약>을 부여하고, <IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여한다."
  },
  Skill_67185_Name = {
    Text = "외계 수술"
  },
  Skill_67186_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여한다. 턴 종료 시, 다른 적들이 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다."
  },
  Skill_67186_Name = {
    Text = "숙명 붕괴"
  },
  Skill_67187_Desc = {
    Text = "<TouquKeywords:영구 탈취>로 <PowerIconKeywords:힘> [Arg1]pt를 획득하고 상대의 <RetaliateIconKeywords:반격> 50%를 제거하며, 「추론」이 없는 5장의 카드에 「추론」을 부여한다."
  },
  Skill_67187_Name = {
    Text = "공세 연습"
  },
  Skill_67188_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 「심연의 문」을 열어 매 턴 종료 시 적을 보충하며, 최대 2명까지 보충된다."
  },
  Skill_67188_Name = {
    Text = "종점, 진리와 심연의 문"
  },
  Skill_67189_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 주고, 자신에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_67189_Name = {
    Text = "「분노」의 창"
  },
  Skill_67190_Desc = {
    Text = "2턴간 <WeaknessIconKeywords:허약>을 부여하고, <ReinforcePVEKeywords:견고> [Arg2]스택을 획득한다."
  },
  Skill_67190_Name = {
    Text = "자폭 개조"
  },
  Skill_67191_Desc = {
    Text = "턴 시작 시 「종말」 1스택을 획득한다. 플레이어가 카드를 사용할 때마다 <ReinforcePVEKeywords:견고> [Arg1]스택을 획득한다. 치명적 피해를 받을 경우, 이 상태를 제거하고 1턴간 피해를 면역하며, HP를 15% 회복하고 의도를 「허무 종결」로 전환한다."
  },
  Skill_67191_Name = {
    Text = "영혼의 역병"
  },
  Skill_67348_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득하며 「종말」 1스택을 획득한다. 다른 모든 적을 처치했다면, 의도가 「운명 붕괴」로 변경된다."
  },
  Skill_67348_Name = {
    Text = "종말의 부름"
  },
  Skill_67349_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득하며 「종말」 1스택을 획득한다. 다른 모든 적을 처치했다면, 의도가 「자폭 개조」로 변경된다."
  },
  Skill_67349_Name = {
    Text = "종말의 부름"
  },
  Skill_67383_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 자신의 최대 HP가 [Arg3]% 증가하며, 플레이어의 최대 HP가 [Arg4]% 감소한다."
  },
  Skill_67383_Name = {
    Text = "등가 교환"
  },
  Skill_67421_Desc = {
    Text = "<Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통> 피해를 [AttackTimes:Arg2]회 주며, 이 피해는 회피할 수 없다."
  },
  Skill_67421_Name = {Text = "종결..."},
  Skill_67431_Desc = {
    Text = "「<Heizhu:검은 양초>」"
  },
  Skill_67431_Name = {
    Text = "검은 양초"
  },
  Skill_67433_Desc = {
    Text = "「<Guishulimao:속임수의 모자>」"
  },
  Skill_67433_Name = {
    Text = "속임수의 모자"
  },
  Skill_67434_Desc = {
    Text = "「<Slbbujie:시계추·불결>」"
  },
  Skill_67434_Name = {
    Text = "시계추·불결함"
  },
  Skill_67435_Desc = {
    Text = "「<Slbbumian:시계추·불면>」"
  },
  Skill_67435_Name = {
    Text = "시계추·불면"
  },
  Skill_67436_Desc = {
    Text = "「<Szeyunyishiniao:축복·재앙 의식의 새>」"
  },
  Skill_67436_Name = {
    Text = "축복·재앙 의식의 새"
  },
  Skill_67437_Desc = {
    Text = "「<Shishengchangji:소리를 잃은 축음기>」"
  },
  Skill_67437_Name = {
    Text = "소리 없는 축음기"
  },
  Skill_67438_Desc = {
    Text = "「<Yishengshoutixiang:의사의 가방>」"
  },
  Skill_67438_Name = {
    Text = "의사의 가방"
  },
  Skill_67441_Desc = {
    Text = "「<Slbyiyong:시계추·물결>」"
  },
  Skill_67441_Name = {
    Text = "시계추·물결"
  },
  Skill_67442_Desc = {
    Text = "「<Szxingdaozhihai:축복·여정의 유골>」"
  },
  Skill_67442_Name = {
    Text = "축복·여정의 유골"
  },
  Skill_67443_Desc = {
    Text = "「<Baiyahui:흰 까마귀 부리>」"
  },
  Skill_67443_Name = {
    Text = "흰 까마귀 부리"
  },
  Skill_67444_Desc = {
    Text = "「<Chansimanao:줄마노>」"
  },
  Skill_67444_Name = {
    Text = "실타래올 마노"
  },
  Skill_67445_Desc = {
    Text = "「<Meilishunjian:아름다운 순간 β>」"
  },
  Skill_67445_Name = {
    Text = "아름다운 순간 β"
  },
  Skill_67446_Desc = {
    Text = "「<Yuanxingdianchi:원형 배터리>」"
  },
  Skill_67446_Name = {
    Text = "프로토타입 배터리"
  },
  Skill_67447_Desc = {
    Text = "「<Guguaigouzhua:기이한 갈고리 발톱>」"
  },
  Skill_67447_Name = {
    Text = "기이한 갈고리 발톱"
  },
  Skill_67448_Desc = {
    Text = "「<Szemengbiaoxiang:축복·악몽의 표상 β>」"
  },
  Skill_67448_Name = {
    Text = "축복·악몽의 표상 β"
  },
  Skill_67449_Desc = {
    Text = "최대 HP의 25%를 회복하고, 최대 HP를 10% 증가시킨다."
  },
  Skill_67449_Name = {
    Text = "돌·지원"
  },
  Skill_67451_Desc = {
    Text = "「<Chenzhonghuakuang:무거운 액자>」"
  },
  Skill_67451_Name = {
    Text = "무거운 액자"
  },
  Skill_67453_Desc = {
    Text = "「<Slbyuyi:시계추·날개>」"
  },
  Skill_67453_Name = {
    Text = "시계추·날개"
  },
  Skill_67454_Desc = {
    Text = "「<Dingxiangluopan:방위 나침반>」"
  },
  Skill_67454_Name = {
    Text = "정밀 나침반"
  },
  Skill_67455_Desc = {
    Text = "「<Szguguaigouzhua:축복·기괴한 갈고리 발톱>」"
  },
  Skill_67455_Name = {
    Text = "축복·기괴한 갈고리발톱"
  },
  Skill_67456_Desc = {
    Text = "「<Szyishimingke:축복·각인된 의식 β>」"
  },
  Skill_67456_Name = {
    Text = "축복·각인된 의식 β"
  },
  Skill_67457_Desc = {
    Text = "「<Jiajisiquanzhang:제사장의 지팡이+>」"
  },
  Skill_67457_Name = {
    Text = "제사장의 지팡이+"
  },
  Skill_67458_Desc = {
    Text = "<Slbtoushe:시계추·투사>」"
  },
  Skill_67458_Name = {
    Text = "시계추·투영"
  },
  Skill_67462_Desc = {
    Text = "「<Qunmengzhige:군중의 노래>」"
  },
  Skill_67462_Name = {
    Text = "군중의 노래"
  },
  Skill_67463_Desc = {
    Text = "「<Jiaqunmengzhige:군중의 노래+>」"
  },
  Skill_67463_Name = {
    Text = "군중의 노래+"
  },
  Skill_67464_Desc = {
    Text = "「<Guaishecantui:뱀의 허물>」"
  },
  Skill_67464_Name = {
    Text = "뱀의 허물"
  },
  Skill_67466_Desc = {
    Text = "「<Aerkanajilu:아르카나 기록>」"
  },
  Skill_67466_Name = {
    Text = "아르카나 기록"
  },
  Skill_67467_Desc = {
    Text = "「<Xiushiliuyedao:녹슨 메스>」"
  },
  Skill_67467_Name = {
    Text = "녹슨 메스"
  },
  Skill_67468_Desc = {
    Text = "「<Jiaqunxingzhijiu:별들의 술 +>」"
  },
  Skill_67468_Name = {
    Text = "별빛의 술+"
  },
  Skill_67469_Desc = {
    Text = "「<Jiariyuelunpan:해와 달의 룰렛+>」"
  },
  Skill_67469_Name = {
    Text = "해와 달의 암호+"
  },
  Skill_67470_Desc = {
    Text = "「불굴의 전의」 1장을 손에 넣고, 이번 턴 동안 「타격」의 행동력 소모가 1 감소한다."
  },
  Skill_67470_Name = {
    Text = "로탄·지원"
  },
  Skill_67471_Desc = {
    Text = "「<Guhuofengling:미혹의 풍령>」"
  },
  Skill_67471_Name = {
    Text = "미혹의 풍령"
  },
  Skill_67472_Desc = {
    Text = "「<Shihengdetianping:불균형한 저울>」"
  },
  Skill_67472_Name = {
    Text = "불균형한 저울"
  },
  Skill_67473_Desc = {
    Text = "「<Szheizhu:축복·검은 양초>」"
  },
  Skill_67473_Name = {
    Text = "축복·검은 촛대"
  },
  Skill_67474_Desc = {
    Text = "영구 힘의 50%에 해당하는 임시 힘을 획득하고, 최대 HP의 50%에 해당하는 실타래드를 획득한다."
  },
  Skill_67474_Name = {
    Text = "오지에·지원"
  },
  Skill_67475_Desc = {
    Text = "「<Womendejia:우리의 집>」"
  },
  Skill_67475_Name = {
    Text = "우리의 집"
  },
  Skill_67476_Desc = {
    Text = "「<Eyunyishiniao:재앙 의식의 새>」"
  },
  Skill_67476_Name = {
    Text = "재앙 의식의 새"
  },
  Skill_67477_Desc = {
    Text = "「<Zaixiguangli:황혼 속에서>」"
  },
  Skill_67477_Name = {
    Text = "황혼 속에서"
  },
  Skill_67478_Desc = {
    Text = "「<Wwenmingzhiguang:문명의 빛>」"
  },
  Skill_67478_Name = {
    Text = "문명의 빛"
  },
  Skill_67479_Desc = {
    Text = "「<Szqisaimanzhiwen:축복·칠성장어의 키스>」"
  },
  Skill_67479_Name = {
    Text = "축복·일곱 비늘의 키스"
  },
  Skill_67480_Desc = {
    Text = "「<Jiatuisezhaopian:빛바랜 사진+>」"
  },
  Skill_67480_Name = {
    Text = "탈색된 사진+"
  },
  Skill_67481_Desc = {
    Text = "「<Jierizhufu:축제의 축복>」"
  },
  Skill_67481_Name = {
    Text = "축제의 축복"
  },
  Skill_67482_Desc = {
    Text = "「<Slbyan:시계추·눈>」"
  },
  Skill_67482_Name = {
    Text = "시계추·눈"
  },
  Skill_67483_Desc = {
    Text = "「<Geyushan:비둘기 깃털 부채>」"
  },
  Skill_67483_Name = {
    Text = "비둘기 깃털 부채"
  },
  Skill_67484_Desc = {
    Text = "「<Slbyanhua:시계추·진화>」"
  },
  Skill_67484_Name = {
    Text = "시계추·진화"
  },
  Skill_67486_Desc = {
    Text = "「<Xiaoxiaoqiangbao:작은 포대기>」"
  },
  Skill_67486_Name = {
    Text = "작은 포대기"
  },
  Skill_67488_Desc = {
    Text = "「<Wanxianglingzhimiyi:만상 영지의 신비 의식>」"
  },
  Skill_67488_Name = {
    Text = "만상 영지 장치"
  },
  Skill_67490_Desc = {
    Text = "「<Slbshuangsheng:시계추·쌍둥이>」"
  },
  Skill_67490_Name = {
    Text = "시계추·쌍둥이"
  },
  Skill_67491_Desc = {
    Text = "「<Yixiangyoupiaojia:이국의 우표집>」"
  },
  Skill_67491_Name = {
    Text = "이국의 우표집"
  },
  Skill_67493_Desc = {
    Text = "「<Yinbaichaifenji:은백 연산기>」"
  },
  Skill_67493_Name = {
    Text = "백은 차분기"
  },
  Skill_67494_Desc = {
    Text = "「<Zhongsuo:무거운 자물쇠>」"
  },
  Skill_67494_Name = {
    Text = "무거운 자물쇠"
  },
  Skill_67495_Desc = {
    Text = "「<Beiyiwangzhezhixue:잊혀진 자의 피>」"
  },
  Skill_67495_Name = {
    Text = "잊혀진 자의 피"
  },
  Skill_67496_Desc = {
    Text = "「<Szchongqunyishi:축복·군충 의식>」"
  },
  Skill_67496_Name = {
    Text = "축복·군체 의식"
  },
  Skill_67497_Desc = {
    Text = "「<Qiuzhidushulun:지식의 독서륜>」"
  },
  Skill_67497_Name = {
    Text = "지식의 독서륜"
  },
  Skill_67498_Desc = {
    Text = "「<Jiatongxunshebei:통신 장비+β>」"
  },
  Skill_67498_Name = {
    Text = "통신 장비+β"
  },
  Skill_67499_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 해당 카드를 복제하며, 두 카드의 행동력 소모를 0으로 만든다."
  },
  Skill_67499_Name = {
    Text = "라모나·지원"
  },
  Skill_67500_Desc = {
    Text = "「<Jisiquanzhang:제사장의 지팡이>」"
  },
  Skill_67500_Name = {
    Text = "제사장의 지팡이"
  },
  Skill_67501_Desc = {
    Text = "「<Meixueyuanli:미학 원리>」"
  },
  Skill_67501_Name = {
    Text = "미학의 원리"
  },
  Skill_67502_Desc = {
    Text = "「<Riyuelunpan:해와 달의 룰렛>」"
  },
  Skill_67502_Name = {
    Text = "해와 달의 암호"
  },
  Skill_67699_Desc = {
    Text = "「<Misagehuizhang:미사그 배지>」"
  },
  Skill_67699_Name = {
    Text = "미사그 배지"
  },
  Skill_67700_Desc = {
    Text = "「<Wumingzhishenmiansha:무명 신의 베일>」"
  },
  Skill_67700_Name = {
    Text = "이름 없는 신의 베일"
  },
  Skill_67759_Name = {
    Text = "골든 테스트 팩"
  },
  Skill_67760_Name = {
    Text = "프리즘 테스트 팩"
  },
  Skill_67761_Name = {
    Text = "실타래버 테스팅 키트"
  },
  Skill_67780_Desc = {
    Text = "자폭한다. <Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 「통 속의 뇌」가 자신의 남은 HP의 2배만큼 HP를 회복한다."
  },
  Skill_67780_Name = {
    Text = "자폭 프로그램"
  },
  Skill_67855_AwakerSkillBackgroundStory = {
    Text = "이 두 눈은 더 이상 정상적으로 사물을 볼 수 없다.\n\n그녀는 시간과 현실타래의 폭풍을 정면으로 마주하며, 울부짖는 혼돈이 베고 갈가리 찢겨 마침내 그녀의 눈이 되도록 내버려 두었다.\n\n「라모나」에게 속한 또 하나의 흔적이 그녀의 몸에서 사라지고 있다. 그녀는 손끝에서 흘러가는 생명을 붙잡지 못했듯이, 흘러가는 자신 또한 붙잡을 수 없다."
  },
  Skill_67855_Desc = {
    Text = "[Power:Arg1]pt의 <PowerIconKeywords:힘>을 획득한다. 덱에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모량을 1 감소시킨다."
  },
  Skill_67855_EffectNameList = {Text = "힘"},
  Skill_67855_Name = {
    Text = "초월의 눈"
  },
  Skill_67855_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_67856_AwakerSkillBackgroundStory = {
    Text = "긴 고독 속에서, 그녀는 왜 검을 휘둘렀는지 이미 잊은 지 오래되었다.\n\n그러나 자신이 이 검을 휘둘러야 한다는 것만은 분명히 알고 있었다."
  },
  Skill_67856_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주고, 「운명의 검」에서 <PowerIconKeywords:힘>이 [Arg2]배로 적용된다. 열쇠 지령을 사용할 때마다, 이번 전투에서 힘 배율이 1배 증가한다."
  },
  Skill_67856_EffectNameList_0 = {Text = "피해"},
  Skill_67856_Name = {
    Text = "운명의 검"
  },
  Skill_67856_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,"
  },
  Skill_67868_Desc = {
    Text = "같은 품질의 유물을 1회 다시 발견한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_67868_Name = {Text = "갱신"},
  Skill_67869_Desc = {
    Text = "같은 품질의 유물을 1회 다시 발견한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_67869_Name = {Text = "갱신"},
  Skill_67870_Desc = {
    Text = "같은 품질의 유물을 1회 다시 발견한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_67870_Name = {Text = "갱신"},
  Skill_67871_Desc = {
    Text = "같은 품질의 유물을 1회 다시 발견한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_67871_Name = {Text = "갱신"},
  Skill_68550_Desc = {
    Text = "그분은 매우 호기심이 많으시다. <Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「분노」 상태를 획득한다. 적의 힘이 지속적으로 증가할 것이다!"
  },
  Skill_68550_Name = {Text = "모독"},
  Skill_68551_Desc = {
    Text = "그분이 당신을 바라보신다. 「증상」 1장을 당신의 덱에 영구적으로 추가한다."
  },
  Skill_68551_Name = {Text = "응시"},
  Skill_68552_Desc = {
    Text = "그분은 의혹을 품으신다. 2턴간 <BlindingKeywords:실타래명>을 부여하고 <BleedingIconKeywords:출혈> [Arg1]스택을 부여한다."
  },
  Skill_68552_Name = {Text = "침입"},
  Skill_68659_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_95:「추억-유토피아의 장막」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68659_Name = {
    Text = "추억의 빛 - 유토피아의 장막"
  },
  Skill_68660_Desc = {
    Text = "행동력 2pt를 획득한다. 열쇠 지령 3개를 확인하고, 그중 1개를 선택하여 즉시 발동하며, 자신의 부정 상태를 해제하고 잃은 HP의 25%를 회복한다."
  },
  Skill_68660_Name = {
    Text = "추억 - 유토피아의 장막"
  },
  Skill_68661_Desc = {
    Text = "손에서 비파생 명령 카드 1장을 선택하여, 이번 전투에서 해당 카드의 행동력 소모를 영구적으로 1 감소시키고, 해당 카드의 복사본 1장을 손에 넣는다."
  },
  Skill_68661_Name = {
    Text = "추억 - 미완성된 밀랍상"
  },
  Skill_68662_Desc = {
    Text = "모든 손패를 버리고, 버린 장수보다 3장 많은 카드를 뽑으며, 그 카드들의 행동력 소모를 1 감소시킨다."
  },
  Skill_68662_Name = {
    Text = "추억 - 변이의 심장"
  },
  Skill_68663_Desc = {
    Text = "임시 <ParcloseIconKeywords:장벽> 2스택을 획득한다. 다음 턴 시작 시 추가로 카드 3장을 뽑고, 행동력 3pt를 획득한다."
  },
  Skill_68663_Name = {
    Text = "추억 - 벌꿀 술"
  },
  Skill_68664_Desc = {
    Text = "비파생 명령 카드 1장을 선택하여, 해당 카드의 원본 복사본 10장을 덱에 섞어 넣는다. 이 카드들은 다음에 사용하기 전까지 행동력 소모가 2 감소한다."
  },
  Skill_68664_Name = {
    Text = "추억 - 풍요의 씨앗"
  },
  Skill_68665_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_91:「추억-미완성된 밀랍상」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68665_Name = {
    Text = "추억의 빛 - 미완성된 밀랍상"
  },
  Skill_68666_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 [Arg1]pt를 획득한다. 3회 사용 가능하다(현재 [Arg2]회 사용됨)."
  },
  Skill_68666_Name = {
    Text = "추억 - 순진한 보답"
  },
  Skill_68667_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_90:「추억-천진한 답례」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68667_Name = {
    Text = "추억의 빛 - 순진한 보답"
  },
  Skill_68668_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_94:「추억-대행자의 심판」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68668_Name = {
    Text = "추억의 빛 - 대행자의 판결"
  },
  Skill_68669_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_96:「추억-풍요의 핵」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68669_Name = {
    Text = "추억의 빛 - 풍요의 씨앗"
  },
  Skill_68670_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_92:「추억-변이의 심장」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68670_Name = {
    Text = "추억의 빛 - 변이의 심장"
  },
  Skill_68671_Desc = {
    Text = "덱 또는 버린 카드 더미에서 카드 1장을 선택하여 손에 넣고, 그 카드의 행동력 소모를 0으로 만든다. <DerivativeCardKeywords_93:「추억-꿀술」> 1장을 덱과 버린 카드 더미에 넣는다."
  },
  Skill_68671_Name = {
    Text = "추억의 빛 - 벌꿀 술"
  },
  Skill_68672_Desc = {
    Text = "뒷줄 적에게 최대 HP의 25%에 해당하는 <FixedDamage:순수 피해>를 입히고, 최대 HP의 25%에 해당하는 방어막을 획득한다."
  },
  Skill_68672_Name = {
    Text = "추억 - 대행자의 판결"
  },
  Skill_68699_Desc = {
    Text = "그분께서 잠시 쉬려고 하신다."
  },
  Skill_68844_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_68844_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_68873_Desc = {
    Text = "모든 깨어남체의 「방어」를 손에 넣으며, 그 카드들의 행동력 소모를 0으로 만든다."
  },
  Skill_68873_Name = {Text = "은신 β"},
  Skill_68874_Desc = {
    Text = "[Arg1]pt의 <PowerIconKeywords:힘>을 획득하고, 다른 깨어남체들의 「타격」을 손에 넣으며, 그 카드들의 행동력 소모를 0pt로 만든다."
  },
  Skill_68874_Name = {
    Text = "불굴의 전의 β"
  },
  Skill_68950_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_68950_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_68951_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_68951_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_68952_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_68952_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69783_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69783_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69784_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69784_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69785_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69785_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69786_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69786_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_69787_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69787_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69788_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69788_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69789_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69789_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_69790_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69790_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69791_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69791_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_69792_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69792_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69793_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69793_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_69794_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69794_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69795_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69795_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69796_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69796_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69797_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69797_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_69798_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69798_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69799_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69799_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_69800_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69800_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69801_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_69801_Name = {
    Text = "원초 혼돈의 씨앗"
  },
  Skill_69802_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_69802_Name = {
    Text = "원초 혼돈의 핵"
  },
  Skill_69803_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Arg3]스택과 <BleedingIconKeywords:출혈> [Arg4]스택을 부여한다."
  },
  Skill_69803_Name = {
    Text = "원초 혼돈의 영혼"
  },
  Skill_70013_Desc = {
    Text = "「심연 원천」 5스택을 소모한다. 깨어남체 1명을 선택하여 광기 [Arg1]pt를 획득한다. 턴 시작 시 모든 깨어남체가 광기 [Arg2]pt를 획득하며, 이 효과는 전투 종료까지 지속된다."
  },
  Skill_70013_Name = {
    Text = "깨어남Ⅱ"
  },
  Skill_70014_Desc = {
    Text = "「심연 원천」 10스택을 소모한다. <DerivativeCardKeywords_60:「왕권」> 1장을 손에 넣고, 모든 깨어남체의 치명타율과 치명타 피해가 25% 증가한다."
  },
  Skill_70014_Name = {
    Text = "깨어남Ⅲ"
  },
  Skill_70015_Desc = {
    Text = "「심연 원천」 1스택을 소모한다. <DerivativeCardKeywords_4:「영감」> 1장을 손에 넣고, 임시 힘과 임시 촉수 피해를 [Arg1] 획득한다."
  },
  Skill_70015_Name = {
    Text = "깨어남Ⅰ"
  },
  Skill_70043_Desc = {
    Text = "그분께서 잠시 쉬려고 하신다."
  },
  Skill_70044_Desc = {
    Text = "뒷줄 적에게 최대 HP의 15%에 해당하는 <FixedDamage:순수 피해>를 입히고, 최대 HP의 25%에 해당하는 방어막을 획득한다."
  },
  Skill_70044_Name = {
    Text = "추억 - 대행자의 판결"
  },
  Skill_70142_Desc = {
    Text = "실타래드를 [Arg1]pt 획득하고, 추가로 「심연 원천」 1스택을 적립한다."
  },
  Skill_70142_Name = {Text = "깊은 잠"},
  Skill_70286_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 손에 있는 장착한 깨어남체의 모든 「스킬」이 주는 피해, 치유 및 실타래드 효과를 [Arg1]% 증가시킨다."
  },
  Skill_70286_Name_1 = {
    Text = "청석 왕좌"
  },
  Skill_70299_AwakerSkillBackgroundStory = {
    Text = "그녀가 평생 추구하던 종착점이 이제 손에 닿을 듯 가까이 놓여 있다.\n 칠흑 같은 대문이 치명적인 끌림을 발산한다.\n 문을 열기 전에 그녀는 372가지 진리의 가능성을 구상했다.\n 문을 연 후에는 그녀가 인정하고 싶지 않은 373번째 가능성만 남았다.\n 선택의 여지가 없었고, 그녀는 그저 떨어질 수밖에 없었다.\n 운이 정말 나쁘구나, 자신과 온 세상."
  },
  Skill_70299_BattleDesc = {
    Text = "다른 깨어남체들이 광기 <Energy:[Energy:Arg1]>pt를 획득하고, 모든 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여하며, 파티의 임시 피해 증폭 효과가 [Arg3]% 증가한다."
  },
  Skill_70299_Desc = {
    Text = "다른 깨어남체들이 광기 <Energy:[Energy:Arg1]>pt를 획득하고, 모든 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여하며, 파티의 임시 피해 증폭 효과가 [Arg3]% 증가한다. 「종말 형태」: 추가로 카드를 3장 드로우하고, 행동력 3pt를 획득하며, 모든 적의 <IntoxicationIconKeywords:중독> 50%를 발동시킨다. 「융해·돌」의 광기 최대치가 50 증가하며, 이는 최대 3번까지 증가한다."
  },
  Skill_70299_EffectNameList = {
    Text = "광기, 중독, 피해 증폭"
  },
  Skill_70299_Name = {
    Text = "종점, 진리와 심연의 문"
  },
  Skill_70299_OverLimitUtlSkillDesc = {
    Text = "다른 깨어남체들이 광기 <Energy:[Energy:Arg4]>pt를 획득하고, 모든 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]스택 부여하며, 파티의 임시 피해 증폭 효과가 [Arg3]% 증가한다. 모든 깨어남체가 입히는 <IntoxicationIconKeywords:중독>, <RetaliateIconKeywords:반격>, 기본 피해가 10% 증가한다. 보스전일 경우, 「종말」을 1스택 추가로 획득한다."
  },
  Skill_70299_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2,$GrowValue3％"
  },
  Skill_70300_AwakerSkillBackgroundStory = {
    Text = "기계 갑각 아래서 선홍빛 포자낭이 팽창하자, 황동 공명기가 벌집 구조의 방어 매트릭스를 전개한다. 균사 펄스망이 공간을 찢어발기고 산성 안개가 경고의 명문을 식각해 내는 가운데, 기억 박리 광선이 서서히 예열된다. 경계에 닿은 모든 육신은, 끝내 배양조 안에서 경련하는 표본으로 전락하고야 말 것이다."
  },
  Skill_70300_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_70300_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 「융해·돌」이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_70300_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_70300_Name = {Text = "방어"},
  Skill_70300_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_70301_AwakerSkillBackgroundStory = {
    Text = "집게손은 그녀의 과거, 그녀의 종족에서 비롯된 힘으로, 그녀가 결코 포기하지 않은 힘입니다. \n그 집게손이 적의 가슴을 관통할 때, 머금은 미소의 의미는 무엇일까요?"
  },
  Skill_70301_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_70301_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 「융해·돌」이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_70301_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_70301_Name = {Text = "타격"},
  Skill_70301_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_70302_AwakerSkillBackgroundStory = {
    Text = "그녀는 자신을 희생하여 진실타래에 닿을 자격을 얻었습니다. \n그녀가 손을 되찾았을 때, 그녀의 영혼은 이미 밀랍처럼 녹아내렸습니다."
  },
  Skill_70302_BattleDesc_0 = {
    Text = "「융해·돌」이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 종료 시, <Heal:[Heal:Arg2]>의 HP를 회복하고 <Energy:[Energy:Arg4]>의 광기를 획득한다. 「종말 형태」: 더 이상 HP를 회복하지 않고, 대신 모든 적의 <IntoxicationIconKeywords:중독>을 [Arg3]% 발동시킨다."
  },
  Skill_70302_BattleDesc_15 = {
    Text = "「융해·돌」이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「종말」 1스택당 피해 강효 +8%. 「허무 종결」로 모든 깨어남체가 기본 광기의 30%를 획득한다. 턴 종료 시, <Heal:[Heal:Arg2]>의 HP를 회복하고 <Energy:[Energy:Arg4]>의 광기를 획득한다. 「종말 형태」: 더 이상 HP를 회복하지 않고, 대신 모든 적의 <IntoxicationIconKeywords:중독>을 [Arg3]% 발동시킨다."
  },
  Skill_70302_Desc_0 = {
    Text = "「융해·돌」이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 종료 시, <Heal:[Heal:Arg2]>의 HP를 회복하고 자신의 광기 회충과 동일한 광기를 획득한다. 「종말 형태」: 더 이상 HP를 회복하지 않고, 대신 모든 적의 <IntoxicationIconKeywords:중독>을 [Arg3]% 발동시킨다."
  },
  Skill_70302_Desc_15 = {
    Text = "「융해·돌」이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 「종말」 1스택당 피해 강효 +8%. 「허무 종결」로 모든 깨어남체가 기본 광기의 30%를 획득한다. 턴 종료 시, <Heal:[Heal:Arg2]>의 HP를 회복하고 자신의 광기 회충과 동일한 광기를 획득한다. 「종말 형태」: 더 이상 HP를 회복하지 않고, 대신 모든 적의 <IntoxicationIconKeywords:중독>을 [Arg3]% 발동시킨다."
  },
  Skill_70302_EffectNameList = {
    Text = "광기, 회복, 중독 발동"
  },
  Skill_70302_Name = {
    Text = "영혼의 역병"
  },
  Skill_70302_PropertyNameList = {
    Text = "$GrowValue1, 체질*GrowValue2,$GrowValue3％,"
  },
  Skill_70303_AwakerSkillBackgroundStory = {
    Text = "우리가 소멸의 일방통행 길을 계속 걸어간다면, 조금 더 빠르게 걷는 것이 자비일까요?\n 종말이 순간적으로 발생할 때, 고통도 한순간에 응축될 것입니다.\n 사람들은 사랑하는 사람과 포옹한 후, 함께 소멸의 공허를 맞이하면 됩니다.\n 만약 끝에 더 이상 고통이 없다면, 그것도 천국에 도달한 것으로 간주될 수 있을까요?"
  },
  Skill_70303_BattleDesc_0 = {
    Text = "모든 적에게 해당 적의 최대 HP 25%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [Arg2]). 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  Skill_70303_BattleDesc_3 = {
    Text = "모든 적에게 해당 적의 최대 HP 30%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [Arg2]). HP 소모의 30%를 회복합니다( <Heal:[Heal:Arg3]> ) 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  Skill_70303_Desc_0 = {
    Text = "모든 적에게 해당 적의 최대 HP 25%에 해당하는 <FixedDamage:순수 피해>를 입히며, 해당 피해는 자신의 최대 HP [Arg1]% 이하로 내려가지 않습니다. 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다. 「허무의 끝」의 효과는 1회만 발동됩니다."
  },
  Skill_70303_Desc_3 = {
    Text = "모든 적에게 해당 적의 최대 HP 30%에 해당하는 <FixedDamage:순수 피해>를 입히며, 해당 피해는 자신의 최대 HP [Arg1]% 이하로 내려가지 않습니다. HP 소모의 30%를 회복합니다. 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다. 「허무의 끝」의 효과는 1회만 발동됩니다."
  },
  Skill_70303_Name = {
    Text = "허무의 종언"
  },
  Skill_70303_tempBattleDesc_1 = {
    Text = "모든 적에게 해당 적의 최대 HP 25%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [Arg2]). 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  Skill_70303_tempBattleDesc_2 = {
    Text = "모든 적에게 해당 적의 최대 HP 30%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [Arg2]). HP 소모의 30%를 회복합니다( <Heal:[Heal:Arg3]> ) 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  Skill_70303_tempBattleDesc_3 = {
    Text = "모든 적에게 해당 적의 최대 HP 30%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [Arg2]). HP 소모의 30%를 회복합니다( <Heal:[Heal:Arg3]> ) 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다. 모든 각성체가 광기 최대치의 30%를 획득합니다."
  },
  Skill_70304_AwakerSkillBackgroundStory = {
    Text = "인형의 손놀림은 무척이나 섬세하여, 영혼의 코어조차 그녀의 손안에서는 길들여진 큐브와 같다.\n이 상냥한 천재는 당신을 위해 기꺼이 무상으로 신체를 개조해 주겠지만, 그 후유증이 다소 살벌하다는 게 흠이다."
  },
  Skill_70304_Desc = {
    Text = "「흥분」 또는 「저주」를 <DerivativeCardKeywords_103:선택>한다."
  },
  Skill_70304_EffectNameList = {
    Text = "흥분 피해 증폭, 저주 힘 감소"
  },
  Skill_70304_Name = {
    Text = "자폭 개조"
  },
  Skill_70304_PropertyNameList = {
    Text = "$GrowValue1％, 방어력*GrowValue2"
  },
  Skill_70305_AwakerSkillBackgroundStory = {
    Text = "개미가 대형 건물의 작동 원리를 추측하는 것은 항상 어리석고 허황된 것이다.\n모든 이상과 신념이 순식간에 무너지며, 회상과 따스함은 특이점 외부의 허상으로 변한다.\n우주의 탄생 지점에서는 아무것도 존재하지 않는다."
  },
  Skill_70305_Desc = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 <DerivativeCardKeywords_104:획득>한다. <Heal:[Heal:Arg2]>의 HP를 회복하고 자신의 현재 광기가 50pt 보유할 때마다 HP 1회 추가로 회복한다."
  },
  Skill_70305_EffectNameList = {
    Text = "광기, 회복, 중독"
  },
  Skill_70305_Name = {
    Text = "운명의 붕괴"
  },
  Skill_70305_PropertyNameList = {
    Text = "$GrowValue1, 체질*GrowValue2,공격력*GrowValue3"
  },
  Skill_70332_Desc_0 = {
    Text = "전체 적의 <PowerIconKeywords:힘>을 임시로 [Exhaustion:Arg2]pt 감소시킨다."
  },
  Skill_70332_Desc_1 = {
    Text = "전체 적에게 <WeaknessIconKeywords:허약>을 [Arg1]턴간 부여하고, <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg2]pt 감소시킨다."
  },
  Skill_70332_Name = {Text = "저주"},
  Skill_70333_Desc_0 = {
    Text = "1턴간 「흥분」 상태를 획득한다: 피해 증폭 +[Arg2]%."
  },
  Skill_70333_Desc_1 = {
    Text = "1턴간 「흥분」 상태를 획득한다: 피해 증폭 +[Arg2]%. 모든 적에게 [Arg1] 턴의 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_70333_Name = {Text = "흥분"},
  Skill_70355_Desc_1 = {
    Text = "전체 아군에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_70355_Name_1 = {
    Text = "아드레날린"
  },
  Skill_70356_Desc_1 = {
    Text = "카드 [Arg1]장을 드로우한다."
  },
  Skill_70356_Name_1 = {Text = "기습"},
  Skill_70357_Desc_1 = {
    Text = "[Arg1]의 행동력을 획득한다."
  },
  Skill_70357_Name_1 = {Text = "추론"},
  Skill_70358_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복하거나, 적 한 명에게 <Damage:[Damage:Arg2]>의 피해를 준다."
  },
  Skill_70358_Name_1 = {
    Text = "액화 허무"
  },
  Skill_70359_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착자가 매 턴 처음 [Arg1]번 공격을 받을 때, 공격자에게 <PVPEmptinessKeywords:공허>를 입힙니다."
  },
  Skill_70359_Name_1 = {
    Text = "허무 속으로 추락한 인형"
  },
  Skill_70360_Desc_1 = {
    Text = "전체 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_70360_Name_1 = {
    Text = "구원 계획"
  },
  Skill_70361_Desc_1 = {
    Text = "전체 아군에게 <Block:[Block:Arg1]>의 실타래드를 부여한다."
  },
  Skill_70361_Name_1 = {
    Text = "피해 항체"
  },
  Skill_70362_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_70362_Name_1 = {
    Text = "파괴 계획"
  },
  Skill_70376_Desc = {
    Text = "열쇠 에너지를 [Arg1] 잃고, 「영지 깨어남」 1장을 선택하여 손에 넣는다. (영지 깨어남을 1장 획득할 때마다 소모량이 100% 증가하며, 소모 후 열쇠 에너지는 음수[-] 상태가 될 수 있다.)"
  },
  Skill_70376_Name = {
    Text = "은열쇠 깨어남"
  },
  Skill_70383_Desc = {
    Text = "같은 품질의 유물을 1회 다시 발견한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70383_Name = {Text = "갱신"},
  Skill_70384_Desc = {
    Text = "같은 품질의 유물을 1회 다시 발견한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70384_Name = {Text = "갱신"},
  Skill_70825_Desc = {
    Text = "모든 깨어남체가 [Arg1]pt의 광기를 획득한다. 모든 「별빛의 보호」를 소모하여, 소모한 스택수만큼 행동력pt를 획득한다. 현재 계역이 「심해」일 경우, 소모한 스택수만큼 임시 촉수를 추가로 생성한다."
  },
  Skill_70825_Name = {Text = "깨어남"},
  Skill_70826_Desc = {
    Text = "<Block:[Arg1]> 포인트 방어막를 획득하고, 「별빛의 보호」 1 스택을 획득합니다. 최대 5 스택까지 쌓이며, 전투 종료 후 제거되지 않습니다."
  },
  Skill_70826_Name = {Text = "깊은 잠"},
  Skill_70827_Desc = {
    Text = "깨어남체 1명을 선택하여, 그 깨어남체의 명령 카드 치명타율과 치명타 피해를 임시로 [Arg1]% 증가시키고, [Arg2]pt의 광기를 획득한다. 리즈가 팀에 있을 경우, 추가로 「소모」가 부여된 「부패한 푸른 불꽃」 1장을 손에 넣는다."
  },
  Skill_70827_Name = {
    Text = "검은 백조의 춤사위"
  },
  Skill_70828_Desc = {
    Text = "깨어남체 1명을 선택하여 [Arg1]pt의 광기를 획득하고, 모든 적에게 <IntoxicationIconKeywords:중독> [Arg2]pt를 부여한다. 대상이 잃은 HP 1%당 추가로 1%의 중독을 발동시키며, 최대 50%까지 발동한다."
  },
  Skill_70828_Name = {
    Text = "허무의 역병"
  },
  Skill_70829_Desc = {
    Text = "「<DerivativeCardKeywords_99:깊은 잠>」 또는 「<DerivativeCardKeywords_100:깨어남>」 중 하나를 선택한다."
  },
  Skill_70829_Name = {
    Text = "별들의 가호"
  },
  Skill_70961_Desc = {
    Text = "황금+ 유물 2개 중 1개를 선택하여 획득한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70961_Name = {Text = "갱신"},
  Skill_70962_Desc = {
    Text = "은색 유물 2개 중 1개를 선택하여 획득한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70962_Name = {Text = "갱신"},
  Skill_70963_Desc = {
    Text = "시계추 유물 2개 중 1개를 선택하여 획득한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70963_Name = {Text = "갱신"},
  Skill_70964_Desc = {
    Text = "축복 유물 2개 중 1개를 선택하여 획득한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70964_Name = {Text = "갱신"},
  Skill_70965_Desc = {
    Text = "저주 유물 2개 중 1개를 선택하여 획득한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70965_Name = {Text = "갱신"},
  Skill_70966_Desc = {
    Text = "황금 유물 2개 중 1개를 선택하여 획득한다. 전투마다 1회의 재발견 기회를 공유한다."
  },
  Skill_70966_Name = {Text = "갱신"},
  Skill_70994_Desc = {
    Text = "종말 10스택"
  },
  Skill_71522_Desc = {
    Text = "HP의 상한이 10% 감소하고, 「흥분」과 「저주」 효과가 동시에 발동한다."
  },
  Skill_71522_Name = {
    Text = "자폭 개조·종말"
  },
  Skill_71523_Desc = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득하고, 전체 적에게 <IntoxicationIconKeywords:중독>을 [Poison:Arg2]pt 부여한다. 자신의 현재 광기 50pt마다 중독을 1회 추가로 부여한다."
  },
  Skill_71523_Name = {
    Text = "운명의 붕괴·종말"
  },
  Skill_71636_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <DerivativeCardKeywords_105:「무한 은심 보물창고」> 1장을 손에 넣는다."
  },
  Skill_71636_Name = {
    Text = "은심 흩뿌리기"
  },
  Skill_71637_Desc = {
    Text = "감금된 것 같다, 움직일 수 없다."
  },
  Skill_71637_Name = {
    Text = "감금 중..."
  },
  Skill_71638_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 양측 모두에게 <VulnerabilityIconKeywords:취약>을 [Arg3]스택 부여한다."
  },
  Skill_71638_Name = {
    Text = "냥냥 펀치"
  },
  Skill_71639_Desc = {
    Text = "임시 <PowerIconKeywords:힘> [Arg1]pt와 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_71639_Name = {
    Text = "손톱 갈기"
  },
  Skill_71652_Desc = {
    Text = "은심의 힘을 느껴라! 현재 계역의 깨어남체 3명을 불러 그중 1명을 선택하여 지원 카드를 획득한다."
  },
  Skill_71652_Name = {
    Text = "끝없는 은심의 보물창고"
  },
  Skill_71691_BattleDesc = {
    Text = "현재 죽음 저항이 2배가 되며, 모든 적의 임시 <PowerIconKeywords:힘>을 [Arg1]pt 감소시키고, 적 1명당 <PowerIconKeywords:임시 힘> [Arg1]pt를 획득한다."
  },
  Skill_71691_Desc = {
    Text = "현재 죽음 저항이 2배가 되며, 모든 적에게서 힘 [Arg1]pt를 <TouquKeywords:영구 탈취>한다."
  },
  Skill_71691_Name = {
    Text = "파인트·지원"
  },
  Skill_71692_Desc = {
    Text = "촉수 피해의 50%에 해당하는 임시 힘을 획득하고, 모든 적의 <PowerIconKeywords:힘>을 임시로 제거하며 3턴간 <VulnerabilityIconKeywords:취약>을 부여하고, 제거한 만큼의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  Skill_71692_Name = {
    Text = "골리아·지원"
  },
  Skill_71693_Desc = {
    Text = "이전 턴 마지막에 사용한 3장의 비파생 명령 카드의 임시 복사본을 손에 넣고, 해당 카드들의 행동력 소모를 0으로 만든다."
  },
  Skill_71693_Name = {
    Text = "주행·라모나·지원"
  },
  Skill_71694_Desc = {
    Text = "다음 턴 시작 시 이번 턴에 잃은 HP만큼의 실타래드를 1턴간 획득한다. 「배아」 3장을 손에 넣는다."
  },
  Skill_71694_Name = {
    Text = "레아·지원"
  },
  Skill_71695_Desc = {
    Text = "손패가 상한에 도달할 때까지 카드를 드로우한다. 턴 종료 시 손에 있는 카드 1장당 모든 깨어남체가 광기 5pt를 획득한다."
  },
  Skill_71695_Name = {
    Text = "카시아·지원"
  },
  Skill_71696_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 35를 획득하며, 턴 종료 시에도 1회 반복된다. 5턴간 지속된다."
  },
  Skill_71696_Name = {
    Text = "윙클·지원"
  },
  Skill_71697_Desc = {
    Text = "모든 적을 1턴간 석화한다. 적이 석화 저항을 가질 경우, 대신 취약을 25스택 부여한다."
  },
  Skill_71697_Name = {
    Text = "아이기스·지원"
  },
  Skill_71698_Desc = {
    Text = "무작위 손패 5장의 행동력 소모를 1 감소시키고, 최대 HP의 50%에 해당하는 실타래드를 획득한다."
  },
  Skill_71698_Name = {
    Text = "틴커트·지원"
  },
  Skill_71699_Desc = {
    Text = "행동력 3pt를 획득한다. 자신의 부정 상태를 해제하고 잃은 HP의 25%를 회복하며, 열쇠 지령 3개를 확인하고 1개를 선택하여 즉시 발동한다."
  },
  Skill_71699_Name = {
    Text = "셀레스트·지원"
  },
  Skill_71700_Desc = {
    Text = "깨어남체 1명을 선택하여 광기 100을 획득하고, 해당 깨어남체의 치명타율과 치명타 피해를 영구적으로 25% 증가시킨다."
  },
  Skill_71700_Name = {
    Text = "유우하시·지원"
  },
  Skill_71701_Desc = {
    Text = "즉시 촉수 피해가 [Arg1] 증가하고, 임시 반격을 [Arg2] 획득한다. 1턴 동안 공격을 받을 때마다 HP를 [Arg3] 회복한다."
  },
  Skill_71701_Name = {
    Text = "카이커스·지원"
  },
  Skill_71702_Desc = {
    Text = "임시 치명타율 35%, 임시 치명타 피해 75%를 획득하며, 이번 턴에 주는 최종 피해가 25% 증가한다."
  },
  Skill_71702_Name = {
    Text = "젠킨·지원"
  },
  Skill_71703_Desc = {
    Text = "즉시 촉수 3개를 생성하고, 다음 턴 시작 시 최대 HP의 25%만큼 실타래드를 획득한다."
  },
  Skill_71703_Name = {
    Text = "산·지원"
  },
  Skill_71704_Desc = {
    Text = "깨어남체 1명을 선택하여 해당 깨어남체의 모든 명령 카드를 버리고, 버린 카드 1장당 임시 힘을 [Arg1]pt 획득하며, 버린 카드의 모든 효과를 발동한다."
  },
  Skill_71704_Name = {
    Text = "리즈·지원"
  },
  Skill_71705_Desc = {
    Text = "깨어남체 1명을 선택하여, 해당 깨어남체의 명령 카드 3장을 뽑고 행동력 소모를 1 감소시킨다. 1턴 동안 해당 깨어남체가 피해를 줄 때마다 촉수 1개가 1회 공격한다."
  },
  Skill_71705_Name = {
    Text = "오레타·지원"
  },
  Skill_71706_Desc = {
    Text = "1턴간 「타격」의 최종 피해가 100% 증가하며, 「포식」을 할 때마다 「타격」 2장을 뽑고 행동력 소모를 1 감소시킨다."
  },
  Skill_71706_Name = {
    Text = "히로·지원"
  },
  Skill_71834_Desc_1 = {
    Text = "적 한 명을 선택하여 <WeaknessIconKeywords:허약>, <PVPVulnerabilityIconKeywords:취약> 및 <PVPSlowKeywords:둔화> 1스택을 부여한다."
  },
  Skill_71834_Name_1 = {
    Text = "허무의 역병"
  },
  Skill_71834_UnknownName = {
    Text = "허무의 역병"
  },
  Skill_71835_Desc_1 = {
    Text = "목표 하나에게 <DelayKeywords:지연> : <PVPVulnerabilityIconKeywords:약점>을 부여합니다."
  },
  Skill_71835_Name_1 = {
    Text = "지연 취약"
  },
  Skill_71836_Desc_1 = {
    Text = "상대의 행동력 소모가 가장 높은 「스킬」 [Arg1]장을 버리게 하고, 그에게 버린 수만큼의 <PVPDerivativeCardKeywords_2:「환상」>을 부여한다."
  },
  Skill_71836_Name_1 = {
    Text = "별들의 가호"
  },
  Skill_71836_UnknownName = {
    Text = "별들의 가호"
  },
  Skill_71904_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_71904_Name_1 = {Text = "타격"},
  Skill_71905_Desc_1 = {
    Text = "상대에게 카드 [Arg1]장을 드로우하게 하고, 모든 적에게 <Damage:[Damage:Arg2]>의 <PVPBleedingKeywords:출혈> 피해를 준다."
  },
  Skill_71905_Name_1 = {
    Text = "광란 촉발"
  },
  Skill_71906_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 피해를 입히고, 상대방을 강제로 목표의 모든 손패 및 손 안의 모든 운명 바퀴 카드와 열쇠 카드을 버리게 합니다, <PVPPenetrateKeywords:관통>."
  },
  Skill_71906_Name_1 = {
    Text = "생명체 재구성"
  },
  Skill_71907_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주어, 상대에게 대상의 모든 손패를 버리게 한다."
  },
  Skill_71907_Name_1 = {
    Text = "심리 교살"
  },
  Skill_71908_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]> 피해를 가하고, 대상이 손에 카드 1장을 가지고 있을 때마다 추가로 [Arg2] 회 피해를 가합니다."
  },
  Skill_71908_Name_1 = {
    Text = "다중 투사"
  },
  Skill_72025_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_72025_Name = {Text = "냥펀치"},
  Skill_72107_Desc = {
    Text = "모든 적이 이번 전투에서 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다(어디든 관계없이). 「잿더미 융식체」 1명을 소환한다."
  },
  Skill_72107_Name = {
    Text = "은심 융합"
  },
  Skill_72108_Desc = {
    Text = "「암살자」 상태와 <ParcloseIconKeywords:장벽> 2스택을 획득한다."
  },
  Skill_72108_Name = {
    Text = "잿더미 속으로"
  },
  Skill_72110_Desc = {
    Text = "「다이얼 폭탄」 1장을 덱에 섞어 넣고, 3턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_72110_Name = {Text = "호출"},
  Skill_72112_Desc = {
    Text = "「잿더미 융식체」 3명과 「긴급 연락」 1개를 소환하고, 자신이 사망한다."
  },
  Skill_72112_Name = {
    Text = "연결 해제"
  },
  Skill_72113_Desc = {
    Text = "<Damage:[Damage:Arg2]>pt의 피해를 [AttackTimes:Arg3]회 입히고, 모든 적이 이번 전투에서 턴 종료 시 <Block:[Block:Arg1]>pt의 실타래드를 획득한다(위치에 관계없이)."
  },
  Skill_72113_Name = {
    Text = "융식 증식"
  },
  Skill_72114_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 2턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_72114_Name = {
    Text = "이중 나선"
  },
  Skill_72115_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_72115_Desc = {
    Text = "1회의 높은 피해를 준다."
  },
  Skill_72115_Name = {
    Text = "물리적 수복"
  },
  Skill_72116_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_72116_Name = {
    Text = "흐름 속으로"
  },
  Skill_72117_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「암살자」 상태를 획득한다."
  },
  Skill_72117_Name = {
    Text = "불꽃 없는 재"
  },
  Skill_72118_Desc = {
    Text = "「다이얼 폭탄」 1장을 덱에 섞어 넣고, 3턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_72118_Name = {Text = "차단"},
  Skill_72119_Desc = {
    Text = "「다이얼 폭탄」 1장을 덱에 섞어 넣고, 2턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_72119_Name = {Text = "호출"},
  Skill_72120_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「잿더미 융식체」 1명을 소환한다."
  },
  Skill_72120_Name = {
    Text = "이체 배척"
  },
  Skill_72122_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 후열에 「잿더미 융식체」 1명을 소환한다."
  },
  Skill_72122_Name = {
    Text = "이체 배척"
  },
  Skill_72123_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_72123_Name = {
    Text = "다시 흐름 속으로"
  },
  Skill_72124_Desc = {
    Text = "모든 적이 이번 전투에서 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다(어디든 관계없이). 「잿더미 융식체」 1명을 소환한다."
  },
  Skill_72124_Name = {
    Text = "은심 융합"
  },
  Skill_72125_Desc = {
    Text = "「다이얼 폭탄」 1장을 덱에 섞어 넣고, 2턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_72125_Name = {Text = "차단"},
  Skill_72177_BattleDesc = {
    Text = "연구 조건: 열쇠 지령을 2회 발동한다. 연구 결과: 모든 깨어남체가 광기 [Arg1]pt를 획득하고, 매 턴 종료 시 추가로 광기 [Arg2]pt를 획득한다."
  },
  Skill_72177_Desc = {
    Text = "연구 조건: 열쇠 지령을 3회 발동한다. 연구 결과: 모든 깨어남체가 광기 [Arg1]pt를 획득하고, 매 턴 종료 시 추가로 광기 [Arg2]pt를 획득한다."
  },
  Skill_72177_Name = {
    Text = "은열쇠 연구"
  },
  Skill_72178_BattleDesc = {
    Text = "연구 조건: 광기 폭발을 5회 발동한다. 연구 결과: 손의 명령 카드 3장을 선택하여 「합주」 각인을 부여한다."
  },
  Skill_72178_Desc = {
    Text = "연구 조건: 광기 폭발을 6회 발동한다. 연구 결과: 손의 명령 카드 3장을 선택하여 「합주」 각인을 부여한다."
  },
  Skill_72178_Name = {
    Text = "광기 연구"
  },
  Skill_72179_BattleDesc = {
    Text = "연구 조건: 피해를 30회 준다. 연구 결과: 모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하고, <ExhaustionIconKeywords:힘>을 [Arg2]pt 잃게 한다."
  },
  Skill_72179_Desc = {
    Text = "연구 조건: 피해를 40회 준다. 연구 결과: 모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하고, <ExhaustionIconKeywords:힘>을 [Arg2]pt 잃게 한다."
  },
  Skill_72179_Name = {
    Text = "연타 연구"
  },
  Skill_72180_BattleDesc = {
    Text = "피해 강효 100%와 치명타율 15%를 획득하며, 이번 턴 내 효과가 2배로 적용된다."
  },
  Skill_72180_Desc = {
    Text = "피해 강효 100%와 치명타율 15%를 획득하며, 이번 턴 내 효과가 2배로 적용된다."
  },
  Skill_72180_Name = {Text = "강심제"},
  Skill_72181_BattleDesc = {
    Text = "행동력 [Arg1]pt를 획득하고, 카드 [Arg1]장을 드로우한다. 행동력 상한과 뽑는 카드 수가 [Arg2] 증가한다."
  },
  Skill_72181_Desc = {
    Text = "행동력 [Arg1]pt를 획득하고, 카드 [Arg1]장을 드로우한다. 행동력 상한과 뽑는 카드 수가 [Arg2] 증가한다."
  },
  Skill_72181_Name = {
    Text = "폭발적인 흥분"
  },
  Skill_72182_BattleDesc = {
    Text = "모든 깨어남체가 광기 [Arg1]pt를 획득하며, 매 턴 종료 시 추가로 광기 [Arg2]pt를 획득한다."
  },
  Skill_72182_Desc = {
    Text = "모든 깨어남체가 광기 [Arg1]pt를 획득하며, 매 턴 종료 시 추가로 광기 [Arg2]pt를 획득한다."
  },
  Skill_72182_Name = {
    Text = "심연의 광기"
  },
  Skill_72183_BattleDesc = {
    Text = "연구 조건: 실타래드 또는 치유를 10회 수행한다. 연구 결과: 행동력 [Arg1]pt를 획득하고, 카드 [Arg1]장을 드로우한다. 행동력 상한과 뽑는 카드 수가 [Arg2] 증가한다."
  },
  Skill_72183_Desc = {
    Text = "연구 조건: 실타래드 또는 치유를 15회 수행한다. 연구 결과: 행동력 [Arg1]pt를 획득하고, 카드 [Arg1]장을 드로우한다. 행동력 상한과 뽑는 카드 수가 [Arg2] 증가한다."
  },
  Skill_72183_Name = {
    Text = "생존 연구"
  },
  Skill_72184_BattleDesc = {
    Text = "연구 조건: 열쇠 지령 2회 발동. 연구 결과: 모든 깨어남체가 광기 [Arg1]pt를 획득하고, 매 턴 종료 시 추가로 광기 [Arg2]pt를 획득한다."
  },
  Skill_72184_Desc = {
    Text = "연구 조건: 열쇠 지령 3회 발동. 연구 결과: 모든 깨어남체가 광기 [Arg1]pt를 획득하고, 매 턴 종료 시 추가로 광기 [Arg2]pt를 획득한다."
  },
  Skill_72184_Name = {
    Text = "은열쇠 연구"
  },
  Skill_72185_BattleDesc = {
    Text = "손의 명령 카드 3장을 선택하여 「합주」 각인을 부여한다."
  },
  Skill_72185_Desc = {
    Text = "손의 명령 카드 3장을 선택하여 「합주」 각인을 부여한다."
  },
  Skill_72185_Name = {
    Text = "병에 담긴 허무"
  },
  Skill_72186_BattleDesc = {
    Text = "연구 조건: 명령 카드 15장 사용. 연구 결과: 피해 강효 100%와 치명타율 15%를 획득하며, 이번 턴 내 효과가 2배로 적용된다."
  },
  Skill_72186_Desc = {
    Text = "연구 조건: 명령 카드 20장 사용. 연구 결과: 피해 강효 100%와 치명타율 15%를 획득하며, 이번 턴 내 효과가 2배로 적용된다."
  },
  Skill_72186_Name = {
    Text = "명령 장비 연구"
  },
  Skill_72187_BattleDesc = {
    Text = "연구 조건: 실타래드 또는 치유를 10회 수행한다. 연구 결과: 행동력 [Arg1]pt를 획득하고, 카드 [Arg1]장을 드로우한다. 행동력 상한과 뽑는 카드 수가 [Arg2] 증가한다."
  },
  Skill_72187_Desc = {
    Text = "연구 조건: 실타래드 또는 치유를 15회 수행한다. 연구 결과: 행동력 [Arg1]pt를 획득하고, 카드 [Arg1]장을 드로우한다. 행동력 상한과 뽑는 카드 수가 [Arg2] 증가한다."
  },
  Skill_72187_Name = {
    Text = "생존 연구"
  },
  Skill_72188_BattleDesc = {
    Text = "연구 조건: 명령 카드 15장을 사용한다. 연구 결과: 피해 강효 100%와 치명타율 15%를 획득하며, 이번 턴 내 효과가 2배로 적용된다."
  },
  Skill_72188_Desc = {
    Text = "연구 조건: 명령 카드 20장을 사용한다. 연구 결과: 피해 강효 100%와 치명타율 15%를 획득하며, 이번 턴 내 효과가 2배로 적용된다."
  },
  Skill_72188_Name = {
    Text = "명령 장비 연구"
  },
  Skill_72189_BattleDesc = {
    Text = "모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하여 <ExhaustionIconKeywords:힘>을 [Arg2]pt 잃게 한다."
  },
  Skill_72189_Desc = {
    Text = "모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하여 <ExhaustionIconKeywords:힘>을 [Arg2]pt 잃게 한다."
  },
  Skill_72189_Name = {
    Text = "쇠약의 역병"
  },
  Skill_72190_BattleDesc = {
    Text = "연구 조건: 광기 폭발을 5회 발동한다. 연구 결과: 손의 명령 카드 3장을 선택하여 「합주」 각인을 부여한다."
  },
  Skill_72190_Desc = {
    Text = "연구 조건: 광기 폭발을 6회 발동한다. 연구 결과: 손의 명령 카드 3장을 선택하여 「합주」 각인을 부여한다."
  },
  Skill_72190_Name = {
    Text = "광기 연구"
  },
  Skill_72191_BattleDesc = {
    Text = "연구 조건: 피해 30회 발생. 연구 결과: 모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하고, <ExhaustionIconKeywords:힘>을 [Arg2]pt 잃게 한다."
  },
  Skill_72191_Desc = {
    Text = "연구 조건: 피해 40회 발생. 연구 결과: 모든 적에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여하고, <ExhaustionIconKeywords:힘>을 [Arg2]pt 잃게 한다."
  },
  Skill_72191_Name = {
    Text = "연타 연구"
  },
  Skill_72827_BattleDesc = {
    Text = "모든 적에게 해당 적의 최대 HP [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입힌다(최소 [Arg3])."
  },
  Skill_72827_Desc = {
    Text = "모든 적에게 해당 적의 최대 HP [Arg1]%에 해당하는 <FixedDamage:순수 피해>를 입히며, 이 피해는 자신의 최대 HP의 [Arg2]% 미만이 되지 않는다."
  },
  Skill_72827_Name = {
    Text = "허무의 종말"
  },
  Skill_73475_Desc = {
    Text = "「광분」 1장을 덱에 섞어 넣는다."
  },
  Skill_73475_Name = {Text = "광연"},
  Skill_73476_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다. 깨어남 카드 사용 후 의도가 「정신 압살」로 변경된다."
  },
  Skill_73476_Name = {
    Text = "고통 착취"
  },
  Skill_73477_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 사망한다."
  },
  Skill_73477_Name = {Text = "자폭"},
  Skill_73482_Desc = {
    Text = "2턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다. 자신의 <MadnessIconKeywords:광란>과 <PowerIconKeywords:힘>의 절반을 제거하고, 잃은 HP의 10%를 회복한다."
  },
  Skill_73482_Name = {
    Text = "정신의 위로"
  },
  Skill_73484_Desc = {
    Text = "손패에 있을 때, 행동력 소비 3인 카드를 사용하면 [Arg1]점의 <FixedDamage:순수 피해>를 받고, 행동력 소비 1 또는 2인 「다이얼 봄」 1장으로 변형된다. 사용 후 행동력 소비와 동일한 수만큼 드로우한다."
  },
  Skill_73484_Name = {
    Text = "다이얼식 폭탄"
  },
  Skill_73485_Desc = {
    Text = "손패에 있을 때, 행동력 소비 2인 카드를 사용하면 [Arg1]점의 <FixedDamage:순수 피해>를 받고, 행동력 소비 1 또는 3인 「다이얼 봄」 1장으로 변형된다. 사용 후 행동력 소비와 동일한 수만큼 드로우한다."
  },
  Skill_73485_Name = {
    Text = "다이얼식 폭탄"
  },
  Skill_73486_Desc = {
    Text = "손패에 있을 때, 행동력 소비 1인 카드를 사용하면 [Arg1]점의 <FixedDamage:순수 피해>를 받고, 행동력 소비 2 또는 3인 「다이얼 봄」 1장으로 변형된다. 사용 후 행동력 소비와 동일한 수만큼 드로우한다."
  },
  Skill_73486_Name = {
    Text = "다이얼식 폭탄"
  },
  Skill_73525_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 2턴간 <BlindingKeywords:실타래명>을 부여한다."
  },
  Skill_73526_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 자신이 <MadnessIconKeywords:광란> [Arg2]스택을 획득한다."
  },
  Skill_73527_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_73528_Desc = {
    Text = "「아니겠지…」 2개를 소환하고, 전체 아군이 <ParcloseIconKeywords:장벽> 3스택을 획득한다."
  },
  Skill_73536_Desc = {
    Text = "해제된 무작위 열쇠 지령 3개 중 1개를 선택하여 즉시 발동한다."
  },
  Skill_73536_Name = {
    Text = "은열쇠의 미광"
  },
  Skill_74028_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 3턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_74028_Name = {
    Text = "이중 나선"
  },
  Skill_74029_Desc = {
    Text = "모든 적이 이번 전투에서 영구적으로 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다(어디든 관계없이). 「긴급 연락」 1개와 「잿더미 융식체」 1명을 소환한다."
  },
  Skill_74029_Name = {
    Text = "영원한 공생"
  },
  Skill_74030_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_74030_Desc = {
    Text = "1회의 높은 피해를 준다."
  },
  Skill_74030_Name = {
    Text = "물리적 수복"
  },
  Skill_74036_Desc = {
    Text = "턴이 시작될 때, 랜덤으로 「인지착란」이 없는 2장의 명령에 「인지착란」을 부여합니다."
  },
  Skill_74036_Name = {
    Text = "영지 최면"
  },
  Skill_74037_Desc = {
    Text = "턴이 시작될 때, 랜덤으로 「인지착란」이 없는 2장의 명령에 「인지착란」을 부여합니다."
  },
  Skill_74037_Name = {
    Text = "영지 최면"
  },
  Skill_74038_Desc = {
    Text = "턴이 시작될 때, 랜덤으로 「인지착란」이 없는 2장의 명령에 「인지착란」을 부여합니다."
  },
  Skill_74038_Name = {
    Text = "영지 최면"
  },
  Skill_74039_Desc = {
    Text = "턴이 시작될 때, 랜덤으로 「인지착란」이 없는 2장의 명령에 「인지착란」을 부여합니다."
  },
  Skill_74040_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 유지된 손패를 모두 버린 후, 「영감」 3장과 3가지 다른 행동력 소모를 가진 「다이얼 폭탄」을 손에 넣는다."
  },
  Skill_74040_Name = {Text = "도달"},
  Skill_74042_Desc = {
    Text = "비소모 명령 카드를 사용할 때 「예비 뇌조」에 해당 카드가 없으면, 해당 카드의 <DepleteIconKeywords:소모> 복사본 [Arg1]장을 「예비 뇌조」에 채워 넣는다. 매 턴 최대 1회 발동한다. 사용 후 「예비 뇌조」에 있는 카드를 최대 3장까지 손에 넣는다."
  },
  Skill_74042_Name = {
    Text = "예비 뇌조"
  },
  Skill_74083_Desc = {
    Text = "모든 깨어남체가 광기를 <Energy:[Arg1]>pt 획득하고, 모든 적에게 2턴간 허약과 취약을 부여한다."
  },
  Skill_74083_Name = {
    Text = "광란의 융해"
  },
  Skill_74300_Desc = {
    Text = "턴 종료 후 자신이 생존한 경우, 플레이어의 탐색이 실타래패한다. 해당 의도는 변경할 수 없다."
  },
  Skill_74300_Name = {Text = "종결..."},
  Skill_74792_Desc = {
    Text = "열쇠 에너지를 최대치까지 획득하고, 모든 깨어남체가 광기를 최대치까지 획득한다."
  },
  Skill_74792_Name = {
    Text = "광추의 경계"
  },
  Skill_74819_BattleDesc = {
    Text = "이번 턴 모든 깨어남체의 치명타율과 치명타 피해가 [Arg1]% 증가한다."
  },
  Skill_74819_Desc = {
    Text = "이번 턴 모든 깨어남체의 치명타율과 치명타 피해가 [Arg1]% 증가한다."
  },
  Skill_74819_Name = {
    Text = "거래 완료"
  },
  Skill_74820_BattleDesc = {
    Text = "전체 적에게 중독 [Arg1]스택을 부여한다."
  },
  Skill_74820_Desc = {
    Text = "전체 적에게 중독 [Arg1]스택을 부여한다."
  },
  Skill_74820_Name = {
    Text = "원질의 오염"
  },
  Skill_74821_BattleDesc = {
    Text = "무작위로 [Arg1]pt의 피해를 [Arg2]회 입힌다. (이 피해에는 힘 1배 보너스가 적용된다)"
  },
  Skill_74821_Desc = {
    Text = "무작위로 [Arg1]pt의 피해를 [Arg2]회 입힌다. (이 피해에는 힘 1배 보너스가 적용된다)"
  },
  Skill_74821_Name = {
    Text = "물물교환"
  },
  Skill_74822_BattleDesc = {
    Text = "모든 깨어남체가 광기를 [Arg1]pt 획득한다."
  },
  Skill_74822_Desc = {
    Text = "모든 깨어남체가 광기를 [Arg1]pt 획득한다."
  },
  Skill_74822_Name = {
    Text = "마음껏 골라보세요"
  },
  Skill_74823_BattleDesc = {
    Text = "전체 적에게 이미 손실타래된 생명력의 [Arg1]% 데미지를 입힌다"
  },
  Skill_74823_Desc = {
    Text = "전체 적에게 이미 손실타래된 생명력의 [Arg1]% 데미지를 입힌다"
  },
  Skill_74823_Name = {
    Text = "차원을 넘나드는 속삭임"
  },
  Skill_74824_BattleDesc = {
    Text = "힘을 [Arg1]pt 획득한다."
  },
  Skill_74824_Desc = {
    Text = "힘을 [Arg1]pt 획득한다."
  },
  Skill_74824_Name = {
    Text = "두개골 컬렉션 감상"
  },
  Skill_74834_Name = {
    Text = "금지된 거래"
  },
  Skill_74893_BattleDesc = {
    Text = "실타래드를 [Arg1]pt 획득한다."
  },
  Skill_74893_Desc = {
    Text = "실타래드를 [Arg1]pt 획득한다."
  },
  Skill_74893_Name = {
    Text = "수많은 문의 수호"
  },
  Skill_74894_BattleDesc = {
    Text = "죽음 저항을 [Arg1] 획득한다."
  },
  Skill_74894_Desc = {
    Text = "죽음 저항을 [Arg1] 획득한다."
  },
  Skill_74894_Name = {
    Text = "죽음도 판매 가능"
  },
  Skill_74895_BattleDesc = {
    Text = "행동력을 [Arg1]pt 획득한다."
  },
  Skill_74895_Desc = {
    Text = "행동력을 [Arg1]pt 획득한다."
  },
  Skill_74895_Name = {
    Text = "새로운 컬렉션이 입고되었습니다"
  },
  Skill_74896_BattleDesc = {
    Text = "무작위로 [Arg1]pt의 피해를 [Arg2]회 입힌다. (이 피해에는 힘 1배 보너스가 적용된다)"
  },
  Skill_74896_Desc = {
    Text = "무작위로 [Arg1]pt의 피해를 [Arg2]회 입힌다. (이 피해에는 힘 1배 보너스가 적용된다)"
  },
  Skill_74896_Name = {
    Text = "거래 완료"
  },
  Skill_74897_BattleDesc = {
    Text = "반격을 [Arg1]스택 획득한다."
  },
  Skill_74897_Desc = {
    Text = "반격을 [Arg1]스택 획득한다."
  },
  Skill_74897_Name = {
    Text = "외상 거래는 허용되지 않습니다"
  },
  Skill_74898_BattleDesc = {
    Text = "전체 적의 임시 <PowerIconKeywords:힘>을 [Arg1]pt 감소시키고, 적 1명당 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다."
  },
  Skill_74898_Desc = {
    Text = "모든 적에게서 힘을 [Arg1]pt <TouquKeywords:탈취>한다."
  },
  Skill_74898_Name = {
    Text = "당신의 두개골은 이미 예약되었습니다."
  },
  Skill_74899_BattleDesc = {
    Text = "깨어남체 1명을 선택하여 광기를 [Arg1]pt 획득한다."
  },
  Skill_74899_Desc = {
    Text = "깨어남체 1명을 선택하여 광기를 [Arg1]pt 획득한다."
  },
  Skill_74899_Name = {
    Text = "당신이 원하는 물건"
  },
  Skill_74900_BattleDesc = {
    Text = "영역 숙련도를 [Arg1]pt 획득한다."
  },
  Skill_74900_Desc = {
    Text = "영역 숙련도를 [Arg1]pt 획득한다."
  },
  Skill_74900_Name = {
    Text = "천 년의 학식"
  },
  Skill_74901_BattleDesc = {
    Text = "이번 턴에 주는 중독, 반격, 출혈이 [Arg1]% 증가한다."
  },
  Skill_74901_Desc = {
    Text = "이번 턴에 주는 중독, 반격, 출혈이 [Arg1]% 증가한다."
  },
  Skill_74901_Name = {
    Text = "욕심부리지 마세요..."
  },
  Skill_74902_BattleDesc = {
    Text = "모든 깨어남체가 광기를 [Arg1]pt 획득한다."
  },
  Skill_74902_Desc = {
    Text = "모든 깨어남체가 광기를 [Arg1]pt 획득한다."
  },
  Skill_74902_Name = {
    Text = "오늘 한정 할인"
  },
  Skill_74903_BattleDesc = {
    Text = "다음 [Arg1]장의 명령 카드가 추가로 열쇠 에너지 [Arg2]pt를 획득한다."
  },
  Skill_74903_Desc = {
    Text = "다음 [Arg1]장의 명령 카드가 추가로 열쇠 에너지 [Arg2]pt를 획득한다."
  },
  Skill_74903_Name = {
    Text = "가격 협상 가능"
  },
  Skill_74945_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후, 광기가 가장 높은 적이 [Arg1]의 광기를 잃고 <PVPEmptinessKeywords:공허>를 획득한다."
  },
  Skill_74945_Name_1 = {
    Text = "최면 진자"
  },
  Skill_74946_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 시작 시, <HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 [Arg1] <PVPCardLockKeywords:카드 봉쇄>를 부여합니다. 장착자가 처치 후, 즉시 이 효과를 한 번 발동합니다."
  },
  Skill_74946_Name_1 = {
    Text = "마녀의 챙 넓은 모자"
  },
  Skill_76443_Desc = {
    Text = "중독 10000 추가"
  },
  Skill_76443_Name = {
    Text = "중독 10000 추가"
  },
  Skill_76444_Desc = {
    Text = "반격 10000 추가"
  },
  Skill_76444_Name = {
    Text = "반격 10000 추가"
  },
  Skill_76532_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 종료 시, 상대의 랜덤한 [Arg1]장의 손패에 [Arg2]스택의 <PVPAcheKeywords:감춰진 고통>을 부여한다."
  },
  Skill_76532_Name_1 = {
    Text = "감춰진 고통"
  },
  Skill_77673_Desc = {
    Text = "<DerivativeCardKeywords_133:「리아의 코인」> 1장을 버린 카드 더미에 넣는다."
  },
  Skill_77673_Name = {
    Text = "술집의 문"
  },
  Skill_77678_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「종말」 2스택을 획득한다."
  },
  Skill_77678_Name = {
    Text = "기계 펄스"
  },
  Skill_77680_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 발생시키고, 무작위로 3장의 카드에 「인지착란」을 추가하며, 1턴 동안 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <VulnerabilityIconKeywords:취약>, <BlindingKeywords:실타래명> 상태를 적용합니다. 2층의 종말을 잃습니다."
  },
  Skill_77680_Name = {
    Text = "의식 방해 장치"
  },
  Skill_77681_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「종말」 2스택을 획득한다."
  },
  Skill_77681_Name = {
    Text = "기계 팔 휘두르기"
  },
  Skill_77682_Desc = {
    Text = "심연의 문을 닫고 다른 적들을 제거한다. 반기계 형태로 변환하여 모든 HP를 회복하고, 현재 「종말」 스택에 비례하여 추가 최대 HP와 「융식 안개 실타래드」 15스택을 획득한다."
  },
  Skill_77682_Name = {
    Text = "기계 비상"
  },
  Skill_77683_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <IntoxicationIconKeywords:중독> [Poison:Arg3]스택을 부여하며, 「융식의 핵심」 2장을 덱에 섞어 넣는다. 「종말」 3스택을 잃는다."
  },
  Skill_77683_Name = {
    Text = "융식 발효 구조체"
  },
  Skill_77684_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 「종말」 3스택을 획득하며 「심연의 문」을 연다. 매 턴 종료 시 적을 보충하며, 최대 2명까지 보충된다."
  },
  Skill_77684_Name = {
    Text = "종점, 진리와 심연의 문"
  },
  Skill_77685_Desc = {
    Text = "플레이어의 최대 HP를 [Arg1]로 변경하고, 「종말」 3스택을 잃는다."
  },
  Skill_77685_Name = {
    Text = "토후와보 응시 장치"
  },
  Skill_77714_Desc = {
    Text = "「종말」 10스택을 획득하고, <BleedingIconKeywords:출혈> [Arg1]스택을 부여한다. 종말, 곧 강림한다…!"
  },
  Skill_77714_Name = {
    Text = "시스템 리부트"
  },
  Skill_77846_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다. 필드에 다른 적이 1명 생존할 때마다 「종말」 1스택을 획득한다. 다른 모든 적을 처치했다면, 의도가 「자폭 개조」로 변경된다."
  },
  Skill_77846_Name = {
    Text = "종말의 부름"
  },
  Skill_77847_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다. 필드에 다른 적이 1명 생존할 때마다 「종말」 1스택을 획득한다. 다른 모든 적을 처치했다면, 의도가 「운명 붕괴」로 변경된다."
  },
  Skill_77847_Name = {
    Text = "종말의 부름"
  },
  Skill_77851_Desc = {
    Text = "2턴간 <WeaknessIconKeywords:허약>을 부여하고, <ReinforcePVEKeywords:견고> [Arg2]스택을 획득한다."
  },
  Skill_77851_Name = {
    Text = "자폭 개조"
  },
  Skill_77852_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Poison:Arg1]스택을 부여한다. 턴 종료 시, 다른 적들이 <PowerIconKeywords:힘> [Power:Arg2]pt를 획득한다."
  },
  Skill_77852_Name = {
    Text = "숙명 붕괴"
  },
  Skill_78648_Desc = {
    Text = "모든 아군의 최대 HP가 1이 된다."
  },
  Skill_78648_Name = {
    Text = "토후와보후 장치"
  },
  Skill_78782_AwakerSkillBackgroundStory = {
    Text = "일렁이는 추의 움직임 속에서 세상은 소멸하기 시작한다.\n시야에도, 마음속에도, 머릿속에도 남은 것은 오직 하나의 형상뿐.\n그것은 구원인 동시에, 끔찍한 절망이다.."
  },
  Skill_78782_BattleDesc = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 [Arg2]회 회복한다. 모든 적의 <MadnessIconKeywords:광란> 상태를 임시로 제거하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시킨다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘> [Power:Arg4]pt를 획득한다."
  },
  Skill_78782_Desc = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복한다. 모든 적의 <MadnessIconKeywords:광란> 상태를 임시로 제거하고, 전체 적의 임시 <ExhaustionIconKeywords:힘>을 [Exhaustion:Arg3]pt 감소시킨다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘> [Power:Arg4]pt를 획득한다."
  },
  Skill_78782_EffectNameList = {
    Text = "회복, 힘 감소, 힘"
  },
  Skill_78782_Name = {
    Text = "심리적 위안"
  },
  Skill_78782_PropertyNameList = {
    Text = "체질*GrowValue1, 방어력*GrowValue2, 공격력*GrowValue3"
  },
  Skill_78783_AwakerSkillBackgroundStory = {
    Text = "그녀의 목소리는 부드럽고 친절하며, 너가 보지못한 정신의 어두운 면에서 얽히고 퍼집니다.\n한 사람은 자신 이외의 존재에게 패배할 수 없으며, 너 자신이 그녀의 무기입니다."
  },
  Skill_78783_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <Energy:[Energy:Arg5]>pt의 광기를 획득한다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘>을 [Power:Arg4]pt 획득한다."
  },
  Skill_78783_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 클레멘타인이 <Energy:[Energy:Arg3]>pt의 광기를 획득한다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘>을 [Power:Arg4]pt 획득한다."
  },
  Skill_78783_EffectNameList = {
    Text = "피해, 광기, 힘"
  },
  Skill_78783_Name = {Text = "타격"},
  Skill_78783_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_78784_Desc = {
    Text = "제거한 「공감」 1스택당, 전체 적에게 「두려움 고착」 1스택을 부여한다. 「두려움 고착」 1스택당 대상이 주는 피해가 3% 감소한다."
  },
  Skill_78784_Name = {
    Text = "전환·두려움 고착"
  },
  Skill_78785_AwakerSkillBackgroundStory = {
    Text = "「당신의 진짜 정체가 무엇인지 말해줄 수 있나요?」\n그녀는 이렇게 물으며 미소 지었다.\n하지만 그 불쌍한 환자는 당연히 대답할 수 없었다. 그의 기억은 이미 조작되었고, 추적할수록 심어진 기억 속의 공포스러운 존재에 가까워질 뿐이었다. 결국 인지가 완전히 붕괴되어 괴물로 변할 때까지."
  },
  Skill_78785_BattleDesc_0 = {
    Text = "자신의 <AnalysisKeywords0:공감>을 모두 제거하고, <D13AFKeyWord2:정신적 상처> 또는 <D13AFKeyWord1:두려움 고착> 중 하나를 선택하여 전체 적에게 부여한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg6]회 입히고, <Posse:[Arg3]>pt의 열쇠 에너지를 획득한다."
  },
  Skill_78785_BattleDesc_2 = {
    Text = "자신의 <AnalysisKeywords0:공감>을 모두 제거하고, <D13AFKeyWord2:정신적 상처> 또는 <D13AFKeyWord1:두려움 고착> 중 하나를 선택하여 전체 적에게 부여한다. 1스택씩 제거될 때마다 클레멘타인이 주는 기본 피해가 3% 증가한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg6]회 입히고, <Posse:[Arg3]>pt의 열쇠 에너지를 획득한다."
  },
  Skill_78785_BattleDesc_3 = {
    Text = "자신의 <AnalysisKeywords3:공감>을 모두 제거하고, <D13AFKeyWordQ2:정신적 상처> 또는 <D13AFKeyWordQ1:두려움 고착> 중 하나를 선택하여 전체 적에게 부여한다. 1스택 제거될 때마다 클레멘타인이 주는 기본 피해가 3% 증가한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg6]회 입히고, <Posse:[Arg3]>pt의 열쇠 에너지를 획득한다."
  },
  Skill_78785_Desc_0 = {
    Text = "자신의 <AnalysisKeywords0:공감>을 모두 제거하고, <D13AFKeyWord2:정신적 상처> 또는 <D13AFKeyWord1:두려움 고착> 중 하나를 선택하여 전체 적에게 부여한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 클레멘타인의 은열쇠 충전량의 [Arg2]%에 해당하는 열쇠 에너지를 획득한다."
  },
  Skill_78785_Desc_2 = {
    Text = "자신의 <AnalysisKeywords0:공감>을 모두 제거하고, <D13AFKeyWord2:정신적 상처> 또는 <D13AFKeyWord1:두려움 고착> 중 하나를 선택하여 전체 적에게 부여한다. 1스택 제거될 때마다 클레멘타인이 주는 기본 피해가 3% 증가한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 클레멘타인의 은열쇠 충전량의 [Arg2]%에 해당하는 열쇠 에너지를 획득한다."
  },
  Skill_78785_Desc_3 = {
    Text = "자신의 <AnalysisKeywords3:공감>을 모두 제거하고, <D13AFKeyWordQ2:정신적 상처> 또는 <D13AFKeyWordQ1:두려움 고착> 중 하나를 선택하여 전체 적에게 부여한다. 1스택 제거될 때마다 클레멘타인이 주는 기본 피해가 3% 증가한다. 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 클레멘타인의 은열쇠 충전량의 [Arg2]%에 해당하는 열쇠 에너지를 획득한다."
  },
  Skill_78785_EffectNameList = {
    Text = "피해, 은열쇠 에너지"
  },
  Skill_78785_Name = {
    Text = "생체 재구성"
  },
  Skill_78785_OverLimitUtlSkillDesc_0 = {
    Text = "자신의 모든 <AnalysisKeywords3:공감>을 제거하고, 모든 적의 <D13AFKeyWordQ2:정신적 상처>와 <D13AFKeyWordQ1:공포 고착>으로 전환하는 것을 선택합니다. <Posse:[Arg4]> 점 은열쇠 에너지와 [Power:Arg5] 점 <PowerIconKeywords:힘>을 획득하고, 모든 적에게 <Damage:[Damage:Arg1]> 점 데미지를 [Arg6]회 가합니다."
  },
  Skill_78785_OverLimitUtlSkillDesc_2 = {
    Text = "자신의 <AnalysisKeywords0:공감>을 모두 제거하고, <D13AFKeyWord2:정신적 상처>와 <D13AFKeyWord1:두려움 고착>을 모두 선택하여 전체 적에게 부여한다. 1스택씩 제거될 때마다 클레멘타인이 주는 기본 피해가 3% 증가한다. <Posse:[Arg4]>pt의 열쇠 에너지와 <PowerIconKeywords:힘>을 [Power:Arg5]pt 획득하고, 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg6]회 입힌다."
  },
  Skill_78785_OverLimitUtlSkillDesc_3 = {
    Text = "자신의 <AnalysisKeywords0:공감>을 모두 제거하고, <D13AFKeyWord2:정신적 상처>와 <D13AFKeyWord1:두려움 고착>을 모두 선택하여 전체 적에게 부여한다. 1스택씩 제거될 때마다 클레멘타인이 주는 기본 피해가 3% 증가한다. <Posse:[Arg4]>pt의 열쇠 에너지와 <PowerIconKeywords:힘>을 [Power:Arg5]pt 획득하고, 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 [Arg6]회 입힌다."
  },
  Skill_78785_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2％"
  },
  Skill_78786_AwakerSkillBackgroundStory = {
    Text = "피가 끓고, 영혼이 타오르며, 살과 뼈에서 짜낸 고통이 가장 맛있는 미식이다.\n이 미식은 반복해서 음미되며, 처음 비명부터 절망의 헐떡거림, 그리고 마지막으로 침묵의 창백한 죽음까지 이른다."
  },
  Skill_78786_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 무작위로 [AttackTimes:Arg2]회 입히고, <Posse:[Arg6]>pt의 열쇠 에너지를 획득한다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘>을 [Power:Arg5]pt 획득한다."
  },
  Skill_78786_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 무작위로 [AttackTimes:Arg2]회 입히고, 클레멘타인의 은열쇠 충전량의 [Arg3]%에 해당하는 열쇠 에너지를 획득한다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘>을 [Power:Arg5]pt 획득한다."
  },
  Skill_78786_EffectNameList = {
    Text = "피해, 힘"
  },
  Skill_78786_Name = {
    Text = "고통 착취"
  },
  Skill_78786_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_78787_AwakerSkillBackgroundStory = {
    Text = "심리 상담이 일단락되었지만, 그녀는 당신이 언젠가 돌아올 것임을 알고 있습니다.\n이 세계는 황량하고 잔인하며, 오직 여기서만 약간의 구원이 있습니다."
  },
  Skill_78787_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt [Arg2]회 획득하고, 광기를 <Energy:[Energy:Arg5]>pt 획득한다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘> [Power:Arg4]pt를 획득한다."
  },
  Skill_78787_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 클레멘타인이 광기를 <Energy:[Energy:Arg3]>pt 획득한다. <WormholeKeywords:초거리>: <PowerIconKeywords:힘> [Power:Arg4]pt를 획득한다."
  },
  Skill_78787_EffectNameList = {
    Text = "실타래드, 광기, 힘"
  },
  Skill_78787_Name = {Text = "방어"},
  Skill_78787_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2, 공격력*GrowValue3"
  },
  Skill_78788_Desc = {
    Text = "제거한 「공감」 1스택당, 전체 적에게 「정신적 상처」 1스택을 부여한다. 「정신적 상처」 1스택당 대상이 받는 피해가 3% 증가한다."
  },
  Skill_78788_Name = {
    Text = "전환·정신적 상처"
  },
  Skill_78789_AwakerSkillBackgroundStory = {
    Text = "낯선 울음소리가 당신의 머리를 깊숙이 파고들며, 당신의 기억 속을 흐릅니다.\n그때부터 당신의 호흡은 자기도 모르게 곤충의 냄새를 품기 시작합니다.\n이 부름을 느끼고, 이 부름을 받아들이고, 그러고 나서 탈피하고, 새로 태어나는 것입니다.\n내 친구여, 나의 동족이여."
  },
  Skill_78789_Desc_0 = {
    Text = "클레멘타인이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 클레멘타인이 매 턴 처음으로 사용하는 명령 카드의 피해, 실타래드, HP 회복, 광기 획득, 열쇠 에너지 획득 효과의 적용 횟수가 [Arg2] 증가한다."
  },
  Skill_78789_Desc_15 = {
    Text = "클레멘타인이 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 클레멘타인이 주는 피해 횟수가 1회 증가하고, 매 턴 처음으로 사용하는 명령 카드의 피해, 실타래드, HP 회복, 광기 획득, 열쇠 에너지 획득 효과의 적용 횟수가 [Arg2] 증가한다. 「공감」 상한이 20으로 증가한다."
  },
  Skill_78789_EffectNameList = {Text = "광기"},
  Skill_78789_Name = {
    Text = "괴충의 부름"
  },
  Skill_78904_Desc_1 = {
    Text = "대상에게 [Arg1]% 최대 HP의 피해를 준다. <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_78904_Desc_2 = {
    Text = "임의의 대상의 명륜을 교체합니다. <Energy:[Energy:Arg2]> 광기를 획득합니다."
  },
  Skill_78904_Name_1 = {
    Text = "냥냥 펀치"
  },
  Skill_78904_Name_2 = {
    Text = "작은 아이디어"
  },
  Skill_78915_Desc_1 = {
    Text = "카드 [Arg1]장을 드로우하고, [Arg2]의 행동력을 획득한다."
  },
  Skill_78915_Name_1 = {
    Text = "리아의 동전"
  },
  Skill_78936_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_29:「리아의 동전」> [Arg1] 장을 다음 드로우 덱에 넣습니다."
  },
  Skill_78936_Name_1 = {
    Text = "술집의 문"
  },
  Skill_78936_UnknownName = {
    Text = "술집의 문"
  },
  Skill_79252_Desc_1 = {
    Text = "리셋 지령을 테스트한다."
  },
  Skill_79252_Name_1 = {
    Text = "리셋 명령 테스트"
  },
  Skill_79257_Desc_1 = {
    Text = "대상에게 [Arg1]% 최대 HP의 피해를 준다. <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_79257_Name_1 = {
    Text = "냥냥 펀치"
  },
  Skill_79302_Name = {
    Text = "출혈 10000 추가"
  },
  Skill_79478_Desc = {
    Text = "모든 손패를 버리고, 「충족」의 무작위 명령 카드로 교체한다. 「충족」은 매 턴 광기 폭발을 2회 발동할 수 있다."
  },
  Skill_79478_Name = {
    Text = "군체 의식"
  },
  Skill_79758_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_79759_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_79760_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_79761_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, <FragileIconKeywords:손상>을 [Arg3]턴간 부여한다."
  },
  Skill_80035_BattleDesc = {
    Text = "「초차원 초월」을 수행한다."
  },
  Skill_80035_Desc = {
    Text = "「초차원 초월」을 수행한다."
  },
  Skill_80035_Name = {Text = "초월"},
  Skill_80193_Desc_1 = {
    Text = "양쪽 모두 [Arg1]장의 카드를 뽑습니다."
  },
  Skill_80193_Name_1 = {
    Text = "특별 치료"
  },
  Skill_80193_UnknownName = {
    Text = "특별 치료"
  },
  Skill_80194_Desc = {
    Text = "<Heal:[Heal:Arg1]>의 HP를 회복하고, 힘 [Arg2]pt를 획득한다. 클레멘타인이 팀에 있을 경우, 그녀가 이번 턴에 다음으로 사용하는 명령 카드의 피해, 실타래드, HP 회복, 광기 획득, 열쇠 에너지 획득 효과의 적용 횟수가 1회 증가한다."
  },
  Skill_80194_Name = {
    Text = "특별 치료"
  },
  Skill_80355_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 발생시킨다. 턴 시작 시 무작위로 「인지착란」이 없는 지시어 2장에 「인지착란」을 적용한다."
  },
  Skill_80355_Name = {
    Text = "생명체 재구성"
  },
  Skill_80442_Desc = {
    Text = "<DamageUpKeywords:피해 증가> 1스택"
  },
  Skill_80442_Name = {
    Text = "클레멘타인 피해 증가"
  },
  Skill_80585_Desc = {
    Text = "「군체 포식」 1장을 손에 넣고, 모든 깨어남체의 치명타율이 [Arg1]% 감소한다."
  },
  Skill_80585_Name = {
    Text = "인지 추출"
  },
  Skill_80586_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 이번 턴에 치명타 피해를 받았다면 의도가 「인지 흡수」로 변경된다."
  },
  Skill_80586_Name = {Text = "독침"},
  Skill_80587_Desc = {
    Text = "부정 상태를 제거하고 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다."
  },
  Skill_80587_Name = {
    Text = "새로운 삶을 향해"
  },
  Skill_80588_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_80588_Name = {Text = "찌르기"},
  Skill_80589_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <WeaknessIconKeywords:허약>을 [Arg3]턴간 부여한다."
  },
  Skill_80589_Name = {Text = "독니"},
  Skill_80590_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, [Arg3]턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_80590_Name = {
    Text = "물어뜯기"
  },
  Skill_80591_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <MadnessIconKeywords:광란> 1스택을 획득한다."
  },
  Skill_80591_Name = {
    Text = "광란의 추격"
  },
  Skill_80605_Desc = {
    Text = "「군체 포식」 [Arg1]장을 손에 넣는다. 덱의 무작위 카드 [Arg2]장에 「둔화」 [Arg3]스택을 부여한다."
  },
  Skill_80605_Name = {
    Text = "신경 독소"
  },
  Skill_80606_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 손에 남아 있는 카드에 「둔화」 [Arg3]스택을 부여한다."
  },
  Skill_80606_Name = {
    Text = "정신 기생"
  },
  Skill_80607_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_80607_Name = {
    Text = "사냥의 순간"
  },
  Skill_80608_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, [Arg3]턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_80608_Name = {
    Text = "사냥의 시간·파쇄"
  },
  Skill_80609_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <HeavyInjuryKeywords:중상>을 [Arg3]턴간 부여한다."
  },
  Skill_80609_Name = {
    Text = "사냥의 시간·중상"
  },
  Skill_80749_Desc = {
    Text = "<PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, 「옛날 잔재」 [Arg2]스택을 획득한다."
  },
  Skill_80749_Name = {
    Text = "히스테리"
  },
  Skill_80750_Desc = {
    Text = "이 의도로 전환한 후, 이번 턴에 받는 능동 피해가 100% 증가한다. 발동 후 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다."
  },
  Skill_80750_Name = {Text = "잠복"},
  Skill_80751_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 발생시킨다. [Arg3]% 의 피해를 주는 중독을 부여하며, 방패당 피해가 1 감소한다. 만약 이 피해가 「죽음 저항」을 촉발했다면, 남은「죽음 저항」의 양을 반으로 줄인다."
  },
  Skill_80751_Name = {
    Text = "독침 분사"
  },
  Skill_80752_Desc = {
    Text = "피해 <Damage:[Damage:Arg1]>pt의 <PunctureDamagewords:관통> 피해를 [AttackTimes:Arg2]회 준다. 잃은 HP의 [Arg3]%를 회복하고, 「우주 유능」 1스택당 최대 HP를 [Arg5]% 증가시킨다. 「우주 윤회」 [Arg4]스택을 획득한다. 「우주 윤회」: 치명적 피해를 받을 경우, 모든 HP를 회복하고 임시 견고를 30스택 획득한다."
  },
  Skill_80752_Name = {
    Text = "변화의 순간"
  },
  Skill_80753_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 손에 남아 있는 카드에 「둔화」 [Arg3]스택을 부여하며, 「군체 포식」 1장을 손에 넣는다."
  },
  Skill_80753_Name = {
    Text = "정신 기생"
  },
  Skill_80754_Desc = {
    Text = "「우주 유능」 1스택을 제거하고 「은신」 상태로 진입하여 「충족」 [Arg1]마리를 소환한다. 「충족」은 매 턴마다 <MadnessIconKeywords:광란> [Arg2]스택을 획득한다. 다른 적이 모두 사망하면 「은신」이 해제된다."
  },
  Skill_80754_Name = {
    Text = "동족 호출"
  },
  Skill_80755_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「군체 포식」 [Arg3]장을 손에 넣는다. 이번 턴에 「옛날 잔재」를 파괴했다면, 피해가 없는 「신경 독소」로 변경된다."
  },
  Skill_80755_Name = {
    Text = "퍼지는 독소"
  },
  Skill_80756_Desc = {
    Text = "이 의도로 전환한 후, 이번 턴에 받는 능동 피해가 100% 증가한다. 발동 후 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다."
  },
  Skill_80756_Name = {Text = "잠복"},
  Skill_80757_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 대상이 HP를 [Arg3]% 잃을 때마다 피해 횟수가 1회 증가한다. 「우주 유능」이 존재할 경우, 1스택을 제거하고 <MadnessIconKeywords:광란> 1스택을 획득한다."
  },
  Skill_80757_Name = {
    Text = "고통 절단"
  },
  Skill_80758_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 실타래드 1pt당 이 피해가 1pt 감소한다. 「우주 유능」이 존재할 경우, 1스택을 제거하고 <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_80758_Name = {
    Text = "차원 찢기"
  },
  Skill_80759_Desc = {
    Text = "「우주 유능」 1스택을 제거하고 「은신」 상태로 진입하여 「충족」 [Arg1]마리를 소환한다. 「충족」은 매 턴마다 <MadnessIconKeywords:광란> [Arg2]스택을 획득한다. 다른 적이 모두 사망하면 「은신」이 해제된다."
  },
  Skill_80759_Name = {
    Text = "동족 호출"
  },
  Skill_80760_Desc = {
    Text = "이 의도로 전환한 후, 이번 턴에 받는 피해가 100% 증가한다. 발동 후 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 [Arg1]스택 부여한다."
  },
  Skill_80760_Name = {Text = "잠복"},
  Skill_80762_Desc = {
    Text = "「탈화자」 [Arg1]명을 전방에 소환한다."
  },
  Skill_80762_Name = {
    Text = "유충 번식"
  },
  Skill_80763_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 「군체 포식」 [Arg3]장을 손에 넣는다. 이번 턴에 「옛날 잔재」를 파괴했다면, 낮은 피해량의 「정신 기생」으로 변경된다."
  },
  Skill_80763_Name = {
    Text = "퍼지는 고통"
  },
  Skill_80764_Desc = {
    Text = "「공허 유능」 [Arg1]스택을 획득하고, 모든 깨어남체의 치명타율이 [Arg4]% 감소한다. 다음 턴 시작 시, 깨어남체 [Arg2]명을 선택하여, 모든 카드와 광기 폭발을 [Arg3]턴간 봉인한다."
  },
  Skill_80764_Name = {
    Text = "의식 유폐"
  },
  Skill_80765_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 발생시킨다. [Arg3]% 의 피해를 주는 중독을 부여하며, 방패당 피해가 1 감소한다. 만약 이 피해가 「죽음 저항」을 촉발했다면, 남은「죽음 저항」의 양을 반으로 줄인다."
  },
  Skill_80765_Name = {
    Text = "독침 분사"
  },
  Skill_80766_Desc = {
    Text = "「탈화자」 [Arg1]명을 전방에 소환한다."
  },
  Skill_80766_Name = {
    Text = "유충 번식"
  },
  Skill_80767_Desc = {
    Text = "「군체 포식」 [Arg1]장을 손에 넣는다. 덱의 무작위 카드 [Arg2]장에 「둔화」 [Arg3]스택을 부여한다."
  },
  Skill_80767_Name = {
    Text = "신경 독소"
  },
  Skill_80768_Desc = {
    Text = "「군체 포식」 [Arg1]장을 손에 넣는다. 덱의 무작위 카드 [Arg2]장에 「둔화」 [Arg3]스택을 부여한다."
  },
  Skill_80768_Name = {
    Text = "신경 독소"
  },
  Skill_80769_Desc = {
    Text = "「초변자」 [Arg1]명을 전방에 소환하고, 임시 <MadnessIconKeywords:광란> 1스택을 획득한다."
  },
  Skill_80769_Name = {Text = "모방"},
  Skill_80969_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <MadnessIconKeywords:광란> 1스택을 획득한다. 깨어남 카드 사용 후 의도가 「고통 착취」로 변경된다."
  },
  Skill_80969_Name = {
    Text = "심리 교살"
  },
  Skill_81071_Desc = {
    Text = "「탈화자」 [Arg1]명을 전방에 소환한다."
  },
  Skill_81071_Name = {
    Text = "유충 번식"
  },
  Skill_81267_Desc = {
    Text = "초차원 공간을 채운다."
  },
  Skill_81267_Name = {
    Text = "초차원 공간 채우기"
  },
  Skill_81296_Desc = {
    Text = "턴 종료 시 손에 있을 경우, 최대 HP를 [Arg1] 잃고 <DepleteIconKeywords:소모>된다. 사용 시, 전방 적에게 「옛날 잔재」 [Arg2]스택을 부여하고, 이 카드를 덱 맨 아래에 넣는다."
  },
  Skill_81296_Name = {
    Text = "군체 포식"
  },
  Skill_81300_Desc = {
    Text = "「비틀거림」, 「질식」, 「산호 증식」, 「모독의 환영」, 「광란」 중 1장을 선택하여 손에 넣고, 나머지 4장은 버린 카드 더미에 넣는다."
  },
  Skill_81300_Name = {
    Text = "세계 연역법"
  },
  Skill_81343_Desc = {
    Text = "1층「우주 유능」을 제거하고, <WeaknessIconKeywords:허약>와<HeavyInjuryKeywords:중창> [Arg1] 턴 동안, 드로우 덱 [Arg2] 장의 명령 카드에 「인지착란」을 적용한다."
  },
  Skill_81343_Name = {
    Text = "벌레 둥지 간섭"
  },
  Skill_81433_Desc = {
    Text = "모든 깨어남체의 <CardKeyWord:봉인> 상태와 치명타율 감소 효과를 해제하고, 적의 「견고」 상태를 제거한다. 이전 턴 마지막으로 사용한 5장의 서로 다른 비파생 명령 카드의 원본 복사본을 손에 넣고, 해당 카드들의 행동력 소모를 0으로 만든 후, <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 부여한다."
  },
  Skill_81433_Name = {
    Text = "회귀 구조"
  },
  Skill_83574_BattleDesc = {
    Text = "모든 「출항」([Arg1])을 제거한다. 1스택 제거할 때마다 최종 피해가 [Arg2]% 증가하고, 모든 각성체가 [Arg3]점의 광기를 획득한다.\n한 번에 5스택 이상의 「출항」을 제거하면, 모든 적을 1턴 동안 <VulnerabilityIconKeywords:취약> 상태로 만들고, 그들에게 HP 소모의 [Arg4]%에 해당하는 <FixedDamage:순수 피해>를 입힌다."
  },
  Skill_83574_Desc = {
    Text = "모든 「출항」을 제거한다. 1스택 제거할 때마다 최종 피해가 10% 증가하고, 모든 각성체가 광기 5점을 획득한다.\n한 번에 5스택 이상의 「출항」을 제거하면, 모든 적을 1턴 동안 「취약」 상태로 만들고, 그들에게 HP 소모의 35%에 해당하는 <FixedDamage:순수 피해>를 입힌다."
  },
  Skill_83574_Name = {
    Text = "파도를 가르는 출항"
  },
  Skill_83575_BattleDesc = {
    Text = "모든 「정박」([Arg1])을 제거한다. 1스택을 제거할 때마다 죽음 저항이 [Arg2]% 증가하고, 행동력 [Arg3]pt를 획득하며, 카드 [Arg4]장을 드로우한다. 한 번에 5스택 이상 「정박」을 제거하면 임시 <ParcloseIconKeywords:장벽> [Arg5]스택을 획득한다."
  },
  Skill_83575_Desc = {
    Text = "모든 「정박」을 제거한다. 1스택을 제거할 때마다 죽음 저항이 15% 증가하고, 행동력 1pt를 획득하며, 카드 1장을 드로우한다. 한 번에 5스택 이상 「정박」을 제거하면 임시 장벽 1스택을 획득한다."
  },
  Skill_83575_Name = {
    Text = "해안 정박"
  },
  Skill_83576_BattleDesc = {
    Text = "「파도 출항」([Arg1]) 또는 「정박 휴식」([Arg2]) 중 하나를 선택한다. 버릴 경우 <DepleteIconKeywords:소모>된다."
  },
  Skill_83576_Desc = {
    Text = "「파도 출항」 또는 「정박 휴식」 중 하나를 선택한다. 버릴 경우 <DepleteIconKeywords:소모>된다."
  },
  Skill_83576_Name = {
    Text = "항해사의 선택"
  },
  Skill_83779_AwakerSkillBackgroundStory = {
    Text = "무한한 염수가 그녀를 포식했으며, 동시에 그녀를 보호했다.\n숨 막히는 침몰 속에서, 그녀는 깊은 바다를 감지하며, 깊은 바다에 녹아들었다.\n언젠가 바다는 완전히 고요해질 것이며, 바다 위를 항해하는 모든 배들은 평화를 부여받을 것이다.\n그녀는 그 날, 즉 “신국 강림의 날”을 기다리고 있다."
  },
  Skill_83779_Desc_0 = {
    Text = "코르포상이 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「<DerivativeCardKeywords_106:파일럿>」 2장을 손에 넣는다. 「정해」 자세로 전환한 후 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 쿨타임 3턴."
  },
  Skill_83779_Desc_15 = {
    Text = "코르포상이 광기를 <Energy:[Energy:Arg1]>pt 획득한다. <ExaltIconKeywords:영지 깨어남>: 촉수 1개를 획득하고, 「<DerivativeCardKeywords_106:파일럿>」 2장을 손에 넣는다. 매 턴 첫 번째 「징벌 뇌정」과 「혼돈 기류」가 추가로 「<DerivativeCardKeywords_106:파일럿>」 1장을 손에 넣으며, 「<DerivativeCardKeywords_106:파일럿>」의 효과가 50% 증가한다. 「정해」 자세로 전환한 후 실타래드를 <Block:[Block:Arg2]>pt 획득한다. 쿨타임 3턴."
  },
  Skill_83779_EffectNameList = {
    Text = "광기, 실타래드"
  },
  Skill_83779_Name = {
    Text = "먼 바다에서의 침몰"
  },
  Skill_83779_PropertyNameList = {
    Text = "$GrowValue1, 방어력*GrowValue2"
  },
  Skill_83780_AwakerSkillBackgroundStory = {
    Text = "구름은 기후 변화에 대해 알려주고, 파도는 해류의 변화를 이야기하지만, 폭풍이 실타래제로 닥쳤을 때, 아무리 거대한 배라도 결국은 무력하게 파도에 휘말리게 된다.\n 이때, 항해사의 측정과 안내는 모든 생존자에게 마지막 퇴로가 된다.\n 그러므로 자신의 의무를 다하라, 비록 번개가 몸을 치더라도, 고통 속에서 한 줄기 빛을 발산하여 해안의 방향을 안내해야 한다.\n 그것은 당신이 반드시 완수해야 할 사명이다."
  },
  Skill_83780_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 촉수 [Arg2]개를 생성한다. 모든 손패를 버리고, 버린 장수만큼 카드를 드로우한다."
  },
  Skill_83780_BattleDesc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 촉수 [Arg2]개를 생성한다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여하고, 임시 치명타 피해가 [Arg5]% 증가한다. 모든 손패를 버리고, 버린 장수만큼 카드를 뽑는다."
  },
  Skill_83780_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 촉수 [Arg2]개를 생성한다. 모든 손패를 버리고, 버린 장수만큼 카드를 드로우한다."
  },
  Skill_83780_Desc_3 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 촉수 [Arg2]개를 생성한다. 전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 임시 치명타 피해가 [Arg3]% 증가하고, 이번 전투에서 죽음 저항이 발동될 때마다 추가로 [Arg4]% 증가한다. 모든 손패를 버리고, 버린 장수만큼 카드를 뽑는다."
  },
  Skill_83780_EffectNameList = {
    Text = "실타래드"
  },
  Skill_83780_Name = {
    Text = "심해를 비추는 인도"
  },
  Skill_83780_OverLimitUtlSkillDesc_0 = {
    Text = "손패의 모든 카드를 버리고 같은 수량의 카드를 뽑으며, 버린 카드의 「여파」 효과를 1회 추가로 발동합니다. <Block:[Block:Arg1]>점의 방어막, [Arg2]개의 임시 촉수, [Arg2]개의 영구 터치 월을 획득합니다."
  },
  Skill_83780_OverLimitUtlSkillDesc_3 = {
    Text = "전체 적에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여하고, 임시 치명타 피해가 [Arg5]% 증가한다. 모든 손패를 버리고, 버린 장수만큼 카드를 뽑으며, 버린 카드의 「여파」 효과를 추가로 1회 발동한다. 실타래드를 <Block:[Block:Arg1]>pt 획득하고, 임시 촉수 [Arg2]개, 영구 촉수 [Arg2]개를 생성한다."
  },
  Skill_83780_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_83781_AwakerSkillBackgroundStory = {
    Text = "그녀는 배의 \"언어\"이기도 하다. 광활한 바다 위에서 깃발을 들어 동료들을 이끈다."
  },
  Skill_83781_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_83781_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg4]>pt 획득한다. <RippleKeywords:여파>: 다음에 사용할 때 획득하는 광기가 [Arg3] 증가하며, 최대 2회 중첩된다."
  },
  Skill_83781_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 코르포상이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_83781_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 코르포상이 광기를 <Energy:[Energy:Arg4]>pt 획득한다. <RippleKeywords:여파>: 다음에 사용할 때 획득하는 광기가 [Arg3] 증가하며, 최대 2회 중첩된다."
  },
  Skill_83781_EffectNameList_0 = {
    Text = "실타래드, 광기"
  },
  Skill_83781_EffectNameList_1 = {
    Text = "실타래드, 광기"
  },
  Skill_83781_Name = {Text = "방어"},
  Skill_83781_PropertyNameList_0 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_83781_PropertyNameList_1 = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_83782_AwakerSkillBackgroundStory = {
    Text = "그녀는 배의 ‘머리’입니다. 정박 중이든 항해 중이든, 언제나 가장 합리적인 판단을 내린다."
  },
  Skill_83782_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_83782_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg4]>pt의 광기를 획득한다. <RippleKeywords:여파>: 다음에 사용할 때 획득하는 광기가 [Arg3] 증가하며, 최대 2회 중첩된다."
  },
  Skill_83782_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 코르포상이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_83782_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 코르포상이 <Energy:[Energy:Arg4]>pt의 광기를 획득한다. <RippleKeywords:여파>: 다음에 사용할 때 획득하는 광기가 [Arg3] 증가하며, 최대 2회 중첩된다."
  },
  Skill_83782_EffectNameList_0 = {
    Text = "피해, 광기"
  },
  Skill_83782_EffectNameList_1 = {
    Text = "피해, 광기"
  },
  Skill_83782_Name = {Text = "타격"},
  Skill_83782_PropertyNameList_0 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_83782_PropertyNameList_1 = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_83783_AwakerSkillBackgroundStory = {
    Text = "깃발 신호는 만국 공통어지만, 동시에 지극히 은밀한 언어이기도 하다.\n의식이 차원의 문을 넘어 「그」를 만났을 때, 케르퍼산트는 특별한 신호를 부여받았다.\n불경하게 깃발을 펄럭일 때마다, 그것은 곧 저 위대한 존재의 부름에 응답하는 의식이 된다."
  },
  Skill_83783_Desc_0 = {
    Text = "<Energy:[Energy:Arg1]>pt의 광기를 획득한다. 「<DerivativeCardKeywords_106:파일럿>」 [Arg2]장을 손에 넣는다."
  },
  Skill_83783_Desc_15 = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득한다. 「<DerivativeCardKeywords_106:파일럿>」 [Arg2]장을 손에 넣는다. 전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_83783_Desc_2 = {
    Text = "<Energy:[Energy:Arg1]>pt의 광기를 획득한다. 「<DerivativeCardKeywords_106:파일럿>」 [Arg2]장을 손에 넣고, 모든 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_83783_EffectNameList = {Text = "광기"},
  Skill_83783_Name = {
    Text = "혼돈의 깃발 신호"
  },
  Skill_83784_AwakerSkillBackgroundStory = {
    Text = "분노할 때조차도 크퍼산트는 이성적입니다.\n 그녀는 먼저 상대방이 저지른 잘못을 판단한 후, 그 정도에 따라 어떤 레벨의 처벌을 주어야 할지 계산합니다.\n 왜냐하면 광활한 바다에서 질서가 없다면, 살육과 배신이 모든 것을 포식할 것입니다."
  },
  Skill_83784_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 무작위로 [Arg2]회 입히고, 이 피해에는 [Arg3]%의 촉수 피해 보너스가 적용된다. 피해를 1회 입힐 때마다 대상이 이번 턴에 받는 촉수 피해가 [Arg4]% 증가한다. 「<DerivativeCardKeywords_106:파일럿>」 2장을 손에 넣는다. <RippleKeywords:여파>: 이 카드는 덱 맨 위로 돌아간다."
  },
  Skill_83784_Desc_15 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 무작위로 [Arg2]회 입히고, 이 피해에는 [Arg3]%의 촉수 피해 보너스가 적용된다. 피해를 1회 입힐 때마다 대상이 이번 턴에 받는 촉수 피해가 [Arg4]% 증가한다. 「<DerivativeCardKeywords_106:파일럿>」 [Arg5]장을 손에 넣는다. <RippleKeywords:여파>: 이 카드는 덱 맨 위로 돌아간다."
  },
  Skill_83784_EffectNameList = {
    Text = "피해, 촉수 피해 증가"
  },
  Skill_83784_Name = {
    Text = "징벌의 번개"
  },
  Skill_83784_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2％"
  },
  Skill_84228_BattleDesc_1 = {
    Text = "무작위로 [Arg3]회 <Damage:[Damage:Arg1]> 피해를 가합니다. [Arg2] <PVPProtectiveKeywords:장벽>을 보유할 때마다 추가로 1회 피해를 가합니다."
  },
  Skill_84228_Desc_1 = {
    Text = "랜덤으로 3회 <Damage:[Damage:Arg1]>의 피해를 준다. <PVPProtectiveKeywords:장벽>을 [Arg2] 보유할 때마다 추가로 1회 피해를 준다."
  },
  Skill_84228_Name_1 = {
    Text = "뇌우의 분노"
  },
  Skill_84229_Desc_1 = {
    Text = "아군 한 명에게 [Arg1] 층 <PVPProtectiveKeywords:스택>을 주고, <PVPPenetrateKeywords:관통>."
  },
  Skill_84229_Name_1 = {
    Text = "심해를 비추는 인도"
  },
  Skill_84230_Desc_1 = {
    Text = "아군 한 명의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_84230_Name_1 = {
    Text = "명해의 숨결"
  },
  Skill_84231_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_84231_Name_1 = {Text = "타격"},
  Skill_84232_Desc_1 = {
    Text = "아군 한 명을 <StrengthenKeywords:강화>하고, 그에게 <Energy:[Energy:Arg1]>의 광기를 부여한다."
  },
  Skill_84232_Name_1 = {
    Text = "파도의 격려"
  },
  Skill_84261_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시와 턴 시작 시, 자신에게 <PVPProtectiveKeywords:장벽>이 없으면 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 획득하고, 그렇지 않으면 <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_84261_Name_1 = {
    Text = "성화 속의 인도자"
  },
  Skill_84262_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, HP 손실타래이 가장 많은 아군의 HP를 <Heal:[Heal:Arg1]> 회복한다."
  },
  Skill_84262_Name_1 = {
    Text = "바다의 항해자"
  },
  Skill_84263_Desc_1 = {
    Text = "전체 아군에게 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_84263_Name_1 = {
    Text = "불멸의 번개"
  },
  Skill_84263_UnknownName = {
    Text = "불멸의 번개"
  },
  Skill_84357_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <RippleKeywords:여파>: <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하고, 촉수 피해가 [TentaclePower:Arg2] 증가한다."
  },
  Skill_84357_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다. <RippleKeywords:여파>: <PowerIconKeywords:힘> [Power:Arg2]pt를 획득하고, 촉수 피해가 [TentaclePower:Arg2] 증가한다."
  },
  Skill_84357_Name = {
    Text = "항로 인도"
  },
  Skill_84378_Desc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고 카드를 [Arg2]장 드로우한다. 코퍼산트가 파티에 있을 경우, 「파일럿」 1장을 손에 넣는다."
  },
  Skill_84378_Name = {
    Text = "불멸의 번개"
  },
  Skill_84383_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 「증상: 광기」 [Arg3]장을 덱에 섞어 넣는다."
  },
  Skill_84383_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 3회 입히고, 「증상: 광기」 1장을 덱 맨 위에 섞어 넣는다."
  },
  Skill_84383_Name = {
    Text = "징벌의 번개"
  },
  Skill_84384_BattleDesc = {
    Text = "힘이 [Arg1] 증가하고, <ParcloseIconKeywords:장벽> [Arg2]스택을 획득하며, <ReinforcePVEKeywords:견고> 5스택을 획득한다. 다음 턴 시작 시, 장벽 1스택당 <ReinforcePVEKeywords:견고> 1스택으로 전환된다."
  },
  Skill_84384_Desc = {
    Text = "「심해를 비추는 인도」: 자신의 힘이 0.05 * 공격력만큼 증가하고, 장벽 8스택을 획득한다. 다음 턴 시작 시, 장벽 1스택당 견고 1스택으로 전환된다."
  },
  Skill_84384_Name = {
    Text = "심해를 비추는 인도"
  },
  Skill_84385_BattleDesc = {
    Text = "<WeaknessIconKeywords:허약>을 해제한다. 자신의 힘이 [Arg1] 증가하고, 받는 피해가 [Arg2]% 증가하며, 「징벌 뇌정」의 피해 횟수가 [Arg3] 증가한다."
  },
  Skill_84385_Desc = {
    Text = "「죽음을 향해 나아가는 천화」: 허약을 해제한다. 자신의 힘이 0.1 * 공격력만큼 증가하고, 받는 피해가 10% 증가하며, 「징벌 뇌정」의 피해 횟수가 1회 추가로 증가한다."
  },
  Skill_84385_Name = {
    Text = "죽음에 맞서는 천화"
  },
  Skill_84387_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, [Arg3]턴간 <VulnerabilityIconKeywords:취약>을 부여하며, 「증상: 광기」 [Arg4]장을 덱에 섞어 넣는다."
  },
  Skill_84387_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 4회 입히고, 2턴간 <VulnerabilityIconKeywords:취약>을 부여하며, 「증상: 광기」 1장을 덱 맨 위에 섞어 넣는다."
  },
  Skill_84387_Name = {
    Text = "징벌의 번개"
  },
  Skill_84388_BattleDesc = {
    Text = "피해 [Arg2]회 주고, [Arg3]턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_84388_Desc = {
    Text = "「혼돈 기류」: 피해 1회 주고, 2턴간 허약을 부여한다."
  },
  Skill_84388_Name = {
    Text = "혼돈의 깃발 신호"
  },
  Skill_84404_BattleDesc = {
    Text = "「징벌 뇌정」의 피해 횟수가 [Arg2] 증가한다. 「원해 침몰」 상태를 획득한다: 매 턴 종료 시 받는 피해가 [Arg3]% 증가하고, 자신이 장벽 [Arg4]스택을 획득한다."
  },
  Skill_84404_Desc = {
    Text = "원해 침몰: 징벌 뇌정의 피해 횟수가 1 증가한다. 「원해 침몰」상태를 획득한다: 매 턴 종료 시 받는 피해가 5% 증가하고, 자신이 장벽 2스택을 획득한다."
  },
  Skill_84404_Name = {
    Text = "먼 바다에서의 침몰"
  },
  Skill_89423_Desc_1 = {
    Text = "모든 적과 아군의 다른 캐릭터에게 <Damage:[Damage:Arg1]>의 피해를 주고, 피해량만큼 실타래드를 획득한다."
  },
  Skill_89423_Name_1 = {
    Text = "죽음의 폭풍"
  },
  Skill_89424_Desc_1 = {
    Text = "아군 한 명을 선택하여 <PVPDerivativeCardKeywords_16:「검은 깃털」> 1장을 획득한다."
  },
  Skill_89424_Name_1 = {
    Text = "칠흑의 비"
  },
  Skill_89425_Desc_1 = {
    Text = "<StrongEffectKeywords:강효> +[Arg1]을 부여하고, 모든 아군이 <PVPDerivativeCardKeywords_16:「검은 깃털」> 1장을 획득한다."
  },
  Skill_89425_Name_1 = {
    Text = "불굴의 고독한 새"
  },
  Skill_89426_Desc_1 = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>: 턴 종료 시 생명력과 보호막이 가장 낮은 아군이 <PVPDerivativeCardKeywords_16:「흑우」> [Arg1] 장을 획득합니다."
  },
  Skill_89426_Name_1 = {
    Text = "외로운 깃털"
  },
  Skill_89427_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_89427_Name_1 = {Text = "타격"},
  Skill_89428_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 피해량만큼의 광기를 획득하며, <PVPProtectiveKeywords:장벽> [Arg2]스택을 획득한다."
  },
  Skill_89428_Name_1 = {
    Text = "검은 깃털"
  },
  Skill_89429_Desc_1 = {
    Text = "<TauntKeywords:도발>을 부여하고, 모든 아군이 <StrongEffectKeywords:강효> +[Arg1]을 획득한다."
  },
  Skill_89429_Name_1 = {
    Text = "지키는 의지"
  },
  Skill_89430_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>:손패 상한 + [Arg2]. 「광기 폭발」 후 [Arg1] 연산력을 획득한다."
  },
  Skill_89430_Name_1 = {
    Text = "견딜 수 없는 자유"
  },
  Skill_89532_Desc_1 = {
    Text = "아군 1명을 선택하여 [Arg1]장의 <PVPDerivativeCardKeywords_16:'검은 깃털'>를 획득합니다."
  },
  Skill_89532_Name_1 = {
    Text = "어긋난 운명"
  },
  Skill_89532_UnknownName = {
    Text = "어긋난 운명"
  },
  Skill_89563_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체가 사망한 후, 자신의 행동력 소모가 [Arg1] 감소한 모든 「스킬」을 덱에 섞어 넣고, 소속자를 남은 HP가 가장 높은 아군으로 변경한다."
  },
  Skill_89563_Name_1 = {
    Text = "폐허로부터의 부활"
  },
  Skill_89659_Desc_1 = {
    Text = "카드 [Arg1]장을 드로우하고, [Arg2]의 행동력을 획득한다."
  },
  Skill_89659_Name_1 = {Text = "영감"},
  Skill_89750_Desc = {
    Text = "대기 중…"
  },
  Skill_89750_Name = {Text = "대기"},
  Skill_89776_AwakerSkillBackgroundStory = {
    Text = "\"형, 형은 날개를 계속 펴고, 계속 날면 얼마나 높이까지 날 수 있을 거라고 생각해? 구름 너머 위로 날아가 달과 별을 만질 수 있을까?\"\n\"아마... 그럴 수 있을지도 몰라? 그러려면 우리에게는 정말 크고 힘 있는 날개가 필요해.\"\n수첩 속 깊고 몽환적인 은하수와 별자리는 두 아이의 깊은 꿈속으로 반영되어 하나의 소원의 씨앗으로 변해 그들의 마음속에 심어졌다."
  },
  Skill_89776_Desc_0 = {
    Text = "카스토르가 <Energy:[Energy:Arg1]> 포인트의 광기를 얻습니다. <ExaltIconKeywords:영지 깨어남>:카스토르가 입히는 피해는 반드시 크리티컬이며, 「<DerivativeCardKeywords_107:검은 깃털>」 사용 후 대상에게 [Corrosion:Arg2] 층의 <Corrosion:침식>을 부여하고, 보존되는 방어막가 50% 증가합니다."
  },
  Skill_89776_Desc_15 = {
    Text = "카스토르가 <Energy:[Energy:Arg1]> 포인트의 광기를 획득합니다. <ExaltIconKeywords:영지 깨어남>: 카스토르가 가하는 피해가 반드시 크리티컬로 적중하며, 「<DerivativeCardKeywords_107:검은 깃털>」을 사용 후 대상에게 [Corrosion:Arg2] 층의 <Corrosion:침식>을 부여하고, 보존되는 방어막가 50% 증가합니다. 매 턴 처음 검은 깃털을 사용할 때 전열 적에게 특성 「정화의 깃털」과 동일한 침식을 가하며, 침식 제거 시 잃는 HP가 300%에서 500%로 증가합니다."
  },
  Skill_89776_EffectNameList = {
    Text = "광기, 침식"
  },
  Skill_89776_Name = {
    Text = "비상하는 숙원"
  },
  Skill_89776_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_89777_AwakerSkillBackgroundStory = {
    Text = "그는 전투 기술을 배우지 않았지만, 저항의 힘은 이미 그의 삶의 본능에 뿌리내리고 있습니다."
  },
  Skill_89777_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_89777_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 카스토르가 <Energy:[Energy:Arg2]>pt의 광기를 획득한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, <Block:[Block:Arg3]>pt의 실타래드를 획득한다."
  },
  Skill_89777_EffectNameList = {
    Text = "피해, 광기, 퀘이사 실타래드"
  },
  Skill_89777_Name = {Text = "타격"},
  Skill_89777_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2, 방어력*GrowValue3"
  },
  Skill_89778_AwakerSkillBackgroundStory = {
    Text = "그는 어리석고, 고집스럽고, 결코 변하지 않았다. 비록 외로운 울음소리만을 낼 수 있다 해도, 어떤 사슬과 칼날에도 굴복하지 않을 것이다. 그는 닳지 않은 날카로운 부리를 사용해 감옥의 모든 균열을 쪼아내려고 한다. 검은 날개가 밤의 가장자리를 찢을 때, 그는 그 마지막 깃털을 물고, 자신의 그림자를 데리고 폭풍의 반대편 하늘빛으로 날아갈 것이다."
  },
  Skill_89778_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 「<DerivativeCardKeywords_107:검은 깃털>」 [Arg2]장을 덱에 넣는다."
  },
  Skill_89778_EffectNameList = {
    Text = "실타래드"
  },
  Skill_89778_Name = {
    Text = "고독한 새의 각오"
  },
  Skill_89778_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]> 포인트의 방어막를 획득합니다. 이번 턴 「<DerivativeCardKeywords_107:검은 깃털>」을 보존할 때 방어막가 <Block:[Block:Arg5]> 증가합니다. 「<DerivativeCardKeywords_107:검은 깃털>」을 사용할 때마다 목표에게 추가로 [Corrosion:Arg4] 층의 <Corrosion:침식>을 부여합니다. 「<DerivativeCardKeywords_107:검은 깃털>」 [Arg2]장을 덱에 섞고, 「<DerivativeCardKeywords_107:검은 깃털>」 [Arg3]장을 손패에 추가합니다."
  },
  Skill_89778_PropertyNameList = {
    Text = "방어력*GrowValue1"
  },
  Skill_89779_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg2]>pt의 피해를 입히고, 카드 [Arg1]장을 드로우한다. 유지: <Block:[Block:Arg3]>pt의 실타래드를 획득한다. 소모됨."
  },
  Skill_89779_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg2]>pt의 피해를 입히고, 카드 [Arg1]장을 드로우한다. 카드 3장을 사용할 때마다 행동력 1pt를 획득하고, 카스토르가 주는 최종 피해가 10% 증가한다([Arg4]/3). 유지: <Block:[Block:Arg3]>pt의 실타래드를 획득한다. 소모됨."
  },
  Skill_89779_Desc_0 = {
    Text = "<Damage:[Damage:Arg2]>pt의 피해를 입히고, 카드 [Arg1]장을 드로우한다. 유지: <Block:[Block:Arg3]>pt의 실타래드를 획득한다. 소모됨."
  },
  Skill_89779_Desc_3 = {
    Text = "<Damage:[Damage:Arg2]>pt의 피해를 입히고, 카드 [Arg1]장을 드로우한다. 카드 3장을 사용할 때마다 행동력 1pt를 획득하고, 카스토르가 주는 최종 피해가 10% 증가한다. 유지: <Block:[Block:Arg3]>pt의 실타래드를 획득한다. 소모됨."
  },
  Skill_89779_Name = {
    Text = "검은 깃털"
  },
  Skill_89780_AwakerSkillBackgroundStory = {
    Text = "잔혹한 착취에 맞서기 위해, 그리고 끝없이 반복되는 상실타래에 저항하기 위해, 그는 이 두 날개를 펼쳐 영원토록 동생의 앞을 막아설 것이다. 마지막 깃털 하나까지 모조리 잿더미로 타들어 가는 그날까지. 자신이 먼저 죽음의 문턱을 넘어서는 그 순간까지."
  },
  Skill_89780_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, 실타래드를 <Block:[Block:Arg3]>pt 획득한다."
  },
  Skill_89780_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 카스토르가 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, 실타래드를 <Block:[Block:Arg3]>pt 획득한다."
  },
  Skill_89780_EffectNameList = {
    Text = "실타래드, 광기, 퀘이사 실타래드"
  },
  Skill_89780_Name = {Text = "방어"},
  Skill_89780_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2, 방어력*GrowValue3"
  },
  Skill_89781_AwakerSkillBackgroundStory = {
    Text = "그의 날개가 펼쳐져, 넓은 방패처럼, 각각의 깃털이 단단한 뼈와 연결되어 당신의 머리 위에서 살랑살랑 흔들립니다.\n 그 검은 그림자가 당신을 감싸고, 모든 햇빛, 바람, 비와 피해를 차단하여 안전한 하늘을 지탱합니다.\n \"그것을 건드리지 마십시오, 이 어두운 저주가 가해자의 가슴으로 모두 되돌아가게 하십시오.\""
  },
  Skill_89781_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, 실타래드를 <Block:[Block:Arg3]>pt 획득한다."
  },
  Skill_89781_Desc_2 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 전체 적에게 1턴간 <WeaknessIconKeywords:허약>을 부여한다. 손에 있는 「<DerivativeCardKeywords_107:검은 깃털>」 1장당 광기를 <Energy:[Energy:Arg2]>pt 획득한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, 실타래드를 <Block:[Block:Arg3]>pt 획득한다."
  },
  Skill_89781_EffectNameList = {
    Text = "실타래드, 퀘이사 실타래드"
  },
  Skill_89781_Name = {
    Text = "태양을 가리는 깃털"
  },
  Skill_89781_PropertyNameList = {
    Text = "방어력*GrowValue1, 방어력*GrowValue2"
  },
  Skill_89782_AwakerSkillBackgroundStory = {
    Text = "그는 참는 데 익숙하지 않으며, 그 날개는 분노의 소용돌이를 일으킬 수 있다.\n 모든 피와 살은 바람의 날카로운 이빨에 찢겨져, 생생하게 죽음의 배 속으로 휘말릴 것이다.\n 하지만 두려워할 필요 없다, 그는 너의 이름을 허리케인의 눈에 두고, 그 가장 중앙의 고요함에 놓을 것이다."
  },
  Skill_89782_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 다른 아군의 임시 치명타 피해가 [Arg3]% 증가한다. <WormholeKeywords:초거리>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 넣고, <Block:[Block:Arg4]>pt의 실타래드를 획득한다."
  },
  Skill_89782_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, 다른 아군의 임시 크리티컬 피해가 [Arg3]% 증가한다. 이번 턴에 「<DerivativeCardKeywords_107:검은 깃털>」을 사용할 때마다 행동력 소모가 1 감소한다. <WormholeKeywords:퀘이사>: 「<DerivativeCardKeywords_107:검은 깃털>」 1장을 덱에 섞고, <Block:[Block:Arg4]>pt의 방어막를 획득한다."
  },
  Skill_89782_EffectNameList = {
    Text = "피해, 크리티컬 피해%, 퀘이사 방어막"
  },
  Skill_89782_Name = {
    Text = "어둠 속의 비행"
  },
  Skill_89782_PropertyNameList = {
    Text = "공격력*GrowValue1, $GrowValue2%, 방어력*GrowValue3"
  },
  Skill_89949_Desc = {
    Text = "잠금 해제된 열쇠 지령 중 무작위 3개를 보고 1개를 선택하여 발동시킨다. 각 열쇠 지령은 이번 탐색에서 1번만 선택할 수 있으며, 초기 지급된 열쇠 지령은 선택할 수 없다."
  },
  Skill_89949_Name = {
    Text = "봉인된 옛 기억"
  },
  Skill_90212_Desc = {
    Text = "깨어남체 1명을 선택하여 <Energy:[Energy:Arg3]>의 광기를 획득하고, 덱에서 행동력 소모가 가장 낮은 카드 [Arg2]장을 드로우한다. 카스토르가 팀에 있을 경우, 카스토르의 피해 <StrongEffectKeywords:강효>를 임시로 [Arg1]% 증가시킨다."
  },
  Skill_90212_Name = {
    Text = "어긋난 운명"
  },
  Skill_90565_Desc = {
    Text = "「제령나이트 칵테일」 추가: 열쇠 에너지를 [Arg1]pt 획득한다."
  },
  Skill_90565_Name = {
    Text = "무결의 은빛"
  },
  Skill_90566_Desc = {
    Text = "「제령나이트 칵테일」 추가: 임시 힘 [Arg1]pt와 임시 경계 [Arg2]pt를 획득한다."
  },
  Skill_90566_Name = {
    Text = "무성한 초록"
  },
  Skill_90567_Desc = {
    Text = "「제령나이트 칵테일」 추가: 모든 깨어남체가 광기를 [Arg1]pt 획득한다."
  },
  Skill_90567_Name = {
    Text = "벌꿀 황금"
  },
  Skill_90568_Desc = {
    Text = "모든 깨어남체의 치명타율과 치명타 피해가 임시로 [Arg1]% 증가한다."
  },
  Skill_90568_Name = {
    Text = "영혼 제례 특제"
  },
  Skill_90569_Desc = {
    Text = "「제령나이트 칵테일」 추가: 「영감」 1장을 손에 넣는다."
  },
  Skill_90569_Name = {
    Text = "영감의 파랑"
  },
  Skill_90570_Desc = {
    Text = "「제령나이트 칵테일」 추가: HP를 [Arg1]pt 회복한다."
  },
  Skill_90570_Name = {
    Text = "피의 빨강"
  },
  Skill_91158_BattleDesc = {
    Text = "자신의 <BleedingIconKeywords:출혈>을 제거하고, 잃은 HP의 30%에 해당하는 실타래드([Arg1])를 획득하며, 카드 2장을 드로우한다."
  },
  Skill_91158_Desc = {
    Text = "자신의 <BleedingIconKeywords:출혈>을 제거하고, 잃은 HP의 30%에 해당하는 실타래드를 획득하며, 카드 2장을 드로우한다."
  },
  Skill_91158_Name = {
    Text = "자손의 축복"
  },
  Skill_91159_BattleDesc = {
    Text = "임시 <Kuangre:광란> 4스택과 행동력 2pt를 획득한다."
  },
  Skill_91159_Desc = {
    Text = "임시 광란 4스택과 행동력 2pt를 획득한다."
  },
  Skill_91159_Name = {
    Text = "자손의 격려"
  },
  Skill_91218_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_91218_Name_1 = {
    Text = "영혼 포식"
  },
  Skill_91219_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_91219_Name_1 = {
    Text = "생령의 향연"
  },
  Skill_91220_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_91220_Name_1 = {Text = "타격"},
  Skill_91221_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>의 광기를 획득한다."
  },
  Skill_91221_Name_1 = {
    Text = "환희의 만찬"
  },
  Skill_91222_Desc_1 = {
    Text = "아군 한 명에게 [Arg1]스택 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  Skill_91222_Name_1 = {
    Text = "속삭임의 장막"
  },
  Skill_91512_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시와 턴 종료 시, 장착한 깨어남체가 후열 적에게 <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_91512_Name_1 = {Text = "개강일"},
  Skill_91513_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <PVPDerivativeCardKeywords_17:「영감」> [Arg1]장을 손에 넣는다."
  },
  Skill_91513_Name_1 = {
    Text = "파트너 특훈"
  },
  Skill_91741_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  Skill_91741_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  Skill_91741_Name = {Text = "타격"},
  Skill_91742_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <BlindingKeywords:실타래명>과 <WeaknessIconKeywords:허약>을 부여하며, <Guaiwuheiyu:검은 깃털> [Arg4]스택을 소모한다. 플레이어가 열쇠 지령을 발동하면, 즉시 의도가 낮은 피해의 「타격」으로 변경되고 <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  Skill_91742_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <BlindingKeywords:실타래명>과 <WeaknessIconKeywords:허약>을 부여하며, <Guaiwuheiyu:검은 깃털> [Arg4]스택을 소모한다. 플레이어가 열쇠 지령을 발동하면, 즉시 의도가 낮은 피해의 「타격」으로 변경되고 <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  Skill_91742_Name = {
    Text = "이중 깃털"
  },
  Skill_91743_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <BlindingKeywords:실타래명>과 <WeaknessIconKeywords:허약>을 부여하며, <Guaiwuheiyu:검은 깃털> [Arg4]스택을 소모한다. 플레이어가 열쇠 지령을 발동하면, 즉시 의도가 낮은 피해의 「타격」으로 변경되고 <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  Skill_91743_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <BlindingKeywords:실타래명>과 <WeaknessIconKeywords:허약>을 부여하며, <Guaiwuheiyu:검은 깃털> [Arg4]스택을 소모한다. 플레이어가 열쇠 지령을 발동하면, 즉시 의도가 낮은 피해의 「타격」으로 변경되고 <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  Skill_91743_Name = {
    Text = "검은 깃털"
  },
  Skill_91744_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Guaiwuheiyu:검은 깃털> 1스택당 최종 피해가 [Arg3]% 증가하며, <Guaiwuheiyu:검은 깃털> 스택을 절반 제거한다."
  },
  Skill_91744_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, <Guaiwuheiyu:검은 깃털> 1스택당 최종 피해가 [Arg3]% 증가하며, <Guaiwuheiyu:검은 깃털> 스택을 절반 제거한다."
  },
  Skill_91744_Name = {
    Text = "어둠의 비행"
  },
  Skill_91745_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <Guaiwuheiyu:검은 깃털> [Arg2]스택을 획득한다."
  },
  Skill_91745_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <Guaiwuheiyu:검은 깃털> [Arg2]스택을 획득한다."
  },
  Skill_91745_Name = {
    Text = "불굴의 고독한 새"
  },
  Skill_91746_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 검은 깃털 [Arg2]스택당 획득하는 실타래드가 [Arg3]% 증가하며, <PowerIconKeywords:힘> [Arg4]pt를 획득한다. <Guaiwuheiyu:검은 깃털> [Arg5]스택을 획득한다."
  },
  Skill_91746_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, <Guaiwuheiyu:검은 깃털> [Arg2]스택당 획득하는 실타래드가 [Arg3]% 증가하며, <PowerIconKeywords:힘> [Arg4]pt를 획득한다. <Guaiwuheiyu:검은 깃털> [Arg5]스택을 획득한다."
  },
  Skill_91746_Name = {
    Text = "암흑의 날개"
  },
  Skill_91747_BattleDesc = {
    Text = "파괴되지 않은 실타래드의 [Arg1]%가 다음 턴까지 유지되며, 턴 종료 시 <Guaiwuheiyu:검은 깃털> [Arg2]스택을 획득한다."
  },
  Skill_91747_Desc = {
    Text = "파괴되지 않은 실타래드의 [Arg1]%가 다음 턴까지 유지되며, 턴 종료 시 <Guaiwuheiyu:검은 깃털> [Arg2]스택을 획득한다."
  },
  Skill_91747_Name = {
    Text = "비상하는 숙원"
  },
  Skill_94508_Desc_1 = {
    Text = "[Arg1]% 확률로 아군 한 명에게 긍정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여하거나, 적 한 명에게 부정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 부여합니다. 부여할 때마다 확률이 절반으로 줄어들며, 이 효과를 무한 반복하고 부여에 실타래패하면 종료됩니다. <PVPPenetrateKeywords:관통 1>."
  },
  Skill_94508_Name_1 = {
    Text = "굶주린 결의"
  },
  Skill_94508_UnknownName = {
    Text = "굶주린 결의"
  },
  Skill_94560_Desc = {
    Text = "출전 깨어남체의 스킬 카드 중에서 <FaxianKeywords:발견>으로 3장을 확인하고, 1장을 선택하여 그 임시 복사본을 손에 넣으며, 그 카드의 행동력 소모를 1 감소시킨다. 현재 계역이 「혈육」일 경우, 「다 먹어치워!」를 선택할 수 있다."
  },
  Skill_94560_Name = {
    Text = "굶주린 결의"
  },
  Skill_94561_BattleDesc = {
    Text = "모든 적의 임시 <PowerIconKeywords:힘>을 [Arg2]pt 감소시키고, 적 1명당 임시 <PowerIconKeywords:힘>을 [Arg3]pt 획득한다. 도어세인이 팀에 있을 경우, 「잔해」 1개를 획득한다."
  },
  Skill_94561_Desc = {
    Text = "모든 적에게서 <PowerIconKeywords:힘> [Arg1]pt를 <TouquKeywords:탈취>한다. 도어세인이 파티에 있을 경우, 「잔해」 1개를 획득한다."
  },
  Skill_94561_Name = {
    Text = "잔혹한 인사"
  },
  Skill_94565_Desc = {
    Text = "모든 카드를 손에 넣지만, 행동력 소모는 감소하지 않는다."
  },
  Skill_94565_Name = {
    Text = "다 먹어치워!"
  },
  Skill_94683_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 1턴간 <WeaknessIconKeywords:허약>을 부여한다."
  },
  Skill_94683_Name = {Text = "찌르기"},
  Skill_94684_Desc = {
    Text = "<IntoxicationIconKeywords:중독> [Arg1]스택을 부여한다."
  },
  Skill_94684_Name = {Text = "저주"},
  Skill_94685_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_94686_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 자신이 사망한다."
  },
  Skill_94686_Name = {Text = "자폭"},
  Skill_94703_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 완전히 방어되지 않을 경우 <DerivativeCardKeywords_80:「질식」> 1장을 덱에 섞어 넣는다."
  },
  Skill_94703_Name = {
    Text = "바다의 제사"
  },
  Skill_94704_Desc = {
    Text = "1턴간 <WeaknessIconKeywords:허약>과 <FragileIconKeywords:손상>을 부여한다."
  },
  Skill_94704_Name = {Text = "오염"},
  Skill_94709_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_94709_Name = {
    Text = "시체 감염"
  },
  Skill_94711_Desc = {
    Text = "모든 아군이 구울이 잃은 HP의 10%를 회복하고, <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_94711_Name = {Text = "연회"},
  Skill_94722_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <IntoxicationIconKeywords:중독> [Arg2]pt를 부여하며, 전방에 「부패 분열체」 1개를 소환한다."
  },
  Skill_94722_Name = {
    Text = "무덤의 부름"
  },
  Skill_94723_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <IntoxicationIconKeywords:중독> [Arg2]pt를 부여하며, 「부패 분열체」 2개를 소환한다."
  },
  Skill_94723_Name = {
    Text = "보름달의 부름"
  },
  Skill_94725_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <HeavyInjuryKeywords:중상>을 [Arg2]턴간 부여한다."
  },
  Skill_94725_Name = {
    Text = "무덤 파기"
  },
  Skill_94726_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <HeavyInjuryKeywords:중상>을 [Arg2]턴간 부여한다."
  },
  Skill_94726_Name = {
    Text = "무덤 파기"
  },
  Skill_94731_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_94731_Name = {
    Text = "시체 감염"
  },
  Skill_94732_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <HeavyInjuryKeywords:중상>을 [Arg2]턴간 부여한다."
  },
  Skill_94732_Name = {
    Text = "묘비의 통곡"
  },
  Skill_94952_Desc = {
    Text = "<Guaiwusiwangdikang:죽음 저항> [Arg1]스택을 획득하고, 「심해 분열체」 2개를 소환한다."
  },
  Skill_94952_Name = {
    Text = "바다의 부름"
  },
  Skill_94953_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주고, 2턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_94953_Name = {
    Text = "찢는 발톱"
  },
  Skill_94954_Desc = {
    Text = "<Guaiwusiwangdikang:죽음 저항> [Arg1]스택, <PowerIconKeywords:힘> [Arg2]pt, <Kuangbao:광포> [Arg3]pt를 획득한다."
  },
  Skill_94954_Name = {
    Text = "불멸의 영혼"
  },
  Skill_94955_Desc = {
    Text = "<PowerIconKeywords:힘>을 [Arg1]pt 획득한다."
  },
  Skill_94955_Name = {
    Text = "굶주린 의지"
  },
  Skill_94956_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt와 <Kuangbao:광포> [Arg2]pt를 획득한다."
  },
  Skill_94956_Name = {
    Text = "굶주린 의지"
  },
  Skill_94957_Desc = {
    Text = "자신이 사망하여, 최대 HP가 가장 높은 아군에게 <PowerIconKeywords:힘> [Arg1]pt를 부여하고, 해당 아군의 최대 HP를 자신의 현재 HP의 2배만큼([Arg2]) 증가시킨다."
  },
  Skill_94957_Name = {
    Text = "포식당함"
  },
  Skill_94958_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 피해량의 [Arg2]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여하며, 대상의 <PowerIconKeywords:힘> [Arg3]%를 제거한다."
  },
  Skill_94958_Name = {
    Text = "영혼 침식"
  },
  Skill_94959_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 치명타 피해를 받을 때마다 공격 횟수가 1회 감소하며, 최대 3회까지 감소한다."
  },
  Skill_94959_Name = {
    Text = "하늘을 삼키는 파도"
  },
  Skill_94960_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <RetaliateIconKeywords:임시 반격> [Arg2]pt를 획득한다."
  },
  Skill_94960_Name = {
    Text = "골이 저리기"
  },
  Skill_94961_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 피해량의 [Arg2]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_94961_Name = {
    Text = "영혼 침식"
  },
  Skill_94962_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 치명타 피해를 받을 때마다 공격 횟수가 1회 감소하며, 최소 3회까지 감소한다."
  },
  Skill_94962_Name = {
    Text = "성난 바다"
  },
  Skill_94963_Desc = {
    Text = "<Guaiwusiwangdikang:죽음 저항> [Arg1]스택을 획득하고, [Arg2]턴간 부정 상태에 면역이 되며, 「심해 분열체」 2개를 소환한다."
  },
  Skill_94963_Name = {
    Text = "심해의 부름"
  },
  Skill_94964_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 주고, 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_94964_Name = {
    Text = "찢는 발톱"
  },
  Skill_94965_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_94965_Name = {
    Text = "영혼 포식"
  },
  Skill_94966_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입힌다."
  },
  Skill_94966_Name = {Text = "탐욕"},
  Skill_94967_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 피해량의 [Arg2]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여하며, 대상의 <PowerIconKeywords:힘> [Arg3]%를 제거한다."
  },
  Skill_94967_Name = {
    Text = "영혼 침식"
  },
  Skill_94968_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <RetaliateIconKeywords:임시 반격> [Arg2]pt와 <Baojidikang:임시 치명타 저항> [Arg3]%를 획득한다."
  },
  Skill_94968_Name = {
    Text = "골이 저리기"
  },
  Skill_95807_Desc = {
    Text = "[Arg1]pt의 피해를 입히고, <PowerIconKeywords:힘> [Arg2]배 보너스를 적용받는다."
  },
  Skill_95807_Name = {
    Text = "유골 제사"
  },
  Skill_95808_Desc = {
    Text = "모든 적이 임시 <PowerIconKeywords:힘> [Arg1]pt를 획득한다. 「장해지주」가 <Guaiwucanhai:잔해>의 절반을 잃는다."
  },
  Skill_95808_Name = {
    Text = "기습 비축"
  },
  Skill_95809_AwakerSkillBackgroundStory = {
    Text = "쉿... 구울의 왕은 무례한 손님을 환영하지 않습니다."
  },
  Skill_95809_BattleDesc = {
    Text = "실타래드를 <Block:[Block:Arg3]>pt 획득하고, 광기를 <Energy:[Energy:Arg4]>pt 획득한다."
  },
  Skill_95809_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 도어세인이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_95809_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_95809_Name = {Text = "방어"},
  Skill_95809_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_95810_Desc_1 = {
    Text = "아군 한 명을 선택해, 자신의 [Arg1]장과 서로 다른 <PVPVoidKeywords:공허>가 부여된 「스킬」을 획득하게 한다."
  },
  Skill_95810_Name_1 = {
    Text = "잔혹한 인사"
  },
  Skill_95810_UnknownName = {
    Text = "잔혹한 인사"
  },
  Skill_95811_AwakerSkillBackgroundStory = {
    Text = "초대장의 종이는 부드러운 피부에서 왔습니다. 초대장의 장식은 매끄러운 두개골에서 왔습니다. 초대장의 글자는 신선한 피에서 왔습니다. 초대장의 서명은 왕저택의 열정적인 주인에게서 왔습니다.\n두레세인은 당신에게 진심 어린 초대를 보냈습니다, 당신을 이 여러분의 연회에 초대합니다."
  },
  Skill_95811_Desc_0 = {
    Text = "도어세인이 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: [Power:Arg2] 점 <PowerIconKeywords:힘>을 획득하며, 도어세인이 입히는 피해가 [Arg3]% 힘 보너스를 추가로 받습니다. 도어세인이 매 턴 첫 번째로 처치를 달성한 후, 다른 적들에게 초과 피해의 50%에 해당하는 <FixedDamage:순수 피해>를 입힙니다."
  },
  Skill_95811_Desc_15 = {
    Text = "도어세인이 <Energy:[Energy:Arg1]> 점 광기를 획득합니다. <ExaltIconKeywords:영지 각성>: [Power:Arg2] 점 <PowerIconKeywords:힘>을 획득하며, 도어세인이 입히는 피해가 [Arg3]% 힘 보너스를 추가로 받습니다. 모든 적에게 현재 HP의 [Arg4]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다. 도어세인이 매 턴 첫 번째로 처치를 달성한 후, 다른 적들에게 초과 피해의 100%에 해당하는 <FixedDamage:순수 피해>를 입힙니다."
  },
  Skill_95811_EffectNameList = {
    Text = "광기, 힘"
  },
  Skill_95811_Name = {
    Text = "궁전의 초대장"
  },
  Skill_95811_PropertyNameList = {
    Text = "$GrowValue1, 공격력*GrowValue2"
  },
  Skill_95812_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 장비 시 <StrongEffectKeywords:증폭 효과>를 [Arg1] 획득한다. 적 처치 시 넘치는 피해는 후방의 깨어남체에게 전달된다."
  },
  Skill_95812_Name_1 = {
    Text = "안식의 입맞춤"
  },
  Skill_95813_AwakerSkillBackgroundStory = {
    Text = "화려한 연회에는 춤이 빠질 수 없습니다."
  },
  Skill_95813_BattleDesc = {
    Text = "<Damage:[Damage:Arg3]>pt의 피해를 입히고, <Energy:[Energy:Arg4]>pt의 광기를 획득한다."
  },
  Skill_95813_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 도어세인이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_95813_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_95813_Name = {Text = "타격"},
  Skill_95813_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_95814_AwakerSkillBackgroundStory = {
    Text = "어둠 속에서, 두레세인은 다시 눈을 떴다.\n슬픔도 증오도 없었다. 그는 기대에 가득 차서, 인간으로서의 육체를 향유했다.\n그는 처음부터 자신의 길이 어디로 이어질 것인지 알고 있었다."
  },
  Skill_95814_BattleDesc = {
    Text = "현재 HP의 10%([Arg2])를 잃고, 전체 적에게 <Damage:[Damage:Arg3]>pt의 피해를 주며 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_95814_Desc = {
    Text = "현재 HP의 10%를 잃고, 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 주며 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  Skill_95814_EffectNameList = {Text = "피해"},
  Skill_95814_Name = {
    Text = "저승의 길"
  },
  Skill_95814_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_95815_Desc = {
    Text = "[Arg1] 층<Guaiwusiwangdikang:죽음 저항>과 [Arg2] 층<Guaiwucanhai:잔해>를 얻으며, 「부식시체 분식체」와 「식시귀 시종」을 소환합니다."
  },
  Skill_95815_Name = {
    Text = "궁전의 초대장"
  },
  Skill_95816_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 주고 [AttackTimes:Arg2] 회, 무작위로「<Dongjie:냉동>」 [Arg3] 장의 뽑기 덱 카드입니다."
  },
  Skill_95816_Name = {
    Text = "저승의 길"
  },
  Skill_95817_AwakerSkillBackgroundStory = {
    Text = "음식 자체를 제외하고, 식사 방식 역시 미식 예술의 중요한 요소이다.\n적의 시체로 만든 식탁칼이 적의 혼 깊숙이 찔러 들어간다.\n모든 요리는 정성스럽게 준비된 재회를 의미한다."
  },
  Skill_95817_BattleDesc = {
    Text = "HP가 가장 낮은 적에게 <Damage:[Damage:Arg4]>pt의 피해를 입히고, [Arg2]%의 힘 보너스가 적용되며, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_95817_Desc = {
    Text = "HP가 가장 낮은 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, [Arg2]%의 힘 보너스가 적용되며, <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_95817_EffectNameList = {
    Text = "피해, 힘"
  },
  Skill_95817_Name = {
    Text = "유골 제사"
  },
  Skill_95817_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_95818_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히며, 적의 HP가 낮을수록 피해가 증가하며 최대 피해 <Damage:[Damage:Arg2]>pt까지 증가한다. 다른 모든 구울을 흡수하며, 1명을 흡수할 때마다 <Guaiwucanhai:잔해> [Arg3]개와 <Guaiwusiwangdikang:죽음 저항> [Arg4]스택을 획득한다."
  },
  Skill_95818_Name = {
    Text = "영혼의 향연"
  },
  Skill_95819_BattleDesc = {
    Text = "모든 「포만감」을 제거하고, 모든 손패를 버린다. <DerivativeCardKeywords_111:「영혼 포식」>을 통해 제거된 카드들을 손에 넣고, 해당 카드들의 행동력 소모를 0으로 만든다. 턴 종료 시 손에 있을 경우: 무작위로 제거된 카드의 복사본 1장을 손에 넣고, 그 카드의 행동력 소모를 0으로 만들며, 소모와 허무를 부여한다."
  },
  Skill_95819_Desc = {
    Text = "모든 「포만감」을 제거하고, 모든 손패를 버린다. <DerivativeCardKeywords_111:「영혼 포식」>을 통해 제거된 카드들을 손에 넣고, 해당 카드들의 행동력 소모를 0으로 만든다. 턴 종료 시 손에 있을 경우: 무작위로 제거된 카드의 복사본 1장을 손에 넣고, 그 카드의 행동력 소모를 0으로 만들며, 소모와 허무를 부여한다."
  },
  Skill_95819_Name = {
    Text = "기억 공명"
  },
  Skill_95820_AwakerSkillBackgroundStory = {
    Text = "너의 가면을 찢어라. 너의 편견을 내려놓아라. 춤추는 공간에 발을 들여놓고, 오랫동안 잠들어 있던 춤 파트너를 안아라.\n그것은 얼마나 오랫동안 이 아름다운 달빛을 보지 못했을까? 그것은 얼마나 오랫동안 부드러운 사랑의 속삭임을 듣지 못했을까?\n들어봐, 그것은 너를 갈망하고 있어, 마치 너가 그것을 갈망하는 것처럼.\n물고, 포식하라. 이 비할 데 없는 성연 속에서 생명체와 죽은 자는 그들의 공동의 승화를 완성한다."
  },
  Skill_95820_BattleDesc_0 = {
    Text = "[<DevouredIconKeywords:포식> :<DerivativeCardKeywords_110:>이번 광기 폭발 크리티컬 확률+[Arg2]%, [Power:Arg1] 점 <PowerIconKeywords:힘> 획득.]HP가 가장 낮은 적에게 <Damage:[Damage:Arg3]> 점 데미지를 가하며, [Arg4]% 힘 보너스를 적용하고, 대상이 HP를 1% 잃을 때마다 이번 광기 폭발의 최종 피해가 3% 증가함. 현재 <CarcassKeywords:잔해> 3개를 보유 중이라면 이를 섭취하여 <Heal:[Heal:Arg5]> 점 HP를 회복하고 이번 광기 폭발에 적용되는 크리티컬 피해 보너스를 2배로 만듦(현재 <CarcassKeywords:잔해> [Arg6]/3개 보유 중)."
  },
  Skill_95820_BattleDesc_3 = {
    Text = "[<DevouredIconKeywords:포식> :<DerivativeCardKeywords_114:>이번 광기 폭발 크리티컬 확률+[Arg2]%, [Power:Arg1] 점 <PowerIconKeywords:힘> 획득.]HP가 가장 낮은 적에게 <Damage:[Damage:Arg3]> 점 데미지를 가하며, [Arg4]% 힘 보너스를 적용하고, 대상이 HP를 1% 잃을 때마다 이번 광기 폭발의 최종 피해가 3% 증가합니다. 현재 <CarcassKeywords:잔해> 3개를 보유 중이라면 이를 섭취하여 <Heal:[Heal:Arg5]> 점 HP를 회복하고 이번 광기 폭발에 적용되는 크리티컬 피해 데미지 보너스를 2배로 만듭니다(현재 <CarcassKeywords:잔해> [Arg6]/3개 보유 중)."
  },
  Skill_95820_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식> :<DerivativeCardKeywords_110:>이번 광기 폭발 크리티컬 확률+[Arg2]%, [Power:Arg1] 점 <PowerIconKeywords:힘> 획득.]HP가 가장 낮은 적에게 <Damage:[Damage:Arg3]> 점 데미지를 가하며, [Arg4]% 힘 보너스를 적용하고, 대상이 HP를 1% 잃을 때마다 이번 광기 폭발의 최종 피해가 3% 증가합니다. 현재 <CarcassKeywords:잔해> 3개를 보유 중이라면 이를 섭취하여 <Heal:[Heal:Arg5]> 점 HP를 회복하고 이번 광기 폭발에 적용되는 크리티컬 피해 데미지 보너스를 2배로 만듭니다."
  },
  Skill_95820_Desc_3 = {
    Text = "[<DevouredIconKeywords:포식> :<DerivativeCardKeywords_114:>이번 광기 폭발 크리티컬 확률+[Arg2]%, [Power:Arg1] 포인트 <PowerIconKeywords:힘> 획득.]HP가 가장 낮은 적에게 <Damage:[Damage:Arg3]> 포인트 데미지를 가하며, [Arg4]% 힘 보너스를 적용하고, 대상이 HP를 1% 잃을 때마다 이번 광기 폭발의 최종 피해가 3% 증가합니다. 현재 <CarcassKeywords:잔해> 3개를 보유 중이라면 이를 섭취하여 <Heal:[Heal:Arg5]> 포인트 HP를 회복하고 이번 광기 폭발에 적용되는 크리티컬 피해 보너스를 두 배로 만듭니다."
  },
  Skill_95820_EffectNameList = {
    Text = "힘, 피해, 회복"
  },
  Skill_95820_Name = {
    Text = "생령의 성찬"
  },
  Skill_95820_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:포식> :<DerivativeCardKeywords_114:>이번 광기 폭발 치명타 확률+[Arg2]%, [Power:Arg1] 포인트의 <PowerIconKeywords:힘> 획득.]이번 광기 폭발의 치명타 확률+ 25%, 기초 피해 50% 증가. 생명력이 가장 낮은 적에게 <Damage:[Damage:Arg7]> 포인트의 피해를 입히며, [Arg4]% 힘 보너스를 적용하고, 이번 광기 폭발로 가하는 최종 피해 100% 증가, 대상이 1% 생명력을 잃을 때마다 추가로 3% 증가. 현재 「잔해」를 3구 보유 중이면 이를 먹어 <Heal:[Heal:Arg5]> 포인트의 생명력을 회복하고 이번 광기 폭발에 적용되는 치명타 피해 보너스를 2배로 증가시킴(현재 [Arg6]/3구의 잔해 보유 중)."
  },
  Skill_95820_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2, 체질*GrowValue3"
  },
  Skill_95821_Desc = {
    Text = "<Guaiwucanhai:잔해> ([Arg3])의 절반을 소모하며, 1스택을 소모할 때마다 <PowerIconKeywords:힘> [Arg1]pt를 획득하고 최대 HP가 [Arg2]% 증가한다. 「부패 분열체」와 「구울 시종」을 소환한다."
  },
  Skill_95821_Name = {
    Text = "유해 수집"
  },
  Skill_95822_Desc = {
    Text = "전략 1개를 선택한다. 「장해지주」가 「잔해 수취」를 발동할 때마다 이 카드를 손에 넣는다."
  },
  Skill_95822_Name = {
    Text = "전략 수립"
  },
  Skill_95823_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt를 획득하고, <Guaiwucanhai:잔해> ([Arg3])의 절반을 소모하며, 1스택을 소모할 때마다 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_95823_Name = {
    Text = "유해 수집"
  },
  Skill_95824_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 [Arg1]장의 카드를 뽑으며, 자신의 「스킬」을 우선적으로 뽑고, 그 스킬의 행동력 소모를 [Arg2] 감소시킨다."
  },
  Skill_95824_Name_1 = {Text = "진미"},
  Skill_95825_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히며, 적의 HP가 낮을수록 피해가 증가하며 최대 피해 <Damage:[Damage:Arg2]>pt까지 증가한다. 턴 종료 시 다른 모든 구울을 흡수하며, 1명을 흡수할 때마다 <Guaiwucanhai:잔해> [Arg3]개를 획득한다."
  },
  Skill_95825_Name = {
    Text = "생령의 향연"
  },
  Skill_95826_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <PowerIconKeywords:힘> [Arg2]배 보너스를 적용받는다."
  },
  Skill_95826_Name = {
    Text = "유골 제사"
  },
  Skill_95827_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 덱의 카드 중 무작위 [Arg3]장을 「동결」한다."
  },
  Skill_95827_Name = {
    Text = "저승의 길"
  },
  Skill_95828_BattleDesc = {
    Text = "아군 깨어남체 1명을 선택하여, 손에 있는 해당 깨어남체의 모든 카드를 제거하고, 제거한 카드 1장당 「포만감」 1스택을 획득하며, 다른 깨어남체가 광기를 <Energy:5>pt 획득한다."
  },
  Skill_95828_Desc = {
    Text = "아군 깨어남체 1명을 선택하여, 손에 있는 해당 깨어남체의 모든 카드를 제거하고, 제거한 카드 1장당 「포만감」 1스택을 획득하며, 다른 깨어남체가 광기를 <Energy:5>pt 획득한다."
  },
  Skill_95828_Name = {
    Text = "영혼의 포식"
  },
  Skill_95829_Desc = {
    Text = "모든 적이 주는 피해가 임시로 30% 감소한다."
  },
  Skill_95829_Name = {
    Text = "정면 교란"
  },
  Skill_95986_Desc = {
    Text = "이중 치명타 100"
  },
  Skill_95986_Name = {
    Text = "100 이중 치명타"
  },
  Skill_95988_Desc = {Text = "힘 1000"},
  Skill_95988_Name = {Text = "1000 힘"},
  Skill_95989_Desc = {
    Text = "100 증폭 효과"
  },
  Skill_95989_Name = {
    Text = "100 증폭 효과"
  },
  Skill_95990_Desc = {Text = "힘 500"},
  Skill_95990_Name = {Text = "500 힘"},
  Skill_96018_Desc = {
    Text = "이번 전투에서 주는 최종 피해가 25% 증가하고, 모든 깨어남체가 광기 30pt를 획득한다. 모든 카드의 「<Kuangluan:도해자 광란>」 상태를 제거하고, 손의 최대 2장의 증상을 소모한 후 그 수만큼 카드를 드로우한다."
  },
  Skill_96018_Name = {
    Text = "부서진 인장"
  },
  Skill_96019_Desc = {
    Text = "이번 전투에서 주는 최종 피해가 50% 증가하고, 모든 깨어남체가 광기 50pt를 획득한다. 모든 카드의 「<Kuangluan:도해자 광란>」 상태를 제거하고, 손의 최대 3장의 증상을 소모한 후 그 수만큼 카드를 드로우한다."
  },
  Skill_96019_Name = {
    Text = "손상된 인장"
  },
  Skill_96022_Desc = {
    Text = "이번 전투에서 주는 최종 피해가 100% 증가하고, 모든 깨어남체가 광기 100pt를 획득한다. 모든 카드의 「<Kuangluan:도해자 광란>」 상태를 제거하고, 손의 모든 증상을 소모한 후 그 수만큼 카드를 드로우한다."
  },
  Skill_96022_Name = {
    Text = "완벽한 인장"
  },
  Skill_96188_BattleDesc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg2]>의 <PunctureDamagewords:관통 피해>를 준다."
  },
  Skill_96188_BattleDesc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg2]>의 <PunctureDamagewords:관통 피해>를 준다. 사용 후 이번 턴에 이후 사용하는 「영원한 밤의 향연」의 힘 보너스가 100% 추가로 적용된다."
  },
  Skill_96188_Desc_0 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다."
  },
  Skill_96188_Desc_3 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 사용 후 이번 턴에 이후 사용하는 「영원한 밤의 향연」의 힘 보너스가 100% 추가로 적용된다."
  },
  Skill_96188_Name = {
    Text = "영야의 향연"
  },
  Skill_96325_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <FragileIconKeywords:취약>을 부여하고, 드로우 더미의 무작위 카드 4장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_96326_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. <PowerIconKeywords:힘> [Arg3]을 획득하고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_96327_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. 드로우 더미의 무작위 카드 3장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_96328_Desc = {
    Text = "<Damage:[Damage:Arg1]> 피해를 [AttackTimes:Arg2]회 입힙니다. [Arg3] 턴 <BlindingKeywords:실타래명>을 부여하고, 드로우 더미의 무작위 카드 1장에 <ColorInkKeywords:인지 부조화>를 부여합니다."
  },
  Skill_96342_Desc = {
    Text = "<Baojidikang:치명타 저항> [Arg1]%와 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_96342_Name = {Text = "서약"},
  Skill_96343_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, [Arg3]턴간 <HeavyInjuryKeywords:중상>을 부여하며, 적의 HP가 낮을수록 피해가 증가하여 최대 피해 <Damage:[Damage:Arg4]>pt까지 증가한다."
  },
  Skill_96343_Name = {
    Text = "뼈를 찢는 칼날"
  },
  Skill_96344_Desc = {
    Text = "<Damage:[Damage:Arg1]> 점 피해를 [AttackTimes:Arg2] 회 발생시킵니다. 「<Dongjie:동결>」[Arg3] 장 드로우 덱의 상단 카드가 동결됩니다."
  },
  Skill_96344_Name = {
    Text = "영혼 봉인"
  },
  Skill_96345_Desc = {
    Text = "<PowerIconKeywords:힘> [Arg1]pt, <Baojidikang:치명타 저항> [Arg2]%, <Fennu:분노> [Arg3]스택을 획득한다."
  },
  Skill_96345_Name = {Text = "집착"},
  Skill_96590_Desc = {
    Text = "「제령나이트 칵테일」 추가: 모든 깨어남체가 광기를 [Arg1]pt 획득한다."
  },
  Skill_96590_Name = {
    Text = "벌꿀 황금"
  },
  Skill_96591_Desc = {
    Text = "「제령나이트 칵테일」 추가: 열쇠 에너지를 [Arg1]pt 획득한다."
  },
  Skill_96591_Name = {
    Text = "무결의 은빛"
  },
  Skill_96592_Desc = {
    Text = "「제령나이트 칵테일」 추가: HP를 [Arg1]pt 회복한다."
  },
  Skill_96592_Name = {
    Text = "피의 빨강"
  },
  Skill_96593_Desc = {
    Text = "「제령나이트 칵테일」 추가: 「영감」 1장을 손에 넣는다."
  },
  Skill_96593_Name = {
    Text = "영감의 파랑"
  },
  Skill_96594_Desc = {
    Text = "「제령나이트 칵테일」 추가: 임시 힘 [Arg1]pt와 임시 경계 [Arg2]pt를 획득한다."
  },
  Skill_96594_Name = {
    Text = "무성한 초록"
  },
  Skill_96734_BattleDesc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg2]> 피해를 입히고, 행동력 1점을 소비할 때마다 피해가 [Arg3] 증가한다."
  },
  Skill_96734_Desc_1 = {
    Text = "<HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:Arg1]> 피해를 입히고, 행동력 1점을 소비할 때마다 피해가 [Arg3] 증가한다."
  },
  Skill_96734_Name_1 = {
    Text = "죽음의 마탄"
  },
  Skill_96735_BattleDesc_1 = {
    Text = "합계 <Damage:[Damage:Arg1]> 피해를 가하고, 모든 적에게 균등 분배하여 각 적에게 <Damage:[Damage:Arg2]> 피해를 가합니다."
  },
  Skill_96735_Desc_1 = {
    Text = "모든 적에게 총 <Damage:[Damage:Arg1]>의 피해를 균등하게 분배하여 준다."
  },
  Skill_96735_Name_1 = {
    Text = "세계를 태우는 지옥불"
  },
  Skill_96736_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 광기를 획득하고, <StrongEffectKeywords:강효> +[Arg2]."
  },
  Skill_96736_Name_1 = {
    Text = "폭발하는 불"
  },
  Skill_96737_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_96737_Name_1 = {Text = "타격"},
  Skill_96738_Desc_1 = {
    Text = "전체 적에게 <DelayKeywords:지연>을 부여합니다: <PVPWeaknessesKeywords:약점>."
  },
  Skill_96738_Name_1 = {
    Text = "만물의 종언"
  },
  Skill_96755_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량의 50%에 해당하는 <BleedingIconKeywords:출혈>을 부여하며, 「<Chaos:혼란>」 1스택당 공격 횟수가 1회 감소한다."
  },
  Skill_96755_Name = {
    Text = "격류의 칼날"
  },
  Skill_96756_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 적의 HP가 낮을수록 피해가 증가하며, 「<Daohaizheyishi:도해자의 제의>」 1스택을 부여한다."
  },
  Skill_96756_Name = {
    Text = "도해자의 심판"
  },
  Skill_96757_Desc = {
    Text = "<Damage:[Damage:Arg1]>만큼 피해를 입히고 [AttackTimes:Arg2]회 공격하며, 적의 생명력이 낮을수록 피해가 더 높아지고, 3장의 카드에「<Kuangluan:도해자광란>」이 추가됩니다."
  },
  Skill_96757_Name = {
    Text = "도해자의 저주"
  },
  Skill_96758_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 「변이」 [Arg3]장을 덱에 섞어 넣으며, 「<Chaos:혼란>」 1스택당 섞는 장수가 1장 감소한다."
  },
  Skill_96758_Name = {
    Text = "심연의 폭발"
  },
  Skill_96759_Desc = {
    Text = "자신의 최대 HP를 [Arg1]% 증가시키고, 추가로 [Arg2]회의 생명을 획득하며, <RetaliateIconKeywords:반격> [Arg3]pt, <Duren:독날> [Arg4]pt, <Baojidikang:치명타 저항> [Arg5]%를 획득한다."
  },
  Skill_96759_Name = {
    Text = "피와 뼈의 재구축"
  },
  Skill_96760_Desc = {
    Text = "<Damage:[Damage:Arg1]>만큼 피해를 입히고 [AttackTimes:Arg2]회 공격하며, [Arg3]점의 <PowerIconKeywords:힘>을 얻습니다. 각 단계의「<Chaos:혼란>」은 획득하는 힘을 [Arg4]점 줄입니다."
  },
  Skill_96760_Name = {
    Text = "용솟음치는 급류"
  },
  Skill_96761_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 무작위 「증상」 [Arg3]장을 덱에 섞어 넣으며, 「<Chaos:혼란>」 1스택당 섞는 장수가 1장 감소한다."
  },
  Skill_96761_Name = {
    Text = "시체 무리 폭발"
  },
  Skill_96762_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 방어되지 않은 피해량의 50%에 해당하는 <BleedingIconKeywords:출혈>을 부여하며, 「<Chaos:혼란>」 1스택당 공격 횟수가 1회 감소한다."
  },
  Skill_96762_Name = {
    Text = "해골 칼날"
  },
  Skill_96787_Desc = {
    Text = "두레인에 의해 펼쳐진 아직 완료되지 않은 마법진은 당신에게 일정한 보호를 제공할 수 있지만, 방어되지 않은 피해는 마법진에 동일하게 전달되며, HP를 회복할 때 완전도의 33%를 회복한다. 영구 유지. 현재 완전도: [Arg2]/[Arg3] ([Arg1]%). 「명몽의 장막」 완료 턴 수: [Arg4]/3."
  },
  Skill_96787_Name = {
    Text = "속삭임의 장막"
  },
  Skill_97107_Desc_1 = {
    Text = "<DelayKeywords:지연>: [Arg1] 점의 무시 상한의 컴퓨팅 파워를 얻습니다."
  },
  Skill_97107_Name_1 = {
    Text = "지지 않는 태양"
  },
  Skill_97107_UnknownName = {
    Text = "지지 않는 태양"
  },
  Skill_97108_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」으로 [Arg1]의 행동력을 획득하며, 「스킬」의 피해가 [Arg2]% 증가한다."
  },
  Skill_97108_Name_1 = {
    Text = "다가오는 태양"
  },
  Skill_97109_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 소모하는 행동력 1당 데미지량 증가 [Arg1]%. 처치 후 「광기 폭발」 데미지량 증가 [Arg2]%."
  },
  Skill_97109_Name_1 = {
    Text = "호박색 죽음"
  },
  Skill_97159_Desc = {
    Text = "자신이 사망하여, 최대 HP가 가장 높은 아군에게 <PowerIconKeywords:힘> [Arg1]pt를 부여하고, 해당 아군의 최대 HP를 자신의 현재 HP의 2배만큼([Arg2]) 증가시킨다."
  },
  Skill_97159_Name = {
    Text = "포식당함"
  },
  Skill_97318_Desc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다."
  },
  Skill_97318_Name = {
    Text = "영야의 향연"
  },
  Skill_97319_Desc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 <PunctureDamagewords:관통 피해>를 준다. 사용 후 이번 턴에 이후 사용하는 「영원한 밤의 향연」의 힘 보너스가 100% 추가로 적용된다."
  },
  Skill_97319_Name = {
    Text = "영야의 향연"
  },
  Skill_97911_AwakerSkillBackgroundStory = {
    Text = "그녀는 너무나도 무심하게 총을 쏘며, 탄약이 맞을 지 신경도 쓰지 않습니다.\n「사냥이 시작된다, 먼저 몸을 풀어보자.」"
  },
  Skill_97911_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_97911_Desc = {
    Text = "피해를 <Damage:[Damage:Arg1]>pt 입히고, 카티구라가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_97911_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_97911_Name = {Text = "타격"},
  Skill_97911_PropertyNameList = {
    Text = "ATK*GrowValue1,$GrowValue2"
  },
  Skill_97912_AwakerSkillBackgroundStory = {
    Text = "불과 빛이 세계를 대체하며, 당신의 눈에는 끝없는 빛만 남습니다. 당신은 사고할 수 없고, 이해할 수 없으며, 왜 세계가 사라졌는지 알지 못합니다. 모든 것이 허무로 증발하는 마지막 순간, 당신은 그것이 태양 폭발 시 가장 빛나는 색깔이라는 것을 깨닫습니다."
  },
  Skill_97912_BattleDesc_0 = {
    Text = "<DerivativeCardKeywords_117:> 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 [Arg2]%의 힘 보너스가 적용된다."
  },
  Skill_97912_BattleDesc_2 = {
    Text = "<DerivativeCardKeywords_117:> 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 [Arg2]%의 힘 보너스가 적용된다. 이 카드가 <HuoyanKeywords4:활염> 3스택을 보유하고 있다면, 기본 피해가 50% 증가한다."
  },
  Skill_97912_Desc_0 = {
    Text = "<DerivativeCardKeywords_117:> 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 [Arg2]%의 힘 보너스가 적용된다."
  },
  Skill_97912_Desc_2 = {
    Text = "<DerivativeCardKeywords_117:> 전체 적에게 <Damage:[Damage:Arg1]>pt의 피해를 입히고, 이 피해에는 [Arg2]%의 힘 보너스가 적용된다. 이 카드가 <HuoyanKeywords:활염> 3스택을 보유하고 있다면, 기본 피해가 50% 증가한다."
  },
  Skill_97912_EffectNameList = {Text = "피해"},
  Skill_97912_Name = {
    Text = "테라 플레어"
  },
  Skill_97912_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_97913_AwakerSkillBackgroundStory = {
    Text = "이는 종말의 예고로, 죽음의 끝을 맞이하게 한다. 네가 죽음의 초대를 거절할 수 있지만, 그 후 너는 세상에서 가장 찬란한 빛을 볼 것이다."
  },
  Skill_97913_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_97913_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, <PowerIconKeywords:힘>을 [Power:Arg4]pt 획득한다. 이 카드가 <HuoyanKeywords4:활염> 3스택을 보유하고 있다면, 추가로 <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_97913_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, <PowerIconKeywords:힘>을 [Power:Arg2]pt 획득한다."
  },
  Skill_97913_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 2회 입히고, <PowerIconKeywords:힘>을 [Power:Arg4]pt 획득한다. 이 카드가 <HuoyanKeywords:활염> 3스택을 보유하고 있다면, 추가로 <PowerIconKeywords:힘>을 [Power:Arg3]pt 획득한다."
  },
  Skill_97913_EffectNameList = {
    Text = "피해, 힘"
  },
  Skill_97913_Name = {
    Text = "마지막 총성"
  },
  Skill_97913_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_97914_AwakerSkillBackgroundStory = {
    Text = "탄약, 칼과 검, 사악한 마법…… 어느 곳에서 시작된 공격이든, 오기 전에 그것의 매개체를 태워버리면 최고의 방어입니다."
  },
  Skill_97914_BattleDesc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_97914_Desc = {
    Text = "방어막을 <Block:[Block:Arg1]>pt 획득하고, 카티구라가 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_97914_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_97914_Name = {Text = "방어"},
  Skill_97914_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_97915_AwakerSkillBackgroundStory = {
    Text = "타오르는 불꽃이 다시 피어올랐고, 온 몸을 덮고 있던 흉터가 눈부신 흰 빛으로 반짝이기 시작했다.\n「이제는 놀 시간이 끝났어. 두 번째 라운드를 시작할 때야.」"
  },
  Skill_97915_BattleDesc_0 = {
    Text = "케티구라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시 손에 있는 케티구라의 명령 카드 1장에 추가로 <HuoyanKeywords4:활염> 1스택을 부여한다. <HuoyanKeywords4:활염> 3스택이 부여된 명령 카드를 사용한 후 해당 카드를 손으로 되돌린다."
  },
  Skill_97915_BattleDesc_15 = {
    Text = "케티구라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시 손에 있는 케티구라의 명령 카드 1장에 추가로 <HuoyanKeywords4:활염> 1스택을 부여한다. <HuoyanKeywords4:활염> 3스택이 부여된 명령 카드를 사용한 후 해당 카드를 손으로 되돌린다. 케티구라의 「활염」 1스택당 최종 피해 및 힘 효과가 30% 증가한다."
  },
  Skill_97915_Desc_0 = {
    Text = "케티구라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시 손에 있는 케티구라의 명령 카드 1장에 추가로 <HuoyanKeywords:활염> 1스택을 부여한다. <HuoyanKeywords:활염> 3스택이 부여된 명령 카드를 사용한 후 해당 카드를 손으로 되돌린다."
  },
  Skill_97915_Desc_15 = {
    Text = "케티구라가 <Energy:[Energy:Arg1]>의 광기를 획득한다. <ExaltIconKeywords:영지 깨어남>: 턴 시작 시 손에 있는 케티구라의 명령 카드 1장에 추가로 <HuoyanKeywords:활염> 1스택을 부여한다. <HuoyanKeywords:활염> 3스택이 부여된 명령 카드를 사용한 후 해당 카드를 손으로 되돌린다. 케티구라의 「활염」 1스택당 최종 피해 및 힘 효과가 30% 증가한다."
  },
  Skill_97915_EffectNameList = {Text = "광기"},
  Skill_97915_Name = {
    Text = "다시 타오르는 업화"
  },
  Skill_97916_BattleDesc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 준다. 행동력 1pt를 소모할 때마다 힘 보너스가 150% 추가로 적용된다. 모든 「폭염」을 소모하며, 소모한 「폭염」 1스택당 힘 보너스가 50% 추가로 적용된다(현재 총 힘 보너스: [Arg2]%). 사용 후, 모든 「엑사 플레어」를 「페타 플레어」로 되돌린다."
  },
  Skill_97916_Desc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 준다. 행동력 1pt를 소모할 때마다 힘 보너스가 150% 추가로 적용된다. 모든 「폭염」을 소모하며, 소모한 「폭염」 1스택당 힘 보너스가 50% 추가로 적용된다. 사용 후, 모든 「엑사 플레어」를 「페타 플레어」로 되돌린다."
  },
  Skill_97916_EffectNameList = {Text = "피해"},
  Skill_97916_Name = {
    Text = "엑사 플레어"
  },
  Skill_97916_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_97917_Desc = {
    Text = "행동력 1pt를 획득하고, 임시 <StrongEffectKeywords:증폭 효과> [Arg1]%를 획득한다. 카티구라가 파티에 있을 경우, 카티구라의 명령 카드 1장을 드로우하고 해당 카드에 「<HuoyanKeywords:활염>」 1스택을 부여한다."
  },
  Skill_97917_Name = {
    Text = "지지 않는 태양"
  },
  Skill_97918_AwakerSkillBackgroundStory = {
    Text = "그의 사자들이 줄지어 나와, 호박색 불꽃을 휘두르며 춤추고 있다. 이것이 그의 힘, 그의 의지, 그의 권한, 그의 불로 세상을 덮고 세상을 태워버릴 것이다."
  },
  Skill_97918_BattleDesc = {
    Text = "전체 적에게 <PunctureDamagewords:관통 피해>를 <Damage:[Damage:Arg1]>pt 입히고, 해당 피해에 [Arg2]%의 힘 보너스가 적용된다. 카티구라의 「명령 카드」 2장을 드로우하고, 손에 있는 카티구라의 「명령 카드」 3장에 <HuoyanKeywords4:활염> 1스택을 부여한다."
  },
  Skill_97918_Desc = {
    Text = "전체 적에게 <PunctureDamagewords:관통 피해>를 <Damage:[Damage:Arg1]>pt 입히고, 해당 피해에 [Arg2]%의 힘 보너스가 적용된다. 카티구라의 「명령 카드」 2장을 드로우하고, 손에 있는 카티구라의 「명령 카드」 3장에 <HuoyanKeywords:활염> 1스택을 부여한다."
  },
  Skill_97918_EffectNameList = {Text = "피해"},
  Skill_97918_Name = {
    Text = "세계를 태우는 지옥불"
  },
  Skill_97918_OverLimitUtlSkillDesc = {
    Text = "전체 적에게 <PunctureDamagewords:관통 피해>를 <Damage:[Damage:Arg1]>pt씩 3회 입히고, 해당 피해에 [Arg2]%의 힘 보너스가 적용된다. 카티구라의 「명령 카드」 2장을 드로우하고, 손에 있는 카티구라의 「명령 카드」에 <HuoyanKeywords4:활염> 5스택을 랜덤으로 부여한다."
  },
  Skill_97918_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_97919_BattleDesc = {
    Text = "깨어남체 1명을 선택하여, 행동력 소모가 0인 임시 「타격」 1장을 손에 넣는다. 3번째 발동 시마다, 「아름다운 순간」 1장을 손에 넣고, 모든 깨어남체의 임시 치명타율을 [Arg1]% 증가시킨다. (현재 [Arg2]회 발동됨)"
  },
  Skill_97919_Desc = {
    Text = "깨어남체 1명을 선택하여, 행동력 소모가 0인 임시 「타격」 1장을 손에 넣는다. 3번째 발동 시마다, 「아름다운 순간」 1장을 손에 넣고, 모든 깨어남체의 임시 치명타율을 [Arg1]% 증가시킨다."
  },
  Skill_97919_Name = {
    Text = "단꿈의 순간"
  },
  Skill_98057_Desc = {
    Text = "「진노」, 「졸음」 12스택을 획득한다. 촉수 피해가 [Arg1] 증가한다."
  },
  Skill_98057_Name = {
    Text = "불멸의 위엄"
  },
  Skill_98119_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [Arg2]회 입히고, <PowerIconKeywords:힘>을 [Arg3]pt 획득한다."
  },
  Skill_98119_Name = {
    Text = "마지막 총성"
  },
  Skill_98120_Desc = {
    Text = "해당 의도로 전환할 때 남은 모든 손패를 버리고 <BurningKeywords:연소>를 부여한다. 상대 턴 시작 시 무작위 손패 [Arg1]장에 <BurningKeywords:연소>를 부여한다."
  },
  Skill_98120_Name = {
    Text = "다시 타오르는 업화"
  },
  Skill_98121_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 주고, 덱 또는 버린 카드 더미의 무작위 카드 [Arg3]장을 <BurningKeywords:연소>시키며, <VulnerabilityIconKeywords:취약>을 [Arg4]스택 부여한다."
  },
  Skill_98121_Name = {
    Text = "페타 플레어"
  },
  Skill_98126_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 <PowerIconKeywords:힘>과 <ExhaustionIconKeywords:힘 감소>의 [Arg3]배 영향을 받는다. 모든 <MonsterExFlameKeywords:폭염>을 제거하고, 1스택당 <PowerIconKeywords:힘>이 [Arg4] 증가한다."
  },
  Skill_98126_Name = {
    Text = "엑사 플레어"
  },
  Skill_98127_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 상대의 남은 모든 손패를 <BurningKeywords:연소>시키며, 1장당 <MonsterExFlameKeywords:폭염> 1스택을 획득한다."
  },
  Skill_98127_Name = {
    Text = "세계를 태우는 지옥불"
  },
  Skill_98195_Desc_1 = {
    Text = "행동력 소모가 가장 낮은 「스킬」 2장을 드로우한다."
  },
  Skill_98195_Name_1 = {
    Text = "정지된 한여름의 기념"
  },
  Skill_98195_UnknownName = {
    Text = "정지된 한여름의 기념"
  },
  Skill_98313_Desc = {
    Text = "80스택 감소"
  },
  Skill_98313_Name = {
    Text = "80스택 감소"
  },
  Skill_98315_Desc = {
    Text = "죽음 저항 100"
  },
  Skill_98315_Name = {
    Text = "100 죽음 저항"
  },
  Skill_98317_Desc = {
    Text = "2종류의 서로 다른 「<PrimaryColor:원색>」을 기록하면 지속적인 버프 효과를 얻는다."
  },
  Skill_98317_Name = {
    Text = "이상 현상의 팔레트"
  },
  Skill_98332_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_98332_Name = {
    Text = "<Blue:원색·파란색>"
  },
  Skill_98333_Desc = {
    Text = "모든 깨어남체가 광기를 <Energy:8>pt 획득한다."
  },
  Skill_98333_Name = {
    Text = "<Yellow:원색·노란색>"
  },
  Skill_98334_Desc = {
    Text = "임시 <PowerIconKeywords:힘> [Power:Arg1]pt를 획득하고, 이번 턴에 주는 최종 피해가 10% 증가한다."
  },
  Skill_98334_Name = {
    Text = "<Red:원색·빨간색>"
  },
  Skill_98508_Desc = {
    Text = "행동력 3pt를 획득하고, 손의 모든 명령 카드에 <BurningKeywords:연소>를 부여한다. 이번 턴에 <BurningKeywords:연소>가 부여된 카드를 사용하면 <Heat:심연의 불꽃> 1스택을 소모하여 해당 카드가 2회 발동하며, 턴 종료 시 <Heat:심연의 불꽃>을 모두 초기화한다."
  },
  Skill_98508_Name = {
    Text = "끝없는 폭염"
  },
  Skill_98704_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_98704_Name = {
    Text = "창백한 선회"
  },
  Skill_98705_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 추가로 대상의 중독 스택의 [Arg3]%에 해당하는 피해를 입힌다."
  },
  Skill_98705_Name = {Text = "타격"},
  Skill_98706_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득한다."
  },
  Skill_98706_Name = {
    Text = "창백한 보호"
  },
  Skill_98707_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 및 <PowerIconKeywords:힘> [Arg2]pt를 획득하고, 덱 맨 위의 카드 [Arg3]장에 둔화 [Arg4]스택을 부여한다."
  },
  Skill_98707_Name = {
    Text = "마지못한 자비"
  },
  Skill_98729_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 덱 맨 위의 카드 [Arg2]장에 둔화 [Arg3]스택을 부여한다."
  },
  Skill_98729_Name = {
    Text = "마지못한 자비"
  },
  Skill_98730_Desc = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 [AttackTimes:Arg2]회 입히고, 피해량의 [Arg3]%에 해당하는 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  Skill_98730_Name = {
    Text = "창백한 선회"
  },
  Skill_98731_Desc = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt, <PowerIconKeywords:힘> [Arg2]pt, <AlertIconKeywords:경계> [Arg3]pt를 획득한다."
  },
  Skill_98731_Name = {
    Text = "창백한 보호"
  },
  Skill_98744_Desc = {
    Text = "「참칭자」를 획득하며, 부여하는 중독이 100% 증가하고, 매 턴 종료 시 실타래드를 <Block:[Block:Arg1]>pt 획득한다."
  },
  Skill_98744_Name = {
    Text = "방황의 길"
  },
  Skill_98984_AwakerSkillBackgroundStory = {
    Text = "내 시선을 두려워하지 말고, 나에게 다가오세요, 가까이 오세요...\n붓이 만드는 화려한 환상 속에서, 제가 당신에게 최고의 아름다움을 부여하게 해주세요."
  },
  Skill_98984_Desc_0 = {
    Text = "[<DevouredIconKeywords:포식>: 이번 턴에 다음으로 사용하는 명령 카드의 행동력 소모가 2 감소한다.] <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 이번 턴에 다른 깨어남체의 광기 폭발로 주는 최종 피해, 실타래드, HP 회복이 [Arg2]% 증가한다. 출전 깨어남체의 스킬 중 <Chuanggoukeyin:그려진 각인>이 있는 스킬 3장을 <FaxianKeywords:발견>하고, 1장을 선택하여 손에 넣는다. 해당 카드에 <DepleteIconKeywords:소모>와 <RetainIconKeywords:유지>를 부여한다."
  },
  Skill_98984_Desc_2 = {
    Text = "[<DevouredIconKeywords:포식>: 이번 턴에 다음으로 사용하는 명령 카드의 행동력 소모가 2 감소한다.] <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 이번 턴에 다른 깨어남체의 광기 폭발로 주는 최종 피해, 실타래드, HP 회복이 [Arg2]% 증가한다. 출전 깨어남체의 스킬 중 <Chuanggoukeyin:그려진 각인>이 있는 스킬 3장을 <FaxianKeywords:발견>하고, 1장을 선택하여 손에 넣는다. 해당 카드에 <DepleteIconKeywords:소모>와 <RetainIconKeywords:유지>를 부여한다."
  },
  Skill_98984_EffectNameList = {Text = "힘"},
  Skill_98984_Name = {
    Text = "진실타래, 그것은 환상"
  },
  Skill_98984_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:포식>: 이번 턴에 다음으로 사용하는 명령 카드의 행동력 소모가 2 감소한다.] <PowerIconKeywords:힘> [Power:Arg1]pt를 획득한다. 이번 턴에 다른 깨어남체의 광기 폭발로 주는 최종 피해, 실타래드, HP 회복이 [Arg2]% 증가한다. <Kuangxiang:광상> 1스택을 획득한다. 출전 깨어남체의 스킬 중 <Chuanggoukeyin:그려진 각인>이 있는 스킬 3장을 2회 <FaxianKeywords:발견>하고, 1장을 선택하여 손에 넣는다. 해당 카드에 <DepleteIconKeywords:소모>와 <RetainIconKeywords:유지>를 부여한다."
  },
  Skill_98984_PropertyNameList = {
    Text = "공격력*GrowValue1"
  },
  Skill_98985_AwakerSkillBackgroundStory = {
    Text = "시체의 잔상이 픽맨의 손끝에서 맴돌며, 길들여지지 않은 영감이 캔버스 위에서 광란의 춤을 춘다.\n평범한 화가는 현실타래의 표상을 그리지만, 진정한 예술가는 광기를 휘둘러 모든 알려지지 않은 기쁨, 고통, 욕망과 추함을 그린다."
  },
  Skill_98985_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:배아 융합>이 [Arg1] 증가하고, <EmptinessKeywords:공허> 상태를 제거합니다. <Chuanggouzaowu:창조의 은빛 유물> 3개를 <FaxianKeywords:발견>하고 1개를 선택하여 획득합니다. 해당 유물은 [Arg2]턴 동안 지속됩니다."
  },
  Skill_98985_Desc_2 = {
    Text = "<EmbryoFusionIconKeywords:배아 융합>이 [Arg1] 증가하고, <EmptinessKeywords:공허> 상태를 제거합니다. <Chuanggouzaowu:창조의 금빛 유물> 3개를 <FaxianKeywords:발견>하고 1개를 선택하여 획득합니다. 해당 유물은 [Arg2]턴 동안 지속됩니다."
  },
  Skill_98985_EffectNameList = {
    Text = "배아 융합"
  },
  Skill_98985_Name = {
    Text = "그림자 모사"
  },
  Skill_98986_AwakerSkillBackgroundStory = {
    Text = "이건 예술에 대한 모독이야! 그런 편협한 편견으로 내 예술을 더럽힐 생각 마."
  },
  Skill_98986_BattleDesc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_98986_BattleDesc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 무작위로 스킬 카드 1장을 드로우한다. 매 턴 최대 1회만 발동한다([Arg3]/1)."
  },
  Skill_98986_Desc_0 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 픽맨이 광기를 <Energy:[Energy:Arg2]>pt 획득한다."
  },
  Skill_98986_Desc_1 = {
    Text = "실타래드를 <Block:[Block:Arg1]>pt 획득하고, 픽맨이 광기를 <Energy:[Energy:Arg2]>pt 획득한다. 무작위로 스킬 카드 1장을 드로우한다. 매 턴 최대 1회만 발동한다."
  },
  Skill_98986_EffectNameList = {
    Text = "실타래드, 광기"
  },
  Skill_98986_Name = {Text = "방어"},
  Skill_98986_PropertyNameList = {
    Text = "방어력*GrowValue1,$GrowValue2"
  },
  Skill_98987_Desc = {
    Text = "「<Kuangxiang:광상>」 1스택을 소모하여, 모든 <FaxianKeywords:발견> 효과를 선택하여 발동한다. <Chuangyi:창의> 1스택을 획득한다."
  },
  Skill_98987_Name = {
    Text = "영감 폭발!"
  },
  Skill_98988_AwakerSkillBackgroundStory = {
    Text = "당신은 왜 아름다움에 저항하나요?\n자, 사랑하는 모델이여, 저의 창작을 느껴보세요."
  },
  Skill_98988_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_98988_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 무작위로 「스킬」 1장을 드로우한다. 매 턴 최대 1회 발동한다([Arg3]/1)."
  },
  Skill_98988_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 픽맨이 <Energy:[Energy:Arg2]>pt의 광기를 획득한다."
  },
  Skill_98988_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>pt의 피해를 입히고, 픽맨이 <Energy:[Energy:Arg2]>pt의 광기를 획득하며, 무작위로 「스킬」 1장을 드로우한다. 매 턴 최대 1회 발동한다."
  },
  Skill_98988_EffectNameList = {
    Text = "피해, 광기"
  },
  Skill_98988_Name = {Text = "타격"},
  Skill_98988_PropertyNameList = {
    Text = "공격력*GrowValue1,$GrowValue2"
  },
  Skill_98989_AwakerSkillBackgroundStory = {
    Text = "조용하고 깊은 묘지, 시체는 조각상처럼 전시되며, 특별한 모형이 되어 죽음의 침묵과 신비를 담아내며, 화가의 무한한 아이디어를 자극합니다.\n뻣뻣한 자세, 창백한 피부, 일그러진 표정……픽맨은 그림자와 부패 속에서 아름다움의 가능성을 찾습니다."
  },
  Skill_98989_Desc_0 = {
    Text = "피크먼이 <Energy:[Energy:Arg1]> 의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: <Kuangxiang:광상> 1층을 획득합니다. 피크먼이 <Chuangyi:창의> 1층을 획득할 때마다, <EmbryoFusionIconKeywords:배아융합>+ [Arg2]."
  },
  Skill_98989_Desc_15 = {
    Text = "피크먼이 <Energy:[Energy:Arg1]> 의 광기를 획득합니다. <ExaltIconKeywords:영지깨어남>: <Kuangxiang:광상> 1층을 획득합니다. 피크먼이 <Chuangyi:창의> 1층을 획득할 때마다, <EmbryoFusionIconKeywords:배아융합>+ [Arg2]. 「회영모형」이 창조한 황금 조형물의 지속 턴 수가 1턴에서 2턴으로 증가합니다."
  },
  Skill_98989_EffectNameList = {
    Text = "광기, 배아 융합"
  },
  Skill_98989_Name = {
    Text = "묘지의 화실타래"
  },
  Skill_98990_AwakerSkillBackgroundStory = {
    Text = "당신은 진정한 색상을 본 적이 있나요?\n온순한 물감이 아니라, 공격적이고 뼈 속까지 스며드는 광기입니다.\n각각의 색조는 뼈를 에는 떨림과 황홀감을 주며, 그것이야말로 화가가 추구하는 최고의 아름다움입니다."
  },
  Skill_98990_BattleDesc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>점의 반드시 크리티컬인 피해를 [Arg3]회 가하며, 피해를 가할 때마다 대상의 <ExhaustionIconKeywords:힘>을 임시로 [Exhaustion:Arg2]점 감소시키고 [Power:Arg2]점의 <PowerIconKeywords:임시 힘>을 획득합니다. 이번 턴 <FaxianKeywords:발견> 효과가 발동될 때마다 이 카드의 기본 행동력 소모가 1 감소하며, 「영감 폭발!」이 발동된 경우 피해를 2회 추가로 가합니다."
  },
  Skill_98990_Desc = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>점의 반드시 크리티컬인 피해를 [Arg3]회 가하며, 피해를 가할 때마다 대상의 <PowerIconKeywords:힘>을 [Arg2]점 <TouquKeywords:탈취>합니다. 이번 턴 <FaxianKeywords:발견> 효과가 발동될 때마다 이 카드의 기본 행동력 소모가 1 감소하며, 「영감 폭발!」이 발동된 경우 피해를 2회 추가로 가합니다."
  },
  Skill_98990_EffectNameList = {
    Text = "피해, 힘 탈취"
  },
  Skill_98990_Name = {
    Text = "침식하는 색채"
  },
  Skill_98990_PropertyNameList = {
    Text = "공격력*GrowValue1, 공격력*GrowValue2"
  },
  Skill_99016_Desc = {
    Text = "「<Kuangxiang:광상>」 1스택을 소모하여, 모든 <FaxianKeywords:발견> 효과를 선택하여 발동한다. <Chuangyi:창의> 1스택을 획득한다."
  },
  Skill_99016_Name = {
    Text = "영감 폭발!"
  },
  Skill_99035_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  Skill_99035_Name_1 = {
    Text = "환몽 화생"
  },
  Skill_99036_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 장착한 깨어남체의 「스킬」 1장을 랜덤하게 손에 넣고, 그 스킬의 행동력 소모를 0으로 만든다."
  },
  Skill_99036_Name_1 = {
    Text = "사실타래주의 역설"
  },
  Skill_99037_Desc_1 = {
    Text = "다음 효과를 무작위로 3회 발동한다: 무작위 적에게 [Arg1]의 피해를 주고 <DisarmKeywords:마비>를 부여한다, 무작위 적에게 [Arg1]의 피해를 주고 <PVPMethysisKeywords:중독>을 부여한다, 모든 적에게 [Arg1]의 피해를 준다."
  },
  Skill_99037_Name_1 = {
    Text = "허무의 색채"
  },
  Skill_99037_UnknownName = {
    Text = "허무의 색채"
  },
  Skill_99038_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  Skill_99038_Name_1 = {
    Text = "원색 침식"
  },
  Skill_99039_Desc_1 = {
    Text = "전체 적에게 <Damage:[Damage:Arg1]>의 피해를 준다."
  },
  Skill_99039_Name_1 = {
    Text = "찬란한 색채"
  },
  Skill_99040_Desc_1 = {
    Text = "<PVPWeaponKeywords:명륜>: 다른 아군이 매 턴 처음으로 「광기 폭발」 한 후, 1장의 카드를 드로우한다."
  },
  Skill_99040_Name_1 = {
    Text = "갈망의 붓"
  },
  Skill_99041_Desc_1 = {
    Text = "산출력 소모가 [Arg1]인 자신의 서로 다른 「스킬」 3장을 손패에 넣고, <StrongEffectKeywords:강효> +[Arg2]."
  },
  Skill_99041_Name_1 = {
    Text = "망상 속의 진실타래"
  },
  Skill_99042_Desc_1 = {
    Text = "전방 적에게 <Damage:[Damage:Arg1]>의 피해를 주고, <Energy:[Energy:Arg2]>의 광기를 획득한다."
  },
  Skill_99042_Name_1 = {Text = "타격"},
  Skill_99115_Desc = {
    Text = "「화사」가 식시귀 형태로 전환하여 [Arg1] 의 <PowerIconKeywords:힘>을 획득하고, 플레이어의 드로우 더미와 버린 더미에서 [Arg2] 장의 카드에 <ErosionColorInkKeywords:인지 착란>을 부여합니다."
  },
  Skill_99115_Name = {
    Text = "묘지의 화실타래"
  },
  Skill_99116_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 가하고, [Arg4] 의 <PowerIconKeywords:힘>을 획득합니다. 이번 턴에 <ErosionColorInkKeywords:인지 착란> 카드를 1장 낼 때마다 「화사」의 <PowerIconKeywords:임시 힘>이 [Arg3] 감소합니다."
  },
  Skill_99116_Name = {
    Text = "망상 속의 진실타래"
  },
  Skill_99117_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 [AttackTimes:Arg2] 회 가하고, [Arg5] 의 <PowerIconKeywords:힘>을 획득합니다. 해당 의도로 전환 시, 플레이어가 <ErosionColorInkKeywords:인지 착란> 카드를 1장 보유할 때마다 「화사」가 [Arg3] 의 <PowerIconKeywords:힘>을 획득합니다. 이번 턴에 <ErosionColorInkKeywords:인지 착란> 카드를 1장 낼 때마다 「화사」의 <PowerIconKeywords:임시 힘>이 [Arg4] 감소합니다."
  },
  Skill_99117_Name = {
    Text = "예술, 곧 광기"
  },
  Skill_99118_Desc = {
    Text = "[Arg1]턴간 <VulnerabilityIconKeywords:취약>을 부여하고, 「융식-추종자」 1개와 「융식-갈망자」 1개를 소환한다."
  },
  Skill_99118_Name = {
    Text = "그림자 모사"
  },
  Skill_99119_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 가하고, 플레이어의 드로우 더미와 버린 더미에서 [Arg2] 장의 카드에 <ErosionColorInkKeywords:인지 착란>을 부여합니다. 모든 <DecayDye:환세 염료>를 소모하며, 1층 소모할 때마다 피해 횟수와 <ErosionColorInkKeywords:인지 착란> 수가 1 증가합니다."
  },
  Skill_99119_Name = {
    Text = "침식하는 색채"
  },
  Skill_99120_Desc = {
    Text = "[Arg1]턴간 <VulnerabilityIconKeywords:취약>과 <WeaknessIconKeywords:허약>을 부여하고, 「융식-시인」 1개를 소환한다."
  },
  Skill_99120_Name = {
    Text = "그림자 모사"
  },
  Skill_99121_Desc = {
    Text = "<Damage:[Damage:Arg1]> 의 피해를 가하고, 플레이어의 드로우 더미와 버린 더미에서 [Arg2] 장의 카드에 <ErosionColorInkKeywords:인지 착란>을 부여합니다. 모든 <DecayDye:환세 염료>를 소모하며, 1층 소모할 때마다 피해 횟수와 <ErosionColorInkKeywords:인지 착란> 수가 1 증가합니다."
  },
  Skill_99121_Name = {
    Text = "침식하는 색채"
  }
})
return Text_Skill
