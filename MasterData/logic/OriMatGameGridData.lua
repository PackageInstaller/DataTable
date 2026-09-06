-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameGridData.lua

module("logic.extensions.orimatgame.model.OriMatGameGridData", package.seeall)

local OriMatGameGridData = class("OriMatGameGridData")

function OriMatGameGridData:ctor()
	self:reset()
end

function OriMatGameGridData:getUnit()
	return self._unit
end

function OriMatGameGridData:getCellCfg()
	return self._cellCfg
end

function OriMatGameGridData:getCellTypeCfg()
	return self._cellTypeCfg
end

function OriMatGameGridData:getGridState()
	return self._gridState
end

function OriMatGameGridData:setCellCfg(cellCfg)
	self._cellCfg = cellCfg

	if cellCfg then
		self._cellTypeCfg = OriMatGameConfig.instance:getMapCellCfg(cellCfg.typeId)
	end

	self:_updateState()
end

function OriMatGameGridData:setUnit(unit)
	if self._gridState ~= OriMatGameEnum.GridState.Empty then
		return
	end

	self._unit = unit

	self:_updateState()
end

function OriMatGameGridData:clearUnit()
	self._unit = nil

	self:_updateState()
end

function OriMatGameGridData:reset()
	self._unit = nil
	self._cellCfg = nil
	self._cellTypeCfg = nil
	self._gridState = OriMatGameEnum.GridState.Empty
	self.row = 0
	self.col = 0
end

function OriMatGameGridData:setRowCol(row, col)
	self.row = row
	self.col = col
end

function OriMatGameGridData:getRowCol()
	return self.row, self.col
end

function OriMatGameGridData:_updateState()
	self._gridState = self._unit and OriMatGameEnum.GridState.ExistUnit or self._cellTypeCfg and (self._cellTypeCfg.type == OriMatGameEnum.MapCellType.RoadFirst and OriMatGameEnum.GridState.RoadFirst or self._cellTypeCfg.type == OriMatGameEnum.MapCellType.RoadMiddle and OriMatGameEnum.GridState.RoadMiddle or self._cellTypeCfg.type == OriMatGameEnum.MapCellType.RoadEnd and OriMatGameEnum.GridState.RoadEnd or self._cellTypeCfg.type == OriMatGameEnum.MapCellType.Wall and OriMatGameEnum.GridState.Wall or OriMatGameEnum.GridState.Empty) or OriMatGameEnum.GridState.Empty
end

function OriMatGameGridData:isObstaclePos()
	if self._cellTypeCfg then
		return self._cellTypeCfg.type == OriMatGameEnum.MapCellType.Obstacle
	end

	return false
end

function OriMatGameGridData:isWalkable()
	if self._cellTypeCfg then
		return self._cellTypeCfg.type == OriMatGameEnum.MapCellType.RoadFirst or self._cellTypeCfg.type == OriMatGameEnum.MapCellType.RoadMiddle or self._cellTypeCfg.type == OriMatGameEnum.MapCellType.RoadEnd
	end

	return false
end

function OriMatGameGridData:getAddParam()
	if self._cellCfg then
		return self._cellCfg.addParam
	end

	return nil
end

return OriMatGameGridData
