-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPoolText.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPoolText", package.seeall)

local BattleHudPoolText = class("BattleHudPoolText", BattleHudPool)

function BattleHudPoolText:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local hud = BattleHudText.New(go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudPoolText
