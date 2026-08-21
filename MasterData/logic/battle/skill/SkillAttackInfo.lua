-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/SkillAttackInfo.lua

module("logic.battle.skill.SkillAttackInfo", package.seeall)

local SkillAttackInfo = class("SkillAttackInfo", AbstractGlobalReusable)

function SkillAttackInfo:ctor()
	self._attackPointHandlers = {}
	self._victims = {}
	self._deadEntityIds = {}
	self._refUnits = {}

	self:reset()
end

function SkillAttackInfo:reuse(...)
	return
end

function SkillAttackInfo:reset()
	self._attacker = false
	self._skillId = false
	self._isReversePosition = false
	self._attackingDirection = false
	self._hasPriorityCounter = false
	self._isStrengthening = false
	self._animState = false
	self._isShowNormalHitEffect = false
	self._continuousType = 0
	self._continuousCount = 0
	self._continuousIndex = 0
	self._totalContinuousCount = 0

	self:_clearAttackPointHandlers()
	BattleTableUtil.clearTable(self._victims)
	BattleTableUtil.clearTable(self._deadEntityIds)
	BattleTableUtil.clearTable(self._refUnits)
end

function SkillAttackInfo:destroy()
	self:reset()
end

function SkillAttackInfo:clear()
	self:reset()
end

function SkillAttackInfo:copyFrom(attackInfo)
	self._attacker = attackInfo._attacker
	self._skillId = attackInfo._skillId
	self._isReversePosition = attackInfo._isReversePosition
	self._attackingDirection = attackInfo._attackingDirection
	self._hasPriorityCounter = attackInfo._hasPriorityCounter
	self._isStrengthening = attackInfo._isStrengthening
	self._animState = attackInfo._animState
	self._continuousType = attackInfo._continuousType
	self._continuousCount = attackInfo._continuousCount
	self._continuousIndex = attackInfo._continuousIndex
	self._totalContinuousCount = attackInfo._totalContinuousCount
	self._isShowNormalHitEffect = attackInfo._isShowNormalHitEffect

	self:passAttackPointHandlers(attackInfo._attackPointHandlers)
	BattleTableUtil.insertto(self._victims, attackInfo._victims)
	BattleTableUtil.insertto(self._deadEntityIds, attackInfo._deadEntityIds)
	BattleTableUtil.insertto(self._refUnits, attackInfo._refUnits)
end

function SkillAttackInfo:setAttacker(attacker)
	self._attacker = attacker

	return self
end

function SkillAttackInfo:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function SkillAttackInfo:setDeadEntityIds(deadEntityIds)
	BattleTableUtil.insertto(self._deadEntityIds, deadEntityIds)

	return self
end

function SkillAttackInfo:setReversePosition(isReversePosition)
	self._isReversePosition = isReversePosition

	return self
end

function SkillAttackInfo:setAttackingDirection(attackingDirection, hasPriorityCounter)
	self._attackingDirection = attackingDirection
	self._hasPriorityCounter = hasPriorityCounter

	return self
end

function SkillAttackInfo:setIsStrengthening(isStrengthening)
	self._isStrengthening = isStrengthening

	return self
end

function SkillAttackInfo:setAnimState(animState)
	self._animState = animState
end

function SkillAttackInfo:passAttackPointHandlers(attackPointHandlers)
	BattleTableUtil.insertto(self._attackPointHandlers, attackPointHandlers)
	BattleTableUtil.clearTable(attackPointHandlers)

	return self
end

function SkillAttackInfo:addAttackPointHandler(attackPointHandler)
	table.insert(self._attackPointHandlers, attackPointHandler)

	return self
end

function SkillAttackInfo:addVictim(victim)
	BattleTableUtil.insertunique(self._victims, victim)
end

function SkillAttackInfo:addRefUnit(unit)
	BattleTableUtil.insertunique(self._refUnits, unit)
end

function SkillAttackInfo:getAttacker()
	return self._attacker
end

function SkillAttackInfo:getVictims()
	return self._victims
end

function SkillAttackInfo:getRefUnits()
	return self._refUnits
end

function SkillAttackInfo:getFirstVictim()
	if #self._victims > 0 then
		return self._victims[1]
	end

	return false
end

function SkillAttackInfo:getSkillId()
	return self._skillId
end

function SkillAttackInfo:getAttackPointHandlers()
	return self._attackPointHandlers
end

function SkillAttackInfo:getDeadEntityIds()
	return self._deadEntityIds
end

function SkillAttackInfo:isReversePosition()
	return self._isReversePosition
end

function SkillAttackInfo:getAttackingDirection()
	return self._attackingDirection
end

function SkillAttackInfo:hasPriorityCounter()
	return self._hasPriorityCounter
end

function SkillAttackInfo:isStrengthening()
	return self._isStrengthening
end

function SkillAttackInfo:getAnimState()
	return self._animState
end

function SkillAttackInfo:setContinuousType(type)
	self._continuousType = type
end

function SkillAttackInfo:getContinuousType()
	return self._continuousType
end

function SkillAttackInfo:setContinuousCount(count)
	self._continuousCount = count
end

function SkillAttackInfo:getContinuousCount()
	return self._continuousCount
end

function SkillAttackInfo:setContinuousIndex(continuousIndex)
	self._continuousIndex = continuousIndex
end

function SkillAttackInfo:getContinuousIndex()
	return self._continuousIndex
end

function SkillAttackInfo:setTotalContinuousCount(totalContinuousCount)
	self._totalContinuousCount = totalContinuousCount
end

function SkillAttackInfo:getTotalContinuousCount()
	return self._totalContinuousCount
end

function SkillAttackInfo:_clearAttackPointHandlers()
	for _, handler in pairs(self._attackPointHandlers) do
		handler:returnSelf()
	end

	BattleTableUtil.clearTable(self._attackPointHandlers)
end

function SkillAttackInfo:setShowNormalHitEffect(isShowNormalHitEffect)
	self._isShowNormalHitEffect = isShowNormalHitEffect
end

function SkillAttackInfo:getShowNormalHitEffect()
	return self._isShowNormalHitEffect
end

return SkillAttackInfo
