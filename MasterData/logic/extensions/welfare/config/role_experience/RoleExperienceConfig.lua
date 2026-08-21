-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/role_experience/RoleExperienceConfig.lua

module("logic.extensions.welfare.config.role_experience.RoleExperienceConfig", package.seeall)

local M = class("RoleExperienceConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.RoleExperience
	}
end

function M:getRoleExperienceList()
	return self._dict[ConfigName.RoleExperience].dataList
end

function M:getRoleExperienceCfg(code)
	return self._dict[ConfigName.RoleExperience] and self._dict[ConfigName.RoleExperience][code]
end

function M:getExperienceCharacterId(code)
	local cfg = self:getRoleExperienceCfg(code)

	return cfg and cfg.heroId
end

function M:getExperienceReward(code)
	local cfg = self:getRoleExperienceCfg(code)
	local rewardCode = cfg and cfg.reward or 0
	local rewardCfg = RewardConfig.instance:getRewardCfgByCode(rewardCode)

	if not rewardCfg or #rewardCfg.reward <= 0 then
		printError("奖励表必得物品数据有误，code:", rewardCode)

		return
	end

	return rewardCfg.reward[1]
end

function M:getImgGuidIdByDungeonId(dungeonId)
	local cfgList = self:getRoleExperienceList()

	if not cfgList then
		return
	end

	for i = 1, #cfgList do
		local cfg = cfgList[i]

		if cfg.levelId == dungeonId then
			return cfg.imageGuideId
		end
	end
end

M.instance = M.New()

return M
