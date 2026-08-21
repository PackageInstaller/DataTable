-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/model/CurrencyExchangeModel.lua

module("logic.extensions.currencyexchange.model.CurrencyExchangeModel", package.seeall)

local M = class("CurrencyExchangeModel", BaseModel)

function M:ctor()
	return
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._exchangeMo = {}
end

function M:getExchangeMo(ruleId)
	if not self._exchangeMo[ruleId] then
		self._exchangeMo[ruleId] = CurrencyExchangeMo.New(ruleId)
	end

	return self._exchangeMo[ruleId]
end

function M:getRemainedTime(ruleId)
	local mo = self:getExchangeMo(ruleId)

	return mo:getRemainedTimes()
end

function M:getMaxTime(ruleId)
	local mo = self:getExchangeMo(ruleId)

	return mo:getMaxTime()
end

function M:canExchange(ruleId)
	local cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(ruleId)

	if cfgCO == nil then
		printError("无法从[t_%s]找到[%s]的数据", ConfigName.CurrencyExchange, ruleId)

		return true
	end

	local mo = self:getExchangeMo(ruleId)

	if mo then
		local remainedTimes = mo:getRemainedTimes()

		return remainedTimes and remainedTimes > 0
	else
		return true
	end
end

M.instance = M.New()

return M
