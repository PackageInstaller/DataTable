-- chunkname: @modules/logic/dungeon/config/RoleStoryConfig.lua

module("modules.logic.dungeon.config.RoleStoryConfig", package.seeall)

local RoleStoryConfig = class("RoleStoryConfig", BaseConfig)

function RoleStoryConfig:ctor()
	self._roleStoryConfig = nil
	self._roleStoryScoreDict = {}
	self._roleStoryRewardDict = {}
	self._roleStoryRewardConfig = nil
	self._roleStoryDispatchDict = {}
	self._roleStoryDispatchConfig = nil
	self._roleStoryDispatchTalkConfig = nil
end

function RoleStoryConfig:reqConfigNames()
	return {
		"hero_story",
		"hero_story_score",
		"hero_story_score_reward",
		"hero_story_dispatch",
		"hero_story_dispatch_talk"
	}
end

function RoleStoryConfig:onConfigLoaded(configName, configTable)
	if configName == "hero_story" then
		self._roleStoryConfig = configTable
	elseif configName == "hero_story_score" then
		self._roleStoryScoreDict = {}

		for _, v in ipairs(configTable.configList) do
			self._roleStoryScoreDict[v.storyId] = self._roleStoryScoreDict[v.storyId] or {}

			local waves = string.splitToNumber(v.wave, "#")

			if waves[#waves] then
				table.insert(self._roleStoryScoreDict[v.storyId], {
					wave = waves[#waves],
					score = v.score
				})
			end
		end

		for k, v in pairs(self._roleStoryScoreDict) do
			table.sort(v, SortUtil.keyLower("wave"))
		end
	elseif configName == "hero_story_score_reward" then
		self._roleStoryRewardDict = {}

		for _, v in ipairs(configTable.configList) do
			self._roleStoryRewardDict[v.storyId] = self._roleStoryRewardDict[v.storyId] or {}

			table.insert(self._roleStoryRewardDict[v.storyId], v)
		end

		for k, v in pairs(self._roleStoryRewardDict) do
			table.sort(v, SortUtil.keyLower("score"))
		end

		self._roleStoryRewardConfig = configTable
	elseif configName == "hero_story_dispatch" then
		self._roleStoryDispatchDict = {}

		for _, v in ipairs(configTable.configList) do
			self._roleStoryDispatchDict[v.heroStoryId] = self._roleStoryDispatchDict[v.heroStoryId] or {}
			self._roleStoryDispatchDict[v.heroStoryId][v.type] = self._roleStoryDispatchDict[v.heroStoryId][v.type] or {}

			table.insert(self._roleStoryDispatchDict[v.heroStoryId][v.type], v)
		end

		for _, v in pairs(self._roleStoryDispatchDict) do
			for t, vv in pairs(v) do
				table.sort(vv, SortUtil.keyLower("id"))
			end
		end

		self._roleStoryDispatchConfig = configTable
	elseif configName == "hero_story_dispatch_talk" then
		self._roleStoryDispatchTalkConfig = configTable
	end
end

function RoleStoryConfig:getStoryList()
	return self._roleStoryConfig.configList
end

function RoleStoryConfig:getStoryById(storyId)
	return self._roleStoryConfig.configDict[storyId]
end

function RoleStoryConfig:getScoreConfig(storyId)
	return self._roleStoryScoreDict[storyId]
end

function RoleStoryConfig:getRewardList(storyId)
	return self._roleStoryRewardDict[storyId]
end

function RoleStoryConfig:getRewardConfig(rewardId)
	return self._roleStoryRewardConfig.configDict[rewardId]
end

function RoleStoryConfig:getStoryIdByActivityId(activityId)
	local list = self:getStoryList()
	local storyId = 0

	for k, v in pairs(list) do
		if v.activityId == activityId then
			storyId = v.id

			break
		end
	end

	return storyId
end

function RoleStoryConfig:getStoryIdByChapterId(chapterId)
	local list = self:getStoryList()

	if list then
		for k, v in pairs(list) do
			if v.chapterId == chapterId then
				return v.id
			end
		end
	end
end

function RoleStoryConfig:getDispatchList(storyId, type)
	return self._roleStoryDispatchDict[storyId] and self._roleStoryDispatchDict[storyId][type]
end

function RoleStoryConfig:getDispatchConfig(dispatchId)
	return self._roleStoryDispatchConfig.configDict[dispatchId]
end

function RoleStoryConfig:getTalkConfig(talkId)
	return self._roleStoryDispatchTalkConfig.configDict[talkId]
end

RoleStoryConfig.instance = RoleStoryConfig.New()

return RoleStoryConfig
