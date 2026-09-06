-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPoolShieldNum.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPoolShieldNum", package.seeall)

local BattleHudPoolShieldNum = class("BattleHudPoolShieldNum", BattleHudPoolHurtNum)

function BattleHudPoolShieldNum:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local goDamage = goutil.clone(self._damageAsset)
		local hud = BattleHudHurtNum.New(goDamage, go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudPoolShieldNum
