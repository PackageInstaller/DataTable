-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalkingsignin/controller/SurvivalKingSignInController.lua

module("logic.extensions.survivalkingsignin.controller.SurvivalKingSignInController", package.seeall)

local SurvivalKingSignInController = class("SurvivalKingSignInController", BaseController)

function SurvivalKingSignInController:onInit()
	self:onReset()
end

function SurvivalKingSignInController:onReset()
	return
end

function SurvivalKingSignInController:getInfo(activityId)
	SurvivalKingSignInAgent.instance:sendPM_SurvivalKingSignInInfoReq(activityId)
end

function SurvivalKingSignInController:handleGetInfo(msg)
	SurvivalKingSignInModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SurvivalKingSignInInfoRes)
end

function SurvivalKingSignInController:signIn(activityId, zoneId)
	SurvivalKingSignInAgent.instance:sendPM_SurvivalKingSignInReq(activityId, zoneId)
end

function SurvivalKingSignInController:handleSignIn(msg)
	SurvivalKingSignInModel.instance:onSignIn(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SurvivalKingSignInRes)
end

function SurvivalKingSignInController:gainPrize(activityId)
	SurvivalKingSignInAgent.instance:sendPM_SurvivalKingSignInGainPrizeReq(activityId)
end

function SurvivalKingSignInController:handleGainPrize(msg)
	SurvivalKingSignInModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SurvivalKingSignInGainPrizeRes)
end

SurvivalKingSignInController.instance = SurvivalKingSignInController.New()

return SurvivalKingSignInController
