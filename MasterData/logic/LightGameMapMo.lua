-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/LightGameMapMo.lua

module("logic.extensions.duolalight.view.LightGameMapMo", package.seeall)

local LightGameMapMo = class("LightGameMapMo")

LightGameMapMo.GridType = {
	Black = 1,
	White = 0,
	Empty = -1
}
LightGameMapMo.Toward = {
	Up = Vector2.New(0, 1),
	Down = Vector2.New(0, -1),
	Left = Vector2.New(-1, 0),
	Right = Vector2.New(1, 0)
}
LightGameMapMo.TowardList = {
	LightGameMapMo.Toward.Up,
	LightGameMapMo.Toward.Down,
	LightGameMapMo.Toward.Left,
	LightGameMapMo.Toward.Right
}

function LightGameMapMo:ctor()
	return
end

function LightGameMapMo:onEnter()
	return
end

function LightGameMapMo:onReset(mapId)
	self._mapId = mapId

	self:onResetMap()
end

function LightGameMapMo:onExit()
	self._mapId = 0
end

function LightGameMapMo:onDestroy()
	return
end

function LightGameMapMo:getMapId()
	return self._mapId
end

function LightGameMapMo:getGridType(x, y)
	if self._gridMapOfRun[x] and self._gridMapOfRun[x][y] then
		return self._gridMapOfRun[x][y]
	end

	return LightGameMapMo.GridType.Empty
end

function LightGameMapMo:setGridType(x, y, gridType)
	self._gridMapOfRun[x][y] = gridType
end

function LightGameMapMo:getGridCount()
	return self._rowCount * self._colCount
end

function LightGameMapMo:getRowCount()
	return self._rowCount
end

function LightGameMapMo:getColCount()
	return self._colCount
end

function LightGameMapMo:onResetMap()
	local mapId = self:getMapId()
	local mapData = DuoLaLightConfig.instance:getDlMapData(mapId)
	local gridMap = {}
	local colCount = 0
	local rowArr = string.split(mapData.buildStr, "#")

	for x, col in ipairs(rowArr) do
		gridMap[x] = {}

		local colArr = string.split(col, ",")

		colCount = Mathf.Max(colCount, #colArr)

		for y, gridType in ipairs(colArr) do
			gridType = checknumber(gridType)
			gridMap[x][y] = gridType
		end
	end

	self._rowCount, self._colCount = #rowArr, colCount
	self._gridMapOfRun = gridMap
end

function LightGameMapMo:getCurMapBuildStr()
	local resultStr = ""
	local tempStr = ""

	for x = 1, self:getRowCount() do
		tempStr = ""

		for y = 1, self:getColCount() do
			tempStr = y == 1 and string.format("%s", self:getGridType(x, y)) or string.format("%s,%s", tempStr, self:getGridType(x, y))
		end

		resultStr = x == 1 and string.format("%s", tempStr) or string.format("%s#%s", resultStr, tempStr)
	end

	return resultStr
end

function LightGameMapMo:getGridVecListByPoint(x, y)
	local gridList = {}

	if self:isCanMove(x, y) then
		table.insert(gridList, Vector2.New(x, y))

		local vecTemp = Vector2.New(0, 0)

		for _, toVec in ipairs(LightGameMapMo.TowardList) do
			vecTemp:Set(x, y)

			while true do
				vecTemp:Add(toVec)

				if self:isCanMove(vecTemp.x, vecTemp.y) then
					table.insert(gridList, vecTemp:Clone())
				else
					break
				end
			end
		end
	end

	return gridList
end

function LightGameMapMo:isCanMove(x, y)
	if self:getGridType(x, y) == LightGameMapMo.GridType.Empty or x < 1 or x > self:getRowCount() or y < 1 or y > self:getColCount() then
		return false
	end

	return true
end

function LightGameMapMo:checkIsPass()
	local tempType

	for x = 1, self:getRowCount() do
		for y = 1, self:getColCount() do
			tempType = self:getGridType(x, y)

			if tempType ~= LightGameMapMo.GridType.Empty and tempType ~= LightGameMapMo.GridType.White then
				return false
			end
		end
	end

	return true
end

return LightGameMapMo
