-- chunkname: @modules/logic/fight/entity/effect/FightBuffDianJiShiEffectItem.lua

module("modules.logic.fight.entity.effect.FightBuffDianJiShiEffectItem", package.seeall)

local FightBuffDianJiShiEffectItem = class("FightBuffDianJiShiEffectItem", FightBaseClass)

function FightBuffDianJiShiEffectItem:onConstructor(entity, buffData, dianJiShiConfig)
	self.entity = entity
	self.entityId = entity.id
	self.buffData = buffData
	self.dianJiShiConfig = dianJiShiConfig
	self.bigSkillCounter = 0

	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.GetDianJiShiBiggerPriorityBuffEffect, self.onGetDianJiShiBiggerPriorityBuffEffect)
	self:com_registMsg(FightMsgId.DestroyDianJiShiSmallerPriorityBuffEffect, self.onDestroyDianJiShiSmallerPriorityBuffEffect)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.SetDianJiShiEffectVisible, self.onDianJiShiEffectVisible)
	self:com_registMsg(FightMsgId.UpdateEntityBuffActInfo, self.onUpdateEntityBuffActInfo)
	self:showEffect()
	FightMsgMgr.sendMsg(FightMsgId.DestroyDianJiShiSmallerPriorityBuffEffect, self.dianJiShiConfig.priority)
end

function FightBuffDianJiShiEffectItem:onDestroyDianJiShiSmallerPriorityBuffEffect(priority)
	if priority > self.dianJiShiConfig.priority then
		self.effectWrap:setActive(false, "FightBuffDianJiShiEffectItemPriority")
	end
end

function FightBuffDianJiShiEffectItem:showEffect()
	local config = self.dianJiShiConfig

	self.effectWrap = self.entity.effect:addHangEffect(config.effect, config.effectHang)

	self.effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.effectWrap)
	self.entity.buff:addLoopBuff(self.effectWrap)
	self:showInitEffect()
end

function FightBuffDianJiShiEffectItem:showInitEffect()
	local config = self.dianJiShiConfig

	self.initEffectWrap = self.entity.effect:addHangEffect(config.initEffect, config.initEffectHang, nil, config.initEffectDuration)

	self.initEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.initEffectWrap)

	local audioId = config.audioId

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightBuffDianJiShiEffectItem:onGetDianJiShiBiggerPriorityBuffEffect(priority)
	if priority < self.dianJiShiConfig.priority then
		FightMsgMgr.replyMsg(FightMsgId.GetDianJiShiBiggerPriorityBuffEffect, self)
	end
end

function FightBuffDianJiShiEffectItem:onRemoveBuff(buffData)
	if buffData ~= self.buffData then
		return
	end

	if self.effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.effectWrap)
		self.entity.effect:removeEffect(self.effectWrap)
		self.entity.buff:removeLoopBuff(self.effectWrap)

		self.effectWrap = nil
	end

	self:disposeSelf()

	local tar, list = FightMsgMgr.sendMsg(FightMsgId.GetDianJiShiBiggerPriorityBuffEffect, 0)

	if list then
		table.sort(list, FightBuffDianJiShiEffectItem.sortByPriority)
		list[1].effectWrap:setActive(true, "FightBuffDianJiShiEffectItemPriority")
		list[1]:showInitEffect()
	end
end

function FightBuffDianJiShiEffectItem.sortByPriority(a, b)
	return a.dianJiShiConfig.priority > b.dianJiShiConfig.priority
end

function FightBuffDianJiShiEffectItem:onSkillPlayStart(entity, curSkillId, fightStepData)
	if not self.effectWrap then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self.entityId and FightCardDataHelper.isBigSkill(curSkillId) then
		self.bigSkillCounter = self.bigSkillCounter + 1

		self.effectWrap:setActive(self.bigSkillCounter <= 0, "FightBuffDianJiShiEffectItem")
	end
end

function FightBuffDianJiShiEffectItem:onSkillPlayFinish(entity, curSkillId, fightStepData)
	if not self.effectWrap then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self.entityId and FightCardDataHelper.isBigSkill(curSkillId) then
		self.bigSkillCounter = self.bigSkillCounter - 1

		self.effectWrap:setActive(self.bigSkillCounter <= 0, "FightBuffDianJiShiEffectItem")
	end
end

function FightBuffDianJiShiEffectItem:onDianJiShiEffectVisible(visible, visibleKey)
	if not self.effectWrap then
		return
	end

	self.effectWrap:setActive(visible, visibleKey)
end

function FightBuffDianJiShiEffectItem:onUpdateEntityBuffActInfo(entityId, buffUid, actInfo)
	if entityId ~= self.entityId then
		return
	end

	if actInfo.actId ~= 1147 then
		return
	end

	local cusCounter = actInfo.param[1]

	if self.counter and cusCounter <= self.counter then
		self.counter = cusCounter

		return
	end

	if self.chargePlaying then
		return
	end

	self.chargePlaying = true
	self.counter = cusCounter

	local config = self.dianJiShiConfig
	local duration = config.chargeEffectDuration

	self:com_registTimer(self.afterChargeEffect, 2)

	self.chargeEffectWrap = self.entity.effect:addHangEffect(config.chargeEffect, config.chargeEffectHang, nil, duration)

	self.chargeEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.chargeEffectWrap)

	local audioId = config.chargeAudioId

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightBuffDianJiShiEffectItem:afterChargeEffect()
	self.chargePlaying = false
	self.chargeEffectWrap = nil
end

return FightBuffDianJiShiEffectItem
