-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/AchievementLabelMO.lua

module("logic.extensions.playerinfo.model.AchievementLabelMO", package.seeall)

local AchievementLabelMO = class("AchievementLabelMO")

function AchievementLabelMO:ctor(cfg)
	self._id = cfg.id
	self._name = cfg.name
	self._icon = cfg.icon
	self._lvReward = cfg.levelRewards
	self._achievements = nil
	self._skillMo = false
end

function AchievementLabelMO:setSkillLevelMo(skillMo)
	self._skillMo = skillMo
end

function AchievementLabelMO:getSkillMo()
	return self._skillMo
end

function AchievementLabelMO:getId()
	return self._id
end

function AchievementLabelMO:getName()
	return self._name
end

function AchievementLabelMO:getIcon()
	return self._icon
end

function AchievementLabelMO:getLvRewards()
	if not self._lvRewarSorted then
		self._lvRewarSorted = {}

		for i, v in pairs(self._lvReward) do
			table.insert(self._lvRewarSorted, {
				level = i,
				rewardId = v
			})
		end

		table.sort(self._lvRewarSorted, function(a, b)
			return a.level < b.level
		end)
	end

	return self._lvRewarSorted
end

function AchievementLabelMO:getFinishCnt()
	local count = 0

	for _, achievementId in ipairs(self:getAchievements()) do
		local achievementMo = AchievementModel.instance:getAchievementMoById(achievementId)

		if achievementMo:getIsFinish() then
			count = count + 1
		end
	end

	return count
end

function AchievementLabelMO:getTotalCnt()
	return #self:getAchievements()
end

function AchievementLabelMO:getAchievements()
	if not self._achievements then
		self._achievements = {}

		local allAchievementCfgs = AchievementConfig.instance:getAllAchievementCfgs()

		for _, cfg in ipairs(allAchievementCfgs) do
			if cfg.skillId == self._id then
				table.insert(self._achievements, cfg.id)
			end
		end
	end

	return self._achievements
end

function AchievementLabelMO:isShowRedPoint()
	local lvRewardList = self:getLvRewards()
	local isShow = false

	for i, v in ipairs(lvRewardList) do
		if self._skillMo:canGetLevelReward(v.level) and not self._skillMo:isGetLevelReward(v.level) then
			isShow = true
		end
	end

	return isShow
end

return AchievementLabelMO
