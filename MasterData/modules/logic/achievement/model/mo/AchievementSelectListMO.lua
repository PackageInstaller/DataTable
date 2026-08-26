-- chunkname: @modules/logic/achievement/model/mo/AchievementSelectListMO.lua

module("modules.logic.achievement.model.mo.AchievementSelectListMO", package.seeall)

local AchievementSelectListMO = pureTable("AchievementSelectListMO")

function AchievementSelectListMO:init(achievementCfgs, groupId)
	self.achievementCfgs = achievementCfgs
	self.groupId = groupId
end

function AchievementSelectListMO:getLineHeight()
	if self.groupId == 0 then
		return 313
	else
		return 460
	end
end

function AchievementSelectListMO:getAchievementType()
	if self.groupId then
		local isGroup = self.groupId ~= 0

		return (isGroup or nil) and (AchievementEnum.AchievementType.Single or AchievementEnum.AchievementType.Group)
	end
end

return AchievementSelectListMO
