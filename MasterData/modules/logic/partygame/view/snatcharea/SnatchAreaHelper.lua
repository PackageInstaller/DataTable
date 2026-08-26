-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaHelper.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaHelper", package.seeall)

local SnatchAreaHelper = _M
local AreaTypeList = {
	SnatchEnum.AreaType.One,
	SnatchEnum.AreaType.Two,
	SnatchEnum.AreaType.Three,
	SnatchEnum.AreaType.Four
}
local DirList = {}

function SnatchAreaHelper.reInitDirList()
	DirList[1] = SnatchEnum.Dir.Down
	DirList[2] = SnatchEnum.Dir.Up
	DirList[3] = SnatchEnum.Dir.Left
	DirList[4] = SnatchEnum.Dir.Right
end

local ExistPosIndexList = {}

function SnatchAreaHelper.reInitExistPosIndexList(posList)
	tabletool.clear(ExistPosIndexList)

	for index, _ in ipairs(posList) do
		table.insert(ExistPosIndexList, index)
	end
end

function SnatchAreaHelper.initMapData(row, column, x, y, z, w)
	local mapData = {}

	for i = 1, row do
		local rowData = {}

		for j = 1, column do
			table.insert(rowData, SnatchEnum.AreaType.None)
		end

		table.insert(mapData, rowData)
	end

	local typePosDict = {
		[SnatchEnum.AreaType.One] = {},
		[SnatchEnum.AreaType.Two] = {},
		[SnatchEnum.AreaType.Three] = {},
		[SnatchEnum.AreaType.Four] = {}
	}
	local typeCountDict = {
		[SnatchEnum.AreaType.One] = x,
		[SnatchEnum.AreaType.Two] = y,
		[SnatchEnum.AreaType.Three] = z,
		[SnatchEnum.AreaType.Four] = w
	}
	local maxCount = 0

	for _, count in pairs(typeCountDict) do
		if maxCount < count then
			maxCount = count
		end
	end

	return mapData, typePosDict, typeCountDict, maxCount
end

function SnatchAreaHelper.randomMapByStep(row, column, x, y, z, w)
	if x + y + z + w ~= row * column then
		logError(string.format("randomMap fail : x : %s, y : %s, z : %s, w : %s, row : %s, column : %s", x, y, z, w, row, column))

		return false
	end

	local mapData, typePosDict, typeCountDict, maxCount = SnatchAreaHelper.initMapData(row, column, x, y, z, w)

	for _, areaType in ipairs(AreaTypeList) do
		local result = SnatchAreaHelper.generateStartPos(areaType, typePosDict[areaType], row, column, mapData)

		if not result then
			logError("generate start pos fail, areaType : " .. tostring(areaType))

			return false, mapData
		end
	end

	return true, mapData, typePosDict, typeCountDict, maxCount
end

function SnatchAreaHelper.randomMap(row, column, x, y, z, w)
	if x + y + z + w ~= row * column then
		logError(string.format("randomMap fail : x : %s, y : %s, z : %s, w : %s, row : %s, column : %s", x, y, z, w, row, column))

		return false
	end

	local mapData, typePosDict, typeCountDict, maxCount = SnatchAreaHelper.initMapData(row, column, x, y, z, w)

	for _, areaType in ipairs(AreaTypeList) do
		local result = SnatchAreaHelper.generateStartPos(areaType, typePosDict[areaType], row, column, mapData)

		if not result then
			logError("generate start pos fail, areaType : " .. tostring(areaType))

			return false, mapData
		end
	end

	for _ = 1, maxCount - 1 do
		SnatchAreaHelper.randomOneStepMapData(mapData, typePosDict, typeCountDict)
	end

	return true, mapData, typePosDict, typeCountDict
end

function SnatchAreaHelper.generateStartPos(areaType, typePosList, row, column, mapData)
	for i = 1, 10 do
		local pos = SnatchAreaHelper.getRandomPos(row, column)

		if mapData[pos.x][pos.y] == SnatchEnum.AreaType.None then
			SnatchAreaHelper.fillMapData(mapData, pos, areaType)
			table.insert(typePosList, pos)

			return true
		end
	end

	logError("generate 10 time fail ?")

	return false
end

function SnatchAreaHelper.getRandomPos(row, column)
	local x = math.random(1, row)
	local y = math.random(1, column)

	return Vector2(x, y)
end

function SnatchAreaHelper.fillMapData(mapData, pos, areaType)
	mapData[pos.x][pos.y] = areaType
end

function SnatchAreaHelper.setMapData(mapData, pos, areaType, typePosDict, typeCountDict)
	local srcAreaType = mapData[pos.x][pos.y]

	if srcAreaType == areaType then
		return
	end

	local srcPosList = typePosDict[srcAreaType]

	if srcPosList then
		for index, _pos in pairs(srcPosList) do
			if _pos.x == pos.x and _pos.y == pos.y then
				table.remove(srcPosList, index)
			end
		end
	end

	local curPosList = typePosDict[areaType]

	if curPosList then
		table.insert(typePosDict[areaType], pos)
	end

	mapData[pos.x][pos.y] = areaType
end

function SnatchAreaHelper.randomOneStepMapData(mapData, typePosDict, typeCountDict)
	for _, areaType in ipairs(AreaTypeList) do
		SnatchAreaHelper.randomOneStepAreaData(areaType, typePosDict[areaType], typeCountDict[areaType], mapData)
	end
end

function SnatchAreaHelper.randomOneStepAreaData(areaType, posList, count, mapData)
	if count <= #posList then
		return
	end

	SnatchAreaHelper.reInitExistPosIndexList(posList)

	for _ = 1, #posList do
		local randomPosIndex = SnatchAreaHelper.getListRandomValue(ExistPosIndexList)
		local pos = posList[randomPosIndex]

		SnatchAreaHelper.reInitDirList()

		for _ = 1, #DirList do
			local randomDir = SnatchAreaHelper.getListRandomValue(DirList)
			local newPosX, newPosY = pos.x + randomDir.x, pos.y + randomDir.y

			if SnatchAreaHelper.checkMapPosIsValid(newPosX, newPosY, mapData) then
				local newPos = Vector2(newPosX, newPosY)

				table.insert(posList, newPos)
				SnatchAreaHelper.fillMapData(mapData, newPos, areaType)

				return
			end
		end
	end
end

function SnatchAreaHelper.getListRandomValue(dataList)
	if #dataList == 1 then
		return table.remove(dataList)
	end

	local index = math.random(1, #dataList)

	return table.remove(dataList, index)
end

function SnatchAreaHelper.checkMapPosIsValid(x, y, mapData)
	if x < 1 or x > #mapData or y < 1 or y > #mapData[1] then
		return false
	end

	return mapData[x][y] == SnatchEnum.AreaType.None
end

function SnatchAreaHelper.checkAddAreaIsValid(x, y, posList)
	for _, pos in ipairs(posList) do
		if SnatchAreaHelper.isNeighbor(pos.x, pos.y, x, y) then
			return true
		end
	end

	return false
end

function SnatchAreaHelper.isNeighbor(x1, y1, x2, y2)
	if x1 == x2 then
		return math.abs(y1 - y2) == 1
	end

	if y1 == y2 then
		return math.abs(x1 - x2) == 1
	end

	return false
end

function SnatchAreaHelper.logMapData(mapData)
	for _, rowData in ipairs(mapData) do
		logError(table.concat(rowData, " "))
	end
end

function SnatchAreaHelper.encodeMapData(mapData)
	for i, rowData in ipairs(mapData) do
		for j, data in ipairs(rowData) do
			if data == SnatchEnum.AreaType.None then
				logError(string.format("序列化地图数据失败, 行 : %s, 列 : %s, data : %s", i, j, data))
				GameFacade.showToastString("生成失败")

				return
			end
		end
	end

	local strTab = {}

	for _, rowData in ipairs(mapData) do
		table.insert(strTab, table.concat(rowData, ""))
	end

	local str = table.concat(strTab, "\n")

	logNormal(str)
	ZProj.GameHelper.SetSystemBuffer(str)
	GameFacade.showToastString("生成成功")

	return str
end

function SnatchAreaHelper.decodeMapData(str)
	local rowList = string.split(str, "\n")
	local mapData = {}
	local typePosDict = {
		[SnatchEnum.AreaType.One] = {},
		[SnatchEnum.AreaType.Two] = {},
		[SnatchEnum.AreaType.Three] = {},
		[SnatchEnum.AreaType.Four] = {}
	}
	local typeCountDict = {
		[SnatchEnum.AreaType.One] = 0,
		[SnatchEnum.AreaType.Two] = 0,
		[SnatchEnum.AreaType.Three] = 0,
		[SnatchEnum.AreaType.Four] = 0
	}

	for i, rowData in ipairs(rowList) do
		local row = {}

		for j = 1, #rowData do
			local data = tonumber(string.sub(rowData, j, j))

			table.insert(row, data)

			local pos = Vector2(i, j)
			local list = typePosDict[data]

			table.insert(list, pos)

			typeCountDict[data] = typeCountDict[data] + 1
		end

		table.insert(mapData, row)
	end

	return mapData, typePosDict, typeCountDict
end

function SnatchAreaHelper.findTwoMapSameRate(mapData1, mapData2)
	local row1 = #mapData1
	local row2 = #mapData2

	if row1 ~= row2 then
		return false
	end

	local column1 = #mapData1[1]
	local column2 = #mapData2[1]

	if column1 ~= column2 then
		return false
	end

	local sameCount = 0

	for row = 1, row1 do
		for column = 1, column1 do
			if mapData1[row][column] == mapData2[row][column] then
				sameCount = sameCount + 1
			end
		end
	end

	return true, sameCount / (row1 * column1)
end

function SnatchAreaHelper.pixPos2AnchorPos(pixPosX, pixPosY, rectTotalWidth, rectTotalHeight, pixTotalWidth, pixTotalHeight)
	local anchorPosX = rectTotalWidth / pixTotalWidth * pixPosX
	local anchorPosY = rectTotalHeight / pixTotalHeight * pixPosY

	return anchorPosX, anchorPosY
end

return SnatchAreaHelper
