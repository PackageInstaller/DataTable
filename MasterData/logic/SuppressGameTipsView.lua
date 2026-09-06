-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameTipsView.lua

module("logic.extensions.suppressgame.view.SuppressGameTipsView", package.seeall)

local SuppressGameTipsView = class("SuppressGameTipsView", ViewComponent)

function SuppressGameTipsView:buildUI()
	SuppressGameTipsView.super.buildUI(self)

	self._clickMask = goutil.findChild(self.mainGO, "clickMask")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "content/scrollerview/Viewport/Content/txt")
end

function SuppressGameTipsView:bindEvents()
	SuppressGameTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._clickMask, self._onClickMask, self)
end

function SuppressGameTipsView:unbindEvents()
	SuppressGameTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._clickMask)
end

function SuppressGameTipsView:onEnter()
	SuppressGameTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._contentStr = params[1]

	self:_onSetUI()
end

function SuppressGameTipsView:onExit()
	SuppressGameTipsView.super.onExit(self)
end

function SuppressGameTipsView:_onSetUI()
	self._txtContent.text = self._contentStr
end

function SuppressGameTipsView:_onClickMask()
	self:close()
end

return SuppressGameTipsView
