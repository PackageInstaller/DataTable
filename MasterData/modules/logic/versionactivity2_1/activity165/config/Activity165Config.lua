-- chunkname: @modules/logic/versionactivity2_1/activity165/config/Activity165Config.lua

module("modules.logic.versionactivity2_1.activity165.config.Activity165Config", package.seeall)

local Activity165Config = class("Activity165Config", BaseConfig)

function Activity165Config:ctor()
	self._storyCoDic = nil
	self._storyEndCoDic = nil
	self._keywordsCoDic = nil
	self._stepCoDic = nil
	self._rewardCoDic = nil
	self._storyStepCoDic = nil
	self._storyEndingCoDic = nil
end

function Activity165Config:reqConfigNames()
	return {
		"activity165_ending",
		"activity165_keyword",
		"activity165_step",
		"activity165_story",
		"activity165_reward"
	}
end

function Activity165Config:onConfigLoaded(configName, configTable)
	if configName == "activity165_ending" then
		self._storyEndCoDic = configTable

		self:initEndingConfig()
	elseif configName == "activity165_keyword" then
		self._keywordsCoDic = configTable
	elseif configName == "activity165_step" then
		self._stepCoDic = configTable

		self:initStepCofig()
	elseif configName == "activity165_story" then
		self._storyCoDic = configTable
		self._storyCoMap = {}
		self._storyElementList = {}
	elseif configName == "activity165_reward" then
		self._rewardCoDic = configTable
	end
end

function Activity165Config:initStepCofig()
	self._storyStepCoDic = {}

	for _, co in pairs(self._stepCoDic.configList) do
		local storyCos = self._storyStepCoDic[co.belongStoryId]

		if not storyCos then
			storyCos = {}
			self._storyStepCoDic[co.belongStoryId] = storyCos
		end

		table.insert(storyCos, co)
	end
end

function Activity165Config:initEndingConfig()
	self._storyEndingCoDic = {}

	for _, co in pairs(self._storyEndCoDic.configList) do
		local storyCos = self._storyEndingCoDic[co.belongStoryId]

		if not storyCos then
			storyCos = {}
			self._storyEndingCoDic[co.belongStoryId] = storyCos
		end

		local stepId = tonumber(co.finalStepId)

		storyCos[stepId] = co
	end
end

function Activity165Config:getStoryCo(actId, storyId)
	if self._storyCoDic.configDict[actId] then
		return self._storyCoDic.configDict[actId]
	end
end

function Activity165Config:getAllStoryCoList(actId)
	local storyCoList = self._storyCoMap[actId]

	if not storyCoList then
		storyCoList = {}

		if not self._storyCoDic.configDict[actId] then
			for storyId, storyCo in pairs(self._storyCoDic.configDict[actId]) do
				table.insert(storyCoList, storyCo)
			end

			table.sort(storyCoList, function(a, b)
				return a.storyId < b.storyId
			end)

			self._storyCoMap[actId] = storyCoList
		end
	end

	return storyCoList
end

function Activity165Config:getStoryElements(actId, storyId)
	local storyCo = self:getStoryCo(actId, storyId)
	local elementList = self._storyElementList[storyId]

	if not elementList then
		elementList = string.splitToNumber(storyCo.unlockElementIds1, "#") or {}
		self._storyElementList[storyId] = elementList
	end

	return elementList
end

function Activity165Config:getStepCo(actId, stepId)
	return self._stepCoDic.configDict[stepId]
end

function Activity165Config:getStoryStepCoList(actId, storyId)
	return self._storyStepCoDic[storyId]
end

function Activity165Config:getKeywordCo(actId, keywordId)
	return self._keywordsCoDic.configDict[keywordId]
end

function Activity165Config:getEndingCo(actId, endingId)
	return self._storyEndCoDic.configDict[endingId]
end

function Activity165Config:getStoryKeywordCoList(actId, storyId)
	local cos = self._keywordsCoDic.configList
	local coList = {}

	if cos then
		for _, co in pairs(cos) do
			if co.belongStoryId == storyId then
				table.insert(coList, co)
			end
		end
	end

	return coList
end

function Activity165Config:getEndingCoByFinalStep(actId, storyId, stepId)
	if self._storyEndingCoDic and self._storyEndingCoDic[storyId] then
		local co = self._storyEndingCoDic[storyId][stepId]

		if co then
			return co
		end
	end
end

function Activity165Config:getEndingCosByStoryId(actId, storyId)
	if self._storyEndingCoDic then
		return self._storyEndingCoDic[storyId]
	end
end

function Activity165Config:getStoryRewardCo(actId, storyId, endingId)
	return self._rewardCoDic.configDict[storyId][endingId]
end

function Activity165Config:getStoryRewardCoList(actId, storyId)
	return self._rewardCoDic.configDict[storyId]
end

Activity165Config.instance = Activity165Config.New()

return Activity165Config
