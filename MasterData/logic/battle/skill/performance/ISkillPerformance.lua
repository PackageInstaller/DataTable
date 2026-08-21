-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/ISkillPerformance.lua

module("logic.battle.skill.performance.ISkillPerformance", package.seeall)

local ISkillPerformance = class("ISkillPerformance")

function ISkillPerformance:beginPerformance(skillVSInfo, callback, callbackSelf)
	return
end

function ISkillPerformance:doAttack(attackInfo, callback, callbackSelf)
	return
end

function ISkillPerformance:endPerformance(callback, callbackSelf)
	return
end

function ISkillPerformance:interrupt()
	return
end

function ISkillPerformance:syncVSInfo()
	return
end

return ISkillPerformance
