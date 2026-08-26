-- chunkname: @modules/logic/room/entity/comp/placeeff/RoomTransportPathLinkEffectComp.lua

module("modules.logic.room.entity.comp.placeeff.RoomTransportPathLinkEffectComp", package.seeall)

local RoomTransportPathLinkEffectComp = class("RoomTransportPathLinkEffectComp", RoomBaseBlockEffectComp)

function RoomTransportPathLinkEffectComp:ctor(entity)
	RoomTransportPathLinkEffectComp.super.ctor(self, entity)

	self.entity = entity
	self._effectPrefixKey = "transport_path_line"
	self._lineParamPools = {}
end

function RoomTransportPathLinkEffectComp:init(go)
	RoomTransportPathLinkEffectComp.super.init(self, go)

	self._tRoomResourceModel = RoomResourceModel.instance

	self:startWaitRunDelayTask()
end

function RoomTransportPathLinkEffectComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, self._refreshLineEffect, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self.startWaitRunDelayTask, self)
	RoomController.instance:registerCallback(RoomEvent.OnLateInitDone, self.startWaitRunDelayTask, self)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, self.startWaitRunDelayTask, self)
end

function RoomTransportPathLinkEffectComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, self._refreshLineEffect, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self.startWaitRunDelayTask, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnLateInitDone, self.startWaitRunDelayTask, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, self.startWaitRunDelayTask, self)
end

function RoomTransportPathLinkEffectComp:onRunDelayTask()
	self:_refreshLineEffect()
end

function RoomTransportPathLinkEffectComp:_refreshLineEffect()
	local indexDict = self:_getLineTypeIndexDict()
	local addParams, removeParams
	local effectComp = self.entity.effect
	local lastIndexDict = self._lastIndexDict

	self._lastIndexDict = indexDict

	for index, param in pairs(indexDict) do
		local oldParam = lastIndexDict and lastIndexDict[index]

		if param and not self:_checkParamsSame(param, oldParam) then
			local effectKey = self:getEffectKeyById(index)

			if addParams == nil then
				addParams = {}
			end

			local vec2 = HexMath.hexToPosition(param.hexPoint, RoomBlockEnum.BlockSize)

			addParams[effectKey] = {
				res = RoomResHelper.getTransportPathPath(param.lineType, param.styleId),
				localPos = Vector3(vec2.x, 0.111, vec2.y),
				localRotation = Vector3(0, param.rotate * 60, 0)
			}
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

			self:_pushLineParam(oldParam)
		end
	end

	if addParams then
		effectComp:addParams(addParams)
		effectComp:refreshEffect()
	end

	if removeParams then
		effectComp:removeParams(removeParams)
		effectComp:refreshEffect()
	end
end

function RoomTransportPathLinkEffectComp:_getResPath(transportPathMO, hexPoint)
	if transportPathMO and transportPathMO:checkHexPoint(hexPoint) then
		-- block empty
	end
end

function RoomTransportPathLinkEffectComp:_checkParamsSame(param, param2)
	if param == nil or param2 == nil then
		return false
	end

	if param.rotate ~= param2.rotate or param.hexPoint ~= param2.hexPoint or param.lineType ~= param2.lineType or param.styleId ~= param2.styleId then
		return false
	end

	return true
end

function RoomTransportPathLinkEffectComp:_getSelectPathMO()
	local tempMO = RoomMapTransportPathModel.instance:getTempTransportPathMO()

	if tempMO then
		return tempMO
	end

	local buildingType = RoomMapTransportPathModel.instance:getSelectBuildingType()

	if buildingType then
		local fromType, toType = RoomTransportHelper.getSiteFromToByType(buildingType)

		tempMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)
	end

	return tempMO
end

function RoomTransportPathLinkEffectComp:_getLineTypeIndexDict()
	local indexDict = {}
	local tempMO = self:_getSelectPathMO()
	local transportPathMOList = RoomMapTransportPathModel.instance:getList()
	local waterStyle
	local isOutSlot = false
	local slotHexDict

	if RoomController.instance:isObMode() then
		slotHexDict = {}
		isOutSlot = true
		waterStyle = RoomTransportPathEnum.StyleId.ObWater
	end

	for _, transportPathMO in ipairs(transportPathMOList) do
		local styleId = RoomTransportPathEnum.StyleId.NoLink

		if transportPathMO:isLinkFinish() then
			styleId = RoomTransportPathEnum.StyleId.EditLink

			if tempMO == transportPathMO then
				styleId = RoomTransportPathEnum.StyleId.Normal
			end
		end

		if isOutSlot then
			styleId = RoomTransportPathEnum.StyleId.ObLink

			self:_addSlotHexPointDict(slotHexDict, transportPathMO)
		end

		self:_addLineParamDict(indexDict, transportPathMO:getHexPointList(), styleId, waterStyle, isOutSlot)
	end

	if slotHexDict then
		for _, slot in pairs(slotHexDict) do
			self:_addHexPintLineParamDict(indexDict, (waterStyle and self:_isWaterBlock(slot.hexPoint) or nil) and waterStyle, slot.hexPoint, slot.prevHexPoint, slot.nextHexPoint)
		end
	end

	return indexDict
end

function RoomTransportPathLinkEffectComp:_addSlotHexPointDict(dict, transportPathMO)
	local hexPointList = transportPathMO:getHexPointList()

	self:_addLinkHexPointDict(dict, hexPointList[1], hexPointList[2])
	self:_addLinkHexPointDict(dict, hexPointList[#hexPointList], hexPointList[#hexPointList - 1])
end

function RoomTransportPathLinkEffectComp:_addLinkHexPointDict(dict, hexPoint, nextHexPoint)
	local index = self._tRoomResourceModel:getIndexByXY(hexPoint.x, hexPoint.y)

	if dict[index] then
		dict[index].nextHexPoint = nextHexPoint
	else
		dict[index] = {}
		dict[index].hexPoint = hexPoint
		dict[index].prevHexPoint = nextHexPoint
	end
end

function RoomTransportPathLinkEffectComp:_addLineParamDict(dict, hexPointList, styleId, waterStyle, isOutSlot)
	if hexPointList and #hexPointList > 0 then
		styleId = styleId or RoomTransportPathEnum.StyleId.Normal
		hexPointList = hexPointList or {}

		local startIdx = 1
		local endIdx = #hexPointList

		if isOutSlot == true then
			startIdx = startIdx + 1
			endIdx = endIdx - 1
		end

		for i = startIdx, endIdx do
			local hexPoint = hexPointList[i]
			local prevHexPoint = hexPointList[i - 1]
			local nextHexPoint = hexPointList[i + 1]

			if waterStyle and self:_isWaterBlock(hexPoint) then
				self:_addHexPintLineParamDict(dict, waterStyle, hexPoint, prevHexPoint, nextHexPoint)
			else
				self:_addHexPintLineParamDict(dict, styleId, hexPoint, prevHexPoint, nextHexPoint)
			end
		end
	end
end

function RoomTransportPathLinkEffectComp:_addHexPintLineParamDict(dict, styleId, hexPoint, prevHexPoint, nextHexPoint)
	local lineType, rotate = RoomTransportPathLinkHelper.getPtahLineType(hexPoint, prevHexPoint, nextHexPoint)

	if lineType and rotate then
		local index = self._tRoomResourceModel:getIndexByXY(hexPoint.x, hexPoint.y)

		index = index * 10

		if dict[index] then
			while dict[index] do
				index = index + 1
			end
		end

		local param = self:_popLineParam()

		param.lineType = lineType
		param.rotate = rotate or 0
		param.hexPoint = hexPoint
		param.styleId = styleId
		dict[index] = param
	end
end

function RoomTransportPathLinkEffectComp:_isWaterBlock(hexPoint)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO and blockMO:hasRiver() then
		return true
	end

	return false
end

function RoomTransportPathLinkEffectComp:_popLineParam()
	local param
	local count = #self._lineParamPools

	if count > 0 then
		param = self._lineParamPools[count]

		table.remove(self._lineParamPools, count)
	else
		param = {}
	end

	return param
end

function RoomTransportPathLinkEffectComp:_pushLineParam(lineParam)
	if lineParam then
		table.insert(self._lineParamPools, lineParam)
	end
end

return RoomTransportPathLinkEffectComp
