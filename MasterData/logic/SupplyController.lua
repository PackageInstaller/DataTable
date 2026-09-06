-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/controller/SupplyController.lua

module("logic.extensions.strength.controller.SupplyController", package.seeall)

local SupplyController = class("SupplyController", BaseController)

function SupplyController:ctor()
	SupplyController.super.ctor(self)
end

function SupplyController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	StrengthAgent.instance:addListener(StrengthAgent.PM_NotifyStrengthChangeRes, self.onReceiveTiliChange, self)
end

function SupplyController:onReset()
	self.supplyList = {}
end

function SupplyController:getSupply(index, callback)
	StrengthAgent.instance:sendPM_StrengthGetFreeReq(index, function()
		SupplyModel.instance:setGotStates(index)
		GameUtil.callBack(callback)
	end)
end

function SupplyController:getIsSupplyInit()
	return SupplyModel.instance.isInitedSupplyInfo == true
end

function SupplyController:updataSupplyRedPoint(callback)
	if not SupplyModel.instance.isInitedSupplyInfo then
		self:getSupplyInfo()

		return
	end

	SupplyModel.instance:updateRedPoint()
	GameUtil.callBack(callback)
end

function SupplyController:getSupplyInfo()
	StrengthAgent.instance:sendPM_StrengthInfoReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadStrenghData===back")
		SupplyModel.instance:setSupply(msg)
	end)
end

function SupplyController:getLaterSupply(index, callback)
	StrengthAgent.instance:sendPM_StrengthCompensateReq(index, function()
		SupplyModel.instance:setGotStates(index)
		GameUtil.callBack(callback)
	end)
end

function SupplyController:_reloadData()
	SupplyModel.instance.isInitedSupplyInfo = false

	self:getSupplyInfo()
end

function SupplyController:CSRequestBuyTili(buyTime)
	StrengthAgent.instance:sendPM_StrengthBuyReq(buyTime, function(msg)
		SupplyModel.instance:buyTiliResult(buyTime)
	end)
end

function SupplyController:onReceiveTiliChange(status, msg)
	if status == 0 and msg then
		SupplyModel.instance:receiveTiliTime(msg.curStrength, msg.nextHpLeftTime)
		MaterialController.instance:addUpdateMo(mo)
	end
end

function SupplyController:getSupplystate(cfg)
	local index = cfg.index

	self.supplyList[index] = ""

	local state = SupplyModel.instance:getGotStates(index)
	local timeFlag = GameUtil.getTimePeriodType(cfg.startTime, cfg.endTime, true)

	if timeFlag == GameUtil.inTimePeriod then
		self.supplyList[index] = state and "已领取" or "可领取"
	elseif timeFlag == GameUtil.beforeTimePeriod then
		self.supplyList[index] = "未到时间"
	elseif timeFlag == GameUtil.afterTimePeriod then
		self.supplyList[index] = state and "已领取" or "可补领"
	end
end

function SupplyController:getSupplyList()
	local cfgs = SupplyConfig.instance:getDailyCfgs()

	for k, v in pairs(cfgs) do
		self:getSupplystate(v)
	end
end

function SupplyController:getBtnStateList()
	return self.supplyList
end

SupplyController.instance = SupplyController.New()

return SupplyController
