-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumediamondgift/controller/ConsumediamondgiftController.lua

module("logic.extensions.consumediamondgift.controller.ConsumediamondgiftController", package.seeall)

local ConsumediamondgiftController = class("ConsumediamondgiftController", BaseController)

ConsumediamondgiftController.GetActivityInfoRes = "ConsumediamondgiftController.GetActivityInfoRes"
ConsumediamondgiftController.GainPrizeRes = "ConsumediamondgiftController.GainPrizeRes"

function ConsumediamondgiftController:ctor()
	return
end

function ConsumediamondgiftController:onInit()
	GlobalDispatcher:addListener(ConsumeDiamondGiftAgent.PM_GetActivityInfoRes, self._GetActivityInfoRes, self)
	GlobalDispatcher:addListener(ConsumeDiamondGiftAgent.GainPrizeRes, self._GainPrizeRes, self)
	self:onReset()
end

function ConsumediamondgiftController:onReset()
	return
end

function ConsumediamondgiftController:sendGetActivityInfoReq()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ConsumeDiamondGift)

	if cfg then
		ConsumediamondgiftModel.instance:setActId(cfg.activityId)
		ConsumeDiamondGiftAgent.instance:sendPM_GetActivityInfoReq(cfg.activityId)
	end
end

function ConsumediamondgiftController:openView()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ConsumeDiamondGift)

	if cfg then
		UIStateManager.instance:push(ViewName.ConsumediamondgiftView, cfg.activityId)
	else
		FloatWordMgr.instance:show("不在活动开放时间内")
	end
end

function ConsumediamondgiftController:_GetActivityInfoRes(status, msg)
	if status == 0 then
		ConsumediamondgiftModel.instance:setActInfo(msg)
	end

	GlobalDispatcher:dispatch(ConsumediamondgiftController.GetActivityInfoRes, status, msg)
end

function ConsumediamondgiftController:_GainPrizeRes(status, msg)
	if status == 0 then
		ConsumediamondgiftModel.instance:gainPrizeRes()
	end

	GlobalDispatcher:dispatch(ConsumediamondgiftController.GainPrizeRes, status, msg)
end

ConsumediamondgiftController.instance = ConsumediamondgiftController.New()

return ConsumediamondgiftController
