-- chunkname: @modules/logic/survival/controller/work/step/SurvivalTweenCameraWork.lua

module("modules.logic.survival.controller.work.step.SurvivalTweenCameraWork", package.seeall)

local SurvivalTweenCameraWork = class("SurvivalTweenCameraWork", SurvivalStepBaseWork)

function SurvivalTweenCameraWork:onStart2(context)
	self:moveNext()
end

function SurvivalTweenCameraWork:moveNext()
	local nextPos = table.remove(self._stepMo.hex)

	if not nextPos then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		SurvivalMapHelper.instance:tryShowServerPanel(sceneMo.panel)
		self:onDone(true)

		return
	end

	ViewMgr.instance:closeAllPopupViews()

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(nextPos.q, nextPos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z), 0.3)
	TaskDispatcher.runDelay(self.moveNext, self, 0.4)
end

function SurvivalTweenCameraWork:clearWork()
	TaskDispatcher.cancelTask(self.moveNext, self)
end

return SurvivalTweenCameraWork
