-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/controller/NewYearPrayController.lua

module("logic.extensions.newyearpray.controller.NewYearPrayController", package.seeall)

local NewYearPrayController = class("NewYearPrayController", BaseController)

function NewYearPrayController:ctor()
	return
end

function NewYearPrayController:onInit()
	return
end

function NewYearPrayController:onReset()
	return
end

function NewYearPrayController:sendPM_NewYearPrayGetInfoReq(activityId)
	NewYearPrayAgent.instance:sendPM_NewYearPrayGetInfoReq(activityId)
end

function NewYearPrayController:handlePM_NewYearPrayGetInfoRes(msg)
	self:getNypMo(msg.activityId):handlePM_NewYearPrayGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewYearPrayGetInfoRes)
end

function NewYearPrayController:sendPM_NewYearPrayDoPrayReq(activityId, stepChoices)
	NewYearPrayAgent.instance:sendPM_NewYearPrayDoPrayReq(activityId, stepChoices)
end

function NewYearPrayController:handlePM_NewYearPrayDoPrayRes(msg)
	self:getNypMo(msg.activityId):handlePM_NewYearPrayDoPrayRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewYearPrayDoPrayRes)
end

function NewYearPrayController:sendPM_NewYearPrayGainProgressPrizeReq(activityId, dataBitId)
	NewYearPrayAgent.instance:sendPM_NewYearPrayGainProgressPrizeReq(activityId, dataBitId)
end

function NewYearPrayController:handlePM_NewYearPrayGainProgressPrizeRes(msg)
	self:getNypMo(msg.activityId):handlePM_NewYearPrayGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewYearPrayGainProgressPrizeRes)
end

function NewYearPrayController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function NewYearPrayController:getActivityType()
	return GameEnum.ActivityType.NewYearPray
end

function NewYearPrayController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function NewYearPrayController:getNypMo(activityId)
	return NewYearPrayModel.instance:getNypMo(activityId)
end

function NewYearPrayController:getNypPlayerMo(activityId)
	return NewYearPrayModel.instance:getNypPlayerMo(activityId)
end

function NewYearPrayController:getTryGetPrizeOfProgressResultAndTips(activityId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeOfProgress(activityId, dataBitId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已领取"
	elseif not self:isEnoughGetPrizeOfProgress(activityId, dataBitId) then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "未满足"
	end

	return result, tips
end

function NewYearPrayController:isCanGetPrizeOfProgress(activityId, dataBitId)
	local result = self:getTryGetPrizeOfProgressResultAndTips(activityId, dataBitId)

	return result == GameEnum.ResultCode.Success
end

function NewYearPrayController:isEnoughGetPrizeOfProgress(activityId, dataBitId)
	local curProgress = self:getProgress(activityId)
	local data = NewYearPrayConfig.instance:getNypProgressData(activityId, dataBitId)

	return curProgress >= data.progress
end

function NewYearPrayController:isHasGainPrizeOfProgress(activityId, dataBitId)
	local list = self:getDataBitIdListOfHasGain(activityId)

	return table.indexof(list, dataBitId) ~= false
end

function NewYearPrayController:getTrEnterPrayResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not self:isEnoughCountToPlay(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "今日已祈愿"
	end

	return result, tips
end

function NewYearPrayController:isEnoughCountToPlay(activityId)
	local leftCount = self:getLeftActCount(activityId)

	return leftCount > 0
end

function NewYearPrayController:getLeftActCount(activityId)
	return self:getNypMo(activityId):getLeftActCount()
end

function NewYearPrayController:getProgress(activityId)
	return self:getNypMo(activityId):getProgress()
end

function NewYearPrayController:getDataBitIdListOfHasGain(activityId)
	return self:getNypMo(activityId):getDataBitIdListOfHasGain()
end

function NewYearPrayController:getScoreOfStep(activityId, stepId)
	return self:getNypMo(activityId):getScoreOfStep(stepId)
end

function NewYearPrayController:getTodayWishingTabId(activityId)
	local key = "Nyp_Wishing_tab"
	local value = GameUtil.getUserDayData(key)

	if value == nil then
		local cfg = NewYearPrayConfig.instance:getNypWishingTabCfgByAct(activityId)

		value = Mathf.Random(1, #cfg)

		GameUtil.saveUserDayData(key, tabId)
	end

	return checknumber(value)
end

NewYearPrayController.instance = NewYearPrayController.New()

return NewYearPrayController
