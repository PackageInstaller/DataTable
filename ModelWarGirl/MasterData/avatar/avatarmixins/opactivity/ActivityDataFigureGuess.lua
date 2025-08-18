-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataFigureGuess.lua

local ResOpActivityGuessAward = require("ClientData/ResOpActivityGuessAward")
local ResOpActivityGuessMisc = require("ClientData/ResOpActivityGuessMisc")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityGuessQuestion = require("ClientData/ResOpActivityGuessQuestion")
local PlayerPrefs = UnityEngine.PlayerPrefs
local ActivityDataFigureGuess = Class("ActivityDataFigureGuess", ActivityDataBase)

Const.GUESS_TYPE_QUESTION = 1
Const.GUESS_TYPE_ANSWER = 2
Const.GUESS_TYPE_MESSAGE = 3
Const.GUESS_TYPE_END = 4
Const.GUESS_STATE_NOT_OPEN = 1
Const.GUESS_STATE_OPEN = 2
Const.GUESS_STATE_GUESSED = 3
Const.GUESS_STATE_ANSWER = 4

function ActivityDataFigureGuess:ctor()
	self.answerType2IdxDic = {
		2,
		1,
		3
	}
end

function ActivityDataFigureGuess:updateClientData(actId)
	self.actId = actId
	self.miscConfig = ResOpActivityGuessMisc[actId] or {}
	self.heroId = self.miscConfig.hero_id
	self.awardId = self.miscConfig.award_id
	self.questionData = ResOpActivityGuessQuestion[actId]
	self.guessDataList = {}
end

function ActivityDataFigureGuess:updateRoleData(roleData)
	self.guessDataList = roleData.guess.data

	local personJoinMarkDic = roleData.guess.is_guessed and ClientUtils.getBitsDictFromByteString(roleData.guess.is_guessed) or {}
	local personAwardMarkDic = roleData.guess.person_is_awarded and ClientUtils.getBitsDictFromByteString(roleData.guess.person_is_awarded) or {}
	local personLookResultDic = roleData.guess.award_is_watched and ClientUtils.getBitsDictFromByteString(roleData.guess.award_is_watched) or {}

	if self.guessDataList then
		for i = 1, #self.guessDataList do
			local data = self.guessDataList[i]

			data.checkPersonJoin = personJoinMarkDic[i] or false
			data.checkPersonAward = personAwardMarkDic[i] or false
			data.lookResult = personLookResultDic[i] or false
		end
	end
end

function ActivityDataFigureGuess:getCurDay()
	local nowTime = ClientUtils.getServerTime()
	local day = math.floor((nowTime - self.actObject.startTime) / 86400) + 1

	return day
end

function ActivityDataFigureGuess:getMyGuessData(answerType)
	if not self.guessDataList then
		return nil
	end

	local idx = self.answerType2IdxDic[answerType]

	return self.guessDataList[idx]
end

function ActivityDataFigureGuess:getCircleGuessData(answerType)
	local opId = self.actObject.opId

	if CurAvatar.myCircle and CurAvatar.myCircle.actData then
		local actData = CurAvatar.myCircle.actData[opId]

		if actData and actData.guessDataList then
			local idx = self.answerType2IdxDic[answerType]
			local circleGuessData = actData.guessDataList[idx]

			return circleGuessData
		else
			return nil
		end
	else
		return nil
	end
end

function ActivityDataFigureGuess:getTotalAwardNum()
	local num = 0

	if self.guessDataList then
		for i = 1, #self.guessDataList do
			local data = self.guessDataList[i]

			if data.checkPersonAward then
				local checkRight = data.right_id == data.choose_id
				local awardConfig = ResOpActivityGuessAward[1][data.award_scheme]

				num = num + (checkRight and awardConfig.win_award or awardConfig.loss_award)
			end

			if data.clan_award then
				num = num + data.clan_award
			end
		end
	end

	return num
end

function ActivityDataFigureGuess:checkTodayAnimed(curDay)
	local key = CurAvatar.uid .. "_" .. self.actObject.opId
	local lastDay = PlayerPrefs.GetInt(key) or 0

	return curDay <= lastDay
end

function ActivityDataFigureGuess:setTodayAnimed(curDay)
	local key = CurAvatar.uid .. "_" .. self.actObject.opId

	PlayerPrefs.SetInt(key, curDay)
end

function ActivityDataFigureGuess:onOpActGuessChooseAnswerResp(answerId, rightNum, wrongNum)
	return
end

function ActivityDataFigureGuess:onOpActGuessAwardInfuseResp(stageId, award, rightNum, wrongNum)
	if not self.guessDataList or not self.guessDataList[stageId] then
		return
	end

	local guessData = self.guessDataList[stageId]

	guessData.clan_award = award
	guessData.right_number = rightNum
	guessData.wrong_number = wrongNum
end

function ActivityDataFigureGuess:getShowBonusDay()
	local day = self:getCurDay()

	if self.guessDataList then
		local answerConfigList = self.questionData[Const.GUESS_TYPE_ANSWER]

		for guessId = 1, #self.guessDataList do
			local data = self.guessDataList[guessId]
			local answerConfig = answerConfigList[guessId] or {}

			if data.checkPersonJoin and day >= answerConfig.unlock_time and not data.lookResult then
				return guessId
			end
		end
	end
end

function ActivityDataFigureGuess:setShowBonusDay(guessId)
	RPC.opActGuessWatch(self.actObject.opId, guessId)
end

function ActivityDataFigureGuess:registerRDEvent()
	ActivityDataFigureGuess.super.registerRDEvent(self)

	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_CIRCLE)
	end
end

function ActivityDataFigureGuess:unRegistRDEvent()
	ActivityDataFigureGuess.super.unRegistRDEvent(self)

	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_CIRCLE)
	end
end

function ActivityDataFigureGuess:checkNew()
	if self.actObject.startTime then
		if self:checkGuessNew() then
			return true
		end

		if self:checkClanBonusNew() then
			return true
		end
	end
end

function ActivityDataFigureGuess:checkClanBonusNew()
	local day = self:getCurDay()
	local answerConfigList = self.questionData[Const.GUESS_TYPE_ANSWER]

	for i, answerConfig in ipairs(answerConfigList) do
		if day >= answerConfig.unlock_time then
			local sData = self.guessDataList[answerConfig.param] or {}

			if sData.clan_award == nil or sData.clan_award == 0 then
				return true
			end
		else
			return false
		end
	end

	return false
end

function ActivityDataFigureGuess:checkGuessNew()
	local state, config = self:getQuestionState()

	if state == Const.GUESS_TYPE_QUESTION then
		if self.guessDataList then
			local guessData = self.guessDataList[config.param]

			if guessData.choose_id and guessData.choose_id > 0 then
				return false
			end
		end

		return true
	end

	return false
end

function ActivityDataFigureGuess:getQuestionState(day)
	day = day or self:getCurDay()

	local curState = Const.GUESS_TYPE_END
	local curQuestionConfig
	local guessConfigList = self.questionData[Const.GUESS_TYPE_QUESTION]
	local answerConfigList = self.questionData[Const.GUESS_TYPE_ANSWER]

	for i, guessConfig in ipairs(guessConfigList) do
		local answerConfig = answerConfigList[i]

		if day < guessConfig.unlock_time then
			return curState, curQuestionConfig
		elseif day < answerConfig.unlock_time then
			return Const.GUESS_TYPE_QUESTION, guessConfig
		elseif answerConfig.unlock_time == day then
			return Const.GUESS_TYPE_ANSWER, guessConfig
		else
			curState = Const.GUESS_TYPE_ANSWER
			curQuestionConfig = guessConfig
		end
	end

	return Const.GUESS_TYPE_END, curQuestionConfig
end

function ActivityDataFigureGuess:getCircleAllWinNum()
	local personalWinNum = 0
	local clanWinNum = 0

	for index, guessConfig in ipairs(self.questionData[Const.GUESS_TYPE_QUESTION]) do
		local guessData = self.guessDataList[index]

		if guessData and guessData.choose_id == guessData.right_id then
			personalWinNum = personalWinNum + 1
		end

		if self:isCircleGuessWin(index) then
			clanWinNum = clanWinNum + 1
		end
	end

	return personalWinNum, clanWinNum
end

function ActivityDataFigureGuess:isCircleGuessWin(index)
	local guessData = self.guessDataList[index]

	if guessData and guessData.clan_award > 0 then
		local winNum = guessData.right_number
		local loseNum = guessData.wrong_number

		return loseNum < winNum, winNum, loseNum
	elseif CurAvatar.myCircle and CurAvatar.myCircle.actData then
		local actData = CurAvatar.myCircle.actData[self.actObject.opId]

		if actData and actData.guessDataList then
			local circleGuessData = actData.guessDataList[index]

			if circleGuessData then
				return circleGuessData.right_number > circleGuessData.wrong_number, circleGuessData.right_number, circleGuessData.wrong_number
			else
				return false, 0, 0
			end
		end
	end
end

function ActivityDataFigureGuess:getGuessState(questionId)
	local day = self:getCurDay()
	local guessConfig = self.questionData[Const.GUESS_TYPE_QUESTION][questionId]
	local answerConfig = self.questionData[Const.GUESS_TYPE_ANSWER][questionId]

	if day < guessConfig.unlock_time then
		return Const.GUESS_STATE_NOT_OPEN
	elseif day < answerConfig.unlock_time then
		local guessData = self.guessDataList[questionId]

		if guessData and guessData.choose_id and guessData.choose_id > 0 then
			return Const.GUESS_STATE_GUESSED
		else
			return Const.GUESS_STATE_OPEN
		end
	else
		return Const.GUESS_STATE_ANSWER
	end
end

return ActivityDataFigureGuess
