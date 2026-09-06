-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/GoodeviltipView.lua

module("logic.extensions.zoo.view.GoodeviltipView", package.seeall)

local GoodeviltipView = class("GoodeviltipView", ViewComponent)

function GoodeviltipView:ctor()
	GoodeviltipView.super.ctor(self)
end

function GoodeviltipView:buildUI()
	GoodeviltipView.super.buildUI(self)

	self._closeBtn = self:getBtn("bggroup/closeBtn")
	self._value = self:getTxt("value/txtValue")
	self._anchor = self:getGo("value/anchor")
	self._pointer = goutil.findChildComponent(self._anchor, "pointer", "UIImageSpriteChange")
	self._goodDesc = self:getTxt("good/view/Viewport/txtDesc")
	self._evilDesc = self:getTxt("evil/view/Viewport/txtDesc")
end

function GoodeviltipView:bindEvents()
	GoodeviltipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function GoodeviltipView:unbindEvents()
	GoodeviltipView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._goodBtn:RemoveClickListener()
	self._evilBtn:RemoveClickListener()
end

function GoodeviltipView:destroyUI()
	GoodeviltipView.super.destroyUI(self)
end

function GoodeviltipView:onEnter()
	GoodeviltipView.super.onEnter(self)

	local goodEvilValue = self:getFirstParam()

	self._value.text = goodEvilValue

	local goodEvilCfg = FriendConfig.instance:GetGoodEvil()
	local min, max = goodEvilCfg[1].lv, goodEvilCfg[#goodEvilCfg].lv
	local proportion = goodEvilValue / (max - min)

	self._pointer:SetState(proportion >= 0.5 and 0 or 1)
	Framework.TransformUtil.SetLocalRotation(self._anchor.transform, 0, 0, proportion * 360)

	self._goodDesc.text = RulesConfig.instance:getRuleCo("getGoodValue").rules
	self._evilDesc.text = RulesConfig.instance:getRuleCo("getEvilValue").rules
end

function GoodeviltipView:onEnterFinished()
	GoodeviltipView.super.onEnterFinished(self)
end

function GoodeviltipView:onExit()
	GoodeviltipView.super.onExit(self)
end

function GoodeviltipView:onExitFinished()
	GoodeviltipView.super.onExitFinished(self)
end

return GoodeviltipView
