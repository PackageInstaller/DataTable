-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/boardmodel/CheckerBoardCellMO.lua

module("logic.battle.battleflow.component.boardmodel.CheckerBoardCellMO", package.seeall)

local CheckerBoardCellMO = class("CheckerBoardCellMO", AbstractGlobalReusable)

function CheckerBoardCellMO:getCapacity()
	return BattleConst.ObjPoolCapacityMaxx
end

function CheckerBoardCellMO:ctor(cellCO)
	self._cellCO = false
	self._ownerEntityId = false
	self._stateMOList = {}
	self._additionalTerrainMO = false

	self:reuse(cellCO)
end

function CheckerBoardCellMO:reuse(cellCO)
	self._cellCO = cellCO
end

function CheckerBoardCellMO:reset()
	self._cellCO = false
	self._ownerEntityId = false

	self:removeAdditionalTerrainMO()
	BattleTableUtil.clearReusableTable(self._stateMOList)
end

function CheckerBoardCellMO:destroy()
	self:reset()
end

function CheckerBoardCellMO:internal_ClearData()
	self._ownerEntityId = false

	self:removeAdditionalTerrainMO()
	BattleTableUtil.clearReusableTable(self._stateMOList)
end

function CheckerBoardCellMO:isEnable()
	return self._cellCO.isEnable
end

function CheckerBoardCellMO:getCellType()
	return self._cellCO.cellType
end

function CheckerBoardCellMO:getCoordinates()
	local coordinates = self._cellCO.coordinates

	return coordinates[1], coordinates[2]
end

function CheckerBoardCellMO:getOwnerEntityId()
	return self._ownerEntityId
end

function CheckerBoardCellMO:hasOwner()
	return self._ownerEntityId
end

function CheckerBoardCellMO:setOwnerEntityId(entityId)
	if self:hasOwner() then
		local x, z = self:getCoordinates()

		if BattleLog.enableError then
			BattleLog.error(string.format("BattleBoardModel::Cell[%s,%s] already has owner[%s],replaced by owner[%s]", x, z, self:getOwnerEntityId(), entityId))
		end
	end

	self._ownerEntityId = entityId
end

function CheckerBoardCellMO:resetOwnerEntityId()
	self._ownerEntityId = false
end

function CheckerBoardCellMO:isEqualOwnerEntityId(entityId)
	return self._ownerEntityId and self._ownerEntityId == entityId
end

function CheckerBoardCellMO:getStateMOList()
	return self._stateMOList
end

function CheckerBoardCellMO:addStateMO(stateMO)
	table.insert(self._stateMOList, stateMO)
end

function CheckerBoardCellMO:removeStateMO(stateMO)
	local removedStateMO = BattleTableUtil.removebyvalue(self._stateMOList, stateMO)

	if removedStateMO then
		removedStateMO:returnSelf()
	end
end

function CheckerBoardCellMO:setAdditionalTerrainMO(additionalTerrainMO)
	self:removeAdditionalTerrainMO()

	self._additionalTerrainMO = additionalTerrainMO
end

function CheckerBoardCellMO:removeAdditionalTerrainMO()
	if self._additionalTerrainMO then
		self._additionalTerrainMO:returnSelf()

		self._additionalTerrainMO = false
	end
end

function CheckerBoardCellMO:getAdditionalTerrainMO()
	return self._additionalTerrainMO
end

function CheckerBoardCellMO:hasAdditionalTerrain()
	return self._additionalTerrainMO and true or false
end

return CheckerBoardCellMO
