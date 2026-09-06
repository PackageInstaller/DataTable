-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/controller/DoubleElevenController.lua

module("logic.extensions.doubleeleven.controller.DoubleElevenController", package.seeall)

local DoubleElevenController = class("DoubleElevenController", BaseController)

function DoubleElevenController:ctor()
	self._curParams = nil
	self._szSupTime = nil
end

function DoubleElevenController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onHandTickDailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.EnterMainCustom, self._onStartEnterGame, self)
end

function DoubleElevenController:onReset()
	self._curParams = nil
	self._szSupTime = nil
end

function DoubleElevenController:_onHandTickDailyRefresh()
	if ViewMgr.instance:isOpen(ViewName.ContinuousRecharge) then
		local actId = DoubleElevenConfig.instance:getDaysRechargeActivityId()

		if checknumber(actId) > 0 then
			self:csGetDaysRechargeGetInfoReq(actId)
		end
	end

	if ViewMgr.instance:isOpen(ViewName.FreeZone) then
		local actId = DoubleElevenConfig.instance:getFreeZoneActivityId()

		if checknumber(actId) > 0 then
			self:csGetFreePayStoreGetInfoReq(actId)
		end
	end

	self:_onStartEnterGame()
end

function DoubleElevenController:_onStartEnterGame()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DoubleEleven, false)
	removetimer(self._setSeckillZoneCustomOpens, self)

	self._szSupTime = nil

	if not self:_isSeckillZoneFuncOpen() then
		return
	end

	self:_setSeckillZoneCustomOpens()
end

function DoubleElevenController:_isSeckillZoneFuncOpen()
	local cfg = DoubleElevenConfig.instance:getDoubleElevenTabCfgByTabId(2)

	if cfg == nil or checknumber(cfg.sort) <= 0 then
		return false
	end

	if cfg.funcId > 0 and not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		return false
	end

	local allList = DoubleElevenModel.instance:getSeckillZoneTabList()

	if allList == nil or #allList == 0 then
		return false
	end

	return true
end

function DoubleElevenController:_isSeckillZoneTimeOpen()
	local nowTime = ServerTime.nowDateServerLook()
	local nowNum = nowTime.hour * 3600 + nowTime.min * 60 + nowTime.sec
	local supTime
	local allList = DoubleElevenModel.instance:getSeckillZoneTabList()

	if allList == nil or #allList == 0 then
		return supTime
	end

	for i = 1, #allList do
		if allList[i] and allList[i].stage == GameUtil.inTimePeriod then
			local strs = string.split(allList[i].strEnd, ":")

			supTime = checknumber(strs[1]) * 3600 + checknumber(strs[2]) * 60 + checknumber(strs[3]) - nowNum - 1

			break
		end
	end

	return supTime
end

function DoubleElevenController:_setSeckillZoneCustomOpens()
	if self._szSupTime == nil then
		local supTime = self:_isSeckillZoneTimeOpen()

		if supTime == nil or supTime <= 0 then
			return
		end

		self._szSupTime = supTime

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DoubleEleven, true, true, 0, ServerTime.now() + self._szSupTime)
	else
		self._szSupTime = self._szSupTime - 1

		if self._szSupTime <= 0 then
			self._szSupTime = nil

			GlobalDispatcher:dispatch("UpdataCustomOpensItem", false, 3)
		end
	end
end

function DoubleElevenController:csGetDaysRechargeGetInfoReq(activityId)
	DaysRechargeAgent.instance:sendPM_DaysRechargeGetInfoReq(activityId)
end

function DoubleElevenController:csSendDaysRechargeGetInfo(msg)
	DoubleElevenModel.instance:csSendDaysRechargeGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataContinuousRechargeInfo)
end

function DoubleElevenController:csGetDaysRechargeGainPrizeReq(activityId, itemId)
	self._curParams = {
		actId = activityId,
		itemId = itemId
	}

	DaysRechargeAgent.instance:sendPM_DaysRechargeGainPrizeReq(activityId, itemId)
end

function DoubleElevenController:csSendDaysRechargeGainPrize(msg)
	if self._curParams == nil then
		return
	end

	DoubleElevenModel.instance:csSendDaysRechargeGainPrize(self._curParams)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataContinuousRechargePrize)

	self._curParams = nil

	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataDoubleElevenRed, 1)
end

function DoubleElevenController:csGetSecondSaleInfoReq(activityId, planId)
	SecondSaleAgent.instance:sendPM_SecondSaleInfoReq(activityId, planId)
end

function DoubleElevenController:csSendSecondSaleInfo(msg)
	DoubleElevenModel.instance:csSendSecondSaleInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataSeckillZoneInfo)
end

function DoubleElevenController:csGetSecondSaleBuyReq(activityId, planId, itemId)
	self._curParams = {
		actId = activityId,
		planId = planId,
		itemId = itemId
	}

	SecondSaleAgent.instance:sendPM_SecondSaleBuyReq(activityId, planId, itemId)
end

function DoubleElevenController:csSendSecondSaleBuy(msg)
	if self._curParams == nil then
		return
	end

	DoubleElevenModel.instance:csSendSecondSaleBuy(self._curParams)

	self._curParams = nil

	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataSeckillZoneInfo)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataDoubleElevenRed, 2)
end

function DoubleElevenController:csGetFreePayStoreGetInfoReq(activityId)
	FreePayStoreAgent.instance:sendPM_FreePayStoreGetInfoReq(activityId)
end

function DoubleElevenController:csSendFreePayStoreGetInfo(msg)
	DoubleElevenModel.instance:csSendFreePayStoreGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataFreeZoneInfo)
end

function DoubleElevenController:csGetFreePayStoreBuyReq(activityId, itemId)
	FreePayStoreAgent.instance:sendPM_FreePayStoreBuyReq(activityId, itemId)
end

function DoubleElevenController:csSendFreePayStoreBuy(msg)
	if msg == nil or msg.item == nil then
		return
	end

	DoubleElevenModel.instance:csSendFreePayStoreBuy(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataFreeZonePrize, msg.resultType)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataDoubleElevenRed, 3)
end

function DoubleElevenController:csGetFreePayStoreGetRanTextReq(activityId)
	FreePayStoreAgent.instance:sendPM_FreePayStoreGetRanTextReq(activityId)
end

function DoubleElevenController:csSendFreePayStoreGetRanText(msg)
	DoubleElevenModel.instance:csSendFreePayStoreGetRanText(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DE_UpdataFreeZoneRank)
end

DoubleElevenController.instance = DoubleElevenController.New()

return DoubleElevenController
