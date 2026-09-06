-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/StarGodPlusExchange/config/StarGodPlusExchangeConfig.lua

module("logic.extensions.stargodplusexchange.config.StarGodPlusExchangeConfig", package.seeall)

local StarGodPlusExchangeConfig = class("StarGodPlusExchangeConfig", BaseConfig)

function StarGodPlusExchangeConfig:onInit()
	StarGodPlusExchangeConfig.super.onInit(self)

	self._SummerCostCfg = nil
	self._SummerPrizeCfg = nil
end

function StarGodPlusExchangeConfig:getNames()
	return {
		"star_god_plus_exchange",
		"star_god_plus_exchange_random"
	}
end

function StarGodPlusExchangeConfig:handleConfig(name, content)
	if name == "star_god_plus_exchange" then
		self._commCfg = content
	elseif name == "star_god_plus_exchange_random" then
		self._actCfg = content
	end
end

function StarGodPlusExchangeConfig:getCommonCfg(key)
	return self._commCfg[key].value
end

StarGodPlusExchangeConfig.instance = StarGodPlusExchangeConfig.New()

return StarGodPlusExchangeConfig
