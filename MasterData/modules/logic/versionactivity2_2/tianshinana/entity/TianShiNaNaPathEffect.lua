-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaPathEffect.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPathEffect", package.seeall)

local TianShiNaNaPathEffect = class("TianShiNaNaPathEffect", LuaCompBase)

function TianShiNaNaPathEffect.Create(parent)
	local go = UnityEngine.GameObject.New("Effect")

	if parent then
		go.transform:SetParent(parent.transform, false)
	end

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, TianShiNaNaPathEffect))
end

function TianShiNaNaPathEffect:init(go)
	self.go = go
end

function TianShiNaNaPathEffect:initData(x, y, type, delay, duration)
	self.x = x
	self.y = y
	self.type = type
	self.delay = delay
	self.duration = duration

	local pos = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(x, y))

	transformhelper.setLocalPos(self.go.transform, pos.x, pos.y, pos.z)

	if delay > 0 then
		TaskDispatcher.runDelay(self.playEffect, self, delay)
	else
		self:playEffect()
	end

	TaskDispatcher.runDelay(self._delayInPool, self, delay + duration)
end

function TianShiNaNaPathEffect:playEffect()
	if not self.loader then
		self.loader = PrefabInstantiate.Create(self.go)

		local path = "scenes/v2a2_m_s12_tsnn_jshd/prefab/path_effect.prefab"

		self.loader:startLoad(path, self._onLoadEnd, self)
	elseif self.loader:getInstGO() then
		self:_realPlayEffect()
	end
end

function TianShiNaNaPathEffect:_onLoadEnd()
	local instGo = self.loader:getInstGO()

	self._goglow = gohelper.findChild(instGo, "1x1_glow")
	self._gostar = gohelper.findChild(instGo, "vx_star")

	self:_realPlayEffect()
end

function TianShiNaNaPathEffect:_realPlayEffect()
	gohelper.setActive(self._goglow, false)
	gohelper.setActive(self._gostar, false)
	gohelper.setActive(self._goglow, self.type == 1)
	gohelper.setActive(self._gostar, self.type == 2)
end

function TianShiNaNaPathEffect:_delayInPool()
	TianShiNaNaEffectPool.instance:returnToPool(self)
end

function TianShiNaNaPathEffect:onDestroy()
	TaskDispatcher.cancelTask(self.playEffect, self)
	TaskDispatcher.cancelTask(self._delayInPool, self)
end

function TianShiNaNaPathEffect:dispose()
	TaskDispatcher.cancelTask(self.playEffect, self)
	TaskDispatcher.cancelTask(self._delayInPool, self)
	gohelper.destroy(self.go)
end

return TianShiNaNaPathEffect
