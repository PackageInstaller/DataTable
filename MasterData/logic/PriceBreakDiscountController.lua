-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/controller/PriceBreakDiscountController.lua

module("logic.extensions.pricebreakdiscount.controller.PriceBreakDiscountController", package.seeall)

local PriceBreakDiscountController = class("PriceBreakDiscountController", BaseController)

function PriceBreakDiscountController:ctor()
	return
end

function PriceBreakDiscountController:onInit()
	GlobalDispatcher:addListener(PriceBreakDiscountAgent.PM_PriceBreakDiscountGetInfoRes, self._PM_PriceBreakDiscountGetInfoRes, self)
	GlobalDispatcher:addListener(PriceBreakDiscountAgent.PM_PriceBreakDiscountBuyRes, self._PM_PriceBreakDiscountBuyRes, self)
	GlobalDispatcher:addListener(PriceBreakDiscountAgent.PM_PriceBreakDiscountSaveCartRes, self._PM_PriceBreakDiscountSaveCartRes, self)
	self:onReset()
end

function PriceBreakDiscountController:onReset()
	return
end

function PriceBreakDiscountController:_PM_PriceBreakDiscountGetInfoRes(msg)
	PriceBreakDiscountModel.instance:setData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PriceBreakDiscountGetInfo)
end

function PriceBreakDiscountController:sendPM_PriceBreakDiscountBuyReq(activityId, inflationMoneyActivityIsOpen)
	local cartItem = {}

	for i, v in pairs(PriceBreakDiscountModel.instance:getTrolley()) do
		if v > 0 then
			local item = PriceBreakDiscountExtension_pb.PriceBreakItem()

			item.itemId = i
			item.itemNum = v

			table.insert(cartItem, item)
		end
	end

	if #cartItem > 0 then
		inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen or false

		PriceBreakDiscountAgent.instance:sendPM_PriceBreakDiscountBuyReq(activityId, cartItem, inflationMoneyActivityIsOpen)
	else
		FloatWordMgr.instance:show(lang("请挑选商品"))
	end
end

function PriceBreakDiscountController:_PM_PriceBreakDiscountBuyRes(msg)
	PriceBreakDiscountModel.instance:setDataAfterData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PriceBreakDiscountBuy)
end

function PriceBreakDiscountController:sendPM_PriceBreakDiscountSaveCartReq(activityId)
	local cartItem = {}

	for i, v in pairs(PriceBreakDiscountModel.instance:getTrolley()) do
		if v > 0 then
			local item = PriceBreakDiscountExtension_pb.PriceBreakItem()

			item.itemId = i
			item.itemNum = v

			table.insert(cartItem, item)
		end
	end

	PriceBreakDiscountAgent.instance:sendPM_PriceBreakDiscountSaveCartReq(activityId, cartItem)
end

function PriceBreakDiscountController:_PM_PriceBreakDiscountSaveCartRes()
	GlobalDispatcher:dispatch(GlobalNotify.PriceBreakDiscountSaveCart)
end

PriceBreakDiscountController.instance = PriceBreakDiscountController.New()

return PriceBreakDiscountController
