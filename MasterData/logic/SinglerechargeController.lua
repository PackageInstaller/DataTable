-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/singlerecharge/controller/SinglerechargeController.lua

module("logic.extensions.singlerecharge.controller.SinglerechargeController", package.seeall)

local SinglerechargeController = class("SinglerechargeController", BaseController)

SinglerechargeController.PM_SingleRechargeGainPrizeRes = "SinglerechargeController.PM_SingleRechargeGainPrizeRes"
SinglerechargeController.PM_SingleRechargeGetInfoRes = "SinglerechargeController.PM_SingleRechargeGetInfoRes"

function SinglerechargeController:ctor()
	return
end

function SinglerechargeController:onInit()
	GlobalDispatcher:addListener(SingleRechargeAgent.PM_SingleRechargeGainPrizeRes, self._PM_SingleRechargeGainPrizeRes, self)
	GlobalDispatcher:addListener(SingleRechargeAgent.PM_SingleRechargeGetInfoRes, self._PM_SingleRechargeGetInfoRes, self)
	self:onReset()
end

function SinglerechargeController:onReset()
	self._currGainPrizeId = 0
end

function SinglerechargeController:_PM_SingleRechargeGainPrizeRes(status, msg)
	if status == 0 and self._currGainPrizeId and self._currGainPrizeId > 0 then
		SinglerechargeModel.instance:gainPrizeRes(self._currGainPrizeId)
	end

	GlobalDispatcher:dispatch(SinglerechargeController.PM_SingleRechargeGainPrizeRes, status, msg)
end

function SinglerechargeController:_PM_SingleRechargeGetInfoRes(status, msg)
	if status == 0 then
		SinglerechargeModel.instance:setItems(msg.items)
	end

	GlobalDispatcher:dispatch(SinglerechargeController.PM_SingleRechargeGetInfoRes, status, msg)
end

function SinglerechargeController:sendPM_SingleRechargeGainPrizeReq(activityId, itemId)
	self._currGainPrizeId = itemId

	SingleRechargeAgent.instance:sendPM_SingleRechargeGainPrizeReq(activityId, itemId)
end

SinglerechargeController.instance = SinglerechargeController.New()

return SinglerechargeController
