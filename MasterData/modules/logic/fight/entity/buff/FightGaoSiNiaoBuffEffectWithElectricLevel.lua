-- chunkname: @modules/logic/fight/entity/buff/FightGaoSiNiaoBuffEffectWithElectricLevel.lua

module("modules.logic.fight.entity.buff.FightGaoSiNiaoBuffEffectWithElectricLevel", package.seeall)

local FightGaoSiNiaoBuffEffectWithElectricLevel = class("FightGaoSiNiaoBuffEffectWithElectricLevel", FightBaseClass)

function FightGaoSiNiaoBuffEffectWithElectricLevel:onConstructor(buffData)
	self.buffData = buffData
	self.uid = buffData.uid
	self.entityId = buffData.entityId
	self.buffId = buffData.buffId
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)
	self.entity = FightHelper.getEntity(self.entityId)
	self.bigSkillCounter = 0

	self:com_registMsg(FightMsgId.OnUpdateBuff, self.refreshEffect)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.UpdateMagicCircile, self.onUpdateMagicCircile)
	self:com_registFightEvent(FightEvent.DeleteMagicCircile, self.onDeleteMagicCircile)
	self:com_registFightEvent(FightEvent.AddMagicCircile, self.onAddMagicCircile)
	self:com_registFightEvent(FightEvent.UpgradeMagicCircile, self.onUpgradeMagicCircile)
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onLogicEnter()
	self:refreshEffect(self.uid)
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onUpdateMagicCircile()
	self:refreshEffect(self.uid)
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onUpgradeMagicCircile()
	self:refreshEffect(self.uid)
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onDeleteMagicCircile()
	self:refreshEffect(self.uid)
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onAddMagicCircile()
	self:refreshEffect(self.uid)
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:refreshEffect(uid)
	if uid ~= self.uid then
		return
	end

	if self.effectWrap then
		self.entity.effect:removeEffect(self.effectWrap)
		self.entity.buff:removeLoopBuff(self.effectWrap)

		self.effectWrap = nil
	end

	local config = lua_fight_gao_si_niao_buffeffect_electric_level.configDict[self.buffId]

	if not config then
		return
	end

	config = config[self.entityData.skin] or config[0]

	if not config then
		return
	end

	local magicCircleData = FightModel.instance:getMagicCircleInfo()

	config = magicCircleData and config[magicCircleData.electricLevel] or config[1]

	if not config then
		return
	end

	self.effectWrap = self.entity.effect:addHangEffect(config.effect, config.effectHangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.effectWrap)
	self.effectWrap:setLocalPos(0, 0, 0)
	self.entity.buff:addLoopBuff(self.effectWrap)

	local audioId = config.audio

	if audioId and audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onSkillPlayStart(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self.entityId and FightCardDataHelper.isBigSkill(curSkillId) then
		self.bigSkillCounter = self.bigSkillCounter + 1

		self.effectWrap:setActive(self.bigSkillCounter <= 0, "FightGaoSiNiaoBuffEffectWithElectricLevel")
	end
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onSkillPlayFinish(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self.entityId and FightCardDataHelper.isBigSkill(curSkillId) then
		self.bigSkillCounter = self.bigSkillCounter - 1

		self.effectWrap:setActive(self.bigSkillCounter <= 0, "FightGaoSiNiaoBuffEffectWithElectricLevel")
	end
end

function FightGaoSiNiaoBuffEffectWithElectricLevel:onDestructor()
	if self.effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.effectWrap)
		self.entity.effect:removeEffect(self.effectWrap)
		self.entity.buff:removeLoopBuff(self.effectWrap)

		self.effectWrap = nil
	end
end

return FightGaoSiNiaoBuffEffectWithElectricLevel
