-- chunkname: @modules/logic/rouge2/common/model/Rouge2_ResultMO.lua

module("modules.logic.rouge2.common.model.Rouge2_ResultMO", package.seeall)

local Rouge2_ResultMO = pureTable("Rouge2_ResultMO")

function Rouge2_ResultMO:init(info)
	self.endHeroId = info.endHeroId

	self:updateCheckEvent(info.checkStr)

	self.finishEventId = info.finishEventId
	self.gainCoin = tonumber(info.gainCoin)
	self.stepNum = tonumber(info.stepNum)
	self.badge2Score = GameUtil.splitString2(info.badge2Score, true)
	self.normalFight2Score = string.splitToNumber(info.normalFight2Score, "#")
	self.difficultFight2Score = string.splitToNumber(info.difficultFight2Score, "#")
	self.dangerousFight2Score = string.splitToNumber(info.dangerousFight2Score, "#")
	self.collection2Score = string.splitToNumber(info.collection2Score, "#")
	self.layer2Score = string.splitToNumber(info.layer2Score, "#")
	self.attrScore = string.splitToNumber(info.attr2Score, "#")
	self.scoreReward1 = tonumber(info.scoreReward1)
	self.scoreReward2 = tonumber(info.scoreReward2)
	self.beforeScore = tonumber(info.beforeScore)
	self.finalScore = tonumber(info.finalScore)

	self:updateReviewInfo(info.reviewInfo)

	self.gainMaterial = info.gainMaterial
	self.addCareerExp = info.addCareerExp
	self.addCurrency = info.addCurrency
end

function Rouge2_ResultMO:updateCheckEvent(checkStr)
	self.attributeCheckTotalCount = 0
	self.attributeCheckCountDic = {}
	self.attributeCheckMaxId = 0
	self.attributeCheckSuccessCount = 0

	if not string.nilorempty(checkStr) then
		local table = cjson.decode(checkStr)

		if table and next(table) then
			for attributeStr, checkParam in pairs(table) do
				local attributeId = tonumber(attributeStr)

				if attributeId then
					local attributeConfig = Rouge2_AttributeConfig.instance:getAttributeConfig(attributeId)

					if not attributeConfig then
						logError("肉鸽2 前端不存在的attributeConfigId :" .. tostring(attributeId))
					else
						for stateStr, count in pairs(checkParam) do
							local state = tonumber(stateStr)

							if state then
								self.attributeCheckTotalCount = self.attributeCheckTotalCount + count

								if state ~= Rouge2_OutsideEnum.AttributeCheckState.Fail then
									self.attributeCheckSuccessCount = self.attributeCheckSuccessCount + count
								end

								self.attributeCheckCountDic[attributeId] = self.attributeCheckCountDic[attributeId] or 0
								self.attributeCheckCountDic[attributeId] = self.attributeCheckCountDic[attributeId] + count
							end
						end
					end
				end
			end
		end

		local maxCheckCount = 0
		local maxCheckAttrId = 0

		if next(self.attributeCheckCountDic) then
			for attributeId, checkCount in pairs(self.attributeCheckCountDic) do
				if maxCheckCount < checkCount then
					maxCheckAttrId = attributeId
					maxCheckCount = checkCount
				end
			end
		end

		self.attributeCheckMaxId = maxCheckAttrId
	end
end

function Rouge2_ResultMO:updateReviewInfo(reviewInfo)
	self.reviewInfo = self.reviewInfo or Rouge2_ReviewMO.New()

	self.reviewInfo:init(reviewInfo)
end

function Rouge2_ResultMO:isSucceed()
	if self.reviewInfo then
		return self.reviewInfo and self.reviewInfo ~= 0
	end
end

function Rouge2_ResultMO:getNormalFightCountAndScore()
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

function Rouge2_ResultMO:getDifficultFightCountAndScore()
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

function Rouge2_ResultMO:getDangerousFightCountAndScore()
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

function Rouge2_ResultMO:getCollectionCountAndScore()
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

function Rouge2_ResultMO:getLayerCountAndScore()
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

function Rouge2_ResultMO:getQuintupleCountAndScore()
	if self.attrScore then
		if not self.attrScore[1] then
			local count = 0

			if self.attrScore then
				if not self.attrScore[2] then
					local score = 0

					return count, score
				end
			end
		end
	end
end

function Rouge2_ResultMO:getDifficulty()
	return self.reviewInfo and self.reviewInfo.difficulty
end

return Rouge2_ResultMO
