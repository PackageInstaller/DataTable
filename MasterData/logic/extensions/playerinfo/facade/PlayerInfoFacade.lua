-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/facade/PlayerInfoFacade.lua

module("logic.extensions.playerinfo.facade.PlayerInfoFacade", package.seeall)

local M = class("PlayerInfoFacade", BaseFacade)

function M:getAchievementSkill()
	return AchievementModel.instance:getSkillLevelMoList()
end

function M:getAchievementSkillProfit(id)
	return AchievementModel.instance:getSkillLevelProfit(id)
end

M.instance = M.New()

return M
