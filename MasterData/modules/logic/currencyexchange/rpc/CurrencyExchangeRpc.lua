-- chunkname: @modules/logic/currencyexchange/rpc/CurrencyExchangeRpc.lua

module("modules.logic.currencyexchange.rpc.CurrencyExchangeRpc", package.seeall)

local CurrencyExchangeRpc = class("CurrencyExchangeRpc", BaseRpc)

CurrencyExchangeRpc.instance = CurrencyExchangeRpc.New()

return CurrencyExchangeRpc
