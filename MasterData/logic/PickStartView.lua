-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickStartView.lua

module("logic.extensions.pickapet.view.PickStartView", package.seeall)

local PickStartView = class("PickStartView", ViewComponent)

function PickStartView:ctor()
	PickStartView.super.ctor(self)
end

function PickStartView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PickStartView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function PickStartView:buildUI()
	self._closeButton = self:getBtn("Btn_start")
end

function PickStartView:destroyUI()
	return
end

function PickStartView:onEnter()
	return
end

function PickStartView:onEnterFinished()
	return
end

function PickStartView:onExit()
	return
end

function PickStartView:onExitFinished()
	return
end

function PickStartView:_onClickClose()
	UIStateManager.instance:push("pickAPetView", 1)
end

return PickStartView
