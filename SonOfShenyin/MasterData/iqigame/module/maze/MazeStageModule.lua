-- chunkname: @IQIGame\\Module\\Maze\\MazeStageModule.lua

MazeStageModule = {}

local json = require("Util.json")
local this = MazeStageModule

function this.ShutDown()
	EventDispatcher.RemoveEventListener(EventID.OnStoryLoadOverEvent, this._OnStoryLoadOver)

	this.isExitMazePrepare = false
end

function this.StartMazeLevel(mazeStagePOD, storySaveData)
	this.MazeStagePod = mazeStagePOD

	local plotStageDupPOD = {}

	plotStageDupPOD.stageId = this.MazeStagePod.mazeId
	plotStageDupPOD.complete = false
	plotStageDupPOD.storySaveData = storySaveData
	StoryModule.plotStageDupPOD = plotStageDupPOD

	local cfgMazeStage = CfgUtil.GetCfgMazeStageDataWithID(this.MazeStagePod.mazeId)
	local cfgMazeRoom = CfgUtil.GetCfgMazeRoomDataWithID(cfgMazeStage.FirstRoomID)
	local isPlayerShowOnAwake = true
	local storyDataID = plotStageDupPOD.storySaveData.currentSceneID ~= 0 and plotStageDupPOD.storySaveData.currentSceneID or cfgMazeRoom.StoryID
	local playerName = PlayerModule.PlayerInfo.baseInfo.pName
	local playerEntityID = StoryModule.GetPlayerEntityID()
	local storyDataConfig = CfgUtil.GetCfgStoryDataWithID(storyDataID)

	if not storyDataConfig then
		return
	end

	local playerPosition = plotStageDupPOD.storySaveData.position and plotStageDupPOD.storySaveData.position or Vector3.New(storyDataConfig.PlayerInitPosition[1], storyDataConfig.PlayerInitPosition[2], storyDataConfig.PlayerInitPosition[3])
	local npcVariables = plotStageDupPOD.storySaveData.npcVariables
	local storyParam = {}

	storyParam.StoryDataID = storyDataID
	storyParam.IsPlayerShowOnAwake = isPlayerShowOnAwake
	storyParam.PlayerName = playerName
	storyParam.PlayerEntityID = playerEntityID
	storyParam.PlayerPosition = playerPosition
	storyParam.NpcVariables = npcVariables
	storyParam.StoryType = Constant.StoryType.Maze

	EventDispatcher.AddEventListener(EventID.OnStoryLoadOverEvent, this._OnStoryLoadOver)
	SceneTransferModule.MainCityToStory(storyParam)
end

function this._OnStoryLoadOver()
	local room = StoryModule.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeRoomID)

	if LuaUtility.StrIsNullOrEmpty(room) then
		local cfgMazeStage = CfgUtil.GetCfgMazeStageDataWithID(this.MazeStagePod.mazeId)
		local cfgMazeRoom = CfgUtil.GetCfgMazeRoomDataWithID(cfgMazeStage.FirstRoomID)

		this.SetCurrentRoomID(cfgMazeRoom.Id)
		this.RandomRoomData(this.currentMazeRoom)
	else
		this.currentMazeRoom = tonumber(StoryModule.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeRoomID))
	end

	EventDispatcher.RemoveEventListener(EventID.OnStoryLoadOverEvent, this._OnStoryLoadOver)
	StoryModule.Save(false)
	EventDispatcher.Dispatch(EventID.MazeStageGoNextRoomEvent)
end

function this.DebugFakeData(firstID)
	this.MazeStagePod = {}
	this.MazeStagePod.mazeId = firstID
	this.currentMazeRoom = firstID
end

function this.GetCurrentRoomID()
	return this.currentMazeRoom
end

function this.GetMazeStageID()
	if not this.MazeStagePod then
		return nil
	end

	return this.MazeStagePod.mazeId
end

function this.GetMazeStagePOD()
	return this.MazeStagePod
end

function this.AddMazeMeetFightCount()
	local jsStr = StoryModule.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeInfo)
	local roomInfo = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		roomInfo = json.decode(jsStr)
	end

	if not roomInfo.meetFightCount then
		roomInfo.meetFightCount = 0
	end

	roomInfo.meetFightCount = roomInfo.meetFightCount + 1
	jsStr = json.encode(roomInfo)

	StoryModule.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeInfo, Constant.StoryVariableType.String, jsStr)
end

function this.GetMazeMeetFightCount()
	local jsStr = StoryModule.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeInfo)
	local roomInfo = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		roomInfo = json.decode(jsStr)
	end

	if not roomInfo then
		return 0
	end

	if not roomInfo.meetFightCount then
		return 0
	end

	return roomInfo.meetFightCount
end

function this.SetCurrentRoomID(id)
	this.currentMazeRoom = id

	if StoryModule.plotStageDupPOD then
		StoryModule.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeRoomID, Constant.StoryVariableType.Int, id)

		local str = StoryModule.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeArrivedRoom)
		local data = {}

		if not LuaUtility.StrIsNullOrEmpty(str) then
			data = json.decode(str)
		end

		data[tostring(id)] = true

		local jsStr = json.encode(data)

		StoryModule.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeArrivedRoom, Constant.StoryVariableType.String, jsStr)
	end
end

function this.GetRoomIsArrived(roomID)
	local data = this.GetRoomArrivedData()

	return data[tostring(roomID)]
end

function this.GetRoomArrivedData()
	local str = StoryModule.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMazeArrivedRoom)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(str) then
		data = json.decode(str)
	end

	return data
end

function this.GetRoomVariableData(roomID)
	local vName = Constant.StoryMazeEvent .. roomID
	local str = StoryModule.GetPODVariable(Constant.StoryMazeNpcID, vName)

	if LuaUtility.StrIsNullOrEmpty(str) then
		return
	end

	return json.decode(str)
end

function this.RandomRoomData(roomID)
	local vName = Constant.StoryMazeEvent .. roomID

	if not LuaUtility.StrIsNullOrEmpty(StoryModule.GetPODVariable(Constant.StoryMazeNpcID, vName)) then
		return
	end

	local cfgRoom = CfgUtil.GetCfgMazeRoomDataWithID(roomID)

	if not cfgRoom then
		return
	end

	local len = #cfgRoom.Event

	if len <= 0 then
		return
	end

	local tb = {}

	tb.param = {}

	for i = 1, len do
		local cfgEvent = CfgUtil.GetCfgMazeEventDataWithID(cfgRoom.Event[i])

		if #cfgEvent.Params <= 0 then
			return
		end

		local param = this.RandomEvent(cfgEvent)

		tb.param[i] = param
	end

	local js = json.encode(tb)

	StoryModule.SetPODVariable(Constant.StoryMazeNpcID, vName, Constant.StoryVariableType.String, js)
end

function this.RandomEvent(cfgEvent)
	local num = math.random(1, 100)
	local param = 0
	local temp = 0
	local len = #cfgEvent.Weight

	for i = 1, len do
		temp = temp + cfgEvent.Weight[i]

		if num < temp then
			param = cfgEvent.Params[i]

			break
		end
	end

	if param == 0 then
		logError(string.format("【迷宫】迷宫房间事件随机错误 ID = %s,请检查配置", cfgEvent.Id))
	end

	return param
end

function this.MazeGoNextRoom(LinkIndex, teleportPos, MazeGoNextRoomTask)
	local cfgMazeRoom = CfgUtil.GetCfgMazeRoomDataWithID(this.currentMazeRoom)
	local nextRoomId = cfgMazeRoom.LinkRooms[LinkIndex]

	if not nextRoomId then
		logError(string.format("迷宫进入房间失败，房间索引 = %s,当前房间ID = %s", LinkIndex, cfgMazeRoom.Id))

		return
	end

	local cfgNextRoom = CfgUtil.GetCfgMazeRoomDataWithID(nextRoomId)

	BehaviorTreeUtility.SwitchScene(cfgNextRoom.StoryID, teleportPos, MazeGoNextRoomTask, function()
		this.SetCurrentRoomID(nextRoomId)
		this.RandomRoomData(nextRoomId)
		EventDispatcher.Dispatch(EventID.MazeStageGoNextRoomEvent)
		StoryModule.Save(false)
	end)
end

function this.CheckMazeHeroAllDead()
	for _, v in pairs(this.MazeStagePod.heros) do
		if v.attr[Constant.Attribute.TYPE_HP] > 0 then
			return false
		end
	end

	return true
end

function this.EnterMazeDup(mazeDupId, formationId)
	net_mazeDup.enterMazeDup(mazeDupId, formationId)
end

function this.EnterMazeDupResult(mazeStagePOD, storySaveData)
	this.StartMazeLevel(mazeStagePOD, storySaveData)
end

function this.notifyMazeDup(mazeStagePOD)
	this.MazeStagePod = mazeStagePOD

	EventDispatcher.Dispatch(EventID.MazeStagePanelRefreshEvent)
end

function this.NotifyFinishMazeDup(completePOD)
	local userData = {}

	userData.fightOverPOD = completePOD

	function userData.closeCallBack()
		EventDispatcher.Dispatch(EventID.CompleteStoryLevel, completePOD)
		EventDispatcher.RemoveEventListener(EventID.CompleteStoryLevel, StoryModule.OnCompleteLevel)
	end

	UIModule.Open(Constant.UIControllerName.Settlement_ActionUI, Constant.UILayer.UI, userData)

	MazeModule.InTheMaze = false
end
