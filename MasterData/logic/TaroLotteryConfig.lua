-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tarolottery/config/TaroLotteryConfig.lua

module("logic.extensions.tarolottery.config.TaroLotteryConfig", package.seeall)

local TaroLotteryConfig = class("TaroLotteryConfig", BaseConfig)

function TaroLotteryConfig:getNames()
	return {
		"tarot_lottery_activity",
		"tarot_lottery_pool",
		"tarot_lottery_big_prize",
		"tarot_lottery_progress"
	}
end

function TaroLotteryConfig:handleConfig(name, content)
	if name == "tarot_lottery_activity" then
		self._tarot_lottery_activity = content
	elseif name == "tarot_lottery_pool" then
		self._tarot_lottery_pool = content
	elseif name == "tarot_lottery_big_prize" then
		self._tarot_lottery_big_prize = content
	elseif name == "tarot_lottery_progress" then
		self._tarot_lottery_progress = content
	end
end

function TaroLotteryConfig:getActivityCfgById(activityId)
	return self._tarot_lottery_activity[activityId]
end

function TaroLotteryConfig:getPoolCfg(activityId)
	return self._tarot_lottery_pool[activityId]
end

function TaroLotteryConfig:getPrizeCfg(activityId)
	return self._tarot_lottery_big_prize[activityId]
end

function TaroLotteryConfig:getPrizeCfgById(activityId, tarotId)
	if self._tarot_lottery_big_prize[activityId] then
		return self._tarot_lottery_big_prize[activityId][tarotId]
	end
end

function TaroLotteryConfig:getProgressCfg(activityId)
	return self._tarot_lottery_progress[activityId]
end

TaroLotteryConfig.instance = TaroLotteryConfig.New()

return TaroLotteryConfig
