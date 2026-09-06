-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/view/NewhandcardgetView.lua

module("logic.extensions.newhandcard.view.NewhandcardgetView", package.seeall)

local NewhandcardgetView = class("NewhandcardgetView", ViewComponent)

function NewhandcardgetView:ctor()
	NewhandcardgetView.super.ctor(self)
end

function NewhandcardgetView:buildUI()
	NewhandcardgetView.super.buildUI(self)

	self._okBtn = self:getBtn("okBtn")
end

function NewhandcardgetView:bindEvents()
	NewhandcardgetView.super.bindEvents(self)
	self._okBtn:AddClickListener(self.close, self)
end

function NewhandcardgetView:unbindEvents()
	NewhandcardgetView.super.unbindEvents(self)
	self._okBtn:RemoveClickListener()
end

function NewhandcardgetView:destroyUI()
	NewhandcardgetView.super.destroyUI(self)
end

function NewhandcardgetView:onEnter()
	NewhandcardgetView.super.onEnter(self)
end

function NewhandcardgetView:onEnterFinished()
	NewhandcardgetView.super.onEnterFinished(self)
end

function NewhandcardgetView:onExit()
	NewhandcardgetView.super.onExit(self)
end

function NewhandcardgetView:onExitFinished()
	NewhandcardgetView.super.onExitFinished(self)
end

return NewhandcardgetView
