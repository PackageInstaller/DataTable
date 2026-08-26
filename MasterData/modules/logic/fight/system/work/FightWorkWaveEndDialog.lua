-- chunkname: @modules/logic/fight/system/work/FightWorkWaveEndDialog.lua

module("modules.logic.fight.system.work.FightWorkWaveEndDialog", package.seeall)

local FightWorkWaveEndDialog = class("FightWorkWaveEndDialog", BaseWork)

function FightWorkWaveEndDialog:onStart()
	local currWaveId = FightModel.instance:getCurWaveId()

	FightWorkStepChangeWave.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, currWaveId)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, currWaveId)

	if FightWorkStepChangeWave.needStopMonsterWave then
		self._dialogWork = FightWorkWaitDialog.New()

		self._dialogWork:registerDoneListener(self._onFightDialogEnd, self)
		self._dialogWork:onStart()
	else
		self:_onFightDialogEnd()
	end
end

function FightWorkWaveEndDialog:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkWaveEndDialog:clearWork()
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)

	if self._dialogWork then
		self._dialogWork:unregisterDoneListener(self._onFightDialogEnd, self)

		self._dialogWork = nil
	end
end

return FightWorkWaveEndDialog
