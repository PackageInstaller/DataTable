-- chunkname: @modules/logic/currency/controller/CurrencyJumpHandler.lua

module("modules.logic.currency.controller.CurrencyJumpHandler", package.seeall)

local CurrencyJumpHandler = class("CurrencyJumpHandler")

function CurrencyJumpHandler.JumpByCurrency(currencyId)
	CurrencyJumpHandler._handlerMap = CurrencyJumpHandler._handlerMap or {
		[CurrencyEnum.CurrencyType.Power] = CurrencyJumpHandler.handlePower,
		[CurrencyEnum.CurrencyType.Diamond] = CurrencyJumpHandler.handlePayDiamond,
		[CurrencyEnum.CurrencyType.FreeDiamondCoupon] = CurrencyJumpHandler.handleFreeDiamond,
		[CurrencyEnum.CurrencyType.Gold] = CurrencyJumpHandler.handleGold,
		[CurrencyEnum.CurrencyType.DryForest] = CurrencyJumpHandler.handleDryForest,
		[CurrencyEnum.CurrencyType.RoomCritterTrain] = CurrencyJumpHandler.handleRoomCritterTrain
	}

	local func = CurrencyJumpHandler._handlerMap[currencyId]

	if func then
		func()
	end
end

function CurrencyJumpHandler.handleGold()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.SummonExchange)
end

function CurrencyJumpHandler.handlePower()
	CurrencyController.instance:openPowerView()
end

function CurrencyJumpHandler.handleFreeDiamond()
	ViewMgr.instance:openView(ViewName.CurrencyDiamondExchangeView)
end

function CurrencyJumpHandler.handlePayDiamond()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
end

function CurrencyJumpHandler.handleDryForest()
	MaterialTipController.instance:showMaterialInfo(2, CurrencyEnum.CurrencyType.DryForest)
end

function CurrencyJumpHandler.handleRoomCritterTrain()
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function CurrencyJumpHandler.clearHandlers()
	CurrencyJumpHandler._handlerMap = nil
end

return CurrencyJumpHandler
