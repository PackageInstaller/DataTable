-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/controller/LingShenConveneController.lua

module("logic.extensions.lingshenconvene.controller.LingShenConveneController", package.seeall)

local LingShenConveneController = class("LingShenConveneController", BaseController)

function LingShenConveneController:ctor()
	return
end

function LingShenConveneController:onReset()
	return
end

function LingShenConveneController:sendPM_LingShenConveneGetInfoReq(activityId)
	LingShenConveneAgent.instance:sendPM_LingShenConveneGetInfoReq(activityId)
end

function LingShenConveneController:handlePM_LingShenConveneGetInfoRes(msg)
	LingShenConveneModel.instance:_onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LingShenConveneGetInfoRes)
end

function LingShenConveneController:sendPM_LingShenConveneUnlockReq(activityId, tabId, iconId)
	LingShenConveneAgent.instance:sendPM_LingShenConveneUnlockReq(activityId, tabId, iconId)
end

function LingShenConveneController:handlePM_LingShenConveneUnlockRes(msg)
	LingShenConveneModel.instance:_onUnlockPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LingShenConveneUnlockRes)
end

function LingShenConveneController:sendPM_LingShenConveneGainProgressPrizeReq(activityId, prizeId)
	LingShenConveneAgent.instance:sendPM_LingShenConveneGainProgressPrizeReq(activityId, prizeId)
end

function LingShenConveneController:handlePM_LingShenConveneGainProgressPrizeRes(msg)
	LingShenConveneModel.instance:_onGainProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LingShenConveneeGainProgressPrizeRes)
end

function LingShenConveneController:sendPM_LingShenConveneGainPrizeReq(activityId, prizeId)
	LingShenConveneAgent.instance:sendPM_LingShenConveneGainPrizeReq(activityId, prizeId)
end

function LingShenConveneController:handlePM_LingShenConveneGainPrizeRes(msg)
	LingShenConveneModel.instance:_onGainRevealPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LingShenConveneeGainPrizeRes)
end

LingShenConveneController.instance = LingShenConveneController.New()

return LingShenConveneController
