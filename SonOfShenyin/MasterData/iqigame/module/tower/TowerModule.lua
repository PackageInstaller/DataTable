-- chunkname: @IQIGame\\Module\\Tower\\TowerModule.lua

TowerChapterModule = {
	climbTowerDupPodDict = {},
	FinishDupList = {}
}

local TowerConditionCid = 600001

function TowerChapterModule.FirstCondition()
	return UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_CHAPTER_TOWER)
end

function TowerChapterModule.GetMaxViewableStageLevel(towerID)
	return TowerChapterModule.GetTowerHighestPassedLevel(towerID).Level + 5
end

function TowerChapterModule.GetStageListByTowerID(towerID)
	local levels = {}

	for levelID, level in pairs(CfgTowerStageTable) do
		if level.ChapterId == towerID then
			levels[level.Level] = level
		end
	end

	table.sort(levels, function(a, b)
		return a.Level < b.Level
	end)

	return levels
end

function TowerChapterModule.Reload(climbTowerDups)
	TowerChapterModule.FSynTowerInfo(climbTowerDups)
end

function TowerChapterModule.RpcEnterDup(passId, units, agentSkill)
	net_climbTowerDup.enterDup(passId, units, agentSkill)
end

function TowerChapterModule.RpcEnterDupResult()
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_CLIMB_TOWER)
end

function TowerChapterModule.RpcDailyPrize(passId)
	net_climbTowerDup.dailyPrize(passId)
end

function TowerChapterModule.RpcDailyPrizeResult(dailyStatus, items)
	EventDispatcher.Dispatch(EventID.TowerDailyRewardReceived, dailyStatus, items)
end

function TowerChapterModule.RpcNotifyDup(dupPODs)
	logDebug("TowerModule.NotifyDup(items)")
	TowerChapterModule.PSynTowerInfo(dupPODs)
	EventDispatcher.Dispatch(EventID.RefreshTowerCfg)
end

function TowerChapterModule.FSynTowerInfo(climbTowerDups)
	TowerChapterModule.ResetTowerDict()

	for _, climbTowerDup in pairs(climbTowerDups) do
		TowerChapterModule.SetTower(climbTowerDup.cid, climbTowerDup)

		for stageID, passStatus in pairs(climbTowerDup.passStatus or {}) do
			if passStatus ~= 0 then
				TowerChapterModule.FinishDupList[stageID] = stageID
			end
		end
	end
end

function TowerChapterModule.PSynTowerInfo(climbTowerDups)
	for _, climbTowerDup in pairs(climbTowerDups) do
		TowerChapterModule.SetTower(climbTowerDup.cid, climbTowerDup)

		for stageID, passStatus in pairs(climbTowerDup.passStatus or {}) do
			if passStatus ~= 0 then
				TowerChapterModule.FinishDupList[stageID] = stageID
			end
		end
	end
end

function TowerChapterModule.SetTowerDailyStatus(towerID, dailyStatus)
	TowerChapterModule.GetTowerByID(towerID).dailyStatus = dailyStatus
end

function TowerChapterModule.ResetTowerDict()
	TowerChapterModule.climbTowerDupPodDict = {}
end

function TowerChapterModule.GetAllTowerCfg()
	return TowerChapterModule.climbTowerDupPodDict
end

function TowerChapterModule.GetTowerByID(id)
	local towerPod = PlayerModule.GetTowerDupPod()

	for _, v in pairs(towerPod) do
		if v.cid == id then
			return v
		end
	end

	return nil
end

function TowerChapterModule.SetTower(id, tower)
	TowerChapterModule.climbTowerDupPodDict[id] = tower
end

function TowerChapterModule.HasDailyRewardToReceive(towerID)
	local towerInfo = TowerChapterModule.GetTowerByID(towerID)
	local dailyStatus = towerInfo.dailyStatus or {}

	for stageID, receiveTime in pairs(dailyStatus) do
		if tonumber(receiveTime) == 0 then
			return true, CfgTowerStageTable[stageID]
		end
	end

	return false, {}
end

function TowerChapterModule.IsStagePassed(stageID)
	return TowerChapterModule.FinishDupList[stageID] ~= nil
end

function TowerChapterModule.GetTowerHighestStage(towerID)
	local stageList = TowerChapterModule.GetStageListByTowerID(towerID)
	local highest = 0
	local highestStage = {}

	for level, stage in pairs(stageList) do
		if highest < level then
			highest = level
			highestStage = stage
		end
	end

	return highestStage
end

function TowerChapterModule.GetTowerHighestPassedLevel(towerID)
	local stageList = TowerChapterModule.GetStageListByTowerID(towerID)
	local chapterInfo = TowerChapterModule.GetTowerByID(towerID) or {}
	local stagePassStatus = chapterInfo.passStatus or {}
	local highest = 0
	local highestStage = {}

	for level, stage in pairs(stageList) do
		if stagePassStatus[stage.Id] and stagePassStatus[stage.Id] ~= 0 and highest < level then
			highest = level
			highestStage = stage
		end
	end

	return highestStage
end

function TowerChapterModule.GetTowerLowestNotPassedStage(towerID)
	local stageList = TowerChapterModule.GetStageListByTowerID(towerID)
	local chapterInfo = TowerChapterModule.GetTowerByID(towerID) or {}
	local stagePassStatus = chapterInfo.passStatus or {}
	local lowest = 4294967296
	local lowestStage = {}

	for level, stage in pairs(stageList) do
		if (not stagePassStatus[stage.Id] or stagePassStatus[stage.Id] == 0) and level < lowest then
			lowest = level
			lowestStage = stage
		end
	end

	return lowestStage
end

function TowerChapterModule.GetTowerDailyRewardNotReceivedLevel(towerID)
	local towerInfo = TowerChapterModule.GetTowerByID(towerID)
	local dailyStatus = towerInfo.dailyStatus or {}

	for stageID, status in pairs(dailyStatus) do
		if status == 0 then
			return CfgTowerStageTable[stageID]
		end
	end

	return {}
end

function TowerChapterModule.GetTowerCfgData()
	local data = {}

	for _, v in pairsCfg(CfgTowerChapterTable) do
		table.insert(data, v)
	end

	table.sort(data, function(a, b)
		return a.Id < b.Id
	end)

	return data
end

function TowerChapterModule.GetTheLastCanStart(chapterId)
	local chapterDup = TowerChapterModule.GetTowerByID(chapterId)

	if not chapterDup then
		return 1
	end

	local stageArray = TowerChapterModule.GetStageListByTowerID(chapterId)
	local len = #stageArray

	if not stageArray or len <= 0 then
		return 1
	end

	local len = #stageArray
	local level = len
	local passState = chapterDup.passStatus

	for i = 1, #stageArray do
		local stageId = stageArray[i].Id

		if not passState[stageId] or passState[stageId] == 0 then
			level = stageArray[i].Level

			break
		end
	end

	return level
end

function TowerChapterModule.GetTowerChapterIsAllPass(chapterId)
	local chapterDup = TowerChapterModule.GetTowerByID(chapterId)

	if not chapterDup then
		return false
	end

	local stageArray = TowerChapterModule.GetStageListByTowerID(chapterId)
	local len = #stageArray

	if not stageArray or len <= 0 then
		return true
	end

	local passState = chapterDup.passStatus

	for i = 1, #stageArray do
		local stageId = stageArray[i].Id

		if not passState[stageId] or passState[stageId] == 0 then
			return false
		end
	end

	return true
end

function TowerChapterModule.GetCfgTowerStageWithLevel(chapterId, level)
	for _, v in pairsCfg(CfgTowerStageTable) do
		if v.ChapterId == chapterId and v.Level == level then
			return v
		end
	end

	return nil
end
