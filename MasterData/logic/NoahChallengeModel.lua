-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/model/NoahChallengeModel.lua

module("logic.extensions.noahchallenge.model.NoahChallengeModel", package.seeall)

local NoahChallengeModel = class("NoahChallengeModel", BaseModel)

function NoahChallengeModel:ctor()
	return
end

function NoahChallengeModel:onInit()
	self:onReset()
end

function NoahChallengeModel:onReset()
	self._petInfoDic = {}
	self._passAllStageChallengeIds = {}
end

function NoahChallengeModel:_initPetInfoDic(challengeId)
	if not self._petInfoDic[challengeId] then
		self._petInfoDic[challengeId] = {}
		self._petInfoDic[challengeId].curStage = 1
		self._petInfoDic[challengeId].buyTime = 0
		self._petInfoDic[challengeId].usedPetIds = {}
	end
end

function NoahChallengeModel:onNoahChallengeInfoRes(challengeId, msg)
	if challengeId and challengeId > 0 then
		self:_initPetInfoDic(challengeId)

		self._petInfoDic[challengeId].curStage = msg.curStage
		self._petInfoDic[challengeId].buyTime = checknumber(msg.buyTime)
		self._petInfoDic[challengeId].usedPetIds = GameUtil.pbToTable(msg.usedPetIds) or {}
	end
end

function NoahChallengeModel:onNoahChallengeResetRes(challengeId, msg)
	if challengeId and challengeId > 0 then
		self:_initPetInfoDic(challengeId)

		self._petInfoDic[challengeId].curStage = msg.curStage
		self._petInfoDic[challengeId].usedPetIds = GameUtil.pbToTable(msg.usedPetIds) or {}
	end
end

function NoahChallengeModel:onNoahChallengeEndRes(msg)
	self:_initPetInfoDic(msg.challengeId)

	self._petInfoDic[msg.challengeId].curStage = msg.stage
	self._petInfoDic[msg.challengeId].usedPetIds = GameUtil.pbToTable(msg.usedPetIds) or {}

	if self:isPassed(msg.challengeId) and not TableUtil.isHad(self._passAllStageChallengeIds, msg.challengeId) then
		table.insert(self._passAllStageChallengeIds, msg.challengeId)
	end
end

function NoahChallengeModel:onNoahChallengeBuyEndRes(msg)
	self:_initPetInfoDic(msg.challengeId)

	self._petInfoDic[msg.challengeId].curStage = self:getMaxStageNum(msg.challengeId)
	self._petInfoDic[msg.challengeId].buyTime = checknumber(msg.buyTime)

	if not TableUtil.isHad(self._passAllStageChallengeIds, msg.challengeId) then
		table.insert(self._passAllStageChallengeIds, msg.challengeId)
	end
end

function NoahChallengeModel:onNoahChallengeBaseInfoRes(msg)
	self._passAllStageChallengeIds = GameUtil.pbToTable(msg.passAllStageChallengeIds) or {}
end

function NoahChallengeModel:getCurStage(challengeId)
	if self._petInfoDic[challengeId] then
		return self._petInfoDic[challengeId].curStage
	else
		return 0
	end
end

function NoahChallengeModel:getMaxStageNum(challengeId)
	local cfg = NoahChallengeConfig.instance:getChallengeCfg(challengeId)

	if cfg then
		local list = NoahChallengeConfig.instance:getChallengeStageList(cfg.challengePlanId)

		return #list
	else
		return 1000
	end
end

function NoahChallengeModel:isPassed(challengeId)
	if self:isChallengeIdPassAllStage(challengeId) then
		return true
	end

	if self._petInfoDic[challengeId] and self._petInfoDic[challengeId].buyTime > 0 then
		return true
	end

	local curStage = self:getCurStage(challengeId)
	local maxStage = self:getMaxStageNum(challengeId)

	return maxStage <= curStage
end

function NoahChallengeModel:isNoStage(challengeId)
	if self._petInfoDic[challengeId] then
		return self._petInfoDic[challengeId].curStage == 0
	end

	return true
end

function NoahChallengeModel:isPetUsed(challengeId, petId)
	if self._petInfoDic[challengeId] then
		return TableUtil.isHad(self._petInfoDic[challengeId].usedPetIds, petId)
	else
		return false
	end
end

function NoahChallengeModel:isChallengeIdPassAllStage(challengeId)
	return TableUtil.isHad(self._passAllStageChallengeIds, challengeId)
end

NoahChallengeModel.instance = NoahChallengeModel.New()

return NoahChallengeModel
