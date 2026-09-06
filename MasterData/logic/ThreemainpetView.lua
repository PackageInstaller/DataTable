-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/ThreemainpetView.lua

module("logic.extensions.guidepopup.view.ThreemainpetView", package.seeall)

local ThreemainpetView = class("ThreemainpetView", ViewComponent)

function ThreemainpetView:ctor()
	ThreemainpetView.super.ctor(self)
end

function ThreemainpetView:buildUI()
	ThreemainpetView.super.buildUI(self)

	self._btnSure = self:getBtn("btnClose")
end

function ThreemainpetView:bindEvents()
	ThreemainpetView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ThreemainpetView:unbindEvents()
	ThreemainpetView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function ThreemainpetView:destroyUI()
	ThreemainpetView.super.destroyUI(self)
end

function ThreemainpetView:onEnter()
	ThreemainpetView.super.onEnter(self)
end

function ThreemainpetView:onEnterFinished()
	ThreemainpetView.super.onEnterFinished(self)
end

function ThreemainpetView:onExit()
	ThreemainpetView.super.onExit(self)
end

function ThreemainpetView:onExitFinished()
	ThreemainpetView.super.onExitFinished(self)
end

function ThreemainpetView:_onClickSure()
	self:close()
end

return ThreemainpetView
