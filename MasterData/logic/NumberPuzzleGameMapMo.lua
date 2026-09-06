-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NumberPuzzleGameMapMo.lua

module("logic.extensions.numberpuzzlegame.view.data.NumberPuzzleGameMapMo", package.seeall)

local NumberPuzzleGameMapMo = class("NumberPuzzleGameMapMo")

function NumberPuzzleGameMapMo:ctor()
	self._rowCount, self._colCount = 0, 0
	self._gridCount = 0
end

function NumberPuzzleGameMapMo:onReset(rowCount, colCount)
	self._rowCount, self._colCount = rowCount, colCount
	self._gridCount = self._rowCount * self._colCount
	self._gridMap = {}

	for x = 1, self._colCount do
		self._gridMap[x] = {}

		for y = 1, self._rowCount do
			self._gridMap[x][y] = NPGEnum.ResultCode_EmptyGridId
		end
	end
end

function NumberPuzzleGameMapMo:clone()
	return TableUtil.deepcopy(self)
end

function NumberPuzzleGameMapMo:getGridId(x, y)
	return (self._gridMap[x] and self._gridMap[x][y] or nil) and self._gridMap[x][y]
end

function NumberPuzzleGameMapMo:setGridId(x, y, gridId)
	self._gridMap[x][y] = gridId
end

function NumberPuzzleGameMapMo:getGridCoord(gridIndex)
	local x = checkint((gridIndex - 1) % self._colCount + 1)
	local y = checkint((gridIndex - x) / self._colCount + 1)

	return x, y
end

function NumberPuzzleGameMapMo:getGridIndex(x, y)
	return (y - 1) * self._colCount + x
end

function NumberPuzzleGameMapMo:getGridCount()
	return self._gridCount
end

function NumberPuzzleGameMapMo:getRowCount()
	return self._rowCount
end

function NumberPuzzleGameMapMo:getColCount()
	return self._colCount
end

function NumberPuzzleGameMapMo:getEntityGridCount()
	local result = 0

	for x = 1, self._colCount do
		for y = 1, self._rowCount do
			if self._gridMap[x][y] ~= NPGEnum.ResultCode_EmptyGridId then
				result = result + 1
			end
		end
	end

	return result
end

function NumberPuzzleGameMapMo:getEmptyGridCount()
	local gridCount = self:getGridCount()
	local entityGridCount = self:getEntityGridCount()

	return gridCount - entityGridCount
end

function NumberPuzzleGameMapMo:getMaxGridId()
	local result = 0

	for x = 1, self._colCount do
		for y = 1, self._rowCount do
			result = Mathf.Max(result, self._gridMap[x][y])
		end
	end

	return result
end

return NumberPuzzleGameMapMo
