-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/ShikongshenglongController.lua

module("logic.extensions.timelimitedchallenge.controller.ShikongshenglongController", package.seeall)

local ShikongshenglongController = class("ShikongshenglongController", BaseController)

ShikongshenglongModel.SkslChallenge = 1
ShikongshenglongModel.SiyuanChallenge = 2
ShikongshenglongModel.ZxlChallenge = 3
ShikongshenglongModel.SLYJDChallenge = 5
ShikongshenglongController.SkslActivityId = 110001
ShikongshenglongController.SiYuanActivityId = 110005
ShikongshenglongController.ZxlActivityId = 110002
ShikongshenglongController.SYWDLYActivityId = 110008
ShikongshenglongController.SLYJDActivityId = 110009

function ShikongshenglongController:onInit()
	return
end

function ShikongshenglongController:onReset()
	return
end

function ShikongshenglongController:sendGetInfos(activityId)
	LightDarkDragonAgent.instance:sendPM_LightDarkDragonInfoReq(activityId)
end

function ShikongshenglongController:sendToFight(activityId)
	LightDarkDragonAgent.instance:sendPM_LightDarkDragonChallengeReq(activityId)
end

function ShikongshenglongController:sendToSweep(activityId, stageId)
	LightDarkDragonAgent.instance:sendPM_LightDarkDragonSweepReq(activityId, stageId)
end

function ShikongshenglongController:sendToSign(activityId)
	LightDarkDragonAgent.instance:sendPM_LightDarkDragonGainDailySignPrizeReq(activityId)
end

function ShikongshenglongController:getActivityId(challengeType)
	if challengeType == ShikongshenglongModel.SkslChallenge then
		return ShikongshenglongController.SkslActivityId
	elseif challengeType == ShikongshenglongModel.SiyuanChallenge then
		return ShikongshenglongController.SiYuanActivityId
	elseif challengeType == ShikongshenglongModel.SLYJDChallenge then
		return ShikongshenglongController.SLYJDActivityId
	else
		return ShikongshenglongController.ZxlActivityId
	end
end

function ShikongshenglongController:getActivityType()
	return GameEnum.ActivityType.DragonSupper
end

function ShikongshenglongController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

ShikongshenglongController.instance = ShikongshenglongController.New()

return ShikongshenglongController
