-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cashback/controller/CashBackController.lua

module("logic.extensions.cashback.controller.CashBackController", package.seeall)

local CashBackController = class("CashBackController", BaseController)

function CashBackController:onReset()
	return
end

function CashBackController:getInfo(activityId)
	CashBackAgent.instance:sendPM_CashBackInfoReq(activityId)
end

function CashBackController:handleGetInfo(msg)
	CashBackModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CashBackUpdateInfo)
end

function CashBackController:gainPrize(activityId, prizeId)
	CashBackAgent.instance:sendPM_CashBackGainPrizeReq(activityId, prizeId)
end

function CashBackController:handleGainPrize(msg)
	CashBackModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CashBackUpdatePrizeState)
end

CashBackController.instance = CashBackController.New()

return CashBackController
