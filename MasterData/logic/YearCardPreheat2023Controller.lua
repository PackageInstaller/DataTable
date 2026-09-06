-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/controller/YearCardPreheat2023Controller.lua

module("logic.extensions.yearcardpreheat2023.controller.YearCardPreheat2023Controller", package.seeall)

local YearCardPreheat2023Controller = class("YearCardPreheat2023Controller", BaseController)

function YearCardPreheat2023Controller:onReset()
	return
end

function YearCardPreheat2023Controller:getInfo(actId)
	AnnualFeePreheat2023Agent.instance:sendPM_AFP2023GetInfoReq(actId)
end

function YearCardPreheat2023Controller:handleGetInfo(msg)
	YearCardPreheat2023Model.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023UpdateInfo)
end

function YearCardPreheat2023Controller:move(actId, x, y)
	AnnualFeePreheat2023Agent.instance:sendPM_AFP2023MoveReq(actId, x, y)
end

function YearCardPreheat2023Controller:handleMove(msg)
	YearCardPreheat2023Model.instance:onMove(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023Domove)
end

function YearCardPreheat2023Controller:dealEvent(actId, x, y)
	AnnualFeePreheat2023Agent.instance:sendPM_AFP2023DoEventReq(actId, x, y)
end

function YearCardPreheat2023Controller:handleDealEvent(msg)
	return
end

function YearCardPreheat2023Controller:collateClue(actId)
	AnnualFeePreheat2023Agent.instance:sendPM_AFP2023CollateClueReq(actId)
end

function YearCardPreheat2023Controller:handleCollateClue(msg)
	YearCardPreheat2023Model.instance:onCollateClue(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023UpdateInfo)
end

function YearCardPreheat2023Controller:gainPersonPrize(actId, id)
	AnnualFeePreheat2023Agent.instance:sendPM_AFP2023GainPersonPrizeReq(actId, id)
end

function YearCardPreheat2023Controller:handleGainPersonPrize(msg)
	YearCardPreheat2023Model.instance:onGainPersonPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023UpdateInfo)
end

function YearCardPreheat2023Controller:gainProgressPrzie(actId, id)
	AnnualFeePreheat2023Agent.instance:sendPM_AFP2023GainProgressPrizeReq(actId, id)
end

function YearCardPreheat2023Controller:handleGainProgressPrize(msg)
	YearCardPreheat2023Model.instance:onGainProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023UpdateInfo)
end

function YearCardPreheat2023Controller:handleEventFinish(msg)
	YearCardPreheat2023Model.instance:onEventFinish(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023UpdateInfo)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheat2023Domove)
end

function YearCardPreheat2023Controller:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function YearCardPreheat2023Controller:getActivityType()
	return GameEnum.ActivityType.YearCard_Preheat_2023
end

function YearCardPreheat2023Controller:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

YearCardPreheat2023Controller.instance = YearCardPreheat2023Controller.New()

return YearCardPreheat2023Controller
