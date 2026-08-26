-- chunkname: @modules/logic/versionactivity1_3/armpipe/model/ArmPuzzlePipeModel.lua

module("modules.logic.versionactivity1_3.armpipe.model.ArmPuzzlePipeModel", package.seeall)

local ArmPuzzlePipeModel = class("ArmPuzzlePipeModel", BaseModel)

ArmPuzzlePipeModel.constWidth = 7
ArmPuzzlePipeModel.constHeight = 5
ArmPuzzlePipeModel.constEntry = 0

function ArmPuzzlePipeModel:reInit()
	self:release()
end

function ArmPuzzlePipeModel:release()
	self._cfgElement = nil
	self._startX = nil
	self._startY = nil
	self._gridDatas = nil
	self._isGameClear = false
	self._entryList = nil
	self._isHasPlaceOP = false
end

function ArmPuzzlePipeModel:initByEpisodeCo(elementCo)
	self._cfgElement = elementCo

	if self._cfgElement then
		self._isHasPlaceOP = false

		local cfgMap = Activity124Config.instance:getMapCo(elementCo.activityId, elementCo.mapId)

		self:initData()
		self:initPuzzle(cfgMap.tilebase)
		self:initPuzzlePlace(cfgMap.objects)
	end
end

function ArmPuzzlePipeModel:initData()
	self._gridDatas = {}

	local w, h = self:getGameSize()
	local mo

	for x = 1, w do
		for y = 1, h do
			self._gridDatas[x] = self._gridDatas[x] or {}
			mo = ArmPuzzlePipeMO.New()

			mo:init(x, y)

			self._gridDatas[x][y] = mo
		end
	end

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function ArmPuzzlePipeModel:initPuzzle(str)
	self._entryList = {}
	self._pathIndexList = {}
	self._pathIndexDict = {}
	self._pathNumListDict = {}
	self._placeDataDict = {}

	local intArr = string.split(str, ",")
	local w, h = self:getGameSize()

	if #intArr >= w * h then
		local index = 1

		for x = 1, w do
			for y = 1, h do
				local value = intArr[index]
				local mo = self._gridDatas[x][y]

				mo:setParamStr(value)

				if mo:isEntry() then
					table.insert(self._entryList, mo)
					self:_initPathByMO(mo)
				end

				if mo.typeId == ArmPuzzlePipeEnum.type.zhanwei then
					self._placeDataDict[mo] = value
					self._isHasPlaceOP = true
				end

				index = index + 1
			end
		end
	end

	for _, numIndexList in pairs(self._pathNumListDict) do
		if numIndexList and #numIndexList > 1 then
			table.sort(numIndexList, ArmPuzzlePipeModel._numIndexSort)
		end
	end
end

function ArmPuzzlePipeModel:initPuzzlePlace(str)
	self._placeTypeDataDict = {
		[ArmPuzzlePipeEnum.type.straight] = 0,
		[ArmPuzzlePipeEnum.type.corner] = 0,
		[ArmPuzzlePipeEnum.type.t_shape] = 0
	}

	local num2s = GameUtil.splitString2(str, true, ",", "#")

	if num2s then
		for _, nums in ipairs(num2s) do
			if #nums >= 2 and self._placeTypeDataDict[nums[1]] then
				self._isHasPlaceOP = true
				self._placeTypeDataDict[nums[1]] = nums[2]
			end
		end
	end
end

function ArmPuzzlePipeModel._numIndexSort(a, b)
	if a ~= b then
		return a < b
	end
end

function ArmPuzzlePipeModel:_initPathByMO(mo)
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

function ArmPuzzlePipeModel:resetEntryConnect()
	local w, h = self:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = self._gridDatas[x][y]

			mo:cleanEntrySet()
		end
	end
end

function ArmPuzzlePipeModel:setGameClear(value)
	self._isGameClear = value
end

function ArmPuzzlePipeModel:isHasPlace()
	return self._isHasPlaceOP
end

function ArmPuzzlePipeModel:isHasPlaceByTypeId(motypeId)
	if self._placeTypeDataDict and self._placeTypeDataDict[motypeId] > 0 then
		return true
	end

	return false
end

function ArmPuzzlePipeModel:getPlaceNum(motypeId)
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

function ArmPuzzlePipeModel:getData(x, y)
	return self._gridDatas[x][y]
end

function ArmPuzzlePipeModel:isPlaceByXY(x, y)
	if self:getPlaceStrByXY(x, y) then
		return true
	end

	return false
end

function ArmPuzzlePipeModel:getPlaceStrByXY(x, y)
	if self._placeDataDict then
		local mo = self:getData(x, y)

		if mo then
			return self._placeDataDict[mo]
		end
	end
end

function ArmPuzzlePipeModel:setPlaceSelectXY(x, y)
	self._placeSelectX = x
	self._placeSelectY = y
end

function ArmPuzzlePipeModel:getPlaceSelectXY()
	return self._placeSelectX, self._placeSelectY
end

function ArmPuzzlePipeModel:isPlaceSelectXY(x, y)
	if x == nil or y == nil then
		return false
	end

	return self._placeSelectX == x and self._placeSelectY == y
end

function ArmPuzzlePipeModel:setGameSize(w, h)
	self._gameWidth = w
	self._gameHeight = h
end

function ArmPuzzlePipeModel:getGameSize()
	return self._gameWidth or ArmPuzzlePipeModel.constWidth, self._gameHeight or ArmPuzzlePipeModel.constHeight
end

function ArmPuzzlePipeModel:getGameClear()
	return self._isGameClear
end

function ArmPuzzlePipeModel:getEntryList()
	return self._entryList
end

function ArmPuzzlePipeModel:getEpisodeCo()
	return self._cfgElement
end

function ArmPuzzlePipeModel:getPathIndexList()
	return self._pathIndexList
end

function ArmPuzzlePipeModel:getIndexByMO(mo)
	if mo.pathType == ArmPuzzlePipeEnum.PathType.Order and self._pathNumListDict[mo.pathIndex] then
		local index = tabletool.indexOf(self._pathNumListDict[mo.pathIndex], mo.numIndex)

		return index or -1
	end

	return 0
end

function ArmPuzzlePipeModel:isHasPathIndex(pathIndex)
	return (self._pathIndexDict or nil) and (self._pathIndexDict[pathIndex] or false)
end

function ArmPuzzlePipeModel:getRelativePosition(x, y, w, h)
	return (self._startX + x) * w, (self._startY + y) * h
end

function ArmPuzzlePipeModel:getIndexByTouchPos(x, y, w, h)
	local x = math.floor((x - (self._startX + 0.5) * w) / w)
	local y = math.floor((y - (self._startY + 0.5) * h) / h)
	local totalW, totalH = self:getGameSize()

	if x >= 0 and x < totalW and y >= 0 and y < totalH then
		return x + 1, y + 1
	end

	return -1, -1
end

ArmPuzzlePipeModel.instance = ArmPuzzlePipeModel.New()

return ArmPuzzlePipeModel
