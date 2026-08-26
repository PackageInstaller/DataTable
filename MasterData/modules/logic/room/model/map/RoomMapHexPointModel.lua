-- chunkname: @modules/logic/room/model/map/RoomMapHexPointModel.lua

module("modules.logic.room.model.map.RoomMapHexPointModel", package.seeall)

local RoomMapHexPointModel = class("RoomMapHexPointModel", BaseModel)

function RoomMapHexPointModel:ctor()
	RoomMapHexPointModel.super.ctor(self)

	self._rangeHexPointsDict = {}
	self._zeroList = {}
	self._hexPointDict = {}
	self._hexPointList = {}
	self._indexDict = {}
	self._rangesHexPointsDic = {}
	self._outIndex2HexDict = {}
end

function RoomMapHexPointModel:onInit()
	self:_clearData()
end

function RoomMapHexPointModel:reInit()
	self:_clearData()
end

function RoomMapHexPointModel:clear()
	RoomMapHexPointModel.super.clear(self)
	self:_clearData()
end

function RoomMapHexPointModel:_clearData()
	return
end

function RoomMapHexPointModel:init()
	local mapMaxRadius = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) or 10
	local zeroPoint = HexPoint(0, 0)

	self._zeroList = {
		zeroPoint
	}
	self._hexPointList = {
		zeroPoint
	}

	local rangesDict = self._rangesHexPointsDic

	for range = 1, mapMaxRadius do
		local hexPointList = rangesDict[range]

		if not hexPointList then
			hexPointList = zeroPoint:getOnRanges(range)
			rangesDict[range] = hexPointList
		end

		tabletool.addValues(self._hexPointList, hexPointList)
	end

	self._hexPointDict = {}
	self._indexDict = {}

	for idx, hexPoint in ipairs(self._hexPointList) do
		self:_add2KeyValue(self._hexPointDict, hexPoint.x, hexPoint.y, hexPoint)
		self:_add2KeyValue(self._indexDict, hexPoint.x, hexPoint.y, idx)
	end
end

function RoomMapHexPointModel:getIndex(hexX, hexY)
	local index = self:_get2KeyValue(self._indexDict, hexX, hexY)

	if not index then
		index = HexMath.hexXYToSpiralIndex(hexX, hexY)

		self:_add2KeyValue(self._indexDict, hexX, hexY, index)
	end

	return index
end

function RoomMapHexPointModel:getHexPoint(hexX, hexY)
	local hexPoint = self:_get2KeyValue(self._hexPointDict, hexX, hexY)

	if not hexPoint then
		hexPoint = HexPoint(hexX, hexY)

		self:_add2KeyValue(self._hexPointDict, hexX, hexY, hexPoint)
	end

	return hexPoint
end

function RoomMapHexPointModel:getHexPointByIndex(index)
	return self._hexPointList[index]
end

function RoomMapHexPointModel:getHexPointList()
	return self._hexPointList
end

function RoomMapHexPointModel:getOnRangeHexPointList(range)
	if range < 1 then
		return self._zeroList
	end

	return self._rangesHexPointsDic[range]
end

function RoomMapHexPointModel:_add2KeyValue(dict, x, y, value)
	dict[x] = dict[x] or {}
	dict[x][y] = value
end

function RoomMapHexPointModel:_get2KeyValue(dict, x, y)
	local xDic = dict[x]

	return xDic and xDic[y]
end

RoomMapHexPointModel.instance = RoomMapHexPointModel.New()

return RoomMapHexPointModel
