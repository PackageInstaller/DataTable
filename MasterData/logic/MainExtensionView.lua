-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainExtensionView.lua

module("logic.extensions.mainui.view.MainExtensionView", package.seeall)

local MainExtensionView = class("MainExtensionView", ViewComponent)

function MainExtensionView:ctor()
	MainExtensionView.super.ctor(self)
end

function MainExtensionView:unbindEvents()
	MainExtensionView.super.unbindEvents(self)
end

function MainExtensionView:bindEvents()
	MainExtensionView.super.bindEvents(self)
end

function MainExtensionView:buildUI()
	MainExtensionView.super.buildUI(self)

	self._extensionGo = self:getGo("extension")
end

function MainExtensionView:onEnter()
	MainExtensionView.super.onEnter(self)
	settimer(1, self._onSecond, self)
end

function MainExtensionView:onExit()
	MainExtensionView.super.onExit(self)
	removetimer(self._onSecond, self)
end

function MainExtensionView:_onSecond()
	if not ViewMgr.instance:isOpen(ViewName.SpringRedPackHudView) and SpringRedPackController.instance:isInActivityTime() then
		self:showTabAt(self._extensionGo, ViewName.SpringRedPackHudView)
	end
end

return MainExtensionView
