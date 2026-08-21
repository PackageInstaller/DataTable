-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_Assist.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_Assist", package.seeall)

local M = class("SkillTagHandler_Assist", SkillTagHandler_MoonRing)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:_getEffectUrl()
	local uniqueRes = self:_checkForUniqueModelRes()

	if uniqueRes then
		return uniqueRes
	end

	if self._shapeRange >= 3 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_yuanhu_3")
	end

	if self._shapeRange >= 2 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_yuanhu_2")
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_yuanhu_1")
end

return M
