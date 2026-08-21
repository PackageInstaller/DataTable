-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleStateAddedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleStateAddedCommand", package.seeall)

local BattleStateAddedCommand = class("BattleStateAddedCommand", BattleCommandBase)

function BattleStateAddedCommand:parseServerCommand(cmdParser, stateChangedEventNO)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local cmd = BattleStateAddedCommand:createInstance()

	cmd:setEntityId(stateChangedEventNO.entity)
	cmd:setStateEnum(stateChangedEventNO.state)
	cmd:setVictimEntityId(victimEntityId)
	cmdParser:addCommand(cmd)
end

function BattleStateAddedCommand:onInit()
	self._entityId = 0
	self._stateEnum = 0
	self._victimEntityId = 0
end

function BattleStateAddedCommand:onClear()
	self._entityId = 0
	self._stateEnum = 0
	self._victimEntityId = 0
end

function BattleStateAddedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleStateAddedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:activeState(self._stateEnum)
	BattleStateHandlerUtil.handleStateAdded(self._stateEnum, unit, runningContext)
	self:finish(true)
end

function BattleStateAddedCommand:toString()
	return string.format("[state added command entityId = %s,state = %s]", self._entityId, self._stateEnum)
end

function BattleStateAddedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleStateAddedCommand:setStateEnum(stateEnum)
	self._stateEnum = stateEnum

	return self
end

function BattleStateAddedCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

return BattleStateAddedCommand
