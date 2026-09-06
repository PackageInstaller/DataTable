-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderShopEventView.lua

module("logic.extensions.exploreunder.view.ExploreUnderShopEventView", package.seeall)

local ExploreUnderShopEventView = class("ExploreUnderShopEventView", ViewComponent)

function ExploreUnderShopEventView:buildUI()
	ExploreUnderShopEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGoto = self:getGo("btnGoto")
end

function ExploreUnderShopEventView:bindEvents()
	ExploreUnderShopEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function ExploreUnderShopEventView:unbindEvents()
	ExploreUnderShopEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function ExploreUnderShopEventView:onEnter()
	ExploreUnderShopEventView.super.onEnter(self)

	self._isOnlyShow = checkbool(self:getFirstParam())

	goutil.setActive(self._btnGoto, not self._isOnlyShow)
end

function ExploreUnderShopEventView:_onClickGoto()
	self:close()
	UIStateManager.instance:push(ViewName.ExploreUnderShopView)
end

return ExploreUnderShopEventView
