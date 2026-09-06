-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudBuffTextPool.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudBuffTextPool", package.seeall)

local BattleHudBuffTextPool = class("BattleHudBuffTextPool", BattleHudPool)

function BattleHudBuffTextPool:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local hud = BattleHudBuffText.New(go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudBuffTextPool
