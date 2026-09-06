-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/model/FemalePsychicModel.lua

module("logic.extensions.femalepsychic.model.FemalePsychicModel", package.seeall)

local FemalePsychicModel = class("FemalePsychicModel", BaseModel)

function FemalePsychicModel:onInit()
	self:onReset()
end

function FemalePsychicModel:onReset()
	self._curLayerData = {}
	self._challengeInfo = {}
	self._battleInfo = {}
	self._battleInfo.activity = 253001
	self._battleInfo.layerId = 1
	self._battleInfo.levelId = 1
	self._battleResult = {}
	self._battleResult.result = 0
	self._battleResult.score = 0
	self._battleResult.isWin = false
	self._femalePsychicFmtMo = nil
	self._fantianFmtMo = FemalePsychicChallengeFmtMo.New()
end

function FemalePsychicModel:setChallengeInfo(msg)
	self._msgInfo = msg

	GameUtil.pbToTable(msg.challengeInfo, self._challengeInfo or {})
end

function FemalePsychicModel:getInfo()
	return self._msgInfo
end

function FemalePsychicModel:setCurLayerData(layerId)
	for _, data in pairs(self._challengeInfo) do
		if data.challengeId == layerId then
			self._curLayerData = data.stage
		end
	end
end

function FemalePsychicModel:getCurLayerInfo(layerId)
	return self._curLayerData or {}
end

function FemalePsychicModel:getCurLevelScore(layerId, levelId)
	if levelId > 0 then
		for _, data in pairs(self._curLayerData) do
			if data.stageId == levelId then
				return data.score
			end
		end
	end

	return 0
end

function FemalePsychicModel:setChallengeId(activityId, layerId, levelId)
	self._battleInfo.activityId = activityId
	self._battleInfo.layerId = layerId
	self._battleInfo.levelId = levelId
end

function FemalePsychicModel:getCanChanllengeLayerId()
	local curLayerProgress = 1

	if self._challengeInfo then
		for _, info in ipairs(self._challengeInfo) do
			for _, challenge in ipairs(info.stage) do
				if challenge.score > 0 then
					curLayerProgress = info.challengeId
				end
			end
		end
	end

	return curLayerProgress
end

function FemalePsychicModel:getBattleInfo()
	return self._battleInfo
end

function FemalePsychicModel:getCurChallengeLayerId()
	return self._battleInfo.layerId
end

function FemalePsychicModel:getCurChallengeLevelId()
	for _, data in ipairs(self._curLayerData) do
		if data.score <= 0 then
			return data.stageId
		end
	end

	return 1
end

function FemalePsychicModel:setBatleResult(msg)
	self._battleResult = {}
	self._battleResult.result = msg.result
	self._battleResult.score = msg.score
	self._battleResult.isWin = msg.isWin
end

function FemalePsychicModel:getChallengeResult()
	return self._battleResult or {}
end

function FemalePsychicModel:getBeforeData()
	if self._battleInfo.levelId < 1 then
		return 0
	end

	return self:getCurLevelScore(self._battleInfo.layerId, self._battleInfo.levelId)
end

function FemalePsychicModel:isChallengeWin()
	return self._battleResult.isWin
end

function FemalePsychicModel:canSaveData()
	if self._battleResult.score == 0 then
		return false
	end

	local nextLevelScore = self:getCurLevelScore(self._battleInfo.layerId, self._battleInfo.levelId + 1)
	local forwardLevelScore = self:getCurLevelScore(self._battleInfo.layerId, self._battleInfo.levelId - 1)

	if nextLevelScore > 0 then
		if self:getBeforeData() then
			return self._battleResult.score ~= self:getBeforeData() and forwardLevelScore < self._battleResult.score and nextLevelScore > self._battleResult.score
		end
	elseif self:getBeforeData() then
		return self._battleResult.score ~= self:getBeforeData() and forwardLevelScore < self._battleResult.score
	end

	return false
end

function FemalePsychicModel:getChallengeFmtMo(activityId, challengeId, stageId)
	if self._femalePsychicFmtMo == nil then
		self._femalePsychicFmtMo = FemalePsychicChallengeFmtMo.New()
	end

	self._femalePsychicFmtMo:initParams(activityId, challengeId, stageId)

	return self._femalePsychicFmtMo
end

function FemalePsychicModel:getFantianChallengeFmtMo(activityId, challengeId, stageId)
	self._fantianFmtMo:initParams(activityId, challengeId, stageId)

	return self._fantianFmtMo
end

function FemalePsychicModel:onUpdateBuffLv(activityId, buffLv)
	if self._msgInfo then
		self._msgInfo.signInBuffLv = buffLv
		self._msgInfo.signToday = true
	end
end

FemalePsychicModel.instance = FemalePsychicModel.New()

return FemalePsychicModel
