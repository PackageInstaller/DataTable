-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/controller/FanTianChallengeController.lua

module("logic.extensions.fantian.controller.FanTianChallengeController", package.seeall)

local FanTianChallengeController = class("FanTianChallengeController", BaseController)

function FanTianChallengeController:onInit()
	self:onReset()
end

function FanTianChallengeController:onReset()
	self._fmtMoMap = self._fmtMoMap or {}

	table.clear(self._fmtMoMap)
end

function FanTianChallengeController:getActivityId()
	local activityType = 313

	return (ActivityDefineController.instance:getActivityIdByType(activityType))
end

function FanTianChallengeController:sendGetInfo(actId)
	FanTianChallengeAgent.instance:sendPM_FanTianClgGetInfoReq(actId)
end

function FanTianChallengeController:handlePM_FanTianClgGetInfoRes(msg)
	FanTianChallengeModel.instance:handlePM_FanTianClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FanTianChallengeUpdate)
end

function FanTianChallengeController:sendGetPrize(actId, id)
	FanTianChallengeAgent.instance:sendPM_FanTianClgGainProgressPrizeReq(actId, id)
end

function FanTianChallengeController:handlePM_FanTianClgGainProgressPrizeRes(msg)
	FanTianChallengeModel.instance:handlePM_FanTianClgGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FanTianChallengeUpdate)
end

function FanTianChallengeController:openFmtView(activityId, curSelectTierId, curSelectLevel, viewName)
	self._resultViewName = viewName

	local fanTianFmtMo = self._fmtMoMap[activityId]

	if not fanTianFmtMo then
		fanTianFmtMo = FanTianFmtMo.New()
		self._fmtMoMap[activityId] = fanTianFmtMo
	end

	fanTianFmtMo:initParams(activityId, curSelectTierId, curSelectLevel)
	CustomFmtController.instance:showMissionView(fanTianFmtMo)
end

function FanTianChallengeController:sendStartFight(activityId, curSelectTierId, curSelectLevel, simpleForm)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	FanTianChallengeAgent.instance:sendPM_FanTianClgFightReq(activityId, curSelectTierId, curSelectLevel, simpleForm)
end

function FanTianChallengeController:onGetFighMsg(msg)
	self._activityId = msg.activityId
	self._tierIdWhenFight = msg.tierIdWhenFight
	self._stageIdWhenFight = msg.stageIdWhenFight
	self._isWin = msg.win

	FanTianChallengeModel.instance:updateHasGainSoulCreepsId(msg)
end

function FanTianChallengeController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(self._resultViewName, self._activityId, self._tierIdWhenFight, self._stageIdWhenFight)

	return true
end

FanTianChallengeController.instance = FanTianChallengeController.New()

return FanTianChallengeController
