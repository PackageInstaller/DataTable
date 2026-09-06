-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/controller/DuoLaLightController.lua

module("logic.extensions.duolalight.controller.DuoLaLightController", package.seeall)

local DuoLaLightController = class("DuoLaLightController", BaseController)

function DuoLaLightController:ctor()
	return
end

function DuoLaLightController:onInit()
	self:onReset()
end

function DuoLaLightController:onReset()
	self._activityId = 0
end

function DuoLaLightController:sendPM_DuoLaGameInfoReq(activityId)
	DuoLaGameAgent.instance:sendPM_DuoLaGameInfoReq(activityId)
end

function DuoLaLightController:handlePM_DuoLaGameInfoRes(msg)
	DuoLaLightModel.instance:handlePM_DuoLaGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DuoLaGameInfoRes)
end

function DuoLaLightController:sendPM_DuoLaGameStartGameReq(activityId, difficultyId)
	local clientKey = math.random(1, 100000)

	DuoLaLightModel.instance:setClientKey(clientKey)
	DuoLaGameAgent.instance:sendPM_DuoLaGameStartGameReq(activityId, difficultyId, clientKey)
end

function DuoLaLightController:handlePM_DuoLaGameStartGameRes(status, msg)
	if status == 0 then
		DuoLaLightModel.instance:handlePM_DuoLaGameStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DuoLaGameStartGameRes, status, msg)
end

function DuoLaLightController:sendPM_DuoLaGameEndGameReq(activityId, difficultyId, isPass, buyTimes)
	local clientKey = DuoLaLightModel.instance:getClientKey()
	local serverKey = DuoLaLightModel.instance:getServerKey()
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		isPass and 1 or 0,
		buyTimes
	})

	DuoLaGameAgent.instance:sendPM_DuoLaGameEndGameReq(activityId, difficultyId, isPass, buyTimes, encryptedKey)
end

function DuoLaLightController:handlePM_DuoLaGameEndGameRes(status, msg)
	if status == 0 then
		DuoLaLightModel.instance:handlePM_DuoLaGameEndGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DuoLaGameEndGameRes, status, msg)
end

function DuoLaLightController:sendPM_DuoLaGameSweepReq(activityId, difficultyId)
	DuoLaGameAgent.instance:sendPM_DuoLaGameSweepReq(activityId, difficultyId)
end

function DuoLaLightController:handlePM_DuoLaGameSweepRes(msg)
	DuoLaLightModel.instance:handlePM_DuoLaGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DuoLaGameSweepRes)
end

function DuoLaLightController:setActivityId(activityId)
	self._activityId = activityId
end

function DuoLaLightController:getActivityId()
	return self._activityId
end

function DuoLaLightController:getActivityType()
	return GameEnum.ActivityType.DuoLaLight
end

function DuoLaLightController:isInActivityTimeAsDuoLa(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DuoLaLightController:getTotalDiffCount(activityId)
	local cfg = DuoLaLightConfig.instance:getDlDiffCfg(activityId)

	return #cfg
end

function DuoLaLightController:getFinsihDiffCount(activityId)
	local diffCount = 0
	local cfg = DuoLaLightConfig.instance:getDlDiffCfg(activityId)

	for _, data in ipairs(cfg) do
		if DuoLaLightModel.instance:isFinishedOfDiff(data.difficultyId) then
			diffCount = diffCount + 1
		end
	end

	return diffCount
end

function DuoLaLightController:getNotFinsihDiffCount(activityId)
	local total = self:getTotalDiffCount(activityId)
	local finish = self:getFinsihDiffCount(activityId)

	return Mathf.Max(total - finish, 0)
end

DuoLaLightController.instance = DuoLaLightController.New()

return DuoLaLightController
