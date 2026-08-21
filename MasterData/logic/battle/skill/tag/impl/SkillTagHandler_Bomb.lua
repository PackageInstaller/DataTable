-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_Bomb.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_Bomb", package.seeall)

local M = class("SkillTagHandler_Bomb", SkillTagHandler_MoonRing)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:_getEffectUrl(range, attackerId)
	local uniqueRes = self:_checkForUniqueModelRes(range, attackerId)

	if uniqueRes then
		return uniqueRes
	end

	if self._shapeRange >= 3 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_chaogan_3")
	end

	if self._shapeRange >= 2 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_chaogan_2")
	end

	if self._shapeRange == 0 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_chaogan_0")
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_chaogan_1")
end

return M
