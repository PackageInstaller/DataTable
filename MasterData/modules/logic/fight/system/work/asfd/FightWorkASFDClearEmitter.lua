-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDClearEmitter.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDClearEmitter", package.seeall)

local FightWorkASFDClearEmitter = class("FightWorkASFDClearEmitter", BaseWork)

function FightWorkASFDClearEmitter:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkASFDClearEmitter:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)

	local asfdMgr = FightHelper.getASFDMgr()

	if asfdMgr then
		asfdMgr:clearEmitterEffect(self.fightStepData)
	end

	return self:onDone(true)
end

function FightWorkASFDClearEmitter:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightWorkASFDClearEmitter:_delayDone()
	logError("奥术飞弹 ClearEmitter 超时了")

	return self:onDone(true)
end

return FightWorkASFDClearEmitter
