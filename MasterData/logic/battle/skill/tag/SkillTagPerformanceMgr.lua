-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/SkillTagPerformanceMgr.lua

module("logic.battle.skill.tag.SkillTagPerformanceMgr", package.seeall)

local SkillTagPerformanceMgr = class("SkillTagPerformanceMgr")
local kGGG = getglobal("_G")

function SkillTagPerformanceMgr:ctor()
	self._tagType2HandlerClass = {}
end

function SkillTagPerformanceMgr:createHandler(tagId, isVariant)
	local handlerClass = self:_getHandlerClass(tagId, isVariant)

	if not handlerClass then
		return
	end

	local inst = handlerClass:createInstance()

	inst:setTagId(tagId)

	return inst
end

function SkillTagPerformanceMgr:destroyHandler(handler)
	handler:returnSelf()
end

function SkillTagPerformanceMgr:_getHandlerClass(tagId, isVariant)
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)
	local tagTypeName = isVariant and string.format("%s_Variant", tagCO.typeName) or tagCO.typeName
	local handlerClass = self._tagType2HandlerClass[tagTypeName]

	if not handlerClass then
		local className = string.format("SkillTagHandler_%s", tagTypeName)

		handlerClass = kGGG[className]
		self._tagType2HandlerClass[tagTypeName] = handlerClass
	end

	return handlerClass
end

SkillTagPerformanceMgr.instance = SkillTagPerformanceMgr.New()

return SkillTagPerformanceMgr
