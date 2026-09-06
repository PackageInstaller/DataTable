-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/GiftbagopenView.lua

module("logic.extensions.itembag.view.GiftbagopenView", package.seeall)

local GiftbagopenView = class("GiftbagopenView", ViewComponent)

function GiftbagopenView:ctor()
	GiftbagopenView.super.ctor(self)
end

function GiftbagopenView:buildUI()
	GiftbagopenView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._effGo = self:getGo("eff")
end

function GiftbagopenView:bindEvents()
	GiftbagopenView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function GiftbagopenView:unbindEvents()
	GiftbagopenView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GiftbagopenView:destroyUI()
	GiftbagopenView.super.destroyUI(self)
end

function GiftbagopenView:onEnter()
	GiftbagopenView.super.onEnter(self)

	local params = self:getOpenParam()

	self._callback = params[1]

	if self._viewEff then
		UIEffectManager.instance:stopEffect(self._viewEff)

		self._viewEff = nil
	end

	self._viewEff = UIEffectManager.instance:playEffect(self, (params[2] or nil) and params[2], nil, 0, 0, false, nil, nil, function(target, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._viewEff:setParent(self._effGo.transform)
	self._viewEff:setScale(1)
	removetimer(self.close, self)
	settimer((params[3] or nil) and params[3], self.close, self, false)
end

function GiftbagopenView:onEnterFinished()
	GiftbagopenView.super.onEnterFinished(self)
end

function GiftbagopenView:onExit()
	GiftbagopenView.super.onExit(self)
	removetimer(self.close, self)

	if self._viewEff then
		UIEffectManager.instance:stopEffect(self._viewEff)

		self._viewEff = nil
	end

	if self._callback ~= nil then
		self._callback()
	end
end

function GiftbagopenView:onExitFinished()
	GiftbagopenView.super.onExitFinished(self)
end

return GiftbagopenView
