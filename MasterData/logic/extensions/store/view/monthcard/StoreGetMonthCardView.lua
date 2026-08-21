-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/monthcard/StoreGetMonthCardView.lua

module("logic.extensions.store.view.monthcard.StoreGetMonthCardView", package.seeall)

local M = class("StoreGetMonthCardView", ViewComponent)

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._btnClose = self:getBtn("store_prime_member_open_tips_-876487488")
	self._txtLastDay = self:getText("store_prime_member_open_tips_-2073976009")
	self._txtRemain = self:getText("store_prime_member_open_tips_388681809")
	self._txtNextDay = self:getText("store_prime_member_open_tips_535351453")
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateMonthView, self)
		GlobalDispatcher:addEventListener(EventType.STORE_STATE_CODE_ERROR, self._handleStoreErrorCode, self)
		GlobalDispatcher:addEventListener(EventType.ON_TAKE_MONTH_CARD_REWARD, self._handleOnTakeMonthCardReward, self)
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updateMonthView, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_STATE_CODE_ERROR, self._handleStoreErrorCode, self)
		GlobalDispatcher:removeEventListener(EventType.ON_TAKE_MONTH_CARD_REWARD, self._handleOnTakeMonthCardReward, self)
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.onClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._canvasGroup.interactable = false

	self:_setEvent(true)

	local storeList = StoreModel.instance:getStoresByStoreType(StoreEnum.MallType.MonthyCard)

	self._storeMo = storeList[1]

	StoreAgent.instance:sendGetGoodsListRequest({
		self._storeMo:getId()
	})
end

function M:onExit()
	self._canvasGroup.interactable = false

	self:_setEvent(false)

	local info = self:getFirstParam() or {}

	if info.openByPopUp then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_VIEW_EXIT)
	end
end

function M:_handleStoreErrorCode()
	self._canvasGroup.interactable = true
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "open" then
		StoreAgent.instance:sendTryTakeMonthlyCardRewardRequest(self._goodsMo:getGoodsId())
	end
end

function M:_handleOnTakeMonthCardReward(e, status)
	local popUp = SigninController.instance:tryPopUpCacheSignInReward(function()
		settimer(0.1, self.onClose, self, false)
	end, self)

	if not popUp then
		self:close()
	end
end

function M:_updateMonthView()
	local goods = StoreModel.instance:getGoodsList(self._storeMo:getTabId(), self._storeMo:getId())

	self._goodsMo = goods[1]

	if not self._goodsMo then
		self:_handleStoreErrorCode()

		return
	end

	local remainedDay = self._goodsMo:getRemainedDay()

	self._txtRemain.text = remainedDay
	self._txtLastDay.text = remainedDay - 1
	self._txtNextDay.text = remainedDay + 1
end

function M:onClose()
	self:close()
end

return M
