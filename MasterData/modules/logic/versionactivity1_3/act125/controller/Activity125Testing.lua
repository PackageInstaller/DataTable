-- chunkname: @modules/logic/versionactivity1_3/act125/controller/Activity125Testing.lua

module("modules.logic.versionactivity1_3.act125.controller.Activity125Testing", package.seeall)

local TestingBase = _G.class("TestingBase")
local KTaskType = TaskEnum.TaskType.Activity125

function TestingBase:ctor()
	self._pb = Activity125Module_pb
	self._cCfg = Activity125Config
	self._cTaskCfg = TaskConfig
	self._pbTask = TaskModule_pb
end

function TestingBase:build_test()
	return
end

function TestingBase:link(obj)
	self._obj = obj
end

local STATE_NONE = 0
local STATE_COMPLETED = 1
local kErrMsgServer = "myserver error"
local kErrMsgClient = "returnCode: -2"
local STesting = _G.class("STesting", TestingBase)

function STesting:ctor()
	TestingBase.ctor(self)

	self._actId2InfoDict = {}
	self._taskInfoDict = {}
	self._taskActivityInfoDict = {}
end

function STesting:_make_Act125Episode(id, state)
	local var_5_0 = {
		id = id
	}

	if not state then
		::label_5_0::

		local var_5_1

		if math.random(0, 99999) % 2 == 0 then
			var_5_1 = STATE_COMPLETED or STATE_NONE
		end
	end

	var_5_0.state = var_5_1

	return var_5_0
end

function STesting:_make_Info(activityId)
	assert(activityId, kErrMsgServer)

	local cfgObj = self._cCfg.instance
	local act125Config = assert(cfgObj:getAct125Config(activityId), kErrMsgServer .. activityId)
	local act125Episodes = {}

	for _, v in pairs(act125Config) do
		local id = v.id

		act125Episodes[id] = self:_make_Act125Episode(id, STATE_NONE)
	end

	local res = {
		activityId = activityId,
		act125Episodes = act125Episodes
	}
	local test_CompleteCount = 0

	for i = 1, test_CompleteCount do
		act125Episodes[i].state = STATE_COMPLETED
	end

	return res
end

function STesting:handleGetInfos(req, reply)
	local activityId = req.activityId
	local info = self:_getInfo(activityId)

	if not info then
		info = self:_make_Info(activityId)
		self._actId2InfoDict[activityId] = info
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "act125Episodes", self:_getEpisodeList(activityId))
end

function STesting:handleFinishAct125Episode(req, reply)
	local activityId = req.activityId
	local episodeId = req.episodeId
	local targetFrequency = req.targetFrequency
	local cfgObj = self._cCfg.instance
	local act125Config = cfgObj:getAct125Config(activityId)
	local info = assert(self:_getInfo(activityId), kErrMsgServer)
	local episodeConfig = cfgObj:getEpisodeConfig(activityId, episodeId)
	local updateAct125Episodes = {}

	if targetFrequency >= episodeConfig.targetFrequency then
		local episodeInfo = self:_retainEpisodeNewState(activityId, episodeId, STATE_COMPLETED)

		table.insert(updateAct125Episodes, episodeInfo)
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodeId", episodeId)
	rawset(reply, "updateAct125Episodes", updateAct125Episodes)
end

function STesting:_make_taskInfos(typeId)
	local dict = {}

	if typeId == KTaskType then
		for _, CO in ipairs(lua_activity125_task.configList) do
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
			if actId == 13612 then
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
	local info = self:_getInfo(activityId)
	local list = {}

	for _, v in pairs(info.act125Episodes) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	return list
end

function STesting:_retainEpisodeNewState(activityId, episodeId, newSTATE_XXXXXX)
	assert(activityId, kErrMsgServer)
	assert(episodeId, kErrMsgServer)
	assert(newSTATE_XXXXXX, kErrMsgServer)

	local info = assert(self:_getInfo(activityId), kErrMsgServer)
	local episodeInfo = info.act125Episodes[episodeId]

	if not episodeInfo then
		logError(kErrMsgClient)

		return
	end

	episodeInfo.state = newSTATE_XXXXXX

	return episodeInfo
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

	self._cRpc = Activity125Rpc
	self._cCtrl = Activity125Controller
	self._cModel = Activity125Model
	self._cActivity125ViewBaseContainer = Activity125ViewBaseContainer
	self._cTaskRpc = TaskRpc
	self._cTaskModel = TaskModel
	self._cTaskController = TaskController
end

function CTesting:build_test()
	self:build_test__Act125()
	self:build_test__Task()
	self:build_test__Player()
end

function CTesting:build_test__Player()
	function PlayerModel.forceSetSimpleProperty()
		return
	end
end

function CTesting:build_test__Act125()
	local rpcObj = self._cRpc.instance
	local pb = self._pb

	function self._cRpc.sendGetAct125InfosRequest(thisObj, activityId, cb, cbObj)
		local req = pb.GetAct125InfosRequest()

		req.activityId = activityId

		local reply = pb.GetAct125InfosReply()

		self._obj:handleGetInfos(req, reply)
		rpcObj:onReceiveGetAct125InfosReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendFinishAct125EpisodeRequest(thisObj, activityId, episodeId, targetFrequency, cb, cbObj)
		local req = pb.FinishAct125EpisodeRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.targetFrequency = targetFrequency

		local reply = pb.FinishAct125EpisodeReply()

		self._obj:handleFinishAct125Episode(req, reply)
		rpcObj:onReceiveFinishAct125EpisodeReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.onReceiveFinishAct125EpisodeReply(thisObj, resultCode, msg)
		if resultCode == 0 then
			Activity125Model.instance:refreshActivityInfo(msg)
			Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate, msg)
			Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeFinished, msg.episodeId)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, {})
	end

	local cMO = Activity125MO
	local isTestAnim = true
	local isTestDays = true
	local isSavePlayerPrefs = true

	if isTestAnim and cMO then
		local _dict = {}

		function cMO.setLocalIsPlay(thisObj, episodeId)
			_dict[thisObj.id] = _dict[thisObj.id] or {}
			_dict[thisObj.id][episodeId] = true
		end

		function cMO.checkLocalIsPlay(thisObj, episodeId)
			_dict[thisObj.id] = _dict[thisObj.id] or {}

			return _dict[thisObj.id][episodeId]
		end
	end

	if not isSavePlayerPrefs then
		function self._cActivity125ViewBaseContainer.saveInt(thisObj, key, value)
			logError("[Activity125Testing] saveInt: key=" .. key .. " value=" .. tostring(value))
		end
	end

	if isTestDays and cMO then
		function cMO.isEpisodeDayOpen(thisObj, episodeId)
			return true
		end

		function cMO.isEpisodeUnLock(thisObj, episodeId)
			return true
		end
	end

	if WarmUp then
		function WarmUp._showDeadline(thisObj)
			return
		end
	end

	if V3a6_WarmUp then
		function V3a6_WarmUp._showDeadline(thisObj)
			return
		end
	end

	function self._cCfg.getWarmUpActId(thisObj)
		return 13612
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

local Activity125Testing = _G.class("Activity125Testing")

function Activity125Testing:ctor()
	self._client = CTesting.New()
	self._sever = STesting.New()

	self._sever:link(self._client)
	self._client:link(self._sever)
end

function Activity125Testing:_test()
	self._client:build_test()
	self._sever:build_test()
end

function Activity125Testing:_offline_test()
	if not lua_activity125.configList then
		local COList = {}
		local recentCO = COList[#COList]

		for i = #COList, math.max(1, #COList - 5), -1 do
			local CO = COList[i]
			local activityId = CO.activityId

			if lua_activity125_link.configDict[activityId] then
				recentCO = CO

				break
			end
		end

		local myActId = 13818

		logError(myActId)

		if not myActId then
			logError("Activity125Testing offline test error: can not found actid")

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
		Activity125Testing.instance:_test()
		Activity125Model.instance:setSelectEpisodeId(myActId, 1)
		ActivityModel.instance:setTargetActivityCategoryId(myActId)
		ViewMgr.instance:openView(ViewName.ActivityBeginnerView)
	end
end

Activity125Testing.instance = Activity125Testing.New()

return Activity125Testing
