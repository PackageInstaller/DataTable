-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/ClawDollController.lua

module("logic.extensions.welfare.controller.claw_doll.ClawDollController", package.seeall)

local M = class("ClawDollController", BaseController)

function M:onInit()
	self:_setEvent(true)
end

function M:onReset()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TASK_GET_TASKNOLIST, self._setTaskListReply, self)
		GlobalDispatcher:addEventListener(EventType.TASK_REFRESH_BOOL, self._isRefreshTaskListReply, self)
		GlobalDispatcher:addEventListener(EventType.TASK_RECEIVE_SUCCESS, self._recevieTaskRewardReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TASK_GET_TASKNOLIST, self._setTaskListReply, self)
		GlobalDispatcher:removeEventListener(EventType.TASK_REFRESH_BOOL, self._isRefreshTaskListReply, self)
		GlobalDispatcher:removeEventListener(EventType.TASK_RECEIVE_SUCCESS, self._recevieTaskRewardReply, self)
	end
end

function M:_setTaskListReply(e, msg)
	if msg.label == TaskEnum.TaskLabel.ClipDollDaily then
		ClawDollModel.instance:setTaskList(msg)
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_SETTASK, msg.label)
	end
end

function M:_isRefreshTaskListReply(e, msg)
	local isRefresh = msg.label == TaskEnum.TaskLabel.ClipDollDaily and msg.refresh == true

	if isRefresh then
		TaskAgent.instance:sendListTaskRequest(msg.label)
	end
end

function M:_recevieTaskRewardReply(e, id)
	local isDataChange = ClawDollModel.instance:setOneTaskFinish(id[1])

	if isDataChange then
		local info = ActivityTaskConfig.instance:getTaskInfoById(id[1])

		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_SETTASK, info.label)
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_REDPOINT)
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_COINNUMBER)
	end
end

function M:_oneTaskChange(e, msg)
	local taskNo = msg.task

	ClawDollModel.instance:oneTaskChange(taskNo)
end

function M:getClawDollTaskLstByLabel(label)
	return ClawDollModel.instance:getClawDollTaskLstByLabel(label)
end

function M:getClawDollOriginTaskLstByCfgId(cfgId)
	return ClawDollModel.instance:getClawDollOriginTaskLstByCfgId(cfgId)
end

function M:isHasTaskCanReivceByCfgId(cfgId)
	return ClawDollModel.instance:isHasTaskCanReivceByCfgId(cfgId)
end

function M:isFinishAllTask(cfgId)
	return ClawDollModel.instance:isFinishAllTask(cfgId)
end

function M:setClipDollInfoReply(msg)
	local isChange = ClawDollModel.instance:setExchangeList(msg.aConfigId, msg.redeemPrize)

	if isChange then
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_REFRESHEXCHANGE, msg.aConfigId)
	end

	local isDataChange = ClawDollModel.instance:setDollInMachineList(msg.aConfigId, msg.dolls)

	if isDataChange then
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_REFRESHDETAIL, msg.aConfigId)
	end
end

function M:setRedeemPrizeReply(msg)
	local isChange = ClawDollModel.instance:setOneExchange(msg)

	if isChange then
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_REFRESHEXCHANGE, msg.aConfigId)
	end
end

function M:setClipDollBollReply(msg)
	local isChange = ClawDollModel.instance:setOneClawDollBoll(msg.aConfigId, msg.doll)

	if isChange then
		GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_BTNINTERACT_CLAW, msg)
	end
end

function M:getClawDollExchangeLstByCfgId(cfgId)
	return ClawDollModel.instance:getClawDollExchangeByCfgId(cfgId)
end

function M:setActivityId(cfgId, id)
	ClawDollModel.instance:setActivityId(cfgId, id)
	ClawDollAgent.instance:sendGetClipDollInfoRequest(cfgId)
end

function M:getActivityId(cfgId)
	return ClawDollModel.instance:getActivityId(cfgId)
end

function M:getCurCoinNumber(cfgId)
	return ClawDollModel.instance:getCurCoinNumber(cfgId)
end

function M:getDollInMachineList(cfgId)
	return ClawDollModel.instance:getDollInMachineList(cfgId)
end

function M:setDollPath(cfgId, lst)
	ClawDollModel.instance:setDollPath(cfgId, lst)
end

function M:getDollPath(cfgId, dollID)
	return ClawDollModel.instance:getDollPath(cfgId, dollID)
end

M.instance = M.New()

return M
