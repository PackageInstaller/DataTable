-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleStepDamageCountCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleStepDamageCountCommand", package.seeall)

local M = class("BattleStepDamageCountCommand", BattleCommandBase)

function M:create()
	local cmd = BattleStepDamageCountCommand:createInstance()

	cmd:setEvents(true)

	return cmd
end

function M:onInit()
	self._enemyDamagedCount = 0
	self._victimPosX = false
	self._victimPosY = false
	self._victimPosZ = false
end

function M:onClear()
	self._enemyDamagedCount = 0
	self._victimPosX = false
	self._victimPosY = false
	self._victimPosZ = false

	self:setEvents(false)
end

function M:setEvents(isAdd)
	if isAdd then
		BattleDispatcher:addEventListener(BattleEventType.DamageCountUpdate, self._onDamageUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.DamageCountUpdate, self._onDamageUpdate, self)
	end
end

function M:_onDamageUpdate(_, victimId, damage)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(victimId)

	if unit and BattleCampRelationUtil.isEnemyOfOperateCamp(unit) then
		if not self._victimPosX then
			self._victimPosX, self._victimPosY, self._victimPosZ = BattleUnitUtil.getUnitCenterPosOnCheckBoard(unit)
		end

		self._enemyDamagedCount = self._enemyDamagedCount + damage
	end
end

function M:execute()
	if self._enemyDamagedCount == 0 or not self._victimPosX then
		self:finish(true)

		return
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnDamaged, self._enemyDamagedCount, self._victimPosX, self._victimPosY, self._victimPosZ)
	self:finish(true)
end

return M
