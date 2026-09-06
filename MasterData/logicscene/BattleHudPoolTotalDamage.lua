-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPoolTotalDamage.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPoolTotalDamage", package.seeall)

local BattleHudPoolTotalDamage = class("BattleHudPoolTotalDamage", BattleHudPoolHurtNum)
local totalDamage

function BattleHudPoolTotalDamage:ctor(damageAsset, mainAsset, hudType, capacity)
	BattleHudPoolTotalDamage.super.ctor(self, damageAsset, mainAsset, hudType, capacity)

	self.needCache = nil
end

function BattleHudPoolTotalDamage:_createHud()
	if self._totalHud then
		return self._totalHud
	end

	if self._mainAsset and not totalDamage then
		local go = goutil.clone(self._mainAsset)
		local goDamage = goutil.clone(self._damageAsset)

		totalDamage = BuffHudTotalDamage.New(goDamage, go, self)

		go:SetActive(false)

		self._totalHud = totalDamage
	end

	return totalDamage
end

function BattleHudPoolTotalDamage:recycleHud(hud)
	if self._isClear then
		UnityEngine.GameObject.Destroy(self._totalHud.go)
	else
		self._totalHud.go:SetActive(false)
	end
end

function BattleHudPoolTotalDamage:clear()
	self._isClear = true

	if self._totalHud then
		UnityEngine.GameObject.Destroy(self._totalHud.go)
	end

	self._totalHud = nil
	totalDamage = nil
end

return BattleHudPoolTotalDamage
