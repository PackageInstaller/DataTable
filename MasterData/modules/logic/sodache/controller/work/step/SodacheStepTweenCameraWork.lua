-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepTweenCameraWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepTweenCameraWork", package.seeall)

local SodacheStepTweenCameraWork = class("SodacheStepTweenCameraWork", SodacheStepBaseWork)

function SodacheStepTweenCameraWork:onWorkStart(context)
	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode, self._stepMo.paramInt[1], self._stepMo.paramInt[2], self._onTweenFinish, self)
	TaskDispatcher.runDelay(self._onTweenFinish, self, 2)
end

function SodacheStepTweenCameraWork:_onTweenFinish()
	self:onDone(true)
end

function SodacheStepTweenCameraWork:clearWork()
	TaskDispatcher.cancelTask(self._onTweenFinish, self)
end

return SodacheStepTweenCameraWork
