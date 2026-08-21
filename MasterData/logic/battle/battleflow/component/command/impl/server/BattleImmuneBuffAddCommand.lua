-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleImmuneBuffAddCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleImmuneBuffAddCommand", package.seeall)

local M = class("BattleImmuneBuffAddCommand", BattleCommandBase)

function M:parseServerCommand(cmdParser, immuneBuffAddNO)
	local cmd = M:createInstance()

	cmd:setEntityId(immuneBuffAddNO.entity)
	cmd:setBuffs(immuneBuffAddNO.buffs)
	cmdParser:addCommand(cmd)
end

function M:onInit()
	self._entityId = 0
	self._immuneBuffList = {}
end

function M:onClear()
	self._entityId = 0

	BattleTableUtil.clearTable(self._immuneBuffList)
end

function M:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("M::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	for i, buffCode in ipairs(self._immuneBuffList) do
		unit.property:addImmuneBuff(buffCode)
		ImmuneBuffHandlerUtil.handleSpecialImmuneUpdate(unit, buffCode, true)
	end

	self:finish(true)
end

function M:toString()
	return string.format("[BattleImmuneBuffAddCommand entityId = %s,immuneBuffList = %s]", self._entityId, #self._immuneBuffList)
end

function M:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function M:setBuffs(buffs)
	for i, v in ipairs(buffs) do
		table.insert(self._immuneBuffList, v)
	end

	return self
end

return M
