-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationDescribeView.lua

module("logic.extensions.islandstation.view.IslandStationDescribeView", package.seeall)

local IslandStationDescribeView = class("IslandStationDescribeView", ViewComponent)

function IslandStationDescribeView:ctor()
	IslandStationDescribeView.super.ctor(self)
end

function IslandStationDescribeView:unbindEvents()
	IslandStationDescribeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCloseDescribe)
end

function IslandStationDescribeView:bindEvents()
	IslandStationDescribeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCloseDescribe, self.close, self)
end

function IslandStationDescribeView:buildUI()
	IslandStationDescribeView.super.buildUI(self)

	self._foodDescribe = self:getGo("foodDescribe")
	self._btnCloseDescribe = self:getGo("btnCloseDescribe")
	self._txtDescribe = self:getTxt("foodDescribe/txtDescribe")
	self._tableview = self:getGo("foodDescribe/tableview")
	self._tablecell = self:getGo("foodDescribe/tableview/tablecell")
	self._foodDescribeScrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateFoodDescribeCell, self), GameUtil.handler(self._clearFoodDescribeCell, self))
end

function IslandStationDescribeView:onExit()
	IslandStationDescribeView.super.onExit(self)
	self._foodDescribeScrollList:dispose()
end

function IslandStationDescribeView:onEnter()
	IslandStationDescribeView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local foodStuffList = params[2]

	self._txtDescribe.text = params[1]

	if foodStuffList then
		self._foodDescribeScrollList:reloadData(foodStuffList)
	end

	GameUtil.SetActive(self._tableview, foodStuffList ~= nil)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._foodDescribe:GetComponent(goutil.Type_RectTransform))
end

function IslandStationDescribeView:_updateFoodDescribeCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtNum.text = ""

	local proxy = MaterialMgr.setCellByCfg(data.materialStr, con)

	proxy.binder:setNumStr(data.num)
end

function IslandStationDescribeView:_clearFoodDescribeCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

return IslandStationDescribeView
