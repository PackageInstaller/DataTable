-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleRoundStartedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleRoundStartedCommand", package.seeall)

local BattleRoundStartedCommand = class("BattleRoundStartedCommand", BattleCommandBase)

function BattleRoundStartedCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattleRoundStartedCommand:createInstance()

	cmd:setRound(eventFieldInt32)
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(0))
end

function BattleRoundStartedCommand:onInit()
	self._round = 0
end

function BattleRoundStartedCommand:onClear()
	self._round = 0
end

function BattleRoundStartedCommand:execute(battleFlow)
	local model = battleFlow.model
	local localLogic = battleFlow.localLogic
	local roundReport = battleFlow.roundReport
	local undoMgr = battleFlow.undoMgr

	self:_decreaseAdditionalTerrainRound()
	model:internal_setRound(self._round)
	localLogic:handleRoundStarted(self._round)
	undoMgr:recordRoundStartedEvent(self._round)
	roundReport:playRoundStartedReport(self._round, self._onReportFinish, self)
	model:setRoundStartStatus(true)
end

function BattleRoundStartedCommand:_decreaseAdditionalTerrainRound()
	local boardModel = BattleMgr.instance:getBoardModel()
	local boardMO = boardModel:getActiveBoardMO()

	for _, cellMO in boardMO:ipairs() do
		local additionalTerrainMO = cellMO:getAdditionalTerrainMO()

		if additionalTerrainMO then
			additionalTerrainMO:decRound()
		end
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnTerrainUpdate)
end

function BattleRoundStartedCommand:_onReportFinish()
	self:finish(true)
end

function BattleRoundStartedCommand:toString()
	return string.format("[round started command,round = %s]", self._round)
end

function BattleRoundStartedCommand:setRound(round)
	self._round = round

	return self
end

return BattleRoundStartedCommand
