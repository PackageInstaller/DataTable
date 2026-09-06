-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/FavorChangeView.lua

module("logic.extensions.pigraise.view.FavorChangeView", package.seeall)

local FavorChangeView = class("FavorChangeView", ViewComponent)

function FavorChangeView:ctor()
	FavorChangeView.super.ctor(self)
end

function FavorChangeView:destroyUI()
	FavorChangeView.super.destroyUI(self)
end

function FavorChangeView:onExitFinished()
	FavorChangeView.super.onExitFinished(self)
end

function FavorChangeView:onEnterFinished()
	FavorChangeView.super.onEnterFinished(self)
end

function FavorChangeView:unbindEvents()
	FavorChangeView.super.unbindEvents(self)
end

function FavorChangeView:bindEvents()
	FavorChangeView.super.bindEvents(self)
end

function FavorChangeView:onExit()
	FavorChangeView.super.onExit(self)
	removetimer(self._onFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.PigFavorChange, self._onRefresh, self)
	self._numberChange:clear()
end

function FavorChangeView:buildUI()
	FavorChangeView.super.buildUI(self)

	self._container = self:getGo("item")
	self._animator = self._container:GetComponent(typeof(UnityEngine.Animator))
	self._numberChange = NumberChange.New(self._container)
end

function FavorChangeView:onEnter()
	FavorChangeView.super.onEnter(self)
	self:_onRefresh(self:getFirstParam())
	GlobalDispatcher:addListener(GlobalNotify.PigFavorChange, self._onRefresh, self)
end

function FavorChangeView:_onRefresh(addValue)
	local addNum = checknumber(addValue)

	if addNum then
		AudioPlayerEx.instance:playEffect(30205)
		self._numberChange:startPlay(addNum, addNum)
		removetimer(self._onFinish, self)
		settimer(1, self._onFinish, self, false)
		self._animator:Rebind()
	end
end

function FavorChangeView:_onFinish()
	self:close()
end

return FavorChangeView
