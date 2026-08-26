-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkCreateLSJASFDEmitter.lua

module("modules.logic.fight.system.work.asfd.FightWorkCreateLSJASFDEmitter", package.seeall)

local FightWorkCreateLSJASFDEmitter = class("FightWorkCreateLSJASFDEmitter", BaseWork)

function FightWorkCreateLSJASFDEmitter:ctor(fightStepData, asfdContext)
	self.fightStepData = fightStepData
	self.asfdContext = asfdContext
end

function FightWorkCreateLSJASFDEmitter:onStart()
	TaskDispatcher.runDelay(self.delayDone, self, 1)

	local asfdMgr = FightHelper.getASFDMgr()

	if not asfdMgr then
		return self:onDone(true)
	end

	local effectWarp = asfdMgr:createEmitterWrap(self.fightStepData)

	if effectWarp then
		asfdMgr:createLSJSpine(self.asfdContext)
		TaskDispatcher.runDelay(self.waitDone, self, FightASFDConfig.instance.emitterWaitTime)
	else
		return self:onDone(true)
	end
end

function FightWorkCreateLSJASFDEmitter:waitDone()
	return self:onDone(true)
end

function FightWorkCreateLSJASFDEmitter:delayDone()
	logError("鹭鸶剪 创建奥术飞弹发射源，超时了")

	return self:onDone(true)
end

function FightWorkCreateLSJASFDEmitter:clearWork()
	TaskDispatcher.cancelTask(self.delayDone, self)
	TaskDispatcher.cancelTask(self.waitDone, self)
end

return FightWorkCreateLSJASFDEmitter
