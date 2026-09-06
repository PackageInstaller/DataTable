-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelspeanswerView.lua

module("logic.extensions.goodfeel.view.GoodfeelspeanswerView", package.seeall)

local GoodfeelspeanswerView = class("GoodfeelspeanswerView", ViewComponent)

function GoodfeelspeanswerView:ctor()
	GoodfeelspeanswerView.super.ctor(self)
end

function GoodfeelspeanswerView:buildUI()
	GoodfeelspeanswerView.super.buildUI(self)

	self._closBtn = self:getBtn("clostBtn")
end

function GoodfeelspeanswerView:bindEvents()
	GoodfeelspeanswerView.super.bindEvents(self)
	self._closBtn:AddClickListener(self.close, self)
end

function GoodfeelspeanswerView:unbindEvents()
	GoodfeelspeanswerView.super.unbindEvents(self)
	self._closBtn:RemoveClickListener()
end

function GoodfeelspeanswerView:destroyUI()
	GoodfeelspeanswerView.super.destroyUI(self)
end

function GoodfeelspeanswerView:onEnter()
	GoodfeelspeanswerView.super.onEnter(self)
end

function GoodfeelspeanswerView:onEnterFinished()
	GoodfeelspeanswerView.super.onEnterFinished(self)
end

function GoodfeelspeanswerView:onExit()
	GoodfeelspeanswerView.super.onExit(self)
end

function GoodfeelspeanswerView:onExitFinished()
	GoodfeelspeanswerView.super.onExitFinished(self)
end

return GoodfeelspeanswerView
