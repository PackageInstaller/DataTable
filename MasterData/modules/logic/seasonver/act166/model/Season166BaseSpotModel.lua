-- chunkname: @modules/logic/seasonver/act166/model/Season166BaseSpotModel.lua

module("modules.logic.seasonver.act166.model.Season166BaseSpotModel", package.seeall)

local Season166BaseSpotModel = class("Season166BaseSpotModel", BaseModel)

function Season166BaseSpotModel:onInit()
	self:reInit()
end

function Season166BaseSpotModel:reInit()
	self:cleanData()
end

function Season166BaseSpotModel:cleanData()
	self.curBaseSpotId = nil
	self.curBaseSpotConfig = nil
	self.curEpisodeId = nil
	self.talentId = nil
end

function Season166BaseSpotModel:initBaseSpotData(actId, baseId)
	self.actId = actId
	self.curBaseSpotId = baseId
	self.curBaseSpotConfig = Season166Config.instance:getSeasonBaseSpotCo(actId, baseId)
	self.curEpisodeId = self.curBaseSpotConfig and self.curBaseSpotConfig.episodeId
	self.talentId = self.curBaseSpotConfig and self.curBaseSpotConfig.talentId
end

function Season166BaseSpotModel:getBaseSpotMaxScore(actId, baseId)
	local actMO = Season166Model.instance:getActInfo(actId)
	local baseSpotMO = actMO.baseSpotInfoMap[baseId]

	if baseSpotMO then
		return baseSpotMO.maxScore
	end

	return 0
end

function Season166BaseSpotModel:getStarCount(actId, baseId, curScore)
	local score = curScore or self:getBaseSpotMaxScore(actId, baseId)
	local allScoreConfig = Season166Config.instance:getSeasonScoreCos(actId)
	local starCount = 0

	for index, config in ipairs(allScoreConfig) do
		if score >= config.needScore then
			starCount = config.star
		end
	end

	return starCount
end

function Season166BaseSpotModel:getScoreLevelCfg(actId, baseId, curScore)
	local score = curScore or self:getBaseSpotMaxScore(actId, baseId)
	local allScoreConfig = Season166Config.instance:getSeasonScoreCos(actId)

	for i = #allScoreConfig, 1, -1 do
		local config = allScoreConfig[i]

		if score >= config.needScore then
			return config
		end
	end
end

function Season166BaseSpotModel:getCurTotalStarCount(actId)
	local totalStarCount = 0
	local baseSpotCoList = Season166Config.instance:getSeasonBaseSpotCos(actId)

	for index, baseSpotCo in ipairs(baseSpotCoList) do
		local starCount = self:getStarCount(actId, baseSpotCo.baseId)

		totalStarCount = totalStarCount + starCount
	end

	return totalStarCount
end

Season166BaseSpotModel.instance = Season166BaseSpotModel.New()

return Season166BaseSpotModel
