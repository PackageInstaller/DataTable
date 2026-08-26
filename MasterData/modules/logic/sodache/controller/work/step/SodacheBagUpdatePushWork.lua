-- chunkname: @modules/logic/sodache/controller/work/step/SodacheBagUpdatePushWork.lua

module("modules.logic.sodache.controller.work.step.SodacheBagUpdatePushWork", package.seeall)

local SodacheBagUpdatePushWork = class("SodacheBagUpdatePushWork", SodacheMsgPushWork)

function SodacheBagUpdatePushWork:onWorkStart(context)
	local msg = self._msg

	SodacheBagUpdatePushWork.doMsg(msg)
	self:onDone(true)
end

function SodacheBagUpdatePushWork.doMsg(msg)
	SodacheModel.instance:updateBag(msg.type, msg)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnBagUpdate, msg.type)
end

function SodacheBagUpdatePushWork:isInsideStep()
	return false
end

return SodacheBagUpdatePushWork
