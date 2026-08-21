-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/EmptySkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.EmptySkillAttackPointHandler", package.seeall)

local EmptySkillAttackPointHandler = class("EmptySkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function EmptySkillAttackPointHandler:ctor()
	self._entityId = false

	self:reuse()
end

function EmptySkillAttackPointHandler:reset()
	self._entityId = false
end

function EmptySkillAttackPointHandler:destroy()
	self:reset()
end

function EmptySkillAttackPointHandler:collectEntityIds(entityIdList)
	table.insert(entityIdList, self._entityId)
end

function EmptySkillAttackPointHandler:build(context)
	return
end

function EmptySkillAttackPointHandler:handleAttackPoint(context, weight)
	return
end

function EmptySkillAttackPointHandler:toString()
	return string.format("[empty skill attack handler,entityId = %s]", self._entityId)
end

function EmptySkillAttackPointHandler:setEntityId(entityId)
	self._entityId = entityId
end

return EmptySkillAttackPointHandler
