-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/controller/TunTianHelpController.lua

module("logic.extensions.tuntianhelp.controller.TunTianHelpController", package.seeall)

local TunTianHelpController = class("TunTianHelpController", BaseController)

function TunTianHelpController:ctor()
	return
end

function TunTianHelpController:onInit()
	self:onReset()
end

function TunTianHelpController:onReset()
	return
end

function TunTianHelpController:sendPM_TunTianHelpGetInfoReq(activityId)
	TunTianHelpAgent.instance:sendPM_TunTianHelpGetInfoReq(activityId)
end

function TunTianHelpController:handlePM_TunTianHelpGetInfoRes(msg)
	TunTianHelpModel.instance:handlePM_TunTianHelpGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianHelpGetInfoRes)
end

function TunTianHelpController:sendPM_TunTianHelpLotteryReq(activityId)
	TunTianHelpAgent.instance:sendPM_TunTianHelpLotteryReq(activityId)
end

function TunTianHelpController:handlePM_TunTianHelpLotteryRes(msg)
	TunTianHelpModel.instance:handlePM_TunTianHelpLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianHelpLotteryRes)
end

function TunTianHelpController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function TunTianHelpController:getActivityType()
	return GameEnum.ActivityType.TunTianHelp
end

function TunTianHelpController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function TunTianHelpController:getJumpPlanId()
	local jumpPlanId = 0
	local dataList = TunTianHelpConfig.instance:getTthSummaryBaseDataList()

	for _, data in ipairs(dataList) do
		if FuncOpenModel.instance:getFuncIsOpen(data.funcId) then
			jumpPlanId = data.jumpPlanId

			break
		end
	end

	return jumpPlanId
end

function TunTianHelpController:isInTimeAsTthSummary(jumpPlanId, jumpId)
	local timePeriod = self:getTimePeriodAsTthSummary(jumpPlanId, jumpId)

	return timePeriod == GameUtil.inTimePeriod
end

function TunTianHelpController:getTimePeriodAsTthSummary(jumpPlanId, jumpId)
	local data = TunTianHelpConfig.instance:getTthSummaryJumpData(jumpPlanId, jumpId)
	local timePeriod = GameUtil.getTimePeriod(data.startTime, data.endTime)

	if timePeriod == GameUtil.inTimePeriod and data.activityParams ~= nil then
		local activityType, activityId = data.activityParams[1], data.activityParams[2]
		local startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)

		timePeriod = GameUtil.getTimePeriodTypeBySec(startStamp, endStamp)
	end

	return timePeriod
end

function TunTianHelpController:getTryLotteryResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not self:isEnoughDailyLotteryTimes(activityId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "剩余次数不足"
	end

	return result, tips
end

function TunTianHelpController:isEnoughDailyLotteryTimes(activityId)
	local leftTimes = self:getLeftDailyLotteryTimes(activityId)

	return leftTimes > 0
end

function TunTianHelpController:getLeftDailyLotteryTimes(activityId)
	local maxTimes = self:getMaxDailyLotteryTimes(activityId)
	local curTimes = self:getDailyLotteryTimes()

	return Mathf.Max(maxTimes - curTimes, 0)
end

function TunTianHelpController:getDailyLotteryTimes()
	return TunTianHelpModel.instance:getDailyLotteryTimes()
end

function TunTianHelpController:getMaxDailyLotteryTimes(activityId)
	local baseData = TunTianHelpConfig.instance:getTthActBaseData(activityId)

	return baseData.dailyTimesLimit
end

TunTianHelpController.instance = TunTianHelpController.New()

return TunTianHelpController
