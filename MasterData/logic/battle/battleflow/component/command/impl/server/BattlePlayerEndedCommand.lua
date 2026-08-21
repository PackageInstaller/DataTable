-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePlayerEndedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePlayerEndedCommand", package.seeall)

local BattlePlayerEndedCommand = class("BattlePlayerEndedCommand", BattleCommandBase)

function BattlePlayerEndedCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattlePlayerEndedCommand:createInstance()

	cmd:setCampId(eventFieldInt32)
	cmdParser:addCommand(BattleClearAllDeadUnitCommand:createInstance())
	cmdParser:addCommand(BattleDelayCommand:create(0.1))
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(0))
end

function BattlePlayerEndedCommand:onInit()
	self._campId = 0
end

function BattlePlayerEndedCommand:onClear()
	self._campId = 0
end

function BattlePlayerEndedCommand:execute(battleFlow)
	local localLogic = battleFlow.localLogic
	local roundReport = battleFlow.roundReport

	localLogic:handlePlayerEnded(self._campId)
	roundReport:playPlayerEndedReport(self._campId, self._onReportFinish, self)
	BattleDispatcher:dispatchEvent(BattleEventType.OnPlayerEnded, self._campId)
end

function BattlePlayerEndedCommand:_onReportFinish()
	self:finish(true)
end

function BattlePlayerEndedCommand:toString()
	return string.format("[player ended command campId = %s]", self._campId)
end

function BattlePlayerEndedCommand:setCampId(campId)
	self._campId = campId

	return self
end

return BattlePlayerEndedCommand
