-- chunkname: @modules/logic/room/model/manufacture/ManufactureFormulaListModel.lua

module("modules.logic.room.model.manufacture.ManufactureFormulaListModel", package.seeall)

local ManufactureFormulaListModel = class("ManufactureFormulaListModel", ListScrollModel)
local NO_MAT_ITEM_TYPE = 1
local NO_MAT_ITEM_HEIGHT = 200
local NEED_MAT_ITEM_TYPE = 2
local NEED_MAT_ITEM_HEIGHT = 262

function ManufactureFormulaListModel.sortFormula(a, b)
	local aManufactureItemId = a.id
	local bManufactureItemId = b.id
	local aItemId = ManufactureConfig.instance:getItemId(aManufactureItemId)
	local bItemId = ManufactureConfig.instance:getItemId(bManufactureItemId)

	if aItemId ~= bItemId then
		return aItemId < bItemId
	end

	local aUnitCount = ManufactureConfig.instance:getUnitCount(aManufactureItemId)
	local bUnitCount = ManufactureConfig.instance:getUnitCount(bManufactureItemId)

	if aUnitCount ~= bUnitCount then
		return aUnitCount < bUnitCount
	end

	return aManufactureItemId < bManufactureItemId
end

function ManufactureFormulaListModel:setManufactureFormulaItemList(buildingUid)
	local list = {}

	self._isNoMat = true

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO then
		local buildingId = buildingMO.buildingId
		local buildingType = RoomConfig.instance:getBuildingType(buildingId)

		self._isNoMat = buildingType == RoomBuildingEnum.BuildingType.Collect

		local buildingLevel = buildingMO:getLevel()
		local allManufactureItemList = ManufactureConfig.instance:getAllManufactureItems(buildingId)

		for _, manufactureItemId in ipairs(allManufactureItemList) do
			local needLevel = ManufactureConfig.instance:getManufactureItemNeedLevel(buildingId, manufactureItemId)

			if needLevel <= buildingLevel then
				list[#list + 1] = {
					id = manufactureItemId,
					buildingUid = buildingUid
				}
			end
		end
	end

	table.sort(list, self.sortFormula)
	self:setList(list)
end

function ManufactureFormulaListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	if not list or #list <= 0 then
		return mixCellInfos
	end

	for i, mo in ipairs(list) do
		if self._isNoMat then
			if not NO_MAT_ITEM_TYPE then
				local mixType = NEED_MAT_ITEM_TYPE

				if self._isNoMat then
					if not NO_MAT_ITEM_HEIGHT then
						local cellHeight = NEED_MAT_ITEM_HEIGHT

						table.insert(mixCellInfos, SLFramework.UGUI.MixCellInfo.New(mixType, cellHeight, nil))
					end
				end
			end
		end
	end

	return mixCellInfos
end

ManufactureFormulaListModel.instance = ManufactureFormulaListModel.New()

return ManufactureFormulaListModel
