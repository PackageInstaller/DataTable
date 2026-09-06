-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/controller/CelebrateBirthdayController.lua

module("logic.extensions.celebratebirthday.controller.CelebrateBirthdayController", package.seeall)

local CelebrateBirthdayController = class("CelebrateBirthdayController", BaseController)

CelebrateBirthdayController.PM_MakeGiftGetInfo = "sendPM_MakeGiftGetInfoReq"
CelebrateBirthdayController.PM_MakeGiftMake = "sendPM_MakeGiftMakeReq"
CelebrateBirthdayController.PM_MakeGiftGainPrize = "sendPM_MakeGiftGainPrizeReq"

function CelebrateBirthdayController:onInit()
	CelebrateBirthdayController.super.onInit(self)

	self._sendParam = {}
end

function CelebrateBirthdayController:onReset()
	CelebrateBirthdayController.super.onReset(self)

	self._sendParam = {}
end

function CelebrateBirthdayController:sendMsg(method, ...)
	self._sendParam[method] = {
		...
	}

	MakeGiftAgent[method](MakeGiftAgent.instance, ...)
end

function CelebrateBirthdayController:handlePM_MakeGiftGetInfoRes(msg)
	CelebrateBirthdayModel.instance:setDailyTime(msg.dailyTime)
	CelebrateBirthdayModel.instance:setWeeklyTime(msg.weeklyTime)
	CelebrateBirthdayModel.instance:setTotalTime(msg.totalTime)
	CelebrateBirthdayModel.instance:setGainPrizeStatus(msg.gainPrizeStatus)
	CelebrateBirthdayModel.instance:setEarliestTime(msg.earliestTime)
	GlobalDispatcher:dispatch(CelebrateBirthdayController.PM_MakeGiftGetInfo)
end

function CelebrateBirthdayController:handlePM_MakeGiftMakeRes(msg)
	CelebrateBirthdayModel.instance:setDailyTime(msg.dailyTime)
	CelebrateBirthdayModel.instance:setWeeklyTime(msg.weeklyTime)
	CelebrateBirthdayModel.instance:setTotalTime(msg.totalTime)
	CelebrateBirthdayModel.instance:setEarliestTime(msg.earliestTime)
	GlobalDispatcher:dispatch(CelebrateBirthdayController.PM_MakeGiftMake, self._sendParam[CelebrateBirthdayController.PM_MakeGiftMake][2])
end

function CelebrateBirthdayController:handlePM_MakeGiftGainPrizeRes()
	local prizeId = self._sendParam[CelebrateBirthdayController.PM_MakeGiftGainPrize][2]

	CelebrateBirthdayModel.instance:gainPrize(prizeId)
	GlobalDispatcher:dispatch(CelebrateBirthdayController.PM_MakeGiftGainPrize, prizeId)
end

function CelebrateBirthdayController:getCurGiftList()
	return
end

CelebrateBirthdayController.instance = CelebrateBirthdayController.New()

return CelebrateBirthdayController
