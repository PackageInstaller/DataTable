-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepContainerFinishWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepContainerFinishWork", package.seeall)

local SodacheStepContainerFinishWork = class("SodacheStepContainerFinishWork", SodacheStepDropCardWork)

function SodacheStepContainerFinishWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()
	local uid = self._stepMo.paramLong[1]

	if not insideMo.unitBox.unitsMap[uid] then
		self:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum3_7.Sodache.search)
	SodacheController.instance:dispatchEvent(SodacheEvent.ContainerFinish, uid, self._onFinish, self)
end

function SodacheStepContainerFinishWork:_onFinish()
	self:onDone(true)
end

return SodacheStepContainerFinishWork
