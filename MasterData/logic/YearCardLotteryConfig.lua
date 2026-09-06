-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/config/YearCardLotteryConfig.lua

module("logic.extensions.yearcardlottery.config.YearCardLotteryConfig", package.seeall)

local YearCardLotteryConfig = class("YearCardLotteryConfig", BaseConfig)

function YearCardLotteryConfig:onInit()
	YearCardLotteryConfig.super.onInit(self)

	self._commonCfgs = nil
	self._prizeCfgs = nil
end

function YearCardLotteryConfig:getNames()
	return {
		"annual_fee_skin",
		"annual_fee_skin_prize"
	}
end

function YearCardLotteryConfig:handleConfig(name, content)
	if name == "annual_fee_skin" then
		self._commonCfgs = content
	elseif name == "annual_fee_skin_prize" then
		self._prizeCfgs = content
	end
end

function YearCardLotteryConfig:getCommonCfg(actId)
	return self._commonCfgs[actId]
end

function YearCardLotteryConfig:getPrizeCfgs(actId)
	local actCfg = self:getCommonCfg(actId)

	if actCfg then
		return self._prizeCfgs[actCfg.prizePlanId]
	end
end

YearCardLotteryConfig.instance = YearCardLotteryConfig.New()

return YearCardLotteryConfig
