-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopcashcouponuseView.lua

module("logic.extensions.payshop.view.PayshopcashcouponuseView", package.seeall)

local PayshopcashcouponuseView = class("PayshopcashcouponuseView", ViewComponent)

function PayshopcashcouponuseView:ctor()
	PayshopcashcouponuseView.super.ctor(self)
end

function PayshopcashcouponuseView:buildUI()
	PayshopcashcouponuseView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
end

function PayshopcashcouponuseView:bindEvents()
	PayshopcashcouponuseView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function PayshopcashcouponuseView:unbindEvents()
	PayshopcashcouponuseView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function PayshopcashcouponuseView:destroyUI()
	PayshopcashcouponuseView.super.destroyUI(self)
end

function PayshopcashcouponuseView:onEnter()
	PayshopcashcouponuseView.super.onEnter(self)
end

function PayshopcashcouponuseView:onEnterFinished()
	PayshopcashcouponuseView.super.onEnterFinished(self)
end

function PayshopcashcouponuseView:onExit()
	PayshopcashcouponuseView.super.onExit(self)
end

function PayshopcashcouponuseView:onExitFinished()
	PayshopcashcouponuseView.super.onExitFinished(self)
end

function PayshopcashcouponuseView:_onClickbtnSure()
	self:close()
end

return PayshopcashcouponuseView
