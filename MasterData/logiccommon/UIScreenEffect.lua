-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/UIScreenEffect.lua

module("logiccommon.common.effect.UIScreenEffect", package.seeall)

local UIScreenEffect = class("UIScreenEffect", GameEffect)

function UIScreenEffect:ctor()
	UIScreenEffect.super.ctor(self)

	self.sortingOrder = nil
	self.isScreenEff = true
end

function UIScreenEffect:onEffectStart()
	UIScreenEffect.super.onEffectStart(self)

	if self.sortingOrder then
		GoUtil.SetSortingOrder(self.effGo, self.sortingOrder)
	end
end

function UIScreenEffect:setTop(isTop)
	return
end

function UIScreenEffect:_onEffectPlayFinish()
	if self._settimer then
		self._settimer = nil

		removetimer(self._onEffectPlayFinish, self)
	end

	if self.finishHandler then
		self.finishHandler(self.finishHandlerTarget, self)
	end

	if self.autoDestroy then
		UIEffectManager.instance:stopEffect(self)
	end
end

return UIScreenEffect
