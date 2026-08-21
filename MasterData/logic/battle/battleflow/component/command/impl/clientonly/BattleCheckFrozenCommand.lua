-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleCheckFrozenCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleCheckFrozenCommand", package.seeall)

local BattleCheckFrozenCommand = class("BattleCheckFrozenCommand", BattleCommandBase)

function BattleCheckFrozenCommand:create(entityId)
	local cmd = BattleCheckFrozenCommand:createInstance()

	cmd:setAttackerEntityId(entityId)

	return cmd
end

function BattleCheckFrozenCommand:onInit()
	self._timeWaiter = TimeWaiter.New()
	self._attackerEntityId = false
end

function BattleCheckFrozenCommand:onClear(interrupt)
	self._timeWaiter:clear()

	self._attackerEntityId = false
end

function BattleCheckFrozenCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._attackerEntityId)

	if unit.property:isStateActive(BattleEnum.State.WEAKPOINT_FROZEN) then
		unit.uiProxy:setDiableActionArrowStatus(true)
		self._timeWaiter:start(BattleConst.DelayOne, self._onAnimationFinish, self)

		return
	end

	self:finish(true)
end

function BattleCheckFrozenCommand:_onAnimationFinish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._attackerEntityId)

	unit.uiProxy:setDiableActionArrowStatus(false)
	self:finish(true)
end

function BattleCheckFrozenCommand:toString()
	return string.format("[check frozen,attackerEntityId = %s]", tostring(self._attackerEntityId))
end

function BattleCheckFrozenCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

return BattleCheckFrozenCommand
