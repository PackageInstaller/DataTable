-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/performs/BuffPerformRebound.lua

module("logicscene.scene.battle.skills.buffs.performs.BuffPerformRebound", package.seeall)

local BuffPerformRebound = class("BuffPerformRebound", BuffPerformBase)

function BuffPerformRebound:onToggle(unit, damage)
	if damage < 0 then
		unit.unitUI:onBuffDamage(damage, UnitCompBattleUI.BuffDamageOrigin.Rebound)
	else
		unit.unitUI:onBuffDamage(damage)
	end
end

return BuffPerformRebound
