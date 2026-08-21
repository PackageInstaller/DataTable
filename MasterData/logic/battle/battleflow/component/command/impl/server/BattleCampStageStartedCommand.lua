-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleCampStageStartedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleCampStageStartedCommand", package.seeall)

local BattleCampStageStartedCommand = class("BattleCampStageStartedCommand", BattleCommandBase)

function BattleCampStageStartedCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattleCampStageStartedCommand:createInstance()

	cmd:setStageId(eventFieldInt32)
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(0))
end

function BattleCampStageStartedCommand:onInit()
	self._stageId = 0
end

function BattleCampStageStartedCommand:onClear()
	self._stageId = 0
end

function BattleCampStageStartedCommand:execute(battleFlow)
	local localLogic = battleFlow.localLogic
	local roundReport = battleFlow.roundReport
	local model = battleFlow.model

	localLogic:handleStageStarted(self._stageId)
	roundReport:playStageStartedReport(self._stageId, self._onReportFinish, self)
end

function BattleCampStageStartedCommand:_onReportFinish()
	self:finish(true)
end

function BattleCampStageStartedCommand:toString()
	return string.format("[camp stage started command stageId = %s]", self._stageId)
end

function BattleCampStageStartedCommand:setStageId(stageId)
	self._stageId = stageId

	return self
end

return BattleCampStageStartedCommand
