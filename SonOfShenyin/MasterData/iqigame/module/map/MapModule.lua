-- chunkname: @IQIGame\\Module\\Map\\MapModule.lua

MapModule = {
	MapMaxY = 2048,
	MapMaxX = 4096,
	CellsNum = CfgDiscreteDataTable[87].Data[1],
	LastStageItemDatas = {},
	NormalStageID = CfgDiscreteDataTable[110].Data[1]
}

function MapModule.Initialize()
	MapItemManager.Initialize()
end

function MapModule.EnterGame(stageType, stageConfigID)
	local chapterType
	local userData = {}

	if stageType == Constant.MapStageType.Boss then
		chapterType = Constant.ChapterPassType.TYPE_BOSS
	elseif stageType == Constant.MapStageType.Equip then
		chapterType = Constant.ChapterPassType.TYPE_EQUIP
	elseif stageType == Constant.MapStageType.Resource then
		chapterType = Constant.ChapterPassType.TYPE_RESOURCES
	elseif stageType == Constant.MapStageType.Tower then
		chapterType = Constant.ChapterPassType.TYPE_CLIMB_TOWER
	elseif stageType == Constant.MapStageType.Daily then
		chapterType = Constant.ChapterPassType.TYPE_RANDOMDAILY

		local randomDup = MapModule.GetRandomDuoDropID(stageConfigID)

		if randomDup ~= nil then
			local monsterTeamID = randomDup.monsterTeamId

			userData.MonsterTeam = {
				monsterTeamID
			}
		end
	elseif stageType == Constant.MapStageType.Challenge then
		chapterType = Constant.ChapterPassType.TYPE_Challenge
	end

	userData.OpenType = 2
	userData.ChapterType = chapterType
	userData.StageId = stageConfigID

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function MapModule.GetMainLineNewUnlock()
	local serverStageId = MapModule.GetcurstagePreviousStage()
	local smallItemCfgs = {}

	for k, v in pairsCfg(CfgWorldMapItemTable) do
		if v.Type == Constant.MapStageType.MainLine then
			table.insert(smallItemCfgs, v)
		end
	end

	table.sort(smallItemCfgs, function(a, b)
		return a.Id < b.Id
	end)

	if serverStageId == nil then
		return smallItemCfgs[1]
	end

	for i = 1, #smallItemCfgs do
		if smallItemCfgs[i].Id == serverStageId then
			if smallItemCfgs[i + 1] == nil then
				return smallItemCfgs[i]
			end

			return smallItemCfgs[i + 1]
		end
	end
end

function MapModule.GetMainLineIsFinish()
	local serverStageId = MapModule.GetcurstagePreviousStage()

	if serverStageId == nil then
		return false
	end

	local smallItemCfgs = {}

	for k, v in pairsCfg(CfgWorldMapItemTable) do
		if v.Type == Constant.MapStageType.MainLine then
			table.insert(smallItemCfgs, v)
		end
	end

	table.sort(smallItemCfgs, function(a, b)
		return a.Id < b.Id
	end)

	if serverStageId == smallItemCfgs[#smallItemCfgs].Id then
		return true
	end

	return false
end

function MapModule.FuncIsOpen(type)
	local chapterType

	if type == Constant.MapStageType.Resource then
		chapterType = Constant.UnlockType.FUNC_DAILY_DUP
	elseif type == Constant.MapStageType.Equip then
		chapterType = Constant.UnlockType.FUNC_EQUIP_DUP
	elseif type == Constant.MapStageType.Boss then
		chapterType = Constant.UnlockType.FUNC_CHAPTER_BOOS
	elseif type == Constant.MapStageType.Tower then
		chapterType = Constant.UnlockType.FUNC_CHAPTER_TOWER
	end

	return UnlockFunctionModule.IsUnlock(chapterType)
end

function MapModule.GetMainLineChapterIsFinishByCid(markCid)
	return StoryChapterModule.FinishDupDict[markCid] ~= nil
end

function MapModule.ActivityIsOpen(chapterId)
	return ActivityModule.IsOpenByTime(CfgDailyDupChapterTable[chapterId].ActivityId)
end

function MapModule.GetNewUnlockMap()
	local mapCfgs = {}
	local unlockCfg = {}

	for k, v in pairsCfg(CfgWorldMapTable) do
		table.insert(mapCfgs, v)
	end

	table.sort(mapCfgs, function(a, b)
		return a.Id > b.Id
	end)

	for i = 1, #mapCfgs do
		if mapCfgs[i].UnlockCondition ~= 0 and ConditionModule.Check(mapCfgs[i].UnlockCondition) then
			return mapCfgs[i]
		end
	end

	return unlockCfg[1]
end

function MapModule.GetCloudIsPlayed(smallId)
	for k, v in pairs(PlayerModule.PlayerInfo.baseInfo.effectIds) do
		if v == smallId then
			return true
		end
	end

	return false
end

function MapModule.GetRandomDuoDropID(stageID)
	for k, v in pairs(PlayerModule.PlayerInfo.randomDups) do
		if v.cid == stageID then
			return v
		end
	end

	return nil
end

function MapModule.EnterMapResult(mapDatas)
	EventDispatcher.Dispatch(EventID.EnterMapResultEvent)
end

function MapModule.ExitMapResult()
	return
end

function MapModule.NotifyUpdateMapSmall(mapDatas)
	EventDispatcher.Dispatch(EventID.NotifyUpdateMapSmall)
end

function MapModule.NotifyUpdateMapItem(mapDatas)
	EventDispatcher.Dispatch(EventID.NotifyUpdateMapItem)
end

function MapModule.TakeNotesEffectIdResult()
	return
end

function MapModule.NotifyDailyDup(dupPODs)
	PlayerModule.PlayerInfo.randomDups = dupPODs

	EventDispatcher.Dispatch(EventID.OnAllDailyDupsUpdate)
end

function MapModule.NotifyFinishDup(randomDupPod)
	local updateIndex

	for k, v in pairs(PlayerModule.PlayerInfo.randomDups) do
		if v.cid == randomDupPod.cid then
			updateIndex = k
		end
	end

	PlayerModule.PlayerInfo.randomDups[updateIndex] = randomDupPod

	if randomDupPod.state == true then
		EventDispatcher.Dispatch(EventID.OnSingleDailyDupUpdate, randomDupPod.smallId)
	end
end

function MapModule.EnterMap(partId, itemType)
	net_mapData.enterMap(partId, true, MapModule.CellsNum)
end

function MapModule.ExitMap()
	net_mapData.exitMap()
end

function MapModule.TakeNotesEffectId(smallId)
	net_mapData.takeNotesEffectId(smallId)
end

function MapModule.Shutdown()
	MapItemManager.Shutdown()
end

function MapModule.GetAllUnlockItem(type, hasMainline)
	local allItems = {}
	local challengeDupPod = PlayerModule.GetChallengeDupPod()

	for k, v in pairsCfg(CfgWorldMapItemTable) do
		if StoryChapterModule.FinishDupDict[v.Id] == nil and ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(v.ShowConditionId)) and v.Type ~= Constant.MapStageType.Daily and v.Type ~= Constant.MapStageType.Favor and v.Type ~= Constant.MapStageType.Challenge then
			if type then
				if v.Type == type then
					table.insert(allItems, v)
				end
			elseif hasMainline == true then
				table.insert(allItems, v)
			elseif v.Type ~= Constant.MapStageType.MainLine then
				if v.Type == Constant.MapStageType.Challenge and (not challengeDupPod[v.Id] or not challengeDupPod[v.Id].state) then
					table.insert(allItems, v)
				else
					table.insert(allItems, v)
				end
			end
		end
	end

	return allItems
end

function MapModule.GetIsFinishByStageID(stageId)
	return StoryChapterModule.FinishDupDict[stageId] ~= nil
end

function MapModule.GetAllMarkItem()
	local allItems = {}

	for k, v in pairsCfg(CfgWorldMapMarkTable) do
		if ConditionModule.Check(CfgWorldMapTable[v.SmallID].UnlockCondition) then
			table.insert(allItems, v)
		end
	end

	return allItems
end

function MapModule.GetDailyStages(mapId)
	local chapterDupPod = PlayerModule.GetChallengeDupPod()
	local data = {}

	for _, v in pairsCfg(CfgWorldMapItemTable) do
		if ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(v.ShowConditionId)) and v.Type == Constant.MapStageType.Challenge and (not chapterDupPod[v.Id] or not chapterDupPod[v.Id].state) then
			table.insert(data, v)
		end
	end

	table.sort(data, function(a, b)
		return a.Id < b.Id
	end)

	return data
end

function MapModule.GetDailyStageCfgBySmallId(smallId)
	return CfgWorldMapItemTable[smallId]
end

function MapModule.CheckChallengeIsAllPass(chapterId)
	local cfgChapterList = MapModule.GetChallengeCfgWithChapterID(chapterId)
	local chapterDupPod = PlayerModule.GetChallengeDupPod()
	local len = #cfgChapterList

	for i = 1, len do
		if not chapterDupPod[cfgChapterList[i].Id] or not chapterDupPod[cfgChapterList[i].Id].state then
			return false
		end
	end

	return true
end

function MapModule.CheckChallengeTipsShow()
	local serverDup = PlayerModule.GetChallengeDupPod()
	local chapterData = {}

	for _, v in pairsCfg(CfgWorldMapItemTable) do
		if v.Type == Constant.MapStageType.Challenge then
			if not chapterData[v.ChapterId] then
				chapterData[v.ChapterId] = {}
			end

			table.insert(chapterData[v.ChapterId], v)
		end
	end

	local generalChapterData = {}

	for i, v in pairsCfg(CfgGeneralDupChapterTable) do
		if v.Type == Constant.ChapterPassType.TYPE_Challenge then
			generalChapterData[i] = v.Index
		end
	end

	table.sort(chapterData, function(a, b)
		return generalChapterData[a.ChapterId] < generalChapterData[b.ChapterId]
	end)

	local currentStateId
	local completeAll = true

	for i, v in OrderPairs(chapterData) do
		local isAllUnlock = true
		local isAllPass = true

		for j, v2 in pairs(v) do
			local isPass = serverDup[v2.Id] and serverDup[v2.Id].state
			local isUnlock = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(v2.ShowConditionId))

			if not isPass then
				isAllPass = false
				completeAll = false
			end

			if not isUnlock then
				isAllUnlock = false

				break
			end
		end

		if isAllUnlock and not isAllPass then
			currentStateId = i
		end
	end

	if completeAll then
		local saveData = PlayerPrefsUtil.GetLuaTable("", Constant.PlayerPrefsConst.ChallengeTipData)

		saveData = saveData or {}

		if saveData.completeAll and saveData.completeAll == 1 then
			return 0
		else
			saveData.completeAll = 1

			PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.ChallengeTipData, saveData)
			PlayerPrefsUtil.Save()

			return 2
		end
	end

	if not currentStateId then
		return 0
	end

	local isShowOpenTip = true
	local isShowFinishedTip = true
	local lastChapterId

	for i, _ in OrderPairs(chapterData) do
		if i == currentStateId then
			break
		end

		lastChapterId = i
	end

	local lastChapterDup = chapterData[lastChapterId]

	if lastChapterDup then
		for _, v in pairs(lastChapterDup) do
			if not serverDup[v.Id] then
				isShowFinishedTip = false

				break
			else
				isShowFinishedTip = true
			end
		end
	else
		isShowFinishedTip = false
	end

	local currentChapterDup = chapterData[currentStateId]

	if currentChapterDup then
		for _, v in pairs(currentChapterDup) do
			if serverDup[v.Id] then
				isShowOpenTip = false

				break
			else
				isShowOpenTip = true
			end
		end
	else
		isShowOpenTip = false
	end

	local saveData = PlayerPrefsUtil.GetLuaTable("", Constant.PlayerPrefsConst.ChallengeTipData)

	saveData = saveData or {}

	local openKey = tostring(currentStateId) .. "open"
	local closeKey = tostring(lastChapterId) .. "close"

	if saveData[openKey] and saveData[openKey] == 1 then
		isShowOpenTip = false
	end

	if saveData[closeKey] and saveData[closeKey] == 1 then
		isShowFinishedTip = false
	end

	if isShowOpenTip and isShowFinishedTip then
		saveData[openKey] = 1
		saveData[closeKey] = 1

		PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.ChallengeTipData, saveData)
		PlayerPrefsUtil.Save()

		return 3
	elseif isShowOpenTip and not isShowFinishedTip then
		saveData[openKey] = 1

		PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.ChallengeTipData, saveData)
		PlayerPrefsUtil.Save()

		return 1
	elseif not isShowOpenTip and isShowFinishedTip then
		saveData[closeKey] = 1

		PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.ChallengeTipData, saveData)
		PlayerPrefsUtil.Save()

		return 2
	else
		return 0
	end
end

function MapModule.GetChallengeCfgWithChapterID(chapterId)
	local t = {}

	for _, v in pairsCfg(CfgWorldMapItemTable) do
		if v.Type == Constant.MapStageType.Challenge and v.ChapterId == chapterId then
			table.insert(t, v)
		end
	end

	return t
end

function MapModule.GetcurstagePreviousStage()
	for i = #StoryChapterModule.FinishDupList, 1, -1 do
		if CfgWorldMapItemTable[StoryChapterModule.FinishDupList[i]].Type == Constant.MapStageType.MainLine then
			return StoryChapterModule.FinishDupList[i]
		end
	end

	return nil
end

function MapModule.GetIsHasMainlineStage(dups)
	for k, v in pairs(dups) do
		if CfgWorldMapItemTable[k].Type == Constant.MapStageType.MainLine then
			return true
		end
	end

	return false
end

function MapModule.GetStageIsPlayAnim(stageId)
	return table.indexOf(PlayerModule.PlayerInfo.baseInfo.effectIds, stageId) ~= -1
end

function MapModule.GetMapHasStageByMapID(mapId)
	local allStageDatas = MapModule.GetAllUnlockItem(nil, true)
	local classifitaionStages = {}

	classifitaionStages[Constant.MapStageType.MainLine] = {}
	classifitaionStages[Constant.MapStageType.BranchLine] = {}
	classifitaionStages[Constant.MapStageType.Daily] = MapModule.GetDailyStages(mapId)

	for _, v in pairs(allStageDatas) do
		if v.SmallId == mapId and (v.Type == Constant.MapStageType.MainLine or v.Type == Constant.MapStageType.BranchLine) then
			table.insert(classifitaionStages[v.Type], v)
		end
	end

	return classifitaionStages
end

function MapModule.GetCurUnlockStagesHasStageByID(stageId)
	local unlockList = MapModule.GetAllUnlockItem(nil, true)

	for k, v in pairs(unlockList) do
		if v.Id == stageId then
			return true
		end
	end

	return false
end

function MapModule.GetMainlineFinishState()
	local curStageCfg = MapModule.GetMainLineNewUnlock()

	if curStageCfg == nil or MapModule.GetMainLineIsFinish() or not MapModule.GetCurUnlockStagesHasStageByID(curStageCfg.Id) then
		return true
	end

	return false
end
