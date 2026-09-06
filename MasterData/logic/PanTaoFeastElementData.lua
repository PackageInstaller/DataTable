-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/model/PanTaoFeastElementData.lua

module("logic.extensions.pantaofeast.model.PanTaoFeastElementData", package.seeall)

local PanTaoFeastElementData = class("PanTaoFeastElementData")

function PanTaoFeastElementData:ctor()
	self:reset()
end

function PanTaoFeastElementData:reset()
	self._elementId = 0
	self._elementType = PanTaoFeastEnum.ElementClientType.None
	self._elementCfg = nil
	self._islock = false
	self._gridId = 0
	self._lastGridId = 0
	self._curRow = 0
	self._curCol = 0
end

function PanTaoFeastElementData:updatePosition(row, col)
	self._curRow = row
	self._curCol = col
	self._gridId = PanTaoFeastGameController.instance:rowColToGridId(row, col)
end

function PanTaoFeastElementData:updateGridId(gridId)
	self._gridId = gridId

	local row, col = PanTaoFeastGameController.instance:gridIdToRowCol(gridId)

	self._curRow = row
	self._curCol = col
end

function PanTaoFeastElementData:getGridId()
	return self._gridId
end

function PanTaoFeastElementData:getLastGridId()
	return self._lastGridId
end

function PanTaoFeastElementData:getRowId()
	return self._curRow
end

function PanTaoFeastElementData:getColId()
	return self._curCol
end

function PanTaoFeastElementData:updateElementId(elementId)
	self._elementId = elementId

	if elementId > 0 then
		local curActivityId = PanTaoFeastGameController.instance:getCurActivityId()

		self._elementCfg = PanTaoFeastConfig.instance:getElementCfgByElementId(curActivityId, elementId)
		self._elementType = PanTaoFeastGameController.instance:getElementClientTypeById(elementId)
	else
		self._elementCfg = nil
		self._elementType = PanTaoFeastEnum.ElementClientType.None
		self._elementCfg = nil
	end
end

function PanTaoFeastElementData:initByServerData(serverData)
	self:reset()

	if serverData then
		self:updateElementId(serverData.elementId)

		self._islock = checknumber(serverData.state) == 1

		self:updateGridId(serverData.gridId)

		self._lastGridId = serverData.gridId
	end
end

function PanTaoFeastElementData:isLock()
	return self._islock
end

function PanTaoFeastElementData:isDeletable()
	if self._islock then
		return false
	end

	if self:isEmpty() then
		return false
	end

	return self._elementType == PanTaoFeastEnum.ElementClientType.RawMat or self._elementType == PanTaoFeastEnum.ElementClientType.Dish or self._elementType == PanTaoFeastEnum.ElementClientType.GreatDish
end

function PanTaoFeastElementData:getElementId()
	return self._elementId
end

function PanTaoFeastElementData:getElementType()
	return self._elementType
end

function PanTaoFeastElementData:isEmpty()
	return self._elementId == 0
end

function PanTaoFeastElementData:getElementName()
	if self._elementCfg then
		return self._elementCfg.name or ""
	end

	return ""
end

return PanTaoFeastElementData
