-- chunkname: @modules/logic/fight/system/work/FightWorkWaitDialog.lua

module("modules.logic.fight.system.work.FightWorkWaitDialog", package.seeall)

local FightWorkWaitDialog = class("FightWorkWaitDialog", BaseWork)

function FightWorkWaitDialog:onStart()
	local godialogcontainer = gohelper.find("UIRoot/HUD/FightView/#go_dialogcontainer")

	if godialogcontainer and godialogcontainer.activeInHierarchy then
		TaskDispatcher.runDelay(self._delayDone, self, 60)
		FightController.instance:registerCallback(FightEvent.FightDialogShow, self._onFightDialogShow, self)
		FightController.instance:registerCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
	else
		self:onDone(true)
	end
end

function FightWorkWaitDialog:_onFightDialogShow()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.runDelay(self._delayDone, self, 60)
end

function FightWorkWaitDialog:_delayDone()
	self:onDone(true)
end

function FightWorkWaitDialog:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkWaitDialog:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.FightDialogShow, self._onFightDialogShow, self)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
end

return FightWorkWaitDialog
