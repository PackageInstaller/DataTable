-- chunkname: @modules/logic/rouge2/map/model/listmodel/Rouge2_LossRelicsListModel.lua

module("modules.logic.rouge2.map.model.listmodel.Rouge2_LossRelicsListModel", package.seeall)

local Rouge2_LossRelicsListModel = class("Rouge2_LossRelicsListModel", Rouge2_LossItemListModelBase)

function Rouge2_LossRelicsListModel._sortDefault(aItem, bItem)
	local aSelect = Rouge2_LossRelicsListModel.instance:isSelect(aItem)
	local bSelect = Rouge2_LossRelicsListModel.instance:isSelect(bItem)

	if aSelect ~= bSelect then
		return aSelect
	end

	return Rouge2_LossItemListModelBase._sortDefault(aItem, bItem)
end

Rouge2_LossRelicsListModel.instance = Rouge2_LossRelicsListModel.New()

return Rouge2_LossRelicsListModel
