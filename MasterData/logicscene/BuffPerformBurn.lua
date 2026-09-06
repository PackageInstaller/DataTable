-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/performs/BuffPerformBurn.lua

module("logicscene.scene.battle.skills.buffs.performs.BuffPerformBurn", package.seeall)

local BuffPerformBurn = class("BuffPerformBurn", BuffPerformBase)

function BuffPerformBurn:onToggle(unit, damage)
	if damage < 0 then
		unit.unitUI:onBuffDamage(damage, UnitCompBattleUI.BuffDamageOrigin.Burn)
	else
		unit.unitUI:onBuffDamage(damage)
	end
end

return BuffPerformBurn
