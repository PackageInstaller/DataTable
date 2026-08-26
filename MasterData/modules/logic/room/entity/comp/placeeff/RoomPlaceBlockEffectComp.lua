-- chunkname: @modules/logic/room/entity/comp/placeeff/RoomPlaceBlockEffectComp.lua

module("modules.logic.room.entity.comp.placeeff.RoomPlaceBlockEffectComp", package.seeall)

local RoomPlaceBlockEffectComp = class("RoomPlaceBlockEffectComp", RoomBaseBlockEffectComp)

function RoomPlaceBlockEffectComp:ctor(entity)
	RoomPlaceBlockEffectComp.super.ctor(self, entity)

	self._hexPointList = {}

	tabletool.addValues(self._hexPointList, RoomMapHexPointModel.instance:getHexPointList())
end

function RoomPlaceBlockEffectComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.SelectBlock, self._refreshCanPlaceEffect, self)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, self._refreshCanPlaceEffect, self)
	RoomWaterReformController.instance:registerCallback(RoomEvent.WaterReformShowChanged, self._refreshCanPlaceEffect, self)
end

function RoomPlaceBlockEffectComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.SelectBlock, self._refreshCanPlaceEffect, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, self._refreshCanPlaceEffect, self)
	RoomWaterReformController.instance:unregisterCallback(RoomEvent.WaterReformShowChanged, self._refreshCanPlaceEffect, self)
end

function RoomPlaceBlockEffectComp:_refreshCanPlaceEffect()
	local canPlaceEffect = self:_isCanShowPlaceEffect()
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local addParams, removeParams
	local effectComp = self.entity.effect

	for index, hexPoint in ipairs(self._hexPointList) do
		local effectKey = self:getEffectKeyById(index)

		if canPlaceEffect and self:_checkByXY(hexPoint.x, hexPoint.y, tRoomMapBlockModel) then
			if not effectComp:isHasKey(effectKey) then
				if addParams == nil then
					addParams = {}
				end

				local vec2 = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

				addParams[effectKey] = {
					res = RoomScenePreloader.ResEffectD03,
					localPos = Vector3(vec2.x, -0.12, vec2.y)
				}
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

function RoomPlaceBlockEffectComp:_checkByBlockMO(blockMO)
	if RoomEnum.IsBlockNeedConnInit then
		if blockMO and blockMO:canPlace() then
			return true
		end
	elseif not blockMO or blockMO:canPlace() then
		return true
	end

	return false
end

function RoomPlaceBlockEffectComp:_checkByXY(x, y, tRoomMapBlockModel)
	local blockMO = tRoomMapBlockModel:getBlockMO(x, y)

	if blockMO and blockMO.blockState == RoomBlockEnum.BlockState.Map then
		return false
	end

	for i = 1, 6 do
		local tempHexPoint = HexPoint.directions[i]
		local neighborMO = tRoomMapBlockModel:getBlockMO(x + tempHexPoint.x, y + tempHexPoint.y)

		if neighborMO and neighborMO.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function RoomPlaceBlockEffectComp:_isCanShowPlaceEffect()
	if RoomBlockHelper.isCanPlaceBlock() then
		local selectInventoryBlockId = RoomInventoryBlockModel.instance:getSelectInventoryBlockId()

		if selectInventoryBlockId and selectInventoryBlockId > 0 then
			return true
		end
	end

	return false
end

function RoomPlaceBlockEffectComp:formatEffectKey(index)
	return index
end

return RoomPlaceBlockEffectComp
