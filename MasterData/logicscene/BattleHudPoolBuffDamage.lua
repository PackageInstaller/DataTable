-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPoolBuffDamage.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPoolBuffDamage", package.seeall)

local BattleHudPoolBuffDamage = class("BattleHudPoolBuffDamage", BattleHudPoolHurtNum)

function BattleHudPoolBuffDamage:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local goDamage = goutil.clone(self._damageAsset)
		local hud = BattleHudBuffDamage.New(goDamage, go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudPoolBuffDamage
