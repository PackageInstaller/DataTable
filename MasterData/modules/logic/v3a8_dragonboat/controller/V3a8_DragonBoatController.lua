-- chunkname: @modules/logic/v3a8_dragonboat/controller/V3a8_DragonBoatController.lua

module("modules.logic.v3a8_dragonboat.controller.V3a8_DragonBoatController", package.seeall)

local V3a8_DragonBoatController = class("V3a8_DragonBoatController", BaseController)

function V3a8_DragonBoatController:addConstEvents()
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, self._onMainPopupFlowFinish, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self, LuaEventSystem.Low)
end

function V3a8_DragonBoatController:_onMainPopupFlowFinish()
	if not V3a8_DragonBoatModel.instance:isActOnLine() then
		return
	end

	self:sendGlobalVoteGetInfo()
	self:sendAct241GetInfo()
	self:_updateAct101Info()
end

function V3a8_DragonBoatController:_onDailyRefresh()
	self:_updateAct101Info()
end

function V3a8_DragonBoatController:_onUpdateActivity(actId)
	if self:actId() == actId then
		self:sendGlobalVoteGetInfo()
		self:sendAct241GetInfo()

		return
	end

	if V3a8_DragonBoatConfig.instance:getVoteFinalResultActId() == actId then
		self:_updateAct101Info()

		return
	end
end

function V3a8_DragonBoatController:actId()
	return V3a8_DragonBoatConfig.instance:actId()
end

function V3a8_DragonBoatController:sendGlobalVoteGetInfo()
	local voteId = V3a8_DragonBoatConfig.instance:voteId()

	return GlobalVoteRpc.instance:sendGlobalVoteGetInfo(voteId, self._onSendGlobalVoteGetInfoCb, self)
end

function V3a8_DragonBoatController:_onSendGlobalVoteGetInfoCb()
	V3a8_DragonBoatModel.instance:cacheVoteSimpleInfo()
end

function V3a8_DragonBoatController:sendAct241GetInfo(cb, cbObj)
	return Activity241Rpc.instance:sendAct241GetInfo(self:actId(), cb, cbObj)
end

function V3a8_DragonBoatController:sendAct241Vote(voteNum, optionId, cb, cbObj)
	return Activity241Rpc.instance:sendAct241Vote(self:actId(), voteNum, optionId, cb, cbObj)
end

function V3a8_DragonBoatController:sendAct241GetBonus(cb, cbObj)
	return Activity241Rpc.instance:sendAct241GetBonus(self:actId(), cb, cbObj)
end

function V3a8_DragonBoatController:sendGetFinalBonusReq(cb, cbObj)
	local actId = V3a8_DragonBoatConfig.instance:getVoteFinalResultActId()

	return Activity101Rpc.instance:sendGet101BonusRequest(actId, 1, cb, cbObj)
end

function V3a8_DragonBoatController:_updateAct101Info()
	local actId = V3a8_DragonBoatConfig.instance:getVoteFinalResultActId()

	if ActivityType101Model.instance:isOpen(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end
end

V3a8_DragonBoatController.instance = V3a8_DragonBoatController.New()

return V3a8_DragonBoatController
