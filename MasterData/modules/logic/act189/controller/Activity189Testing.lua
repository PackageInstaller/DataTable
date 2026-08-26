-- chunkname: @modules/logic/act189/controller/Activity189Testing.lua

module("modules.logic.act189.controller.Activity189Testing", package.seeall)

local ti = table.insert
local TestingBase = _G.class("TestingBase")
local KTaskType = TaskEnum.TaskType.Activity189

function TestingBase:ctor()
	self._pb = Activity189Module_pb
	self._cCfg = Activity189Config
	self._cTaskCfg = TaskConfig
	self._pbTask = TaskModule_pb
end

function TestingBase:build_test()
	return
end

function TestingBase:link(obj)
	self._obj = obj
end

local kErrMsgServer = "服务器异常"
local STesting = _G.class("STesting", TestingBase)

function STesting:ctor()
	TestingBase.ctor(self)

	self._taskInfoDict = {}
	self._taskActivityInfoDict = {}
end

function STesting:_make_taskInfos(typeId)
	local dict = {}

	if typeId == KTaskType then
		for _, CO in ipairs(lua_activity189_task.configList) do
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
			for taskId, info in pairs(actTable) do
				ti(taskInfo, info)
			end
		end

		ti(activityInfo, self._taskActivityInfoDict[typeId])
	end

	rawset(reply, "taskInfo", taskInfo)
	rawset(reply, "activityInfo", activityInfo)
	rawset(reply, "typeIds", typeIds)
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

	self._cRpc = Activity189Rpc
	self._cCtrl = Activity189Controller
	self._cModel = Activity189Model
	self._cTaskRpc = TaskRpc
	self._cTaskModel = TaskModel
	self._cTaskController = TaskController
end

function CTesting:build_test()
	self:build_test__Task()
	self:build_test__Player()
end

function CTesting:build_test__Player()
	function PlayerModel.forceSetSimpleProperty()
		return
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

local Activity189Testing = _G.class("Activity189Testing")

function Activity189Testing:ctor()
	self._client = CTesting.New()
	self._sever = STesting.New()

	self._sever:link(self._client)
	self._client:link(self._sever)
end

function Activity189Testing:_test()
	self._client:build_test()
	self._sever:build_test()
end

Activity189Testing.instance = Activity189Testing.New()

return Activity189Testing
