-- chunkname: @modules/logic/versionactivity1_8/dungeon/model/Activity157RepairGameModel.lua

module("modules.logic.versionactivity1_8.dungeon.model.Activity157RepairGameModel", package.seeall)

local Activity157RepairGameModel = class("Activity157RepairGameModel", BaseModel)

local function numIndexSort(a, b)
	return a < b
end

function Activity157RepairGameModel:onInit()
	self._startX = nil
	self._startY = nil
	self._mapPipeGridDict = nil
end

function Activity157RepairGameModel:reInit()
	self:onInit()
end

function Activity157RepairGameModel:setGameDataBeforeEnter(componentId)
	local actId = Activity157Model.instance:getActId()

	self:setCurComponentId(componentId)
	self:initMapGrid()

	local tileBase = Activity157Config.instance:getAct157RepairMapTilebase(actId, componentId)

	self:initPuzzle(tileBase)

	local objects = Activity157Config.instance:getAct157RepairMapObjects(actId, componentId)

	self:initPuzzlePlace(objects)
end

function Activity157RepairGameModel:setCurComponentId(componentId)
	self._curComponentId = componentId
end

function Activity157RepairGameModel:resetGameData()
	local curComponentId = self:getCurComponentId()

	self:setGameDataBeforeEnter(curComponentId)
end

function Activity157RepairGameModel:setGameClear(value)
	self._isGameClear = value
end

function Activity157RepairGameModel:initMapGrid()
	self._mapPipeGridDict = {}

	local w, h = self:getGameSize()
	local girdMo

	for x = 1, w do
		for y = 1, h do
			self._mapPipeGridDict[x] = self._mapPipeGridDict[x] or {}
			girdMo = Activity157PipeGridMo.New()

			girdMo:init(x, y)

			self._mapPipeGridDict[x][y] = girdMo
		end
	end

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function Activity157RepairGameModel:initPuzzle(strTile)
	self._entryList = {}
	self._pathIndexList = {}
	self._pathIndexDict = {}
	self._pathNumListDict = {}
	self._placeDataDict = {}

	local intArr = string.split(strTile, ",")
	local w, h = self:getGameSize()

	if #intArr >= w * h then
		local index = 1

		for x = 1, w do
			for y = 1, h do
				local value = intArr[index]
				local gridMo = self._mapPipeGridDict[x][y]

				gridMo:setParamStr(value)

				if gridMo:isEntry() then
					table.insert(self._entryList, gridMo)
					self:_initPathByMO(gridMo)
				end

				if gridMo.typeId == ArmPuzzlePipeEnum.type.zhanwei then
					self._placeDataDict[gridMo] = value
					self._isHasPlaceOP = true
				end

				index = index + 1
			end
		end
	end

	for _, numIndexList in pairs(self._pathNumListDict) do
		if numIndexList and #numIndexList > 1 then
			table.sort(numIndexList, numIndexSort)
		end
	end
end

function Activity157RepairGameModel:_initPathByMO(mo)
	if mo:isEntry() then
		if not self._pathIndexDict[mo.pathIndex] then
			self._pathIndexDict[mo.pathIndex] = true

			table.insert(self._pathIndexList, mo.pathIndex)
		end

		if mo.pathType == ArmPuzzlePipeEnum.PathType.Order then
			local pathIndex = mo.pathIndex
			local numIndex = mo.numIndex

			self._pathNumListDict[pathIndex] = self._pathNumListDict[pathIndex] or {}

			if tabletool.indexOf(self._pathNumListDict[pathIndex], numIndex) == nil then
				table.insert(self._pathNumListDict[pathIndex], numIndex)
			end
		end
	end
end

function Activity157RepairGameModel:initPuzzlePlace(strObjects)
	self._placeTypeDataDict = {
		[ArmPuzzlePipeEnum.type.straight] = 0,
		[ArmPuzzlePipeEnum.type.corner] = 0,
		[ArmPuzzlePipeEnum.type.t_shape] = 0
	}

	local num2s = GameUtil.splitString2(strObjects, true, ",", "#")

	if num2s then
		for _, nums in ipairs(num2s) do
			if #nums >= 2 and self._placeTypeDataDict[nums[1]] then
				self._isHasPlaceOP = true
				self._placeTypeDataDict[nums[1]] = nums[2]
			end
		end
	end
end

function Activity157RepairGameModel:resetEntryConnect()
	local w, h = self:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = self._mapPipeGridDict[x][y]

			mo:cleanEntrySet()
		end
	end
end

function Activity157RepairGameModel:getGameSize()
	local width, high = 0, 0
	local actId = Activity157Model.instance:getActId()
	local strSize = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.FactoryRepairGameMapSize)

	if not string.nilorempty(strSize) then
		local params = string.split(strSize, "#")

		width = tonumber(params[1]) or 0
		high = tonumber(params[2]) or 0
	end

	return width, high
end

function Activity157RepairGameModel:getIndexByTouchPos(argsX, argsY, argsW, argsH)
	local x = math.floor((argsX - (self._startX + 0.5) * argsW) / argsW)
	local y = math.floor((argsY - (self._startY + 0.5) * argsH) / argsH)
	local totalW, totalH = self:getGameSize()

	if x >= 0 and x < totalW and y >= 0 and y < totalH then
		return x + 1, y + 1
	end

	return -1, -1
end

function Activity157RepairGameModel:getRelativePosition(x, y, w, h)
	return (self._startX + x) * w, (self._startY + y) * h
end

function Activity157RepairGameModel:getEntryList()
	return self._entryList
end

function Activity157RepairGameModel:getData(x, y)
	return self._mapPipeGridDict[x][y]
end

function Activity157RepairGameModel:getIndexByMO(mo)
	if mo.pathType == ArmPuzzlePipeEnum.PathType.Order and self._pathNumListDict[mo.pathIndex] then
		local index = tabletool.indexOf(self._pathNumListDict[mo.pathIndex], mo.numIndex)

		return index or -1
	end

	return 0
end

function Activity157RepairGameModel:getGameClear()
	return self._isGameClear
end

function Activity157RepairGameModel:getCurComponentId()
	return self._curComponentId
end

function Activity157RepairGameModel:isHasPlace()
	return self._isHasPlaceOP
end

function Activity157RepairGameModel:isHasPlaceByTypeId(motypeId)
	if self._placeTypeDataDict and self._placeTypeDataDict[motypeId] > 0 then
		return true
	end

	return false
end

function Activity157RepairGameModel:isPlaceByXY(x, y)
	if self:getPlaceStrByXY(x, y) then
		return true
	end

	return false
end

function Activity157RepairGameModel:getPlaceStrByXY(x, y)
	if self._placeDataDict then
		local mo = self:getData(x, y)

		if mo then
			return self._placeDataDict[mo]
		end
	end
end

function Activity157RepairGameModel:setPlaceSelectXY(x, y)
	self._placeSelectX = x
	self._placeSelectY = y
end

function Activity157RepairGameModel:getPlaceSelectXY()
	return self._placeSelectX, self._placeSelectY
end

function Activity157RepairGameModel:isPlaceSelectXY(x, y)
	if x == nil or y == nil then
		return false
	end

	return self._placeSelectX == x and self._placeSelectY == y
end

function Activity157RepairGameModel:getPlaceNum(motypeId)
	local placeNum = 0

	if self._placeTypeDataDict and self._placeTypeDataDict[motypeId] then
		placeNum = self._placeTypeDataDict[motypeId]

		for mo, _ in pairs(self._placeDataDict) do
			if mo.typeId == motypeId then
				placeNum = placeNum - 1
			end
		end
	end

	return math.max(0, placeNum)
end

Activity157RepairGameModel.instance = Activity157RepairGameModel.New()

return Activity157RepairGameModel
