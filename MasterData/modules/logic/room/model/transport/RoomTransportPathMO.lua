-- chunkname: @modules/logic/room/model/transport/RoomTransportPathMO.lua

module("modules.logic.room.model.transport.RoomTransportPathMO", package.seeall)

local RoomTransportPathMO = pureTable("RoomTransportPathMO")

function RoomTransportPathMO:init(info)
	self.hexPointList = {}

	self:setId(info and info.id)
end

function RoomTransportPathMO:setId(pid)
	self.id = pid or 0
end

function RoomTransportPathMO:updateCritterInfo(info)
	self.critterUid = info.critterUid or self.critterUid or 0

	if tonumber(self.critterUid) == 0 then
		self.critterUid = 0
	end
end

function RoomTransportPathMO:updateBuildingInfo(info)
	self.buildingUid = info.buildingUid or self.buildingUid or 0
	self.buildingId = info.buildingId or info.buildingDefineId or self.buildingId or 0
	self.buildingSkinId = info.buildingSkinId or info.skinId or self.buildingSkinId or 0
end

function RoomTransportPathMO:updateInfo(info)
	self.fromType = info.fromType or self.fromType or 0
	self.toType = info.toType or self.toType or 0
	self.blockCleanType = info.blockCleanType or self.blockCleanType or 0

	self:updateCritterInfo(info)
	self:updateBuildingInfo(info)

	local tempHexpoints = info.hexPointList

	if tempHexpoints then
		self.hexPointList = {}

		tabletool.addValues(self.hexPointList, tempHexpoints)
	end
end

function RoomTransportPathMO:setServerRoadInfo(roadInfo)
	local info = RoomTransportHelper.serverRoadInfo2Info(roadInfo)

	self:updateInfo(info)
end

function RoomTransportPathMO:checkSameType(aBuildingType, bBuildingType)
	if self.fromType == aBuildingType and self.toType == bBuildingType or self.fromType == bBuildingType and self.toType == aBuildingType then
		return true
	end

	return false
end

function RoomTransportPathMO:isLinkFinish()
	if not self.fromType or not self.toType or self.fromType == self.toType then
		return false
	end

	if RoomBuildingEnum.BuildingArea[self.fromType] and RoomBuildingEnum.BuildingArea[self.toType] then
		return true
	end

	return false
end

function RoomTransportPathMO:getHexPointList()
	return self.hexPointList
end

function RoomTransportPathMO:getHexPointCount()
	return (self.hexPointList or nil) and (#self.hexPointList or 0)
end

function RoomTransportPathMO:setHexPointList(hexPointList)
	self.hexPointList = {}

	tabletool.addValues(self.hexPointList, hexPointList)
end

function RoomTransportPathMO:getLastHexPoint()
	return self.hexPointList[#self.hexPointList]
end

function RoomTransportPathMO:getFirstHexPoint()
	return self.hexPointList[1]
end

function RoomTransportPathMO:changeBenEnd()
	if self.hexPointList and #self.hexPointList > 1 then
		self.fromType = self.toType
		self.toType = self.fromType

		local count = #self.hexPointList
		local half = math.floor(count * 0.5)

		for i = 1, half do
			local lastIdx = count - i + 1

			self.hexPointList[i] = self.hexPointList[lastIdx]
			self.hexPointList[lastIdx] = self.hexPointList[i]
		end
	end
end

function RoomTransportPathMO:removeLastHexPoint()
	local count = self:getHexPointCount()

	if count > 0 then
		table.remove(self.hexPointList, count)
	end
end

function RoomTransportPathMO:setIsEdit(isEdit)
	self._isEdit = isEdit
end

function RoomTransportPathMO:getIsEdit()
	return self._isEdit
end

function RoomTransportPathMO:setIsQuickLink(isQuickLink)
	self._isQuickLink = isQuickLink
end

function RoomTransportPathMO:getIsQuickLink()
	return self._isQuickLink
end

function RoomTransportPathMO:addHexPoint(hexPoint)
	if self:isCanAddHexPoint(hexPoint) then
		table.insert(self.hexPointList, hexPoint)

		return true
	end

	return false
end

function RoomTransportPathMO:isCanAddHexPoint(hexPoint)
	if not hexPoint or self:checkHexPoint(hexPoint) then
		return false
	end

	local lastHexPoint = self:getLastHexPoint()

	if lastHexPoint == nil or HexPoint.Distance(lastHexPoint, hexPoint) == 1 then
		return true
	end

	return false
end

function RoomTransportPathMO:checkHexPoint(hexPoint)
	if hexPoint then
		return self:checkHexXY(hexPoint.x, hexPoint.y)
	end

	return false
end

function RoomTransportPathMO:checkHexXY(x, y)
	for index, tHexPoint in ipairs(self.hexPointList) do
		if tHexPoint.x == x and tHexPoint.y == y then
			return true, index
		end
	end

	return false
end

function RoomTransportPathMO:checkTempTypes(typeList)
	self.tempFromTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(self:getFirstHexPoint(), typeList)
	self.tempToTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(self:getLastHexPoint(), typeList)
	self.fromType, self.toType = self:_find2ListValue(self.tempFromTypes, self.tempToTypes, 0)
end

function RoomTransportPathMO:_find2ListValue(alist, blist, defaultValue)
	for i = 1, #alist do
		for j = 1, #blist do
			if alist[i] ~= blist[j] then
				return alist[i], blist[j]
			end
		end
	end

	return alist[1] or defaultValue, blist[1] or defaultValue
end

function RoomTransportPathMO:isTransporting()
	local result = false
	local hasCritterWork = self:hasCritterWorking()

	if hasCritterWork then
		local isFromAreaRunning = ManufactureModel.instance:isAreaHasManufactureRunning(self.fromType)
		local isToAreaRunning = ManufactureModel.instance:isAreaHasManufactureRunning(self.toType)

		if isFromAreaRunning or isToAreaRunning then
			result = true
		end
	end

	return result
end

function RoomTransportPathMO:hasCritterWorking()
	local critterMO = CritterModel.instance:getCritterMOByUid(self.critterUid)

	return ((critterMO or nil) and critterMO:getMoodValue()) > 0
end

function RoomTransportPathMO:clear()
	if self.hexPointList and #self.hexPointList > 0 then
		self.hexPointList = {}
		self.fromType = 0
		self.toType = 0
	end
end

return RoomTransportPathMO
