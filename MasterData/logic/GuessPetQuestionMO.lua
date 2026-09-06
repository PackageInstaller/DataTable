-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/model/GuessPetQuestionMO.lua

module("logic.extensions.guesspets.model.GuessPetQuestionMO", package.seeall)

local GuessPetQuestionMO = class("GuessPetQuestionMO")

function GuessPetQuestionMO:ctor()
	self.raceId = 0
	self.pictureId = 0
	self.questStartStamp = 0
	self.questEndStamp = 0
	self.questPreparingStamp = 0
	self.answers = nil
	self.playerAnswers = nil
	self.nextQuestionRecvTime = 0
end

function GuessPetQuestionMO:getStartDeltaTime()
	return self.questStartStamp - ServerTime.now()
end

function GuessPetQuestionMO:isWaitingPreparing()
	return ServerTime.now() < self.questPreparingStamp
end

function GuessPetQuestionMO:isDoing()
	local startTime = self.questStartStamp
	local endTime = self.questEndStamp
	local now = ServerTime.now()

	return startTime <= now and now < endTime
end

function GuessPetQuestionMO:getEndDeltaTime()
	return self.questEndStamp - ServerTime.now()
end

function GuessPetQuestionMO:isPassed()
	return self:getEndDeltaTime() <= 0
end

function GuessPetQuestionMO:setPlayerAnswer(userId, answer, isFirstCorrect, addScores)
	self.playerAnswers = self.playerAnswers or {}
	self.playerAnswers[userId] = {
		answer = answer,
		isFirstCorrect = isFirstCorrect,
		addScores = addScores
	}
end

function GuessPetQuestionMO:getPlayerAnswer(userId)
	if self.playerAnswers then
		return self.playerAnswers[userId]
	end
end

return GuessPetQuestionMO
