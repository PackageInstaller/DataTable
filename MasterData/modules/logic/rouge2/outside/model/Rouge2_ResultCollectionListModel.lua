-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_ResultCollectionListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_ResultCollectionListModel", package.seeall)

local Rouge2_ResultCollectionListModel = class("Rouge2_ResultCollectionListModel", ListScrollModel)

function Rouge2_ResultCollectionListModel:initList(info)
	local tempList = {}

	if info and info.items then
		for _, item in ipairs(info.items) do
			local mo = {}

			mo.itemId = item.itemId
			mo.type = Rouge2_OutsideEnum.CollectionType.Collection

			table.insert(tempList, mo)
		end
	end

	self:setList(tempList)
end

Rouge2_ResultCollectionListModel.instance = Rouge2_ResultCollectionListModel.New()

return Rouge2_ResultCollectionListModel
