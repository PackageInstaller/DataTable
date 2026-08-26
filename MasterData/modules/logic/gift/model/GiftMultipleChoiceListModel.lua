-- chunkname: @modules/logic/gift/model/GiftMultipleChoiceListModel.lua

module("modules.logic.gift.model.GiftMultipleChoiceListModel", package.seeall)

local GiftMultipleChoiceListModel = class("GiftMultipleChoiceListModel", ListScrollModel)

function GiftMultipleChoiceListModel:setPropList(Infos)
	self._moList = Infos and Infos or {}

	self:setList(self._moList)
end

function GiftMultipleChoiceListModel:getOptionalGiftIdList(giftId)
	local materialsIds = {}
	local ids = ItemModel.instance:getOptionalGiftMaterialSubTypeList(giftId)

	for _, id in pairs(ids) do
		table.insert(materialsIds, id)
	end

	return materialsIds
end

function GiftMultipleChoiceListModel:getOptionalGiftInfo(giftId)
	local materialsIds = self:getOptionalGiftIdList(giftId)
	local info = {}

	for _, id in pairs(materialsIds) do
		local material = {
			1,
			id,
			1
		}

		table.insert(info, material)
	end

	return info
end

GiftMultipleChoiceListModel.instance = GiftMultipleChoiceListModel.New()

return GiftMultipleChoiceListModel
