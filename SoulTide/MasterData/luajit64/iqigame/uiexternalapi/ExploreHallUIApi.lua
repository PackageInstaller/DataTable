-- chunkname: @IQIGame\\UIExternalApi\\ExploreHallUIApi.lua

ExploreHallUIApi = BaseLangApi:Extend()

function ExploreHallUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ToggleBtnText", self.GetToggleBtnText)
	self:RegisterApi("DailyDupCidToggleIndex", self.GetDailyDupCidToggleIndex)
	self:RegisterApi("ExploringViewText", self.GetExploringViewText)
	self:RegisterApi("ProgressLabel", self.GetProgressLabel)
	self:RegisterApi("ChapterEnLabel", self.GetChapterEnLabel)
	self:RegisterApi("ChapterNameText", self.GetChapterNameText)
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("EndlessMazeLabel", self.GetEndlessMazeLabel)
	self:RegisterApi("NormalNumText", self.GetNormalNumText)
	self:RegisterApi("FloorNumText", self.GetFloorNumText)
	self:RegisterApi("SpaceTreasureBtnText", self.GetSpaceTreasureBtnText)
	self:RegisterApi("SpaceTreasureBtnEnText", self.GetSpaceTreasureBtnEnText)
	self:RegisterApi("RpgRpgMazeBtnText", self.GetRpgRpgMazeBtnText)
	self:RegisterApi("RpgBossBtnText", self.GetRpgBossBtnText)
	self:RegisterApi("RpgExBossBtnText", self.GetRpgExBossBtnText)
	self:RegisterApi("ShopExBossBtnText", self.GetShopExBossBtnText)
	self:RegisterApi("TaskTaskBtnText", self.GetTaskTaskBtnText)
	self:RegisterApi("RpgMazeLimitTimeText", self.GetRpgMazeLimitTimeText)
	self:RegisterApi("ClaimAllRewardBtn", self.GetClaimAllRewardBtn)
	self:RegisterApi("IllusionDifficulty", self.GetIllusionDifficulty)
	self:RegisterApi("IllusionDifficultyLabel", self.GetIllusionDifficultyLabel)
	self:RegisterApi("RpgPvBtnText", self.GetRpgPvBtnText)
	self:RegisterApi("SkillTrainingLabel", self.GetSkillTrainingLabel)
	self:RegisterApi("DreamLimitTimeTexts", self.GetDreamLimitTimeTexts)
	self:RegisterApi("DreamLevelBtnUnlockLabel", self.GetDreamLevelBtnUnlockLabel)
	self:RegisterApi("DreamLevelBtnUnlockDescText", self.GetDreamLevelBtnUnlockDescText)
	self:RegisterApi("PlotChallengeShopBtnText", self.GetPlotChallengeShopBtnText)
	self:RegisterApi("PlotChallengeTextFight", self.GetPlotChallengeTextFight)
	self:RegisterApi("PlotChallengeCostValue", self.GetPlotChallengeCostValue)
	self:RegisterApi("PlotChallengeClearTextReward", self.GetPlotChallengeClearTextReward)
	self:RegisterApi("PlotChallengeNowTextReward", self.GetPlotChallengeNowTextReward)
	self:RegisterApi("PlotChallengeTextBOSS", self.GetPlotChallengeTextBOSS)
	self:RegisterApi("PlotChallengeLimitTimeTexts", self.GetPlotChallengeLimitTimeTexts)
	self:RegisterApi("PlotChallengeRewardTitle", self.GetPlotChallengeRewardTitle)
	self:RegisterApi("PlotChallengeStartTile", self.GetPlotChallengeStartTile)
	self:RegisterApi("PlotChallengeEndTitle", self.GetPlotChallengeEndTitle)
	self:RegisterApi("PlotBtnLabel", self.GetPlotBtnLabel)
	self:RegisterApi("ChallengeBtnLabel", self.GetChallengeBtnLabel)
	self:RegisterApi("ButtonInfo", self.GetButtonInfo)
	self:RegisterApi("MagicTowerLevelBtn", self.GetMagicTowerLevelBtn)
	self:RegisterApi("MagicTowerDisabledLevelBtn", self.GetMagicTowerDisabledLevelBtn)
	self:RegisterApi("MagicTowerLimitTimeTexts", self.GetMagicTowerLimitTimeTexts)
	self:RegisterApi("MagicTowerTipBtn", self.GetMagicTowerTipBtn)
	self:RegisterApi("DualTeamExploreLevelBtnText", self.GetDualTeamExploreLevelBtnText)
	self:RegisterApi("DualTeamExploreShopBtnText", self.GetDualTeamExploreShopBtnText)
	self:RegisterApi("DualTeamExploreTaskBtnText", self.GetDualTeamExploreTaskBtnText)
	self:RegisterApi("DualTeamExploreBossBtnText", self.GetDualTeamExploreBossBtnText)
	self:RegisterApi("DualTeamExploreExBossBtnText", self.GetDualTeamExploreExBossBtnText)
	self:RegisterApi("DualTeamExploreTipBtnText", self.GetDualTeamExploreTipBtnText)
	self:RegisterApi("DualTeamExploreDesc", self.GetDualTeamExploreDesc)
	self:RegisterApi("DualTeamExploreLimitTimeTexts", self.GetDualTeamExploreLimitTimeTexts)
	self:RegisterApi("MonsterAcademyNewGameBtn", self.GetMonsterAcademyNewGameBtn)
	self:RegisterApi("MonsterAcademyTaskBtn", self.GetMonsterAcademyTaskBtn)
	self:RegisterApi("MonsterAcademyShopBtn", self.GetMonsterAcademyShopBtn)
	self:RegisterApi("MonsterAcademyOldMemoriesBtn", self.GetMonsterAcademyOldMemoriesBtn)
	self:RegisterApi("MonsterAcademyIntroductionBtn", self.GetMonsterAcademyIntroductionBtn)
	self:RegisterApi("MonsterAcademyLimitTimeTexts", self.GetMonsterAcademyLimitTimeTexts)
	self:RegisterApi("EndlessPlusLimitTimeTexts", self.GetEndlessPlusLimitTimeTexts)
	self:RegisterApi("EndlessPlusBtnUnlockLabel", self.GetEndlessPlusBtnUnlockLabel)
	self:RegisterApi("EndlessPlusBtnUnlockDescText", self.GetEndlessPlusBtnUnlockDescText)
	self:RegisterApi("BonusTextUnlockChapter", self.GetBonusTextUnlockChapter)
	self:RegisterApi("BonusTextComplete", self.GetBonusTextComplete)
	self:RegisterApi("FlightChallengeLimitTimeTexts", self.GetFlightChallengeLimitTimeTexts)
	self:RegisterApi("RestaurantOperationTimeTexts", self.GetRestaurantOperationTimeTexts)
	self:RegisterApi("RestaurantOperationIncomeNum", self.GetRestaurantOperationIncomeNum)
	self:RegisterApi("PlaceGameTimeTexts", self.GetPlaceGameTimeTexts)
	self:RegisterApi("PlaceGameTextRewardNum", self.GetPlaceGameTextRewardNum)
	self:RegisterApi("PlaceGameOutPut", self.GetPlaceGameOutPut)
	self:RegisterApi("AmusementParkTimeTexts", self.GetAmusementParkTimeTexts)
	self:RegisterApi("AmusementParkIncomeNum", self.GetAmusementParkIncomeNum)
	self:RegisterApi("SurvivalLimitTimeTexts", self.GetSurvivalLimitTimeTexts)
	self:RegisterApi("SurvivalAttrWeaponLevel", self.GetSurvivalAttrWeaponLevel)
	self:RegisterApi("HorizontalRPGLimitTimeText", self.GetHorizontalRPGLimitTimeText)
	self:RegisterApi("HorizontalChallengeCostValue", self.GetHorizontalChallengeCostValue)
	self:RegisterApi("HorizontalChallengeClearTextReward", self.GetPlotChallengeClearTextReward)
	self:RegisterApi("HorizontalChallengeNowTextReward", self.GetPlotChallengeNowTextReward)
	self:RegisterApi("HorizontalChallengeRewardTitle", self.GetHorizontalChallengeRewardTitle)
	self:RegisterApi("HorizontalChallengeIcon", self.GetHorizontalChallengeIcon)
	self:RegisterApi("FishingActivityTimeTexts", self.GetFishingActivityTimeTexts)
	self:RegisterApi("FishingActivityTextMaxWeight", self.GetTextMaxWeight)
	self:RegisterApi("FishingActivityTextTotalWeight", self.GetTextTotalWeight)
	self:RegisterApi("FishingActivityTextBooks", self.GetFishingActivityTextBooks)
	self:RegisterApi("FishingActivityMoneyIcon", self.GetFishingActivityMoneyIcon)
	self:RegisterApi("FishingActivityTextAutoLabel", self.GetFishingActivityTextAutoLabel)
end

function ExploreHallUIApi:GetFishingActivityTextAutoLabel(top)
	if top then
		return "可收网"
	end

	return "自动网鱼中"
end

function ExploreHallUIApi:GetFishingActivityMoneyIcon(cid)
	local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", cid)

	if iconPath == "" then
		iconPath = UIGlobalApi.GetIconPath(CfgItemTable[cid].Icon)
	end

	return iconPath
end

function ExploreHallUIApi:GetFishingActivityTextBooks(num, totalNum)
	return string.format("%s/%s", num, totalNum)
end

function ExploreHallUIApi:GetTextTotalWeight(weight)
	if weight < 1000 then
		return string.format("%skg", weight)
	end

	return string.format("%s吨", weight / 1000)
end

function ExploreHallUIApi:GetTextMaxWeight(weight)
	if weight < 1000 then
		return string.format("%skg", weight)
	end

	return string.format("%s吨", weight / 1000)
end

function ExploreHallUIApi:GetFishingActivityTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, accessEndText, endTimeText

	startTimeText = getDateTimeMText(startTime)
	accessEndText = getDateTimeMText(accessEndTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return startTimeText, accessEndText, endTimeText
end

function ExploreHallUIApi:GetHorizontalChallengeIcon(state, type)
	if state == 0 then
		if type == 1 then
			return self:GetResUrl(5200006)
		elseif type == 2 then
			return self:GetResUrl(5200000)
		elseif type == 3 then
			return self:GetResUrl(5200002)
		elseif type == 4 then
			return self:GetResUrl(5200004)
		end
	elseif state == 1 then
		if type == 1 then
			return self:GetResUrl(5200006)
		elseif type == 2 then
			return self:GetResUrl(5200000)
		elseif type == 3 then
			return self:GetResUrl(5200002)
		elseif type == 4 then
			return self:GetResUrl(5200004)
		end
	elseif state == 2 then
		if type == 1 then
			return self:GetResUrl(5200007)
		elseif type == 2 then
			return self:GetResUrl(5200001)
		elseif type == 3 then
			return self:GetResUrl(5200003)
		elseif type == 4 then
			return self:GetResUrl(5200005)
		end
	end

	return UIGlobalApi.GetImagePath("/Challenge_Background/DramaChallenge/DramaChallenge_230727/DramaChallengeMainUI_230727/Drama_Story_Image_03.png")
end

function ExploreHallUIApi:GetHorizontalChallengeRewardTitle(state)
	if state == 2 then
		return self:GetCfgText(1243003)
	end

	return self:GetCfgText(3100502)
end

function ExploreHallUIApi:GetPlotChallengeNowTextReward()
	return self:GetCfgText(2000038)
end

function ExploreHallUIApi:GetPlotChallengeClearTextReward()
	return self:GetCfgText(2000039)
end

function ExploreHallUIApi:GetHorizontalChallengeCostValue(needValue, haveValue)
	return string.format("x%s", needValue)
end

function ExploreHallUIApi:GetHorizontalRPGLimitTimeText(timeText)
	return string.format("%s", timeText)
end

function ExploreHallUIApi:GetSurvivalAttrWeaponLevel(lv)
	return string.format("Lv %s", lv)
end

function ExploreHallUIApi:GetSurvivalLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, endTimeText

	startTimeText = getDateTimeMText(startTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return startTimeText, endTimeText
end

function ExploreHallUIApi:GetAmusementParkIncomeNum(count)
	return count
end

function ExploreHallUIApi:GetAmusementParkTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, accessEndText, endTimeText

	startTimeText = getDateTimeMText(startTime)
	accessEndText = getDateTimeMText(accessEndTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return startTimeText, accessEndText, endTimeText
end

function ExploreHallUIApi:GetPlaceGameOutPut(name, num)
	return string.format("%s:%s/m", name, num)
end

function ExploreHallUIApi:GetPlaceGameTextRewardNum(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function ExploreHallUIApi:GetPlaceGameTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, accessEndText, endTimeText

	startTimeText = getDateTimeMText(startTime)
	accessEndText = getDateTimeMText(accessEndTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return startTimeText, accessEndText, endTimeText
end

function ExploreHallUIApi:GetRestaurantOperationIncomeNum(count)
	return string.format(self:GetCfgText(3810076), count)
end

function ExploreHallUIApi:GetRestaurantOperationTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, accessEndText, endTimeText

	startTimeText = getDateTimeMText(startTime)
	accessEndText = getDateTimeMText(accessEndTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return startTimeText, accessEndText, endTimeText
end

function ExploreHallUIApi:GetFlightChallengeLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, endTimeText

	startTimeText = getDateTimeMText(startTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return startTimeText, endTimeText
end

function ExploreHallUIApi:GetBonusTextComplete(num, totalNum)
	return string.format("%s/%s", num, totalNum)
end

function ExploreHallUIApi:GetBonusTextUnlockChapter(num, totalNum)
	return string.format("%s/%s", num, totalNum)
end

function ExploreHallUIApi:GetMonsterAcademyLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local label, startTimeText, endTimeText

	label = self:GetCfgText(2000032)
	startTimeText = getDateTimeMText(startTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return label, startTimeText, endTimeText
end

function ExploreHallUIApi:GetMonsterAcademyIntroductionBtn()
	return self:GetCfgText(2000048)
end

function ExploreHallUIApi:GetMonsterAcademyOldMemoriesBtn()
	return self:GetCfgText(2000066)
end

function ExploreHallUIApi:GetMonsterAcademyShopBtn()
	return "商店"
end

function ExploreHallUIApi:GetMonsterAcademyTaskBtn()
	return "学分"
end

function ExploreHallUIApi:GetMonsterAcademyNewGameBtn()
	return self:GetCfgText(2000067)
end

function ExploreHallUIApi:GetChallengeBtnLabel()
	return self:GetCfgText(9000002)
end

function ExploreHallUIApi:GetButtonInfo()
	return self:GetCfgText(2000048)
end

function ExploreHallUIApi:GetPlotBtnLabel()
	return self:GetCfgText(9000001)
end

function ExploreHallUIApi:GetPlotChallengeEndTitle()
	return self:GetCfgText(2000043)
end

function ExploreHallUIApi:GetPlotChallengeStartTile()
	return self:GetCfgText(2000042)
end

function ExploreHallUIApi:GetPlotChallengeRewardTitle(state)
	if state == 2 then
		return self:GetCfgText(1243003)
	end

	return self:GetCfgText(3100502)
end

function ExploreHallUIApi:GetPlotChallengeLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local label, startTimeText, endTimeText

	label = self:GetCfgText(2000032)
	startTimeText = getDateTimeMText(accessEndTime)
	endTimeText = getDateTimeMText(activityEndTime)

	return label, startTimeText, endTimeText
end

function ExploreHallUIApi:GetPlotChallengeTextBOSS()
	return self:GetCfgText(1213160)
end

function ExploreHallUIApi:GetPlotChallengeNowTextReward()
	return self:GetCfgText(2000038)
end

function ExploreHallUIApi:GetPlotChallengeClearTextReward()
	return self:GetCfgText(2000039)
end

function ExploreHallUIApi:GetPlotChallengeCostValue(needValue, haveValue)
	return string.format("x%s", needValue)
end

function ExploreHallUIApi:GetPlotChallengeTextFight()
	return self:GetCfgText(2000040)
end

function ExploreHallUIApi:GetPlotChallengeShopBtnText()
	return self:GetCfgText(9000004)
end

function ExploreHallUIApi:GetSkillTrainingLabel()
	return self:GetCfgText(2000027)
end

function ExploreHallUIApi:GetTitleText()
	return self:GetCfgText(1107007)
end

function ExploreHallUIApi:GetToggleBtnText(index)
	if index == 1 then
		return self:GetCfgText(2000005)
	elseif index == 2 then
		return self:GetCfgText(2000006)
	elseif index == 3 then
		return self:GetCfgText(2000049)
	elseif index == 4 then
		return self:GetCfgText(2000050)
	elseif index == 5 then
		return self:GetCfgText(2000037)
	elseif index == 6 then
		return self:GetCfgText(2000051)
	elseif index == 7 then
		return "魔塔"
	elseif index == 8 then
		return "怪物学园"
	end
end

function ExploreHallUIApi:GetDailyDupCidToggleIndex(index)
	if index == 3 then
		return 8
	elseif index == 4 then
		return 11
	elseif index == 5 then
		return 12
	elseif index == 6 then
		return 13
	elseif index == 7 then
		return 14
	elseif index == 8 then
		return 15
	elseif index == 9 then
		return 17
	elseif index == 10 then
		return 21
	elseif index == 11 then
		return 23
	elseif index == 12 then
		return 24
	elseif index == 13 then
		return 25
	elseif index == 14 then
		return 26
	elseif index == 15 then
		return 27
	elseif index == 16 then
		return 28
	end

	return 1
end

function ExploreHallUIApi:GetExploringViewText()
	return self:GetCfgText(2000007)
end

function ExploreHallUIApi:GetProgressLabel()
	return self:GetCfgText(2000008)
end

function ExploreHallUIApi:GetChapterEnLabel()
	return self:GetCfgText(1229001)
end

function ExploreHallUIApi:GetChapterNameText(typeName, alias, name)
	return typeName
end

function ExploreHallUIApi:GetMazeNameText(chapterAlias, chapterName, chapterOrder, mazeOrder, mazeName)
	local orderStr

	if chapterOrder == 1 then
		if mazeOrder <= 3 then
			orderStr = "0-" .. mazeOrder
		else
			orderStr = chapterOrder .. "-" .. mazeOrder - 3
		end
	elseif chapterOrder == 16 then
		if mazeOrder <= 4 then
			orderStr = "16-?"
		else
			orderStr = chapterOrder .. "-" .. mazeOrder
		end
	else
		orderStr = chapterOrder .. "-" .. mazeOrder
	end

	return chapterAlias .. " " .. orderStr
end

function ExploreHallUIApi:GetEndlessMazeLabel()
	return self:GetCfgText(2000009), self:GetCfgText(2000010)
end

function ExploreHallUIApi:GetNormalNumText(currentNum, totalNum)
	if totalNum == 0 then
		return ""
	else
		return string.format(self:GetCfgText(2000013) .. "%s/%s", currentNum, totalNum)
	end
end

function ExploreHallUIApi:GetFloorNumText(floor)
	return floor
end

function ExploreHallUIApi:GetSpaceTreasureBtnText()
	return self:GetCfgText(1315303)
end

function ExploreHallUIApi:GetSpaceTreasureBtnEnText()
	return self:GetCfgText(2000011)
end

function ExploreHallUIApi:GetRpgRpgMazeBtnText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000060)
	elseif openCount == 4 then
		return self:GetCfgText(2000080)
	else
		return self:GetCfgText(2000018)
	end
end

function ExploreHallUIApi:GetRpgBossBtnText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000061)
	elseif openCount == 4 then
		return self:GetCfgText(2000078)
	else
		return self:GetCfgText(2000019)
	end
end

function ExploreHallUIApi:GetRpgExBossBtnText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000062)
	elseif openCount == 4 then
		return self:GetCfgText(2000079)
	else
		return self:GetCfgText(2000020)
	end
end

function ExploreHallUIApi:GetShopExBossBtnText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000063)
	elseif openCount == 4 then
		return self:GetCfgText(2000076)
	else
		return self:GetCfgText(2000021)
	end
end

function ExploreHallUIApi:GetTaskTaskBtnText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000064)
	elseif openCount == 4 then
		return self:GetCfgText(2000077)
	else
		return self:GetCfgText(2000022)
	end
end

function ExploreHallUIApi:GetRpgMazeLimitTimeText(timeText)
	return string.format("%s", timeText)
end

function ExploreHallUIApi:GetClaimAllRewardBtn()
	return self:GetCfgText(2000024)
end

function ExploreHallUIApi:GetIllusionDifficulty(chapterOrder, maxChapterOrder)
	if chapterOrder >= 17 then
		return "07", chapterOrder - 16, 3
	elseif chapterOrder >= 14 then
		return "06", chapterOrder - 13, 3
	elseif chapterOrder >= 11 then
		return "05", chapterOrder - 10, 3
	elseif chapterOrder >= 8 then
		return "04", chapterOrder - 7, 3
	elseif chapterOrder >= 5 then
		return "03", chapterOrder - 4, 3
	elseif chapterOrder >= 3 then
		return "02", chapterOrder - 2, 2
	else
		return "01", chapterOrder, 2
	end
end

function ExploreHallUIApi:GetIllusionDifficultyLabel()
	return self:GetCfgText(2000025)
end

function ExploreHallUIApi:GetRpgPvBtnText()
	return self:GetCfgText(2000028)
end

function ExploreHallUIApi:GetDreamLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local label, startTimeText, endTimeText

	if currentServerTime < accessEndTime then
		label = self:GetCfgText(2000032)
		startTimeText = getDateTimeMText(startTime)
		endTimeText = getDateTimeMText(accessEndTime)
	else
		label = self:GetCfgText(2000033)
		startTimeText = getDateTimeMText(accessEndTime)
		endTimeText = getDateTimeMText(activityEndTime)
	end

	return label, startTimeText, endTimeText
end

function ExploreHallUIApi:GetDreamLevelBtnUnlockLabel()
	return self:GetCfgText(2000034)
end

function ExploreHallUIApi:GetDreamLevelBtnUnlockDescText(isLock, currentServerTime, levelStartTime)
	if currentServerTime < levelStartTime then
		return string.format(self:GetCfgText(2000035), getDateTimeMText(levelStartTime))
	elseif isLock then
		return self:GetCfgText(2000036)
	end

	return "???"
end

function ExploreHallUIApi:GetMagicTowerLevelBtn()
	return self:GetCfgText(2000044)
end

function ExploreHallUIApi:GetMagicTowerDisabledLevelBtn(currentServerTime, startTime, accessEndTime, activityEndTime)
	return self:GetCfgText(2000045)
end

function ExploreHallUIApi:GetMagicTowerLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local startTimeText, endTimeText

	if currentServerTime < accessEndTime then
		startTimeText = getDateTimeMText(startTime)
		endTimeText = getDateTimeMText(accessEndTime)

		return string.format(self:GetCfgText(2000046), startTimeText, endTimeText)
	else
		startTimeText = getDateTimeMText(accessEndTime)
		endTimeText = getDateTimeMText(activityEndTime)

		return string.format(self:GetCfgText(2000047), startTimeText, endTimeText)
	end
end

function ExploreHallUIApi:GetMagicTowerTipBtn()
	return self:GetCfgText(2000048)
end

function ExploreHallUIApi:GetDualTeamExploreLevelBtnText(openCount)
	if openCount == 1 then
		return self:GetCfgText(2000052)
	elseif openCount == 2 then
		return self:GetCfgText(2000070)
	elseif openCount == 3 then
		return self:GetCfgText(2000052)
	end

	return ""
end

function ExploreHallUIApi:GetDualTeamExploreShopBtnText(openCount)
	if openCount == 1 then
		return self:GetCfgText(2000055)
	elseif openCount == 2 then
		return self:GetCfgText(2000073)
	elseif openCount == 3 then
		return self:GetCfgText(2000055)
	end

	return ""
end

function ExploreHallUIApi:GetDualTeamExploreTaskBtnText(openCount)
	if openCount == 1 then
		return self:GetCfgText(2000056)
	elseif openCount == 2 then
		return self:GetCfgText(2000074)
	elseif openCount == 3 then
		return self:GetCfgText(2000056)
	end

	return ""
end

function ExploreHallUIApi:GetDualTeamExploreBossBtnText(openCount)
	if openCount == 1 then
		return self:GetCfgText(2000053)
	elseif openCount == 2 then
		return self:GetCfgText(2000071)
	elseif openCount == 3 then
		return self:GetCfgText(2000053)
	end

	return ""
end

function ExploreHallUIApi:GetDualTeamExploreExBossBtnText(openCount)
	if openCount == 1 then
		return self:GetCfgText(2000054)
	elseif openCount == 2 then
		return self:GetCfgText(2000072)
	elseif openCount == 3 then
		return self:GetCfgText(2000054)
	end

	return ""
end

function ExploreHallUIApi:GetDualTeamExploreTipBtnText()
	return self:GetCfgText(2000048)
end

function ExploreHallUIApi:GetDualTeamExploreDesc(openCount)
	if openCount == 1 then
		return self:GetCfgText(3300200)
	elseif openCount == 2 then
		return self:GetCfgText(2000075)
	elseif openCount == 3 then
		return self:GetCfgText(3300200)
	end

	return ""
end

function ExploreHallUIApi:GetDualTeamExploreLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local label, startTimeText, endTimeText

	if currentServerTime < accessEndTime then
		label = self:GetCfgText(2000032)
		startTimeText = getDateTimeMText(startTime)
		endTimeText = getDateTimeMText(accessEndTime)
	else
		label = self:GetCfgText(2000033)
		startTimeText = getDateTimeMText(accessEndTime)
		endTimeText = getDateTimeMText(activityEndTime)
	end

	return label, startTimeText, endTimeText
end

function ExploreHallUIApi:GetEndlessPlusLimitTimeTexts(currentServerTime, startTime, accessEndTime, activityEndTime)
	local label, startTimeText, endTimeText

	if currentServerTime < accessEndTime then
		label = self:GetCfgText(2000042)
		startTimeText = getDateTimeMText(startTime)
		endTimeText = getDateTimeMText(accessEndTime)
	else
		label = self:GetCfgText(2000033)
		startTimeText = getDateTimeMText(accessEndTime)
		endTimeText = getDateTimeMText(activityEndTime)
	end

	return label, startTimeText, endTimeText
end

function ExploreHallUIApi:GetEndlessPlusBtnUnlockLabel()
	return self:GetCfgText(2000034)
end

function ExploreHallUIApi:GetEndlessPlusBtnUnlockDescText(isLock)
	if isLock then
		return self:GetCfgText(2000036)
	end

	return "???"
end

ExploreHallUIApi:Init()
