-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/controller/PlayerReturnController.lua

module("logic.extensions.playerreturn.controller.PlayerReturnController", package.seeall)

local PlayerReturnController = class("PlayerReturnController", BaseController)

function PlayerReturnController:ctor()
	return
end

function PlayerReturnController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onHandTickDailyRefresh, self)
	RegressAgent.instance:addHandler(RegressAgent.PM_NotifyRegressBuyGiftRes, self.scNotifyRegressBuyGiftRes, self)
end

function PlayerReturnController:onReset()
	return
end

function PlayerReturnController:_onHandTickDailyRefresh()
	self:csRegressGetActInfoReq()

	if ViewMgr.instance:isOpen(ViewName.PlayerReturnSign) then
		self:csRegressGetSignInInfoReq()
	end

	if ViewMgr.instance:isOpen(ViewName.PlayerReturnPlge) then
		GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlgeInfo)
	end

	if ViewMgr.instance:isOpen(ViewName.PlayerReturnTask) then
		self:csRegressGetTaskInfoReq()
	end

	if ViewMgr.instance:isOpen(ViewName.PlayerReturnShop) then
		self:csRegressGetShopInfoReq()
	end

	PlayerReturnConfig.instance:getOpenActivityId()

	if ViewMgr.instance:isOpen(ViewName.BackTask) then
		self:csGetCIGetActInfoReq()
	end
end

function PlayerReturnController:csRegressGetActInfoReq()
	RegressAgent.instance:sendPM_RegressGetActInfoReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadRequestPlayerReturn===back")
		PlayerReturnModel.instance:setOpenActivityInfo(msg.actInfo)
	end, nil, function()
		PlayerReturnModel.instance:setOpenActivityInfo()
	end)
end

function PlayerReturnController:csRegressSetOpenReq()
	RegressAgent.instance:sendPM_RegressSetOpenReq()
end

function PlayerReturnController:csRegressGetSignInInfoReq()
	RegressAgent.instance:sendPM_RegressGetSignInInfoReq(function(msg)
		PlayerReturnModel.instance:setAllSignInfo(msg.prizeGainBits)
	end, nil, function()
		PlayerReturnModel.instance:setAllSignInfo()
	end)
end

function PlayerReturnController:csRegressGainSignInPrizeReq(dayNum)
	RegressAgent.instance:sendPM_RegressGainSignInPrizeReq(dayNum, function(msg)
		PlayerReturnModel.instance:setSingleSignInfo(dayNum)
	end, nil, nil)
end

function PlayerReturnController:csRegressGetTaskInfoReq()
	RegressAgent.instance:sendPM_RegressGetTaskInfoReq(function(msg)
		PlayerReturnModel.instance:setTaskAndScoreInfo(msg)
	end, nil, nil)
end

function PlayerReturnController:csRegressGainTaskScorePrizeReq(scoreId)
	RegressAgent.instance:sendPM_RegressGainTaskScorePrizeReq(scoreId, function(msg)
		PlayerReturnModel.instance:setScoreReceiveById(msg.scoreId)
	end, nil, nil)
end

function PlayerReturnController:csRegressGainTaskPrizeReq(taskId, planId)
	RegressAgent.instance:sendPM_RegressGainTaskPrizeReq(taskId, function(msg)
		PlayerReturnModel.instance:setTaskReceiveById(msg.taskId, planId)
	end, nil, nil)
end

function PlayerReturnController:sendPM_CIGainTypePrizeReq(activityId, prizeId)
	CampaignInviteAgent.instance:sendPM_CIGainTypePrizeReq(activityId, prizeId)
end

function PlayerReturnController:handlePM_CIGainTypePrizeRes(msg)
	PlayerReturnModel.instance:handlePM_CIGainTypePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PR_handlePM_CIGainTypePrizeRes)
end

function PlayerReturnController:csRegressGetShopInfoReq()
	RegressAgent.instance:sendPM_RegressGetShopInfoReq(function(msg)
		PlayerReturnModel.instance:setAllShopBuyInfo(msg.userShopItemInfos)
	end, nil, nil)
end

function PlayerReturnController:csRegressBuyShopItemReq(shopId)
	RegressAgent.instance:sendPM_RegressBuyShopItemReq(shopId, 1, function(msg)
		PlayerReturnModel.instance:setSingleShopBuyInfo(shopId)
	end, nil, nil)
end

function PlayerReturnController:scNotifyRegressBuyGiftRes(msg)
	if msg == nil or msg.shopItemInfo == nil then
		return
	end

	local info = msg.shopItemInfo

	PlayerReturnModel.instance:setSingleShopBuyInfo(info.shopItemId, info.buyCount)
end

function PlayerReturnController:csGetCIGetActInfoReq()
	local actId = PlayerReturnModel.instance.backActId

	if checknumber(actId) <= 0 then
		return
	end

	CampaignInviteAgent.instance:sendPM_CIGetActInfoReq(actId)
end

function PlayerReturnController:csSendCIGetActInfo(msg)
	PlayerReturnModel.instance:csSendCIGetActInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBackTaskBase)
end

function PlayerReturnController:csGetCIGetInviteListReq()
	local actId = PlayerReturnModel.instance.backActId

	if checknumber(actId) <= 0 then
		return
	end

	CampaignInviteAgent.instance:sendPM_CIGetInviteListReq(actId)
end

function PlayerReturnController:csSendCIGetInviteList(list)
	if list == nil or #list == 0 then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataBackInviteList, list)
end

function PlayerReturnController:csGetCIUseCodeReq(code)
	local actId = PlayerReturnModel.instance.backActId

	if checknumber(actId) <= 0 or string.nilorempty(code) then
		return
	end

	CampaignInviteAgent.instance:sendPM_CIUseCodeReq(actId, code)
end

function PlayerReturnController:csSendCIUseCode(msg)
	PlayerReturnModel.instance:csSendCIUseCode(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBackTaskBase)
end

function PlayerReturnController:csGetCIGainPrizeReq(prizeId)
	local actId = PlayerReturnModel.instance.backActId

	if checknumber(actId) <= 0 or checknumber(prizeId) <= 0 then
		return
	end

	CampaignInviteAgent.instance:sendPM_CIGainPrizeReq(actId, prizeId)
end

function PlayerReturnController:csSendCIGainPrize(msg)
	PlayerReturnModel.instance:csSendCIGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBackGainPrize)
end

function PlayerReturnController:csSendCINotifyNewInvite(msg)
	PlayerReturnModel.instance:csSendCINotifyNewInvite(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBackTaskBase)
end

function PlayerReturnController:getPrizeStateOfAct(activityId, prizeId)
	local state = GameEnum.PrizeState.IsNotEnough

	if self:isPrizeHasGainOfAct(prizeId) then
		state = GameEnum.PrizeState.IsHasGain
	elseif self:isEnoughGetPrizeOfAct(activityId, prizeId) then
		state = GameEnum.PrizeState.IsCanGet
	end

	return state
end

function PlayerReturnController:isCanGetPrizeOfAct(activityId, prizeId)
	local isEnough = self:isEnoughGetPrizeOfAct(activityId, prizeId)
	local isHasGain = self:isPrizeHasGainOfAct(prizeId)

	if isEnough and not isHasGain then
		return true
	end

	return false
end

function PlayerReturnController:isEnoughGetPrizeOfAct(activityId, prizeId)
	local result = false
	local data = PlayerReturnConfig.instance:getTypePrizeData(activityId, prizeId)

	if data then
		local cur = self:getActTimes(data.type)
		local need = data.needCount

		result = need <= cur
	end

	return result
end

function PlayerReturnController:isPrizeHasGainOfAct(prizeId)
	local list = PlayerReturnModel.instance:getGainTypePrizeIds()

	return table.indexof(list, prizeId)
end

function PlayerReturnController:getActTimes(_type)
	return PlayerReturnModel.instance:getActTimes(_type)
end

PlayerReturnController.instance = PlayerReturnController.New()

return PlayerReturnController
