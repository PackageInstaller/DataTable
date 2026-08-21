-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/record/AirWorkShowKillView.lua

module("logic.extensions.airworkshop.flow.defflow.view.record.AirWorkShowKillView", package.seeall)

local M = class("AirWorkShowKillView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtPosition = goutil.findChildTextComponent(self.mainGO, "imgDi/txtPosition")
	self._txtNumber = goutil.findChildTextComponent(self.mainGO, "imgDi/txtNum")
	self._scrollRectGo = goutil.findChild(self.mainGO, "imgDi/scrollView")
	self._loopList = LoopListHelper.New(self._scrollRectGo)

	self._loopList:InitListView(0, self._updateCell, self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for i, v in ipairs(self._itemViewList or {}) do
		v:_unbindEvents()
	end

	self._itemViewList = false
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_CELL_KILLDATA_CHANGE, self._refresh, self)

	self._data = self:getFirstParam()

	self:_setData()
end

function M:onExitFinished()
	GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_CELL_KILLDATA_CHANGE, self._refresh, self)
end

function M:destroyUI()
	return
end

function M:_refresh(e, cellKillData)
	self._data = cellKillData

	self:_setData()
end

function M:_setData()
	if not self._data then
		return
	end

	self._txtPosition.text = string.format("(%s,%s)", self._data:getPosition())
	self._txtNumber.text = self._data:getCount()
	self._moList = self._data:getRecord()

	if not self._moList then
		return
	end

	printWarn("=====_setData=====", #self._moList)

	self._itemViewList = {}

	local itemCount = #self._moList

	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("item1")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkShowKillItem)
	local mo = self._moList[curIndex]

	itemView:updateData(mo)
	table.insert(self._itemViewList, itemView)

	return item
end

return M
