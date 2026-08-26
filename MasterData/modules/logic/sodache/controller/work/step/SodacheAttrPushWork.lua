-- chunkname: @modules/logic/sodache/controller/work/step/SodacheAttrPushWork.lua

module("modules.logic.sodache.controller.work.step.SodacheAttrPushWork", package.seeall)

local SodacheAttrPushWork = class("SodacheAttrPushWork", SodacheMsgPushWork)

function SodacheAttrPushWork:onWorkStart(context)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	outSideMo.attrContainer:updateAttr(self._msg.updates)

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnAttrUpdate)
	self:onDone(true)
end

function SodacheAttrPushWork:isInsideStep()
	return false
end

return SodacheAttrPushWork
