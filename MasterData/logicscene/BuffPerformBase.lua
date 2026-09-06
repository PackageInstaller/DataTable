-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/performs/BuffPerformBase.lua

module("logicscene.scene.battle.skills.buffs.performs.BuffPerformBase", package.seeall)

local BuffPerformBase = class("BuffPerformBase")

function BuffPerformBase:onToggle(unit, damage, hurtOrigin)
	unit.unitUI:onBuffDamage(damage)
end

return BuffPerformBase
