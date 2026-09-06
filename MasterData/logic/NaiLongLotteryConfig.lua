-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/config/NaiLongLotteryConfig.lua

module("logic.extensions.nailonglottery.config.NaiLongLotteryConfig", package.seeall)

local NaiLongLotteryConfig = class("NaiLongLotteryConfig", BaseConfig)

function NaiLongLotteryConfig:onInit()
	NaiLongLotteryConfig.super.onInit(self)
end

function NaiLongLotteryConfig:getNames()
	return {
		"share_lottery_activity",
		"share_lottery_progress_unlock",
		"share_lottery_progress_prize",
		"share_lottery_prize"
	}
end

function NaiLongLotteryConfig:handleConfig(name, content)
	if name == "share_lottery_activity" then
		self._share_lottery_activity = content
	elseif name == "share_lottery_progress_unlock" then
		self._share_lottery_progress_unlock = content
	elseif name == "share_lottery_progress_prize" then
		self._share_lottery_progress_prize = content
	elseif name == "share_lottery_prize" then
		self._share_lottery_prize = content
	end
end

function NaiLongLotteryConfig:getActData(activityId)
	return self._share_lottery_activity[activityId]
end

function NaiLongLotteryConfig:getProgressUnlockCfg(activityId)
	return self._share_lottery_progress_unlock[activityId]
end

function NaiLongLotteryConfig:getProgressUnlockData(activityId, index)
	if self._share_lottery_progress_unlock[activityId] then
		return self._share_lottery_progress_unlock[activityId][index]
	end
end

function NaiLongLotteryConfig:getProgressPrizeCfg(activityId)
	return self._share_lottery_progress_prize[activityId]
end

function NaiLongLotteryConfig:getProgressPrizeData(activityId, prizeId)
	if self._share_lottery_progress_prize[activityId] then
		return self._share_lottery_progress_prize[activityId][prizeId]
	end
end

function NaiLongLotteryConfig:getPrizeCfg(activityId)
	return self._share_lottery_prize[activityId]
end

function NaiLongLotteryConfig:getPrizeData(activityId, prizeId)
	if self._share_lottery_prize[activityId] then
		return self._share_lottery_prize[activityId][prizeId]
	end
end

NaiLongLotteryConfig.instance = NaiLongLotteryConfig.New()

return NaiLongLotteryConfig
