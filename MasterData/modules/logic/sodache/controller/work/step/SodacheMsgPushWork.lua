-- chunkname: @modules/logic/sodache/controller/work/step/SodacheMsgPushWork.lua

module("modules.logic.sodache.controller.work.step.SodacheMsgPushWork", package.seeall)

local SodacheMsgPushWork = class("SodacheMsgPushWork", SodacheStepBaseWork)

function SodacheMsgPushWork:ctor(msgName, msg)
	self._msgName = msgName or ""
	self._msg = msg
end

function SodacheMsgPushWork:onWorkStart(context)
	self:onDone(true)
end

function SodacheMsgPushWork:isInsideStep()
	return true
end

function SodacheMsgPushWork:canMergeExecute()
	return false
end

return SodacheMsgPushWork
