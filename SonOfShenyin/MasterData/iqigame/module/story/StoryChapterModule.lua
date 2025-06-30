-- chunkname: @IQIGame\\Module\\Story\\StoryChapterModule.lua

StoryChapterModule = {
	FinishDupList = {},
	FinishDupDict = {},
	ServerDupList = {},
	unlockedChapterDict = {}
}

local this = StoryChapterModule
local firstChapterID = 100
local firstStageID = 100011

function StoryChapterModule.Init()
	return
end

function StoryChapterModule.Shutdown()
	return
end

function StoryChapterModule.Reload(generalDups)
	StoryChapterModule.FinishDupList = {}
	StoryChapterModule.FinishDupDict = {}
	StoryChapterModule.ServerDupList = generalDups

	StoryChapterModule.RefreshFinishDup(generalDups)

	StoryChapterModule.unlockedChapterDict = StoryChapterModule.GetUnlockedChapterDict()
end

function StoryChapterModule.RefreshFinishDup(generalDups)
	for Id, pod in pairs(generalDups) do
		if pod > 0 then
			table.insert(StoryChapterModule.FinishDupList, Id)

			StoryChapterModule.FinishDupDict[Id] = Id
		elseif pod == 0 and StoryChapterModule.FinishDupDict[Id] then
			StoryChapterModule.FinishDupDict[Id] = nil

			local idx = 0

			for i, v in ipairs(StoryChapterModule.FinishDupList) do
				if v == Id then
					idx = i
				end
			end

			table.remove(StoryChapterModule.FinishDupList, idx)
		end

		StoryChapterModule.ServerDupList[Id] = pod
	end

	table.sort(StoryChapterModule.FinishDupList, function(a, b)
		return a < b
	end)
	EventDispatcher.Dispatch(EventID.OnNotifyStage, generalDups)
end

function StoryChapterModule.NotifyFinishDup(completePOD, stageCid)
	if StoryModule.isDebugFight then
		StoryModule.OnCompleteLevel()

		StoryModule.isDebugFight = false

		return
	end

	if stageCid == 0 then
		SceneTransferModule.StoryToMainCity(completePOD, {
			revertUI = true
		})
		EventDispatcher.Dispatch(EventID.StoryGuideComplete)

		return
	end

	local worldMapItemCfg = CfgUtil.GetCfgWorldMapItemDataWithID(stageCid)

	if worldMapItemCfg and worldMapItemCfg.NextLevel and worldMapItemCfg.NextLevel ~= 0 then
		-- block empty
	else
		SceneTransferModule.StoryToMainCity(completePOD, {
			revertUI = true
		})
	end

	EventDispatcher.Dispatch(EventID.StoryGuideComplete)
end

function StoryChapterModule.GetLatestStageID()
	local unlockedStages = {}

	for _, stageConfig in pairsCfg(CfgWorldMapItemTable) do
		if stageConfig.ItemType == Constant.MapStageType.MainLine and ConditionModule.Check(stageConfig.ShowConditionId) then
			table.insert(unlockedStages, stageConfig)
		end
	end

	table.sort(unlockedStages, function(stageConfigLeft, stageConfigRight)
		return stageConfigLeft.Id < stageConfigRight.Id
	end)

	if #unlockedStages > 0 then
		return math.max(unlockedStages[#unlockedStages].Id, firstStageID)
	else
		return firstStageID
	end
end

function StoryChapterModule.GetUnlockedChapterDict()
	local unlockedChapterList = {}

	for _, chapter in pairsCfg(CfgGeneralDupChapterTable) do
		if ConditionModule.Check(chapter.UnlockConditionId) then
			unlockedChapterList[chapter.Id] = chapter
		end
	end

	return unlockedChapterList
end

function StoryChapterModule.GetLatestUnlockedChapter()
	local unlockedChapterList = {}

	for _, config in pairsCfg(CfgGeneralDupChapterTable) do
		if ConditionModule.Check(config.UnlockConditionId) then
			unlockedChapterList[config.Index] = config
		end
	end

	local highest = -1
	local highestChapter = {}

	for index, chapter in pairs(unlockedChapterList) do
		if highest < index then
			highest = index
			highestChapter = chapter
		end
	end

	return highestChapter
end

function StoryChapterModule.GetNextChapterByIndex(index)
	for _, chapter in pairsCfg(CfgGeneralDupChapterTable) do
		if chapter.Index == index + 1 then
			return chapter
		end
	end

	return nil
end

function StoryChapterModule.GetLatestUnlockedStage(idTable)
	if not idTable or not idTable.chapterID and not idTable.stageID then
		logError("StoryChapterModule.GetLatestUnlockedStage need [chapterID] or [stageID] param")

		return
	end

	if idTable.stageID then
		idTable.chapterID = StoryChapterModule.GetStageByID(idTable.stageID).ChapterId
	end

	local stageList = StoryChapterModule.GetStageListByChapterID(idTable.chapterID)
	local unlockedStageList = {}

	for index, config in pairs(stageList) do
		if ConditionModule.Check(config.UnlockConditionId) then
			unlockedStageList[index] = config
		end
	end

	local highest = -1
	local highestStage = {}

	for index, stage in pairs(unlockedStageList) do
		if highest < index then
			highest = index
			highestStage = stage
		end
	end

	return highestStage
end

function StoryChapterModule.GetNextStageByStageID(chapterID, index)
	local stageList = StoryChapterModule.GetStageListByChapterID(chapterID)

	for _, stage in pairsCfg(stageList) do
		if stage.Index == index + 1 then
			return stage
		end
	end

	return nil
end

function StoryChapterModule.GetChapterByID(id)
	return CfgGeneralDupChapterTable[id]
end

function StoryChapterModule.GetStageByID(id)
	return CfgWorldMapItemTable[id]
end

function StoryChapterModule.GetChapterList()
	local chapterList = {}

	for _, chapterConfig in pairsCfg(CfgGeneralDupChapterTable) do
		chapterList[chapterConfig.Index] = chapterConfig
	end

	return chapterList
end

function StoryChapterModule.GetChapterLinkedList()
	local chapterList = StoryChapterModule.GetChapterList()

	for index = 0, #chapterList do
		chapterList[index].Prev = chapterList[index - 1]
		chapterList[index].Next = chapterList[index + 1]
	end

	return chapterList
end

function StoryChapterModule.GetStageDictWithLinked()
	local stageList = StoryChapterModule.GetStageList()

	table.sort(stageList, function(a, b)
		return a.Id < b.Id
	end)

	local stageMap = {}

	for index = 1, #stageList do
		stageList[index].Prev = stageList[index - 1]
		stageList[index].Next = stageList[index + 1]
		stageMap[stageList[index].Id] = stageList[index]
	end

	return stageMap
end

function StoryChapterModule.GetStageList()
	local stageList = {}

	for _, stageConfig in pairsCfg(CfgWorldMapItemTable) do
		if stageConfig.ItemType == Constant.MapStageType.MainLine then
			table.insert(stageList, stageConfig)
		end
	end

	return stageList
end

function StoryChapterModule.GetStageListByChapterID(chapterID)
	local stageList = {}

	for _, stageConfig in pairsCfg(CfgWorldMapItemTable) do
		if stageConfig.ItemType == Constant.MapStageType.MainLine and stageConfig.ChapterId == chapterID then
			stageList[stageConfig.Index] = stageConfig
		end
	end

	return stageList
end

function StoryChapterModule.GetStageDictByChapterID(chapterID)
	local stageDict = {}

	for _, stageConfig in pairsCfg(CfgWorldMapItemTable) do
		if stageConfig.ItemType == Constant.MapStageType.MainLine and stageConfig.ChapterId == chapterID then
			stageDict[stageConfig.Id] = stageConfig
		end
	end

	return stageDict
end

function StoryChapterModule.GetDropItems(stageID)
	local drops = {}

	for _, dropID in pairs(CfgWorldMapItemTable[stageID].FirstReward) do
		table.insert(drops, {
			tag = ItemCell.TagEnum.FirstPass,
			dropID = dropID
		})
	end

	for _, dropID in pairs(CfgWorldMapItemTable[stageID].PassReward) do
		table.insert(drops, {
			tag = ItemCell.TagEnum.None,
			dropID = dropID
		})
	end

	return drops
end

function StoryChapterModule:GetChapterProgress(chapterID)
	local stageDict = StoryChapterModule.GetStageDictByChapterID(chapterID)
	local finishedCount = 0

	for stageID, _ in pairs(stageDict) do
		if StoryChapterModule.FinishDupDict[stageID] then
			finishedCount = finishedCount + 1
		end
	end

	local total = getTableLength(stageDict)

	return finishedCount / total
end

function StoryChapterModule:GetStartStage(chapterID, stageID)
	if stageID then
		return StoryChapterModule.GetStageByID(stageID)
	end

	return StoryChapterModule.GetLatestUnlockedStage({
		chapterID = chapterID
	})
end

function StoryChapterModule.GetChapterIsFinished(stageID)
	return StoryChapterModule.FinishDupDict[stageID]
end

function StoryChapterModule.EnterDup(dupId, isReview)
	isReview = isReview and true or false
	StoryModule.isReview = isReview

	local cfgWorldMap = CfgUtil.GetCfgWorldMapItemDataWithID(dupId)

	if cfgWorldMap and cfgWorldMap.MainTaskId and cfgWorldMap.MainTaskId ~= 0 and TaskSystemModule.GetTaskByPlayer(cfgWorldMap.MainTaskId) then
		TaskSystemModule.TrackTask(cfgWorldMap.MainTaskId)
	end

	net_generalDup.enterDup(dupId, isReview)
end

function this.GetStoryReviewData()
	local tb = {}

	for _, v in pairs(CfgGeneralDupChapterTable) do
		if v.PlotType == Constant.StoryReviewType.Main or v.PlotType == Constant.StoryReviewType.Continue then
			table.insert(tb, v)
		end
	end

	table.sort(tb, function(a, b)
		return a.Id < b.Id
	end)

	return tb
end

function this.GetStoryReviewStageData(generalDupID)
	local tb = {}

	for _, v in pairs(CfgWorldMapItemTable) do
		if v.ChapterId == generalDupID then
			table.insert(tb, v)
		end
	end

	table.sort(tb, function(a, b)
		return a.Id < b.Id
	end)

	return tb
end

function this.GetStoryReviewStageIsLock(worldMapItemId)
	return this.FinishDupDict[worldMapItemId] and true or false
end

function this.GetStageIsCompleteWithID(worldMapItemId)
	return this.ServerDupList[worldMapItemId] and this.ServerDupList[worldMapItemId] >= 1 or false
end

function this.GetStageChallengeCount(worldMapItemId)
	return this.ServerDupList[worldMapItemId] and this.ServerDupList[worldMapItemId] or 0
end
