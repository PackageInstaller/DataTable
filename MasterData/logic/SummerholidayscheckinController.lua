-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerholidayscheckin/controller/SummerholidayscheckinController.lua

module("logic.extensions.summerholidayscheckin.controller.SummerholidayscheckinController", package.seeall)

local SummerholidayscheckinController = class("SummerholidayscheckinController", BaseController)

function SummerholidayscheckinController:ctor()
	return
end

function SummerholidayscheckinController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	self:onReset()
end

function SummerholidayscheckinController:onReset()
	return
end

function SummerholidayscheckinController:setCheckInRedpoint()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.SummerHolidaysCheckIn)
	local isInTime = activityId > 0

	if not isInTime then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUMMERHOLIDAY_GAIZHANG, false)

		return
	end

	local cfgs = SummerholidayscheckinConfig.instance:getPrizeCfgs(activityId)

	if cfgs then
		if not #cfgs then
			local cnt = 0
			local days = SummerholidayscheckinModel.instance:getCheckInDays()

			if cnt <= days then
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUMMERHOLIDAY_GAIZHANG, false)

				return
			end

			local cInTime = SummerholidayscheckinModel.instance:getTodayCheckInTimes()
			local actCfg = SummerholidayscheckinConfig.instance:getActCfg(activityId)

			if cInTime < actCfg.dailyCheckInLimit then
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUMMERHOLIDAY_GAIZHANG, true)

				return
			end

			RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUMMERHOLIDAY_GAIZHANG, false)
		end
	end
end

function SummerholidayscheckinController:_onStartEnterGame()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.SummerHolidaysCheckIn)

	if activityId <= 0 then
		return
	end

	SummerHolidaysCheckInAgent.instance:sendPM_SummerHolidaysCheckInGetInfoReq(activityId)
end

SummerholidayscheckinController.instance = SummerholidayscheckinController.New()

return SummerholidayscheckinController
