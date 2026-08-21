-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTerrainAddedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTerrainAddedCommand", package.seeall)

local BattleTerrainAddedCommand = class("BattleTerrainAddedCommand", BattleCommandBase)

function BattleTerrainAddedCommand:parseServerCommand(cmdParser, cellNOList)
	if #cellNOList > 0 then
		local cmd = BattleTerrainAddedCommand:createInstance()

		cmd:addFromCellNOList(cellNOList)
		cmdParser:addCommand(cmd)
	end
end

function BattleTerrainAddedCommand:onInit()
	self._timelineTask = TimelineTask.New()
	self._cellInfoList = {}
	self._newGroupIds = {}
end

function BattleTerrainAddedCommand:onClear()
	self._timelineTask:clear()
	BattleTableUtil.clearTable(self._newGroupIds)
	BattleTableUtil.clearReusableTable(self._cellInfoList)
end

function BattleTerrainAddedCommand:execute(battleFlow, runningContext)
	self:_playBornTerrain()
	self._timelineTask:clear()
	self._timelineTask:addTask(1)
	self._timelineTask:addFinishListener(self._onFinishTask, self)
	self._timelineTask:start()
end

function BattleTerrainAddedCommand:_playBornTerrain()
	local additionalTerrainMgr = BattleMgr.instance:getAdditionalTerrainMgr()

	additionalTerrainMgr:createTerrainUnits(self._cellInfoList, self._newGroupIds)

	for _, groupId in ipairs(self._newGroupIds) do
		local groupUnit = additionalTerrainMgr:getGroupUnit(groupId)

		groupUnit.terrainModel:playBornAnimation()
	end
end

function BattleTerrainAddedCommand:_onFinishTask()
	self:finish(true)
end

function BattleTerrainAddedCommand:toString()
	return string.format("[terrain added command, cellInfoList = %s]", BattleTableUtil.arrayToString(self._cellInfoList))
end

function BattleTerrainAddedCommand:addFromCellNOList(cellNOList)
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

return BattleTerrainAddedCommand
