-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_Assist_Variant.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_Assist_Variant", package.seeall)

local M = class("SkillTagHandler_Assist_Variant", SkillTagHandler_MoonRing_Variant)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:_getEffectUrl(shapeType, range, attackerId)
	local uniqueRes = self:_checkForUniqueModelRes(shapeType, range, attackerId)

	if uniqueRes then
		return uniqueRes, 1
	end

	if range >= 3 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_yuanhu_3")
	end

	if range >= 2 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_yuanhu_2")
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_yuanhu_1")
end

return M
