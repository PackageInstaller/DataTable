-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/config/TopUpLotteryConfig.lua

module("logic.extensions.topuplottery.config.TopUpLotteryConfig", package.seeall)

local TopUpLotteryConfig = class("TopUpLotteryConfig", BaseConfig)

function TopUpLotteryConfig:onInit()
	TopUpLotteryConfig.super.onInit(self)
end

function TopUpLotteryConfig:getNames()
	return {
		"topup_lottery",
		"topup_lottery_prize"
	}
end

function TopUpLotteryConfig:handleConfig(name, content)
	if name == "topup_lottery" then
		self._topup_lottery = content
	elseif name == "topup_lottery_prize" then
		self._topup_lottery_prize = content
	end
end

function TopUpLotteryConfig:getActivityConfig(activityId)
	return self._topup_lottery[activityId]
end

function TopUpLotteryConfig:getPrizeConfigs(prizePlanId)
	return self._topup_lottery_prize[prizePlanId]
end

TopUpLotteryConfig.instance = TopUpLotteryConfig.New()

return TopUpLotteryConfig
