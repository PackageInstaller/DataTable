-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/model/FamilyPartyModel.lua

module("logic.extensions.familyparty.model.FamilyPartyModel", package.seeall)

local FamilyPartyModel = class("FamilyPartyModel", BaseModel)

function FamilyPartyModel:onInit()
	self:onReset()
end

function FamilyPartyModel:onReset()
	self._partyTimeMillis = -1
	self._idlePrizeInfo = nil
	self._answerGameInfo = nil
	self._tempAnswerGameInfo = nil
	self._finalQuestion = nil
	self._questionIndex = 0
	self._optionId = 0
	self._questionDic = {}
end

function FamilyPartyModel:onGainIdlePrizeRes(msg)
	if msg:HasField("idlePrizeInfo") then
		self._idlePrizeInfo = GameUtil.pbToTable(msg.idlePrizeInfo)
	end
end

function FamilyPartyModel:onAnswerQuestionRes(msg)
	local optionId = self:getAnswerQuestionInfo(self._answerGameInfo.currentIndex)

	if optionId > 0 then
		self._answerGameInfo.mySelectOptionId = optionId
	end
end

function FamilyPartyModel:onOpenPartyRes(msg)
	return
end

function FamilyPartyModel:onNotifyPartyBeginRes(msg)
	self._partyTimeMillis = msg.partyTimeMillis
	self._idlePrizeInfo = GameUtil.pbToTable(msg.idlePrizeInfo)
	self._finalQuestion = nil
end

function FamilyPartyModel:onNotifyPartyEndRes(msg)
	self:clearAnswerQuestionInfos()

	self._partyTimeMillis = -1
	self._idlePrizeInfo = nil
	self._answerGameInfo = nil
	self._finalQuestion = nil
end

function FamilyPartyModel:onNotifyNextQuestionRes(msg)
	self._answerGameInfo = {}
	self._answerGameInfo.currentIndex = msg.index
	self._answerGameInfo.currentQuestionId = msg.questionId
	self._answerGameInfo.stateStartMillis = msg.stateStartMillis
	self._answerGameInfo.state = 1
end

function FamilyPartyModel:onNotifyQuestionResultRes(msg)
	self._finalQuestion = msg.finalQuestion

	if self._answerGameInfo then
		self._answerGameInfo.currentIndex = msg.index
		self._answerGameInfo.correctOptionId = msg.correctOptionId
		self._answerGameInfo.mySelectOptionId = msg.mySelectOptionId
		self._answerGameInfo.stateStartMillis = msg.stateStartMillis
		self._answerGameInfo.optionUserCounts = GameUtil.pbToTable(msg.optionUserCounts)
		self._answerGameInfo.state = 2
	end
end

function FamilyPartyModel:onNotifyOptionInfoChangeRes(msg)
	if self._answerGameInfo then
		self._answerGameInfo.optionUserCounts = GameUtil.pbToTable(msg.optionUserCounts)
	end
end

function FamilyPartyModel:isPartyOpening()
	local curTimestamp = ServerTime.now()
	local handOpenTimestamp = Mathf.Floor(checknumber(self._partyTimeMillis) / 1000)

	if handOpenTimestamp > 0 and handOpenTimestamp <= curTimestamp then
		return true
	end

	return false
end

function FamilyPartyModel:setFamilyCubeInfo(familyCubeInfo)
	if familyCubeInfo then
		self._partyTimeMillis = familyCubeInfo.partyTimeMillis
		self._idlePrizeInfo = familyCubeInfo.idlePrizeInfo
		self._answerGameInfo = familyCubeInfo.answerGameInfo

		if self._answerGameInfo and self._answerGameInfo.currentQuestionId then
			FamilyPartyModel.instance:setAnswerQuestionInfo(self._answerGameInfo.currentQuestionId, self._answerGameInfo.mySelectOptionId)
		end

		if self._answerGameInfo and self._answerGameInfo.currentIndex >= 0 then
			self._finalQuestion = nil
		end
	end
end

function FamilyPartyModel:setAnswerQuestionInfo(index, optionId)
	self._questionDic[index] = optionId
end

function FamilyPartyModel:getAnswerQuestionInfo(index)
	return self._questionDic[index]
end

function FamilyPartyModel:clearAnswerQuestionInfos()
	table.clear(self._questionDic)
end

function FamilyPartyModel:getPartyStartTime()
	return Mathf.Round(checknumber(self._partyTimeMillis) / 1000)
end

function FamilyPartyModel:getPartyTimeMillis()
	return self._partyTimeMillis
end

function FamilyPartyModel:setPartyTimeMillis(partyTimeMillis)
	self._partyTimeMillis = partyTimeMillis
end

function FamilyPartyModel:getPartyEndTime()
	local startTimestamp = self:getPartyStartTime()
	local minute = checknumber(FamilyPartyConfig.instance:getCommonValue("PARTY_PERIOD_MINUTES"))
	local sec = minute * 60

	return startTimestamp + sec
end

function FamilyPartyModel:getStartIdleTimestamp()
	if self._idlePrizeInfo then
		if checknumber(self._idlePrizeInfo.startIdleTimeMillis) > 0 then
			return (Mathf.Round(checknumber(self._idlePrizeInfo.startIdleTimeMillis) / 1000))
		end

		return -1
	else
		return -1
	end
end

function FamilyPartyModel:getAccIdlePrizeCount()
	if self._idlePrizeInfo then
		return self._idlePrizeInfo.accIdlePrizeCount
	else
		return 0
	end
end

function FamilyPartyModel:getHasGainIdlePrizeCount()
	if self._idlePrizeInfo then
		return self._idlePrizeInfo.hasGainPrizeCount
	else
		return 0
	end
end

function FamilyPartyModel:getWeeklyGainPrizeCount()
	return 0
end

function FamilyPartyModel:isStartAnswerQuestion()
	if self._answerGameInfo and self._answerGameInfo.currentIndex ~= 0 then
		return true
	else
		return false
	end
end

function FamilyPartyModel:isAnswerQuestioning()
	local index = self:getAnswerQuestionCurIndex()

	return not self._finalQuestion and index > 0
end

function FamilyPartyModel:isAnswerEnd()
	local index = self:getAnswerQuestionCurIndex()

	return self._finalQuestion or index < 0
end

function FamilyPartyModel:getStartAnswerQuestionTime()
	local minute = checknumber(FamilyPartyConfig.instance:getCommonValue("QUESTION_GAME_BEGIN_MINUTES"))
	local sec = minute * 60

	return self:getPartyStartTime() + sec
end

function FamilyPartyModel:getAnswerQuestionCurIndex()
	if self._answerGameInfo then
		return self._answerGameInfo.currentIndex
	else
		return 0
	end
end

function FamilyPartyModel:getAnswerGameInfo()
	return self._answerGameInfo
end

function FamilyPartyModel:getUserCount(optionId)
	if self._answerGameInfo and self._answerGameInfo.optionUserCounts then
		for i, v in ipairs(self._answerGameInfo.optionUserCounts) do
			if v.optionId == optionId then
				return v.userCount
			end
		end

		return 0
	else
		return 0
	end
end

function FamilyPartyModel:isCanAnswerQuestionState()
	return self._answerGameInfo.state == 1
end

FamilyPartyModel.instance = FamilyPartyModel.New()

return FamilyPartyModel
