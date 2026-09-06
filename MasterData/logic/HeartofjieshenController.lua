-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/controller/HeartofjieshenController.lua

module("logic.extensions.heartofjieshen.controller.HeartofjieshenController", package.seeall)

local HeartofjieshenController = class("HeartofjieshenController", BaseController)

function HeartofjieshenController:ctor()
	return
end

function HeartofjieshenController:onInit()
	self:onReset()
end

function HeartofjieshenController:onReset()
	return
end

function HeartofjieshenController:getActivityId()
	return 389001
end

function HeartofjieshenController:enterMission(activityId, creepsMasterId, fmtType, resultViewName)
	self._resultViewName = resultViewName

	local mo = HeartofjieshenModel.instance:getFmtMo()

	mo:initParams(activityId, creepsMasterId, fmtType)
	CustomFmtController.instance:showMissionView(mo)
end

function HeartofjieshenController:sendFightYi(activityId, simpleForm)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	HeartOfJieShenClgAgent.instance:sendPM_HeartOfJieShenClgFightYiReq(activityId, simpleForm)
end

function HeartofjieshenController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(self._resultViewName, self._activityId)

	return true
end

function HeartofjieshenController:sendFightChi(activityId, simpleForm)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEndChi, self))
	HeartOfJieShenClgAgent.instance:sendPM_HeartOfJieShenClgFightChiReq(activityId, simpleForm)
end

function HeartofjieshenController:onBattleEndChi()
	BattleFacade.instance:registerResultHandler(nil, nil)
	HeartofjieshenModel.instance:resetClgFinishDic()
end

HeartofjieshenController.instance = HeartofjieshenController.New()

return HeartofjieshenController
