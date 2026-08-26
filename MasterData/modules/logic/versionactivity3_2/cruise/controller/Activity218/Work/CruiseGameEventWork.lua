-- chunkname: @modules/logic/versionactivity3_2/cruise/controller/Activity218/Work/CruiseGameEventWork.lua

module("modules.logic.versionactivity3_2.cruise.controller.Activity218.Work.CruiseGameEventWork", package.seeall)

local CruiseGameEventWork = class("CruiseGameEventWork", BaseWork)

function CruiseGameEventWork:ctor(event, eventParam)
	self.event = event
	self.eventParam = eventParam
end

function CruiseGameEventWork:onStart()
	Activity218Controller.instance:dispatchEvent(self.event, self.eventParam)
	self:onDone(true)
end

function CruiseGameEventWork:onDestroy()
	return
end

return CruiseGameEventWork
