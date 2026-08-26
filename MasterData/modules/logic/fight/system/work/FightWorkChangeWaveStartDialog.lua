-- chunkname: @modules/logic/fight/system/work/FightWorkChangeWaveStartDialog.lua

module("modules.logic.fight.system.work.FightWorkChangeWaveStartDialog", package.seeall)

local FightWorkChangeWaveStartDialog = class("FightWorkChangeWaveStartDialog", BaseWork)

function FightWorkChangeWaveStartDialog:onStart()
	local nextWaveId = FightModel.instance:getCurWaveId() + 1

	FightWorkStepChangeWave.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWave, nextWaveId)

	if FightWorkStepChangeWave.needStopMonsterWave then
		self._dialogWork = FightWorkWaitDialog.New()

		self._dialogWork:registerDoneListener(self._onFightDialogEnd, self)
		self._dialogWork:onStart()
	else
		self:_onFightDialogEnd()
	end
end

function FightWorkChangeWaveStartDialog:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkChangeWaveStartDialog:clearWork()
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)

	if self._dialogWork then
		self._dialogWork:unregisterDoneListener(self._onFightDialogEnd, self)

		self._dialogWork = nil
	end
end

return FightWorkChangeWaveStartDialog
