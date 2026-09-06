-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/controller/RecallTaskController.lua

module("logic.extensions.recalltask.controller.RecallTaskController", package.seeall)

local RecallTaskController = class("RecallTaskController", BaseController)

function RecallTaskController:ctor()
	return
end

function RecallTaskController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onHandTickDailyRefresh, self)
end

function RecallTaskController:onReset()
	return
end

function RecallTaskController:_onHandTickDailyRefresh()
	local isRecall = RecallTaskModel.instance:isGetRecallPlayer()

	if isRecall then
		local cfg = RecallTaskConfig.instance:getRecallActivityCfg(RecallTaskModel.instance.openActivityId)

		if (cfg and cfg.funcId > 0 or nil) and FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) and ViewMgr.instance:isOpen(ViewName.RecallTask) then
			self:csGetInviteUserInfoReq()
		end
	else
		local isOpen = PlayerReturnModel.instance:isOpenActivityEnd()

		if isOpen and ViewMgr.instance:isOpen(ViewName.ReturnTask) then
			self:csGetRegressUserInfoReq()
		end
	end
end

function RecallTaskController:csGetRegressUserInfoReq()
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIGetRegressUserInfoReq(actId)
end

function RecallTaskController:csRegressUserInfo(msg)
	RecallTaskModel.instance:csRegressUserInfo(msg)
end

function RecallTaskController:csGetInviteUserInfoReq()
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIGetInviteUserInfoReq(actId)
end

function RecallTaskController:csInviteUserInfo(msg)
	RecallTaskModel.instance:csInviteUserInfo(msg)
end

function RecallTaskController:csGetGainTaskPrizeReq(taskId, userId)
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIGainTaskPrizeReq(actId, taskId, userId)
end

function RecallTaskController:csGainTaskPrize(msg)
	RecallTaskModel.instance:csGainTaskPrize(msg)
end

function RecallTaskController:csGetGainInvitePrizeReq(prizeId)
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIGainInvitePrizeReq(actId, prizeId)
end

function RecallTaskController:csGainInvitePrize(msg)
	RecallTaskModel.instance:csGainInvitePrize(msg)
end

function RecallTaskController:csGetWriteUseCodeReq(code)
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIUseCodeReq(actId, code)
end

function RecallTaskController:csWriteUseCode(msg)
	RecallTaskModel.instance:csWriteUseCode(msg)
end

function RecallTaskController:csGetTaskInviteInfoReq(userId, taskId, isHead)
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIGetTaskInviteInfoReq(actId, userId, taskId, isHead)
end

function RecallTaskController:csTaskInviteInfo(msg)
	RecallTaskModel.instance:csTaskInviteInfo(msg)
end

function RecallTaskController:scGetAcceptTaskInviteReq(userId, taskId)
	local actId = RecallTaskModel.instance.openActivityId

	if checknumber(actId) <= 0 then
		return
	end

	RegressInviteAgent.instance:sendPM_RIAcceptTaskInviteReq(actId, userId, taskId)
end

function RecallTaskController:csAcceptTaskInvite(msg)
	RecallTaskModel.instance:csAcceptTaskInvite(msg)
end

function RecallTaskController:scGetAllShopItemInfoReq()
	local isRecall = RecallTaskModel.instance:isGetRecallPlayer()
	local isOpen = true

	if isRecall then
		local cfg = RecallTaskConfig.instance:getRecallActivityCfg(RecallTaskModel.instance.openActivityId)

		if cfg and cfg.funcId > 0 then
			isOpen = FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)
		end
	else
		isOpen = PlayerReturnModel.instance:isOpenActivityEnd()
	end

	if not isOpen then
		return
	end

	ActivityshopController.instance:getAllShopItemInfo(RecallTaskModel.instance.openActivityType, RecallTaskModel.instance.openActivityId)
end

RecallTaskController.instance = RecallTaskController.New()

return RecallTaskController
