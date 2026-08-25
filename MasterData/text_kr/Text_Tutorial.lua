__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "전투 중 이미 경험했던 턴으로 돌아갈 수 있으며, 전투의 앞 25턴 중 아무 한 턴으로 돌아갈 수 있습니다."
  },
  Tutorial_120371_Title_1 = {
    Text = "시간 역행"
  },
  Tutorial_124999_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스-순차 선택 모드>를 선택해 화면 오른쪽 아래의 「매칭 시작」을 터치하면 매칭에 들어갑니다. 사전 파티 구성은 필요하지 않습니다."
  },
  Tutorial_124999_Desc_2 = {
    Text = "대전 시작 전, 시스템이 랜덤으로 <TutorialHighlight:유물> 1개를 선택하며 해당 효과는 대전 중에 적용됩니다. 매 판 유물 효과에 따라 무작위로 제시되는 제한된 선택지의 카드 풀에서 필요한 깨어남체, 명륜, 열쇠 지령를 번갈아 선택해 편성을 구성하고 상대와 대전합니다."
  },
  Tutorial_124999_Desc_3 = {
    Text = "두 개의 깨어남체를 클릭하여 위치를 교환함으로써 전투 중 자신의 파티의 위치를 조정합니다. 위치는 앞뒤로 1-4의 순서로 배열됩니다."
  },
  Tutorial_124999_Title_1 = {
    Text = "순차 선택 모드"
  },
  Tutorial_126878_Desc_1 = {
    Text = "일부 깨어남체의 인격 심화가 +12에 도달하면 자동으로 \"최종 법칙\" 효과를 얻으며, 각 깨어남체가 얻는 효과는 다릅니다."
  },
  Tutorial_126878_Desc_2 = {
    Text = "깨어남체의 \"최종 법칙\"이 해금되면, 해당 깨어남체 전용 통신기 메시지를 수신하게 됩니다. 수호자는 꼭 확인해 주세요."
  },
  Tutorial_126878_Title_1 = {
    Text = "최종 법칙"
  },
  Tutorial_126878_Title_2 = {
    Text = "전용 메시지"
  },
  Tutorial_148475_Desc_1 = {
    Text = "각성체 동조율이 <TutorialHighlight:Lv20>에 도달하면 전용 <TutorialHighlight:광채>를 획득할 수 있습니다."
  },
  Tutorial_148475_Desc_2 = {
    Text = "<TutorialHighlight:광채>는 당신과 각성체가 혼연일체임을 증명하는 것입니다."
  },
  Tutorial_148475_Desc_3 = {
    Text = "이제 해당 각성체의 명령 카드가 전투 중 특별하게 표시되며, 소셜 상황에서 다른 수호자에게 보여줄 수 있습니다."
  },
  Tutorial_148475_Title_1 = {
    Text = "혼연일체"
  },
  Tutorial_17805_Desc_1 = {
    Text = "적을 클릭하면 모든 상태를 확인할 수 있습니다. <TutorialHighlight:경고> 상태는 더욱 주의 깊게 살펴봐야 하며, 이는 적의 특별한 메커니즘을 나타냅니다. 수호자가 조사를 원활하게 완료하지 못하는 대부분의 원인은 종종 적의 특별한 메커니즘을 주목하지 못했기 때문입니다."
  },
  Tutorial_17805_Title_1 = {Text = "적 상태"},
  Tutorial_17806_Desc_1 = {
    Text = "적을 물리친 후 <TutorialHighlight:각인>을 선택할 수 있으며, <TutorialHighlight:융흔>에서 <TutorialHighlight:검은 인장>를 소모하여 구매할 수 있습니다. <TutorialHighlight:각인>은 지정된 카드에 다양한 추가 효과를 부여합니다. 각 지정 카드에는 최대 <TutorialHighlight:1>회까지 각인을 할 수 있습니다. 더 자주 사용되는 명령 카드에 우선적으로 각인을 하면 각인으로 얻는 수익을 향상시킬 수 있습니다."
  },
  Tutorial_17806_Title_1 = {Text = "각인"},
  Tutorial_17807_Desc_1 = {
    Text = "깨어남체에 다양한 속성을 제공하며, <TutorialHighlight:세트>를 구성하면 특별한 효과도 발생합니다. 총 6개의 부위가 있으며, 각 부위의 <TutorialHighlight:주 속성>은 다릅니다. 크리티컬 확률과 크리티컬 피해는 I, II, III 부위에 나타나고; 광기 회복 등급과 은열 충전 등급은 I, IV, V 부위에 나타나며; 영역 숙련과 검은 인장 드롭율은 II, IV, VI 부위에 나타납니다; 피해 증폭과 데스 리저스턴스는 III, V, VI 부위에 나타납니다."
  },
  Tutorial_17807_Title_1 = {
    Text = "비밀계약"
  },
  Tutorial_17808_Desc_1 = {
    Text = "<TutorialHighlight:환몽심잠> 플레이 모드에서는 매번 도전 시 무작위로 선택된 맵에 진입하게 됩니다. 도전에 성공하면, 도전한 레벨의 난이도, 강화된 깨어남체, 그리고 레벨 내 평가 항목에 따라 적절한 점수를 얻습니다. 매주 도전에서는 다른 초기 창조물과 강화된 깨어남체가 제공됩니다."
  },
  Tutorial_17808_Desc_2 = {
    Text = "<TutorialHighlight:조사 랭킹>은 매주 도전에서 획득한 최고 점수에 따라 순위가 매겨지며, 매주 조사 랭킹이 정산되어 해당 보상이 지급됩니다. <TutorialHighlight:시즌 랭킹>은 시즌 동안 획득한 최고 점수에 따라 순위가 매겨집니다."
  },
  Tutorial_17808_Desc_3 = {
    Text = "「심잠 기록」은 여러 목표가 설정되어 있으며, 이를 달성하면 해당 보상을 받을 수 있습니다. 매번 「심잠 기록」 목표를 완료하거나 심잠 도전을 성공하면 <TutorialHighlight:심잠 경험치>를 획득할 수 있습니다. 심잠 경험치가 일정 값에 도달하면 <TutorialHighlight:심잠 레벨>이 상승하며, 풍부한 보상을 받을 수 있습니다. 심잠 기록과 심잠 레벨은 인터페이스 좌하단에서 확인할 수 있습니다."
  },
  Tutorial_17808_Title_1 = {
    Text = "환몽심잠"
  },
  Tutorial_17809_Desc_1 = {
    Text = "이벤트와 융흔을 통해 <TutorialHighlight:유물>을 얻을 수 있으며, <TutorialHighlight:유물>은 우리 파티의 전투 능력을 강화할 수 있습니다. 훌륭한 수호자는 종종 파티의 필요에 따라 더 적합한 <TutorialHighlight:유물>을 선택할 수 있습니다."
  },
  Tutorial_17809_Title_1 = {Text = "유물"},
  Tutorial_17810_Desc_1 = {
    Text = "안개를 걷어내어 지도 시야가 <TutorialHighlight:2>칸 증가합니다. 이를 활용하여 더 나은 경로를 계획할 수도 있죠."
  },
  Tutorial_17810_Title_1 = {Text = "조명등"},
  Tutorial_17811_Desc_1 = {
    Text = "<TutorialHighlight:중독> 상태인 대상은 턴 종료 시 <TutorialHighlight:중독>의 단계와 동일한 피해를 받습니다. <TutorialHighlight:중독> 데미지는 <TutorialHighlight:치명타가 불가능>합니다."
  },
  Tutorial_17811_Title_1 = {Text = "중독"},
  Tutorial_17812_Desc_1 = {
    Text = "<TutorialHighlight:취약> 상태인 대상은 받는 피해가 50% 증가하며, 턴 종료 시 자동으로 1스택 <TutorialHighlight:취약>이 제거됩니다. 적이 <TutorialHighlight:취약> 상태일 때 이를 활용하여 더 많은 피해를 입힐 수 있습니다."
  },
  Tutorial_17812_Title_1 = {Text = "취약"},
  Tutorial_17813_Desc_1 = {
    Text = "「부식의 폐허」, 「금지된 기록」, 「초월적 존재」 스테이지를 완료하면, 해당 스테이지와 더 낮은 난이도의 스테이지는 <TutorialHighlight:재현>할 수 있습니다. <TutorialHighlight:재현>을 통해 스테이지 보상을 빠르게 획득할 수 있습니다."
  },
  Tutorial_17813_Title_1 = {Text = "재현"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:실타래드>는 생명 대신 피해를 감당할 수 있으며, 턴 종료 시 <TutorialHighlight:자동 제거> 모든 실타래드가 제거됩니다. 실타래드의 한도는 파티의 <TutorialHighlight:생명 한도>와 동일합니다. 가능한 한 <TutorialHighlight:실타래드를 이번 턴의 모든 적의 피해 총합과 동일하게 유지하십시오>, 최소한의 비용으로 전투 승리를 쟁취하십시오."
  },
  Tutorial_17814_Title_1 = {
    Text = "실타래드"
  },
  Tutorial_17815_Desc_1 = {
    Text = "반복적으로 깨어남체를 획득하면 이를 <TutorialHighlight:파편>으로 변환합니다. <TutorialHighlight:파편>을 소모하여 깨어남체의 레벨을 높이면 깨어남체의 스킬에 추가적인 특수 능력을 얻을 수 있습니다. 깨어남체의 영혼 깨어남 레벨이 가득찬 후 해당 <TutorialHighlight:파편>을 획득할 시에는 <TutorialHighlight:영핵의 조각>으로 변환됩니다."
  },
  Tutorial_17815_Title_1 = {Text = "파편"},
  Tutorial_17816_Desc_1 = {
    Text = "행동력은 <TutorialHighlight:전체 파티 공유>되며, 카드를 플레이할 때 <TutorialHighlight:행동력>을 소모합니다. 행동력은 턴 시작 시 <TutorialHighlight:자동으로 최대치로 회복>되고, 턴 종료 후 <TutorialHighlight:자동으로 초기화>됩니다. 행동력의 효율적인 사용을 위해 가능한 한 <TutorialHighlight:모든 행동력을 소모한 후 턴을 종료>하시기 바랍니다."
  },
  Tutorial_17816_Title_1 = {Text = "행동력"},
  Tutorial_17817_Desc_1 = {
    Text = "<TutorialHighlight:초월적 존재>의 적을 물리치면 고등급 <TutorialHighlight:스킬 업그레이드 소재>를 얻을 수 있으며, 매주 1회 보상을 획득할 수 있습니다. 다양한 재료는 <TutorialHighlight:연금실타래>에서 합성 및 치환할 수도 있습니다."
  },
  Tutorial_17817_Title_1 = {
    Text = "초월적 존재"
  },
  Tutorial_17818_Desc_1 = {
    Text = "획득 후 <TutorialHighlight:물자에서 사용 가능>하며, 미리 설정된 값에 따라 깨어남체의 레벨과 스킬 레벨을 빠르게 상승시킬 수 있습니다."
  },
  Tutorial_17818_Title_1 = {
    Text = "영지 증폭기"
  },
  Tutorial_17819_Desc_1 = {
    Text = "깨어남체의 광기가 <TutorialHighlight:100>에 도달하면 <TutorialHighlight:광기 폭발>을 사용할 수 있습니다. 각 깨어남체의 광기 폭발 효과는 다르므로, 적절히 활용하면 <TutorialHighlight:전투 효율 극대화>할 수 있습니다."
  },
  Tutorial_17819_Title_1 = {
    Text = "광기 폭발"
  },
  Tutorial_17820_Desc_1 = {
    Text = "<TutorialHighlight:손상> 상태인 대상은 획득한 실타래드가 25% 감소하며, 턴 종료 시 자동으로 1중첩 <TutorialHighlight:손상>이 제거됩니다. 만약 아군 파티가 <TutorialHighlight:손상> 상태라면, 방어하기 전에 <TutorialHighlight:손상> 상태를 제거할 방법을 생각하거나 전략을 변경하여 이번 턴에 전력을 다해 공격해보세요."
  },
  Tutorial_17820_Title_1 = {Text = "손상"},
  Tutorial_17821_Desc_1 = {
    Text = "<TutorialHighlight:명륜>을 장착하면 깨어남체의 속성을 향상시키고 특별한 능력을 얻을 수 있습니다."
  },
  Tutorial_17821_Title_1 = {Text = "명륜"},
  Tutorial_17822_Desc_1 = {
    Text = "<TutorialHighlight:출혈> 상태인 대상은 턴 종료 시 <TutorialHighlight:출혈>의 단계와 동일한 피해를 받고 <TutorialHighlight:출혈 상태가 제거>됩니다.\n<TutorialHighlight:HP 회복> 시 회복량의 2배에 해당하는 출혈 스택을 제거합니다. 출혈 피해는 <TutorialHighlight:치명타가 불가능>합니다."
  },
  Tutorial_17822_Title_1 = {Text = "출혈"},
  Tutorial_17823_Desc_1 = {
    Text = "혼돈 깨어남체는 <TutorialHighlight:영역 제한을 돌파>하여 다른 영역의 깨어남체와 배치할 수 있으며, 서로 다른 공생 효과가 있습니다. 임의의 파티에 혼돈 깨어남체가 존재하면 추가로 100%의 죽음 저항을 획득할 수 있습니다."
  },
  Tutorial_17823_Desc_2 = {
    Text = "다른 영역의 파티에 비해, 혼돈 영역 파티는 은열쇠 에너지를 획득하는 속도가 더 빠릅니다. 또한 두 번째 열쇠 지령을 사용할 때 모든 열쇠 지령 중에서 원하는 것을 선택할 수 있으며, 선택한 약령은 2회 발동됩니다. 따라서 혼돈 영역 파티는 열쇠 지령과의 시너지가 매우 중요하며, 알맞은 열쇠 지령을 선택하면 혼돈 영역 파티의 전투력을 극대화할 수 있습니다."
  },
  Tutorial_17823_Title_1 = {Text = "혼돈"},
  Tutorial_17824_Desc_1 = {
    Text = "매 1점의<TutorialHighlight:방어>를 보유할 때마다 실타래드를 획득할 때 추가로 실타래드 1pt를 얻습니다."
  },
  Tutorial_17824_Title_1 = {Text = "방어"},
  Tutorial_17825_Desc_1 = {
    Text = "첫 조사를 완료한 후 <TutorialHighlight:공명 활성화 재료>를 얻을 수 있습니다. 이 재료는 강력한 <TutorialHighlight:공명>을 활성화하는 데 사용할 수 있으며, 공명은 이 장의 모든 관문에서 적용됩니다."
  },
  Tutorial_17825_Title_1 = {Text = "공명"},
  Tutorial_17826_Desc_1 = {
    Text = "내 파티이 <TutorialHighlight:광기 봉인> 상태일 때, 광기 폭발을 발동할 수 없다. 적이 <TutorialHighlight:광기 봉인>을 발동하기 전에 광기 폭발을 발동하여 광기를 낭비하지 않도록 하라."
  },
  Tutorial_17826_Title_1 = {
    Text = "광기의 봉인"
  },
  Tutorial_17827_Desc_1 = {
    Text = "<TutorialHighlight:영지 비약>를 소모하면 깨어남체 레벨이 상승하며, 깨어남체 업그레이드 후 속성이 향상됩니다. 레벨 상한선에 도달하면 먼저 승격해야 하며, 승격하면 깨어남체 레벨 상한선이 증가합니다."
  },
  Tutorial_17827_Title_1 = {
    Text = "영지 비약"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:힘>이 1 감소할 때마다, <TutorialHighlight:능동 피해>를 입힐 때마다 1의 피해가 감소합니다."
  },
  Tutorial_17828_Title_1 = {Text = "힘 감소"},
  Tutorial_17829_Desc_1 = {
    Text = "피해를 받기 전에 피해 면역을 얻고 <TutorialHighlight:장벽> 1층을 제거합니다. 단일 피해가 높을수록 <TutorialHighlight:장벽>의 효율이 더 높아집니다."
  },
  Tutorial_17829_Title_1 = {Text = "장벽"},
  Tutorial_17830_Desc_1 = {
    Text = "<TutorialHighlight:허약> 상태인 대상은 입히는 피해가 25% 감소하며, 턴 종료 시 자동으로 1단계 <TutorialHighlight:허약>이 제거됩니다. 만약 우리 파티가 <TutorialHighlight:허약> 상태라면, 공격하기 전에 <TutorialHighlight:허약> 상태를 제거할 방법을 생각하거나 전략을 변경하여 이번 턴에 전력을 다해 방어해 보세요."
  },
  Tutorial_17830_Title_1 = {Text = "허약"},
  Tutorial_17831_Desc_1 = {
    Text = "<TutorialHighlight:금지된 기록>의 적을 물리치면 깨어남체 능력을 업그레이드할 수 있는 <TutorialHighlight:비밀 계약>를 얻을 수 있으며, 각 장의 메인 스토리를 통과할 때마다 새로운 스테이지가 잠금 해제됩니다. 비밀 계약은 상점을 통해 교환하여 얻을 수도 있습니다."
  },
  Tutorial_17831_Title_1 = {
    Text = "금지된 기록"
  },
  Tutorial_17832_Desc_1 = {
    Text = "초차원파티이 매 턴에 사용한 <TutorialHighlight:첫 번째> 명령 카드의 임시 복사가 <TutorialHighlight:초차원 공간>에 들어가고 강력한 워프 효과를 발동합니다. 초차원 공간이 최대치에 도달하면 추가적인 <TutorialHighlight:초차원 턴>을 1개 획득하며, <TutorialHighlight:초차원 턴은 모든 워프 효과를 발동할 수 있습니다>. 초원파티을 잘 운영하는 기본 비결: 매 턴에 사용한 첫 번째 카드를 신중하게 계획하세요."
  },
  Tutorial_17832_Title_1 = {Text = "초차원"},
  Tutorial_17833_Desc_1 = {
    Text = "우리 파티의 생명력이 소진되면 <TutorialHighlight:응급 영지체>를 활성화하여 모든 상태를 회복할 수 있습니다. 응급 영지체는 매일 자동으로 <TutorialHighlight:1>개 회복되며, 최대 <TutorialHighlight:5>개까지 회복됩니다. 응급 영지체를 <TutorialHighlight:고난이도 전투>에 합리적으로 사용하고 함부로 낭비하지 마세요."
  },
  Tutorial_17833_Title_1 = {
    Text = "응급 영지체"
  },
  Tutorial_17834_Desc_1 = {
    Text = "지도에서 미세하게 빛나는 장소를 자세히 찾아가 조사하면 뜻밖의 수확이 있을 수 있습니다."
  },
  Tutorial_17834_Title_1 = {
    Text = "조사 포인트"
  },
  Tutorial_17835_Desc_1 = {
    Text = "이것은 모든 적의 이번 턴의 피해량의 총합입니다. 간단하면서도 유용한 수호자 전투 경험:<TutorialHighlight:가능한 한 방어막을 적의 총 피해량과 동일하게 유지하세요>."
  },
  Tutorial_17835_Title_1 = {
    Text = "적의 총 피해량"
  },
  Tutorial_17837_Desc_1 = {
    Text = "혈육 팀의 <TutorialHighlight:배아 융합>이 상한에 도달하면 1장의 <TutorialHighlight:「배아」>를 얻습니다. 광기 폭발을 발동하면 <TutorialHighlight:「배아」>를 소모하여 강력한 <TutorialHighlight:포식> 효과를 발동하므로, 손패에 <TutorialHighlight:「배아」>가 있을 때 최대한 광기 폭발을 발동해야 합니다. 그렇지 않으면 혈육 팀의 최대 실타래력을 발휘할 수 없습니다."
  },
  Tutorial_17837_Desc_2 = {
    Text = "매 전투가 끝난 후 5% 최대 생명의 회복량이 핏빛 용광로에 축적됩니다. 사용하지 않은 <TutorialHighlight:「배아」>가 있을 경우, 각 배아도 5% 최대 생명의 회복량을 용광로에 축적합니다. 핏빛 용광로는 아군의 HP를 회복하는 데 사용되며, 매 턴마다 한 번 용광로를 HP로 전환할 수 있습니다. 수호자는 핏빛 용광로의 사용 시기를 합리적으로 계획해야 전투의 흐름을 뒤바꿀 수 있습니다."
  },
  Tutorial_17837_Title_1 = {Text = "혈육"},
  Tutorial_17838_Desc_1 = {
    Text = "연락처에서, 당신은 우리 파티가 잃은 생명의 50%를 회복하거나 지정된 1명의 깨어남체를 깨어남할 수 있습니다. 우리 파티의 생명이 낮을 때는 생명 회복을 선택하는 것을 추천하며, 그렇지 않을 경우 깨어남체를 깨어남하는 것을 추천합니다."
  },
  Tutorial_17838_Title_1 = {Text = "연락처"},
  Tutorial_17839_Desc_1 = {
    Text = "검은 인장을 소모하여 자신의 파티를 강화할 수 있는 장소로, 일반적으로 1개의 각인, 1개의 실타래버 유물, 1개의 골드 창조물이 제공됩니다. 여기에서 필요한 아이템이 없다면, 오른쪽 상단의 <TutorialHighlight:갱신>을 터치하면 융흔이 새로운 아이템을 제공합니다."
  },
  Tutorial_17839_Title_1 = {Text = "융흔"},
  Tutorial_17840_Desc_1 = {
    Text = "강제로 <TutorialHighlight:환상>을 통과하면 \"증상\"에 감염됩니다."
  },
  Tutorial_17840_Title_1 = {Text = "환상"},
  Tutorial_17841_Desc_1 = {
    Text = "명령 카드를 통해 깨어남체가 <TutorialHighlight:광기>를 얻을 수 있으며, 명령 카드의 스킬 레벨이 높을수록 얻는 광기가 많아집니다."
  },
  Tutorial_17841_Title_1 = {Text = "광기"},
  Tutorial_17842_Desc_1 = {
    Text = "적을 물리치거나 이벤트를 조사하면 <TutorialHighlight:검은 인장>를 얻을 수 있으며, 깨어남체의 <TutorialHighlight:검은 인장 드롭> 속성을 향상시켜 얻을 수 있는 검은 인장의 수량을 늘릴 수 있습니다."
  },
  Tutorial_17842_Desc_2 = {
    Text = "융흔에서 <TutorialHighlight:검은 인장>를 소모하여 각인과 유물을 구매할 수 있으며, 이를 사용하여 깨어남체를 깨어남시킬 수도 있습니다. 최종전에 앞서, 가능한 모든 블랙 마크를 소모하여 우리 편의 파티을 강화하세요."
  },
  Tutorial_17842_Title_1 = {
    Text = "검은 인장"
  },
  Tutorial_17843_Desc_1 = {
    Text = "공격을 받을 때, 공격자에게 <TutorialHighlight:반격>의 단계와 동일한 피해를 입힙니다. <TutorialHighlight:반격> 피해는 <TutorialHighlight:치명타가 불가능>합니다."
  },
  Tutorial_17843_Title_1 = {Text = "반격"},
  Tutorial_17844_Desc_1 = {
    Text = "매 1pt의 <TutorialHighlight:힘>을 소유하고, 적극적으로 피해를 입힐 때마다 추가로 피해가 1pt 증가합니다."
  },
  Tutorial_17844_Title_1 = {Text = "힘"},
  Tutorial_17845_Desc_1 = {
    Text = "파견 깨어남체가 연구 미션을 완료하면, 완료 후 해당 보상을 획득할 수 있습니다. 파견 깨어남체의 <TutorialHighlight:총 레벨>이 높을수록 보상이 더욱 풍성하며, 최대 총 240 레벨로 계산됩니다."
  },
  Tutorial_17845_Title_1 = {Text = "파견"},
  Tutorial_17847_Desc_1 = {
    Text = "치명적인 피해를 받을 때, <TutorialHighlight:죽음 저항과 동등한 확률>로 이 피해를 면역하고 1의 생명력을 보존하며, <TutorialHighlight:발동에 성공하면 죽음 저항이 절반으로 줄어듭니다>. 파티의 죽음 저항은 모든 깨어남체의 죽음 저항 합계와 같으며, 파티의 죽음 저항을 증가시키는 것은 전투 시의 실타래수 용인율을 높이는 데 도움이 됩니다."
  },
  Tutorial_17847_Title_1 = {
    Text = "죽음 저항"
  },
  Tutorial_17848_Desc_1 = {
    Text = "심해 파티 전투 시작 시 1개의 <TutorialHighlight:촉수>가 생성되며, <TutorialHighlight:촉수>는 턴 종료 시 전방의 적을 공격합니다. 현재의 촉수 피해와 공격 횟수는 촉수 아이콘 아래의 수식을 통해 확인할 수 있습니다. 일부 깨어남체는 촉수 수량과 촉수 피해를 증가시킬 수 있으며, 턴 종료 시 대량의 피해를 입힐 수 있습니다."
  },
  Tutorial_17848_Title_1 = {Text = "심해"},
  Tutorial_17850_Desc_1 = {
    Text = "손패를 사용하려면 행동력을 소모해야 하며, 턴 종료 시 모든 손패는 <TutorialHighlight:버린 카드 더미>로 들어갑니다. <TutorialHighlight:카드 내기 순서>를 합리적으로 계획하는 것이 전투 승리의 관건입니다."
  },
  Tutorial_17850_Title_1 = {Text = "손패"},
  Tutorial_17851_Desc_1 = {
    Text = "적의 다음 턴에 취할 행동을 대표하며, 이번 턴의 결정을 내릴 때 <TutorialHighlight:의도>를 활용하는 것이 전투의 핵심 플레이입니다."
  },
  Tutorial_17851_Title_1 = {
    Text = "적의 의도"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:스킬 강화>는 깨어남체의 속성을 향상시키고 명령 카드의 효과를 강화할 수 있습니다. 깨어남체 스킬 화면에서 다음 레벨을 클릭하면 업그레이드된 효과를 미리 볼 수 있습니다."
  },
  Tutorial_17852_Desc_2 = {
    Text = "다른 영역의 깨어남체는 다른 <TutorialHighlight:스킬 강화 소재>가 필요합니다."
  },
  Tutorial_17852_Title_1 = {
    Text = "스킬 강화"
  },
  Tutorial_20768_Desc_1 = {
    Text = "깨어남체가 행동력을 소모할 때 <TutorialHighlight:은열쇠 에너지>를 획득할 수 있습니다. 깨어남체의 <TutorialHighlight:은열쇠 충전> 속성은 획득하는 <TutorialHighlight:은열쇠 에너지>를 증가시킵니다."
  },
  Tutorial_20768_Title_1 = {
    Text = "은열쇠 에너지"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:녹슨 문>은 중요한 조사 경로를 막습니다. 지도에서 <TutorialHighlight:녹슨 열쇠>라는 물건을 찾아보세요. 이 열쇠는 <TutorialHighlight:녹슨 문>을 시작할 수 있습니다."
  },
  Tutorial_20769_Title_1 = {Text = "녹슨 문"},
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:녹슨 열쇠>는 당신의 전진을 막는 <TutorialHighlight:녹슨 문>을 열 수 있습니다."
  },
  Tutorial_20770_Title_1 = {
    Text = "녹슨 열쇠"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:어둠의 경계>는 네 개의 영역으로 구성된 일련의 스테이지로, 완료 시 은심, 영지 비약 등의 보상을 받을 수 있으며, 누적 성급이 지정된 요구 사항을 충족하면 추가로 은심, 무구의 은핵 등의 보상을 받을 수 있습니다!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "다른 경영역의 간격 관문은 조사파티의 깨어남체 경영역에 대해 특정 조건을 제시하며, <TutorialHighlight:조건을 만족하는> 파티만 조사를 진행할 수 있습니다."
  },
  Tutorial_20771_Title_1 = {
    Text = "어둠의 경계"
  },
  Tutorial_20772_Desc_1 = {
    Text = "은열쇠 에너지가 TutorialHighlight:1000에 도달하면 장착한 <TutorialHighlight:열쇠 지령>을 발동할 수 있습니다. 매 턴 열쇠 지령을 2회 발동할 수 있지만, 두 번째 발동 시에는 무작위 열쇠 지령 3개 중 1개를 선택하는 방식으로 변경되며, 이때 선택한 열쇠 지령은 이번 탐색에서 다시 선택할 수 없습니다. 파티 편성 시 아군 파티와 시너지가 맞는 열쇠 지령을 선택하면 조사를 훨씬 수월하게 진행할 수 있습니다."
  },
  Tutorial_20772_Title_1 = {
    Text = "열쇠 지령"
  },
  Tutorial_20773_Desc_1 = {
    Text = "같은 <TutorialHighlight:명륜>을 소모하여 스택을 수행하면 <TutorialHighlight:명륜>의 속성과 특수 능력을 향상시킬 수 있습니다. 스택을 1회에서 3회까지 수행하면 명륜의 효과가 강화되며, 스택을 4회에서 15회까지 수행하면 명륜의 속성이 강화됩니다. 스택 화면에서 「다음 단계」 버튼을 클릭하면 스택 후의 변화를 미리 볼 수 있습니다."
  },
  Tutorial_20773_Title_1 = {
    Text = "명륜 중첩 위치"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:비밀 계약 강화>는 비밀 계약의 속성 강도를 높일 수 있으며, 최대 12레벨까지 올릴 수 있습니다. 비밀 계약 분해를 통해 해당 잔본을 얻을 수 있으며, 자원에서 재료 교환을 통해 <TutorialHighlight:천면인장>을 얻을 수 있습니다. 비밀 계약 강화에는 <TutorialHighlight:천면인장>이 소모되며, 강화된 비밀 계약을 분해하면 강화에 소모된 <TutorialHighlight:천면인장>이 반환됩니다."
  },
  Tutorial_22247_Title_1 = {
    Text = "비밀 계약 강화"
  },
  Tutorial_22248_Desc_1 = {
    Text = "전이를 통해 <TutorialHighlight:비밀 계약>가 랜덤한 종류와 강도의 속성을 얻을 수 있으며, 부속성 속성은 부위와 무관하게 크리티컬 확률, 크리티컬 피해, 광기 회복 레벨, 은열 충전 레벨, 영역 숙련, 검은 인장 드롭율, 피해 증폭, 죽음저항 8종이 나타날 수 있습니다. 전사 시 특정 속성을 보존하고 싶다면 <TutorialHighlight:잠금>을 선택할 수 있으며, 잠금된 속성은 전사 시 변하지 않습니다."
  },
  Tutorial_22248_Title_1 = {
    Text = "비밀 계약 전이"
  },
  Tutorial_23466_Desc_1 = {
    Text = "수호자 조사 등급이 상승함에 따라 <TutorialHighlight:유물과 각인의 강도>가 함께 상승하고, 깨어남체 <TutorialHighlight:파티의 생명에 미치는 영향>도 상승합니다. 조사와 막간 훈련을 통해 많은 수호자 경험치를 얻을 수 있습니다. 린피테이프를 하나씩 소모할 때마다 수호자 경험치 1을 획득할 수 있습니다."
  },
  Tutorial_23466_Title_1 = {
    Text = "수호자 조사 등급"
  },
  Tutorial_47538_Desc_1 = {
    Text = "<TutorialHighlight:융재 금지구역>은 난이도가 상당히 높은 도전 시스템입니다. TutorialHighlight:수호자님은 여러 파티를 유연하게 조합하여 최대한 많은 특훈치를 확보하고, 이를 통해 더 많은 보상을 획득해야 합니다. 고위험 난이도에서는 적 유닛이 더욱 강력해질 뿐만 아니라, 다양한 디버프 효과가 적용됩니다."
  },
  Tutorial_47538_Desc_2 = {
    Text = "융재금지구역에는 독특한 규칙이 있습니다: 동일한 깨어남체와 영혼 깨어남, 동일한 명륜은 중복 출전할 수 없으며, 수호자는 초기 유물, 몬스터 및 추천 레벨에 따라 이번 도전 파티을 유연하게 선택할 수 있습니다. 전술적으로 최대한 많은 훈련 포인트를 얻기 위해 전투를 진행해야 합니다. <TutorialHighlight:도움> 으로 출전한 깨어남체는 이 제한의 영향을 받지 않습니다."
  },
  Tutorial_47538_Title_1 = {
    Text = "융재 금지 구역"
  },
  Tutorial_54390_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서, 전투 화면 내에서 적과 아군의 깨어남체가 가진 <TutorialHighlight:상태>는 생명력 및 광기 아래에 표시되며, 클릭하면 구체적인 효과를 확인할 수 있습니다."
  },
  Tutorial_54390_Desc_2 = {
    Text = "<TutorialHighlight:버프>에 해당하는 내용은 다음과 같습니다(자세히 보기): <TauntKeywords:도발>, <PowerColourKeywords:힘>, <EnergyStorageKeywords:차지>, <PVPProtectiveKeywords:장벽>, <StrengthenKeywords:반격>, <ReinforceKeywords:요새화>, <StrengthenKeywords:강화>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "<TutorialHighlight:디버프>에 해당하는 것은 다음과 같습니다(자세히 보기): <PVPEntanglementKeywords:엉킴>, <PVPVulnerabilityIconKeywords:취약>, <PVPSlowKeywords:둔화>, <ComaKeywords:석화>, <DisarmKeywords:마비>, <PVPMethysisKeywords:중독>, <PVPEmptinessKeywords:공허>, <PVPBleedingKeywords:출혈>, <PVPSeriousInjuryKeywords:중상>, <ComaKeywords:기절>."
  },
  Tutorial_54390_Title_1 = {Text = "상태"},
  Tutorial_54391_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 일부 깨어남체의 카드에는 서로 다른 <TutorialHighlight:부가 옵션> 효과가 있으며, <TutorialHighlight:컬렉션> 시스템에서 확인하거나 전투 중 카드에서 길게 눌러 확인할 수 있습니다. 부가 옵션에는 (상세 정보 클릭): <PVPPenetrateKeywords:관통>, <PrepareKeywords:준비>, <PVPResurrectionKeywords:부활>, <PVPHoldingKeywords:보유>, <PhantomKeywords:환영>, <PVPRaidKeywords:습격>이 포함됩니다."
  },
  Tutorial_54391_Title_1 = {
    Text = "부가 옵션"
  },
  Tutorial_54392_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서, 매칭 포인트는 시즌 종료와 새 시즌 시작에 따라 초기화되며, 시즌의 이름 및 지속 시간 등 정보는 화면 우측에서 확인하실타래 수 있습니다. 포인트가 초기화될 때, 지난 시즌 1000점을 초과한 수호자는 초과한 부분이 반으로 줄어듭니다."
  },
  Tutorial_54392_Desc_2 = {
    Text = "매 시즌 기간 동안 <TutorialHighlight:시즌 미션>이 제공되며, 시즌 미션을 완료하면 풍성한 보상을 받을 수 있습니다. 시즌 미션은 시즌 갱신 시 초기화됩니다."
  },
  Tutorial_54392_Title_1 = {Text = "시즌"},
  Tutorial_54393_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 깨어남체가 전사하면, 손패에 해당 깨어남체의 카드가 <TutorialHighlight:환상>으로 변환됩니다. <TutorialHighlight:명륜>을 이미 전사한 깨어남체에게 장착하면 1장의 환상을 얻고, 소모된 행동력을 반환받습니다. 환상은 특정 명륜의 효과로 <TutorialHighlight:작은 소원>으로 합성될 수 있습니다."
  },
  Tutorial_54393_Title_1 = {Text = "환상"},
  Tutorial_54394_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서, 첫 번째 턴에 양쪽 모두 <TutorialHighlight:행동력> 3pt와 한도를 가지고 있으며, 후공은 1장의 <TutorialHighlight:후공> 카드를 보충합니다. 이후 매 턴 시작 시, 행동력의 한도와 회복량이 1pt씩 증가하여 10pt가 될 때까지 증가합니다. 자동 증가 외에도 행동력의 한도를 높이거나 낮추는 다른 수단이 있으며, 행동력의 한도가 10에 도달한 후 추가로 증가하면, 초과 한도 1pt는 1장의 카드를 뽑는 것으로 대체됩니다."
  },
  Tutorial_54394_Title_1 = {Text = "행동력"},
  Tutorial_54395_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서, 각 깨어남체는 <TutorialHighlight:광기>와 <TutorialHighlight:광기 폭발>을 가지고 있습니다. <TutorialHighlight:타격> 카드나 특정 <TutorialHighlight:스킬> 카드를 사용하여 광기를 얻을 수 있으며, 피해를 받아 생명력을 잃을 때도 광기를 얻습니다(생명력 2% 또는 동량의 방어막을 잃을 때마다 광기 1pt를 얻습니다). 광기가 100에 도달하면 해당 깨어남체를 클릭하여 광기 폭발을 선택적으로 사용할 수 있습니다."
  },
  Tutorial_54395_Title_1 = {Text = "광기"},
  Tutorial_54396_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 매칭 대전 중 「대전 기록」의 특정 목표를 달성하면 해당 보상을 받을 수 있습니다. 이 보상은 일회성 보상으로 시즌 초기화와 관계없이 유지되며, 화면 왼쪽 하단의 「대전 기록」을 통해 확인할 수 있습니다."
  },
  Tutorial_54396_Title_1 = {
    Text = "대전 기록"
  },
  Tutorial_54397_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 화면 왼쪽의 「컬렉션」 탭에서 모든 깨어남체, 명륜, 열쇠 지령 정보를 볼 수 있습니다."
  },
  Tutorial_54397_Title_1 = {Text = "컬렉션"},
  Tutorial_54398_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 각 깨어남체는 2장의 <TutorialHighlight:타격> 카드와 3장의 <TutorialHighlight:스킬> 카드를 보유합니다. 일반적으로, 다른 스킬 카드는 서로 다른 행동력 소모량을 가집니다."
  },
  Tutorial_54398_Title_1 = {Text = "스킬"},
  Tutorial_54399_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 매 턴 자동으로 뽑게되는 수량은 5장이고, 기본 <TutorialHighlight:손패의 한도>도 10장입니다. 전투 화면의 오른쪽 아래에서 아군의 현재 손패 수와 손패 한도을 볼 수 있으며, 오른쪽 위에서 적의 상황을 확인할 수 있습니다. 다른 방법을 통해 매 턴 뽑기 수와 손패의 한도를 변경할 수 있습니다."
  },
  Tutorial_54399_Title_1 = {Text = "손패"},
  Tutorial_54400_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서, 각기 다른 깨어남체는 서로 다른 <TutorialHighlight:포지션>을 가지고 있으며, 총 5개가 있습니다. 구체적으로는 <TutorialHighlight:가디언>,<TutorialHighlight:투쟁>,<TutorialHighlight:영지>,<TutorialHighlight:흉성>,<TutorialHighlight:축복>입니다. <TutorialHighlight:배치>를 진행할 때는 4명의 서로 다른 위치의 깨어남체를 선택하여 파티를 구성해야 합니다."
  },
  Tutorial_54400_Title_1 = {Text = "포지션"},
  Tutorial_54401_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스-사전 편성 모드>를 선택해 화면 오른쪽 아래의 「매칭 시작」을 터치하면 배치 인터페이스로 이동합니다. 화면 왼쪽에 있는 <TutorialHighlight:사전 편성>에서 미리 파티를 구성할 수도 있습니다."
  },
  Tutorial_54401_Desc_2 = {
    Text = "사전 편성은 여러 세트를 저장할 수 있으며, 왼쪽 상단에서 파티 이름을 편집할 수 있습니다. 각 파티은 4명의 깨어남체, 4개의 명륜, 2개의 열쇠 지령으로 구성됩니다."
  },
  Tutorial_54401_Title_1 = {
    Text = "사전 편성 모드"
  },
  Tutorial_54705_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스> 모드에서 자신의 <TutorialHighlight:프로필 아이콘>을 클릭하고, 보내고 싶은 <TutorialHighlight:대전 이모티콘>을 선택하여 상대방에게 마음을 전달해 보세요!"
  },
  Tutorial_54705_Title_1 = {
    Text = "감정 표현"
  },
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:페이즈 체스>는 두 사람이 대결하는 게임으로, 양측은 각자 준비한 파티로 <TutorialHighlight:매칭 대전>을 진행하며, 매칭 시에는 실타래력이 비슷한 상대를 찾아 매칭합니다."
  },
  Tutorial_54706_Desc_2 = {
    Text = "대전을 통해 <TutorialHighlight:사전 구성 경험치>와 <TutorialHighlight:드래프트 경험치>를 획득할 수 있으며, 획득한 경험치에 따라 <TutorialHighlight:사전 구성 레벨> 및 <TutorialHighlight:드래프트 레벨>의 <TutorialHighlight:1회성 보상>을 해제할 수 있습니다."
  },
  Tutorial_54706_Desc_3 = {
    Text = "매주 포인트 순위에 따라 <TutorialHighlight:타이틀>을 얻고, 다음 날 <TutorialHighlight:장미 금권>을 받게 됩니다.\n 만약 동시에 「페이즈 체스」와 「환몽 심잠」에 참여했다면, 장미 금권의 정산은 이 두 가지 플레이 중 <TutorialHighlight:더 높은> 보상을 기준으로 합니다."
  },
  Tutorial_54706_Title_1 = {
    Text = "페이즈 체스 소개"
  },
  Tutorial_74798_Desc_1 = {
    Text = "다른 스테이지에는 다른 <TutorialHighlight:챕터> 환경이 존재하여 전체 규칙과 유물 효과를 크게 변경합니다. 구체적으로는 각 스테이지 화면에서 관련 탭을 클릭하여 확인할 수 있습니다."
  },
  Tutorial_74798_Title_1 = {Text = "챕터"},
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:깨어남체 회귀>는 깨어남체의 다양한 육성 소모를 반환할 수 있습니다."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:육성 회귀>은 깨어남체의 레벨, 승격, 스킬, 영지 심화 상태를 초기화하며, 소모된 재료와 금전은 전량 반환됩니다."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:영혼 깨어남 회귀>는 깨어남체의 영혼 깨어남 상태를 초기화하고, 영혼 깨어남이 가져오는 레벨 한도를 초기화하며, 소모된 재료는 전량 반환됩니다."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:블랙풀 반환>은 「육성 회귀」의 효과를 포함하며, 추가로 깨어남체 자체도 초기화되어 미개방 상태가 됩니다."
  },
  Tutorial_81370_Title_1 = {
    Text = "깨어남체 회귀"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:깨어남체 강화>는 가장 빠르게 깨어남체의 속성을 향상시키는 방법 중 하나입니다. <TutorialHighlight:영지 비약>을 소모하여 깨어남체의 레벨을 올릴 수 있습니다."
  },
  Tutorial_81371_Desc_2 = {
    Text = "깨어남체가 레벨 한도에 도달한 후에는 <TutorialHighlight:승격>을 통해 레벨 한도을 올려야 하며, 다른 영역의 깨어남체는 다른 <TutorialHighlight:승격 재료>가 필요합니다."
  },
  Tutorial_81371_Title_1 = {
    Text = "깨어남체 강화"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:영혼 깨어남>은 깨어남체의 명령 카드 효과를 크게 향상시킬 수 있습니다. 영혼 깨어남 레벨 7에서 <TutorialHighlight:초월 폭발>이 해제되어 깨어남체가 광기 폭발할 시에 추가 효과를 얻습니다. 영혼 깨어남 레벨 11과 15에서는 깨어남체 레벨 한도를 5레벨 높일 수 있습니다."
  },
  Tutorial_81372_Title_1 = {
    Text = "영혼 깨어남"
  }
})
return Text_Tutorial
