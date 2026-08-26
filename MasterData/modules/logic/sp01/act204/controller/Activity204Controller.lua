-- chunkname: @modules/logic/sp01/act204/controller/Activity204Controller.lua

module("modules.logic.sp01.act204.controller.Activity204Controller", package.seeall)

local Activity204Controller = class("Activity204Controller", BaseController)

function Activity204Controller:reInit()
	self:_destroyRpcFlow()
end

function Activity204Controller:setPlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end

	self:dispatchEvent(Activity204Event.LocalKeyChange)
end

function Activity204Controller:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(key, value) or GameUtil.playerPrefsGetStringByUserId(key, value)

	return value
end

function Activity204Controller:getBubbleActIdList()
	local actIdStr = Activity204Config.instance:getConstStr(Activity204Enum.ConstId.BubbleActIds)

	return (string.splitToNumber(actIdStr, "#"))
end

function Activity204Controller:sendRpc2GetMainTaskInfo(callback, callbackObj)
	local isOpen = ActivityHelper.isOpen(ActivityEnum.Activity.V2a9_Act204)

	if isOpen then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Activity173
		})
		Activity204Rpc.instance:sendGetAct204InfoRequest(ActivityEnum.Activity.V2a9_Act204, callback, callbackObj)
	end
end

function Activity204Controller:getAllEntranceActInfo(callback, callbackObj)
	self:_destroyRpcFlow()

	self._rpcFlow = FlowSequence.New()

	local bubbleActIds = self:getBubbleActIdList()

	for _, bubbleActId in ipairs(bubbleActIds) do
		self._rpcFlow:addWork(Activity204RpcWork.New(bubbleActId, Activity101Rpc.sendGet101InfosRequest, Activity101Rpc.instance, bubbleActId))
	end

	self._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_AssassinChase, AssassinChaseRpc.sendAct206GetInfoRequest, AssassinChaseRpc.instance, ActivityEnum.Activity.V2a9_AssassinChase))
	self._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_LoginSign, Activity101Rpc.sendGet101InfosRequest, Activity101Rpc.instance, ActivityEnum.Activity.V2a9_LoginSign))
	self._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_Act204, TaskRpc.sendGetTaskInfoRequest, TaskRpc.instance, {
		TaskEnum.TaskType.Activity173
	}))
	self._rpcFlow:addWork(Activity204RpcWork.New(ActivityEnum.Activity.V2a9_Act204, Activity204Rpc.sendGetAct204InfoRequest, Activity204Rpc.instance, ActivityEnum.Activity.V2a9_Act204))

	if callback then
		self._rpcFlow:registerDoneListener(callback, callbackObj)
	end

	self._rpcFlow:start()
end

function Activity204Controller:_destroyRpcFlow()
	if self._rpcFlow then
		self._rpcFlow:destroy()

		self._rpcFlow = nil
	end
end

function Activity204Controller:jumpToActivity(activityId, params, callback, callbackObj)
	if not activityId then
		logError("jump failed !!! activityId is nil")

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(activityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParam)
		end

		return
	end

	local jumpHandleFunc = Activity204Controller.jumpHandleFunc[activityId]

	if not jumpHandleFunc then
		logError("jump failed !!! jump handle function is nil")

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.Activity204EntranceView) then
		local entranceActId = ActivityEnum.Activity.V2a9_ActCollection
		local entranceJumpFunc = Activity204Controller.jumpHandleFunc[entranceActId]

		if entranceJumpFunc then
			local entranceParams = {
				actId = entranceActId,
				entranceIds = Activity204Enum.EntranceIdList
			}

			entranceJumpFunc(self, entranceActId, entranceParams, function()
				jumpHandleFunc(self, activityId, params, callback, callbackObj)
			end)

			return
		end
	end

	jumpHandleFunc(self, activityId, params, callback, callbackObj)
end

function Activity204Controller:jumpTo_130517(activityId, params, callback, callbackObj)
	self:getAllEntranceActInfo(function()
		ViewMgr.instance:openView(ViewName.Activity204EntranceView, params)

		if callback then
			callback(callbackObj)
		end
	end)
end

function Activity204Controller:jumpTo_130518(actId)
	Activity204Controller.instance:sendRpc2GetMainTaskInfo(function(_, resultCode)
		if resultCode ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Activity204TaskView, {
			actId = actId
		})
	end)
end

function Activity204Controller:jumpTo_130519(actId)
	Act205Controller.instance:openGameStartView(actId)
end

function Activity204Controller:jumpTo_130521(actId)
	Activity101Rpc.instance:sendGet101InfosRequest(actId, function(_, resultCode)
		if resultCode ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.V2a9_LoginSign_FullView, {
			actId = actId
		})
	end)
end

function Activity204Controller:jumpTo_130520()
	AssassinChaseController.instance:openGameStartView(ActivityEnum.Activity.V2a9_AssassinChase)
end

Activity204Controller.jumpHandleFunc = {
	[ActivityEnum.Activity.V2a9_ActCollection] = Activity204Controller.jumpTo_130517,
	[ActivityEnum.Activity.V2a9_Act204] = Activity204Controller.jumpTo_130518,
	[ActivityEnum.Activity.V2a9_Act205] = Activity204Controller.jumpTo_130519,
	[ActivityEnum.Activity.V2a9_AssassinChase] = Activity204Controller.jumpTo_130520,
	[ActivityEnum.Activity.V2a9_LoginSign] = Activity204Controller.jumpTo_130521
}

function Activity204Controller:checkCanGetReward_130518(actId)
	local actMo = Activity204Model.instance:getActMo(actId)

	return actMo and actMo:hasActivityReward()
end

function Activity204Controller:checkCanGetReward_130520(actId)
	return AssassinChaseModel.instance:isActHaveReward(actId)
end

function Activity204Controller:checkCanGetReward_130521(actId)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

function Activity204Controller:checkCanGetReward_130524()
	local actIdList = self:getBubbleActIdList()

	for _, actId in ipairs(actIdList) do
		if ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId) then
			return true
		end
	end
end

Activity204Controller.checkCanGetRewardFunc = {
	[ActivityEnum.Activity.V2a9_Act204] = Activity204Controller.checkCanGetReward_130518,
	[ActivityEnum.Activity.V2a9_AssassinChase] = Activity204Controller.checkCanGetReward_130520,
	[ActivityEnum.Activity.V2a9_LoginSign] = Activity204Controller.checkCanGetReward_130521,
	[ActivityEnum.Activity.V2a9_Bubble] = Activity204Controller.checkCanGetReward_130524
}

function Activity204Controller:isAnyActCanGetReward()
	for actId, checkFun in pairs(Activity204Controller.checkCanGetRewardFunc) do
		local canGet = checkFun(self, actId)

		if canGet then
			return true
		end
	end
end

function Activity204Controller:checkOceanNewOpenRedDot()
	local isOpen = Act205Model.instance:isGameTimeOpen(Act205Enum.GameStageId.Ocean)

	if isOpen then
		::label_23_0::

		local isNewOpen = true
		local isNewOpen

		if Activity204Controller.instance:getPlayerPrefs(PlayerPrefsKey.Activity204OceanOpenReddot, 0) ~= 0 then
			isNewOpen = false
		end

		local redDotVal = isNewOpen and 1 or 0
		local redDotInfoList = {
			{
				uid = 0,
				id = RedDotEnum.DotNode.V2a9_Act205OceanOpen,
				value = redDotVal
			}
		}

		RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
	end
end

Activity204Controller.instance = Activity204Controller.New()

return Activity204Controller
