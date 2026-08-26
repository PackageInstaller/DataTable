-- chunkname: @modules/logic/achievement/model/PlayerViewAchievementModel.lua

module("modules.logic.achievement.model.PlayerViewAchievementModel", package.seeall)

local PlayerViewAchievementModel = class("PlayerViewAchievementModel", BaseModel)

function PlayerViewAchievementModel:decodeShowAchievement(showStr)
	local singeTaskSet, groupTaskSet = AchievementUtils.decodeShowStr(showStr)
	local singleSet = {}

	for _, taskId in pairs(singeTaskSet) do
		local taskCO = AchievementConfig.instance:getTask(taskId)

		if taskCO then
			table.insert(singleSet, taskCO.id)
		end
	end

	local groupSet = {}

	for _, taskId in pairs(groupTaskSet) do
		local taskCO = AchievementConfig.instance:getTask(taskId)

		if taskCO then
			local achievementCO = AchievementConfig.instance:getAchievement(taskCO.achievementId)

			if achievementCO.groupId ~= 0 then
				groupSet[achievementCO.groupId] = groupSet[achievementCO.groupId] or {}

				table.insert(groupSet[achievementCO.groupId], taskCO.id)
			end
		end
	end

	return singleSet, groupSet
end

function PlayerViewAchievementModel:getShowAchievements(showStr)
	local singleSet, groupSet = self:decodeShowAchievement(showStr)
	local isNamePlate = self:checkIsNamePlate(singleSet)
	local isGroup = groupSet and tabletool.len(groupSet) > 0

	return isGroup, isGroup and groupSet or singleSet, isNamePlate
end

function PlayerViewAchievementModel:checkIsNamePlate(singleSet)
	if not singleSet then
		return false
	end

	if singleSet and #singleSet == 1 then
		local taskCO = AchievementConfig.instance:getTask(singleSet[1])

		if taskCO then
			local achievementCO = AchievementConfig.instance:getAchievement(taskCO.achievementId)

			if achievementCO and achievementCO.category == AchievementEnum.Type.NamePlate then
				return true
			end
		end
	end

	return false
end

PlayerViewAchievementModel.instance = PlayerViewAchievementModel.New()

return PlayerViewAchievementModel
