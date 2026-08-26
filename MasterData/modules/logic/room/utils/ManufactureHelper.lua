-- chunkname: @modules/logic/room/utils/ManufactureHelper.lua

module("modules.logic.room.utils.ManufactureHelper", package.seeall)

local ManufactureHelper = {}

ManufactureHelper.__EMPTY__TABLE = {}

function ManufactureHelper.findItemIdListByBUid(buildingUid)
	local manufactureMO = ManufactureModel.instance:getManufactureMOById(buildingUid)

	if not manufactureMO then
		return ManufactureHelper.__EMPTY__TABLE
	end

	local itemIdList = {}
	local slotMOList = manufactureMO:getAllUnlockedSlotMOList()

	for _, slotMO in ipairs(slotMOList) do
		local state = slotMO:getSlotState()

		if state == RoomManufactureEnum.SlotState.Running or state == RoomManufactureEnum.SlotState.Wait or state == RoomManufactureEnum.SlotState.Stop or state == RoomManufactureEnum.SlotState.Complete then
			local manufactureItemId = slotMO:getSlotManufactureItemId()
			local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

			if not tabletool.indexOf(itemIdList, itemId) then
				table.insert(itemIdList, itemId)
			end
		end
	end

	return itemIdList
end

function ManufactureHelper.findLuckyItemIdListByBUid(buildingUid)
	local isAll, luckyItemDict = ManufactureHelper.findLuckyItemParamByBUid(buildingUid)

	if not isAll and not luckyItemDict then
		return ManufactureHelper.__EMPTY__TABLE
	end

	local itemIdList = ManufactureHelper.findItemIdListByBUid(buildingUid)

	if isAll then
		return itemIdList
	end

	for i = #itemIdList, 1, -1 do
		local itemId = itemIdList[i]

		if not luckyItemDict or not luckyItemDict[itemId] then
			table.remove(itemIdList, 1)
		end
	end

	return itemIdList
end

function ManufactureHelper.findLuckyItemParamByBUid(buildingUid)
	local isAll = false
	local luckyItemDict
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local critterMOList = CritterHelper.getWorkCritterMOListByBuid(buildingUid)

	if not buildingMO or not critterMOList or #critterMOList < 1 then
		return isAll, luckyItemDict
	end

	local buildingId = buildingMO.buildingId
	local tCritterConfig = CritterConfig.instance
	local tManufactureCritterListModel = ManufactureCritterListModel.instance

	for i = 1, #critterMOList do
		local critterMO = critterMOList[i]
		local attrInfo = tManufactureCritterListModel:getPreviewAttrInfo(critterMO:getId(), buildingId, false)

		if attrInfo and attrInfo.skillTags and #attrInfo.skillTags > 0 then
			local skillTags = attrInfo.skillTags

			for si = 1, #skillTags do
				local cfg = tCritterConfig:getCritterTagCfg(skillTags[si])

				if cfg and cfg.luckyItemType == RoomManufactureEnum.LuckyItemType.All then
					isAll = true

					return true, luckyItemDict
				elseif cfg and cfg.luckyItemType == RoomManufactureEnum.LuckyItemType.ItemId and not string.nilorempty(cfg.luckyItemIds) then
					local itemIdList = string.splitToNumber(cfg.luckyItemIds)

					if itemIdList then
						for _, itemId in ipairs(itemIdList) do
							luckyItemDict = luckyItemDict or {}
							luckyItemDict[itemId] = true
						end
					end
				end
			end
		end
	end

	return isAll, luckyItemDict
end

return ManufactureHelper
