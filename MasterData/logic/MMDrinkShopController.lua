-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/controller/MMDrinkShopController.lua

module("logic.extensions.mmdrinkshop.controller.MMDrinkShopController", package.seeall)

local MMDrinkShopController = class("MMDrinkShopController", BaseController)

function MMDrinkShopController:onInit()
	self:onReset()
end

function MMDrinkShopController:onReset()
	return
end

function MMDrinkShopController:getDefaultActivityId()
	return 596001
end

function MMDrinkShopController:getInfo(activityId)
	MMDrinkShopAgent.instance:sendPM_MMDrinkShopGetInfoReq(activityId)
end

function MMDrinkShopController:handlePM_MMDrinkShopGetInfoRes(msg)
	MMDrinkShopModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MMDrinkShopGetInfoRes)
end

function MMDrinkShopController:startMake(activityId, slotId, steps_pb_Ary)
	MMDrinkShopAgent.instance:sendPM_MMDrinkShopStartMakeReq(activityId, slotId, steps_pb_Ary)
end

function MMDrinkShopController:handlePM_MMDrinkShopStartMakeRes(msg)
	MMDrinkShopModel.instance:onStartMake(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MMDrinkShopStartMakeRes)
end

function MMDrinkShopController:finishMake(activityId, slotId)
	MMDrinkShopAgent.instance:sendPM_MMDrinkShopFinishMakeReq(activityId, slotId)
end

function MMDrinkShopController:handlePM_MMDrinkShopFinishMakeRes(msg)
	MMDrinkShopModel.instance:onFinishMake(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MMDrinkShopFinishMakeRes)
end

function MMDrinkShopController:gainPrize(activityId, prizeId)
	MMDrinkShopAgent.instance:sendPM_MMDrinkShopGainPrizeReq(activityId, prizeId)
end

function MMDrinkShopController:handlePM_MMDrinkShopGainPrizeRes(msg)
	MMDrinkShopModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MMDrinkShopGainPrizeRes)
end

MMDrinkShopController.instance = MMDrinkShopController.New()

return MMDrinkShopController
