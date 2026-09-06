-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/model/CrazyPartnerModel.lua

module("logic.extensions.crazypartner.model.CrazyPartnerModel", package.seeall)

local CrazyPartnerModel = class("CrazyPartnerModel", BaseModel)

function CrazyPartnerModel:ctor()
	self:onReset()
end

function CrazyPartnerModel:onInit()
	self:onReset()
end

function CrazyPartnerModel:onReset()
	self._totalScore = 0
	self._gainScorePrizeMap = {}
	self._rankData = {}
	self._difficultyMap = {}
end

function CrazyPartnerModel:handleGetInfo(msg)
	if msg.activityId == self:getActivityId() then
		self._totalScore = msg.totalScore

		local difficultyInfos = msg.difficulty

		self._difficultyMap = {}

		for _, difficultyInfo in ipairs(difficultyInfos) do
			self._difficultyMap[difficultyInfo.difficulty] = difficultyInfo
		end

		self._gainScorePrizeMap = {}

		for _, id in ipairs(msg.gainScorePrize) do
			self._gainScorePrizeMap[id] = true
		end
	end
end

function CrazyPartnerModel:beforeGainPrize(index)
	self._cachePrizeId = index
end

function CrazyPartnerModel:handleGainPrize(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)

		if self._cachePrizeId ~= nil then
			self._gainScorePrizeMap[self._cachePrizeId] = true
		end
	else
		self._cachePrizeId = nil
	end
end

function CrazyPartnerModel:beforeFight(difficulty)
	self.fightInfo = CrazyPartnerFightInfo.New(difficulty)
end

function CrazyPartnerModel:clearFightInfo()
	self.fightInfo = nil
end

function CrazyPartnerModel:handleNotifyChallengeEnd(msg)
	if self.fightInfo then
		self.fightInfo:update(msg)
	end

	local difficultyInfo = msg.difficulty

	self._difficultyMap[difficultyInfo.difficulty] = difficultyInfo
end

function CrazyPartnerModel:handleRankInfo(rankType, msg)
	if not msg.rankInfo then
		local myRank = -1
		local myUserId = checknumber(LoginModel.instance.userId)

		for _, rankInfo in ipairs(msg.rankInfo) do
			if checknumber(rankInfo.headInfo.userId) == myUserId then
				myRank = checknumber(rankInfo.rank)

				break
			end
		end

		self._rankData[rankType] = {
			myRank = myRank,
			rankInfoList = msg.rankInfo
		}
	end
end

function CrazyPartnerModel:getRankData(rankType)
	return self._rankData[rankType]
end

function CrazyPartnerModel:getTotalScore()
	return self._totalScore
end

function CrazyPartnerModel:getActivityId()
	return CrazyPartnerConfig.instance:getActId()
end

function CrazyPartnerModel:isCanGainPrizeByIndex(index)
	if self:isHasGainPrizeByIndex(index) then
		return false
	end

	local config = CrazyPartnerConfig.instance:getPrizeConfByIndex(self:getActivityId(), index)

	return self._totalScore >= config.score
end

function CrazyPartnerModel:isHasGainPrizeByIndex(index)
	if self._gainScorePrizeMap then
		return self._gainScorePrizeMap[index]
	end

	return true
end

function CrazyPartnerModel:getDifficultyInfoByIndex(index)
	if self._difficultyMap then
		return self._difficultyMap[index]
	end

	return nil
end

function CrazyPartnerModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = CrazyPartnerCustomFmtMo.New()
	end

	return self._customFmtMo
end

function CrazyPartnerModel:addViewInfo(viewName, ...)
	self._viewInfo = self._viewInfo or {}

	local info = {}

	info.viewName = viewName
	info.params = {
		...
	}

	table.insert(self._viewInfo, info)
end

function CrazyPartnerModel:getViewInfos()
	return self._viewInfo or {}
end

function CrazyPartnerModel:clearViewInfos()
	self._viewInfo = {}
end

CrazyPartnerModel.instance = CrazyPartnerModel.New()

return CrazyPartnerModel
