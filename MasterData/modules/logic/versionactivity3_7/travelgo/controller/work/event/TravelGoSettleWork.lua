-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoSettleWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoSettleWork", package.seeall)

local TravelGoSettleWork = class("TravelGoSettleWork", BaseWork)

function TravelGoSettleWork:ctor(isOnlyPlayer)
	self.isOnlyPlayer = isOnlyPlayer
end

function TravelGoSettleWork:onStart()
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	if playerEntity.attributes:getHp() <= 0 then
		TravelGoModel.instance:setSettle(false)
		TravelGoController.instance:settle()
		self:onDone(false)
	elseif not self.isOnlyPlayer and TravelGoModel.instance.day >= TravelGoModel.instance.maxDay then
		TravelGoModel.instance:setSettle(true)
		TravelGoController.instance:settle()
		self:onDone(false)
	else
		self:onDone(true)
	end
end

function TravelGoSettleWork:clearWork()
	return
end

return TravelGoSettleWork
