-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/config/WheelFortuneConfig.lua

module("logic.extensions.wheelfortune.config.WheelFortuneConfig", package.seeall)

local WheelFortuneConfig = class("WheelFortuneConfig", BaseConfig)

function WheelFortuneConfig:onInit()
	WheelFortuneConfig.super.onInit(self)
end

function WheelFortuneConfig:getNames()
	return {
		"wheel_fortune_activity",
		"wheel_fortune_pool"
	}
end

function WheelFortuneConfig:handleConfig(name, content)
	if name == "wheel_fortune_activity" then
		self.activotyCfg = content
	elseif name == "wheel_fortune_pool" then
		self.poolCfg = content
	end
end

function WheelFortuneConfig:getActCfgs()
	return self.activotyCfg
end

function WheelFortuneConfig:getActCfgById(actId)
	return self.activotyCfg[actId]
end

function WheelFortuneConfig:getPoolCfg(jackpot)
	return self.poolCfg[jackpot]
end

function WheelFortuneConfig:getFirstPrize(actId, orderId)
	local actCfg = self:getActCfgById(actId)
	local poolCfg = self:getPoolCfg(actCfg.prizePool)
	local orderCfg = poolCfg[orderId]

	for i, cfg in ipairs(orderCfg) do
		if cfg.type == 1 then
			return cfg
		end
	end

	return nil
end

function WheelFortuneConfig:getPrizeCfg(actId, orderId, prizeId)
	local actCfg = self:getActCfgById(actId)

	return self.poolCfg[actCfg.prizePool][orderId][prizeId]
end

function WheelFortuneConfig:getMaxOrder(actId)
	local aCfg = self:getActCfgById(actId)
	local list = self:getPoolCfg(aCfg.prizePool)

	return #list
end

WheelFortuneConfig.instance = WheelFortuneConfig.New()

return WheelFortuneConfig
