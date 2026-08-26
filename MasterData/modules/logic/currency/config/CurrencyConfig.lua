-- chunkname: @modules/logic/currency/config/CurrencyConfig.lua

module("modules.logic.currency.config.CurrencyConfig", package.seeall)

local CurrencyConfig = class("CurrencyConfig", BaseConfig)

function CurrencyConfig:ctor()
	self._currencyConfig = nil
end

function CurrencyConfig:reqConfigNames()
	return {
		"currency"
	}
end

function CurrencyConfig:onConfigLoaded(configName, configTable)
	if configName == "currency" then
		self._currencyConfig = configTable
	end
end

function CurrencyConfig:getCurrencyCo(currencyId)
	return self._currencyConfig.configDict[currencyId]
end

function CurrencyConfig:getAllCurrency()
	local allCurrency = {}

	for key, config in pairs(self._currencyConfig.configDict) do
		table.insert(allCurrency, key)
	end

	return allCurrency
end

CurrencyConfig.instance = CurrencyConfig.New()

return CurrencyConfig
