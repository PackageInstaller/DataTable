-- chunkname: @modules/logic/store/view/MonthAndSeasonCardView.lua

module("modules.logic.store.view.MonthAndSeasonCardView", package.seeall)

local MonthAndSeasonCardView = class("MonthAndSeasonCardView", BaseView)
local MonthCardTab = 1
local SeasonCardTab = 2

function MonthAndSeasonCardView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gosubViewParent = gohelper.findChild(self.viewGO, "subViewContainer/#go_subViewParent")
	self._btnSwitch = gohelper.findChildButton(self.viewGO, "#btn_switch")
	self._txtSwitch = gohelper.findChildTextMesh(self.viewGO, "#txt_switch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MonthAndSeasonCardView:addEvents()
	self._btnSwitch:AddClickListener(self.onSwitchClick, self)
end

function MonthAndSeasonCardView:removeEvents()
	self._btnSwitch:RemoveClickListener()
end

function MonthAndSeasonCardView:_editableInitView()
	return
end

function MonthAndSeasonCardView:onUpdateParam()
	return
end

function MonthAndSeasonCardView:onSwitchClick()
	local monthCardId = StoreConfig.instance:getMonthCardStoreChargeId()

	if self._curGoodsId == monthCardId then
		if not SeasonCardTab then
			local nextTabId = MonthCardTab

			self:switchToNext(nextTabId)
		end
	end
end

function MonthAndSeasonCardView:onOpen()
	self.tabId2CardId = {
		[MonthCardTab] = StoreConfig.instance:getMonthCardStoreChargeId(),
		[SeasonCardTab] = StoreConfig.instance:getSeasonCardStoreChargeId()
	}

	local defaultTabId
	local goodsMo = StoreModel.instance:getGoodsMO(self.tabId2CardId[SeasonCardTab])

	self.defaultTabId = (not goodsMo or goodsMo:isSoldOut()) and MonthCardTab or SeasonCardTab

	self:switchToNext(self.defaultTabId, true)
end

function MonthAndSeasonCardView:switchToNext(selectTabId, isOpen)
	local curGoodsId = self.tabId2CardId[selectTabId]
	local goodsMo = StoreModel.instance:getGoodsMO(curGoodsId)

	if not goodsMo or goodsMo:isSoldOut() then
		return
	end

	self._preTabId = self._curTabId
	self._curTabId = selectTabId
	self._curGoodsId = curGoodsId

	local monthCardId = StoreConfig.instance:getMonthCardStoreChargeId()

	if curGoodsId == monthCardId then
		if not SeasonCardTab then
			local nextTabId = MonthCardTab
			local nextGoodsId = self.tabId2CardId[nextTabId]
			local nextGoodsMo = StoreModel.instance:getGoodsMO(nextGoodsId)
			local canSwitch = nextGoodsMo and not nextGoodsMo:isSoldOut()

			gohelper.setActive(self._btnSwitch, canSwitch)
			gohelper.setActive(self._txtSwitch, canSwitch)

			if canSwitch then
				self._txtSwitch.text = nextGoodsMo.config.name
			end

			UIBlockMgr.instance:startBlock(self.viewName .. "SwitchTab")

			if not isOpen then
				local curFirstTabViewList = self.viewContainer._tabViews
				local curFirstTabView = curFirstTabViewList[self.viewContainer._viewStatus]
				local curSecondView = curFirstTabView._tabViews[curFirstTabView._curTabId]
				local curParentView = curSecondView._views[2]
				local curView = curParentView._tabViews[self._preTabId]

				if curView and curView.switchClose then
					curView:switchClose(self._onSwitchCloseAnimDone, self)
				else
					self:_onSwitchCloseAnimDone()
				end
			else
				TaskDispatcher.runDelay(self._onSwitchCloseAnimDone, self, 0.01)
			end
		end
	end
end

function MonthAndSeasonCardView:_onSwitchCloseAnimDone()
	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
	UIBlockMgr.instance:endBlock(self.viewName .. "SwitchTab")
	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 7, self._curTabId)
end

function MonthAndSeasonCardView:getIndexByTabId(tabId)
	return self._curTabId
end

function MonthAndSeasonCardView:onClose()
	return
end

function MonthAndSeasonCardView:onDestroyView()
	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
end

return MonthAndSeasonCardView
