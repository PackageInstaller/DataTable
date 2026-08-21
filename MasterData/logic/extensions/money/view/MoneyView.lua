-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/view/MoneyView.lua

module("logic.extensions.money.view.MoneyView", package.seeall)

local MoneyShowType = CommEnum.MoneyShowType
local M = class("MoneyView", ViewComponent)

function M:ctor(moneyShowType, topCurrencyGo, isNewIcon)
	self._moneyShowType = moneyShowType or MoneyShowType.MoneyGeneralShowType
	self._topCurrencyGo = topCurrencyGo
	self._isNewIcon = isNewIcon
	self._moneyItemList = {}
	self._hasInit = false
end

function M:buildUI()
	if not self._topCurrencyGo then
		self._topCurrencyGo = self:getGoByPath("top_currency")
	end

	local moneyInfo = MoneyUtil.getMoneyInfoByShowType(self._moneyShowType)

	if not moneyInfo.defaultHide and not self._hasInit then
		self:_createMoneyItem(moneyInfo.moneyCodes)
	end
end

function M:destroyUI()
	self:setEvent(false)

	for k, v in ipairs(self._moneyItemList or {}) do
		v:unbindEvents()
	end
end

function M:bindEvents()
	self:registerLocalNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, self._handleOnUpdateMoneyViewShow, self)
	self:registerLocalNotify(EventType.UPDATA_TOP_MONEY_VALUE, self._handleOnUpdateMoneyValue, self)
end

function M:unbindEvents()
	self:unregisterLocalNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, self._handleOnUpdateMoneyViewShow, self)
	self:unregisterLocalNotify(EventType.UPDATA_TOP_MONEY_VALUE, self._handleOnUpdateMoneyValue, self)
end

function M:onEnter()
	self:setEvent(true)
	self:_updateValue()

	for k, v in ipairs(self._moneyItemList) do
		v:onEnter()
	end
end

function M:onExit()
	self:setEvent(false)

	for k, v in ipairs(self._moneyItemList) do
		v:onExit()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemCostEvent, self)
		GlobalDispatcher:addEventListener(EventType.SET_TOP_COST_STATE_EVENT, self._handleCostItemEvent, self)
		GlobalDispatcher:addEventListener(MoneyEventType.MONEY_ITEM_HINT_CHANGE, self._handleMoneyItemHintChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemCostEvent, self)
		GlobalDispatcher:removeEventListener(EventType.SET_TOP_COST_STATE_EVENT, self._handleCostItemEvent, self)
		GlobalDispatcher:removeEventListener(MoneyEventType.MONEY_ITEM_HINT_CHANGE, self._handleMoneyItemHintChange, self)
	end
end

function M:_handleOnUpdateMoneyViewShow(key, showType, codeList)
	for k, v in ipairs(self._moneyItemList) do
		v:onExit()
	end

	table.clear(self._moneyItemList)
	self:clearCurrencyChildren()

	if showType == nil and codeList ~= nil then
		local moneyCodes = MoneyUtil.getMoneyInfoList(codeList)

		self:_createMoneyItem(moneyCodes)
		self:_updateValue()

		return
	end

	self._moneyShowType = showType or MoneyShowType.MoneyGeneralShowType

	local moneyInfo = MoneyUtil.getMoneyInfoByShowType(self._moneyShowType)

	if not moneyInfo.defaultHide then
		self:_createMoneyItem(moneyInfo.moneyCodes)
		self:_updateValue()
	end
end

function M:_handleOnUpdateMoneyValue(e)
	if self._moneyShowType then
		local moneyInfo = MoneyUtil.getMoneyInfoByShowType(self._moneyShowType)

		if not moneyInfo.defaultHide then
			self:_updateValue()
		end
	end
end

function M:clearCurrencyChildren()
	if not goutil.isNil(self._topCurrencyGo) then
		goutil.clearChildren(self._topCurrencyGo)
	end
end

function M:_handleItemCostEvent()
	self:_updateValue()
end

function M:_handleCostItemEvent(code, state, showType)
	goutil.setActive(self._topCurrencyGo, state)

	if not self._hasInit and state then
		self._moneyItemList = {}
		self._moneyShowType = showType or self._moneyShowType

		local moneyInfo = MoneyUtil.getMoneyInfoByShowType(self._moneyShowType)

		self:_createMoneyItem(moneyInfo.moneyCodes)

		for k, v in ipairs(self._moneyItemList) do
			v:updateData()
		end
	end
end

function M:_handleMoneyItemHintChange(e, code, hintStr)
	for k, v in ipairs(self._moneyItemList) do
		if v:getNeedHint() and v:getMoneyCode() == code then
			v:updateTxtHint(hintStr)
		end
	end
end

function M:_createMoneyItem(codesDefine)
	self._hasInit = true

	local currencyGo = false
	local itemView = false

	for k, v in ipairs(codesDefine) do
		currencyGo = self:getResInstance(CommonResPath.Url_Currency_Item)

		if currencyGo then
			local creator = v.creator or MoneyGeneralItem.New

			itemView = creator(currencyGo, v.code)

			itemView:setMoneyIconPath(v.src)
			itemView:setMoneyShowType(self._moneyShowType)
			itemView:updateTxtHint(nil)
			itemView:setNeedHint(v.hint)
			itemView:setAddBtnVisible(v.addBtn)
			itemView:setJumpBtnVisible(not v.hideJumpBtn)
			itemView:setJumpBtnPassEvent(v.jumpBtnPassEvent)
			itemView:onEnter()
			table.insert(self._moneyItemList, itemView)
			goutil.addChildToParent(currencyGo, self._topCurrencyGo)
		else
			printError("无法获取顶部资源Item预制，请检查Presentor有depend")
		end
	end
end

function M:_updateValue()
	for k, v in ipairs(self._moneyItemList) do
		v:updateData()
	end
end

function M:printStatus()
	printWarn(string.format("[%s] showType[%s] init[%s] itemCount=%s", self._viewPresentor:getViewName(), self._moneyShowType, self._hasInit, #self._moneyItemList))

	for k, v in ipairs(self._moneyItemList) do
		v:printStatus()
	end
end

function M:getMoneyItemList()
	return self._moneyItemList or {}
end

return M
