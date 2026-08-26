-- chunkname: @modules/logic/room/model/manufacture/ManufactureSlotMO.lua

module("modules.logic.room.model.manufacture.ManufactureSlotMO", package.seeall)

local ManufactureSlotMO = pureTable("ManufactureSlotMO")

function ManufactureSlotMO:init(slotInfo)
	self._id = slotInfo.slotId
	self._priority = slotInfo.priority
	self._manufactureItemId = slotInfo.productionId
	self._slotStatus = slotInfo.slotStatus
	self._inventoryCount = slotInfo.inventoryCount
	self._beginTime = slotInfo.beginTime
	self._finishTime = slotInfo.nextFinishTime
	self._pauseTime = slotInfo.pauseTime
end

function ManufactureSlotMO:getSlotId()
	return self._id
end

function ManufactureSlotMO:getSlotPriority()
	return self._priority
end

function ManufactureSlotMO:getFinishCount()
	local result = 0
	local state = self:getSlotState()

	if state == RoomManufactureEnum.SlotState.Complete then
		result = self._inventoryCount
	elseif state == RoomManufactureEnum.SlotState.Running or state == RoomManufactureEnum.SlotState.Wait or state == RoomManufactureEnum.SlotState.Stop then
		local manufactureItemId = self:getSlotManufactureItemId()

		result = ManufactureConfig.instance:getUnitCount(manufactureItemId)
	end

	return result
end

function ManufactureSlotMO:getSlotManufactureItemId()
	return self._manufactureItemId
end

function ManufactureSlotMO:getSlotState(getRealState)
	if not getRealState and self._priority == RoomManufactureEnum.FirstSlotPriority and self._slotStatus == RoomManufactureEnum.SlotState.Wait then
		return RoomManufactureEnum.SlotState.Stop
	end

	return self._slotStatus or RoomManufactureEnum.SlotState.Locked
end

function ManufactureSlotMO:getTotalNeedTime()
	local result = 0
	local state = self:getSlotState(true)

	if state == RoomManufactureEnum.SlotState.Running or state == RoomManufactureEnum.SlotState.Stop then
		result = self._finishTime - self._beginTime
	elseif state == RoomManufactureEnum.SlotState.Wait then
		local manufactureItemId = self:getSlotManufactureItemId()

		if manufactureItemId and manufactureItemId ~= 0 then
			result = ManufactureConfig.instance:getNeedTime(manufactureItemId)
		end
	end

	return math.max(0, result)
end

function ManufactureSlotMO:getElapsedTime()
	local result = 0
	local state = self:getSlotState()

	if state == RoomManufactureEnum.SlotState.Running then
		local now = ServerTime.now()

		result = now - self._beginTime
	elseif state == RoomManufactureEnum.SlotState.Stop then
		result = self._pauseTime - self._beginTime
	end

	return math.max(0, result)
end

function ManufactureSlotMO:getSlotProgress()
	local elapsedTime = self:getElapsedTime()
	local totalNeedTime = self:getTotalNeedTime()

	return Mathf.Clamp((totalNeedTime and totalNeedTime > 0 or nil) and elapsedTime / totalNeedTime, 0, 1)
end

function ManufactureSlotMO:getSlotRemainSecTime()
	local elapsedTime = self:getElapsedTime()
	local totalNeedTime = self:getTotalNeedTime()

	return Mathf.Clamp(totalNeedTime - elapsedTime, 0, totalNeedTime)
end

function ManufactureSlotMO:getSlotRemainStrTime(useEn)
	local needTimeSec = self:getSlotRemainSecTime()

	return (ManufactureController.instance:getFormatTime(needTimeSec, useEn))
end

function ManufactureSlotMO:getSlotAccelerateEff(accelerateItemId)
	local result = 0
	local state = self:getSlotState(true)

	if state ~= RoomManufactureEnum.SlotState.Running then
		return result
	end

	local itemCfg = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, accelerateItemId)

	if itemCfg then
		local manufactureItemId = self:getSlotManufactureItemId()
		local cfgTotalTime = ManufactureConfig.instance:getNeedTime(manufactureItemId)
		local cfgItemEff = tonumber(itemCfg.effect)
		local realTotalTime = self._finishTime - self._beginTime

		result = realTotalTime * (cfgItemEff / cfgTotalTime)
	end

	return result
end

return ManufactureSlotMO
