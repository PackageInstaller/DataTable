-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/currency/CurrencyService.lua

CurrencyService = class("CurrencyService", Service, _M)

local opType = {
	OPCODE_CURRENCY_BUY_GOLD = 10208,
	OPCODE_CURRENCY_BUY_EXP = 10206,
	OPCODE_CURRENCY_BUY_ENGRY = 10207,
	OPCODE_CURRENCY_BUY_CRYSTAL = 10210
}

function CurrencyService:initialize()
	super.initialize(self)
end

function CurrencyService:dispose()
	super.dispose(self)
end

function CurrencyService:requestBuyGold(params, callback)
	cjson = require("cjson")

	local request = self:newRequest(opType.OPCODE_CURRENCY_BUY_GOLD, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, true)
end

function CurrencyService:requestBuyCrystal(params, callback)
	cjson = require("cjson")

	dump(params)

	local request = self:newRequest(opType.OPCODE_CURRENCY_BUY_CRYSTAL, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, true)
end

function CurrencyService:requestBuyExp(params, callback)
	local request = self:newRequest(opType.OPCODE_CURRENCY_BUY_EXP, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, true)
end

function CurrencyService:requestBuyEngry(callback)
	cjson = require("cjson")

	local request = self:newRequest(opType.OPCODE_CURRENCY_BUY_ENGRY, {}, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, true)
end
