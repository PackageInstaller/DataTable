-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerTaskView.lua

module("logic.extensions.disorderpower.view.DisOrderPowerTaskView", package.seeall)

local DisOrderPowerTaskView = class("DisOrderPowerTaskView", EventTaskTabFrameView)

function DisOrderPowerTaskView:ctor()
	DisOrderPowerTaskView.super.ctor(self)
end

function DisOrderPowerTaskView:unbindEvents()
	DisOrderPowerTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose, self.close, self)
end

function DisOrderPowerTaskView:bindEvents()
	DisOrderPowerTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DisOrderPowerTaskView:buildUI()
	DisOrderPowerTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
end

function DisOrderPowerTaskView:onExit()
	DisOrderPowerTaskView.super.onExit(self)
end

function DisOrderPowerTaskView:onEnter()
	DisOrderPowerTaskView.super.onEnter(self)
end

return DisOrderPowerTaskView
