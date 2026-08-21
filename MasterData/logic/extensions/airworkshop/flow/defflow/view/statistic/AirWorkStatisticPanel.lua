-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/statistic/AirWorkStatisticPanel.lua

module("logic.extensions.airworkshop.flow.defflow.view.statistic.AirWorkStatisticPanel", package.seeall)

local M = class("AirWorkStatisticPanel")

function M:ctor(container)
	self._go = container.gameObject
	self._emptyGo = goutil.findChild(self._go, "txtNull")
	self._scrollRectGo = goutil.findChild(self._go, "scrollView")
	self._contentGo = goutil.findChild(self._scrollRectGo, "viewPort/content")
	self._loopList = LoopListHelper.New(self._scrollRectGo)

	self._loopList:InitListView(0, self._updateCell, self)
	self:_bindEvents()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	for i, v in ipairs(self._itemViewList or {}) do
		v:_unbindEvents()
	end
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:onEnter(data, index)
	self._moList = data
	self._tabIndex = index
	self._isKill = self._tabIndex == 2

	self:_setData()
end

function M:onExit()
	return
end

function M:_setData()
	if not self._moList then
		goutil.setActive(self._emptyGo, true)

		return
	end

	self._itemViewList = {}

	local itemCount = #self._moList

	printWarn("=====_setData=====", itemCount)
	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()
	goutil.setActive(self._emptyGo, itemCount == 0)
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("item1")
	local itemView

	if self._tabIndex == 1 then
		itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkStatisticAttackItem)
	else
		itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkStatisticDefendItem)
	end

	local mo = self._moList[curIndex]

	itemView:updateData(mo, self._isKill)
	table.insert(self._itemViewList, itemView)

	return item
end

return M
