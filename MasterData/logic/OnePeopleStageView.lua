-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/onepeople/OnePeopleStageView.lua

module("logic.extensions.scenariocopy.view.onepeople.OnePeopleStageView", package.seeall)

local OnePeopleStageView = class("OnePeopleStageView", ScmainStageView)

function OnePeopleStageView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._txtProgress = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("condition/txtDesc"):GetComponent(goutil.Type_UIText)
	self._txtRecmdPower = self:getGo("fightpower/txtRecmdPower"):GetComponent(goutil.Type_UIText)
	self._btnAuto = self:getBtn("btnAuto")
	self._btnStart = self:getBtn("btnStart")
	self._costPower = self:getGo("costPower")
	self._txtCostNum = self:getGo("costPower/txtCostNum"):GetComponent(goutil.Type_UIText)
	self._txtBtnStartName = self:getGo("btnStart/Text"):GetComponent(goutil.Type_UIText)
	self._iconPower = self:getGo("costPower/Icon")
	self._tableGo = self:getGo("normalPrize/tableview")
	self._tableCell = self:getGo("normalPrize/tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableCell:SetActive(false)

	self._txtPassDesc = self:getTxt("condition2/txtDesc")
	self._btnSpecialStart = self:getBtn("btnSpecialStart")
end

function OnePeopleStageView:bindEvents()
	OnePeopleStageView.super.bindEvents(self)
	self._btnSpecialStart:AddClickListener(self._onClickStart, self)
end

function OnePeopleStageView:unbindEvents()
	OnePeopleStageView.super.unbindEvents(self)
	self._btnSpecialStart:RemoveClickListener()
end

function OnePeopleStageView:_setBtnStart(isPass)
	OnePeopleStageView.super._setBtnStart(self, isPass)
	self._btnSpecialStart.gameObject:SetActive(not isPass)
	self._btnStart.gameObject:SetActive(isPass)
end

return OnePeopleStageView
