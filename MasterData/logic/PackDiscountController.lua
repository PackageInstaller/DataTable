-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/controller/PackDiscountController.lua

module("logic.extensions.packdiscount.controller.PackDiscountController", package.seeall)

local PackDiscountController = class("PackDiscountController", BaseController)

function PackDiscountController:ctor()
	return
end

function PackDiscountController:onInit()
	self:onReset()
end

function PackDiscountController:onReset()
	return
end

function PackDiscountController:sendPM_PackDiscountGetInfoReq(activityId)
	PackDiscountAgent.instance:sendPM_PackDiscountGetInfoReq(activityId)
end

function PackDiscountController:handlePM_PackDiscountGetInfoRes(status, msg)
	PackDiscountModel.instance:setPackInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PackDiscountGetInfoRes, msg)
end

function PackDiscountController:handlePM_PackDiscountNotifyPaySucRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PackDiscountNotifyPaySucRes, msg)
end

function PackDiscountController:isBuyItem(itemId)
	local hasBuyItems = PackDiscountModel.instance:hasBuyItems()

	return TableUtil.isHad(hasBuyItems, itemId)
end

function PackDiscountController:isBuySingleItem()
	local hasBuyItems = PackDiscountModel.instance:hasBuyItems()

	return table.nums(hasBuyItems) > 0
end

function PackDiscountController:isBuyPack()
	return PackDiscountModel.instance:isBuyPack()
end

function PackDiscountController:isCanBuyPack()
	return not self:isBuyPack() and not self:isBuyItem()
end

function PackDiscountController:showHudInMain()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PackDiscount)
	local packCfg = PackDiscountConfig.instance:getDiscountPackCfg(activityId)
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PackDiscount, activityId)

	if actCfg then
		local isInTime = GameUtil.checkIsInTimePeriod(actCfg.startTime, actCfg.endTime)

		if isInTime then
			MainUIController.instance:openBottomLeftView(ViewName.PackDiscountHudView)
		else
			MainUIController.instance:closeBottomLeftView(ViewName.PackDiscountHudView)
		end
	else
		MainUIController.instance:closeBottomLeftView(ViewName.PackDiscountHudView)
	end
end

PackDiscountController.instance = PackDiscountController.New()

return PackDiscountController
