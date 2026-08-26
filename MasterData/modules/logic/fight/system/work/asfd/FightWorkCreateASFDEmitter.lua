-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkCreateASFDEmitter.lua

module("modules.logic.fight.system.work.asfd.FightWorkCreateASFDEmitter", package.seeall)

local FightWorkCreateASFDEmitter = class("FightWorkCreateASFDEmitter", BaseWork)

function FightWorkCreateASFDEmitter:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkCreateASFDEmitter:onStart()
	TaskDispatcher.runDelay(self.delayDone, self, 1)

	local asfdMgr = FightHelper.getASFDMgr()

	if not asfdMgr then
		return self:onDone(true)
	end

	local effectWarp = asfdMgr:createEmitterWrap(self.fightStepData)

	if effectWarp then
		TaskDispatcher.runDelay(self.waitDone, self, FightASFDConfig.instance.emitterWaitTime)
	else
		return self:onDone(true)
	end
end

function FightWorkCreateASFDEmitter:waitDone()
	return self:onDone(true)
end

function FightWorkCreateASFDEmitter:delayDone()
	logError("创建奥术飞弹发射源，超时了")

	return self:onDone(true)
end

function FightWorkCreateASFDEmitter:clearWork()
	TaskDispatcher.cancelTask(self.delayDone, self)
	TaskDispatcher.cancelTask(self.waitDone, self)
end

return FightWorkCreateASFDEmitter
