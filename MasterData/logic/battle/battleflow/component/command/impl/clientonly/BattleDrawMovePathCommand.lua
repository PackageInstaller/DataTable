-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleDrawMovePathCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleDrawMovePathCommand", package.seeall)

local BattleDrawMovePathCommand = class("BattleDrawMovePathCommand", BattleCommandBase)

function BattleDrawMovePathCommand:parseServerCommand(cmdParser, movedEventNO)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(movedEventNO.entity)
	local cmd = BattleDrawMovePathCommand:createInstance()

	cmd:setEntityId(movedEventNO.entity)
	cmd:insertPathCoordinates(unit.transform:getCoordinates())
	cmd:insertPathCoordinatesList(movedEventNO.movement)
	cmdParser:addCommand(cmd)
end

function BattleDrawMovePathCommand:onInit()
	self._entityId = 0
	self._pathUnionIndexList = {}
end

function BattleDrawMovePathCommand:onClear()
	self._entityId = 0

	table.clear(self._pathUnionIndexList)
end

function BattleDrawMovePathCommand:execute(battleFlow)
	local pathUnionIndexList = self._pathUnionIndexList
	local stopUnionIndex = pathUnionIndexList[#pathUnionIndexList]
	local pathArrow = battleFlow.pathArrow
	local boardMgr = battleFlow.boardMgr

	pathArrow:showPath(self._pathUnionIndexList)
	pathArrow:showFocusSign(stopUnionIndex)
	self:finish(true)
end

function BattleDrawMovePathCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleDrawMovePathCommand:insertPathCoordinates(x, z)
	table.insert(self._pathUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(x, z))
end

function BattleDrawMovePathCommand:insertPathCoordinatesList(coordinatesList)
	for _, coordinates in ipairs(coordinatesList) do
		self:insertPathCoordinates(coordinates.x, coordinates.z)
	end

	return self
end

function BattleDrawMovePathCommand:toString()
	return string.format("[draw move path command entityId = %s, path = %s]", self._entityId, tostring(self._needDrawPath), BattleTableUtil.arrayToString(self._pathUnionIndexList))
end

return BattleDrawMovePathCommand
