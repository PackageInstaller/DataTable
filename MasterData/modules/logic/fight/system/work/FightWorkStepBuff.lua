-- chunkname: @modules/logic/fight/system/work/FightWorkStepBuff.lua

module("modules.logic.fight.system.work.FightWorkStepBuff", package.seeall)

local FightWorkStepBuff = class("FightWorkStepBuff", FightEffectBase)

function FightWorkStepBuff:beforePlayEffectData()
	local buff = self.actEffectData.buff

	self._buffUid = buff and buff.uid
	self._buffId = buff and buff.buffId
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if not self._entityMO then
		return
	end

	local curMO = self._entityMO:getBuffMO(self._buffUid)

	self._oldBuffMO = FightHelper.deepCopySimpleWithMeta(curMO)
end

function FightWorkStepBuff:onStart()
	if not self._entityMO then
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity(self._entityId)

	if not entity then
		self:onDone(true)

		return
	end

	if not entity.buff then
		self:onDone(true)

		return
	end

	FightWorkStepBuff.updateWaitTime = FightBuffHelper.canPlayDormantBuffAni(self.actEffectData, self.fightStepData)

	local effectType = self.actEffectData.effectType

	if effectType == FightEnum.EffectType.BUFFADD or effectType == FightEnum.EffectType.BUFFUPDATE then
		self._newBuffMO = self._entityMO:getBuffMO(self._buffUid)

		if not self._newBuffMO then
			self:onDone(true)

			return
		end
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		entity.buff:addBuff(self._newBuffMO, false, self.fightStepData.stepUid)
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		entity.buff:delBuff(self._buffUid)
	elseif effectType == FightEnum.EffectType.BUFFUPDATE then
		entity.buff:updateBuff(self._newBuffMO, self._oldBuffMO or self._newBuffMO, self.actEffectData)
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, self._entityId, effectType, self._buffId, self._buffUid, self.actEffectData.configEffect, self.actEffectData.buff)

	local durationDic = FightDataHelper.tempMgr.buffDurationDic[self._entityId]

	if not durationDic then
		durationDic = {}
		FightDataHelper.tempMgr.buffDurationDic[self._entityId] = durationDic
	end

	durationDic[self._buffUid] = self.actEffectData.buff.duration

	if FightWorkStepBuff.canPlayDormantBuffAni then
		self:com_registTimer(self._delayDone, FightWorkStepBuff.updateWaitTime / FightModel.instance:getSpeed())

		return
	end

	if self._buffId == 229601 then
		self:com_registTimer(self._delayDone, 1.5)

		return
	end

	self:defaultLogic()
end

function FightWorkStepBuff:defaultLogic()
	local effectType = self.actEffectData.effectType
	local workList

	if effectType == FightEnum.EffectType.BUFFADD then
		workList = FightMsgMgr.sendMsg(FightMsgId.GetAddBuffShowWork, self._entityId, self._buffUid)
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		workList = FightMsgMgr.sendMsg(FightMsgId.GetRemoveBuffShowWork, self._entityId, self._buffUid)
	elseif effectType == FightEnum.EffectType.BUFFUPDATE then
		workList = FightMsgMgr.sendMsg(FightMsgId.GetUpdateBuffShowWork, self._entityId, self._buffUid)
	end

	self:playWorkAndDone(workList)
end

function FightWorkStepBuff:clearWork()
	return
end

return FightWorkStepBuff
