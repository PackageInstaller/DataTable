-- chunkname: @modules/logic/fight/system/work/FightWorkNormalDialog.lua

module("modules.logic.fight.system.work.FightWorkNormalDialog", package.seeall)

local FightWorkNormalDialog = class("FightWorkNormalDialog", BaseWork)

function FightWorkNormalDialog:ctor(dialogType, param)
	self._dialogType = dialogType
	self._param = param
end

function FightWorkNormalDialog:onStart()
	FightController.instance:dispatchEvent(FightEvent.FightDialog, self._dialogType, self._param)

	if FightViewDialog.showFightDialog then
		self._dialogWork = FightWorkWaitDialog.New()

		self._dialogWork:registerDoneListener(self._onFightDialogEnd, self)
		self._dialogWork:onStart()

		return
	end

	self:onDone(true)
end

function FightWorkNormalDialog:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkNormalDialog:clearWork()
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)

	if self._dialogWork then
		self._dialogWork:unregisterDoneListener(self._onFightDialogEnd, self)

		self._dialogWork = nil
	end
end

return FightWorkNormalDialog
