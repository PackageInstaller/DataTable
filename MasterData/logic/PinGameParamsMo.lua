-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameParamsMo.lua

module("logic.extensions.pingame.view.ui.PinGameParamsMo", package.seeall)

local PinGameParamsMo = class("PinGameParamsMo")

PinGameParamsMo.CallBackType_RuningExit = "CallBackType_RuningExit"
PinGameParamsMo.CallBackType_GameFinish = "CallBackType_GameFinish"

function PinGameParamsMo:ctor(stagePlanId, stageId, isLocalGame, activityId)
	self._stagePlanId = stagePlanId
	self._stageId = stageId
	self._isLocalGame = checkbool(isLocalGame)
	self._activityId = activityId or 0
	self._gameEndCallBack = nil
end

function PinGameParamsMo:getStagePlanId()
	return self._stagePlanId
end

function PinGameParamsMo:getStageId()
	return self._stageId
end

function PinGameParamsMo:isLocalGame()
	return self._isLocalGame
end

function PinGameParamsMo:getActivityId()
	return self._activityId
end

function PinGameParamsMo:getGameEndCallBack()
	return self._gameEndCallBack
end

function PinGameParamsMo:setGameEndCallBack(callBack)
	self._gameEndCallBack = callBack
end

return PinGameParamsMo
