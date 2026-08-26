-- chunkname: @modules/logic/activity/controller/warmup/ActivityWarmUpController.lua

module("modules.logic.activity.controller.warmup.ActivityWarmUpController", package.seeall)

local ActivityWarmUpController = class("ActivityWarmUpController", BaseController)

function ActivityWarmUpController:onInit()
	return
end

function ActivityWarmUpController:reInit()
	return
end

function ActivityWarmUpController:init(actId)
	logNormal("ActivityWarmUpController init actId = " .. tostring(actId))

	local actMO = ActivityModel.instance:getActMO(actId)

	ActivityWarmUpModel.instance:init(actId)

	if actMO then
		ActivityWarmUpModel.instance:setStartTime(actMO.startTime)
	end

	local curDay = ActivityWarmUpModel.instance:getCurrentDay()

	self:switchTab(curDay or 1)
end

function ActivityWarmUpController:onReceiveInfos(actId, orderInfos)
	if ActivityWarmUpModel.instance:getActId() == actId then
		ActivityWarmUpModel.instance:setServerOrderInfos(orderInfos)
		self:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
		self:dispatchEvent(ActivityWarmUpEvent.OnInfosReply)
	end
end

function ActivityWarmUpController:onUpdateSingleOrder(actId, orderInfo)
	if ActivityWarmUpModel.instance:getActId() == actId then
		ActivityWarmUpModel.instance:updateSingleOrder(orderInfo)
		self:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
	end
end

function ActivityWarmUpController:onOrderPush(actId, orderInfo)
	if ActivityWarmUpModel.instance:getActId() == actId then
		ActivityWarmUpModel.instance:updateSingleOrder(orderInfo)
		self:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
	end

	local cfg = Activity106Config.instance:getActivityWarmUpOrderCo(actId, orderInfo.orderId)

	if cfg and orderInfo.process >= cfg.maxProgress then
		GameFacade.showToast(ToastEnum.WarmUpOrderPush, cfg.name, string.format("%s/%s", orderInfo.process, cfg.maxProgress))
	end
end

function ActivityWarmUpController:focusOrderGame(orderId)
	logNormal("focusOrderGame")

	self._focusActId = ActivityWarmUpModel.instance:getActId()
	self._focusOrderId = orderId

	ActivityWarmUpGameController.instance:registerCallback(ActivityWarmUpEvent.NotifyGameClear, self.finishOrderGame, self)
	ActivityWarmUpGameController.instance:registerCallback(ActivityWarmUpEvent.NotifyGameCancel, self.cancelOrderGame, self)
end

function ActivityWarmUpController:cancelOrderGame()
	logNormal("cancelOrderGame")
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameClear, self.finishOrderGame, self)
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameCancel, self.cancelOrderGame, self)

	self._focusActId = nil
	self._focusOrderId = nil

	self:dispatchEvent(ActivityWarmUpEvent.PlayOrderCancel)
end

function ActivityWarmUpController:finishOrderGame()
	logNormal("finishOrderGame")
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameClear, self.finishOrderGame, self)
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameCancel, self.cancelOrderGame, self)

	if self._focusActId ~= nil and self._focusOrderId ~= nil then
		Activity106Rpc.instance:sendGet106OrderBonusRequest(self._focusActId, self._focusOrderId, ActivityWarmUpGameController.instance:getGameCostTime(), self.onFinishReceive, self)
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity106)
	end
end

function ActivityWarmUpController:onFinishReceive(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	if self._focusActId ~= nil and self._focusOrderId ~= nil then
		self:dispatchEvent(ActivityWarmUpEvent.PlayOrderFinish, {
			actId = self._focusActId,
			orderId = self._focusOrderId
		})
	end
end

function ActivityWarmUpController:getRedDotParam()
	local actId = ActivityWarmUpModel.instance:getActId()
	local actCfg = ActivityConfig.instance:getActivityCo(actId)

	if actCfg then
		local centerCfg = ActivityConfig.instance:getActivityCenterCo(actCfg.showCenter)

		if centerCfg then
			return centerCfg.reddotid, actId
		end
	end

	return nil
end

function ActivityWarmUpController:cantJumpDungeonGetName(jumpId)
	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

	if not jumpConfig then
		return false
	end

	local jumpParam = jumpConfig.param

	if JumpController.instance:cantJump(jumpParam) then
		local jumps = string.split(jumpParam, "#")
		local episodeId = tonumber(jumps[#jumps])
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local cantJumpName = DungeonController.getEpisodeName(episodeConfig)

		return true, cantJumpName
	end

	return false
end

function ActivityWarmUpController:switchTab(index)
	ActivityWarmUpModel.instance:selectDayTab(index)
	self:dispatchEvent(ActivityWarmUpEvent.ViewSwitchTab)
end

ActivityWarmUpController.instance = ActivityWarmUpController.New()

LuaEventSystem.addEventMechanism(ActivityWarmUpController.instance)

return ActivityWarmUpController
