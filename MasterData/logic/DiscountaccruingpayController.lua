-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/discountaccruingpay/controller/DiscountaccruingpayController.lua

module("logic.extensions.discountaccruingpay.controller.DiscountaccruingpayController", package.seeall)

local DiscountaccruingpayController = class("DiscountaccruingpayController", BaseController)

DiscountaccruingpayController.GetPayInfoRes = "DiscountaccruingpayController.GetPayInfoRes"
DiscountaccruingpayController.GainExGiftRes = "DiscountaccruingpayController.GainExGiftRes"
DiscountaccruingpayController.PM_NotifyBuyGiftRes = "DiscountaccruingpayController.PM_NotifyBuyGiftRes"

function DiscountaccruingpayController:ctor()
	return
end

function DiscountaccruingpayController:onInit()
	GlobalDispatcher:addListener(DiscountAccruingPayAgent.GetPayInfoRes, self._GetPayInfoRes, self)
	GlobalDispatcher:addListener(DiscountAccruingPayAgent.GainExGiftRes, self._GainExGiftRes, self)
	GlobalDispatcher:addListener(DiscountAccruingPayAgent.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	self:onReset()
end

function DiscountaccruingpayController:onReset()
	return
end

function DiscountaccruingpayController:openView()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.DiscountaccruingPay)

	if cfg then
		UIStateManager.instance:push(ViewName.DiscountaccruingpayView, cfg.activityId)
	else
		FloatWordMgr.instance:show("不在活动开放时间内")
	end
end

function DiscountaccruingpayController:_GetPayInfoRes(status, msg)
	if status == 0 then
		DiscountaccruingpayModel.instance:setPayInfos(msg)
	end

	GlobalDispatcher:dispatch(DiscountaccruingpayController.GetPayInfoRes, status, msg)
end

function DiscountaccruingpayController:_GainExGiftRes(status, msg)
	if status == 0 then
		DiscountaccruingpayModel.instance:setGainExGiftRes(msg.activityId)
	end

	GlobalDispatcher:dispatch(DiscountaccruingpayController.GainExGiftRes, status, msg)
end

function DiscountaccruingpayController:_PM_NotifyBuyGiftRes(status, msg)
	if status == 0 then
		DiscountaccruingpayModel.instance:setBuyGiftInfo(msg.info)
	end

	GlobalDispatcher:dispatch(DiscountaccruingpayController.PM_NotifyBuyGiftRes, status, msg)
end

DiscountaccruingpayController.instance = DiscountaccruingpayController.New()

return DiscountaccruingpayController
