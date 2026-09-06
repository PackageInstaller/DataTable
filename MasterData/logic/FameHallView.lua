-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/FameHallView.lua

module("logic.extensions.famehall.view.FameHallView", package.seeall)

local FameHallView = class("FameHallView", ViewComponent)

function FameHallView:ctor()
	FameHallView.super.ctor(self)
end

function FameHallView:unbindEvents()
	FameHallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function FameHallView:bindEvents()
	FameHallView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function FameHallView:buildUI()
	FameHallView.super.buildUI(self)

	self._container = self:getGo("container")
	self._btnClose = self:getGo("btnClose")
	self._btnRule = self:getGo("title/btnRule")
	self._tableView = self:getGo("tableview")
	self._tableCell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updataCell, self), GameUtil.handler(self._clearCell, self))
	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))
end

function FameHallView:onExit()
	FameHallView.super.onExit(self)
end

function FameHallView:onEnter()
	FameHallView.super.onEnter(self)

	local enterTab = checknumber(self:getFirstParam())

	if enterTab == 0 then
		enterTab = 1
	end

	self._curTabId = 0

	self._commonTab:clearAllData()

	for i, data in ipairs(FameHallConfig.instance:getTabList()) do
		if checknumber(data.rootTabId) == 0 then
			local obj = self._commonTab:addTabData(data.name, data)
		end
	end

	for i, data in ipairs(FameHallConfig.instance:getTabList()) do
		if checknumber(data.rootTabId) ~= 0 then
			local obj = self._commonTab:addTabData(data.name, data, data.rootTabId)
		end
	end

	self:_onClickTab(enterTab)
end

function FameHallView:refreshView()
	self:showTabAt(self._container)

	local curTabCfg = FameHallConfig.instance:getTabCfg(self._curTabId)

	if curTabCfg then
		self:showTabAt(self._container, curTabCfg.viewname, curTabCfg)
	end
end

function FameHallView:_updataCell(view, cell, data, tag)
	local go = cell.gameObject
	local uiChangeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = data.name

	local isSelect = data.tabId == self._curTabId

	if isSelect == true then
		uiChangeGroup:SetState(1)
	else
		uiChangeGroup:SetState(0)
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickTab(data.tabId)
	end, self)
end

function FameHallView:_clearCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function FameHallView:_onClickTab(tabId)
	self._curTabId = tabId

	local curTabCfg = FameHallConfig.instance:getTabCfg(self._curTabId)

	self._commonTab:jumpTabByData(curTabCfg)
end

function FameHallView:_onClickRule()
	TipsFacade.instance:openRulesView("fame_hall_rule")
end

function FameHallView:_onUpdateExtCell(view, cell, tabData, tag)
	return
end

function FameHallView:_onUpdateRight(tabData)
	self._curTabId = 0

	if tabData then
		local data = tabData.data

		self._curTabId = data.tabId
	end

	self:refreshView()
end

return FameHallView
