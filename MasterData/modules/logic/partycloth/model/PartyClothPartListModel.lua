-- chunkname: @modules/logic/partycloth/model/PartyClothPartListModel.lua

module("modules.logic.partycloth.model.PartyClothPartListModel", package.seeall)

local PartyClothPartListModel = class("PartyClothPartListModel", ListScrollModel)

function PartyClothPartListModel:initData(clothType, clothId)
	local clothIdMap = PartyClothModel.instance:getWearClothIdMap()
	local wearClothId = clothIdMap[clothType]
	local list = {}
	local clothMoList = PartyClothModel.instance:getClothMoList(clothType)

	for _, mo in ipairs(clothMoList) do
		local wearStatus = mo.clothId == wearClothId and 1 or 0

		list[#list + 1] = {
			config = mo.config,
			isWear = wearStatus
		}
	end

	table.sort(list, PartyClothHelper.SortClothFunc)
	self:setList(list)

	if clothId then
		self:selectClothItem(clothId, true)
	end
end

function PartyClothPartListModel:selectClothItem(clothId, select)
	local index

	for k, mo in ipairs(self._list) do
		if mo.config.clothId == clothId then
			index = k

			break
		end
	end

	if index then
		self:selectCell(index, select)
	end
end

PartyClothPartListModel.instance = PartyClothPartListModel.New()

return PartyClothPartListModel
