-- chunkname: @IQIGame\\Module\\Maze\\MazeDataModule.lua

MazeDataModule = {}
MazeDataModule.PlayerInfo = {
	AbyssDifficulty = 0,
	PlayerCameraType = 0,
	MonsterGrade = 0,
	ExploreScore = 0,
	EnergyMax = 0,
	TempHeroSoulCid = 0,
	ExamDurationChange = 0,
	AbyssPowerId = 0,
	MiniMapSwitch = false,
	Duration = 0,
	Energy = 0,
	BaseInfo = {
		pid = 0,
		vipExp = 0,
		vip = 0,
		exp = 0,
		leaderCid = 0,
		headIcon = 0,
		avatarFrame = 0,
		serverId = 0,
		pLv = 0,
		pName = 0
	}
}
MazeDataModule.DollDataList = nil
MazeDataModule.TempActiveDollDataList = nil
MazeDataModule.__SoulDataMap = nil
MazeDataModule.__SoulItemDataEquips = nil
MazeDataModule.Items = {}
MazeDataModule.LogicID = 0
MazeDataModule.MazeInstanceID = 0
MazeDataModule.MazeLevelCID = 0
MazeDataModule.MazeLevelResID = 0
MazeDataModule.MazeMapPathNodes = nil
MazeDataModule.SettlementData = {
	Score = 0,
	Money = 0,
	PlayerExp = 0,
	Success = false
}
MazeDataModule.MazeMapData = {}
MazeDataModule.ActiveNodeMaxX = 0
MazeDataModule.ActiveNodeMaxY = 0
MazeDataModule.AllNodeMinX = 2147483647
MazeDataModule.AllNodeMinY = 2147483647
MazeDataModule.AllNodeMaxX = 0
MazeDataModule.AllNodeMaxY = 0
MazeDataModule.MinNodeXIndex = 0
MazeDataModule.MaxNodeXIndex = 0
MazeDataModule.MinNodeYIndex = 0
MazeDataModule.MaxNodeYIndex = 0
MazeDataModule.ElementPODs = nil
MazeDataModule.ElementPODGrid = nil
MazeDataModule.LeaderElementPOD = nil
MazeDataModule.WeatherCid = 0
MazeDataModule.AreaNodeDistanceX = 0
MazeDataModule.AreaNodeDistanceY = 0
MazeDataModule.CurrDialog = 0
MazeDataModule.IsFirstTimeHere = false
MazeDataModule.IsRestoreMaze = false
MazeDataModule.SoulLvExpListBeforeQuit = nil
MazeDataModule.StarConditions = nil
MazeDataModule.StartTime = nil
MazeDataModule.ChangeStateElementRatio = 0
MazeDataModule.ChapterType = 0
MazeDataModule.StreamingLoadType = 0
MazeDataModule.MapUILimitType = 0

local AreaNodeData = require("IQIGame.Module.Maze.AreaNodeData")
local MazeElementPOD = require("IQIGame.Module.Maze.MazeElementPOD")
local MazeUpdateDollEventData = require("IQIGame.Module.Maze.MazeUpdateDollEventData")

function MazeDataModule.Init()
	local params = string.split(CfgMazeGlobalTable[1002].Parameter, "|")

	MazeDataModule.AreaNodeDistanceX = tonumber(params[1])
	MazeDataModule.AreaNodeDistanceY = tonumber(params[2])
end

function MazeDataModule.AddEventListeners()
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.EnterMazeCommandEventId, MazeDataModule.OnUpdateMazeData)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdatePlayerInfoCommandEventId, MazeDataModule.OnUpdatePlayerInfo)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateItemCommandEventId, MazeDataModule.OnUpdateItems)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateDollCommandEventId, MazeDataModule.OnUpdateDolls)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateCompleteEventCommandEventId, MazeDataModule.OnUpdateCompleteEvents)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdatePlayerParamsCommandEventId, MazeDataModule.OnUpdatePlayerParams)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateBuffCommandEventId, MazeDataModule.OnUpdateBuff)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateNumAttrCommandEventId, MazeDataModule.OnUpdateNumAttr)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateMapPathNodeCommandEventId, MazeDataModule.OnUpdateMapPathNode)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateDollAttrCommandEventId, MazeDataModule.OnUpdateDollAttr)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateElementCommandEventId, MazeDataModule.OnUpdateElement)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateExploreScoreCommandEventId, MazeDataModule.OnUpdateExploreScore)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateMazeTaskCommandEventId, MazeDataModule.OnMazeTaskUpdate)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyUpdateRuneCommandEventId, MazeDataModule.OnUpdateRune)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateStarConditionCommandEventId, MazeDataModule.OnUpdateStarCondition)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateItemDropGetCntsCommandEventId, MazeDataModule.OnUpdateItemDropGetCnts)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateEnergyCommandEventId, MazeDataModule.OnUpdateEnergy)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateExamDurationCommandEventId, MazeDataModule.OnUpdateExamDuration)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateTempHeroSoulCommandEventId, MazeDataModule.OnUpdateTempHeroSoul)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.UpdateAbyssDifficultyCommandEventId, MazeDataModule.OnUpdateAbyssDifficulty)
end

function MazeDataModule.RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.EnterMazeCommandEventId, MazeDataModule.OnUpdateMazeData)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdatePlayerInfoCommandEventId, MazeDataModule.OnUpdatePlayerInfo)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateItemCommandEventId, MazeDataModule.OnUpdateItems)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateDollCommandEventId, MazeDataModule.OnUpdateDolls)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateCompleteEventCommandEventId, MazeDataModule.OnUpdateCompleteEvents)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdatePlayerParamsCommandEventId, MazeDataModule.OnUpdatePlayerParams)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateBuffCommandEventId, MazeDataModule.OnUpdateBuff)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateNumAttrCommandEventId, MazeDataModule.OnUpdateNumAttr)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateMapPathNodeCommandEventId, MazeDataModule.OnUpdateMapPathNode)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateDollAttrCommandEventId, MazeDataModule.OnUpdateDollAttr)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateElementCommandEventId, MazeDataModule.OnUpdateElement)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateExploreScoreCommandEventId, MazeDataModule.OnUpdateExploreScore)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateMazeTaskCommandEventId, MazeDataModule.OnMazeTaskUpdate)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyUpdateRuneCommandEventId, MazeDataModule.OnUpdateRune)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateStarConditionCommandEventId, MazeDataModule.OnUpdateStarCondition)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateItemDropGetCntsCommandEventId, MazeDataModule.OnUpdateItemDropGetCnts)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateEnergyCommandEventId, MazeDataModule.OnUpdateEnergy)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateExamDurationCommandEventId, MazeDataModule.OnUpdateExamDuration)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateTempHeroSoulCommandEventId, MazeDataModule.OnUpdateTempHeroSoul)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.UpdateAbyssDifficultyCommandEventId, MazeDataModule.OnUpdateAbyssDifficulty)
end

function MazeDataModule.OnUpdateAbyssDifficulty(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.PlayerInfo.AbyssDifficulty = command.AbyssDifficulty
	MazeDataModule.PlayerInfo.MonsterGrade = command.MonsterGrade

	EventDispatcher.Dispatch(EventID.AbyssDifficultyChanged)
end

function MazeDataModule.OnUpdateTempHeroSoul(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.PlayerInfo.TempHeroSoulCid = command.SoulCid

	EventDispatcher.Dispatch(EventID.MazeChangeHero)
end

function MazeDataModule.OnUpdateExamDuration(sender, args)
	local command = args:ToLuaTable()
	local oldValue = MazeDataModule.PlayerInfo.ExamDurationChange

	MazeDataModule.PlayerInfo.ExamDurationChange = command.ExamDurationChange

	EventDispatcher.Dispatch(EventID.ExamMazeDurationChange, command.ExamDurationChange - oldValue)
end

function MazeDataModule.OnUpdateEnergy(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.PlayerInfo.Energy = command.Energy
	MazeDataModule.PlayerInfo.EnergyMax = command.EnergyMax

	EventDispatcher.Dispatch(EventID.MazeUpdateEnergy)
end

function MazeDataModule.OnUpdateItemDropGetCnts(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.PlayerInfo.ItemDropGetCnts[command.Cid] = command.Value
end

function MazeDataModule.OnUpdateStarCondition(sender, args)
	if MazeDataModule.StarConditions == nil then
		return
	end

	local command = args:ToLuaTable()

	for i = 1, #MazeDataModule.StarConditions do
		MazeDataModule.StarConditions[i] = MazeDataModule.StarConditions[i] or command.StarConditions[i]
	end
end

function MazeDataModule.OnUpdateRune(sender, args)
	if MazeDataModule.PlayerInfo == nil then
		return
	end

	local command = args:ToLuaTable()
	local mazeRunePOD = command.Rune

	if command.IsRemove then
		for i = 1, #MazeDataModule.PlayerInfo.Runes do
			local pod = MazeDataModule.PlayerInfo.Runes[i]

			if pod.CID == mazeRunePOD.CID then
				table.remove(MazeDataModule.PlayerInfo.Runes, i)

				break
			end
		end
	else
		local found = false

		for i = 1, #MazeDataModule.PlayerInfo.Runes do
			local pod = MazeDataModule.PlayerInfo.Runes[i]

			if pod.CID == mazeRunePOD.CID then
				found = true
				MazeDataModule.PlayerInfo.Runes[i] = mazeRunePOD

				break
			end
		end

		if not found then
			table.insert(MazeDataModule.PlayerInfo.Runes, mazeRunePOD)
			MazeModule.FlyRune()
		else
			MazeModule.RemoveFirstFlyRuneData()
		end
	end

	EventDispatcher.Dispatch(EventID.MazeUpdateRune)
end

function MazeDataModule.OnMazeTaskUpdate(sender, args)
	local command = args:ToLuaTable()
	local oldProgresses = MazeDataModule.PlayerInfo.MazeTasks[command.Cid]

	MazeDataModule.PlayerInfo.MazeTasks[command.Cid] = command.Progresses

	EventDispatcher.Dispatch(EventID.PreUpdateMazeTask, command.Cid, oldProgresses, command.Progresses)
end

function MazeDataModule.OnUpdateExploreScore(sender, args)
	local command = args:ToLuaTable()
	local lastScore = MazeDataModule.PlayerInfo.ExploreScore

	MazeDataModule.PlayerInfo.ExploreScore = command.ExploreScore

	EventDispatcher.Dispatch(EventID.MazeUpdateExploreScore, command.ExploreScore - lastScore)
end

function MazeDataModule.OnUpdateElement(sender, args)
	if MazeDataModule.PlayerInfo == nil then
		return
	end

	local command = args:ToLuaTable()

	for i = 1, #command.ElementData do
		local newElementPOD = command.ElementData[i]
		local targetElementPOD

		for j = 1, #MazeDataModule.ElementPODs do
			local elementPOD = MazeDataModule.ElementPODs[j]

			if elementPOD.ID == newElementPOD.ID then
				targetElementPOD = elementPOD

				break
			end
		end

		if targetElementPOD == nil then
			local pod = MazeElementPOD.New(newElementPOD)

			MazeDataModule.AddElementPOD(pod)
			EventDispatcher.Dispatch(EventID.MazeAddElement, pod)
		else
			local oldNodeId = targetElementPOD.NodeId

			targetElementPOD:Init(newElementPOD)

			if not targetElementPOD.IsRemoved and oldNodeId ~= targetElementPOD.NodeId then
				MazeDataModule.MoveElementPOD(targetElementPOD.ID, targetElementPOD.CID, oldNodeId, targetElementPOD.NodeId)
			end

			EventDispatcher.Dispatch(EventID.MazeUpdateElement, targetElementPOD, oldNodeId)
		end
	end
end

function MazeDataModule.OnUpdateDollAttr(sender, args)
	if MazeDataModule.DollDataList == nil then
		return
	end

	local command = args:ToLuaTable()

	for i = 1, #MazeDataModule.DollDataList do
		local dollPOD = MazeDataModule.DollDataList[i]

		if dollPOD.id == command.DollID then
			local oldValue = dollPOD.finalAttributes[command.AttType]

			dollPOD.finalAttributes[command.AttType] = command.Value

			if command.AttType == Constant.Attribute.TYPE_HP then
				local newValue = command.Value

				if oldValue ~= 0 and newValue == 0 then
					EventDispatcher.Dispatch(EventID.MazeSoulDead, dollPOD)
				elseif oldValue == 0 and newValue ~= 0 then
					EventDispatcher.Dispatch(EventID.MazeSoulRevive, dollPOD)
				end
			end

			local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)

			soulData.atts[command.AttType] = command.Value

			break
		end
	end

	EventDispatcher.Dispatch(EventID.MazeUpdateDollAttr, command.DollID, command.AttType, command.Value)
end

function MazeDataModule.GetCachedSoulLvExpData(soulCid)
	return MazeDataModule.SoulLvExpListBeforeQuit[soulCid]
end

function MazeDataModule.OnUpdateMapPathNode(sender, args)
	if MazeDataModule.PlayerInfo == nil then
		return
	end

	local command = args:ToLuaTable()
	local areaNodeData

	for i = 1, #MazeDataModule.MazeMapPathNodes do
		areaNodeData = MazeDataModule.MazeMapPathNodes[i]

		if areaNodeData.NodeId == command.MazeMapPathNodePOD.NodeID then
			local isActiveJustNow = areaNodeData.IsActive

			MazeDataModule.UpdateAreaNodeData(areaNodeData, command.MazeMapPathNodePOD)

			MazeDataModule.ActiveNodeMaxX = math.max(MazeDataModule.ActiveNodeMaxX, areaNodeData.x)
			MazeDataModule.ActiveNodeMaxY = math.max(MazeDataModule.ActiveNodeMaxY, areaNodeData.y)

			EventDispatcher.Dispatch(EventID.MazeUpdateNodeData, areaNodeData, isActiveJustNow ~= areaNodeData.IsActive)

			break
		end
	end
end

function MazeDataModule.OnUpdateNumAttr(sender, args)
	if MazeDataModule.PlayerInfo == nil then
		return
	end

	local command = args:ToLuaTable()

	for k, v in pairs(command.NumAttrs) do
		MazeDataModule.PlayerInfo.NumAttrs[k] = v
	end

	EventDispatcher.Dispatch(EventID.MazeUpdateNumAttr)
end

function MazeDataModule.OnUpdateBuff(sender, args)
	if MazeDataModule.PlayerInfo == nil then
		return
	end

	local command = args:ToLuaTable()

	if command.Type == 1 then
		MazeDataModule.AddBuff(command.Buff, command.DollID)
	elseif command.Type == 2 then
		MazeDataModule.UpdateBuff(command.Buff, command.DollID)
	elseif command.Type == 3 then
		MazeDataModule.DeleteBuff(command.Buff, command.DollID)
	end

	EventDispatcher.Dispatch(EventID.MazeBuffChanged)
end

function MazeDataModule.OnUpdatePlayerParams(sender, args)
	local command = args:ToLuaTable()

	for k, v in pairs(command.PlayerParams) do
		MazeDataModule.PlayerInfo.PlayerParams[k] = v
	end

	EventDispatcher.Dispatch(EventID.MazeUpdatePlayerParams)
end

function MazeDataModule.OnUpdateMazeData(sender, args)
	local command = args:ToLuaTable()

	MazeDataModule.LogicID = command.ID
	MazeDataModule.MazeLevelCID = command.MazeLevelID

	if HorizontalRPGModule.CheckHorizontalMazeInstance(MazeDataModule.MazeInstanceID) then
		MazeDataModule.MazeLevelResID = HorizontalRPGModule.GetMazeLevelResID(MazeDataModule.MazeInstanceID)
	else
		MazeDataModule.MazeLevelResID = command.MazeLevelResID
	end

	MazeDataModule.PlayerInfo = command.PlayerData
	MazeDataModule.WeatherCid = command.WeatherCid
	MazeDataModule.IsFirstTimeHere = command.First
	MazeDataModule.IsRestoreMaze = command.Restore
	MazeDataModule.StarConditions = {}

	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[MazeDataModule.MazeInstanceID]

	if mazeInfoPOD ~= nil then
		for i = 1, #mazeInfoPOD.starConditions do
			MazeDataModule.StarConditions[i] = mazeInfoPOD.starConditions[i] or MazeDataModule.PlayerInfo.StarConditions[i]
		end
	end

	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	MazeDataModule.ChapterType = cfgChapterData.Type

	local cfgMazeLevelData = CfgMazeLevelTable[MazeDataModule.MazeLevelCID]

	MazeDataModule.StreamingLoadType = cfgMazeLevelData.StreamingLoadType
	MazeDataModule.MapUILimitType = cfgMazeLevelData.MapUILimitType

	MazeDataModule.__InnerUpdateAreaNodes(command.MazeMapPathNodes, cfgMazeInstanceData.IsShowAnimation)
	MazeDataModule.__InnerUpdateDolls(command.PlayerData.DollDatas)
	MazeDataModule.__InnerUpdateItems(command.PlayerData.ItemDatas, true)
	MazeDataModule.__InnerUpdateElements(command.MazeElementData)
	MazeDataModule.RefreshClientEffectBuff()
	EventDispatcher.Dispatch(EventID.MazeUpdateData)
end

function MazeDataModule.__InnerUpdateAreaNodes(nodePODs, showFirstCameraAnimation)
	MazeDataModule.MazeMapPathNodes = {}

	local mazeMapData = {}
	local areaNodes = {}
	local areaNodeMap = {}

	MazeDataModule.MinNodeXIndex = 0
	MazeDataModule.MinNodeYIndex = 0
	MazeDataModule.MaxNodeXIndex = 0
	MazeDataModule.MaxNodeYIndex = 0

	for i = 1, #nodePODs do
		local nodePOD = nodePODs[i]

		MazeDataModule.MinNodeXIndex = math.min(MazeDataModule.MinNodeXIndex, nodePOD.XIndex)
		MazeDataModule.MinNodeYIndex = math.min(MazeDataModule.MinNodeYIndex, nodePOD.YIndex)
		MazeDataModule.MaxNodeXIndex = math.max(MazeDataModule.MaxNodeXIndex, nodePOD.XIndex)
		MazeDataModule.MaxNodeYIndex = math.max(MazeDataModule.MaxNodeYIndex, nodePOD.YIndex)
	end

	for i = 1, #nodePODs do
		local areaNodeData = AreaNodeData.New()
		local nodePOD = nodePODs[i]

		MazeDataModule.UpdateAreaNodeData(areaNodeData, nodePOD, true)

		local cfgMazePathNodeData = CfgMazePathNodeTable[areaNodeData.CID]

		if showFirstCameraAnimation and MazeDataModule.StreamingLoadType == Constant.Maze.StreamingTypeNone and cfgMazePathNodeData.Type == 2 then
			areaNodeData.IsActive = true
			areaNodeData.IsExit = true
		end

		areaNodes[areaNodeData.XIndex + 1] = areaNodes[areaNodeData.XIndex + 1] or {}
		areaNodes[areaNodeData.XIndex + 1][areaNodeData.YIndex + 1] = areaNodeData
		areaNodeMap[areaNodeData.NodeId] = areaNodeData

		if areaNodeData.IsActive then
			MazeDataModule.ActiveNodeMaxX = math.max(MazeDataModule.ActiveNodeMaxX, areaNodeData.x)
			MazeDataModule.ActiveNodeMaxY = math.max(MazeDataModule.ActiveNodeMaxY, areaNodeData.y)
		end

		MazeDataModule.AllNodeMinX = math.min(MazeDataModule.AllNodeMinX, areaNodeData.x)
		MazeDataModule.AllNodeMinY = math.min(MazeDataModule.AllNodeMinY, areaNodeData.y)
		MazeDataModule.AllNodeMaxX = math.max(MazeDataModule.AllNodeMaxX, areaNodeData.x)
		MazeDataModule.AllNodeMaxY = math.max(MazeDataModule.AllNodeMaxY, areaNodeData.y)

		table.insert(MazeDataModule.MazeMapPathNodes, areaNodeData)
	end

	mazeMapData.Nodes = areaNodes
	mazeMapData.NodeMap = areaNodeMap
	MazeDataModule.MazeMapData = mazeMapData

	for i = 1, #MazeDataModule.MazeMapPathNodes do
		local areaNodeData = MazeDataModule.MazeMapPathNodes[i]

		for j = 1, #areaNodeData.NextNodes do
			local nodeId = areaNodeData.NextNodes[j]

			if nodeId ~= 0 then
				local nextNodeData = MazeDataModule.MazeMapData.NodeMap[nodeId]

				table.insert(nextNodeData.ParentNodes, areaNodeData.NodeId)
			end
		end
	end
end

function MazeDataModule.UpdateAreaNodeData(areaNodeData, mazeMapPathNodePOD, isInit)
	areaNodeData.NodeId = mazeMapPathNodePOD.NodeID
	areaNodeData.CID = mazeMapPathNodePOD.CID
	areaNodeData.XIndex = mazeMapPathNodePOD.XIndex
	areaNodeData.YIndex = mazeMapPathNodePOD.YIndex

	if isInit then
		areaNodeData.x = mazeMapPathNodePOD.XIndex * MazeDataModule.AreaNodeDistanceX + MazeSceneApi:GetString("NodeLeftMarginX")
		areaNodeData.y = (MazeDataModule.MaxNodeYIndex - MazeDataModule.MinNodeYIndex - mazeMapPathNodePOD.YIndex) * MazeDataModule.AreaNodeDistanceY + MazeSceneApi:GetString("NodeBottomMarginY")
	end

	areaNodeData.NextNodes = mazeMapPathNodePOD.FollowNodeIDs
	areaNodeData.IsActive = mazeMapPathNodePOD.IsActive
	areaNodeData.ExploreWeight = mazeMapPathNodePOD.ExploreWeight
	areaNodeData.IsComplete = mazeMapPathNodePOD.IsComplete
	areaNodeData.EffectType = mazeMapPathNodePOD.EffectType
	areaNodeData.IsPastComplete = mazeMapPathNodePOD.IsPastComplete
	areaNodeData.AreaIx = mazeMapPathNodePOD.AreaIx
end

function MazeDataModule.GetNodeDataById(nodeId)
	local areaNodeData = MazeDataModule.MazeMapData.NodeMap[nodeId]

	if areaNodeData == nil then
		local heroNodeInfo = "nil"

		if MazeDataModule.LeaderElementPOD ~= nil then
			local heroNodeData = MazeDataModule.MazeMapData.NodeMap[MazeDataModule.LeaderElementPOD.NodeId]

			if heroNodeData ~= nil then
				heroNodeInfo = heroNodeData.CID .. " x " .. heroNodeData.XIndex .. "y" .. heroNodeData.YIndex
			end
		end

		logError("找不到节点数据。NodeId " .. tostring(nodeId) .. " MazeInstance.Id " .. tostring(MazeDataModule.MazeInstanceID) .. " Hero node info " .. heroNodeInfo)
	end

	return areaNodeData
end

function MazeDataModule.GetNodeDataByCfgId(cfgId)
	local retList = {}

	for i, v in pairs(MazeDataModule.MazeMapData.Nodes) do
		for i1, v1 in pairs(v) do
			if v1.CID == cfgId then
				table.insert(retList, v1)
			end
		end
	end

	return retList
end

function MazeDataModule.GetNodeDataByIndex(x, y)
	local column = MazeDataModule.MazeMapData.Nodes[x]

	if column == nil then
		return nil
	end

	return column[y]
end

function MazeDataModule.GetNodesAround(nodeId, radius)
	local result = {}

	if radius <= 0 then
		logError("半径不能小于1")

		return result
	end

	local centerNodeData = MazeDataModule.GetNodeDataById(nodeId)
	local startX = centerNodeData.XIndex + 1 - radius
	local endX = centerNodeData.XIndex + 1 + radius
	local startY = centerNodeData.YIndex + 1 - radius
	local endY = centerNodeData.YIndex + 1 + radius

	if startX < 0 then
		startX = 0
	end

	if startY < 0 then
		startY = 0
	end

	for x = startX, endX do
		for y = startY, endY do
			local column = MazeDataModule.MazeMapData.Nodes[x]

			if column ~= nil then
				local nodeData = column[y]

				if nodeData ~= nil and nodeData.NodeId ~= nodeId then
					table.insert(result, nodeData)
				end
			end
		end
	end

	return result
end

function MazeDataModule.OnUpdatePlayerInfo(sender, args)
	local command = args:ToLuaTable()

	for k, v in pairs(command.BasePOD) do
		local changeValue = v - MazeDataModule.PlayerInfo.BaseInfo[k]

		MazeDataModule.PlayerInfo.BaseInfo[k] = v

		EventDispatcher.Dispatch(EventID.MazePlayerSomeInfoChange, k, v, changeValue)
	end

	EventDispatcher.Dispatch(EventID.MazePlayerInfoChanged)
end

function MazeDataModule.OnUpdateDolls(sender, args)
	local command = args:ToLuaTable()
	local dolls = command.Dolls
	local changedDolls = {}
	local changedProps = {}

	for i = 1, #dolls do
		local newDollPOD = dolls[i]
		local oldDollPOD
		local changedProp = MazeUpdateDollEventData.New(newDollPOD.id)

		changedProps[newDollPOD.id] = changedProp

		for j = 1, #MazeDataModule.DollDataList do
			if MazeDataModule.DollDataList[j].id == newDollPOD.id then
				oldDollPOD = MazeDataModule.DollDataList[j]

				for filedName, fieldValue in pairs(newDollPOD) do
					local oldValue = oldDollPOD[filedName]
					local newValue = fieldValue

					if isBasicType(fieldValue) and newValue ~= oldValue then
						changedProp[filedName] = newValue - oldValue
					end

					oldDollPOD[filedName] = newValue
				end

				table.insert(changedDolls, oldDollPOD)

				break
			end
		end

		if oldDollPOD == nil then
			table.insert(MazeDataModule.DollDataList, newDollPOD)
			table.insert(changedDolls, newDollPOD)
		end
	end

	table.sort(MazeDataModule.DollDataList, function(mazeDollPOD1, mazeDollPOD2)
		return mazeDollPOD1.formationPos < mazeDollPOD2.formationPos
	end)

	for i = 1, #changedDolls do
		local dollPOD = changedDolls[i]
		local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
		local soulCustomPOD = MazeDataModule.DollPODToSoulPOD(dollPOD)

		if soulData ~= nil then
			soulData:Initialize(dollPOD.soulCid, soulCustomPOD)
		else
			soulData = SoulModule.CreateCustomSoulData(dollPOD.soulCid, soulCustomPOD)
		end

		MazeDataModule.__SoulDataMap[soulData.soulCid] = soulData
		MazeDataModule.__SoulItemDataEquips[soulData.soulCid] = MazeDataModule.__EquipPODMapToItemDataMap(dollPOD.equipments)
	end

	EventDispatcher.Dispatch(EventID.MazeUpdateDoll, changedProps)
end

function MazeDataModule.__InnerUpdateDolls(dolls)
	table.sort(dolls, function(mazeDollPOD1, mazeDollPOD2)
		return mazeDollPOD1.formationPos < mazeDollPOD2.formationPos
	end)

	MazeDataModule.DollDataList = dolls
	MazeDataModule.__SoulDataMap = {}
	MazeDataModule.__SoulItemDataEquips = {}

	for i = 1, #MazeDataModule.DollDataList do
		local dollPOD = MazeDataModule.DollDataList[i]
		local soulCustomPOD = MazeDataModule.DollPODToSoulPOD(dollPOD)
		local soulData = SoulModule.CreateCustomSoulData(dollPOD.soulCid, soulCustomPOD)

		MazeDataModule.__SoulDataMap[soulData.soulCid] = soulData
		MazeDataModule.__SoulItemDataEquips[soulData.soulCid] = MazeDataModule.__EquipPODMapToItemDataMap(dollPOD.equipments)
	end
end

function MazeDataModule.GetActiveDollDataList()
	MazeDataModule.TempActiveDollDataList = MazeDataModule.TempActiveDollDataList or {}

	for i = 1, #MazeDataModule.TempActiveDollDataList do
		MazeDataModule.TempActiveDollDataList[i] = nil
	end

	for i = 1, #MazeDataModule.DollDataList do
		local dollData = MazeDataModule.DollDataList[i]

		if dollData.formationPos ~= 0 then
			table.insert(MazeDataModule.TempActiveDollDataList, dollData)
		end
	end

	return MazeDataModule.TempActiveDollDataList
end

function MazeDataModule.__EquipPODMapToItemDataMap(equipPODMap)
	local itemDataMap = {}

	for index, mazeEquipPOD in pairs(equipPODMap) do
		itemDataMap[index] = ItemData.CreateFromMazeEquipPOD(mazeEquipPOD)
	end

	return itemDataMap
end

function MazeDataModule.DollPODToSoulPOD(dollPOD)
	local soulPOD = {
		cid = dollPOD.soulCid,
		lv = dollPOD.lv,
		exp = dollPOD.exp,
		dress2DCid = dollPOD.dress2DCid,
		dress3DCid = dollPOD.dress3DCid,
		qualityId = dollPOD.soulQualityCid,
		activationSkillStrengthen = dollPOD.skillStrengthens,
		talentCids = dollPOD.talentCids,
		soulMemoryPieces = dollPOD.soulMemoryPieces,
		mood = dollPOD.mood,
		talentGroupCids = dollPOD.talentGroupCids,
		unlockSkillGroups = dollPOD.unlockSkillGroups,
		soulAttr = dollPOD.finalAttributes
	}

	return soulPOD
end

function MazeDataModule.OnUpdateCompleteEvents(sender, args)
	local command = args:ToLuaTable()

	table.insert(MazeDataModule.PlayerInfo.CompleteEvents, command.EventId)
end

function MazeDataModule.OnUpdateItems(sender, args)
	local command = args:ToLuaTable()
	local items = command.Items

	MazeDataModule.__InnerUpdateItems(items, false)
	EventDispatcher.Dispatch(EventID.MazeUpdateItem)
end

function MazeDataModule.__InnerUpdateItems(csMazeItemDatas, isInit)
	local items = {}
	local itemData

	for i = 1, #csMazeItemDatas do
		itemData = ItemData:CreateFromMazeItemData(csMazeItemDatas[i])

		table.insert(items, itemData)
	end

	local itemInWarehouse, indexInWarehouse, itemFromServer
	local addItems = {}
	local deleteItems = {}
	local updateItems = {}

	for i = 1, #items do
		itemFromServer = items[i]
		itemInWarehouse, indexInWarehouse = MazeDataModule.FindItemByInstanceID(itemFromServer.id)

		if itemInWarehouse == nil then
			itemInWarehouse = itemFromServer

			table.insert(addItems, itemInWarehouse)
		elseif itemFromServer.num == nil or itemFromServer.num == 0 then
			table.insert(deleteItems, itemInWarehouse)
		else
			itemInWarehouse = itemFromServer
			MazeDataModule.Items[indexInWarehouse] = itemInWarehouse
		end

		table.insert(updateItems, itemInWarehouse)
	end

	for i = 1, #deleteItems do
		for j = #MazeDataModule.Items, 1, -1 do
			if MazeDataModule.Items[j].id == deleteItems[i].id then
				table.remove(MazeDataModule.Items, j)
			end
		end
	end

	for i = 1, #addItems do
		table.insert(MazeDataModule.Items, addItems[i])
	end

	if #addItems > 0 and not isInit then
		EventDispatcher.Dispatch(EventID.AddItem, addItems)
	end

	if #deleteItems > 0 then
		-- block empty
	end

	if #updateItems > 0 then
		-- block empty
	end
end

function MazeDataModule.GetAllItems(tabType)
	local result = {}
	local itemData = 0
	local cfgItemData

	for i = 1, #MazeDataModule.Items do
		cfgItemData = MazeDataModule.Items[i]:GetCfg()

		if tabType == 0 or cfgItemData.Tabs == tabType then
			itemData = MazeDataModule.Items[i]

			table.insert(result, itemData)
		end
	end

	return result
end

function MazeDataModule.FindItemByInstanceID(instanceID)
	local items = MazeDataModule.Items

	for i = 1, #items do
		if items[i].id == instanceID then
			return items[i], i
		end
	end

	return nil, 0
end

function MazeDataModule.GetItemNumByCfgID(cfgID)
	if MazeDataModule.PlayerInfo.NumAttrs[cfgID] ~= nil then
		return MazeDataModule.PlayerInfo.NumAttrs[cfgID]
	end

	local num = 0

	for i = 1, #MazeDataModule.Items do
		if MazeDataModule.Items[i].cid == cfgID then
			num = num + MazeDataModule.Items[i].num
		end
	end

	return num
end

function MazeDataModule.GetItemDataByCid(cid)
	for i = 1, #MazeDataModule.Items do
		local itemData = MazeDataModule.Items[i]

		if itemData.cid == cid then
			return itemData
		end
	end

	return nil
end

function MazeDataModule.GetEquipListByPosition(position)
	local equips = {}
	local equipOnDollNum = 0

	for soulCid, dollEquips in pairs(MazeDataModule.__SoulItemDataEquips) do
		for index, itemData in pairs(dollEquips) do
			local cfgItemData = itemData:GetCfg()

			if cfgItemData.Type == Constant.ItemType.Equip and cfgItemData.Position == position then
				table.insert(equips, itemData)

				equipOnDollNum = equipOnDollNum + 1
			end
		end
	end

	for i = 1, #MazeDataModule.Items do
		local itemData = MazeDataModule.Items[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.Type == Constant.ItemType.Equip and cfgItemData.Position == position then
			table.insert(equips, itemData)
		end
	end

	return equips, equipOnDollNum
end

function MazeDataModule.GetWearingEquipMap(soulCid)
	local index = -1

	for i = 1, #MazeDataModule.DollDataList do
		local dollData = MazeDataModule.DollDataList[i]

		if dollData.soulCid == soulCid then
			index = i

			break
		end
	end

	if index == -1 then
		return {}
	end

	return MazeDataModule.__SoulItemDataEquips[soulCid]
end

function MazeDataModule.GetWoreEquipSoulCid(woreEquipID)
	for i, v in pairs(MazeDataModule.__SoulItemDataEquips) do
		for m, n in pairs(v) do
			if n.id == woreEquipID then
				return i
			end
		end
	end

	return nil
end

function MazeDataModule.CheckEquipIsOnDoll(itemData, exceptiveDollId)
	for i = 1, #MazeDataModule.DollDataList do
		local dollPOD = MazeDataModule.DollDataList[i]

		if exceptiveDollId == nil or dollPOD.id ~= exceptiveDollId then
			for index, mazeItemPOD in pairs(dollPOD.equipments) do
				if mazeItemPOD.ID == itemData.id then
					return true, dollPOD.id
				end
			end
		end
	end

	return false, nil
end

function MazeDataModule.__InnerUpdateElements(elementDatas)
	MazeDataModule.ElementPODs = {}
	MazeDataModule.ElementPODGrid = {}

	for i = 1, #elementDatas do
		local elementPOD = MazeElementPOD.New(elementDatas[i])

		MazeDataModule.AddElementPOD(elementPOD)

		if elementPOD.Pid == MazeDataModule.PlayerInfo.BaseInfo.pid then
			MazeDataModule.LeaderElementPOD = elementPOD
		end
	end
end

function MazeDataModule.AddElementPOD(elementPOD)
	table.insert(MazeDataModule.ElementPODs, elementPOD)

	local areaNodeData = MazeDataModule.GetNodeDataById(elementPOD.NodeId)
	local column = MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1]

	if column == nil then
		column = {}
		MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1] = column
	end

	local elementPODs = column[areaNodeData.YIndex + 1]

	if elementPODs == nil then
		elementPODs = {}
		column[areaNodeData.YIndex + 1] = elementPODs
	end

	table.insert(elementPODs, elementPOD)
end

function MazeDataModule.MoveElementPOD(elementId, elementCid, fromNodeId, toNodeId)
	local areaNodeData = MazeDataModule.GetNodeDataById(fromNodeId)
	local column = MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1]

	if column == nil then
		logError("移动元素数据失败，元素原节点上无任何元素数据。元素CID " .. elementCid)

		return
	end

	local elementPODs = column[areaNodeData.YIndex + 1]

	if elementPODs == nil then
		logError("移动元素数据失败，元素原节点上无任何元素数据。元素CID " .. elementCid)

		return
	end

	local targetElementPOD

	for i = 1, #elementPODs do
		local elementPOD = elementPODs[i]

		if elementPOD.ID == elementId then
			targetElementPOD = elementPOD

			table.remove(elementPODs, i)

			break
		end
	end

	if targetElementPOD == nil then
		logError("移动元素数据失败，元素原节点上找不到该元素。元素CID " .. elementCid)

		return
	end

	areaNodeData = MazeDataModule.GetNodeDataById(toNodeId)
	column = MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1]

	if column == nil then
		column = {}
		MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1] = column
	end

	elementPODs = column[areaNodeData.YIndex + 1]

	if elementPODs == nil then
		elementPODs = {}
		column[areaNodeData.YIndex + 1] = elementPODs
	end

	table.insert(elementPODs, targetElementPOD)
	EventDispatcher.Dispatch(EventID.MazeElementNodeChange, elementId, fromNodeId, toNodeId)
end

function MazeDataModule.GetElementPOD(elementId)
	for i = 1, #MazeDataModule.ElementPODs do
		local elementPOD = MazeDataModule.ElementPODs[i]

		if elementPOD.ID == elementId then
			return elementPOD
		end
	end

	return nil
end

function MazeDataModule.GetElementPODsByNode(nodeId)
	local areaNodeData = MazeDataModule.GetNodeDataById(nodeId)
	local column = MazeDataModule.ElementPODGrid[areaNodeData.XIndex + 1]

	if column == nil then
		return nil
	end

	local elementPODs = column[areaNodeData.YIndex + 1]

	return elementPODs
end

function MazeDataModule.AddBuff(buffPOD, dollID)
	if dollID == 0 then
		table.insert(MazeDataModule.PlayerInfo.Buffs, buffPOD)
		MazeDataModule.RefreshClientEffectBuff()
	else
		for i = 1, #MazeDataModule.DollDataList do
			local dollPOD = MazeDataModule.DollDataList[i]

			if dollPOD.id == dollID then
				table.insert(dollPOD.buffs, buffPOD)

				break
			end
		end
	end

	EventDispatcher.Dispatch(EventID.MazeBuffAdded, dollID, buffPOD.CID)
end

function MazeDataModule.UpdateBuff(buffPOD, dollID)
	local oldTriggerCount = 0

	if dollID == 0 then
		local playerBuffs = MazeDataModule.PlayerInfo.Buffs

		for i = 1, #playerBuffs do
			local oldBuffPOD = playerBuffs[i]

			if oldBuffPOD.CID == buffPOD.CID then
				oldTriggerCount = oldBuffPOD.TriggerCount
				playerBuffs[i] = buffPOD

				break
			end
		end

		MazeDataModule.RefreshClientEffectBuff()
	else
		for i = 1, #MazeDataModule.DollDataList do
			local dollPOD = MazeDataModule.DollDataList[i]

			if dollPOD.id == dollID then
				for j = 1, #dollPOD.buffs do
					local oldBuffPOD = dollPOD.buffs[j]

					if oldBuffPOD.CID == buffPOD.CID then
						oldTriggerCount = oldBuffPOD.TriggerCount
						dollPOD.buffs[j] = buffPOD

						break
					end
				end

				break
			end
		end
	end

	EventDispatcher.Dispatch(EventID.MazeBuffTriggerCount, dollID, buffPOD.CID, oldTriggerCount, buffPOD.TriggerCount)
end

function MazeDataModule.DeleteBuff(buffPOD, dollID)
	if dollID == 0 then
		local playerBuffs = MazeDataModule.PlayerInfo.Buffs

		for i = 1, #playerBuffs do
			if playerBuffs[i].CID == buffPOD.CID then
				table.remove(playerBuffs, i)

				break
			end
		end

		MazeDataModule.RefreshClientEffectBuff()
	else
		for i = 1, #MazeDataModule.DollDataList do
			local dollPOD = MazeDataModule.DollDataList[i]

			if dollPOD.id == dollID then
				for j = 1, #dollPOD.buffs do
					if dollPOD.buffs[j].CID == buffPOD.CID then
						table.remove(dollPOD.buffs, j)

						break
					end
				end

				break
			end
		end
	end

	EventDispatcher.Dispatch(EventID.MazeBuffRemoved, dollID, buffPOD.CID)
end

function MazeDataModule.RefreshClientEffectBuff()
	local changeStateValue = 0

	for i = 1, #MazeDataModule.PlayerInfo.Buffs do
		local buffPOD = MazeDataModule.PlayerInfo.Buffs[i]
		local cfgBuffData = CfgBuffTable[buffPOD.CID]

		for j = 1, #cfgBuffData.EffectType do
			if cfgBuffData.EffectType[j] == 259 and tonumber(cfgBuffData.EffectParam[j][1]) == 8 then
				changeStateValue = changeStateValue + tonumber(cfgBuffData.EffectParam[j][2]) / 100
			end
		end
	end

	changeStateValue = math.max(-50, changeStateValue)
	changeStateValue = math.min(100, changeStateValue)
	MazeDataModule.ChangeStateElementRatio = 1 + changeStateValue / 100
end

function MazeDataModule.GetDollPODByID(dollId)
	for i = 1, #MazeDataModule.DollDataList do
		if MazeDataModule.DollDataList[i].id == dollId then
			return MazeDataModule.DollDataList[i]
		end
	end
end

function MazeDataModule.GetSoulData(soulCid)
	return MazeDataModule.__SoulDataMap[soulCid]
end

function MazeDataModule.GetNumAttrValue(itemCid)
	local value = MazeDataModule.PlayerInfo.NumAttrs[itemCid]

	if value == nil then
		value = 0
	end

	return value
end

function MazeDataModule.GetFirstAliveDoll()
	local aliveDollData
	local dollDataList = MazeDataModule.GetActiveDollDataList()

	for i = 1, #dollDataList do
		local dollData = dollDataList[i]

		if dollData.finalAttributes[Constant.Attribute.TYPE_HP] > 0 then
			aliveDollData = dollData

			break
		end
	end

	return aliveDollData
end

function MazeDataModule.GetSoulAvatarData()
	local aliveDollData = MazeDataModule.GetFirstAliveDoll()

	if aliveDollData == nil then
		return nil
	end

	local soulAvatarData = SoulAvatarData.New()

	if MazeDataModule.PlayerInfo.TempHeroSoulCid ~= 0 then
		local cfgSoulAvatarData = CfgSoulAvatarTable[MazeDataModule.PlayerInfo.TempHeroSoulCid]

		soulAvatarData:Update(cfgSoulAvatarData)
	else
		local cfgDressData3D = CfgDressTable[aliveDollData.dress3DCid]
		local cfgSoulResData3D = CfgSoulResTable[cfgDressData3D.SoulResID]

		soulAvatarData.entityCid = cfgSoulResData3D.EntityId

		local cfgDressData2D = CfgDressTable[aliveDollData.dress2DCid]
		local cfgSoulResData2D = CfgSoulResTable[cfgDressData2D.SoulResID]

		soulAvatarData.headIcon = cfgSoulResData2D.HeadIcon
		soulAvatarData.headIcon02 = cfgSoulResData2D.HeadIcon02
	end

	return soulAvatarData
end

function MazeDataModule.GetLeftTime()
	if MazeDataModule.StartTime == nil then
		return 0
	end

	local cfgDiscreteDataData = CfgDiscreteDataTable[6510001]
	local sec = cfgDiscreteDataData.Data[1] * 60 - (UnityEngine.Time.realtimeSinceStartup - MazeDataModule.StartTime) + MazeDataModule.PlayerInfo.ExamDurationChange

	if sec < 0 then
		sec = 0
	end

	return sec
end

function MazeDataModule.CheckCanUse(id)
	local csItemData = MazeDataModule.FindItemByInstanceID(id)

	if csItemData == nil then
		return false, ""
	end

	local cfgItemData = csItemData:GetCfg()
	local isOk, errorMsg = ConditionModule.Check(cfgItemData.UseConditionID)

	if not isOk then
		local cfgConditionData = CfgConditionTable[cfgItemData.UseConditionID]

		errorMsg = WarehouseUIApi:GetString("UseItemCheckConditionFailText", cfgConditionData.Name)
	end

	return isOk, errorMsg
end

function MazeDataModule.GetCurrentElement()
	local elementPODs = MazeDataModule.GetElementPODsByNode(MazeDataModule.LeaderElementPOD.NodeId)

	if elementPODs ~= nil then
		for i = 1, #elementPODs do
			local elementPOD = elementPODs[i]

			if elementPOD.ID ~= MazeDataModule.LeaderElementPOD.ID and not elementPOD.IsRemoved then
				return elementPOD
			end
		end
	end

	return nil
end

function MazeDataModule.IsScrollMaze()
	return MazeDataModule.ChapterType == Constant.Maze.ChapterTypeScroll or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeLunaSysTeamScroll
end

function MazeDataModule.HasUnlockRuneItem()
	local hasRuneItem = false
	local items = MazeDataModule.GetAllItems(0)

	for i = 1, #items do
		local itemData = items[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.Type == Constant.ItemType.Item and cfgItemData.SubType == Constant.ItemSubType.ItemUnlockRune then
			hasRuneItem = true

			break
		end
	end

	return hasRuneItem
end

function MazeDataModule.IsShowOnLayer(elementNodeData)
	if not MazeDataModule.IsEndlessPlusLikeMaze() then
		return true
	end

	local heroNodeData = MazeDataModule.GetNodeDataById(MazeDataModule.LeaderElementPOD.NodeId)

	return elementNodeData.XIndex >= heroNodeData.XIndex
end

function MazeDataModule.IsEndlessPlusLikeMaze()
	return MazeDataModule.ChapterType == Constant.Maze.ChapterTypeEndlessPlus
end

function MazeDataModule.Clear()
	MazeDataModule.PlayerInfo = nil
	MazeDataModule.DollDataList = nil
	MazeDataModule.TempActiveDollDataList = nil
	MazeDataModule.__SoulDataMap = nil
	MazeDataModule.__SoulItemDataEquips = nil
	MazeDataModule.Items = {}
	MazeDataModule.LogicID = 0
	MazeDataModule.MazeInstanceID = 0
	MazeDataModule.MazeLevelCID = 0
	MazeDataModule.MazeMapPathNodes = nil
	MazeDataModule.CacheShowDropItems = nil
	MazeDataModule.SettlementData = nil
	MazeDataModule.MazeMapData = nil
	MazeDataModule.ActiveNodeMaxX = 0
	MazeDataModule.ActiveNodeMaxY = 0
	MazeDataModule.AllNodeMinX = 2147483647
	MazeDataModule.AllNodeMinY = 2147483647
	MazeDataModule.AllNodeMaxX = 0
	MazeDataModule.AllNodeMaxY = 0
	MazeDataModule.MinNodeXIndex = 0
	MazeDataModule.MaxNodeXIndex = 0
	MazeDataModule.MinNodeYIndex = 0
	MazeDataModule.MaxNodeYIndex = 0
	MazeDataModule.ElementPODs = nil
	MazeDataModule.ElementPODGrid = nil
	MazeDataModule.LeaderElementPOD = nil
	MazeDataModule.CurrDialog = 0
	MazeDataModule.SoulLvExpListBeforeQuit = nil
	MazeDataModule.StarConditions = nil
	MazeDataModule.StartTime = nil
	MazeDataModule.ChangeStateElementRatio = 0
	MazeDataModule.ChapterType = 0
	MazeDataModule.StreamingLoadType = 0
	MazeDataModule.MapUILimitType = 0
end
