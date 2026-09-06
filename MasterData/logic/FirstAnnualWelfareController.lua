-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/controller/FirstAnnualWelfareController.lua

module("logic.extensions.firstannualwelfare.controller.FirstAnnualWelfareController", package.seeall)

local FirstAnnualWelfareController = class("FirstAnnualWelfareController", BaseController)

function FirstAnnualWelfareController:ctor()
	return
end

function FirstAnnualWelfareController:onInit()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)
	self:onReset()
end

function FirstAnnualWelfareController:onReset()
	self:specialOnceRedPoint()
end

function FirstAnnualWelfareController:onRedPointChange()
	local rpKey = "FIRST_ANNUAL_WELFARE_MAIN_VIEW_DAILY"
	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FirstAnnualWelfare)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ANNUALWELFARE, (actTimeCfg or nil) and checknumber(GameUtil.getUserDayData(rpKey)) <= 0)
end

function FirstAnnualWelfareController:resetRedPoint()
	local rpKey = "FIRST_ANNUAL_WELFARE_MAIN_VIEW_DAILY"

	GameUtil.saveUserDayData(rpKey, 1)
end

function FirstAnnualWelfareController:specialOnceRedPoint()
	local activityType = GameEnum.ActivityType.FirstAnnualWelfare
	local activityId = ActivityDefineController.instance:getActivityIdByType(activityType)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
	local redId = RedPointModel.ID_ANNUALWELFARE_GOLDENDIAMONDCARD2

	if not isInTime then
		RedPointController.instance:setRedPointInfo(redId, false)
	else
		local key = string.format("FirstAnnualOnceRedPoint_%s", activityId)

		GameUtil.getUserData(key, function(value)
			RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0)
		end)
	end
end

function FirstAnnualWelfareController:saveSpecialOnceRedPoint(activityId)
	local redId = RedPointModel.ID_ANNUALWELFARE_GOLDENDIAMONDCARD2
	local key = string.format("FirstAnnualOnceRedPoint_%s", activityId)

	GameUtil.saveUserData(key, 1)
	RedPointController.instance:setRedPointInfo(redId, false)
end

function FirstAnnualWelfareController:onSendFirstAnnualWelfareGetInfoReq(activityId)
	FirstAnnualWelfareAgent.instance:sendPM_FirstAnnualWelfareGetInfoReq(activityId)
end

function FirstAnnualWelfareController:onHandleFirstAnnualWelfareGetInfoRes(msg)
	FirstAnnualWelfareModel.instance:onHandleFirstAnnualWelfareGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FirstAnnualWelfareGetInfoRes)
end

function FirstAnnualWelfareController:onSendFirstAnnualWelfareGainFreeGoldenCardReq(activityId)
	FirstAnnualWelfareAgent.instance:sendPM_FirstAnnualWelfareGainFreeGoldenCardReq(activityId)
end

function FirstAnnualWelfareController:onHandleFirstAnnualWelfareGainFreeGoldenCardRes(msg)
	FirstAnnualWelfareModel.instance:onHandleFirstAnnualWelfareGainFreeGoldenCardRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateGoldenDiamondCardInfo)
	GlobalDispatcher:dispatch(GlobalNotify.FirstAnnualWelfareGetInfoRes)
end

function FirstAnnualWelfareController:onSendFirstAnnualWelfareExchangeReq(activityId, exchangeIndex, choiceId, costIds)
	FirstAnnualWelfareAgent.instance:sendPM_FirstAnnualWelfareExchangeReq(activityId, exchangeIndex, choiceId, costIds)
end

function FirstAnnualWelfareController:onHandleFirstAnnualWelfareExchangeRes(msg)
	FirstAnnualWelfareModel.instance:onHandleFirstAnnualWelfareExchangeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FirstAnnualWelfareExchangeRes)
end

function FirstAnnualWelfareController:onSendFirstAnnualWelfareGainPetSkinReq(activityId, skinId)
	FirstAnnualWelfareAgent.instance:sendPM_FirstAnnualWelfareGainPetSkinReq(activityId, skinId)
end

function FirstAnnualWelfareController:onHandleFirstAnnualWelfareGainPetSkinRes(msg)
	FirstAnnualWelfareModel.instance:onHandleFirstAnnualWelfareGainPetSkinRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FirstAnnualWelfareGetInfoRes)
end

function FirstAnnualWelfareController:startEnterGame()
	return
end

function FirstAnnualWelfareController:dailyRefresh()
	return
end

FirstAnnualWelfareController.instance = FirstAnnualWelfareController.New()

return FirstAnnualWelfareController
