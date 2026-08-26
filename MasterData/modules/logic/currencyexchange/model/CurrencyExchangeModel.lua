-- chunkname: @modules/logic/currencyexchange/model/CurrencyExchangeModel.lua

module("modules.logic.currencyexchange.model.CurrencyExchangeModel", package.seeall)

local CurrencyExchangeModel = class("CurrencyExchangeModel", BaseModel)

function CurrencyExchangeModel:onInit()
	self:reInit()
end

function CurrencyExchangeModel:reInit()
	self._exchangeMoDic = {}
end

function CurrencyExchangeModel:initInfo(infoList)
	tabletool.clear(self._exchangeMoDic)

	if infoList and next(infoList) then
		for _, infoNO in ipairs(infoList) do
			local mo = CurrencyExchangeMo.New()

			mo:init(infoNO)

			self._exchangeMoDic[mo.currencyId] = mo
		end
	end

	CurrencyExchangeController.instance:dispatchEvent(CurrencyExchangeEvent.onGetInfo)
end

function CurrencyExchangeModel:onInfoChange(currencyIds)
	if currencyIds and next(currencyIds) then
		for _, currencyId in ipairs(currencyIds) do
			local mo = self._exchangeMoDic[currencyId]

			if mo then
				mo.isProp = CurrencyExchangeEnum.PropState.Proped
			end
		end
	end

	CurrencyExchangeController.instance:dispatchEvent(CurrencyExchangeEvent.onInfoChange)
end

function CurrencyExchangeModel:getInfoMo(currencyId)
	if not self._exchangeMoDic then
		return nil
	end

	return self._exchangeMoDic[currencyId]
end

CurrencyExchangeModel.instance = CurrencyExchangeModel.New()

return CurrencyExchangeModel
