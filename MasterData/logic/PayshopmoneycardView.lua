-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopmoneycardView.lua

module("logic.extensions.payshop.view.PayshopmoneycardView", package.seeall)

local PayshopmoneycardView = class("PayshopmoneycardView", ViewComponent)

function PayshopmoneycardView:ctor()
	PayshopmoneycardView.super.ctor(self)
end

function PayshopmoneycardView:buildUI()
	PayshopmoneycardView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
end

function PayshopmoneycardView:bindEvents()
	PayshopmoneycardView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function PayshopmoneycardView:unbindEvents()
	PayshopmoneycardView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function PayshopmoneycardView:destroyUI()
	PayshopmoneycardView.super.destroyUI(self)
end

function PayshopmoneycardView:onEnter()
	PayshopmoneycardView.super.onEnter(self)
end

function PayshopmoneycardView:onEnterFinished()
	PayshopmoneycardView.super.onEnterFinished(self)
end

function PayshopmoneycardView:onExit()
	PayshopmoneycardView.super.onExit(self)
end

function PayshopmoneycardView:onExitFinished()
	PayshopmoneycardView.super.onExitFinished(self)
end

function PayshopmoneycardView:_onClickbtnSure()
	self:close()
end

return PayshopmoneycardView
