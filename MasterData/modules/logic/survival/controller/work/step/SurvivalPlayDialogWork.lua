-- chunkname: @modules/logic/survival/controller/work/step/SurvivalPlayDialogWork.lua

module("modules.logic.survival.controller.work.step.SurvivalPlayDialogWork", package.seeall)

local SurvivalPlayDialogWork = class("SurvivalPlayDialogWork", SurvivalStepBaseWork)

function SurvivalPlayDialogWork:onStart2(context)
	if self.context.fastExecute then
		self:onDone(true)

		return
	end

	TipDialogController.instance:openTipDialogView(self._stepMo.paramInt[1], self._onPlayFinish, self)
end

function SurvivalPlayDialogWork:_onPlayFinish()
	self:onDone(true)
end

return SurvivalPlayDialogWork
