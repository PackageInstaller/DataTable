-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialtipView.lua

module("logic.extensions.herotrial.view.HerotrialtipView", package.seeall)

local HerotrialtipView = class("HerotrialtipView", ViewComponent)

function HerotrialtipView:ctor()
	HerotrialtipView.super.ctor(self)
end

function HerotrialtipView:buildUI()
	HerotrialtipView.super.buildUI(self)

	self.okBtn = self:getBtn("okBtn")
end

function HerotrialtipView:bindEvents()
	HerotrialtipView.super.bindEvents(self)
	self.okBtn:AddClickListener(self.onClickOk, self)
end

function HerotrialtipView:unbindEvents()
	HerotrialtipView.super.unbindEvents(self)
	self.okBtn:RemoveClickListener()
end

function HerotrialtipView:destroyUI()
	HerotrialtipView.super.destroyUI(self)
end

function HerotrialtipView:onEnter()
	HerotrialtipView.super.onEnter(self)
end

function HerotrialtipView:onEnterFinished()
	HerotrialtipView.super.onEnterFinished(self)
end

function HerotrialtipView:onExit()
	HerotrialtipView.super.onExit(self)
	self.mainGO:SetActive(false)
end

function HerotrialtipView:onExitFinished()
	HerotrialtipView.super.onExitFinished(self)
end

function HerotrialtipView:onClickOk()
	UIStateManager.instance:push(ViewName.HerotrialopentipView)
end

return HerotrialtipView
