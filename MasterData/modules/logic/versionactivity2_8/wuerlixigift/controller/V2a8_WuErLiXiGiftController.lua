-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/controller/V2a8_WuErLiXiGiftController.lua

module("modules.logic.versionactivity2_8.wuerlixigift.controller.V2a8_WuErLiXiGiftController", package.seeall)

local V2a8_WuErLiXiGiftController = class("V2a8_WuErLiXiGiftController", BaseController)

function V2a8_WuErLiXiGiftController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function V2a8_WuErLiXiGiftController:_checkActivityInfo()
	self:getV2a8_WuErLiXiGiftActivityInfo()
end

function V2a8_WuErLiXiGiftController:getV2a8_WuErLiXiGiftActivityInfo(cb, cbObj)
	local isOpen = V2a8_WuErLiXiGiftModel.instance:isV2a8_WuErLiXiGiftOpen()

	if not isOpen then
		return
	end

	local actId = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, cb, cbObj)
end

function V2a8_WuErLiXiGiftController:openV2a8_WuErLiXiGiftView()
	self.getV2a8_WuErLiXiGiftActivityInfo(self, self._realOpenV2a8_WuErLiXiGiftView, self)
end

function V2a8_WuErLiXiGiftController:_realOpenV2a8_WuErLiXiGiftView()
	ViewMgr.instance:openView(ViewName.V2a8_WuErLiXiGiftView)
end

function V2a8_WuErLiXiGiftController:receiveV2a8_WuErLiXiGift(cb, cbObj)
	local isOpen = V2a8_WuErLiXiGiftModel.instance:isV2a8_WuErLiXiGiftOpen()

	if not isOpen then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local actId = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local index = V2a8_WuErLiXiGiftModel.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if canReceive then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index, cb, cbObj)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

V2a8_WuErLiXiGiftController.instance = V2a8_WuErLiXiGiftController.New()

return V2a8_WuErLiXiGiftController
