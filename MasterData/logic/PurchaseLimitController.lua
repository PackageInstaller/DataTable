-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/purchaselimit/controller/PurchaseLimitController.lua

module("logic.extensions.purchaselimit.controller.PurchaseLimitController", package.seeall)

local PurchaseLimitController = class("PurchaseLimitController", BaseController)

function PurchaseLimitController:ctor()
	return
end

function PurchaseLimitController:onInit()
	self:onReset()
end

function PurchaseLimitController:onReset()
	return
end

function PurchaseLimitController:sendPM_PurchaseLimitInfoReq(activityId)
	PurchaseLimitAgent.instance:sendPM_PurchaseLimitInfoReq(activityId)
end

function PurchaseLimitController:handlePM_PurchaseLimitInfoRes(status, msg)
	PurchaseLimitModel.instance:setPurchaseInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PurchaseLimitInfoRes, msg)
end

function PurchaseLimitController:sendPM_PurchaseLimitBuyReq(activityId, itemId)
	PurchaseLimitAgent.instance:sendPM_PurchaseLimitBuyReq(activityId, itemId)
end

function PurchaseLimitController:handlePM_PurchaseLimitBuyRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PurchaseLimitBuyRes, msg)
end

function PurchaseLimitController:getRaceIds()
	local actIds = PurchaseLimitConfig.instance:getCommonCfgById("SHOW_ACTID")
	local actCfg = PurchaseLimitConfig.instance:getActCfg(actIds)
	local raceCfg = {}

	for _, v in ipairs(actCfg) do
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(v.activityId)

		if isInTime then
			table.insert(raceCfg, v)
		end
	end

	return raceCfg
end

PurchaseLimitController.instance = PurchaseLimitController.New()

return PurchaseLimitController
