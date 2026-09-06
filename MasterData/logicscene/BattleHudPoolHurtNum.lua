-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPoolHurtNum.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPoolHurtNum", package.seeall)

local BattleHudPoolHurtNum = class("BattleHudPoolHurtNum", BattleHudPool)

function BattleHudPoolHurtNum:ctor(damageAsset, mainAsset, hudType, capacity)
	BattleHudPoolHurtNum.super.ctor(self, mainAsset, hudType, capacity)

	self._damageAsset = damageAsset
	self.needCache = true
end

function BattleHudPoolHurtNum:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local goDamage = goutil.clone(self._damageAsset)
		local hud = BattleHudHurtNum.New(goDamage, go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudPoolHurtNum
