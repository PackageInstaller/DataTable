-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/model/NaxisuosiPipeModel.lua

module("modules.logic.versionactivity3_9.naxisuosi.model.NaxisuosiPipeModel", package.seeall)

local NaxisuosiPipeModel = class("NaxisuosiPipeModel", BaseModel)

NaxisuosiPipeModel.constWidth = 7
NaxisuosiPipeModel.constHeight = 5

function NaxisuosiPipeModel:reInit()
	self:release()
end

function NaxisuosiPipeModel:release()
	self._cfgElement = nil
	self._startX = nil
	self._startY = nil
	self._gridDatas = nil
	self._isGameClear = false
	self._entryList = nil
	self._mapType = nil
	self._gameId = nil
	self._startTime = nil
end

function NaxisuosiPipeModel:getGameId()
	return self._gameId
end

function NaxisuosiPipeModel:getStartTime()
	return self._startTime
end

function NaxisuosiPipeModel:initByEpisodeCo(episodeCo)
	self._cfgElement = episodeCo

	if self._cfgElement then
		local mapCo = NaxisuosiConfig.instance:getMapCo(episodeCo.activityId, episodeCo.episodeId)

		if mapCo then
			self:setGameSize(mapCo.width, mapCo.height)

			self._mapType = mapCo.type or NaxisuosiPipeEnum.MapType.Orange
		end

		self:initData()

		self._gameId = mapCo.id

		if mapCo then
			if not mapCo.tilebase then
				local tilebase = ""

				self:initPuzzle(tilebase)

				self._startTime = ServerTime.now()
			end
		end
	end
end

function NaxisuosiPipeModel:initData()
	self._gridDatas = {}

	local w, h = self:getGameSize()
	local mo

	for x = 1, w do
		self._gridDatas[x] = self._gridDatas[x] or {}

		for y = 1, h do
			mo = NaxisuosiPipeMO.New()

			mo:init(x, y)

			self._gridDatas[x][y] = mo
		end
	end

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function NaxisuosiPipeModel:initPuzzle(str)
	self._entryList = {}
	self._pathIndexList = {}
	self._pathIndexDict = {}
	self._pathNumListDict = {}

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

				index = index + 1
			end
		end
	end

	for _, numIndexList in pairs(self._pathNumListDict) do
		if numIndexList and #numIndexList > 1 then
			table.sort(numIndexList, NaxisuosiPipeModel._numIndexSort)
		end
	end
end

function NaxisuosiPipeModel._numIndexSort(a, b)
	if a ~= b then
		return a < b
	end
end

function NaxisuosiPipeModel:_initPathByMO(mo)
	if mo:isEntry() then
		if not self._pathIndexDict[mo.pathIndex] then
			self._pathIndexDict[mo.pathIndex] = true

			table.insert(self._pathIndexList, mo.pathIndex)
		end

		if mo.pathType == NaxisuosiPipeEnum.PathType.Order then
			local pathIndex = mo.pathIndex
			local numIndex = mo.numIndex

			self._pathNumListDict[pathIndex] = self._pathNumListDict[pathIndex] or {}

			if tabletool.indexOf(self._pathNumListDict[pathIndex], numIndex) == nil then
				table.insert(self._pathNumListDict[pathIndex], numIndex)
			end
		end
	end
end

function NaxisuosiPipeModel:resetEntryConnect()
	local w, h = self:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = self._gridDatas[x][y]

			mo:cleanEntrySet()
		end
	end
end

function NaxisuosiPipeModel:setGameClear(value)
	self._isGameClear = value
end

function NaxisuosiPipeModel:getData(x, y)
	return self._gridDatas[x][y]
end

function NaxisuosiPipeModel:setGameSize(w, h)
	self._gameWidth = w
	self._gameHeight = h
end

function NaxisuosiPipeModel:getGameSize()
	return self._gameWidth or NaxisuosiPipeModel.constWidth, self._gameHeight or NaxisuosiPipeModel.constHeight
end

function NaxisuosiPipeModel:getGameClear()
	return self._isGameClear
end

function NaxisuosiPipeModel:getEntryList()
	return self._entryList
end

function NaxisuosiPipeModel:getEpisodeCo()
	return self._cfgElement
end

function NaxisuosiPipeModel:getPathIndexList()
	return self._pathIndexList
end

function NaxisuosiPipeModel:getIndexByMO(mo)
	if mo.pathType == NaxisuosiPipeEnum.PathType.Order and self._pathNumListDict[mo.pathIndex] then
		local index = tabletool.indexOf(self._pathNumListDict[mo.pathIndex], mo.numIndex)

		return index or -1
	end

	return 0
end

function NaxisuosiPipeModel:isHasPathIndex(pathIndex)
	return (self._pathIndexDict or nil) and (self._pathIndexDict[pathIndex] or false)
end

function NaxisuosiPipeModel:getConnectAllEntryCount()
	local count = 0

	if self._entryList then
		for _, mo in ipairs(self._entryList) do
			if mo.typeId == NaxisuosiPipeEnum.type.first or mo.typeId == NaxisuosiPipeEnum.type.last or mo.typeId == NaxisuosiPipeEnum.type.connect then
				count = count + 1
			end
		end
	end

	return count
end

function NaxisuosiPipeModel:getMapType()
	return self._mapType or NaxisuosiPipeEnum.MapType.Orange
end

function NaxisuosiPipeModel:getRelativePosition(x, y)
	local anchorX = self._offsetX + (x - 0.5) * self._itemW
	local anchorY = self._offsetY + (y - 0.5) * self._itemH

	return anchorX, anchorY
end

function NaxisuosiPipeModel:setMapSize(mapW, mapH, itemW, itemH)
	self._mapW = mapW
	self._mapH = mapH
	self._itemW = itemW
	self._itemH = itemH
	self._offsetX = -mapW * 0.5
	self._offsetY = -mapH * 0.5
end

function NaxisuosiPipeModel:getIndexByTouchPos(x, y)
	local gridX = math.floor((x - self._offsetX) / self._itemW) + 1
	local gridY = math.floor((y - self._offsetY) / self._itemH) + 1
	local totalW, totalH = self:getGameSize()

	if gridX >= 1 and gridX <= totalW and gridY >= 1 and gridY <= totalH then
		return gridX, gridY
	end

	return -1, -1
end

NaxisuosiPipeModel.instance = NaxisuosiPipeModel.New()

return NaxisuosiPipeModel
