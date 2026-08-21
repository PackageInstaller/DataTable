-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/monster/RogueUnitCompMonsterProp.lua

module("logic.extensions.roguelike.unit.comp.monster.RogueUnitCompMonsterProp", package.seeall)

local M = class("RogueUnitCompMonsterProp", RogueUnitCompBase)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:initByConfig(co)
	self._id = co.id
	self._hp = co.totalDice
	self._fighting = co.fighting
	self._weakness = {}
	self._attack = 1
	self._attackType = 1
	self._sanAttack = 1
	self._co = co
end

function M:getName()
	return self._co.name
end

function M:getBuffId()
	return self._co.passiveEffect
end

function M:getPassiveEffectDesc()
	local buffId = self:getBuffId()
	local effectCo = RoguelikeConfig.instance:getEffectById(buffId)

	return effectCo and effectCo.description or ""
end

function M:getPassiveDesc()
	return self._co.passiveDesc
end

function M:setReplaceId(newMonsterId)
	self._replaceId = newMonsterId

	local co = RoguelikeConfig.instance:getRoguelikeMonsterById(newMonsterId)

	self._fighting = co.fighting
	self._weakness = {}
	self._attack = 1
	self._attackType = 1
	self._sanAttack = 1
	self._co = co
end

function M:getReplaceId()
	return self._replaceId
end

function M:getOriginHp()
	return self._co and self._co.totalDice or 10
end

function M:getHeadIcon()
	return self._co and self._co.head or ""
end

function M:getId()
	return self._id
end

function M:onReset()
	self._id = 0
	self._hp = 0
	self._fighting = 0
	self._weakness = 0
	self._attack = 0
	self._fixedFighting = nil
end

function M:getFighting()
	return self._fighting
end

function M:setFighting(fighting)
	self._fighting = fighting
end

function M:setFixedFighting(fighting)
	self._fixedFighting = fighting
end

function M:getAttack()
	return self._attack
end

function M:setAttack(attack)
	self._attack = attack
end

function M:getSanAttack()
	return self._sanAttack
end

function M:setSanAttack(sanAttack)
	self._sanAttack = sanAttack
end

function M:setHp(hp, ignoreDispatch)
	self._hp = hp

	if not ignoreDispatch then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_MONSTER_HP, self._id, self._hp)
	end
end

function M:getHp()
	return self._hp
end

function M:getIsDeath()
	return self._hp <= 0
end

function M:reduceHp(reduce, isTemp, isAllowOverflow)
	if self._hp - reduce > self:getOriginHp() and not isAllowOverflow then
		return
	end

	self._hp = self._hp - reduce < 0 and 0 or self._hp - reduce

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_MONSTER_HP, self._id, self._hp, isTemp)
end

function M:addHp(addition)
	self._hp = self._hp + addition
end

function M:getWeakness()
	return self._weakness
end

function M:getAttackType()
	return self._attackType
end

function M:getSuccessEffectId()
	return self._co.successEffectId
end

function M:getFailEffectId()
	return {}
end

function M:getAniTime()
	return self._co.aniTimes
end

function M:getFeaturesDices()
	if not self._co then
		printError("没有初始化怪物属性")
	end

	return self._co and self._co.features or {
		1,
		2,
		3,
		4,
		5,
		6
	}
end

function M:setAttackType(attackType)
	self._attackType = attackType
end

function M:setIsHpImmuneAttack(isHpImmuneAttack)
	self._isHpImmuneAttack = isHpImmuneAttack
end

function M:getIsHpImmuneAttack()
	return self._isHpImmuneAttack
end

function M:getHpYOffset()
	return self._co.hpBarYOffset
end

function M:getActionSection(idx)
	local index = idx or RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()
	local sections = {
		self._co.action1Section,
		self._co.action2Section,
		self._co.action3Section,
		self._co.action4Section,
		self._co.action5Section,
		self._co.action5Section
	}
	local section = sections[index]
	local randomCount = math.random(section[1], section[2])

	return randomCount
end

function M:getActionSectionRound(idx)
	local index = idx or RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()
	local sections = {
		self._co.action1Section,
		self._co.action2Section,
		self._co.action3Section,
		self._co.action4Section,
		self._co.action5Section,
		self._co.action5Section
	}
	local section = sections[index]

	return section[1], section[2]
end

return M
