-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAttackSignCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAttackSignCommand", package.seeall)

local BattleAttackSignCommand = class("BattleAttackSignCommand", BattleCommandBase)

function BattleAttackSignCommand:create(entityId, attackingDirection, victimId, releaseDistance)
	local cmd = BattleAttackSignCommand:createInstance()

	cmd:setEntityId(entityId)
	cmd:setAttackingDirection(attackingDirection)
	cmd:setVictimId(victimId)
	cmd:setReleaseDistance(releaseDistance)

	return cmd
end

function BattleAttackSignCommand:executeAttackSignCommand(unit, attackingDirection)
	local isSteppedAttackerAtLeft = BattleCampRelationUtil.isSameOrFriendOfOperateCamp(unit)

	BattleDispatcher:dispatchEvent(BattleEventType.ON_SHOW_ATTACK_SIGN, isSteppedAttackerAtLeft, attackingDirection)
end

function BattleAttackSignCommand:onInit()
	self._entityId = false
	self._attackingDirection = false
	self._victimId = false
	self._releaseDistance = false
end

function BattleAttackSignCommand:onClear()
	self._entityId = false
	self._attackingDirection = false
	self._victimId = false
	self._releaseDistance = false
end

function BattleAttackSignCommand:execute(battleFlow)
	if self._attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER then
		self:executeForDistanceCounter()

		return
	end

	if self._attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE then
		self:finish(true)

		return
	end

	if self._attackingDirection then
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local unit = unitMgr:getUnit(self._entityId)

		BattleAttackSignCommand:executeAttackSignCommand(unit, self._attackingDirection)
	end

	self:finish(true)
end

function BattleAttackSignCommand:executeForDistanceCounter()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(self._entityId)
	local victim = unitMgr:getUnit(self._victimId)
	local x1, y1 = victim.transform:getCoordinates()
	local x2, y2 = attacker.transform:getCoordinates()

	if self._releaseDistance < math.abs(x1 - x2) + math.abs(y1 - y2) then
		BattleAttackSignCommand:executeAttackSignCommand(attacker, self._attackingDirection)
	end

	self:finish(true)
end

function BattleAttackSignCommand:toString()
	return string.format("[attack sign command entityId = %s,attackingDirection = %s]", self._entityId, self._attackingDirection)
end

function BattleAttackSignCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleAttackSignCommand:setAttackingDirection(attackingDirection)
	self._attackingDirection = attackingDirection

	return self
end

function BattleAttackSignCommand:setVictimId(victimId)
	self._victimId = victimId

	return self
end

function BattleAttackSignCommand:setReleaseDistance(releaseDistance)
	self._releaseDistance = releaseDistance

	return self
end

return BattleAttackSignCommand
