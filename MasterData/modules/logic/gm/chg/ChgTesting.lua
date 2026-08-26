-- chunkname: @modules/logic/gm/chg/ChgTesting.lua

module("modules.logic.gm.chg.ChgTesting", package.seeall)

local RD = require("modules.logic.gm.gaosiniao.reverse_define")

ChgEnum.rDir = RD(ChgEnum, "Dir")
ChgEnum.rPuzzleMazeObjType = RD(ChgEnum, "PuzzleMazeObjType")
ChgEnum.rPuzzleMazeEffectType = RD(ChgEnum, "PuzzleMazeEffectType")
ChgEnum.rPuzzleMazeObjSubType = RD(ChgEnum, "PuzzleMazeObjSubType")

local kGreen = "#00FF00"
local kYellow = "#FFFF00"
local kRed = "#FF0000"
local kBlue = "#0000FF"
local kBlack = "#000000"
local kWhite = "#FFFFFF"

local function _setColorDesc(desc, hexColor)
	if desc ~= nil and type(desc) ~= "string" then
		desc = tostring(desc)
	end

	if string.nilorempty(desc) then
		desc = "[None]"
	end

	return gohelper.getRichColorText(desc, hexColor or kWhite)
end

local function _unitTest_now()
	return "{\"energy\":100,\"roundList\":[{\"width\":6,\"height\":3,\"objMap\":[{\"key\":\"2_4\",\"type\":1,\"subType\":1,\"group\":0,\"priority\":0,\"effects\":[{\"type\":3,\"param\":\"30211\"}],\"interactLines\":[],\"iconUrl\":\"\",\"hp\":0},{\"key\":\"5_3\",\"type\":2,\"subType\":1,\"group\":0,\"priority\":0,\"effects\":[],\"interactLines\":[],\"iconUrl\":\"\",\"hp\":0},{\"key\":\"3_3\",\"type\":4,\"subType\":1,\"group\":101,\"priority\":0,\"effects\":[],\"interactLines\":[],\"iconUrl\":\"yj_01\",\"hp\":0},{\"key\":\"3_2\",\"type\":4,\"subType\":1,\"group\":101,\"priority\":0,\"effects\":[],\"interactLines\":[],\"iconUrl\":\"yj_01\",\"hp\":0},{\"key\":\"2_2\",\"type\":4,\"subType\":1,\"group\":101,\"priority\":0,\"effects\":[],\"interactLines\":[],\"iconUrl\":\"yj_01\",\"hp\":0}],\"blockMap\":[],\"pawnIconUrl\":\"\",\"addEnergyBeginRound\":0}],\"v3a4_spriteName\":\"\"}\n"
end

local function _unitTest8x5_1()
	local CO = lua_chapter_map_element.configDict[34701012]

	return (CO or nil) and (CO.param or _unitTest_now())
end

local function _unitTest()
	return _unitTest8x5_1()
end

local TestingBase = _G.class("TestingBase")
local KTaskType = TaskEnum.TaskType.Activity210

function TestingBase:ctor()
	self._pb = DungeonModule_pb
	self._cCfg = ChgConfig
	self._cTaskCfg = TaskConfig
	self._pbTask = TaskModule_pb
end

function TestingBase:build_test()
	return
end

function TestingBase:link(obj)
	self._obj = obj
end

function TestingBase:actId()
	return self._cCfg.instance:actId()
end

function TestingBase:getEpisodeCO(episodeId)
	local cfgObj = self._cCfg.instance

	if not episodeId or episodeId == 0 then
		return
	end

	return (cfgObj:getEpisodeCO(episodeId))
end

local kErrMsgServer = "myserver error"
local STesting = _G.class("STesting", TestingBase)

function STesting:ctor()
	TestingBase.ctor(self)

	self._actId2InfoDict = {}
	self._taskInfoDict = {}
	self._taskActivityInfoDict = {}
end

local kTest_CompleteCount = 6
local kBase_EpisodeId = 1311800

function STesting:_make_Act210Info(activityId)
	assert(activityId, kErrMsgServer)

	local act210EpisodeCOs = assert(lua_activity210_episode.configDict[activityId], kErrMsgServer .. activityId)
	local episodeId2Act210EpisodeRecord = {}

	for i, v in pairs(act210EpisodeCOs) do
		local episodeId = v.episodeId

		episodeId2Act210EpisodeRecord[episodeId] = self:_make_Act210EpisodeRecord(episodeId)
	end

	episodeId2Act210EpisodeRecord[0] = self:_make_Act210EpisodeRecord(0)

	local res = {
		activityId = activityId,
		episodeId2Act210EpisodeRecord = episodeId2Act210EpisodeRecord
	}

	for i = 1, kTest_CompleteCount do
		local episodeId = kBase_EpisodeId + i

		episodeId2Act210EpisodeRecord[episodeId].isFinished = true
	end

	return res
end

function STesting:handleGetAct210Info(req, reply)
	local activityId = req.activityId
	local info = self:_getInfo(activityId)

	if not info then
		info = self:_make_Act210Info(activityId)
		self._actId2InfoDict[activityId] = info
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodes", self:_getEpisodeList(activityId))
end

function STesting:handleAct210FinishEpisode(req, reply)
	local activityId = req.activityId
	local episodeId = req.episodeId
	local progress = req.progress
	local info = assert(self:_getInfo(activityId), kErrMsgServer)
	local act210EpisodeRecord = assert(info.episodeId2Act210EpisodeRecord[episodeId], kErrMsgServer)

	if episodeId == 0 then
		act210EpisodeRecord.isFinished = true
	else
		local episodeCO = assert(self:getEpisodeCO(episodeId), kErrMsgServer)

		if episodeCO.preEpisodeId > 0 then
			local preAct210EpisodeRecord = info.episodeId2Act210EpisodeRecord[episodeCO.preEpisodeId]

			assert(preAct210EpisodeRecord.isFinished, kErrMsgServer)
		end

		act210EpisodeRecord.isFinished = true
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodeId", episodeId)
	rawset(reply, "progress", progress)
end

function STesting:_make_taskInfos(typeId)
	local dict = {}

	if typeId == KTaskType then
		for _, CO in ipairs(lua_activity210_task.configList) do
			local taskId = CO.id
			local activityId = CO.activityId

			dict[activityId] = dict[activityId] or {}

			if CO.isOnline then
				dict[activityId][taskId] = self:_make_TaskInfo(taskId, typeId)
			end
		end
	else
		assert(false, "please init task type: " .. typeId)
	end

	return dict
end

function STesting:_make_TaskActivityInfo(typeId)
	return {
		defineId = 0,
		expiryTime = 0,
		value = 0,
		gainValue = 0,
		typeId = typeId
	}
end

function STesting:handleGetTaskInfoReply(req, reply)
	local typeIds = req.typeIds
	local taskInfo = {}
	local activityInfo = {}

	for _, typeId in ipairs(typeIds) do
		self._taskInfoDict[typeId] = self._taskInfoDict[typeId] or self:_make_taskInfos(typeId)
		self._taskActivityInfoDict[typeId] = self._taskActivityInfoDict[typeId] or self:_make_TaskActivityInfo(typeId)

		for actId, actTable in pairs(self._taskInfoDict[typeId]) do
			if actId == self:actId() then
				for taskId, info in pairs(actTable) do
					table.insert(taskInfo, info)
				end
			end
		end

		table.insert(activityInfo, self._taskActivityInfoDict[typeId])
	end

	rawset(reply, "taskInfo", taskInfo)
	rawset(reply, "activityInfo", activityInfo)
	rawset(reply, "typeIds", typeIds)
end

function STesting:_getInfo(activityId)
	return self._actId2InfoDict[activityId]
end

function STesting:_make_TaskInfo(taskId, taskType)
	local taskCO = TaskModel.instance:getTaskConfig(taskType, taskId)

	assert(taskCO, kErrMsgServer)

	local maxProgress = taskCO.maxProgress
	local res = {
		hasFinished = false,
		expiryTime = 0,
		finishCount = 0,
		id = taskId,
		type = taskType,
		progress = math.random(0, maxProgress)
	}

	res.hasFinished = res.progress == maxProgress

	return res
end

local kResultCode = 0
local CTesting = _G.class("CTesting", TestingBase)

function CTesting:ctor()
	TestingBase.ctor(self)

	self._cRpc = DungeonRpc
	self._cCtrl = ChgController
	self._cBattleModel = ChgBattleModel
	self._cTaskRpc = TaskRpc
	self._cTaskModel = TaskModel
	self._cTaskController = TaskController
	self._cChgViewBaseContainer = ChgViewBaseContainer
	self._cV3a4_Chg_LevelViewContainer = V3a4_Chg_LevelViewContainer
	self._cV3a4_Chg_GameView = V3a4_Chg_GameView
	self._cV3a4_Chg_GameViewContainer = V3a4_Chg_GameViewContainer
	self._cChg_PuzzleMazeGameInfo = Chg_PuzzleMazeGameInfo
end

function CTesting:build_test()
	self:build_test__Chg()
	self:build_test__Task()
end

function CTesting:build_test__Chg()
	function self._cV3a4_Chg_GameViewContainer.openInternal(thisObj, viewParam, ...)
		local modelInst = self._cBattleModel.instance
		local elementId = modelInst:elementId()

		modelInst:onInit()

		modelInst._elementId = elementId

		thisObj:restart()
		self._cV3a4_Chg_GameViewContainer.super.openInternal(thisObj, viewParam, ...)
	end

	function self._cV3a4_Chg_GameViewContainer.buildViews(thisObj)
		thisObj._mainView = V3a4_Chg_GameView.New()

		return {
			thisObj._mainView
		}
	end

	function self._cV3a4_Chg_GameViewContainer.restart(thisObj)
		local modelInst = self._cBattleModel.instance
		local jsonStr = _unitTest()
		local _mapMO = modelInst._mapMO

		_mapMO:restart(jsonStr)
	end

	function self._cV3a4_Chg_GameView.setText_txtCount(thisObj, num)
		thisObj._txtCount.text = tostring(num)
	end

	function self._cChg_PuzzleMazeGameInfo.mapCO(thisObj)
		if not thisObj.__info then
			thisObj:reset(_unitTest())
		end

		return thisObj.__info
	end

	function self._cChgViewBaseContainer.saveInt(key, value)
		logError("saveInt:" .. tostring(key) .. " value=" .. tostring(value))
	end

	function self._cChgViewBaseContainer.showV3a4_Chg_GameStartView()
		return
	end

	function self._cCtrl.completeGame()
		local ctrlInst = self._cCtrl.instance
		local elementId = ctrlInst._battle:elementId()

		ctrlInst:dispatchEvent(ChgEvent.OnGameFinished, elementId)
	end

	function GaoSiNiaoWork_WaitCloseView.onStart(thisObj)
		thisObj:clearWork()
		thisObj:onSucc()
	end
end

function CTesting:build_test__Task()
	local rpcObj = self._cTaskRpc.instance
	local pb = self._pbTask

	function self._cTaskRpc.sendGetTaskInfoRequest(thisObj, typeIds, callback, callbackObj)
		local req = pb.GetTaskInfoRequest()

		for _, v in pairs(typeIds) do
			table.insert(req.typeIds, v)
		end

		if #typeIds == 1 and typeIds[1] == KTaskType then
			local reply = pb.GetTaskInfoReply()

			self._obj:handleGetTaskInfoReply(req, reply)
			rpcObj:onReceiveGetTaskInfoReply(kResultCode, reply)

			local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

			if callback then
				if callbackObj then
					callback(callbackObj, cmd, kResultCode)
				else
					callback(cmd, kResultCode)
				end
			end
		else
			return thisObj:sendMsg(req, callback, callbackObj)
		end
	end
end

function CTesting:switchMode(isEditMode)
	local modelInst = self._cBattleModel.instance
	local isLastEditMode = modelInst._mapMO.class.__cname == "GaoSiNiaoBattleMapMO__Edit"

	if isLastEditMode == isEditMode then
		return
	end

	if isEditMode then
		GaoSiNiaoBattleMapMO__Edit.move_ctor(modelInst, "_mapMO", modelInst, "_mapMO")
	else
		GaoSiNiaoBattleMapMO.move_ctor(modelInst, "_mapMO", modelInst, "_mapMO")
	end
end

local ChgTesting = _G.class("ChgTesting")

function ChgTesting:ctor()
	self._client = CTesting.New()
	self._sever = STesting.New()

	self._sever:link(self._client)
	self._client:link(self._sever)
end

function ChgTesting:_test()
	self._client:build_test()
	self._sever:build_test()
end

function ChgTesting:_offline_test()
	local myActId = self._client:actId()

	logError(myActId)

	if not myActId then
		logError("ChgTesting offline test error: can not found actId")

		return
	end

	local myStartTime = os.time() * 1000
	local myEndTime = myStartTime + 259200
	local myActivityInfo = {
		activityInfos = {
			{
				currentStage = 0,
				isUnlock = true,
				online = true,
				isReceiveAllBonus = false,
				isNewStage = false,
				id = myActId,
				startTime = myStartTime,
				endTime = myEndTime
			}
		}
	}

	ActivityModel.instance:setActivityInfo(myActivityInfo)
	ChgTesting.instance:_test()

	if not ChgTesting.s_fistOpenGm then
		GMController.instance:openGMView()

		ChgTesting.s_fistOpenGm = true

		return
	end

	ViewMgr.instance:closeView(ViewName.GMToolView)
	ViewMgr.instance:closeView(ViewName.GMToolView2)

	if not ChgTesting.s_V3a4_Chg_GameView then
		ViewMgr.instance:openView(ViewName.V3a4_Chg_GameView)

		ChgTesting.s_V3a4_Chg_GameView = true
	else
		ChgTesting.s_V3a4_Chg_GameView = false

		ViewMgr.instance:closeView(ViewName.V3a4_Chg_GameView)
	end
end

ChgTesting.instance = ChgTesting.New()
ChgTesting.setColorDesc = _setColorDesc
ChgTesting.kGreen = kGreen
ChgTesting.kWhite = kWhite
ChgTesting.kYellow = kYellow
ChgTesting.kRed = kRed
ChgTesting.kBlue = kBlue
ChgTesting.kBlack = kBlack

return ChgTesting
