-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/config/CurrencyExchangeConfig.lua

module("logic.extensions.currencyexchange.config.CurrencyExchangeConfig", package.seeall)

local M = class("CurrencyExchangeConfig", BaseConfig)

function M:onInit()
	self._currencyExchange = {}
end

function M:getNames()
	return {
		ConfigName.CurrencyExchange
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.CurrencyExchange then
		for _, cfg in pairs(content.dataList or {}) do
			self._currencyExchange[cfg.id] = CurrencyExchangeCO.New(cfg)
		end
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getCurrencyExchange(id)
	return self._currencyExchange[id]
end

function M:getCurrencyExchangeCoLst()
	return self._currencyExchange
end

M.instance = M.New()

return M
