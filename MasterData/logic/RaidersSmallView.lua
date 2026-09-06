-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/raiders/RaidersSmallView.lua

module("logic.extensions.legend.view.raiders.RaidersSmallView", package.seeall)

local RaidersSmallView = class("RaidersSmallView", FlyTweenBase)

function RaidersSmallView:ctor()
	RaidersSmallView.super.ctor(self)
end

function RaidersSmallView:buildUI()
	RaidersSmallView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
end

function RaidersSmallView:bindEvents()
	RaidersSmallView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function RaidersSmallView:unbindEvents()
	RaidersSmallView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function RaidersSmallView:onEnter()
	RaidersSmallView.super.onEnter(self)

	local param = self:getOpenParam()

	self:_setUIFlyTweenParam(param[2])
end

function RaidersSmallView:onExit()
	RaidersSmallView.super.onExit(self)
end

function RaidersSmallView:_onClickClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

return RaidersSmallView
