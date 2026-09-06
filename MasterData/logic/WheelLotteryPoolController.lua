-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheellotterypool/controller/WheelLotteryPoolController.lua

module("logic.extensions.wheellotterypool.controller.WheelLotteryPoolController", package.seeall)

local WheelLotteryPoolController = class("WheelLotteryPoolController", BaseController)

function WheelLotteryPoolController:ctor()
	return
end

function WheelLotteryPoolController:onInit()
	return
end

function WheelLotteryPoolController:onReset()
	return
end

function WheelLotteryPoolController:sendPM_WheelLotteryGetInfoReq(activityId)
	WheelLotteryPoolAgent.instance:sendPM_WheelLotteryGetInfoReq(activityId)
end

function WheelLotteryPoolController:handlePM_WheelLotteryGetInfoRes(msg)
	WheelLotteryPoolModel.instance:handlePM_WheelLotteryGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WheelLotteryGetInfoRes)
end

function WheelLotteryPoolController:sendPM_WheelLotteryLotteryReq(activityId, poolId)
	WheelLotteryPoolAgent.instance:sendPM_WheelLotteryLotteryReq(activityId, poolId)
end

function WheelLotteryPoolController:handlePM_WheelLotteryLotteryRes(msg)
	WheelLotteryPoolModel.instance:handlePM_WheelLotteryLotteryRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WheelLotteryLotteryRes)
end

function WheelLotteryPoolController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function WheelLotteryPoolController:getSkinId(activityId)
	return WheelLotteryPoolConfig.instance:getCommonData(activityId).skinId
end

function WheelLotteryPoolController:getActivityType()
	return GameEnum.ActivityType.WheelLotteryPool
end

function WheelLotteryPoolController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

WheelLotteryPoolController.instance = WheelLotteryPoolController.New()

return WheelLotteryPoolController
