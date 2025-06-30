-- chunkname: @IQIGame\\Module\\EndlessPlus\\EndlessPlusMazeModule.lua

EndlessPlusMazeModule = {
	GlobalCid = 0
}

local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function EndlessPlusMazeModule.Reload(dailyDupPOD)
	EndlessPlusMazeModule.DailyDupPOD = dailyDupPOD

	if EndlessPlusMazeModule.DailyDupPOD ~= nil then
		EndlessPlusMazeModule.GlobalCid = EndlessPlusMazeModule.DailyDupPOD.common.openCount
	end
end

function EndlessPlusMazeModule.Update(dailyDupPOD)
	EndlessPlusMazeModule.DailyDupPOD = deepClonePOD(dailyDupPOD, EndlessPlusMazeModule.DailyDupPOD)
	EndlessPlusMazeModule.GlobalCid = EndlessPlusMazeModule.DailyDupPOD.common.openCount
end

function EndlessPlusMazeModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[17]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and EndlessPlusMazeModule.DailyDupPOD ~= nil and EndlessPlusMazeModule.DailyDupPOD.common.status ~= 0
end

function EndlessPlusMazeModule.SendEnterLevel(levelCid, formationId)
	MazeModule.SendEnterEndlessPlusMaze(levelCid, formationId)
end

function EndlessPlusMazeModule.ChallengeExBoss(formationId)
	if EndlessPlusMazeModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_abyssPlus.challengeExBoss(formationId)
end

function EndlessPlusMazeModule.ChallengeExBossResult()
	return
end

function EndlessPlusMazeModule.NotifyChallengeExBossComplete(win, getItems, dmgRecords)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function EndlessPlusMazeModule.SendUseRunes(runeCidList)
	net_abyssPlus.useRune(runeCidList)
end

function EndlessPlusMazeModule.GetExploreUIAsset()
	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	return cfgEndlessPlusGlobalData.ExploreHallUIBG
end

function EndlessPlusMazeModule.GetMallCidList()
	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	return cfgEndlessPlusGlobalData.MallGoods
end

function EndlessPlusMazeModule.IsPreviousLevelPassed(levelCid)
	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]
	local levelIndex = table.indexOf(cfgEndlessPlusGlobalData.Level, levelCid)
	local previousLevelIndex = levelIndex - 1

	if previousLevelIndex <= 0 then
		return true
	end

	local previousLevelCid = cfgEndlessPlusGlobalData.Level[previousLevelIndex]
	local previousLevelCfgData = CfgEndlessPlusLevelTable[previousLevelCid]
	local passedLayersInPreviousLevel = EndlessPlusMazeModule.DailyDupPOD.abyssPlusPOD.levelScore[previousLevelCid]

	passedLayersInPreviousLevel = passedLayersInPreviousLevel or 0

	return passedLayersInPreviousLevel >= previousLevelCfgData.Clearance
end

function EndlessPlusMazeModule.GetSortedRuneSuitLists(runes)
	local suitMap = {}
	local cidList = {}
	local numList = {}

	for i = 1, #runes do
		local runeCid = runes[i]
		local cfgRuneData = CfgRuneTable[runeCid]

		table.addValue(suitMap, cfgRuneData.QualityConstitute, 1)
		table.addValue(suitMap, cfgRuneData.TypeConstitute, 1)
	end

	local partList = {}

	for cid, num in pairs(suitMap) do
		table.insert(partList, {
			cid = cid,
			num = num
		})
	end

	table.sort(partList, function(data1, data2)
		return data1.num > data2.num
	end)

	for i = 1, #partList do
		table.insert(cidList, partList[i].cid)
		table.insert(numList, partList[i].num)
	end

	return cidList, numList
end

function EndlessPlusMazeModule.GetLegendRuneSuitCidList(cidList, numList)
	local legendCidList = {}

	for cid, cfgLegendConstituteData in pairsCfg(CfgLegendConstituteTable) do
		local isActive = true

		for i = 1, #cfgLegendConstituteData.RuneConstitute do
			local requireRuneSuitCid = cfgLegendConstituteData.RuneConstitute[i]
			local index = table.indexOf(cidList, requireRuneSuitCid)

			if index == -1 then
				isActive = false

				break
			end

			local requireRuneNum = cfgLegendConstituteData.ConstituteNum[i]

			if requireRuneNum > numList[index] then
				isActive = false

				break
			end
		end

		if isActive then
			table.insert(legendCidList, cid)
		end
	end

	return legendCidList
end

function EndlessPlusMazeModule.IsInChallengeLimitTime()
	local cfgDailyDupData = CfgDailyDupTable[EndlessPlusMazeModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = EndlessPlusMazeModule.DailyDupPOD.common.openDate
	local accessLevelEndTime = openDate + cfgDailyDupData.AccessibleTime
	local isInChallengeLimitTime = openDate <= currentServerTime and currentServerTime <= accessLevelEndTime

	if not isInChallengeLimitTime then
		NoticeModule.ShowNotice(21057003)
	end

	return isInChallengeLimitTime
end

function EndlessPlusMazeModule.Shutdown()
	EndlessPlusMazeModule.DailyDupPOD = nil
	EndlessPlusMazeModule.GlobalCid = 0
end
