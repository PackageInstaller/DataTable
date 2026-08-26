-- chunkname: @modules/logic/versionactivity2_0/dungeon/config/Activity161Config.lua

module("modules.logic.versionactivity2_0.dungeon.config.Activity161Config", package.seeall)

local Activity161Config = class("Activity161Config", BaseConfig)

function Activity161Config:ctor()
	self._activity161GraffitiConfig = nil
	self._activity161RewardConfig = nil
	self._activity161DialogConfig = nil
	self._activity161ChessConfig = nil
	self.graffitiPicList = {}
end

function Activity161Config:reqConfigNames()
	return {
		"activity161_graffiti",
		"activity161_reward",
		"activity161_graffiti_event",
		"activity161_graffiti_dialog",
		"activity161_graffiti_chess"
	}
end

function Activity161Config:onConfigLoaded(configName, configTable)
	if configName == "activity161_graffiti" then
		self._activity161GraffitiConfig = configTable
	elseif configName == "activity161_reward" then
		self._activity161RewardConfig = configTable
	elseif configName == "activity161_graffiti_dialog" then
		self._activity161DialogConfig = configTable
	elseif configName == "activity161_graffiti_chess" then
		self._activity161ChessConfig = configTable
	end
end

function Activity161Config:getAllGraffitiCo(activityId)
	return self._activity161GraffitiConfig.configDict[activityId]
end

function Activity161Config:getGraffitiCo(activityId, elementId)
	return self._activity161GraffitiConfig.configDict[activityId][elementId]
end

function Activity161Config:getGraffitiCount(activityId)
	local allCos = self:getAllGraffitiCo(activityId)

	return GameUtil.getTabLen(allCos)
end

function Activity161Config:getAllRewardCos(activityId)
	local allRewardCoList = {}
	local allRewardCoDict = self._activity161RewardConfig.configDict[activityId]

	for _, rewardCo in pairs(allRewardCoDict) do
		table.insert(allRewardCoList, rewardCo)
	end

	table.sort(allRewardCoList, Activity161Config.sortReward)

	return allRewardCoList
end

function Activity161Config.sortReward(a, b)
	return a.rewardId < b.rewardId
end

function Activity161Config:getRewardCo(activityId, finishNum)
	return self._activity161RewardConfig.configDict[activityId][finishNum]
end

function Activity161Config:getFinalReward(activityId)
	local rewardCoList = tabletool.copy(self:getAllRewardCos(activityId))
	local finalCo = rewardCoList[#rewardCoList]
	local rewardList = GameUtil.splitString2(finalCo.bonus, true)
	local finalReward = table.remove(rewardList, #rewardList)

	return rewardList, finalReward
end

function Activity161Config:getUnlockCondition(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
	local needFinishEpisode, preElement, cdFinishElement

	if not string.nilorempty(elementCo.condition) then
		needFinishEpisode = self:extractConditionValue(elementCo.condition, "EpisodeFinish")
		preElement = self:extractConditionValue(elementCo.condition, "ChapterMapElement")
		cdFinishElement = self:extractConditionValue(elementCo.condition, "Act161CdFinish")
	end

	return needFinishEpisode, preElement, cdFinishElement
end

function Activity161Config:extractConditionValue(str, key)
	local pattern = key .. "=(%d+)"
	local valueMatch = string.match(str, pattern)

	return valueMatch or nil
end

function Activity161Config:getAllDialogMapCoByGraoupId(groupId)
	return self._activity161DialogConfig.configDict[groupId]
end

function Activity161Config:getDialogConfig(groupId, stepId)
	return self._activity161DialogConfig.configDict[groupId][stepId]
end

function Activity161Config:getChessConfig(chessId)
	return self._activity161ChessConfig.configDict[chessId]
end

function Activity161Config:getGraffitiRelevantElementMap(activityId)
	local graffitiMap = self:getAllGraffitiCo(activityId)
	local relevantElementMap = {}
	local mainElementMap = {}

	for index, graffitiCo in pairs(graffitiMap) do
		if not string.nilorempty(graffitiCo.subElementIds) then
			for _, elementId in pairs((string.splitToNumber(graffitiCo.subElementIds, "#"))) do
				relevantElementMap[elementId] = graffitiCo
			end
		end

		if not string.nilorempty(graffitiCo.mainElementId) then
			mainElementMap[graffitiCo.mainElementId] = graffitiCo
		end
	end

	return relevantElementMap, mainElementMap
end

function Activity161Config:getGraffitiRelevantElement(activityId, elementId)
	local graffitiCo = self:getGraffitiCo(activityId, elementId)

	return (not string.nilorempty(graffitiCo.subElementIds) or nil) and string.splitToNumber(graffitiCo.subElementIds, "#")
end

function Activity161Config:isPreMainElementFinish(graffitiConfig)
	local preMainElementIds = string.splitToNumber(graffitiConfig.preMainElementIds, "#") or {}

	if #preMainElementIds == 0 then
		return true
	end

	for index, elementId in ipairs(preMainElementIds) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			return false
		end
	end

	return true
end

function Activity161Config:initGraffitiPicMap(activityId)
	if #self.graffitiPicList == 0 then
		local allGraffitiCos = self:getAllGraffitiCo(activityId)

		for elementId, graffitiCo in pairs(allGraffitiCos) do
			table.insert(self.graffitiPicList, graffitiCo)
		end

		table.sort(self.graffitiPicList, self.sortGraffitiPic)
	end
end

function Activity161Config.sortGraffitiPic(configA, configB)
	return configA.sort < configB.sort
end

function Activity161Config:checkIsGraffitiMainElement(activityId, elementId)
	local allGraffitiCos = self:getAllGraffitiCo(activityId)

	for _, graffitiCo in pairs(allGraffitiCos) do
		if graffitiCo.mainElementId == elementId then
			return true, graffitiCo
		end
	end

	return false
end

Activity161Config.instance = Activity161Config.New()

return Activity161Config
