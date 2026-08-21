-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleCampStageEndedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleCampStageEndedCommand", package.seeall)

local BattleCampStageEndedCommand = class("BattleCampStageEndedCommand", BattleCommandBase)

function BattleCampStageEndedCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattleCampStageEndedCommand:createInstance()

	cmd:setStageId(eventFieldInt32)
	cmdParser:addCommand(cmd)
end

function BattleCampStageEndedCommand:onInit()
	self._stageId = 0
end

function BattleCampStageEndedCommand:onClear()
	self._stageId = 0
end

function BattleCampStageEndedCommand:execute(battleFlow)
	local localLogic = battleFlow.localLogic
	local roundReport = battleFlow.roundReport

	localLogic:handleStageEnded(self._stageId)
	roundReport:playStageEndedReport(self._stageId, self._onReportFinish, self)
end

function BattleCampStageEndedCommand:_onReportFinish()
	self:finish(true)
end

function BattleCampStageEndedCommand:toString()
	return string.format("[camp stage ended command stageId = %s]", self._stageId)
end

function BattleCampStageEndedCommand:setStageId(stageId)
	self._stageId = stageId

	return self
end

return BattleCampStageEndedCommand
