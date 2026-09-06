-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/controller/HDZeropayController.lua

module("logic.extensions.zeropay.controller.HDZeropayController", package.seeall)

local HDZeropayController = class("HDZeropayController", BaseController)

HDZeropayController.PM_GetGiftInfoRes = "ZeropayController.PM_GetGiftInfoRes"
HDZeropayController.PM_NotifyBuyGiftRes = "ZeropayController.PM_NotifyBuyGiftRes"

function HDZeropayController:ctor()
	return
end

function HDZeropayController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(NewZeroPayAgent.GetGiftInfoRes, self._PM_GetGiftInfoRes, self)
	GlobalDispatcher:addListener(NewZeroPayAgent.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._ickDailyRefreshData, self)
end

function HDZeropayController:onReset()
	self._isLoadInfo = false
	self.actPool = nil
	self.curActId = nil
end

function HDZeropayController:sendPM_GetGiftInfoReq()
	if self._isLoadInfo then
		return
	end

	NewZeroPayAgent.instance:sendGetGiftInfoReq()
end

function HDZeropayController:_ickDailyRefreshData()
	self._isLoadInfo = false
end

function HDZeropayController:_PM_GetGiftInfoRes(status, msg)
	if status == 0 then
		self._isLoadInfo = true
		self.curActId = msg.activityId
		self.actPool = {}
		self.actPool[msg.activityId] = {}

		local infoMap = self.actPool[msg.activityId]
		local infos = msg.infos

		for i, v in ipairs(infos) do
			local giftId = v.giftId

			infoMap[giftId] = v
		end
	end

	GlobalDispatcher:dispatch(HDZeropayController.PM_GetGiftInfoRes, status, msg)
end

function HDZeropayController:_PM_NotifyBuyGiftRes(status, msg)
	if status == 0 and self.actPool then
		local infoMap = self.actPool[msg.activityId]

		if infoMap then
			local info = msg.info

			if infoMap then
				infoMap[info.giftId] = info
			end
		end
	end

	GlobalDispatcher:dispatch(HDZeropayController.PM_NotifyBuyGiftRes, status, msg)
end

function HDZeropayController:getGiftCanBuy(actId, giftId)
	local infoMap = self.actPool[actId]

	if infoMap then
		local info = infoMap[giftId]
		local cfg = HDZeropayConfig.instance:getNewActCfg(actId, giftId)

		if info and ((cfg or nil) and cfg.maxBuyTimes) > info.buyTimes and info.isCanBuy then
			return true
		end
	end

	return false
end

function HDZeropayController:getBuyTimes(actId, giftId)
	local infoMap = self.actPool[actId]

	if infoMap then
		local info = infoMap[giftId]

		if info then
			return checknumber(info.buyTimes)
		end
	end

	return 0
end

HDZeropayController.instance = HDZeropayController.New()

return HDZeropayController
