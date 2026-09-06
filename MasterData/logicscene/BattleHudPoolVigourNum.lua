-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPoolVigourNum.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPoolVigourNum", package.seeall)

local BattleHudPoolVigourNum = class("BattleHudPoolVigourNum", BattleHudPoolHurtNum)

function BattleHudPoolVigourNum:_createHud()
	if self._mainAsset then
		local go = goutil.clone(self._mainAsset)
		local goDamage = goutil.clone(self._damageAsset)
		local hud = BattleHudVigourNum.New(goDamage, go, self)

		go:SetActive(false)

		return hud
	end
end

return BattleHudPoolVigourNum
