-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/config/FanRuiLotteryConfig.lua

module("logic.extensions.fanruilottery.config.FanRuiLotteryConfig", package.seeall)

local FanRuiLotteryConfig = class("FanRuiLotteryConfig", BaseConfig)

function FanRuiLotteryConfig:onInit()
	return
end

function FanRuiLotteryConfig:getNames()
	return {
		"fan_rui_lottery_activity",
		"fan_rui_lottery_pool",
		"fan_rui_lottery_game",
		"fan_rui_lottery_rule"
	}
end

function FanRuiLotteryConfig:handleConfig(name, content)
	if name == "fan_rui_lottery_activity" then
		self._fan_rui_lottery_activity = content
	elseif name == "fan_rui_lottery_pool" then
		self._fan_rui_lottery_pool = content
	elseif name == "fan_rui_lottery_game" then
		self._fan_rui_lottery_game = content
	elseif name == "fan_rui_lottery_rule" then
		self._fan_rui_lottery_rule = content
	end
end

function FanRuiLotteryConfig:getActivityCfg(actId)
	return self._fan_rui_lottery_activity[actId]
end

function FanRuiLotteryConfig:getLotteryPrize(actId)
	return self._fan_rui_lottery_pool[actId]
end

function FanRuiLotteryConfig:getLotteryPrizeById(actId, prizeId)
	return self._fan_rui_lottery_pool[actId][prizeId]
end

function FanRuiLotteryConfig:getGameCfg(actId)
	return self._fan_rui_lottery_game[actId]
end

function FanRuiLotteryConfig:getRuleCfgs(ruleId)
	return self._fan_rui_lottery_rule[ruleId]
end

FanRuiLotteryConfig.instance = FanRuiLotteryConfig.New()

return FanRuiLotteryConfig
