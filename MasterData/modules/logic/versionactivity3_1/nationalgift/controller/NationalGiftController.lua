-- chunkname: @modules/logic/versionactivity3_1/nationalgift/controller/NationalGiftController.lua

module("modules.logic.versionactivity3_1.nationalgift.controller.NationalGiftController", package.seeall)

local NationalGiftController = class("NationalGiftController", BaseController)

function NationalGiftController:onInit()
	self:reInit()
end

function NationalGiftController:reInit()
	self._hasGet = nil
end

function NationalGiftController:onInitFinish()
	return
end

function NationalGiftController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
	PayController.instance:registerCallback(PayEvent.PayFinished, self._onPayCallback, self)
end

function NationalGiftController:_onPayCallback()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if not isGiftHasBuy then
		self._hasGet = nil

		self:_onRefreshActivity()
	end
end

function NationalGiftController:_onDailyRefresh()
	self._hasGet = nil
end

function NationalGiftController:_onRefreshActivity()
	local actId = NationalGiftModel.instance:getCurVersionActId()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return
	end

	local couldGet = actInfoMo:isOnline()

	if couldGet and self._hasGet ~= couldGet then
		Activity212Rpc.instance:sendGetAct212InfoRequest(actId)
	end

	self._hasGet = couldGet
end

function NationalGiftController:openNationalGiftBuyTipView(param)
	ViewMgr.instance:openView(ViewName.NationalGiftBuyTipView, param)
end

NationalGiftController.instance = NationalGiftController.New()

return NationalGiftController
