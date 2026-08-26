-- chunkname: @modules/logic/rouge/model/RougeFavoriteCollectionEnchantListModel.lua

module("modules.logic.rouge.model.RougeFavoriteCollectionEnchantListModel", package.seeall)

local RougeFavoriteCollectionEnchantListModel = class("RougeFavoriteCollectionEnchantListModel", ListScrollModel)

function RougeFavoriteCollectionEnchantListModel:initData(filterMo)
	local list = RougeCollectionListModel.instance:getEnchantList()
	local result = {}

	for i, v in ipairs(list) do
		if v ~= filterMo then
			table.insert(result, v)
		end
	end

	self:setList(result)
end

RougeFavoriteCollectionEnchantListModel.instance = RougeFavoriteCollectionEnchantListModel.New()

return RougeFavoriteCollectionEnchantListModel
