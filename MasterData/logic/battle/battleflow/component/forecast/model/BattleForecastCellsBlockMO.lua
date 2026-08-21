-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/model/BattleForecastCellsBlockMO.lua

module("logic.battle.battleflow.component.forecast.model.BattleForecastCellsBlockMO", package.seeall)

local BattleForecastCellsBlockMO = class("BattleForecastCellsBlockMO", AbstractGlobalReusable)

function BattleForecastCellsBlockMO:parseFromCellsBlockedEventNO(cellsBlockedEventNO)
	local cellsBlockMO = BattleForecastCellsBlockMO:createInstance()

	cellsBlockMO:initFromCellsBlockedEventNO(cellsBlockedEventNO)

	return cellsBlockMO
end

function BattleForecastCellsBlockMO:initFromCellsBlockedEventNO(cellsBlockedEventNO)
	self.entityId = cellsBlockedEventNO.entity
	self.skillCode = cellsBlockedEventNO.skill

	local cells = cellsBlockedEventNO.cells

	for _, cellNO in ipairs(cells) do
		table.insert(self.unionIndexList, BoardIndexConverter.cellNOToUnionIndex(cellNO))
	end
end

function BattleForecastCellsBlockMO:ctor()
	self.entityId = false
	self.skillCode = false
	self.unionIndexList = {}
end

function BattleForecastCellsBlockMO:reset()
	self.entityId = false
	self.skillCode = false

	BattleTableUtil.clearTable(self.unionIndexList)
end

function BattleForecastCellsBlockMO:destroy()
	self.entityId = nil
	self.skillCode = nil
	self.unionIndexList = nil
end

function BattleForecastCellsBlockMO:addToCellMO()
	local boardModel = BattleMgr.instance:getBoardModel()
	local unionIndexList = self.unionIndexList

	for _, unionIndex in ipairs(unionIndexList) do
		local cellMO = boardModel:getBoardCellMO(unionIndex)
		local cellStateMO = CheckerBoardCellStateMO:createInstance()

		cellStateMO:setEntityId(self.entityId)
		cellStateMO:setSkillCode(self.skillCode)
		cellStateMO:setState(BattleEnum.CellState.BLOCKED)
		cellMO:addStateMO(cellStateMO)
	end
end

function BattleForecastCellsBlockMO:removeFromCellMO()
	local boardModel = BattleMgr.instance:getBoardModel()
	local unionIndexList = self.unionIndexList
	local cellStateMO = CheckerBoardCellStateMO:createInstance()

	for _, unionIndex in ipairs(unionIndexList) do
		local cellMO = boardModel:getBoardCellMO(unionIndex)

		cellStateMO:setEntityId(self.entityId)
		cellStateMO:setSkillCode(self.skillCode)
		cellStateMO:setState(BattleEnum.CellState.BLOCKED)
		cellMO:removeStateMO(cellStateMO)
	end

	cellStateMO:returnSelf()
end

return BattleForecastCellsBlockMO
