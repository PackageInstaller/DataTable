-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaDieStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDieStep", package.seeall)

local TianShiNaNaDieStep = class("TianShiNaNaDieStep", TianShiNaNaStepBase)

function TianShiNaNaDieStep:onStart(context)
	local playerMo = TianShiNaNaModel.instance:getHeroMo()

	if not playerMo then
		self:_delayDone()

		return
	end

	local playerEntity = TianShiNaNaEntityMgr.instance:getEntity(playerMo.co.id)

	if not playerEntity then
		self:_delayDone()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_death)
	playerEntity:playCloseAnim()
	UIBlockMgr.instance:startBlock("TianShiNaNaDieStep")
	TaskDispatcher.runDelay(self._delayDone, self, 1)
end

function TianShiNaNaDieStep:_delayDone()
	ViewMgr.instance:openView(ViewName.TianShiNaNaResultView, {
		isWin = false,
		reason = self._data.reason
	})
	self:onDone(false)
end

function TianShiNaNaDieStep:clearWork()
	UIBlockMgr.instance:endBlock("TianShiNaNaDieStep")
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return TianShiNaNaDieStep
