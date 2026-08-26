-- chunkname: @modules/logic/survival/controller/SurvivalStoreController.lua

module("modules.logic.survival.controller.SurvivalStoreController", package.seeall)

local SurvivalStoreController = class("SurvivalStoreController", BaseController)

function SurvivalStoreController:onInit()
	return
end

function SurvivalStoreController:reInit()
	return
end

function SurvivalStoreController:buyGoods(id, count, callback, callbackObj)
	SurvivalOutSideRpc.instance:sendSurvivalOutsideShopBuyRequest(id, count, callback, callbackObj)
end

SurvivalStoreController.instance = SurvivalStoreController.New()

return SurvivalStoreController
