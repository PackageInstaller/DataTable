-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffLockHpComp.lua

module("modules.logic.fight.entity.comp.buff.FightBuffLockHpComp", package.seeall)

local FightBuffLockHpComp = class("FightBuffLockHpComp")

function FightBuffLockHpComp:ctor()
	return
end

function FightBuffLockHpComp:refreshLockHp()
	FightController.instance:dispatchEvent(FightEvent.OnLockHpChange, self.entityId)
end

function FightBuffLockHpComp:onBuffStart(entity, buffMo)
	self.entityId = entity.entityId

	self:refreshLockHp()
end

function FightBuffLockHpComp:onUpdateBuff(entityId, effectType, buffId, buffUid)
	self:refreshLockHp()
end

function FightBuffLockHpComp:onBuffEnd()
	self:refreshLockHp()
end

function FightBuffLockHpComp:dispose()
	self:refreshLockHp()
end

return FightBuffLockHpComp
