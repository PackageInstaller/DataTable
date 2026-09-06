-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/model/NewSummonPetObtainModel.lua

module("logic.extensions.newsummonpetobtain.model.NewSummonPetObtainModel", package.seeall)

local NewSummonPetObtainModel = class("NewSummonPetObtainModel", BaseModel)

function NewSummonPetObtainModel:ctor()
	return
end

function NewSummonPetObtainModel:onInit()
	self:onReset()
end

function NewSummonPetObtainModel:onReset()
	self._activityId = 0
	self._progressMsg = {}
	self._playerMsg = {}
	self._balanceLayerMsg = {}
	self._balanceStageMsg = {}
	self._balanceCustomFmtMo = nil
	self._curBalanceStageId = nil
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGetInfoRes(msg)
	self._activityId = msg.activityId
	self._progressMsg.score = msg.score
	self._progressMsg.gainedPrizeIds = msg.gainedPrizeIds
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGainPrizeRes(msg)
	self._activityId = msg.activityId
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGetPlayerInfoRes(msg)
	self._activityId = msg.activityId
	self._playerMsg.finalAccomplishId = msg.finalAccomplishId
	self._playerMsg.gainedTaskIds = msg.gainedTaskIds
	self._playerMsg.hasPlayGameToday = msg.hasPlayGameToday
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGameEndRes(msg)
	self._activityId = msg.activityId
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGainTaskScoreRes(msg)
	self._activityId = msg.activityId
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGetBalanceTierRes(msg)
	self._balanceLayerMsg.curTier = msg.curTier
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainGetBalanceInfoRes(msg)
	self._activityId = msg.activityId
	self._balanceLayerMsg.curTier = msg.curTier

	if self._balanceStageMsg[msg.stageId] == nil then
		self._balanceStageMsg[msg.stageId] = {}
	end

	self._balanceStageMsg[msg.stageId].stageId = msg.stageId
	self._balanceStageMsg[msg.stageId].maxScoreToday = msg.maxScoreToday
	self._balanceStageMsg[msg.stageId].black = msg.black
	self._balanceStageMsg[msg.stageId].white = msg.white
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainChallengeRes(msg)
	self._activityId = msg.activityId
end

function NewSummonPetObtainModel:handlePM_NewSummonPetObtainChallengeResultRes(msg)
	self._balanceLayerMsg.curTier = msg.curTier

	if self._balanceStageMsg[msg.stageId] == nil then
		self._balanceStageMsg[msg.stageId] = {}
	end

	self._balanceStageMsg[msg.stageId].stageId = msg.stageId
	self._balanceStageMsg[msg.stageId].maxScoreToday = msg.maxScoreToday
	self._balanceStageMsg[msg.stageId].black = msg.black
	self._balanceStageMsg[msg.stageId].white = msg.white
end

function NewSummonPetObtainModel:getCurActivityId()
	return self._activityId
end

function NewSummonPetObtainModel:getCurScoreInProgress()
	return self._progressMsg.score or 0
end

function NewSummonPetObtainModel:getGainedPrizeIdsInProgress()
	return self._progressMsg.gainedPrizeIds or {}
end

function NewSummonPetObtainModel:isHasGainPrizeInProgress(prizeId)
	local prizeIdList = self:getGainedPrizeIdsInProgress()

	for _, v in ipairs(prizeIdList) do
		if prizeId == v then
			return true
		end
	end

	return false
end

function NewSummonPetObtainModel:getFinalAccomplishIdInMusic()
	return self._playerMsg.finalAccomplishId or 0
end

function NewSummonPetObtainModel:isHasPlayGameTodayInMusic()
	return self._playerMsg.hasPlayGameToday or false
end

function NewSummonPetObtainModel:isHasGainTaskPrizeAsMusicTask(taskId)
	local taskIdList = self:_getGHainedTaskIdsInMusic()

	for _, v in ipairs(taskIdList) do
		if taskId == v then
			return true
		end
	end

	return false
end

function NewSummonPetObtainModel:_getGHainedTaskIdsInMusic()
	return self._playerMsg.gainedTaskIds or {}
end

function NewSummonPetObtainModel:getCurTierInBL()
	return self._balanceLayerMsg.curTier
end

function NewSummonPetObtainModel:saveCurStageId(stageId)
	self._curBalanceStageId = stageId
end

function NewSummonPetObtainModel:getCurStageId()
	return self._curBalanceStageId
end

function NewSummonPetObtainModel:getMaxScoreTodayInBS(stageId)
	return (self._balanceStageMsg[stageId] or nil) and (self._balanceStageMsg[stageId].maxScoreToday or 0)
end

function NewSummonPetObtainModel:getBalanceInfoInBS(stageId, ruleId, isBlack)
	local ruleInfo

	if self._balanceStageMsg[stageId] then
		if isBlack then
			for _, v in ipairs(self._balanceStageMsg[stageId].black) do
				if v.ruleId == ruleId then
					ruleInfo = v.info
				end
			end
		else
			for _, v in ipairs(self._balanceStageMsg[stageId].white) do
				if v.ruleId == ruleId then
					ruleInfo = v.info
				end
			end
		end
	end

	return ruleInfo
end

function NewSummonPetObtainModel:getCustomFmtMoAsBS()
	if self._balanceCustomFmtMo == nil then
		self._balanceCustomFmtMo = BalanceCustomFmtMo.New()
	end

	return self._balanceCustomFmtMo
end

NewSummonPetObtainModel.instance = NewSummonPetObtainModel.New()

return NewSummonPetObtainModel
