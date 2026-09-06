-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/controller/OperationSignInController.lua

module("logic.extensions.operationsignin.controller.OperationSignInController", package.seeall)

local OperationSignInController = class("OperationSignInController", BaseController)

function OperationSignInController:ctor()
	return
end

function OperationSignInController:onInit()
	OperationCheckInAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onShowChangeSet, self))
end

function OperationSignInController:onReset()
	return
end

function OperationSignInController:getInfo(callback)
	local activityId = OperationSignInModel.instance:getActivityId()

	OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(activityId, function(msg)
		OperationSignInModel.instance:setData(msg)
		OperationSignInModel.instance:setLastTimeStamp()

		if callback then
			GameUtil.callBack(callback, msg)
		end

		GlobalDispatcher:dispatch(GlobalNotify.OperationSignIn)
	end)
end

function OperationSignInController:getIfNewDay()
	local lastTimeStamp = OperationSignInModel.instance:getLastTimeStamp()

	if lastTimeStamp then
		local lastTimeObj = GameUtil.time2date(lastTimeStamp)
		local lastWeekDay = lastTimeObj.wday
		local lastHour = lastTimeObj.hour

		if lastHour >= 0 and lastHour < 5 then
			lastWeekDay = lastWeekDay + 6
		end

		lastWeekDay = lastWeekDay % 7

		local curTime = GameUtil.time2date(ServerTime.now())
		local curWeekDay = curTime.wday
		local curHour = curTime.hour

		if curHour >= 0 and curHour < 5 then
			curWeekDay = curWeekDay + 6
		end

		curWeekDay = curWeekDay % 7

		return curWeekDay ~= lastWeekDay
	else
		return false
	end
end

function OperationSignInController:gainPrize(day, callback)
	local activityId = OperationSignInModel.instance:getActivityId()

	OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(activityId, day, function(msg)
		OperationSignInModel.instance:setDaysList(day)
		GameUtil.callBack(callback, msg)
	end)
end

function OperationSignInController:updateActivityId()
	local activityId
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn)

	if cfg then
		activityId = cfg.activityId
	end

	OperationSignInModel.instance:setActivityId(activityId)

	local isOpen = activityId ~= nil

	GlobalDispatcher:dispatch(GlobalNotify.TimedItemChange)

	return isOpen
end

function OperationSignInController:onShowChangeSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		if msgName == "handlePM_OperationCheckInGainPrizeRes" then
			self:notify(GlobalNotify.OperationSignInGetPrize, changeSetId)
			MaterialController.instance:setChangeSetPopup(changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
			MaterialController.instance:showItemsGetWindow(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

OperationSignInController.instance = OperationSignInController.New()

return OperationSignInController
