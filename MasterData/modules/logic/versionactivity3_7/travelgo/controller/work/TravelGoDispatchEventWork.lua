-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/TravelGoDispatchEventWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.TravelGoDispatchEventWork", package.seeall)

local TravelGoDispatchEventWork = class("TravelGoDispatchEventWork", BaseWork)

function TravelGoDispatchEventWork:ctor(event, eventParam)
	self.event = event
	self.eventParam = eventParam
end

function TravelGoDispatchEventWork:onStart()
	TravelGoController.instance:dispatchEvent(self.event, self.eventParam)
	self:onDone(true)
end

return TravelGoDispatchEventWork
