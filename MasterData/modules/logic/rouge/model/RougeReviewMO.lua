-- chunkname: @modules/logic/rouge/model/RougeReviewMO.lua

module("modules.logic.rouge.model.RougeReviewMO", package.seeall)

local RougeReviewMO = pureTable("RougeReviewMO")

function RougeReviewMO:init(info)
	self.season = info.season
	self.playerName = info.playerName
	self.playerLevel = info.playerLevel
	self.portrait = info.portrait
	self.finishTime = info.finishTime
	self.difficulty = info.difficulty
	self.style = info.style
	self.teamLevel = info.teamLevel
	self.collectionNum = info.collectionNum
	self.gainCoin = info.gainCoin
	self.endId = info.endId
	self.layerId = info.layerId
	self.middleLayerId = info.middleLayerId

	self:updateTeamInfo(info.teamInfo)
	self:updateSlotCollections(info.layouts)
	self:updateVersions(info.version)
	self:updateLimiterInfo(info)
end

function RougeReviewMO:updateTeamInfo(teamInfo)
	self.teamInfo = RougeTeamInfoMO.New()

	self.teamInfo:init(teamInfo)
end

function RougeReviewMO:getTeamInfo()
	return self.teamInfo
end

function RougeReviewMO:updateSlotCollections(slotCollections)
	self.slotCollections = RougeCollectionHelper.buildCollectionSlotMOs(slotCollections)
end

function RougeReviewMO:getSlotCollections()
	return self.slotCollections
end

function RougeReviewMO:isSucceed()
	return self.endId and self.endId ~= 0
end

function RougeReviewMO:isInMiddleLayer()
	return self.middleLayerId ~= 0
end

function RougeReviewMO:updateVersions(versions)
	self._versions = {}

	tabletool.addValues(self._versions, versions)
end

function RougeReviewMO:getVersions()
	return self._versions
end

function RougeReviewMO:updateLimiterInfo(info)
	if info:HasField("riskValue") then
		self._riskValue = info.riskValue
	end
end

function RougeReviewMO:getLimiterRiskValue()
	return self._riskValue
end

return RougeReviewMO
