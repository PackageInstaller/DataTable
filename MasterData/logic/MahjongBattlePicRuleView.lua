-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattlePicRuleView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattlePicRuleView", package.seeall)

local MahjongBattlePicRuleView = class("MahjongBattlePicRuleView", ViewComponent)

function MahjongBattlePicRuleView:ctor()
	MahjongBattlePicRuleView.super.ctor(self)
end

function MahjongBattlePicRuleView:unbindEvents()
	MahjongBattlePicRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._tabList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function MahjongBattlePicRuleView:bindEvents()
	MahjongBattlePicRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, cell in ipairs(self._tabList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, i), self)
	end
end

function MahjongBattlePicRuleView:buildUI()
	MahjongBattlePicRuleView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tabList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("tablist/btn" .. i)
		cell.UIChangeGroup = cell.go:GetComponent("UIChangeGroup")

		table.insert(self._tabList, cell)
	end

	self._con1 = self:getGo("con1")
	self._con2 = self:getGo("con2")
	self._con3 = self:getGo("con3")
end

function MahjongBattlePicRuleView:onExit()
	MahjongBattlePicRuleView.super.onExit(self)
end

function MahjongBattlePicRuleView:onEnter()
	MahjongBattlePicRuleView.super.onEnter(self)
	self:_onClickTab(1)
end

function MahjongBattlePicRuleView:_onClickTab(index)
	for i, cell in ipairs(self._tabList) do
		cell.UIChangeGroup:SetState(i == index and 0 or 1)
	end

	goutil.setActive(self._con1, index == 1)
	goutil.setActive(self._con2, index == 2)
	goutil.setActive(self._con3, index == 3)
end

return MahjongBattlePicRuleView
