-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/controller/YearCardSignInController.lua

module("logic.extensions.yearcardsignin.controller.YearCardSignInController", package.seeall)

local YearCardSignInController = class("YearCardSignInController", BaseController)

function YearCardSignInController:sendGetInfoReq(actId)
	self._getInfoActId = actId

	AnnuitySignInAgent.instance:sendPM_AnnuitySignInGetInfoReq(actId)
end

function YearCardSignInController:handleGetInfo(msg)
	YearCardSignInModel.instance:onGetInfo(msg, self._getInfoActId)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInInfoUpdate)
end

function YearCardSignInController:sendSignInReq(actId, day)
	YearCardSignInModel.instance:signIn(day)
	AnnuitySignInAgent.instance:sendPM_AnnuitySignInGainPrizeReq(actId, day)
end

function YearCardSignInController:handleSignIn(msg)
	YearCardSignInModel.instance:onSignIn(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInInfoUpdate)
end

function YearCardSignInController:sendSignInOneKeyReq(actId)
	AnnuitySignInAgent.instance:sendPM_AnnuitySignInGainPrizeOnekeyReq(actId)
end

function YearCardSignInController:handleSignInOneKey(msg)
	YearCardSignInModel.instance:onSignInOneKey(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInInfoUpdate)
end

function YearCardSignInController:sendBuyGiftReq(actId, giftId)
	AnnuitySignInAgent.instance:sendPM_AnnuitySignInCostReq(actId, giftId)
end

function YearCardSignInController:handleBuyGift(msg)
	YearCardSignInModel.instance:onBuyGift(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardSignInInfoUpdate)
end

YearCardSignInController.instance = YearCardSignInController.New()

return YearCardSignInController
