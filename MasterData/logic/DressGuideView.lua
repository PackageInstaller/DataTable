-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressguide/DressGuideView.lua

module("logic.extensions.dressguide.DressGuideView", package.seeall)

local DressGuideView = class("DressGuideView", ViewComponent)

function DressGuideView:ctor()
	DressGuideView.super.ctor(self)
end

function DressGuideView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnDress:AddClickListener(self._onClickDress, self)
end

function DressGuideView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnDress:RemoveClickListener()
end

function DressGuideView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnDress = self:getBtn("btnDress")
end

function DressGuideView:destroyUI()
	return
end

function DressGuideView:onEnter()
	return
end

function DressGuideView:onEnterFinished()
	return
end

function DressGuideView:onExit()
	return
end

function DressGuideView:onExitFinished()
	return
end

function DressGuideView:_onClickClose()
	UIStateManager.instance:pop()
end

function DressGuideView:_onClickDress()
	ClothesAgent.instance:sendSetMyAvatarReq({
		1
	}, self._onClickClose, self)
end

return DressGuideView
