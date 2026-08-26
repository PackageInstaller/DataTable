-- chunkname: @modules/logic/backpack/model/BackpackCategoryListModel.lua

module("modules.logic.backpack.model.BackpackCategoryListModel", package.seeall)

local BackpackCategoryListModel = class("BackpackCategoryListModel", ListScrollModel)

function BackpackCategoryListModel:setCategoryList(infos)
	local moList = infos and infos or {}

	table.sort(moList, function(a, b)
		return a.id < b.id
	end)
	self:setList(moList)
end

BackpackCategoryListModel.instance = BackpackCategoryListModel.New()

return BackpackCategoryListModel
