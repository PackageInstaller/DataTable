-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkMissileASFD.lua

module("modules.logic.fight.system.work.asfd.FightWorkMissileASFD", package.seeall)

local FightWorkMissileASFD = class("FightWorkMissileASFD", BaseWork)

function FightWorkMissileASFD:ctor(fightStepData, asfdContext, interval)
	FightWorkMissileASFD.super.ctor(self, fightStepData)

	self.fightStepData = fightStepData
	self.asfdContext = asfdContext
	self.interval = interval or self:getDefaultInterval()
	self.interval = self.interval / FightModel.instance:getUISpeed()
end

function FightWorkMissileASFD:getDefaultInterval()
	return (FightASFDConfig.instance:getMissileInterval(self.asfdContext.emitterAttackNum))
end

function FightWorkMissileASFD:onStart()
	TaskDispatcher.runDelay(self.delayDone, self, 1)

	local asfdMgr = FightHelper.getASFDMgr()

	if not asfdMgr then
		return self:onDone(true)
	end

	asfdMgr:emitMissile(self.fightStepData, self.asfdContext)
	TaskDispatcher.runDelay(self.waitDone, self, self.interval)
end

function FightWorkMissileASFD:delayDone()
	logError("发射奥术飞弹 超时了")

	return self:onDone(true)
end

function FightWorkMissileASFD:waitDone()
	return self:onDone(true)
end

function FightWorkMissileASFD:clearWork()
	TaskDispatcher.cancelTask(self.delayDone, self)
	TaskDispatcher.cancelTask(self.waitDone, self)
end

return FightWorkMissileASFD
