-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkMissileASFDDone.lua

module("modules.logic.fight.system.work.asfd.FightWorkMissileASFDDone", package.seeall)

local FightWorkMissileASFDDone = class("FightWorkMissileASFDDone", BaseWork)

function FightWorkMissileASFDDone:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkMissileASFDDone:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 1)

	local asfdMgr = FightHelper.getASFDMgr()

	if asfdMgr then
		asfdMgr:clearEmitterEffect(self.fightStepData)
		asfdMgr:clearLSJSpine(self.fightStepData)
	end

	return self:onDone(true)
end

function FightWorkMissileASFDDone:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightWorkMissileASFDDone:_delayDone()
	logError("奥术飞弹 等待发射完成 超时了")

	return self:onDone(true)
end

return FightWorkMissileASFDDone
