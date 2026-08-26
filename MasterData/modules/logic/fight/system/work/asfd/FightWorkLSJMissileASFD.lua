-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkLSJMissileASFD.lua

module("modules.logic.fight.system.work.asfd.FightWorkLSJMissileASFD", package.seeall)

local FightWorkLSJMissileASFD = class("FightWorkLSJMissileASFD", BaseWork)

function FightWorkLSJMissileASFD:ctor(fightStepData, asfdContext, interval)
	FightWorkLSJMissileASFD.super.ctor(self, fightStepData)

	self.fightStepData = fightStepData
	self.asfdContext = asfdContext
	self.interval = interval
end

function FightWorkLSJMissileASFD:onStart()
	TaskDispatcher.runDelay(self.delayDone, self, 5)

	local asfdMgr = FightHelper.getASFDMgr()

	if not asfdMgr then
		return self:onDone(true)
	end

	local spineList = asfdMgr:getLSJSpineList()

	if not spineList then
		self:_emitMissile()

		return
	end

	local curIndex = self.asfdContext.emitterAttackNum
	local entity = spineList[curIndex]

	if not entity then
		self:_emitMissile()

		return
	end

	if asfdMgr:isLSJEmptyEntity(entity) then
		self:_emitMissile()

		return
	end

	self.entity = entity

	local spineGo = entity.spine:getSpineGO()

	if gohelper.isNil(spineGo) then
		FightController.instance:registerCallback(FightEvent.AfterInitSpine, self.onSpineLoadDone, self)

		return
	end

	local lsjPlayedAnimList = asfdMgr:getLSJPlayedAnimList()

	if lsjPlayedAnimList then
		lsjPlayedAnimList[curIndex] = true
	end

	self:playAction()
end

function FightWorkLSJMissileASFD:onSpineLoadDone(spine)
	if self.entity.id ~= spine.entity.id then
		return
	end

	self:playAction()
end

function FightWorkLSJMissileASFD:playAction()
	local lsjCo = FightASFDConfig.instance:getLSJCo(self.asfdContext.emitterAttackNum)

	self.entity.spine:play(lsjCo.action, false, true, true)

	local spinePosX, spinePosY, spinePosZ = transformhelper.getPos(self.entity.go.transform)
	local offset = FightStrUtil.instance:getSplitToNumberCache(lsjCo.missileOffset, ",")

	if offset then
		local missilePosX = spinePosX + (offset[1] or 0)

		if offset then
			local missilePosY = spinePosY + (offset[2] or 0)

			if offset then
				local missilePosZ = spinePosZ + (offset[3] or 0)

				self.asfdContext.missilePos = Vector3(missilePosX, missilePosY, missilePosZ)

				TaskDispatcher.runDelay(self._emitMissile, self, lsjCo.missileDelay / FightModel.instance:getUISpeed())
			end
		end
	end
end

function FightWorkLSJMissileASFD:_emitMissile()
	local asfdMgr = FightHelper.getASFDMgr()

	asfdMgr:emitMissile(self.fightStepData, self.asfdContext)
	TaskDispatcher.runDelay(self.waitDone, self, self.interval)
end

function FightWorkLSJMissileASFD:delayDone()
	logError("发射奥术飞弹 超时了")

	return self:onDone(true)
end

function FightWorkLSJMissileASFD:waitDone()
	return self:onDone(true)
end

function FightWorkLSJMissileASFD:clearWork()
	FightController.instance:unregisterCallback(FightEvent.AfterInitSpine, self.onSpineLoadDone, self)
	TaskDispatcher.cancelTask(self.delayDone, self)
	TaskDispatcher.cancelTask(self.waitDone, self)
	TaskDispatcher.cancelTask(self._emitMissile, self)
end

return FightWorkLSJMissileASFD
