-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/GroupEventSkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.GroupEventSkillAttackPointHandler", package.seeall)

local GroupEventSkillAttackPointHandler = class("GroupEventSkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)
local kTempVec3 = Vector3.New()

function GroupEventSkillAttackPointHandler:parseEventNO(groupEventNO)
	local handler = GroupEventSkillAttackPointHandler:createInstance()
	local events = groupEventNO.events

	for _, eventNO in ipairs(events) do
		if eventNO:HasField("damaged") then
			handler:addAttackPointHandler(DamageSkillAttackPointHandler:parseEventNO(eventNO.damaged))
		else
			handler:addAttackPointHandler(CureSkillAttackPointHandler:parseEventNO(eventNO.cured))
		end
	end

	return handler
end

function GroupEventSkillAttackPointHandler:ctor()
	self._subHandlers = {}

	self:reset()
end

function GroupEventSkillAttackPointHandler:reuse(...)
	return
end

function GroupEventSkillAttackPointHandler:reset()
	BattleTableUtil.clearReusableTable(self._subHandlers)
end

function GroupEventSkillAttackPointHandler:destroy()
	self:reset()
end

function GroupEventSkillAttackPointHandler:build(context)
	SkillAttackPointHandlerUtil.buildAttackPointHandlers(self._subHandlers, context)
end

function GroupEventSkillAttackPointHandler:handleAttackPoint(context, weight)
	SkillAttackPointHandlerUtil.executeAttackPointHandlers(self._subHandlers, context, weight)
end

function GroupEventSkillAttackPointHandler:handleLastAttackPoint(context)
	SkillAttackPointHandlerUtil.executeLastAttackPointHandlers(self._subHandlers, context)
end

function GroupEventSkillAttackPointHandler:toString()
	local sb = StringBuffer.New()

	sb:append("[group damage handler]"):appendLine()

	for _, handler in ipairs(self._subHandlers) do
		sb:append(handler:toString()):appendLine()
	end

	return sb:toString()
end

function GroupEventSkillAttackPointHandler:collectEntityIds(entityIdList)
	for _, handler in ipairs(self._subHandlers) do
		handler:collectEntityIds(entityIdList)
	end
end

function GroupEventSkillAttackPointHandler:addAttackPointHandler(handler)
	table.insert(self._subHandlers, handler)
end

return GroupEventSkillAttackPointHandler
