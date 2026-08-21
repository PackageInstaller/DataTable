-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/ISkillTagHandler.lua

module("logic.battle.skill.tag.ISkillTagHandler", package.seeall)

local ISkillTagHandler = class("ISkillTagHandler", AbstractGlobalReusable)

function ISkillTagHandler:parseServerEventNO(tagNO)
	if BattleLog.enableError then
		BattleLog.error("umimplement method parseServerEventNO")
	end
end

function ISkillTagHandler:startPerformance(callback, callbackSelf)
	if BattleLog.enableError then
		BattleLog.error("umimplement method parseServerEventNO")
	end
end

function ISkillTagHandler:stopPerformance(isInterrupt)
	return
end

function ISkillTagHandler:setTagId(tagId)
	self._tagId = tagId
end

return ISkillTagHandler
