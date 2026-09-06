-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroResultFailView.lua

module("logic.extensions.miraclehero.view.MiracleHeroResultFailView", package.seeall)

local MiracleHeroResultFailView = class("MiracleHeroResultFailView", ViewComponent)

function MiracleHeroResultFailView:ctor()
	MiracleHeroResultFailView.super.ctor(self)
end

function MiracleHeroResultFailView:unbindEvents()
	MiracleHeroResultFailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MiracleHeroResultFailView:bindEvents()
	MiracleHeroResultFailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function MiracleHeroResultFailView:buildUI()
	MiracleHeroResultFailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
end

function MiracleHeroResultFailView:onExit()
	MiracleHeroResultFailView.super.onExit(self)
end

function MiracleHeroResultFailView:onEnter()
	MiracleHeroResultFailView.super.onEnter(self)
end

function MiracleHeroResultFailView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroBattleEnd)
	self:close()
end

return MiracleHeroResultFailView
