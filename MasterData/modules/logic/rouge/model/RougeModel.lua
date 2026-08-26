-- chunkname: @modules/logic/rouge/model/RougeModel.lua

module("modules.logic.rouge.model.RougeModel", package.seeall)

local RougeModel = class("RougeModel", BaseModel)

function RougeModel:onInit()
	return
end

function RougeModel:reInit()
	self._rougeInfo = nil
end

function RougeModel:updateRougeInfo(info)
	self._rougeInfo = self._rougeInfo or RougeInfoMO.New()

	self._rougeInfo:init(info)

	if info:HasField("mapInfo") then
		self._mapModel = RougeMapModel.instance

		self._mapModel:updateMapInfo(info.mapInfo)
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfo)
end

function RougeModel:updateResultInfo(info)
	self._rougeResult = self._rougeResult or RougeResultMO.New()

	self._rougeResult:init(info)
end

function RougeModel:getRougeInfo()
	return self._rougeInfo
end

function RougeModel:getRougeResult()
	return self._rougeResult
end

function RougeModel:getMapModel()
	return self._mapModel
end

function RougeModel:getSeason()
	return self._rougeInfo and self._rougeInfo.season
end

function RougeModel:getVersion()
	local inRouge = self:inRouge()

	if not inRouge then
		local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()

		return gameRecordInfo and gameRecordInfo:getVersionIds() or {}
	end

	if self._rougeInfo then
		if not self._rougeInfo.version then
			local version

			return version or {}
		end
	end
end

function RougeModel:getDifficulty()
	return (self._rougeInfo or nil) and (self._rougeInfo.difficulty or nil)
end

function RougeModel:getStyle()
	return (self._rougeInfo or nil) and (self._rougeInfo.style or nil)
end

function RougeModel:getTeamCapacity()
	return self._rougeInfo and self._rougeInfo.teamSize
end

function RougeModel:getTeamInfo()
	return self._rougeInfo and self._rougeInfo.teamInfo
end

function RougeModel:updatePower(power, powerLimit)
	if not self._rougeInfo then
		return
	end

	self._rougeInfo.power = power
	self._rougeInfo.powerLimit = powerLimit

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoPower)
end

function RougeModel:updateTeamInfo(teamInfo)
	self._rougeInfo:updateTeamInfo(teamInfo)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTeamInfo)
end

function RougeModel:updateTeamLife(heroLifeList)
	self._rougeInfo:updateTeamLife(heroLifeList)
end

function RougeModel:updateExtraHeroInfo(heroInfoList)
	self._rougeInfo:updateExtraHeroInfo(heroInfoList)
end

function RougeModel:updateTeamLifeAndDispatchEvent(heroLifeList)
	self._rougeInfo:updateTeamLifeAndDispatchEvent(heroLifeList)
end

function RougeModel:updateTalentInfo(talentInfo)
	self._rougeInfo:updateTalentInfo(talentInfo)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentInfo)
end

function RougeModel:isContinueLast()
	if not self._rougeInfo then
		return false
	end

	return self._rougeInfo:isContinueLast()
end

function RougeModel:clear()
	self._mapModel = nil
	self._rougeInfo = nil
	self._isAbort = nil
	self._rougeResult = nil
	self._initHeroDict = nil

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfo)
end

function RougeModel:isCanSelectRewards()
	if not self._rougeInfo then
		return false
	end

	return self._rougeInfo:isCanSelectRewards()
end

function RougeModel:isFinishedDifficulty()
	return self._rougeInfo and self._rougeInfo.state == RougeEnum.State.Difficulty
end

function RougeModel:isFinishedLastReward()
	return self._rougeInfo and self._rougeInfo.state == RougeEnum.State.LastReward
end

function RougeModel:isFinishedStyle()
	return self._rougeInfo and self._rougeInfo.state == RougeEnum.State.Style
end

function RougeModel:isStarted()
	return self._rougeInfo and self._rougeInfo.state == RougeEnum.State.Start
end

function RougeModel:isFinish()
	return self._rougeInfo and self._rougeInfo.state == RougeEnum.State.isEnd
end

function RougeModel:getState()
	return (self._rougeInfo or nil) and (self._rougeInfo.state or RougeEnum.State.Empty)
end

function RougeModel:inRouge()
	local state = self:getState()

	return state ~= RougeEnum.State.Empty and state ~= RougeEnum.State.isEnd
end

function RougeModel:getEndId()
	return self._rougeInfo and self._rougeInfo.endId
end

function RougeModel:updateFightResultMo(info)
	self.fightResultMo = self.fightResultMo or RougeFightResultMO.New()

	self.fightResultMo:init(info)
end

function RougeModel:getFightResultInfo()
	return self.fightResultMo
end

function RougeModel:getLastRewardList()
	return (self._rougeInfo or nil) and (self._rougeInfo.lastReward or {})
end

function RougeModel:getSelectRewardNum()
	return (self._rougeInfo or nil) and (self._rougeInfo.selectRewardNum or 0)
end

function RougeModel:getRougeRetryNum()
	return (self._rougeInfo or nil) and (self._rougeInfo.retryNum or 0)
end

function RougeModel:updateRetryNum(tryNum)
	if self._rougeInfo then
		self._rougeInfo.retryNum = tryNum
	end
end

function RougeModel:isRetryFight()
	local retryNum = self:getRougeRetryNum()

	if not retryNum then
		return false
	end

	return retryNum > 0
end

function RougeModel:getEffectDict()
	return self._rougeInfo and self._rougeInfo:getEffectDict()
end

function RougeModel:isAbortRouge()
	return self._isAbort
end

function RougeModel:onAbortRouge()
	self._isAbort = true
end

function RougeModel:getDeadHeroNum()
	return self._rougeInfo and self._rougeInfo:getDeadHeroNum() or 0
end

function RougeModel:setTeamInitHeros(initHeroIds)
	self._initHeroDict = {}

	if initHeroIds then
		for _, heroId in ipairs(initHeroIds) do
			self._initHeroDict[heroId] = true
		end
	end
end

function RougeModel:isInitHero(heroId)
	return (heroId or nil) and self._initHeroDict and self._initHeroDict[heroId]
end

function RougeModel:getInitHeroIds()
	local result = {}

	if self._initHeroDict then
		for heroId, _ in pairs(self._initHeroDict) do
			result[#result + 1] = heroId
		end
	end

	return result
end

RougeModel.instance = RougeModel.New()

return RougeModel
