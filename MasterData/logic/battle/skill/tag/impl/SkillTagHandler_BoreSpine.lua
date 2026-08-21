-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_BoreSpine.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_BoreSpine", package.seeall)

local M = class("SkillTagHandler_BoreSpine", SkillTagHandler_MoonRing)

function M:_getEffectUrl()
	local uniqueRes = self:_checkForUniqueModelRes()

	if uniqueRes then
		return uniqueRes
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhuici_1")
end

return M
