-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLUnnamedEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLUnnamedEffect", package.seeall)

local FightTLUnnamedEffect = class("FightTLUnnamedEffect", FightTimelineTrackItem)

function FightTLUnnamedEffect:onTrackStart(fightStepData, duration, paramsArr)
	local actEffect = FightHelper.getActEffectData(FightEnum.EffectType.UNNAMEDSTRENGTHEN, fightStepData)

	if not actEffect then
		return
	end

	local effectName = paramsArr[1]
	local mountPoint = paramsArr[2]

	if string.nilorempty(effectName) then
		return
	end

	local targetId = actEffect.targetId
	local entity = FightHelper.getEntity(targetId)

	if not entity then
		return
	end

	local posX, posY, posZ

	if mountPoint == "0" then
		posX, posY, posZ = FightHelper.getEntityWorldBottomPos(entity)
	elseif mountPoint == "1" then
		posX, posY, posZ = FightHelper.getEntityWorldCenterPos(entity)
	elseif mountPoint == "2" then
		posX, posY, posZ = FightHelper.getEntityWorldTopPos(entity)
	elseif mountPoint == "3" then
		posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)
	else
		posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)
	end

	self.effectWrap = entity.effect:addGlobalEffect(effectName, entity:getSide())

	self.effectWrap:setWorldPos(posX, posY, posZ)
	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, self.effectWrap)

	self.entity = entity
end

function FightTLUnnamedEffect:onTrackEnd()
	self:removeEffect()
end

function FightTLUnnamedEffect:onDestructor()
	self:removeEffect()
end

function FightTLUnnamedEffect:removeEffect()
	if self.effectWrap then
		self.entity.effect:removeEffect(self.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.effectWrap)

		self.effectWrap = nil
		self.entity = nil
	end
end

return FightTLUnnamedEffect
