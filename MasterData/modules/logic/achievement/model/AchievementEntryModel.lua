-- chunkname: @modules/logic/achievement/model/AchievementEntryModel.lua

module("modules.logic.achievement.model.AchievementEntryModel", package.seeall)

local AchievementEntryModel = class("AchievementEntryModel", BaseModel)

function AchievementEntryModel:onInit()
	return
end

function AchievementEntryModel:reInit()
	return
end

function AchievementEntryModel:initData()
	self.infoDict = AchievementConfig.instance:getCategoryAchievementMap()

	self:initCategory()
end

function AchievementEntryModel:initCategory()
	local achievements = AchievementConfig.instance:getOnlineAchievements()

	self._category2TotalDict = {}
	self._category2FinishedDict = {}
	self._totalAchievementGotCount = 0
	self._level2AchievementDict = {}

	for i, achievementCO in ipairs(achievements) do
		if AchievementUtils.isShowByAchievementCfg(achievementCO) then
			local level = AchievementModel.instance:getAchievementLevel(achievementCO.id)
			local category = achievementCO.category

			if level > 0 then
				self._category2FinishedDict[category] = self._category2FinishedDict[category] == nil and 1 or self._category2FinishedDict[category] + 1
				self._totalAchievementGotCount = self._totalAchievementGotCount + 1
			end

			self._level2AchievementDict[level] = self._level2AchievementDict[level] or 0
			self._level2AchievementDict[level] = self._level2AchievementDict[level] + 1
			self._category2TotalDict[category] = self._category2TotalDict[category] == nil and 1 or self._category2TotalDict[category] + 1
		end
	end
end

function AchievementEntryModel:getFinishCount(achieveType)
	return self._category2FinishedDict[achieveType] or 0, self._category2TotalDict[achieveType] or 0
end

function AchievementEntryModel:getLevelCount(level)
	if self._level2AchievementDict then
		return self._level2AchievementDict[level] or 0
	end
end

function AchievementEntryModel:getTotalFinishedCount()
	return self._totalAchievementGotCount or 0
end

function AchievementEntryModel:categoryHasNew(category)
	local cfgList = self.infoDict[category]

	if cfgList then
		for i, achievementCo in ipairs(cfgList) do
			if AchievementModel.instance:achievementHasNew(achievementCo.id) then
				return true
			end
		end
	end
end

AchievementEntryModel.instance = AchievementEntryModel.New()

return AchievementEntryModel
