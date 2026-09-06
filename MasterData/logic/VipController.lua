-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/controller/VipController.lua

module("logic.extensions.vip.controller.VipController", package.seeall)

local VipController = class("VipController", BaseController)

function VipController:ctor()
	VipController.super.ctor(self)
end

function VipController:onInit()
	VipController.super.onInit(self)
	GlobalDispatcher:addListener(VipAgent.PM_GainVipFreeBonusRes, self._handleGainVipBonusRes, self)
	GlobalDispatcher:addListener(VipAgent.PM_VipExpDailyChangeRes, self._handleVipExpDailyDailyChangeRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyResetData, self)
	self:onReset()
end

function VipController:onReset()
	VipController.super.onReset(self)
end

function VipController:sendInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj
	end
end

function VipController:_getInfoRes(msg)
	VipModel.instance:updateData(msg)
	self:_callback()
end

function VipController:sendGetVipInfoReq()
	VipAgent.instance:sendPM_GetVipInfoReq(self._getVipInfoRes, self, self._errorCall)
end

function VipController:_getVipInfoRes(msg)
	VipModel.instance:updateDataGetVipInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BroadcastCurVipLevel)
end

function VipController:sendGainVipDailyBonusReq(vipLevel, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		VipModel.instance:tryToChangeDailyBonusStateByLv(checkint(vipLevel))
		VipAgent.instance:sendPM_GainVipDailyBonusReq(checkint(vipLevel), self._gainVipDailyBonusRes, self, self._errorCall)
	end
end

function VipController:_gainVipDailyBonusRes(msg)
	VipModel.instance:updateDataGainVipDailyBonus(msg)
	self:_callback()
end

function VipController:sendGainVipBonusReq(vipLevel, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		VipAgent.instance:sendPM_GainVipOnceFreeBonusReq(vipLevel, self._gainVipBonusRes, self, self._errorCall)
	end
end

function VipController:_gainVipBonusRes(msg)
	VipModel.instance:updateDataGainVipBonus(msg)
	self:_callback()
end

function VipController:_handleGainVipBonusRes(status, msg)
	if status == 0 then
		self:_gainVipBonusRes(msg)
	end
end

function VipController:_handleVipExpDailyDailyChangeRes(status, msg)
	if status == 0 then
		VipModel.instance:updateDataVipExpDailyChange(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BroadcastCurVipLevel)
		self:_callback()
	end
end

function VipController:_dailyResetData()
	VipModel.instance:dailyResetData()
end

function VipController:_callback(...)
	local handler = self._handler
	local handlerObj = self._handlerObj

	if handler then
		if handlerObj then
			self._handler(handlerObj, ...)
		else
			handler(...)
		end
	end

	self._handler = nil
	self._handlerObj = nil
end

function VipController:_errorCall()
	self._handler = nil
	self._handlerObj = nil

	printInfo("Vip Error Callback")
end

function VipController:_checkIsReqing()
	if self._handler then
		print("_checkIsReqing")
		print(debug.traceback())
		FloatWordMgr.instance:show("Vip sent req ")

		return true
	else
		return false
	end
end

VipController.instance = VipController.New()

return VipController
