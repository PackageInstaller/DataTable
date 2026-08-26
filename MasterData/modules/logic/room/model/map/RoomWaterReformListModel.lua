-- chunkname: @modules/logic/room/model/map/RoomWaterReformListModel.lua

module("modules.logic.room.model.map.RoomWaterReformListModel", package.seeall)

local RoomWaterReformListModel = class("RoomWaterReformListModel", ListScrollModel)

function RoomWaterReformListModel:onInit()
	self:_clearData()
end

function RoomWaterReformListModel:reInit()
	self:_clearData()
end

function RoomWaterReformListModel:clear()
	self:_clearData()
	RoomWaterReformListModel.super.clear(self)
end

function RoomWaterReformListModel:_clearData()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			if view.setSelectList then
				view:setSelectList()
			end
		end
	end
end

function RoomWaterReformListModel:setShowBlockList()
	local curReformMode = RoomWaterReformModel.instance:getReformMode()
	local moList = {}

	if curReformMode == RoomEnum.ReformMode.Water then
		local typeList = RoomConfig.instance:getWaterReformTypeList()

		for _, waterType in ipairs(typeList) do
			local mo = {
				waterType = waterType
			}

			mo.blockId = RoomConfig.instance:getWaterReformTypeBlockId(waterType)
			moList[#moList + 1] = mo
		end
	elseif curReformMode == RoomEnum.ReformMode.Block then
		local lockColorList = {}
		local colorList = RoomConfig.instance:getBlockColorReformList()

		for _, blockColor in ipairs(colorList) do
			local mo = {
				blockColor = blockColor
			}

			mo.blockId = RoomConfig.instance:getBlockColorReformBlockId(blockColor)

			local isUnlock = RoomWaterReformModel.instance:isUnlockBlockColor(blockColor)

			if isUnlock then
				moList[#moList + 1] = mo
			else
				lockColorList[#lockColorList + 1] = mo
			end
		end

		for _, mo in ipairs(lockColorList) do
			moList[#moList + 1] = mo
		end
	end

	self:setList(moList)
end

function RoomWaterReformListModel:setSelectWaterType(waterType)
	local selectMO
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo.waterType and mo.waterType == waterType then
			selectMO = mo

			break
		end
	end

	for _, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomWaterReformListModel:setSelectBlockColor(blockColor)
	local selectMO
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo.blockColor and mo.blockColor == blockColor then
			selectMO = mo

			break
		end
	end

	for _, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomWaterReformListModel:getDefaultSelectWaterType()
	local hasSelect = RoomWaterReformModel.instance:hasSelectWaterArea()

	if not hasSelect then
		return
	end

	local result
	local selectWaterBlockMoList = RoomWaterReformModel.instance:getSelectWaterBlockMoList()

	for _, blockMo in ipairs(selectWaterBlockMoList) do
		local defineWaterType = blockMo:getDefineWaterType()

		if result and result ~= defineWaterType then
			result = nil

			break
		end

		result = defineWaterType
	end

	return result
end

function RoomWaterReformListModel:getDefaultSelectBlockColor()
	local hasSelect = RoomWaterReformModel.instance:hasSelectedBlock()

	if not hasSelect then
		return
	end

	local result
	local selectedBlocks = RoomWaterReformModel.instance:getSelectedBlocks()

	if selectedBlocks then
		for selectedBlockId, _ in pairs(selectedBlocks) do
			local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(selectedBlockId)

			if blockMO then
				local defineBlockType = blockMO:getDefineBlockType()

				if result and result ~= defineBlockType then
					result = nil

					break
				end

				result = defineBlockType
			end
		end
	end

	return result
end

RoomWaterReformListModel.instance = RoomWaterReformListModel.New()

return RoomWaterReformListModel
