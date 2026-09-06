-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/model/GuessBoxModel.lua

module("logic.extensions.guessbox.model.GuessBoxModel", package.seeall)

local GuessBoxModel = class("GuessBoxModel", BaseModel)

function GuessBoxModel:ctor()
	return
end

function GuessBoxModel:onInit()
	self:onReset()
end

function GuessBoxModel:onReset()
	self._activityId = 0
	self._dailyHasPlayeTimes = 0
	self._weeklyHasPlayeTimes = 0
	self._clientKey = 0
	self._serverKey = 0
	self._score = 0
	self._flowerIds = {}
end

function GuessBoxModel:onHandleGuessBoxGameGetInfoRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._dailyHasPlayeTimes = checknumber(msg.dailyHasPlayeTimes)
	self._weeklyHasPlayeTimes = checknumber(msg.weeklyHasPlayeTimes)
	self._score = checknumber(msg.score)
	self._gainedScorePrizeIds = msg.gainedScorePrizeIds or {}
end

function GuessBoxModel:onHandleGuessBoxGameStartGameRes(msg)
	self._serverKey = msg.serverKey
	self._flowerIds = {}
end

function GuessBoxModel:onHandleGuessBoxGameEndGameRes(msg)
	self._dailyHasPlayeTimes = checknumber(msg.dailyHasPlayeTimes)
	self._weeklyHasPlayeTimes = checknumber(msg.weeklyHasPlayeTimes)
	self._serverKey = 0
end

function GuessBoxModel:onHandleGuessBoxGameEndGameRes(msg)
	local data = GameUtil.pbToTable(msg)

	self._activityId = checknumber(data.activityId)
	self._rankInfo = data.infoList
	self._myRank = checknumber(data.myRank)
end

function GuessBoxModel:getActivityId()
	return self._activityId
end

function GuessBoxModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.GuessBoxGame)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.GuessBoxGame)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GuessBoxGame, v.activityId) then
			local cfg = GuessBoxConfig.instance:getGbCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_guess_box_game no cfg, id = " .. v.activityId)

			break
		end
	end

	return actId
end

function GuessBoxModel:getDailyHasPlayeTimes()
	return self._dailyHasPlayeTimes
end

function GuessBoxModel:getWeeklyHasPlayeTimes()
	return self._weeklyHasPlayeTimes
end

function GuessBoxModel:saveClientKey(key)
	self._clientKey = key
end

function GuessBoxModel:getClientKey()
	return self._clientKey
end

function GuessBoxModel:getServerKey()
	return self._serverKey
end

function GuessBoxModel:saveFlowerIds(FlowerIds)
	self._flowerIds = FlowerIds
end

function GuessBoxModel:getFlowerIds()
	return self._flowerIds
end

function GuessBoxModel:getMyRank()
	return checknumber(self._myRank)
end

function GuessBoxModel:getRankInfo()
	return self._rankInfo or {}
end

function GuessBoxModel:getScore()
	return self._score
end

function GuessBoxModel:getGainedScorePrizeIds()
	return self._gainedScorePrizeIds
end

function GuessBoxModel:isCanGetProgressReward(actId, prizeId)
	if self._activityId ~= actId then
		return false
	end

	local cfg = GuessBoxConfig.instance:getRewardProgressListCfg(actId, prizeId)

	if cfg then
		return self._score >= cfg.score and not self:isGetedProgressReward(actId, prizeId)
	else
		return false
	end
end

function GuessBoxModel:isGetedProgressReward(actId, prizeId)
	if self._activityId ~= actId then
		return false
	end

	for i, v in ipairs(self._gainedScorePrizeIds) do
		if v == prizeId then
			return true
		end
	end

	return false
end

function GuessBoxModel:setGameScore(score)
	self._gameScore = score
end

function GuessBoxModel:getGameScore()
	return checknumber(self._gameScore)
end

GuessBoxModel.instance = GuessBoxModel.New()

return GuessBoxModel
