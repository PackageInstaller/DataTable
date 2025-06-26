-- chunkname: @IQIGame\\UIExternalApi\\ActivityUIApi.lua

ActivityUIApi = BaseLangApi:Extend()

function ActivityUIApi:Init()
	self:RegisterApi("tabBtn", self.GetTabBtnTxt)
	self:RegisterApi("tabEngBtn", self.GetTabEngBtnTxt)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("viewPath", self.GetViewPath)
	self:RegisterApi("goSignDesc", self.GetSignDesc)
	self:RegisterApi("goTonicDesc", self.GetTonicDesc)
	self:RegisterApi("goCostDesc", self.GetCostDesc)
	self:RegisterApi("goBtnTonic", self.GetBtnTonicTxt)
	self:RegisterApi("goBtnSign", self.GetBtnSignTxt)
	self:RegisterApi("goTonicSignDesc", self.GetTonicSignDesc)
	self:RegisterApi("signViewDayPath", self.GetSignViewDayPath)
	self:RegisterApi("signViewCount", self.GetSignViewCount)
	self:RegisterApi("signViewBtnDetailTxt", self.GetSignViewBtnDetailTxt)
	self:RegisterApi("signViewTime", self.GetSignViewTime)
	self:RegisterApi("paidViewBtnDetailTxt", self.GetPaidViewBtnDetailTxt)
	self:RegisterApi("paidViewTime", self.GetPaidViewTime)
	self:RegisterApi("paidViewTaskDesc", self.GetPaidViewTaskDesc)
	self:RegisterApi("paidViewTaskTarget", self.GetPaidViewTaskTarget)
	self:RegisterApi("paidViewRewardDay", self.GetPaidViewRewardDay)
	self:RegisterApi("paidViewActivityName", self.GetPaidViewActivityName)
	self:RegisterApi("paidViewDesc_1", self.GetPaidViewDesc_1)
	self:RegisterApi("paidViewDesc_2", self.GetPaidViewDesc_2)
	self:RegisterApi("paidViewDesc_3", self.GetPaidViewDesc_3)
	self:RegisterApi("paidViewBuyTxt", self.GetPaidViewBuyTxt)
	self:RegisterApi("paidViewRewardCount", self.GetPaidViewRewardCount)
	self:RegisterApi("paidViewLockTxtPath", self.GetPaidViewLockTxtPath)
	self:RegisterApi("furGashView", self.GetFurGashViewTime)
	self:RegisterApi("furGashViewDesc", self.GetFurGashViewDesc)
	self:RegisterApi("furGashViewBtnLotteryPoolTxt", self.GetFurGashViewBtnLotteryPoolTxt)
	self:RegisterApi("furGashViewBtnTheme_1", self.GetFurGashViewBtnTheme_1)
	self:RegisterApi("furGashViewBtnTheme_2", self.GetFurGashViewBtnTheme_2)
	self:RegisterApi("furGashViewBtnBuyTxt", self.GetFurGashViewBtnBuyTxt)
	self:RegisterApi("furGashViewBtnBatchBuyTxt", self.GetFurGashViewBtnBatchBuyTxt)
	self:RegisterApi("furGashViewBuyCount", self.GetFurGashViewBuyCount)
	self:RegisterApi("furGashViewBatchBuyCount", self.GetFurGashViewBatchBuyCount)
	self:RegisterApi("furGashViewThemeCid", self.GetFurGashViewThemeCid)
	self:RegisterApi("FoodTitleText", self.GetFoodTitleText)
	self:RegisterApi("FoodSubTitleText", self.GetFoodSubTitleText)
	self:RegisterApi("FoodTipText", self.GetFoodTipText)
	self:RegisterApi("FoodItemTitleText", self.GetFoodItemTitleText)
	self:RegisterApi("FoodItemTimeText", self.GetFoodItemTimeText)
	self:RegisterApi("FoodItemContentText", self.GetFoodItemContentText)
	self:RegisterApi("FoodItemIcon", self.GetFoodItemIcon)
	self:RegisterApi("FoodItemNotTimeText", self.GetFoodItemNotTimeText)
	self:RegisterApi("FoodItemClaimedText", self.GetFoodItemClaimedText)
	self:RegisterApi("FoodItemFreeClaimBtnText", self.GetFoodItemFreeClaimBtnText)
	self:RegisterApi("FoodItemCostClaimBtnText", self.GetFoodItemCostClaimBtnText)
	self:RegisterApi("FoodItemCostLabel", self.GetFoodItemCostLabel)
	self:RegisterApi("goBtnTest", self.GetBtnTestText)
	self:RegisterApi("turn_toggleRule", self.turn_toggleRule)
	self:RegisterApi("turn_toggleRecord", self.turn_toggleRecord)
	self:RegisterApi("turn_btnTurn", self.turn_btnTurn)
	self:RegisterApi("turn_turnTips", self.turn_turnTips)
	self:RegisterApi("turn_ruleInfo", self.turn_ruleInfo)
	self:RegisterApi("turn_remainTimes", self.turn_remainTimes)
	self:RegisterApi("turn_txtTitle", self.turn_txtTitle)
	self:RegisterApi("turn_txtDate", self.turn_txtDate)
	self:RegisterApi("turn_btnTurn2", self.turn_btnTurn2)
	self:RegisterApi("turn_txtRecord", self.turn_txtRecord)
	self:RegisterApi("commit_title", self.commit_title)
	self:RegisterApi("commit_nameInGame", self.commit_nameInGame)
	self:RegisterApi("commit_name1", self.commit_name1)
	self:RegisterApi("commit_name2", self.commit_name2)
	self:RegisterApi("commit_phone1", self.commit_phone1)
	self:RegisterApi("commit_phone2", self.commit_phone2)
	self:RegisterApi("commit_address1", self.commit_address1)
	self:RegisterApi("commit_address2", self.commit_address2)
	self:RegisterApi("commit_declare", self.commit_declare)
	self:RegisterApi("commit_cancel", self.commit_cancel)
	self:RegisterApi("commit_ok", self.commit_ok)
	self:RegisterApi("moonLogin_stateDesc", self.GetMoonLoginStateDesc)
	self:RegisterApi("moonLogin_dayDesc", self.GetMoonLoginDayDesc)
	self:RegisterApi("moonLogin_title1", self.GetMoonTipTitle1)
	self:RegisterApi("moonLogin_title2", self.GetMoonLoginTitle2)
	self:RegisterApi("moonLogin_title3", self.GetMoonLoginTitle3)
	self:RegisterApi("moonLogin_desc1", self.GetMoonLoginDesc1)
	self:RegisterApi("moonLogin_desc2", self.GetMoonLoginDesc2)
	self:RegisterApi("moodStartDate", self.GetMoodStartDate)
	self:RegisterApi("moodEndDate", self.GetMoodEndDate)
	self:RegisterApi("moonTip_title1", self.GetMoonTipTitle1)
	self:RegisterApi("moonTip_title2", self.GetMoonTipTitle2)
	self:RegisterApi("moonTip_desc1", self.GetMoonTipDesc1)
	self:RegisterApi("moonTip_desc2", self.GetMoonTipDesc2)
	self:RegisterApi("moonTip_npc1", self.GetMoonTipNpc1)
	self:RegisterApi("moonTip_npc2", self.GetMoonTipNpc2)
	self:RegisterApi("nationalDay_stateDesc", self.GetNationalDayStateDesc)
	self:RegisterApi("nationalDay_dayDesc", self.GetNationalDayDayDesc)
	self:RegisterApi("nationalDay_title1", self.GetNationalDayTitle1)
	self:RegisterApi("nationalDay_title2", self.GetNationalDayTitle2)
	self:RegisterApi("nationalDay_title3", self.GetNationalDayTitle3)
	self:RegisterApi("nationalDay_desc1", self.GetNationalDayDesc1)
	self:RegisterApi("nationalDay_desc2", self.GetNationalDayDesc2)
	self:RegisterApi("nationalDayStartDate", self.GetNationalDayStartDate)
	self:RegisterApi("nationalDayEndDate", self.GetNationalDayEndDate)
	self:RegisterApi("TextTimeTitle", self.GetTextTimeTitle)
	self:RegisterApi("TextReturn", self.GetTextReturn)
	self:RegisterApi("TextBuyService", self.GetTextBuyService)
	self:RegisterApi("TextNext", self.GetTextNext)
	self:RegisterApi("TextCurrent", self.GetTextCurrent)
	self:RegisterApi("TextHaveNum", self.GetTextHaveNum)
	self:RegisterApi("TextBuyOver", self.GetTextBuyOver)
	self:RegisterApi("TextOverValue", self.GetTextOverValue)
	self:RegisterApi("TextCurrentValue", self.GetTextCurrentValue)
	self:RegisterApi("TextTimeClose", self.GetTextTimeClose)
	self:RegisterApi("TextBuyServiceValue", self.GetTextBuyServiceValue)
	self:RegisterApi("TextPictureTitle", self.GetTextPictureTitle)
	self:RegisterApi("TextTaskReward", self.GetTextTaskReward)
	self:RegisterApi("TextDayReward", self.GetTextDayReward)
	self:RegisterApi("TextBtnTask", self.GetTextBtnTask)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("TextRewardCount", self.GetTextRewardCount)
	self:RegisterApi("TextHave", self.GetTextHave)
	self:RegisterApi("TextNeed", self.GetTextNeed)
	self:RegisterApi("TextBtnUnlockPic", self.GetTextBtnUnlockPic)
	self:RegisterApi("TextPicTimeClose", self.GetTextPicTimeClose)
	self:RegisterApi("TextCompletedDes", self.GetTextCompletedDes)
	self:RegisterApi("TextUnlockReward", self.GetTextUnlockReward)
	self:RegisterApi("TextCompleted", self.GetTextCompleted)
	self:RegisterApi("TextBtnIntroduction", self.GetTextBtnIntroduction)
	self:RegisterApi("TextTodayWords", self.GetTextTodayWords)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextBtnEnter", self.GetTextBtnEnter)
	self:RegisterApi("TextOpenTime", self.GetTextOpenTime)
	self:RegisterApi("TextFight", self.GetTextFight)
	self:RegisterApi("TextBossLevel", self.GetTextBossLevel)
	self:RegisterApi("TextFightNum", self.GetTextFightNum)
	self:RegisterApi("TextKilled", self.GetTextKilled)
	self:RegisterApi("TextMonsterList", self.GetTextMonsterList)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextChallengeBtn", self.GetTextChallengeBtn)
	self:RegisterApi("TextNewCharacterOpenTime", self.GetTextNewCharacterOpenTime)
	self:RegisterApi("NewCharacterTextOpen", self.GetNewCharacterTextOpen)
	self:RegisterApi("TextBtnTip", self.GetTextBtnTip)
	self:RegisterApi("TextBtnBingo", self.GetTextBtnBingo)
	self:RegisterApi("TextBtnStory", self.GetTextBtnStory)
	self:RegisterApi("TextBtnNewCharacterTask", self.GetTextBtnNewCharacterTask)
	self:RegisterApi("TextTotalScore", self.GetTextTotalScore)
	self:RegisterApi("TextEXPRESS", self.GetTextEXPRESS)
	self:RegisterApi("GachaRateUpLabel", self.GetGachaRateUpLabel)
	self:RegisterApi("GachaRateUpValueText", self.GetGachaRateUpValueText)
	self:RegisterApi("GachaCostItemNumText", self.GetGachaCostItemNumText)
	self:RegisterApi("GachaDrawBtnText", self.GetGachaDrawBtnText)
	self:RegisterApi("GachaRewardGotViewText", self.GetGachaRewardGotViewText)
	self:RegisterApi("GachaRollingEffectDuration", self.GetGachaRollingEffectDuration)
	self:RegisterApi("GachaProgressEffectMaskTilingX", self.GetGachaProgressEffectMaskTilingX)
	self:RegisterApi("GachaProgressEffectSpeed", self.GetGachaProgressEffectSpeed)
	self:RegisterApi("GachaCellEffectDuration", self.GetGachaCellEffectDuration)
	self:RegisterApi("GachaRateUpDescText", self.GetGachaRateUpDescText)
	self:RegisterApi("InvasionTextOpenTime", self.GetInvasionTextOpenTime)
	self:RegisterApi("InvasionTextBtnGetReward", self.GetInvasionTextBtnGetReward)
	self:RegisterApi("InvasionTextUp", self.GetInvasionTextUp)
	self:RegisterApi("InvasionTextDown", self.GetInvasionTextDown)
	self:RegisterApi("InvasionTextLock", self.GetInvasionTextLock)
	self:RegisterApi("InvasionTextFormation", self.GetInvasionTextFormation)
	self:RegisterApi("InvasionTextSoulGrid", self.GetInvasionTextSoulGrid)
	self:RegisterApi("InvasionTextScore", self.GetInvasionTextScore)
	self:RegisterApi("InvasionTextBtnTip", self.GetInvasionTextBtnTip)
	self:RegisterApi("SpaceTextBtnClaim", self.GetSpaceTextBtnClaim)
	self:RegisterApi("SpaceTextOpenTime", self.GetSpaceTextOpenTime)
	self:RegisterApi("SpaceTreasureCellItemNum", self.GetSpaceTreasureCellItemNum)
	self:RegisterApi("SpaceTextSpendPower", self.GetSpaceTextSpendPower)
	self:RegisterApi("SpaceTextGetMsg", self.GetSpaceTextGetMsg)
	self:RegisterApi("SpaceTextSpendItem", self.GetSpaceTextSpendItem)
	self:RegisterApi("SpaceTextTitleMsg", self.GetSpaceTextTitleMsg)
	self:RegisterApi("LuckyBtnLotteryPoolTitle", self.GetLuckyBtnLotteryPoolTitle)
	self:RegisterApi("LuckyTextDes", self.GetLuckyTextDes)
	self:RegisterApi("LuckyBtnProbabilityTitle", self.GetLuckyBtnProbabilityTitle)
	self:RegisterApi("LuckyBtnLotteryRecordTitle", self.GetLuckyBtnLotteryRecordTitle)
	self:RegisterApi("LuckyBtnBuyTitle1", self.GetLuckyBtnBuyTitle1)
	self:RegisterApi("LuckyBtnBuyTitle2", self.GetLuckyBtnBuyTitle2)
	self:RegisterApi("LuckyBtnBatchBuyTitle1", self.GetLuckyBtnBatchBuyTitle1)
	self:RegisterApi("LuckyBtnBatchBuyTitle2", self.GetLuckyBtnBatchBuyTitle2)
	self:RegisterApi("PandaOpenTime", self.GetPandaOpenTime)
	self:RegisterApi("PandaBtnFeedLabel", self.GetPandaBtnFeedLabel)
	self:RegisterApi("PandaNeed", self.GetPandaNeed)
	self:RegisterApi("PandaNeedValue", self.GetPandaNeedValue)
	self:RegisterApi("PandaBtnWashLabel", self.GetPandaBtnWashLabel)
	self:RegisterApi("PandaBtnInteract", self.GetPandaBtnInteract)
	self:RegisterApi("PandaBtnExploreLabel", self.GetPandaBtnExploreLabel)
	self:RegisterApi("PandaFavorTitle", self.GetPandaFavorTitle)
	self:RegisterApi("PandaBtnShopLabel", self.GetPandaBtnShopLabel)
	self:RegisterApi("PandaTextUpGrade", self.GetPandaTextUpGrade)
	self:RegisterApi("PandaTextMaxTip", self.GetPandaTextMaxTip)
	self:RegisterApi("VoteMostPopularDes", self.GetVoteMostPopularDes)
	self:RegisterApi("VoteBtnVoteLabel", self.GetVoteBtnVoteLabel)
	self:RegisterApi("VoteNeedText", self.GetVoteNeedText)
	self:RegisterApi("ReplacementBtnBuyLabel", self.GetReplacementBtnBuyLabel)
	self:RegisterApi("ReplacementPassName1", self.GetReplacementPassName1)
	self:RegisterApi("ReplacementImgNum", self.GetReplacementImgNum)
	self:RegisterApi("NewYearTextOpenTime", self.GetNewYearTextOpenTime)
	self:RegisterApi("NewYearBtnExchangeLabel", self.GetNewYearBtnExchangeLabel)
	self:RegisterApi("NewYearBtnCollectingLabel", self.GetNewYearBtnCollectingLabel)
	self:RegisterApi("NewYearBtnCollectedLabel", self.GetNewYearBtnCollectedLabel)
	self:RegisterApi("NewYearTextRemainingTimes", self.GetNewYearTextRemainingTimes)
	self:RegisterApi("PureExhibitionOpenTime", self.GetPureExhibitionOpenTime)
	self:RegisterApi("DropExchangeTitle1", self.GetDropExchangeTitle1)
	self:RegisterApi("DropExchangeTextDay", self.GetDropExchangeTextDay)
	self:RegisterApi("DropExchangeTextLabel", self.GetDropExchangeTextLabel)
	self:RegisterApi("DropExchangeTextGetValue", self.GetDropExchangeTextGetValue)
	self:RegisterApi("DropExchangeTextTip", self.GetDropExchangeTextTip)
	self:RegisterApi("DropExchangeBtnShopLabel", self.GetDropExchangeBtnShopLabel)
	self:RegisterApi("DropExchangeTextCloseTime", self.GetDropExchangeTextCloseTime)
	self:RegisterApi("DropExchangeDesc1", self.GetDropExchangeDesc1)
	self:RegisterApi("ActivityTurnTime", self.GetActivityTurnTime)
	self:RegisterApi("LimitedCellTagNum", self.GetLimitedCellTagNum)
	self:RegisterApi("LimitedTextDes", self.GetLimitedTextDes)
	self:RegisterApi("LimitedBtnProbabilityTitle", self.GetLimitedBtnProbabilityTitle)
	self:RegisterApi("LimitedBtnLotteryRecordTitle", self.GetLimitedBtnLotteryRecordTitle)
	self:RegisterApi("LimitedBtnBuyTitle1", self.GetLimitedBtnBuyTitle1)
	self:RegisterApi("LimitedBtnBuyTitle2", self.GetLimitedBtnBuyTitle2)
	self:RegisterApi("LimitedBtnBatchBuyTitle1", self.GetLimitedBtnBatchBuyTitle1)
	self:RegisterApi("LimitedBtnBatchBuyTitle2", self.GetLimitedBtnBatchBuyTitle2)
	self:RegisterApi("LimitedBtnDetails", self.GetLimitedBtnDetails)
	self:RegisterApi("LimitedTextTitle", self.GetLimitedTextTitle)
	self:RegisterApi("LimitedTextTimeStart", self.GetLimitedTextTimeStart)
	self:RegisterApi("LimitedTextTimeEnd", self.GetLimitedTextTimEnd)
	self:RegisterApi("LimitedTestDes", self.GetLimitedTestDes)
	self:RegisterApi("FreeReward_TaskItem_ProgressText", self.GetFreeReward_TaskItem_ProgressText)
	self:RegisterApi("FreeReward_TaskItem_FinishedBtnText", self.GetFreeReward_TaskItem_FinishedBtnText)
	self:RegisterApi("CupVotingStartTime", self.GetCupVotingStartTime)
	self:RegisterApi("CupVotingEndTime", self.GetCupVotingEndTime)
	self:RegisterApi("CupVotingImgTitlePath", self.GetCupVotingImgTitlePath)
	self:RegisterApi("CupVotingBtnLookRankLabel", self.GetCupVotingBtnLookRankLabel)
	self:RegisterApi("CupVotingBtnDesLabel", self.GetCupVotingBtnDesLabel)
	self:RegisterApi("CupVotingTextRank", self.GetCupVotingTextRank)
	self:RegisterApi("CupVotingTipText", self.GetCupVotingTipText)
	self:RegisterApi("CupVotingTextVotesNum", self.GetCupVotingTextVotesNum)
end

function ActivityUIApi:GetCupVotingTextVotesNum(num)
	return string.format(self:GetCfgText(8001036), num)
end

function ActivityUIApi:GetCupVotingTipText()
	return self:GetCfgText(1233655)
end

function ActivityUIApi:GetCupVotingTextRank(index)
	return string.format(self:GetCfgText(1233653), index)
end

function ActivityUIApi:GetCupVotingBtnDesLabel()
	return self:GetCfgText(1233651)
end

function ActivityUIApi:GetCupVotingBtnLookRankLabel()
	return self:GetCfgText(1233652)
end

function ActivityUIApi:GetCupVotingImgTitlePath(stage)
	if stage == 0 then
		return self:GetResUrl(1702250)
	elseif stage == 1 then
		return self:GetResUrl(1702251)
	elseif stage == 2 then
		return self:GetResUrl(1702252)
	elseif stage == 3 then
		return self:GetResUrl(1702252)
	end

	return self:GetResUrl(1702252)
end

function ActivityUIApi:GetCupVotingEndTime(endYear, endMoth, endDay, endHM)
	return string.format("%s/%s/%s %s", endYear, endMoth, endDay, endHM)
end

function ActivityUIApi:GetCupVotingStartTime(startYear, startMoth, startDay, startHM)
	return string.format("%s/%s/%s %s", startYear, startMoth, startDay, startHM)
end

function ActivityUIApi:GetLimitedTestDes(value)
	if value == 0 then
		return self:GetCfgText(1233649)
	end

	return string.format(self:GetCfgText(1233198), value)
end

function ActivityUIApi:GetLimitedTextTimEnd(startYear, endMoth, endDay, endHM)
	return string.format("%s\n%s.%s.%s", endHM, startYear, endMoth, endDay)
end

function ActivityUIApi:GetLimitedTextTimeStart(endYear, startMoth, startDay, startHM)
	return string.format("%s.%s.%s\n%s", endYear, startMoth, startDay, startHM)
end

function ActivityUIApi:GetLimitedTextTitle()
	return self:GetCfgText(1233190)
end

function ActivityUIApi:GetLimitedBtnDetails()
	return self:GetCfgText(1233191)
end

function ActivityUIApi:GetLimitedBtnBatchBuyTitle2()
	return self:GetCfgText(1233192)
end

function ActivityUIApi:GetLimitedBtnBatchBuyTitle1(name, num)
	return string.format(self:GetCfgText(1233194), name, num)
end

function ActivityUIApi:GetLimitedBtnBuyTitle2()
	return self:GetCfgText(1233193)
end

function ActivityUIApi:GetLimitedBtnBuyTitle1(name, num)
	return string.format(self:GetCfgText(1233194), name, num)
end

function ActivityUIApi:GetLimitedBtnLotteryRecordTitle()
	return self:GetCfgText(1233195)
end

function ActivityUIApi:GetLimitedBtnProbabilityTitle()
	return self:GetCfgText(1233196)
end

function ActivityUIApi:GetLimitedTextDes()
	return self:GetCfgText(1233197)
end

function ActivityUIApi:GetLimitedCellTagNum(num)
	if num > 0 then
		CountColor = 30
	else
		CountColor = 28
	end

	return self.TextColor[CountColor] .. num .. self.TextColor[0]
end

function ActivityUIApi:GetActivityTurnTime(startTime, endTime)
	return string.format("%s: %s~%s", self:GetCfgText(1233178), startTime, endTime)
end

function ActivityUIApi:GetDropExchangeDesc1()
	return self:GetCfgText(1233601)
end

function ActivityUIApi:GetDropExchangeTextCloseTime(shopCloseTime)
	return string.format(self:GetCfgText(1233602), shopCloseTime)
end

function ActivityUIApi:GetDropExchangeBtnShopLabel()
	return self:GetCfgText(1019241)
end

function ActivityUIApi:GetDropExchangeTextTip()
	return self:GetCfgText(1233604)
end

function ActivityUIApi:GetDropExchangeTextGetValue(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function ActivityUIApi:GetDropExchangeTextLabel()
	return self:GetCfgText(1233605)
end

function ActivityUIApi:GetDropExchangeTextDay(startMoth, startDay, endMoth, endDay)
	return string.format("%s.%s - %s.%s", startMoth, startDay, endMoth, endDay)
end

function ActivityUIApi:GetDropExchangeTitle1()
	return self:GetCfgText(1233321)
end

function ActivityUIApi:GetPureExhibitionOpenTime(startTime, endTime)
	return string.format("%s: %s~%s", self:GetCfgText(1233178), startTime, endTime)
end

function ActivityUIApi:GetNewYearTextRemainingTimes(num)
	return string.format(self:GetCfgText(1233607), num)
end

function ActivityUIApi:GetNewYearBtnCollectedLabel()
	return self:GetCfgText(1233608)
end

function ActivityUIApi:GetNewYearBtnCollectingLabel()
	return self:GetCfgText(1233609)
end

function ActivityUIApi:GetNewYearBtnExchangeLabel()
	return self:GetCfgText(1233610)
end

function ActivityUIApi:GetNewYearTextOpenTime(startTime, endTime)
	return string.format("%s: %s~%s", self:GetCfgText(1233178), startTime, endTime)
end

function ActivityUIApi:GetReplacementImgNum(num)
	local path = {
		self:GetResUrl(1702230),
		self:GetResUrl(1702231),
		self:GetResUrl(1702232),
		self:GetResUrl(1702233),
		self:GetResUrl(1702234),
		self:GetResUrl(1702235),
		self:GetResUrl(1702236),
		self:GetResUrl(1702237),
		self:GetResUrl(1702238),
		self:GetResUrl(1702239)
	}

	return path[num + 1]
end

function ActivityUIApi:GetReplacementPassName1()
	return "第"
end

function ActivityUIApi:GetReplacementBtnBuyLabel(num)
	local str = MiscApi:GetString("moneySign")

	return string.format("%s%s", str, num)
end

function ActivityUIApi:GetVoteNeedText(name, num)
	return string.format(self:GetCfgText(1233508), name, num)
end

function ActivityUIApi:GetVoteBtnVoteLabel()
	return self:GetCfgText(1233509)
end

function ActivityUIApi:GetVoteMostPopularDes()
	return self:GetCfgText(1233510)
end

function ActivityUIApi:GetPandaTextMaxTip()
	return self:GetCfgText(1233511)
end

function ActivityUIApi:GetPandaTextUpGrade(num)
	return string.format("+%s", num) .. self:GetCfgText(1160028)
end

function ActivityUIApi:GetPandaBtnShopLabel()
	return self:GetCfgText(1233501)
end

function ActivityUIApi:GetPandaFavorTitle()
	return self:GetCfgText(1233502)
end

function ActivityUIApi:GetPandaBtnExploreLabel()
	return self:GetCfgText(1233503)
end

function ActivityUIApi:GetPandaBtnInteract()
	return self:GetCfgText(1233504)
end

function ActivityUIApi:GetPandaBtnWashLabel()
	return self:GetCfgText(1233505)
end

function ActivityUIApi:GetPandaNeedValue(name, num)
	return string.format("%s x%s", name, num)
end

function ActivityUIApi:GetPandaNeed()
	return self:GetCfgText(1233506)
end

function ActivityUIApi:GetPandaBtnFeedLabel()
	return self:GetCfgText(1233507)
end

function ActivityUIApi:GetPandaOpenTime(startTime, endTime)
	return string.format("%s: %s~%s", self:GetCfgText(1233178), startTime, endTime)
end

function ActivityUIApi:GetLuckyBtnBatchBuyTitle2()
	return self:GetCfgText(1233403)
end

function ActivityUIApi:GetLuckyBtnBatchBuyTitle1()
	return self:GetCfgText(1233408)
end

function ActivityUIApi:GetLuckyBtnBuyTitle2()
	return self:GetCfgText(1233402)
end

function ActivityUIApi:GetLuckyBtnBuyTitle1()
	return self:GetCfgText(1233407)
end

function ActivityUIApi:GetLuckyBtnLotteryRecordTitle()
	return self:GetCfgText(1233404)
end

function ActivityUIApi:GetLuckyBtnProbabilityTitle()
	return self:GetCfgText(1233405)
end

function ActivityUIApi:GetLuckyTextDes()
	return self:GetCfgText(1233409)
end

function ActivityUIApi:GetLuckyBtnLotteryPoolTitle()
	return self:GetCfgText(1233406)
end

function ActivityUIApi:GetSpaceTextTitleMsg(needPower)
	return string.format(self:GetCfgText(1233301), needPower)
end

function ActivityUIApi:GetSpaceTextSpendItem(name, num)
	return string.format("%s:%s", name, num)
end

function ActivityUIApi:GetSpaceTextGetMsg()
	return string.format(self:GetCfgText(1233302))
end

function ActivityUIApi:GetSpaceTextSpendPower(num)
	return string.format(self:GetCfgText(1233303), num)
end

function ActivityUIApi:GetSpaceTreasureCellItemNum(haveNum, needNum)
	return string.format("%s/%s", haveNum, needNum)
end

function ActivityUIApi:GetSpaceTextOpenTime(startTime, endTime)
	return self:GetCfgText(1233178) .. "：\n" .. startTime .. " ~ " .. endTime
end

function ActivityUIApi:GetSpaceTextBtnClaim()
	return self:GetCfgText(1233304)
end

function ActivityUIApi:GetFurGashViewTime(startTime, endTime)
	return self:GetCfgText(1233178) .. "：" .. startTime .. " ~ " .. endTime
end

function ActivityUIApi:GetFurGashViewDesc()
	return self:GetCfgText(1233305)
end

function ActivityUIApi:GetFurGashViewBtnLotteryPoolTxt()
	return self:GetCfgText(1233306)
end

function ActivityUIApi:GetFurGashViewBtnTheme_1()
	return self:GetCfgText(1233311)
end

function ActivityUIApi:GetFurGashViewBtnTheme_2()
	return self:GetCfgText(1233312)
end

function ActivityUIApi:GetFurGashViewBtnBuyTxt()
	return self:GetCfgText(1233313)
end

function ActivityUIApi:GetFurGashViewBtnBatchBuyTxt()
	return self:GetCfgText(1233314)
end

function ActivityUIApi:GetFurGashViewBuyCount(costCount, ownCount)
	return "X1"
end

function ActivityUIApi:GetFurGashViewBatchBuyCount(costCount, ownCount)
	return "X10"
end

function ActivityUIApi:GetFurGashViewThemeCid(index)
	if index == 1 then
		return 8
	end

	if index == 2 then
		return 9
	end
end

function ActivityUIApi:GetSignViewTime(time)
	return self:GetCfgText(2000042) .. self:Space(1) .. time
end

function ActivityUIApi:GetSignViewBtnDetailTxt()
	return self:GetCfgText(1233322)
end

function ActivityUIApi:GetPaidViewBtnDetailTxt()
	return self:GetCfgText(1233322)
end

function ActivityUIApi:GetPaidViewTime(time)
	return self:GetCfgText(1233321) .. self:Space(1) .. time
end

function ActivityUIApi:GetPaidViewTaskDesc(desc)
	return desc
end

function ActivityUIApi:GetPaidViewTaskTarget(curNum, targetNum)
	return tostring(curNum) .. "/" .. tostring(targetNum)
end

function ActivityUIApi:GetPaidViewRewardDay(day)
	if day == 1 then
		return "1"
	elseif day == 2 then
		return "2"
	elseif day == 3 then
		return "3"
	elseif day == 4 then
		return "4"
	elseif day == 5 then
		return "5"
	elseif day == 6 then
		return "6"
	elseif day == 7 then
		return "7"
	end
end

function ActivityUIApi:GetPaidViewActivityName(name)
	return name
end

function ActivityUIApi:GetPaidViewDesc_1()
	return self:GetCfgText(1233512)
end

function ActivityUIApi:GetPaidViewDesc_2()
	return self:GetCfgText(1233513)
end

function ActivityUIApi:GetPaidViewDesc_3()
	return self:GetCfgText(1233514)
end

function ActivityUIApi:GetPaidViewBuyTxt(amount)
	return MiscApi:GetString("moneySign") .. tostring(amount)
end

function ActivityUIApi:GetPaidViewRewardCount(count)
	return "x" .. tostring(count)
end

function ActivityUIApi:GetPaidViewLockTxtPath(day)
	local StartNum = 1702240

	if day == 1 then
		return self:GetResUrl(StartNum)
	elseif day == 2 then
		return self:GetResUrl(StartNum + 1)
	elseif day == 3 then
		return self:GetResUrl(StartNum + 2)
	elseif day == 4 then
		return self:GetResUrl(StartNum + 3)
	elseif day == 5 then
		return self:GetResUrl(StartNum + 4)
	elseif day == 6 then
		return self:GetResUrl(StartNum + 5)
	else
		return self:GetResUrl(StartNum + 6)
	end
end

function ActivityUIApi:GetSignViewCount(count)
	return "x" .. count
end

function ActivityUIApi:GetSignViewDayPath(day)
	local ResId = 1702120 + day

	return self:GetResUrl(ResId)
end

function ActivityUIApi:GetInvasionTextBtnTip()
	return self:GetCfgText(1233360)
end

function ActivityUIApi:GetInvasionTextScore(currentScore, maxScore)
	return string.format("<size=20>%s</size>\n%s", currentScore, maxScore)
end

function ActivityUIApi:GetInvasionTextSoulGrid()
	return self:GetCfgText(1233350)
end

function ActivityUIApi:GetInvasionTextFormation()
	return self:GetCfgText(1233351)
end

function ActivityUIApi:GetInvasionTextLock(index, needScore)
	if index == 2 then
		return string.format(self:GetCfgText(1233352), needScore)
	elseif index == 3 then
		return string.format(self:GetCfgText(1233357), needScore)
	else
		return string.format(self:GetCfgText(1233355), needScore)
	end
end

function ActivityUIApi:GetInvasionTextDown(index)
	if index == 1 then
		return self:GetCfgText(1233353)
	elseif index == 2 then
		return self:GetCfgText(1233358)
	elseif index == 3 then
		return self:GetCfgText(1233359)
	elseif index == 4 then
		return self:GetCfgText(1233356)
	end
end

function ActivityUIApi:GetInvasionTextUp(index)
	if index == 1 then
		return self:GetCfgText(1233353)
	elseif index == 2 then
		return self:GetCfgText(1233358)
	elseif index == 3 then
		return self:GetCfgText(1233359)
	elseif index == 4 then
		return self:GetCfgText(1233356)
	end
end

function ActivityUIApi:GetInvasionTextBtnGetReward()
	return self:GetCfgText(1233354)
end

function ActivityUIApi:GetInvasionTextOpenTime(startTime, endTime)
	return self:GetCfgText(1233178) .. "：" .. startTime .. " ~ " .. endTime
end

function ActivityUIApi:GetTextEXPRESS(name, num)
	return string.format("%sx%s", name, num)
end

function ActivityUIApi:GetTextTotalScore()
	return self:GetCfgText(1233201)
end

function ActivityUIApi:GetTextBtnNewCharacterTask()
	return self:GetCfgText(1233202)
end

function ActivityUIApi:GetTextBtnStory()
	return self:GetCfgText(1233203)
end

function ActivityUIApi:GetTextBtnBingo()
	return self:GetCfgText(1233204)
end

function ActivityUIApi:GetTextBtnTip()
	return self:GetCfgText(1233205)
end

function ActivityUIApi:GetNewCharacterTextOpen()
	return self:GetCfgText(1233178)
end

function ActivityUIApi:GetTextNewCharacterOpenTime(startTime, endTime)
	return startTime .. " ~ " .. endTime
end

function ActivityUIApi:GetTextChallengeBtn()
	return self:GetCfgText(1213003)
end

function ActivityUIApi:GetTextReward()
	return self:GetCfgText(1213071)
end

function ActivityUIApi:GetTextMonsterList()
	return self:GetCfgText(2100001)
end

function ActivityUIApi:GetTextKilled()
	return self:GetCfgText(1233161)
end

function ActivityUIApi:GetTextFightNum(recommendPower, power)
	if recommendPower < power then
		-- block empty
	end

	return recommendPower
end

function ActivityUIApi:GetTextBossLevel(boosLv)
	if boosLv == 1 then
		return self:GetCfgText(1213091)
	elseif boosLv == 2 then
		return self:GetCfgText(1213092)
	elseif boosLv == 3 then
		return self:GetCfgText(1213093)
	elseif boosLv == 4 then
		return self:GetCfgText(1213094)
	elseif boosLv == 5 then
		return self:GetCfgText(1213095)
	elseif boosLv == 6 then
		return self:GetCfgText(1213096)
	elseif boosLv == 7 then
		return self:GetCfgText(1213097)
	elseif boosLv == 8 then
		return self:GetCfgText(1213098)
	elseif boosLv == 9 then
		return self:GetCfgText(1213099)
	elseif boosLv == 10 then
		return self:GetCfgText(1213100)
	end

	return ""
end

function ActivityUIApi:GetTextFight()
	return self:GetCfgText(1233162)
end

function ActivityUIApi:GetTextOpenTime(startTime, endTime)
	return string.format("%s~%s", startTime, endTime)
end

function ActivityUIApi:GetTextBtnEnter()
	return self:GetCfgText(1233163)
end

function ActivityUIApi:GetTextDes()
	return self:GetCfgText(1233164)
end

function ActivityUIApi:GetTextTodayWords()
	return self:GetCfgText(1233165)
end

function ActivityUIApi:GetTextBtnIntroduction()
	return self:GetCfgText(1233166)
end

function ActivityUIApi:GetViewPath(viewID)
	if viewID == Constant.Activity_ID.MoonLogin then
		return UIGlobalApi.GetPrefabRoot("/UI/_ActivityUI/MoonLogin.prefab")
	elseif viewID == Constant.Activity_ID.MoonTip then
		return UIGlobalApi.GetPrefabRoot("/UI/_ActivityUI/MoonTip.prefab")
	elseif viewID == Constant.Activity_ID.NationalDay then
		return UIGlobalApi.GetPrefabRoot("/UI/_ActivityUI/NationalDay.prefab")
	elseif viewID == Constant.Activity_ID.LuckyTurntable then
		return UIGlobalApi.GetPrefabRoot("/UI/_DailyActivityUI/LuckyTable_211224001.prefab")
	elseif viewID == Constant.Activity_ID.ReplacementPass then
		return UIGlobalApi.GetPrefabRoot("/UI/_DailyActivityUI/ReplenishPassCheck_220113.prefab")
	end

	return ""
end

function ActivityUIApi:GetTextBuyServiceValue(num, max)
	if max <= num then
		return max .. "+"
	end

	return num
end

function ActivityUIApi:GetTextCompleted(count, total)
	return string.format("%s/%s", count, total)
end

function ActivityUIApi:GetTextUnlockReward()
	return self:GetCfgText(1233167)
end

function ActivityUIApi:GetTextCompletedDes()
	return self:GetCfgText(1233168)
end

function ActivityUIApi:GetTextPicTimeClose(str)
	if str < 3600 then
		return self:GetCfgText(1233169) .. "   " .. self:GetCfgText(1233170) .. ": " .. getTimeDurationText(str, 3)
	elseif str >= 3600 and str < 86400 then
		return self:GetCfgText(1233169) .. "   " .. self:GetCfgText(1233170) .. ": " .. getTimeDurationText(str, 2)
	else
		return self:GetCfgText(1233169) .. "   " .. self:GetCfgText(1233170) .. ": " .. getTimeDurationText(str, 1)
	end
end

function ActivityUIApi:GetTextBtnUnlockPic()
	return self:GetCfgText(1233171)
end

function ActivityUIApi:GetTextNeed(num, isAmple)
	if isAmple then
		return string.format(self:GetCfgText(1233172) .. "：%s", num)
	end

	return string.format(self:GetCfgText(1233172) .. "：%s", num)
end

function ActivityUIApi:GetTextHave(num)
	return string.format(self:GetCfgText(1233173) .. "：%s", num)
end

function ActivityUIApi:GetTextRewardCount(num1, num2)
	return string.format("%s/%s", num1, num2)
end

function ActivityUIApi:GetTextRewardTitle()
	return self:GetCfgText(1233174)
end

function ActivityUIApi:GetTextBtnTask()
	return self:GetCfgText(1233175)
end

function ActivityUIApi:GetTextDayReward(num1, num2)
	return string.format(self:GetCfgText(1233176) .. "：%s/%s", num1, num2)
end

function ActivityUIApi:GetTextTaskReward(num1, num2)
	return string.format(self:GetCfgText(1233177) .. "：%s/%s", num1, num2)
end

function ActivityUIApi:GetTextPictureTitle(startTime, endTime)
	return self:GetCfgText(1233178) .. "：" .. startTime .. " ~ " .. endTime
end

function ActivityUIApi:GetTextTimeClose(str)
	return string.format(self:GetCfgText(1233179) .. "：%s", str)
end

function ActivityUIApi:GetTextCurrentValue(num)
	return string.format("%s%%", num)
end

function ActivityUIApi:GetTextOverValue(num1, num2)
	return self:GetCfgText(1233180) .. ": " .. self.TextColor[41] .. num1 .. self.TextColor[0] .. "/" .. num2
end

function ActivityUIApi:GetTextBuyOver()
	return self:GetCfgText(1233181)
end

function ActivityUIApi:GetTextHaveNum(num1, num2)
	return string.format(self:GetCfgText(1233180) .. ": %s/%s", num1, num2)
end

function ActivityUIApi:GetTextCurrent()
	return self:GetCfgText(1233182) .. "："
end

function ActivityUIApi:GetTextNext(num)
	if num < 0 then
		return self:GetCfgText(1233183)
	end

	return self:GetCfgText(1233184) .. num
end

function ActivityUIApi:GetTextBuyService()
	return self:GetCfgText(1233185) .. "："
end

function ActivityUIApi:GetTextReturn()
	return self:GetCfgText(1233186)
end

function ActivityUIApi:GetTextTimeTitle(startTime, endTime)
	return self:GetCfgText(1233178) .. "：" .. startTime .. " ~ " .. endTime
end

function ActivityUIApi:GetMoodStartDate()
	return "2022/9/8 14:00:00"
end

function ActivityUIApi:GetMoodEndDate()
	return "2022/9/15 14:00:00"
end

function ActivityUIApi:GetMoonLoginTitle1()
	return self:GetCfgText(1233150)
end

function ActivityUIApi:GetMoonLoginTitle2()
	return self:GetCfgText(1233151)
end

function ActivityUIApi:GetNationalDayTitle2()
	return "Mid-Autumn festival"
end

function ActivityUIApi:GetMoonLoginTitle3()
	return self:GetCfgText(1233152)
end

function ActivityUIApi:GetNationalDayTitle3()
	return self:GetCfgText(1233189)
end

function ActivityUIApi:GetMoonLoginDesc1()
	return self:GetCfgText(1233153)
end

function ActivityUIApi:GetNationalDayDesc1()
	return self:GetCfgText(1233153)
end

function ActivityUIApi:GetMoonLoginDesc2()
	return self:GetCfgText(1233154)
end

function ActivityUIApi:GetNationalDayDesc2()
	return self:GetCfgText(1233188)
end

function ActivityUIApi:GetMoonTipNpc1()
	return self:GetCfgText(1233155)
end

function ActivityUIApi:GetMoonTipNpc2()
	return self:GetCfgText(1233156)
end

function ActivityUIApi:GetMoonTipDesc1()
	return self:GetCfgText(1233157)
end

function ActivityUIApi:GetMoonTipDesc2()
	return self:GetCfgText(1233158)
end

function ActivityUIApi:GetMoonTipTitle2()
	return self:GetCfgText(1233151)
end

function ActivityUIApi:GetMoonTipTitle1()
	return self:GetCfgText(1233150)
end

function ActivityUIApi:GetNationalDayTitle1()
	return self:GetCfgText(1233187)
end

function ActivityUIApi:GetNationalDayStartDate()
	return "2021/10/1  4:00:00"
end

function ActivityUIApi:GetNationalDayEndDate()
	return "2021/10/8  4:00:00"
end

function ActivityUIApi:GetMoonLoginStateDesc(state)
	if state == 1 then
		return self:GetCfgText(2300601)
	elseif state == 2 then
		return "." .. self:GetCfgText(1245001) .. "."
	else
		return self:GetCfgText(1245002)
	end
end

function ActivityUIApi:GetNationalDayStateDesc(state)
	if state == 1 then
		return self:GetCfgText(2300601)
	elseif state == 2 then
		return "." .. self:GetCfgText(1245001) .. "."
	else
		return self:GetCfgText(1245002)
	end
end

function ActivityUIApi:GetMoonLoginDayDesc(day, state, isSpecialDay)
	if state == 2 then
		return self:GetCfgText(1245003) .. self.TextColor[1000] .. "<size=60>" .. tostring(day) .. "</size>" .. self.TextColor[0] .. self:GetCfgText(1245004)
	elseif isSpecialDay then
		return self.TextColor[1001] .. self:GetCfgText(1245003) .. "<size=60>" .. tostring(day) .. "</size>" .. self:GetCfgText(1245004) .. self.TextColor[0]
	else
		return self:GetCfgText(1245003) .. "<size=60>" .. tostring(day) .. "</size>" .. self:GetCfgText(1245004)
	end
end

function ActivityUIApi:GetNationalDayDayDesc(day, state, isSpecialDay)
	if state == 2 then
		return self:GetCfgText(1245003) .. self.TextColor[1000] .. "<size=60>" .. tostring(day) .. "</size>" .. self.TextColor[0] .. self:GetCfgText(1245004)
	elseif isSpecialDay then
		return self.TextColor[1001] .. self:GetCfgText(1245003) .. "<size=60>" .. tostring(day) .. "</size>" .. self:GetCfgText(1245004) .. self.TextColor[0]
	else
		return self:GetCfgText(1245003) .. "<size=60>" .. tostring(day) .. "</size>" .. self:GetCfgText(1245004)
	end
end

function ActivityUIApi:GetBtnTestText()
	return self:GetCfgText(1233100)
end

function ActivityUIApi:GetTabBtnTxt(index)
	if index == 2 then
		return self:GetCfgText(1233101)
	elseif index == 3 then
		return self:GetCfgText(1233102)
	elseif index == 4 then
		return self:GetCfgText(1233150)
	elseif index == 5 then
		return self:GetCfgText(1233159)
	elseif index == 6 then
		return self:GetCfgText(1233187)
	elseif index == 7 then
		return self:GetCfgText(1233401)
	elseif index == 8 then
		return self:GetCfgText(1233450)
	else
		return "????"
	end
end

function ActivityUIApi:GetTabEngBtnTxt(index)
	if index == 1 then
		return ""
	end

	return ""
end

function ActivityUIApi:GetTitle()
	return self:GetCfgText(1233001)
end

function ActivityUIApi:GetTonicDesc()
	return self:GetCfgText(1233051)
end

function ActivityUIApi:GetCostDesc(cost)
	return cost
end

function ActivityUIApi:GetBtnTonicTxt()
	return self:GetCfgText(1233052)
end

function ActivityUIApi:GetBtnSignTxt()
	return self:GetCfgText(1233053)
end

function ActivityUIApi:GetTonicSignDesc()
	return self:GetCfgText(1233052)
end

function ActivityUIApi:GetSignDesc(signed, signedDays, tonicSign)
	local ret

	if signed and tonicSign > 0 then
		ret = self:GetCfgText(1233054) .. signedDays .. self:GetCfgText(1233055) .. self:GetCfgText(1233056) .. tonicSign .. self:GetCfgText(1233055)
	else
		ret = self:GetCfgText(1233054) .. signedDays .. self:GetCfgText(1233055)
	end

	return ret
end

function ActivityUIApi:GetFoodTitleText()
	return self:GetCfgText(1233103)
end

function ActivityUIApi:GetFoodSubTitleText()
	return self:GetCfgText(1233104)
end

function ActivityUIApi:GetFoodTipText()
	return self:GetCfgText(1233105)
end

function ActivityUIApi:GetFoodItemTitleText(title)
	return title
end

function ActivityUIApi:GetFoodItemTimeText(openTimeHour, openTimeMin, endTimeHour, endTimeMin, isH12, isOpenTimePm, isEndTimePm)
	local openTimeHourStr = tostring(openTimeHour)
	local openTimeMinStr = tostring(openTimeMin)
	local endTimeHourStr = tostring(endTimeHour)
	local endTimeMinStr = tostring(endTimeMin)

	if openTimeHour < 10 then
		openTimeHourStr = "0" .. openTimeHourStr
	end

	if openTimeMin < 10 then
		openTimeMinStr = "0" .. openTimeMinStr
	end

	if endTimeHour < 10 then
		endTimeHourStr = "0" .. endTimeHourStr
	end

	if endTimeMin < 10 then
		endTimeMinStr = "0" .. endTimeMinStr
	end

	local openTimeStr = openTimeHourStr .. ":" .. openTimeMinStr
	local endTimeStr = endTimeHourStr .. ":" .. endTimeMinStr

	if isH12 then
		if isOpenTimePm then
			openTimeStr = openTimeStr .. "PM"
		else
			openTimeStr = openTimeStr .. "AM"
		end

		if isEndTimePm then
			endTimeStr = endTimeStr .. "PM"
		else
			endTimeStr = endTimeStr .. "AM"
		end
	end

	return openTimeStr .. "~" .. endTimeStr
end

function ActivityUIApi:GetFoodItemContentText(count)
	return self:GetCfgText(1233106) .. "+" .. count
end

function ActivityUIApi:GetFoodItemIcon(day, date, cid)
	local DataSources

	DataSources = (day - 1) * 10 + date % 10

	if DataSources < 1 then
		DataSources = 42
	elseif DataSources > 68 then
		DataSources = 21
	end

	if cid == 1 then
		DataSources = 1702000 + DataSources

		return self:GetResUrl(DataSources)
	else
		if DataSources >= 35 then
			DataSources = 34 - (DataSources - 35)
		else
			DataSources = 35 + (34 - DataSources)
		end

		DataSources = 1702000 + DataSources

		return self:GetResUrl(DataSources)
	end
end

function ActivityUIApi:GetFoodItemNotTimeText()
	return self:GetCfgText(1233107)
end

function ActivityUIApi:GetFoodItemClaimedText()
	return self:GetCfgText(1101015)
end

function ActivityUIApi:GetFoodItemFreeClaimBtnText()
	return self:GetCfgText(1015039)
end

function ActivityUIApi:GetFoodItemCostClaimBtnText()
	return self:GetCfgText(1015039)
end

function ActivityUIApi:GetFoodItemCostLabel()
	return self:GetCfgText(1233108) .. "："
end

function ActivityUIApi:turn_toggleRule()
	return self:GetCfgText(1233109)
end

function ActivityUIApi:turn_toggleRecord()
	return self:GetCfgText(1233110)
end

function ActivityUIApi:turn_btnTurn()
	return self:GetCfgText(1233111)
end

function ActivityUIApi:turn_turnTips()
	return self:GetCfgText(1233112)
end

function ActivityUIApi:turn_ruleInfo()
	return self:GetCfgText(1233113)
end

function ActivityUIApi:turn_remainTimes(times)
	if times > 0 then
		return self:GetCfgText(1233114) .. ":" .. times
	else
		return self:GetCfgText(1233114) .. ":" .. self.TextColor[41] .. times .. self.TextColor[0]
	end
end

function ActivityUIApi:turn_txtTitle()
	return self:GetCfgText(1233115)
end

function ActivityUIApi:turn_txtDate()
	return self:GetCfgText(1233116)
end

function ActivityUIApi:turn_btnTurn2()
	return self:GetCfgText(1233117)
end

function ActivityUIApi:turn_txtRecord(rare, name, id, count)
	name = self:Anonymous(name, 1)

	return self:Space(1) .. self.TextColor[12] .. name .. self.TextColor[0] .. self:Space(1) .. self:GetCfgText(1233128) .. self:Space(1) .. self.PropQualityLang[rare] .. CfgItemTable[id].Name .. self.PropQualityLang[0] .. self:Space(1) .. "x" .. count
end

function ActivityUIApi:commit_title()
	return self:GetCfgText(1233126) .. self:GetCfgText(1233127)
end

function ActivityUIApi:commit_nameInGame()
	return self:GetCfgText(1233118)
end

function ActivityUIApi:commit_name1()
	return self:GetCfgText(1233119)
end

function ActivityUIApi:commit_name2()
	return self:Blank("NAME", 1)
end

function ActivityUIApi:commit_phone1()
	return self:GetCfgText(1233120)
end

function ActivityUIApi:commit_phone2()
	return self:Blank("TEL.", 1)
end

function ActivityUIApi:commit_address1()
	return self:GetCfgText(1233121)
end

function ActivityUIApi:commit_address2()
	return self:Blank("ADD", 1)
end

function ActivityUIApi:commit_declare()
	return self:GetCfgText(1233122)
end

function ActivityUIApi:commit_cancel()
	return self:GetCfgText(1233123)
end

function ActivityUIApi:commit_ok()
	return self:GetCfgText(1233124)
end

function ActivityUIApi:GetGachaRateUpLabel()
	return ""
end

function ActivityUIApi:GetGachaRateUpValueText(value)
	return ""
end

function ActivityUIApi:GetGachaCostItemNumText(num)
	if num == 0 then
		return self.TextColor[33] .. self:GetCfgText(1233129) .. self.TextColor[0]
	end

	return num
end

function ActivityUIApi:GetGachaDrawBtnText()
	return self:GetCfgText(1233130)
end

function ActivityUIApi:GetGachaRewardGotViewText()
	return self:GetCfgText(1233131)
end

function ActivityUIApi:GetGachaRollingEffectDuration(rare)
	return 4
end

function ActivityUIApi:GetGachaProgressEffectMaskTilingX(rare, rewardIndex)
	if rare == 1 then
		if rewardIndex == 0 then
			return 2.5
		else
			return 0.5
		end
	elseif rare == 2 then
		if rewardIndex == 0 then
			return 2.5
		elseif rewardIndex == 1 then
			return 1.2
		elseif rewardIndex == 2 then
			return 0.5
		end
	elseif rare == 3 then
		if rewardIndex == 0 then
			return 2.5
		elseif rewardIndex == 1 then
			return 1.3
		elseif rewardIndex == 2 then
			return 0.8
		elseif rewardIndex == 3 then
			return 0.5
		end
	elseif rare == 4 then
		if rewardIndex == 0 then
			return 2.5
		elseif rewardIndex == 1 then
			return 1.7
		elseif rewardIndex == 2 then
			return 1
		elseif rewardIndex == 3 then
			return 0.7
		elseif rewardIndex == 4 then
			return 0.5
		end
	end
end

function ActivityUIApi:GetGachaProgressEffectSpeed(rare)
	return 3
end

function ActivityUIApi:GetGachaCellEffectDuration()
	return 0.5
end

function ActivityUIApi:GetGachaRateUpDescText(timeStr)
	return string.format(self:GetCfgText(1233132), timeStr)
end

function ActivityUIApi:GetFreeReward_TaskItem_ProgressText(finishedNum, targetNum)
	return string.format("%s/%s", finishedNum, targetNum)
end

function ActivityUIApi:GetFreeReward_TaskItem_FinishedBtnText()
	return self:GetCfgText(1233661)
end

ActivityUIApi:Init()
