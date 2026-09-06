-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleRuleView.lua

module("logic.extensions.scuffle.view.ScuffleRuleView", package.seeall)

local ScuffleRuleView = class("ScuffleRuleView", ViewComponent)

function ScuffleRuleView:ctor()
	ScuffleRuleView.super.ctor(self)
end

function ScuffleRuleView:buildUI()
	ScuffleRuleView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tabBtn1 = self:getBtn("tabLeft/tabBtn1")
	self._tabBtn2 = self:getBtn("tabLeft/tabBtn2")
	self._tabBg1 = self:getGo("tabLeft/tabBtn1/tabBg")
	self._tabBg2 = self:getGo("tabLeft/tabBtn2/tabBg")
	self._colorChange1 = self:getGo("tabLeft/tabBtn1/txtTab"):GetComponent(typeof(UITextColorChange))
	self._colorChange2 = self:getGo("tabLeft/tabBtn2/txtTab"):GetComponent(typeof(UITextColorChange))
	self._baseRule = self:getGo("baseRule")
	self._levelRule = self:getGo("levelRule")
	self._txtBaseRule = self:getTxt("baseRule/txtscrollContent/viewport/content/txtBaseRule")
end

function ScuffleRuleView:bindEvents()
	ScuffleRuleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._tabBtn1:AddClickListener(self._onClickTab1, self)
	self._tabBtn2:AddClickListener(self._onClickTab2, self)
end

function ScuffleRuleView:unbindEvents()
	ScuffleRuleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._tabBtn1:RemoveClickListener()
	self._tabBtn2:RemoveClickListener()
end

function ScuffleRuleView:onExit()
	ScuffleRuleView.super.onExit(self)
end

function ScuffleRuleView:onEnter()
	ScuffleRuleView.super.onEnter(self)
	self:_setRuleDesc()
	self:_changeTab(1)
end

function ScuffleRuleView:_onClickClose()
	self:close()
end

function ScuffleRuleView:_onClickTab1()
	self:_changeTab(1)
end

function ScuffleRuleView:_onClickTab2()
	self:_changeTab(2)
end

function ScuffleRuleView:_changeTab(index)
	self._tabBg1:SetActive(index == 1)
	self._tabBg2:SetActive(index == 2)
	self._colorChange1:SetState(index == 1 and 1 or 0)
	self._colorChange2:SetState(index == 2 and 1 or 0)
	self._baseRule:SetActive(index == 1)
	self._levelRule:SetActive(index == 2)
end

function ScuffleRuleView:_setRuleDesc()
	self._txtBaseRule.text = ScuffleConfig.instance:getCommonValueByKey("ACTIVITY_RULE")
end

return ScuffleRuleView
