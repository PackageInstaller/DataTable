-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleCellsBlockedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleCellsBlockedCommand", package.seeall)

local BattleCellsBlockedCommand = class("BattleCellsBlockedCommand", BattleCommandBase)

function BattleCellsBlockedCommand:parseServerCommand(cmdParser, cellsBlockedEventNO)
	local cmd = BattleCellsBlockedCommand:createInstance()

	cmd:setEntityId(cellsBlockedEventNO.entity)
	cmd:setSkillCode(cellsBlockedEventNO.skill)
	cmd:setCoordinatesList(cellsBlockedEventNO.cells)
	cmdParser:addCommand(cmd)
end

function BattleCellsBlockedCommand:createFromCellsBlockedEventNO(unionIndex, cellsBlockedEventNO)
	local cmd = BattleCellsBlockedCommand:createInstance()

	cmd:setEntityId(cellsBlockedEventNO.entity)
	cmd:setSkillCode(cellsBlockedEventNO.skill)
	cmd:addUnionIndex(unionIndex)

	return cmd
end

function BattleCellsBlockedCommand:onInit()
	self._entityId = 0
	self._skillCode = 0
	self._unionIndexList = {}
end

function BattleCellsBlockedCommand:onClear()
	self._entityId = 0
	self._skillCode = 0

	BattleTableUtil.clearTable(self._unionIndexList)
end

function BattleCellsBlockedCommand:execute(battleFlow)
	local boardModel = battleFlow.boardModel
	local unionIndexList = self._unionIndexList

	for _, unionIndex in ipairs(unionIndexList) do
		local cellMO = boardModel:getBoardCellMO(unionIndex)
		local cellStateMO = CheckerBoardCellStateMO:createInstance()

		cellStateMO:setEntityId(self._entityId)
		cellStateMO:setSkillCode(self._skillCode)
		cellStateMO:setState(BattleEnum.CellState.BLOCKED)
		cellMO:addStateMO(cellStateMO)
	end

	self:finish(true)
end

function BattleCellsBlockedCommand:toString()
	return string.format("[cells blocked command entityId = %s,skillCode = %s,unionIndexList = %s]", self._entityId, self._skillCode, BattleTableUtil.arrayToString(self._unionIndexList))
end

function BattleCellsBlockedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleCellsBlockedCommand:setSkillCode(skillCode)
	self._skillCode = skillCode

	return self
end

function BattleCellsBlockedCommand:setCoordinatesList(coordinatesList)
	for _, coordinates in ipairs(coordinatesList) do
		table.insert(self._unionIndexList, BoardIndexConverter.coordinatesToUnionIndex(coordinates.x, coordinates.z))
	end

	return self
end

function BattleCellsBlockedCommand:addUnionIndex(unionIndex)
	table.insert(self._unionIndexList, unionIndex)

	return self
end

return BattleCellsBlockedCommand
