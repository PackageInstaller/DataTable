-- chunkname: @modules/logic/room/model/map/RoomInventoryBuildingModel.lua

module("modules.logic.room.model.map.RoomInventoryBuildingModel", package.seeall)

local RoomInventoryBuildingModel = class("RoomInventoryBuildingModel", BaseModel)

function RoomInventoryBuildingModel:onInit()
	self:_clearData()
end

function RoomInventoryBuildingModel:reInit()
	self:_clearData()
end

function RoomInventoryBuildingModel:clear()
	RoomInventoryBuildingModel.super.clear(self)
	self:_clearData()
end

function RoomInventoryBuildingModel:_clearData()
	self._hasBuildingDict = {}
end

function RoomInventoryBuildingModel:initInventory(infos)
	self:clear()
	self:addBuilding(infos)

	local cfgList = lua_manufacture_building.configList
	local buildingCfgList = RoomConfig.instance:getBuildingConfigList()
	local info = {
		use = false
	}

	for i = 1, #cfgList do
		local manuCfg = cfgList[i]
		local buildingId = manuCfg.id
		local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

		if buildingCfg and not self._hasBuildingDict[buildingId] then
			self._hasBuildingDict[buildingId] = true
			info.uid = -buildingId
			info.buildingId = buildingId
			info.buildingState = RoomBuildingEnum.BuildingState.Inventory

			local buildingMO = RoomBuildingMO.New()

			buildingMO:init(info)
			self:_addBuildingMO(buildingMO)
		end
	end
end

function RoomInventoryBuildingModel:checkBuildingPut(buildingId)
	buildingId = tonumber(buildingId)

	local list = self:getBuildingMOList()

	for i, v in ipairs(list) do
		if v.buildingId == buildingId then
			local param = RoomBuildingHelper.getRecommendHexPoint(v.buildingId)

			return param and param.hexPoint ~= nil
		end
	end

	return false
end

function RoomInventoryBuildingModel:addBuilding(infos)
	if not infos or #infos <= 0 then
		return
	end

	self._hasBuildingDict = self._hasBuildingDict or {}

	for i, info in ipairs(infos) do
		self._hasBuildingDict[info.defineId] = true

		if not info.use then
			local buildingInfo = RoomInfoHelper.serverInfoToBuildingInfo(info)
			local buildingMO = RoomBuildingMO.New()

			buildingMO:init(buildingInfo)

			if buildingMO.config then
				self:_addBuildingMO(buildingMO)
			end
		end

		self:_removeBuildingMOByUId(-info.defineId)
	end
end

function RoomInventoryBuildingModel:_addBuildingMO(mo)
	local oldMO = self:getById(mo.id)

	if oldMO then
		self:remove(oldMO)
	end

	self:addAtLast(mo)
end

function RoomInventoryBuildingModel:_removeBuildingMO(mo)
	self:remove(mo)
end

function RoomInventoryBuildingModel:_removeBuildingMOByUId(uid)
	local mo = self:getById(uid)

	if mo then
		self:remove(mo)
	end
end

function RoomInventoryBuildingModel:placeBuilding(info)
	self:_removeBuildingMOByUId(info.uid)
end

function RoomInventoryBuildingModel:unUseBuilding(info)
	local buildMO = self:getById(info.uid)

	if buildMO then
		buildMO.use = false

		return
	end

	if info.use then
		return
	end

	local buildingInfo = RoomInfoHelper.serverInfoToBuildingInfo(info)
	local buildingMO = RoomBuildingMO.New()

	buildingMO:init(buildingInfo)
	self:_addBuildingMO(buildingMO)
end

function RoomInventoryBuildingModel:getBuildingMOList()
	return self:getList()
end

function RoomInventoryBuildingModel:getBuildingMOById(uid)
	return self:getById(uid)
end

function RoomInventoryBuildingModel:getCount()
	return self:getCount()
end

RoomInventoryBuildingModel.instance = RoomInventoryBuildingModel.New()

return RoomInventoryBuildingModel
