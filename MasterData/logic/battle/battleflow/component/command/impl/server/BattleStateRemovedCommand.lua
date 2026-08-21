-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleStateRemovedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleStateRemovedCommand", package.seeall)

local BattleStateRemovedCommand = class("BattleStateRemovedCommand", BattleCommandBase)

function BattleStateRemovedCommand:parseServerCommand(cmdParser, stateChangedEventNO)
	local cmd = BattleStateRemovedCommand:createInstance()

	cmd:setEntityId(stateChangedEventNO.entity)
	cmd:setStateEnum(stateChangedEventNO.state)
	cmdParser:addCommand(cmd)
end

function BattleStateRemovedCommand:onInit()
	self._entityId = 0
	self._stateEnum = 0
end

function BattleStateRemovedCommand:onClear()
	self._entityId = 0
	self._stateEnum = 0
end

function BattleStateRemovedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleStateRemovedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:inactiveState(self._stateEnum)
	BattleStateHandlerUtil.handleStateRemoved(self._stateEnum, unit, runningContext)
	self:finish(true)
end

function BattleStateRemovedCommand:toString()
	return string.format("[state removed command entityId = %s,state = %s]", self._entityId, self._stateEnum)
end

function BattleStateRemovedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleStateRemovedCommand:setStateEnum(stateEnum)
	self._stateEnum = stateEnum

	return self
end

return BattleStateRemovedCommand
