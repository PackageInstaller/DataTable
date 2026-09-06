-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/controller/ZeropayController.lua

module("logic.extensions.zeropay.controller.ZeropayController", package.seeall)

local ZeropayController = class("ZeropayController", BaseController)

ZeropayController.PM_GetGiftInfoRes = "ZeropayController.PM_GetGiftInfoRes"
ZeropayController.PM_NotifyBuyGiftRes = "ZeropayController.PM_NotifyBuyGiftRes"

function ZeropayController:ctor()
	return
end

function ZeropayController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(ZeroPayAgent.PM_GetGiftInfoRes, self._PM_GetGiftInfoRes, self)
	GlobalDispatcher:addListener(ZeroPayAgent.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._ickDailyRefreshData, self)
end

function ZeropayController:onReset()
	self._isLoadInfo = false
end

function ZeropayController:openView()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ZeroPay)

	if cfg then
		UIStateManager.instance:push(ViewName.ZeropaymainView, cfg.activityId)
	else
		FloatWordMgr.instance:show("不在活动开放时间内")
	end
end

function ZeropayController:sendPM_GetGiftInfoReq()
	if self._isLoadInfo then
		return
	end

	ZeroPayAgent.instance:sendPM_GetGiftInfoReq()
end

function ZeropayController:_ickDailyRefreshData()
	self._isLoadInfo = false
end

function ZeropayController:_PM_GetGiftInfoRes(status, msg)
	if status == 0 then
		self._isLoadInfo = true

		ZeropayModel.instance:setGiftInfo(msg)
	end

	GlobalDispatcher:dispatch(ZeropayController.PM_GetGiftInfoRes, status, msg)
end

function ZeropayController:_PM_NotifyBuyGiftRes(status, msg)
	if status == 0 then
		ZeropayModel.instance:buyGiftRes(msg)
	end

	GlobalDispatcher:dispatch(ZeropayController.PM_NotifyBuyGiftRes, status, msg)
end

ZeropayController.instance = ZeropayController.New()

return ZeropayController
