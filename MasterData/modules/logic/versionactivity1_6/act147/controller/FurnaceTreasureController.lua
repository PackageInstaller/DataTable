-- chunkname: @modules/logic/versionactivity1_6/act147/controller/FurnaceTreasureController.lua

module("modules.logic.versionactivity1_6.act147.controller.FurnaceTreasureController", package.seeall)

local FurnaceTreasureController = class("FurnaceTreasureController", BaseController)

function FurnaceTreasureController:onInit()
	return
end

function FurnaceTreasureController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshActivityInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshActivityInfo, self)
end

function FurnaceTreasureController:reInit()
	return
end

function FurnaceTreasureController:refreshActivityInfo(argsActId)
	local actId = FurnaceTreasureModel.instance:getActId()
	local hasArgsActId = not string.nilorempty(argsActId) and argsActId ~= 0

	if hasArgsActId and argsActId ~= actId then
		return
	end

	local isOpen = FurnaceTreasureModel.instance:isActivityOpen()

	if isOpen then
		FurnaceTreasureRpc.instance:sendGetAct147InfosRequest(actId)
	elseif hasArgsActId then
		FurnaceTreasureModel.instance:resetData(true)
	end
end

function FurnaceTreasureController:BuyFurnaceTreasureGoods(storeId, goodsId, cb, cbObj)
	local isCanBuy = false

	if storeId and goodsId then
		local goodsRemainBuyCount = FurnaceTreasureModel.instance:getGoodsRemainCount(storeId, goodsId)

		isCanBuy = goodsRemainBuyCount >= FurnaceTreasureEnum.DEFAULT_BUY_COUNT
	end

	if not isCanBuy then
		if cb then
			cb(cbObj)
		end

		GameFacade.showToast(ToastEnum.CurrencyChanged)

		return
	end

	local actId = FurnaceTreasureModel.instance:getActId()

	FurnaceTreasureRpc.instance:sendBuyAct147GoodsRequest(actId, storeId, goodsId, FurnaceTreasureEnum.DEFAULT_BUY_COUNT, cb, cbObj)
end

FurnaceTreasureController.instance = FurnaceTreasureController.New()

return FurnaceTreasureController
