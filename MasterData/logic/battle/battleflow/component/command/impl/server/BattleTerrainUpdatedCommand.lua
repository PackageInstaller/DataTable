-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTerrainUpdatedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTerrainUpdatedCommand", package.seeall)

local BattleTerrainUpdatedCommand = class("BattleTerrainUpdatedCommand", BattleCommandBase)

function BattleTerrainUpdatedCommand:parseServerCommand(cmdParser, cellNOList)
	local cmd = BattleTerrainUpdatedCommand:createInstance()

	cmd:addFromCellNOList(cellNOList)
	cmdParser:addCommand(cmd)
end

function BattleTerrainUpdatedCommand:onInit()
	self._cellInfoList = {}
end

function BattleTerrainUpdatedCommand:onClear()
	BattleTableUtil.clearReusableTable(self._cellInfoList)
end

function BattleTerrainUpdatedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local boardModel = battleFlow.boardModel
	local cellInfoList = self._cellInfoList

	for _, cellInfo in ipairs(cellInfoList) do
		local additionalTerrainInfo = cellInfo.additionalTerrainInfo
		local cellMO = boardModel:getBoardCellMO(cellInfo.unionIndex)
		local terrainMO = cellMO:getAdditionalTerrainMO()

		terrainMO:updateTerrain(additionalTerrainInfo)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnTerrainUpdate)
	self:finish(true)
end

function BattleTerrainUpdatedCommand:toString()
	return string.format("[terrain updated command, cellInfoList = %s]", BattleTableUtil.arrayToString(self._cellInfoList))
end

function BattleTerrainUpdatedCommand:addFromCellNOList(cellNOList)
	for _, cellNO in ipairs(cellNOList) do
		local cellIndex = BoardIndexConverter.cellNOToUnionIndex(cellNO)
		local cellInfo = BattleCellInfo:createInstance(cellIndex)
		local additionalTerrainNOList = cellNO.additionalTerrains

		for _, additionalTerrainNO in ipairs(additionalTerrainNOList) do
			cellInfo:setFromAdditionalTerrainNO(additionalTerrainNO)
		end

		table.insert(self._cellInfoList, cellInfo)
	end

	return self
end

return BattleTerrainUpdatedCommand
