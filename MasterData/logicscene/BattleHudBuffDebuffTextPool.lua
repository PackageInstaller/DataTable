-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudBuffDebuffTextPool.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudBuffDebuffTextPool", package.seeall)

local BattleHudBuffDebuffTextPool = class("BattleHudBuffDebuffTextPool", BattleHudPool)

function BattleHudBuffDebuffTextPool:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local hud = BattleHudBuffText.New(go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudBuffDebuffTextPool
