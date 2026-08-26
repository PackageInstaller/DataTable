-- chunkname: @modules/logic/room/model/map/RoomMapTransportPathModel.lua

module("modules.logic.room.model.map.RoomMapTransportPathModel", package.seeall)

local RoomMapTransportPathModel = class("RoomMapTransportPathModel", BaseModel)

function RoomMapTransportPathModel:onInit()
	self:_clearData()
end

function RoomMapTransportPathModel:reInit()
	self:_clearData()
end

function RoomMapTransportPathModel:clear()
	RoomMapTransportPathModel.super.clear(self)
	self:_clearData()
end

function RoomMapTransportPathModel:_clearData()
	self._siteHexPointDict = {}
	self._buildingTypesDict = {}
	self._opParams = {}
end

function RoomMapTransportPathModel:removeByIds(ids)
	if ids and #ids > 0 then
		for _, id in ipairs(ids) do
			local mo = self:getById(id)

			self:remove(mo)
		end
	end
end

function RoomMapTransportPathModel:updateInofoById(id, info)
	local parthMO = self:getById(id)

	if parthMO and info then
		parthMO:updateInfo(info)
	end
end

function RoomMapTransportPathModel:getTransportPathMOByCritterUid(critterUid)
	local moList = self:getList()

	for i = 1, #moList do
		local pathMO = moList[i]

		if pathMO and pathMO.critterUid == critterUid then
			return pathMO
		end
	end
end

function RoomMapTransportPathModel:getTransportPathMOByBuildingUid(buildingUid)
	local moList = self:getList()

	for i = 1, #moList do
		local pathMO = moList[i]

		if pathMO and pathMO.buildingUid == buildingUid then
			return pathMO
		end
	end
end

function RoomMapTransportPathModel:getTransportPathMO(id)
	return self:getById(id)
end

function RoomMapTransportPathModel:getTransportPathMOList()
	return self:getList()
end

function RoomMapTransportPathModel:initPath(roadInfos)
	RoomTransportHelper.initTransportPathModel(self, roadInfos)

	self._buildingTypesDict = {}
end

function RoomMapTransportPathModel:resetByTransportPathMOList(pathMOList)
	local moList = {}

	if pathMOList then
		for index = 1, #pathMOList do
			local tMO = pathMOList[index]
			local pathMO = self:getByIndex(tMO.id)

			if not pathMO then
				pathMO = RoomTransportPathMO.New()

				pathMO:setId(-index)
			end

			pathMO:setIsEdit(false)
			pathMO:setIsQuickLink(nil)
			pathMO:updateInfo(tMO)
			table.insert(moList, pathMO)
		end
	end

	self:setList(moList)
end

function RoomMapTransportPathModel:updateSiteHexPoint()
	self._siteHexPointDict = {}

	local moList = self:getList()
	local linkFinishMOList = {}

	for i = 1, #moList do
		local aPathMO = moList[i]

		if aPathMO and aPathMO:isLinkFinish() then
			table.insert(linkFinishMOList, aPathMO)
		end
	end

	for i = 1, #linkFinishMOList do
		local aPathMO = linkFinishMOList[i]

		for j = i + 1, #linkFinishMOList do
			local siteType, hexPoint = RoomTransportHelper.getSiltParamBy2PathMO(aPathMO, linkFinishMOList[j])

			if siteType ~= nil and hexPoint ~= nil then
				self._siteHexPointDict[siteType] = hexPoint
			end
		end
	end

	for i = 1, #linkFinishMOList do
		local aPathMO = linkFinishMOList[i]

		aPathMO:checkTempTypes({
			aPathMO.fromType,
			aPathMO.toType
		})
	end

	local buildingTypesList = RoomTransportHelper.getPathBuildingTypesList()

	for i = 1, #buildingTypesList do
		local buildingTypes = buildingTypesList[i]
		local fromType = buildingTypes[1]
		local toType = buildingTypes[2]
		local transMO = self:getTransportPathMOBy2Type(fromType, toType)

		if transMO and transMO:isLinkFinish() then
			self._siteHexPointDict[transMO.fromType] = self._siteHexPointDict[transMO.fromType] or transMO:getFirstHexPoint()
			self._siteHexPointDict[transMO.toType] = self._siteHexPointDict[transMO.toType] or transMO:getLastHexPoint()
		end
	end
end

function RoomMapTransportPathModel:getSiteHexPointByType(buildingType)
	return self._siteHexPointDict and self._siteHexPointDict[buildingType]
end

function RoomMapTransportPathModel:getSiteTypeByHexPoint(hexPoint)
	if self._siteHexPointDict and hexPoint then
		for siteType, siteHexPoint in pairs(self._siteHexPointDict) do
			if hexPoint == siteHexPoint then
				return siteType
			end
		end
	end

	return 0
end

function RoomMapTransportPathModel:setSiteHexPointByType(buildingType, hexPoint)
	self._siteHexPointDict = self._siteHexPointDict or {}
	self._siteHexPointDict[buildingType] = hexPoint
end

function RoomMapTransportPathModel:isHasEdit()
	local moList = self:getList()

	for _, pathMO in ipairs(moList) do
		if pathMO:getIsEdit() then
			return true
		end
	end

	return false
end

function RoomMapTransportPathModel:setSelectBuildingType(buildingType)
	self._selectBuildingType = buildingType
end

function RoomMapTransportPathModel:getSelectBuildingType()
	return self._selectBuildingType
end

function RoomMapTransportPathModel:setOpParam(isDragPath, siteType)
	self._opParams = self._opParams or {}
	self._opParams.isDragPath = isDragPath == true
	self._opParams.siteType = siteType
end

function RoomMapTransportPathModel:getOpParam()
	return self._opParams
end

function RoomMapTransportPathModel:setIsRemoveBuilding(isRemoveBuilding)
	self._isRemoveBuilding = isRemoveBuilding
end

function RoomMapTransportPathModel:getIsRemoveBuilding()
	return self._isRemoveBuilding
end

function RoomMapTransportPathModel:placeTempTransportPathMO()
	self._tempTransportPathMO = nil
end

function RoomMapTransportPathModel:getTempTransportPathMO()
	return self._tempTransportPathMO
end

function RoomMapTransportPathModel:addTempTransportPathMO(hexPoint, fromType, toType)
	local transportPathMO = self:getTransportPathMOBy2Type(fromType, toType)

	transportPathMO = transportPathMO or self:_findTransportPathMOByHexPoint(hexPoint, false)

	if not transportPathMO then
		local typesList

		transportPathMO = self:_createTempTransportPathMOByHexPoint(hexPoint, (fromType and toType or nil) and {
			fromType,
			toType
		})
	end

	self._tempTransportPathMO = transportPathMO

	return transportPathMO
end

function RoomMapTransportPathModel:getTransportPathMOByHexPoint(hexPoint, isLinkFinsh)
	return self:_findTransportPathMOByHexPoint(hexPoint, isLinkFinsh)
end

function RoomMapTransportPathModel:getTransportPathMOListByHexPoint(hexPoint, isLinkFinish)
	local tempList
	local moList = self:getList()

	for i = 1, #moList do
		local transportPathMO = moList[i]

		if (isLinkFinish == nil or isLinkFinish == transportPathMO:isLinkFinish()) and transportPathMO:checkHexPoint(hexPoint) then
			tempList = tempList or {}

			table.insert(tempList, transportPathMO)
		end
	end

	return tempList
end

function RoomMapTransportPathModel:getLinkFinishCount()
	return self:_countTransportPathMO(nil, true)
end

function RoomMapTransportPathModel:getLinkFailCount()
	local linkCount = self:getLinkFinishCount()
	local maxCount = self:getMaxCount()

	return maxCount - linkCount
end

function RoomMapTransportPathModel:getTransportPathMOBy2Type(fromType, toType)
	local moList = self:getList()

	for i = 1, #moList do
		local transportPathMO = moList[i]

		if transportPathMO:checkSameType(fromType, toType) then
			return transportPathMO
		end
	end
end

function RoomMapTransportPathModel:_countTransportPathMO(hexPoint, isLinkFinsh)
	local moList = self:getList()
	local count = 0

	for i = 1, #moList do
		local transportPathMO = moList[i]

		if (hexPoint == nil or transportPathMO:checkHexPoint(hexPoint)) and (isLinkFinsh == nil or isLinkFinsh == transportPathMO:isLinkFinish()) then
			count = count + 1
		end
	end

	return count
end

function RoomMapTransportPathModel:_findTransportPathMOByHexPoint(hexPoint, isLinkFinsh)
	local moList = self:getList()

	for i = 1, #moList do
		local transportPathMO = moList[i]

		if transportPathMO:checkHexPoint(hexPoint) and (isLinkFinsh == nil or isLinkFinsh == transportPathMO:isLinkFinish()) then
			return transportPathMO
		end
	end
end

function RoomMapTransportPathModel:_createTempTransportPathMOByHexPoint(hexPoint, typesList)
	local fromTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(hexPoint, typesList)

	if not fromTypes or #fromTypes < 1 then
		return nil
	end

	local transportPathMO
	local moList = self:getList()

	for i = 1, #moList do
		if moList[i]:getHexPointCount() < 1 then
			transportPathMO = moList[i]

			moList[i]:addHexPoint(hexPoint)

			break
		end
	end

	if not transportPathMO and self:getMaxCount() > self:getCount() then
		transportPathMO = RoomTransportPathMO.New()

		transportPathMO:init()

		local id = 0

		while self:getById(id) ~= nil do
			id = id - 1
		end

		transportPathMO:setId(id)
		transportPathMO:addHexPoint(hexPoint)
		self:addAtLast(transportPathMO)
	end

	return transportPathMO
end

function RoomMapTransportPathModel:getMaxCount()
	local count = RoomMapBuildingAreaModel.instance:getCount() - 1

	count = (count + 1) * count * 0.5

	return count
end

RoomMapTransportPathModel.instance = RoomMapTransportPathModel.New()

return RoomMapTransportPathModel
