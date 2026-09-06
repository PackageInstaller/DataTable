-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/PetqualitypopupView.lua

module("logic.extensions.guidepopup.view.PetqualitypopupView", package.seeall)

local PetqualitypopupView = class("PetqualitypopupView", ViewComponent)

function PetqualitypopupView:ctor()
	PetqualitypopupView.super.ctor(self)
end

function PetqualitypopupView:buildUI()
	PetqualitypopupView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
end

function PetqualitypopupView:bindEvents()
	PetqualitypopupView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnClose:AddClickListener(self._onClickSure, self)
end

function PetqualitypopupView:unbindEvents()
	PetqualitypopupView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function PetqualitypopupView:destroyUI()
	PetqualitypopupView.super.destroyUI(self)
end

function PetqualitypopupView:onEnter()
	PetqualitypopupView.super.onEnter(self)
end

function PetqualitypopupView:onEnterFinished()
	PetqualitypopupView.super.onEnterFinished(self)
end

function PetqualitypopupView:onExit()
	PetqualitypopupView.super.onExit(self)
end

function PetqualitypopupView:onExitFinished()
	PetqualitypopupView.super.onExitFinished(self)
end

function PetqualitypopupView:_onClickSure()
	GuideController.instance:finishGuide()
	self:close()
end

return PetqualitypopupView
