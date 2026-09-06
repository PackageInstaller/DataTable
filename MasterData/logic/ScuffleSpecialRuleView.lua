-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleSpecialRuleView.lua

module("logic.extensions.scuffle.view.ScuffleSpecialRuleView", package.seeall)

local ScuffleSpecialRuleView = class("ScuffleSpecialRuleView", ViewComponent)

function ScuffleSpecialRuleView:ctor()
	ScuffleSpecialRuleView.super.ctor(self)
end

function ScuffleSpecialRuleView:buildUI()
	ScuffleSpecialRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnL = self:getBtn("btnL")
	self._btnR = self:getBtn("btnR")
	self._imgRule = self:getGo("imgRule")
end

function ScuffleSpecialRuleView:bindEvents()
	ScuffleSpecialRuleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnL:AddClickListener(self._onClickLeft, self)
	self._btnR:AddClickListener(self._onClickRight, self)
end

function ScuffleSpecialRuleView:unbindEvents()
	ScuffleSpecialRuleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnL:RemoveClickListener()
	self._btnR:RemoveClickListener()
end

function ScuffleSpecialRuleView:onEnter()
	ScuffleSpecialRuleView.super.onEnter(self)

	self._iconPathList = ScuffleSpecialRuleViewPresentor.IconPath
	self._curPage = 1

	goutil.setActive(self._btnL.gameObject, false)
	goutil.setActive(self._btnR.gameObject, true)
	uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, self._iconPathList[self._curPage])
end

function ScuffleSpecialRuleView:onExit()
	ScuffleSpecialRuleView.super.onExit(self)
end

function ScuffleSpecialRuleView:_onClickClose()
	self:close()
end

function ScuffleSpecialRuleView:_onClickLeft()
	if self._curPage == 2 then
		self._curPage = 1

		goutil.setActive(self._btnL.gameObject, false)
		goutil.setActive(self._btnR.gameObject, true)
		uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, self._iconPathList[self._curPage])
	else
		goutil.setActive(self._btnL.gameObject, false)
		goutil.setActive(self._btnR.gameObject, true)
	end
end

function ScuffleSpecialRuleView:_onClickRight()
	if self._curPage == 1 then
		self._curPage = 2

		goutil.setActive(self._btnL.gameObject, true)
		goutil.setActive(self._btnR.gameObject, false)
		uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, self._iconPathList[self._curPage])
	else
		goutil.setActive(self._btnL.gameObject, true)
		goutil.setActive(self._btnR.gameObject, false)
	end
end

return ScuffleSpecialRuleView
