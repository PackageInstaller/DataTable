-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeTipsView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeTipsView", package.seeall)

local SunWuKongChallengeTipsView = class("SunWuKongChallengeTipsView", ViewComponent)

function SunWuKongChallengeTipsView:ctor()
	SunWuKongChallengeTipsView.super.ctor(self)
end

function SunWuKongChallengeTipsView:buildUI()
	SunWuKongChallengeTipsView.super.buildUI(self)

	self._btnGo = self:getGo("crazyTip")
	self._btnClose = GameUtil.asBtn(self._btnGo)
end

function SunWuKongChallengeTipsView:bindEvents()
	SunWuKongChallengeTipsView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SunWuKongChallengeTipsView:unbindEvents()
	SunWuKongChallengeTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SunWuKongChallengeTipsView:onEnter()
	SunWuKongChallengeTipsView.super.onEnter(self)
end

function SunWuKongChallengeTipsView:onExit()
	SunWuKongChallengeTipsView.super.onExit(self)
end

return SunWuKongChallengeTipsView
