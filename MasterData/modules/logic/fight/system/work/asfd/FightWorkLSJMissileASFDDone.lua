-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkLSJMissileASFDDone.lua

module("modules.logic.fight.system.work.asfd.FightWorkLSJMissileASFDDone", package.seeall)

local FightWorkLSJMissileASFDDone = class("FightWorkLSJMissileASFDDone", BaseWork)

function FightWorkLSJMissileASFDDone:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkLSJMissileASFDDone:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 1)
	self:clearEmitterEffect()
	self:playDieAnimLSJSpine()

	return self:onDone(true)
end

function FightWorkLSJMissileASFDDone:clearEmitterEffect()
	local asfdMgr = FightHelper.getASFDMgr()

	if asfdMgr then
		asfdMgr:clearEmitterEffect(self.fightStepData)
	end
end

function FightWorkLSJMissileASFDDone:playDieAnimLSJSpine()
	local asfdMgr = FightHelper.getASFDMgr()

	if not asfdMgr then
		return
	end

	local playedAnimList = asfdMgr:getLSJPlayedAnimList()
	local spineList = asfdMgr:getLSJSpineList()

	if not spineList or not playedAnimList then
		return
	end

	if #playedAnimList == #spineList then
		return
	end

	local actionName = "die"
	local start = #playedAnimList + 1

	for i = start, #spineList do
		local spine = spineList[i]

		if not asfdMgr:isLSJEmptyEntity() then
			spine.spine:play(actionName, false, true, true)
		end
	end
end

function FightWorkLSJMissileASFDDone:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightWorkLSJMissileASFDDone:_delayDone()
	logError("奥术飞弹 等待发射完成 超时了")

	return self:onDone(true)
end

return FightWorkLSJMissileASFDDone
