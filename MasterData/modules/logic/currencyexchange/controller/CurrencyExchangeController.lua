-- chunkname: @modules/logic/currencyexchange/controller/CurrencyExchangeController.lua

module("modules.logic.currencyexchange.controller.CurrencyExchangeController", package.seeall)

local CurrencyExchangeController = class("CurrencyExchangeController", BaseController)

function CurrencyExchangeController:onInit()
	return
end

function CurrencyExchangeController:onInitFinish()
	return
end

function CurrencyExchangeController:addConstEvents()
	return
end

function CurrencyExchangeController:reInit()
	return
end

function CurrencyExchangeController:setCurrencyExchangeState(currencyId)
	local infoMo = CurrencyExchangeModel.instance:getInfoMo(currencyId)

	if not infoMo then
		return
	end

	if infoMo:isProped() then
		return
	end

	local idList = {
		currencyId
	}

	self._curCurrencyId = currencyId

	CurrencyRpc.instance:sendPopExchangeSameCurrencyRequest(idList, self.openCurCurrencyExchangeView, self)
end

function CurrencyExchangeController:openCurCurrencyExchangeView()
	if self._curCurrencyId == nil then
		return
	end

	local param = {}

	param.currencyId = self._curCurrencyId

	ViewMgr.instance:openView(ViewName.CurrencyExchangeTipsView, param)

	self._curCurrencyId = nil
end

function CurrencyExchangeController:openCurrencyExchangeView(currencyId)
	if currencyId == nil then
		return
	end

	local param = {}

	param.currencyId = currencyId

	ViewMgr.instance:openView(ViewName.CurrencyExchangeTipsView, param)
end

CurrencyExchangeController.instance = CurrencyExchangeController.New()

return CurrencyExchangeController
