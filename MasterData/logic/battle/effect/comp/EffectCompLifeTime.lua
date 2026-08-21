-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompLifeTime.lua

module("logic.battle.effect.comp.EffectCompLifeTime", package.seeall)

local EffectCompLifeTime = class("EffectCompLifeTime", IEffectComp)

function EffectCompLifeTime:onInit()
	self._loader = self.unit.loader
	self._currentTime = 0
	self._lifeTime = 0
	self._isAutoDestroy = true
	self._finishHandler = Handler.New()
end

function EffectCompLifeTime:onReset()
	FrameUpdate:removeListener(self)

	self._currentTime = 0
	self._lifeTime = 0
	self._isAutoDestroy = true

	self._finishHandler:clear()
end

function EffectCompLifeTime:onDestroy()
	FrameUpdate:removeListener(self)

	self._loader = false
end

function EffectCompLifeTime:onResourceLoaded()
	self:_tryStartTimer()
end

function EffectCompLifeTime:replay()
	self:_tryStartTimer()
end

function EffectCompLifeTime:setLifeTime(lifeTime)
	self._lifeTime = lifeTime or -1

	self:_tryStartTimer()
end

function EffectCompLifeTime:setAutoDestroy(isAutoDestroy)
	self._isAutoDestroy = isAutoDestroy
end

function EffectCompLifeTime:setFinishListener(callback, callbackSelf)
	self._finishHandler:setListener(callback, callbackSelf)
end

function EffectCompLifeTime:luaUpdate(deltaTime)
	self._currentTime = self._currentTime + deltaTime

	if self._currentTime >= self._lifeTime then
		self:_onEffectFinish()
	end
end

function EffectCompLifeTime:_onEffectFinish()
	FrameUpdate:removeListener(self)
	self._finishHandler:call(self.unit)

	if self._isAutoDestroy then
		self.unit:destroy()
	end
end

function EffectCompLifeTime:destroyUnit()
	self:_onEffectFinish()
end

function EffectCompLifeTime:_tryStartTimer()
	if FrameUpdate:hasListener(self) then
		return
	end

	local goInst = self._loader:getInst()

	if goInst and self._lifeTime > 0 then
		FrameUpdate:addListener(self)
	end
end

return EffectCompLifeTime
