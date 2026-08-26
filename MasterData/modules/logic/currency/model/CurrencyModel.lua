-- chunkname: @modules/logic/currency/model/CurrencyModel.lua

module("modules.logic.currency.model.CurrencyModel", package.seeall)

local CurrencyModel = class("CurrencyModel", BaseModel)

function CurrencyModel:onInit()
	self._currencyList = {}
	self.powerCanBuyCount = 0
end

function CurrencyModel:getDiamond()
	local currency = self:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	return (currency or nil) and (currency.quantity or 0)
end

function CurrencyModel:getFreeDiamond()
	local currency = self:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	return (currency or nil) and (currency.quantity or 0)
end

function CurrencyModel:getGold()
	return self:getCurrency(CurrencyEnum.CurrencyType.Gold).quantity or 0
end

function CurrencyModel:getPower()
	return self:getCurrency(CurrencyEnum.CurrencyType.Power).quantity or 0
end

function CurrencyModel:getCurrency(currencyId)
	return self._currencyList[currencyId]
end

function CurrencyModel:getCurrencyList()
	return self._currencyList
end

function CurrencyModel:setCurrencyList(currencyList)
	self:_receiveCurrencyList(currencyList)
end

function CurrencyModel:changeCurrencyList(currencyList)
	if not currencyList then
		return
	end

	self:_receiveCurrencyList(currencyList)
end

function CurrencyModel:_receiveCurrencyList(currencyList)
	local changeIds = {}

	for i, v in ipairs(currencyList) do
		if not self._currencyList[v.currencyId] then
			local data = CurrencyMO.New()

			self._currencyList[v.currencyId]:init(v)

			self._currencyList[self._currencyList[v.currencyId].currencyId] = self._currencyList[v.currencyId]
			changeIds[v.currencyId] = true
		end
	end

	CurrencyController.instance:powerRecover()
	CurrencyController.instance:dispatchEvent(CurrencyEvent.CurrencyChange, changeIds)
end

function CurrencyModel:reInit()
	self._currencyList = {}
	self.powerCanBuyCount = 0
end

CurrencyModel.instance = CurrencyModel.New()

return CurrencyModel
