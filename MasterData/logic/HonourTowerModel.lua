-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/model/HonourTowerModel.lua

module("logic.extensions.honourtower.model.HonourTowerModel", package.seeall)

local HonourTowerModel = class("HonourTowerModel", BaseModel)

HonourTowerModel.model = {
	hundred = 2,
	racing = 1
}

function HonourTowerModel:ctor()
	return
end

function HonourTowerModel:onInit()
	self:onReset()
end

function HonourTowerModel:onReset()
	self._periodId = 0
	self._stageProgress = {}
	self._hundredRacingProgress = {}
	self._petIds = {}
	self._customFmtMo = nil
	self._stageId = 0
	self._regressChallengeIds = {}
	self._challengeInfo = nil
end

function HonourTowerModel:setInfo(msg)
	self._periodId = msg.periodId
	self._regressChallengeIds = msg.regressChallengeId or {}
	self._challengeInfo = {}

	for i, v in ipairs(msg.challengeInfo) do
		self._challengeInfo[v.challengeId] = v
	end

	self._maxStageIds = {}

	for i, v in ipairs(msg.maxStageIds) do
		self._maxStageIds[v.challengeId] = v.maxStageId
	end
end

function HonourTowerModel:getMaxStageIds()
	return self._maxStageIds
end

function HonourTowerModel:getChallengeInfos()
	return self._challengeInfo
end

function HonourTowerModel:getChallengeInfo(challengeId)
	if self._challengeInfo[challengeId] then
		return self._challengeInfo[challengeId]
	end

	return nil
end

function HonourTowerModel:setChallengeSuccessed(challengeId, stageId, round)
	local info = self:getChallengeInfo(challengeId)

	if info then
		if stageId > info.curStageId then
			info.curStageId = stageId
		end

		for i, v in ipairs(info.stages) do
			if v.stageId == stageId then
				v.minRound = round
				v.gainedPassPrize = true
				v.gainedFristPrize = true

				break
			end
		end
	end
end

function HonourTowerModel:setPeriodId()
	local cfg = HonourTowerConfig.instance:getPeriodCfg()

	self._periodId = 0

	for i, v in ipairs(cfg) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			self._periodId = v.periodId

			return
		end
	end
end

function HonourTowerModel:getCustomTrueOrFalseFmtMo(periodId, challengeId, stageId)
	if self._customFmtMo == nil then
		self._customFmtMo = HonourTowerCustomFmtMo.New()
	end

	self._customFmtMo:initParams(periodId, challengeId, stageId)

	return self._customFmtMo
end

function HonourTowerModel:getRegressChallengeIds()
	return self._regressChallengeIds
end

function HonourTowerModel:getPeriodId()
	self:setPeriodId()

	return self._periodId
end

function HonourTowerModel:setRegressChallengeId(periodId, challengeId)
	if self._periodId == periodId then
		self._regressChallengeIds = self._regressChallengeIds or {}

		if not table.indexof(self._regressChallengeIds, challengeId) then
			table.insert(self._regressChallengeIds, challengeId)
		end
	end
end

function HonourTowerModel:getStageInfo(challengeId, stageId)
	local info = self:getChallengeInfo(challengeId)

	for i, v in ipairs(info.stages) do
		if v.stageId == stageId then
			return v
		end
	end

	return nil
end

function HonourTowerModel:isChallengeGainAllFirstPrize(challengeId)
	if not self._maxStageIds[challengeId] then
		local passNum = 0
		local cnt = #HonourTowerConfig.instance:getStageCfgs(challengeId)

		return cnt <= passNum
	end
end

HonourTowerModel.instance = HonourTowerModel.New()

return HonourTowerModel
