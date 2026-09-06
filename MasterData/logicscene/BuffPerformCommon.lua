-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/performs/BuffPerformCommon.lua

module("logicscene.scene.battle.skills.buffs.performs.BuffPerformCommon", package.seeall)

local BuffPerformCommon = class("BuffPerformCommon", BuffPerformBase)

function BuffPerformCommon:onToggle(unit, damage, hurtOrigin)
	if damage < 0 then
		if hurtOrigin == GameEnum.BuffHurtOriginType.Burn then
			unit.unitUI:onBuffDamage(damage, UnitCompBattleUI.BuffDamageOrigin.Burn)
		elseif hurtOrigin == GameEnum.BuffHurtOriginType.Rebound then
			unit.unitUI:onBuffDamage(damage, UnitCompBattleUI.BuffDamageOrigin.Rebound)
		elseif hurtOrigin == GameEnum.BuffHurtOriginType.Poison then
			unit.unitUI:onBuffDamage(damage, UnitCompBattleUI.BuffDamageOrigin.Poison)
		else
			unit.unitUI:onBuffDamage(damage)
		end
	else
		unit.unitUI:onBuffDamage(damage)
	end
end

return BuffPerformCommon
