-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonS2TopView.lua

module("logic.extensions.season.view.mainhud.SeasonS2TopView", package.seeall)

local SeasonS2TopView = class("SeasonS2TopView", ViewComponent)

function SeasonS2TopView:ctor()
	SeasonS2TopView.super.ctor(self)
end

function SeasonS2TopView:buildUI()
	SeasonS2TopView.super.buildUI(self)

	self._btnGuide = self:getBtn("top_guide/btnGuide")
	self._btnFindKeyBag = self:getBtn("rightbottom/btnFindKeyBag")
	self._btn_tip = self:getBtn("btn_tip")
end

function SeasonS2TopView:bindEvents()
	SeasonS2TopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGuide, self._onClickGuide, self)
	GameUtil.addClickHandler(self._btnFindKeyBag, self._onClickFindKeyBag, self)
	self._btn_tip:AddClickListener(self._onClickHelp, self)
end

function SeasonS2TopView:unbindEvents()
	SeasonS2TopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGuide)
	GameUtil.rmClickHandler(self._btnFindKeyBag)
	self._btn_tip:RemoveClickListener()
end

function SeasonS2TopView:destroyUI()
	SeasonS2TopView.super.destroyUI(self)
end

function SeasonS2TopView:onEnter()
	SeasonS2TopView.super.onEnter(self)
	SeasonModePvePlusAgent.instance:sendPM_SMPVEFindKeyInfoReq()
end

function SeasonS2TopView:onExit()
	SeasonS2TopView.super.onExit(self)
end

function SeasonS2TopView:onExitFinished()
	SeasonS2TopView.super.onExitFinished(self)
end

function SeasonS2TopView:_onClickGuide()
	UIStateManager.instance:push(ViewName.SeasonTaskIntroduceView)
end

function SeasonS2TopView:_onClickFindKeyBag()
	UIStateManager.instance:push(ViewName.SeasonFindKeyBagView)
end

function SeasonS2TopView:_onClickHelp()
	TipsFacade.instance:openRulesView("seasonmainview_rules")
end

return SeasonS2TopView
