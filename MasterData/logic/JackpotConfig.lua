-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/config/JackpotConfig.lua

module("logic.extensions.jackpot.config.JackpotConfig", package.seeall)

local JackpotConfig = class("JackpotConfig", BaseConfig)

function JackpotConfig:onInit()
	JackpotConfig.super.onInit(self)
end

function JackpotConfig:getNames()
	return {
		"jackpot_activity",
		"jackpot_pool"
	}
end

function JackpotConfig:handleConfig(name, content)
	if name == "jackpot_activity" then
		self.activotyCfg = content
	elseif name == "jackpot_pool" then
		self.poolCfg = content
	end
end

function JackpotConfig:getActCfgs()
	return self.activotyCfg
end

function JackpotConfig:getActCfgById(actId)
	return self.activotyCfg[actId]
end

function JackpotConfig:getPoolCfg(jackpot)
	return self.poolCfg[jackpot]
end

function JackpotConfig:getMaxOrder(actId, order)
	local aCfg = self:getActCfgById(actId)
	local list = self:getPoolCfg(aCfg.jackpot)

	return #list
end

JackpotConfig.instance = JackpotConfig.New()

return JackpotConfig
