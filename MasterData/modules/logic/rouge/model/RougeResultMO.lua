-- chunkname: @modules/logic/rouge/model/RougeResultMO.lua

module("modules.logic.rouge.model.RougeResultMO", package.seeall)

local RougeResultMO = pureTable("RougeResultMO", RougeCollectionMO)

function RougeResultMO:init(info)
	self.season = tonumber(info.season)

	self:updateHeroId(info.initHeroId)

	self.collectionNum = GameUtil.splitString2(info.collection2NumStr, true)
	self.composeRes = GameUtil.splitString2(info.composeRes2NumStr, true)

	self:updateFinishEventIds(info.finishEventId)
	self:updateFinishEntrustIds(info.finishEntrustId)

	self.consumeCoin = tonumber(info.consumeCoin)
	self.consumePower = tonumber(info.consumePower)
	self.maxDamage = tonumber(info.maxDamage)
	self.deadNum = tonumber(info.deadNum)
	self.reviveNum = tonumber(info.reviveNum)
	self.repairShopNum = tonumber(info.repairShopNum)
	self.displaceNum = tonumber(info.displaceNum)
	self.stepNum = tonumber(info.stepNum)
	self.badge2Score = GameUtil.splitString2(info.badge2Score, true)
	self.normalFight2Score = string.splitToNumber(info.normalFight2Score, "#")
	self.difficultFight2Score = string.splitToNumber(info.difficultFight2Score, "#")
	self.dangerousFight2Score = string.splitToNumber(info.dangerousFight2Score, "#")
	self.collection2Score = string.splitToNumber(info.collection2Score, "#")
	self.layer2Score = string.splitToNumber(info.layer2Score, "#")
	self.entrust2Score = string.splitToNumber(info.entrust2Score, "#")
	self.end2Score = string.splitToNumber(info.end2Score, "#")
	self.scoreReward = tonumber(info.scoreReward)
	self.beforeScore = tonumber(info.beforeScore)
	self.finalScore = tonumber(info.finalScore)
	self.addPoint = tonumber(info.addPoint)
	self.remainScore2Point = tonumber(info.remainScore2Point)
	self.addGeniusPoint = tonumber(info.addGeniusPoint)
	self.remainScore2GeniusPoint = tonumber(info.remainScore2GeniusPoint)

	self:updateReviewInfo(info.reviewInfo)

	self.preRemainScore2Point = tonumber(info.preRemainScore2Point)
	self.preRemainScore2GeniusPoint = tonumber(info.preRemainScore2GeniusPoint)

	self:updateLimiterResult(info)

	self.extraAddPoint = tonumber(info.extraAddPoint)
end

function RougeResultMO:updateReviewInfo(reviewInfo)
	self.reviewInfo = RougeReviewMO.New()

	self.reviewInfo:init(reviewInfo)
end

function RougeResultMO:getReviewInfo()
	return self.reviewInfo
end

function RougeResultMO:updateHeroId(initHeroId)
	self.initHeroId = {}

	for _, heroId in ipairs(initHeroId) do
		table.insert(self.initHeroId, heroId)
	end
end

function RougeResultMO:getInitHeroId()
	return self.initHeroId
end

function RougeResultMO:updateFinishEventIds(finishEventId)
	self.finishEventId = {}
	self.finishEventMap = {}

	for _, eventId in ipairs(finishEventId) do
		table.insert(self.finishEventId, eventId)

		self.finishEventMap[eventId] = true
	end
end

function RougeResultMO:updateFinishEntrustIds(finishEntrustId)
	self.finishEntrustId = {}
	self.finishEntrustIdMap = {}

	for _, entrustId in ipairs(finishEntrustId) do
		table.insert(self.finishEntrustId, entrustId)

		self.finishEntrustIdMap[entrustId] = true
	end
end

function RougeResultMO:getNormalFightCountAndScore()
	if self.normalFight2Score then
		if not self.normalFight2Score[1] then
			local count = 0

			if self.normalFight2Score then
				if not self.normalFight2Score[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function RougeResultMO:getDifficultFightCountAndScore()
	if self.difficultFight2Score then
		if not self.difficultFight2Score[1] then
			local count = 0

			if self.difficultFight2Score then
				if not self.difficultFight2Score[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function RougeResultMO:getDangerousFightCountAndScore()
	if self.dangerousFight2Score then
		if not self.dangerousFight2Score[1] then
			local count = 0

			if self.dangerousFight2Score then
				if not self.dangerousFight2Score[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function RougeResultMO:getCollectionCountAndScore()
	if self.collection2Score then
		if not self.collection2Score[1] then
			local count = 0

			if self.collection2Score then
				if not self.collection2Score[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function RougeResultMO:getLayerCountAndScore()
	if self.layer2Score then
		if not self.layer2Score[1] then
			local count = 0

			if self.layer2Score then
				if not self.layer2Score[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function RougeResultMO:getEntrustCountAndScore()
	if self.entrust2Score then
		if not self.entrust2Score[1] then
			local count = 0

			if self.entrust2Score then
				if not self.entrust2Score[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function RougeResultMO:getEndCountAndScore()
	local isSucc = self:isSucceed()
	local count = isSucc and 1 or 0

	if self.end2Score then
		if not self.end2Score[2] then
			local score = 0

			return count, score
		end
	end
end

function RougeResultMO:getResultSeason()
	return self.season
end

function RougeResultMO:getTotalFightCount()
	local normalFightCount = self:getNormalFightCountAndScore()
	local difficlutFightCount = self:getDifficultFightCountAndScore()
	local dangerousFightCount = self:getDangerousFightCountAndScore()

	return normalFightCount + difficlutFightCount + dangerousFightCount
end

function RougeResultMO:isEntrustFinish(entrustId)
	return self.finishEntrustIdMap and self.finishEntrustIdMap[entrustId] == true
end

function RougeResultMO:isEventFinish(eventId)
	return self.finishEventMap and self.finishEventMap[eventId] == true
end

function RougeResultMO:isSucceed()
	if self.end2Score then
		return self.end2Score and self.end2Score ~= 0
	end
end

function RougeResultMO:getCompositeCollectionIdAndCount()
	return self.composeRes
end

function RougeResultMO:updateLimiterResult(info)
	if not info:HasField("limiterResNO") then
		self.limiterResultMo = nil

		return
	end

	local preEmblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	self.limiterResultMo = RougeLimiterResultMO.New()

	self.limiterResultMo:init(info.limiterResNO)
	self.limiterResultMo:setPreEmbleCount(preEmblemCount)
end

function RougeResultMO:getLimiterResultMo()
	return self.limiterResultMo
end

return RougeResultMO
