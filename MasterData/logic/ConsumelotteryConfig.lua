-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/config/ConsumelotteryConfig.lua

module("logic.extensions.consumelottery.config.ConsumelotteryConfig", package.seeall)

local ConsumelotteryConfig = class("ConsumelotteryConfig", BaseConfig)

function ConsumelotteryConfig:onInit()
	return
end

function ConsumelotteryConfig:getNames()
	return {
		"consume_lottery_activity",
		"consume_lottery_prize"
	}
end

function ConsumelotteryConfig:handleConfig(name, content)
	if name == "consume_lottery_activity" then
		self._consume_lottery_activityCfg = content
	elseif name == "consume_lottery_prize" then
		self._consume_lottery_prizeCfg = content
	end
end

function ConsumelotteryConfig:getActCfgs()
	return self._consume_lottery_activityCfg
end

function ConsumelotteryConfig:getActCfg(actId)
	return self._consume_lottery_activityCfg[actId]
end

function ConsumelotteryConfig:getLotteryPrizeCfg(planId)
	return self._consume_lottery_prizeCfg[planId]
end

function ConsumelotteryConfig:getMustHitNum(actId)
	return self._consume_lottery_activityCfg[actId].pledgeNum
end

function ConsumelotteryConfig:getRecharMoneyToTicket(actId)
	return self._consume_lottery_activityCfg[actId].ticketPrice
end

ConsumelotteryConfig.instance = ConsumelotteryConfig.New()

return ConsumelotteryConfig
