-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/HappylemonView.lua

module("logic.extensions.bonus.view.HappylemonView", package.seeall)

local HappylemonView = class("HappylemonView", ViewComponent)

function HappylemonView:ctor()
	HappylemonView.super.ctor(self)
end

function HappylemonView:bindEvents()
	HappylemonView.super.bindEvents(self)
	self._btnGame:AddClickListener(self._onClickbtnGame, self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
	self._btnPet:AddClickListener(self._onClickbtnPet, self)
end

function HappylemonView:unbindEvents()
	HappylemonView.super.unbindEvents(self)
	self._btnGame:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnPet:RemoveClickListener()
end

function HappylemonView:buildUI()
	HappylemonView.super.buildUI(self)

	self._btnGame = self:getBtn("btnGame")
	self._btnRule = self:getBtn("btnRule")
	self._btnPet = self:getBtn("btnPet")
end

function HappylemonView:destroyUI()
	HappylemonView.super.destroyUI(self)
end

function HappylemonView:onEnter()
	HappylemonView.super.onEnter(self)
	BounsModel.instance:setHappyLemonClick()

	if BounsModel.instance:checkHappyLemonDot() then
		GlobalDispatcher:dispatch(GlobalNotify.BounsRedPointUpdate)
	end
end

function HappylemonView:onExit()
	HappylemonView.super.onExit(self)
end

function HappylemonView:_onClickbtnGame()
	SurveyController.instance:reportBehavior(200420)
	FuncOpenController.instance:openFunc(16)
end

function HappylemonView:_onClickbtnRule()
	SurveyController.instance:reportBehavior(200418)
	TipsFacade.instance:openRulesView("happylemon")
end

function HappylemonView:_onClickbtnPet()
	SurveyController.instance:reportBehavior(200419)
	UIStateManager.instance:push(ViewName.PigskinselectView)
end

return HappylemonView
