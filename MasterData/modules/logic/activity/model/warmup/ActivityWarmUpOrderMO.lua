-- chunkname: @modules/logic/activity/model/warmup/ActivityWarmUpOrderMO.lua

module("modules.logic.activity.model.warmup.ActivityWarmUpOrderMO", package.seeall)

local ActivityWarmUpOrderMO = pureTable("ActivityWarmUpOrderMO")

function ActivityWarmUpOrderMO:ctor()
	self.id = nil
	self.cfg = nil
	self.progress = nil
	self.hasGetBonus = false
	self.accept = false
	self.status = ActivityWarmUpEnum.OrderStatus.None
end

function ActivityWarmUpOrderMO:init(cfg)
	self.id = cfg.id
	self.cfg = cfg
end

function ActivityWarmUpOrderMO:initServerData(data)
	self.progress = data.process
	self.hasGetBonus = data.hasGetBonus
	self.accept = data.accept

	if self.hasGetBonus then
		self.status = ActivityWarmUpEnum.OrderStatus.Finished
	elseif not self.accept then
		self.status = ActivityWarmUpEnum.OrderStatus.WaitForAccept
	elseif self.accept and not self:isColleted() then
		self.status = ActivityWarmUpEnum.OrderStatus.Accepted
	elseif self.accept and self:isColleted() and not self.hasGetBonus then
		self.status = ActivityWarmUpEnum.OrderStatus.Collected
	end
end

function ActivityWarmUpOrderMO:getStatus()
	return self.status
end

function ActivityWarmUpOrderMO:isColleted()
	if self.progress then
		return self.progress >= self.cfg.maxProgress
	else
		return false
	end
end

function ActivityWarmUpOrderMO:canFinish()
	return self.status == ActivityWarmUpEnum.OrderStatus.Collected
end

return ActivityWarmUpOrderMO
