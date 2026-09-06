-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/model/GuessLanternModel.lua

module("logic.extensions.guesslantern.model.GuessLanternModel", package.seeall)

local GuessLanternModel = class("GuessLanternModel", BaseModel)

function GuessLanternModel:ctor()
	return
end

function GuessLanternModel:onInit()
	self:onReset()
end

function GuessLanternModel:onReset()
	self._activityId = 0
	self._problemList = {}
	self._guessNum = 0
	self._prizeId = {}
end

function GuessLanternModel:onGetInfoRes(msg)
	self._problemList = GameUtil.pbToTable(msg.problemList) or {}
	self._guessNum = msg.guessNum
	self._prizeId = GameUtil.pbToTable(msg.prizeId) or {}

	table.sort(self._problemList, function(a, b)
		return a.problemId < b.problemId
	end)
end

function GuessLanternModel:onIncProgressRes(msg)
	if self._activityId == msg.actId then
		self._guessNum = self._guessNum + 1

		local isExist = false

		for i, v in ipairs(self._problemList) do
			if v.problemId == msg.problemId then
				isExist = true
				v.isGuess = true

				break
			end
		end

		if not isExist then
			local element = {}

			element.problemId = msg.problemId
			element.isGuess = true

			table.insert(self._problemList, element)
		end

		table.sort(self._problemList, function(a, b)
			return a.problemId < b.problemId
		end)
		printInfo("test GuessLanternModel:onIncProgressRes0>")

		for i, v in ipairs(self._problemList) do
			printInfo("test GuessLanternModel:onIncProgressRes1>", v.problemId, v.isGuess)
		end
	end
end

function GuessLanternModel:onGainPrizeRes(msg)
	if self._activityId == msg.actId and not TableUtil.isHad(self._prizeId, msg.prizeId) then
		table.insert(self._prizeId, msg.prizeId)
	end
end

function GuessLanternModel:initActivity()
	local cfgActivity = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GuessLantern)

	if cfgActivity then
		self._activityId = cfgActivity.activityId or 307001
	end
end

function GuessLanternModel:getActivityId()
	if self._activityId > 0 then
		return self._activityId
	else
		self:initActivity()

		return self._activityId
	end
end

function GuessLanternModel:getActivityType()
	return GameEnum.ActivityType.GuessLantern
end

function GuessLanternModel:getRewardProgress()
	return self._guessNum
end

function GuessLanternModel:isPlayerRewardCanGet(prizeId, guessNum)
	local isScoreEnough = guessNum <= self:getRewardProgress()

	return isScoreEnough and not self:isPlayerRewardGeted(prizeId)
end

function GuessLanternModel:isPlayerRewardGeted(prizeId)
	return TableUtil.isHad(self._prizeId, prizeId)
end

function GuessLanternModel:isGuessedByIndex(index)
	for i, v in ipairs(self._problemList) do
		if i == index then
			return v.isGuess, v.problemId
		end
	end

	return false, 0
end

function GuessLanternModel:isGuessed(problemId)
	for i, v in ipairs(self._problemList) do
		if v.problemId == problemId then
			return v.isGuess
		end
	end
end

function GuessLanternModel:getNoGuessProblemIds()
	local problemList = {}

	for i, v in ipairs(self._problemList) do
		if not v.isGuess then
			table.insert(problemList, v.problemId)
		end
	end

	return problemList
end

GuessLanternModel.instance = GuessLanternModel.New()

return GuessLanternModel
