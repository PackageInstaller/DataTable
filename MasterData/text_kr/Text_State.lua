__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "모든 깨어남체가 주는 광기가 50% 증가한다."
  },
  State_100291_Name = {Text = "고백"},
  State_100292_Name = {Text = "턴 시작"},
  State_100293_Desc = {
    Text = "모든 깨어남체가 주는 광기가 50% 감소한다."
  },
  State_100293_Name = {
    Text = "인격 그림자"
  },
  State_100295_Name = {
    Text = "피해 감청"
  },
  State_100296_Desc = {
    Text = "스택당 턴 시작 시 모든 깨어남체가 <Energy:5>의 광기를 획득한다."
  },
  State_100296_Name = {
    Text = "자아의 어두운 면"
  },
  State_100297_Desc = {
    Text = "모든 깨어남체가 주는 광기가 50% 증가하며, 턴 종료 시 최대 HP의 20%만큼 실타래드를 획득한다."
  },
  State_100297_Name = {
    Text = "정신의 벽"
  },
  State_100298_Desc = {
    Text = "턴 시작 후 현재 HP의 10%를 잃고, [DescArg1]의 <PowerIconKeywords:힘>을 획득한다. 모든 깨어남체가 주는 광기가 50% 감소한다."
  },
  State_100298_Name = {
    Text = "장벽 붕괴"
  },
  State_100299_Desc = {
    Text = "광기 폭발 카운트"
  },
  State_100299_Name = {
    Text = "광기 폭발 카운터"
  },
  State_100302_Name = {
    Text = "광기 폭발 감청"
  },
  State_100307_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 광기 폭발을 발동한 후 「공동 창조」 1스택을 획득한다. 이번 턴 내에 다른 깨어남체의 광기 폭발이 「공동 창조」를 소모하여, 해당 광기 폭발의 치명타율을 <WeaponEffect_Num:[StateArg1]%> 증가시킬 수 있으며, 「공동 창조」를 소모한 깨어남체가 장착한 깨어남체의 광기 회충량의 <WeaponEffect_Num:[StateArg1]%>만큼 광기를 획득한다."
  },
  State_100307_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 발동한 후 「공동 창조」 1스택을 획득한다. 이번 턴 내에 다른 깨어남체의 광기 폭발이 「공동 창조」를 소모하여, 해당 광기 폭발의 치명타율을 <WeaponEffect_Num:[StateArg1]%> 증가시키며, 「공동 창조」를 소모한 깨어남체가 <WeaponEffect_Num:[DescArg1]>의 광기를 획득한다."
  },
  State_100326_Desc = {
    Text = "스택당 턴 시작 시 모든 깨어남체가 <Energy:3>의 광기를 획득한다."
  },
  State_100326_Name = {
    Text = "<DarkEgo:자아의 어두운 면>"
  },
  State_100327_Desc = {
    Text = "모든 깨어남체가 주는 광기가 50% 증가하며, 턴 종료 시 최대 HP의 20%만큼 실타래드를 획득한다."
  },
  State_100327_Name = {
    Text = "<MindWall:심리 장벽>"
  },
  State_100328_Desc = {
    Text = "모든 깨어남체가 주는 광기가 50% 증가한다."
  },
  State_100328_Name = {
    Text = "<TrueConfess:고백>"
  },
  State_100329_Desc = {
    Text = "모든 깨어남체가 주는 광기가 50% 감소하며, 턴 종료 후 <DarkEgo:자아의 어두운 면> 1스택을 획득한다. <DarkEgo:자아의 어두운 면>: 턴 시작 시 모든 깨어남체가 광기 3을 획득한다."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:인격 그림자>"
  },
  State_100330_Desc = {
    Text = "턴 시작 후 현재 HP의 10%를 잃고, [DescArg1]의 <PowerIconKeywords:힘>을 획득한다. 모든 깨어남체가 주는 광기가 50% 감소한다."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:장벽 붕괴>"
  },
  State_100395_Name = {
    Text = "창조된 은혜의 피+"
  },
  State_100396_Name = {
    Text = "창조된 은혜의 피"
  },
  State_100527_Desc = {
    Text = "픽맨이 「발견」 효과를 발동할 때 추가로 「영감 폭발!」 옵션이 추가된다: 「광상」 1스택을 소모하고, 모든 효과를 선택하며 「창의」 1스택을 획득한다."
  },
  State_100527_Name = {Text = "광상"},
  State_100541_Desc = {
    Text = "현재 「창의」가 10스택일 경우, 픽맨이 광기 폭발 발동 후 모든 「창의」를 소모하여 광상 1스택을 획득하고 모든 깨어남체가 광기 15를 획득한다. 창의의 최대치는 10스택이며, 다음 전투로 이월된다."
  },
  State_100541_Name = {
    Text = "<Chuangyi:창의>"
  },
  State_100542_Desc = {
    Text = "픽맨이 「발견」 효과를 발동할 때 추가로 「영감 폭발!」 옵션이 추가된다: 「광상」 1스택을 소모하고, 모든 「발견」 효과를 선택하며 「창의」 1스택을 획득한다."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:광상>"
  },
  State_100544_Name = {
    Text = "달콤한 민달팽이"
  },
  State_100544_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드와 HP 회복이 6% 증가한다. 장착한 깨어남체의 영역 숙련이 50을 초과할 경우, 실타래드와 HP 회복이 추가로 6% 증가한다."
  },
  State_100545_Name = {
    Text = "달콤한 민달팽이"
  },
  State_100545_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드와 HP 회복이 6% 증가한다. 장착한 깨어남체의 영역 숙련이 50을 초과할 경우, 실타래드와 HP 회복이 추가로 6% 증가한다."
  },
  State_100558_Desc = {
    Text = "이번 턴에 다른 깨어남체의 다음 광기 폭발 치명타율이 [StateArg1]% 증가하며, 사용 후 [DescArg1]의 광기를 획득한다."
  },
  State_100558_Name = {
    Text = "공동 창작"
  },
  State_100559_Desc = {
    Text = "다음 「별의 시대 유물」을 포함한다: 악동, 봄의 제전, 무거운 자물쇠, 줄마노, 은혜의 피, 녹슨 강톱, 황금빛 꿈나라, 피 묻은 자갈."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:창조 유물>"
  },
  State_100562_Desc = {
    Text = "이번 턴에 사용하는 다음 [Layer]장의 명령 카드 행동력 소모가 2 감소한다."
  },
  State_100562_Name = {
    Text = "진실타래이자 환상"
  },
  State_100564_Desc = {
    Text = "다음 「각인」을 포함한다: 계산, 묘수, 광화, 촉매, 난폭, 철벽, 쇠약, 영감."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:창조 각인>"
  },
  State_100566_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_100617_Desc = {
    Text = "턴 종료 시, 촉수 상한 1을 획득한다."
  },
  State_100617_Name = {
    Text = "잊혀진 집념"
  },
  State_100619_Desc = {
    Text = "힘 감소 시, 힘 스택의 50%만 감소한다."
  },
  State_100619_Name = {
    Text = "쇠약 저항"
  },
  State_100621_Desc = {
    Text = "스택당 플레이어가 주는 기본 피해가 15% 감소하며, 이후 항해의 방향을 안내할 수 있다."
  },
  State_100621_Name = {
    Text = "희미한 촛불"
  },
  State_100623_Desc = {
    Text = "스택당 플레이어가 주는 기본 피해가 30% 감소하며, 능동 피해 또는 촉수 피해를 입힌 후, 자신의 중독이 [DescArg1] 감소한다."
  },
  State_100623_Name = {
    Text = "미항의 빛"
  },
  State_100639_Desc = {
    Text = "주는 촉수 피해가 임시로 50% 감소한다."
  },
  State_100639_Name = {
    Text = "잃어버린 고대의 도시"
  },
  State_100644_Desc = {
    Text = "대상의 힘을 영구적으로 감소시키고, 감소한 만큼의 힘을 획득한다."
  },
  State_100644_Name = {
    Text = "<TouquKeywords:영구 탈취>"
  },
  State_100647_Desc = {
    Text = "모든 피해를 면역한다."
  },
  State_100647_Name = {
    Text = "모든 피해 면역"
  },
  State_100694_Desc = {
    Text = "스택당 플레이어가 주는 기본 피해가 30% 감소하며, 능동 피해 또는 촉수 피해를 입힌 후, 자신의 중독이 감소한다."
  },
  State_100694_Name = {
    Text = "미항의 빛"
  },
  State_116342_Desc = {
    Text = "<ErosionColorInkKeywords:인지 착란> 카드 사용 후 「화사」가 1층 <DecayDye:환세 염료>를 획득."
  },
  State_116342_Name = {
    Text = "이상 현상의 팔레트"
  },
  State_116406_Name = {Text = "진급"},
  State_116407_Name = {Text = "공 상태"},
  State_116858_Desc = {
    Text = "이 상태는 취약 곱셈 구역을 사용하며, 독립적인 곱셈 구역인 척한다. 「개발 전용」"
  },
  State_116858_Name = {
    Text = "특정 상태를 보유하고 있으면 받는 피해가 2배로 증가함__[개발 전용]"
  },
  State_116859_Desc = {
    Text = "다음 턴 시작 시, 약점을 획득한다."
  },
  State_116859_Name = {
    Text = "지연 약점"
  },
  State_116958_Desc = {
    Text = "카드 사용 후, 해당 스택 수만큼 피해를 받는다."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:카드 봉쇄>"
  },
  State_117154_Desc = {
    Text = "이 효과는 팀의 모든 깨어남체에 대해 단 1회만 발동하며, 반복해서 발동할 수 없다."
  },
  State_117154_Name = {
    Text = "<TeamUnique:팀 고유>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 전과 턴 종료 시, <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 <Damage:[Damage:StateArg1]> 스택의 <PVPCorrosionKeywords:죄인>을 부여한다."
  },
  State_117212_Name = {
    Text = "왜곡된 기사시"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 사용 시 및 턴 종료 시, 광기가 가장 높은 적에게 [StateArg1]의 <PVPfengsuoKeywords:폭발 봉인>을 부여한다."
  },
  State_117213_Name = {
    Text = "성자의 얼굴"
  },
  State_117346_Desc = {
    Text = "폴룩스가 주는 피해에 [Layer]%의 출혈이 추가로 부여된다."
  },
  State_117346_Name = {Text = "죄인"},
  State_117355_Desc = {
    Text = "폴룩스가 사용하는 다음 명령 카드가 2회 발동된다."
  },
  State_117355_Name = {
    Text = "신의 새 계약"
  },
  State_117357_Desc = {
    Text = "팀 유일: 「융흔」과 「잿더미 유적」이 새로고침된 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다."
  },
  State_117357_WeaponDesc = {
    Text = "「융흔」과 「잿더미 유적」이 새로고침된 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다."
  },
  State_117358_Desc = {
    Text = "스택당 폴룩스가 주는 피해에 1%의 출혈이 추가로 부여된다."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:죄인>"
  },
  State_117744_Desc = {
    Text = "[Layer] <MaxHPKeywords:최대 HP>를 잃으며, 해제 시 잃은 최대 HP는 반환되지 않는다. 발동 시 [Layer] 의 순수 피해를 받는다. 영속."
  },
  State_117744_Name = {Text = "죄인"},
  State_117745_Desc = {
    Text = "부여 시 동일한 스택 수만큼의 <MaxHPKeywords:최대 HP>를 잃으며, 해제 시 잃은 최대 HP는 반환되지 않는다. 발동 시 동일한 스택 수만큼의 순수 피해를 받는다. 영속."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:죄인>"
  },
  State_117755_Desc = {
    Text = "턴 종료 전까지 아무런 행동도 할 수 없다."
  },
  State_117755_Name = {Text = "기절"},
  State_117756_Desc = {
    Text = "턴 종료 전까지 아무런 행동도 할 수 없다."
  },
  State_117756_Name = {Text = "기절"},
  State_117776_Desc = {
    Text = "이번 턴에 [Layer]장의 명령 카드 최종 피해와 실타래드가 [StateArg1]% 증가한다."
  },
  State_117776_Name = {Text = "신염"},
  State_117777_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 카드가 주는 기본 피해와 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 턴 시작 시 및 장착한 깨어남체가 광기 폭발을 발동한 후, 「심화」 1스택을 획득한다. 장착한 깨어남체가 이번 턴에 명령 카드를 사용할 때 「심화」 1스택을 소모하여, 해당 카드의 최종 피해와 실타래드가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 초차원 턴에서는 「신염」을 획득하며, 효과가 2배로 증가한다."
  },
  State_117777_WeaponDesc = {
    Text = "장착한 깨어남체의 카드가 주는 기본 피해와 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 턴 시작 시 및 장착한 깨어남체가 광기 폭발을 발동한 후, 「심화」 1스택을 획득한다. 장착한 깨어남체가 이번 턴에 명령 카드를 사용할 때 「심화」 1스택을 소모하여, 해당 카드의 최종 피해와 실타래드가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 초차원 턴에서는 「신염」을 획득하며, 효과가 2배로 증가한다."
  },
  State_117778_Desc = {
    Text = "이번 턴에 [Layer]장의 명령 카드 최종 피해와 실타래드가 [StateArg1]% 증가한다."
  },
  State_117778_Name = {Text = "심화"},
  State_117779_Desc = {
    Text = "팀 유일: 초차원 턴에 장착한 깨어남체가 「심화」 3스택을 획득한다. 장착한 깨어남체가 이번 턴에 명령 카드를 사용할 때 1스택을 소모하여, 해당 카드의 최종 피해와 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_117779_WeaponDesc = {
    Text = "초차원 턴에 장착한 깨어남체가 「심화」 3스택을 획득한다. 장착한 깨어남체가 이번 턴에 명령 카드를 사용할 때 1스택을 소모하여, 해당 카드의 최종 피해와 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_117851_Desc = {
    Text = "폴룩스의 각 명령 카드가 추가로 50%의 「고통 구원」 효과를 받으며, [Layer]턴 동안 지속된다."
  },
  State_117851_Name = {
    Text = "백야를 비추는 빛"
  },
  State_117853_Desc = {
    Text = "폴룩스가 이번 턴에 사용하는 다음 [Layer]장의 명령 카드 피해가 [DescArg1] 증가하고, 실타래드가 [DescArg2] 증가하며, 광기 10을 획득한다."
  },
  State_117853_Name = {
    Text = "고통 구원"
  },
  State_117869_Desc = {
    Text = "광기 폭발을 발동할 때마다 「호출」 1스택이 증가하며, 「호출」 1스택당 [DescArg1]의 힘을 획득한다. 상한은 5스택이다."
  },
  State_117869_Name = {
    Text = "심해 대사제"
  },
  State_117870_Desc = {
    Text = "사망 후, 처치자가 잃은 HP의 20%를 회복한다."
  },
  State_117870_Name = {
    Text = "맛있는 회"
  },
  State_117875_Desc = {
    Text = "후방에 빈 자리가 있으면, 행동 후 1스택을 잃고 「맛있는 회」가 부여된 「치어」 1개를 소환한다."
  },
  State_117875_Name = {
    Text = "상호 계약: 어군"
  },
  State_117876_Desc = {
    Text = "부여하는 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <HeavyInjuryKeywords:중상> 효과가 50%로 증가한다."
  },
  State_117876_Name = {
    Text = "허약&손상&중상 심화"
  },
  State_117880_Desc = {
    Text = "이번 전투에서 이후의 「물고기 떼 비약」이 추가로 1회 발동된다."
  },
  State_117880_Name = {
    Text = "어군 비상 추가 발동"
  },
  State_117883_Desc = {
    Text = "5스택에 도달하면, 모든 깨어남체를 즉시 봉인하고 의도를 「레무리아의 영광!+」으로 변경한다."
  },
  State_117883_Name = {Text = "호출"},
  State_117885_Desc = {
    Text = "힘 감소 효과를 받을 때, 부여한 대상에게도 동일한 양의 힘 감소 효과를 부여한다."
  },
  State_117885_Name = {
    Text = "눈에는 눈"
  },
  State_117889_Desc = {
    Text = "등장 시 자신의 최대 HP가 10% 증가하고, 다른 아군에게 [DescArg1]의 <PowerIconKeywords:힘>을 부여하며, 이번 전투 중 <FishLeapWords:군서의 힘>의 HP 증가 및 힘 획득 효과가 추가로 1회 발동된다."
  },
  State_117889_Name = {
    Text = "군서의 힘"
  },
  State_118112_Desc = {
    Text = "받는 단일 피해 상한은 [DescArg1]pt이며, HP가 50% 미만이 되면 제한이 해제된다."
  },
  State_118112_Name = {
    Text = "고통 역치 I"
  },
  State_118113_Desc = {
    Text = "능동 피해를 받고 HP를 잃은 후, 잃은 HP의 15%에 해당하는 실타래드와 잃은 HP의 5%에 해당하는 <AlertIconKeywords:임시 경계>를 획득한다."
  },
  State_118113_Name = {
    Text = "연체 특성 I"
  },
  State_118114_Desc = {
    Text = "능동 피해를 받고 HP를 잃은 후, 잃은 HP의 35%에 해당하는 실타래드와 잃은 HP의 10%에 해당하는 <AlertIconKeywords:임시 경계>를 획득한다."
  },
  State_118114_Name = {
    Text = "연체 특성 III"
  },
  State_118115_Desc = {
    Text = "전방에 빈 자리가 있으면, 행동 후 1스택을 잃고 「심해 분열체」 1개를 소환한다."
  },
  State_118115_Name = {
    Text = "상호 계약: 심해 분열체"
  },
  State_118116_Desc = {
    Text = "받는 단일 피해 상한은 [DescArg1]pt이며, HP가 50% 미만이 되면 제한이 해제된다."
  },
  State_118116_Name = {
    Text = "고통 역치 II"
  },
  State_118117_Desc = {
    Text = "받는 단일 피해 상한은 [DescArg1]pt이며, HP가 50% 미만이 되면 제한이 해제된다."
  },
  State_118117_Name = {
    Text = "고통 역치 III"
  },
  State_118118_Desc = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>가 [TentaclePower:DescArg1]인 촉수 1개와 촉수 상한 5개를 획득한다. 턴 종료 후 촉수 1개를 획득한다. 받는 힘 감소 효과가 50% 감소한다."
  },
  State_118118_Name = {
    Text = "촉수 집결"
  },
  State_118119_Desc = {
    Text = "능동 피해를 받고 HP를 잃은 후, 잃은 HP의 25%에 해당하는 실타래드와 잃은 HP의 5%에 해당하는 <AlertIconKeywords:임시 경계>를 획득한다."
  },
  State_118119_Name = {
    Text = "연체 특성 II"
  },
  State_118319_Desc = {
    Text = "받는 단일 피해 상한은 [DescArg1]pt이며, HP가 50% 미만이 되면 제한이 해제된다."
  },
  State_118319_Name = {
    Text = "해연의 방패 피해 제한"
  },
  State_118320_Name = {
    Text = "임시 쇠약 역제 카운터"
  },
  State_118321_Name = {
    Text = "쇠약 역제 카운터"
  },
  State_118322_Name = {
    Text = "소환 준비 표식"
  },
  State_118323_Desc = {
    Text = "물고기 떼 비약이 발동되었다."
  },
  State_118323_Name = {
    Text = "어군 비상 출현 표식"
  },
  State_118324_Desc = {
    Text = "피해를 1회 입힐 때마다, 임시 촉수 1개를 생성한다."
  },
  State_118324_Name = {
    Text = "신의 은총"
  },
  State_118325_Desc = {
    Text = "방어되지 않은 피해를 입힐 때, [DescArg1]장의 질식을 덱 맨 위에 섞어 넣는다."
  },
  State_118325_Name = {
    Text = "신세계 뱀두인 진동"
  },
  State_118656_Desc = {
    Text = "카드를 사용할 때 [StateArg1]의 피해를 받고 1스택을 제거한다. 스택이 0이 되면 약한 「바다 속의 존재」가 부화한다. 턴 종료 시에도 기생 상태가 남아 있을 경우, 스택에 비례하여 HP가 증가하는 「바다 속의 존재」가 부화한다."
  },
  State_118656_Name = {
    Text = "다중 기생됨"
  },
  State_118657_Desc = {
    Text = "카드를 사용할 때 [StateArg1]의 피해를 받고 1스택을 제거한다. 스택이 0이 되면 약한 「바다 속의 존재」가 부화한다. 턴 종료 시에도 기생 상태가 남아 있을 경우, 스택에 비례하여 HP가 증가하는 「바다 속의 존재」가 부화한다."
  },
  State_118657_Name = {
    Text = "재기생됨"
  },
  State_118659_Desc = {
    Text = "카드를 사용할 때 [StateArg1]의 피해를 받고 1스택을 제거한다. 스택이 0이 되면 약한 「바다 속의 존재」가 부화한다. 턴 종료 시에도 기생 상태가 남아 있을 경우, 스택에 비례하여 HP가 증가하는 「바다 속의 존재」가 부화한다."
  },
  State_118659_Name = {Text = "기생됨"},
  State_118663_Name = {
    Text = "신세계 뱀두인 의도 감청"
  },
  State_118669_Name = {
    Text = "신세계 뱀두인 초기화"
  },
  State_118670_Desc = {
    Text = "쇠약 반격이 있는지 감지한다."
  },
  State_118670_Name = {
    Text = "쇠약 역제 측정"
  },
  State_118671_Desc = {
    Text = "플레이어의 쇠약 행동을 감지한다."
  },
  State_118671_Name = {
    Text = "쇠약 역제 감청"
  },
  State_118672_Name = {
    Text = "신세계 뱀두인 의도 감청 쿨다운"
  },
  State_118741_Name = {
    Text = "임시 촉수 제거"
  },
  State_118743_Name = {
    Text = "소환 준비 전방 위치에 소환 표식 필요"
  },
  State_118759_Name = {
    Text = "몬스터 현재 영구 촉수 수량"
  },
  State_118760_Name = {
    Text = "몬스터 영구 촉수 상한"
  },
  State_118762_Name = {
    Text = "최초 부패 안내"
  },
  State_118763_Name = {
    Text = "최초 신경 독소 관통 혈액 안내"
  },
  State_118764_Name = {
    Text = "최초 저주의 숨결 안내"
  },
  State_118766_Name = {
    Text = "푸른고리 문어 보스 의도 감청"
  },
  State_118769_Name = {
    Text = "은심 랜턴 안내"
  },
  State_118771_Name = {
    Text = "최초 정찰 공격 안내"
  },
  State_118772_Name = {
    Text = "최초 군사 열창 안내"
  },
  State_118935_Name = {
    Text = "몬스터 머피 의도 감청"
  },
  State_118938_Desc = {
    Text = "「심해 숙녀」가 깨어남하여, 생성하는 실타래드량이 크게 증가한다!"
  },
  State_118938_Name = {Text = "피조물"},
  State_118943_Desc = {
    Text = "자신의 턴에 받는 피해가 2배로 증가한다. 자신이 HP를 잃을 때, 잃은 양만큼 스택을 잃는다. 스택이 0이 되면 촉수 수를 영구적으로 1 감소시키고 스택을 초기화한다. 최소 1개까지 감소 가능하다."
  },
  State_118943_Name = {
    Text = "신모의 희생"
  },
  State_118973_Name = {
    Text = "인내의 반역 관리"
  },
  State_119051_Desc = {
    Text = "턴 종료 시 발동하며, 발동 시 동일한 스택 수만큼의 순수 피해를 받고 스택의 절반을 제거한다. 해제 불가."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:희생>"
  },
  State_119052_Desc = {
    Text = "능동 피해를 받은 후, 받은 피해의 [Layer]%만큼 희생을 획득한다."
  },
  State_119052_Name = {
    Text = "강생 의식"
  },
  State_119053_Desc = {
    Text = "턴 종료 시 발동하며, 발동 시 [Layer] 의 순수 피해를 받고 스택의 절반을 제거한다. 해제 불가."
  },
  State_119053_Name = {
    Text = "헌신의 제사"
  },
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 헌신의 제사가 가장 적은 적에게 <PVPSacrificeKeyWords:헌신의 제사>를 [StateArg1] 부여하고, 이를 [StateArg2]회 반복한다. 전체 아군이 더 이상 <PVPCapKeywords:최대 행동력> 감소 효과의 영향을 받지 않는다."
  },
  State_119058_Name = {
    Text = "어둠 속의 안식"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후, 전체 적이 이번 턴에 능동 피해를 받으면 받은 피해의 [StateArg1]%만큼 <PVPSacrificeKeyWords:희생>을 획득한다."
  },
  State_119059_Name = {
    Text = "푸른 고리 독소"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [StateArg1]% 증가하며, 임의의 아군이 「타격」을 사용한 후 [StateArg3]장의 카드를 뽑는다. 매 턴 최대 [StateArg2]회 발동한다(현재 [DescArg1]회 발동됨)."
  },
  State_119060_Name = {
    Text = "광란의 세계 끝에서"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 전체 아군의 「타격」 피해가 [StateArg1]% 증가한다."
  },
  State_119061_Name = {
    Text = "이성의 등불"
  },
  State_119063_Desc = {
    Text = "5스택에 도달하면, 의도를 「레무리아의 영광!」으로 변경한다."
  },
  State_119063_Name = {Text = "호출"},
  State_119075_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_119075_Name = {
    Text = "미깨어남"
  },
  State_119076_Desc = {
    Text = "전방에 빈 자리가 있다면, 행동 후 1스택을 잃고, 무작위로 「레무리아 깨어남체」 1개를 소환한다."
  },
  State_119076_Name = {
    Text = "상호 계약: 레무리아"
  },
  State_119077_Desc = {
    Text = "「호출」이 5스택에 도달하면, 모든 깨어남체를 즉시 봉인한다."
  },
  State_119077_Name = {
    Text = "미리암 깨어남!"
  },
  State_119077_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_119080_Desc = {
    Text = "「혼돈 기억」 또는 「잊혀지지 않은 새벽」을 발동할 때, 선택한 열쇠 지령이 추가로 1회 발동한다."
  },
  State_119080_Name = {
    Text = "망각에서 비롯됨"
  },
  State_119082_Desc = {
    Text = "깨어남체가 광기 폭발을 발동할 때마다, 기본 광기가 10 증가한다."
  },
  State_119082_Name = {
    Text = "광기 고갈"
  },
  State_119083_Desc = {
    Text = "명령 카드가 초차원 공간에서 꺼내질 때, 행동력 소모가 1 감소한다."
  },
  State_119083_Name = {
    Text = "그 경계의 종말"
  },
  State_119084_Desc = {
    Text = "열쇠 지령을 발동할 때마다, 필요한 은열쇠 에너지가 100 증가한다."
  },
  State_119084_Name = {
    Text = "은열쇠 진동"
  },
  State_119085_Desc = {
    Text = "핏빛 용광로를 사용한 후, 배아 1개를 성결의 자식으로 변환한다. 3턴 쿨다운."
  },
  State_119085_Name = {
    Text = "핏빛 양육"
  },
  State_119086_Desc = {
    Text = "번식의 힘 쿨다운 중, 남은 [Layer]턴."
  },
  State_119086_Name = {
    Text = "번식의 힘 - 쿨다운"
  },
  State_119104_Desc = {
    Text = "턴 시작 시 [DescArg1]스택의 「명계」를 획득한다."
  },
  State_119104_Name = {
    Text = "해제 의식"
  },
  State_119105_Desc = {
    Text = "사망 후 모든 「명계」를 잃는다. 명계 1스택당 최대 HP의 1%를 회복하고, 촉수 피해가 1% 증가한다."
  },
  State_119105_Name = {Text = "명계"},
  State_119106_Name = {
    Text = "몬스터 탄망 머피 의도 감청"
  },
  State_119107_Name = {
    Text = "신국의 질서 관리"
  },
  State_119108_Desc = {
    Text = "HP를 잃을 때, 스택당 잃은 HP의 1%만큼 <SacrificeKeyWord:희생>을 획득한다."
  },
  State_119108_Name = {
    Text = "강생 의식"
  },
  State_119109_Desc = {
    Text = "<SacrificeKeyWord:희생> 이외의 피해를 받으면, 받은 피해량만큼 「신국 질서」를 잃고, 피해량의 50%만큼 <SacrificeKeyWord:희생>을 획득한다. 스택이 0이 되면 「명계」 1스택을 획득하고 스택이 초기화된다."
  },
  State_119109_Name = {
    Text = "신국의 질서"
  },
  State_119132_Desc = {
    Text = "이번 턴 「타격」 피해가 [Layer]% 증가한다."
  },
  State_119132_Name = {
    Text = "타격 강화"
  },
  State_119134_Name = {
    Text = "최초 허망 개척자 안내"
  },
  State_119359_Name = {
    Text = "은열쇠 의식 카운터"
  },
  State_119362_Name = {
    Text = "의식 진행하기"
  },
  State_119363_Name = {
    Text = "보유 카드"
  },
  State_119364_Name = {
    Text = "광기 의식 카운터"
  },
  State_119365_Desc = {
    Text = "모든 깨어남체의 HP 회복 및 실타래드가 40% 증가한다."
  },
  State_119365_Name = {Text = "침착"},
  State_119366_Desc = {
    Text = "버린 후 다시 손으로 돌아온다."
  },
  State_119366_Name = {
    Text = "버린 후 손으로 돌아옴"
  },
  State_119367_Name = {
    Text = "생명 의식 카운터"
  },
  State_119368_Desc = {
    Text = "매 턴 시작 시 은열쇠 에너지 500을 획득한다."
  },
  State_119368_Name = {Text = "통찰"},
  State_119369_Desc = {
    Text = "모든 깨어남체가 획득하는 광기가 50% 증가한다."
  },
  State_119369_Name = {
    Text = "위엄 있는 지휘"
  },
  State_119370_Name = {Text = "유물"},
  State_119373_Name = {
    Text = "적이 희생 부여"
  },
  State_119567_Name = {
    Text = "의식 완료하기"
  },
  State_119568_Desc = {
    Text = "받는 타격 피해가 [Layer]pt 증가한다."
  },
  State_119568_Name = {
    Text = "타격 심화"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」 전, 「스킬」 전, 「광기 폭발」 전에 임시 <StrongEffectKeywords:강효> +[StateArg1]을 부여한다. 매 턴 각 효과는 한 번만 발동한다."
  },
  State_119583_Name = {
    Text = "우리는 다시 만날 것이다"
  },
  State_119588_Name = {
    Text = "혈육 쿨다운"
  },
  State_119589_Name = {
    Text = "초차원 쿨다운"
  },
  State_119590_Desc = {
    Text = "팀 유니크: 능동적으로 촉수 자세를 전환하거나, 진홍빛 용광로를 사용하거나, 「소멸」을 해제한 후, 장착자의 명령 카드를 1장 드로우합니다. 각 효과는 3턴 쿨다운입니다. 모든 각성체가 탐색으로 획득하는 동조율이 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_119590_WeaponDesc = {
    Text = "촉수 자세를 능동적으로 전환(현재 남은 [DescArg1]턴 쿨다운), 핏빛 용광로 사용(현재 남은 [DescArg2]턴 쿨다운), 「소멸」 발동 후(현재 남은 [DescArg3]턴 쿨다운), 장착한 깨어남체의 명령 카드 1장을 드로우한다. 각 효과는 3턴 쿨다운을 가진다. 탐색 완료 후, 모든 깨어남체가 획득하는 동조율이 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_119591_Name = {
    Text = "심해 쿨다운"
  },
  State_119741_Desc = {
    Text = "모든 깨어남체의 힘 획득 효과가 50% 감소한다."
  },
  State_119741_Name = {
    Text = "성상 저주: 쇠퇴의 슬픔"
  },
  State_119742_Desc = {
    Text = "매 턴 시작 시 잃은 HP의 15%를 회복한다."
  },
  State_119742_Name = {
    Text = "성상 축복: 영원한 꿈"
  },
  State_119743_Desc = {
    Text = "모든 깨어남체의 HP 회복량이 50% 감소한다."
  },
  State_119743_Name = {
    Text = "성상 저주: 파멸의 원한"
  },
  State_119744_Desc = {
    Text = "「성상 저주: 파멸의 원한」이 1턴간 무효화된다."
  },
  State_119744_Name = {
    Text = "성상 저주 면역: 파멸의 원한"
  },
  State_119746_Name = {
    Text = "심연의 사슬 소실타래 횟수"
  },
  State_119747_Desc = {
    Text = "피해를 받지 않으며, 1턴 동안 지속된다."
  },
  State_119747_Name = {
    Text = "은열쇠가 앞길을 인도하길."
  },
  State_119748_Desc = {
    Text = "「성상 저주: 쇠퇴의 슬픔」이 1턴간 무효화된다."
  },
  State_119748_Name = {
    Text = "성상 저주 면역: 쇠퇴의 슬픔"
  },
  State_119749_Desc = {
    Text = "수호자 턴 시작 시, 「<Abyssallock:꿈의 족쇄>」 스택 수만큼 손패의 카드에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  State_119749_Name = {
    Text = "꿈의 족쇄"
  },
  State_119750_Name = {
    Text = "천상의 장막 의도 감청"
  },
  State_119751_Name = {
    Text = "장막 재현 해방 표식"
  },
  State_119752_Desc = {
    Text = "매 턴 시작 시 최대 HP의 5%만큼 <PowerIconKeywords:힘>을 획득하고, 임시 치명타율이 25% 증가한다."
  },
  State_119752_Name = {
    Text = "성상 축복: 위엄의 꿈"
  },
  State_119753_Name = {
    Text = "어두운 심연의 조류 카운터"
  },
  State_119754_Desc = {
    Text = "모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  State_119754_Name = {
    Text = "성상 저주: 어리석음의 탄식"
  },
  State_119755_Name = {
    Text = "사망 카운터"
  },
  State_119756_Desc = {
    Text = "「성상 저주: 어리석음의 탄식」이 1턴간 무효화된다."
  },
  State_119756_Name = {
    Text = "성상 저주 면역: 어리석음의 탄식"
  },
  State_119757_Desc = {
    Text = "수호자 턴 시작 시, 「<Abyssallock:꿈의 족쇄>」 스택 수만큼 손패의 카드에 <SlowIconKeywords:둔화> 1스택을 부여한다. 「낙원의 장막」이 능동 피해로 파괴될 때마다 1스택씩 감소하며, 파괴한 깨어남체를 1턴간 「완전 봉인」한다."
  },
  State_119757_Name = {
    Text = "꿈의 족쇄"
  },
  State_119758_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 10을 획득한다."
  },
  State_119758_Name = {
    Text = "성상 축복: 지식의 꿈"
  },
  State_119760_Name = {
    Text = "사망 감청"
  },
  State_119789_Desc = {
    Text = "턴 시작 시 [Layer]의 HP를 회복한다."
  },
  State_119789_Name = {
    Text = "진흙 속의 꽃"
  },
  State_119837_Desc = {
    Text = "라모나가 이번 턴에 사용하는 다음 명령 카드가 2회 발동된다."
  },
  State_119837_Name = {
    Text = "다시 손 잡기"
  },
  State_119847_Desc = {
    Text = "사용 전에 카드의 행동력을 변경한다.「개발 전용」"
  },
  State_119847_Name = {
    Text = "사용 전 카드의 행동력 변경__「개발 전용」"
  },
  State_119928_Desc = {
    Text = "사용 후 추가로 [StateArg1]회 발동하며, <DepleteIconKeywords:소모>된다. <RippleKeywords:여파>: 카드 2장을 드로우한다."
  },
  State_119928_Name = {
    Text = "<Rune_20:심해의 메아리>"
  },
  State_119958_Desc = {
    Text = "사망 후 즉시 무작위 「물고기 떼」 1개를 소환하여, 해당 물고기 떼의 「물고기 떼 회유」를 1스택 감소시킨다."
  },
  State_119958_Name = {
    Text = "어군 회유"
  },
  State_119959_Desc = {
    Text = "사망 후 즉시 무작위 「태아 떼」 1개를 소환하여, 해당 태아 떼의 「생생불식」을 1스택 감소시킨다."
  },
  State_119959_Name = {
    Text = "생생불식"
  },
  State_119960_Desc = {
    Text = "가하는 주동 및 촉수 피해가 35% 감소하며, 플레이어의 현재 HP가 50% 초과 시 제거됩니다."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:부패>"
  },
  State_120215_Desc = {
    Text = "수호자 턴 시작 시, 「<Abyssallock:꿈의 족쇄>」 스택 수만큼 손패의 카드에 <SlowIconKeywords:둔화> 1스택을 부여한다. 「낙원의 장막」이 능동 피해로 파괴될 때마다 1스택씩 감소하며, 파괴한 깨어남체를 1턴간 「완전 봉인」한다."
  },
  State_120215_Name = {
    Text = "심연의 사슬"
  },
  State_120216_Desc = {
    Text = "수호자 턴 시작 시, 「<Abyssallock:심연의 사슬>」 스택 수만큼 손패의 카드에 <SlowIconKeywords:둔화> 1스택을 부여한다."
  },
  State_120216_Name = {
    Text = "심연의 사슬"
  },
  State_120218_Name = {
    Text = "턴 종료 시 머피 지원 선택"
  },
  State_120222_Name = {
    Text = "턴 시작 시 역전 저주 선택"
  },
  State_120292_Name = {
    Text = "수용되지 않은 아픔"
  },
  State_120293_Desc = {
    Text = "턴 종료 시 [Layer]pt의 HP를 회복한다."
  },
  State_120293_Name = {
    Text = "수용되지 않은 아픔"
  },
  State_120312_Desc = {
    Text = "사망 후 즉시 무작위 「물고기 왕」 1명을 소환하여, 해당 물고기 왕의 「물고기 떼 회유」를 1스택 감소시킨다."
  },
  State_120312_Name = {
    Text = "어군 회유"
  },
  State_120320_Desc = {
    Text = "스택당 다음 「망상의 왕녀」가 부여하는 「강생 의식」이 20% 증가하며, 최대 5스택까지 중첩된다. 5스택 달성 후 다음 「망상의 왕녀」의 피해 횟수가 2배로 증가한다."
  },
  State_120320_Name = {Text = "명계"},
  State_120321_Desc = {
    Text = "스택당 능동 또는 촉수 피해를 받을 때 피해의 1%에 해당하는 헌제 추가, 턴 종료 시 제거, 최대 75스택."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:강생 의식>"
  },
  State_120322_Desc = {
    Text = "팀 유일: 손패 상한이 2 증가하며, 다른 명륜이 제공하는 손패 상한과 중첩되지 않는다. 장착한 깨어남체의 은열쇠 충전, 광기 폭발이 주는 최종 피해 및 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 「정해」 자세로 전환할 때, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다. 3턴 쿨다운. 「노도」 자세로 전환할 때, 모든 적에게 <WeaponEffect_Num:[StateArg3]>스택의 <DwmofeiKeywords:강생 의식>을 부여한다. 3턴 쿨다운."
  },
  State_120322_WeaponDesc = {
    Text = "손패 상한이 2 증가하며, 다른 명륜이 제공하는 손패 상한과 중첩되지 않는다. 장착한 깨어남체의 은열쇠 충전, 광기 폭발이 주는 최종 피해 및 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 「정해」 자세로 전환할 때, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다. 3턴 쿨다운. 「노도」 자세로 전환할 때, 모든 적에게 <WeaponEffect_Num:[StateArg3]>스택의 <DwmofeiKeywords:강생 의식>을 부여한다. 3턴 쿨다운."
  },
  State_120324_Desc = {
    Text = "주동 또는 촉수 피해를 받을 때 [Layer]% 피해의 헌제가 추가되며, 턴 종료 시 제거됩니다. 최대 75스택까지 중첩됩니다."
  },
  State_120324_Name = {
    Text = "강생 의식"
  },
  State_120351_Desc = {
    Text = "[Layer]턴 후에 다시 「신국·고요한 바다」로 전환할 수 있다."
  },
  State_120351_Name = {
    Text = "신국·바다 냉각"
  },
  State_120354_Desc = {
    Text = "[Layer]턴 후에 다시 「신국·몰아치는 파도」로 전환할 수 있다."
  },
  State_120354_Name = {
    Text = "신국·노도 냉각"
  },
  State_120357_Name = {Text = "촉수"},
  State_120362_Desc = {
    Text = "<SacrificeKeyWord:희생> 이외의 피해를 받으면, 피해량의 50%만큼 <SacrificeKeyWord:희생>을 획득한다."
  },
  State_120362_Name = {
    Text = "일반 몬스터 희생 관리"
  },
  State_120363_Desc = {
    Text = "턴 종료 후 [Layer]의 피해를 받고 <SacrificeKeyWord:희생> 스택의 50%가 감소한다."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:희생>"
  },
  State_120364_Desc = {
    Text = "자신이 사망하면 「도해자 근위대」를 소환한다."
  },
  State_120364_Name = {
    Text = "영원한 신념"
  },
  State_120401_Desc = {
    Text = "이 카드의 행동력 소모가 [StateArg5] 감소하며, 사용 후 [StateArg4]장의 카드를 드로우한다."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:미사그 배지>"
  },
  State_120450_Name = {
    Text = "푸른고리 문어 플레이어 HP 기록"
  },
  State_120462_Desc = {
    Text = "전투 종료 후에도 덱에 보존되지만, 사용하거나 소모되면 영구적으로 제거됩니다."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:폐기>"
  },
  State_120900_Name = {
    Text = "「레무리아 깨어남체」 소환 준비 카운터"
  },
  State_120907_Desc = {
    Text = "촉수가 공격할 때 방어될 경우, [DescArg1]스택의 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  State_120907_Name = {Text = "암류"},
  State_120908_Desc = {
    Text = "촉수가 공격할 때 방어될 경우, 스택 수만큼의 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  State_120908_Name = {Text = "암류"},
  State_120910_Desc = {
    Text = "이 카드의 행동력 소모가 [StateArg5] 증가하며, 사용 후 [StateArg4]장의 카드를 드로우한다."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:미사그 배지>"
  },
  State_120924_Desc = {
    Text = "다음 턴 시작 시, 보강을 획득한다."
  },
  State_120924_Name = {
    Text = "지연 보강"
  },
  State_120929_Desc = {
    Text = "카드가 유지를 획득하지만, 사용 후 오염을 제거하고 「심해 분열체」 1개를 소환한다. 소환할 자리가 없으면 「예비 소환: 심해 분열체」 1스택을 획득한다."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:도해자의 저주>"
  },
  State_120930_Desc = {
    Text = "빈 자리가 있다면, 행동 후 1스택을 잃고 「심해 분열체」 1개를 소환한다."
  },
  State_120930_Name = {
    Text = "상호 계약: 심해 분열체"
  },
  State_120934_Desc = {
    Text = "치명타 피해를 받을 때마다, 3%의 <Baojidikang:임시 치명타 저항>을 획득. 매 턴 시작 시 카드 2장에 「<SeastriderCurse:도해자 저주>」를 부여."
  },
  State_120934_Name = {
    Text = "심해 제사"
  },
  State_120941_Desc = {
    Text = "적의 스킬을 강화시킨다. 피해를 받을 때마다 1스택을 잃는다."
  },
  State_120941_Name = {
    Text = "피의 맹세"
  },
  State_121006_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 은열쇠 충전, 광기 폭발이 주는 최종 피해 및 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_121006_WeaponDesc = {
    Text = "장착한 깨어남체의 은열쇠 충전, 광기 폭발이 주는 최종 피해 및 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_121014_Name = {
    Text = "성태의 보호"
  },
  State_121015_Desc = {
    Text = "턴 시작 시 실타래드가 제거되지 않는다. 실타래드를 보유하고 있을 때 <ReinforcePVEKeywords:보강> 50스택을 보유한다. 실타래드가 파괴되면 <ReinforcePVEKeywords:보강>이 제거된다."
  },
  State_121015_Name = {
    Text = "성태의 보호"
  },
  State_121151_Desc = {
    Text = "카드가 유지를 획득하지만, 사용 후 오염을 제거하고 「심해 분열체」 1개를 소환한다. 소환할 자리가 없으면 「예비 소환: 심해 분열체」 1스택을 획득한다."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:도해자의 저주>"
  },
  State_121210_Name = {
    Text = "전체 적에게 부정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여, 2회 발동"
  },
  State_121211_Name = {
    Text = "카드 2장을 뽑고 행동력 2pt 획득"
  },
  State_121212_Name = {
    Text = "전체 아군에게 긍정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여, 2회 발동"
  },
  State_121213_Desc = {
    Text = "모든 피해를 면역한다."
  },
  State_121213_Name = {
    Text = "모든 피해 면역"
  },
  State_121231_Desc = {
    Text = "스택당 다음 「망상의 왕녀」가 부여하는 「강생 의식」이 20% 증가하며, 최대 5스택까지 중첩된다. 5스택 달성 후 다음 「망상의 왕녀」의 피해 횟수가 2배로 증가한다."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:명계>"
  },
  State_121365_Desc = {
    Text = "추가로 [Layer]%의 촉수 피해를 받는다."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:유지>: 매 턴 시작 시 은열쇠 에너지 500pt 획득"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:유지>: 모든 깨어남체의 HP 회복 및 실타래드 40% 증가"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:유지>: 모든 깨어남체의 광기 획득량 50% 증가"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:여파>: 카드 1장 뽑고, 임시 <PowerIconKeywords:힘> [DescArg1]pt 획득"
  },
  State_121734_Desc = {
    Text = "명령 카드 1장을 사용할 때마다, 해당 깨어남체의 행동력 소모가 가장 낮은 카드 1장을 버린다."
  },
  State_121734_Name = {
    Text = "광란의 격류"
  },
  State_121735_Desc = {
    Text = "모든 명령 카드의 행동력 소모가 1 증가한다. 매 3턴마다 턴 종료 시 「점점 석화됨」 1장을 손에 넣는다."
  },
  State_121735_Name = {
    Text = "비탄의 격류"
  },
  State_121736_Desc = {
    Text = "턴 종료 시, 잃은 HP의 10%를 회복하고, 자신의 부정 상태와 플레이어의 긍정 상태를 해제한다."
  },
  State_121736_Name = {
    Text = "강림의 격류"
  },
  State_121737_Desc = {
    Text = "전투 시작 시, 임시 장벽 15스택을 획득한다. 턴 종료 시, 임시 장벽 15스택을 획득하고, 무작위 카드 10장에 「임시 용해」를 부여한다."
  },
  State_121737_Name = {
    Text = "살을 에는 급류"
  },
  State_121738_Desc = {
    Text = "깨어남체가 부여하는 힘 효과가 75% 감소한다. HP를 잃을 때마다 [DescArg1]의 실타래드와 임시 보강 1스택을 획득한다."
  },
  State_121738_Name = {
    Text = "이단의 격류"
  },
  State_121739_Desc = {
    Text = "모든 깨어남체의 광기 상한이 50% 증가한다. 매 턴 종료 시, 모든 깨어남체의 광기 10을 차감하고, 자신은 최대 HP의 3%를 회복한다."
  },
  State_121739_Name = {
    Text = "공포의 격류"
  },
  State_121740_Desc = {
    Text = "전투 시작 및 매 턴 종료 시, 임시 <ResentChainsKeywords:원한의 사슬> 2층을 획득합니다."
  },
  State_121740_Name = {
    Text = "기괴한 격류"
  },
  State_121797_Desc = {
    Text = "가하는 모든 피해, 치유 및 보호막 효과가 10% 감소합니다. 상한 2층, 해제 불가. 치취의 마지막 시전자가 사망하면 피시전자의 모든 치취가 제거됩니다."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:치취>"
  },
  State_121798_Desc = {
    Text = "가하는 피해, 치유 및 방어막 효과가 [DescArg1]% 감소하며, 해제 불가. 최대 2스택.\n<StatusApplier:> 처치 후 제거됨."
  },
  State_121798_Name = {Text = "치취"},
  State_121799_Name = {
    Text = "제4장 레무리아 지원 카드"
  },
  State_121850_Desc = {
    Text = "촉수 피해가 80% 감소한다."
  },
  State_121850_Name = {
    Text = "골리아·지원"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:여파>: 카드 2장 뽑기"
  },
  State_121878_Name = {
    Text = "역전 저주 스토리 최초 선택"
  },
  State_122428_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_122428_Name = {
    Text = "미깨어남"
  },
  State_122431_Desc = {
    Text = "무셰트가 방어되지 않은 피해를 입힐 때, <Monster_Fervor:임시 열광> 2스택을 획득한다."
  },
  State_122431_Name = {
    Text = "안개 속의 유적"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 <PVPReciprocalKeywords:카운트다운 순간> 3스택을 획득한다."
  },
  State_122441_Name = {
    Text = "카운트다운 순간"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 방어막 <Block:[Block:StateArg1]>과 광기를 <Energy:[Energy:StateArg1]> 획득한다. 턴 종료 시 해당 명륜은 자동 해제되며, 다음에 「상자 속의 천진난만」을 장착할 때 획득하는 광기와 방어막이 [StateArg2] 증가한다."
  },
  State_122442_Name = {
    Text = "상자 속의 천진난만"
  },
  State_122443_Desc = {
    Text = "턴 시작 시 스택이 1 감소하며, 스택 소진 시 자신의 부정 상태를 해제하고 광기 100을 획득한 후, 다시 3스택의 카운트다운 순간을 획득한다. 명륜 교체 시 카운트다운 순간 상태를 잃는다."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:카운트다운>"
  },
  State_122596_Desc = {
    Text = "카드를 사용할 수 없으며, 광기 폭발을 발동할 수 없다."
  },
  State_122596_Name = {
    Text = "<Seal1:봉인>"
  },
  State_122636_Desc = {
    Text = "매 턴 첫 번째로 사용하는 「스킬」의 피해, 치유 및 실타래드가 [StateArg1]% 증가한다."
  },
  State_122636_Name = {
    Text = "루비 브로치"
  },
  State_122650_Desc = {
    Text = "유물 <OrangeQuality:마술 장갑>이 이 카드를 추가했다."
  },
  State_122650_Name = {
    Text = "이상한 카드"
  },
  State_122654_Name = {
    Text = "매 턴 시작 및 행동 종료 시 빈 플레이어 덱을 리셋하려고 시도하며, 비어 있지 않으면 리셋하지 않는다.「개발 전용」"
  },
  State_122706_Name = {
    Text = "<CardKeyWord:재회 소원>"
  },
  State_122707_Desc = {
    Text = "이번 턴 내 마지막으로 사용한 「스킬」로 간주하며, 행동력 소모 -2, 두 번째 덱의 맨 위에 놓습니다."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:재회 소원>"
  },
  State_123109_Desc = {
    Text = "팀 유일: 「융흔」에서 「각인」을 최초로 구매하거나, 「잿더미 유적」에서 할인 상품을 최초로 구매할 때 필요한 검은 인장이 <WeaponEffect_Num:[StateArg1]%> 확률로 0이 된다. 각 탐색에서 최대 1회 발동한다."
  },
  State_123109_WeaponDesc = {
    Text = "「융흔」에서 「각인」을 최초로 구매하거나, 「잿더미 유적」에서 할인 상품을 최초로 구매할 때 필요한 검은 인장이 <WeaponEffect_Num:[StateArg1]%> 확률로 0이 된다. 각 탐색에서 최대 1회 발동한다."
  },
  State_123177_Desc = {
    Text = "턴 시작 시 초기화된다. 10스택에 도달하면, 다음에 카드를 사용한 후 무셰트가 즉시 행동하여 「임시 열광」을 제거하고 의도 「인간 폭발」을 추가한다."
  },
  State_123177_Name = {
    Text = "임시 열광"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang:죽음 저항>의 HP 회복 효과가 5배로 증가한다. 적이 카드를 1장 사용할 때마다, 자신이 <Monster_Fervor:임시 열광> 1스택을 획득한다."
  },
  State_123178_Name = {
    Text = "모닝 성깔"
  },
  State_123243_Desc = {
    Text = "적 처치 시 전체 층수를 제거하고 동일한 양의 광기를 획득합니다."
  },
  State_123243_Name = {Text = "와류"},
  State_123246_Desc = {
    Text = "적 처치 시 모든 층수를 제거하고 동일한 양의 광기를 획득합니다."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:와류>"
  },
  State_123294_Desc = {
    Text = "이번 턴에 「타격」으로 [DescArg1]장의 카드를 드로우했다."
  },
  State_123294_Name = {Text = "광학"},
  State_123507_Desc = {
    Text = "팀 유일: 탐색 시작 후, 「카운트다운 순간: 5」 1장을 덱에 추가한다. 「카운트다운 순간: 5」: 사용 후 카드 1장을 드로우하고, 다음 「카운트다운 순간」을 버린 카드 더미에 섞어 넣는다. 「<DestructionKeywords:폐기>」. 「카운트다운 순간: 0」: 카드 3장을 드로우하고 행동력 3을 획득하며, <WeaponEffect_Num:[StateArg1]%> 확률로 「카운트다운 순간: 5」를 버린 카드 더미에 섞어 넣는다. 유지. 「<DestructionKeywords:폐기>」."
  },
  State_123507_WeaponDesc = {
    Text = "탐색 시작 후, 「카운트다운 순간: 5」 1장을 덱에 추가한다. 「카운트다운 순간: 5」: 사용 후 카드 1장을 드로우하고, 다음 「카운트다운 순간」을 버린 카드 더미에 섞어 넣는다. 「<DestructionKeywords:폐기>」. 「카운트다운 순간: 0」: 카드 3장을 드로우하고 행동력 3을 획득하며, <WeaponEffect_Num:[StateArg1]%> 확률로 「카운트다운 순간: 5」를 버린 카드 더미에 섞어 넣는다. 유지. 「<DestructionKeywords:폐기>」."
  },
  State_123520_Desc = {
    Text = "팀 유일: 매 턴 처음으로 열쇠 지령을 발동한 후, <WeaponEffect_Num:[StateArg1]%> 확률로 장착한 깨어남체의 「타격」 1장을 드로우한다."
  },
  State_123520_WeaponDesc = {
    Text = "매 턴 처음으로 열쇠 지령을 발동한 후, <WeaponEffect_Num:[StateArg1]%> 확률로 장착한 깨어남체의 「타격」 1장을 드로우한다."
  },
  State_123521_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 광기 폭발과 추격 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 이번 턴에 임의의 깨어남체의 「타격」을 사용한 후, 장착한 깨어남체의 「타격」 피해가 장착한 깨어남체의 공격력의 <WeaponEffect_Num:[StateArg2]%>만큼 임시로 증가하며, 매 턴 최대 8회 발동된다."
  },
  State_123521_WeaponDesc = {
    Text = "장착한 깨어남체의 광기 폭발과 추격 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 이번 턴에 임의의 깨어남체의 「타격」을 사용한 후, 장착한 깨어남체의 「타격」 피해가 임시로 <WeaponEffect_Num:[DescArg2]> 증가하며, 매 턴 최대 8회 발동된다."
  },
  State_123810_Desc = {
    Text = "적의 현재 의도를 「행동 불가」로 대체한다."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:기절>"
  },
  State_123812_Desc = {
    Text = "턴 종료 시, 행동력 소모가 감소한다."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:예비>"
  },
  State_123994_Desc = {
    Text = "어떤 행동도 할 수 없다."
  },
  State_123994_Name = {
    Text = "정제된 수면"
  },
  State_124010_Desc = {
    Text = "다음 턴 시작 시, [Layer]의 행동력을 획득한다."
  },
  State_124010_Name = {
    Text = "지연 행동력"
  },
  State_124024_Desc = {
    Text = "이번 턴에 [Layer]장의 타격을 사용했으며, [DescArg1]회 「극적인 만남」이 발동되었다."
  },
  State_124024_Name = {
    Text = "극적인 만남"
  },
  State_124034_Desc = {
    Text = "모든 깨어남체의 「타격」 피해가 [StateArg1] 증가하며, [Layer]턴 동안 지속된다."
  },
  State_124034_Name = {
    Text = "샤이닝☆토네이도"
  },
  State_124037_Desc = {
    Text = "무셰트의 피해 횟수가 1 증가하며, 모든 깨어남체의 「타격」 피해가 [StateArg1] 증가하고, [Layer]턴 동안 지속된다."
  },
  State_124037_Name = {
    Text = "샤이닝☆토네이도"
  },
  State_124107_Desc = {
    Text = "「별의 새싹」이 사망하면 모든 피해에 면역되고 깨어남하며, 최대 HP가 2배로 증가하고 남은 HP와 동일한 최대 HP를 추가로 획득한다. 깨어남 후 모든 부정 상태를 해제한다."
  },
  State_124107_Name = {
    Text = "미깨어남"
  },
  State_124108_Name = {
    Text = "경계 외의 소리 카운터"
  },
  State_124109_Desc = {
    Text = "자신이 획득한 <RetaliateIconKeywords:반격>이 추가로 5%의 <PowerIconKeywords:힘> 보너스를 받는다. 단일 턴 내에 [DescArg1]의 HP를 잃은 후, 「노래자」와 위치를 교환한다."
  },
  State_124109_Name = {
    Text = "재생 포대기"
  },
  State_124111_Desc = {
    Text = "죽음 저항의 HP 회복 효과가 25%로 증가한다. 적이 명령 카드를 1장 사용할 때마다, <PowerIconKeywords:힘>을 [DescArg1] 임시로 탈취한다."
  },
  State_124111_Name = {
    Text = "무한한 별빛"
  },
  State_124112_Desc = {
    Text = "「노래자」가 사망하면 모든 피해에 면역되고 깨어남하며, 최대 HP가 2배로 증가하고 남은 HP와 동일한 최대 HP를 추가로 획득한다."
  },
  State_124112_Name = {
    Text = "미깨어남"
  },
  State_124113_Desc = {
    Text = "상대 턴 종료 시 손패를 버리지 않는다. 턴 종료 시 순서대로 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <HeavyInjuryKeywords:중상>, <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  State_124113_Name = {
    Text = "경계 외의 소리"
  },
  State_124115_Desc = {
    Text = "가하는 <FragileIconKeywords:손상>, <HeavyInjuryKeywords:치명타>, <WeaknessIconKeywords:허약>이 50%로 심화됩니다. <SlowIconKeywords:둔화> 카드를 [DescArg1]장 더 사용한 후, 「별의 새싹」과 위치를 교환합니다."
  },
  State_124115_Name = {
    Text = "행성 여행자"
  },
  State_124121_Name = {
    Text = "행성 여행자 카운터"
  },
  State_124122_Name = {
    Text = "행성 여행자 플레이어 감청"
  },
  State_124190_Desc = {
    Text = "자신이 획득한 <RetaliateIconKeywords:반격>이 추가로 5%의 <PowerIconKeywords:힘> 보너스를 받는다."
  },
  State_124190_Name = {
    Text = "재생 포대기"
  },
  State_124193_Name = {
    Text = "죽음 저항 HP 회복량 25%로 증가"
  },
  State_124198_Desc = {
    Text = "가하는 <FragileIconKeywords:손상>, <HeavyInjuryKeywords:치명타> 및 <WeaknessIconKeywords:허약>이 50%로 심화됩니다."
  },
  State_124198_Name = {
    Text = "행성 여행자"
  },
  State_124277_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124277_Name = {
    Text = "출력값 2"
  },
  State_124278_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124278_Name = {
    Text = "출력값 4"
  },
  State_124279_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124279_Name = {
    Text = "출력값 5"
  },
  State_124280_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124280_Name = {
    Text = "출력값 1"
  },
  State_124282_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124282_Name = {
    Text = "출력값 7"
  },
  State_124283_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124283_Name = {
    Text = "출력값 8"
  },
  State_124284_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124284_Name = {
    Text = "출력값 9"
  },
  State_124285_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124285_Name = {
    Text = "출력값 10"
  },
  State_124286_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124286_Name = {
    Text = "출력값 6"
  },
  State_124287_Desc = {
    Text = "실타래행 과정의 중간값을 가시화한다."
  },
  State_124287_Name = {
    Text = "출력값 3"
  },
  State_124736_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124736_Name = {
    Text = "감청 테스트 1"
  },
  State_124747_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124747_Name = {
    Text = "감청 테스트 2"
  },
  State_124748_Desc = {
    Text = "적이 <BurningKeywords:연소> 카드를 사용할 때, 자신에게 <MonsterExFlameKeywords:폭염> 1스택을 부여하지만, <PowerIconKeywords:힘>이 [DescArg1] 임시로 감소한다."
  },
  State_124748_Name = {
    Text = "꺼지지 않는 불꽃"
  },
  State_124752_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124752_Name = {
    Text = "감청 테스트 3"
  },
  State_124753_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124753_Name = {
    Text = "감청 테스트 4"
  },
  State_124754_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124754_Name = {
    Text = "감청 테스트 5"
  },
  State_124765_Desc = {
    Text = "치명타율이 [Layer]% 증가한다."
  },
  State_124765_Name = {
    Text = "치명타율"
  },
  State_124766_Desc = {
    Text = "이번 전투 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_124766_Name = {
    Text = "치명타율"
  },
  State_124766_WeaponDesc = {
    Text = "이번 전투 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_124767_Desc = {
    Text = "치명타 피해가 [Layer]% 증가한다."
  },
  State_124767_Name = {
    Text = "치명타 피해"
  },
  State_124811_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124811_Name = {
    Text = "감청 테스트 8"
  },
  State_124812_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124812_Name = {
    Text = "감청 테스트 7"
  },
  State_124813_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124813_Name = {
    Text = "감청 테스트 6"
  },
  State_124826_Desc = {
    Text = "BEAttachPostAction 인터페이스의 매개변수 3이 올바르게 필터링되었는지 또는 해당 트리거를 발동하는지 확인한다."
  },
  State_124826_Name = {
    Text = "감청 테스트 9"
  },
  State_124843_Desc = {
    Text = "트리거 BSTAfterAttachPostAction 및 BSTAfterDoActiveDamage.AttachPostAction의 감지를 검증한다."
  },
  State_124843_Name = {
    Text = "감청 테스트 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체의 스킬 카드를 사용한 후, [StateArg1]장의 카드를 드로우하며, 다른 깨어남체의 카드를 우선적으로 드로우한다. 매 턴 최대 1회 발동한다."
  },
  State_124886_Name = {
    Text = "숙명의 물레"
  },
  State_124887_Desc = {
    Text = "해당 깨어남체의 「짜기」 피해 횟수가 [Layer] 증가합니다."
  },
  State_124887_Name = {Text = "직조"},
  State_124888_Desc = {
    Text = "카드를 사용할 때마다 적의 손에 있는 무작위 「스킬」로 변화하며, 그 행동력 소모를 -2 합니다."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:예언>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 다음에 사용하는 [StateArg1]장의 「스킬」이 2회 발동한다."
  },
  State_124890_Name = {
    Text = "영원한 직조의 그물"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:예언>"
  },
  State_124916_Desc = {
    Text = "턴 종료 시 모든 스택을 제거하고 [DescArg1] 의 순수 피해를 입힌다. 해제 불가."
  },
  State_124916_Name = {
    Text = "운명의 전조"
  },
  State_124917_Desc = {
    Text = "턴 종료 시 모든 스택을 제거하고 순수 피해를 입힌다. 해제 불가."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:운명의 전조>"
  },
  State_124992_Desc = {
    Text = "다음 [DescArg1] 장 「스킬」을 2회 사용."
  },
  State_124992_Name = {
    Text = "이중 발사"
  },
  State_124993_Desc = {
    Text = "주고받은 치명적인 능동 피해를 각각 동일한 수치의 <PVPDestinedDeathKeyWords:운명의 전조> 부여로 대체한다. 해제할 수 없다."
  },
  State_124993_Name = {
    Text = "운명, 이로써 고하노라"
  },
  State_124997_Desc = {
    Text = "가하거나 받는 치명적인 능동 피해를 동일한 양의 <PVPDestinedDeathKeyWords:운명의 전조>를 부여하는 것으로 대체함. 해제 불가."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:운명, 이로써 고하노라>"
  },
  State_125002_Name = {
    Text = "상태@일반 플레이어 버림 단계 후 실타래드값 감청"
  },
  State_125003_Name = {
    Text = "실타래드값"
  },
  State_125004_Name = {
    Text = "상태@일반 플레이어 실타래드 카운터 적용"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 [StateArg1] 스택 <PVPLostSoulKeyWords:도취>를 부여합니다."
  },
  State_125472_Name = {
    Text = "목련의 미끼"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 다른 아군이 「광기 폭발」한 후, 손에 있는 장착한 깨어남체의 모든 「스킬」의 행동력 소모가 [StateArg1] 감소한다."
  },
  State_125486_Name = {
    Text = "부질없는 찡그림"
  },
  State_125925_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_125925_Name = {
    Text = "미깨어남"
  },
  State_125926_Name = {
    Text = "상태@몬스터 타비 의도 전환 플레이어 감청"
  },
  State_125927_Desc = {
    Text = "[DescArg1]장의 명령 카드를 다시 사용한 후, 의도를 「여섯 날개의 해방」으로 전환한다."
  },
  State_125927_Name = {
    Text = "네 날개 돋기"
  },
  State_125928_Desc = {
    Text = "명령 카드를 사용한 후, 해당 깨어남체의 광기 폭발과 모든 명령 카드를 2턴간 봉인한다."
  },
  State_125928_Name = {
    Text = "시공을 가르는 날개"
  },
  State_125929_Desc = {
    Text = "단일 턴 내에 [DescArg1]의 피해를 받은 후, 임시 <ReinforceColour:보강> 70스택과 <ResentChainsKeywords:원한의 사슬> 1스택을 획득한다."
  },
  State_125929_Name = {
    Text = "존재하지 않는 존재"
  },
  State_125933_Desc = {
    Text = "[DescArg1]장의 명령 카드를 추가로 사용한 후, 의도를 「네 날개의 성장」로 전환한다."
  },
  State_125933_Name = {
    Text = "두 날개의 맥동"
  },
  State_125934_Desc = {
    Text = "행동력을 소모할 때 획득하는 은열쇠 에너지가 50% 감소한다. 타비가 방어되지 않은 피해를 입힌 후, 「<DerivativeCardKeywords_131:진·윤회 역설>」 1장을 손에 넣는다."
  },
  State_125934_Name = {
    Text = "은열쇠의 문"
  },
  State_125935_Name = {Text = "침묵"},
  State_125935_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_125937_Desc = {
    Text = "명령 카드를 사용한 후, 해당 깨어남체의 광기 폭발과 모든 명령 카드를 2턴간 봉인한다."
  },
  State_125937_Name = {
    Text = "시공을 가르는 날개"
  },
  State_125964_Desc = {
    Text = "행동력을 소모할 때, 획득하는 은열쇠 에너지가 50% 감소한다. 타비가 방어되지 않은 피해를 입힌 후, 「<DerivativeCardKeywords_131:진·윤회 역설>」 1장을 손에 넣는다."
  },
  State_125964_Name = {
    Text = "은열쇠의 문"
  },
  State_126010_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 잠금 중독 및 중독 발동 효과가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 혈육 계역 자동 회복되는 <EmbryoFusionIconKeywords:배아 융합>이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체가 매 턴 처음으로 「공진」을 발동할 때 다른 깨어남체들이 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_126010_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 잠금 중독 및 중독 발동 효과가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 혈육 계역 자동 회복되는 <EmbryoFusionIconKeywords:배아 융합>이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체가 매 턴 처음으로 「공진」을 발동할 때 다른 깨어남체들이 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_126463_Name = {
    Text = "상태@몬스터 리즈 유혹의 불꽃 피해 감청"
  },
  State_126464_Desc = {
    Text = "상한 10스택, 스택당 리즈가 주는 피해가 [DescArg1] 증가한다."
  },
  State_126464_Name = {
    Text = "<GreenWord:청록색 불씨>"
  },
  State_126465_Name = {
    Text = "몬스터 리즈 의도 감청"
  },
  State_126466_Desc = {
    Text = "상대 턴 종료 시 손패를 버리지 않는다. 의도가 푸른 불꽃으로 전환될 때, <MonsterLizVerdantSpark:청록색 불씨>를 최소 6스택 보유하고 있다면 6스택을 소모하여 의도를 <Damage:[Damage:DescArg1]>의 피해를 [AttackTimes:DescArg2]회 주는 「사멸의 푸른 불꽃」으로 업그레이드한다. 최소 3스택을 보유하고 있다면 3스택을 소모하여 의도를 <Damage:[Damage:DescArg3]>의 피해를 [AttackTimes:DescArg4]회 주는 「부패의 푸른 불꽃」으로 업그레이드한다."
  },
  State_126466_Name = {
    Text = "불멸 녹염"
  },
  State_126467_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작하며, 「고통의 춤」에 부정 상태를 해제하는 능력을 부여한다."
  },
  State_126467_Name = {
    Text = "미깨어남"
  },
  State_126468_Name = {
    Text = "상태@몬스터 리즈 비취 영상 관리"
  },
  State_126469_Desc = {
    Text = "[DescArg1]의 HP를 잃을 때마다 <MonsterLizVerdantSpark:청록색 불씨> [DescArg2]스택을 획득한다."
  },
  State_126469_Name = {
    Text = "비취 영상"
  },
  State_126470_Name = {
    Text = "상태@몬스터 리즈 안내문 카운터"
  },
  State_126479_Desc = {
    Text = "상한 10스택, 리즈가 주는 피해가 증가한다."
  },
  State_126479_Name = {
    Text = "<GreenWord:청록색 불씨>"
  },
  State_126540_Desc = {
    Text = "쉬가 [Layer]회 「공진」을 발동할 때, 「공진」 효과가 2배로 증가한다."
  },
  State_126540_Name = {
    Text = "안개에 묶인 맹세"
  },
  State_126568_Desc = {
    Text = "깨어남체가 능동 피해를 줄 때마다, 촉수 1개로 대상을 공격하여 [Layer]%의 촉수 피해를 입힌다."
  },
  State_126568_Name = {
    Text = "노도의 광란"
  },
  State_126569_Desc = {
    Text = "깨어남체가 능동 피해를 줄 때마다, 촉수 1개로 대상을 공격하여 50%의 촉수 피해를 입힌다."
  },
  State_126569_Name = {
    Text = "노도의 광란"
  },
  State_126643_Desc = {
    Text = "본 상태의 MaxLayer=1. 출처 깨어남체: [DescArg1]"
  },
  State_126643_Name = {
    Text = "제한 1스택"
  },
  State_126644_Desc = {
    Text = "획득 후, [Layer]스택의 시연 상태를 초기화하고 다시 추가한다.\n시연 상태의 최대 스택 수는 1스택이다."
  },
  State_126644_Name = {
    Text = "최대 스택 돌파"
  },
  State_126645_Desc = {
    Text = "라모나가 주는 기본 피해가 [DescArg1]% 증가한다."
  },
  State_126645_Name = {
    Text = "지고의 정련"
  },
  State_126651_Desc = {
    Text = "추격 후 감지가 [Layer]회 충족되었다."
  },
  State_126651_Name = {Text = "카운터"},
  State_126652_Desc = {
    Text = "획득 후, 전방 적에게 후속 행동을 추가하여 현재 의도를 사용하게 한다."
  },
  State_126652_Name = {
    Text = "몬스터 추격시키기"
  },
  State_126653_Desc = {
    Text = "획득 후, 위치 1의 깨어남체에게 후속 행동을 추가하여 해당 깨어남체의 타격 카드를 사용하게 한다."
  },
  State_126653_Name = {
    Text = "깨어남체 추격시키기"
  },
  State_126654_Desc = {
    Text = "지명 감지가 발동될 때, 카운트를 1회 출력한다."
  },
  State_126654_Name = {
    Text = "지명 감청"
  },
  State_126655_Desc = {
    Text = "획득 후, 수호자에게 후속 행동을 추가하여 스킬@주인공 스킬@머릿속의 소리를 사용하게 한다."
  },
  State_126655_Name = {
    Text = "수호자 추격시키기"
  },
  State_126677_Desc = {
    Text = "이번 턴에 [Layer]장의 「오만의 검」이 2회 발동한다."
  },
  State_126677_Name = {
    Text = "태고의 고래 울음"
  },
  State_126678_WeaponDesc = {
    Text = "고래 도약의 모든 피해 횟수가 1 증가한다."
  },
  State_126714_Desc = {
    Text = "아이기스의 다음 [Layer]장의 「방어」가 3회 발동한다."
  },
  State_126714_Name = {
    Text = "응고된 눈물"
  },
  State_126714_WeaponDesc = {
    Text = "고래 도약의 모든 피해 횟수가 1 증가한다."
  },
  State_126715_WeaponDesc = {
    Text = "고래 도약의 모든 피해 횟수가 1 증가한다."
  },
  State_126776_Desc = {
    Text = "스택당 받는 잠금 중독이 5% 증가하며, 주는 피해가 [DescArg1]% 감소한다. 최대 [DescArg2]스택까지 중첩된다."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:치취>"
  },
  State_126783_Name = {
    Text = "임시 폐기"
  },
  State_126784_Desc = {
    Text = "받는 잠금 중독이 [DescArg1]% 증가하며, 주는 피해가 [DescArg2]% 감소한다. 최대 [DescArg3]스택까지 중첩된다."
  },
  State_126784_Name = {Text = "치취"},
  State_126785_Desc = {
    Text = "다른 깨어남체가 누적 X장의 명령 카드를 사용한 경우, 사용 후 후속 효과가 발동된다. 자신의 명령 카드를 사용하거나 턴 종료 후 자신의 공진 카운트가 초기화된다."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:공진 X>"
  },
  State_126789_Desc = {
    Text = "모든 적에게 <WitherKeywords:치취> 2스택을 부여한다."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:상약>"
  },
  State_126790_Desc = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1스택 제거할 때마다 대상 최대 HP의 [DescArg1]% <FixedDamage:순수 피해>를 가하고 40% 중독을 발동합니다."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:탈백>"
  },
  State_126803_Desc = {
    Text = "다음에 사용하는 [DescArg1]장의 명령 카드는 3턴 후의 미래로 보내진다."
  },
  State_126803_Name = {
    Text = "운명의 물레"
  },
  State_126893_Name = {
    Text = "상태@운명 초차원 순수 표식"
  },
  State_126895_Desc = {
    Text = "이 카드가 가하는 피해, 고정 힘과 촉수 데미지 증가, 고정 중독, 고정 반격의 최종 효과가 [DescArg1]% 증가하고, 가하는 고정 방어막, 고정 HP 회복, 힘 감소 효과가 [DescArg2]% 증가합니다. 「특이점 비콘」을 가진 카드는 더 이상 「초차원 공간」에 복사될 수 없습니다."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:특이점 비콘 [DescArg2]>"
  },
  State_126896_Name = {
    Text = "상태@초월의 빛 카드 행동력 조화 스택 감소"
  },
  State_126900_Name = {
    Text = "상태@운명 초차원 직업 초기화 2"
  },
  State_126901_Name = {
    Text = "상태@운명 초차원 직업 초기화 1"
  },
  State_126903_Name = {
    Text = "상태@초차원 공간 초거리 표식"
  },
  State_126927_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 잠금 중독 및 중독 발동 효과가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 매 턴 처음으로 「공진」을 발동할 때 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다."
  },
  State_126927_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 잠금 중독 및 중독 발동 효과가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 매 턴 처음으로 「공진」을 발동할 때 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:중독>"
  },
  State_127108_Desc = {
    Text = "모든 적에게 <WitherKeywords:치취> 5스택을 부여한다."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:상약>"
  },
  State_127109_Desc = {
    Text = "모든 적의 <WitherKeywords:도취>를 제거하며, 1스택 제거할 때마다 체력의 20%에 해당하는 진홍빛 용광로를 쌓고, 대상 최대 HP의 [DescArg1]% <FixedDamage:순수 피해>를 가하며 40% 중독을 발동합니다."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:탈백>"
  },
  State_127176_Desc = {
    Text = "스택당 받는 잠금 중독이 5% 증가하며, 주는 피해가 [DescArg1]% 감소한다. 최대 [DescArg2]스택까지 중첩된다."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:치취>"
  },
  State_127264_Desc = {
    Text = "이 카드를 사용할 때, 「각자」는 <MonsterTimeBeacon:회귀> 1스택을 획득한다. 이 카드를 버릴 경우, 「각자」는 <MonsterTimeBeacon:회귀> 1스택을 잃는다."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:초월의 눈>"
  },
  State_127266_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_127266_Name = {
    Text = "미깨어남"
  },
  State_127267_Desc = {
    Text = "턴 종료 후, <MonsterTimeBeacon:회귀> 1스택을 획득한다."
  },
  State_127267_Name = {
    Text = "음엔트로피 역전"
  },
  State_127271_Desc = {
    Text = "열쇠 지령 발동 후, 자신이 <MonsterTimeBeacon:회귀> 1스택을 획득한다."
  },
  State_127271_Name = {
    Text = "뫼비우스 죄수"
  },
  State_127272_Desc = {
    Text = "상한 3스택. 「각자」가 의도를 발동할 때 <MonsterTimeBeacon:회귀> 3스택을 보유하고 있다면, <MonsterTimeBeacon:회귀> 효과가 발동되고 <MonsterTimeBeacon:회귀>가 초기화되며 부정 상태가 제거된다."
  },
  State_127272_Name = {
    Text = "<WhiteWord:회전>"
  },
  State_127275_Desc = {
    Text = "스택당 받는 잠금 중독이 5% 증가하며, 주는 피해가 [DescArg1]% 감소한다. 최대 [DescArg2]스택까지 중첩된다."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:치취>"
  },
  State_127276_Desc = {
    Text = "이 카드를 사용할 때, 「각자」는 <MonsterTimeBeacon:회귀> 1스택을 획득한다. 이 카드를 버릴 경우, 「각자」는 <MonsterTimeBeacon:회귀> 1스택을 잃는다."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:초월의 눈>"
  },
  State_127312_Desc = {
    Text = "깨어남체의 인격 심화가 +12에 도달하면 「최종 법칙」이 활성화되며, 활성화 후 일부 고유한 효과를 획득할 수 있다."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:최종 법칙>"
  },
  State_127705_Desc = {
    Text = "카드가 조작되었습니다! 사용 후 [Layer] 피해를 받으며, <CardKeyWord:암중 파괴> 스택이 절반으로 줄어듭니다."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:암중 파괴>"
  },
  State_127705_WeaponDesc = {
    Text = "카드를 사용한 후 [StateArg1]의 피해를 받는다."
  },
  State_127708_Desc = {
    Text = "적이 비명령 카드를 사용한 후, 모든 아군이 [DescArg1]스택의 <PowerIconKeywords:힘>을 획득한다. 옛날 잔재가 파괴된 후 효과가 사라진다."
  },
  State_127708_Name = {
    Text = "혼란의 실타래"
  },
  State_127709_Name = {
    Text = "검은 실타래 플레이어 상태"
  },
  State_127710_Name = {
    Text = "검은 실타래 발동"
  },
  State_128026_Name = {
    Text = "흰 실타래 플레이어 상태"
  },
  State_128027_Desc = {
    Text = "적이 명령 카드를 사용한 후, 모든 아군이 [DescArg1]스택의 임시 <ReinforcePVEKeywords:보강>을 획득한다. 옛날 잔재가 파괴된 후 효과가 사라진다."
  },
  State_128027_Name = {
    Text = "율법의 실타래"
  },
  State_128028_Desc = {
    Text = "카드가 조작되었습니다! 사용 후 <FixedDamage:순수 피해>를 받으며, <BrokenCard:암중 파괴> 스택이 절반으로 줄어듭니다."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:암중 파괴>"
  },
  State_128028_WeaponDesc = {
    Text = "카드를 사용한 후 [StateArg1]의 피해를 받는다."
  },
  State_128029_Name = {
    Text = "흰 실타래 발동"
  },
  State_128067_Name = {
    Text = "상태@냉거미 시녀 잔여 감청"
  },
  State_128069_Name = {
    Text = "상태@냉거미 시녀 엉킴 명중 검사"
  },
  State_128071_Name = {
    Text = "상태@냉거미 시녀 전방 위치 소환 표식 필요"
  },
  State_128073_Desc = {
    Text = "매 행동 종료 후 <ParcloseIconKeywords:장벽> [DescArg1]스택과 <Chapter5_Monster_Fervor1:열광> [DescArg2]스택을 획득한다."
  },
  State_128073_Name = {
    Text = "직모의 요람"
  },
  State_128082_Desc = {
    Text = "사용 후 하멜른이 광기 3을 획득한다."
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:기합 선율>"
  },
  State_128086_Desc = {
    Text = "적이 명령 카드를 사용한 후, 자신이 <Chapter5_Monster_Fervor1:열광> [DescArg1]스택을 획득하고, 「옛날 잔재」를 파괴한 후 후열 아군과 위치를 교환한다."
  },
  State_128086_Name = {
    Text = "숙명 윤전"
  },
  State_128087_Name = {
    Text = "상태@냉거미 시녀 백색 윤회 발동 표식"
  },
  State_128089_Name = {
    Text = "백색 윤회 발동"
  },
  State_128216_Name = {
    Text = "백색 윤회 플레이어 상태"
  },
  State_128245_Desc = {
    Text = "턴 시작 시 초기화된다. 10스택에 도달하면, 다음에 카드를 사용한 후 즉시 행동하여 <Chapter5_Monster_Fervor2:열광>을 제거하고, 의도를 <FragileIconKeywords:손상>을 부여하며 <BrokenCard:암중 파괴>를 무작위로 부여하는 「붕괴의 실타래」로 전환한다."
  },
  State_128245_Name = {
    Text = "임시 열광"
  },
  State_128246_Name = {
    Text = "흑색 윤회 플레이어 상태"
  },
  State_128247_Desc = {
    Text = "사망 후 부활하며, 피해를 면역하고 HP 100%를 보유한다. 의도를 「운명의 열광」으로 전환한다: 매 행동 종료 후 <PowerIconKeywords:힘> [DescArg1]pt와 <Chapter5_Monster_Fervor2:열광> [DescArg2]스택을 획득한다."
  },
  State_128247_Name = {
    Text = "우화 신생"
  },
  State_128248_Desc = {
    Text = "턴 시작 시 초기화된다. 10스택에 도달하면, 다음에 카드를 사용한 후 즉시 행동하여 <Chapter5_Monster_Fervor1:열광>을 제거하고, 의도를 <WeaknessIconKeywords:허약>을 부여하며 명령 카드를 무작위로 봉인하는 「속박의 그물」로 전환한다."
  },
  State_128248_Name = {
    Text = "임시 열광"
  },
  State_128250_Name = {
    Text = "흑색 윤회 발동"
  },
  State_128251_Desc = {
    Text = "적이 비명령 카드를 사용할 때, 자신이 <Chapter5_Monster_Fervor2:열광> [DescArg1]스택을 획득하고, 「옛날 잔재」를 파괴한 후 후열 아군과 위치를 교환한다."
  },
  State_128251_Name = {
    Text = "연옥 윤전"
  },
  State_128253_Desc = {
    Text = "사망 후 부활하며, 피해를 면역하고 HP 100%를 보유한다. 의도를 「운명의 열광」으로 전환한다: 매 행동 종료 후 <ParcloseIconKeywords:장벽> [DescArg1]스택과 <Chapter5_Monster_Fervor1:열광> [DescArg2]스택을 획득한다."
  },
  State_128253_Name = {
    Text = "우화 신생"
  },
  State_128257_Desc = {
    Text = "매 행동 종료 후 <PowerIconKeywords:힘> [DescArg1]pt와 <Chapter5_Monster_Fervor2:열광> [DescArg2]스택을 획득한다."
  },
  State_128257_Name = {
    Text = "직모의 속삭임"
  },
  State_128643_Name = {
    Text = "상태@플레이어 이번 턴 증상 사용 카운터"
  },
  State_128644_Desc = {
    Text = "턴 시작 시 초기화된다. 10스택에 도달하면, 다음에 카드를 사용한 후 즉시 행동하여 <Chapter5_Monster_Fervor3:열광>을 제거하고 무작위로 의도를 전환한다."
  },
  State_128644_Name = {
    Text = "임시 열광"
  },
  State_128645_Desc = {
    Text = "의도는 네 가지 중에서 무작위로 선택되지만 반복되지 않는다. 광기 폭발 발동 후 즉시 의도를 전환한다. 명령 카드를 사용한 후 <Chapter5_Monster_Fervor3:열광> 1스택을 획득한다."
  },
  State_128645_Name = {
    Text = "만면 동조"
  },
  State_128646_Name = {
    Text = "상태@혼란된 운명 실타래격 강타 카드 사용 검사"
  },
  State_128648_Desc = {
    Text = "다음 턴 시작 시까지, 명령 카드를 1장 사용할 때마다 [DescArg1]의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  State_128648_Name = {
    Text = "폭노의 고치"
  },
  State_128692_Desc = {
    Text = "능동 피해 또는 촉수 피해를 받은 후, 받은 피해량만큼 「옛날 잔재」를 제거하고 제거량의 300%만큼 HP를 잃는다. 기타 피해를 받을 때는 절반을 제거한다. 「옛날 잔재」 스택은 매 턴 초기화된다."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:옛날 잔재>"
  },
  State_128695_Name = {
    Text = "상태@혼란된 운명 의도 표식"
  },
  State_129297_Desc = {
    Text = "다음 [Layer]번째 전투 시작 시 모든 적의 HP를 1로 만든다."
  },
  State_129297_Name = {
    Text = "소 「N」의 협력"
  },
  State_129569_Name = {
    Text = "상태@혼란된 운명 환희 극장 발동 표식"
  },
  State_129570_Name = {
    Text = "상태@혼란된 운명 숙명 속삭임 발동 표식"
  },
  State_129571_Name = {
    Text = "상태@혼란된 운명 끝없는 공허 발동 표식"
  },
  State_129612_Desc = {
    Text = "의도는 네 가지 중에서 무작위로 선택되지만 반복되지 않는다. 광기 폭발 발동 후 즉시 의도를 전환한다. 명령 카드를 사용한 후 <Chapter5_Monster_Fervor3:열광> 1스택을 획득한다."
  },
  State_129612_Name = {
    Text = "만면 동조"
  },
  State_129625_Desc = {
    Text = "의도는 네 가지 중에서 무작위로 선택되지만 반복되지 않는다. 광기 폭발 발동 후 즉시 의도를 전환한다. 명령 카드를 사용한 후 <Chapter5_Monster_Fervor3:열광> 1스택을 획득한다. 의도를 전환할 때마다 「착란 운명」 1스택을 획득한다."
  },
  State_129625_Name = {
    Text = "만면 동조"
  },
  State_129643_Desc = {
    Text = "의도를 전환할 때마다 1스택을 획득하며, 「착란 운명」이 10스택에 도달하면 의도가 전환 불가능하며 큰 피해와 약화를 주는 「파견광연」으로 조정된다."
  },
  State_129643_Name = {
    Text = "착란 운명"
  },
  State_129644_Name = {
    Text = "왜곡 융합 의도 잠금"
  },
  State_129650_Desc = {
    Text = "팀 유니크: 장착자가 각성체 「회귀·라모나」인 경우, 다른 각성체가 탐색 스테이지에서 획득하는 동조율이 <WeaponEffect_Num:[StateArg1]%> 증가하지만, 자신은 동조율을 획득하지 않습니다."
  },
  State_129650_WeaponDesc = {
    Text = "장착한 깨어남체가 깨어남체 「순행·라모나」일 경우, 스테이지 완료 시 다른 깨어남체들이 획득하는 동조율이 <WeaponEffect_Num:[StateArg1]%> 증가하지만, 자신은 동조율을 획득하지 않는다."
  },
  State_129761_Desc = {
    Text = "플레이어의 게임 내 성장 강도 인터페이스의 반환값을 수정하며, 1스택당 1%씩 증가한다."
  },
  State_129761_Name = {
    Text = "게임 내 성장 강도 수정"
  },
  State_129845_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_129845_Name = {
    Text = "미깨어남"
  },
  State_129846_Name = {
    Text = "끊긴 실타래의 진동 카운터"
  },
  State_129848_Desc = {
    Text = "[DescArg1]장의 카드가 차원 균열을 떠날 때마다 <BrokenCard:암중 파괴> [DescArg2]스택을 부여한다."
  },
  State_129848_Name = {
    Text = "인형극장 개막"
  },
  State_129849_Desc = {
    Text = "매 턴 적이 사용한 첫 번째 명령 카드의 복사본을 차원 균열에 넣는다. 카드가 차원 균열에 들어가면 <DepleteIconKeywords:소모>를 부여한다. 매 턴 최초로 열쇠 지령을 사용하면 가장 왼쪽의 카드를 꺼내 덱 맨 위에 놓는다."
  },
  State_129849_Name = {
    Text = "운명의 실타래 조종"
  },
  State_129850_Desc = {
    Text = "차원 균열에 명령 카드가 1장 있을 때마다 플레이어의 손패 상한이 1 감소한다. 차원 균열이 가득 차 있다면, 다음에 카드를 사용할 때 「영원의 직조」가 즉시 행동하고, 행동 후 차원 균열을 비우며 의도를 「운명을 초월하는 비가」로 조정한다."
  },
  State_129850_Name = {
    Text = "끊긴 실타래의 진동"
  },
  State_129854_Desc = {
    Text = "차원 균열에 명령 카드가 1장 있을 때마다, 플레이어의 손패 상한이 1 감소한다. 차원 균열이 가득 차 있다면, 다음에 카드를 사용할 때 「영원의 그물」이 즉시 행동하고, 행동 후 차원 균열을 비우며 의도를 「운명, 이로써 고하노라」로 조정한다."
  },
  State_129854_Name = {
    Text = "끊긴 실타래의 진동"
  },
  State_129864_Desc = {
    Text = "카드를 사용할 때마다 「졸음」 1스택을 제거한다. 턴 시작 시 12스택의 「졸음」으로 회복된다."
  },
  State_129864_Name = {Text = "진노"},
  State_129865_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_129865_Name = {
    Text = "미깨어남"
  },
  State_129872_Desc = {
    Text = "임시 변수."
  },
  State_129872_Name = {
    Text = "카운터 1"
  },
  State_129873_Desc = {
    Text = "[Layer]스택의 카운트 상태 _패키지 카운터1_을 획득한다."
  },
  State_129873_Name = {
    Text = "패키지 테스트 1"
  },
  State_129874_Desc = {
    Text = "임시 변수."
  },
  State_129874_Name = {
    Text = "증폭기 1"
  },
  State_130358_Desc = {
    Text = "다음에 사용하는 명령 카드가 추가로 2회 발동된다."
  },
  State_130358_Name = {
    Text = "마리오네트"
  },
  State_130387_Desc = {
    Text = "「마리오네트」가 소모된 후, 이후 매 턴 첫 번째 명령 카드가 추가로 2회 발동한다. 보스전일 경우, 모든 깨어남체가 광기 50을 획득하고 은열쇠 에너지 1000을 획득한다."
  },
  State_130387_Name = {
    Text = "운명의 장례식"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:유지>: 은열쇠 에너지 [DescArg1]pt 획득"
  },
  State_130389_Desc = {
    Text = "사용 후 모든 깨어남체가 [DescArg1]의 광기를 획득한다."
  },
  State_130389_Name = {
    Text = "사용 후 모든 깨어남체가 광기 [DescArg1]pt 획득"
  },
  State_130390_Desc = {
    Text = "행동력 상한과 손패 상한이 1 증가한다."
  },
  State_130390_Name = {
    Text = "중복된 측면"
  },
  State_130391_Desc = {
    Text = "증상 카드를 1장 사용할 때마다, 「마리오네트」의 행동력 소모가 1 감소한다."
  },
  State_130391_Name = {
    Text = "불결한 여운"
  },
  State_130490_Desc = {
    Text = "이 카드가 주는 피해, 실타래드, 치유, 힘, 쇠약, 촉수 피해, 잠금 중독, 잠금 반격이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_130490_Name = {
    Text = "특이점 비콘 α"
  },
  State_130498_Desc = {
    Text = "다음에 사용하는 명령 카드가 추가로 2회 발동된다."
  },
  State_130498_Name = {
    Text = "운명의 장례식"
  },
  State_130500_Desc = {
    Text = "보스전에서 죽음 저항이 100% 증가한다. 「죽음 저항」이 발동된 후 다음 턴 「마리오네트」가 더 이상 명령 카드를 강제로 사용하지 않고, 손에 있는 명령 카드 중 1장을 선택한다."
  },
  State_130500_Name = {
    Text = "순교자의 회상"
  },
  State_130501_Desc = {
    Text = "다음 명령 카드의 행동력 소모가 0으로 감소한다."
  },
  State_130501_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_130512_Desc = {
    Text = "다음에 사용하는 명령 카드가 추가로 2회 발동되며, 행동력 소모가 2 감소한다."
  },
  State_130512_Name = {
    Text = "마리오네트"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장비 시 및 턴 시작 시, 다음 효과 중 하나를 무작위로 발동합니다: <Energy:[Energy:StateArg1]> 광기를 획득하고 자신에게 <PVPSlowKeywords:둔화> 부여; <Energy:[Energy:StateArg3]> 광기를 획득; <Energy:[Energy:StateArg4]> 및 [StateArg5]장의 <PVPDerivativeCardKeywords_17:「영감」>을 획득."
  },
  State_130517_Name = {
    Text = "도박의 지혜"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <Block:[Block:StateArg1]> 방어막과 <DelayKeywords:지연>: <Energy:[Energy:StateArg2]> 광기를 획득합니다."
  },
  State_131046_Name = {
    Text = "아득한 에덴동산"
  },
  State_131047_Desc = {
    Text = "이번 턴에 [Layer]회 사용하는 열쇠 지령이 2회 발동된다."
  },
  State_131047_Name = {
    Text = "이중 발사 열쇠 지령"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 첫 번째로 「스킬」 사용 후 <HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 <Damage:[Damage:StateArg1]> 피해를 줍니다."
  },
  State_131048_Name = {
    Text = "갇힌 광기"
  },
  State_131055_Desc = {
    Text = "매 턴 드로우 수가 1 감소한다. 모든 깨어남체가 주는 실타래드와 HP 회복이 20% 증가한다."
  },
  State_131055_Name = {Text = "털 정리"},
  State_131056_Desc = {
    Text = "HP를 잃은 후, 잃은 HP와 동일한 양의 지연 광기를 실타래드로 전환한다."
  },
  State_131056_Name = {
    Text = "소용돌이 실타래드"
  },
  State_131058_Desc = {
    Text = "모든 깨어남체의 기본 광기가 10 증가한다. 광기 폭발을 발동한 후 행동력 1을 획득하며, 각 깨어남체는 1턴에 1회만 발동할 수 있다."
  },
  State_131058_Name = {
    Text = "부비부비"
  },
  State_131059_Name = {
    Text = "모스 궁극기 업그레이드 표시"
  },
  State_131061_Desc = {
    Text = "은열쇠 에너지 상한 및 열쇠 지령 소모 은열쇠 에너지가 350 증가한다. 매 턴 최초로 사용하는 열쇠 지령이 2회 발동된다."
  },
  State_131061_Name = {
    Text = "간식 먹이기"
  },
  State_131064_Desc = {
    Text = "광기 폭발을 발동한 후 행동력 1을 획득하며, 각 깨어남체는 1턴에 1회만 발동할 수 있다."
  },
  State_131064_Name = {
    Text = "부비부비"
  },
  State_131069_Desc = {
    Text = "모든 깨어남체가 주는 실타래드와 HP 회복이 20% 증가한다."
  },
  State_131069_Name = {Text = "털 정리"},
  State_131073_Desc = {
    Text = "팀 유일: 전투 시작 시 기본 광기의 <WeaponEffect_Num:[StateArg1]%>만큼 광기를 획득한다. 장착한 깨어남체의 광기 폭발 최종 피해가 증가하며, 그 증가량은 기본 광기의 <WeaponEffect_Num:[StateArg2]%>이다. 「노도」 자세로 전환할 때, 현재 영역 숙련의 <WeaponEffect_Num:[StateArg3]%>만큼 임시 영역 숙련을 획득한다. 3턴 쿨다운."
  },
  State_131073_WeaponDesc = {
    Text = "전투 시작 시 [DescArg1]의 광기를 획득한다. 장착한 깨어남체의 광기 폭발 최종 피해가 [DescArg2]% 증가한다. 「노도」 자세로 전환할 때, [DescArg3]의 임시 영역 숙련을 획득한다. 3턴 쿨다운(현재 남은 [DescArg4]턴)."
  },
  State_131078_Desc = {
    Text = "매 턴 최초로 사용하는 열쇠 지령이 2회 발동된다."
  },
  State_131078_Name = {
    Text = "간식 먹이기"
  },
  State_131118_Desc = {
    Text = "피해를 받거나 생명력을 잃을 때마다 최대 생명력의 3%를 초과할 수 없다."
  },
  State_131118_Name = {
    Text = "천사의 고치"
  },
  State_131123_Desc = {
    Text = "턴 시작 시 초기화된다. 10스택에 도달하면, 다음에 카드를 사용한 후 즉시 행동하여 다음 의도로 전환하고 <Chapter5_Monster_Fervor4:열광>을 제거한다."
  },
  State_131123_Name = {
    Text = "임시 열광"
  },
  State_131127_Desc = {
    Text = "운명에 속박된 자세. 적이 1장의 「커맨드 카드」를 사용할 때마다 자신은 1층의 「임시 열광」을 얻습니다."
  },
  State_131127_Name = {
    Text = "속박 서약"
  },
  State_131134_Desc = {
    Text = "사망 후, 네프레아가 [DescArg1] 층의 임시 광열을 획득하지만, 최대 생명력의 3%를 잃는다."
  },
  State_131134_Name = {
    Text = "연옥의 문"
  },
  State_131186_Desc = {
    Text = "사용 후 1회 추가 발동되지만, [DescArg1] 포인트의 피해를 받습니다."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:운명 잔해>"
  },
  State_131188_Desc = {
    Text = "사용한 「스킬」이 「차원 균열」에 들어가며 같은 이름의 모든 스킬에 「운명의 잔해」를 부여하고, 차원 균열을 떠나면 해제됩니다. 차원 균열이 가득 차면, 「배반의 그물」 네프레아가 행동 후 차원 균열을 비우고, 다음 의도를 강력한 광기 폭발로 전환합니다."
  },
  State_131188_Name = {
    Text = "차원 균열"
  },
  State_131191_Name = {
    Text = "인지 장애"
  },
  State_131242_Desc = {
    Text = "이 카드가 주는 피해, 실타래드, 치유, 힘, 쇠약, 촉수 피해, 잠금 중독, 잠금 반격이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_131242_Name = {
    Text = "특이점 비콘 β"
  },
  State_131258_Desc = {
    Text = "물레의 실타래을 돌려 잘못된 운명을 교란한다. 열쇠 명령을 해제하거나 「운명의 파편」 카드를 사용한 후 1단계 제거되며, 모두 제거되면 아라크네가 「운명의 실타래, 제자리로」 추격을 발동하여 막대한 피해를 입힌다. 3회 해제 후 적의 「천사의 고치」를 완전히 파괴한다!"
  },
  State_131258_Name = {
    Text = "명망 교란"
  },
  State_131261_Name = {
    Text = "파멸 극장"
  },
  State_131351_Desc = {
    Text = "다른 깨어남체가 광기 폭발을 발동한 후 1스택을 소모하고, 모스가 「소용돌이! 흐름! 탄!」을 발사하여 추격한다."
  },
  State_131351_Name = {
    Text = "소용돌이 장전"
  },
  State_131439_Desc = {
    Text = "다음에 사용하는 명령 카드가 추가로 2회 발동되며, 행동력 소모가 0으로 감소한다."
  },
  State_131439_Name = {
    Text = "마리오네트"
  },
  State_131637_Desc = {
    Text = "사망 후 즉시 무작위 「심연옥 거미 떼」 또는 「냉거미 떼」를 소환하여 해당 대상의 「군집 효과」를 1단계 감소시킨다."
  },
  State_131637_Name = {
    Text = "군집 효과"
  },
  State_131638_Desc = {
    Text = "사망 후 즉시 무작위 「파상 모체」 또는 「속박사 모체」를 소환하여 해당 대상의 「군집 효과」를 1단계 감소시킨다."
  },
  State_131638_Name = {
    Text = "군집 효과"
  },
  State_131645_Desc = {
    Text = "팀 유일: 「노도」 자세로 전환할 때, 현재 영역 숙련의 <WeaponEffect_Num:[StateArg1]%>만큼 임시 영역 숙련을 획득한다. 3턴 쿨다운."
  },
  State_131645_WeaponDesc = {
    Text = "「노도」 자세로 전환할 때, [DescArg2]의 임시 영역 숙련을 획득한다. 3턴 쿨다운(현재 남은 [DescArg1]턴)."
  },
  State_131657_Desc = {
    Text = "다른 깨어남체가 광기 폭발을 발동한 후 1스택을 소모하고, 모스가 「소용돌이! 흐름! 탄!」을 발사하여 추격한다."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:소용돌이 장전>"
  },
  State_131660_Desc = {
    Text = "스택당 광기 폭발을 발동하는 데 필요한 광기 요구량이 1 증가한다."
  },
  State_131660_Name = {
    Text = "광기 소모 잠금값 수정"
  },
  State_131675_Desc = {
    Text = "이 카드가 다음에 사용될 때 [StateArg1]% 확률로 1회 추가 발동한다."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:도박>"
  },
  State_131684_Desc = {
    Text = "다음 [Layer]회 「와! 류! 탄!」이 2회 발동된다."
  },
  State_131684_Name = {
    Text = "모스크스! 대! 폭! 발!"
  },
  State_131749_Desc = {
    Text = "팀 유일: 탐색 시작 후, 「도박의 지혜」 1장을 덱에 섞어 넣는다. 「도박의 지혜」: 행동력 1을 소모한다. 손에 있는 모든 명령 카드를 무작위로 덱에 섞어 넣으며, 섞인 명령 카드는 다음에 사용할 때 <WeaponEffect_Num:[StateArg1]%> 확률로 1회 추가 발동한다. 또한 명령 카드 1장을 섞어 넣을 때마다 모든 깨어남체가 광기 2를 획득한다. <RetainIconKeywords:유지>. <DepleteIconKeywords:소모>. <GuyouKeywords:고유>."
  },
  State_131749_WeaponDesc = {
    Text = "탐색 시작 후, 「도박의 지혜」 1장을 덱에 섞어 넣는다. 「도박의 지혜」: 행동력 1을 소모한다. 손에 있는 모든 명령 카드를 무작위로 덱에 섞어 넣으며, 섞인 명령 카드는 다음에 사용할 때 <WeaponEffect_Num:[StateArg1]%> 확률로 1회 추가 발동한다. 또한 명령 카드 1장을 섞어 넣을 때마다 모든 깨어남체가 광기 2를 획득한다. <RetainIconKeywords:유지>. <DepleteIconKeywords:소모>. <GuyouKeywords:고유>."
  },
  State_131769_Name = {
    Text = "상태@번식 혈육 직업 초기화 1"
  },
  State_131779_Desc = {
    Text = "[Layer]회 사용 후에만 버린 카드 더미로 들어가며 횟수가 초기화되지만, 「각인」은 최초 사용 시에만 발동한다."
  },
  State_131779_Name = {
    Text = "[Layer]회 사용 가능"
  },
  State_131789_Desc = {
    Text = "대체 수단. tid가 [Layer]인 카드 1장을 손에 넣는다."
  },
  State_131789_Name = {
    Text = "지정 카드 추가"
  },
  State_131807_Name = {
    Text = "상태@번식 혈육 순수 표식"
  },
  State_131824_Name = {
    Text = "상태@몬스터 타비 의도 전환 플레이어 감청"
  },
  State_131846_Desc = {
    Text = "사망 후 즉시 무작위 「심연옥 거미 떼」 또는 「냉거미 떼」를 소환하여 해당 대상의 「군집 효과」를 1단계 감소시킨다."
  },
  State_131846_Name = {
    Text = "군집 효과"
  },
  State_131908_Desc = {
    Text = "대상의 HP, 실타래드, 광기를 분담하지만, 전투 통계는 발생하지 않는다."
  },
  State_131908_Name = {
    Text = "부패의 연회 점프대"
  },
  State_131909_Desc = {
    Text = "해당 상태를 보유하면 광기 폭발을 사용할 수 없다."
  },
  State_131909_Name = {
    Text = "영구 봉인"
  },
  State_132366_Desc = {
    Text = "다른 깨어남체가 타격 카드 사용 후 추격을 실타래행한다."
  },
  State_132366_Name = {Text = "추격"},
  State_132465_Desc = {
    Text = "이 깨어남체가 주는 피해, 실타래드, 치유, 힘, 쇠약, 촉수 피해, 잠금 중독, 잠금 반격이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_132465_Name = {
    Text = "강화 포식 α"
  },
  State_132469_Desc = {
    Text = "이 깨어남체가 주는 피해, 실타래드, 치유, 힘, 쇠약, 촉수 피해, 잠금 중독, 잠금 반격이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_132469_Name = {
    Text = "강화 포식 β"
  },
  State_132539_Desc = {
    Text = "집합 테스트 유물"
  },
  State_132539_Name = {
    Text = "유물 집중 테스트"
  },
  State_132539_WeaponDesc = {Text = "테스트"},
  State_132560_WeaponDesc = {
    Text = "청화염이 [Damage:StateArg2]회 피해를 줄 때마다, 소모되는 「푸른 불꽃」 1장을 획득한다."
  },
  State_132564_WeaponDesc = {
    Text = "청화염이 [Damage:StateArg2]회 피해를 줄 때마다, 「푸른 불꽃」 1장을 획득한다."
  },
  State_132565_WeaponDesc = {
    Text = "청화염이 [Damage:StateArg2]회 피해를 줄 때마다, 「푸른 불꽃」 1장을 획득한다."
  },
  State_132598_Desc = {
    Text = "이번 턴에 촉수 피해를 입힐 때, 추가로 피해량의 [Layer]%만큼 중독을 부여한다."
  },
  State_132598_Name = {
    Text = "잊혀진 집념"
  },
  State_132609_Desc = {
    Text = "조각사가 실타래드를 부여할 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_132609_Name = {
    Text = "무아의 경지"
  },
  State_132609_WeaponDesc = {
    Text = "조각사가 실타래드를 부여할 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_132669_Desc = {
    Text = "이 깨어남체의 카드가 주는 피해, 실타래드, 치유, 힘, 쇠약, 촉수 피해, 잠금 중독, 잠금 반격이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_132669_Name = {
    Text = "운명 초차원 α"
  },
  State_132840_Name = {
    Text = "\"24\"의 명령 카드 인격 효과 보너스 2배. 광기 폭발 발동 후, 인격 보너스 2배 효과 이번 턴에 무효"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [StateArg1] <StrongEffectKeywords:증폭>을 획득하고, 다른 아군이 광기 폭발 후 <PVPOneMeetingKeywords:일기일회>를 획득합니다."
  },
  State_132891_Name = {
    Text = "사쿠라의 망상"
  },
  State_132892_Desc = {
    Text = "·획득 시 다른 아군의 「일기일회」 상태를 제거하고, 「벚꽃 아래의 수수께끼」를 장비한 아군의 증폭 효과와 동일한 효과를 획득하며, 최대 3중첩.\n·「벚꽃 아래의 수수께끼」를 장비한 캐릭터는 「일기일회」를 획득할 수 없음."
  },
  State_132892_Name = {
    Text = "일기일회"
  },
  State_133294_Name = {
    Text = "궁전의 초대장"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장비 후, 장착자의 「타격」, 「스킬」, 「광기 폭발」 설명을 식별할 수 없지만, 매 피해, 보호막, 치유가 무작위로 [StateArg1]%~[StateArg2]% 증가."
  },
  State_133353_Name = {
    Text = "진흙 속의 동화"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 이 명륜은 사망 후에도 보존됩니다. 장착자 사망 시 및 사망 상태에서 이후 [Layer] 턴 종료 후, 다른 아군이 <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:우종>과 HP를 획득합니다."
  },
  State_133354_Name = {
    Text = "세상이 향기로 물들기를"
  },
  State_133369_Desc = {
    Text = "다음에 사용하는 [DescArg1]장의 타비가 아닌 명령 카드가 2회 발동된다."
  },
  State_133369_Name = {
    Text = "은열쇠의 문"
  },
  State_133372_Desc = {
    Text = "현재 초차원 턴일 경우, 특이점 도약 효과를 발동한다. 「특이점 소멸」도 이번 턴의 다음 특이점 도약을 반드시 발동시킬 수 있다."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:특이점 도약>"
  },
  State_133391_Desc = {
    Text = "해당 상태의 스택 수가 대상의 HP 이상일 경우, 모든 운명 재단을 제거하고 대상을 즉시 처치한다. 부여하는 잠금 운명 재단은 피해 강효의 영향을 받는다."
  },
  State_133391_Name = {
    Text = "<CutKeywords:운명 재단>"
  },
  State_133395_Desc = {
    Text = "이후에 사용하는 다음 [Layer]장의 명령 카드가 「차원 이동」을 발동한다."
  },
  State_133395_Name = {
    Text = "차원 이동"
  },
  State_133717_Desc = {
    Text = "현재 소유자는 [Layer]이며, 해당 소유자의 모든 현재 및 미래 카드가 해당 속성을 획득한다(현재: 카드 봉인)."
  },
  State_133717_Name = {
    Text = "카드 속성 전파"
  },
  State_133774_Desc = {
    Text = "스택당 해당 카드가 주는 피해, 고정 힘과 촉수 피해 증가, 고정 중독, 고정 반격 최종 효과 2% 증가; 고정 방어막, 고정 HP 회복, 힘 감소의 최종 효과 1% 증가. 특이점 비콘을 보유한 카드는 「차원 이동」을 발동할 수 없음."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:특이점 비콘>"
  },
  State_133775_Desc = {
    Text = "스택당 모든 각성체 카드가 주는 피해, 고정 힘과 촉수 피해 증가, 고정 중독, 고정 반격 최종 효과 2% 증가; 고정 방어막, 고정 HP 회복, 힘 감소의 최종 효과 1% 증가."
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:특이점 프리즘>"
  },
  State_133961_Desc = {
    Text = "팀 유니크: 탐색 시작 후 「봄의 편지」 카드 1장을 생성하여 덱에 넣습니다: 행동력 소비 1, 은열쇠 에너지 <WeaponEffect_Num:[StateArg1]> 포인트 획득, 사용 후 영구적으로 「벚꽃 만개」로 변화: 행동력 소비 1, 은열쇠 에너지 <WeaponEffect_Num:[StateArg2]> 포인트 획득, 사용 후 영구적으로 「꽃보라」로 변화: 행동력 소비 1, 은열쇠 에너지 <WeaponEffect_Num:[StateArg3]> 포인트 획득, 사용 후 영구적으로 「일기일회」로 변화: 행동력 소비 1, 해금된 3개의 은열쇠 중 무작위로 1개를 선택하여 즉시 발동하고 2회 효과 발생, 사용 후 영구적으로 「봄의 편지」로 변화. 이 카드들은 모두 「보존」을 보유합니다."
  },
  State_133961_WeaponDesc = {
    Text = "탐색 시작 후 「봄의 편지」 카드 1장을 생성하여 덱에 삽입: 연산력 소모 1, <WeaponEffect_Num:[StateArg1]> 포인트의 은열쇠 에너지 획득, 사용 후 영구적으로 「만개한 벚꽃」으로 변화: 연산력 소모 1, <WeaponEffect_Num:[StateArg2]> 포인트의 은열쇠 에너지 획득, 사용 후 영구적으로 「꽃보라」로 변화: 연산력 소모 1, <WeaponEffect_Num:[StateArg3]> 포인트의 은열쇠 에너지 획득, 사용 후 영구적으로 「일기일회」로 변화: 연산력 소모 1, 해금된 3개의 무작위 열쇠령 중 1개를 선택하여 즉시 발동하고 2회 적용, 사용 후 영구적으로 「봄의 편지」로 변화. 이 카드들은 모두 「보류」를 보유."
  },
  State_133994_Desc = {
    Text = "모든 각성체 명령 카드가 가하는 피해, 고정 힘과 촉수 피해 증가, 고정 중독, 고정 반격의 최종 효과가 [DescArg1]% 증가하고, 가하는 고정 방어막, 고정 HP 회복, 힘 감소 효과가 [DescArg2]% 증가."
  },
  State_133994_Name = {
    Text = "특이점 프리즘"
  },
  State_133998_Desc = {
    Text = "이 카드가 주는 피해, 실타래드, 힘 변화가 [DescArg2]% 증가하며, 촉수 피해, HP 회복, 잠금 중독, 잠금 반격의 최종 효과가 [DescArg1]% 증가한다. 턴 종료 또는 사용 후 제거된다."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:임시 강화 [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "스택당 해당 카드가 주는 피해, 고정 힘과 촉수 피해 증가, 고정 중독, 고정 반격 최종 효과 2% 증가; 고정 방어막, 고정 HP 회복, 힘 감소의 최종 효과 1% 증가, 턴 종료 또는 사용 후 제거."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:임시 강화>"
  },
  State_134100_Desc = {
    Text = "이번 전투에서 치명적 피해를 받을 시, 부활하여 [Layer]pt의 HP를 회복하고 모든 깨어남체가 [StateArg1]pt의 광기와 [DescArg1]pt의 임시 촉수 피해를 획득한다. 해제할 수 없다."
  },
  State_134100_Name = {
    Text = "불멸의 극락조"
  },
  State_134191_Desc = {
    Text = "팀 유일: 탐색 시작 후, 「은밀한 오후 휴식 시간」 1장을 덱에 섞어 넣는다. 「은밀한 오후 휴식 시간」: 행동력 1을 소모한다. 임시 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. <RetainIconKeywords:유지>. <DepleteIconKeywords:소모>."
  },
  State_134191_WeaponDesc = {
    Text = "탐색 시작 후, 「은밀한 오후 휴식 시간」 1장을 덱에 섞어 넣는다. 「은밀한 오후 휴식 시간」: 행동력 1을 소모한다. 임시 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. <RetainIconKeywords:유지>. <DepleteIconKeywords:소모>."
  },
  State_134195_Desc = {
    Text = "이 카드가 주는 잠금 중독, 잠금 반격, 잠금 운명 재단 스택이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_134195_Name = {
    Text = "삼상의 힘 α1"
  },
  State_134196_Desc = {
    Text = "이 깨어남체의 명령 카드가 주는 잠금 중독, 잠금 반격, 잠금 운명 재단 스택이 증가하며, 독립적으로 1+[StateArg1]%가 곱해진다."
  },
  State_134196_Name = {
    Text = "삼상의 힘β3"
  },
  State_134197_Desc = {
    Text = "이 카드가 주는 잠금 중독, 잠금 반격, 잠금 운명 재단 스택이 증가하며, 독립적으로 1+[StateArg1]%가 곱해진다."
  },
  State_134197_Name = {
    Text = "삼상의 힘β1"
  },
  State_134198_Desc = {
    Text = "이 깨어남체의 명령 카드가 주는 잠금 중독, 잠금 반격, 잠금 운명 재단 스택이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_134198_Name = {
    Text = "삼상의 힘α3"
  },
  State_134199_Desc = {
    Text = "이 깨어남체의 광기 폭발이 주는 잠금 중독, 잠금 반격, 잠금 운명 재단 스택이 증가하며, 독립적으로 1+[StateArg1]%가 곱해진다."
  },
  State_134199_Name = {
    Text = "삼상의 힘β2"
  },
  State_134200_Desc = {
    Text = "이 깨어남체의 광기 폭발이 주는 잠금 중독, 잠금 반격, 잠금 운명 재단 스택이 증가하며, 독립적으로 1+[Layer]%가 곱해진다."
  },
  State_134200_Name = {
    Text = "삼상의 힘α2"
  },
  State_134227_Desc = {
    Text = "아라크네가 운명을 짜는 자의 선줄기. 최대 [DescArg1] 층, 광기 폭발에 의해 소모되어 「끝없는 실타래타래」 추격을 발동할 수 있다. 「직명」은 다음 전투로 계승된다."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:직명>"
  },
  State_134231_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 장착한 깨어남체가 「추격」 시 임시 강효가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 매 턴 최대 5회 발동한다. 「차원 이동」이 발동될 때마다 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_134231_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 장착한 깨어남체가 「추격」 시 임시 강효가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 매 턴 최대 5회 발동한다. 「차원 이동」이 발동될 때마다 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_134237_Desc = {
    Text = "아라크네가 운명을 엮어 이끌어낸 실타래타래, 최대 [DescArg1] 층이며, 광기 폭발로 소모하여 「<DerivativeCardKeywords_144:무한한 실타래타래>」 추격을 발동할 수 있다. 「직명」은 다음 전투로 계승된다."
  },
  State_134237_Name = {Text = "직명"},
  State_134240_Desc = {
    Text = "다음 [Layer]회 「영원의 직조」가 추가 「사선인명」을 생성하여 덱과 버린 카드 더미에 넣는다."
  },
  State_134240_Name = {
    Text = "운명의 그물"
  },
  State_134261_Desc = {
    Text = "다음 [Layer]회 주는 피해가 2배가 된다."
  },
  State_134261_Name = {
    Text = "은밀한 오후 휴식 시간"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 다음에 주는 피해가 2배가 된다."
  },
  State_134262_Name = {
    Text = "은밀한 오후 휴식 시간"
  },
  State_134285_Desc = {
    Text = "해당 상태의 스택 수가 대상의 HP 이상일 경우, 모든 운명 재단을 제거하고 대상을 즉시 처치한다. 부여하는 잠금 운명 재단은 피해 강효의 영향을 받는다."
  },
  State_134285_Name = {
    Text = "운명 재단"
  },
  State_134313_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 장착한 깨어남체가 「추격」 시 임시 강효가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 매 턴 최대 5회 발동한다."
  },
  State_134313_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 장착한 깨어남체가 「추격」 시 임시 강효가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 매 턴 최대 5회 발동한다."
  },
  State_134384_Desc = {
    Text = "이후에 사용하는 다음 [Layer]장의 명령 카드가 「차원 이동」을 발동한다."
  },
  State_134384_Name = {
    Text = "차원 이동"
  },
  State_134389_Desc = {
    Text = "이 카드가 가하는 피해, 고정 힘과 촉수 데미지 증가, 고정 중독, 고정 반격의 최종 효과가 [DescArg1]% 증가하고, 가하는 고정 방어막, 고정 HP 회복, 힘 감소 효과가 [DescArg2]% 증가합니다. 「특이점 비콘」을 가진 카드는 더 이상 「초차원 공간」에 복사될 수 없습니다."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:특이점 비콘 [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "매 턴 처음으로 명령 카드를 사용한 후 해당 효과가 발동되며, 명령 카드를 사용한 후 해당 카드의 임시 원본 복사본을 초차원 공간에 넣는다. 초차원 턴에서는 해당 효과를 발동할 수 없다."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:차원 이동>"
  },
  State_135232_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:특이점 도약>: 이번 턴 남은 시간 동안 다른 깨어남체가 명령 카드를 사용한 후, <SilkKeywords:직명> 1스택을 소모하여 「<DerivativeCardKeywords_144:끝없는 실타래타래>」 추격 발동>"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:특이점 도약>: 이번 턴 남은 시간 동안 다른 깨어남체가 명령 카드를 사용한 후, <SilkKeywords:직명> 1스택을 소모하여 「<DerivativeCardKeywords_144:끝없는 실타래타래>」 추격 발동"
  },
  State_135919_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:특이점 도약>: 이번 턴 남은 시간 동안 다른 깨어남체가 명령 카드를 사용한 후, <SilkKeywords:직명> 1스택을 소모하여 「<DerivativeCardKeywords_144:끝없는 실타래타래>」 추격 발동>"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:특이점 도약>: 이번 턴 남은 시간 동안 다른 깨어남체가 명령 카드를 사용한 후, <SilkKeywords:직명> 1스택을 소모하여 「<DerivativeCardKeywords_144:끝없는 실타래타래>」 추격 발동"
  },
  State_135921_Desc = {
    Text = "깨어남체가 주는 피해가 25% 증가한다."
  },
  State_135921_Name = {
    Text = "<CardKeyWord:꾸짖음, 은원을 갚기 위하여>"
  },
  State_138824_Desc = {
    Text = "빛나는 생명이 자유를 찬미하며 개선가를 울리고 있으며, 사야의 광기 폭발로 소모하여 그 효과를 강화할 수 있습니다. 이 상태는 최대 4층까지 쌓이며, 전투 종료 후에도 보존됩니다."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:우종>"
  },
  State_139039_Desc = {
    Text = "해당 깨어남체의 해당 턴 다음 광기 폭발로 인한 피해, 잠금 방어막, 잠금 HP 회복, 잠금 힘, 힘 감소, 촉수 피해 증가, 잠금 중독, 잠금 반격의 최종 효과가 [Layer]% 증가한다."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:번식 축전>"
  },
  State_139687_Desc = {
    Text = "빛나는 생명이 자유를 찬미하며 개선가를 울리고 있으며, 사야의 광기 폭발로 소모하여 그 효과를 강화할 수 있습니다. 이 상태는 최대 4층까지 쌓이며, 전투 종료 후에도 보존됩니다."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:우종>"
  },
  State_139688_Desc = {
    Text = "팀 유니크: 최대 산출력 +1, 동일 유형 효과는 중첩 불가. 장착자의 광기 최대치가 10 포인트마다, 주는 고정 <Corrosion:침식> 효과가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 주는 배아 융합이 <WeaponEffect_Num:[Float:StateArg2]%> 증가합니다."
  },
  State_139688_WeaponDesc = {
    Text = "최대 산출력 +1, 동일 유형 효과는 중첩 불가. 장착자의 광기 최대치가 10 포인트마다, 주는 고정 <Corrosion:침식> 효과가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 주는 배아 융합이 <WeaponEffect_Num:[Float:StateArg2]%> 증가합니다."
  },
  State_139689_Desc = {
    Text = "팀 유니크: 「진홍빛 용광로」 사용 후, 장착자가 광기 최대치의 <WeaponEffect_Num:[StateArg1]%>에 해당하는 광기를 획득합니다. 3턴 쿨다운."
  },
  State_139689_WeaponDesc = {
    Text = "「핏빛 용광로」 사용 후, 장착자가 <WeaponEffect_Num:[StateArg1]%> 광기 최대치의 광기를 획득합니다. 3턴 쿨다운."
  },
  State_139977_Desc = {
    Text = "이번 턴에 「타격」을 사용하면, 「타격」+ [DescArg1]% 피해 관통; 그렇지 않으면 턴 종료 시 +[Layer] 배리어."
  },
  State_139977_Name = {Text = "성수"},
  State_140063_Desc = {
    Text = "다음 턴에서 연산력을 빌려 쓴 \"차용증\"으로, 다음 턴 시작 후 [Layer] 연산력이 차감됩니다. 해제 불가."
  },
  State_140063_Name = {
    Text = "차용증 소지"
  },
  State_140068_Desc = {
    Text = "다음 [DescArg1]장의 「스킬」이 소모하는 연산력 - [StateArg1]."
  },
  State_140068_Name = {Text = "깨달음"},
  State_140135_Desc = {
    Text = "1스택 보유 시마다, 해당 깨어남체의 이번 턴 다음 광기 폭발로 인한 데미지, 잠금 방어막, 잠금 HP 회복, 잠금 힘, 힘 감소, 터치손상 증가, 잠금 중독, 잠금 반격의 최종 효과가 1% 증가합니다."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:번식 축전>"
  },
  State_140186_WeaponDesc = {
    Text = "고래 도약의 모든 피해 횟수가 1 증가한다."
  },
  State_140454_Desc = {
    Text = "파티 유일: 장착자 자신, 명륜, 밀계에서 검은 인장 드롭이 1%씩 있을 때마다, 전투 종료 후 최대 생명력의 <WeaponEffect_Num:[StateArg1]%>를 회복하며, 매 라운드 종료 시 해당 회복 효과가 30% 감소하고, 여러 번 독립적으로 계산됩니다. 「잿더미 유적」에서 「감응」을 사용한 후, 이번 「잿더미 유적」 갱신 시 검은 인장을 소모하지 않습니다."
  },
  State_140454_WeaponDesc = {
    Text = "파티 유일: 전투 종료 후 최대 생명력의 <WeaponEffect_Num:[DescArg2]%> 회복([DescArg1]), 매 턴 종료 시 해당 회복 효과 30% 감소. 「잿더미 유적」에서 「감응」 발동 후, 이번 「잿더미 유적」 갱신 시 검은 인장 소모 불필요."
  },
  State_140456_WeaponDesc = {
    Text = "사용 후 영구적으로 제거된다."
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:명륜>:장착 시 및 임의의 깨어남체가 「광기 폭발」을 발동한 후, 자신이 <Block:[Block:StateArg1]> 보호막을 획득합니다."
  },
  State_140458_Name = {
    Text = "별들에게"
  },
  State_140489_Desc = {
    Text = "동일한 양의 최대 생명력을 획득하며, 층수는 깨어남체의 초기 최대 생명력을 초과하지 않는다."
  },
  State_140489_Name = {Text = "깃종"},
  State_140490_Desc = {
    Text = "동일한 양의 최대 생명력을 획득하며, 층수는 해당 깨어남체의 초기 최대 생명력 [DescArg1]을 초과하지 않는다."
  },
  State_140490_Name = {Text = "깃종"},
  State_140495_Desc = {
    Text = "다음 「스킬」 소모 행동력 - [Layer]."
  },
  State_140495_Name = {Text = "개서"},
  State_140517_Desc = {
    Text = "다음 「스킬」이 소모하는 행동력 - [DescArg1]."
  },
  State_140517_Name = {Text = "개서"},
  State_140547_Desc = {
    Text = "해당 효과는 최대 배아 융합+ 100이며, 배아 융합 효과 증가 보너스의 영향을 받지 않습니다."
  },
  State_140547_Name = {
    Text = "배아 융합 2배"
  },
  State_140645_Desc = {
    Text = "대기 특수 효과"
  },
  State_140645_Name = {
    Text = "대기 특수 효과"
  },
  State_140647_Name = {
    Text = "인지부조화 사용 감지"
  },
  State_140648_Name = {
    Text = "플레이어 인지부조화 보유 카운트"
  },
  State_140650_Desc = {
    Text = "매 턴 처음 3회 「인지착란」이 부여된 지령 카드를 사용하면 사야가 [Layer] 포인트의 광기를 획득합니다."
  },
  State_140650_Name = {
    Text = "인지 개조"
  },
  State_140651_Desc = {
    Text = "대기 특수 효과"
  },
  State_140651_Name = {
    Text = "대기 특수 효과"
  },
  State_140653_Desc = {
    Text = "이 카드의 행동력 소모가 10% 확률로 -2, 25% 확률로 -1, 30% 확률로 변동 없음, 25% 확률로 +1, 10% 확률로 +2가 됩니다. 사용하거나 버린 후 이 상태를 제거합니다."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:인지 부조화>"
  },
  State_140654_Desc = {
    Text = "대기 특수 효과"
  },
  State_140654_Name = {
    Text = "대기 특수 효과"
  },
  State_140655_Desc = {
    Text = "이 카드는 융식으로 가려져 텍스트를 확인할 수 없으며, 행동력 소모가 10% 확률로 -2, 25% 확률로 -1, 30% 확률로 변동 없음, 25% 확률로 +1, 10% 확률로 +2가 됩니다. 사용하거나 버린 후 이 상태를 제거합니다."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:인지 착란>"
  },
  State_140656_Desc = {
    Text = "이 카드의 행동력 소모가 10% 확률로 -2, 25% 확률로 -1, 30% 확률로 변동 없음, 25% 확률로 +1, 10% 확률로 +2가 됩니다. 사용하거나 버린 후 이 상태를 제거합니다."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:인지 부조화>"
  },
  State_140657_Desc = {
    Text = "이 카드는 융식으로 가려져 텍스트를 확인할 수 없으며, 행동력 소모가 10% 확률로 -2, 25% 확률로 -1, 30% 확률로 변동 없음, 25% 확률로 +1, 10% 확률로 +2가 됩니다. 사용하거나 버린 후 이 상태를 제거합니다."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:인지 착란>"
  },
  State_140658_Name = {
    Text = "플레이어 인지부조화 보유 감지"
  },
  State_140659_Desc = {
    Text = "대기 특수 효과"
  },
  State_140659_Name = {
    Text = "대기 특수 효과"
  },
  State_140662_Desc = {
    Text = "매 턴 시작 시, 「인지 착란」이 없는 지령 카드 2장에 무작위로 「인지 착란」을 부여합니다."
  },
  State_140662_Name = {
    Text = "생체 재구성"
  },
  State_140672_Desc = {
    Text = "이번 턴이 끝나기 전까지, 매번 가하는 피해, 치유, 보호막이 무작위로 15%~35% 감소하며, 해제할 수 없습니다."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:인지 착란>"
  },
  State_140673_Desc = {
    Text = "이번 턴이 끝나기 전까지, 매번 가하는 피해, 치유, 보호막이 무작위로 15%~35% 감소하며, 해제할 수 없습니다."
  },
  State_140673_Name = {
    Text = "인지 착란"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 <MaxHPKeywords:최대 HP>를 [StateArg1] 획득하고, 턴 종료 시 HP를 <Heal:[Heal:DescArg1]> 회복한다. HP 회복량은 장착자의 HP가 낮을수록 증가하며, 최대 [StateArg3]% 증가한다."
  },
  State_140683_Name = {
    Text = "이상한 나라의 릴리"
  },
  State_140724_Name = {Text = "쩝쩝"},
  State_140726_Desc = {
    Text = "이 카드가 가하는 피해, 힘, 촉완 피해, 잠금 중독, 잠금 반격, 보호막, 생명력 회복, 힘 감소의 최종 효과가 [DescArg1]% 감소합니다."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:적응 [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "허기이 5층에 도달하면, 턴 종료 후 모든 허기을 소모하고 의도를 강력 공격으로 전환하며 [DescArg1]의 힘을 획득."
  },
  State_140727_Name = {Text = "허기"},
  State_140728_Desc = {
    Text = "매 턴 시작 시 허기 1층을 획득하고, 막히지 않은 데미지를 가할 때 최대 HP의 2%([DescArg1]) 포인트의 방어막를 획득하며, 적응의 최대 스택이 75로 증가합니다."
  },
  State_140728_Name = {
    Text = "먹이 지키기"
  },
  State_140730_Desc = {
    Text = "커맨드 카드를 사용한 후, 소속 깨어남체의 모든 카드에 <AdaptKeywords:적응> 10층을 부여하고, 다른 깨어남체의 카드에서 <AdaptKeywords:적응> 5층을 제거합니다. <AdaptKeywords:적응> 1층마다 카드가 주는 데미지, 힘, 터치손상, 잠금 중독, 잠금 반격, 방어막, HP 회복, 힘 감소의 최종 효과가 1% 감소하며, 최대 [DescArg1]층까지 중첩됩니다."
  },
  State_140730_Name = {Text = "모방"},
  State_140838_Desc = {
    Text = "이번 턴 가하는 피해가 [Layer]% 감소합니다."
  },
  State_140838_Name = {
    Text = "태양을 가리는 악몽의 벽"
  },
  State_140839_Desc = {
    Text = "이번 턴 모든 깨어남체의 최종 피해가 [Layer]% 증가합니다."
  },
  State_140839_Name = {
    Text = "수행 사냥꾼"
  },
  State_140856_Desc = {
    Text = "행동 불가 상태가 되며, 턴 종료 시 의식 간섭 1층을 제거한다. 전부 제거된 후 해당 깨어남체가 다음 1번 광기 폭발을 사용할 때 초월 폭발을 사용한 것으로 간주하며, 이미 초월 폭발을 사용한 경우 광기 최대치를 100% 반환합니다."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:의식 간섭>"
  },
  State_140860_Desc = {
    Text = "행동 불가 상태가 되며, 턴 종료 시 의식 간섭 1층을 제거한다. 전부 제거된 후 해당 깨어남체가 다음 1번 광기 폭발을 사용할 때 초월 폭발을 사용한 것으로 간주하며, 이미 초월 폭발을 사용한 경우 광기 최대치를 100% 반환합니다."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:의식 간섭>"
  },
  State_140861_Desc = {
    Text = "다음 광기 폭발을 1번 사용할 때 초월 폭발을 사용한 것으로 간주하며, 이미 초월 폭발을 사용한 경우에는 광기 최대치의 100%를 반환한다."
  },
  State_140861_Name = {
    Text = "이상한 나라의 릴리"
  },
  State_140873_Desc = {
    Text = "1층마다 이 카드가 주는 데미지, 힘, 터치손상, 잠금 중독, 잠금 반격, 방어막, HP 회복, 힘 감소의 최종 효과가 1% 감소하며, 최대 [DescArg1]층까지 쌓입니다."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:적응>"
  },
  State_140877_Name = {
    Text = "[DescArg1]회 추가 발동"
  },
  State_141468_Desc = {
    Text = "허기이 5층에 도달하면, 턴 종료 후 모든 허기을 소모하고 의도를 강력 공격으로 전환하며 힘을 획득합니다."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:허기>"
  },
  State_141504_Desc = {
    Text = "최대 3구까지 쌓을 수 있으며, 상한에 도달한 후 다음 「생령의 성찬」으로 이를 먹고 효과를 강화할 수 있습니다. 잔해는 다음 전투로 이어집니다."
  },
  State_141504_Name = {Text = "잔해"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 종료 시, <PVPVoidKeywords:공허>가 부여된 「스킬」 카드를 [StateArg1]장 <PVPDiscoveryKeyWords:발견>하여 손에 넣습니다."
  },
  State_141950_Name = {
    Text = "위를 향한 추락"
  },
  State_141988_Desc = {
    Text = "본 카드가 주는 피해, 방어막, 치유, 부여하는 힘, 쇠약, 터치손상, 중독, 반격, 운명 재단, 잠금 중독, 잠금 반격, 잠금 운명 재단의 효과가 [Layer]% 증가합니다."
  },
  State_141988_Name = {
    Text = "본 카드 홀로그래픽"
  },
  State_141989_Desc = {
    Text = "무작위 카드를 생성함."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:발견>"
  },
  State_141991_Desc = {
    Text = "본 깨어남체의 광기 폭발이 주는 피해, 방어막, 치유, 부여하는 힘, 쇠약, 터치손상, 중독, 반격, 운명 재단, 잠금 중독, 잠금 반격, 잠금 운명 재단의 효과가 [Layer]% 증가합니다."
  },
  State_141991_Name = {
    Text = "광기 폭발 홀로그래픽"
  },
  State_141992_Desc = {
    Text = "본 깨어남체의 카드가 주는 피해, 방어막, 치유, 부여하는 힘, 쇠약, 터치손상, 중독, 반격, 운명 재단, 잠금 중독, 잠금 반격, 잠금 운명 재단의 효과가 [Layer]% 증가합니다."
  },
  State_141992_Name = {
    Text = "본 카드 홀로그래픽"
  },
  State_141993_Desc = {
    Text = "본 깨어남체의 커맨드 카드가 주는 피해, 방어막, 치유, 부여하는 힘, 쇠약, 터치손상, 중독, 반격, 운명 재단, 잠금 중독, 잠금 반격, 잠금 운명 재단의 효과가 [Layer]% 증가합니다."
  },
  State_141993_Name = {
    Text = "커맨드 카드 홀로그래픽"
  },
  State_141994_Desc = {
    Text = "카드 사용 후, 광기 폭발 후 입힌 데미지, 방어막 획득, 치유, 힘·쇠약·터치손상·중독·반격·운명 재단·잠금 중독·잠금 반격·잠금 운명 재단 부여."
  },
  State_141994_Name = {
    Text = "화려한 색채 발동 명령"
  },
  State_142018_Desc = {
    Text = "턴 시작 시, <Guaiwucanhai:잔해> 1스택을 획득한다."
  },
  State_142018_Name = {
    Text = "궁전의 초대장"
  },
  State_142057_Desc = {
    Text = "키오더 사용 후 자신의 의도를 전환하며, 전투 시작 후 모든 깨어남체의 은열 충전 등급이 25% 증가합니다."
  },
  State_142057_Name = {
    Text = "깨달음 인과"
  },
  State_142058_Desc = {
    Text = "가하는 기본 데미지, 중독, 반격이 [DescArg1]% 감소합니다"
  },
  State_142058_Name = {
    Text = "오염된 날개"
  },
  State_142060_Desc = {
    Text = "적이 커맨드 카드를 사용할 때마다, 자신이 임시 열광 1층을 획득합니다. 임시 열광이 10층에 도달하면, 다음 커맨드 카드 사용 후 자신이 즉시 행동하고 모든 임시 열광을 제거합니다."
  },
  State_142060_Name = {
    Text = "심연 반향"
  },
  State_142062_Desc = {
    Text = "매번 0246 초기 효과가 무작위"
  },
  State_142062_Name = {
    Text = "의도 무작위"
  },
  State_142063_Desc = {
    Text = "자신의 턴 내에, 받는 데미지가 [DescArg1]% 감소합니다."
  },
  State_142063_Name = {
    Text = "성스러운 날개"
  },
  State_142065_Desc = {
    Text = "턴 시작 시 제거됩니다. 10층에 도달하면, 다음 커맨드 카드 사용 후 자신이 즉시 행동하고 모든 임시 열광을 제거합니다."
  },
  State_142065_Name = {
    Text = "임시 열광"
  },
  State_142066_Desc = {
    Text = "부여하는 <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상>, <HeavyInjuryKeywords:중상> 효과가 50%로 증가한다."
  },
  State_142066_Name = {
    Text = "본질 통찰"
  },
  State_142067_Desc = {
    Text = "가하는 힘, 반격, 터치손상이 [DescArg1]% 감소합니다"
  },
  State_142067_Name = {
    Text = "저주의 날개"
  },
  State_142072_Desc = {
    Text = "피해를 받거나 HP를 잃을 때, 최대 HP의 5%를 초과할 수 없다."
  },
  State_142072_Name = {
    Text = "고통 감내 임계값"
  },
  State_142091_Desc = {
    Text = "육익 배증 카운트"
  },
  State_142091_Name = {
    Text = "육익 배증 카운트"
  },
  State_142092_Desc = {
    Text = "모든 깨어남체의 은열 충전 등급이 25% 증가합니다."
  },
  State_142092_Name = {
    Text = "깨달음 인과"
  },
  State_142093_Desc = {
    Text = "육익 배증 소모 진행도: [DescArg1], 현재 필요 피해량: [DescArg2]."
  },
  State_142093_Name = {
    Text = "육익 배증"
  },
  State_142095_Desc = {
    Text = "육익 배증 표식"
  },
  State_142095_Name = {
    Text = "육익 배증 표식"
  },
  State_142166_Desc = {
    Text = "구체적인 효과는 일반 타격 논리를 참조하십시오.__「개발 전용」"
  },
  State_142213_Name = {
    Text = "행동력 상한 감소"
  },
  State_142215_Desc = {
    Text = "다음 턴 시작 시에도 여전히 사망 상태라면, 소생하고 [StateArg1] 방어막를 획득하며, 해제 불가."
  },
  State_142215_Name = {
    Text = "영원한 집착"
  },
  State_142228_Desc = {
    Text = "이 카드는 명륜 「위를 향한 추락」이 생성했습니다."
  },
  State_142228_Name = {
    Text = "위를 향한 추락"
  },
  State_142229_Desc = {
    Text = "파티 유일: 탐색 시작 후, 「이상한 나라의 릴리」 1장을 덱에 추가한다. 「이상한 나라의 릴리」: 행동력을 2pt 소모하고, 장착자가 광기 <WeaponEffect_Num:[StateArg1]>pt와 <Yishiganshe:「의식 간섭」> 3스택을 획득한다. <RetainIconKeywords:보존>. <DepleteIconKeywords:소모>."
  },
  State_142229_Name = {
    Text = "이상한 나라의 릴리"
  },
  State_142229_WeaponDesc = {
    Text = "탐색 시작 후, 「이상한 나라의 릴리」 1장을 덱에 추가한다. 「이상한 나라의 릴리」: 행동력을 2pt 소비하고, 장착자가 광기 <WeaponEffect_Num:[StateArg1]>pt와 <Yishiganshe:「의식 간섭」> 3스택을 획득한다. <RetainIconKeywords:보존>. <DepleteIconKeywords:소모>."
  },
  State_142452_Desc = {
    Text = "받는 힘 감소 효과가 50% 감소합니다."
  },
  State_142452_Name = {
    Text = "불멸의 존재"
  },
  State_142663_Desc = {
    Text = "다음 턴 시작 시, <DelayKeywords:지연>: [Layer] 광기를 획득함."
  },
  State_142663_Name = {
    Text = "지연된 지연된 광기"
  },
  State_142688_Desc = {
    Text = "대상이 장착한 명륜이 무효화되며, 해제 불가."
  },
  State_142688_Name = {
    Text = "슈퍼 포박"
  },
  State_142692_Desc = {
    Text = "새로운 아이디어가 떠오르고 있는 중."
  },
  State_142692_Name = {
    Text = "번뜩이는 아이디어"
  },
  State_142715_Desc = {
    Text = "해당 「기술」 피해량 [DescArg1]% 증가, 해당 기술이 소모하는 행동력 1점당 [StateArg1]% 증가."
  },
  State_142715_Name = {
    Text = "호박색의 죽음"
  },
  State_142887_Desc = {
    Text = "이번 턴에 다시 「마비」 상태가 되면, 해당 대상의 모든 「공격」이 「환상」으로 변하며, 해제 불가, 턴 종료 시까지 지속됨."
  },
  State_142887_Name = {
    Text = "약간 마비됨"
  },
  State_142954_Desc = {
    Text = "최대 산출력의 최솟값은 0이며, 매 턴 시작 시 10 미만이면 1씩 증가함. 10에 도달한 후 최대 산출력을 추가로 획득하면 동일한 수량의 카드를 드로우하는 것으로 전환됨."
  },
  State_142954_Name = {
    Text = "행동력 상한"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143002_Name = {
    Text = "사토구야SR(임시 텍스트)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143004_Name = {
    Text = "사토구아 전용 무기(임시 텍스트)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143005_Name = {
    Text = "란테고스 SR (임시 텍스트)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143006_Name = {
    Text = "흑파라오 전용 무기 (임시 텍스트)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 시작 시, 무작위 적에게 [StateArg1] <PVPCompassKeywords:잘못된 길로 향하는 나침반>을 부여합니다."
  },
  State_143007_Name = {
    Text = "갈림길을 가리키는 나침반"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143008_Name = {
    Text = "샤타크 새 전용 무기 (임시 텍스트)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143009_Name = {
    Text = "아르고몬트 전용 무기 (임시 텍스트)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 최대 손패 매수+ [StateArg1], 장착자 또는 아군 사망 시, 해당 카드가 더 이상 <PVPDerivativeCardKeywords_2:\"환상\">으로 변환되지 않고 <PVPDerivativeCardKeywords_30:\"요마 사냥\">으로 변환됩니다."
  },
  State_143010_Name = {
    Text = "살아있는 감옥"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143011_Name = {
    Text = "벌처 SR (임시 텍스트)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143012_Name = {
    Text = "샨타크 SR (임시 텍스트)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143013_Name = {
    Text = "본원 오지에 SR (임시 텍스트)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전 현재 HP의 25%를 잃고; 「광기 폭발」 후 전체 적에게 [StateArg1] 피해를 주고 동량의 HP를 흡수한다."
  },
  State_143014_Name = {
    Text = "달콤한 열매의 낭설"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143016_Name = {
    Text = "네프렌카 SR (임시 텍스트)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143017_Name = {
    Text = "란티고스 전용 무기 (임시 텍스트)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143018_Name = {
    Text = "본원 툴루 SR (임시 텍스트)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 적 전체에게 [StateArg1] 스택 <PVPBless:축복>을 부여합니다."
  },
  State_143019_Name = {
    Text = "달콤한 진실타래"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143020_Name = {
    Text = "본원 오지에 전용 무기(임시 텍스트)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143022_Name = {
    Text = "독수리 전용 무기 (임시 텍스트)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_143023_Name = {
    Text = "아포고몬 SR (임시 텍스트)"
  },
  State_143326_Desc = {
    Text = "은열쇠 충전이 [DescArg1] 증가합니다."
  },
  State_143326_Name = {
    Text = "깨달음 인과"
  },
  State_143331_Desc = {
    Text = "다음 턴 종료 전까지 <StatusApplier:>을(를) 위해 피해의 절반을 대신 받습니다. 이 상태는 팀 유니크이며, 연결된 양측 중 한 명이 사망하면 효과가 제거되고, 해제할 수 없습니다."
  },
  State_143331_Name = {
    Text = "피해 감수"
  },
  State_143333_Desc = {
    Text = "다음 턴 시작 전 <StatusApplier:>이(가) 피해의 절반을 대신 받습니다. 이 상태는 팀 유니크이며, 연결된 양측 중 한 명이 사망하면 효과가 제거되고, 해제할 수 없습니다."
  },
  State_143333_Name = {
    Text = "피해 이전"
  },
  State_143336_Desc = {
    Text = "「건트」에 1번 추가로 발동을 부여한다. 「건트」 사용 시 1층을 소모하며, 상한은 9층이고 전투 종료 시 제거되지 않는다."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:사냥>"
  },
  State_143340_Desc = {
    Text = "「건트」에 1번 추가로 발동을 부여한다. 「건트」 사용 시 1층을 소모하며, 상한은 9층이고 전투 종료 시 제거되지 않는다."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:사냥>"
  },
  State_143386_Desc = {
    Text = "<StatusApplier:>을(를) 위해 피해의 절반을 대신 받습니다. 해제할 수 없습니다."
  },
  State_143386_Name = {
    Text = "피해 감수"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:>이(가) 피해의 절반을 대신 받습니다. 해제할 수 없습니다."
  },
  State_143387_Name = {
    Text = "피해 이전"
  },
  State_143406_Name = {
    Text = "이 카드 추가 발동 [DescArg1] 회"
  },
  State_143408_Desc = {
    Text = "적 깨어남체의 공격을 받을 때 공격자의 [Layer] 광기로 전환합니다."
  },
  State_143408_Name = {
    Text = "갈림길을 가리키는 나침반"
  },
  State_143409_Desc = {
    Text = "적 깨어남체의 공격을 받을 때 스택 수만큼 공격자의 광기로 전환합니다."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:갈림길을 가리키는 나침반>"
  },
  State_143419_Desc = {
    Text = "이 카드는 <PVPDerivativeCardKeywords_31:\"오레타의 보물\">에서 왔습니다."
  },
  State_143419_Name = {
    Text = "오레타의 보물"
  },
  State_143426_Desc = {
    Text = "턴 시작 후, [Layer] 행동력을 차감합니다. 해제할 수 없습니다."
  },
  State_143426_Name = {
    Text = "지연 행동력 차감"
  },
  State_143441_Desc = {
    Text = "제[StateArg1]라운드 조작 시 선택된 깨어남체."
  },
  State_143441_Name = {
    Text = "테스트 마커1"
  },
  State_143442_Desc = {
    Text = "제[StateArg1]라운드 조작 시 선택된 깨어남체."
  },
  State_143442_Name = {
    Text = "테스트 마커2"
  },
  State_143444_Desc = {
    Text = "제[StateArg1]라운드 조작 시 선택된 깨어남체."
  },
  State_143444_Name = {
    Text = "테스트 마커4"
  },
  State_143445_Desc = {
    Text = "제[StateArg1]라운드 조작 시 선택된 깨어남체."
  },
  State_143445_Name = {
    Text = "테스트 마커3"
  },
  State_143499_Name = {
    Text = "능동 피해 면역__「개발 전용」"
  },
  State_143500_Name = {
    Text = "순수 피해 면역__「개발 전용」"
  },
  State_143541_Desc = {
    Text = "모든 적이 이번 턴에 가하는 피해를 [DescArg1]% 감소시키고, [DescArg2] 힘을 획득한다."
  },
  State_143541_Name = {Text = "호위"},
  State_143542_Desc = {
    Text = "임시 최종 피해 +[DescArg1]%, 모든 적에게 최대 HP의 [DescArg2]% 침식을 가한다."
  },
  State_143542_Name = {Text = "사냥"},
  State_143548_Desc = {
    Text = "방어막를 부여하고 상태를 추가, 몬스터, 분기1."
  },
  State_143548_Name = {
    Text = "몬스터 실타래드 전환1"
  },
  State_143549_Desc = {
    Text = "방어막를 부여하고 상태를 추가, 깨어남체, 분기2."
  },
  State_143549_Name = {
    Text = "캐릭터 실타래드 전환2"
  },
  State_143550_Desc = {
    Text = "방어막를 부여하고 상태를 추가, 깨어남체, 분기1."
  },
  State_143550_Name = {
    Text = "캐릭터 실타래드 전환1"
  },
  State_143551_Desc = {
    Text = "방어막를 생성하고 상태를 추가합니다, 몬스터, 분기 2."
  },
  State_143551_Name = {
    Text = "몬스터 실타래드 전환2"
  },
  State_143552_Desc = {
    Text = "방어막를 부여하고 상태를 추가, 플레이어, 분기1."
  },
  State_143552_Name = {
    Text = "플레이어 실타래드 전환1"
  },
  State_143553_Desc = {
    Text = "방어막를 부여하고 상태를 추가, 플레이어, 분기2."
  },
  State_143553_Name = {
    Text = "플레이어 실타래드 전환2"
  },
  State_143573_Desc = {
    Text = "건트는 폰토스의 강화 카드로, 총 3종류가 있다: 「약식의 건트」 「교란의 건트」 「사냥의 건트」. 영구 「건트」를 생성할 때 영구 「건트」가 6장을 초과하면, 무작위 영구 「건트」를 산출력 소모 +1이지만 1번 추가로 발동하는 「쌍생 건트」로 업그레이드하며, 「쌍생 건트」는 덱 안에서 「건트」 2장으로 취급한다. 모든 「건트」가 이미 업그레이드된 경우 <DestructionKeywords:파괴>가 있는 「고급 영감」 1장을 손패에 넣는다."
  },
  State_143573_Name = {Text = "건트"},
  State_143578_Desc = {
    Text = "이번 턴 내, 능동 피해를 받을 때마다 [Layer] 장의 <PVPDerivativeCardKeywords_30:\"악몽 감금\">을 손패에 넣는다."
  },
  State_143578_Name = {
    Text = "군주의 의식"
  },
  State_143595_Desc = {
    Text = "이 카드에 <PrepareKeywords:준비> [StateArg1]가 추가되었습니다."
  },
  State_143595_Name = {
    Text = "검은 백조의 춤사위"
  },
  State_143597_Desc = {
    Text = "팀 유니크: 장착자가 가하는 힘 감소 효과가 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 「노도」 자세로 전환 시, 임시 크리티컬 데미지가 증가하며, 증가량은 자신의 기본 크리티컬 데미지의 <WeaponEffect_Num:[StateArg1]%> 에 해당합니다. 3회합 쿨다운."
  },
  State_143597_WeaponDesc = {
    Text = "장착자가 가하는 힘 감소 효과가 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 「노도」 자세로 전환 후 임시 크리티컬 데미지가 <WeaponEffect_Num:[DescArg1]%> 증가합니다. 3회합 쿨다운."
  },
  State_143598_Desc = {
    Text = "팀 유니크: 장착자가 가하는 힘 감소 효과가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 적 1명을 처치할 때마다 장착자의 이번 탐색 회합 종료 시 잠금 회복되는 광기가 2포인트 증가하고, 최대 <WeaponEffect_Num:[StateArg2]> 회 중첩됩니다. 「노도」 자세로 전환 후 임시 크리티컬 데미지가 증가하며, 증가량은 자신의 기본 크리티컬 데미지의 <WeaponEffect_Num:[StateArg1]%> 에 해당합니다. 3회합 쿨다운."
  },
  State_143598_WeaponDesc = {
    Text = "장착자가 가하는 힘 감소 효과가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 적 1명을 처치할 때마다 장착자의 이번 탐색 회합 종료 시 잠금 회복되는 광기가 2포인트 증가하고, 최대 <WeaponEffect_Num:[StateArg2]> 회 중첩됩니다. 「노도」 자세로 전환 후 임시 크리티컬 데미지가 <WeaponEffect_Num:[DescArg1]%> 증가합니다. 3회합 쿨다운."
  },
  State_143683_Desc = {
    Text = "이 깨어남체의 추격이 봉인되어 사용할 수 없으며, [Layer] 회합 후 봉인이 해제됩니다."
  },
  State_143683_Name = {
    Text = "<Seal1:추격 봉인>"
  },
  State_144381_Desc = {
    Text = "행동 불가, 잔여 [DescArg1] 턴."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:의식 간섭>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 아군이 사망 시, 자신이 <Energy:[Energy:StateArg1]> 광기를 획득한다. 아군이 소생 시, 해당 아군이 <Energy:[Energy:StateArg2]> 광기를 획득한다. 광기 획득 효과는 대상의 광기가 가득 차지 않았을 때만 발동하며, 남은 발동 횟수 [Layer] 회, 횟수 소진 후 해당 명륜을 파괴한다."
  },
  State_144441_Name = {
    Text = "영혼의 동조"
  },
  State_144494_Desc = {
    Text = "총 7가지 효과가 있으며, 다음을 포함합니다: 카드 8장 뽑기, 행동력 6점 획득, 은열쇠 에너지 획득, 모든 각성체가 고정 광기 획득, 힘 획득, 모든 적의 힘 임시 감소, 임시 피해 증폭 증가."
  },
  State_144494_Name = {
    Text = "<Blessing:선물>"
  },
  State_144508_Desc = {
    Text = "「대가」는 총 3가지로, 「놓쳐진 기회」, 「허풍」, 「은폐된 살의」가 있습니다.\n「놓쳐진 기회」: 2턴 후 「선물」 효과를 획득합니다.\n「허풍」: 「선물」 효과가 50% 감소합니다.\n「은폐된 살의」: 자신에게 무작위로 1가지 다른 효과를 부여합니다: 2턴 허약, 2턴 손상, 2턴 치명타, 자신의 최대 HP 1%에 해당하는 중독, 2스택 공허, 손 안의 무작위 카드 2장에 1스택 둔화 부여, 임시 증상 카드 2장 생성(전투 간 계승 불가)하여 드로우 덱 상단에 추가."
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:대가>"
  },
  State_144519_Desc = {
    Text = "테스트 진행 수치, 턴 시작 후 또는 카드 사용 후 갱신. 현재 보유 영역정: [Layer]."
  },
  State_144519_Name = {
    Text = "신 혼돈 영역정"
  },
  State_145228_Name = {
    Text = "<WormGrowth:포식>"
  },
  State_145229_Desc = {
    Text = "당신도 축복의 일부랍니다~. 카라부의 광기 폭발로 소모되어 버프를 획득할 수 있으며, 이 상태는 최대 5스택까지 쌓입니다. 전투 종료 후 제거되지 않습니다."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:봉헌>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」 피해 증가 [DescArg1]%, 매 「타격」 후 피해가 추가로 [StateArg2]% 증가하며, 최대 [StateArg3]%까지 증가합니다."
  },
  State_145436_Name = {
    Text = "불멸의 곯은 뼈"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [StateArg2] 스택의 <EnergyStorageKeywords:충전>을 얻고, 「타격」 피해 증가 [StateArg1]% 및 <PVPPunctureDamagewords:관통 피해>로 변경된다."
  },
  State_145437_Name = {
    Text = "하늘의 추락"
  },
  State_145456_Desc = {
    Text = "대상 선택 시 도발, 잠행, 잠금을 무시합니다. 여러 대상의 조건이 동일할 경우, 앞에 있는 깨어남체를 우선 선택합니다."
  },
  State_145456_Name = {
    Text = "HP와 방어막 최저"
  },
  State_145457_Desc = {
    Text = "대상 선택 시 도발, 잠행, 잠금을 무시합니다. 여러 대상의 조건이 동일할 경우, 앞에 있는 깨어남체를 우선 선택합니다."
  },
  State_145457_Name = {
    Text = "HP와 방어막 최고"
  },
  State_145495_Desc = {
    Text = "이 카드는 쌍발로 사용됩니다."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:쌍발>"
  },
  State_145554_Desc = {
    Text = "팀 유일: 탐색 시작 후, 1장의 <Falltospace1[StateArg3]:「인세로의 내딛음」>을 덱에 추가한다. 「인세로의 내딛음」: 행동력 0 소모. 모든 적에게 장착자 공격력 <WeaponEffect_Num:[StateArg1]%> 및 최대 HP <WeaponEffect_Num:[Float:StateArg4]%>의 잠금 <Corrosion:부식> 피해를 주고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 1장의 <Falltospace2[StateArg3]:「위를 향한 추락」>을 드오루 덱에 셔플한다. <RetainIconKeywords:보존>. <DepleteIconKeywords:소모>."
  },
  State_145554_Name = {
    Text = "위를 향한 추락"
  },
  State_145554_WeaponDesc = {
    Text = "탐색 시작 후, 1장의 <Falltospace1[StateArg3]:「인세로의 내딛음」>을 덱에 추가합니다. 「인세로의 내딛음」: 행동력 0 소모. 모든 적에게 장착자 공격력 <WeaponEffect_Num:[StateArg1]%> 및 최대 HP <WeaponEffect_Num:[Float:StateArg4]%>의 잠금 <Corrosion:부식> 피해를 주고, 각 위치의 다른 깨어남체의 명령 카드에 <ErosionColorInkKeywords:인지 착란>을 부여하며 1장의 <Falltospace2[StateArg3]:「위를 향한 추락」>을 드오루 덱에 셔플한다. <RetainIconKeywords:보존>. <DepleteIconKeywords:소모>"
  },
  State_145572_Desc = {
    Text = "매 턴 시작 시, 다른 모든 깨어남체가 <Damage:[Damage:Layer]> 관통 피해를 입힙니다."
  },
  State_145572_Name = {
    Text = "고래를 삼킨 폭풍"
  },
  State_145590_Desc = {
    Text = "동일한 귀속의 동일한 카드가 손패에 들어올 때 융합 효과가 발동되며 해당 카드를 소비합니다."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:융합>"
  },
  State_145592_Desc = {
    Text = "적 하나를 잠금하여 우선 공격 대상으로 삼습니다. 단일 대상 선택 시 잠금 대상만 선택할 수 있으며, 도발과 은신을 무시합니다."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:잠금>"
  },
  State_145619_Name = {Text = "중상"},
  State_145620_Name = {Text = "공허"},
  State_145621_Desc = {
    Text = "「선물」 효과가 50% 감소합니다."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:허풍>"
  },
  State_145622_Name = {Text = "둔화"},
  State_145623_Desc = {
    Text = "자신에게 무작위로 1가지 다른 효과를 부여합니다: 2턴 허약, 2턴 손상, 2턴 치명타, 최대 HP 1%에 해당하는 중독 부여, 2스택 공허, 손 안의 무작위 카드 2장에 1스택 둔화 부여, 임시 증상 카드 2장 생성(전투 간 계승 불가)하여 드로우 덱 상단에 추가."
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:은폐된 살의>"
  },
  State_145624_Name = {Text = "허약"},
  State_145625_Name = {
    Text = "동일한 임시 「증상 카드」 2장"
  },
  State_145626_Name = {Text = "손상"},
  State_145627_Name = {Text = "중독"},
  State_145628_Desc = {
    Text = "2턴 후 「선물」 효과를 획득합니다."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:놓쳐진 기회>"
  },
  State_145631_Desc = {
    Text = "「타격」 피해 증가 [StateArg1]% 및 <PVPPunctureDamagewords:관통 피해>로 변경됩니다."
  },
  State_145631_Name = {
    Text = "하늘의 추락"
  },
  State_145632_Desc = {
    Text = "이 카드는 명륜 「행운의 시간」에서 왔습니다."
  },
  State_145632_Name = {
    Text = "행운의 시간"
  },
  State_145638_Desc = {
    Text = "이 카드의 행동력 소비가 [Layer] 증가합니다."
  },
  State_145638_Name = {
    Text = "잔혹한 인사"
  },
  State_145642_Desc = {
    Text = "2턴 후 모든 각성체가 [StateArg1] 점의 광기를 [Layer] 회 획득합니다."
  },
  State_145642_Name = {
    Text = "지연 광기"
  },
  State_145644_Desc = {
    Text = "2턴 후 은열쇠 에너지 <Posse:[StateArg1]>점을 [Layer]회 획득합니다."
  },
  State_145644_Name = {
    Text = "지연 은열쇠 에너지"
  },
  State_145645_Desc = {
    Text = "2턴 후 모든 적의 <ExhaustionIconKeywords:힘>을 [StateArg1]점 임시 감소시킵니다 [Layer]회."
  },
  State_145645_Name = {
    Text = "지연 쇠약"
  },
  State_145646_Desc = {
    Text = "2턴 후 행동력 [StateArg1]점을 [Layer]회 획득합니다."
  },
  State_145646_Name = {
    Text = "지연 행동력"
  },
  State_145647_Desc = {
    Text = "2턴 후 <PowerIconKeywords:힘> [StateArg1]점을 [Layer]회 획득합니다."
  },
  State_145647_Name = {Text = "지연 힘"},
  State_145648_Desc = {
    Text = "2턴 후 카드를 [StateArg1] 장 [Layer] 회 드로우합니다."
  },
  State_145648_Name = {
    Text = "지연 드로우"
  },
  State_145649_Desc = {
    Text = "2턴 후 임시 피해 증폭 [StateArg1]% [Layer] 회."
  },
  State_145649_Name = {
    Text = "지연 임시 피해 증폭"
  },
  State_145652_Desc = {
    Text = "이 카드의 행동력 소모가 [Layer] 감소한다."
  },
  State_145652_Name = {
    Text = "견딜 수 없는 자유"
  },
  State_145654_Desc = {
    Text = "테스트. 사용 후, 또는 손패에서 벗어난 후, 파괴."
  },
  State_145654_Name = {
    Text = "테스트. 순간"
  },
  State_145660_Desc = {
    Text = "아군\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\n적군\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "리셋 후 HP 변화"
  },
  State_145693_Desc = {
    Text = "턴 종료 후, 행동력 소모가 [Layer] 감소하며, 버려진 후에도 이 효과가 발동된다."
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:예비[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_145694_Name = {
    Text = "흑소와의 공생"
  },
  State_145698_Desc = {
    Text = "잠금된 <StatusApplier:>을 우선 공격하며, 단일 대상 선택 시 잠금 대상만 선택 가능하고 도발과 은신을 무시합니다."
  },
  State_145698_Name = {Text = "잠금"},
  State_145699_Desc = {
    Text = "·잠금된 <StatusApplier:>을 우선 공격하며, 단일 대상 선택 시 잠금 대상만 선택 가능하고 도발과 은신을 무시합니다.\n·자신이 사망한 후 <StatusApplier:>가 「<PVPDerivativeCardKeywords_32:덤벼라!>」를 획득합니다."
  },
  State_145699_Name = {Text = "잠금"},
  State_145709_Desc = {
    Text = "스택당 카라부 체력의 10%에 해당하는 최대 HP가 증가하며, 「과식」은 최대 50스택까지 쌓입니다. 이 상태를 획득할 때 이미 상한에 도달한 경우, 초과 1스택마다 동일량의 3배에 해당하는 HP를 회복합니다. 보스전이 아닌 전투 1회당 최대 10스택의 「과식」을 획득할 수 있습니다. 전투 종료 시 제거되지 않습니다."
  },
  State_145709_Name = {
    Text = "<WormGrowth1:포식>"
  },
  State_145710_Desc = {
    Text = "당신도 축복의 일부랍니다~. 카라부의 광기 폭발로 소모되어 버프를 획득할 수 있으며, 이 상태는 최대 5스택까지 쌓입니다. 전투 종료 후 제거되지 않습니다."
  },
  State_145710_Name = {
    Text = "<SacrificialMark1:봉헌>"
  },
  State_145901_Desc = {
    Text = "아군\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]"
  },
  State_145901_Name = {
    Text = "리셋 후 HP 변화"
  },
  State_146041_Desc = {
    Text = "해당 각성체가 세속의 소란에서 벗어난 듯한 느낌을 받는다.\n·턴 종료 전까지 어떠한 행동도 할 수 없으며, 피해를 99% 감소시킨다. 대상에게 내성이 없을 경우 대상에게 내성을 부여한다.\n·효과 종료 시 아군 전체에게 <Damage:[Layer]> 의 순수 피해를 입힌다.\n·부여 시 대상이 내성을 보유하고 있을 경우, 즉시 기만을 종료하고 대상에게 입히는 피해가 2배가 된다."
  },
  State_146041_Name = {Text = "기만"},
  State_146043_Desc = {
    Text = "다음 턴 시작 시, [Layer] 광기를 차감합니다."
  },
  State_146043_Name = {
    Text = "지연 광기 차감"
  },
  State_146058_Desc = {
    Text = "테스트 진행 수치, 턴 시작 후 또는 카드 사용 후 갱신. 현재 공격 효율: [Layer]%."
  },
  State_146058_Name = {
    Text = "은열쇠 공격 효율"
  },
  State_146059_Desc = {
    Text = "테스트 진행 수치, 턴 시작 후 또는 카드 사용 후 갱신. 현재 방어 효율: [Layer]%."
  },
  State_146059_Name = {
    Text = "은열쇠 방어 효율"
  },
  State_146079_Desc = {
    Text = "이 카드가 손패에서 나간 후 손패로 돌아온다."
  },
  State_146079_Name = {
    Text = "<Recycle:회수>"
  },
  State_146085_Desc = {
    Text = "이번 턴 사용 전 카드 행동력 변경"
  },
  State_146085_Name = {
    Text = "이번 턴 사용 전 카드 행동력 변경"
  },
  State_146085_WeaponDesc = {
    Text = "플레이 전에 카드의 산출력을 변경"
  },
  State_146086_Desc = {
    Text = "이번 턴 사용 전 카드 행동력 변경"
  },
  State_146086_Name = {
    Text = "이번 턴 사용 전 카드 행동력 변경"
  },
  State_146086_WeaponDesc = {
    Text = "플레이 전에 카드의 산출력을 변경"
  },
  State_146117_Desc = {
    Text = "「<DerivativeCardKeywords_157:검의 뼈>」에 의해 소모되어 버프를 획득할 수 있습니다. 이 상태는 최대 15스택까지 쌓입니다."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:전의>"
  },
  State_146129_Desc = {
    Text = "모든 깨어남체의 최종 피해 +[Layer]%."
  },
  State_146129_Name = {
    Text = "별하늘 고래의 살의"
  },
  State_146147_Desc = {
    Text = "「<DerivativeCardKeywords_157:검의 뼈>」에 의해 소모되어 버프를 획득할 수 있습니다. 이 상태는 최대 15스택까지 쌓입니다."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:전의>"
  },
  State_146154_Desc = {
    Text = "해당 깨어남체가 기분 좋게 느끼도록 합니다. 해당 깨어남체의 「스킬」이 「축복?」으로 변화되며, 변화 후 동일한 스택 수를 소비합니다."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:축복>"
  },
  State_146155_Desc = {
    Text = "이 깨어남체의 컨디션이 좋습니다.\n·앞으로 [Layer] 장의 「스킬」이 「축복?」으로 변화되며, 변화 후 동일한 스택 수를 소모합니다."
  },
  State_146155_Name = {Text = "축복"},
  State_146155_WeaponDesc = {Text = "아니요"},
  State_146202_Desc = {
    Text = "해당 각성체가 세속의 소란에서 벗어난 듯한 느낌을 받게 한다.\n·턴 종료 전까지 어떠한 행동도 할 수 없으며, 피해를 99% 감소시킨다. 대상에게 내성이 없을 경우 대상에게 내성을 부여한다.\n·효과 종료 시 아군 전체에게 동일한 스택 수만큼의 순수 피해를 입힌다.\n·부여 시 대상이 내성을 보유하고 있을 경우, 즉시 기만을 종료하고 대상에게 입히는 피해가 2배가 된다."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:현혹>"
  },
  State_146352_Desc = {
    Text = "피해를 받을 때마다 1회당 [StateArg1]스택의 <Shimieluotanhuodong1:전의>를 쌓습니다."
  },
  State_146352_Name = {Text = "투혼"},
  State_146363_Desc = {
    Text = "다음 턴 시작 시, [Layer] HP를 제거합니다. HP를 잃을 때 동일한 양만큼 이 상태의 스택 수가 감소합니다."
  },
  State_146363_Name = {
    Text = "거짓이 아닌 것"
  },
  State_146383_Desc = {
    Text = "상태 추가 후, 카드 사용 후, 각 깨어남체의 은열쇠 충전 레벨을 갱신하고 출력합니다."
  },
  State_146383_Name = {
    Text = "효율 입구"
  },
  State_146384_Desc = {
    Text = "P1값 [StateArg1], P2값 [StateArg2], P3값 [StateArg3], P4값 [StateArg4]."
  },
  State_146384_Name = {Text = "효율 값"},
  State_146385_Desc = {
    Text = "상태 추가 후, 카드 사용 후, 각 깨어남체의 은열쇠 충전 레벨을 갱신하고 출력합니다."
  },
  State_146385_Name = {
    Text = "레벨 입구"
  },
  State_146386_Desc = {
    Text = "P1값 [StateArg1], P2값 [StateArg2], P3값 [StateArg3], P4값 [StateArg4]."
  },
  State_146386_Name = {Text = "레벨 값"},
  State_146446_Desc = {
    Text = "깨어남체 방어력, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "방어 속성 목록"
  },
  State_146448_Desc = {
    Text = "깨어남체 공격력, P1: 힘[StateArg1] 강도[StateArg2], P2: 힘[StateArg3] 강도[StateArg4], P3: 힘[StateArg5] 강도[StateArg6], P4: 힘[StateArg7] 강도[StateArg8]."
  },
  State_146448_Name = {
    Text = "공격 속성 목록"
  },
  State_146452_Desc = {
    Text = "팀 유니크: 장착자의 「타격」 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 턴 종료 시 장착자의 다음 광기 폭발 치명타 피해가 증가하며, 증가 비율은 광기 최대치의 <WeaponEffect_Num:[StateArg2]%>와 동일하고, 최대 5회 중첩됩니다."
  },
  State_146452_WeaponDesc = {
    Text = "장착자의 「타격」 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 턴 종료 시 장착자의 다음 광기 폭발 치명타 피해가 <WeaponEffect_Num:[DescArg1]%> 증가하며, 최대 5회 중첩됩니다(현재 [DescArg2]% 적용 중)."
  },
  State_146456_Desc = {
    Text = "팀 유니크: 장착자의 「타격」 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_146456_WeaponDesc = {
    Text = "장착자의 「타격」 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_146534_Desc = {
    Text = "단계 시작 후, 원초 혼돈 각 메커니즘의 컨테이너를 수호자에게 추가합니다."
  },
  State_146534_Name = {
    Text = "원초 혼돈 초기화"
  },
  State_146535_Desc = {
    Text = "속성 컨테이너."
  },
  State_146535_Name = {
    Text = "원초 혼돈 식별자"
  },
  State_146536_Desc = {
    Text = "메커니즘 컨테이너."
  },
  State_146536_Name = {
    Text = "원초 혼돈 메커니즘"
  },
  State_146644_Desc = {
    Text = "영지 깨어남은 예비 1을 획득하며, 매 턴 첫 번째로 사용 시 보유한 은열쇠를 자동으로 해방한다."
  },
  State_146644_Name = {
    Text = "원초의 메아리"
  },
  State_146645_Desc = {
    Text = "신 혼돈 영역에서 매 턴 첫 번째로 영지 깨어남을 사용할 때 보유한 은열쇠를 자동으로 해방한다. 현재 사용 가능."
  },
  State_146645_Name = {
    Text = "사용 가능 표식"
  },
  State_146646_Desc = {
    Text = "기본 은열쇠 에너지 상한이 2000으로 변경된다. 은열쇠 에너지 획득 규칙이 다음으로 대체된다: 깨어남체가 매 턴 첫 번째로 명령 카드를 사용할 때, 은열쇠 충전 레벨의 3배 + 100의 은열쇠 에너지를 획득한다."
  },
  State_146646_Name = {
    Text = "신 혼돈 열쇠의 힘 규칙"
  },
  State_146651_Desc = {
    Text = "이 깨어남체의 공격력 속성을 [Layer]% 높인다."
  },
  State_146651_Name = {
    Text = "혼돈·공격"
  },
  State_146652_Desc = {
    Text = "전투 시작 후 1회에 한해, 각 깨어남체의 은열쇠 충전 효율을 은열쇠 충전 레벨의 평균값으로 변경한다."
  },
  State_146652_Name = {
    Text = "원초 균형"
  },
  State_146653_Desc = {
    Text = "이 깨어남체의 방어력 속성을 [Layer]% 높입니다."
  },
  State_146653_Name = {
    Text = "혼돈·방어"
  },
  State_146663_Desc = {
    Text = "다음 [Layer]장의 침식·로탄의 「타격」이 추가 1회 발동합니다."
  },
  State_146663_Name = {
    Text = "고래를 삼킨 폭풍"
  },
  State_147058_Name = {
    Text = "장식품 36호실타래의 고리"
  },
  State_147079_Desc = {
    Text = "이 카드는 버릴 수 없으며, 변화할 수 없습니다."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:강제 보존>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 미설정"
  },
  State_147545_Name = {
    Text = "저무는 별·틴커트 SR(임시 텍스트)"
  },
  State_147546_Name = {Text = "폐기"},
  State_147546_WeaponDesc = {
    Text = "경계 너머의 목소리"
  },
  State_147584_Desc = {
    Text = "다음에 사용하는 <DerivativeCardKeywords_152:「선녀의 은총」>의 <Blessing:은총> 효과가 50% 증가"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [StateArg1] <MaxHPKeywords:최대 HP>를 획득한다. 턴 시작 시, 적 전체에게 <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:출혈> 피해를 입힌다,"
  },
  State_147737_Name = {
    Text = "어둠에서 어둠으로"
  },
  State_147764_Name = {
    Text = "상태@카라부 활동 오선택 카운트"
  },
  State_147765_Desc = {
    Text = "다음 턴 시작 시 행동력 2점을 잃고 드로우 수가 2장 감소한다."
  },
  State_147765_Name = {
    Text = "로열 마리 초콜릿"
  },
  State_147768_Desc = {
    Text = "다음 턴 시작 시 [DescArg1] 장의 상급 영감을 획득한다."
  },
  State_147768_Name = {
    Text = "로열 마리 골드"
  },
  State_147769_Desc = {
    Text = "이번 전투에서 「과식」이 현재 [Layer] 중첩되어 있습니다."
  },
  State_147769_Name = {
    Text = "중첩 제한"
  },
  State_147772_Name = {
    Text = "상태@카라부 활동 임시 열쇠의 힘 상한 추가"
  },
  State_147773_Name = {
    Text = "상태@카라부 활동 임시 열쇠의 힘 상한 추가"
  },
  State_147774_Name = {
    Text = "상태@카라부 활동 임시 열쇠의 힘 상한 추가_일반 혼돈"
  },
  State_147797_Desc = {
    Text = "광기, <PowerIconKeywords:힘>, HP, 은열쇠 에너지, 행동력 및 드로우를 획득하거나 잃을 수 있습니다."
  },
  State_147797_Name = {
    Text = "로열 마리 초콜릿"
  },
  State_147800_Desc = {
    Text = "다음 턴 시작 시 행동력 2점을 잃고 드로우 수가 2장 감소한다."
  },
  State_147800_Name = {
    Text = "로열 마리 초콜릿"
  },
  State_147869_Name = {
    Text = "[Layer]장 카드 뽑기"
  },
  State_147870_Name = {
    Text = "전체 적에게 [Layer]턴 허약 부여"
  },
  State_147871_Name = {
    Text = "광기 [Energy:DescArg1]pt 획득"
  },
  State_147872_Name = {
    Text = "전체 적에게 [Layer]턴 취약 부여"
  },
  State_147873_Name = {
    Text = "[Layer] 행동력 획득"
  },
  State_147874_Name = {
    Text = "[Block:DescArg1] 실타래드 획득"
  },
  State_147962_Desc = {
    Text = "이후 플레이어가 「<DerivativeCardKeywords_158:대죄>」를 사용할 때 <MonsterSinMarkKeywords:죄인> 스택을 50%만 해제하며, 명령 카드를 1장 사용할 때마다 「성자·백야」가 <MonsterSinMarkKeywords:죄인> 1 스택을 획득합니다."
  },
  State_147962_Name = {
    Text = "정화의 길"
  },
  State_147967_Desc = {
    Text = "「성자·백야」가 가하는 피해에 [DescArg1]%의 <BleedingIconKeywords:출혈>을 추가합니다."
  },
  State_147967_Name = {Text = "죄인"},
  State_147968_Desc = {
    Text = "최대 3 스택. 공격 의도로 전환 시, 「성자·백야」가 가하는 피해를 25% 증가시키고 1 스택을 소모합니다."
  },
  State_147968_Name = {
    Text = "고통 구원"
  },
  State_147969_Desc = {
    Text = "「성자·백야」가 「성심」 의도 상태일 때, 명령 카드를 1장 사용할 때마다 <MonsterPolluxFever:광열> 2 스택을 쌓습니다."
  },
  State_147969_Name = {
    Text = "신의 새 계약"
  },
  State_147971_Desc = {
    Text = "이 각성체는 아직 각성하지 않았습니다… 쓰러지기 직전에 HP를 회복하고 <InvincibleUntilRoused:은심 고정> 1 스택을 획득하며, 각성 후 <InvincibleUntilRoused:은심 고정>을 해제하고 진정한 형태로 전투를 시작합니다."
  },
  State_147971_Name = {
    Text = "미깨어남"
  },
  State_147972_Desc = {
    Text = "스택당 「성자·백야」가 가하는 피해에 1% <BleedingIconKeywords:출혈>을 추가합니다."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:죄의 인장>"
  },
  State_147974_Desc = {
    Text = "턴 시작 후 해제됩니다. 10 스택에 도달하면, 다음에 카드를 사용한 직후 즉시 행동하고, 광열을 제거하며 의도를 「성심」으로 전환합니다."
  },
  State_147974_Name = {
    Text = "임시 열광"
  },
  State_147975_Desc = {
    Text = "전투 시작 시, 「<DerivativeCardKeywords_158:대죄>」 1장을 손패에 넣고, 턴 종료 후 <MonsterSinMarkKeywords:죄인> 5 스택을 획득합니다."
  },
  State_147975_Name = {
    Text = "등불의 전령"
  },
  State_147993_Desc = {
    Text = "최대 3 스택. 공격 의도로 전환 시, 「성자·백야」가 가하는 피해를 25% 증가시키고 1 스택을 소모합니다."
  },
  State_147993_Name = {
    Text = "고통 구원"
  },
  State_148020_Desc = {
    Text = "모든 피해에 면역되고 HP를 잃을 수 없으며, 각성 후 제거됩니다."
  },
  State_148020_Name = {
    Text = "은심 잠금"
  },
  State_148021_Name = {
    Text = "상태@몬스터 공용 소생 각성 전 면역 해제 표식"
  },
  State_148073_Name = {
    Text = "카드 1장을 뽑습니다"
  },
  State_148074_Desc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:유지>"
  },
  State_148074_WeaponDesc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_148076_Name = {
    Text = "정화의 길 카드 사용 감지"
  },
  State_148116_Desc = {
    Text = "1턴 후 카드를 [StateArg1] 장 [Layer] 회 드로우합니다."
  },
  State_148116_Name = {
    Text = "드로우 지연1"
  },
  State_148381_Desc = {
    Text = "턴 종료까지 자신이 가하는 피해에 100% <BleedingIconKeywords:출혈>을 추가합니다."
  },
  State_148381_Name = {
    Text = "사슬에 묶인 원한"
  },
  State_148383_Desc = {
    Text = "최대 3 스택. 「증오」를 3 스택 보유 중이라면, 다음에 의도가 「선혈의 사슬」로 전환될 때 의도를 「피에 굶주린 철구」로 전환하고 「증오」를 해제합니다."
  },
  State_148383_Name = {
    Text = "「증오」"
  },
  State_148385_Desc = {
    Text = "적이 명령 카드를 사용할 때마다 <MonsterB05EXFever:임시 열광> 2 스택을 획득합니다."
  },
  State_148385_Name = {
    Text = "불규칙한 형태"
  },
  State_148386_Desc = {
    Text = "턴 종료까지 방어막을 획득할 수 없습니다."
  },
  State_148386_Name = {
    Text = "속박의 사슬"
  },
  State_148387_Desc = {
    Text = "이 각성체는 아직 각성하지 않았습니다… 쓰러지기 직전에 HP를 회복하고 <InvincibleUntilRoused:은심 고정> 1 스택을 획득하며, 각성 후 <InvincibleUntilRoused:은심 고정>을 해제하고 진정한 형태로 전투를 시작합니다."
  },
  State_148387_Name = {
    Text = "미깨어남"
  },
  State_148391_Desc = {
    Text = "턴 종료까지 자신이 가하는 피해에 100% <BleedingIconKeywords:출혈>을 추가합니다."
  },
  State_148391_Name = {
    Text = "속박의 사슬"
  },
  State_148392_Desc = {
    Text = "턴 시작 후 해제됩니다. 10 스택에 도달하면, 다음에 카드를 사용한 직후 즉시 행동하고, 광열을 제거하며 의도를 「선혈의 사슬」로 전환합니다."
  },
  State_148392_Name = {
    Text = "임시 열광"
  },
  State_148394_Desc = {
    Text = "턴 시작 시 <ResentChainsKeywords:증오의 사슬> 1 스택을 획득합니다. 의도가 「피에 굶주린 철구」로 전환될 때, 적의 턴 종료까지 모든 피해와 HP 손실 효과에 면역됩니다."
  },
  State_148394_Name = {
    Text = "영혼 사냥 선언"
  },
  State_148395_Desc = {
    Text = "모든 피해(관통 피해 포함)에 면역되며 HP를 잃을 수 없습니다. 적의 턴 종료 후 제거됩니다."
  },
  State_148395_Name = {
    Text = "영혼을 거두리-피에 굶주린 철구"
  },
  State_148421_Desc = {
    Text = "1턴 후 모든 적의 <ExhaustionIconKeywords:힘>을 임시로 [StateArg1] 점 감소시킵니다 [Layer] 회"
  },
  State_148421_Name = {
    Text = "지연 고갈1"
  },
  State_148422_Desc = {
    Text = "1턴 후 임시 피해 증폭 [StateArg1]% [Layer] 회."
  },
  State_148422_Name = {
    Text = "지연 임시 피해 증폭1"
  },
  State_148423_Desc = {
    Text = "1턴 후 <Posse:[StateArg1]> 점의 은열쇠 에너지를 [Layer] 회 획득합니다."
  },
  State_148423_Name = {
    Text = "지연 은열쇠 에너지1"
  },
  State_148426_Desc = {
    Text = "1턴 후 [StateArg1] 점의 행동력을 [Layer] 회 획득합니다."
  },
  State_148426_Name = {
    Text = "지연 행동력1"
  },
  State_148427_Desc = {
    Text = "1턴 후 모든 각성체가 [StateArg1] 점의 광기를 [Layer] 회 획득합니다."
  },
  State_148427_Name = {
    Text = "광기 지연1"
  },
  State_148428_Desc = {
    Text = "1턴 후 [StateArg1] 점의 <PowerIconKeywords:힘>을 [Layer] 회 획득합니다."
  },
  State_148428_Name = {
    Text = "지연 힘1"
  },
  State_148511_Desc = {
    Text = "팀 유니크: 탐색 시작 후, <Backupbody[StateArg3]:「영혼의 동조」> 카드 1장을 덱에 추가합니다. 「영혼의 동조」: 행동력 소비 0, 사용 후 행동력 1 포인트 획득. <RetainIconKeywords:보존>: 장착자 체력의 <WeaponEffect_Num:[StateArg1]%>에 해당하는 고정 HP 회복량과 <WeaponEffect_Num:[StateArg2]> 포인트의 고정 광기를 이 카드에 축적합니다. 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 <DestructionKeywords:파괴>합니다."
  },
  State_148511_Name = {
    Text = "영혼의 동조"
  },
  State_148511_WeaponDesc = {
    Text = "탐색 시작 후, <Backupbody[StateArg3]:「영혼의 동조」> 카드 1장을 덱에 추가합니다. 「영혼의 동조」: 행동력 소비 0, 사용 후 행동력 1 포인트 획득. <RetainIconKeywords:보존>: 장착자 체력의 <WeaponEffect_Num:[StateArg1]%>에 해당하는 고정 HP 회복량과 <WeaponEffect_Num:[StateArg2]> 포인트의 고정 광기를 이 카드에 축적합니다. 이 카드가 파괴되지 않은 경우, 한 번의 사망을 면역하고 축적된 모든 HP 회복량과 광기를 방출한 후 이 카드를 <DestructionKeywords:파괴>합니다."
  },
  State_148513_Desc = {
    Text = "상대 턴 종료 시 손패를 버리지 않는다. 턴 종료 시 순서대로 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <HeavyInjuryKeywords:중상>, <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  State_148513_Name = {
    Text = "경계 너머의 목소리"
  },
  State_148520_Desc = {
    Text = "턴 종료까지 방어막을 획득할 수 없습니다."
  },
  State_148520_Name = {
    Text = "사슬에 묶인 원한"
  },
  State_148522_Desc = {
    Text = "팀 유니크: 장착자의 「광기 폭발」이 주는 보호막과 힘이 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_148524_Desc = {
    Text = "팀 유니크: 장착자의 「광기 폭발」이 주는 보호막과 힘이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 장착자의 「방어」가 주는 보호막이 <WeaponEffect_Num:[StateArg2]%> 증가합니다. 장착자가 「방어」를 사용한 후 장착자 공격력의 <WeaponEffect_Num:[StateArg3]%>에 해당하는 힘을 획득합니다."
  },
  State_148540_Desc = {
    Text = "지연[Layer] : <AwakerName:[DescArg1]>의 행동력이 가장 높은 [StateArg1]장의 명령 카드의 행동력 소비가 [StateArg2] 감소합니다."
  },
  State_148540_Name = {
    Text = "예지의 거울 - 지연[Layer]"
  },
  State_148541_Name = {
    Text = "손에서 선택한 각성체 카드의 「둔화」 효과 제거"
  },
  State_148544_Desc = {
    Text = "지연[Layer] : <AwakerName:[DescArg1]>의 다음 광기 폭발 시 광기 1점 소비할 때마다 은열쇠 에너지를 [StateArg1]점 획득합니다."
  },
  State_148544_Name = {
    Text = "악마의 열쇠 - 지연[Layer]"
  },
  State_148547_Desc = {
    Text = "<AwakerName:[DescArg1]> 다음 광기 폭발은 초월 폭발로 간주하며, 이미 초월 폭발인 경우 광기 최대치의 100%를 반환합니다."
  },
  State_148547_Name = {
    Text = "영원의 관"
  },
  State_148548_Desc = {
    Text = "보존: 모든 각성체가 광기 5점 획득."
  },
  State_148548_Name = {
    Text = "그림자에 스며들다"
  },
  State_148549_Name = {
    Text = "손에 있는 모든 「예비」 효과 발동"
  },
  State_148553_Desc = {
    Text = "지연[Layer] : <AwakerName:[DescArg1]>이(가) 다음에 사용하는 [Layer]장의 명령 카드가 손실된 HP의 [StateArg2]%에 해당하는 방어막을 획득합니다."
  },
  State_148553_Name = {
    Text = "유혹의 열매 - 지연[Layer]"
  },
  State_148554_Desc = {
    Text = "<AwakerName:[DescArg1]>의 명령 카드가 주는 피해에 [Layer]% 출혈을 추가로 부여합니다."
  },
  State_148554_Name = {
    Text = "필멸의 눈"
  },
  State_148556_Desc = {
    Text = "손에 있을 때, 모든 각성체가 능동 피해를 줄 때 10% 출혈을 추가로 부여합니다."
  },
  State_148556_Name = {
    Text = "악몽은 예정대로 찾아오고"
  },
  State_148557_Desc = {
    Text = "<AwakerName:[DescArg1]>이(가) 다음에 사용하는 [Layer]장의 명령 카드가 손실된 HP의 [StateArg1]%에 해당하는 방어막을 획득합니다."
  },
  State_148557_Name = {
    Text = "유혹의 열매"
  },
  State_148559_Desc = {
    Text = "<AwakerName:[DescArg1]>의 다음 광기 폭발 시 광기 1점 소비할 때마다 은열쇠 에너지를 [Layer]점 획득합니다."
  },
  State_148559_Name = {
    Text = "악마의 열쇠"
  },
  State_148561_Desc = {
    Text = "이 카드를 사용할 때, 다음 세 가지 부정적 효과 중 하나를 무작위로 발동합니다: 효과 50% 감소/2턴 지연 후 발동/무작위로 부정적 효과 1개 획득."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:왜곡된 소망>"
  },
  State_148562_Name = {
    Text = "선택한 각성체가 광기 10점 획득"
  },
  State_148563_Desc = {
    Text = "지연[Layer] : <AwakerName:[DescArg1]>의 다음 광기 폭발 시 획득하는 방어막과 HP 회복이 [StateArg1]% 증가합니다."
  },
  State_148563_Name = {
    Text = "공정의 깃털 - 지연[Layer]"
  },
  State_148566_Desc = {
    Text = "<AwakerName:[DescArg1]>의 다음 광기 폭발이 주는 피해에 [Layer]% 운명 재단을 추가로 부여합니다."
  },
  State_148566_Name = {
    Text = "운명의 실타래"
  },
  State_148569_Desc = {
    Text = "<AwakerName:[DescArg1]>의 다음 광기 폭발 시 획득하는 방어막과 HP 회복이 [Layer]% 증가합니다."
  },
  State_148569_Name = {
    Text = "공정의 깃털"
  },
  State_148571_Desc = {
    Text = "지연[Layer] : <AwakerName:[DescArg1]>의 명령 카드가 주는 피해에 [StateArg1]% 출혈을 추가로 부여합니다."
  },
  State_148571_Name = {
    Text = "필멸의 눈 - 지연[Layer]"
  },
  State_148574_Desc = {
    Text = "지연[Layer] : <AwakerName:[DescArg1]>의 다음 광기 폭발이 주는 피해에 [StateArg1]% 운명 재단을 추가로 부여합니다."
  },
  State_148574_Name = {
    Text = "운명의 실 - 지연[Layer]"
  },
  State_148575_Name = {
    Text = "선택한 각성체가 광기 20점 획득"
  },
  State_149089_Name = {
    Text = "상태@등불견 소형 삼킴 광기 표식"
  },
  State_149092_Desc = {
    Text = "「<AwakerName:[DescArg1]>」의 광기 <Energy:[Energy:DescArg2]> 포인트를 삼켰으며, 사망 후 반환됩니다."
  },
  State_149092_Name = {Text = "삼킴"},
  State_149094_Desc = {
    Text = "팀 유니크: 장착자의 광기 폭발이 주는 기초 보호막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 장착자가 <WeaknessIconKeywords:허약>을 유발하는 명령 카드를 사용한 후, 다음 장착자의 명령 카드가 주는 기초 보호막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 「진홍빛 용광로」 사용 시 장착자의 행동력 소비가 가장 높은 스킬 카드 1장을 뽑고, <EmbryoFusionIconKeywords:배아 융합> +<WeaponEffect_Num: [StateArg1]>, 3턴 쿨다운."
  },
  State_149094_WeaponDesc = {
    Text = "장착자의 광기 폭발이 주는 기초 보호막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 장착자가 <WeaknessIconKeywords:허약>을 유발하는 명령 카드를 사용한 후, 다음 장착자의 명령 카드가 주는 기초 보호막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 「진홍빛 용광로」 사용 시 장착자의 행동력 소비가 가장 높은 스킬 카드 1장을 뽑고, <EmbryoFusionIconKeywords:배아 융합> +<WeaponEffect_Num: [StateArg1]>, 3턴 쿨다운."
  },
  State_149122_Desc = {
    Text = "사망 후 즉시 무작위 「하티 사냥 무리」 또는 「스콜 사냥 무리」 1명을 소환하여 해당 개체의 「군집 효과」를 1 스택 감소시킵니다."
  },
  State_149122_Name = {
    Text = "군집 효과"
  },
  State_149123_Desc = {
    Text = "광기 폭발로 받는 피해가 50% 감소합니다."
  },
  State_149123_Name = {
    Text = "심지화· 융"
  },
  State_149124_Desc = {
    Text = "명령 카드로 받는 피해가 50% 감소합니다."
  },
  State_149124_Name = {
    Text = "심지화· 암"
  },
  State_149125_Desc = {
    Text = "「<AwakerName:[DescArg1]>」의 명령 카드를 빙결시키며, 사망 후 해당 각성체의 빙결을 해제합니다."
  },
  State_149125_Name = {Text = "삼킴"},
  State_149126_Desc = {
    Text = "사망 후 즉시 무작위 「스콜 사냥 무리」 1명을 소환하여 해당 개체의 「군집 효과」를 1 스택 감소시킵니다."
  },
  State_149126_Name = {
    Text = "군집 효과"
  },
  State_149128_Name = {
    Text = "상태@빙설 등불견 소빙결 카드 식별"
  },
  State_149140_Desc = {
    Text = "적의 스킬을 강화시킨다. 피해를 받을 때마다 1스택을 잃는다."
  },
  State_149140_Name = {
    Text = "피의 맹세"
  },
  State_149143_Desc = {
    Text = "드로우 단계 종료 후, 적의 손패에 [DescArg1]장의 <SlowIconKeywords:둔화> 명령 카드가 있을 때마다 자신이 [DescArg2] 스택의 <BloodOath_New:피의 맹세>를 획득합니다. 자신이 막히지 않은 피해를 입힌 후 손패 또는 드로우 덱의 <SlowIconKeywords:둔화> 상태가 아닌 명령 카드 [DescArg3]장에 무작위로 [DescArg4] 스택의 <SlowIconKeywords:둔화>를 부여합니다."
  },
  State_149143_Name = {
    Text = "얼어붙은 피의 서약"
  },
  State_149162_Desc = {
    Text = "막히지 않은 피해를 줄 때, 죽음 저항을 제거합니다."
  },
  State_149162_Name = {
    Text = "극동의 마법"
  },
  State_149163_Desc = {
    Text = "최대 HP가 동일한 스택 수만큼 감소하며, 전투 종료 후 절반으로 줄어듭니다."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:뼈를 에는 일격>"
  },
  State_149164_Desc = {
    Text = "피해를 줄 때 뼈를 에는 일격을 부여합니다."
  },
  State_149164_Name = {
    Text = "사무치는 추위"
  },
  State_149167_Desc = {
    Text = "최대 HP가 [Layer] 감소하며, 전투 종료 후 절반으로 줄어듭니다."
  },
  State_149167_Name = {
    Text = "<BlueKeyWord:뼈를 에는 추위>"
  },
  State_149169_Desc = {
    Text = "스택당 카라부 체력의 15%에 해당하는 최대 HP가 증가하며, 「과식」은 최대 50스택까지 쌓입니다. 이 상태를 획득할 때 이미 상한에 도달한 경우, 초과 1스택마다 동일량의 3배에 해당하는 HP를 회복합니다. 보스전이 아닌 전투 1회당 최대 10스택의 「과식」을 획득할 수 있습니다. 전투 종료 시 제거되지 않습니다."
  },
  State_149169_Name = {
    Text = "<WormGrowth2:과식>"
  },
  State_149172_Desc = {
    Text = "팀 유니크: 장착자가 <WeaknessIconKeywords:허약>을 유발하는 명령 카드를 사용한 후, 다음 장착자의 명령 카드가 주는 기초 보호막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_149172_WeaponDesc = {
    Text = "장착자가 <WeaknessIconKeywords:허약>을 유발하는 명령 카드를 사용한 후, 다음 장착자의 명령 카드가 주는 기초 보호막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_149187_Desc = {
    Text = "테스트｜고정 피해를 받은 후, 고정 피해로 처치한 후를 감지하고, 발동 값과 연관자를 출력합니다."
  },
  State_149187_Name = {
    Text = "테스트 고정 피해"
  },
  State_149188_Desc = {
    Text = "테스트｜고정 피해로 처치 후, 트리거값1, 처치 실제 피해:[Layer]"
  },
  State_149188_Name = {
    Text = "테스트 고정 처치 트리거값2"
  },
  State_149189_Desc = {
    Text = "테스트｜고정 피해로 처치 후, 연관자2, 처치를 가한 출처:[Layer]"
  },
  State_149189_Name = {
    Text = "테스트 고정 처치 연관자2"
  },
  State_149190_Desc = {
    Text = "테스트｜고정 피해로 처치 후, 트리거값1, 처치 초과 피해:[Layer]"
  },
  State_149190_Name = {
    Text = "테스트 고정 처치 트리거값3"
  },
  State_149191_Desc = {
    Text = "테스트｜고정 피해를 받은 후, 트리거값1, 총 피해:[Layer]"
  },
  State_149191_Name = {
    Text = "테스트 고정 피해 트리거값1"
  },
  State_149192_Desc = {
    Text = "테스트｜고정 피해로 처치 후, 연관자1, 처치된 대상:[Layer]"
  },
  State_149192_Name = {
    Text = "테스트 고정 처치 연관자1"
  },
  State_149193_Desc = {
    Text = "테스트｜고정 피해를 받은 후, 연관자2, 피격자:[Layer]"
  },
  State_149193_Name = {
    Text = "테스트 고정 피해 연관자2"
  },
  State_149194_Desc = {
    Text = "테스트｜고정 피해를 받은 후, 트리거값1, 총 피해:[Layer]"
  },
  State_149194_Name = {
    Text = "테스트 고정 피해 트리거값2"
  },
  State_149195_Desc = {
    Text = "테스트｜고정 피해로 처치 후, 트리거값1, 처치 총 피해:[Layer]"
  },
  State_149195_Name = {
    Text = "테스트 고정 처치 트리거값1"
  },
  State_149196_Desc = {
    Text = "테스트｜고정 피해를 받은 후, 연관자1, 피해 출처:[Layer]"
  },
  State_149196_Name = {
    Text = "테스트 고정 피해 연관자1"
  },
  State_149227_Desc = {
    Text = "턴 종료 시 방어막이 사라지지 않습니다. 방어막 보유 시 광기 폭발 피해를 50% 더 받으며, 명령 카드로 받는 피해가 50% 감소합니다."
  },
  State_149227_Name = {
    Text = "눈막에 감춰진 자취"
  },
  State_149228_Desc = {
    Text = "피해를 줄 때 출혈을 부여합니다."
  },
  State_149228_Name = {Text = "관통혈"},
  State_149229_Desc = {
    Text = "등장 시 최대 HP의 25%를 잃고, 잃은 수치의 [DescArg1]%에 해당하는 「서리 방패」로 전환합니다."
  },
  State_149229_Name = {
    Text = "서리 방패 전환"
  },
  State_149230_Desc = {
    Text = "명령 카드 피해 증가 50%를 받고, 광기 폭발 피해 감소 50%를 받습니다."
  },
  State_149230_Name = {
    Text = "상태@암색 외투 피해 증감"
  },
  State_149232_Desc = {
    Text = "턴 종료 시 방어막이 사라지지 않습니다. 방어막 보유 시 명령 카드 피해 증가 50%를 받고, 광기 폭발 피해 감소 50%를 받습니다."
  },
  State_149232_Name = {
    Text = "암영에 감춰진 자취"
  },
  State_149233_Desc = {
    Text = "광기 폭발 피해 증가 50%를 받고, 명령 카드 피해 감소 50%를 받습니다."
  },
  State_149233_Name = {
    Text = "상태@설색 외투 피해 증감"
  },
  State_149234_Desc = {
    Text = "등장 시 최대 HP의 25%를 잃고, 잃은 수치의 [DescArg1]%에 해당하는 「저주 방패」로 전환합니다."
  },
  State_149234_Name = {
    Text = "저주 방패 전환"
  },
  State_149235_Desc = {
    Text = "막히지 않은 피해를 줄 때, 죽음 저항을 제거합니다."
  },
  State_149235_Name = {
    Text = "등불 주술"
  },
  State_149250_Desc = {
    Text = "받는 명령 카드 피해 +50%"
  },
  State_149250_Name = {
    Text = "받는 명령 카드 피해 +50%"
  },
  State_149251_Desc = {
    Text = "받는 명령 카드 피해 -50%"
  },
  State_149251_Name = {
    Text = "받는 명령 카드 피해 -50%"
  },
  State_149252_Desc = {
    Text = "받는 광기 폭발 피해 -50%"
  },
  State_149252_Name = {
    Text = "받는 광기 폭발 피해 -50%"
  },
  State_149253_Desc = {
    Text = "받는 광기 폭발 피해 +50%"
  },
  State_149253_Name = {
    Text = "받는 광기 폭발 피해 +50%"
  },
  State_149265_Desc = {
    Text = "사망 후 즉시 무작위 「웬디고」를 소환하고, 해당 개체의 「군집 효과」를 1층 감소시킵니다."
  },
  State_149265_Name = {
    Text = "군집 효과"
  },
  State_149268_Desc = {
    Text = "모든 방어막을 잃을 때, 임시 보강 75층을 획득하고 「눈보라 속으로 잠기다」 1층을 제거하며, 의도를 <BoneHitKeywords:뼈를 에는 일격>을 부여하는 강력한 공격으로 교체합니다."
  },
  State_149268_Name = {
    Text = "눈보라 속으로 잠기다"
  },
  State_149269_Desc = {
    Text = "모든 방어막을 잃을 때, 임시 보강 75층을 획득하고 「어둠 속으로 잠기다」 1층을 제거하며, 의도를 광기를 빼앗는 강력한 공격으로 교체합니다."
  },
  State_149269_Name = {
    Text = "어둠 속으로 잠기다"
  },
  State_149270_Desc = {
    Text = "사망 후 즉시 무작위 「웬디고」를 소환하고, 해당 개체의 「군집 효과」를 1층 감소시킵니다."
  },
  State_149270_Name = {
    Text = "군집 효과"
  },
  State_149308_Name = {
    Text = "상태@등불 기도자 둔화 스택 기록"
  },
  State_149391_Desc = {
    Text = "이 각성체는 아직 각성하지 않았습니다… 쓰러지기 직전에 HP를 회복하고 <InvincibleUntilRoused:은심 고정> 1 스택을 획득하며, 각성 후 <InvincibleUntilRoused:은심 고정>을 해제하고 진정한 형태로 전투를 시작합니다."
  },
  State_149391_Name = {
    Text = "미깨어남"
  },
  State_149398_Desc = {
    Text = "「백설 요정」의 의도가 「흩날리는 눈의 저주」로 전환될 때 1층을 소모하고, 의도를 「기적의 축복」으로 변경합니다."
  },
  State_149398_Name = {Text = "과식"},
  State_149399_Desc = {
    Text = "「백설 요정」이 「흠 없는 동화」를 사용한 후 다음 [DescArg1]개의 의도가 모두 「흩날리는 눈의 저주」가 됩니다. 매 턴 [DescArg2]장의 [DescArg3]층 <SlowIconKeywords:둔화>를 가진 무작위 <Blessing:축복> 카드를 덱에 셔플합니다."
  },
  State_149399_Name = {
    Text = "유혹하는 달콤한 열매"
  },
  State_149418_Desc = {
    Text = "크리티컬 불가, 기본 피해로 간주하지 않으며, 최종 피해 등의 보너스 영향을 받지 않음."
  },
  State_149418_Name = {
    Text = "<RealDamage:잠금 피해>"
  },
  State_149419_Name = {
    Text = "<Rune_6:철벽>"
  },
  State_149420_Name = {
    Text = "<Rune_3:묘수>"
  },
  State_149421_Name = {
    Text = "<Rune_15:폭발>"
  },
  State_149422_Name = {
    Text = "<Rune_4:계산>"
  },
  State_149423_Name = {
    Text = "<Rune_11:지배>"
  },
  State_149424_Name = {
    Text = "<Rune_12:흡혈>"
  },
  State_149425_Name = {
    Text = "<Rune_1:취약>"
  },
  State_149426_Name = {
    Text = "<Rune_14:난폭>"
  },
  State_149427_Name = {
    Text = "<Rune_2:허약>"
  },
  State_149428_Name = {
    Text = "<Rune_9:가시>"
  },
  State_149429_Name = {
    Text = "<Rune_10:독소>"
  },
  State_149430_Name = {
    Text = "<Rune_18:쇠약>"
  },
  State_149576_Desc = {
    Text = "「백설 요정」의 의도가 「흩날리는 눈의 저주」로 전환될 때 1층을 소모하고, 의도를 「기적의 축복」으로 변경합니다."
  },
  State_149576_Name = {Text = "과식"},
  State_149618_Desc = {
    Text = "2 턴 후, 다음 효과 발동:\n[DescArg1] 점 행동력 획득. \n[DescArg2] 점 힘 획득. \n[DescArg3] 점 은열쇠 에너지 획득. \n[DescArg5] 점 광기 획득. \n[DescArg6] 장 드로우.\n[DescArg7] 점 임시 피해 증폭 획득.\n모든 적의 힘을 임시로 [DescArg4] 점 감소시킨다."
  },
  State_149618_Name = {
    Text = "놓쳐진 기회2"
  },
  State_149619_Desc = {
    Text = "1턴 후, 다음 효과를 발동합니다:\n[DescArg1] 점의 행동력을 획득합니다. \n[DescArg2] 점의 힘을 획득합니다. \n[DescArg3] 점의 은열쇠 에너지를 획득합니다. \n[DescArg5] 점의 광기를 획득합니다. \n카드를 [DescArg6] 장 드로우합니다.\n[DescArg7] 점의 임시 피해 증폭을 획득합니다.\n모든 적의 힘을 임시로 [DescArg4] 점 감소시킵니다."
  },
  State_149619_Name = {
    Text = "놓쳐진 기회1"
  },
  State_149628_Desc = {
    Text = "턴 종료 전 적이 은열쇠 에너지를 1000점 이상 보유하고 있으면, 은열쇠 에너지 1000을 포식합니다."
  },
  State_149628_Name = {
    Text = "열쇠의 힘 봉헌"
  },
  State_149629_Desc = {
    Text = "턴 종료 전 광기가 가장 높은 각성체가 광기를 100점 이상 보유하고 있으면, 해당 각성체의 광기 50점을 포식합니다."
  },
  State_149629_Name = {
    Text = "광기 봉헌"
  },
  State_149630_Desc = {
    Text = "턴 종료 전 적이 은열쇠 에너지를 1000점 이상 보유하고 있으면, 은열쇠 에너지 1000을 포식합니다."
  },
  State_149630_Name = {
    Text = "열쇠의 힘 봉헌"
  },
  State_149631_Desc = {
    Text = "턴 종료 전 적이 행동력을 3점 이상 보유하고 있으면, 행동력 3점을 포식합니다."
  },
  State_149631_Name = {
    Text = "행동력 봉헌"
  },
  State_149632_Desc = {
    Text = "턴 종료 전 적이 행동력을 3점 이상 보유하고 있으면, 행동력 3점을 포식합니다."
  },
  State_149632_Name = {
    Text = "행동력 봉헌"
  },
  State_149633_Desc = {
    Text = "버리기 단계 전 적의 손패에 명령 카드가 4장 이상 남아 있으면, 무작위 명령 카드 2장을 포식합니다."
  },
  State_149633_Name = {
    Text = "카드 봉헌"
  },
  State_149634_Desc = {
    Text = "버리기 단계 전 적의 손패에 명령 카드가 4장 이상 남아 있으면, 무작위 명령 카드 2장을 포식합니다."
  },
  State_149634_Name = {
    Text = "카드 봉헌"
  },
  State_149635_Desc = {
    Text = "턴 종료 전 광기가 가장 높은 각성체가 광기를 100점 이상 보유하고 있으면, 해당 각성체의 광기 50점을 포식합니다."
  },
  State_149635_Name = {
    Text = "광기 봉헌"
  },
  State_149652_Desc = {
    Text = "크리티컬 불가, 해당 각성체가 입힌 피해로 간주하지 않음."
  },
  State_149652_Name = {
    Text = "<FixedDamage:순수 피해>"
  },
  State_149660_Desc = {
    Text = "이 카드가 주는 피해, 방어막, 힘 변화를 [DescArg2]% 증가시키고, 촉수 피해, HP 회복, 고정 중독, 고정 반격의 최종 효과를 [DescArg1]% 증가시키며, 사용 후 제거됩니다."
  },
  State_149660_Name = {
    Text = "강화 [DescArg1]"
  },
  State_149664_Desc = {
    Text = "1층마다 이 카드가 주는 피해, 고정 힘과 촉수 피해 증가, 고정 중독, 고정 반격 최종 효과를 2% 증가시키고; 고정 방어막, 고정 HP 회복, 힘 감소의 최종 효과를 1% 증가시키며, 사용 후 제거됩니다."
  },
  State_149664_Name = {Text = "강화"},
  State_149719_Name = {
    Text = "PVP 순수 피해 면역__「개발용 전용」"
  },
  State_149736_Desc = {
    Text = "다음 [Layer] 장의 <AwakerName:[DescArg1]> 명령 카드가 주는 기초 보호막이 [StateArg1]% 증가합니다."
  },
  State_149736_Name = {
    Text = "달콤한 열매의 낭설"
  },
  State_149744_Desc = {
    Text = "다음 [Layer] 장 사용하는 축복이 부정적 효과를 발동하지 않는다"
  },
  State_149744_Name = {
    Text = "요정님이 보우하사"
  },
  State_149772_Desc = {
    Text = "능동 피해를 받을 때마다 모든 각성체가 광기를 3 잃으며, 매 턴 최대 5회 발동합니다. 방어막을 격파하면 「저주 방패」 상태를 제거합니다."
  },
  State_149772_Name = {
    Text = "저주 방패"
  },
  State_149773_Desc = {
    Text = "능동 피해를 받을 때마다 손패의 무작위 카드 1장에 임시 「둔화」를 1 스택 부여하며, 매 턴 최대 5회 발동합니다. 방어막을 격파하면 「서리 방패」 상태를 제거합니다."
  },
  State_149773_Name = {
    Text = "서리 방패"
  },
  State_149782_Desc = {
    Text = "소모: 다음 턴 드로우 후, 「천변만화의 열매」 1장을 드로우 덱에 셔플합니다."
  },
  State_149782_Name = {
    Text = "천변만화의 열매"
  },
  State_149787_Desc = {
    Text = "1 중첩당 부서약·오지에의 명령 카드 최종 피해가 [DescArg2]% 증가하고, 턴 시작 시 드로우 수 -1, 치명타 피해가 [DescArg3]% 증가하며, 상한 [DescArg1] 중첩, 전투 종료 시 제거되지 않는다."
  },
  State_149787_Name = {
    Text = "<KuangNu:암류>"
  },
  State_149788_Desc = {
    Text = "부서약·오지에의 「스킬」을 사용할 때, 1 중첩을 소모하여 「방어」 1장을 드로우하고, 다음에 사용하기 전까지 보존 상태가 되며, 상한 [DescArg1] 중첩, 전투 종료 시 제거되지 않는다."
  },
  State_149788_Name = {
    Text = "<ShuZui:자죄>"
  },
  State_149789_Desc = {
    Text = "1 중첩당 부서약·오지에의 명령 카드 최종 피해가 33% 증가하고, 턴 시작 시 드로우 수 -1, 상한 [DescArg1] 중첩, 전투 종료 시 제거되지 않는다."
  },
  State_149789_Name = {
    Text = "<KuangNu:암류>"
  },
  State_149790_Desc = {
    Text = "1 중첩당 부서약·오지에의 명령 카드 최종 피해가 [DescArg2]% 증가하고, 턴 시작 시 드로우 수 -1, 상한 [DescArg1] 중첩, 전투 종료 시 제거되지 않는다."
  },
  State_149790_Name = {
    Text = "<KuangNu:암류>"
  },
  State_149791_Desc = {
    Text = "부서약·오지에의 「스킬」을 사용할 때, 1 중첩을 소모하여 「방어」 1장을 드로우하고, 다음에 사용하기 전까지 보존 상태가 되며, 상한 [DescArg1] 중첩, 전투 종료 시 제거되지 않는다."
  },
  State_149791_Name = {
    Text = "<ShuZui:자죄>"
  },
  State_149814_Desc = {
    Text = "임시 피해 증폭 +[Layer]%."
  },
  State_149814_Name = {
    Text = "임시 피해 증폭"
  },
  State_149819_Desc = {
    Text = "모든 피해를 면역한다."
  },
  State_149819_Name = {Text = "면역"},
  State_149892_Desc = {
    Text = "다음 [Layer] 장의 <AwakerName:[DescArg1]> 명령 카드가 주는 기초 보호막이 [StateArg1]% 증가합니다."
  },
  State_149892_Name = {
    Text = "평온한 진실타래"
  },
  State_149913_Name = {
    Text = "상태@대식충 보물 특수효과_틴커트 파손"
  },
  State_149914_Name = {
    Text = "상태@대식충 보물 특수효과_윌리엄 파손"
  },
  State_149915_Name = {
    Text = "상태@대식충 보물 특수효과_윌리엄"
  },
  State_149916_Name = {
    Text = "상태@대식충 보물 특수효과_카스토르 파손"
  },
  State_149917_Name = {
    Text = "상태@대식충 보물 특수효과_블러드 체인 히로 파손"
  },
  State_149918_Name = {
    Text = "상태@대식충 턴 시작 테스트"
  },
  State_149919_Name = {
    Text = "상태@대식충 보물 특수효과_틴커트"
  },
  State_149920_Name = {
    Text = "상태@대식충 보물 특수효과_아라크네"
  },
  State_149921_Name = {
    Text = "상태@대식충 보물 특수효과_아라크네 파손"
  },
  State_149922_Name = {
    Text = "상태@대식충 보물 특수효과_카스토르"
  },
  State_149923_Name = {
    Text = "상태@대식충 보물 특수효과_블러드 체인 히로"
  },
  State_149930_Desc = {
    Text = "1 중첩당 부서약·오지에의 명령 카드 최종 피해가 50% 증가하고, 턴 시작 시 드로우 수 -1, 상한 [DescArg1] 중첩, 전투 종료 시 제거되지 않는다."
  },
  State_149930_Name = {
    Text = "<KuangNu:암류>"
  },
  State_149931_Desc = {
    Text = "총 7가지 효과가 있으며, 다음을 포함합니다: 힘 획득, 드로우, 행동력 획득, 은열쇠 에너지 획득, 임시 피해 증폭 증가, 모든 각성체 광기 획득, 모든 적의 힘 임시 감소."
  },
  State_149931_Name = {
    Text = "<Blessing:선물>"
  },
  State_149933_Name = {
    Text = "상태@몬스터 카라부 봉헌 기포"
  },
  State_149934_Name = {
    Text = "상태@몬스터 카라부 봉헌 기포"
  },
  State_149939_Desc = {
    Text = "턴 종료까지 방어막을 획득할 수 없습니다."
  },
  State_149939_Name = {
    Text = "속박의 사슬"
  },
  State_19507_Desc = {
    Text = "다음 턴 시작 전까지 받는 능동 공격 피해와 출혈 스택이 25% 증가하며, 적용 시 보강과 상쇄된다."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:취약>"
  },
  State_19508_Desc = {
    Text = "턴 종료 시, 이 카드를 버린다."
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:공허>"
  },
  State_19509_Desc = {
    Text = "임시로 카드의 행동력을 변경한다.「개발 전용」"
  },
  State_19509_Name = {
    Text = "카드 행동력 영구 변경__「개발 전용」"
  },
  State_19511_Desc = {
    Text = "사망 후 손패를 환상으로 대체한다.「개발 전용」"
  },
  State_19511_Name = {
    Text = "사망 시 손패를 환상으로 교체하는 트리거__「개발 전용」"
  },
  State_19513_Name = {
    Text = "<EnergyStorageColour:사투>를 부여한다「개발 전용」"
  },
  State_19516_Name = {
    Text = "카드 행동력 임시 변경__「개발 전용」"
  },
  State_19517_Desc = {
    Text = "2% HP를 잃을 때마다 광기 1pt를 획득한다.「개발 전용」"
  },
  State_19517_Name = {
    Text = "피해를 받으면 광기를 획득한다__「개발 전용」"
  },
  State_19519_Desc = {
    Text = "「타격」 사용 후 모든 스택을 소모하며, 스택당 이번 「타격」이 주는 피해가 50% 증가한다. 최대 5스택까지 중첩할 수 있다. (현재 총 [DescArg1]% 증가)"
  },
  State_19519_Name = {Text = "차지"},
  State_19521_Desc = {
    Text = "스택당 이번 전투에서 주는 모든 피해가 1pt 증가하며, 해제할 수 없다."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:힘>"
  },
  State_19522_Name = {
    Text = "카드 행동력 임시 변경__「개발 전용」"
  },
  State_19523_Name = {
    Text = "카드 행동력 영구 변경__「개발 전용」"
  },
  State_19524_Desc = {
    Text = "다음 턴 시작 전, 공격을 받을 때마다 공격자에게 [Layer] 의 순수 피해를 입힌다."
  },
  State_19524_Name = {Text = "반격"},
  State_19525_Desc = {
    Text = "턴 시작 전 깨어남체의 실타래드를 제거한다.「개발 전용」"
  },
  State_19525_Name = {
    Text = "턴 시작 전 캐릭터의 실타래드를 제거한다__「개발 전용」"
  },
  State_19527_Desc = {
    Text = "스택당 「스킬」의 이번 턴 행동력 소모+1, 최대 3스택, 사용 후 스택이 1보다 크면 스택-1."
  },
  State_19527_Name = {
    Text = "<SlowColour:느림>"
  },
  State_19528_Desc = {
    Text = "강력한 효과를 가진 카드."
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:키오링>"
  },
  State_19529_Desc = {
    Text = "[Layer] 번 사용할 수 있으며, 다른 카드를 사용할 때마다 이 카드의 다음 사용 시 행동력 소모 -1."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:환영 [Layer]>"
  },
  State_19530_Desc = {
    Text = "· 상대의 우선 공격 대상이 되며, 상대가 단일 대상을 선택할 때 도발 깨어남체만 선택할 수 있다.\n· 도발 획득 시 자신의 잠행과 다른 아군의 도발을 해제하고, 동시에 적의 잠행을 제거한다."
  },
  State_19530_Name = {
    Text = "<TauntColour:도발>"
  },
  State_19532_Desc = {
    Text = "이번 턴 종료 전까지 주는 피해가 [DescArg1]% 감소하며, 적용 시 강화와 상쇄된다."
  },
  State_19532_Name = {Text = "허약"},
  State_19533_Desc = {
    Text = "이번 턴 종료 전까지 주는 피해가 50% 감소하며, 적용 시 강화와 상쇄된다."
  },
  State_19533_Name = {
    Text = "<WeaknessColour:약화>"
  },
  State_19534_Desc = {
    Text = "다음 턴 시작 전까지 받는 능동 공격 피해와 출혈 스택이 [DescArg1]% 증가하며, 적용 시 보강과 상쇄된다."
  },
  State_19534_Name = {Text = "취약"},
  State_19535_Desc = {
    Text = "· 상대의 우선 공격 대상이 되며, 상대가 단일 대상을 선택할 때 도발 깨어남체만 선택할 수 있다.\n\n· 도발 획득 시 자신의 잠행과 다른 아군의 도발을 해제하고, 동시에 적의 잠행을 제거한다."
  },
  State_19535_Name = {Text = "도발"},
  State_19536_Desc = {
    Text = "턴 종료 시 광기 10pt를 획득한다.「개발 전용」"
  },
  State_19536_Name = {
    Text = "턴 종료 시 광기를 획득하는 트리거__「개발 전용」"
  },
  State_19537_Desc = {
    Text = "이번 턴 종료 전까지 주는 피해가 [DescArg1]% 증가하며, 적용 시 허약과 상쇄된다."
  },
  State_19537_Name = {Text = "강화"},
  State_19538_Desc = {
    Text = "· 8번째 및 9번째 턴 시작 시 각각 1스택을 획득한다.\n\n· 스택당 받는 실타래드와 HP 회복량이 50% 감소하며, 장벽의 중첩 가능 횟수가 1 감소한다.\n\n· 사투는 해제할 수 없으며, 사망한 깨어남체에도 적용된다."
  },
  State_19538_Name = {Text = "사투"},
  State_19540_Name = {
    Text = "행동력 상한"
  },
  State_19541_Desc = {
    Text = "턴 종료 전까지 아무런 행동도 할 수 없다."
  },
  State_19541_Name = {Text = "기절"},
  State_19544_Desc = {
    Text = "「타격」 사용 후 모든 스택을 소모하며, 소모한 스택 1스택당 이번 「타격」이 주는 피해가 50% 증가한다. 최대 5스택까지 중첩할 수 있다."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:차지>"
  },
  State_19545_Name = {
    Text = "이 카드는 「타격」으로 간주한다__「개발 전용」"
  },
  State_19546_Desc = {
    Text = "사용 전에 카드의 행동력을 변경한다.「개발 전용」"
  },
  State_19546_Name = {
    Text = "사용 전 카드의 행동력 변경__「개발 전용」"
  },
  State_19547_Desc = {
    Text = "턴 종료 시 [Layer] 의 순수 피해를 받는다. 영속."
  },
  State_19547_Name = {Text = "중독"},
  State_19549_Desc = {
    Text = "다음 턴 시작 전까지 받는 능동 공격 피해가 50% 감소하며, 적용 시 취약과 상쇄된다."
  },
  State_19549_Name = {
    Text = "<ReinforceColour:강화>"
  },
  State_19552_Desc = {
    Text = "현재 실타래드 [Layer]pt 보유하며, 실타래드는 최대 HP를 초과할 수 없다. 1턴 동안 지속된다."
  },
  State_19552_Name = {
    Text = "실타래드"
  },
  State_19553_Desc = {
    Text = "드로우 단계 후 후발제인을 획득한다.「개발 전용」"
  },
  State_19553_Name = {
    Text = "후공 제압 트리거__「개발 전용」"
  },
  State_19554_Name = {
    Text = "공 상태__「개발 전용」"
  },
  State_19555_Desc = {
    Text = "·이번 턴 「스킬」 행동력 소모+[Layer], 최대 3스택.\n·「스킬」 사용 후 스택이 1보다 크면 스택-1."
  },
  State_19555_Name = {Text = "둔화"},
  State_19556_Desc = {
    Text = "턴 종료 시, 이 카드의 행동력 소모가 [Layer] 감소한다."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:예비 [Layer]>"
  },
  State_19557_Desc = {
    Text = "다음 턴 시작 전까지 받는 능동 공격 피해가 [DescArg1]% 감소하며, 적용 시 취약과 상쇄된다."
  },
  State_19557_Name = {Text = "보강"},
  State_19558_Name = {
    Text = "부활 시 덱에 카드를 추가하는 트리거__「개발 전용」"
  },
  State_19560_Desc = {
    Text = "턴 종료 전까지 광기 폭발을 사용할 수 없다."
  },
  State_19560_Name = {Text = "봉인"},
  State_19561_Name = {
    Text = "3회 사용 가능"
  },
  State_19990_Desc = {
    Text = "다음 턴 시작 시, [Layer]의 광기를 획득한다."
  },
  State_19990_Name = {
    Text = "지연 광기"
  },
  State_19992_Desc = {
    Text = "턴 종료 전까지 어떠한 행동도 할 수 없으며, 실타래신 데미지를 받으면 대상은 내성을 획득합니다. 내성을 가진 상태에서 다시 실타래신 데미지를 받으면 실타래신 효과가 상쇄되고 데미지가 두 배로 증가합니다. 이 상태는 해제할 수 없습니다."
  },
  State_19992_Name = {
    Text = "<ComaColour:기절>"
  },
  State_19995_Desc = {
    Text = "턴 종료 시 스택 수와 동일한 순수 피해를 입힌다. 영속."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:중독>"
  },
  State_19996_Desc = {
    Text = "이번 턴 종료 전까지 주는 피해가 25% 증가하며, 적용 시 허약과 상쇄된다."
  },
  State_19996_Name = {
    Text = "<StrengthenColour:강화>"
  },
  State_19998_Desc = {
    Text = "다음 턴 시작 전, 공격을 받을 때마다 공격자에게 동일한 스택 수만큼의 순수 피해를 입힌다."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:반격>"
  },
  State_20012_Desc = {
    Text = "남은 행동력 1pt당 다음 턴 시작 시 카드 1장을 드로우하며, 남은 손패 1장당 다음 턴 시작 시 행동력 1을 획득한다."
  },
  State_20012_Name = {
    Text = "이화된 선현의 단장"
  },
  State_20012_WeaponDesc = {
    Text = "남은 행동력 1pt당 다음 턴 시작 시 카드 1장을 드로우하며, 남은 손패 1장당 다음 턴 시작 시 행동력 1을 획득한다."
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:계역 숙련>이 100 증가한다. 매 턴 첫 번째로 사용한 카드를 손으로 되돌린다. 초차원 턴 시작 시, 해당 턴의 손패 상한이 5 증가하며 손패를 복제한다."
  },
  State_20013_Name = {
    Text = "상태@시계추 거울"
  },
  State_20014_Name = {
    Text = "시령추「미실타래」"
  },
  State_20016_Name = {
    Text = "유물 마술 장갑"
  },
  State_20017_Desc = {
    Text = "다음 도약 효과가 반드시 발동된다."
  },
  State_20017_Name = {Text = "도약"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:계역 숙련>이 100 증가한다. 매 턴 첫 번째로 사용한 카드를 손으로 되돌린다. 초차원 턴 시작 시, 해당 턴의 손패 상한이 5 증가하며 손패를 복제한다."
  },
  State_20021_Name = {
    Text = "상태@시계추 거울"
  },
  State_20023_Desc = {
    Text = "전투 시작 후, 광기 충전 2장을 덱에 넣는다."
  },
  State_20023_Name = {
    Text = "혼돈 봉합체"
  },
  State_20023_WeaponDesc = {
    Text = "전투 시작 후, 광기 충전 2장을 덱에 넣는다."
  },
  State_20024_Desc = {
    Text = "광기 폭발을 발동할 때마다, [Arg1]의 중독을 부여하는 「독성 감염」 1장을 획득한다. 턴 종료 시, 손에 있는 「독성 감염」 3장마다 중독을 발동하는 「독성 발작」 1장으로 합성할 수 있다."
  },
  State_20024_Name = {
    Text = "상태@유물 이화 이종 후두"
  },
  State_20026_Desc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있으며 후속 효과를 발동한다."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:유지>"
  },
  State_20026_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:계역 숙련> 증가 100. 카드를 사용할 때마다 배아 융합 +10, 생명력이 25% 미만일 때 20으로 증가하며, 매 턴 최대 10회까지 적용됩니다."
  },
  State_20028_Name = {
    Text = "상태@시계추 잠식"
  },
  State_20029_Desc = {
    Text = "광기 폭발을 발동할 때마다, [Arg1]의 중독을 부여하는 「독성 감염」 1장을 획득한다. 턴 종료 시, 손에 있는 「독성 감염」 3장마다 중독을 발동하는 「독성 발작」 1장으로 합성할 수 있다."
  },
  State_20029_Name = {
    Text = "상태@유물 이화 이종 후두"
  },
  State_20035_Name = {
    Text = "상태@시계추 불면"
  },
  State_20038_Name = {
    Text = "혼돈 공생체"
  },
  State_20038_WeaponDesc = {
    Text = "팀이 혼돈과 다른 직업으로 구성될 때, 턴 시작 시 모든 깨어남체가 광기 20을 획득한다."
  },
  State_20039_Desc = {
    Text = "버리기 단계에서 손에 남아 있을 경우, 카드가 소모되며 이번 전투에서 다시 등장하지 않는다."
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:허무>"
  },
  State_20039_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_20040_Name = {
    Text = "상태@시계추 불면 카운터"
  },
  State_20041_Desc = {
    Text = "턴 시작 시 적 1명당 행동력 1을 획득하고, 카드 1장을 드로우한다. 능동 피해로 적을 처치할 때, 다른 적에게 과잉 피해의 2배만큼 출혈을 부여한다."
  },
  State_20041_Name = {
    Text = "이화된 군중의 노래"
  },
  State_20042_Desc = {
    Text = "부정 상태에 있는 적에게 주는 피해가 25% 증가하며, 적을 처치한 후 처치자가 광기 20을 획득한다."
  },
  State_20044_Desc = {
    Text = "부여하는 허약 효과가 10% 증가한다. 매 3턴마다 모든 적에게 허약 1스택을 추가한다."
  },
  State_20045_Desc = {
    Text = "다음 턴 시작 시, 덱에서 카드 3장을 선택하여 손에 넣는다."
  },
  State_20045_Name = {
    Text = "시계추 비상"
  },
  State_20306_Name = {
    Text = "유물 마술 장갑"
  },
  State_20419_Desc = {
    Text = "피해를 1회 입힐 때마다 대상에게 [Arg1]스택의 중독을 부여한다. 이번 전투에서 누적 25회 발동되면 즉시 모든 적의 중독을 발동시킨다."
  },
  State_20425_Desc = {
    Text = "턴 시작 시, [Layer]의 임시 <PowerIconKeywords:힘>과 실타래드를 획득한다."
  },
  State_20425_Name = {
    Text = "갈증의 포식자"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 처음 [StateArg2] 장의 「스킬」이 소모하는 산출력 - [StateArg1]."
  },
  State_20600_Name = {Text = "명오"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [StateArg1]% 증가한다. 공격을 1회 받을 때마다 [StateArg2]스택의 <EnergyStorageKeywords:차지>를 획득한다."
  },
  State_20601_Name = {Text = "폭식"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 대상을 선택하여 [StateArg1]스택의 <PVPSlowKeywords:둔화>를 부여하며, 매 턴 첫 번째 대상에게 발동 시 효과가 2배로 증가한다."
  },
  State_20602_Name = {
    Text = "망각의 손"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <Energy:[Energy:StateArg1]>의 광기를 획득한다."
  },
  State_20603_Name = {
    Text = "기체 역섭"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」으로 자신의 HP를 <Heal:[Heal:StateArg1]> 회복한다."
  },
  State_20604_Name = {Text = "흡입"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 자신에게 <ComaKeywords:기절>을 부여한다. 「광기 폭발」 전에 모든 아군의 부정 상태를 해제한다."
  },
  State_20605_Name = {
    Text = "귀족의 지팡이"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」으로 자신이 <Energy:[Energy:StateArg1]>의 광기를 획득한다."
  },
  State_20606_Name = {Text = "광란"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 <HPAndShieldMax:HP와 방어막가 가장 높은> 적을 공격하고, 추가로 피해의 [StateArg1]%에 해당하는 <PVPBleedingKeywords:출혈>을 입힌다."
  },
  State_20607_Name = {
    Text = "절단과 피해"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 사용 시 및 턴 종료 시, 자신이 <Energy:[Energy:StateArg1]>의 광기를 획득한다."
  },
  State_20608_Name = {Text = "속삭임"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: HP를 잃어서 획득하는 광기가 2배로 증가한다."
  },
  State_20609_Name = {
    Text = "바다의 꿈"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「공격」 피해량 증가 [DescArg1]%, 「광기 폭발」 후 자신의 <PVPPowerIconKeywords:힘>+ [StateArg2] 및 「공격」 피해량 추가 증가 [StateArg3]%, 최대 100%."
  },
  State_20610_Name = {
    Text = "별하늘의 짐승"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」 사용 시 및 턴 종료 시, HP 손실타래이 가장 큰 아군의 HP를 <Heal:[Heal:StateArg1]> 회복한다."
  },
  State_20611_Name = {Text = "희망"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 광기가 가장 낮은 아군이 <Energy:[Energy:StateArg1]>의 광기를 획득하고, HP 손실타래이 가장 많은 아군의 HP를 <Heal:[Heal:StateArg2]> 회복한다."
  },
  State_20612_Name = {
    Text = "자비로운 양육"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 다른 아군이 <Block:[Block:StateArg1]>의 실타래드를 획득한다."
  },
  State_20613_Name = {
    Text = "존재하지 않는 곳"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, [StateArg1]의 임시 <PVPRetaliateIconKeywords:반격>을 획득한다."
  },
  State_20614_Name = {Text = "핵 용해"},
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 처음으로 사용하는 「타격」이 추가로 [StateArg1]의 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  State_20615_Name = {
    Text = "고통의 저주"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시 <Energy:[Energy:StateArg1]>의 광기를 획득한다."
  },
  State_20616_Name = {
    Text = "아쿠트의 봄"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <Block:[Block:StateArg1]>의 실타래드를 획득한다."
  },
  State_20617_Name = {Text = "추방"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 양측이 모든 손패를 버리고 버린 카드 수 + 1장의 카드를 뽑는다."
  },
  State_20618_Name = {
    Text = "행복한 매직 쇼"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 <Energy:[Energy:StateArg1]> 광기를 획득합니다. 아군 깨어남체가 「광기 폭발」을 발동한 후, 자신은 <DelayKeywords:지연>: <Energy:[Energy:StateArg2]> 광기를 획득합니다."
  },
  State_20619_Name = {
    Text = "신왕의 찬송가"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 손패 상한이 [StateArg2] 증가한다. 턴 종료 시, 손패에서 랜덤한 「스킬」 [StateArg1]장의 복사본을 획득한다."
  },
  State_20620_Name = {
    Text = "재회의 순간"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 자신에게 <StrengthenKeywords:강화>와 <ReinforceKeywords:보강>을 부여한다."
  },
  State_20621_Name = {
    Text = "고통을 넘어서"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시 자신이 <Energy:[Energy:StateArg1]> 광기를 획득하고, 남은 모든 계산력을 소모하며, 계산력 1을 소모할 때마다 획득 광기가 [StateArg3] 증가합니다."
  },
  State_20622_Name = {
    Text = "은밀한 탄생"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 [StateArg1]장의 카드를 드로우한다."
  },
  State_20623_Name = {Text = "용출"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: \"광기 폭발\" 후 [StateArg1]장의 \"스킬\"을 뽑고, 그 중 [StateArg2]장의 복사본을 손패에 넣습니다."
  },
  State_20624_Name = {
    Text = "행운의 시간"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <DelayKeywords:지연>: 전체 아군의 <Heal:[Heal:StateArg1]> HP를 회복합니다."
  },
  State_20625_Name = {
    Text = "폭식 우화"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [StateArg1]% 증가하며, 자신이 <ReinforceKeywords:보강>을 획득한다."
  },
  State_20626_Name = {
    Text = "불굴의 의지"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 모든 아군의 HP를 <Heal:[Heal:StateArg1]> 회복한다."
  },
  State_20627_Name = {Text = "은총"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 다른 아군이 <Energy:[Energy:StateArg1]>의 광기를 획득하며, 이 효과로 넘치는 광기는 절반으로 감소하여 장착한 깨어남체에게 반환된다."
  },
  State_20628_Name = {
    Text = "책임의 무게"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」이 주는 피해, 치유 및 실타래드 효과가 [StateArg1]% 증가한다."
  },
  State_20629_Name = {
    Text = "장미의 이름으로"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <Block:[Block:StateArg1]>의 실타래드와 <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_20630_Name = {
    Text = "겨울밤의 추억"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:명륜>:「타격」으로 <PVPVulnerabilityIconKeywords:손상> 목표를 공격합니다. 장착 시와 턴 종료 시 [StateArg1] 층 <EnergyStorageKeywords:축력>을 획득합니다."
  },
  State_20631_Name = {Text = "임계점"},
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 손패 상한이 [StateArg1] 증가한다."
  },
  State_20632_Name = {
    Text = "기억의 나선"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 처음으로 적의 능동 공격을 받은 후, 그 적에게 [StateArg1]의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다."
  },
  State_20633_Name = {
    Text = "창백한 후예"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」「스킬」「광기 폭발」이 주는 피해, 치료 및 실타래드가 [DescArg1]% 증가하며, <PVPGrowthKeywords:성장> [StateArg2]% 증가한다."
  },
  State_20634_Name = {
    Text = "태양의 몰락"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 모든 아군이 <StrengthenKeywords:강화>를 획득한다."
  },
  State_20635_Name = {
    Text = "경건한 위력"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <PVPDerivativeCardKeywords_2:「환상」> 1장을 획득한다. 손에 <PVPDerivativeCardKeywords_2:「환상」> 2장이 있을 때마다, 이를 합성하여 <PVPDerivativeCardKeywords_12:「작은 소원」> 1장으로 만든다."
  },
  State_20636_Name = {Text = "숙성"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <PVPDerivativeCardKeywords_11:「불평등한 교환」> [StateArg1]장을 덱에 섞어 넣는다."
  },
  State_20637_Name = {
    Text = "정보는 생명"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 장착자가 <HPAndShieldMax:HP와 방어막가 가장 높은> 적에게 [StateArg1] 피해를 주고, <PVPMethysisKeywords:중독>을 부여한다."
  },
  State_20639_Name = {
    Text = "부패의 선물"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 시작 시, 장착한 깨어남체가 전체 적에게 <Damage:[Damage:StateArg1]>의 <PVPBleedingKeywords:출혈> 피해를 주며, 대상이 손패를 1장 가질 때마다 <PVPBleedingKeywords:출혈> 피해가 [StateArg2] 증가한다."
  },
  State_20640_Name = {
    Text = "혈육의 광연"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 사망한 후, 다른 아군에게 [StateArg1]스택의 <PVPProtectiveKeywords:장벽>을 부여한다."
  },
  State_20641_Name = {
    Text = "죽음의 분석"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:보유>: 카드를 사용할 때마다 이 카드는 다른 랜덤 「명륜」으로 변하며, 그 스킬의 행동력 소모가 1 감소한다."
  },
  State_20642_Name = {
    Text = "영혼의 탄생"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 [StateArg1] 행동력을 획득하고, <DelayKeywords:지연>: [StateArg2] 행동력을 차감한다."
  },
  State_20643_Name = {
    Text = "기억 증후군"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 자신에게 [StateArg2]의 피해를 주고, <PVPEntanglementKeywords:엉킴>을 부여한다. 죽은 아군이 1명 있을 때마다 <StrongEffectKeywords:강효>가 [StateArg1] 증가한다."
  },
  State_20644_Name = {
    Text = "가장 소중한 수집품"
  },
  State_20645_Name = {
    Text = "모험가의 배낭"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [StateArg1]% 증가하며, 「광기 폭발」 후 자신의 HP를 <Heal:[Heal:StateArg2]> 회복한다."
  },
  State_20646_Name = {
    Text = "삼켜진 자장가"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <PVPDerivativeCardKeywords_11:「불평등한 교환」> [StateArg1]장을 손에 넣는다."
  },
  State_20647_Name = {
    Text = "폭우 속에서"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 시작 시, 긍정적인 <PVPWonderfulEffectKeywords:기묘한 효과>를 획득한다. 적이 매 턴 처음으로 「열쇠 지령」을 사용할 때 「화려한 풍경」 [StateArg1]장을 손에 넣는다."
  },
  State_20648_Name = {
    Text = "소리 없는 잔치"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 이전 턴 마지막에 사용한 「스킬」을 손에 넣고, 그 스킬의 행동력 소모를 1 감소시킨다. 이 효과가 여러 번 발동할 경우 이전 턴으로 거슬러 올라간다."
  },
  State_20649_Name = {
    Text = "역행 시계"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 자신에게 <ComaKeywords:기절>을 부여한다. 「광기 폭발」 전에 전체 적의 긍정 상태를 해제한다."
  },
  State_20650_Name = {Text = "섬망"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, [StateArg1]장의 카드를 드로우한다."
  },
  State_20651_Name = {Text = "탐욕"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 전체 적에게 [StateArg1]의 피해를 주고, <DisarmKeywords:마비>를 부여한다."
  },
  State_20652_Name = {Text = "징벌"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 대상을 선택할 수 있으며, 대상의 <Energy:[Energy:StateArg1]> 광기를 감소시킨다."
  },
  State_20653_Name = {
    Text = "떠도는 욕망"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 시작 시, 자신에게 <PVPSeriousInjuryKeywords:치명타>을 부여하고 <Damage:[Damage:StateArg1]> 층 <PVPCorrosionKeywords:죄 인장>을 획득합니다. 턴 종료 시, 자신에게 <ReinforceKeywords:요새화>를 부여합니다."
  },
  State_20654_Name = {
    Text = "여왕의 금칙"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」의 피해가 [StateArg1]% 증가하며, 「타격」이 대상을 선택할 수 있다."
  },
  State_20655_Name = {Text = "총애"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 주는 피해, 치료 및 방어막 효과가 [StateArg1]% 증가하며, 「스킬」 사용 후 <PVPProtectiveKeywords:장벽>이 없을 경우 1스택을 획득한다."
  },
  State_20656_Name = {
    Text = "시첩의 끝구절"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 적이 [StateArg1]번째 「스킬」을 사용할 때, 그 스킬의 행동력 소모가 [StateArg2] 감소한 복사본 1장을 손에 넣는다."
  },
  State_20657_Name = {Text = "통찰"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 목표를 1회 공격할 때마다 [StateArg1]의 행동력을 획득한다."
  },
  State_20658_Name = {
    Text = "속박된 노래"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 사망 후, 다음 턴 시작 시 자신이 <PVPResurrectionKeywords:부활>하고, <Heal:[Heal:StateArg1]>의 HP와 <Block:[Block:StateArg2]>의 실타래드를 획득하며, 이 「명륜」을 파괴한다."
  },
  State_20659_Name = {Text = "활성"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 전체 아군이 <Block:[Block:StateArg1]>의 실타래드를 획득한다."
  },
  State_20660_Name = {
    Text = "마음의 장벽"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 전체 적에게 <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:출혈> 피해를 입힙니다."
  },
  State_20661_Name = {
    Text = "잃어버린 길"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:운명의 바퀴>：턴 종료 시, <PVPCapKeywords:연산력 상한> 1점마다 <HPAndShieldMin:생명과 보호막이 가장 낮은> 적에게 [StateArg1] <PVPBleedingKeywords:출혈>을 부여하며, 총 <Damage:[Damage:DescArg1]> <PVPBleedingKeywords:출혈> 피해를 입힙니다."
  },
  State_20662_Name = {
    Text = "밤의 그림자 속에서"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 자신의 부정 상태를 해제하고, [StateArg1]스택의 <EnergyStorageKeywords:차지>를 획득한다."
  },
  State_20663_Name = {
    Text = "사슬을 벗어던진 날"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」로 자신이 <ReinforceKeywords:보강>을 획득한다."
  },
  State_20664_Name = {
    Text = "기사의 마음"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 자신이 부정 효과를 해제할 때 해제할 수 있는 부정 효과가 없으면 <Heal:[Heal:StateArg1]> 생명을 회복합니다. 턴 종료 시, <DelayKeywords:지연>: 자신에게 부정 효과를 해제합니다."
  },
  State_20665_Name = {
    Text = "인도하는 돛"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 <HPAndShieldMin:HP와 방어막가 가장 낮은> 아군이 [StateArg1] 스택의 <PVPProtectiveKeywords:장벽>을 얻는다."
  },
  State_20666_Name = {
    Text = "나의 소중한 친구에게"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 장착한 깨어남체가 처음 사용하는 「스킬」의 피해가 [StateArg1]% 증가한다."
  },
  State_20667_Name = {
    Text = "거인의 검"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 아군 깨어남체가 죽을 때, 전체 적에게 <Damage:[Damage:StateArg1]>의 <PVPBleedingKeywords:출혈> 피해를 준다. 장착한 깨어남체가 죽을 때 추가로 <Damage:[Damage:StateArg2]>의 <PVPBleedingKeywords:출혈> 피해를 준다."
  },
  State_20668_Name = {
    Text = "산호 여인의 죽음"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 시작 시, 자신에게 <PVPProtectiveKeywords:장벽>이 없으면 [StateArg1]스택의 <PVPProtectiveKeywords:장벽>을 획득하고, 그렇지 않으면 손에 있는 자신의 행동력 소모가 가장 높은 「스킬」 1장의 행동력 소모를 1 감소시킨다."
  },
  State_20669_Name = {
    Text = "신언 석판"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 <PVPSeriousInjuryKeywords:치명타>을 일으키고, 피해량이 [StateArg1]% 증가하지만, 자신이 받은 피해의 절반만큼 생명력을 잃습니다."
  },
  State_20670_Name = {
    Text = "고통의 지느러미"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신의 HP를 <Heal:[Heal:StateArg1]> 회복한다."
  },
  State_20671_Name = {
    Text = "죽음을 넘어"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 행동력 소모가 가장 높은 손패 1장의 행동력 소모를 [StateArg1] 감소시킨다."
  },
  State_20672_Name = {
    Text = "정신 집중"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <Block:[Block:StateArg1]>의 실타래드를 획득하고, 다른 아군이 <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_20673_Name = {
    Text = "완성 불가능한 연산"
  },
  State_20696_Name = {
    Text = "상태@거인의 공포"
  },
  State_20723_Desc = {
    Text = "타격 카드의 피해량이 [Layer] 증가한다.「개발 전용」"
  },
  State_20723_Name = {
    Text = "타격 카드 잠금 피해 증가__「개발 전용」"
  },
  State_20724_Desc = {
    Text = "타격 카드의 피해량이 [Layer] 감소한다.「개발 전용」"
  },
  State_20724_Name = {
    Text = "타격 카드 잠금 피해 감소__「개발 전용」"
  },
  State_20749_Desc = {
    Text = "일반 회고 카운트.__「개발 전용」"
  },
  State_20758_Desc = {
    Text = "다음 턴 시작 시, 카드 [Layer]장을 드로우한다."
  },
  State_20758_Name = {
    Text = "지연 카드 뽑기"
  },
  State_20766_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.__「개발 전용」"
  },
  State_20802_Desc = {
    Text = "이 카드는 사용할 수 없다. 「개발 전용」"
  },
  State_20802_Name = {
    Text = "사용 불가__[개발 전용]"
  },
  State_20803_Desc = {
    Text = "이 카드는 행동력을 1 소모하여 다른 카드를 사용한 후, 이 카드는 다른 랜덤 명륜 카드로 변한다."
  },
  State_20803_Name = {
    Text = "<CardKeyWord:영혼의 탄생>"
  },
  State_20805_Desc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:유지>"
  },
  State_20806_Desc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않고, 덱에서 제거된다."
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:소모>"
  },
  State_20820_Desc = {
    Text = "다음 턴 시작 시 부활하며, HP [Layer]pt와 실타래드 [Layer]pt를 획득한다."
  },
  State_20820_Name = {
    Text = "지연 부활"
  },
  State_20851_Name = {
    Text = "카드 부여"
  },
  State_20981_Desc = {
    Text = "「핏빛」이 깨어남했으며, 주는 피해가 대폭 증가한다."
  },
  State_20981_Name = {
    Text = "유우하시 깨어남!"
  },
  State_20981_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_20982_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_20982_Name = {
    Text = "미깨어남"
  },
  State_20988_Desc = {
    Text = "초기 광기 +80. 매 턴 광기 20을 획득한다."
  },
  State_20988_Name = {
    Text = "다포딜·첫 만남"
  },
  State_20989_Desc = {
    Text = "초기 광기 +80. 매 턴 행동력 2와 광기 20을 획득한다."
  },
  State_20989_Name = {
    Text = "툴루·첫 만남"
  },
  State_21306_Desc = {
    Text = "매 턴 연속 공격 횟수가 초기화된다."
  },
  State_21306_Name = {
    Text = "콤보 초기화"
  },
  State_21307_Desc = {
    Text = "스택당 공격 횟수가 1 증가하며, 피해를 받으면 1스택이 감소한다. 최소 1스택까지 감소하며, 턴 종료 시 모든 스택이 사라진다."
  },
  State_21307_Name = {Text = "콤보"},
  State_21342_Desc = {
    Text = "다음 턴 시작 시, [Layer]의 치유를 획득한다."
  },
  State_21342_Name = {
    Text = "지연 치유"
  },
  State_21345_Desc = {
    Text = "신강 의식이 시작되기 전, 사망 후 부활하여 부정 상태를 해제하고 피해를 면역하며 HP 30%를 회복한다. 신강 의식이 시작된 후, 사망 후 완전히 부활하여 부정 상태와 의식 집착을 해제하고 권속 2명을 소환한다."
  },
  State_21345_Name = {
    Text = "의식 집착"
  },
  State_21358_Desc = {
    Text = "해당 플레이어의 손패에는 상한이 없다.__「개발 전용」"
  },
  State_21381_Name = {
    Text = "봉인 사용 횟수 카운터"
  },
  State_21385_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 감소한다. 스택이 0이 되면, 의도를 높은 피해량의 광기 폭발로 전환하고 석화 효과가 해제된다."
  },
  State_21385_Name = {
    Text = "혈의 광포"
  },
  State_21450_Desc = {
    Text = "다음 턴 시작 시, 자신의 부정 상태를 해제한다."
  },
  State_21450_Name = {
    Text = "지연 정화"
  },
  State_21488_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.__「개발 전용」"
  },
  State_21492_Desc = {
    Text = "피해는 치명타 발생 시 50% 증가한다."
  },
  State_21492_Name = {
    Text = "<CardKeyWord:치명타>"
  },
  State_21546_Desc = {
    Text = "다음 턴 시작 시, [Layer]의 실타래드를 획득한다."
  },
  State_21546_Name = {
    Text = "지연 실타래드"
  },
  State_21547_Desc = {
    Text = "턴 시작 시, 실타래드의 절반을 유지한다."
  },
  State_21547_Name = {Text = "강인"},
  State_21548_Desc = {
    Text = "다음 턴 시작 시, 강화를 획득한다."
  },
  State_21548_Name = {
    Text = "지연 강화"
  },
  State_21580_Desc = {
    Text = "해골 사냥꾼이 당신의 행동 흔적을 추적하고 있다. 카드를 1장 드로우할 때마다 해골 사냥꾼이 [StateArg1]의 임시 힘을 획득한다."
  },
  State_21580_Name = {Text = "추적"},
  State_21587_Name = {
    Text = "이번 턴에 새로운 무작위 깨어남체 발견됨"
  },
  State_21590_Name = {
    Text = "새로운 깨어남체 탐색 시도 횟수"
  },
  State_21601_Name = {
    Text = "새로운 깨어남체 발견"
  },
  State_21616_Desc = {
    Text = "광기 폭발 사용 후 모든 깨어남체를 1턴간 봉인한다."
  },
  State_21616_Name = {
    Text = "여정의 유골"
  },
  State_21671_Name = {
    Text = "범위 피해를 준다「개발 전용」"
  },
  State_21688_Name = {
    Text = "1회 사용 가능"
  },
  State_21689_Name = {
    Text = "2회 사용 가능"
  },
  State_21720_Desc = {
    Text = "대상 뒤의 깨어남체에 동일한 효과를 부여하고, 만약 그 뒤에 깨어남체가 없다면 단순히 대상에게 효과를 부여합니다."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:관통>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체가 매 턴 처음으로 「스킬」을 사용한 후, 그 스킬의 행동력 소모가 [StateArg1] 감소한 복사본 1장을 덱에 섞어 넣는다."
  },
  State_21726_Name = {
    Text = "회전, 회전"
  },
  State_21744_Name = {
    Text = "새로운 깨어남체 탐색 시도 횟수"
  },
  State_21745_Name = {
    Text = "새로운 깨어남체 발견"
  },
  State_21746_Name = {
    Text = "이번 턴에 새로운 무작위 깨어남체 발견됨"
  },
  State_21747_Desc = {
    Text = "[Layer]명의 깨어남체가 사냥당하고 있다. 사냥당하는 깨어남체가 카드를 1장 사용할 때마다, 「폭주 해골 사냥꾼」이 사냥의 표식 1스택을 획득한다."
  },
  State_21747_Name = {
    Text = "사냥 의식"
  },
  State_21751_Desc = {
    Text = "사냥의 표식 스택의 절반만큼 카드를 드로우한다([DescArg1]). 「폭주 해골 사냥꾼」의 사냥의 표식 스택이 1 증가한다."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:사냥당함>"
  },
  State_21754_Desc = {
    Text = "사망 후, 「폭주 해골 사냥꾼」의 모든 임시 힘을 해제하고, 그의 「사냥의 표식」 스택을 절반으로 감소시킨다."
  },
  State_21754_Name = {
    Text = "일시적 해방"
  },
  State_21765_Desc = {
    Text = "· 아군 깨어남체 1명에게 「명륜」을 장착하여 해당 「명륜」의 효과를 발휘하게 한다.\n\n· 깨어남체에게 「명륜」을 중복 장착할 경우, 기존 「명륜」은 파괴되고 새로운 「명륜」이 유지된다.\n\n· 깨어남체 사망 시 장착한 「명륜」은 파괴된다.\n\n· 사망한 깨어남체에게 「명륜」을 장착할 경우 해당 「명륜」은 파괴되며, 환상 1장을 획득하고 소모한 행동력을 반환받는다."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:명륜>"
  },
  State_21785_Name = {
    Text = "전투 외침"
  },
  State_21787_Name = {
    Text = "전투 외침 추가"
  },
  State_21826_Name = {
    Text = "아이들의 왕 등장 대사"
  },
  State_21829_Name = {
    Text = "죽음의 메아리"
  },
  State_21838_Name = {
    Text = "시작 소개"
  },
  State_21843_Name = {
    Text = "시작 시 상태 추가"
  },
  State_21895_Name = {
    Text = "등장 대사"
  },
  State_21905_Desc = {
    Text = "「타격」이 행동력 2를 획득하고, 무작위로 카드 1장을 버린다. 「방어」가 카드 2장을 드로우하고, 행동력 1을 잃는다."
  },
  State_21928_Name = {Text = "힌트"},
  State_22054_Name = {
    Text = "등장 대사"
  },
  State_22055_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_22055_Name = {
    Text = "미깨어남"
  },
  State_22067_Desc = {
    Text = "턴 종료 후, 촉수 1개가 [Layer]회 공격한다."
  },
  State_22067_Name = {
    Text = "촉수 집결"
  },
  State_22074_Desc = {
    Text = "7턴 생존 시 의도가 응시로 변경되고, 8턴 이상에서는 의도가 모독으로 변경된다."
  },
  State_22134_Desc = {
    Text = "관통 피해는 대상의 HP, 방어막, 장벽을 동시에 손상시킵니다."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:관통 피해>"
  },
  State_22157_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「해류」와 「조석」으로 분열된다."
  },
  State_22157_Name = {Text = "분열"},
  State_22204_Desc = {
    Text = "턴 시작 후 [Layer]%의 임시 치명타율과 임시 치명타 피해를 획득한다."
  },
  State_22204_Name = {
    Text = "서서히 퍼지는 선율"
  },
  State_22204_WeaponDesc = {
    Text = "다음 턴 시작 전까지 HP를 잃지 않으면, 다음 턴의 치명타율이 [StateArg1]% 증가한다."
  },
  State_22210_Desc = {
    Text = "행동력 소모 +100, 「타격」을 사용할 수 없으며, 광기를 획득할 수 없다."
  },
  State_22210_Name = {
    Text = "슈퍼 둔화"
  },
  State_22238_Name = {
    Text = "플레이어 데스매치__「개발 전용」"
  },
  State_22239_Name = {
    Text = "플레이어에게 <EnergyStorageColour:사투>를 부여한다__「개발 전용」"
  },
  State_22249_Desc = {
    Text = "다음 턴 시작 후, [Layer]장의 카드를 적게 드로우한다."
  },
  State_22249_Name = {
    Text = "불평등한 교환"
  },
  State_22300_Desc = {
    Text = "해당 타격 카드는 사용할 수 없다.「개발 전용」"
  },
  State_22300_Name = {
    Text = "타격 카드 무장 해제로 사용 불가__「개발 전용」"
  },
  State_22303_Desc = {
    Text = "피해를 받을 때마다 손패의 무작위 카드에 임시 「둔화」 1스택을 부여하며, 실타래드가 파괴되면 「서리 방패」 상태를 제거한다."
  },
  State_22303_Name = {
    Text = "서리 방패"
  },
  State_22324_Desc = {
    Text = "스택당 이번 턴에 공격 횟수가 1 증가한다."
  },
  State_22324_Name = {
    Text = "노도의 메아리"
  },
  State_22325_Desc = {
    Text = "공격을 받을 때마다 [StateArg1]의 임시 힘을 획득한다."
  },
  State_22325_Name = {
    Text = "거인의 혈통"
  },
  State_22326_Desc = {
    Text = "당신이 잠겼습니다! 사용 후 도해자 근위대가 임시 광란 1스택을 획득하고, 해당 명령 카드의 노도 인장을 제거한다."
  },
  State_22326_Name = {
    Text = "<CardKeyWord:노도 마크>"
  },
  State_22328_Desc = {
    Text = "「노도 인장」이 있는 명령 카드를 사용할 때마다, 이번 턴의 공격 횟수가 1 증가한다."
  },
  State_22328_Name = {
    Text = "노도의 메아리"
  },
  State_22334_Desc = {
    Text = "「타격」 카드를 1장 사용할 때마다, [StateArg1]장의 「상처」를 덱 맨 위에 놓는다."
  },
  State_22334_Name = {
    Text = "트라우마"
  },
  State_22404_Desc = {
    Text = "이번 전투 내에서 생성되는 실타래드가 [Layer]pt 증가한다."
  },
  State_22404_Name = {Text = "경계"},
  State_22405_Desc = {
    Text = "이번 전투 내에서 생성되는 실타래드가 증가한다."
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:경계>"
  },
  State_22702_Desc = {
    Text = "매 턴 첫 번째로 사용한 「카드」는 추가 효과를 발동한다."
  },
  State_22702_Name = {
    Text = "<CardKeyWord:돌격>"
  },
  State_22706_Name = {
    Text = "돌격 마크__「개발 전용」"
  },
  State_22707_Desc = {
    Text = "매 턴 카드 사용 후 플레이어에게 돌격 상태를 부여하여 표시한다.__「개발 전용」"
  },
  State_22707_Name = {
    Text = "<PVPRaidKeywords:돌격> 트리거__「개발 전용」"
  },
  State_22721_Name = {
    Text = "시령추「미실타래」"
  },
  State_23405_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여, 현재 반격 스택과 동일한 힘을 획득하고 HP를 회복하며 진정한 형태로 전투를 시작한다."
  },
  State_23405_Name = {
    Text = "미깨어남"
  },
  State_23406_Desc = {
    Text = "「침연자」는 매 턴 종료 시 [StateArg1]스택의 반격을 획득한다."
  },
  State_23406_Name = {
    Text = "카이커스 깨어남!"
  },
  State_23512_Name = {
    Text = "천면환상 부여"
  },
  State_23514_Name = {
    Text = "천면환상 부여"
  },
  State_23515_Name = {
    Text = "천면환상 부여"
  },
  State_23516_Name = {
    Text = "천면환상 부여"
  },
  State_23517_Name = {
    Text = "플레이어에게 버프 부여"
  },
  State_23518_Desc = {
    Text = "2턴간 취약을 부여하고, 공격 횟수가 1 증가하며, 힘 감소를 부여한다."
  },
  State_23518_Name = {
    Text = "<CardKeyWord:의도 선택>"
  },
  State_23519_Name = {Text = "의도 2b"},
  State_23520_Name = {Text = "의도 2c"},
  State_23521_Name = {
    Text = "버릴 시 소모되며, 전체 깨어남체 [StateArg1]pt 광기 차감 및 「증상」 5장을 플레이어의 덱에 섞어 넣기"
  },
  State_23522_Name = {
    Text = "버릴 시 소모되며, 전체 깨어남체 [StateArg1]pt 광기 차감"
  },
  State_23524_Name = {Text = "의도3a"},
  State_23525_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_23525_Name = {
    Text = "미깨어남"
  },
  State_23526_Name = {Text = "의도 2a"},
  State_23527_Name = {Text = "의도3c"},
  State_23528_Name = {Text = "의도 3b"},
  State_23529_Desc = {
    Text = "힘 증가 / 추가 피해 / 실타래드 획득"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:의도 선택>"
  },
  State_23530_Desc = {
    Text = "「천면환상」을 사용할 때 두 번의 의도 선택이 필요하다. 버릴 경우, 모든 깨어남체가 광기 20을 잃고, 「증상」 카드 5장을 플레이어의 덱에 섞어 넣는다."
  },
  State_23530_Name = {
    Text = "다프다엘 깨어남!"
  },
  State_23531_Name = {
    Text = "천면환상 부여"
  },
  State_23532_Name = {
    Text = "천면환상 부여"
  },
  State_23533_Desc = {
    Text = "증상 카드 덱에 섞어 넣기 / 출혈 부여 / 광기 감소"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:의도 선택>"
  },
  State_23534_Name = {Text = "의도 1a"},
  State_23535_Name = {Text = "의도 1c"},
  State_23536_Name = {Text = "의도 1b"},
  State_23612_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 감소한다. 스택이 0이 되면, 의도를 높은 피해량의 광기 폭발로 전환하고 석화 효과가 해제된다."
  },
  State_23612_Name = {
    Text = "혈의 광포·종결"
  },
  State_23687_Name = {
    Text = "시령추「조수」"
  },
  State_23726_Desc = {
    Text = "다음 턴까지 깨어남체의 사망을 1회 막는다. 최대 1스택."
  },
  State_23726_Name = {
    Text = "죽음 저항"
  },
  State_23732_Desc = {
    Text = "다음 턴 시작 전까지, 능동 피해를 1회 받을 때마다 [Layer] 스택의 <PainWord:인내>를 획득합니다."
  },
  State_23732_Name = {
    Text = "흑늪의 금역"
  },
  State_23736_Name = {
    Text = "이번 턴 드로우 수"
  },
  State_23737_Name = {
    Text = "드로우 횟수 기록"
  },
  State_23741_Name = {
    Text = "드로우 기록 적용"
  },
  State_23744_Desc = {
    Text = "필드에 「사자」가 없을 경우, 턴 시작 시 「사자」 1명을 소환하며, 소환할 때마다 HP가 증가한다."
  },
  State_23744_Name = {
    Text = "사자 소환"
  },
  State_23747_Name = {
    Text = "생명력 강화"
  },
  State_23748_Name = {
    Text = "소환 카운터"
  },
  State_23769_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_23769_Name = {
    Text = "미깨어남"
  },
  State_23771_Desc = {
    Text = "「기술사」가 깨어남했다. 그녀가 「환영」으로 만드는 분신을 조심하라. 깨어남 후 상대가 카드를 1장 사용할 때마다 카시아가 「환영」 1스택을 획득한다."
  },
  State_23771_Name = {
    Text = "카시아 깨어남!"
  },
  State_23771_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_23782_Desc = {
    Text = "환영 10스택을 획득한 후, 「환영」 스택을 초기화하고 전방에 분신 1개를 소환하며, 최대 2개의 분신이 존재할 수 있다. 분신은 소환 시 <PVPProtectiveKeywords:장벽> 3스택을 보유한다."
  },
  State_23782_Name = {Text = "환영"},
  State_23786_Name = {
    Text = "상태@깨어남체 카시아 공중 물체 획득"
  },
  State_23787_Name = {
    Text = "상태@깨어남체 카시아@공중 물체 획득@드로우 감소"
  },
  State_23788_Desc = {
    Text = "3턴 시작 시, 「과거의 메아리 — 모든 손패를 버리고, 현재 HP와 실타래드가 이전 턴 종료 시의 상태로 돌아간다. 유지, 소모됨.」 1장을 손에 넣는다."
  },
  State_23791_Name = {
    Text = "오프닝 안내"
  },
  State_23823_Name = {Text = "폭탄 1"},
  State_23825_Name = {
    Text = "상태@깨어남체 카시아@모두 사라져라"
  },
  State_23827_Desc = {
    Text = "사용 후, 최대 HP가 [DescArg1] 감소하며, 대마술사는 이번 턴에 「의기양양」 1스택을 획득한다."
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:환호>"
  },
  State_23828_Desc = {
    Text = "대마술사는 현재 자신의 공연을 매우 즐기고 있으며, 「의기양양」 1스택당 스킬 효과가 약화되고 힘이 [DescArg1] 감소한다. 최대 5스택까지 획득할 수 있다."
  },
  State_23828_Name = {
    Text = "의기양양"
  },
  State_23871_Desc = {
    Text = "최대 HP 증가 시 현재 HP는 함께 증가하지 않으며, 최대 HP 감소 시 초과된 현재 HP는 제거된다. 최대 HP는 최소 1이며, 사망 후에도 초기화되지 않는다."
  },
  State_23871_Name = {
    Text = "<MaxHPColour:최대 HP>"
  },
  State_23934_Name = {
    Text = "상태@공중 물체 획득 핸드 감청"
  },
  State_23935_Name = {
    Text = "상태@깨어남체 카시아@공중 물체 획득 적용"
  },
  State_2393_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_2393_Name = {
    Text = "미깨어남"
  },
  State_2394_Name = {
    Text = "핏빛 힘 계령 보너스"
  },
  State_2395_Name = {
    Text = "장식품 먼 곳의 향연"
  },
  State_2395_WeaponDesc = {
    Text = "[방어]가 주는 실타래드가 30% 증가한다. 장착한 깨어남체의 검은 인장 드롭률이 15%를 초과할 경우, [방어]가 주는 실타래드가 추가로 30% 증가한다."
  },
  State_2396_Desc = {
    Text = "치명타 피해가 20% 증가한다. 실타래드가 있는 적에게 주는 피해는 반드시 치명타로 적중한다."
  },
  State_2398_Desc = {
    Text = "피해를 받을 때 [Layer]의 실타래드를 획득하며, 피해를 받을 때마다 실타래드가 계속 증가한다. 턴 종료 시 회복된다."
  },
  State_2398_Name = {
    Text = "차원 장벽"
  },
  State_2398_WeaponDesc = {
    Text = "받는 능동 피해가 [Layer] 증가한다. 피해를 받을 때마다 융식 상처가 확대되며, 턴 시작 시 회복된다."
  },
  State_2399_Desc = {
    Text = "HP를 회복한 후, 모든 깨어남체가 광기 3을 획득한다. 5번째 HP를 회복한 후, 이번 전투에서 광기 폭발 피해가 [Arg1] 증가한다."
  },
  State_2400_Desc = {
    Text = "촉수 상한이 1 증가한다. HP가 50% 미만일 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2400_Name = {
    Text = "유물 과거의 공물"
  },
  State_2400_WeaponDesc = {
    Text = "촉수 상한이 1 증가한다. HP가 50% 미만일 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2401_Desc = {
    Text = "턴 시작 시, 버린 카드 더미 맨 위의 카드를 손에 넣는다."
  },
  State_2402_Desc = {
    Text = "턴 시작 시, 초차원 공간에 있는 카드 1장당 이번 턴에 [Arg1]의 임시 힘을 획득한다."
  },
  State_2403_Desc = {
    Text = "이번 전투 내에서 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_2403_Name = {Text = "경계"},
  State_2403_WeaponDesc = {
    Text = "이번 전투 내에서 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_2404_Desc = {
    Text = "획득 시 증상 카드 1장을 삭제한다. 행운의 각인 확률이 50% 증가한다."
  },
  State_2405_Desc = {
    Text = "임시로 카드의 행동력 변경"
  },
  State_2405_Name = {
    Text = "임시 카드 행동력 변경"
  },
  State_2405_WeaponDesc = {
    Text = "임시로 카드의 행동력 변경"
  },
  State_2406_Desc = {
    Text = "마지막 1pt의 행동력을 소모할 때, 행동력 2를 획득한다. 매 턴 최대 2회 발동된다."
  },
  State_2407_Name = {Text = "관측값"},
  State_2408_Name = {
    Text = "선원의 호루라기"
  },
  State_2409_Desc = {
    Text = "이번 턴에 「타격」을 1장 사용할 때마다 행동력 소모가 1 감소한다."
  },
  State_2409_Name = {
    Text = "오만의 검"
  },
  State_2409_WeaponDesc = {
    Text = "이번 턴에 「타격」을 1장 사용할 때마다 행동력 소모가 1 감소한다."
  },
  State_2410_Desc = {
    Text = "1턴 동안 행동할 수 없다. 석화된 적은 다시 석화 효과를 받을 수 없다."
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:석화>"
  },
  State_2410_WeaponDesc = {
    Text = "몬스터를 1턴 동안 기절시킨다."
  },
  State_2411_Desc = {
    Text = "턴 종료 시, 아군 팀에 [Layer]스택의 출혈을 부여한다."
  },
  State_2411_Name = {
    Text = "피의 등불"
  },
  State_2411_WeaponDesc = {
    Text = "턴 종료 시, 아군 팀에 [Layer]스택의 출혈을 부여한다."
  },
  State_2412_Desc = {
    Text = "다음 턴에 주는 피해가 2배로 증가한다."
  },
  State_2412_Name = {
    Text = "궁지 생존"
  },
  State_2412_WeaponDesc = {
    Text = "다음 턴에 주는 피해가 2배로 증가한다."
  },
  State_2413_Desc = {
    Text = "타격과 방어로 획득하는 광기가 [Layer]% 감소한다."
  },
  State_2413_Name = {Text = "공허"},
  State_2413_WeaponDesc = {
    Text = "타격과 방어로 획득하는 광기가 [StateArg1]%가 된다."
  },
  State_2415_Desc = {
    Text = "이전 턴에 피해를 받았다면, 턴 시작 시 1턴간 면역을 획득한다."
  },
  State_2415_Name = {
    Text = "최후의 외침"
  },
  State_2415_WeaponDesc = {
    Text = "이전 턴에 피해를 받았다면, 턴 시작 시 1턴간 면역을 획득한다."
  },
  State_2416_Desc = {
    Text = "소환된 몬스터의 HP와 피해가 2배로 증가한다."
  },
  State_2416_Name = {
    Text = "「밀랍 세계」"
  },
  State_2416_WeaponDesc = {
    Text = "소환된 몬스터의 HP와 피해가 2배로 증가한다."
  },
  State_24174_Desc = {
    Text = "해당 깨어남체는 더 이상 피해로 인해 HP가 1 미만으로 떨어지지 않는다."
  },
  State_24174_Name = {
    Text = "죽음 면역"
  },
  State_2418_Desc = {
    Text = "[광기 폭발]로 자신이 광기 30을 획득한다."
  },
  State_2418_Name = {
    Text = "이화된 신의 베일"
  },
  State_2418_WeaponDesc = {
    Text = "[광기 폭발]로 자신이 광기 30을 획득한다."
  },
  State_2419_Name = {
    Text = "유물 백색 거울면"
  },
  State_2420_Desc = {
    Text = "이번 턴에 「방어」를 1장 사용할 때마다 행동력 소모가 1 감소한다."
  },
  State_2420_Name = {
    Text = "심안의 칼날"
  },
  State_2420_WeaponDesc = {
    Text = "이번 턴에 「방어」를 1장 사용할 때마다 행동력 소모가 1 감소한다."
  },
  State_24210_Desc = {
    Text = "이번 턴에 신왕의 촉수 공격 대상이 모든 적으로 변경된다."
  },
  State_24210_Name = {
    Text = "신국 완지 - 열쇠 지령"
  },
  State_24211_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg4]회 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg6]회).\n· 깨어남체가 광기 폭발을 사용할 때마다, 이번 턴에 공격을 1회 추가로 발동한다.\n· 수호자가 열쇠 지령을 사용한 후, 이번 턴에 발동하는 공격 대상이 모든 적으로 변경된다. 보스전일 경우, 「신국 완지」가 주는 피해가 [DescArg5] 추가로 증가한다."
  },
  State_24211_Name = {
    Text = "신국 완지"
  },
  State_24213_Name = {
    Text = "이 카드가 손에 있을 경우, 턴 종료 시 150pt 은열쇠 에너지 획득"
  },
  State_24214_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg2]의 피해를 준다."
  },
  State_24214_Name = {
    Text = "신국 완지"
  },
  State_24215_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg4]회)."
  },
  State_24215_Name = {
    Text = "신국 완지"
  },
  State_24217_Name = {
    Text = "자신의 <VulnerabilityIconKeywords:취약>, <WeaknessIconKeywords:허약>, <FragileIconKeywords:손상> 상태를 해제한다."
  },
  State_24220_Name = {
    Text = "실타래드 [DescArg1]pt 획득"
  },
  State_24222_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg4]회 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg5]회).\n· 깨어남체가 광기 폭발을 사용할 때마다, 이번 턴에 공격을 1회 추가로 발동한다.\n· 수호자가 열쇠 지령을 사용할 때마다, 이번 턴에 발동하는 공격 대상이 모든 적으로 변경된다."
  },
  State_24222_Name = {
    Text = "신국 완지"
  },
  State_24223_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg4]회).\n· 수호자가 열쇠 지령을 사용할 때마다, 이번 턴에 발동하는 공격 대상이 모든 적으로 변경된다."
  },
  State_24223_Name = {
    Text = "신국 완지"
  },
  State_24224_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg4]회 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg5]회).\n· 깨어남체가 광기 폭발을 사용할 때마다, 이번 턴에 공격을 1회 추가로 발동한다."
  },
  State_24224_Name = {
    Text = "신국 완지"
  },
  State_24226_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg4]회 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg6]회).\n· 깨어남체가 광기 폭발을 사용할 때마다, 이번 턴에 공격을 1회 추가로 발동한다.\n· 보스전에서 수호자가 열쇠 지령을 사용할 때마다, 「신국 완지」의 피해가 [DescArg5] 증가한다."
  },
  State_24226_Name = {
    Text = "신국 완지"
  },
  State_24227_Desc = {
    Text = "· 턴 종료 후, 전방 적에게 [DescArg2]의 피해를 준다. 적을 처치할 경우, 해당 피해가 [DescArg3] 증가하며, 최대 5회 증가한다(현재 [DescArg5]회).\n· 수호자가 열쇠 지령을 사용한 후, 이번 턴에 발동하는 공격 대상이 모든 적으로 변경된다. 보스전일 경우, 「신국 완지」가 주는 피해가 [DescArg4] 추가로 증가한다."
  },
  State_24227_Name = {
    Text = "신국 완지"
  },
  State_2422_Desc = {
    Text = "사용 후 [StateArg1]의 실타래드를 획득한다."
  },
  State_2422_Name = {
    Text = "<Rune_6:철벽>"
  },
  State_24245_Desc = {
    Text = "턴 종료 시, 모든 「히드라」의 권속을 부활시킨다. 권속이 사망할 때마다 1스택이 감소하며, 스택이 0이 되면 「히드라」가 형태를 변환하여 최종 전투를 시작한다."
  },
  State_24245_Name = {
    Text = "만 뱀 조종자"
  },
  State_24247_Desc = {
    Text = "받는 피해가 90% 감소한다. 턴 시작 시 「만사조시」 스택이 없으면, 이 상태를 제거한다."
  },
  State_24247_Name = {
    Text = "뱀 형태 장벽"
  },
  State_2425_Desc = {
    Text = "사용 후 소모된다. 명령 카드일 경우, 피해와 실타래드가 2배로 증가한다."
  },
  State_2425_Name = {
    Text = "<CardKeyWord:용해>"
  },
  State_2426_Desc = {
    Text = "매 턴 처음으로 사용하는 카드는 추가로 1회 더 발동하지만, 매 턴 최대 4장까지만 사용할 수 있다."
  },
  State_2427_Name = {
    Text = "상태@환몽 은열쇠: 혈연의 심장 카운터"
  },
  State_2428_Desc = {
    Text = "악의 화의 <PVPProtectiveKeywords:장벽> 수량이 [Layer]스택 증가한다."
  },
  State_2428_Name = {
    Text = "원한 장벽"
  },
  State_2428_WeaponDesc = {
    Text = "악의 꽃의 장벽 수량이 [Layer]스택 증가한다."
  },
  State_24292_Name = {
    Text = "후열 전진"
  },
  State_24293_Name = {
    Text = "전열 후진"
  },
  State_2429_Desc = {
    Text = "주는 모든 피해가 [Layer]% 감소한다."
  },
  State_2429_Name = {
    Text = "임시 피해 감소"
  },
  State_2429_WeaponDesc = {
    Text = "주는 모든 피해가 [Layer]% 감소한다."
  },
  State_2430_Desc = {
    Text = "전투 시작 시, 모든 아군이 [왁스 갑옷] 3스택을 획득한다. 턴 종료 시, 아군 팀에 [Arg1]스택의 출혈을 부여한다."
  },
  State_2430_Name = {
    Text = "「밀랍의 신사」"
  },
  State_2430_WeaponDesc = {
    Text = "전투 시작 시, 모든 아군이 [왁스 갑옷] 3스택을 획득한다. 턴 종료 시, 아군 팀에 [Arg1]스택의 출혈을 부여한다."
  },
  State_2431_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드와 HP 회복이 증가하며, 증가량은 장착한 깨어남체의 체질 <WeaponEffect_Num:[StateArg1]%>이다. 장착한 깨어남체가 주는 반격이 <WeaponEffect_Num:[StateArg3]%> 증가하고, 「방어」 사용 시 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg4]%>만큼의 <RetaliateIconKeywords:반격>을 추가로 획득한다. 전투 시작 후, 장착한 깨어남체의 체질 <WeaponEffect_Num:[StateArg2]%>만큼의 <PowerIconKeywords:힘>을 획득한다. 현재 계역이 「심해」일 경우, 동일한 양의 촉수 피해를 추가로 획득한다."
  },
  State_2431_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드와 HP 회복이 <WeaponEffect_Num:[DescArg1]> 증가하며, 장착한 깨어남체가 주는 반격이 <WeaponEffect_Num:[StateArg3]%> 증가한다. 「방어」 사용 시, <WeaponEffect_Num:[Counterattack:DescArg3]>의 <RetaliateIconKeywords:반격>을 추가로 획득한다. 전투 시작 후, <WeaponEffect_Num:[Power:DescArg2]>의 <PowerIconKeywords:힘>을 획득한다. 현재 계역이 「심해」일 경우, 동일한 양의 촉수 피해를 추가로 획득한다."
  },
  State_2432_Desc = {
    Text = "받는 능동 피해 및 촉수 피해가 50% 증가하며, 턴 종료 시 1 스택을 제거한다."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:취약>"
  },
  State_2432_WeaponDesc = {
    Text = "받는 모든 피해가 50% 증가한다."
  },
  State_2433_Desc = {
    Text = "매 턴 종료 시 [Layer]의 힘을 획득한다."
  },
  State_2433_Name = {Text = "분노"},
  State_2434_Name = {
    Text = "장식품 36호실타래의 고리"
  },
  State_2434_WeaponDesc = {
    Text = "장착한 깨어남체의 카드를 드로우할 때, 해당 카드의 행동력 소모가 0~3 사이에서 무작위로 변화한다."
  },
  State_2435_Desc = {
    Text = "이벤트19_2"
  },
  State_2435_Name = {
    Text = "이벤트19_2"
  },
  State_2435_WeaponDesc = {
    Text = "이벤트19_2"
  },
  State_2436_Desc = {
    Text = "획득하는 힘과 실타래드가 50% 감소하며, [Layer]턴 동안 지속된다."
  },
  State_2436_Name = {
    Text = "임시 저주"
  },
  State_2436_WeaponDesc = {
    Text = "턴 종료 전까지, 자신에게 부여되는 긍정 상태를 면역한다."
  },
  State_2438_Desc = {
    Text = "상태@유물 은백색 차분기 카운트"
  },
  State_2438_Name = {
    Text = "상태@유물 은백색 차분기 카운터"
  },
  State_2438_WeaponDesc = {
    Text = "상태@유물 은백색 차분기 카운트"
  },
  State_2440_Name = {
    Text = "카드 1장 뽑음"
  },
  State_2441_Name = {
    Text = "행동력 1pt 획득"
  },
  State_2442_Name = {
    Text = "전체 적에게 <VulnerabilityIconKeywords:취약>을 1스택 부여한다."
  },
  State_2443_Name = {
    Text = "전체 적에게 <WeaknessIconKeywords:허약> 1스택 부여"
  },
  State_2444_Name = {
    Text = "광기 <Energy:[DescArg1]>pt 획득"
  },
  State_2445_Name = {
    Text = "다른 깨어남체가 광기 <Energy:[DescArg1]>pt 획득"
  },
  State_2446_Name = {
    Text = "<DerivativeCardKeywords_4:「영감」> 1장을 덱에 넣기"
  },
  State_2447_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 명령 카드 치명타율과 치명타 피해, 명령 카드가 주는 실타래드, HP 회복, 광기 및 힘이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 현재 계역이 「초차원」일 경우, 「소멸」을 발동한 후 <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다. 초차원 턴에 진입한 후, 이번 턴의 다음 열쇠 지령이 2회 발동한다."
  },
  State_2447_WeaponDesc = {
    Text = "장착한 깨어남체의 명령 카드 치명타율과 치명타 피해, 명령 카드가 주는 실타래드, HP 회복, 광기 및 힘이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 현재 계역이 「초차원」일 경우, 「소멸」을 발동한 후 <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다. 초차원 턴에 진입한 후, 이번 턴의 다음 열쇠 지령이 2회 발동한다."
  },
  State_2448_Desc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_2448_Name = {
    Text = "<CardKeyWord:유지>"
  },
  State_2449_Desc = {
    Text = "실타래제 피해를 받은 후 [Layer]의 실타래드를 획득한다."
  },
  State_2449_Name = {Text = "버퍼"},
  State_2449_WeaponDesc = {
    Text = "실타래제 피해를 받은 후 [Layer]의 실타래드를 획득한다."
  },
  State_2450_Desc = {
    Text = "「타격」이 반드시 치명타로 적중한다. 치명타 피해가 50% 증가한다."
  },
  State_2451_Desc = {
    Text = "턴 종료 시, 다른 아군이 [Layer]의 힘을 획득한다."
  },
  State_2451_Name = {
    Text = "「계명의 불꽃」"
  },
  State_2452_Desc = {
    Text = "사용 후 [StateArg1]의 힘을 획득한다."
  },
  State_2452_Name = {
    Text = "<Rune_14_High:고급 난폭>"
  },
  State_2453_Name = {
    Text = "장식품 광합성 제례"
  },
  State_2453_WeaponDesc = {
    Text = "전투 시작 후, 장착한 깨어남체의 모든 카드가 유지를 획득한다."
  },
  State_2454_Desc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않고, 덱에서 제거된다."
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:소모>"
  },
  State_2454_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_24556_Name = {
    Text = "상태@대마술사 후디니@행운의 관객 환호 추가"
  },
  State_2455_Name = {
    Text = "상태@청염무사 계령 7"
  },
  State_24560_Desc = {
    Text = "열쇠 지령을 사용할 때마다 순행·라모나의 임시 치명타율과 임시 치명타 피해가 25% 증가한다."
  },
  State_24560_Name = {
    Text = "클라인 여행자"
  },
  State_24562_Desc = {
    Text = "턴 종료 후, 음엔트로피 1스택을 획득한다."
  },
  State_24562_Name = {
    Text = "펜로즈 행진자"
  },
  State_24564_Desc = {
    Text = "음엔트로피 3스택을 보유할 때마다 순행·라모나의 명령 카드를 사용하면 모든 음엔트로피를 소모하고 회환 추가 효과가 발동된다. 음엔트로피는 최대 3스택까지 중첩된다."
  },
  State_24564_Name = {
    Text = "음엔트로피"
  },
  State_2456_Name = {
    Text = "상태@청염 무사 계령 15"
  },
  State_2457_Name = {
    Text = "카드 1장 뽑기"
  },
  State_24584_Name = {
    Text = "상태@N의 분신@속삭임 1 상태 전환"
  },
  State_2458_Name = {
    Text = "상태@장식품 핏빛의 포옹 효과 카운터"
  },
  State_24593_Desc = {
    Text = "스택이 0일 때, 의도를 「검은 소환」으로 변경한다. 턴 종료 시 1스택이 감소하며, 최대 4스택까지 가질 수 있다."
  },
  State_24593_Name = {Text = "혼돈"},
  State_24595_Desc = {
    Text = "사망 후 즉시 「N」의 「혼돈」 1스택을 감소시킨다."
  },
  State_24595_Name = {Text = "확산"},
  State_24596_Desc = {
    Text = "「N」의 분신을 소환할 때, 「어둠」 1스택당 분신 1개를 소환한다."
  },
  State_24596_Name = {Text = "어둠"},
  State_2460_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해, <IntoxicationIconKeywords:중독> 및 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg1]%> 증가하며, 치명타율과 치명타 피해가 <WeaponEffect_Num:[StateArg2]%> 증가한다."
  },
  State_2460_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해, <IntoxicationIconKeywords:중독> 및 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg1]%> 증가하며, 치명타율과 치명타 피해가 <WeaponEffect_Num:[StateArg2]%> 증가한다."
  },
  State_2461_Desc = {
    Text = "이번 전투에서 치명적 피해를 받을 때 부활하며, [Layer]pt의 HP를 회복하고 모든 깨어남체가 [StateArg1]pt의 광기를 획득한다. 해제할 수 없다."
  },
  State_2461_Name = {
    Text = "불멸의 극락조"
  },
  State_2463_Desc = {
    Text = "전투 시작 시 배아 융합이 20% 증가한다. 깨어남체의 광기가 가득 찬 상태일 때마다 배아 융합이 추가로 20% 증가한다."
  },
  State_24640_Desc = {
    Text = "전투 시작 후, 배아 융합이 [Blood:DescArg1] 증가하며, 죽음 저항이 발동될 때마다 배아 융합이 [Blood:DescArg1] 증가한다. 소렐이 피해를 줄 때마다, 이번 턴 동안 자신이 주는 피해가 공격력의 4%만큼 증가한다."
  },
  State_24640_Name = {Text = "명주"},
  State_2464_Desc = {
    Text = "카드의 행동력이 증가한다."
  },
  State_2464_Name = {
    Text = "영구 카드 행동력 증가"
  },
  State_2464_WeaponDesc = {
    Text = "카드의 행동력이 증가한다."
  },
  State_24654_Desc = {
    Text = "다프다엘이 어떤 방식으로든 적을 처치하면, 이번 스테이지에서 팀의 치명타율이 영구적으로 5% 증가한다. 최대 5회 중첩된다. (현재 [DescArg1]회 중첩됨)"
  },
  State_24654_Name = {
    Text = "탐욕의 안개"
  },
  State_2466_Desc = {
    Text = "다음 턴 시작까지, 공격 피해를 1회 받을 때마다 촉수로 공격자를 1회 반격하며, 임시 촉수 데미지 +[Layer]."
  },
  State_2466_Name = {
    Text = "[폐기됨] 이단의 혈통"
  },
  State_24678_Name = {
    Text = "상태@N의 분신@속삭임 2 상태 전환"
  },
  State_24679_Name = {
    Text = "상태@N의 분신 3@속삭임 6 상태 전환"
  },
  State_2467_Desc = {
    Text = "상태@프롤로그 공세 연습"
  },
  State_2467_Name = {
    Text = "상태@프롤로그 공세 연습"
  },
  State_2467_WeaponDesc = {
    Text = "상태@프롤로그 공세 연습"
  },
  State_24680_Name = {
    Text = "상태@N의 분신 2@속삭임 1 상태 전환"
  },
  State_24681_Name = {
    Text = "상태@N의 분신@속삭임 6 상태 전환"
  },
  State_24682_Name = {
    Text = "상태@N의 분신 3@속삭임 3 상태 전환"
  },
  State_24683_Name = {
    Text = "상태@N의 분신 2@속삭임 2 상태 전환"
  },
  State_24684_Name = {
    Text = "상태@N의 분신@속삭임 4 상태 전환"
  },
  State_24685_Name = {
    Text = "상태@N의 분신@속삭임 5 상태 전환"
  },
  State_24686_Name = {
    Text = "상태@N의 분신 3@속삭임 5 상태 전환"
  },
  State_24687_Name = {
    Text = "상태@N의 분신 3@속삭임 2 상태 전환"
  },
  State_24688_Name = {
    Text = "상태@N의 분신 2@속삭임 6 상태 전환"
  },
  State_24689_Name = {
    Text = "상태@N의 분신 3@속삭임 4 상태 전환"
  },
  State_24690_Name = {
    Text = "상태@N의 분신 3@속삭임 1 상태 전환"
  },
  State_24691_Name = {
    Text = "상태@N의 분신 2@속삭임 4 상태 전환"
  },
  State_24692_Name = {
    Text = "상태@N의 분신 2@속삭임 3 상태 전환"
  },
  State_24693_Name = {
    Text = "상태@N의 분신@속삭임 3 상태 전환"
  },
  State_24694_Name = {
    Text = "상태@N의 분신 2@속삭임 5 상태 전환"
  },
  State_2470_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 경계를 잃고, 주는 능동 피해가 추가로 힘 1배의 보너스를 받는다."
  },
  State_24719_Desc = {
    Text = "「@2」가 해방된 모습으로 현현하여, HP가 원래의 3배로 증가한다."
  },
  State_24719_Name = {
    Text = "운명의 부활"
  },
  State_24719_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_2471_Desc = {
    Text = "턴 시작 시, 아군 팀의 경계가 1 감소한다."
  },
  State_2471_Name = {Text = "부식"},
  State_2471_WeaponDesc = {
    Text = "턴 시작 시, 아군 팀의 경계가 1 감소한다."
  },
  State_24720_Desc = {
    Text = "미지의 존재의 힘은 아직 검은 웅덩이 아래에 잠들어 있으며, 패배 직전에 완전히 부활하여 HP를 회복하고 해방된 모습으로 전투를 시작한다."
  },
  State_24720_Name = {Text = "잠복"},
  State_2472_Desc = {
    Text = "실타래드와 HP에 동시에 피해를 주며, 면역될 수 없다."
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:관통 피해>"
  },
  State_2472_WeaponDesc = {
    Text = "관통 피해는 대상의 실타래드와 피해 감소를 무시하고 직접 피해를 준다."
  },
  State_24730_Desc = {
    Text = "임시 초차원 공간을 추가하며, 상한은 10이다. 다음 초차원 턴 진입 시, 임시 초차원 공간의 카드가 손으로 이동하고, 임시 초차원 공간이 제거된다."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:임시 초차원 공간>"
  },
  State_24737_Desc = {
    Text = "턴 시작 시, 상대에게 출혈을 입히며, 운명 1스택당 [StateArg1]의 출혈을 일으킨다."
  },
  State_24737_Name = {Text = "운명"},
  State_24738_Desc = {
    Text = "운명 1스택이 발동될 때 [StateArg1]의 출혈을 일으키며, 카드 1장을 사용할 때마다 운명 1스택이 감소한다."
  },
  State_24738_Name = {Text = "운명"},
  State_24739_Name = {Text = "운명"},
  State_2473_Desc = {
    Text = "[방어]가 촉수 1개를 잃고, [StateArg1]의 HP를 회복한다. [타격]이 [StateArg2]의 HP를 잃고, 촉수 1개를 생성한다."
  },
  State_2473_Name = {
    Text = "유물 장생자의 혈육"
  },
  State_2473_WeaponDesc = {
    Text = "[방어]가 촉수 1개를 잃고, [StateArg1]의 HP를 회복한다. [타격]이 [StateArg2]의 HP를 잃고, 촉수 1개를 생성한다."
  },
  State_2474_Desc = {
    Text = "공격력이 [Layer]% 증가한다."
  },
  State_2474_Name = {
    Text = "일반 공격력 비율 증가"
  },
  State_2474_WeaponDesc = {
    Text = "공격력이 [Layer]% 증가한다."
  },
  State_2475_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 능동 피해가 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg3]%>만큼 증가한다. 장착한 깨어남체의 명령 카드를 1장 사용하거나 버릴 때마다, 무작위 적에게 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 <IntoxicationIconKeywords:중독>을 부여한다. 초차원 턴 종료 후, <WeaponEffect_Num:[StateArg2]%> 확률로 모든 적의 중독을 100% 발동시킨다."
  },
  State_2475_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 능동 피해가 <WeaponEffect_Num:[DescArg2]> 증가한다. 장착한 깨어남체의 명령 카드를 1장 사용하거나 버릴 때마다, 무작위 적에게 <WeaponEffect_Num:[DescArg1]>스택의 <IntoxicationIconKeywords:중독>을 부여한다. 초차원 턴 종료 후, <WeaponEffect_Num:[StateArg2]%> 확률로 모든 적의 중독을 [DescArg3]% 발동시킨다."
  },
  State_2476_Name = {
    Text = "상태@본원 지자 계령1"
  },
  State_2478_Desc = {
    Text = "노틸러스가 부여하는 실타래드가 2배로 증가한다."
  },
  State_2478_Name = {
    Text = "수리 전문가"
  },
  State_2478_WeaponDesc = {
    Text = "노틸러스가 부여하는 실타래드가 2배로 증가한다."
  },
  State_2479_Desc = {
    Text = "청화염이 피해를 줄 때마다, 스택이 1 증가한다."
  },
  State_2479_Name = {
    Text = "비취영상 카운트"
  },
  State_2479_WeaponDesc = {
    Text = "청화염이 피해를 줄 때마다, 스택이 1 증가한다."
  },
  State_2480_Desc = {
    Text = "HP를 회복할 때 [StateArg1]의 반격을 획득한다. 침연자가 카드를 1장 사용할 때마다 HP 1을 회복한다."
  },
  State_2480_Name = {
    Text = "변형의 육체"
  },
  State_2481_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_2_3_1"
  },
  State_2481_Name = {
    Text = "상태@프롤로그 덱 초기화 0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_2_3_1"
  },
  State_2482_Desc = {
    Text = "HP가 50% 미만일 때 동일한 HP를 가진 융식 삼각형 중 1개를 소환한다."
  },
  State_2482_Name = {Text = "소환"},
  State_2482_WeaponDesc = {
    Text = "HP가 50% 미만일 때 동일한 HP를 가진 융식 삼각형 중 1개를 소환한다."
  },
  State_2486_Desc = {
    Text = "턴 시작 시 적 1명당 행동력 1을 획득한다. 능동 피해로 적을 처치할 때, 다른 적에게 과잉 피해와 동일한 양의 출혈을 부여한다."
  },
  State_24879_Desc = {
    Text = "천 년이 지나고, 만 년이 지나도, 그들은 영원한 어둠의 폐허에서 은총을 기다린다. 사망 후 즉시 「N」의 「혼돈」 1스택이 감소하며, 「N」은 [DescArg1]의 실타래드와 [DescArg2]의 힘을 획득한다."
  },
  State_24879_Name = {
    Text = "허상 분신"
  },
  State_2488_Desc = {
    Text = "「강화 카드」/「증상 카드」/「상태 카드」를 사용할 때마다, 광기가 가장 낮은 깨어남체가 광기 10을 획득한다."
  },
  State_2489_Desc = {
    Text = "치명타율이 10% 증가한다. 매 턴 처음으로 치명타를 발생시킨 후 치명타율이 추가로 20% 증가하며, 매 턴 3번째 치명타를 발생시키면 치명타 피해가 추가로 50% 증가한다."
  },
  State_2490_Desc = {
    Text = "스택당 공격 횟수가 1 증가하며, 피해를 받으면 1스택이 감소한다. 턴 종료 시 모든 스택이 사라진다."
  },
  State_2490_Name = {Text = "기도"},
  State_2491_Desc = {
    Text = "HP를 회복할 때 회복량과 동일한 실타래드를 획득한다."
  },
  State_2491_Name = {
    Text = "임시 경화"
  },
  State_2492_Desc = {
    Text = "매 턴 첫 번째 능동 피해를 면역한다."
  },
  State_2492_Name = {Text = "견고"},
  State_2492_WeaponDesc = {
    Text = "매 턴 첫 번째 능동 피해를 면역한다."
  },
  State_2493_Desc = {
    Text = "주는 능동 피해가 [Layer]pt 감소한다."
  },
  State_2493_Name = {Text = "힘 감소"},
  State_2494_Desc = {
    Text = "상태@프롤로그 광기 0_1_4_1"
  },
  State_2494_Name = {
    Text = "상태@프롤로그 광기 0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_4_1"
  },
  State_2495_Desc = {
    Text = "상태@프롤로그 광기 0_1_4_2"
  },
  State_2495_Name = {
    Text = "상태@프롤로그 광기 0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_4_2"
  },
  State_24968_Desc = {
    Text = "전투 시작 후, 배아 융합이 [Blood:DescArg2] 증가하며, 죽음 저항이 발동될 때마다 배아 융합이 [Blood:DescArg2] 증가한다. 소렐이 피해를 줄 때마다, 이번 턴 동안 자신이 주는 피해가 [DescArg1]pt 증가한다."
  },
  State_24968_Name = {Text = "명주"},
  State_2496_Desc = {
    Text = "턴 시작 시 [Arg1]의 HP를 회복한다. HP가 50% 미만일 경우, 회복량이 [Arg2]로 변경된다."
  },
  State_2496_Name = {
    Text = "은사의 피"
  },
  State_24976_Desc = {
    Text = "「볼록 달의 시녀」가 깨어남했다. 특제 요리가 가져올 위험을 조심하라!"
  },
  State_24976_Name = {
    Text = "가렌 깨어남!"
  },
  State_24976_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_24977_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_24977_Name = {
    Text = "미깨어남"
  },
  State_2497_Desc = {
    Text = "릴리는 플레이어가 매 턴 사용한 첫 번째 명령 카드를 모방한다. 타격 카드일 경우 릴리의 공격 횟수가 1 증가하고, 방어 카드일 경우 릴리는 최대 HP의 10%만큼 실타래드를 획득한다. 다른 명령 카드일 경우, 릴리도 무슨 일인지 모르고 여기에 농포를 하나 둔다."
  },
  State_2497_Name = {
    Text = "릴리 깨어남!"
  },
  State_2497_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_2498_Name = {
    Text = "장식품 저주 토끼"
  },
  State_2498_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드와 HP 회복이 6% 증가한다. 장착한 깨어남체의 영역 숙련이 50을 초과할 경우, 실타래드와 HP 회복이 추가로 6% 증가한다."
  },
  State_2499_Name = {
    Text = "정체의 저주"
  },
  State_2500_Desc = {
    Text = "실타래제 피해를 입힐 때마다 중독을 부여한다."
  },
  State_2500_Name = {Text = "독소"},
  State_2501_Desc = {
    Text = "팀 유일: 팀의 최대 HP가 10% 증가한다. 장착한 깨어남체가 주는 치유와 실타래드가 <WeaponEffect_Num:[StateArg3]%> 증가한다. 장착한 깨어남체의 「타격」 사용 후, 잃은 HP의 <WeaponEffect_Num:[StateArg1]%>를 회복한다. 장착한 깨어남체의 「방어」 사용 후, 현재 HP의 <WeaponEffect_Num:[StateArg2]%>만큼 실타래드를 획득한다. 이 효과는 매 턴 각각 최대 1회 발동된다."
  },
  State_2501_Name = {
    Text = "영혼의 탄생"
  },
  State_2501_WeaponDesc = {
    Text = "팀의 최대 HP가 10% 증가한다. 장착한 깨어남체가 주는 치유와 실타래드가 <WeaponEffect_Num:[StateArg3]%> 증가한다. 장착한 깨어남체의 「타격」 사용 후, 잃은 HP의 [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>)를 회복한다. 장착한 깨어남체의 「방어」 사용 후, 현재 HP의 [StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>)만큼 실타래드를 획득한다. 이 효과는 매 턴 각각 최대 1회 발동된다."
  },
  State_2502_Desc = {
    Text = "가하는 능동 및 촉수 피해가 50 % 감소."
  },
  State_2502_Name = {
    Text = "적멸의 허약"
  },
  State_2502_WeaponDesc = {
    Text = "주는 모든 피해가 50% 감소한다."
  },
  State_2503_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 카드가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 턴 시작 시, <WeaponEffect_Num:[StateArg2]%> 확률로 장착한 깨어남체의 무작위 카드 1장을 손에 생성하며, 소모를 부여한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체에게 「배아」를 사용할 때, 장착한 깨어남체의 이번 턴 다음 타격 카드의 치명타율이 <WeaponEffect_Num:+[StateArg3]%> 증가한다."
  },
  State_2503_WeaponDesc = {
    Text = "장착한 깨어남체의 카드가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 턴 시작 시, <WeaponEffect_Num:[StateArg2]%> 확률로 장착한 깨어남체의 무작위 카드 1장을 손에 생성하며, 소모를 부여한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체에게 「배아」를 사용할 때, 장착한 깨어남체의 이번 턴 다음 타격 카드의 치명타율이 <WeaponEffect_Num:+[StateArg3]%> 증가한다."
  },
  State_2504_Desc = {
    Text = "「타격」이 행동력 2를 획득하고, 무작위로 카드 1장을 버린다. 「방어」가 카드 2장을 드로우하고, 행동력 1을 잃는다."
  },
  State_25056_Desc = {
    Text = "행동력을 소모할 때마다, 카렌이 [Layer]의 임시 힘을 획득한다."
  },
  State_25056_Name = {Text = "배부름"},
  State_25057_Desc = {
    Text = "행동력을 소모할 때마다 카렌이 [StateArg1]의 임시 힘을 획득하며, 턴 종료 시 1스택이 제거된다."
  },
  State_25057_Name = {Text = "배부름"},
  State_2505_Name = {
    Text = "장식품 사월의 찬가"
  },
  State_2505_WeaponDesc = {
    Text = "전투 시작 후, 장착한 깨어남체의 직업이 초차원일 경우 공격력이 25% 증가한다."
  },
  State_2507_Desc = {
    Text = "획득 시 최대 HP가 100% 증가하고, 턴 시작 시 [Arg1]의 HP를 잃는다."
  },
  State_2509_Name = {
    Text = "상태@일반 영역 숙련"
  },
  State_2511_Desc = {
    Text = "상태@프롤로그 열쇠 에너지 교습"
  },
  State_2511_Name = {
    Text = "상태@프롤로그 열쇠 에너지 교습"
  },
  State_2511_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_2"
  },
  State_2512_Desc = {
    Text = "행동력 소모가 3 이상인 카드를 1장 사용하면, 카드 1장을 드로우하고 행동력 1을 획득한다."
  },
  State_2514_Desc = {
    Text = "이번 전투 내에서 생성하는 실타래드가 [Layer]pt 감소한다."
  },
  State_2514_Name = {
    Text = "경계 감소"
  },
  State_2514_WeaponDesc = {
    Text = "이번 전투 내에서 생성하는 실타래드가 [Layer]pt 감소한다."
  },
  State_2515_Desc = {
    Text = "[타격]이 모든 적에게 [StateArg1]스택의 중독을 부여한다."
  },
  State_2515_Name = {
    Text = "유물 신경 독소"
  },
  State_25163_Desc = {
    Text = "그는 안개처럼 이해하기 어렵다."
  },
  State_25163_Name = {
    Text = "과거의 그림자"
  },
  State_25165_Desc = {
    Text = "순행·라모나 명령 카드의 고유 추가 효과로, 음엔트로피 3스택을 보유할 때 발동된다. 회환은 다음 전투로 이월된다."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:회귀>"
  },
  State_25166_Desc = {
    Text = "음엔트로피 3스택을 보유할 때마다 순행·라모나의 명령 카드를 사용하면 모든 음엔트로피를 소모하고 회환 추가 효과가 발동된다. 음엔트로피는 최대 3스택까지 중첩된다."
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:음엔트로피>"
  },
  State_2516_Desc = {
    Text = "사용할 수 없다."
  },
  State_2516_Name = {
    Text = "사용 불가"
  },
  State_2516_WeaponDesc = {
    Text = "카드를 사용할 수 없다."
  },
  State_25179_Name = {
    Text = "광기 판정"
  },
  State_2517_Desc = {
    Text = "아군 팀이 광기 폭발을 발동한 후, 자신은 해당 턴에 힘을 잃는다. 1턴에 1회."
  },
  State_2517_Name = {
    Text = "공포의 광기"
  },
  State_25181_Name = {
    Text = "윤회 유지 효과"
  },
  State_2518_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_3"
  },
  State_2518_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_3"
  },
  State_25194_Desc = {
    Text = "사망 후 「N」에게 [DescArg1]의 실타래드와 [DescArg2]의 영구적인 힘을 추가한다."
  },
  State_2519_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_3"
  },
  State_2519_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_3"
  },
  State_25204_Name = {
    Text = "상태@N의 분신 2@의도 판정"
  },
  State_25205_Name = {
    Text = "상태@N의 분신 3@의도 판정"
  },
  State_25206_Name = {
    Text = "상태@N@N의 분신 판정 추가"
  },
  State_25207_Name = {
    Text = "상태@N의 분신@의도 판정"
  },
  State_2520_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_2"
  },
  State_2520_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_1_2"
  },
  State_2522_Desc = {
    Text = "히로가 이미 깨어남했으며, 공격 강도와 공격성이 향상될 것이다."
  },
  State_2522_Name = {
    Text = "히로 깨어남"
  },
  State_2523_Desc = {
    Text = "홀수 턴 시작 시, 이번 턴 내에서 [Arg1]의 힘을 획득한다. 짝수 턴 시작 시, 이번 턴 내에서 [Arg2]의 경계를 획득한다."
  },
  State_2524_Desc = {
    Text = "전투 시작 시, 힘 1을 획득한다."
  },
  State_2524_Name = {
    Text = "널리 알려진 명성"
  },
  State_2525_Desc = {
    Text = "공격 횟수가 1 감소하고, [Layer]의 힘을 획득한다."
  },
  State_2525_Name = {Text = "방종"},
  State_2527_Name = {
    Text = "핏빛 힘 보너스"
  },
  State_2528_Desc = {
    Text = "실타래제 행동력 소모가 3인 카드를 1장 사용할 때, 카드 1장을 드로우하고 행동력 2를 획득한다."
  },
  State_2529_Desc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_2529_Name = {
    Text = "임시 치명타 피해"
  },
  State_2529_WeaponDesc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_2531_Desc = {
    Text = "청화염이 [Damage:StateArg2]회 피해를 줄 때마다, 소모되는 「푸른 불꽃」 1장을 획득한다."
  },
  State_2531_Name = {
    Text = "비취영상"
  },
  State_2531_WeaponDesc = {
    Text = "청화염이 [Damage:StateArg2]회 피해를 줄 때마다, 소모되는 「푸른 불꽃」 1장을 획득한다."
  },
  State_2532_Name = {
    Text = "장식품 핏빛의 심계"
  },
  State_2534_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_3"
  },
  State_2534_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_3"
  },
  State_2535_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_2"
  },
  State_2535_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_2"
  },
  State_2536_Name = {
    Text = "상태@임시 타격 카드 치명타 피해 증가"
  },
  State_2537_Desc = {
    Text = "공상의 검이 실타래드를 부여할 때, [StateArg2]의 임시 경계를 획득한다."
  },
  State_2537_Name = {
    Text = "전장의 탁견"
  },
  State_2537_WeaponDesc = {
    Text = "공상의 검이 실타래드를 부여할 때, [StateArg2]의 임시 경계를 획득한다."
  },
  State_2538_Desc = {
    Text = "사용 후 [StateArg1] 층의 반격을 획득하고, 모든 적에게 반격의 [StateArg2]% <FixedDamage:순수 피해>를 가함."
  },
  State_2538_Name = {
    Text = "<Rune_9_High:고급 가시>"
  },
  State_25391_Desc = {
    Text = "팀에 이미 한 명의 깨어남체가 「행운의 관객」으로 선택되었다. 해당 깨어남체의 모든 카드는 「환호」 효과를 가진다."
  },
  State_25391_Name = {
    Text = "행운의 관객"
  },
  State_25392_Desc = {
    Text = "사용 후, 최대 HP의 2%를 잃고, 대마술사는 이번 턴에 「의기양양」 1스택을 획득한다."
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:응원>"
  },
  State_25401_Desc = {
    Text = "이 카드가 손에 있을 때 손패 상한이 1 증가한다."
  },
  State_25401_Name = {
    Text = "손패 상한 무시"
  },
  State_25403_Desc = {
    Text = "촉수 피해가 50% 감소하며, 촉수 피해를 1회 줄 때마다 [Layer]pt의 실타래드를 획득한다."
  },
  State_25403_Name = {Text = "정해"},
  State_25405_Desc = {
    Text = "이 카드는 모든 상황에서 손에 있다."
  },
  State_25405_Name = {
    Text = "영구 유지"
  },
  State_25406_Desc = {
    Text = "이번 턴 내에서 더 이상 촉수 자세를 전환할 수 없다."
  },
  State_25406_Name = {
    Text = "심해의 광기·제한"
  },
  State_25407_Desc = {
    Text = "촉수 피해가 25% 증가하며, 턴 종료 시 촉수 수가 1 감소한다."
  },
  State_25407_Name = {
    Text = "심해의 광기"
  },
  State_25415_Desc = {
    Text = "열쇠 지령 발동 후, [Layer]의 열쇠 에너지를 획득한다."
  },
  State_25415_Name = {
    Text = "혼돈 임시 열쇠 에너지 과잉"
  },
  State_25417_Name = {Text = "폭탄 3"},
  State_25418_Name = {Text = "폭탄 2"},
  State_2542_Name = {
    Text = "상태@유물 무명의 부속지 카운터"
  },
  State_2543_Name = {
    Text = "상태@스테이지 2-14 전투 8 말풍선 1"
  },
  State_2544_Desc = {
    Text = "상태@프롤로그 몬스터 패시브"
  },
  State_2544_Name = {
    Text = "상태@프롤로그 몬스터 패시브"
  },
  State_2544_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브"
  },
  State_2545_Desc = {
    Text = "전투 시작 시 배아 융합이 20% 증가한다. 깨어남체의 광기가 가득 찬 상태일 때마다 배아 융합이 추가로 20% 증가한다."
  },
  State_2547_Desc = {
    Text = "턴 시작 시, 이번 턴에 [Arg1]의 힘을 획득하는 「작살」 1장을 손에 넣는다. 광기 폭발을 발동한 후, 손에 있는 모든 「작살」의 힘을 [Arg2] 증가시킨다."
  },
  State_2548_Desc = {
    Text = "사망을 1회 면역하며, 발동 후 HP 50을 회복하고 해당 유물을 영구적으로 무효화한다."
  },
  State_2548_Name = {
    Text = "유물 대역 인형"
  },
  State_2548_WeaponDesc = {
    Text = "사망을 1회 면역하며, 발동 후 HP 50을 회복하고 해당 유물을 영구적으로 무효화한다."
  },
  State_2549_Desc = {
    Text = "주는 능동 피해와 촉수 피해가 감소한다."
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords:힘 감소>"
  },
  State_2549_WeaponDesc = {
    Text = "각 스택의 쇠약은 주는 피해와 촉수 피해를 1 감소시킨다."
  },
  State_2550_Desc = {
    Text = "뽑았을 때 자신에게 1턴간 손상을 부여한다. 사용 시 모든 적에게 1턴간 취약을 부여한다. 판매 불가."
  },
  State_2550_Name = {
    Text = "상태 저위 붕괴"
  },
  State_2550_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 손상을 부여한다. 사용 시 모든 적에게 1턴간 취약을 부여한다. 판매 불가."
  },
  State_2552_Desc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:유지>"
  },
  State_2552_WeaponDesc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_2553_Desc = {
    Text = "턴 시작 시, 행동력 1을 획득한다."
  },
  State_2553_Name = {
    Text = "상태@유물 아르카나 행동력"
  },
  State_2553_WeaponDesc = {
    Text = "턴 시작 시, 행동력 1을 획득한다."
  },
  State_2554_Name = {
    Text = "퍼트니 조간신문"
  },
  State_2556_Desc = {
    Text = "HP가 감소한 후, 감소한 수치의 [Layer]%만큼 실타래드를 획득한다."
  },
  State_2556_Name = {
    Text = "피의 보호막"
  },
  State_2556_WeaponDesc = {
    Text = "HP가 감소한 후, 감소한 수치의 [Layer]%만큼 실타래드를 획득한다."
  },
  State_2557_Desc = {
    Text = "다음 턴 시작 시, [Layer]pt의 실타래드를 획득한다."
  },
  State_2557_Name = {
    Text = "고통과 환희 실타래드"
  },
  State_2558_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「간섭형 융식체」 2개로 분열된다."
  },
  State_2558_Name = {Text = "분열"},
  State_2558_WeaponDesc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체」 2개로 분열된다."
  },
  State_2559_Desc = {
    Text = "공격을 받을 때마다 [Layer]의 임시 힘을 잃는다."
  },
  State_2559_Name = {
    Text = "충동의 대가"
  },
  State_2560_Desc = {
    Text = "다음 턴 시작 후 [Layer]pt의 실타래드를 획득한다."
  },
  State_2560_Name = {
    Text = "폐쇄적 창작"
  },
  State_2560_WeaponDesc = {
    Text = "다음 턴 시작 후 [Layer]pt의 실타래드를 획득한다."
  },
  State_2561_Desc = {
    Text = "우울한 재능"
  },
  State_2561_Name = {
    Text = "우울한 재능"
  },
  State_2561_WeaponDesc = {
    Text = "우울한 재능"
  },
  State_2562_Name = {
    Text = "상태@장3_공명1_표식"
  },
  State_2563_Desc = {
    Text = "매 10번째 카드를 사용할 때마다, 촉수 피해가 2 증가하며, 모든 촉수가 1회 공격한다."
  },
  State_2563_Name = {
    Text = "유물 작살"
  },
  State_2563_WeaponDesc = {
    Text = "매 10번째 카드를 사용할 때마다, 촉수 피해가 2 증가하며, 모든 촉수가 1회 공격한다."
  },
  State_2564_Desc = {
    Text = "획득하는 모든 실타래드가 [DescArg1]% 감소한다."
  },
  State_2564_Name = {
    Text = "<FragileColour:손상>"
  },
  State_2564_WeaponDesc = {
    Text = "획득하는 모든 실타래드가 33% 감소한다."
  },
  State_2565_Name = {
    Text = "장식품 핏빛의 포옹"
  },
  State_2565_WeaponDesc = {
    Text = "장착한 깨어남체가 피해를 입힐 때 은열쇠 에너지 20을 획득하며, 치명타 피해를 입힐 경우 은열쇠 에너지 50을 획득한다. 매 턴 최대 3회 발동된다."
  },
  State_2566_Desc = {
    Text = "한 턴 내에 3번 공격을 받으면 임시 <MadnessColour:발광> 1스택을 획득합니다."
  },
  State_2566_Name = {
    Text = "「달콤한 고통」"
  },
  State_2567_Desc = {
    Text = "[Layer] 번 피해를 받았으며, 3번에 달하면 「달콤한 악귀」가 이번 턴 내 <MadnessColour:발광> 1스택을 획득합니다."
  },
  State_2567_Name = {
    Text = "「달콤한 고통」 횟수"
  },
  State_2567_WeaponDesc = {
    Text = "이미 [Layer]회 피해를 받았으며, 3회에 도달하면 「달콤한 악귀」가 이번 턴 동안 광란 1스택을 획득한다."
  },
  State_2569_Desc = {
    Text = "계역 추천 보너스 효과가 50%로 증가하며, 스테이지 시작 시 영역 숙련이 100 증가한다."
  },
  State_2569_Name = {
    Text = "상태@환몽 은열쇠: 적성 분리"
  },
  State_2570_Desc = {
    Text = "사용 후 [StateArg1]장의 카드를 드로우한다."
  },
  State_2570_Name = {
    Text = "<Rune_3:묘수>"
  },
  State_2571_Desc = {
    Text = "팀에 있는 【혼돈】 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_2571_Name = {
    Text = "혼돈 보너스"
  },
  State_2571_WeaponDesc = {
    Text = "팀에 있는 【혼돈】 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_2572_Desc = {
    Text = "사용 후 배아 융합 +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:흡혈>"
  },
  State_2573_Desc = {
    Text = "[도화선] 5스택을 보유한다. 카드를 사용하면 스택이 1 감소한다. 스택이 0이 되면 자폭하여 공격력 × 2.5의 피해를 준다."
  },
  State_2573_Name = {Text = "폭탄"},
  State_2573_WeaponDesc = {
    Text = "[도화선] 5스택을 보유한다. 카드를 사용하면 스택이 1 감소한다. 스택이 0이 되면 자폭하여 공격력 × 2.5의 피해를 준다."
  },
  State_2574_Desc = {
    Text = "치명타 피해가 50% 증가한다. 특정 턴에 공격하지 않았다면, 다음 턴에는 주는 피해가 반드시 치명타로 적중한다."
  },
  State_2574_Name = {
    Text = "상태@환몽 은열쇠: 윤무"
  },
  State_2575_Desc = {
    Text = "팀 유일: 전투 시작 시, 유물 1개당 장착한 깨어남체의 명령 카드 치명타율이 [StateArg1]% 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후 4면체 주사위를 던져, 장착한 깨어남체가 주사위 눈금 × <WeaponEffect_Num:[StateArg2]>만큼의 광기와 임시 치명타 피해를 획득한다. 4 이상이 나올 경우, 다른 깨어남체도 그 절반을 획득한다."
  },
  State_2575_WeaponDesc = {
    Text = "전투 시작 시, 유물 1개당 장착한 깨어남체의 명령 카드 치명타율이 [StateArg1]% 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후 4면체 주사위를 던져, 장착한 깨어남체가 주사위 눈금 × <WeaponEffect_Num:[StateArg2]>만큼의 광기와 임시 치명타 피해를 획득한다. 4 이상이 나올 경우, 다른 깨어남체도 그 절반을 획득한다."
  },
  State_2576_Desc = {
    Text = "카드가 초차원 공간에 들어갈 때마다, 해당 카드의 행동력 소모가 1 감소한다."
  },
  State_2579_Desc = {
    Text = "이번 턴 가하는 능동 피해 횟수가 [Layer] 증가."
  },
  State_2579_Name = {
    Text = "<MadnessColour:임시 발광>"
  },
  State_2580_Desc = {
    Text = "사냥꾼 해골 마녀의 카드가 초차원 공간에 들어가거나 나올 때마다, 행동력 1을 획득한다."
  },
  State_2580_Name = {
    Text = "차원 투영"
  },
  State_2581_Desc = {
    Text = "모든 깨어남체의 은열쇠 충전이 30 증가한다. 열쇠 지령 발동 후, <DerivativeCardKeywords_4:「영감」> 3장을 덱에 섞어 넣는다."
  },
  State_2581_Name = {
    Text = "상태@시계추 통찰"
  },
  State_2582_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_2582_Name = {
    Text = "상태@테스트 레이저포 광기"
  },
  State_2583_Desc = {
    Text = "능동 피해를 받을 때마다 아군 팀의 카운트가 1 증가한다."
  },
  State_2583_Name = {
    Text = "상태@복수의 거대한 검 참수 중상 카운트"
  },
  State_2583_WeaponDesc = {
    Text = "능동 피해를 받을 때마다 아군 팀의 카운트가 1 증가한다."
  },
  State_2584_Desc = {
    Text = "덱이 초기화될 때마다, [Arg1]의 힘을 획득한다."
  },
  State_2586_Desc = {
    Text = "획득하는 모든 실타래드가 25% 감소하며, 턴 종료 시 1스택이 제거된다."
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords:손상>"
  },
  State_2586_WeaponDesc = {
    Text = "획득하는 모든 실타래드가 25% 감소한다."
  },
  State_2587_Desc = {
    Text = "상처 피해가 2배로 증가한다. 실타래제 피해를 입힐 때마다 [Layer]pt의 실타래드를 획득한다."
  },
  State_2587_Name = {
    Text = "「천식의 이빨」"
  },
  State_2587_WeaponDesc = {
    Text = "상처 피해가 2배로 증가한다. 실타래제 피해를 입힐 때마다 [Layer]pt의 실타래드를 획득한다."
  },
  State_2588_Desc = {
    Text = "턴 종료 후, [Layer] 포인트의 <FixedDamage:순수 피해>를 받고 해당 상태를 제거합니다. HP 회복 시 회복량의 2배에 해당하는 출혈 스택을 제거합니다."
  },
  State_2588_Name = {
    Text = "영구 <BleedingColour: 출혈>"
  },
  State_2588_WeaponDesc = {
    Text = "턴 종료 후, [Layer]pt의 피해를 받고 해당 상태가 제거된다. 치유될 때마다 스택 수가 절반으로 감소한다."
  },
  State_2589_Name = {
    Text = "장식품 왜곡된 쌍자 흑"
  },
  State_2589_WeaponDesc = {
    Text = "홀수 턴 시작 후, 소모와 허무가 부여된 장착한 깨어남체의 [타격] 1장을 손에 넣는다."
  },
  State_2590_Desc = {
    Text = "이동 시 검은 인장 10을 획득한다."
  },
  State_2590_Name = {
    Text = "유물 무저갱"
  },
  State_2590_WeaponDesc = {
    Text = "이동 시 검은 인장 10을 획득한다."
  },
  State_2592_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 제거되며, 스택이 0이 되면 [DescArg1]의 실타래드를 획득한다."
  },
  State_2592_Name = {
    Text = "차원 장벽"
  },
  State_2593_Name = {
    Text = "상태@핏빛 피와 모래의 찬가"
  },
  State_2594_Desc = {
    Text = "실타래제 피해를 입히면 실타래드를 획득한다."
  },
  State_2594_Name = {
    Text = "「천식의 이빨」"
  },
  State_2594_WeaponDesc = {
    Text = "실타래제 피해를 입히면 실타래드를 획득한다."
  },
  State_2595_Desc = {
    Text = "피해를 1회 줄 때마다 [StateArg2]의 임시 힘을 획득한다."
  },
  State_2595_Name = {
    Text = "지자의 여왕의 검 개시"
  },
  State_2597_Desc = {
    Text = "턴 시작 후, [Layer]pt의 실타래드를 획득한다."
  },
  State_2597_Name = {
    Text = "지연 실타래드"
  },
  State_2597_WeaponDesc = {
    Text = "턴 시작 후, [Layer]pt의 실타래드를 획득한다."
  },
  State_2600_Desc = {
    Text = "HP를 잃을 때마다 광기가 가장 낮은 깨어남체가 광기 10을 획득한다. HP를 5회 잃을 때마다 장벽 1스택을 획득한다."
  },
  State_2600_Name = {
    Text = "시령추「해석」"
  },
  State_2601_Desc = {
    Text = "짝수 턴에 받는 피해가 50% 감소하고, 주는 피해가 33% 증가한다."
  },
  State_2601_Name = {Text = "변덕"},
  State_2601_WeaponDesc = {
    Text = "짝수 턴에 받는 피해가 50% 감소하고, 주는 피해가 33% 증가한다."
  },
  State_2602_Desc = {
    Text = "당신이 잠겼습니다! 사용 후 영원한 열광자가 [StateArg1]의 임시 힘을 획득하고, 해당 지령의 심해 낙인을 제거한다."
  },
  State_2602_Name = {
    Text = "<CardKeyWord:심해 마크>"
  },
  State_2602_WeaponDesc = {
    Text = "카드를 사용한 후 심해 잠수자 정예가 [StateArg1]의 임시 힘을 획득한다."
  },
  State_2603_Desc = {
    Text = "손에 「배아」가 있을 경우, 모든 「배아」를 소모하며, 배아 1장당 후속 효과를 1회 발동한다."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:무한 포식>"
  },
  State_2604_Desc = {
    Text = "이번 턴 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_2604_Name = {
    Text = "임시 치명타율"
  },
  State_2604_WeaponDesc = {
    Text = "이번 턴 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_2605_Desc = {
    Text = "HP가 95%([StateArg1]) 미만일 때, 동일한 HP를 가진 「실타래험 습작」 2개로 분열된다."
  },
  State_2605_Name = {Text = "분열"},
  State_2605_WeaponDesc = {
    Text = "HP가 30%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체 밀랍상」 3개로 분열된다."
  },
  State_2606_Desc = {
    Text = "HP가 90%([StateArg1]) 미만일 때, 동일한 HP를 가진 「실타래험 습작」 2개로 분열된다."
  },
  State_2606_Name = {Text = "분열"},
  State_2606_WeaponDesc = {
    Text = "HP가 30%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체 밀랍상」 3개로 분열된다."
  },
  State_2607_Desc = {
    Text = "전투 종료 후, HP 5를 회복한다."
  },
  State_2607_Name = {
    Text = "융기월의 시녀 계령 3"
  },
  State_2607_WeaponDesc = {
    Text = "전투 종료 후, HP 5를 회복한다."
  },
  State_2609_Desc = {
    Text = "HP가 30%([StateArg1]) 미만일 때, 동일한 HP를 가진 「실타래험 습작」 2개로 분열된다."
  },
  State_2609_Name = {Text = "분열"},
  State_2609_WeaponDesc = {
    Text = "HP가 30%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체 밀랍상」 3개로 분열된다."
  },
  State_2610_Desc = {
    Text = "HP가 70%([StateArg1]) 미만일 때, 동일한 HP를 가진 「실타래험 습작」 2개로 분열된다."
  },
  State_2610_Name = {Text = "분열"},
  State_2610_WeaponDesc = {
    Text = "HP가 30%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체 밀랍상」 3개로 분열된다."
  },
  State_2611_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「실타래험 습작」 2개로 분열된다."
  },
  State_2611_Name = {Text = "분열"},
  State_2611_WeaponDesc = {
    Text = "HP가 30%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체 밀랍상」 3개로 분열된다."
  },
  State_2612_Desc = {
    Text = "고대자 모방"
  },
  State_2612_Name = {
    Text = "고대자 모방"
  },
  State_2612_WeaponDesc = {
    Text = "고대자 모방"
  },
  State_2614_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 명령 카드를 사용한 후, <WeaponEffect_Num:[StateArg1]%> 확률로 버린 카드 더미에서 손으로 다시 가져온다. 이 효과는 단일 턴에 1회만 발동된다."
  },
  State_2614_WeaponDesc = {
    Text = "장착한 깨어남체의 명령 카드를 사용한 후, <WeaponEffect_Num:[StateArg1]%> 확률로 버린 카드 더미에서 손으로 다시 가져온다. 이 효과는 단일 턴에 1회만 발동된다."
  },
  State_2617_Desc = {
    Text = "다음 턴 시작 시, 추가로 [DescArg1]장의 카드를 드로우한다."
  },
  State_2617_Name = {
    Text = "증상: 흥분"
  },
  State_2619_Desc = {
    Text = "이번 전투 내에서 주는 능동 피해가 [Layer]pt 감소한다."
  },
  State_2619_Name = {Text = "힘 감소"},
  State_2619_WeaponDesc = {
    Text = "이번 전투 내에서 주는 피해가 [Layer]pt 감소한다."
  },
  State_2620_Desc = {
    Text = "유물 녹슨 메스"
  },
  State_2620_Name = {
    Text = "녹슨 메스"
  },
  State_2623_Desc = {
    Text = "턴 시작 시 행동력 1을 획득한다."
  },
  State_2624_Desc = {
    Text = "사용 후 모든 적이 [StateArg1]의 임시 힘을 잃는다."
  },
  State_2624_Name = {
    Text = "<Rune_18:쇠약>"
  },
  State_2625_Desc = {
    Text = "도약 효과가 2회 발동한다. 초차원 턴에 진입할 때, 모든 적이 임시 힘 5를 획득한다."
  },
  State_2625_Name = {
    Text = "유물 악몽 혼등"
  },
  State_2626_Desc = {
    Text = "촉수 상한이 1 감소한다. 턴 종료 시 모든 촉수가 추가로 1회 공격한다."
  },
  State_2627_Name = {
    Text = "[StateArg1] 열쇠 에너지 획득"
  },
  State_2627_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 선택한 카드가 열쇠 에너지를 획득한다."
  },
  State_2628_Desc = {
    Text = "「미완성된 밀랍상」에서 복제한 카드가 각인 효과를 획득한다."
  },
  State_2628_Name = {
    Text = "상태@장2_공명3"
  },
  State_2628_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 복제한 카드가 각인 효과를 획득한다."
  },
  State_2629_Desc = {
    Text = "「미완성된 밀랍상」에서 발견 가능한 복제 카드 범위가 증가한다."
  },
  State_2629_Name = {
    Text = "상태@장2_공명2"
  },
  State_2629_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 복제한 카드와 그 원본이 「고유」 효과를 획득한다."
  },
  State_2630_Desc = {
    Text = "「미완성된 밀랍상」에서 복사한 카드와 그 원본은 「유지」 효과를 획득한다."
  },
  State_2630_Name = {
    Text = "상태@장2_공명4"
  },
  State_2630_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 복제한 카드와 그 원본이 「유지」 효과를 획득한다."
  },
  State_2631_Desc = {
    Text = "「미완성된 밀랍상」에서 카드를 1장 더 복제한다."
  },
  State_2631_Name = {
    Text = "상태@장2_공명6"
  },
  State_2631_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 카드를 1장 더 복제한다."
  },
  State_2633_Desc = {
    Text = "능동 피해를 1회 받을 때마다 【녹염】 1장을 손에 넣고 「소모」를 부여하며, [Layer] 턴 동안 지속됩니다."
  },
  State_2633_Name = {
    Text = "유혹의 불꽃"
  },
  State_2633_WeaponDesc = {
    Text = "다음 턴 전까지 공격받을 때마다 「푸른 불꽃」 1장을 손에 넣는다."
  },
  State_2634_Desc = {
    Text = "카드를 사용할 때 [StateArg1]의 피해를 받고 1스택을 제거한다. 스택이 0이 되면 약한 「바다 속의 존재」가 부화한다. 턴 종료 시에도 기생 상태가 남아 있을 경우, 스택에 비례하여 HP가 증가하는 「바다 속의 존재」가 부화한다."
  },
  State_2634_Name = {Text = "기생됨"},
  State_2635_Desc = {
    Text = "상태@프롤로그 공세 연습 표식"
  },
  State_2635_Name = {
    Text = "상태@프롤로그 공세 연습 표식"
  },
  State_2635_WeaponDesc = {
    Text = "상태@프롤로그 공세 연습 표식"
  },
  State_2636_Name = {
    Text = "상태@제4장 공명@다음 턴 드로우 수 1"
  },
  State_2637_Desc = {
    Text = "턴 시작 시 [StateArg1]의 행동력을 획득한다."
  },
  State_2637_Name = {
    Text = "유물 활성 주사기"
  },
  State_2637_WeaponDesc = {
    Text = "턴 시작 시 [StateArg1]의 행동력을 획득한다."
  },
  State_2639_Desc = {
    Text = "전투 중 치명타 피해를 받을 때, 일정 확률로 HP 1을 남기고 생존한다. 발동 후 이번 조사에서 확률이 절반으로 감소하며, 획득하는 죽음 저항도 절반으로 감소한다."
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:죽음 저항>"
  },
  State_2640_Name = {
    Text = "일반 1회 반복 적용"
  },
  State_2645_Desc = {
    Text = "상태@프롤로그 몬스터 패시브1"
  },
  State_2645_Name = {
    Text = "상태@프롤로그 몬스터 패시브1"
  },
  State_2645_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브1"
  },
  State_2646_Desc = {
    Text = "상태@프롤로그 몬스터 패시브2"
  },
  State_2646_Name = {
    Text = "상태@프롤로그 몬스터 패시브2"
  },
  State_2646_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브2"
  },
  State_2647_Desc = {
    Text = "상태@프롤로그 몬스터 패시브3"
  },
  State_2647_Name = {
    Text = "상태@프롤로그 몬스터 패시브3"
  },
  State_2647_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브3"
  },
  State_2648_Desc = {
    Text = "상태@프롤로그 몬스터 패시브4"
  },
  State_2648_Name = {
    Text = "상태@프롤로그 몬스터 패시브4"
  },
  State_2648_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브4"
  },
  State_2649_Desc = {
    Text = "상태@프롤로그 몬스터 패시브5"
  },
  State_2649_Name = {
    Text = "상태@프롤로그 몬스터 패시브5"
  },
  State_2649_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브5"
  },
  State_2650_Desc = {
    Text = "상태@프롤로그 몬스터 패시브6"
  },
  State_2650_Name = {
    Text = "상태@프롤로그 몬스터 패시브6"
  },
  State_2650_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브6"
  },
  State_2651_Desc = {
    Text = "상태@프롤로그 몬스터 패시브7"
  },
  State_2651_Name = {
    Text = "상태@프롤로그 몬스터 패시브7"
  },
  State_2651_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브7"
  },
  State_2652_Desc = {
    Text = "상태@프롤로그 몬스터 패시브8"
  },
  State_2652_Name = {
    Text = "상태@프롤로그 몬스터 패시브8"
  },
  State_2652_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브8"
  },
  State_2653_Desc = {
    Text = "상태@프롤로그 몬스터 패시브9"
  },
  State_2653_Name = {
    Text = "상태@프롤로그 몬스터 패시브9"
  },
  State_2653_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브9"
  },
  State_2655_Desc = {
    Text = "방어되지 않은 피해를 입혔을 때, 피해량만큼 HP를 회복한다. 피해를 입힐 때 제거된다."
  },
  State_2655_Name = {Text = "흡혈"},
  State_2656_Desc = {
    Text = "다음 턴 시작 시 도망간다!!!!!!"
  },
  State_2656_Name = {Text = "도망"},
  State_2660_Desc = {
    Text = "전투 시작 시 힘을 획득하지만, 받는 피해가 5씩 증가한다."
  },
  State_2660_Name = {
    Text = "최후의 외침"
  },
  State_2661_Desc = {
    Text = "전투 시작 시, 모든 적이 [Arg1]의 힘을 잃는다."
  },
  State_2662_Name = {
    Text = "상태@장3_테스트 상태"
  },
  State_2663_Desc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_2663_Name = {
    Text = "상태 저위 쇠약"
  },
  State_2663_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_2666_Name = {
    Text = "윤회비수 치명타율"
  },
  State_2667_Desc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_2667_Name = {
    Text = "타격 카드 피해 증가"
  },
  State_2667_WeaponDesc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_2668_Desc = {
    Text = "공격력이 [Layer]% 증가한다."
  },
  State_2668_Name = {
    Text = "일반 영구 공격력 비율 증가"
  },
  State_2668_WeaponDesc = {
    Text = "공격력이 [Layer]% 증가한다."
  },
  State_2669_Desc = {
    Text = "이번 전투 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_2669_Name = {
    Text = "치명타 피해"
  },
  State_2670_Desc = {
    Text = "허약을 부여하면 [Arg1]pt의 실타래드를 획득하고, 취약을 부여하면 [Arg2]pt의 힘을 획득한다. 1턴 내에 이 두 효과가 모두 발동하면, 추가로 [Arg1]pt의 실타래드와 [Arg2]pt의 힘을 획득한다."
  },
  State_2670_Name = {
    Text = "무거운 액자"
  },
  State_2671_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_2671_Name = {
    Text = "미깨어남"
  },
  State_2672_Desc = {
    Text = "매 턴 시작 시, 아군 팀에 [속박]을 부여한다."
  },
  State_2672_Name = {Text = "속박"},
  State_2672_WeaponDesc = {
    Text = "매 턴 시작 시, 아군 팀에 [속박]을 부여한다."
  },
  State_2674_Desc = {
    Text = "이번 턴 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_2674_Name = {
    Text = "임시 치명타율"
  },
  State_2676_Name = {
    Text = "장식품 핏빛의 심계"
  },
  State_2676_WeaponDesc = {
    Text = "열쇠 지령 발동 후, 장착한 깨어남체가 임시 치명타율 15%를 획득한다. 장착한 깨어남체의 현재 치명타 피해가 80%를 초과할 경우, 임시 치명타율 15%를 추가로 획득한다."
  },
  State_2677_Desc = {
    Text = "매 턴 처음 3회 받는 능동/촉수 피해가 75% 감소한다."
  },
  State_2677_Name = {
    Text = "「불멸의 잔해」"
  },
  State_2677_WeaponDesc = {
    Text = "매 턴 처음 3회 받는 능동/촉수 피해가 75% 감소한다."
  },
  State_2679_Name = {
    Text = "상태@장3_공명7_표식"
  },
  State_2680_Desc = {
    Text = "치명타율이 20% 증가한다. 턴 시작 시 HP가 25% 미만일 경우, 이번 턴에 주는 피해가 반드시 치명타로 적중한다."
  },
  State_2681_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_2681_Name = {
    Text = "미깨어남"
  },
  State_2682_Desc = {
    Text = "실타래드와 치유 강효가 50% 증가한다."
  },
  State_2682_Name = {
    Text = "이화된 정원의 수호자"
  },
  State_2682_WeaponDesc = {
    Text = "실타래드와 치유 강효가 50% 증가한다."
  },
  State_2683_Desc = {
    Text = "상태 스택만큼 카드를 드로우한다."
  },
  State_2683_Name = {Text = "드로우"},
  State_2684_Desc = {
    Text = "팀 유일: 장착자의 「타격」은 <WeaponEffect_Num:[StateArg1]%>의 확률로 1의 계산력을 얻고 모든 적에게 10%의<IntoxicationIconKeywords:중독>을 발생시킵니다. 현재 계역이 「심해」일 경우, 이 효과가 발동할 때 1개의 촉수가 1회 공격합니다. 이 효과는 단일 턴에 한 번만 적용됩니다."
  },
  State_2684_WeaponDesc = {
    Text = "장착자의 「타격」은 <WeaponEffect_Num:[StateArg1]%>의 확률로 1의 계산력을 얻고 모든 적에게 [DescArg1]%의<IntoxicationIconKeywords:중독>을 발생시킵니다. 현재 계역이 「심해」일 경우, 이 효과가 발동할 때 1개의 촉수가 1회 공격합니다. 이 효과는 매 턴 최대 1회 발동할 수 있습니다."
  },
  State_2685_Desc = {
    Text = "허약, 취약 및 취약 상태에 면역이며, 턴 종료 시 1스택이 제거된다."
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords:축복>"
  },
  State_2685_WeaponDesc = {
    Text = "이번 턴 내에서 아군에게 부여되는 부정 상태에 면역이다."
  },
  State_2686_Desc = {
    Text = "전투 중에 부여되는 임시 카드이다."
  },
  State_2686_Name = {
    Text = "<CardKeyWord:상태 카드>"
  },
  State_2687_Desc = {
    Text = "이번 턴 내에서 치명타율이 100% 증가한다."
  },
  State_2687_Name = {
    Text = "임시 필사 치명타"
  },
  State_2687_WeaponDesc = {
    Text = "이번 턴 내에서 치명타율이 100% 증가한다."
  },
  State_2688_Desc = {
    Text = "매 턴 3번째 카드를 사용한 후, 「영감」 1장을 버린 카드 더미에 넣는다. 매 턴 6번째 카드를 사용한 후, 버린 카드 더미에서 「영감」 1장을 손으로 되돌린다."
  },
  State_2689_Desc = {
    Text = "턴 시작 시 카드 2장을 드로우한다. 초차원 카드 슬롯 용량이 2 증가한다."
  },
  State_2689_Name = {
    Text = "유물 속임수 모자"
  },
  State_2689_WeaponDesc = {
    Text = "턴 시작 시 카드 2장을 드로우한다. 초차원 카드 슬롯 용량이 2 증가한다."
  },
  State_2690_Desc = {
    Text = "미덕 기사가 카드를 사용할 때, [StateArg1]의 힘을 획득한다."
  },
  State_2690_Name = {
    Text = "기사의 열정"
  },
  State_2691_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 광기 폭발을 발동한 후, <WeaponEffect_Num:[StateArg1]>의 광기와 <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다. 손패 4장당 1회 반복된다. 현재 계역이 「초차원」일 경우, 장착한 깨어남체의 카드가 초차원 공간에 들어간 후, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg3]%>만큼의 임시 힘을 획득하며, 매 턴 최대 2회 발동된다."
  },
  State_2691_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 발동한 후, <WeaponEffect_Num:[StateArg1]>의 광기와 <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다. 손패 4장당 1회 반복된다. 현재 계역이 「초차원」일 경우, 장착한 깨어남체의 카드가 초차원 공간에 들어간 후, <WeaponEffect_Num:[Power:DescArg1]>의 임시 힘을 획득하며, 매 턴 최대 2회 발동된다."
  },
  State_2693_Desc = {
    Text = "상태@프롤로그 광기 0_1_2 효과"
  },
  State_2693_Name = {
    Text = "상태@프롤로그 광기 0_1_2 효과"
  },
  State_2693_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_2 효과"
  },
  State_2694_Desc = {
    Text = "검은 인장 1을 소모할 때마다 모든 깨어남체가 광기 1을 획득한다."
  },
  State_2694_Name = {
    Text = "상태@유물 역생화"
  },
  State_2694_WeaponDesc = {
    Text = "검은 인장 1을 소모할 때마다 모든 깨어남체가 광기 1을 획득한다."
  },
  State_2695_Desc = {
    Text = "깨어남체의 카드가 초차원 공간에 들어갈 때마다, 해당 깨어남체가 광기 15를 획득한다."
  },
  State_2696_Desc = {
    Text = "상태@프롤로그 광기 0_1_2 발동"
  },
  State_2696_Name = {
    Text = "상태@프롤로그 광기 0_1_2 발동"
  },
  State_2696_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_2 발동"
  },
  State_2698_Name = {
    Text = "다음 턴 시작 시 행동력 +1"
  },
  State_2699_Name = {
    Text = "다음 턴 시작 시 행동력 +2"
  },
  State_2701_Desc = {
    Text = "심해 숙녀가 실타래드를 획득할 때, 임시 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2701_Name = {Text = "피조물"},
  State_2701_WeaponDesc = {
    Text = "심해 숙녀가 실타래드를 획득할 때, 임시 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2702_Desc = {
    Text = "획득 시 죽음 저항 100%를 획득한다. 죽음 저항이 발동된 후, 이번 전투에서 매 턴 시작 시 [Arg1]의 HP를 회복한다."
  },
  State_2702_Name = {
    Text = "인공호흡"
  },
  State_2703_Desc = {
    Text = "매 턴 처음으로 사용한 깨어남체 카드의 임시 복사본이 차원 균열로 들어간다. 이 복사본은 위험한 순간에 자신을 보호하는 데 사용할 수 있다!"
  },
  State_2703_Name = {
    Text = "차원 균열"
  },
  State_2705_Name = {
    Text = "복수 선언"
  },
  State_2706_Desc = {
    Text = "점점 석화됨 검사"
  },
  State_2706_Name = {
    Text = "점점 석화됨 판정"
  },
  State_2706_WeaponDesc = {
    Text = "점점 석화됨 검사"
  },
  State_2707_Desc = {
    Text = "이번 턴 내에 촉수가 전체 적을 공격한다."
  },
  State_2707_Name = {
    Text = "전체 촉수 공격"
  },
  State_2707_WeaponDesc = {
    Text = "이번 턴 내에 촉수가 전체 적을 공격한다."
  },
  State_2708_Desc = {
    Text = "촉수 상한이 1 증가한다. HP가 50% 미만일 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2708_Name = {
    Text = "이화된 과거의 공물"
  },
  State_2708_WeaponDesc = {
    Text = "촉수 상한이 1 증가한다. HP가 50% 미만일 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2709_Desc = {
    Text = "유물 녹슨 메스 카운트"
  },
  State_2710_Desc = {Text = "인장"},
  State_2710_Name = {Text = "마크"},
  State_2710_WeaponDesc = {Text = "인장"},
  State_2711_Desc = {
    Text = "임시로 카드의 행동력 변경"
  },
  State_2711_Name = {
    Text = "임시 카드 행동력 변경"
  },
  State_2711_WeaponDesc = {
    Text = "임시로 카드의 행동력 변경"
  },
  State_2712_Desc = {
    Text = "생성하는 실타래드가 증가한다."
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:경계>"
  },
  State_2712_WeaponDesc = {
    Text = "획득하는 실타래드가 증가한다."
  },
  State_2713_Desc = {
    Text = "복수의 거대한 칼날은 매 턴마다 힘을 획득한다."
  },
  State_2713_Name = {
    Text = "복수의 거대한 검 깨어남"
  },
  State_2713_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_2715_Desc = {
    Text = "이번 스테이지 내에서 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_2715_Name = {
    Text = "영구 경계"
  },
  State_2715_WeaponDesc = {
    Text = "이번 스테이지 내에서 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_2718_Desc = {
    Text = "팀 유일: 턴 종료 시 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득하며, 장착한 깨어남체의 은열쇠 충전량과 동일한 은열쇠 에너지를 획득한다."
  },
  State_2718_WeaponDesc = {
    Text = "턴 종료 시 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득하며, 장착한 깨어남체의 은열쇠 충전량과 동일한 은열쇠 에너지를 획득한다."
  },
  State_2720_Desc = {
    Text = "실타래제 피해를 입힐 때, 광기가 가장 높은 깨어남체의 광기를 10 감소시킨다."
  },
  State_2720_Name = {Text = "공허"},
  State_2720_WeaponDesc = {
    Text = "실타래제 피해를 입힐 때, 광기가 가장 높은 깨어남체의 광기를 10 감소시킨다."
  },
  State_2721_Name = {
    Text = "상태@스테이지 2-9 전투 5 말풍선 1"
  },
  State_2722_Desc = {
    Text = "사용 후 「영감」 [StateArg1]장을 덱에 섞어 넣는다. 「영감」: 행동력 1을 획득하고, 카드 1장을 드로우하며, 유지, 소모됨."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:고급 영감>"
  },
  State_2723_Desc = {
    Text = "사용 후 전체 적에게 [StateArg1]턴간 취약을 부여한다."
  },
  State_2723_Name = {
    Text = "<Rune_1_High:고급 취약>"
  },
  State_2724_Desc = {
    Text = "공격 횟수가 1 증가한다."
  },
  State_2724_Name = {
    Text = "환몽의 핵 반격"
  },
  State_2726_Desc = {
    Text = "사용 후 모든 적에게 [StateArg1]스택의 중독을 부여하고, 모든 적의 중독을 [StateArg2]% 발동시킨다."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:고급 독소>"
  },
  State_2727_Desc = {
    Text = "사망 직전에 HP 1을 회복하고 해당 상태를 제거한다."
  },
  State_2727_Name = {Text = "근성"},
  State_2727_WeaponDesc = {
    Text = "사망 직전에 HP 1을 회복하고 해당 상태를 제거한다."
  },
  State_2728_Desc = {
    Text = "턴 시작 시 다른 아군 1명당 <PVPProtectiveKeywords:장벽> 1스택을 획득한다."
  },
  State_2728_Name = {
    Text = "링크 장벽"
  },
  State_2728_WeaponDesc = {
    Text = "턴 시작 시 다른 아군 1명당 최대 HP의 [Layer]%만큼 실타래드를 획득한다."
  },
  State_2729_Desc = {
    Text = "발동 시 해당 깨어남체의 카드 1장을 드로우한다."
  },
  State_2729_Name = {
    Text = "이화된 공간 왜곡기 드로우"
  },
  State_2729_WeaponDesc = {
    Text = "발동 시 해당 깨어남체의 카드 1장을 드로우한다."
  },
  State_2730_Desc = {
    Text = "자신이 사망하면, 히드라의 「만사조시」 상태가 1스택 감소한다."
  },
  State_2730_Name = {Text = "권속"},
  State_2732_Desc = {
    Text = "상태@프롤로그 광기 초기화 0_2_3"
  },
  State_2732_Name = {
    Text = "상태@프롤로그 광기 초기화 0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "상태@프롤로그 광기 초기화 0_2_3"
  },
  State_2734_Name = {
    Text = "다음 턴 시작 시 드로우 수 +1"
  },
  State_2735_Desc = {
    Text = "이 카드를 사용한 후 「차원 이동」이 발동되거나 현재 초차원 턴일 경우, 후속 효과를 발동한다."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:도약>"
  },
  State_2735_WeaponDesc = {
    Text = "현재 초차원 턴일 경우, 도약 효과를 발동할 수 있다."
  },
  State_2737_Desc = {
    Text = "아군 팀의 덱이 초기화될 때, [Layer]의 힘을 획득한다."
  },
  State_2737_Name = {
    Text = "영원한 응결"
  },
  State_2738_Name = {
    Text = "허약 효과 증가"
  },
  State_2740_Desc = {
    Text = "「미완성된 밀랍상」에서 복제한 카드 및 그 원본의 행동력 소모가 1 감소하며, 증상 카드 1장을 획득한다."
  },
  State_2740_Name = {
    Text = "상태@장2_공명5_2"
  },
  State_2740_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 복제한 카드와 그 원본의 행동력 소모가 1 감소한다."
  },
  State_2741_Desc = {
    Text = "「미완성된 밀랍상」에서 복제한 카드 및 그 원본의 행동력 소모가 1 감소하며, 증상 카드 1장을 획득한다."
  },
  State_2741_Name = {
    Text = "상태@장2_공명5_1"
  },
  State_2741_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 복제한 카드와 그 원본의 행동력 소모가 1 감소한다."
  },
  State_2742_Desc = {
    Text = "딱딱 소리내는 자가 피해를 1회 줄 때마다 [StateArg2]의 임시 힘을 획득하며, 실타래드를 1회 획득할 때마다 [StateArg3]의 임시 경계를 획득한다."
  },
  State_2742_Name = {
    Text = "매개변수 조정"
  },
  State_2744_Desc = {
    Text = "깨어남체의 카드가 초차원 공간에 들어갈 때마다, 해당 카드의 소속 깨어남체가 광기 15를 획득한다."
  },
  State_2744_Name = {
    Text = "유물 도약 장치"
  },
  State_2744_WeaponDesc = {
    Text = "깨어남체의 카드가 초차원 공간에 들어갈 때마다, 해당 카드의 소속 깨어남체가 광기 15를 획득한다."
  },
  State_2746_Desc = {
    Text = "공격 횟수가 1 증가하고, [Layer]의 힘을 잃는다."
  },
  State_2746_Name = {Text = "초조"},
  State_2747_Desc = {
    Text = "사용 후 다른 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_2747_Name = {
    Text = "<Rune_16:촉매>"
  },
  State_2748_Desc = {
    Text = "상태@등불 의식"
  },
  State_2748_Name = {
    Text = "상태@등불 의식"
  },
  State_2748_WeaponDesc = {
    Text = "상태@등불 의식"
  },
  State_2749_Desc = {
    Text = "이번 턴에 촉수 피해를 입힌 후, 대상에게 [Layer]스택의 중독을 부여한다."
  },
  State_2749_Name = {
    Text = "깊은 암류"
  },
  State_2750_Desc = {
    Text = "나와 함께 바다로 가라·········"
  },
  State_2750_Name = {
    Text = "님피아 깨어남"
  },
  State_2752_Desc = {
    Text = "수련이 피해를 줄 때, [StateArg2]의 광기를 획득한다."
  },
  State_2752_Name = {
    Text = "잊혀진 고난의 바다"
  },
  State_2752_WeaponDesc = {
    Text = "수련이 피해를 줄 때, [StateArg2]의 광기를 획득한다."
  },
  State_2753_Desc = {
    Text = "턴 시작 시 HP가 [Arg1]보다 크면 [Arg1]의 HP를 잃고, 해당 턴 내내 [Arg2]의 힘과 [Arg3]의 경계를 획득한다."
  },
  State_2754_Name = {
    Text = "상태@임시 타격 카드 치명타율 증가"
  },
  State_2757_Desc = {
    Text = "다음 턴 시작 시, 추가로 [DescArg1]의 행동력을 획득한다."
  },
  State_2757_Name = {
    Text = "증상: 의심"
  },
  State_2758_Desc = {
    Text = "모든 HP 회복 효과가 [Arg1] 증가하며, 초과 회복된 HP는 동일한 양의 실타래드로 전환된다."
  },
  State_2758_Name = {
    Text = "나비 표본"
  },
  State_2760_Desc = {
    Text = "깨어남체 1명이 포식을 1회 수행할 때마다, 다른 깨어남체들이 광기 10을 획득한다."
  },
  State_2762_Desc = {
    Text = "사용 후 추가로 [StateArg1]회 발동하며, [StateArg2]의 검은 인장을 획득한다. 소모됨. 고유."
  },
  State_2762_Name = {
    Text = "<Rune_7_High:고급 메아리>"
  },
  State_2762_WeaponDesc = {
    Text = "사용 후 추가로 [StateArg1]회 발동하며, 소모된다."
  },
  State_2763_Desc = {
    Text = "침묵의 군주가 행동력 1을 소모할 때마다, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2763_Name = {
    Text = "불멸의 위엄"
  },
  State_2763_WeaponDesc = {
    Text = "침묵의 군주가 행동력 1을 소모할 때마다, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2764_Desc = {
    Text = "방어되지 않은 피해를 입혔을 때, [StateArg1]스택의 출혈을 부여한다."
  },
  State_2764_Name = {
    Text = "악의적 방혈"
  },
  State_2765_Name = {
    Text = "상태@조지@사망 시 치유"
  },
  State_2767_Name = {
    Text = "상태@검은 인장 및 은열쇠 충전 효율"
  },
  State_2769_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_2769_Name = {
    Text = "미깨어남"
  },
  State_2771_Desc = {
    Text = "몬스터 힘"
  },
  State_2771_Name = {
    Text = "몬스터 힘"
  },
  State_2772_Name = {
    Text = "상태@스테이지 2-5 전투 3 말풍선 1"
  },
  State_2773_Desc = {
    Text = "전투 시작 시, 「아름다운 순간 - 턴 종료까지 손에 있는 모든 깨어남체의 카드를 「타격」으로 교체한다. 유지, 소모됨.」 1장을 손에 넣는다."
  },
  State_2775_Desc = {
    Text = "드로우 수 복귀"
  },
  State_2775_Name = {
    Text = "드로우 수 복귀"
  },
  State_2776_Name = {
    Text = "석화의 눈 정체 저주 강화"
  },
  State_2777_Name = {
    Text = "상태@장3_빈 상태"
  },
  State_2778_Desc = {
    Text = "전투 시작 시 [Arg1]의 실타래드를 획득한다. 이번 전투에서 「방어」를 7회 사용하면 즉시 [Arg2]의 실타래드를 획득한다."
  },
  State_2778_Name = {
    Text = "퍼트니 조간신문"
  },
  State_2779_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「간섭형 융식체」 3개로 분열된다."
  },
  State_2779_Name = {Text = "분열"},
  State_2779_WeaponDesc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체」 2개로 분열된다."
  },
  State_2780_Desc = {
    Text = "사용 후 [StateArg1]의 행동력을 획득한다."
  },
  State_2780_Name = {
    Text = "<Rune_4:계산>"
  },
  State_2781_Desc = {
    Text = "매 [Layer]장의 카드를 사용할 때, 자신에게 장벽이 없으면 <ParcloseIconKeywords:장벽> 1스택을 추가한다."
  },
  State_2781_Name = {
    Text = "차지 장벽"
  },
  State_2781_WeaponDesc = {
    Text = "아군 팀이 [Layer]장의 카드를 사용할 때마다, 몬스터가 장벽 1스택을 새로 획득한다."
  },
  State_2784_Desc = {
    Text = "초차원 턴이 아니더라도 매 턴마다 한 번의 도약 효과를 발동할 수 있다. 초차원 공간 용량이 2 증가한다."
  },
  State_2785_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 카드를 사용하면, 장착한 깨어남체가 광기 1을 획득한다. 전투 시작 시, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 <PowerIconKeywords:힘>을 획득한다. 현재 계역이 「심해」일 경우, 추가로 <WeaponEffect_Num:[StateArg2]%>만큼의 <CardKeyWord:촉수 피해>를 획득한다. 이후 매 턴 시작 시, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg3]%>만큼의 <PowerIconKeywords:힘>을 획득한다. 현재 계역이 「심해」일 경우, 추가로 <WeaponEffect_Num:[StateArg4]%>만큼의 <CardKeyWord:촉수 피해>를 획득한다."
  },
  State_2785_WeaponDesc = {
    Text = "장착한 깨어남체가 카드를 사용한 후, 장착한 깨어남체가 광기 1을 획득한다. 전투 시작 시, <WeaponEffect_Num:[Power:DescArg1]>의 <PowerIconKeywords:힘>을 획득한다. 현재 계역이 「심해」일 경우, 추가로 <WeaponEffect_Num:[DescArg2]>의 <CardKeyWord:촉수 피해>를 획득한다. 이후 매 턴 시작 시, <WeaponEffect_Num:[Power:DescArg3]>의 <PowerIconKeywords:힘>을 획득한다. 현재 계역이 「심해」일 경우, 추가로 <WeaponEffect_Num:[DescArg4]>의 <CardKeyWord:촉수 피해>를 획득한다."
  },
  State_2786_Name = {
    Text = "상태@유물 피 묻은 자갈 카운터"
  },
  State_2787_Desc = {
    Text = "HP를 회복하고, 「허무 종결」 1장을 버린 카드 더미에 섞어 넣는다. 영속, 폐기."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:진리 추구>"
  },
  State_2787_WeaponDesc = {
    Text = "HP를 회복하고, 「허무 종결」 1장을 버린 카드 더미에 섞어 넣는다. 영속, 폐기."
  },
  State_2788_Desc = {
    Text = "턴 시작 시 [StateArg1]장의 카드를 드로우한다."
  },
  State_2788_Name = {
    Text = "유물 선지자의 소원 램프 1"
  },
  State_2788_WeaponDesc = {
    Text = "턴 시작 시 [StateArg1]장의 카드를 드로우한다."
  },
  State_2789_Desc = {
    Text = "카드가 젠킨에게 조작당했습니다! 사용 후 [Layer] 포인트의 <FixedDamage:순수 피해>를 받습니다."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:사용 후 [Layer]pt 피해를 입음>"
  },
  State_2789_WeaponDesc = {
    Text = "카드를 사용한 후 [StateArg1]pt의 피해를 받는다."
  },
  State_2790_Desc = {
    Text = "턴 종료 시 [StateArg1]장의 손패를 유지할 수 있다."
  },
  State_2790_Name = {
    Text = "유물 선지자의 소원 램프 2"
  },
  State_2790_WeaponDesc = {
    Text = "턴 종료 시 [StateArg1]장의 손패를 유지할 수 있다."
  },
  State_2792_Desc = {
    Text = "전투 시작 시, 모든 아군이 [왁스 갑옷] 3스택을 획득한다. 턴 시작 시, [경련] 1장을 아군 팀의 덱에 섞어 넣는다."
  },
  State_2792_Name = {
    Text = "「밀랍의 숙녀」"
  },
  State_2792_WeaponDesc = {
    Text = "전투 시작 시, 모든 아군이 [왁스 갑옷] 3스택을 획득한다. 턴 시작 시, [경련] 1장을 아군 팀의 덱에 섞어 넣는다."
  },
  State_2793_Desc = {
    Text = "상태@석화의 눈 죽음의 투쟁"
  },
  State_2793_Name = {
    Text = "상태@석화의 눈 죽음의 투쟁"
  },
  State_2793_WeaponDesc = {
    Text = "상태@석화의 눈 죽음의 투쟁"
  },
  State_2796_Desc = {
    Text = "HP를 잃을 때마다 모든 적에게 [Arg1]스택의 중독을 추가한다. 매 턴 중독 수치가 [Arg2] 증가한다."
  },
  State_2797_Desc = {
    Text = "턴 시작 시, 이번 턴에 [Arg1]의 경계를 획득하는 「양산」 1장을 손에 넣는다. 카드 6장을 사용한 후, 손에 있는 모든 「양산」의 경계를 [Arg2] 증가시킨다."
  },
  State_2798_Desc = {
    Text = "인애 주제가 실타래드를 부여할 때, 무작위 손패 1장의 행동력 소모가 사용 전까지 1 감소한다."
  },
  State_2798_Name = {
    Text = "아버지의 자비"
  },
  State_2798_WeaponDesc = {
    Text = "인애 주제가 실타래드를 부여할 때, 무작위 손패 1장의 행동력 소모가 사용 전까지 1 감소한다."
  },
  State_2799_Desc = {
    Text = "달해파리가 능동 피해를 가할 때, [StateArg1]개의 촉수가 해당 대상을 공격합니다."
  },
  State_2799_Name = {
    Text = "자기 증식"
  },
  State_2799_WeaponDesc = {
    Text = "해월이 피해를 줄 때, [StateArg1]개의 촉수가 해당 대상을 공격한다."
  },
  State_2800_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_2800_Name = {
    Text = "상태@테스트 단검 치명타 피해"
  },
  State_2801_Desc = {
    Text = "실타래제 피해를 받으면 깊은 융식 스택이 증가한다."
  },
  State_2801_Name = {
    Text = "피해를 받을 시 깊은 융식 스택 증가"
  },
  State_2801_WeaponDesc = {
    Text = "실타래제 피해를 받으면 깊은 융식 스택이 증가한다."
  },
  State_2802_Desc = {
    Text = "턴 시작 시 임시 힘이 증가한다."
  },
  State_2802_Name = {
    Text = "임시 힘 증가"
  },
  State_2804_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_2804_Name = {
    Text = "상태@테스트 레이저포 치명타 피해"
  },
  State_2805_Desc = {
    Text = "턴 종료 시, 다른 아군이 힘을 획득한다."
  },
  State_2805_Name = {
    Text = "「계명의 불꽃」"
  },
  State_2807_Desc = {
    Text = "턴 시작 시, 이번 턴에 [Arg1]의 경계를 획득하는 「양산」 1장을 손에 넣는다. 카드 6장을 사용한 후, 손에 있는 모든 「양산」의 경계를 [Arg2] 증가시킨다."
  },
  State_2808_Desc = {
    Text = "턴 종료 시 배아 융합도 1을 생성하고, 손에 배아가 있을 경우 HP 15를 회복한다."
  },
  State_2808_Name = {
    Text = "이화된 지혈겸"
  },
  State_2808_WeaponDesc = {
    Text = "턴 종료 시 배아 융합도 1을 생성하고, 손에 배아가 있을 경우 HP 15를 회복한다."
  },
  State_2809_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 힘을 잃는다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 매 턴 최대 6회 발동한다."
  },
  State_2809_Name = {
    Text = "칠성장어의 입맞춤"
  },
  State_2810_Desc = {
    Text = "턴 종료 시, 최대 HP의 [Layer]%를 회복한다."
  },
  State_2810_Name = {
    Text = "자기 치유"
  },
  State_2810_WeaponDesc = {
    Text = "몬스터 턴 종료 시, 최대 HP의 [Layer]%를 회복한다."
  },
  State_2811_Desc = {
    Text = "증상 카드를 드로우할 때 [Arg1]의 힘을 얻는다. 저주 각인 또는 저주 유물을 1개 보유할 때마다 치명타율과 치명타 피해가 10% 증가한다."
  },
  State_2812_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_2812_Name = {
    Text = "미깨어남"
  },
  State_2813_Desc = {
    Text = "턴 시작 시 행동력을 잃는다."
  },
  State_2813_Name = {
    Text = "계산이 빗나갔다!"
  },
  State_2814_Desc = {
    Text = "전투 승리 시 획득하는 각인이 강력하고 위험한 저주 각인으로 변경된다."
  },
  State_2817_Desc = {
    Text = "스택당 받는 피해가 [StateArg1] 감소하며, 치명타를 받을 때마다 1스택이 감소한다."
  },
  State_2817_Name = {
    Text = "왁스 갑옷"
  },
  State_2817_WeaponDesc = {
    Text = "이상 상태에 면역이며, 치명타를 받으면 제거된다."
  },
  State_2818_Desc = {
    Text = "분열되어 융식 삼각형 소형과 융식 삼각형 소형 B로 나뉜다."
  },
  State_2818_Name = {Text = "분열"},
  State_2818_WeaponDesc = {
    Text = "분열되어 융식 삼각형 소형과 융식 삼각형 소형 B로 나뉜다."
  },
  State_2820_Desc = {
    Text = "사용 후 [StateArg1]의 임시 힘을 획득하며, 해당 각인 카드도 힘 보너스를 받는다."
  },
  State_2820_Name = {
    Text = "<Rune_15:폭발>"
  },
  State_2821_Name = {
    Text = "임시 취약 면역"
  },
  State_2823_Desc = {
    Text = "팀 유니크: 전투 시작 시 전열 적에게 2중첩 <VulnerabilityIconKeywords:약점> 부여. 턴 시작 시, 약점 상태의 적이 장착자 공격력의 <WeaponEffect_Num:[StateArg1]%> 에 해당하는 임시 <PowerIconKeywords:힘>을 잃음. 현재 영역이 「혈육」이면, 장착자가 「광기 폭발」 발동 후 배아 융합 +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "전투 시작 시, 전열 적에게 2중첩 <VulnerabilityIconKeywords:약점> 부여. 턴 시작 시, 약점 상태의 적이 <WeaponEffect_Num:[Power:DescArg1]> 점 임시 <PowerIconKeywords:힘>을 잃음. 현재 영역이 「혈육」이면, 장착자가 「광기 폭발」 발동 후 배아 융합 +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "몬스터 초차원 카드 슬롯 상한"
  },
  State_2825_Name = {
    Text = "몬스터 초차원 카드 슬롯 상한"
  },
  State_2825_WeaponDesc = {
    Text = "몬스터 초차원 카드 슬롯 상한"
  },
  State_2826_Desc = {
    Text = "연속 2회, 이전 카드보다 행동력 소모가 낮은 카드를 사용할 때, 현재 광기가 가장 낮은 깨어남체가 광기 50을 획득한다."
  },
  State_2826_Name = {
    Text = "유물 아르카나 유물"
  },
  State_2827_Desc = {
    Text = "피해 횟수와 피해량이 증가한다."
  },
  State_2827_Name = {
    Text = "<CardKeyWord:업그레이드>"
  },
  State_2829_Desc = {
    Text = "실타래제 피해를 입힐 때, [Layer]의 힘을 획득한다."
  },
  State_2829_Name = {
    Text = "「혼란한 인격」"
  },
  State_2830_Desc = {
    Text = "팀에 있는 【심해】 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_2830_Name = {
    Text = "심해 보너스"
  },
  State_2830_WeaponDesc = {
    Text = "팀에 있는 【심해】 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_2832_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_2832_Name = {
    Text = "상태@테스트 레이저포 죽음 저항"
  },
  State_2833_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다. 카드를 드로우할 때마다 해당 카드의 행동력 소모가 무작위로 변경된다 (0-4)."
  },
  State_2835_Desc = {
    Text = "포식을 1회 수행할 때마다, 모든 적의 임시 힘을 [Arg1] 탈취한다."
  },
  State_2836_Name = {
    Text = "상태@저주 맹종"
  },
  State_2837_Name = {
    Text = "상태@저주 맹종"
  },
  State_2838_Name = {
    Text = "상태@저주 맹종"
  },
  State_2840_Desc = {
    Text = "턴 종료 후, [Layer] 포인트의 <FixedDamage:순수 피해>를 받고 [DescArg1]% 스택을 제거합니다. HP 회복 시 회복량의 2배에 해당하는 출혈 스택을 제거합니다."
  },
  State_2840_Name = {
    Text = "<BleedingColour: 출혈>"
  },
  State_2840_WeaponDesc = {
    Text = "턴 종료 후, [Layer]pt의 피해를 받고 해당 상태가 제거된다. 치유될 때마다 스택 수가 절반으로 감소한다."
  },
  State_2842_Desc = {
    Text = "사용 후 [StateArg1] 층의 반격을 획득하고, 모든 적에게 반격의 [StateArg2]% <FixedDamage:순수 피해>를 가함."
  },
  State_2842_Name = {
    Text = "<Rune_9:가시>"
  },
  State_2843_Desc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다 [StateArg1]스택의 실타래드를 획득한다. 1턴 동안 지속된다."
  },
  State_2843_Name = {
    Text = "비상하는 깃털"
  },
  State_2843_WeaponDesc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다 [StateArg1]스택의 실타래드를 획득한다. 1턴 동안 지속된다."
  },
  State_2844_Desc = {
    Text = "매 전투에서 처음으로 HP를 잃을 때, 피해를 1회 면역하는 장벽을 획득한다."
  },
  State_2845_Name = {
    Text = "장식품 매장지의 속삭임"
  },
  State_2845_WeaponDesc = {
    Text = "스테이지 시작 시 죽음 저항이 25% 증가한다. 죽음 저항이 발동된 후, 장착한 깨어남체가 광기 50을 획득한다."
  },
  State_2846_Desc = {
    Text = "사망을 1회 면역하며, 발동 후 [Arg1]의 HP를 회복하고 해당 유물을 영구적으로 무효화한다."
  },
  State_2846_Name = {
    Text = "대역 인형"
  },
  State_2847_Desc = {
    Text = "사냥당한 깨어남체가 카드를 1장 사용할 때마다, 사냥의 표식 1스택을 획득하며, 사냥의 표식 스택의 절반에 해당하는 카드를 드로우한다."
  },
  State_2847_Name = {
    Text = "사냥 의식"
  },
  State_2849_Desc = {
    Text = "HP를 잃을 때마다 [Arg1]의 힘을 획득한다. 최대 10회 중첩된다. 최대 중첩 시, 잃은 HP의 25%를 회복한다."
  },
  State_2849_Name = {
    Text = "최고의 영광"
  },
  State_2853_Desc = {
    Text = "유물 영구 안락 의자 카운트"
  },
  State_2854_Desc = {
    Text = "사망 후 깨어남체에게 광기를 제공하지 않는다."
  },
  State_2854_Name = {Text = "이기적"},
  State_2854_WeaponDesc = {
    Text = "사망 후 깨어남체에게 광기를 제공하지 않는다."
  },
  State_2855_Desc = {
    Text = "타격 카드의 피해가 [StateArg1]% 증가하며, [Layer]턴 동안 지속된다."
  },
  State_2855_Name = {
    Text = "궁지 생존·타격"
  },
  State_2855_WeaponDesc = {
    Text = "이번 턴에 타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_2856_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드를 줄 때 아군 전체가 <WeaponEffect_Num:[StateArg3]%>의 임시 치명타율과 장착한 깨어남체의 은열쇠 충전량의 <WeaponEffect_Num:[StateArg4]%>만큼 은열쇠 에너지를 획득한다. 매 턴 최대 2회 발동된다. 현재 계역이 「심해」일 경우, 촉수 1개가 공격할 때마다 장착한 깨어남체가 광기 1을 획득하며, 매 턴 최대 <WeaponEffect_Num:[StateArg2]>까지 획득할 수 있다."
  },
  State_2856_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드를 줄 때 아군 전체가 <WeaponEffect_Num:[StateArg3]%>의 임시 치명타율과 장착한 깨어남체의 은열쇠 충전량의 <WeaponEffect_Num:[StateArg4]%>만큼 은열쇠 에너지를 획득한다. 매 턴 최대 2회 발동된다. 현재 계역이 「심해」일 경우, 촉수 1개가 공격할 때마다 장착한 깨어남체가 광기 1을 획득하며, 매 턴 최대 <WeaponEffect_Num:[StateArg2]>까지 획득할 수 있다."
  },
  State_2857_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 10을 획득한다. 최대 HP가 50% 감소한다."
  },
  State_2858_Name = {
    Text = "사용 시 추가로 장벽 2pt 획득"
  },
  State_2859_Desc = {
    Text = "전투 시작 후 이 카드는 손에 잠금된다."
  },
  State_2859_Name = {
    Text = "<CardKeyWord:고유>"
  },
  State_2860_Desc = {
    Text = "뽑았을 때 자신의 최대 HP가 10% 감소한다. 사용 후 모든 깨어남체의 이번 턴 치명타 피해가 100% 증가한다. 판매 불가."
  },
  State_2860_Name = {
    Text = "상태 저위 융식"
  },
  State_2860_WeaponDesc = {
    Text = "뽑았을 때 자신의 최대 HP가 10% 감소한다. 사용 후 모든 깨어남체의 이번 턴 치명타 피해가 100% 증가한다. 판매 불가."
  },
  State_2861_Name = {
    Text = "(잔여: [Layer])"
  },
  State_2862_Desc = {
    Text = "턴 종료 시 중독 피해를 추가로 받는다."
  },
  State_2862_Name = {
    Text = "체질 쇠약"
  },
  State_2863_Desc = {
    Text = "진화 단계 수"
  },
  State_2863_Name = {
    Text = "진화 단계 수"
  },
  State_2863_WeaponDesc = {
    Text = "진화 단계 수"
  },
  State_2864_Desc = {
    Text = "「24」가 깨어남했다. 마지막 「살려줘」를 사용하여 기회를 찾아라!"
  },
  State_2864_Name = {
    Text = "\"24\" 깨어남!"
  },
  State_2864_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_2866_Desc = {
    Text = "팀 유니크: 최대 손패 매수 +2, 턴 종료 시 장착자의 <WeaponEffect_Num:[StateArg1]%> 은열쇠 충전에 해당하는 은열쇠 에너지를 획득한다. 열쇠 지령을 발동할 때마다 모든 깨어남체가 <WeaponEffect_Num:[StateArg2]> 광기를 획득하며, 현재 계역이 「혈육」일 경우 배아 융합이 <WeaponEffect_Num:+[Blood:StateArg3]> 증가한다."
  },
  State_2866_WeaponDesc = {
    Text = "최대 손패 매수 +2, 턴 종료 시 <WeaponEffect_Num:[DescArg1]> 은열쇠 에너지를 획득합니다. 키오더를 사용할 때마다 모든 깨어남체가 <WeaponEffect_Num:[StateArg2]> 광기를 획득하며, 현재 영역이 「혈육」인 경우 배아 융합 <WeaponEffect_Num:+[Blood:StateArg3]> 도 적용됩니다."
  },
  State_2868_Desc = {
    Text = "턴 종료 시 손에 남은 카드 1장당 모든 깨어남체가 광기 2를 획득한다."
  },
  State_2871_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때 동일한 HP를 가진 융식 삼각형 중 1개를 소환한다."
  },
  State_2871_Name = {Text = "소환"},
  State_2871_WeaponDesc = {
    Text = "HP가 50%([StateArg1]) 미만일 때 동일한 HP를 가진 융식 삼각형 중 1개를 소환한다."
  },
  State_2874_Desc = {
    Text = "깨어남체가 해골 사냥꾼의 주목을 받고 있을 때, 해당 깨어남체의 카드를 사용하면 추가로 카드 2장을 드로우할 수 있다."
  },
  State_2875_Desc = {
    Text = "사용 후 배아 융합 +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:고급 흡혈>"
  },
  State_2875_WeaponDesc = {
    Text = "사용 후 배아 융합+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "전투 종료 후, 추가로 검은 인장 50과 증상 카드 1장을 획득한다."
  },
  State_2877_Desc = {
    Text = "붉은 부인이 피해를 1회 줄 때마다 [StateArg2]의 임시 힘을 획득한다."
  },
  State_2877_Name = {
    Text = "환영 특권"
  },
  State_2878_Desc = {
    Text = "피해 횟수가 1 증가하지만, 피해량이 25% 감소한다."
  },
  State_2878_Name = {Text = "광란"},
  State_2878_WeaponDesc = {
    Text = "피해 횟수가 1 증가하지만, 피해량이 25% 감소한다."
  },
  State_2879_Name = {
    Text = "달콤한 민달팽이"
  },
  State_2879_WeaponDesc = {
    Text = "「소멸」 사용 후, 이번 턴이 정해 자세일 경우, 장착한 깨어남체의 이번 턴 실타래드와 치유 효과가 30% 증가한다."
  },
  State_2880_Name = {
    Text = "상태@바다의 사도 계령 7"
  },
  State_2881_Desc = {
    Text = "「성례」를 「집착」으로 1장 전환할 때마다, 이번 전투에서 미리암이 주는 기본 피해가 15% 증가한다."
  },
  State_2881_Name = {
    Text = "포영환멸"
  },
  State_2883_Desc = {
    Text = "팀 유니크: 장착자가 능동 피해를 입힌 후, <WeaponEffect_Num:[StateArg1]%> 확률로 장착자의 명령 카드 1장을 뽑고 해당 카드의 행동력 소비를 1 감소시킵니다. 이 효과는 단일 턴에 1회만 발동합니다."
  },
  State_2883_WeaponDesc = {
    Text = "장착자가 능동 피해를 입힌 후, <WeaponEffect_Num:[StateArg1]%> 확률로 장착자의 명령 카드 1장을 뽑고 해당 카드의 행동력 소비를 1 감소시킵니다. 이 효과는 단일 턴에 1회만 발동합니다."
  },
  State_2884_Name = {
    Text = "가하는 피해는 <PunctureDamagewords:관통 피해>임. 손에 있는 행동력이 가장 높은 카드 1장의 행동력 소모 1 감소"
  },
  State_2885_Name = {
    Text = "상태@턴 시작 시 드로우 +2"
  },
  State_2887_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 광기 폭발을 발동한 후, 이번 턴의 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 손에 있는 모든 장착한 깨어남체의 카드가 <WeaponEffect_Num:[StateArg2]%> 확률로 이번 턴 내 행동력 소모가 1 감소한다."
  },
  State_2887_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 발동한 후, 이번 턴의 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 손에 있는 모든 장착한 깨어남체의 카드가 <WeaponEffect_Num:[StateArg2]%> 확률로 이번 턴 내 행동력 소모가 1 감소한다."
  },
  State_2888_Desc = {
    Text = "손에 「배아」가 있을 경우, 1장을 소모하고 후속 효과를 발동한다."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:포식>"
  },
  State_2888_WeaponDesc = {
    Text = "손의 배아를 소모하여 강력한 포식 효과를 발동한다."
  },
  State_2889_Name = {
    Text = "깨어남체 한 명을 선택하여 광기 <Energy:[DescArg1]>pt 부여"
  },
  State_2890_Desc = {
    Text = "전투 시작 시, 아군 팀에 손상 1스택을 부여한다."
  },
  State_2890_Name = {
    Text = "방어구 관통"
  },
  State_2890_WeaponDesc = {
    Text = "전투 시작 시, 아군 팀에 손상 1스택을 부여한다."
  },
  State_2891_Name = {
    Text = "광기 시작 회복 증가"
  },
  State_2892_Desc = {
    Text = "턴 종료 시, [Layer]pt의 HP를 회복한다."
  },
  State_2892_Name = {
    Text = "지연 HP 회복"
  },
  State_2892_WeaponDesc = {
    Text = "턴 종료 시까지, 처치할 때마다 [Layer]pt의 HP를 회복한다."
  },
  State_2897_Desc = {
    Text = "본원 강림 발동 시, 적의 임시 힘을 감소시킨다."
  },
  State_2897_Name = {
    Text = "공포의 광기"
  },
  State_2899_Desc = {
    Text = "상대의 손패 수가 4 이상일 때, 피해를 받으면 [StateArg1]의 실타래드를 획득한다."
  },
  State_2899_Name = {Text = "뱀 형태"},
  State_2900_Desc = {
    Text = "이번 전투 내에서 주는 피해가 [Layer]pt 증가한다."
  },
  State_2900_Name = {Text = "힘"},
  State_2900_WeaponDesc = {
    Text = "이번 전투 내에서 주는 피해가 [Layer]pt 증가한다."
  },
  State_2901_Desc = {
    Text = "[광기 폭발]로 자신이 광기 20을 획득한다."
  },
  State_2901_Name = {
    Text = "유물 무명신의 베일"
  },
  State_2901_WeaponDesc = {
    Text = "[광기 폭발]로 자신이 광기 20을 획득한다."
  },
  State_2902_Desc = {
    Text = "통 속의 뇌의 HP 회복량이 2배로 증가한다."
  },
  State_2902_Name = {
    Text = "영혼과 육체의 분리"
  },
  State_2902_WeaponDesc = {
    Text = "통 속의 뇌의 HP 회복량이 2배로 증가한다."
  },
  State_2903_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_2903_Name = {
    Text = "상태@테스트 단검 치명타"
  },
  State_2904_Desc = {
    Text = "실타래제 피해를 받을 때마다 실타래드 10을 획득한다."
  },
  State_2904_Name = {Text = "버퍼링"},
  State_2904_WeaponDesc = {
    Text = "실타래제 피해를 받을 때마다 실타래드 10을 획득한다."
  },
  State_2905_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 「광기 폭발」이 생성하는 실타래드가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체가 「광기 폭발」을 사용한 후, 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg1]%>만큼의 임시 <PowerIconKeywords:힘>을 획득한다. 아군 팀이 <FragileIconKeywords:손상> 상태일 경우, 효과가 2배로 증가한다."
  },
  State_2905_WeaponDesc = {
    Text = "장착한 깨어남체의 「광기 폭발」이 생성하는 실타래드가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체가 「광기 폭발」을 사용한 후, [Power:DescArg1]pt의 임시 <PowerIconKeywords:힘>을 획득한다. 아군 팀이 <FragileIconKeywords:손상> 상태일 경우, 효과가 2배로 증가한다."
  },
  State_2906_Desc = {
    Text = "실타래제 피해를 입힌 후, 아군 팀의 힘을 임시로 [Layer]pt 감소시킨다."
  },
  State_2906_Name = {
    Text = "마비 전격"
  },
  State_2909_Desc = {
    Text = "[Layer]의 광기를 보유한다. 광기가 5 이상일 경우, 의도가 「뒤틀린 시체의 광연」으로 변경되며, 광기가 감소하면 원래대로 돌아온다."
  },
  State_2909_Name = {
    Text = "상태@몬스터24 뒤틀린 시체의 광연 카운터"
  },
  State_2909_WeaponDesc = {
    Text = "[Layer]의 광기를 보유한다. 광기가 5 이상일 경우, 의도가 「뒤틀린 시체의 광연」으로 변경되며, 광기가 감소하면 원래대로 돌아온다."
  },
  State_2910_Desc = {
    Text = "팀 유일: 탐색 시작 시 「영감」 1장과 장착한 깨어남체의 「타격」을 덱에 추가한다. 장착한 깨어남체의 「타격」 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 사용 후 <WeaponEffect_Num:[StateArg2]%> 확률로 카드 1장을 드로우한다. 이 효과는 매 턴 최대 1회 발동된다. 현재 계역이 「초차원」이고 초차원 턴 중일 경우, 「타격」이 「영감」 1장을 손에 넣는다. 해당 턴에 최대 1회 발동된다."
  },
  State_2910_WeaponDesc = {
    Text = "탐색 시작 시 「영감」 1장과 장착한 깨어남체의 「타격」을 덱에 추가한다. 장착한 깨어남체의 「타격」 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 사용 후 <WeaponEffect_Num:[StateArg2]%> 확률로 카드 1장을 드로우한다. 이 효과는 매 턴 최대 1회 발동된다. 현재 계역이 「초차원」이고 초차원 턴 중일 경우, 「타격」이 「영감」 1장을 손에 넣는다. 해당 턴에 최대 1회 발동된다."
  },
  State_2911_Desc = {
    Text = "상태@순백의 공상 세계 개조 카운트"
  },
  State_2911_Name = {
    Text = "상태@순백의 공상 세계 카운트"
  },
  State_2911_WeaponDesc = {
    Text = "상태@순백의 공상 세계 개조 카운트"
  },
  State_2912_Desc = {
    Text = "당신이 잠겼습니다! 사용 후 도해자 친위대가 [StateArg1]의 임시 힘을 획득하고, 해당 지령의 심해 낙인을 제거한다."
  },
  State_2912_Name = {
    Text = "<CardKeyWord:심해 마크>"
  },
  State_2912_WeaponDesc = {
    Text = "카드를 사용한 후 심해 잠수자 친위대가 [StateArg1]의 임시 힘을 획득한다."
  },
  State_2913_Desc = {
    Text = "전투 시작 시 자신에게 3턴간 손상을 부여한다."
  },
  State_2913_Name = {
    Text = "유물 기이한 갈고리발톱 2"
  },
  State_2913_WeaponDesc = {
    Text = "전투 시작 시 자신에게 3턴간 손상을 부여한다."
  },
  State_2914_Desc = {
    Text = "HP가 50% 미만일 때, 의도가 동일한 HP를 가진 [융식 삼각형 중]을 소환하는 것으로 변경된다."
  },
  State_2914_Name = {Text = "분열"},
  State_2914_WeaponDesc = {
    Text = "HP가 50% 미만일 때, 의도가 동일한 HP를 가진 [융식 삼각형 중]을 소환하는 것으로 변경된다."
  },
  State_2915_Desc = {
    Text = "「끝없는 원한」의 피해 횟수가 [Layer] 증가한다."
  },
  State_2915_Name = {Text = "증오"},
  State_2915_WeaponDesc = {
    Text = "「끝없는 원한」의 피해 횟수가 [Layer] 증가한다."
  },
  State_2917_Desc = {
    Text = "턴 종료 시, 남은 손패 1장당 다음 턴 시작 시 행동력 1을 획득한다."
  },
  State_2917_Name = {
    Text = "상태@환몽 은열쇠: 연산"
  },
  State_2918_Desc = {
    Text = "받는 피해가 99% 감소한다. 능동 피해를 받은 후 1스택이 제거되며, 턴 시작 시 3스택으로 회복된다."
  },
  State_2918_Name = {
    Text = "「불멸의 잔해」"
  },
  State_2918_WeaponDesc = {
    Text = "받는 피해가 99% 감소한다. 능동 피해를 받은 후 1스택이 제거되며, 턴 시작 시 3스택으로 회복된다."
  },
  State_2919_Desc = {
    Text = "상태@청화 비취 영상 사전"
  },
  State_2919_Name = {
    Text = "상태 @ 취화 비취 영상 앞당기기"
  },
  State_2919_WeaponDesc = {
    Text = "상태@청화 비취 영상 사전"
  },
  State_2922_Desc = {
    Text = "행동력 1을 소모할 때마다, 해당 깨어남체가 광기 2를 획득한다."
  },
  State_2923_Desc = {
    Text = "턴 종료 시, 힘이 [Layer] 증가한다."
  },
  State_2923_Name = {
    Text = "강신 의식"
  },
  State_2923_WeaponDesc = {
    Text = "매 턴 종료 시 [Layer]의 힘을 획득한다."
  },
  State_2925_Desc = {
    Text = "청화염이 피해를 줄 때마다, 스택이 1 증가한다."
  },
  State_2925_Name = {
    Text = "비취영상 카운트"
  },
  State_2925_WeaponDesc = {
    Text = "청화염이 피해를 줄 때마다, 스택이 1 증가한다."
  },
  State_2927_Name = {
    Text = "상태@저주 섬망 변화"
  },
  State_2929_Desc = {
    Text = "팀 유니크: 장착자가 피해를 1번 줄 때마다 <WeaponEffect_Num:[StateArg3]%> 확률로 장착자가 임시 크리티컬 데미지 2%를 획득합니다. 장착자가 광기 폭발을 사용한 후 무작위 적에게 장착자 공격의 <WeaponEffect_Num:[StateArg1]%> 에 해당하는 능동 피해를 3번 줍니다. 현재 영역이 「혈육」인 경우 장착자가 배아를 포식할 때마다 배아 융합 +<WeaponEffect_Num:[Blood:StateArg2]> 이 적용됩니다."
  },
  State_2929_WeaponDesc = {
    Text = "장착자가 피해를 1번 줄 때마다 <WeaponEffect_Num:[StateArg3]%> 확률로 장착자가 임시 크리티컬 데미지 2%를 획득합니다. 장착자가 광기 폭발을 사용한 후 무작위 적에게 [DescArg1] 능동 피해를 3번 줍니다. 현재 영역이 「혈육」인 경우 장착자가 배아를 포식할 때마다 배아 융합 +<WeaponEffect_Num:[Blood:StateArg2]> 이 적용됩니다."
  },
  State_2930_Name = {
    Text = "상태@조지@사망 시 힘 획득"
  },
  State_2931_Desc = {
    Text = "포식을 1회 수행할 때마다, 모든 적의 임시 힘을 4 탈취한다."
  },
  State_2931_Name = {
    Text = "이화된 줄마노"
  },
  State_2933_Name = {
    Text = "장식품 왜곡된 쌍자 백"
  },
  State_2933_WeaponDesc = {
    Text = "짝수 턴 시작 후, 소모와 허무가 부여된 장착한 깨어남체의 [방어] 1장을 손에 넣는다."
  },
  State_2934_Desc = {
    Text = "받는 능동 및 촉수 피해가 [DescArg1] % 증가."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour:취약>"
  },
  State_2934_WeaponDesc = {
    Text = "받는 모든 피해가 50% 증가한다."
  },
  State_2937_Desc = {
    Text = "3번째 실타래드를 획득할 때마다, 획득한 실타래드와 동일한 양의 반격을 추가로 획득한다."
  },
  State_2938_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우하고, 턴 종료 시 손패 1장을 선택하여 유지할 수 있다."
  },
  State_2939_Name = {
    Text = "손상 면역"
  },
  State_2940_Desc = {
    Text = "재생력 효과가 증가한다."
  },
  State_2940_Name = {
    Text = "이단의 혈통 흡수 강화"
  },
  State_2941_Desc = {
    Text = "사용 후 모든 적에게 [StateArg1]스택의 중독을 부여하고, 모든 적의 중독을 [StateArg2]% 발동시킨다."
  },
  State_2941_Name = {
    Text = "<Rune_10:독소>"
  },
  State_2942_Desc = {
    Text = "턴 종료 시 다른 아군의 생명을 [Layer] % 회복하고 지속 피해를 클리어합니다."
  },
  State_2942_Name = {
    Text = "전장 구조"
  },
  State_2946_Desc = {
    Text = "광란 연격으로 매우 높은 실타래드를 획득한다."
  },
  State_2946_Name = {
    Text = "「정지 요새」"
  },
  State_2946_WeaponDesc = {
    Text = "광란 연격으로 매우 높은 실타래드를 획득한다."
  },
  State_2947_Name = {Text = "용해 2"},
  State_2948_Desc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_2948_Name = {
    Text = "사용 전 카드 행동력 변경"
  },
  State_2948_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_2949_Name = {
    Text = "명륜 전투 각인 포기"
  },
  State_2951_Desc = {
    Text = "유물 영구 안락 의자"
  },
  State_2951_Name = {
    Text = "함묵 장갑"
  },
  State_2952_Desc = {
    Text = "턴 종료 후, [Layer]의 HP를 회복한다. HP 5를 잃을 때마다 1스택이 제거된다."
  },
  State_2952_Name = {Text = "재생력"},
  State_2954_Name = {
    Text = "상태@2-8 몬스터24@살려줘"
  },
  State_2955_Desc = {
    Text = "모든 적이 HP를 잃는다. 영속, 폐기."
  },
  State_2955_Name = {
    Text = "<CardKeyWord:허무 종결>"
  },
  State_2955_WeaponDesc = {
    Text = "모든 적이 HP를 잃는다. 영속, 폐기."
  },
  State_2956_Desc = {
    Text = "피해를 1회 받을 때마다 모든 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_2956_Name = {Text = "환상 빛"},
  State_2956_WeaponDesc = {
    Text = "피해를 1회 받을 때마다 모든 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_2957_Desc = {
    Text = "사망 후, 원래 위치에 자신의 HP 1/3의 [융식 삼각형 중]을 소환한다."
  },
  State_2957_Name = {Text = "융식"},
  State_2957_WeaponDesc = {
    Text = "사망 후, 원래 위치에 자신의 HP 1/3의 [융식 삼각형 중]을 소환한다."
  },
  State_2960_Desc = {
    Text = "짝수 턴에 행동력이 0일 때, 행동력 2를 획득한다."
  },
  State_2960_Name = {
    Text = "이화된 낡은 퍼즐"
  },
  State_2960_WeaponDesc = {
    Text = "짝수 턴에 행동력이 0일 때, 행동력 2를 획득한다."
  },
  State_2961_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 부여하는 <IntoxicationIconKeywords:중독>이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동하기 전, 모든 적에게 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg2]%>만큼의 중독을 부여한다. 열쇠 지령 사용 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_2961_WeaponDesc = {
    Text = "장착한 깨어남체가 부여하는 <IntoxicationIconKeywords:중독>이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동하기 전, 모든 적에게 <WeaponEffect_Num:[Poison:DescArg1]>스택의 중독을 부여한다. 열쇠 지령 사용 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_2962_Desc = {
    Text = "사용 후 전체 적에게 [StateArg1]턴간 허약을 부여한다."
  },
  State_2962_Name = {
    Text = "<Rune_2:허약>"
  },
  State_2965_Name = {
    Text = "상태@융기월의 시녀 계령 7"
  },
  State_2967_Desc = {
    Text = "증상 카드 사용 시, 판디아의 상태가 \"초조\"와 \"방종\" 사이에서 변화함. 초조: 가하는 능동 피해 횟수+1, 힘 감소. 방종: 가하는 능동 피해 횟수-1, 힘 증가."
  },
  State_2967_Name = {
    Text = "판디아 깨어남!"
  },
  State_2967_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_2968_Name = {
    Text = "상태@스테이지 2-14 전투 8 말풍선 4"
  },
  State_2969_Name = {
    Text = "상태@스테이지 2-14 전투 8 말풍선 5"
  },
  State_2970_Desc = {
    Text = "원초의 자손"
  },
  State_2970_Name = {
    Text = "원초의 자손"
  },
  State_2970_WeaponDesc = {
    Text = "원초의 자손"
  },
  State_2971_Desc = {
    Text = "상태@프롤로그 체력 절반 감소"
  },
  State_2971_Name = {
    Text = "상태@프롤로그 체력 절반 감소"
  },
  State_2971_WeaponDesc = {
    Text = "상태@프롤로그 체력 절반 감소"
  },
  State_2972_Name = {
    Text = "상태@스테이지 2-14 전투 8 말풍선 2"
  },
  State_2973_Name = {
    Text = "상태@스테이지 2-14 전투 8 말풍선 3"
  },
  State_2975_Desc = {
    Text = "매 전투의 처음 5회 도약 효과가 추가로 1회 발동된다."
  },
  State_2976_Desc = {
    Text = "턴 종료 시, 실타래드가 0 또는 10의 배수일 경우 [Arg1]의 실타래드를 획득한다. HP가 10의 배수일 경우 [Arg2]의 힘을 획득한다."
  },
  State_2976_Name = {
    Text = "구조 신호"
  },
  State_2977_Desc = {
    Text = "홀수 턴에 손패가 0장일 때, 카드 2장을 드로우한다."
  },
  State_2977_Name = {
    Text = "이화된 낡은 퍼즐"
  },
  State_2977_WeaponDesc = {
    Text = "홀수 턴에 손패가 0장일 때, 카드 2장을 드로우한다."
  },
  State_2978_Desc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 방어 모드로 전환된다."
  },
  State_2978_Name = {
    Text = "카드 카운터"
  },
  State_2978_WeaponDesc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 방어 모드로 전환된다."
  },
  State_2979_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 중독 및 실타래드가 <WeaponEffect_Num:[StateArg3]%> 증가한다. 장착한 깨어남체의 「타격」 치명타율과 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 최대 HP의 <WeaponEffect_Num:[StateArg2]%>만큼 실타래드를 획득한다. 실타래드 효과는 매 턴 최대 1회 발동된다."
  },
  State_2979_Name = {
    Text = "고통을 넘어"
  },
  State_2979_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 중독 및 실타래드가 <WeaponEffect_Num:[StateArg3]%> 증가한다. 장착한 깨어남체의 「타격」 치명타율과 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 최대 HP의 [StateArg2]%([DescArg1])만큼 실타래드를 획득한다. 실타래드 효과는 매 턴 최대 1회 발동된다."
  },
  State_2983_Desc = {
    Text = "버리기 단계에서 손에 남아 있을 경우, 카드가 소모되며 이번 전투에서 다시 등장하지 않는다."
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:허무>"
  },
  State_2983_WeaponDesc = {
    Text = "버리기 단계에서 손에 남아 있을 경우, 버린 카드 더미로 들어가지 않고, 이번 전투에서 다시 사용할 수 없다."
  },
  State_2985_Desc = {
    Text = "턴 종료 시까지, 피해를 줄 때마다 턴 종료 시 [Layer]pt의 HP를 회복한다."
  },
  State_2985_Name = {
    Text = "진주옥란"
  },
  State_2985_WeaponDesc = {
    Text = "턴 종료 시까지, 피해를 줄 때마다 [Layer]pt의 HP를 회복한다."
  },
  State_2987_Desc = {
    Text = "이벤트19_1"
  },
  State_2987_Name = {
    Text = "이벤트19_1"
  },
  State_2987_WeaponDesc = {
    Text = "이벤트19_1"
  },
  State_2988_Desc = {
    Text = "배아를 포식할 때, 버린 카드 더미에서 손으로 되돌아오며, 행동력 소모가 0이 된다."
  },
  State_2988_Name = {
    Text = "불길한 자손"
  },
  State_2988_WeaponDesc = {
    Text = "배아를 포식할 때, 버린 카드 더미에서 손으로 되돌아오며, 행동력 소모가 0이 된다."
  },
  State_2989_Desc = {
    Text = "깨어남체의 카드를 사용한 후, 행동력 소모가 1 감소한 해당 카드의 임시 복사본을 덱에 섞어 넣는다."
  },
  State_2990_Desc = {
    Text = "사용 후 모든 적이 [StateArg1]의 임시 힘을 잃는다."
  },
  State_2990_Name = {
    Text = "<Rune_18_High:고급 쇠약>"
  },
  State_2992_Desc = {
    Text = "「공허」를 뽑은 후, 이번 턴 내 모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  State_2992_Name = {Text = "공허"},
  State_2992_WeaponDesc = {
    Text = "「공허」를 뽑은 후, 이번 턴 내 모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  State_2993_Name = {
    Text = "상태@유물 괴뱀 허물 카운터"
  },
  State_2994_Desc = {
    Text = "촉수가 가득 찼을 때 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2994_Name = {
    Text = "보호의 힘"
  },
  State_2994_WeaponDesc = {
    Text = "촉수가 가득 찼을 때 촉수 피해가 [StateArg1] 증가한다."
  },
  State_2996_Desc = {
    Text = "사용 후 촉수 1개가 [StateArg1]회 공격한다."
  },
  State_2996_Name = {
    Text = "<Rune_11:지배>"
  },
  State_2997_Desc = {
    Text = "매 턴 3번째 피해를 입힌 후 [Arg1]의 실타래드를 획득한다. 매 턴 6번째 피해를 입힌 후 [Arg2]의 힘을 획득한다."
  },
  State_2997_Name = {
    Text = "안전 출구"
  },
  State_3001_Desc = {
    Text = "공격을 받을 때 획득하는 광기가 2 증가한다."
  },
  State_3002_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3002_Name = {
    Text = "상태@테스트 레이저포 행운"
  },
  State_3003_Desc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않고, 덱에서 제거된다."
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:소모>"
  },
  State_3003_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_3004_Desc = {
    Text = "[Layer]턴 동안 중독 상태를 면역한다."
  },
  State_3004_Name = {
    Text = "중독 면역"
  },
  State_3008_Desc = {
    Text = "매 턴 시작 시, 상대 손에 남은 카드에 둔화 1스택을 부여한다. 행동력 소모가 5를 초과하는 카드는 돌로 변환된다."
  },
  State_3008_Name = {
    Text = "아이기스 깨어남!"
  },
  State_3008_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_3011_Desc = {
    Text = "팀 유일: 장착자의 「광기 폭발」 크리티컬 확률과 크리티컬 데미지가 <WeaponEffect_Num:[StateArg2]%> 증가합니다. 장착자가 「광기 폭발」을 시전한 후, 장착자의 체질 <WeaponEffect_Num:[StateArg1]%>에 상응하는 <PowerIconKeywords:힘>을 획득합니다. 만약 이번 광기 폭발이 <CardKeyWord:흡수> 효과를 발동했다면, 추가로 1회 <PowerIconKeywords:힘>을 획득합니다."
  },
  State_3011_WeaponDesc = {
    Text = "장착자의 「광기 폭발」 크리티컬 확률과 크리티컬 데미지가 <WeaponEffect_Num:[StateArg2]%> 증가합니다. 장착자가 「광기 폭발」을 시전한 후, <WeaponEffect_Num:[Power:DescArg1]> 포인트의 힘을 획득합니다. 만약 이번 광기 폭발이 <CardKeyWord:흡수> 효과를 발동시켰다면, 추가로 1 번 <PowerIconKeywords:힘>을 얻습니다."
  },
  State_3012_Desc = {
    Text = "무의미한 공허 상태"
  },
  State_3012_Name = {
    Text = "무의미한 공허 상태"
  },
  State_3012_WeaponDesc = {
    Text = "무의미한 공허 상태"
  },
  State_3013_Desc = {
    Text = "갈증환자가 배아 융합을 사용할 때, [StateArg1] 점의 힘을 획득합니다."
  },
  State_3013_Name = {
    Text = "피를 갈망하는 자"
  },
  State_3014_Desc = {
    Text = "상대의 손패 수가 4 이상일 때, 피해를 받으면 [StateArg1]의 실타래드를 획득한다."
  },
  State_3014_Name = {Text = "뱀 형태"},
  State_3015_Desc = {
    Text = "상태@왁스 갑옷 아군 팀"
  },
  State_3015_Name = {
    Text = "상태@왁스 갑옷 우리 팀"
  },
  State_3015_WeaponDesc = {
    Text = "상태@왁스 갑옷 아군 팀"
  },
  State_3016_Desc = {
    Text = "소환된 몬스터의 HP가 2배로 증가한다."
  },
  State_3016_Name = {
    Text = "「괴로움의 물결」"
  },
  State_3016_WeaponDesc = {
    Text = "소환된 몬스터의 HP가 2배로 증가한다."
  },
  State_3017_Name = {
    Text = "상태@저주 섬망"
  },
  State_3018_Desc = {
    Text = "「차원을 관통하는 개」가 HP 1을 잃을 때마다 1스택이 제거되며, 스택이 0이 되면 [StateArg1]의 실타래드를 획득하고, [StateArg2]스택의 차원 장벽을 다시 획득한다."
  },
  State_3018_Name = {
    Text = "차원 장벽"
  },
  State_3019_Desc = {
    Text = "검은 인장 10을 소모할 때마다 HP 1%를 회복한다."
  },
  State_3019_Name = {
    Text = "상태@유물 역생근"
  },
  State_3019_WeaponDesc = {
    Text = "검은 인장 10을 소모할 때마다 HP 1%를 회복한다."
  },
  State_3020_Desc = {
    Text = "이전 턴에 피해를 받았다면, 턴 시작 시 1턴간 면역을 획득한다."
  },
  State_3020_Name = {
    Text = "최후의 외침"
  },
  State_3020_WeaponDesc = {
    Text = "이전 턴에 피해를 받았다면, 턴 시작 시 1턴간 면역을 획득한다."
  },
  State_3021_Desc = {
    Text = "턴 시작 시 행동력 1을 획득한다."
  },
  State_3021_Name = {
    Text = "상태@최대 행동력-2"
  },
  State_3023_Desc = {
    Text = "이번 턴 능동 피해를 받을 때마다, 피해 출처에게 [Layer] 의 <FixedDamage:순수 피해>를 가함."
  },
  State_3023_Name = {
    Text = "임시 반격"
  },
  State_3023_WeaponDesc = {
    Text = "능동 피해를 받을 때마다, 공격자에게 [Layer] 의 <FixedDamage:순수 피해>를 가함."
  },
  State_3024_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3024_Name = {
    Text = "상태@테스트 단검 죽음 저항"
  },
  State_3025_Desc = {
    Text = "카드를 1장 사용할 때마다, 이번 턴 내 치명타율이 10% 증가한다."
  },
  State_3026_Desc = {
    Text = "전투 시작 후 임시 복사본 [StateArg1]장을 덱에 섞어 넣는다. 원본 카드와 복사본 모두 유지된다."
  },
  State_3026_Name = {
    Text = "<Rune_8_High:고급 미러>"
  },
  State_3026_WeaponDesc = {
    Text = "전투 시작 후 임시 복사본 [StateArg1]장을 덱에 섞어 넣는다."
  },
  State_3027_Desc = {
    Text = "전투 종료 후, 추가로 검은 인장 50과 증상 카드 1장을 획득한다."
  },
  State_3028_Name = {
    Text = "상태@턴 시작 시 행동력 +2"
  },
  State_3029_Desc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 방어 모드로 전환된다."
  },
  State_3029_Name = {
    Text = "카드 카운터"
  },
  State_3029_WeaponDesc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 방어 모드로 전환된다."
  },
  State_3033_Desc = {
    Text = "매 10장의 카드를 사용할 때마다 모든 피해를 막는 장벽 1스택을 획득한다. 이미 장벽을 보유 중이라면, 대신 [Arg1]의 HP를 회복한다."
  },
  State_3034_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 카드를 1장 사용할 때마다 <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 이 효과는 단일 턴에 최대 3회 발동된다."
  },
  State_3034_WeaponDesc = {
    Text = "장착한 깨어남체의 카드를 1장 사용할 때마다 <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 이 효과는 한 턴에 최대 3회 발동된다."
  },
  State_3035_Desc = {
    Text = "사용 후 촉수 1개가 [StateArg1]회 공격한다."
  },
  State_3035_Name = {
    Text = "<Rune_11_High:고급 지배>"
  },
  State_3035_WeaponDesc = {
    Text = "사용 후 촉수 1개가 모든 적을 [StateArg1]회 공격한다."
  },
  State_30364_Desc = {
    Text = "이 카드가 손에 있을 때 손패 상한이 1 증가한다."
  },
  State_30364_Name = {
    Text = "손패 상한 무시"
  },
  State_30369_Desc = {
    Text = "이번 턴에 손패 상한이 [Layer] 증가한다."
  },
  State_30369_Name = {
    Text = "최대 손패 수"
  },
  State_3036_Desc = {
    Text = "부여하는 손상 및 허약 효과가 33%에서 50%로 변경된다."
  },
  State_3036_Name = {
    Text = "「적멸 여파」"
  },
  State_3036_WeaponDesc = {
    Text = "부여하는 손상 및 허약 효과가 33%에서 50%로 변경된다."
  },
  State_3038_Desc = {
    Text = "팀 유일: 열쇠 지령을 발동한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다."
  },
  State_3038_WeaponDesc = {
    Text = "열쇠 지령을 발동한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다."
  },
  State_3040_Desc = {
    Text = "매 턴 시작 시, 아군 팀에 [속박] [Layer]스택을 부여한다."
  },
  State_3040_Name = {Text = "속박"},
  State_3040_WeaponDesc = {
    Text = "매 턴 시작 시, 아군 팀에 [속박] [Layer]스택을 부여한다."
  },
  State_3041_Desc = {
    Text = "덱에 영구적으로 남는다."
  },
  State_3041_Name = {
    Text = "<CardKeyWord:증상 카드>"
  },
  State_3042_Desc = {
    Text = "피해를 입힐 때마다, 이번 턴 내에서 [Arg1]의 힘을 획득한다. 최대 3회 중첩되며, 최대 중첩 시 효과가 2배로 증가한다."
  },
  State_3043_Desc = {
    Text = "짝수 턴에 받는 피해가 50% 감소하고, 주는 피해가 33% 증가한다."
  },
  State_3043_Name = {Text = "변덕"},
  State_3043_WeaponDesc = {
    Text = "짝수 턴에 받는 피해가 50% 감소하고, 주는 피해가 33% 증가한다."
  },
  State_3045_Desc = {
    Text = "광기 폭발을 발동한 후, 해당 깨어남체가 광기 20을 획득한다."
  },
  State_3045_Name = {
    Text = "이름 없는 신의 베일"
  },
  State_3046_Desc = {
    Text = "팀 유일: 적이 사망할 때마다 [StateArg1]의 검은 인장을 획득한다. 장착한 깨어남체가 적을 처치한 후, 이번 스테이지에서 장착한 깨어남체의 치명타 피해가 영구적으로 <WeaponEffect_Num:[StateArg2]%> 증가하며, 최대 5회 중첩된다. 장착한 깨어남체가 도약 효과를 발동할 때마다, 해당 턴 동안 장착한 깨어남체가 주는 최종 피해가 <WeaponEffect_Num:[StateArg3]%> 증가하며, 최대 3회 중첩된다."
  },
  State_3046_WeaponDesc = {
    Text = "적이 사망할 때마다 [StateArg1]의 검은 인장을 획득한다. 장착한 깨어남체가 적을 처치한 후, 이번 스테이지에서 장착한 깨어남체의 치명타 피해가 영구적으로 <WeaponEffect_Num:[StateArg2]%> 증가하며, 최대 5회 중첩된다. 장착한 깨어남체가 도약 효과를 발동할 때마다, 해당 턴 동안 장착한 깨어남체가 주는 최종 피해가 <WeaponEffect_Num:[StateArg3]%> 증가하며, 최대 3회 중첩된다."
  },
  State_3047_Desc = {
    Text = "턴 시작 시 [Arg1]의 실타래드를 획득하며, 1턴이 지날 때마다 이 실타래드량이 [Arg2] 증가한다."
  },
  State_3047_Name = {
    Text = "수호의 손"
  },
  State_3048_Desc = {
    Text = "로탄의 전의는 결코 멈추지 않는다. 매 턴 종료 시, 로탄은 허약과 취약을 3스택 해제한다."
  },
  State_3048_Name = {
    Text = "로탄 깨어남"
  },
  State_3049_Desc = {
    Text = "조지의 다음 공격 피해 횟수가 1 증가한다."
  },
  State_3049_Name = {Text = "원한"},
  State_3049_WeaponDesc = {
    Text = "조지의 다음 공격 피해 횟수가 1 증가한다."
  },
  State_3050_Desc = {
    Text = "전투 시작 시, [경련] 1장을 덱에 섞어 넣는다."
  },
  State_3050_Name = {Text = "공포"},
  State_3050_WeaponDesc = {
    Text = "전투 시작 시, [경련] 1장을 덱에 섞어 넣는다."
  },
  State_3051_Desc = {
    Text = "방어되지 않은 피해를 입혔을 때, 「절규」 1장을 덱에 섞어 넣는다."
  },
  State_3051_Name = {
    Text = "타오르는 밀랍의 욕망"
  },
  State_3051_WeaponDesc = {
    Text = "실타래제 피해를 입힐 때, 「절규」 1장을 덱에 섞어 넣는다."
  },
  State_3054_Name = {
    Text = "상태@저주 쇼크"
  },
  State_3055_Desc = {
    Text = "전투 시작 시, 아군 팀에 손상 1스택을 부여한다."
  },
  State_3055_Name = {Text = "관통"},
  State_3055_WeaponDesc = {
    Text = "전투 시작 시, 아군 팀에 손상 1스택을 부여한다."
  },
  State_3056_Desc = {
    Text = "턴 종료 시, 허약과 취약을 1스택 제거한다."
  },
  State_3056_Name = {Text = "위압"},
  State_3058_Desc = {
    Text = "촉수 1개당, 턴 종료 시 [Arg1]의 실타래드를 획득한다."
  },
  State_3058_Name = {
    Text = "무명 부속지"
  },
  State_3060_Desc = {
    Text = "다음 턴 시작 시 [Layer]pt의 실타래드를 획득한다."
  },
  State_3060_Name = {
    Text = "정신 재건"
  },
  State_3060_WeaponDesc = {
    Text = "다음 턴 시작 시 [Layer]장의 카드를 드로우한다."
  },
  State_3063_Desc = {
    Text = "실타래제 피해를 입힐 때마다 [Layer]스택의 중독을 부여한다."
  },
  State_3063_Name = {Text = "독소"},
  State_3064_Desc = {
    Text = "카드를 사용하기 전에 스택 수만큼의 피해를 받는다. 턴 종료 후 해제된다."
  },
  State_3064_Name = {Text = "속박"},
  State_3064_WeaponDesc = {
    Text = "카드를 사용하기 전에 스택 수만큼의 피해를 받는다. 턴 종료 후 해제된다."
  },
  State_3065_Name = {
    Text = "상태@유물 과거의 공물 2"
  },
  State_3068_Desc = {
    Text = "턴 종료 후, [Layer] 의 <FixedDamage:순수 피해>를 받음."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:중독>"
  },
  State_3068_WeaponDesc = {
    Text = "턴 종료 후, [Layer] 의 <FixedDamage:순수 피해>를 받음."
  },
  State_3069_Name = {
    Text = "장식품 데우스 엑스 마키나"
  },
  State_3069_WeaponDesc = {
    Text = "매 전투의 첫 번째 턴에 행동력 1을 추가로 획득한다."
  },
  State_3070_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 「타격」이 대상 적에게 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 임시 <PowerIconKeywords:힘>을 잃게 한다. 이 효과는 한 턴 내에서 최대 3회 발동된다."
  },
  State_3070_WeaponDesc = {
    Text = "장착한 깨어남체의 「타격」이 대상 적의 임시 <PowerIconKeywords:힘>을 <WeaponEffect_Num:[Power:DescArg1]> 감소시킨다. 이 효과는 한 턴 내에서 최대 3회 발동된다."
  },
  State_3071_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 「방어」를 사용한 후, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  State_3071_WeaponDesc = {
    Text = "장비 착용자의 「방어」를 무너뜨린 후, <WeaponEffect_Num:[Power:DescArg1]> 점의 일시적인 <PowerIconKeywords:힘>을 획득합니다."
  },
  State_3072_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 적을 처치한 후, <WeaponEffect_Num:[StateArg1]>의 광기를 획득하고, 치명타 피해 1%를 획득한다. 이 효과는 탐색 전체에 걸쳐 유지된다."
  },
  State_3072_WeaponDesc = {
    Text = "장착한 깨어남체가 적을 처치한 후, <WeaponEffect_Num:[StateArg1]>의 광기를 획득하고, 치명타 피해 1%를 추가로 획득한다. 이 효과는 탐색 전체에 걸쳐 유지된다."
  },
  State_3073_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 광기 폭발을 사용한 후, 모든 아군의 이번 턴 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_3073_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 모든 아군의 이번 턴 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_3074_Desc = {
    Text = "팀 유일: 증상 카드를 1장 사용한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다. 이 효과는 한 턴 내 최대 2회 발동된다. 장착한 깨어남체가 명령 카드 1장을 사용한 후, 광기 1을 획득한다."
  },
  State_3074_WeaponDesc = {
    Text = "증상 카드를 사용한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다. 이 효과는 한 턴 내 최대 2회 발동된다. 장착한 깨어남체가 명령 카드 1장을 사용한 후, 광기 1을 획득한다."
  },
  State_3075_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 광기 폭발을 발동한 후, 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg1]%>만큼의 실타래드를 획득한다."
  },
  State_3075_Name = {
    Text = "마음의 장벽"
  },
  State_3075_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, <WeaponEffect_Num:[Block:DescArg1]>의 실타래드를 획득한다."
  },
  State_3076_Desc = {
    Text = "팀 유니크: 장착자가 능동 피해를 입힌 후 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가하며, 크리티컬 발생 후 해당 효과로 획득한 치명타율을 초기화합니다."
  },
  State_3076_WeaponDesc = {
    Text = "장착자가 능동 피해를 입힌 후 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가하며, 크리티컬 발생 후 해당 효과로 획득한 치명타율을 초기화합니다."
  },
  State_3078_Desc = {
    Text = "이번 턴 내에서 주는 피해가 반드시 치명타로 적중한다."
  },
  State_3078_Name = {
    Text = "임시 필사 치명타"
  },
  State_3078_WeaponDesc = {
    Text = "이번 턴 내에서 치명타율이 100% 증가한다."
  },
  State_3082_Desc = {
    Text = "광기 폭발을 발동한 후, 해당 깨어남체의 무작위 카드 1장을 손에 넣는다. 이 카드는 소모와 허무를 부여받는다."
  },
  State_3082_Name = {
    Text = "의사의 가방"
  },
  State_3084_Desc = {
    Text = "사용 후 카드의 복사본 [StateArg1]장을 임시 <DimensionalSpaceIconKeywords:초차원 공간>에 넣는다."
  },
  State_3084_Name = {
    Text = "<Rune_13_High:고급 워프>"
  },
  State_3084_WeaponDesc = {
    Text = "사용 후 소모되지만, 임시 원본 복사본 [StateArg1]장이 초차원 공간으로 들어간다."
  },
  State_3087_Desc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_3087_Name = {
    Text = "타격 카드 피해 임시 증가"
  },
  State_3087_WeaponDesc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_3088_Desc = {
    Text = "받는 능동 피해가 [Layer] 증가한다. 피해를 받을 때마다 융식 상처가 확대되며, 턴 시작 시 회복된다."
  },
  State_3088_Name = {
    Text = "깊은 융식"
  },
  State_3088_WeaponDesc = {
    Text = "받는 능동 피해가 [Layer] 증가한다. 피해를 받을 때마다 융식 상처가 확대되며, 턴 시작 시 회복된다."
  },
  State_3092_Name = {
    Text = "보스전일 경우, 전체 깨어남체 30pt 광기 획득 및 봉인 상태 해제"
  },
  State_3093_Name = {
    Text = "상태@곡예사 모방쇼 카운트"
  },
  State_3094_Desc = {
    Text = "뽑았을 때 자신에게 1턴간 손상을 부여한다. 사용 시 모든 적에게 1턴간 취약을 부여한다. 판매 불가."
  },
  State_3094_Name = {
    Text = "상태 저위 붕괴"
  },
  State_3094_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 손상을 부여한다. 사용 시 모든 적에게 1턴간 취약을 부여한다. 판매 불가."
  },
  State_3095_Desc = {
    Text = "이번 스테이지 내에서 주는 피해가 [Layer]pt 증가한다."
  },
  State_3095_Name = {Text = "영구 힘"},
  State_3095_WeaponDesc = {
    Text = "이번 스테이지 내에서 주는 피해가 [Layer]pt 증가한다."
  },
  State_3096_Desc = {
    Text = "로탄을 설득하는 길은 아직 멀었다."
  },
  State_3096_Name = {
    Text = "로탄 깨어남"
  },
  State_3098_Desc = {
    Text = "획득 후 카드 1장을 선택하여 해당 카드의 행동력 소모를 영구적으로 1로 만든다."
  },
  State_3099_Desc = {
    Text = "광기 폭발을 발동한 후, 이번 턴 내에서 [Arg1]의 힘을 획득한다."
  },
  State_3100_Desc = {
    Text = "매 턴 시작 시 죽음 저항이 10% 증가한다. 죽음 저항이 100% 이상일 때, 추가로 영역 숙련 30을 획득한다."
  },
  State_3104_Desc = {
    Text = "이번 턴 내에서, 능동 피해를 1회 받을 때마다 「달콤한 악귀」의 피해 횟수가 1 증가한다."
  },
  State_3104_Name = {
    Text = "고통 공유"
  },
  State_3104_WeaponDesc = {
    Text = "이번 턴 내에서, 능동 피해를 1회 받을 때마다 「달콤한 악귀」의 피해 횟수가 1 증가한다."
  },
  State_3106_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「실타래험 습작」 2개로 분열된다."
  },
  State_3106_Name = {Text = "분열"},
  State_3106_WeaponDesc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 동일한 HP를 가진 「II형 융식체 밀랍상」 3개로 분열된다."
  },
  State_3108_Name = {
    Text = "장식품 환형의 시편"
  },
  State_3108_WeaponDesc = {
    Text = "짝수 턴 시작 후, 행동력 1을 획득한다."
  },
  State_3109_Name = {
    Text = "상태@제4장 공명@행동력 -1"
  },
  State_3109_WeaponDesc = {
    Text = "「순진한 답례」의 행동력 소모가 1 감소한다."
  },
  State_3110_Name = {
    Text = "상태@제4장 공명@행동력 -1"
  },
  State_3110_WeaponDesc = {
    Text = "「순진한 답례」의 행동력 소모가 1 감소한다."
  },
  State_3111_Desc = {
    Text = "다음 턴 시작 시, 남은 실타래드를 HP의 2배로 전환한다."
  },
  State_3111_Name = {
    Text = "불멸의 꽃"
  },
  State_3112_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 부여하는 중독이 <WeaponEffect_Num:[StateArg3]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후, 장착한 깨어남체의 체질 <WeaponEffect_Num:[StateArg1]%>만큼 HP를 회복하며, 남은 행동력 1pt당 장착한 깨어남체의 체질 <WeaponEffect_Num:[StateArg2]%>만큼 HP를 추가로 회복한다."
  },
  State_3112_Name = {
    Text = "소리 없는 잔치"
  },
  State_3112_WeaponDesc = {
    Text = "장착한 깨어남체가 부여하는 중독이 <WeaponEffect_Num:[StateArg3]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후, <WeaponEffect_Num:[Heal:DescArg1]>의 HP를 회복하며, 남은 행동력 1pt당 <WeaponEffect_Num:[Heal:DescArg2]>의 HP를 추가로 회복한다."
  },
  State_3113_Desc = {
    Text = "상태@프롤로그 광기 0_1_4"
  },
  State_3113_Name = {
    Text = "상태@프롤로그 광기 0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_4"
  },
  State_3114_Desc = {
    Text = "상태@프롤로그 광기 0_1_2"
  },
  State_3114_Name = {
    Text = "상태@프롤로그 광기 0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_2"
  },
  State_3115_Desc = {
    Text = "상태@프롤로그 광기 0_1_2"
  },
  State_3115_Name = {
    Text = "상태@프롤로그 광기 0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_2"
  },
  State_3116_Name = {
    Text = "상태@프롤로그 광기 0_1_1"
  },
  State_3117_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 「타격」과 「광기 폭발」 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 「타격」을 사용하면, 장착한 깨어남체가 임시 치명타율 5%를 획득하며, 매 턴 최대 3회까지 중첩된다. 3회에 도달하면 임시 치명타 피해 15%를 추가로 획득한다."
  },
  State_3117_WeaponDesc = {
    Text = "장착한 깨어남체의 「타격」과 「광기 폭발」 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 「타격」을 사용하면, 장착한 깨어남체가 임시 치명타율 5%를 획득하며, 매 턴 최대 3회까지 중첩된다. 3회에 도달하면 임시 치명타 피해 15%를 추가로 획득한다."
  },
  State_3118_Desc = {
    Text = "턴 시작 시 잃은 HP의 [Layer]%를 회복한다."
  },
  State_3118_Name = {
    Text = "인도하는 돛의 비호"
  },
  State_3120_Desc = {
    Text = "[방어]가 [Arg1]스택의 반격을 획득한다."
  },
  State_3121_Desc = {
    Text = "적의 의도가 공격이 아닐 경우, 해당 적에게 능동 피해 또는 촉수 피해를 입힌 후, 피해량의 절반만큼 출혈을 추가로 부여한다."
  },
  State_3123_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg3]%> 증가한다. 공격을 1회 받을 때마다, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 임시 <PowerIconKeywords:힘>을 획득한다. 장착한 깨어남체가 광기 폭발을 사용한 후, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg2]%>만큼의 <RetaliateIconKeywords:반격>을 획득한다."
  },
  State_3123_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 반격이 <WeaponEffect_Num:[StateArg3]%> 증가한다. 공격을 1회 받을 때마다, <WeaponEffect_Num:[Power:DescArg1]>의 임시 <PowerIconKeywords:힘>을 획득한다. 장착한 깨어남체가 광기 폭발을 사용한 후, <WeaponEffect_Num:[Counterattack:DescArg2]>의 반격을 획득한다."
  },
  State_3124_Desc = {
    Text = "행운의 탐정이 획득하는 검은 인장이 2배로 증가한다."
  },
  State_3124_Name = {
    Text = "최고의 운"
  },
  State_3124_WeaponDesc = {
    Text = "행운의 탐정이 획득하는 검은 인장이 2배로 증가한다."
  },
  State_3127_Name = {
    Text = "상태@스테이지 2-10 전투 3 말풍선 1"
  },
  State_3128_Desc = {
    Text = "모든 깨어남체가 주는 실타래드와 HP 회복이 [StateArg1]% 증가한다."
  },
  State_3128_Name = {Text = "요람"},
  State_3129_Desc = {
    Text = "다음 턴 시작 전까지 능동 피해를 받을 때마다 추가로 [Layer]회 반격과 촉수 반격을 발동하며, 50% 피해를 가합니다."
  },
  State_3129_Name = {
    Text = "역린의 수호"
  },
  State_3130_Desc = {
    Text = "이번 턴 내에 주는 피해가 [Layer]pt 증가한다."
  },
  State_3130_Name = {Text = "임시 힘"},
  State_3130_WeaponDesc = {
    Text = "이번 턴 내에 주는 피해가 [Layer]pt 증가한다."
  },
  State_3135_Desc = {
    Text = "스택당 주는 능동 피해 횟수가 1 증가한다."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:광란>"
  },
  State_3136_Name = {Text = "광기"},
  State_3137_Desc = {
    Text = "전투 시작 시, 촉수 1개를 획득하며, 촉수 피해가 영구적으로 [Arg1] 증가한다."
  },
  State_3138_Name = {
    Text = "장식품 이율배반"
  },
  State_3138_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 아군이 장착한 깨어남체의 방어력의 100%만큼 <RetaliateIconKeywords:반격>을 획득한다. 그리고 자신의 현재 <RetaliateIconKeywords:반격>이 10% 증가한다."
  },
  State_3139_Desc = {
    Text = "초차원 턴에 진입한 후, 자신의 허약과 손상 상태를 해제하고, 모든 적에게 2턴간 허약과 취약을 부여한다."
  },
  State_3140_Desc = {
    Text = "전투 시작 시, 「환각」을 초차원 공간에 넣는다. 초차원 공간이 4장에 도달할 때까지 반복한다."
  },
  State_3143_Desc = {
    Text = "실타래제 피해를 입힐 때, 아군 팀이 임시 힘 [Layer]을 잃는다."
  },
  State_3143_Name = {Text = "마비"},
  State_3144_Name = {
    Text = "아군 팀 \"중독\"과 \"출혈\" 스택 절반 감소"
  },
  State_3145_Desc = {
    Text = "[Layer]턴 동안 카드를 사용할 수 없다."
  },
  State_3145_Name = {
    Text = "카드를 사용할 수 없음"
  },
  State_3146_Desc = {
    Text = "바다의 사도가 카드를 1장 사용할 때, [StateArg1]개의 임시 촉수를 생성하며, 이 촉수는 촉수 상한을 무시한다."
  },
  State_3146_Name = {
    Text = "대행 권능"
  },
  State_3146_WeaponDesc = {
    Text = "바다의 사도가 카드를 1장 사용할 때, [StateArg1]개의 임시 촉수를 생성하며, 이 촉수는 촉수 상한을 무시한다."
  },
  State_3149_Desc = {
    Text = "다음 턴 시작 시, 받는 능동 및 촉수 피해가 50 % 증가."
  },
  State_3149_Name = {
    Text = "지연 취약"
  },
  State_3149_WeaponDesc = {
    Text = "받는 모든 피해가 50% 증가한다."
  },
  State_3150_Desc = {
    Text = "한 턴 내에 3번 공격을 받으면 임시 <MadnessColour:발광> 1스택을 획득합니다."
  },
  State_3150_Name = {
    Text = "「달콤한 고통」"
  },
  State_3151_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 힘을 얻는다."
  },
  State_3152_Name = {
    Text = "상태@장식품 재진화"
  },
  State_3152_WeaponDesc = {
    Text = "장착한 깨어남체의 턴 종료 후 광기 3을 획득한다. 장착한 깨어남체의 광기 회충량이 10을 초과할 경우, 광기 2를 추가로 획득한다."
  },
  State_3153_Name = {
    Text = "상태@저주 섬망 원상복구"
  },
  State_3154_Name = {
    Text = "치명타율"
  },
  State_3155_Desc = {
    Text = "매 턴마다 잃은 HP의 10%를 회복한다."
  },
  State_3155_Name = {Text = "메딕"},
  State_3155_WeaponDesc = {
    Text = "매 턴마다 잃은 HP의 10%를 회복한다."
  },
  State_3156_Desc = {
    Text = "매 턴 받는 첫 번째 피해가 5배로 증가한다."
  },
  State_3156_Name = {Text = "당황"},
  State_3160_Desc = {
    Text = "턴 시작 시, 이번 턴에 [Arg1]의 경계를 획득하는 「양산」 1장을 손에 넣는다. 카드 6장을 사용한 후, 손에 있는 모든 「양산」의 경계를 [Arg2] 증가시킨다."
  },
  State_3161_Desc = {
    Text = "상대의 드로우 수가 [Layer] 감소하지만, 모든 카드가 유지를 획득한다."
  },
  State_3161_WeaponDesc = {
    Text = "아군 팀의 드로우 수가 [Layer] 감소하며, 모든 카드가 유지를 획득한다."
  },
  State_3163_Desc = {
    Text = "죽음 저항이 발동된 후, [Layer]pt의 HP를 회복한다."
  },
  State_3163_Name = {
    Text = "별의 요람"
  },
  State_3163_WeaponDesc = {
    Text = "죽음 저항이 발동된 후, [Layer]pt의 HP를 회복한다."
  },
  State_3164_Name = {
    Text = "끝없는 원한 카운트"
  },
  State_3165_Name = {
    Text = "기어 다니는 자 계령 3"
  },
  State_3166_Name = {
    Text = "본 전투 발동됨"
  },
  State_3168_Desc = {
    Text = "턴 시작 시 모든 몬스터의 공격 횟수 카운트가 1 증가한다."
  },
  State_3168_Name = {
    Text = "상태@복수의 거대한 검 참수 중상"
  },
  State_3168_WeaponDesc = {
    Text = "턴 시작 시 모든 몬스터의 공격 횟수 카운트가 1 증가한다."
  },
  State_3170_Desc = {
    Text = "충동의 대가를 부여한다."
  },
  State_3170_Name = {
    Text = "충동의 대가 부여"
  },
  State_3170_WeaponDesc = {
    Text = "충동의 대가를 부여한다."
  },
  State_3171_Name = {
    Text = "상태@스테이지 2-1 전투 3 말풍선 1"
  },
  State_3172_Desc = {
    Text = "피해를 입힐 때마다 [StateArg1]의 임시 힘을 획득하며, 최대 [StateArg2]회 중첩된다. 최대 중첩 시 효과가 2배로 증가한다."
  },
  State_3172_Name = {
    Text = "유물 피 묻은 자갈"
  },
  State_3174_Desc = {
    Text = "최대 HP가 30% 감소한다."
  },
  State_3174_Name = {
    Text = "유물 육분의 2"
  },
  State_3174_WeaponDesc = {
    Text = "최대 HP가 30% 감소한다."
  },
  State_3175_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 10을 획득한다."
  },
  State_3175_Name = {
    Text = "유물 육분의 1"
  },
  State_3175_WeaponDesc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 10을 획득한다."
  },
  State_3176_Desc = {
    Text = "프롤로그 덱 초기화 0_1_1_1"
  },
  State_3176_Name = {
    Text = "프롤로그 덱 초기화 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "프롤로그 덱 초기화 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "「경계」가 3스택에 도달하면 후퇴하고, 「대리 밀랍상」을 소환한다. 턴 시작 시 스택을 초기화한다."
  },
  State_3177_Name = {Text = "경계"},
  State_3177_WeaponDesc = {
    Text = "「경계」가 3스택에 도달하면 후퇴하고, 「대리 밀랍상」을 소환한다. 턴 시작 시 스택을 초기화한다."
  },
  State_3178_Desc = {
    Text = "카드의 행동력 소모를 증가시킨다."
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords:둔화>"
  },
  State_3178_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_3179_Desc = {
    Text = "전투 시작 시 실타래드 20을 획득한다. 매 턴 시작 시 실타래드가 존재할 경우, 해당 턴의 실타래드와 치유 강효가 50% 증가한다."
  },
  State_3179_Name = {
    Text = "이화된 정원의 수호자"
  },
  State_3179_WeaponDesc = {
    Text = "전투 시작 시 실타래드 20을 획득한다. 매 턴 시작 시 실타래드가 존재할 경우, 해당 턴의 실타래드와 치유 강효가 50% 증가한다."
  },
  State_3180_Desc = {
    Text = "치명타율이 25% 증가한다. HP를 회복한 후, 회복을 발생시킨 대상의 치명타율에 비례하여 추가로 HP 회복이 1회 발생할 수 있다."
  },
  State_3180_Name = {
    Text = "상태@환몽 은열쇠: 치명타 치유"
  },
  State_3181_Name = {
    Text = "치명타율"
  },
  State_3183_Desc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3183_Name = {
    Text = "임시 치명타 피해"
  },
  State_3185_Desc = {
    Text = "이동 시 추가 압력이 증가한다."
  },
  State_3185_Name = {
    Text = "유물 무저갱 2"
  },
  State_3185_WeaponDesc = {
    Text = "이동 시 추가 압력이 증가한다."
  },
  State_3189_Name = {
    Text = "몬스터 지연 힘"
  },
  State_3190_Name = {
    Text = "유물 열쇠"
  },
  State_3193_Desc = {
    Text = "다음 턴 시작 후 [Layer]pt의 실타래드를 획득한다."
  },
  State_3193_Name = {
    Text = "잃어버린 예술"
  },
  State_3193_WeaponDesc = {
    Text = "다음 턴 시작 후 [Layer]pt의 실타래드를 획득한다."
  },
  State_3196_Desc = {
    Text = "사용 후 [StateArg1]의 행동력을 획득한다."
  },
  State_3196_Name = {
    Text = "<Rune_4_High:고급 계산>"
  },
  State_3196_WeaponDesc = {
    Text = "사용 후 [StateArg1]의 행동력을 획득한다."
  },
  State_3197_Desc = {
    Text = "「타격」으로 [Arg1]의 HP를 회복하고, 자신의 출혈과 중독 스택을 절반으로 감소시킨다."
  },
  State_3197_Name = {
    Text = "지혈 클램프"
  },
  State_3200_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해와 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 탐색 시작 시 장착한 깨어남체의 「타격」과 「방어」를 덱에 추가한다. 장착한 깨어남체가 「방어」를 사용한 후, 장착한 깨어남체의 다음 「타격」의 치명타율과 치명타 피해가 15% 증가한다. 장착한 깨어남체가 「타격」을 사용한 후, 장착한 깨어남체의 다음 「방어」의 실타래드가 15% 증가하며, 최대 3회 중첩된다."
  },
  State_3200_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해와 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 탐색 시작 시 장착한 깨어남체의 「타격」과 「방어」를 덱에 추가한다. 장착한 깨어남체가 「방어」를 사용한 후, 장착한 깨어남체의 다음 「타격」의 치명타율과 치명타 피해가 15% 증가한다. 장착한 깨어남체가 「타격」을 사용한 후, 장착한 깨어남체의 다음 「방어」의 실타래드가 15% 증가하며, 최대 3회 중첩된다."
  },
  State_3201_Name = {
    Text = "끝없는 원한"
  },
  State_3203_Desc = {
    Text = "팀 유니크: 장착자가 주는 방어막 [<WeaponEffect_Num:[StateArg3]%>] 증가. 장착자의 「방어」가 HP가 가장 높은 적에게 장착자 방어력의 <WeaponEffect_Num:[StateArg1]%> 에 해당하는 <IntoxicationIconKeywords:중독>을 부여. 현재 영역이 「혈육」이면, <IntoxicationIconKeywords:중독> 부여 시 <EmbryoFusionIconKeywords:배아 융합> + <WeaponEffect_Num:[Blood:StateArg2]>, 해당 효과는 턴당 최대 3회 발동."
  },
  State_3203_WeaponDesc = {
    Text = "장착자가 주는 방어막 <WeaponEffect_Num:[StateArg3]%> 증가. 장착자의 「방어」가 HP가 가장 높은 적에게 <WeaponEffect_Num:[Poison:DescArg1]> 중첩의 <IntoxicationIconKeywords:중독>을 부여. 현재 영역이 「혈육」이면, <IntoxicationIconKeywords:중독> 부여 시 <EmbryoFusionIconKeywords:배아 융합> +<WeaponEffect_Num:[Blood:StateArg2]>, 해당 효과는 턴당 최대 3회 발동."
  },
  State_3204_Desc = {
    Text = "실타래제 피해를 입힐 때, [StateArg1]장의 「상처」를 덱에 섞어 넣는다."
  },
  State_3204_Name = {Text = "열상"},
  State_3204_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_3206_Desc = {
    Text = "카드를 1장 사용할 때마다, 이번 턴 내 치명타율이 [StateArg1]% 증가하며, 최대 [StateArg2]회 중첩된다. 최대 중첩 시 효과가 2배로 증가한다."
  },
  State_3206_Name = {
    Text = "유물 멤피스 의식 거울"
  },
  State_3206_WeaponDesc = {
    Text = "카드를 1장 사용할 때마다, 이번 턴 내 치명타율이 [StateArg1]% 증가하며, 최대 [StateArg2]회 중첩된다. 최대 중첩 시 효과가 2배로 증가한다."
  },
  State_3207_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 제거되며, 스택이 0이 되면 [DescArg1]의 실타래드를 획득한다."
  },
  State_3207_Name = {
    Text = "차원 장벽"
  },
  State_3208_Desc = {
    Text = "석화 중, 행동할 수 없으며, 턴 종료 후 제거된다."
  },
  State_3208_Name = {
    Text = "<PetrifactionColour: 석화>"
  },
  State_3209_Name = {
    Text = "장식품 생명력 착취"
  },
  State_3209_WeaponDesc = {
    Text = "전투 시작 후, 장착한 깨어남체의 직업이 혈육일 경우 공격력이 25% 증가한다."
  },
  State_3210_Name = {
    Text = "상태@복수의 거대한 칼날 계령 1"
  },
  State_3211_Desc = {
    Text = "손패 상한이 2 증가하고, 턴 종료 시 손패를 버리지 않는다. HP를 잃을 때마다 무작위로 손패 2장을 버린다."
  },
  State_3212_Desc = {
    Text = "능동 및 촉수 피해 감소 25%, 턴 종료 시 1스택 제거."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:허약>"
  },
  State_3212_WeaponDesc = {
    Text = "주는 모든 피해가 25% 감소한다."
  },
  State_3213_Desc = {
    Text = "실타래드와 치유 효과가 [Layer]% 증가한다."
  },
  State_3213_Name = {
    Text = "임시 실타래드 및 치유 강효"
  },
  State_3213_WeaponDesc = {
    Text = "실타래드와 치유 효과가 [Layer]% 증가한다."
  },
  State_3215_Name = {
    Text = "시령추「은밀」"
  },
  State_3216_Desc = {
    Text = "전투 종료 후, 추가로 검은 인장 100을 획득하지만 증상 카드 1장을 얻는다."
  },
  State_3216_Name = {
    Text = "유물 행운의 반지"
  },
  State_3216_WeaponDesc = {
    Text = "전투 종료 후, 추가로 검은 인장 100을 획득하지만 증상 카드 1장을 얻는다."
  },
  State_3220_Desc = {
    Text = "광기 폭발 후 카드 1장을 드로우한다. HP가 25% 미만일 경우, 추가로 카드 1장을 드로우한다."
  },
  State_3223_Desc = {
    Text = "부여하는 허약 효과가 10% 증가한다. 매 3턴마다 모든 적에게 허약 1스택을 추가한다."
  },
  State_3224_Name = {
    Text = "상태@유물 아르카나 기록 행동력"
  },
  State_3225_Name = {
    Text = "경추 절단"
  },
  State_3226_Desc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_3226_Name = {Text = "소모"},
  State_3226_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_3227_Desc = {
    Text = "모든 유물의 가격이 50% 감소한다."
  },
  State_3227_Name = {
    Text = "유물 교역 훈장"
  },
  State_3227_WeaponDesc = {
    Text = "모든 유물의 가격이 50% 감소한다."
  },
  State_3228_Desc = {
    Text = "턴 시작 시, 광기가 가장 낮은 깨어남체가 광기 25를 획득한다."
  },
  State_3228_Name = {
    Text = "상태@유물 아르카나 광기"
  },
  State_3228_WeaponDesc = {
    Text = "턴 시작 시, 광기가 가장 낮은 깨어남체가 광기 25를 획득한다."
  },
  State_3229_Desc = {
    Text = "프롤로그 덱 초기화 0_1_1_1"
  },
  State_3229_Name = {
    Text = "프롤로그 덱 초기화 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "프롤로그 덱 초기화 0_1_1_1"
  },
  State_3230_Name = {
    Text = "상태@일반 지연 행동력"
  },
  State_3232_Desc = {
    Text = "상태@몬스터 초차원 카드 슬롯 트리거"
  },
  State_3232_Name = {
    Text = "상태@몬스터 초차원 카드 슬롯 트리거"
  },
  State_3232_WeaponDesc = {
    Text = "상태@몬스터 초차원 카드 슬롯 트리거"
  },
  State_3234_Desc = {
    Text = "전투 시작 시 힘 3을 획득하지만, 받는 피해가 5씩 증가한다."
  },
  State_3234_Name = {
    Text = "최후의 외침"
  },
  State_3235_Desc = {
    Text = "전투 시작 시 [Layer]의 힘을 획득하지만, 받는 피해가 5씩 증가한다."
  },
  State_3235_Name = {
    Text = "최후의 외침"
  },
  State_3236_Desc = {
    Text = "사용 후 다른 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_3236_Name = {
    Text = "<Rune_16_High:고급 촉매>"
  },
  State_3237_Desc = {
    Text = "3턴마다 촉수 3개를 획득한다. 이 촉수는 촉수 상한을 무시하며, 턴 종료 시 제거된다."
  },
  State_3238_Desc = {
    Text = "전투 시작 시 몬스터가 받는 모든 피해가 증가하는 상태를 부여한다."
  },
  State_3238_Name = {
    Text = "전투 시작 시 몬스터가 받는 피해 증가 상태 부여"
  },
  State_3238_WeaponDesc = {
    Text = "전투 시작 시 몬스터가 받는 모든 피해가 증가하는 상태를 부여한다."
  },
  State_3239_Desc = {
    Text = "공격력이 [Layer]pt 증가한다."
  },
  State_3239_Name = {
    Text = "일반 공격력 증가"
  },
  State_3239_WeaponDesc = {
    Text = "공격력이 [Layer]pt 증가한다."
  },
  State_3242_Name = {
    Text = "<DerivativeCardKeywords_4:「영감」> 2장을 덱에 넣기"
  },
  State_3243_Desc = {
    Text = "카드의 행동력이 증가한다."
  },
  State_3243_Name = {
    Text = "카드 행동력 증가"
  },
  State_3243_WeaponDesc = {
    Text = "카드의 행동력이 증가한다."
  },
  State_3244_Desc = {
    Text = "소환된 몬스터의 HP가 2배로 증가한다."
  },
  State_3244_Name = {
    Text = "「괴로움의 물결」"
  },
  State_3244_WeaponDesc = {
    Text = "소환된 몬스터의 HP가 2배로 증가한다."
  },
  State_3245_Desc = {
    Text = "전투 시작 시, 아군 팀의 치명타율이 30% 감소하고, 치명타 피해가 30% 증가한다."
  },
  State_3245_Name = {Text = "억제"},
  State_3245_WeaponDesc = {
    Text = "전투 시작 시, 아군 팀의 치명타율이 30% 감소하고, 치명타 피해가 30% 증가한다."
  },
  State_3246_Desc = {
    Text = "전투 시작 시 일반 적의 HP가 30% 증가하고, 전투 승리 후 추가로 검은 인장 25를 제공한다."
  },
  State_3246_Name = {
    Text = "유물 파편화된 전기"
  },
  State_3246_WeaponDesc = {
    Text = "전투 시작 시 일반 적의 HP가 30% 증가하고, 전투 승리 후 추가로 검은 인장 25를 제공한다."
  },
  State_3247_Desc = {
    Text = "[광기 폭발]로 모든 손패의 행동력 소모가 1 감소한다."
  },
  State_3247_Name = {
    Text = "이화된 문명의 빛"
  },
  State_3247_WeaponDesc = {
    Text = "[광기 폭발]로 모든 손패의 행동력 소모가 1 감소한다."
  },
  State_3249_Desc = {
    Text = "다른 아군이 <MadnessColour:발광> 1스택을 획득하며, 자신이 사망하면 해제됩니다."
  },
  State_3249_Name = {
    Text = "안절부절"
  },
  State_3249_WeaponDesc = {
    Text = "다른 아군이 광란 1스택을 획득하며, 자신이 사망하면 해제된다."
  },
  State_3250_Desc = {
    Text = "전투 종료 후에도 덱에 보존되지만, 사용하거나 소모되면 영구적으로 제거됩니다."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:폐기>"
  },
  State_3250_WeaponDesc = {
    Text = "사용 후 영구적으로 제거된다."
  },
  State_3251_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해 면역 후 1층 감소, 턴 시작 시 제거."
  },
  State_3251_Name = {
    Text = "<ParcloseColour:임시 장벽>"
  },
  State_3252_Desc = {
    Text = "진흙의 꽃이 실타래드를 부여할 때, 최대 HP가 [StateArg2] 증가한다."
  },
  State_3252_Name = {
    Text = "점액 응집"
  },
  State_3252_WeaponDesc = {
    Text = "진흙의 꽃이 실타래드를 부여할 때, 최대 HP가 [StateArg2] 증가한다."
  },
  State_3253_Desc = {
    Text = "[StateArg1]의 임시 경계를 획득한다."
  },
  State_3253_Name = {
    Text = "<CardKeyWord:기계 무장-방패>"
  },
  State_3253_WeaponDesc = {
    Text = "[StateArg1]의 임시 경계를 획득한다."
  },
  State_3255_Name = {Text = "반격"},
  State_3256_Name = {
    Text = "상태@저주 흥분"
  },
  State_3259_Desc = {
    Text = "가하는 능동 피해 횟수가 [Layer] 증가."
  },
  State_3259_Name = {
    Text = "<MadnessColour:광란>"
  },
  State_3260_Desc = {
    Text = "초차원 공간이 가득 찼을 때, 추가 턴을 획득한다. 이 턴에는 카드를 드로우하지 않고, 초차원 공간의 카드를 손으로 가져온다."
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:초차원 공간>"
  },
  State_3260_WeaponDesc = {
    Text = "초차원 공간이 가득 찼을 때, 추가 초차원 턴을 획득하며, 모든 초차원 공간 카드를 손에 넣는다."
  },
  State_3261_Desc = {
    Text = "그가 소환한 몬스터의 피해가 2배로 증가한다."
  },
  State_3261_Name = {
    Text = "「밀랍 군단」"
  },
  State_3261_WeaponDesc = {
    Text = "그가 소환한 몬스터의 피해가 2배로 증가한다."
  },
  State_3262_Desc = {
    Text = "상태@왁스 코팅 아군 팀"
  },
  State_3262_Name = {
    Text = "상태@왁스 코팅 우리 팀"
  },
  State_3262_WeaponDesc = {
    Text = "상태@왁스 코팅 아군 팀"
  },
  State_3263_Name = {
    Text = "상태@노틸러스 껍질 반격"
  },
  State_3264_Name = {
    Text = "필사 치명타"
  },
  State_3265_Name = {
    Text = "버릴 시 제거됨"
  },
  State_3266_Desc = {
    Text = "죽음의 꿈 도시의 강화 도약"
  },
  State_3266_Name = {
    Text = "상태@죽음의 꿈도시 강화 도약"
  },
  State_3267_Desc = {
    Text = "전투 시작 시, [왁스 갑옷] 5스택을 획득한다."
  },
  State_3267_Name = {
    Text = "「밀랍의 신사」"
  },
  State_3267_WeaponDesc = {
    Text = "전투 시작 시, [왁스 갑옷] 5스택을 획득한다."
  },
  State_3268_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다. 카드를 드로우할 때마다 해당 카드의 행동력 소모가 무작위로 변경된다 (0-4)."
  },
  State_3268_Name = {
    Text = "유물 만화경"
  },
  State_3268_WeaponDesc = {
    Text = "턴 시작 시 카드 1장을 드로우한다. 카드를 드로우할 때마다 해당 카드의 행동력 소모가 무작위로 변경된다 (0-4)."
  },
  State_3269_Desc = {
    Text = "매 턴 2번째 실타래드를 획득하면 [Arg1]스택의 반격을 획득한다. 매 턴 4번째 실타래드를 획득하면 모든 적에게 반격 수치만큼 피해를 1회 준다."
  },
  State_3269_Name = {
    Text = "아는 것은 모두 말하다"
  },
  State_3270_Name = {
    Text = "상태@장2 공명 복제"
  },
  State_3271_Desc = {
    Text = "[타격]이 모든 적에게 [Arg1]스택의 중독을 부여한다."
  },
  State_3272_Desc = {
    Text = "방어되지 않은 피해를 입혔을 때, 실타래제 피해량의 3배만큼 HP를 회복한다. 피해를 입힐 때 제거된다."
  },
  State_3272_Name = {Text = "흡혈"},
  State_3273_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 카드를 사용한 후, 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg1]%>만큼의 실타래드를 획득하며, 촉수 1개당 실타래드가 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg2]%>만큼 증가한다. 이 효과는 단일 턴에 1회만 발동된다."
  },
  State_3273_Name = {
    Text = "산호 여인의 죽음"
  },
  State_3273_WeaponDesc = {
    Text = "장착한 깨어남체의 카드를 사용한 후, <WeaponEffect_Num:[Block:DescArg1]>의 실타래드를 획득하며, 촉수 1개당 실타래드가 <WeaponEffect_Num:[DescArg2]> 증가한다. 이 효과는 단일 턴에 1회만 발동된다."
  },
  State_3274_Desc = {
    Text = "능동 피해를 받을 때마다 아군 팀의 카운트가 1 증가한다."
  },
  State_3274_Name = {
    Text = "상태@복수의 거대한 검 중상 아군 팀 카운트"
  },
  State_3274_WeaponDesc = {
    Text = "능동 피해를 받을 때마다 아군 팀의 카운트가 1 증가한다."
  },
  State_3277_Desc = {
    Text = "사용 후 소속 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_3277_Name = {
    Text = "<Rune_5:광화>"
  },
  State_3280_Name = {
    Text = "운명의 검"
  },
  State_3281_Desc = {
    Text = "주는 능동 피해를 증가시킨다."
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:힘>"
  },
  State_3281_WeaponDesc = {
    Text = "주는 피해가 증가한다."
  },
  State_3282_Desc = {
    Text = "피해 횟수와 피해량이 증가한다."
  },
  State_3282_Name = {
    Text = "<CardKeyWord:업그레이드>"
  },
  State_3282_WeaponDesc = {
    Text = "피해 횟수가 1회 증가한다."
  },
  State_3283_Desc = {
    Text = "매 턴 시작 시, [StateArg1]의 HP를 회복한다. HP가 50% 미만일 경우, 회복량이 [StateArg2]로 변경된다."
  },
  State_3283_Name = {
    Text = "유물 유향 제제"
  },
  State_3283_WeaponDesc = {
    Text = "매 턴 시작 시, [StateArg1]의 HP를 회복한다. HP가 50% 미만일 경우, 회복량이 [StateArg2]로 변경된다."
  },
  State_3287_Desc = {
    Text = "전투 시작 시, 「영감」 2장을 덱에 섞어 넣는다. 전투를 1회 통과할 때마다 이 유물이 업그레이드되며, 최대 3회까지 가능하다."
  },
  State_3288_Desc = {
    Text = "상태@공 상태"
  },
  State_3288_Name = {
    Text = "상태@빈 상태"
  },
  State_3288_WeaponDesc = {
    Text = "상태@공 상태"
  },
  State_3289_Desc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 의도를 「불멸의 꽃」으로 대체하고, 방어에 중점을 둔 스킬 세트를 사용한다."
  },
  State_3289_Name = {
    Text = "불멸의 꽃"
  },
  State_3289_WeaponDesc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 방어 모드로 전환된다."
  },
  State_3290_Desc = {
    Text = "한때 「미리암」이었던 이형은 극도의 편집증과 절망에 빠져 있다. 그녀의 마지막 망집을 깨뜨려 이 수천 년간의 광기를 종식시켜라."
  },
  State_3290_Name = {Text = "망집"},
  State_3291_Desc = {
    Text = "실타래제 피해를 입힐 때, 아군 팀이 임시 힘 3을 잃는다."
  },
  State_3291_Name = {Text = "마비"},
  State_3292_Desc = {
    Text = "광기 폭발을 발동할 때, 적이 1회 피해를 줄 때마다 해당 적에게 [Arg1]스택의 중독을 부여한다."
  },
  State_3293_Desc = {
    Text = "이번 스테이지 내에서 주는 피해가 [Layer]pt 감소한다."
  },
  State_3293_Name = {Text = "힘 감소"},
  State_3293_WeaponDesc = {
    Text = "이번 스테이지 내에서 주는 피해와 촉수 피해가 [Layer]pt 감소한다."
  },
  State_3294_Name = {
    Text = "상태@저주 의심"
  },
  State_3296_Desc = {
    Text = "버려지거나 사용될 때 제거된다."
  },
  State_3296_Name = {
    Text = "버리거나 사용 시 제거됨"
  },
  State_3296_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_3297_Desc = {
    Text = "상태@가시 여왕 계명_형"
  },
  State_3297_Name = {
    Text = "상태@가시여왕 계명_형"
  },
  State_3297_WeaponDesc = {
    Text = "상태@가시 여왕 계명_형"
  },
  State_3298_Desc = {
    Text = "이번 턴 내에서 다음 도약 효과가 반드시 발동한다."
  },
  State_3298_Name = {
    Text = "도약 확정 발동"
  },
  State_3298_WeaponDesc = {
    Text = "이번 턴 내에서 도약 효과에 조건이 필요하지 않다."
  },
  State_3301_Name = {
    Text = "상태@별들의 술 카운터"
  },
  State_3302_Desc = {
    Text = "영원한 응결을 부여한다."
  },
  State_3302_Name = {
    Text = "영원한 응결 부여"
  },
  State_3302_WeaponDesc = {
    Text = "영원한 응결을 부여한다."
  },
  State_3304_Desc = {
    Text = "매 턴 마지막으로 사용한 명령 카드에 대응하는 깨어남체가 턴 종료 시 광기 15를 획득한다. 「어머니 상」을 보유 중이라면, 다른 깨어남체도 광기 5를 추가로 획득한다."
  },
  State_3305_Desc = {
    Text = "사용 후 「영감」 [StateArg1]장을 덱에 섞어 넣는다. 「영감」: 행동력 1을 획득하고, 카드 1장을 드로우하며, 유지, 소모됨."
  },
  State_3305_Name = {
    Text = "<Rune_17:영감>"
  },
  State_3307_Name = {
    Text = "(잔여: [Layer])"
  },
  State_3308_Desc = {
    Text = "턴 시작 시, 이전 턴에 남은 손패가 2장 이상이라면, 행동력 2를 획득한다."
  },
  State_3309_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3309_Name = {
    Text = "상태@테스트 장검 죽음 저항"
  },
  State_3310_Desc = {
    Text = "이동자가 실타래드를 부여할 때, <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_3310_Name = {
    Text = "자기 봉쇄"
  },
  State_3310_WeaponDesc = {
    Text = "이동자가 실타래드를 부여할 때, <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_3312_Desc = {
    Text = "HP를 회복할 때마다 [Arg1]의 반격을 획득하며, HP가 75%를 초과하면 추가로 [Arg2]의 반격을 획득한다."
  },
  State_3313_Desc = {
    Text = "턴 시작 시 이번 턴 동안 [Arg1]의 힘을 획득한다. 카드를 1장 사용할 때마다 이번 턴 동안 [Arg2]의 힘을 잃는다."
  },
  State_3314_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3314_Name = {
    Text = "미깨어남"
  },
  State_3315_Desc = {
    Text = "매 턴 첫 번째 카드를 사용한 후, 무작위 손패 2장을 해당 카드의 원본 버전 복사본으로 변환하고, 턴 종료 시 원래대로 돌아온다."
  },
  State_3315_Name = {
    Text = "유물 미혹의 풍령"
  },
  State_3316_Desc = {
    Text = "턴 종료 시 실타래드가 유지된다."
  },
  State_3316_Name = {
    Text = "수호 방벽"
  },
  State_3316_WeaponDesc = {
    Text = "턴 종료 시 실타래드가 유지된다."
  },
  State_3317_Desc = {
    Text = "턴 종료 시 모든 실타래드를 잃는다."
  },
  State_3317_Name = {
    Text = "속박: 생부"
  },
  State_3318_Name = {
    Text = "상태@갈혈자의 아첨의 포옹 포식 식별자"
  },
  State_3323_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3323_Name = {
    Text = "상태@테스트 장검 광기"
  },
  State_3324_Desc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3324_Name = {
    Text = "임시 치명타 피해"
  },
  State_3324_WeaponDesc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3325_Desc = {
    Text = "덱을 재설정할 때마다, 이번 턴 동안 [Arg1]의 힘을 획득하는 「작살」 2장과 이번 턴 동안 [Arg2]의 경계를 획득하는 「양산」 1장을 손에 넣는다."
  },
  State_3326_Desc = {
    Text = "매 턴 첫 번째 능동 피해를 면역한다."
  },
  State_3326_Name = {Text = "견고"},
  State_3326_WeaponDesc = {
    Text = "매 턴 첫 번째 능동 피해를 면역한다."
  },
  State_3327_Desc = {
    Text = "몬스터가 사망하기 전의 HP"
  },
  State_3327_Name = {
    Text = "몬스터 사망 전 체력"
  },
  State_3327_WeaponDesc = {
    Text = "몬스터가 사망하기 전의 HP"
  },
  State_3328_Desc = {
    Text = "이번 전투에서 치명적 피해를 받을 때, 한 번 부활하며 [Layer]pt의 HP를 회복한다. 해제할 수 없다."
  },
  State_3328_Name = {
    Text = "불멸의 극락조"
  },
  State_3329_Desc = {
    Text = "매 5장의 카드를 사용할 때마다, 손에 있는 가장 왼쪽 카드의 복사본을 획득하지만, 허무와 소모가 부여된다."
  },
  State_3330_Desc = {
    Text = "카드의 행동력 소모가 [Layer]pt 증가한다. 카드를 사용한 후 이 부정 효과는 제거된다."
  },
  State_3330_Name = {
    Text = "<SlowColour:둔화 [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "카드의 행동력 소모가 [Layer]pt 증가한다."
  },
  State_3332_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해 면역 후 1스택 감소."
  },
  State_3332_Name = {
    Text = "<ParcloseColour:장벽>"
  },
  State_3335_Desc = {
    Text = "전투 시작 시, 모든 적에게 취약을 1스택 부여한다. 「정체의 저주」가 추가로 적이 받는 취약 효과를 25% 증가시킨다."
  },
  State_3335_Name = {
    Text = "석화의 눈 계령 6"
  },
  State_3336_Name = {
    Text = "상태@조지@사망 시 치유"
  },
  State_3337_Name = {
    Text = "붉은 제례"
  },
  State_3339_Desc = {
    Text = "공격력이 [Layer]pt 증가한다."
  },
  State_3339_Name = {
    Text = "임시 공격력 증가"
  },
  State_3339_WeaponDesc = {
    Text = "공격력이 [Layer]pt 증가한다."
  },
  State_3340_Desc = {
    Text = "광기 폭발을 발동한 후, 이번 전투 내에서 광기 폭발 피해가 [Arg1] 증가하며, 최대 5회 중첩된다. 최대 중첩 시 해당 광기 폭발을 발동한 깨어남체가 광기 100을 획득한다."
  },
  State_3341_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_1"
  },
  State_3341_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_1"
  },
  State_3342_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_2"
  },
  State_3342_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_2"
  },
  State_3343_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_3"
  },
  State_3343_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_3"
  },
  State_3344_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_4"
  },
  State_3344_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_4"
  },
  State_3345_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3345_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3346_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3346_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_6"
  },
  State_3347_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3347_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_2_7"
  },
  State_3348_Desc = {
    Text = "사용 후 [StateArg1]장의 카드를 드로우한다."
  },
  State_3348_Name = {
    Text = "<Rune_3_High:고급 묘수>"
  },
  State_3348_WeaponDesc = {
    Text = "사용 후 [StateArg1]장의 카드를 드로우한다."
  },
  State_3350_Desc = {
    Text = "광기 폭발을 발동한 후, 현재 HP의 10%를 잃고, 이번 턴 내에 모든 적의 힘을 [Arg1] 탈취한다."
  },
  State_3351_Name = {
    Text = "상태@덱 추가 후"
  },
  State_3352_Name = {
    Text = "유물 비전 천체의 기구 1"
  },
  State_3354_Name = {
    Text = "유물 비전 천체의 기구 2"
  },
  State_3356_Name = {
    Text = "턴 종료 시 질식 중독"
  },
  State_3357_Desc = {
    Text = "다음 턴 시작 후, 촉수 피해가 [Layer] 증가한다."
  },
  State_3357_Name = {
    Text = "지연 촉수 피해"
  },
  State_3358_Desc = {
    Text = "다음 턴 시작 후, [Layer]의 실타래드를 획득한다."
  },
  State_3358_Name = {
    Text = "잃어버린 예술 - 실타래드"
  },
  State_3359_Desc = {
    Text = "사용하는 카드 3장마다 해당 카드가 2회 발동한다."
  },
  State_3359_Name = {
    Text = "유물 별들의 술"
  },
  State_3359_WeaponDesc = {
    Text = "사용하는 카드 3장마다 해당 카드가 2회 발동한다."
  },
  State_3360_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3360_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3362_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3362_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3364_Desc = {
    Text = "획득 시 카드 1장을 선택하여, 두 개의 세 가지 선택지 강화 효과를 부여한다. (참고: 천면환상 카드 조합과 유사)"
  },
  State_3365_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3365_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3366_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3366_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3368_Desc = {
    Text = "버리기 단계 전에 행동력 소모가 5를 초과하면 돌로 변한다."
  },
  State_3368_Name = {Text = "석화"},
  State_3368_WeaponDesc = {
    Text = "버리기 단계 전에 손패를 돌로 만든다."
  },
  State_3369_Desc = {
    Text = "모든 포식 효과가 무한 포식으로 변경된다."
  },
  State_3369_Name = {
    Text = "무한 포식"
  },
  State_3369_WeaponDesc = {
    Text = "모든 포식 효과가 무한 포식으로 변경된다."
  },
  State_3370_Desc = {
    Text = "이번 스테이지 내에서 생성하는 실타래드가 [Layer]pt 감소한다."
  },
  State_3370_Name = {
    Text = "영구 경계 감소"
  },
  State_3370_WeaponDesc = {
    Text = "이번 스테이지 내에서 생성하는 실타래드가 [Layer]pt 감소한다."
  },
  State_3372_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3372_Name = {
    Text = "미깨어남"
  },
  State_3373_Desc = {
    Text = "실타래제 피해를 입힐 때, [StateArg1]장의 「상처」를 덱에 섞어 넣는다."
  },
  State_3373_Name = {Text = "질식"},
  State_3373_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_3374_Desc = {
    Text = "턴 종료 후, 스택 수만큼의 힘을 획득한다."
  },
  State_3374_Name = {Text = "분노"},
  State_3376_Desc = {
    Text = "이번 전투 내에서 광기 폭발이 주는 피해가 [Layer]pt 증가한다."
  },
  State_3376_Name = {
    Text = "광기 폭발 피해 증가"
  },
  State_3378_Desc = {
    Text = "광기 폭발을 발동한 후, 다음에 사용하는 카드가 2회 발동한다."
  },
  State_3378_Name = {
    Text = "상태@환몽 은열쇠: 폭발"
  },
  State_3379_Desc = {
    Text = "HP가 50% 미만일 때, 사슬 파괴자가 광포해진다."
  },
  State_3379_Name = {
    Text = "복수의 순간"
  },
  State_3379_WeaponDesc = {
    Text = "HP가 50% 미만일 때, 사슬 파괴자가 광포해진다."
  },
  State_3380_Desc = {
    Text = "전투 시작 시, [혼란] 1장을 덱에 섞어 넣는다."
  },
  State_3380_Name = {Text = "환혹"},
  State_3380_WeaponDesc = {
    Text = "전투 시작 시, [혼란] 1장을 덱에 섞어 넣는다."
  },
  State_3381_Name = {
    Text = "초차원 직업 초기화"
  },
  State_3382_Desc = {
    Text = "임무를 하나 획득한다. 임무 완료 후 보상을 획득한다. 【임무 이벤트 자리 표시자】"
  },
  State_3383_Name = {
    Text = "초차원 직업 초기화"
  },
  State_3385_Desc = {
    Text = "받는 능동 및 촉수 피해가 33% 감소한다."
  },
  State_3385_Name = {
    Text = "거울 방패"
  },
  State_3385_WeaponDesc = {
    Text = "받는 능동 및 촉수 피해가 33% 감소한다."
  },
  State_3386_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3386_Name = {
    Text = "상태@테스트 장검 치명타"
  },
  State_3387_Name = {
    Text = "상태@스테이지 2-3 전투 3 말풍선 1"
  },
  State_3388_Desc = {
    Text = "사용 후 [StateArg1]의 힘을 획득한다."
  },
  State_3388_Name = {
    Text = "<Rune_14:난폭>"
  },
  State_3389_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3389_Name = {
    Text = "미깨어남"
  },
  State_3390_Desc = {
    Text = "전투 시작 시, 모든 적에게 1턴간 허약과 취약을 부여한다."
  },
  State_3392_Desc = {
    Text = "획득 시 [Arg1]의 힘을 얻는다. 「배아」가 융합될 때마다, 이번 턴 내에서 [Arg2]의 힘을 얻는다."
  },
  State_3393_Desc = {
    Text = "턴 시작 시 배아 융합이 30% 증가한다. 모든 포식 효과가 무한 포식으로 변경된다."
  },
  State_3394_Name = {
    Text = "<DerivativeCardKeywords_4:「영감」> 1장을 덱에 넣기"
  },
  State_3395_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 「타격」 기본 피해가 25% 증가하고, 「방어」 기본 실타래드가 25% 증가한다. 장착한 깨어남체의 「타격」 사용 시 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 임시 <PowerIconKeywords:힘>을 획득하며, 장착한 깨어남체의 「방어」 사용 시 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg2]%>만큼의 임시 <AlertIconKeywords:경계>를 획득한다. 현재 계역이 「초차원」일 경우, 초차원 턴 진입 시 임시 <PowerIconKeywords:힘>과 임시 <AlertIconKeywords:경계>를 획득한다."
  },
  State_3395_WeaponDesc = {
    Text = "장착한 깨어남체의 「타격」 기본 피해가 25% 증가하고, 「방어」 기본 실타래드가 25% 증가한다. 장착한 깨어남체의 「타격」 사용 시 <WeaponEffect_Num:[Power:DescArg1]>의 임시 <PowerIconKeywords:힘>을 획득하며, 장착한 깨어남체의 「방어」 사용 시 <WeaponEffect_Num:[DescArg2]>의 임시 <AlertIconKeywords:경계>를 획득한다. 현재 계역이 「초차원」일 경우, 초차원 턴 진입 시 임시 <PowerIconKeywords:힘>과 임시 <AlertIconKeywords:경계>를 획득한다."
  },
  State_3397_Desc = {
    Text = "매 10번째 카드를 사용할 때마다, 촉수 피해가 [Arg1] 증가하며, 모든 촉수가 1회 공격한다."
  },
  State_3400_Desc = {
    Text = "정예 적과 보스 적의 최대 HP가 20% 감소한다."
  },
  State_3401_Desc = {
    Text = "사용 후 추가로 [StateArg1]회 발동하며, [StateArg2]의 검은 인장을 획득한다. 소모됨. 고유."
  },
  State_3401_Name = {
    Text = "<Rune_7:메아리>"
  },
  State_3402_Desc = {
    Text = "「곡괭이」 루센의 강타 피해가 [Layer]% 증가한다."
  },
  State_3402_Name = {
    Text = "강타 피해 증가"
  },
  State_3402_WeaponDesc = {
    Text = "곡괭이 루센의 강타 피해가 [Layer]% 증가한다."
  },
  State_3403_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3403_Name = {
    Text = "미깨어남"
  },
  State_3405_Name = {
    Text = "전체 적의 <PowerIconKeywords:힘> [Power:StateArg1]pt 일시 감소, 1턴 동안 획득하는 실타래드와 <PowerIconKeywords:힘> 50% 감소"
  },
  State_3406_Name = {
    Text = "<PowerIconKeywords:힘> [StateArg1]pt 획득"
  },
  State_3407_Name = {
    Text = "덱에서 카드 1장을 골라 손으로 가져오고, 해당 카드의 행동력 소모 1 감소"
  },
  State_3408_Name = {
    Text = "<Posse:[DescArg1]> 점의 은열에너지를 획득합니다. 이번 전투에서 「목을 자르는 일격」과 「천면환상」의 기본 데미지가 10% 증가합니다."
  },
  State_3409_Name = {
    Text = "깨어남체 한 명을 선택하여 광기 <Energy:[DescArg1]>pt 부여"
  },
  State_3410_Name = {
    Text = "이 카드 치명타율과 치명타 피해 50% 증가, 관통 피해를 입힘"
  },
  State_3411_Name = {
    Text = "1턴 동안 자신이 <FragileIconKeywords:손상>, <WeaknessIconKeywords:허약>, <VulnerabilityIconKeywords:취약>에 면역된다. 실타래드를 <Block:[Block:StateArg1]>pt 획득한다."
  },
  State_3412_Desc = {
    Text = "부정 상태에 면역이며, 턴 종료 또는 치명타 피격 후 1스택이 감소한다."
  },
  State_3412_Name = {
    Text = "왁스 코팅"
  },
  State_3412_WeaponDesc = {
    Text = "스택당 받는 피해가 10% 감소하며, 치명타를 받을 때마다 1스택이 감소한다."
  },
  State_3415_Desc = {
    Text = "획득 시 3개의 부패 각인 중 1개를 선택하여 획득한다. 부패 각인은 일반 각인보다 강력하지만, 사용 시 카드를 소모한다."
  },
  State_3415_Name = {
    Text = "유물 비취 탁본"
  },
  State_3415_WeaponDesc = {
    Text = "획득 시 3개의 부패 각인 중 1개를 선택하여 획득한다. 부패 각인은 일반 각인보다 강력하지만, 사용 시 카드를 소모한다."
  },
  State_3416_Desc = {
    Text = "팀 유니크: 전투 시작 후, 장착자 방어력의 <WeaponEffect_Num:[StateArg1]%> 에 해당하는 반격 획득. <DeathResistanceIconKeywords: 죽음 저항> 발동 후, 최대 총 2중첩의 「요람」 획득: 전체 아군이 주는 방어막와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가하며, 턴 종료 시 1중첩 제거. 현재 영역이 「혈육」이면, <DeathResistanceIconKeywords: 죽음 저항> 발동 후 배아 융합 <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "전투 시작 후, <WeaponEffect_Num:[Counterattack:DescArg1]> 중첩의 반격 획득. <DeathResistanceIconKeywords: 죽음 저항> 발동 후, 최대 총 2중첩의 「요람」 획득: 전체 아군이 주는 방어막와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가하며, 턴 종료 시 1중첩 제거. 현재 영역이 「혈육」이면, <DeathResistanceIconKeywords: 죽음 저항> 발동 후 배아 융합 <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "턴 종료 후, 임시 힘을 잃는다."
  },
  State_3418_Name = {
    Text = "지연 쇠약"
  },
  State_3419_Desc = {
    Text = "획득 시 고급 또는 저주 각인이 있는 카드 3장을 표시하고, 1장을 선택하여 해당 각인을 부여한다."
  },
  State_3420_Desc = {
    Text = "행동할 때마다 출혈을 부여하며, 치유로 출혈 스택을 절반으로 감소시킬 수 있다."
  },
  State_3420_Name = {Text = "혈흔"},
  State_3420_WeaponDesc = {
    Text = "행동할 때마다 출혈을 부여하며, 치유로 출혈 스택을 절반으로 감소시킬 수 있다."
  },
  State_3421_Desc = {
    Text = "턴 시작 시, 이번 턴에 [Arg1]의 힘을 획득하는 「작살」 1장을 손에 넣는다. 광기 폭발을 발동한 후, 손에 있는 모든 「작살」의 힘을 [Arg2] 증가시킨다."
  },
  State_3422_Name = {
    Text = "상태@장식품 무구한 묵시록"
  },
  State_3422_WeaponDesc = {
    Text = "열쇠 지령 발동 후, [DescArg1]의 HP를 회복한다. 장착한 깨어남체의 은열쇠 충전 등급이 20을 초과할 경우, [DescArg1]의 HP를 추가로 회복한다. 동일한 효과는 중복 적용되지 않는다."
  },
  State_3423_Desc = {
    Text = "영역 숙련 100, 피해를 입힐 때 임시 촉수 피해를 추가로 부여한다."
  },
  State_3423_Name = {
    Text = "시령추「몽마」"
  },
  State_3424_Desc = {
    Text = "턴 시작 시, 이전 턴에 카드를 3장 이상 사용했다면, 카드 2장을 드로우한다."
  },
  State_3425_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 의도를 「궁지 생존」으로 변경한다: 손상, 허약 및 중독 상태를 제거하고, 아군 팀에 허약과 손상 99스택을 부여한다."
  },
  State_3425_Name = {
    Text = "복수의 순간"
  },
  State_3425_WeaponDesc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 의도를 「궁지 생존」으로 변경한다: 손상, 허약 및 중독 상태를 제거하고, 아군 팀에 허약과 손상 99스택을 부여한다."
  },
  State_3429_Desc = {
    Text = "행동할 때마다 출혈을 부여하며, 치유로 출혈 효과를 제거할 수 있다."
  },
  State_3429_Name = {Text = "중상"},
  State_3429_WeaponDesc = {
    Text = "행동할 때마다 출혈을 부여하며, 치유로 출혈 효과를 제거할 수 있다."
  },
  State_3430_Desc = {
    Text = "광기 폭발을 사용한 후, [Arg1]의 반격을 획득한다. 이번 전투 중 6번째로 발동될 경우, 반격 수치가 2배가 된다."
  },
  State_3431_Name = {
    Text = "중독 면역"
  },
  State_3432_Desc = {
    Text = "버릴 때 소모된다."
  },
  State_3432_Name = {
    Text = "카드 버리기 소모"
  },
  State_3432_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_3434_Name = {
    Text = "상태@일반 취약 부여 보정"
  },
  State_3436_Desc = {
    Text = "[Layer]명의 깨어남체가 사냥당하고 있다."
  },
  State_3436_Name = {
    Text = "사냥당함"
  },
  State_3437_Desc = {
    Text = "상태@몬스터 고래 도약 환영 행성 초자_혼돈의 짐승"
  },
  State_3437_Name = {
    Text = "상태@몬스터 고래 도약 환영 행성 초자_혼돈의 짐승"
  },
  State_3437_WeaponDesc = {
    Text = "상태@몬스터 고래 도약 환영 행성 초자_혼돈의 짐승"
  },
  State_3438_Desc = {
    Text = "[StateArg1]의 임시 힘을 획득한다."
  },
  State_3438_Name = {
    Text = "<CardKeyWord:기계 무장-검>"
  },
  State_3439_Desc = {
    Text = "턴 종료 시 툴루가 광기 5를 획득한다."
  },
  State_3439_Name = {
    Text = "별들의 제자리 찾음"
  },
  State_3440_Name = {
    Text = "황금 가이드"
  },
  State_3441_Desc = {
    Text = "홀수 턴에 손패가 0장일 때, 카드 2장을 드로우한다. 짝수 턴에 행동력이 0일 때, 행동력 2를 획득한다."
  },
  State_3441_Name = {
    Text = "이화된 낡은 퍼즐"
  },
  State_3441_WeaponDesc = {
    Text = "홀수 턴에 손패가 0장일 때, 카드 2장을 드로우한다. 짝수 턴에 행동력이 0일 때, 행동력 2를 획득한다."
  },
  State_3442_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 힘을 잃는다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 매 턴 최대 6회 발동한다."
  },
  State_3442_Name = {
    Text = "칠성장어의 입맞춤"
  },
  State_3444_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다."
  },
  State_3445_Desc = {
    Text = "방어력이 [Layer]% 증가한다."
  },
  State_3445_Name = {
    Text = "일반 방어력 비율 증가"
  },
  State_3445_WeaponDesc = {
    Text = "방어력이 [Layer]% 증가한다."
  },
  State_3446_Desc = {
    Text = "[도화선] 5스택을 보유한다. 카드를 사용하면 스택이 1 감소한다. 스택이 0이 되면 자폭하여 공격력 × 2.5의 피해를 준다."
  },
  State_3446_Name = {Text = "폭탄"},
  State_3446_WeaponDesc = {
    Text = "[도화선] 5스택을 보유한다. 카드를 사용하면 스택이 1 감소한다. 스택이 0이 되면 자폭하여 공격력 × 2.5의 피해를 준다."
  },
  State_3447_Desc = {
    Text = "[도화선] 5스택을 보유한다. 카드를 사용하면 스택이 1 감소한다. 스택이 0이 되면 자폭하여 공격력 × 2.5의 피해를 준다."
  },
  State_3447_Name = {Text = "폭탄"},
  State_3447_WeaponDesc = {
    Text = "[도화선] 5스택을 보유한다. 카드를 사용하면 스택이 1 감소한다. 스택이 0이 되면 자폭하여 공격력 × 2.5의 피해를 준다."
  },
  State_3448_Desc = {
    Text = "매 턴 종료 후, 모든 촉수를 발동한다."
  },
  State_3448_Name = {
    Text = "촉수 자동 발동"
  },
  State_3448_WeaponDesc = {
    Text = "매 턴 종료 후, 모든 촉수를 발동한다."
  },
  State_3449_Desc = {
    Text = "상태@프롤로그 광기 0_1_1 발동"
  },
  State_3449_Name = {
    Text = "상태@프롤로그 광기 0_1_1 발동"
  },
  State_3449_WeaponDesc = {
    Text = "상태@프롤로그 광기 0_1_1 발동"
  },
  State_3450_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해 면역 후 1스택 제거."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:장벽>"
  },
  State_3450_WeaponDesc = {
    Text = "받는 피해 99% 감소, 피해를 받은 후 1스택 감소."
  },
  State_3451_Desc = {
    Text = "사망 시 모든 깨어남체가 광기 10을 획득한다."
  },
  State_3451_Name = {
    Text = "죽음의 은빛 비늘"
  },
  State_3451_WeaponDesc = {
    Text = "사망 시 모든 깨어남체가 광기 10을 획득한다."
  },
  State_3452_Desc = {
    Text = "카드를 사용할 때마다 [StateArg1]의 피해를 받고 1스택을 제거한다. 턴 종료 시에도 남아 있을 경우, 「바다 속의 존재」를 부화시키며, 스택 1당 HP가 10%씩 증가한다."
  },
  State_3452_Name = {
    Text = "심연의 침식"
  },
  State_3453_Name = {
    Text = "상태@복수의 거대한 검 힘 배수"
  },
  State_3455_Desc = {
    Text = "상태@프롤로그 광기 초기화 0_2_3 효과"
  },
  State_3455_Name = {
    Text = "상태@프롤로그 광기 초기화 0_2_3 효과"
  },
  State_3455_WeaponDesc = {
    Text = "상태@프롤로그 광기 초기화 0_2_3 효과"
  },
  State_3456_Desc = {
    Text = "[방어]가 [StateArg1]스택의 반격을 획득한다."
  },
  State_3456_Name = {
    Text = "유물 쐐기풀 조끼"
  },
  State_3457_Name = {
    Text = "취약 면역"
  },
  State_3458_Desc = {
    Text = "[타격]과 [방어]를 사용한 후, 해당 깨어남체가 광기 35를 획득한다. 단, 해당 카드들의 행동력 소모가 1 증가한다."
  },
  State_3459_Desc = {
    Text = "이번 전투 내에서 광기 폭발이 주는 피해가 [Layer]pt 증가한다."
  },
  State_3459_Name = {
    Text = "광기 폭발 피해 증가"
  },
  State_3461_Desc = {
    Text = "5번째로 입히는 피해는 반드시 치명타로 적중한다."
  },
  State_3462_Name = {
    Text = "상태@복수의 거대한 검 힘 3배수"
  },
  State_3463_Name = {
    Text = "상태@복수의 거대한 검 힘 배율 2"
  },
  State_3464_Desc = {
    Text = "촉수 상한이 1 증가한다. HP가 50% 미만일 때, 촉수 피해가 [Arg1] 증가한다."
  },
  State_3465_Desc = {
    Text = "해당 카드는 전투에서 사용되며, 스테이지 내에서 유효하다."
  },
  State_3465_Name = {
    Text = "<CardKeyWord:영속>"
  },
  State_3465_WeaponDesc = {
    Text = "해당 카드는 전투에서 가지고 나갈 수 있으며, 스테이지 내에서 유효하다."
  },
  State_3466_Desc = {
    Text = "획득 시 깨어남체 1명을 선택하여 깨어남시키면, 해당 깨어남체의 깨어남 카드 행동력 소모가 영구적으로 1 감소한다."
  },
  State_34671_Desc = {
    Text = "사용 후 손으로 되돌아온다."
  },
  State_34671_Name = {
    Text = "<CardKeyWord:회수>"
  },
  State_34685_Name = {
    Text = "폭탄 2 플레이어"
  },
  State_34689_Desc = {
    Text = "HP 1을 잃을 때마다 <PainWord:인내> 1스택을 획득하며, 상한은 최대 HP의 100%이다. 인내는 다음 전투로 이월된다."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:인내>"
  },
  State_3468_Desc = {
    Text = "상태@불량품의 원한"
  },
  State_3468_Name = {
    Text = "상태@불량품의 원한"
  },
  State_3468_WeaponDesc = {
    Text = "상태@불량품의 원한"
  },
  State_34691_Desc = {
    Text = "생명 1점을 잃을 때마다 <PainWord:인내> 1층을 획득합니다. 최대 [DescArg1]층. 인내는 다음 전투로 이어집니다."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:인내>"
  },
  State_34696_Desc = {
    Text = "이 카드는 모든 상황에서 손에 있으며, 손패 상한이 1 증가한다."
  },
  State_34696_Name = {
    Text = "영구 유지 및 손패 상한 무시"
  },
  State_3469_Desc = {
    Text = "가하는 능동 및 촉수 피해가 [DescArg1] % 감소."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:허약>"
  },
  State_3469_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_3470_Desc = {
    Text = "점점 석화됨 검사를 부여한다."
  },
  State_3470_Name = {
    Text = "점점 석화됨 판정 부여"
  },
  State_3470_WeaponDesc = {
    Text = "점점 석화됨 검사를 부여한다."
  },
  State_3471_Desc = {
    Text = "매 [StateArg1]번째 사용하는 카드는 2회 발동한다."
  },
  State_3471_Name = {
    Text = "상태@별들의 술 카운터"
  },
  State_3471_WeaponDesc = {
    Text = "매 [StateArg1]번째 사용하는 카드는 2회 발동한다."
  },
  State_3473_Desc = {
    Text = "HP가 50% 미만일 때, 「등불 교회 목사」가 「신강」을 기원하여 모든 신도를 흡수한 후 광포해진다."
  },
  State_3473_Name = {
    Text = "심지의 낙인"
  },
  State_3473_WeaponDesc = {
    Text = "HP가 50% 미만일 때, 「등불 교회 목사」가 「신강」을 기원하여 모든 신도를 흡수한 후 광포해진다."
  },
  State_3475_Desc = {
    Text = "[타격]과 [방어]의 행동력 소모가 1 증가한다."
  },
  State_3475_Name = {
    Text = "유물 저주받은 석비"
  },
  State_3475_WeaponDesc = {
    Text = "[타격]과 [방어]의 행동력 소모가 1 증가한다."
  },
  State_3476_Desc = {
    Text = "HP를 잃을 때마다 배아 융합이 10% 증가한다. HP가 50% 미만일 경우 효과가 2배로 증가한다."
  },
  State_3477_Desc = {
    Text = "공격을 받을 때 최대 HP의 [Layer]%를 회복하고, 최대 HP의 15%를 초과하는 피해를 받으면 기절하며 이 상태가 제거된다."
  },
  State_3477_Name = {
    Text = "검은 혼돈"
  },
  State_3478_Name = {
    Text = "상태@장식품 표준 비밀 계약"
  },
  State_3479_Desc = {
    Text = "검은 인장 1을 소모할 때마다 모든 깨어남체가 광기 1을 획득한다."
  },
  State_3479_Name = {
    Text = "유물 역생화"
  },
  State_3479_WeaponDesc = {
    Text = "검은 인장 1을 소모할 때마다 모든 깨어남체가 광기 1을 획득한다."
  },
  State_3480_Desc = {
    Text = "턴 종료 시까지, HP가 0으로 떨어지지 않는다."
  },
  State_3480_Name = {
    Text = "진주옥란 불사"
  },
  State_3480_WeaponDesc = {
    Text = "턴 종료 시까지, HP가 0으로 떨어지지 않는다."
  },
  State_3481_Desc = {
    Text = "스테이지 시작 시, 죽음 저항률과 행운의 각인률이 2배로 증가한다."
  },
  State_3481_Name = {
    Text = "상태@환몽 은열쇠: 두 배 행운"
  },
  State_3482_Desc = {
    Text = "부여하는 취약 효과가 25% 증가한다. 매 3턴마다 모든 적에게 취약을 1스택 추가한다."
  },
  State_3483_Desc = {
    Text = "행동할 때마다 출혈을 부여하며, 치유로 출혈 효과를 제거할 수 있다."
  },
  State_3483_Name = {Text = "중상"},
  State_3483_WeaponDesc = {
    Text = "행동할 때마다 출혈을 부여하며, 치유로 출혈 효과를 제거할 수 있다."
  },
  State_3484_Desc = {
    Text = "실타래제 피해를 입힐 때, 힘을 획득한다."
  },
  State_3484_Name = {
    Text = "「혼란한 인격」"
  },
  State_3485_Desc = {
    Text = "상태@등불 의식 발동"
  },
  State_3485_Name = {
    Text = "상태@등불 의식 발동"
  },
  State_3485_WeaponDesc = {
    Text = "상태@등불 의식 발동"
  },
  State_3486_Name = {
    Text = "운명의 검"
  },
  State_3488_Desc = {
    Text = "카드를 사용할 때 [StateArg1]의 피해를 받고 1스택을 제거한다. 스택이 0이 되면 약한 「바다 속의 존재」가 부화한다. 턴 종료 시에도 기생 상태가 남아 있을 경우, 스택에 비례하여 HP가 증가하는 「바다 속의 존재」가 부화한다."
  },
  State_3488_Name = {
    Text = "다중 기생됨"
  },
  State_3489_Name = {
    Text = "턴 종료 시 손패나 <DimensionalSpaceIconKeywords:초차원 공간>에 있을 경우, 「부패 녹염」으로 업그레이드"
  },
  State_3489_WeaponDesc = {
    Text = "턴 종료 시 손 또는 초차원 공간에 있으면 강화된다."
  },
  State_3490_Desc = {
    Text = "카드를 사용할 때 [StateArg1]의 피해를 받고 1스택을 제거한다. 스택이 0이 되면 약한 「바다 속의 존재」가 부화한다. 턴 종료 시에도 기생 상태가 남아 있을 경우, 스택에 비례하여 HP가 증가하는 「바다 속의 존재」가 부화한다."
  },
  State_3490_Name = {
    Text = "재기생됨"
  },
  State_3492_Desc = {
    Text = "매 짝수 턴에 아군 팀의 힘이 [Layer] 감소한다."
  },
  State_3492_Name = {Text = "힘 해제"},
  State_3495_Desc = {
    Text = "행동할 때마다 [Layer]스택의 출혈을 부여한다."
  },
  State_3495_Name = {Text = "중상"},
  State_3495_WeaponDesc = {
    Text = "행동할 때마다 [Layer]스택의 출혈을 부여하며, 치유로 출혈 효과를 제거할 수 있다."
  },
  State_34964_Desc = {
    Text = "턴 시작 후, 최대 HP의 10%만큼 <PainWord:인내>를 획득한다."
  },
  State_34964_Name = {
    Text = "영원히 기억한다"
  },
  State_3496_Name = {
    Text = "턴 종료 시 손패나 <DimensionalSpaceIconKeywords:초차원 공간>에 있을 경우, 「사멸 녹염」으로 업그레이드"
  },
  State_3496_WeaponDesc = {
    Text = "턴 종료 시 손 또는 초차원 공간에 있으면 강화된다."
  },
  State_3497_Desc = {
    Text = "팀이 서로 다른 직업의 깨어남체로 구성될 때, 팀의 HP와 모든 깨어남체의 공격력과 방어력이 200% 증가한다."
  },
  State_3497_Name = {
    Text = "믹스 매치 보너스"
  },
  State_3497_WeaponDesc = {
    Text = "팀이 서로 다른 직업의 깨어남체로 구성될 때, 팀의 HP와 모든 깨어남체의 공격력과 방어력이 200% 증가한다."
  },
  State_3499_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 생성하는 광기가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후, <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다."
  },
  State_3499_WeaponDesc = {
    Text = "장착한 깨어남체가 생성하는 광기가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후, <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다."
  },
  State_3502_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3502_Name = {
    Text = "상태@테스트 단검 광기"
  },
  State_3504_Desc = {
    Text = "매 턴 시작 시, [StateArg1]장의 카드를 드로우한다."
  },
  State_3504_Name = {
    Text = "유물 방위 나침반"
  },
  State_3504_WeaponDesc = {
    Text = "매 턴 시작 시, [StateArg1]장의 카드를 드로우한다."
  },
  State_3507_Name = {
    Text = "장식품 유기 형태"
  },
  State_3507_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 이번 턴 내에서 자신의 실타래드와 치유 강효가 2배로 증가한다."
  },
  State_3508_Name = {
    Text = "장식품 소녀의 번데기"
  },
  State_3508_WeaponDesc = {
    Text = "전투 시작 후, 장착한 깨어남체의 직업이 혼돈일 경우 공격력이 25% 증가한다."
  },
  State_3510_Desc = {
    Text = "깨어남체가 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_3510_Name = {
    Text = "<AlertColour:경계>"
  },
  State_3511_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3511_Name = {
    Text = "상태@테스트 장검 행운"
  },
  State_35120_Desc = {
    Text = "능동 피해를 1회 받을 때마다 피해 출처에 [StateArg1] 스택의 중독을 부여하며, [Layer] 턴 동안 지속됩니다."
  },
  State_35120_Name = {
    Text = "진흙 위의 불멸의 꽃"
  },
  State_3512_Name = {
    Text = "임시 손상 면역"
  },
  State_3514_Desc = {
    Text = "턴 종료 시 동일한 스택 수만큼의 <FixedDamage:순수 피해>를 받고 해당 상태를 제거한다."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords:출혈>"
  },
  State_3514_WeaponDesc = {
    Text = "턴 시작 시 피해를 받는다."
  },
  State_35158_Name = {
    Text = "시령추「입미」"
  },
  State_3515_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3515_Name = {
    Text = "미깨어남"
  },
  State_35161_Name = {
    Text = "시령추「축적」"
  },
  State_3516_Name = {
    Text = "상태@저주 낙담"
  },
  State_3518_Desc = {
    Text = "기술사가 카드를 1장 사용할 때마다 [StateArg2]의 임시 힘을 획득한다."
  },
  State_3518_Name = {
    Text = "공연 서막"
  },
  State_3519_Desc = {
    Text = "초차원 턴이 아니더라도 매 턴마다 한 번씩 도약 효과를 발동할 수 있다."
  },
  State_3519_Name = {
    Text = "공간 왜곡기"
  },
  State_3519_WeaponDesc = {
    Text = "초차원 턴이 아니더라도 매 턴마다 한 번씩 도약 효과를 발동할 수 있다."
  },
  State_3520_Desc = {
    Text = "전투 시작 시, 깨어남체 1명을 선택하여 광기 50을 부여한다."
  },
  State_35228_Name = {
    Text = "시령추「축적」"
  },
  State_3522_Name = {
    Text = "상태@유물 작살 카운터"
  },
  State_35238_Desc = {
    Text = "팀 유일: 장착자가 생성한 방패와 중독이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 죽음 저항이 발동될 때마다 모든 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 임시 크리티컬 확률과 크리티컬 피해를 부여받는다."
  },
  State_35238_WeaponDesc = {
    Text = "장착자의 방어막과 중독이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 사망 저항이 발동할 때마다 모든 웨이크업 바디는 <WeaponEffect_Num:[StateArg2]%>의 임시 크리티컬 확률과 크리티컬 데미지를 획득합니다."
  },
  State_3523_Desc = {
    Text = "사용 후 전체 적에게 [StateArg1]턴간 허약을 부여한다."
  },
  State_3523_Name = {
    Text = "<Rune_1_High:상급 허약>"
  },
  State_3524_Desc = {
    Text = "받는 피해가 [Layer]pt 증가한다."
  },
  State_3524_Name = {
    Text = "융식 상처"
  },
  State_3524_WeaponDesc = {
    Text = "받는 피해가 [Layer]pt 증가한다."
  },
  State_3525_Desc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다, 그들에게 [속박] 2스택을 부여한다."
  },
  State_3525_Name = {
    Text = "「동구 특공」"
  },
  State_3525_WeaponDesc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다, 그들에게 [속박] 2스택을 부여한다."
  },
  State_35264_Desc = {
    Text = "이번 턴에 카드를 1장 사용할 때마다 「기술사」가 환영 1스택을 획득한다."
  },
  State_35264_Name = {
    Text = "이형 환영 기록"
  },
  State_35277_Name = {
    Text = "카시아의 마법 방어"
  },
  State_3527_Desc = {
    Text = "매 턴 첫 번째 명령 카드에 대응하는 깨어남체가 턴 종료 시 광기 15를 획득한다. 「헌신 정신」을 동시에 보유하고 있으면, 다른 깨어남체도 광기 5를 획득한다."
  },
  State_3528_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3528_Name = {
    Text = "상태@테스트 레이저포 계역"
  },
  State_3529_Desc = {
    Text = "모든 피해를 면역하며, 턴 시작 후 제거된다."
  },
  State_3529_Name = {
    Text = "피해 면역"
  },
  State_3530_Desc = {
    Text = "상태@행운의 탐정 올인 표식 8"
  },
  State_3530_Name = {
    Text = "상태@행운의 탐정 무모한 도박 표식 8"
  },
  State_3530_WeaponDesc = {
    Text = "상태@행운의 탐정 올인 표식 8"
  },
  State_3531_Desc = {
    Text = "팀 유일: 전투 시작 시 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다. 다른 깨어남체가 광기 폭발을 발동할 때마다, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다. 현재 계역이 「심해」일 경우, 장착한 깨어남체가 광기 폭발을 발동한 후, 공격력의 <WeaponEffect_Num:[StateArg3]%>만큼 촉수 피해를 획득한다."
  },
  State_3531_WeaponDesc = {
    Text = "전투 시작 시 장착한 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다. 다른 깨어남체가 광기 폭발을 발동할 때마다, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다. 현재 계역이 「심해」일 경우, 장착한 깨어남체가 광기 폭발을 발동한 후, 촉수 피해가 <WeaponEffect_Num:+[DescArg1]> 증가한다."
  },
  State_3532_Desc = {
    Text = "턴 시작 시 [StateArg1]의 행동력을 획득한다."
  },
  State_3532_Name = {
    Text = "유물 검은 양초 1"
  },
  State_3533_Desc = {
    Text = "반드시 시작 패에 포함된다."
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:고유>"
  },
  State_3533_WeaponDesc = {
    Text = "전투 시작 후 이 카드는 손에 잠금된다."
  },
  State_3535_Desc = {
    Text = "카드의 행동력 소모가 [Layer]pt 증가한다. 턴 종료 또는 카드 사용 후 이 부정 효과는 제거된다."
  },
  State_3535_Name = {
    Text = "<SlowColour:임시 지연 [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "카드의 행동력 소모가 [Layer]pt 증가한다."
  },
  State_3536_Name = {
    Text = "보스전에서 3회 사용 가능"
  },
  State_3537_Desc = {
    Text = "「순진한 답례」를 획득하면 각인을 1회 수행할 수 있다."
  },
  State_3537_Name = {
    Text = "상태@장1_공명4"
  },
  State_3537_WeaponDesc = {
    Text = "「순진한 답례」를 획득하면 각인을 1회 수행할 수 있다."
  },
  State_3538_Desc = {
    Text = "「순진한 답례」 사용 시 광기 획득량이 증가한다."
  },
  State_3538_Name = {
    Text = "상태@장1_공명1"
  },
  State_3538_WeaponDesc = {
    Text = "「순진한 답례」 사용 시 광기 획득량이 증가한다."
  },
  State_3539_Desc = {
    Text = "「순진한 답례」의 행동력 소모가 1 감소한다."
  },
  State_3539_Name = {
    Text = "상태@장1_공명3"
  },
  State_3539_WeaponDesc = {
    Text = "「순진한 답례」의 행동력 소모가 1 감소한다."
  },
  State_3540_Desc = {
    Text = "「순진한 답례」는 대상을 지정할 수 있다."
  },
  State_3540_Name = {
    Text = "상태@장1_공명2"
  },
  State_3540_WeaponDesc = {
    Text = "「순진한 답례」는 대상을 지정할 수 있다."
  },
  State_3541_Desc = {
    Text = "쿰이 당신들이 설치한 함정에 빠졌다."
  },
  State_3541_Name = {
    Text = "함정에 빠짐"
  },
  State_3542_Desc = {
    Text = "전투 시작 시, 덱에 각인 1개당 [Arg1]의 힘을 획득하고, 유물 1개당 [Arg2]의 HP를 회복한다."
  },
  State_3542_Name = {
    Text = "☆상회 훈장☆"
  },
  State_3545_Name = {
    Text = "무한한 별빛 저항"
  },
  State_3545_WeaponDesc = {
    Text = "카드를 1장 사용할 때마다 [StateArg1]%의 죽음 저항을 획득한다. 죽음 저항을 획득할 때, [StateArg2]의 HP를 회복한다."
  },
  State_3546_Desc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다, 그들에게 [속박] [Layer]스택을 부여한다."
  },
  State_3546_Name = {
    Text = "「동구 특공」"
  },
  State_3546_WeaponDesc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다, 그들에게 [속박] [Layer]스택을 부여한다."
  },
  State_3547_Desc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다, 그들에게 [속박] [Layer]스택을 부여한다."
  },
  State_3547_Name = {
    Text = "「동구 특공」"
  },
  State_3547_WeaponDesc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다, 그들에게 [속박] [Layer]스택을 부여한다."
  },
  State_3548_Desc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_3548_Name = {
    Text = "상태 저위 쇠약"
  },
  State_3548_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_3549_Name = {
    Text = "상태@장식품 황야의 늑대"
  },
  State_3549_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 10% 증가한다. 장착한 깨어남체의 피해 강효가 20%를 초과할 경우, 기본 피해가 추가로 10% 증가한다."
  },
  State_35503_Name = {
    Text = "시령추「만연」"
  },
  State_3551_Desc = {
    Text = "턴 시작 시, 이전 턴에 남은 손패 수가 [StateArg1]장보다 많으면 [StateArg2]의 행동력을 획득한다."
  },
  State_3551_Name = {
    Text = "유물 은백색 차분기"
  },
  State_3551_WeaponDesc = {
    Text = "턴 시작 시, 이전 턴에 남은 손패 수가 [StateArg1]장보다 많으면 [StateArg2]의 행동력을 획득한다."
  },
  State_35539_Desc = {
    Text = "받는 피해가 2배로 증가하며, [Layer]턴 동안 지속된다."
  },
  State_35539_Name = {
    Text = "여정의 유골"
  },
  State_3553_Desc = {
    Text = "치명타율이 25% 증가한다. HP를 회복한 후, 회복을 발생시킨 대상의 치명타율에 비례하여 추가로 HP 회복이 1회 발생할 수 있다."
  },
  State_3553_Name = {
    Text = "상태@환몽 은열쇠: 치명타 치유"
  },
  State_3554_Desc = {
    Text = "실타래드와 치유 효과가 [Layer]% 증가한다."
  },
  State_3554_Name = {
    Text = "실타래드 및 치유 강효"
  },
  State_3554_WeaponDesc = {
    Text = "실타래드와 치유 효과가 [Layer]% 증가한다."
  },
  State_3555_Desc = {
    Text = "획득 시 죽음 저항 100%를 획득한다. 죽음 저항이 발동된 후, 이번 전투에서 매 턴 시작 시 [Arg1]의 HP를 회복한다."
  },
  State_3555_Name = {
    Text = "인공호흡"
  },
  State_3556_Desc = {
    Text = "해당 유물 획득 시 카드 1장을 선택하고, 해당 카드의 복사본 1장을 덱에 추가한다."
  },
  State_3558_Desc = {
    Text = "턴 시작 시 검은 인장이 10 초과하면, 검은 인장 10을 소모하고, 해당 턴에 주는 피해가 2배로 증가한다."
  },
  State_3559_Desc = {
    Text = "방어되지 않은 피해를 입힐 때, 손상 1스택을 부여한다."
  },
  State_3559_Name = {
    Text = "날카로운 발톱"
  },
  State_3559_WeaponDesc = {
    Text = "실타래제 피해를 입힐 때, [StateArg1]장의 「상처」를 덱에 섞어 넣는다."
  },
  State_3561_Name = {
    Text = "상태@환몽 은열쇠: 난무 카운터"
  },
  State_3562_Desc = {
    Text = "사망 후, 다른 아군의 힘이 [Layer] 증가한다."
  },
  State_3562_Name = {
    Text = "죽음의 속삭임"
  },
  State_35635_Name = {
    Text = "상태@깨어남체 카시아 공중 물체 획득 발동 가능"
  },
  State_35636_Name = {
    Text = "상태@깨어남체 카시아 공중 물체 획득 추가"
  },
  State_3563_Desc = {
    Text = "방어되지 않은 피해를 입힐 때, [StateArg1]장의 「상처」를 덱에 섞어 넣는다."
  },
  State_3563_Name = {
    Text = "예리한 칼날"
  },
  State_3563_WeaponDesc = {
    Text = "실타래제 피해를 입힐 때, [StateArg1]장의 「상처」를 덱에 섞어 넣는다."
  },
  State_35645_Desc = {
    Text = "이번 턴의 드로우 수가 [Layer] 감소한다."
  },
  State_35645_Name = {
    Text = "드로우 감소"
  },
  State_35646_Desc = {
    Text = "이번 턴의 드로우 수가 [Layer] 감소한다."
  },
  State_35646_Name = {
    Text = "드로우 감소"
  },
  State_3564_Desc = {
    Text = "사용 후 [StateArg1]의 임시 힘을 획득하며, 해당 각인 카드도 힘 보너스를 받는다."
  },
  State_3564_Name = {
    Text = "<Rune_15_High:고급 폭발>"
  },
  State_3565_Desc = {
    Text = "조각사가 실타래드를 부여할 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_3565_Name = {
    Text = "무아의 경지"
  },
  State_3565_WeaponDesc = {
    Text = "조각사가 실타래드를 부여할 때, 촉수 피해가 [StateArg1] 증가한다."
  },
  State_3566_Desc = {
    Text = "턴 시작 시 임시 힘 3을 획득한다. [광기 폭발]이 이 임시 힘을 2배로 증가시키며, 최대 2회 중첩된다."
  },
  State_3566_Name = {
    Text = "유물 괴뱀 허물"
  },
  State_3567_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3567_Name = {
    Text = "상태@테스트 레이저포 치명타"
  },
  State_35684_Desc = {
    Text = "아군 팀이 광기 폭발을 발동한 후, 자신은 해당 턴에 힘을 잃는다. 1턴에 1회."
  },
  State_35684_Name = {
    Text = "공포의 광기"
  },
  State_35685_Desc = {
    Text = "본원 강림 발동 시, 적의 임시 힘을 감소시킨다."
  },
  State_35685_Name = {
    Text = "공포의 광기"
  },
  State_3568_Desc = {
    Text = "라모나가 피해를 줄 때, [StateArg1]의 행동력을 획득한다."
  },
  State_3568_Name = {
    Text = "제일 철학"
  },
  State_3568_WeaponDesc = {
    Text = "라모나가 피해를 줄 때, [StateArg1]의 행동력을 획득한다."
  },
  State_3570_Name = {
    Text = "다음 턴 시작 시 드로우 수 +2"
  },
  State_3571_Name = {
    Text = "임시 허약 면역"
  },
  State_3572_Desc = {
    Text = "그가 소환한 몬스터의 피해가 2배로 증가한다."
  },
  State_3572_Name = {Text = "지휘관"},
  State_3572_WeaponDesc = {
    Text = "그가 소환한 몬스터의 피해가 2배로 증가한다."
  },
  State_3573_Desc = {
    Text = "매 턴 처음 받는 피해가 5배로 증가한다."
  },
  State_3573_Name = {Text = "자부심"},
  State_3573_WeaponDesc = {
    Text = "매 턴 처음 받는 피해가 2배로 증가한다."
  },
  State_3574_Desc = {
    Text = "동일한 깨어남체의 카드를 연속으로 사용할 때마다, 해당 깨어남체가 광기 10을 획득한다."
  },
  State_35768_Name = {
    Text = "은열쇠 에너지 300pt 획득"
  },
  State_35769_Name = {
    Text = "행동력 1pt 획득"
  },
  State_35770_Name = {
    Text = "자신의 <IntoxicationIconKeywords:중독>, 봉인, <SlowIconKeywords:둔화> 상태 해제"
  },
  State_35771_Name = {
    Text = "최대 HP의 [DescArg1]%(<Block:[DescArg2]>) 실타래드 획득"
  },
  State_35772_Name = {
    Text = "보스전에서 추가로 [StateArg1]회 사용 가능"
  },
  State_35774_Desc = {
    Text = "사망 전에 셀레스트의 지원을 1회 호출하여, 모든 HP, 광기, 은열쇠 에너지를 회복한다."
  },
  State_35774_Name = {
    Text = "유토피아의 장막"
  },
  State_3577_Name = {
    Text = "광기 자동 회복 증가"
  },
  State_35809_Desc = {
    Text = "주는 피해가 [StateArg1]% 감소하며, [Layer]턴 동안 지속된다."
  },
  State_35809_Name = {
    Text = "망상의 계승자"
  },
  State_35809_WeaponDesc = {
    Text = "상태@심해 숙녀 홍차와 케이크"
  },
  State_3580_Desc = {
    Text = "[Layer]턴 동안 촉수가 주는 피해가 관통 피해가 된다."
  },
  State_3580_Name = {
    Text = "관통 촉수"
  },
  State_35811_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해의 절반만큼 <SacrificeKeyWord:헌제>를 획득하며, [Layer] 턴 동안 지속됩니다."
  },
  State_35811_Name = {
    Text = "망상의 계승자"
  },
  State_35819_Desc = {
    Text = "턴 종료 시 머피가 광기 5를 획득한다. 열쇠 지령 발동 후, 최대 HP의 2%만큼 <SacrificeKeyWord:희생>을 제거한다."
  },
  State_35819_Name = {
    Text = "홍차와 케이크"
  },
  State_3581_Desc = {
    Text = "상태@붉은 부인 권력의 원무 카운트"
  },
  State_3581_Name = {
    Text = "상태@붉은 부인 권력의 원무 카운트"
  },
  State_3582_Desc = {
    Text = "초차원 턴이 아니더라도 매 턴마다 한 번의 도약 효과를 발동할 수 있다. 발동 시 해당 깨어남체의 카드 1장을 드로우한다."
  },
  State_3582_Name = {
    Text = "이화된 공간 왜곡기"
  },
  State_3582_WeaponDesc = {
    Text = "초차원 턴이 아니더라도 매 턴마다 한 번의 도약 효과를 발동할 수 있다. 발동 시 해당 깨어남체의 카드 1장을 드로우한다."
  },
  State_3584_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3584_Name = {
    Text = "상태@테스트 단검 계역"
  },
  State_35858_Desc = {
    Text = "턴 종료 시 머피가 광기 5를 획득한다. 열쇠 지령 발동 후, 머피의 공격력의 3%만큼 촉수 피해를 획득한다."
  },
  State_35858_Name = {
    Text = "홍차와 케이크"
  },
  State_3585_Desc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 「등불 교회 목사」가 「신강」을 기원하여 모든 신도를 흡수한 후 광포해진다."
  },
  State_3585_Name = {
    Text = "심지의 낙인"
  },
  State_3585_WeaponDesc = {
    Text = "HP가 50%([StateArg1]) 미만일 때, 「등불 교회 목사」가 「신강」을 기원하여 모든 신도를 흡수한 후 광포해진다."
  },
  State_3588_Name = {
    Text = "상태@유물 아르카나 유물 행동력"
  },
  State_3589_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해 면역 후 1스택 감소."
  },
  State_3589_Name = {
    Text = "<ParcloseColour:장벽>"
  },
  State_3591_Desc = {
    Text = "팀 유니크: 장착자가 입히는 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 「방어」 시 장착자 방어력의 <WeaponEffect_Num:[StateArg2]%>에 해당하는 임시 반격을 획득하며, 보스전에서는 3배의 임시 반격을 획득합니다. 죽음 저항 발동 후, 모든 적에게 [StateArg3]% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  State_3591_Name = {
    Text = "밤의 그림자 속에서"
  },
  State_3591_WeaponDesc = {
    Text = "장착자가 입히는 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 「방어」를 사용한 후 <WeaponEffect_Num:[Counterattack:DescArg1]> 층의 임시 반격을 획득하며, 보스전에서는 3배의 임시 반격을 획득합니다. 죽음 저항 발동 후, 모든 적에게 [StateArg3]% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  State_3592_Desc = {
    Text = "촉수가 주는 피해가 증가한다."
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:촉수 피해>"
  },
  State_3592_WeaponDesc = {
    Text = "촉수가 주는 피해량이 증가한다."
  },
  State_3593_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 <IntoxicationIconKeywords:중독>이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 「타격」이 대상 적에게 공격력의 <WeaponEffect_Num:[StateArg2]%>만큼 <IntoxicationIconKeywords:중독>을 부여한다. 이 효과는 매 턴 최대 3회 발동된다."
  },
  State_3593_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 <IntoxicationIconKeywords:중독>이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 「타격」이 대상 적에게 <WeaponEffect_Num:[Poison:DescArg1]>스택의 <IntoxicationIconKeywords:중독>을 부여한다. 이 효과는 매 턴 최대 3회 발동된다."
  },
  State_3596_Name = {
    Text = "잔여 은심"
  },
  State_35970_Desc = {
    Text = "사망 후, 플레이어에게 1턴간 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  State_35970_Name = {
    Text = "조기 사망"
  },
  State_35971_Desc = {
    Text = "등장 시, 최대 HP의 50%에 해당하는 실타래드를 획득한다."
  },
  State_35971_Name = {
    Text = "알껍데기"
  },
  State_3597_Name = {
    Text = "잔여 은심"
  },
  State_3598_Name = {
    Text = "잔여 은심"
  },
  State_3599_Desc = {
    Text = "실타래제 행동력 소모가 4 이상인 카드를 1장 사용할 때, 다른 손패의 행동력 소모가 1 감소한다."
  },
  State_36006_Desc = {
    Text = "사망 후 원래 위치에 「잠의 자식」이 생성된다."
  },
  State_36006_Name = {Text = "화신"},
  State_3600_Name = {
    Text = "잔여 은심"
  },
  State_36013_Desc = {
    Text = "이 상태는 <SacrificeKeyWord:희생>으로 간주되며, 다음 턴 시작 시 [Layer]스택의 <SacrificeKeyWord:희생> 상태를 획득한다."
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:지연 희생>"
  },
  State_36014_Desc = {
    Text = "턴 종료 시 [Layer]pt의 피해를 받고 <SacrificeKeyWord:희생> 스택의 50%를 제거한다."
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:희생>"
  },
  State_3601_Name = {
    Text = "상태@환몽 은열쇠: 윤무 카운터"
  },
  State_36022_Desc = {
    Text = "<SacrificeKeyWord:희생> 이외의 원인으로 피해를 받으면, 피해량의 50%만큼 <SacrificeKeyWord:희생>을 획득한다."
  },
  State_36022_Name = {Text = "참배"},
  State_36023_Desc = {
    Text = "사망 후 다른 아군이 존재할 경우, 「물의 자식」을 생성한다."
  },
  State_36023_Name = {Text = "화신"},
  State_36024_Desc = {
    Text = "사망 후 다른 아군이 존재할 경우, 「잠의 자식」을 생성한다."
  },
  State_36024_Name = {Text = "화신"},
  State_3603_Name = {
    Text = "보스전에서 2회 사용 가능하며 첫 사용 후 손으로 돌아옴"
  },
  State_3604_Desc = {
    Text = "팀이 서로 다른 직업의 깨어남체로 구성될 때, 팀의 HP와 모든 깨어남체의 공격력과 방어력이 200% 증가한다."
  },
  State_3604_Name = {
    Text = "상태@믹스 매치 보너스"
  },
  State_3604_WeaponDesc = {
    Text = "팀이 서로 다른 직업의 깨어남체로 구성될 때, 팀의 HP와 모든 깨어남체의 공격력과 방어력이 200% 증가한다."
  },
  State_3607_Desc = {
    Text = "사용 후 이번 전투에서 해당 깨어남체가 특수한 능력 향상을 획득한다. 영지 깨어남을 반복해서 사용해도 중첩되지 않는다."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:영지 깨어남>"
  },
  State_3607_WeaponDesc = {
    Text = "영지 깨어남은 사용 후 이번 전투에서 해당 깨어남체가 특수한 능력 향상을 획득할 수 있다. 단, 반복해서 사용한 영지 깨어남은 중첩되어 발동되지 않는다."
  },
  State_3608_Name = {
    Text = "전체 아군이 [StateArg1]pt 광기 획득"
  },
  State_36092_Desc = {
    Text = "사망 후 다른 아군이 존재할 경우, 원래 위치에 「물의 자식」을 생성한다."
  },
  State_36092_Name = {Text = "화신"},
  State_36093_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 감소한다. 스택이 0이 되면, 몬스터 턴 종료 후 「물의 자식」 1개를 소환하고, [DescArg1]스택의 「물의 숙주」를 다시 획득한다. 최대 4개의 「물의 자식」까지 존재할 수 있다."
  },
  State_36093_Name = {
    Text = "물의 숙주"
  },
  State_36094_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 감소한다. 스택이 0이 되면, 「영각의 자식」 1개를 소환하고, [DescArg1]스택의 「산호 숙주」를 다시 획득한다. 최대 4개까지 존재할 수 있다."
  },
  State_36094_Name = {
    Text = "영각 숙주"
  },
  State_3609_Name = {
    Text = "보스전에서 2회 사용 가능하며, 첫 사용 후 손으로 돌아오고, 다시 뽑은 카드의 이번 턴 행동력 소모 1 감소"
  },
  State_36111_Desc = {
    Text = "사망 후, 「산호 증식」 1장을 플레이어의 손에 넣는다."
  },
  State_36111_Name = {
    Text = "산호 증식"
  },
  State_3611_Desc = {
    Text = "상태@프롤로그 몬스터 패시브12"
  },
  State_3611_Name = {
    Text = "상태@프롤로그 몬스터 패시브12"
  },
  State_3611_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브12"
  },
  State_36124_Desc = {
    Text = "턴 종료 후 [Layer]의 피해를 받고 「희생」 스택의 50%가 감소한다."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:희생>"
  },
  State_3612_Desc = {
    Text = "상태@프롤로그 몬스터 패시브13"
  },
  State_3612_Name = {
    Text = "상태@프롤로그 몬스터 패시브13"
  },
  State_3612_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브13"
  },
  State_36136_Name = {
    Text = "손에 있는 동안, 다른 카드를 1장 사용할 때마다 [StateArg1] 포인트의 <FixedDamage:순수 피해>를 받습니다."
  },
  State_3613_Desc = {
    Text = "상태@프롤로그 몬스터 패시브10"
  },
  State_3613_Name = {
    Text = "상태@프롤로그 몬스터 패시브10"
  },
  State_3613_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브10"
  },
  State_3614_Desc = {
    Text = "상태@프롤로그 몬스터 패시브11"
  },
  State_3614_Name = {
    Text = "상태@프롤로그 몬스터 패시브11"
  },
  State_3614_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브11"
  },
  State_36152_Desc = {
    Text = "턴 종료 시 스택 수만큼 피해를 받은 후, <SacrificeKeyWord:희생> 스택의 50%를 제거한다. 희생은 다음 전투로 이월된다."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:희생>"
  },
  State_3615_Desc = {
    Text = "상태@프롤로그 몬스터 패시브16"
  },
  State_3615_Name = {
    Text = "상태@프롤로그 몬스터 패시브16"
  },
  State_3615_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브16"
  },
  State_3616_Desc = {
    Text = "상태@프롤로그 몬스터 패시브14"
  },
  State_3616_Name = {
    Text = "상태@프롤로그 몬스터 패시브14"
  },
  State_3616_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브14"
  },
  State_36173_Name = {
    Text = "보스전에서 [DescArg1]회 사용 가능"
  },
  State_36174_Name = {
    Text = "(잔여 횟수: [Layer])"
  },
  State_3617_Desc = {
    Text = "상태@프롤로그 몬스터 패시브15"
  },
  State_3617_Name = {
    Text = "상태@프롤로그 몬스터 패시브15"
  },
  State_3617_WeaponDesc = {
    Text = "상태@프롤로그 몬스터 패시브15"
  },
  State_36182_Name = {
    Text = "최대 HP의 [DescArg1]%(<Block:[DescArg2]>) 실타래드 및 동일한 양의 HP 회복, 실타래드는 잃은 HP에 비례하여 증가"
  },
  State_3618_Desc = {
    Text = "실타래제 피해를 받을 때 실타래드를 획득한다."
  },
  State_3618_Name = {Text = "버퍼"},
  State_3618_WeaponDesc = {
    Text = "실타래제 피해를 받을 때 실타래드를 획득한다."
  },
  State_36196_Desc = {
    Text = "로탄의 「타격」 피해가 30% 증가한다."
  },
  State_36196_Name = {
    Text = "불기의 검풍"
  },
  State_3619_Desc = {
    Text = "상태@청염 무사 타격 방어"
  },
  State_3619_Name = {
    Text = "상태@청염무사 타격 방어"
  },
  State_3619_WeaponDesc = {
    Text = "상태@청염 무사 타격 방어"
  },
  State_3620_Desc = {
    Text = "증상 카드를 획득할 때마다, 최대 HP가 [Arg1] 증가한다."
  },
  State_3621_Desc = {
    Text = "원초 신도가 카드를 1장 사용할 때마다 [StateArg1]장의 카드를 드로우하고, 모든 적의 중독을 5% 발동시킨다."
  },
  State_3621_Name = {
    Text = "잊혀진 집념"
  },
  State_3621_WeaponDesc = {
    Text = "원초 신도가 카드를 1장 사용할 때마다 [StateArg1]장의 카드를 드로우한다."
  },
  State_3622_Desc = {
    Text = "「폭주 해골 사냥꾼」과 「사자」의 스킬 효과를 강화한다. 매 턴 시작 시 [StateArg1]의 임시 힘을 획득하며, 「사냥의 표식」 1스택당 추가로 [StateArg1]씩 증가한다."
  },
  State_3622_Name = {
    Text = "사냥의 표식"
  },
  State_36242_Desc = {
    Text = "전투 시작 후 [StateArg1]의 실타래드를 획득한다. HP를 잃으면, 「성아」가 깊은 잠에서 깨어나 울기 시작한다."
  },
  State_36242_Name = {Text = "숙면"},
  State_3624_Desc = {
    Text = "상태@지자 공세 연습 힘 감소"
  },
  State_3624_Name = {
    Text = "상태@지자 공세 추진 힘 감소"
  },
  State_3625_Desc = {
    Text = "실타래드를 보유하고 있을 때 주는 피해가 [Arg1] 증가한다. 실타래드가 현재 HP보다 높을 때 주는 피해가 추가로 [Arg2] 증가한다."
  },
  State_36263_Desc = {
    Text = "더 이상 피해를 받지 않으며, 「수태의 씨앗」 발동을 준비한다."
  },
  State_36263_Name = {Text = "면역"},
  State_3628_Name = {
    Text = "상태@사용 후 방어 붕괴"
  },
  State_3629_Name = {
    Text = "카드 2장 뽑음"
  },
  State_3630_Name = {
    Text = "전체 적에게 <VulnerabilityIconKeywords:취약>을 2스택 부여한다."
  },
  State_36315_Desc = {
    Text = "턴 종료 시 [Layer]의 힘을 획득한다."
  },
  State_36315_Name = {
    Text = "신의 은총"
  },
  State_3631_Name = {
    Text = "행동력 2pt 획득"
  },
  State_3632_Name = {
    Text = "광기 <Energy:[DescArg1]>pt 획득"
  },
  State_36332_Desc = {
    Text = "매 턴 시작 시, 신모 권능 1스택을 획득하거나 신모 권능을 소모하여 머피의 도움을 1회 받을 수 있다."
  },
  State_36332_Name = {
    Text = "신모 권능"
  },
  State_36334_Desc = {
    Text = "매 턴 종료 시 촉수 1개를 획득한다."
  },
  State_36334_Name = {
    Text = "레무리아의 부름"
  },
  State_3633_Name = {
    Text = "전체 적에게 <WeaknessIconKeywords:허약> 2스택 부여"
  },
  State_36346_Desc = {
    Text = "HP가 0으로 감소할 때, HP를 1로 만들고 더 이상 피해를 받지 않으며, 「수태의 씨앗」 발동을 준비한다."
  },
  State_36346_Name = {
    Text = "수태의 씨앗"
  },
  State_3634_Name = {
    Text = "<DerivativeCardKeywords_4:「영감」> 2장을 덱에 넣기"
  },
  State_3635_Name = {
    Text = "다른 깨어남체가 광기 <Energy:[DescArg1]>pt 획득"
  },
  State_36360_Desc = {
    Text = "턴 시작 후 [DescArg1]% 확률로 촉수 집결 1스택을 획득한다. 100%를 초과할 경우 여러 스택을 획득할 수 있다."
  },
  State_36360_Name = {Text = "해귀선"},
  State_36361_Desc = {
    Text = "등장 시, 다른 아군이 [Layer]의 힘을 획득한다."
  },
  State_36361_Name = {
    Text = "신강 기형"
  },
  State_3636_Desc = {
    Text = "상태@유물 미혹의 풍령 발동"
  },
  State_3636_Name = {
    Text = "상태@유물 미혹의 풍령 발동"
  },
  State_3637_Desc = {
    Text = "HP가 25% 미만이고 사망하지 않았을 때, 즉시 [Arg1]의 HP를 회복한다. 3회 발동 후 영구적으로 무효화된다."
  },
  State_3637_Name = {
    Text = "☆비상식량☆"
  },
  State_3638_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해 면역 후 1스택 감소."
  },
  State_3638_Name = {
    Text = "<ParcloseColour:장벽>"
  },
  State_3638_WeaponDesc = {
    Text = "받는 피해 99% 감소, 피해를 받을 때마다 1스택 감소."
  },
  State_3639_Desc = {
    Text = "라모나가 피해를 줄 때, [StateArg1]의 행동력을 획득한다."
  },
  State_3639_Name = {
    Text = "제삼 철학"
  },
  State_3639_WeaponDesc = {
    Text = "라모나가 피해를 줄 때, [StateArg1]의 행동력을 획득한다."
  },
  State_3641_Desc = {
    Text = "「미완성된 밀랍상」에서 카드 1장을 선택하여 행동력 소모가 1 감소한다."
  },
  State_3641_Name = {
    Text = "상태@장2_공명_기본 효과"
  },
  State_3641_WeaponDesc = {
    Text = "「미완성된 밀랍상」 노드에서 카드 복제 시 등급이 1 증가한다."
  },
  State_3642_Desc = {
    Text = "HP를 잃을 때마다 [Arg1]스택의 반격을 획득한다. 단일 턴 내에서 3번째로 발동될 경우, 모든 적에게 반격 수치만큼 피해를 1회 준다."
  },
  State_3642_Name = {
    Text = "옛 친구의 회중시계"
  },
  State_3646_Desc = {
    Text = "HP가 1 아래로 떨어지지 않으며, 치명적 피해를 받으면 의도를 궁지 생존으로 대체한다. 【궁지 생존】: 최대 HP의 100%를 회복하고, 힘이 2배로 증가하며, 후속 스킬을 강화한다."
  },
  State_3646_Name = {
    Text = "궁지 생존"
  },
  State_3647_Name = {
    Text = "상태@유물 아르카나 기록 카운터"
  },
  State_3648_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 HP 회복 효과가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 턴 시작 시, 이전 턴에 잃은 HP의 <WeaponEffect_Num:[StateArg1]%>만큼 임시 <PowerIconKeywords:힘>과 실타래드를 획득한다."
  },
  State_3648_WeaponDesc = {
    Text = "장착한 깨어남체의 HP 회복 효과가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 턴 시작 시, 이전 턴에 잃은 HP의 <WeaponEffect_Num:[StateArg1]%>만큼 임시 <PowerIconKeywords:힘>과 실타래드를 획득한다."
  },
  State_3649_Desc = {
    Text = "팀에 있는 [초차원] 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_3649_Name = {
    Text = "초차원 보너스"
  },
  State_3649_WeaponDesc = {
    Text = "팀에 있는 [초차원] 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_3651_Desc = {
    Text = "사용 전에 카드의 행동력 변경"
  },
  State_3651_Name = {
    Text = "사용 전 카드 행동력 변경"
  },
  State_3651_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_3652_Desc = {
    Text = "턴 시작 시, 이전 턴에 사용한 카드 수가 [StateArg1]장을 초과하면 [StateArg2]장의 카드를 드로우한다."
  },
  State_3652_Name = {
    Text = "유물 마술 장갑"
  },
  State_3652_WeaponDesc = {
    Text = "턴 시작 시, 이전 턴에 사용한 카드 수가 [StateArg1]장을 초과하면 [StateArg2]장의 카드를 드로우한다."
  },
  State_3653_Name = {
    Text = "유물 파편화된 전기 2"
  },
  State_3654_Desc = {
    Text = "턴 시작 후 [Layer]%의 임시 치명타율을 획득한다."
  },
  State_3654_Name = {
    Text = "서서히 퍼지는 선율"
  },
  State_3654_WeaponDesc = {
    Text = "다음 턴 시작 전까지 HP를 잃지 않으면, 다음 턴의 치명타율이 [StateArg1]% 증가한다."
  },
  State_3656_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3656_Name = {
    Text = "미깨어남"
  },
  State_3658_Desc = {
    Text = "손패의 마지막 1장을 사용할 때, 카드 2장을 드로우한다. 매 턴 최대 2회 발동할 수 있다."
  },
  State_3659_Name = {
    Text = "상태@타격 카드 치명타율 및 치명타 피해 증가"
  },
  State_36613_Name = {
    Text = "상태@장식품 데우스 엑스 마키나 카운터"
  },
  State_3661_Desc = {
    Text = "실타래제 피해를 받으면 깊은 융식 스택이 증가한다."
  },
  State_3661_Name = {
    Text = "피해를 받을 시 깊은 융식 스택 증가"
  },
  State_3661_WeaponDesc = {
    Text = "실타래제 피해를 받으면 깊은 융식 스택이 증가한다."
  },
  State_3662_Desc = {
    Text = "이번 전투 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3662_Name = {
    Text = "치명타 피해"
  },
  State_3662_WeaponDesc = {
    Text = "이번 전투 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_36631_Desc = {
    Text = "광기 폭발을 발동할 때마다 「잉태」 1스택이 증가하며, 잉태 1스택당 [StateArg1]의 힘을 획득한다. 최대 5스택까지 증가할 수 있다."
  },
  State_36631_Name = {
    Text = "가잉 주인"
  },
  State_36635_Desc = {
    Text = "광기 폭발을 발동할 때마다 「잉태」 1스택이 증가하며, 잉태 1스택당 [StateArg1]의 힘을 획득한다. 최대 5스택까지 증가할 수 있다."
  },
  State_36635_Name = {
    Text = "레무리아의 최종 강신"
  },
  State_36636_Desc = {
    Text = "5스택에 도달하면, 「레무리아의 영광!」을 발동하여 높은 피해를 주고 권속을 소환한다."
  },
  State_36636_Name = {Text = "잉태"},
  State_36637_Desc = {
    Text = "5스택에 도달하면, 「레무리아를 위하여!」를 발동하여 높은 피해를 주고 권속을 소환한다."
  },
  State_36637_Name = {Text = "잉태"},
  State_3663_Desc = {
    Text = "매 턴 첫 번째 카드를 사용한 후, 해당 깨어남체의 「타격」 1장을 손에 넣는다."
  },
  State_3664_Desc = {
    Text = "사용 후 광기 5를 획득한다."
  },
  State_3664_Name = {Text = "추념"},
  State_3664_WeaponDesc = {
    Text = "사용 후 광기 5를 획득한다."
  },
  State_3665_Desc = {
    Text = "배아 융합이 상한에 도달하면, 「배아」 1장을 손패에 추가합니다."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:배아 융합>"
  },
  State_3666_Desc = {
    Text = "치명타율이 [Layer]% 증가한다."
  },
  State_3666_Name = {
    Text = "치명타율"
  },
  State_3666_WeaponDesc = {
    Text = "치명타율이 [Layer]% 증가한다."
  },
  State_36670_Name = {
    Text = "상태@장식품 재진화 카운터"
  },
  State_36670_WeaponDesc = {
    Text = "장착한 깨어남체의 턴 종료 후 광기 3을 획득한다. 장착한 깨어남체의 광기 회충량이 10을 초과할 경우, 광기 2를 추가로 획득한다."
  },
  State_3667_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg4]%> 증가한다. 장착한 깨어남체가 카드를 사용하면 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg1]%>만큼의 <RetaliateIconKeywords:반격>을 획득하며, 매 턴 최대 2회 발동된다. 해당 카드가 초차원 공간에 진입했다면, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 추가로 획득한다. 광기 폭발을 발동한 후, 모든 적이 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg3]%>만큼의 임시 힘을 잃는다."
  },
  State_3667_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 <RetaliateIconKeywords:반격>이 <WeaponEffect_Num:[StateArg4]%> 증가한다. 장착한 깨어남체가 카드를 사용하면 <WeaponEffect_Num:[Counterattack:DescArg1]>의 <RetaliateIconKeywords:반격>을 획득하며, 매 턴 최대 2회 발동된다. 해당 카드가 초차원 공간에 진입했다면, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 추가로 획득한다. 광기 폭발을 발동한 후, 모든 적의 임시 힘이 <WeaponEffect_Num:[Power:DescArg2]> 감소한다."
  },
  State_3668_Desc = {
    Text = "상태@이화된 정원의 수호자 표식"
  },
  State_3668_Name = {
    Text = "상태@이화된 정원의 수호자 표식"
  },
  State_3668_WeaponDesc = {
    Text = "상태@이화된 정원의 수호자 표식"
  },
  State_3669_Desc = {
    Text = "[Layer]턴 동안 허약, 취약 및 취약 상태에 면역된다."
  },
  State_3669_Name = {
    Text = "<BlessingColour:축복>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer]턴 동안 부여되는 부정 상태를 면역한다."
  },
  State_36710_Name = {
    Text = "차오르는 달 아래 춤"
  },
  State_3673_Desc = {
    Text = "획득 시 카드 2장을 선택하여 삭제하고, [StateArg1]의 힘을 얻는다."
  },
  State_3673_Name = {
    Text = "유물 블랙스타 연소의 잿더미"
  },
  State_3674_Desc = {
    Text = "턴 종료 시, 모든 깨어남체의 광기를 10 감소시킨다."
  },
  State_3674_Name = {Text = "적멸"},
  State_3674_WeaponDesc = {
    Text = "턴 종료 시, 모든 깨어남체의 광기를 10 감소시킨다."
  },
  State_3675_Name = {
    Text = "버린 카드 수 + 1장 드로우"
  },
  State_3676_Desc = {
    Text = "상대 턴에 받는 피해가 [Layer]% 감소한다."
  },
  State_3676_Name = {Text = "기민"},
  State_3676_WeaponDesc = {
    Text = "아군 턴에 몬스터가 받는 피해가 [Layer]% 감소한다."
  },
  State_3677_Desc = {
    Text = "방어력이 [Layer]% 증가한다."
  },
  State_3677_Name = {
    Text = "임시 방어력 비율 증가"
  },
  State_3677_WeaponDesc = {
    Text = "방어력이 [Layer]% 증가한다."
  },
  State_36781_Desc = {
    Text = "힘 감소 시, 힘 스택의 50%만 감소한다."
  },
  State_36781_Name = {
    Text = "육체화를 갈망하는 의지"
  },
  State_3678_Name = {
    Text = "상태@이벤트 유물 1"
  },
  State_36797_Desc = {
    Text = "이번 턴에, 촉수 피해가 [Layer] 감소한다."
  },
  State_36797_Name = {
    Text = "촉수 피해 감소"
  },
  State_3679_Name = {
    Text = "상태@이벤트 유물 2"
  },
  State_3680_Desc = {
    Text = "피해를 1회 입힐 때마다 대상에게 [Arg1]스택의 중독을 부여한다. 이번 전투에서 누적 25회 발동되면 즉시 모든 적의 중독을 발동시킨다."
  },
  State_3681_Desc = {
    Text = "막히지 않은 피해를 가할 때, 무작위 2장의 「명령 카드」에 [DescArg1] 층의 <BrokenCard:암중 파괴>를 부여."
  },
  State_3681_Name = {
    Text = "젠킨 깨어남!"
  },
  State_3681_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_3682_Desc = {
    Text = "HP가 10% 감소할 때마다 모든 깨어남체가 광기 10을 획득하며, 사망 후 촉수 피해가 증가한다."
  },
  State_3682_Name = {
    Text = "깊이 묻힌 은심"
  },
  State_3682_WeaponDesc = {
    Text = "HP가 10% 감소할 때마다 모든 깨어남체가 광기 10을 획득하며, 사망 후 촉수 피해가 증가한다."
  },
  State_3683_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 명령 카드가 주는 치유량이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체가 「광기 폭발」을 사용하기 전, 다른 깨어남체들이 <WeaponEffect_Num:[StateArg1]>pt의 광기를 획득한다. 아군 팀이 <VulnerabilityIconKeywords:취약> 상태일 경우, 효과가 2배로 증가한다."
  },
  State_3683_WeaponDesc = {
    Text = "장착한 깨어남체의 명령 카드가 주는 치유량이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체가 광기 폭발을 사용하기 전, 다른 깨어남체들이 <WeaponEffect_Num:[StateArg1]>pt의 광기를 획득한다. 아군 팀이 <VulnerabilityIconKeywords:취약> 상태일 경우, 효과가 2배로 증가한다."
  },
  State_3684_Desc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 의도를 「불멸의 꽃」으로 대체하고, 방어에 중점을 둔 스킬 세트를 사용한다."
  },
  State_3684_Name = {
    Text = "불멸의 꽃"
  },
  State_3684_WeaponDesc = {
    Text = "피해 1pt를 받을 때마다 1스택이 감소한다. 스택이 0이 되면 방어 모드로 전환된다."
  },
  State_3685_Desc = {
    Text = "뽑았을 때 행동력 1을 잃고, 카드 1장을 드로우한다."
  },
  State_3685_Name = {Text = "현혹"},
  State_3685_WeaponDesc = {
    Text = "뽑았을 때 행동력 1을 잃고, 카드 1장을 드로우한다."
  },
  State_3686_Desc = {
    Text = "뽑았을 때 행동력 1을 잃고, 카드 1장을 드로우한다."
  },
  State_3686_Name = {
    Text = "차원 봉인"
  },
  State_3686_WeaponDesc = {
    Text = "뽑았을 때 행동력 1을 잃고, 카드 1장을 드로우한다."
  },
  State_36884_Desc = {
    Text = "이번 전투에서 마지막 맹세는 더 이상 능동적으로 죽음 저항을 발동하여 실타래드를 획득할 수 없다."
  },
  State_36884_Name = {
    Text = "마지막 맹세"
  },
  State_3688_Desc = {
    Text = "연속으로 2회, 이전 카드보다 행동력 소모가更高的 카드를 사용할 때, 행동력 2를 획득한다."
  },
  State_3688_Name = {
    Text = "유물 아르카나 기록"
  },
  State_3688_WeaponDesc = {
    Text = "연속으로 2회, 이전 카드보다 행동력 소모가更高的 카드를 사용할 때, 행동력 2를 획득한다."
  },
  State_3689_Desc = {
    Text = "턴 시작 시 영역 숙련이 30 증가한다. 부정 상태에 있지 않을 때, 영역 숙련 증가량이 100으로 변경된다."
  },
  State_3692_Desc = {
    Text = "천 가지 모습을 가진 신비한 카드이다. 그중 필요한 것을 선택하라!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:천면환상>"
  },
  State_3692_WeaponDesc = {
    Text = "천 가지 모습을 가진 신비한 카드이다. 그중 필요한 것을 선택하라!"
  },
  State_3693_Desc = {
    Text = "치명타율이 25% 증가한다. HP를 회복한 후, 회복을 발생시킨 대상의 치명타율에 비례하여 추가로 HP 회복이 1회 발생할 수 있다."
  },
  State_3693_Name = {
    Text = "상태@환몽 은열쇠: 치명타 치유"
  },
  State_3696_Desc = {
    Text = "피해를 1회 입힐 때마다 이번 턴 내에 [Arg1]의 경계를 획득한다. 턴 시작 시 남은 실타래드가 3pt마다 이번 턴 내에 힘 1을 획득한다."
  },
  State_3696_Name = {
    Text = "시령추「은밀」"
  },
  State_3697_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다. 연속 2회, 이전 카드와 동일한 행동력 소모를 가진 카드를 사용하면 추가로 카드 1장을 드로우한다."
  },
  State_3698_Desc = {
    Text = "사용 후 카드의 복사본 [StateArg1]장을 임시 <DimensionalSpaceIconKeywords:초차원 공간>에 넣는다."
  },
  State_3698_Name = {
    Text = "<Rune_13:워프>"
  },
  State_3699_Name = {
    Text = "잔여 은심"
  },
  State_3700_Desc = {
    Text = "공격력이 [Layer]% 증가한다."
  },
  State_3700_Name = {
    Text = "임시 공격력 비율 증가"
  },
  State_3700_WeaponDesc = {
    Text = "공격력이 [Layer]% 증가한다."
  },
  State_3702_Desc = {
    Text = "상태@일반 최대 HP 변경"
  },
  State_3702_Name = {
    Text = "상태@일반 최대 HP 변경"
  },
  State_3702_WeaponDesc = {
    Text = "상태@일반 최대 HP 변경"
  },
  State_3703_Name = {
    Text = "상태@제4장 공명@다음 턴 드로우 수 2"
  },
  State_3704_Desc = {
    Text = "영역 숙련이 30 증가한다. 획득 시 유물 1개를 선택하여 이를 무작위 유물로 교체한다."
  },
  State_3705_Name = {
    Text = "해월 계령 3"
  },
  State_3707_Desc = {
    Text = "전투 시작 후 임시 복사본 [StateArg1]장을 덱에 섞어 넣는다. 원본 카드와 복사본 모두 유지된다."
  },
  State_3707_Name = {
    Text = "<Rune_8:미러>"
  },
  State_3708_Desc = {
    Text = "짝수 턴 종료 시, 남은 손패 1장당 다음 턴 시작 시 행동력 1을 획득한다."
  },
  State_3708_Name = {
    Text = "유물 선현의 단장 2"
  },
  State_3708_WeaponDesc = {
    Text = "짝수 턴 종료 시, 남은 손패 1장당 다음 턴 시작 시 행동력 1을 획득한다."
  },
  State_3709_Desc = {
    Text = "홀수 턴 종료 시, 남은 행동력 1pt당 다음 턴 시작 시 카드 1장을 드로우한다."
  },
  State_3709_Name = {
    Text = "유물 선현의 단장 1"
  },
  State_3709_WeaponDesc = {
    Text = "홀수 턴 종료 시, 남은 행동력 1pt당 다음 턴 시작 시 카드 1장을 드로우한다."
  },
  State_3711_Desc = {
    Text = "행동할 때마다 [Layer]스택의 출혈을 부여한다."
  },
  State_3711_Name = {Text = "혈흔"},
  State_3711_WeaponDesc = {
    Text = "행동할 때마다 [Layer]스택의 출혈을 부여하며, 치유로 출혈 스택을 절반으로 감소시킬 수 있다."
  },
  State_3712_Desc = {
    Text = "카드를 사용한 후 소모되며, 명령 카드는 3배의 피해와 실타래드를 생성한다. 1턴 동안 지속된다."
  },
  State_3712_Name = {Text = "용해"},
  State_3714_Desc = {
    Text = "사용 후 [StateArg1]의 실타래드를 획득한다."
  },
  State_3714_Name = {
    Text = "<Rune_6:철벽>"
  },
  State_3716_Desc = {
    Text = "이번 전투 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_3716_Name = {
    Text = "치명타율"
  },
  State_3719_Desc = {
    Text = "능동 피해를 받을 때, 촉수 반격 피해의 출처로 만들며, [Layer] 턴 동안 지속됩니다."
  },
  State_3719_Name = {
    Text = "이단의 혈통"
  },
  State_3720_Desc = {
    Text = "방어력이 [Layer]pt 증가한다."
  },
  State_3720_Name = {
    Text = "일반 방어력 증가"
  },
  State_3720_WeaponDesc = {
    Text = "방어력이 [Layer]pt 증가한다."
  },
  State_3721_Desc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않고, 덱에서 제거된다."
  },
  State_3721_Name = {Text = "소모"},
  State_3721_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_3722_Desc = {
    Text = "피해를 입힐 때마다 임시 촉수 피해가 [StateArg1] 증가하며, 최대 5회 중첩된다. 최대 중첩 시 촉수 1개를 생성한다."
  },
  State_3722_Name = {
    Text = "유물 제사장의 지팡이"
  },
  State_3722_WeaponDesc = {
    Text = "피해를 입힐 때마다 임시 촉수 피해가 [StateArg1] 증가하며, 최대 5회 중첩된다. 최대 중첩 시 촉수 1개를 생성한다."
  },
  State_3723_Name = {
    Text = "유물 흑색 거울면"
  },
  State_3724_Desc = {
    Text = "획득 시 다른 모든 유물을 잃고, 무작위로 황금 유물 2개를 획득한다."
  },
  State_3726_Name = {
    Text = "뒤틀린 시체의 광연"
  },
  State_3728_Desc = {
    Text = "전투 시작 시, [타격] 1장을 획득한다."
  },
  State_3728_Name = {
    Text = "고래 도약 계령 1"
  },
  State_3728_WeaponDesc = {
    Text = "전투 시작 시, [타격] 1장을 획득한다."
  },
  State_3730_Desc = {
    Text = "상태@몬스터 달콤한 악귀 꿀빛 비극의 환상"
  },
  State_3730_Name = {
    Text = "상태@몬스터 달콤한 악귀 꿀빛 비극의 환상"
  },
  State_3730_WeaponDesc = {
    Text = "상태@몬스터 달콤한 악귀 꿀빛 비극의 환상"
  },
  State_3731_Desc = {
    Text = "아군 팀이 상점에서 구매 후, 다음 전투에서 매 턴 카드 1장을 추가로 드로우하고 행동력 1을 획득한다."
  },
  State_3732_Desc = {
    Text = "매 3턴마다 임시 촉수 3개를 획득한다. 이 촉수는 촉수 상한을 무시한다."
  },
  State_3732_Name = {
    Text = "유물 무명의 부속지"
  },
  State_3732_WeaponDesc = {
    Text = "매 3턴마다 임시 촉수 3개를 획득한다. 이 촉수는 촉수 상한을 무시한다."
  },
  State_3733_Desc = {
    Text = "홀수 턴 종료 시, 남은 행동력이 다음 턴의 추가 드로우로 전환된다. 짝수 턴 종료 시, 남은 손패가 다음 턴의 추가 행동력으로 전환된다."
  },
  State_3735_Name = {
    Text = "아군 팀 \"중독\" 스택 절반 감소"
  },
  State_3738_Desc = {
    Text = "턴 종료 시 배아 융합이 15% 증가하며, 손에 「배아」가 있을 경우 [Arg1]의 HP를 회복한다."
  },
  State_3738_Name = {
    Text = "역병 진단서"
  },
  State_3739_Name = {
    Text = "장식품 유기 형태 효과"
  },
  State_3739_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 이번 턴 내에서 자신의 실타래드와 치유 강효가 2배로 증가한다."
  },
  State_3740_Name = {
    Text = "상태@달콤한 악귀 폭격 카운트"
  },
  State_3741_Desc = {
    Text = "3턴 시작 시, 「과거의 메아리 — 모든 손패를 버리고, 현재 HP와 실타래드가 이전 턴 종료 시의 상태로 돌아간다. 유지, 소모됨.」 1장을 손에 넣는다."
  },
  State_3742_Desc = {
    Text = "사용 후 전체 적에게 [StateArg1]턴간 취약을 부여한다."
  },
  State_3742_Name = {
    Text = "<Rune_1:취약>"
  },
  State_3743_Desc = {
    Text = "사용하는 6번째 카드는 2회 발동한다."
  },
  State_3743_Name = {
    Text = "유물 별들의 술"
  },
  State_3744_Name = {
    Text = "상태@유물 멤피스 의식 거울 카운터"
  },
  State_3747_Name = {
    Text = "덱에서 카드 1장을 골라 손으로 가져오기"
  },
  State_3748_Name = {
    Text = "가하는 피해의 치명타 확률이 [DescArg1]% 증가, 치명타 피해가 [DescArg2]% 증가"
  },
  State_3750_Name = {
    Text = "임시 치명타율 +[DescArg1]%. 이 전투에서 「경추 절단」과 「천면환상」 기본 피해 5% 증가"
  },
  State_3751_Name = {
    Text = "<PowerIconKeywords:힘> [StateArg1]pt 획득"
  },
  State_3752_Name = {
    Text = "<Posse:[DescArg1]> 점의 은열에너지를 획득했습니다. <Block:[Block:StateArg1]> 점의 방어막을 획득했습니다."
  },
  State_3753_Desc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:유지>"
  },
  State_3753_WeaponDesc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_3754_Desc = {
    Text = "능동 피해를 입힐 때, 이번 턴 내에서 촉수 피해가 [Arg1] 증가하며, 최대 3회 중첩된다. 최대 중첩 시 촉수 1개를 생성하고, 턴 종료 후 제거된다."
  },
  State_3755_Desc = {
    Text = "팀 유일: 장착자가 생성하는 방어막이 <WeaponEffect_Num:[StateArg1]%> 증가하고, 생명 회복이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 홀수 턴 종료 시 장착자의 크리티컬 확률이 +<WeaponEffect_Num:[StateArg2]%> 증가하고, <WeaponEffect_Num:[StateArg3]> 광기를 획득합니다; 짝수 턴 종료 시 장착자의 크리티컬 데미지가 +<WeaponEffect_Num:[StateArg2]%> 증가하고, <WeaponEffect_Num:[StateArg4]> 은열에너지를 획득합니다. 현재 경계역이 「혈육」인 경우, 진홍색 용광로의 축적 상한이 <WeaponEffect_Num:[StateArg5]%> 증가합니다."
  },
  State_3755_WeaponDesc = {
    Text = "장착자가 생성하는 방어막이 <WeaponEffect_Num:[StateArg1]%> 증가하고, 생명력 회복이 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 홀수 턴 종료 시 장착자의 크리티컬 확률이 +<WeaponEffect_Num:[StateArg2]%> 증가하고, 광기를 <WeaponEffect_Num:[StateArg3]> 포인트 획득합니다. 짝수 턴 종료 시 장착자의 크리티컬 데미지가 +<WeaponEffect_Num:[StateArg2]%> 증가하고, <WeaponEffect_Num:[StateArg4]> 은열에너지를 획득합니다. 현재 경계역이 ‘혈육’일 경우, 진홍색 용광로의 축적 상한치가 <WeaponEffect_Num:[StateArg5]%> 증가합니다."
  },
  State_3757_Desc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다 [StateArg1]스택의 실타래드를 획득한다. 1턴 동안 지속된다."
  },
  State_3757_Name = {
    Text = "비상하는 깃털"
  },
  State_3757_WeaponDesc = {
    Text = "아군 팀이 카드를 1장 사용할 때마다 [StateArg1]스택의 실타래드를 획득한다. 1턴 동안 지속된다."
  },
  State_3759_Name = {
    Text = "기계 장비 1"
  },
  State_3760_Desc = {
    Text = "[StateArg1] 이상의 검은 인장을 보유하고 있다면, [광기 폭발]로 [StateArg1]의 검은 인장을 잃고, 모든 적에게 1턴간 취약과 허약을 부여한다."
  },
  State_3760_Name = {
    Text = "유물 재앙 의식의 새"
  },
  State_3760_WeaponDesc = {
    Text = "[StateArg1] 이상의 검은 인장을 보유하고 있다면, [광기 폭발]로 [StateArg1]의 검은 인장을 잃고, 모든 적에게 1턴간 취약과 허약을 부여한다."
  },
  State_3761_Desc = {
    Text = "아군 팀이 「비틀거림」을 1장 드로우할 때마다, [Layer]의 힘을 획득한다."
  },
  State_3761_Name = {
    Text = "등불 의식"
  },
  State_3761_WeaponDesc = {
    Text = "아군 팀이 「비틀거림」을 1장 드로우할 때마다, [Layer]의 힘을 획득한다."
  },
  State_3763_Desc = {
    Text = "기어 다니는 자가 피해를 1회 줄 때마다, 이번 턴 동안 치명타 피해가 [StateArg3]% 증가한다."
  },
  State_3763_Name = {
    Text = "통로 접기"
  },
  State_3763_WeaponDesc = {
    Text = "기어 다니는 자가 피해를 1회 줄 때마다, 이번 턴 동안 치명타 피해가 [StateArg3]% 증가한다."
  },
  State_3764_Name = {
    Text = "기계 장비 2"
  },
  State_3766_Name = {
    Text = "핏빛 힘 배수 추가"
  },
  State_3767_Desc = {
    Text = "턴 시작 시 무작위 적에게 [Arg1]의 피해를 준다. 이번 전투에서 「타격」을 7회 사용한 후, 피해가 [Arg2]로 변경된다."
  },
  State_3767_Name = {
    Text = "낡은 퍼즐"
  },
  State_3768_Desc = {
    Text = "받은 능동 피해가 반드시 치명타로 적용되며, 턴 종료 후 제거된다."
  },
  State_3768_Name = {Text = "약점"},
  State_3768_WeaponDesc = {
    Text = "받은 능동 피해가 반드시 치명타로 적용되며, 턴 종료 후 제거된다."
  },
  State_3770_Name = {
    Text = "상태@유물 아르카나 유물 카운터"
  },
  State_3771_Desc = {
    Text = "전투 시작 시, 행동력 3을 획득한다."
  },
  State_3772_Desc = {
    Text = "복수의 거대한 칼날이 피해를 1회 줄 때마다, 현재 촉수 피해와 동일한 임시 힘을 획득한다."
  },
  State_3772_Name = {
    Text = "복수 예고"
  },
  State_3773_Desc = {
    Text = "턴 종료 시 동일한 스택 수만큼의 <FixedDamage:순수 피해>를 받는다."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:중독>"
  },
  State_3773_WeaponDesc = {
    Text = "턴 시작 시 피해를 받는다."
  },
  State_3774_Desc = {
    Text = "광기 폭발을 발동할 때마다, [Arg1]의 중독을 부여하는 「독성 감염」 1장을 획득한다. 턴 종료 시, 손에 있는 「독성 감염」 3장마다 중독을 발동하는 「독성 발작」 1장으로 합성할 수 있다."
  },
  State_3776_Desc = {
    Text = "능동 피해를 받을 때마다 「경계」가 1스택 증가한다. 「경계」가 3스택에 도달하면 후퇴한다."
  },
  State_3776_Name = {
    Text = "겁쟁이 인형"
  },
  State_3776_WeaponDesc = {
    Text = "능동 피해를 받을 때마다 「경계」가 1스택 증가한다. 「경계」가 3스택에 도달하면 후퇴한다."
  },
  State_3777_Desc = {
    Text = "사용 후 소속 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_3777_Name = {
    Text = "<Rune_5_High:고급 광화>"
  },
  State_3777_WeaponDesc = {
    Text = "사용 후 소속 깨어남체가 [StateArg1]의 광기를 획득한다."
  },
  State_3778_Desc = {
    Text = "부정 상태에 있는 적에게 주는 피해가 25% 증가하고, 적을 처치한 후 처치자가 광기 20을 획득한다."
  },
  State_3779_Desc = {
    Text = "촉수 상한이 2 감소한다. 턴 종료 시 모든 촉수가 추가로 1회 공격한다."
  },
  State_3779_Name = {
    Text = "유물 고통의 성완"
  },
  State_3779_WeaponDesc = {
    Text = "촉수 상한이 2 감소한다. 턴 종료 시 모든 촉수가 추가로 1회 공격한다."
  },
  State_3781_Desc = {
    Text = "턴 시작 시, 덱 맨 위의 카드 2장에 「정체의 저주」를 부여한다."
  },
  State_3781_Name = {
    Text = "「심연의 저주 눈」"
  },
  State_3781_WeaponDesc = {
    Text = "턴 시작 시, 덱 맨 위의 카드 2장에 「정체의 저주」를 부여한다."
  },
  State_3782_Desc = {
    Text = "팀 유일: 탐색 시작 시 장착자의 「방어」를 덱에 추가하고, 장착자의 「방어」 방어막이 <WeaponEffect_Num:[StateArg1]}> 증가합니다."
  },
  State_3782_WeaponDesc = {
    Text = "탐색이 시작될 때, 장착자의 「방어」를 덱에 추가하고, 장착자의 「방어」 방어막이 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_3783_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 광기 폭발 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다."
  },
  State_3783_WeaponDesc = {
    Text = "장착한 깨어남체의 광기 폭발 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다."
  },
  State_3784_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 명령 카드 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다."
  },
  State_3784_WeaponDesc = {
    Text = "장착한 깨어남체의 명령 카드 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다."
  },
  State_3786_Desc = {
    Text = "당신이 잠겼습니다! 사용 후 모든 몬스터가 [StateArg1]의 임시 힘을 획득하고, 해당 지령의 심해 낙인을 제거한다."
  },
  State_3786_Name = {
    Text = "<CardKeyWord:심해 마크>"
  },
  State_3786_WeaponDesc = {
    Text = "카드를 사용한 후 심해 잠수자가 [StateArg1]의 임시 힘을 획득한다."
  },
  State_3787_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 광기 폭발을 발동한 후, 모든 아군이 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다."
  },
  State_3787_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 발동한 후, 모든 아군이 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다."
  },
  State_3788_Desc = {
    Text = "팀 유일: 탐색 시작 시 장착한 깨어남체의 「타격」 1장을 덱에 추가하며, 장착한 깨어남체의 「타격」 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_3788_WeaponDesc = {
    Text = "탐색 시작 시 장착한 깨어남체의 「타격」 1장을 덱에 추가하며, 장착한 깨어남체의 「타격」 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_3790_Desc = {
    Text = "상태@불확정 물질 카운트"
  },
  State_3790_Name = {
    Text = "상태@불확정 물질 카운터"
  },
  State_3790_WeaponDesc = {
    Text = "상태@불확정 물질 카운트"
  },
  State_3791_Desc = {
    Text = "피해를 입힐 때마다 [Arg1]의 실타래드를 획득한다. 매 턴 최대 5회 중첩되며, 최대 중첩 시 「영감」 1장을 손에 넣는다."
  },
  State_3792_Desc = {
    Text = "더 이상 석화의 영향을 받지 않는다."
  },
  State_3792_Name = {
    Text = "석화 저항"
  },
  State_3792_WeaponDesc = {
    Text = "더 이상 석화 효과를 받지 않고, 대신 3배의 피해를 받는다."
  },
  State_3793_Desc = {
    Text = "이번 스테이지 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3793_Name = {
    Text = "영구 치명타 피해"
  },
  State_3793_WeaponDesc = {
    Text = "이번 스테이지 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3794_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3794_Name = {
    Text = "상태@테스트 장검 치명타 피해"
  },
  State_3796_Desc = {
    Text = "HP가 20% 감소할 때마다 모든 깨어남체가 광기 10을 획득하며, 사망 후 촉수 피해가 증가한다."
  },
  State_3796_Name = {
    Text = "석출된 은 알갱이"
  },
  State_3796_WeaponDesc = {
    Text = "HP가 20% 감소할 때마다 모든 깨어남체가 광기 10을 획득하며, 사망 후 촉수 피해가 증가한다."
  },
  State_3797_Desc = {
    Text = "피해를 받을 때마다 [StateArg1]의 임시 힘을 획득하며, 턴 시작 시 제거된다."
  },
  State_3797_Name = {
    Text = "쥐떼의 분노!"
  },
  State_37980_Desc = {
    Text = "이번 전투 내에서 영역 숙련이 [Layer] 증가한다."
  },
  State_37980_Name = {
    Text = "영역 숙련"
  },
  State_3798_Desc = {
    Text = "실타래제 피해를 입힌 후 HP를 회복한다."
  },
  State_3798_Name = {
    Text = "흡혈의 검"
  },
  State_3798_WeaponDesc = {
    Text = "실타래제 피해를 입힌 후 HP를 회복한다."
  },
  State_3799_Desc = {
    Text = "팀에 있는 [혈육] 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_3799_Name = {
    Text = "혈육 보너스"
  },
  State_3799_WeaponDesc = {
    Text = "팀에 있는 [혈육] 직업 깨어남체 1명당, 팀의 최대 HP, 방어력, 공격력이 50% 증가한다."
  },
  State_3800_Desc = {
    Text = "모든 적에게 피해를 준다. 이 피해에는 <CardKeyWord:힘>이 배수로 적용된다."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:거대한 검의 위엄>"
  },
  State_3801_Desc = {
    Text = "방어되지 않은 피해를 입혔을 때, [StateArg1]스택의 출혈을 부여한다."
  },
  State_3801_Name = {Text = "방혈"},
  State_3802_Desc = {
    Text = "손에 있을 때, 명령 카드를 1장 사용할 때마다 해당 카드의 행동력 소모가 0인 복사본으로 변한다."
  },
  State_3802_Name = {
    Text = "<CardKeyWord:성결의 자식>"
  },
  State_3802_WeaponDesc = {
    Text = "손에 있을 때, 카드를 1장 사용할 때마다 해당 카드의 행동력 소모가 0인 복사본으로 변한다."
  },
  State_3803_Desc = {
    Text = "전투 시작 시, 현재 행동력 소모가 1인 모든 카드의 이번 전투 동안 피해, 실타래드 및 치유량이 [Arg1] 증가한다."
  },
  State_3804_Desc = {
    Text = "이화된 작살 카운트"
  },
  State_3804_Name = {
    Text = "상태@이화된 작살 카운터"
  },
  State_3804_WeaponDesc = {
    Text = "이화된 작살 카운트"
  },
  State_3807_Name = {
    Text = "장식품 약재의 꿈"
  },
  State_3807_WeaponDesc = {
    Text = "전투 시작 후, 추가로 장착한 깨어남체의 한 세트 카드를 덱에 섞어 넣는다."
  },
  State_3808_Desc = {
    Text = "상태@일반 현재 HP 변경"
  },
  State_3808_Name = {
    Text = "상태@일반 현재 HP 변경"
  },
  State_3808_WeaponDesc = {
    Text = "상태@일반 현재 HP 변경"
  },
  State_3810_Desc = {
    Text = "사망 후, 다른 아군의 힘이 증가한다."
  },
  State_3810_Name = {
    Text = "죽음의 속삭임"
  },
  State_3811_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3811_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_4_1"
  },
  State_3813_Name = {
    Text = "허약 면역"
  },
  State_3815_Desc = {
    Text = "턴 종료 시 모든 깨어남체가 [Layer]pt의 광기를 잃는다."
  },
  State_3815_Name = {
    Text = "<EnergyColour:공허>"
  },
  State_3815_WeaponDesc = {
    Text = "획득하는 광기가 [Layer]% 감소한다."
  },
  State_3817_Desc = {
    Text = "턴 시작 시 상대에게 [DescArg1]의 쇠약을 부여한다."
  },
  State_3817_Name = {Text = "확산"},
  State_3817_WeaponDesc = {
    Text = "턴 시작 시, 아군 팀이 [DescArg1Layer0.01]스택의 쇠약을 획득한다."
  },
  State_3818_Name = {
    Text = "상태@지자 계령 1"
  },
  State_3819_Name = {
    Text = "사슬 파괴자 계령1"
  },
  State_3819_WeaponDesc = {
    Text = "고대자 모방"
  },
  State_3821_Desc = {
    Text = "턴 시작 시, 이전 턴에 잃은 HP의 절반만큼 실타래드를 획득한다."
  },
  State_3821_Name = {
    Text = "고통과 환희"
  },
  State_3821_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_3824_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 광기 폭발 기본 피해가 [StateArg1]% 증가한다. 탐색 시작 시, 장착한 깨어남체가 학자 인격 상태로 진입한다. 장착한 깨어남체가 광기 폭발을 발동한 후 학자 인격과 광대 인격 사이를 전환한다.\n\n학자 인격: 턴 종료 시, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다.\n\n광대 인격: 턴 종료 시, 장착한 깨어남체의 치명타율과 치명타 피해가 <WeaponEffect_Num:+[StateArg3]%> 증가한다."
  },
  State_3824_WeaponDesc = {
    Text = "장착한 깨어남체의 광기 폭발 기본 피해가 [StateArg1]% 증가한다. 탐색 시작 시, 장착한 깨어남체가 학자 인격 상태로 진입한다. 장착한 깨어남체가 광기 폭발을 발동한 후 학자 인격과 광대 인격 사이를 전환한다.\n\n학자 인격: 턴 종료 시, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다.\n\n광대 인격: 턴 종료 시, 장착한 깨어남체의 치명타율과 치명타 피해가 <WeaponEffect_Num:+[StateArg3]%> 증가한다."
  },
  State_3825_Desc = {
    Text = "능동 피해를 받을 때, 피해 원천에게 동일한 스택 수만큼의 <FixedDamage:순수 피해>를 입힌다."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords:반격>"
  },
  State_3825_WeaponDesc = {
    Text = "능동 피해를 받을 때마다, 공격자에게 <FixedDamage:순수 피해>를 입힌다."
  },
  State_3826_Name = {
    Text = "상태@환몽 은열쇠: 폭발 카운터"
  },
  State_3827_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 HP 회복량이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 광기 폭발을 사용한 후, 다음 턴 시작 시 잃은 HP의 <WeaponEffect_Num:[StateArg2]%>를 회복한다."
  },
  State_3827_WeaponDesc = {
    Text = "장착한 깨어남체의 HP 회복량이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 광기 폭발을 사용한 후, 다음 턴 시작 시 잃은 HP의 <WeaponEffect_Num:[DescArg1]%>를 회복한다."
  },
  State_3830_Name = {
    Text = "추가 1회 발동"
  },
  State_3831_Name = {
    Text = "유물 역생근"
  },
  State_3834_Desc = {
    Text = "미로 거미가 부여하는 중독이 2배로 증가한다."
  },
  State_3834_Name = {
    Text = "방황의 길"
  },
  State_3835_Desc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3835_Name = {
    Text = "임시 치명타 피해"
  },
  State_3835_WeaponDesc = {
    Text = "이번 턴 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_3836_Desc = {
    Text = "테스트123"
  },
  State_3836_Name = {
    Text = "테스트123"
  },
  State_3837_Desc = {
    Text = "팀 유니크: 장착자가 입히는 광기가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 입히는 중독이 <WeaponEffect_Num:[StateArg2]%> 증가합니다. 장착자가 능동 피해를 입힌 후, 모든 각성체의 임시 치명타 피해가 장착자의 기본 치명타 피해의 <WeaponEffect_Num:[StateArg3]%>에 해당하는 수치만큼 증가하며, 매 턴 최대 1회 발동합니다. 현재 영역이 「심해」인 경우, 전투 시작 시 최대 촉수 수량과 촉수 수량이 +1 됩니다."
  },
  State_3837_WeaponDesc = {
    Text = "장착자가 입히는 광기가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 입히는 중독이 <WeaponEffect_Num:[StateArg2]%> 증가합니다. 장착자가 능동 피해를 입힌 후 모든 각성체의 임시 치명타 피해 +<WeaponEffect_Num:[DescArg1]%>, 매 턴 최대 1회 발동합니다. 현재 영역이 「심해」인 경우, 전투 시작 시 최대 촉수 수량과 촉수 수량이 +1 됩니다."
  },
  State_3839_Desc = {
    Text = "전투 시작 시, 덱에 증상 카드가 1장 있을 때마다 [Arg1]의 힘을 획득한다. 모든 증상 카드가 허무를 획득한다."
  },
  State_3840_Desc = {
    Text = "HP가 감소할 때마다 [StateArg1]의 경계를 획득한다."
  },
  State_3840_Name = {Text = "경계"},
  State_3842_Desc = {
    Text = "가하는 능동 및 촉수 피해가 [DescArg1] % 감소."
  },
  State_3842_Name = {Text = "허약"},
  State_3842_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_3843_Desc = {
    Text = "행동할 때마다 [Layer]스택의 출혈을 부여한다."
  },
  State_3843_Name = {Text = "중상"},
  State_3843_WeaponDesc = {
    Text = "행동할 때마다 [Layer]스택의 출혈을 부여하며, 치유로 출혈 효과를 제거할 수 있다."
  },
  State_3844_Desc = {
    Text = "고래 도약의 모든 피해 횟수가 1 증가한다."
  },
  State_3844_Name = {
    Text = "전투의 욕망"
  },
  State_3844_WeaponDesc = {
    Text = "고래 도약의 모든 피해 횟수가 1 증가한다."
  },
  State_3845_Desc = {
    Text = "카드의 행동력이 감소한다."
  },
  State_3845_Name = {
    Text = "카드 행동력 감소"
  },
  State_3845_WeaponDesc = {
    Text = "카드의 행동력이 감소한다."
  },
  State_3846_Name = {
    Text = "유물 비취 탁본"
  },
  State_3848_Desc = {
    Text = "이번 전투 내에서 무작위 깨어남체 1명의 광기 폭발이 봉인되어 사용할 수 없다."
  },
  State_3848_Name = {Text = "봉인"},
  State_3850_Desc = {
    Text = "매 [StateArg1]번째 카드를 사용할 때, 촉수 피해가 [StateArg2] 증가하며, 모든 촉수가 1회 공격한다."
  },
  State_3850_Name = {
    Text = "이화된 작살"
  },
  State_3850_WeaponDesc = {
    Text = "매 [StateArg1]번째 카드를 사용할 때, 촉수 피해가 [StateArg2] 증가하며, 모든 촉수가 1회 공격한다."
  },
  State_3851_Name = {
    Text = "장식품 극장 고양이"
  },
  State_3851_WeaponDesc = {
    Text = "주는 모든 피해가 증가하며, 증가량은 장착한 깨어남체의 최대 HP의 10%에 해당한다."
  },
  State_3852_Desc = {
    Text = "물어뜯기 피해 횟수가 [Layer] 증가한다."
  },
  State_3852_Name = {
    Text = "점점 강해지는 물어뜯기"
  },
  State_3852_WeaponDesc = {
    Text = "물어뜯기 피해 횟수가 [Layer] 증가한다."
  },
  State_3853_Desc = {
    Text = "턴 시작 시 덱에 있는 무작위 명령 카드 1장의 복사본으로 변신하며, 해당 카드의 행동력 소모는 3으로 잠금된다. 턴 종료 시 원래대로 돌아온다."
  },
  State_3853_Name = {
    Text = "<CardKeyWord:섬망>"
  },
  State_3853_WeaponDesc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_3854_Desc = {
    Text = "카드 2장을 드로우하고, 동시에 해골 사냥꾼의 주의를 끈다."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:사냥당함>"
  },
  State_3855_Name = {Text = "힘"},
  State_3856_Desc = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_1"
  },
  State_3856_Name = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "상태@프롤로그 덱 초기화 0_1_3_1"
  },
  State_3859_Desc = {
    Text = "풍요의 숨결이 제공하는 광기가 2배로 증가한다."
  },
  State_3859_Name = {
    Text = "어머니의 부름"
  },
  State_3859_WeaponDesc = {
    Text = "풍요의 숨결이 제공하는 광기가 2배로 증가한다."
  },
  State_3860_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3860_Name = {
    Text = "상태@테스트 단검 행운"
  },
  State_3862_Name = {
    Text = "상태@스테이지 2-15 전투 4 말풍선 1"
  },
  State_3863_Desc = {
    Text = "3회 광기 폭발을 발동할 때마다, 모든 손패의 행동력 소모가 1 감소한다."
  },
  State_3866_Desc = {
    Text = "이번 턴에 손패 상한이 [Layer] 증가한다."
  },
  State_3866_Name = {
    Text = "최대 손패 수 증가"
  },
  State_3867_Name = {
    Text = "초차원 직업 카운터"
  },
  State_3868_Desc = {
    Text = "이번 턴 내에서 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_3868_Name = {
    Text = "임시 경계"
  },
  State_3868_WeaponDesc = {
    Text = "이번 턴 내에서 생성하는 실타래드가 [Layer]pt 증가한다."
  },
  State_3872_Desc = {
    Text = "피해를 입으면 임시 힘이 취소된다."
  },
  State_3872_Name = {Text = "약점"},
  State_38730_Desc = {
    Text = "턴 시작 후 [DescArg1]% 확률로 촉수 집결 1스택을 획득한다. 100%를 초과할 경우 여러 스택을 획득할 수 있다."
  },
  State_38730_Name = {Text = "해귀선"},
  State_38735_Desc = {
    Text = "가하는 능동 피해가 [StateArg1]% 감소하고, 공격 횟수가 2배가 되며, [Layer] 턴 동안 지속됩니다."
  },
  State_38735_Name = {Text = "잠꼬대"},
  State_38738_Desc = {
    Text = "상한은 10스택이며, 다음 전투로 이월된다."
  },
  State_38738_Name = {
    Text = "꿈의 인도"
  },
  State_3873_Desc = {
    Text = "이번 전투 내에서 영역 숙련이 [Layer]pt 증가한다."
  },
  State_3873_Name = {
    Text = "영역 숙련"
  },
  State_3874_Name = {
    Text = "상태@풍령 카드 원상복구"
  },
  State_3876_Desc = {
    Text = "매 짝수 턴에 아군 팀의 힘이 감소한다."
  },
  State_3876_Name = {
    Text = "「죽음의 구멍」"
  },
  State_3878_Desc = {
    Text = "HP 2를 잃을 때마다 다음 턴 시작 시 [Layer]pt의 실타래드를 획득한다."
  },
  State_3878_Name = {
    Text = "고통과 환희"
  },
  State_3878_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_3879_Desc = {
    Text = "획득 시 최대 HP가 [Arg1] 증가한다. 획득 시 HP가 25% 미만일 경우, 최대 HP 증가량이 [Arg2]로 변경된다."
  },
  State_3881_Desc = {
    Text = "상태@몬스터 조지가 밀랍상 몬스터를 먹는다"
  },
  State_3881_Name = {
    Text = "상태@몬스터 조지가 밀랍상 몬스터를 잡아먹기"
  },
  State_3881_WeaponDesc = {
    Text = "상태@몬스터 조지가 밀랍상 몬스터를 먹는다"
  },
  State_3882_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3882_Name = {
    Text = "미깨어남"
  },
  State_3883_Desc = {
    Text = "이번 스테이지 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_3883_Name = {
    Text = "영구 치명타율"
  },
  State_3883_WeaponDesc = {
    Text = "이번 스테이지 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_3884_Desc = {
    Text = "매 턴마다 배아 융합도 1이 추가로 생성된다. 모든 포식 효과가 무한 포식으로 변경된다."
  },
  State_3884_Name = {
    Text = "유물 꿈틀거리는 탯줄"
  },
  State_3884_WeaponDesc = {
    Text = "매 턴마다 배아 융합도 1이 추가로 생성된다. 모든 포식 효과가 무한 포식으로 변경된다."
  },
  State_3888_Desc = {
    Text = "광기 폭발을 발동할 수 없으며, 턴 종료 시 1스택이 제거된다."
  },
  State_3888_Name = {
    Text = "<CardKeyWord:봉인>"
  },
  State_3888_WeaponDesc = {
    Text = "모든 깨어남체의 광기 폭발을 사용할 수 없다."
  },
  State_3890_Name = {
    Text = "버린 카드 수 + [DescArg1]장 드로우"
  },
  State_3893_Desc = {
    Text = "피해를 입힐 때 [Arg1]의 실타래드를 획득한다. HP를 회복할 때 [Arg2]의 임시 힘을 획득한다."
  },
  State_3893_Name = {
    Text = "우리의 집"
  },
  State_3894_Desc = {
    Text = "버리기 단계 전에 손패를 돌로 만든다."
  },
  State_3894_Name = {Text = "석화"},
  State_3894_WeaponDesc = {
    Text = "버리기 단계 전에 손패를 돌로 만든다."
  },
  State_3895_Desc = {
    Text = "이번 턴 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_3895_Name = {
    Text = "임시 치명타율"
  },
  State_3895_WeaponDesc = {
    Text = "이번 턴 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_3898_Desc = {
    Text = "다음 턴 시작 시 [Layer]pt의 실타래드를 획득한다."
  },
  State_3898_Name = {
    Text = "고통과 환희 실타래드"
  },
  State_3900_Name = {
    Text = "카드가 봉인되어 사용할 수 없으며, 버릴 때 해제된다"
  },
  State_3901_Name = {
    Text = "상태@유물 제사장의 지팡이 카운터"
  },
  State_3902_Desc = {
    Text = "이번 턴 내에서 주는 능동 피해가 [Layer]pt 감소한다."
  },
  State_3902_Name = {Text = "힘 감소"},
  State_3902_WeaponDesc = {
    Text = "이번 턴 내에서 주는 피해가 [Layer]pt 감소한다."
  },
  State_3904_Desc = {
    Text = "HP 1을 잃을 때마다 1스택이 제거되며, 스택이 0이 되면 [StateArg1]의 실타래드를 획득하고, [StateArg2]스택의 혈액 장벽을 다시 획득한다."
  },
  State_3904_Name = {
    Text = "깨어남 - 피의 장벽"
  },
  State_3905_Desc = {
    Text = "능동 피해를 받을 때마다, 피해 출처에게 [Layer] 의 <FixedDamage:순수 피해>를 가함."
  },
  State_3905_Name = {Text = "반격"},
  State_3905_WeaponDesc = {
    Text = "능동 피해를 받을 때마다, 공격자에게 [Layer] 의 <FixedDamage:순수 피해>를 가함."
  },
  State_3906_Name = {
    Text = "잔여 은심"
  },
  State_3907_Name = {
    Text = "잔여 은심"
  },
  State_3908_Desc = {
    Text = "통 속의 뇌가 회복을 줄 때, [Arg2]장의 카드를 드로우한다."
  },
  State_3908_Name = {
    Text = "허실타래 이중성"
  },
  State_3908_WeaponDesc = {
    Text = "통 속의 뇌가 회복을 줄 때, [Arg2]장의 카드를 드로우한다."
  },
  State_3909_Name = {
    Text = "잔여 은심"
  },
  State_3910_Name = {
    Text = "잔여 은심"
  },
  State_3911_Name = {
    Text = "잔여 은심"
  },
  State_3912_Name = {
    Text = "잔여 은심"
  },
  State_3913_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 턴 시작 시, 남은 실타래드의 <WeaponEffect_Num:[StateArg2]%>를 유지한다. 유지되는 실타래드는 최대 HP의 <WeaponEffect_Num:[StateArg3]%>까지 가능하다."
  },
  State_3913_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 턴 시작 시, 남은 실타래드의 <WeaponEffect_Num:[StateArg2]%>를 유지한다. 유지되는 실타래드는 최대 HP의 <WeaponEffect_Num:[StateArg3]%>까지 가능하다."
  },
  State_3914_Desc = {
    Text = "매 턴 2번째 광기 폭발을 발동한 후, 모든 깨어남체가 광기 10을 획득한다. 매 턴 3번째 광기 폭발을 발동한 후, 모든 깨어남체의 광기 폭발 쿨다운이 초기화되고 광기 10을 획득한다."
  },
  State_3915_Name = {
    Text = "잔여 은심"
  },
  State_3916_Name = {
    Text = "잔여 은심"
  },
  State_3917_Desc = {
    Text = "다음 턴에 임시 힘이 증가한다."
  },
  State_3917_Name = {Text = "차지"},
  State_3918_Desc = {
    Text = "매 턴 시작 시 처음 받는 피해가 2배로 적용되는 상태를 획득한다."
  },
  State_3918_Name = {Text = "자부심"},
  State_3918_WeaponDesc = {
    Text = "매 턴 시작 시 처음 받는 피해가 2배로 적용되는 상태를 획득한다."
  },
  State_3921_Desc = {
    Text = "이번 턴의 카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:유지>"
  },
  State_3921_WeaponDesc = {
    Text = "카드는 버리기 단계에서 버린 카드 더미로 들어가지 않고, 손에 남아 있다."
  },
  State_3923_Desc = {
    Text = "카드의 행동력이 감소한다."
  },
  State_3923_Name = {
    Text = "영구 카드 행동력 감소"
  },
  State_3923_WeaponDesc = {
    Text = "카드의 행동력이 감소한다."
  },
  State_3925_Name = {
    Text = "상태@제4장 공명@아군 턴 시작 시 행동력 2"
  },
  State_3926_Desc = {
    Text = "「뒤틀린 시체의 광연」의 피해가 [Layer]pt 증가한다."
  },
  State_3926_Name = {Text = "왜곡"},
  State_3926_WeaponDesc = {
    Text = "「조증」 피해가 증가한다."
  },
  State_3927_Desc = {
    Text = "「공허」를 뽑은 후, 이번 턴 내 모든 깨어남체가 획득하는 광기가 [Layer]% 감소한다."
  },
  State_3927_Name = {Text = "공허"},
  State_3927_WeaponDesc = {
    Text = "「공허」를 뽑은 후, 이번 턴 내 모든 깨어남체가 획득하는 광기가 [Layer]% 감소한다."
  },
  State_3928_Desc = {
    Text = "달콤한 악귀가 피해를 줄 때, [StateArg2]의 반격을 획득한다."
  },
  State_3928_Name = {
    Text = "주고받기"
  },
  State_3929_Desc = {
    Text = "획득하는 힘과 실타래드가 50% 감소하며, 턴 종료 시 1스택이 제거된다."
  },
  State_3929_Name = {
    Text = "<CardKeyWord:저주>"
  },
  State_3929_WeaponDesc = {
    Text = "이번 턴 내에서 아군에게 부여되는 긍정 상태에 면역이다."
  },
  State_3930_Name = {
    Text = "상태@제4장 공명@아군 턴 시작 시 행동력 1"
  },
  State_3931_Name = {
    Text = "상태@핏빛 피와 모래의 찬가"
  },
  State_3932_Desc = {
    Text = "카드가 유지를 획득한다. 정체의 저주 1스택당 카드의 행동력 소모가 1 증가하며, 사용 후 정체의 저주가 제거된다."
  },
  State_3932_Name = {
    Text = "정체의 저주([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "카드가 유지를 획득한다. 정체의 저주 1스택당 카드의 행동력 소모가 1 증가하며, 사용 후 정체의 저주가 제거된다."
  },
  State_3933_Desc = {
    Text = "방어력이 [Layer]pt 증가한다."
  },
  State_3933_Name = {
    Text = "임시 방어력 증가"
  },
  State_3933_WeaponDesc = {
    Text = "방어력이 [Layer]pt 증가한다."
  },
  State_3934_Desc = {
    Text = "획득하는 모든 실타래드가 50% 감소한다."
  },
  State_3934_Name = {
    Text = "적멸의 손상"
  },
  State_3934_WeaponDesc = {
    Text = "획득하는 모든 실타래드가 50% 감소한다."
  },
  State_3935_Desc = {
    Text = "아군 팀이 손패 1장을 사용할 때마다 「관측」 1스택을 획득하며, 10스택에 도달하면 자신이 기절한다."
  },
  State_3935_Name = {Text = "관측"},
  State_3936_Desc = {
    Text = "장착한 깨어남체가 주는 피해, 실타래드, 치유량이 [StateArg1]% 증가한다. (임시)"
  },
  State_3936_Name = {
    Text = "상태@테스트 장검 계역"
  },
  State_3937_Desc = {
    Text = "가시 여왕이 반격을 획득할 때, 반격 수치의 절반만큼 실타래드를 획득한다."
  },
  State_3937_Name = {
    Text = "좀비의 벽"
  },
  State_3938_Name = {
    Text = "밀랍상 생성"
  },
  State_3941_Desc = {
    Text = "배아를 포식할 때, 버린 카드 더미에서 손으로 되돌아온다."
  },
  State_3941_Name = {
    Text = "창백한 선회"
  },
  State_3941_WeaponDesc = {
    Text = "배아를 포식할 때, 버린 카드 더미에서 손으로 되돌아온다."
  },
  State_3942_Name = {
    Text = "장식품 해귀선"
  },
  State_3942_WeaponDesc = {
    Text = "전투 시작 후, 장착한 깨어남체의 직업이 심해일 경우 공격력이 25% 증가한다."
  },
  State_3943_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_3943_Name = {
    Text = "미깨어남"
  },
  State_3944_Desc = {
    Text = "턴 종료 후 모든 깨어남체가 광기 5를 획득한다. 남은 행동력 1pt당 모든 깨어남체가 추가로 광기 3을 획득한다."
  },
  State_3945_Desc = {
    Text = "모든 유물의 가격이 50% 감소한다."
  },
  State_39547_Desc = {
    Text = "전투 종료 후 추가로 검은 인장 5개를 획득하며, 이 효과는 검은 인장 드롭 보너스의 영향을 받는다. 완다가 카드를 사용한 후, 꿈의 인도 1스택을 획득하며, 이 효과는 매 턴 최대 2회 발동된다. 현재 [DescArg1]회 남았다."
  },
  State_39547_Name = {
    Text = "모피와 비너스"
  },
  State_40483_Name = {
    Text = "파쇄된 칼"
  },
  State_40484_Desc = {
    Text = "완다의 스킬이 도약 효과를 발동할 때, 꿈의 인도가 5스택 존재하면 5스택을 소모하고 추가 효과를 획득한다. 꿈의 인도 상한은 10스택이며, 다음 전투로 이월된다."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:몽인>"
  },
  State_41337_Desc = {
    Text = "턴 종료 시 [Layer]의 HP를 회복한다."
  },
  State_41337_Name = {
    Text = "장미의 승리 - 회복"
  },
  State_41340_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드와 반격이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 공격을 받을 때마다 <WeaponEffect_Num:[StateArg2]%> 확률로 모든 깨어남체가 광기 1을 획득한다."
  },
  State_41340_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드와 반격이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 공격을 받을 때마다 <WeaponEffect_Num:[StateArg2]%> 확률로 모든 깨어남체가 광기 1을 획득한다."
  },
  State_41342_Name = {
    Text = "효과 변화__「개발 전용」"
  },
  State_41344_Name = {
    Text = "변화 효과"
  },
  State_41360_Desc = {
    Text = "<DreamGuide:꿈의 인도> 5스택을 소모하여, 완다가 <Energy:[StateArg1]>의 광기를 획득하고, 현재 영구 <RetaliateIconKeywords:반격>의 [StateArg2]%에 해당하는 임시 <RetaliateIconKeywords:반격>을 획득한다."
  },
  State_41360_Name = {
    Text = "심면 반격"
  },
  State_41361_Desc = {
    Text = "<DreamGuide:꿈의 인도> 10 스택을 소모하여 모든 적을 1턴 동안 「잠꼬대」 상태로 만듭니다: 가하는 능동 피해가 [StateArg3]% 감소하고, 공격 횟수가 2배가 됩니다."
  },
  State_41361_Name = {
    Text = "잠꼬대 메아리"
  },
  State_43818_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_43818_Name = {
    Text = "미깨어남"
  },
  State_44398_Desc = {
    Text = "매 턴 첫 번째 카드를 사용한 후, 해당 깨어남체의 「방어」 1장을 손에 넣는다."
  },
  State_44484_Name = {
    Text = "보스전에서 3회 사용 가능"
  },
  State_44485_Name = {
    Text = "(잔여: [Layer])"
  },
  State_44491_Name = {
    Text = "차단 효과__「개발 전용」"
  },
  State_44562_Name = {
    Text = "효과 비활성화"
  },
  State_44575_Desc = {
    Text = "이번 턴에 남은 실타래드는 제거되지 않고 다음 턴까지 유지된다."
  },
  State_44575_Name = {
    Text = "실타래드 유지"
  },
  State_44653_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 20을 획득한다. 획득 시 최대 HP가 50% 감소한다."
  },
  State_44665_Desc = {
    Text = "이번 턴 「타격」의 치명타율이 [Layer]% 증가한다."
  },
  State_44665_Name = {
    Text = "치명타율"
  },
  State_44667_Desc = {
    Text = "「타격」이 [DescArg1]의 행동력을 획득한다. 현재 자세가 「노도」일 경우, 행동력을 획득하지 않고 촉수 1개로 [DescArg2]회 공격한다."
  },
  State_44667_Name = {
    Text = "거인의 패도"
  },
  State_44671_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 25를 획득한다. 획득 시 최대 HP가 3배로 증가한다."
  },
  State_44672_Name = {
    Text = "축복·군체 의식"
  },
  State_44711_Desc = {
    Text = "유물 상한이 5 증가하고, [융흔]에서 새로고침 횟수가 1 증가한다. 전투 종료 후, 검은 인장 125를 획득하며, 획득 시 최대 6장의 증상 카드를 선택하여 삭제할 수 있다."
  },
  State_44713_Desc = {
    Text = "전투 종료 후, 추가로 검은 인장 100과 증상 카드 2장을 획득한다."
  },
  State_44730_Desc = {
    Text = "턴 시작 시, <Heal:[Heal:StateArg1]>의 핏빛 용광로 회복량을 적립한다."
  },
  State_44730_Name = {Text = "구원"},
  State_44731_Desc = {
    Text = "고통으로 고통을 없앤다. 모든 진홍색 용광로의 남은 회복량을 소모하여, 1점당 3점의 피해량을 증가시킨다. 만약 리더 전투라면, 1점당 9점의 피해량을 증가시킨다. 최대 생명력의 1%에 해당하는 진홍색 용광로를 소모할 때마다 [DescArg1]% 최종 피해가 증가합니다."
  },
  State_44731_Name = {Text = "해방"},
  State_44732_Desc = {
    Text = "피로써 구원한다. 피해를 입힌 후, 현재 HP의 10%를 잃고, 잃은 HP와 동일한 양의 핏빛 용광로 회복량을 적립한다."
  },
  State_44732_Name = {Text = "헌신"},
  State_44739_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 힘을 잃는다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 매 턴 최대 6회 발동한다."
  },
  State_44739_Name = {
    Text = "죄책·칠성장어의 입맞춤"
  },
  State_44740_Name = {
    Text = "축복·일곱 비늘의 키스"
  },
  State_44741_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 힘을 잃는다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 매 턴 최대 6회 발동한다."
  },
  State_44741_Name = {
    Text = "죄책·칠성장어의 입맞춤"
  },
  State_44742_Desc = {
    Text = "획득 시 영구적으로 [Arg1]의 힘을 잃는다. 피해를 줄 때마다 [Arg2]의 HP를 회복하며, 매 턴 최대 6회 발동한다."
  },
  State_44742_Name = {
    Text = "축복·일곱 비늘의 키스"
  },
  State_44743_WeaponDesc = {
    Text = "전투 시작 시 자신에게 3턴간 손상을 부여한다."
  },
  State_44744_WeaponDesc = {
    Text = "전투 시작 시 자신에게 3턴간 손상을 부여한다."
  },
  State_44750_Desc = {
    Text = "턴 시작 시 [StateArg1]의 행동력을 획득한다."
  },
  State_44750_Name = {
    Text = "유물 검은 양초 1"
  },
  State_44751_Desc = {
    Text = "턴 시작 시 [StateArg1]의 행동력을 획득한다."
  },
  State_44751_Name = {
    Text = "유물 검은 양초 1"
  },
  State_44752_Desc = {
    Text = "「소피아」가 HP 1을 잃을 때마다 1스택이 감소하고, 스택이 0이 되면 의도를 「눈에는 눈」으로 교체하고 [StateArg2]의 실타래드를 획득한다. 최초 발동 시 모든 스택이 회복된다."
  },
  State_44752_Name = {
    Text = "매장된 충동"
  },
  State_44762_Desc = {
    Text = "「방어」를 사용할 때, 「상처」 1장을 덱에 섞어 넣는다."
  },
  State_44762_Name = {Text = "찢기"},
  State_44763_Desc = {
    Text = "모든 깨어남체의 치명타 피해 수치가 절반으로 감소한다."
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord:실타래명>"
  },
  State_44764_Desc = {
    Text = "「타격」을 사용할 때, 「상처」 1장을 덱에 섞어 넣는다."
  },
  State_44764_Name = {
    Text = "트라우마"
  },
  State_44807_Desc = {
    Text = "처음으로 패배 직전에, HP를 회복하고 의도를 「거울 속의 심판」으로 전환하여 자신을 강화한다. 두 번째로 패배 직전에, HP를 회복하고 의도를 「광란의 물어뜯기」로 전환하여 매우 높은 단일 피해를 준다."
  },
  State_44807_Name = {
    Text = "매장된 살육"
  },
  State_44819_Desc = {
    Text = "<PVPProtectiveKeywords:장벽>이 없을 경우 임시 <PVPProtectiveKeywords:장벽> 1스택을 획득하고, 그렇지 않으면 치명타율과 치명타 피해가 10% 증가한다."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:부신의 수호>"
  },
  State_44828_Desc = {
    Text = "팀 유니크: 턴 종료 시, 장착자가 [StateArg1] 포인트의 광기를 획득합니다. 능동 피해 및 촉수 피해를 받을 때, 다음 턴 시작 시 피해의 <WeaponEffect_Num:[StateArg2]%>에 해당하는 방어막을 획득합니다. 현재 영역이 혈육인 경우, 방어막 지연을 획득하지 않고 대신 피해의 <WeaponEffect_Num:[StateArg2]%>에 해당하는 회복량을 진홍빛 용광로에 축적합니다."
  },
  State_44828_WeaponDesc = {
    Text = "턴 종료 시, 장착자가 <WeaponEffect_Num:[StateArg1]> 포인트의 광기를 획득합니다. 능동 피해 또는 촉수 피해를 받을 때, 다음 턴 시작 시 <WeaponEffect_Num:[Float:StateArg2]%> 피해에 해당하는 방어막을 획득합니다. 현재 영역이 혈육인 경우, 방어막 지연을 획득하지 않고 대신 <WeaponEffect_Num:[Float:StateArg2]%> 피해에 해당하는 회복량을 진홍빛 용광로에 축적합니다."
  },
  State_44889_Name = {
    Text = "상태@인면개 보스@종언의 거울 1"
  },
  State_44890_Name = {
    Text = "상태@인면개 보스@종언의 거울 2"
  },
  State_44891_Name = {
    Text = "상태@인면개 보스@종언의 거울 3"
  },
  State_44903_Desc = {
    Text = "능동 또는 촉수 피해를 받은 후, [StateArg1]% 피해를 진홍빛 용광로 회복량으로 전환하며, [Layer] 턴 동안 지속됩니다."
  },
  State_44903_Name = {
    Text = "창조주의 은총"
  },
  State_44909_Name = {
    Text = "소모 가능"
  },
  State_45018_Desc = {
    Text = "턴 종료 전까지 「타격」을 사용할 수 없다."
  },
  State_45018_Name = {Text = "마비"},
  State_45025_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.__「개발 전용」"
  },
  State_45029_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.「개발 전용」"
  },
  State_45032_Desc = {
    Text = "다음 턴 종료 시, [Layer]의 피해를 받는다."
  },
  State_45032_Name = {Text = "출혈"},
  State_45039_Desc = {
    Text = "다음 턴 시작 전까지, 능동 또는 촉수 피해를 받을 때마다 다음 턴 시작 시 피해의 [Layer]%에 해당하는 방어막 획득."
  },
  State_45039_Name = {
    Text = "기적의 강림"
  },
  State_45040_Desc = {
    Text = "다음 턴 시작 전까지, 능동 또는 촉수 피해를 받을 때마다 피해의 [Layer]%에 해당하는 회복량을 진홍빛 용광로에 축적."
  },
  State_45040_Name = {
    Text = "기적의 강림"
  },
  State_45049_Desc = {
    Text = "다음 주동 공격 피해로 인한 HP 손실타래을 상쇄합니다. 최대 3 스택까지 쌓을 수 있으며, 사투 1 스택마다 장벽의 최대 스택 수가 -1 됩니다. 이미 획득한 장벽은 최대 스택 수가 감소해도 줄어들지 않습니다."
  },
  State_45049_Name = {Text = "장벽"},
  State_45050_Desc = {
    Text = "다음 주동 공격 피해로 인한 HP 손실타래을 상쇄합니다. 최대 3 스택까지 쌓을 수 있으며, 사투 1 스택마다 장벽의 최대 스택 수가 -1 됩니다. 이미 획득한 장벽은 최대 스택 수가 감소해도 줄어들지 않습니다."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:장벽>"
  },
  State_45064_Name = {
    Text = "소리 없는 잔치의 카운터__[개발 전용]"
  },
  State_45069_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.__「개발 전용」"
  },
  State_45072_Name = {
    Text = "성화 카운터"
  },
  State_45073_Desc = {
    Text = "카드의 행동력이 감소한다."
  },
  State_45076_Desc = {
    Text = "적용 시 대상의 실타래드와 지연 치유를 해제하고, 턴 종료 전까지 받는 치유와 실타래드 효과가 50% 감소한다."
  },
  State_45076_Name = {Text = "중상"},
  State_45137_Desc = {
    Text = "광기 폭발 사용 후 모든 깨어남체를 1턴간 봉인하고, 1턴간 취약을 부여한다."
  },
  State_45137_Name = {
    Text = "원죄·행도의 해골"
  },
  State_45139_Desc = {
    Text = "광기 폭발 사용 후, 무작위로 부정 상태 1개를 해제한다."
  },
  State_45139_Name = {
    Text = "축복·여정의 유골"
  },
  State_45148_Desc = {
    Text = "모든 깨어남체의 치명타 피해 수치가 절반으로 감소한다."
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord:실타래명>"
  },
  State_45166_Desc = {
    Text = "턴 종료 전까지 장착한 명륜이 무효화된다."
  },
  State_45166_Name = {Text = "엉킴"},
  State_45206_Desc = {
    Text = "신앙으로 세상을 구원한다. 모든 핏빛 용광로의 남은 회복량을 소모하여, 소모량의 150%에 해당하는 실타래드를 획득한다. 이 실타래드는 실타래드 보너스와 약화 효과의 영향을 받지 않으며, 실타래드 상한을 무시한다."
  },
  State_45206_Name = {Text = "구원"},
  State_45248_Name = {
    Text = "카운터__[개발 전용]"
  },
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 자신이 <TauntKeywords:도발>과 <Block:[Block:StateArg1]>의 실타래드를 획득한다."
  },
  State_45328_Name = {
    Text = "35mm의 마법"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」이 대상을 선택할 수 있으며, 「타격」 전에 대상의 해제 가능한 모든 긍정 상태를 그 뒤의 깨어남체에게 <PVPRepelKeywords:밀쳐내기>한다."
  },
  State_45329_Name = {
    Text = "심해의 부름"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 「타격」 후, 손에 있는 장착한 깨어남체의 비파생 「스킬」이 순서대로 장착한 깨어남체의 다른 「스킬」로 변화한다. [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]"
  },
  State_45331_Name = {
    Text = "지난날의 꽃과 시"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:명륜>:주동 피해를 받을 때마다 다른 아군이 <Energy:[Energy:StateArg1]> 광기를 획득합니다."
  },
  State_45332_Name = {
    Text = "이사라우의 시선"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 손패 상한이 [StateArg1] 증가한다. 「광기 폭발」 후 자신이 <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_45333_Name = {
    Text = "찬란한 이별의 키스"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 이번 턴의 다음 「타격」을 랜덤 대상으로 변경하고, 추가로 랜덤한 대상 [StateArg1]명을 공격하게 한다."
  },
  State_45334_Name = {
    Text = "거울 속의 사람"
  },
  State_45345_Desc = {
    Text = "1단계 출산 스킬 사용 횟수를 기록하는 데 사용된다."
  },
  State_45345_Name = {
    Text = "출생 표식 1"
  },
  State_45346_Desc = {
    Text = "2단계 출산 스킬 사용 횟수를 기록한다."
  },
  State_45346_Name = {
    Text = "출생 표식 2"
  },
  State_45354_Desc = {
    Text = "이 카드는 사용할 수 없다.__「개발 전용」"
  },
  State_45354_Name = {
    Text = "사용 불가__「개발 전용」"
  },
  State_45356_Desc = {
    Text = "턴 종료 시, 마지막으로 사용한 「스킬」 카드로 변화하며 해당 카드의 행동력 소모가 2 감소한다. 사용 후 「안개 드리운 진실타래」를 덱에 섞어 넣는다."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:안개 드리운 진실타래>"
  },
  State_45364_Desc = {
    Text = "다음 턴 시작 시, 해당 깨어남체가 「타격」 [Layer]장을 획득한다."
  },
  State_45364_Name = {
    Text = "지연 타격 획득"
  },
  State_45385_Desc = {
    Text = "본 전투에서 발생하는 모든 데미지가 [Layer] 포인트 감소하며, 무효화 불가입니다. 이 중 [DescArg1] 레이어의 임시 힘 감소는 턴 종료 시 제거됩니다."
  },
  State_45385_Name = {Text = "힘 감소"},
  State_45387_Desc = {
    Text = "이번 전투 내에서 주는 모든 피해가 [Layer]pt 증가하며, 해제할 수 없다. 그중 [DescArg1]스택은 임시 힘으로, 턴 종료 시 제거된다."
  },
  State_45387_Name = {Text = "힘"},
  State_45397_Desc = {
    Text = "턴 시작 시, 장벽 1스택을 힘으로 전환한다."
  },
  State_45397_Name = {
    Text = "장미의 승리"
  },
  State_45403_Desc = {
    Text = "다음 턴 시작 시, 차지 [Layer]스택을 획득한다."
  },
  State_45403_Name = {
    Text = "지연 차지"
  },
  State_45407_Desc = {
    Text = "획득한 광기와 지연된 광기가 50% 감소하며, 모든 지연된 광기를 즉시 제거합니다."
  },
  State_45407_Name = {Text = "공허"},
  State_45656_Desc = {
    Text = "모나무가 세 번째로 부활하여, 번식 스킬 2를 가동한다."
  },
  State_45658_Desc = {
    Text = "모나무가 처음으로 부활하여, 번식 스킬을 활성화했다."
  },
  State_45661_Desc = {
    Text = "HP가 0으로 감소할 때 HP를 1로 만들고, 더 이상 피해를 받지 않으며, 「다중 융합」을 준비한다."
  },
  State_45661_Name = {
    Text = "다중 융합"
  },
  State_45715_Desc = {
    Text = "현재 촉수 피해의 [StateArg1]%만큼 임시 힘을 획득한다."
  },
  State_45715_Name = {Text = "찬탈"},
  State_45716_Desc = {
    Text = "현재 촉수 피해의 [StateArg1]%만큼 임시 힘을 획득한다. 골리아의 임시 치명타율이 25% 증가한다."
  },
  State_45716_Name = {Text = "찬탈"},
  State_45717_Desc = {
    Text = "이번 전투 동안 「거대한 검의 위엄」과 「참수의 일격」의 기본 피해가 25% 증가한다. 골리아가 <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_45717_Name = {Text = "잠복"},
  State_45718_Desc = {
    Text = "이번 전투 동안 「거대한 검의 위엄」과 「참수의 일격」의 기본 피해가 25% 증가한다."
  },
  State_45718_Name = {Text = "잠복"},
  State_46057_Name = {Text = "행동력"},
  State_46079_Desc = {
    Text = "이번 턴 내에서, 대상이 능동 피해를 받을 때마다 가장 많은 HP를 잃은 아군의 HP를 [Layer] 회복한다."
  },
  State_46079_Name = {
    Text = "성혈의 인도"
  },
  State_46119_Desc = {
    Text = "다음에 공격을 받으면 공격자에게 엉킴을 부여한다."
  },
  State_46119_Name = {
    Text = "미로 함정"
  },
  State_46124_Desc = {
    Text = "턴 종료 전까지 아무런 행동도 할 수 없다."
  },
  State_46124_Name = {Text = "석화"},
  State_46138_Desc = {
    Text = "상대가 마지막으로 사용한 「스킬」로 변화하며, 해당 스킬의 행동력 소모가 1 감소한다."
  },
  State_46138_Name = {
    Text = "<CardKeyWord:별빛 모방>"
  },
  State_46139_Desc = {
    Text = "능동적으로 공격받을 때마다 자신은 [Layer]스택의 차지를 획득하고 공격자에게 [Layer]스택의 둔화를 부여한다."
  },
  State_46139_Name = {
    Text = "이상 중력"
  },
  State_46155_Desc = {
    Text = "자신의 「스킬」 사용 후 [StateArg1]스택의 차지를 획득하고 스택이 1 감소한다. 턴 종료 시 모든 스택을 소모하며, 스택당 [StateArg2]의 HP를 회복한다."
  },
  State_46155_Name = {
    Text = "이단의 피"
  },
  State_46243_Name = {
    Text = "통찰 카운터__[개발 전용]"
  },
  State_46255_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.「개발 전용」"
  },
  State_46256_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.「개발 전용」"
  },
  State_46322_Desc = {
    Text = "턴 시작 시 30%의 배아 융합을 획득합니다."
  },
  State_46322_Name = {
    Text = "유우하시 체험"
  },
  State_46323_Desc = {
    Text = "초차원 턴 시작 후, 광기 100을 획득하고, 턴 시작 후 힘 7을 획득한다."
  },
  State_46323_Name = {
    Text = "리즈 체험"
  },
  State_46324_Desc = {
    Text = "매 턴 「영감」 1장을 획득한다."
  },
  State_46324_Name = {
    Text = "젠킨 체험"
  },
  State_46329_Desc = {
    Text = "전투 시작 후, 은열쇠 에너지 600을 획득하고, 로탄이 광기 50을 획득하며, 로탄이 광기 폭발을 발동한 후 광기 44를 추가로 획득한다."
  },
  State_46329_Name = {
    Text = "체험 보너스"
  },
  State_46330_Desc = {
    Text = "턴이 시작될 때 30% 배아 융합, 10 광기, [DescArg1] 포인트의 힘을 얻고, 3장의 「타격」을 드로우 덱에 추가합니다."
  },
  State_46330_Name = {
    Text = "히로 체험"
  },
  State_46333_Name = {
    Text = "레아 체험"
  },
  State_46334_Desc = {
    Text = "4번째 턴 시작 후, 광기 100을 획득한다."
  },
  State_46334_Name = {
    Text = "팔로스 체험"
  },
  State_46336_Desc = {
    Text = "턴이 시작될 때 30%의 배아 융합과 10 광기를 획득합니다."
  },
  State_46336_Name = {
    Text = "아그리파 체험"
  },
  State_46337_Desc = {
    Text = "턴 시작 시 광기 10을 획득한다."
  },
  State_46337_Name = {
    Text = "카이커스 체험"
  },
  State_46338_Desc = {
    Text = "턴이 시작될 때 30%의 배아 융합과 10 광기를 획득합니다."
  },
  State_46338_Name = {
    Text = "파인트 체험"
  },
  State_46427_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.__「개발 전용」"
  },
  State_46428_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.「개발 전용」"
  },
  State_46429_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.__「개발 전용」"
  },
  State_46441_Desc = {
    Text = "관통 피해가 아닌 피해에 면역되며, 턴 시작 후 제거됩니다."
  },
  State_46441_Name = {
    Text = "피해 면역"
  },
  State_46442_Name = {
    Text = "카드는 타격 대상 유형을 수정할 수 없음__「개발 전용」"
  },
  State_46500_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.「개발 전용」"
  },
  State_46505_Desc = {
    Text = "이번 턴 내, 능동 피해를 받을 때마다 [Layer] 광기를 획득합니다."
  },
  State_46505_Name = {
    Text = "고통 전환"
  },
  State_46508_Desc = {
    Text = "실타래신을 받을 때 저항을 획득합니다. 저항을 보유한 상태에서 다시 실타래신 피해를 받으면 실타래신 효과를 무효화하고 데미지가 2배로 증가합니다. 이 상태는 제거할 수 없습니다."
  },
  State_46508_Name = {Text = "내성"},
  State_46511_Desc = {
    Text = "해당 깨어남체의 「천면 중첩」 피해가 [Layer] 증가합니다."
  },
  State_46511_Name = {
    Text = "천면중첩"
  },
  State_46512_Desc = {
    Text = "턴 종료 전까지, 해당 깨어남체가 카드를 사용한 후 [Layer]의 피해를 받는다."
  },
  State_46512_Name = {
    Text = "카드 봉쇄"
  },
  State_46513_Desc = {
    Text = "다음 시편을 증폭시켜 추가 효과를 부여하며, 해제할 수 없다."
  },
  State_46513_Name = {
    Text = "슬픔의 잉크"
  },
  State_46536_Desc = {
    Text = "상태 파라미터1이 0이면 드로우하고, 그렇지 않으면 글자만 떠다닌다."
  },
  State_46536_Name = {Text = "드로우"},
  State_46538_Desc = {
    Text = "탐색 시작 시 [StateArg1]의 광기를 획득한다."
  },
  State_46538_Name = {
    Text = "광기의 징조"
  },
  State_47072_Desc = {
    Text = "이번 턴 타격 카드의 치명타율이 [Layer]% 증가한다."
  },
  State_47072_Name = {
    Text = "타격 치명타"
  },
  State_47089_Name = {
    Text = "테스트 효과__「개발 전용」"
  },
  State_47096_Desc = {
    Text = "「영감」을 1장 사용할 때마다 다프다엘이 [StateArg1]의 광기를 획득하고, [StateArg2]의 힘을 획득한다. 매 턴 최대 5회 발동된다. (현재 남은 횟수: [DescArg1])"
  },
  State_47096_Name = {
    Text = "원질 침전"
  },
  State_47189_Name = {
    Text = "광란 인격으로 전환. 혈육·우울: <EmbryoFusionIconKeywords:배아 융합> +[Blood:StateArg5], [StateArg6] 점 핏빛 용광로 회복량 축적"
  },
  State_47192_Name = {
    Text = "우울 인격: 다른 깨어남체도 [DescArg1]배 광기 획득. 조증 인격: 추가로 [DescArg2]배 광기 획득"
  },
  State_47199_Name = {
    Text = "우울 인격으로 전환합니다. 혈육·조증: 피해량에 [DescArg1]배 <PowerIconKeywords:힘> 계수가 적용되고 목표에 200% 피해량의 <BleedingIconKeywords:출혈>을 부여하며, [StateArg7] <PowerIconKeywords:힘>을 획득합니다"
  },
  State_47204_Name = {
    Text = "조증 인격으로 전환. 혼돈·우울: 은열쇠 에너지 <Posse:[StateArg1]>pt 획득, 다음 열쇠 지령 2회 발동"
  },
  State_47206_Name = {
    Text = "조증 인격으로 전환. 심해·우울: 대상에게 <WeaknessIconKeywords:허약> 및 <VulnerabilityIconKeywords:취약>을 2턴간 부여하고, 촉수 1개 생성하며, <TentacleInjurieIconKeywords:촉수 피해> [TentaclePower:StateArg3] 증가한다."
  },
  State_47209_Name = {
    Text = "우울한 인격으로 전환. 초차원·조증: 가한 피해의 15%만큼 <RetaliateIconKeywords:반격>을 획득한 후, 다른 적들에게 동일한 양의 <FixedDamage:순수 피해>를 가합니다. 이번 턴에 「영감」을 1장 사용할 때마다 해당 피해가 이번 턴 내에 [StateArg9] 증가하며, 최대 [StateArg10] 증가합니다"
  },
  State_47211_Name = {
    Text = "우울 인격: 손패에서 행동력이 가장 높은 카드 [DescArg1]장의 행동력 소모 1 감소, 임시 <RetainIconKeywords:유지>를 획득. 조증 인격: 추가로 [DescArg2]회 피해"
  },
  State_47212_Name = {
    Text = "\"24\"가 우울과 조증 인격 사이를 전환하며, 현재 계역과 인격에 따라 추가 효과 발동"
  },
  State_47216_Name = {
    Text = "우울 인격으로 전환. 심해·조증: 이 피해는 [StateArg4]% <TentacleInjurieIconKeywords:촉수 피해> 보너스 적용, 모든 적에게 피해량의 30% <IntoxicationIconKeywords:중독> 부여"
  },
  State_47217_Name = {
    Text = "우울 인격으로 전환. 혼돈·조증: 피해 3회, \"24\"가 주는 모든 피해 [StateArg2]pt 증가"
  },
  State_47218_Name = {
    Text = "조증 인격으로 전환. 초차원·우울: 「영감」 2장 획득, 대상의 <PowerIconKeywords:힘> [Power:StateArg8]pt 임시 감소"
  },
  State_47222_Name = {
    Text = "우울 인격: 손패에서 행동력이 가장 높은 카드 [DescArg1]장의 행동력 소모 1 감소, 임시 <RetainIconKeywords:유지>를 획득. <AwakerCard_24Lost:조증 인격: 추가로 [DescArg2]회 피해>"
  },
  State_47224_Name = {
    Text = "우울 인격: 다른 깨어남체도 [DescArg1]배 광기 획득. <AwakerCard_24Lost:조증 인격: 추가로 [DescArg2]배 광기 획득>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:우울 인격: 다른 깨어남체도 [DescArg1]배 광기 획득.> 조증 인격: 추가로 [DescArg2]배 광기 획득"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:우울 인격: 손패에서 행동력이 가장 높은 카드 [DescArg1]장의 행동력 소모 1 감소, 임시 <RetainIconKeywords:유지>를 획득.> 조증 인격: 추가로 [DescArg2]회 피해"
  },
  State_47451_Name = {
    Text = "라이커 열쇠 지령 명륜 효과 사용 금지__「개발 전용」"
  },
  State_47485_Name = {
    Text = "우울 인격: 손패에서 행동력이 가장 높은 카드 [DescArg1]장의 행동력 소모 2 감소, 임시 <RetainIconKeywords:유지>를 획득. 조증 인격: 추가로 [DescArg2]회 피해"
  },
  State_47486_Name = {
    Text = "우울 인격: 손패에서 행동력이 가장 높은 카드 [DescArg1]장의 행동력 소모 2 감소, 임시 <RetainIconKeywords:유지>를 획득. <AwakerCard_24Lost:조증 인격: 추가로 [DescArg2]회 피해>"
  },
  State_47488_Name = {
    Text = "우울 인격: 추가로 <Energy:[DescArg1]>pt 광기 획득. 조증 인격: 추가로 [DescArg2]회 실타래드 획득"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:우울 인격: 손패에서 행동력이 가장 높은 카드 [DescArg1]장의 행동력 소모 2 감소, 임시 <RetainIconKeywords:유지>를 획득.> 조증 인격: 추가로 [DescArg2]회 피해"
  },
  State_47492_Name = {
    Text = "우울 인격: 추가로 <Energy:[DescArg1]>pt 광기 획득. <AwakerCard_24Lost:조증 인격: 추가로 [DescArg2]회 피해>"
  },
  State_47493_Name = {
    Text = "우울 인격: 추가로 <Energy:[DescArg1]>pt 광기 획득. 조증 인격: 추가로 [DescArg2]회 피해"
  },
  State_47494_Name = {
    Text = "우울 인격: 다른 깨어남체에게 [DescArg1]배 광기 부여하고, 모든 적에게 [DescArg3]턴 동안 <WeaknessIconKeywords:허약>을 부여한다. 조증 인격: 추가로 [DescArg2]배 광기 획득하고, 모든 적에게 [DescArg3]턴 동안 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  State_47495_Name = {
    Text = "우울 인격: 다른 깨어남체에게 [DescArg1]배 광기 부여하고, 모든 적에게 [DescArg3]턴 동안 <WeaknessIconKeywords:허약>을 부여한다. <AwakerCard_24Lost:조증 인격: 추가로 [DescArg2]배 광기 획득하고, 모든 적에게 [DescArg3]턴 동안 <VulnerabilityIconKeywords:취약>을 부여한다>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:우울 인격: 다른 깨어남체에게 [DescArg1]배 광기 부여하고, 모든 적에게 [DescArg3]턴 동안 허약을 부여한다.> 조증 인격: 추가로 [DescArg2]배 광기 획득하고, 모든 적에게 [DescArg3]턴 동안 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:우울 인격: 추가로 <Energy:[DescArg1]>pt 광기 획득.> 조증 인격: 추가로 [DescArg2]회 피해"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:우울 인격: 추가로 <Energy:[DescArg1]>pt 광기 획득.> 조증 인격: 추가로 [DescArg2]회 실타래드 획득"
  },
  State_47500_Name = {
    Text = "우울 인격: 추가로 <Energy:[DescArg1]>pt 광기 획득. <AwakerCard_24Lost:조증 인격: 추가로 [DescArg2]회 실타래드 획득>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 다른 웨이크업 바디의 [StateArg1] 장 카드를 버리고, 버리기에 성공하면 [StateArg2] 장의 카드를 뽑습니다."
  },
  State_47517_Name = {
    Text = "은빛 물고기의 결심"
  },
  State_47518_Name = {
    Text = "은빛 물고기의 결심 카운터__[개발 전용]"
  },
  State_47528_Desc = {
    Text = "본 턴에 「타격」 + [DescArg1]% 피해 <PVPPenetrateKeywords:관통>."
  },
  State_47528_Name = {Text = "여위"},
  State_47530_Desc = {
    Text = "이번 턴 내에서 이전에 사용한 「스킬」로 간주된다."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:모의 연역>"
  },
  State_47557_Desc = {
    Text = "팀 유니크: 탐색 시작 후, 장착자는 은대구 어인 인격 상태에 진입합니다. 장착자가 광기 폭발을 해제한 후 은대구 어인 인격과 고양이 인격 사이를 전환합니다.\n은대구 어인 인격: 장착자가 능동 피해를 입힌 후 <WeaponEffect_Num:[StateArg1]> 은열쇠 에너지를 획득합니다. 고양이 인격: 장착자가 능동 피해를 입힌 후, 장착자의 임시 치명타 피해 <WeaponEffect_Num:+[StateArg2]%>. 두 효과는 매 턴 최대 5회 발동 기회를 공유합니다."
  },
  State_47557_WeaponDesc = {
    Text = "탐색 시작 후, 장착자는 은대구 어인 인격 상태에 진입합니다. 장착자가 광기 폭발을 해제한 후 은대구 어인 인격과 고양이 인격 사이를 전환합니다.\n은대구 어인 인격: 장착자가 능동 피해를 입힌 후 <WeaponEffect_Num:[StateArg1]> 은열쇠 에너지를 획득합니다. 고양이 인격: 장착자가 능동 피해를 입힌 후, 장착자의 임시 치명타 피해 <WeaponEffect_Num:+[StateArg2]%>. 두 효과는 매 턴 최대 5회 발동 기회를 공유합니다."
  },
  State_47822_Desc = {
    Text = "다음 턴에 다시 「마비」 상태가 되면, 해당 대상의 모든 「공격」이 「환상」으로 변하며, 해제 불가, 다음 턴 종료 시까지 지속됨."
  },
  State_47822_Name = {
    Text = "약간 마비됨"
  },
  State_47825_Desc = {
    Text = "턴이 시작될 때 해당 스킬 효과가 발생합니다."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:지연>"
  },
  State_47826_Desc = {
    Text = "·대상이 「마비」 상태일 때 피해가 2배가 되며, 그렇지 않으면 이번 턴 해당 대상의 「공격」을 사용할 수 없음.\n·연속 2턴 「마비」 상태일 경우, 해당 대상의 모든 「공격」이 「환상」으로 변함."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:마비>"
  },
  State_47827_Desc = {
    Text = "스택당 이번 전투에서 주는 모든 피해가 1pt 감소하며, 해제할 수 없다."
  },
  State_47827_Name = {
    Text = "<WeaknessColour:힘 감소>"
  },
  State_47828_Desc = {
    Text = "· 적용 시 스택 수만큼 피해를 준다. 대상이 「엉킴」 상태일 경우 피해가 2배가 되며, 그렇지 않을 경우 대상이 턴 종료 전까지 장착한 명륜이 무효화된다."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:얽힘>"
  },
  State_47830_Desc = {
    Text = "적용 시 대상의 실타래드와 지연 치유를 해제하고, 턴 종료 전까지 받는 치유와 실타래드 효과가 50% 감소한다."
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:중상>"
  },
  State_47831_Desc = {
    Text = "턴 종료 전까지 어떠한 행동도 할 수 없으며, 실타래신 데미지를 받으면 대상은 내성을 획득합니다. 내성을 가진 상태에서 다시 실타래신 데미지를 받으면 실타래신 효과가 상쇄되고 데미지가 두 배로 증가합니다. 이 상태는 해제할 수 없습니다."
  },
  State_47831_Name = {
    Text = "<ComaColour:석화>"
  },
  State_47832_Desc = {
    Text = "감염된 쥐, 전기 쥐, 치매 쥐를 포함한다."
  },
  State_47832_Name = {
    Text = "<CardKeyWord:쥐 카드>"
  },
  State_47833_Desc = {
    Text = "백조 손수건, 역분할 마술 상자, 텔레파시 마이크를 포함한다."
  },
  State_47833_Name = {
    Text = "<CardKeyWord:놀라운 마술>"
  },
  State_47841_Desc = {
    Text = "이번 전투에서 다음 [Layer]회 사용하는 열쇠 지령이 2회 발동한다."
  },
  State_47841_Name = {
    Text = "더블 발사 열쇠 지령"
  },
  State_47842_Desc = {
    Text = "획득한 광기와 지연된 광기가 50% 감소하며, 모든 지연된 광기를 즉시 제거합니다."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:공허>"
  },
  State_47843_Desc = {
    Text = "깨어남체를 사망 상태에서 벗어나게 하여 해당 깨어남체의 전체 카드를 덱에 넣는다."
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:부활>"
  },
  State_47844_Desc = {
    Text = "랜덤으로 이해할 수 없는 효과를 생성한다."
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:기묘한 효과>"
  },
  State_47845_Desc = {
    Text = "카드가 손에 있을 때 효과가 발동한다."
  },
  State_47845_Name = {
    Text = "<CardKeyWord:보유>"
  },
  State_47873_Desc = {
    Text = "다음 턴 종료 시, 스택 수만큼 피해를 준다."
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:출혈>"
  },
  State_47887_Name = {
    Text = "현재 팀 계역에 따라 다른 효과 적용"
  },
  State_47888_Name = {
    Text = "혈육: 「24」가 행동력 1pt 소모 시 <EmbryoFusionIconKeywords:배아 융합> +[Blood:DescArg1], <PowerIconKeywords:힘>을 [StateArg3]pt 획득, 「24」 광기 폭발 추가로 300% 힘 보너스 적용"
  },
  State_47889_Name = {
    Text = "심해: \"24\"가 주는 피해에 [StateArg2]% <TentacleInjurieIconKeywords:촉수 피해> 보너스 적용, 피해량의 10% <IntoxicationIconKeywords:중독> 부여. \"24\"의 광기 폭발 시 적의 <IntoxicationIconKeywords:중독> [StateArg6]% 발동"
  },
  State_47892_Name = {
    Text = "혼돈: 「24」의 크리티컬 확률 및 크리티컬 피해 +[StateArg4]%. 키오더 사용 시마다 「24」의 광기 폭발 최종 피해 [StateArg1]% 증가"
  },
  State_47894_Name = {
    Text = "초차원: \"24\"가 주는 피해에 [StateArg5]% <RetaliateIconKeywords:반격> 보너스 적용, 턴 종료 시 버린 카드 더미에 「영감」 1장 추가, 손패 상한 +2"
  },
  State_48009_Desc = {
    Text = "매 턴 처음 사용 시 추가로 [StateArg1]회 발동한다."
  },
  State_48009_Name = {
    Text = "<Rune_19:합주>"
  },
  State_48010_Desc = {
    Text = "합주 표식"
  },
  State_48010_Name = {
    Text = "합주 표식"
  },
  State_48011_Desc = {
    Text = "매 턴 처음 사용 시 추가로 [StateArg1]회 발동한다."
  },
  State_48011_Name = {
    Text = "<Rune_19_High:고급 합주>"
  },
  State_48011_WeaponDesc = {
    Text = "사용 후 추가로 [StateArg1]회 발동하며, 소모된다."
  },
  State_48012_Desc = {
    Text = "각인된 카드가 매 턴 처음 사용될 때 2회 발동한다."
  },
  State_48012_Name = {
    Text = "<CardKeyWord:각인: 합주>"
  },
  State_48013_Desc = {
    Text = "각인된 카드가 매 턴 처음 사용될 때 3회 발동한다."
  },
  State_48013_Name = {
    Text = "<CardKeyWord:각인: 고급 합주>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:모의 연역>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:영혼의 탄생>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:안개 드리운 진실타래>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:별빛 모방>"
  },
  State_48099_Desc = {
    Text = "턴 종료 시 「24」가 [DescArg1]pt의 광기를 획득한다. 「24」가 광기 폭발을 발동할 때마다, 이 효과로 획득하는 광기가 1 증가한다."
  },
  State_48099_Name = {
    Text = "파블로프 행동 연구"
  },
  State_48099_WeaponDesc = {
    Text = "장착한 깨어남체의 턴 종료 후 광기 3pt를 획득한다. 장착한 깨어남체의 광기 회충이 10을 초과할 경우, 추가로 광기 2pt를 획득한다."
  },
  State_48100_Name = {
    Text = "상태@24 파블로프 행동 연구 카운트"
  },
  State_48100_WeaponDesc = {
    Text = "장착한 깨어남체의 턴 종료 후 광기 3pt를 획득한다. 장착한 깨어남체의 광기 회충이 10을 초과할 경우, 추가로 광기 2pt를 획득한다."
  },
  State_48107_Desc = {
    Text = "매 턴 장착한 깨어남체가 처음 사용하는 「스킬」의 피해가 [StateArg1]% 증가한다."
  },
  State_48107_Name = {
    Text = "거인의 검"
  },
  State_48108_Desc = {
    Text = "장착한 깨어남체가 매 턴 처음으로 「스킬」을 사용한 후, 그 스킬의 행동력 소모가 [StateArg1] 감소한 복사본 1장을 덱에 섞어 넣는다."
  },
  State_48108_Name = {
    Text = "회전, 회전"
  },
  State_48110_Desc = {
    Text = "「스킬」이 이번 턴의 다음 「타격」을 랜덤 대상으로 변경하고, 추가로 랜덤한 대상 [StateArg1]명을 공격하게 한다."
  },
  State_48110_Name = {
    Text = "거울 속의 사람"
  },
  State_48140_Desc = {
    Text = "탐색 시작 시, '24'는 우울한 인격 상태로 진입합니다.\n<School_1:혼돈·우울>: <Posse:[StateArg1]> 점의 은열쇠 에너지를 획득하고, 다음 은열쇠가 2회 발동됩니다.\n<School_1:혼돈·조증>: 3회 피해를 가하며, '24'가 가하는 모든 피해가 [StateArg2] 증가합니다.\n<School_2:심해·우울>: 대상에게 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 2턴 부여하고, 촉수 1개를 생성하며, <TentacleInjurieIconKeywords:촉수 피해>+ [StateArg3].\n<School_2:심해·조증>: 해당 피해는 [StateArg4]% <TentacleInjurieIconKeywords:촉수 피해> 보너스를 받으며, 모든 적에게 가한 피해의 30%만큼 <IntoxicationIconKeywords:중독>을 부여합니다.\n<School_3:혈육·우울>: <EmbryoFusionIconKeywords:배아 융합> +[Blood:StateArg5], [StateArg6] 점의 진홍빛 용광로 회복량을 축적합니다.\n<School_3:혈육·조증>: 피해는 6배의 <PowerIconKeywords:힘> 보너스를 받으며 대상에게 가한 피해의 200%만큼 <BleedingIconKeywords:출혈>을 부여하고, [StateArg7] 점의 <PowerIconKeywords:힘>을 획득합니다.\n<School_4:초차원·우울>: 「영감」 2장을 손에 추가하고, 대상의 <PowerIconKeywords:힘>을 임시로 [StateArg8] 감소시킵니다.\n<School_4:초차원·조증>: 가한 피해의 15%만큼 <RetaliateIconKeywords:반격>을 획득한 후, 다른 적들에게 동일한 양의 <FixedDamage:순수 피해>를 가합니다. 이번 턴에 「영감」을 1장 사용할 때마다 해당 피해가 이번 턴 내에 [StateArg9] 증가하며, 최대 [StateArg10] 증가합니다."
  },
  State_48140_Name = {
    Text = "계역과 인격 효과"
  },
  State_48141_Desc = {
    Text = "<School_1:혼돈>: 「24」의 크리티컬 확률과 크리티컬 피해가 +[StateArg4]% 증가한다. 열쇠 지령을 사용할 때마다, 「24」의 광기 폭발 최종 피해가 [StateArg1]% 증가한다.\n<School_2:심해>: 「24」가 주는 피해는 [StateArg2]%의 <TentacleInjurieIconKeywords:촉수 피해> 보너스를 받으며, 피해량의 10%만큼 <IntoxicationIconKeywords:중독>을 부여한다. 「24」의 광기 폭발이 적의 <IntoxicationIconKeywords:중독>을 50% 발동시킨다.\n<School_3:혈육>: 「24」가 행동력 1을 소모할 때마다 <EmbryoFusionIconKeywords:배아 융합> +[Blood:DescArg1], [StateArg3]pt의 <PowerIconKeywords:힘>을 획득한다. 「24」의 광기 폭발은 추가로 300% 힘 보너스를 받는다\n<School_4:초차원>: 「24」가 주는 피해는 [StateArg5]%의 <RetaliateIconKeywords:반격> 데미지 보너스를 받으며, 턴 종료 시 버린 카드 더미에 「영감」 1장을 섞어 넣고, 최대 손패 매수 +2."
  },
  State_48141_Name = {
    Text = "계역 효과"
  },
  State_48149_Name = {
    Text = "카드 특수 효과를 사용할 수 없음__[개발 전용]"
  },
  State_48176_Desc = {
    Text = "이번 체험에서 매 턴 행동력 1을 획득한다. 「24」는 행동력 1을 소모할 때마다 은열쇠 에너지 30을 획득한다."
  },
  State_48176_Name = {
    Text = "'24' 체험"
  },
  State_48198_Desc = {
    Text = "이번 체험에서 매 턴 「영감」 1장을 획득한다."
  },
  State_48198_Name = {
    Text = "'24' 체험"
  },
  State_48199_Desc = {
    Text = "이번 체험에서 매 턴 행동력 1을 획득한다."
  },
  State_48199_Name = {
    Text = "'24' 체험"
  },
  State_48589_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러질 때 깨어남하여 HP를 회복하고 원래의 2배로 증가하며 진정한 형태로 전투를 시작한다."
  },
  State_48589_Name = {
    Text = "미깨어남"
  },
  State_48607_Name = {
    Text = "공용 카드 원본 행동력 감소__「개발 전용」"
  },
  State_48822_Desc = {
    Text = "혈육 계역 메커니즘 턴 시작 시, 획득하는 배아 융합이 50% 증가한다."
  },
  State_48822_Name = {
    Text = "생생불식"
  },
  State_48923_Desc = {
    Text = "그림자 「24」가 깨어남했다. 마지막 「살려줘」를 사용하여 기회를 찾아라!"
  },
  State_48923_Name = {
    Text = "그림자 \"24\" 깨어남!"
  },
  State_48923_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_49063_Desc = {
    Text = "로탄의 「타격」 피해가 30% 증가한다."
  },
  State_49063_Name = {
    Text = "앙양된 전의"
  },
  State_49109_Desc = {
    Text = "카드가 유지를 획득하며, 턴 종료 시 손에 있을 경우 해당 명령 카드의 소모가 부여된 원본 복사본 1장을 획득한다."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:잉태>"
  },
  State_49109_WeaponDesc = {
    Text = "사용 후 추가로 [StateArg1]회 발동하며, 소모된다."
  },
  State_49148_Desc = {
    Text = "사망 후, 행동력 소모가 0이 아닌 카드 1장에 「변이 1」을 부여한다. 변이: 카드 상태로, 전투 종료 후에도 유지된다. 스택당 행동력 소모를 1 감소시키지만, 사용 후 스택당 무작위 변이 카드 1장을 손에 넣고(손패 상한 무시), 모든 변이를 제거한다."
  },
  State_49148_Name = {
    Text = "변이의 태아"
  },
  State_49149_Desc = {
    Text = "스택당 카드의 행동력 소모가 1 감소한다. 사용 후, 변이 1스택당 무작위 변이 카드 1장을 손에 넣고, 해당 상태를 제거한다. 이 상태는 전투 종료 후에도 유지된다."
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:변이 [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "사용 후 영구적으로 제거된다."
  },
  State_49207_Name = {
    Text = "열쇠 에너지 100 획득"
  },
  State_49225_Desc = {
    Text = "턴 종료 후, 촉수 1개가 [Layer]회 공격한다."
  },
  State_49225_Name = {
    Text = "<CardKeyWord:촉수 집결>"
  },
  State_49226_Desc = {
    Text = "턴 종료 시, 손패 1장당 모든 적의 중독을 3% 발동시키고, 광기 3pt를 획득한다."
  },
  State_49226_Name = {
    Text = "희미한 촛불"
  },
  State_49260_Desc = {
    Text = "턴 종료 시 체질의 7.5%만큼 HP를 회복한다."
  },
  State_49260_Name = {
    Text = "수용되지 않은 아픔"
  },
  State_49270_Desc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_49270_Name = {
    Text = "타격 카드 피해 증가"
  },
  State_49270_WeaponDesc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_49278_Desc = {
    Text = "턴 종료 시, 잃은 HP의 5%를 회복한다. HP가 50%([StateArg1]) 미만일 경우, [StateArg2]의 힘을 추가로 획득한다."
  },
  State_49278_Name = {
    Text = "핏빛 성단"
  },
  State_49430_Desc = {
    Text = "받는 피해가 감소하며, 스택당 1%씩 감소한다. 다른 아군이 사망하면 이 상태가 제거된다."
  },
  State_49430_Name = {
    Text = "<AberrationColour:은폐>"
  },
  State_49500_Desc = {
    Text = "스택당 공격 횟수가 1 증가하며, 피해를 받으면 1스택이 감소한다. 턴 종료 시 모든 스택이 사라진다."
  },
  State_49500_Name = {Text = "기도"},
  State_49524_Desc = {
    Text = "턴 종료 시, 잃은 HP의 5%를 회복한다. 플레이어가 상태 카드나 증상 카드를 1장 드로우할 때마다 모든 「누비아」가 [StateArg1]의 임시 힘을 획득한다."
  },
  State_49524_Name = {
    Text = "핏빛 복음"
  },
  State_49526_Desc = {
    Text = "사망 후 즉시 HP를 [StateArg2]로 회복하고 1턴간 피해를 면역하며, 의도를 「오염 살포」로 조정한다."
  },
  State_49526_Name = {Text = "파종"},
  State_49542_Desc = {
    Text = "팀 유일: 전투 시작 후, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 힘을 획득한다. 현재 계역이 「심해」일 경우, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg2]%>만큼의 촉수 피해가 추가로 증가한다."
  },
  State_49542_WeaponDesc = {
    Text = "전투 시작 후, <WeaponEffect_Num:[Power:DescArg1]>의 힘을 획득한다. 현재 계역이 「심해」일 경우, <WeaponEffect_Num:[DescArg2]>의 촉수 피해를 추가로 획득한다."
  },
  State_49546_Desc = {
    Text = "항상 정예 경비병 2명과 함께 등장한다. 자신이 사망하면 그들도 함께 사망한다."
  },
  State_49546_Name = {Text = "열진"},
  State_49547_Desc = {
    Text = "사망 후, 아란 대장이 [StateArg1]의 힘과 최대 HP의 50%에 해당하는 실타래드를 획득한다."
  },
  State_49547_Name = {Text = "충성"},
  State_49558_Desc = {
    Text = "매 턴 힘이 [StateArg1] 증가한다."
  },
  State_49558_Name = {
    Text = "모래의 기원"
  },
  State_49582_Desc = {
    Text = "이번 전투에서 매 턴 남은 실타래드는 제거되지 않고 계속 유지된다."
  },
  State_49582_Name = {
    Text = "실타래드 영구 유지"
  },
  State_49583_Desc = {
    Text = "턴 종료 시, [StateArg1]의 실타래드를 획득하며, 경계 보너스가 적용된다."
  },
  State_49583_Name = {
    Text = "아란의 실타래드"
  },
  State_49595_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_49595_Name = {
    Text = "미깨어남"
  },
  State_49596_Desc = {
    Text = "「공상의 검」이 깨어남하여, 더 많은 실타래드와 힘을 획득하게 되었다."
  },
  State_49596_Name = {
    Text = "엘바 깨어남!"
  },
  State_49596_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_49597_Name = {
    Text = "이번 턴에 이미 마비됨__[개발 전용]"
  },
  State_49600_Desc = {
    Text = "전체 적에게 2턴간 허약을 부여한다."
  },
  State_49600_Name = {
    Text = "공포의 피"
  },
  State_49601_Desc = {
    Text = "전체 적에게 2턴간 취약을 부여한다."
  },
  State_49601_Name = {
    Text = "부패의 피"
  },
  State_49602_Desc = {
    Text = "전체 적에게 1턴간 취약을 부여한다."
  },
  State_49602_Name = {
    Text = "부패의 피"
  },
  State_49603_Desc = {
    Text = "배아 융합 +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "생식의 피"
  },
  State_49604_Desc = {
    Text = "배아 융합 +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "생식의 피"
  },
  State_49605_Desc = {
    Text = "전체 적에게 1턴간 허약을 부여한다."
  },
  State_49605_Name = {
    Text = "공포의 피"
  },
  State_49623_Desc = {
    Text = "받는 HP 회복량이 [DescArg1]% 감소한다. 턴 종료 시 1스택이 제거된다."
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:중상>"
  },
  State_49623_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_49627_Desc = {
    Text = "초기에 <PVPProtectiveKeywords:장벽> 2스택을 보유한다. 사망 시, 모든 「누비아」가 [StateArg1]의 힘을 획득한다."
  },
  State_49627_Name = {
    Text = "혈맥 분출"
  },
  State_49628_Desc = {
    Text = "사망 시, 모든 「누비아」가 [StateArg1]의 힘을 획득한다."
  },
  State_49628_Name = {
    Text = "혈맥 연결"
  },
  State_49638_Desc = {
    Text = "블랙 산양 시리즈 몬스터인지 확인하는 상태"
  },
  State_49833_Desc = {
    Text = "턴 종료 시, 모든 적에게 1턴간 「실타래명」 상태를 부여한다. 자신의 실타래드가 파괴되면, 「실타래명」 상태가 취소된다."
  },
  State_49833_Name = {
    Text = "모래먼지 벽장"
  },
  State_49844_Desc = {
    Text = "팀 유일: 턴 종료 후 <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 죽음 저항이 발동된 후 <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다. 응급 영지체 사용 후, 행동력 상한이 3 증가하고, 매 턴 드로우 수가 3 증가한다."
  },
  State_49844_WeaponDesc = {
    Text = "턴 종료 후 <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 죽음 저항이 발동된 후 <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다. 응급 영지체 사용 후, 행동력 상한이 3 증가하고, 매 턴 드로우 수가 3 증가한다."
  },
  State_49877_Desc = {
    Text = "카드의 행동력 소모를 감소시킨다. 사용 후, 변이 1스택당 무작위 변이 카드 1장을 손에 넣고, 해당 상태를 제거한다. 이 상태는 전투 종료 후에도 유지된다."
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:변이>"
  },
  State_49877_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_49954_Desc = {
    Text = "모든 깨어남체의 치명타 피해 수치가 절반으로 감소한다."
  },
  State_49954_Name = {
    Text = "<BlindingKeywords:실타래명>"
  },
  State_49954_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_49957_Desc = {
    Text = "능동 피해를 받을 때 각성체를 공격하는 광기 폭발과 모든 카드를 1턴 봉인하고, <ResentChainsKeywords:증오의 사슬> 1스택 제거. 턴 종료 시 초기화."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:원한의 사슬>"
  },
  State_49957_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_49958_Desc = {
    Text = "능동 피해 및 촉수 피해를 받을 때, 공격 각성체의 광기 폭발과 모든 카드를 1턴 봉인하고, <ResentChainsKeywords:증오의 사슬> 1층을 제거합니다."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:원한의 사슬>"
  },
  State_49959_Desc = {
    Text = "매 턴 시작 시, <ResentChainsKeywords:원한의 사슬> 1스택을 획득한다."
  },
  State_49959_Name = {
    Text = "다차원의 자물쇠"
  },
  State_50010_Desc = {
    Text = "받는 HP 회복량이 25% 감소한다. 턴 종료 시 1스택이 제거된다."
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:중상>"
  },
  State_50021_Desc = {
    Text = "팀 유니크: 장착자가 광기 폭발을 사용한 후 장착자 공격의 <WeaponEffect_Num:[StateArg1]%> 에 해당하는 <PowerIconKeywords:힘>을 획득합니다. 현재 영역이 「혈육」인 경우 광기 폭발 사용 후 배아 융합 <WeaponEffect_Num:+[Blood:StateArg2]> 이 적용됩니다."
  },
  State_50021_WeaponDesc = {
    Text = "장착자가 광기 폭발을 사용한 후 <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:힘>을 획득합니다. 현재 영역이 「혈육」인 경우 광기 폭발 사용 후 배아 융합 <WeaponEffect_Num:+[Blood:StateArg2]> 이 적용됩니다."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 치명적 피해를 1회 저항하고 이 「명륜」을 파괴하며, [StateArg1]스택의 <PVPProtectiveKeywords:장벽>을 획득한다. 발동 시 유일한 생존 아군일 경우, 다음 턴 시작 시 무작위 「열쇠 지령」 [StateArg2]장을 획득한다."
  },
  State_50302_Name = {
    Text = "극야와 새벽"
  },
  State_50323_Desc = {
    Text = "다음 턴 시작 전, 랜덤한 열쇠 지령을 [Layer]장 획득한다."
  },
  State_50323_Name = {
    Text = "지연 열쇠 지령"
  },
  State_50333_Desc = {
    Text = "턴 종료 시 모든 깨어남체가 광기를 잃는다."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:공허>"
  },
  State_50333_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_50352_Name = {
    Text = "타이스 체험"
  },
  State_50353_Name = {
    Text = "타이스 체험"
  },
  State_50358_Desc = {
    Text = "받는 피해가 감소하며, 스택당 1%씩 감소한다. 다른 아군이 사망하면 이 상태가 제거된다."
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:은폐>"
  },
  State_50375_Desc = {
    Text = "해당 효과에는 다음이 포함된다: 자신이 광기 10pt를 획득하고, 다른 아군이 광기 5pt를 획득하며, 전체 적에게 취약 1스택과 허약 1스택을 부여하고, 카드 1장을 뽑으며, 은열쇠 에너지 200pt를 획득한다."
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:기묘한 긍정 효과>"
  },
  State_50389_Desc = {
    Text = "턴 시작 시, 「라이커의 행운 주사위」 1장을 손에 넣는다."
  },
  State_50389_Name = {
    Text = "라이커의 지원"
  },
  State_50390_Desc = {
    Text = "턴 시작 시, [StateArg1]의 힘을 획득한다."
  },
  State_50390_Name = {
    Text = "전장의 통찰"
  },
  State_50491_Name = {
    Text = "시령추「균형」"
  },
  State_50735_Desc = {
    Text = "처음으로 패배 직전에 HP를 회복하고 의도를 「비통의 찢기」로 전환하여 매우 높은 단일 피해를 준다."
  },
  State_50735_Name = {
    Text = "무의미한 결의"
  },
  State_50854_Desc = {
    Text = "전투 시작 시, [StateArg1] 점의 <RetaliateIconKeywords:반격>을 획득합니다. 턴 종료 후 [StateArg2] 점의 방어막을 획득하며, 매 턴마다 이 방어막은 [StateArg3] 증가합니다."
  },
  State_50854_Name = {
    Text = "강한 나무껍질"
  },
  State_50861_Desc = {
    Text = "더 이상 피해를 받지 않으며, 「만천자식의 어머니」를 준비한다."
  },
  State_50861_Name = {Text = "파생"},
  State_50862_Desc = {
    Text = "더 이상 피해를 받지 않으며, 「번식」을 준비한다."
  },
  State_50862_Name = {Text = "부화"},
  State_50863_Desc = {
    Text = "더 이상 피해를 받지 않으며, 「광란의 나무 수액」을 발동할 준비를 한다."
  },
  State_50863_Name = {Text = "면역"},
  State_50864_Desc = {
    Text = "더 이상 피해를 받지 않으며, 「나무 수액」을 발동할 준비를 한다."
  },
  State_50864_Name = {Text = "면역"},
  State_50891_Desc = {
    Text = "더 이상 피해를 받지 않으며, 「다중 융합」을 준비한다."
  },
  State_50891_Name = {Text = "포식"},
  State_51016_Desc = {
    Text = "받는 중독 효과가 1000%로 증가한다."
  },
  State_51016_Name = {
    Text = "썩은 나무"
  },
  State_51017_Desc = {
    Text = "받는 중독 효과가 500%로 증가한다."
  },
  State_51017_Name = {
    Text = "썩은 나무"
  },
  State_51607_Desc = {
    Text = "모든 피해를 면역하며, 턴 시작 후 제거된다."
  },
  State_51607_Name = {
    Text = "피해 면역"
  },
  State_51695_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_51695_Name = {
    Text = "미깨어남"
  },
  State_51696_Desc = {
    Text = "「바다의 사도」가 깨어남했으며, 그녀는 광기 폭발에 대해 더 강력한 대응 수단을 가졌다."
  },
  State_51696_Name = {
    Text = "미리암 깨어남!"
  },
  State_51696_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_51739_Desc = {
    Text = "턴 종료 시 무작위로 「신국의 환영」 1장을 획득한다. 해제할 수 없다."
  },
  State_51739_Name = {
    Text = "신앙의 종말"
  },
  State_51740_Desc = {
    Text = "전투 시작 시, 「집착」 1장을 손에 넣는다."
  },
  State_51740_Name = {
    Text = "불멸의 경건"
  },
  State_51741_Desc = {
    Text = "턴 시작 시 [Layer]pt의 실타래드를 획득한다. 해제할 수 없다."
  },
  State_51741_Name = {
    Text = "확고한 자아"
  },
  State_51742_Desc = {
    Text = "턴 시작 시 촉수 피해와 힘이 [Layer] 증가한다. 해제할 수 없다."
  },
  State_51742_Name = {
    Text = "헌신의 계시"
  },
  State_51743_Desc = {
    Text = "이번 턴에 촉수가 공격할 때마다, 촉수 자세에 따라 다음 효과를 획득한다. 조수: 모든 깨어남체가 <Energy:[Energy:StateArg1]>의 광기를 획득한다. 정해: 모든 적에게 [StateArg2]pt의 <IntoxicationIconKeywords:중독>을 부여한다. 노도: 임시 <TentacleInjurieIconKeywords:촉수 피해>가 [StateArg3] 증가한다."
  },
  State_51743_Name = {
    Text = "모신의 축복"
  },
  State_51745_Desc = {
    Text = "바다의 사도가 카드를 1장 사용할 때, [StateArg1]개의 임시 촉수를 생성하며, 이 촉수는 촉수 상한을 무시한다."
  },
  State_51745_Name = {
    Text = "대행 권능"
  },
  State_51745_WeaponDesc = {
    Text = "바다의 사도가 카드를 1장 사용할 때, [StateArg1]개의 임시 촉수를 생성하며, 이 촉수는 촉수 상한을 무시한다."
  },
  State_51811_Name = {
    Text = "인도하는 돛 치유 효과__[개발 전용]"
  },
  State_51813_Desc = {
    Text = "턴 종료 후, 행동력 소모가 [Layer] 감소하며, 버려진 후에도 이 효과가 발동된다."
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:예비[Layer]>"
  },
  State_51820_Desc = {
    Text = "「잉태」가 추가 효과를 획득한다: 5스택일 때 즉시 「물의 자식」 1명을 소환하며, 최대 2명의 「물의 자식」까지 존재할 수 있다."
  },
  State_51820_Name = {
    Text = "미리암 깨어남"
  },
  State_51822_Desc = {
    Text = "광기 폭발을 발동할 때마다 「잉태」 1스택이 증가하며, 잉태 1스택당 [StateArg1]의 힘을 획득한다. 최대 5스택까지 증가할 수 있다."
  },
  State_51822_Name = {
    Text = "레무리아의 최종 강신"
  },
  State_52068_Desc = {
    Text = "손에 있는 최대 3장의 「성례」를 「집착」으로 전환하며, 전환된 수량에 따라 단계별 추가 효과를 획득한다."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:제의>"
  },
  State_52087_Desc = {
    Text = "「불멸의 극락조」는 [Layer]턴 후에 다시 부활 가능 상태를 부여할 수 있다."
  },
  State_52087_Name = {
    Text = "부활 쿨다운"
  },
  State_52116_Desc = {
    Text = "턴 종료 전까지, 해당 깨어남체가 광기 폭발을 사용한 후 [Layer]의 피해를 받는다."
  },
  State_52116_Name = {
    Text = "폭발 봉인"
  },
  State_52369_Desc = {
    Text = "[DescArg1]장의 증상 카드를 사용한 후, 툴루의 지원 카드 「왕권」을 획득한다: 큰 피해를 주고, 대상을 1턴간 기절시킨다."
  },
  State_52369_Name = {
    Text = "신국의 재림"
  },
  State_53115_Desc = {
    Text = "이번 턴 미리암이 다음에 발동하는 「제의」 효과가 50% 증가한다."
  },
  State_53115_Name = {
    Text = "심연을 향한 기도"
  },
  State_53144_Desc = {
    Text = "매 턴 시작 시 <Block:[Block:StateArg1]>의 실타래드를 획득한다."
  },
  State_53144_Name = {
    Text = "<CardKeyWord:자아 견지>"
  },
  State_53145_Desc = {
    Text = "매 턴 시작 시 <PowerIconKeywords:힘>과 <TentacleInjurieIconKeywords:촉수 피해>가 [StateArg2] 증가한다."
  },
  State_53145_Name = {
    Text = "<CardKeyWord:헌신의 계시>"
  },
  State_53673_Desc = {
    Text = "선체 분열의 최대 보유 수량은 10장이다."
  },
  State_53673_Name = {
    Text = "선체 분열 제한"
  },
  State_53674_Desc = {
    Text = "손패 상한이 2 증가한다. 턴 시작 시, 미리암이 광기 20을 획득한다."
  },
  State_53674_Name = {
    Text = "미리암 체험"
  },
  State_53755_Desc = {
    Text = "모든 깨어남체가 부여하는 <PowerIconKeywords:힘>, <RetaliateIconKeywords:반격>, <IntoxicationIconKeywords:중독>이 [DescArg1]% 증가한다. 「분화 장편」이 부여하는 <PowerIconKeywords:힘>이 증가한다."
  },
  State_53755_Name = {
    Text = "기이시편·공포"
  },
  State_53756_Desc = {
    Text = "모든 깨어남체가 획득하는 광기가 [DescArg1]% 증가하며, 턴 종료 시의 행동력과 명령 카드는 다음 턴까지 유지된다. 「분화 장편」이 주는 광기 획득량이 증가한다."
  },
  State_53756_Name = {
    Text = "환몽시편·희"
  },
  State_53758_Desc = {
    Text = "모든 깨어남체가 주는 최종 피해가 [DescArg1]% 증가하며, 「분화 장편」이 증가시키는 치명타율과 치명타 피해가 증가한다."
  },
  State_53758_Name = {
    Text = "망상시편·노"
  },
  State_53759_Desc = {
    Text = "모든 깨어남체가 주는 실타래드와 HP 회복, 부여하는 <PowerIconKeywords:힘> 감소 효과가 [DescArg1]% 증가하며, 「분화 장편」이 주는 회복량이 증가한다."
  },
  State_53759_Name = {
    Text = "애통시편·애"
  },
  State_53772_Name = {
    Text = "장식품 이율배반"
  },
  State_53772_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 아군이 장착한 깨어남체의 방어력의 100%만큼 <RetaliateIconKeywords:반격>을 획득한다. 그리고 자신의 현재 <RetaliateIconKeywords:반격>이 10% 증가한다."
  },
  State_53870_Name = {
    Text = "장식품 36호실타래의 고리"
  },
  State_53870_WeaponDesc = {
    Text = "장착한 깨어남체의 카드를 드로우할 때, 해당 카드의 행동력 소모가 0~3 사이에서 무작위로 변화한다."
  },
  State_53981_Name = {
    Text = "장식품 약재의 꿈 검은 인장 교정"
  },
  State_53981_WeaponDesc = {
    Text = "전투 시작 후, 추가로 장착한 깨어남체의 한 세트 카드를 덱에 섞어 넣는다."
  },
  State_54002_Name = {
    Text = "상태@장식품 약재의 꿈 필터링 표식"
  },
  State_54002_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 아군이 장착한 깨어남체의 방어력의 100%만큼 <RetaliateIconKeywords:반격>을 획득한다. 그리고 자신의 현재 <RetaliateIconKeywords:반격>이 10% 증가한다."
  },
  State_54011_Name = {
    Text = "상태@장식품 약재의 꿈 복제1 사용 가능"
  },
  State_54011_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 아군이 장착한 깨어남체의 방어력의 100%만큼 <RetaliateIconKeywords:반격>을 획득한다. 그리고 자신의 현재 <RetaliateIconKeywords:반격>이 10% 증가한다."
  },
  State_54012_Name = {
    Text = "상태@장식품 약재의 꿈 복제2 사용 가능"
  },
  State_54012_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 아군이 장착한 깨어남체의 방어력의 100%만큼 <RetaliateIconKeywords:반격>을 획득한다. 그리고 자신의 현재 <RetaliateIconKeywords:반격>이 10% 증가한다."
  },
  State_54013_Desc = {
    Text = "이번 턴 내에서 영역 숙련이 [Layer]pt 증가한다."
  },
  State_54013_Name = {
    Text = "임시 영역 숙련"
  },
  State_54014_Desc = {
    Text = "영역 숙련이 [Layer]pt 증가한다."
  },
  State_54014_Name = {
    Text = "영역 숙련"
  },
  State_54043_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 이번 턴 내에서 자신의 실타래드와 치유 강효가 2배로 증가한다."
  },
  State_54044_Desc = {
    Text = "2배의 피해를 입히고 환형 라모나의 은열쇠 충전에 상응하는 은열쇠 에너지를 추가로 600% 획득하지만, 사용 후 <DepleteIconKeywords:소모>됩니다."
  },
  State_54044_Name = {
    Text = "미래 찬가"
  },
  State_54045_Desc = {
    Text = "행동력 3pt를 획득한다."
  },
  State_54045_Name = {
    Text = "윤회의 정원"
  },
  State_54046_Desc = {
    Text = "턴 시작 시, [StateArg1]의 HP를 회복하며, [Layer]턴 동안 지속된다."
  },
  State_54046_Name = {
    Text = "이성, 진리와 현실타래"
  },
  State_54071_Desc = {
    Text = "오지에가 가하는 능동 피해 횟수 +1, [Layer] 턴 동안 지속됩니다."
  },
  State_54071_Name = {
    Text = "칠예, 팔덕"
  },
  State_54121_Desc = {
    Text = "이번 전투에서 「혼돈의 짐승」이 주는 기본 피해가 [Layer]% 증가한다."
  },
  State_54121_Name = {
    Text = "혼돈의 짐승"
  },
  State_54138_Desc = {
    Text = "소렐이 다음에 사용하는 [Layer]장의 명령 카드가 2회 발동한다."
  },
  State_54138_Name = {
    Text = "욕망의 난무"
  },
  State_54384_Desc = {
    Text = "님피아가 부여하는 <IntoxicationIconKeywords:중독>이 50% 증가하며, [Layer]턴 동안 지속된다."
  },
  State_54384_Name = {
    Text = "자아의 장례식"
  },
  State_54416_Desc = {
    Text = "깨어남체의 최대 광기 보유량이 2배로 증가한다. 광기가 기본 광기의 2배에 도달하면 초한 폭발을 발동할 수 있으며, 광기 폭발 발동 후 남은 광기가 절반으로 감소한다."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:초한 폭발>"
  },
  State_54416_WeaponDesc = {
    Text = "손의 배아를 소모하여 강력한 포식 효과를 발동한다."
  },
  State_54561_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 피해가 장착한 깨어남체의 공격력의 <WeaponEffect_Num:[StateArg1]%>만큼 증가한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체가 포식 효과를 발동할 때마다 추가로 장착한 깨어남체가 주는 피해가 장착한 깨어남체의 공격력의 3%만큼 증가한다."
  },
  State_54561_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 피해가 [DescArg1] 증가한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체가 포식 효과를 발동할 때마다 추가로 장착한 깨어남체가 주는 피해가 [DescArg2] 증가한다."
  },
  State_54568_Name = {
    Text = "행성의 종말에 이를 때까지"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 적의 깨어남체가 사망한 후, [StateArg1] <StrongEffectKeywords:증폭>을 얻고, 그의 산출력 소모가 가장 높으며 <PVPVoidKeywords:허무>가 부여된 「스킬」을 손에 넣습니다."
  },
  State_54597_Name = {
    Text = "무수한 총애의 시선"
  },
  State_54704_Desc = {
    Text = "「24」의 다음 명령 카드가 3회 발동한다."
  },
  State_54704_Name = {
    Text = "뒤틀린 시체의 광연"
  },
  State_54798_Desc = {
    Text = "모든 깨어남체가 주는 실타래드, HP 회복, 힘 감소 효과가 [StateArg1]% 증가하며, 분화 장편의 회복 효과가 증가한다."
  },
  State_54798_Name = {Text = "「애」"},
  State_54799_Desc = {
    Text = "모든 깨어남체가 주는 반격, 중독, 힘 획득 효과가 [StateArg1]% 증가한다. 분화 장편의 힘 획득량이 증가한다."
  },
  State_54799_Name = {
    Text = "「공포」"
  },
  State_54800_Desc = {
    Text = "모든 깨어남체가 주는 최종 피해가 [StateArg1]% 증가하며, 분화 장편의 치명타율과 치명타 피해가 증가한다."
  },
  State_54800_Name = {Text = "「노」"},
  State_55108_Desc = {
    Text = "턴 시작 시 손에 있는 「푸른 불꽃」 또는 「부패의 푸른 불꽃」을 「사멸의 푸른 불꽃」으로 승급한다. [Layer]턴 동안 지속된다."
  },
  State_55108_Name = {
    Text = "사멸 강림"
  },
  State_55108_WeaponDesc = {
    Text = "턴 시작 시 손 또는 초차원 공간에 있으면 강화된다."
  },
  State_55113_Desc = {
    Text = "올라가 매 턴 첫 번째 시편을 사용한 후, 광기 10을 획득한다."
  },
  State_55113_Name = {
    Text = "꽃과 시의 재회"
  },
  State_55465_Name = {
    Text = "은유「노」 [Layer]스택 소모, 추가로 [DescArg1]회 피해를 입힘"
  },
  State_55466_Name = {
    Text = "은유「애」 [Layer]스택 소모, HP <Heal:[Heal:DescArg1]>pt 회복"
  },
  State_55467_Name = {
    Text = "은유「공포」 [Layer]스택 소모, <PowerIconKeywords:힘> [Power:DescArg1]pt 추가 획득"
  },
  State_55469_Name = {
    Text = "은유「희」 [Layer]스택 소모, 광기 <Energy:[Energy:DescArg1]>pt 추가 획득"
  },
  State_55470_Name = {
    Text = "경추 절단"
  },
  State_55485_Desc = {
    Text = "카시아가 사용하는 다음 [Layer]장의 카드가 자신의 공격력 10%에 해당하는 힘을 획득합니다."
  },
  State_55485_Name = {
    Text = "유쾌한 웃음"
  },
  State_55486_Name = {
    Text = "죽음의 꿈도시 초월 폭발 시 꿈의 인도 소모 면제"
  },
  State_55487_Desc = {
    Text = "에리카의 「타격」이 추가로 2회 데미지를 주고, 「방어」가 추가로 2회 방어막을 얻으며, 지속 [Layer] 턴입니다."
  },
  State_55487_Name = {
    Text = "다중 계산"
  },
  State_55489_Name = {
    Text = "시공간 점프"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:헌시>: 전체 적에게 부정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여 또는 전체 아군에게 긍정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여 또는 카드 1장을 뽑고 행동력 1pt 획득. 마지막 헌시는 2회 발동된다"
  },
  State_55807_Name = {
    Text = "카드 1장을 뽑고 행동력 1pt 획득"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:헌시>: 전체 아군에게 긍정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여 또는 카드 1장을 뽑고 행동력 1pt 획득. 마지막 헌시는 2회 발동된다"
  },
  State_55809_Name = {
    Text = "전체 적에게 부정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여"
  },
  State_55811_Desc = {
    Text = "제시된 옵션 중 하나를 선택하여 적용한다."
  },
  State_55811_Name = {
    Text = "<ComaColour:결정>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:헌시>: 전체 적에게 부정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여 또는 카드 1장을 뽑고 행동력 1pt 획득. 마지막 헌시는 2회 발동된다"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:헌시>: 전체 적에게 부정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여 또는 전체 아군에게 긍정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여. 마지막 헌시는 2회 발동된다"
  },
  State_55816_Name = {
    Text = "전체 아군에게 긍정적 <PVPWonderfulEffectKeywords:기묘한 효과> 부여"
  },
  State_55824_Desc = {
    Text = "제시된 옵션 중 하나를 선택하여 적용하며, 선택한 옵션은 제거된다. 남은 옵션이 있을 경우 이 카드를 상대의 손에 넣는다."
  },
  State_55824_Name = {
    Text = "<ComaColour:시를 바치다>"
  },
  State_55836_Desc = {
    Text = "턴 종료 시, 손에 있는 올라가의 명령 카드 행동력 소모가 1 감소한다."
  },
  State_55836_Name = {
    Text = "묵으로 물든 시"
  },
  State_55839_Desc = {
    Text = "획득 시 다른 모든 유물을 잃고, 무작위로 황금 유물 2개를 획득한다."
  },
  State_55866_Desc = {
    Text = "팀 유일: 전투 시작 시 장착한 깨어남체의 명령 카드 1장을 드로우하며, <WeaponEffect_Num:[StateArg1]%> 확률로 해당 카드의 행동력 소모가 1 감소한다. 죽음 저항이 발동될 때마다 이 효과가 1회 반복된다."
  },
  State_55866_WeaponDesc = {
    Text = "전투 시작 시 장착한 깨어남체의 명령 카드 1장을 드로우하며, <WeaponEffect_Num:[StateArg1]%> 확률로 해당 카드의 행동력 소모가 1 감소한다. 죽음 저항이 발동될 때마다 이 효과가 1회 반복된다."
  },
  State_55992_Desc = {
    Text = "행동력이 부족할 경우 카드에 소모와 표식을 부여한다."
  },
  State_55992_Name = {Text = "잔여"},
  State_55993_Name = {
    Text = "잔여 표식"
  },
  State_56018_Desc = {
    Text = "이번 전투에서 최대 HP가 [Layer]% 증가한다."
  },
  State_56018_Name = {
    Text = "뮤즈의 은혜 - 명"
  },
  State_56020_Desc = {
    Text = "이번 전투에서 피해량이 [Layer]% 증가한다."
  },
  State_56020_Name = {
    Text = "뮤즈의 은혜 - 힘"
  },
  State_56030_Desc = {
    Text = "이번 턴에 깨어남체가 주는 실타래드와 치유량이 [Layer]% 증가한다."
  },
  State_56030_Name = {Text = "눈"},
  State_56031_Desc = {
    Text = "이번 턴에 피해를 1회 줄 때마다, 임시 치명타율이 [Layer]% 증가한다."
  },
  State_56031_Name = {Text = "나비"},
  State_56034_Desc = {
    Text = "각 「은유」는 최대 3스택까지 중첩된다. 다른 「은유」는 시편의 다른 효과를 증폭시킨다:\n\n<망상 시편>: 모든 은유 「노」를 소모하며, 스택당 추가로 2회 피해를 준다.\n\n<애통 시편>: 모든 은유 「애」를 소모하며, 스택당 추가로 HP를 회복한다.\n\n<환몽 시편>: 모든 은유 「희」를 소모하며, 스택당 추가로 광기 10을 획득한다.\n\n<기묘 시편>: 모든 은유 「공포」를 소모하며, 스택당 추가로 <PowerIconKeywords:힘>을 획득한다."
  },
  State_56034_Name = {Text = "은유"},
  State_56208_Desc = {
    Text = "비의 예찬가: HP <Heal:[DescArg1]> 회복.\n바람의 송가: [DescArg2] 포인트 <PowerIconKeywords:힘> 획득.\n꽃의 찬미가: 모든 깨어남체가 [DescArg3] 포인트 광기 획득.\n달의 찬양가: 임시 크리티컬 확률 [DescArg4]% 증가."
  },
  State_56208_Name = {Text = "시편"},
  State_56330_Desc = {
    Text = "[DescArg1]의 실타래드를 획득한다. 이번 턴에 광기 폭발을 3회 발동했다면, 이 카드가 추가로 1회 발동한다."
  },
  State_56330_Name = {
    Text = "고급 이미지"
  },
  State_56331_Desc = {
    Text = "덱과 버린 카드 더미에서 명령 카드 1장을 선택하여 손에 넣고, 해당 카드의 행동력 소모를 2 감소시킨다."
  },
  State_56331_Name = {
    Text = "고급 이미지"
  },
  State_56332_Desc = {
    Text = "[DescArg1]의 임시 <PowerIconKeywords:힘>을 획득한다. 사용 후 이번 턴에 피해를 1회 줄 때마다 임시 치명타율이 3% 증가한다."
  },
  State_56332_Name = {
    Text = "고급 이미지"
  },
  State_56333_Desc = {
    Text = "잃은 HP의 10%를 회복한다. 현재 HP가 25% 미만일 경우, 이 카드가 추가로 1회 발동한다."
  },
  State_56333_Name = {
    Text = "고급 이미지"
  },
  State_56334_Desc = {
    Text = "다음 열쇠 지령이 2회 발동한다."
  },
  State_56334_Name = {
    Text = "고급 이미지"
  },
  State_56335_Desc = {
    Text = "자신의 최대 HP의 150%에 해당하는 <FixedDamage:순수 피해>를 입히며, 해당 피해는 10배의 <PowerIconKeywords:힘> 보정을 받습니다."
  },
  State_56335_Name = {
    Text = "고급 이미지"
  },
  State_56336_Desc = {
    Text = "카드 5장을 드로우한다."
  },
  State_56336_Name = {
    Text = "고급 이미지"
  },
  State_56337_Desc = {
    Text = "[DescArg1]의 임시 <AlertIconKeywords:경계>를 획득한다. 사용 후 이번 턴에 주는 실타래드와 회복량이 [DescArg2]% 증가한다."
  },
  State_56337_Name = {
    Text = "고급 이미지"
  },
  State_56338_Desc = {
    Text = "행동력 3을 획득한다."
  },
  State_56338_Name = {
    Text = "고급 이미지"
  },
  State_56339_Desc = {
    Text = "무작위 부정 상태 1개를 해제한다. 이 카드가 추가로 3회 발동되며, 소모된다."
  },
  State_56339_Name = {
    Text = "고급 이미지"
  },
  State_56340_Desc = {
    Text = "모든 적에게 3턴간 <VulnerabilityIconKeywords:취약>을 부여한다. 적이 사망할 때마다, 이 카드를 덱에서 손으로 가져온다."
  },
  State_56340_Name = {
    Text = "고급 이미지"
  },
  State_56341_Desc = {
    Text = "영역 숙련이 25 증가하고, 임시 영역 숙련이 125 증가한다."
  },
  State_56341_Name = {
    Text = "고급 이미지"
  },
  State_56342_Desc = {
    Text = "모든 깨어남체가 광기 15를 획득한다."
  },
  State_56342_Name = {
    Text = "고급 이미지"
  },
  State_56343_Desc = {
    Text = "모든 적에게 3턴간 <WeaknessIconKeywords:허약>을 부여하고, 이 카드의 복사본 1장을 버린 카드 더미에 넣으며, <DepleteIconKeywords:소모>, <NothingnessIconKeywords:허무>를 부여한다."
  },
  State_56343_Name = {
    Text = "고급 이미지"
  },
  State_56372_Desc = {
    Text = "사망 시, 플레이어가 마지막으로 획득한 부정 상태 1개를 제거한다."
  },
  State_56372_Name = {Text = "꽃과 시"},
  State_56400_Desc = {
    Text = "「타격」 후, 손에 있는 자신의 「스킬」이 순서대로 다른 「스킬」로 변화한다. [ShowIfState:， <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]"
  },
  State_56400_Name = {
    Text = "지난날의 꽃과 시"
  },
  State_56402_Desc = {
    Text = "은유 「노」 [DescArg2]스택 보유: 「망상 시편」이 도약을 발동할 때 추가로 피해를 준다.\n\n은유 「애」 [DescArg3]스택 보유: 「애통 시편」이 도약을 발동할 때 추가로 HP를 회복한다.\n\n은유 「희」 [DescArg1]스택 보유: 「환몽 시편」이 도약을 발동할 때 추가로 깨어남체가 광기를 획득한다.\n\n은유 「공포」 [DescArg4]스택 보유: 「기묘 시편」이 도약을 발동할 때 추가로 힘을 획득한다."
  },
  State_56402_Name = {Text = "은유"},
  State_57166_Desc = {
    Text = "깨어남체가 주는 피해가 25% 증가한다."
  },
  State_57170_Desc = {
    Text = "손패 상한이 2 증가한다. 턴 종료 시, 손패 1장을 선택하여 유지를 부여하고 그 카드의 행동력 소모를 1 감소시킨다. 3턴 동안 지속된다."
  },
  State_57170_Name = {
    Text = "항해의 빛"
  },
  State_57316_Desc = {
    Text = "매 턴 시작 시 「배아」 1장을 「성결의 자식」으로 전환한다. 「배아」가 없을 경우 <EmbryoFusionIconKeywords:배아 융합> +[Blood:DescArg1]. [Layer]턴 동안 지속된다."
  },
  State_57316_Name = {
    Text = "영속하는 성골의 계승"
  },
  State_57317_Desc = {
    Text = "이 명륜이 덱에 있을 때, 손에 있는 스킬이 곧 어떻게 변화할지 볼 수 있다."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:지난날의 꽃과 시>"
  },
  State_57324_Desc = {
    Text = "이 깨어남체가 「지난날의 꽃과 시」를 발동하면, 이 카드는 <CardKeyWord:<SkillName1:>>로 변한다."
  },
  State_57324_Name = {
    Text = "지난날의 꽃과 시"
  },
  State_57325_Desc = {
    Text = "이 깨어남체가 「지난날의 꽃과 시」를 발동하면, 이 카드는 <CardKeyWord:<SkillName2:>>로 변한다."
  },
  State_57325_Name = {
    Text = "지난날의 꽃과 시"
  },
  State_57326_Desc = {
    Text = "이 깨어남체가 「지난날의 꽃과 시」를 발동하면, 이 카드는 <CardKeyWord:<SkillName3:>>로 변한다."
  },
  State_57326_Name = {
    Text = "지난날의 꽃과 시"
  },
  State_57335_Name = {
    Text = "[DescArg1]배 힘 보너스 추가 적용"
  },
  State_57356_Name = {
    Text = "상태@침연자 반격 계산"
  },
  State_57368_Name = {
    Text = "상태@침연자 반격 점프대"
  },
  State_57413_Name = {
    Text = "실타래드 1pt당 이 카드의 피해가 [DescArg1]pt 증가"
  },
  State_57417_Desc = {
    Text = "죽음 저항이 발동될 때마다 100% 반격의 <FixedDamage:순수 피해>를 가하며, 이번 전투에서 죽음 저항이 발동될 때마다 <FixedDamage:순수 피해>가 25% 증가합니다."
  },
  State_57417_Name = {
    Text = "사랑의 요람"
  },
  State_57566_Name = {
    Text = "궁지 생존"
  },
  State_57587_Desc = {
    Text = "「선체 분열」을 사용할 때 카드 1장을 드로우한다. 남은 횟수는 [Layer]번이다."
  },
  State_57587_Name = {
    Text = "해파리 모여라!"
  },
  State_57665_Name = {
    Text = "신모의 가호"
  },
  State_57728_Desc = {
    Text = "유우하시의 피해 횟수가 1 증가한다."
  },
  State_57728_Name = {
    Text = "피의 선물"
  },
  State_57751_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 열쇠 지령 발동 후 모든 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 임시 치명타율과 치명타 피해를 획득하지만, 최대 HP의 3%만큼 희생을 부여한다. 현재 계역이 「심해」일 경우, 열쇠 지령 발동 후 촉수 피해가 장착한 깨어남체의 공격력의 <WeaponEffect_Num:[StateArg3]%>만큼 증가한다."
  },
  State_57751_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 열쇠 지령 발동 후 모든 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 임시 치명타율과 치명타 피해를 획득하지만, [DescArg1]의 희생을 부여한다. 현재 계역이 「심해」일 경우, 열쇠 지령 발동 후 촉수 피해가 [DescArg2] 증가한다."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [StateArg1]스택의 <PVPSleepKeywords:정제된 수면>을 획득한다."
  },
  State_57753_Name = {
    Text = "빙하 아래의 잠"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 매 턴 처음으로 「광기 폭발」한 후, 임시 <StrongEffectKeywords:강효> +[StateArg1]을 부여한다."
  },
  State_57766_Name = {
    Text = "목자의 지팡이"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <Energy:[Energy:StateArg1]>의 광기를 차감하여 <PVPDerivativeCardKeywords_12:「작은 소원」>으로 전환한다. 전환에 실타래패하면 <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_57767_Name = {
    Text = "끝없는 연주"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」의 피해가 [StateArg1]% 증가한다. 「광기 폭발」 후 잃은 HP의 [StateArg2]%를 회복한다."
  },
  State_57768_Name = {
    Text = "설산이 녹을 때까지"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체의 스킬 카드를 사용한 후, 장착한 깨어남체의 스킬 카드 1장을 뽑는다. 매 턴 최대 1회 발동한다."
  },
  State_57769_Name = {
    Text = "진리의 문"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 가하는 피해, 치유 및 방어막 효과 증가 [StateArg1]~[StateArg2]%(현재 [Layer] %), <PhantomKeywords:환영>."
  },
  State_57770_Name = {
    Text = "운명의 룰렛"
  },
  State_57814_Name = {
    Text = "이 표식이 존재할 경우, 명륜을 교체 중임을 나타낸다. 일부 로직은 이 표식을 인식해야 한다.「개발 전용」"
  },
  State_57817_Desc = {
    Text = "행동 불가. 턴 종료 시 스택이 1 감소하며, 스택 소진 시 <StrongEffectKeywords:강효> +5. 해제할 수 없음. 명륜 교체 시 정제된 수면 상태를 잃는다."
  },
  State_57817_Name = {
    Text = "정제된 수면"
  },
  State_57854_Desc = {
    Text = "턴 시작 시 [StateArg1]pt의 실타래드와 [StateArg2]pt의 촉수 피해를 획득하고, 임시 촉수 2개를 생성한다. [Layer]턴 동안 지속된다."
  },
  State_57854_Name = {
    Text = "자유의 맹세"
  },
  State_57854_WeaponDesc = {
    Text = "상태@심해 숙녀 홍차와 케이크"
  },
  State_57864_Name = {
    Text = "힘 보너스 갱신__[개발 전용]"
  },
  State_57942_Desc = {
    Text = "현재 융합도 [Layer]%이다. 융합도가 100%에 도달하면 적이 강제로 다음 단계로 진입하며, 더 강력한 단계 전환 스킬을 사용한다."
  },
  State_57942_Name = {Text = "융합도"},
  State_57952_Desc = {
    Text = "힘 감소 시, 힘 스택의 50%만 감소한다."
  },
  State_57952_Name = {Text = "심잠"},
  State_57953_Desc = {
    Text = "턴 종료 시, 촉수 1개를 생성한다. 깨어남 후 이 상태를 제거한다."
  },
  State_57953_Name = {Text = "깊은 잠"},
  State_57955_Desc = {
    Text = "히로가 주는 피해가 [StateArg1]% 증가하며, [Layer]턴 동안 지속된다."
  },
  State_57955_Name = {
    Text = "궁지 생존·피해"
  },
  State_57968_Desc = {
    Text = "율리에트의 영향을 받아, 매 턴 종료 후 쌍둥이 융합도가 10% 증가하고, 「변이」 1장을 덱에 섞어 넣는다."
  },
  State_57968_Name = {
    Text = "「율리에트의 노래」"
  },
  State_57970_Name = {
    Text = "신모의 가호"
  },
  State_57976_Desc = {
    Text = "「어둠의 아이」가 강제 융합을 실행한 후, 「망각의 시작」에게 자신의 현재 HP의 3배에 해당하는 <FixedDamage:순수 피해>를 입힙니다."
  },
  State_57976_Name = {Text = "희생"},
  State_58051_Desc = {
    Text = "치명타 피해가 [Layer]% 증가한다."
  },
  State_58051_Name = {
    Text = "치명타 피해"
  },
  State_58052_Desc = {
    Text = "탐색 중에 검은 인장 1pt를 소모할 때마다, 「올인」의 기본 피해가 0.5% 증가한다. (이미 [DescArg1]% 증가)"
  },
  State_58052_Name = {
    Text = "무조건 수익"
  },
  State_58061_Name = {
    Text = "습득물 반환"
  },
  State_58063_Desc = {
    Text = "깨어남체가 주는 피해가 25% 증가하며, [Layer]턴 동안 지속된다."
  },
  State_58063_Name = {
    Text = "만고를 초월한 응시"
  },
  State_58144_Desc = {
    Text = "이번 스테이지 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_58144_Name = {
    Text = "영구 치명타율"
  },
  State_58144_WeaponDesc = {
    Text = "이번 스테이지 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_58259_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 적을 처치한 후 <WeaponEffect_Num:[StateArg2]>의 검은 인장을 획득하며, 탐색 중 최대 3회 발동된다. 3회 발동 후 이번 탐색에서 장착한 깨어남체의 치명타율이 영구적으로 <WeaponEffect_Num:[StateArg3]%> 증가한다."
  },
  State_58259_WeaponDesc = {
    Text = "장착한 깨어남체의 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 적을 처치한 후 <WeaponEffect_Num:[DescArg2]>의 검은 인장을 획득하며, 탐색 중 최대 3회([DescArg1]/3) 발동된다. 3회 발동 후 이번 탐색에서 장착한 깨어남체의 치명타율이 영구적으로 <WeaponEffect_Num:[StateArg3]%> 증가한다."
  },
  State_58297_Desc = {
    Text = "라이커가 적을 처치할 경우 검은 인장 [DescArg3]개를 획득하며, 탐사 동안 최대 5회 적용됩니다 ([DescArg1]/5). \n전투를 통해 검은 인장 50/125/250개를 획득할 때마다 최대 유물 수량이 1 증가하며, 전투 종료 시 「혼돈의 유산」 중 하나를 선택하여 유물 목록에 추가합니다. (현재 획득한 검은 인장: [DescArg2])"
  },
  State_58297_Name = {
    Text = "승자독식"
  },
  State_58447_Desc = {
    Text = "다음 세 가지 유물을 포함한다:\n\n「행운의 코트」: 모든 깨어남체의 치명타율이 10% 증가한다. 모든 라이커와 주사위의 무작위 결과에 최솟값이 나오지 않는다.\n\n<업그레이드>: 치명타율 증가가 15%로 변경되며, 무작위 결과의 최댓값이 1 증가한다.\n\n「편방 주사위」: 열쇠 지령을 발동할 때마다 「<C05_yansheng1:편방 주사위>」 1장을 손에 넣는다.\n\n<업그레이드>: 「<C05_yansheng2:빛나는 편방 주사위>」 1장을 손에 넣는 것으로 변경된다.\n\n「큰입 단추」: 턴 시작 시 및 라이커 또는 주사위의 무작위 효과가 발동될 때, 은열쇠 에너지 50과 치명타 피해 2%를 획득하며, 최대 치명타 피해 30%까지 획득할 수 있다.\n\n<업그레이드>: 은열쇠 에너지 100과 치명타 피해 4%를 획득하며, 최대 치명타 피해 50%까지 획득할 수 있도록 변경된다."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:혼돈의 유산>"
  },
  State_58490_Desc = {
    Text = "졸음이 모두 제거될 때, 모든 깨어남체와 카드를 봉인하고, 「침묵의 군주」의 의도를 「왕권의 위엄」으로 조정한다."
  },
  State_58490_Name = {Text = "졸음"},
  State_58491_Desc = {
    Text = "카드를 사용할 때마다 「졸음」 1스택을 제거한다. 턴 시작 시 12스택의 「졸음」으로 회복된다."
  },
  State_58491_Name = {Text = "진노"},
  State_58492_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_58492_Name = {
    Text = "미깨어남"
  },
  State_58493_Desc = {
    Text = "카드를 사용할 때마다 「졸음」 1스택을 제거한다. 턴 시작 시 12스택의 「졸음」으로 회복된다."
  },
  State_58493_Name = {Text = "진노"},
  State_58947_Desc = {
    Text = "이번 스테이지 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_59078_Name = {
    Text = ", 1회 사용 가능"
  },
  State_59079_Name = {
    Text = ", 2회 사용 가능"
  },
  State_59080_Name = {
    Text = ", 3회 사용 가능"
  },
  State_59117_Desc = {
    Text = "치명타 피해가 [Layer]% 증가한다."
  },
  State_59117_Name = {
    Text = "치명타 피해"
  },
  State_59160_Desc = {
    Text = "입히는 모든 피해, 치료 및 방패 효과가 10% 증가하며, 해제가 불가합니다."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:강효>"
  },
  State_59161_Desc = {
    Text = "가하는 피해, 치료 및 방패 효과가 [DescArg1]% 증가하며, 해제 불가입니다."
  },
  State_59161_Name = {Text = "강효"},
  State_59169_Desc = {
    Text = "이 카드의 기본 행동력 소모는 행동력 상한을 초과하지 않는다.「개발 전용」"
  },
  State_59169_Name = {
    Text = "균형__「개발 전용」"
  },
  State_59173_Name = {
    Text = "이 표식이 존재할 경우, 다중 타격이 진행 중임을 나타내며, 다중 타격이 다시 발동되지 않는다.「개발 전용」"
  },
  State_59208_Desc = {
    Text = "입히는 모든 피해, 치료 및 방패 효과가 10% 감소하며, 해제가 불가합니다."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:강효 감소>"
  },
  State_59209_Desc = {
    Text = "가하는 피해, 치료 및 방패 효과가 [DescArg1]% 감소하며, 해제 불가입니다."
  },
  State_59209_Name = {
    Text = "강효 감소"
  },
  State_59423_Desc = {
    Text = "라이커가 적을 처치할 경우 검은 인장 5개를 획득하며, 라이커의 검은 인장 드롭율이 1% 증가할 때마다 획득량이 1% 증가합니다. 탐사 동안 최대 5회 적용됩니다. 전투를 통해 검은 인장 50/125/250개를 획득할 때마다 최대 유물 수량이 1 증가하며, 전투 종료 시 「혼돈의 유산」 중 하나를 선택하여 유물 목록에 추가합니다."
  },
  State_59423_Name = {
    Text = "승자독식"
  },
  State_59424_Desc = {
    Text = "탐색 중에 검은 인장 1pt를 소모할 때마다, 「올인」의 기본 피해가 0.5% 증가한다."
  },
  State_59424_Name = {
    Text = "무조건 수익"
  },
  State_59439_Desc = {
    Text = "이 상태는 취약 곱셈 구역을 사용하며, 독립적인 곱셈 구역인 척한다. 「개발 전용」"
  },
  State_59439_Name = {
    Text = "특정 상태를 보유하고 있으면 받는 피해가 2배로 증가함__[개발 전용]"
  },
  State_59519_Name = {
    Text = "덱 또는 버린 카드 더미에서 명령 카드 1장을 선택하여 손에 넣고, 행동력 소모를 0으로 만든다."
  },
  State_59520_Desc = {
    Text = "사용 후 카드 2장을 드로우하고, 각인 카드의 실타래제 행동력 소모만큼 해당 카드들의 행동력 소모를 감소시킨다. 매 전투 1회만 발동한다."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:지혜의 이치>"
  },
  State_59521_Name = {
    Text = "현재 HP의 10%([DescArg1]) 잃음"
  },
  State_59522_Desc = {
    Text = "사용 후 해당 깨어남체 이외의 모든 카드를 버리고, 무작위 비깨어남체 카드 5장을 획득한다. 매 전투 1회만 발동한다."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:환희의 이치>"
  },
  State_59525_Name = {
    Text = "해당 명령 카드의 깨어남체가 50pt 광기 획득"
  },
  State_59526_Desc = {
    Text = "사용 후 <RetainIconKeywords:유지>와 <DepleteIconKeywords:소모>가 부여된 원본 복사본 3장을 획득한다. 매 전투 1회만 발동한다."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:번식의 이치>"
  },
  State_59534_Name = {
    Text = "이 표식이 존재할 경우, 이 카드는 <PhantomKeywords:환영> 발동이 금지됨을 나타낸다.「개발 전용」"
  },
  State_59560_Name = {
    Text = "3대 질체 각인이 있는 카드 1장을 선택하여 손에 넣음"
  },
  State_59671_Desc = {
    Text = "이번 턴에 모든 깨어남체의 최종 피해가 15% 증가한다."
  },
  State_59671_Name = {
    Text = "초현실타래 회중시계"
  },
  State_59673_Name = {
    Text = "작은 오르골"
  },
  State_59678_Desc = {
    Text = "획득 시 다른 모든 유물을 잃고, 무작위로 황금 유물 2개를 획득한다."
  },
  State_59878_Desc = {
    Text = "턴 종료 시, 추가로 「혼돈」 1스택을 감소시키고 [StateArg1]의 <PowerIconKeywords:힘>을 획득한다. 이후 소환되는 「N」의 분신 HP가 200% 증가하며, 사망 시 더 이상 「N」의 「혼돈」 스택 감소와 <PowerIconKeywords:힘> 획득을 발동하지 않는다."
  },
  State_59878_Name = {
    Text = "혼돈 강림"
  },
  State_59991_Name = {
    Text = ", 이 카드를 사용할 때 최대 5스택의 <EnergyStorageKeywords:차지>를 소모한다"
  },
  State_59993_Name = {
    Text = "잃은 HP의 10%([DescArg1]) 회복"
  },
  State_60000_Desc = {
    Text = "능동 피해를 받을 때마다, 임시 <MadnessIconKeywords:발광> 1층을 획득합니다."
  },
  State_60000_Name = {
    Text = "쌓이는 분노"
  },
  State_60028_Desc = {
    Text = "플레이어 턴 시작 시, 무작위 손패 1장의 행동력 소모를 이번 턴 동안 3으로 변경한다. 사망 후 이 효과는 무효화되며, 처치한 깨어남체의 모든 카드 행동력 소모가 이번 턴 동안 1 감소한다."
  },
  State_60028_Name = {
    Text = "망상의 감옥"
  },
  State_60044_Name = {
    Text = "[Layer]회 사용 후 소모"
  },
  State_60083_Desc = {
    Text = "이번 턴 받는 피해가 [Layer] % 감소."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:보강>"
  },
  State_60083_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60085_Desc = {
    Text = "전투 시작 및 턴 시작 시 임시 보강을 획득하며, 플레이어의 HP가 높을수록 더 많은 스택을 획득한다. 최대 50스택까지 획득할 수 있다."
  },
  State_60085_Name = {
    Text = "최종 번데기화"
  },
  State_60085_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60086_Desc = {
    Text = "전투 시작 및 턴 시작 시 임시 보강을 획득하며, 플레이어의 HP가 높을수록 더 많은 스택을 획득한다. 최대 25스택까지 획득할 수 있다."
  },
  State_60086_Name = {
    Text = "번데기화"
  },
  State_60086_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60087_Desc = {
    Text = "부여하는 중상 효과가 HP 회복량을 [Layer]% 감소시키는 것으로 변경된다."
  },
  State_60087_Name = {
    Text = "<Rune_14_High:중상 심화>"
  },
  State_60087_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60088_Desc = {
    Text = "스택당 받는 모든 피해 1% 감소."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:보강>"
  },
  State_60088_WeaponDesc = {
    Text = "획득하는 모든 실타래드가 25% 감소한다."
  },
  State_60089_Desc = {
    Text = "받는 모든 피해가 [Layer] % 감소."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:보강>"
  },
  State_60089_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60106_Desc = {
    Text = "턴 시작 후, 무작위 손패 1장의 행동력 소모를 3으로 변경하며, 턴 종료 시 원래대로 회복된다."
  },
  State_60106_Name = {
    Text = "망상의 감옥"
  },
  State_60112_Desc = {
    Text = "이번 턴 내에 명령 카드를 1장 사용할 때마다, 모든 깨어남체가 광기 1을 획득한다."
  },
  State_60112_Name = {Text = "협주곡"},
  State_60115_Desc = {
    Text = "이번 턴에 광기 폭발을 발동한 후, 쌍둥이 융합도가 3% 감소한다."
  },
  State_60115_Name = {Text = "진혼곡"},
  State_60118_Desc = {
    Text = "이번 턴에 주는 피해, 중독, 반격이 [Layer]% 증가한다."
  },
  State_60118_Name = {Text = "광상곡"},
  State_60128_Desc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_60128_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_60129_Desc = {
    Text = "다음에 사용하는 [Layer]장의 비파생 명령 카드 행동력 소모가 2 감소한다."
  },
  State_60129_Name = {Text = "하행음"},
  State_60130_Desc = {
    Text = "다음에 사용하는 [Layer]장의 비파생 명령 카드 행동력 소모가 2 증가하며, 2회 발동된다."
  },
  State_60130_Name = {Text = "상행음"},
  State_60148_Desc = {
    Text = "턴 종료 시 상태에 따라 다른 효과를 획득한다: 전개 - 임시 <MadnessIconKeywords:광란> 1스택을 획득한다. 수축 - 임시 <ReinforcePVEKeywords:보강> 50스택을 획득한다."
  },
  State_60148_Name = {
    Text = "매개변수 조정"
  },
  State_60150_Desc = {
    Text = "플레이어가 열쇠 지령을 발동할 때마다, 즉시 전개와 수축 두 형태 사이를 전환한다. 전개로 전환 시 즉시 [StateArg1]의 임시 힘을 획득한다. 수축으로 전환 시 즉시 [StateArg2]의 실타래드를 획득한다."
  },
  State_60150_Name = {
    Text = "기능 감지"
  },
  State_60151_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_60151_Name = {
    Text = "미깨어남"
  },
  State_60154_Desc = {
    Text = "현재 형태는 수축이다. 기계 장비가 실타래드와 경계를 획득하며, 의도는 주로 방어에 집중된다."
  },
  State_60154_Name = {
    Text = "기계 무장-수축"
  },
  State_60155_Desc = {
    Text = "현재 형태는 전개이다. 기계 장비가 힘을 획득하며, 의도는 주로 공격을 중심으로 한다."
  },
  State_60155_Name = {
    Text = "기계 무장-전개"
  },
  State_60167_Desc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_60167_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_60184_Desc = {
    Text = "카드를 사용할 때마다, 「모순 쌍둥이」가 의도를 변경한다."
  },
  State_60184_Name = {Text = "모순"},
  State_60187_Desc = {
    Text = "플레이어에게 부여하는 허약, 손상, 중상 효과가 모두 50%이다."
  },
  State_60187_Name = {
    Text = "종말이자 시작"
  },
  State_60201_Name = {
    Text = "몬스터 지연 힘"
  },
  State_60263_Desc = {
    Text = "부여하는 손상 효과가 실타래드 획득량을 [Layer]% 감소시키는 것으로 변경된다."
  },
  State_60263_Name = {
    Text = "<Rune_14_High:손상 심화>"
  },
  State_60264_Desc = {
    Text = "부여된 출혈 효과는 턴 종료 시 자동으로 50%만 제거된다."
  },
  State_60264_Name = {
    Text = "<Rune_14_High: 용혈>"
  },
  State_60265_Desc = {
    Text = "출혈 효과는 턴 종료 시 자동으로 50%만 제거된다."
  },
  State_60265_Name = {
    Text = "<BleedingColour: 용혈>"
  },
  State_60279_Name = {
    Text = "턴 종료 시 이 카드는 소모"
  },
  State_60284_Desc = {
    Text = "전투 시작 및 턴 시작 시 임시 보강을 획득하며, 플레이어의 HP가 낮을수록 더 많은 스택을 획득한다. 최대 50스택까지 획득할 수 있다."
  },
  State_60284_Name = {
    Text = "불파 검진"
  },
  State_60284_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60297_Desc = {
    Text = "「@2」가 해방된 모습으로 현현하여, HP가 원래의 3배로 증가한다. 그리고 매 턴마다 수호자에게 질문을 던져, 「타비에게 답하기」 1장을 손에 넣는다."
  },
  State_60297_Name = {
    Text = "진리의 물음"
  },
  State_60297_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_60298_Desc = {
    Text = "미지의 존재의 힘은 아직 검은 웅덩이 아래에 잠들어 있으며, 패배 직전에 완전히 부활하여 HP를 회복하고 해방된 모습으로 전투를 시작한다."
  },
  State_60298_Name = {Text = "잠복"},
  State_60312_Desc = {
    Text = "매 턴 누적 HP 10%만큼 피해를 받을 때마다 임시 「보강」을 [Layer]스택 획득한다."
  },
  State_60312_Name = {
    Text = "융식 안개 실타래드"
  },
  State_60315_Desc = {
    Text = "이번 턴에 광기 폭발을 발동한 후, 잃은 HP의 5%([DescArg1])를 회복한다."
  },
  State_60315_Name = {Text = "진혼곡"},
  State_60336_Name = {
    Text = "사용 후 행동력 1pt 및 카드 1장 획득, 하지만 이 카드는 소모됨"
  },
  State_60339_Name = {
    Text = "이번 턴에 사용 시 행동력 1pt 및 카드 1장 획득, 하지만 이 카드는 소모됨"
  },
  State_60367_Desc = {
    Text = "플레이어 턴 시작 시, 무작위 손패 1장의 행동력 소모를 이번 턴 동안 3으로 변경한다. 사망 후 이 효과는 무효화되며, 처치한 깨어남체의 모든 카드 행동력 소모가 이번 턴 동안 1 감소한다."
  },
  State_60367_Name = {
    Text = "망상의 감옥"
  },
  State_60386_Desc = {
    Text = "효과는 다음과 같다: 피해량의 150%만큼 출혈, 피해량의 75%만큼 중독, 허약 1스택 부여, 취약 1스택 부여, 임시로 [DescArg1]pt만큼 힘 감소."
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:기묘한 부정 효과>"
  },
  State_60404_Desc = {
    Text = "피해를 1회 받을 때마다 임시 보강 2스택을 획득한다."
  },
  State_60404_Name = {
    Text = "종말 변신"
  },
  State_60408_Desc = {
    Text = "HP가 33%로 감소할 때마다( [DescArg1] 부족), 이번 턴에 더 이상 피해를 받지 않으며, 「귀면의 물어뜯기」를 발동한다."
  },
  State_60408_Name = {
    Text = "귀면 찢기"
  },
  State_60409_Desc = {
    Text = "HP가 66%로 감소할 때마다( [DescArg1] 부족), 이번 턴에 더 이상 피해를 받지 않으며, 「종말 변신」을 발동한다."
  },
  State_60409_Name = {
    Text = "종언의 거울"
  },
  State_60429_Name = {
    Text = "상태@깨어남체 하멜른@원초의 선율"
  },
  State_60430_Desc = {
    Text = "실타래제 행동력 소모와 의도 표시가 일치하는 카드를 사용할 때 해당 카드를 소모하고, 모든 적이 [DescArg1]의 임시 힘을 잃게 한다."
  },
  State_60430_Name = {
    Text = "음표 율령"
  },
  State_60431_Name = {
    Text = "상태@깨어남체 하멜른@상행음"
  },
  State_60432_Name = {
    Text = "상태@깨어남체 하멜른@영혼의 서곡"
  },
  State_60433_Name = {
    Text = "상태@깨어남체 하멜른@하행음"
  },
  State_60434_Name = {
    Text = "상태@깨어남체 하멜른@추억의 회전곡"
  },
  State_60435_Name = {
    Text = "상태@깨어남체 하멜른@영혼의 서곡 카운터"
  },
  State_60436_Desc = {
    Text = "방어되지 않은 피해를 입힐 때, [StateArg1]장의 「상처」를 덱에 섞어 넣는다."
  },
  State_60436_Name = {
    Text = "영혼의 서곡"
  },
  State_60438_Name = {
    Text = "상태@깨어남체 하멜른@상행음 감청"
  },
  State_60439_Name = {
    Text = "상태@깨어남체 하멜른@하행음 감청"
  },
  State_60440_Name = {
    Text = "상태@깨어남체 하멜른@영혼의 서곡 감청"
  },
  State_60441_Name = {
    Text = "상태@깨어남체 하멜른@추억의 회전곡 감청"
  },
  State_60442_Name = {
    Text = "상태@깨어남체 하멜른@원초의 선율 감청"
  },
  State_60486_Desc = {
    Text = "전투 시작 시, 모든 깨어남체의 광기가 절반으로 감소한다."
  },
  State_60486_Name = {
    Text = "모신 흡수"
  },
  State_60487_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 최대 HP가 200% 증가하고, HP를 회복하며 진정한 형태로 전투를 시작한다."
  },
  State_60487_Name = {
    Text = "미깨어남"
  },
  State_60490_Desc = {
    Text = "사망 후 모든 깨어남체가 광기 30을 획득한다."
  },
  State_60490_Name = {
    Text = "생의 욕망"
  },
  State_60491_Desc = {
    Text = "모든 깨어남체가 획득하는 광기가 50% 감소한다."
  },
  State_60491_Name = {
    Text = "모목 의식"
  },
  State_60493_Desc = {
    Text = "HP가 누적 [Layer] 감소할 때마다, 모방 깨어남체 1개를 소환한다. 필드에 모방 깨어남체가 이미 2개일 경우, 모든 모방 깨어남체의 최대 HP를 50% 증가시킨다."
  },
  State_60493_Name = {Text = "양육모"},
  State_60500_Desc = {
    Text = "현재 모방 깨어남체가 존재할 경우, 자신이 「은폐」 50스택을 획득한다."
  },
  State_60500_Name = {
    Text = "숲속에 은닉"
  },
  State_60511_Desc = {
    Text = "반드시 시작 패에 포함된다."
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:고유>"
  },
  State_60511_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_60522_Desc = {
    Text = "부여하는 손상 및 중상 효과가 50%로 증가한다."
  },
  State_60522_Name = {Text = "파멸"},
  State_60523_Desc = {
    Text = "스택당 공격 횟수가 1 증가하며, 피해를 받으면 1스택이 감소한다. 턴 종료 시 모든 스택이 사라진다."
  },
  State_60523_Name = {Text = "기도"},
  State_60524_Desc = {
    Text = "전투 시작 및 턴 시작 시 [Layer]스택의 보강을 획득하며, 최대 50스택까지 가능하다."
  },
  State_60524_Name = {Text = "성화"},
  State_60524_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_60527_Desc = {
    Text = "사용 후 소모되지만, 적의 임시 힘을 감소시킨다."
  },
  State_60527_Name = {
    Text = "<CardKeyWord:멜로디 헤븐>"
  },
  State_60543_Desc = {
    Text = "턴 종료 시 「혈서」 10스택을 획득한다. 「혈서」는 피해를 받은 후 1스택이 제거된다."
  },
  State_60543_Name = {
    Text = "심지의 불꽃"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:회전 선율>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:회전 선율>"
  },
  State_60562_Desc = {
    Text = "사용 후 2회 발동하며, 「기합 선율」로 변경된다."
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:회전 선율>"
  },
  State_60564_Desc = {
    Text = "처음으로 패배 직전에 HP를 회복하고 의도를 「종말 진화」로 전환하여 힘과 보강을 획득한다. 두 번째로 패배 직전에 HP를 회복하고 의도를 「귀면의 물어뜯기」로 전환하여 매우 높은 단일 피해를 준다."
  },
  State_60564_Name = {
    Text = "그림자 악귀"
  },
  State_60567_Desc = {
    Text = "사용 후 하멜른이 광기 3을 획득한다."
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:기합 선율>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:기합 선율>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:기합 선율>"
  },
  State_60570_Desc = {
    Text = "사용 후 하멜른이 광기 3을 획득한다."
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:기합 선율>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:회전 선율>"
  },
  State_60576_Desc = {
    Text = "플레이어 턴 시작 시, 무작위 손패 1장의 행동력 소모를 이번 턴 동안 3으로 변경한다. 사망 후 이 효과는 무효화되며, 처치한 깨어남체의 모든 카드 행동력 소모가 이번 턴 동안 1 감소한다."
  },
  State_60576_Name = {
    Text = "망상의 감옥"
  },
  State_60578_Desc = {
    Text = "치명적 피해를 받으면 HP 50%를 회복하고, 1턴간 피해를 면역하며, 의도가 「탈피」로 변경된다."
  },
  State_60578_Name = {Text = "우화"},
  State_60592_Desc = {
    Text = "팀 유니크: 탐색 시작 시, 「은열쇠의 새벽빛」 1장을 드로우 덱에 셔플하고 <DestructionKeywords:파괴>를 부여합니다. 은열쇠를 해제한 후, 장착자의 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 장착자가 능동 피해를 입힐 때, 장착자의 은열쇠 충전량의 <WeaponEffect_Num:[StateArg2]%>에 해당하는 은열쇠 에너지와 <WeaponEffect_Num:[StateArg3]%> 임시 크리티컬 확률을 획득하며, 매 턴 최대 5회 발동합니다."
  },
  State_60592_WeaponDesc = {
    Text = "탐색 시작 시, 「은열쇠의 새벽빛」 1장을 드로우 덱에 셔플하고 <DestructionKeywords:파괴>를 부여합니다. 은열쇠를 해제한 후, 장착자의 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가합니다. 장착자가 능동 피해를 입힐 때, <WeaponEffect_Num:[DescArg1]> 포인트의 은열쇠 에너지와 <WeaponEffect_Num:[StateArg3]%> 임시 크리티컬 확률을 획득하며, 매 턴 최대 5회 발동합니다."
  },
  State_60594_Desc = {
    Text = "팀 유일: 턴 종료 후, 장착한 깨어남체가 광기 5를 획득한다. 장착한 깨어남체가 광기 폭발을 발동한 후, 이번 턴에 사용하는 다음 명령 카드의 치명타율, 치명타 피해, 실타래드, HP 회복이 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_60594_WeaponDesc = {
    Text = "턴 종료 후, 장착한 깨어남체가 광기 5를 획득한다. 장착한 깨어남체가 광기 폭발을 발동한 후, 이번 턴에 다음으로 사용하는 장착한 깨어남체의 명령 카드의 치명타율, 치명타 피해, 실타래드, HP 회복이 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_60898_Desc = {
    Text = "능동 피해 및 촉수 피해를 받을 때, 공격 각성체의 광기 폭발과 모든 카드를 1턴 봉인하고, <ResentChainsKeywords:증오의 사슬> 1층을 제거합니다."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:원한의 사슬>"
  },
  State_60925_Desc = {
    Text = "턴 종료 시, 잃은 HP의 5%를 회복한다. 플레이어가 증상 또는 상태 카드를 1장 드로우할 때마다, 모든 아군이 [Layer]의 힘을 획득한다."
  },
  State_60925_Name = {
    Text = "피의 등불"
  },
  State_60926_Desc = {
    Text = "턴 종료 시 현재 HP가 50% 미만이면, [Layer]의 힘과 [StateArg1]스택의 장벽을 획득한다."
  },
  State_60926_Name = {
    Text = "등불 성단"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 전에 전체 적에게 [StateArg1]스택의 <PVPSlowKeywords:둔화>를 부여한다."
  },
  State_60953_Name = {
    Text = "영원한 진혼곡"
  },
  State_60962_Desc = {
    Text = "이번 전투에서 최대 HP가 [Layer]% 증가한다."
  },
  State_60962_Name = {Text = "HP 증가"},
  State_60964_Desc = {
    Text = "이번 전투에서 피해량이 [Layer]% 증가한다."
  },
  State_60964_Name = {
    Text = "피해 증가"
  },
  State_61038_Name = {
    Text = "하멜른 체험"
  },
  State_61050_Desc = {
    Text = "「선율」 효과를 발동하거나 「협주의 교향」을 사용한 후, 하멜른이 치명타율과 치명타 피해 1%를 획득한다(현재 [DescArg1]% 획득). 이 효과가 10회 발동될 때마다, 이번 전투에서 「영혼의 서곡」과 「원초의 선율」의 피해 횟수가 1 증가하며, 최대 3회까지 증가한다."
  },
  State_61050_Name = {
    Text = "월하 광상"
  },
  State_61051_Desc = {
    Text = "「선율」 효과를 발동하거나 「협주의 교향」을 사용한 후, 하멜른이 치명타율과 치명타 피해 1%를 획득한다. 이 효과가 10회 발동될 때마다, 이번 전투에서 「영혼의 서곡」과 「원초의 선율」의 피해 횟수가 1 증가하며, 최대 3회까지 증가한다."
  },
  State_61051_Name = {
    Text = "월하 광상"
  },
  State_61056_Desc = {
    Text = "첫 턴에 임시 힘 100을 획득한다."
  },
  State_61056_Name = {Text = "광폭"},
  State_61084_Desc = {
    Text = "이번 턴에 사용하는 다음 [Layer]장의 카드: 행동력 소모가 3 이상일 경우, 행동력 2를 획득하고, 그렇지 않으면 카드 2장을 드로우한다."
  },
  State_61084_Name = {
    Text = "네번째 악장"
  },
  State_61085_Desc = {
    Text = "행동력 소모가 2 감소하고, 사용 후 2회 발동하며, 「기합 선율」로 변경된다."
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:회전 선율>"
  },
  State_61089_Desc = {
    Text = "다음에 사용하는 명령 카드 1장이 2회 발동한다."
  },
  State_61089_Name = {
    Text = "오케스트라 지휘봉"
  },
  State_61145_Name = {
    Text = "<BleedingColour: 출혈>"
  },
  State_61174_Desc = {
    Text = "실타래드를 획득할 수 없다."
  },
  State_61174_Name = {
    Text = "잔당의 장례"
  },
  State_61180_Desc = {
    Text = "혈쇄·히로의 기본 피해가 이번 전투에서 [DescArg1]% 증가한다."
  },
  State_61180_Name = {
    Text = "복수의 칼날"
  },
  State_61185_Desc = {
    Text = "적의 스킬을 강화시킨다. 피해를 받을 때마다 1스택을 잃는다."
  },
  State_61185_Name = {
    Text = "피의 맹세"
  },
  State_62213_Desc = {
    Text = "가하는 허약 효과가 가하는 능동 및 촉수 피해를 [Layer]% 감소시키는 효과로 변경."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:허약 심화>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 [StateArg1]의 <StrongEffectKeywords:강효>를 획득한다. HP를 잃을 때마다, 현재 HP가 [StateArg2]% 미만일 경우 <ReinforceKeywords:보강>과 <StrengthenKeywords:강화>를 획득한다."
  },
  State_62309_Name = {
    Text = "핏빛 침잠"
  },
  State_62317_Desc = {
    Text = "모든 피해를 면역하며, 턴 시작 후 제거된다."
  },
  State_62317_Name = {
    Text = "피해 완전 면역"
  },
  State_62336_Desc = {
    Text = "카드 3장을 사용할 때마다(남은 [Layer]장), 카드 1장을 드로우하고 손패의 명령 카드 1장을 무작위로 동결한다."
  },
  State_62336_Name = {
    Text = "혹한의 추위"
  },
  State_62337_Desc = {
    Text = "카드 3장을 사용할 때마다(남은 [Layer]장), 카드 1장을 드로우하고 손패의 명령 카드 1장을 무작위로 동결한다."
  },
  State_62337_Name = {
    Text = "혹한의 추위"
  },
  State_62338_Desc = {
    Text = "이 카드는 사용할 수 없으며, 턴 종료 시 버려지지 않고, 소속 깨어남체가 광기 5를 획득한다. 소속 깨어남체가 광기 폭발을 발동한 후, 동결이 해제된다."
  },
  State_62338_Name = {
    Text = "<CardKeyWord:동결>"
  },
  State_65332_Desc = {
    Text = "사망 후 모든 깨어남체가 광기 30을 획득한다."
  },
  State_65332_Name = {Text = "소멸"},
  State_65342_Desc = {
    Text = "패배 후 부활하며, 최대 HP가 100% 증가하고 「서리한기」를 발동한다."
  },
  State_65342_Name = {Text = "침묵"},
  State_65346_Desc = {
    Text = "사망 후, 손패의 명령 카드 2장을 동결한다."
  },
  State_65346_Name = {Text = "상강"},
  State_65358_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동하기 전, 임시 손패 상한이 1 증가하고, 장착한 깨어남체의 명령 카드 1장을 드로우한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체가 포식을 발동할 때 임시 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 매 턴 최대 1회 발동된다."
  },
  State_65358_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동하기 전, 임시 손패 상한이 1 증가하고, 장착한 깨어남체의 명령 카드 1장을 드로우한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체가 포식을 발동할 때 임시 치명타 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 매 턴 최대 1회 발동된다."
  },
  State_65360_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 전투 시작 시, 장착한 깨어남체가 「빙설」 25스택을 획득한다. 장착한 깨어남체가 카드를 사용하면 광기 2를 획득하고 1스택을 제거한다. 「빙설」이 모두 제거된 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 치명타율을 획득한다."
  },
  State_65360_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 전투 시작 시, 장착한 깨어남체가 「빙설」 25스택을 획득한다. 장착한 깨어남체가 카드를 사용하면 광기 2를 획득하고 1스택을 제거한다. 「빙설」이 모두 제거된 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 치명타율을 획득한다(현재 남은 빙설 [DescArg1]스택)."
  },
  State_65362_Desc = {
    Text = "누적 [StateArg1]회 능동 피해를 받을 때마다(남은 횟수: [Layer]회), 손패의 명령 카드 1장을 무작위로 동결한다."
  },
  State_65362_Name = {
    Text = "서리 반환"
  },
  State_65463_Name = {
    Text = "검은 인장 5pt 획득"
  },
  State_65490_Desc = {
    Text = "턴 종료 시 [StateArg1] 층의 서리방패와 [StateArg2] 점의 힘을 획득합니다."
  },
  State_65490_Name = {
    Text = "절대 영도"
  },
  State_65497_Name = {
    Text = "혈쇄·히로 체험"
  },
  State_65553_Desc = {
    Text = "턴 종료 시, 남은 손패 수에 따라 힘을 획득한다. 손패 1장당 [Layer]의 힘을 획득한다."
  },
  State_65553_Name = {Text = "얼음 검"},
  State_65557_Desc = {
    Text = "치명적 피해를 받은 후 모든 HP를 회복하고, 의도를 「진·깊은 우주의 주목」으로 전환하며, 임시 보강 80스택을 획득하고 자신의 부정 상태와 플레이어의 긍정 상태를 제거한다. 턴 종료 시, 자신이 보강 20스택을 제거한다."
  },
  State_65557_Name = {
    Text = "태고의 혼돈"
  },
  State_65558_Desc = {
    Text = "치명적 피해를 받은 후 의도를 「진·깊은 우주의 주목」으로 전환하고 임시 보강 80스택을 획득하며, 모든 HP를 회복한다. [DescArg1]회 발동 가능하다. 발동 횟수를 모두 소진한 후 치명적 피해를 받으면 HP 1을 남기고 의도를 「만천 세계의 눈」으로 변경한다. 턴 종료 시, 자신이 보강 20스택을 제거한다."
  },
  State_65558_Name = {Text = "별가루"},
  State_65559_Desc = {
    Text = "모두 사망한 후 토후와보가 다시 등장한다."
  },
  State_65559_Name = {
    Text = "태고의 파편"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic:탐사대원들이 히로에 대한 의심을 계속 깊게 하고 있어, 적이 접근하기 전에 선택을 해야 하며 혼란에 빠진 팀을 안정시켜야 합니다>"
  },
  State_65565_Name = {
    Text = "\n<D05EX_Relic:대원들의 의심을 무시하고 계속 전진하기>"
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:탐사대와 상황 설명하기>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic:히로를 단속하여 대원들을 보호하기>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic:히로를 단속하고, 깨어남체의 힘을 사용하여 대원들을 최대한 보호하기>"
  },
  State_65585_Desc = {
    Text = "이 카드를 사용한 후 손으로 되돌아가며, 턴 종료까지 각인이 무효화된다."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:메아리>"
  },
  State_66305_Desc = {
    Text = "턴 종료 시, 임시 <ResentChainsKeywords:원한의 사슬> 1층을 획득합니다."
  },
  State_66305_Name = {
    Text = "영원을 꿰뚫는 자물쇠"
  },
  State_66306_Desc = {
    Text = "능동 피해 및 촉수 피해를 받을 때, 공격 각성체의 광기 폭발과 모든 카드를 1턴 봉인하고, <ResentChainsKeywords:증오의 사슬> 1층을 제거합니다."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:원한의 사슬>"
  },
  State_66308_Desc = {
    Text = "치명적 피해를 입은 후 HP가 1로 잠금된다."
  },
  State_66308_Name = {
    Text = "태고의 혼돈"
  },
  State_66311_Desc = {
    Text = "깨어남체들의 기억이 당신의 머릿속 가장자리에서 솟아나와 뇌리에 뿌리를 내리고 자란다. 당신이 그것들을 몇 번을 잘라내든, 융식이 그것들을 몇 번을 뒤집어엎든, 그것들은 결코 떠나지 않았다."
  },
  State_66311_Name = {
    Text = "파괴된 기억"
  },
  State_66313_Desc = {
    Text = "명령 카드 1장을 사용할 때마다, 해당 깨어남체의 행동력 소모가 가장 낮은 카드 1장을 버린다."
  },
  State_66313_Name = {
    Text = "최고 의지의 위압"
  },
  State_66314_Desc = {
    Text = "모든 데미지에 면역합니다."
  },
  State_66314_Name = {
    Text = "피해 완전 면역"
  },
  State_66317_Desc = {
    Text = "깨어남체들의 기억이 당신의 머릿속 가장자리에서 솟아나와 뇌리에 뿌리를 내리고 자란다. 당신이 그것들을 몇 번을 잘라내든, 융식이 그것들을 몇 번을 뒤집어엎든, 그것들은 결코 떠나지 않았다. 매 턴 시작 시 행동력 상한 1과 손패 상한 2를 회복한다."
  },
  State_66317_Name = {
    Text = "기억의 조각"
  },
  State_66325_Desc = {
    Text = "깨어남체들의 기억이 당신의 머릿속 가장자리에서 솟아나와 뇌리에 뿌리를 내리고 자란다. 당신이 그것들을 몇 번을 잘라내든, 융식이 그것들을 몇 번을 뒤집어엎든, 그것들은 결코 떠나지 않았다. 매 턴 시작 시 행동력 상한 1과 손패 상한 2를 회복한다."
  },
  State_66325_Name = {
    Text = "기억의 조각"
  },
  State_66358_Desc = {
    Text = "탐색 중 최초로 죽음 저항이 발동될 때, 「<DerivativeCardKeywords_39:과거의 메아리>」 1장을 손에 넣는다."
  },
  State_66358_Name = {
    Text = "존재하지 않는 존재"
  },
  State_66359_Desc = {
    Text = "무작위로 여러 개의 선택지를 생성하여 선택하게 한다."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:발견>"
  },
  State_66360_Desc = {
    Text = "이번 전투 내에서 치명타율이 [Layer]% 증가한다."
  },
  State_66360_Name = {
    Text = "치명타율"
  },
  State_66362_Desc = {
    Text = "이번 전투 내에서 치명타 피해가 [Layer]% 증가한다."
  },
  State_66362_Name = {
    Text = "치명타 피해"
  },
  State_66409_Name = {
    Text = "대행자의 판결"
  },
  State_66410_Desc = {
    Text = "다음에 사용하는 [DescArg1]장의 타비의 명령 카드가 2회 발동된다."
  },
  State_66410_Name = {
    Text = "만물 귀일"
  },
  State_66414_Desc = {
    Text = "손에 있을 때, 덱 맨 위의 카드가 명령 카드일 경우 해당 카드의 복사본으로 변한다."
  },
  State_66414_Name = {
    Text = "만물의 이치를 통달함"
  },
  State_66454_Desc = {
    Text = "스킬 카드의 행동력 소모가 「은폐」 스택 수만큼 감소하며, 최대 5스택까지 중첩할 수 있다. 피해를 받거나 스킬 카드를 사용하면 1스택이 제거된다."
  },
  State_66454_Name = {Text = "잠행"},
  State_66456_Desc = {
    Text = "스킬 카드의 행동력 소모가 「은폐」 스택 수만큼 감소하며 최대 5스택까지 중첩할 수 있고, 피해를 받거나 스킬 카드를 사용하면 1스택이 제거된다."
  },
  State_66456_Name = {
    Text = "<YinniColour:은폐>"
  },
  State_66465_Desc = {
    Text = "광기 폭발 사용 후, 해당 스택 수만큼 피해를 받는다."
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:폭발 봉쇄>"
  },
  State_66522_Desc = {
    Text = "8번째로 사용하는 카드가 2회 발동된다."
  },
  State_66522_Name = {
    Text = "별들의 술"
  },
  State_66553_Desc = {
    Text = "「타격」과 「방어」를 사용한 후, 해당 깨어남체가 광기 35를 획득한다. 단, 해당 카드들의 행동력 소모가 1 증가한다."
  },
  State_66553_Name = {
    Text = "불완전한 얼굴"
  },
  State_66554_Desc = {
    Text = "획득 시, <DerivativeCardKeywords_1:「유영의 메아리」> 1장을 손에 넣는다."
  },
  State_66554_Name = {
    Text = "통신 장비"
  },
  State_66555_Desc = {
    Text = "최대 행동력이 1 증가한다."
  },
  State_66555_Name = {
    Text = "활성 주사기"
  },
  State_66556_Desc = {
    Text = "동일한 깨어남체의 카드를 연속으로 사용할 때마다, 해당 깨어남체가 광기 8을 획득한다."
  },
  State_66556_Name = {
    Text = "정밀 계측기"
  },
  State_66557_Desc = {
    Text = "HP를 잃을 때마다 [DescArg1]의 <PowerIconKeywords:힘>을 획득한다. 매 전투 최대 10회 중첩된다. 최대 중첩 시, 잃은 HP의 25%를 회복한다."
  },
  State_66557_Name = {
    Text = "최고의 영광"
  },
  State_66558_Desc = {
    Text = "매 3 턴마다 모든 적에게 1층의 <WeaknessIconKeywords:약화>를 추가합니다. <WeaknessIconKeywords:약화> 상태의 적에게 데미지를 입힌 후 임시로 <PowerIconKeywords:힘> [DescArg1] 점을 획득합니다. 각 턴당 최대 3회까지 트리거됩니다."
  },
  State_66558_Name = {Text = "악동"},
  State_66559_Desc = {
    Text = "행동력 소모가 3 이상인 카드를 1장 사용하면, 카드 1장을 드로우하고 행동력 1을 획득한다."
  },
  State_66559_Name = {
    Text = "상실타래의 아름다움"
  },
  State_66560_Desc = {
    Text = "「타격」이 행동력 2를 획득하고 무작위로 카드 1장을 버린다. 「방어」가 카드 2장을 드로우하고 행동력 1을 잃는다. 매 턴 최대 3회 발동된다."
  },
  State_66560_Name = {
    Text = "행복한 레코드"
  },
  State_66561_Desc = {
    Text = "매 3턴마다 모든 적에게 <VulnerabilityIconKeywords:취약>을 1스택 부여한다. <VulnerabilityIconKeywords:취약> 상태의 적에게 피해를 입힌 후, 해당 적이 [DescArg1]pt의 임시 <PowerIconKeywords:힘>을 잃는다. 매 턴 최대 3회 발동된다."
  },
  State_66561_Name = {
    Text = "봄의 제전"
  },
  State_66562_Desc = {
    Text = "매 4턴마다 모든 적이 해당 턴에 받는 피해가 2배로 증가하며, 해당 턴에 광기 폭발을 사용하면 모든 깨어남체를 1턴간 봉인한다."
  },
  State_66562_Name = {
    Text = "여정의 유골"
  },
  State_66563_Desc = {
    Text = "턴 시작 시, 이전 턴에 카드를 3장 이상 사용했다면, 카드 2장을 드로우한다."
  },
  State_66563_Name = {Text = "새 지갑"},
  State_66564_Desc = {
    Text = "획득 시, 행동력 3을 획득한다."
  },
  State_66564_Name = {
    Text = "회중시계"
  },
  State_66565_Desc = {
    Text = "획득 시, 모든 적에게 1턴간 <WeaknessIconKeywords:허약>과 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  State_66565_Name = {
    Text = "변색 구속복"
  },
  State_66566_Desc = {
    Text = "매 턴 시작 시 <DeathResistanceIconKeywords:죽음 저항>이 10% 증가한다(이번 스테이지 내에서 죽음 저항이 1회 발동될 때마다 획득하는 죽음 저항이 절반으로 감소한다). <DeathResistanceIconKeywords:죽음 저항>이 100% 이상일 때, <ProficientInRealmsIconKeywords:계역 숙련>이 100 증가한다."
  },
  State_66566_Name = {
    Text = "인어의 눈물"
  },
  State_66703_Desc = {
    Text = "팀 유일: 은열쇠 적립 상한이 100% 증가한다. 손패 상한이 2 증가하며, 다른 명륜이 제공하는 손패 상한과 중첩되지 않는다. 장착한 깨어남체의 은열쇠 충전이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 카드를 사용한 후, 이번 턴 동안 장착한 깨어남체의 명령 카드 치명타율과 치명타 피해, 주는 실타래드, 광기 및 힘 획득 효과가 <WeaponEffect_Num:[StateArg2]%> 증가하며, 최대 5회 중첩된다."
  },
  State_66703_WeaponDesc = {
    Text = "은열쇠 적립 상한이 100% 증가한다. 손패 상한이 2 증가하며, 다른 명륜이 제공하는 손패 상한과 중첩되지 않는다. 장착한 깨어남체의 은열쇠 충전이 <WeaponEffect_Num:[DescArg2]> 증가한다. 장착한 깨어남체가 카드를 사용한 후, 이번 턴 동안 장착한 깨어남체의 명령 카드 치명타율과 치명타 피해, 주는 실타래드, 광기 및 힘이 <WeaponEffect_Num:[StateArg2]%> 증가하며, 최대 5회 중첩된다(현재 [DescArg1]중첩)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 시작 시, 자신에게 <PVPProtectiveKeywords:장벽>이 없으면 [StateArg1]스택의 <PVPProtectiveKeywords:장벽>을 획득하고, 그렇지 않으면 <StrengthenKeywords:강화>를 획득한다."
  },
  State_66722_Name = {
    Text = "은세의 윤회"
  },
  State_66872_Desc = {
    Text = "타비가 주는 피해, 실타래드, HP 회복이 임시로 [StateArg1]% 증가하며, [Layer]턴 동안 지속된다."
  },
  State_66872_Name = {
    Text = "무한한 억만의 빛"
  },
  State_66884_Desc = {
    Text = "턴 종료 시 행동력 소모가 감소하며, 버려질 때에도 해당 효과가 발동된다."
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:예비1>"
  },
  State_66888_Desc = {
    Text = "팀 유일: 열쇠 지령을 발동한 후, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg1]%>만큼의 <PowerIconKeywords:힘>과 방어력 <WeaponEffect_Num:[StateArg2]%>만큼의 실타래드를 획득한다. 응급 영지체 사용 후, 턴 종료 시 모든 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_66888_Name = {
    Text = "순수한 은빛의 초심"
  },
  State_66888_WeaponDesc = {
    Text = "열쇠 지령을 발동한 후, <WeaponEffect_Num:[Power:DescArg1]>의 <PowerIconKeywords:힘>과 <WeaponEffect_Num:[Block:DescArg2]>의 실타래드를 획득한다. 응급 영지체 사용 후, 턴 종료 시 모든 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_66893_Desc = {
    Text = "팀 유일: 전투 시작 후, 장착한 깨어남체의 은열쇠 충전량의 <WeaponEffect_Num:[StateArg1]%>만큼 은열쇠 에너지를 획득한다. 매 전투 최초로 열쇠 지령을 발동한 후, 이 효과를 한 번 더 반복한다."
  },
  State_66893_WeaponDesc = {
    Text = "전투 시작 후, <WeaponEffect_Num:[DescArg1]>의 은열쇠 에너지를 획득한다. 매 전투 최초로 열쇠 지령을 발동한 후, 이 효과를 한 번 더 반복한다."
  },
  State_66896_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_66900_Desc = {
    Text = "이 카드의 피해, 치유, 실타래드가 [StateArg1]% 증가한다."
  },
  State_66900_Name = {
    Text = "순은의 초심"
  },
  State_66901_Desc = {
    Text = "가하는 피해, 치료 및 방패 효과가 [DescArg1]% 증가하며, 1 턴 지속됩니다"
  },
  State_66901_Name = {
    Text = "임시 강효"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 다른 아군 깨어남체가 사망한 후, <Block:[Block:StateArg1]>의 실타래드를 획득하고, 그 깨어남체의 행동력 소모가 가장 낮은 「스킬」을 손에 넣는다."
  },
  State_66902_Name = {
    Text = "순은의 초심"
  },
  State_66971_Desc = {
    Text = "HP가 0으로 감소할 때, HP를 1로 만들고 더 이상 피해를 받지 않는다."
  },
  State_66971_Name = {
    Text = "세계 단절"
  },
  State_67234_Desc = {
    Text = "턴 종료 시, 「통 속의 뇌 분체」 1명을 소환한다. [Layer]턴 동안 지속된다."
  },
  State_67234_Name = {Text = "분리"},
  State_67235_Desc = {
    Text = "사망 시 모든 HP를 회복하고, 최대 HP가 100% 증가하며, 「영혼의 역병」을 발동한다."
  },
  State_67235_Name = {
    Text = "미깨어남"
  },
  State_67237_Desc = {
    Text = "10스택에 도달하면, 의도가 「허무 종결」로 변경된다: 상대의 최대 HP를 1로 만든다."
  },
  State_67237_Name = {Text = "종말"},
  State_67238_Desc = {
    Text = "턴 종료 시, 「종말」 1스택을 획득한다. 치명적 피해를 받은 후 이 상태를 제거하고 1턴간 피해를 면역하며, HP 15%를 회복하고 「종말」 10스택을 획득한다."
  },
  State_67238_Name = {
    Text = "영혼의 역병"
  },
  State_67240_Desc = {
    Text = "「지자」가 임시 <ReinforcePVEKeywords:보강> 25스택과 [Power:StateArg1]의 임시 <PowerIconKeywords:힘>을 획득하고, 해당 상태를 제거한다."
  },
  State_67240_Name = {
    Text = "<TuiyanColour:추론>"
  },
  State_67241_Desc = {
    Text = "사망 시 모든 HP를 회복하고, 최대 HP가 100% 증가하며, 「기사의 열정」을 발동한다."
  },
  State_67241_Name = {
    Text = "미깨어남"
  },
  State_67242_Desc = {
    Text = "사망 시 모든 HP를 회복하고, 최대 HP가 100% 증가하며, 「영혼과 육체@1분」을 발동한다."
  },
  State_67242_Name = {
    Text = "미깨어남"
  },
  State_67243_Desc = {
    Text = "턴 종료 시, 「통 속의 뇌 분체」 1명을 소환한다. 통 속의 뇌 분체가 「영질 분리」를 발동할 때, 플레이어의 힘을 추가로 5% 탈취한다."
  },
  State_67243_Name = {
    Text = "영혼과 육체의 @1 분"
  },
  State_67245_Desc = {
    Text = "턴 종료 시, [StateArg1]의 <PowerIconKeywords:힘>을 획득한다."
  },
  State_67245_Name = {
    Text = "기사의 열정"
  },
  State_67246_Desc = {
    Text = "매 턴 최초로 실타래드가 파괴될 때, 최대 HP의 25%를 잃고 [Power:DescArg1]의 <PowerIconKeywords:임시 힘>과 [Layer]스택의 임시 보강을 획득한다. 다음 턴 시작 시, <Block:[Block:DescArg2]>스택의 실타래드를 다시 획득하며, 「기사의 신앙」이 발동될 때마다 실타래드를 1회 추가로 획득한다."
  },
  State_67246_Name = {
    Text = "기사의 신앙"
  },
  State_67247_Desc = {
    Text = "매 턴 종료 시 적을 보충하며, 최대 2명의 적이 동시에 존재할 수 있다. 적이 사망하면, 「부패한 뇌」가 최대 HP의 5%를 잃는다."
  },
  State_67247_Name = {
    Text = "심연의 문"
  },
  State_67252_Desc = {
    Text = "치명적 피해를 받을 때 후열로 이동하고 HP 1을 남기며, 이후 더 이상 어떤 피해도 받을 수 없으며, <PowerIconKeywords:힘>이 [DescArg1] 증가한다. 자폭은 이 효과를 발동하지 않는다."
  },
  State_67252_Name = {
    Text = "영질 분리"
  },
  State_67253_Desc = {
    Text = "[Layer]장의 카드를 사용한 후, 전방에 「통 속의 뇌 분체」 1명을 생성한다. 최대 3개의 분체가 동시에 존재할 수 있다."
  },
  State_67253_Name = {
    Text = "통 속의 뇌"
  },
  State_67255_Desc = {
    Text = "사망 시 모든 HP를 회복하고, 최대 HP가 100% 증가하며, 「제일 철학」을 발동한다."
  },
  State_67255_Name = {
    Text = "미깨어남"
  },
  State_67256_Desc = {
    Text = "드로우 단계 후, 손에서 무작위 명령 카드 3장을 공개하고, 1장을 선택하여 「메아리」 각인을 부여하며, 나머지 카드는 버린다."
  },
  State_67256_Name = {
    Text = "제일 철학"
  },
  State_67257_Desc = {
    Text = "매 턴 최초로 열쇠 지령을 발동하면, 모든 깨어남체가 광기 10을 획득하지만, 열쇠 지령 소모가 영구적으로 10% 증가한다."
  },
  State_67257_Name = {
    Text = "점점 부서지는 링크"
  },
  State_67258_Desc = {
    Text = "전투 시작 시, <Block:[Block:DescArg1]>스택의 실타래드를 획득한다. 턴 종료 시, 실타래드가 사라지지 않는다."
  },
  State_67258_Name = {
    Text = "기사의 결의"
  },
  State_67347_Desc = {
    Text = "손에 있을 때, 덱 맨 위의 카드가 명령 카드일 경우, 해당 카드의 행동력 소모가 1 감소한 복사본으로 변한다."
  },
  State_67347_Name = {
    Text = "만물의 이치를 통달함"
  },
  State_67353_Desc = {
    Text = "사망 후 「부패한 뇌」가 최대 HP의 5%를 잃는다."
  },
  State_67353_Name = {Text = "용해"},
  State_67358_Desc = {
    Text = "플레이어가 행동력 1을 소모할 때마다, 즉시 <Block:[Block:StateArg1]>의 실타래드와 임시 보강 3스택을 획득한다."
  },
  State_67358_Name = {
    Text = "부정형 장벽"
  },
  State_67414_Desc = {
    Text = "직시할 수 없는 눈. 거스를 수 없는 기운. 모든 것을 이루는 파편도 단지 파편일 뿐. 이제, 운명적인 파멸의 결말을 맞이하라..."
  },
  State_67414_Name = {
    Text = "만상의 본원과의 대면"
  },
  State_67418_Desc = {
    Text = "사용 후 해당 깨어남체 이외의 모든 카드를 버리고, 무작위 비깨어남체 카드 5장을 획득한다. 매 전투 1회만 발동한다."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:고급 환희의 이치>"
  },
  State_67419_Desc = {
    Text = "사용 후 <RetainIconKeywords:유지>와 <DepleteIconKeywords:소모>가 부여된 원본 복사본 3장을 획득하고, 해당 카드들의 행동력 소모를 1 감소시킨다. 매 전투 1회만 발동한다."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:고급 번식의 이치>"
  },
  State_67420_Desc = {
    Text = "사용 후 카드 4장을 드로우하고, 각인 카드의 실타래제 행동력 소모만큼 해당 카드들의 행동력 소모를 감소시킨다. 매 전투 1회만 발동한다."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:고급 지혜의 이치>"
  },
  State_67598_Desc = {
    Text = "광기 폭발을 사용한 후, 해당 깨어남체의 무작위 카드 1장을 손에 넣는다. 해당 카드는 <DepleteIconKeywords:소모>와 <NothingnessIconKeywords:허무>를 획득한다. 전투 종료 후, [DescArg1]의 HP를 회복한다."
  },
  State_67598_Name = {
    Text = "의사의 가방"
  },
  State_67599_Desc = {
    Text = "「타격」「방어」가 아닌 명령 카드를 사용한 후, 해당 깨어남체가 광기 15를 획득하며, 매 턴 최대 5회 발동된다. 매 턴 최초 발동 시, 사용한 카드를 다시 손으로 되돌린다."
  },
  State_67599_Name = {
    Text = "시계추·투사"
  },
  State_67600_Desc = {
    Text = "최대 행동력이 4 증가하며, 덱을 재설정할 때마다 <DerivativeCardKeywords_4:「영감」> 4장을 덱에 추가한다."
  },
  State_67600_Name = {
    Text = "축복·검은 양초"
  },
  State_67602_Name = {Text = "폐기"},
  State_67603_Desc = {
    Text = "부정 상태에 있는 적에게 주는 피해가 20% 증가하며, 적을 처치한 후 처치자가 광기 20을 획득한다."
  },
  State_67603_Name = {
    Text = "제사장의 지팡이"
  },
  State_67604_Desc = {
    Text = "이전에 사용한 깨어남체와 다른 깨어남체의 명령 카드를 사용할 때, 해당 깨어남체가 광기 3을 획득하고 「활성」 1스택을 적립한다. 「활성」이 10스택에 도달하면 모든 「활성」을 소모하고, 모든 깨어남체의 행동력 소모가 1 감소하며 「소모」가 부여된 무작위 명령 카드를 각각 1장씩 손에 넣는다. 매 턴 최대 1회 발동된다."
  },
  State_67604_Name = {
    Text = "시계추·진화"
  },
  State_67605_Desc = {
    Text = "실타래드를 보유하고 있을 때, 해당 유물이 [DescArg1]의 임시 <PowerIconKeywords:힘>을 제공한다. 실타래드가 현재 HP보다 높을 때, [DescArg2]의 임시 <PowerIconKeywords:힘>을 추가로 제공한다."
  },
  State_67605_Name = {
    Text = "비둘기 깃털 부채"
  },
  State_67606_Desc = {
    Text = "턴 시작 시 적 1명당 행동력 1을 획득한다. 능동 피해로 적을 처치할 때, 다른 적에게 과잉 피해와 동일한 <BleedingIconKeywords:출혈>을 부여한다."
  },
  State_67606_Name = {
    Text = "군중의 노래"
  },
  State_67607_Desc = {
    Text = "5회 광기 폭발을 발동할 때마다, 광기 폭발을 발동한 깨어남체가 광기 100을 획득한다."
  },
  State_67607_Name = {
    Text = "작은 포대기"
  },
  State_67608_Name = {Text = "폐기"},
  State_67609_Desc = {
    Text = "광기 폭발을 발동한 후, 현재 HP의 8%를 잃고, 모든 적에게서 [DescArg1]의 임시 <PowerIconKeywords:힘>을 탈취한다. 적이 1명만 있을 경우, [DescArg2]의 임시 <PowerIconKeywords:힘>을 추가로 탈취한다."
  },
  State_67609_Name = {
    Text = "재앙 의식의 새"
  },
  State_67611_Desc = {
    Text = "2턴마다 모든 적이 받는 피해가 2배로 증가하며, 이번 턴에 광기 폭발을 1회 발동할 때마다 무작위로 부정 상태 1개를 해제한다."
  },
  State_67611_Name = {
    Text = "축복·여정의 유골"
  },
  State_67612_Desc = {
    Text = "모든 「타격」이 주는 치명타 피해가 20% 증가한다. 획득 시, <DerivativeCardKeywords_40:「아름다운 순간 」> 1장을 손에 넣는다."
  },
  State_67612_Name = {
    Text = "아름다운 순간 β"
  },
  State_67614_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 25를 획득한다. 획득 시 최대 HP가 1.5배가 된다."
  },
  State_67614_Name = {
    Text = "축복·악몽의 표상 β"
  },
  State_67615_Desc = {
    Text = "매 6번째 명령 카드를 사용할 때마다 해당 카드를 버린 카드 더미에서 손으로 되돌린다."
  },
  State_67615_Name = {
    Text = "황혼 속에서"
  },
  State_67616_Name = {Text = "폐기"},
  State_67618_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 25를 획득한다. 획득 시 최대 HP가 1.5배가 된다."
  },
  State_67619_Desc = {
    Text = "손패 상한이 5 증가한다. 획득 시, 손패를 상한까지 보충한다. 턴 시작 시 추가로 카드 1장을 드로우한다. 턴 종료 시 손에 있는 모든 증상 카드와 상태 카드를 버리고, 다른 카드는 유지한다."
  },
  State_67619_Name = {
    Text = "축복·각인된 의식 β"
  },
  State_67620_Desc = {
    Text = "매 턴 3번째 카드를 사용한 후, <DerivativeCardKeywords_4:「영감」> 1장을 버린 카드 더미에 넣는다. 매 턴 6번째 카드를 사용한 후, 버린 카드 더미에서 <DerivativeCardKeywords_4:「영감」> 1장을 손으로 가져온다."
  },
  State_67620_Name = {
    Text = "문명의 빛"
  },
  State_67621_Desc = {
    Text = "광기 폭발을 사용한 후, [DescArg1]의 임시 힘을 획득하고, 모든 적에게서 [DescArg1]의 임시 <PowerIconKeywords:힘>을 탈취한다. 적이 1명만 있을 경우, [DescArg2]의 임시 <PowerIconKeywords:힘>을 추가로 탈취한다."
  },
  State_67621_Name = {
    Text = "축복·재앙 의식의 새"
  },
  State_67622_Desc = {
    Text = "마지막 1pt의 행동력을 소모할 때, 행동력 2를 획득한다. 매 턴 최대 2회 발동된다."
  },
  State_67622_Name = {
    Text = "은백 연산기"
  },
  State_67623_Desc = {
    Text = "획득 후 영구적으로 [DescArg1]의 <PowerIconKeywords:힘>을 획득한다. 피해를 입힐 때마다 [DescArg2]의 HP를 회복하며, 매 턴 최대 6회 발동된다."
  },
  State_67623_Name = {
    Text = "축복·칠성장어의 키스"
  },
  State_67624_Name = {Text = "폐기"},
  State_67625_Desc = {
    Text = "매 턴 최초로 명령 카드가 버린 카드 더미에 들어간 후, 해당 카드의 행동력 소모를 1 감소시킨 임시 복사본을 덱에 섞어 넣는다."
  },
  State_67625_Name = {
    Text = "소리를 잃은 축음기"
  },
  State_67626_Desc = {
    Text = "최대 행동력이 1 증가한다. 연속 2회, 이전 카드보다 행동력 소모가 높은 카드를 사용할 때, 행동력 1을 획득한다."
  },
  State_67626_Name = {
    Text = "아르카나 기록"
  },
  State_67628_Name = {Text = "폐기"},
  State_67630_Name = {Text = "폐기"},
  State_67631_Desc = {
    Text = "최대 행동력이 2 증가한다. 덱을 재설정할 때마다 <DerivativeCardKeywords_9:「비틀거림」> 1장을 덱에 추가한다."
  },
  State_67631_Name = {
    Text = "검은 양초"
  },
  State_67632_Name = {Text = "폐기"},
  State_67634_Desc = {
    Text = "턴 종료 시 손에 남은 카드 1장당, 모든 깨어남체가 광기 2를 획득한다."
  },
  State_67634_Name = {
    Text = "불균형한 저울"
  },
  State_67635_Desc = {
    Text = "획득 시, 모든 깨어남체가 광기 50을 획득하며, <DerivativeCardKeywords_1:「유영의 메아리」> 2장을 덱에 섞어 넣는다."
  },
  State_67635_Name = {
    Text = "통신 장비+β"
  },
  State_67636_Desc = {
    Text = "치명타 피해가 15% 증가한다. 실타래드가 있는 적에게 주는 피해는 반드시 치명타로 적중한다."
  },
  State_67636_Name = {
    Text = "미학 원리"
  },
  State_67637_Desc = {
    Text = "턴 시작 시 카드 2장을 드로우하고, 행동력 2를 획득한다. 명령 카드나 영지 깨어남을 드로우할 때마다, 해당 카드의 행동력 소모가 무작위로 변화한다 (0-4)."
  },
  State_67637_Name = {
    Text = "속임수의 모자"
  },
  State_67638_Desc = {
    Text = "부정 상태에 있는 적에게 주는 피해가 50% 증가하며, 적을 처치한 후 처치자가 광기 100을 획득한다."
  },
  State_67638_Name = {
    Text = "제사장의 지팡이+"
  },
  State_67639_Desc = {
    Text = "치명타율이 50% 증가하고, 치명타 피해가 100% 증가한다."
  },
  State_67639_Name = {
    Text = "축복·기괴한 갈고리발톱"
  },
  State_67640_Desc = {
    Text = "치명타율과 치명타 피해가 100% 증가한다. 피해 또는 촉수 피해를 1회 줄 때마다, 이번 턴 동안 모든 깨어남체의 치명타율과 치명타 피해가 10% 감소하며, 최대 50%까지 감소한다. 주는 중독과 반격이 10% 증가하며, 최대 50%까지 증가한다."
  },
  State_67640_Name = {
    Text = "시계추·물결"
  },
  State_67641_Desc = {
    Text = "광기 폭발을 발동한 후, [DescArg1]의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  State_67641_Name = {
    Text = "무거운 자물쇠"
  },
  State_67643_Desc = {
    Text = "능동 피해를 입힐 때 [DescArg1]의 실타래드를 획득한다. HP를 회복할 때, [DescArg2]의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  State_67643_Name = {
    Text = "우리의 집"
  },
  State_67645_Desc = {
    Text = "치명타율이 10% 증가한다. 매 턴 최초로 치명타를 발생시킨 후 치명타율이 추가로 20% 증가하며, 매 턴 3번째 치명타를 발생시키면 치명타 피해가 추가로 50% 증가한다."
  },
  State_67645_Name = {
    Text = "축제의 축복"
  },
  State_67646_Desc = {
    Text = "홀수 턴 종료 시, 남은 행동력이 있으면 다음 턴에 추가로 카드 2장을 드로우한다. 짝수 턴 종료 시, 남은 손패가 있으면 다음 턴에 추가로 행동력 2를 획득한다."
  },
  State_67646_Name = {
    Text = "해와 달의 룰렛"
  },
  State_67647_Desc = {
    Text = "5번째로 사용하는 명령 카드는 2회 발동하며, 사용 후 손으로 되돌아온다."
  },
  State_67647_Name = {
    Text = "별들의 술 +"
  },
  State_67649_Desc = {
    Text = "몬스터 의도를 숨긴다. 매 턴 행동력 1을 획득하고, 카드 1장을 드로우한다."
  },
  State_67649_Name = {
    Text = "미혹의 풍령"
  },
  State_67650_Desc = {
    Text = "「타격」과 「방어」가 은열쇠 에너지 50을 추가로 획득한다. 행동력 소모가 2 이상인 카드를 1장 사용할 때마다, 행동력 소모가 1인 카드 1장을 드로우하고 해당 카드의 행동력 소모를 0으로 변경한다. 매 턴 최대 3회 발동된다."
  },
  State_67650_Name = {
    Text = "시계추·쌍둥이"
  },
  State_67651_Desc = {
    Text = "획득 시 팀의 영역 숙련이 원래 값의 150%로 변경된다. 매 턴 5번째 명령 카드를 사용한 후, 모든 깨어남체가 광기 20을 획득한다."
  },
  State_67651_Name = {
    Text = "시계추·불결"
  },
  State_67653_Desc = {
    Text = "매 턴 광기 폭발을 2회 발동한 후, 모든 깨어남체가 광기 8을 획득하며, 3회 발동한 후, 모든 깨어남체가 다시 광기 8을 획득한다."
  },
  State_67653_Name = {
    Text = "잊혀진 자의 피"
  },
  State_67654_Name = {
    Text = "[DescArg1]회 추가 발동"
  },
  State_67656_Desc = {
    Text = "치명타율이 50% 증가하고, 자신에게 3턴간 <FragileIconKeywords:손상>을 부여한다."
  },
  State_67656_Name = {
    Text = "기이한 갈고리 발톱"
  },
  State_67657_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다. 연속 2회, 이전 카드와 동일한 행동력 소모를 가진 카드를 사용할 때, 추가로 카드 1장을 드로우하며, 매 턴 최대 3회 발동된다."
  },
  State_67657_Name = {
    Text = "만상 영지의 신비 의식"
  },
  State_67658_Desc = {
    Text = "실타래제 행동력 소모가 3인 카드를 1장 사용하면, 카드 1장을 드로우하고 행동력 2를 획득한다. 실타래제 행동력 소모가 4 이상인 카드를 1장 사용하면, 다른 손패의 행동력 소모가 1 감소한다."
  },
  State_67658_Name = {
    Text = "시계추·눈"
  },
  State_67659_Desc = {
    Text = "턴 시작 시 적 1명당 행동력 2를 획득한다. 능동 피해로 적을 처치할 때, 다른 적에게 과잉 피해의 2배만큼 <BleedingIconKeywords:출혈>을 부여한다."
  },
  State_67659_Name = {
    Text = "군중의 노래+"
  },
  State_67660_Desc = {
    Text = "매 3번째 「타격」을 사용할 때마다, 모든 적에게 [DescArg1]의 피해를 주고, 해당 깨어남체가 광기 15를 획득한다."
  },
  State_67660_Name = {
    Text = "녹슨 메스"
  },
  State_67661_Desc = {
    Text = "행동력을 소모할 때마다, 카드 1장을 드로우한다. 매 턴 최대 5회 발동된다. 덱이 초기화될 때마다, 행동력 2를 획득한다."
  },
  State_67661_Name = {
    Text = "시계추·불면"
  },
  State_67662_Desc = {
    Text = "깨어남체가 아닌 카드를 사용할 때마다, 광기가 가장 낮은 깨어남체가 광기 10을 획득한다."
  },
  State_67662_Name = {
    Text = "이국의 우표집"
  },
  State_67665_Desc = {
    Text = "최대 행동력이 2 증가한다. 「타격」 또는 「방어」를 사용한 후, 해당 깨어남체가 광기 5를 획득한다. 광기 폭발을 발동한 후, 해당 깨어남체의 소모와 허무가 부여된 「타격」 1장을 획득한다. 열쇠 지령을 발동한 후, 무작위로 소모와 허무가 부여된 「방어」 1장을 획득한다."
  },
  State_67665_Name = {
    Text = "시계추·날개"
  },
  State_67666_Desc = {
    Text = "피해를 줄 때마다 [DescArg1]의 임시 <PowerIconKeywords:힘>을 획득하며, 최대 3회 중첩된다. 최대 중첩 시 효과가 2배로 증가한다."
  },
  State_67666_Name = {Text = "줄마노"},
  State_67667_Desc = {
    Text = "턴 종료 후 모든 깨어남체가 광기 5를 획득한다. 남은 행동력 1pt당 모든 깨어남체가 추가로 광기 3을 획득한다."
  },
  State_67667_Name = {
    Text = "원형 배터리"
  },
  State_67668_Desc = {
    Text = "치명타 피해가 15% 증가한다. 「타격」의 치명타율이 40% 증가한다."
  },
  State_67668_Name = {
    Text = "흰 까마귀 부리"
  },
  State_67669_Name = {Text = "폐기"},
  State_67670_Desc = {
    Text = "광기 폭발 후 카드 1장을 드로우한다. HP가 25% 미만일 경우, 추가로 카드 1장을 드로우한다."
  },
  State_67670_Name = {
    Text = "지식의 독서륜"
  },
  State_67671_Desc = {
    Text = "능동 피해를 1회 입힐 때마다, [DescArg1]의 HP를 회복하고, 피해 대상에게 [DescArg2]스택의 <BleedingIconKeywords:출혈>을 부여한다."
  },
  State_67671_Name = {
    Text = "축복·군충 의식"
  },
  State_67672_Desc = {
    Text = "<WeaknessIconKeywords:허약> 효과가 8% 증가하고, <VulnerabilityIconKeywords:취약> 효과가 25% 증가한다. <WeaknessIconKeywords:허약> 또는 <VulnerabilityIconKeywords:취약>을 부여할 때, 대상의 <PowerIconKeywords:힘> [DescArg1]pt를 임시로 탈취한다."
  },
  State_67672_Name = {
    Text = "빛바랜 사진+"
  },
  State_67673_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다."
  },
  State_67673_Name = {
    Text = "방위 나침반"
  },
  State_67674_Desc = {
    Text = "명령 카드를 1장 사용할 때마다 [DescArg2]%의 <DeathResistanceIconKeywords:죽음 저항>을 획득한다(이번 스테이지 내에서 죽음 저항이 발동될 때마다 획득하는 죽음 저항이 절반으로 감소한다). <DeathResistanceIconKeywords:죽음 저항>이 100% 이상일 경우, 대신 [DescArg1]의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  State_67674_Name = {
    Text = "뱀의 허물"
  },
  State_67675_Desc = {
    Text = "턴 종료 시 남은 행동력이 있으면 다음 턴에 추가로 카드 2장을 드로우한다. 남은 손패가 있으면 다음 턴에 추가로 행동력 2를 획득한다."
  },
  State_67675_Name = {
    Text = "해와 달의 룰렛+"
  },
  State_67677_Desc = {
    Text = "<WeaknessIconKeywords:허약>을 부여할 때 [DescArg1]pt의 실타래드를 획득하고, <VulnerabilityIconKeywords:취약>을 부여할 때 [DescArg2]pt의 임시 <PowerIconKeywords:힘>을 획득한다. 1턴 내에 이 두 효과가 모두 발동하면, 추가로 [DescArg1]pt의 실타래드와 [DescArg2]pt의 임시 <PowerIconKeywords:힘>을 획득한다."
  },
  State_67677_Name = {
    Text = "무거운 액자"
  },
  State_67703_Desc = {
    Text = "턴 시작 시, 이전 턴에 남은 손패 수가 3장을 초과하면, 행동력 2를 획득한다."
  },
  State_67703_Name = {
    Text = "미사그 배지"
  },
  State_67704_Desc = {
    Text = "광기 폭발을 발동한 후, 해당 깨어남체가 광기 10을 획득하고, [DescArg1]의 실타래드를 획득한다."
  },
  State_67704_Name = {
    Text = "무명 신의 베일"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:만물의 이치를 통달함>: 사용 후 원래대로 돌아오며, 광기 <Energy:[StateArg1]>pt 획득"
  },
  State_67841_WeaponDesc = {
    Text = "사용 전에 카드의 행동력을 변경한다."
  },
  State_67844_Desc = {
    Text = "치명적 피해를 받은 후 모든 HP를 회복한다. 최대 1회 활성화 가능하며, 현재 [DescArg1]회 활성화되었다."
  },
  State_67844_Name = {
    Text = "태고의 혼돈"
  },
  State_67866_Name = {
    Text = "<BleedingColour: 출혈>"
  },
  State_68298_Desc = {
    Text = "치명적 피해를 입은 후 의도가 「진·깊은 우주의 주목」으로 전환되며 임시 보강 80스택을 획득하고 모든 HP를 회복한다. 이 효과는 [DescArg1]회 발동 가능하다. 턴 종료 시, 자신은 보강 20스택을 제거한다."
  },
  State_68298_Name = {Text = "별가루"},
  State_68554_Desc = {
    Text = "치명적 피해를 받은 후 모든 HP를 회복하고, 다른 적들이 모두 사망한 후 해당 상태를 제거한다. 최대 1회 발동 가능하며, 현재 [DescArg1]회 발동되었다."
  },
  State_68554_Name = {
    Text = "태고의 혼돈 파편"
  },
  State_68621_Desc = {
    Text = "전투 시작 및 매 턴 종료 시, 임시 <ResentChainsKeywords:원한의 사슬> 2층을 획득합니다."
  },
  State_68621_Name = {
    Text = "기괴한 격류"
  },
  State_68622_Desc = {
    Text = "깨어남체가 부여하는 힘 효과가 75% 감소한다. HP를 잃을 때마다 [DescArg1]의 실타래드와 임시 보강 1스택을 획득한다."
  },
  State_68622_Name = {
    Text = "이단의 격류"
  },
  State_68623_Desc = {
    Text = "명령 카드 1장을 사용할 때마다, 해당 깨어남체의 행동력 소모가 가장 낮은 카드 1장을 버린다."
  },
  State_68623_Name = {
    Text = "광란의 격류"
  },
  State_68624_Desc = {
    Text = "턴 종료 시, 잃은 HP의 10%를 회복하고, 자신의 부정 상태와 플레이어의 긍정 상태를 해제한다."
  },
  State_68624_Name = {
    Text = "강림의 격류"
  },
  State_68626_Desc = {
    Text = "모든 깨어남체의 기본 광기가 50% 증가한다. 매 턴 종료 시, 모든 깨어남체의 광기 10을 차감하고, 자신은 최대 HP의 3%를 회복한다."
  },
  State_68626_Name = {
    Text = "공포의 격류"
  },
  State_68627_Desc = {
    Text = "전투 시작 시, 임시 장벽 15스택을 획득한다. 턴 종료 시, 임시 장벽 15스택을 획득하고, 무작위 카드 10장에 「임시 용해」를 부여한다."
  },
  State_68627_Name = {
    Text = "살을 에는 급류"
  },
  State_68632_Desc = {
    Text = "모든 명령 카드의 행동력 소모가 1 증가한다. 매 3턴마다 턴 종료 시 「점점 석화됨」 1장을 손에 넣는다."
  },
  State_68632_Name = {
    Text = "비탄의 격류"
  },
  State_68635_Name = {
    Text = "「순은의 핵심·공포」"
  },
  State_68637_Desc = {
    Text = "HP를 잃을 때, 잃은 만큼 스택이 감소한다. 스택이 0이 되면, 플레이어가 임시 장벽 2스택을 획득하고, 자신이 [DescArg1]스택의 실타래드와 [DescArg2]스택의 임시 보강을 획득하며, [DescArg3]스택의 차원 장벽을 다시 획득한다."
  },
  State_68637_Name = {
    Text = "차원 장벽"
  },
  State_68638_Name = {
    Text = "「순은의 핵심·사신」"
  },
  State_68646_Desc = {
    Text = "기본 피해와 실타래드량이 200% 증가하지만, 사용 후 소모된다."
  },
  State_68646_Name = {
    Text = "<RedQuality1:임시 용해>"
  },
  State_68647_Name = {
    Text = "「순음의 핵·광기」"
  },
  State_68680_Desc = {
    Text = "고대의 파편을 제거한다."
  },
  State_68680_Name = {
    Text = "태고의 파편 제거"
  },
  State_68704_Desc = {
    Text = "토후와보가 진정으로 강림하기까지 [DescArg1]턴이 남아 있다..."
  },
  State_68704_Name = {Text = "강림"},
  State_68829_Desc = {
    Text = "능동 또는 촉수 피해를 받을 때, 피해 면역 후 1층 감소, 턴 시작 시 제거."
  },
  State_68829_Name = {
    Text = "<ParcloseColour:임시 장벽>"
  },
  State_68829_WeaponDesc = {
    Text = "받는 피해 99% 감소, 피해를 받을 때마다 1스택 감소."
  },
  State_70026_Desc = {
    Text = "이 카드는 「유지」를 가지며, 사용 후 모든 깨어남체의 임시 치명타율이 [StateArg1]% 증가하고 「불멸의 지배」가 제거된다. 현재 계역이 심해일 경우, 「불멸의 지배」 제거 후 행동력 1을 획득한다."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:불멸의 지배>"
  },
  State_70031_Desc = {
    Text = "팀 유일: 전투 시작 시, 덱에 있는 장착한 깨어남체의 모든 행동력 소모가 3 이상인 명령 카드에 「불멸의 지배」 효과를 부여한다. 「불멸의 지배」: 이 카드는 「유지」를 가지며, 사용 후 모든 깨어남체의 임시 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가하고 「불멸의 지배」가 제거된다. 현재 계역이 심해일 경우, 「불멸의 지배」 제거 후 행동력 1을 획득한다."
  },
  State_70031_WeaponDesc = {
    Text = "전투 시작 시, 덱에 있는 장착한 깨어남체의 모든 행동력 소모가 3 이상인 명령 카드에 「불멸의 지배」 효과를 부여한다. 「불멸의 지배」: 이 카드는 「유지」를 가지며, 사용 후 모든 깨어남체의 임시 치명타율이 <WeaponEffect_Num:[StateArg1]%> 증가하고 「불멸의 지배」가 제거된다. 현재 계역이 심해일 경우, 「불멸의 지배」 제거 후 행동력 1을 획득한다."
  },
  State_70182_Desc = {
    Text = "획득하는 모든 실타래드가 [DescArg1]% 감소한다."
  },
  State_70182_Name = {
    Text = "<FragileColour:손상>"
  },
  State_70182_WeaponDesc = {
    Text = "획득하는 모든 실타래드가 33% 감소한다."
  },
  State_70277_Desc = {
    Text = "능동 또는 촉수 피해를 받은 후, [StateArg1]% 피해를 진홍빛 용광로 회복량으로 전환하며, [Layer] 턴 동안 지속됩니다."
  },
  State_70277_Name = {
    Text = "창조 의식"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, 손에 있는 장착한 깨어남체의 모든 「스킬」이 주는 피해, 치유 및 실타래드 효과를 [StateArg1]% 증가시킨다."
  },
  State_70287_Name = {
    Text = "청석 왕좌"
  },
  State_70288_Desc = {
    Text = "이 카드가 주는 피해, 치료 및 실타래드가 [DescArg1]% 증가한다."
  },
  State_70288_Name = {
    Text = "청석 왕좌"
  },
  State_70313_Desc = {
    Text = "보스전에서 턴 시작 시 및 「융해·돌」이 광기 폭발을 발동한 후, 「종말」 1스택을 획득한다. 「종말」은 최대 10스택까지 보유할 수 있으며, 10스택에 도달하면 「허무 종결」 1장을 손에 넣는다."
  },
  State_70313_Name = {
    Text = "소멸의 길"
  },
  State_70318_Desc = {
    Text = "모든 적에게 [StateArg1] 턴 <VulnerabilityIconKeywords:취약>을 부여하고, 1턴 「흥분」 상태 획득: 피해 증폭 +[StateArg2]%."
  },
  State_70318_Name = {Text = "흥분"},
  State_70322_Desc = {
    Text = "종말 10스택을 보유하고 있을 때, 「허무 종결」 1장을 손에 넣는다."
  },
  State_70322_Name = {Text = "종말"},
  State_70330_Desc = {
    Text = "1턴간 「흥분」 상태를 획득한다: 피해 증폭 +[Arg2]%."
  },
  State_70330_Name = {Text = "흥분"},
  State_70346_Desc = {
    Text = "모든 적에게 [StateArg1]턴간 <WeaknessIconKeywords:허약>을 부여하고, 이번 턴 동안 <PowerIconKeywords:힘>을 [Exhaustion:StateArg3] 감소시킨다."
  },
  State_70346_Name = {Text = "저주"},
  State_70347_Desc = {
    Text = "모든 적의 <PowerIconKeywords:힘>을 이번 턴 동안 [Exhaustion:StateArg3] 감소시킨다."
  },
  State_70347_Name = {Text = "저주"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착자가 매 턴 처음 [StateArg1]번 공격을 받을 때, 공격자에게 <PVPEmptinessKeywords:공허>를 입힙니다."
  },
  State_70374_Name = {
    Text = "허무 속으로 추락한 인형"
  },
  State_70379_Desc = {
    Text = "공격자에게 <PVPEmptinessKeywords:공허>를 부여합니다. 공격을 받은 후 이 상태를 제거합니다."
  },
  State_70379_Name = {
    Text = "공허 반격"
  },
  State_70443_Desc = {
    Text = "종말 10스택을 보유하고 있을 때, 「허무 종결」 1장을 손에 넣는다."
  },
  State_70443_Name = {Text = "종말"},
  State_70539_Name = {
    Text = "영혼의 역병"
  },
  State_70589_Desc = {
    Text = "연속 2회, 이전 카드보다 행동력 소모가 낮은 카드를 사용할 때, 모든 적에게 중독 40/80을 부여하며, 매 턴 최대 5회 발동된다."
  },
  State_70590_Desc = {
    Text = "매 턴 최초로 배아를 직접 사용한 후, 이번 턴 내에 능동 피해가 피해량의 15/30%만큼 출혈을 부여한다."
  },
  State_70593_Desc = {
    Text = "비파생 명령 카드를 사용한 후, 해당 카드의 행동력 소모를 2 감소시킨 임시 복사본 1/2장을 덱에 섞어 넣는다. 3턴 쿨다운."
  },
  State_70594_Desc = {
    Text = "턴 종료 시, 조수 자세일 경우 촉수 피해 32/64를 획득한다. 3턴 쿨다운."
  },
  State_70595_Desc = {
    Text = "전투 시작 시 모든 적에게 중독 1280을 부여하며, 보스전에서는 효과가 2배로 증가한다."
  },
  State_70598_Desc = {
    Text = "카드가 초차원 공간에 들어갈 때, 해당 카드가 다른 초차원 공간 카드의 소속 깨어남체와 다를 경우, 「영감」 0.5장/1장을 손에 넣는다."
  },
  State_70600_Desc = {
    Text = "턴 종료 시 HP 32를 회복한다."
  },
  State_70600_Name = {
    Text = "은사의 피"
  },
  State_70602_Desc = {
    Text = "은열쇠 깨어남 사용 후 카드 4장을 드로우한다."
  },
  State_70603_Desc = {
    Text = "은열쇠 깨어남 사용 후 모든 깨어남체가 광기 10을 획득한다."
  },
  State_70605_Desc = {
    Text = "은열쇠 깨어남 사용 후 힘 32를 획득한다."
  },
  State_70607_Desc = {
    Text = "연속 2회, 이전 카드보다 행동력 소모가 높은 카드를 사용할 때, 반격 24/48을 획득하며, 매 턴 최대 5회 발동된다."
  },
  State_70609_Desc = {
    Text = "은열쇠 깨어남 사용 후 실타래드 96을 획득한다."
  },
  State_70609_Name = {
    Text = "나비 표본"
  },
  State_70611_Desc = {
    Text = "은열쇠 깨어남 사용 후 모든 깨어남체가 주는 기본 피해가 25%/50% 증가한다."
  },
  State_70614_Name = {
    Text = "레이저 턱뼈+"
  },
  State_70617_Desc = {
    Text = "매 턴 처음 5회 주는 피해가 15%/30% 증가한다."
  },
  State_70618_Desc = {
    Text = "턴 시작 시 카드 1장을 드로우한다."
  },
  State_70619_Desc = {
    Text = "「타격」이 피해량의 10%/20%만큼 중독을 부여하며, 매 턴 최대 320/640까지 중독 피해를 준다."
  },
  State_70620_Desc = {
    Text = "적에게 공격받을 때 해당 적에게 아군 최대 HP의 25%/50%에 해당하는 <FixedDamage:순수 피해>를 1회 입힙니다. 이 피해는 100%/200% 반격 계수를 적용받으며, 각 적마다 매 턴 최대 1회 발동합니다."
  },
  State_70620_Name = {
    Text = "유실타래된 제사 단검"
  },
  State_70621_Desc = {
    Text = "은열쇠 깨어남 사용 후 실타래드 192를 획득한다."
  },
  State_70621_Name = {
    Text = "나비 표본+"
  },
  State_70623_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 10을 획득한다."
  },
  State_70624_Desc = {
    Text = "은열쇠 깨어남 사용 후 모든 깨어남체가 광기 20을 획득한다."
  },
  State_70628_Desc = {
    Text = "턴 시작 시 카드 2장을 드로우한다."
  },
  State_70629_Desc = {
    Text = "매 턴 최초 포식 시, 다른 깨어남체가 광기 10/20을 획득한다."
  },
  State_70635_Desc = {
    Text = "은열쇠 깨어남 사용 후 반격 416을 획득한다."
  },
  State_70636_Desc = {
    Text = "HP를 잃을 때, 잃은 HP의 10%/20%만큼 핏빛 용광로를 획득한다."
  },
  State_70637_Desc = {
    Text = "전투 시작 시, 촉수 상한이 1/2 증가하고, 촉수 1/2개를 획득한다."
  },
  State_70641_Desc = {
    Text = "소멸로 실타래드 160/320을 획득하며, 3턴 쿨다운을 가진다."
  },
  State_70641_Name = {
    Text = "초현실타래 회중시계"
  },
  State_70643_Desc = {
    Text = "턴 시작 시 행동력 1을 획득한다."
  },
  State_70644_Desc = {
    Text = "광기 폭발을 사용한 후, 임시 힘 16/32를 획득한다."
  },
  State_70645_Desc = {
    Text = "턴 시작 시 행동력 2를 획득한다."
  },
  State_70646_Name = {
    Text = "유실타래된 제사 단검+"
  },
  State_70647_Desc = {
    Text = "모든 깨어남체가 주는 기본 피해가 30% 증가한다."
  },
  State_70648_Desc = {
    Text = "전투 시작 시 모든 적에게 중독 640을 부여하며, 보스전에서는 효과가 2배로 증가한다."
  },
  State_70656_Desc = {
    Text = "「타격」이 추가로 1/2회, 깨어남체 공격력의 60%만큼 피해를 추가로 주며, 매 턴 최대 3회 발동된다."
  },
  State_70657_Desc = {
    Text = "전투 시작 시 힘 32를 획득한다."
  },
  State_70660_Desc = {
    Text = "전투 시작 시 힘 64를 획득한다."
  },
  State_70661_Desc = {
    Text = "턴 종료 시 HP 64를 회복한다."
  },
  State_70661_Name = {
    Text = "은혜의 피+"
  },
  State_70662_Desc = {
    Text = "은열쇠 깨어남 사용 후 행동력 2를 획득한다."
  },
  State_70664_Desc = {
    Text = "은열쇠 깨어남 사용 후 힘 16을 획득한다."
  },
  State_70666_Desc = {
    Text = "전투 시작 후, 영역 숙련 100/200을 획득한다. 모든 깨어남체가 주는 기본 중독과 유물이 주는 중독이 10%/20% 증가한다."
  },
  State_70667_Desc = {
    Text = "은열쇠 깨어남 사용 후 행동력 4를 획득한다."
  },
  State_70670_Desc = {
    Text = "전투 시작 시 반격 320을 획득하며, 보스전에서는 효과가 2배로 증가한다."
  },
  State_70671_Desc = {
    Text = "초차원 턴에 진입한 후, 첫 번째로 사용한 비파생 명령 카드가 1/2회 추가로 발동된다."
  },
  State_70678_Desc = {
    Text = "전투 시작 시 반격 640을 획득하며, 보스전에서는 효과가 2배로 증가한다."
  },
  State_70681_Desc = {
    Text = "모든 깨어남체가 주는 기본 피해가 60% 증가한다."
  },
  State_70682_Desc = {
    Text = "손패가 2장 이하일 때, 카드 1/2장을 드로우한다. 매 턴 최대 2회 발동된다."
  },
  State_70683_Desc = {
    Text = "소멸로 광기가 가장 낮은 깨어남체가 광기 50/100을 획득하며, 3턴 쿨다운을 가진다."
  },
  State_70684_Desc = {
    Text = "턴 시작 시, HP가 25% 미만이면 임시 힘 72/144를 획득한다."
  },
  State_70685_Desc = {
    Text = "은열쇠 깨어남 사용 후 모든 적에게 중독 416을 부여한다."
  },
  State_70686_Desc = {
    Text = "광기 폭발 발동 후, 모든 적에게 아군 최대 HP의 15%/30%에 해당하는 <FixedDamage:순수 피해>를 1회 입히고, 10%/20% 중독을 발동합니다."
  },
  State_70687_Name = {
    Text = "초한 회중시계+"
  },
  State_70689_Desc = {
    Text = "은열쇠 깨어남 사용 후 모든 적에게 중독 832을 부여한다."
  },
  State_70690_Desc = {
    Text = "전투 시작 후, 영역 숙련 100/200을 획득한다. 모든 깨어남체가 주는 기본 반격과 유물이 주는 반격이 10%/20% 증가한다."
  },
  State_70691_Desc = {
    Text = "피해를 입힐 때마다 임시 힘 4/8을 획득하며, 매 턴 최대 15회 발동된다."
  },
  State_70693_Desc = {
    Text = "배아 융합 자동 획득량이 100%/200% 증가한다."
  },
  State_70694_Desc = {
    Text = "은열쇠 깨어남 사용 후 카드 2장을 드로우한다."
  },
  State_70695_Desc = {
    Text = "매 턴 시작 시 모든 깨어남체가 광기 5를 획득한다."
  },
  State_70696_Desc = {
    Text = "은열쇠 깨어남 사용 후 반격 208을 획득한다."
  },
  State_70698_Desc = {
    Text = "방어가 임시 반격 200/400을 획득한다. 매 턴 최대 3회 발동된다."
  },
  State_70804_Name = {
    Text = "생사의 한계"
  },
  State_70805_Desc = {
    Text = "전투 시작 후, 모든 적에게 허약 1/2스택을 부여하며, 보스에게는 효과가 2배로 적용된다. 모든 깨어남체가 주는 기본 피해가 15%/30% 증가한다."
  },
  State_70806_Name = {
    Text = "수호의 손+"
  },
  State_70808_Desc = {
    Text = "정해 자세를 사용하여 모든 적에게 쇠약 64/128을 부여한다. 3턴 쿨다운."
  },
  State_70809_Desc = {
    Text = "턴 시작 시, HP가 25% 미만이면 실타래드 100/200을 획득한다."
  },
  State_70809_Name = {
    Text = "수호의 손"
  },
  State_70810_Desc = {
    Text = "노도 자세를 사용하여 즉시 모든 촉수가 적을 1/2회 공격하게 한다. 3턴 쿨다운."
  },
  State_70812_Desc = {
    Text = "전투 시작 후, 모든 적에게 취약을 1/2스택 부여하며, 보스에게는 효과가 2배로 적용된다. 모든 깨어남체가 주는 기본 피해가 15%/30% 증가한다."
  },
  State_70832_Desc = {
    Text = "팀 유일: 전투 시작 시, 장착한 깨어남체가 장착한 깨어남체의 광기 회충량의 <WeaponEffect_Num:[StateArg1]%>만큼 광기를 획득한다. 장착한 깨어남체가 매 전투 최초로 광기 폭발을 발동한 후, 이 효과를 한 번 더 반복한다."
  },
  State_70832_WeaponDesc = {
    Text = "전투 시작 시, 장착한 깨어남체가 장착한 깨어남체의 광기 회충량의 <WeaponEffect_Num:[StateArg1]%>만큼 광기를 획득한다(<WeaponEffect_Num:[DescArg1]>). 장착한 깨어남체가 매 전투 최초로 광기 폭발을 발동한 후, 이 효과를 한 번 더 반복한다."
  },
  State_70835_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 광기, 중독, HP 회복이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후, 이번 광기 소모량의 <WeaponEffect_Num:[StateArg2]%>에 해당하는 광기를 획득한다."
  },
  State_70835_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 광기, 중독, HP 회복이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체가 광기 폭발을 발동한 후, 이번 광기 소모량의 <WeaponEffect_Num:[StateArg2]%>에 해당하는 광기를 획득한다."
  },
  State_70989_Desc = {
    Text = "한 턴에 광기 폭발을 4회 발동한 후, 행동력 3/6을 획득한다. 3턴 쿨다운."
  },
  State_71001_Desc = {
    Text = "한 턴 내에 서로 다른 깨어남체에 속한 명령 카드 4장을 사용한 후, 모든 깨어남체가 광기 20/40을 획득한다. 3턴 쿨다운."
  },
  State_71153_Desc = {
    Text = "턴 시작 시 케익스가 광기 15를 획득한다. 케익스가 실타래드를 획득하면 실타래드량의 50%만큼 HP를 회복한다."
  },
  State_71154_Desc = {
    Text = "턴 시작 시 아이기스가 광기 15pt를 획득한다. 아이기스가 취약 상태의 적에게 피해를 입힐 때, 해당 적의 임시 힘 10pt를 탈취한다. 매 턴 최대 5회 발동된다."
  },
  State_71155_Desc = {
    Text = "턴 시작 시 레아가 광기 15를 획득한다. HP를 잃을 때마다 힘 8을 획득하며, 매 전투 최대 10회 중첩된다. 10회 중첩 후, 「고통과 환희」의 행동력 소모가 1로 변경되고, 피해 횟수가 1 증가한다."
  },
  State_71156_Desc = {
    Text = "턴 시작 시 아그리파가 광기 15를 획득한다. 「불인한 시혜」는 아그리파가 이번 턴 동안 행동력 소모를 1 감소시키며, 매 턴 최대 1회 발동된다."
  },
  State_71157_Desc = {
    Text = "턴 시작 시 산이 광기 15를 획득한다. 전투 시작 시 산의 모든 명령 카드에 유지, 예비 1을 부여하고 실타래드 24를 획득한다."
  },
  State_71157_Name = {
    Text = "차원 영상 · 산"
  },
  State_71158_Desc = {
    Text = "턴 시작 시 돌이 광기 15를 획득한다. 전투 시작 후 돌의 「등가 교환」 행동력 소모가 0으로 변경되며, 사용 후 다음 턴에 추가로 카드 2장을 드로우한다."
  },
  State_71159_Desc = {
    Text = "턴 시작 시 팔로스가 광기 15를 획득한다. 촉수 피해를 1회 줄 때마다, 팔로스가 이번 전투에서 부여하는 중독이 1% 증가하며, 최대 100%까지 증가한다."
  },
  State_71160_Desc = {
    Text = "턴 시작 시 「24」가 광기 15를 획득한다. 턴 시작 시 「24」가 「우울 인격」 상태일 경우 광기 25를 추가로 획득하고, 「조증 인격」 상태일 경우 「24」의 임시 치명타율과 임시 치명타 피해가 35% 증가한다."
  },
  State_71161_Desc = {
    Text = "턴 시작 시 파인트가 광기 15를 획득한다. 죽음 저항이 발동될 때마다 파인트가 이번 탐색에서 주는 실타래드, 반격, HP 회복이 20% 증가하며, 최대 5회 발동된다."
  },
  State_71162_Desc = {
    Text = "턴 시작 시 골리아가 광기 15를 획득한다. 골리아가 1턴 내에 피해를 3회 입혔을 경우, 골리아가 주는 피해는 이번 전투에서 추가로 1배의 힘 보너스를 받는다. 3턴 쿨다운."
  },
  State_71163_Desc = {
    Text = "턴 시작 시 혈쇄·히로가 광기 15를 획득한다. 혈쇄·히로의 능동 피해가 출혈 20%를 추가로 부여하며, 적을 처치한 후 다른 적에게 과잉 피해와 동일한 출혈을 부여한다."
  },
  State_71164_Desc = {
    Text = "턴 시작 시 오레타가 광기 15를 획득한다. 「선체 분열」의 피해 횟수가 1 증가하며, 오레타의 「방어」를 사용한 후 「선체 분열」 1장을 손에 넣는다."
  },
  State_71166_Desc = {
    Text = "턴 시작 시 릴리가 광기 15를 획득한다. 릴리의 인내 상한이 100% 증가하며, 「진흙 위의 불멸의 꽃」 또는 「보복의 일격」을 사용할 때, 「인내」 스택의 8%만큼 HP를 회복한다."
  },
  State_71167_Desc = {
    Text = "턴 시작 시 로탄이 광기 15를 획득한다. 매 턴 최초로 로탄의 「방어」를 사용한 후, 소모와 허무가 부여된 「오만의 검」 2장을 손에 넣는다."
  },
  State_71168_Desc = {
    Text = "턴 시작 시 판디아가 광기 15를 획득한다. 턴 시작 시 반격 64를 획득한다. 비임시 반격 4pt당 「판디아」 명령 카드가 주는 피해가 1 증가한다."
  },
  State_71169_Desc = {
    Text = "턴 시작 시 히로가 광기 15를 획득한다. 카드 1장이 버려질 때마다, 「히로」가 광기 5를 획득한다."
  },
  State_71170_Desc = {
    Text = "턴 시작 시 타비가 광기 15를 획득한다. 한 턴 내에 타비의 명령 카드 6장을 사용하면, 「은열쇠 서광」 1장을 손에 넣는다. 3턴 쿨다운."
  },
  State_71171_Desc = {
    Text = "턴 시작 시 미리암이 광기 15를 획득하고, 「성례」 1장을 손에 넣는다."
  },
  State_71172_Desc = {
    Text = "턴 시작 시 융해·돌이 광기 15를 획득한다. 융해·돌이 광기 폭발을 발동한 후, 광기 20을 소모할 때마다 다른 깨어남체가 광기 1을 획득한다."
  },
  State_71173_Desc = {
    Text = "턴 시작 시 살바도르가 광기 15를 획득한다. 핏빛 용광로를 적립할 때마다 적립량의 5%만큼 힘을 추가로 획득한다. 살바도르의 「타격」과 「응소지고」가 추가로 1배의 힘 보너스를 받는다."
  },
  State_71175_Desc = {
    Text = "턴 시작 시 노틸라가 광기 15를 획득한다. 노틸라의 「광기 폭발」을 사용한 후, 현재 실타래드의 50%에 해당하는 반격을 획득하며, 매 턴 최대 1회 발동된다."
  },
  State_71177_Desc = {
    Text = "턴 시작 시 리즈가 광기 15를 획득한다. 「고통의 춤」으로 버린 카드가 추가로 1회 발동된다. 3턴 쿨다운."
  },
  State_71178_Desc = {
    Text = "턴 시작 시 라모나가 광기 15를 획득한다. 매 3번째 라모나의 명령 카드를 사용할 때마다, 해당 명령 카드가 추가로 1회 발동된다."
  },
  State_71179_Desc = {
    Text = "턴 시작 시 유우하시가 광기 15를 획득한다. 유우하시의 광기 소모가 10 감소하며, 광기 폭발을 발동할 때마다 광기 소모가 추가로 5 감소한다. 매 턴 광기 폭발을 2회 발동할 수 있다."
  },
  State_71180_Desc = {
    Text = "턴 시작 시 엘바가 광기 15를 획득한다. 이전 턴에 엘바가 「방어」를 2장 사용했다면, 소모된 「심안의 칼날」 1장을 손에 넣는다. 「타격」을 2장 사용했다면, 소모된 「임전 체세」 1장을 손에 넣는다."
  },
  State_71181_Desc = {
    Text = "턴이 시작될 때 소렐은 15의 광기를 획득합니다. 소렐이 1번의 데미지를 줄 때마다 배아 융합 +10, 턴당 최대 10회까지 적용됩니다. 10회 적용된 후에는 소렐의 이번 전투에서 크리티컬 데미지 +20%가 됩니다."
  },
  State_71182_Desc = {
    Text = "턴 시작 시 하멜른이 광기 15를 획득한다. 「영혼의 서곡」의 행동력 소모가 1 감소하고, 기본 피해 횟수가 1 증가한다."
  },
  State_71183_Desc = {
    Text = "턴 시작 시 타이스가 광기 15를 획득한다. 타이스가 1턴 내에 명령 카드 2장을 사용한 후, 「성결의 자식」 1장과 임시 힘 72를 획득한다. 3턴 쿨다운."
  },
  State_71187_Desc = {
    Text = "턴 시작 시 셀레스트가 광기 15를 획득한다. 턴 종료 전까지 손에 있는 셀레스트의 명령 카드 1장당 촉수 1개가 적을 공격하고 HP 8을 회복한다."
  },
  State_71188_Desc = {
    Text = "턴 시작 시 머피가 광기 15를 획득한다. 머피의 「타격」과 「방어」는 「희생」의 25%를 임시 촉수 피해로 전환할 수 있지만, 매 턴 최대 1회만 발동된다."
  },
  State_71189_Desc = {
    Text = "턴 시작 시 님피아가 광기 15를 획득한다. 님피아의 「타격」을 사용한 후, 님피아가 이번 전투에서 부여하는 중독이 20% 증가한다. 님피아의 「방어」를 사용한 후, 모든 적의 중독을 50% 발동시킨다. 매 턴 각각 최대 1회 발동된다."
  },
  State_71190_Desc = {
    Text = "턴 시작 시 오지에이 광기 15를 획득한다. 매 턴 최초로 오지에의 「관통의 창」 또는 「타격」을 사용한 후, 오지에이 이번 턴 내에 주는 실타래드와 힘이 50% 증가한다."
  },
  State_71191_Desc = {
    Text = "턴 시작 시 라이커가 광기 15를 획득한다. 매 턴 최초 주사위 결과는 항상 6이다."
  },
  State_71192_Desc = {
    Text = "턴 시작 시 순행·라모나가 광기 15를 획득한다. 매 턴 최초로 「회환」이 발동될 때, 은열쇠 에너지 500과 「음엔트로피」 1스택을 획득한다."
  },
  State_71193_Desc = {
    Text = "턴 시작 시 툴루가 광기 15를 획득한다. 툴루의 광기 소모가 10 감소하며, 광기 폭발을 발동한 후 즉시 임시 촉수 2개를 생성한다."
  },
  State_71194_Desc = {
    Text = "턴 시작 시 카렌이 광기 15를 획득한다. 「조용한 감시」를 사용하면 소모한 행동력의 2배를 반환한다. 3턴 쿨다운."
  },
  State_71271_Desc = {
    Text = "턴 시작 시 올라가 광기 15를 획득한다. 전투 시작 시 모든 감정의 은유를 각각 1스택씩 획득한다. 「은유」 효과가 50% 증가한다."
  },
  State_71272_Desc = {
    Text = "턴 시작 시 젠킨이 광기 15를 획득하며, 최종 피해가 5% 증가한다. 「브라운 출동!」의 기본 피해와 피해 증가량이 200% 증가한다."
  },
  State_71273_Desc = {
    Text = "턴 시작 시 다프다엘이 광기 15와 「영감」 1장을 획득한다. 「이질적 파도」를 사용할 때마다 해당 카드로 획득하는 힘이 이번 탐색에서 영구적으로 25% 증가하며, 최대 300%까지 증가한다."
  },
  State_71274_Desc = {
    Text = "턴 시작 시 틴커트가 광기 15를 획득한다. 틴커트의 명령 카드가 도약을 발동한 후 해당 카드를 손으로 되돌린다. 매 턴 최대 3회 발동된다."
  },
  State_71275_Desc = {
    Text = "턴 시작 시 완다가 광기 15를 획득하고 「꿈의 인도」 1스택을 획득한다. 현재가 초차원 턴일 경우, 추가로 임시 「등가시 사슬」과 「미로의 수호자」를 각각 1장씩 손에 넣는다."
  },
  State_71276_Desc = {
    Text = "턴 시작 시 에리카가 광기 15를 획득한다. 에리카가 1턴 내에 명령 카드 3장을 사용하면, 「영감」 1장을 획득하고 이번 전투에서 「전자기 폭발」이 받는 힘과 경계 보너스가 1배 증가한다."
  },
  State_71277_Desc = {
    Text = "턴 시작 시 카시아가 광기 15를 획득한다. 카드 1장을 드로우할 때마다 카시아가 광기 1을 획득한다. 카시아가 광기 폭발을 사용할 때 모든 적이 힘 32를 잃는다."
  },
  State_71278_Desc = {
    Text = "턴 시작 시 윙클이 광기 15를 획득한다. 다른 깨어남체가 광기 폭발을 발동할 때마다 윙클이 광기 5를 획득하고, 손에 있는 「정신 재건」의 행동력 소모가 1 감소한다."
  },
  State_71279_Desc = {
    Text = "피해 증폭 +[StateArg1]%, [Layer] 턴 유지."
  },
  State_71279_Name = {Text = "흥분"},
  State_71503_Name = {
    Text = "「종말 형태」: 추가로 카드 3장 드로우, 행동력 3pt 획득, 전체 적에게 [DescArg1]% <IntoxicationIconKeywords:중독> 발동, 「융해·돌」의 광기 상한 50pt 증가 (최대 3회)"
  },
  State_71581_Name = {
    Text = "영혼 단련"
  },
  State_71589_Name = {
    Text = "촉수 1개로 적을 공격하고 8pt 회복"
  },
  State_71605_Name = {
    Text = "실타래드 [StateArg1]pt 획득"
  },
  State_71650_Desc = {
    Text = "사망 후 부활하고 분신을 여러 개 소환하지만, 부활 후에는 어떤 보강이나 면역도 획득하지 않는다. [Layer]회 더 발동될 수 있다."
  },
  State_71650_Name = {
    Text = "만천 차원의 짐승"
  },
  State_71651_Desc = {
    Text = "HP를 잃을 때마다 [StateArg1]의 임시 힘을 잃는다. [Layer]회 남아 있으며, 매 턴 발동 횟수가 초기화된다."
  },
  State_71651_Name = {
    Text = "신사 모자"
  },
  State_71707_Desc = {
    Text = "능동 피해를 1회 받을 때마다 HP를 [StateArg1] 회복하며, [Layer] 턴 동안 지속됩니다."
  },
  State_71707_Name = {
    Text = "카이커스·지원"
  },
  State_71708_Desc = {
    Text = "턴 종료 시, 손에 있는 카드 1장당 모든 깨어남체가 [DescArg1]의 광기를 획득한다."
  },
  State_71708_Name = {
    Text = "카시아·지원"
  },
  State_71709_Desc = {
    Text = "턴 종료 시, 광기 35를 획득하고 [Layer]턴 동안 지속된다."
  },
  State_71709_Name = {
    Text = "윙클·지원"
  },
  State_71711_Desc = {
    Text = "깨어남체가 주는 피해가 25% 증가하며, [Layer]턴 동안 지속된다."
  },
  State_71711_Name = {
    Text = "젠킨·지원"
  },
  State_71712_Desc = {
    Text = "능동 피해를 가할 때, 촉수 1개가 1회 공격하며, [Layer] 턴 동안 지속됩니다."
  },
  State_71712_Name = {
    Text = "오레타·지원"
  },
  State_71712_WeaponDesc = {
    Text = "해월이 피해를 줄 때, [StateArg1]개의 촉수가 해당 대상을 공격한다."
  },
  State_71713_Desc = {
    Text = "「포식」을 수행할 때마다, 「타격」 2장을 드로우하고 해당 카드들의 행동력 소모를 1 감소시킨다. [Layer]턴 동안 지속된다."
  },
  State_71713_Name = {
    Text = "히로·지원"
  },
  State_71740_Desc = {
    Text = "다음 턴 시작 시 [Layer]pt의 실타래드를 획득한다."
  },
  State_71740_Name = {
    Text = "레아·지원 실타래드"
  },
  State_71741_Desc = {
    Text = "다음 턴 시작 시, 이번 턴에 잃은 HP만큼의 실타래드를 획득하며, [Layer]턴 동안 지속된다."
  },
  State_71741_Name = {
    Text = "레아·지원"
  },
  State_71741_WeaponDesc = {
    Text = "다음 턴 시작 시, 이전 턴에 잃은 HP와 동일한 양의 실타래드를 획득한다."
  },
  State_71742_Desc = {
    Text = "타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_71742_Name = {
    Text = "히로·지원"
  },
  State_71742_WeaponDesc = {
    Text = "이번 턴에 타격 카드의 피해가 [Layer]% 증가한다."
  },
  State_71837_Desc = {
    Text = "다음 턴 시작 시, 취약을 획득한다."
  },
  State_71837_Name = {
    Text = "지연 취약"
  },
  State_71839_Desc = {
    Text = "「깨어남」을 사용할 때, [Layer]의 행동력을 획득한다. 현재 계역이 「심해」일 경우, 추가로 임시 촉수 [Layer]개를 생성한다."
  },
  State_71839_Name = {
    Text = "별빛의 보호"
  },
  State_71856_Desc = {
    Text = "HP를 잃을 때마다 [StateArg1]의 임시 힘을 잃는다. [Layer]회 남아 있으며, 매 턴 발동 횟수가 초기화된다."
  },
  State_71856_Name = {
    Text = "신사 모자"
  },
  State_72016_Name = {
    Text = "혈육 정통"
  },
  State_72018_WeaponDesc = {
    Text = "피해를 1회 받을 때마다, 모든 깨어남체가 광기 1을 획득한다."
  },
  State_72033_Name = {Text = "촉수"},
  State_72036_Name = {
    Text = "혼돈 직업 초기화"
  },
  State_72079_Name = {Text = "노도"},
  State_72102_Desc = {
    Text = "클래식한 「모리멘스」 플레이 경험."
  },
  State_72102_Name = {Text = "망각편"},
  State_72137_Name = {
    Text = "행동력 가득"
  },
  State_72206_Name = {
    Text = "연구 진행도 「[DescArg1] / 15」"
  },
  State_72208_Name = {
    Text = "연구 진행도 「[DescArg1] / 2」"
  },
  State_72212_Name = {
    Text = "연구 진행도 「[DescArg1] / 10」"
  },
  State_72213_Name = {
    Text = "연구 진행도 「[DescArg1] / 30」"
  },
  State_72220_Name = {
    Text = "연구 진행도 「[DescArg1] / 5」"
  },
  State_73518_Desc = {
    Text = "주는 피해가 100% 증가하며, HP를 잃은 후 해당 상태는 해제되지만, 최대 HP의 50%만큼 실타래드를 획득한다."
  },
  State_73518_Name = {
    Text = "「암살자」"
  },
  State_73520_Desc = {
    Text = "사망 시, HP 1을 남기고 모든 피해를 면역하며, 의도를 「연결 해제」로 전환한다."
  },
  State_73520_Name = {
    Text = "「연결자」"
  },
  State_73533_Desc = {
    Text = "플레이어 턴 종료 시 더 이상 손패를 버리지 않는다. 전투 시작 시, 플레이어의 손패 상한을 8로 설정한다."
  },
  State_73533_Name = {
    Text = "군체 감응"
  },
  State_73535_Desc = {
    Text = "자신의 턴 내에서 받는 피해가 75% 감소한다. 힘 감소 시, 힘 스택의 50%만 감소한다."
  },
  State_73535_Name = {
    Text = "자체 보호"
  },
  State_73566_Desc = {
    Text = "비명령 카드를 1장 사용할 때마다, [Power:StateArg1]의 <PowerIconKeywords:힘>과 <Block:[Block:StateArg2]>의 실타래드를 획득한다."
  },
  State_73566_Name = {
    Text = "「통신자」"
  },
  State_73567_Desc = {
    Text = "비명령 카드를 1장 사용할 때마다, [Power:StateArg1]의 <PowerIconKeywords:힘>과 <Block:[Block:StateArg2]>의 실타래드를 획득한다."
  },
  State_73567_Name = {
    Text = "「통신자」"
  },
  State_73570_Desc = {
    Text = "비명령 카드를 1장 사용할 때마다, [Power:StateArg1]의 <PowerIconKeywords:힘>과 <Block:[Block:StateArg2]>의 실타래드를 획득한다."
  },
  State_73570_Name = {
    Text = "「통신자」"
  },
  State_73573_Desc = {
    Text = "비명령 카드를 1장 사용할 때마다, [Power:StateArg1]의 <PowerIconKeywords:힘>과 <Block:[Block:StateArg2]>의 실타래드를 획득한다."
  },
  State_73573_Name = {
    Text = "「통신자」"
  },
  State_73649_Desc = {
    Text = "팀 피해 강효가 [Layer]% 증가한다."
  },
  State_73649_Name = {
    Text = "허무 속으로 추락한 인형"
  },
  State_73655_Name = {
    Text = "유기 형태 식별자"
  },
  State_73664_Name = {
    Text = "장식품 유기 형태 효과"
  },
  State_73664_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 사용한 후, 이번 턴 내에서 자신의 실타래드와 치유 강효가 2배로 증가한다."
  },
  State_74012_Desc = {
    Text = "모든 적에게 최대 HP의 [StateArg1]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [DescArg1]). 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  State_74012_Name = {
    Text = "허무의 종말"
  },
  State_74013_Desc = {
    Text = "모든 적에게 최대 HP의 [StateArg1]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다. 이 피해는 자신의 최대 HP의 500% 미만이 될 수 없으며, 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  State_74013_Name = {
    Text = "허무의 종말"
  },
  State_74014_Desc = {
    Text = "모든 적에게 최대 HP의 [StateArg1]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(이 피해는 자신의 최대 HP의 500% 미만이 될 수 없습니다). HP 소모의 30%를 회복하며, 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  State_74014_Name = {
    Text = "허무의 종말"
  },
  State_74015_Desc = {
    Text = "모든 적에게 최대 HP의 [StateArg1]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다(최소 [DescArg1]). <Heal:[Heal:DescArg2]> HP를 회복하며, 사용 후 「융해·돌」의 특정 스킬이 「종말 형태」로 변경됩니다."
  },
  State_74015_Name = {
    Text = "허무의 종말"
  },
  State_74019_Desc = {
    Text = "모든 깨어남체가 주는 중독, 반격, 기본 피해가 [Layer]% 증가한다."
  },
  State_74019_Name = {
    Text = "광기 감염"
  },
  State_74142_Desc = {
    Text = "탐색 시작 후, 체질, 공격력, 방어력이 [StateArg1]% 증가한다."
  },
  State_74142_Name = {
    Text = "영혼 적성"
  },
  State_74219_Name = {
    Text = "사용 후 손으로 돌아옴"
  },
  State_74273_Desc = {
    Text = "혈쇄·히로가 능동 피해를 입힐 때, [StateArg1]%의 출혈을 부여하며, [Layer]턴 동안 지속된다."
  },
  State_74273_Name = {
    Text = "속박의 사슬"
  },
  State_74771_Desc = {
    Text = "1회의 광기 폭발을 발동하기 위해 필요한 광기 수치이다."
  },
  State_74771_Name = {
    Text = "광기 상한"
  },
  State_74788_Desc = {
    Text = "·존재의 역설: 탐색 시작 시, 죽음 저항의 75%가 최대 HP 보너스로 전환되며, 최대 300%의 죽음 저항을 전환하고 최대 10%의 최대 HP를 증가시킨다. 죽음 저항이 발동될 때마다 추가로 「은열쇠 미광」 1장을 손에 넣는다.\n\n·끝없는 상처: 보스전에서, 아군이 받는 HP 회복량이 HP 상한의 100%에 도달할 때마다 이후 받는 HP 회복 효과가 25% 감소하지만, 현재 죽음 저항 총량이 25% 증가한다. 최대 3회 발동된다.\n\n·프리즘 렌즈: 턴 시작 시, 반격이 HP 상한의 750%를 초과할 경우 초과된 스택을 절반으로 감소시키며, 영구 반격은 최대 HP 상한의 2250%까지 중첩된다. 적의 중독이 HP 상한의 1000%를 초과할 경우 초과된 스택을 절반으로 감소시키며, 중독은 최대 HP 상한의 3000%까지 중첩된다. 깨어남체가 반격으로 얻는 피해 보너스량이 70% 감소하지만, 주는 모든 중독과 반격이 10% 증가한다. 적 턴 시작 시, 영지 깨어남이 활성화된 깨어남체 1명당 현재 영구 반격의 25%만큼 임시 반격을 획득하고, 모든 적의 중독을 25% 발동시킨다.\n\n·운명의 광추: 일반 몬스터가 「응시」를 발동하는 턴 수가 6턴으로 변경된다. 모든 전투는 15턴의 제한을 가지며, 15턴 시작 시 「광추의 경계」 1장을 손에 넣는다. 해당 카드는 은열쇠 에너지를 최대치까지 획득하고, 모든 깨어남체의 광기를 최대치까지 채운다."
  },
  State_74788_Name = {
    Text = "(일시적 폐기)"
  },
  State_74791_Desc = {
    Text = "\n·행동력 조화: 한 턴 내에 사용한 카드가 명령 카드 10장에 도달하면, 명령 카드를 1장 사용할 때마다 「행동력 조화」 1스택을 획득합니다. 「행동력 조화」는 이번 턴 내 명령 카드를 사용할 때마다 행동력 소비+1이 되며, 이로 인해 소비된 추가 행동력 1점당 100% 각성체 은열쇠 충전의 은열쇠 에너지로 전환됩니다. 중첩 가능합니다. 초차원 공간 발동 후 행동력 조화 효과가 초기화됩니다.\n·행동력 과다: 카드 사용 후 해당 카드의 이번 턴 내 행동력 소비 감소 효과를 제거합니다. 전투 중 현재 행동력이 12를 초과하면, 초과된 행동력 1점당 자동으로 300% 팀 평균 은열쇠 충전의 은열쇠 에너지로 전환됩니다.\n·광기 조화: 광기 백분율 증가 효과가 절반으로 감소합니다. 각성체가 광기 폭발을 발동할 때마다 해당 각성체의 광기 최대치 +10. 턴 종료 시 광기 폭발을 발동하지 않은 각성체 1명당 200% 팀 평균 은열쇠 충전의 은열쇠 에너지를 획득합니다."
  },
  State_74791_Name = {
    Text = "열쇠 에너지 조화"
  },
  State_74809_Name = {
    Text = "「종말 형태」: 추가로 카드 3장 드로우, 행동력 3pt 획득, 모든 적에게 [DescArg1]% <IntoxicationIconKeywords:중독> 발동, 「융해·돌」의 광기 상한 50pt 증가 (최대 3회)"
  },
  State_74826_Name = {
    Text = "무작위로 <FixedDamage:순수 피해> [DescArg1]을 [DescArg2]회 입힙니다(이 피해는 힘 1배 계수를 적용받습니다)"
  },
  State_74827_Name = {
    Text = "이번 턴 모든 깨어남체의 치명타율 및 치명타 피해 [DescArg1]% 증가"
  },
  State_74828_Name = {
    Text = "전체 적에게 [DescArg1]pt 중독 부여"
  },
  State_74829_Name = {
    Text = "모든 적에게 HP 소모의 [DescArg1]%에 해당하는 <FixedDamage:순수 피해>를 입힙니다"
  },
  State_74830_Name = {
    Text = "힘 [DescArg1]pt 획득"
  },
  State_74831_Name = {
    Text = "모든 깨어남체가 [DescArg1]pt 광기 획득"
  },
  State_74847_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 매 턴 사용하는 첫 번째 명령 카드가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 해당 카드가 초차원 공간에 진입했다면, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다."
  },
  State_74847_WeaponDesc = {
    Text = "장착한 깨어남체가 매 턴 사용하는 첫 번째 명령 카드가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 해당 카드가 초차원 공간에 진입했다면, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다."
  },
  State_74879_Name = {
    Text = "[DescArg1]pt 행동력 획득"
  },
  State_74881_Name = {
    Text = "깨어남체 1명을 선택하여 광기 [DescArg1]pt 획득"
  },
  State_74882_Name = {
    Text = "영역 숙련 [DescArg1]pt 획득"
  },
  State_74883_Name = {
    Text = "다음 [DescArg1]장의 명령 카드가 추가로 열쇠 에너지 [DescArg2]pt 획득"
  },
  State_74884_Name = {
    Text = "이번 턴 중독, 반격, 출혈 [DescArg1]% 증가"
  },
  State_74885_Name = {
    Text = "모든 깨어남체가 광기 [DescArg1]pt 획득"
  },
  State_74887_Name = {
    Text = "실타래드 [DescArg1]pt 획득"
  },
  State_74888_Name = {
    Text = "[DescArg1]pt 죽음 저항 획득"
  },
  State_74889_Name = {
    Text = "[DescArg1]스택 반격 획득"
  },
  State_74890_Name = {
    Text = "모든 적에게서 임시 힘 [DescArg1]pt 탈취"
  },
  State_74891_Name = {
    Text = "무작위로 <FixedDamage:순수 피해> [DescArg1]을 [DescArg2]회 입힙니다(이 피해는 힘 1배 계수를 적용받습니다)"
  },
  State_74910_Desc = {
    Text = "팀 유니크: 장착자가 각성체 「라몬나」인 경우, 탐색 스테이지에서 획득하는 동조율이 <WeaponEffect_Num:[StateArg1]%> 증가합니다."
  },
  State_74910_WeaponDesc = {
    Text = "장착한 깨어남체가 깨어남체 「라모나」일 경우, 스테이지 완료 시 획득하는 동조율이 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_74932_Desc = {
    Text = "「타격」 카드, 「방어」 카드, 「스킬」 카드를 사용할 때 「금지된 거래」의 해당 효과가 업그레이드된다."
  },
  State_74932_Name = {
    Text = "금지된 거래"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 시작 시, <HPAndShieldMin:HP와 방어막가 가장 낮은> 적에게 [StateArg1] 스택의 행동 봉쇄를 부여합니다. 장착자가 처치 후, 즉시 이 효과를 한 번 발동합니다."
  },
  State_74947_Name = {
    Text = "마녀의 챙 넓은 모자"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후, 광기가 가장 높은 적이 [StateArg1]의 광기를 잃고 <PVPEmptinessKeywords:공허>를 획득한다."
  },
  State_74948_Name = {
    Text = "최면 진자"
  },
  State_76236_Desc = {
    Text = "\n·은열쇠 깨어남: 은열쇠 에너지가 가득 찰 때, 추가로 「银钥觉醒」을 선택하여 지정한 깨어남체의 영지 깨어남 카드를 손에 넣고 「보존」을 부여할 수 있으며, 이번 전투 동안 유효합니다. 「银钥觉醒」은 매 턴 1회만 발동할 수 있으며, 「은열쇠」와 독립적으로 쿨다운됩니다.\n·열쇠의 힘 과부하: 「银钥觉醒」 사용 시, 영지 깨어남이 해금된 깨어남체가 1개 있을 때마다 은열쇠 에너지를 추가로 1000 감소시키며, 이 효과로 인해 은열쇠 에너지가 음수가 될 수 있습니다.\n·기록 각인: 수호자가 은열쇠를 1개 보유할 때마다 「물상 연구」와 「영식 연구」를 1% 향상시키며, 최대 50%까지 향상됩니다. 모든 R 명륜의 효과가 장착자의 차원 영상 유물이 등장할 확률을 100% 높이는 것으로 변경됩니다."
  },
  State_76236_Name = {
    Text = "찬란한 은빛"
  },
  State_76277_Desc = {
    Text = "팀 유일: 보스전 시작 후, 최대 50의 검은 인장을 소모하며, 검은 인장 1pt를 소모할 때마다 <WeaponEffect_Num:[StateArg1]%>의 <DeathResistanceIconKeywords:죽음 저항>을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76277_WeaponDesc = {
    Text = "보스전 시작 후, 최대 50의 검은 인장을 소모하며, 검은 인장 1pt를 소모할 때마다 <WeaponEffect_Num:[StateArg1]%>의 <DeathResistanceIconKeywords:죽음 저항>을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76278_Desc = {
    Text = "팀 유일: 새로운 칸을 지날 때마다, 잃은 HP의 <WeaponEffect_Num:[StateArg1]%>를 회복한다. 응급 영지체 사용 후, 모든 깨어남체의 치명타율과 치명타 피해가 100% 증가한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76278_WeaponDesc = {
    Text = "새로운 칸을 지날 때마다, 잃은 HP의 [StateArg1]%([DescArg1])를 회복한다. 응급 영지체 사용 후, 모든 깨어남체의 치명타율과 치명타 피해가 100% 증가한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76279_Desc = {
    Text = "팀 유일: 융흔에서 깨어남체 깨어남 비용이 <WeaponEffect_Num:[StateArg1]>의 검은 인장만큼 감소한다. 장착한 깨어남체의 영지 깨어남이 고유를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76279_WeaponDesc = {
    Text = "융흔에서 깨어남체 깨어남 비용이 <WeaponEffect_Num:[StateArg1]>의 검은 인장만큼 감소한다. 장착한 깨어남체의 영지 깨어남이 고유를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76280_Desc = {
    Text = "팀 유일: 휴식처의 회복량이 <WeaponEffect_Num:[StateArg1]%> 증가하며, HP 회복을 선택한 후 「영감」 2장을 덱에 추가한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76280_WeaponDesc = {
    Text = "휴식처의 회복량이 <WeaponEffect_Num:[StateArg1]%> 증가하며, HP 회복을 선택한 후 「영감」 2장을 덱에 추가한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76281_Desc = {
    Text = "팀 유일: 전투 종료 후, 광기가 가장 낮은 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76281_WeaponDesc = {
    Text = "전투 종료 후, 광기가 가장 낮은 깨어남체가 <WeaponEffect_Num:[Energy:StateArg1]>의 광기를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76282_Desc = {
    Text = "팀 유일: 융흔 새로고침 횟수가 1 증가하며, 새로고침 비용이 <WeaponEffect_Num:[StateArg1]>의 검은 인장만큼 감소한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76282_WeaponDesc = {
    Text = "융흔 새로고침 횟수가 1 증가하며, 새로고침 비용이 <WeaponEffect_Num:[StateArg1]>의 검은 인장만큼 감소한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76283_Desc = {
    Text = "팀 유일: 융흔 유물 슬롯이 3개로 변경되며, 그중 하나는 저주 유물이다. 저주 유물 구매 후 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76283_WeaponDesc = {
    Text = "융흔 유물 슬롯이 3개로 변경되며, 그중 하나는 저주 유물이다. 저주 유물 구매 후 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76284_Desc = {
    Text = "팀 유일: 스테이지 시작 후, 모든 깨어남체가 <WeaponEffect_Num:[StateArg1]>의 광기를 획득한다. 보스전 시작 후, 카드 2장을 드로우한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76284_WeaponDesc = {
    Text = "스테이지 시작 후, 모든 깨어남체가 <WeaponEffect_Num:[Energy:StateArg1]>의 광기를 획득한다. 보스전 시작 후, 카드 2장을 드로우한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76285_Desc = {
    Text = "팀 유일: 스테이지 시작 후, <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 보스전 시작 후, 행동력 2를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76285_WeaponDesc = {
    Text = "스테이지 시작 후, <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 보스전 시작 후, 행동력 2를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76286_Desc = {
    Text = "팀 유일: 휴식처에서 추가 옵션이 제공된다: 최대 3장의 증상을 제거하고 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76286_WeaponDesc = {
    Text = "휴식처에서 추가 옵션이 제공된다: 최대 3장의 증상을 제거하고 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76287_Desc = {
    Text = "팀 유일: 일반 전투 종료 후 선택 가능한 각인 수가 4개로 증가하며, 장착한 깨어남체 카드의 각인이 <WeaponEffect_Num:[StateArg1]%> 확률로 고급 각인으로 업그레이드된다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76287_WeaponDesc = {
    Text = "일반 전투 종료 후 선택 가능한 각인 수가 4개로 증가하며, 장착한 깨어남체 카드의 각인이 <WeaponEffect_Num:[StateArg1]%> 확률로 고급 각인으로 업그레이드된다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76288_Desc = {
    Text = "팀 유일: 전투 종료 후, <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76288_WeaponDesc = {
    Text = "전투 종료 후, <WeaponEffect_Num:[StateArg1]>의 은열쇠 에너지를 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76289_Desc = {
    Text = "팀 유일: 탐색 중 시야가 1 증가하며, 지도 시야가 모두 열린 후 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 보스전 시작 시, 모든 적에게 1턴간 허약과 취약을 부여한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76289_WeaponDesc = {
    Text = "탐색 중 시야가 1 증가하며, 지도 시야가 모두 열린 후 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 보스전 시작 시, 모든 적에게 1턴간 허약과 취약을 부여한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76290_Desc = {
    Text = "팀 유일: 일반 전투 종료 후, 각인 포기를 선택할 수 있으며, 최대 HP가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 이 효과는 최대 2회 발동된다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76290_WeaponDesc = {
    Text = "일반 전투 종료 후, 각인 포기를 선택할 수 있으며, 최대 HP가 <WeaponEffect_Num:[DescArg1]> 증가한다. 이 효과는 최대 2회 발동된다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76291_Desc = {
    Text = "팀 유일: 스테이지 시작 후, <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 유물 상한이 2 증가한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76291_WeaponDesc = {
    Text = "스테이지 시작 후, <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 유물 상한이 2 증가한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76292_Desc = {
    Text = "팀 유일: 융흔 카드 판매처에서 증상 카드를 판매할 수 있으며, 증상 카드 판매 후 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76292_WeaponDesc = {
    Text = "융흔 카드 판매처에서 증상 카드를 판매할 수 있으며, 증상 카드 판매 후 <WeaponEffect_Num:[StateArg1]>의 검은 인장을 획득한다. 별의 시대 챕터에서는 효과가 「장착한 깨어남체의 차원 영상 유물 출현 확률이 100% 증가」로 변경된다."
  },
  State_76321_Name = {
    Text = "프리즘 렌즈"
  },
  State_76323_Name = {
    Text = "광기 조화"
  },
  State_76324_Name = {
    Text = "행동력 조화"
  },
  State_76325_Desc = {
    Text = "[DescArg1]장의 명령 카드를 사용한 후, 「행동력 조화」 상태로 진입한다."
  },
  State_76325_Name = {
    Text = "행동력 조화"
  },
  State_76326_Name = {
    Text = "존재의 역설"
  },
  State_76328_Name = {
    Text = "운명의 광추"
  },
  State_76337_Name = {
    Text = "끝없는 상처"
  },
  State_76338_Desc = {
    Text = "플레이어가 받는 치유량이 [Layer]% 감소한다."
  },
  State_76338_Name = {
    Text = "끝없는 상처"
  },
  State_76430_Name = {
    Text = "차원 영상 · 릴리"
  },
  State_76433_Name = {
    Text = "행동력 조화"
  },
  State_76434_Desc = {
    Text = "명령 카드를 사용할 때, 행동력 조화로 인해 추가로 행동력을 소모했다면, 깨어남체 은열쇠 충전량의 100%만큼 은열쇠 에너지를 추가로 획득한다. 중첩 가능."
  },
  State_76434_Name = {
    Text = "행동력 조화"
  },
  State_76435_Name = {
    Text = "프리즘 렌즈"
  },
  State_76528_Name = {
    Text = "이 카드는 「타격」으로 간주하기"
  },
  State_76529_Desc = {
    Text = "획득 시 깨어남체의 카드 1장을 선택하여 해당 카드의 행동력 소모를 1 감소시키고, 사용 후 카드 1장을 드로우하며, 해당 카드를 「타격」으로 간주한다."
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 종료 시, 상대의 무작위 손패 [StateArg1]장에 <PVPAcheKeywords:감춰진 고통> [StateArg2]스택을 부여한다."
  },
  State_76533_Name = {
    Text = "감춰진 고통"
  },
  State_76553_Desc = {
    Text = "이 카드의 행동력 소모가 [StateArg1] 감소한다."
  },
  State_76553_Name = {
    Text = "무수한 총애의 시선"
  },
  State_77686_Name = {
    Text = "반기계 형태"
  },
  State_77688_Desc = {
    Text = "다섯 번째 턴이 시작되거나 사망 직전일 때, 죽음을 면역하고 의도를 「기계 비상」으로 조정한다."
  },
  State_77688_Name = {
    Text = "연약한 육체"
  },
  State_77690_Desc = {
    Text = "「반기계 형태」로 전환한 후, 종말 1스택당 최대 HP의 10%를 추가로 획득한다. 「반기계 형태」에서 「융해·돌」는 종말 스택 증가에 따라 더 위협적인 스킬을 발동한다."
  },
  State_77690_Name = {Text = "종말"},
  State_77692_Desc = {
    Text = "턴 종료 시, 융식 몬스터 2개를 소환하며, 최대 2개까지 동시에 존재할 수 있다. 소환된 융식 몬스터가 사망하면, 「융해·돌」이 최대 HP의 5%를 잃는다."
  },
  State_77692_Name = {
    Text = "심연의 문"
  },
  State_77693_Desc = {
    Text = "사망 후 「융해·돌」이 최대 HP의 5%를 잃는다."
  },
  State_77693_Name = {Text = "용해"},
  State_78102_Desc = {
    Text = "주는 피해가 15% 감소하고, 받는 피해가 30% 증가한다. 전투 종료 시까지 지속된다."
  },
  State_78102_Name = {
    Text = "과주파수 마비"
  },
  State_78694_Desc = {
    Text = "전투 시작 시 [Arg1]의 힘을 획득한다. 턴 시작 시 영구 힘 [Arg2]pt당 [Arg3]의 임시 힘을 획득하며, 최대 [Arg4]의 임시 힘을 얻을 수 있다. 그리고 턴 종료 시 해당 유물로 획득한 임시 힘의 절반만큼 실타래드를 잃는다."
  },
  State_78696_Desc = {
    Text = "은열쇠 깨어남 사용 후 해당 깨어남체의 「스킬」 [Arg1]장을 소모하고, 소모가 부여된 복사본 [Arg2]장을 덱에 섞어 넣는다."
  },
  State_78697_Desc = {
    Text = "턴 시작 시, [Arg2]스택의 중독을 받으며, 초차원 공간의 빈 슬롯 1개당 [Arg1]의 힘을 획득한다."
  },
  State_78698_Desc = {
    Text = "행동력 상한이 [Arg1] 감소한다. 행동력 소모가 [Arg2] 이상인 카드를 1장 사용할 때마다 행동력 1을 획득하며, 매 턴 최대 [Arg3]회 발동된다."
  },
  State_78699_Desc = {
    Text = "드로우 후 추가로 [Arg1]장의 카드를 드로우하지만, [Arg2]장의 손패를 버려야 한다."
  },
  State_78700_Desc = {
    Text = "모든 깨어남체의 기본 피해가 [Arg1]% 증가하고, 덱 초기화 시 추가로 [Arg2]% 증가하지만, 「비틀거림」 1장을 손에 넣는다. 증가치는 최대 [Arg3]%까지이다."
  },
  State_78701_Desc = {
    Text = "턴 시작 시 [Arg1]개를 초과하는 영구 촉수가 있다면, [Arg2]개의 촉수를 잃고 [Arg3]개의 임시 촉수를 획득한다. 그렇지 않으면 [Arg4]개의 임시 촉수를 획득한다."
  },
  State_78702_Desc = {
    Text = "은열쇠 깨어남 후 [Arg1]의 은열쇠 에너지를 추가로 소모하여, 획득한 영지 깨어남 카드의 행동력 소모를 0으로 만든다. 사용 시 해당 깨어남체가 [Arg2]의 광기를 추가로 획득한다."
  },
  State_78703_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1]의 중독을 부여한다. 턴 시작 전 적의 중독 [Arg2]%를 제거하고, 제거량의 [Arg3]%만큼 출혈을 부여한다."
  },
  State_78710_Desc = {
    Text = "명령 카드를 1장 사용할 때마다, 해당 깨어남체가 이번 턴에 주는 최종 피해가 [Arg1]% 증가하지만, [Arg2]의 광기를 잃는다. 매 턴 최대 [Arg3]회 발동된다."
  },
  State_78712_Desc = {
    Text = "턴 시작 시 배아 융합도 + [Arg1], 당신의 배아는 턴 종료 시 폐기됩니다."
  },
  State_78713_Desc = {
    Text = "턴 시작 시 [Arg1]의 반격을 획득한다. 1턴 내에 광기 폭발을 [Arg2]회 발동한 후, 자신의 영구 반격 [Arg3]%를 제거하고, 제거량의 [Arg4]%만큼 임시 반격을 획득한다. [Arg5]턴 쿨다운."
  },
  State_78781_Desc = {
    Text = "대상의 힘을 임시로 감소시키고, 감소한 만큼의 임시 힘을 획득한다."
  },
  State_78781_Name = {
    Text = "<TouquKeywords:탈취>"
  },
  State_79405_Desc = {
    Text = "사용 후 「맑은 기억」이 1 증가하여 10에 도달하면 1턴 동안 잠그고 「영감」 3장을 획득하며, 다음 턴 시작 시 5로 초기화된다."
  },
  State_79405_Name = {
    Text = "진실타래된 과거"
  },
  State_79406_Desc = {
    Text = "사용 후 「맑은 기억」이 1 감소하고, 0에 도달하면 1턴 동안 잠그고 모든 깨어남체가 광기 30을 획득한다. 다음 턴 시작 시 5로 초기화된다."
  },
  State_79406_Name = {
    Text = "화려한 환몽"
  },
  State_80052_Desc = {Text = "테스트"},
  State_80052_Name = {
    Text = "테스트123"
  },
  State_80052_WeaponDesc = {Text = "테스트"},
  State_80161_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 광기 폭발 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 은열쇠 충전이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 초차원 턴에 진입한 후, 모든 깨어남체가 <WeaponEffect_Num:[StateArg4]>의 광기를 획득한다. 「소멸」을 발동한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_80161_WeaponDesc = {
    Text = "장착한 깨어남체의 광기 폭발 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 은열쇠 충전이 <WeaponEffect_Num:[DescArg1]> 증가한다. 초차원 턴에 진입한 후, 모든 깨어남체가 <WeaponEffect_Num:[StateArg4]>의 광기를 획득한다. 「소멸」을 발동한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_80174_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 은열쇠 충전이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 첫 번째 전투 시작 후, 모든 적에게 허약과 취약을 1스택 부여한다."
  },
  State_80174_WeaponDesc = {
    Text = "장착한 깨어남체의 은열쇠 충전이 <WeaponEffect_Num:[DescArg1]>pt 증가한다. 첫 번째 전투 시작 후, 모든 적에게 허약과 취약을 1스택 부여한다."
  },
  State_80207_Desc = {
    Text = "이 카드를 사용한 후 「차원 이동」이 발동되면 후속 효과를 발동하며, 초차원 공간에서 꺼낼 경우 행동력 소모가 1 감소한다."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:초거리>"
  },
  State_80328_Desc = {
    Text = "그녀의 감정, 인식, 그리고 모든 것이 군체 의식과 영원히 연결되어 있다. 최대 15스택까지 중첩된다. 「공감」은 클레멘타인의 광기 폭발 「생명체 재구성」에 의해 약화 효과로 전환될 수 있다."
  },
  State_80328_Name = {Text = "공감"},
  State_80331_Desc = {
    Text = "군집 침식 아래, 당신의 약점이 드러납니다. 이번 턴에 받는 주동 및 촉수 피해가 [DescArg1]% 증가합니다."
  },
  State_80331_Name = {
    Text = "<D13Colour:정신적 트라우마>"
  },
  State_80332_Desc = {
    Text = "그녀의 감정, 인식, 그리고 모든 것이 군체 의식과 영원히 연결되어 있으며, 최대 10스택까지 중첩된다. 「공감」은 클레멘타인의 광기 폭발 「생명체 재구성」에 의해 약화 효과로 전환될 수 있다."
  },
  State_80332_Name = {Text = "공감"},
  State_80335_Desc = {
    Text = "군집 침식 아래, 당신의 약점이 드러납니다. 이번 턴에 받는 주동 및 촉수 피해가 [DescArg1]% 증가합니다."
  },
  State_80335_Name = {
    Text = "<D13Colour:정신적 트라우마>"
  },
  State_80336_Desc = {
    Text = "군집 침식 아래, 당신의 공포는 숨길 수 없습니다. 이번 턴에 가하는 주동 및 촉수 피해가 [DescArg1]% 감소합니다."
  },
  State_80336_Name = {
    Text = "<D13Colour:공포 고착>"
  },
  State_80338_Desc = {
    Text = "군집 침식 아래, 당신의 공포는 숨길 수 없습니다. 이번 턴에 가하는 주동 및 촉수 피해가 [DescArg1]% 감소합니다."
  },
  State_80338_Name = {
    Text = "<D13Colour:공포 고착>"
  },
  State_80575_Desc = {
    Text = "능동 피해나 촉수 피해를 입은 후, 동일한 양의 「옛날 잔재」를 제거하고 제거량의 300%만큼 HP를 잃는다. 다른 피해를 입을 때는 절반만 제거한다. 「옛날 잔재」 스택은 매 턴 초기화된다."
  },
  State_80575_Name = {
    Text = "옛날 잔재"
  },
  State_80644_Name = {
    Text = "상태@초월의 빛 중"
  },
  State_80773_Desc = {
    Text = "힘 감소 효과를 받을 때, 힘 스택이 50%만 감소합니다. 자신의 턴 내에 받는 주동 및 촉수 피해 이외의 피해가 100% 증가합니다."
  },
  State_80773_Name = {
    Text = "이차원 항체"
  },
  State_80774_Desc = {
    Text = "능동 피해 또는 촉수 피해를 받은 후, 받은 피해량만큼 「옛날 잔재」를 제거하고 제거량의 300%만큼 HP를 잃는다. 기타 피해를 받을 때는 절반을 제거한다. 「옛날 잔재」 스택은 매 턴 초기화된다. 「옛날 잔재」가 모두 제거된 후, 「보강」 50스택을 획득한다."
  },
  State_80774_Name = {
    Text = "옛날 잔재"
  },
  State_80777_Desc = {
    Text = "전투 시작 시, 모든 깨어남체의 치명타율을 10% 감소시킨다. 사망 후, 다른 아군이 [DescArg1]의 힘과 [DescArg2]스택의 「옛날 잔재」를 획득한다."
  },
  State_80777_Name = {
    Text = "군체 공감 - 전승"
  },
  State_80778_Desc = {
    Text = "사망 후 다른 아군이 임시 <MadnessIconKeywords:발광> 1스택을 획득합니다."
  },
  State_80778_Name = {
    Text = "군체 공감 - 융합"
  },
  State_80782_Desc = {
    Text = "이번 전투에서 모든 깨어남체의 치명타율이 [Layer]% 감소한다."
  },
  State_80782_Name = {
    Text = "치명타율 감소"
  },
  State_80783_Desc = {
    Text = "턴 종료 시, <MadnessIconKeywords:발광> 1 스택을 획득합니다."
  },
  State_80783_Name = {
    Text = "동족 인연"
  },
  State_80784_Desc = {
    Text = "HP가 50% 미만이 되면, 「초변자」 1명을 후방에 소환한다. 매 전투 1회만 발동된다."
  },
  State_80784_Name = {
    Text = "군체 공감 - 분열"
  },
  State_80785_Desc = {
    Text = "힘이 감소할 때, 힘 스택의 50%만 감소합니다. 플레이어가 광기 폭발을 발동할 때마다 임시 <MadnessIconKeywords:발광> 1 스택을 획득합니다."
  },
  State_80785_Name = {
    Text = "군체 공감 - 이차원"
  },
  State_80788_Desc = {
    Text = "힘이 감소할 때, 힘 스택의 25%만 감소합니다. 플레이어가 광기 폭발을 발동할 때마다 임시 <MadnessIconKeywords:발광> 1 스택을 획득합니다."
  },
  State_80788_Name = {
    Text = "군체 공감 - 이차원"
  },
  State_80789_Desc = {
    Text = "받는 주동 및 촉수 피해가 100% 증가하며, 1턴간 지속됩니다."
  },
  State_80789_Name = {Text = "잠복"},
  State_80790_Desc = {
    Text = "변화 후, 우주 유능 1스택당 더욱 완벽해진다…"
  },
  State_80790_Name = {
    Text = "우주 유능"
  },
  State_80792_Desc = {
    Text = "플레이어가 광기 폭발을 발동할 때마다 임시 <MadnessIconKeywords:발광> 1스택을 획득합니다."
  },
  State_80792_Name = {
    Text = "군체 공감 - 이차원"
  },
  State_80794_Desc = {
    Text = "카드를 사용할 수 없으며, 턴 종료 시에도 손에 남아 있다."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:속박>"
  },
  State_80807_Desc = {
    Text = "5턴이 시작되거나 사망 직전일 때, 다른 모든 적을 제거하고 의도를 「변화의 순간」으로 전환한다."
  },
  State_80807_Name = {
    Text = "탈바꿈의 순간"
  },
  State_80809_Desc = {
    Text = "턴 종료 시, 손에 있는 허무 카드는 버려진다."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:공허>"
  },
  State_80810_Desc = {
    Text = "능동 피해나 촉수 피해를 입은 후, 동일한 양의 「옛날 잔재」를 제거하고 제거량의 300%만큼 HP를 잃는다. 다른 피해를 입을 때는 절반만 제거한다. 「옛날 잔재」 스택은 매 턴 초기화된다."
  },
  State_80810_Name = {
    Text = "옛날 잔재"
  },
  State_80827_Desc = {
    Text = "누적 15장의 카드를 사용할 때마다, 현재 의도를 「상처 강타」로 대체한다(현재 [Layer]장 남음)."
  },
  State_80827_Name = {
    Text = "분노의 처벌"
  },
  State_81022_WeaponDesc = {
    Text = "피해를 1회 받을 때마다, 모든 깨어남체가 광기 1을 획득한다."
  },
  State_81027_Desc = {
    Text = "이 카드의 소속은 「충족」이며, 행동력 소모가 1 감소하고, 사용 후 「소모」된다."
  },
  State_81027_Name = {
    Text = "생명 의식"
  },
  State_81054_Desc = {
    Text = "군집 침식 아래, 너의 공포는 숨을 곳이 없다. 스택당 이번 턴 능동 및 촉수 피해 3% 감소, 최대 15스택."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:두려움 고착>"
  },
  State_81055_Desc = {
    Text = "군집 침식 아래, 너의 공포는 숨을 곳이 없다. 스택당 이번 턴 받는 능동 및 촉수 피해 3% 증가, 최대 10스택."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:정신적 상처>"
  },
  State_81056_Desc = {
    Text = "군집 침식 아래, 너의 공포는 숨을 곳이 없다. 스택당 이번 턴 받는 능동 및 촉수 피해 3% 증가, 최대 15스택."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:정신적 상처>"
  },
  State_81057_Desc = {
    Text = "군집 침식 아래, 너의 공포는 숨을 곳이 없다. 스택당 이번 턴 능동 및 촉수 피해 3% 감소, 최대 10스택."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:두려움 고착>"
  },
  State_81058_Desc = {
    Text = "그녀의 감정, 인식, 그리고 모든 것이 군체 의식과 영원히 연결되어 있다. 「공감」은 클레멘타인의 광기 폭발 「생명체 재구성」에 의해 약화 효과로 전환될 수 있으며, 최대 15스택까지 중첩된다."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:공감>"
  },
  State_81059_Desc = {
    Text = "그녀의 감정, 인식, 그리고 모든 것이 군체 의식과 영원히 연결되어 있다. 「공감」은 클레멘타인의 광기 폭발 「생명체 재구성」에 의해 약화 효과로 전환될 수 있으며, 최대 10스택까지 중첩된다."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:공감>"
  },
  State_81073_Desc = {
    Text = "치명적 피해를 받은 후 즉시 모든 HP를 회복하고 임시 보강 80%를 획득하며, 「초변자」 1명을 후방에 소환한다. 2회 발동 가능하다."
  },
  State_81073_Name = {
    Text = "군체 공감 - 분열"
  },
  State_81278_Desc = {
    Text = "매 턴 최초로 열쇠 지령을 발동하면, 모든 깨어남체가 광기 10을 획득하지만, 열쇠 지령 소모가 영구적으로 10% 증가한다."
  },
  State_81278_Name = {
    Text = "은열쇠 억제"
  },
  State_81312_Desc = {
    Text = "치명적 피해를 받은 후, 모든 HP를 회복하고 임시 보강 50스택을 획득한다. [Layer]회 더 발동 가능하다."
  },
  State_81312_Name = {
    Text = "우주 윤회"
  },
  State_81331_Desc = {
    Text = "턴 시작 시, 깨어남체 1명을 선택하여, 해당 깨어남체의 모든 카드와 광기 폭발을 3턴간 봉인한다."
  },
  State_81331_Name = {
    Text = "의식 유폐"
  },
  State_81340_Desc = {
    Text = "이 카드는 봉인되어 사용할 수 없으며, [Layer]턴 후 봉인이 해제된다."
  },
  State_81340_Name = {
    Text = "<Seal1:카드 봉인>"
  },
  State_81341_Desc = {
    Text = "이 깨어남체의 광기 폭발은 봉인되어 사용할 수 없으며, [Layer]턴 후 봉인이 해제된다."
  },
  State_81341_Name = {
    Text = "<Seal1:광기의 봉인>"
  },
  State_81354_Desc = {
    Text = "사용 후 [DescArg1]의 피해를 받으며, 턴 종료 시까지 사용하지 않을 경우 소모된다."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:연소>"
  },
  State_81356_Desc = {
    Text = "카드를 연소시켜 사용하며, 사용 후 [DescArg1]의 피해를 받고, 턴 종료 시까지 손에 있을 경우 소모된다."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:연소>"
  },
  State_81356_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_83587_Desc = {
    Text = "「파도 출항」을 선택할 때 효과를 증가시킬 수 있으며, 상한은 10스택이다."
  },
  State_83587_Name = {
    Text = "「출항」"
  },
  State_83589_Desc = {
    Text = "「정박 휴식」을 선택할 때 효과를 증가시킬 수 있으며, 상한은 10스택이다."
  },
  State_83589_Name = {
    Text = "「정박」"
  },
  State_83593_Desc = {
    Text = "이번 턴 모든 깨어남체가 주는 최종 피해가 증가한다."
  },
  State_83593_Name = {
    Text = "최종 피해"
  },
  State_83596_Desc = {
    Text = "손패 상한이 1 증가한다. 턴 시작 시 덱에 「항해자의 선택」이 없을 경우, 이를 손에 넣는다. 보스가 최대 HP의 10%를 잃을 때마다 「출항」 1스택을 획득한다. 자신이 최대 HP의 10%를 잃을 때마다 「정박」 1스택을 획득한다."
  },
  State_83596_Name = {
    Text = "에라스모의 인도 - 「출항」"
  },
  State_83607_Desc = {
    Text = "보스 누적 HP 10% 손실타래 표식"
  },
  State_83607_Name = {
    Text = "상태@보스 누적 HP 10% 손실타래 표식"
  },
  State_83609_Desc = {
    Text = "플레이어 누적 HP 10% 손실타래 표식"
  },
  State_83609_Name = {
    Text = "상태@플레이어 10%의 HP 누적 손실타래 표식"
  },
  State_83614_Desc = {
    Text = "플레이어의 HP 10% 수치"
  },
  State_83614_Name = {
    Text = "상태@플레이어 HP 10%"
  },
  State_83615_Desc = {
    Text = "[Layer]의 HP를 잃은 후, 「출항」 1스택을 획득한다."
  },
  State_83615_Name = {
    Text = "「출항」 진행도"
  },
  State_83616_Desc = {
    Text = "[Layer]의 HP를 잃은 후, 「정박」 1스택을 획득한다."
  },
  State_83616_Name = {
    Text = "「정박」 진행도"
  },
  State_83617_Desc = {
    Text = "보스 HP 10% 수치"
  },
  State_83617_Name = {
    Text = "상태@보스 10%의 HP"
  },
  State_83618_Desc = {
    Text = "테스트 시 현재 HP는 [Layer]pt이다."
  },
  State_83618_Name = {
    Text = "적 현재 HP 카운터"
  },
  State_83619_Desc = {
    Text = "테스트 시 최대 HP는 [Layer]pt이다."
  },
  State_83619_Name = {
    Text = "적 최대 HP 카운터"
  },
  State_83620_Desc = {
    Text = "현재 파라미터 4의 값에 100을 곱하면 [Layer]pt이다."
  },
  State_83620_Name = {
    Text = "파라미터 출력"
  },
  State_83621_Desc = {
    Text = "보스 HP 10% 손실타래 카운트 중간값"
  },
  State_83621_Name = {
    Text = "상태@보스 HP 10% 손실타래 카운터 중간값"
  },
  State_83622_Desc = {
    Text = "플레이어 HP 10% 손실타래 카운트 중간값"
  },
  State_83622_Name = {
    Text = "상태@플레이어 HP 10% 손실타래 카운터 중간값"
  },
  State_83627_Desc = {
    Text = "[DescArg1]의 HP를 잃은 후, 「출항」 1스택을 획득한다."
  },
  State_83627_Name = {
    Text = "「출항」 진행도"
  },
  State_83805_Name = {Text = "여파"},
  State_83807_Name = {
    Text = "먼 바다에서의 침몰"
  },
  State_83808_Desc = {
    Text = "이 카드는 버려질 때 「여파」 효과가 발동된다."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:여파>"
  },
  State_83811_Desc = {
    Text = "추가로 [Layer]%의 촉수 피해를 받는다."
  },
  State_83812_Desc = {
    Text = "추가로 [Layer]%의 촉수 피해를 받는다."
  },
  State_83814_Desc = {
    Text = "보스 HP 10% 수치"
  },
  State_83814_Name = {
    Text = "보스 10%의 HP"
  },
  State_84140_Desc = {
    Text = "이번 전투에서 「소란스러운 바다」를 통해 [Layer]장의 「선체 분열」이 소모되었다."
  },
  State_84140_Name = {
    Text = "소란스러운 바다"
  },
  State_84184_Name = {
    Text = "이 스킬은 추가로 힘 보너스 [Layer]% 적용"
  },
  State_84255_Desc = {
    Text = "팀 유일: 전투 시작 시, 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg1]%>만큼의 실타래드를 획득한다. 죽음 저항이 발동된 후, 다음 턴 시작 시 이 효과가 다시 발동된다."
  },
  State_84255_Name = {
    Text = "바다의 길잡이"
  },
  State_84255_WeaponDesc = {
    Text = "전투 시작 시, <WeaponEffect_Num:[Block:DescArg1]>의 실타래드를 획득한다. 죽음 저항이 발동된 후, 다음 턴 시작 시 이 효과가 다시 발동된다."
  },
  State_84257_Desc = {
    Text = "팀 유일: 장착한 깨어남체의 광기 폭발이 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 광기 폭발 발동 후 모든 깨어남체의 임시 치명타 피해가 <WeaponEffect_Num:[StateArg2]%> 증가하고, 촉수 1개당 추가로 1% 증가한다. 각 탐색에서 최초로 죽음 저항이 발동된 후, 다음 턴 시작 시 최대 HP의 <WeaponEffect_Num:[StateArg3]%>를 회복한다."
  },
  State_84257_WeaponDesc = {
    Text = "장착한 깨어남체의 광기 폭발이 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 광기 폭발 발동 후 모든 깨어남체의 임시 치명타 피해가 <WeaponEffect_Num:[StateArg2]%> 증가하고, 촉수 1개당 추가로 1% 증가한다. 각 탐색에서 최초로 죽음 저항이 발동된 후, 다음 턴 시작 시 최대 HP의 <WeaponEffect_Num:[StateArg3]%>를 회복한다."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, HP 손실타래이 가장 많은 아군의 HP를 <Heal:[Heal:StateArg1]> 회복한다."
  },
  State_84272_Name = {
    Text = "바다의 항해자"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 시작 시, 자신에게 <PVPProtectiveKeywords:장벽>이 없으면 [StateArg1]스택의 <PVPProtectiveKeywords:장벽>을 획득하고, 그렇지 않으면 <Energy:[Energy:StateArg2]>의 광기를 획득한다."
  },
  State_84273_Name = {
    Text = "성화 속 인도"
  },
  State_84364_Desc = {
    Text = "치명타 피해가 [Layer]% 증가한다."
  },
  State_84364_Name = {
    Text = "치명타 피해"
  },
  State_84368_Desc = {
    Text = "남은 [Layer]턴 쿨다운."
  },
  State_84368_Name = {
    Text = "먼 바다에서의 침몰"
  },
  State_84375_Desc = {
    Text = "턴 시작 시, [Layer]pt의 실타래드를 획득한다."
  },
  State_84375_Name = {
    Text = "바다의 항해자"
  },
  State_84376_Desc = {
    Text = "턴 시작 시, [Layer]pt의 HP를 회복한다."
  },
  State_84376_Name = {
    Text = "성화 속 인도"
  },
  State_84399_Desc = {
    Text = "매 턴 종료 시 받는 피해가 5% 증가하며, 자신이 장벽 2스택을 획득한다."
  },
  State_84399_Name = {
    Text = "먼 바다에서의 침몰"
  },
  State_84400_Desc = {
    Text = "다음 턴 시작 시 장벽 1스택당 <ReinforcePVEKeywords:보강> 1스택으로 전환된다."
  },
  State_84400_Name = {
    Text = "「파일럿」"
  },
  State_84402_Desc = {
    Text = "받는 모든 피해가 [Layer]% 증가합니다."
  },
  State_84402_Name = {
    Text = "힘 과소비"
  },
  State_89340_Desc = {
    Text = "추가로 [Layer]%의 촉수 피해를 받는다."
  },
  State_89340_Name = {
    Text = "촉수 취약"
  },
  State_89422_Desc = {
    Text = "모든 깨어남체가 생성하는 광기가 100% 증가하며, 매 턴 광기 폭발을 2회 발동할 수 있다."
  },
  State_89422_Name = {
    Text = "「불굴의 마음」"
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:명륜>:패 상한 + [StateArg2]. 「광기 폭발」 후 [StateArg1] 계산력을 획득합니다."
  },
  State_89447_Name = {
    Text = "견딜 수 없는 자유"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:명륜>:턴 종료 시 생명과 방어막이 가장 낮은 아군이 [StateArg1] 장의 <PVPDerivativeCardKeywords_16:「흑우」>를 획득합니다."
  },
  State_89448_Name = {
    Text = "외로운 깃털"
  },
  State_89554_Name = {
    Text = "운명의 광추"
  },
  State_89555_Desc = {
    Text = "팀 유니크: 장착자가 광기 폭발을 해제한 후, 광기 폭발 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하고, 방어막과 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가하며, 최대 5회 중첩됩니다. 장착자가 탐색으로 획득하는 동조율이 <WeaponEffect_Num:[StateArg3]%> 증가합니다."
  },
  State_89555_WeaponDesc = {
    Text = "장착한 깨어남체가 광기 폭발을 발동한 후, 광기 폭발 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 실타래드와 HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 최대 5회 중첩된다. 탐색 완료 후, 장착한 깨어남체가 획득하는 동조율이 <WeaponEffect_Num:[StateArg3]%> 증가한다."
  },
  State_89557_Name = {
    Text = "프리즘 렌즈"
  },
  State_89559_Desc = {
    Text = "\n·존재의 역설: 탐색 시작 시, 죽음 저항의 75%가 최대 HP 보너스로 전환되며, 최대 300%의 죽음 저항을 전환하고, 최대 HP를 최대 10% 증가시킵니다. 죽음 저항이 발동될 때마다 추가로 「은열쇠의 미광」 1장을 손에 넣습니다.\n·깊은 상흔: 보스전에서, 아군이 받는 HP 회복량이 HP 상한의 100%에 도달할 때마다, 이후 받는 HP 회복 효과가 25% 감소하지만, 현재 죽음 저항 총량이 25% 증가합니다. 최대 3회 발동됩니다.\n·프리즘 렌즈: 턴 시작 시, 반격이 HP 상한의 2000%를 초과하면 초과분의 스택을 절반으로 줄이고, 영구 반격은 최대 HP 상한의 6000%까지만 중첩됩니다. 적의 중독이 HP 상한의 3000%를 초과하면 초과분의 스택을 절반으로 줄이고, 중독은 최대 HP 상한의 9000%까지 중첩됩니다. 깨어남체가 반격으로 얻는 데미지 보너스량이 70% 감소하지만, 가하는 모든 중독과 반격이 10% 증가합니다. 깨어남체를 깨어남시킬 때마다: 턴 종료 후 현재 영구 반격의 25%에 해당하는 임시 반격을 획득하고, 적 턴 종료 시 모든 적의 중독 25%를 추가로 발동합니다.\n·운명의 광추: 일반 몬스터가 「응시」를 발동하는 턴 수가 6턴으로 변경됩니다. 15턴 시작 시, 「광추의 경계」 1장을 손에 넣습니다: 은열쇠 에너지와 모든 깨어남체의 광기를 최대치로 채웁니다."
  },
  State_89559_Name = {
    Text = "시공 왜곡"
  },
  State_89567_Desc = {
    Text = "이 카드의 행동력 소모가 [StateArg1] 감소한다."
  },
  State_89567_Name = {
    Text = "폐허로부터의 부활"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착한 깨어남체가 사망한 후, 자신의 행동력 소모가 [StateArg1] 감소한 모든 「스킬」을 덱에 섞어 넣고, 소속자를 남은 HP가 가장 높은 아군으로 변경한다."
  },
  State_89568_Name = {
    Text = "폐허로부터의 부활"
  },
  State_89571_Name = {
    Text = "「불타는 극장」"
  },
  State_89572_Desc = {
    Text = "턴 시작 시, 상대의 무작위 손패 [DescArg1]장에 <BurningKeywords:연소>를 부여하고, [DescArg2]의 임시 힘을 획득한다. 2턴이 지날 때마다, 연소가 부여되는 카드 수가 1 증가하고, 획득하는 임시 힘이 [DescArg3] 증가한다."
  },
  State_89572_Name = {
    Text = "「불타는 극장」"
  },
  State_89626_Desc = {
    Text = "은열쇠 깨어남 사용 후, 「은열쇠 미광」 1장을 손에 넣는다. 모든 깨어남체의 깨어남이 완료된 후, 매 턴 시작 시 무작위 깨어남체의 지원 1장을 발견한다."
  },
  State_89631_Desc = {
    Text = "추가 도약 [Layer]회"
  },
  State_89634_Desc = {
    Text = "영지 깨어남4"
  },
  State_89634_Name = {
    Text = "영지 깨어남 4"
  },
  State_89637_Desc = {
    Text = "매 턴 첫 번째 명령 카드가 추가로 1회 발동한다. 소멸 시 촉수 1개를 생성한다. 촉수 자세를 「노도」로 전환한 후, 이번 턴에 다음 2장의 명령 카드 도약 효과가 반드시 발동하며 초차원 공간으로 들어간다. 3턴 쿨다운."
  },
  State_89640_Desc = {
    Text = "영역 숙련이 200 증가한다. 핏빛 용광로를 소모할 때, 소모량의 15%만큼 촉수 피해가 증가한다. 촉수가 공격할 때마다 [Arg3]의 핏빛 용광로를 적립한다."
  },
  State_89642_Desc = {
    Text = "손패 상한이 2 증가하며, 광기 폭발 발동 후 임시 최종 피해가 10% 증가한다. 카드가 초차원 공간에 들어간 후, 손에 있는 「배아」 1개가 「성결의 자식」으로 변환된다. 「배아」를 1개 생성할 때마다, 초차원 공간의 무작위 카드 1장의 행동력 소모가 1 감소한다."
  },
  State_89669_Desc = {
    Text = "은열쇠 깨어남4"
  },
  State_89669_Name = {
    Text = "은열쇠 깨어남 4"
  },
  State_89759_Desc = {
    Text = "열쇠 지령 발동 후, 라모나가 임시 치명타율 50%를 획득한다."
  },
  State_89759_Name = {
    Text = "소중한 인연"
  },
  State_90023_Name = {
    Text = "상수 표 구성에 사용되는 상태, 일시적으로 폐기됨"
  },
  State_90059_Desc = {
    Text = "이번 턴에 능동 또는 촉수 피해를 받을 때, 받은 피해량만큼 침식을 제거하고 제거량의 [DescArg1]%만큼 HP를 잃는다. 기타 피해를 받을 때는 피해량의 50%만큼 침식을 제거한다."
  },
  State_90059_Name = {Text = "부식"},
  State_90094_Name = {
    Text = "검은 깃털"
  },
  State_90218_Desc = {
    Text = "팀 유일: 손패 상한이 2 증가하며, 동일한 효과는 중첩되지 않는다. 장착한 깨어남체가 주는 실타래드와 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 초차원 턴에 진입한 후 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다. 「소멸」을 발동한 후 모든 깨어남체의 임시 치명타 피해가 <WeaponEffect_Num:[StateArg3]%> 증가한다. 3턴 쿨다운."
  },
  State_90218_WeaponDesc = {
    Text = "손패 상한이 2 증가하며, 동일한 효과는 중첩되지 않는다. 장착한 깨어남체가 주는 실타래드와 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 초차원 턴에 진입한 후 <WeaponEffect_Num:[StateArg2]>의 광기를 획득한다. 「소멸」을 발동한 후 모든 깨어남체의 임시 치명타 피해가 <WeaponEffect_Num:[StateArg3]%> 증가한다. 3턴 쿨다운."
  },
  State_90221_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 턴 종료 시 장착한 깨어남체의 방어력 <WeaponEffect_Num:[StateArg2]%>만큼의 실타래드를 획득한다. 매 턴 방어력이 2%씩 증가한다."
  },
  State_90221_Name = {
    Text = "고독한 깃털"
  },
  State_90221_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 턴 종료 시 <WeaponEffect_Num:[Block:DescArg1]>의 실타래드를 획득한다."
  },
  State_90294_Desc = {
    Text = "이번 턴에 능동 또는 촉수 피해를 받을 때, 받은 피해량만큼 침식을 제거하고 제거량의 [DescArg1]%만큼 HP를 잃는다. 기타 피해를 받을 때는 피해량의 50%만큼 침식을 제거한다."
  },
  State_90294_Name = {
    Text = "<Corrosion:침식>"
  },
  State_90591_Name = {
    Text = "「영감」 [Layer]장을 손에 넣기"
  },
  State_90594_Name = {
    Text = "및 임시 경계 [Layer]pt 획득"
  },
  State_90599_Name = {
    Text = "모든 깨어남체가 광기 [Layer]pt 획득"
  },
  State_90600_Name = {
    Text = "은열쇠 에너지 [Layer]pt 획득"
  },
  State_90601_Name = {
    Text = "(<harmonyKeyWord:「조화」> 남은 횟수 [DescArg1]회)"
  },
  State_90603_Name = {
    Text = "임시 힘 [Layer]pt 획득"
  },
  State_90604_Name = {
    Text = "잃은 HP에 비례하여 HP [Layer]pt 회복"
  },
  State_90696_Desc = {
    Text = "사용 전에 「조미료」 1개를 발견하여 넣고 그 효과를 발동하며, 보스전에서 조화 횟수가 1회 증가한다."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:조화>"
  },
  State_91106_Desc = {
    Text = "광란 1스택당 주는 능동 피해와 촉수 피해에 피해량의 10%만큼 <BleedingIconKeywords:출혈>이 추가로 부여된다."
  },
  State_91106_Name = {Text = "열광"},
  State_91165_Name = {
    Text = "창백한 알"
  },
  State_91235_Desc = {
    Text = "HP를 잃을 때 동일한 수만큼 스택이 감소하며, 부상 스택이 0이 되면 모든 각성체가 광기 10을 획득하고 부상 스택이 초기화됩니다."
  },
  State_91235_Name = {Text = "부상"},
  State_91236_Name = {
    Text = "로마 활동 보스 체력 카운터 적용"
  },
  State_91329_Desc = {
    Text = "이 카드의 행동력 소모가 [StateArg1] 감소한다."
  },
  State_91329_Name = {Text = "진미"},
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 턴 종료 시, <PVPDerivativeCardKeywords_17:「영감」> [StateArg1]장을 손에 넣는다."
  },
  State_91521_Name = {
    Text = "파트너 특훈"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장착 시 및 턴 종료 시, 장착한 깨어남체가 후열 적에게 <Damage:[Damage:StateArg1]>의 피해를 준다."
  },
  State_91522_Name = {Text = "개강일"},
  State_91676_Desc = {
    Text = "구체적인 효과는 일반 타격 로직을 참조한다.「개발 전용」"
  },
  State_91706_Desc = {
    Text = "다음 턴 시작 시 스택 수만큼의 행동력을 획득한다."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:행동력 유지>"
  },
  State_91717_Desc = {
    Text = "최대 3구까지 쌓을 수 있으며, 상한에 도달한 후 다음 「생령의 성찬」으로 이를 먹고 효과를 강화할 수 있습니다. 잔해는 다음 전투로 이어집니다."
  },
  State_91717_Name = {Text = "잔해"},
  State_91759_Desc = {
    Text = "검은 깃털은 「성자·검은 깃털」의 능력을 강화할 수 있다."
  },
  State_91759_Name = {
    Text = "검은 깃털"
  },
  State_91761_Desc = {
    Text = "「성자·검은 깃털」의 파괴되지 않은 실타래드의 50%는 다음 턴까지 유지되며, 턴 종료 후 <Guaiwuheiyu:검은 깃털> 1스택을 획득한다."
  },
  State_91761_Name = {
    Text = "비상하는 숙원"
  },
  State_91797_Desc = {
    Text = "이 카드는 사용 후 및 버려진 후 전방 적에게 스택 수만큼의 실타래드를 부여한다."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:감춰진 고통>"
  },
  State_91799_Desc = {
    Text = "이 카드를 사용하면 전방 적에게 [Layer]의 실타래드를 부여한다."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:감춰진 고통 [Layer]>"
  },
  State_91809_Desc = {
    Text = "이 카드의 행동력 소모가 [Layer] 감소한다."
  },
  State_91809_Name = {
    Text = "정신 집중"
  },
  State_91819_Desc = {
    Text = "전투의 현재 턴 수에 따라 해당 변화를 얻습니다."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:성장>"
  },
  State_91827_Desc = {
    Text = "「타격」이 대상을 선택할 수 있으며, 「타격」 전에 대상의 해제 가능한 모든 긍정 상태를 그 뒤의 깨어남체에게 밀쳐낸다."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:심해의 부름>"
  },
  State_94410_Name = {
    Text = "매 턴 시작 및 행동 종료 시 빈 플레이어 덱을 리셋하려고 시도하며, 비어 있지 않으면 리셋하지 않는다.「개발 전용」"
  },
  State_94411_Name = {
    Text = "매 턴 시작 및 행동 종료 시 빈 플레이어 덱을 리셋하려고 시도하며, 비어 있지 않으면 리셋하지 않는다.「개발 전용」"
  },
  State_94426_Name = {
    Text = "수동 실타래드__[개발 전용]"
  },
  State_94540_Desc = {
    Text = "대상 뒤에 다른 깨어남체가 없을 경우, 대상의 긍정 상태를 해제한다."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:긍정 상태 밀쳐내기>"
  },
  State_94600_Desc = {
    Text = "치명적 피해를 받은 후 1스택을 제거하고 최대 HP의 5%를 회복한다. 이번 턴 내에 발동될 때마다 회복량이 1%씩 증가한다."
  },
  State_94600_Name = {
    Text = "죽음 저항"
  },
  State_94603_Name = {
    Text = "구울 표식"
  },
  State_94608_Name = {
    Text = "죽음 저항 발동 횟수"
  },
  State_94623_Desc = {
    Text = "광란 1스택당 주는 능동 피해와 촉수 피해에 피해량의 10%만큼 <BleedingIconKeywords:출혈>이 추가로 부여된다."
  },
  State_94623_Name = {
    Text = "<Kuangre:열광>"
  },
  State_94657_Desc = {
    Text = "적을 처치하거나 적의 부활 효과가 발동될 때, 해당 효과가 발동된다."
  },
  State_94657_Name = {
    Text = "<KillKeywords:격파>"
  },
  State_94692_Desc = {
    Text = "치명적 피해를 받은 후 1스택을 제거하고 최대 HP의 5%를 회복한다. 이번 턴 내에 발동될 때마다 회복량이 1%씩 증가한다."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang:죽음 저항>"
  },
  State_94693_Desc = {
    Text = "턴 시작 시, 다른 아군이 존재할 경우 [DescArg1]의 HP를 잃고, HP가 가장 높은 아군에게 <Guaiwusiwangdikang:죽음 저항> 1스택과 [DescArg2]의 <PowerIconKeywords:힘>을 부여한다."
  },
  State_94693_Name = {
    Text = "부패 시체의 분할"
  },
  State_94708_Desc = {
    Text = "턴 시작 시, 다른 아군이 존재할 경우 [DescArg1]의 HP를 잃고, HP가 가장 높은 아군에게 <Guaiwusiwangdikang:죽음 저항> 1스택과 [DescArg2]의 <Duren:독날>을 부여한다."
  },
  State_94708_Name = {
    Text = "심해의 분할"
  },
  State_94730_Desc = {
    Text = "방어되지 않은 능동 피해를 입혔을 때, [Layer]의 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  State_94730_Name = {Text = "독검"},
  State_94993_Desc = {
    Text = "매 턴마다 경천노도 횟수를 초기화한다."
  },
  State_94993_Name = {
    Text = "노도 횟수 초기화"
  },
  State_94994_Desc = {
    Text = "스택당 공격 횟수가 1 증가하며, 치명타 피해를 받을 때 1스택을 잃는다. 최소 1스택, 턴 종료 시 모든 스택을 잃는다."
  },
  State_94994_Name = {
    Text = "노도 횟수"
  },
  State_94995_Desc = {
    Text = "매번 치명타 피해를 받을 때마다 3%의 <Baojidikang:임시 치명타 저항>을 획득합니다. 매번 피해를 줄 때마다 1장의 랜덤 카드에「심잠 인장」을 추가합니다."
  },
  State_94995_Name = {
    Text = "심해 제사"
  },
  State_94996_Desc = {
    Text = "공격을 받을 때, 스택 수만큼의 임시 힘을 획득한다."
  },
  State_94996_Name = {Text = "광폭"},
  State_94997_Desc = {
    Text = "매번 치명타 피해를 받을 때마다 5%의 <Baojidikang:임시 치명타 저항>을 획득합니다. 매번 피해를 줄 때마다 1장의 랜덤 카드에「심잠 인장」을 추가합니다."
  },
  State_94997_Name = {
    Text = "심해 제사"
  },
  State_94998_Desc = {
    Text = "<Guaiwusiwangdikang:죽음 저항>이 발동될 때, 드로우 덱 또는 손패의 무작위 카드 1장에 <SlowIconKeywords:둔화>를 부여한다."
  },
  State_94998_Name = {
    Text = "절망의 화신"
  },
  State_94999_Desc = {
    Text = "매 턴마다 식천거랑 횟수를 초기화한다."
  },
  State_94999_Name = {
    Text = "하늘을 삼키는 파도 횟수 초기화"
  },
  State_95000_Desc = {
    Text = "부정 상태에 면역이다."
  },
  State_95000_Name = {
    Text = "부정 상태 면역"
  },
  State_95001_Desc = {
    Text = "스택당 공격 횟수가 1 증가하며, 치명타 피해를 받을 때 1스택을 잃는다. 최소 1스택, 턴 종료 시 모든 스택을 잃는다."
  },
  State_95001_Name = {
    Text = "하늘을 삼키는 파도 횟수"
  },
  State_95002_Desc = {
    Text = "이번 턴 내에 치명타를 받을 확률이 [Layer]% 감소한다."
  },
  State_95002_Name = {
    Text = "임시 치명타 저항"
  },
  State_95002_WeaponDesc = {
    Text = "이번 턴 내에 치명타를 받을 확률이 [Layer]% 감소한다."
  },
  State_95035_Desc = {
    Text = "방어되지 않은 능동 피해를 입혔을 때, 스택 1당 1의 <IntoxicationIconKeywords:중독>을 부여한다."
  },
  State_95035_Name = {
    Text = "<Duren:독검>"
  },
  State_95038_Desc = {
    Text = "공격을 받을 때, 스택 수만큼의 임시 힘을 획득한다."
  },
  State_95038_Name = {
    Text = "<Kuangbao:광폭>"
  },
  State_95040_Desc = {
    Text = "잃은 HP를 기록한다."
  },
  State_95040_Name = {
    Text = "잃은 HP 기록"
  },
  State_95932_Name = {
    Text = "구울 흡수 대기"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 [StateArg1]장의 카드를 뽑으며, 자신의 「스킬」을 우선적으로 뽑고, 그 스킬의 행동력 소모를 [StateArg2] 감소시킨다."
  },
  State_95937_Name = {Text = "진미"},
  State_95938_Desc = {
    Text = "카드를 1장 제거할 때마다, 포만감 스택이 1 증가한다. 최대 10스택."
  },
  State_95938_Name = {Text = "포만감"},
  State_95943_Desc = {
    Text = "주는 피해가 임시로 30% 감소한다."
  },
  State_95943_Name = {
    Text = "정면 교란"
  },
  State_95944_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 처치를 1회 달성할 때마다 장착한 깨어남체의 이번 탐색 내 치명타율이 2% 증가하며, 광기 폭발이 주는 기본 피해가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 최대 10회 중첩된다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체에게 「배아」를 직접 사용할 때 추가로 <WeaponEffect_Num:[StateArg4]>의 광기를 획득한다. 3턴 쿨다운."
  },
  State_95944_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 처치를 1회 달성할 때마다 장착한 깨어남체의 이번 탐색 내 치명타율이 2% 증가하며, 광기 폭발이 주는 기본 피해가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 최대 10회 중첩된다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체에게 「배아」를 직접 사용할 때 추가로 <WeaponEffect_Num:[StateArg4]>의 광기를 획득한다. 3턴 쿨다운."
  },
  State_95948_Name = {
    Text = "구울 흡수"
  },
  State_95949_Desc = {
    Text = "사용 후 듀레세인이 <Guaiwucanhai:잔해>의 절반을 잃는다."
  },
  State_95949_Name = {
    Text = "기습 비축"
  },
  State_95953_Desc = {
    Text = "죽음 저항의 HP 회복 효과가 5배로 증가한다."
  },
  State_95953_Name = {
    Text = "속삭임의 장막"
  },
  State_95954_Name = {
    Text = "구울 흡수 깨어남판"
  },
  State_95960_Desc = {
    Text = "잔해 수량은 「잔해 수집」의 효과를 증가시킨다."
  },
  State_95960_Name = {Text = "잔해"},
  State_95962_Name = {
    Text = "처치 수__[개발 전용]"
  },
  State_95964_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체가 적을 처치할 때 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg2]%>만큼 핏빛 용광로를 적립한다."
  },
  State_95964_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 현재 계역이 「혈육」일 경우, 장착한 깨어남체가 적을 처치할 때 <WeaponEffect_Num:[DescArg1]>의 핏빛 용광로를 적립한다."
  },
  State_95966_Desc = {
    Text = "다음 턴 시작 시, [Layer]장의 해당 깨어남체 카드를 드로우한다."
  },
  State_95966_Name = {
    Text = "잔혹한 인사"
  },
  State_95967_Desc = {
    Text = "잔해 수량은 「잔해 수집」의 효과를 증가시킨다."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:잔해>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 장비 시 <StrongEffectKeywords:증폭 효과>를 [StateArg1] 획득한다. 적 처치 시 넘치는 피해는 후방의 깨어남체에게 전달된다."
  },
  State_95968_Name = {
    Text = "안식의 입맞춤"
  },
  State_96167_Desc = {
    Text = "해체할 수 없으며, 소환된 몸체가 처치된 후, 다른 아군은 [StateArg1] <StrongEffectKeywords:증폭>을 얻습니다."
  },
  State_96167_Name = {
    Text = "검은 별의 불타는 재"
  },
  State_96183_Desc = {
    Text = "턴 종료 시, 필드에 다른 아군이 없으면 의도를 자폭으로 전환한다."
  },
  State_96183_Name = {
    Text = "구울 자폭"
  },
  State_96193_Name = {
    Text = "식전 예절"
  },
  State_96330_Desc = {
    Text = "자신의 HP가 1% 잃을 때마다, 듀레세인의 명령 카드가 주는 기본 피해, 실타래드, 광기가 1% 증가한다."
  },
  State_96330_Name = {
    Text = "유령의 속삭임"
  },
  State_96352_Name = {
    Text = "최초의 구울 카운터"
  },
  State_96354_Name = {
    Text = "시작 최대 HP"
  },
  State_96355_Desc = {
    Text = "치명타를 받을 확률이 [Layer]% 감소한다."
  },
  State_96355_Name = {
    Text = "치명타 저항"
  },
  State_96355_WeaponDesc = {
    Text = "이번 전투 내에서 치명타를 받을 확률이 [Layer]% 감소한다."
  },
  State_96356_Desc = {
    Text = "매 [DescArg1] 점의 생명을 잃을 때마다 [DescArg2] 층의<ReinforcePVEKeywords:보강>을 얻으며, 최대 [DescArg3] 층입니다.「<Guaiwusiwangdikang:죽음 저항>」이 발동되면 자신의 최대 생명이 [DescArg4]% 증가합니다."
  },
  State_96356_Name = {
    Text = "일레나의 보호"
  },
  State_96357_Desc = {
    Text = "턴 종료 후, 스택 수만큼의 힘을 획득한다."
  },
  State_96357_Name = {
    Text = "<Fennu: 분노>"
  },
  State_96358_Desc = {
    Text = "치명타를 받을 확률이 [Layer]% 감소한다."
  },
  State_96358_Name = {
    Text = "<Baojidikang:치명타 저항>"
  },
  State_96412_Name = {
    Text = "폭식자의 감청"
  },
  State_96416_Desc = {
    Text = "치명타를 받을 확률이 [Layer]% 감소한다."
  },
  State_96416_Name = {
    Text = "치명타 저항"
  },
  State_96603_Name = {
    Text = "이번 턴에 사용하지 않을 경우, 다음 턴 시작 시 「조화」 효과 1회 발동"
  },
  State_96610_Name = {
    Text = "최초 죽음 저항"
  },
  State_96613_Name = {
    Text = "파도의 감청"
  },
  State_96650_Desc = {
    Text = "스택당 모든 깨어남체의 치명타율이 [DescArg1]% 증가한다."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:심연의 불꽃>"
  },
  State_96719_Desc = {
    Text = "이번 턴에 <BurningKeywords:연소>가 부여된 카드를 사용할 때, <Heat:심연의 불꽃> 1스택을 소모하여 해당 카드가 2회 발동하며, 턴 종료 시 <Heat:심연의 불꽃>을 모두 초기화한다."
  },
  State_96719_Name = {
    Text = "끝없는 폭염"
  },
  State_96731_Desc = {
    Text = "이번 턴에 <BurningKeywords:연소>가 부여된 카드를 사용할 때, <Heat:심연의 불꽃> 1스택을 소모하여 해당 카드가 2회 발동하며, 턴 종료 시 <Heat:심연의 불꽃>을 모두 초기화한다."
  },
  State_96731_Name = {
    Text = "<Overload:끝없는 폭염>"
  },
  State_96732_Desc = {
    Text = "스택당 모든 깨어남체의 치명타율이 [DescArg1]% 증가한다."
  },
  State_96732_Name = {
    Text = "<Heat:심연의 불꽃>"
  },
  State_96740_Desc = {
    Text = "받는 능동 공격 피해와 출혈 스택이 50% 증가하며, 피해를 받거나 턴 시작 시 제거된다."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:허점>"
  },
  State_96741_Desc = {
    Text = "사용 후 남은 행동력이 [StateArg1]보다 클 경우, 추가로 [StateArg1]의 행동력을 소모하여 후속 효과를 발동한다.「개발 전용」"
  },
  State_96741_Name = {
    Text = "<CardKeyWord:행동력 과부하>__「개발 전용」"
  },
  State_96742_Name = {
    Text = "행동력 과부하 트리거 마크__「개발 전용」"
  },
  State_96743_Desc = {
    Text = "사용 후 남은 행동력이 행동력 과부하에 필요한 행동력보다 클 경우, 추가로 행동력을 소모하여 후속 효과를 발동한다."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:행동력 과부하>"
  },
  State_96744_Desc = {
    Text = "받는 능동 공격 피해와 출혈 스택이 50% 증가하며, 피해를 받거나 턴 시작 시 제거된다."
  },
  State_96744_Name = {Text = "약점"},
  State_96774_Desc = {
    Text = "치명타 피해를 받을 때마다 임시 치명타 저항이 3% 증가한다."
  },
  State_96774_Name = {
    Text = "심해 원령"
  },
  State_96780_Desc = {
    Text = "카드가 유지를 획득하지만, 사용하거나 버릴 경우 오염이 제거되고 「심해 분열체」 1개를 소환한다. 최대 2개까지 소환할 수 있다. 소환할 자리가 없으면 즉시 부조의 괴뢰가 [DescArg1]의 힘과 [DescArg2]의 HP를 획득한다."
  },
  State_96780_Name = {
    Text = "<Kuangluan:도해자의 광란>"
  },
  State_96783_Desc = {
    Text = "매 라운드 2장의 카드에「<Kuangluan:바다를 건너는 자의 광란>」을 추가합니다."
  },
  State_96783_Name = {
    Text = "도해자의 제의"
  },
  State_96784_Desc = {
    Text = "부조의 괴뢰의 공세를 최대 5스택까지 감소시킬 수 있다."
  },
  State_96784_Name = {Text = "혼란"},
  State_96808_Desc = {
    Text = "[DescArg1]의 HP를 잃을 때마다 <ReinforcePVEKeywords:보강> 15스택을 획득하며, 상한은 75스택이다. 보강이 파괴되면 초기화되고 <Chaos:혼란> 1스택을 획득한다. 만약 「골혈 재구성」을 발동한 적이 없다면, 치명적 피해를 받은 후 의도를 「골혈 재구성」으로 전환하고 모든 피해를 면역한다."
  },
  State_96808_Name = {
    Text = "「함체의 꼭두각시」"
  },
  State_96809_Name = {
    Text = "함체의 꼭두각시 카운터"
  },
  State_96810_Desc = {
    Text = "주는 피해가 25% 감소한다."
  },
  State_96810_Name = {
    Text = "속삭임의 장막"
  },
  State_96813_Name = {
    Text = "재구성 표식"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「타격」으로 [StateArg1]의 행동력을 획득하며, 「스킬」의 피해가 [StateArg2]% 증가한다."
  },
  State_97114_Name = {
    Text = "다가오는 태양"
  },
  State_97118_Name = {
    Text = "함체의 꼭두각시 격파"
  },
  State_97119_Desc = {
    Text = "카드가 유지를 획득하지만, 사용하거나 버릴 경우 오염이 제거되고 「심해 분열체」 1개를 소환한다. 최대 2개까지 소환할 수 있다. 소환할 자리가 없으면 즉시 부조의 괴뢰가 [DescArg1]의 힘과 [DescArg2]의 HP를 획득한다."
  },
  State_97119_Name = {
    Text = "<Kuangluan:도해자의 광란>"
  },
  State_97120_Desc = {
    Text = "법진의 보호를 받아 모든 적이 주는 피해가 25% 감소한다."
  },
  State_97120_Name = {
    Text = "속삭임의 장막"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「스킬」이 소모하는 행동력 1당 피해량 증가 [StateArg1]%. 처치 후 「광기 폭발」 피해량 증가 [StateArg2]%, 현재 보너스 [DescArg1]%."
  },
  State_97131_Name = {
    Text = "호박색 죽음"
  },
  State_97134_Desc = {
    Text = "주는 최종 피해가 50% 증가한다."
  },
  State_97134_Name = {
    Text = "셀레네의 노래"
  },
  State_97135_Desc = {
    Text = "주는 최종 피해가 25% 증가한다."
  },
  State_97135_Name = {
    Text = "셀레네의 속삭임"
  },
  State_97136_Desc = {
    Text = "주는 최종 피해가 100% 증가한다."
  },
  State_97136_Name = {
    Text = "셀레네의 고창"
  },
  State_97137_Desc = {
    Text = "버린 후 다시 손으로 돌아온다."
  },
  State_97137_Name = {
    Text = "버린 후 손으로 돌아옴"
  },
  State_97137_WeaponDesc = {
    Text = "뽑았을 때 자신에게 1턴간 허약을 부여한다. 사용 시 모든 적에게 1턴간 허약을 부여한다. 판매 불가."
  },
  State_97219_Desc = {
    Text = "완다가 사용하는 다음 [Layer]장의 카드가 추가로 1회 발동한다."
  },
  State_97219_Name = {
    Text = "가시의 여왕"
  },
  State_97251_Desc = {
    Text = "· 상대의 우선 공격 대상이 되지 않으며, 상대가 단일 대상을 선택할 때 잠행 깨어남체를 선택할 수 없다.\n\n· 잠행 획득 시 자신의 도발과 다른 아군의 잠행을 해제한다. 다른 아군이 없거나 적이 도발을 획득할 경우 잠행을 해제한다."
  },
  State_97251_Name = {Text = "잠행"},
  State_97252_Desc = {
    Text = "· 상대의 우선 공격 대상이 되지 않으며, 상대가 단일 대상을 선택할 때 잠행 깨어남체를 선택할 수 없다.\n\n· 잠행 획득 시 자신의 도발과 다른 아군의 잠행을 해제한다. 다른 아군이 없거나 적이 도발을 획득할 경우 잠행을 해제한다."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:잠행>"
  },
  State_97339_Name = {
    Text = "미사그 우승컵"
  },
  State_97742_Desc = {
    Text = "능동 피해를 받을 때마다, 피해 출처에게 [Layer] 의 <FixedDamage:순수 피해>를 가함."
  },
  State_97742_Name = {Text = "반격"},
  State_97743_Desc = {
    Text = "주는 능동 피해가 [Layer]pt 증가한다."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:힘>"
  },
  State_97744_Desc = {
    Text = "받는 모든 피해가 [Layer] % 감소."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:보강>"
  },
  State_97744_WeaponDesc = {
    Text = "주는 모든 피해가 [DescArg1]% 감소한다."
  },
  State_97938_Desc = {
    Text = "최종 피해가 [DescArg1]% 증가한다."
  },
  State_97938_Name = {
    Text = "미사그 우승컵"
  },
  State_97939_Desc = {
    Text = "주는 최종 피해가 50% 증가한다."
  },
  State_97939_Name = {
    Text = "미사그 우승컵"
  },
  State_97941_Desc = {
    Text = "기본 피해가 100% 증가한다."
  },
  State_97941_Name = {
    Text = "미사그 우승컵"
  },
  State_97942_Desc = {
    Text = "광기 폭발 발동 시 광기 35를 획득한다."
  },
  State_97942_Name = {
    Text = "미사그 우승컵"
  },
  State_97943_Name = {
    Text = "행동력 유지 카운터"
  },
  State_98055_Desc = {
    Text = "턴 종료 시, 촉수 1개를 생성한다. 깨어남 후 이 상태를 제거한다."
  },
  State_98055_Name = {Text = "깊은 잠"},
  State_98060_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_98060_Name = {
    Text = "미깨어남"
  },
  State_98068_Desc = {
    Text = "「폭염」 10스택을 보유할 때, 행동력 2를 획득하고 모든 「페타 플레어」를 「엑사 플레어」로 업그레이드한다."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:폭염>"
  },
  State_98139_Desc = {
    Text = "상대 턴 시작 후 무작위 손패 1장에 <BurningKeywords:연소>를 부여한다."
  },
  State_98139_Name = {
    Text = "다시 타오르는 업화"
  },
  State_98140_Desc = {
    Text = "<MonsterExFlameKeywords:폭염> 10스택을 적립한 후 의도를 극히 높은 피해의 「엑사 플레어」로 전환한다!"
  },
  State_98140_Name = {
    Text = "<BurningColor:폭염>"
  },
  State_98147_Desc = {
    Text = "적이 <BurningKeywords:연소> 카드를 사용할 때, 자신에게 <MonsterExFlameKeywords:폭염> 1스택을 부여하지만, <PowerIconKeywords:힘>이 [DescArg1] 임시로 감소한다."
  },
  State_98147_Name = {
    Text = "꺼지지 않는 불꽃"
  },
  State_98148_Desc = {
    Text = "이 깨어남체는 아직 깨어남하지 않았다… 쓰러지기 직전에 깨어남하여 남은 모든 손패를 버리고 <BurningKeywords:연소>를 부여하며, HP를 회복하고 진정한 형태로 전투를 시작한다."
  },
  State_98148_Name = {
    Text = "미깨어남"
  },
  State_98302_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 힘 획득 효과가 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체의 명령 카드를 사용한 후, 장착한 깨어남체의 공격력 <WeaponEffect_Num:[StateArg3]%>만큼의 임시 힘을 획득한다. 매 턴 최대 5회 발동된다."
  },
  State_98302_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가하며, 주는 힘이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 장착한 깨어남체의 명령 카드를 사용한 후, <WeaponEffect_Num:[Power:DescArg1]>의 임시 힘을 획득한다. 매 턴 최대 5회 발동된다(현재 [DescArg2]/5회 발동됨)."
  },
  State_98323_Desc = {
    Text = "카드가 버려진 후 다시 손으로 되돌아온다."
  },
  State_98323_Name = {
    Text = "버린 후 손으로 돌아옴"
  },
  State_98341_Desc = {
    Text = "다른 원색과 조화하여 새로운 색으로 변할 수 있다."
  },
  State_98341_Name = {
    Text = "<Yellow:원색·옐로>"
  },
  State_98344_Desc = {
    Text = "다른 원색과 조화하여 새로운 색으로 변할 수 있다."
  },
  State_98344_Name = {
    Text = "<Red:원색·레드>"
  },
  State_98345_Desc = {
    Text = "다른 원색과 조화하여 새로운 색으로 변할 수 있다."
  },
  State_98345_Name = {
    Text = "<Blue:원색·블루>"
  },
  State_98366_Desc = {
    Text = "턴 시작 시, 은열쇠 에너지가 [Arg1]보다 크면 [Arg1]의 은열쇠 에너지를 소모하여 <DerivativeCardKeywords_115:「고급 영감」> 1장을 손에 넣는다."
  },
  State_98435_Desc = {
    Text = "빨간색과 파란색의 조화로 이루어졌으며, 능동 피해를 1회 줄 때마다 <Block:[DescArg1]>의 실타래드를 획득한다."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:이상·퍼플>"
  },
  State_98436_Desc = {
    Text = "빨간색과 노란색의 조화로 이루어졌으며, 광기 폭발 후 해당 깨어남체가 <Energy:15>의 광기를 획득한다."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:이상·오렌지>"
  },
  State_98437_Desc = {
    Text = "주는 최종 피해가 10% 증가한다."
  },
  State_98437_Name = {
    Text = "<Red:원색·레드>"
  },
  State_98438_Desc = {
    Text = "노란색과 파란색의 조화로 이루어졌으며, 「방어」를 사용한 후 <Heal:[DescArg1]>의 HP를 회복한다."
  },
  State_98438_Name = {
    Text = "<GreenWord:이상·그린>"
  },
  State_98439_Desc = {
    Text = "노란색과 파란색의 조화로 이루어졌으며, 「방어」를 사용한 후 <Heal:[DescArg1]>의 HP를 회복한다."
  },
  State_98439_Name = {
    Text = "<GreenWord:이상·그린>"
  },
  State_98440_Desc = {
    Text = "빨간색과 파란색의 조화로 이루어졌으며, 능동 피해를 1회 줄 때마다 <Block:[DescArg1]>의 실타래드를 획득한다."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:이상·퍼플>"
  },
  State_98441_Desc = {
    Text = "빨간색과 노란색의 조화로 이루어졌으며, 광기 폭발 후 해당 깨어남체가 <Energy:15>의 광기를 획득한다."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:이상·오렌지>"
  },
  State_98444_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체의 명령 카드 5장을 사용한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 임시 치명타율을 획득한다. 이 효과는 매 턴 1회만 발동된다."
  },
  State_98444_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 장착한 깨어남체의 명령 카드 5장을 사용한 후, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg2]%>의 임시 치명타율을 획득한다. 이 효과는 매 턴 1회만 발동된다(현재 사용한 장수: [DescArg1]/5장)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:활염 1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:활염 3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:활염 2>"
  },
  State_98474_Desc = {
    Text = "다른 색을 혼합하여 조합할 수 있는 기본 색으로, 빨강, 노랑, 파랑으로 구성된다."
  },
  State_98474_Name = {Text = "원색"},
  State_98484_Name = {
    Text = "잊혀진 고난의 바다"
  },
  State_98485_Desc = {
    Text = "이 카드가 주는 실타래드와 광기가 [DescArg2]% 증가하며, 최종 피해와 힘이 [DescArg1]% 증가하고, 「유지」를 획득한다. 사용 후 모든 「활염」을 소모하고 1스택의 「활염」을 손에 있는 다른 케티구라의 명령 카드 1장으로 전이한다."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:활염 2>"
  },
  State_98486_Desc = {
    Text = "이 카드가 주는 실타래드와 광기가 [DescArg2]% 증가하며, 최종 피해와 힘이 [DescArg1]% 증가하고, 「유지」를 획득한다. 사용 후 모든 「활염」을 소모하고 1스택의 「활염」을 손에 있는 다른 케티구라의 명령 카드 1장으로 전이한다."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:활염 3>"
  },
  State_98487_Desc = {
    Text = "이 카드가 주는 실타래드와 광기가 [DescArg2]% 증가하며, 최종 피해와 힘이 [DescArg1]% 증가하고, 「유지」를 획득한다. 사용 후 모든 「활염」을 소모하고 1스택의 「활염」을 손에 있는 다른 케티구라의 명령 카드 1장으로 전이한다."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:활염 1>"
  },
  State_98488_Desc = {
    Text = "「활염」 1스택당 카드가 주는 최종 피해, 실타래드, 광기, 힘이 30% 증가하며, 최대 3스택까지 중첩된다. 「활염」을 보유한 카드는 「유지」를 획득하며, 사용 후 모든 「활염」을 소모하고 1스택의 「활염」을 손에 있는 다른 케티구라의 명령 카드 1장으로 전이한다."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:활염>"
  },
  State_98492_Desc = {
    Text = "탐색 시작 후, 체질, 공격력, 방어력이 [StateArg1]% 증가한다."
  },
  State_98492_Name = {
    Text = "영혼 적성"
  },
  State_98495_Desc = {
    Text = "탐색 시작 후, 체질, 공격력, 방어력이 [StateArg1]% 증가한다."
  },
  State_98495_Name = {
    Text = "영혼 적성"
  },
  State_98507_Desc = {
    Text = "탐색 시작 후, 체질, 공격력, 방어력이 [StateArg1]% 증가한다."
  },
  State_98507_Name = {
    Text = "영혼 적성"
  },
  State_98511_Name = {
    Text = "파생 카드 획득"
  },
  State_98551_Desc = {
    Text = "전투 시작 시 영역 숙련이 [Arg1] 증가한다. 홀수 턴 시작 시 카드 1장을 드로우하고, 짝수 턴 시작 시 행동력 1을 획득한다."
  },
  State_98553_Desc = {
    Text = "「배아」 1개를 생성할 때마다 [Arg1]의 핏빛 용광로를 획득한다. 매 턴 최대 3회 발동된다."
  },
  State_98555_Desc = {
    Text = "전투 시작 시 [Arg1]%의 강효를 획득한다. 매 턴 최초로 중독을 부여한 후, [Arg2]장의 카드를 드로우한다."
  },
  State_98556_Desc = {
    Text = "모든 깨어남체의 HP 회복과 실타래드의 기본 효과가 [Arg1]% 증가한다."
  },
  State_98557_Desc = {
    Text = "「배아」 1개를 생성할 때마다 [Arg1]의 핏빛 용광로를 획득한다. 매 턴 최대 3회 발동된다."
  },
  State_98559_Desc = {
    Text = "카드를 1장 드로우하거나 버릴 때마다 [Arg1]의 임시 힘을 획득하며, 최대 [Arg2]의 임시 힘을 획득할 수 있다."
  },
  State_98560_Desc = {
    Text = "모든 깨어남체가 주는 기본 피해가 [Arg1]% 증가한다. 광기 폭발을 발동하기 전, 발동한 깨어남체가 주는 기본 피해가 임시로 [Arg2]% 증가한다."
  },
  State_98561_Desc = {
    Text = "턴 시작 시, HP가 50% 미만일 경우 임시 피해 증폭이 [Arg1]% 증가한다. HP가 25% 미만일 경우, 추가로 [Arg2]장의 카드를 드로우하고 행동력을 [Arg2] 획득한다."
  },
  State_98562_Desc = {
    Text = "능동 피해 또는 촉수 피해를 입힌 후, 대상이 이번 턴에 받는 촉수 피해가 [Arg1]% 증가한다. 매 턴 최대 20회 발동된다."
  },
  State_98563_Desc = {
    Text = "전투 시작 시 [Arg1]의 힘을 획득한다. 「소모」가 있는 카드를 1장 사용할 때마다 [Arg2]의 임시 힘을 획득하며, 최대 [Arg3]회 발동된다."
  },
  State_98564_Desc = {
    Text = "「광기 폭발」로 [Arg1]의 은열쇠 에너지를 획득한다. 매 턴 최대 3회 발동된다."
  },
  State_98565_Desc = {
    Text = "각 카드가 초차원으로 들어올 시, 드로우 덱에서 해당 카드 소속 깨어남체의 명령 카드를 [Arg1]장 드로우한다. 드로우할 수 없다면 동일한 양의 행동력을 획득한다. 매 턴 최대 2번 발동할 수 있다."
  },
  State_98567_Desc = {
    Text = "턴 종료 전, 손에 있는 각 명령 카드의 소속 깨어남체가 [Arg1]의 광기를 획득한다."
  },
  State_98568_Desc = {
    Text = "전투 시작 시 피해 강효가 [Arg1]% 증가한다. 능동 피해를 입힌 후 모든 적에게 [Arg2]의 중독을 부여하며, 매 턴 최대 5회 추가로 발동된다."
  },
  State_98569_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」 발동 후, 모든 적에게 [Arg1]스택의 중독을 부여하고 [Arg2]스택의 반격을 획득한다."
  },
  State_98571_Desc = {
    Text = "은열쇠 깨어남 사용 후 [Arg1]의 HP를 회복하고, [Arg2]의 은열쇠 에너지를 획득한다."
  },
  State_98571_Name = {
    Text = "여행용 양산"
  },
  State_98572_Desc = {
    Text = "매 턴 두 번째로 「열쇠 지령」을 발동한 후, [Arg1]의 은열쇠 에너지를 획득하고, 모든 깨어남체가 [Arg2]의 광기를 획득한다."
  },
  State_98575_Desc = {
    Text = "전투 시작 시 피해 강효가 [Arg1]% 증가한다. 능동 피해를 입힌 후 모든 적에게 [Arg2]의 중독을 부여하며, 매 턴 최대 5회 추가로 발동된다."
  },
  State_98576_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1]스택의 허약과 취약을 부여한다. 「소멸」 후에도 이 효과가 발동되지만, 3턴의 재사용 대기 시간이 있다."
  },
  State_98577_Desc = {
    Text = "모든 깨어남체가 주는 기본 피해가 [Arg1]% 증가한다. 광기 폭발을 발동하기 전, 발동한 깨어남체가 주는 기본 피해가 임시로 [Arg2]% 증가한다."
  },
  State_98579_Desc = {
    Text = "턴 시작 시, HP가 50% 미만일 경우 임시 피해 증폭이 [Arg1]% 증가한다. HP가 25% 미만일 경우, 추가로 [Arg2]장의 카드를 드로우하고 행동력을 [Arg2] 획득한다."
  },
  State_98581_Desc = {
    Text = "모든 깨어남체의 매 턴 최초 「명령 카드」는 [Arg1]의 은열쇠 에너지를 획득한다."
  },
  State_98582_Desc = {
    Text = "「광기 폭발」을 5회 발동한 후, 다음에 사용하는 [Arg1]장의 비파생 명령 카드가 추가로 1회 발동한다."
  },
  State_98583_Desc = {
    Text = "모든 깨어남체의 매 턴 최초 「명령 카드」는 [Arg1]의 은열쇠 에너지를 획득한다."
  },
  State_98586_Desc = {
    Text = "턴 시작 시, 광기 폭발을 발동하기에 광기가 부족한 모든 깨어남체가 [Arg1]의 광기를 획득한다."
  },
  State_98587_Desc = {
    Text = "카드를 1장 드로우하거나 버릴 때마다 [Arg1]의 임시 힘을 획득하며, 최대 [Arg2]의 임시 힘을 획득할 수 있다."
  },
  State_98588_Desc = {
    Text = "턴 종료 전, 손에 있는 각 명령 카드의 소속 깨어남체가 [Arg1]의 광기를 획득한다."
  },
  State_98589_Desc = {
    Text = "전투 시작 시 모든 적의 임시 힘을 [Arg1]만큼 잃게 한다. 「핏빛 용광로」를 사용할 때도 이 효과가 발동되지만, 3턴의 쿨다운이 있다."
  },
  State_98590_Desc = {
    Text = "전투 시작 시 [Arg1]%의 강효를 획득한다. 매 턴 최초로 중독을 부여한 후, [Arg2]장의 카드를 드로우한다."
  },
  State_98591_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」 발동 후, 모든 적에게 [Arg1]스택의 중독을 부여하고 [Arg2]스택의 반격을 획득한다."
  },
  State_98596_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」 사용 후 소모한 은열쇠 에너지의 [Arg1]%를 반환한다."
  },
  State_98597_Desc = {
    Text = "은열쇠 깨어남 사용 후 [Arg1]의 HP를 회복하고, [Arg2]의 은열쇠 에너지를 획득한다."
  },
  State_98597_Name = {
    Text = "여행용 양산+"
  },
  State_98598_Desc = {
    Text = "전투 시작 시 [Arg1]의 힘을 획득한다. 「소모」가 있는 카드를 1장 사용할 때마다 [Arg2]의 임시 힘을 획득하며, 최대 [Arg3]회 발동된다."
  },
  State_98600_Desc = {
    Text = "전투 시작 시 모든 적의 임시 힘을 [Arg1]만큼 잃게 한다. 「핏빛 용광로」를 사용할 때도 이 효과가 발동되지만, 3턴의 쿨다운이 있다."
  },
  State_98602_Desc = {
    Text = "전투 시작 시 피해 증폭을 [Arg1]% 획득한다. 매 턴 첫 반격을 획득한 후, 행동력 1/2을 획득한다."
  },
  State_98603_Desc = {
    Text = "전투 시작 시 피해 증폭 +[Arg1]%를 획득합니다. 주동 또는 촉수 피해를 받은 후 반격 [Arg2]을 획득하며, 매 턴 최대 3회 발동합니다."
  },
  State_98604_Desc = {
    Text = "전투 시작 시 피해 증폭 +[Arg1]%를 획득합니다. 주동 또는 촉수 피해를 받은 후 반격 [Arg2]을 획득하며, 매 턴 최대 3회 발동합니다."
  },
  State_98606_Desc = {
    Text = "각 카드가 초차원으로 들어올 시, 드로우 덱에서 해당 카드 소속 깨어남체의 명령 카드를 [Arg1]장 드로우한다. 드로우할 수 없다면 동일한 양의 행동력을 획득한다. 매 턴 최대 2번 발동할 수 있다."
  },
  State_98607_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」으로 모든 촉수가 적을 [Arg1]회 공격하며, 50%의 피해를 입힌다."
  },
  State_98608_Desc = {
    Text = "전투 시작 시 [Arg1]%의 피해 강효를 획득한다. 다른 깨어남체의 명령 카드를 1장 사용할 때마다 추가로 15/30%의 임시 피해 강효를 획득한다."
  },
  State_98610_Desc = {
    Text = "은열쇠 깨어남 사용 후 손에서 행동력 소모가 가장 높은 2/4장의 카드가 다음 사용 전까지 유지와 예비를 획득하고, 은열쇠 에너지 100/200을 획득한다."
  },
  State_98611_Desc = {
    Text = "전투 시작 시 영역 숙련이 [Arg1] 증가한다. 홀수 턴 시작 시 카드 1장을 드로우하고, 짝수 턴 시작 시 행동력 1을 획득한다."
  },
  State_98612_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」으로 임시 피해 강효가 [Arg1]% 증가한다. HP가 낮을수록 효과가 더 강력하다."
  },
  State_98613_Desc = {
    Text = "전투 시작 시 [Arg1]%의 피해 강효를 획득한다. 다른 깨어남체의 명령 카드를 1장 사용할 때마다 추가로 15/30%의 임시 피해 강효를 획득한다."
  },
  State_98614_Desc = {
    Text = "「광기 폭발」을 5회 발동한 후, 다음에 사용하는 [Arg1]장의 비파생 명령 카드가 추가로 1회 발동한다."
  },
  State_98615_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」 사용 후 소모한 은열쇠 에너지의 [Arg1]%를 반환한다."
  },
  State_98616_Desc = {
    Text = "모든 깨어남체의 HP 회복과 실타래드의 기본 효과가 [Arg1]% 증가한다."
  },
  State_98617_Desc = {
    Text = "능동 피해 또는 촉수 피해를 입힌 후, 대상이 이번 턴에 받는 촉수 피해가 [Arg1]% 증가한다. 매 턴 최대 20회 발동된다."
  },
  State_98619_Desc = {
    Text = "턴 종료 시 은열쇠 에너지가 가득 차 있다면, [Arg1]의 은열쇠 에너지를 소모하여 「은열쇠 미광」 1장을 손에 넣는다."
  },
  State_98621_Desc = {
    Text = "턴 종료 시 은열쇠 에너지가 가득 차 있다면, [Arg1]의 은열쇠 에너지를 소모하여 「은열쇠 서광」 1장을 손에 넣는다."
  },
  State_98623_Desc = {
    Text = "턴 시작 시, 광기 폭발을 발동하기에 광기가 부족한 모든 깨어남체가 [Arg1]의 광기를 획득한다."
  },
  State_98624_Desc = {
    Text = "전투 시작 시 및 죽음 저항 발동 후, [Arg1]의 은열쇠 에너지를 획득한다."
  },
  State_98625_Desc = {
    Text = "전투 시작 시 모든 적에게 [Arg1]스택의 허약과 취약을 부여한다. 「소멸」 후에도 이 효과가 발동되지만, 3턴의 재사용 대기 시간이 있다."
  },
  State_98626_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」으로 임시 피해 강효가 [Arg1]% 증가한다. HP가 낮을수록 효과가 더 강력하다."
  },
  State_98627_Desc = {
    Text = "「광기 폭발」로 [Arg1]의 은열쇠 에너지를 획득한다. 매 턴 최대 3회 발동된다."
  },
  State_98628_Desc = {
    Text = "매 턴 최초의 「열쇠 지령」으로 모든 촉수가 적을 [Arg1]회 공격하며, 50%의 피해를 입힌다."
  },
  State_98629_Desc = {
    Text = "매 턴 두 번째로 「열쇠 지령」을 발동한 후, [Arg1]의 은열쇠 에너지를 획득하고, 모든 깨어남체가 [Arg2]의 광기를 획득한다."
  },
  State_98630_Desc = {
    Text = "전투 시작 시 및 죽음 저항 발동 후, [Arg1]의 은열쇠 에너지를 획득한다."
  },
  State_98632_Desc = {
    Text = "전투 시작 시 피해 증폭을 [Arg1]% 획득한다. 매 턴 첫 반격을 획득한 후, 행동력 1/2을 획득한다."
  },
  State_98686_Desc = {
    Text = "다음에 사용하는 [Layer]장의 비파생 명령 카드가 추가로 1회 발동한다."
  },
  State_98686_Name = {
    Text = "비파생 명령 카드 이중 발사"
  },
  State_98739_Desc = {
    Text = "의도가 「창백한 선회」로 전환될 때, 상태 스택에 비례하여 동일한 횟수의 피해가 증가하며, 턴 종료 후 상태가 초기화된다. 3스택에 도달하면 즉시 의도가 「창백한 선회」로 전환된다."
  },
  State_98739_Name = {
    Text = "거미 여인의 키스"
  },
  State_98742_Desc = {
    Text = "부여하는 중독이 100% 증가하며, 매 턴 종료 시 <Block:[Block:DescArg1]>의 실타래드를 획득한다."
  },
  State_98742_Name = {
    Text = "방황의 길"
  },
  State_98743_Desc = {
    Text = "턴 중 [DescArg1]의 피해를 받은 후, 임시 보강 75스택을 획득하고, 의도를 「인내할 수 없는 자비」로 전환하며 석화 효과를 해제한다. 「거미 여왕의 키스」 1스택을 획득한다."
  },
  State_98743_Name = {Text = "참칭자"},
  State_98752_Desc = {
    Text = "카드를 연소시켜 사용하며, 사용 후 최대 HP의 5% 피해를 받고, 턴 종료 시까지 손에 있을 경우 소모된다."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:연소>"
  },
  State_98752_WeaponDesc = {
    Text = "각 스택의 둔화는 카드의 행동력 소모를 1 증가시킨다."
  },
  State_98887_Name = {
    Text = "구조의 성불"
  },
  State_98889_Desc = {
    Text = "매 턴 최초로 <DepleteIconKeywords:소모>가 있는 명령 카드를 사용할 때, 버린 카드 더미에 넣는다."
  },
  State_98889_Name = {
    Text = "구원의 성등"
  },
  State_98912_Desc = {
    Text = "스택당 모든 깨어남체가 주는 실타래드와 HP 회복이 10% 감소한다."
  },
  State_98912_Name = {
    Text = "<LostWay:로스트>"
  },
  State_98913_Desc = {
    Text = "스택당 모든 깨어남체가 주는 실타래드와 HP 회복이 10% 감소한다."
  },
  State_98913_Name = {Text = "로스트"},
  State_99007_Desc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않고, 덱에서 제거된다."
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:소모>"
  },
  State_99007_WeaponDesc = {
    Text = "사용 후 버린 카드 더미로 들어가지 않으며, 이번 전투에서 다시 사용할 수 없다."
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 다른 아군이 매 턴 처음으로 「광기 폭발」한 후, [StateArg1]장의 카드를 드로우한다."
  },
  State_99053_Name = {
    Text = "갈망의 붓"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:명륜>: 「광기 폭발」 후 장착한 깨어남체의 「스킬」 [StateArg1]장을 무작위로 손에 넣고, 해당 스킬의 행동력 소모를 0으로 만든다."
  },
  State_99055_Name = {
    Text = "사실타래주의 역설"
  },
  State_99056_Desc = {
    Text = "팀 유일: 열쇠 지령을 발동한 후, 장착한 깨어남체의 치명타율이 임시로 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_99056_WeaponDesc = {
    Text = "열쇠 지령을 발동한 후, 장착한 깨어남체의 치명타율이 임시로 <WeaponEffect_Num:[StateArg1]%> 증가한다."
  },
  State_99134_Desc = {
    Text = "「화가」가 그림을 그리는 데 사용되는 염료로, 스킬 효과를 강화할 수 있다. 최대 10스택까지 가능하다."
  },
  State_99134_Name = {
    Text = "환세 염료"
  },
  State_99237_Name = {
    Text = "상태 장식품 비상"
  },
  State_99237_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 10% 증가한다. 장착한 깨어남체의 피해 강효가 20%를 초과할 경우, 기본 피해가 추가로 10% 증가한다."
  },
  State_99238_Name = {
    Text = "상태@장식품 부식질"
  },
  State_99238_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 10% 증가한다. 장착한 깨어남체의 피해 강효가 20%를 초과할 경우, 기본 피해가 추가로 10% 증가한다."
  },
  State_99239_Name = {
    Text = "상태 장식품 스틱스"
  },
  State_99239_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 기본 피해가 10% 증가한다. 장착한 깨어남체의 피해 강효가 20%를 초과할 경우, 기본 피해가 추가로 10% 증가한다."
  },
  State_99258_Desc = {
    Text = "팀 유일: 매 턴 2번째 열쇠 지령을 발동한 후, <WeaponEffect_Num:[StateArg1]%> 확률로 장착한 깨어남체의 명령 카드 1장을 드로우한다. 매 턴 3번째 장착한 깨어남체의 명령 카드를 사용한 후, <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다."
  },
  State_99258_WeaponDesc = {
    Text = "매 턴 2번째 열쇠 지령을 발동한 후, <WeaponEffect_Num:[StateArg1]%> 확률로 장착한 깨어남체의 명령 카드 1장을 드로우한다. 매 턴 3번째 장착한 깨어남체의 명령 카드를 사용한 후, <WeaponEffect_Num:[StateArg2]>의 은열쇠 에너지를 획득한다."
  },
  State_99294_Desc = {
    Text = "모든 깨어남체가 획득하는 광기가 [DescArg1]% 증가하며, 턴 종료 시의 행동력과 명령 카드는 다음 턴까지 유지된다. 화려한 장편의 광기 획득량이 증가한다."
  },
  State_99294_Name = {Text = "「희」"},
  State_99295_Desc = {
    Text = "모든 깨어남체가 획득하는 광기가 [StateArg1]% 증가하며, 턴 종료 시의 행동력과 명령 카드는 다음 턴까지 유지된다. 분화 장편의 광기 획득량이 증가한다."
  },
  State_99295_Name = {Text = "「희」"},
  State_99336_Desc = {
    Text = "「화가」가 그림을 그리는 데 사용되는 염료로, 스킬 효과를 강화할 수 있다. 최대 10스택까지 가능하다."
  },
  State_99336_Name = {
    Text = "<DecayDye:환세 염료>"
  },
  State_99533_Name = {
    Text = "장식품 소녀의 번데기"
  },
  State_99533_WeaponDesc = {
    Text = "전투 시작 후, 장착한 깨어남체의 직업이 혼돈일 경우 공격력이 25% 증가한다."
  },
  State_99534_Name = {
    Text = "달콤한 민달팽이"
  },
  State_99534_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 실타래드와 HP 회복이 6% 증가한다. 장착한 깨어남체의 영역 숙련이 50을 초과할 경우, 실타래드와 HP 회복이 추가로 6% 증가한다."
  },
  State_99640_Desc = {
    Text = "현재 「창의」가 10스택일 경우, 픽맨이 광기 폭발을 발동한 후 모든 창의를 소모하여, 모든 깨어남체가 광기 15를 획득하고 「광상」 1스택을 획득한다. 창의의 최대치는 10스택이며, 다음 전투로 이월된다."
  },
  State_99640_Name = {Text = "창의"},
  State_99723_Desc = {
    Text = "팀 유일: 장착한 깨어남체가 주는 광기 및 힘 획득 효과가 <WeaponEffect_Num:[StateArg1]%> 증가한다. 광기 폭발을 발동한 후, 이번 턴에 다음으로 발동하는 다른 깨어남체의 광기 폭발 최종 피해, 실타래드, HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 이번 광기 폭발이 「포식」을 발동했다면, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  },
  State_99723_WeaponDesc = {
    Text = "장착한 깨어남체가 주는 광기 및 힘이 <WeaponEffect_Num:[StateArg1]%> 증가한다. 광기 폭발을 발동한 후, 이번 턴에 다음으로 발동하는 다른 깨어남체의 광기 폭발 최종 피해, 실타래드, HP 회복이 <WeaponEffect_Num:[StateArg2]%> 증가한다. 이번 광기 폭발이 「포식」을 발동했다면, 장착한 깨어남체가 <WeaponEffect_Num:[StateArg3]>의 광기를 획득한다."
  }
})
return Text_State
