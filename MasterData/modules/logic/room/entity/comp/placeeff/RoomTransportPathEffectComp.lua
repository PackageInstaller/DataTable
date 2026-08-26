-- chunkname: @modules/logic/room/entity/comp/placeeff/RoomTransportPathEffectComp.lua

module("modules.logic.room.entity.comp.placeeff.RoomTransportPathEffectComp", package.seeall)

local RoomTransportPathEffectComp = class("RoomTransportPathEffectComp", RoomBaseBlockEffectComp)

function RoomTransportPathEffectComp:ctor(entity)
	RoomTransportPathEffectComp.super.ctor(self, entity)

	self.entity = entity
	self._effectPrefixKey = "transport_path"
	self._blockParamPools = {}
	self.delayTaskTime = 0.05
	self._effectId = {
		SiteCollect = 4,
		SiteProcess = 5,
		BlockManufacture = 3,
		BlockCollect = 1,
		BlockNotCan = 8,
		BlockProcess = 2,
		SiteManufacture = 6
	}
	self._effectResMap = {
		[self._effectId.BlockCollect] = RoomScenePreloader.ResEffectBlue01,
		[self._effectId.BlockProcess] = RoomScenePreloader.ResEffectYellow01,
		[self._effectId.BlockManufacture] = RoomScenePreloader.ResEffectGreen01,
		[self._effectId.SiteCollect] = RoomScenePreloader.ResEffectBlue02,
		[self._effectId.SiteProcess] = RoomScenePreloader.ResEffectYellow02,
		[self._effectId.SiteManufacture] = RoomScenePreloader.ResEffectGreen02,
		[self._effectId.BlockNotCan] = RoomScenePreloader.ResEffectRed01
	}
	self._stieType2IdMap = {
		[RoomBuildingEnum.BuildingType.Collect] = self._effectId.SiteCollect,
		[RoomBuildingEnum.BuildingType.Process] = self._effectId.SiteProcess,
		[RoomBuildingEnum.BuildingType.Manufacture] = self._effectId.SiteManufacture
	}
	self._buildingType2IdMap = {
		[RoomBuildingEnum.BuildingType.Collect] = self._effectId.BlockCollect,
		[RoomBuildingEnum.BuildingType.Process] = self._effectId.BlockProcess,
		[RoomBuildingEnum.BuildingType.Manufacture] = self._effectId.BlockManufacture
	}
end

function RoomTransportPathEffectComp:init(go)
	RoomTransportPathEffectComp.super.init(self, go)

	self._tRoomResourceModel = RoomResourceModel.instance
end

function RoomTransportPathEffectComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathConfirmChange, self._refreshConfirmEffect, self)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, self.startWaitRunDelayTask, self)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, self.startWaitRunDelayTask, self)
end

function RoomTransportPathEffectComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathConfirmChange, self._refreshConfirmEffect, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, self.startWaitRunDelayTask, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, self.startWaitRunDelayTask, self)
end

function RoomTransportPathEffectComp:onRunDelayTask()
	self:_refreshConfirmEffect()
end

function RoomTransportPathEffectComp:_refreshConfirmEffect()
	local indexDict = self:_getBlackIndexDict()
	local addParams, removeParams
	local effectComp = self.entity.effect
	local lastIndexDict = self._lastIndexDict

	self._lastIndexDict = indexDict
	self._tRoomResourceModel = RoomResourceModel.instance

	if indexDict then
		for index, param in pairs(indexDict) do
			local oldParam = lastIndexDict and lastIndexDict[index]

			if param and not self:_checkParamsSame(param, oldParam) then
				local effectKey = self:getEffectKeyById(index)

				if addParams == nil then
					addParams = {}
				end

				local posX, posY = HexMath.hexXYToPosXY(param.hexPoint.x, param.hexPoint.y, RoomBlockEnum.BlockSize)

				addParams[effectKey] = {
					res = self._effectResMap[param.effectId],
					localPos = Vector3(posX, 0, posY)
				}
			end
		end
	end

	if lastIndexDict then
		for index, oldParam in pairs(lastIndexDict) do
			if not indexDict or not indexDict[index] then
				local effectKey = self:getEffectKeyById(index)

				if effectComp:isHasKey(effectKey) then
					if removeParams == nil then
						removeParams = {}
					end

					table.insert(removeParams, effectKey)
				end
			end

			self:_pushParam(oldParam)
		end
	end

	if addParams then
		effectComp:addParams(addParams)
		effectComp:refreshEffect()
	end

	if removeParams then
		self:removeParamsAndPlayAnimator(removeParams, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function RoomTransportPathEffectComp:_getBlackIndexDict()
	if not RoomTransportController.instance:isTransportPathShow() then
		return nil
	end

	local tRoomMapTransportPathModel = RoomMapTransportPathModel.instance
	local buildingTypeList = RoomTransportHelper.getPathBuildingTypes(tRoomMapTransportPathModel:getSelectBuildingType())

	if not buildingTypeList or #buildingTypeList < 1 then
		return nil
	end

	local blockDict = {}
	local tRoomMapBuildingAreaModel = RoomMapBuildingAreaModel.instance
	local tRoomMapHexPointModel = RoomMapHexPointModel.instance

	for i = 1, #buildingTypeList do
		local buildingType = buildingTypeList[i]
		local hexPoint = tRoomMapTransportPathModel:getSiteHexPointByType(buildingType)

		if hexPoint then
			self:_addParamDict(blockDict, hexPoint, self._buildingType2IdMap[buildingType], true)
		end
	end

	for i = 1, #buildingTypeList do
		local buildingType = buildingTypeList[i]
		local areaMO = tRoomMapBuildingAreaModel:getAreaMOByBType(buildingType)

		if areaMO and areaMO.mainBuildingMO then
			local hexPoint = areaMO.mainBuildingMO.hexPoint
			local pointList = RoomMapModel.instance:getBuildingPointList(areaMO.mainBuildingMO.buildingId, areaMO.mainBuildingMO.rotate)

			for _, point in ipairs(pointList) do
				local hexPoint = tRoomMapHexPointModel:getHexPoint(point.x + hexPoint.x, point.y + hexPoint.y)

				self:_addParamDict(blockDict, hexPoint, self._buildingType2IdMap[buildingType], true)
			end
		end
	end

	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local blockMOList = tRoomMapBlockModel:getFullBlockMOList()
	local isRemoveBuilding = RoomMapTransportPathModel.instance:getIsRemoveBuilding()

	for i, blockMO in ipairs(blockMOList) do
		if not RoomTransportHelper.canPathByBlockMO(blockMO, isRemoveBuilding) then
			local hexPoint = blockMO.hexPoint

			self:_addParamDict(blockDict, hexPoint, self._effectId.BlockNotCan, true)
		end
	end

	local pathMO = tRoomMapTransportPathModel.instance:getTempTransportPathMO() or tRoomMapTransportPathModel:getTransportPathMOBy2Type(buildingTypeList[1], buildingTypeList[2])

	for i = 1, #buildingTypeList do
		local buildingType = buildingTypeList[i]
		local areaMO = tRoomMapBuildingAreaModel:getAreaMOByBType(buildingType)
		local hexPointList = areaMO and areaMO:getRangesHexPointList()

		if hexPointList then
			for _, hexPoint in ipairs(hexPointList) do
				local blockMO = tRoomMapBlockModel:getBlockMO(hexPoint.x, hexPoint.y)

				if blockMO and blockMO:isInMapBlock() then
					self:_addParamDict(blockDict, hexPoint, ((pathMO and pathMO:isLinkFinish() or nil) and self._buildingType2IdMap)[buildingType], false)
				end
			end
		end
	end

	return blockDict
end

function RoomTransportPathEffectComp:_checkParamsSame(param, param2)
	if param == nil or param2 == nil then
		return false
	end

	if param.effectId ~= param2.effectId or param.hexPoint ~= param2.hexPoint then
		return false
	end

	return true
end

function RoomTransportPathEffectComp:_addParamDict(dict, hexPoint, effectId, isOnly)
	local index = self._tRoomResourceModel:getIndexByXY(hexPoint.x, hexPoint.y)

	index = index * 10

	local param = dict[index]

	if param and (param.isOnly or isOnly or param.effectId == effectId) then
		return
	end

	if param then
		while dict[index] do
			index = index + 1
		end
	end

	local param = self:_popParam()

	param.effectId = effectId
	param.isOnly = isOnly
	param.index = index
	param.hexPoint = hexPoint
	dict[index] = param
end

function RoomTransportPathEffectComp:_popParam()
	local param
	local count = #self._blockParamPools

	if count > 0 then
		param = self._blockParamPools[count]

		table.remove(self._blockParamPools, count)
	else
		param = {}
	end

	return param
end

function RoomTransportPathEffectComp:_pushParam(param)
	if param then
		table.insert(self._blockParamPools, param)
	end
end

return RoomTransportPathEffectComp
