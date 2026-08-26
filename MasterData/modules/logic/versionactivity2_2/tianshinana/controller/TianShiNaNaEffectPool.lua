-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/TianShiNaNaEffectPool.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEffectPool", package.seeall)

local TianShiNaNaEffectPool = class("TianShiNaNaEffectPool")

function TianShiNaNaEffectPool:ctor()
	self._effect = {}
	self.root = nil
end

function TianShiNaNaEffectPool:setRoot(root)
	self.root = root
end

function TianShiNaNaEffectPool:getFromPool(x, y, type, delay, duration)
	local effect = table.remove(self._effect)

	effect = effect or TianShiNaNaPathEffect.Create(self.root)

	effect:initData(x, y, type, delay, duration)

	return effect
end

function TianShiNaNaEffectPool:returnToPool(effect)
	table.insert(self._effect, effect)
end

function TianShiNaNaEffectPool:clear()
	for _, effect in pairs(self._effect) do
		effect:dispose()
	end

	self._effect = {}
	self.root = nil
end

TianShiNaNaEffectPool.instance = TianShiNaNaEffectPool.New()

return TianShiNaNaEffectPool
