__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LanguageConfig = readonly({
  LanguageConfig_24Resonance1_1_CN = {
    Text = "랜덤 명령 카드 2장에 각인 새기기:「(EnchantConfig.Arg1)」"
  },
  LanguageConfig_24Resonance1_2_CN = {
    Text = "랜덤 명령 카드 4장에 각인 새기기:「(EnchantConfig.Arg1)」"
  },
  LanguageConfig_24Resonance1_3_CN = {
    Text = "3개의 랜덤 백은 유물 획득"
  },
  LanguageConfig_24Resonance1_4_CN = {
    Text = "3개의 랜덤 백은 유물을 획득하거나, 1개의 랜덤 황금+ 유물을 획득"
  },
  LanguageConfig_2ndAnniversarySenderText_CN = {Text = "라모나"},
  LanguageConfig_2ndAnniversaryText_CN = {
    Text = "어디에 있든지, %player%。\n미사그는 계속해서 차원 링크를 시도하고 있으며, 아마도 곧 다시 만날 수 있을 것입니다.\n돌은 당신이 있는 차원을 위치시켰으며, 그것이 내 마음에 어떤 광기를 가져오는지까지는 표현할 수 없습니다.\n명확하고 정확하며 규칙이 명확한 것들을 선호하지만, 이 일에 대해서는 희망이 아주 미약하고 비현실타래적이라도 상관없습니다.\n오래 기다리는 것보다, 영원히 재회하지 않을 이별은 더 상상할 수 없습니다.\n이번에 성공하지 못해도 괜찮습니다, 다음 번, 또 다음 번, 아니면 수천, 수만 번이라도, 필요하다면 나는 미사그의 모든 사람들과 함께 반드시 당신을 데려올 것입니다.\n지금 우리가 각각 다른 차원에 있지만, 미사그는 여전히 은심 테크를 통해 당신에게 도움을 줄 수 있는 가능성을 찾기 위해 노력했습니다. 우리의 과거 기억을 모아 새로운 기억을 만들어서, 이 선물들이 당신에게 도움이 될 수 있도록 하세요.\n모두 언제나 믿고 있습니다, 당신은 꼭 돌아올 것입니다.\n왜냐하면 나는 기다리는 일에 능숙합니다."
  },
  LanguageConfig_2ndAnniversaryTitleText_CN = {
    Text = "그 편의 그리움"
  },
  LanguageConfig_2ndAnniversary_200DrawsText_CN = {
    Text = "활동 미션를 완료하면 최대 「유명한 핵」×200을 받을 수 있습니다!"
  },
  LanguageConfig_AbilityCard_Lock_CN = {
    Text = "능력 봉인"
  },
  LanguageConfig_AboutToCompose_CN = {
    Text = "합성 예정"
  },
  LanguageConfig_AboutToDecompose_CN = {
    Text = "분해 예정"
  },
  LanguageConfig_AbyssAllClearanceChallengeScore_CN = {
    Text = "특훈 점수 합계"
  },
  LanguageConfig_AbyssChallengeAwakerAssistRuleTitle_CN = {
    Text = "조력 설명"
  },
  LanguageConfig_AbyssChallengeAwakerAssistRule_CN = {
    Text = "· 「융재금지구역」에서 조력 깨어남체를 1회 사용할 수 있습니다. 조력 깨어남체와 명륜은 편성 제한 규칙의 영향을 받지 않습니다. (융재금지구역의 규칙 설명에서 편성 제한 규칙의 자세한 내용을 확인할 수 있습니다.)\n· 조력 깨어남체가 있는 조사 파티를 초기화할 때 조력 횟수가 1회 반환됩니다."
  },
  LanguageConfig_AbyssChallengeBattleTips_CN = {
    Text = "* 완료된 후, 사용된 깨어남체, 명륜 및 은열쇠는 다른 융재금지구역에서 사용할 수 없습니다."
  },
  LanguageConfig_AbyssChallengeEndTips_CN = {Text = "종료됨"},
  LanguageConfig_AbyssChallengeHistoricalRecord_CN = {Text = "· 추가"},
  LanguageConfig_AbyssChallengeObtainScore_CN = {
    Text = "특훈 점수 획득"
  },
  LanguageConfig_AbyssChallengePass_CN = {Text = "완료"},
  LanguageConfig_AbyssChallengePerfectPass_CN = {
    Text = "완벽한 클리어"
  },
  LanguageConfig_AbyssChallengeRankNotOnTheList_CN = {
    Text = "랭킹 미등록"
  },
  LanguageConfig_AbyssChallengeRankPreviousPeriod_CN = {
    Text = "이전 시즌"
  },
  LanguageConfig_AbyssChallengeRankThisPeriod_CN = {
    Text = "이번 시즌"
  },
  LanguageConfig_AbyssChallengeResetTipsDateHour_CN = {
    Text = "{s1}일 {s2}시간 후 초기화"
  },
  LanguageConfig_AbyssChallengeResetTipsHourMinute_CN = {
    Text = "{s1}시간 {s2}분 후 초기화"
  },
  LanguageConfig_AbyssChallengeRevivalCostTips_CN = {
    Text = "응급 영지체가 3개 미만입니다. 비용을 지불하시겠습니까?"
  },
  LanguageConfig_AbyssChallengeRuleDesc_CN = {
    Text = "<Title:융재금지구역>\n· 융재금지구역은 난이도가 높은 컨텐츠입니다. 수호자는 여러 도전 팀을 유연하게 조합하여 최대한 높은 특훈 점수를 획득하고, 더 많은 보상을 얻어야 합니다.\n\n<Title:금지구역 기본 규칙>\n· 융재금지구역은 총 5개의 파도로 나뉘며, 각 파도마다 난이도가 다른 스테이지가 포함되어 있습니다.\n· 스테이지를 클리어하면 해당 스테이지에 맞는 특훈 점수를 획득할 수 있으며, 구체적인 수치는 스테이지 상세 화면에서 확인할 수 있습니다.\n· 특훈 점수가 일정량에 도달하면, 은심과 검은 공물 외에도 희귀 자원인 「원초 영핵」, 「원초 영핵 정수」를 획득할 수 있습니다! 이는 미사그 지하의 블랙풀에서 나오는 신비한 영핵으로, 깨어남체의 최대 레벨을 80까지 상승시킬 수 있습니다.\n· 「융재금지구역」은 주기적으로 스테이지 내용과 보상이 갱신됩니다. 해당 기간이 종료되면 수령하지 않은 보상은 획득할 수 없으니, 기간 내에 완료하고 수령하는 것을 잊지 마세요.\n\n<Title:금지구역 특수 규칙>\n· 융재금지구역에는 고유한 제한 규칙이 존재합니다: 동일 깨어남체와 명륜, 은열쇠는 중복하여 사용할 수 없습니다. 초기 유물, 몬스터, 추천 레벨을 참고하여 도전 팀을 유연하게 선택할 수 있습니다.\n· Ⅱ급 경보 이상의 스테이지는 융식의 파도의 영향으로 도전 팀의 전투 능력에 영향을 받습니다. 구체적인 효과는 스테이지 상세 화면에서 확인 가능합니다.\n· 도전을 완료한 후, 「리셋」 기능을 사용해 해당 스테이지의 도전 팀을 초기화할 수 있습니다. 초기화 후 깨어남체, 명륜, 은열쇠는 다시 사용할 수 있지만, 해당 스테이지에서 획득한 특훈 점수는 차감됩니다(보상 상태에는 영향 없음).\n· 동일 파도의 스테이지를 반복 도전하려면 먼저 초기화를 진행해야 합니다. 즉, 각 파도에서 수호자는 한 스테이지의 특훈 점수만 획득할 수 있으며, 중복 획득은 불가능합니다.\n· 「융재금지구역」에서는 조력 깨어남체를 1회 사용할 수 있습니다. 조력 깨어남체와 명륜은 제한 규칙의 영향을 받지 않으며, 조력 깨어남체가 포함된 도전 팀을 리셋하면 조력 기회도 1회 복구됩니다.\n\n<Title:랭킹>\n· 현재 주기와 이전 주기의 특훈 점수 랭킹, 그리고 다른 수호자들의 융재금지구역 클리어 팀 정보를 확인할 수 있습니다.\n· 랭킹에는 이번 주기 최고 특훈 점수와 해당 클리어 팀 정보가 표시됩니다. 초기화는 랭킹이나 클리어 팀 정보 표시에는 영향을 주지 않습니다."
  },
  LanguageConfig_AbyssChallengeRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_AbyssChallengeScore_CN = {
    Text = "누적 특훈 점수"
  },
  LanguageConfig_AbyssChallengeStageClearance_CN = {
    Text = "{s1} 완료"
  },
  LanguageConfig_AbyssChallengeTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_AbyssChallengeTipsV2_CN = {
    Text = "<Title:「융재 금지 구역」>\n·융재 금지 구역은 난이도가 높은 게임 시스템입니다. 수호자는 여러 도전 팀을 유연하게 조합하여 최대한 많은 훈련 포인트를 획득하고, 더 많은 보상을 얻어야 합니다.\n\n<Title:「금지 구역 기본 규칙」>\n·융재 금지 구역은 총 5개의 웨이브로 나뉘며, 각 웨이브에는 난이도 레벨이 다른 단계가 포함되어 있습니다.\n·단계를 클리어하면 해당 수량의 훈련 포인트를 획득할 수 있으며, 자세한 내용은 단계 상세 화면에서 확인할 수 있습니다.\n·훈련 포인트가 지정 요건에 도달하면 「은심」과 「검은 공물」을 수령할 수 있을 뿐만 아니라, 희귀 물자 「원초 영핵」「원초 영핵 정수」도 획득할 수 있습니다! 이는 미사그 지하 블랙풀에서 생산되는 신비로운 영핵으로, 각성체의 레벨 상한을 최대 90레벨까지 올리는 데 도움이 됩니다!\n·「융재 금지 구역」은 주기적으로 단계 내용과 보상이 갱신되며, 일반적으로 14일마다 한 번 갱신됩니다. 해당 기간이 종료되면 이전 기간에 진행 중이던 도전이 즉시 종료되며, 수령하지 않은 보상은 획득할 수 없으니 수호자 여러분, 제때 완료하고 수령하는 것을 잊지 마세요~\n\n<Title:「금지 구역 특수 규칙」>\n·융재 금지 구역에는 고유한 제한 법칙이 있습니다: 동일한 각성체와 은열쇠, 동명의 명륜은 중복 출전할 수 없으며, 수호자는 초기 유물, 몬스터 및 추천 레벨에 따라 이번 도전의 팀을 유연하게 선택할 수 있습니다.\n·도전 완료 후, 수호자가 더 좋은 조합 방안을 발견하면 「초기화」 기능을 사용하여 해당 단계의 도전 팀을 초기화할 수 있습니다. 초기화 후 각성체, 은열쇠, 명륜 모두 다시 출전할 수 있지만, 해당 단계 클리어로 획득한 훈련 포인트도 차감됩니다 (보상 상태에는 영향 없음).\n·「융재 금지 구역」에서는 조력자를 1회 사용할 수 있으며, 조력자 각성체와 명륜은 제한 법칙의 영향을 받지 않습니다. 조력자 각성체가 포함된 도전 팀을 초기화할 때도 조력자 횟수 1회가 반환됩니다.\n·도전 과정에서 「응급 영지체」를 사용하여 클리어를 도울 수 있으며, 매 사용 시 「응급 영지체」 3개가 필요합니다. 사용 후 완료된 도전과 훈련 포인트는 특별 표시되며, 훈련 보상은 정상적으로 수령할 수 있지만 랭킹에는 반영되지 않습니다.\n\n<Title:「추가 도전」>\n·임의의 단계를 클리어하면 해당 단계의 「추가 도전」이 해금되어 더 높은 난이도의 시험에 도전할 수 있습니다.\n·추가 도전은 별도로 도전 팀을 편성해야 하며, 동일하게 제한 법칙의 영향을 받습니다: 동일한 각성체와 은열쇠, 동명의 명륜은 중복 출전할 수 없으며, 조력자 횟수는 일반 도전과 공유됩니다 (전체 게임 모드 합산 1회).\n·추가 도전을 클리어하면 훈련 포인트 5점을 획득하며, 이번 기간 훈련 포인트 총액에 합산되어 더 많은 보상 수령 및 랭킹 순위 향상에 도움이 됩니다.\n·「초기화」 기능을 사용하여 추가 도전 팀 또는 일반 도전 팀을 개별적으로 초기화할 수 있습니다.\n·추가 클리어 후 일반 도전 팀을 초기화하면, 추가 도전 팀이 새로운 일반 도전 팀으로 전환되고, 추가 도전 진행 상황이 초기화되며, 추가 클리어 훈련 포인트가 차감됩니다.\n\n<Title:「랭킹」>\n·현재 기간과 이전 기간의 훈련 포인트 랭킹, 그리고 다른 수호자들의 융재 금지 구역 클리어 정보를 확인하여 수호자에게 참고 정보를 제공합니다.\n·랭킹은 이번 기간 최고 훈련 포인트 달성 시의 훈련 포인트와 클리어 정보를 표시하며, 초기화는 순위에 영향을 주지 않고 클리어 편성 정보 표시에도 영향을 주지 않습니다.\n·「응급 영지체」를 사용하여 도전을 클리어해 획득한 훈련 포인트는 특별 표시되며 랭킹에 반영되지 않습니다."
  },
  LanguageConfig_AbyssChallengeTips_CN = {
    Text = "<Title:「융재금지구역」>\n· 융재금지구역은 난이도가 높은 플레이 시스템입니다. 수호자는 여러 도전 팀을 유연하게 편성하여 가능한 한 많은 특훈치를 획득하고, 더 많은 보상을 받아야 합니다.\n\n<Title:「금지구역 기본 규칙」>\n· 융재금지구역은 총 5개의 웨이브로 나뉘며, 각 웨이브에는 난이도가 다른 스테이지가 포함되어 있습니다.\n· 스테이지를 클리어하면 해당하는 수량의 특훈치를 획득할 수 있으며, 자세한 내용은 스테이지 상세 화면에서 확인할 수 있습니다.\n· 특훈치가 지정 요구치에 도달하면 「은심」과 「검은 인장」을 수령할 수 있을 뿐만 아니라, 희귀 물자인 「원초 영핵」 「정수 원초 영핵」도 획득할 수 있습니다! 이것은 미사그 지하 블랙풀에서 산출되는 신비한 영핵으로, 깨어남체의 레벨 상한을 최대 80레벨까지 올릴 수 있습니다!\n· 「융재금지구역」은 주기적으로 스테이지 내용과 보상이 갱신되며, 일반적으로 14일마다 한 번 갱신됩니다. 해당 기간이 종료되면 수령하지 않은 보상은 받을 수 없으니, 수호자 님은 잊지 말고 완료 및 수령해 주세요.\n\n<Title:「금지구역 특수 규칙」>\n· 융재금지구역에는 고유한 제한 법칙이 있습니다: 동일한 깨어남체와 열쇠령, 동명의 운명의 바퀴는 중복 출전할 수 없으며, 수호자는 초기 유물, 적 및 권장 레벨에 따라 이번 도전 파티를 유연하게 선택할 수 있습니다.\n· 도전을 완료한 후, 더 나은 편성 방안이 있다면 「초기화」 기능을 사용하여 해당 스테이지의 도전 파티를 초기화할 수 있습니다. 초기화 후 깨어남체, 열쇠령, 운명의 바퀴 모두 다시 출전할 수 있지만, 해당 스테이지에서 획득한 특훈치도 차감됩니다(보상 상태에는 영향 없음).\n· 「융재금지구역」에서는 조력을 1회 사용할 수 있으며, 조력 깨어남체와 운명의 바퀴는 제한 법칙의 영향을 받지 않습니다. 조력 깨어남체가 포함된 도전 파티를 초기화할 경우, 조력 횟수 1회도 반환됩니다.\n\n<Title:「랭킹」>\n· 이번 시즌과 지난 시즌의 특훈치 랭킹 및 다른 수호자의 융재금지구역 클리어 정보를 확인할 수 있어, 수호자에게 참고 정보를 제공합니다.\n· 랭킹에는 이번 시즌 최고 특훈치 달성 시의 특훈치와 클리어 정보가 표시되며, 초기화는 순위에 영향을 주지 않고 클리어 편성 정보 표시에도 영향을 주지 않습니다."
  },
  LanguageConfig_AbyssChallengeTitle_CN = {
    Text = "융재금지구역"
  },
  LanguageConfig_AbyssChallengeWeaponCanNotFight_CN = {
    Text = "해당 명륜은 다른 융재금지구역에서 사용 중입니다."
  },
  LanguageConfig_AbyssClearanceChallengeScore_CN = {
    Text = "완료한 특훈 점수"
  },
  LanguageConfig_AbyssExtraClearanceChallengeScore_CN = {
    Text = "추가 특훈 점수"
  },
  LanguageConfig_AchievementGet_CN = {
    Text = "업적 달성"
  },
  LanguageConfig_AchievementRewards_CN = {
    Text = "업적 보상"
  },
  LanguageConfig_ActivationResonance_Tips_CN = {
    Text = "공명 활성화 힌트"
  },
  LanguageConfig_ActiveSkill_CN = {
    Text = "스킬 활성화됨"
  },
  LanguageConfig_ActivityDescriptionTitle_CN = {
    Text = "이벤트 설명"
  },
  LanguageConfig_ActivityExtraDropTimes_CN = {Text = "무제한"},
  LanguageConfig_ActivityFull_CN = {
    Text = "활성 이온이 가득 찼습니다"
  },
  LanguageConfig_ActivityIsEnd_CN = {
    Text = "이벤트가 종료되었습니다."
  },
  LanguageConfig_ActivityLoginDays_CN = {
    Text = "{s1}일 로그인"
  },
  LanguageConfig_ActivityMarkHalfAYear_CN = {Text = "1주년"},
  LanguageConfig_ActivityMarkMouchetteCrossover_CN = {Text = "컬래버"},
  LanguageConfig_ActivityMarkOneAndAHalfYears_CN = {Text = "1.5주년"},
  LanguageConfig_ActivityMarkReturn_CN = {
    Text = "복귀 이벤트"
  },
  LanguageConfig_ActivityMarkTwoYears_CN = {Text = "2주년"},
  LanguageConfig_ActivityResonanceRules_CN = {
    Text = "1、이번 기간 한정 이벤트에는 전용 공명이 있으며, 공명 업그레이드 재료를 사용하여 공명 효과를 활성화할 수 있습니다. 공명은 조사 시 강력한 도움을 제공합니다.\n2、기간 한정 이벤트 기간 동안 지정된 미션를 완료하면 공명 업그레이드 재료를 획득할 수 있습니다.\n3、지도 내에 공명 노드가 등장하며, 공명 노드로 이동하면 이번 탐색에서 공명 효과를 얻을 수 있습니다."
  },
  LanguageConfig_ActivityRewardNotReceived_CN = {
    Text = "<Receive:수령 가능>"
  },
  LanguageConfig_ActivityRewardReceived_CN = {
    Text = "<Claimed:수령 완료>"
  },
  LanguageConfig_ActivityRewardTitle_CN = {
    Text = "업적 보상"
  },
  LanguageConfig_ActivityRewardday_CN = {
    Text = "<DayTime:제{s1}일>"
  },
  LanguageConfig_ActivityShopIsEnd_1_CN = {
    Text = "{s1}일 {s2}시간 후에 교환이 종료됩니다."
  },
  LanguageConfig_ActivityShopIsEnd_2_CN = {
    Text = "{s1}시간 {s2}분 후에 교환이 종료됩니다."
  },
  LanguageConfig_ActivitySignReceiveRewardTimeLabel_CN = {
    Text = "남은 깨어남 횟수: {remaining_awakenings}"
  },
  LanguageConfig_ActivityStageMadnessChallengeTips_CN = {
    Text = "광란 난이도에서는 최초 클리어 보상만 획득할 수 있습니다."
  },
  LanguageConfig_ActivityStartTrial_CN = {
    Text = "체험 시작"
  },
  LanguageConfig_ActivityTaskGroupOpenCountDownFormat_CN = {
    Text = "해제까지 {s1}일 {s2}시간 {s3}분"
  },
  LanguageConfig_ActivityTaskTotalFinished_CN = {
    Text = "상시 훈련 미션 완료"
  },
  LanguageConfig_ActivityTaskWeeklyTitle_CN = {
    Text = "주간 시련"
  },
  LanguageConfig_ActivityTimeCountdown_2_CN = {
    Text = "{s1}시간 {s2}분 후 종료"
  },
  LanguageConfig_ActivityTimeCountdown_CN = {
    Text = "{s1}일 {s2}시간 후 종료"
  },
  LanguageConfig_ActivityTimeExpired_CN = {Text = "만료됨"},
  LanguageConfig_ActivityTimePermanent_CN = {Text = "영구"},
  LanguageConfig_ActorString_Sort_Ascend_CN = {
    Text = "오름차순"
  },
  LanguageConfig_ActorString_Sort_Descend_CN = {
    Text = "내림차순"
  },
  LanguageConfig_Actor_Skill_Upgrade_MaxLeve_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_AffixConnect_CN = {Text = "의"},
  LanguageConfig_AfterTheNth_CN = {
    Text = "{s1}위 이하"
  },
  LanguageConfig_AlchemyDecomposeCostItemNotEnoughTip_CN = {
    Text = "분해에 필요한 물자가 부족하여 분해할 수 없습니다"
  },
  LanguageConfig_AlchemyDecomposeEmptyResultTips_CN = {
    Text = "정답을 입력해주세요"
  },
  LanguageConfig_AlchemyDecomposeItemRuleContent_CN = {
    Text = "1、수호자는 여기서 재료를 분해할 수 있으며, 분해 후에는 복구할 수 없으니 수호자는 신중하게 선택하시기 바랍니다.\n2、재료 분해의 구체적인 산출물은 화면에서 확인할 수 있습니다."
  },
  LanguageConfig_AlchemyDecomposeSelectLimitTips_CN = {
    Text = "분해할 아이템 수량이 최대치에 도달했습니다"
  },
  LanguageConfig_AlchemyDecomposeTrinketConfirmTIps_CN = {
    Text = "분해 대상 목록에 <Blue:중첩된 비밀 계약>이 포함되어 있으며, 이는 아이템 가치가 높습니다. 분해를 확정하실타래 경우 입력창에 문제에 대한 <Blue:정답>을 적고 확인을 누르면 분해가 진행됩니다."
  },
  LanguageConfig_AlchemyDecomposeTrinketLockTip_CN = {
    Text = "선택한 비밀 계약이 잠겨 있습니다."
  },
  LanguageConfig_AlchemyDecomposeTrinketRuleContent_CN = {
    Text = "1. 수호자는 여기서 비밀 계약 분해를 진행할 수 있습니다. 분해 후에는 복구할 수 없으므로, 신중하게 선택하시기 바랍니다. \n2. 분해할 명륜에 강화된 비밀 계약이 포함되어 있을 경우, 분해 시 수호자가 인증을 완료해야만 분해할 수 있습니다.\n3. 현재 「편성」, 「비밀 계약 프리셋」 또는 「조력 깨어남체」에서 사용 중인 비밀 계약은 분해할 수 없습니다."
  },
  LanguageConfig_AlchemyDecomposeWeaponConfirmTIps_CN = {
    Text = "분해 대상 목록에 <Blue:SSR 명륜 또는 중첩된 명륜>이 포함되어 있으며, 아이템 가치가 높습니다. 분해가 명확하다면 입력란에 <Blue:확인>을 입력하고 확인을 선택하면 분해가 진행됩니다."
  },
  LanguageConfig_AlchemyDecomposeWeaponLockTip_CN = {
    Text = "선택한 명륜이 잠겨 있습니다."
  },
  LanguageConfig_AlchemyDecomposeWeaponRuleContent_CN = {
    Text = "1. 수호자는 여기서 명륜 분해를 진행할 수 있습니다. 분해 후에는 복구할 수 없으므로, 신중하게 선택하시기 바랍니다.\n2. 분해할 명륜에 SSR급 명륜 또는 이미 중첩된 명륜이 포함되어 있을 경우, 분해 시 수호자가 인증을 완료해야만 분해할 수 있습니다.\n3. 현재 「편성」이나 「조력 깨어남체」에서 사용 중인 명륜은 분해할 수 없습니다."
  },
  LanguageConfig_AlchemyDecomposeWrongResultTips_CN = {
    Text = "잘못 입력하셨습니다, 다시 입력해 주세요."
  },
  LanguageConfig_AlchemyWorkshop_CN = {
    Text = "연금실타래"
  },
  LanguageConfig_AlertBossKilled_CN = {
    Text = "모든 원초의 눈의 분신이 소멸되었습니다. 더 이상 도전할 수 없습니다."
  },
  LanguageConfig_AlertForceAssist_CN = {
    Text = "조력 깨어남체가 배치되지 않았습니다. 조사를 시작할 수 없습니다."
  },
  LanguageConfig_AllAchievement_CN = {
    Text = "업적/전체 업적"
  },
  LanguageConfig_AllAwakerAwaked_CN = {
    Text = "모든 깨어남체가 이미 깨어남되었습니다"
  },
  LanguageConfig_AlreadyGot_CN = {Text = "획득"},
  LanguageConfig_Aoerlagongminglianluo1_CN = {
    Text = "합성할 시를 선택할 수 있습니다."
  },
  LanguageConfig_Aoerlagongminglianluo2_CN = {
    Text = "업그레이드할 이미지를 선택할 수 있습니다."
  },
  LanguageConfig_AppointTaskRewardAddTag_CN = {Text = "추가"},
  LanguageConfig_ArchiveCollectionRewardsTitle_CN = {
    Text = "수집 보상"
  },
  LanguageConfig_AssistAwakerSortTypeAttentionTime_CN = {
    Text = "팔로잉 시간"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerLevel_CN = {
    Text = "깨어남체 레벨"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerPotency_CN = {
    Text = "깨어남체 기령"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerSkill_CN = {
    Text = "깨어남체 스킬"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerTalentLv_CN = {
    Text = "특성 레벨"
  },
  LanguageConfig_AssistAwakerSortTypeTrinketCompletion_CN = {
    Text = "비밀 계약 완성도"
  },
  LanguageConfig_AssistAwakerSortTypeWeaponPotency_CN = {
    Text = "명륜 중첩 레벨"
  },
  LanguageConfig_AssistanceSystemIntroduction_CN = {
    Text = "· 수호자는 1명의 깨어남체를 선택하여 조력 캐릭터로 참전시킬 수 있으며, 상호 팔로우한 수호자들은 융식의 폐허, 금지된 기록, 환몽 심잠에서 조력 깨어남체를 사용하여 출전할 수 있습니다. \n· 다른 수호자가 당신의 조력 깨어남체로 조사에 성공할 때마다, 장미 금권*1000을 보상으로 획득할 수 있으며, 매일 최대 20번까지 보상을 받을 수 있습니다. \n·장미 금권 보상이 50회 누적되었을 경우, 수호자는 먼저 보상을 수령해야만 계속해서 조력 보상을 받을 수 있습니다."
  },
  LanguageConfig_AssistanceSystemTitle_CN = {
    Text = "조력 규칙"
  },
  LanguageConfig_AutoBattleClose_CN = {
    Text = "미활성화"
  },
  LanguageConfig_AutoBattleOpen_CN = {
    Text = "활성화됨"
  },
  LanguageConfig_AutoBattleTxt_CN = {
    Text = "자동 전투"
  },
  LanguageConfig_AutoFightForbid_CN = {
    Text = "자동 전투는 고난이도 전투에서 사용할 수 없습니다. 스스로의 전략으로 통과하세요."
  },
  LanguageConfig_AutocConversion_Title_CN = {
    Text = "「천면 인장」을 선택하여 재료를 변환"
  },
  LanguageConfig_AwakerAchievement_CN = {
    Text = "업적/깨어남체 업적"
  },
  LanguageConfig_AwakerAssistRuleTitle_CN = {
    Text = "조력 규칙"
  },
  LanguageConfig_AwakerAssistRule_CN = {
    Text = "· 융식의 폐허, 금지된 기록, 환몽 심잠, 초월적 존재 등을 플레이할 때, 상호 팔로우한 수호자의 조력 깨어남체 1명을 선택하여 출전할 수 있습니다.\n· 조력 깨어남체는 현재 팀의 영역 제한을 충족해야 하며, 조건에 맞지 않는 조력 깨어남체는 출전할 수 없습니다. 수호자는 배치를 조정한 후 다시 출전시킬 수 있습니다.\n· 일부 이벤트에는 추가적인 특수 조력 규칙이 있을 수 있습니다. 자세한 내용은 해당 이벤트의 「이벤트 설명」을 확인하기 바랍니다."
  },
  LanguageConfig_AwakerChipChestPreviewTitle_CN = {
    Text = "깨어남체 파편 미리보기"
  },
  LanguageConfig_AwakerChipSelectTitle_CN = {
    Text = "깨어남체 파편 선택"
  },
  LanguageConfig_AwakerChipTypeName_CN = {
    Text = "깨어남체 파편"
  },
  LanguageConfig_AwakerColletion_CN = {
    Text = "깨어남체 필터"
  },
  LanguageConfig_AwakerDetailButton_CN = {
    Text = "상세 정보"
  },
  LanguageConfig_AwakerFavorBreakThroughPopTip_CN = {
    Text = "「동심의 증표」× 1 을 사용하여 영육 동조를 진행하시겠습니까?"
  },
  LanguageConfig_AwakerFavorBreakThroughSuccessTip_CN = {
    Text = "영육 동조"
  },
  LanguageConfig_AwakerFavorBreakThrough_CN = {
    Text = "영육 동조"
  },
  LanguageConfig_AwakerFavorImproveActivity_CN = {
    Text = "이벤트 보너스"
  },
  LanguageConfig_AwakerFavorImproveAssist_CN = {
    Text = "조력 사용"
  },
  LanguageConfig_AwakerFavorImproveBase_CN = {
    Text = "동조율 기본 보상"
  },
  LanguageConfig_AwakerFavorImproveFirst_CN = {
    Text = "첫 클리어"
  },
  LanguageConfig_AwakerFavorImproveResonance_CN = {
    Text = "공명 보너스"
  },
  LanguageConfig_AwakerFavorability_Description_Detail_CN = {
    Text = "<Title:【동조율 획득】>\n·조사 작전, 특파 기록, 의식 잠항, 환몽심잠 등의 단계를 클리어한 후, 출전한 각성체는 동조율을 획득할 수 있습니다.\n·각성체가 카드를 많이 낼수록, 행동력과 광기를 많이 소모할수록 더 많은 동조율을 획득합니다. 단계 추천 레벨이 높을수록 더 많은 동조율을 획득합니다.\n·수호자의 은열쇠 에너지 소모가 많을수록, 출전한 각성체가 획득하는 동조율도 많아집니다.\n·수동 전투 중 획득하는 동조율은 「자동 전투」 활성화 시의 3배입니다.\n·조력자를 사용하여 단계를 클리어한 후, 수호자의 출전 각성체가 획득하는 동조율이 50% 증가합니다.\n·각성체를 기숙사에 초대한 후, 5분마다 동조율 1점을 획득할 수 있습니다.\n·오프라인 저장량이 300점을 초과하면 획득 속도가 15분당 1점으로 감소하며, 최대 3000점까지 저장할 수 있습니다.\n\n<Title:【동조율 레벨】>\n·각성체의 동조율을 모아 동조율 레벨을 올릴 수 있으며, 레벨이 높을수록 더 많은 각성체의 음성과 스토리를 해금할 수 있습니다. 일부 레벨에서는 「무구의 은핵」을 획득할 수 있습니다.\n·각성체 동조율이 Lv15에 도달한 후, 「영육 동조」를 통해 「동심의 증표」를 소모하여 레벨 상한을 단계적으로 Lv20까지 올릴 수 있으며, 레벨마다 「영핵 파편」×5를 획득할 수 있고, Lv20 달성 시 「광채」를 추가로 획득할 수 있습니다.\n·각성체 동조율이 현재 레벨 상한에 도달하면 더 이상 누적되지 않으며, 영육 동조를 먼저 완료해야 계속 획득할 수 있습니다."
  },
  LanguageConfig_AwakerFavorability_Description_Title_CN = {
    Text = "동조율 설명"
  },
  LanguageConfig_AwakerFavorability_Str_LvUp_CN = {
    Text = "{s1}의 동조율이 {s2}(으)로 상승했습니다."
  },
  LanguageConfig_AwakerFormConflict_CN = {
    Text = "배치 불가"
  },
  LanguageConfig_AwakerFragment_CN = {
    Text = "{s1}의 파편"
  },
  LanguageConfig_AwakerHasColletion_CN = {
    Text = "필터 적용됨"
  },
  LanguageConfig_AwakerLevelLimitIncreaseTo_CN = {
    Text = "깨어남체 최대 레벨이 {s1}레벨로 상승하여, 추가로 레벨을 상승시킬 수 있습니다."
  },
  LanguageConfig_AwakerLevelMaxSelectTips_CN = {
    Text = "{s1}은(는) 계령 레벨 한도에 도달했습니다. 선택한 아이템을 변경해 주세요"
  },
  LanguageConfig_AwakerMaxLevelBtnPreview_CN = {
    Text = "{s1}급 미리 보기"
  },
  LanguageConfig_AwakerNotObtained_CN = {
    Text = "깨어남체 미획득"
  },
  LanguageConfig_AwakerOverflowCraftLimitTips_CN = {
    Text = "횟수는 과거 깨어남체 초과 기록에서 비롯됩니다. 해당 횟수는 잠금값으로, 사용 후 복구할 수 없습니다."
  },
  LanguageConfig_AwakerPoolGroupBtnTip_1_CN = {
    Text = "클릭하여 지정된 깨어남체 변경"
  },
  LanguageConfig_AwakerPoolGroupTitle_1_CN = {
    Text = "삼상의 균형"
  },
  LanguageConfig_AwakerPoolGroupTitle_8_CN = {
    Text = "추억이 잊혀지기 전에"
  },
  LanguageConfig_AwakerPotencyBtnText_CN = {Text = "활성화"},
  LanguageConfig_AwakerPreviewTitle_CN = {
    Text = "깨어남체 미리보기"
  },
  LanguageConfig_AwakerRandomChestTipTitle_CN = {
    Text = "랜덤으로 깨어남체 획득"
  },
  LanguageConfig_AwakerRandomSelectTitle_CN = {
    Text = "랜덤 깨어남체 획득"
  },
  LanguageConfig_AwakerSelectPreviewDetailTips_CN = {
    Text = "깨어남체를 클릭하여 상세 정보 확인"
  },
  LanguageConfig_AwakerSelectTitle_CN = {
    Text = "선택된 깨어남체"
  },
  LanguageConfig_AwakerSelectUseDetailTips_CN = {
    Text = "길게 눌러 깨어남체 상세 정보를 확인하세요"
  },
  LanguageConfig_AwakerSkillExaltTips_CN = {
    Text = "소모 광기: {s1}"
  },
  LanguageConfig_AwakerSkillUpgradeTips_CN = {
    Text = "승격 등급을 {s1}로 올려 레벨을 더 상승시킬 수 있습니다"
  },
  LanguageConfig_AwakerSkillValueTips_CN = {
    Text = "소비 행동력: {s1}"
  },
  LanguageConfig_AwakerSkinTypeName_CN = {Text = "의상"},
  LanguageConfig_AwakerSkin_CN = {Text = "의상"},
  LanguageConfig_AwakerStateInformation_CN = {
    Text = "상세 정보"
  },
  LanguageConfig_AwakerStoryAge_CN = {Text = "나이"},
  LanguageConfig_AwakerStoryBasicI_CN = {
    Text = "기본 정보"
  },
  LanguageConfig_AwakerStoryBirth_CN = {Text = "생일"},
  LanguageConfig_AwakerStoryEpithet_CN = {Text = "칭호"},
  LanguageConfig_AwakerStoryGender_CN = {Text = "성별"},
  LanguageConfig_AwakerStoryHeight_CN = {Text = "신장"},
  LanguageConfig_AwakerStoryIcon_CN = {Text = "스토리"},
  LanguageConfig_AwakerStoryKnowsIndex_CN = {
    Text = "영성 지수"
  },
  LanguageConfig_AwakerStoryNameEn_CN = {
    Text = "영문 이름"
  },
  LanguageConfig_AwakerStoryName_CN = {Text = "이름"},
  LanguageConfig_AwakerStoryWeight_CN = {Text = "체중"},
  LanguageConfig_AwakerTagName_CN = {Text = "특성"},
  LanguageConfig_AwakerTrialActivityTitle_CN = {
    Text = "깨어남체 체험"
  },
  LanguageConfig_AwakerTrinketStrengthenBtnText_CN = {Text = "강화"},
  LanguageConfig_AwakerTypeName_CN = {
    Text = "깨어남체"
  },
  LanguageConfig_AwakerUpgradeBtnText_CN = {
    Text = "업그레이드"
  },
  LanguageConfig_AwakerUpgradeButton_CN = {Text = "레벨 업"},
  LanguageConfig_AwakerUpgradeMaterialCompose_CN = {
    Text = "소재 합성"
  },
  LanguageConfig_AwakerUpgradeMaxBtnText_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_AwakerUseTimesLimitTips_CN = {
    Text = "* 클리어 후, 출전한 깨어남체는 오늘 하루 동안 해당 이벤트에서 사용할 수 없습니다."
  },
  LanguageConfig_AwakerVoiceIcon_CN = {Text = "음성"},
  LanguageConfig_AwakerWeaponSelectDetail_CN = {
    Text = "상세 정보"
  },
  LanguageConfig_Awaker_LevelUp_Success_CN = {
    Text = "레벨 상승"
  },
  LanguageConfig_Awaker_Select_Get_Tips1_CN = {
    Text = "체험 깨어남체 선택"
  },
  LanguageConfig_Awaker_Select_Get_Tips2_UP_CN = {
    Text = "최대 2개의 깨어남체를 선택하세요"
  },
  LanguageConfig_Awaker_Type_Assist_CN = {Text = "보조형"},
  LanguageConfig_Awaker_Type_Atk_CN = {Text = "공격형"},
  LanguageConfig_Awaker_Type_Def_CN = {Text = "방어형"},
  LanguageConfig_AwardNodeGetItemButton_CN = {Text = "확인"},
  LanguageConfig_AwardNodeGetItemTitle_CN = {
    Text = "아이템 획득"
  },
  LanguageConfig_BPAdvanceBuyConfirmTipBottomDesc_CN = {
    Text = "<Blue:{s1}> 원액을 소모하여 구매하시겠습니까?"
  },
  LanguageConfig_BPAdvanceBuyConfirmTipTopDesc_CN = {
    Text = "구매 후 해당 기간 동안 「일일 시험 훈련」에서 받지 못한 일부 보상을 소급하여 지급합니다."
  },
  LanguageConfig_BPAwardTab_CN = {Text = "보상"},
  LanguageConfig_BPBoxTab_CN = {
    Text = "선물 상자"
  },
  LanguageConfig_BPBuyLevelTxt_CN = {
    Text = "<size=30><color=#ffffff>구매 후 </color></size>%d<size=34><color=#ffffff>레벨로 상승하여, 다음 보상을 얻을 수 있습니다"
  },
  LanguageConfig_BPChargeSuccessfulTips_CN = {
    Text = "구매 성공"
  },
  LanguageConfig_BPChooseColectDirectlyBtn_CN = {
    Text = "직접 수령"
  },
  LanguageConfig_BPChooseConfirmBtn_CN = {Text = "확인"},
  LanguageConfig_BPChooseNextBtn_CN = {Text = "다음"},
  LanguageConfig_BPChooseSelectHint_CN = {
    Text = "원하는 보상을 선택하세요"
  },
  LanguageConfig_BPExpWeeklyLimitTxt_CN = {
    Text = "이번 주 과제 경험치 획득량이 최대치에 도달했습니다"
  },
  LanguageConfig_BPExpireTips_CN = {
    Text = "새 학기 과제 기록이 업데이트되었습니다"
  },
  LanguageConfig_BPExtraLvAwardTxt_CN = {
    Text = "추가 보상"
  },
  LanguageConfig_BPLevelLimitTxt_CN = {
    Text = "축하합니다! 과제 레벨이 최대에 도달했습니다."
  },
  LanguageConfig_BPMultiChooseLastHint_CN = {
    Text = "마지막 보상입니다"
  },
  LanguageConfig_BPMultiChooseTitleNum_CN = {
    Text = "({s1}/{s2})"
  },
  LanguageConfig_BPMultiChooseTitle_CN = {
    Text = "획득할 보상을 선택하세요"
  },
  LanguageConfig_BPNewOpenContent_CN = {
    Text = "새로운 학기 과제가 시작되었습니다!\n과제 미션을 완료하고, 과제 레벨을 상승시켜 풍성한 보상을 수령하세요!"
  },
  LanguageConfig_BPNewOpenTitle_CN = {
    Text = "신규 과제 오픈"
  },
  LanguageConfig_BPOpenPreviewTxt_CN = {
    Text = "{s1}일 {s2}시간 후 신규 과제 개시"
  },
  LanguageConfig_BPRuleTxt2_CN = {
    Text = "\n\n<Title:[특별 과제]>\n·본 과제 기간은 {s1} - {s2} (GMT+8)이며, 과제를 완료하면 2배의 과제 경험치를 획득하여 과제 레벨을 빠르게 높일 수 있습니다."
  },
  LanguageConfig_BPRuleTxt_CN = {
    Text = "<Title:[과제 종류]>\n·매 회차 기본 과제는 별도 해금 없이 바로 참여할 수 있으며, 수호자는 프리미엄 과제를 해제하여 더 풍성한 보상을 획득할 수 있습니다.\n·일반적으로 각 회차 과제는 28일간 진행됩니다. 다만 미사그는 때때로 더 짧은 기간 동안 특별 과제를 오픈하기도 하는데, 특별 과제 기간 동안 획득하는 과제 경험치는 모두 2배로 적용되어 수호자가 더욱 빠르게 과제를 완료할 수 있습니다!\n \n·28일간 진행되는 과제:\n  ·「프리미엄 과제」 해제에 「원액」×680 필요, 즉시 「은심」×680 획득.\n  ·「핵심 과제」 해제에 「원액」×1280 필요, 즉시 「은심」×1460 획득.\n  ·「프리미엄 과제」를 「핵심 과제」로 업그레이드하는 데 「원액」×780 필요, 즉시 「은심」×780 획득.\n \n·특별 과제:\n  ·과제 진행 중 획득하는 「과제 경험치」 2배로 증가.\n  ·「프리미엄 과제」 해제에 「원액」×680 필요, 즉시 「은심」×680 획득.\n  ·「핵심 과제」 해제에 「원액」×980 필요, 즉시 「은심」×1070 획득.\n  ·「프리미엄 과제」를 「핵심 과제」로 업그레이드하는 데 「원액」×390 필요, 즉시 「은심」×390 획득.\n\n<Title:[핵심 과제 특권]>\n·「핵심 과제」 해제 시, 해당 회차 과제 진행 기간 동안 특권이 부여됩니다.\n·「일일 훈련」의 「기초 활성 이온」 누적 보상에서 획득하는 「현실타래의 시작점」, 「퓨어 코어」, 「경험」, 「은심」이 3배로 증가합니다. 「핵심 과제」 구매 후 이번 회차에 이미 수령한 「기초 활성 이온」 누적 보상의 추가 배율 부분이 소급 지급됩니다.\n·전투 중 「시간 역행」을 사용해 이전 턴으로 되돌아갈 수 있습니다.\n·「위상 대인전」에서 모든 카드를 한시적으로 해제할 수 있습니다.\n\n<Title:[과제 레벨]>\n·수호자는 비경 교실타래의 일일 훈련과 주간 훈련을 완료하여 과제 경험치를 획득하고, 과제 레벨을 올려 풍성한 보상을 받을 수 있습니다.\n·「일일 훈련」은 9시에 리프레시되며, 「주간 훈련」은 매주 월요일 9시(GMT+8)에 리프레시됩니다.\n·과제 레벨이 50레벨에 도달한 이후로는 1레벨 상승 시마다 추가 보상을 1개씩 획득할 수 있습니다."
  },
  LanguageConfig_BPSingleChooseTitle_CN = {
    Text = "획득할 보상을 선택하세요"
  },
  LanguageConfig_BPTaskSubTabDaily_CN = {
    Text = "일일 미션"
  },
  LanguageConfig_BPTaskSubTabMonthly_CN = {
    Text = "주간 미션"
  },
  LanguageConfig_BPTaskSubTabPeriod_CN = {
    Text = "학기 미션"
  },
  LanguageConfig_BPTaskTab_CN = {Text = "미션"},
  LanguageConfig_BPTimeFormat_CN = {
    Text = "이번 시즌 남은 시간: {s1}"
  },
  LanguageConfig_BackTrack_CN = {Text = "회고"},
  LanguageConfig_BacktrackAwaker_Rules_CN = {
    Text = "<Title:[육성 초기화]>\n· 육성 초기화는 각 깨어남체의 모든 업그레이드, 승격, 스킬, 영지 심화 상태를 초기화하며, 소모된 재료와 금권은 모두 반환됩니다.\n· 깨어남체가 소모한 모든 승격 재료는 같은 양과 등급의 「초급 승격 상자」, 「중급 승격 상자」, 「고급 승격 상자」로 반환됩니다. \n· 깨어남체가 소모한 모든 스킬 재료는 같은 양과 등급의 「초급 스킬 보급 상자」, 「중급 스킬 보급품 상자」, 「고급 스킬 보급 상자」로 반환됩니다. \n· 깨어남체가 소모한 모든 「행운의 사탕」, 「밀랍상 점토 」, 「칠흑의 족쇄」, 「차원 결정」, 「성심의 경건함」은 30배 수량의 「모방 결정체」 로 반환됩니다.\n<Title:[계령 초기화]>\n· 깨어남체의 계령 상태를 초기화하며, 계령으로 상승한 최대 레벨 또한 초기화됩니다. 소모된 재료는 모두 반환됩니다.\n· 깨어남체가 소모하거나 사용하지 않은 계령 파편은 획득 출처에 따라 각각 다른 아이템으로 반환됩니다.\n· 「근원의 시야」를 통해 획득한 경우, 「근원의 시야」로 반환됩니다.\n· 한정 깨어남으로 획득한 한정 깨어남체에게서 변환된 경우, 「영혼 회수의 핵」으로 반환됩니다.\n· 「돌」「오지에」「로탄」은 「조사 배지」 2500개로 반환됩니다.\n· 「라모나」「회귀·라모나」는 「파편·라모나」로 반환됩니다.\n·「아이기스」「오레타」「에리카」는 「융식의 구슬」 8000개로 반환됩니다.\n· 기타 방식으로 획득한 경우, 「원질의 낙원」으로 반환됩니다.\n<Title:[블랙풀 회귀]>\n· 「육성 초기화」의 모든 효과에 더해, 깨어남체 자체를 초기화하여 획득하지 않은 상태로 되돌립니다.\n· 깨어남체에게 장착된 명륜과 비밀 계약은 모두 해제되며, 프로필 아이콘은 사용 불가 상태가 되고, 사용 중이라면 기본 아바타로 변경됩니다.\n· 깨어남체의 승격 보상 수령 상태, 동조율 및 동조율 보상 수령 상태는 모두 유지되며, 해당 깨어남체를 다시 획득할 때 계승됩니다.\n· 깨어남체 자체는 출처에 따라 각각 다른 아이템으로 반환됩니다. 한정 깨어남으로 획득한 한정 깨어남체는 「영혼 회귀의 핵」으로 반환되며, 기타 방식으로 획득한 경우 「원질의 낙원」으로 반환됩니다.\n<Title:[아이템 설명]>\n· 「초급 승격 상자」: 사용 시 순백의 조각, 연마된 본능, 기억 복사본, 인식 템플릿 중 1개 선택 가능.\n· 「중급 승격 상자」：사용 시 순백의 문서, 연마된 이성, 감정 복사본, 정신 템플릿 중 1개 선택 가능.\n· 「고급 승격 상자」：사용 시 순백의 비편, 연마된 영혼, 의식 복사본, 영지 템플릿 중 1개 선택 가능.\n· 「초급 스킬 보급」: 사용 시 희미한 수정나비, 낮은줄기 바다백합, 마른 번데기, 부서진 광석 중 1개 선택 가능.\n· 「중급 스킬 보급품」: 사용 시 빛나는 수정 나비, 높은줄기 바다백합, 원생 번데기, 유성의 파편 중 1개 선택 가능.\n· 「고급 스킬 보급」：사용 시 혼돈의 결정 나비, 유인타 백합, 포자 중합체, 유카탄의 별 중 1개 선택 가능.\n· 「근원의 시야」：사용 시 획득한 SSR 캐릭터 깨어남체 파편 중 1개 선택 가능.\n·「원질의 낙원」: 사용 시 「영역 탐구」 에서 지정 가능한 깨어남체 1개 선택 가능.\n· 「영혼 회귀의 핵」: 사용 시 「영역 탐구」, 과거 캐릭터 이벤트 깨어남, 현재 이벤트 깨어남체 중 1개 선택 가능."
  },
  LanguageConfig_BacktrackCannotSkipTips_CN = {
    Text = "현재 조사 중이므로 이동할 수 없습니다."
  },
  LanguageConfig_BacktrackRedirectHint_CN = {
    Text = "해제하러 가기"
  },
  LanguageConfig_BacktrackRichText1_CN = {
    Text = "남은 횟수 {s1}"
  },
  LanguageConfig_BacktrackRichText2_CN = {
    Text = "남은 횟수 <color=#FF0000>{s1}</color>"
  },
  LanguageConfig_BacktrackTimesLeft_CN = {
    Text = "육성 초기화 기능은 {s1} 후에 비활성화됩니다."
  },
  LanguageConfig_BacktrackTips1_CN = {
    Text = "한정 깨어남체는 「육성 초기화」만 진행할 수 있습니다."
  },
  LanguageConfig_BacktrackTips2_CN = {
    Text = "「육성 초기화」 또는 「계령 초기화」후에는 「블랙풀 회귀」가 불가능합니다."
  },
  LanguageConfig_BacktrackTips3_CN = {
    Text = "한정 깨어남체는 「블랙풀 회귀」를 진행할 수 없습니다."
  },
  LanguageConfig_BacktrackWeapon_Rules_CN = {
    Text = "<Title:[중첩 초기화]>\n· 명륜의 모든 중첩 상태가 초기화되며, 사용한 재료가 전부 반환됩니다.\n·「순환 모본」으로 활성화한 중첩은 「순환 모본」으로 반환됩니다. 한정 깨어남에서 획득한 한정 명륜으로 활성화된 중첩은 「운명 회귀의 핵」으로 반환됩니다. 그 외 방법으로 활성화한 중첩은 「회전의 책」로 반환됩니다.\n<Title:[블랙풀 환원]>\n·이 작업은 「육성 초기화」의 모든 효과에 더해, 명륜 자체도 초기화됩니다.\n· 한정 깨어남으로 획득한 한정 명륜은 「운명 회귀의 핵」으로 반환됩니다. 그 외 방법으로 획득한 명륜은 「회전의 책」로 반환됩니다.\n<Title:[아이템 설명]>\n·다음 아이템들은 물자 화면에서 사용 가능합니다.\n· 「순환 모본」：임의의 SSR 명륜의 중첩 재료로 사용할 수 있습니다.\n· 「회전의 책」: 사용 시 「로테이션의 형상」에 있는 SSR 명륜 중 1개를 선택할 수 있습니다.\n·「운명 회수의 핵」: 사용 시 「로테이션의 형상」, 과거 명륜 이벤트 및 현재 명륜 이벤트의 SSR 명륜 중 1개를 선택할 수 있습니다."
  },
  LanguageConfig_BagCapacity_CN = {
    Text = "수량 {s1}/{s2}"
  },
  LanguageConfig_BagEmptyTitle_CN = {
    Text = "{s1} 아이템 없음"
  },
  LanguageConfig_BagItemUseBtnText_CN = {Text = "사용"},
  LanguageConfig_BagKeeperSkillTitle_CN = {Text = "은열쇠"},
  LanguageConfig_BagMaterialEmptyDesc_CN = {
    Text = "조사 및 막간 훈련을 통해 획득 가능"
  },
  LanguageConfig_BagMaterialTitle_CN = {Text = "재료"},
  LanguageConfig_BagSpecialEmptyDesc_CN = {
    Text = "특정 경로를 통해 획득 가능"
  },
  LanguageConfig_BagSpecialTitle_CN = {Text = "소모품"},
  LanguageConfig_BagTitle_CN = {Text = "물자"},
  LanguageConfig_BagTrinketEmptyDesc_CN = {
    Text = "금지된 기록을 통해 획득 가능"
  },
  LanguageConfig_BagTrinketTitle_CN = {
    Text = "비밀 계약"
  },
  LanguageConfig_BagWeaponEmptyDesc_CN = {
    Text = "깨어남을 통해 획득 가능"
  },
  LanguageConfig_BagWeaponTitle_CN = {Text = "명륜"},
  LanguageConfig_BattleAchievement_CN = {
    Text = "업적/전투 업적"
  },
  LanguageConfig_BattleBuff_1_CN = {Text = "공격력"},
  LanguageConfig_BattleBuff_2_CN = {
    Text = "피해 증가"
  },
  LanguageConfig_BattleBuff_3_CN = {Text = "방어력"},
  LanguageConfig_BattleBuff_4_CN = {
    Text = "방어막 증가"
  },
  LanguageConfig_BattleBuff_5_CN = {
    Text = "촉수 피해"
  },
  LanguageConfig_BattleBuff_6_CN = {
    Text = "촉수 피해 증가"
  },
  LanguageConfig_BattlePassLeftTimeLess_CN = {
    Text = "{s1}시간 {s2}분"
  },
  LanguageConfig_BattlePassLeftTimeMore_CN = {
    Text = "{s1}일 {s2}시간"
  },
  LanguageConfig_BattlePassLevel_CN = {Text = "%d 레벨"},
  LanguageConfig_BattleSchoolEffectTipsTitle_CN = {
    Text = "영역 메커니즘"
  },
  LanguageConfig_BattleSim_Err_NoActor_CN = {
    Text = "캐릭터 칸이 비어 있어 전투에 진입할 수 없습니다"
  },
  LanguageConfig_BattleString_01_CN = {
    Text = "남은 턴 수: {s1}"
  },
  LanguageConfig_BattleString_02_CN = {
    Text = "행동력 부족, 명령 카드 사용 불가"
  },
  LanguageConfig_BattleTeachingEntryBtnTxt_CN = {
    Text = "훈련 시작"
  },
  LanguageConfig_BattleTeachingLabel_CN = {
    Text = "실타래전 강의"
  },
  LanguageConfig_BattleTeachingRuleDesc_CN = {
    Text = "1. 수호자 님은 해당 스테이지에서 관련 전투 내용을 학습하고 연습하실타래 수 있습니다.\n2. 수호자 님께서 해당 실타래전 강의 스테이지를 완료하실타래 경우, 「실타래전 강의」에서 보상을 수령할 수 있습니다."
  },
  LanguageConfig_BattleWaves_CN = {
    Text = "웨이브 {s1}/{s2}"
  },
  LanguageConfig_Battle_Begin_Boss_CHN_CN = {
    Text = "최고 경보"
  },
  LanguageConfig_Battle_Begin_CHN_CN = {
    Text = "전투 시작"
  },
  LanguageConfig_Battle_Begin_Elite_CHN_CN = {
    Text = "위험 경보"
  },
  LanguageConfig_Battle_BoutCount_CN = {
    Text = "전체 턴 수"
  },
  LanguageConfig_Battle_Btn_BeDamageInfo_CN = {
    Text = "적의 총 피해량"
  },
  LanguageConfig_Battle_Btn_GoldInfo_CN = {
    Text = "검은 인장"
  },
  LanguageConfig_Battle_Btn_TurnInfo_CN = {Text = "턴 수"},
  LanguageConfig_Battle_CardGroup_CN = {Text = "카드"},
  LanguageConfig_Battle_ChooseCardToHand_CN = {
    Text = "카드 {s1}장을 손패에 추가합니다"
  },
  LanguageConfig_Battle_ChooseCard_CN = {
    Text = "명령 카드 선택"
  },
  LanguageConfig_Battle_Cooldown_CN = {
    Text = "쿨다운 중"
  },
  LanguageConfig_Battle_DeathResist_CN = {
    Text = "죽음 저항"
  },
  LanguageConfig_Battle_Defeated_Title_CHN_CN = {
    Text = "전투 패배"
  },
  LanguageConfig_Battle_DisCardGroup_Str_CN = {
    Text = "버린 카드 더미({s1})"
  },
  LanguageConfig_Battle_Discard_Title_CN = {
    Text = "버린 카드 더미"
  },
  LanguageConfig_Battle_DrawCardGroup_Str_CN = {
    Text = "드로우 덱({s1})"
  },
  LanguageConfig_Battle_Draw_Title_CN = {
    Text = "드로우 덱"
  },
  LanguageConfig_Battle_Elite_Tips_CN = {Text = "고위험"},
  LanguageConfig_Battle_EndTurn_CHN_CN = {Text = "턴 종료"},
  LanguageConfig_Battle_EnemyTurn_Title_CHN_CN = {Text = "적군 턴"},
  LanguageConfig_Battle_Exhaust_Title_CN = {Text = "소모 덱"},
  LanguageConfig_Battle_ExtraTurn_Desc_CHN_CN = {
    Text = "초차원 워프!"
  },
  LanguageConfig_Battle_ExtraTurn_Desc_EN_CN = {
    Text = "초차원 상태로 진입하여, 초차원 깨어남체의 진정한 힘을 발휘합니다."
  },
  LanguageConfig_Battle_ExtraTurn_Title_CHN_CN = {Text = "추가 턴"},
  LanguageConfig_Battle_Gain_Card_CN = {Text = "획득"},
  LanguageConfig_Battle_Gain_Relic_CN = {Text = "획득"},
  LanguageConfig_Battle_GiveUp_Card_CN = {Text = "포기"},
  LanguageConfig_Battle_GiveUp_Relic_CN = {Text = "포기"},
  LanguageConfig_Battle_GiveUp_Stone_CN = {
    Text = "모든 전투에서 검은 인장 획득 포기"
  },
  LanguageConfig_Battle_PlayerTurn_Title_CHN_CN = {Text = "아군 턴"},
  LanguageConfig_Battle_RelicList_Title_CN = {
    Text = "보유한 유물"
  },
  LanguageConfig_Battle_ResonanceBuff_Str_CN = {Text = "공명"},
  LanguageConfig_Battle_State_Layer_CN = {Text = "{s1}스택"},
  LanguageConfig_Battle_Str_DeathResist_CN = {
    Text = "죽음 저항!"
  },
  LanguageConfig_Battle_Str_Round_CN = {Text = "턴"},
  LanguageConfig_Battle_Strengthen_Str_CN = {Text = "강화"},
  LanguageConfig_Battle_Threat_Save_CN = {Text = "안전"},
  LanguageConfig_Battle_Threat_Unknown_CN = {Text = "미지"},
  LanguageConfig_Battle_Tips_BeDamageInfo_CN = {
    Text = "이번 턴의 적이 가할 총 피해량입니다. 보호막을 획득하면 피해를 막을 수 있습니다."
  },
  LanguageConfig_Battle_Tips_Block_CN = {Text = "방어"},
  LanguageConfig_Battle_Tips_BloodName_CN = {
    Text = "배아 융합"
  },
  LanguageConfig_Battle_Tips_BloodTips_CN = {
    Text = "· 턴 시작 시 <CardKeyWord:배아 융합>이 20% (체력 손실타래에 따라 최대 40%까지) 증가하고, 100%에 도달하면 <CardKeyWord:배아> 1장을 손패에 추가합니다. \n· 혈육 영역의 광기 폭발은 <CardKeyWord:배아>를 소모하여 <CardKeyWord:포식> 효과를 발동시킵니다."
  },
  LanguageConfig_Battle_Tips_BoutCount_CN = {
    Text = "모든 전투의 총 턴 수."
  },
  LanguageConfig_Battle_Tips_DeathResist_CN = {
    Text = "전투 중 치명적인 피해를 받으면 일정 확률로 HP 1pt를 남긴다. 발동 후 다음 턴에 행동력 2pt를 얻고 카드를 2장 뽑으며, 팀의 <CardKeyWord:죽음 저항>이 절반으로 감소하고 이후 획득하는 <CardKeyWord:죽음 저항>도 절반으로 감소하며, 조사 종료까지 지속된다.\n혼돈 계역 깨어남체가 1명 이상 있으면, 초기 <CardKeyWord:죽음 저항> +100%."
  },
  LanguageConfig_Battle_Tips_DimensionName_CN = {
    Text = "초차원 공간"
  },
  LanguageConfig_Battle_Tips_DimensionTips_CN = {
    Text = "· 매 턴 첫 번째로 사용한 명령 카드의 임시 복사본이 <CardKeyWord:초차원 공간>에 추가되어 그 워프 효과를 발동합니다. \n· 초차원 공간이 가득 차면 추가 초차원 턴에 진입할 수 있으며, 해당 턴에는 일반적인 카드 뽑기를 하지 않고 대신 초차원 공간의 카드를 손패에 추가합니다. 초차원 턴에는 모든 워프 효과를 발동할 수 있습니다."
  },
  LanguageConfig_Battle_Tips_EffectEnd_CN = {
    Text = "{s1} 효과 종료"
  },
  LanguageConfig_Battle_Tips_EnergyInfo_CN = {
    Text = "시작 시 에너지 획득: [ene_init]\n에너지 자동 회복: [ene_passive]\n에너지 소모 감소: [ene_return]"
  },
  LanguageConfig_Battle_Tips_GoldInfo_CN = {
    Text = "보유한 검은 인장 수량입니다. 융식 흔적에서 유물과 각인을 교환할 수 있습니다. 적을 물리치거나 이벤트와 조우하여 검은 인장을 획득할 수 있습니다."
  },
  LanguageConfig_Battle_Tips_HpHeal_CN = {
    Text = "시작 시 에너지 획득: [ene_init]\n에너지 자동 회복: [ene_passive]\n에너지 소모 감소: [ene_return]"
  },
  LanguageConfig_Battle_Tips_HpHeal_Title_CN = {
    Text = "HP 자동 회복"
  },
  LanguageConfig_Battle_Tips_Immune_CN = {Text = "면역"},
  LanguageConfig_Battle_Tips_LuckyEnchant_CN = {
    Text = "전투 종료 후 각인을 획득하거나 상점에서 각인을 구매할 때, 고급 각인으로 강화될 확률이 있습니다."
  },
  LanguageConfig_Battle_Tips_MonsterDimensionTips_CN = {
    Text = "매 턴 첫 번째로 사용한 명령 카드의 임시 복사본이 차원 균열에 추가됩니다. 차원의 사냥개가 차원 폐쇄를 발동한 후, 다음 턴의 카드 뽑기를 건너뛰고 차원 균열에 있는 카드를 손패에 추가합니다."
  },
  LanguageConfig_Battle_Tips_PhiloStoneDropBonusesTips_CN = {
    Text = "전투 승리 후 적이 드롭하는 검은 인장 수량을 증가시킵니다."
  },
  LanguageConfig_Battle_Tips_PhiloStoneDropBonuses_CN = {
    Text = "검은 인장 드롭 보너스"
  },
  LanguageConfig_Battle_Tips_TentacleName_CN = {Text = "촉수"},
  LanguageConfig_Battle_Tips_TentacleTips_CN = {
    Text = "전투 시작 시 촉수 1개가 생성되며, 촉수는 턴 종료 시 맨 앞의 적을 공격합니다. \n적이 사망할 때마다 촉수 피해가 영구적으로 증가합니다."
  },
  LanguageConfig_Battle_Tips_TurnInfo_CN = {
    Text = "이번 전투에서 진행된 턴 수입니다. 적은 턴 수가 늘어남에 따라 점차 강해집니다."
  },
  LanguageConfig_Battle_Transcendent_Title_CN = {
    Text = "초차원 공간 활성화"
  },
  LanguageConfig_Battle_Uenergy_Float_CN = {
    Text = "{s1} 광기"
  },
  LanguageConfig_Battle_Win_Return_CN = {
    Text = "명령 카드 선택으로 돌아가기"
  },
  LanguageConfig_Battle_Win_Select1_CN = {
    Text = "선택됨: 0/1"
  },
  LanguageConfig_Battle_Win_Select2_CN = {
    Text = "선택됨: 0/2"
  },
  LanguageConfig_Battle_Win_SelectCard_CN = {
    Text = "명령 카드 선택"
  },
  LanguageConfig_Battle_Win_SelectRelic_CN = {
    Text = "유물 선택"
  },
  LanguageConfig_Battle_Win_Title_CHN_CN = {
    Text = "전투 승리"
  },
  LanguageConfig_Battle_expect_Str_hurt_CN = {
    Text = "적 턴 피해"
  },
  LanguageConfig_BenyuanDuoerHuodong1_CN = {
    Text = "완료되지 않은 연구를 선택하세요."
  },
  LanguageConfig_BenyuanDuoerHuodong2_CN = {
    Text = "명령 카드 3장을 선택하여 「합주」각인 새기기"
  },
  LanguageConfig_BigMeal_CN = {
    Text = "호화로운 만찬!"
  },
  LanguageConfig_BigPotencyDesc_CN = {
    Text = "핵심 계령 (쓰이지 않음)"
  },
  LanguageConfig_Billing_Total_Damage_CN = {Text = "총 피해"},
  LanguageConfig_BlackOfferingShopRules_CN = {
    Text = "1. 수호자는 일정 수량의 「검은 공물」을 소모하여 상품을 교환할 수 있습니다.\n2. 수호자 조사 레벨이 상승하면, 무광 교환 상점에 새로운 상품이 해금됩니다.\n3. 무광 교환 상점 상품은 일정 시간마다 자동으로 재고가 갱신됩니다.\n4. 수호자는 「무광의 영역」 또는 「융재금지구역」을 통해 「검은 공물」을 획득할 수 있습니다."
  },
  LanguageConfig_BlackPoolBackTrack_CN = {
    Text = "블랙풀 반환"
  },
  LanguageConfig_Blessing_Select_CN = {
    Text = "선녀의 축복, 모두에게 공평하니, 부디 선택해 주세요"
  },
  LanguageConfig_BlockText_CN = {Text = "방어막"},
  LanguageConfig_BloodAbilityCoolDown_CN = {
    Text = "「핏빛 용광로」 태세가 쿨다운 중이어서 사용할 수 없습니다. 남은 쿨다운 턴: {s1}"
  },
  LanguageConfig_BonusAffix_A24Activity_CN = {
    Text = "이성 보너스"
  },
  LanguageConfig_BonusAffix_Activity_CN = {
    Text = "이벤트 보너스"
  },
  LanguageConfig_BonusAffix_HamelnActivity_CN = {
    Text = "악장 보너스"
  },
  LanguageConfig_BonusAffix_HorlaActivity_CN = {
    Text = "시편 보너스"
  },
  LanguageConfig_BonusAffix_MagicStoryActivity_CN = {
    Text = "영감 보너스"
  },
  LanguageConfig_BonusAffix_MiryamActivity_CN = {
    Text = "제물 보너스"
  },
  LanguageConfig_BonusAffix_MurphyActivity_CN = {
    Text = "태아 보너스"
  },
  LanguageConfig_BonusAffix_OriginDollActivity_CN = {
    Text = "인형 부품 보너스"
  },
  LanguageConfig_BonusAffix_OriginHelotActivity_CN = {
    Text = "꽃봉오리 보너스"
  },
  LanguageConfig_BonusAffix_RykerActivity_CN = {
    Text = "칩 보너스"
  },
  LanguageConfig_BonusAffix_SalvadorActivity_CN = {
    Text = "광채 보너스"
  },
  LanguageConfig_BonusAffix_SorelActivity_CN = {
    Text = "부채 보너스"
  },
  LanguageConfig_BonusAffix_TawilActivity_CN = {
    Text = "종말 지침 보너스"
  },
  LanguageConfig_BonusAffix_ThaisActivity_CN = {
    Text = "욕망 보너스"
  },
  LanguageConfig_BonusAffix_TuluActivity_CN = {
    Text = "감정 보너스"
  },
  LanguageConfig_BonusAffix_WandaActivity_CN = {
    Text = "기전 보너스"
  },
  LanguageConfig_BonusCardAwardText_CN = {
    Text = "욕망 보너스"
  },
  LanguageConfig_BonusCardRateText_CN = {
    Text = "「풍요의 종자」획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusCardTipsContent_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「뒤엉킨 욕망」 스테이지 미션 보상 중 「풍요의 종자」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「타이스」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「자비로운 양육」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「작별의 키스」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「욕망 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusCardTipsTitle_CN = {
    Text = "욕망 보너스 설명"
  },
  LanguageConfig_BonusRuleContent_A24Activity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「기억 인코딩」 스테이지 미션 보상 중 「기억 퍼즐」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「24」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「이형체의 포식」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「은빛 물고기의 결심」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「이성 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_ArachneActivity_CN = {
    Text = "1,수호자는 특정 깨어남체 또는 명륜(전투에 배치할 필요 없음)을 보유하고 있으면「인형의 무대」단계 미션 보상 중「벨벳 좌석 표 뒷면」의 추가 드롭 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다: \n·깨어남체「아라크네」: 기령 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SSR 명륜「영원한 직조의 그물」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SR 명륜「숙명의 물레」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n2,서로 다른 깨어남체 또는 명륜의「활동 보너스」는 중첩 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_CarabooActivity_CN = {
    Text = "1、수호자가 특정 각성체 또는 명륜을 보유하고 있으면 (출전 불필요) 「우모파티의 보물」 단계 임무 보상 중 「붉은 사과」「황금 사과」「사과 사탕」의 추가 드롭 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·각성체 「카라부」: 계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SSR 명륜 「달콤한 거짓」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SR 명륜 「고요히 빛나는 진실」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n2、서로 다른 각성체 또는 명륜의 「활동 보너스」는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_CastorActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「창공을 넘어」 스테이지 미션 보상 중 「상식 책」, 「수리 책」, 「문학 책」 획득 시 추가 드롭 보너스를 받을 수 있습니다. 구체적인 보너스는 다음과 같습니다：\n· 「카스토르」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「견딜 수 없는 자유」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「고독한 깃털」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_ClementineActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「공포 치료」 스테이지 미션 보상 중 「진단 보고서」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「클레멘타인」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「숨겨진 고통」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「최면 진자」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_DaffodilActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「마녀의 작은 가게」 스테이지 미션 보상 중 「창백한 야수의 두개골」, 「어스름 야수의 두개골」, 「진홍빛 야수의 두개골」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「다포딜」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「가장 소중한 수집품」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「마녀의 모자 」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_DoresainActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「영혼을 삼키는 연회」 스테이지 미션 보상 중 「부패한 손뼈」 획득 시 추가 드롭 보너스를 받을 수 있습니다. 구체적인 보너스는 다음과 같습니다：\n· 「도어세인」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「안식의 입맞춤」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「진미」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_GenesisTinctActivity_CN = {
    Text = "1、수호자가 특정 각성체 또는 명륜을 보유하고 있으면 (출전 불필요) 「임시 텍스트」 단계 임무 보상 중 「임시 텍스트」, 「임시 텍스트」, 「임시 텍스트」의 추가 드롭 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·각성체 「저무는 별·틴커트」: 계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SSR 명륜 「임시 텍스트」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SR 명륜 「임시 텍스트」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n2、서로 다른 각성체 또는 명륜의 「활동 보너스」는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_HamelnActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「울려퍼지는 굉음」 스테이지 미션 보상 중 「고창 악장」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「하멜른」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「영원한 진혼곡」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「끝없는 연주」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「악장 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_HorlaActivity_CN = {
    Text = "1、수호자가 특정 깨어남체 또는 명륜(출전 불필요)을 보유하면 「정원의 추억」 단계 임무 보상 중 「우울한 시문」, 「유감의 시문」, 「기쁜 시」에 추가 드롭 보너스(재현 포함)를 적용할 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·깨어남체 「오를라」: 계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n·SSR 명륜 「시첩의 끝구절」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n·SR 명륜 「지난날의 꽃과 시」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n2、서로 다른 깨어남체 또는 명륜의 「시문 보너스」는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_KathiguRaActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「잿빛의 추격」 스테이지 미션 보상 중 「재물의 「인장」」, 「죽음의 「인장」」, 「전쟁의 「인장」」 획득 시 추가 드롭 보너스를 받을 수 있습니다. 구체적인 보너스는 다음과 같습니다：\n· 「카티그라」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「호박빛의 죽음」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「다가오는 태양」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_LotanCetarchon_CN = {
    Text = "1、수호자가 특정 깨어남체 또는 명륜(출전 불필요)을 보유하면 「살육의 각축」 단계 임무 보상 중 「핏빛 제물」에 추가 드롭 보너스를 적용할 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·깨어남체 「침식·로탄」: 계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SSR 명륜 「하늘의 추락」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SR 명륜 「불멸의 곯은 뼈」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n2、서로 다른 깨어남체 또는 명륜의 「활동 보너스」는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_MagicStoryActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「각본 미궁」 스테이지 미션 보상 중 「흩날리는 영감」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「릴리」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「고통을 넘어」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「35mm의 마법」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「영감 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_MiryamActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「신국의 재탄생」 스테이지 미션 보상 중 「제물의 눈물」, 「제물의 피」, 「제물의 골수」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「미리암」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「신앙의 힘」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「심연의 부름」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「제물 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_MoskActivity_CN = {
    Text = "1. 수호자는 특정 깨어남체나 명륜(출전 요구 없음)을 보유하고 있을 경우 “모스크와 바다” 단계 미션 보상 중 “해면 1호”, “해면 2호”, “해면 3호”의 추가 드롭 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다: \n·깨어남체 “모스크”: 기령 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SSR 명륜 “미약한 에덴”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SR 명륜 “갇힌 광란”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n2. 서로 다른 깨어남체나 명륜의 “이벤트 보너스”는 누적 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_MouchetteActivity_CN = {
    Text = "1. 수호자는 특정 깨어남체 또는 명륜(출전 요구 없음)을 보유하면 “잃어버린 자아” 단계 미션 보상에서 “안개의 시선”, “안개의 꿈”, “안개의 원천”의 추가 드롭 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다: \n·깨어남체 “모카”: 기령 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SSR 명륜 “광학의 세계 끝까지”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SR 명륜 “이성 빛나는 등불”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n2. 서로 다른 깨어남체 또는 명륜의 “이벤트 보너스”는 누적 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_MurphyActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「암흑의 모태」 스테이지 미션 보상 중 「무식의 태아」, 「무욕의 태아」, 「무염의 태아」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「머피」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「은밀한 탄생」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「빙하 아래의 잠든」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「배아 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_OriginDollActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「허무의 문」 스테이지 미션 보상 중 「인형 부품」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「융해·돌」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「허무로 추락하는 인형」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「목동의 지팡이」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「인형 부품 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_OriginHelotActivity_CN = {
    Text = "<Title:확률 설명>\n1. 사용시 확률적으로 다음 중 하나를 얻을 수 있습니다.\n- 10% 확률: 「형체 없는 자의 증표」 한정 프로필 아이콘 및 페이즈 체스 감정 표현\n- 90% 확률: 과거 핵심 과제/시즌 상위 한정 프로필 아이콘 및 페이즈 체스 감정 표현\n2. 모든 한정 아이콘 및 감정 표현은 10% 확률을 균등 분배합니다. (자세한 목록은 하단의 「한정 아이콘 및 감정 표현 목록」 참고)\n3. 획득 가능 시기\n- 핵심 과제 한정 프로필 아이콘 및 감정 표현: 해당 과제 종료 후 약 1년 후 드롭 목록에 추가\n- 시즌 보상 감정 표현: 시즌 종료 직후 드롭 목록에 추가\n4. 과거 한정 아이콘 및 감정 표현은 90% 확률을 균등 분배합니다.\n- 「형체 없는 자의 초대장」 또한 과거 한정 항목으로 간주됩니다.\n- 목록에 다른 과거 한정 항목이 없을 경우, 「형체 없는 자의 초대장」이 단독으로 90%를 차지합니다.\n5. 이미 보유한 아이콘 혹은 감정 표현을 획득할 경우, 자동으로 「형체 없는 자의 초대장」 1개로 변환됩니다.\n- 초대장을 일정 수량 모으면, 「형체 없는 자의 증표」 라인업에서 원하는 아이콘 혹은 감정 표현을 선택하여 획득할 수 있습니다.\n\n<Title:한정 아이콘 및 감정 표현 목록>\n1. 한정 아이콘\n- 은열쇠의 이름으로 (엘바, 골리아, 유우하시, 카시아, 코르트, 덱스터, 실타래비아, 윌리엄)\n2. 한정 감정 표현\n- 광기의 미사그 (유우하시·내놔, 브라운·몰라, 히로·죽인다)\n- 여유의 미사그 (실타래비아·티타임, 코르트·밤샘, 오지에·경례, 로탄·형제, 라모나·민망, 돌·배터리 부족)\n- 페이즈 통신 (수호자·나?)\n- 지혜의 미사그 (골리아·강인, 레아·눈물, 노틸라·에?, 젠킨·사색, 아그리파·엿보기, 카이커스·앙심)\n꼬마 미사그 (젠킨·메롱)"
  },
  LanguageConfig_BonusRuleContent_OriginMurphyActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「임시 텍스트」 스테이지 미션 보상 중 「임시 텍스트」,「임시 텍스트」,「임시 텍스트」 획득 시 추가 드롭 보너스를 받을 수 있습니다. 구체적인 보너스는 다음과 같습니다：\n· 「탄망·머피」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「어둠 속의 안식」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「푸른 고리의 독」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_PickmanActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「임시 텍스트」 스테이지 미션 보상 중 「임시 텍스트」,「임시 텍스트」,「임시 텍스트」 획득 시 추가 드롭 보너스를 받을 수 있습니다. 구체적인 보너스는 다음과 같습니다：\n· 「피크맨」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「사실타래주의 모순」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「갈망하는 붓」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_PolluxActivity_CN = {
    Text = "1. 수호자가 특정 깨어남체나 명륜(출전 요구 없음)을 보유하면 “극주야의 종야” 스테이지 미션 보상 중 “진견봉례”, “후회봉례”, “충성봉례”에서 추가 드랍 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다: \n·깨어남체 “폴룩스”: 기령 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SSR 명륜 “왜곡된 기사시”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SR 명륜 “성자 존영”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n2. 서로 다른 깨어남체나 명륜의 “이벤트 보너스”는 중첩 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_PontosActivity_CN = {
    Text = "1、수호자가 특정 깨어남체 또는 명륜을 보유하고 있으면(출전 불필요) 「고지 순렵」 단계 미션 보상의 「신선한 「사냥감」」「거대한 「사냥감」」「오래된 「사냥감」」에 추가 드롭 보너스를 적용할 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·깨어남체 「폰토스」: 계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SSR 명륜 「살아있는 감옥」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SR 명륜 「갈림길을 가리키는 나침반」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n2、서로 다른 깨어남체 또는 명륜의 「활동 보너스」는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_RykerActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「달밤의 전설」 스테이지 미션 보상 중 「결승 칩」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「라이커」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「행운의 시간」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「운명의 룰렛」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「칩 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_SalvadorActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「성당으로 향하는 길」 스테이지 미션 보상 중 「자선 판매권」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「살바도르」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「신언의 석판」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「거울 속 인물」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「휘광 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_SayaActivity_CN = {
    Text = "1、수호자가 특정 깨어남체 또는 명륜을 보유하고 있으면 (출전 불필요) \"Notes njim sǝlǝm\" 단계 미션 보상의 \"순백 인분\", \"붉은 인분\", \"요광 인분\"에 추가 드롭 보너스를 획득할 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·깨어남체 \"사야\": 기령 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SSR 명륜 \"세상이 향기가 되길\": 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SR 명륜 \"진흙 속의 동화\": 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n2、서로 다른 깨어남체 또는 명륜의 \"활동 보너스\"는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_SorelActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「장미의 추억」 스테이지 미션 보상 중 「영혼의 깃털 부채」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「소렐」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「장미의 이름으로」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「무수한 총애의 시선」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「부채 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_StElmosFireActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「심연 속 방황」 스테이지 미션 보상 중 「신호 깃발」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「코퍼산트」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「성화 속 길잡이」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「바다의 항해자」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「활동 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_Summer2Activity_CN = {
    Text = "1. 수호자가 “휴일 기행”에서 “고급 기행”을 해제하면, “일광 하 신사” 단계 미션 보상에서 추가 100%의 “진주 조개 기념 소품” 드롭을 얻을 수 있습니다(재현 포함).\n2. 특별히, 광란 난이도 최초 도전 보상은 “이벤트 보너스”의 영향을 받지 않습니다."
  },
  LanguageConfig_BonusRuleContent_TaisuiActivity_CN = {
    Text = "1、수호자가 특정 깨어남체 또는 명륜(출전 불필요)을 보유하면 「임시 텍스트」 단계 임무 보상 중 「임시 텍스트」에 추가 드롭 보너스를 적용할 수 있으며, 구체적인 보너스는 다음과 같습니다:\n·깨어남체 「태세」: 계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SSR 명륜 「임시 텍스트」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n·SR 명륜 「임시 텍스트」: 중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%.\n2、서로 다른 깨어남체 또는 명륜의 「활동 보너스」는 중첩 방식으로 정산됩니다."
  },
  LanguageConfig_BonusRuleContent_TawilActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「최종 시험」 스테이지 미션 보상 중 「종말 지침」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「타비」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「감춰진 수레바퀴」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「진리의 문」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「종말 지침 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_ThaisActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「뒤엉킨 욕망」 스테이지 미션 보상 중 「풍요의 종자」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「타이스」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「자비로운 양육」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「작별의 키스」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「욕망 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_TuluActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「심연의 응시」 스테이지 미션 보상 중 「피로의 감정」, 「비애의 감정」, 「환희의 감정」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「툴루」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「신왕의 찬가」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「청석 왕좌」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「감정 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_WandaActivity_CN = {
    Text = "1. 수호자가 특정 「깨어남체」 또는 「명륜」을 보유하고 있을 경우(편성할 필요 없음), 「불꽃의 향연」 스테이지 미션 보상 중 「원생 경골」, 「원형잎 화석」, 「나선 유적」 획득 시 추가 드롭 보너스를 받을 수 있습니다(재현 포함). 구체적인 보너스는 다음과 같습니다：\n· 「완다」：계령 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SSR 「여왕의 계율」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n· SR 「이살라우의 주시」：중첩 0/1/2/3 이상, 보너스 20%/30%/40%/50%\n\n2. 서로 다른 「깨어남체」 또는 「명륜」의 「기전 보너스」는 합산 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleContent_XuActivity_CN = {
    Text = "1. 수호자는 특정 깨어남체나 명륜(출전 요구 없음)을 보유하면 “현녀무상” 단계 미션 보상 중 “배꿀사탕”의 추가 드롭 보너스를 받을 수 있으며, 구체적인 보너스는 다음과 같습니다: \n·깨어남체 “서”: 기령 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SSR 명륜 “억지로 미간을 찌푸리다”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n·SR 명륜 “백합의 미끼”: 스택 위치 0/1/2/3 이상, 보너스 20%/30%/40%/50%. \n2. 서로 다른 깨어남체나 명륜의 “이벤트 보너스”는 중첩 방식으로 계산됩니다."
  },
  LanguageConfig_BonusRuleTitle_Activity_CN = {
    Text = "보너스 설명"
  },
  LanguageConfig_BonusTips_A24Activity_CN = {
    Text = "「기억 퍼즐」획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_Activity_CN = {
    Text = "이벤트 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_HamelnActivity_CN = {
    Text = "악장 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_HorlaActivity_CN = {
    Text = "시편 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_MagicStoryActivity_CN = {
    Text = "영감 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_MiryamActivity_CN = {
    Text = "제물 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_MurphyActivity_CN = {
    Text = "태아 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_OriginDollActivity_CN = {
    Text = "인형 부품 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_OriginHelotActivity_CN = {
    Text = "꽃봉오리 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_RykerActivity_CN = {
    Text = "칩 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_SalvadorActivity_CN = {
    Text = "자선 판매권 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_SorelActivity_CN = {
    Text = "부채 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_TawilActivity_CN = {
    Text = "종말 지침 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_ThaisActivity_CN = {
    Text = "욕망 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_TuluActivity_CN = {
    Text = "감정 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_WandaActivity_CN = {
    Text = "기전 획득량 보너스: <NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BoutBloodSkillMaxTimesTips_CN = {
    Text = "이번 턴에서 더는 핏빛 용광로를 사용할 수 없습니다."
  },
  LanguageConfig_BpRewardSourceName_CN = {
    Text = "핵심 과제"
  },
  LanguageConfig_BpUnPurchaseLevelClickTips_CN = {
    Text = "현재 등급 구매 불가"
  },
  LanguageConfig_BreakThroughCondition_1_CN = {
    Text = "<Gray:조건 1>"
  },
  LanguageConfig_BreakThroughCondition_2_CN = {
    Text = "<Gray:조건 2>"
  },
  LanguageConfig_BreakThroughCondition_3_CN = {
    Text = "<Gray:조건 3>"
  },
  LanguageConfig_BreakThrough_Btn_Str_CN = {Text = "승격"},
  LanguageConfig_BreakThrough_Completed_Deblock_Skill_Str_CN = {
    Text = "새로운 스킬 활성화 가능"
  },
  LanguageConfig_BreakThrough_Completed_Title_Str_CN = {
    Text = "승격 성공"
  },
  LanguageConfig_BreakThrough_Detail_Btn_Str_CN = {Text = "승격"},
  LanguageConfig_BreakThrough_Detail_Deblock_Skill_Str_CN = {
    Text = "새로운 스킬 활성화 가능"
  },
  LanguageConfig_BreakThrough_Detail_Item_Str_CN = {
    Text = "승격 재료"
  },
  LanguageConfig_BreakThrough_Detail_Unmet_Tips_CN = {
    Text = "재료 부족"
  },
  LanguageConfig_BreakThrough_PlayLevel_Requirement_CN = {
    Text = "조사 등급 {s1}에 도달할 시 승격 가능"
  },
  LanguageConfig_BreakThrough_Preview_Btn_Str_CN = {Text = "수령"},
  LanguageConfig_BreakThrough_Preview_Completed_Tips_CN = {
    Text = "승격 완료"
  },
  LanguageConfig_BreakThrough_Preview_Completed_Tips_Str_CN = {
    Text = "보상 수령 완료"
  },
  LanguageConfig_BreakThrough_Preview_Item_Str_CN = {
    Text = "승격 재료"
  },
  LanguageConfig_BreakThrough_Preview_Not_Completed_Tips_CN = {
    Text = "조사 등급 {s2}, 깨어남체 레벨 {s1}에 도달할 시 승격 가능"
  },
  LanguageConfig_BreakThrough_Preview_Title_Str_CN = {
    Text = "미리보기"
  },
  LanguageConfig_BreakThrough_Skill_Active_Requirement_CN = {
    Text = "{s1} 활성화 필요"
  },
  LanguageConfig_BreakThrough_Skill_Active_Success_CN = {
    Text = "활성화 성공"
  },
  LanguageConfig_BreakThrough_Skill_Block_Str_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_BreakThrough_Skill_Deblock_Str_CN = {
    Text = "승격 등급 {s1}에 해제됩니다"
  },
  LanguageConfig_BreakThrough_Task_Requirement_CN = {
    Text = "조건 중 하나를 달성 시 승격 가능"
  },
  LanguageConfig_BreakThrough_Unmet_Tips_CN = {
    Text = "조사 등급  {s1}급 해금"
  },
  LanguageConfig_BreakthroughTitleText_CN = {
    Text = "승격 {s1}단계"
  },
  LanguageConfig_BuffOffset_CN = {
    Text = "<color=#E3FFE3>상쇄</color>"
  },
  LanguageConfig_Buff_Tips_DispelBuff_CN = {
    Text = "해제 불가"
  },
  LanguageConfig_Burning_Opera_01_CN = {
    Text = "극장이 불길에 휩싸였습니다… 불꽃은 힘을 부여하지만, 계속 타오르는 카드에는 주의하세요!"
  },
  LanguageConfig_Buy_Jewel_Btn_Sure_CN = {
    Text = "돌아가기"
  },
  LanguageConfig_Buy_Jewel_Str_Price_CN = {Text = "가격"},
  LanguageConfig_Buy_Jewel_Str_Title_CN = {
    Text = "은심 구매"
  },
  LanguageConfig_C05AFNotUseCard_CN = {
    Text = "검은 인장 부족"
  },
  LanguageConfig_C15AFNotUseCard_CN = {
    Text = "은열쇠 에너지 부족"
  },
  LanguageConfig_CanEquipOneSSRWeaonRuleDesc_CN = {
    Text = "깨어남체마다 SSR 명륜 1개만 장착할 수 있습니다."
  },
  LanguageConfig_CanEquipTwoSSRWeaonRuleDesc_CN = {
    Text = "이제 SSR 명륜을 2개 장비할 수 있습니다"
  },
  LanguageConfig_CancelAutoBattle_CN = {
    Text = "자동 전투가 취소되었습니다"
  },
  LanguageConfig_CancelSelectAllAwaker_CN = {
    Text = "모두 취소"
  },
  LanguageConfig_CanceledText_CN = {Text = "취소됨"},
  LanguageConfig_CardString_01_CN = {Text = "피해"},
  LanguageConfig_CardString_02_CN = {Text = "능력"},
  LanguageConfig_CardString_03_CN = {Text = "상태"},
  LanguageConfig_CardString_04_CN = {Text = "스킬"},
  LanguageConfig_CardString_05_CN = {Text = "증상"},
  LanguageConfig_CardString_06_CN = {Text = "방어막"},
  LanguageConfig_CardTip_Destroy_CN = {
    Text = "<CardTip:파괴>\n사용 후, 해당 카드는 덱에서 영구적으로 제거됩니다."
  },
  LanguageConfig_CardTip_Innate_CN = {
    Text = "<CardTip:고유>\n전투 시작 시, 해당 카드가 손패에 포함됩니다."
  },
  LanguageConfig_CardTip_Metallicize_CN = {
    Text = "<CardTip:금속화>\n턴 종료 시, 스택과 동일한 수치의 방어막 값을 획득합니다."
  },
  LanguageConfig_Card_Awaker_Select_CN = {
    Text = "능력 선택"
  },
  LanguageConfig_Card_Bag_Title_CN = {
    Text = "명령 카드"
  },
  LanguageConfig_Card_Select_Act_Tips1_CN = {
    Text = "행동 의도 1개를 선택하세요."
  },
  LanguageConfig_Card_Select_Act_Tips2_CN = {
    Text = "행동 의도 2개를 선택하세요."
  },
  LanguageConfig_Card_Select_CN = {
    Text = "카드 {s1}장 선택하기"
  },
  LanguageConfig_Card_Select_Copy_Tips1_CN = {
    Text = "카드 1장을 선택해 복사하세요."
  },
  LanguageConfig_Card_Select_Copy_Tips1_Ruins_CN = {
    Text = "카드 1장을 선택해 행동력 소모를 감소시키고, 공명 효과를 부여하세요."
  },
  LanguageConfig_Card_Select_Del_Tips1_CN = {
    Text = "카드 1장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips1_Curse_CN = {
    Text = "증상 카드 1장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips1_Ruins_CN = {
    Text = "카드 1장을 선택해 삭제하고, 공명 효과를 부여하세요."
  },
  LanguageConfig_Card_Select_Del_Tips1_UP_CN = {
    Text = "카드를 최대 1장 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips2_CN = {
    Text = "카드 2장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips2_Curse_CN = {
    Text = "증상 카드 2장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips2_Ruins_CN = {
    Text = "카드 2장을 선택해 삭제하고, 공명 효과를 부여하세요."
  },
  LanguageConfig_Card_Select_Del_Tips2_Up_CN = {
    Text = "카드를 최대 2장 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips3_CN = {
    Text = "카드 3장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips4_Curse_CN = {
    Text = "증상 카드 4장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips5_Up_CN = {
    Text = "카드를 최대 5장 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips6_Curse_CN = {
    Text = "증상 카드 6장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tips6_Curse_Up_CN = {
    Text = "증상 카드 최대 6장을 선택해 삭제하세요."
  },
  LanguageConfig_Card_Select_Del_Tipskelaimenting_CN = {
    Text = "명령 카드 1장을 선택해 손패에 추가하세요."
  },
  LanguageConfig_Card_Select_Del_Tipsnaogang2_CN = {
    Text = "카드 최대 3장을 선택해 손패에 추가하세요."
  },
  LanguageConfig_Card_Select_Del_Tipsnaogang_CN = {
    Text = "카드 최대 2장을 선택해 삭제한 뒤, 「예비 뇌조」에 넣으세요."
  },
  LanguageConfig_Card_Select_Discard_Tips2_CN = {
    Text = "카드를 2장 선택하여 버리기"
  },
  LanguageConfig_Card_Select_Get_Tips1_CN = {
    Text = "카드 1장을 선택해 손패에 넣어보세요."
  },
  LanguageConfig_Card_Select_Get_Tips1_Ceremony_CN = {
    Text = "하나의 의식을 진행할 수 있습니다"
  },
  LanguageConfig_Card_Select_Get_Tips1_KeeperSkill_CN = {
    Text = "은열쇠 1개 선택"
  },
  LanguageConfig_Card_Select_Get_Tips1_Use_CN = {
    Text = "카드 1장을 선택해 사용하세요."
  },
  LanguageConfig_Card_Select_Get_Tips1_jingji1_CN = {
    Text = "추가 효과를 선택하세요."
  },
  LanguageConfig_Card_Select_Get_Tips1_qianmian1_CN = {
    Text = "천면환상 1장을 선택해 손패에 추가하세요."
  },
  LanguageConfig_Card_Select_Get_Tips1_qianmian2_CN = {
    Text = "천면환상에 부여할 추가 효과를 선택하세요."
  },
  LanguageConfig_Card_Select_Get_Tips2_CN = {
    Text = "카드 2장을 선택해 손패에 넣어보세요."
  },
  LanguageConfig_Card_Select_Get_Tips33_CN = {
    Text = "카드를 최대 3장 선택해 손패에 넣어보세요."
  },
  LanguageConfig_Card_Select_Get_Tips3_CN = {
    Text = "카드 3장을 선택해 손패에 넣어보세요."
  },
  LanguageConfig_Card_Select_Get_Tips_Caroboo_CN = {
    Text = "금화인가요, 초콜릿인가요? 눈썰미를 발휘할 시간이 왔어요~"
  },
  LanguageConfig_Card_Select_Get_Tips_GLY1_CN = {
    Text = "발동할 효과 선택"
  },
  LanguageConfig_Card_Select_Get_Tips_ShiWen_CN = {
    Text = "발동할 효과 선택"
  },
  LanguageConfig_Card_Select_Get_Tips_mofei_CN = {
    Text = "계산력' 또는 '드로우 카드'를 선택합니다"
  },
  LanguageConfig_Card_Select_Get_Tips_waiyu_CN = {
    Text = "흥분 또는 \"저주\" 선택"
  },
  LanguageConfig_Card_Select_Get_Tipsbaiyin_CN = {
    Text = "일반 등급의 유물 1개를 선택하세요."
  },
  LanguageConfig_Card_Select_Get_Tipsfengrang_CN = {
    Text = "손패 1장을 선택해, 해당 카드의 복사본 3장을 드로우 덱에 섞어 넣습니다."
  },
  LanguageConfig_Card_Select_Get_Tipshuangjin_CN = {
    Text = "희귀 등급의 유물 1개를 선택하세요."
  },
  LanguageConfig_Card_Select_Get_Tipslamengna2_CN = {
    Text = "카드 1장에 「반향」 각인을 부여하고, 나머지 카드는 버린 카드 더미에 넣습니다."
  },
  LanguageConfig_Card_Select_Get_Tipslamengna3_CN = {
    Text = "임의 매수의 카드를 선택하여 버리고, 같은 수의 카드를 뽑습니다."
  },
  LanguageConfig_Card_Select_Get_Tipslamengna4_CN = {
    Text = "카드를 1장 선택하여, 그 카드의 행동력 소비량을 1 감소시킵니다."
  },
  LanguageConfig_Card_Select_Get_Tipslamengna5_CN = {
    Text = "비파생 명령 카드 1장 선택"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna6_CN = {
    Text = "임의의 카드를 선택하여 버리고, 버린 카드 1장당 임시 크리티컬 피해 +15%"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna7_CN = {
    Text = "카드를 1장 선택하여, 해당 카드의 임시 복사본을 손패에 넣고 그 행동력 소비량을 1 감소시킵니다."
  },
  LanguageConfig_Card_Select_Get_Tipslamengna_CN = {
    Text = "카드를 1장 선택하여 손패에 넣고, 나머지 카드는 버린 카드 더미에 넣습니다."
  },
  LanguageConfig_Card_Select_Get_Tipslaxiang_CN = {
    Text = "손패 1장을 선택해, 해당 카드의 계산력 소모를 0으로 만들고,"
  },
  LanguageConfig_Card_Select_Get_Tipslengcai_CN = {
    Text = "경이 등급의 유물 1개를 선택하세요."
  },
  LanguageConfig_Card_Select_Get_Tipspikeman1_CN = {
    Text = "1장의 카드를 선택하여 손에 넣고, 해당 카드에 「소모」와 「보존」 효과를 부여합니다."
  },
  LanguageConfig_Card_Select_Get_Tipspikeman2_CN = {
    Text = "픽맨 구조물의 창조 유물 1개를 선택하여 획득합니다."
  },
  LanguageConfig_Card_Select_Get_Tipstiaojiu1_CN = {
    Text = "조미료를 1가지 선택하여, 이번 전투 동안 「영혼 제례 특상주」에 추가합니다."
  },
  LanguageConfig_Card_Select_Get_Tipsxiaomao_CN = {
    Text = "깨어남체 1명을 선택하여, 해당 깨어남체의 지원 카드를 손패에 넣습니다."
  },
  LanguageConfig_Card_Select_Get_Tipszhiyuan_CN = {
    Text = "지원 카드 1장을 선택해 손패에 추가하세요."
  },
  LanguageConfig_Card_Select_Get_Tipszhuiyi_CN = {
    Text = "추억 효과 1개를 선택하여 발동합니다."
  },
  LanguageConfig_Card_Select_Get_Unit4BossBuff_CN = {
    Text = "1장의 「성상 축복」을 선택하기"
  },
  LanguageConfig_Card_Select_Get_Unit4BossDeBuff_CN = {
    Text = "1장의 「성상 축복」을 선택하여 그 카드를 「저주」로 반전하기"
  },
  LanguageConfig_Card_Select_Get_tawil_CN = {
    Text = "3장의 명령 카드를 선택하여 소모합니다"
  },
  LanguageConfig_Card_Select_Puppet_Tips_CN = {
    Text = "1장의 카드를 선택하여 강제로 사용합니다."
  },
  LanguageConfig_Card_Select_Redraw_Tips3_CN = {
    Text = "최대 3장을 폐기하고 같은 수의 카드를 드로우합니다"
  },
  LanguageConfig_Card_Select_Retain_Tips1_CN = {
    Text = "손패에 남겨 둘 카드 1장을 선택하세요."
  },
  LanguageConfig_Card_Select_Retain_Tips2_CN = {
    Text = "카드 1장을 손에 보존하면, 해당 카드의 행동력 소모가 1 감소합니다."
  },
  LanguageConfig_Card_Select_Sell_Tips1_CN = {
    Text = "판매할 카드 1장을 선택하세요."
  },
  LanguageConfig_Card_Select_Tips1_CN = {
    Text = "카드 1장을 선택하세요."
  },
  LanguageConfig_Card_Select_Tips1_consume_CN = {
    Text = "소모할 카드 1장을 선택하세요."
  },
  LanguageConfig_Card_Select_Tips1_cost1_CN = {
    Text = "카드 1장을 선택해 해당 카드의 행동력 소모를 1로 변경하세요."
  },
  LanguageConfig_Card_Select_Tips1_hamulin_CN = {
    Text = "음률 1개를 선택해 발동하세요."
  },
  LanguageConfig_Card_Select_Tips1_huihuana_CN = {
    Text = "카드 1장을 선택해 「반복되는 선율」을 추가하세요."
  },
  LanguageConfig_Card_Select_Tips1_huihuanb_CN = {
    Text = "카드 2장을 선택해 「반복되는 선율」을 추가하세요."
  },
  LanguageConfig_Card_Select_Tips1_kelaimenting_CN = {
    Text = "「공감」을 「정신적 상처」 또는 「공포 고착」으로 전환하세요."
  },
  LanguageConfig_Card_Select_Tips1_tawei_CN = {
    Text = "「추억」 1개를 선택해 해당 효과를 발동하세요."
  },
  LanguageConfig_Card_Select_Tips1_xu_CN = {
    Text = "「약속」 또는 「영혼 탈취」를 선택하세요."
  },
  LanguageConfig_Card_Select_Tips_2ndAnniversaryBOSS_CN = {
    Text = "최대 3장의 카드에 「여파」를 부여합니다"
  },
  LanguageConfig_Card_Select_Up_Tips1_CN = {
    Text = "각인이 새겨진 카드 1장을 선택해 각인을 강화하세요."
  },
  LanguageConfig_Card_Select_Upyixiang_Tips1_CN = {
    Text = "이미지 1장을 선택하여 업그레이드"
  },
  LanguageConfig_Card_Select_yixiang_Tips1_CN = {
    Text = "이미지 1장을 선택하여 획득"
  },
  LanguageConfig_Card_Tip_Ability_CN = {
    Text = "<CardTip:영지 깨어남>\n해당 효과는 깨어남체마다 한 번만 발동되며, 중첩되지 않습니다."
  },
  LanguageConfig_Card_Tip_Anger_CN = {
    Text = "<CardTip:거대한 검의 위엄>\n행동력 2를 소모하여 모든 적에게 공격력 200%의 피해를 가합니다. 이 피해에는 힘 계수가 300%로 적용됩니다. 소모."
  },
  LanguageConfig_Card_Tip_Artifact_CN = {
    Text = "<CardTip:견고>\n스택마다 디버프 면역 1회를 제공합니다."
  },
  LanguageConfig_Card_Tip_Blood_CN = {
    Text = "<CardTip:배아 융합>\n배아 융합이 100%에 도달하면, 혈육 영역의 광기 폭발을 강화할 수 있는 배아를 손패에 추가합니다."
  },
  LanguageConfig_Card_Tip_Bramble_CN = {
    Text = "<CardTip:가시>\n공격받을 때, 공격자에게 스택만큼 피해를 입힙니다."
  },
  LanguageConfig_Card_Tip_CantRemove_CN = {
    Text = "<CardTip:제거 불가>\n탐색 중 해당 카드를 덱에서 제거할 수 없습니다."
  },
  LanguageConfig_Card_Tip_CardDestroy_CN = {
    Text = "<CardTip:파괴>\n탐색 중 한 번만 사용할 수 있으며, 사용 후 덱에서 영구적으로 제거됩니다."
  },
  LanguageConfig_Card_Tip_Condition_CN = {
    Text = "<CardTip:상태>\n전투가 끝나면 해당 카드는 덱에서 제거됩니다."
  },
  LanguageConfig_Card_Tip_Consume_CN = {
    Text = "<CardTip:소모>\n사용 후, 전투가 끝날 때까지 덱에서 제거됩니다."
  },
  LanguageConfig_Card_Tip_Critical_CN = {
    Text = "크리티컬 확률: [critical]\n크리티컬 피해: [critical_damage]"
  },
  LanguageConfig_Card_Tip_Dexterity_CN = {
    Text = "<CardTip:경계>\n명령 카드로 획득하는 방어막 값을 증가시킵니다."
  },
  LanguageConfig_Card_Tip_Energy_CN = {
    Text = "시작시 에너지 획득:  [ene_init]\n에너지 자동 회복:  [ene_passive]\n에너지 소모 감소:  [ene_return]"
  },
  LanguageConfig_Card_Tip_Ethereal_CN = {
    Text = "<CardTip:공허>\n카드가 손패에서 버려지거나, 덱에 섞여 들어가면 소모됩니다."
  },
  LanguageConfig_Card_Tip_Fire_CN = {
    Text = "<CardTip:혼염>\n 혼염은 가디언 스피릿의 <BuffTipDamage:피해량>을 증가시킵니다."
  },
  LanguageConfig_Card_Tip_Frail_CN = {
    Text = "<CardTip:손상>\n획득하는 실타래드가 50% 감소됩니다."
  },
  LanguageConfig_Card_Tip_Free_CN = {
    Text = "<CardTip:행동력 면제>\n해당 카드의 행동력 소비량이 0이 됩니다."
  },
  LanguageConfig_Card_Tip_Goat_CN = {
    Text = "<CardTip:성결의 자식>\n행동력 소모 0. 손패에 있을 때, 매 카드 사용 시 행동력 소비 0의 복사본이 됩니다. 소모, 보존."
  },
  LanguageConfig_Card_Tip_Innate_CN = {
    Text = "<CardTip:고유>\n전투 시작 시, 해당 카드가 손패에 포함됩니다."
  },
  LanguageConfig_Card_Tip_LifeSteal_CN = {
    Text = "<CardTip:흡혈>\n방어막으로 방어되지 않은 피해와 동일한 수치의 HP를 회복합니다."
  },
  LanguageConfig_Card_Tip_Marking_CN = {
    Text = "<CardTip:촉수 표식>\n마지막으로 표식이 새겨진 대상에게 촉수의 공격이 집중됩니다."
  },
  LanguageConfig_Card_Tip_Multiprotection_CN = {
    Text = "<CardTip:다중 보호>\n턴 종료시, 현재 스택 수와 동일한 방어막 값을 획득합니다. 피해를 받을 때마다 스택이 1 감소합니다."
  },
  LanguageConfig_Card_Tip_NoDiscard_CN = {
    Text = "<CardTip:보존>\n보존되는 카드는 턴 종료 시에도 버린 카드 더미에 들어가지 않고 손패에 남습니다."
  },
  LanguageConfig_Card_Tip_Regenerate_CN = {
    Text = "<CardTip:재생>\n턴 종료 시, 재생 스택과 동일한 수치의 HP를 회복합니다."
  },
  LanguageConfig_Card_Tip_Strength_CN = {
    Text = "<CardTip:힘>\n피해가 수치만큼 증가합니다."
  },
  LanguageConfig_Card_Tip_TentacleStrength_CN = {
    Text = "<CardTip:촉수 피해>\n촉수 피해가 수치만큼 증가합니다."
  },
  LanguageConfig_Card_Tip_Useless_CN = {
    Text = "<CardTip:사용 불가>\n해당 카드는 손패에서 사용할 수 없습니다."
  },
  LanguageConfig_Card_Tip_Vnlnerable_CN = {
    Text = "<CardTip:취약>\n받는 피해량이 50% 증가합니다."
  },
  LanguageConfig_Card_Tip_Weak_CN = {
    Text = "<CardTip:허약>\n가하는 피해량이 25% 감소합니다."
  },
  LanguageConfig_Card_Tip_Wind_CN = {
    Text = "<CardTip:중독>\n중독을 부여할 때마다 스택이 쌓입니다. 적의 턴이 끝날 때, 대상은 현재 중독 스택과 동일한 피해를 받습니다."
  },
  LanguageConfig_Card_Tip_Wing_CN = {
    Text = "<CardTip:부속품>\n부속품은 신성한 수호자의 <BuffTipDamage:피해량>을 증가시킵니다."
  },
  LanguageConfig_Card_Tip_devour_CN = {
    Text = "<CardTip:포식>\n손패의 배아를 1장 소모하여 추가 효과를 발동합니다."
  },
  LanguageConfig_Card_Upgrade_CN = {Text = "강화"},
  LanguageConfig_Card_Upgrade_Desc_CN = {
    Text = "강화할 카드 1장을 선택하기"
  },
  LanguageConfig_CellCardHint_CN = {
    Text = "판매된 카드는 이번 조사에서 영구적으로 제거되니, 신중하게 선택하세요."
  },
  LanguageConfig_ChangeDress_CN = {Text = "변경"},
  LanguageConfig_ChangeGenderCost_CN = {
    Text = "{s1}을 소모합니다"
  },
  LanguageConfig_ChangeGenderFreeTips_CN = {
    Text = "초회 무료"
  },
  LanguageConfig_ChaosSchool_RelicTips_CN = {
    Text = "획득할 유물 선택"
  },
  LanguageConfig_Chaos_Tips_Title2_CN = {
    Text = "원초의 숨결"
  },
  LanguageConfig_Chaos_Tips_Title_CN = {
    Text = "은열쇠 공명"
  },
  LanguageConfig_Chapter7Resonance1_1_CN = {
    Text = "기타 공명 효과"
  },
  LanguageConfig_Chapter7Resonance1_2_CN = {
    Text = ", 랜덤 증상 3장 획득"
  },
  LanguageConfig_ChargeItemNoChargeTest_CN = {
    Text = "이 테스트에서는 결제 기능이 제공되지 않습니다"
  },
  LanguageConfig_Charge_NotOpen_CN = {
    Text = "충전 기능 미오픈"
  },
  LanguageConfig_ChestPreviewTitle_CN = {
    Text = "재료 미리보기"
  },
  LanguageConfig_ChestTypeName_CN = {
    Text = "보물 상자"
  },
  LanguageConfig_ChooseItemForDecompose_CN = {
    Text = "분해할 재료를 선택하지 않았습니다"
  },
  LanguageConfig_ChooseModel_CN = {
    Text = "모드 선택"
  },
  LanguageConfig_Choose_CN = {Text = "선택"},
  LanguageConfig_ClearCopy_Btn_CN = {
    Text = "스킵 {s1}회"
  },
  LanguageConfig_ClearCopy_Str_Title_CN = {
    Text = "재현 보상"
  },
  LanguageConfig_ClearCopy_Tips_CN = {
    Text = "스킵을 이용해 전투를 빠르게 진행하세요!"
  },
  LanguageConfig_ClearCopy_Tips_Unlock_CN = {
    Text = "3성 클리어 후 개방"
  },
  LanguageConfig_CloseExpression_PVP_CN = {
    Text = "상호작용 차단"
  },
  LanguageConfig_CollaborationSubplotTipsText_CN = {
    Text = "<Title:[다차원 연결]>1. 다음 조건을 충족해야 다차원 연결을 진행할 수 있습니다.\n· 해당 조사 작전 완료\n· 지정된 수량의 '현실타래의 기점'을 소모하여 해제\n2. 다차원 연결이 기간 한정 이벤트 중일 경우, '현실타래의 기점'을 소모하지 않고 무료로 해제할 수 있습니다. 이벤트 종료 후 조사 진행도는 유지됩니다.\n3. 다차원 연결 조사 미션를 최초로 완료하면 무구의 은핵을 획득할 수 있습니다."
  },
  LanguageConfig_CollaborationSubplotTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_CollectionBoxCollectCountdown_CN = {
    Text = "수령까지 남은 시간: {s1}"
  },
  LanguageConfig_CollectionBoxFillUpCountdown_CN = {
    Text = "자동 획득 최대치까지: {s1}"
  },
  LanguageConfig_CollectionBoxProduceSpeed_CN = {
    Text = "{s1}/시간"
  },
  LanguageConfig_CollectionHall_Progress_ActivityCG_CN = {
    Text = "이벤트 수집"
  },
  LanguageConfig_CollectionHall_Progress_Creation_CN = {
    Text = "유물 수집"
  },
  LanguageConfig_CollectionHall_Progress_Default_CN = {
    Text = "수집 진행도"
  },
  LanguageConfig_CollectionHall_Progress_Event_CN = {
    Text = "이벤트 수집"
  },
  LanguageConfig_CollectionHall_Progress_Music_CN = {
    Text = "축음기 수집"
  },
  LanguageConfig_CollectionHall_Progress_PromotionVideo_CN = {Text = "PV 수집"},
  LanguageConfig_CollectionHall_Progress_RadioDrama_CN = {
    Text = "라디오 드라마 수집"
  },
  LanguageConfig_CollectionHall_Progress_Role_CN = {
    Text = "캐릭터 수집"
  },
  LanguageConfig_CollectionHall_Progress_ScenesCG_CN = {
    Text = "장면 CG 수집"
  },
  LanguageConfig_CollectionHall_Progress_StoryLineCG_CN = {
    Text = "스토리 CG 수집"
  },
  LanguageConfig_CollectionHall_Progress_Trinket_CN = {
    Text = "비밀계약 수집"
  },
  LanguageConfig_CollectionHall_Progress_Weapon_CN = {
    Text = "명륜 수집"
  },
  LanguageConfig_CollectionHall_Progress_WorldView_CN = {
    Text = "세계관 수집"
  },
  LanguageConfig_CollectionNumber_CN = {
    Text = "전시관 컬렉션 수"
  },
  LanguageConfig_CollectionUnlockItemTitle_CN = {Text = "해금"},
  LanguageConfig_CollectionUnlockItem_CN = {
    Text = "이 배경 애니메이션을 해금하려면 <Blue:“{s1}”*{s2}> 필요\n해금 후 기숙사 배경으로 설정 가능"
  },
  LanguageConfig_Collection_Reward_Desc_CN = {
    Text = "누적 수집 수량 도달"
  },
  LanguageConfig_CombatEffectiveness_CN = {Text = "전투력"},
  LanguageConfig_CommentDataNull_CN = {
    Text = "댓글 없음"
  },
  LanguageConfig_CommonItemAchievement_CN = {Text = "업적"},
  LanguageConfig_CommonItemBattle_CN = {Text = "전투"},
  LanguageConfig_CommonItemDailyFirst_CN = {
    Text = "오늘 첫 클리어"
  },
  LanguageConfig_CommonItemDoubleOutputActivity_CN = {Text = "보상"},
  LanguageConfig_CommonItemExplore_CN = {Text = "탐색"},
  LanguageConfig_CommonItemFirst3Star_CN = {Text = "3성"},
  LanguageConfig_CommonItemFirst_CN = {
    Text = "첫 클리어"
  },
  LanguageConfig_CommonItemHide_CN = {Text = "숨기기"},
  LanguageConfig_CommonItemShop_CN = {Text = "상점"},
  LanguageConfig_CommonItemTalent_CN = {Text = "공명"},
  LanguageConfig_CommonReceive_CN = {Text = "수령"},
  LanguageConfig_CommonTabAll_CN = {Text = "전부"},
  LanguageConfig_CommonTipsOwnedText_CN = {
    Text = "현재 보유 중: {s1}"
  },
  LanguageConfig_Common_Button_Confirm_CN = {Text = "확인"},
  LanguageConfig_CommonlyAssistCount_CN = {
    Text = "수량 <color=#ffffff>{s1}</color>/{s2}"
  },
  LanguageConfig_CommunityJumpTipsTitle_CN = {
    Text = "공식 커뮤니티"
  },
  LanguageConfig_CommunityJumpTips_CN = {
    Text = "공식 커뮤니티에 참여해 보세요!"
  },
  LanguageConfig_CommunityJump_1_CN = {
    Text = "페이스북"
  },
  LanguageConfig_CommunityJump_2_CN = {
    Text = "디스코드"
  },
  LanguageConfig_CompilingShaders_CN = {
    Text = "셰이더를 컴파일 중입니다"
  },
  LanguageConfig_ComposeButtonText_CN = {Text = "합성"},
  LanguageConfig_ComposeTimes_CN = {
    Text = "합성 수량"
  },
  LanguageConfig_ComposeTitle_CN = {
    Text = "재료 합성"
  },
  LanguageConfig_CompositeRemainTips_CN = {
    Text = "남은 합성 가능 횟수：<color=#ffffff>{s1}</color>"
  },
  LanguageConfig_ComsumeSet_CN = {
    Text = "치환 설정"
  },
  LanguageConfig_ConductPasswordBattle1_CN = {
    Text = "비공개 대전 - 사전 편성 모드 진행 중..."
  },
  LanguageConfig_ConductPasswordBattle2_CN = {
    Text = "비공개 대전 - 순차 선택 모드 진행 중..."
  },
  LanguageConfig_ConfessionEventRulesDesc_CN = {
    Text = "<Title:규칙 설명>\n1, “조사 작전” 7-3·보통을 클리어한 후, 새로운 특별 조사 컨텐츠인 「번식 광란」이 오픈됩니다!\n2, 깨어남체들이 신비한 힘에 휘말려「번식 광열」 상태에 빠졌습니다... 수호자 분들은 주의하시기 바랍니다!\n3, 깨어남체의 동조율이 10레벨에 도달하면, 「현실타래의 시작점」3개를 소모하여 해당 깨어남체의 「번식 광열 이벤트」를 해금할 수 있습니다. 완료 후 「무구의 은핵」1개를 획득할 수 있습니다!"
  },
  LanguageConfig_ConfessionEventRulesTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_ConfirmationNoLongerPromptsText_1_CN = {
    Text = "오늘은 그만 보기"
  },
  LanguageConfig_ConfirmationNoLongerPromptsText_2_CN = {
    Text = "{s1}일 동안 다시 알리지 않음"
  },
  LanguageConfig_ConitinueSurvey_CN = {
    Text = "조사 계속하기"
  },
  LanguageConfig_ConsumeItemTypeName_CN = {Text = "소모품"},
  LanguageConfig_Contact_Tips_1_CN = {
    Text = "유물 칸 1개 해제!"
  },
  LanguageConfig_ContainOneSchool_CN = {
    Text = "필수 편성"
  },
  LanguageConfig_ContinueChanllengeBtnTxt_CN = {
    Text = "계속 도전하기"
  },
  LanguageConfig_ConvertedToFragment_CN = {Text = "변환됨"},
  LanguageConfig_CopyAchievementBtnGroupName_CN = {
    Text = "레벨 달성"
  },
  LanguageConfig_CopyCollectBtnGroupName_CN = {
    Text = "조사 평가"
  },
  LanguageConfig_CopyLeftLineup_CN = {
    Text = "왼쪽 진형 복사"
  },
  LanguageConfig_CopyLineup_CN = {
    Text = "진형 복사"
  },
  LanguageConfig_CopyPassword_CN = {
    Text = "복제 페이즈 값"
  },
  LanguageConfig_CopyRecording_CN = {
    Text = "재생 복사"
  },
  LanguageConfig_CopyResonanceBtnGroupName_CN = {Text = "공명"},
  LanguageConfig_CopyRightLineup_CN = {
    Text = "오른쪽 진형 복사"
  },
  LanguageConfig_CopySettleNoData_CN = {
    Text = "데이터가 아직 업데이트되지 않았습니다"
  },
  LanguageConfig_CopySettleTeamDataBlood_CN = {
    Text = "조사 종료 시 남은 HP"
  },
  LanguageConfig_CopySettleTeamDataResist_CN = {
    Text = "죽음 저항 발동 횟수"
  },
  LanguageConfig_CopySettleTeamDataRevival_CN = {
    Text = "응급 영지체 사용 횟수"
  },
  LanguageConfig_CopySettleTeamDataRound_CN = {
    Text = "최종전 턴 수"
  },
  LanguageConfig_CopySettleTitle_CN = {
    Text = "조사 데이터"
  },
  LanguageConfig_CopySettleUncleared_CN = {Text = "미완료"},
  LanguageConfig_CopySweepBtnText_CN = {Text = "재현"},
  LanguageConfig_Copy_Lock_CN = {
    Text = "{s2} {s3} 도달 시 {s1} 해제"
  },
  LanguageConfig_Copy_Recommend_Level_CN = {
    Text = "추천 레벨:"
  },
  LanguageConfig_Copy_Recommend_School_CN = {
    Text = "추천 영역:"
  },
  LanguageConfig_CosmeticsRandChestRateText_CN = {
    Text = "<Title:확률 설명>\n1. 사용 시 확률적으로 다음 중 하나를 얻을 수 있습니다.\n- 10% 확률: 「형체 없는 자의 증표」 한정 프로필 아이콘 및 페이즈 체스 감정 표현\n- 90% 확률: 과거 핵심 과제/시즌 상위 한정 프로필 아이콘 및 페이즈 체스 감정 표현\n2. 모든 한정 아이콘 및 감정 표현은 10% 확률을 균등 분배합니다. (자세한 목록은 하단의 「한정 아이콘 및 감정 표현 목록」 참고)\n3. 획득 가능 시기\n- 핵심 과제 한정 프로필 아이콘 및 감정 표현: 해당 과제 종료 후 약 1년 후 드롭 목록에 추가\n- 시즌 보상 감정 표현: 시즌 종료 직후 드롭 목록에 추가\n4. 과거 한정 아이콘 및 감정 표현은 90% 확률을 균등 분배합니다.\n- 「형체 없는 자의 초대장」 또한 과거 한정 항목으로 간주됩니다.\n- 목록에 다른 과거 한정 항목이 없을 경우, 「형체 없는 자의 초대장」이 단독으로 90%를 차지합니다.\n5. 이미 보유한 아이콘 혹은 감정 표현을 획득할 경우, 자동으로 「형체 없는 자의 초대장」 1개로 변환됩니다.\n- 초대장을 일정 수량 모으면, 「형체 없는 자의 증표」 라인업에서 원하는 아이콘 혹은 감정 표현을 선택하여 획득할 수 있습니다.\n\n<Title:한정 아이콘 및 감정 표현 목록>\n1. 한정 아이콘\n- 은열쇠의 이름으로 (엘바, 골리아, 유우하시, 카시아, 코르트, 덱스터, 실타래비아, 윌리엄)\n2. 한정 감정 표현\n- 광기의 미사그 (유우하시·내놔, 브라운·몰라, 히로·죽인다)\n- 여유의 미사그 (실타래비아·티타임, 코르트·밤샘, 오지에·경례, 로탄·형제, 라모나·민망, 돌·배터리 부족)\n- 페이즈 통신 (수호자·나?)\n- 지혜의 미사그 (골리아·강인, 레아·눈물, 노틸라·에?, 젠킨·사색, 아그리파·엿보기, 카이커스·앙심)\n- 꼬마 미사그 (젠킨·메롱)"
  },
  LanguageConfig_CosmeticsRandChestRateTitle_CN = {
    Text = "확률 설명"
  },
  LanguageConfig_CostTips_CN = {
    Text = "행동력 +{s1}"
  },
  LanguageConfig_CounterTagAwaker_CN = {
    Text = "특공 깨어남체"
  },
  LanguageConfig_CoursePopMultiTipText_CN = {
    Text = "여러 개의 튜토리얼..."
  },
  LanguageConfig_CurUenergyValue_CN = {
    Text = "현재 광기: {s1}"
  },
  LanguageConfig_CurrRefineLevelEffect_CN = {
    Text = "현재 효과"
  },
  LanguageConfig_CurrencyNotEnoughText_CN = {
    Text = "원액이 부족합니다. 원액 추출로 이동하시겠습니까?"
  },
  LanguageConfig_CurrencyNotEnoughTitle_CN = {
    Text = "원액 부족"
  },
  LanguageConfig_CurrentLevelFavorability_1_CN = {
    Text = "(현재: {s1})"
  },
  LanguageConfig_CurrentLevelFavorability_2_CN = {
    Text = "<TaskFinish:(현재: {s1})>"
  },
  LanguageConfig_CurrentTrinketSet_CN = {
    Text = "현재 프리셋: {s1}"
  },
  LanguageConfig_CutClass_Btn_Finish_CN = {
    Text = "오늘 대리 완료"
  },
  LanguageConfig_CutClass_Btn_NoRecord_CN = {
    Text = "대리 불가"
  },
  LanguageConfig_CutClass_Btn_Normal_CN = {
    Text = "미션 대리"
  },
  LanguageConfig_D05EX_Activity_Card_Tips_CN = {
    Text = "의심을 마주하고 결정을 내리기"
  },
  LanguageConfig_D05EX_Activity_Light_String_CN = {
    Text = ", 단원 3명 추가"
  },
  LanguageConfig_DBG_Sweep_Count_CN = {
    Text = "{s1}/{s2}장"
  },
  LanguageConfig_DFDESideDia10_CN = {
    Text = "「작은 선물」 하나, 어떻게 하시겠어요?"
  },
  LanguageConfig_DFDESideDia11_CN = {
    Text = "여성의 선물을 거절하면 불행해질 거에요."
  },
  LanguageConfig_DFDESideDia12_CN = {
    Text = "어머나, 이런 상황엔 소용없네."
  },
  LanguageConfig_DFDESideDia1_CN = {
    Text = "잃어버린 청춘에 대한 분노."
  },
  LanguageConfig_DFDESideDia2_CN = {
    Text = "드디어 그 성가신 걸 치워버렸네."
  },
  LanguageConfig_DFDESideDia3_CN = {
    Text = "그 눈구멍을 직접 들여다보지 마."
  },
  LanguageConfig_DFDESideDia4_CN = {
    Text = "그 녀석은 먹잇감의 살집까지 꼼꼼히 따진다네. 까다롭지?"
  },
  LanguageConfig_DFDESideDia5_CN = {
    Text = "조심해, 뇌를 먹어버릴지도 모르니까."
  },
  LanguageConfig_DFDESideDia6_CN = {
    Text = "사라져버린 것들에 유난히 집착하거든..."
  },
  LanguageConfig_DFDESideDia7_CN = {
    Text = "미사그 교외의 단조롭고 변하지 않는 풍경을 기록한 물건."
  },
  LanguageConfig_DFDESideDia8_CN = {
    Text = "「사냥개」의 습격을 막는 법을 알려드리죠."
  },
  LanguageConfig_DFDESideDia9_CN = {
    Text = "라모나의 일상을 담아낸 귀한 필름이야. 다시는 못 구하지."
  },
  LanguageConfig_DaFuDaiErHuodong1_CN = {
    Text = "맞춤형 「금기의 거래」가 나타났습니다."
  },
  LanguageConfig_DailyChallengeAll_CN = {Text = "전부"},
  LanguageConfig_DailyChallengeAttrBonus_CN = {
    Text = "속성 +50%"
  },
  LanguageConfig_DailyChallengeAwardIllustrateContent_CN = {
    Text = "1. 오늘 완료한 환몽 심잠의 최고 난이도에 따라, 다음 날 획득할 「융식의 구슬」 보상이 결정됩니다. 각 난이도별 보상은 다음과 같습니다：\n· 환몽 심잠Ⅰ：융식의 구슬 300개\n· 환몽 심잠 Ⅱ：융식의 구슬 400개\n· 환몽 심잠 Ⅲ：융식의 구슬 500개\n·환몽 심잠 Ⅳ：융식의 구슬 600개\n·환몽 심잠 Ⅴ：융식의 구슬 700개\n·환몽 심잠 Ⅵ：융식의 구슬 800개\n·환몽 심잠 Ⅶ：융식의 구슬 900개\n·환몽 심잠 · 광란：융식의 구슬 900개\n2. 보상은 다음 날 정산 우편으로 발송되므로, 반드시 확인해 주세요.\n3. 같은 날 「환몽 심잠」 또는 「대리 미션」에 참여하면서 동시에 「페이즈 체스」에도 참여한 경우, 다음 날 9시에 정산되는 융식의 구슬 보상은 일일 환몽 보상과 「페이즈 체스」 랭킹 보상 중 더 높은 보상 기준으로 지급됩니다."
  },
  LanguageConfig_DailyChallengeAwardIllustrateTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_DailyChallengeAwardPreviewTitle_CN = {
    Text = "보상 미리보기"
  },
  LanguageConfig_DailyChallengeAwardSendTimeText_CN = {
    Text = "보상은 다음 날 %s, 우편으로 발송됩니다"
  },
  LanguageConfig_DailyChallengeBloodDimension_CN = {
    Text = "혈육 초차원"
  },
  LanguageConfig_DailyChallengeBlood_CN = {
    Text = "순수 혈육"
  },
  LanguageConfig_DailyChallengeChallengeNoneText_CN = {
    Text = "오늘 도전 기록 없음"
  },
  LanguageConfig_DailyChallengeChaos_CN = {
    Text = "순수 혼돈"
  },
  LanguageConfig_DailyChallengeChosenResonanceTitle_CN = {
    Text = "선택된 공명"
  },
  LanguageConfig_DailyChallengeChosenStar_CN = {
    Text = "현재 달성 등급"
  },
  LanguageConfig_DailyChallengeClearButton_CN = {Text = "비우기"},
  LanguageConfig_DailyChallengeCountdown_Hour_CN = {
    Text = "주간 시련 보상 초기화: {s1}일 {s2}시간"
  },
  LanguageConfig_DailyChallengeCountdown_Minute_CN = {
    Text = "주간 시련 보상 초기화: {s1}시간 {s2}분"
  },
  LanguageConfig_DailyChallengeCountdown_Week_CN = {
    Text = "이번 주 순위 보상 초기화: {s1}"
  },
  LanguageConfig_DailyChallengeDimension_CN = {
    Text = "순수 초차원"
  },
  LanguageConfig_DailyChallengeEmptyTips_CN = {
    Text = "기록 없음"
  },
  LanguageConfig_DailyChallengeEnterButtonGreyTips_CN = {
    Text = "공명 도전 항목을 선택하세요"
  },
  LanguageConfig_DailyChallengeEnterButton_CN = {Text = "도전"},
  LanguageConfig_DailyChallengeExpAttenuationRulesTipsAlert_CN = {
    Text = "심잠 경험이 감소합니다"
  },
  LanguageConfig_DailyChallengeExpAttenuationRulesTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_DailyChallengeExpAttenuationRulesTips_CN = {
    Text = "·「수호자 조사 등급」이나 「파티 평균 레벨」이 도전 스테이지 추천 등급보다 현저히 높을 경우에는, 심잠 경험치가 감소합니다."
  },
  LanguageConfig_DailyChallengeExpOutAttenuation_CN = {
    Text = "보상 감소"
  },
  LanguageConfig_DailyChallengeExpOutBase_CN = {
    Text = "기본 보상"
  },
  LanguageConfig_DailyChallengeExpRewardCoefficientLevelTips_CN = {
    Text = "·「수호자 레벨」이 단계의 추천 레벨과 비슷할 경우, 도전에서 승리하면 심해 업적을 완료하고 「심해 경험」을 얻을 수 있습니다. \n   ·「도전 여정」: 도전 난이도의 「추천 레벨」이 「수호자 레벨」- 40 레벨보다 높을 때, 기본 심해 경험을 얻을 수 있습니다. \n   ·「초월 여정」: 도전 난이도의 「추천 레벨」이 「수호자 레벨」- 20 레벨보다 높을 때, 추가로 기본 심해 경험을 한 번 더 얻을 수 있습니다."
  },
  LanguageConfig_DailyChallengeExpRewardTask1_CN = {
    Text = "도전 여정"
  },
  LanguageConfig_DailyChallengeExpRewardTask2_CN = {
    Text = "초월의 여정"
  },
  LanguageConfig_DailyChallengeInstructionsExample_CN = {
    Text = "({s1})「{s2}」: {s3}"
  },
  LanguageConfig_DailyChallengeInstructionsV2_CN = {
    Text = "<Title:[환몽심잠]>\n·초기 유물, 단계 유물은 매주 월요일 9시(GMT+8)에 변경됩니다.\n·매 도전 시 무작위 도전 시나리오에 진입합니다.\n<Title:[심잠 경험치]>\n·「수호자 레벨」이 단계의 권장 레벨과 비슷할 경우, 도전 승리 시 심잠 업적을 완료하여 「심잠 경험치」를 획득할 수 있습니다.\n   ·「도전 여정」: 도전 난이도의 「권장 레벨」이 「수호자 레벨」- 40 레벨보다 높을 때, 기본 심잠 경험치를 획득할 수 있습니다.\n   ·「초월 여정」: 도전 난이도의 「권장 레벨」이 「수호자 레벨」- 20 레벨보다 높을 때, 기본 심잠 경험치를 추가로 1회 더 획득할 수 있습니다.\n<Title:[심잠 레벨]>\n·심잠 경험치가 일정 수치에 도달하면 심잠 레벨이 상승합니다. 레벨이 오를 때마다 풍부한 보상을 획득할 수 있습니다.\n<Title:[시즌 업데이트]>\n·일반적으로 시즌은 28일마다 초기화됩니다.\n·조사 종료 시 조사 점수를 획득하며, 매 시즌 해당 시즌의 최고 조사 점수를 기록하여 해당 시즌 순위에 사용합니다. 반복 조사를 통해 점수를 높일 수 있습니다. 다른 수호자와 조사 점수가 동일할 경우 같은 순위로 처리됩니다.\n·시즌 종료 시 해당 시즌 순위가 정산되며, 이메일을 통해 해당 시즌 순위 보상이 발송됩니다. 수호자는 「순위표」-「순위 보상」을 클릭하여 순위 보상을 확인할 수 있습니다.\n·매 시즌마다 시즌 임무가 있으며, 시즌 임무를 완료하면 풍부한 보상을 획득할 수 있습니다. 시즌 임무는 시즌 종료 시 초기화됩니다.\n<Title:[매 시즌 강화 깨어남체]>\n·매 시즌 각 영역에서 무작위 깨어남체 2명이 해당 시즌의 환몽심잠 행동 중 광폭화되어 체력, 공격력, 방어력이 50% 상승합니다.\n<Title:[조사 점수]>\n·조사 종료 시 현재 단계의 난이도 기본 점수와 완료한 평가 항목으로 정산하며, 높은 난이도에 도전할수록 난이도 기본 점수가 높아집니다.\n·아래는 구체적인 평가 항목입니다.\n1、「시간의 모래시계」: 초기 라운드는 50이며, 잔여 1라운드마다 추가로 20점을 획득합니다.\n2、「심연의 부름」: 강화 깨어남체 1 / 2 / 3 / 4명을 출전시킬 때, 250 / 500 / 750 / 1000점을 획득합니다.\n3、「환경 구조」: 응급 영지체를 1회 사용할 때마다 조사 점수가 20% 감소하며, 여러 번 발동 시 여러 번 곱산됩니다.\n4、「꿈의 개척자」: 매일 첫 플레이 시 500점을 획득합니다."
  },
  LanguageConfig_DailyChallengeInstructions_CN = {
    Text = "<Title:[환몽심잠]>\n· 초기 유물, 단계 유물은 매주 월요일 9시(GMT+8)에 변경됩니다.\n· 매번 도전 시 무작위 도전 시나리오에 진입합니다.\n<Title:[심잠 경험]>\n· 「수호자 레벨」이 단계의 추천 레벨과 비슷하다면, 도전 승리 시 심잠 업적을 달성하여 「심잠 경험」을 획득할 수 있습니다.\n   · 「도전 여정」: 도전 난이도의 「추천 레벨」이 「수호자 레벨」- 40 레벨 보다 높을 때, 기본 심잠 경험을 획득할 수 있습니다.\n   · 「초월 여정」: 도전 난이도의 「추천 레벨」이 「수호자 레벨」- 20 레벨 보다 높을 때, 기본 심잠 경험을 추가로 1회 더 획득할 수 있습니다.\n<Title:[심잠 레벨]>\n· 심잠 경험이 일정 수치에 도달하면 심잠 레벨이 상승합니다. 레벨이 오를 때마다 풍성한 보상을 획득할 수 있습니다.\n<Title:[시즌 업데이트]>\n· 일반적으로 시즌은 28일마다 초기화됩니다.\n· 탐사 종료 후 조사 평점이 매겨지며, 매 시즌 본 시즌 최고 조사 평점이 해당 시즌 랭킹에 기록됩니다. 평점 향상을 위해 반복 탐사가 가능합니다. 다른 수호자와 조사 평점이 동일할 경우, 같은 순위로 간주됩니다.\n· 시즌 종료 시 본 시즌 순위가 정산되며, 본 시즌 순위 보상이 메일로 발송됩니다. 수호자는 「랭킹」-「랭킹 보상」을 클릭하여 랭킹 보상을 확인할 수 있습니다.\n· 매 시즌마다 시즌 임무가 있으며, 시즌 임무를 완료하면 풍성한 보상을 획득할 수 있습니다. 시즌 임무는 시즌 종료 시 초기화됩니다.\n<Title:[시즌별 깨어남체 강화]>\n· 매 시즌 각 계역에서 무작위 깨어남체 2명이 본 시즌 환몽심잠 행동 중 광폭화되어, 체력, 공격, 방어가 50% 상승합니다.\n<Title:[조사 평점]>\n· 탐사 종료 시 현재 단계의 난이도 기본 점수와 완료한 평점 항목으로 정산되며, 높은 난이도에 도전할수록 난이도 기본 점수가 높아집니다.\n· 아래는 구체적인 평점 항목입니다.\n1,「시간의 모래시계」: 초기 턴은 50점이며, 잔여 1턴마다 추가로 20점을 획득합니다.\n2,「심연 호출」: 강화 깨어남체 1/2명을 출전 시 사용할 때, 250 / 500점을 획득합니다.\n3,「환경 구조」: 응급 영지체 1회 사용 시마다 조사 평점이 20% 감소하며, 여러 번 발동 시 여러 번 곱산됩니다.\n4,「꿈 개척자」: 매일 첫 플레이 시 500점을 획득합니다."
  },
  LanguageConfig_DailyChallengeLevel_CN = {
    Text = "{s1} 레벨"
  },
  LanguageConfig_DailyChallengeLimitedDoubleLessTip_CN = {Text = "2배"},
  LanguageConfig_DailyChallengeLimitedDoubleShortTip_CN = {
    Text = "기간 한정 2배"
  },
  LanguageConfig_DailyChallengeLimitedDoubleTip_CN = {
    Text = "한시적 두 배 경험치"
  },
  LanguageConfig_DailyChallengeLiquidation_CN = {
    Text = "랭킹 정산 중..."
  },
  LanguageConfig_DailyChallengeLockedResonanceTips_CN = {
    Text = "상위 공명 도전을 완료하여 해금"
  },
  LanguageConfig_DailyChallengeMagnificationDescribe_CN = {
    Text = "현재 조사 평점 배율 x{s1}, 최종 평점은 조사 완료 시점을 기준으로 합니다."
  },
  LanguageConfig_DailyChallengeOceanBlood_CN = {
    Text = "심해 혈육"
  },
  LanguageConfig_DailyChallengeOceanDimension_CN = {
    Text = "심해 초차원"
  },
  LanguageConfig_DailyChallengeOcean_CN = {
    Text = "순수 심해"
  },
  LanguageConfig_DailyChallengeRankingRuleDesc_CN = {
    Text = "1. 조사 칭호의 랭킹 구간은 해당 구역 랭킹 참여 인원수에 따라 동적으로 변동됩니다. 구간 비율은 다음과 같습니다.\n환몽의 지배자: 상위 1%\n심해 잠수 대가: 1% ~ 5%\n심해 학자: 5% ~ 15%\n꿈 견습: 15% ~ 35%\n잠수 초심자: 35% ~ 75%\n불면증 환자: 75% 이후\n2. 참여 인원이 적은 구역 랭킹의 경우, 높은 조사 칭호에는 추가 명단이 제공됩니다.\n따라서 참여자가 적은 구역에 참가할수록 높은 조사 칭호와 더 많은 랭킹 보상을 받을 가능성이 높아집니다.\n추가 명단 수는 전일 환몽 심연 참여 인원수를 기준으로 결정됩니다.\n3. 다른 수호자와 점수가 동일한 경우, 랭킹은 도전 시간 순으로 정렬됩니다.\n하지만 랭킹 보상은 해당 점수에서 가장 높은 순위를 기준으로 지급됩니다."
  },
  LanguageConfig_DailyChallengeRankingRuleTitle_CN = {
    Text = "랭킹 규칙"
  },
  LanguageConfig_DailyChallengeResonanceSelectTips_CN = {
    Text = "오른쪽에서 공명 선택"
  },
  LanguageConfig_DailyChallengeResonanceSelectTitle_CN = {
    Text = "공명 선택지"
  },
  LanguageConfig_DailyChallengeRewardButtonText_CN = {
    Text = "보상 규칙"
  },
  LanguageConfig_DailyChallengeRewardCount_CN = {
    Text = "누적 보상 {s1}/{s2}"
  },
  LanguageConfig_DailyChallengeRewardPreview_CN = {
    Text = "보상 미리보기"
  },
  LanguageConfig_DailyChallengeRewardTips_1_CN = {
    Text = "더 높은 도전 난이도를 선택하면 더 많은 보상을 획득할 수 있습니다"
  },
  LanguageConfig_DailyChallengeRewardTips_2_CN = {
    Text = "모든 보상을 획득했습니다"
  },
  LanguageConfig_DailyChallengeRewardTips_CN = {
    Text = "도전 난이도 달성"
  },
  LanguageConfig_DailyChallengeRightWeeklyTitle_CN = {
    Text = "이번 주 심해 기록"
  },
  LanguageConfig_DailyChallengeRules_CN = {
    Text = "환몽 심잠 규칙"
  },
  LanguageConfig_DailyChallengeScoreBase_CN = {
    Text = "난이도 기본 점수: <OptionHighlight_Dadly: {s1}>"
  },
  LanguageConfig_DailyChallengeScoreMultiple_CN = {
    Text = "점수 배율\n<OptionHighlight_Dadly:× {s1}>"
  },
  LanguageConfig_DailyChallengeStarAwardShort_CN = {
    Text = "다음 단계 보상 획득까지 {s1}성 필요"
  },
  LanguageConfig_DailyChallengeTips_CN = {
    Text = "막간 훈련: 모든 깨어남체의 레벨, 스킬 레벨이 1로 조정됩니다. 유물 강도가 수호자 조사 등급 1일 때의 강도로 조정됩니다."
  },
  LanguageConfig_DailyChallengeTodayRelicGetConfirmButton_CN = {Text = "확인"},
  LanguageConfig_DailyChallengeTodayRelicGetTitle_CN = {
    Text = "일일 유물 획득"
  },
  LanguageConfig_DailyChallengeTodayRelicTitle_CN = {
    Text = "오늘의 유물"
  },
  LanguageConfig_DailyChallengeTodayStarTitle_CN = {
    Text = "오늘의 최고 달성 등급"
  },
  LanguageConfig_DailyChallengeUnlockNewResonanceConfirmButton_CN = {Text = "확인"},
  LanguageConfig_DailyChallengeUnlockNewResonanceTitle_CN = {
    Text = "신규 공명 해금"
  },
  LanguageConfig_DailyChallenge_CN = {
    Text = "융식 구슬"
  },
  LanguageConfig_DailyChallenge_CurrentProgress_CN = {
    Text = "(현재: {s1})"
  },
  LanguageConfig_DailyChallengexSettlementBasicScoreTips_CN = {
    Text = "도전한 스테이지 난이도에 따라 획득한 난이도 기초 점수"
  },
  LanguageConfig_DailyChallengexSettlementBasicScoreTitle_CN = {
    Text = "환몽 심잠 점수"
  },
  LanguageConfig_DailyCopyChallengeBtnText_CN = {Text = "도전"},
  LanguageConfig_DailyCopyRules_CN = {
    Text = "1. 융식의 폐허에서 스테이지를 클리어하면 대량의 깨어남체 승격 재료, 영지 비약, 장미 금권을 획득할 수 있습니다.\n2. 스테이지 도전 완료 후 재현이 해금되며, 재현을 통해 해당 스테이지의 미션 보상을 즉시 획득할 수 있습니다. 재현 시에는 조사에 필요한 것과 동일한 양의 린피테이프가 소모됩니다.\n3. 조사 레벨이 25에 도달하면 스킬 재료 스테이지가 해금됩니다."
  },
  LanguageConfig_DailyCopy_Start_CN = {Text = "도전"},
  LanguageConfig_DailyCopy_Str_Blood_Title_CN = {
    Text = "유기 잔상"
  },
  LanguageConfig_DailyCopy_Str_Dialog_CN = {
    Text = "스테이지를 완료하여 재료를 획득할 수 있습니다.\n가져갈 수 있는 건 전부 챙겨주세요."
  },
  LanguageConfig_DailyCopy_Str_Dimension_Title_CN = {
    Text = "차원 잔상"
  },
  LanguageConfig_DailyCopy_Str_Money_Exp_CN = {
    Text = "약재 연마"
  },
  LanguageConfig_DailyCopy_Str_Money_Title_CN = {
    Text = "금권 수사"
  },
  LanguageConfig_DailyCopy_Str_Ocean_Title_CN = {
    Text = "해연 잔상"
  },
  LanguageConfig_DailyCopy_Str_Title_CN = {
    Text = "융식의 폐허"
  },
  LanguageConfig_DailyCopy_Str_TrinketCopy_CN = {
    Text = "스테이지를 완료하여 비밀 계약을 획득할 수 있습니다.\n가져갈 수 있는 건 전부 챙겨주세요."
  },
  LanguageConfig_DailyHistoryLevelViewTitle_DailyChallenge_CN = {
    Text = "심잠 보상"
  },
  LanguageConfig_DailyHistoryLevelViewTitle_DailyChallenge_ExpProgress_CN = {
    Text = "심잠 경험 {s1}"
  },
  LanguageConfig_DailyResetTips_CN = {
    Text = "날짜 갱신, 메인 화면으로 돌아갑니다"
  },
  LanguageConfig_Daily_First_Finish_CN = {
    Text = "첫 클리어"
  },
  LanguageConfig_Daily_First_Finish_Tips_CN = {
    Text = "클리어 후 다음 단계 보상 획득"
  },
  LanguageConfig_DataStatistics_CN = {
    Text = "데이터 통계"
  },
  LanguageConfig_DataTransmissionTips_CN = {
    Text = "데이터 전송이 진행 중이니, 잠시 기다려 주세요."
  },
  LanguageConfig_DateFormat_CN = {
    Text = ": {s1}～{s2}"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_10_CN = {
    Text = "적 체력 +750%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_11_CN = {
    Text = "적 체력 +1000%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_12_CN = {
    Text = "적 체력 +1100%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_13_CN = {
    Text = "적 체력 +1200%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_14_CN = {
    Text = "적 체력 +1300%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_15_CN = {
    Text = "적 체력 +1400%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_16_CN = {
    Text = "적 체력 +1500%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_1_CN = {
    Text = "난이도 보너스 없음"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_2_CN = {
    Text = "적 체력 +25%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_3_CN = {
    Text = "적 체력 +75%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_4_CN = {
    Text = "적 체력 +125%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_5_CN = {
    Text = "적 체력 +200%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_6_CN = {
    Text = "적 체력 +275%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_7_CN = {
    Text = "적 체력 +350%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_8_CN = {
    Text = "적 체력 +450%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_9_CN = {
    Text = "적 체력 +600%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_10_CN = {
    Text = "적 피해 +150%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_11_CN = {
    Text = "적 피해 +200%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_12_CN = {
    Text = "적 피해 +220%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_13_CN = {
    Text = "적 피해 +240%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_14_CN = {
    Text = "적 피해 +260%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_15_CN = {
    Text = "적 피해 +280%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_16_CN = {
    Text = "적 피해 +300%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_1_CN = {
    Text = "난이도 보너스 없음"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_2_CN = {
    Text = "적 피해 +5%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_3_CN = {
    Text = "적 피해 +15%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_4_CN = {
    Text = "적 피해 +25%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_5_CN = {
    Text = "적 피해 +40%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_6_CN = {
    Text = "적 피해 +55%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_7_CN = {
    Text = "적 피해 +70%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_8_CN = {
    Text = "적 피해 +90%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_9_CN = {
    Text = "적 피해 +120%"
  },
  LanguageConfig_Day_CN = {Text = "일"},
  LanguageConfig_DeathResistFail_CN = {
    Text = "<color=#FF7370>죽음 저항 실타래패</color>"
  },
  LanguageConfig_DeathResist_1_CN = {
    Text = "죽음 저항!"
  },
  LanguageConfig_DeathResistance_CN = {
    Text = "<color=#E3FFE3>죽음 저항</color>"
  },
  LanguageConfig_DecomposeButtonText_CN = {Text = "분해"},
  LanguageConfig_DecomposeTimes_CN = {
    Text = "분해 수량"
  },
  LanguageConfig_DecomposeTitle_CN = {
    Text = "명륜 분해"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips10_CN = {
    Text = "레벨 보정:"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips11_CN = {
    Text = "레벨 보정:"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips12_CN = {
    Text = "레벨 보정:"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips13_CN = {
    Text = "「신국에 비치는 그림자: 이변 해조」에서는, 수호자들이 함께 침공에 맞설 수 있도록 레벨 보정 메커니즘이 적용됩니다!\n레벨 보정 규칙은 다음과 같습니다:\n1. 탐사 팀 내 깨어남체의 레벨이 60 미만일 경우. 이번 도전에서는 60으로 보정됩니다.\n2. 탐사 팀 내 깨어남자의 스킬 레벨이 5 미만일 경우. 이번 도전에서는 5로 보정됩니다.\n3. 탐사 팀 내에 깨어남체의 「광기의 징조」가 6 미만일 경우. 이번 도전에서는 6으로 보정됩니다.\n4. 탐사 팀 내 깨어남체의 「영혼 단련」이 5 미만일 경우. 이번 도전에서는 5로 보정됩니다.\n5. 수호자 조사 레벨이 60 미만일 경우. 이번 도전에서는 60으로 보정됩니다."
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips14_CN = {
    Text = "이번 이변 해조 군집이 소멸되어, 도전을 계속할 수 없습니다."
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips15_CN = {
    Text = "모든 이변 해조 군집이 소멸되어, 도전을 계속할 수 없습니다."
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips1_CN = {
    Text = "다른 수호자들과 함께 싸워 희귀한 보상을 얻으세요"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips2_CN = {
    Text = "모든 흑조 군집이 소멸되었습니다."
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips3_CN = {
    Text = "도전 시작"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips4_CN = {
    Text = "오늘의 도전 {s1}"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips5_CN = {
    Text = "월드 보스 진행도"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips7_CN = {
    Text = "오늘의 도전 {s1}"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips8_CN = {
    Text = "오늘의 도전 {s1}"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips9_CN = {
    Text = "레벨 보정"
  },
  LanguageConfig_DefaultName_CN = {
    Text = "실타래베스터"
  },
  LanguageConfig_DefaultWord_CN = {Text = "기본"},
  LanguageConfig_DerivedCardDesc_CN = {
    Text = "파생 카드 설명"
  },
  LanguageConfig_DestroyWeapon_CN = {
    Text = "<color=#FF7370>명륜 파괴</color>"
  },
  LanguageConfig_Dev_EnterAccount_CN = {
    Text = "계정을 입력해주세요"
  },
  LanguageConfig_Dev_SelectServer_CN = {
    Text = "서버를 선택해주세요"
  },
  LanguageConfig_DiamondDonateDesc_CN = {
    Text = "당신이 기부한 모든 원액은 소중합니다. 기부금은 융식 연구와 학교 건설에 투입되고, 미사그의 일부가 되어 우리 모두의 잊히지 않는 미래로 향할 것입니다. \n은열쇠가 우리를 인도하길."
  },
  LanguageConfig_DiamondDonateTipContent_CN = {
    Text = "<Title:기부 규칙>\n· 「원액 기부」를 통해 소모된 원액은 모두 누적 기부 값에 포함됩니다.\n· 또한, 「깨어남」에서 은심이 부족할 때 직접 기부한 원액도 포함됩니다.\n<Title:보상 규칙>\n· 원액 1을 기부할 때마다 공헌치 1을 획득합니다.\n· 공헌치가 2500에 도달하면 특별한 보상을 1회 받을 수 있습니다.\n· 20회의 보상이 한 사이클을 형성합니다.\n· 각 사이클의 총 보상은 다음과 같습니다: 원초 영핵 x1, 추억의 깃펜 x400, 천면인장 x1000, 장미 금권 x5000000."
  },
  LanguageConfig_DiamondDonateTipTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_DiamondShop_Str_Title_CN = {
    Text = "은심 구매"
  },
  LanguageConfig_DimensionAbilityCoolDown_CN = {
    Text = "「멸망」 태세가 쿨다운 중이어서 사용할 수 없습니다. 남은 쿨다운 턴: {s1}"
  },
  LanguageConfig_DisasterReliefKuroshioEntryNameFormat_CN = {Text = "{s1}: {s2}"},
  LanguageConfig_DisasterReliefKuroshioTipsDesc_CN = {
    Text = "수호자들에게 알립니다. 조사가 진행됨에 따라, 융식의 파도로 인한 환경 특성이 달라지고, 특정 지역에 영향을 미칩니다."
  },
  LanguageConfig_DisasterReliefKuroshio_CN = {
    Text = "융식의 파도"
  },
  LanguageConfig_DispatchAgain_CN = {
    Text = "다시 파견"
  },
  LanguageConfig_DispatchClear_CN = {Text = "비우기"},
  LanguageConfig_DispatchClose_CN = {Text = "닫기"},
  LanguageConfig_DispatchNoReceiveTask_CN = {
    Text = "완료된 파견이 없습니다"
  },
  LanguageConfig_DispatchNormal_CN = {Text = "파견"},
  LanguageConfig_DispatchOneClickFormation_CN = {
    Text = "빠른 출전"
  },
  LanguageConfig_DispatchReceiveAll_CN = {
    Text = "일괄 수령"
  },
  LanguageConfig_DispatchSucessfulTip_CN = {
    Text = "파견 성공"
  },
  LanguageConfig_Dispel_Tips_CN = {
    Text = "{s1} 제거"
  },
  LanguageConfig_DissolutionJewelShopRules_CN = {
    Text = "1. 수호자는 일정 수량의 「융식의 구슬」을 소모하여 상품을 교환할 수 있습니다.\n2. 수호자 조사 레벨이 상승하면, 심잠 교환 상점에 새로운 상품이 해금됩니다.\n3. 심잠 교환 상점 상품은 일정 시간마다 자동으로 재고가 갱신됩니다.\n4. 수호자는 「환몽 심잠」 또는 「페이즈 체스」을 통해 「융식의 구슬」을 획득할 수 있습니다."
  },
  LanguageConfig_Dot_CN = {Text = "."},
  LanguageConfig_DoubleExperience_01_CN = {
    Text = "경험치 2배"
  },
  LanguageConfig_DoubleExperience_02_CN = {Text = "추가"},
  LanguageConfig_DoubleExperience_03_CN = {
    Text = "과제 경험치 2배"
  },
  LanguageConfig_DoubleKill_CN = {
    Text = "더블 킬!"
  },
  LanguageConfig_DoubleOutputActivityBonusHead_CN = {
    Text = "보상 +100%"
  },
  LanguageConfig_DoubleOutputActivityRemainTimes_CN = {
    Text = "{s1}회 남음"
  },
  LanguageConfig_DoubleOutputActivityStageTips_CN = {
    Text = "오늘 남은 두 배 보상 횟수:<DoubleOutputActivityTimes:{s1}/{s2}>"
  },
  LanguageConfig_DoubleOutputActivityTimesHead_CN = {
    Text = "오늘 추가 보상 +{s1}%"
  },
  LanguageConfig_DoubleOutputActivityTimesRunOut_CN = {
    Text = "오늘의 2배 보상 횟수 소진"
  },
  LanguageConfig_DoubleOutputActivityTimes_CN = {
    Text = "오늘의 추가 보상 +50%"
  },
  LanguageConfig_DownloadStorageSpaceTips_CN = {
    Text = "저장 공간이 부족합니다, 최소 {s1}의 저장 공간을 확보해 주세요. 저장 공간 부족 시 실타래행 중 리소스가 손실타래될 위험이 있습니다."
  },
  LanguageConfig_DrawEmptyStr_CN = {
    Text = "모든 보상을 획득했습니다"
  },
  LanguageConfig_DrawOneStr_CN = {
    Text = "1회 추출"
  },
  LanguageConfig_DressingWord_CN = {Text = "착용 중"},
  LanguageConfig_DropItemTypeName_CN = {
    Text = "선물 상자"
  },
  LanguageConfig_DynamicStageRuleDesc_CN = {
    Text = "· 해당 스테이지의 난이도는 수호자 조사 등급에 따라 달라집니다. 조사 등급이 높을수록 적이 강해지지만, 클리어 후 얻을 수 있는 장미 금권, 영지 비약, 동조율 보상이 약간 증가합니다."
  },
  LanguageConfig_DynamicStageRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_EffectDescription_CN = {
    Text = "효과 설명"
  },
  LanguageConfig_EmojiCommonDesc_CN = {
    Text = "[감정 표현]"
  },
  LanguageConfig_EnchantDesc_CN = {
    Text = "각인 설명"
  },
  LanguageConfig_EnchantGroup_1_CN = {Text = "각인"},
  LanguageConfig_EnchantGroup_2_CN = {
    Text = "「다중 치유」이벤트 각인"
  },
  LanguageConfig_EnchantStoreTitle_CN = {
    Text = "각인 융식 흔적"
  },
  LanguageConfig_EnchantmentAwardButton_CN = {Text = "각인"},
  LanguageConfig_EnchantmentAwardFull_CN = {
    Text = "모든 카드에 각인이 새겨져 있습니다"
  },
  LanguageConfig_EnchantmentAwardLevelUp_CN = {
    Text = "행운의 각인!"
  },
  LanguageConfig_EnchantmentAwardTitle2_CN = {
    Text = "카드 2장에 각인 새기기"
  },
  LanguageConfig_EnchantmentAwardTitle_CN = {
    Text = "카드에 각인 새기기"
  },
  LanguageConfig_EnchantmentAwardUncheck_CN = {
    Text = "각인 새길 카드를 선택하기"
  },
  LanguageConfig_EnchantmentUnit8_Title1_CN = {
    Text = "카드 1장을 선택하여 「번식의 이치」 깨우치기"
  },
  LanguageConfig_EnchantmentUnit8_Title1_plus_CN = {
    Text = "카드 1장을 선택하여「번식의 이치」를 완전히 깨우치기"
  },
  LanguageConfig_EnchantmentUnit8_Title2_CN = {
    Text = "카드 1장을 선택하여 「환희의 이치」 깨우치기"
  },
  LanguageConfig_EnchantmentUnit8_Title2_plus_CN = {
    Text = "카드 1장을 선택하여「환희의 이치」를 완전히 깨우치기"
  },
  LanguageConfig_EnchantmentUnit8_Title3_CN = {
    Text = "카드 1장을 선택하여「지혜의 이치」깨우치기"
  },
  LanguageConfig_EnchantmentUnit8_Title3_plus_CN = {
    Text = "카드 1장을 선택하여「지혜의 이치」를 완전히 깨우치기"
  },
  LanguageConfig_EnchantmentUnit8_Title4_CN = {
    Text = "최대 2장의 카드를 선택하여 「심해의 반향」 각인을 부여."
  },
  LanguageConfig_EnergyCommonAutoRecoverTips_CN = {
    Text = "현재 보충 속도: 1개/5분"
  },
  LanguageConfig_EnergyMonthCardCountDownDesc_CN = {
    Text = "남은 수령일 <color=#21849a>{s1}</color> 일"
  },
  LanguageConfig_EnergyMonthCardDailyRewardDesc_CN = {
    Text = "30일 동안 매일 우편으로 수령 가능"
  },
  LanguageConfig_EnergyMonthCardImmediateRewardDesc_CN = {
    Text = "구매 시 즉시 획득"
  },
  LanguageConfig_EnergyMonthCardOutLimitDayTips_CN = {
    Text = "현재 잔여 기간({s1}일)이 {s2}일을 초과하여 구매할 수 없습니다."
  },
  LanguageConfig_EnergyMonthCardRuleContent_CN = {
    Text = "[일일 보급 소개]\n- 일일 보급 구매 시 즉시 「은심」× 680과 30일간의 일일 보급 유효 시간이 지급됩니다.\n- 일일 보급 유효 기간 동안 매일 메일함에서 「린피테이프」 × 300과 「추억의 깃펜」 × 30을 획득할 수 있습니다. (매일 오전 10시 갱신, 한국 시간 기준)\n\n[주의 사항]\n- 일일 보급 잔여 유효 기간이 180일 이하일 때 추가 구매 시, 총 유효 시간이 연장됩니다.\n- 일일 보급 잔여 유효 기간이 180일을 초과할 경우 구매할 수 없습니다.\n- 특별한 사유로 중복 구매가 발생할 경우, 총 유효 기간은 누적되지 않으며 「은심」 × 680이 반환됩니다.\n- 일일 보급 유효 기간 중 수령하지 않은 「린피테이프」와 「추억의 깃펜」은 반환되지 않습니다."
  },
  LanguageConfig_EnergyMonthCardRuleTitle_CN = {
    Text = "일일 보급 설명"
  },
  LanguageConfig_EnergyOverAutoRecoverTips_CN = {
    Text = "현재 보충 속도: 1개/15분"
  },
  LanguageConfig_Energy_Buy_Item_Acess_CN = {
    Text = "현재 은심"
  },
  LanguageConfig_Energy_Buy_Item_Used_CN = {
    Text = "은심 소모"
  },
  LanguageConfig_Energy_Countdown_Str_CN = {
    Text = "{s1} 후 린피테이프 1pt를 회복합니다"
  },
  LanguageConfig_Energy_Revert_Str_Content_CN = {
    Text = "「린피테이프」를 회복하시겠습니까?"
  },
  LanguageConfig_Energy_Revert_Str_Num_CN = {
    Text = "린피테이프"
  },
  LanguageConfig_Energy_Revert_Str_Time_CN = {
    Text = "(오늘 남은 회복 횟수 {s1}/{s2}회)"
  },
  LanguageConfig_Energy_Revert_Str_Title_CN = {
    Text = "린피테이프 회복"
  },
  LanguageConfig_EnhancedPrompt_CN = {
    Text = "이번 시즌 {s1} 은(는) 환몽 심잠에서 행동할 때 광폭화하여 체질, 공격력, 방어력이 50% 상승합니다."
  },
  LanguageConfig_EnterPassword_CN = {
    Text = "상위 값 입력"
  },
  LanguageConfig_Event_ItemOwnCnt_CN = {
    Text = "보유 수: {s1}"
  },
  LanguageConfig_Event_ItemUseCancel_CN = {Text = "취소"},
  LanguageConfig_Event_ItemUseCnt_CN = {
    Text = "사용 수량"
  },
  LanguageConfig_Event_ItemUseConfirm_CN = {Text = "확인"},
  LanguageConfig_Event_ItemUseLeftCnt_CN = {
    Text = "남은 양: {s1}"
  },
  LanguageConfig_Event_ItemUseTitle_CN = {
    Text = "빠른 사용"
  },
  LanguageConfig_Event_Shop_BuyBtn_N_CN = {Text = "취소"},
  LanguageConfig_Event_Shop_BuyBtn_Y_CN = {Text = "확인"},
  LanguageConfig_Event_Shop_BuyTip_1_CN = {
    Text = "검은 인장 부족"
  },
  LanguageConfig_Event_Shop_BuyTip_2_CN = {
    Text = "검은 인장 부족"
  },
  LanguageConfig_Event_Shop_String_5_CN = {Text = "품절"},
  LanguageConfig_ExaltUpgradeDescription_CN = {
    Text = "다른 스킬의 평균 레벨과 같음"
  },
  LanguageConfig_ExchangeConfirmText_CN = {
    Text = "은심이 부족합니다. {s1} 원액을 동일한 양의 은심으로 교환하시겠습니까?"
  },
  LanguageConfig_ExchangeConfirmTitle_CN = {
    Text = "은심 부족"
  },
  LanguageConfig_ExchangeConfirm_CN = {
    Text = "치환 확정"
  },
  LanguageConfig_ExchangeCostInfoPreviewTips_CN = {
    Text = "치환을 통해 <Blue:{s2}> <Blue:{s1}>개를 획득합니다"
  },
  LanguageConfig_ExchangeCostItemEnoughTips_CN = {
    Text = "치환 결과"
  },
  LanguageConfig_ExchangeCostItemNotEnoughTips_CN = {
    Text = "재료 부족"
  },
  LanguageConfig_ExchangeCostItemNumNotEnoughTips_CN = {
    Text = "선택한 재료가 {s1}개 부족하여 치환이 불가능합니다."
  },
  LanguageConfig_ExchangeCostItemNumReachLimitTips_CN = {
    Text = "선택된 소모품 수량이 최대치에 도달했습니다"
  },
  LanguageConfig_ExchangeCostSelectLimitTips_CN = {
    Text = "최대 6종류의 재료만 선택할 수 있습니다."
  },
  LanguageConfig_ExchangeCostSelectPanelTips_CN = {
    Text = "선택한 재료를 소모하여 새로운 재료 <Blue:{s1}> 개를 치환할 수 있습니다"
  },
  LanguageConfig_ExchangeCostSelectPanelTitle_CN = {
    Text = "재료 선택"
  },
  LanguageConfig_ExchangeNumZeroText_CN = {
    Text = "교환 수량은 0일 수 없습니다"
  },
  LanguageConfig_ExchangePlanSaveTips_CN = {
    Text = "「천면인장」 부족 시 치환 설정이 저장되었습니다."
  },
  LanguageConfig_ExchangeShopRules_CN = {
    Text = "<Title:교환 상점>\n·수호자는 각종 교환 상점에서 일정량의 해당 화폐를 소모하여 상품을 교환할 수 있습니다.\n·수호자의 조사 레벨이 상승하면, 교환 상점도 함께 업그레이드되어 새로운 콘텐츠가 해금됩니다.\n·교환 상점 내의 상품은 일정 시간마다 자동으로 재고가 새로워집니다.\n\n<Title:금권 교환>\n·수호자는 처음으로 주요 조사 사건을 클리어하거나 「융흔의 유적: 금권 수사」, 「파견 보상」, 「과제 보상」 및 한정 시간 플레이 활동 보상을 통해 「장미 금권」을 얻을 수 있습니다.\n\n<Title:침전 교환>\n·수호자는 깨어남을 통해 「근원 침전」을 얻을 수 있습니다.\n\n<Title:조사 교환>\n·수호자는 주요 조사 사건에서 3성 단계의 별을 얻거나 「초월 존재」를 통해 「조사 배지」를 얻을 수 있습니다.\n\n<Title:무광 교환>\n·수호자는 「무광의 영역」이나 「융재 금역」을 통해 「검은 공급물」을 얻을 수 있습니다.\n\n<Title:융주 교환>\n·수호자는 「상훈 미션: 매주 시험」을 통해 「융흔의 구슬」을 얻을 수 있습니다."
  },
  LanguageConfig_ExchangeTips_CN = {
    Text = "다음 재료를 소모하여 <Blue:{s3}> <Blue:{s2}> 개를 획득하시겠습니까?"
  },
  LanguageConfig_ExchangeTitle_CN = {
    Text = "은심 교환"
  },
  LanguageConfig_Exchange_Start_CN = {Text = "치환"},
  LanguageConfig_ExitInvestigation_CN = {
    Text = "조사 종료"
  },
  LanguageConfig_ExpFullTips_CN = {
    Text = "가득 찼음"
  },
  LanguageConfig_ExpiredConvertText_CN = {
    Text = "일부 아이템이 변환되었습니다"
  },
  LanguageConfig_ExpiredText_CN = {
    Text = "다음 아이템은 기간이 만료되어 사용할 수 없습니다."
  },
  LanguageConfig_ExploreCurseConfirm_CN = {
    Text = "스트레스를 감수하고 전진 (압력 폐기)"
  },
  LanguageConfig_ExploreCurseDesc_CN = {
    Text = "극심한 압박 속에서, 당신의 정신은 점점 더 팽팽해지며 보이지 않는 임계점에 가까워집니다. (스트레스 손실타래)\n\n\"{s2}\" 카드 {s1}장을 획득했습니다."
  },
  LanguageConfig_ExploreCurseTitle_CN = {
    Text = "증상 (스트레스 손실타래)"
  },
  LanguageConfig_ExploreSpiritDesc_CN = {
    Text = "어디서 왔는지 알 수도 없는 시선이 실타래존하는 것처럼 당신을 짓누릅니다. 숨쉬기가 가빠져 가고, 눈앞이 점차 흐려지고 있습니다…… (스트레스 손실타래)"
  },
  LanguageConfig_ExploreSpiritTitle_CN = {
    Text = "스트레스 과부하 (스트레스 손실타래)"
  },
  LanguageConfig_ExploreStressMaxReduceMaxHP_CN = {
    Text = "{s1} 최대 HP"
  },
  LanguageConfig_ExploreStressRaise_CN = {
    Text = "+{s1} 스트레스"
  },
  LanguageConfig_ExtraGift_CN = {
    Text = "추가 증정"
  },
  LanguageConfig_ExtraSSRWeaponRuleContent_CN = {
    Text = "<Title:인과 초월>\n· 일반적으로 동일한 깨어남체는 하나의 SSR 명륜만 장비할 수 있습니다.\n· 추가 중첩이 12단계에 도달한 SSR 명륜을 깨어남체에 장비할 경우, 「인과 초월」 효과가 활성화되어 깨어남체는 동시에 두 개의 SSR 명륜을 장비할 수 있게 됩니다."
  },
  LanguageConfig_ExtraSSRWeaponRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_ExtraSSRWeaponUnlockTips_CN = {
    Text = "「인과 초월」이 활성화되었습니다!"
  },
  LanguageConfig_FailureConfirm_CN = {Text = "후퇴"},
  LanguageConfig_FailureHint_CN = {
    Text = "깨어남체들을 강화한 후, 다시 도전해 보세요!"
  },
  LanguageConfig_FastPromotionTypeName_CN = {
    Text = "영지 증폭기"
  },
  LanguageConfig_FavorSettleShowSourceTabActivity_CN = {
    Text = "이벤트 보너스"
  },
  LanguageConfig_FavorSettleShowSourceTabAssist_CN = {
    Text = "조력자 보너스"
  },
  LanguageConfig_FavorSettleShowSourceTabCard_CN = {
    Text = "카드 내기"
  },
  LanguageConfig_FavorSettleShowSourceTabCost_CN = {Text = "행동력"},
  LanguageConfig_FavorSettleShowSourceTabKeeper_CN = {
    Text = "은열쇠 에너지"
  },
  LanguageConfig_FavorSettleShowSourceTabManual_CN = {
    Text = "수동 전투"
  },
  LanguageConfig_FavorSettleShowSourceTabTotal_CN = {Text = "총액"},
  LanguageConfig_FavorSettleShowSourceTabUlti_CN = {Text = "광기"},
  LanguageConfig_FavorSettleShowSourceTabWeapon_CN = {
    Text = "명륜 보너스"
  },
  LanguageConfig_FavorabilityIncrease_CN = {
    Text = "{s1} 동조율<color=#1AE8F5>+{s2}</color>"
  },
  LanguageConfig_FavorabilityLimit_description_02_CN = {
    Text = "해당 깨어남체의 동조율이 최대치에 도달했습니다:"
  },
  LanguageConfig_FavorabilityLimit_description_CN = {
    Text = "동조율 기본 상한은 42000입니다"
  },
  LanguageConfig_FavorabilityUnlockCondition_1_CN = {
    Text = "{s1}의 동조율이 {s2}레벨에 도달할 시 개방"
  },
  LanguageConfig_FavorabilityUnlockCondition_2_CN = {
    Text = "<Gray1:{s1}의 동조율이 {s2}레벨에 도달할 시 개방>"
  },
  LanguageConfig_FightAgain_CN = {Text = "재전투"},
  LanguageConfig_FilterAwakerOptionsTipsDesc_CN = {
    Text = "특정 깨어남체를 필터링하여 해당 깨어남체를 포함한 편성을 확인할 수 있습니다."
  },
  LanguageConfig_FilterAwakerOptionsTipsTitle_CN = {
    Text = "클리어 깨어남체 선택"
  },
  LanguageConfig_FilterAwakerUnableSelect_CN = {
    Text = "선택할 수 없음"
  },
  LanguageConfig_FinalBoss_Bubble1_CN = {
    Text = "이런……월권을……"
  },
  LanguageConfig_FinalBoss_Bubble2_CN = {
    Text = "발버둥칠……필요 없다……"
  },
  LanguageConfig_FinalBoss_Bubble3_CN = {
    Text = "은색의 여섯 날개로, 너를 보호하리니."
  },
  LanguageConfig_FinalBoss_Bubble4_CN = {
    Text = "두 개의 날개가 펼쳐지고…… 은열쇠가 이곳에서 기울어진다."
  },
  LanguageConfig_FinalBoss_Bubble5_CN = {
    Text = "네 개의 날개가 자라나며…… 빛의 깃털이 이곳에서 빛나리니."
  },
  LanguageConfig_FinalBoss_Bubble6_CN = {
    Text = "여섯 개의 날개가 만개하였다…… 종언이 이곳에 강림하신다!"
  },
  LanguageConfig_FinalBoss_Name_CN = {
    Text = "타비: 만상문"
  },
  LanguageConfig_FinalBoss_Tips1_CN = {
    Text = "전지전능한 신명에게도 저항할 수 없는 것이 있습니다. 열쇠 지령을 사용하면 그분의 의도가 전환되므로, 전략을 조정하면 더욱 효과적으로 공략할 수 있습니다!"
  },
  LanguageConfig_FinalBoss_Tips2_CN = {
    Text = "명령 카드를 대량으로 사용하면 그분의 행동이 가속화되니, 미리 대비하세요!"
  },
  LanguageConfig_FinalBoss_Tips3_CN = {
    Text = "그분의 능력이 강화되어, 다른 의도로 전환할 때 추가 효과가 발생합니다. 주의하여 대응하세요!"
  },
  LanguageConfig_FirstTimeNormalRewardTagText_CN = {
    Text = "첫 클리어 2배 보너스"
  },
  LanguageConfig_FirstUnity_Monster_Tips_1_CN = {
    Text = "은빛의 여섯 날개로, 그대에게 보호를."
  },
  LanguageConfig_FirstUnity_Monster_Tips_2_CN = {
    Text = "두 개의 날개가 펼쳐지며, 광기가 모여든다."
  },
  LanguageConfig_FirstUnity_Monster_Tips_3_CN = {
    Text = "네 개의 날개가 자라나, 은빛 깃털이 빛난다!"
  },
  LanguageConfig_FirstUnity_Monster_Tips_4_CN = {
    Text = "여섯 개의 날개가 만개하고, 심판이 다가온다!"
  },
  LanguageConfig_FirstUnity_Monster_Tips_5_CN = {
    Text = "광기로 가득 차며, 심판이 다가온다!"
  },
  LanguageConfig_FiveFreePullsTips_CN = {
    Text = "무료 5연깨어남 {s1}회 가능합니다"
  },
  LanguageConfig_Float_Tip_BloodDevour_CN = {
    Text = "포식 효과 발동!"
  },
  LanguageConfig_Float_Tip_DefenceCrash_CN = {
    Text = "방어막 파괴!"
  },
  LanguageConfig_Float_Tip_DimensionJump_CN = {
    Text = "워프 효과 발동!"
  },
  LanguageConfig_Float_Tip_EnergyDown_CN = {
    Text = "에너지 감소…"
  },
  LanguageConfig_Float_Tip_Revive_CN = {Text = "재탄생"},
  LanguageConfig_Float_Tip_TentacleFull_CN = {
    Text = "촉수 수량이 이미 최대입니다!"
  },
  LanguageConfig_ForceAssistTeam_CN = {
    Text = "해당 조사 미션에서는 반드시 조력 깨어남체를 배치해야 합니다."
  },
  LanguageConfig_ForgedRelicTypeName_CN = {
    Text = "<OrangeRelic:황금 유물>"
  },
  LanguageConfig_Formation_Administration_CombatNum_String_CN = {
    Text = "총 전투력"
  },
  LanguageConfig_Formation_Administration_Current_Team_String_CN = {
    Text = "현재 파티"
  },
  LanguageConfig_Formation_Administration_Sure_Btn_CN = {Text = "선택"},
  LanguageConfig_Formation_Administration_Title_String_CN = {
    Text = "파티 관리"
  },
  LanguageConfig_Formation_CurrentTeam_AvgLevelNum_String_CN = {
    Text = "현재 파티의 평균 레벨"
  },
  LanguageConfig_Formation_Default_TeamName_String1_CN = {Text = "파티 1"},
  LanguageConfig_Formation_Default_TeamName_String2_CN = {Text = "파티 2"},
  LanguageConfig_Formation_Default_TeamName_String3_CN = {Text = "파티 3"},
  LanguageConfig_Formation_Default_TeamName_String4_CN = {Text = "파티 4"},
  LanguageConfig_Formation_Default_TeamName_String5_CN = {Text = "파티 5"},
  LanguageConfig_Formation_EnterCopy_Btn_CN = {Text = "조사"},
  LanguageConfig_Formation_Fast_Btn_CN = {
    Text = "빠른 편성"
  },
  LanguageConfig_Formation_Fast_Sure_Btn_CN = {Text = "보관"},
  LanguageConfig_Formation_RecommendLevel_CN = {
    Text = "추천 레벨"
  },
  LanguageConfig_Formation_RecommendTeam_LevelNum_String_CN = {
    Text = "해당 스테이지 추천 레벨"
  },
  LanguageConfig_Formation_RenameTeam_Back_Btn_CN = {Text = "취소"},
  LanguageConfig_Formation_RenameTeam_CurrentTeam_String_CN = {
    Text = "현재 이름:"
  },
  LanguageConfig_Formation_RenameTeam_Recommend_String_CN = {
    Text = "터치하여 파티 이름 편집하기"
  },
  LanguageConfig_Formation_RenameTeam_Sure_Btn_CN = {Text = "확인"},
  LanguageConfig_Formation_RenameTeam_Title_String_CN = {
    Text = "파티 이름 변경"
  },
  LanguageConfig_Formation_Role_ForceAssist_Recommend_CN = {
    Text = "<Blue:조력 깨어남체 선택>"
  },
  LanguageConfig_Formation_Role_Recommend_String_CN = {
    Text = "배치할 깨어남체를 선택해 주세요."
  },
  LanguageConfig_Formation_SelectRole_Details_Btn_CN = {
    Text = "상세 정보"
  },
  LanguageConfig_Formation_SelectRole_DifferentOccupation_String_CN = {
    Text = "영역 충돌"
  },
  LanguageConfig_Formation_SelectRole_NotBattle_String_CN = {
    Text = "출전할 수 없습니다"
  },
  LanguageConfig_Formation_SelectRole_Nothing_Tips_CN = {
    Text = "해당 영역의 깨어남체가 존재하지 않습니다"
  },
  LanguageConfig_Formation_SelectRole_Recommend_String1_CN = {
    Text = "깨어남체가 선택되지 않았습니다"
  },
  LanguageConfig_Formation_SelectRole_Recommend_String2_CN = {
    Text = "왼쪽에서 깨어남체를 선택하세요"
  },
  LanguageConfig_Formation_SelectRole_Sure_Btn1_CN = {Text = "제거"},
  LanguageConfig_Formation_SelectRole_Sure_Btn2_CN = {Text = "배치"},
  LanguageConfig_Formation_SelectRole_Sure_Btn3_CN = {Text = "교체"},
  LanguageConfig_Formation_SelectRole_Title_String_CN = {
    Text = "깨어남체 선택"
  },
  LanguageConfig_FreeTrialRuleDesc_CN = {
    Text = "· 깨어남체 체험 스테이지를 통해 깨어남체의 기본 사용법을 익힐 수 있습니다.\n· 상시 깨어남체 체험 스테이지에서는 첫 클리어 보상으로 은심 및 무결의 핵이 제공됩니다!\n· 한정 깨어남체 체험 스테이지에서는 첫 클리어 보상으로 근원의 침전이 제공됩니다."
  },
  LanguageConfig_FreeTrialRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_FreeTrialTitle_CN = {
    Text = "깨어남체 체험"
  },
  LanguageConfig_Frenzy_CN = {
    Text = "아이히히히"
  },
  LanguageConfig_FriendGameCount_CN = {
    Text = "친선 경기 {s1}<size=24>초대장</size>"
  },
  LanguageConfig_FriendGameInviteTipsDraft_CN = {
    Text = "당신을 순차 선택 모드에 초대하고 있습니다..."
  },
  LanguageConfig_FriendGameInviteTipsNormal_CN = {
    Text = "당신을 예상 팀 대결에 초대하고 있습니다…"
  },
  LanguageConfig_FriendGameNull_CN = {
    Text = "초대 취소됨"
  },
  LanguageConfig_FriendGameWaitAccept_CN = {
    Text = "친선 경기 초대 수락"
  },
  LanguageConfig_FriendGameWaitFormation_CN = {
    Text = "파티 편집"
  },
  LanguageConfig_FriendGame_CN = {
    Text = "친선 경기"
  },
  LanguageConfig_FriendInvitationCopy_CN = {Text = "복사"},
  LanguageConfig_FriendInvitationPaste_CN = {
    Text = "붙여넣기"
  },
  LanguageConfig_FriendInvitationRule_CN = {
    Text = "<Title:초대 이벤트>\n1. 수호자는 초대 코드를 공유하여 새로운 수호자를 미사그 대학에 초대하고 함께 모험을 떠날 수 있습니다.\n2. 초대받은 수호자가 미션를 완료하면, 미션 보상을 수령하여 「은열쇠의 광휘」를 획득할 수 있으며, 「은열쇠의 광휘」가 일정 수량에 도달하면 풍부한 보상을 받을 수 있습니다!\n3. 초대받은 수호자의 레벨이 5/10/15/20에 도달하면 각각 20/20/20/40 「은열쇠의 광휘」를 획득할 수 있습니다.\n4. 각 수호자는 최대 50명의 초대받은 수호자에게서만 미션 보상을 받을 수 있으며, 그 후로는 미션 보상이 제공되지 않습니다.\n5. 초대받은 수호자는 조사 레벨이 5에 도달해야 초대 인원에 포함됩니다.\n<Title:초대 결속>\n1. 수호자는 초대 코드를 입력하여 초대한 플레이어와 결속하고 즉시 은화*300 보상을 받을 수 있습니다!\n2. 각 수호자는 미사그 도착 후 처음 7일 이내에만 초대 코드를 입력할 수 있으며, 이후에는 「초대 결속」 기능이 닫힙니다."
  },
  LanguageConfig_FriendInvitationShareText_CN = {
    Text = "저와 《Morimens》 모험의 여정에 함께하세요! 다운로드 후 저의 초대 코드 {s1}를 사용하면 예비 수호자 님을 위해 준비한 전용 보상도 획득할 수 있습니다, 미사그 대학을 다니고 내 인생이 달라졌다!\n{s2}"
  },
  LanguageConfig_FriendInvitationTips_Accepted_CN = {
    Text = "<Blue:{s1}>의 초대를 수락했습니다!"
  },
  LanguageConfig_FrozenResentment_CN = {
    Text = "보지 마, 듣지 마, @1에 발을 들이지 마……"
  },
  LanguageConfig_FunctionNotComplete_CN = {
    Text = "기능 미완성"
  },
  LanguageConfig_GMUserIdText_CN = {Text = "UID: {s1}"},
  LanguageConfig_GMVersionText_CN = {Text = "Ver: {s1}"},
  LanguageConfig_GamePassportTip_CN = {
    Text = "고급 기행 해금\n미션 완료 후 추가 보상을 받을 수 있습니다."
  },
  LanguageConfig_GamePassportTitle_CN = {
    Text = "비밀수호 기행"
  },
  LanguageConfig_GenderChangeConfirmContent_CN = {
    Text = "수호자의 성별을 <Blue:「{s1}」>으로 변경하여 게임 스토리를 체험하세요."
  },
  LanguageConfig_GenderChangeConfirmFreeTips_CN = {
    Text = "이번 변경은 무료로 진행되며, 이후 변경은 <Blue:「{s1}」{s2}>개를 소모합니다."
  },
  LanguageConfig_GenderChangeConfirmTitle_CN = {
    Text = "성별 변경"
  },
  LanguageConfig_GenderChangeSuccessfulTips_CN = {
    Text = "성별이 수정되었습니다: {s1}"
  },
  LanguageConfig_GetConditionStr_CN = {
    Text = "{s1}회 이후부터 출현"
  },
  LanguageConfig_GetRelic_CN = {
    Text = "유물 획득"
  },
  LanguageConfig_GetSSRDecompose_CN = {
    Text = "SSR 분해로 획득"
  },
  LanguageConfig_GiftDiamondDeductTip_CN = {
    Text = "<size=30><color=#ACBFCA>「원액」 소모 시 증정된 「원액」을 우선 차감합니다.\n(추출: {s1}, 증정: {s2})</color></size>"
  },
  LanguageConfig_GiveAwayItem_CN = {
    Text = "선물하기"
  },
  LanguageConfig_GoGetWord_CN = {
    Text = "구매하러 가기"
  },
  LanguageConfig_GoTo_CN = {Text = "진행"},
  LanguageConfig_GoldShopRefreshDesc_CN = {
    Text = "{s1}시간 {s2}분"
  },
  LanguageConfig_GoldShopRefreshTimesOutTips_CN = {
    Text = "갱신 횟수가 최대치에 도달했습니다"
  },
  LanguageConfig_GoldShopRuleTitle_CN = {
    Text = "금권 교환 설명"
  },
  LanguageConfig_GoldenWeekSummonDesc1_CN = {
    Text = "<SummonOrange:선택한 깨어남체와 명륜>의 획득률 상승!"
  },
  LanguageConfig_GoldenWeekSummonDesc2_CN = {
    Text = "선택 후 이벤트 기간 동안 변경 불가"
  },
  LanguageConfig_GoodSourcePVP_CN = {
    Text = "페이즈 체스"
  },
  LanguageConfig_GoodSourceSocial_CN = {
    Text = "수호자 기록"
  },
  LanguageConfig_GuideNote_Breakthrough_CN = {
    Text = "승격 조건 충족(택1)"
  },
  LanguageConfig_GuideNote_CrazyOmen_CN = {
    Text = "광기의 전조 승급 조건"
  },
  LanguageConfig_GuideNote_ExplorationProgress_CN = {
    Text = "현재 수집 진행도"
  },
  LanguageConfig_GuideNote_MaterialMet_CN = {
    Text = "소재 충족 완료"
  },
  LanguageConfig_GuideNote_MaterialNeeded_CN = {
    Text = "아직 획득해야 할 소재"
  },
  LanguageConfig_GuideNote_MoreImprovement_CN = {
    Text = "추가 강화"
  },
  LanguageConfig_GuideNote_RecommendMystic_CN = {
    Text = "추천 비밀계약"
  },
  LanguageConfig_GuideNote_ResetTime_CN = {
    Text = "초기화 시간"
  },
  LanguageConfig_GuideNote_Rules_Description3_CN = {
    Text = "<Title:강화 밀의>\n·깨어남체를 선택하면 필요한 재료와 추천 장착 밀계를 확인할 수 있으며, 필요한 재료는 현재 보유 재료와 도달 가능한 한계를 기준으로 계산됩니다."
  },
  LanguageConfig_GuideNote_Rules_Title1_CN = {
    Text = "일일 훈련"
  },
  LanguageConfig_GuideNote_Rules_Title2_CN = {
    Text = "주간 시련"
  },
  LanguageConfig_GuideNote_Rules_Title3_CN = {
    Text = "강화 밀의"
  },
  LanguageConfig_GuideNote_Rules_Title4_CN = {
    Text = "금기 시련"
  },
  LanguageConfig_GuideNote_Rules_Title5_CN = {
    Text = "은휘의 길"
  },
  LanguageConfig_GuideNote_Rules_Title6_CN = {
    Text = "자원 탐사"
  },
  LanguageConfig_GuideNote_SkillImprovement_CN = {
    Text = "스킬 승급 조건"
  },
  LanguageConfig_GuideNote_Title1_CN = {
    Text = "비경 교실타래"
  },
  LanguageConfig_GuideNote_Title2_CN = {
    Text = "일일 훈련"
  },
  LanguageConfig_GuideNote_Title3_CN = {
    Text = "주간 시련"
  },
  LanguageConfig_GuideNote_Title4_CN = {
    Text = "비의 강화"
  },
  LanguageConfig_GuideNote_Title5_CN = {
    Text = "금기 시련"
  },
  LanguageConfig_GuideNote_Title6_CN = {
    Text = "은휘의 길"
  },
  LanguageConfig_GuideNote_Title7_CN = {
    Text = "자원 탐사"
  },
  LanguageConfig_HZWMainDia1_CN = {
    Text = "우리를 얕보지 말라고!"
  },
  LanguageConfig_HZWMainDia2_CN = {
    Text = "방해하지 마!"
  },
  LanguageConfig_HalfBleeding_CN = {
    Text = "출혈이 절반으로 줄어듭니다"
  },
  LanguageConfig_HolyRelicTypeName_CN = {
    Text = "<OrangeRelic:축복받은 유물>"
  },
  LanguageConfig_Hour_CN = {Text = "시간"},
  LanguageConfig_HowToPlayTxt_CN = {
    Text = "플레이 방법 설명"
  },
  LanguageConfig_ImmuneSpDown_CN = {
    Text = "행동력 감소 면역"
  },
  LanguageConfig_InGameDownloadChecking_CN = {
    Text = "리소스를 다시 다운로드하는 중입니다. 잠시만 기다려 주세요... {s1}%"
  },
  LanguageConfig_InGameDownloadReady_CN = {
    Text = "리소스 다운로드 준비 중"
  },
  LanguageConfig_InGameDownloadRedownloading_CN = {
    Text = "리소스를 다시 다운로드하는 중입니다. 잠시만 기다려 주세요... {s1}%"
  },
  LanguageConfig_InGameDownloadUnzipStart_CN = {
    Text = "리소스 압축 해제 준비 중"
  },
  LanguageConfig_InGameDownloadUnziping_CN = {
    Text = "리소스 압축 해제 중입니다. 잠시만 기다려 주세요… {s1}%"
  },
  LanguageConfig_InGameDownloadingProg_CN = {
    Text = "다운로드 중 {s1}"
  },
  LanguageConfig_InGameDownloadingTips_CN = {
    Text = "절전 모드 혹은 저전력 모드를 끄면 백그라운드 다운로드를 지원하며, 알림 권한을 활성화하면 다운로드 상태 알림을 받을 수 있습니다."
  },
  LanguageConfig_InGameDownloadingTitle_CN = {
    Text = "리소스 다운로드"
  },
  LanguageConfig_InheritConsumeDrawItemConvertTips_CN = {
    Text = "곧 「무구의 은핵」으로 전환됩니다"
  },
  LanguageConfig_InterludeStageRewardsTitle_CN = {
    Text = "3성 보상"
  },
  LanguageConfig_InvestAchievement_CN = {
    Text = "업적/조사 업적"
  },
  LanguageConfig_InvestigationBadgeShopRules_CN = {
    Text = "1. 수호자는 일정 수량의 「조사 배지」를 소모하여 상품을 교환할 수 있습니다.\n2. 수호자 조사 레벨이 상승하면, 조사 교환 상점에 새로운 상품이 해금됩니다.\n3. 조사 교환 상점 상품은 일정 시간마다 자동으로 재고가 갱신됩니다.\n4. 수호자는 메인 스토리 조사 이벤트에서 3성 달성 또는 「초월적 존재」를 통해 「조사 배지」를 획득할 수 있습니다."
  },
  LanguageConfig_Investigation_Failed_CN = {
    Text = "조사 종료"
  },
  LanguageConfig_Investigation_Successful_CN = {
    Text = "조사 완료"
  },
  LanguageConfig_InviteAwaker_CN = {
    Text = "무료 깨어남"
  },
  LanguageConfig_InviteWeapon_CN = {
    Text = "명륜 선택"
  },
  LanguageConfig_IsNewDotText_CN = {Text = "추천"},
  LanguageConfig_ItemByDecompose_CN = {
    Text = "분해 시 획득 소재"
  },
  LanguageConfig_ItemEquipping_CN = {
    Text = "현재 장비"
  },
  LanguageConfig_ItemForCompose_CN = {
    Text = "합성 레시피"
  },
  LanguageConfig_ItemGain_AwakerGainLikeReward_CHN_CN = {
    Text = "동조율 보상"
  },
  LanguageConfig_ItemGain_String_LevelUpGet_CHN_CN = {
    Text = "초과 경험치 반환"
  },
  LanguageConfig_ItemGain_String_MainCont_CHN_CN = {
    Text = "화면을 터치하여 계속"
  },
  LanguageConfig_ItemGain_String_MainTitle_CHN_CN = {
    Text = "아이템 획득"
  },
  LanguageConfig_ItemGain_String_MainTitle_CN = {
    Text = "아이템 획득"
  },
  LanguageConfig_ItemGain_String_ShareTitle_CN = {
    Text = "공유 보상"
  },
  LanguageConfig_ItemGain_String_SpecialItemUse_CN = {
    Text = "아이템 획득"
  },
  LanguageConfig_ItemGain_String_WorkCont_CHN_CN = {
    Text = "화면을 터치하여 계속"
  },
  LanguageConfig_ItemGain_String_WorkTitle_CHN_CN = {
    Text = "아이템 획득"
  },
  LanguageConfig_ItemNeed_CN = {Text = "필요"},
  LanguageConfig_ItemType_Awaker_CN = {
    Text = "깨어남체"
  },
  LanguageConfig_ItemType_HeadAndEmoji_CN = {
    Text = "아이콘 및 감정 표현"
  },
  LanguageConfig_ItemType_Material_CN = {Text = "재료"},
  LanguageConfig_ItemType_Specail_CN = {Text = "특수"},
  LanguageConfig_ItemType_Trinket_CN = {
    Text = "비밀 계약"
  },
  LanguageConfig_ItemType_Weapon_CN = {Text = "명륜"},
  LanguageConfig_ItemUseTimes_CN = {
    Text = "사용 횟수"
  },
  LanguageConfig_ItemUsingDesc_CN = {Text = "사용 중"},
  LanguageConfig_KMMainDia1_CN = {
    Text = "빨리…… 도망가……"
  },
  LanguageConfig_KMMainDia2_CN = {
    Text = "으... 아파..."
  },
  LanguageConfig_KPLevel_CN = {Text = "수호자"},
  LanguageConfig_KarenActivityRewardBottomText_CN = {
    Text = "현재 청소 도구 {s1}"
  },
  LanguageConfig_KarenActivityRewardTitle_CN = {
    Text = "먼지 청소 수당"
  },
  LanguageConfig_KeeperSkillCannotChange_CN = {
    Text = "현재 스테이지에서는 은열쇠 스킬을 교체할 수 없습니다."
  },
  LanguageConfig_KeeperSkillEnergyConsume_CN = {
    Text = "은열쇠 에너지 소모: {s1}"
  },
  LanguageConfig_KeeperSkillEnergy_CN = {
    Text = "은열쇠 에너지 {s1}"
  },
  LanguageConfig_KeeperSkillEquipPrompt_CN = {
    Text = "선택된 은열쇠: {s1}"
  },
  LanguageConfig_KeeperSkillTitle_CN = {Text = "은열쇠"},
  LanguageConfig_Keeper_Cost_CN = {
    Text = "에너지 소모:"
  },
  LanguageConfig_KilledMonsterCount_CN = {
    Text = "<color=#5EF2FF> {s1} </color> 체 격퇴"
  },
  LanguageConfig_LLMainDia1_CN = {
    Text = "나——는——누구?"
  },
  LanguageConfig_LLMainDia2_CN = {
    Text = "엄...마..."
  },
  LanguageConfig_LLMainDia3_CN = {
    Text = "난... 지켜야..."
  },
  LanguageConfig_LLMainDia4_CN = {
    Text = "하나……도……아프지 않아"
  },
  LanguageConfig_LTMainDia1_CN = {
    Text = "좋아! 지난번엔 승부가 안 났잖아!"
  },
  LanguageConfig_LTMainDia2_CN = {
    Text = "이거 한번 받아봐!"
  },
  LanguageConfig_LTMainDia3_CN = {
    Text = "하하! 지난번보다 훨씬 재밌잖아! 이번엔 진짜로 간다!"
  },
  LanguageConfig_LTMainDia4_CN = {
    Text = "좋아, 이제 준비운동은 끝이야!"
  },
  LanguageConfig_LackOfGoldCoin_CN = {
    Text = "장미 금권이 부족합니다"
  },
  LanguageConfig_LackOfItemForCompose_CN = {
    Text = "재료가 부족하여, 합성할 수 없습니다"
  },
  LanguageConfig_LackOfItemForDecompose_CN = {
    Text = "분해할 수 있는 재료가 없습니다"
  },
  LanguageConfig_LackOfTrinketForRecast_CN = {
    Text = "장착되지 않은 SSR 비밀 계약을 보유하지 않았습니다"
  },
  LanguageConfig_LargeSubplotResonanceRules_CN = {
    Text = "1、「특파 기록」의 일부 조사 사건에는 전용 공명이 있으며, 공명 업그레이드 재료를 사용하여 공명 효과를 활성화할 수 있습니다. 공명은 조사 시 강력한 지원을 제공합니다.\n2、깨어남체 한정 이벤트 기간 동안 지정 미션를 완료하면 공명 업그레이드 재료를 획득할 수 있습니다. 이벤트 종료 후에는 「장미 금권」× 5000을 소모하여 공명 업그레이드 재료 1개를 추가로 교환할 수 있습니다.\n3、맵 내에 공명 노드가 등장하며, 공명 노드로 이동하면 이번 탐색에서 공명 효과를 획득합니다."
  },
  LanguageConfig_LargeSubplotTipsText_CN = {
    Text = "<Title:특파 기록>\n1. 아래 조건을 모두 충족해야 특파 기록을 진행할 수 있습니다.\n· 해당 조사 미션 완료\n· '현실타래의 기점' ×7 소모하여 해제\n2. 특파 기록이 한정 이벤트 중일 경우, '현실타래의 기점'소모하지 않고 무료로 해제 가능합니다. 이벤트 종료 후에도 조사 진행도는 유지됩니다.\n3. 특파 기록 조사 미션를 완료 시 무구의 은핵, 수호자 경험치, 조사 배지 등의 보상을 획득을 수 있습니다."
  },
  LanguageConfig_LargeSubplotTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_LargeSubplotTitle_CN = {
    Text = "특파 기록"
  },
  LanguageConfig_LeaveSpStore_Tips_CN = {
    Text = "융식으로부터 목이 쉰 듯한 속삭임이 흘러나온다: \n떠나라. 그리고 이곳에서 다시는 그것을 마주하지 못하리라."
  },
  LanguageConfig_LeftCountText_CN = {
    Text = "남은 횟수"
  },
  LanguageConfig_Less_Sweep_Item_CN = {
    Text = "스킵 쿠폰이 부족합니다"
  },
  LanguageConfig_LevelDetailBattle_Boss_Tips_CN = {Text = "보스"},
  LanguageConfig_LevelDetailBattle_Elite_Tips_CN = {Text = "엘리트"},
  LanguageConfig_LevelDetailEnchantGroup_CN = {Text = "각인"},
  LanguageConfig_LevelDetailRelicEnchantGroupNone_CN = {
    Text = "유물 혹은 각인 없음"
  },
  LanguageConfig_LevelDetailRelicGroup_CN = {Text = "유물"},
  LanguageConfig_LevelFailureGuide_CN = {
    Text = "·깨어남체 레벨 상승\n·깨어남체 스킬 강화\n·명륜 중첩\n·비밀 계약 강화\n·계령 활성화"
  },
  LanguageConfig_LevelLimitIncrease_CN = {
    Text = "최대 레벨 증가"
  },
  LanguageConfig_LevelSuppression_Description_Detail_CN = {
    Text = "· 추천 레벨은 해당 조사의 난이도의 참고 기준을 제공합니다. 만약 파티의 평균 레벨이나 수호자의 조사 등급이 추천 레벨보다 낮다면, 조사를 진행할 때 큰 도전을 겪을 수 있습니다."
  },
  LanguageConfig_LevelSuppression_Description_Title_CN = {
    Text = "추천 등급"
  },
  LanguageConfig_LevelSuppression_tips_CN = {
    Text = "아군 파티 속성 {s1}"
  },
  LanguageConfig_LevelUnlockDesc_CN = {
    Text = "{s1} 클리어 후 해금"
  },
  LanguageConfig_LevelUpGamePassport_CN = {
    Text = "기행 진급"
  },
  LanguageConfig_LevelUpTipsAccountDamagerText_CN = {
    Text = "스테이지 유물 및 각인 효과가 강화되었습니다."
  },
  LanguageConfig_LevelUpTipsHpMultiplierText_CN = {
    Text = "깨어남체 체력 1당 상승하는 최대 HP가 <TipsHighlightText_1:{s1}> (으)로 상승했습니다."
  },
  LanguageConfig_Level_Up_Energy_Str_CN = {
    Text = "린피테이프"
  },
  LanguageConfig_Level_Up_Level_Str_CN = {Text = "레벨"},
  LanguageConfig_Level_Up_Max_Energy_Str_CN = {
    Text = "최대 린피테이프"
  },
  LanguageConfig_Level_Up_Tips_CN = {
    Text = "수호자 조사 등급 상승"
  },
  LanguageConfig_Level_Up_Title_CN = {Text = "레벨 업"},
  LanguageConfig_LikeBounusTips_CN = {
    Text = "{s1} 동조율 보너스"
  },
  LanguageConfig_LikeSourceCollectionHallComment_CN = {
    Text = "전시관 소장 댓글"
  },
  LanguageConfig_LikeSourcePvpCollectionComment_CN = {
    Text = "페이즈 대결 카드 코멘트"
  },
  LanguageConfig_LilyResonance1_1_CN = {
    Text = ", 보통 각인 3개 중 1개를 선택"
  },
  LanguageConfig_LilyResonance1_2_CN = {
    Text = ", 고급 각인 3개 중 1개를 선택"
  },
  LanguageConfig_LilyResonance4_1_CN = {
    Text = ", 「영감」 1장을 획득"
  },
  LanguageConfig_LilyResonance4_2_CN = {
    Text = ", 「영감」 2장을 획득"
  },
  LanguageConfig_LimitedTimeFreeUnlock_CN = {
    Text = "무료 개방 이벤트"
  },
  LanguageConfig_LinkageActivityTitle_CN = {
    Text = "다차원 연결"
  },
  LanguageConfig_Localized_CN = {
    Text = "현지화 완료"
  },
  LanguageConfig_LoginInterface_Announcement_CN = {Text = "공지"},
  LanguageConfig_LoginInterface_Btn_Enter_CN = {
    Text = "미사그 대학 진입"
  },
  LanguageConfig_LoginPV1_Name_CN = {Text = "Morimens"},
  LanguageConfig_LoginPV2_Name_CN = {
    Text = "은열쇠가 앞길을 인도하기를"
  },
  LanguageConfig_LoginPV3_Name_CN = {
    Text = "망각으로부터 <▼>"
  },
  LanguageConfig_LoginPV4_Name_CN = {
    Text = "별들이 교차하는 순간"
  },
  LanguageConfig_LoginPlatFormActivityTxt_CN = {
    Text = "프로필을 완성하고, 다른 기기로 플레이하고 원액을 추출하면 전용 한정 아바타와 환의 보상을 획득할 수 있습니다!"
  },
  LanguageConfig_LoginPvModifyTipDesc_CN = {
    Text = "선택된 애니메이션은 이후 로그인할 때마다 재생됩니다. 단, 조사 진행도가 새로운 단계에 도달하면 새로운 애니메이션이 우선 한 번 재생됩니다. 게임 데이터를 삭제하거나 게임을 재설치하면 선택된 애니메이션이 초기화됩니다."
  },
  LanguageConfig_LoginPvModifyTipTitle_CN = {Text = "설명"},
  LanguageConfig_Login_ResetLoginBackground_CN = {
    Text = "로그인 배경 초기화"
  },
  LanguageConfig_Login_SetLoginBackground_CN = {
    Text = "로그인 배경으로 설정"
  },
  LanguageConfig_LotteryCoreRewardLabel_CN = {Text = "특수"},
  LanguageConfig_LotteryCoreRewardResetTimes_CN = {
    Text = "특수 아이템 남은 초기화 횟수: {s1}"
  },
  LanguageConfig_LotteryCoreReward_CN = {
    Text = "특수 아이템"
  },
  LanguageConfig_LotteryDrawBtnText_CN = {
    Text = "시구 교환"
  },
  LanguageConfig_LotteryNormalReward_CN = {
    Text = "일반 아이템"
  },
  LanguageConfig_LotteryPhoneticDialogue10_CN = {
    Text = "더 경건하게, 더 많은 희생을… 신국은 당신의 기도를 보고 있어요. 언젠가는 반드시 응답할 것입니다."
  },
  LanguageConfig_LotteryPhoneticDialogue11_CN = {
    Text = "아무리 평범한 사람이라도 시구에 감동받을 수 있어요… 이 꽃은 당신을 위해 피었답니다!"
  },
  LanguageConfig_LotteryPhoneticDialogue12_CN = {
    Text = "시에는 감정이 있고, 꽃에는 꽃말이 있죠. 당신께 바칩니다."
  },
  LanguageConfig_LotteryPhoneticDialogue13_CN = {
    Text = "잘 지켜봐라… 난 영원히 싸울 테니."
  },
  LanguageConfig_LotteryPhoneticDialogue14_CN = {
    Text = "내 승리를 보러 온 거냐?"
  },
  LanguageConfig_LotteryPhoneticDialogue15_CN = {
    Text = "힘내고, 몸부림쳐라, 착한 아이야. 선생님이 머리 한번 쓰다듬어줄까?"
  },
  LanguageConfig_LotteryPhoneticDialogue16_CN = {
    Text = "이런 쓰레기들로, 무엇을 구할 수 있겠느냐?"
  },
  LanguageConfig_LotteryPhoneticDialogue17_CN = {
    Text = "와, 손님 운이 좋네요. 한 번 더 시도해 보시겠어요?"
  },
  LanguageConfig_LotteryPhoneticDialogue18_CN = {
    Text = "좀 더 둘러보시겠어요? 우리 가게에는 더 귀중한 물건들도 있답니다!"
  },
  LanguageConfig_LotteryPhoneticDialogue19_CN = {
    Text = "이 보고서, 정말 맛있네요. 잘 먹었습니다!"
  },
  LanguageConfig_LotteryPhoneticDialogue1_CN = {
    Text = "친절하시네요, 감사해요."
  },
  LanguageConfig_LotteryPhoneticDialogue20_CN = {
    Text = "음, 받겠습니다. 다른 건 없나요?"
  },
  LanguageConfig_LotteryPhoneticDialogue21_CN = {
    Text = "선물 고마워요. 이것도 받아주세요."
  },
  LanguageConfig_LotteryPhoneticDialogue22_CN = {
    Text = "귀한 재료를 좀 구했어요. 도움이 되길 바라요!"
  },
  LanguageConfig_LotteryPhoneticDialogue23_CN = {
    Text = "간단한 전채입니다. 맛있게 드세요."
  },
  LanguageConfig_LotteryPhoneticDialogue24_CN = {
    Text = "성주님께서 직접 조리하신 메인 디시입니다. 입맛에 맞으신가요, 손님?"
  },
  LanguageConfig_LotteryPhoneticDialogue25_CN = {
    Text = "기법과 규칙에 너무 신경 쓰지 마세요."
  },
  LanguageConfig_LotteryPhoneticDialogue26_CN = {
    Text = "이성은 당신에게 그리는 법만 가르치고, 광기만이 당신으로 하여금 창조하게 한다."
  },
  LanguageConfig_LotteryPhoneticDialogue27_CN = {
    Text = "세상 사람들은 광기를 두려워하는데, 그들은 진실타래을 본 적이 없기 때문이다."
  },
  LanguageConfig_LotteryPhoneticDialogue28_CN = {
    Text = "보셨나요? 진짜 세상!"
  },
  LanguageConfig_LotteryPhoneticDialogue29_CN = {
    Text = "나는 진짜 색깔을 보았고, 얼마나 멋진가."
  },
  LanguageConfig_LotteryPhoneticDialogue2_CN = {
    Text = "와, 운이 참 좋으시네요! 받으세요!"
  },
  LanguageConfig_LotteryPhoneticDialogue30_CN = {
    Text = "광기와 부조리가 진정한 현실타래의 아름다움, 예술의 아름다움이다!"
  },
  LanguageConfig_LotteryPhoneticDialogue31_CN = {
    Text = "검은색, 검은색이 여전히 여기 있어, 너의 죄악을 계속 씻어내라."
  },
  LanguageConfig_LotteryPhoneticDialogue32_CN = {
    Text = "얼마나 아름다운지, 나는 너의 순수한 혼을 보았다……"
  },
  LanguageConfig_LotteryPhoneticDialogue33_CN = {
    Text = "야, 비밀 지키는 사람! 그때의 일 다시 해도 당신은 나를 구해줄 거지? \n……그럼 나는 안심하고 편하게 잘 수 있어. 고맙고, 헉, 내가 말하는 건, 고마워."
  },
  LanguageConfig_LotteryPhoneticDialogue34_CN = {
    Text = "최근 옛날의 일을 꿈꾸고 있다. 정말 지긋지긋하다. 이 물건은 차라리 좀 쓸모가 있기를."
  },
  LanguageConfig_LotteryPhoneticDialogue35_CN = {
    Text = "신 어머니는 신국을 위해 고귀한 희생을 하셨습니다. 우리는 그녀의 안식을 위해 모든 것을 바치고자 합니다."
  },
  LanguageConfig_LotteryPhoneticDialogue36_CN = {
    Text = "신모에 대한 귀하의 헌신에 감사드리며, 이로 인해 그녀가 좋은 하룻밤을 보낼 수 있기를 바랍니다."
  },
  LanguageConfig_LotteryPhoneticDialogue37_CN = {
    Text = "이 꿈은 결코 끝나지 않을 것이며, 너는……\n다행히도 나는 너를 그곳에 가입할 수 있도록 허락할 것이다."
  },
  LanguageConfig_LotteryPhoneticDialogue38_CN = {
    Text = "너는 내가 꿈에서 본 게 어떤 모습인지 아는가? 그런 더럽고 부정한 장면……"
  },
  LanguageConfig_LotteryPhoneticDialogue39_CN = {
    Text = "신외의 물건이 얼마나 많습니까, 당신이 어떤 소망이 있다면, 주저하지 말고 저에게 직접 말씀해 주세요……"
  },
  LanguageConfig_LotteryPhoneticDialogue3_CN = {
    Text = "정말 보물을 찾았네, 젊은 친구! 이 가게 물건들은 다 고대 유물이지!"
  },
  LanguageConfig_LotteryPhoneticDialogue40_CN = {
    Text = "당신이 극동의 황폐한 폐허에 있다면, 절대 함부로 제사를 지내지 마세요——요괴와 들개? 하하……그것들은 별로 중요하지 않아요."
  },
  LanguageConfig_LotteryPhoneticDialogue41_CN = {
    Text = "우리 알탄이, 장하다!"
  },
  LanguageConfig_LotteryPhoneticDialogue42_CN = {
    Text = "알탄아, 대단해!"
  },
  LanguageConfig_LotteryPhoneticDialogue43_CN = {
    Text = "반짝반짝! 줄게, 알탄이!"
  },
  LanguageConfig_LotteryPhoneticDialogue44_CN = {
    Text = "친구, 좋아! 모스와 알탄이, 교환!"
  },
  LanguageConfig_LotteryPhoneticDialogue45_CN = {
    Text = "해녀, 정말 아름다워요! 모스, 수집! 알탄이, 보상!"
  },
  LanguageConfig_LotteryPhoneticDialogue46_CN = {
    Text = "모스, 좋아! 고마워, 알탄이!"
  },
  LanguageConfig_LotteryPhoneticDialogue47_CN = {
    Text = "맞아……운명에 버림받은 자여, 그 감옥을 부숴라!"
  },
  LanguageConfig_LotteryPhoneticDialogue48_CN = {
    Text = "흥, 운명의 작은 장난이로군."
  },
  LanguageConfig_LotteryPhoneticDialogue49_CN = {
    Text = "번식, 성장, 이 모든 것은 사랑과 밀접하게 연관되어 있어요."
  },
  LanguageConfig_LotteryPhoneticDialogue4_CN = {
    Text = "이렇게 강력한 마법에 선택받다니, 혹시 네가 그 전설의 선택받은 자인가?"
  },
  LanguageConfig_LotteryPhoneticDialogue50_CN = {
    Text = "혼자 그 세계에 도착했을 때, 어떤 사람이 저에게 많은, 정말 많은 것을 가르쳐 주었고, 오늘날까지도 계속 열심히 배우고 있어요."
  },
  LanguageConfig_LotteryPhoneticDialogue51_CN = {
    Text = "누군가에게 아낌없이 사랑받은 적이 있나요, 아니면 모든 것을 버리고 누군가를 사랑한 적이 있나요?\n저는 그것이 정말 아름다운 일이라고 생각해요."
  },
  LanguageConfig_LotteryPhoneticDialogue52_CN = {
    Text = "인간의 연애, 아니, 생물의 연애란 정말 신기해요.\n자신보다도 중요한 존재, 무엇보다도 중요한 존재."
  },
  LanguageConfig_LotteryPhoneticDialogue53_CN = {
    Text = "저와 함께 기다려 주세요, 그 빛나는, 찬란한, 아름다운 세계의 시작을."
  },
  LanguageConfig_LotteryPhoneticDialogue54_CN = {
    Text = "선물 고마워요, 새로운 발견을 가져다줄 것 같아요."
  },
  LanguageConfig_LotteryPhoneticDialogue55_CN = {
    Text = "우와…… 이거 진짜야? 완전 대박 났잖아?!"
  },
  LanguageConfig_LotteryPhoneticDialogue56_CN = {
    Text = "이런 꼬마아이의 말을 너는 믿을 수 있어?"
  },
  LanguageConfig_LotteryPhoneticDialogue57_CN = {
    Text = "진짜 좋은데! 아니, 물론 내가 찾는 건 여기 없지만…… 모두가 얻은 성과에 기뻐하는 거라구."
  },
  LanguageConfig_LotteryPhoneticDialogue58_CN = {
    Text = "이…… 이 요정은 모두가 각자마다의 소원을 이룰 수 있다고, 그렇게 믿고 있어."
  },
  LanguageConfig_LotteryPhoneticDialogue59_CN = {
    Text = "히히, 받아라! 도망가지 마~ 진짜 요정의 축복을 한 번 제대로 누려 보라고!"
  },
  LanguageConfig_LotteryPhoneticDialogue5_CN = {
    Text = "음? 아, 그냥 가져세가요. 친절함에 감사드린다고 하죠…"
  },
  LanguageConfig_LotteryPhoneticDialogue60_CN = {
    Text = "조금만 더, 아주 쪼오금만 더면 돼! 한 번만 더 해봐~"
  },
  LanguageConfig_LotteryPhoneticDialogue61_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_LotteryPhoneticDialogue62_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_LotteryPhoneticDialogue63_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_LotteryPhoneticDialogue64_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_LotteryPhoneticDialogue65_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_LotteryPhoneticDialogue66_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_LotteryPhoneticDialogue6_CN = {
    Text = "오, 운이 좋으시네요. 옆집 존과 달리, 제 물건들은 실타래용성이 최고랍니다. 도움이 되길 바라요!"
  },
  LanguageConfig_LotteryPhoneticDialogue7_CN = {
    Text = "가장 깊은 욕망을 저에게 보여주세요… 그러면 당신이 갈망하는 걸 드릴게요."
  },
  LanguageConfig_LotteryPhoneticDialogue8_CN = {
    Text = "당신의 갈증을 느낄 수 있어요… 그럼 저를 원하고, 갈망해보세요."
  },
  LanguageConfig_LotteryPhoneticDialogue9_CN = {
    Text = "조용히 귀를 기울여보세요. 이 맑은 소리가 바로 신국의 응답이에요."
  },
  LanguageConfig_LotteryProgressText_CN = {
    Text = "남은 횟수: {s1}/{s2}"
  },
  LanguageConfig_LotteryResetBtnText_CN = {
    Text = "초기화 {s1}/{s2}"
  },
  LanguageConfig_LotteryRuleContent_CN = {
    Text = "1. 「코레트의 꽃집」에는 총 세 개의 화단이 있으며, 개방 시간은 다음과 같습니다：\n· 「붓꽃 화단」： 7월 15일 9시 개방.\n· 「초롱꽃 화단」： 7월 17일 9시 개방.\n·「장미 화단」： 7월 19일 9시 개방.\n2. 교환 시마다 1000개의 「애상의 시문」/「유감의 시문」/「환희의 시문」을 소모하며, 화단에서 다섯 가지 아이템 보상을 랜덤으로 획득합니다.\n3. 각 화단의 아이템 보상은 「특수 아이템」과 「일반 아이템」으로 구분되며, 초기화 시 특수 아이템 보상의 남은 수량을 최대치로 되돌릴 수 있습니다. 구체적인 규칙은 다음과 같습니다：\n(1) 첫 두 번의 초기화：「특수 아이템」이 남아있지 않을 경우, 수호자는 초기화를 선택할 수 있습니다. 초기화 후 「특수 아이템」과 「일반 아이템」의 남은 수량이 모두 최대치로 초기화됩니다. 또는 교환을 계속할 수 있으며, 「일반 아이템」이 남아있지 않으면 교환을 계속하기 위해 반드시 초기화를 진행해야 합니다.\n(2) 세 번째 초기화 이후：「일반 아이템」이 남아있지 않을 때만 리셋이 가능합니다. 이 경우 「일반 아이템」의 남은 수량만 최대치로 초기화되며, 「특수 아이템」은 더 이상 초기화되지 않습니다.\n4. 8월 5일 9:00(GMT+8) 이후, 남아 있는 교환되지 않은 「시문」은 200개당 「장미 금권*5000」으로 환산되어 회수되니, 반드시 메일을 확인해 주세요."
  },
  LanguageConfig_LotteryRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_LuckyBagRedDotText_CN = {Text = "추천"},
  LanguageConfig_LuckyTime_1_CN = {
    Text = "행운의 시간: 1"
  },
  LanguageConfig_LuckyTime_2_CN = {
    Text = "행운의 시간: 2"
  },
  LanguageConfig_LuckyTime_3_CN = {
    Text = "행운의 시간: 3"
  },
  LanguageConfig_LuckyTime_4_CN = {
    Text = "행운의 시간 - 엄청난 행운: 4!"
  },
  LanguageConfig_LuckyTime_5_CN = {
    Text = "행운의 시간 - 엄청난 행운: 5!"
  },
  LanguageConfig_MLYMResonance1_1_CN = {
    Text = "[소중한 것의 희생] 「따뜻한 가정」, 「진심어린 친구」, 「안정적인 생활」 중 1장의 카드를 선택하여 잃습니다."
  },
  LanguageConfig_MLYMResonance1_2_CN = {
    Text = "[소중한 것의 희생] 「따뜻한 가정」, 「진심어린 친구」, 「안정적인 생활」 중 1장의 카드를 선택하여 잃고, 「신국의 환영」1장을 추가합니다."
  },
  LanguageConfig_Mail_BackpackFull_Message_CN = {
    Text = "존경하는 수호자님, 물자 보관함이 가득 차 {s1}에서 얻은 보상을 수령하지 못했습니다. 보상이 우편으로 전달되었습니다, 보관함을 정리해 주세요."
  },
  LanguageConfig_Mail_BackpackFull_Sender_CN = {
    Text = "Z1 프로젝트 팀"
  },
  LanguageConfig_Mail_BackpackFull_Title_CN = {
    Text = "시스템 보상 재발급"
  },
  LanguageConfig_Mail_CheckPrompt_CN = {
    Text = "우편을 선택하여 확인"
  },
  LanguageConfig_Mail_CollectAll_CN = {
    Text = "일괄 수령"
  },
  LanguageConfig_Mail_CountDown_Day_CN = {
    Text = "{s1}일 후 만료"
  },
  LanguageConfig_Mail_CountDown_Hour_CN = {
    Text = "{s1}시간 후 만료"
  },
  LanguageConfig_Mail_CountDown_Soon_CN = {
    Text = "만료 예정"
  },
  LanguageConfig_Mail_DeleteRead_CN = {
    Text = "읽은 우편 삭제"
  },
  LanguageConfig_Mail_Description_Detail_CN = {
    Text = "<Title:[우편함 용량]>\n· 우편은 최대 100통까지 보관할 수 있습니다.\n· 우편 수량이 최대치에 도달하면, 시스템에서 가장 오래된 우편대로 자동으로 삭제 처리합니다.\n· 각 우편은 유효 기간이 있으며, 만료 후에는 자동으로 삭제됩니다.\n\n<Title:[우편 보관함]>\n· 생일 축하 메시지 등의 특별한 우편은 보상을 수령한 후 우편 보관함에 저장되며, 영구적으로 보관됩니다."
  },
  LanguageConfig_Mail_Description_Title_CN = {
    Text = "우편함 설명"
  },
  LanguageConfig_Mail_Number_Treasures_CN = {
    Text = "보유 수량 {s1}/{s2}"
  },
  LanguageConfig_Mail_Recive_CN = {Text = "수령"},
  LanguageConfig_Mail_SendTime_CN = {
    Text = "시간: {s1}"
  },
  LanguageConfig_Mail_Sender_CN = {
    Text = "발신자: {s1}"
  },
  LanguageConfig_Mail_Title_CN = {Text = "우편함"},
  LanguageConfig_Mail_Treasures_CN = {
    Text = "우편 보관함"
  },
  LanguageConfig_MainCopyOutPanelTrinketMaxTips_CN = {
    Text = "비밀 계약 용량이 가득 찼습니다. 새로 획득한 비밀 계약은 우편함으로 보내졌습니다."
  },
  LanguageConfig_MainCopyTitle_CN = {
    Text = "조사 작전"
  },
  LanguageConfig_MainInterface_Awaker_CN = {
    Text = "깨어남체"
  },
  LanguageConfig_MainInterface_Bag_CN = {Text = "물자"},
  LanguageConfig_MainInterface_Battlepass_CN = {Text = "통행증"},
  LanguageConfig_MainInterface_Btn_Arena_CN = {
    Text = "막간 훈련"
  },
  LanguageConfig_MainInterface_Btn_BOSS_CN = {
    Text = "초월적 존재"
  },
  LanguageConfig_MainInterface_Btn_DailyChallenge_CN = {
    Text = "환몽 심잠"
  },
  LanguageConfig_MainInterface_Btn_DailyCopy_CN = {
    Text = "융식의 폐허"
  },
  LanguageConfig_MainInterface_Btn_MultiTeamArena_CN = {
    Text = "광식 집중(개발 중)"
  },
  LanguageConfig_MainInterface_Btn_Send_CN = {Text = "파견"},
  LanguageConfig_MainInterface_Btn_TrinketCopy_CN = {
    Text = "금지된 기록"
  },
  LanguageConfig_MainInterface_Btn_WeekChallenge_CN = {
    Text = "무광의 영역"
  },
  LanguageConfig_MainInterface_Challenge_CN = {
    Text = "막간 훈련"
  },
  LanguageConfig_MainInterface_Home_CN = {
    Text = "연구 센터"
  },
  LanguageConfig_MainInterface_MainCopy_CN = {Text = "조사"},
  LanguageConfig_MainInterface_Recharge_CN = {Text = "상점"},
  LanguageConfig_MainInterface_Shop_CN = {
    Text = "교환 상점"
  },
  LanguageConfig_MainInterface_Summon_CN = {Text = "깨어남"},
  LanguageConfig_MainLinesChallenge_CN = {Text = "조사"},
  LanguageConfig_MainLinesDetail_CN = {
    Text = "스테이지 상세"
  },
  LanguageConfig_MainLinesHard_CN = {Text = "어려움"},
  LanguageConfig_MainLinesInvestigationResult_CN = {
    Text = "조사 평가"
  },
  LanguageConfig_MainLinesInvestigation_CN = {Text = "조사"},
  LanguageConfig_MainLinesSimple_CN = {Text = "보통"},
  LanguageConfig_MainLines_AchieveCondition_CN = {
    Text = "업적 조건 ({s1}/{s2})"
  },
  LanguageConfig_MainLines_Chapter0_CN = {Text = "서장"},
  LanguageConfig_MainLines_Chapter1_CN = {Text = "제1장"},
  LanguageConfig_MainLines_Chapter2_CN = {Text = "제2장"},
  LanguageConfig_MainLines_Chapter3_CN = {Text = "제3장"},
  LanguageConfig_MainLines_Chapter4_CN = {Text = "제4장"},
  LanguageConfig_MainLines_Chapter5_CN = {Text = "제5장"},
  LanguageConfig_MainLines_Chapter6_CN = {Text = "제6장"},
  LanguageConfig_MainLines_Chapter9_CN = {Text = "최종장"},
  LanguageConfig_MainLines_Chapterx_CN = {Text = "제{s1}장"},
  LanguageConfig_MainLines_CompleteInvestigation_CN = {
    Text = "조사 완료"
  },
  LanguageConfig_MainLines_CurrentProgressGreen_CN = {
    Text = "현재: <GreenQuality:{s1}>"
  },
  LanguageConfig_MainLines_CurrentProgressRed_CN = {
    Text = "현재: <RedQuality:{s1}>"
  },
  LanguageConfig_MainLines_DiamondMapNodeTips_CN = {
    Text = "이번은 특별한 경험으로, 아이템을 획득하지 않습니다."
  },
  LanguageConfig_MainLines_HideCondition_CN = {
    Text = "비밀 조건 ({s1}/{s2})"
  },
  LanguageConfig_MainLines_Investigation_Reward_CN = {
    Text = "조사 보상"
  },
  LanguageConfig_MainLines_NextStep_CN = {Text = "다음"},
  LanguageConfig_MainLines_StopThere_CN = {Text = "후퇴"},
  LanguageConfig_MainLines_ThreeStarConditionTips_CN = {
    Text = "조사 평가"
  },
  LanguageConfig_MainLines_ThreeStarCondition_CN = {
    Text = "3성 조건 ({s1}/{s2})"
  },
  LanguageConfig_MainLines_Ways_To_Lift_CN = {
    Text = "전투력 향상 제안"
  },
  LanguageConfig_MainShopSingleBuyConfirmPanel_Lock_CN = {Text = "미개방"},
  LanguageConfig_MainShopSingleBuyConfirmPanel_MaxPotency_CN = {
    Text = "계령이 최대 등급에 도달했습니다"
  },
  LanguageConfig_MainShopSingleBuyConfirmPanel_SellOut_CN = {
    Text = "매진되었습니다"
  },
  LanguageConfig_Main_Title_3_CN = {Text = "안내서"},
  LanguageConfig_MapEvent_Key_Tips1_CN = {
    Text = "이미 열쇠를 보유하고 있습니다."
  },
  LanguageConfig_MapNodeChaosName_CN = {
    Text = "짙은 안개"
  },
  LanguageConfig_MapNodeKeyDescription_CN = {
    Text = "열쇠 꾸러미. 녹슨 문을 열 수 있습니다."
  },
  LanguageConfig_MatchSuccessful_CN = {
    Text = "매치 성공"
  },
  LanguageConfig_MatchingPasswordBattle_CN = {
    Text = "비밀 계약을 매칭 중입니다…"
  },
  LanguageConfig_MaxHp_CN = {Text = "최대 HP"},
  LanguageConfig_MaxLevelWeaponShopTips_CN = {
    Text = "최대 중첩"
  },
  LanguageConfig_MaxLevel_Tips_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_MaxLevel_Tips_Exp_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_MaxPotencyAwakerShopTips_CN = {
    Text = "인격 심화가 최대입니다"
  },
  LanguageConfig_Minute_CN = {Text = "분"},
  LanguageConfig_MockDungeonTitle_CN = {
    Text = "모의 훈련"
  },
  LanguageConfig_MonsterHideIntention_CN = {Text = "미지"},
  LanguageConfig_MonsterMeatReaction1_CN = {
    Text = "내... 잘못이... 아니야..."
  },
  LanguageConfig_MonsterMeatReaction2_CN = {
    Text = "내ﾉ잘ｲ...驫못8이ﾃ...P아ｬ니야..."
  },
  LanguageConfig_MonsterMeatReaction3_CN = {
    Text = "그냥... 살고 싶어..."
  },
  LanguageConfig_MonsterMeatReaction4_CN = {
    Text = "그ﾗ냥ｸ...ﾎ麤살ﾑ고w싶ｦ어..."
  },
  LanguageConfig_MonsterMeatTips1_CN = {
    Text = "고ﾑ깃w덩ｦ어J리ﾒ는ｩ 각ﾇ齉성ｯ체7 카ﾘ드L를ﾝ 인Q식ｱ할ﾏ 수r 있ｮ는ﾌ 것d 같ﾙ지3만ｪ, 과ﾔ龥도G한ｽ 인ﾈ식은 그것의 의식을 부식시킨다......"
  },
  LanguageConfig_MonsterMeatTips2_CN = {
    Text = "고깃덩어리는 깨어남체 카드를 인식할 수 있는 것 같지만, 과도한 인식은 그것의 의식을 부식시킨다…"
  },
  LanguageConfig_MonsterMeat_Bubble1_CN = {
    Text = "먹ﾐ을4Pｾ......수喰qｪ齉ﾙ 있Kt......nの東鬱ｿ7는ｪ 것"
  },
  LanguageConfig_MonsterMeat_Bubble2_CN = {
    Text = "먹을 수 있는… 것"
  },
  LanguageConfig_MonsterMeat_Name_CN = {
    Text = "기괴한 고깃덩어리"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss1_CN = {
    Text = "적의 영향으로 카드를 내기 어렵습니다! 은열쇠의 인도를 따라 슬픔의 화신을 이겨내세요!"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss2_CN = {
    Text = "광기를 발산하는 수단이 제한된 것 같습니다. 두려움의 화신의 봉인을 뚫기 위해 더 많은 광기를 폭발시켜 보세요."
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss3_CN = {
    Text = "깨어남체의 능력이 점차 녹아내릴 것이니, 힘을 한 사람에게 집중하여 차가운 화신을 물리쳐라!"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss4_CN = {
    Text = "적의 사슬은 당신의 여러 번 공격 능력에 영향을 미칩니다. 여러 번 폭발하여 봉인을돌파하면 기묘한 존재를 물리칠 수 있습니다!"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss5_CN = {
    Text = "일반적인 공격 방법이 효과가 없는 것 같습니다… 악신의 화신을 격파하기 위해 다른 방법을 시도해 보세요…"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss6_CN = {
    Text = "적의 광기는 당신이 자신을 잃게 만들 것입니다. 더 많은 명령 카드를 회전시켜 광기에 맞서고, 광기의 화신을 이기세요!"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss7_CN = {
    Text = "적의 재생 능력이 매우 강하며 상태 영향을 제거할 수 있습니다. 매 턴 안정적으로 피해를 입혀 강림한 존재를 격파하세요!"
  },
  LanguageConfig_Monster_6unit_B0006_Tips1_CN = {
    Text = "딸… 속에서… 깨어나……"
  },
  LanguageConfig_Monster_6unit_B0006_Tips2_CN = {
    Text = "변화… 이로써 태어난다……"
  },
  LanguageConfig_Monster_6unit_B0006_Tips3_CN = {
    Text = "심연 속의 깜빡임... 안 돼... 하지 마..."
  },
  LanguageConfig_Monster_6unit_C0602_tips1_CN = {
    Text = "숙주의 몸에서 재탄생..."
  },
  LanguageConfig_Monster_6unit_C0602boss_tips1_CN = {
    Text = "나... 네가 보여..."
  },
  LanguageConfig_Monster_6unit_C0602boss_tips2_CN = {
    Text = "적이 엄청난 속도로 HP를 회복하고 있습니다! 피해를 주어 막야아 합니다!"
  },
  LanguageConfig_Monster_6unit_C0603_BOSSSIZE_Tips1_CN = {
    Text = "보아라, 이 몸에 깃든 신의 은총을… 목격하라……!"
  },
  LanguageConfig_Monster_6unit_C0603_Tips1_CN = {
    Text = "탄생… 쉬익… 탄생……"
  },
  LanguageConfig_Monster_6unit_C0603_tips1_CN = {
    Text = "내 산호... 마음에 들었으면 좋겠네..."
  },
  LanguageConfig_Monster_6unit_C0603_tips2_CN = {
    Text = "적의 HP가 일정량 감소할 때마다, 「변이 산호」가 몸속에서 생성됩니다!"
  },
  LanguageConfig_Monster_6unit_EndBoss_Select_Card_Tips_CN = {
    Text = "효과 하나를 선택하여 발동"
  },
  LanguageConfig_Monster_8unit_EndBoss_Num3_Tips_CN = {
    Text = "빛의 아이를 공격하면 안 됩니다! 어둠의 아이를 쓰러뜨려 그녀를 깨우세요!"
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips1_CN = {
    Text = "그것이 그대의 답이라면, 원한의 사슬 속에서... 동료들을 구해 보아라."
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips2_CN = {
    Text = "그것이 그대의 답이라면, 수많은 왜곡 속에서... 소중한 세계를 구해 보아라."
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips3_CN = {
    Text = "그것이 그대의 답이라면, 방향을 알 수 없는 세계에서... 자신을 구해 보아라."
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips4_CN = {
    Text = "침묵, 망설임, 나약함... 그대의 약점은 치명적이다, 수호자."
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips_CN = {
    Text = "타비에게 대답하기"
  },
  LanguageConfig_Monster_AF_C09_CN = {
    Text = "판디아는 감히 그녀를 공격하는 나쁜 아이들에게 가혹한 벌을 선사할 겁니다……"
  },
  LanguageConfig_Monster_ALKNSpider_DarkTips_CN = {
    Text = "울어라, 웃어라! 그 숙명의 종말이 곧 다가온다!"
  },
  LanguageConfig_Monster_ALKNSpider_LightTips_CN = {
    Text = "잠들어라, 잠들어라……그 숙명의 결말이 이곳에 내릴 것이다……"
  },
  LanguageConfig_Monster_ALKN_Bubble1_CN = {
    Text = "돌아라, 물레가 만물을 짜낼 것이다."
  },
  LanguageConfig_Monster_ALKN_Bubble2_CN = {
    Text = "운명이 너와 나를 묶었다, 아무도 도망칠 수 없어……"
  },
  LanguageConfig_Monster_ALKN_Bubble3_CN = {
    Text = "끊어라, 되돌릴 수 없는 운명이여."
  },
  LanguageConfig_Monster_ALKN_DarkTips1_CN = {
    Text = "운명의 종국이 곧 다가온다……"
  },
  LanguageConfig_Monster_ALKN_DarkTips2_CN = {
    Text = "받아들여라, 아라크네…… 운명은 너에게 해방을 가져다줄 것이다!"
  },
  LanguageConfig_Monster_ALKN_DarkTips3_CN = {
    Text = "「과거——운명의 실타래로 봉인되어, 너는 영원히 침묵의 심연으로 떨어지리라!」"
  },
  LanguageConfig_Monster_ALKN_DarkTips4_CN = {
    Text = "「현재—— 모든 운명과 엮인 거짓말들이여, 전부 재로 화하라!」"
  },
  LanguageConfig_Monster_ALKN_DarkTips5_CN = {
    Text = "「미래——이 가시의 씨앗을, 내일의 토양 깊이 묻어라. 미래에, 우리에게는 아무것도 남지 않으리……」"
  },
  LanguageConfig_Monster_ALKN_DarkTips6_CN = {
    Text = "「끊어라……끊어라! 오너라, 운명이여! 나는 버려진 모든 해골로, 너에게 이 마지막 비가를 바치리라!」"
  },
  LanguageConfig_Monster_ALKN_Tips1_CN = {
    Text = "매 턴 첫 번째 명령 카드가 차원 균열에 빠집니다. 열쇠 지령을 사용하여 원래의 궤도로 되돌려 주세요."
  },
  LanguageConfig_Monster_ALKN_Tips2_CN = {
    Text = "차원 균열 속 카드는 타락한 운명에 오염되었습니다. 신중하게 사용하세요!"
  },
  LanguageConfig_Monster_Agrippa_bubble_01_CN = {
    Text = "천한 것... 감히 나를 이렇게 대하다니!"
  },
  LanguageConfig_Monster_Agrippa_bubble_tips_01_CN = {
    Text = "조심하세요! 적의 공격은 중독 효과를 동반합니다."
  },
  LanguageConfig_Monster_Agrippa_bubble_tips_02_CN = {
    Text = "적은 일정 피해를 받으면 견고 상태에 진입하고 방어 태세로 전환됩니다."
  },
  LanguageConfig_Monster_Awaker_O04_Tips_1_CN = {
    Text = "카이커스가 놀라운 속도로 상처를 치유하고 있습니다. 그를 공격하여 회복을 방해하세요!"
  },
  LanguageConfig_Monster_B0001_1_CN = {
    Text = "당신의 몸이 점점 무거워지면서, 깨어남체에게 명령을 내리기가 어려워집니다…"
  },
  LanguageConfig_Monster_B0001_2_CN = {
    Text = "미안해요…"
  },
  LanguageConfig_Monster_B0001_3_CN = {
    Text = "조심해요! 이번 턴에 사용되지 않은 카드는 모두 돌로 변하고 말 거예요…"
  },
  LanguageConfig_Monster_B0002_1_CN = {
    Text = "배고파, 조지 배가 너무 꼬르륵거려요…"
  },
  LanguageConfig_Monster_B0002_2_CN = {
    Text = "조지를 버리지 마요, 저희를 버리지 말아주세요……!"
  },
  LanguageConfig_Monster_B0002_Tips_1_CN = {
    Text = "조지가 동료들에게 명령을 내리려 하고 있습니다..."
  },
  LanguageConfig_Monster_B0003_Tips_1_CN = {
    Text = "광기와 융식이 카드를 집어삼키고 있습니다. 사용한 카드가 소모됩니다."
  },
  LanguageConfig_Monster_B0003_Tips_2_CN = {
    Text = "세계의 문을… 봉쇄한다!"
  },
  LanguageConfig_Monster_B0004_1_CN = {
    Text = "「차원을 찢는 사냥개」가 당신을 노리고 있습니다... 차원 균열에 카드를 넣어 자신을 보호하세요!"
  },
  LanguageConfig_Monster_B0004_2_CN = {
    Text = "현실타래이…… 찢어집니다!"
  },
  LanguageConfig_Monster_B0005_1_CN = {
    Text = "더러운... 불경한 자..."
  },
  LanguageConfig_Monster_B0005_2_CN = {
    Text = "잠자는 군주이시여, 저의 부름에 답하소서..."
  },
  LanguageConfig_Monster_B0005_3_CN = {
    Text = "영원@1, 꿈@1, 속으로..."
  },
  LanguageConfig_Monster_B0005_4_CN = {
    Text = "혼돈은 사라지고, 별들이... 제자리로 돌아올 것이다"
  },
  LanguageConfig_Monster_B0005_5_CN = {
    Text = "주여, 불경한 자에게 심판을 내리는 것을 용서하소서...!"
  },
  LanguageConfig_Monster_B0005_6_CN = {
    Text = "아...안돼! 어째서 날 방해하는 것이냐...!"
  },
  LanguageConfig_Monster_B0005_7_CN = {
    Text = "모독자여... 극형을 마주하라!"
  },
  LanguageConfig_Monster_B0005_CN = {
    Text = "신을 모독하는 자... 대행자의 이름으로 신벌을 내리겠다!"
  },
  LanguageConfig_Monster_B0005_Tips_1_CN = {
    Text = "「미리암」이라고 불리었던 존재가, 신의 시선을 받고자 기도하고 있습니다..."
  },
  LanguageConfig_Monster_B0007_SideDia1_CN = {
    Text = "지모수가 수많은 아란의 혈육을 흡수했습니다..."
  },
  LanguageConfig_Monster_B0007_SideDia2_CN = {
    Text = "지모수의 혹에서 생명의 박동이 느껴집니다..."
  },
  LanguageConfig_Monster_B0007_SideDia3_CN = {
    Text = "그는 근원이자, 풍요이며, 무수한 자손을 낳는다……"
  },
  LanguageConfig_Monster_B0008_Name1_CN = {
    Text = "「쌍둥이 신상」"
  },
  LanguageConfig_Monster_B0008_Name2_CN = {
    Text = "「어둠의 아이」"
  },
  LanguageConfig_Monster_B0008_Name3_CN = {
    Text = "「망각의 시작」"
  },
  LanguageConfig_Monster_B0008_Name4_CN = {
    Text = "「망각의 마지막 진실타래」"
  },
  LanguageConfig_Monster_B0008_SideDia10_CN = {
    Text = "미안해... 수호자... 더 이상 버틸 수 없을 것 같아..."
  },
  LanguageConfig_Monster_B0008_SideDia11_CN = {
    Text = "유리에트가 신상의 힘을 포기했습니다... 쓰러뜨리세요!"
  },
  LanguageConfig_Monster_B0008_SideDia1_CN = {
    Text = "모순의 융합도에 주의하세요! 완전히 융합되면 라모나의 의식이 위험해집니다..."
  },
  LanguageConfig_Monster_B0008_SideDia2_CN = {
    Text = "유리에트가 문의 힘을 다루고 있습니다. 신상의 융합도가 매 턴 상승합니다!"
  },
  LanguageConfig_Monster_B0008_SideDia3_CN = {
    Text = "「망각」의 힘이 정신 차원에 영향을 미치고 있습니다. 음악이 더이상 닿지 않습니다..."
  },
  LanguageConfig_Monster_B0008_SideDia4_CN = {
    Text = "쌍둥이의 융합도에 주의하세요! 100%에 도달하면 라모나의 의식이 크게 영향을 받을 수 있습니다..."
  },
  LanguageConfig_Monster_B0008_SideDia5_CN = {
    Text = "무의미한 저항이야... 문의 힘은 신상의 탄생을 수호한다..."
  },
  LanguageConfig_Monster_B0008_SideDia6_CN = {
    Text = "돌아와, 라모나... 우리 함께, 궁극의 망각을 맞이하자..."
  },
  LanguageConfig_Monster_B0008_SideDia7_CN = {
    Text = "완벽한 융합... 그 때가 다가왔다! 만물의 빛을 재구성하리..."
  },
  LanguageConfig_Monster_B0008_SideDia8_CN = {
    Text = "어째서 도망치는가... 궁극의... 정화의 망각으로부터!"
  },
  LanguageConfig_Monster_B0008_SideDia9_CN = {
    Text = "침식... 파괴... 망각... 정화!"
  },
  LanguageConfig_Monster_B0009_Name1_CN = {
    Text = "「토후-와-보후, 영원의 혼돈」"
  },
  LanguageConfig_Monster_B0009_SideDia2_CN = {
    Text = "&%……&중……&시작&&*……파괴……"
  },
  LanguageConfig_Monster_B0009_SideDia3_CN = {
    Text = "원초의 혼돈이 몇 턴 후 강림합니다… 하지만 지금은 끝없이 쏟아지는 시선들을 막아내는 것이 우선입니다… 적절한 순간에 적을 격파하여 숨을 돌리세요!"
  },
  LanguageConfig_Monster_B0009_SideDia4_CN = {
    Text = "&%…무수%……¥&*…강림………"
  },
  LanguageConfig_Monster_B0009_SideDia5_CN = {
    Text = "……융식 ……소멸"
  },
  LanguageConfig_Monster_B0009_SideDia6_CN = {
    Text = "……무상 ……위압"
  },
  LanguageConfig_Monster_B0009_SideDia7_CN = {
    Text = "……망각……"
  },
  LanguageConfig_Monster_B0009_SideDia8_CN = {
    Text = "……사슬……"
  },
  LanguageConfig_Monster_B0009_SideDia9_CN = {
    Text = "융식 안개의 보호막이 파괴되었습니다! 여정의 추억이 다시 드로우 덱에 돌아와, 당신의 의지를 가득 채웁니다..."
  },
  LanguageConfig_Monster_B05EX_SideDia10_CN = {
    Text = "링크를 끊을 자의 힘과 결단, 보여줘, 수호자."
  },
  LanguageConfig_Monster_B05EX_SideDia11_CN = {
    Text = "링크가 점점 약해지고 있어… 이것이 너의 길이라면, 나는 응원할게."
  },
  LanguageConfig_Monster_B05EX_SideDia12_CN = {
    Text = "무한한 융삼켜진 검은 파도에서 발버둥쳐라—— 심연의 문이 이곳에 열리리니!"
  },
  LanguageConfig_Monster_B05EX_SideDia13_CN = {
    Text = "조심하세요! 돌의 「종말」이 쌓이고 있습니다… 10스택에 도달하면 진정한 종말이 찾아올 것입니다…"
  },
  LanguageConfig_Monster_B05EX_SideDia15_CN = {
    Text = "세계의 끝이... 드디어 도달했다!"
  },
  LanguageConfig_Monster_B05EX_SideDia16_CN = {
    Text = "깊고 어두운 미지 앞에서, 허무가 되어라."
  },
  LanguageConfig_Monster_B05EX_SideDia17_CN = {
    Text = "돌의 분신이 치명적인 피해를 받으면, 후방으로 이동한 후 더 큰 피해를 줍니다! 전투의 템포를 조절하세요!"
  },
  LanguageConfig_Monster_B05EX_SideDia18_CN = {
    Text = "아쉽네. 예비 육체 하나를 또 낭비하다니."
  },
  LanguageConfig_Monster_B05EX_SideDia19_CN = {
    Text = "이게 나의 첫 번째 철학이야."
  },
  LanguageConfig_Monster_B05EX_SideDia1_CN = {
    Text = "들어라… 영겁의 한빙이 속삭인다…!"
  },
  LanguageConfig_Monster_B05EX_SideDia24_CN = {
    Text = "5…… 조금만 더……"
  },
  LanguageConfig_Monster_B05EX_SideDia29_CN = {
    Text = "10! 종말이…… 마침내 도래하였다!"
  },
  LanguageConfig_Monster_B05EX_SideDia2_CN = {
    Text = "산맥들이… 차가운 불꽃 속에서 깨어난다…!"
  },
  LanguageConfig_Monster_B05EX_SideDia30_CN = {
    Text = "종말이 곧 강림한다…!"
  },
  LanguageConfig_Monster_B05EX_SideDia31_CN = {
    Text = "그 눈으로 종말을 목도하도록 해!"
  },
  LanguageConfig_Monster_B05EX_SideDia32_CN = {
    Text = "여기는 내 실타래험실타래이야…"
  },
  LanguageConfig_Monster_B05EX_SideDia33_CN = {
    Text = "오랜만이네, 파트너."
  },
  LanguageConfig_Monster_B05EX_SideDia3_CN = {
    Text = "카드 3장을 사용할 때마다 명령 카드 1장이 얼어붙습니다. 신중히 행동하세요!"
  },
  LanguageConfig_Monster_B05EX_SideDia4_CN = {
    Text = "남아 있는 얼어붙은 카드는 이번 턴에 모두 산산조각 나며, 적의 피해로 변환됩니다… 조심하세요!"
  },
  LanguageConfig_Monster_B05EX_SideDia5_CN = {
    Text = "조심하세요! 돌의 「종말」이 쌓이고 있습니다… 10스택에 도달하면 진정한 종말이 찾아올 것입니다…"
  },
  LanguageConfig_Monster_B05EX_SideDia6_CN = {
    Text = "주군의 힘, 저는 보았습니다…"
  },
  LanguageConfig_Monster_B05EX_SideDia7_CN = {
    Text = "방어막을 파괴하면 큰 피해를 줄 수 있지만, 동시에 적이 임시 힘을 얻습니다. 신중히 행동하세요."
  },
  LanguageConfig_Monster_B05EX_SideDia8_CN = {
    Text = "저는 이 맹세를 영원히 지킬 것입니다!"
  },
  LanguageConfig_Monster_B05EX_SideDia9_CN = {
    Text = "뇌가 담긴 통이 사라지지 않는 한, 「나」는 끊임없이 재생할 거야. 생각한 뒤 행동해."
  },
  LanguageConfig_Monster_B05EX_bubble_01_CN = {
    Text = "발버둥쳐라. 블러드 체인은 묶을수록 더 조여들 뿐이다."
  },
  LanguageConfig_Monster_B05EX_bubble_02_CN = {
    Text = "도망칠 수 없어. 여기서 끝내주지!"
  },
  LanguageConfig_Monster_B05EX_bubble_03_CN = {
    Text = "이 원한은…… 너희의 피로 갚아라!"
  },
  LanguageConfig_Monster_B05EX_tips_01_CN = {
    Text = "명령 카드를 사용할 때마다 적이 「광열」을 얻습니다. 신중하게 카드를 내세요!"
  },
  LanguageConfig_Monster_B05EX_tips_02_CN = {
    Text = "이번 턴에는 방어막 능력이 무효화됩니다. 어떻게든 살아남으세요!"
  },
  LanguageConfig_Monster_B05EX_tips_03_CN = {
    Text = "「피에 굶주린 철구」 상태에서 「혼을 거두는 자」는 모든 피해와 HP 손실에 면역됩니다. 대처에 주의하세요!"
  },
  LanguageConfig_Monster_B05_Tips1_CN = {
    Text = "내 절망과 분노를 맛봐라!!"
  },
  LanguageConfig_Monster_B11AF_bubble_01_CN = {
    Text = "요정 납시었다! 어서 봉헌을 바치지 않겠느냐?"
  },
  LanguageConfig_Monster_B11AF_bubble_02_CN = {
    Text = "흥흥, 이것이 요정의 축복이다! 믿어봐, 반드시 이루어질 테니!"
  },
  LanguageConfig_Monster_B11AF_bubble_03_CN = {
    Text = "구두쇠 같으니, 동그라미 그려서 저주해 주겠어!"
  },
  LanguageConfig_Monster_B11AF_bubble_04_CN = {
    Text = "자, 이 달콤한 축복을 받아라!"
  },
  LanguageConfig_Monster_B11AF_bubble_05_CN = {
    Text = "가득 가득한 봉헌이야! 마음에 들어!"
  },
  LanguageConfig_Monster_B11AF_bubble_06_CN = {
    Text = "하아? 아무것도 못 얻었다니?!"
  },
  LanguageConfig_Monster_B11AF_bubble_07_CN = {
    Text = "절반 봉헌도 나쁘지 않아～ 계속 힘내～"
  },
  LanguageConfig_Monster_B11AF_tips_01_CN = {
    Text = "「백설 요정」이 봉헌을 받고 있습니다. 봉헌한 자는 축복을 받을 수 있으며, 봉헌하지 않은 자는 벌을 받게 됩니다."
  },
  LanguageConfig_Monster_B11AF_tips_02_CN = {
    Text = "주의! 「백설 요정」이 더 많은 봉헌을 요구합니다."
  },
  LanguageConfig_Monster_BZLLZ_1_CN = {
    Text = "해골 사냥꾼이 깨어남체를 사냥하기 위해 행동을 강화했습니다!"
  },
  LanguageConfig_Monster_C0102_AT_1_CN = {
    Text = "적이 광란에 빠졌습니다! 위협을 줄이기 위해 공격하세요!"
  },
  LanguageConfig_Monster_C0102_AT_2_CN = {
    Text = "적이 강한 공격을 준비하고 있습니다!"
  },
  LanguageConfig_Monster_C0203_Tips_1_CN = {
    Text = "밀랍상들이 밀랍으로 무장했습니다…!"
  },
  LanguageConfig_Monster_C0303_Tips_1_CN = {
    Text = "zzzzzZZZZZ..."
  },
  LanguageConfig_Monster_C0303_Tips_2_CN = {Text = "……???"},
  LanguageConfig_Monster_C0502_1_CN = {
    Text = "재림, 탄생, 재림, 탄생…"
  },
  LanguageConfig_Monster_C0502_2_CN = {
    Text = "「해양 생물」에 기생되었습니다! 카드를 사용하면 피해를 입습니다!"
  },
  LanguageConfig_Monster_C0502_CN = {
    Text = "「찾았다...」"
  },
  LanguageConfig_Monster_C0503BOSS_Tips_1_CN = {
    Text = "남은 손패가 많을수록 적의 공격이 약해집니다. 더 많은 손패를 보존하여 적의 공격력을 줄이세요!"
  },
  LanguageConfig_Monster_C0503BOSS_Tips_2_CN = {
    Text = "남은 손패가 많을수록 적이 더 많은 장벽을 얻습니다. 최대한 손패를 사용하세요!"
  },
  LanguageConfig_Monster_C0503BOSS_Tips_3_CN = {
    Text = "조심하세요! 적의 큰 공격으로 인해 모든 손패가 버려집니다!"
  },
  LanguageConfig_Monster_C0603BOSS_Tips_1_CN = {
    Text = "적의 HP가 일정량 줄어들 때마다, 「영지의 자식」이 배에서 태어납니다!"
  },
  LanguageConfig_Monster_C0603_Title_CN = {
    Text = "조심하세요! 광기 폭발을 발동하면 적에게 「잉태」상태가 부여되어 적의 힘이 증가하고, 5스택에 도달하면 강력한 스킬을 해방합니다!"
  },
  LanguageConfig_Monster_C06_Tips_1_CN = {
    Text = "「분열 환자」가 곧 미쳐버립니다! 빨리 「평온의 종」을 사용하여 그녀의 광기를 낮추세요!"
  },
  LanguageConfig_Monster_C06_Tips_2_CN = {
    Text = "누구라도 흙으로 돌아가기 마련이다…… 산산조각나라!"
  },
  LanguageConfig_Monster_C09_Tips_1_CN = {
    Text = "달콤한 소악마가 반격을 준비합니다…!"
  },
  LanguageConfig_Monster_C11_SideDia1_CN = {
    Text = "나는 아란을 보호할 것이다!"
  },
  LanguageConfig_Monster_C11_SideDia2_CN = {
    Text = "적이 심안의 칼날을 준비하고 있습니다! 방어막을 파괴하여 피해를 줄이세요!"
  },
  LanguageConfig_Monster_C702BOSS_SideDia1_CN = {
    Text = "「성스러운 강의 누비아」가 강력한 공격을 준비하고 있습니다! 다른 적들을 물리쳐서 약화시키세요!"
  },
  LanguageConfig_Monster_C702_SideDia1_CN = {
    Text = "「셀케트」가 강력한 공격을 준비하고 있습니다! 다른 적들을 물리쳐서 약화시키세요!"
  },
  LanguageConfig_Monster_C702_SideDia2_CN = {
    Text = "적이 그림자 속으로 숨어들어 자신을 보호하려고 합니다..."
  },
  LanguageConfig_Monster_C702_SideDia3_CN = {
    Text = "&&……%그림자)&…습격&…%"
  },
  LanguageConfig_Monster_C703_SideDia1_CN = {
    Text = "&…%…&하나로*()융합&……%"
  },
  LanguageConfig_Monster_C703_SideDia2_CN = {
    Text = "조심하세요! 증상 또는 상태 카드를 뽑으면 「누비아」들이 임시 힘을 획득합니다!"
  },
  LanguageConfig_Monster_C704BOSS_SideDia1_CN = {
    Text = "진형 변경! 방어한다!"
  },
  LanguageConfig_Monster_C704BOSS_SideDia2_CN = {
    Text = "진형 변경! 돌격하라!"
  },
  LanguageConfig_Monster_C704BOSS_SideDia3_CN = {
    Text = "너희의 피와 육체는 성스러운 강으로 돌아갔다!"
  },
  LanguageConfig_Monster_C704BOSS_SideDia4_CN = {
    Text = "전사들이여! 진형을 다듬어라!"
  },
  LanguageConfig_Monster_C706BOSS_SideDia1_CN = {
    Text = "황색 모래의 하늘 아래에서... 장례를 치러 주마..."
  },
  LanguageConfig_Monster_C706BOSS_SideDia2_CN = {
    Text = "조심하세요! 적이 하늘을 뒤덮은 황색 모래로 모든 깨어남체의 광기를 흡수할 것입니다!"
  },
  LanguageConfig_Monster_Castor_01_CN = {
    Text = "무엇이 우리 앞을 가로막든, 그를 데리고 다시 도망칠 겁니다."
  },
  LanguageConfig_Monster_Castor_02_CN = {
    Text = "너의 소원, 우리의 소원... 나는 포기하지 않아, 절대로."
  },
  LanguageConfig_Monster_Castor_03_CN = {
    Text = "적이 축적된 검은 깃털을 모두 방출하려 합니다..."
  },
  LanguageConfig_Monster_Chapter8_01_CN = {
    Text = "회복 수단이 영향을 받았습니다. 날아오는 적의 칼날에 주의하세요!"
  },
  LanguageConfig_Monster_Chapter8_02_CN = {
    Text = "은열쇠를 사용하면 에리카의 상태가 변화합니다. 이를 활용해 보세요!"
  },
  LanguageConfig_Monster_Chapter8_03_CN = {
    Text = "알 수 없는 명령 수신. 공격 모드로 변경."
  },
  LanguageConfig_Monster_Chapter8_04_CN = {
    Text = "알 수 없는 명령 수신. 방어 모드로 변경."
  },
  LanguageConfig_Monster_Chapter8_05_CN = {
    Text = "의도에 맞는 행동력을 가진 카드를 사용하면, 적의 공격을 약화시킬 수 있지만, 카드를 소모하게 됩니다. 조심하세요!"
  },
  LanguageConfig_Monster_Chapter8_06_CN = {
    Text = "「원초의 선율」을 최대한 막아내지 못하면, 적이 크게 강화됩니다...!"
  },
  LanguageConfig_Monster_Chapter8_07_CN = {
    Text = "버텨 보시죠... 제 전력의 일격을...!"
  },
  LanguageConfig_Monster_Chapter8_08_CN = {
    Text = "주인님은 약속했어요... 다시 태어난 저는 영원해질 거라고...!"
  },
  LanguageConfig_Monster_Chapter8_09_CN = {
    Text = "혈육의 자손이여... 자라나거라..."
  },
  LanguageConfig_Monster_Chapter8_10_CN = {
    Text = "조심하세요! 적이 관통 피해와 심각한 손상을 입힐 예정입니다. 방어막에 큰 영향을 줄 것입니다!"
  },
  LanguageConfig_Monster_Chapter8_11_CN = {
    Text = "순순히 굴어. 꼬마 냥이."
  },
  LanguageConfig_Monster_Chapter8_12_CN = {
    Text = "진정하렴, 아이야. 내가 너희를 올바른 길로 인도해 줄테니…"
  },
  LanguageConfig_Monster_Chapter8_13_CN = {
    Text = "갈채를 보내세요! 공연이 절정에 다다르고 있습니다!"
  },
  LanguageConfig_Monster_Chapter8_14_CN = {
    Text = "등불 교회를 위해...!"
  },
  LanguageConfig_Monster_Chapter8_15_CN = {
    Text = "등불은 우리에게 영광스러운 진화를 선사할 것입니다!"
  },
  LanguageConfig_Monster_Chapter8_16_CN = {
    Text = "「N」이 분신 뒤로 이동했습니다... 적절한 기회를 찾아 단숨에 격파하세요!"
  },
  LanguageConfig_Monster_Chapter8_17_CN = {
    Text = "적이 견고 상태에 진입했습니다! 피 묻은 심지를 활용하여 기회를 찾아 적을 처치하세요!"
  },
  LanguageConfig_Monster_Corposant_01_CN = {
    Text = "차가운 빛, 여기서 항로를 인도한다..."
  },
  LanguageConfig_Monster_Corposant_02_CN = {
    Text = "항로 확정, 전 선원은 주목하라."
  },
  LanguageConfig_Monster_Corposant_03_CN = {
    Text = "희생은 불가피하며, 나는 이미 준비되었다."
  },
  LanguageConfig_Monster_Corposant_04_CN = {
    Text = "천둥과 함께, 반역자들을 벌하라!"
  },
  LanguageConfig_Monster_Corposant_05_CN = {
    Text = "나는 세인트 엘모의 불이자, 앞길을 밝히는 길잡이다."
  },
  LanguageConfig_Monster_Cursedbreath_Bubble_CN = {
    Text = "바다의 악령과 함께 춤추자!"
  },
  LanguageConfig_Monster_Cursedbreath_Tips_CN = {
    Text = "가능한 한 적의 공격을 막아 소환을 피하세요!"
  },
  LanguageConfig_Monster_D08_SideDia1_CN = {
    Text = "적대 세력 감지. 전자기포 충전 완료. 조준 개시..."
  },
  LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia1_CN = {
    Text = "적이 랜덤으로 깨어남체 1명의 카드를 융식으로 덧칠할 것입니다!"
  },
  LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia2_CN = {
    Text = "과거의 기억들이, 모두 마른 가지와 함께 사라지도록."
  },
  LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia3_CN = {
    Text = "이 시편의 낙원에 매료되어라..."
  },
  LanguageConfig_Monster_DCD06_01_SideDia1_CN = {
    Text = "적이 랜덤으로 깨어남체 1명의 카드를 덧칠할 것입니다!"
  },
  LanguageConfig_Monster_DYQ_1_CN = {
    Text = "적은 「차원 장벽」에 둘러싸여 있으며, HP가 일정 수준 이하로 감소할 때마다 대량의 방어막을 획득합니다."
  },
  LanguageConfig_Monster_Decay_Tips_CN = {
    Text = "HP 회복이 50% 이상이면 부패 상태가 해제됩니다!"
  },
  LanguageConfig_Monster_DeepSeaAcolyte_Tips_CN = {
    Text = "적의 「피의 서약」 상태는 임시 촉수 수량을 크게 증가시킵니다! 피해를 주어 「피의 서약」을 격파하세요!"
  },
  LanguageConfig_Monster_Doresain_01_CN = {
    Text = "식사를 방해하지 마세요."
  },
  LanguageConfig_Monster_Doresain_02_CN = {
    Text = "제 양식이 되어주시죠."
  },
  LanguageConfig_Monster_Doresain_03_CN = {
    Text = "당신의 행동은 대가를 치르게 될 겁니다."
  },
  LanguageConfig_Monster_Doresain_04_CN = {
    Text = "조심하세요, 적이 더 많은 잔해를 소모할수록 이번 힘 증가 효과는 더욱 강화됩니다!"
  },
  LanguageConfig_Monster_FL01_CN = {
    Text = "둔화 효과로 카드를 사용하기 어려워집니다! 광기 폭발을 자주 발동하여 슬픔의 화신을 물리치세요!"
  },
  LanguageConfig_Monster_FL02_CN = {
    Text = "밀랍인형관의 영혼은 당신의 광기를 갈망합니다... 더 많은 명령 카드를 순환시켜 두려움의 화신을 물리치세요!"
  },
  LanguageConfig_Monster_FL03_CN = {
    Text = "특정 카드들이 서서히 용해될 것입니다… 포기할 수 없는 것들을 손에 쥐고... 혹한의 화신을 물리치세요…"
  },
  LanguageConfig_Monster_FL04_CN = {
    Text = "사슬과 차원 장벽은 차원의 사냥개의 주특기입니다… 매 턴 데미지를 입혀서 변화의 화신을 물리치세요..."
  },
  LanguageConfig_Monster_FL05_CN = {
    Text = "일반적인 공격은 효과가 없는 것 같습니다... 이단의 화신을 물리치기 위한 다른 방법을 시도해 보세요..."
  },
  LanguageConfig_Monster_FL06_CN = {
    Text = "적은 당신을 광기로 몰아넣고 있습니다... 은열쇠가 이성을 되찾는 데에 도움이 될 지도 모릅니다... 광기의 화신을 물리치세요..."
  },
  LanguageConfig_Monster_FL07_CN = {
    Text = "적은 극도로 높은 재생 능력을 지녔으며, 다양한 상태 이상을 제거할 수 있습니다! 한 번에 본원의 화신을 물리치세요!"
  },
  LanguageConfig_Monster_FL08_CN = {
    Text = "원래 말하고 싶은 게 있었는데…"
  },
  LanguageConfig_Monster_FL09_CN = {
    Text = "내게 안기렴... 함께라면... 사라지지 않을 거야..."
  },
  LanguageConfig_Monster_FL10_CN = {
    Text = "말해주세요. 결국 당신은 누구인가요?"
  },
  LanguageConfig_Monster_FL11_CN = {
    Text = "괜찮아요, 걱정 마세요... 이건 치료일 뿐이에요..."
  },
  LanguageConfig_Monster_FL12_CN = {
    Text = "여기는 내 실타래험실타래이야..."
  },
  LanguageConfig_Monster_FL13_CN = {
    Text = "종말이 곧 강림한다...!"
  },
  LanguageConfig_Monster_FL14_CN = {
    Text = "그 두 눈으로 종말을 목격해 봐!"
  },
  LanguageConfig_Monster_FL15_CN = {
    Text = "@1go-@4 8겹의 융식 안개 보호막이 제거되어, 받는 피해가 크게 증가합니다. 기회를 놓치지 말고 쓰러뜨리세요...!"
  },
  LanguageConfig_Monster_FL16_CN = {
    Text = "@3은 당신과 @3심리@3상담을 해주고 싶어"
  },
  LanguageConfig_Monster_FL17_CN = {
    Text = "@4고통…@2더……"
  },
  LanguageConfig_Monster_FL18_CN = {
    Text = "적이 군체 의식과 소통하고 있습니다. 이 틈을 타서 공격하세요!"
  },
  LanguageConfig_Monster_FL19_CN = {
    Text = "조심하세요. 광기 폭발을 발동할 때마다 적이 임시 광기를 획득합니다."
  },
  LanguageConfig_Monster_FL20_CN = {
    Text = "의사... 의사 선생님! @1살려주세요!"
  },
  LanguageConfig_Monster_FL21_CN = {
    Text = "@2들이여, 헌신하십시오... 여러@1의 고통을..."
  },
  LanguageConfig_Monster_FL22_CN = {
    Text = "나와... 링크를..."
  },
  LanguageConfig_Monster_FL23_CN = {
    Text = "적은 막대한 힘을 얻었지만, 동시에 고대의 재를 획득하여 매 턴 받는 피해가 증가합니다..."
  },
  LanguageConfig_Monster_FL24_CN = {
    Text = "깨어남체 1명을 선택하여 해당 깨어남체의 모든 카드와 광기 폭발을 3턴 동안 봉인합니다."
  },
  LanguageConfig_Monster_FL25_CN = {
    Text = "초차원의 @1번데기가 우주 에테르를 축적하고 있습니다. 최대한 많은 곤충을 처치하여 방해하세요...!"
  },
  LanguageConfig_Monster_Faint_Bubble1_CN = {
    Text = "틴커트는 내가 껍질을 떠나는 것을 원하지 않지만, 그녀는 없어요……"
  },
  LanguageConfig_Monster_Faint_Bubble2_CN = {
    Text = "통제 불능…위험…나에게서 멀리 떨어져……"
  },
  LanguageConfig_Monster_Faint_Tips1_CN = {
    Text = "파인트가 양분을 흡수하고 있습니다……그녀에게 피해를 입혀서 방해해 보세요!"
  },
  LanguageConfig_Monster_Faint_Tips2_CN = {
    Text = "명령 카드를 사용할 때마다 힘이 흡수됩니다. 신중하게 행동하세요!"
  },
  LanguageConfig_Monster_Faros_bubble_tips_01_CN = {
    Text = "조심해! 방어 후 촉수 피해를 입으면 중독 효과가 덧붙여진다!"
  },
  LanguageConfig_Monster_FishLeap_Bubble_CN = {
    Text = "어군 도약!"
  },
  LanguageConfig_Monster_Ghoul_01_CN = {
    Text = "유해의 성이여, 나의 영혼을 보호하라..."
  },
  LanguageConfig_Monster_Ghoul_02_CN = {
    Text = "거대한 파도 앞에서 흩어져라..."
  },
  LanguageConfig_Monster_Ghoul_03_CN = {
    Text = "날카로운 공격이군요... 하지만 저는 쓰러지지 않을 겁니다...!"
  },
  LanguageConfig_Monster_Ghoul_04_CN = {
    Text = "그녀를 위해... 절대 쓰러질 수 없어...!"
  },
  LanguageConfig_Monster_Ghoul_05_CN = {
    Text = "조심하세요. 적이 광폭 상태에 진입하여, 피해를 입을 때마다 임시 힘을 얻습니다!"
  },
  LanguageConfig_Monster_Ghoul_06_CN = {
    Text = "바다를 건너는 자의 거대한 파도가 곧 다가옵니다... 저지하기 위해 크리티컬 피해를 가하세요!"
  },
  LanguageConfig_Monster_HDN_SideDia1_CN = {
    Text = "마스터 후디니가 행운아 한 명을 뽑을 거예요! 그 행운아는 과연 누구일까~요~?"
  },
  LanguageConfig_Monster_HDN_SideDia2_CN = {
    Text = "눈부시고 정교한 카드 쇼!"
  },
  LanguageConfig_Monster_HDN_SideDia3_CN = {
    Text = "마스터 후디니의 마술 쇼, 지금 바로 시작합니다!"
  },
  LanguageConfig_Monster_HDN_SideDia4_CN = {
    Text = "가라, 마술 조수! 마스터 후디니의 관객을 들어올려!"
  },
  LanguageConfig_Monster_JL_Tips_1_CN = {
    Text = "카렌이 「배부름」 상태가 되었습니다! 행동력을 소모할 때마다 카렌이 힘을 획득합니다!"
  },
  LanguageConfig_Monster_KM_1_CN = {
    Text = "적에게 「반격」 상태가 쌓였습니다. 공격에 유의하세요!"
  },
  LanguageConfig_Monster_KXY_SideDia1_CN = {
    Text = "이제 필요 없다면, 사라져버리게 해볼까요!"
  },
  LanguageConfig_Monster_KXY_SideDia2_CN = {
    Text = "어느 걸 골라도 소용없어요, 소용없다고요!"
  },
  LanguageConfig_Monster_KathiguRa_01_CN = {
    Text = "불타는 카드를 사용하면 양측에 활염이 부여됩니다!"
  },
  LanguageConfig_Monster_KathiguRa_02_CN = {
    Text = "수억의 광휘 속에서, 불타버려라!"
  },
  LanguageConfig_Monster_KathiguRa_03_CN = {
    Text = "폭발하는 불꽃이여, 여기서 다시 타올라라!"
  },
  LanguageConfig_Monster_KathiguRa_04_CN = {
    Text = "적이 강력한 공격을 발산합니다! 연소 카드를 사용하여 적을 약화시키세요."
  },
  LanguageConfig_Monster_LLZ_1_CN = {
    Text = "해골 사냥꾼이 사냥을 시작했습니다. 카드를 1장 뽑을 때마다 주목을 받습니다!"
  },
  LanguageConfig_Monster_LLZ_2_CN = {
    Text = "해골 사냥꾼이 깨어남체를 사냥하기 위해 추적 본능을 일깨웠습니다!"
  },
  LanguageConfig_Monster_LL_1_CN = {
    Text = "적에게 일정량의 피해를 입히면 행동 방식이 변경됩니다!"
  },
  LanguageConfig_Monster_LL_2_CN = {
    Text = "적의 방어막 값은 턴 종료 시 HP로 전환됩니다. 파괴하세요!"
  },
  LanguageConfig_Monster_LT_1_CN = {
    Text = "적이 「영지 깨어남」을 발동하여 전세를 바꾸려고 합니다! 이번 턴의 모든 피해가 무효화됩니다…"
  },
  LanguageConfig_Monster_Liz_Bubble1_CN = {
    Text = "녹염 속에서 정화하세요!"
  },
  LanguageConfig_Monster_Liz_Bubble2_CN = {
    Text = "경의를 표하며 감상하라, 죽음을 고하는 춤……"
  },
  LanguageConfig_Monster_Liz_Tips1_CN = {
    Text = "적에게 피해를 입힌 후 강화가 진행됩니다. 조심히 행동하세요!"
  },
  LanguageConfig_Monster_Liz_Tips2_CN = {
    Text = "적이 죽음을 고하는 춤을 사용합니다. 모든 카드를 버리고 가능한 한 카드를 사용하세요!"
  },
  LanguageConfig_Monster_Liz_Tips3_CN = {
    Text = "적이 생명을 잃으면 녹염을 돕고, 리듬을 조절합니다!"
  },
  LanguageConfig_Monster_MLYM_Tips_CN = {
    Text = "주의! 광기 폭발을 방출하면 적에게 “호출” 상태가 부여되어 적의 힘이 증가하고, 5층에 도달하면 강력한 스킬을 방출합니다!"
  },
  LanguageConfig_Monster_MadHorse_1_CN = {
    Text = "턴 동안에 가한 피해는 적의 융식 상처를 심화시킵니다."
  },
  LanguageConfig_Monster_MadHorse_2_CN = {
    Text = "완전히 피해를 막지 못한다면, 추가적인 「상처」를 얻습니다."
  },
  LanguageConfig_Monster_Mofei_Tips_CN = {
    Text = "이 턴 내 그에게 입히는 피해는 반드시 치명타가 되지만, 방어에 주의하는 것이 좋습니다!"
  },
  LanguageConfig_Monster_Mouchette_Bubble1_CN = {
    Text = "반짝이는☆회오리바람——!!"
  },
  LanguageConfig_Monster_Mouchette_Bubble2_CN = {
    Text = "자, 자! 살육의 게임이 시작되었어요, 우리 세상의 끝까지 싸워봅시다!"
  },
  LanguageConfig_Monster_Mouchette_Bubble3_CN = {
    Text = "짱☆짱! 살육의 시간이 다가왔다——다음은 나야~"
  },
  LanguageConfig_Monster_Mouchette_Tips1_CN = {
    Text = "주의하세요, “안개 속의 괴수”의 공격이 막힐 때마다 그녀는 더 강해집니다!"
  },
  LanguageConfig_Monster_Mouchette_Tips2_CN = {
    Text = "조심해라, “안개 속의 괴수”의 공격이 한 번 피해를 입힐 때마다 그녀는 더욱 열광적으로 변한다!"
  },
  LanguageConfig_Monster_Neurotoxin_Bubble_CN = {
    Text = "맹독 앞에서 부패하라……"
  },
  LanguageConfig_Monster_Neurotoxin_Tips_CN = {
    Text = "적군이 관통 피해를 입힐 예정입니다. 최대한 HP를 회복하세요!"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble1_CN = {
    Text = "윤회에 빠져…… 영원한 낙원이……"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble2_CN = {
    Text = "신국의 영광은 세상에 비춰야 합니다!"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble3_CN = {
    Text = "당신은…… 환생의 중심과 면담하게 된다……"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble4_CN = {
    Text = "무지한 자여…… 그대들은 이미 나의 신의 나라에 있습니다."
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Tips1_CN = {
    Text = "「꿈의 족쇄」를 파괴하면 둔화를 감소시킬 수 있지만, 「낙원의 장막」의 배척 효과가 더 강해질 것입니다..."
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Tips2_CN = {
    Text = "둔화가 부여된 카드를 사용하여 적의 피해 횟수를 줄일 수 있습니다...!"
  },
  LanguageConfig_Monster_NewUnit5_EndBoss_Bubble1_CN = {
    Text = "받아들여라, 아라크네…… 운명은 너에게 해방을 가져다줄 것이다!"
  },
  LanguageConfig_Monster_NewUnit5_EndBoss_Tips1_CN = {
    Text = "명령 카드를 사용하면 적의 운명의 속박이 점차 감소하여 열광을 얻을 수 있습니다…"
  },
  LanguageConfig_Monster_NewUnit5_EndBoss_Tips2_CN = {
    Text = "명령 카드를 사용하면 차원 균열에 진입하며, 같은 이름의 카드에 「운명의 파편」을 부여합니다. 운명의 파편을 쌓아, 아라크네가 이 뒤틀린 운명을 바로잡게 하세요!"
  },
  LanguageConfig_Monster_O01_SideDia1_CN = {Text = "zzzZZZZ…"},
  LanguageConfig_Monster_O01_SideDia2_CN = {
    Text = "*&...%¥...@...&...zzzzZZZZ..."
  },
  LanguageConfig_Monster_O01_SideDia3_CN = {
    Text = "누가 내 잠을 방해하는가…!"
  },
  LanguageConfig_Monster_O01_SideDia4_CN = {
    Text = "시끄러운 놈… 네 어리석은 행동을 후회하도록 하여라!"
  },
  LanguageConfig_Monster_O01_SideDia5_CN = {
    Text = "카드를 사용하거나 광기 폭발을 발동하면 툴루의 졸음이 사라집니다…"
  },
  LanguageConfig_Monster_O07_Tips1_CN = {
    Text = "너 자신을 희생하라! 신국의 제물이 되어라!"
  },
  LanguageConfig_Monster_Ocean_Tips_CN = {
    Text = "턴 종료 시, 모든 촉수가 1번씩 공격합니다."
  },
  LanguageConfig_Monster_Ocean_Title_CN = {Text = "촉수"},
  LanguageConfig_Monster_Pickman_bubble_01_CN = {
    Text = "진실타래이란 무엇일까? 거짓이란 무엇일까?"
  },
  LanguageConfig_Monster_Pickman_bubble_02_CN = {
    Text = "광란은 이 세계의 유일한 진리다! 그것은 예술의 유일한 진리다!"
  },
  LanguageConfig_Monster_Pickman_bubble_tips_01_CN = {
    Text = "적이 대량의 피해를 입히려 합니다. 가능한 한 인지 부조화 카드를 내서 적의 피해를 줄이세요!"
  },
  LanguageConfig_Monster_Pickman_bubble_tips_02_CN = {
    Text = "적이 강해졌습니다. 부여한 인지 부조화에 이상한 변화가 발생했습니다!"
  },
  LanguageConfig_Monster_Pickman_bubble_tips_03_CN = {
    Text = "주의! 인지 착란 카드를 낼 때, 적의 공격 횟수가 증가합니다."
  },
  LanguageConfig_Monster_Pollux_bubble_01_CN = {
    Text = "네 죄악을 직시하고, 등불의 심판을 받아라."
  },
  LanguageConfig_Monster_Pollux_bubble_02_CN = {
    Text = "죄악으로 가득 찬 자여, 빛나는 자 앞에 후회하라!"
  },
  LanguageConfig_Monster_Pollux_bubble_tips_01_CN = {
    Text = "「성자·백야」가 「성심」을 발동하려 합니다! 명령 카드를 사용하면 그의 광열이 더욱 심해지니, 신중하게 행동하세요!"
  },
  LanguageConfig_Monster_Pollux_bubble_tips_02_CN = {
    Text = "「성자·백야」는 매 행동 시 발생하는 「죄인」을 떠안으며, 「대죄」의 제거 효과가 절반으로 감소합니다."
  },
  LanguageConfig_Monster_Pollux_bubble_tips_03_CN = {
    Text = "고통이 분출을 기다리고 있습니다…… 「성심」이 그 출구가 될지도 모릅니다."
  },
  LanguageConfig_Monster_Probe_Tips_CN = {
    Text = "남은 손패가 많을수록 적은 더 많은 임시 반격을 얻습니다!"
  },
  LanguageConfig_Monster_RMQ_SideDia1_CN = {
    Text = "등불을 든 자가 나와 함께하노니!"
  },
  LanguageConfig_Monster_RMQ_SideDia2_CN = {
    Text = "나는 불순한 자들을 찢어낼 것이다!"
  },
  LanguageConfig_Monster_RMQ_SideDia3_CN = {
    Text = "조심하세요! 이번 턴 카드를 사용하면 적의 스킬이 강화되며, 카드를 1장 사용할 때마다 강화 효과가 변경됩니다."
  },
  LanguageConfig_Monster_RMQ_SideDia4_CN = {
    Text = "나는… 새로운 세계로… 나아갈 것이다…"
  },
  LanguageConfig_Monster_RamonoPlus_Bubble1_CN = {
    Text = "인과가 이 순간 닫힌다, 너의 어제를 맞이하라."
  },
  LanguageConfig_Monster_RamonoPlus_Bubble2_CN = {
    Text = "검끝에 수만 가지 윤회가 실타래려 있다, 너는 도망칠 곳이 없다!"
  },
  LanguageConfig_Monster_RamonoPlus_Tips1_CN = {
    Text = "열쇠령을 사용하면 「각자」가 회환을 축적합니다. 남용하지 마세요!"
  },
  LanguageConfig_Monster_RamonoPlus_Tips2_CN = {
    Text = "「각자」가 여러 장의 카드를 예지했습니다. 사용하면 적에게 회환을 제공하니, 버리기를 시도하세요."
  },
  LanguageConfig_Monster_S0103_1_CN = {
    Text = "차원 균열로 인해 당신은 힘의 일부를 잃었습니다...…"
  },
  LanguageConfig_Monster_S0103_2_CN = {
    Text = "차원 균열로부터의 공격은 전류로 가득 차 있습니다..."
  },
  LanguageConfig_Monster_S0202_1_CN = {
    Text = "그르르… (이를 가는 소리)…"
  },
  LanguageConfig_Monster_S0203_1_CN = {
    Text = "서쪽 구역에서 온 친구, 작은 선물 하나 줄게. 받아!"
  },
  LanguageConfig_Monster_S0203_2_CN = {
    Text = "젠킨이 쥐 떼를 불러냈습니다… 그녀를 공격하면 쥐 떼가 더욱 분노할 거예요."
  },
  LanguageConfig_Monster_S0203_3_CN = {
    Text = "머리가 어지러워… 공격을 받아내기가 힘들어…"
  },
  LanguageConfig_Monster_S0302_1_CN = {
    Text = "피의 초월 의식으로 인해 매 턴마다 강화됩니다…!"
  },
  LanguageConfig_Monster_S0303_1_CN = {
    Text = "「계시를 듣는 자」가 모든 적을 강화했습니다!"
  },
  LanguageConfig_Monster_S0303_2_CN = {
    Text = "「고집적인 정열」이 모든 적을 강화했습니다!"
  },
  LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia1_CN = {
    Text = "조심하세요! 적의 차원 에너지가 극한에 달했습니다! 이번 턴 차원 사슬이 3번 발동됩니다! 신중하게 공격하세요!"
  },
  LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia2_CN = {
    Text = "「살아남기 위해」가 모든 적을 강화합니다!"
  },
  LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia3_CN = {
    Text = "적 주변을 증오로 가득 찬 차원의 사슬이 둘러싸고 있어, 처음 공격하는 깨어남체를 봉쇄합니다!"
  },
  LanguageConfig_Monster_S2B0002_Name1_CN = {
    Text = "「우주@2 투영」"
  },
  LanguageConfig_Monster_SeaWandererBoss_bubble_01_CN = {
    Text = "나는 부패의 파도 속에서 피어나... 주를 따르며... 먹어치운다!"
  },
  LanguageConfig_Monster_SeaWandererBoss_bubble_02_CN = {
    Text = "주를 경청하라... 주의 심판을 받아들여라...!"
  },
  LanguageConfig_Monster_SeaWandererBoss_tips_01_CN = {
    Text = "도어세인이 「몽염의 장막」 마법진을 준비하고 있습니다. 최대한 많은 피해를 방어막으로 막아내어 그를 지키세요!"
  },
  LanguageConfig_Monster_SeaWandererBoss_tips_02_CN = {
    Text = "적의 형태가 불안정합니다. HP 막대를 붕괴시킬 때마다 적의 공격성을 낮출 수 있습니다!"
  },
  LanguageConfig_Monster_SeaWandererBoss_tips_03_CN = {
    Text = "카드에 부여된 「도해자의 광란」에 주의하세요! 사용하거나 버릴 때 도해자 분열체가 나타납니다!"
  },
  LanguageConfig_Monster_Seamonsteronslaught_Bubble_CN = {
    Text = "「나의 신의 이름은 모독당할 수 없다!」"
  },
  LanguageConfig_Monster_Snakerend_Tips_CN = {
    Text = "남은 손패가 적을수록 적의 공격이 강해집니다!"
  },
  LanguageConfig_Monster_TDJZ_1_CN = {
    Text = "「출혈」 상태가 적용되었습니다. 치유를 통해 해제할 수 있습니다."
  },
  LanguageConfig_Monster_TDJZ_2_CN = {
    Text = "「기도」 상태에서는 공격 횟수가 크게 증가하며, 피해를 주어 감소시킬 수 있습니다."
  },
  LanguageConfig_Monster_Tinct_Bubble1_CN = {
    Text = "또 당신을 잃게 되는 건가요, 누나……"
  },
  LanguageConfig_Monster_Tinct_Bubble2_CN = {
    Text = "노래 소리가 온 세상에 울려 퍼지면, 당신은 들을 수 있나요, 누나……"
  },
  LanguageConfig_Monster_Tinct_Tips1_CN = {
    Text = "팅크트의 환광은 “느림”을 발생시킵니다... 가능한 한 손에 있는 보존 카드를 사용하세요!"
  },
  LanguageConfig_Monster_Tinct_Tips2_CN = {
    Text = "손패는 더 이상 자동으로 폐기되지 않으므로, 느림 카드를 반드시 제때 처리하세요!"
  },
  LanguageConfig_Monster_TwistedFate1_CN = {
    Text = "@2을(를) 파괴하라! @3을(를) 삼켜라!!!"
  },
  LanguageConfig_Monster_TwistedFate2_CN = {
    Text = "광기 폭발은 적의 의도를 변경하고 강화시킵니다. 주의하세요!"
  },
  LanguageConfig_Monster_WDZZ_1_CN = {
    Text = "깨어남체의 「광기 폭발」이 이번 턴 동안 봉인됩니다."
  },
  LanguageConfig_Monster_XL_1_CN = {
    Text = "적의 「힘」이 크게 강화되었습니다. 조심하세요!"
  },
  LanguageConfig_Monster_Z0001_SideDia1_CN = {
    Text = "오늘은 어떤 소동을 피워볼까..."
  },
  LanguageConfig_Monster_Z0001_SideDia2_CN = {
    Text = "신사다운 결투를 해보자고!"
  },
  LanguageConfig_Monster_Z0001_SideDia3_CN = {
    Text = "어라, 은심이 모자에서 떨어졌어..."
  },
  LanguageConfig_Monster_Z0001_SideDia4_CN = {
    Text = "야옹ㅡ 신사를 이렇게 대하다니!"
  },
  LanguageConfig_Monster_Z0001_SideDia5_CN = {
    Text = "함께 열정적인 밤을 보내자!"
  },
  LanguageConfig_Monster_shuilian1_CN = {
    Text = "제발 다가오지 마세요……"
  },
  LanguageConfig_Monster_shuilian2_CN = {
    Text = "난 너희를 해치고 싶지 않아……"
  },
  LanguageConfig_Monster_shuilian3_CN = {
    Text = "더 나아가면 안 돼요……"
  },
  LanguageConfig_Monster_tawil_Bubble0_CN = {Text = "3..."},
  LanguageConfig_Monster_tawil_Bubble1_CN = {Text = "2..."},
  LanguageConfig_Monster_tawil_Bubble2_CN = {Text = "1..."},
  LanguageConfig_Monster_tawil_Bubble3_CN = {
    Text = "당신은 무엇을 열쇠로 삼아 최종의 문살을 두드릴 것인가?"
  },
  LanguageConfig_Monster_tawil_Bubble4_CN = {
    Text = "나는 알고 있습니다. 나는 증언합니다. 나는…… 여기 강림합니다."
  },
  LanguageConfig_Monster_tawil_Bubble5_CN = {
    Text = "궁극의 문이 열릴 것입니다… 최후의 “답”이 곧 드러날 것입니다."
  },
  LanguageConfig_Monster_tawil_Bubble6_CN = {
    Text = "만물이 하나에서 시작된다. 만물은 결국 하나로 돌아간다."
  },
  LanguageConfig_Monster_tawil_Tips1_CN = {
    Text = "매번 명령 카드를 사용할 때마다 적의 공격이 강화됩니다. 신중하게 행동하세요!"
  },
  LanguageConfig_Monster_tawil_Tips2_CN = {
    Text = "가능한 한 적의 피해를 막아 “회귀 역설”의 영향을 피하세요!"
  },
  LanguageConfig_Monster_xiluo0_CN = {
    Text = "듣거라, 복수자의 분노를!"
  },
  LanguageConfig_Monster_xiluo1_CN = {
    Text = "성녀로서의 삶은 끝났네."
  },
  LanguageConfig_Monster_xiluo2_CN = {
    Text = "그건 용납되지 않는 자비인가?"
  },
  LanguageConfig_Monster_xiluo3_CN = {
    Text = "나는 한때 당신의 소중한 존재였어…"
  },
  LanguageConfig_MonthCardLeftDaysText_CN = {
    Text = "{s1}일 남음"
  },
  LanguageConfig_MonthCardRuleText_CN = {
    Text = "<Title:[월상 관측 소개]>\n· 월상 관측 구매 시, 즉시 「은심」× 300과 30일간의 월상 관측 이용권을 획득합니다.\n· 월상 관측 유효 기간 동안 매일 로그인 시 「은심」× 200을 획득할 수 있습니다. (매일 오전 10시 갱신, 한국 시간 기준)\n\n\n<Title:[주의사항]>\n· 월상 관측 잔여 유효 기간이 150일 이하일 때 추가 구매 시, 유효 기간이 연장됩니다.\n· 월상 관측 유효 기간 중 로그인하지 않아 수령하지 못한 「은심」은 반환되지 않습니다."
  },
  LanguageConfig_MoppingUp_lock_Warn_CN = {
    Text = "조사 등급 2 달성 시 빠른 조사 해금"
  },
  LanguageConfig_MultiLifeReduceStar_CN = {
    Text = "클리어 평가가 {s1}성으로 내려갑니다"
  },
  LanguageConfig_MultiSelectBox_BuyConfirmText_CN = {
    Text = "다음 물품 구매를 확인하시겠습니까?"
  },
  LanguageConfig_MultiSelectBox_FixItemTitle_CN = {
    Text = "잠금 아이템"
  },
  LanguageConfig_MultiSelectBox_SelectItemText_CN = {
    Text = "선물 패키지 내용을 선택하세요"
  },
  LanguageConfig_MultiSelectBox_SelectItemTitle_CN = {
    Text = "자유 아이템 선택"
  },
  LanguageConfig_MustBattle_CN = {
    Text = "필수 출전"
  },
  LanguageConfig_NFYMainDia1_CN = {
    Text = "죄송하지만, 여러분을 막아야겠습니다."
  },
  LanguageConfig_NFYMainDia2_CN = {
    Text = "프랜시스 부인… 저는… 아직 쓰러질 수 없습니다."
  },
  LanguageConfig_NameChangeTips_CN = {
    Text = "수정 후, {s1}시간 동안 다시 수정할 수 없습니다"
  },
  LanguageConfig_NeedToActivateTheFrontPotency_CN = {
    Text = "이전 계령을 활성화해야 합니다"
  },
  LanguageConfig_NetBlockMaskTips_CN = {
    Text = "네트워크 연결 중, 잠시만 기다려 주세요"
  },
  LanguageConfig_NewLevelUp_alllClean_CN = {Text = "리셋"},
  LanguageConfig_NewLevelUp_autoSet_CN = {
    Text = "자동 삽입"
  },
  LanguageConfig_NewPreOrderPurchaseCountdownTips_CN = {
    Text = "{s1} 이내에 구매 시 기간 한정 보상 수령 가능"
  },
  LanguageConfig_NewPreOrderPurchaseTobeClaimed_CN = {
    Text = "특가 항목은 {s1}후 사라지며, 구매 후 즉시 수령 가능"
  },
  LanguageConfig_NextRefineLevelEffect_CN = {
    Text = "중첩 후 효과"
  },
  LanguageConfig_NextStep_CN = {
    Text = "다음 단계"
  },
  LanguageConfig_NoAwakerAwaked_CN = {
    Text = "미깨어남 깨어남체"
  },
  LanguageConfig_NoCounterTagAwaker_CN = {
    Text = "현재 특공 깨어남체가 없습니다"
  },
  LanguageConfig_Nonimagery_1_1_1_1_CN = {Text = "눈물"},
  LanguageConfig_Nonimagery_1_1_1_2_CN = {Text = "시선"},
  LanguageConfig_Nonimagery_1_1_1_3_CN = {Text = "지나다"},
  LanguageConfig_Nonimagery_1_2_1_1_CN = {Text = "그러나"},
  LanguageConfig_Nonimagery_1_2_1_2_CN = {Text = "또는"},
  LanguageConfig_Nonimagery_1_2_1_3_CN = {Text = "여전히"},
  LanguageConfig_Nonimagery_1_3_1_1_CN = {
    Text = "휘두르다"
  },
  LanguageConfig_Nonimagery_1_3_1_2_CN = {
    Text = "뛰어오르다"
  },
  LanguageConfig_Nonimagery_1_3_1_3_CN = {Text = "견디다"},
  LanguageConfig_Nonimagery_1_4_1_1_CN = {Text = "까지"},
  LanguageConfig_Nonimagery_1_4_1_2_CN = {Text = "반드시"},
  LanguageConfig_Nonimagery_1_4_1_3_CN = {Text = "위한"},
  LanguageConfig_NormalGamePassport_CN = {
    Text = "일반 기행"
  },
  LanguageConfig_NotOwned_CN = {Text = "미보유"},
  LanguageConfig_OffSell_CN = {
    Text = "판매 종료"
  },
  LanguageConfig_OpenExpression_PVP_CN = {
    Text = "상호작용 허용"
  },
  LanguageConfig_Option_RankListAchievementCount_CN = {
    Text = "업적 달성 수"
  },
  LanguageConfig_Option_RankListAssistanceCount_CN = {
    Text = "지원 횟수"
  },
  LanguageConfig_Option_RankListCollectionNum_CN = {
    Text = "전시관 보유 수"
  },
  LanguageConfig_Option_RankListFollowerNum_CN = {
    Text = "팔로워 수"
  },
  LanguageConfig_Option_RankListGetlikeCount_CN = {
    Text = "받은 좋아요 수"
  },
  LanguageConfig_Option_RankListHomologyRate_CN = {
    Text = "총 동조율 레벨"
  },
  LanguageConfig_Option_RankListLikeCount_CN = {
    Text = "보낸 좋아요 수"
  },
  LanguageConfig_Option_RankListLoginDays_CN = {
    Text = "로그인 일수"
  },
  LanguageConfig_Option_RankListPlayerLevel_CN = {
    Text = "수호자 조사 등급"
  },
  LanguageConfig_OrangeEnchantConfigTypeName_CN = {
    Text = "<OrangeRelic:고급 각인>"
  },
  LanguageConfig_OrangeRelicTypeName_CN = {
    Text = "<OrangeRelic:황금 유물>"
  },
  LanguageConfig_OtherAchievement_CN = {
    Text = "업적/기타 업적"
  },
  LanguageConfig_OverLimitUtlSkill_CN = {
    Text = "<OverLimitUtlSkillKeywords:초월 폭발>"
  },
  LanguageConfig_Overload_CN = {
    Text = "행동력 초과!"
  },
  LanguageConfig_OwnedCount_CN = {
    Text = "보유 중: {s1}"
  },
  LanguageConfig_Owned_CN = {Text = "보유 중"},
  LanguageConfig_PVETeamShareCode_CN = {
    Text = "조사 작전——편성 파티 공유\n수호자: {1}({2}) 파티 이름: {3}\n\n{10}, {21}, {23}, {25}\n{30}, {41}, {43}, {45}\n{50}, {61}, {63}, {65}\n{70}, {81}, {83}, {85}\n{4}\n\n{0}"
  },
  LanguageConfig_PVPAttentionBtnUnClickableStateTips_CN = {
    Text = "이미 상대방을 팔로우했습니다."
  },
  LanguageConfig_PVPAwakerTrain_CN = {
    Text = "깨어남체 체험"
  },
  LanguageConfig_PVPBPLockTxt_CN = {
    Text = "핵심 과제를 해제하면 이번 시즌의 모든 카드를 사용할 수 있습니다."
  },
  LanguageConfig_PVPBPUnLockTxt_CN = {
    Text = "본 시즌 한정 개방 중"
  },
  LanguageConfig_PVPBattlePerformance_CN = {
    Text = "전투 성과"
  },
  LanguageConfig_PVPBattle_Tips_NumberOfCards_CN = {
    Text = "현재 총 {s1}장의 손패를 보유 중입니다.\n손패의 한도는 기본적으로 10장입니다.\n보유한 손패가 한도에 도달하면, 더 이상 손패를 획득할 수 없습니다."
  },
  LanguageConfig_PVPCollectFilterTypeName_All_CN = {Text = "전체"},
  LanguageConfig_PVPCollectFilterTypeName_Blood_CN = {Text = "혈육"},
  LanguageConfig_PVPCollectFilterTypeName_Chaos_CN = {Text = "혼돈"},
  LanguageConfig_PVPCollectFilterTypeName_Dimension_CN = {Text = "초차원"},
  LanguageConfig_PVPCollectFilterTypeName_KeeperSkill_CN = {Text = "은열쇠"},
  LanguageConfig_PVPCollectFilterTypeName_Ocean_CN = {Text = "심해"},
  LanguageConfig_PVPCollectFilterTypeName_Weapon_CN = {Text = "명륜"},
  LanguageConfig_PVPEmailRewardrTxt_CN = {
    Text = "이전 시즌의 랭킹 보상을 수령하지 않으셨기에, 우편을 통해 발송되었습니다. 확인하고 수령해주세요."
  },
  LanguageConfig_PVPFailTips_CN = {
    Text = "낙심하지 마세요! 다시 시도하면 다음에는 더 강해질 겁니다."
  },
  LanguageConfig_PVPFirstWinBonus_CN = {
    Text = "첫 승리 보너스"
  },
  LanguageConfig_PVPGoodBtnUnClickableStateTips_CN = {
    Text = "이미 상대방에게 좋아요를 보냈습니다."
  },
  LanguageConfig_PVPInstructions_CN = {
    Text = "<Title:[페이즈 체스]>\n페이즈 체스는 《Morimens》의 추가 모드입니다.\n각 시즌마다 모든 카드와 전반적인 룰이 크게 개편될 수 있으며, 이를 통해 보다 균형 있고 재미있는 환경을 제공합니다. 따라서 페이즈 체스 해금을 위해 자원을 투자할 때는 신중하게 판단하시기 바랍니다.\n페이즈 체스는 1대1 대전 모드로, 각자 준비한 파티를 사용해 매칭이 이루어집니다. 비슷한 실타래력의 상대와 우선적으로 매칭됩니다.\n「페이즈 체스」 및 「환몽 심잠」에서 승리하거나, 「페이즈 체스」에서 패배하더라도 끝까지 싸우면 수호자 경험치를 얻을 수 있습니다. 두 모드가 경험치 획득 한도를 공유하며, 하루 최대 {s2}까지 획득할 수 있습니다. 오늘은 이미 {s1}의 경험치를 얻었습니다.\n【주간 시련】\n매주 「환몽 심연」과 「페이즈 체」에서의 총 승리 횟수가 1회, 3회, 5회에 도달하면 푸짐한 보상을 획득할 수 있습니다.\n주간 시련 진행도와 보상은 매주 월요일에 초기화됩니다.\n【점수 및 랭킹】\n점수 규칙 : 초기 점수는 0점이며, 매칭 대전을 통해 점수를 획득할 수 있습니다.\n점수 변동: 양측 점수가 동일할 때, 승자는 총점의 5%를 획득하고 패자는 같은 수치를 잃습니다.\n초보자 보호: 점수가 1500 미만일 경우, 승리 시 더 많은 점수를 얻고 패배 시 잃는 점수가 줄어듭니다.\n강자 도전 : 강한 상대를 이기면 더 많은 점수를 얻고, 강한 상대에게 패배하면 잃는 점수가 줄어듭니다. 약한 상대를 이길 경우 얻는 점수는 적습니다.\n랭킹 등록 조건 : 하루에 한 판이라도 참가하면 당일 랭킹에 등록됩니다. 당일 한 판 이상 승리하면 다음 날 보상을 받을 수 있습니다.\n결산 보상 : 「환몽 심잠」과 마찬가지로, 당일 점수 순위에 따라 칭호를 부여받고 다음 날 융식의 구슬과 장미 금권을 수령할 수 있습니다. 두 모드에 모두 참여했을 경우, 두 보상 중 더 높은 쪽 기준으로 결산됩니다. 미션 대리 역시 같은 방식으로 적용됩니다.\n<Title:[시즌 갱신]>\n시즌 초기화 : 일반적으로 시즌은 28일마다 초기화되며, 초기화 시 1000점을 초과한 점수는 절반으로 감소합니다.\n시즌 랭킹 : 시즌 중 달성한 최고 점수를 기준으로 순위가 산정되며, 최소 한 판 이상 참여해야만 유효합니다."
  },
  LanguageConfig_PVPMatchDefeat_CN = {
    Text = "대전 패배"
  },
  LanguageConfig_PVPMatchVictory_CN = {
    Text = "대전 승리"
  },
  LanguageConfig_PVPOpeningVoiceUnlockDesc_CN = {
    Text = "상위 대결에서 이 대화를 트리거하면 잠금 해제됩니다"
  },
  LanguageConfig_PVPRankRewardCountdown_CN = {
    Text = "이번 시즌 남은 시간: {s1}일 {s2}시간"
  },
  LanguageConfig_PVPRankingRuleDesc_CN = {
    Text = "<Title:[점수 랭킹]>\n·[프리셋 모드]와 [드래프트 모드]는 각각 독립된 시즌과 시즌 랭킹을 가지며, 시즌 랭킹 보상은 매 시즌 종료 시 정산됩니다.\n·현재 시즌 내 한 경기에 참여하면 해당 모드의 시즌 랭킹에 등록되며, 시즌 내 역대 최고 점수를 기준으로 순위가 산정됩니다. 현재 시즌 내 한 경기 승리 시 시즌 종료 시점에 현재 시즌 랭킹에 따라 보상이 정산됩니다.\n<Title:[랭킹 비율]>\n·대국 칭호는 참여자 점수 순위에 따라 배정됩니다. 비율은 다음과 같습니다:\n     ·위상 전설: 상위 2%\n     ·위상의 지배자: 2%~10%\n     ·페이즈 마스터: 10%~25%\n     ·페이즈 엘리트: 25%~50%\n     ·체스 견습: 50%~75%\n     ·체스 초심자: 75% 이후\n·다른 수호자와 점수가 동일한 경우, 랭킹 진입 순서로 정렬됩니다. 단, 대국 칭호와 보상은 해당 점수에서 가장 높은 순위를 기준으로 지급됩니다."
  },
  LanguageConfig_PVPRankingRuleTitle_CN = {
    Text = "랭킹 규칙"
  },
  LanguageConfig_PVPRecordTime_Day_CN = {
    Text = "{s1}일 전"
  },
  LanguageConfig_PVPRecordTime_Hour_CN = {
    Text = "{s1}시간 전"
  },
  LanguageConfig_PVPRecordTime_Minute_CN = {
    Text = "{s1}분 전"
  },
  LanguageConfig_PVPSeasonBonus_CN = {
    Text = "시즌 보너스"
  },
  LanguageConfig_PVPSeasonCountdown_CN = {
    Text = "{s1}일 {s2}시간"
  },
  LanguageConfig_PVPSettleAccelerateField_CN = {
    Text = "수호자 경험치 부스트"
  },
  LanguageConfig_PVPTargetErrorTips_CN = {
    Text = "스킬 타겟 오류, 다시 선택해 주세요."
  },
  LanguageConfig_PVPTeamShareCode_CN = {
    Text = "페이즈 대결——편대 공유\n수호자:{1}({2})\n\n편대 이름:{3}\n{12},{7},{6},{5},{4}\n{13},{11},{10},{9},{8}\n\n{0}"
  },
  LanguageConfig_PVPTraning_ChooseKeeperSkill_CN = {
    Text = "은열쇠 1개를 선택하세요"
  },
  LanguageConfig_PVPTraning_ChooseWeapon_CN = {
    Text = "명륜 1개를 선택하세요"
  },
  LanguageConfig_PVPTraning_EnemyName_CN = {
    Text = "미사그 대학 고양이"
  },
  LanguageConfig_PVPTraning_ResetCooldown_CN = {
    Text = "초기화 기능 쿨다운 중, 잠시 후 다시 시도해주세요."
  },
  LanguageConfig_PVPWinningStreak_CN = {
    Text = "연속 승리"
  },
  LanguageConfig_PVP_Opponent_Exited_CN = {
    Text = "상대방이 종료했습니다"
  },
  LanguageConfig_PVPandDailyChallengeExpTips_CN = {
    Text = "「환몽 심잠」 및 「페이즈 체스」를 통해 수호자 경험치를 획득할 수 있으며, 매일 최대 경험치 {s1}을(를) 획득할 수 있습니다. 오늘 이미 경험치 {s2} 만큼 획득하셨습니다."
  },
  LanguageConfig_PassportAdvancedPurchased_Txt_CN = {
    Text = "고급 과제를 구매하셨습니다"
  },
  LanguageConfig_PassportAdvanced_Txt_CN = {
    Text = "해제 후 즉시 「은심」 × <color=#5EF2FF><size=32>680</size></color>을(를) 획득할 수 있습니다."
  },
  LanguageConfig_PassportHoistDoubleUpgrade_Txt_CN = {
    Text = "과제를 업그레이드하면 즉시 「은심」 × <color=#5EF2FF><size=32>390</size></color>을(를) 획득하고, 과제 등급을 <color=#5EF2FF><size=32>20</size>레벨</color> 올릴 수 있습니다."
  },
  LanguageConfig_PassportHoistDouble_Txt_CN = {
    Text = "해제 후 즉시 「은심」 × <color=#5EF2FF><size=32>1070</size></color>을(를) 획득하고, 과제 등급을 <color=#5EF2FF><size=32>20</size>레벨</color> 올릴 수 있습니다."
  },
  LanguageConfig_PassportHoistPurchased_Txt_CN = {
    Text = "핵심 과제를 구매하셨습니다"
  },
  LanguageConfig_PassportHoistUpgrade_Txt_CN = {
    Text = "과제를 업그레이드하면 즉시 「은심」 × <color=#5EF2FF><size=32>780</size></color>을(를) 획득하고, 과제 등급을 <color=#5EF2FF><size=32>10</size>레벨</color> 올릴 수 있습니다."
  },
  LanguageConfig_PassportHoist_Txt_CN = {
    Text = "해제 후 즉시 「은심」 × <color=#5EF2FF><size=32>1460</size></color>을(를) 획득하고, 과제 등급을 <color=#5EF2FF><size=32>10</size>레벨</color> 올릴 수 있습니다."
  },
  LanguageConfig_PasswordBattle1_CN = {
    Text = "사전 편성 모드"
  },
  LanguageConfig_PasswordBattle2_CN = {
    Text = "순차 선택 모드"
  },
  LanguageConfig_PasswordBattlePasswordPrompt_CN = {
    Text = "6자리 비밀번호를 입력하세요."
  },
  LanguageConfig_PasswordBattleQueueButton_CN = {Text = "대기 중"},
  LanguageConfig_PasswordBattleRuleTips_CN = {
    Text = "· 계약 생성: 수호자가 계약을 생성할 때 먼저 하나의 대결 모드를 선택해야 합니다. 사전 구성 모드와 순환 선택 모드로 나뉩니다. 생성 후, 수호자는 여섯 자리 숫자의 위상 값을 얻게 되며, 다른 수호자들은 해당 위상 값을 통해 직접 매칭할 수 있습니다. 일정 시간 내에 다른 수호자가 참여하지 않으면 계약이 취소됩니다. \n · 계약 참여: 수호자는 획득한 위상 값을 입력하여 해당 계약에 들어가 대결을 진행할 수 있습니다."
  },
  LanguageConfig_PasswordBattle_CN = {
    Text = "비공개 대전"
  },
  LanguageConfig_PasswordBattle_FriendGame_CN = {
    Text = "우정 경기"
  },
  LanguageConfig_PermanentActivityRuleContent_CN = {
    Text = "<Title:기억의 회랑>\n· 「기억의 회랑」 표시가 있는 이벤트는 이벤트 기간 종료 후 「기억의 회랑」에 수록되어, 「기억의 회랑」을 통해 해당 플레이 및 스토리를 계속 체험하실타래 수 있습니다.\n<Title:수록 규칙>\n· 「기억의 회랑」 표시가 있는 이벤트에는 풍성한 한정 보상이 존재하며, 이벤트 기간 종료 후에는 한정 보상을 더 이상 수령하실타래 수 없으니, 수호자 님께서는 한정 보상을 제때에 수령해 주세요.\n· 이벤트가 「기억의 회랑」에 수록된 후에는 이전 진행도가 자동으로 보존되어 수호자 님께서 계속 체험하실타래 수 있습니다."
  },
  LanguageConfig_PermanentActivityRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_PermanentActivityTitle_CN = {
    Text = "기억의 회랑"
  },
  LanguageConfig_PhiloStone_CN = {
    Text = "검은 인장"
  },
  LanguageConfig_PhiloStone_Desc_CN = {
    Text = "융식이 갈망하는 신비로운 인장입니다, 동일한 가치의 아이템과 교환할 수 있습니다."
  },
  LanguageConfig_PickCosmeticsAllEmojiGot_CN = {
    Text = "목록에 있는 모든 대전 감정 표현을 획득하셨습니다"
  },
  LanguageConfig_PickCosmeticsAllPlayerAvatarsGot_CN = {
    Text = "목록에 있는 모든 프로필 아이콘을 획득하셨습니다"
  },
  LanguageConfig_PlayerExpRateTxt_CN = {
    Text = "경험치 부스트: {s1}%"
  },
  LanguageConfig_PlayerExpRuleContent_CN = {
    Text = "<Title:지고의 찬양>\n1. 「지식의 선물」 이벤트에서 각 미션를 완료하면 「지고의 찬양」 효과를 획득할 수 있으며, 수호자 경험치 획득량이 최대 100%까지 가속됩니다. 여러 「지고의 찬양」 효과가 동시에 존재할 경우, 가장 높은 가속 효과가 적용됩니다.\n2. 더 높은 단계의 「지고의 찬양」 효과를 해금하거나 획득하면, 가속 비율과 현재 가속 가능한 수호자 경험치 총량에 따라 즉시 추가 수호자 경험치를 얻습니다.\n3. 「지고의 찬양」 해금 후, 수호자가 경험치를 얻을 때마다 해당 가속 비율에 맞는 추가 수호자 경험치를 획득합니다.\n4. 주의: 「지고의 찬양」으로 얻는 추가 수호자 경험치는 가속 가능 경험치 총량에 포함되지 않습니다.\n5. 현재 가속 가능한 수호자 경험치 총량: {s1}.\n6. 가속으로 이미 획득한 추가 수호자 경험치: {s2} ({s3}%)."
  },
  LanguageConfig_PlayerExpRuleTitle_CN = {
    Text = "부스트 설명"
  },
  LanguageConfig_PlayerLevelTaskLabel_CN = {
    Text = "성장 기록"
  },
  LanguageConfig_PlayerLv_CN = {
    Text = "조사 등급"
  },
  LanguageConfig_PlayerNotLoggedIn_CN = {
    Text = "플레이어 - 로그인하지 않음"
  },
  LanguageConfig_PlusGamePassport_CN = {
    Text = "고급 기행"
  },
  LanguageConfig_Poem_CN = {Text = "시편"},
  LanguageConfig_PoetryFormatGroup_1_CN = {
    Text = "얼룩진 {s1}은(는) 오랫동안 기다린다.\n@2는 @2의 찌릿함 속에 머무르고,\n@2의 방에서 {s2}이(가) 타오르는 소리가 들리면, {s3}이(가) 정원을 가득 채운다."
  },
  LanguageConfig_PoetryFormatGroup_2_CN = {
    Text = "{s1} 곁에서, 한 @2의 소멸 속, 추격하는 춤곡 속에서 {s2}이(가) 막을 내리기 시작한다. @2, 들어라: 오늘 밤 나는 {s3}와(과) 함께 춤추리라."
  },
  LanguageConfig_PoetryFormatGroup_3_CN = {
    Text = "{s1}와(과) 술을 나누며, @2의 잔을 들어 올린다. 창밖의 @2는 {s2}의 것, 그것이 바로 @2의 시공간이다. @2의 밤하늘, @2의 불빛 속에서, 생명은 {s3}에게 자리를 내준다."
  },
  LanguageConfig_PoetryFormatGroup_4_CN = {
    Text = "한 장의 잎이 @2를 {s1}에게 빌려준다. 이것이 @2의 허무: {s2}와(과) @2, 멀리서 바라볼 뿐. 오직 떨어질 때, {s3}은(는) 서로를 껴안는다."
  },
  LanguageConfig_PoetryFormatGroup_5_CN = {
    Text = "가시를 넘어, {s1}와(과) @2가 피어난다. 영원의 {s2}이(가) @2로부터 떨어지고, @2 속으로, {s3}의 외로운 품으로 떨어진다."
  },
  LanguageConfig_PoetryFormatGroup_6_CN = {
    Text = "심연 속 {s1}, @2의 손아귀에서 피어나고, @2의 꿈 속 @2여, 나는 한때 @2의 {s2}였다. {s3}이(가) 떨어지는 @2에서, 나는 너의 황량한 마음을 기억하리라."
  },
  LanguageConfig_PontosHuoDong_Tips1_CN = {
    Text = "「방호」 또는 「사냥」 선택"
  },
  LanguageConfig_PoolGroupTitle_10_CN = {
    Text = "별들과의 만남"
  },
  LanguageConfig_PoolGroupTitle_11_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_12_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_13_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_14_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_15_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_16_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_17_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_18_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_19_CN = {
    Text = "시계열 외 동행"
  },
  LanguageConfig_PoolGroupTitle_1_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_20_CN = {
    Text = "삼상 형생·그 두 번째"
  },
  LanguageConfig_PoolGroupTitle_21_CN = {
    Text = "인과의 보육원·그 두 번째"
  },
  LanguageConfig_PoolGroupTitle_22_CN = {
    Text = "군성의 만개"
  },
  LanguageConfig_PoolGroupTitle_23_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_24_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_25_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_26_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_27_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_28_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_29_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_2_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_30_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_31_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_32_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_33_CN = {
    Text = "기억 끝에 닿은 빛"
  },
  LanguageConfig_PoolGroupTitle_34_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_35_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_36_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_37_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_38_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_39_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_3_CN = {
    Text = "기억이 잊히기 전에"
  },
  LanguageConfig_PoolGroupTitle_40_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_41_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_42_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_43_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_44_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_45_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_46_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_47_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_48_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_49_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_4_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_50_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_51_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_52_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_53_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_5_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_6_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_7_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PoolGroupTitle_8_CN = {
    Text = "삼상 균형"
  },
  LanguageConfig_PoolGroupTitle_9_CN = {
    Text = "인과 묘목"
  },
  LanguageConfig_PotencyComingSoon_CN = {
    Text = "해당 깨어남체의 초월 폭발은 아직 개방되지 않았습니다."
  },
  LanguageConfig_PotencyNumberOfLayers_CN = {Text = "{s1}층"},
  LanguageConfig_PotencyPopupTitle_CN = {
    Text = "인격 심화"
  },
  LanguageConfig_PotencyUnlockFormat_CN = {
    Text = "인격 심화{s1} 해금"
  },
  LanguageConfig_Potency_LevelUp_Success_CN = {
    Text = "계령 상승"
  },
  LanguageConfig_PreOrderBeforePurchaseTips_CN = {
    Text = "구매 후, 시간에 걸쳐 모든 보상 수령 가능"
  },
  LanguageConfig_PreOrderNeedWaitTobeClaimed_CN = {
    Text = "{s1} 후 수령 가능"
  },
  LanguageConfig_PreOrderNotPurchasedNeedWait_CN = {
    Text = "{s1} 구매하여 수령"
  },
  LanguageConfig_PreOrderNotPurchasedTobeClaimed_CN = {
    Text = "구매하여 수령"
  },
  LanguageConfig_PreOrderPurchaseCountdownTips_CN = {
    Text = "{s1} 이후 구매 불가"
  },
  LanguageConfig_PreOrderPurchasedTips_CN = {
    Text = "구매 완료!\n모든 보상을 시간에 걸쳐 수령할 수 있습니다."
  },
  LanguageConfig_PreOrderTobeClaimed_CN = {
    Text = "수령 가능"
  },
  LanguageConfig_PrerequisiteStagesRequired_CN = {
    Text = "선행 스테이지를 완료해야 합니다"
  },
  LanguageConfig_PreviewClose_CN = {Text = "닫기"},
  LanguageConfig_PrizeNum10_CN = {Text = "10등상"},
  LanguageConfig_PrizeNum1_CN = {Text = "1등상"},
  LanguageConfig_PrizeNum2_CN = {Text = "2등상"},
  LanguageConfig_PrizeNum3_CN = {Text = "3등상"},
  LanguageConfig_PrizeNum4_CN = {Text = "4등상"},
  LanguageConfig_PrizeNum5_CN = {Text = "5등상"},
  LanguageConfig_PrizeNum6_CN = {Text = "6등상"},
  LanguageConfig_PrizeNum7_CN = {Text = "7등상"},
  LanguageConfig_PrizeNum8_CN = {Text = "8등상"},
  LanguageConfig_PrizeNum9_CN = {Text = "9등상"},
  LanguageConfig_PromoteMethod_CN = {
    Text = "전투력 향상 제안"
  },
  LanguageConfig_PurpleRelicTypeName_CN = {
    Text = "<OrangeRelic:특수 유물>"
  },
  LanguageConfig_PvEReplayAddRoundsNum_CN = {
    Text = "추가·최종전 라운드 수"
  },
  LanguageConfig_PvEReplayCode_CN = {
    Text = "조사 작전-{3}——전투 재생\n수호자:{1}({2})\n\n{4},{5},{6},{17}\n{7},{8},{9},{18}\n{10},{11},{12},{19}\n{13},{14},{15},{20}\n{16}\n\n{0}"
  },
  LanguageConfig_PvEReplayDefeatTips_CN = {
    Text = "조사 실타래패, 재생 공유 불가."
  },
  LanguageConfig_PvEReplayRoundsNum_CN = {
    Text = "최종전 턴 수"
  },
  LanguageConfig_PvEReplayTabNullDesc_CN = {
    Text = "조사 작전 기록 없음"
  },
  LanguageConfig_PvPChallengeBtnText_CN = {Text = "도전"},
  LanguageConfig_PvPExitReplay_CN = {
    Text = "녹화 종료"
  },
  LanguageConfig_PvPGiveUp_CN = {Text = "기권"},
  LanguageConfig_PvPMatchingText_CN = {
    Text = "비슷한 실타래력의 상대방과 매칭 중입니다"
  },
  LanguageConfig_PvPMatchinging_CN = {
    Text = "{s1}명 중에서 실타래력이 비슷한 상대를 찾아 매칭 중입니다 {s2}"
  },
  LanguageConfig_PvPMoreGameBeCancelTips_CN = {
    Text = "상대방이 취소했습니다."
  },
  LanguageConfig_PvPMoreGameBeRefusedTips_CN = {
    Text = "상대방이 거절했습니다."
  },
  LanguageConfig_PvPMoreGameBtnActiveRefuseStateTips_CN = {
    Text = "이미 상대방의 요청을 거절했습니다."
  },
  LanguageConfig_PvPMoreGameBtnOverWinStateTips_CN = {
    Text = "2번 승리한 플레이어가 존재하여, 재대결을 진행할 수 없습니다."
  },
  LanguageConfig_PvPMoreGameBtnQuitStateTips_CN = {
    Text = "상대방이 대결을 종료했습니다."
  },
  LanguageConfig_PvPMoreGameBtnRefuseStateTips_CN = {
    Text = "상대방이 이미 요청을 거절했습니다."
  },
  LanguageConfig_PvPMoreGameTitle_CN = {Text = "재대결"},
  LanguageConfig_PvPMoreGame_CN = {Text = "재대결"},
  LanguageConfig_PvPPlayOrderFirst_CN = {Text = "선공"},
  LanguageConfig_PvPPlayOrderSecond_CN = {Text = "후공"},
  LanguageConfig_PvPReplayCode_CN = {
    Text = "#공유자:{1}({2})\n#\n#{3}\n#{12},{7},{6},{5},{4}\n#{13},{11},{10},{9},{8}\n#---------------VS--------------------\n#{14}\n#{23},{18},{17},{16},{15}\n#{24},{22},{21},{20},{19}\n#\n{0}\n#\n#이 정보를 클립보드에 복사한 후 게임으로 돌아가서 붙여넣어 재생해 주세요."
  },
  LanguageConfig_PvPReplayCode_Copy_CN = {
    Text = "대결이 클립보드에 복사되었습니다."
  },
  LanguageConfig_PvPReplayCode_ErrorPaste_CN = {
    Text = "클립보드에서 게임이 감지되지 않거나 게임이 만료되었습니다"
  },
  LanguageConfig_PvPReplayModeDisp1_CN = {
    Text = "사전 편성 모드"
  },
  LanguageConfig_PvPReplayModeDisp2_CN = {
    Text = "순차 선택 모드"
  },
  LanguageConfig_PvPReplayModeDisp3_CN = {
    Text = "비밀번호 미리 설정하기"
  },
  LanguageConfig_PvPReplayModeDisp4_CN = {
    Text = "비밀번호 선택"
  },
  LanguageConfig_PvPReplayModeDisp5_CN = {
    Text = "친선 사전 그룹"
  },
  LanguageConfig_PvPReplayModeDisp6_CN = {
    Text = "친선 선택"
  },
  LanguageConfig_PvPReplayTabNullDesc_CN = {
    Text = "페이즈 체스 기록 없음"
  },
  LanguageConfig_PvPReplay_CheckBot_CN = {
    Text = "로봇의 세부정보를 볼 수 없습니다"
  },
  LanguageConfig_PvPTeamBuildChallengeNotFullTips_CN = {
    Text = "편성을 완성해야 매칭을 시작할 수 있습니다."
  },
  LanguageConfig_PvPTeamBuildPanelSaveBtnText_CN = {Text = "배치"},
  LanguageConfig_PvPTeamMultiBuildTitle_CN = {
    Text = "파티 편집"
  },
  LanguageConfig_PvPTeamSingleBuildAwakerTitle_CN = {
    Text = "깨어남체 선택"
  },
  LanguageConfig_PvPTeamSingleBuildKeyTitle_CN = {
    Text = "은열쇠 카드 선택"
  },
  LanguageConfig_PvPTeamSingleBuildWeaponTitle_CN = {
    Text = "명륜 카드 선택"
  },
  LanguageConfig_PvPTrainGiveUp_CN = {Text = "종료"},
  LanguageConfig_PvPWinCount_CN = {Text = "{s1}승"},
  LanguageConfig_PvpBattleRewardRankBonus_CN = {
    Text = "점수 추가"
  },
  LanguageConfig_PvpCollectCommentBtnMine_CN = {
    Text = "내 코멘트"
  },
  LanguageConfig_PvpCollectCommentBtnPublish_CN = {
    Text = "코멘트 게시"
  },
  LanguageConfig_PvpCollectCommentEditLabel_CN = {
    Text = "최대 {s1}자까지 입력 가능하며, 비속어 혹은 민감한 단어는 입력할 수 없습니다."
  },
  LanguageConfig_PvpCollectCommentEditTimeOutTips_CN = {
    Text = "30일 이상된 코멘트는 수정할 수 없습니다"
  },
  LanguageConfig_PvpCollectCommentLikeForbid_CN = {
    Text = "내 코멘트에는 좋아요를 할 수 없습니다"
  },
  LanguageConfig_PvpCollectCommentPublishTime_CN = {
    Text = "발행 시간:  {s1}"
  },
  LanguageConfig_PvpCollectCommentSortModePublishTime_CN = {Text = "최신"},
  LanguageConfig_PvpCollectCommentSortModeRecommend_CN = {Text = "추천"},
  LanguageConfig_PvpCollectCommentUpdateTime_CN = {
    Text = "편집한 날짜: {s1}"
  },
  LanguageConfig_PvpCollectEditCommentViewTitle_CN = {
    Text = "코멘트 편집"
  },
  LanguageConfig_PvpCommentTimeLessThan1Day_CN = {
    Text = "{s1}시간 전"
  },
  LanguageConfig_PvpCommentTimeLessThan1Hour_CN = {
    Text = "{s1}분 전"
  },
  LanguageConfig_PvpCommentTimeLessThan1Min_CN = {Text = "방금"},
  LanguageConfig_PvpCommentTimeLessThan1Month_CN = {
    Text = "{s1}일 전"
  },
  LanguageConfig_PvpCommentTimeLessThan1Year_CN = {
    Text = "{s1}개월 전"
  },
  LanguageConfig_PvpCommentTimeMoreThan1Year_CN = {
    Text = "{s1}년 전"
  },
  LanguageConfig_PvpDraftAdjustPosReady_CN = {
    Text = "준비 완료"
  },
  LanguageConfig_PvpDraftClickConfirmWhenNotSelect_CN = {
    Text = "먼저 전투할 깨어남체/운명의 바퀴/은열쇠를 선택해주세요"
  },
  LanguageConfig_PvpDraftParamEntryLockTips_CN = {
    Text = "현재 시즌 점수가 {s1}에 도달하여, 참여 가능합니다."
  },
  LanguageConfig_PvpFriendBattle_CN = {
    Text = "친선 경기"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_Draft_CN = {
    Text = "선택 보상"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_Draft_ExpProgress_CN = {
    Text = "선택 경험 {s1}"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_PreBuild_CN = {
    Text = "예비 그룹 보상"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_PreBuild_ExpProgress_CN = {
    Text = "예비 그룹 경험 {s1}"
  },
  LanguageConfig_PvpMatchBattle_CN = {
    Text = "매칭 대전"
  },
  LanguageConfig_PvpMatchCanceling_CN = {
    Text = "취소 중..."
  },
  LanguageConfig_PvpMatchEmptyPvpTypeTips_CN = {
    Text = "최소 하나의 매칭 타입을 선택하세요"
  },
  LanguageConfig_PvpOnlyKeeperSkillClickTips_CN = {
    Text = "해당 열쇠는 「페이즈 체스」 전용 열쇠로, 현재 조사에서는 사용할 수 없습니다"
  },
  LanguageConfig_PvpRuleTipsCreationTitle_CN = {
    Text = "[랜덤 유물]"
  },
  LanguageConfig_PvpTaskViewTitle_CN = {
    Text = "대결 기록"
  },
  LanguageConfig_PvpVoiceName_AwakerDied_CN = {Text = "죽음"},
  LanguageConfig_PvpVoiceName_CountingStart_CN = {Text = "촉구"},
  LanguageConfig_PvpVoiceName_OperationImpossible_CN = {Text = "오류"},
  LanguageConfig_PvpVoiceName_OperationStop_CN = {Text = "생각"},
  LanguageConfig_PvpVoiceName_PlayerEnter_CN = {Text = "시작"},
  LanguageConfig_PvpVoiceName_ReletedAwakerInEnemies_CN = {
    Text = "관계 대화·{s1}"
  },
  LanguageConfig_PvpVoiceName_SkillReady_CN = {Text = "필살"},
  LanguageConfig_QuantityHeld_CN = {
    Text = "보유 수량: {s1}"
  },
  LanguageConfig_QuestionnaireEmailSender_CN = {
    Text = "미사그 대학 교무실타래"
  },
  LanguageConfig_RPGJJC_Desc_CN = {
    Text = "「연습 증명서」를 소모하여 다른 수호자가 배치한 방어 파티에 도전할 수 있으며, 도전에 성공하면 랭킹이 상승합니다. 동시에 자신의 방어 파티도 신중히 배치하세요. 그렇지 않으면 다른 수호자의 공격으로 랭킹이 하락할 수 있습니다. 랭킹이 높을수록 매 시간 획득하는 「연습 배지」의 양이 증가합니다. 「연습 증명서」는 시간이 지나면 자동으로 충전되며, 「연습 배지」는 교환 상점에서 장미 금권, 영지 비약 등 다양한 아이템으로 교환할 수 있습니다."
  },
  LanguageConfig_RPGTeam_School_All_CN = {Text = "개요"},
  LanguageConfig_RPGTeam_School_Have_No_Actor_CN = {
    Text = "해당 영역의 깨어남체를 획득하지 않았습니다"
  },
  LanguageConfig_RailHistoryLevelViewTitle_ExpProgress_CN = {
    Text = "귀빈 포인트{s1}"
  },
  LanguageConfig_RailWayActivityRewardTitle_CN = {
    Text = "열차 노선"
  },
  LanguageConfig_RailWayCurProgress_CN = {
    Text = "현재 진행 상황{s1}"
  },
  LanguageConfig_RailWayHistoryLevelViewTitle_CN = {
    Text = "우등실타래 규격"
  },
  LanguageConfig_RailWayLevelAdjustmentTipsContent_CN = {
    Text = "「질주하는 환희 특급열차」에는 레벨 보상 메커니즘이 있으며, 구체적인 규칙은 다음과 같습니다: \n ·조사 팀에서 레벨이 60 미만인 깨어남체는 이번 도전에서 60레벨로 보상됩니다. \n ·조사 팀에서 스킬 레벨이 5 미만인 깨어남체는 이번 도전에서 5레벨로 보상됩니다. \n ·조사 팀에서 「광기의 징조」가 6 미만인 깨어남체는 이번 도전에서 6레벨로 보상됩니다. \n ·조사 팀에서 「영혼 단련」이 5 미만인 깨어남체는 이번 도전에서 5레벨로 보상됩니다. \n ·만약 수호자 레벨이 60 미만이라면, 이번 도전에서 60레벨로 보상됩니다."
  },
  LanguageConfig_RailWayLevelAdjustmentTipsTitle_CN = {
    Text = "레벨 보상"
  },
  LanguageConfig_RailWayLevelAdjustmentTips_CN = {
    Text = "레벨 보상"
  },
  LanguageConfig_RailWayMaxProgress_CN = {
    Text = "커리어 최고 진행도"
  },
  LanguageConfig_RailWayOutBreakRecordTips_CN = {
    Text = "진행도 갱신!"
  },
  LanguageConfig_RailWayOutMaxExp_CN = {
    Text = "「귀빈 포인트」 {s1}pt"
  },
  LanguageConfig_RailWayResonanceRuleContent_CN = {
    Text = "1. 「질주하는 환희 특급 열차」에서는 보다 풍부한 공명 강화를 제공해 수호자 님들께 도전 중 강력한 지원을 제공합니다.\n2. 「기념 사진 촬영」에서 공명 강화 재료를 획득하실타래 수 있으며, 재료를 소모해 공명 효과를 활성화할 수 있습니다.\n3. 각 단계마다 조사 작전 공명 이벤트가 존재하며, 조사 작전 공명 이벤트에 진입 시 해당 챕터의 강력한 공명 효과를 획득하실타래 수 있고, 해당 공명 효과는 전체 조사가 끝날 때까지 지속됩니다.\n4. 「작은 「N」의 협조」에서 획득한 공명 효과는 조사가 시작된 후부터 조사 종료 시까지 지속됩니다."
  },
  LanguageConfig_RailWayRulesContentV2_CN = {
    Text = "<Title:게임 방식 소개>\n1、「질주하는 즐거움 특급 열차」는 「별의 시대」 규칙을 채용한 연속 도전 모드입니다. 수호자는 다양한 랜덤 조우 속에서 여러 조사 작전에 등장했던 최종 보스에게 연속으로 도전하게 됩니다!\n2、게임 방식 내 유물 보유 상한은 최대 36개까지 높일 수 있습니다.\n3、도전 과정 중 조사 작전 내 강력한 「공명」 효과 3종을 동시에 보유하고 강화할 수 있습니다.\n4、응급 영지체를 1회 사용할 때마다 이번 도전에서 획득하는 「VIP 포인트」가 20% 감소합니다.\n5、도중 퇴장 후 진행 상황 보존을 지원하지만, 팀 상태는 외부 육성 변경 사항과 동기화되어 업데이트되지 않습니다. 진행 상황은 최대 이전 도전으로부터 7일 후까지 보존되며, 보존 기간 내에 도전을 계속하지 않으면 도전 포기로 간주되어 진행 상황이 더 이상 보존되지 않습니다.\n\n<Title:레벨 보정>\n「열차 출발」에 참여하면 레벨 보정을 받게 되며, 구체적인 규칙은 다음과 같습니다:\n  ·조사 팀 내 레벨이 60 미만인 각성체는 이번 도전에서 60레벨로 보정됩니다.\n  ·조사 팀 내 스킬 레벨이 5 미만인 각성체는 이번 도전에서 5레벨로 보정됩니다.\n  ·조사 팀 내 「광기의 징조」가 6 미만인 각성체는 이번 도전에서 6레벨로 보정됩니다.\n  ·조사 팀 내 「영혼 단련」이 5 미만인 각성체는 이번 도전에서 5레벨로 보정됩니다.\n  ·수호자 레벨이 60 미만인 경우, 이번 도전에서 60레벨로 보정됩니다.\n\n<Title:단계 구성>\n1、단일 도전은 총 세 단계로 나뉘며, 각 단계의 주요 적과 공명 효과는 해당 범위 내에서 무작위로 생성됩니다:\n  ·1단계: 「망각편」 제1~4장 내용에 해당합니다.\n  ·2단계: 「망각편」 제5~8장 내용에 해당합니다.\n  ·3단계: 「별의 시대」 제1~4장 내용에 해당합니다.\n ·광기 난이도에서는 3단계 도전 완료 후 4단계 최종 보스 「타비」에게 추가로 도전하게 됩니다.\n2、단계 보스를 격파한 후, 무작위 3개의 「시계추」 중 하나를 선택하여 획득할 수 있습니다.\n\n<Title:난이도 및 초기 유물>\n이번 도전은 총 세 가지 난이도로 구성되며, 각 난이도마다 다른 단계 보상과 초기 유물이 있습니다. 수호자 여러분은 도전 난이도 선택 전에 상세 정보를 확인하실 수 있습니다.\n\n<Title:단계 보상>\n1、각 난이도의 엘리트와 보스를 격파하여 「VIP 포인트」를 획득할 수 있으며, 「VIP 포인트」는 「아실 규격」 레벨을 높여 보상을 획득하는 데 사용됩니다.\n  ·1단계: 엘리트/보스 격파 시 「VIP 포인트」×25/75 획득\n  ·2단계: 엘리트/보스 격파 시 「VIP 포인트」×50/150 획득\n  ·3단계: 엘리트/보스 격파 시 「VIP 포인트」×75/225 획득\n2、도전 난이도가 높을수록 더 많은 「VIP 포인트」를 획득할 수 있습니다.\n  ·【어려움 난이도】: 세 단계 완료 시 획득하는 「VIP 포인트」가 150% 증가합니다.\n\n  ·【매드니스 난이도】: 세 단계 완료 시 획득하는 「VIP 포인트」가 400% 증가합니다.\n ·최종 보스 「타비」를 격파하면 「VIP 포인트」×1500을 추가로 획득할 수 있습니다.\n\n<Title:시즌 업데이트>\n1、「귀빈 명부」는 도전 성과가 우수한 수호자를 기록하며, 매 시즌 동안 1회 도전하여 「VIP 포인트」를 성공적으로 획득한 수호자는 「귀빈 명부」에 등재될 수 있습니다.\n2、「귀빈 명부」의 시즌 순위는 단일 도전에서 획득한 최다 「VIP 포인트」와 최소 「턴 수」를 기준으로 하며, 반복 도전을 통해 순위를 높일 수 있습니다.\n3、시즌 종료 후 이메일을 통해 해당 시즌 「귀빈 명부」의 순위 보상이 정산됩니다.\n4、매 시즌마다 시즌 임무가 있으며, 시즌 임무를 완료하면 풍부한 보상을 획득할 수 있습니다. 시즌 임무는 매 시즌 업데이트 시 초기화됩니다.\n5、시즌 전환 시, 전투 중인 단계는 도전 완료 후 최신 시즌 임무를 바로 완료할 수 있지만, 「귀빈 명부」에는 등재될 수 없습니다."
  },
  LanguageConfig_RailWayRulesContent_CN = {
    Text = "<Title:게임 모드 소개>\n1、「질주하는 즐거움 특급 열차」는 「별의 시대」 규칙을 채택한 연속 도전 모드입니다. 수호자는 다양한 무작위 조우 속에서 여러 조사 작전에 등장했던 최종 보스에게 연속으로 도전하게 됩니다!\n2、게임 모드 내 유물 보유 상한은 최대 36개까지 증가할 수 있습니다.\n3、도전 과정에서 조사 작전의 강력한 「공명」 효과 3종을 동시에 보유하고 강화할 수 있습니다.\n4、응급 영지체를 1회 사용할 때마다 이번 도전에서 획득하는 「VIP 포인트」가 20% 감소합니다.\n5、도중에 나가고 진행 상황을 보존할 수 있지만, 팀 상태는 외부 육성 변화에 따라 동기화되어 업데이트되지 않습니다. 진행 상황은 최대 이전 도전으로부터 7일 후까지 보존되며, 보존 기간 동안 도전을 계속하지 않으면 도전을 포기한 것으로 간주되어 진행 상황이 더 이상 보존되지 않습니다.\n\n<Title:레벨 보정>\n「열차 출발」에 참여하면 레벨 보정을 받을 수 있으며, 구체적인 규칙은 다음과 같습니다:\n  ·조사 팀 내 레벨이 60레벨 미만인 각성체는 이번 도전에서 60레벨로 보정됩니다.\n  ·조사 팀 내 스킬 레벨이 5레벨 미만인 각성체는 이번 도전에서 5레벨로 보정됩니다.\n  ·조사 팀 내 「광기의 징조」가 6레벨 미만인 각성체는 이번 도전에서 6레벨로 보정됩니다.\n  ·조사 팀 내 「영혼 단련」이 5레벨 미만인 각성체는 이번 도전에서 5레벨로 보정됩니다.\n  ·수호자 레벨이 60레벨 미만인 경우, 이번 도전에서 60레벨로 보정됩니다.\n\n<Title:단계 구성>\n1、단일 도전은 총 세 단계로 나뉘며, 각 단계의 주제 적과 공명 효과는 해당 범위 내에서 무작위로 생성됩니다:\n  ·1단계: 「망각편」 제1~4장 내용에 해당합니다.\n  ·2단계: 「망각편」 제5~8장 내용에 해당합니다.\n  ·3단계: 「별의 시대」 제1~4장 내용에 해당합니다.\n2、단계 보스를 처치한 후, 무작위 3개의 「시계추」 중 하나를 선택하여 획득할 수 있습니다.\n\n<Title:난이도와 초기 유물>\n이번 도전은 총 세 가지 난이도로 구성되며, 각 난이도마다 다른 단계 보상과 초기 유물이 있습니다. 수호자 여러분은 도전 난이도를 선택하기 전에 자세한 정보를 확인할 수 있습니다.\n\n<Title:단계 보상>\n1、각 난이도의 엘리트와 보스를 처치하여 「VIP 포인트」를 획득할 수 있으며, 「VIP 포인트」는 「아실 규격」 레벨을 올려 보상을 획득하는 데 사용됩니다.\n  ·1단계: 엘리트/보스 격파 시 「VIP 포인트」×25/75 획득\n  ·2단계: 엘리트/보스 격파 시 「VIP 포인트」×50/150 획득\n  ·3단계: 엘리트/보스 격파 시 「VIP 포인트」×75/225 획득\n2、도전 난이도가 높을수록 더 많은 「VIP 포인트」를 획득할 수 있습니다.\n  ·【어려운 난이도】: 세 단계 완료 시 획득하는 「VIP 포인트」가 150% 증가\n  ·【광기 난이도】: 세 단계 완료 시 획득하는 「VIP 포인트」가 400% 증가\n\n<Title:시즌 업데이트>\n1、「귀빈 명부」는 도전 성적이 우수한 수호자를 기록하며, 각 시즌 동안 1회 도전하여 「VIP 포인트」를 성공적으로 획득한 수호자는 「귀빈 명부」에 등록될 수 있습니다.\n2、「귀빈 명부」의 시즌 랭킹은 단일 도전에서 획득한 최다 「VIP 포인트」와 최소 「턴 수」를 기준으로 하며, 반복 도전을 통해 순위를 높일 수 있습니다.\n3、시즌 종료 후, 메일을 통해 이번 시즌 「귀빈 명부」의 랭킹 보상이 정산됩니다.\n4、매 시즌마다 시즌 임무가 있으며, 시즌 임무를 완료하면 풍성한 보상을 획득할 수 있습니다. 시즌 임무는 매 시즌 업데이트 시 초기화됩니다.\n5、시즌 전환 시, 전투 중인 단계는 도전 완료 후 최신 시즌 임무를 바로 완료할 수 있지만, 최신 「귀빈 명부」에는 진입할 수 없습니다."
  },
  LanguageConfig_RailWayRulesTitle_CN = {
    Text = "질주하는 환희 특급 열차"
  },
  LanguageConfig_RailWaySaveAndExit_CN = {
    Text = "저장 후 종료"
  },
  LanguageConfig_RailWaySettlementDetails1_CN = {
    Text = "기본 보상"
  },
  LanguageConfig_RailWaySettlementDetails2_CN = {
    Text = "응급 영지체 사용하여 낮추기"
  },
  LanguageConfig_RailWayStageCrazyMileExpGetDescV2_CN = {
    Text = "이번 조사에서 최대 {s1}「VIP 포인트」를 획득할 수 있습니다.\n「응급 영지체」를 {s3}회 사용하였으며, 현재 {s2}「VIP 포인트」를 획득하였습니다.\n  ·1단계: 엘리트/보스 격파 시 「VIP 포인트」×25/75 획득\n  ·2단계: 엘리트/보스 격파 시 「VIP 포인트」×50/150 획득\n  ·3단계: 엘리트/보스 격파 시 「VIP 포인트」×75/225 획득\n  ·어려움/광기 난이도에서 획득하는 「VIP 포인트」가 150%/400% 증가합니다\n  ·광기 난이도 4단계 보스를 처치하면 「VIP 포인트」× 1500을 추가로 획득할 수 있습니다.\n  ·「응급 영지체」를 1회 사용할 때마다 「VIP 포인트」가 20% 감소합니다."
  },
  LanguageConfig_RailWayStageCrazyMileExpGetDesc_CN = {
    Text = "이번 조사에서 최대 {s1} 「귀빈 포인트」를 획득할 수 있습니다.\n{s3}회 「응급 영지체」를 사용했으며, 현재 {s2} 「귀빈 포인트」를 획득했습니다.\n  ·1단계: 정예/수령 격파 시 「귀빈 포인트」×25/75 획득\n  ·2단계: 정예/수령 격파 시 「귀빈 포인트」×50/150 획득\n  ·3단계: 정예/수령 격파 시 「귀빈 포인트」×75/225 획득\n  ·어려움/광란 난이도에서 획득하는 「귀빈 포인트」가 150%/400% 증가\n  ·「응급 영지체」를 1회 사용할 때마다 「귀빈 포인트」가 20% 감소합니다."
  },
  LanguageConfig_RailWayStageCrazyNowDescV2_CN = {
    Text = "광기 난이도는 4개의 단계로 구성되며, 앞의 3개 단계에서 각 단계마다 6번의 전투가 있습니다. 제4단계에서는 바로 최종 리더에게 도전합니다.\n현재 제 {s1} 단계 - 제 {s2} 번째 전투에 도달했습니다."
  },
  LanguageConfig_RailWayStageCrazyNowDesc_CN = {
    Text = "현재 조사 중에는 3개의 단계가 있으며, 각 단계마다 6번의 전투가 있습니다.\n현재 {s1}단계 - {s2}번째 전투에 도달했습니다."
  },
  LanguageConfig_RailWayStageDifficultyBuffContent1_CN = {
    Text = "<Title:단계 보상>\n· 1단계: 엘리트/보스 격파 시 「귀빈 포인트」×25/75 획득\n· 2단계: 엘리트/보스 격파 시 「귀빈 포인트」×50/150 획득\n· 3단계: 엘리트/보스 격파 시 「귀빈 포인트」×75/225 획득\n<Title:초기 유물>\n조사 시작 시 유물 「작은 「N」의 완전한 카메라」를 획득합니다.\n· <OrangeQuality:골드 조화>: 「행동력 조화」로 인한 행동력 증가 효과의 최대치는 1pt이며, 피해 증폭 효과 1%당 영지 연구 심도가 1% 증가합니다.\n· <RedQuality:장거리 피로>: 전투 중 모든 HP 회복 효과가 50% 감소합니다."
  },
  LanguageConfig_RailWayStageDifficultyBuffContent2_CN = {
    Text = "<Title:단계 보상>\n도전의 난이도가 높을수록 더 많은 「귀빈 포인트」를 획득하실타래 수 있습니다. 3가지 단계에서 획득한 「귀빈 포인트」가 150% 증가합니다.\n<Title:초기 유물>\n조사 시작 시 유물 「작은 「N」의 낡은 카메라」를 획득합니다.\n· <OrangeQuality:골드 조화>: 「행동력 조화」로 인한 행동력 증가 효과의 최대치는 1pt이며, 피해 증폭 효과 1%당 영지 연구 심도가 1% 증가합니다.\n· <OrangeQuality:차원 선물>: 탐험 시작 시, 랜덤으로 차원 영상 유물을 1개 획득하며, 최대 손패 매수가 1 증가합니다.\n· <RedQuality:장거리 피로>: 전투 중 모든 HP 회복 효과가 50% 감소합니다.\n· <RedQuality:기절 증상>: 전투 시작 시, 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다."
  },
  LanguageConfig_RailWayStageDifficultyBuffContent3V2_CN = {
    Text = "<Title:특별 도전>\n광기 난이도에서 제3단계를 완료하면 추가로 제4단계 최종 리더 「타비」에게 도전합니다.\n<Title:단계 보상>\n도전 난이도가 높을수록 더 많은 「VIP 포인트」를 획득합니다. 세 단계를 완료하여 획득하는 「VIP 포인트」가 400% 증가\n최종 리더 「타비」를 격파한 후, 추가로 「VIP 포인트」× 1500을 획득할 수 있습니다.\n<Title:초기 유물>\n조사 시작 시 유물 「꼬마 」N「의 혼란스러운 카메라」를 획득\n·<OrangeQuality:황금 조화>: 「산출력 조화」로 인한 행동력 증가 효과의 최대치는 1점이며, 피해 증폭 1%를 보유할 때마다 영지 연구 심도 효과가 1% 증가합니다.\n·<OrangeQuality:차원의 선물>: 탐색 시작 시 무작위로 차원 영상 유물 1개를 획득하고, 최대 손패 매수가 2 증가합니다.\n·<OrangeQuality:축복 의식>: 제1, 제2단계 리더 격파 보상이 무작위 축복 유물 3개 중 1개 선택으로 변경됩니다.\n·<RedQuality:장거리 피로>: 전투 중 모든 HP 회복 효과가 50% 감소합니다.\n·<RedQuality:기절 증상>: 전투 시작 시 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다.\n·<RedQuality:영원한 밤의 복도>: 탐색 시작 시 모든 깨어남체의 광기 최대치와 은열쇠 에너지 상한이 50% 증가합니다"
  },
  LanguageConfig_RailWayStageDifficultyBuffContent3_CN = {
    Text = "<Title:단계 보상>\n도전의 난이도가 높을수록 더 많은 「귀빈 포인트」를 획득하실타래 수 있습니다. 3가지 단계에서 획득한 「귀빈 포인트」가 400% 증가합니다.\n<Title:초기 유물>\n조사 시작 시 유물 「작은 「N」의 혼란 카메라」를 획득합니다.\n· <OrangeQuality:골드 조화>: 「행동력 조화」로 인한 행동력 증가 효과의 최대치는 1pt이며, 피해 증폭 효과 1%당 영지 연구 심도가 1% 증가합니다.\n· <OrangeQuality:차원 선물>: 탐험 시작 시, 랜덤으로 차원 영상 유물을 1개 획득하며, 최대 손패 매수가 2 증가합니다.\n· <OrangeQuality:축복받은 의식>: 1단계, 2단계의 보스 보상이 축복받은 유물 3개 중 1개 랜덤 획득으로 변경됩니다.\n· <RedQuality:장거리 피로>: 전투 중 모든 HP 회복 효과가 50% 감소합니다.\n· <RedQuality:기절 증상>: 전투 시작 시, 모든 깨어남체의 현재 광기와 은열쇠 에너지가 50% 감소합니다.\n· <RedQuality:영원한 밤의 복도>: 탐험 시작 시, 모든 깨어남체의 광기 최대치와 은열쇠 에너지 상한이 50% 증가합니다."
  },
  LanguageConfig_RailWayStageInformationTitle_CN = {
    Text = "단계 규칙 설명"
  },
  LanguageConfig_RailWayStageMileExpGetDesc_CN = {
    Text = "이번 조사에서 최대 {s1} 「귀빈 포인트」를 획득할 수 있습니다.\n{s3}회 「응급 영지체」를 사용했으며, 현재 {s2} 「귀빈 포인트」를 획득했습니다.\n  ·1단계: 정예/수령 격파 시 「귀빈 포인트」×25/75 획득\n  ·2단계: 정예/수령 격파 시 「귀빈 포인트」×50/150 획득\n  ·3단계: 정예/수령 격파 시 「귀빈 포인트」×75/225 획득\n  ·어려움/광란 난이도에서 획득하는 「귀빈 포인트」가 150%/400% 증가\n  ·「응급 영지체」를 1회 사용할 때마다 「귀빈 포인트」가 20% 감소합니다."
  },
  LanguageConfig_RailWayStageMileExpGetTitle_CN = {
    Text = "귀빈 포인트"
  },
  LanguageConfig_RailWayStageNowDesc_CN = {
    Text = "현재 조사 중에는 3개의 단계가 있으며, 각 단계마다 6번의 전투가 있습니다.\n현재 {s1}단계 - {s2}번째 전투에 도달했습니다."
  },
  LanguageConfig_RailWayStageNowTitle_CN = {
    Text = "조사 진행도"
  },
  LanguageConfig_RailWayTaskViewTitle_CN = {
    Text = "기념 사진 촬영"
  },
  LanguageConfig_RandomChestTipConfirmBtnTxt_CN = {
    Text = "랜덤으로 획득"
  },
  LanguageConfig_RandomSelectAward_CN = {
    Text = "랜덤 획득"
  },
  LanguageConfig_RankDataFirstLoadTip_CN = {
    Text = "데이터 요청 중"
  },
  LanguageConfig_RankDataNull_CN = {
    Text = "기록 없음"
  },
  LanguageConfig_RankListAchievementCount_CN = {
    Text = "업적 달성 개수"
  },
  LanguageConfig_RankListAssistanceCount_CN = {
    Text = "지원 횟수"
  },
  LanguageConfig_RankListCollectionNum_CN = {
    Text = "전시관 컬렉션 수"
  },
  LanguageConfig_RankListFollowerNum_CN = {
    Text = "팔로워 수"
  },
  LanguageConfig_RankListGetlikeCount_CN = {
    Text = "받은 좋아요 수"
  },
  LanguageConfig_RankListHomologyRate_CN = {
    Text = "총 동조율 레벨"
  },
  LanguageConfig_RankListLikeCount_CN = {
    Text = "보낸 좋아요 수"
  },
  LanguageConfig_RankListLoginDays_CN = {
    Text = "로그인 일수"
  },
  LanguageConfig_RankListPlayerLevel_CN = {
    Text = "수호자 조사 등급/경험치"
  },
  LanguageConfig_RateStrColored_CN = {
    Text = "배율 <color=#5EF2FF>x{s1}</color>"
  },
  LanguageConfig_RateStr_CN = {
    Text = "배율 ×{s1}"
  },
  LanguageConfig_RatingTipsDesc_CN = {
    Text = "스토어 페이지로 이동하여 게임에 대한 소중한 평가와 의견을 부탁드립니다."
  },
  LanguageConfig_RatingTipsTitle_CN = {
    Text = "평가 초대"
  },
  LanguageConfig_ReConnect_1_CN = {
    Text = "동기화 재시도 중..."
  },
  LanguageConfig_ReConnect_6_CN = {
    Text = "정신 동기화 진행 중"
  },
  LanguageConfig_ReConnect_7_CN = {
    Text = "동기화 실타래패"
  },
  LanguageConfig_ReRoundNoReward_CN = {
    Text = "수령 가능한 미션이 없습니다. 「페이즈 체스」에 참여하세요."
  },
  LanguageConfig_ReRoundRewardTitle_CN = {
    Text = "라운드 특별상"
  },
  LanguageConfig_ReRoundScoreStr_CN = {
    Text = "현재 마법의 도토리 수량: {s1}"
  },
  LanguageConfig_ReachLimitForCompose_CN = {
    Text = "한도에 도달하여 합성할 수 없습니다"
  },
  LanguageConfig_ReadAllStr_CN = {
    Text = "모두 읽음"
  },
  LanguageConfig_RecClass_Description_Detail_CN = {
    Text = "· 만약 활성화된 영역이 추천 영역 중 하나와 동일하면, 모든 출전 깨어남체의 체력, 공격, 방어가 잠금 비율로 상승합니다."
  },
  LanguageConfig_RecClass_Description_Title_CN = {
    Text = "추천 영역 설명"
  },
  LanguageConfig_RecClass_tips_CN = {
    Text = "아군 파티 속성 {s1}"
  },
  LanguageConfig_RecastButtonText_CN = {Text = "재인쇄"},
  LanguageConfig_RecastConsumeTrinketTips_1_CN = {
    Text = "재인쇄를 통해 비밀 계약 상자 {s1}개를 획득할 수 있습니다"
  },
  LanguageConfig_RecastConsumeTrinketTips_2_CN = {
    Text = "현재 선택된 비밀 계약을 소모하여 <color=#fea338>{s1}</color>개의 새로운 비밀 계약을 제작할 수 있습니다 (비밀 계약 추가 제작을 위해 필요한 개수: <color=#fea338>{s2}/{s3}</color>)"
  },
  LanguageConfig_RecastConsumeTrinketTips_CN = {
    Text = "임의의 SSR 비밀 계약 3개를 새로운 비밀 계약으로 재인쇄"
  },
  LanguageConfig_RecastTimes_CN = {
    Text = "재인쇄 횟수"
  },
  LanguageConfig_RecastTitle_CN = {
    Text = "비밀 계약 재인쇄"
  },
  LanguageConfig_RecommendAccountLevel_CN = {
    Text = "레벨 {s1} 권장"
  },
  LanguageConfig_RecordShortcut_CN = {
    Text = "설정된 키를 누르세요"
  },
  LanguageConfig_RecordsSortTypeTime_CN = {
    Text = "완료 일자"
  },
  LanguageConfig_RedEnchantConfigTypeName_CN = {
    Text = "<RedRelic:저주 각인>"
  },
  LanguageConfig_RedRelicTypeName_CN = {
    Text = "<RedRelic:저주받은 유물>"
  },
  LanguageConfig_RedemptionCodePanelTitle_CN = {
    Text = "보상 교환"
  },
  LanguageConfig_RedemptionTips_10026_CN = {
    Text = "이미 이 교환 코드와 유사한 코드의 보상을 수령했습니다."
  },
  LanguageConfig_RedemptionTips_10028_CN = {
    Text = "이미 이 교환 코드와 호환되지 않는 다른 코드의 보상을 수령했습니다."
  },
  LanguageConfig_RedemptionTips_10029_CN = {
    Text = "해당 교환 코드 보상이 만료되었습니다."
  },
  LanguageConfig_RedemptionTips_10602_CN = {
    Text = "해당 교환 코드가 활성화되지 않았거나, 수령 조건을 충족하지 못했습니다."
  },
  LanguageConfig_RedemptionTips_10603_CN = {
    Text = "해당 교환 코드에 대한 보상이 존재하지 않습니다."
  },
  LanguageConfig_RedemptionTips_10604_CN = {
    Text = "동일 교환 코드 사용 횟수가 최대치에 도달했습니다."
  },
  LanguageConfig_RedemptionTips_10607_CN = {
    Text = "시스템이 혼잡합니다, 잠시 후에 다시 시도해 주세요."
  },
  LanguageConfig_RedemptionTips_10608_CN = {
    Text = "입력한 캐릭터 ID 혹은 캐릭터 이름이 잘못되었습니다. 다시 시도해 주세요."
  },
  LanguageConfig_RedemptionTips_10610_CN = {
    Text = "이미 해당 교환 코드와 호환되지 않는 다른 코드를 사용했습니다."
  },
  LanguageConfig_RedemptionTips_10611_CN = {
    Text = "해당 교환 코드를 입력한 수호자 수가 최대에 도달했습니다."
  },
  LanguageConfig_RedemptionTips_10612_CN = {
    Text = "이미 해당 교환 코드를 사용했습니다."
  },
  LanguageConfig_RedemptionTips_15000_CN = {
    Text = "해당 교환 코드의 보상 수령 조건을 충족하지 못했습니다."
  },
  LanguageConfig_RedemptionTips_200_CN = {
    Text = "교환에 성공했습니다! 잠시 후 우편함을 확인해 주세요."
  },
  LanguageConfig_RedemptionTips_419_CN = {
    Text = "교환 코드가 존재하지 않습니다."
  },
  LanguageConfig_RedemptionTips_429_CN = {
    Text = "작업이 너무 자주 이루어졌습니다. 잠시 후에 다시 시도해 주세요."
  },
  LanguageConfig_RedemptionTips_430_CN = {
    Text = "해당 교환 코드는 사용할 수 없습니다."
  },
  LanguageConfig_RedemptionTips_Empty_CN = {
    Text = "교환 코드가 입력되지 않았습니다. 교환 코드를 입력해 주세요."
  },
  LanguageConfig_RedemptionTips_other_CN = {
    Text = "해당 교환 코드의 사용자 수가 최대치에 도달했거나, 교환 코드가 존재하지 않습니다."
  },
  LanguageConfig_ReducedDeathResistance_CN = {
    Text = "죽음 저항이 감소했습니다!"
  },
  LanguageConfig_RefineReturn_CN = {
    Text = "중첩 초과 반환"
  },
  LanguageConfig_Refine_CN = {Text = "중첩"},
  LanguageConfig_Refresh_CN = {Text = "갱신"},
  LanguageConfig_RefusedText_CN = {Text = "거부됨"},
  LanguageConfig_RelicAwardButton_CN = {Text = "확인"},
  LanguageConfig_RelicAwardTitle_CN = {
    Text = "유물 1개 선택"
  },
  LanguageConfig_RelicAwardUncheck_CN = {
    Text = "유물 선택"
  },
  LanguageConfig_RelicDeleteCardDesc_CN = {
    Text = "카드 {s1}장 삭제"
  },
  LanguageConfig_RelicGroup_100_CN = {Text = "혈육"},
  LanguageConfig_RelicGroup_101_CN = {Text = "초차원"},
  LanguageConfig_RelicGroup_10_CN = {Text = "마술"},
  LanguageConfig_RelicGroup_11_CN = {Text = "저주"},
  LanguageConfig_RelicGroup_12_CN = {Text = "보호"},
  LanguageConfig_RelicGroup_13_CN = {Text = "쌍생"},
  LanguageConfig_RelicGroup_14_CN = {Text = "증식"},
  LanguageConfig_RelicGroup_15_CN = {
    Text = "최상의 경지"
  },
  LanguageConfig_RelicGroup_16_CN = {Text = "즉발"},
  LanguageConfig_RelicGroup_1_CN = {Text = "기원"},
  LanguageConfig_RelicGroup_201_CN = {Text = "원초"},
  LanguageConfig_RelicGroup_202_CN = {Text = "지배자"},
  LanguageConfig_RelicGroup_203_CN = {Text = "잠재력"},
  LanguageConfig_RelicGroup_204_CN = {Text = "통솔"},
  LanguageConfig_RelicGroup_205_CN = {Text = "처형"},
  LanguageConfig_RelicGroup_206_CN = {Text = "부식"},
  LanguageConfig_RelicGroup_207_CN = {Text = "통찰"},
  LanguageConfig_RelicGroup_208_CN = {Text = "사멸"},
  LanguageConfig_RelicGroup_209_CN = {
    Text = "피의 제사"
  },
  LanguageConfig_RelicGroup_210_CN = {Text = "무명"},
  LanguageConfig_RelicGroup_251_CN = {Text = "초차원"},
  LanguageConfig_RelicGroup_252_CN = {Text = "혈육"},
  LanguageConfig_RelicGroup_253_CN = {Text = "심해"},
  LanguageConfig_RelicGroup_290_CN = {
    Text = "차원 영상 - 혼돈"
  },
  LanguageConfig_RelicGroup_291_CN = {
    Text = "차원 영상 - 깊은 바다"
  },
  LanguageConfig_RelicGroup_292_CN = {
    Text = "차원 영상 - 혈육"
  },
  LanguageConfig_RelicGroup_293_CN = {
    Text = "차원 영상 - 초차원"
  },
  LanguageConfig_RelicGroup_2_CN = {Text = "새싹"},
  LanguageConfig_RelicGroup_3_CN = {Text = "리듬"},
  LanguageConfig_RelicGroup_4_CN = {Text = "무욕"},
  LanguageConfig_RelicGroup_5_CN = {
    Text = "피와 고름"
  },
  LanguageConfig_RelicGroup_6_CN = {Text = "망상"},
  LanguageConfig_RelicGroup_7_CN = {
    Text = "기묘한 아름다움"
  },
  LanguageConfig_RelicGroup_8_CN = {Text = "적성"},
  LanguageConfig_RelicGroup_997_CN = {Text = "축복"},
  LanguageConfig_RelicGroup_998_CN = {Text = "죄악"},
  LanguageConfig_RelicGroup_999_CN = {
    Text = "유물 그룹 테스트 999"
  },
  LanguageConfig_RelicGroup_99_CN = {Text = "심해"},
  LanguageConfig_RelicGroup_9_CN = {Text = "진격"},
  LanguageConfig_RelicLvUnlock_CN = {
    Text = "유물 해금"
  },
  LanguageConfig_RelicSelectedEnoughHint_CN = {
    Text = "더 이상 유물을 선택할 수 없습니다"
  },
  LanguageConfig_RelicSelectedNotEnoughHint_CN = {
    Text = "유물 {s1}개 선택하기"
  },
  LanguageConfig_RelicStoreTitle_CN = {
    Text = "유물 융식 흔적"
  },
  LanguageConfig_RelicStrengthShopTitle_CN = {
    Text = "{s1}개의 유물을 선택하여 강화합니다"
  },
  LanguageConfig_Relic_Select_CN = {
    Text = "유물 {s1}개 선택하기"
  },
  LanguageConfig_RemainValidTime_CN = {
    Text = "남은 유효 시간:"
  },
  LanguageConfig_RemoveBuff_CN = {
    Text = "<color=#FF7370>해제</color>"
  },
  LanguageConfig_RemoveCardHint_CN = {
    Text = "삭제된 카드는 이번 조사에서 영구적으로 제거되니, 신중하게 선택하세요."
  },
  LanguageConfig_RemoveDeBuff_CN = {
    Text = "<color=#E3FFE3>정화</color>"
  },
  LanguageConfig_RenderChangeCDTips_CN = {
    Text = "성별 전환 쿨타임 {s1} 남음"
  },
  LanguageConfig_RepairTipsContent_CN = {
    Text = "수리 기능은 다운로드된 모든 게임 리소스를 삭제합니다. 확인을 클릭하면 다시 다운로드합니다.\n게임이 정상적으로 동작하지 않거나 강제 종료되는 등의 문제가 발생할 때만 이 기능을 사용할 것을 권장합니다.\n리소스를 삭제하시겠습니까?"
  },
  LanguageConfig_RepairTipsTitle_CN = {
    Text = "리소스 복구"
  },
  LanguageConfig_Repeat_Get_Copy_Reward_CN = {
    Text = "장미 금권 효율 보상을 획득했습니다"
  },
  LanguageConfig_RepelBuff_CN = {
    Text = "<color=#FF7370>상태 해제</color>"
  },
  LanguageConfig_RepetitiveAwakerConvert_CN = {
    Text = "중복 깨어남체 변환"
  },
  LanguageConfig_ReplayLoadingTips_CN = {
    Text = "리플레이 연결 중…"
  },
  LanguageConfig_ReplayLoadingTitle_CN = {
    Text = "전투 기록"
  },
  LanguageConfig_ReplayTabRule_CN = {
    Text = "<Title:[조사 모드]>\n· 조사 활동, 어둠의 경계 및 제한 시간 게임 이벤트 등의 여건에서 조사를 완료한 후, 해당 조사 기록을 확인할 수 있습니다.\n· 실타래패한 조사 모드 도전은 기록되지 않습니다.\n· 현재는 막판 전투의 재생만 지원됩니다.\n\n<Title:[재생]>\n· 아래 입력 창에 전투 기록을 입력하여 해당 전투 재생을 시청할 수 있습니다.\n· 조사 모드 '조사 데이터', 상위 대국 '전투 정산' 등의 화면에서 전투 기록을 복사하고 다른 사람과 공유할 수 있습니다.\n· '조사 활동'과 '상위 대국'은 각각 최대 100개를 저장할 수 있으며, 기록은 최대 30일 동안 보존됩니다."
  },
  LanguageConfig_ReplayTabTitle_CN = {
    Text = "전투 기록"
  },
  LanguageConfig_ReplenishEnergy_Comfirm1_CN = {Text = "확인"},
  LanguageConfig_ReplenishEnergy_Comfirm2_CN = {Text = "교환"},
  LanguageConfig_ReplenishEnergy_ExchangeDesc1_CN = {
    Text = "사용 후, 린피테이프를 <Blue:{s1}> 만큼 회복합니다"
  },
  LanguageConfig_ReplenishEnergy_ExchangeDesc2_CN = {
    Text = "은심 <Blue:{s1}>개를 소모하여, 린피테이프 <Blue:{s2}>을(를) 회복합니다. 오늘 남은 회복 횟수: <Blue:{s3}>"
  },
  LanguageConfig_ReplenishEnergy_ExchangeSubDesc2_CN = {
    Text = "하루 보충 횟수가 많아질수록, 「은심」 소모량이 증가합니다"
  },
  LanguageConfig_ReplenishEnergy_Supplement_CN = {
    Text = "보충 방법"
  },
  LanguageConfig_ReplenishEnergy_Title_CN = {
    Text = "린피테이프 보충"
  },
  LanguageConfig_ReportTimeLimited_CN = {
    Text = "금일 신고 횟수 한도를 초과하였습니다"
  },
  LanguageConfig_ResearchComplete_CN = {
    Text = "조사 완료"
  },
  LanguageConfig_ResetTaskTimeCountdown_CN = {
    Text = "{s1}시간 {s2}분 후 초기화"
  },
  LanguageConfig_ResonanceActiveDefault_CN = {
    Text = "기본 활성화"
  },
  LanguageConfig_ResonanceActiveExtraItem_CN = {
    Text = "({s1}을 사용하여 활성화 가능)"
  },
  LanguageConfig_ResonanceActiveNoneEffectsText_CN = {
    Text = "활성화된 공명 없음"
  },
  LanguageConfig_ResonanceActiveText_CN = {Text = "활성화"},
  LanguageConfig_ResonanceArriveMaxLevelText_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_ResonanceEffectsText_CN = {
    Text = "%s(Lv.%d): %s"
  },
  LanguageConfig_ResonanceParticleTypeName_CN = {
    Text = "공명 입자"
  },
  LanguageConfig_ResonanceRelateToEvent_CN = {
    Text = "[공명] 효과 영향"
  },
  LanguageConfig_ResonanceResetCostConfirm_CN = {
    Text = "현재 스테이지의 공명 포인트를 초기화하기 위해 <color=%s>%d</color>%s를 소모하시겠습니까?"
  },
  LanguageConfig_ResonanceReset_CN = {
    Text = "공명 포인트 초기화"
  },
  LanguageConfig_ResonanceRewardTagText_CN = {
    Text = "공명 보너스"
  },
  LanguageConfig_ResonanceRules_CN = {
    Text = "1. 각 장의 조사 사건에는 공명이 있으며, 조사를 진행할 때 강력한 지원을 제공합니다.\n2. 스테이지를 최초로 클리어하면 공명 강화 재료를 획득할 수 있으며, 재료를 소모해 공명 효과를 활성화할 수 있습니다.\n3. 공명은 지도 상의 노드에 나타나며, 공명 노드로 이동하면 해당 탐사에서 공명을 획득할 수 있습니다."
  },
  LanguageConfig_ResonanceSelectCard_CN = {
    Text = "복제할 카드 1장 선택"
  },
  LanguageConfig_ResonanceText_CN = {Text = "공명"},
  LanguageConfig_ResonanceUnlockText_CN = {Text = "미개방"},
  LanguageConfig_ResonanceUnlockTips_CN = {
    Text = "{s1} 활성화 후 해금"
  },
  LanguageConfig_ResonanceUnlock_And_CN = {Text = "와/과"},
  LanguageConfig_ResonanceUnlock_Or_CN = {Text = "또는"},
  LanguageConfig_ResonanceUpgradeText_CN = {
    Text = "업그레이드"
  },
  LanguageConfig_Resonance_Group_Desc_1_CN = {
    Text = "[친절한 선물] 칸에서, 「순수한 보답」 1장을 덱에 추가합니다—— 행동력을 1 소비하고, 광기가 가장 낮은 깨어남체 하나에게 광기 30을 부여한다, 소모."
  },
  LanguageConfig_Resonance_Group_Desc_24_CN = {
    Text = "「광란의 길」 이벤트에서, 깨어남체 하나를 지정하여 정신 분열 상태로 만들어 초기 명령 카드 4장을 제거할 수 있습니다. 그 후 길이 열리며, 3가지 중 1개의 황금 유물을 획득할 수 있습니다.\n이후 4번의 「의식의 파편」 이벤트에서 잃어버린 명령 카드를 하나씩 회수할 수 있으며, 회수한 명령 카드에 고유한 각인 <EnsembleKeywords:「합주」>가 새겨집니다."
  },
  LanguageConfig_Resonance_Group_Desc_2_CN = {
    Text = "[미완성된 밀랍상] 칸에서, 카드 1장을 선택하여 행동력 소비를 1 감소시킵니다."
  },
  LanguageConfig_Resonance_Group_Desc_3_CN = {
    Text = "[기괴한 농포] 칸에서, 「변이의 심장」1장을 덱에 추가합니다. (행동력 소비 0, 사용 후 모든 손패를 버리고 카드를 (버린 카드 매수의 +1)장 뽑는다. 소모.)"
  },
  LanguageConfig_Resonance_Group_Desc_4_CN = {
    Text = "[꿀 와인] 칸에서, 「꿀 와인」1장을 덱에 추가합니다—— 행동력을 1 소비하고, 임시 장벽 1 스택 획득한다, 소모."
  },
  LanguageConfig_Resonance_Group_Desc_5_CN = {
    Text = "「침몰한 자」 및 그 이후 스테이지의 [대행의 의식] 칸에서, 「신국의 팔」효과를 획득합니다—— 턴 종료 시, 자신의 최대 HP 10%에 해당하는 피해를 전방의 적에게 가한다.\n「대행자의 판결」 1장을 덱에 추가합니다—— 행동력 소비 0, 사용 시 현재 HP의 10%를 소비하고, 「신국의 팔」이 후방의 적에게 소비한 HP의 3배 피해를 가한다. 보스 전투일 경우 10배의 피해를 가한다. 소모."
  },
  LanguageConfig_Resonance_Group_Desc_6_CN = {
    Text = "[순백의 돛] 칸에서, 「유토피아의 장막」 1장을 덱에 추가합니다—— 행동력을 1 소비하고, 장비하지 않은 은열쇠 3개를 제시한 후 1개를 선택하여 즉시 발동시킨다. 은열쇠 쿨다운이 적용되지 않는다. 보스 전투에서는 1번 더 사용할 수 있다. 소모."
  },
  LanguageConfig_Resonance_Group_Desc_7_CN = {
    Text = "시작점 근처, 특별 공명 이벤트 [잉태의 어머니] 칸에서, 명령 카드 1장을 선택하여 「잉태」각인을 새기고, 3장의 랜덤 증상 카드를 획득합니다.\n「잉태」각인: 카드가 보존을 얻고, 턴 종료 시 손패에 존재할 경우, 원본 카드의 복사본을 1장 손패에 추가하고, 보존 및 소모 효과를 추가한다."
  },
  LanguageConfig_Resonance_Group_Desc_8_CN = {
    Text = "시작점 근처, 특별 공명 이벤트 [미사그 학생증]칸에서, 「극야의 미광」1장을 덱에 추가합니다. \n「극야의 미광」: 현재 HP의 10% 소비한다. 드로우 덱 또는 버린 카드 더미의 카드 1장을 선택하여 손패에 추가하고, 그 행동력 소비를 0으로 만든다. 소모."
  },
  LanguageConfig_Resonance_Group_Desc_9_CN = {
    Text = "시작점 근처, 특별 공명 이벤트 [미사그 학생증] 칸에서, 「극야의 미광」1장을 덱에 추가하고, 제8장의 모든 보너스를 이어받습니다."
  },
  LanguageConfig_Resonance_Group_Desc_D05EX_CN = {
    Text = "초기 유물 「과학 탐사단」을 획득합니다: 초기 인원 30명. 전투 시작 시 덱에 「의심」 5장을 추가. 「의심」: 사용 시 탐사단 인원을 얼마나 소모할지 선택하여, 소모 인원에 따라 다른 효과를 얻습니다. 탐색 도중에는 끊임없이 「의심」과 관련된 선택을 마주하게 되며, 탐사단 인원이 줄어들 수 있습니다. 연락 지점을 통과하면 구조를 받을 기회도 있습니다. 철수할 때, 남아 있는 탐사단 인원 수에 따라 「구조 훈장」을 획득합니다. 철수 인원이 많을수록 「구조 훈장」의 효과가 강력해집니다."
  },
  LanguageConfig_Resonance_Group_Desc_Horla_CN = {
    Text = "탐색 시작 시 초기 유물 「오를라의 펜과 잉크」를 획득합니다: 전투가 끝나면 「펜과 잉크」 1스택을 획득하며, 「펜과 잉크」가 2스택에 도달하면 스택이 소모되고 랜덤 「이미지」 1장을 덱에 추가한다.\n특수 공명 이벤트 [봄의 선물]에서 「헌시 창작」을 선택할 수 있습니다: 「이미지」 카드 3장을 선택하여 오를라가 당신을 위한 「헌시」를 창작한다."
  },
  LanguageConfig_Resonance_Group_Desc_Lily_CN = {
    Text = "공명 이벤트 [프로듀서의 신화]에서, 「파트너에게 도움 요청」을 선택하면 고급 각인 중 하나를 선택할 수 있습니다."
  },
  LanguageConfig_Resonance_Group_Desc_MLYM_CN = {
    Text = "탐사 시작 시 3장의 강화 카드(<DerivativeCardKeywords_57:「따뜻한 가정」>, <DerivativeCardKeywords_58:「진심어린 친구」>, <DerivativeCardKeywords_59:「안정된 삶」>)를 덱에 추가합니다.\n「따뜻한 가정」: 행동력을 2pt 획득한다.\n「진심어린 친구」: 모든 적에게 허약 1, 취약 1을 부여한다.\n「안정된 삶」: 카드 2장을 뽑는다."
  },
  LanguageConfig_Resonance_Group_Desc_Railway_CN = {
    Text = "대기 중입니다."
  },
  LanguageConfig_Resonance_Group_Desc_SEWD_CN = {
    Text = "[비밀 명령 대행] 이벤트에서, 랜덤으로 사악한 유물 또는 황금 유물을 획득합니다. 「후회」 이벤트에서 사악한 유물을 축복받은 유물로 정화할 수 있고, 「구원」 이벤트에서 증상 카드를 삭제하고 보상을 획득할 수 있습니다."
  },
  LanguageConfig_Resonance_Group_Desc_Wangda_CN = {
    Text = "공명 이벤트【비밀 명령 대행】에서, 「자금 획득」을 선택하면 검은 인장 25와 랜덤 백은 유물을 획득합니다."
  },
  LanguageConfig_Resonance_Group_Desc_x1_CN = {
    Text = "공명 이벤트 [희미하게 남은 의식]에서, 「예비 뇌통」1장을 덱에 추가합니다. 「예비 뇌통」은 이전에 사용한 카드를 일시적으로 저장할 수 있으며, 상황에 따라 손으로 가져올 것인지 결정할 수 있습니다."
  },
  LanguageConfig_Resonance_Group_Desc_x2_CN = {
    Text = "「생명의 변신」 이벤트에서 깨어남체를 선택하여 「곤충」으로 전환한다.\n「곤충」의 광기 충전 및 은열쇠 충전이 50% 증가하며, 모든 명령 카드의 행동력 소모가 1 감소되고, 이는 사용 후 소모된다."
  },
  LanguageConfig_Resonance_Group_Desc_x3_CN = {
    Text = "[연회 전의 의례] 이벤트에서, 「영혼 제례 특상주」 1장을 덱에 추가합니다.\n「영혼 제례 특상주」: 모든 깨어남체의 크리티컬 확률과 크리티컬 피해를 일시적으로 10% 증가시킨다. 「영혼 제례 특상주」를 사용한 후, 재료를 1종 추가하여 영구적인 특수 효과를 추가할 수 있습니다!"
  },
  LanguageConfig_Resonance_Group_Desc_x4_CN = {
    Text = "「머피의 환영」 이벤트에서, 「순환의 그림자」 3장을 덱에 추가합니다. \n「순환의 그림자」: 사용 시, 「추억 효과」 1개를 발견하고 사용한 후, 소모된다. 여파: 모든 깨어남체가 5 광기를 획득한다."
  },
  LanguageConfig_Resonance_Group_Desc_x5_CN = {
    Text = "임시 텍스트, 스타즈 챕터 5 공명 기능 설명."
  },
  LanguageConfig_Resonance_Group_Desc_x6_CN = {
    Text = "임시 텍스트, 성진장 6공명 기능 설명."
  },
  LanguageConfig_Resonance_Group_Name_1_CN = {
    Text = "아이들의 노래"
  },
  LanguageConfig_Resonance_Group_Name_2_CN = {
    Text = "밀랍상의 수기"
  },
  LanguageConfig_Resonance_Group_Name_3_CN = {
    Text = "중얼거리는 명상"
  },
  LanguageConfig_Resonance_Group_Name_4_CN = {
    Text = "미친 학자"
  },
  LanguageConfig_Resonance_Group_Name_5_CN = {
    Text = "항해 일지"
  },
  LanguageConfig_Resonance_Group_Name_6_CN = {
    Text = "순백의 돛"
  },
  LanguageConfig_Resonance_Group_Name_7_CN = {
    Text = "무수한 자손"
  },
  LanguageConfig_Resonance_Group_Name_8_CN = {
    Text = "극야의 미광"
  },
  LanguageConfig_Resonance_Group_Name_9_CN = {
    Text = "지고의 의지"
  },
  LanguageConfig_Resonance_Group_Name_Railway_CN = {
    Text = "질주하는 환희 특급 열차"
  },
  LanguageConfig_ResurrectionCoinPurchaseTips_CN = {
    Text = "(교환 후 즉시 소모되어 소생하며, 철수 시 응급 영지체가 반환됩니다. 응급 영지체는 매주 3회 구매 한도가 있으며, 현재 남은 횟수: {s1}/3)"
  },
  LanguageConfig_ResurrectionCoinSkillDescription_CN = {
    Text = "사망 후 발동할 수 있으며, 응급 영지체 사용 후 모든 HP, 광기, 은열쇠 에너지를 회복하고 해당 턴 동안 이후의 모든 피해에 면역이 된다."
  },
  LanguageConfig_Resurrection_CN = {Text = "부활"},
  LanguageConfig_ReturnEventRewardButtonText_CN = {
    Text = "재시작 보급"
  },
  LanguageConfig_ReturnEventRewardSenderText_CN = {Text = "——돌"},
  LanguageConfig_ReturnEventRewardText_CN = {
    Text = "융식과 맞서는 미션은 미지로 향하는 되돌아올 수 없는 길이며, 그 길 위에는 수많은 함정과 위기가 도사리고 있습니다.\n또한 「세계를 구하는 것」은 너무 장대하고, 쉽게 자신을 잃게 만드는 과제이기도 합니다. 미사그 대학의 역사 속에서, 많은 젊은 조사자들이 사명감에 현혹되어 이성을 잃고 스스로를 불태워버린 사례가 있습니다.\n그러므로 잠시 휴식을 결정한 당신을 우리는 모두 다행스럽게 생각합니다. 또다시 수호자를 잃을 여유는 없습니다.\n인사말은 여기까지 하겠습니다. 당신이 신속히 조사 가능한 상태로 돌아올 수 있도록, 제가 재활 훈련 프로그램을 하나 마련했습니다. 그대로 따라 하고, 결과를 가지고 저를 찾아오면 제가 보상을 준비하겠습니다.\n덧붙여, 라모나가 당신을 위해 몇 가지 「작은 선물」을 준비했습니다. 그녀가 많이 보고 싶어 합니다."
  },
  LanguageConfig_ReturnEventRewardTitleText_CN = {
    Text = "다시 시작하는 미지의 여정"
  },
  LanguageConfig_Revive_Tips_CN = {
    Text = "<RedQuality:응급 영지체>가 활성화되었습니다.\n깨어남체의 전투 능력이 회복되었습니다.\n마지막 기회를 잡으세요!"
  },
  LanguageConfig_RewardItemAccelerateTag_CN = {Text = "가속"},
  LanguageConfig_RoleDayExpLimit_CN = {
    Text = "오늘의 경험치 제한"
  },
  LanguageConfig_RoleDetailsAttributeLevelUp_Btn_LevelUpLimit_CN = {
    Text = "최대로 강화"
  },
  LanguageConfig_RoleDetailsAttributeLevelUp_Btn_LevelUp_CN = {
    Text = "1레벨 강화"
  },
  LanguageConfig_RoleDetailsAttributeLevelUp_Str_LimitTip_CN = {
    Text = "최대 레벨 도달"
  },
  LanguageConfig_RoleDetailsEquipDetails_Btn_Change_CN = {Text = "교체"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_LevelUp_CN = {Text = "강화"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_PutOn_CN = {Text = "장비"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_Remove_CN = {Text = "해제"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_Replace_CN = {Text = "교체"},
  LanguageConfig_RoleDetailsSkillLevelUp_Btn_Determine_CN = {
    Text = "업그레이드"
  },
  LanguageConfig_RoleDetailsSkill_Str_AbilitySkill_CN = {
    Text = "영지 깨어남"
  },
  LanguageConfig_RoleDetails_Str_DBG_CN = {
    Text = "조사 모드"
  },
  LanguageConfig_RoleDetails_Str_RPG_CN = {
    Text = "도전 모드"
  },
  LanguageConfig_RoleInterfaceSort_Str_AtkType_CN = {Text = "공격"},
  LanguageConfig_RoleInterfaceSort_Str_Atk_CN = {
    Text = "공격 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_DefType_CN = {Text = "방어"},
  LanguageConfig_RoleInterfaceSort_Str_Def_CN = {
    Text = "방어 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Favorability_CN = {
    Text = "동조율 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Hp_CN = {
    Text = "체력 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Level_CN = {Text = "Lv. {s1}"},
  LanguageConfig_RoleInterfaceSort_Str_Potency_CN = {
    Text = "계령 {s1}/{s2}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Score_CN = {
    Text = "전투력 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_SupType_CN = {Text = "특수"},
  LanguageConfig_RoleInterface_Btn_Determine_CN = {Text = "닫기"},
  LanguageConfig_RoleInterface_SortTypeBtn_Atk_CN = {Text = "공격"},
  LanguageConfig_RoleInterface_SortTypeBtn_Collection_CN = {Text = "수집"},
  LanguageConfig_RoleInterface_SortTypeBtn_Def_CN = {Text = "방어"},
  LanguageConfig_RoleInterface_SortTypeBtn_Favorability_CN = {Text = "동조율"},
  LanguageConfig_RoleInterface_SortTypeBtn_Hp_CN = {Text = "체력"},
  LanguageConfig_RoleInterface_SortTypeBtn_Level_CN = {Text = "레벨"},
  LanguageConfig_RoleInterface_SortTypeBtn_Potency_CN = {Text = "계령"},
  LanguageConfig_RoleInterface_SortTypeBtn_Score_CN = {Text = "전투력"},
  LanguageConfig_RoleInterface_SortTypeBtn_Star_CN = {Text = "희귀도"},
  LanguageConfig_RoleInterface_SortTypeBtn_Type_CN = {Text = "영역"},
  LanguageConfig_RoleInterface_Str_Tips_CN = {
    Text = "해당 영역에 사용할 수 있는 깨어남체가 없습니다"
  },
  LanguageConfig_RoleInterface_Str_Title_CN = {
    Text = "모든 영역"
  },
  LanguageConfig_RootSedimentShopRules_CN = {
    Text = "1. 수호자는 일정량의 「근원 침전물」을 소모하여 상품을 교환할 수 있습니다.\n2. 수호자 조사 레벨이 상승하면, 침전 교환 상점에 새로운 상품이 해금됩니다.\n3. 침전 교환 상점 상품은 일정 시간마다 자동으로 재고가 갱신됩니다.\n4. 수호자는 깨어남을 통해 「근원 침전물」을 획득할 수 있습니다."
  },
  LanguageConfig_RuleTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_RulesOfPlay_CN = {
    Text = "환몽 심잠"
  },
  LanguageConfig_RuneGain_Title_CN = {
    Text = "각인을 새길 카드 1장 선택"
  },
  LanguageConfig_SDKLogining_CN = {
    Text = "“사용자 센터” 로그인 중입니다. 잠시만 기다려 주세요."
  },
  LanguageConfig_SEWDResonance1_1_CN = {
    Text = "랜덤 사악한 유물 획득"
  },
  LanguageConfig_SEWDResonance1_2_CN = {
    Text = "3개 중 1개의 사악한 유물 획득"
  },
  LanguageConfig_SaleSuccessful_CN = {
    Text = "판매 완료"
  },
  LanguageConfig_SalvadorStageUnlockDesc_CN = {
    Text = "선행 스테이지를 완료하여 특파 기록 해제"
  },
  LanguageConfig_SchoolNotAagreeWith_CN = {
    Text = "영역 충돌"
  },
  LanguageConfig_SchoolRequired_CN = {
    Text = "영역 요구사항"
  },
  LanguageConfig_SchoolTaskLabel_CN = {
    Text = "영역 숙련"
  },
  LanguageConfig_SchoolTowerChallengeLockTips_CN = {
    Text = "이전 스테이지를 완료하여 해제하세요"
  },
  LanguageConfig_SchoolTowerChallengeNotReachLevelTips_CN = {
    Text = "도전에 필요한 레벨이 부족합니다"
  },
  LanguageConfig_SchoolTowerRuleTxt_CN = {
    Text = "<Title:무광의 영역>\n·무광의 영역은 난이도가 높은 여러 스테이지로 구성되어 있습니다. 스테이지를 통과하면 풍부한 보상을 획득할 수 있습니다. 또한, 누적 스테이지 평가를 일정량 달성할 때마다 추가 보상을 획득할 수 있습니다.\n\n<Title:조사 요구 조건>\n·무광의 영역 스테이지에서는 지정된 영역과 인원 수의 깨어남체를 사용하여 조사를 수행해야 합니다. 수호자는 스테이지 상세 정보 및 파티 구성 화면에서 요구 조건을 확인할 수 있습니다.\n\n<Title:초기 유물>\n·무광의 영역 스테이지에는 고유한 유물이 존재하며, 해당 유물은 각 스테이지에서만 효과가 적용됩니다. 유물의 효과를 적절히 활용하면 조사를 더욱 효율적으로 진행할 수 있을 것입니다."
  },
  LanguageConfig_SchoolTowerTeamBuildFobiddenTips_CN = {
    Text = "파티가 요구 조건을 만족하지 않았습니다."
  },
  LanguageConfig_School_Activate_CN = {
    Text = "활성화됨"
  },
  LanguageConfig_School_Blood_Content_String_CN = {
    Text = "· 턴 시작 시 <CardKeyWord:배아 융합>이 20% (체력 손실타래에 따라 최대 40%까지) 증가하고, 100%에 도달하면 <CardKeyWord:「배아」> 1장을 손패에 추가합니다.\n· 혈육 영역의 「광기 폭발」은 <CardKeyWord:「배아」>를 소모하여 <CardKeyWord:포식> 효과를 발동할 수 있으며, 매 턴 처음으로 포식을 발동할 때 최대 HP의 2%에 해당하는 방어막과 1%에 해당하는 임시 힘을 획득합니다. (잃은 HP에 비례하여 최대 2배까지 증가)"
  },
  LanguageConfig_School_Blood_Title_String_CN = {
    Text = "피의 제물"
  },
  LanguageConfig_School_Chaos_Content_String_CN = {
    Text = "· 혼돈 영역의 깨어남체는 영역 제한을 받지 않고 다른 영역 깨어남체와 함께 배치할 수 있습니다. \n· 파티에 혼돈 깨어남체가 존재할 경우, 추가로 100%의 죽음 저항을 획득합니다. \n· 턴 종료 시 및 「광기 폭발」 발동 후, <CardKeyWord:은열쇠 에너지>가 50 증가합니다."
  },
  LanguageConfig_School_Chaos_Title_String_CN = {
    Text = "우주 만상"
  },
  LanguageConfig_School_Dimension_Content_String_CN = {
    Text = "· 매 턴 첫 번째로 사용한 명령 카드의 임시 복사본이 <CardKeyWord:초차원 공간>에 추가되어 그 워프 효과를 발동합니다.\n· 초차원 공간이 가득 차면 추가 초차원 턴에 진입할 수 있으며, 해당 턴에는 일반적인 카드 뽑기를 하지 않고 대신 초차원 공간의 카드를 손패에 추가합니다. 초차원 턴에는 모든 워프 효과를 발동할 수 있습니다."
  },
  LanguageConfig_School_Dimension_Title_String_CN = {
    Text = "차원 도약"
  },
  LanguageConfig_School_Ocean_Content_String_CN = {
    Text = "· 전투 시작 시 촉수를 1개 생성하며, 촉수는 턴 종료 시 전방의 적을 공격합니다. \n· 광기 폭발을 사용할 때마다 턴 종료 시 촉수가 추가로 1회 공격합니다. \n· 힘을 3pt 얻을 때마다 촉수 피해가 1pt 상승하며, 힘이 3pt 감소할 때마다 촉수 피해가 1pt 감소합니다."
  },
  LanguageConfig_School_Ocean_Title_String_CN = {
    Text = "심연의 접촉"
  },
  LanguageConfig_School_Tips_String_CN = {
    Text = "조사 모드에서는, 파티에 포함된 깨어남체의 영역에 따라 영역 특성이 활성화됩니다."
  },
  LanguageConfig_School_Title_String_CN = {
    Text = "영역 특성"
  },
  LanguageConfig_ScoreAchieveNum_CN = {
    Text = "환몽 심잠 최고 기록: {s1}"
  },
  LanguageConfig_ScoreAchieveTitle_CN = {
    Text = "환몽 심잠 기록"
  },
  LanguageConfig_ScoreMaxTo_CN = {
    Text = "환몽 심잠 최고 기록"
  },
  LanguageConfig_ScoreMultipleDesc_CN = {
    Text = "(총 평점은 다음 항목의 합계 x{s1}입니다)"
  },
  LanguageConfig_ScoreReachTile_CN = {
    Text = "주간 시련"
  },
  LanguageConfig_ScoreReachTo_CN = {
    Text = "누적된 점수"
  },
  LanguageConfig_ScoreSumDesc_CN = {
    Text = "(총 평점은 다음 합계입니다)"
  },
  LanguageConfig_SeasonDesc_0_CN = {
    Text = "시즌 0 설명"
  },
  LanguageConfig_SeasonDesc_1_CN = {
    Text = "시즌 1 설명"
  },
  LanguageConfig_SeasonDesc_2_CN = {
    Text = "시즌 2 설명"
  },
  LanguageConfig_SeasonDesc_3_CN = {
    Text = "시즌 3 설명"
  },
  LanguageConfig_SeasonDesc_4_CN = {
    Text = "시즌 4 설명"
  },
  LanguageConfig_SeasonName_0_CN = {
    Text = "시즌 0 이름"
  },
  LanguageConfig_SeasonName_1_CN = {
    Text = "시즌 1 이름"
  },
  LanguageConfig_SeasonName_2_CN = {
    Text = "시즌 2 이름"
  },
  LanguageConfig_SeasonName_3_CN = {
    Text = "시즌 3 이름"
  },
  LanguageConfig_SeasonName_4_CN = {
    Text = "시즌 4 이름"
  },
  LanguageConfig_SeasonRankListSettlementNotice1_CN = {
    Text = "이번 시즌은 {s1}일 {s2}시간 후 랭킹 보상이 정산됩니다"
  },
  LanguageConfig_SeasonRankListSettlementNotice2_CN = {
    Text = "이번 시즌은 {s1}시간 {s2}분 후 랭킹 보상이 정산됩니다"
  },
  LanguageConfig_SecondAnniversaryDailyGainAbleTip_CN = {
    Text = "수령 가능"
  },
  LanguageConfig_SecondAnniversaryDailyReward_CN = {
    Text = "일일 캠퍼스 고양이 증정"
  },
  LanguageConfig_SecondAnniversaryDailyTimeAlert_CN = {
    Text = "카운트다운 {s1} 후 수령 가능"
  },
  LanguageConfig_SecondAnniversarySevenDaySign_CN = {
    Text = "캠퍼스 고양이의 7일 보상"
  },
  LanguageConfig_SecondAnniversaryShopName_CN = {
    Text = "캠퍼스 고양이의 미니 마켓"
  },
  LanguageConfig_Second_CN = {Text = "초"},
  LanguageConfig_SelectAllAwaker_CN = {
    Text = "전체 선택"
  },
  LanguageConfig_SelectItemToDecompose_CN = {
    Text = "왼쪽에서 분해할 재료를 선택"
  },
  LanguageConfig_SelectKeeperSkillToUse_Title1_CN = {
    Text = "발동할 은열쇠를 선택하세요"
  },
  LanguageConfig_SelectKeeperSkill_Title1_CN = {
    Text = "은열쇠를 선택하세요"
  },
  LanguageConfig_SelectOneWheelEquipment_CN = {
    Text = "명륜 장비 1개 선택"
  },
  LanguageConfig_SelectTrinketHave_CN = {Text = "있음"},
  LanguageConfig_SelectTrinketMainAttr_CN = {
    Text = "주 속성 선택"
  },
  LanguageConfig_SelectTrinketNo_CN = {Text = "없음"},
  LanguageConfig_SelectTrinketSubAttr_CN = {
    Text = "부 속성 선택"
  },
  LanguageConfig_SelectTrinketSuit_CN = {
    Text = "세트 선택"
  },
  LanguageConfig_Select_yixiangCard_CN = {
    Text = "이미지 3장을 선택하여 헌시 작성"
  },
  LanguageConfig_SelectedSpecNumAwakers_CN = {
    Text = "{s1}개의 깨어남체를 선택해주세요"
  },
  LanguageConfig_ServerWideKilledMonstersCount_CN = {
    Text = "모든 차원에서 <color=#5EF2FF>{s1}</color> 체를 격퇴했습니다"
  },
  LanguageConfig_Server_Closed_CN = {
    Text = "캠퍼스를 열심히 가꾸고 있습니다, 점검이 끝날 때까지 기다려주세요."
  },
  LanguageConfig_Server_Stop_Confirm_CN = {Text = "확인"},
  LanguageConfig_Server_Stop_Desc_CN = {
    Text = "서버 연결이 끊겼습니다, 로그인 화면으로 돌아갑니다."
  },
  LanguageConfig_Server_Stop_Tittle_CN = {
    Text = "연결이 끊겼습니다"
  },
  LanguageConfig_Server_Warn_10_CN = {
    Text = "해당 비경을 찾을 수 없습니다"
  },
  LanguageConfig_Server_Warn_11_CN = {
    Text = "비경 이벤트 완료됨"
  },
  LanguageConfig_Server_Warn_12_CN = {
    Text = "비경 이벤트 설정 타입이 잘못 입력되었습니다"
  },
  LanguageConfig_Server_Warn_13_CN = {
    Text = "비경 이벤트가 없습니다"
  },
  LanguageConfig_Server_Warn_14_CN = {
    Text = "검은 인장이 부족하여 구매할 수 없습니다"
  },
  LanguageConfig_Server_Warn_15_CN = {
    Text = "해당 카드는 강화할 수 없습니다"
  },
  LanguageConfig_Server_Warn_16_CN = {
    Text = "해당 카드는 더 이상 강화할 수 없습니다"
  },
  LanguageConfig_Server_Warn_17_CN = {
    Text = "이 상인은 해당 상품을 판매하지 않습니다"
  },
  LanguageConfig_Server_Warn_18_CN = {
    Text = "해당 보상이 존재하지 않습니다"
  },
  LanguageConfig_Server_Warn_19_CN = {
    Text = "보상 수령 완료"
  },
  LanguageConfig_Server_Warn_1_CN = {
    Text = "작업 성공"
  },
  LanguageConfig_Server_Warn_20_CN = {
    Text = "이벤트 데이터 오류"
  },
  LanguageConfig_Server_Warn_21_CN = {
    Text = "상품 구매 성공"
  },
  LanguageConfig_Server_Warn_22_CN = {
    Text = "과제 유닛 데이터를 찾지 못했습니다"
  },
  LanguageConfig_Server_Warn_23_CN = {
    Text = "유닛이 이미 제출되었습니다, 다시 제출할 필요는 없습니다."
  },
  LanguageConfig_Server_Warn_24_CN = {
    Text = "유닛의 과제가 아직 전부 완료되지 않았습니다, 제출할 수 없습니다."
  },
  LanguageConfig_Server_Warn_25_CN = {
    Text = "과제 모듈이 존재하지 않습니다"
  },
  LanguageConfig_Server_Warn_26_CN = {
    Text = "레벨 데이터가 존재하지 않습니다"
  },
  LanguageConfig_Server_Warn_2_CN = {
    Text = "설정표 오류"
  },
  LanguageConfig_Server_Warn_3_CN = {
    Text = "클라이언트 데이터 입력 오류"
  },
  LanguageConfig_Server_Warn_4_CN = {
    Text = "서비스가 아직 준비 중입니다"
  },
  LanguageConfig_Server_Warn_5_CN = {
    Text = "캐릭터 데이터 오류"
  },
  LanguageConfig_Server_Warn_6_CN = {
    Text = "캐릭터가 존재하지 않아, 새로 생성해야 합니다"
  },
  LanguageConfig_Server_Warn_7_CN = {
    Text = "캐릭터가 이미 존재해, 새로 생성하지 않아도 무관합니다"
  },
  LanguageConfig_Server_Warn_8_CN = {
    Text = "캐릭터 이름 중복"
  },
  LanguageConfig_Server_Warn_9_CN = {
    Text = "비경 오류"
  },
  LanguageConfig_Service_Not_Errcode_CN = {
    Text = "기능 힌트: 힌트 코드를 찾을 수 없습니다"
  },
  LanguageConfig_Service_Tips_11859_CN = {
    Text = "건물 해제 조건 미충족"
  },
  LanguageConfig_Service_Tips_11860_CN = {
    Text = "건물 업그레이드 조건 미충족"
  },
  LanguageConfig_Service_Tips_11861_CN = {
    Text = "건물 업그레이드 재료 부족"
  },
  LanguageConfig_Service_Tips_71_CN = {
    Text = "사용 조건 미충족"
  },
  LanguageConfig_SetLogInReward_MOBILE_Tips_CN = {
    Text = "모바일 기기로 로그인하기"
  },
  LanguageConfig_SetLogInReward_PC_Tips_CN = {
    Text = "PC 장비로 로그인하기"
  },
  LanguageConfig_SetLogInReward_Tips_CN = {
    Text = "다양한 플랫폼 로그인 시 한정 아바타 등의 보상을 받을 수 있습니다"
  },
  LanguageConfig_SettingPanelTitle_CN = {Text = "설정"},
  LanguageConfig_SettingToggleClose_CN = {Text = "Off"},
  LanguageConfig_SettingToggleOpen_CN = {Text = "On"},
  LanguageConfig_ShareFacebookText_CN = {
    Text = "망각전야/모리멘스에서 {s1}을(를) 뽑았어요. 와서 보세요!"
  },
  LanguageConfig_ShareLineText_CN = {
    Text = "망각전야/모리멘스에서 {s1}을(를) 뽑았어요. 와서 보세요!"
  },
  LanguageConfig_ShareTwitterText_CN = {
    Text = "망각전야/모리멘스에서 {s1}을(를) 뽑았어요. 와서 보세요!"
  },
  LanguageConfig_ShenGuoShangFu_01_CN = {
    Text = "모든 바다 괴물을 처치하면 최종 보스가 등장합니다!"
  },
  LanguageConfig_Shield_Break_CN = {
    Text = "방어막 파괴"
  },
  LanguageConfig_ShopChargeDesc_CN = {
    Text = "{s2} {s1}방울"
  },
  LanguageConfig_ShopConfirmExchange_CN = {
    Text = "교환 확인"
  },
  LanguageConfig_ShopEnchantGiftText_CN = {Text = "선물"},
  LanguageConfig_ShopExchangeQuantity_CN = {
    Text = "교환 수량"
  },
  LanguageConfig_ShopItem_Str_Free_CN = {Text = "무료"},
  LanguageConfig_ShopLimitTimeActivity_CN = {Text = "한정"},
  LanguageConfig_ShopNameDefault_CN = {
    Text = "미사그 상점"
  },
  LanguageConfig_ShopName_ActivityShop10_CN = {Text = "메아리"},
  LanguageConfig_ShopName_ActivityShop11_CN = {
    Text = "심연 속 깨달음"
  },
  LanguageConfig_ShopName_ActivityShop12_CN = {
    Text = "지식에 대한 열망"
  },
  LanguageConfig_ShopName_ActivityShop13_CN = {
    Text = "제물 바치기"
  },
  LanguageConfig_ShopName_ActivityShop15_CN = {
    Text = "학생회관"
  },
  LanguageConfig_ShopName_ActivityShop16_CN = {
    Text = "은밀한 거점"
  },
  LanguageConfig_ShopName_ActivityShop17_CN = {
    Text = "무셰트의 오두막집"
  },
  LanguageConfig_ShopName_ActivityShop18_CN = {
    Text = "무변의 수렵장"
  },
  LanguageConfig_ShopName_ActivityShop19_CN = {
    Text = "투기장 제단"
  },
  LanguageConfig_ShopName_ActivityShop20_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_ShopName_ActivityShop2_CN = {
    Text = "인격 해석"
  },
  LanguageConfig_ShopName_ActivityShop3_CN = {
    Text = "마법 각본 상점"
  },
  LanguageConfig_ShopName_ActivityShop4_CN = {
    Text = "황금 장미의 축제"
  },
  LanguageConfig_ShopName_ActivityShop5_CN = {
    Text = "성태 부화"
  },
  LanguageConfig_ShopName_ActivityShop6_CN = {
    Text = "럭키 클럽"
  },
  LanguageConfig_ShopName_ActivityShop7_CN = {
    Text = "고요한 잠의 궁전"
  },
  LanguageConfig_ShopName_ActivityShop8_CN = {
    Text = "인격 해석"
  },
  LanguageConfig_ShopName_ActivityShop9_CN = {
    Text = "완다의 보물상자"
  },
  LanguageConfig_ShopName_ReturnCoinShop_CN = {
    Text = "복학 상점"
  },
  LanguageConfig_Shop_Batch_Buy_Btn_CN = {
    Text = "일괄 구매 {s1}"
  },
  LanguageConfig_Shop_Buy_Btn_CN = {Text = "구매"},
  LanguageConfig_Shop_Buy_Lack_Arena_Money_CN = {
    Text = "아레나 코인이 부족합니다"
  },
  LanguageConfig_Shop_Buy_Lack_Money_CN = {
    Text = "{s1} 부족"
  },
  LanguageConfig_Shop_Buy_Str_BuyLimit_CN = {
    Text = "잔여: {s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Btn_Back_CN = {Text = "취소"},
  LanguageConfig_Shop_Confirm_Buy_Btn_Sure_CN = {Text = "확인"},
  LanguageConfig_Shop_Confirm_Buy_Str_Need_Arena_Money_CN = {
    Text = "아레나 코인 소모 {s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Need_Money_CN = {
    Text = "소모 {s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Now_Arena_Money_CN = {
    Text = "현재 아레나 코인 {s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Now_Money_CN = {
    Text = "현재 {s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Tips_CN = {
    Text = "{s1}를 사용하여 다음 아이템을 구매하시겠습니까?"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Title_CN = {
    Text = "구매 확인"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Arena_Money_Tips_CN = {
    Text = "아레나 코인이 부족합니다"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Lack_Money_Tips_CN = {
    Text = "장미 금권이 부족합니다"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Money_Tips_CN = {
    Text = "다음 아이템 사용"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Tips_CN = {
    Text = "상점 목록을 초기화하시겠습니까?"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Title_CN = {
    Text = "초기화 확인"
  },
  LanguageConfig_Shop_GiftBag_Exchange_CN = {Text = "교환"},
  LanguageConfig_Shop_Now_Num_Goods_Str_CN = {
    Text = "보유 수: {s1}"
  },
  LanguageConfig_Shop_Refresh_Cost_Text_CN = {
    Text = "검은 인장 {s1} 소모"
  },
  LanguageConfig_Shop_Remove_Btn_Select_CN = {
    Text = "선택 해제"
  },
  LanguageConfig_Shop_Revert_Btn_Price_CN = {
    Text = "{s1}로 즉시 재설정하기"
  },
  LanguageConfig_Shop_Revert_Button_Text_CN = {
    Text = "즉시 재설정"
  },
  LanguageConfig_Shop_Revert_Str_Next_Time_CN = {
    Text = "초기화까지: {s1}"
  },
  LanguageConfig_Shop_Sell_Out_Tips_CN = {Text = "품절"},
  LanguageConfig_ShortDaysDisplay_CN = {Text = "{s1}일"},
  LanguageConfig_ShortHourDisplay_CN = {Text = "{s1}시"},
  LanguageConfig_SinRelicTypeName_CN = {
    Text = "<RedRelic:사악한 유물>"
  },
  LanguageConfig_SkillActivated_CN = {Text = "활성화"},
  LanguageConfig_SkillDetailedInformation_CN = {
    Text = "상세 정보"
  },
  LanguageConfig_SkillLevelExUpgrade_CN = {
    Text = "<AwakerSkill:스킬 레벨 +{s1}>"
  },
  LanguageConfig_SkillLevelUp_NeedAwakerLevel_CN = {
    Text = "깨어남체 레벨 <Color4:{s1}> 필요"
  },
  LanguageConfig_SkillMaterialTypeName_CN = {
    Text = "스킬 재료"
  },
  LanguageConfig_SkillNotActivated_CN = {
    Text = "미활성화"
  },
  LanguageConfig_SkillStowInformation_CN = {
    Text = "정보 숨기기"
  },
  LanguageConfig_SkillUpgradeInsufficientMaterial_CN = {
    Text = "스킬 업그레이드 소재 부족"
  },
  LanguageConfig_Skill_LevelUp_Success_CN = {
    Text = "스킬 레벨 상승"
  },
  LanguageConfig_SkinTurntableActivityDesc1_CN = {
    Text = "<color=#e3c96e>{s1}</color>회 더 뽑으면 4성 의상 획득 확률 발생"
  },
  LanguageConfig_SkinTurntableActivityDesc2_CN = {
    Text = "이번 추첨에서 <color=#e3c96e>{s1}%</color> 확률로 4성 의상 획득 가능"
  },
  LanguageConfig_SkinTurntableActivityDesc3_CN = {
    Text = "남은 보상을 얻기 위해 계속 추출"
  },
  LanguageConfig_SmallPotencyDesc_CN = {
    Text = "부가 계령 (쓰이지 않음)"
  },
  LanguageConfig_SmallPotencyTitle_CN = {Text = "공용"},
  LanguageConfig_SmallSubplotTipsText_CN = {
    Text = "<Title:[의식 잠항]>\n1. 일부 의식 잠항은 다음 조건을 충족해야 진행할 수 있습니다.\n· 선행 조사 미션 완료\n· 지정된 수량의 '현실타래의 기점'을 소모하여 해제\n2. 의식 잠항이 기간 한정 이벤트 중일 경우, '현실타래의 기점'소모하지 않고 무료로 해제 가능합니다. 이벤트 종료 후 조사 진행도는 유지됩니다.\n3. 의식 잠항 조사 미션 완료 시 무구의 은핵, 수호자 경험치, 조사 배지 등의 보상을 획득할 수 있다."
  },
  LanguageConfig_SmallSubplotTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_SmallSubplotTitle_CN = {
    Text = "의식 잠항"
  },
  LanguageConfig_SocialChangeAvatarFrameBtnTxt_CN = {
    Text = "프로필 프레임 변경"
  },
  LanguageConfig_SocialOnlineTimeLabel_CN = {
    Text = "로그인 시간"
  },
  LanguageConfig_SocialSourcePanelAccelerateTips_CN = {
    Text = "경험치 부스트 {s1}%"
  },
  LanguageConfig_SocialSystemAccumulatedRatingThisWeek_CN = {
    Text = "이번 주 누적 평점"
  },
  LanguageConfig_SocialSystemAddNewFans_CN = {
    Text = "신규 팔로워"
  },
  LanguageConfig_SocialSystemBirthday_CN = {
    Text = "{s1}월 {s2}일"
  },
  LanguageConfig_SocialSystemCancelCommonUseBattleHelp_CN = {
    Text = "주 이용 조력 해제"
  },
  LanguageConfig_SocialSystemCancelFollow_CN = {
    Text = "팔로우 해제"
  },
  LanguageConfig_SocialSystemCannotSearchForOneself_CN = {
    Text = "자기 자신을 검색할 수는 없습니다"
  },
  LanguageConfig_SocialSystemChangeAvatar_CN = {
    Text = "프로필 아이콘 변경"
  },
  LanguageConfig_SocialSystemChangeBatch_CN = {Text = "갱신"},
  LanguageConfig_SocialSystemCommonUseBattleHelp_CN = {
    Text = "주 이용 조력 설정"
  },
  LanguageConfig_SocialSystemCommunity_CN = {
    Text = "커뮤니티"
  },
  LanguageConfig_SocialSystemCoolDown_CN = {
    Text = "대기 시간: {s1}초"
  },
  LanguageConfig_SocialSystemEnterNoteName_CN = {
    Text = "별명 입력"
  },
  LanguageConfig_SocialSystemEnterUID_CN = {Text = "UID 입력"},
  LanguageConfig_SocialSystemFansEmptyStatusDesc_CN = {
    Text = "당신을 발견할 수호자가 언젠가 나타날 것입니다..."
  },
  LanguageConfig_SocialSystemFansEmptyStatusTitle_CN = {
    Text = "팔로워 없음"
  },
  LanguageConfig_SocialSystemFans_CN = {Text = "팔로워"},
  LanguageConfig_SocialSystemFollowEmptyStatusDesc_CN = {
    Text = "더 많은 수호자들을 팔로우해 보세요!"
  },
  LanguageConfig_SocialSystemFollowEmptyStatusTitle_CN = {
    Text = "팔로우 없음"
  },
  LanguageConfig_SocialSystemFollow_CN = {Text = "팔로우"},
  LanguageConfig_SocialSystemFollowed_CN = {
    Text = "팔로우 중"
  },
  LanguageConfig_SocialSystemHighestRecord_CN = {
    Text = "최고 기록"
  },
  LanguageConfig_SocialSystemHighestTitle_CN = {
    Text = "최고 칭호"
  },
  LanguageConfig_SocialSystemInterrelated_CN = {
    Text = "맞팔로우"
  },
  LanguageConfig_SocialSystemIntroductionNone_CN = {
    Text = "설명 없음"
  },
  LanguageConfig_SocialSystemIntroductionNotYetEdited_CN = {
    Text = "선택하여 설명 입력"
  },
  LanguageConfig_SocialSystemIntroduction_CN = {
    Text = "프로필 편집"
  },
  LanguageConfig_SocialSystemInvitation_CN = {Text = "초대"},
  LanguageConfig_SocialSystemJustVisited_CN = {
    Text = "방금 방문"
  },
  LanguageConfig_SocialSystemLeaveNoteName_CN = {
    Text = "[{s1}]의 별명 설정하기, 팔로우 해제 시 별명 삭제"
  },
  LanguageConfig_SocialSystemLikeEmptyStatusDesc_CN = {
    Text = "더 많은 수호자들에게 좋아요를 눌러주세요"
  },
  LanguageConfig_SocialSystemLikeHistory_CN = {
    Text = "좋아요 기록"
  },
  LanguageConfig_SocialSystemLookupEmptyStatusDesc_CN = {
    Text = "클릭하여 목록을 갱신하고, 더 많은 수호자들을 만나보세요"
  },
  LanguageConfig_SocialSystemLookupEmptyStatusTitle_CN = {
    Text = "낯선 사람이 없습니다"
  },
  LanguageConfig_SocialSystemLookup_CN = {Text = "검색"},
  LanguageConfig_SocialSystemMainLineMadness_CN = {Text = "광란"},
  LanguageConfig_SocialSystemModifyRemarks_CN = {
    Text = "메모 수정"
  },
  LanguageConfig_SocialSystemNewAddition_CN = {Text = "New"},
  LanguageConfig_SocialSystemNewFansTip_CN = {
    Text = "최근 추가된 {s1}명의 추종자를 확인할 수 있습니다"
  },
  LanguageConfig_SocialSystemNoFoundInTheSearch_CN = {
    Text = "다른 수호자를 찾을 수 없습니다"
  },
  LanguageConfig_SocialSystemRank_CN = {Text = "랭킹"},
  LanguageConfig_SocialSystemSchoolTowerGap_CN = {
    Text = "무광의 영역"
  },
  LanguageConfig_SocialSystemSchoolTowerWheelGap_CN = {
    Text = "무광의 영역: 회전 영역"
  },
  LanguageConfig_SocialSystemSearchPlayers_CN = {
    Text = "UID로 검색"
  },
  LanguageConfig_SocialSystemSearchResult_CN = {
    Text = "검색 결과"
  },
  LanguageConfig_SocialSystemSearch_CN = {Text = "검색"},
  LanguageConfig_SocialSystemSetBirthday_CN = {
    Text = "생일 설정"
  },
  LanguageConfig_SocialSystemSetRemarks_CN = {
    Text = "메모 설정"
  },
  LanguageConfig_SocialSystemSocialInteraction_CN = {Text = "동창회"},
  LanguageConfig_SocialSystemStranger_CN = {
    Text = "낯선 사람"
  },
  LanguageConfig_SocialSystemStrollingAround_CN = {
    Text = "산책 중..."
  },
  LanguageConfig_SocialSystemSurveyProgress_CN = {
    Text = "조사 작전"
  },
  LanguageConfig_SocialSystemVisitedDaysAgo_CN = {
    Text = "{s1}일 전 방문"
  },
  LanguageConfig_SocialSystemVisitedHoursAgo_CN = {
    Text = "{s1}시간 전 방문"
  },
  LanguageConfig_SocialSystemVisitedMinutesAgo_CN = {
    Text = "{s1}분 전 방문"
  },
  LanguageConfig_SocialSystemVisitorEmptyStatusDesc_CN = {
    Text = "다른 수호자들이 발자국을 남기는 것을 기다립니다"
  },
  LanguageConfig_SocialSystemVisitorEmptyStatusTitle_CN = {
    Text = "방문자 없음"
  },
  LanguageConfig_SocialSystemVisitor_CN = {Text = "방문자"},
  LanguageConfig_SocialUnfollowedFans_CN = {
    Text = "미팔로우"
  },
  LanguageConfig_SocializeAdmireReason_CN = {
    Text = "{s1}로부터"
  },
  LanguageConfig_SocializeAdmireTime_Day_CN = {
    Text = "{s1}일 전에 좋아요 누름"
  },
  LanguageConfig_SocializeAdmireTime_Hour_CN = {
    Text = "{s1}시간 전에 좋아요 누름"
  },
  LanguageConfig_SocializeAdmireTime_JustNow_CN = {
    Text = "방금 좋아요를 눌렀습니다"
  },
  LanguageConfig_SocializeAdmireTime_Minute_CN = {
    Text = "방금 좋아요 누름"
  },
  LanguageConfig_SocializeAwakerLevel_CN = {
    Text = "깨어남체 레벨"
  },
  LanguageConfig_SocializeBatchCancel_CN = {
    Text = "일괄 구독 취소"
  },
  LanguageConfig_SocializeExitCancel_CN = {
    Text = "구독 해제"
  },
  LanguageConfig_SocializeFinishCancel_CN = {
    Text = "구독 해제 완료"
  },
  LanguageConfig_SocializeOnLineState_Activity_CN = {
    Text = "이벤트에 참여하는 중..."
  },
  LanguageConfig_SocializeOnLineState_Alchemy_CN = {
    Text = "아이템 합성 중..."
  },
  LanguageConfig_SocializeOnLineState_Awaker_CN = {
    Text = "깨어남체 관찰 중..."
  },
  LanguageConfig_SocializeOnLineState_Bag_CN = {
    Text = "물자 점검 중..."
  },
  LanguageConfig_SocializeOnLineState_Battlepass_CN = {
    Text = "과제 연구 중..."
  },
  LanguageConfig_SocializeOnLineState_Challenge_CN = {
    Text = "막간 훈련을 준비 중입니다..."
  },
  LanguageConfig_SocializeOnLineState_Copy_CN = {
    Text = "금지된 기록을 작성 중..."
  },
  LanguageConfig_SocializeOnLineState_DailyChallenge_CN = {
    Text = "환몽 심잠 수행 중..."
  },
  LanguageConfig_SocializeOnLineState_DailyCopy_CN = {
    Text = "융식의 폐허에..."
  },
  LanguageConfig_SocializeOnLineState_Dispatch_CN = {
    Text = "미션 파견 중..."
  },
  LanguageConfig_SocializeOnLineState_MainCopyInvestigate_CN = {
    Text = "조사 작전 중..."
  },
  LanguageConfig_SocializeOnLineState_MainCopy_CN = {
    Text = "조사 준비 중..."
  },
  LanguageConfig_SocializeOnLineState_Manual_CN = {
    Text = "안내서를 펴내는 중..."
  },
  LanguageConfig_SocializeOnLineState_PVP_CN = {
    Text = "페이즈 체스 매칭 중..."
  },
  LanguageConfig_SocializeOnLineState_PreparePVP_CN = {
    Text = "페이즈 체스 준비 중..."
  },
  LanguageConfig_SocializeOnLineState_Shop_CN = {
    Text = "미사그 상점을 둘러보는 중..."
  },
  LanguageConfig_SocializeOnLineState_Summon_CN = {
    Text = "깨어남 시도 중..."
  },
  LanguageConfig_SocializeOnLineState_WeekChallenge_CN = {
    Text = "무광의 영역에..."
  },
  LanguageConfig_SocializeOnLineState_WeeklyBoss_CN = {
    Text = "초월적 존재를 마주하는 중..."
  },
  LanguageConfig_SocializeOnLineTime_Day_CN = {
    Text = "{s1}일 전에 접속"
  },
  LanguageConfig_SocializeOnLineTime_Hour_CN = {
    Text = "{s1}시간 전에 접속"
  },
  LanguageConfig_SocializeOnLineTime_Minute_CN = {
    Text = "{s1} 분 전에 접속"
  },
  LanguageConfig_SocializeOnLineTime_Month_CN = {
    Text = "{s1}개월 전 온라인"
  },
  LanguageConfig_SocializeOnLineTime_YearMonth_CN = {
    Text = "마지막 로그인:{s1}년{s2}월"
  },
  LanguageConfig_SocializeOnLineTime_Year_CN = {
    Text = "{s1}년 전 온라인"
  },
  LanguageConfig_SocializeRoleLevel_CN = {
    Text = "수호자 조사 등급"
  },
  LanguageConfig_Socialize_AllStrangersFollowed_CN = {
    Text = "전부 팔로우 완료"
  },
  LanguageConfig_Socialize_AttentionPlayer_CN = {
    Text = "조력자 팔로우 버튼"
  },
  LanguageConfig_Socialize_CancelAttention_CN = {
    Text = "조력 취소 버튼"
  },
  LanguageConfig_Socialize_FollowTime_Day_CN = {
    Text = "{s1}일 전 팔로우됨"
  },
  LanguageConfig_Socialize_FollowTime_Hour_CN = {
    Text = "{s1}시간 전 팔로우됨"
  },
  LanguageConfig_Socialize_FollowTime_JustNow_CN = {
    Text = "방금 당신을 팔로우했습니다"
  },
  LanguageConfig_Socialize_FollowTime_Minute_CN = {
    Text = "{s1}분 전 팔로우됨"
  },
  LanguageConfig_SoulSynchronization_CN = {
    Text = "동조 종료"
  },
  LanguageConfig_SpecialMaterialTypeName_CN = {
    Text = "특수 재료"
  },
  LanguageConfig_SpecialRating_CN = {
    Text = "평가 항목"
  },
  LanguageConfig_SpecialShopCustomSoldOutTips_CN = {
    Text = "「감지」는 하나의 회색 유적에서 한 번만 사용할 수 있습니다."
  },
  LanguageConfig_SpecialShopName_CN = {
    Text = "재의 유적"
  },
  LanguageConfig_SpecialShopNoStrengthRelicTips_CN = {
    Text = "강화할 유물이 없습니다."
  },
  LanguageConfig_SpecialShopRefreshCostLabel_CN = {Text = "비용"},
  LanguageConfig_SpecialSubplotTipsText_CN = {
    Text = "<Title:[이몽의 세계]>\n1. 다음 조건을 충족해야 이몽의 세계를 진행할 수 있습니다:\n· 해당 조사 작전 완료\n· 「현실타래의 기점」 × 7을 소모하여 해제\n2. 이몽의 세계가 기간 한정 이벤트 중일 경우, '현실타래의 기점'을 소모하지 않고 무료로 해제할 수 있습니다. 이벤트 종료 후 조사 진행도는 유지됩니다.\n3. 이몽의 세계 조사 미션를 최초로 완료하면 무구의 은핵을 획득할 수 있습니다."
  },
  LanguageConfig_SpecialSubplotTipsTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_SpecialSubplotTitle_CN = {
    Text = "이몽의 세계"
  },
  LanguageConfig_SpecialTeamAssignTitle_CN = {
    Text = "파티 프리셋"
  },
  LanguageConfig_SpecialTeamBanTips_CN = {
    Text = "해당 조사 미션 출전 불가: {s1}"
  },
  LanguageConfig_SpecialTeamPreset_CN = {Text = "프리셋"},
  LanguageConfig_SpecialTeamTryOut_CN = {Text = "체험"},
  LanguageConfig_Speicial_kuangre1_CN = {
    Text = "곧 「명령 광열」 상태에 진입합니다. 현재 남은 명령 카드 3장..."
  },
  LanguageConfig_Speicial_kuangre2_CN = {
    Text = "곧 「명령 광열」 상태에 진입합니다. 현재 남은 명령 카드 2장..."
  },
  LanguageConfig_Speicial_kuangre3_CN = {
    Text = "곧 「명령 광열」 상태에 진입합니다. 현재 남은 명령 카드 1장..."
  },
  LanguageConfig_Speicial_kuangre4_CN = {
    Text = "「명령 광열」 상태에 진입했습니다! 이번 턴에 명령 카드를 1장 사용할 때마다 명령 카드의 행동력 소모가 1 증가하고, 추가로 100 광기를 획득합니다."
  },
  LanguageConfig_SpiritualDeepenInsufficientMaterials_CN = {
    Text = "영지 심화 재료 부족"
  },
  LanguageConfig_SpiritualDeepen_CN = {
    Text = "영지 심화"
  },
  LanguageConfig_StageAchieveTaskGot_CN = {Text = "달성"},
  LanguageConfig_StageAchieveTaskNotGot_CN = {Text = "미달성"},
  LanguageConfig_StageAchievementButton_CN = {
    Text = "업적 ({s1}/{s2})"
  },
  LanguageConfig_StageChapterMorimens_CN = {Text = "망각편"},
  LanguageConfig_StageChapterMorimens_Full_CN = {
    Text = "망각 전날의 밤"
  },
  LanguageConfig_StageChapterStarsCameRight_CN = {Text = "성신편"},
  LanguageConfig_StageChapterStarsCameRight_Full_CN = {
    Text = "별들이 교차하는 순간"
  },
  LanguageConfig_StageCloseCountdownText_CN = {
    Text = "{s1} 후 종료"
  },
  LanguageConfig_StageClosedText_CN = {
    Text = "이벤트 종료됨"
  },
  LanguageConfig_StageCopyUnlockDescFomat_CN = {
    Text = "{s1} 후 해제"
  },
  LanguageConfig_StageHideRewardsButton_CN = {
    Text = "비밀 ({s1}/{s2})"
  },
  LanguageConfig_StageHighDifficultTipsContent_CN = {
    Text = "앞길에는 셀 수 없을 정도의 위기들이 도사리고 있으며, 인간의 힘으로는 도저히 감당할 수 없는 존재들이 숨어 있다.\n매 순간 내리는 선택 하나하나가 운명을 좌우하리니, 만반의 준비를 갖추어라.\n어둠과 미지에 맞서는 자들에게 경의를 표한다.\n은열쇠가 앞길을 밝혀주기를."
  },
  LanguageConfig_StageHighDifficultTipsTitle_CN = {Text = "경고"},
  LanguageConfig_StageInitialStateContent_CN = {
    Text = "「%s」: %s"
  },
  LanguageConfig_StageInitialStateTitle_1_CN = {
    Text = "버프 효과"
  },
  LanguageConfig_StageInitialStateTitle_CN = {
    Text = "디버프 효과"
  },
  LanguageConfig_StageOpenCountdownText_CN = {
    Text = "{s1} 후 개방"
  },
  LanguageConfig_StageRelicEmpty_CN = {
    Text = "초기 유물 없음"
  },
  LanguageConfig_StageRewardsTitle_CN = {
    Text = "업적 보상"
  },
  LanguageConfig_StageUnlockCountdownText_CN = {
    Text = "{s1}일 {s2}시간 후에 개방"
  },
  LanguageConfig_StarRatingRules_CN = {
    Text = "각 스테이지의 탐사는 보스전 턴 수에 따라 조사 평가를 받으며, 스테이지별 최대 3성을 획득할 수 있습니다. 누적한 별의 수에 따라 은핵 보상을 받을 수 있습니다."
  },
  LanguageConfig_StateEffectDesc_CN = {
    Text = "상태 설명"
  },
  LanguageConfig_StateEffectDurationDesc_1_CN = {
    Text = "이번 턴 동안"
  },
  LanguageConfig_StateEffectDurationDesc_2_CN = {
    Text = "이번 전투 동안"
  },
  LanguageConfig_StateEffectDurationDesc_3_CN = {
    Text = "이번 탐색 동안"
  },
  LanguageConfig_StatusApplier1_CN = {
    Text = "적 <color=#bb646d> {s1} </color>"
  },
  LanguageConfig_StatusApplier2_CN = {
    Text = "아군 <color=#76aac8> {s1} </color>"
  },
  LanguageConfig_StatusApplier4_CN = {
    Text = "<color=#bb646d> {s1} </color>"
  },
  LanguageConfig_StatusApplier5_CN = {Text = ","},
  LanguageConfig_StoreAwakerAwake_CN = {
    Text = "깨어남체 깨어남"
  },
  LanguageConfig_StoreBuyCancel_CN = {Text = "취소"},
  LanguageConfig_StoreBuyConfirm_CN = {Text = "확인"},
  LanguageConfig_StoreEnchantmentCancel_CN = {Text = "취소"},
  LanguageConfig_StoreEnchantmentConfirmTitle_CN = {
    Text = "해당 카드에 각인 장착하기"
  },
  LanguageConfig_StoreEnchantmentConfirm_CN = {Text = "확인"},
  LanguageConfig_StoreGiveBloodTitle_CN = {Text = "감지"},
  LanguageConfig_StoreGiveBlood_CN = {
    Text = "<color=#BB646D> {s1} </color>점의 체력을 소모하여 {s2}개의 검은 인장을 획득합니다."
  },
  LanguageConfig_StoreGoodsTypeEnchantment_CN = {Text = "각인"},
  LanguageConfig_StoreGoodsTypeItem_CN = {Text = "재료"},
  LanguageConfig_StoreGoodsTypeRelic_CN = {Text = "유물"},
  LanguageConfig_StorePhiloStoneLack_CN = {
    Text = "검은 인장 부족"
  },
  LanguageConfig_StoreReleaseNoAwaker_CN = {
    Text = "이미 모든 깨어남체가 깨어남되었습니다"
  },
  LanguageConfig_StoreReleaseTimesOut_CN = {
    Text = "남은 횟수 부족"
  },
  LanguageConfig_StoreRenewButton_CN = {
    Text = "갱신({s1}/{s2})"
  },
  LanguageConfig_StoreRenewTimes_CN = {
    Text = "{s1]회 남음"
  },
  LanguageConfig_StoreRenewTitle_CN = {
    Text = "상품 갱신"
  },
  LanguageConfig_StoreSellCardCancel_CN = {Text = "취소"},
  LanguageConfig_StoreSellCardConfirm_CN = {Text = "확인"},
  LanguageConfig_StoreSellCardNoCard_CN = {
    Text = "판매할 수 있는 명령 카드가 없습니다"
  },
  LanguageConfig_StoreSellCardPrice_CN = {
    Text = "검은 인장 {s1}개 획득"
  },
  LanguageConfig_StoreSellCardTimesOut_CN = {
    Text = "남은 횟수가 부족합니다"
  },
  LanguageConfig_StoreSellCardTitle_CN = {
    Text = "명령 카드 판매"
  },
  LanguageConfig_StoreSellCard_CN = {
    Text = "명령 카드 판매"
  },
  LanguageConfig_StoreSoldOut_CN = {
    Text = "상품 매진"
  },
  LanguageConfig_StoreTitle_CN = {
    Text = "융식 흔적"
  },
  LanguageConfig_StoreTitle_Sp_CN = {
    Text = "특수 융식 흔적"
  },
  LanguageConfig_StoryGuideTitle_CN = {
    Text = "스토리 가이드"
  },
  LanguageConfig_StoryItemTypeName_CN = {
    Text = "스토리 아이템"
  },
  LanguageConfig_StoryLineTask_String_Available_CN = {Text = "수령"},
  LanguageConfig_StoryLineTask_String_Received_CN = {
    Text = "수령 완료"
  },
  LanguageConfig_StoryLine_EffectTip_CN = {
    Text = "지형 효과 및 적의 효과를 확인할 수 있습니다"
  },
  LanguageConfig_StoryLine_LockAdvance_CN = {
    Text = "{s2} {s3} 도달 시 {s1} 해제"
  },
  LanguageConfig_StoryRole_Unlock_CN = {
    Text = "해당 스토리 라인은 아직 해제되지 않았습니다, 진입할 수 없습니다."
  },
  LanguageConfig_StorylineGuide_0_CN = {
    Text = "죽음을 무릅쓰고."
  },
  LanguageConfig_StorylineGuide_10_CN = {
    Text = "물론, 혼란은 모든 것의 결말입니다. 하지만 항상 싸우기를 포기하지 않는 사람이 있지 않나요?"
  },
  LanguageConfig_StorylineGuide_11_CN = {
    Text = "머리 위의 우주를 직시할 수 없다. 마음의 심연을 직시할 수 없다."
  },
  LanguageConfig_StorylineGuide_12_CN = {
    Text = "식사는 이 세상 유일한 미덕입니다."
  },
  LanguageConfig_StorylineGuide_13_CN = {
    Text = "무한한 꿈속에는 답이 없습니다. 이 꿈은 깨어날 때가 되었습니다."
  },
  LanguageConfig_StorylineGuide_14_CN = {
    Text = "운명의 무대 위에서 우리가 맡아야 할 역할은 결코 선택할 수 없었습니다."
  },
  LanguageConfig_StorylineGuide_15_CN = {
    Text = "여행자여, 조용히 눈 내리는 밤으로 발을 들이세요. 공허한 설산의 정상에서, 긴 꿈의 종결을 증언하세요."
  },
  LanguageConfig_StorylineGuide_16_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_StorylineGuide_17_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_StorylineGuide_18_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_StorylineGuide_19_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_StorylineGuide_1_CN = {
    Text = "렌티니언의 위험한 밤안개에 발을 디디세요, 수호자. 당신의 길은 여기서 시작됩니다."
  },
  LanguageConfig_StorylineGuide_20_CN = {
    Text = "임시 텍스트"
  },
  LanguageConfig_StorylineGuide_2_CN = {
    Text = "예술가, 미친 사람, 고행자, 어리석은 사람… 이 도시는 당신의 전시관입니다. 왁스상들이 이야기의 시작 지점에 서서 당신의 방문을 간절히 기다리고 있습니다."
  },
  LanguageConfig_StorylineGuide_3_CN = {
    Text = "라이의 눈과 바람은 살육을 싫어하며, 그녀는 당신을 기다리고 있습니다, 오직 거래를 위해서. 그녀는 당신이 갈망하는 비밀을 가져다줄 것입니다. 그녀의 가격은 영원히 잔인하고, 영원히 합리적입니다."
  },
  LanguageConfig_StorylineGuide_4_CN = {
    Text = "추억하라, 추억을 위해 싸우고, 추억을 위해 죽어라. 추억은 우리의 복음서이며, 우리의 비문이다. 추억 외에는 우리는 아무것도 없다."
  },
  LanguageConfig_StorylineGuide_5_CN = {
    Text = "별들이 떨어지기 전에, 우리는 바다를 향해 기도합니다: 고요한 파도 소리가 우리를 꿈속으로 인도해 주기를, 우리가 옛 고향의 품으로 돌아가기를, 긴 꿈에서 깨어나지 않기를."
  },
  LanguageConfig_StorylineGuide_6_CN = {
    Text = "노래하라—— 그 고대의 왕이 다시 그의 왕좌를 보았다. 신성한 계시는 모든 성실타래한 백성에게 신의 나라를 가져올 것이다."
  },
  LanguageConfig_StorylineGuide_7_CN = {
    Text = "듣고, 기도하고, 호출하고, 번식하며, 가장 고귀한 이상과 가장 비천한 욕망에 복종하라. 어머니의 이름으로, 그는 혼돈과 공포 속에서 영원히 존재할 수 있다."
  },
  LanguageConfig_StorylineGuide_8_CN = {
    Text = "영원히 타오르는 불빛이 켜졌습니다. 그 어두운 빛이 당신을 끝으로 가는 길을 비춰줄 것입니다."
  },
  LanguageConfig_StorylineGuide_9_CN = {
    Text = "그에게 당신의 답변을 전하세요."
  },
  LanguageConfig_StrongerTitle_CN = {
    Text = "「막간 훈련」을 통해 재료를 획득하여 깨어남체를 강화하세요!"
  },
  LanguageConfig_StrongerWayTitle_CN = {
    Text = "강해지는 방법"
  },
  LanguageConfig_StrongerWay_CN = {
    Text = "· 「조사 작전」1-7·보통 난이도를 클리어하여 개방:「융식의 폐허」- 대량의 깨어남체 육성 재료 획득 가능.\n· 「조사 작전」3-10·보통 난이도를 클리어하여 해금:「초월적 존재」- 대량의 깨어남체 스킬 강화 재료 획득 가능.\n· 「조사 등급」15레벨 달성 시 개방:「두 번째 명륜」- 장착 시 전투력 향상 가능.\n· 「조사 등급」35레벨 달성 시 개방:「금지된 기록」- 대량의 비밀 계약 획득 가능, 깨어남체 능력 강화."
  },
  LanguageConfig_SubPlotAvgPreviewItemName_CN = {
    Text = "다시 보기 {s1}"
  },
  LanguageConfig_SubplotActivityRewardTimeTips_CN = {
    Text = "\n<GrayState:({s1}일 {s2}시간 후에 오픈)>"
  },
  LanguageConfig_SubplotFreeTips_CN = {
    Text = "이벤트 기간 중, 다음 조사 콘텐츠를 <WeaponEffect_Num:「기간 한정 무료 잠금 해제」>할 수 있습니다."
  },
  LanguageConfig_SubplotJumpButton_CN = {Text = "조사"},
  LanguageConfig_SuitPlanChoosenTitle_CN = {
    Text = "프리셋 선택"
  },
  LanguageConfig_SummonAutoDecomposeItem_CN = {
    Text = "자동 분해"
  },
  LanguageConfig_SummonCountdown_CN = {
    Text = "남은 시간: \n{s1}"
  },
  LanguageConfig_SummonDailyDiscount_CN = {
    Text = "매일 1회 한정"
  },
  LanguageConfig_SummonDailyRecommend_CN = {
    Text = "오늘의 추천"
  },
  LanguageConfig_SummonExtraItem_CN = {
    Text = "추가 증정"
  },
  LanguageConfig_SummonFirstDesc_CN = {
    Text = "첫 5회 깨어남은 제한 없이 재시도할 수 있습니다!"
  },
  LanguageConfig_SummonFirstTitle_CN = {
    Text = "첫회 한정"
  },
  LanguageConfig_SummonLimitDesc_CN = {Text = "한정"},
  LanguageConfig_SummonNoCallbackTips_CN = {
    Text = "이전 깨어남이 아직 진행 중입니다, 잠시 기다려 주세요"
  },
  LanguageConfig_SummonOptionCountDesc_CN = {
    Text = "선택됨<space=0.2em><color=#e1e1e1>{s1}/{s2}</color>"
  },
  LanguageConfig_SummonProbabilityUpDescFormat_CN = {
    Text = "<SummonOrange:「{s1}」> 획득 확률 상승!"
  },
  LanguageConfig_SummonRepetitiveAwaker_CN = {
    Text = "중복 깨어남체 변환"
  },
  LanguageConfig_SummonRulesExtraTxt1_CN = {
    Text = "일반 보상 횟수가 모자랄 경우, 추가 보상 횟수가 대신 사용됩니다."
  },
  LanguageConfig_SummonRulesExtraTxt2_CN = {
    Text = "현재 추가 보상 횟수: {s1}"
  },
  LanguageConfig_SummonRulesTitle_CN = {
    Text = "깨어남 규칙"
  },
  LanguageConfig_SummonSelectAwakeBtnTips_CN = {
    Text = "지금 선택"
  },
  LanguageConfig_SummonSelectAwakePanelDesc_CN = {
    Text = "1. 순차 운명:\n깨어남체 1명을 선택하여 순차 운명 깨어남의 목표로 지정할 수 있습니다. 깨어남에서 등장하는 깨어남체는 항상 선택한 깨어남체와 같은 영역에서만 등장합니다.\n2. 추천 명륜:\n깨어남체를 선택하면, 해당 깨어남체의 추천 명륜이 자동으로 선택됩니다.\n3. 깨어남 확률 업:\n깨어남 중 등장하는 SSR은 33.33% 확률로 목표 깨어남체 또는 명륜이 등장합니다(확률은 동일하게 분배됨).\n2회 연속으로 목표 깨어남체 또는 명륜을 획득하지 못할 경우, 다음 SSR은 반드시 선택한 깨어남체 또는 명륜이 등장합니다.\n4.선택 잠금:\n한 번 선택한 깨어남체와 명륜은 이벤트 기간 동안 변경할 수 없습니다."
  },
  LanguageConfig_SummonSelectAwakerBtnUnClickTips_CN = {
    Text = "먼저 깨어남체를 선택해주세요"
  },
  LanguageConfig_SummonSelectAwakerOwnedLabel_CN = {Text = "보유 중"},
  LanguageConfig_SummonTargetPoolNotSelectTips_CN = {
    Text = "명륜을 지정한 후에 깨어남할 수 있습니다"
  },
  LanguageConfig_SummonTrial_CN = {
    Text = "깨어남체 체험"
  },
  LanguageConfig_SummonTypeText_0_CN = {
    Text = "상시 명륜 깨어남"
  },
  LanguageConfig_SummonTypeText_10_CN = {
    Text = "만상 깨어남"
  },
  LanguageConfig_SummonTypeText_12_CN = {
    Text = "역명 쌍생 깨어남"
  },
  LanguageConfig_SummonTypeText_13_CN = {
    Text = "경계 잠금 깨어남"
  },
  LanguageConfig_SummonTypeText_14_CN = {
    Text = "캐릭터 선택 깨어남"
  },
  LanguageConfig_SummonTypeText_15_CN = {
    Text = "운명 합일·3배 깨어남"
  },
  LanguageConfig_SummonTypeText_16_CN = {
    Text = "속박 맹세의 칙령"
  },
  LanguageConfig_SummonTypeText_17_CN = {
    Text = "백상 자유 각성"
  },
  LanguageConfig_SummonTypeText_1_CN = {
    Text = "한정 명륜 깨어남"
  },
  LanguageConfig_SummonTypeText_2_CN = {
    Text = "한정 깨어남체 깨어남"
  },
  LanguageConfig_SummonTypeText_3_CN = {
    Text = "예약 깨어남"
  },
  LanguageConfig_SummonTypeText_4_CN = {
    Text = "예약 깨어남"
  },
  LanguageConfig_SummonTypeText_5_CN = {
    Text = "상시 깨어남체 깨어남"
  },
  LanguageConfig_SummonTypeText_6_CN = {
    Text = "신입 추천 깨어남"
  },
  LanguageConfig_SummonTypeText_7_CN = {
    Text = "순차 운명 깨어남"
  },
  LanguageConfig_SummonTypeText_8_CN = {
    Text = "운명 합일 깨어남"
  },
  LanguageConfig_SummonTypeText_9_CN = {
    Text = "신입 깨어남체 깨어남"
  },
  LanguageConfig_SummonType_14SelectPanelDesc_CN = {
    Text = "1,캐릭터 자선 깨어남:수호자는 이번 주 캐릭터 자선 깨어남 이벤트에서 선택할 수 있는 깨어남체 목록 중에서 4개의 깨어남체를 이번 UP 목표로 선택할 수 있습니다.\n2,깨어남 확률 UP:\n·깨어남으로 SSR을 얻을 때마다 50%의 확률로 이번 주 선택한 UP 깨어남체 중 하나가 됩니다. \n·이번 깨어남에서 얻은 SSR이 이번 주 선택한 UP 깨어남체가 아닐 경우, 다음 깨어남을 통해 얻는 SSR은 반드시 이번 주 선택한 UP 깨어남체가 됩니다.\n3,UP 목표가 한 번 선택되면, 이번 주에는 더 이상 깨어남 대상을 변경할 수 없습니다."
  },
  LanguageConfig_SummonType_14SelectTips_CN = {
    Text = "{s1}명의 “망각편” 한정 깨어남체를 선택하세요"
  },
  LanguageConfig_SummonType_14SelectTitle_CN = {
    Text = "선택 {s1} 명 지정된 깨어남체"
  },
  LanguageConfig_SummonType_14SelectUpTips_CN = {
    Text = "선택된 {s1}명의 확률 상승 깨어남체"
  },
  LanguageConfig_SummonType_14SummonDesc1_CN = {
    Text = "<SummonOrange:선택한 {s1}개 깨어남체> 획득률 상승!"
  },
  LanguageConfig_SummonType_14SummonDesc2_CN = {
    Text = "선택 후 이벤트 기간 동안 변경 불가"
  },
  LanguageConfig_SummonType_17FinishSelect_CN = {
    Text = "선택 완료"
  },
  LanguageConfig_SummonType_17SelectPanelDesc_CN = {
    Text = "1、백상 자유 각성: 수호자는 이번 기간 백상 자유 각성 이벤트에서 선택 가능한 각성체 목록 중 5명의 각성체를 선택할 수 있으며, 선택된 각성체와 추천 명륜이 이번 각성 이벤트의 SSR 목록이 됩니다.\n2、각성을 통해 SSR을 획득할 때마다 100% 확률로 이번 기간 선정된 각성체 또는 추천 명륜 중 하나입니다. \n3、UP 목표는 한 번 선정되면 이번 기간 내 지정 각성 대상을 변경할 수 없습니다."
  },
  LanguageConfig_SummonType_17SelectTips_CN = {
    Text = "{s1} 명의 「별의 시대」 한정 각성체 선택"
  },
  LanguageConfig_SummonType_17SelectTitle_CN = {
    Text = "{s1} 각성체 1명 선택"
  },
  LanguageConfig_SummonType_17SelectType_1_CN = {Text = "공격형"},
  LanguageConfig_SummonType_17SelectType_2_CN = {Text = "방어형"},
  LanguageConfig_SummonType_17SelectType_3_CN = {Text = "보조형"},
  LanguageConfig_SummonType_17SelectType_4_CN = {Text = "남성"},
  LanguageConfig_SummonType_17SelectType_5_CN = {Text = "여성"},
  LanguageConfig_SummonType_17SelectedDesc_CN = {
    Text = "각성체와 추천 명륜이 지정되었습니다"
  },
  LanguageConfig_SummonType_17SelectedTips_CN = {
    Text = "{s1} 선택됨"
  },
  LanguageConfig_SummonType_17SelectionProgress_CN = {
    Text = "선택됨 {s1}/{s2}"
  },
  LanguageConfig_SummonType_17SummonDesc1_CN = {
    Text = "<SummonOrange:자유 선택> 각성 SSR 목록!"
  },
  LanguageConfig_SummonType_17SummonDesc2_CN = {
    Text = "선택 후 이벤트 기간 동안 변경 불가"
  },
  LanguageConfig_Summon_Detail_Btn_CN = {
    Text = "상세 확인"
  },
  LanguageConfig_Summon_DrawOnce_Btn_CN = {
    Text = "1회 깨어남"
  },
  LanguageConfig_Summon_DrawTenTimes_Btn_CN = {
    Text = "5회 깨어남"
  },
  LanguageConfig_Summon_Free_CN = {Text = "무료"},
  LanguageConfig_Summon_History_Btn_CN = {
    Text = "깨어남 기록"
  },
  LanguageConfig_Summon_LongDesc_Text1_CN = {
    Text = "다음 항목의 [확률 UP 출현!!!]"
  },
  LanguageConfig_Summon_LongDesc_Text2_CN = {
    Text = "다음 SSR 항목은 전체 SSR 출현율의 50%를 차지합니다."
  },
  LanguageConfig_Summon_LongDesc_Text3_CN = {
    Text = "다음 SR 항목은 전체 SR 출현율의 50%를 차지합니다."
  },
  LanguageConfig_Summon_RateDesc_Btn_CN = {
    Text = "깨어남 상세"
  },
  LanguageConfig_Summon_RateDesc_Tab_ItemList_CN = {
    Text = "아이템 목록"
  },
  LanguageConfig_Summon_RateDesc_Tab_LongDesc_CN = {
    Text = "확률 안내"
  },
  LanguageConfig_Summon_RateDesc_Tab_UPItem_CN = {Text = "UP 항목"},
  LanguageConfig_Summon_RateList_Text1_CN = {
    Text = "항목 리스트:"
  },
  LanguageConfig_Summon_RateList_Text2_CN = {
    Text = "(확률 UP 또는 보장 규칙이 적용되지 않을 때, 모든 깨어남체/명륜의 기본 출현율은 동일합니다)"
  },
  LanguageConfig_Summon_ReselectTimes_CN = {
    Text = "횟수: {s1}/{s2}"
  },
  LanguageConfig_Summon_Reselect_Btn_CN = {
    Text = "깨어남 재시도"
  },
  LanguageConfig_Summon_SchoolSelected_CN = {
    Text = "현재 지정: {s1}"
  },
  LanguageConfig_Summon_School_DetailTitle_CN = {
    Text = "영역 특성:"
  },
  LanguageConfig_Summon_School_Difficulty_CN = {
    Text = "운영 난이도"
  },
  LanguageConfig_Summon_SelectSchoolTips_CN = {
    Text = "영역을 지정해야 깨어남할 수 있습니다"
  },
  LanguageConfig_Summon_SelectSchool_CN = {
    Text = "영역 지정"
  },
  LanguageConfig_Summon_SelectSchool_Tips_CN = {
    Text = "지정할 영역을 선택"
  },
  LanguageConfig_Summon_SelectWeapon_CN = {
    Text = "명륜 지정"
  },
  LanguageConfig_Summon_SelectWeapon_Tips_CN = {
    Text = "지정할 명륜을 선택"
  },
  LanguageConfig_Summon_Select_Btn_CN = {
    Text = "이번 결과 선택하기"
  },
  LanguageConfig_Summon_Shop_Btn_CN = {
    Text = "상점 교환"
  },
  LanguageConfig_Summon_Str_Free_CN = {
    Text = "첫 회 무료"
  },
  LanguageConfig_Summon_Tab_Type0_CN = {
    Text = "상시 깨어남"
  },
  LanguageConfig_Summon_Tab_Type1_CN = {
    Text = "명륜\n상시 깨어남"
  },
  LanguageConfig_Summon_Tab_Type2_CN = {
    Text = "깨어남체\n상시 깨어남"
  },
  LanguageConfig_Summon_Time_Remain1_CN = {Text = "{s1}일"},
  LanguageConfig_Summon_Times_Left_CN = {
    Text = "{s1}회 깨어남 후 종료"
  },
  LanguageConfig_SuperUltlSkillName_CN = {
    Text = "초월 폭발"
  },
  LanguageConfig_SweepRuleTxt_CN = {
    Text = "<Title:재현>\n·재현 기능을 통해 스테이지의 미션 보상을 즉시 획득할 수 있습니다.\n·각 재현은 조사를 진행하는 데 필요한 린피테이프와 동일한 양의 린피테이프를 소모합니다.\n<Title:개방 조건>\n·스테이지마다 재현 기능 개방 조건이 다르며, 미개방 상태일 때는 수호자 재현 팝업 화면에서 해제 방법에 대한 힌트를 확인할 수 있습니다."
  },
  LanguageConfig_SweepTipsAllTasksNotClearTxt_CN = {
    Text = "클리어 후, 「업적 보상」을 100% 달성하여 해제"
  },
  LanguageConfig_SweepTipsNotThreeStarTxt_CN = {
    Text = "조사 평가 3성 도달 시 개방"
  },
  LanguageConfig_SweepTipsUnopenTxt_CN = {
    Text = "도전 완료 후 재현 기능 개방"
  },
  LanguageConfig_SystemPreset_CN = {
    Text = "스토리 편성"
  },
  LanguageConfig_TDJMMainDia1_CN = {
    Text = "어둠은 영원한 죄를 내리나, 빛은 복음을 내리리라."
  },
  LanguageConfig_TDJMMainDia2_CN = {
    Text = "빛으로 돌아오라, 양떼여. 그렇지 않으면 너희는 어둠 속에 떨어지리라."
  },
  LanguageConfig_TDJZMainDia1_CN = {
    Text = "영원의 밤이 다가오니, 빛 속에 몸을 씻고 속죄를 얻으라."
  },
  LanguageConfig_TalentActivationConditionPrompt_CN = {
    Text = "활성화 조건을 충족해야 합니다"
  },
  LanguageConfig_TalentActivationConditions_CN = {
    Text = "활성화 조건"
  },
  LanguageConfig_TalentExtraFavor_CN = {
    Text = "{s1}(+{s2})"
  },
  LanguageConfig_TalentTab_ALL_CN = {Text = "전부"},
  LanguageConfig_TalentUpgradeConditionPrompt_CN = {
    Text = "업그레이드 조건을 만족해야 합니다"
  },
  LanguageConfig_TalentUpgradeConditions_CN = {
    Text = "업그레이드 조건"
  },
  LanguageConfig_TalentUpgradeInsufficientMaterial_CN = {
    Text = "재료가 부족합니다"
  },
  LanguageConfig_TapToSummon_CN = {
    Text = "은열쇠 삽입"
  },
  LanguageConfig_TaskAvgUnlockStr_CN = {
    Text = "스토리 해제"
  },
  LanguageConfig_TaskAward_Btn_Completed_CN = {Text = "수령"},
  LanguageConfig_TaskModule_btn_reward_CN = {Text = "수령"},
  LanguageConfig_TaskNpc_001_CN = {
    Text = "미션 보상 수령 가능"
  },
  LanguageConfig_TaskType_Appoint_Battle_CN = {Text = "전투"},
  LanguageConfig_TaskType_Appoint_Dispatch_CN = {Text = "조사"},
  LanguageConfig_Task_AchievementLabel_CN = {
    Text = "업적 칭호"
  },
  LanguageConfig_Task_Achievement_Finished_CN = {
    Text = "업적 <color=#359bb1>{s1}</color>개 완료"
  },
  LanguageConfig_Task_Appoint_AcountLvUpTips_CN = {
    Text = "동시에 파견할 수 있는 미션 수량: <TipsHighlightText_1:{s1} >"
  },
  LanguageConfig_Task_Appoint_AllFinished_CN = {
    Text = "오늘의 파견 미션을 모두 완료했습니다!"
  },
  LanguageConfig_Task_Appoint_Battle_Award_CN = {
    Text = "미션 보상"
  },
  LanguageConfig_Task_Appoint_Battle_EnemyInfo_CN = {
    Text = "전투 개요"
  },
  LanguageConfig_Task_Appoint_Battle_NeedTime_CN = {Text = "즉시"},
  LanguageConfig_Task_Appoint_Battle_Select_CN = {
    Text = "전투 진입"
  },
  LanguageConfig_Task_Appoint_Cannot_GetNewApppoint_CN = {
    Text = "오늘의 파견 횟수가 한도에 도달했습니다."
  },
  LanguageConfig_Task_Appoint_Level_CN = {
    Text = "파견 등급: {s1} (쓰이지 않음)"
  },
  LanguageConfig_Task_Appoint_Newer_Tips_CN = {
    Text = "모든 파견 미션을 완료한 후 갱신"
  },
  LanguageConfig_Task_Appoint_NonExistent_CN = {
    Text = "미션이 갱신되었습니다."
  },
  LanguageConfig_Task_Appoint_Refresh_CN = {
    Text = "갱신 (쓰이지 않음)"
  },
  LanguageConfig_Task_Appoint_Refresh_Free_CN = {
    Text = "무료 갱신 (쓰이지 않음)"
  },
  LanguageConfig_Task_Appoint_Refresh_NoTaskToRefresh_CN = {
    Text = "갱신 가능한 미션 없음 (쓰이지 않음)"
  },
  LanguageConfig_Task_Appoint_Refresh_NotAvailable_CN = {
    Text = "오늘의 파견 횟수 한도에 도달하여 갱신할 수 없습니다."
  },
  LanguageConfig_Task_Appoint_Refresh_NotEnoughItem_CN = {
    Text = "은심 부족 (쓰이지 않음)"
  },
  LanguageConfig_Task_Appoint_Refresh_TimeLeft_CN = {
    Text = "{s1} 후 갱신"
  },
  LanguageConfig_Task_Appoint_Rules_CN = {
    Text = "<Title:[파견 규칙]>\n· 수호자는 깨어남체를 조사 또는 연구 미션에 파견할 수 있으며, 미션을 완료하면 해당하는 보상을 획득할 수 있습니다.\n· 파견 파티의 레벨 합계가 파견 요구치를 충족해야만 파견을 보낼 수 있습니다. \n· 파견 파티의 총 레벨이 미션 요구 조건보다 20 레벨 높아질 때마다 추가 보상을 받을 수 있습니다. 파견 파티의 총 레벨이 240을 넘을 경우 추가 보상을 더 이상 획득할 수 없습니다.\n· 하나의 깨어남체는 동시에 하나의 파견 미션만 수행할 수 있습니다. 미션 도중 파견 팀을 귀환시키면 해당 미션에 투입된 깨어남체를 즉시 파견할 수 있게 되지만, 해당 미션의 보상을 받을 수 없게 됩니다.\n· 수호자 조사 등급이 20/30/40/50/60에 도달할 때마다 파견 가능한 미션 수가 1씩 증가합니다.\n·주의: 깨어남체의 본원 형태는 파견할 수 없습니다."
  },
  LanguageConfig_Task_Appoint_TimesLeft_CN = {
    Text = "파견 제한: {s1}/{s2}"
  },
  LanguageConfig_Task_Appoint_Unclaimed_Toomuch_CN = {
    Text = "미수령한 미션 보상이 너무 많습니다, 먼저 수령해주세요."
  },
  LanguageConfig_Task_Career_Btn_Last_CN = {Text = "이전"},
  LanguageConfig_Task_Career_Btn_Next_CN = {Text = "다음"},
  LanguageConfig_Task_Career_LastChapter_Tips_CN = {
    Text = "이미 첫 번째 단계입니다"
  },
  LanguageConfig_Task_Career_NextChapter_Tips_CN = {
    Text = "모든 미션을 완료하면 다음 단계가 해금됩니다"
  },
  LanguageConfig_Task_Career_Parent_Pickup_Tips_CN = {
    Text = "오른쪽의 모든 미션을 완료한 후 수령 가능"
  },
  LanguageConfig_Task_Career_Progress_CN = {
    Text = "현재 진행도: {s1}/{s2}"
  },
  LanguageConfig_Task_Daily_Desc_CN = {
    Text = "일일 과제의 보상으로 「은심」과 대량의 「수호자 경험치」를 얻을 수 있습니다."
  },
  LanguageConfig_Task_Daily_Name_CN = {
    Text = "일일 과제"
  },
  LanguageConfig_Task_Dispatch_AwakerState_CN = {Text = "파견 중"},
  LanguageConfig_Task_Dispatch_Awakers_CN = {
    Text = "깨어남체 파견"
  },
  LanguageConfig_Task_Dispatch_Callback_CN = {Text = "귀환"},
  LanguageConfig_Task_Dispatch_Callback_CancelBtn_CN = {Text = "취소"},
  LanguageConfig_Task_Dispatch_Callback_ConfirmBtn_CN = {Text = "확인"},
  LanguageConfig_Task_Dispatch_Callback_Desc1_CN = {
    Text = "현재 파견된 파티를 즉시 귀환시키시겠습니까?"
  },
  LanguageConfig_Task_Dispatch_Callback_Desc2_CN = {
    Text = "파견된 깨어남체"
  },
  LanguageConfig_Task_Dispatch_Callback_Desc3_CN = {
    Text = "주의: 귀환 시 보상 획득 불가"
  },
  LanguageConfig_Task_Dispatch_Callback_Title_CN = {
    Text = "파견 귀환"
  },
  LanguageConfig_Task_Dispatch_DispatchingTips_CN = {
    Text = "해당 깨어남체는 다른 미션을 수행 중입니다"
  },
  LanguageConfig_Task_Dispatch_Essential_Cond_CN = {
    Text = "필수 조건"
  },
  LanguageConfig_Task_Dispatch_Extra_Award_CN = {
    Text = "추가 보상 (쓰이지 않음)"
  },
  LanguageConfig_Task_Dispatch_Extra_Cond_CN = {
    Text = "추가 조건 (쓰이지 않음)"
  },
  LanguageConfig_Task_Dispatch_FinishedTips_CN = {
    Text = "해당 미션은 이미 완료되어 귀환시킬 수 없습니다"
  },
  LanguageConfig_Task_Dispatch_Hour_CN = {
    Text = "{s1}시간 {s2}분"
  },
  LanguageConfig_Task_Dispatch_LeftTime_CN = {
    Text = "남은 [삭제 대기]"
  },
  LanguageConfig_Task_Dispatch_Level_Tips_CN = {
    Text = "파견 레벨 합계: {s1}"
  },
  LanguageConfig_Task_Dispatch_Minute_CN = {Text = "{s1}분"},
  LanguageConfig_Task_Dispatch_NeedTime_CN = {
    Text = "{s1}시간 남음"
  },
  LanguageConfig_Task_Dispatch_NeedTime_Min_CN = {
    Text = "{s1}분 남음"
  },
  LanguageConfig_Task_Dispatch_Second_CN = {Text = "{s1}초"},
  LanguageConfig_Task_Dispatch_SelectConfirm_CN = {
    Text = "파견 확인"
  },
  LanguageConfig_Task_Dispatch_Select_CN = {
    Text = "파견 보내기"
  },
  LanguageConfig_Task_Dispatch_Select_Condition_NotMeet_CN = {
    Text = "필수 조건을 충족해야만 파견할 수 있습니다"
  },
  LanguageConfig_Task_Dispatch_Select_Null_CN = {
    Text = "최소 한 명의 깨어남체를 파견해야 합니다"
  },
  LanguageConfig_Task_Dispatch_SpeedUp_CN = {
    Text = "가속 (쓰이지 않음)"
  },
  LanguageConfig_Task_Dispatch_SpeedUp_Free_CN = {
    Text = "무료 (쓰이지 않음)"
  },
  LanguageConfig_Task_Dispatch_SpeedUp_NotEnoughItem_CN = {
    Text = "가속 티켓 부족 (쓰이지 않음)"
  },
  LanguageConfig_Task_Dispatch_TeamNum_CN = {
    Text = "파견된 파티: {s1}/{s2}"
  },
  LanguageConfig_Task_Dispatch_TeamNum_NotEnough_CN = {
    Text = "파견할 수 있는 파티가 부족합니다"
  },
  LanguageConfig_Task_GoldShop_Rules_CN = {
    Text = "<Title:【금권 교환 규칙】>\n·금권 교환 상점은 매일 오전 9시에 초기화됩니다. (GMT+8)\n·수호자는 일정 수량의 장미 금권을 소모하여 금권 교환 상점의 재고를 갱신할 수 있습니다.\n·매일 최대 5회 갱신할 수 있으며, 소모하는 장미 금권 수량은 점차 증가합니다.\n·수호자 조사 등급이 상승하면 새로운 교환 가능 상품이 개방됩니다."
  },
  LanguageConfig_Task_Module_Btn_CN = {
    Text = "미션 진입"
  },
  LanguageConfig_Task_State_Completed_CN = {Text = "완료됨"},
  LanguageConfig_Task_State_Ongoing_CN = {Text = "진행 중"},
  LanguageConfig_Task_State_Received_CN = {
    Text = "보상 수령 완료"
  },
  LanguageConfig_Task_SubTab_Achievement_CN = {Text = "업적"},
  LanguageConfig_Task_Tab_Achievement_CN = {Text = "업적"},
  LanguageConfig_Task_Tab_Appoint_CN = {Text = "파견"},
  LanguageConfig_Task_Tab_Career_CN = {
    Text = "미션 보고"
  },
  LanguageConfig_Task_Tab_Daily_CN = {Text = "일정"},
  LanguageConfig_Task_Tips_ToReceive_CN = {
    Text = "수령 가능"
  },
  LanguageConfig_TeamAssistAwakerStepDown_CN = {
    Text = "조력 깨어남체가 팀에서 제외되었습니다"
  },
  LanguageConfig_TeamAverageLevel_CN = {
    Text = "파티 평균 레벨"
  },
  LanguageConfig_TeamFormation_CN = {Text = "편성"},
  LanguageConfig_TeamNeedFightAwakerTips_CN = {
    Text = "해당 조사에서 {s1}은 반드시 출전해야 합니다"
  },
  LanguageConfig_TeamRecommendLevel_CN = {
    Text = "레벨 {s1} 권장"
  },
  LanguageConfig_TeamSchoolRequired_CN = {
    Text = "파티 요구사항"
  },
  LanguageConfig_TeamSkillStrength_CN = {
    Text = "파티 스킬 레벨"
  },
  LanguageConfig_TeamTitleText_CN = {
    Text = "파티 편성"
  },
  LanguageConfig_TeamTrinketStrength_CN = {
    Text = "파티 비밀계약 강도"
  },
  LanguageConfig_TeamTypeTips_Atk_CN = {
    Text = "파티에 공격형 깨어남체가 부족합니다"
  },
  LanguageConfig_TeamTypeTips_Auxiliary_CN = {
    Text = "파티에 보조형 깨어남체가 부족합니다"
  },
  LanguageConfig_TeamTypeTips_Def_CN = {
    Text = "파티에 방어형 깨어남체가 부족합니다"
  },
  LanguageConfig_TeamWeaponStrength_CN = {
    Text = "파티 명륜 강도"
  },
  LanguageConfig_TeamWipe_CN = {
    Text = "파티 전멸!!!"
  },
  LanguageConfig_Team_AwakerLevel_CN = {Text = "Lv. {s1}"},
  LanguageConfig_Team_CN = {Text = "파티"},
  LanguageConfig_Team_Card_Str_Nill_Overview_CN = {
    Text = "캐릭터를 편성에 넣어주세요"
  },
  LanguageConfig_Team_Occupation_Tips_CN = {
    Text = "영역 특성"
  },
  LanguageConfig_Team_Str_Nill_Actor_CN = {
    Text = "깨어남체 없음"
  },
  LanguageConfig_TentacleModeSwitch1_CN = {
    Text = "현재 「조수」 태세이기 때문에, 다시 선택할 수 없습니다."
  },
  LanguageConfig_TentacleModeSwitch2_CN = {
    Text = "현재 영구 촉수 수량이 부족하여 「노도」 태세로 변경할 수 없습니다."
  },
  LanguageConfig_TentacleModeSwitch3_CN = {
    Text = "「정해」 태세가 쿨다운 중이어서 변경할 수 없습니다. 남은 쿨다운 턴: {s1}"
  },
  LanguageConfig_TentacleModeSwitch4_CN = {
    Text = "「노도」 태세가 쿨다운 중이어서 변경할 수 없습니다. 남은 쿨다운 턴: {s1}"
  },
  LanguageConfig_TentacleModeSwitchCondString_CN = {
    Text = "선택 불가"
  },
  LanguageConfig_TentacleModeSwitchCondTips_CN = {
    Text = "이번 턴 이미 촉수 태세를 변경했습니다"
  },
  LanguageConfig_TentacleModeSwitchNew_CN = {
    Text = "현재 태세"
  },
  LanguageConfig_TentacleModeSwitchTips_CN = {
    Text = "촉수 태세 선택"
  },
  LanguageConfig_TentacleOverflow_CN = {
    Text = "초과 발동"
  },
  LanguageConfig_TentaclesTips_CN = {
    Text = "촉수 피해 +{s1}"
  },
  LanguageConfig_TextActOpenTime_CN = {
    Text = "{s2} 후「s1」개방"
  },
  LanguageConfig_TextAlreadyReceivedAwaker_CN = {
    Text = "깨어남 완료됨: {s1}"
  },
  LanguageConfig_TextAlreadyReceivedWeapon_CN = {
    Text = "수령 완료: {s1}"
  },
  LanguageConfig_TextAlreadyReceived_CN = {
    Text = "수령 완료"
  },
  LanguageConfig_TextBanTitle_CN = {
    Text = "블랙리스트"
  },
  LanguageConfig_TextBan_CN = {
    Text = "블랙리스트 추가"
  },
  LanguageConfig_TextBanned_CN = {Text = "차단됨"},
  LanguageConfig_TextBossProgress_CN = {
    Text = "원초를 향한 공투 진행도: {s1}<color=#A7B9C3>/{s2}</color>"
  },
  LanguageConfig_TextCancelBan_CN = {
    Text = "차단 해제"
  },
  LanguageConfig_TextComma_CN = {Text = ","},
  LanguageConfig_TextEmptyBan_CN = {
    Text = "블랙리스트가 없습니다"
  },
  LanguageConfig_TextEventNotFinished_CN = {
    Text = "「{s1}」완료 후 개방"
  },
  LanguageConfig_TextFightBoss_CN = {
    Text = "별들의 진혼곡"
  },
  LanguageConfig_TextUnlockEvent_CN = {
    Text = "「{s1}」완료 후 개방"
  },
  LanguageConfig_Text_Discount_Unlock_CN = {
    Text = "기간 한정 상품 개방"
  },
  LanguageConfig_Text_Enter_Plot_CN = {
    Text = "스토리 진입"
  },
  LanguageConfig_Text_Unlock_CN = {Text = "개방"},
  LanguageConfig_TheNth_CN = {Text = "{s1}위"},
  LanguageConfig_ThisWeek_CN = {Text = "이번 주"},
  LanguageConfig_Ticket_Countdown_Str_CN = {
    Text = "{s1} 후에 증명서 1장을 얻습니다"
  },
  LanguageConfig_Ticket_Revert_Btn_Return_CN = {Text = "취소"},
  LanguageConfig_Ticket_Revert_Btn_Sure_CN = {Text = "확인"},
  LanguageConfig_Ticket_Revert_Time_Tips_CN = {
    Text = "1시간마다 1장씩 회복"
  },
  LanguageConfig_TimeFormatYMDHm2_CN = {
    Text = "{s1} 월 {s2} 일 {s3}:{s4}"
  },
  LanguageConfig_TimeFormatYMDHm_CN = {
    Text = "{s1}년 {s2}월 {s3}일 {s4}시 {s5}분"
  },
  LanguageConfig_TimeSettleStr_CN = {
    Text = "{s1} 후 정산"
  },
  LanguageConfig_TimeoutText_CN = {
    Text = "시간 초과"
  },
  LanguageConfig_Tip_Ability_CN = {
    Text = "<CardTip:능력>\n각각의 깨어남체는 강력한 능력을 보유하고 있으며, 상점과 연락 지점에서 해금할 수 있습니다."
  },
  LanguageConfig_Tip_Rune_CN = {
    Text = "<CardTip:각인>\n능력 카드를 제외한 모든 카드에 각인을 새겨 각인 효과를 부여할 수 있으며, 각 카드당 최대 1개의 각인을 새길 수 있습니다."
  },
  LanguageConfig_Tip_TemporaryStrength_CN = {
    Text = "<CardTip:임시 힘>\n피해가 증가합니다. 아군 턴 종료 시 임시 힘을 잃습니다."
  },
  LanguageConfig_TipsAwakerEquip_CN = {
    Text = "{s1} 장착됨"
  },
  LanguageConfig_TipsOriginTitle_CN = {
    Text = "획득 방법"
  },
  LanguageConfig_TipsRefineLevel_CN = {
    Text = "중첩 {s1}단계"
  },
  LanguageConfig_TitleRate_CN = {Text = "확률"},
  LanguageConfig_TitleRewardItems_CN = {
    Text = "보상 아이템"
  },
  LanguageConfig_TitleReward_CN = {Text = "보상"},
  LanguageConfig_Today_CN = {Text = "이번 주"},
  LanguageConfig_TopBarItemTypeName_CN = {
    Text = "일반 화폐"
  },
  LanguageConfig_TotalNumWins_CN = {
    Text = "전체 승리 횟수"
  },
  LanguageConfig_TotallyNumb_CN = {
    Text = "완전 마비!"
  },
  LanguageConfig_TrialActivityRewardTips_CN = {
    Text = "체험 보상"
  },
  LanguageConfig_TrinketApplyingToSuitPlan_CN = {Text = "적용됨"},
  LanguageConfig_TrinketAutoRefineProgress_CN = {
    Text = "자동 전사 중, 현재 {s1}회차"
  },
  LanguageConfig_TrinketAutoRefineStopByGetTargetAttr_CN = {
    Text = "비밀 계약 자동 전사 목표 달성!\n<size=40>{s1}회 전사 완료</size>"
  },
  LanguageConfig_TrinketAutoRefineStopByMaterialNotEnough_CN = {
    Text = "{s1}회 전사 완료, 이번 자동 전사가 종료되었습니다."
  },
  LanguageConfig_TrinketAutoRefineStopByMaxTimeLimit_CN = {
    Text = "100회 전사 완료, 자동 전사가 종료되었습니다."
  },
  LanguageConfig_TrinketAutoRefine_CN = {
    Text = "<Title:자동 전사>\n·자동 전사는 현재 재료 상황에 따라 최대 100회 전사를 진행할 수 있습니다.\n·자동 전사 시, 전사 결과 중 잠금되지 않은 속성 강도가 8인 항목이 1개 있으면 자동 전사가 중단됩니다.\n·재료가 부족하면 자동 전사가 중지됩니다.\n\n<Title:건너뛰기>\n·자동 전사 시 매 전사 결과가 표시되며, 전사 과정을 건너뛸 수 있습니다. 건너뛴 후에는 자동 전사의 최종 결과가 바로 표시됩니다."
  },
  LanguageConfig_TrinketAutoSelectTips_CN = {
    Text = "자동 선택: 품질이 낮고 레벨이 낮은 비밀 계약을 우선적으로 소재로 선택합니다"
  },
  LanguageConfig_TrinketBatchUnbindComingSoon_CN = {
    Text = "일괄 분리 기능이 곧 오픈됩니다"
  },
  LanguageConfig_TrinketBatchUnbindTitle_CN = {
    Text = "일괄 분리"
  },
  LanguageConfig_TrinketBindBonusDesc_CN = {
    Text = "결속 후, 비밀 계약 주 속성이 추가로 {s1} 상승합니다!"
  },
  LanguageConfig_TrinketBindNoneSelectedTips_CN = {
    Text = "결속할 수 있는 비밀 계약이 없습니다. 최소 하나를 선택해 주세요."
  },
  LanguageConfig_TrinketBindRuleDesc_CN = {
    Text = "<Title:비밀 계약 결속>\n·수호자는 이제 각성체에 비밀 계약을 결속할 수 있습니다.\n·각성체의 각 슬롯에 비밀 계약 1개를 결속할 수 있으며, 총 6개입니다.\n·결속 후, 각 슬롯의 비밀 계약 주 속성이 추가로 50% 상승합니다.\n·결속된 비밀 계약은 「물자-비밀 계약」과 「제련실」에 표시되지 않습니다.\n·편성 및 각성체 조력자에서 각성체에 비밀 계약을 장착하지 않은 경우, 결속된 비밀 계약이 자동으로 장착됩니다.\n·결속된 비밀 계약 부품을 강화해도 결속 상태는 변경되지 않으며, 주 속성 상승은 강화 후 상태에 따라 업데이트됩니다.\n\n<Title:비밀 계약 분리>\n·비밀 계약 결속을 수정하거나 취소하려면 비밀 계약 결속 페이지에서 결속된 비밀 계약을 분리해야 합니다.\n·단일 부품 분리 시 동일 유형의 비밀 계약 10개가 필요합니다(슬롯 무관).\n·비밀 계약 분리 시, 이미 사용된 비밀 계약은 소재 선택 항목에 표시되지 않습니다."
  },
  LanguageConfig_TrinketBindSuccessTips_CN = {
    Text = "비밀 계약 결속 성공"
  },
  LanguageConfig_TrinketBind_CN = {Text = "결속"},
  LanguageConfig_TrinketChangeBindSuccessTips_CN = {
    Text = "비밀 계약 결속 수정 성공"
  },
  LanguageConfig_TrinketChangeBind_CN = {Text = "결속"},
  LanguageConfig_TrinketChooseForRecast_CN = {
    Text = "재인쇄할 비밀 계약 선택"
  },
  LanguageConfig_TrinketChooseLimited_CN = {
    Text = "비밀 계약 소지 수량이 최대치에 도달했습니다"
  },
  LanguageConfig_TrinketChoosenPartTitle_CN = {Text = "부위"},
  LanguageConfig_TrinketChoosenSuitTitle_CN = {Text = "프리셋"},
  LanguageConfig_TrinketChoosenTitle_CN = {
    Text = "비밀 계약 선택"
  },
  LanguageConfig_TrinketCompletionRate_CN = {
    Text = "비밀 계약 완성도"
  },
  LanguageConfig_TrinketContrast_CN = {Text = "비교"},
  LanguageConfig_TrinketConversionLockOneOption_CN = {
    Text = "「{s1}」을(를) 소모하여 잔본 보충"
  },
  LanguageConfig_TrinketConversionNewEnries_CN = {
    Text = "신규 부가 속성"
  },
  LanguageConfig_TrinketConversionOriEnries_CN = {
    Text = "기존 부가 속성"
  },
  LanguageConfig_TrinketConversionReplace_CN = {Text = "교체"},
  LanguageConfig_TrinketConversionRuleTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_TrinketConversionRule_CN = {
    Text = "<Title:전사>\n· 전사를 통해 비밀 계약의 부가 속성 종류와 수치를 변경할 수 있으며, 주 속성의 종류와 수치는 영향을 받지 않습니다.\n· 전사 시 부가 속성의 종류는 주 속성과 중복될 수 있으며, 부가 속성끼리도 같은 종류가 나올 수 있습니다.\n· 전사 시 부가 속성은 서로 다른 강도의 수치를 부여받습니다.\n· 비밀 계약 전사 기능을 개방한 이후, 새로 획득하는 비밀 계약은 자동으로 1회 무료 전사가 진행됩니다.\n<Title:잠금>\n· 전사할 때 특정 부가 속성을 유지하고 싶다면, 해당 부가 속성 옆의 잠금 버튼을 눌러 잠금할 수 있습니다. 잠근 부가 속성의 종류와 수치는 전사 시 보존됩니다.\n· 동시에 최대 2개의 부가 속성을 잠글 수 있습니다.\n· 부가 속성 1개를 잠그면 추가로 「비밀 계약 잔본」 20개가 필요하며, 부가 속성 2개를 잠그면 「추억의 깃펜」 10개가 필요합니다.\n· 부가 속성 1개만 잠글 경우, 「추억의 깃펜으로 잔본 보충」 옵션을 선택할 수 있습니다. 이를 활성화하면 현재 잔본이 부족할 때 자동으로 해당 수량만큼의 깃펜을 소모하여 전사가 진행됩니다."
  },
  LanguageConfig_TrinketConversion_CN = {Text = "전사"},
  LanguageConfig_TrinketCopyRules_CN = {
    Text = "1. 금지된 기록에서 스테이지를 클리어하면 비밀 계약을 획득할 수 있습니다.\n2. 추천 레벨에 따라 획득할 수 있는 비밀 계약의 수가 다릅니다.\n· 추천 레벨 35 스테이지는 1개의 비밀 계약을 획득할 수 있습니다.\n· 추천 레벨 45 스테이지는 2개의 비밀 계약을 획득할 수 있습니다.\n· 추천 레벨 55 스테이지는 3개의 비밀 계약을 획득할 수 있습니다.\n3. 각 장의 조사를 완료할 때마다 하나의 비밀 계약 스테이지가 해금됩니다."
  },
  LanguageConfig_TrinketDecomposeEmptyTips_CN = {
    Text = "분해할 수 있는 비밀 계약 없음"
  },
  LanguageConfig_TrinketDecomposeTitle_CN = {
    Text = "비밀 계약 분해"
  },
  LanguageConfig_TrinketEmptyStateTips_CN = {
    Text = "아직 현재 위치의 비밀 계약을 보유하지 않았습니다"
  },
  LanguageConfig_TrinketEntriesNone_CN = {
    Text = "속성 없음"
  },
  LanguageConfig_TrinketEquipped_CN = {Text = "장착됨"},
  LanguageConfig_TrinketFilterMainAttrTitle_CN = {
    Text = "주 속성: (위치에 따라 다름)"
  },
  LanguageConfig_TrinketFilterPartTitle_CN = {Text = "위치"},
  LanguageConfig_TrinketFilterSubAttrTitle_CN = {
    Text = "부가 속성"
  },
  LanguageConfig_TrinketFilterSuitTitle_CN = {Text = "세트"},
  LanguageConfig_TrinketGetNewEntries_CN = {
    Text = "전사를 통해 새로운 부가 속성을 추가"
  },
  LanguageConfig_TrinketInvalidPrompt_CN = {
    Text = "<Block:{s1}><Damage:6세트의 효과는 파티 내 유일한 효과로, 중복 적용될 수 없습니다. 현재 이 효과는 <Block:{s2}>에게 적용되었기 때문에, 이곳에서는 적용되지 않습니다.>"
  },
  LanguageConfig_TrinketIsLocked_CN = {
    Text = "비밀 계약이 잠겨 있습니다"
  },
  LanguageConfig_TrinketLevelUpTips_1_CN = {
    Text = "새로운 부가 속성 {s1}개 추가하기"
  },
  LanguageConfig_TrinketLevelUpTips_2_CN = {
    Text = "랜덤으로 부가 속성 {s1}개 부여하기"
  },
  LanguageConfig_TrinketLockedCannotSelectTips_CN = {
    Text = "비밀 계약이 잠겨 있어 선택할 수 없습니다"
  },
  LanguageConfig_TrinketMaterialNotEnough_CN = {
    Text = "수량 부족"
  },
  LanguageConfig_TrinketMaterialTypeName_CN = {
    Text = "비밀 계약 재료"
  },
  LanguageConfig_TrinketMustChooseThree_CN = {
    Text = "선택한 비밀 계약이 3개 미만이어서 재인쇄할 수 없습니다"
  },
  LanguageConfig_TrinketPlsSelect_CN = {
    Text = "비밀 계약 부위 선택"
  },
  LanguageConfig_TrinketStow_CN = {Text = "접기"},
  LanguageConfig_TrinketStrengCostItemNotEnoughTips_CN = {
    Text = "「천면인장」 부족"
  },
  LanguageConfig_TrinketStrengthNeed_CN = {Text = "필요"},
  LanguageConfig_TrinketStrengthTitle_CN = {
    Text = "비밀 계약 상세 정보"
  },
  LanguageConfig_TrinketStrengthenEmptyStateTips_1_CN = {
    Text = "장착되어 있지 않은 비밀 계약 혹은 재료 아이템을 보유하고 있지 않습니다"
  },
  LanguageConfig_TrinketStrengthenEmptyStateTips_2_CN = {
    Text = "장착되어 있지 않은 명륜을 보유하고 있지 않습니다"
  },
  LanguageConfig_TrinketStrengthenItemNum_1_CN = {
    Text = "비밀 계약 {s1}"
  },
  LanguageConfig_TrinketStrengthenItemNum_2_CN = {
    Text = "명륜 {s1}"
  },
  LanguageConfig_TrinketStrengthenLockTips_1_CN = {
    Text = "선택한 비밀 계약이 잠겨 있습니다, 재료로 사용하기 위해서는 잠금을 해제해야 합니다."
  },
  LanguageConfig_TrinketStrengthenLockTips_2_CN = {
    Text = "선택한 명륜이 잠겨 있습니다, 재료로 사용하기 위해서는 잠금을 해제해야 합니다."
  },
  LanguageConfig_TrinketStrengthenSuccess_1_CN = {
    Text = "강화 성공"
  },
  LanguageConfig_TrinketStrengthenSuccess_2_CN = {
    Text = "2배 강화 성공"
  },
  LanguageConfig_TrinketStrengthenSuccess_5_CN = {
    Text = "5배 강화 성공"
  },
  LanguageConfig_TrinketStrengthentTips_CN = {
    Text = "강화할 비밀 계약 선택"
  },
  LanguageConfig_TrinketSuitEditTitle_CN = {
    Text = "프리셋 편집"
  },
  LanguageConfig_TrinketSuitEffect_CN = {
    Text = "{s1}세트: {s2}"
  },
  LanguageConfig_TrinketSuitPlanNum_CN = {
    Text = "프리셋 수량"
  },
  LanguageConfig_TrinketSuitSavedTips_CN = {
    Text = "프리셋 이름을 입력하세요..."
  },
  LanguageConfig_TrinketSuitSavedTitle_CN = {
    Text = "프리셋 저장"
  },
  LanguageConfig_TrinketTypeName_CN = {
    Text = "비밀 계약"
  },
  LanguageConfig_TrinketUnBindSuccessTips_CN = {
    Text = "비밀 계약 분리 성공"
  },
  LanguageConfig_TrinketUnbindMaterialTitle_CN = {
    Text = "분리 소재 선택"
  },
  LanguageConfig_TrinketUnbind_CN = {Text = "분리"},
  LanguageConfig_TrinketUpgradeConsumeReturn_CN = {
    Text = "강화 재료 초과 반환"
  },
  LanguageConfig_TrinketUpgradeConsume_CN = {
    Text = "소모 재료"
  },
  LanguageConfig_TrinketUpgradeLevelSuccess_CN = {
    Text = "강화 성공"
  },
  LanguageConfig_TrinketUpgradeNoneMats_CN = {
    Text = "세트와 위치가 일치하는 비밀 계약이 없습니다"
  },
  LanguageConfig_TrinketUpgradeSelMats_CN = {
    Text = "업그레이드 재료 선택"
  },
  LanguageConfig_TrinketUpgrade_CN = {
    Text = "업그레이드"
  },
  LanguageConfig_Trinket_Suggest_Btn_CN = {Text = "추천"},
  LanguageConfig_TrinketsEquipedByAwakersTips_CN = {
    Text = "해당 비밀 계약은 이미 장비 중입니다. 교체하시겠습니까?"
  },
  LanguageConfig_TrinketsUpgradeMaxLevel_CN = {
    Text = "최대 레벨 도달"
  },
  LanguageConfig_TrinketsUpgradeMax_CN = {
    Text = "최대치까지 상승"
  },
  LanguageConfig_TrinketsUpgradeOne_CN = {
    Text = "1레벨 상승"
  },
  LanguageConfig_TripleKill_CN = {
    Text = "트리플 킬!!"
  },
  LanguageConfig_TripleSummonReward_CN = {
    Text = "깨어남 1회 · 보상 3배 획득"
  },
  LanguageConfig_Tuluhuodong1_CN = {
    Text = "「잠들기」 또는 「깨어나기」 선택"
  },
  LanguageConfig_TurnLockCardTips_CN = {
    Text = "사용할 수 있는 명령 카드가 남아있습니다. 위험한 상황에서는 아끼지 말고 사용하세요!"
  },
  LanguageConfig_TurnLockExSkillTips_CN = {
    Text = "광기 폭발이 준비되었습니다. 위험한 상황에서는 아끼지 말고 사용하세요!"
  },
  LanguageConfig_TurnLockPosseTips_CN = {
    Text = "은열쇠가 준비됐습니다. 위험한 상황에서는 아끼지 말고 사용하세요!"
  },
  LanguageConfig_TurntableProbabilityDesc_CN = {
    Text = "1, 환상 옷 보상은 5번째 추첨 때부터 나타납니다. 1~4회 추첨 시, 환상 옷 보상의 확률은 획득하지 않은 보상의 초기 확률에 따라 비율 분배됩니다.\n2, 보상 풀 내의 보상은 잠금되어 있으며, 이미 획득한 보상은 다시 나타나지 않습니다. 미획득 보상의 확률은 변경되며, 변경된 확률은「해당 보상의 초기 확률/（100%-획득한 보상의 초기 확률 총합）」입니다.\n3, 아래는 모든 보상의 구체적인 확률 전시로, 소수점 넷째 자리에서 반올림하여 전시됩니다."
  },
  LanguageConfig_TutorialReward_CN = {
    Text = "강의 수료 보상"
  },
  LanguageConfig_TutorialSearchResult_CN = {
    Text = "합계 <color=#5ef2ff>{s1}</color>개의 결과"
  },
  LanguageConfig_TutorialTaskLabel_CN = {Text = "도움말"},
  LanguageConfig_TutorialTitle_CN = {
    Text = "강의 모음"
  },
  LanguageConfig_TwoAndAHalfAnniversaryRAIDActiviityEndTime_CN = {
    Text = "체포 총수 달성 {s1} 일 후 종료"
  },
  LanguageConfig_UIBlockMaskTips_CN = {
    Text = "리소스 로딩 중, 잠시만 기다려 주세요"
  },
  LanguageConfig_UIKeeperSkillChooseAll_CN = {Text = "전부"},
  LanguageConfig_UIKeeperSkillChoose_CN = {Text = "선택"},
  LanguageConfig_UIKeeperSkillUsed_CN = {Text = "사용 중"},
  LanguageConfig_UI_Recharge_Panel_DayShopItemRefresh_CN = {
    Text = "{s1}일 {s2}시간"
  },
  LanguageConfig_UI_Recharge_Panel_DayShopItemRefresh_Hour_CN = {
    Text = "{s1}시간 {s2}분"
  },
  LanguageConfig_UI_Recharge_Panel_Deadline_CN = {
    Text = "{s1}일 {s2}시간 후 판매 종료"
  },
  LanguageConfig_UI_Recharge_Panel_Deadline_Hour_CN = {
    Text = "{s1}시간 {s2}분 후 판매 종료"
  },
  LanguageConfig_UI_Recharge_Panel_HaveItemCondition_CN = {
    Text = "{s1} 획득 후 해제"
  },
  LanguageConfig_UI_Recharge_Panel_HourShopItemRefresh_CN = {
    Text = "0일 {s1}시간"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Battle_Pass_CN = {
    Text = "과제 선물상자"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Diamond_Shop_CN = {
    Text = "「은심」 구매"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_AdvanceDC_CN = {
    Text = "침전 교환"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_GiftBag_CN = {
    Text = "컬렉션 패키지"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_CN = {
    Text = "달표면 관측"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_CN = {
    Text = "원액 추출"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_CN = {
    Text = "거품 교환"
  },
  LanguageConfig_UI_Recharge_Panel_PlayerLevelCondition_CN = {
    Text = "조사 등급 {s1} 달성 시 해제"
  },
  LanguageConfig_UI_Recharge_Panel_SpecialSaleDeadline_CN = {
    Text = "{s1}일 {s2}시간 후 종료"
  },
  LanguageConfig_UI_Recharge_Panel_SpecialSaleDeadline_Hour_CN = {
    Text = "{s1}시간 {s2}분 후 종료"
  },
  LanguageConfig_UI_WeekBoss_Refresh_CN = {
    Text = "{s1}일 {s2}시간 후 갱신"
  },
  LanguageConfig_UWHXSideDia1_CN = {
    Text = "하하... 고작 이 정도냐?"
  },
  LanguageConfig_UWHXSideDia2_CN = {
    Text = "장난은 끝이다, 이제 내 차례다!"
  },
  LanguageConfig_UWHXSideDia3_CN = {
    Text = "웃기는군. 내가 언제까지나 그놈한테 휘둘릴 거라 생각했나?"
  },
  LanguageConfig_UWHXSideDia4_CN = {
    Text = "우리는 별에서 온 존재... 결코 만족 따위는 모른다!"
  },
  LanguageConfig_UltlSkillNamePrefix_CN = {
    Text = "초월 폭발"
  },
  LanguageConfig_UltlSkillName_CN = {
    Text = "광기 폭발"
  },
  LanguageConfig_UltraPotencyCommingsoon_CN = {
    Text = "기대해주세요"
  },
  LanguageConfig_UltraPotencyDesc_CN = {
    Text = "깨어남체 인격 심화가 +12에 도달하면 “최종 법칙”이 활성화됩니다. 활성화되면 일부 독특한 효과를 얻을 수 있습니다."
  },
  LanguageConfig_UltraPotencyKeywords_CN = {
    Text = "<UltraPotencyKeywords:최종 법칙>"
  },
  LanguageConfig_UltraPotencyLockedName_CN = {
    Text = "최종 법칙"
  },
  LanguageConfig_UnGotStr_CN = {Text = "미보유"},
  LanguageConfig_Under_Investigation_Monster_CN = {
    Text = "조사 진행 중"
  },
  LanguageConfig_UniversalAlertTitle_CN = {Text = "알림"},
  LanguageConfig_UniversalCancelButton_CN = {Text = "취소"},
  LanguageConfig_UniversalConfirmButton_CN = {Text = "확인"},
  LanguageConfig_UniversalSettlementPhiloStone_CN = {
    Text = "{s1} 검은 인장"
  },
  LanguageConfig_UniversalUnlockButton_CN = {Text = "개방"},
  LanguageConfig_UnlockConditionExemption_CN = {
    Text = "\n<Gray:(이벤트 기간 동안 동조율 요구 조건 무시)>"
  },
  LanguageConfig_Unlockable_CN = {
    Text = "해제 가능"
  },
  LanguageConfig_Unranked_CN = {
    Text = "랭킹 기록 없음"
  },
  LanguageConfig_VerificationAgeFormat1_CN = {
    Text = "{s1}세 이하"
  },
  LanguageConfig_VerificationAgeFormat2_CN = {
    Text = "{s1}세~{s2}세"
  },
  LanguageConfig_VerificationAgeLimit_CN = {
    Text = "매월 최대 {s1}원"
  },
  LanguageConfig_VictoryAward_CN = {Text = "획득"},
  LanguageConfig_VindicateTitle_CN = {
    Text = "번식 광열"
  },
  LanguageConfig_VoiceActorTips_CN = {Text = "VA: {s1}"},
  LanguageConfig_WDZZMainDia1_CN = {
    Text = "#@...#?...#*"
  },
  LanguageConfig_WaitResponseTips_CN = {
    Text = "캠퍼스로 입장하기 위해 대기하는 중입니다, 잠시만 기다려 주세요."
  },
  LanguageConfig_WaitngTimeout2_CN = {
    Text = "대기 시간이 종료되었습니다. 다시 계약을 체결해 주세요"
  },
  LanguageConfig_WaitngTimeout_CN = {
    Text = "대기 시간 초과, 동일한 위상 값을 일치시킬 수 없습니다"
  },
  LanguageConfig_WakeFromSleep_CN = {Text = "옵니다!"},
  LanguageConfig_WangdaResonance15_1_CN = {
    Text = ", 랜덤 깨어남체 1명 깨어남"
  },
  LanguageConfig_WangdaResonance1_1_CN = {
    Text = ", 검은 인장을 Arg3 획득"
  },
  LanguageConfig_WeaponBreakthroughPlayerLevelRequire_CN = {
    Text = "수호자 등급 {s1} 필요"
  },
  LanguageConfig_WeaponBreakthroughSkillDesc_CN = {
    Text = "특수 능력"
  },
  LanguageConfig_WeaponBreakthroughTip_CN = {
    Text = "명륜을 {s1} 레벨로 상승시키면 다음 단계로 승격시킬 수 있습니다"
  },
  LanguageConfig_WeaponCurrRefineLevel_CN = {
    Text = "{s1} 단계"
  },
  LanguageConfig_WeaponDecomposeEmptyTips_CN = {
    Text = "분해할 수 있는 명륜 없음"
  },
  LanguageConfig_WeaponDecompositionCraftLimitTips_CN = {
    Text = "횟수는 과거 운명의 바퀴 분해 기록에서 비롯됩니다. 해당 횟수는 잠금값으로, 사용 후 복구할 수 없습니다."
  },
  LanguageConfig_WeaponEnhanceCost_CN = {
    Text = "소모 재료 ({s1}/{s2})"
  },
  LanguageConfig_WeaponEnhanceMtrlSortType_1_CN = {
    Text = "강화 등급"
  },
  LanguageConfig_WeaponEnhanceMtrlSortType_2_CN = {Text = "희귀도"},
  LanguageConfig_WeaponEnhanceMtrlType_1_CN = {Text = "에테르"},
  LanguageConfig_WeaponEnhanceMtrlType_2_CN = {
    Text = "R 이하의 명륜"
  },
  LanguageConfig_WeaponEnhanced_CN = {
    Text = "강화 완료"
  },
  LanguageConfig_WeaponExclusiveTips_CN = {
    Text = "장착자가 {s1}일 때, {s2}의 모든 카드가 황금색으로 변합니다."
  },
  LanguageConfig_WeaponHigherQuality_CN = {
    Text = "더 높은 희귀도"
  },
  LanguageConfig_WeaponInvalidPrompt_CN = {
    Text = "<Damage:동일한 명륜의 효과는 중복 적용될 수 없습니다. 현재 이 명륜 효과는 <Block:{s1}>에게 이미 적용되었으며, 이곳에서는 적용되지 않습니다.>"
  },
  LanguageConfig_WeaponLevelMaxSelectTips_CN = {
    Text = "{s1}은(는) 중첩 레벨 한도에 도달했습니다. 선택한 아이템을 변경해 주세요"
  },
  LanguageConfig_WeaponListEmpty_CN = {
    Text = "장착 가능한 명륜 없음"
  },
  LanguageConfig_WeaponOverflowReturn_CN = {
    Text = "초과 경험치 반환"
  },
  LanguageConfig_WeaponPoolGroupBtnTip_2_CN = {
    Text = "클릭하여 지정된 명륜 변경"
  },
  LanguageConfig_WeaponPoolGroupTitle_2_CN = {
    Text = "인과의 묘목"
  },
  LanguageConfig_WeaponPreviewTitle_CN = {
    Text = "명륜 미리보기"
  },
  LanguageConfig_WeaponRandomChestTipTitle_CN = {
    Text = "랜덤으로 명륜 획득"
  },
  LanguageConfig_WeaponRandomSelectTitle_CN = {
    Text = "랜덤 명륜 획득"
  },
  LanguageConfig_WeaponReachBreakthroughLimit_CN = {
    Text = "최대 레벨 달성"
  },
  LanguageConfig_WeaponReachNewRefineLevel_CN = {
    Text = "{s1} 단계로 중첩 완료"
  },
  LanguageConfig_WeaponRefineLevel_CN = {
    Text = "중첩 {s1}단계"
  },
  LanguageConfig_WeaponRefined_02_CN = {
    Text = "자동 겹침"
  },
  LanguageConfig_WeaponRefined_03_CN = {
    Text = "최대 스택 등급에 도달한 명륜이 자동으로 다른 자원으로 분해됩니다"
  },
  LanguageConfig_WeaponRefined_04_CN = {Text = "변환"},
  LanguageConfig_WeaponRefined_CN = {
    Text = "중첩 완료"
  },
  LanguageConfig_WeaponSelectPreviewDetailTips_CN = {
    Text = "명륜을 클릭하여 상세 정보 확인"
  },
  LanguageConfig_WeaponSelectTitle_CN = {
    Text = "명륜 선택"
  },
  LanguageConfig_WeaponSelectUseDetailTips_CN = {
    Text = "명륜을 길게 눌러 상세 정보 확인"
  },
  LanguageConfig_WeaponSortTypeName_1_CN = {Text = "레벨"},
  LanguageConfig_WeaponSortTypeName_2_CN = {Text = "희귀도"},
  LanguageConfig_WeaponSortTypeName_3_CN = {
    Text = "획득 순서"
  },
  LanguageConfig_WeaponSortTypeName_4_CN = {Text = "영역"},
  LanguageConfig_WeaponSortTypeName_5_CN = {
    Text = "스택 위치"
  },
  LanguageConfig_WeaponTypeName_CN = {Text = "명륜"},
  LanguageConfig_WeaponUnequip_2_CN = {
    Text = "장착되지 않은 명륜"
  },
  LanguageConfig_WeaponUnequip_CN = {Text = "미장착"},
  LanguageConfig_Weapon_Suggest_Btn_CN = {Text = "추천"},
  LanguageConfig_WeekChallengeAwakerCannotChoose_CN = {Text = "탈진"},
  LanguageConfig_WeekChallengeInstructions_CN = {
    Text = "<Title:【무광의 영역】>\n· 「무광의 영역」은 난이도가 높은 여러 관문으로 구성되어 있습니다. 보스를 격파하고 조사를 완료하면 풍성한 조사 보상을 받을 수 있습니다. 「무광의 영역」에서의 도전은 린피테이프를 소모하지 않습니다.\n<Title:【도전 규칙】>\n· 수호자는 스테이지의 보스를 격파하고 조사를 완료하여, 해당 조사에 대한 성급 평가를 받을 수 있습니다. 조사 점수의 성급이 높아질수록 다양한 보상을 획득할 수 있습니다.\n· 각기 다른 「무광의 영역」 스테이지에서는 수호자에게 고유한 초기 지원 유물이 제공되며, 이는 해당 던전 내에서만 유효합니다.\n· 동일한 「무광의 영역」 스테이지에서 특정 던전을 클리어하면, 현재 편성에 사용한 각 깨어남체가 기록됩니다. 같은 깨어남체는 다른 던전에서는 출전할 수 없습니다.\n· 이미 클리어한 스테이지는 진행 상황을 초기화할 수 있으며, 초기화 시 해당 스테이지에서 사용한 캐릭터와 성급 기록이 삭제됩니다. 이후 수호자는 편성을 재조정하고 도전을 계속할 수 있습니다."
  },
  LanguageConfig_WeekChallengeNotReached_1_CN = {
    Text = "다음 단계의 보상 조건이 충족되지 않았거나, 이미 모든 보상을 수령했습니다."
  },
  LanguageConfig_WeekChallengeNotReached_CN = {Text = "미달성"},
  LanguageConfig_WeekChallengeRewardHaveBeenObtained_CN = {
    Text = "모든 보상을 획득했습니다"
  },
  LanguageConfig_WeekChallengeRewardsPreview_CN = {
    Text = "도전 보상 미리보기"
  },
  LanguageConfig_WeekChallengeRulesOfPlay_CN = {
    Text = "무광의 영역"
  },
  LanguageConfig_WeekChallengeStarNumReach_CN = {
    Text = "현재 도전 성급"
  },
  LanguageConfig_WeeklyBossInstructions_CN = {
    Text = "<Title:전투 생략>\n· 「환몽 심잠」과 「초월적 존재」에서 보스가 아닌 적과 조우하기 전에 특수 이벤트가 발생합니다. 일정량의 체력을 소모하여 전투를 건너뛰고 즉시 적을 처치할 수 있습니다. 일반 적의 경우 최대 체력의 20%를 소모하고, 엘리트 적의 경우 최대 체력의 40%를 소모합니다. \n·이 이벤트를 유연하게 활용하면 “환몽 심잠”과 “초월적 존재”의 도전 속도를 크게 향상시킬 수 있습니다. \n\n<Title:보상 횟수>\n·매주 월요일 오전 9시(GMT+8)에 보상 횟수가 초기화됩니다. “초월적 존재”의 임의 스테이지를 클리어한 후 보상 횟수 1회를 소모하여 미션 보상을 받을 수 있습니다. \n·사용하지 않은 보상 횟수는 다음 주로 이월되지 않습니다."
  },
  LanguageConfig_WeeklyBossRemainTimes_CN = {
    Text = "이번 주「초월 존재」남은 횟수:<color={s1}>{s2}</color>/{s3}"
  },
  LanguageConfig_WeeklyBossTitle_CN = {
    Text = "규칙 설명"
  },
  LanguageConfig_WeeklyBoss_LvLimit_CN = {
    Text = "조사 등급 {s1}에 개방"
  },
  LanguageConfig_WeeklyRecordDesc_CN = {
    Text = "페이즈 체스와 환몽 심잠 승리 횟수 합계 {s1}판"
  },
  LanguageConfig_WeeklyRecord_CN = {
    Text = "주간 시련"
  },
  LanguageConfig_WeeklyTotalWinTaskDesc_CN = {
    Text = "시간 한정 이벤트, 환잠 또는 페이즈 체스에서 승리를 {s1}번 거둚 <color=#A3A6AB>({s2}/{s1})</color>"
  },
  LanguageConfig_WhiteEnchantConfigTypeName_CN = {
    Text = "<WhiteRelic:일반 각인>"
  },
  LanguageConfig_WhiteRelicTypeName_CN = {
    Text = "<WhiteRelic:백은 유물>"
  },
  LanguageConfig_WordItemDesc_CN = {
    Text = "키워드 설명"
  },
  LanguageConfig_Word_DiDi_CN = {Text = "남동생"},
  LanguageConfig_Word_GeGe_CN = {
    Text = "{Male=형,Female=오빠}"
  },
  LanguageConfig_Word_He_CN = {Text = "그"},
  LanguageConfig_Word_JieJie_CN = {
    Text = "{Male=누나,Female=언니}"
  },
  LanguageConfig_Word_LordLady_CN = {Text = "아가씨"},
  LanguageConfig_Word_Lord_CN = {Text = "도련님"},
  LanguageConfig_Word_Madam_CN = {Text = "아가씨"},
  LanguageConfig_Word_MeiMei_CN = {Text = "여동생"},
  LanguageConfig_Word_She_CN = {Text = "그녀"},
  LanguageConfig_Word_Sir_CN = {Text = "선생님"},
  LanguageConfig_WorldBossDoing_CN = {
    Text = "다른 수호자들과 함께 싸워 희귀한 보상을 얻으세요"
  },
  LanguageConfig_WorldBossDone_CN = {
    Text = "모든 원초의 눈의 분신이 소멸되었습니다."
  },
  LanguageConfig_WorldstageShopRelicStrengthTitle_CN = {Text = "제사"},
  LanguageConfig_WorldstageShopRelicStrength_CN = {
    Text = "검은 인장을 소비하여 백은 유물을 황금 유물로 강화할 수 있으며, 강화를 진행할 때마다 비용이 증가합니다."
  },
  LanguageConfig_XLMainDia1_CN = {
    Text = "흥, 너희 쯤이야."
  },
  LanguageConfig_XLMainDia2_CN = {
    Text = "날 막을 생각은 꿈도 꾸지 마!"
  },
  LanguageConfig_XLMainDia3_CN = {
    Text = "릴리를... 돌려줘!"
  },
  LanguageConfig_XLMainDia4_CN = {
    Text = "와라, 로탄!"
  },
  LanguageConfig_XLMainDia5_CN = {
    Text = "승부를 내자!"
  },
  LanguageConfig_XLMainDia6_CN = {
    Text = "난 아직... 지지 않았어!"
  },
  LanguageConfig_XuanWoHuodong1_CN = {
    Text = "갑자기 놀러 온 꼬마 석탄 2세를 마주하게 되면, 당신의 선택은……"
  },
  LanguageConfig_chaotype2_pack_select_title_CN = {
    Text = "은열쇠 1세트를 선택하여 순서대로 해방"
  },
  LanguageConfig_chaotype2_teamskill_desc_CN = {
    Text = "{s1}이(가) 추가로 1회 반복됩니다."
  },
  LanguageConfig_chaotype2_teamskill_name_CN = {
    Text = "이중·{s1}"
  },
  LanguageConfig_laikegamblingsuccess_CN = {
    Text = "배팅의 지혜 - 쌍발"
  },
  LanguageConfig_risk_error_msg_freqControl_CN = {
    Text = "캐릭터 생성 수량이 최대치에 도달했습니다."
  },
  LanguageConfig_risk_error_msg_maliciousAction_CN = {
    Text = "위반 행위가 감지되었습니다, [고객 센터]로 이동하여 문의 접수를 해주세요."
  },
  LanguageConfig_risk_error_msg_maliciousEnv_CN = {
    Text = "디바이스 또는 네트워크에 문제가 발생했습니다. 잠시 후에 다시 시도해 주세요."
  },
  LanguageConfig_risk_error_msg_requestLimit_CN = {
    Text = "시스템이 혼잡합니다. 잠시 후에 다시 시도해 주세요."
  },
  LanguageConfig_setUp_CN = {Text = "설정"},
  LanguageConfig_statistic_battle_filter_all_CN = {
    Text = "모든 전투"
  },
  LanguageConfig_statistic_battle_filter_boss_CN = {
    Text = "보스 전투"
  },
  LanguageConfig_statistic_battle_filter_common_CN = {
    Text = "일반 전투"
  },
  LanguageConfig_statistic_battle_filter_elite_CN = {
    Text = "엘리트 전투"
  },
  LanguageConfig_statistic_bout_filter_all_CN = {Text = "모든 턴"},
  LanguageConfig_statistic_bout_filter_turn_CN = {Text = "제{s1}턴"},
  LanguageConfig_statistic_state_concept_FinalVerdict_CN = {
    Text = "운명 재단"
  },
  LanguageConfig_statistic_state_concept_bleed_CN = {Text = "출혈"},
  LanguageConfig_statistic_state_concept_corrosion_CN = {Text = "부식"},
  LanguageConfig_statistic_state_concept_counterattack_CN = {Text = "반격"},
  LanguageConfig_statistic_state_concept_poison_CN = {Text = "중독"},
  LanguageConfig_statistic_state_concept_sacrifice_CN = {
    Text = "헌신의 제사"
  },
  LanguageConfig_statistic_type_filter_block_CN = {Text = "방어막"},
  LanguageConfig_statistic_type_filter_damage_CN = {Text = "피해"},
  LanguageConfig_statistic_type_filter_heal_CN = {Text = "치료"},
  LanguageConfig_test_api_a1_CN = {
    Text = "은열쇠 1세트를 선택하여 순서대로 해방"
  },
  LanguageConfig_test_api_a2_CN = {
    Text = "2라운드 반드시 2명을 선택하여 표시 부여"
  },
  LanguageConfig_test_api_a3_CN = {
    Text = "3라운드 선택적으로 2명에게 표시 부여"
  },
  LanguageConfig_test_api_a4_CN = {
    Text = "4라운드 {상태@공 상태}인 대상을 필터링하여\n반드시 4명을 선택하여 표시 부여"
  },
  LanguageConfig_yixiang10_1_CN = {Text = "꽃다발"},
  LanguageConfig_yixiang10_2_CN = {Text = "꽃다발"},
  LanguageConfig_yixiang10_3_CN = {Text = "꽃다발"},
  LanguageConfig_yixiang10_CN = {Text = "꽃다발"},
  LanguageConfig_yixiang11_1_CN = {Text = "고양이"},
  LanguageConfig_yixiang11_2_CN = {Text = "고양이"},
  LanguageConfig_yixiang11_3_CN = {Text = "고양이"},
  LanguageConfig_yixiang11_CN = {Text = "고양이"},
  LanguageConfig_yixiang12_1_CN = {Text = "대지"},
  LanguageConfig_yixiang12_2_CN = {Text = "대지"},
  LanguageConfig_yixiang12_3_CN = {Text = "대지"},
  LanguageConfig_yixiang12_CN = {Text = "대지"},
  LanguageConfig_yixiang13_1_CN = {Text = "샘물"},
  LanguageConfig_yixiang13_2_CN = {Text = "샘물"},
  LanguageConfig_yixiang13_3_CN = {Text = "샘물"},
  LanguageConfig_yixiang13_CN = {Text = "샘물"},
  LanguageConfig_yixiang14_1_CN = {Text = "달"},
  LanguageConfig_yixiang14_2_CN = {Text = "달"},
  LanguageConfig_yixiang14_3_CN = {Text = "달"},
  LanguageConfig_yixiang14_CN = {Text = "달"},
  LanguageConfig_yixiang1_1_CN = {Text = "태양"},
  LanguageConfig_yixiang1_2_CN = {Text = "태양"},
  LanguageConfig_yixiang1_3_CN = {Text = "태양"},
  LanguageConfig_yixiang1_CN = {Text = "태양"},
  LanguageConfig_yixiang2_1_CN = {Text = "별"},
  LanguageConfig_yixiang2_2_CN = {Text = "별"},
  LanguageConfig_yixiang2_3_CN = {Text = "별"},
  LanguageConfig_yixiang2_CN = {Text = "별"},
  LanguageConfig_yixiang3_1_CN = {Text = "봄"},
  LanguageConfig_yixiang3_2_CN = {Text = "봄"},
  LanguageConfig_yixiang3_3_CN = {Text = "봄"},
  LanguageConfig_yixiang3_CN = {Text = "봄"},
  LanguageConfig_yixiang4_1_CN = {Text = "시구"},
  LanguageConfig_yixiang4_2_CN = {Text = "시구"},
  LanguageConfig_yixiang4_3_CN = {Text = "시구"},
  LanguageConfig_yixiang4_CN = {Text = "시구"},
  LanguageConfig_yixiang5_1_CN = {Text = "나비"},
  LanguageConfig_yixiang5_2_CN = {Text = "나비"},
  LanguageConfig_yixiang5_3_CN = {Text = "나비"},
  LanguageConfig_yixiang5_CN = {Text = "나비"},
  LanguageConfig_yixiang6_1_CN = {Text = "구름"},
  LanguageConfig_yixiang6_2_CN = {Text = "구름"},
  LanguageConfig_yixiang6_3_CN = {Text = "구름"},
  LanguageConfig_yixiang6_CN = {Text = "구름"},
  LanguageConfig_yixiang7_1_CN = {Text = "바람"},
  LanguageConfig_yixiang7_2_CN = {Text = "바람"},
  LanguageConfig_yixiang7_3_CN = {Text = "바람"},
  LanguageConfig_yixiang7_CN = {Text = "바람"},
  LanguageConfig_yixiang8_1_CN = {Text = "숲"},
  LanguageConfig_yixiang8_2_CN = {Text = "숲"},
  LanguageConfig_yixiang8_3_CN = {Text = "숲"},
  LanguageConfig_yixiang8_CN = {Text = "숲"},
  LanguageConfig_yixiang9_1_CN = {Text = "눈"},
  LanguageConfig_yixiang9_2_CN = {Text = "눈"},
  LanguageConfig_yixiang9_3_CN = {Text = "눈"},
  LanguageConfig_yixiang9_CN = {Text = "눈"}
})
return Text_LanguageConfig
