-- chunkname: @modules/logic/room/model/map/path/RoomMapVehicleModel.lua

module("modules.logic.room.model.map.path.RoomMapVehicleModel", package.seeall)

local RoomMapVehicleModel = class("RoomMapVehicleModel", BaseModel)

function RoomMapVehicleModel:ctor()
	RoomMapVehicleModel.super:ctor(self)
	self:_clearData()
end

function RoomMapVehicleModel:onInit()
	self:_clearData()
end

function RoomMapVehicleModel:reInit()
	self:_clearData()
end

function RoomMapVehicleModel:clear()
	RoomMapVehicleModel.super.clear(self)
	self:_clearData()
end

function RoomMapVehicleModel:_clearData()
	self._buildingUidToVehicleIdDic = {}
	self._transportSiteTypeToVehicleIdDic = {}
	self._resIndexDic = {}
end

function RoomMapVehicleModel:init()
	self:clear()
end

function RoomMapVehicleModel:initVehicle()
	local resIndexDic = {}
	local vehicleMOList = {}
	local planIdList = {}

	self._resIndexDic = resIndexDic

	self:_initBuildingVehicle(vehicleMOList, resIndexDic, planIdList)
	self:_initTransportSiteVehicle(vehicleMOList, resIndexDic, planIdList)

	local planMOList = RoomMapPathPlanModel.instance:getList()

	for i, planMO in ipairs(planMOList) do
		local resourceId = planMO.resourceId
		local resCfg = RoomConfig.instance:getResourceConfig(resourceId)

		if resCfg then
			if not resCfg.numLimit then
				local numLimit = 0

				if resCfg then
					if not resCfg.vehicleId then
						local vehicleId = 0

						if numLimit > 0 and vehicleId ~= 0 and numLimit <= planMO:getCount() then
							local vehicleCfg = RoomConfig.instance:getVehicleConfig(vehicleId)

							if vehicleCfg then
								local id = self:_createMOId(vehicleId, resIndexDic)
								local vehicleMO = RoomMapVehicleMO.New()

								vehicleMO:init(id, planMO, vehicleId)
								table.insert(vehicleMOList, vehicleMO)
							end
						end
					end
				end
			end
		end
	end

	self:setList(vehicleMOList)
end

function RoomMapVehicleModel:_initBuildingVehicle(vehicleMOList, resIndexDic, planIdList)
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i = 1, #buildingMOList do
		local buildingMO = buildingMOList[i]

		if buildingMO.config then
			if not buildingMO.config.vehicleType then
				local vehicleType = 0

				if buildingMO.config then
					if not buildingMO.config.vehicleId then
						local vehicleId = 0
						local hexPoint = buildingMO.hexPoint

						if vehicleType ~= 0 and vehicleId ~= 0 and hexPoint then
							local vehicleCfg = RoomConfig.instance:getVehicleConfig(vehicleId)

							if vehicleCfg then
								::label_8_0::

								local planMO = RoomMapPathPlanModel.instance:getPlanMOByXY(hexPoint.x, hexPoint.y, vehicleCfg.resId)
								local resCfg = RoomConfig.instance:getResourceConfig(vehicleCfg.resId)

								if resCfg then
									if not resCfg.numLimit then
										local numLimit = 0
										local areaNodeList = {}

										if planMO and numLimit > 0 and numLimit <= planMO:getCount() and self:_checkAreaByBuildingMO(buildingMO, planMO, areaNodeList) then
											local vehicleMO = RoomMapVehicleMO.New()
											local id = self:_createMOId(vehicleId, resIndexDic)

											self:_checkAreaNodeList(areaNodeList)
											vehicleMO:init(id, planMO, vehicleId, areaNodeList)

											vehicleMO.vehicleType = vehicleType
											vehicleMO.ownerType = RoomVehicleEnum.OwnerType.Building
											vehicleMO.ownerId = buildingMO.id

											table.insert(vehicleMOList, vehicleMO)

											self._buildingUidToVehicleIdDic[buildingMO.id] = id

											table.insert(planIdList, planMO.id)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function RoomMapVehicleModel:_checkAreaNodeList(areaNodeList)
	if not areaNodeList or #areaNodeList < 2 then
		return
	end

	local count = #areaNodeList

	if areaNodeList[1]:isEndNode() and not areaNodeList[count]:isEndNode() then
		local n = math.floor(count / 2)

		for i = 1, n do
			local j = count + 1 - i

			areaNodeList[i] = areaNodeList[j]
			areaNodeList[j] = areaNodeList[i]
		end
	end
end

function RoomMapVehicleModel:_checkAreaByBuildingMO(buildingMO, planMO, areaNodeList)
	if not buildingMO or not planMO then
		return false
	end

	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingMO.buildingId)
	local centerPoint = buildingConfigParam.centerPoint
	local pointList = buildingConfigParam.pointList

	for i, point in ipairs(pointList) do
		local worldPoint = RoomBuildingHelper.getWorldHexPoint(point, centerPoint, buildingMO.hexPoint, buildingMO.rotate)
		local node = planMO:getNodeByXY(worldPoint.x, worldPoint.y)

		if not node then
			return false
		end

		if areaNodeList then
			table.insert(areaNodeList, node)
		end
	end

	return true
end

function RoomMapVehicleModel:_createMOId(id, indexDict)
	if not indexDict[id] then
		local index = 1

		indexDict[id] = index + 1

		return id * 1000 + index
	end
end

function RoomMapVehicleModel:getVehicleMOByBuilingUid(buildingUid)
	if self._buildingUidToVehicleIdDic[buildingUid] then
		return self:getById(self._buildingUidToVehicleIdDic[buildingUid])
	end
end

function RoomMapVehicleModel:_initTransportSiteVehicle(vehicleMOList, resIndexDic)
	local siteTypeList = RoomTransportHelper.getSiteBuildingTypeList()

	for i = 1, #siteTypeList do
		local siteType = siteTypeList[i]
		local vehicleMO = self:createVehicleMOBySiteType(siteType)

		if vehicleMO then
			table.insert(vehicleMOList, vehicleMO)
		end
	end
end

function RoomMapVehicleModel:createVehicleMOBySiteType(siteType)
	if not siteType then
		return
	end

	local fromType, toType = RoomTransportHelper.getSiteFromToByType(siteType)
	local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)

	if not pathMO or not pathMO.buildingUid or pathMO.buildingUid == 0 then
		return
	end

	local vehicleCfg = RoomTransportHelper.getVehicleCfgByBuildingId(pathMO.buildingId, pathMO.buildingSkinId)

	if not vehicleCfg then
		return
	end

	if not self._transportSiteTypeToVehicleIdDic[siteType] then
		local id = self:_createMOId(fromType, self._resIndexDic)

		self._transportSiteTypeToVehicleIdDic[siteType] = id

		local planMO = RoomMapPathPlanMO.New()
		local resId = RoomResourceEnum.ResourceId.Empty

		planMO:initHexPintList(id, resId, pathMO:getHexPointList())

		local areaNodeList = {}
		local nodeList = planMO:getNodeList()
		local isRiver = false

		if #nodeList > 0 then
			local node = nodeList[(pathMO.fromType ~= siteType or nil) and #nodeList]

			table.insert(areaNodeList, node)

			local blockMO = RoomMapBlockModel.instance:getBlockMO(node.hexPoint.x, node.hexPoint.y)

			if blockMO and blockMO:hasRiver() then
				isRiver = true
			end
		end

		local vehicleMO = RoomMapVehicleMO.New()

		vehicleMO:init(id, planMO, vehicleCfg.id, areaNodeList)

		vehicleMO.vehicleType = 1
		vehicleMO.ownerType = RoomVehicleEnum.OwnerType.TransportSite
		vehicleMO.ownerId = siteType

		vehicleMO:setReplaceType((isRiver or nil) and (RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land))

		return vehicleMO
	end
end

function RoomMapVehicleModel:getVehicleIdBySiteType(siteType)
	return self._transportSiteTypeToVehicleIdDic[siteType]
end

function RoomMapVehicleModel:getVehicleMOBySiteType(siteType)
	return self:getById(self:getVehicleIdBySiteType(siteType))
end

RoomMapVehicleModel.instance = RoomMapVehicleModel.New()

return RoomMapVehicleModel
