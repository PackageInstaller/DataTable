-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetsPhotographView.lua

module("logic.extensions.petshandbook.view.PetsPhotographView", package.seeall)

local PetsPhotographView = class("PetsPhotographView", ViewComponent)

function PetsPhotographView:ctor()
	PetsPhotographView.super.ctor(self)
end

function PetsPhotographView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetsPhotographView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function PetsPhotographView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
end

function PetsPhotographView:destroyUI()
	return
end

function PetsPhotographView:onEnter()
	return
end

function PetsPhotographView:onEnterFinished()
	return
end

function PetsPhotographView:onExit()
	return
end

function PetsPhotographView:onExitFinished()
	return
end

function PetsPhotographView:_onClickClose()
	UIStateManager.instance:pop()
end

return PetsPhotographView
