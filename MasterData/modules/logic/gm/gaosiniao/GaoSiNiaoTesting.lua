-- chunkname: @modules/logic/gm/gaosiniao/GaoSiNiaoTesting.lua

module("modules.logic.gm.gaosiniao.GaoSiNiaoTesting", package.seeall)

local Empty = GaoSiNiaoEnum.GridType.Empty
local Start = GaoSiNiaoEnum.GridType.Start
local End = GaoSiNiaoEnum.GridType.End
local Wall = GaoSiNiaoEnum.GridType.Wall
local Portal = GaoSiNiaoEnum.GridType.Portal
local Path = GaoSiNiaoEnum.GridType.Path
local RB = GaoSiNiaoEnum.PathType.RB
local LT = GaoSiNiaoEnum.PathType.LT
local LRTB = GaoSiNiaoEnum.PathType.LRTB
local TB = GaoSiNiaoEnum.PathType.TB
local LB = GaoSiNiaoEnum.PathType.LB
local RT = GaoSiNiaoEnum.PathType.RT
local LR = GaoSiNiaoEnum.PathType.LR
local LTB = GaoSiNiaoEnum.PathType.LTB

local function _unitTest5()
	local mapInfo = GaoSiNiaoMapInfo.New(GaoSiNiaoEnum.Version.V1_0_0)
	local mapCO = {
		id = 1004,
		height = 6,
		width = 6
	}

	mapCO.bagList = {
		mapInfo:make_bagCO(LR, 5),
		mapInfo:make_bagCO(LT, 2),
		mapInfo:make_bagCO(RB, 2),
		mapInfo:make_bagCO(RT, 2),
		mapInfo:make_bagCO(LB, 1),
		(mapInfo:make_bagCO(LTB, 1))
	}

	local function _m(...)
		return mapInfo:make_gridCO(...)
	end

	local function _mz(...)
		return mapInfo:make_gridCOZot(...)
	end

	mapCO.gridList = {
		[0] = _m(Start),
		_m(Empty),
		_m(Path, LR),
		_m(Empty),
		_m(Empty),
		_m(Wall),
		_m(Empty),
		_m(Empty),
		_m(Wall),
		_m(Portal),
		_m(Path, TB),
		_mz(End, 180),
		_m(Path, RT),
		_m(Empty),
		_m(Wall),
		_m(Empty),
		_m(Empty),
		_m(Path, TB),
		_m(Wall),
		_m(Empty),
		_m(Empty),
		_m(Empty),
		_m(Empty),
		_m(Empty),
		_m(Empty),
		_m(Path, LR),
		_m(Empty),
		_m(Empty),
		_m(Wall),
		_m(Wall),
		_m(Portal),
		_m(Empty),
		_m(Wall),
		_m(Empty),
		_m(Empty),
		(_mz(End, 90))
	}

	return mapCO
end

local function _unitTest()
	return _unitTest5()
end

local TestingBase = _G.class("TestingBase")
local KTaskType = TaskEnum.TaskType.Activity210

function TestingBase:ctor()
	self._pb = Activity210Module_pb
	self._cCfg = GaoSiNiaoConfig
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

function STesting:_make_Act210EpisodeRecord(episodeId, isFinished, progress)
	return {
		episodeId = episodeId,
		isFinished = isFinished or false,
		progress = progress or "",
		unlockBranchIds = {}
	}
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

function STesting:handleAct210SaveEpisodeProgress(req, reply)
	local activityId = req.activityId
	local episodeId = req.episodeId
	local progress = req.progress

	if episodeId == 0 then
		-- block empty
	else
		local info = assert(self:_getInfo(activityId), kErrMsgServer)
		local act210EpisodeRecord = assert(info.episodeId2Act210EpisodeRecord[episodeId], kErrMsgServer)
		local episodeCO = assert(self:getEpisodeCO(episodeId), kErrMsgServer)
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodeId", episodeId)
	rawset(reply, "progress", progress)
end

function STesting:handleAct210ChooseEpisodeBranch(req, reply)
	local activityId = req.activityId
	local episodeId = req.episodeId
	local branchId = req.branchId

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodeId", episodeId)
	rawset(reply, "branchId", branchId)
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

function STesting:_getEpisodeList(activityId)
	local info = assert(self:_getInfo(activityId), kErrMsgServer)
	local list = {}

	for _, act210EpisodeRecord in pairs(info.episodeId2Act210EpisodeRecord) do
		table.insert(list, act210EpisodeRecord)
	end

	table.sort(list, function(a, b)
		return a.episodeId < b.episodeId
	end)

	return list
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

	self._cRpc = Activity210Rpc
	self._cCtrl = GaoSiNiaoController
	self._cSysModel = GaoSiNiaoSysModel
	self._cBattleModel = GaoSiNiaoBattleModel
	self._cTaskRpc = TaskRpc
	self._cTaskModel = TaskModel
	self._cTaskController = TaskController
	self._cGaoSiNiaoLevelViewContainer = V3a1_GaoSiNiao_LevelViewContainer
	self._cV3a1_GaoSiNiao_GameView = V3a1_GaoSiNiao_GameView
	self._cV3a1_GaoSiNiao_GameViewContainer = V3a1_GaoSiNiao_GameViewContainer
	self._cGaoSiNiaoMapInfo = GaoSiNiaoMapInfo
	self._cActivity210ViewBaseContainer = Activity210ViewBaseContainer
end

function CTesting:build_test()
	self:build_test__Act210()
	self:build_test__Task()
end

function CTesting:build_test__Act210()
	local rpcObj = self._cRpc.instance
	local pb = self._pb

	function self._cRpc.sendGetAct210InfoRequest(thisObj, activityId, cb, cbObj)
		local req = pb.GetAct210InfoRequest()

		req.activityId = activityId

		local reply = pb.GetAct210InfoReply()

		self._obj:handleGetAct210Info(req, reply)
		rpcObj:onReceiveGetAct210InfoReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendAct210FinishEpisodeRequest(thisObj, activityId, episodeId, progress, cb, cbObj)
		local req = pb.Act210FinishEpisodeRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.progress = progress or ""

		local reply = pb.Act210FinishEpisodeReply()

		self._obj:handleAct210FinishEpisode(req, reply)
		rpcObj:onReceiveAct210FinishEpisodeReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendAct210SaveEpisodeProgressRequest(thisObj, activityId, episodeId, progress, cb, cbObj)
		local req = pb.Act210SaveEpisodeProgressRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.progress = progress or ""

		local reply = pb.Act210SaveEpisodeProgressReply()

		self._obj:handleAct210SaveEpisodeProgress(req, reply)
		rpcObj:onReceiveAct210FinishEpisodeReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendAct210ChooseEpisodeBranchRequest(thisObj, activityId, episodeId, branchId, cb, cbObj)
		local req = pb.Act210ChooseEpisodeBranchRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.branchId = branchId

		local reply = pb.Act210ChooseEpisodeBranchReply()

		self._obj:handleAct210ChooseEpisodeBranch(req, reply)
		rpcObj:onReceiveAct210ChooseEpisodeBranchReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cSysModel.hasPassPreStory()
		return true
	end

	function self._cSysModel.hasPassPostStory()
		return true
	end

	function self._cSysModel.hasPassPrePostStory()
		return true
	end

	function self._cGaoSiNiaoLevelViewContainer.onContainerInit()
		return
	end

	function self._cGaoSiNiaoLevelViewContainer.buildViews(thisObj)
		return {
			V3a1_GaoSiNiao_LevelView.New()
		}
	end

	self._cGaoSiNiaoLevelViewContainer.s_episodeIdSet = self._cGaoSiNiaoLevelViewContainer.s_episodeIdSet or {}

	local s_episodeIdSet = self._cGaoSiNiaoLevelViewContainer.s_episodeIdSet

	function self._cGaoSiNiaoLevelViewContainer.saveHasPlayedUnlockedAnimPath(thisObj, episodeId)
		s_episodeIdSet[episodeId] = true
	end

	function self._cGaoSiNiaoLevelViewContainer.hasPlayedUnlockedAnimPath(thisObj, episodeId)
		return s_episodeIdSet[episodeId] == true
	end

	function self._cGaoSiNiaoLevelViewContainer.isEpisodeOpen(thisObj, episodeId)
		local value = kBase_EpisodeId + (kTest_CompleteCount + 1)
		local toWhich = GameUtil.clamp(value, 1311801, 1311809)

		return episodeId <= toWhich
	end

	function self._cV3a1_GaoSiNiao_GameViewContainer.openInternal(thisObj, viewParam, ...)
		local mapCO = _unitTest()
		local modelInst = self._cBattleModel.instance
		local episodeId = modelInst._episodeId

		modelInst:onInit()

		modelInst._episodeId = episodeId

		local _mapMO = modelInst._mapMO

		_mapMO.__info._mapCO = mapCO

		_mapMO:_createMap(mapCO)
		self._cV3a1_GaoSiNiao_GameViewContainer.super.openInternal(thisObj, viewParam, ...)
	end

	function self._cV3a1_GaoSiNiao_GameViewContainer.buildViews(thisObj)
		return {
			V3a1_GaoSiNiao_GameView.New()
		}
	end

	function self._cGaoSiNiaoMapInfo.mapCO(thisObj)
		thisObj._mapCO = thisObj._mapCO or _unitTest()

		return thisObj._mapCO
	end

	function self._cActivity210ViewBaseContainer.saveInt(key, value)
		logError("saveInt:" .. tostring(key) .. " value=" .. tostring(value))
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

local GaoSiNiaoTesting = _G.class("GaoSiNiaoTesting")

function GaoSiNiaoTesting:ctor()
	self._client = CTesting.New()
	self._sever = STesting.New()

	self._sever:link(self._client)
	self._client:link(self._sever)
end

function GaoSiNiaoTesting:_test()
	addGlobalModule("modules.logic.gm.gaosiniao.GaoSiNiaoBattleMapMO__Edit", "GaoSiNiaoBattleMapMO__Edit")
	self._client:build_test()
	self._sever:build_test()
end

function GaoSiNiaoTesting:_offline_test()
	local myActId = self._client:actId()

	logError(myActId)

	if not myActId then
		logError("GaoSiNiaoTesting offline test error: can not found actId")

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
	GaoSiNiaoTesting.instance:_test()

	if not GaoSiNiaoTesting.s_fistOpenGm then
		GMController.instance:openGMView()

		GaoSiNiaoTesting.s_fistOpenGm = true

		return
	end

	ViewMgr.instance:closeView(ViewName.GMToolView)
	ViewMgr.instance:closeView(ViewName.GMToolView2)

	if not GaoSiNiaoTesting.s_V3a1_GaoSiNiao_GameView then
		ViewMgr.instance:openView(ViewName.V3a1_GaoSiNiao_GameView)

		GaoSiNiaoTesting.s_V3a1_GaoSiNiao_GameView = true
	else
		GaoSiNiaoTesting.s_V3a1_GaoSiNiao_GameView = false

		ViewMgr.instance:closeView(ViewName.V3a1_GaoSiNiao_GameView)
	end
end

function GaoSiNiaoTesting:cSwitchMode(isEditMode)
	self._client:switchMode(isEditMode or false)
end

GaoSiNiaoTesting.instance = GaoSiNiaoTesting.New()

return GaoSiNiaoTesting
