-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotGridData.lua

module("logic.extensions.defendcarrot.model.DefendCarrotGridData", package.seeall)

local DefendCarrotGridData = class("DefendCarrotGridData")

function DefendCarrotGridData:ctor()
	self:reset()
end

function DefendCarrotGridData:getUnit()
	return self._unit
end

function DefendCarrotGridData:getCellCfg()
	return self._cellCfg
end

function DefendCarrotGridData:getCellTypeCfg()
	return self._cellTypeCfg
end

function DefendCarrotGridData:getGridState()
	return self._gridState
end

function DefendCarrotGridData:setCellCfg(cellCfg)
	self._cellCfg = cellCfg

	if cellCfg then
		self._cellTypeCfg = DefendCarrotConfig.instance:getMapCellCfg(cellCfg.typeId)
	end

	self:_updateState()
end

function DefendCarrotGridData:setUnit(unit)
	if self._gridState ~= DefendCarrotEnum.GridState.Empty then
		return
	end

	self._unit = unit

	self:_updateState()
end

function DefendCarrotGridData:clearUnit()
	self._unit = nil

	self:_updateState()
end

function DefendCarrotGridData:reset()
	self._unit = nil
	self._cellCfg = nil
	self._cellTypeCfg = nil
	self._gridState = DefendCarrotEnum.GridState.Empty
	self.row = 0
	self.col = 0
end

function DefendCarrotGridData:setRowCol(row, col)
	self.row = row
	self.col = col
end

function DefendCarrotGridData:getRowCol()
	return self.row, self.col
end

function DefendCarrotGridData:_updateState()
	self._gridState = self._unit and DefendCarrotEnum.GridState.ExistUnit or self._cellTypeCfg and (self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.RoadFirst and DefendCarrotEnum.GridState.RoadFirst or self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.RoadMiddle and DefendCarrotEnum.GridState.RoadMiddle or self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.RoadEnd and DefendCarrotEnum.GridState.RoadEnd or self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.Wall and DefendCarrotEnum.GridState.Wall or DefendCarrotEnum.GridState.Empty) or DefendCarrotEnum.GridState.Empty
end

function DefendCarrotGridData:isObstaclePos()
	if self._cellTypeCfg then
		return self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.Obstacle
	end

	return false
end

function DefendCarrotGridData:isWalkable()
	if self._cellTypeCfg then
		return self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.RoadFirst or self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.RoadMiddle or self._cellTypeCfg.type == DefendCarrotEnum.MapCellType.RoadEnd
	end

	return false
end

function DefendCarrotGridData:getAddParam()
	if self._cellCfg then
		return self._cellCfg.addParam
	end

	return nil
end

return DefendCarrotGridData
