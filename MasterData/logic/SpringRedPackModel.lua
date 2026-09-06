-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/model/SpringRedPackModel.lua

module("logic.extensions.springredpack.model.SpringRedPackModel", package.seeall)

local SpringRedPackModel = class("SpringRedPackModel", BaseModel)

SpringRedPackModel.None = 1
SpringRedPackModel.Countdown = 2
SpringRedPackModel.StartRedPack = 3
SpringRedPackModel.RedPackType = {
	DailyRedPack = 2,
	RoundRedPack = 1
}

function SpringRedPackModel:onInit()
	self:onReset()
end

function SpringRedPackModel:onReset()
	self._activityId = checknumber(SpringRedPackConfig.instance:getConstValue("EDITION_ACTIVITY"))
	self._dailyGainRound = 0
	self._hasGainDailyPrize = true
	self._roundGetList = {}
	self._requestRound = 0
	self._hasGainThisRound = false
	self._redPackPrizeId = 0
	self._otherPrizeIds = {}
	self._logs = {}
	self._curRoundId = -1
	self._curRedPackState = SpringRedPackModel.Default
end

function SpringRedPackModel:onGetRedPackInfoRes(msg)
	self._hasGainDailyPrize = msg.hasGainDailyPrize
	self._dailyGainRound = msg.dailyGainRound

	if msg:HasField("hasGainThisRound") then
		self._hasGainThisRound = msg.hasGainThisRound
	end
end

function SpringRedPackModel:onGainSpringRedPackRes(msg)
	self._redPackPrizeId = msg:HasField("redPackPrizeId") and msg.redPackPrizeId or 0
	self._otherPrizeIds = GameUtil.pbToTable(msg.otherPrizeIds) or {}
end

function SpringRedPackModel:onGetRedPackLogsRes(msg)
	self._logs = GameUtil.pbToTable(msg.logs) or {}

	GameUtil.reverse(self._logs)
end

function SpringRedPackModel:setHasGainThisRound(isGain)
	self._hasGainThisRound = isGain
	self._dailyGainRound = self._dailyGainRound + 1
end

function SpringRedPackModel:setHasGainDailyPrize(isGainDaily)
	self._hasGainDailyPrize = isGainDaily
end

function SpringRedPackModel:setCurRedPackState(state, round)
	self._curRedPackState = state
	self._curRoundId = round
end

function SpringRedPackModel:getCurRedPackState()
	return self._curRedPackState
end

function SpringRedPackModel:getCurRoundId()
	return self._curRoundId
end

function SpringRedPackModel:getCurActivityId()
	return self._activityId
end

function SpringRedPackModel:isUseAllRedPackCount()
	local cfg = SpringRedPackConfig.instance:getActivityCfg(self:getCurActivityId())

	if cfg then
		local maxCount = cfg.dailyRounds

		return maxCount <= self._dailyGainRound
	else
		return true
	end
end

function SpringRedPackModel:isGainDailyPrize()
	return self._hasGainDailyPrize
end

function SpringRedPackModel:isGainThisRound()
	return self._hasGainThisRound
end

function SpringRedPackModel:getDailyGainRound()
	return self._dailyGainRound
end

function SpringRedPackModel:getLogsList()
	return self._logs or {}
end

SpringRedPackModel.instance = SpringRedPackModel.New()

return SpringRedPackModel
