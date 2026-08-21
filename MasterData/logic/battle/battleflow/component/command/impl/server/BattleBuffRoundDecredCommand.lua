-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleBuffRoundDecredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleBuffRoundDecredCommand", package.seeall)

local BattleBuffRoundDecredCommand = class("BattleBuffRoundDecredCommand", BattleCommandBase)

function BattleBuffRoundDecredCommand:parseServerCommand(cmdParser, buffTriggeredEventNO)
	local cmd = BattleBuffRoundDecredCommand:createInstance()

	cmd:setEntityId(buffTriggeredEventNO.entity)
	cmd:setBuffIds(buffTriggeredEventNO.ids)
	cmd:setDecrement(buffTriggeredEventNO.decrement)
	cmdParser:addCommand(cmd)
end

function BattleBuffRoundDecredCommand:onInit()
	self._entityId = 0
	self._decrement = 0
	self._buffIds = {}
end

function BattleBuffRoundDecredCommand:onClear()
	self._entityId = 0
	self._decrement = 0

	BattleTableUtil.clearTable(self._buffIds)
end

function BattleBuffRoundDecredCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleBuffRoundDecredCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.buff:decRound(self._buffIds, self._decrement)
	self:finish(true)
end

function BattleBuffRoundDecredCommand:toString()
	return string.format("[buff round decred command entityId = %s,buffIds = %s,decrement = %s]", self._entityId, BattleTableUtil.arrayToString(self._buffIds), self._decrement)
end

function BattleBuffRoundDecredCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleBuffRoundDecredCommand:setDecrement(decrement)
	self._decrement = decrement

	return self
end

function BattleBuffRoundDecredCommand:setBuffIds(buffIds)
	if buffIds then
		table.insertto(self._buffIds, buffIds)
	end

	return self
end

return BattleBuffRoundDecredCommand
