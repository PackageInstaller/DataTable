-- chunkname: @modules/logic/room/entity/comp/placeeff/RoomPlaceBuildingEffectComp.lua

module("modules.logic.room.entity.comp.placeeff.RoomPlaceBuildingEffectComp", package.seeall)

local RoomPlaceBuildingEffectComp = class("RoomPlaceBuildingEffectComp", RoomBaseBlockEffectComp)

function RoomPlaceBuildingEffectComp:ctor(entity)
	RoomPlaceBuildingEffectComp.super.ctor(self, entity)

	self.entity = entity
	self._effectPrefixKey = RoomEnum.EffectKey.BuilidCanPlaceKey
end

function RoomPlaceBuildingEffectComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.BuildingCanConfirm, self._refreshBuildingConfirmEffect, self)
end

function RoomPlaceBuildingEffectComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.BuildingCanConfirm, self._refreshBuildingConfirmEffect, self)
end

function RoomPlaceBuildingEffectComp:_refreshBuildingConfirmEffect()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()
	local curBuilingUId
	local canPlaceEffect = false

	if tempBuildingMO and RoomBuildingController.instance:isBuildingListShow() then
		canPlaceEffect = true
		curBuilingUId = tempBuildingMO.uid
	end

	if self._lastBuildingUid == curBuilingUId then
		return
	end

	self._lastBuildingUid = curBuilingUId

	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local tRoomResourceModel = RoomResourceModel.instance
	local addParams, removeParams
	local blockMOList = tRoomMapBlockModel:getFullBlockMOList()
	local isCheckBuildingArea = false
	local rangesHexPointList

	if tempBuildingMO and tempBuildingMO:isBuildingArea() and not tempBuildingMO:isAreaMainBuilding() then
		isCheckBuildingArea = true
		rangesHexPointList = self:_getRangesHexPointList(tempBuildingMO)
	end

	local effectComp = self.entity.effect

	for i, blockMO in ipairs(blockMOList) do
		local hexPoint = blockMO.hexPoint
		local index = tRoomResourceModel:getIndexByXY(hexPoint.x, hexPoint.y)
		local effectKey = self:getEffectKeyById(index)

		if canPlaceEffect and self:_checkBuildingAreaShow(isCheckBuildingArea, hexPoint, rangesHexPointList) then
			local isnotCan = self:_isCanNotConfirm(blockMO, tempBuildingMO)

			if not effectComp:isHasKey(effectKey) then
				if addParams == nil then
					addParams = {}
				end

				local posX, posY = HexMath.hexXYToPosXY(hexPoint.x, hexPoint.y, RoomBlockEnum.BlockSize)
				local var_4_0 = {}

				if isnotCan then
					var_4_0.res = RoomScenePreloader.ResEffectD04 or RoomScenePreloader.ResEffectD03
				end

				var_4_0.localPos = Vector3(posX, 0, posY)
				addParams[effectKey] = var_4_0
			end
		elseif effectComp:getEffectRes(effectKey) then
			if removeParams == nil then
				removeParams = {}
			end

			table.insert(removeParams, effectKey)
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

function RoomPlaceBuildingEffectComp:_getRangesHexPointList(tempBuildingMO)
	if tempBuildingMO and tempBuildingMO:isBuildingArea() and not tempBuildingMO:isAreaMainBuilding() then
		local areaMO = RoomMapBuildingAreaModel.instance:getAreaMOByBId(tempBuildingMO.buildingId)

		if areaMO then
			return areaMO:getRangesHexPointList()
		end
	end

	return nil
end

function RoomPlaceBuildingEffectComp:_checkBuildingAreaShow(isCheckBuildingArea, hexPoint, hexPointList)
	if isCheckBuildingArea and not RoomBuildingHelper.isInInitBlock(hexPoint) and (not hexPointList or not tabletool.indexOf(hexPointList, hexPoint)) and not RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y) then
		return false
	end

	return true
end

function RoomPlaceBuildingEffectComp:_isCanNotConfirm(blockMO, tempBuildingMO)
	local hexPoint = blockMO.hexPoint

	if RoomBuildingHelper.isInInitBlock(hexPoint) then
		return true
	end

	local buildingParam = RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y)

	if not tempBuildingMO then
		if buildingParam then
			return true
		end
	else
		if buildingParam and buildingParam.buildingUid ~= tempBuildingMO.uid then
			return true
		end

		if RoomTransportHelper.checkInLoadHexXY(hexPoint.x, hexPoint.y) then
			return true
		end

		return RoomBuildingHelper.checkBuildResId(tempBuildingMO.buildingId, blockMO:getResourceList(true)) == false
	end

	return false
end

return RoomPlaceBuildingEffectComp
